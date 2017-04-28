From: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Move  kiq ring lock out of virt strucure
Date: Fri, 28 Apr 2017 21:26:33 +0000
Message-ID: <DM5PR12MB1179284CC4DD50F4D0DDF85DF4130@DM5PR12MB1179.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_DM5PR12MB1179284CC4DD50F4D0DDF85DF4130DM5PR12MB1179namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx list (amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org)" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: brahma_sw_dev <brahma_sw_dev-5C7GfCeVMHo@public.gmane.org>

--_004_DM5PR12MB1179284CC4DD50F4D0DDF85DF4130DM5PR12MB1179namp_
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1179284CC4DD50F4D0DDF85DF4130DM5PR12MB1179namp_"

--_000_DM5PR12MB1179284CC4DD50F4D0DDF85DF4130DM5PR12MB1179namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please have  a look.

Regards
Shaoyun.liu

--_000_DM5PR12MB1179284CC4DD50F4D0DDF85DF4130DM5PR12MB1179namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Please have&nbsp; a look.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shaoyun.liu<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM5PR12MB1179284CC4DD50F4D0DDF85DF4130DM5PR12MB1179namp_--

--_004_DM5PR12MB1179284CC4DD50F4D0DDF85DF4130DM5PR12MB1179namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Move-kiq-ring-lock-out-of-virt-structure.patch"
Content-Description: 0001-drm-amdgpu-Move-kiq-ring-lock-out-of-virt-structure.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Move-kiq-ring-lock-out-of-virt-structure.patch";
	size=3804; creation-date="Fri, 28 Apr 2017 21:25:54 GMT";
	modification-date="Fri, 28 Apr 2017 21:24:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjNTIwMTEwODA3NDU5YmRkM2ZhNGQ2Yzg2YjJmMmFiMjkxMDUxZWJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaGFveXVuIExpdSA8U2hhb3l1bi5MaXVAYW1kLmNvbT4KRGF0
ZTogRnJpLCAyOCBBcHIgMjAxNyAxNzoxODoyNiAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9h
bWRncHU6IE1vdmUga2lxIHJpbmcgbG9jayBvdXQgb2YgdmlydCBzdHJ1Y3R1cmUKClRoZSB1c2Fn
ZSBvZiBraXEgc2hvdWxkIG5vdCBkZXBlbmQgb24gdGhlIHZpcnR1YWxpemF0aW9uLgoKQ2hhbmdl
LUlkOiBJMzlhNDM5MzgzYjBjNDhkOGY0MTBjZDM2MjMyNWI4NDA0MzgyY2Q1MwpTaWduZWQtb2Zm
LWJ5OiBTaGFveXVuIExpdSA8U2hhb3l1bi5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgIHwgMSArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmlydC5jIHwgOSArKysrLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92aXJ0LmggfCAxIC0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OF8wLmMgICAgfCAyICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jICAg
IHwgMiArKwogNSBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAppbmRleCBlMzMwMDA5Li5kYmQwY2IyIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaApAQCAtOTA5LDYgKzkwOSw3IEBAIHN0cnVj
dCBhbWRncHVfbWVjIHsKIHN0cnVjdCBhbWRncHVfa2lxIHsKIAl1NjQJCQllb3BfZ3B1X2FkZHI7
CiAJc3RydWN0IGFtZGdwdV9ibwkqZW9wX29iajsKKwlzdHJ1Y3QgbXV0ZXgJCWxvY2tfcmluZzsK
IAlzdHJ1Y3QgYW1kZ3B1X3JpbmcJcmluZzsKIAlzdHJ1Y3QgYW1kZ3B1X2lycV9zcmMJaXJxOwog
fTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jCmluZGV4IDEzNjMyMzku
LjRkYTE1ZTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
aXJ0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYwpAQCAt
MTA4LDcgKzEwOCw2IEBAIHZvaWQgYW1kZ3B1X3ZpcnRfaW5pdF9zZXR0aW5nKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQogCWFkZXYtPmNnX2ZsYWdzID0gMDsKIAlhZGV2LT5wZ19mbGFncyA9
IDA7CiAKLQltdXRleF9pbml0KCZhZGV2LT52aXJ0LmxvY2tfa2lxKTsKIAltdXRleF9pbml0KCZh
ZGV2LT52aXJ0LmxvY2tfcmVzZXQpOwogfQogCkBAIC0xMjIsMTIgKzEyMSwxMiBAQCB1aW50MzJf
dCBhbWRncHVfdmlydF9raXFfcnJlZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMy
X3QgcmVnKQogCiAJQlVHX09OKCFyaW5nLT5mdW5jcy0+ZW1pdF9ycmVnKTsKIAotCW11dGV4X2xv
Y2soJmFkZXYtPnZpcnQubG9ja19raXEpOworCW11dGV4X2xvY2soJmtpcS0+bG9ja19yaW5nKTsK
IAlhbWRncHVfcmluZ19hbGxvYyhyaW5nLCAzMik7CiAJYW1kZ3B1X3JpbmdfZW1pdF9ycmVnKHJp
bmcsIHJlZyk7CiAJYW1kZ3B1X2ZlbmNlX2VtaXQocmluZywgJmYpOwogCWFtZGdwdV9yaW5nX2Nv
bW1pdChyaW5nKTsKLQltdXRleF91bmxvY2soJmFkZXYtPnZpcnQubG9ja19raXEpOworCW11dGV4
X3VubG9jaygma2lxLT5sb2NrX3JpbmcpOwogCiAJciA9IGZlbmNlX3dhaXQoZiwgZmFsc2UpOwog
CWlmIChyKQpAQCAtMTQ4LDEyICsxNDcsMTIgQEAgdm9pZCBhbWRncHVfdmlydF9raXFfd3JlZyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgcmVnLCB1aW50MzJfdCB2KQogCiAJ
QlVHX09OKCFyaW5nLT5mdW5jcy0+ZW1pdF93cmVnKTsKIAotCW11dGV4X2xvY2soJmFkZXYtPnZp
cnQubG9ja19raXEpOworCW11dGV4X2xvY2soJmtpcS0+bG9ja19yaW5nKTsKIAlhbWRncHVfcmlu
Z19hbGxvYyhyaW5nLCAzMik7CiAJYW1kZ3B1X3JpbmdfZW1pdF93cmVnKHJpbmcsIHJlZywgdik7
CiAJYW1kZ3B1X2ZlbmNlX2VtaXQocmluZywgJmYpOwogCWFtZGdwdV9yaW5nX2NvbW1pdChyaW5n
KTsKLQltdXRleF91bmxvY2soJmFkZXYtPnZpcnQubG9ja19raXEpOworCW11dGV4X3VubG9jaygm
a2lxLT5sb2NrX3JpbmcpOwogCiAJciA9IGZlbmNlX3dhaXQoZiwgZmFsc2UpOwogCWlmIChyKQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuaCBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmgKaW5kZXggYThlZDE2Mi4uNmYy
YjdkZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQu
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oCkBAIC01Miw3
ICs1Miw2IEBAIHN0cnVjdCBhbWRncHVfdmlydCB7CiAJdWludDY0X3QJCQljc2Ffdm1pZDBfYWRk
cjsKIAlib29sIGNoYWluZWRfaWJfc3VwcG9ydDsKIAl1aW50MzJfdAkJCXJlZ192YWxfb2ZmczsK
LQlzdHJ1Y3QgbXV0ZXgJCQlsb2NrX2tpcTsKIAlzdHJ1Y3QgbXV0ZXggICAgICAgICAgICAgICAg
ICAgIGxvY2tfcmVzZXQ7CiAJc3RydWN0IGFtZGdwdV9pcnFfc3JjCQlhY2tfaXJxOwogCXN0cnVj
dCBhbWRncHVfaXJxX3NyYwkJcmN2X2lycTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhf
MC5jCmluZGV4IGFjNjRlMDEuLmQ2NDk0NzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y4XzAuYwpAQCAtMTM4NSw2ICsxMzg1LDggQEAgc3RhdGljIGludCBnZnhfdjhfMF9raXFfaW5p
dF9yaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCXN0cnVjdCBhbWRncHVfa2lxICpr
aXEgPSAmYWRldi0+Z2Z4LmtpcTsKIAlpbnQgciA9IDA7CiAKKwltdXRleF9pbml0KCZraXEtPmxv
Y2tfcmluZyk7CisKIAlyID0gYW1kZ3B1X3diX2dldChhZGV2LCAmYWRldi0+dmlydC5yZWdfdmFs
X29mZnMpOwogCWlmIChyKQogCQlyZXR1cm4gcjsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfMC5jCmluZGV4IDA4ZGFhM2YuLjliNjhkMzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYwpAQCAtNjE1LDYgKzYxNSw4IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfa2lxX2lu
aXRfcmluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlzdHJ1Y3QgYW1kZ3B1X2tpcSAq
a2lxID0gJmFkZXYtPmdmeC5raXE7CiAJaW50IHIgPSAwOwogCisJbXV0ZXhfaW5pdCgma2lxLT5s
b2NrX3JpbmcpOworCiAJciA9IGFtZGdwdV93Yl9nZXQoYWRldiwgJmFkZXYtPnZpcnQucmVnX3Zh
bF9vZmZzKTsKIAlpZiAocikKIAkJcmV0dXJuIHI7Ci0tIAoxLjkuMQoK

--_004_DM5PR12MB1179284CC4DD50F4D0DDF85DF4130DM5PR12MB1179namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_DM5PR12MB1179284CC4DD50F4D0DDF85DF4130DM5PR12MB1179namp_--
