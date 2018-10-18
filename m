From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdkfd: Add proper prefix to functions
Date: Thu, 18 Oct 2018 22:03:13 +0000
Message-ID: <DM5PR12MB182014BE6C9AD85DD08289F0F7F80@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1539897297-12082-1-git-send-email-Amber.Lin@amd.com>,
 <1539897297-12082-3-git-send-email-Amber.Lin@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1363532391=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539897297-12082-3-git-send-email-Amber.Lin-5C7GfCeVMHo@public.gmane.org>
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
To: "Lin, Amber" <Amber.Lin-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1363532391==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB182014BE6C9AD85DD08289F0F7F80DM5PR12MB1820namp_"

--_000_DM5PR12MB182014BE6C9AD85DD08289F0F7F80DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Lin, Amb=
er <Amber.Lin-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, October 18, 2018 5:15:24 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Lin, Amber
Subject: [PATCH 3/3] drm/amdkfd: Add proper prefix to functions

Add amdgpu_amdkfd_ prefix to amdgpu functions served for amdkfd usage.

Signed-off-by: Amber Lin <Amber.Lin-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      | 12 ++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c        |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c           |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c         |  6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c       |  8 ++++----
 8 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index c31a884..4e384ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -268,7 +268,7 @@ void amdgpu_amdkfd_gpu_reset(struct kgd_dev *kgd)
                 amdgpu_device_gpu_recover(adev, NULL);
 }

-int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
+int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
                         void **mem_obj, uint64_t *gpu_addr,
                         void **cpu_ptr, bool mqd_gfx9)
 {
@@ -340,7 +340,7 @@ int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
         return r;
 }

-void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj)
+void amdgpu_amdkfd_free_gtt_mem(struct kgd_dev *kgd, void *mem_obj)
 {
         struct amdgpu_bo *bo =3D (struct amdgpu_bo *) mem_obj;

@@ -351,7 +351,7 @@ void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj)
         amdgpu_bo_unref(&(bo));
 }

-void get_local_mem_info(struct kgd_dev *kgd,
+void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
                         struct kfd_local_mem_info *mem_info)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
@@ -383,7 +383,7 @@ void get_local_mem_info(struct kgd_dev *kgd,
                 mem_info->mem_clk_max =3D 100;
 }

-uint64_t get_gpu_clock_counter(struct kgd_dev *kgd)
+uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct kgd_dev *kgd)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;

@@ -392,7 +392,7 @@ uint64_t get_gpu_clock_counter(struct kgd_dev *kgd)
         return 0;
 }

-uint32_t get_max_engine_clock_in_mhz(struct kgd_dev *kgd)
+uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;

@@ -405,7 +405,7 @@ uint32_t get_max_engine_clock_in_mhz(struct kgd_dev *kg=
d)
                 return 100;
 }

-void get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu_info)
+void amdgpu_amdkfd_get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu=
_info)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
         struct amdgpu_cu_info acu_info =3D adev->gfx.cu_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 8e0d4f7..69cc9a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -134,16 +134,16 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *ad=
ev);
 void amdgpu_amdkfd_gpu_reset(struct kgd_dev *kgd);

 /* Shared API */
-int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
+int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
                         void **mem_obj, uint64_t *gpu_addr,
                         void **cpu_ptr, bool mqd_gfx9);
-void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj);
-void get_local_mem_info(struct kgd_dev *kgd,
+void amdgpu_amdkfd_free_gtt_mem(struct kgd_dev *kgd, void *mem_obj);
+void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
                         struct kfd_local_mem_info *mem_info);
-uint64_t get_gpu_clock_counter(struct kgd_dev *kgd);
+uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct kgd_dev *kgd);

-uint32_t get_max_engine_clock_in_mhz(struct kgd_dev *kgd);
-void get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu_info);
+uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd);
+void amdgpu_amdkfd_get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu=
_info);
 uint64_t amdgpu_amdkfd_get_vram_usage(struct kgd_dev *kgd);
 uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd);

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 85e833d..5f4062b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -835,7 +835,7 @@ static int kfd_ioctl_get_clock_counters(struct file *fi=
lep,
         dev =3D kfd_device_by_id(args->gpu_id);
         if (dev)
                 /* Reading GPU clock counter from KGD */
-               args->gpu_clock_counter =3D get_gpu_clock_counter(dev->kgd)=
;
+               args->gpu_clock_counter =3D amdgpu_amdkfd_get_gpu_clock_cou=
nter(dev->kgd);
         else
                 /* Node without GPU resource */
                 args->gpu_clock_counter =3D 0;
@@ -1240,7 +1240,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
         if (dev->device_info->needs_iommu_device)
                 return false;

-       get_local_mem_info(dev->kgd, &mem_info);
+       amdgpu_amdkfd_get_local_mem_info(dev->kgd, &mem_info);
         if (mem_info.local_mem_size_private =3D=3D 0 &&
                         mem_info.local_mem_size_public > 0)
                 return true;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index a48be99..3783d12 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1160,7 +1160,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_ima=
ge,
         cu->flags |=3D CRAT_CU_FLAGS_GPU_PRESENT;
         cu->proximity_domain =3D proximity_domain;

-       get_cu_info(kdev->kgd, &cu_info);
+       amdgpu_amdkfd_get_cu_info(kdev->kgd, &cu_info);
         cu->num_simd_per_cu =3D cu_info.simd_per_cu;
         cu->num_simd_cores =3D cu_info.simd_per_cu * cu_info.cu_active_num=
ber;
         cu->max_waves_simd =3D cu_info.max_waves_per_simd;
@@ -1191,7 +1191,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_ima=
ge,
          * report the total FB size (public+private) as a single
          * private heap.
          */
-       get_local_mem_info(kdev->kgd, &local_mem_info);
+       amdgpu_amdkfd_get_local_mem_info(kdev->kgd, &local_mem_info);
         sub_type_hdr =3D (typeof(sub_type_hdr))((char *)sub_type_hdr +
                         sub_type_hdr->length);

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index eeb42af..d7e0f41 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -479,7 +479,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
         /* add another 512KB for all other allocations on gart (HPD, fence=
s) */
         size +=3D 512 * 1024;

-       if (alloc_gtt_mem(
+       if (amdgpu_amdkfd_alloc_gtt_mem(
                         kfd->kgd, size, &kfd->gtt_mem,
                         &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
                         false)) {
@@ -553,7 +553,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 kfd_doorbell_error:
         kfd_gtt_sa_fini(kfd);
 kfd_gtt_sa_init_error:
-       free_gtt_mem(kfd->kgd, kfd->gtt_mem);
+       amdgpu_amdkfd_free_gtt_mem(kfd->kgd, kfd->gtt_mem);
         dev_err(kfd_device,
                 "device %x:%x NOT added due to errors\n",
                 kfd->pdev->vendor, kfd->pdev->device);
@@ -570,7 +570,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
                 kfd_topology_remove_device(kfd);
                 kfd_doorbell_fini(kfd);
                 kfd_gtt_sa_fini(kfd);
-               free_gtt_mem(kfd->kgd, kfd->gtt_mem);
+               amdgpu_amdkfd_free_gtt_mem(kfd->kgd, kfd->gtt_mem);
         }

         kfree(kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_mqd_manager.c
index 2708070..6910028 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -59,7 +59,7 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm=
,
         uint32_t cu_per_sh[4] =3D {0};
         int i, se, cu =3D 0;

-       get_cu_info(mm->dev->kgd, &cu_info);
+       amdgpu_amdkfd_get_cu_info(mm->dev->kgd, &cu_info);

         if (cu_mask_count > cu_info.cu_active_number)
                 cu_mask_count =3D cu_info.cu_active_number;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v9.c
index db3b195..9dbba60 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -84,7 +84,7 @@ static int init_mqd(struct mqd_manager *mm, void **mqd,
                 *mqd_mem_obj =3D kzalloc(sizeof(struct kfd_mem_obj), GFP_K=
ERNEL);
                 if (!*mqd_mem_obj)
                         return -ENOMEM;
-               retval =3D alloc_gtt_mem(kfd->kgd,
+               retval =3D amdgpu_amdkfd_alloc_gtt_mem(kfd->kgd,
                         ALIGN(q->ctl_stack_size, PAGE_SIZE) +
                                 ALIGN(sizeof(struct v9_mqd), PAGE_SIZE),
                         &((*mqd_mem_obj)->gtt_mem),
@@ -251,7 +251,7 @@ static void uninit_mqd(struct mqd_manager *mm, void *mq=
d,
         struct kfd_dev *kfd =3D mm->dev;

         if (mqd_mem_obj->gtt_mem) {
-               free_gtt_mem(kfd->kgd, mqd_mem_obj->gtt_mem);
+               amdgpu_amdkfd_free_gtt_mem(kfd->kgd, mqd_mem_obj->gtt_mem);
                 kfree(mqd_mem_obj);
         } else {
                 kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 6f73101..c73b4ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1053,7 +1053,7 @@ static uint32_t kfd_generate_gpu_id(struct kfd_dev *g=
pu)
         if (!gpu)
                 return 0;

-       get_local_mem_info(gpu->kgd, &local_mem_info);
+       amdgpu_amdkfd_get_local_mem_info(gpu->kgd, &local_mem_info);

         local_mem_size =3D local_mem_info.local_mem_size_private +
                         local_mem_info.local_mem_size_public;
@@ -1119,7 +1119,7 @@ static void kfd_fill_mem_clk_max_info(struct kfd_topo=
logy_device *dev)
          * for APUs - If CRAT from ACPI reports more than one bank, then
          *       all the banks will report the same mem_clk_max informatio=
n
          */
-       get_local_mem_info(dev->gpu->kgd, &local_mem_info);
+       amdgpu_amdkfd_get_local_mem_info(dev->gpu->kgd, &local_mem_info);

         list_for_each_entry(mem, &dev->mem_props, list)
                 mem->mem_clk_max =3D local_mem_info.mem_clk_max;
@@ -1240,7 +1240,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
          * needed for the topology
          */

-       get_cu_info(dev->gpu->kgd, &cu_info);
+       amdgpu_amdkfd_get_cu_info(dev->gpu->kgd, &cu_info);
         dev->node_props.simd_arrays_per_engine =3D
                 cu_info.num_shader_arrays_per_engine;

@@ -1249,7 +1249,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
         dev->node_props.location_id =3D PCI_DEVID(gpu->pdev->bus->number,
                 gpu->pdev->devfn);
         dev->node_props.max_engine_clk_fcompute =3D
-               get_max_engine_clock_in_mhz(dev->gpu->kgd);
+               amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->kgd);
         dev->node_props.max_engine_clk_ccompute =3D
                 cpufreq_quick_get_max(0) / 1000;
         dev->node_props.drm_render_minor =3D
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB182014BE6C9AD85DD08289F0F7F80DM5PR12MB1820namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Lin, Amber &lt;Amber.Lin@amd.=
com&gt;<br>
<b>Sent:</b> Thursday, October 18, 2018 5:15:24 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Lin, Amber<br>
<b>Subject:</b> [PATCH 3/3] drm/amdkfd: Add proper prefix to functions</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add amdgpu_amdkfd_ prefix to amdgpu functions serv=
ed for amdkfd usage.<br>
<br>
Signed-off-by: Amber Lin &lt;Amber.Lin-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 12 &#43;&#43;&#43;&#43;&#43;&#43;------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 12 &#43;&#43;&#43;&#43;&#43;&#43;------<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_crat.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; |&nbsp; 6 &#43;&#43;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c&nbsp;&nbsp;&nbsp; |&nbsp=
; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c |&nbsp; 4 &#43;&#43;-=
-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_topology.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 8 &#43;&#43;&#43;&#43;----<br>
&nbsp;8 files changed, 26 insertions(&#43;), 26 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index c31a884..4e384ab 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -268,7 &#43;268,7 @@ void amdgpu_amdkfd_gpu_reset(struct kgd_dev *kgd)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_gpu_recover(adev, NULL);<br>
&nbsp;}<br>
&nbsp;<br>
-int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,<br>
&#43;int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void =
**mem_obj, uint64_t *gpu_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void =
**cpu_ptr, bool mqd_gfx9)<br>
&nbsp;{<br>
@@ -340,7 &#43;340,7 @@ int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
-void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj)<br>
&#43;void amdgpu_amdkfd_free_gtt_mem(struct kgd_dev *kgd, void *mem_obj)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo =3D (=
struct amdgpu_bo *) mem_obj;<br>
&nbsp;<br>
@@ -351,7 &#43;351,7 @@ void free_gtt_mem(struct kgd_dev *kgd, void *mem_ob=
j)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;(bo))=
;<br>
&nbsp;}<br>
&nbsp;<br>
-void get_local_mem_info(struct kgd_dev *kgd,<br>
&#43;void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t kfd_local_mem_info *mem_info)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)kgd;<br>
@@ -383,7 &#43;383,7 @@ void get_local_mem_info(struct kgd_dev *kgd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mem_info-&gt;mem_clk_max =3D 100;<br>
&nbsp;}<br>
&nbsp;<br>
-uint64_t get_gpu_clock_counter(struct kgd_dev *kgd)<br>
&#43;uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct kgd_dev *kgd)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)kgd;<br>
&nbsp;<br>
@@ -392,7 &#43;392,7 @@ uint64_t get_gpu_clock_counter(struct kgd_dev *kgd)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-uint32_t get_max_engine_clock_in_mhz(struct kgd_dev *kgd)<br>
&#43;uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd=
)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)kgd;<br>
&nbsp;<br>
@@ -405,7 &#43;405,7 @@ uint32_t get_max_engine_clock_in_mhz(struct kgd_dev=
 *kgd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 100;<br>
&nbsp;}<br>
&nbsp;<br>
-void get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu_info)<br>
&#43;void amdgpu_amdkfd_get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info=
 *cu_info)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)kgd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_cu_info acu_=
info =3D adev-&gt;gfx.cu_info;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h<br>
index 8e0d4f7..69cc9a9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
@@ -134,16 &#43;134,16 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device=
 *adev);<br>
&nbsp;void amdgpu_amdkfd_gpu_reset(struct kgd_dev *kgd);<br>
&nbsp;<br>
&nbsp;/* Shared API */<br>
-int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,<br>
&#43;int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void =
**mem_obj, uint64_t *gpu_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void =
**cpu_ptr, bool mqd_gfx9);<br>
-void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj);<br>
-void get_local_mem_info(struct kgd_dev *kgd,<br>
&#43;void amdgpu_amdkfd_free_gtt_mem(struct kgd_dev *kgd, void *mem_obj);<b=
r>
&#43;void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t kfd_local_mem_info *mem_info);<br>
-uint64_t get_gpu_clock_counter(struct kgd_dev *kgd);<br>
&#43;uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct kgd_dev *kgd);<br>
&nbsp;<br>
-uint32_t get_max_engine_clock_in_mhz(struct kgd_dev *kgd);<br>
-void get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu_info);<br>
&#43;uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd=
);<br>
&#43;void amdgpu_amdkfd_get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info=
 *cu_info);<br>
&nbsp;uint64_t amdgpu_amdkfd_get_vram_usage(struct kgd_dev *kgd);<br>
&nbsp;uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index 85e833d..5f4062b 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -835,7 &#43;835,7 @@ static int kfd_ioctl_get_clock_counters(struct file=
 *filep,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev =3D kfd_device_by_id(a=
rgs-&gt;gpu_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Reading GPU clock counter from KGD */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; args-&gt;gpu_clock_counter =3D get_gpu_clock_counter(dev-&gt;kgd=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; args-&gt;gpu_clock_counter =3D amdgpu_amdkfd_get_gpu_clock_c=
ounter(dev-&gt;kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Node without GPU resource */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; args-&gt;gpu_clock_counter =3D 0;<br>
@@ -1240,7 &#43;1240,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;device_info-&g=
t;needs_iommu_device)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_local_mem_info(dev-&gt;kgd, &amp;=
mem_info);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_local_mem_info(=
dev-&gt;kgd, &amp;mem_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mem_info.local_mem_siz=
e_private =3D=3D 0 &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_i=
nfo.local_mem_size_public &gt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c<br>
index a48be99..3783d12 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
@@ -1160,7 &#43;1160,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat=
_image,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu-&gt;flags |=3D CRAT_CU_=
FLAGS_GPU_PRESENT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu-&gt;proximity_domain =
=3D proximity_domain;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_cu_info(kdev-&gt;kgd, &amp;cu_inf=
o);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_cu_info(kdev-&g=
t;kgd, &amp;cu_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu-&gt;num_simd_per_cu =3D=
 cu_info.simd_per_cu;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu-&gt;num_simd_cores =3D =
cu_info.simd_per_cu * cu_info.cu_active_number;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu-&gt;max_waves_simd =3D =
cu_info.max_waves_per_simd;<br>
@@ -1191,7 &#43;1191,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat=
_image,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * report the total F=
B size (public&#43;private) as a single<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * private heap.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_local_mem_info(kdev-&gt;kgd, &amp=
;local_mem_info);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_local_mem_info(=
kdev-&gt;kgd, &amp;local_mem_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_type_hdr =3D (typeof(s=
ub_type_hdr))((char *)sub_type_hdr &#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_t=
ype_hdr-&gt;length);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index eeb42af..d7e0f41 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -479,7 &#43;479,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add another 512KB for a=
ll other allocations on gart (HPD, fences) */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D 512 * 1024;<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (alloc_gtt_mem(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_amdkfd_alloc_gtt_mem(<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;kgd, size, &amp;kfd-&gt;gtt_mem,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
kfd-&gt;gtt_start_gpu_addr, &amp;kfd-&gt;gtt_start_cpu_ptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false=
)) {<br>
@@ -553,7 &#43;553,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,<br>
&nbsp;kfd_doorbell_error:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_gtt_sa_fini(kfd);<br>
&nbsp;kfd_gtt_sa_init_error:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_gtt_mem(kfd-&gt;kgd, kfd-&gt;gtt=
_mem);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(kfd-&g=
t;kgd, kfd-&gt;gtt_mem);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(kfd_device,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;device %x:%x NOT added due to errors\n&quot;,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd-&gt;pdev-&gt;vendor, kfd-&gt;pdev-&gt;device);<br=
>
@@ -570,7 &#43;570,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd_topology_remove_device(kfd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd_doorbell_fini(kfd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd_gtt_sa_fini(kfd);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; free_gtt_mem(kfd-&gt;kgd, kfd-&gt;gtt_mem);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(kfd-&gt;kgd, kfd-&gt;gtt_mem);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(kfd);<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_mqd_manager.c<br>
index 2708070..6910028 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c<br>
@@ -59,7 &#43;59,7 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager=
 *mm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cu_per_sh[4] =3D =
{0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, se, cu =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_cu_info(mm-&gt;dev-&gt;kgd, &amp;=
cu_info);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_cu_info(mm-&gt;=
dev-&gt;kgd, &amp;cu_info);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cu_mask_count &gt; cu_=
info.cu_active_number)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cu_mask_count =3D cu_info.cu_active_number;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
index db3b195..9dbba60 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
@@ -84,7 &#43;84,7 @@ static int init_mqd(struct mqd_manager *mm, void **mq=
d,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *mqd_mem_obj =3D kzalloc(sizeof(struct kfd_mem_obj), =
GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!*mqd_mem_obj)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENOMEM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; retval =3D alloc_gtt_mem(kfd-&gt;kgd,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; retval =3D amdgpu_amdkfd_alloc_gtt_mem(kfd-&gt;kgd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN=
(q-&gt;ctl_stack_size, PAGE_SIZE) &#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(sizeof(struct v9_mqd), PAG=
E_SIZE),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
((*mqd_mem_obj)-&gt;gtt_mem),<br>
@@ -251,7 &#43;251,7 @@ static void uninit_mqd(struct mqd_manager *mm, void=
 *mqd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *kfd =3D mm=
-&gt;dev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_mem_obj-&gt;gtt_me=
m) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; free_gtt_mem(kfd-&gt;kgd, mqd_mem_obj-&gt;gtt_mem);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(kfd-&gt;kgd, mqd_mem_obj-&gt;gtt_=
mem);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(mqd_mem_obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd_gtt_sa_free(mm-&gt;dev, mqd_mem_obj);<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c<br>
index 6f73101..c73b4ff 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
@@ -1053,7 &#43;1053,7 @@ static uint32_t kfd_generate_gpu_id(struct kfd_de=
v *gpu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!gpu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_local_mem_info(gpu-&gt;kgd, &amp;=
local_mem_info);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_local_mem_info(=
gpu-&gt;kgd, &amp;local_mem_info);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local_mem_size =3D local_m=
em_info.local_mem_size_private &#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local=
_mem_info.local_mem_size_public;<br>
@@ -1119,7 &#43;1119,7 @@ static void kfd_fill_mem_clk_max_info(struct kfd_=
topology_device *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for APUs - If CRAT=
 from ACPI reports more than one bank, then<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; all the banks will report the same mem_clk_max informatio=
n<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_local_mem_info(dev-&gt;gpu-&gt;kg=
d, &amp;local_mem_info);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_local_mem_info(=
dev-&gt;gpu-&gt;kgd, &amp;local_mem_info);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(mem, &=
amp;dev-&gt;mem_props, list)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mem-&gt;mem_clk_max =3D local_mem_info.mem_clk_max;<b=
r>
@@ -1240,7 &#43;1240,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * needed for the top=
ology<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_cu_info(dev-&gt;gpu-&gt;kgd, &amp=
;cu_info);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_cu_info(dev-&gt=
;gpu-&gt;kgd, &amp;cu_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;node_props.simd_ar=
rays_per_engine =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cu_info.num_shader_arrays_per_engine;<br>
&nbsp;<br>
@@ -1249,7 &#43;1249,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;node_props.locatio=
n_id =3D PCI_DEVID(gpu-&gt;pdev-&gt;bus-&gt;number,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gpu-&gt;pdev-&gt;devfn);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;node_props.max_eng=
ine_clk_fcompute =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; get_max_engine_clock_in_mhz(dev-&gt;gpu-&gt;kgd);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev-&gt;gpu-&gt;kg=
d);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;node_props.max_eng=
ine_clk_ccompute =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cpufreq_quick_get_max(0) / 1000;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;node_props.drm_ren=
der_minor =3D<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB182014BE6C9AD85DD08289F0F7F80DM5PR12MB1820namp_--

--===============1363532391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1363532391==--
