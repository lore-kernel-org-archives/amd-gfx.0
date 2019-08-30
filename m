From: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: SMU_MSG_OverridePcieParameters is
 unsupport for APU
Date: Fri, 30 Aug 2019 09:58:10 +0800
Message-ID: <1567130290-7756-1-git-send-email-aaron.liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.7.4"
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Ray.Huang-5C7GfCeVMHo@public.gmane.org, Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>

--------------2.7.4
Content-Type: text/plain; charset="UTF-8"; format=fixed
Content-Transfer-Encoding: 8bit


For apu, SMU_MSG_OverridePcieParameters is unsupport.
So return directly in smu_override_pcie_parameters function.

Signed-off-by: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 3 +++
 1 file changed, 3 insertions(+)


--------------2.7.4
Content-Type: text/x-patch;
	name="0001-drm-amd-powerplay-SMU_MSG_OverridePcieParameters-is-.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-drm-amd-powerplay-SMU_MSG_OverridePcieParameters-is-.patch"

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 8c61778..b726565 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1001,6 +1001,9 @@ static int smu_override_pcie_parameters(struct smu_context *smu)
 	uint32_t pcie_gen = 0, pcie_width = 0, smu_pcie_arg;
 	int ret;
 
+	if (adev->flags & AMD_IS_APU)
+		return 0;
+
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
 		pcie_gen = 3;
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)

--------------2.7.4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--------------2.7.4--
