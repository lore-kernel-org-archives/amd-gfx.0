From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup VCN IB generation
Date: Tue, 13 Feb 2018 08:50:24 -0500
Message-ID: <2992ee3b-c077-9222-b1e1-79ea9cb3c143@amd.com>
References: <20180207194822.7878-1-christian.koenig@amd.com>
 <20180207194822.7878-2-christian.koenig@amd.com>
 <839e2b57-edf4-d389-56ab-1a97dd84c832@amd.com>
 <6262040a-ef05-bda4-904e-d8a5954239bc@gmail.com>
 <eca08a4f-cc5c-ab86-acf0-f04444f733f4@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------52E8801C8C18D65B2A4D1935"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <eca08a4f-cc5c-ab86-acf0-f04444f733f4-5C7GfCeVMHo@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--------------52E8801C8C18D65B2A4D1935
Content-Type: multipart/alternative;
 boundary="------------188740810FA5ED0F0E637795"

--------------188740810FA5ED0F0E637795
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Found the issue, amdgpu_vcn_dec_get_destroy_msg was missing struct 
amdgpu_bo *bo *= NULL*; and so amdgpu_bo_create_reserved would not call 
amdgpu_bo_create.

Attached updated patch.

Thanks,

Andrey


On 02/12/2018 02:46 PM, Andrey Grodzovsky wrote:
> Tested with latest amd-staging-drm-next + VCN patch on top. VCN dec 
> tests pass but when modprobing amdgpu I get a few warnings and BUG_ONs 
> - log attached. UVD is not enabled so can't test the UVD patch.
>
>
> Thanks,
>
> Andrey
>
>
> On 02/09/2018 07:31 AM, Christian König wrote:
>> Question is rather can somebody please test this on Raven?
>>
>> Thanks,
>> Christian. 
>


--------------188740810FA5ED0F0E637795
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Found the issue, amdgpu_vcn_dec_get_destroy_msg was missing
      struct amdgpu_bo *bo <b>= NULL</b>; and so
      amdgpu_bo_create_reserved would not call amdgpu_bo_create.</p>
    <p>Attached updated patch.</p>
    <p>Thanks,</p>
    <p>Andrey<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 02/12/2018 02:46 PM, Andrey
      Grodzovsky wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:eca08a4f-cc5c-ab86-acf0-f04444f733f4-5C7GfCeVMHo@public.gmane.org">Tested
      with latest amd-staging-drm-next + VCN patch on top. VCN dec tests
      pass but when modprobing amdgpu I get a few warnings and BUG_ONs -
      log attached. UVD is not enabled so can't test the UVD patch.
      <br>
      <br>
      <br>
      Thanks,
      <br>
      <br>
      Andrey
      <br>
      <br>
      <br>
      On 02/09/2018 07:31 AM, Christian König wrote:
      <br>
      <blockquote type="cite">Question is rather can somebody please
        test this on Raven?
        <br>
        <br>
        Thanks,
        <br>
        Christian. </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------188740810FA5ED0F0E637795--

--------------52E8801C8C18D65B2A4D1935
Content-Type: text/x-patch;
 name="0001-drm-amdgpu-cleanup-VCN-IB-generation.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-drm-amdgpu-cleanup-VCN-IB-generation.patch"

>From 03d3d0195b4e672cefb2851e66f0fe03bd9089a3 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 7 Feb 2018 20:48:22 +0100
Subject: drm/amdgpu: cleanup VCN IB generation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Start to use amdgpu_bo_create_reserved v2.

v2:
Fix missing pointer init to NULL.
Remove extra new lines.

Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 91 ++++++++-------------------------
 1 file changed, 20 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e86d0b2..6c5e25f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -270,43 +270,26 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
 	return r;
 }
 
-static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
-			       bool direct, struct dma_fence **fence)
+static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
+				   struct amdgpu_bo *bo, bool direct,
+				   struct dma_fence **fence)
 {
-	struct ttm_operation_ctx ctx = { true, false };
-	struct ttm_validate_buffer tv;
-	struct ww_acquire_ctx ticket;
-	struct list_head head;
+	struct amdgpu_device *adev = ring->adev;
+	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
-	struct dma_fence *f = NULL;
-	struct amdgpu_device *adev = ring->adev;
 	uint64_t addr;
 	int i, r;
 
-	memset(&tv, 0, sizeof(tv));
-	tv.bo = &bo->tbo;
-
-	INIT_LIST_HEAD(&head);
-	list_add(&tv.head, &head);
-
-	r = ttm_eu_reserve_buffers(&ticket, &head, true, NULL);
-	if (r)
-		return r;
-
-	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-	if (r)
-		goto err;
-
 	r = amdgpu_job_alloc_with_ib(adev, 64, &job);
 	if (r)
 		goto err;
 
 	ib = &job->ibs[0];
 	addr = amdgpu_bo_gpu_offset(bo);
-	ib->ptr[0] = PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA0), 0);
+	ib->ptr[0] = PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA0),0);
 	ib->ptr[1] = addr;
-	ib->ptr[2] = PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA1), 0);
+	ib->ptr[2] = PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA1),0);
 	ib->ptr[3] = addr >> 32;
 	ib->ptr[4] = PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_CMD), 0);
 	ib->ptr[5] = 0;
@@ -330,11 +313,12 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *b
 			goto err_free;
 	}
 
-	ttm_eu_fence_buffer_objects(&ticket, &head, f);
+	amdgpu_bo_fence(bo, f, false);
+	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_unref(&bo);
 
 	if (fence)
 		*fence = dma_fence_get(f);
-	amdgpu_bo_unref(&bo);
 	dma_fence_put(f);
 
 	return 0;
@@ -343,7 +327,8 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *b
 	amdgpu_job_free(job);
 
 err:
-	ttm_eu_backoff_reservation(&ticket, &head);
+	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_unref(&bo);
 	return r;
 }
 
@@ -351,31 +336,16 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 			      struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo;
+	struct amdgpu_bo *bo = NULL;
 	uint32_t *msg;
 	int r, i;
 
-	r = amdgpu_bo_create(adev, 1024, PAGE_SIZE, true,
-			     AMDGPU_GEM_DOMAIN_VRAM,
-			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
-			     AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
-			     NULL, NULL, &bo);
+	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM,
+				      &bo, NULL, (void **)&msg);
 	if (r)
 		return r;
 
-	r = amdgpu_bo_reserve(bo, false);
-	if (r) {
-		amdgpu_bo_unref(&bo);
-		return r;
-	}
-
-	r = amdgpu_bo_kmap(bo, (void **)&msg);
-	if (r) {
-		amdgpu_bo_unreserve(bo);
-		amdgpu_bo_unref(&bo);
-		return r;
-	}
-
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000038);
 	msg[2] = cpu_to_le32(0x00000001);
@@ -393,9 +363,6 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = 14; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	amdgpu_bo_kunmap(bo);
-	amdgpu_bo_unreserve(bo);
-
 	return amdgpu_vcn_dec_send_msg(ring, bo, true, fence);
 }
 
@@ -403,31 +370,16 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 			       bool direct, struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo;
+	struct amdgpu_bo *bo = NULL;
 	uint32_t *msg;
 	int r, i;
 
-	r = amdgpu_bo_create(adev, 1024, PAGE_SIZE, true,
-			     AMDGPU_GEM_DOMAIN_VRAM,
-			     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
-			     AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
-			     NULL, NULL, &bo);
+	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM,
+				      &bo, NULL, (void **)&msg);
 	if (r)
 		return r;
 
-	r = amdgpu_bo_reserve(bo, false);
-	if (r) {
-		amdgpu_bo_unref(&bo);
-		return r;
-	}
-
-	r = amdgpu_bo_kmap(bo, (void **)&msg);
-	if (r) {
-		amdgpu_bo_unreserve(bo);
-		amdgpu_bo_unref(&bo);
-		return r;
-	}
-
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000018);
 	msg[2] = cpu_to_le32(0x00000000);
@@ -437,9 +389,6 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = 6; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	amdgpu_bo_kunmap(bo);
-	amdgpu_bo_unreserve(bo);
-
 	return amdgpu_vcn_dec_send_msg(ring, bo, direct, fence);
 }
 
-- 
2.7.4


--------------52E8801C8C18D65B2A4D1935
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------52E8801C8C18D65B2A4D1935--
