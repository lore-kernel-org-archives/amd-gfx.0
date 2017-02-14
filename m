From: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Remove bo.priority compiler warning
Date: Tue, 14 Feb 2017 13:03:45 -0500
Message-ID: <daa4edb1-ace7-1640-6ae3-645126a64acc@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------92DB19EDEC3BE4DB70CDF15D"
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

--------------92DB19EDEC3BE4DB70CDF15D
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Addresses this compile warning:

warning: comparison of distinct pointer types lacks a cast [enabled by 
default]
   bo->tbo.priority = min(bo->tbo.priority, TTM_MAX_BO_PRIORITY - 1);

  Kent


--------------92DB19EDEC3BE4DB70CDF15D
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-Remove-bo.priority-compiler-warning.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Remove-bo.priority-compiler-warning.patch"

>From 3da9f2d478c048c36a395f92a2bdb49fe04b831e Mon Sep 17 00:00:00 2001
From: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 14 Feb 2017 12:52:35 -0500
Subject: [PATCH] drm/amdgpu: Remove bo.priority compiler warning

bo->tbo.priority is an unsigned, so casting to int to address the
warning shouldn't be an issue

Change-Id: I1a379e08f43b4c5f85c88446dff473baa87562f9
Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1c71bea..af6efb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -420,7 +420,7 @@ int amdgpu_bo_create_restricted(struct amdgpu_device *adev,
 	bo->tbo.priority = ilog2(bo->tbo.num_pages);
 	if (kernel)
 		bo->tbo.priority *= 2;
-	bo->tbo.priority = min(bo->tbo.priority, TTM_MAX_BO_PRIORITY - 1);
+	bo->tbo.priority = min((int)bo->tbo.priority, TTM_MAX_BO_PRIORITY - 1);
 
 	if (flags & AMDGPU_GEM_CREATE_VRAM_CLEARED &&
 	    bo->tbo.mem.placement & TTM_PL_FLAG_VRAM) {
-- 
2.7.4


--------------92DB19EDEC3BE4DB70CDF15D
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------92DB19EDEC3BE4DB70CDF15D--
