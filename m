From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix fclk idle state
Date: Tue, 29 Jan 2019 20:55:44 +0000
Message-ID: <BN6PR12MB18092D373D6ED5E16B5CC0AEF7970@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190129201653.4834-1-Roman.Li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1095097491=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190129201653.4834-1-Roman.Li-5C7GfCeVMHo@public.gmane.org>
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
To: "Li, Roman" <Roman.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Quan,
 Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Cc: "Chan, Carl" <Carl.Chan-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============1095097491==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18092D373D6ED5E16B5CC0AEF7970BN6PR12MB1809namp_"

--_000_BN6PR12MB18092D373D6ED5E16B5CC0AEF7970BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Roman.Li=
@amd.com <Roman.Li-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, January 29, 2019 3:16:53 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Xu, Feifei; Quan, Evan
Cc: Chan, Carl; Wentland, Harry; Li, Roman
Subject: [PATCH] drm/amd/display: Fix fclk idle state

From: Roman Li <Roman.Li-5C7GfCeVMHo@public.gmane.org>

[Why]
The earlier change 'Fix 6x4K displays' led to fclk value
idling at higher DPM level.

[How]
Apply the fix only to respective multi-display configuration.

Signed-off-by: Roman Li <Roman.Li-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c b/drivers/gpu=
/drm/amd/display/dc/dce/dce_clk_mgr.c
index 3c52a4fc921d..bbe051736a18 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
@@ -627,7 +627,15 @@ static void dce11_pplib_apply_display_requirements(
                         dc,
                         context->bw.dce.sclk_khz);

-       pp_display_cfg->min_dcfclock_khz =3D pp_display_cfg->min_engine_clo=
ck_khz;
+       /*
+        * As workaround for >4x4K lightup set dcfclock to min_engine_clock=
 value.
+        * This is not required for less than 5 displays,
+        * thus don't request decfclk in dc to avoid impact
+        * on power saving.
+        *
+        */
+       pp_display_cfg->min_dcfclock_khz =3D (context->stream_count > 4)?
+                       pp_display_cfg->min_engine_clock_khz : 0;

         pp_display_cfg->min_engine_clock_deep_sleep_khz
                         =3D context->bw.dce.sclk_deep_sleep_khz;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18092D373D6ED5E16B5CC0AEF7970BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Roman.Li-5C7GfCeVMHo@public.gmane.org &lt;Roman.Li=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 29, 2019 3:16:53 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Xu, Feifei; Quan, Evan<br>
<b>Cc:</b> Chan, Carl; Wentland, Harry; Li, Roman<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix fclk idle state</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Roman Li &lt;Roman.Li-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
[Why]<br>
The earlier change 'Fix 6x4K displays' led to fclk value<br>
idling at higher DPM level.<br>
<br>
[How]<br>
Apply the fix only to respective multi-display configuration.<br>
<br>
Signed-off-by: Roman Li &lt;Roman.Li-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c | 10 &#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;1 file changed, 9 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c b/drivers/gpu=
/drm/amd/display/dc/dce/dce_clk_mgr.c<br>
index 3c52a4fc921d..bbe051736a18 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c<br>
@@ -627,7 &#43;627,15 @@ static void dce11_pplib_apply_display_requirements=
(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conte=
xt-&gt;bw.dce.sclk_khz);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_display_cfg-&gt;min_dcfclock_khz =
=3D pp_display_cfg-&gt;min_engine_clock_khz;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * As workaround for &gt;4x4=
K lightup set dcfclock to min_engine_clock value.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This is not required for =
less than 5 displays,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * thus don't request decfcl=
k in dc to avoid impact<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on power saving.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_display_cfg-&gt;min_dcfclock_k=
hz =3D (context-&gt;stream_count &gt; 4)?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_display_c=
fg-&gt;min_engine_clock_khz : 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_display_cfg-&gt;min_eng=
ine_clock_deep_sleep_khz<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D c=
ontext-&gt;bw.dce.sclk_deep_sleep_khz;<br>
-- <br>
2.17.1<br>
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

--_000_BN6PR12MB18092D373D6ED5E16B5CC0AEF7970BN6PR12MB1809namp_--

--===============1095097491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1095097491==--
