From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amd/powerplay: remove mutex lock for
 smu_handle_task when smu late init
Date: Thu, 18 Jul 2019 10:35:34 +0000
Message-ID: <MN2PR12MB3344F0DFB162D49F9BDD19CCE4C80@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1563444138-23948-1-git-send-email-Jack.Gui@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0224442291=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1563444138-23948-1-git-send-email-Jack.Gui-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Gui, Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

--===============0224442291==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3344F0DFB162D49F9BDD19CCE4C80MN2PR12MB3344namp_"

--_000_MN2PR12MB3344F0DFB162D49F9BDD19CCE4C80MN2PR12MB3344namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

cGxlYXNlIGhvbGQgb24gdGhlIG11dGV4IGNoYW5nZXMgb2YgcGF0Y2gxIGFuZCBwYXRjaDMuIFdl
IG5lZWQgYW4gb3ZlcmFsbCB0aG91Z2h0IG92ZXIgdGhlIHNtdSBtdXRleCBtYWNoaW5zaW0uIExl
dCB1cyBoYXZlIHNvbWUgaW50ZXJuYWwgZGlzY3Vzc2lvbnMgZmlyc3QuDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+ILT6se0gQ2hlbmdtaW5nIEd1aSA8SmFjay5HdWlAYW1kLmNv
bT4NCreiy83KsbzkOiBUaHVyc2RheSwgSnVseSAxOCwgMjAxOSA2OjAyOjE2IFBNDQrK1bz+yMs6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz4NCrOty806IEd1aSwgSmFjayA8SmFjay5HdWlAYW1kLmNvbT4NCtb3zOI6IFtQQVRDSCAx
LzNdIGRybS9hbWQvcG93ZXJwbGF5OiByZW1vdmUgbXV0ZXggbG9jayBmb3Igc211X2hhbmRsZV90
YXNrIHdoZW4gc211IGxhdGUgaW5pdA0KDQpyZW1vdmUgbXV0ZXggbG9jayB3aGVuIHNtdSBsYXRl
IGluaXQgdG8gY2FsbCBzbXVfaGFuZGxlX3Rhc2sNCg0KU2lnbmVkLW9mZi1ieTogQ2hlbmdtaW5n
IEd1aSA8SmFjay5HdWlAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2FtZGdwdV9zbXUuYyB8IDIgLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KaW5kZXggN2Qx
YmQwOS4uMTIyOTg1YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2FtZGdwdV9zbXUuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1
X3NtdS5jDQpAQCAtNTY5LDExICs1NjksOSBAQCBzdGF0aWMgaW50IHNtdV9sYXRlX2luaXQodm9p
ZCAqaGFuZGxlKQ0KDQogICAgICAgICBpZiAoIXNtdS0+cG1fZW5hYmxlZCkNCiAgICAgICAgICAg
ICAgICAgcmV0dXJuIDA7DQotICAgICAgIG11dGV4X2xvY2soJnNtdS0+bXV0ZXgpOw0KICAgICAg
ICAgc211X2hhbmRsZV90YXNrKCZhZGV2LT5zbXUsDQogICAgICAgICAgICAgICAgICAgICAgICAg
c211LT5zbXVfZHBtLmRwbV9sZXZlbCwNCiAgICAgICAgICAgICAgICAgICAgICAgICBBTURfUFBf
VEFTS19DT01QTEVURV9JTklUKTsNCi0gICAgICAgbXV0ZXhfdW5sb2NrKCZzbXUtPm11dGV4KTsN
Cg0KICAgICAgICAgcmV0dXJuIDA7DQogfQ0KLS0NCjIuNy40DQoNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0K

--_000_MN2PR12MB3344F0DFB162D49F9BDD19CCE4C80MN2PR12MB3344namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div>
<div>
<div style=3D"direction:ltr">please hold on the mutex changes of patch1 and=
 patch3. We need an overall thought over the smu mutex machinsim. Let us ha=
ve some internal discussions first.</div>
</div>
<div><br>
</div>
<div class=3D"x_ms-outlook-ios-signature"></div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> amd-g=
fx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; =B4=FA=B1=ED Chengming Gui=
 &lt;Jack.Gui-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Thursday, July 18, 2019 6:02:16 PM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Gui, Jack &lt;Jack.Gui-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH 1/3] drm/amd/powerplay: remove mutex lock for s=
mu_handle_task when smu late init</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">remove mutex lock when smu late init to call smu_h=
andle_task<br>
<br>
Signed-off-by: Chengming Gui &lt;Jack.Gui-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 --<br>
&nbsp;1 file changed, 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 7d1bd09..122985c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -569,11 &#43;569,9 @@ static int smu_late_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_handle_task(&amp;adev-=
&gt;smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&=
gt;smu_dpm.dpm_level,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_P=
P_TASK_COMPLETE_INIT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font>
</body>
</html>

--_000_MN2PR12MB3344F0DFB162D49F9BDD19CCE4C80MN2PR12MB3344namp_--

--===============0224442291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0224442291==--
