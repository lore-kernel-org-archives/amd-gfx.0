From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Simplify the mmap offset related bit
 operations
Date: Fri, 1 Nov 2019 20:50:02 +0000
Message-ID: <DM6PR12MB2778D1D6CA1EAE57D77078BCF0620@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191101201138.6125-1-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0254696827=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191101201138.6125-1-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0254696827==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778D1D6CA1EAE57D77078BCF0620DM6PR12MB2778namp_"

--_000_DM6PR12MB2778D1D6CA1EAE57D77078BCF0620DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please discard this one and look for an update version.

Regards,
Yong
________________________________
From: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, November 1, 2019 4:11 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdkfd: Simplify the mmap offset related bit operation=
s

The new code is much cleaner and results in better readability.

Change-Id: I0c1f7cca7e24ddb7b4ffe1cb0fa71943828ae373
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 ++++------
 drivers/gpu/drm/amd/amdkfd/kfd_events.c  |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 +++------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +--
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index b91993753b82..34078df36621 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -298,7 +298,6 @@ static int kfd_ioctl_create_queue(struct file *filep, s=
truct kfd_process *p,
         /* Return gpu_id as doorbell offset for mmap usage */
         args->doorbell_offset =3D KFD_MMAP_TYPE_DOORBELL;
         args->doorbell_offset |=3D KFD_MMAP_GPU_ID(args->gpu_id);
-       args->doorbell_offset <<=3D PAGE_SHIFT;
         if (KFD_IS_SOC15(dev->device_info->asic_family))
                 /* On SOC15 ASICs, include the doorbell offset within the
                  * process doorbell frame, which could be 1 page or 2 page=
s.
@@ -1938,20 +1937,19 @@ static int kfd_mmap(struct file *filp, struct vm_ar=
ea_struct *vma)
 {
         struct kfd_process *process;
         struct kfd_dev *dev =3D NULL;
-       unsigned long vm_pgoff;
+       unsigned long mmap_offset;
         unsigned int gpu_id;

         process =3D kfd_get_process(current);
         if (IS_ERR(process))
                 return PTR_ERR(process);

-       vm_pgoff =3D vma->vm_pgoff;
-       vma->vm_pgoff =3D KFD_MMAP_OFFSET_VALUE_GET(vm_pgoff);
-       gpu_id =3D KFD_MMAP_GPU_ID_GET(vm_pgoff);
+       mmap_offset =3D vma->vm_pgoff << PAGE_SHIFT;
+       gpu_id =3D KFD_MMAP_GET_GPU_ID(mmap_offset);
         if (gpu_id)
                 dev =3D kfd_device_by_id(gpu_id);

-       switch (vm_pgoff & KFD_MMAP_TYPE_MASK) {
+       switch (mmap_offset & KFD_MMAP_TYPE_MASK) {
         case KFD_MMAP_TYPE_DOORBELL:
                 if (!dev)
                         return -ENODEV;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c
index 908081c85de1..1f8365575b12 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -346,7 +346,6 @@ int kfd_event_create(struct file *devkfd, struct kfd_pr=
ocess *p,
                 ret =3D create_signal_event(devkfd, p, ev);
                 if (!ret) {
                         *event_page_offset =3D KFD_MMAP_TYPE_EVENTS;
-                       *event_page_offset <<=3D PAGE_SHIFT;
                         *event_slot_index =3D ev->event_id;
                 }
                 break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 66bae8f2dad1..8eecd2cd1fd2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -59,24 +59,21 @@
  * NOTE: struct vm_area_struct.vm_pgoff uses offset in pages. Hence, these
  *  defines are w.r.t to PAGE_SIZE
  */
-#define KFD_MMAP_TYPE_SHIFT    (62 - PAGE_SHIFT)
+#define KFD_MMAP_TYPE_SHIFT    (62)
 #define KFD_MMAP_TYPE_MASK      (0x3ULL << KFD_MMAP_TYPE_SHIFT)
 #define KFD_MMAP_TYPE_DOORBELL  (0x3ULL << KFD_MMAP_TYPE_SHIFT)
 #define KFD_MMAP_TYPE_EVENTS    (0x2ULL << KFD_MMAP_TYPE_SHIFT)
 #define KFD_MMAP_TYPE_RESERVED_MEM      (0x1ULL << KFD_MMAP_TYPE_SHIFT)
 #define KFD_MMAP_TYPE_MMIO      (0x0ULL << KFD_MMAP_TYPE_SHIFT)

-#define KFD_MMAP_GPU_ID_SHIFT (46 - PAGE_SHIFT)
+#define KFD_MMAP_GPU_ID_SHIFT (46)
 #define KFD_MMAP_GPU_ID_MASK (((1ULL << KFD_GPU_ID_HASH_WIDTH) - 1) \
                                 << KFD_MMAP_GPU_ID_SHIFT)
 #define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) << KFD_MMAP_GPU_ID_SH=
IFT)\
                                 & KFD_MMAP_GPU_ID_MASK)
-#define KFD_MMAP_GPU_ID_GET(offset)    ((offset & KFD_MMAP_GPU_ID_MASK) \
+#define KFD_MMAP_GET_GPU_ID(offset)    ((offset & KFD_MMAP_GPU_ID_MASK) \
                                 >> KFD_MMAP_GPU_ID_SHIFT)

-#define KFD_MMAP_OFFSET_VALUE_MASK     (0x3FFFFFFFFFFFULL >> PAGE_SHIFT)
-#define KFD_MMAP_OFFSET_VALUE_GET(offset) (offset & KFD_MMAP_OFFSET_VALUE_=
MASK)
-
 /*
  * When working with cp scheduler we should assign the HIQ manually or via
  * the amdgpu driver to a fixed hqd slot, here are the fixed HIQ hqd slot
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index 6abfb77ae540..39dc49b8fd85 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -554,8 +554,7 @@ static int kfd_process_init_cwsr_apu(struct kfd_process=
 *p, struct file *filep)
                 if (!dev->cwsr_enabled || qpd->cwsr_kaddr || qpd->cwsr_bas=
e)
                         continue;

-               offset =3D (KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(de=
v->id))
-                       << PAGE_SHIFT;
+               offset =3D KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev=
->id);
                 qpd->tba_addr =3D (int64_t)vm_mmap(filep, 0,
                         KFD_CWSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,
                         MAP_SHARED, offset);
--
2.17.1


--_000_DM6PR12MB2778D1D6CA1EAE57D77078BCF0620DM6PR12MB2778namp_
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
Please discard this one and look for an update version.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhao, Yong &lt;Yong.Z=
hao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, November 1, 2019 4:11 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Simplify the mmap offset related bit op=
erations</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The new code is much cleaner and results in better=
 readability.<br>
<br>
Change-Id: I0c1f7cca7e24ddb7b4ffe1cb0fa71943828ae373<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 &#43;&#43;&#43;&#43;---=
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_events.c&nbsp; |&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 9 &#4=
3;&#43;&#43;------<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c |&nbsp; 3 &#43;--<br>
&nbsp;4 files changed, 8 insertions(&#43;), 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index b91993753b82..34078df36621 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -298,7 &#43;298,6 @@ static int kfd_ioctl_create_queue(struct file *file=
p, struct kfd_process *p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Return gpu_id as doorbe=
ll offset for mmap usage */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset =
=3D KFD_MMAP_TYPE_DOORBELL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset |=
=3D KFD_MMAP_GPU_ID(args-&gt;gpu_id);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;doorbell_offset &lt;&lt;=3D =
PAGE_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_IS_SOC15(dev-&gt;d=
evice_info-&gt;asic_family))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* On SOC15 ASICs, include the doorbell offset within=
 the<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * process doorbell frame, which could be 1 page=
 or 2 pages.<br>
@@ -1938,20 &#43;1937,19 @@ static int kfd_mmap(struct file *filp, struct v=
m_area_struct *vma)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *proces=
s;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev =3D NU=
LL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long vm_pgoff;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long mmap_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int gpu_id;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process =3D kfd_get_proces=
s(current);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(process))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return PTR_ERR(process);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_pgoff =3D vma-&gt;vm_pgoff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_pgoff =3D KFD_MMAP_OFFSET_=
VALUE_GET(vm_pgoff);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_id =3D KFD_MMAP_GPU_ID_GET(vm_pgo=
ff);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_offset =3D vma-&gt;vm_pgoff =
&lt;&lt; PAGE_SHIFT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_id =3D KFD_MMAP_GET_GPU_ID(mm=
ap_offset);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev =3D kfd_device_by_id(gpu_id);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (vm_pgoff &amp; KFD_MMAP_TYPE_=
MASK) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (mmap_offset &amp; KFD_MMA=
P_TYPE_MASK) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_MMAP_TYPE_DOORBEL=
L:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENODEV;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c<br>
index 908081c85de1..1f8365575b12 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
@@ -346,7 &#43;346,6 @@ int kfd_event_create(struct file *devkfd, struct kf=
d_process *p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D create_signal_event(devkfd, p, ev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *even=
t_page_offset =3D KFD_MMAP_TYPE_EVENTS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *event_page_offs=
et &lt;&lt;=3D PAGE_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *even=
t_slot_index =3D ev-&gt;event_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index 66bae8f2dad1..8eecd2cd1fd2 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -59,24 &#43;59,21 @@<br>
&nbsp; * NOTE: struct vm_area_struct.vm_pgoff uses offset in pages. Hence, =
these<br>
&nbsp; *&nbsp; defines are w.r.t to PAGE_SIZE<br>
&nbsp; */<br>
-#define KFD_MMAP_TYPE_SHIFT&nbsp;&nbsp;&nbsp; (62 - PAGE_SHIFT)<br>
&#43;#define KFD_MMAP_TYPE_SHIFT&nbsp;&nbsp;&nbsp; (62)<br>
&nbsp;#define KFD_MMAP_TYPE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x3ULL &lt;=
&lt; KFD_MMAP_TYPE_SHIFT)<br>
&nbsp;#define KFD_MMAP_TYPE_DOORBELL&nbsp; (0x3ULL &lt;&lt; KFD_MMAP_TYPE_S=
HIFT)<br>
&nbsp;#define KFD_MMAP_TYPE_EVENTS&nbsp;&nbsp;&nbsp; (0x2ULL &lt;&lt; KFD_M=
MAP_TYPE_SHIFT)<br>
&nbsp;#define KFD_MMAP_TYPE_RESERVED_MEM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x1=
ULL &lt;&lt; KFD_MMAP_TYPE_SHIFT)<br>
&nbsp;#define KFD_MMAP_TYPE_MMIO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x0ULL &lt;=
&lt; KFD_MMAP_TYPE_SHIFT)<br>
&nbsp;<br>
-#define KFD_MMAP_GPU_ID_SHIFT (46 - PAGE_SHIFT)<br>
&#43;#define KFD_MMAP_GPU_ID_SHIFT (46)<br>
&nbsp;#define KFD_MMAP_GPU_ID_MASK (((1ULL &lt;&lt; KFD_GPU_ID_HASH_WIDTH) =
- 1) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;&lt; KFD_MMAP_GPU_ID_SHIFT)<=
br>
&nbsp;#define KFD_MMAP_GPU_ID(gpu_id) ((((uint64_t)gpu_id) &lt;&lt; KFD_MMA=
P_GPU_ID_SHIFT)\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp; KFD_MMAP_GPU_ID_MASK)<br>
-#define KFD_MMAP_GPU_ID_GET(offset)&nbsp;&nbsp;&nbsp; ((offset &amp; KFD_M=
MAP_GPU_ID_MASK) \<br>
&#43;#define KFD_MMAP_GET_GPU_ID(offset)&nbsp;&nbsp;&nbsp; ((offset &amp; K=
FD_MMAP_GPU_ID_MASK) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; KFD_MMAP_GPU_ID_SHIFT)<=
br>
&nbsp;<br>
-#define KFD_MMAP_OFFSET_VALUE_MASK&nbsp;&nbsp;&nbsp;&nbsp; (0x3FFFFFFFFFFF=
ULL &gt;&gt; PAGE_SHIFT)<br>
-#define KFD_MMAP_OFFSET_VALUE_GET(offset) (offset &amp; KFD_MMAP_OFFSET_VA=
LUE_MASK)<br>
-<br>
&nbsp;/*<br>
&nbsp; * When working with cp scheduler we should assign the HIQ manually o=
r via<br>
&nbsp; * the amdgpu driver to a fixed hqd slot, here are the fixed HIQ hqd =
slot<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index 6abfb77ae540..39dc49b8fd85 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -554,8 &#43;554,7 @@ static int kfd_process_init_cwsr_apu(struct kfd_pro=
cess *p, struct file *filep)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!dev-&gt;cwsr_enabled || qpd-&gt;cwsr_kaddr || qp=
d-&gt;cwsr_base)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; offset =3D (KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev-&gt=
;id))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;&lt; PAGE_SH=
IFT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; offset =3D KFD_MMAP_TYPE_RESERVED_MEM | KFD_MMAP_GPU_ID(dev-=
&gt;id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; qpd-&gt;tba_addr =3D (int64_t)vm_mmap(filep, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_C=
WSR_TBA_TMA_SIZE, PROT_READ | PROT_EXEC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAP_S=
HARED, offset);<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB2778D1D6CA1EAE57D77078BCF0620DM6PR12MB2778namp_--

--===============0254696827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0254696827==--
