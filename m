From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amd/amdgpu: Add wave reader to debugfs
Date: Fri, 14 Oct 2016 13:35:47 +0000
Message-ID: <CY4PR12MB1768ACB62C43AC65AD6F5735F7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20161011191815.2097-1-tom.stdenis@amd.com>
 <20161011191815.2097-2-tom.stdenis@amd.com>,
 <74d8807b-fb6b-d249-3c6a-2eba72fa73a3@gmail.com>
 <CY4PR12MB1768E88741EB80464DC9151DF7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>,
 <MWHPR12MB16942B1E36EC312FA807A250F7DF0@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1366228994=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB16942B1E36EC312FA807A250F7DF0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Nicolai_H=E4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1366228994==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768ACB62C43AC65AD6F5735F7DF0CY4PR12MB1768namp_"

--_000_CY4PR12MB1768ACB62C43AC65AD6F5735F7DF0CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,


Sounds like a plan since I want to add a few fields anyways.


Tom


________________________________
From: Deucher, Alexander
Sent: Friday, October 14, 2016 09:33
To: StDenis, Tom; Nicolai H=E4hnle
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH 1/3] drm/amd/amdgpu: Add wave reader to debugfs


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

--_000_CY4PR12MB1768ACB62C43AC65AD6F5735F7DF0CY4PR12MB1768namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi Alex,</p>
<p><br>
</p>
<p>Sounds like a plan since I want to add a few fields anyways. &nbsp;</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander<br=
>
<b>Sent:</b> Friday, October 14, 2016 09:33<br>
<b>To:</b> StDenis, Tom; Nicolai H=E4hnle<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH 1/3] drm/amd/amdgpu: Add wave reader to debugfs<=
/font>
<div>&nbsp;</div>
</div>
<div>
<div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">You could make the wave decode a gfx callback =
and move the code into the IP modules.</span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">&nbsp;</span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">Alex</span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">&nbsp;</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #B5C4DF 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<b><span style=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;">From:</span></b><span style=3D"font-size:10.0pt; font-famil=
y:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx [mailto:amd-gfx-bounc=
es-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]
<b>On Behalf Of </b>StDenis, Tom<br>
<b>Sent:</b> Friday, October 14, 2016 6:56 AM<br>
<b>To:</b> Nicolai H=E4hnle<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amd/amdgpu: Add wave reader to debugfs<=
/span></p>
</div>
</div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
&nbsp;</p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; c=
olor:black">Hi Nicolai,</span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; c=
olor:black">&nbsp;</span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; c=
olor:black">I was trying to avoid having ASIC specific includes/etc in the =
amdgpu_device.c file. &nbsp;Agreed that de-numberifying it would be nice. &=
nbsp;Maybe we can add some /**/ comments to clear it up. &nbsp;I imagine
 in the future we'll add more fields (upto 32 in this design) anyways.</spa=
n></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; c=
olor:black">&nbsp;</span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; c=
olor:black">Cheers,</span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; c=
olor:black">Tom</span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
<div>
<div>
<div align=3D"center" style=3D"text-align: center; margin: 0in 0in 0.0001pt=
; font-size: 12pt; font-family: &quot;Times New Roman&quot;, serif;">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<b><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;s=
ans-serif&quot;; color:black">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black"> N=
icolai H=E4hnle &lt;<a href=3D"mailto:nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" style=3D"color: b=
lue; text-decoration: underline;">nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 03:25<br>
<b>To:</b> Tom St Denis; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" s=
tyle=3D"color: blue; text-decoration: underline;">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amd/amdgpu: Add wave reader to debugfs<=
/span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;=
; color:black">
</span></p>
<div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
</div>
</div>
<div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-size:10.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:black">On 11.10.2016 21:18, Tom St Denis wrote:<br>
&gt; Currently supports CZ/VI.&nbsp; Allows nearly atomic read<br>
&gt; of wave data from GPU.<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org"=
 style=3D"color: blue; text-decoration: underline;">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>=
&gt;<br>
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
&gt;</span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1768ACB62C43AC65AD6F5735F7DF0CY4PR12MB1768namp_--

--===============1366228994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1366228994==--
