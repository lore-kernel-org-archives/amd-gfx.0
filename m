From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device
 initialization
Date: Mon, 26 Nov 2018 16:20:36 +0000
Message-ID: <BN6PR12MB16515D3CE1A39EA3501EBC0880D70@BN6PR12MB1651.namprd12.prod.outlook.com>
References: <1542815518-8124-1-git-send-email-ozeng@amd.com>
 <1542815518-8124-5-git-send-email-ozeng@amd.com>
 <CADnq5_PKauwpBumDu8CigT33vC2QSMUCvTw0wzxd1_11LfoiUg@mail.gmail.com>
 <CADnq5_O-ajV9xMFF5BsKUei48LLY1dGV3C_i+oDy+5J+Y2VwHA@mail.gmail.com>,
 <BN6PR12MB165183EC3AAC7436C0E6846C80D70@BN6PR12MB1651.namprd12.prod.outlook.com>,
 <BN6PR12MB1809D7A7892DC1A246F47750F7D70@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BN6PR12MB180989D8B99769C89F6F710FF7D70@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1071392123=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB180989D8B99769C89F6F710FF7D70-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1071392123==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16515D3CE1A39EA3501EBC0880D70BN6PR12MB1651namp_"

--_000_BN6PR12MB16515D3CE1A39EA3501EBC0880D70BN6PR12MB1651namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

That is good idea. Will do it.

thanks,
Oak

From: Deucher, Alexander
Sent: Monday, November 26, 2018 11:02 AM
To: Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>; Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device ini=
tialization


Maybe it would be better to add this as a callback to struct amdgpu_asic_fu=
ncs to avoid adding asic specific code to amdgpu_device.c



Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Deucher, Alexander <Alexander.Deucher=
@amd.com<mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, November 26, 2018 10:59:02 AM
To: Zeng, Oak; Alex Deucher
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device ini=
tialization


Ah, ok.  no problem.



Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org<mailto:Oa=
k.Zeng-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, November 26, 2018 10:31:04 AM
To: Alex Deucher
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: RE: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device ini=
tialization

Yes, that was my first version. But during debug, I found amdgpu_device_doo=
rbell_init uses adev->doorbell_index.max_assignment which is initialized in=
 *_doorbell_index_init. So I have to call *_doorbell_index_init before amdg=
pu_device_doorbell_init. *_set_ip_blocks() is too late.

In a later version, I moved calling of *_doorbell_index_init to the top of =
amdgpu_device_doorbell_init.

thanks,
Oak

-----Original Message-----
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Sunday, November 25, 2018 1:43 PM
To: Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org<mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org>>
Subject: Fwd: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device in=
itialization

---------- Forwarded message ---------
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Date: Wed, Nov 21, 2018 at 11:21 AM
Subject: Re: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device ini=
tialization
To: <ozeng-5C7GfCeVMHo@public.gmane.org<mailto:ozeng-5C7GfCeVMHo@public.gmane.org>>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org>>, Oak Zeng <Oak.Zeng-5C7GfCeVMHo@public.gmane.org<mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org>>


On Wed, Nov 21, 2018 at 10:52 AM Oak Zeng <ozeng-5C7GfCeVMHo@public.gmane.org<mailto:ozeng@amd.c=
om>> wrote:
>
> Change-Id: I2f004bbbe2565035460686f4fc16e86b77a2a9b5
> Signed-off-by: Oak Zeng <ozeng-5C7GfCeVMHo@public.gmane.org<mailto:ozeng-5C7GfCeVMHo@public.gmane.org>>
> Suggested-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mailto:Felix.Kuehlin=
g@amd.com>>
> Suggested-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.de=
ucher-5C7GfCeVMHo@public.gmane.org>>

I think it would be cleaner to add this to the *_set_ip_blocks() functions =
in cik.c, vi.c, and soc15.c so it aligns with the
*_reg_base_init() calls.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cb06e68..a942a88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -513,6 +513,13 @@ void amdgpu_device_pci_config_reset(struct amdgpu_de=
vice *adev)
>   */
>  static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)  {
> +       if (adev->asic_type < CHIP_VEGA10)
> +               vi_doorbell_index_init(adev);
> +       else if (adev->asic_type =3D=3D CHIP_VEGA10)
> +               vega10_doorbell_index_init(adev);
> +       else
> +               vega12_doorbell_index_init(adev);
> +
>         /* No doorbell on SI hardware generation */
>         if (adev->asic_type < CHIP_BONAIRE) {
>                 adev->doorbell.base =3D 0;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16515D3CE1A39EA3501EBC0880D70BN6PR12MB1651namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
<p class=3D"MsoNormal">That is good idea. Will do it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Oak<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander <br>
<b>Sent:</b> Monday, November 26, 2018 11:02 AM<br>
<b>To:</b> Zeng, Oak &lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;; Alex Deucher &lt;alexdeucher=
@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 5/7] drm/amdgpu: Call doorbell index init on dev=
ice initialization<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Maybe it would be better to=
 add this as a callback to struct amdgpu_asic_funcs to avoid adding asic sp=
ecific code to amdgpu_device.c<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Alexa=
nder.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Monday, November 26, 2018 10:59:02 AM<br>
<b>To:</b> Zeng, Oak; Alex Deucher<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Subject:</b> Re: [PATCH 5/7] drm/amdgpu: Call doorbell index init on dev=
ice initialization</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Ah, ok.&nbsp; no problem.<o=
:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f Zeng, Oak &lt;<a href=3D"mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org">Oak.Zeng-5C7GfCeVMHo@public.gmane.org</a>&gt=
;<br>
<b>Sent:</b> Monday, November 26, 2018 10:31:04 AM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Subject:</b> RE: [PATCH 5/7] drm/amdgpu: Call doorbell index init on dev=
ice initialization</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">Yes, that was my first version. But during debug, I =
found amdgpu_device_doorbell_init uses adev-&gt;doorbell_index.max_assignme=
nt which is initialized in *_doorbell_index_init. So I have to call *_doorb=
ell_index_init before amdgpu_device_doorbell_init.
 *_set_ip_blocks() is too late.<br>
<br>
In a later version, I moved calling of *_doorbell_index_init to the top of =
amdgpu_device_doorbell_init.<br>
<br>
thanks,<br>
Oak<br>
<br>
-----Original Message-----<br>
From: Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher=
@gmail.com</a>&gt;
<br>
Sent: Sunday, November 25, 2018 1:43 PM<br>
To: Zeng, Oak &lt;<a href=3D"mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org">Oak.Zeng-5C7GfCeVMHo@public.gmane.org</a>&=
gt;<br>
Subject: Fwd: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device in=
itialization<br>
<br>
---------- Forwarded message ---------<br>
From: Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher=
@gmail.com</a>&gt;<br>
Date: Wed, Nov 21, 2018 at 11:21 AM<br>
Subject: Re: [PATCH 5/7] drm/amdgpu: Call doorbell index init on device ini=
tialization<br>
To: &lt;<a href=3D"mailto:ozeng-5C7GfCeVMHo@public.gmane.org">ozeng-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Cc: amd-gfx list &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-g=
fx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;, Oak Zeng &lt;<a href=3D"mailto:Oak.Zeng@a=
md.com">Oak.Zeng-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
<br>
On Wed, Nov 21, 2018 at 10:52 AM Oak Zeng &lt;<a href=3D"mailto:ozeng@amd.c=
om">ozeng-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Change-Id: I2f004bbbe2565035460686f4fc16e86b77a2a9b5<br>
&gt; Signed-off-by: Oak Zeng &lt;<a href=3D"mailto:ozeng-5C7GfCeVMHo@public.gmane.org">ozeng@amd=
.com</a>&gt;<br>
&gt; Suggested-by: Felix Kuehling &lt;<a href=3D"mailto:Felix.Kuehling@amd.=
com">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Suggested-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd=
.com">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
I think it would be cleaner to add this to the *_set_ip_blocks() functions =
in cik.c, vi.c, and soc15.c so it aligns with the<br>
*_reg_base_init() calls.<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 7 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index cb06e68..a942a88 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -513,6 &#43;513,13 @@ void amdgpu_device_pci_config_reset(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; static int amdgpu_device_doorbell_init(struct amdgpu_device *ade=
v)&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &lt; =
CHIP_VEGA10)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vi_doorbell_index_init(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;asic_type =
=3D=3D CHIP_VEGA10)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vega10_doorbell_index_init(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vega12_doorbell_index_init(adev);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No doorbell on SI h=
ardware generation */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type=
 &lt; CHIP_BONAIRE) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell.base =3D 0;<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
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

--_000_BN6PR12MB16515D3CE1A39EA3501EBC0880D70BN6PR12MB1651namp_--

--===============1071392123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1071392123==--
