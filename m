From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Date: Fri, 1 Nov 2019 22:20:32 +0000
Message-ID: <DM6PR12MB2778C939A102478FF10F39ADF0620@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191101204818.8125-1-Yong.Zhao@amd.com>,
 <c237f5bf-6638-2d90-3f94-e1eca2c22780@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0915769850=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c237f5bf-6638-2d90-3f94-e1eca2c22780-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0915769850==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778C939A102478FF10F39ADF0620DM6PR12MB2778namp_"

--_000_DM6PR12MB2778C939A102478FF10F39ADF0620DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Felix,

The PAGE_SHIFT was not deleted but merged into the KFD_*_SHIFT in kfd_priv.=
h. Because of that, this change is actually transparent to the thunk, and i=
t only straightens up the bit shift operations in most cases.

Regards,
Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, November 1, 2019 5:13 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Zhao, Yo=
ng <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit opera=
tions

NAK. This won't work for several reasons.

The mmap_offset is used as offset parameter in the mmap system call. If
you check the man page of mmap, you'll see that "offset must be a
multiple of the page size". Therefore the PAGE_SHIFT is necessary.

In the case of doorbell offsets, the offset is parsed and processed by
the Thunk in user mode. On GFX9 GPUs the lower bits are used for the
offset of the doorbell within the doorbell page. On GFX8 the queue ID
was used, but on GFX9 we had to decoupled the doorbell ID from the queue
ID. If you remove the PAGE_SHIFT, you'll need to put those bits
somewhere else. But that change in the encoding would break the ABI with
the Thunk.

Regards,
   Felix

On 2019-11-01 4:48 p.m., Zhao, Yong wrote:
> The new code is much cleaner and results in better readability.
>
> Change-Id: I0c1f7cca7e24ddb7b4ffe1cb0fa71943828ae373
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 +++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c  |  1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 +++------
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +--
>   4 files changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index b91993753b82..590138727ca9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -298,7 +298,6 @@ static int kfd_ioctl_create_queue(struct file *filep,=
 struct kfd_process *p,
>        /* Return gpu_id as doorbell offset for mmap usage */
>        args->doorbell_offset =3D KFD_MMAP_TYPE_DOORBELL;
>        args->doorbell_offset |=3D KFD_MMAP_GPU_ID(args->gpu_id);
> -     args->doorbell_offset <<=3D PAGE_SHIFT;
>        if (KFD_IS_SOC15(dev->device_info->asic_family))
>                /* On SOC15 ASICs, include the doorbell offset within the
>                 * process doorbell frame, which could be 1 page or 2 page=
s.
> @@ -1938,20 +1937,22 @@ static int kfd_mmap(struct file *filp, struct vm_=
area_struct *vma)
>   {
>        struct kfd_process *process;
>        struct kfd_dev *dev =3D NULL;
> -     unsigned long vm_pgoff;
> +     unsigned long mmap_offset;
>        unsigned int gpu_id;
>
>        process =3D kfd_get_process(current);
>        if (IS_ERR(process))
>                return PTR_ERR(process);
>
> -     vm_pgoff =3D vma->vm_pgoff;
> -     vma->vm_pgoff =3D KFD_MMAP_OFFSET_VALUE_GET(vm_pgoff);
> -     gpu_id =3D KFD_MMAP_GPU_ID_GET(vm_pgoff);
> +     mmap_offset =3D vma->vm_pgoff << PAGE_SHIFT;
> +     gpu_id =3D KFD_MMAP_GET_GPU_ID(mmap_offset);
>        if (gpu_id)
>                dev =3D kfd_device_by_id(gpu_id);
>
> -     switch (vm_pgoff & KFD_MMAP_TYPE_MASK) {
> +     /* only leave the offset segment */
> +     vma->vm_pgoff &=3D (1ULL << (KFD_MMAP_GPU_ID_SHIFT - PAGE_SHIFT)) -=
 1;
> +
> +     switch (mmap_offset & KFD_MMAP_TYPE_MASK) {
>        case KFD_MMAP_TYPE_DOORBELL:
>                if (!dev)
>                        return -ENODEV;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_events.c
> index 908081c85de1..1f8365575b12 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -346,7 +346,6 @@ int kfd_event_create(struct file *devkfd, struct kfd_=
process *p,
>                ret =3D create_signal_event(devkfd, p, ev);
>                if (!ret) {
>                        *event_page_offset =3D KFD_MMAP_TYPE_EVENTS;
> -                     *event_page_offset <<=3D PAGE_SHIFT;
>                        *event_slot_index =3D ev->event_id;
>                }
>                break;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 66bae8f2dad1..8eecd2cd1fd2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -59,24 +59,21 @@
>    * NOTE: struct vm_area_struct.vm_pgoff uses offset in pages. Hence, th=
ese
>    *  defines are w.r.t to PAGE_SIZE
>    */
> -#define KFD_MMAP_TYPE_SHIFT  (62 - PAGE_SHIFT)
> +#define KFD_MMAP_TYPE_SHIFT  (62)
>   #define KFD_MMAP_TYPE_MASK  (0x3ULL << KFD_MMAP_TYPE_SHIFT)
>   #define KFD_MMAP_TYPE_DOORBELL      (0x3ULL << KFD_MMAP_TYPE_SHIFT)
>   #define KFD_MMAP_TYPE_EVENTS        (0x2ULL << KFD_MMAP_TYPE_SHIFT)
>   #define KFD_MMAP_TYPE_RESERVED_MEM  (0x1ULL << KFD_MMAP_TYPE_SHIFT)
>   #define KFD_MMAP_TYPE_MMIO  (0x0ULL << KFD_MMAP_TYPE_SHIFT)
>
> -#define KFD_MMAP_GPU_ID_SHIFT (46 - PAGE_SHIFT)
> +#define KFD_MMAP_GPU_ID_SHIFT (46)
>   #define KFD_MMAP_GPU_ID_MASK (((1ULL << KFD_GPU_ID_HASH_WIDTH) - 1) \
>                                << KFD_MMAP_GPU_ID_SHIFT)
>   #define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) << KFD_MMAP_GPU_ID=
_SHIFT)\
>                                & KFD_MMAP_GPU_ID_MASK)
> -#define KFD_MMAP_GPU_ID_GET(offset)    ((offset & KFD_MMAP_GPU_ID_MASK) =
\
> +#define KFD_MMAP_GET_GPU_ID(offset)    ((offset & KFD_MMAP_GPU_ID_MASK) =
\
>                                >> KFD_MMAP_GPU_ID_SHIFT)
>
> -#define KFD_MMAP_OFFSET_VALUE_MASK   (0x3FFFFFFFFFFFULL >> PAGE_SHIFT)
> -#define KFD_MMAP_OFFSET_VALUE_GET(offset) (offset & KFD_MMAP_OFFSET_VALU=
E_MASK)
> -
>   /*
>    * When working with cp scheduler we should assign the HIQ manually or =
via
>    * the amdgpu driver to a fixed hqd slot, here are the fixed HIQ hqd sl=
ot
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 6abfb77ae540..39dc49b8fd85 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -554,8 +554,7 @@ static int kfd_process_init_cwsr_apu(struct kfd_proce=
ss *p, struct file *filep)
>                if (!dev->cwsr_enabled || qpd->cwsr_kaddr || qpd->cwsr_bas=
e)
>                        continue;
>
> -             offset =3D (KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(de=
v->id))
> -                     << PAGE_SHIFT;
> +             offset =3D KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev=
->id);
>                qpd->tba_addr =3D (int64_t)vm_mmap(filep, 0,
>                        KFD_CWSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,
>                        MAP_SHARED, offset);

--_000_DM6PR12MB2778C939A102478FF10F39ADF0620DM6PR12MB2778namp_
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
Hi Felix,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The&nbsp;<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI=
&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -ap=
ple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-se=
rif; font-size: 14.6667px; background-color: rgb(255, 255, 255); display: i=
nline !important">PAGE_SHIFT
 was not deleted but merged into the&nbsp;<span style=3D"font-family: &quot=
;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&q=
uot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;=
, sans-serif; background-color: rgb(255, 255, 255); display: inline !import=
ant">KFD_*_SHIFT
 in kfd_priv.h. Because of that, this change is actually transparent to the=
 thunk, and it only straightens up the bit shift operations in most cases.<=
/span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant"><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI W=
eb (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSyst=
emFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: r=
gb(255, 255, 255); display: inline !important"><br>
</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant"><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI W=
eb (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSyst=
emFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: r=
gb(255, 255, 255); display: inline !important">Regards,</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant"><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI W=
eb (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSyst=
emFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: r=
gb(255, 255, 255); display: inline !important">Yong</span></span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, November 1, 2019 5:13 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;; Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bi=
t operations</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">NAK. This won't work for several reasons.<br>
<br>
The mmap_offset is used as offset parameter in the mmap system call. If <br=
>
you check the man page of mmap, you'll see that &quot;offset must be a <br>
multiple of the page size&quot;. Therefore the PAGE_SHIFT is necessary.<br>
<br>
In the case of doorbell offsets, the offset is parsed and processed by <br>
the Thunk in user mode. On GFX9 GPUs the lower bits are used for the <br>
offset of the doorbell within the doorbell page. On GFX8 the queue ID <br>
was used, but on GFX9 we had to decoupled the doorbell ID from the queue <b=
r>
ID. If you remove the PAGE_SHIFT, you'll need to put those bits <br>
somewhere else. But that change in the encoding would break the ABI with <b=
r>
the Thunk.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
On 2019-11-01 4:48 p.m., Zhao, Yong wrote:<br>
&gt; The new code is much cleaner and results in better readability.<br>
&gt;<br>
&gt; Change-Id: I0c1f7cca7e24ddb7b4ffe1cb0fa71943828ae373<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 &#43;&#43;&#=
43;&#43;&#43;&#43;&#43;------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_events.c&nbsp; |&nbsp; 1 -<=
br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&=
nbsp; 9 &#43;&#43;&#43;------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c |&nbsp; 3 &#43;--=
<br>
&gt;&nbsp;&nbsp; 4 files changed, 11 insertions(&#43;), 15 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_chardev.c<br>
&gt; index b91993753b82..590138727ca9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; @@ -298,7 &#43;298,6 @@ static int kfd_ioctl_create_queue(struct file =
*filep, struct kfd_process *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Return gpu_id as doorbell=
 offset for mmap usage */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset =3D=
 KFD_MMAP_TYPE_DOORBELL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset |=
=3D KFD_MMAP_GPU_ID(args-&gt;gpu_id);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset &lt;&lt;=3D PAGE_SH=
IFT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_IS_SOC15(dev-&gt;dev=
ice_info-&gt;asic_family))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* On SOC15 ASICs, include the doorbell offset within t=
he<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * process doorbell frame, which could be 1 page o=
r 2 pages.<br>
&gt; @@ -1938,20 &#43;1937,22 @@ static int kfd_mmap(struct file *filp, str=
uct vm_area_struct *vma)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *process;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev =3D NULL=
;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned long vm_pgoff;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long mmap_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int gpu_id;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process =3D kfd_get_process(=
current);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(process))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return PTR_ERR(process);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; vm_pgoff =3D vma-&gt;vm_pgoff;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_pgoff =3D KFD_MMAP_OFFSET_VALUE_G=
ET(vm_pgoff);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; gpu_id =3D KFD_MMAP_GPU_ID_GET(vm_pgoff);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmap_offset =3D vma-&gt;vm_pgoff &lt;&lt=
; PAGE_SHIFT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; gpu_id =3D KFD_MMAP_GET_GPU_ID(mmap_offs=
et);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_id)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev =3D kfd_device_by_id(gpu_id);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (vm_pgoff &amp; KFD_MMAP_TYPE_MASK) {=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* only leave the offset segment */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_pgoff &amp;=3D (1ULL &lt;&lt;=
 (KFD_MMAP_GPU_ID_SHIFT - PAGE_SHIFT)) - 1;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (mmap_offset &amp; KFD_MMAP_TYPE_=
MASK) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_MMAP_TYPE_DOORBELL:=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-ENODEV;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_events.c<br>
&gt; index 908081c85de1..1f8365575b12 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&gt; @@ -346,7 &#43;346,6 @@ int kfd_event_create(struct file *devkfd, stru=
ct kfd_process *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D create_signal_event(devkfd, p, ev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *event_=
page_offset =3D KFD_MMAP_TYPE_EVENTS;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *event_page_offset &lt;=
&lt;=3D PAGE_SHIFT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *event_=
slot_index =3D ev-&gt;event_id;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index 66bae8f2dad1..8eecd2cd1fd2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -59,24 &#43;59,21 @@<br>
&gt;&nbsp;&nbsp;&nbsp; * NOTE: struct vm_area_struct.vm_pgoff uses offset i=
n pages. Hence, these<br>
&gt;&nbsp;&nbsp;&nbsp; *&nbsp; defines are w.r.t to PAGE_SIZE<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; -#define KFD_MMAP_TYPE_SHIFT&nbsp; (62 - PAGE_SHIFT)<br>
&gt; &#43;#define KFD_MMAP_TYPE_SHIFT&nbsp; (62)<br>
&gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_MASK&nbsp; (0x3ULL &lt;&lt; KFD_MMAP=
_TYPE_SHIFT)<br>
&gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_DOORBELL&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (0x3ULL &lt;&lt; KFD_MMAP_TYPE_SHIFT)<br>
&gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_EVENTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (0x2ULL &lt;&lt; KFD_MMAP_TYPE_SHIFT)<br>
&gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_RESERVED_MEM&nbsp; (0x1ULL &lt;&lt; =
KFD_MMAP_TYPE_SHIFT)<br>
&gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_MMIO&nbsp; (0x0ULL &lt;&lt; KFD_MMAP=
_TYPE_SHIFT)<br>
&gt;&nbsp;&nbsp; <br>
&gt; -#define KFD_MMAP_GPU_ID_SHIFT (46 - PAGE_SHIFT)<br>
&gt; &#43;#define KFD_MMAP_GPU_ID_SHIFT (46)<br>
&gt;&nbsp;&nbsp; #define KFD_MMAP_GPU_ID_MASK (((1ULL &lt;&lt; KFD_GPU_ID_H=
ASH_WIDTH) - 1) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;&lt; KFD_MMAP_GPU_ID_SHIFT)<br=
>
&gt;&nbsp;&nbsp; #define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) &lt;&=
lt; KFD_MMAP_GPU_ID_SHIFT)\<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp; KFD_MMAP_GPU_ID_MASK)<br>
&gt; -#define KFD_MMAP_GPU_ID_GET(offset)&nbsp;&nbsp;&nbsp; ((offset &amp; =
KFD_MMAP_GPU_ID_MASK) \<br>
&gt; &#43;#define KFD_MMAP_GET_GPU_ID(offset)&nbsp;&nbsp;&nbsp; ((offset &a=
mp; KFD_MMAP_GPU_ID_MASK) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; KFD_MMAP_GPU_ID_SHIFT)<br=
>
&gt;&nbsp;&nbsp; <br>
&gt; -#define KFD_MMAP_OFFSET_VALUE_MASK&nbsp;&nbsp; (0x3FFFFFFFFFFFULL &gt=
;&gt; PAGE_SHIFT)<br>
&gt; -#define KFD_MMAP_OFFSET_VALUE_GET(offset) (offset &amp; KFD_MMAP_OFFS=
ET_VALUE_MASK)<br>
&gt; -<br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * When working with cp scheduler we should assign th=
e HIQ manually or via<br>
&gt;&nbsp;&nbsp;&nbsp; * the amdgpu driver to a fixed hqd slot, here are th=
e fixed HIQ hqd slot<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_process.c<br>
&gt; index 6abfb77ae540..39dc49b8fd85 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; @@ -554,8 &#43;554,7 @@ static int kfd_process_init_cwsr_apu(struct kf=
d_process *p, struct file *filep)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!dev-&gt;cwsr_enabled || qpd-&gt;cwsr_kaddr || qpd-=
&gt;cwsr_base)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; offset =3D (KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev-&gt;id))<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;&lt; PAGE_SHIFT;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; offset =3D KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev-&gt;id)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; qpd-&gt;tba_addr =3D (int64_t)vm_mmap(filep, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_CWS=
R_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAP_SHA=
RED, offset);<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB2778C939A102478FF10F39ADF0620DM6PR12MB2778namp_--

--===============0915769850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0915769850==--
