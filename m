From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/3] drm/amd/amdgpu: Add wave reader to debugfs
Date: Fri, 14 Oct 2016 13:33:11 +0000
Message-ID: <MWHPR12MB16942B1E36EC312FA807A250F7DF0@MWHPR12MB1694.namprd12.prod.outlook.com>
References: <20161011191815.2097-1-tom.stdenis@amd.com>
 <20161011191815.2097-2-tom.stdenis@amd.com>,
 <74d8807b-fb6b-d249-3c6a-2eba72fa73a3@gmail.com>
 <CY4PR12MB1768E88741EB80464DC9151DF7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0614517058=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1768E88741EB80464DC9151DF7DF0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Nicolai_H=E4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0614517058==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB16942B1E36EC312FA807A250F7DF0MWHPR12MB1694namp_"

--_000_MWHPR12MB16942B1E36EC312FA807A250F7DF0MWHPR12MB1694namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

You could make the wave decode a gfx callback and move the code into the IP=
 modules.

Alex

From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of S=
tDenis, Tom
Sent: Friday, October 14, 2016 6:56 AM
To: Nicolai H=E4hnle
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/3] drm/amd/amdgpu: Add wave reader to debugfs


Hi Nicolai,



I was trying to avoid having ASIC specific includes/etc in the amdgpu_devic=
e.c file.  Agreed that de-numberifying it would be nice.  Maybe we can add =
some /**/ comments to clear it up.  I imagine in the future we'll add more =
fields (upto 32 in this design) anyways.



Cheers,

Tom

________________________________
From: Nicolai H=E4hnle <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Friday, October 14, 2016 03:25
To: Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org>
Cc: StDenis, Tom
Subject: Re: [PATCH 1/3] drm/amd/amdgpu: Add wave reader to debugfs

On 11.10.2016 21:18, Tom St Denis wrote:
> Currently supports CZ/VI.  Allows nearly atomic read
> of wave data from GPU.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org<mailto:tom.stdenis@amd.c=
om>>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 74 ++++++++++++++++++++++++=
++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 89b353418195..b1ab6358fa0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2914,6 +2914,72 @@ static ssize_t amdgpu_debugfs_sensor_read(struct f=
ile *f, char __user *buf,
>        return !r ? 4 : r;
>  }
>
> +static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t SQ_IN=
DEX, uint32_t SQ_DATA, uint32_t simd, uint32_t wave, uint32_t address)
> +{
> +     WREG32(SQ_INDEX, (wave & 0xF) | ((simd & 0x3) << 4) | (address << 1=
6) | (1 << 13));
> +     return RREG32(SQ_DATA);
> +}
> +
> +static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf=
,
> +                                     size_t size, loff_t *pos)
> +{
> +     struct amdgpu_device *adev =3D f->f_inode->i_private;
> +     int r, x;
> +     ssize_t result=3D0;
> +     uint32_t offset, se, sh, cu, wave, simd, data[16];
> +
> +     if (size & 3 || *pos & 3)
> +             return -EINVAL;
> +
> +     /* decode offset */
> +     offset =3D (*pos & 0x7F);
> +     se =3D ((*pos >> 7) & 0xFF);
> +     sh =3D ((*pos >> 15) & 0xFF);
> +     cu =3D ((*pos >> 23) & 0xFF);
> +     wave =3D ((*pos >> 31) & 0xFF);
> +     simd =3D ((*pos >> 37) & 0xFF);
> +     *pos &=3D 0x7F;
> +
> +     /* switch to the specific se/sh/cu */
> +     mutex_lock(&adev->grbm_idx_mutex);
> +     amdgpu_gfx_select_se_sh(adev, se, sh, cu);
> +
> +     x =3D 0;
> +     if (adev->family =3D=3D AMDGPU_FAMILY_CZ || adev->family =3D=3D AMD=
GPU_FAMILY_VI) {
> +             /* type 0 wave data */
> +             data[x++] =3D 0;
> +             data[x++] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x12);
> +             data[x++] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x18);
> +             data[x++] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x19);
> +             data[x++] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x27E);
> +             data[x++] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x27F);
> +             data[x++] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x14);
> +             data[x++] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x1A);
> +             data[x++] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x1B);

I know this is just debug code, but it's still annoying to have all
these magic constants here, when there are perfectly good ixSQ_WAVE_*
etc. defines in the asic_reg headers.

Nicolai

> +     } else {
> +             return -EINVAL;
> +     }
> +
> +     amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
> +     mutex_unlock(&adev->grbm_idx_mutex);
> +
> +     while (size && (*pos < x * 4)) {
> +             uint32_t value;
> +
> +             value =3D data[*pos >> 2];
> +             r =3D put_user(value, (uint32_t *)buf);
> +             if (r)
> +                     return r;
> +
> +             result +=3D 4;
> +             buf +=3D 4;
> +             *pos +=3D 4;
> +             size -=3D 4;
> +     }
> +
> +     return result;
> +}
> +
>  static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>        .owner =3D THIS_MODULE,
>        .read =3D amdgpu_debugfs_regs_read,
> @@ -2951,6 +3017,12 @@ static const struct file_operations amdgpu_debugfs=
_sensors_fops =3D {
>        .llseek =3D default_llseek
>  };
>
> +static const struct file_operations amdgpu_debugfs_wave_fops =3D {
> +     .owner =3D THIS_MODULE,
> +     .read =3D amdgpu_debugfs_wave_read,
> +     .llseek =3D default_llseek
> +};
> +
>  static const struct file_operations *debugfs_regs[] =3D {
>        &amdgpu_debugfs_regs_fops,
>        &amdgpu_debugfs_regs_didt_fops,
> @@ -2958,6 +3030,7 @@ static const struct file_operations *debugfs_regs[]=
 =3D {
>        &amdgpu_debugfs_regs_smc_fops,
>        &amdgpu_debugfs_gca_config_fops,
>        &amdgpu_debugfs_sensors_fops,
> +     &amdgpu_debugfs_wave_fops,
>  };
>
>  static const char *debugfs_regs_names[] =3D {
> @@ -2967,6 +3040,7 @@ static const char *debugfs_regs_names[] =3D {
>        "amdgpu_regs_smc",
>        "amdgpu_gca_config",
>        "amdgpu_sensors",
> +     "amdgpu_wave",
>  };
>
>  static int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>

--_000_MWHPR12MB16942B1E36EC312FA807A250F7DF0MWHPR12MB1694namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">You could make the wave d=
ecode a gfx callback and move the code into the IP modules.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Alex<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx =
[mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]
<b>On Behalf Of </b>StDenis, Tom<br>
<b>Sent:</b> Friday, October 14, 2016 6:56 AM<br>
<b>To:</b> Nicolai H=E4hnle<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amd/amdgpu: Add wave reader to debugfs<=
o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Hi Nicolai,<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">I was trying to avoid having ASIC specific includes/etc in the a=
mdgpu_device.c file. &nbsp;Agreed that de-numberifying it would be nice. &n=
bsp;Maybe we can add some /**/ comments to clear it up. &nbsp;I imagine
 in the future we'll add more fields (upto 32 in this design) anyways.<o:p>=
</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Cheers,<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Tom<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</=
o:p></span></p>
<div>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:black"> Nicolai H=E4hnle &lt;<a href=3D"mailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
">nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 03:25<br>
<b>To:</b> Tom St Denis; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">a=
md-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amd/amdgpu: Add wave reader to debugfs<=
/span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;=
;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">&nbsp;<o:p></o:p></span></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">On 11.10.2016 21:18, Tom St=
 Denis wrote:<br>
&gt; Currently supports CZ/VI.&nbsp; Allows nearly atomic read<br>
&gt; of wave data from GPU.<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org"=
>tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 74 &#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 74 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 89b353418195..b1ab6358fa0f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2914,6 &#43;2914,72 @@ static ssize_t amdgpu_debugfs_sensor_read(s=
truct file *f, char __user *buf,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !r ? 4 : r;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_=
t SQ_INDEX, uint32_t SQ_DATA, uint32_t simd, uint32_t wave, uint32_t addres=
s)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SQ_INDEX, (wave &amp; 0xF) | ((si=
md &amp; 0x3) &lt;&lt; 4) | (address &lt;&lt; 16) | (1 &lt;&lt; 13));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32(SQ_DATA);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __us=
er *buf,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; size_t size, loff_t *pos)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D f-&gt;f_i=
node-&gt;i_private;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int r, x;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t result=3D0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t offset, se, sh, cu, wave, simd,=
 data[16];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (size &amp; 3 || *pos &amp; 3)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* decode offset */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D (*pos &amp; 0x7F);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; se =3D ((*pos &gt;&gt; 7) &amp; 0xFF);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sh =3D ((*pos &gt;&gt; 15) &amp; 0xFF);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; cu =3D ((*pos &gt;&gt; 23) &amp; 0xFF);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; wave =3D ((*pos &gt;&gt; 31) &amp; 0xFF)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; simd =3D ((*pos &gt;&gt; 37) &amp; 0xFF)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; *pos &amp;=3D 0x7F;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* switch to the specific se/sh/cu */<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;grbm_idx_mutex)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_select_se_sh(adev, se, sh, cu=
);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; x =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;family =3D=3D AMDGPU_FAMILY=
_CZ || adev-&gt;family =3D=3D AMDGPU_FAMILY_VI) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* type 0 wave data */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data[x&#43;&#43;] =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data[x&#43;&#43;] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x12);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data[x&#43;&#43;] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x18);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data[x&#43;&#43;] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x19);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data[x&#43;&#43;] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x27E);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data[x&#43;&#43;] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x27F);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data[x&#43;&#43;] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x14);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data[x&#43;&#43;] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x1A);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data[x&#43;&#43;] =3D wave_read_ind(adev, 0x2378, 0x2379, simd, wav=
e, 0x1B);<br>
<br>
I know this is just debug code, but it's still annoying to have all <br>
these magic constants here, when there are perfectly good ixSQ_WAVE_* <br>
etc. defines in the asic_reg headers.<br>
<br>
Nicolai<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF=
, 0xFFFFFFFF, 0xFFFFFFFF);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;grbm_idx_mute=
x);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; while (size &amp;&amp; (*pos &lt; x * 4)=
) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uint32_t value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; value =3D data[*pos &gt;&gt; 2];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D put_user(value, (uint32_t *)buf);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; result &#43;=3D 4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; buf &#43;=3D 4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *pos &#43;=3D 4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; size -=3D 4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static const struct file_operations amdgpu_debugfs_regs_fops =3D=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_reg=
s_read,<br>
&gt; @@ -2951,6 &#43;3017,12 @@ static const struct file_operations amdgpu_=
debugfs_sensors_fops =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek<b=
r>
&gt;&nbsp; };<br>
&gt;<br>
&gt; &#43;static const struct file_operations amdgpu_debugfs_wave_fops =3D =
{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_wave_read,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; static const struct file_operations *debugfs_regs[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs_fop=
s,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs_did=
t_fops,<br>
&gt; @@ -2958,6 &#43;3030,7 @@ static const struct file_operations *debugfs=
_regs[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs_smc=
_fops,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_gca_conf=
ig_fops,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_sensors_=
fops,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_wave_fops,<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const char *debugfs_regs_names[] =3D {<br>
&gt; @@ -2967,6 &#43;3040,7 @@ static const char *debugfs_regs_names[] =3D =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_regs_smc&quot;,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_gca_config&quot=
;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_sensors&quot;,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_wave&quot;,<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)<=
br>
&gt;<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MWHPR12MB16942B1E36EC312FA807A250F7DF0MWHPR12MB1694namp_--

--===============0614517058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0614517058==--
