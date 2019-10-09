From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/8] drm/amdgpu: add a generic fb accessing helper function
Date: Wed, 9 Oct 2019 11:30:09 +0000
Message-ID: <SN1PR12MB2544ECC6BB4C073BCA587E1195950@SN1PR12MB2544.namprd12.prod.outlook.com>
References: <20191008192934.5481-1-alexander.deucher@amd.com>
 <20191008192934.5481-3-alexander.deucher@amd.com>,
 <0edeab78-992c-89b2-f2c2-41db101bc5b7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0005012269=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0edeab78-992c-89b2-f2c2-41db101bc5b7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0005012269==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB2544ECC6BB4C073BCA587E1195950SN1PR12MB2544namp_"

--_000_SN1PR12MB2544ECC6BB4C073BCA587E1195950SN1PR12MB2544namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ok,

Thanks for your reviewing!

Rico
________________________________
From: Christian K?nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, October 9, 2019 16:25
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Yin, Tianci (Rico) <Tia=
nci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/8] drm/amdgpu: add a generic fb accessing helper func=
tion

Am 08.10.19 um 21:29 schrieb Alex Deucher:
> From: "Tianci.Yin" <tianci.yin-5C7GfCeVMHo@public.gmane.org>
>
> add a generic helper function for accessing framebuffer via MMIO
>
> Change-Id: I4baa0aa53c93a94c2eff98c6211a61f369239982
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Tianci.Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 42 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 +-----
>   3 files changed, 45 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 17ccb9015141..0d60c2e6c592 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -985,6 +985,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   void amdgpu_device_fini(struct amdgpu_device *adev);
>   int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
>
> +int amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> +                    uint32_t *buf, size_t size, bool write);
>   uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>                        uint32_t acc_flags);
>   void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t =
v,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index f25275abf408..53ce227f759c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -153,6 +153,48 @@ bool amdgpu_device_is_px(struct drm_device *dev)
>        return false;
>   }
>
> +/**
> + * VRAM access helper functions.
> + *
> + * amdgpu_device_vram_access - read/write a buffer in vram
> + *
> + * @adev: amdgpu_device pointer
> + * @pos: offset of the buffer in vram
> + * @buf: virtual address of the buffer in system memory
> + * @size: read/write size, sizeof(@buf) must > @size
> + * @write: true - write to vram, otherwise - read from vram
> + *
> + * Returns 0 on success or an -error on failure.
> + */
> +int amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> +                    uint32_t *buf, size_t size, bool write)

Indentation seems to be incorrect here.

> +{
> +     uint64_t end =3D pos + size;
> +     unsigned long flags;
> +
> +     if (IS_ERR_OR_NULL(buf) ||
> +         (adev->gmc.mc_vram_size > 0 &&
> +          end > adev->gmc.mc_vram_size)) {
> +             DRM_ERROR("parameter error! pos:%llx, buf:%llx, size:%zx.\n=
",
> +                       pos, (u64)buf, size);
> +             return -EINVAL;
> +     }

Please drop that, this is a purely internal functions and parameter
checking like this doesn't really make sense.

Regards,
Christian.

> +
> +     while (pos < end) {
> +             spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> +             WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> +             WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
> +             if (write)
> +                     WREG32_NO_KIQ(mmMM_DATA, *buf++);
> +             else
> +                     *buf++ =3D RREG32_NO_KIQ(mmMM_DATA);
> +             spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> +             pos +=3D 4;
> +     }
> +
> +     return 0;
> +}
> +
>   /*
>    * MMIO register access helper functions.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index db2dab3a6dff..324c2d605f54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -134,21 +134,10 @@ static int hw_id_map[MAX_HWIP] =3D {
>
>   static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uin=
t8_t *binary)
>   {
> -     uint32_t *p =3D (uint32_t *)binary;
>        uint64_t vram_size =3D (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 2=
0;
>        uint64_t pos =3D vram_size - BINARY_MAX_SIZE;
> -     unsigned long flags;
> -
> -     while (pos < vram_size) {
> -             spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -             WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> -             WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
> -             *p++ =3D RREG32_NO_KIQ(mmMM_DATA);
> -             spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> -             pos +=3D 4;
> -     }
>
> -     return 0;
> +     return amdgpu_device_vram_access(adev, pos, (uint32_t *)binary, BIN=
ARY_MAX_SIZE, false);
>   }
>
>   static uint16_t amdgpu_discovery_calculate_checksum(uint8_t *data, uint=
32_t size)


--_000_SN1PR12MB2544ECC6BB4C073BCA587E1195950SN1PR12MB2544namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Ok, <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks for your reviewing!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K&ouml;nig =
&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, October 9, 2019 16:25<br>
<b>To:</b> Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Yin, Tianc=
i (Rico) &lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/8] drm/amdgpu: add a generic fb accessing help=
er function</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 08.10.19 um 21:29 schrieb Alex Deucher:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; add a generic helper function for accessing framebuffer via MMIO<br>
&gt;<br>
&gt; Change-Id: I4baa0aa53c93a94c2eff98c6211a61f369239982<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbs=
p; | 42 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 &#43;--=
---<br>
&gt;&nbsp;&nbsp; 3 files changed, 45 insertions(&#43;), 12 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 17ccb9015141..0d60c2e6c592 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -985,6 &#43;985,8 @@ int amdgpu_device_init(struct amdgpu_device *a=
dev,<br>
&gt;&nbsp;&nbsp; void amdgpu_device_fini(struct amdgpu_device *adev);<br>
&gt;&nbsp;&nbsp; int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);<=
br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;int amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t =
pos,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *buf, size_t siz=
e, bool write);<br>
&gt;&nbsp;&nbsp; uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32=
_t reg,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t acc_flags);<br>
&gt;&nbsp;&nbsp; void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t r=
eg, uint32_t v,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index f25275abf408..53ce227f759c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -153,6 &#43;153,48 @@ bool amdgpu_device_is_px(struct drm_device *d=
ev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;/**<br>
&gt; &#43; * VRAM access helper functions.<br>
&gt; &#43; *<br>
&gt; &#43; * amdgpu_device_vram_access - read/write a buffer in vram<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; * @pos: offset of the buffer in vram<br>
&gt; &#43; * @buf: virtual address of the buffer in system memory<br>
&gt; &#43; * @size: read/write size, sizeof(@buf) must &gt; @size<br>
&gt; &#43; * @write: true - write to vram, otherwise - read from vram<br>
&gt; &#43; *<br>
&gt; &#43; * Returns 0 on success or an -error on failure.<br>
&gt; &#43; */<br>
&gt; &#43;int amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t =
pos,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *buf, size_t siz=
e, bool write)<br>
<br>
Indentation seems to be incorrect here.<br>
<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t end =3D pos &#43; size;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR_OR_NULL(buf) ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gmc.mc=
_vram_size &gt; 0 &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end &gt; a=
dev-&gt;gmc.mc_vram_size)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;parameter error! pos:%llx, buf:%llx, size:%zx.\n&qu=
ot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos, (u=
64)buf, size);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
Please drop that, this is a purely internal functions and parameter <br>
checking like this doesn't really make sense.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; while (pos &lt; end) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock, flags);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_NO_KIQ(mmMM_INDEX_HI, pos &gt;&gt; 31);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (write)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_=
DATA, *buf&#43;&#43;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *buf&#43;&#43; =3D =
RREG32_NO_KIQ(mmMM_DATA);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; spin_unlock_irqrestore(&amp;adev-&gt;mmio_idx_lock, flags);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pos &#43;=3D 4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * MMIO register access helper functions.<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; index db2dab3a6dff..324c2d605f54 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; @@ -134,21 &#43;134,10 @@ static int hw_id_map[MAX_HWIP] =3D {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int amdgpu_discovery_read_binary(struct amdgpu_devi=
ce *adev, uint8_t *binary)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *p =3D (uint32_t *)binary;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vram_size =3D (uint=
64_t)RREG32(mmRCC_CONFIG_MEMSIZE) &lt;&lt; 20;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pos =3D vram_size -=
 BINARY_MAX_SIZE;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; while (pos &lt; vram_size) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_NO_KIQ(mmMM_INDEX_HI, pos &gt;&gt; 31);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p&#43;&#43; =3D RREG32_NO_KIQ(mmMM_DATA);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; spin_unlock_irqrestore(&amp;adev-&gt;mmio_idx_lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pos &#43;=3D 4;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_vram_access(adev, p=
os, (uint32_t *)binary, BINARY_MAX_SIZE, false);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static uint16_t amdgpu_discovery_calculate_checksum(uint8_=
t *data, uint32_t size)<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SN1PR12MB2544ECC6BB4C073BCA587E1195950SN1PR12MB2544namp_--

--===============0005012269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0005012269==--
