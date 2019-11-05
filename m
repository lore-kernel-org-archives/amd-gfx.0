From: "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/swSMU: fix smu workload bit map error
Date: Tue, 5 Nov 2019 14:36:40 +0000
Message-ID: <ADFBF901-E147-4148-AF0E-B51D217C34A3@amd.com>
References: <20191105102302.21037-1-kevin1.wang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0526005268=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191105102302.21037-1-kevin1.wang-5C7GfCeVMHo@public.gmane.org>
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
To: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0526005268==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_ADFBF901E1474148AF0EB51D217C34A3amdcom_"

--_000_ADFBF901E1474148AF0EB51D217C34A3amdcom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

UmV2aWV3ZWQtYnk6IEtlbm5ldGggRmVuZyA8a2VubmV0aC5mZW5nQGFtZC5jb208bWFpbHRvOmtl
bm5ldGguZmVuZ0BhbWQuY29tPj4NCg0KDQrU2iAyMDE5xOoxMdTCNcjVo6zPws7nNjoyM6OsV2Fu
ZywgS2V2aW4oWWFuZykgPEtldmluMS5XYW5nQGFtZC5jb208bWFpbHRvOktldmluMS5XYW5nQGFt
ZC5jb20+PiDQtLXAo7oNCg0KZml4IHdvcmtsb2FkIGJpdCAoV09SS0xPQURfUFBMSUJfQ09NUFVU
RV9CSVQpIG1hcCBlcnJvcg0Kb24gdmVnYTIwIGFuZCBuYXZpIGFzaWMuDQoNCmZpeCBjb21taXQ6
DQpkcm0vYW1kL3Bvd2VycGxheTogYWRkIGZ1bmN0aW9uIGdldF93b3JrbG9hZF90eXBlX21hcCBm
b3Igc3dzbXUNCg0KU2lnbmVkLW9mZi1ieTogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1kLmNv
bTxtYWlsdG86a2V2aW4xLndhbmdAYW1kLmNvbT4+DQotLS0NCmRyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L25hdmkxMF9wcHQuYyB8IDIgKy0NCmRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L3ZlZ2EyMF9wcHQuYyB8IDIgKy0NCjIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvbmF2aTEwX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEw
X3BwdC5jDQppbmRleCA3NjlmOTQ1MWQ5MDQuLjM1NGY3MDk3OGY4MiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jDQpAQCAtMjA3LDcgKzIwNyw3IEBAIHN0
YXRpYyBzdHJ1Y3Qgc211XzExXzBfY21uMmFpc2NfbWFwcGluZyBuYXZpMTBfd29ya2xvYWRfbWFw
W1BQX1NNQ19QT1dFUl9QUk9GSUxFDQpXT1JLTE9BRF9NQVAoUFBfU01DX1BPV0VSX1BST0ZJTEVf
UE9XRVJTQVZJTkcsIFdPUktMT0FEX1BQTElCX1BPV0VSX1NBVklOR19CSVQpLA0KV09SS0xPQURf
TUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX1ZJREVPLCBXT1JLTE9BRF9QUExJQl9WSURFT19CSVQp
LA0KV09SS0xPQURfTUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX1ZSLCBXT1JLTE9BRF9QUExJQl9W
Ul9CSVQpLA0KLSBXT1JLTE9BRF9NQVAoUFBfU01DX1BPV0VSX1BST0ZJTEVfQ09NUFVURSwgV09S
S0xPQURfUFBMSUJfQ1VTVE9NX0JJVCksDQorIFdPUktMT0FEX01BUChQUF9TTUNfUE9XRVJfUFJP
RklMRV9DT01QVVRFLCBXT1JLTE9BRF9QUExJQl9DT01QVVRFX0JJVCksDQpXT1JLTE9BRF9NQVAo
UFBfU01DX1BPV0VSX1BST0ZJTEVfQ1VTVE9NLCBXT1JLTE9BRF9QUExJQl9DVVNUT01fQklUKSwN
Cn07DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92ZWdhMjBf
cHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92ZWdhMjBfcHB0LmMNCmluZGV4
IDdjODkzM2Y5ODdkMS4uNWIyMTM4NmY1NThkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvdmVnYTIwX3BwdC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS92ZWdhMjBfcHB0LmMNCkBAIC0yMjEsNyArMjIxLDcgQEAgc3RhdGljIHN0cnVjdCBz
bXVfMTFfMF9jbW4yYWlzY19tYXBwaW5nIHZlZ2EyMF93b3JrbG9hZF9tYXBbUFBfU01DX1BPV0VS
X1BST0ZJTEUNCldPUktMT0FEX01BUChQUF9TTUNfUE9XRVJfUFJPRklMRV9QT1dFUlNBVklORywg
V09SS0xPQURfUFBMSUJfUE9XRVJfU0FWSU5HX0JJVCksDQpXT1JLTE9BRF9NQVAoUFBfU01DX1BP
V0VSX1BST0ZJTEVfVklERU8sIFdPUktMT0FEX1BQTElCX1ZJREVPX0JJVCksDQpXT1JLTE9BRF9N
QVAoUFBfU01DX1BPV0VSX1BST0ZJTEVfVlIsIFdPUktMT0FEX1BQTElCX1ZSX0JJVCksDQotIFdP
UktMT0FEX01BUChQUF9TTUNfUE9XRVJfUFJPRklMRV9DT01QVVRFLCBXT1JLTE9BRF9QUExJQl9D
VVNUT01fQklUKSwNCisgV09SS0xPQURfTUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX0NPTVBVVEUs
IFdPUktMT0FEX1BQTElCX0NPTVBVVEVfQklUKSwNCldPUktMT0FEX01BUChQUF9TTUNfUE9XRVJf
UFJPRklMRV9DVVNUT00sIFdPUktMT0FEX1BQTElCX0NVU1RPTV9CSVQpLA0KfTsNCg0KLS0NCjIu
MTcuMQ0KDQoNCg==

--_000_ADFBF901E1474148AF0EB51D217C34A3amdcom_
Content-Type: text/html; charset="gb2312"
Content-ID: <04683E1149779340B2E6163BB217E934-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space;" class=3D"">
Reviewed-by: Kenneth Feng &lt;<a href=3D"mailto:kenneth.feng-5C7GfCeVMHo@public.gmane.org" class=
=3D"">kenneth.feng-5C7GfCeVMHo@public.gmane.org</a>&gt;
<div class=3D""><br class=3D"">
</div>
<div class=3D""><br class=3D"">
<div style=3D"">
<blockquote type=3D"cite" class=3D"">
<div class=3D"">=D4=DA 2019=C4=EA11=D4=C25=C8=D5=A3=AC=CF=C2=CE=E76:23=A3=
=ACWang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org" class=3D"">=
Kevin1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt; =D0=B4=B5=C0=A3=BA</div>
<br class=3D"Apple-interchange-newline">
<div class=3D"">
<div class=3D"">fix workload bit (WORKLOAD_PPLIB_COMPUTE_BIT) map error<br =
class=3D"">
on vega20 and navi asic.<br class=3D"">
<br class=3D"">
fix commit:<br class=3D"">
drm/amd/powerplay: add function get_workload_type_map for swsmu<br class=3D=
"">
<br class=3D"">
Signed-off-by: Kevin Wang &lt;<a href=3D"mailto:kevin1.wang-5C7GfCeVMHo@public.gmane.org" class=
=3D"">kevin1.wang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br class=3D"">
---<br class=3D"">
drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 &#43;-<br class=3D"">
drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 2 &#43;-<br class=3D"">
2 files changed, 2 insertions(&#43;), 2 deletions(-)<br class=3D"">
<br class=3D"">
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br class=3D"">
index 769f9451d904..354f70978f82 100644<br class=3D"">
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br class=3D"">
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br class=3D"">
@@ -207,7 &#43;207,7 @@ static struct smu_11_0_cmn2aisc_mapping navi10_work=
load_map[PP_SMC_POWER_PROFILE<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_POWERSAVING,<span class=3D"Apple-tab-span" style=3D"=
white-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_POWER_SAVING_BIT),<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_VIDEO,<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_VIDEO_BIT),<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_VR,<span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_PPLIB_=
VR_BIT),<br class=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space:pre"> </span>WORKLOAD_=
MAP(PP_SMC_POWER_PROFILE_COMPUTE,<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_CUSTOM_BIT),<br class=3D"">
&#43;<span class=3D"Apple-tab-span" style=3D"white-space:pre"> </span>WORKL=
OAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_COMPUTE_BIT),<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_CUSTOM,<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_CUSTOM_BIT),<br class=3D"">
};<br class=3D"">
<br class=3D"">
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br class=3D"">
index 7c8933f987d1..5b21386f558d 100644<br class=3D"">
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br class=3D"">
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br class=3D"">
@@ -221,7 &#43;221,7 @@ static struct smu_11_0_cmn2aisc_mapping vega20_work=
load_map[PP_SMC_POWER_PROFILE<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_POWERSAVING,<span class=3D"Apple-tab-span" style=3D"=
white-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_POWER_SAVING_BIT),<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_VIDEO,<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_VIDEO_BIT),<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_VR,<span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_PPLIB_=
VR_BIT),<br class=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space:pre"> </span>WORKLOAD_=
MAP(PP_SMC_POWER_PROFILE_COMPUTE,<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_CUSTOM_BIT),<br class=3D"">
&#43;<span class=3D"Apple-tab-span" style=3D"white-space:pre"> </span>WORKL=
OAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_COMPUTE_BIT),<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_CUSTOM,<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_CUSTOM_BIT),<br class=3D"">
};<br class=3D"">
<br class=3D"">
-- <br class=3D"">
2.17.1<br class=3D"">
<br class=3D"">
</div>
</div>
</blockquote>
</div>
<br class=3D"">
</div>
</body>
</html>

--_000_ADFBF901E1474148AF0EB51D217C34A3amdcom_--

--===============0526005268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0526005268==--
