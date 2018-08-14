From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: Disable deadlock test suite for RV/RV2/PCO
Date: Tue, 14 Aug 2018 16:15:15 +0000
Message-ID: <BN6PR12MB180951F811B852EED79BDE0CF7380@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1534245010-17995-1-git-send-email-likun.gao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0424307351=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534245010-17995-1-git-send-email-likun.gao-5C7GfCeVMHo@public.gmane.org>
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
To: "Gao, Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0424307351==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180951F811B852EED79BDE0CF7380BN6PR12MB1809namp_"

--_000_BN6PR12MB180951F811B852EED79BDE0CF7380BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of likun Ga=
o <likun.gao-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, August 14, 2018 7:10:10 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Gao, Likun
Subject: [PATCH libdrm] amdgpu: Disable deadlock test suite for RV/RV2/PCO

From: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>

disable deadlock test suite for RV/RV2/PCO

Signed-off-by: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>
---
 tests/amdgpu/deadlock_tests.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/amdgpu/deadlock_tests.c b/tests/amdgpu/deadlock_tests.c
index 1eb5761..304482d 100644
--- a/tests/amdgpu/deadlock_tests.c
+++ b/tests/amdgpu/deadlock_tests.c
@@ -93,7 +93,8 @@ CU_BOOL suite_deadlock_tests_enable(void)
                 return CU_FALSE;

         if (device_handle->info.family_id =3D=3D AMDGPU_FAMILY_AI ||
-           device_handle->info.family_id =3D=3D AMDGPU_FAMILY_SI) {
+           device_handle->info.family_id =3D=3D AMDGPU_FAMILY_SI ||
+           device_handle->info.family_id =3D=3D AMDGPU_FAMILY_RV) {
                 printf("\n\nCurrently hangs the CP on this ASIC, deadlock =
suite disabled\n");
                 enable =3D CU_FALSE;
         }
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180951F811B852EED79BDE0CF7380BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of likun Gao &lt;likun.gao@amd.c=
om&gt;<br>
<b>Sent:</b> Tuesday, August 14, 2018 7:10:10 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Gao, Likun<br>
<b>Subject:</b> [PATCH libdrm] amdgpu: Disable deadlock test suite for RV/R=
V2/PCO</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Likun Gao &lt;Likun.Gao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
disable deadlock test suite for RV/RV2/PCO<br>
<br>
Signed-off-by: Likun Gao &lt;Likun.Gao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;tests/amdgpu/deadlock_tests.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/tests/amdgpu/deadlock_tests.c b/tests/amdgpu/deadlock_tests.c<=
br>
index 1eb5761..304482d 100644<br>
--- a/tests/amdgpu/deadlock_tests.c<br>
&#43;&#43;&#43; b/tests/amdgpu/deadlock_tests.c<br>
@@ -93,7 &#43;93,8 @@ CU_BOOL suite_deadlock_tests_enable(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return CU_FALSE;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (device_handle-&gt;info=
.family_id =3D=3D AMDGPU_FAMILY_AI ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_handle=
-&gt;info.family_id =3D=3D AMDGPU_FAMILY_SI) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_ha=
ndle-&gt;info.family_id =3D=3D AMDGPU_FAMILY_SI ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_ha=
ndle-&gt;info.family_id =3D=3D AMDGPU_FAMILY_RV) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; printf(&quot;\n\nCurrently hangs the CP on this ASIC,=
 deadlock suite disabled\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enable =3D CU_FALSE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180951F811B852EED79BDE0CF7380BN6PR12MB1809namp_--

--===============0424307351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0424307351==--
