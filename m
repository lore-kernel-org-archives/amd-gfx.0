From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v4 5/5] drm/amdgpu: move PD/PT bos on LRU again
Date: Fri, 17 Aug 2018 18:08:01 +0800
Message-ID: <1534500481-15123-6-git-send-email-ray.huang@amd.com>
References: <1534500481-15123-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1517142213=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534500481-15123-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

--===============1517142213==
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit

The new bulk moving functionality is ready, the overhead of moving PD/PT bos to
LRU is fixed. So move them on LRU again.

Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Tested-by: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Tested-by: Dieter Nützel <Dieter-0hun7QTegEsDD4udEopG9Q@public.gmane.org>
Acked-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 037cfbc..f498b7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1121,7 +1121,7 @@ int amdgpu_vm_update_directories(struct amdgpu_device *adev,
 					   struct amdgpu_vm_bo_base,
 					   vm_status);
 		bo_base->moved = false;
-		list_del_init(&bo_base->vm_status);
+		list_move(&bo_base->vm_status, &vm->idle);
 
 		bo = bo_base->bo->parent;
 		if (!bo)
-- 
2.7.4


--===============1517142213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1517142213==--
