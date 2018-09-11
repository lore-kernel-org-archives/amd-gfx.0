From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix the dead lock issue.
Date: Tue, 11 Sep 2018 13:41:56 +0800
Message-ID: <83f7a45f-1aee-a2a8-bc82-f3433157c6cb@amd.com>
References: <1536634293-26099-1-git-send-email-Emily.Deng@amd.com>
 <bf049e4b-321f-33b4-dad2-708269515e90@amd.com>
 <BN7PR12MB2644CEE78E8E6D658D1A686E8F040@BN7PR12MB2644.namprd12.prod.outlook.com>
 <fcbc7544-d08d-4051-c554-f1f9cecb87e1@amd.com>
 <BN7PR12MB2644E374B512DC7EF10CA6D08F040@BN7PR12MB2644.namprd12.prod.outlook.com>
 <be67e50d-f161-c7da-256e-149ed1b56f26@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------57E075D6EAC58DDAB6A86B59"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <be67e50d-f161-c7da-256e-149ed1b56f26-5C7GfCeVMHo@public.gmane.org>
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--------------57E075D6EAC58DDAB6A86B59
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年09月11日 11:37, zhoucm1 wrote:
>
>
> On 2018年09月11日 11:32, Deng, Emily wrote:
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
>>> zhoucm1
>>> Sent: Tuesday, September 11, 2018 11:28 AM
>>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; Zhou, David(ChunMing)
>>> <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> Subject: Re: [PATCH] drm/amdgpu: Fix the dead lock issue.
>>>
>>>
>>>
>>> On 2018年09月11日 11:23, Deng, Emily wrote:
>>>>> -----Original Message-----
>>>>> From: Zhou, David(ChunMing)
>>>>> Sent: Tuesday, September 11, 2018 11:03 AM
>>>>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>> Subject: Re: [PATCH] drm/amdgpu: Fix the dead lock issue.
>>>>>
>>>>>
>>>>>
>>>>> On 2018年09月11日 10:51, Emily Deng wrote:
>>>>>> It will ramdomly have the dead lock issue when test TDR:
>>>>>> 1. amdgpu_device_handle_vram_lost gets the lock shadow_list_lock 2.
>>>>>> amdgpu_bo_create locked the bo's resv lock 3.
>>>>>> amdgpu_bo_create_shadow is waiting for the shadow_list_lock 4.
>>>>>> amdgpu_device_recover_vram_from_shadow is waiting for the bo's resv
>>>>>> lock.
>>>>>>
>>>>>> v2:
>>>>>>       Make a local copy of the list
>>>>>>
>>>>>> Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21
>>>>> ++++++++++++++++++++-
>>>>>>     1 file changed, 20 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 2a21267..8c81404 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -3105,6 +3105,9 @@ static int
>>>>> amdgpu_device_handle_vram_lost(struct amdgpu_device *adev)
>>>>>>         long r = 1;
>>>>>>         int i = 0;
>>>>>>         long tmo;
>>>>>> +    struct list_head local_shadow_list;
>>>>>> +
>>>>>> +    INIT_LIST_HEAD(&local_shadow_list);
>>>>>>
>>>>>>         if (amdgpu_sriov_runtime(adev))
>>>>>>             tmo = msecs_to_jiffies(8000);
>>>>>> @@ -3112,8 +3115,19 @@ static int
>>>>> amdgpu_device_handle_vram_lost(struct amdgpu_device *adev)
>>>>>>             tmo = msecs_to_jiffies(100);
>>>>>>
>>>>>>         DRM_INFO("recover vram bo from shadow start\n");
>>>>>> +
>>>>>> +    mutex_lock(&adev->shadow_list_lock);
>>>>>> +    list_splice_init(&adev->shadow_list, &local_shadow_list);
>>>>>> +    mutex_unlock(&adev->shadow_list_lock);
>>>>>> +
>>>>>> +
>>>>>>         mutex_lock(&adev->shadow_list_lock);
>>>>> local_shadow_list is a local variable, I think it doesn't need lock
>>>>> at all, no one change it. Otherwise looks good to me.
>>>> The bo->shadow_list which now is in local_shadow_list maybe destroy in
>>>> case that it already in amdgpu_bo_destroy, then it will change
>>> local_shadow_list, so need lock the shadow_list_lock.
>>> Ah, sorry for noise, I forget you don't reference these BOs.
>> Yes, I don't reference these Bos, as I found even reference these 
>> Bos, it still couldn't avoid the case that another process is already
>> in amdgpu_bo_destroy.
> ??? that shouldn't happen, the reference is belonged to list. But back 
> to here, we don't need reference them.
> And since no shadow BO is added to local after splice, we'd better to 
> use list_next_entry to iterate the local shadow list instead of 
> list_for_each_entry_safe.
>
> Thanks,
> David Zhou
>>> Thanks,
>>> David Zhou
>>>> Best wishes
>>>> Emily Deng
>>>>> Thanks,
>>>>> David Zhou
>>>>>> -    list_for_each_entry_safe(bo, tmp, &adev->shadow_list, 
>>>>>> shadow_list) {
>>>>>> +    list_for_each_entry_safe(bo, tmp, &local_shadow_list, 
>>>>>> shadow_list) {
because shadow list doesn't take bo reference, we should give a 
amdgpu_bo_ref(bo) with attached patch before unlock.
You can have a try.

Thanks,
David Zhou
>>>>>> + mutex_unlock(&adev->shadow_list_lock);
>>>>>> +
>>>>>> +        if (!bo)
>>>>>> +            continue;
>>>>>> +
>>>>>>             next = NULL;
>>>>>>             amdgpu_device_recover_vram_from_shadow(adev, ring, bo,
>>>>> &next);
>>>>>>             if (fence) {
>>>>>> @@ -3132,9 +3146,14 @@ static int
>>>>>> amdgpu_device_handle_vram_lost(struct amdgpu_device *adev)
>>>>>>
>>>>>>             dma_fence_put(fence);
>>>>>>             fence = next;
>>>>>> +        mutex_lock(&adev->shadow_list_lock);
>>>>>>         }
>>>>>>         mutex_unlock(&adev->shadow_list_lock);
>>>>>>
>>>>>> +    mutex_lock(&adev->shadow_list_lock);
>>>>>> +    list_splice_init(&local_shadow_list, &adev->shadow_list);
>>>>>> +    mutex_unlock(&adev->shadow_list_lock);
>>>>>> +
>>>>>>         if (fence) {
>>>>>>             r = dma_fence_wait_timeout(fence, false, tmo);
>>>>>>             if (r == 0)
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------57E075D6EAC58DDAB6A86B59
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-changing-of-shadow-bo-reference-should-ta.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-drm-amdgpu-changing-of-shadow-bo-reference-should-ta.pa";
	filename*1="tch"

>From 7676fc70738699dddca5627e21be0d82e91aea05 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 11 Sep 2018 13:37:31 +0800
Subject: [PATCH] drm/amdgpu: changing of shadow bo reference should take
 shadow lock

because shadow list doesn't reference shadow bo.

Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index b0e14a3d54ef..50651157203b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -101,11 +101,9 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 		drm_prime_gem_destroy(&bo->gem_base, bo->tbo.sg);
 	drm_gem_object_release(&bo->gem_base);
 	amdgpu_bo_unref(&bo->parent);
-	if (!list_empty(&bo->shadow_list)) {
-		mutex_lock(&adev->shadow_list_lock);
+	if (!list_empty(&bo->shadow_list))
 		list_del_init(&bo->shadow_list);
-		mutex_unlock(&adev->shadow_list_lock);
-	}
+
 	kfree(bo->metadata);
 	kfree(bo);
 }
@@ -838,13 +836,21 @@ struct amdgpu_bo *amdgpu_bo_ref(struct amdgpu_bo *bo)
 void amdgpu_bo_unref(struct amdgpu_bo **bo)
 {
 	struct ttm_buffer_object *tbo;
+	bool locked = false;
 
 	if ((*bo) == NULL)
 		return;
 
+	if (bo->parent && bo->parent->shadow == bo &&
+	    !list_empty(&bo->parent->shadow_list)) {
+		mutex_lock(&adev->shadow_list_lock);
+		locked = true;
+	}
 	tbo = &((*bo)->tbo);
 	ttm_bo_put(tbo);
 	*bo = NULL;
+	if (locked)
+		mutex_unlock(&adev->shadow_list_lock);
 }
 
 /**
-- 
2.17.1


--------------57E075D6EAC58DDAB6A86B59
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------57E075D6EAC58DDAB6A86B59--
