From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm 0/4] Dynamicly disable suites and tets.
Date: Mon, 13 Nov 2017 09:57:35 -0500
Message-ID: <faf30a58-a8cf-05b2-6028-065438b38f07@amd.com>
References: <1510288203-21716-1-git-send-email-andrey.grodzovsky@amd.com>
 <fbf19682-a259-4105-7f4b-193524fe2dae@amd.com>
 <407f0a79-e15b-61b7-2e3a-8f4b680c9c6c@amd.com>
 <ebac16f5-4d16-d6e9-8bc0-5ee0de061719@amd.com>
 <58c5d164-078d-74cc-b3ab-07bf6d39287c@amd.com>
 <1245c92c-bfc4-d343-c752-17fa036e1bad@amd.com>
 <7a5b2721-5938-c865-27b0-47dae1ad5883@daenzer.net>
 <cbb173a7-289f-c13d-5518-55ea20a69b58@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------7BC5953CCBD8B0B8A753FC8F"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cbb173a7-289f-c13d-5518-55ea20a69b58-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------7BC5953CCBD8B0B8A753FC8F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/13/2017 07:39 AM, Christian König wrote:

> Am 13.11.2017 um 12:32 schrieb Michel Dänzer:
>> On 12/11/17 10:35 AM, Christian König wrote:
>>> A few comments on the code:
>>>
>>>> +/* Validate bo size is bit bigger then the request domain */
>>>> +static inline bool amdgpu_bo_validate_bo_size(struct amdgpu_device
>>>> *adev,
>>>> +                      unsigned long size, u32 domain)
>>> Drop the inline keyword and the second _bo_ in the name here.
>>>
>>>> +{
>>>> +    struct ttm_mem_type_manager *man = NULL;
>>>> +
>>>> +    if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
>>>> +        man = &adev->mman.bdev.man[TTM_PL_VRAM];
>>>> +
>>>> +        if (man && size < (man->size << PAGE_SHIFT))
>>> Drop the extra check that man is not NULL. We get the pointer to an
>>> array element, that can't be NULL.
>>>
>>>> +            return true;
>>> Mhm, domain is a bitmask of allowed domains.
>>>
>>> So we should check all valid domains if the size fit, not just the 
>>> first
>>> one.
>> Assuming VRAM <-> system migration of BOs larger than the GTT domain
>> works, I'd say we should only require that the BO can fit in any of the
>> allowed domains. Otherwise it must also always fit in GTT.
> Good point, and yes VRAM <-> system migration of BOs larger than the 
> GTT domain works now.
>
> I can agree on that VRAM should probably be optional, otherwise we 
> can't allocate anything large when the driver uses only very low 
> amounts of stolen VRAM on APUs.
>
> But I think when userspace requests VRAM and GTT at the same time we 
> still should be able to fall back to GTT.

Attached V2 patch, I still don't understand why I experience the SIGSEV 
in the tester when the check fails and the IOCTLs will return ENOMEM

I will update the libdrm test to correctly handle mem failure, it 
segfaults at the moment.


Thanks,
Andey
>
> Regards,
> Christian.


--------------7BC5953CCBD8B0B8A753FC8F
Content-Type: text/x-patch;
 name="0001-drm-amdgpu-Implement-BO-size-validation-V2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-amdgpu-Implement-BO-size-validation-V2.patch"

>From 37369b3a58027dedf7e9dc65fd9bc0f9e86d0d80 Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 10 Nov 2017 18:35:56 -0500
Subject: drm/amdgpu: Implement BO size validation V2

Validates BO size against each requested domain's total memory.

v2:
Make GTT size check a MUST to allow fall back to GTT.
Rmove redundant NULL check.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index a937c49..5acf20c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -281,6 +281,44 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 		*cpu_addr = NULL;
 }
 
+/* Validate bo size is bit bigger then the request domain */
+static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
+					  unsigned long size, u32 domain)
+{
+	struct ttm_mem_type_manager *man = NULL;
+
+	/*
+	 * If GTT is part of requested domains the check must succeed to
+	 * allow fall back to GTT
+	 */
+	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
+		man = &adev->mman.bdev.man[TTM_PL_TT];
+
+		if (size < (man->size << PAGE_SHIFT))
+			return true;
+		else
+			goto fail;
+	}
+
+	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
+		man = &adev->mman.bdev.man[TTM_PL_VRAM];
+
+		if (size < (man->size << PAGE_SHIFT))
+			return true;
+		else
+			goto fail;
+	}
+
+
+	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
+	return true;
+
+fail:
+	DRM_ERROR("BO size %lu > total memory in domain: %llu\n", size,
+					      man->size << PAGE_SHIFT);
+	return false;
+}
+
 static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 			       unsigned long size, int byte_align,
 			       bool kernel, u32 domain, u64 flags,
@@ -299,6 +337,9 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	page_align = roundup(byte_align, PAGE_SIZE) >> PAGE_SHIFT;
 	size = ALIGN(size, PAGE_SIZE);
 
+	if (!amdgpu_bo_validate_size(adev, size, domain))
+		return -ENOMEM;
+
 	if (kernel) {
 		type = ttm_bo_type_kernel;
 	} else if (sg) {
-- 
2.7.4


--------------7BC5953CCBD8B0B8A753FC8F
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------7BC5953CCBD8B0B8A753FC8F--
