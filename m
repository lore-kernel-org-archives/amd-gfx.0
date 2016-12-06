From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amd/amdgpu: Add debugfs support for reading GPRs
Date: Tue, 6 Dec 2016 12:40:19 +0000
Message-ID: <CY4PR12MB17682F63DB50CC32D6DBF36DF7820@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20161205183652.29325-1-tom.stdenis@amd.com>
 <20161205183652.29325-2-tom.stdenis@amd.com>,
 <9c9c13e7-f02d-73c0-1f3c-09cea022d195@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0484388846=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9c9c13e7-f02d-73c0-1f3c-09cea022d195-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0484388846==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB17682F63DB50CC32D6DBF36DF7820CY4PR12MB1768namp_"

--_000_CY4PR12MB17682F63DB50CC32D6DBF36DF7820CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Edward,


I don't think 'f' could be NULL there nor could the private data be NULL be=
cause it's initialized to point to the amdgpu_device when the entry is adde=
d to the vfs.


I can sort out the whitespace though.


Tom


________________________________
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Sent: Monday, December 5, 2016 14:59
To: Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: Re: [PATCH 1/3] drm/amd/amdgpu: Add debugfs support for reading GP=
Rs

Hi Tom,

On 12/06/2016 05:36 AM, Tom St Denis wrote:
> Implemented for SGPRs for GFX v8 initially.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 ++++++++++++++++++++++++=
++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 25 +++++++++++
>  3 files changed, 99 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 4f64bb16a8d3..2834451eef8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -844,6 +844,8 @@ struct amdgpu_gfx_funcs {
>        uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
>        void (*select_se_sh)(struct amdgpu_device *adev, u32 se_num, u32 s=
h_num, u32 instance);
>        void (*read_wave_data)(struct amdgpu_device *adev, uint32_t simd, =
uint32_t wave, uint32_t *dst, int *no_fields);
> +     void (*read_wave_vgprs)(struct amdgpu_device *adev, uint32_t simd, =
uint32_t wave, uint32_t thread, uint32_t start, uint32_t size, uint32_t *ds=
t);
> +     void (*read_wave_sgprs)(struct amdgpu_device *adev, uint32_t simd, =
uint32_t wave, uint32_t start, uint32_t size, uint32_t *dst);
>  };
>
>  struct amdgpu_gfx {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 25ad736b5ca5..7f9cb1c85d75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3055,6 +3055,71 @@ static ssize_t amdgpu_debugfs_wave_read(struct fil=
e *f, char __user *buf,
>        return result;
>  }
>
> +static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
> +                                     size_t size, loff_t *pos)
> +{
> +     struct amdgpu_device *adev =3D f->f_inode->i_private;

Could f potentially be null here?

> +     int r;
> +     ssize_t result=3D0;

result =3D 0

> +     uint32_t offset, se, sh, cu, wave, simd, thread, bank, *data;
> +
> +     if (size & 3 || *pos & 3)
> +             return -EINVAL;
> +
> +     /* decode offset */
> +     offset =3D (*pos & 0xFFF);
> +     se =3D ((*pos >> 12) & 0xFF);
> +     sh =3D ((*pos >> 20) & 0xFF);
> +     cu =3D ((*pos >> 28) & 0xFF);
> +     wave =3D ((*pos >> 36) & 0xFF);
> +     simd =3D ((*pos >> 44) & 0xFF);
> +     thread =3D ((*pos >> 52) & 0xFF);
> +     bank =3D ((*pos >> 60) & 1);
> +
> +     /* sanity check offset/size */
> +     if (offset + size > (adev->gfx.config.max_gprs << 2))
> +             return -EINVAL;
> +
> +     data =3D kmalloc_array(1024, sizeof(*data), GFP_KERNEL);
> +     if (!data)
> +             return -ENOMEM;
> +
> +     /* switch to the specific se/sh/cu */
> +     mutex_lock(&adev->grbm_idx_mutex);
> +     amdgpu_gfx_select_se_sh(adev, se, sh, cu);
> +
> +     if (bank =3D=3D 0) {
> +             if (adev->gfx.funcs->read_wave_vgprs)
> +                     adev->gfx.funcs->read_wave_vgprs(adev, simd, wave, =
thread, offset>>2, size>>2, data);
> +     } else {
> +             if (adev->gfx.funcs->read_wave_sgprs)
> +                     adev->gfx.funcs->read_wave_sgprs(adev, simd, wave, =
offset>>2, size>>2, data);
> +     }
> +
> +     amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
> +     mutex_unlock(&adev->grbm_idx_mutex);
> +
> +     while (size) {
> +             uint32_t value;
> +
> +             value =3D data[offset >> 2];
> +             r =3D put_user(value, (uint32_t *)buf);
> +             if (r) {
> +                     result =3D r;
> +                     goto err;
> +             }
> +
> +             result +=3D 4;
> +             buf +=3D 4;
> +             offset +=3D 4;
> +             size -=3D 4;
> +     }
> +
> +err:
> +     kfree(data);
> +     return result;
> +}
> +
>  static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>        .owner =3D THIS_MODULE,
>        .read =3D amdgpu_debugfs_regs_read,
> @@ -3097,6 +3162,11 @@ static const struct file_operations amdgpu_debugfs=
_wave_fops =3D {
>        .read =3D amdgpu_debugfs_wave_read,
>        .llseek =3D default_llseek
>  };
> +static const struct file_operations amdgpu_debugfs_gpr_fops =3D {
> +     .owner =3D THIS_MODULE,
> +     .read =3D amdgpu_debugfs_gpr_read,
> +     .llseek =3D default_llseek
> +};
>
>  static const struct file_operations *debugfs_regs[] =3D {
>        &amdgpu_debugfs_regs_fops,
> @@ -3106,6 +3176,7 @@ static const struct file_operations *debugfs_regs[]=
 =3D {
>        &amdgpu_debugfs_gca_config_fops,
>        &amdgpu_debugfs_sensors_fops,
>        &amdgpu_debugfs_wave_fops,
> +     &amdgpu_debugfs_gpr_fops,
>  };
>
>  static const char *debugfs_regs_names[] =3D {
> @@ -3116,6 +3187,7 @@ static const char *debugfs_regs_names[] =3D {
>        "amdgpu_gca_config",
>        "amdgpu_sensors",
>        "amdgpu_wave",
> +     "amdgpu_gpr",
>  };
>
>  static int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 9b8d3fe67adb..180309f5784c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5184,6 +5184,21 @@ static uint32_t wave_read_ind(struct amdgpu_device=
 *adev, uint32_t simd, uint32_
>        return RREG32(mmSQ_IND_DATA);
>  }
>
> +static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
> +                        uint32_t wave, uint32_t thread,
> +                        uint32_t regno, uint32_t num, uint32_t *out)
> +{
> +     WREG32(mmSQ_IND_INDEX,
> +             (wave << SQ_IND_INDEX__WAVE_ID__SHIFT) |
> +             (simd << SQ_IND_INDEX__SIMD_ID__SHIFT) |
> +             (regno << SQ_IND_INDEX__INDEX__SHIFT) |
> +             (thread << SQ_IND_INDEX__THREAD_ID__SHIFT) |
> +             (SQ_IND_INDEX__FORCE_READ_MASK) |
> +             (SQ_IND_INDEX__AUTO_INCR_MASK));
> +     while (num--)
> +             *(out++) =3D RREG32(mmSQ_IND_DATA);
> +}
> +
>  static void gfx_v8_0_read_wave_data(struct amdgpu_device *adev, uint32_t=
 simd, uint32_t wave, uint32_t *dst, int *no_fields)
>  {
>        /* type 0 wave data */
> @@ -5208,11 +5223,21 @@ static void gfx_v8_0_read_wave_data(struct amdgpu=
_device *adev, uint32_t simd, u
>        dst[(*no_fields)++] =3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_=
M0);
>  }
>
> +static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_=
t simd,
> +                                  uint32_t wave, uint32_t start,
> +                                  uint32_t size, uint32_t *dst)
> +{
> +     wave_read_regs(
> +             adev, simd, wave, 0,
> +             start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
> +}
> +
>
>  static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs =3D {
>        .get_gpu_clock_counter =3D &gfx_v8_0_get_gpu_clock_counter,
>        .select_se_sh =3D &gfx_v8_0_select_se_sh,
>        .read_wave_data =3D &gfx_v8_0_read_wave_data,
> +     .read_wave_sgprs =3D &gfx_v8_0_read_wave_sgprs,

Just fyi, these & are actually redundant when it comes to func ptr's.

>  };
>
>  static int gfx_v8_0_early_init(void *handle)
>

Kind Regards,
Edward.


--_000_CY4PR12MB17682F63DB50CC32D6DBF36DF7820CY4PR12MB1768namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi Edward,</p>
<p><br>
</p>
<p>I don't think 'f' could be NULL there nor could the private data be NULL=
 because it's initialized to point to the amdgpu_device when the entry is a=
dded to the vfs.</p>
<p><br>
</p>
<p>I can sort out the whitespace though.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Edward O'Callaghan =
&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, December 5, 2016 14:59<br>
<b>To:</b> Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amd/amdgpu: Add debugfs support for rea=
ding GPRs</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi Tom,<br>
<br>
On 12/06/2016 05:36 AM, Tom St Denis wrote:<br>
&gt; Implemented for SGPRs for GFX v8 initially.<br>
&gt; <br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 2 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 &#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 25 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 3 files changed, 99 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 4f64bb16a8d3..2834451eef8a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -844,6 &#43;844,8 @@ struct amdgpu_gfx_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t (*get_gpu_clock_cou=
nter)(struct amdgpu_device *adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*select_se_sh)(struct =
amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*read_wave_data)(struc=
t amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t *dst, int *no=
_fields);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void (*read_wave_vgprs)(struct amdgpu_de=
vice *adev, uint32_t simd, uint32_t wave, uint32_t thread, uint32_t start, =
uint32_t size, uint32_t *dst);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void (*read_wave_sgprs)(struct amdgpu_de=
vice *adev, uint32_t simd, uint32_t wave, uint32_t start, uint32_t size, ui=
nt32_t *dst);<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; struct amdgpu_gfx {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 25ad736b5ca5..7f9cb1c85d75 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -3055,6 &#43;3055,71 @@ static ssize_t amdgpu_debugfs_wave_read(str=
uct file *f, char __user *buf,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __use=
r *buf,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; size_t size, loff_t *pos)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D f-&gt;f_i=
node-&gt;i_private;<br>
<br>
Could f potentially be null here?<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t result=3D0;<br>
<br>
result =3D 0<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t offset, se, sh, cu, wave, simd,=
 thread, bank, *data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (size &amp; 3 || *pos &amp; 3)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* decode offset */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D (*pos &amp; 0xFFF);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; se =3D ((*pos &gt;&gt; 12) &amp; 0xFF);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sh =3D ((*pos &gt;&gt; 20) &amp; 0xFF);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; cu =3D ((*pos &gt;&gt; 28) &amp; 0xFF);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; wave =3D ((*pos &gt;&gt; 36) &amp; 0xFF)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; simd =3D ((*pos &gt;&gt; 44) &amp; 0xFF)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; thread =3D ((*pos &gt;&gt; 52) &amp; 0xF=
F);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bank =3D ((*pos &gt;&gt; 60) &amp; 1);<b=
r>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* sanity check offset/size */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (offset &#43; size &gt; (adev-&gt;gfx=
.config.max_gprs &lt;&lt; 2))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data =3D kmalloc_array(1024, sizeof(*dat=
a), GFP_KERNEL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!data)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -ENOMEM;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* switch to the specific se/sh/cu */<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;grbm_idx_mutex)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_select_se_sh(adev, se, sh, cu=
);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (bank =3D=3D 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;gfx.funcs-&gt;read_wave_vgprs)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.funcs-=
&gt;read_wave_vgprs(adev, simd, wave, thread, offset&gt;&gt;2, size&gt;&gt;=
2, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;gfx.funcs-&gt;read_wave_sgprs)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.funcs-=
&gt;read_wave_sgprs(adev, simd, wave, offset&gt;&gt;2, size&gt;&gt;2, data)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF=
, 0xFFFFFFFF, 0xFFFFFFFF);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;grbm_idx_mute=
x);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; while (size) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uint32_t value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; value =3D data[offset &gt;&gt; 2];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D put_user(value, (uint32_t *)buf);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (r) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D r;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; result &#43;=3D 4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; buf &#43;=3D 4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; offset &#43;=3D 4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; size -=3D 4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;err:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static const struct file_operations amdgpu_debugfs_regs_fops =3D=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_reg=
s_read,<br>
&gt; @@ -3097,6 &#43;3162,11 @@ static const struct file_operations amdgpu_=
debugfs_wave_fops =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_wav=
e_read,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek<b=
r>
&gt;&nbsp; };<br>
&gt; &#43;static const struct file_operations amdgpu_debugfs_gpr_fops =3D {=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_gpr_read,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek<br>
&gt; &#43;};<br>
&gt;&nbsp; <br>
&gt;&nbsp; static const struct file_operations *debugfs_regs[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs_fop=
s,<br>
&gt; @@ -3106,6 &#43;3176,7 @@ static const struct file_operations *debugfs=
_regs[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_gca_conf=
ig_fops,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_sensors_=
fops,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_wave_fop=
s,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_gpr_fops,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; static const char *debugfs_regs_names[] =3D {<br>
&gt; @@ -3116,6 &#43;3187,7 @@ static const char *debugfs_regs_names[] =3D =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_gca_config&quot=
;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_sensors&quot;,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_wave&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_gpr&quot;,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)<=
br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v8_0.c<br>
&gt; index 9b8d3fe67adb..180309f5784c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; @@ -5184,6 &#43;5184,21 @@ static uint32_t wave_read_ind(struct amdgpu=
_device *adev, uint32_t simd, uint32_<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32(mmSQ_IND_DATA)=
;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;static void wave_read_regs(struct amdgpu_device *adev, uint32_t s=
imd,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t wave, uint32_t thread,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t regno, uint32_t num, uint32_t *out)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmSQ_IND_INDEX,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (wave &lt;&lt; SQ_IND_INDEX__WAVE_ID__SHIFT) |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (simd &lt;&lt; SQ_IND_INDEX__SIMD_ID__SHIFT) |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (regno &lt;&lt; SQ_IND_INDEX__INDEX__SHIFT) |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (thread &lt;&lt; SQ_IND_INDEX__THREAD_ID__SHIFT) |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (SQ_IND_INDEX__FORCE_READ_MASK) |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (SQ_IND_INDEX__AUTO_INCR_MASK));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; while (num--)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *(out&#43;&#43;) =3D RREG32(mmSQ_IND_DATA);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static void gfx_v8_0_read_wave_data(struct amdgpu_device *adev, =
uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* type 0 wave data */<br>
&gt; @@ -5208,11 &#43;5223,21 @@ static void gfx_v8_0_read_wave_data(struct=
 amdgpu_device *adev, uint32_t simd, u<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[(*no_fields)&#43;&#43;] =
=3D wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, =
uint32_t simd,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t wave, u=
int32_t start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size, u=
int32_t *dst)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; wave_read_regs(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev, simd, wave, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; start &#43; SQIND_WAVE_SGPRS_OFFSET, size, dst);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; <br>
&gt;&nbsp; static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs =3D {<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_gpu_clock_counter =3D &=
amp;gfx_v8_0_get_gpu_clock_counter,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .select_se_sh =3D &amp;gfx_v=
8_0_select_se_sh,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_wave_data =3D &amp;gfx=
_v8_0_read_wave_data,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .read_wave_sgprs =3D &amp;gfx_v8_0_read_=
wave_sgprs,<br>
<br>
Just fyi, these &amp; are actually redundant when it comes to func ptr's.<b=
r>
<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int gfx_v8_0_early_init(void *handle)<br>
&gt; <br>
<br>
Kind Regards,<br>
Edward.<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB17682F63DB50CC32D6DBF36DF7820CY4PR12MB1768namp_--

--===============0484388846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0484388846==--
