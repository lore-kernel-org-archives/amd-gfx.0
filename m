From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: enable SW SMU reset functionality
Date: Fri, 26 Jul 2019 01:03:54 +0000
Message-ID: <MN2PR12MB33446FE3CFFC12443A9FFB9CE4C00@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20190725023930.22521-1-evan.quan@amd.com>,
 <20190725023930.22521-2-evan.quan@amd.com>
 <MN2PR12MB3296605E0E8E85F415368D46A2C10@MN2PR12MB3296.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1116349750=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3296605E0E8E85F415368D46A2C10-rweVpJHSKTqAm9ToKNQgFgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============1116349750==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB33446FE3CFFC12443A9FFB9CE4C00MN2PR12MB3344namp_"

--_000_MN2PR12MB33446FE3CFFC12443A9FFB9CE4C00MN2PR12MB3344namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

It's a bug fix for uploading new pptable from sysfs.
And it's not hardware involved. The real hardware operation involved with t=
his is in smu_v11_0_enable_thermal_alert.
And in old powerplay routine, this is also put in sw_init and we do not fin=
d any problem with that until now.

Regards,
Evan
From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, July 25, 2019 9:08 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 2/2] drm/amd/powerplay: enable SW SMU reset functionali=
ty

I don't recommend that, because obviously this is a hardware operation, so =
why need to move it  into sw init?
Is this a workaround solution, or is it specific to which asic?
and set pptable from sysfs and do baco reset operation need to call these f=
unctions, have you test it?
the function in amdgpu_smu.c and smu_v11_0.c need work correctly in all asi=
c,
it needs to be done carefully, unless there is a good reason.

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:e=
van.quan-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, July 25, 2019 10:39 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH 2/2] drm/amd/powerplay: enable SW SMU reset functionality

Move SMU irq handler register to sw_init as that's totally
software related. Otherwise, it will prevent SMU reset working.

Change-Id: Ibd3e48ae9a90ab57f42b3f2ddbb736deeebc8715
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:evan.quan-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 6935a00cd389..a5079b93caa3 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -741,6 +741,12 @@ static int smu_sw_init(void *handle)
                 return ret;
         }

+       ret =3D smu_register_irq_handler(smu);
+       if (ret) {
+               pr_err("Failed to register smc irq handler!\n");
+               return ret;
+       }
+
         return 0;
 }

@@ -750,6 +756,9 @@ static int smu_sw_fini(void *handle)
         struct smu_context *smu =3D &adev->smu;
         int ret;

+       kfree(smu->irq_source);
+       smu->irq_source =3D NULL;
+
         ret =3D smu_smc_table_sw_fini(smu);
         if (ret) {
                 pr_err("Failed to sw fini smc table!\n");
@@ -1061,10 +1070,6 @@ static int smu_hw_init(void *handle)
         if (ret)
                 goto failed;

-       ret =3D smu_register_irq_handler(smu);
-       if (ret)
-               goto failed;
-
         if (!smu->pm_enabled)
                 adev->pm.dpm_enabled =3D false;
         else
@@ -1094,9 +1099,6 @@ static int smu_hw_fini(void *handle)
         kfree(table_context->overdrive_table);
         table_context->overdrive_table =3D NULL;

-       kfree(smu->irq_source);
-       smu->irq_source =3D NULL;
-
         ret =3D smu_fini_fb_allocations(smu);
         if (ret)
                 return ret;
--
2.22.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB33446FE3CFFC12443A9FFB9CE4C00MN2PR12MB3344namp_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
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
	margin:1.0in 1.25in 1.0in 1.25in;}
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
<p class=3D"MsoNormal">It&#8217;s a bug fix for uploading new pptable from =
sysfs.<o:p></o:p></p>
<p class=3D"MsoNormal">And it&#8217;s not hardware involved. The real hardw=
are operation involved with this is in smu_v11_0_enable_thermal_alert.<o:p>=
</o:p></p>
<p class=3D"MsoNormal">And in old powerplay routine, this is also put in sw=
_init and we do not find any problem with that until now.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.c=
om&gt; <br>
<b>Sent:</b> Thursday, July 25, 2019 9:08 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/powerplay: enable SW SMU reset func=
tionality<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"appendonsend">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I don't=
 recommend that, because obviously this is a
<b>hardware</b> <b>operation</b>, so why need to move it&nbsp; into <b>sw</=
b> <b>init</b>?<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Is this=
 a workaround solution, or is it specific to which asic?<o:p></o:p></span><=
/p>
</div>
</div>
<div id=3D"appendonsend">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">and set=
 pptable from sysfs and do baco reset operation need to call these function=
s, have you test it?<o:p></o:p></span></p>
</div>
<div id=3D"appendonsend">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">the fun=
ction in amdgpu_smu.c and smu_v11_0.c need work correctly in all asic,<o:p>=
</o:p></span></p>
</div>
<div id=3D"appendonsend">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">it need=
s to be done carefully, unless there is a good reason.<o:p></o:p></span></p=
>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
</div>
<div id=3D"appendonsend">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Best Re=
gards,<br>
Kevin<o:p></o:p></span></p>
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
f Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan-5C7GfCeVMHo@public.gmane.org</a>&=
gt;<br>
<b>Sent:</b> Thursday, July 25, 2019 10:39 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan@am=
d.com</a>&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/powerplay: enable SW SMU reset function=
ality</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">Move SMU irq handler register to sw_init as that's t=
otally<br>
software related. Otherwise, it will prevent SMU reset working.<br>
<br>
Change-Id: Ibd3e48ae9a90ab57f42b3f2ddbb736deeebc8715<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 16 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;1 file changed, 9 insertions(&#43;), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 6935a00cd389..a5079b93caa3 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -741,6 &#43;741,12 @@ static int smu_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_register_irq_handler(=
smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_err(&quot;Failed to register smc irq handler!\n&quot;);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -750,6 &#43;756,9 @@ static int smu_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D &amp;adev-&gt;smu;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu-&gt;irq_source);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;irq_source =3D NULL;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_smc_table_sw_f=
ini(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to sw fini smc table!\n&quot;);<b=
r>
@@ -1061,10 &#43;1070,6 @@ static int smu_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_register_irq_handler(smu)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto failed;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm_enabled =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
@@ -1094,9 &#43;1099,6 @@ static int smu_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(table_context-&gt;ov=
erdrive_table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;overdriv=
e_table =3D NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu-&gt;irq_source);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;irq_source =3D NULL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_fini_fb_alloca=
tions(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
-- <br>
2.22.0<br>
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

--_000_MN2PR12MB33446FE3CFFC12443A9FFB9CE4C00MN2PR12MB3344namp_--

--===============1116349750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1116349750==--
