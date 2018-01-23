From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: move static CSA address to top of address
 space v2
Date: Tue, 23 Jan 2018 14:50:53 +0000
Message-ID: <CY4PR12MB1653894D0D7ACBBC4100F55AF7E30@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <20180123101554.25390-1-christian.koenig@amd.com>,
 <20180123101554.25390-4-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0032965461=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180123101554.25390-4-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0032965461==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1653894D0D7ACBBC4100F55AF7E30CY4PR12MB1653namp_"

--_000_CY4PR12MB1653894D0D7ACBBC4100F55AF7E30CY4PR12MB1653namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Patches 1-3:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>


Patch 4:

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, January 23, 2018 5:15:54 AM
To: Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH 4/4] drm/amdgpu: move static CSA address to top of address =
space v2

Move the CSA area to the top of the VA space to avoid clashing with
HMM/ATC in the lower range on GFX9.

v2: wrong sign noticed by Roger, rebase on CSA_VADDR cleanup, handle VA
hole on GFX9 as well.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 24 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  4 ++--
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e7dfb7b44b4b..b832651d2137 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -24,6 +24,18 @@
 #include "amdgpu.h"
 #define MAX_KIQ_REG_WAIT        100000000 /* in usecs */

+uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
+{
+       uint64_t addr =3D adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT=
;
+
+       addr -=3D AMDGPU_VA_RESERVED_SIZE;
+
+       if (addr >=3D AMDGPU_VA_HOLE_START)
+               addr |=3D AMDGPU_VA_HOLE_END;
+
+       return addr;
+}
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 {
         /* By now all MMIO pages except mailbox are blocked */
@@ -55,14 +67,14 @@ void amdgpu_free_static_csa(struct amdgpu_device *adev)=
 {

 /*
  * amdgpu_map_static_csa should be called during amdgpu_vm_init
- * it maps virtual address "AMDGPU_VA_RESERVED_SIZE - AMDGPU_CSA_SIZE"
- * to this VM, and each command submission of GFX should use this virtual
- * address within META_DATA init package to support SRIOV gfx preemption.
+ * it maps virtual address amdgpu_csa_vaddr() to this VM, and each command
+ * submission of GFX should use this virtual address within META_DATA init
+ * package to support SRIOV gfx preemption.
  */
-
 int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm=
,
                           struct amdgpu_bo_va **bo_va)
 {
+       uint64_t csa_addr =3D amdgpu_csa_vaddr(adev) & AMDGPU_VA_HOLE_MASK;
         struct ww_acquire_ctx ticket;
         struct list_head list;
         struct amdgpu_bo_list_entry pd;
@@ -90,7 +102,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
                 return -ENOMEM;
         }

-       r =3D amdgpu_vm_alloc_pts(adev, (*bo_va)->base.vm, AMDGPU_CSA_VADDR=
,
+       r =3D amdgpu_vm_alloc_pts(adev, (*bo_va)->base.vm, csa_addr,
                                 AMDGPU_CSA_SIZE);
         if (r) {
                 DRM_ERROR("failed to allocate pts for static CSA, err=3D%d=
\n", r);
@@ -99,7 +111,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
                 return r;
         }

-       r =3D amdgpu_vm_bo_map(adev, *bo_va, AMDGPU_CSA_VADDR, 0, AMDGPU_CS=
A_SIZE,
+       r =3D amdgpu_vm_bo_map(adev, *bo_va, csa_addr, 0, AMDGPU_CSA_SIZE,
                              AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
                              AMDGPU_PTE_EXECUTABLE);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 6a83425aa9ed..880ac113a3a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -251,8 +251,7 @@ struct amdgpu_virt {
         uint32_t gim_feature;
 };

-#define AMDGPU_CSA_SIZE    (8 * 1024)
-#define AMDGPU_CSA_VADDR   (AMDGPU_VA_RESERVED_SIZE - AMDGPU_CSA_SIZE)
+#define AMDGPU_CSA_SIZE                (8 * 1024)

 #define amdgpu_sriov_enabled(adev) \
 ((adev)->virt.caps & AMDGPU_SRIOV_CAPS_ENABLE_IOV)
@@ -279,6 +278,8 @@ static inline bool is_virtual_machine(void)
 }

 struct amdgpu_vm;
+
+uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev);
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 int amdgpu_allocate_static_csa(struct amdgpu_device *adev);
 int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm=
,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 530d2ea1b73c..6482efec47a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -7147,11 +7147,11 @@ static void gfx_v8_0_ring_emit_ce_meta(struct amdgp=
u_ring *ring)
         } ce_payload =3D {};

         if (ring->adev->virt.chained_ib_support) {
-               ce_payload_addr =3D AMDGPU_CSA_VADDR +
+               ce_payload_addr =3D amdgpu_csa_vaddr(ring->adev) +
                         offsetof(struct vi_gfx_meta_data_chained_ib, ce_pa=
yload);
                 cnt_ce =3D (sizeof(ce_payload.chained) >> 2) + 4 - 2;
         } else {
-               ce_payload_addr =3D AMDGPU_CSA_VADDR +
+               ce_payload_addr =3D amdgpu_csa_vaddr(ring->adev) +
                         offsetof(struct vi_gfx_meta_data, ce_payload);
                 cnt_ce =3D (sizeof(ce_payload.regular) >> 2) + 4 - 2;
         }
@@ -7175,7 +7175,7 @@ static void gfx_v8_0_ring_emit_de_meta(struct amdgpu_=
ring *ring)
                 struct vi_de_ib_state_chained_ib chained;
         } de_payload =3D {};

-       csa_addr =3D AMDGPU_CSA_VADDR;
+       csa_addr =3D amdgpu_csa_vaddr(ring->adev);
         gds_addr =3D csa_addr + 4096;
         if (ring->adev->virt.chained_ib_support) {
                 de_payload.chained.gds_backup_addrlo =3D lower_32_bits(gds=
_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 720d15f1324e..1363e7ddd04a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3873,7 +3873,7 @@ static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_=
ring *ring)
         int cnt;

         cnt =3D (sizeof(ce_payload) >> 2) + 4 - 2;
-       csa_addr =3D AMDGPU_CSA_VADDR;
+       csa_addr =3D amdgpu_csa_vaddr(ring->adev);

         amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
         amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
@@ -3891,7 +3891,7 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_=
ring *ring)
         uint64_t csa_addr, gds_addr;
         int cnt;

-       csa_addr =3D AMDGPU_CSA_VADDR;
+       csa_addr =3D amdgpu_csa_vaddr(ring->adev);
         gds_addr =3D csa_addr + 4096;
         de_payload.gds_backup_addrlo =3D lower_32_bits(gds_addr);
         de_payload.gds_backup_addrhi =3D upper_32_bits(gds_addr);
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1653894D0D7ACBBC4100F55AF7E30CY4PR12MB1653namp_
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
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Patches 1-3:</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Patch 4:</p>
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, January 23, 2018 5:15:54 AM<br>
<b>To:</b> Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH 4/4] drm/amdgpu: move static CSA address to top of a=
ddress space v2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Move the CSA area to the top of the VA space to av=
oid clashing with<br>
HMM/ATC in the lower range on GFX9.<br>
<br>
v2: wrong sign noticed by Roger, rebase on CSA_VADDR cleanup, handle VA<br>
hole on GFX9 as well.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 24 &#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |&nbsp; 5 &#43;&#43;&#43;--<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 6 &#4=
3;&#43;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#4=
3;&#43;--<br>
&nbsp;4 files changed, 26 insertions(&#43;), 13 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index e7dfb7b44b4b..b832651d2137 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -24,6 &#43;24,18 @@<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#define MAX_KIQ_REG_WAIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10=
0000000 /* in usecs */<br>
&nbsp;<br>
&#43;uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr =3D adev-&gt;vm_man=
ager.max_pfn &lt;&lt; AMDGPU_GPU_PAGE_SHIFT;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr -=3D AMDGPU_VA_RESERVED_SIZE=
;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (addr &gt;=3D AMDGPU_VA_HOLE_S=
TART)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; addr |=3D AMDGPU_VA_HOLE_END;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return addr;<br>
&#43;}<br>
&#43;<br>
&nbsp;bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* By now all MMIO pages e=
xcept mailbox are blocked */<br>
@@ -55,14 &#43;67,14 @@ void amdgpu_free_static_csa(struct amdgpu_device *a=
dev) {<br>
&nbsp;<br>
&nbsp;/*<br>
&nbsp; * amdgpu_map_static_csa should be called during amdgpu_vm_init<br>
- * it maps virtual address &quot;AMDGPU_VA_RESERVED_SIZE - AMDGPU_CSA_SIZE=
&quot;<br>
- * to this VM, and each command submission of GFX should use this virtual<=
br>
- * address within META_DATA init package to support SRIOV gfx preemption.<=
br>
&#43; * it maps virtual address amdgpu_csa_vaddr() to this VM, and each com=
mand<br>
&#43; * submission of GFX should use this virtual address within META_DATA =
init<br>
&#43; * package to support SRIOV gfx preemption.<br>
&nbsp; */<br>
-<br>
&nbsp;int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_v=
m *vm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct amdgpu_bo_va **bo_va)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t csa_addr =3D amdgpu_csa_=
vaddr(adev) &amp; AMDGPU_VA_HOLE_MASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ww_acquire_ctx tick=
et;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_list_entr=
y pd;<br>
@@ -90,7 &#43;102,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_alloc_pts(adev, (*bo_=
va)-&gt;base.vm, AMDGPU_CSA_VADDR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_alloc_pts(adev, (=
*bo_va)-&gt;base.vm, csa_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_CSA_SIZE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to allocate pts for static CSA=
, err=3D%d\n&quot;, r);<br>
@@ -99,7 &#43;111,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_bo_map(adev, *bo_va, =
AMDGPU_CSA_VADDR, 0, AMDGPU_CSA_SIZE,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_bo_map(adev, *bo_=
va, csa_addr, 0, AMDGPU_CSA_SIZE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PTE_EXECUTABLE);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h<br>
index 6a83425aa9ed..880ac113a3a9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
@@ -251,8 &#43;251,7 @@ struct amdgpu_virt {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gim_feature;<br>
&nbsp;};<br>
&nbsp;<br>
-#define AMDGPU_CSA_SIZE&nbsp;&nbsp;&nbsp; (8 * 1024)<br>
-#define AMDGPU_CSA_VADDR&nbsp;&nbsp; (AMDGPU_VA_RESERVED_SIZE - AMDGPU_CSA=
_SIZE)<br>
&#43;#define AMDGPU_CSA_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (8 * 1024)<br>
&nbsp;<br>
&nbsp;#define amdgpu_sriov_enabled(adev) \<br>
&nbsp;((adev)-&gt;virt.caps &amp; AMDGPU_SRIOV_CAPS_ENABLE_IOV)<br>
@@ -279,6 &#43;278,8 @@ static inline bool is_virtual_machine(void)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;struct amdgpu_vm;<br>
&#43;<br>
&#43;uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev);<br>
&nbsp;bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_allocate_static_csa(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_v=
m *vm,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 530d2ea1b73c..6482efec47a1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -7147,11 &#43;7147,11 @@ static void gfx_v8_0_ring_emit_ce_meta(struct a=
mdgpu_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } ce_payload =3D {};<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;adev-&gt;virt=
.chained_ib_support) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ce_payload_addr =3D AMDGPU_CSA_VADDR &#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ce_payload_addr =3D amdgpu_csa_vaddr(ring-&gt;adev) &#43;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offse=
tof(struct vi_gfx_meta_data_chained_ib, ce_payload);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cnt_ce =3D (sizeof(ce_payload.chained) &gt;&gt; 2) &#=
43; 4 - 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ce_payload_addr =3D AMDGPU_CSA_VADDR &#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ce_payload_addr =3D amdgpu_csa_vaddr(ring-&gt;adev) &#43;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offse=
tof(struct vi_gfx_meta_data, ce_payload);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cnt_ce =3D (sizeof(ce_payload.regular) &gt;&gt; 2) &#=
43; 4 - 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -7175,7 &#43;7175,7 @@ static void gfx_v8_0_ring_emit_de_meta(struct amd=
gpu_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct vi_de_ib_state_chained_ib chained;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } de_payload =3D {};<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; csa_addr =3D AMDGPU_CSA_VADDR;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; csa_addr =3D amdgpu_csa_vaddr(rin=
g-&gt;adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_addr =3D csa_addr &#43=
; 4096;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;adev-&gt;virt=
.chained_ib_support) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; de_payload.chained.gds_backup_addrlo =3D lower_32_bit=
s(gds_addr);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 720d15f1324e..1363e7ddd04a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -3873,7 &#43;3873,7 @@ static void gfx_v9_0_ring_emit_ce_meta(struct amd=
gpu_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cnt;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt =3D (sizeof(ce_payload=
) &gt;&gt; 2) &#43; 4 - 2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; csa_addr =3D AMDGPU_CSA_VADDR;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; csa_addr =3D amdgpu_csa_vaddr(rin=
g-&gt;adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET3(PACKET3_WRITE_DATA, cnt));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, (W=
RITE_DATA_ENGINE_SEL(2) |<br>
@@ -3891,7 &#43;3891,7 @@ static void gfx_v9_0_ring_emit_de_meta(struct amd=
gpu_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t csa_addr, gds_add=
r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cnt;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; csa_addr =3D AMDGPU_CSA_VADDR;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; csa_addr =3D amdgpu_csa_vaddr(rin=
g-&gt;adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_addr =3D csa_addr &#43=
; 4096;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de_payload.gds_backup_addr=
lo =3D lower_32_bits(gds_addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de_payload.gds_backup_addr=
hi =3D upper_32_bits(gds_addr);<br>
-- <br>
2.14.1<br>
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

--_000_CY4PR12MB1653894D0D7ACBBC4100F55AF7E30CY4PR12MB1653namp_--

--===============0032965461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0032965461==--
