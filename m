From: "Lvzhihong (ReJohn)" <lvzhihong1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: x11vnc display output problem while the physical monitor display is
 normal.
Date: Thu, 18 Jan 2018 10:38:31 +0000
Message-ID: <E7DD0E9246072C4A9CA8F1C79F816696018CFE1C@dggemi505-mbx.china.huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0749637572=="
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

--===============0749637572==
Content-Language: zh-CN
Content-Type: multipart/related;
	boundary="_004_E7DD0E9246072C4A9CA8F1C79F816696018CFE1Cdggemi505mbxchi_";
	type="multipart/alternative"

--_004_E7DD0E9246072C4A9CA8F1C79F816696018CFE1Cdggemi505mbxchi_
Content-Type: multipart/alternative;
	boundary="_000_E7DD0E9246072C4A9CA8F1C79F816696018CFE1Cdggemi505mbxchi_"

--_000_E7DD0E9246072C4A9CA8F1C79F816696018CFE1Cdggemi505mbxchi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
I use x11vnc for remote control, the environment is an arm server with AMDG=
PU which enabled by open source driver.
we start x server by : startx , and start x11vnc by : export DISPLAY=3D:0 &=
 x11vnc.

         From the beginning, the x11vnc output and the physical monitor out=
put is the same and normal.  But after we run some GPU test(android ASOP), =
the x11vnc output turned to blurred, but the physical monitor output still =
normal. I try to shoot the screen by 'scrot' run in command line. The scree=
nshoot look the same with x11vnc output.

         I could not stable reproduce the problem now. And there are not an=
y error infomations in dmesg or Xorg.0.log. The problem appear twice now, m=
aybe because of the long time running of x11vnc. I am not sure.
         Here is the screenshoot (x11vnc output and screenshoot of scrot), =
the physical monitor output always narmal. CAN ANYONE HELP ?
         [cid:image001.jpg-hWxZiifDZ5AIrCiIgBIlDjRmByFHzeGd@public.gmane.org]



--_000_E7DD0E9246072C4A9CA8F1C79F816696018CFE1Cdggemi505mbxchi_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
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
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">I =
use x11vnc for remote control, the environment is an arm server with AMDGPU=
 which enabled by open source driver.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">we=
 start x server by : startx , and start x11vnc by : export DISPLAY=3D:0 &am=
p; x11vnc.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US"><o=
:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; From the beginning, the x11vnc output and the physical mo=
nitor output is the same and normal. &nbsp;But after we run some GPU test(a=
ndroid ASOP), the x11vnc output turned to blurred, but the physical monitor=
 output
 still normal. I try to shoot the screen by &#8216;scrot&#8217; run in comm=
and line. The screenshoot look the same with x11vnc output.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; I could not stable reproduce the problem now. And there a=
re not any error infomations in dmesg or Xorg.0.log. The problem appear twi=
ce now, maybe because of the long time running of x11vnc. I am not sure.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; Here is the screenshoot (x11vnc output and screenshoot of=
 scrot), the physical monitor output always narmal. CAN ANYONE HELP ?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; <img width=3D"519" height=3D"389" id=3D"_x56fe__x7247__x0=
020_1" src=3D"cid:image001.jpg-hWxZiifDZ5AIrCiIgBIlDjRmByFHzeGd@public.gmane.org"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_E7DD0E9246072C4A9CA8F1C79F816696018CFE1Cdggemi505mbxchi_--

--_004_E7DD0E9246072C4A9CA8F1C79F816696018CFE1Cdggemi505mbxchi_
Content-Type: image/jpeg; name="image001.jpg"
Content-Description: image001.jpg
Content-Disposition: inline; filename="image001.jpg"; size=8857;
	creation-date="Thu, 18 Jan 2018 10:38:31 GMT";
	modification-date="Thu, 18 Jan 2018 10:38:31 GMT"
Content-ID: <image001.jpg-hWxZiifDZ5AIrCiIgBIlDjRmByFHzeGd@public.gmane.org>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwkHBgoJCAkLCwoMDxkQDw4ODx4WFxIZJCAmJSMg
IyIoLTkwKCo2KyIjMkQyNjs9QEBAJjBGS0U+Sjk/QD3/2wBDAQsLCw8NDx0QEB09KSMpPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT3/wAARCAGFAgcDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDxmiii
gApVClSSxB7DFJVi0tJ7rd5Ebvt67TjFAm0ldkRSMLw7E46be/50zFaP9k33/PvN/wB9D/Gj+yb7
/n3m/wC+h/jTsyPaw/mX3mdiitIaTfgj/R5v++h/jWfIrJK6uCGBIIPrRaxUZxlsxtFFFIoVV3nG
QOO5xTniKZ+ZDzj5WzSR43jJUD1YZFTfJ/z0i/74P+FAFeipfKj/AOe6f98n/Cjyo/8Anuv/AHyf
8KAIqKV1CthWDD1ApKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooo
oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAOm+HP
/I9ad/21/wDRT0UfDn/ketO/7a/+inoqkJnM0VOWUAn9wfYA1CzbjnAHsKkE7iVZswh374Y5P9/f
x/3zVap7U2w3faWnH93ygP1zQhSV0XNsP/Ppb/8AkanRR2zSASW9ui92Cztj8M1XJ07Hyve59wv+
NJmw/v3f5L/jVXMXF92akdvp6NuAgb2a2nI/9CrDuNv2mXaAF3nAAIGM+h5FaEeopEgSO91JEXoq
vgD9azZW3yu25m3MTufqfr70SaCjGSbu38xtFFFSdAqI0jbUUsfQDNSfZZ/+eEv/AHwaiBIOQcGl
3t/eP50ASfZZ/wDnhL/3waPss/8Azwl/74NR72/vH86N7f3j+dAA6PG211ZT6EYpKCSepzRQAUUU
UAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQ
AUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQB03w5/5HrTv+2v8A6Keij4c/8j1p
3/bX/wBFPRVITOZoooqRhUkKRPnzZTHjphc5qOrmnfasv9ljmc8bvLj3Y+vBoQpOyuR+Ta/8/Lf9
+v8A69J5Vv8A8/Df9+//AK9aTf2qQcW95n3g/wDrUwHWwMfZ7n/wH/8ArVVjJz7Nff8A8ApIIY23
LcHPvFmq7nLsc5564xmtlU11gCIZefWID+lZEwcTSCUESbjuBHfvSY6crvf+vuGUUUUjUKKKKACi
iigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKK
KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA6b4c/8AI9ad/wBt
f/RT0UfDn/ketO/7a/8Aop6KpCZzNFFFSMKtWTEbwHiUn/nocVVqWCSZN3kyFM9cPtzQiZaon8t+
96vv89KIZSP+P2P/AL+//Xpv2i9/5+X/AO/v/wBejz73/n5f/v7/APXqiHfyLKDaoDSQMR/EZ2Gf
1rNl/wBa/T7x6HI/OrPn3v8Az8v/AN/f/r1VcsXYscsTyc5yaTHBNMSiiikaBRRRQAUUUUAFFFFA
BRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAF
FFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAHTfDn/ketO/7a/8Aop6KPhz/
AMj1p3/bX/0U9FUhM5miiipGFWrG1gut/wBovYrXbjHmKzbv++Qaq1f0vUWsPN2yvHvA+7j/AApr
fUifNy+7v/XqSvpdkEJXWrVmA4HlyDP/AI7Vf7BH/wA/9p+b/wDxNXpNclkjZHvJ2VhgghcEf981
U+1Qf3j/AN+0/wDiaehlH2i3f9fchn2CP/oIWn5v/wDE1UddrsoYMAcZHQ1pLNAQD5yj2KL/APE1
nSkGVyDkZODSZpBu+o2iiikaBRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRR
QAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFA
BRRRQAUUUUAFFFFAHTfDn/ketO/7a/8Aop6KPhz/AMj1p3/bX/0U9FUhM5miiipGWY1sSi+bJchs
chY1Iz/31U0cFjIT5U4GOv2kFPy25/WqFWbK3E+/ME82Mf6pgMfXINMh6K9yw1lblSBc2QPrvk/+
JqH7Cn/P7a/m3/xNTvp2UOyxvA2OCZARn/vmq/8AZl5/z7SflTsSpJ9fyF+wp/z+2v5t/wDE1VZd
rldwbBxkdDVpNJvXbC27598D+dVXRo5GRxhlOCPekyotPrcSiiikWFFFFABRRRQAUUUUAFFFFABR
RRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFF
FABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAdN8Of8AketO/wC2v/op6KPhz/yPWnf9
tf8A0U9FUhM5miiipGFS24DNgmJfeTOP0qKr2mXNzbmQ2zMuQN22JX/n0pomd7aER2gn/j3P0zUo
hUj/AF1l/wCPf4VZm1u8CMjXL5YdoIx+o6VR/tK8/wCfiT/vqnoQud/1/wAAsw2LXEmyF7R3xnC7
v8Kz5kMczowAZWIOOlaEOsbVUTRyykdSJ2XNZ8riSV3AIDMSATnH40OwQ5ru42iiipNQooooAKKK
KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoooo
AKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDpvhz/wAj1p3/AG1/
9FPRR8Of+R607/tr/wCinoqkJnNyStK25goOMfKoX+VNooqRlhILdkUtdqrEcrsY4pJEEQH2e4Mm
fvbVIxUFXtNtXuTJsjlfb/zzlVP50ybPuUtjf3T+VGxv7p/Kth9OmRCxhucAZP8ApKE/lVbZ/wBM
b3/vv/61FhOVtChsb+6fypK0Nh/543v/AH3/APWqhJ/rG4Ycnhuv40NDjK4lFFFIoKKKKACiiigA
ooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACi
iigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA6b4c/8AI9ad/wBtf/RT
0UfDn/ketO/7a/8Aop6KpCZzNFFFSMKfEiPnfKI/qCc/lTKuW7XDg/YIZQwHzlMtn/CgTdtyAxRf
8/C/98mjyov+e6/98mpp5r6BgJzKjEZAYYqL7bcf89Wpi1exZjnt441Ux2jkfxMj5P5GqUhDSMVA
AJOAvT8Kk+23H/PVqhYlmJJyTyTQ2KMbMKKKKRYUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUA
FFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAU
UUUAFFFFABRRRQAUUUUAFFFFABRRRQB03w5/5HrTv+2v/op6KPhz/wAj1p3/AG1/9FPRVITOblle
Zt0jFjjGTTaKKkYVNbwJOTvmEePVWOfyFQ1o6Sm4y/6JdXHT/USbNv14NNK7JnLlVyAWce3LXKr6
5jfj9KX7Lbf8/wDF/wB+3/wrWeNBGxk0nUwgHzbrk4x/3zVXOmf9Au6/8CR/8TVctv6Ziqjff8Cn
9ltv+f8Ai/79v/hVVwFdgrBgDww71rKdLZsf2dcL/vXYH/stZc23zn8tdqbjtG7OB9e9Jo0hJt63
/D9BlFFFSaBRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABR
RRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFF
FAHTfDn/AJHrTv8Atr/6Keij4c/8j1p3/bX/ANFPRVITOZorSvNMlVGmzYoqLysVwrZ/DcTms2k0
0KMlJXQVZs2gXf58Cy9MZlKY/Ko7byjIfOxtx3JH8ga0IpLOAMY7x4SR0iiMm767tuPwzQgld6Ij
klsvLbZZRhscH7QTj8KpeYn/ADxX8zRNcSXDBpW3EDAOKjobFGNkX4NVniVY1kEaKOBjOKpSuZJX
cnJYkk+tNoovcaik7oKKKKRQUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUU
AFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQA
UUUUAFFFFABRRRQB03w5/wCR607/ALa/+inoo+HP/I9ad/21/wDRT0VSEzmaKKKkYVbsBES/mlh0
xiDzP6jFVKs2V7dWZc2l3JblvvbHK7vyoAuGO1PRpf8AwCH/AMVUOyD+9J/4DD/4qhte1VgQ2pXh
B/6bN/jUUd5eTSgG7uMnv5h/qaaImn0JdkH96T/wGH/xVUZMeY2OmTjjH6VsR2146Bv7T257NcAE
fhurJmBWeQM29gxBbOc++ackTTd3uMoooqTUKKKKACiiigAooooAKKKKACiiigAooooAKKKKACii
igAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKK
ACiiigAooooAKKKKACiiigAooooA6b4c/wDI9ad/21/9FPRR8Of+R607/tr/AOinoqkJnNyBA37t
iw9SuKbRRUjCpbdVLHfs/wCBf/rFRVc0+S9TzPsTlc43cgfzprcmTsiNii5/dQHHo7f40zzk/wCf
eP8ANv8AGtN7vWY0Z2nYKoyfnSq39uaj/wA/T/pTaRCcntb7/wDgFXzk/wCfeP8ANv8AGoicknAH
sO1X/wC3NR/5+n/IVRd2kkZ3OWY5J9TSdi436/mJRRRSKCiiigAooooAKKKKACiiigAooooAKKKK
ACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA
KKKKACiiigAooooAKKKKACiiigAooooAKKKKAOm+HP8AyPWnf9tf/RT0UfDn/ketO/7a/wDop6Kp
CZzNFFFSMK0dJNpmX7ZLbx9Nvmwu+fptPFZ1aWkPs87HnZIGPL2fru/pVR3IqJuLSNDOkf8AP1p/
/gJN/jS50j/n60//AMA5v8aqmTUCCCzYP+zHUY+1n1/75jrTmXb+vvOb2TW8n9//AAC9nR/+frT/
APwDm/xrAuNn2mXyypTedpUEAjPGAeRWkBee/wD3zHWXLnzn3fe3HNRN36GtKNm9b/16IbRRRUG4
UUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABR
RRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQB03w5/wCR
607/ALa/+inoo+HP/I9ad/21/wDRT0VSEzmaKKKkYVZs5RGHB+z/ADDH75C35cGq1T2sQk3ZheTH
91wuP0poT2FFrER/x+QD8H/+JpPs8f8Az9Q/k/8A8TVj7Kv/AD5y/wDf9f8ACgWq/wDPnL/3/X/C
nYlyXf8AIiWOMADz7U+5V/8ACqz43tggjPUdKv8A2VP+fOX/AL/r/hVCQbZGGCuCeCc4pMIu4lFF
FIsKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA6b4c/
8j1p3/bX/wBFPRR8Of8AketO/wC2v/op6KpCZzNFFFSMKs2c3k7z5NvLnH+u7fTkVWq/pV1HbGTz
IZJN2MbFQ4/76U047kz2H/a9wIFnp4OOv+TTPtDf88bH8l/xrR/taD/n0uP+/cX/AMRS/wBrW/8A
z53H/fuL/wCIrSy7mF3/AC/iZv2hv+eNj+S/41RkOZGOFGSeF6fhXQDVrf8A587j/v3D/wDEVg3D
iS4kcAqGYkAgZHPtxUy9TSm31VhlFFFQahRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUA
FFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAU
UUUAFFFFABRRRQAUUUUAFFFFAHTfDn/ketO/7a/+inoo+HP/ACPWnf8AbX/0U9FUhM5miiipGFAJ
HQkUVp6NE8hl2POuAP8AVTJH+e4jNNK7sTKXKrmbub+8fzqSCbypVd0Eqjqjk4P5Guj+yy/8977/
AMDYf/iqPss3/Pe+/wDA2H/4qr9mzH2y/pmP/aUH/QNtv++pP/iqoSMHkZgoUEkhR0HtXUC0m/57
33/gdD/8VXNXIK3UoJYkOeWYE9e5HBpSTW5dOSb0/MjoooqDUKKKKACiiigAooooAKKKKACiiigA
ooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACi
iigAooooAKKKKACiiigAooooAKKKKACiiigAooooA6b4c/8AI9ad/wBtf/RT0UfDn/ketO/7a/8A
op6KpCZzNFFFSMKkixzkJ/wI4qOrNm23ePMnTI/5ZDOfryKaFLYTCekP/fRownpD/wB9GkmtwGHk
rKRjneoH8jUfkS/3GoFp3JcJ6Q/99GoG+8enXtUsaTxNuVOfdQf51E5JcluueeMUMaEooopDCiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAOm+HP/I9ad/2
1/8ART0UfDn/AJHrTv8Atr/6KeiqQmczRRRUjCnJG8mdiM2OuBmm1Zs5PL3/ALyVM/3H2/1FNCbs
iEwTKCTE4A6kqaSNVZwHfYvdsZxV2S4lPCzTMp67p/8A69R739/+/op2RKkxnkW//P1/5DNQMAGI
U5APB9atb5Pf/v8ACqr8u2fX1zSY4iUUUUigooooAKKKKACiiigAooooAKKKKACiiigAooooAKKK
KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoooo
AKKKKACiiigAooooAKKKKACiiigDpvhz/wAj1p3/AG1/9FPRR8Of+R607/tr/wCinoqkJnM0U/yv
+mifnTWG04yD7ipC4lKFLfdBP0FJT43Vc7t//AWxQNieW/8Acb8qfDB5koWRjEp6uVJA/Kl81P8A
pt/33/8AWo82P/pt/wB9/wD1qehN2WP7Pt/+f9P+/T/4VSdQkjKG3AHAOMZqXzY/+m3/AH3/APWq
EnJJ5/Gm7dAin1YUUUVJQUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFF
FFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUU
UAFFFFABRRRQB03w5/5HrTv+2v8A6Keij4c/8j1p3/bX/wBFPRVITOZoooqRhVqyVW37lQ9PvIzf
yqrVqxKAvveRen3GA/mRVR3In8JZZIlUtsh4/wCmMlQedD/ct/8Avhv8amkEbggT3ABHQspB/wDH
qr/ZY/8Ano3/AI5/8VVu/RGUbdWO86H+5b/98N/jVRyC7EYxnt0q0tnGxwJG/EoP/Zqquu12Xrg4
qJX6mkLdGJRRRUmgUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABR
RRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFF
FABRRRQB03w5/wCR607/ALa/+inoo+HP/I9ad/21/wDRT0VSEzmaKVm3HIUL7CkqRhUkKK+dzIMf
3mxUdOj387KaE9iZoY1UndEcdg5z/Kotyf8APP8A8eod5Bwx60yhsSXcngkjWTJCLx1cbh+WKhcg
yMRjBPYYFJRRcaVncKKKKQwooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA
KKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAo
oooAKKKKACiiigDpvhz/AMj1p3/bX/0U9FHw5/5HrTv+2v8A6KeiqQmczRRRUjCprbZ82+RE/wB6
Pdmoantgp3blY/SPd/WnHcmexPmH/n5g/wDAf/61GYf+fmD/AMB//rUFYyPuSD/tgP8AGkVFU5Hm
H62wP9a11/r/AIcx07/19xIiw8H7Va/RoD/hVCTHmvggjJwVGAavZH90/wDgIv8AjVCT/WN9T2x+
napnsVT3f9fohKKKKzNgooAyccfjTtn+0v50BcbRTtn+0v50bP8AaX86LCuNooIweoP0ooGFFFFA
BRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAF
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
PM8G7CNGADlSvX8aKKKfJHsLnkf/2Q==

--_004_E7DD0E9246072C4A9CA8F1C79F816696018CFE1Cdggemi505mbxchi_--

--===============0749637572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0749637572==--
