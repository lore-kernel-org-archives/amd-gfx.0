From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: implement dpm_get_sclk/mclk for RV
Date: Tue, 12 Dec 2017 15:11:27 +0000
Message-ID: <BN6PR12MB165224D67507F0ADF97F0E37F7340@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1513063453-21812-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1513934818=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513063453-21812-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1513934818==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB165224D67507F0ADF97F0E37F7340BN6PR12MB1652namp_"

--_000_BN6PR12MB165224D67507F0ADF97F0E37F7340BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, December 12, 2017 2:24 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH] drm/amd/pp: implement dpm_get_sclk/mclk for RV

Change-Id: I3abf5bde8c64ccab8e842a7c22aee011fc34e69f
Reviewed-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c | 25 ++++++++++++++++++++++=
+--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c b/drivers/gpu/d=
rm/amd/powerplay/hwmgr/rv_hwmgr.c
index 3e0b267..027fd63 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
@@ -523,12 +523,33 @@ static int rv_dpm_force_dpm_level(struct pp_hwmgr *hw=
mgr,

 static uint32_t rv_dpm_get_mclk(struct pp_hwmgr *hwmgr, bool low)
 {
-       return 0;
+       struct rv_hwmgr *data;
+
+       if (hwmgr =3D=3D NULL)
+               return -EINVAL;
+
+       data =3D (struct rv_hwmgr *)(hwmgr->backend);
+
+       if (low)
+               return data->clock_vol_info.vdd_dep_on_fclk->entries[0].clk=
;
+       else
+               return data->clock_vol_info.vdd_dep_on_fclk->entries[
+                       data->clock_vol_info.vdd_dep_on_fclk->count - 1].cl=
k;
 }

 static uint32_t rv_dpm_get_sclk(struct pp_hwmgr *hwmgr, bool low)
 {
-       return 0;
+       struct rv_hwmgr *data;
+
+       if (hwmgr =3D=3D NULL)
+               return -EINVAL;
+
+       data =3D (struct rv_hwmgr *)(hwmgr->backend);
+
+       if (low)
+               return data->gfx_min_freq_limit;
+       else
+               return data->gfx_max_freq_limit;
 }

 static int rv_dpm_patch_boot_state(struct pp_hwmgr *hwmgr,
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB165224D67507F0ADF97F0E37F7340BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Tuesday, December 12, 2017 2:24 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/pp: implement dpm_get_sclk/mclk for RV</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:10pt;=
">
<div class=3D"PlainText">Change-Id: I3abf5bde8c64ccab8e842a7c22aee011fc34e6=
9f<br>
Reviewed-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Reviewed-by: Alex Deucher &lt;alexander.deucher@am=
d.com&gt;<br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c | 25 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 23 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c b/drivers/gpu/d=
rm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
index 3e0b267..027fd63 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
@@ -523,12 &#43;523,33 @@ static int rv_dpm_force_dpm_level(struct pp_hwmgr=
 *hwmgr,<br>
&nbsp;<br>
&nbsp;static uint32_t rv_dpm_get_mclk(struct pp_hwmgr *hwmgr, bool low)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rv_hwmgr *data;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D (struct rv_hwmgr *)(hwmg=
r-&gt;backend);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return data-&gt;clock_vol_info.vdd_dep_on_fclk-&gt;entries[0=
].clk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return data-&gt;clock_vol_info.vdd_dep_on_fclk-&gt;entries[<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;clo=
ck_vol_info.vdd_dep_on_fclk-&gt;count - 1].clk;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static uint32_t rv_dpm_get_sclk(struct pp_hwmgr *hwmgr, bool low)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rv_hwmgr *data;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D (struct rv_hwmgr *)(hwmg=
r-&gt;backend);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return data-&gt;gfx_min_freq_limit;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return data-&gt;gfx_max_freq_limit;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int rv_dpm_patch_boot_state(struct pp_hwmgr *hwmgr,<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk281759" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB165224D67507F0ADF97F0E37F7340BN6PR12MB1652namp_--

--===============1513934818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1513934818==--
