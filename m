From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: show gfx clock gating status to user
Date: Thu, 5 Jan 2017 04:27:39 +0000
Message-ID: <CY4PR12MB1687087F6B8A456F9599F834FB600@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1483440426-22080-1-git-send-email-ray.huang@amd.com>
 <BN6PR12MB1652A908E7D3DAD0302D6217F76E0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170104022144.GA21218@hr-amur2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0057352920=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Fu, Ping" <Ping.Fu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>

--===============0057352920==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687087F6B8A456F9599F834FB600CY4PR12MB1687namp_"

--_000_CY4PR12MB1687087F6B8A456F9599F834FB600CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sorry, update.

User just need to know the cg/pg feature's state(enable/disable), not curre=
nt CG state.



Best Regards

Rex



-----Original Message-----
From: Zhu, Rex
Sent: Thursday, January 05, 2017 11:34 AM
To: Huang, Ray; Deucher, Alexander
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Mao, David; Fu, Ping
Subject: RE: [PATCH] drm/amdgpu: show gfx clock gating status to user



As talked with David. They not only need to know whether the CG/PG is suppo=
rted, but also need to know  those features state(enabled/disabled) (not cu=
rrent CG/PG state).



we added the profile mode, so in runtime, user can disable/enable cg.

Then user wanted to confirm the feature's state



So we may need to export cg/pg mask and feature's state.



Best Regards

Rex





-----Original Message-----

From: Huang Rui [mailto:ray.huang-5C7GfCeVMHo@public.gmane.org]

Sent: Wednesday, January 04, 2017 10:22 AM

To: Deucher, Alexander

Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Zh=
u, Rex; Mao, David; Fu, Ping

Subject: Re: [PATCH] drm/amdgpu: show gfx clock gating status to user



On Tue, Jan 03, 2017 at 11:02:09PM +0800, Deucher, Alexander wrote:

> > -----Original Message-----

> > From: Huang Rui [mailto:ray.huang-5C7GfCeVMHo@public.gmane.org]

> > Sent: Tuesday, January 03, 2017 5:47 AM

> > To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx@li=
sts.freedesktop.org>

> > Cc: Zhu, Rex; Mao, David; Fu, Ping; Huang, Ray

> > Subject: [PATCH] drm/amdgpu: show gfx clock gating status to user

> >

> > Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org<mailto:ray.huang-5C7GfCeVMHo@public.gmane.org>>

> > ---

> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 1 +

> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 5 +++++

> > drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c  | 2 ++

> > drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 2 ++

> > drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 3 +++

> >  5 files changed, 13 insertions(+)

> >

> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h

> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h

> > index 96eeea7..989d311 100644

> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h

> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h

> > @@ -1033,6 +1033,7 @@ struct amdgpu_gfx {

> >          struct amdgpu_irq_src              priv_inst_irq;

> >          /* gfx status */

> >          uint32_t                     gfx_current_status;

> > +          bool                             cg_enabled;

> >          /* ce ram size*/

> >          unsigned                     ce_ram_size;

> >          struct amdgpu_cu_info             cu_info;

> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c

> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c

> > index a7c7657..10f2eab 100644

> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c

> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c

> > @@ -1543,6 +1543,11 @@ static int amdgpu_debugfs_pm_info(struct

> > seq_file *m, void *data)

> >          struct amdgpu_device *adev =3D dev->dev_private;

> >          struct drm_device *ddev =3D adev->ddev;

> >

> > +          if (adev->gfx.cg_enabled)

> > +                   seq_printf(m, "GFX Clock Gating: Enabled\n");

> > +          else

> > +                   seq_printf(m, "GFX Clock Gating: Disabled\n");

> > +

>

>

> I think it would be better to print the cg_flags and pg_flags (both as a =
mask and in human readable form) so we know exactly cg and pg features are =
enabled.

>



It's probable better. Let me revise this patch and send it later.



Thanks,

Rui

--_000_CY4PR12MB1687087F6B8A456F9599F834FB600CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:8.0pt;
	font-family:"Calibri","sans-serif";}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Sorry, update.<o:p></o:p></s=
pan></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">User just need to know the c=
g/pg feature</span><span lang=3D"EN-US" style=3D"font-family:&quot;Courier =
New&quot;">&#8217;</span><span lang=3D"EN-US">s state(enable/disable), not =
current CG state.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Best Regards<o:p></o:p></spa=
n></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Rex<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">-----Original Message-----<b=
r>
From: Zhu, Rex <br>
Sent: Thursday, January 05, 2017 11:34 AM<br>
To: Huang, Ray; Deucher, Alexander<br>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Mao, David; Fu, Ping<br>
Subject: RE: [PATCH] drm/amdgpu: show gfx clock gating status to user</span=
></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">As talked with David. They n=
ot only need to know whether the CG/PG is supported, but also need to know =
&nbsp;<span style=3D"color:#00B050">those features state(enabled/disabled)
</span>(not <span style=3D"color:red">current CG/PG state)</span>. <o:p></o=
:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">we added the profile mode, s=
o in runtime, user can disable/enable cg.
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Then user wanted to confirm =
the feature</span><span lang=3D"EN-US" style=3D"font-family:&quot;Courier N=
ew&quot;">&#8217;</span><span lang=3D"EN-US">s state<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">So we may need to export cg/=
pg mask and feature</span><span lang=3D"EN-US" style=3D"font-family:&quot;C=
ourier New&quot;">&#8217;</span><span lang=3D"EN-US">s state.<o:p></o:p></s=
pan></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Best Regards<o:p></o:p></spa=
n></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Rex<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">-----Original Message-----<o=
:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">From: Huang Rui [<a href=3D"=
mailto:ray.huang-5C7GfCeVMHo@public.gmane.org"><span style=3D"color:windowtext;text-decoration:n=
one">mailto:ray.huang-5C7GfCeVMHo@public.gmane.org</span></a>]<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Sent: Wednesday, January 04,=
 2017 10:22 AM<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">To: Deucher, Alexander<o:p><=
/o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Cc: <a href=3D"mailto:amd-gf=
x@lists.freedesktop.org">
<span style=3D"color:windowtext;text-decoration:none">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</span></a>; Zhu, Rex; Mao, David; Fu, Ping<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Subject: Re: [PATCH] drm/amd=
gpu: show gfx clock gating status to user<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">On Tue, Jan 03, 2017 at 11:0=
2:09PM &#43;0800, Deucher, Alexander wrote:<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; -----Original Mess=
age-----<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; From: Huang Rui [<=
a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org"><span style=3D"color:windowtext;text-de=
coration:none">mailto:ray.huang-5C7GfCeVMHo@public.gmane.org</span></a>]<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; Sent: Tuesday, Jan=
uary 03, 2017 5:47 AM<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; To: Deucher, Alexa=
nder; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
<span style=3D"color:windowtext;text-decoration:none">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</span></a><o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; Cc: Zhu, Rex; Mao,=
 David; Fu, Ping; Huang, Ray<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; Subject: [PATCH] d=
rm/amdgpu: show gfx clock gating status to user<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; <o:p></o:p></span>=
</p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; Signed-off-by: Hua=
ng Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org"><span style=3D"color:window=
text;text-decoration:none">ray.huang-5C7GfCeVMHo@public.gmane.org</span></a>&gt;<o:p></o:p></spa=
n></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; ---<o:p></o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt;&nbsp; drivers/gpu/=
drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp; | 1 &#43;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt;&nbsp; drivers/gpu/=
drm/amd/amdgpu/amdgpu_pm.c | 5 &#43;&#43;&#43;&#43;&#43;
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; drivers/gpu/drm/am=
d/amdgpu/gfx_v6_0.c&nbsp; | 2 &#43;&#43;
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; drivers/gpu/drm/am=
d/amdgpu/gfx_v7_0.c&nbsp; | 2 &#43;&#43;
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; drivers/gpu/drm/am=
d/amdgpu/gfx_v8_0.c&nbsp; | 3 &#43;&#43;&#43;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt;&nbsp; 5 files chan=
ged, 13 insertions(&#43;)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; <o:p></o:p></span>=
</p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; diff --git a/drive=
rs/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; b/drivers/gpu/drm/=
amd/amdgpu/amdgpu.h<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; index 96eeea7..989=
d311 100644<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; --- a/drivers/gpu/=
drm/amd/amdgpu/amdgpu.h<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; &#43;&#43;&#43; b/=
drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; @@ -1033,6 &#43;10=
33,7 @@ struct amdgpu_gfx {<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt;&nbsp; &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv_inst_irq;<o:p>=
</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt;&nbsp; &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gfx status */<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt;&nbsp; &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; gfx_current_status;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; &#43;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cg_enabled=
;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt;&nbsp; &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ce ram size*/<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt;&nbsp; &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; ce_ram_size;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt;&nbsp; &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_cu_info&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu_info;<o:p></o:p></span=
></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; diff --git a/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_pm.c<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_pm.c<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; index a7c7657..10f=
2eab 100644<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; --- a/drivers/gpu/=
drm/amd/amdgpu/amdgpu_pm.c<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; &#43;&#43;&#43; b/=
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; @@ -1543,6 &#43;15=
43,11 @@ static int amdgpu_debugfs_pm_info(struct
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; seq_file *m, void =
*data)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt;&nbsp; &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev-&gt;dev_p=
rivate;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt;&nbsp; &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D adev-&gt;ddev;<o=
:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; <o:p></o:p></span>=
</p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; &#43;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.cg_enabled)<o:p>=
</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; &#43;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;GFX Clock Gating: Enabled\n&quot;)=
;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; &#43;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; &#43;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;GFX Clock Gating: Disabled\n&quot;=
);<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; &gt; &#43;<o:p></o:p></=
span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; <o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; <o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; I think it would be bet=
ter to print the cg_flags and pg_flags (both as a mask and in human readabl=
e form) so we know exactly cg and pg features are enabled.<o:p></o:p></span=
></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&gt; <o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">It's probable better. Let me=
 revise this patch and send it later.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Thanks,<o:p></o:p></span></p=
>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Rui<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_CY4PR12MB1687087F6B8A456F9599F834FB600CY4PR12MB1687namp_--

--===============0057352920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0057352920==--
