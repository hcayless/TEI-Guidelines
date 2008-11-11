package org.tei.tei;

import java.io.File;
import java.io.IOException;

import javax.xml.transform.TransformerException;
import javax.xml.transform.stream.StreamSource;

import net.sf.saxon.s9api.Processor;
import net.sf.saxon.s9api.QName;
import net.sf.saxon.s9api.SaxonApiException;
import net.sf.saxon.s9api.Serializer;
import net.sf.saxon.s9api.XdmAtomicValue;
import net.sf.saxon.s9api.XdmDestination;
import net.sf.saxon.s9api.XdmNode;
import net.sf.saxon.s9api.XsltCompiler;
import net.sf.saxon.s9api.XsltExecutable;
import net.sf.saxon.s9api.XsltTransformer;

import org.tei.docx.DocX;
import org.tei.exceptions.ConfigurationException;
import org.tei.utils.FileUtils;
import org.tei.utils.SaxonProcFactory;
import org.tei.utils.XMLUtils;

/**
 * Represents a TEI file
 * 
 * @author Arno Mittelbach
 *
 */
public class TEI {

	/**
	 * The TEI document
	 */
	private XdmNode tei;
	
	/**
	 * 
	 */
	private static TEIPropertiesProvider propertiesProvider;

	/**
	 * Constructs a new TEI object from a file
	 * 
	 * @param input The TEI input file
	 * @throws SaxonApiException 
	 */
	public TEI(File inputFile) throws SaxonApiException{
		this.tei = XMLUtils.readFileIntoSaxonDoc(inputFile);
	}
	
	/**
	 * Constructs a new TEI object from a DOM tree
	 * 
	 * @param doc
	 */
	public TEI(XdmNode doc){
		this.tei = doc;
	}
	
	/**
	 * Provide a properties provider 
	 * 
	 * @param provider
	 */
	public static void setPropertiesProvider(TEIPropertiesProvider provider){
		propertiesProvider = provider;
	}
	
	/**
	 * 
	 * @return The document
	 */
	public XdmNode getDocument(){
		return tei;
	}
	
	/**
	 * Stores the document to disk
	 * 
	 * @param file
	 * @throws IOException
	 */
	public void storeFile(File file) throws IOException {
		XMLUtils.storeDocument(tei, file);
	}
	
	/**
	 * Creates a compiled ODD file
	 * 
	 * @param properties
	 * @return
	 * @throws TransformerException
	 * @throws SaxonApiException
	 */
	public TEI generateODD(ODDGenerationProperties properties) throws TransformerException, SaxonApiException {
		// load stylesheets
		Processor proc = SaxonProcFactory.getProcessor();
		
		// prepare transformer
		XsltCompiler comp = proc.newXsltCompiler();
		
		// are we to use a custom error Listener
		if(null != properties.getErrorListener() )
			comp.setErrorListener(properties.getErrorListener());
		
		XsltExecutable odd2oddExec = comp.compile(new StreamSource(propertiesProvider.tei_pp_getStylesheetsDir() + File.separator + "odd2odd.xsl"));
		XsltTransformer odd2oddTransformer = odd2oddExec.load();
		
		odd2oddTransformer.setParameter(new QName("selectedSchema"), new XdmAtomicValue(properties.getSchemaName()));
		
		if(properties.isVerbose())
			odd2oddTransformer.setParameter(new QName("verbose"), new XdmAtomicValue("true"));
		if(properties.isStripped())
			odd2oddTransformer.setParameter(new QName("stripped"), new XdmAtomicValue("true"));
		
		odd2oddTransformer.setParameter(new QName("localsource"), new XdmAtomicValue(propertiesProvider.tei_pp_getP5Subset()));
		odd2oddTransformer.setParameter(new QName("TEIC"), new XdmAtomicValue("true") );
		odd2oddTransformer.setParameter(new QName("lang"), new XdmAtomicValue(properties.getLanguage()));
		odd2oddTransformer.setParameter(new QName("doclang"), new XdmAtomicValue(properties.getLanguage()));
		odd2oddTransformer.setParameter(new QName("useVersionFromTEI"), new XdmAtomicValue( properties.isUseVersionFromTEI() ? "true" : "false" ));
		
		if(null != properties.getMessageListener())
			odd2oddTransformer.setMessageListener(properties.getMessageListener());
		odd2oddTransformer.setInitialContextNode(tei);
		XdmDestination result = new XdmDestination();
		odd2oddTransformer.setDestination(result);
		odd2oddTransformer.transform();
		
		return new TEI((XdmNode) result.getXdmNode());
	}

	/**
	 * Creates a relaxing schema
	 * 
	 * @return
	 * @throws TransformerException
	 * @throws SaxonApiException
	 */
	public XdmNode generateRelax(RelaxGenerationProperties properties) throws TransformerException, SaxonApiException{
		// load stylesheets
		Processor proc = SaxonProcFactory.getProcessor();
		
		// prepare transformer
		XsltCompiler comp = proc.newXsltCompiler();
		if(null != properties.getErrorListener() )
			comp.setErrorListener(properties.getErrorListener());
		
		XsltExecutable odd2relaxExec = comp.compile(new StreamSource(propertiesProvider.tei_pp_getStylesheetsDir() + File.separator + "odd2relax.xsl"));
		XsltTransformer odd2relaxTransformer = odd2relaxExec.load();
		
		if(properties.isVerbose())
			odd2relaxTransformer.setParameter(new QName("verbose"), new XdmAtomicValue("true"));

		odd2relaxTransformer.setParameter(new QName("TEIC"), new XdmAtomicValue("true") );
		odd2relaxTransformer.setParameter(new QName("lang"), new XdmAtomicValue(properties.getLanguage()));
		odd2relaxTransformer.setParameter(new QName("doclang"), new XdmAtomicValue(properties.getLanguage()));
		odd2relaxTransformer.setParameter(new QName("parameterize"), new XdmAtomicValue(properties.isParameterizedDTD() ? "true" : "false"));
		odd2relaxTransformer.setParameter(new QName("patternPrefix"), new XdmAtomicValue(properties.getPatternPrefix()));
		
		if(null != properties.getMessageListener())
			odd2relaxTransformer.setMessageListener(properties.getMessageListener());
		odd2relaxTransformer.setInitialContextNode(tei);
		XdmDestination result = new XdmDestination();
		odd2relaxTransformer.setDestination(result);
		odd2relaxTransformer.transform();
		
		return (XdmNode) result.getXdmNode();
	}
	
	/**
	 * 
	 * @throws SaxonApiException
	 */
	public void generateDTD(DTDGenerationProperties properties) throws SaxonApiException{
		// load stylesheets
		Processor proc = SaxonProcFactory.getProcessor();
		
		// prepare transformer
		XsltCompiler comp = proc.newXsltCompiler();
		if(null != properties.getErrorListener() )
			comp.setErrorListener(properties.getErrorListener());
		
		XsltExecutable odd2dtdExec = comp.compile(new StreamSource(propertiesProvider.tei_pp_getStylesheetsDir() + File.separator + "odd2dtd.xsl"));
		XsltTransformer odd2dtdTransformer = odd2dtdExec.load();
		
		if(properties.isVerbose())
			odd2dtdTransformer.setParameter(new QName("verbose"), new XdmAtomicValue("true"));
		
		odd2dtdTransformer.setParameter(new QName("TEIC"), new XdmAtomicValue("true") );
		odd2dtdTransformer.setParameter(new QName("lang"), new XdmAtomicValue(properties.getLanguage()));
		odd2dtdTransformer.setParameter(new QName("doclang"), new XdmAtomicValue(properties.getLanguage()));
		odd2dtdTransformer.setParameter(new QName("parameterize"), new XdmAtomicValue(properties.isParameterizedDTD() ? "true" : "false"));
		
		if(null != properties.getMessageListener())
			odd2dtdTransformer.setMessageListener(properties.getMessageListener());
		odd2dtdTransformer.setInitialContextNode(tei);
		Serializer result = new Serializer();
		result.setOutputFile(properties.getOutputFile());
		odd2dtdTransformer.setDestination(result);
		odd2dtdTransformer.transform();
	}

	
	/**
	 * 
	 * @param doc
	 * @return
	 * @throws SaxonApiException
	 */
	public TEI generateDocumentation(DocumentationGenerationProperties properties) throws SaxonApiException{
		// load stylesheets
		Processor proc = SaxonProcFactory.getProcessor();
		
		// prepare transformer
		XsltCompiler comp = proc.newXsltCompiler();
		if(null != properties.getErrorListener() )
			comp.setErrorListener(properties.getErrorListener());
		
		XsltExecutable odd2teiDocExec = comp.compile(new StreamSource(propertiesProvider.tei_pp_getStylesheetsDir() + File.separator + "odd2lite.xsl"));
		XsltTransformer odd2teiDocTransformer = odd2teiDocExec.load();
		
		
		odd2teiDocTransformer.setParameter(new QName("TEIC"), new XdmAtomicValue("true") );
		odd2teiDocTransformer.setParameter(new QName("localsource"), new XdmAtomicValue(propertiesProvider.tei_pp_getP5Subset()));
		odd2teiDocTransformer.setParameter(new QName("lang"), new XdmAtomicValue(properties.getLanguage()));
		odd2teiDocTransformer.setParameter(new QName("doclang"), new XdmAtomicValue(properties.getLanguage()));
		
		if(null != properties.getMessageListener())
			odd2teiDocTransformer.setMessageListener(properties.getMessageListener());
		odd2teiDocTransformer.setInitialContextNode(tei);
		XdmDestination result = new XdmDestination();
		odd2teiDocTransformer.setDestination(result);
		odd2teiDocTransformer.transform();
		
		return new TEI((XdmNode) result.getXdmNode());
	}
	

	public void transformToDocX(DocXTransformationProperties properties) throws SaxonApiException, ConfigurationException, IOException {
		DocX docx = new DocX(properties.getOutputFile().getName(), properties);
		docx.mergeTEI(tei);
		File zipFile = docx.getDocXFile();
		zipFile.renameTo(properties.getOutputFile());
		docx.cleanUp();
	}	
	
	public void transformToHTML(HTMLTransformationProperties properties) throws SaxonApiException, IOException{
		// load stylesheets
		Processor proc = SaxonProcFactory.getProcessor();
		
		// prepare transformer
		XsltCompiler comp = proc.newXsltCompiler();
		if(null != properties.getErrorListener() )
			comp.setErrorListener(properties.getErrorListener());
	
		XsltExecutable odd2HTMLDocExec = comp.compile(new StreamSource(propertiesProvider.tei_pp_getStylesheetsDir() + File.separator + "odd2html.xsl"));
		XsltTransformer odd2HTMLDocTransformer = odd2HTMLDocExec.load();
		
		odd2HTMLDocTransformer.setParameter(new QName("STDOUT"), new XdmAtomicValue("true") );
		odd2HTMLDocTransformer.setParameter(new QName("splitLevel"), new XdmAtomicValue("-1"));
		odd2HTMLDocTransformer.setParameter(new QName("lang"), new XdmAtomicValue(properties.getLanguage()));
		odd2HTMLDocTransformer.setParameter(new QName("doclang"), new XdmAtomicValue(properties.getLanguage()));
		odd2HTMLDocTransformer.setParameter(new QName("documentationLanguage"), new XdmAtomicValue(properties.getLanguage()));
		
		if(null != properties.getCSSFile())
			odd2HTMLDocTransformer.setParameter(new QName("cssFile"), new XdmAtomicValue(properties.getCSSFile()));
		if(null != properties.getCSSSecondaryFile())
			odd2HTMLDocTransformer.setParameter(new QName("cssSecondaryFile"), new XdmAtomicValue(properties.getCSSSecondaryFile()));
		
		if(null != properties.getMessageListener())
			odd2HTMLDocTransformer.setMessageListener(properties.getMessageListener());
		odd2HTMLDocTransformer.setInitialContextNode(tei);
		Serializer result = new Serializer();
		result.setOutputFile( properties.getOutputFile() );
		odd2HTMLDocTransformer.setDestination(result);
		odd2HTMLDocTransformer.transform();
	}
	
	
}
