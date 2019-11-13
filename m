From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Eliminate ops_asic_specific in kernel
 queue
Date: Wed, 13 Nov 2019 18:30:53 +0000
Message-ID: <CY4PR12MB18134EB7A7E706091597D115F7760@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191112221839.30840-1-Yong.Zhao@amd.com>
 <20191112221839.30840-2-Yong.Zhao@amd.com>,
 <CY4PR1201MB2533EF7848C4831796DD20A185760@CY4PR1201MB2533.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1643622675=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR1201MB2533EF7848C4831796DD20A185760-1iTaO6aE1DCmssYNuJz6EmrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1643622675==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB18134EB7A7E706091597D115F7760CY4PR12MB1813namp_"

--_000_CY4PR12MB18134EB7A7E706091597D115F7760CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

CI just refers to the dGPUs (bonaire and hawaii), the CIK refers to the who=
le family (CI dGPUs, Indus (kaveri platform), and Kerala (kabini/mullins pl=
atform).

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Russell,=
 Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 13, 2019 8:28 AM
To: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
Cc: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amdkfd: Eliminate ops_asic_specific in kernel =
queue

Should we use "CI" instead of "CIK" in the comments? I thought CIK was a sh=
ort form for CI kickers, while CI encompasses all CI ASICs. Even though we =
had _cik as the suffix for most of the CI stuff. Just wondering about accur=
acy.

 Kent

-----Original Message-----
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Yong Zha=
o
Sent: Tuesday, November 12, 2019 5:19 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdkfd: Eliminate ops_asic_specific in kernel queu=
e

The ops_asic_specific function pointers are actually quite generic after us=
ing a simple if condition. Eliminate it by code refactoring.

Change-Id: Icb891289cca31acdbe2d2eea76a426f1738b9c08
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 63 ++++++++-----------  dr=
ivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h |  4 --  .../gpu/drm/amd/amdkfd=
/kfd_kernel_queue_v9.c  | 36 -----------  .../gpu/drm/amd/amdkfd/kfd_kernel=
_queue_vi.c  | 48 --------------
 4 files changed, 26 insertions(+), 125 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_kernel_queue.c
index a750b1d110eb..59ee9053498c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -87,9 +87,17 @@ static bool initialize(struct kernel_queue *kq, struct k=
fd_dev *dev,
         kq->pq_kernel_addr =3D kq->pq->cpu_ptr;
         kq->pq_gpu_addr =3D kq->pq->gpu_addr;

-       retval =3D kq->ops_asic_specific.initialize(kq, dev, type, queue_si=
ze);
-       if (!retval)
-               goto err_eop_allocate_vidmem;
+       /* For CIK family asics, kq->eop_mem is not needed */
+       if (dev->device_info->asic_family > CHIP_HAWAII) {
+               retval =3D kfd_gtt_sa_allocate(dev, PAGE_SIZE, &kq->eop_mem=
);
+               if (retval !=3D 0)
+                       goto err_eop_allocate_vidmem;
+
+               kq->eop_gpu_addr =3D kq->eop_mem->gpu_addr;
+               kq->eop_kernel_addr =3D kq->eop_mem->cpu_ptr;
+
+               memset(kq->eop_kernel_addr, 0, PAGE_SIZE);
+       }

         retval =3D kfd_gtt_sa_allocate(dev, sizeof(*kq->rptr_kernel),
                                         &kq->rptr_mem);
@@ -200,7 +208,12 @@ static void uninitialize(struct kernel_queue *kq)

         kfd_gtt_sa_free(kq->dev, kq->rptr_mem);
         kfd_gtt_sa_free(kq->dev, kq->wptr_mem);
-       kq->ops_asic_specific.uninitialize(kq);
+
+       /* For CIK family asics, kq->eop_mem is Null, kfd_gtt_sa_free()
+        * is able to handle NULL properly.
+        */
+       kfd_gtt_sa_free(kq->dev, kq->eop_mem);
+
         kfd_gtt_sa_free(kq->dev, kq->pq);
         kfd_release_kernel_doorbell(kq->dev,
                                         kq->queue->properties.doorbell_ptr=
);
@@ -280,8 +293,15 @@ static void submit_packet(struct kernel_queue *kq)
         }
         pr_debug("\n");
 #endif
-
-       kq->ops_asic_specific.submit_packet(kq);
+       if (kq->dev->device_info->doorbell_size =3D=3D 8) {
+               *kq->wptr64_kernel =3D kq->pending_wptr64;
+               write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
+                                       kq->pending_wptr64);
+       } else {
+               *kq->wptr_kernel =3D kq->pending_wptr;
+               write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
+                                       kq->pending_wptr);
+       }
 }

 static void rollback_packet(struct kernel_queue *kq) @@ -310,42 +330,11 @@=
 struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
         kq->ops.submit_packet =3D submit_packet;
         kq->ops.rollback_packet =3D rollback_packet;

-       switch (dev->device_info->asic_family) {
-       case CHIP_KAVERI:
-       case CHIP_HAWAII:
-       case CHIP_CARRIZO:
-       case CHIP_TONGA:
-       case CHIP_FIJI:
-       case CHIP_POLARIS10:
-       case CHIP_POLARIS11:
-       case CHIP_POLARIS12:
-       case CHIP_VEGAM:
-               kernel_queue_init_vi(&kq->ops_asic_specific);
-               break;
-
-       case CHIP_VEGA10:
-       case CHIP_VEGA12:
-       case CHIP_VEGA20:
-       case CHIP_RAVEN:
-       case CHIP_RENOIR:
-       case CHIP_ARCTURUS:
-       case CHIP_NAVI10:
-       case CHIP_NAVI12:
-       case CHIP_NAVI14:
-               kernel_queue_init_v9(&kq->ops_asic_specific);
-               break;
-       default:
-               WARN(1, "Unexpected ASIC family %u",
-                    dev->device_info->asic_family);
-               goto out_free;
-       }
-
         if (kq->ops.initialize(kq, dev, type, KFD_KERNEL_QUEUE_SIZE))
                 return kq;

         pr_err("Failed to init kernel queue\n");

-out_free:
         kfree(kq);
         return NULL;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h b/drivers/gpu/dr=
m/amd/amdkfd/kfd_kernel_queue.h
index a9a35897d8b7..475e9499c0af 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
@@ -66,7 +66,6 @@ struct kernel_queue_ops {

 struct kernel_queue {
         struct kernel_queue_ops ops;
-       struct kernel_queue_ops ops_asic_specific;

         /* data */
         struct kfd_dev          *dev;
@@ -99,7 +98,4 @@ struct kernel_queue {
         struct list_head        list;
 };

-void kernel_queue_init_vi(struct kernel_queue_ops *ops); -void kernel_queu=
e_init_v9(struct kernel_queue_ops *ops);
-
 #endif /* KFD_KERNEL_QUEUE_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_kernel_queue_v9.c
index 9e0eaf446bab..2de01009f1b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
@@ -27,42 +27,6 @@
 #include "kfd_pm4_opcodes.h"
 #include "gc/gc_10_1_0_sh_mask.h"

-static bool initialize_v9(struct kernel_queue *kq, struct kfd_dev *dev,
-                       enum kfd_queue_type type, unsigned int queue_size)
-{
-       int retval;
-
-       retval =3D kfd_gtt_sa_allocate(dev, PAGE_SIZE, &kq->eop_mem);
-       if (retval)
-               return false;
-
-       kq->eop_gpu_addr =3D kq->eop_mem->gpu_addr;
-       kq->eop_kernel_addr =3D kq->eop_mem->cpu_ptr;
-
-       memset(kq->eop_kernel_addr, 0, PAGE_SIZE);
-
-       return true;
-}
-
-static void uninitialize_v9(struct kernel_queue *kq) -{
-       kfd_gtt_sa_free(kq->dev, kq->eop_mem);
-}
-
-static void submit_packet_v9(struct kernel_queue *kq) -{
-       *kq->wptr64_kernel =3D kq->pending_wptr64;
-       write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
-                               kq->pending_wptr64);
-}
-
-void kernel_queue_init_v9(struct kernel_queue_ops *ops) -{
-       ops->initialize =3D initialize_v9;
-       ops->uninitialize =3D uninitialize_v9;
-       ops->submit_packet =3D submit_packet_v9;
-}
-
 static int pm_map_process_v9(struct packet_manager *pm,
                 uint32_t *buffer, struct qcm_process_device *qpd)  { diff =
--git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_kernel_queue_vi.c
index 64f13f34d819..bed4d0ccb6b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
@@ -26,54 +26,6 @@
 #include "kfd_pm4_headers_vi.h"
 #include "kfd_pm4_opcodes.h"

-static bool initialize_vi(struct kernel_queue *kq, struct kfd_dev *dev,
-                       enum kfd_queue_type type, unsigned int queue_size);
-static void uninitialize_vi(struct kernel_queue *kq); -static void submit_=
packet_vi(struct kernel_queue *kq);
-
-void kernel_queue_init_vi(struct kernel_queue_ops *ops) -{
-       ops->initialize =3D initialize_vi;
-       ops->uninitialize =3D uninitialize_vi;
-       ops->submit_packet =3D submit_packet_vi;
-}
-
-static bool initialize_vi(struct kernel_queue *kq, struct kfd_dev *dev,
-                       enum kfd_queue_type type, unsigned int queue_size)
-{
-       int retval;
-
-       /*For CIK family asics, kq->eop_mem is not needed */
-       if (dev->device_info->asic_family <=3D CHIP_HAWAII)
-               return true;
-
-       retval =3D kfd_gtt_sa_allocate(dev, PAGE_SIZE, &kq->eop_mem);
-       if (retval !=3D 0)
-               return false;
-
-       kq->eop_gpu_addr =3D kq->eop_mem->gpu_addr;
-       kq->eop_kernel_addr =3D kq->eop_mem->cpu_ptr;
-
-       memset(kq->eop_kernel_addr, 0, PAGE_SIZE);
-
-       return true;
-}
-
-static void uninitialize_vi(struct kernel_queue *kq) -{
-       /* For CIK family asics, kq->eop_mem is Null, kfd_gtt_sa_free()
-        * is able to handle NULL properly.
-        */
-       kfd_gtt_sa_free(kq->dev, kq->eop_mem);
-}
-
-static void submit_packet_vi(struct kernel_queue *kq) -{
-       *kq->wptr_kernel =3D kq->pending_wptr;
-       write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
-                               kq->pending_wptr);
-}
-
 unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size) =
 {
         union PM4_MES_TYPE_3_HEADER header;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB18134EB7A7E706091597D115F7760CY4PR12MB1813namp_
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
CI just refers to the dGPUs (bonaire and hawaii), the CIK refers to the who=
le family (CI dGPUs, Indus (kaveri platform), and Kerala (kabini/mullins pl=
atform).</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Russell, Kent &lt;Kent.Russel=
l@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 13, 2019 8:28 AM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdkfd: Eliminate ops_asic_specific in =
kernel queue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Should we use &quot;CI&quot; instead of &quot;CIK&=
quot; in the comments? I thought CIK was a short form for CI kickers, while=
 CI encompasses all CI ASICs. Even though we had _cik as the suffix for mos=
t of the CI stuff. Just wondering about accuracy.<br>
<br>
&nbsp;Kent<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf Of Yo=
ng Zhao<br>
Sent: Tuesday, November 12, 2019 5:19 PM<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: [PATCH 2/2] drm/amdkfd: Eliminate ops_asic_specific in kernel queu=
e<br>
<br>
The ops_asic_specific function pointers are actually quite generic after us=
ing a simple if condition. Eliminate it by code refactoring.<br>
<br>
Change-Id: Icb891289cca31acdbe2d2eea76a426f1738b9c08<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 63 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;-----------&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_kern=
el_queue.h |&nbsp; 4 --&nbsp; .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c&=
nbsp; | 36 -----------&nbsp; .../gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c&n=
bsp; | 48 --------------<br>
&nbsp;4 files changed, 26 insertions(&#43;), 125 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_kernel_queue.c<br>
index a750b1d110eb..59ee9053498c 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c<br>
@@ -87,9 &#43;87,17 @@ static bool initialize(struct kernel_queue *kq, stru=
ct kfd_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;pq_kernel_addr =3D =
kq-&gt;pq-&gt;cpu_ptr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;pq_gpu_addr =3D kq-=
&gt;pq-&gt;gpu_addr;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D kq-&gt;ops_asic_specific.i=
nitialize(kq, dev, type, queue_size);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!retval)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto err_eop_allocate_vidmem;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For CIK family asics, kq-&gt;e=
op_mem is not needed */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;device_info-&gt;asic_=
family &gt; CHIP_HAWAII) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; retval =3D kfd_gtt_sa_allocate(dev, PAGE_SIZE, &amp;kq-&gt;e=
op_mem);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (retval !=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_eop=
_allocate_vidmem;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; kq-&gt;eop_gpu_addr =3D kq-&gt;eop_mem-&gt;gpu_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; kq-&gt;eop_kernel_addr =3D kq-&gt;eop_mem-&gt;cpu_ptr;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; memset(kq-&gt;eop_kernel_addr, 0, PAGE_SIZE);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D kfd_gtt_sa_allo=
cate(dev, sizeof(*kq-&gt;rptr_kernel),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;kq-&gt;rptr_mem);<br>
@@ -200,7 &#43;208,12 @@ static void uninitialize(struct kernel_queue *kq)<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_gtt_sa_free(kq-&gt;dev=
, kq-&gt;rptr_mem);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_gtt_sa_free(kq-&gt;dev=
, kq-&gt;wptr_mem);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;ops_asic_specific.uninitialize=
(kq);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For CIK family asics, kq-&gt;e=
op_mem is Null, kfd_gtt_sa_free()<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is able to handle NULL pr=
operly.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_gtt_sa_free(kq-&gt;dev, kq-&g=
t;eop_mem);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_gtt_sa_free(kq-&gt;dev=
, kq-&gt;pq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_release_kernel_doorbel=
l(kq-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kq-&gt;queue-&gt;properties.doorbell_ptr);<br>
@@ -280,8 &#43;293,15 @@ static void submit_packet(struct kernel_queue *kq)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;\n&quot;);<=
br>
&nbsp;#endif<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;ops_asic_specific.submit_packe=
t(kq);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kq-&gt;dev-&gt;device_info-&g=
t;doorbell_size =3D=3D 8) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *kq-&gt;wptr64_kernel =3D kq-&gt;pending_wptr64;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; write_kernel_doorbell64(kq-&gt;queue-&gt;properties.doorbell=
_ptr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; kq-&gt;pending_wptr64);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *kq-&gt;wptr_kernel =3D kq-&gt;pending_wptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; write_kernel_doorbell(kq-&gt;queue-&gt;properties.doorbell_p=
tr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; kq-&gt;pending_wptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void rollback_packet(struct kernel_queue *kq) @@ -310,42 &#43;=
330,11 @@ struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;ops.submit_packet =
=3D submit_packet;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;ops.rollback_packet=
 =3D rollback_packet;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (dev-&gt;device_info-&gt;asic_=
family) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_KAVERI:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_HAWAII:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CARRIZO:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_TONGA:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_FIJI:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS10:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS11:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS12:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGAM:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kernel_queue_init_vi(&amp;kq-&gt;ops_asic_specific);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA10:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA12:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ARCTURUS:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kernel_queue_init_v9(&amp;kq-&gt;ops_asic_specific);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WARN(1, &quot;Unexpected ASIC family %u&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;device_info-&gt;asic_famil=
y);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out_free;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kq-&gt;ops.initialize(=
kq, dev, type, KFD_KERNEL_QUEUE_SIZE))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return kq;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to ini=
t kernel queue\n&quot;);<br>
&nbsp;<br>
-out_free:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(kq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h b/drivers/gpu/dr=
m/amd/amdkfd/kfd_kernel_queue.h<br>
index a9a35897d8b7..475e9499c0af 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h<br>
@@ -66,7 &#43;66,6 @@ struct kernel_queue_ops {<br>
&nbsp;<br>
&nbsp;struct kernel_queue {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kernel_queue_ops op=
s;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kernel_queue_ops ops_asic_spec=
ific;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* data */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dev;<br>
@@ -99,7 &#43;98,4 @@ struct kernel_queue {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list;<br>
&nbsp;};<br>
&nbsp;<br>
-void kernel_queue_init_vi(struct kernel_queue_ops *ops); -void kernel_queu=
e_init_v9(struct kernel_queue_ops *ops);<br>
-<br>
&nbsp;#endif /* KFD_KERNEL_QUEUE_H_ */<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
index 9e0eaf446bab..2de01009f1b6 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
@@ -27,42 &#43;27,6 @@<br>
&nbsp;#include &quot;kfd_pm4_opcodes.h&quot;<br>
&nbsp;#include &quot;gc/gc_10_1_0_sh_mask.h&quot;<br>
&nbsp;<br>
-static bool initialize_v9(struct kernel_queue *kq, struct kfd_dev *dev,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum kfd_queue_t=
ype type, unsigned int queue_size)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D kfd_gtt_sa_allocate(dev, P=
AGE_SIZE, &amp;kq-&gt;eop_mem);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;eop_gpu_addr =3D kq-&gt;eop_me=
m-&gt;gpu_addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;eop_kernel_addr =3D kq-&gt;eop=
_mem-&gt;cpu_ptr;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(kq-&gt;eop_kernel_addr, 0, PAG=
E_SIZE);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
-}<br>
-<br>
-static void uninitialize_v9(struct kernel_queue *kq) -{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_gtt_sa_free(kq-&gt;dev, kq-&gt;eo=
p_mem);<br>
-}<br>
-<br>
-static void submit_packet_v9(struct kernel_queue *kq) -{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *kq-&gt;wptr64_kernel =3D kq-&gt;pend=
ing_wptr64;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_kernel_doorbell64(kq-&gt;queue-=
&gt;properties.doorbell_ptr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;pending_wptr64);<br>
-}<br>
-<br>
-void kernel_queue_init_v9(struct kernel_queue_ops *ops) -{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&gt;initialize =3D initialize_v9;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&gt;uninitialize =3D uninitialize=
_v9;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&gt;submit_packet =3D submit_pack=
et_v9;<br>
-}<br>
-<br>
&nbsp;static int pm_map_process_v9(struct packet_manager *pm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t *buffer, struct qcm_process_device *qpd)&nbs=
p; { diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c<br>
index 64f13f34d819..bed4d0ccb6b1 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c<br>
@@ -26,54 &#43;26,6 @@<br>
&nbsp;#include &quot;kfd_pm4_headers_vi.h&quot;<br>
&nbsp;#include &quot;kfd_pm4_opcodes.h&quot;<br>
&nbsp;<br>
-static bool initialize_vi(struct kernel_queue *kq, struct kfd_dev *dev,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum kfd_queue_t=
ype type, unsigned int queue_size);<br>
-static void uninitialize_vi(struct kernel_queue *kq); -static void submit_=
packet_vi(struct kernel_queue *kq);<br>
-<br>
-void kernel_queue_init_vi(struct kernel_queue_ops *ops) -{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&gt;initialize =3D initialize_vi;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&gt;uninitialize =3D uninitialize=
_vi;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&gt;submit_packet =3D submit_pack=
et_vi;<br>
-}<br>
-<br>
-static bool initialize_vi(struct kernel_queue *kq, struct kfd_dev *dev,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum kfd_queue_t=
ype type, unsigned int queue_size)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*For CIK family asics, kq-&gt;eop_me=
m is not needed */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;device_info-&gt;asic_fami=
ly &lt;=3D CHIP_HAWAII)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D kfd_gtt_sa_allocate(dev, P=
AGE_SIZE, &amp;kq-&gt;eop_mem);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval !=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;eop_gpu_addr =3D kq-&gt;eop_me=
m-&gt;gpu_addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;eop_kernel_addr =3D kq-&gt;eop=
_mem-&gt;cpu_ptr;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(kq-&gt;eop_kernel_addr, 0, PAG=
E_SIZE);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
-}<br>
-<br>
-static void uninitialize_vi(struct kernel_queue *kq) -{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For CIK family asics, kq-&gt;eop_m=
em is Null, kfd_gtt_sa_free()<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is able to handle NULL proper=
ly.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_gtt_sa_free(kq-&gt;dev, kq-&gt;eo=
p_mem);<br>
-}<br>
-<br>
-static void submit_packet_vi(struct kernel_queue *kq) -{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *kq-&gt;wptr_kernel =3D kq-&gt;pendin=
g_wptr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_kernel_doorbell(kq-&gt;queue-&g=
t;properties.doorbell_ptr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;pending_wptr);<br>
-}<br>
-<br>
&nbsp;unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_s=
ize)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union PM4_MES_TYPE_3_HEADE=
R header;<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB18134EB7A7E706091597D115F7760CY4PR12MB1813namp_--

--===============1643622675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1643622675==--
