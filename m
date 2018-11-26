From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: limit high pixel clock modes on ST/CZ
Date: Mon, 26 Nov 2018 14:15:50 +0000
Message-ID: <BN6PR12MB1809F50687D05789C14E6C61F7D70@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1543214171-12460-1-git-send-email-shirish.s@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0702654118=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1543214171-12460-1-git-send-email-shirish.s-5C7GfCeVMHo@public.gmane.org>
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
To: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0702654118==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809F50687D05789C14E6C61F7D70BN6PR12MB1809namp_"

--_000_BN6PR12MB1809F50687D05789C14E6C61F7D70BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I thought there was a patch to do this already that got sent out a few week=
s ago.  Basically limit ST/CZ to modes that do not require a retimer.  Is a=
n additional patch needed?


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of S, Shiri=
sh <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, November 26, 2018 1:36:30 AM
To: Li, Sun peng (Leo); Wentland, Harry
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; S, Shirish
Subject: [PATCH] drm/amd/display: limit high pixel clock modes on ST/CZ

[Why]
ST/CZ (dce110) advertises modes such as 4k@60Hz etc.,
that it cannot handle correctly, hence  resulting in
several issues like flickering, black lines/flashes and so on.

[How]
These modes are basically high pixel clock ones, hence
limit the same to be advertised to avoid bad user experiences

Signed-off-by: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>
Suggested-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c    | 10 ++++++=
++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.=
c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index 1b2fe0d..1b8fe99 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -1121,6 +1121,16 @@ bool dce110_timing_generator_validate_timing(
         if (!timing)
                 return false;

+       /* Limit all modes that have a high pixel clock
+        * which seems to be problematic on dce110
+        * These include: 4k@60Hz, 1080p@144Hz,1440p@120Hz
+        * based on the below formula:
+        * refresh rate =3D pixel clock / (htotal * vtotal)
+        */
+       if (timing->pix_clk_khz > 300000)
+               return false;
+
+
         hsync_offset =3D timing->h_border_right + timing->h_front_porch;
         h_sync_start =3D timing->h_addressable + hsync_offset;

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809F50687D05789C14E6C61F7D70BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">I thought there was a patch to do=
 this already that got sent out a few weeks ago.&nbsp; Basically limit ST/C=
Z to modes that do not require a retimer.&nbsp; Is an additional patch need=
ed?</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of S, Shirish &lt;Shirish.S@amd.=
com&gt;<br>
<b>Sent:</b> Monday, November 26, 2018 1:36:30 AM<br>
<b>To:</b> Li, Sun peng (Leo); Wentland, Harry<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; S, Shirish<br>
<b>Subject:</b> [PATCH] drm/amd/display: limit high pixel clock modes on ST=
/CZ</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
ST/CZ (dce110) advertises modes such as 4k@60Hz etc.,<br>
that it cannot handle correctly, hence&nbsp; resulting in<br>
several issues like flickering, black lines/flashes and so on.<br>
<br>
[How]<br>
These modes are basically high pixel clock ones, hence<br>
limit the same to be advertised to avoid bad user experiences<br>
<br>
Signed-off-by: Shirish S &lt;shirish.s-5C7GfCeVMHo@public.gmane.org&gt;<br>
Suggested-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c&nbsp;&nbs=
p;&nbsp; | 10 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 10 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.=
c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c<br>
index 1b2fe0d..1b8fe99 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_gener=
ator.c<br>
@@ -1121,6 &#43;1121,16 @@ bool dce110_timing_generator_validate_timing(<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!timing)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Limit all modes that have a hi=
gh pixel clock<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * which seems to be problem=
atic on dce110<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * These include: 4k@60Hz, 1=
080p@144Hz,1440p@120Hz<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * based on the below formul=
a:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * refresh rate =3D pixel cl=
ock / (htotal * vtotal)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timing-&gt;pix_clk_khz &gt; 3=
00000)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hsync_offset =3D timing-&g=
t;h_border_right &#43; timing-&gt;h_front_porch;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; h_sync_start =3D timing-&g=
t;h_addressable &#43; hsync_offset;<br>
&nbsp;<br>
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

--_000_BN6PR12MB1809F50687D05789C14E6C61F7D70BN6PR12MB1809namp_--

--===============0702654118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0702654118==--
