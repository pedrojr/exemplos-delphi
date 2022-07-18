unit XmlBuilderTests;

interface

uses
  TestFramework;

type
  TestIXmlBuilder = class(TTestCase)
  private
    function XmlSimples(ComFormatacao: Boolean): string;
    function XmlCompleto(ComFormatacao: Boolean): string;
  published
    procedure XmlSimplesSemFormatacaoTest;
    procedure XmlSimplesComFormatacaoTest;
    procedure XmlCompletoSemFormatacao;
    procedure XmlCompletoComFormatacao;
    procedure XmlComAlteracaoEmPartes;
  end;

implementation

uses
  SysUtils, Classes, XmlBuilder;

{ TestIXmlBuilder }

procedure TestIXmlBuilder.XmlSimplesSemFormatacaoTest;
const
  XmlExpected = '<?xml version="1.0"?><eTag xmlns="http://www.test.com.br/schema"><n2 id="1"><n3.1><i1>2</i1><i2>123456</i2></n3.1>'+
                '<n3.2><i1>3</i1><i2>654321</i2></n3.2><n3.3></n3.3></n2></eTag>'#$D#$A;
var
  XmlActual: string;
begin
  XmlActual := XmlSimples(False);
  CheckEquals(XmlExpected, XmlActual);
end;

procedure TestIXmlBuilder.XmlSimplesComFormatacaoTest;
const
  XmlExpected = '<?xml version="1.0"?>'#$D#$A'<eTag xmlns="http://www.test.com.br/schema">'#$D#$A'  <n2 id="1">'#$D#$A'    <n3.1>'#$D#$A+
                '      <i1>2</i1>'#$D#$A'      <i2>123456</i2>'#$D#$A'    </n3.1>'#$D#$A'    <n3.2>'#$D#$A'      <i1>3</i1>'#$D#$A+
                '      <i2>654321</i2>'#$D#$A'    </n3.2>'#$D#$A'    <n3.3>'#$D#$A'    </n3.3>'#$D#$A'  </n2>'#$D#$A'</eTag>'#$D#$A;
var
  XmlActual: string;
begin
  XmlActual := XmlSimples(True);
  CheckEquals(XmlExpected, XmlActual);
end;

function TestIXmlBuilder.XmlSimples(ComFormatacao: Boolean): string;
begin
  Result := NewXmlBuilder()
              .Element('eTag').Attribute('xmlns', 'http://www.test.com.br/schema')
                .Element('n2').Attribute('id', '1')
                  .Element('n3.1')
                    .Element('i1', '2').Up
                    .Element('i2', '123456').Up
                  .Up
                  .Element('n3.2')
                    .Element('i1', '3').Up
                    .Element('i2', '654321').Up
                  .Up
                  .Element('n3.3').Up
                .Up
              .Up.ToStr(ComFormatacao);
end;

procedure TestIXmlBuilder.XmlCompletoSemFormatacao;
const
  XmlExpected = '<?xml version="1.0"?><eTag xmlns="http://www.test.com.br/schema"><n2 Id="1"><n3.1><i1>2</i1><i2>123456</i2></n3.1>'+
                '<n3.2><i1>2</i1><i2>654321</i2></n3.2><n3.3><n4 Id="001"><n5 Id="002"><n6><n7.1><i1>3</i1><i2>5</i2><i3>1.0</i3></n7.1>'+
                '<n7.2><i1>2</i1><i2>123</i2></n7.2><n7.3><n8><n9.1><i1>001</i1><i2>2015-01</i2><i3>2016-12</i3></n9.1><n9.2><i1>Test</i1>'+
                '<i2>212405</i2><i3><a>1</a><b>2</b><c>S</c><d><i1>1-23</i1><i2>2022</i2><i3>321</i3></d></i3></n9.2></n8></n7.3></n6></n5>'+
                '</n4></n3.3></n2></eTag>'#$D#$A;
var
  XmlActual: string;
begin
  XmlActual := XmlCompleto(False);
  CheckEquals(XmlExpected, XmlActual);
end;

procedure TestIXmlBuilder.XmlCompletoComFormatacao;
const
  XmlExpected = '<?xml version="1.0"?>'#$D#$A'<eTag xmlns="http://www.test.com.br/schema">'#$D#$A'  <n2 Id="1">'#$D#$A'    <n3.1>'#$D#$A'      <i1>2</i1>'#$D#$A+
                '      <i2>123456</i2>'#$D#$A'    </n3.1>'#$D#$A'    <n3.2>'#$D#$A'      <i1>2</i1>'#$D#$A'      <i2>654321</i2>'#$D#$A'    </n3.2>'#$D#$A+
                '    <n3.3>'#$D#$A'      <n4 Id="001">'#$D#$A'        <n5 Id="002">'#$D#$A'          <n6>'#$D#$A'            <n7.1>'#$D#$A+
                '              <i1>3</i1>'#$D#$A'              <i2>5</i2>'#$D#$A'              <i3>1.0</i3>'#$D#$A'            </n7.1>'#$D#$A'            <n7.2>'#$D#$A+
                '              <i1>2</i1>'#$D#$A'              <i2>123</i2>'#$D#$A'            </n7.2>'#$D#$A'            <n7.3>'#$D#$A'              <n8>'#$D#$A+
                '                <n9.1>'#$D#$A'                  <i1>001</i1>'#$D#$A'                  <i2>2015-01</i2>'#$D#$A'                  <i3>2016-12</i3>'#$D#$A+
                '                </n9.1>'#$D#$A'                <n9.2>'#$D#$A'                  <i1>Test</i1>'#$D#$A'                  <i2>212405</i2>'#$D#$A+
                '                  <i3>'#$D#$A'                    <a>1</a>'#$D#$A'                    <b>2</b>'#$D#$A'                    <c>S</c>'#$D#$A+
                '                    <d>'#$D#$A'                      <i1>1-23</i1>'#$D#$A'                      <i2>2022</i2>'#$D#$A+
                '                      <i3>321</i3>'#$D#$A'                    </d>'#$D#$A'                  </i3>'#$D#$A'                </n9.2>'#$D#$A+
                '              </n8>'#$D#$A'            </n7.3>'#$D#$A'          </n6>'#$D#$A'        </n5>'#$D#$A'      </n4>'#$D#$A'    </n3.3>'#$D#$A+
                '  </n2>'#$D#$A'</eTag>'#$D#$A;
var
  XmlActual: string;
begin
  XmlActual := XmlCompleto(True);
  CheckEquals(XmlExpected, XmlActual);
end;

function TestIXmlBuilder.XmlCompleto(ComFormatacao: Boolean): string;
begin
  Result := NewXmlBuilder()
              .Element('eTag').Attribute('xmlns', 'http://www.test.com.br/schema')
                .Element('n2').Attribute('Id', '1')
                  .Element('n3.1')
                    .Element('i1', '2').Up
                    .Element('i2', '123456').Up
                  .Up
                  .Element('n3.2')
                    .Element('i1', '2').Up
                    .Element('i2', '654321').Up
                  .Up
                  .Element('n3.3')
                    .Element('n4').Attribute('Id', '001')
                      .Element('n5').Attribute('Id', '002')
                        .Element('n6')
                          .Element('n7.1')
                            .Element('i1', '3').Up
                            .Element('i2', '5').Up
                            .Element('i3', '1.0').Up
                          .Up
                          .Element('n7.2')
                            .Element('i1', '2').Up
                            .Element('i2', '123').Up
                          .Up
                          .Element('n7.3')
                            .Element('n8')
                              .Element('n9.1')
                                .Element('i1', '001').Up
                                .Element('i2', '2015-01').Up
                                .Element('i3', '2016-12').Up
                              .Up
                              .Element('n9.2')
                                .Element('i1', 'Test').Up
                                .Element('i2', '212405').Up
                                .Element('i3')
                                  .Element('a', '1').Up
                                  .Element('b', '2').Up
                                  .Element('c', 'S').Up
                                  .Element('d')
                                    .Element('i1', '1-23').Up
                                    .Element('i2', '2022').Up
                                    .Element('i3', '321').Up
                                  .Up.First.ToStr(ComFormatacao)
end;

procedure TestIXmlBuilder.XmlComAlteracaoEmPartes;
const
  XmlExpected = '<?xml version="1.0"?><N1 abc="123" xyz="321"><N2><N2a><abc>123</abc><xyz>321</xyz></N2a>'+
                '<N2b><abc>123</abc><xyz>321</xyz></N2b></N2><N3></N3></N1>'#$D#$A;
var
  Xmlb: IXmlBuilder;
  XmlActual: string;
begin
  Xmlb := NewXmlBuilder()
              .Element('N1')
                .Attribute('abc', '123')
                .Attribute('xyz', '321');

  Xmlb.Element('N2')
        .Element('N2a')
          .Element('abc', '123').Up
          .Element('xyz', '321').Up
        .Up
        .Element('N2b')
          .Element('abc', '123').Up
          .Element('xyz', '321').Up
        .Up
      .Up;

  XmlActual := Xmlb.Element('N3').First.ToStr;

  CheckEquals(XmlExpected, XmlActual);
end;

initialization
  RegisterTest(TestIXmlBuilder.Suite);

end.

