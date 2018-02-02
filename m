From: "Lvzhihong (ReJohn)" <lvzhihong1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: GPU VM fault in Ubuntu17.10(mesa 17.2.8,kernel 4.15)
Date: Fri, 2 Feb 2018 03:21:24 +0000
Message-ID: <E7DD0E9246072C4A9CA8F1C79F816696018DEE1B@dggemi505-mbx.china.huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1324184676=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: zh-CN
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: sunnanyong <sunnanyong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

--===============1324184676==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_E7DD0E9246072C4A9CA8F1C79F816696018DEE1Bdggemi505mbxchi_"

--_000_E7DD0E9246072C4A9CA8F1C79F816696018DEE1Bdggemi505mbxchi_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KICAgICAgIFdlIGhhdmUgZ3B1IFZNIEZhdWx0IHByb2JsZW0gc29tZXRpbWVzIHdp
dGggbmV3ZXN0IFY0LjE1IGtlcm5lbCBkcml2ZXIgYW5kIG1lc2EgVjE3LjIuOA0KTXkgZ3B1IGlz
IFJhZGVvbiBQcm8gV1g3MTAwDQoNClRoZXJlIGlzIGEgbG90IG9mIGtlcm5lbCBsb2cgcHJpbnRl
ZCBsaWtlIHRoaXM6DQpKYW4gMzEgMTM6MzU6NDQgdWJ1bnR1IGtlcm5lbDogWzEyMDc0OS45OTAx
ODVdIGFtZGdwdSAwMDBkOjMxOjAwLjA6IEdQVSBmYXVsdCBkZXRlY3RlZDogMTQ2IDB4MDYwOGQy
MGMNCkphbiAzMSAxMzozNTo0NCB1YnVudHUga2VybmVsOiBbMTIwNzQ5Ljk5MDE5Ml0gYW1kZ3B1
IDAwMGQ6MzE6MDAuMDogICBWTV9DT05URVhUMV9QUk9URUNUSU9OX0ZBVUxUX0FERFIgICAweDAw
MUFFMkMxDQpKYW4gMzEgMTM6MzU6NDQgdWJ1bnR1IGtlcm5lbDogWzEyMDc0OS45OTAxOTVdIGFt
ZGdwdSAwMDBkOjMxOjAwLjA6ICAgVk1fQ09OVEVYVDFfUFJPVEVDVElPTl9GQVVMVF9TVEFUVVMg
MHgwODBEMjAwQw0KSmFuIDMxIDEzOjM1OjQ0IHVidW50dSBrZXJuZWw6IFsxMjA3NDkuOTkwMTk5
XSBhbWRncHUgMDAwZDozMTowMC4wOiBWTSBmYXVsdCAoMHgwYywgdm1pZCA0KSBhdCBwYWdlIDE3
NjE5ODUsIHJlYWQgZnJvbSAnQ0JDNycgKDB4NDM0MjQzMzcpICgyMTApDQpKYW4gMzEgMTM6MzU6
NDQgdWJ1bnR1IGtlcm5lbDogWzEyMDc0OS45OTAyMDZdIGFtZGdwdSAwMDBkOjMxOjAwLjA6IEdQ
VSBmYXVsdCBkZXRlY3RlZDogMTQ2IDB4MDYwOGUyMGMNCkphbiAzMSAxMzozNTo0NCB1YnVudHUg
a2VybmVsOiBbMTIwNzQ5Ljk5MDIwOF0gYW1kZ3B1IDAwMGQ6MzE6MDAuMDogICBWTV9DT05URVhU
MV9QUk9URUNUSU9OX0ZBVUxUX0FERFIgICAweDAwMUFFMkMxDQpKYW4gMzEgMTM6MzU6NDQgdWJ1
bnR1IGtlcm5lbDogWzEyMDc0OS45OTAyMTBdIGFtZGdwdSAwMDBkOjMxOjAwLjA6ICAgVk1fQ09O
VEVYVDFfUFJPVEVDVElPTl9GQVVMVF9TVEFUVVMgMHgwOTA2MjAxNA0KSmFuIDMxIDEzOjM1OjQ0
IHVidW50dSBrZXJuZWw6IFsxMjA3NDkuOTkwMjE0XSBhbWRncHUgMDAwZDozMTowMC4wOiBWTSBm
YXVsdCAoMHgxNCwgdm1pZCA0KSBhdCBwYWdlIDE3NjE5ODUsIHdyaXRlIGZyb20gJ0NCQzAnICgw
eDQzNDI0MzMwKSAoOTgpDQpKYW4gMzEgMTM6MzU6NDQgdWJ1bnR1IGtlcm5lbDogWzEyMDc0OS45
OTAyMjBdIGFtZGdwdSAwMDBkOjMxOjAwLjA6IEdQVSBmYXVsdCBkZXRlY3RlZDogMTQ2IDB4MDYw
OGEyMGMNCkphbiAzMSAxMzozNTo0NCB1YnVudHUga2VybmVsOiBbMTIwNzQ5Ljk5MDIyM10gYW1k
Z3B1IDAwMGQ6MzE6MDAuMDogICBWTV9DT05URVhUMV9QUk9URUNUSU9OX0ZBVUxUX0FERFIgICAw
eDAwMUFFMkIxDQpKYW4gMzEgMTM6MzU6NDQgdWJ1bnR1IGtlcm5lbDogWzEyMDc0OS45OTAyMjVd
IGFtZGdwdSAwMDBkOjMxOjAwLjA6ICAgVk1fQ09OVEVYVDFfUFJPVEVDVElPTl9GQVVMVF9TVEFU
VVMgMHgwODBBMjAwQw0KSmFuIDMxIDEzOjM1OjQ0IHVidW50dSBrZXJuZWw6IFsxMjA3NDkuOTkw
MjI4XSBhbWRncHUgMDAwZDozMTowMC4wOiBWTSBmYXVsdCAoMHgwYywgdm1pZCA0KSBhdCBwYWdl
IDE3NjE5NjksIHJlYWQgZnJvbSAnQ0JDNCcgKDB4NDM0MjQzMzQpICgxNjIpDQpKYW4gMzEgMTM6
MzU6NDQgdWJ1bnR1IGtlcm5lbDogWzEyMDc0OS45OTAyMzVdIGFtZGdwdSAwMDBkOjMxOjAwLjA6
IEdQVSBmYXVsdCBkZXRlY3RlZDogMTQ2IDB4MDYwODkyMGMNCkphbiAzMSAxMzozNTo0NCB1YnVu
dHUga2VybmVsOiBbMTIwNzQ5Ljk5MDIzOF0gYW1kZ3B1IDAwMGQ6MzE6MDAuMDogICBWTV9DT05U
RVhUMV9QUk9URUNUSU9OX0ZBVUxUX0FERFIgICAweDAwMUFFMkIwDQpKYW4gMzEgMTM6MzU6NDQg
dWJ1bnR1IGtlcm5lbDogWzEyMDc0OS45OTAyNDBdIGFtZGdwdSAwMDBkOjMxOjAwLjA6ICAgVk1f
Q09OVEVYVDFfUFJPVEVDVElPTl9GQVVMVF9TVEFUVVMgMHgwODBBMjAwQw0KSmFuIDMxIDEzOjM1
OjQ0IHVidW50dSBrZXJuZWw6IFsxMjA3NDkuOTkwMjQzXSBhbWRncHUgMDAwZDozMTowMC4wOiBW
TSBmYXVsdCAoMHgwYywgdm1pZCA0KSBhdCBwYWdlIDE3NjE5NjgsIHJlYWQgZnJvbSAnQ0JDNCcg
KDB4NDM0MjQzMzQpICgxNjIpDQpKYW4gMzEgMTM6MzU6NDQgdWJ1bnR1IGtlcm5lbDogWzEyMDc0
OS45OTAyNTBdIGFtZGdwdSAwMDBkOjMxOjAwLjA6IEdQVSBmYXVsdCBkZXRlY3RlZDogMTQ2IDB4
MDYwODYyMGMNCkphbiAzMSAxMzozNTo0NCB1YnVudHUga2VybmVsOiBbMTIwNzQ5Ljk5MDI1Ml0g
YW1kZ3B1IDAwMGQ6MzE6MDAuMDogICBWTV9DT05URVhUMV9QUk9URUNUSU9OX0ZBVUxUX0FERFIg
ICAweDAwMUFFMkJBDQpKYW4gMzEgMTM6MzU6NDQgdWJ1bnR1IGtlcm5lbDogWzEyMDc0OS45OTAy
NTRdIGFtZGdwdSAwMDBkOjMxOjAwLjA6ICAgVk1fQ09OVEVYVDFfUFJPVEVDVElPTl9GQVVMVF9T
VEFUVVMgMHgwODBBMjAwQw0KSmFuIDMxIDEzOjM1OjQ0IHVidW50dSBrZXJuZWw6IFsxMjA3NDku
OTkwMjU3XSBhbWRncHUgMDAwZDozMTowMC4wOiBWTSBmYXVsdCAoMHgwYywgdm1pZCA0KSBhdCBw
YWdlIDE3NjE5NzgsIHJlYWQgZnJvbSAnQ0JDNCcgKDB4NDM0MjQzMzQpICgxNjIpDQpKYW4gMzEg
MTM6MzU6NDQgdWJ1bnR1IGtlcm5lbDogWzEyMDc0OS45OTAyNjRdIGFtZGdwdSAwMDBkOjMxOjAw
LjA6IEdQVSBmYXVsdCBkZXRlY3RlZDogMTQ2IDB4MDYwODUyMGMNCkphbiAzMSAxMzozNTo0NCB1
YnVudHUga2VybmVsOiBbMTIwNzQ5Ljk5MDI2Nl0gYW1kZ3B1IDAwMGQ6MzE6MDAuMDogICBWTV9D
T05URVhUMV9QUk9URUNUSU9OX0ZBVUxUX0FERFIgICAweDAwMUFFMkMxDQpKYW4gMzEgMTM6MzU6
NDQgdWJ1bnR1IGtlcm5lbDogWzEyMDc0OS45OTAyNjldIGFtZGdwdSAwMDBkOjMxOjAwLjA6ICAg
Vk1fQ09OVEVYVDFfUFJPVEVDVElPTl9GQVVMVF9TVEFUVVMgMHgwODA1MjAwQw0KDQpBbmQgSSBz
ZWUgdGhlIEdQVSBoYXMgaHVuZ6OsdGhlIGdwdSBsb2FkIGtlZXAgYXQgMTAwJSAsIHRoZSBYIHNl
cnZlciBjYW4gbm90IHJlc3RhcnQgYW55bW9yZS4NCg0KDQo=

--_000_E7DD0E9246072C4A9CA8F1C79F816696018DEE1Bdggemi505mbxchi_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Hi all,=
</span><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; We have gpu VM Fault problem sometimes with n=
ewest V4.15 kernel driver and mesa V17.2.8<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">My gpu =
is Radeon Pro WX7100<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">There i=
s a lot of kernel log printed like this:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990185] amdgpu 000d:31:00.0: GPU fault dete=
cted: 146 0x0608d20c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990192] amdgpu 000d:31:00.0: &nbsp;&nbsp;VM=
_CONTEXT1_PROTECTION_FAULT_ADDR&nbsp;&nbsp; 0x001AE2C1<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990195] amdgpu 000d:31:00.0:&nbsp;&nbsp; VM=
_CONTEXT1_PROTECTION_FAULT_STATUS 0x080D200C<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990199] amdgpu 000d:31:00.0: VM fault (0x0c=
, vmid 4) at page 1761985, read from 'CBC7' (0x43424337) (210)<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990206] amdgpu 000d:31:00.0: GPU fault dete=
cted: 146 0x0608e20c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990208] amdgpu 000d:31:00.0:&nbsp;&nbsp; VM=
_CONTEXT1_PROTECTION_FAULT_ADDR&nbsp;&nbsp; 0x001AE2C1<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990210] amdgpu 000d:31:00.0:&nbsp;&nbsp; VM=
_CONTEXT1_PROTECTION_FAULT_STATUS 0x09062014<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990214] amdgpu 000d:31:00.0: VM fault (0x14=
, vmid 4) at page 1761985, write from 'CBC0' (0x43424330) (98)<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990220] amdgpu 000d:31:00.0: GPU fault dete=
cted: 146 0x0608a20c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990223] amdgpu 000d:31:00.0:&nbsp;&nbsp; VM=
_CONTEXT1_PROTECTION_FAULT_ADDR&nbsp;&nbsp; 0x001AE2B1<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990225] amdgpu 000d:31:00.0:&nbsp;&nbsp; VM=
_CONTEXT1_PROTECTION_FAULT_STATUS 0x080A200C<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990228] amdgpu 000d:31:00.0: VM fault (0x0c=
, vmid 4) at page 1761969, read from 'CBC4' (0x43424334) (162)<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990235] amdgpu 000d:31:00.0: GPU fault dete=
cted: 146 0x0608920c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990238] amdgpu 000d:31:00.0:&nbsp;&nbsp; VM=
_CONTEXT1_PROTECTION_FAULT_ADDR&nbsp;&nbsp; 0x001AE2B0<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990240] amdgpu 000d:31:00.0:&nbsp;&nbsp; VM=
_CONTEXT1_PROTECTION_FAULT_STATUS 0x080A200C<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990243] amdgpu 000d:31:00.0: VM fault (0x0c=
, vmid 4) at page 1761968, read from 'CBC4' (0x43424334) (162)<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990250] amdgpu 000d:31:00.0: GPU fault dete=
cted: 146 0x0608620c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990252] amdgpu 000d:31:00.0:&nbsp;&nbsp; VM=
_CONTEXT1_PROTECTION_FAULT_ADDR&nbsp;&nbsp; 0x001AE2BA<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990254] amdgpu 000d:31:00.0:&nbsp;&nbsp; VM=
_CONTEXT1_PROTECTION_FAULT_STATUS 0x080A200C<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990257] amdgpu 000d:31:00.0: VM fault (0x0c=
, vmid 4) at page 1761978, read from 'CBC4' (0x43424334) (162)<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990264] amdgpu 000d:31:00.0: GPU fault dete=
cted: 146 0x0608520c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990266] amdgpu 000d:31:00.0:&nbsp;&nbsp; VM=
_CONTEXT1_PROTECTION_FAULT_ADDR&nbsp;&nbsp; 0x001AE2C1<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Jan 31 =
13:35:44 ubuntu kernel: [120749.990269] amdgpu 000d:31:00.0:&nbsp;&nbsp; VM=
_CONTEXT1_PROTECTION_FAULT_STATUS 0x0805200C<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">And I s=
ee the GPU has hung</span><span style=3D"font-family:=CB=CE=CC=E5;color:#1F=
497D">=A3=AC</span><span lang=3D"EN-US" style=3D"color:#1F497D">the gpu loa=
d keep at 100% , the X server can not restart anymore.<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_E7DD0E9246072C4A9CA8F1C79F816696018DEE1Bdggemi505mbxchi_--

--===============1324184676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1324184676==--
