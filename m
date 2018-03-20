From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Fix gfx ring test failed on Fiji without hw
 avfs support
Date: Tue, 20 Mar 2018 14:12:57 +0000
Message-ID: <DM5PR12MB18203465D2AC25E4CD08D3BEF7AB0@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1521536723-5090-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0860504040=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1521536723-5090-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

--===============0860504040==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB18203465D2AC25E4CD08D3BEF7AB0DM5PR12MB1820namp_"

--_000_DM5PR12MB18203465D2AC25E4CD08D3BEF7AB0DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, March 20, 2018 5:05:23 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH] drm/amd/pp: Fix gfx ring test failed on Fiji without hw av=
fs support

caused by
'commit ca82cec868d1 ("drm/amd/pp: Simplified the avfs btc state on smu7")'

Change-Id: Ice0012e74ec3ef25cc561f8515ea6a553567d8a6
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c      | 3 +++
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/fiji_smumgr.c
index 43432e4..faef783 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -263,6 +263,9 @@ static int fiji_setup_graphics_level_structure(struct p=
p_hwmgr *hwmgr)

 static int fiji_avfs_event_mgr(struct pp_hwmgr *hwmgr)
 {
+       if (!hwmgr->avfs_supported)
+               return 0;
+
         PP_ASSERT_WITH_CODE(0 =3D=3D fiji_setup_graphics_level_structure(h=
wmgr),
                         "[AVFS][fiji_avfs_event_mgr] Could not Copy Graphi=
cs Level"
                         " table over to SMU",
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index f6b1298..997a777 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -172,11 +172,13 @@ static int polaris10_setup_graphics_level_structure(s=
truct pp_hwmgr *hwmgr)
 }


-static int
-polaris10_avfs_event_mgr(struct pp_hwmgr *hwmgr)
+static int polaris10_avfs_event_mgr(struct pp_hwmgr *hwmgr)
 {
         struct smu7_smumgr *smu_data =3D (struct smu7_smumgr *)(hwmgr->smu=
_backend);

+       if (!hwmgr->avfs_supported)
+               return 0;
+
         PP_ASSERT_WITH_CODE(0 =3D=3D polaris10_setup_graphics_level_struct=
ure(hwmgr),
                 "[AVFS][Polaris10_AVFSEventMgr] Could not Copy Graphics Le=
vel table over to SMU",
                 return -EINVAL);
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB18203465D2AC25E4CD08D3BEF7AB0DM5PR12MB1820namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<b>Sent:</b> Tuesday, March 20, 2018 5:05:23 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/pp: Fix gfx ring test failed on Fiji withou=
t hw avfs support</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">caused by<br>
'commit ca82cec868d1 (&quot;drm/amd/pp: Simplified the avfs btc state on sm=
u7&quot;)'<br>
<br>
Change-Id: Ice0012e74ec3ef25cc561f8515ea6a553567d8a6<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 3 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 6 &#43;&#43=
;&#43;&#43;--<br>
&nbsp;2 files changed, 7 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
index 43432e4..faef783 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
@@ -263,6 &#43;263,9 @@ static int fiji_setup_graphics_level_structure(stru=
ct pp_hwmgr *hwmgr)<br>
&nbsp;<br>
&nbsp;static int fiji_avfs_event_mgr(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;avfs_supported)<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D fiji_setup_graphics_level_structure(hwmgr),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;[AVFS][fiji_avfs_event_mgr] Could not Copy Graphics Level&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
; table over to SMU&quot;,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
index f6b1298..997a777 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<b=
r>
@@ -172,11 &#43;172,13 @@ static int polaris10_setup_graphics_level_structu=
re(struct pp_hwmgr *hwmgr)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
-static int<br>
-polaris10_avfs_event_mgr(struct pp_hwmgr *hwmgr)<br>
&#43;static int polaris10_avfs_event_mgr(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_smumgr *smu_da=
ta =3D (struct smu7_smumgr *)(hwmgr-&gt;smu_backend);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;avfs_supported)<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D polaris10_setup_graphics_level_structure(hwmgr),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;[AVFS][Polaris10_AVFSEventMgr] Could not Copy G=
raphics Level table over to SMU&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL);<br>
-- <br>
1.9.1<br>
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

--_000_DM5PR12MB18203465D2AC25E4CD08D3BEF7AB0DM5PR12MB1820namp_--

--===============0860504040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0860504040==--
