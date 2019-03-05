From: =?UTF-8?B?5ZGo56OK?= <mfk530-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix kernel Oops caused by change_bit in ARM64
Date: Tue, 5 Mar 2019 10:37:42 +0800
Message-ID: <CALKDN1PRNNDMhNKYaNsFdkYCKM4R4tUtQ9svXdmPwBQL6=AzFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0046881164=="
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

--===============0046881164==
Content-Type: multipart/alternative; boundary="00000000000087c5c905834fc277"

--00000000000087c5c905834fc277
Content-Type: text/plain; charset="UTF-8"

I got this kernel Oops when running ROCm kernel in a ARM64 machine with
Vega64 card.

---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 20d7e4775d49..b6945af39b95 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -726,8 +726,8 @@ static bool gmc_v9_0_keep_stolen_memory(struct
amdgpu_device *adev)
 static int gmc_v9_0_allocate_vm_inv_eng(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] =
-		{GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP};
+	unsigned long vm_inv_engs[AMDGPU_MAX_VMHUBS] =
+		      {GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP};
 	unsigned i;
 	unsigned vmhub, inv_eng;

@@ -743,7 +743,7 @@ static int gmc_v9_0_allocate_vm_inv_eng(struct
amdgpu_device *adev)
 		}

 		ring->vm_inv_eng = inv_eng - 1;
-		change_bit(inv_eng - 1, (unsigned long *)(&vm_inv_engs[vmhub]));
+		change_bit(inv_eng - 1, &vm_inv_engs[vmhub]);

 		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
 			 ring->name, ring->vm_inv_eng, ring->funcs->vmhub);

--00000000000087c5c905834fc277
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">I got this kernel Oops when running ROCm kernel in a ARM64 machine with Vega64 card.<div><br><div><pre style="color:rgb(0,0,0);white-space:pre-wrap">---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 20d7e4775d49..b6945af39b95 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -726,8 +726,8 @@ static bool gmc_v9_0_keep_stolen_memory(struct amdgpu_device *adev)
 static int gmc_v9_0_allocate_vm_inv_eng(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] =
-		{GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP};
+	unsigned long vm_inv_engs[AMDGPU_MAX_VMHUBS] =
+		      {GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP};
 	unsigned i;
 	unsigned vmhub, inv_eng;
 
@@ -743,7 +743,7 @@ static int gmc_v9_0_allocate_vm_inv_eng(struct amdgpu_device *adev)
 		}
 
 		ring-&gt;vm_inv_eng = inv_eng - 1;
-		change_bit(inv_eng - 1, (unsigned long *)(&amp;vm_inv_engs[vmhub]));
+		change_bit(inv_eng - 1, &amp;vm_inv_engs[vmhub]);
 
 		dev_info(adev-&gt;dev, &quot;ring %s uses VM inv eng %u on hub %u\n&quot;,
 			 ring-&gt;name, ring-&gt;vm_inv_eng, ring-&gt;funcs-&gt;vmhub);</pre></div></div></div>

--00000000000087c5c905834fc277--

--===============0046881164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0046881164==--
