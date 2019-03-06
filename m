From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: XGMI pstate switch initial support
Date: Wed, 6 Mar 2019 16:14:48 +0000
Message-ID: <BN6PR12MB180955EFEDB25AB9643DAD54F7730@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1551803104-18651-1-git-send-email-shaoyun.liu@amd.com>,
 <DM6PR12MB324116586D9AE56B393FBEECF4730@DM6PR12MB3241.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1939312222=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM6PR12MB324116586D9AE56B393FBEECF4730-lmeGfMZKVrEShx2hYn8pVQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1939312222==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180955EFEDB25AB9643DAD54F7730BN6PR12MB1809namp_"

--_000_BN6PR12MB180955EFEDB25AB9643DAD54F7730BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Liu, Sha=
oyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, March 6, 2019 11:03 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH] drm/amdgpu: XGMI pstate switch initial support

Ping

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, March 5, 2019 11:25 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Liu, Shaoyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: XGMI pstate switch initial support

Driver vote low to high pstate switch whenever there is an outstanding XGMI=
 mapping request. Driver vote high to low pstate when all the outstanding X=
GMI mapping is terminated.

Change-Id: I499fb1c389077632fe9cfce4b6dc9a33deff6875
Signed-off-by: shaoyunl <shaoyun.liu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++  drivers/gpu/drm/amd/a=
mdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 29 ++++++++++++++++++++++++++=
++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 ++
 6 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index f0dada9..c3c8392 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -930,6 +930,10 @@ struct amdgpu_device {

         int asic_reset_res;
         struct work_struct              xgmi_reset_work;
+
+       /* counter of mapped memory through xgmi */
+       atomic_t                        xgmi_map_counter;
+
 };

 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *=
bdev) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
index 00def57..f28abb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2008,6 +2008,9 @@ static void amdgpu_device_ip_late_init_func_handler(s=
truct work_struct *work)
         r =3D amdgpu_device_enable_mgpu_fan_boost();
         if (r)
                 DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
+
+       /*set to low pstate by default */
+       amdgpu_xgmi_set_pstate(adev, 0);
 }

 static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work) d=
iff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_object.h
index 220a6a7..6f176bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -54,6 +54,7 @@ struct amdgpu_bo_va_mapping {
         uint64_t                        __subtree_last;
         uint64_t                        offset;
         uint64_t                        flags;
+       bool                            is_xgmi;
 };

 /* User space allocated BO in a VM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index c0f315b..5765761 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -34,6 +34,7 @@
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gmc.h"
+#include "amdgpu_xgmi.h"

 /**
  * DOC: GPUVM
@@ -2013,8 +2014,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
         struct ttm_mem_reg *mem;
         struct drm_mm_node *nodes;
         struct dma_fence *exclusive, **last_update;
-       uint64_t flags;
         struct amdgpu_device *bo_adev =3D adev;
+       bool is_xgmi =3D false;
+       uint64_t flags;
         int r;

         if (clear || !bo) {
@@ -2036,6 +2038,10 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
         if (bo) {
                 flags =3D amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, mem);
                 bo_adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
+               if (adev !=3D bo_adev &&
+                   adev->gmc.xgmi.hive_id &&
+                   adev->gmc.xgmi.hive_id =3D=3D bo_adev->gmc.xgmi.hive_id=
)
+                       is_xgmi =3D true;
         } else {
                 flags =3D 0x0;
         }
@@ -2054,6 +2060,19 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
         }

         list_for_each_entry(mapping, &bo_va->invalids, list) {
+               if (mapping->is_xgmi !=3D is_xgmi) {
+                       if (is_xgmi) {
+                               /* Adding an XGMI mapping to the PT */
+                               if (atomic_inc_return(&adev->xgmi_map_count=
er) =3D=3D 1)
+                                       amdgpu_xgmi_set_pstate(adev, 1);
+                       } else {
+                               /* Removing an XGMI mapping from the PT */
+                               if (atomic_dec_return(&adev->xgmi_map_count=
er) =3D=3D 0)
+                                       amdgpu_xgmi_set_pstate(adev, 0);
+                       }
+                       mapping->is_xgmi =3D is_xgmi;
+               }
+
                 r =3D amdgpu_vm_bo_split_mapping(adev, exclusive, pages_ad=
dr, vm,
                                                mapping, flags, bo_adev, no=
des,
                                                last_update);
@@ -2271,6 +2290,13 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev=
,
                 r =3D amdgpu_vm_bo_update_mapping(adev, NULL, NULL, vm,
                                                 mapping->start, mapping->l=
ast,
                                                 init_pte_value, 0, &f);
+
+               if (mapping->is_xgmi) {
+                       /* Removing an XGMI mapping from the PT */
+                       if (atomic_dec_return(&adev->xgmi_map_counter) =3D=
=3D 0)
+                               amdgpu_xgmi_set_pstate(adev, 0);
+               }
+
                 amdgpu_vm_free_mapping(adev, vm, mapping, f);
                 if (r) {
                         dma_fence_put(f);
@@ -2467,6 +2493,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
         mapping->last =3D eaddr;
         mapping->offset =3D offset;
         mapping->flags =3D flags;
+       mapping->is_xgmi =3D false;

         amdgpu_vm_bo_insert_map(adev, bo_va, mapping);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 407dd16c..cb403cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -72,6 +72,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdg=
pu_device *adev, int lo
         mutex_init(&tmp->reset_lock);
         if (lock)
                 mutex_lock(&tmp->hive_lock);
+       tmp->pstate =3D -1;

         mutex_unlock(&xgmi_mutex);

@@ -182,3 +183,17 @@ void amdgpu_xgmi_remove_device(struct amdgpu_device *a=
dev)
                 mutex_unlock(&hive->hive_lock);
         }
 }
+
+int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate) {
+       int ret =3D 0;
+       struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev, 0);
+
+       if (!hive)
+               return 0;
+
+       if (hive->pstate =3D=3D pstate)
+               return 0;
+       /* Todo : sent the message to SMU for pstate change */
+       return ret;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h
index 14bc606..6859702 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -31,11 +31,13 @@ struct amdgpu_hive_info {
         int number_devices;
         struct mutex hive_lock,
                      reset_lock;
+       int pstate; /*0 -- low , 1 -- high , -1 unknown*/
 };

 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, =
int lock);  int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, =
struct amdgpu_device *adev);  int amdgpu_xgmi_add_device(struct amdgpu_devi=
ce *adev);  void amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
+int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);

 #endif
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180955EFEDB25AB9643DAD54F7730BN6PR12MB1809namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 6, 2019 11:03 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: XGMI pstate switch initial support<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping<br>
<br>
-----Original Message-----<br>
From: Liu, Shaoyun &lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt; <br>
Sent: Tuesday, March 5, 2019 11:25 AM<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Liu, Shaoyun &lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: [PATCH] drm/amdgpu: XGMI pstate switch initial support<br>
<br>
Driver vote low to high pstate switch whenever there is an outstanding XGMI=
 mapping request. Driver vote high to low pstate when all the outstanding X=
GMI mapping is terminated.<br>
<br>
Change-Id: I499fb1c389077632fe9cfce4b6dc9a33deff6875<br>
Signed-off-by: shaoyunl &lt;shaoyun.liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 4 &#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 3 &#43;&#43;&#43;&=
nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |&nbsp; 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp;&nbsp; | 29 &=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp;&nbsp; | 15 &#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h&nbsp;&nbsp; |&nbsp; 2 &#43;&=
#43;<br>
&nbsp;6 files changed, 53 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index f0dada9..c3c8392 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -930,6 &#43;930,10 @@ struct amdgpu_device {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int asic_reset_res;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct work_struct&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgmi=
_reset_work;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* counter of mapped memory throu=
gh xgmi */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgmi_map_counter;<br>
&#43;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_dev=
ice *bdev) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
index 00def57..f28abb3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2008,6 &#43;2008,9 @@ static void amdgpu_device_ip_late_init_func_handl=
er(struct work_struct *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_enable=
_mgpu_fan_boost();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;enable mgpu fan boost failed (%d).\n&=
quot;, r);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*set to low pstate by default */=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_set_pstate(adev, 0);<=
br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void amdgpu_device_delay_enable_gfx_off(struct work_struct *wo=
rk) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.h<br>
index 220a6a7..6f176bb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
@@ -54,6 &#43;54,7 @@ struct amdgpu_bo_va_mapping {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __subtree_last;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_xgmi;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/* User space allocated BO in a VM */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index c0f315b..5765761 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -34,6 &#43;34,7 @@<br>
&nbsp;#include &quot;amdgpu_trace.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
&nbsp;#include &quot;amdgpu_gmc.h&quot;<br>
&#43;#include &quot;amdgpu_xgmi.h&quot;<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * DOC: GPUVM<br>
@@ -2013,8 &#43;2014,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_mem_reg *mem;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_mm_node *nodes;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *exclusiv=
e, **last_update;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_a=
dev =3D adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_xgmi =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clear || !bo) {<br>
@@ -2036,6 &#43;2038,10 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ad=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; flags =3D amdgpu_ttm_tt_pte_flags(adev, bo-&gt;tbo.tt=
m, mem);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bo_adev =3D amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev !=3D bo_adev &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.hive_id &amp;&amp;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.hive_id =3D=3D bo_=
adev-&gt;gmc.xgmi.hive_id)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_xgmi =3D =
true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; flags =3D 0x0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2054,6 &#43;2060,19 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ad=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(mappin=
g, &amp;bo_va-&gt;invalids, list) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (mapping-&gt;is_xgmi !=3D is_xgmi) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_xgmi)=
 {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Adding an XGMI mapping to the PT */<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_inc_return(&amp;adev-&gt;xgm=
i_map_counter) =3D=3D 1)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; amdgpu_xgmi_set_pstate(adev, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Removing an XGMI mapping from the PT=
 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_dec_return(&amp;adev-&gt;xgm=
i_map_counter) =3D=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; amdgpu_xgmi_set_pstate(adev, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;=
is_xgmi =3D is_xgmi;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_bo_split_mapping(adev, exclusive, pag=
es_addr, vm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping, flags, b=
o_adev, nodes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_update);<br>
@@ -2271,6 &#43;2290,13 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_bo_update_mapping(adev, NULL, NULL, v=
m,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt=
;start, mapping-&gt;last,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pte_va=
lue, 0, &amp;f);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (mapping-&gt;is_xgmi) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Removing =
an XGMI mapping from the PT */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_d=
ec_return(&amp;adev-&gt;xgmi_map_counter) =3D=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_set_pstate(adev, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_vm_free_mapping(adev, vm, mapping, f);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_f=
ence_put(f);<br>
@@ -2467,6 &#43;2493,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;last =3D eaddr=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;offset =3D off=
set;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;flags =3D flag=
s;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;is_xgmi =3D false;<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_insert_map(ad=
ev, bo_va, mapping);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index 407dd16c..cb403cf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -72,6 &#43;72,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct =
amdgpu_device *adev, int lo<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;tmp-&gt;re=
set_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (lock)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;tmp-&gt;hive_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp-&gt;pstate =3D -1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;xgmi_mut=
ex);<br>
&nbsp;<br>
@@ -182,3 &#43;183,17 @@ void amdgpu_xgmi_remove_device(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hive-&gt;hive_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&#43;<br>
&#43;int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate) {<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive =3D=
 amdgpu_get_xgmi_hive(adev, 0);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hive)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive-&gt;pstate =3D=3D pstate=
)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Todo : sent the message to SMU=
 for pstate change */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
\ No newline at end of file<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h<br>
index 14bc606..6859702 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
@@ -31,11 &#43;31,13 @@ struct amdgpu_hive_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int number_devices;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex hive_lock,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_lock;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pstate; /*0 -- low , 1 -- hig=
h , -1 unknown*/<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *a=
dev, int lock);&nbsp; int amdgpu_xgmi_update_topology(struct amdgpu_hive_in=
fo *hive, struct amdgpu_device *adev);&nbsp; int amdgpu_xgmi_add_device(str=
uct amdgpu_device *adev);&nbsp; void amdgpu_xgmi_remove_device(struct
 amdgpu_device *adev);<br>
&#43;int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);<br=
>
&nbsp;<br>
&nbsp;#endif<br>
--<br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180955EFEDB25AB9643DAD54F7730BN6PR12MB1809namp_--

--===============1939312222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1939312222==--
