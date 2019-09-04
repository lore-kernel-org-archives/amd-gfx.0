From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: Add UMD PState Renoir Msg
 Parameters
Date: Wed, 4 Sep 2019 06:32:02 +0000
Message-ID: <MN2PR12MB3296B324AFCAABE3E7E63ECEA2B80@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <1567576882-13685-1-git-send-email-Prike.Liang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1759956886=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1567576882-13685-1-git-send-email-Prike.Liang-5C7GfCeVMHo@public.gmane.org>
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
To: "Liang, Prike" <Prike.Liang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============1759956886==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296B324AFCAABE3E7E63ECEA2B80MN2PR12MB3296namp_"

--_000_MN2PR12MB3296B324AFCAABE3E7E63ECEA2B80MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

i think it's better to merge these two patches into one patch.
after fixed: Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Liang, P=
rike <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, September 4, 2019 2:01 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Liang, Prike <Prike.Lia=
ng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/powerplay: Add UMD PState Renoir Msg Parameter=
s

Add UMD PState macro definition for PState update.

Signed-off-by: Prike Liang <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
reviewed-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
[Kevin]: change "reviewed-by" to "Reviewed-by"
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.h
index e9b7237..a017a47 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
@@ -25,4 +25,9 @@

 extern void renoir_set_ppt_funcs(struct smu_context *smu);

+//UMD PState Renoir Msg Parameters in MHz
+#define RENOIR_UMD_PSTATE_GFXCLK       700
+#define RENOIR_UMD_PSTATE_SOCCLK       678
+#define RENOIR_UMD_PSTATE_FCLK         800
+
 #endif
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3296B324AFCAABE3E7E63ECEA2B80MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>i think it's better to merge these two patches into one patch.</span>=
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>after fixed: Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</spa=
n></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>Best Regards,<br>
Kevin</span><span></span></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Liang, Prike &lt;Prike.Liang@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 4, 2019 2:01 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Liang, Pri=
ke &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/powerplay: Add UMD PState Renoir Msg Pa=
rameters</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Add UMD PState macro definition for PState update.=
<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;<br>
reviewed-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div class=3D"PlainText"><b><i>[Kevin]: change &quot;reviewed-by&quot; to &=
quot;Reviewed-by&quot;</i></b></div>
<div class=3D"PlainText">---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 5 &#43;&#43;&#43;&#43;&#=
43;<br>
&nbsp;1 file changed, 5 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.h<br>
index e9b7237..a017a47 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h<br>
@@ -25,4 &#43;25,9 @@<br>
&nbsp;<br>
&nbsp;extern void renoir_set_ppt_funcs(struct smu_context *smu);<br>
&nbsp;<br>
&#43;//UMD PState Renoir Msg Parameters in MHz<br>
&#43;#define RENOIR_UMD_PSTATE_GFXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7=
00<br>
&#43;#define RENOIR_UMD_PSTATE_SOCCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6=
78<br>
&#43;#define RENOIR_UMD_PSTATE_FCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 800<br>
&#43;<br>
&nbsp;#endif<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296B324AFCAABE3E7E63ECEA2B80MN2PR12MB3296namp_--

--===============1759956886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1759956886==--
