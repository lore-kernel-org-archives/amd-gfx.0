From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix the page fault of raven2
Date: Mon, 24 Sep 2018 10:07:00 +0800
Message-ID: <1537754820-17901-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0108930013=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

--===============0108930013==
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit

While the apg_end address is 0xffffffff, if add 1 with it, the value will be
overflow and roll back to 0. So when 0 is written to
mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, the system aperture is actually disabled. And
so any access to vram will trigger a page fault.

Raven2's HW issue only need increase the vram end address, and needn't do it on
the agp.

Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Marek Olšák <marek.olsak-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 65f58eb..ceb7847 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -82,7 +82,8 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		 * to get rid of the VM fault and hardware hang.
 		 */
 		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-			     (max(adev->gmc.vram_end, adev->gmc.agp_end) >> 18) + 0x1);
+			     max((adev->gmc.vram_end >> 18) + 0x1,
+				 adev->gmc.agp_end >> 18));
 	else
 		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 			     max(adev->gmc.vram_end, adev->gmc.agp_end) >> 18);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 80698b5..14649f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -100,7 +100,8 @@ static void mmhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		 * to get rid of the VM fault and hardware hang.
 		 */
 		WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-			     (max(adev->gmc.vram_end, adev->gmc.agp_end) >> 18) + 0x1);
+			     max((adev->gmc.vram_end >> 18) + 0x1,
+				 adev->gmc.agp_end >> 18));
 	else
 		WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 			     max(adev->gmc.vram_end, adev->gmc.agp_end) >> 18);
-- 
2.7.4


--===============0108930013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0108930013==--
