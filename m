From: "Zhang, Boyuan" <Boyuan.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: drm/amdgpu update uvd 7.0 enc test
Date: Tue, 15 Aug 2017 20:38:25 +0000
Message-ID: <BN6PR1201MB25154454199E5F9131A08076878D0@BN6PR1201MB2515.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_BN6PR1201MB25154454199E5F9131A08076878D0BN6PR1201MB2515_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-CA
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
Cc: "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>

--_004_BN6PR1201MB25154454199E5F9131A08076878D0BN6PR1201MB2515_
Content-Type: multipart/alternative;
	boundary="_000_BN6PR1201MB25154454199E5F9131A08076878D0BN6PR1201MB2515_"

--_000_BN6PR1201MB25154454199E5F9131A08076878D0BN6PR1201MB2515_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Update UVD 7.0 enc test according to firmware interface changes for session=
 info ib.


Please review.


Regards,

Boyuan


--_000_BN6PR1201MB25154454199E5F9131A08076878D0BN6PR1201MB2515_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p><span>Update UVD 7.0 enc test</span> according to firmware interface cha=
nges for session info ib.</p>
<p><br>
</p>
<p>Please review.</p>
<p><br>
</p>
<p>Regards,</p>
<p>Boyuan<br>
</p>
<p><br>
</p>
</div>
</body>
</html>

--_000_BN6PR1201MB25154454199E5F9131A08076878D0BN6PR1201MB2515_--

--_004_BN6PR1201MB25154454199E5F9131A08076878D0BN6PR1201MB2515_
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-update-uvd-enc-test-for-new-fw.patch"
Content-Description: 0001-drm-amdgpu-update-uvd-enc-test-for-new-fw.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-update-uvd-enc-test-for-new-fw.patch"; size=1512;
	creation-date="Tue, 15 Aug 2017 20:36:29 GMT";
	modification-date="Tue, 15 Aug 2017 20:36:29 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0MWEzMDg0MDU1YmIwNzBiMDU0MTMxNWNlZjVjZmE3MzU2NjI0YWZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCb3l1YW4gWmhhbmcgPGJveXVhbi56aGFuZ0BhbWQuY29tPgpE
YXRlOiBUdWUsIDE1IEF1ZyAyMDE3IDE2OjI5OjM3IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gZHJt
L2FtZGdwdTogdXBkYXRlIHV2ZCBlbmMgdGVzdCBmb3IgbmV3IGZ3CgpzZXNzaW9uIGluZm8gaW50
ZXJmYWNlIGNoYW5nZWQgZHVlIHRvIGZ3IGludGVyZmFjZSBjaGFuZ2VzLAp1cGRhdGUgdGVzdCBp
YiBhY2NvcmRpbmdseS4KClNpZ25lZC1vZmYtYnk6IEJveXVhbiBaaGFuZyA8Ym95dWFuLnpoYW5n
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y3XzAuYyB8IDQg
KystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjdfMC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y3XzAuYwppbmRleCAyM2E4NTc1Li40NjZhZmY5IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjdfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92N18wLmMKQEAgLTIyNSw4ICsyMjUsOCBAQCBz
dGF0aWMgaW50IHV2ZF92N18wX2VuY19nZXRfY3JlYXRlX21zZyhzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
KnJpbmcsIHVpbnQzMl90IGhhbmRsZQogCWliLT5sZW5ndGhfZHcgPSAwOwogCWliLT5wdHJbaWIt
Pmxlbmd0aF9kdysrXSA9IDB4MDAwMDAwMTg7CiAJaWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0g
MHgwMDAwMDAwMTsgLyogc2Vzc2lvbiBpbmZvICovCi0JaWItPnB0cltpYi0+bGVuZ3RoX2R3Kytd
ID0gaGFuZGxlOwogCWliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IDB4MDAwMDAwMDA7CisJaWIt
PnB0cltpYi0+bGVuZ3RoX2R3KytdID0gMHgwMDAxMDAwMDsKIAlpYi0+cHRyW2liLT5sZW5ndGhf
ZHcrK10gPSB1cHBlcl8zMl9iaXRzKGR1bW15KTsKIAlpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10g
PSBkdW1teTsKIApAQCAtMjg4LDggKzI4OCw4IEBAIGludCB1dmRfdjdfMF9lbmNfZ2V0X2Rlc3Ry
b3lfbXNnKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgdWludDMyX3QgaGFuZGxlLAogCWliLT5s
ZW5ndGhfZHcgPSAwOwogCWliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IDB4MDAwMDAwMTg7CiAJ
aWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0gMHgwMDAwMDAwMTsKLQlpYi0+cHRyW2liLT5sZW5n
dGhfZHcrK10gPSBoYW5kbGU7CiAJaWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0gMHgwMDAwMDAw
MDsKKwlpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSAweDAwMDEwMDAwOwogCWliLT5wdHJbaWIt
Pmxlbmd0aF9kdysrXSA9IHVwcGVyXzMyX2JpdHMoZHVtbXkpOwogCWliLT5wdHJbaWItPmxlbmd0
aF9kdysrXSA9IGR1bW15OwogCi0tIAoyLjcuNAoK

--_004_BN6PR1201MB25154454199E5F9131A08076878D0BN6PR1201MB2515_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_BN6PR1201MB25154454199E5F9131A08076878D0BN6PR1201MB2515_--
