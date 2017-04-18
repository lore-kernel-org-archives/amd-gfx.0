From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 12/12] drm/amdgpu/gfx9: Switch baremetal to use KIQ for
 compute ring management. (v3)
Date: Tue, 18 Apr 2017 06:11:07 +0000
Message-ID: <CY4PR12MB16871760AD05B696AD9F3E0CFB190@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1492466447-27614-1-git-send-email-alexander.deucher@amd.com>,
 <1492466447-27614-13-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1269136397=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1492466447-27614-13-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============1269136397==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16871760AD05B696AD9F3E0CFB190CY4PR12MB1687namp_"

--_000_CY4PR12MB16871760AD05B696AD9F3E0CFB190CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

+static int gfx_v9_0_kiq_kcq_disable(struct amdgpu_device *adev)

...............

+               DRM_ERROR("KCQ enable failed (scratch(0x%04X)=3D0x%08X)\n",


should be disable here.


Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, April 18, 2017 6:00:47 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH 12/12] drm/amdgpu/gfx9: Switch baremetal to use KIQ for com=
pute ring management. (v3)

KIQ is the Kernel Interface Queue for managing the MEC.  Rather than settin=
g
up rings via direct MMIO of ring registers, the rings are configured via
special packets sent to the KIQ.  The allows the MEC to better manage share=
d
resources and certain power events. It also reduces the code paths in the
driver to support and is required for MEC powergating.

v2: drop gfx_v9_0_cp_compute_fini() as well
v3: rebase on latest changes derived from gfx8, add unmap queues on
hw_fini

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 374 ++++++++----------------------=
----
 1 file changed, 81 insertions(+), 293 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index f86a7f6..ef7a3ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1113,23 +1113,21 @@ static int gfx_v9_0_sw_init(void *handle)
                         return r;
         }

-       if (amdgpu_sriov_vf(adev)) {
-               r =3D gfx_v9_0_kiq_init(adev);
-               if (r) {
-                       DRM_ERROR("Failed to init KIQ BOs!\n");
-                       return r;
-               }
+       r =3D gfx_v9_0_kiq_init(adev);
+       if (r) {
+               DRM_ERROR("Failed to init KIQ BOs!\n");
+               return r;
+       }

-               kiq =3D &adev->gfx.kiq;
-               r =3D gfx_v9_0_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
-               if (r)
-                       return r;
+       kiq =3D &adev->gfx.kiq;
+       r =3D gfx_v9_0_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
+       if (r)
+               return r;

-               /* create MQD for all compute queues as wel as KIQ for SRIO=
V case */
-               r =3D gfx_v9_0_compute_mqd_sw_init(adev);
-               if (r)
-                       return r;
-       }
+       /* create MQD for all compute queues as wel as KIQ for SRIOV case *=
/
+       r =3D gfx_v9_0_compute_mqd_sw_init(adev);
+       if (r)
+               return r;

         /* reserve GDS, GWS and OA resource for gfx */
         r =3D amdgpu_bo_create_kernel(adev, adev->gds.mem.gfx_partition_si=
ze,
@@ -1176,11 +1174,9 @@ static int gfx_v9_0_sw_fini(void *handle)
         for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
                 amdgpu_ring_fini(&adev->gfx.compute_ring[i]);

-       if (amdgpu_sriov_vf(adev)) {
-               gfx_v9_0_compute_mqd_sw_fini(adev);
-               gfx_v9_0_kiq_free_ring(&adev->gfx.kiq.ring, &adev->gfx.kiq.=
irq);
-               gfx_v9_0_kiq_fini(adev);
-       }
+       gfx_v9_0_compute_mqd_sw_fini(adev);
+       gfx_v9_0_kiq_free_ring(&adev->gfx.kiq.ring, &adev->gfx.kiq.irq);
+       gfx_v9_0_kiq_fini(adev);

         gfx_v9_0_mec_fini(adev);
         gfx_v9_0_ngg_fini(adev);
@@ -1736,13 +1732,6 @@ static void gfx_v9_0_cp_compute_enable(struct amdgpu=
_device *adev, bool enable)
         udelay(50);
 }

-static int gfx_v9_0_cp_compute_start(struct amdgpu_device *adev)
-{
-       gfx_v9_0_cp_compute_enable(adev, true);
-
-       return 0;
-}
-
 static int gfx_v9_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 {
         const struct gfx_firmware_header_v1_0 *mec_hdr;
@@ -1785,45 +1774,6 @@ static int gfx_v9_0_cp_compute_load_microcode(struct=
 amdgpu_device *adev)
         return 0;
 }

-static void gfx_v9_0_cp_compute_fini(struct amdgpu_device *adev)
-{
-       int i, r;
-
-       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
-               struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[i];
-
-               if (ring->mqd_obj) {
-                       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
-                       if (unlikely(r !=3D 0))
-                               dev_warn(adev->dev, "(%d) reserve MQD bo fa=
iled\n", r);
-
-                       amdgpu_bo_unpin(ring->mqd_obj);
-                       amdgpu_bo_unreserve(ring->mqd_obj);
-
-                       amdgpu_bo_unref(&ring->mqd_obj);
-                       ring->mqd_obj =3D NULL;
-               }
-       }
-}
-
-static int gfx_v9_0_init_queue(struct amdgpu_ring *ring);
-
-static int gfx_v9_0_cp_compute_resume(struct amdgpu_device *adev)
-{
-       int i, r;
-       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
-               struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[i];
-               if (gfx_v9_0_init_queue(ring))
-                       dev_warn(adev->dev, "compute queue %d init failed!\=
n", i);
-       }
-
-       r =3D gfx_v9_0_cp_compute_start(adev);
-       if (r)
-               return r;
-
-       return 0;
-}
-
 /* KIQ functions */
 static void gfx_v9_0_kiq_setting(struct amdgpu_ring *ring)
 {
@@ -1914,6 +1864,56 @@ static int gfx_v9_0_kiq_kcq_enable(struct amdgpu_dev=
ice *adev)
         return r;
 }

+static int gfx_v9_0_kiq_kcq_disable(struct amdgpu_device *adev)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+       uint32_t scratch, tmp =3D 0;
+       int r, i;
+
+       r =3D amdgpu_gfx_scratch_get(adev, &scratch);
+       if (r) {
+               DRM_ERROR("Failed to get scratch reg (%d).\n", r);
+               return r;
+       }
+       WREG32(scratch, 0xCAFEDEAD);
+
+       r =3D amdgpu_ring_alloc(kiq_ring, 6 + 3);
+       if (r) {
+               DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+               amdgpu_gfx_scratch_free(adev, scratch);
+               return r;
+       }
+       /* unmap queues */
+       amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
+       amdgpu_ring_write(kiq_ring,
+                         PACKET3_UNMAP_QUEUES_ACTION(1)| /* RESET_QUEUES *=
/
+                         PACKET3_UNMAP_QUEUES_QUEUE_SEL(2)); /* select all=
 queues */
+       amdgpu_ring_write(kiq_ring, 0);
+       amdgpu_ring_write(kiq_ring, 0);
+       amdgpu_ring_write(kiq_ring, 0);
+       amdgpu_ring_write(kiq_ring, 0);
+       /* write to scratch for completion */
+       amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
+       amdgpu_ring_write(kiq_ring, (scratch - PACKET3_SET_UCONFIG_REG_STAR=
T));
+       amdgpu_ring_write(kiq_ring, 0xDEADBEEF);
+       amdgpu_ring_commit(kiq_ring);
+
+       for (i =3D 0; i < adev->usec_timeout; i++) {
+               tmp =3D RREG32(scratch);
+               if (tmp =3D=3D 0xDEADBEEF)
+                       break;
+               DRM_UDELAY(1);
+       }
+       if (i >=3D adev->usec_timeout) {
+               DRM_ERROR("KCQ enable failed (scratch(0x%04X)=3D0x%08X)\n",
+                         scratch, tmp);
+               r =3D -EINVAL;
+       }
+       amdgpu_gfx_scratch_free(adev, scratch);
+
+       return r;
+}
+
 static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 {
         struct amdgpu_device *adev =3D ring->adev;
@@ -2194,7 +2194,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring=
 *ring)
         struct v9_mqd *mqd =3D ring->mqd_ptr;
         int mqd_idx =3D ring - &adev->gfx.compute_ring[0];

-       if (!adev->gfx.in_reset) {
+       if (!adev->gfx.in_reset && !adev->gfx.in_suspend) {
                 memset((void *)mqd, 0, sizeof(*mqd));
                 mutex_lock(&adev->srbm_mutex);
                 soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue,=
 0);
@@ -2285,10 +2285,7 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *=
adev)
         if (r)
                 return r;

-       if (amdgpu_sriov_vf(adev))
-               r =3D gfx_v9_0_kiq_resume(adev);
-       else
-               r =3D gfx_v9_0_cp_compute_resume(adev);
+       r =3D gfx_v9_0_kiq_resume(adev);
         if (r)
                 return r;

@@ -2298,6 +2295,13 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *=
adev)
                 ring->ready =3D false;
                 return r;
         }
+
+       ring =3D &adev->gfx.kiq.ring;
+       ring->ready =3D true;
+       r =3D amdgpu_ring_test_ring(ring);
+       if (r)
+               ring->ready =3D false;
+
         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
                 ring =3D &adev->gfx.compute_ring[i];

@@ -2307,14 +2311,6 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *=
adev)
                         ring->ready =3D false;
         }

-       if (amdgpu_sriov_vf(adev)) {
-               ring =3D &adev->gfx.kiq.ring;
-               ring->ready =3D true;
-               r =3D amdgpu_ring_test_ring(ring);
-               if (r)
-                       ring->ready =3D false;
-       }
-
         gfx_v9_0_enable_gui_idle_interrupt(adev, true);

         return 0;
@@ -2360,9 +2356,9 @@ static int gfx_v9_0_hw_fini(void *handle)
                 pr_debug("For SRIOV client, shouldn't do anything.\n");
                 return 0;
         }
+       gfx_v9_0_kiq_kcq_disable(adev);
         gfx_v9_0_cp_enable(adev, false);
         gfx_v9_0_rlc_stop(adev);
-       gfx_v9_0_cp_compute_fini(adev);

         return 0;
 }
@@ -2371,14 +2367,18 @@ static int gfx_v9_0_suspend(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       adev->gfx.in_suspend =3D true;
         return gfx_v9_0_hw_fini(adev);
 }

 static int gfx_v9_0_resume(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+       int r;

-       return gfx_v9_0_hw_init(adev);
+       r =3D gfx_v9_0_hw_init(adev);
+       adev->gfx.in_suspend =3D false;
+       return r;
 }

 static bool gfx_v9_0_is_idle(void *handle)
@@ -3753,218 +3753,6 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_devic=
e *adev,
         return 0;
 }

-static int gfx_v9_0_init_queue(struct amdgpu_ring *ring)
-{
-       int r, j;
-       u32 tmp;
-       bool use_doorbell =3D true;
-       u64 hqd_gpu_addr;
-       u64 mqd_gpu_addr;
-       u64 eop_gpu_addr;
-       u64 wb_gpu_addr;
-       u32 *buf;
-       struct v9_mqd *mqd;
-       struct amdgpu_device *adev;
-
-       adev =3D ring->adev;
-       if (ring->mqd_obj =3D=3D NULL) {
-               r =3D amdgpu_bo_create(adev,
-                               sizeof(struct v9_mqd),
-                               PAGE_SIZE,true,
-                               AMDGPU_GEM_DOMAIN_GTT, 0, NULL,
-                               NULL, &ring->mqd_obj);
-               if (r) {
-                       dev_warn(adev->dev, "(%d) create MQD bo failed\n", =
r);
-                       return r;
-               }
-       }
-
-       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
-       if (unlikely(r !=3D 0)) {
-               gfx_v9_0_cp_compute_fini(adev);
-               return r;
-       }
-
-       r =3D amdgpu_bo_pin(ring->mqd_obj, AMDGPU_GEM_DOMAIN_GTT,
-                                 &mqd_gpu_addr);
-       if (r) {
-               dev_warn(adev->dev, "(%d) pin MQD bo failed\n", r);
-               gfx_v9_0_cp_compute_fini(adev);
-               return r;
-       }
-       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&buf);
-       if (r) {
-               dev_warn(adev->dev, "(%d) map MQD bo failed\n", r);
-               gfx_v9_0_cp_compute_fini(adev);
-               return r;
-       }
-
-       /* init the mqd struct */
-       memset(buf, 0, sizeof(struct v9_mqd));
-
-       mqd =3D (struct v9_mqd *)buf;
-       mqd->header =3D 0xC0310800;
-       mqd->compute_pipelinestat_enable =3D 0x00000001;
-       mqd->compute_static_thread_mgmt_se0 =3D 0xffffffff;
-       mqd->compute_static_thread_mgmt_se1 =3D 0xffffffff;
-       mqd->compute_static_thread_mgmt_se2 =3D 0xffffffff;
-       mqd->compute_static_thread_mgmt_se3 =3D 0xffffffff;
-       mqd->compute_misc_reserved =3D 0x00000003;
-       mutex_lock(&adev->srbm_mutex);
-       soc15_grbm_select(adev, ring->me,
-                              ring->pipe,
-                              ring->queue, 0);
-       /* disable wptr polling */
-       WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
-
-       /* write the EOP addr */
-       BUG_ON(ring->me !=3D 1 || ring->pipe !=3D 0); /* can't handle other=
 cases eop address */
-       eop_gpu_addr =3D adev->gfx.mec.hpd_eop_gpu_addr + (ring->queue * ME=
C_HPD_SIZE);
-       eop_gpu_addr >>=3D 8;
-
-       WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR, lower_32_bits(eop_gpu_a=
ddr));
-       WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI, upper_32_bits(eop_gp=
u_addr));
-       mqd->cp_hqd_eop_base_addr_lo =3D lower_32_bits(eop_gpu_addr);
-       mqd->cp_hqd_eop_base_addr_hi =3D upper_32_bits(eop_gpu_addr);
-
-       /* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-       tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL);
-       tmp =3D REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
-                                   (order_base_2(MEC_HPD_SIZE / 4) - 1));
-       WREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL, tmp);
-
-       /* enable doorbell? */
-       tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
-       if (use_doorbell)
-               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOOR=
BELL_EN, 1);
-       else
-               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOOR=
BELL_EN, 0);
-
-       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, tmp);
-       mqd->cp_hqd_pq_doorbell_control =3D tmp;
-
-       /* disable the queue if it's active */
-       ring->wptr =3D 0;
-       mqd->cp_hqd_dequeue_request =3D 0;
-       mqd->cp_hqd_pq_rptr =3D 0;
-       mqd->cp_hqd_pq_wptr_lo =3D 0;
-       mqd->cp_hqd_pq_wptr_hi =3D 0;
-       if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
-               WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
-               for (j =3D 0; j < adev->usec_timeout; j++) {
-                       if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
-                               break;
-                       udelay(1);
-               }
-               WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, mqd->cp_hqd_d=
equeue_request);
-               WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR, mqd->cp_hqd_pq_rptr);
-               WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO, mqd->cp_hqd_pq_wpt=
r_lo);
-               WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI, mqd->cp_hqd_pq_wpt=
r_hi);
-       }
-
-       /* set the pointer to the MQD */
-       mqd->cp_mqd_base_addr_lo =3D mqd_gpu_addr & 0xfffffffc;
-       mqd->cp_mqd_base_addr_hi =3D upper_32_bits(mqd_gpu_addr);
-       WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR, mqd->cp_mqd_base_addr_lo);
-       WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR_HI, mqd->cp_mqd_base_addr_hi=
);
-
-       /* set MQD vmid to 0 */
-       tmp =3D RREG32_SOC15(GC, 0, mmCP_MQD_CONTROL);
-       tmp =3D REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
-       WREG32_SOC15(GC, 0, mmCP_MQD_CONTROL, tmp);
-       mqd->cp_mqd_control =3D tmp;
-
-       /* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
-       hqd_gpu_addr =3D ring->gpu_addr >> 8;
-       mqd->cp_hqd_pq_base_lo =3D hqd_gpu_addr;
-       mqd->cp_hqd_pq_base_hi =3D upper_32_bits(hqd_gpu_addr);
-       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE, mqd->cp_hqd_pq_base_lo);
-       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI, mqd->cp_hqd_pq_base_hi);
-
-       /* set up the HQD, this is similar to CP_RB0_CNTL */
-       tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTROL);
-       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
-               (order_base_2(ring->ring_size / 4) - 1));
-       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
-               ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
-#ifdef __BIG_ENDIAN
-       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
-#endif
-       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
-       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ROQ_PQ_IB_FLIP, 0);
-       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
-       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
-       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTROL, tmp);
-       mqd->cp_hqd_pq_control =3D tmp;
-
-       /* set the wb address wether it's enabled or not */
-       wb_gpu_addr =3D adev->wb.gpu_addr + (ring->rptr_offs * 4);
-       mqd->cp_hqd_pq_rptr_report_addr_lo =3D wb_gpu_addr & 0xfffffffc;
-       mqd->cp_hqd_pq_rptr_report_addr_hi =3D
-       upper_32_bits(wb_gpu_addr) & 0xffff;
-       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR,
-               mqd->cp_hqd_pq_rptr_report_addr_lo);
-       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
-               mqd->cp_hqd_pq_rptr_report_addr_hi);
-
-       /* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=
=3D1 */
-       wb_gpu_addr =3D adev->wb.gpu_addr + (ring->wptr_offs * 4);
-       mqd->cp_hqd_pq_wptr_poll_addr_lo =3D wb_gpu_addr & 0xfffffffc;
-       mqd->cp_hqd_pq_wptr_poll_addr_hi =3D upper_32_bits(wb_gpu_addr) & 0=
xffff;
-       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
-               mqd->cp_hqd_pq_wptr_poll_addr_lo);
-       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
-               mqd->cp_hqd_pq_wptr_poll_addr_hi);
-
-       /* enable the doorbell if requested */
-       if (use_doorbell) {
-               WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
-                       (AMDGPU_DOORBELL64_KIQ * 2) << 2);
-               WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
-                       (AMDGPU_DOORBELL64_MEC_RING7 * 2) << 2);
-               tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
-               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-                       DOORBELL_OFFSET, ring->doorbell_index);
-               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOOR=
BELL_EN, 1);
-               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOOR=
BELL_SOURCE, 0);
-               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOOR=
BELL_HIT, 0);
-               mqd->cp_hqd_pq_doorbell_control =3D tmp;
-
-       } else {
-               mqd->cp_hqd_pq_doorbell_control =3D 0;
-       }
-       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
-               mqd->cp_hqd_pq_doorbell_control);
-
-       /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO, mqd->cp_hqd_pq_wptr_lo);
-       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI, mqd->cp_hqd_pq_wptr_hi);
-
-       /* set the vmid for the queue */
-       mqd->cp_hqd_vmid =3D 0;
-       WREG32_SOC15(GC, 0, mmCP_HQD_VMID, mqd->cp_hqd_vmid);
-
-       tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_PERSISTENT_STATE);
-       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0=
x53);
-       WREG32_SOC15(GC, 0, mmCP_HQD_PERSISTENT_STATE, tmp);
-       mqd->cp_hqd_persistent_state =3D tmp;
-
-       /* activate the queue */
-       mqd->cp_hqd_active =3D 1;
-       WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, mqd->cp_hqd_active);
-
-       soc15_grbm_select(adev, 0, 0, 0, 0);
-       mutex_unlock(&adev->srbm_mutex);
-
-       amdgpu_bo_kunmap(ring->mqd_obj);
-       amdgpu_bo_unreserve(ring->mqd_obj);
-
-       if (use_doorbell)
-               WREG32_FIELD15(GC, 0, CP_PQ_STATUS, DOORBELL_ENABLE, 1);
-
-       return 0;
-}
-
 const struct amdgpu_ip_block_version gfx_v9_0_ip_block =3D
 {
         .type =3D AMD_IP_BLOCK_TYPE_GFX,
--
2.5.5

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB16871760AD05B696AD9F3E0CFB190CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p><font size=3D"2"><span style=3D"font-size:10pt"><font size=3D"2"><span s=
tyle=3D"font-size:10pt">&#43;static int gfx_v9_0_kiq_kcq_disable(struct amd=
gpu_device *adev)</span></font></span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">...............<br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">&#43;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR=
(&quot;KCQ <span style=3D"color:rgb(208,92,18)">
enable</span> failed (scratch(0x%04X)=3D0x%08X)\n&quot;,</span></font></p>
<p><br>
</p>
<p><font size=3D"2">should be disable here.</font></p>
<p><font size=3D"2"><br>
</font></p>
<p><font size=3D"2">Best Regards</font></p>
<p><font size=3D"2">Rex</font><br>
</p>
<p><font size=3D"2"><span style=3D"font-size:10pt"></span></font><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, April 18, 2017 6:00:47 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH 12/12] drm/amdgpu/gfx9: Switch baremetal to use KIQ =
for compute ring management. (v3)</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">KIQ is the Kernel Interface Queue for managing the=
 MEC.&nbsp; Rather than setting<br>
up rings via direct MMIO of ring registers, the rings are configured via<br=
>
special packets sent to the KIQ.&nbsp; The allows the MEC to better manage =
shared<br>
resources and certain power events. It also reduces the code paths in the<b=
r>
driver to support and is required for MEC powergating.<br>
<br>
v2: drop gfx_v9_0_cp_compute_fini() as well<br>
v3: rebase on latest changes derived from gfx8, add unmap queues on<br>
hw_fini<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 374 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;--------------------------<br>
&nbsp;1 file changed, 81 insertions(&#43;), 293 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index f86a7f6..ef7a3ee 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -1113,23 &#43;1113,21 @@ static int gfx_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D gfx_v9_0_kiq_init(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
Failed to init KIQ BOs!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gfx_v9_0_kiq_init(adev);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to init KIQ BOs!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kiq =3D &amp;adev-&gt;gfx.kiq;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D gfx_v9_0_kiq_init_ring(adev, &amp;kiq-&gt;ring, &amp;kiq-&=
gt;irq);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq =3D &amp;adev-&gt;gfx.kiq;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gfx_v9_0_kiq_init_ring(adev=
, &amp;kiq-&gt;ring, &amp;kiq-&gt;irq);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* create MQD for all compute queues as wel as KIQ for SRIOV cas=
e */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D gfx_v9_0_compute_mqd_sw_init(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* create MQD for all compute que=
ues as wel as KIQ for SRIOV case */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gfx_v9_0_compute_mqd_sw_ini=
t(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reserve GDS, GWS and OA=
 resource for gfx */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_ker=
nel(adev, adev-&gt;gds.mem.gfx_partition_size,<br>
@@ -1176,11 &#43;1174,9 @@ static int gfx_v9_0_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;gfx.num_compute_rings; i&#43;&#43;)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(&amp;adev-&gt;gfx.compute_ring[i]);<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v9_0_compute_mqd_sw_fini(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v9_0_kiq_free_ring(&amp;adev-&gt;gfx.kiq.ring, &amp;adev-&gt=
;gfx.kiq.irq);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v9_0_kiq_fini(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_compute_mqd_sw_fini(adev=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_kiq_free_ring(&amp;adev-=
&gt;gfx.kiq.ring, &amp;adev-&gt;gfx.kiq.irq);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_kiq_fini(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_mec_fini(adev);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_ngg_fini(adev);<b=
r>
@@ -1736,13 &#43;1732,6 @@ static void gfx_v9_0_cp_compute_enable(struct am=
dgpu_device *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&nbsp;}<br>
&nbsp;<br>
-static int gfx_v9_0_cp_compute_start(struct amdgpu_device *adev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_cp_compute_enable(adev, true=
);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static int gfx_v9_0_cp_compute_load_microcode(struct amdgpu_device *a=
dev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gfx_firmware_=
header_v1_0 *mec_hdr;<br>
@@ -1785,45 &#43;1774,6 @@ static int gfx_v9_0_cp_compute_load_microcode(st=
ruct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static void gfx_v9_0_cp_compute_fini(struct amdgpu_device *adev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.num=
_compute_rings; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt;gfx.compute_ring[i];<=
br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ring-&gt;mqd_obj) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_=
reserve(ring-&gt;mqd_obj, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r !=
=3D 0))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;(%d) reserve M=
QD bo failed\n&quot;, r);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(=
ring-&gt;mqd_obj);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unrese=
rve(ring-&gt;mqd_obj);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(=
&amp;ring-&gt;mqd_obj);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;mqd_obj=
 =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-}<br>
-<br>
-static int gfx_v9_0_init_queue(struct amdgpu_ring *ring);<br>
-<br>
-static int gfx_v9_0_cp_compute_resume(struct amdgpu_device *adev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.num=
_compute_rings; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt;gfx.compute_ring[i];<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (gfx_v9_0_init_queue(ring))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&g=
t;dev, &quot;compute queue %d init failed!\n&quot;, i);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gfx_v9_0_cp_compute_start(adev)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;/* KIQ functions */<br>
&nbsp;static void gfx_v9_0_kiq_setting(struct amdgpu_ring *ring)<br>
&nbsp;{<br>
@@ -1914,6 &#43;1864,56 @@ static int gfx_v9_0_kiq_kcq_enable(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int gfx_v9_0_kiq_kcq_disable(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t scratch, tmp =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gfx_scratch_get(adev=
, &amp;scratch);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to get scratch reg (%d).\n&quot;, r);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(scratch, 0xCAFEDEAD);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_alloc(kiq_ring,=
 6 &#43; 3);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to lock KIQ (%d).\n&quot;, r);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_gfx_scratch_free(adev, scratch);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* unmap queues */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(kiq_ring, PACKE=
T3(PACKET3_UNMAP_QUEUES, 4));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(kiq_ring,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PACKET3_UNMAP_QUEUES_ACTION(1)| /* RESET_QUEUES */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PACKET3_UNMAP_QUEUES_QUEUE_SEL(2)); /* select all queues */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(kiq_ring, 0);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(kiq_ring, 0);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(kiq_ring, 0);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(kiq_ring, 0);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* write to scratch for completio=
n */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(kiq_ring, PACKE=
T3(PACKET3_SET_UCONFIG_REG, 1));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(kiq_ring, (scra=
tch - PACKET3_SET_UCONFIG_REG_START));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(kiq_ring, 0xDEA=
DBEEF);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(kiq_ring);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;use=
c_timeout; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp =3D RREG32(scratch);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (tmp =3D=3D 0xDEADBEEF)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_UDELAY(1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i &gt;=3D adev-&gt;usec_timeo=
ut) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_ERROR(&quot;KCQ enable failed (scratch(0x%04X)=3D0x%08X)=
\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
scratch, tmp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_scratch_free(adev, scr=
atch);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
@@ -2194,7 &#43;2194,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_=
ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_mqd *mqd =3D rin=
g-&gt;mqd_ptr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mqd_idx =3D ring - &am=
p;adev-&gt;gfx.compute_ring[0];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gfx.in_reset) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gfx.in_reset &amp;&=
amp; !adev-&gt;gfx.in_suspend) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset((void *)mqd, 0, sizeof(*mqd));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;srbm_mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc15_grbm_select(adev, ring-&gt;me, ring-&gt;pipe, r=
ing-&gt;queue, 0);<br>
@@ -2285,10 &#43;2285,7 @@ static int gfx_v9_0_cp_resume(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D gfx_v9_0_kiq_resume(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D gfx_v9_0_cp_compute_resume(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gfx_v9_0_kiq_resume(adev);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
@@ -2298,6 &#43;2295,13 @@ static int gfx_v9_0_cp_resume(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ring-&gt;ready =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;gfx.kiq.ri=
ng;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;ready =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_test_ring(ring)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ring-&gt;ready =3D false;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;gfx.num_compute_rings; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;gfx.compute_ring[i];<br>
&nbsp;<br>
@@ -2307,14 &#43;2311,6 @@ static int gfx_v9_0_cp_resume(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-=
&gt;ready =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ring =3D &amp;adev-&gt;gfx.kiq.ring;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ring-&gt;ready =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_ring_test_ring(ring);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;ready =
=3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_enable_gui_idle_i=
nterrupt(adev, true);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -2360,9 &#43;2356,9 @@ static int gfx_v9_0_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;For SRIOV client, shouldn't do anythin=
g.\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_kiq_kcq_disable(adev);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_cp_enable(adev, f=
alse);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_rlc_stop(adev);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_cp_compute_fini(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -2371,14 &#43;2367,18 @@ static int gfx_v9_0_suspend(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.in_suspend =3D true;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return gfx_v9_0_hw_fini(ad=
ev);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int gfx_v9_0_resume(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return gfx_v9_0_hw_init(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gfx_v9_0_hw_init(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.in_suspend =3D false=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static bool gfx_v9_0_is_idle(void *handle)<br>
@@ -3753,218 &#43;3753,6 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_d=
evice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int gfx_v9_0_init_queue(struct amdgpu_ring *ring)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, j;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_doorbell =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 hqd_gpu_addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 mqd_gpu_addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 eop_gpu_addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 wb_gpu_addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *buf;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct v9_mqd *mqd;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev =3D ring-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;mqd_obj =3D=3D NULL) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_bo_create(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct v9_mqd),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE,true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT, 0, NULL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, &amp;ring-&gt;mqd_obj);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&g=
t;dev, &quot;(%d) create MQD bo failed\n&quot;, r);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(ring-&gt;mqd_=
obj, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v9_0_cp_compute_fini(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_pin(ring-&gt;mqd_obj,=
 AMDGPU_GEM_DOMAIN_GTT,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mqd_gpu_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev, &quot;(%d) pin MQD bo failed\n&quot;, r);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v9_0_cp_compute_fini(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_kmap(ring-&gt;mqd_obj=
, (void **)&amp;buf);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev, &quot;(%d) map MQD bo failed\n&quot;, r);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v9_0_cp_compute_fini(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init the mqd struct */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(buf, 0, sizeof(struct v9_mqd))=
;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd =3D (struct v9_mqd *)buf;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;header =3D 0xC0310800;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;compute_pipelinestat_enable =
=3D 0x00000001;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;compute_static_thread_mgmt_se=
0 =3D 0xffffffff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;compute_static_thread_mgmt_se=
1 =3D 0xffffffff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;compute_static_thread_mgmt_se=
2 =3D 0xffffffff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;compute_static_thread_mgmt_se=
3 =3D 0xffffffff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;compute_misc_reserved =3D 0x0=
0000003;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;srbm_mutex);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc15_grbm_select(adev, ring-&gt;me,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;pipe,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;queue, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable wptr polling */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL=
_CNTL, EN, 0);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* write the EOP addr */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(ring-&gt;me !=3D 1 || ring-&gt=
;pipe !=3D 0); /* can't handle other cases eop address */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eop_gpu_addr =3D adev-&gt;gfx.mec.hpd=
_eop_gpu_addr &#43; (ring-&gt;queue * MEC_HPD_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eop_gpu_addr &gt;&gt;=3D 8;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE=
_ADDR, lower_32_bits(eop_gpu_addr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_EOP_BASE=
_ADDR_HI, upper_32_bits(eop_gpu_addr));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_eop_base_addr_lo =3D l=
ower_32_bits(eop_gpu_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_eop_base_addr_hi =3D u=
pper_32_bits(eop_gpu_addr);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the EOP size, register value i=
s 2^(EOP_SIZE&#43;1) dwords */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_=
EOP_CONTROL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_EOP=
_CONTROL, EOP_SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (order_base_2(MEC_H=
PD_SIZE / 4) - 1));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONT=
ROL, tmp);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable doorbell? */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_=
PQ_DOORBELL_CONTROL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_doorbell)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_=
EN, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_=
EN, 0);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORB=
ELL_CONTROL, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_doorbell_control =
=3D tmp;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable the queue if it's active *=
/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_dequeue_request =3D 0;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_rptr =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_wptr_lo =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_wptr_hi =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTI=
VE) &amp; 1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;usec_timeout; j&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(RREG32_SOC=
15(GC, 0, mmCP_HQD_ACTIVE) &amp; 1))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, mqd-&gt;cp_hqd_deq=
ueue_request);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR, mqd-&gt;cp_hqd_pq_rptr);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO, mqd-&gt;cp_hqd_pq_wptr_=
lo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI, mqd-&gt;cp_hqd_pq_wptr_=
hi);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the pointer to the MQD */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_mqd_base_addr_lo =3D mqd_g=
pu_addr &amp; 0xfffffffc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_mqd_base_addr_hi =3D upper=
_32_bits(mqd_gpu_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADD=
R, mqd-&gt;cp_mqd_base_addr_lo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADD=
R_HI, mqd-&gt;cp_mqd_base_addr_hi);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set MQD vmid to 0 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmCP_MQD_=
CONTROL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_MQD_CON=
TROL, VMID, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_MQD_CONTROL,=
 tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_mqd_control =3D tmp;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the pointer to the HQD, this i=
s similar CP_RB0_BASE/_HI */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hqd_gpu_addr =3D ring-&gt;gpu_addr &g=
t;&gt; 8;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_base_lo =3D hqd_gpu=
_addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_base_hi =3D upper_3=
2_bits(hqd_gpu_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE,=
 mqd-&gt;cp_hqd_pq_base_lo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_=
HI, mqd-&gt;cp_hqd_pq_base_hi);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set up the HQD, this is similar to=
 CP_RB0_CNTL */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_=
PQ_CONTROL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_=
CONTROL, QUEUE_SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (order_base_2(ring-&gt;ring_size / 4) - 1));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_=
CONTROL, RPTR_BLOCK_SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) &lt;&lt; 8));<br>
-#ifdef __BIG_ENDIAN<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_=
CONTROL, ENDIAN_SWAP, 1);<br>
-#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_=
CONTROL, UNORD_DISPATCH, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_=
CONTROL, ROQ_PQ_IB_FLIP, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_=
CONTROL, PRIV_STATE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_=
CONTROL, KMD_QUEUE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTR=
OL, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_control =3D tmp;<br=
>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the wb address wether it's ena=
bled or not */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wb_gpu_addr =3D adev-&gt;wb.gpu_addr =
&#43; (ring-&gt;rptr_offs * 4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_rptr_report_addr_lo=
 =3D wb_gpu_addr &amp; 0xfffffffc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_rptr_report_addr_hi=
 =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(wb_gpu_addr) &amp; 0xff=
ff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_=
REPORT_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mqd-&gt;cp_hqd_pq_rptr_report_addr_lo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_=
REPORT_ADDR_HI,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mqd-&gt;cp_hqd_pq_rptr_report_addr_hi);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only used if CP_PQ_WPTR_POLL_CNTL.=
CP_PQ_WPTR_POLL_CNTL__EN_MASK=3D1 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wb_gpu_addr =3D adev-&gt;wb.gpu_addr =
&#43; (ring-&gt;wptr_offs * 4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_wptr_poll_addr_lo =
=3D wb_gpu_addr &amp; 0xfffffffc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_wptr_poll_addr_hi =
=3D upper_32_bits(wb_gpu_addr) &amp; 0xffff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_=
POLL_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mqd-&gt;cp_hqd_pq_wptr_poll_addr_lo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_=
POLL_ADDR_HI,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mqd-&gt;cp_hqd_pq_wptr_poll_addr_hi);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable the doorbell if requested *=
/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_doorbell) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (AMDGPU_DOORBELL=
64_KIQ * 2) &lt;&lt; 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (AMDGPU_DOORBELL=
64_MEC_RING7 * 2) &lt;&lt; 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOORBELL_OFFSET,=
 ring-&gt;doorbell_index);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_=
EN, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_=
SOURCE, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_=
HIT, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mqd-&gt;cp_hqd_pq_doorbell_control =3D tmp;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mqd-&gt;cp_hqd_pq_doorbell_control =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORB=
ELL_CONTROL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mqd-&gt;cp_hqd_pq_doorbell_control);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reset read and write pointers, sim=
ilar to CP_RB0_WPTR/_RPTR */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_=
LO, mqd-&gt;cp_hqd_pq_wptr_lo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_=
HI, mqd-&gt;cp_hqd_pq_wptr_hi);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the vmid for the queue */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_vmid =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_VMID, mq=
d-&gt;cp_hqd_vmid);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_=
PERSISTENT_STATE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PER=
SISTENT_STATE, PRELOAD_SIZE, 0x53);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_PERSISTE=
NT_STATE, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_persistent_state =3D t=
mp;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* activate the queue */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_active =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, =
mqd-&gt;cp_hqd_active);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc15_grbm_select(adev, 0, 0, 0, 0);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;srbm_mutex=
);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(ring-&gt;mqd_obj);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(ring-&gt;mqd_obj)=
;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_doorbell)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_FIELD15(GC, 0, CP_PQ_STATUS, DOORBELL_ENABLE, 1);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;const struct amdgpu_ip_block_version gfx_v9_0_ip_block =3D<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .type =3D AMD_IP_BLOCK_TYP=
E_GFX,<br>
-- <br>
2.5.5<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR12MB16871760AD05B696AD9F3E0CFB190CY4PR12MB1687namp_--

--===============1269136397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1269136397==--
