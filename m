From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Reverted another change to fix buffer move hangs (was Re: [PATCH]
 drm/ttm: partial revert "cleanup ttm_tt_(unbind|destroy)" v2)
Date: Mon, 15 Aug 2016 15:06:41 -0400
Message-ID: <d120fde0-a175-c9b5-a3ab-b6840207190e@amd.com>
References: <1469193013-11482-1-git-send-email-deathsimple@vodafone.de>
 <95d462b5-7c20-2f40-c406-48f5aece0817@daenzer.net>
 <58e8df15-98dd-facc-acb6-68f94a937374@amd.com>
 <67b3c224-29e0-0a98-6c3a-8439744149da@amd.com>
 <c76c7703-6c0d-0d2a-ba9f-c012d74c01bf@amd.com>
 <MWHPR12MB16948D7420076C10DCFAEEBBF71E0@MWHPR12MB1694.namprd12.prod.outlook.com>
 <12c479b4-64d0-952c-f9d2-decd25533251@amd.com>
 <c016cb14-f262-7432-f4ef-cdbb638807f4@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------D17BCE8E885C2E7654D80637"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c016cb14-f262-7432-f4ef-cdbb638807f4-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--------------D17BCE8E885C2E7654D80637
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Patch against current amd-staging-4.6 is attached.

Regards,
  Felix


On 16-08-13 05:25 AM, Christian König wrote:
> Am 13.08.2016 um 01:22 schrieb Felix Kuehling:
>> [CC Kent FYI]
>>
>> On 16-08-11 04:31 PM, Deucher, Alexander wrote:
>>>> -----Original Message-----
>>>> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
>>>> Of Felix Kuehling
>>>> Sent: Thursday, August 11, 2016 3:52 PM
>>>> To: Michel Dänzer; Christian König
>>>> Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> Subject: Reverted another change to fix buffer move hangs (was Re:
>>>> [PATCH] drm/ttm: partial revert "cleanup ttm_tt_(unbind|destroy)" v2)
>>>>
>>>> We had to revert another change on the KFD branch to fix a buffer move
>>>> problem: 8b6b79f43801f00ddcdc10a4d5719eba4b2e32aa (drm/amdgpu:
>>>> group BOs
>>>> by log2 of the size on the LRU v2
>>> That makes sense.  I think you may want a different LRU scheme for
>>> KFD or at least special handling for KFD buffers.
>> [FK] But I think the patch shouldn't cause hangs, regardless.
>>
>> I eventually found what the problem was. The "group BOs by log2 of the
>> size on the LRU v2" patch exposed a latent bug related to the GART size.
>> On our KFD branch, we calculate the GART size differently, and it can
>> easily go above 4GB. I think on amd-staging-4.6 the GART size can also
>> go above 4GB on cards with lots of VRAM.
>>
>> However, the offset parameter in amdgpu_gart_bind and unbind is only
>> 32-bit. With the patch our test ended up using GART offsets beyond 4GB
>> for the first time. Changing the offset parameter to uint64_t fixes the
>> problem.
>
> Nice catch, please provide a patch to fix this.
>
>> Our test also demonstrates a potential flaw in the log2 grouping patch:
>> When a buffer of a previously unused size is added to the LRU, it gets
>> added to the front of the list, rather than the tail. So an application
>> that allocates a very large buffer after a bunch of smaller buffers, is
>> very likely to have that buffer evicted over and over again before any
>> smaller buffers are considered for eviction. I believe, this can result
>> in thrashing of large buffers.
>>
>> Some other observations: When the last BO of a given size is removed
>> from the LRU list, the LRU tail for that size is left "floating" in the
>> middle of the LRU list. So the next BO of that size that is added, will
>> be added at an arbitrary position in the list. It may even end up in the
>> middle of a block of pages of a different size. So a log2 grouping may
>> end up being split.
>
> Yeah, those are more or less known issues.
>
> Keep in mind that we only added the grouping by log2 of the size to
> have a justification to push the TTM changes upstream for the coming
> KFD fences.
>
> E.g. so that we are able to have this upstream before we try to push
> on the fence code.
>
> I will take a look at fixing those issues when I have time, shouldn't
> be to complicated to set the entries to zero when they aren't used or
> adjust other entries as well when some are added.
>
> Regards,
> Christian.
>
>>
>> Regards,
>>    Felix
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>


--------------D17BCE8E885C2E7654D80637
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-Change-GART-offset-to-64-bit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Change-GART-offset-to-64-bit.patch"

>From 34b9f9e33fc83e375c291e8d3480f8faff150183 Mon Sep 17 00:00:00 2001
From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 12 Aug 2016 19:25:21 -0400
Subject: [PATCH] drm/amdgpu: Change GART offset to 64-bit

The GART aperture size can be bigger than 4GB. Therefore the offset
used in amdgpu_gart_bind and amdgpu_gart_unbind must be 64-bit.

Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d4ab35a..a55eb6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -662,9 +662,9 @@ int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev);
 void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);
 int amdgpu_gart_init(struct amdgpu_device *adev);
 void amdgpu_gart_fini(struct amdgpu_device *adev);
-void amdgpu_gart_unbind(struct amdgpu_device *adev, unsigned offset,
+void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 			int pages);
-int amdgpu_gart_bind(struct amdgpu_device *adev, unsigned offset,
+int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		     int pages, struct page **pagelist,
 		     dma_addr_t *dma_addr, uint32_t flags);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 921bce2..0feea34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -221,7 +221,7 @@ void amdgpu_gart_table_vram_free(struct amdgpu_device *adev)
  * Unbinds the requested pages from the gart page table and
  * replaces them with the dummy page (all asics).
  */
-void amdgpu_gart_unbind(struct amdgpu_device *adev, unsigned offset,
+void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 			int pages)
 {
 	unsigned t;
@@ -268,7 +268,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, unsigned offset,
  * (all asics).
  * Returns 0 for success, -EINVAL for failure.
  */
-int amdgpu_gart_bind(struct amdgpu_device *adev, unsigned offset,
+int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		     int pages, struct page **pagelist, dma_addr_t *dma_addr,
 		     uint32_t flags)
 {
-- 
1.9.1


--------------D17BCE8E885C2E7654D80637
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------D17BCE8E885C2E7654D80637--
