From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: disable ECC check for Raven to avoid error
 message annoyance
Date: Wed, 17 Jan 2018 14:11:33 +0000
Message-ID: <BN6PR12MB1652BC4DA2E56C4B5828D281F7E90@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1516172538-27374-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_BN6PR12MB1652BC4DA2E56C4B5828D281F7E90BN6PR12MB1652namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1516172538-27374-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--_004_BN6PR12MB1652BC4DA2E56C4B5828D281F7E90BN6PR12MB1652namp_
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652BC4DA2E56C4B5828D281F7E90BN6PR12MB1652namp_"

--_000_BN6PR12MB1652BC4DA2E56C4B5828D281F7E90BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The check should be moved up into late_init where the call to ecc_available=
 is and we should make it explicit since only vega10 supports it, that way =
we don't get any false messages from RV.  How about the attached patch?


Alex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Junwei Z=
hang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, January 17, 2018 2:02 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhang, Jerry
Subject: [PATCH] drm/amdgpu: disable ECC check for Raven to avoid error mes=
sage annoyance

It should be enabled until ECC is supported for Raven.

Change-Id: If847663d503c26d2a08274ca721b4ce1bc637111
Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index c12ee75..a333442 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -533,6 +533,10 @@ static int gmc_v9_0_ecc_available(struct amdgpu_device=
 *adev)

         DRM_DEBUG("ecc: gmc_v9_0_ecc_available()\n");

+       /* Temporally skip ECC for Raven to avoid error message annoyance *=
/
+       if (adev->asic_type =3D=3D CHIP_RAVEN)
+               return 0;
+
         lost_sheep =3D 0;
         for (i =3D 0; i < ARRAY_SIZE(ecc_umclocalcap_addrs); ++i) {
                 reg_addr =3D ecc_umclocalcap_addrs[i];
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652BC4DA2E56C4B5828D281F7E90BN6PR12MB1652namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">The check should be moved up into=
 late_init where the call to ecc_available is and we should make it explici=
t since only vega10 supports it, that way we don't get any false messages f=
rom RV.&nbsp; How about the attached patch?</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Junwei Zhang &lt;Jerry.Zhan=
g@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 17, 2018 2:02 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhang, Jerry<br>
<b>Subject:</b> [PATCH] drm/amdgpu: disable ECC check for Raven to avoid er=
ror message annoyance</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It should be enabled until ECC is supported for Ra=
ven.<br>
<br>
Change-Id: If847663d503c26d2a08274ca721b4ce1bc637111<br>
Signed-off-by: Junwei Zhang &lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 &#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 4 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index c12ee75..a333442 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -533,6 &#43;533,10 @@ static int gmc_v9_0_ecc_available(struct amdgpu_de=
vice *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;ecc: gmc_v=
9_0_ecc_available()\n&quot;);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Temporally skip ECC for Raven =
to avoid error message annoyance */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHI=
P_RAVEN)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lost_sheep =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY=
_SIZE(ecc_umclocalcap_addrs); &#43;&#43;i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reg_addr =3D ecc_umclocalcap_addrs[i];<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk459467" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652BC4DA2E56C4B5828D281F7E90BN6PR12MB1652namp_--

--_004_BN6PR12MB1652BC4DA2E56C4B5828D281F7E90BN6PR12MB1652namp_
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-only-check-for-ECC-on-Vega10.patch"
Content-Description: 0001-drm-amdgpu-only-check-for-ECC-on-Vega10.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-only-check-for-ECC-on-Vega10.patch"; size=1360;
	creation-date="Wed, 17 Jan 2018 14:11:15 GMT";
	modification-date="Wed, 17 Jan 2018 14:11:15 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2ZjhhYzM2NWQwZmFjZTI0ODc2YWExOGNmOWRmYTFjODkzMDY2NTU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMTcgSmFuIDIwMTggMDk6MDc6MjkgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBvbmx5IGNoZWNrIGZvciBFQ0Mgb24gVmVnYTEwCgpSViBkb2Vzbid0IHN1
cHBvcnQgaXQuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDE4
ICsrKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKaW5kZXggYjdl
M2E0ZGM5NTJjLi4zNmUzZDg2NGRmNzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5
XzAuYwpAQCAtNjI5LDE0ICs2MjksMTYgQEAgc3RhdGljIGludCBnbWNfdjlfMF9sYXRlX2luaXQo
dm9pZCAqaGFuZGxlKQogCWZvcihpID0gMDsgaSA8IEFNREdQVV9NQVhfVk1IVUJTOyArK2kpCiAJ
CUJVR19PTih2bV9pbnZfZW5nW2ldID4gMTYpOwogCi0JciA9IGdtY192OV8wX2VjY19hdmFpbGFi
bGUoYWRldik7Ci0JaWYgKHIgPT0gMSkgewotCQlEUk1fSU5GTygiRUNDIGlzIGFjdGl2ZS5cbiIp
OwotCX0gZWxzZSBpZiAociA9PSAwKSB7Ci0JCURSTV9JTkZPKCJFQ0MgaXMgbm90IHByZXNlbnQu
XG4iKTsKLQl9IGVsc2UgewotCQlEUk1fRVJST1IoImdtY192OV8wX2VjY19hdmFpbGFibGUoKSBm
YWlsZWQuIHI6ICVkXG4iLCByKTsKLQkJcmV0dXJuIHI7CisJaWYgKGFkZXYtPmFzaWNfdHlwZSA9
PSBDSElQX1ZFR0ExMCkgeworCQlyID0gZ21jX3Y5XzBfZWNjX2F2YWlsYWJsZShhZGV2KTsKKwkJ
aWYgKHIgPT0gMSkgeworCQkJRFJNX0lORk8oIkVDQyBpcyBhY3RpdmUuXG4iKTsKKwkJfSBlbHNl
IGlmIChyID09IDApIHsKKwkJCURSTV9JTkZPKCJFQ0MgaXMgbm90IHByZXNlbnQuXG4iKTsKKwkJ
fSBlbHNlIHsKKwkJCURSTV9FUlJPUigiZ21jX3Y5XzBfZWNjX2F2YWlsYWJsZSgpIGZhaWxlZC4g
cjogJWRcbiIsIHIpOworCQkJcmV0dXJuIHI7CisJCX0KIAl9CiAKIAlyZXR1cm4gYW1kZ3B1X2ly
cV9nZXQoYWRldiwgJmFkZXYtPmdtYy52bV9mYXVsdCwgMCk7Ci0tIAoyLjEzLjYKCg==

--_004_BN6PR12MB1652BC4DA2E56C4B5828D281F7E90BN6PR12MB1652namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_BN6PR12MB1652BC4DA2E56C4B5828D281F7E90BN6PR12MB1652namp_--
