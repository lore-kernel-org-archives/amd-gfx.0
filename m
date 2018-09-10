From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Fixing SDMA TO after GPU reset
Date: Mon, 10 Sep 2018 18:52:28 -0400
Message-ID: <059118f3-2729-12a1-7c8d-e306f69369aa@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------E54A63366F88D57DB4C07841"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--------------E54A63366F88D57DB4C07841
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Attached patch fixes SDMA TO after GPU reset, it's a regression caused 
by cbd5285 drm/amdgpu: move setting the GART addr into TTM.

But to me it looks safer just to revert the original patch all together 
since we never can predict for sure if VM flush will take place and so 
it's safer to just always assign job->vm_pd_addr.

Andrey


--------------E54A63366F88D57DB4C07841
Content-Type: text/x-patch;
 name="0001-drm-amdgpu-Fix-SDMA-TO-after-GPU-reset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-amdgpu-Fix-SDMA-TO-after-GPU-reset.patch"

>From 038ca047fc41d85fb390b9564cebc7c6da441831 Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Date: Mon, 10 Sep 2018 18:43:58 -0400
Subject: drm/amdgpu: Fix SDMA TO after GPU reset

After GPU reset amdgpu_vm_clear_bo triggers VM flush
but job->vm_pd_addr is not set causing SDMA TO.

Fixes cbd5285 drm/amdgpu: move setting the GART addr into TTM.
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f5a9600..88598b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -526,6 +526,8 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
+	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
+
 	addr = amdgpu_bo_gpu_offset(bo);
 	if (ats_entries) {
 		uint64_t ats_value;
-- 
2.7.4


--------------E54A63366F88D57DB4C07841
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------E54A63366F88D57DB4C07841--
