From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 32/32] drm/amd/display: Fix dim display on DCE11
Date: Wed, 4 Apr 2018 15:17:40 +0000
Message-ID: <BN6PR12MB18095513D4EAE9751423B742F7A40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180404012747.5651-1-harry.wentland@amd.com>,
 <20180404012747.5651-33-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1800261231=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180404012747.5651-33-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>

--===============1800261231==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18095513D4EAE9751423B742F7A40BN6PR12MB1809namp_"

--_000_BN6PR12MB18095513D4EAE9751423B742F7A40BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Do other DCE blocks need this fix as well?  Or is this code shared with say=
 DCE8 and DCE10?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Harry We=
ntland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, April 3, 2018 9:27 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Li, Sun peng (Leo)
Subject: [PATCH 32/32] drm/amd/display: Fix dim display on DCE11

From: "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>

Before programming the input gamma, check that we're not using the
identity correction.

Signed-off-by: Leo (Sunpeng) Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>
Acked-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 99d192200797..f385b18d5c2e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -280,7 +280,9 @@ dce110_set_input_transfer_func(struct pipe_ctx *pipe_ct=
x,
         build_prescale_params(&prescale_params, plane_state);
         ipp->funcs->ipp_program_prescale(ipp, &prescale_params);

-       if (plane_state->gamma_correction && dce_use_lut(plane_state->forma=
t))
+       if (plane_state->gamma_correction &&
+                       !plane_state->gamma_correction->is_identity &&
+                       dce_use_lut(plane_state->format))
                 ipp->funcs->ipp_program_input_lut(ipp, plane_state->gamma_=
correction);

         if (tf =3D=3D NULL) {
--
2.15.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18095513D4EAE9751423B742F7A40BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Do other DCE blocks need this fix=
 as well?&nbsp; Or is this code shared with say DCE8 and DCE10?<br>
</p>
<br>
Alex<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Harry Wentland &lt;harry.we=
ntland-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, April 3, 2018 9:27 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Li, Sun peng (Leo)<br>
<b>Subject:</b> [PATCH 32/32] drm/amd/display: Fix dim display on DCE11</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: &quot;Leo (Sunpeng) Li&quot; &lt;sunpeng.li@=
amd.com&gt;<br>
<br>
Before programming the input gamma, check that we're not using the<br>
identity correction.<br>
<br>
Signed-off-by: Leo (Sunpeng) Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Anthony Koo &lt;Anthony.Koo-5C7GfCeVMHo@public.gmane.org&gt;<br>
Acked-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 4 &#43;=
&#43;&#43;-<br>
&nbsp;1 file changed, 3 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c<br>
index 99d192200797..f385b18d5c2e 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer=
.c<br>
@@ -280,7 &#43;280,9 @@ dce110_set_input_transfer_func(struct pipe_ctx *pip=
e_ctx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_prescale_params(&amp=
;prescale_params, plane_state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipp-&gt;funcs-&gt;ipp_prog=
ram_prescale(ipp, &amp;prescale_params);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (plane_state-&gt;gamma_correction =
&amp;&amp; dce_use_lut(plane_state-&gt;format))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (plane_state-&gt;gamma_correct=
ion &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !plane_state=
-&gt;gamma_correction-&gt;is_identity &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce_use_lut(=
plane_state-&gt;format))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ipp-&gt;funcs-&gt;ipp_program_input_lut(ipp, plane_st=
ate-&gt;gamma_correction);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tf =3D=3D NULL) {<br>
-- <br>
2.15.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk30396" previewremoved=3D"true">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB18095513D4EAE9751423B742F7A40BN6PR12MB1809namp_--

--===============1800261231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1800261231==--
