From: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: update IH_CHICKEN in oss 4.0 IP header for
 VG/RV series
Date: Fri, 30 Aug 2019 13:33:14 +0800
Message-ID: <1567143195-22090-1-git-send-email-aaron.liu@amd.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Ray.Huang-5C7GfCeVMHo@public.gmane.org, Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>

--------------2.7.4
Content-Type: text/plain; charset="UTF-8"; format=fixed
Content-Transfer-Encoding: 8bit


In Renoir's emulator, those chicken bits need to be programmed.

Signed-off-by: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_mask.h | 4 ++++
 1 file changed, 4 insertions(+)


--------------2.7.4
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-update-IH_CHICKEN-in-oss-4.0-IP-header-fo.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-update-IH_CHICKEN-in-oss-4.0-IP-header-fo.patch"

diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_mask.h
index 1ee3a23..dc9895a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_0_sh_mask.h
@@ -1109,7 +1109,11 @@
 #define IH_CID_REMAP_DATA__CLIENT_ID_REMAP_MASK                                                               0x00FF0000L
 //IH_CHICKEN
 #define IH_CHICKEN__ACTIVE_FCN_ID_PROT_ENABLE__SHIFT                                                          0x0
+#define IH_CHICKEN__MC_SPACE_FBPA_ENABLE__SHIFT                                                               0x3
+#define IH_CHICKEN__MC_SPACE_GPA_ENABLE__SHIFT                                                                0x4
 #define IH_CHICKEN__ACTIVE_FCN_ID_PROT_ENABLE_MASK                                                            0x00000001L
+#define IH_CHICKEN__MC_SPACE_FBPA_ENABLE_MASK                                                                 0x00000008L
+#define IH_CHICKEN__MC_SPACE_GPA_ENABLE_MASK                                                                  0x00000010L
 //IH_MMHUB_CNTL
 #define IH_MMHUB_CNTL__UNITID__SHIFT                                                                          0x0
 #define IH_MMHUB_CNTL__IV_TLVL__SHIFT                                                                         0x8

--------------2.7.4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--------------2.7.4--
