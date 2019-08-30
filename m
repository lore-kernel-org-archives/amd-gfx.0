From: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: fix no interrupt issue for renoir emu (v2)
Date: Fri, 30 Aug 2019 13:33:15 +0800
Message-ID: <1567143195-22090-2-git-send-email-aaron.liu@amd.com>
References: <1567143195-22090-1-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.7.4"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1567143195-22090-1-git-send-email-aaron.liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Ray.Huang-5C7GfCeVMHo@public.gmane.org, Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>

--------------2.7.4
Content-Type: text/plain; charset="UTF-8"; format=fixed
Content-Transfer-Encoding: 8bit


In renoir's vega10_ih model, there's a security change in mmIH_CHICKEN
register, that limits IH to use physical address (FBPA, GPA) directly.
Those chicken bits need to be programmed first.

Signed-off-by: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)


--------------2.7.4
Content-Type: text/x-patch;
	name="0002-drm-amdgpu-fix-no-interrupt-issue-for-renoir-emu-v2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-drm-amdgpu-fix-no-interrupt-issue-for-renoir-emu-v2.patch"

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index f19268a..b273eb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -232,7 +232,13 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI, (ih->gpu_addr >> 40) & 0xff);
 
 	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
+	ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
 	ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
+	if (adev->irq.ih.use_bus_addr) {
+		ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
+	} else {
+		ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN, MC_SPACE_FBPA_ENABLE, 1);
+	}
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
 				   !!adev->irq.msi_enabled);
 
@@ -245,14 +251,10 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	}
 
-	if ((adev->asic_type == CHIP_ARCTURUS || adev->asic_type == CHIP_RENOIR) &&
-		adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-		if (adev->irq.ih.use_bus_addr) {
-			ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
-			ih_chicken |= 0x00000010;
-			WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);
-		}
-	}
+	if ((adev->asic_type == CHIP_ARCTURUS
+		&& adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
+		|| adev->asic_type == CHIP_RENOIR)
+		WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);
 
 	/* set the writeback address whether it's enabled or not */
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO,

--------------2.7.4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--------------2.7.4--
