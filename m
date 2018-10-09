From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Fix warning storm on Raven2
Date: Tue, 9 Oct 2018 17:52:59 +0000
Message-ID: <BN6PR12MB18090B83ACDC01F4FB9844E0F7E70@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1539107410-28823-1-git-send-email-Roman.Li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1248974918=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539107410-28823-1-git-send-email-Roman.Li-5C7GfCeVMHo@public.gmane.org>
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
To: "Li, Roman" <Roman.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>

--===============1248974918==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18090B83ACDC01F4FB9844E0F7E70BN6PR12MB1809namp_"

--_000_BN6PR12MB18090B83ACDC01F4FB9844E0F7E70BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Roman.Li=
@amd.com <Roman.Li-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, October 9, 2018 1:50:09 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Li, Sun peng (Leo); Wu, Hersen; Wentland, Harry; Li, Roman
Subject: [PATCH 1/2] drm/amd/display: Fix warning storm on Raven2

From: Roman Li <Roman.Li-5C7GfCeVMHo@public.gmane.org>

[Why]
Wrong index for pstate debug test register

[How]
Add correct index value for dcn1_01 in hubbub1_construct()

Signed-off-by: Hersen Wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Roman Li <Roman.Li-5C7GfCeVMHo@public.gmane.org>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    | 43 ++++++++++++++++++=
+++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/=
gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index 69345ce6..4254e7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -133,7 +133,43 @@ bool hubbub1_verify_allow_pstate_change_high(
                 forced_pstate_allow =3D false;
         }

-       /* RV1:
+       /* RV2:
+        * dchubbubdebugind, at: 0xB
+        * description
+        * 0:     Pipe0 Plane0 Allow Pstate Change
+        * 1:     Pipe0 Plane1 Allow Pstate Change
+        * 2:     Pipe0 Cursor0 Allow Pstate Change
+        * 3:     Pipe0 Cursor1 Allow Pstate Change
+        * 4:     Pipe1 Plane0 Allow Pstate Change
+        * 5:     Pipe1 Plane1 Allow Pstate Change
+        * 6:     Pipe1 Cursor0 Allow Pstate Change
+        * 7:     Pipe1 Cursor1 Allow Pstate Change
+        * 8:     Pipe2 Plane0 Allow Pstate Change
+        * 9:     Pipe2 Plane1 Allow Pstate Change
+        * 10:    Pipe2 Cursor0 Allow Pstate Change
+        * 11:    Pipe2 Cursor1 Allow Pstate Change
+        * 12:    Pipe3 Plane0 Allow Pstate Change
+        * 13:    Pipe3 Plane1 Allow Pstate Change
+        * 14:    Pipe3 Cursor0 Allow Pstate Change
+        * 15:    Pipe3 Cursor1 Allow Pstate Change
+        * 16:    Pipe4 Plane0 Allow Pstate Change
+        * 17:    Pipe4 Plane1 Allow Pstate Change
+        * 18:    Pipe4 Cursor0 Allow Pstate Change
+        * 19:    Pipe4 Cursor1 Allow Pstate Change
+        * 20:    Pipe5 Plane0 Allow Pstate Change
+        * 21:    Pipe5 Plane1 Allow Pstate Change
+        * 22:    Pipe5 Cursor0 Allow Pstate Change
+        * 23:    Pipe5 Cursor1 Allow Pstate Change
+        * 24:    Pipe6 Plane0 Allow Pstate Change
+        * 25:    Pipe6 Plane1 Allow Pstate Change
+        * 26:    Pipe6 Cursor0 Allow Pstate Change
+        * 27:    Pipe6 Cursor1 Allow Pstate Change
+        * 28:    WB0 Allow Pstate Change
+        * 29:    WB1 Allow Pstate Change
+        * 30:    Arbiter's allow_pstate_change
+        * 31:    SOC pstate change request"
+        *
+        * RV1:
          * dchubbubdebugind, at: 0x7
          * description "3-0:   Pipe0 cursor0 QOS
          * 7-4:   Pipe1 cursor0 QOS
@@ -157,7 +193,6 @@ bool hubbub1_verify_allow_pstate_change_high(
          * 31:    SOC pstate change request
          */

-
         REG_WRITE(DCHUBBUB_TEST_DEBUG_INDEX, hubbub->debug_test_index_psta=
te);

         for (i =3D 0; i < pstate_wait_timeout_us; i++) {
@@ -819,5 +854,9 @@ void hubbub1_construct(struct hubbub *hubbub,
         hubbub->masks =3D hubbub_mask;

         hubbub->debug_test_index_pstate =3D 0x7;
+#if defined(CONFIG_DRM_AMD_DC_DCN1_01)
+       if (ctx->dce_version =3D=3D DCN_VERSION_1_01)
+               hubbub->debug_test_index_pstate =3D 0xB;
+#endif
 }

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in the sections below.



--_000_BN6PR12MB18090B83ACDC01F4FB9844E0F7E70BN6PR12MB1809namp_
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
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFo=
nt&quot;, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols;">
<p style=3D"margin-top:0; margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0; margin-bottom:0">Acked-by: Alex Deucher &lt;alexa=
nder.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Roman.Li-5C7GfCeVMHo@public.gmane.org &lt;Roman.=
Li-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, October 9, 2018 1:50:09 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Li, Sun peng (Leo); Wu, Hersen; Wentland, Harry; Li, Roman<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/display: Fix warning storm on Raven2</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Roman Li &lt;Roman.Li-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
[Why]<br>
Wrong index for pstate debug test register<br>
<br>
[How]<br>
Add correct index value for dcn1_01 in hubbub1_construct()<br>
<br>
Signed-off-by: Hersen Wu &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Roman Li &lt;Roman.Li-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c&nbsp;&nbsp;&nbsp; | 4=
3 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;1 file changed, 41 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/=
gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c<br>
index 69345ce6..4254e7e 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c<br>
@@ -133,7 &#43;133,43 @@ bool hubbub1_verify_allow_pstate_change_high(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; forced_pstate_allow =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* RV1:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* RV2:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * dchubbubdebugind, at: 0xB=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * description<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 0:&nbsp;&nbsp;&nbsp;&nbsp=
; Pipe0 Plane0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 1:&nbsp;&nbsp;&nbsp;&nbsp=
; Pipe0 Plane1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2:&nbsp;&nbsp;&nbsp;&nbsp=
; Pipe0 Cursor0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 3:&nbsp;&nbsp;&nbsp;&nbsp=
; Pipe0 Cursor1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 4:&nbsp;&nbsp;&nbsp;&nbsp=
; Pipe1 Plane0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 5:&nbsp;&nbsp;&nbsp;&nbsp=
; Pipe1 Plane1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 6:&nbsp;&nbsp;&nbsp;&nbsp=
; Pipe1 Cursor0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 7:&nbsp;&nbsp;&nbsp;&nbsp=
; Pipe1 Cursor1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 8:&nbsp;&nbsp;&nbsp;&nbsp=
; Pipe2 Plane0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 9:&nbsp;&nbsp;&nbsp;&nbsp=
; Pipe2 Plane1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 10:&nbsp;&nbsp;&nbsp; Pip=
e2 Cursor0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 11:&nbsp;&nbsp;&nbsp; Pip=
e2 Cursor1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 12:&nbsp;&nbsp;&nbsp; Pip=
e3 Plane0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 13:&nbsp;&nbsp;&nbsp; Pip=
e3 Plane1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 14:&nbsp;&nbsp;&nbsp; Pip=
e3 Cursor0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 15:&nbsp;&nbsp;&nbsp; Pip=
e3 Cursor1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 16:&nbsp;&nbsp;&nbsp; Pip=
e4 Plane0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 17:&nbsp;&nbsp;&nbsp; Pip=
e4 Plane1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 18:&nbsp;&nbsp;&nbsp; Pip=
e4 Cursor0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 19:&nbsp;&nbsp;&nbsp; Pip=
e4 Cursor1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 20:&nbsp;&nbsp;&nbsp; Pip=
e5 Plane0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 21:&nbsp;&nbsp;&nbsp; Pip=
e5 Plane1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 22:&nbsp;&nbsp;&nbsp; Pip=
e5 Cursor0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 23:&nbsp;&nbsp;&nbsp; Pip=
e5 Cursor1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 24:&nbsp;&nbsp;&nbsp; Pip=
e6 Plane0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 25:&nbsp;&nbsp;&nbsp; Pip=
e6 Plane1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 26:&nbsp;&nbsp;&nbsp; Pip=
e6 Cursor0 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 27:&nbsp;&nbsp;&nbsp; Pip=
e6 Cursor1 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 28:&nbsp;&nbsp;&nbsp; WB0=
 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 29:&nbsp;&nbsp;&nbsp; WB1=
 Allow Pstate Change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 30:&nbsp;&nbsp;&nbsp; Arb=
iter's allow_pstate_change<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 31:&nbsp;&nbsp;&nbsp; SOC=
 pstate change request&quot;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * RV1:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * dchubbubdebugind, =
at: 0x7<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * description &quot;=
3-0:&nbsp;&nbsp; Pipe0 cursor0 QOS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 7-4:&nbsp;&nbsp; P=
ipe1 cursor0 QOS<br>
@@ -157,7 &#43;193,6 @@ bool hubbub1_verify_allow_pstate_change_high(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 31:&nbsp;&nbsp;&nb=
sp; SOC pstate change request<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_WRITE(DCHUBBUB_TEST_DE=
BUG_INDEX, hubbub-&gt;debug_test_index_pstate);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; pstat=
e_wait_timeout_us; i&#43;&#43;) {<br>
@@ -819,5 &#43;854,9 @@ void hubbub1_construct(struct hubbub *hubbub,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub-&gt;masks =3D hubbu=
b_mask;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub-&gt;debug_test_inde=
x_pstate =3D 0x7;<br>
&#43;#if defined(CONFIG_DRM_AMD_DC_DCN1_01)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;dce_version =3D=3D DC=
N_VERSION_1_01)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hubbub-&gt;debug_test_index_pstate =3D 0xB;<br>
&#43;#endif<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk445418" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15391075668560.6223877911093239" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15391075668520.6619941898908696" style=3D"width: 9=
0%; background-color: rgb(255, 255, 255); position: relative; overflow: aut=
o; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1=
px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);=
" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15391075668540.14967359666528068" style=3D"vertical-alig=
n: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"=
2">
<div id=3D"LPRemovePreviewContainer_15391075668540.6907574272253448"></div>
<div id=3D"LPTitle_15391075668540.6597142408214279" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot;=
wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&q=
uot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif=
; line-height: 21px;">
<a id=3D"LPUrlAnchor_15391075668540.7588781973848282" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15391075668550.4384515405369218" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15391075668550.09770762632513252" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf=
_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma,=
 Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; =
overflow: hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB18090B83ACDC01F4FB9844E0F7E70BN6PR12MB1809namp_--

--===============1248974918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1248974918==--
