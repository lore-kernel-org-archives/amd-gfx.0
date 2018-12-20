From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: fix compliler errors
 [-Werror,-Wmissing-braces]
Date: Thu, 20 Dec 2018 15:34:03 +0000
Message-ID: <BN6PR12MB180942C4385A978B03567E74F7BF0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1545314443-7069-1-git-send-email-shirish.s@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2117811148=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1545314443-7069-1-git-send-email-shirish.s-5C7GfCeVMHo@public.gmane.org>
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
To: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2117811148==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180942C4385A978B03567E74F7BF0BN6PR12MB1809namp_"

--_000_BN6PR12MB180942C4385A978B03567E74F7BF0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of S, Shiri=
sh <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, December 20, 2018 9:01:04 AM
To: Li, Sun peng (Leo); Wentland, Harry; Deucher, Alexander; Koenig, Christ=
ian
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; S, Shirish
Subject: [PATCH] drm/amd/display: fix compliler errors [-Werror,-Wmissing-b=
races]

Initializing structures with { } is known to be problematic since
it doesn't necessararily initializes all bytes, in case of padding,
causing random failures when structures are memcmp().

This patch fixes the structure initialisation compiler error by memsetting
the entire structure elements instead of only the first one.

Signed-off-by: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c       | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 0bd33a7..1b5630f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -92,9 +92,10 @@ static void log_mpc_crc(struct dc *dc,
 void dcn10_log_hubbub_state(struct dc *dc, struct dc_log_buffer_ctx *log_c=
tx)
 {
         struct dc_context *dc_ctx =3D dc->ctx;
-       struct dcn_hubbub_wm wm =3D {0};
+       struct dcn_hubbub_wm wm;
         int i;

+       memset(&wm, 0, sizeof(struct dcn_hubbub_wm));
         hubbub1_wm_read_state(dc->res_pool->hubbub, &wm);

         DTN_INFO("HUBBUB WM:      data_urgent  pte_meta_urgent"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.=
c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index cd46901..3fccec2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -72,7 +72,7 @@ static unsigned int snprintf_count(char *pBuf, unsigned i=
nt bufSize, char *fmt,
 static unsigned int dcn10_get_hubbub_state(struct dc *dc, char *pBuf, unsi=
gned int bufSize)
 {
         struct dc_context *dc_ctx =3D dc->ctx;
-       struct dcn_hubbub_wm wm =3D {0};
+       struct dcn_hubbub_wm wm;
         int i;

         unsigned int chars_printed =3D 0;
@@ -81,6 +81,7 @@ static unsigned int dcn10_get_hubbub_state(struct dc *dc,=
 char *pBuf, unsigned i
         const uint32_t ref_clk_mhz =3D dc_ctx->dc->res_pool->ref_clock_inK=
hz / 1000;
         static const unsigned int frac =3D 1000;

+       memset(&wm, 0, sizeof(struct dcn_hubbub_wm));
         hubbub1_wm_read_state(dc->res_pool->hubbub, &wm);

         chars_printed =3D snprintf_count(pBuf, remaining_buffer, "wm_set_i=
ndex,data_urgent,pte_meta_urgent,sr_enter,sr_exit,dram_clk_chanage\n");
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180942C4385A978B03567E74F7BF0BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of S, Shirish &lt;Shirish.S@amd.=
com&gt;<br>
<b>Sent:</b> Thursday, December 20, 2018 9:01:04 AM<br>
<b>To:</b> Li, Sun peng (Leo); Wentland, Harry; Deucher, Alexander; Koenig,=
 Christian<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; S, Shirish<br>
<b>Subject:</b> [PATCH] drm/amd/display: fix compliler errors [-Werror,-Wmi=
ssing-braces]</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Initializing structures with { } is known to be pr=
oblematic since<br>
it doesn't necessararily initializes all bytes, in case of padding,<br>
causing random failures when structures are memcmp().<br>
<br>
This patch fixes the structure initialisation compiler error by memsetting<=
br>
the entire structure elements instead of only the first one.<br>
<br>
Signed-off-by: Shirish S &lt;shirish.s-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | 3 &#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c | 3 &=
#43;&#43;-<br>
&nbsp;2 files changed, 4 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c<br>
index 0bd33a7..1b5630f 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c=
<br>
@@ -92,9 &#43;92,10 @@ static void log_mpc_crc(struct dc *dc,<br>
&nbsp;void dcn10_log_hubbub_state(struct dc *dc, struct dc_log_buffer_ctx *=
log_ctx)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *dc_ctx =
=3D dc-&gt;ctx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn_hubbub_wm wm =3D {0};<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn_hubbub_wm wm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;wm, 0, sizeof(struct =
dcn_hubbub_wm));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub1_wm_read_state(dc-&=
gt;res_pool-&gt;hubbub, &amp;wm);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DTN_INFO(&quot;HUBBUB WM:&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_urgent&nbsp; pte_meta_urgent&quot;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.=
c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c<br>
index cd46901..3fccec2 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_d=
ebug.c<br>
@@ -72,7 &#43;72,7 @@ static unsigned int snprintf_count(char *pBuf, unsign=
ed int bufSize, char *fmt,<br>
&nbsp;static unsigned int dcn10_get_hubbub_state(struct dc *dc, char *pBuf,=
 unsigned int bufSize)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *dc_ctx =
=3D dc-&gt;ctx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn_hubbub_wm wm =3D {0};<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn_hubbub_wm wm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int chars_printed=
 =3D 0;<br>
@@ -81,6 &#43;81,7 @@ static unsigned int dcn10_get_hubbub_state(struct dc =
*dc, char *pBuf, unsigned i<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint32_t ref_clk_mhz=
 =3D dc_ctx-&gt;dc-&gt;res_pool-&gt;ref_clock_inKhz / 1000;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const unsigned int =
frac =3D 1000;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;wm, 0, sizeof(struct =
dcn_hubbub_wm));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubbub1_wm_read_state(dc-&=
gt;res_pool-&gt;hubbub, &amp;wm);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chars_printed =3D snprintf=
_count(pBuf, remaining_buffer, &quot;wm_set_index,data_urgent,pte_meta_urge=
nt,sr_enter,sr_exit,dram_clk_chanage\n&quot;);<br>
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

--_000_BN6PR12MB180942C4385A978B03567E74F7BF0BN6PR12MB1809namp_--

--===============2117811148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2117811148==--
