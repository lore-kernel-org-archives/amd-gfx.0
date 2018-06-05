From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2] drm/amdgpu: fix CG enabling hang with gfxoff enabled
Date: Tue, 5 Jun 2018 11:01:42 +0800
Message-ID: <1528167702-28398-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1652381436=="
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1652381436==
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit

After defer the execution of clockgating enabling, at that time, gfx already
enter into "off" state. Howerver, clockgating enabling will use MMIO to access
the gfx registers, then get the gfx hung.

So here we should move the gfx powergating and gfxoff enabling behavior at the
end of initialization behind clockgating.

Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---

Changes from V1 -> V2:
- Update real root cause of gfx hung with gfxoff enabled.

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             |  5 -----
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c     |  2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |  4 ++--
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f509d32..72b95f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1723,6 +1723,18 @@ static int amdgpu_device_ip_late_set_cg_state(struct amdgpu_device *adev)
 			}
 		}
 	}
+
+	if (adev->powerplay.pp_feature & PP_GFXOFF_MASK) {
+		/* enable gfx powergating */
+		amdgpu_device_ip_set_powergating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_CG_STATE_GATE);
+		/* enable gfxoff */
+		amdgpu_device_ip_set_powergating_state(adev,
+						       AMD_IP_BLOCK_TYPE_SMC,
+						       AMD_CG_STATE_GATE);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2c5e2a4..31ecc86 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3358,11 +3358,6 @@ static int gfx_v9_0_late_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
-						   AMD_PG_STATE_GATE);
-	if (r)
-		return r;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index b493369..d0e6e2d 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -245,7 +245,7 @@ static int pp_set_powergating_state(void *handle,
 	}
 
 	if (hwmgr->hwmgr_func->enable_per_cu_power_gating == NULL) {
-		pr_info("%s was not implemented.\n", __func__);
+		pr_debug("%s was not implemented.\n", __func__);
 		return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 7712eb6..b72d089 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -284,7 +284,7 @@ static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)
 
 static int smu10_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
-	return smu10_disable_gfx_off(hwmgr);
+	return 0;
 }
 
 static int smu10_enable_gfx_off(struct pp_hwmgr *hwmgr)
@@ -299,7 +299,7 @@ static int smu10_enable_gfx_off(struct pp_hwmgr *hwmgr)
 
 static int smu10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
-	return smu10_enable_gfx_off(hwmgr);
+	return 0;
 }
 
 static int smu10_gfx_off_control(struct pp_hwmgr *hwmgr, bool enable)
-- 
2.7.4


--===============1652381436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1652381436==--
