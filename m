From: "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/display: Add connector debugfs for "output_bpc"
Date: Tue, 4 Jun 2019 18:14:19 +0000
Message-ID: <BN8PR12MB3217F1A7473AFE5372C30DEBEF150@BN8PR12MB3217.namprd12.prod.outlook.com>
References: <20190603174437.23996-1-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1709622187=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190603174437.23996-1-nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============1709622187==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB3217F1A7473AFE5372C30DEBEF150BN8PR12MB3217namp_"

--_000_BN8PR12MB3217F1A7473AFE5372C30DEBEF150BN8PR12MB3217namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Looks straightforward


Reviewed-by: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Nicholas=
 Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Sent: June 3, 2019 1:44:37 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Li, Sun peng (Leo); Wentland, Harry; Kazlauskas, Nicholas
Subject: [PATCH v2] drm/amd/display: Add connector debugfs for "output_bpc"

[Why]
This will be useful for verifying whether we enter the correct output
color depth from IGT.

[How]
Locks the connector and associated CRTC if available and outputs
the current and maximum output bpc values.

Example:

cat /sys/kernel/debug/dri/0/DP-1/output_bpc
Current: 8
Maximum: 10

v2: Drop unneeded connector status check

Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 71 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1d5fc5ad3bee..a3e362fa6747 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -672,6 +672,71 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struc=
t file *f, const char __us
         return bytes_from_user;
 }

+/*
+ * Returns the current and maximum output bpc for the connector.
+ * Example usage: cat /sys/kernel/debug/dri/0/DP-1/output_bpc
+ */
+static int output_bpc_show(struct seq_file *m, void *data)
+{
+       struct drm_connector *connector =3D m->private;
+       struct drm_device *dev =3D connector->dev;
+       struct drm_crtc *crtc =3D NULL;
+       struct dm_crtc_state *dm_crtc_state =3D NULL;
+       int res =3D -ENODEV;
+       unsigned int bpc;
+
+       mutex_lock(&dev->mode_config.mutex);
+       drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+
+       if (connector->state =3D=3D NULL)
+               goto unlock;
+
+       crtc =3D connector->state->crtc;
+       if (crtc =3D=3D NULL)
+               goto unlock;
+
+       drm_modeset_lock(&crtc->mutex, NULL);
+       if (crtc->state =3D=3D NULL)
+               goto unlock;
+
+       dm_crtc_state =3D to_dm_crtc_state(crtc->state);
+       if (dm_crtc_state->stream =3D=3D NULL)
+               goto unlock;
+
+       switch (dm_crtc_state->stream->timing.display_color_depth) {
+       case COLOR_DEPTH_666:
+               bpc =3D 6;
+               break;
+       case COLOR_DEPTH_888:
+               bpc =3D 8;
+               break;
+       case COLOR_DEPTH_101010:
+               bpc =3D 10;
+               break;
+       case COLOR_DEPTH_121212:
+               bpc =3D 12;
+               break;
+       case COLOR_DEPTH_161616:
+               bpc =3D 16;
+               break;
+       default:
+               goto unlock;
+       }
+
+       seq_printf(m, "Current: %u\n", bpc);
+       seq_printf(m, "Maximum: %u\n", connector->display_info.bpc);
+       res =3D 0;
+
+unlock:
+       if (crtc)
+               drm_modeset_unlock(&crtc->mutex);
+
+       drm_modeset_unlock(&dev->mode_config.connection_mutex);
+       mutex_unlock(&dev->mode_config.mutex);
+
+       return res;
+}
+
 /*
  * Returns the min and max vrr vfreq through the connector's debugfs file.
  * Example usage: cat /sys/kernel/debug/dri/0/DP-1/vrr_range
@@ -730,8 +795,6 @@ static ssize_t dp_sdp_message_debugfs_write(struct file=
 *f, const char __user *b
         return write_size;
 }

-DEFINE_SHOW_ATTRIBUTE(vrr_range);
-
 static ssize_t dp_dpcd_address_write(struct file *f, const char __user *bu=
f,
                                  size_t size, loff_t *pos)
 {
@@ -814,6 +877,9 @@ static ssize_t dp_dpcd_data_read(struct file *f, char _=
_user *buf,
         return read_size - r;
 }

+DEFINE_SHOW_ATTRIBUTE(output_bpc);
+DEFINE_SHOW_ATTRIBUTE(vrr_range);
+
 static const struct file_operations dp_link_settings_debugfs_fops =3D {
         .owner =3D THIS_MODULE,
         .read =3D dp_link_settings_read,
@@ -866,6 +932,7 @@ static const struct {
                 {"link_settings", &dp_link_settings_debugfs_fops},
                 {"phy_settings", &dp_phy_settings_debugfs_fop},
                 {"test_pattern", &dp_phy_test_pattern_fops},
+               {"output_bpc", &output_bpc_fops},
                 {"vrr_range", &vrr_range_fops},
                 {"sdp_message", &sdp_message_fops},
                 {"aux_dpcd_address", &dp_dpcd_address_debugfs_fops},
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN8PR12MB3217F1A7473AFE5372C30DEBEF150BN8PR12MB3217namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Looks straightforward</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: David Francis &lt;Da=
vid.Francis-5C7GfCeVMHo@public.gmane.org&gt;</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Nicholas Kazlauskas &lt;nicho=
las.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> June 3, 2019 1:44:37 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Li, Sun peng (Leo); Wentland, Harry; Kazlauskas, Nicholas<br>
<b>Subject:</b> [PATCH v2] drm/amd/display: Add connector debugfs for &quot=
;output_bpc&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
This will be useful for verifying whether we enter the correct output<br>
color depth from IGT.<br>
<br>
[How]<br>
Locks the connector and associated CRTC if available and outputs<br>
the current and maximum output bpc values.<br>
<br>
Example:<br>
<br>
cat /sys/kernel/debug/dri/0/DP-1/output_bpc<br>
Current: 8<br>
Maximum: 10<br>
<br>
v2: Drop unneeded connector status check<br>
<br>
Cc: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 71 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<b=
r>
&nbsp;1 file changed, 69 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
index 1d5fc5ad3bee..a3e362fa6747 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c=
<br>
@@ -672,6 &#43;672,71 @@ static ssize_t dp_phy_test_pattern_debugfs_write(s=
truct file *f, const char __us<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bytes_from_user;<br=
>
&nbsp;}<br>
&nbsp;<br>
&#43;/*<br>
&#43; * Returns the current and maximum output bpc for the connector.<br>
&#43; * Example usage: cat /sys/kernel/debug/dri/0/DP-1/output_bpc<br>
&#43; */<br>
&#43;static int output_bpc_show(struct seq_file *m, void *data)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *connector =
=3D m-&gt;private;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D connec=
tor-&gt;dev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc =3D NULL;<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_crtc_state *dm_crtc_sta=
te =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int res =3D -ENODEV;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int bpc;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dev-&gt;mode_conf=
ig.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_modeset_lock(&amp;dev-&gt;mod=
e_config.connection_mutex, NULL);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (connector-&gt;state =3D=3D NU=
LL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto unlock;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crtc =3D connector-&gt;state-&gt;=
crtc;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (crtc =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto unlock;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_modeset_lock(&amp;crtc-&gt;mu=
tex, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (crtc-&gt;state =3D=3D NULL)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto unlock;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_crtc_state =3D to_dm_crtc_stat=
e(crtc-&gt;state);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dm_crtc_state-&gt;stream =3D=
=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto unlock;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (dm_crtc_state-&gt;stream-=
&gt;timing.display_color_depth) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case COLOR_DEPTH_666:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; bpc =3D 6;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case COLOR_DEPTH_888:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; bpc =3D 8;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case COLOR_DEPTH_101010:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; bpc =3D 10;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case COLOR_DEPTH_121212:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; bpc =3D 12;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case COLOR_DEPTH_161616:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; bpc =3D 16;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto unlock;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;Current: %u\n=
&quot;, bpc);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;Maximum: %u\n=
&quot;, connector-&gt;display_info.bpc);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D 0;<br>
&#43;<br>
&#43;unlock:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (crtc)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; drm_modeset_unlock(&amp;crtc-&gt;mutex);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_modeset_unlock(&amp;dev-&gt;m=
ode_config.connection_mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;dev-&gt;mode_co=
nfig.mutex);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return res;<br>
&#43;}<br>
&#43;<br>
&nbsp;/*<br>
&nbsp; * Returns the min and max vrr vfreq through the connector's debugfs =
file.<br>
&nbsp; * Example usage: cat /sys/kernel/debug/dri/0/DP-1/vrr_range<br>
@@ -730,8 &#43;795,6 @@ static ssize_t dp_sdp_message_debugfs_write(struct =
file *f, const char __user *b<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return write_size;<br>
&nbsp;}<br>
&nbsp;<br>
-DEFINE_SHOW_ATTRIBUTE(vrr_range);<br>
-<br>
&nbsp;static ssize_t dp_dpcd_address_write(struct file *f, const char __use=
r *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size, loff_t *pos)<=
br>
&nbsp;{<br>
@@ -814,6 &#43;877,9 @@ static ssize_t dp_dpcd_data_read(struct file *f, ch=
ar __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return read_size - r;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;DEFINE_SHOW_ATTRIBUTE(output_bpc);<br>
&#43;DEFINE_SHOW_ATTRIBUTE(vrr_range);<br>
&#43;<br>
&nbsp;static const struct file_operations dp_link_settings_debugfs_fops =3D=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D dp_link_settings=
_read,<br>
@@ -866,6 &#43;932,7 @@ static const struct {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {&quot;link_settings&quot;, &amp;dp_link_settings_deb=
ugfs_fops},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {&quot;phy_settings&quot;, &amp;dp_phy_settings_debug=
fs_fop},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {&quot;test_pattern&quot;, &amp;dp_phy_test_pattern_f=
ops},<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; {&quot;output_bpc&quot;, &amp;output_bpc_fops},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {&quot;vrr_range&quot;, &amp;vrr_range_fops},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {&quot;sdp_message&quot;, &amp;sdp_message_fops},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {&quot;aux_dpcd_address&quot;, &amp;dp_dpcd_address_d=
ebugfs_fops},<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN8PR12MB3217F1A7473AFE5372C30DEBEF150BN8PR12MB3217namp_--

--===============1709622187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1709622187==--
