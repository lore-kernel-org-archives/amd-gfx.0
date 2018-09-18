From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/dc: Trigger set power state task when display
 configuration changes
Date: Tue, 18 Sep 2018 05:44:37 +0000
Message-ID: <BYAPR12MB277585FBE856647226005A97FB1D0@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <1536904627-24761-1-git-send-email-Rex.Zhu@amd.com>
 <BN6PR12MB18096D890B7032FC56F79958F7190@BN6PR12MB1809.namprd12.prod.outlook.com>,
 <BYAPR12MB27753088DE039984D6D4D3DAFB1E0@BYAPR12MB2775.namprd12.prod.outlook.com>
 <DM3PR1201MB1039DB50BA9374E4D92470D5EF1E0@DM3PR1201MB1039.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0598470281=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM3PR1201MB1039DB50BA9374E4D92470D5EF1E0-BBcFnVpqZhVMmo+XJk11QmrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0598470281==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB277585FBE856647226005A97FB1D0BYAPR12MB2775namp_"

--_000_BYAPR12MB277585FBE856647226005A97FB1D0BYAPR12MB2775namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi David,

Yes, There is an issue you pointed out on Raven. Because the force_dpm_leve=
l was added for UMD-P state and the min clocks were hardcode. The display's=
 clock requests were ignored.
I will fix this issue.
Thanks.

Best Regards
Rex

From: Francis, David
Sent: Monday, September 17, 2018 9:31 PM
To: Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexander.Deucher@amd.c=
om>; Wentland, Harry <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/dc: Trigger set power state task when display =
configuration changes


On Linux, the clocks are already set by the time that function call is reac=
hed.  amdgpu_pm_compute clocks resets the clocks to their default value.

________________________________
From: Zhu, Rex
Sent: September 17, 2018 4:12:33 AM
To: Deucher, Alexander; Wentland, Harry; Francis, David
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: RE: [PATCH] drm/amd/dc: Trigger set power state task when display =
configuration changes


+Harry and David.



Best Regards

Rex



From: Deucher, Alexander
Sent: Friday, September 14, 2018 9:40 PM
To: Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>>; amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amd/dc: Trigger set power state task when display =
configuration changes



Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deucher@=
amd.com>>

________________________________

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Z=
hu-5C7GfCeVMHo@public.gmane.org>>
Sent: Friday, September 14, 2018 1:57:07 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Zhu, Rex
Subject: [PATCH] drm/amd/dc: Trigger set power state task when display conf=
iguration changes



Revert "drm/amd/display: Remove call to amdgpu_pm_compute_clocks"

This reverts commit dcd473770e86517543691bdb227103d6c781cd0a.

when display configuration changes, dc need to update the changes
to powerplay, also need to trigger a power state task.
amdgpu_pm_compute_clocks is the interface to set power state task
either dpm enabled or powerplay enabled

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 6d16b4a..0fab64a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -105,6 +105,8 @@ bool dm_pp_apply_display_requirements(
                         adev->powerplay.pp_funcs->display_configuration_ch=
ange(
                                 adev->powerplay.pp_handle,
                                 &adev->pm.pm_display_cfg);
+
+               amdgpu_pm_compute_clocks(adev);
         }

         return true;
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BYAPR12MB277585FBE856647226005A97FB1D0BYAPR12MB2775namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal0, li.xmsonormal0, div.xmsonormal0
	{mso-style-name:x_msonormal0;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsochpdefault, li.xmsochpdefault, div.xmsochpdefault
	{mso-style-name:x_msochpdefault;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.xemailstyle20
	{mso-style-name:x_emailstyle20;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi David,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yes, There is an issue you pointed out on Raven. Bec=
ause the force_dpm_level was added for UMD-P state and the min clocks were =
hardcode. The display&#8217;s clock requests were ignored.
<o:p></o:p></p>
<p class=3D"MsoNormal">I will fix this issue.<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Rex &nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Francis, David <br>
<b>Sent:</b> Monday, September 17, 2018 9:31 PM<br>
<b>To:</b> Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Alexander &lt;Alexand=
er.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Wentland, Harry &lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/dc: Trigger set power state task when d=
isplay configuration changes<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">On Linux, the clocks are al=
ready set by the time that function call is reached.&nbsp; amdgpu_pm_comput=
e clocks resets the clocks to their default value.<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"3" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Zhu, Rex<br>
<b>Sent:</b> September 17, 2018 4:12:33 AM<br>
<b>To:</b> Deucher, Alexander; Wentland, Harry; Francis, David<br>
<b>Cc:</b> </span><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@=
lists.freedesktop.org</a><span style=3D"color:black"><br>
<b>Subject:</b> RE: [PATCH] drm/amd/dc: Trigger set power state task when d=
isplay configuration changes</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal">&#43;Harry and David.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Best Regards<o:p></o:p></p>
<p class=3D"xmsonormal">Rex<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> Deucher, Alexander <br>
<b>Sent:</b> Friday, September 14, 2018 9:40 PM<br>
<b>To:</b> Zhu, Rex &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">Rex.Zhu-5C7GfCeVMHo@public.gmane.org<=
/a>&gt;; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/dc: Trigger set power state task when d=
isplay configuration changes<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Acked-by: Alex Deucher &lt;=
</span><a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"><span style=3D"font-siz=
e:12.0pt">alexander.deucher-5C7GfCeVMHo@public.gmane.org</span></a><span style=3D"font-size:12.0=
pt;color:black">&gt;</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"3" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"color:black">From:</span></b><spa=
n style=3D"color:black"> amd-gfx &lt;</span><a href=3D"mailto:amd-gfx-bounc=
es-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><span st=
yle=3D"color:black">&gt; on behalf of Rex Zhu &lt;</span><a href=3D"mailto:=
Rex.Zhu-5C7GfCeVMHo@public.gmane.org">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;<br>
<b>Sent:</b> Friday, September 14, 2018 1:57:07 AM<br>
<b>To:</b> </span><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@=
lists.freedesktop.org</a><span style=3D"color:black"><br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/dc: Trigger set power state task when displ=
ay configuration changes</span>
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal">Revert &quot;drm/amd/display: Remove call to amdgpu=
_pm_compute_clocks&quot;<br>
<br>
This reverts commit dcd473770e86517543691bdb227103d6c781cd0a.<br>
<br>
when display configuration changes, dc need to update the changes<br>
to powerplay, also need to trigger a power state task.<br>
amdgpu_pm_compute_clocks is the interface to set power state task<br>
either dpm enabled or powerplay enabled<br>
<br>
Signed-off-by: Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">Rex.Zhu@amd.c=
om</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 2 &#43;&#4=
3;<br>
&nbsp;1 file changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c<br>
index 6d16b4a..0fab64a 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c<=
br>
@@ -105,6 &#43;105,8 @@ bool dm_pp_apply_display_requirements(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;powerplay.pp_funcs-&gt;display_configuration_change(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_handle,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;pm.pm_display_cfg)=
;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_pm_compute_clocks(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB277585FBE856647226005A97FB1D0BYAPR12MB2775namp_--

--===============0598470281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0598470281==--
