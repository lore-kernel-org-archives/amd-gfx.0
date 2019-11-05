From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Date: Tue, 5 Nov 2019 23:08:54 +0000
Message-ID: <DM6PR12MB2778665DFDF4915AD20E84CFF07E0@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191101204818.8125-1-Yong.Zhao@amd.com>
 <2d2985b2-bcd2-3f56-918e-948020c61993@amd.com>
 <DM6PR12MB27789FF639D6516AAB7E6099F0620@DM6PR12MB2778.namprd12.prod.outlook.com>,
 <f066444f-a621-f6d4-0c85-2071bf528b2e@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0860220432=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f066444f-a621-f6d4-0c85-2071bf528b2e-5C7GfCeVMHo@public.gmane.org>
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

--===============0860220432==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778665DFDF4915AD20E84CFF07E0DM6PR12MB2778namp_"

--_000_DM6PR12MB2778665DFDF4915AD20E84CFF07E0DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Okay. I will delete that line.

Regards,
Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, November 5, 2019 5:34 PM
To: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit opera=
tions

On 2019-11-01 7:03 p.m., Zhao, Yong wrote:
>
>     > +     /* only leave the offset segment */
>     > +     vma->vm_pgoff &=3D (1ULL << (KFD_MMAP_GPU_ID_SHIFT - PAGE_SHI=
FT)) - 1;
>
>     You're now open-coding what used to be done by the
>     KFD_MMAP_OFFSET_VALUE_GET macro. I don't see how this is an
>     improvement.
>     Maybe better to update the macro to do this.
>
>
> I can definitely do that, but I think we'd better delete this line
> completely as it seems odd to change vm_pgoff. Moreover this vm_pgoff
> is not used at all in the following function calls. What do you think?

I think you're right. Looks like a historical accident. I see that older
versions of kfd_event_mmap used to access vm_pgoff and probably depended
on this. We removed that in this commit:


commit 50cb7dd94cb43a6204813376e1be1d21780b71fb
Author: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Date:   Fri Oct 27 19:35:26 2017 -0400

     drm/amdkfd: Simplify events page allocator

     The first event page is always big enough to handle all events.
     Handling of multiple events pages is not supported by user mode, and
     not necessary.

     Signed-off-by: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>
     Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
     Acked-by: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
     Signed-off-by: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>



Regards,
   Felix


>
> Regards,
> Yong
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Friday, November 1, 2019 6:48 PM
> *To:* Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: [PATCH] drm/amdkfd: Simplify the mmap offset related
> bit operations
> On 2019-11-01 4:48 p.m., Zhao, Yong wrote:
> > The new code is much cleaner and results in better readability.
> >
> > Change-Id: I0c1f7cca7e24ddb7b4ffe1cb0fa71943828ae373
> > Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 +++++++------
> >   drivers/gpu/drm/amd/amdkfd/kfd_events.c  |  1 -
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 +++------
> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +--
> >   4 files changed, 11 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > index b91993753b82..590138727ca9 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -298,7 +298,6 @@ static int kfd_ioctl_create_queue(struct file
> *filep, struct kfd_process *p,
> >        /* Return gpu_id as doorbell offset for mmap usage */
> >        args->doorbell_offset =3D KFD_MMAP_TYPE_DOORBELL;
> >        args->doorbell_offset |=3D KFD_MMAP_GPU_ID(args->gpu_id);
> > -     args->doorbell_offset <<=3D PAGE_SHIFT;
> >        if (KFD_IS_SOC15(dev->device_info->asic_family))
> >                /* On SOC15 ASICs, include the doorbell offset within th=
e
> >                 * process doorbell frame, which could be 1 page or 2
> pages.
> > @@ -1938,20 +1937,22 @@ static int kfd_mmap(struct file *filp,
> struct vm_area_struct *vma)
> >   {
> >        struct kfd_process *process;
> >        struct kfd_dev *dev =3D NULL;
> > -     unsigned long vm_pgoff;
> > +     unsigned long mmap_offset;
> >        unsigned int gpu_id;
> >
> >        process =3D kfd_get_process(current);
> >        if (IS_ERR(process))
> >                return PTR_ERR(process);
> >
> > -     vm_pgoff =3D vma->vm_pgoff;
> > -     vma->vm_pgoff =3D KFD_MMAP_OFFSET_VALUE_GET(vm_pgoff);
> > -     gpu_id =3D KFD_MMAP_GPU_ID_GET(vm_pgoff);
> > +     mmap_offset =3D vma->vm_pgoff << PAGE_SHIFT;
> > +     gpu_id =3D KFD_MMAP_GET_GPU_ID(mmap_offset);
> >        if (gpu_id)
> >                dev =3D kfd_device_by_id(gpu_id);
> >
> > -     switch (vm_pgoff & KFD_MMAP_TYPE_MASK) {
> > +     /* only leave the offset segment */
> > +     vma->vm_pgoff &=3D (1ULL << (KFD_MMAP_GPU_ID_SHIFT -
> PAGE_SHIFT)) - 1;
>
> You're now open-coding what used to be done by the
> KFD_MMAP_OFFSET_VALUE_GET macro. I don't see how this is an improvement.
> Maybe better to update the macro to do this.
>
>
> > +
> > +     switch (mmap_offset & KFD_MMAP_TYPE_MASK) {
> >        case KFD_MMAP_TYPE_DOORBELL:
> >                if (!dev)
> >                        return -ENODEV;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > index 908081c85de1..1f8365575b12 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > @@ -346,7 +346,6 @@ int kfd_event_create(struct file *devkfd, struct
> kfd_process *p,
> >                ret =3D create_signal_event(devkfd, p, ev);
> >                if (!ret) {
> >                        *event_page_offset =3D KFD_MMAP_TYPE_EVENTS;
> > -                     *event_page_offset <<=3D PAGE_SHIFT;
> >                        *event_slot_index =3D ev->event_id;
> >                }
> >                break;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > index 66bae8f2dad1..8eecd2cd1fd2 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -59,24 +59,21 @@
> >    * NOTE: struct vm_area_struct.vm_pgoff uses offset in pages.
> Hence, these
> >    *  defines are w.r.t to PAGE_SIZE
> >    */
> > -#define KFD_MMAP_TYPE_SHIFT  (62 - PAGE_SHIFT)
> > +#define KFD_MMAP_TYPE_SHIFT  (62)
> >   #define KFD_MMAP_TYPE_MASK  (0x3ULL << KFD_MMAP_TYPE_SHIFT)
> >   #define KFD_MMAP_TYPE_DOORBELL      (0x3ULL << KFD_MMAP_TYPE_SHIFT)
> >   #define KFD_MMAP_TYPE_EVENTS        (0x2ULL << KFD_MMAP_TYPE_SHIFT)
> >   #define KFD_MMAP_TYPE_RESERVED_MEM  (0x1ULL << KFD_MMAP_TYPE_SHIFT)
> >   #define KFD_MMAP_TYPE_MMIO  (0x0ULL << KFD_MMAP_TYPE_SHIFT)
> >
> > -#define KFD_MMAP_GPU_ID_SHIFT (46 - PAGE_SHIFT)
> > +#define KFD_MMAP_GPU_ID_SHIFT (46)
> >   #define KFD_MMAP_GPU_ID_MASK (((1ULL << KFD_GPU_ID_HASH_WIDTH) - 1) \
> >                                << KFD_MMAP_GPU_ID_SHIFT)
> >   #define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) <<
> KFD_MMAP_GPU_ID_SHIFT)\
> >                                & KFD_MMAP_GPU_ID_MASK)
> > -#define KFD_MMAP_GPU_ID_GET(offset)    ((offset &
> KFD_MMAP_GPU_ID_MASK) \
> > +#define KFD_MMAP_GET_GPU_ID(offset)    ((offset &
> KFD_MMAP_GPU_ID_MASK) \
> >                                >> KFD_MMAP_GPU_ID_SHIFT)
> >
> > -#define KFD_MMAP_OFFSET_VALUE_MASK (0x3FFFFFFFFFFFULL >> PAGE_SHIFT)
> > -#define KFD_MMAP_OFFSET_VALUE_GET(offset) (offset &
> KFD_MMAP_OFFSET_VALUE_MASK)
>
> This macro is still useful. See above. I think you should just update
> the mask and continue using it for clarity.
>
> Regards,
>    Felix
>
>
> > -
> >   /*
> >    * When working with cp scheduler we should assign the HIQ
> manually or via
> >    * the amdgpu driver to a fixed hqd slot, here are the fixed HIQ
> hqd slot
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > index 6abfb77ae540..39dc49b8fd85 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -554,8 +554,7 @@ static int kfd_process_init_cwsr_apu(struct
> kfd_process *p, struct file *filep)
> >                if (!dev->cwsr_enabled || qpd->cwsr_kaddr ||
> qpd->cwsr_base)
> >                        continue;
> >
> > -             offset =3D (KFD_MMAP_TYPE_RESERVED_MEM |
> KFD_MMAP_GPU_ID(dev->id))
> > -                     << PAGE_SHIFT;
> > +             offset =3D KFD_MMAP_TYPE_RESERVED_MEM |
> KFD_MMAP_GPU_ID(dev->id);
> >                qpd->tba_addr =3D (int64_t)vm_mmap(filep, 0,
> >                        KFD_CWSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,
> >                        MAP_SHARED, offset);

--_000_DM6PR12MB2778665DFDF4915AD20E84CFF07E0DM6PR12MB2778namp_
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
Okay. I will delete that line.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, November 5, 2019 5:34 PM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bi=
t operations</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2019-11-01 7:03 p.m., Zhao, Yong wrote:<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* only lea=
ve the offset segment */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_=
pgoff &amp;=3D (1ULL &lt;&lt; (KFD_MMAP_GPU_ID_SHIFT - PAGE_SHIFT)) - 1;<br=
>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; You're now open-coding what used to be done by=
 the<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MMAP_OFFSET_VALUE_GET macro. I don't see h=
ow this is an<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; improvement.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Maybe better to update the macro to do this.<b=
r>
&gt;<br>
&gt;<br>
&gt; I can definitely do that, but I think we'd better delete this line <br=
>
&gt; completely as it seems odd to change vm_pgoff. Moreover this vm_pgoff =
<br>
&gt; is not used at all in the following function calls. What do you think?=
<br>
<br>
I think you're right. Looks like a historical accident. I see that older <b=
r>
versions of kfd_event_mmap used to access vm_pgoff and probably depended <b=
r>
on this. We removed that in this commit:<br>
<br>
<br>
commit 50cb7dd94cb43a6204813376e1be1d21780b71fb<br>
Author: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
Date:&nbsp;&nbsp; Fri Oct 27 19:35:26 2017 -0400<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; drm/amdkfd: Simplify events page allocator<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; The first event page is always big enough to handl=
e all events.<br>
&nbsp;&nbsp;&nbsp;&nbsp; Handling of multiple events pages is not supported=
 by user mode, and<br>
&nbsp;&nbsp;&nbsp;&nbsp; not necessary.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Yong Zhao &lt;yong.zhao-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Felix Kuehling &lt;Felix.Kuehling@a=
md.com&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Acked-by: Oded Gabbay &lt;oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Oded Gabbay &lt;oded.gabbay@gmail.c=
om&gt;<br>
<br>
<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; Yong<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; *Sent:* Friday, November 1, 2019 6:48 PM<br>
&gt; *To:* Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org <br>
&gt; &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
&gt; *Subject:* Re: [PATCH] drm/amdkfd: Simplify the mmap offset related <b=
r>
&gt; bit operations<br>
&gt; On 2019-11-01 4:48 p.m., Zhao, Yong wrote:<br>
&gt; &gt; The new code is much cleaner and results in better readability.<b=
r>
&gt; &gt;<br>
&gt; &gt; Change-Id: I0c1f7cca7e24ddb7b4ffe1cb0fa71943828ae373<br>
&gt; &gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 13 &#43;&#=
43;&#43;&#43;&#43;&#43;&#43;------<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_events.c&nbsp; |&nbsp;=
 1 -<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbs=
p; |&nbsp; 9 &#43;&#43;&#43;------<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c |&nbsp; 3 &#=
43;--<br>
&gt; &gt;&nbsp;&nbsp; 4 files changed, 11 insertions(&#43;), 15 deletions(-=
)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; &gt; index b91993753b82..590138727ca9 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&gt; &gt; @@ -298,7 &#43;298,6 @@ static int kfd_ioctl_create_queue(struct =
file <br>
&gt; *filep, struct kfd_process *p,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Return gpu_id as doo=
rbell offset for mmap usage */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offse=
t =3D KFD_MMAP_TYPE_DOORBELL;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offse=
t |=3D KFD_MMAP_GPU_ID(args-&gt;gpu_id);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset &lt;&lt;=3D PA=
GE_SHIFT;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_IS_SOC15(dev-&g=
t;device_info-&gt;asic_family))<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /* On SOC15 ASICs, include the doorbell offset wit=
hin the<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * process doorbell frame, which could be 1 p=
age or 2 <br>
&gt; pages.<br>
&gt; &gt; @@ -1938,20 &#43;1937,22 @@ static int kfd_mmap(struct file *filp=
, <br>
&gt; struct vm_area_struct *vma)<br>
&gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *pro=
cess;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev =3D=
 NULL;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned long vm_pgoff;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long mmap_offset;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int gpu_id;<br=
>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process =3D kfd_get_pro=
cess(current);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(process))<br=
>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return PTR_ERR(process);<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; vm_pgoff =3D vma-&gt;vm_pgoff;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_pgoff =3D KFD_MMAP_OFFSET_VA=
LUE_GET(vm_pgoff);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; gpu_id =3D KFD_MMAP_GPU_ID_GET(vm_pgoff=
);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmap_offset =3D vma-&gt;vm_pgoff &l=
t;&lt; PAGE_SHIFT;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; gpu_id =3D KFD_MMAP_GET_GPU_ID(mmap=
_offset);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_id)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev =3D kfd_device_by_id(gpu_id);<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (vm_pgoff &amp; KFD_MMAP_TYPE_MA=
SK) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* only leave the offset segment */=
<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_pgoff &amp;=3D (1ULL &lt=
;&lt; (KFD_MMAP_GPU_ID_SHIFT - <br>
&gt; PAGE_SHIFT)) - 1;<br>
&gt;<br>
&gt; You're now open-coding what used to be done by the<br>
&gt; KFD_MMAP_OFFSET_VALUE_GET macro. I don't see how this is an improvemen=
t.<br>
&gt; Maybe better to update the macro to do this.<br>
&gt;<br>
&gt;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (mmap_offset &amp; KFD_MMAP_=
TYPE_MASK) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_MMAP_TYPE_DOOR=
BELL:<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!dev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -ENODEV;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c <br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&gt; &gt; index 908081c85de1..1f8365575b12 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&gt; &gt; @@ -346,7 &#43;346,6 @@ int kfd_event_create(struct file *devkfd,=
 struct <br>
&gt; kfd_process *p,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ret =3D create_signal_event(devkfd, p, ev);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
vent_page_offset =3D KFD_MMAP_TYPE_EVENTS;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *event_page_offset=
 &lt;&lt;=3D PAGE_SHIFT;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *e=
vent_slot_index =3D ev-&gt;event_id;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &gt; index 66bae8f2dad1..8eecd2cd1fd2 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &gt; @@ -59,24 &#43;59,21 @@<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; * NOTE: struct vm_area_struct.vm_pgoff uses off=
set in pages. <br>
&gt; Hence, these<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; *&nbsp; defines are w.r.t to PAGE_SIZE<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt; -#define KFD_MMAP_TYPE_SHIFT&nbsp; (62 - PAGE_SHIFT)<br>
&gt; &gt; &#43;#define KFD_MMAP_TYPE_SHIFT&nbsp; (62)<br>
&gt; &gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_MASK&nbsp; (0x3ULL &lt;&lt; KFD=
_MMAP_TYPE_SHIFT)<br>
&gt; &gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_DOORBELL&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (0x3ULL &lt;&lt; KFD_MMAP_TYPE_SHIFT)<br>
&gt; &gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_EVENTS&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; (0x2ULL &lt;&lt; KFD_MMAP_TYPE_SHIFT)<br>
&gt; &gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_RESERVED_MEM&nbsp; (0x1ULL &lt;=
&lt; KFD_MMAP_TYPE_SHIFT)<br>
&gt; &gt;&nbsp;&nbsp; #define KFD_MMAP_TYPE_MMIO&nbsp; (0x0ULL &lt;&lt; KFD=
_MMAP_TYPE_SHIFT)<br>
&gt; &gt;<br>
&gt; &gt; -#define KFD_MMAP_GPU_ID_SHIFT (46 - PAGE_SHIFT)<br>
&gt; &gt; &#43;#define KFD_MMAP_GPU_ID_SHIFT (46)<br>
&gt; &gt;&nbsp;&nbsp; #define KFD_MMAP_GPU_ID_MASK (((1ULL &lt;&lt; KFD_GPU=
_ID_HASH_WIDTH) - 1) \<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;&lt; KFD_MMAP_GPU_ID_SHIF=
T)<br>
&gt; &gt;&nbsp;&nbsp; #define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) =
&lt;&lt; <br>
&gt; KFD_MMAP_GPU_ID_SHIFT)\<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp; KFD_MMAP_GPU_ID_MASK)<b=
r>
&gt; &gt; -#define KFD_MMAP_GPU_ID_GET(offset)&nbsp;&nbsp;&nbsp; ((offset &=
amp; <br>
&gt; KFD_MMAP_GPU_ID_MASK) \<br>
&gt; &gt; &#43;#define KFD_MMAP_GET_GPU_ID(offset)&nbsp;&nbsp;&nbsp; ((offs=
et &amp; <br>
&gt; KFD_MMAP_GPU_ID_MASK) \<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; KFD_MMAP_GPU_ID_SHIF=
T)<br>
&gt; &gt;<br>
&gt; &gt; -#define KFD_MMAP_OFFSET_VALUE_MASK (0x3FFFFFFFFFFFULL &gt;&gt; P=
AGE_SHIFT)<br>
&gt; &gt; -#define KFD_MMAP_OFFSET_VALUE_GET(offset) (offset &amp; <br>
&gt; KFD_MMAP_OFFSET_VALUE_MASK)<br>
&gt;<br>
&gt; This macro is still useful. See above. I think you should just update<=
br>
&gt; the mask and continue using it for clarity.<br>
&gt;<br>
&gt; Regards,<br>
&gt; &nbsp;&nbsp; Felix<br>
&gt;<br>
&gt;<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp; /*<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; * When working with cp scheduler we should assi=
gn the HIQ <br>
&gt; manually or via<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; * the amdgpu driver to a fixed hqd slot, here a=
re the fixed HIQ <br>
&gt; hqd slot<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; &gt; index 6abfb77ae540..39dc49b8fd85 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; &gt; @@ -554,8 &#43;554,7 @@ static int kfd_process_init_cwsr_apu(stru=
ct <br>
&gt; kfd_process *p, struct file *filep)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!dev-&gt;cwsr_enabled || qpd-&gt;cwsr_kaddr ||=
 <br>
&gt; qpd-&gt;cwsr_base)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; co=
ntinue;<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; offset =3D (KFD_MMAP_TYPE_RESERVED_MEM | <br>
&gt; KFD_MMAP_GPU_ID(dev-&gt;id))<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;&lt; PAGE_SHIF=
T;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; offset =3D KFD_MMAP_TYPE_RESERVED_MEM | <br>
&gt; KFD_MMAP_GPU_ID(dev-&gt;id);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;tba_addr =3D (int64_t)vm_mmap(filep, 0,<br=
>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KF=
D_CWSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MA=
P_SHARED, offset);<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB2778665DFDF4915AD20E84CFF07E0DM6PR12MB2778namp_--

--===============0860220432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0860220432==--
