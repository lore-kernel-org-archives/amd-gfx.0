From: "Liang, Prike" <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/5] drm/amd/powerplay: bypass dpm_context null pointer
 check guard for some smu series
Date: Tue, 24 Sep 2019 03:28:03 +0000
Message-ID: <MN2PR12MB35362883856A74A2E25C5182FB840@MN2PR12MB3536.namprd12.prod.outlook.com>
References: <1569228167-3120-1-git-send-email-Prike.Liang@amd.com>
 <MN2PR12MB3296B10F5F4A601EC54B405BA2850@MN2PR12MB3296.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0997460981=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3296B10F5F4A601EC54B405BA2850-rweVpJHSKTqAm9ToKNQgFgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "arron.liu-5C7GfCeVMHo@public.gmane.org" <arron.liu-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>

--===============0997460981==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB35362883856A74A2E25C5182FB840MN2PR12MB3536namp_"

--_000_MN2PR12MB35362883856A74A2E25C5182FB840MN2PR12MB3536namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

That's a good point for simplifying  the code and will send another patch f=
or this.

Thanks,
Prike
From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, September 23, 2019 5:22 PM
To: Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: arron.liu-5C7GfCeVMHo@public.gmane.org; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Qua=
n@amd.com>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amd/powerplay: bypass dpm_context null pointer=
 check guard for some smu series

the smu driver many place will use AMD_IS_APU flags,
i think we'd better add a new member "is_apu" in smu_context"

Best Regards,
kevin

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org<mai=
lto:Prike.Liang-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, September 23, 2019 4:43 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: arron.liu-5C7GfCeVMHo@public.gmane.org<mailto:arron.liu-5C7GfCeVMHo@public.gmane.org> <arron.liu-5C7GfCeVMHo@public.gmane.org<mailto:a=
rron.liu-5C7GfCeVMHo@public.gmane.org>>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org<mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org>=
>; Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org<mailto:Prike.Liang-5C7GfCeVMHo@public.gmane.org>>; Quan, Ev=
an <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; Feng, Kenneth <Kenneth.Fe=
ng-5C7GfCeVMHo@public.gmane.org<mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH 1/5] drm/amd/powerplay: bypass dpm_context null pointer che=
ck guard for some smu series

For now APU has no smu_dpm_context structure for containing default/current=
 related dpm table,
thus will not initialize smu_dpm_context and aviod null pointer check guard=
 for APU.

Signed-off-by: Prike Liang <Prike.Liang-5C7GfCeVMHo@public.gmane.org<mailto:Prike.Liang-5C7GfCeVMHo@public.gmane.org>=
>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 90fa444..3afd2cd 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1554,7 +1554,9 @@ static int smu_enable_umd_pstate(void *handle,

         struct smu_context *smu =3D (struct smu_context*)(handle);
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
-       if (!smu->pm_enabled || !smu_dpm_ctx->dpm_context)
+       struct amdgpu_device *adev =3D smu->adev;
+
+       if (!(adev->flags & AMD_IS_APU) && (!smu->pm_enabled || !smu_dpm_ct=
x->dpm_context))
                 return -EINVAL;

         if (!(smu_dpm_ctx->dpm_level & profile_mode_mask)) {
@@ -1751,8 +1753,9 @@ enum amd_dpm_forced_level smu_get_performance_level(s=
truct smu_context *smu)
 {
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
         enum amd_dpm_forced_level level;
+       struct amdgpu_device *adev =3D smu->adev;

-       if (!smu_dpm_ctx->dpm_context)
+       if (!(adev->flags & AMD_IS_APU) && !smu_dpm_ctx->dpm_context)
                 return -EINVAL;

         mutex_lock(&(smu->mutex));
@@ -1766,8 +1769,9 @@ int smu_force_performance_level(struct smu_context *s=
mu, enum amd_dpm_forced_lev
 {
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
         int ret =3D 0;
+       struct amdgpu_device *adev =3D smu->adev;

-       if (!smu_dpm_ctx->dpm_context)
+       if (!(adev->flags & AMD_IS_APU) && !smu_dpm_ctx->dpm_context)
                 return -EINVAL;

         ret =3D smu_enable_umd_pstate(smu, &level);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB35362883856A74A2E25C5182FB840MN2PR12MB3536namp_
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
span.EmailStyle20
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
<p class=3D"MsoNormal">That&#8217;s a good point for simplifying &nbsp;the =
code and will send another patch for this.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Prike<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.c=
om&gt; <br>
<b>Sent:</b> Monday, September 23, 2019 5:22 PM<br>
<b>To:</b> Liang, Prike &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org<br>
<b>Cc:</b> arron.liu-5C7GfCeVMHo@public.gmane.org; Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Quan, E=
van &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;<b=
r>
<b>Subject:</b> Re: [PATCH 1/5] drm/amd/powerplay: bypass dpm_context null =
pointer check guard for some smu series<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">the smu=
 driver many place will use AMD_IS_APU flags,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">i think=
 we'd better add a new member &quot;is_apu&quot; in smu_context&quot;<o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Best Re=
gards,<br>
kevin<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f Liang, Prike &lt;<a href=3D"mailto:Prike.Liang-5C7GfCeVMHo@public.gmane.org">Prike.Liang@amd.c=
om</a>&gt;<br>
<b>Sent:</b> Monday, September 23, 2019 4:43 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:arron.liu-5C7GfCeVMHo@public.gmane.org">arron.liu-5C7GfCeVMHo@public.gmane.org</a> &lt;<=
a href=3D"mailto:arron.liu-5C7GfCeVMHo@public.gmane.org">arron.liu-5C7GfCeVMHo@public.gmane.org</a>&gt;; Huang, Ray &=
lt;<a href=3D"mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org">Ray.Huang-5C7GfCeVMHo@public.gmane.org</a>&gt;; Liang, P=
rike &lt;<a href=3D"mailto:Prike.Liang-5C7GfCeVMHo@public.gmane.org">Prike.Liang-5C7GfCeVMHo@public.gmane.org</a>&gt;=
;
 Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan-5C7GfCeVMHo@public.gmane.org</a>&=
gt;; Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org">Kenneth.Feng=
@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 1/5] drm/amd/powerplay: bypass dpm_context null poin=
ter check guard for some smu series</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">For now APU has no smu_dpm_context structure for con=
taining default/current related dpm table,<br>
thus will not initialize smu_dpm_context and aviod null pointer check guard=
 for APU.<br>
<br>
Signed-off-by: Prike Liang &lt;<a href=3D"mailto:Prike.Liang-5C7GfCeVMHo@public.gmane.org">Prike=
.Liang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 10 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;---<br>
&nbsp;1 file changed, 7 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 90fa444..3afd2cd 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1554,7 &#43;1554,9 @@ static int smu_enable_umd_pstate(void *handle,<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D (struct smu_context*)(handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu_dpm_c=
tx-&gt;dpm_context)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D sm=
u-&gt;adev;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS=
_APU) &amp;&amp; (!smu-&gt;pm_enabled || !smu_dpm_ctx-&gt;dpm_context))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(smu_dpm_ctx-&gt;dpm_=
level &amp; profile_mode_mask)) {<br>
@@ -1751,8 &#43;1753,9 @@ enum amd_dpm_forced_level smu_get_performance_lev=
el(struct smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level =
level;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D sm=
u-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_dpm_ctx-&gt;dpm_context)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS=
_APU) &amp;&amp; !smu_dpm_ctx-&gt;dpm_context)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;(smu-&gt;m=
utex));<br>
@@ -1766,8 &#43;1769,9 @@ int smu_force_performance_level(struct smu_contex=
t *smu, enum amd_dpm_forced_lev<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D sm=
u-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_dpm_ctx-&gt;dpm_context)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS=
_APU) &amp;&amp; !smu_dpm_ctx-&gt;dpm_context)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_enable_umd_pst=
ate(smu, &amp;level);<br>
-- <br>
2.7.4<br>
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
</body>
</html>

--_000_MN2PR12MB35362883856A74A2E25C5182FB840MN2PR12MB3536namp_--

--===============0997460981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0997460981==--
