From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Remove unused CFLAGS entry in DML
 Makefile
Date: Thu, 8 Feb 2018 22:10:58 +0000
Message-ID: <BN6PR12MB1652AC493950CDF3579BA369F7F30@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20180208214728.19140-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1258396350=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180208214728.19140-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1258396350==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652AC493950CDF3579BA369F7F30BN6PR12MB1652namp_"

--_000_BN6PR12MB1652AC493950CDF3579BA369F7F30BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Harry We=
ntland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, February 8, 2018 4:47:28 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Wentland, Harry
Subject: [PATCH] drm/amd/display: Remove unused CFLAGS entry in DML Makefil=
e

Missed that with a previous change that removed unused files.

Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/=
amd/display/dc/dml/Makefile
index 0271043cf6a2..f83a608f93e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -32,7 +32,6 @@ endif

 dml_ccflags :=3D -mhard-float -msse $(cc_stack_align)

-CFLAGS_display_mode_vba.o :=3D $(dml_ccflags)
 CFLAGS_display_mode_lib.o :=3D $(dml_ccflags)
 CFLAGS_display_pipe_clocks.o :=3D $(dml_ccflags)
 CFLAGS_dml1_display_rq_dlg_calc.o :=3D $(dml_ccflags)
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652AC493950CDF3579BA369F7F30BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Harry Wentland &lt;harry.went=
land-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, February 8, 2018 4:47:28 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Wentland, Harry<br>
<b>Subject:</b> [PATCH] drm/amd/display: Remove unused CFLAGS entry in DML =
Makefile</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Missed that with a previous change that removed un=
used files.<br>
<br>
Signed-off-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dml/Makefile | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/=
amd/display/dc/dml/Makefile<br>
index 0271043cf6a2..f83a608f93e9 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
@@ -32,7 &#43;32,6 @@ endif<br>
&nbsp;<br>
&nbsp;dml_ccflags :=3D -mhard-float -msse $(cc_stack_align)<br>
&nbsp;<br>
-CFLAGS_display_mode_vba.o :=3D $(dml_ccflags)<br>
&nbsp;CFLAGS_display_mode_lib.o :=3D $(dml_ccflags)<br>
&nbsp;CFLAGS_display_pipe_clocks.o :=3D $(dml_ccflags)<br>
&nbsp;CFLAGS_dml1_display_rq_dlg_calc.o :=3D $(dml_ccflags)<br>
-- <br>
2.14.1<br>
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

--_000_BN6PR12MB1652AC493950CDF3579BA369F7F30BN6PR12MB1652namp_--

--===============1258396350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1258396350==--
