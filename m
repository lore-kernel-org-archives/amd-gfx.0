Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D48C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 10:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8767613B2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 10:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8767613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9B66E48D;
	Tue, 22 Jun 2021 10:36:21 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98866E48D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 10:36:19 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id i24so12262557edx.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 03:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=yp7b4Qq5CWau/R+MnN++lK97OAIUST8rddS08dy61l0=;
 b=TeonWqYaNa6vuJJMsy0+2Cdki5RvNiZnA0c3zll7PUF81geubheMAk5HEwTk17f9VB
 UoOxFBGa02vHn3g9G1m9B9op/Xq4FKWF2b0mDRrHY98px4NfiYb9WY/eEvjJPmtRSYet
 XKF/ZAFH8HYKTCim+XyM/SXhPJb+C9qwYoxNF/+Vfwn6Zt0do3eCPw6XAb3JqauRWhSa
 tD6JvfLG1VTu77L6EmDtZCte61rBHeVTD6ne3aHf4eBQczO3MYXNMMNp0YWz68kitk90
 NV6YrKu1Zwg1tCBtY/9nxd2ttXBpHMDF5cEO5HM0F3cgVLXAB1LWoA1d85m5lQJ1CMrj
 V3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=yp7b4Qq5CWau/R+MnN++lK97OAIUST8rddS08dy61l0=;
 b=HWhlhEYVQI7y9ATA98Jzrw5jCJrUNpXiyYkciLZ1YdlTuAim7u28XwuECQySnI3jnE
 fNnsIFhfGhYezXd+ThCtBuGDw3rFZH6SRwC41z4n+GweBV64i2+CSAnc/L2D4R2GjpqQ
 UOflJhWbeIagkbaij69FAz75enpq8B8/tmICrssufS9ym+TnZ92LhL+TLOZTKPqTS0Vw
 6JKEdCODiSFHe9X+Efy6/PjOoaSAtSwnaSeK9c3uUSEqX4YMBlU9D4qqvk2GOXciH4Ry
 /Ju3My1y9XR0uStcJXADqfXT8c9UF+zx/IN6Tm9UvZXdamzZ2BsZgfGpSedq4n/P1x9i
 ZGNA==
X-Gm-Message-State: AOAM530snOCjZXx9IhVBGOVWJOLJvH32dDmrNLqqad9qElz9tvwLGPkF
 9dDXMU1oPtb2dOpbRrUPPQzWFxRrLjo=
X-Google-Smtp-Source: ABdhPJxibYaYlSkG97UMsT3//4TrkJdZDywaZzEjdBCKedcBcNlzcu+0tS3DPaCxpECme1MZ8wpUFg==
X-Received: by 2002:aa7:cc19:: with SMTP id q25mr3947792edt.56.1624358178427; 
 Tue, 22 Jun 2021 03:36:18 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4?
 ([2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4])
 by smtp.gmail.com with ESMTPSA id w10sm6672375edv.34.2021.06.22.03.36.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 03:36:17 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: add helper function for vm pasid
To: "Das, Nirmoy" <nirmoy.das@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210622065711.4589-1-nirmoy.das@amd.com>
 <e2a64dee-ca51-ab36-9255-8950e78c6190@amd.com>
 <5ad4ce29-2a7c-efc2-1541-4e204064f045@amd.com>
 <9ff705c2-a4e4-dc37-041a-66c490d8f7ad@gmail.com>
 <564b4de5-b1fd-283e-85b8-7819c24bca10@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c28d9c08-0ab8-780a-ae44-e444ae49500e@gmail.com>
Date: Tue, 22 Jun 2021 12:36:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <564b4de5-b1fd-283e-85b8-7819c24bca10@amd.com>
Content-Language: en-US
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Felix.Kuehling@amd.com
Content-Type: multipart/mixed; boundary="===============0273197455=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0273197455==
Content-Type: multipart/alternative;
 boundary="------------68C16E65E81FFA868BAA7D65"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------68C16E65E81FFA868BAA7D65
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.06.21 um 12:30 schrieb Das, Nirmoy:
>
> On 6/22/2021 10:36 AM, Christian König wrote:
>
>> Am 22.06.21 um 09:39 schrieb Das, Nirmoy:
>>>
>>> On 6/22/2021 9:03 AM, Christian König wrote:
>>>>
>>>>
>>>> Am 22.06.21 um 08:57 schrieb Nirmoy Das:
>>>>> Cleanup code related to vm pasid by adding helper functions.
>>>>>
>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 105 
>>>>> ++++++++++++-------------
>>>>>   1 file changed, 50 insertions(+), 55 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index 63975bda8e76..6e476b173cbb 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -87,6 +87,46 @@ struct amdgpu_prt_cb {
>>>>>       struct dma_fence_cb cb;
>>>>>   };
>>>>>
>>>>> +static int amdgpu_vm_pasid_alloc(struct amdgpu_device *adev,
>>>>> +                 struct amdgpu_vm *vm,
>>>>> +                 unsigned int pasid,
>>>>> +                 unsigned int *vm_pasid)
>>>>> +{
>>>>> +    unsigned long flags;
>>>>> +    int r;
>>>>> +
>>>>> +    if (!pasid)
>>>>> +        return 0;
>>>>> +
>>>>> + spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>> +    r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
>>>>> +              GFP_ATOMIC);
>>>>> + spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>> +    if (r < 0)
>>>>> +        return r;
>>>>> +    if (vm_pasid)
>>>>> +        *vm_pasid = pasid;
>>>>> +
>>>>
>>>> Ok the more I read from this patch the less it makes sense.
>>>>
>>>> We don't allocate the passid here, we just set it up in the idr.
>>>>
>>>> What we could do is to replace the idr with an xarray, that would 
>>>> certainly make more sense than this here.
>>>
>>>
>>> xarray looks great, with that we don't need pasid_lock either.
>>
>> You still need the lock to protect against VM destruction while 
>> looking things up, but you could switch to RCU for this instead.
>
>
> xarray has xa_{lock|unloack}_irqsave() and adev->vm_manager.pasid_xa 
> will exist till devices's lifetime.

That's just a wrapper around the lock.

> So I am thinking something like:
>
> amdgpu_vm_pasid_insert()
>
> {
>
> ...
>
> xa_lock_irqsave(adev->vm_manager.pasids, flags)
> r = xa_store(&adev->vm_manager.pasids, pasid, vm, GFP_ATOMIC);
> xa_unlock_irqsave(adev->vm_manager.pasids, flags)

It would be really nice if we could avoid the GFP_ATOMIC here, but not 
much of a problem since we had that before.

> }
>
> amdgpu_vm_pasid_remove()
>
> {
>
> ....
>
> xa_lock_irqsave(adev->vm_manager.pasids, flags)
> xa_erase(&adev->vm_manager.pasids, pasid);
> xa_unlock_irqsave(adev->vm_manager.pasids, flags)
>
> }
>
>
> xa_{lock|unloack}_irqsave() can be use while looking up vm ptr for a 
> pasid.
>
>
> Shouldn't this be enough ?
>

Yeah I think so.

Christian.

>
> Regards,
>
> Nirmoy
>
>>
>> Christian.
>>
>>>
>>>
>>> Thanks
>>>
>>> Nirmoy
>>>
>>>
>>>>
>>>> Christian.
>>>>
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static void amdgpu_vm_pasid_remove(struct amdgpu_device *adev,
>>>>> +                   unsigned int pasid,
>>>>> +                   unsigned int *vm_pasid)
>>>>> +{
>>>>> +    unsigned long flags;
>>>>> +
>>>>> +    if (!pasid)
>>>>> +        return;
>>>>> +
>>>>> + spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>> +    idr_remove(&adev->vm_manager.pasid_idr, pasid);
>>>>> + spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>> +
>>>>> +    if (vm_pasid)
>>>>> +        *vm_pasid = 0;
>>>>> +}
>>>>> +
>>>>>   /*
>>>>>    * vm eviction_lock can be taken in MMU notifiers. Make sure no 
>>>>> reclaim-FS
>>>>>    * happens while holding this lock anywhere to prevent deadlocks 
>>>>> when
>>>>> @@ -2940,18 +2980,8 @@ int amdgpu_vm_init(struct amdgpu_device 
>>>>> *adev, struct amdgpu_vm *vm, u32 pasid)
>>>>>
>>>>>       amdgpu_bo_unreserve(vm->root.bo);
>>>>>
>>>>> -    if (pasid) {
>>>>> -        unsigned long flags;
>>>>> -
>>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>> -        r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, 
>>>>> pasid + 1,
>>>>> -                  GFP_ATOMIC);
>>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>> -        if (r < 0)
>>>>> -            goto error_free_root;
>>>>> -
>>>>> -        vm->pasid = pasid;
>>>>> -    }
>>>>> +    if (amdgpu_vm_pasid_alloc(adev, vm, pasid, &vm->pasid))
>>>>> +        goto error_free_root;
>>>>>
>>>>>       INIT_KFIFO(vm->faults);
>>>>>
>>>>> @@ -3038,19 +3068,11 @@ int amdgpu_vm_make_compute(struct 
>>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>>       r = amdgpu_vm_check_clean_reserved(adev, vm);
>>>>>       if (r)
>>>>>           goto unreserve_bo;
>>>>> +    r = amdgpu_vm_pasid_alloc(adev, vm, pasid, NULL);
>>>>> +    if (r ==  -ENOSPC)
>>>>> +        goto unreserve_bo;
>>>>>
>>>>> -    if (pasid) {
>>>>> -        unsigned long flags;
>>>>> -
>>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>> -        r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, 
>>>>> pasid + 1,
>>>>> -                  GFP_ATOMIC);
>>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>> -
>>>>> -        if (r == -ENOSPC)
>>>>> -            goto unreserve_bo;
>>>>> -        r = 0;
>>>>> -    }
>>>>> +    r = 0;
>>>>>
>>>>>       /* Check if PD needs to be reinitialized and do it before
>>>>>        * changing any other state, in case it fails.
>>>>> @@ -3089,35 +3111,23 @@ int amdgpu_vm_make_compute(struct 
>>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>>       vm->is_compute_context = true;
>>>>>
>>>>>       if (vm->pasid) {
>>>>> -        unsigned long flags;
>>>>> -
>>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>> -        idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
>>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>> -
>>>>>           /* Free the original amdgpu allocated pasid
>>>>>            * Will be replaced with kfd allocated pasid
>>>>>            */
>>>>>           amdgpu_pasid_free(vm->pasid);
>>>>> -        vm->pasid = 0;
>>>>> +        amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>>>>>       }
>>>>>
>>>>>       /* Free the shadow bo for compute VM */
>>>>> amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
>>>>> -
>>>>>       if (pasid)
>>>>>           vm->pasid = pasid;
>>>>>
>>>>>       goto unreserve_bo;
>>>>>
>>>>>   free_idr:
>>>>> -    if (pasid) {
>>>>> -        unsigned long flags;
>>>>> +    amdgpu_vm_pasid_remove(adev, pasid, NULL);
>>>>>
>>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>> -        idr_remove(&adev->vm_manager.pasid_idr, pasid);
>>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>> -    }
>>>>>   unreserve_bo:
>>>>>       amdgpu_bo_unreserve(vm->root.bo);
>>>>>       return r;
>>>>> @@ -3133,14 +3143,7 @@ int amdgpu_vm_make_compute(struct 
>>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>>    */
>>>>>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, 
>>>>> struct amdgpu_vm *vm)
>>>>>   {
>>>>> -    if (vm->pasid) {
>>>>> -        unsigned long flags;
>>>>> -
>>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>> -        idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
>>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>> -    }
>>>>> -    vm->pasid = 0;
>>>>> +    amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>>>>>       vm->is_compute_context = false;
>>>>>   }
>>>>>
>>>>> @@ -3164,15 +3167,7 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>>>> *adev, struct amdgpu_vm *vm)
>>>>>
>>>>>       root = amdgpu_bo_ref(vm->root.bo);
>>>>>       amdgpu_bo_reserve(root, true);
>>>>> -    if (vm->pasid) {
>>>>> -        unsigned long flags;
>>>>> -
>>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>> -        idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
>>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>> -        vm->pasid = 0;
>>>>> -    }
>>>>> -
>>>>> +    amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>>>>>       dma_fence_wait(vm->last_unlocked, false);
>>>>>       dma_fence_put(vm->last_unlocked);
>>>>>
>>>>> -- 
>>>>> 2.32.0
>>>>>
>>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C3285a973b5a4498f3b0608d93558d909%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637599478002028860%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=QLv4hbUpPF9H%2BVL4eOQlTeROWQA%2FG1LrPGFBzCQRt7o%3D&amp;reserved=0 
>>>
>>


--------------68C16E65E81FFA868BAA7D65
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 22.06.21 um 12:30 schrieb Das, Nirmoy:<br>
    <blockquote type="cite"
      cite="mid:564b4de5-b1fd-283e-85b8-7819c24bca10@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>On 6/22/2021 10:36 AM, Christian König wrote:<br>
      </p>
      <blockquote type="cite"
        cite="mid:9ff705c2-a4e4-dc37-041a-66c490d8f7ad@gmail.com">Am
        22.06.21 um 09:39 schrieb Das, Nirmoy: <br>
        <blockquote type="cite"> <br>
          On 6/22/2021 9:03 AM, Christian König wrote: <br>
          <blockquote type="cite"> <br>
            <br>
            Am 22.06.21 um 08:57 schrieb Nirmoy Das: <br>
            <blockquote type="cite">Cleanup code related to vm pasid by
              adding helper functions. <br>
              <br>
              Signed-off-by: Nirmoy Das <a
                class="moz-txt-link-rfc2396E"
                href="mailto:nirmoy.das@amd.com" moz-do-not-send="true">&lt;nirmoy.das@amd.com&gt;</a>
              <br>
              --- <br>
                drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 105
              ++++++++++++------------- <br>
                1 file changed, 50 insertions(+), 55 deletions(-) <br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
              index 63975bda8e76..6e476b173cbb 100644 <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
              @@ -87,6 +87,46 @@ struct amdgpu_prt_cb { <br>
                    struct dma_fence_cb cb; <br>
                }; <br>
              <br>
              +static int amdgpu_vm_pasid_alloc(struct amdgpu_device
              *adev, <br>
              +                 struct amdgpu_vm *vm, <br>
              +                 unsigned int pasid, <br>
              +                 unsigned int *vm_pasid) <br>
              +{ <br>
              +    unsigned long flags; <br>
              +    int r; <br>
              + <br>
              +    if (!pasid) <br>
              +        return 0; <br>
              + <br>
              +   
              spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              +    r = idr_alloc(&amp;adev-&gt;vm_manager.pasid_idr, vm,
              pasid, pasid + 1, <br>
              +              GFP_ATOMIC); <br>
              +
              spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              +    if (r &lt; 0) <br>
              +        return r; <br>
              +    if (vm_pasid) <br>
              +        *vm_pasid = pasid; <br>
              + <br>
            </blockquote>
            <br>
            Ok the more I read from this patch the less it makes sense.
            <br>
            <br>
            We don't allocate the passid here, we just set it up in the
            idr. <br>
            <br>
            What we could do is to replace the idr with an xarray, that
            would certainly make more sense than this here. <br>
          </blockquote>
          <br>
          <br>
          xarray looks great, with that we don't need pasid_lock either.
          <br>
        </blockquote>
        <br>
        You still need the lock to protect against VM destruction while
        looking things up, but you could switch to RCU for this instead.
        <br>
      </blockquote>
      <p><br>
      </p>
      <font face="Helvetica, Arial, sans-serif">xarray has <span
          style="color: rgb(0, 0, 0); font-size: 16px; font-style:
          normal; font-variant-ligatures: normal; font-variant-caps:
          normal; font-weight: 400; letter-spacing: normal; text-align:
          start; text-indent: 0px; text-transform: none; white-space:
          normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;">xa_{lock|unloack}_irqsave() and </span><span
          style="color: rgb(0, 0, 0); font-size: 16px; font-style:
          normal; font-variant-ligatures: normal; font-variant-caps:
          normal; font-weight: 400; letter-spacing: normal; text-align:
          start; text-indent: 0px; text-transform: none; white-space:
          normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;">adev-&gt;vm_manager.pasid_xa will
          exist till devices's lifetime.</span></font></blockquote>
    <br>
    That's just a wrapper around the lock.<br>
    <br>
    <blockquote type="cite"
      cite="mid:564b4de5-b1fd-283e-85b8-7819c24bca10@amd.com"><font
        face="Helvetica, Arial, sans-serif"><span style="color: rgb(0,
          0, 0); font-size: 16px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; text-align: start;
          text-indent: 0px; text-transform: none; white-space: normal;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;">So I am thinking something like:<br>
        </span><br>
      </font>
      <p><font face="Helvetica, Arial, sans-serif">amdgpu_vm_pasid_insert()
          <br>
        </font></p>
      <p><font face="Helvetica, Arial, sans-serif">{</font></p>
      <p><font face="Helvetica, Arial, sans-serif">...<br>
        </font></p>
      <font face="Helvetica, Arial, sans-serif"><span style="color:
          rgb(0, 0, 0); font-size: 16px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; text-align: start;
          text-indent: 0px; text-transform: none; white-space: normal;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"> <span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;">xa_lock_irqsave(</span></span><span
          style="color: rgb(0, 0, 0); font-size: 16px; font-style:
          normal; font-variant-ligatures: normal; font-variant-caps:
          normal; font-weight: 400; letter-spacing: normal; text-align:
          start; text-indent: 0px; text-transform: none; white-space:
          normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"><span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;">adev-&gt;vm_manager.pasids,
            flags)</span></span><br>
        <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
          normal; font-variant-ligatures: normal; font-variant-caps:
          normal; font-weight: 400; letter-spacing: normal; text-align:
          start; text-indent: 0px; text-transform: none; white-space:
          normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"><span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;">r =
            xa_store(&amp;adev-&gt;vm_manager.pasids, pasid, vm,
            GFP_ATOMIC);</span></span><br>
        <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
          normal; font-variant-ligatures: normal; font-variant-caps:
          normal; font-weight: 400; letter-spacing: normal; text-align:
          start; text-indent: 0px; text-transform: none; white-space:
          normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"><span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span
              style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"> <span
                style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"></span></span></span></span><span
          style="color: rgb(0, 0, 0); font-size: 16px; font-style:
          normal; font-variant-ligatures: normal; font-variant-caps:
          normal; font-weight: 400; letter-spacing: normal; text-align:
          start; text-indent: 0px; text-transform: none; white-space:
          normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"><span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span
              style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span
                style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;">xa_unlock_irqsave(</span></span><span
              style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span
                style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;">adev-&gt;vm_manager.pasids,
                flags)</span></span></span></span></font></blockquote>
    <br>
    It would be really nice if we could avoid the GFP_ATOMIC here, but
    not much of a problem since we had that before.<br>
    <br>
    <blockquote type="cite"
      cite="mid:564b4de5-b1fd-283e-85b8-7819c24bca10@amd.com">
      <p><font face="Helvetica, Arial, sans-serif"><span style="color:
            rgb(0, 0, 0); font-size: 16px; font-style: normal;
            font-variant-ligatures: normal; font-variant-caps: normal;
            font-weight: 400; letter-spacing: normal; text-align: start;
            text-indent: 0px; text-transform: none; white-space: normal;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;
            background-color: rgb(252, 252, 252);
            text-decoration-thickness: initial; text-decoration-style:
            initial; text-decoration-color: initial; display: inline
            !important; float: none;"></span>}</font></p>
      <p><font face="Helvetica, Arial, sans-serif"><span style="color:
            rgb(0, 0, 0); font-size: 16px; font-style: normal;
            font-variant-ligatures: normal; font-variant-caps: normal;
            font-weight: 400; letter-spacing: normal; text-align: start;
            text-indent: 0px; text-transform: none; white-space: normal;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;
            background-color: rgb(252, 252, 252);
            text-decoration-thickness: initial; text-decoration-style:
            initial; text-decoration-color: initial; display: inline
            !important; float: none;"><span style="color: rgb(0, 0, 0);
              font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span
                style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;">amdgpu_vm_pasid_remove()</span></span></span></font></p>
      <p><font face="Helvetica, Arial, sans-serif"><span style="color:
            rgb(0, 0, 0); font-size: 16px; font-style: normal;
            font-variant-ligatures: normal; font-variant-caps: normal;
            font-weight: 400; letter-spacing: normal; text-align: start;
            text-indent: 0px; text-transform: none; white-space: normal;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;
            background-color: rgb(252, 252, 252);
            text-decoration-thickness: initial; text-decoration-style:
            initial; text-decoration-color: initial; display: inline
            !important; float: none;"><span style="color: rgb(0, 0, 0);
              font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span
                style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;">{</span></span></span></font></p>
      <p><font face="Helvetica, Arial, sans-serif"><span style="color:
            rgb(0, 0, 0); font-size: 16px; font-style: normal;
            font-variant-ligatures: normal; font-variant-caps: normal;
            font-weight: 400; letter-spacing: normal; text-align: start;
            text-indent: 0px; text-transform: none; white-space: normal;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;
            background-color: rgb(252, 252, 252);
            text-decoration-thickness: initial; text-decoration-style:
            initial; text-decoration-color: initial; display: inline
            !important; float: none;"><span style="color: rgb(0, 0, 0);
              font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span
                style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;">....<br>
              </span></span></span></font></p>
      <p><font face="Helvetica, Arial, sans-serif"><span style="color:
            rgb(0, 0, 0); font-size: 16px; font-style: normal;
            font-variant-ligatures: normal; font-variant-caps: normal;
            font-weight: 400; letter-spacing: normal; text-align: start;
            text-indent: 0px; text-transform: none; white-space: normal;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;
            background-color: rgb(252, 252, 252);
            text-decoration-thickness: initial; text-decoration-style:
            initial; text-decoration-color: initial; display: inline
            !important; float: none;"><span style="color: rgb(0, 0, 0);
              font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span
                style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;">xa_lock_irqsave(</span></span><span
              style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span
                style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;">adev-&gt;vm_manager.pasids,
                flags)</span></span><br>
            <span style="color: rgb(0, 0, 0); font-size: 16px;
              font-style: normal; font-variant-ligatures: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              background-color: rgb(252, 252, 252);
              text-decoration-thickness: initial; text-decoration-style:
              initial; text-decoration-color: initial; display: inline
              !important; float: none;"><span style="color: rgb(0, 0,
                0); font-size: 16px; font-style: normal;
                font-variant-ligatures: normal; font-variant-caps:
                normal; font-weight: 400; letter-spacing: normal;
                text-align: start; text-indent: 0px; text-transform:
                none; white-space: normal; word-spacing: 0px;
                -webkit-text-stroke-width: 0px; background-color:
                rgb(252, 252, 252); text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;">xa_erase(&amp;adev-&gt;vm_manager.pasids,
                pasid);</span></span><br>
            <span style="color: rgb(0, 0, 0); font-size: 16px;
              font-style: normal; font-variant-ligatures: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              background-color: rgb(252, 252, 252);
              text-decoration-thickness: initial; text-decoration-style:
              initial; text-decoration-color: initial; display: inline
              !important; float: none;"><span style="color: rgb(0, 0,
                0); font-size: 16px; font-style: normal;
                font-variant-ligatures: normal; font-variant-caps:
                normal; font-weight: 400; letter-spacing: normal;
                text-align: start; text-indent: 0px; text-transform:
                none; white-space: normal; word-spacing: 0px;
                -webkit-text-stroke-width: 0px; background-color:
                rgb(252, 252, 252); text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span
                  style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;"> <span
                    style="color: rgb(0, 0, 0); font-size: 16px;
                    font-style: normal; font-variant-ligatures: normal;
                    font-variant-caps: normal; font-weight: 400;
                    letter-spacing: normal; text-align: start;
                    text-indent: 0px; text-transform: none; white-space:
                    normal; word-spacing: 0px;
                    -webkit-text-stroke-width: 0px; background-color:
                    rgb(252, 252, 252); text-decoration-thickness:
                    initial; text-decoration-style: initial;
                    text-decoration-color: initial; display: inline
                    !important; float: none;"></span></span></span></span><span
              style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span
                style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span
                  style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;"><span
                    style="color: rgb(0, 0, 0); font-size: 16px;
                    font-style: normal; font-variant-ligatures: normal;
                    font-variant-caps: normal; font-weight: 400;
                    letter-spacing: normal; text-align: start;
                    text-indent: 0px; text-transform: none; white-space:
                    normal; word-spacing: 0px;
                    -webkit-text-stroke-width: 0px; background-color:
                    rgb(252, 252, 252); text-decoration-thickness:
                    initial; text-decoration-style: initial;
                    text-decoration-color: initial; display: inline
                    !important; float: none;">xa_unlock_irqsave(</span></span><span
                  style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;"><span
                    style="color: rgb(0, 0, 0); font-size: 16px;
                    font-style: normal; font-variant-ligatures: normal;
                    font-variant-caps: normal; font-weight: 400;
                    letter-spacing: normal; text-align: start;
                    text-indent: 0px; text-transform: none; white-space:
                    normal; word-spacing: 0px;
                    -webkit-text-stroke-width: 0px; background-color:
                    rgb(252, 252, 252); text-decoration-thickness:
                    initial; text-decoration-style: initial;
                    text-decoration-color: initial; display: inline
                    !important; float: none;">adev-&gt;vm_manager.pasids,
                    flags)</span></span></span></span> </span></font></p>
      <p><font face="Helvetica, Arial, sans-serif"><span style="color:
            rgb(0, 0, 0); font-size: 16px; font-style: normal;
            font-variant-ligatures: normal; font-variant-caps: normal;
            font-weight: 400; letter-spacing: normal; text-align: start;
            text-indent: 0px; text-transform: none; white-space: normal;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;
            background-color: rgb(252, 252, 252);
            text-decoration-thickness: initial; text-decoration-style:
            initial; text-decoration-color: initial; display: inline
            !important; float: none;">}</span></font></p>
      <p><font face="Helvetica, Arial, sans-serif"><br>
          <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
            normal; font-variant-ligatures: normal; font-variant-caps:
            normal; font-weight: 400; letter-spacing: normal;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(252,
            252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"> <span
              style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">xa_{lock|unloack}_irqsave()
              can be use while looking up vm ptr for a pasid.</span></span></font></p>
      <p><font face="Helvetica, Arial, sans-serif"><span style="color:
            rgb(0, 0, 0); font-size: 16px; font-style: normal;
            font-variant-ligatures: normal; font-variant-caps: normal;
            font-weight: 400; letter-spacing: normal; text-align: start;
            text-indent: 0px; text-transform: none; white-space: normal;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;
            background-color: rgb(252, 252, 252);
            text-decoration-thickness: initial; text-decoration-style:
            initial; text-decoration-color: initial; display: inline
            !important; float: none;"><span style="color: rgb(0, 0, 0);
              font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><br>
            </span> </span></font></p>
      <font face="Helvetica, Arial, sans-serif"> </font>
      <p><font face="Helvetica, Arial, sans-serif">Shouldn't this be
          enough ?</font></p>
    </blockquote>
    <br>
    Yeah I think so.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:564b4de5-b1fd-283e-85b8-7819c24bca10@amd.com">
      <p><font face="Helvetica, Arial, sans-serif"><br>
        </font></p>
      <p><font face="Helvetica, Arial, sans-serif">Regards,</font></p>
      <p><font face="Helvetica, Arial, sans-serif">Nirmoy</font><br>
      </p>
      <blockquote type="cite"
        cite="mid:9ff705c2-a4e4-dc37-041a-66c490d8f7ad@gmail.com"> <br>
        Christian. <br>
        <br>
        <blockquote type="cite"> <br>
          <br>
          Thanks <br>
          <br>
          Nirmoy <br>
          <br>
          <br>
          <blockquote type="cite"> <br>
            Christian. <br>
            <br>
            <blockquote type="cite">+    return 0; <br>
              +} <br>
              + <br>
              +static void amdgpu_vm_pasid_remove(struct amdgpu_device
              *adev, <br>
              +                   unsigned int pasid, <br>
              +                   unsigned int *vm_pasid) <br>
              +{ <br>
              +    unsigned long flags; <br>
              + <br>
              +    if (!pasid) <br>
              +        return; <br>
              + <br>
              +   
              spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              +    idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
              pasid); <br>
              +
              spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              + <br>
              +    if (vm_pasid) <br>
              +        *vm_pasid = 0; <br>
              +} <br>
              + <br>
                /* <br>
                 * vm eviction_lock can be taken in MMU notifiers. Make
              sure no reclaim-FS <br>
                 * happens while holding this lock anywhere to prevent
              deadlocks when <br>
              @@ -2940,18 +2980,8 @@ int amdgpu_vm_init(struct
              amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid) <br>
              <br>
                    amdgpu_bo_unreserve(vm-&gt;root.bo); <br>
              <br>
              -    if (pasid) { <br>
              -        unsigned long flags; <br>
              - <br>
              - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              -        r = idr_alloc(&amp;adev-&gt;vm_manager.pasid_idr,
              vm, pasid, pasid + 1, <br>
              -                  GFP_ATOMIC); <br>
              -
              spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              -        if (r &lt; 0) <br>
              -            goto error_free_root; <br>
              - <br>
              -        vm-&gt;pasid = pasid; <br>
              -    } <br>
              +    if (amdgpu_vm_pasid_alloc(adev, vm, pasid,
              &amp;vm-&gt;pasid)) <br>
              +        goto error_free_root; <br>
              <br>
                    INIT_KFIFO(vm-&gt;faults); <br>
              <br>
              @@ -3038,19 +3068,11 @@ int amdgpu_vm_make_compute(struct
              amdgpu_device *adev, struct amdgpu_vm *vm, <br>
                    r = amdgpu_vm_check_clean_reserved(adev, vm); <br>
                    if (r) <br>
                        goto unreserve_bo; <br>
              +    r = amdgpu_vm_pasid_alloc(adev, vm, pasid, NULL); <br>
              +    if (r ==  -ENOSPC) <br>
              +        goto unreserve_bo; <br>
              <br>
              -    if (pasid) { <br>
              -        unsigned long flags; <br>
              - <br>
              - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              -        r = idr_alloc(&amp;adev-&gt;vm_manager.pasid_idr,
              vm, pasid, pasid + 1, <br>
              -                  GFP_ATOMIC); <br>
              -
              spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              - <br>
              -        if (r == -ENOSPC) <br>
              -            goto unreserve_bo; <br>
              -        r = 0; <br>
              -    } <br>
              +    r = 0; <br>
              <br>
                    /* Check if PD needs to be reinitialized and do it
              before <br>
                     * changing any other state, in case it fails. <br>
              @@ -3089,35 +3111,23 @@ int amdgpu_vm_make_compute(struct
              amdgpu_device *adev, struct amdgpu_vm *vm, <br>
                    vm-&gt;is_compute_context = true; <br>
              <br>
                    if (vm-&gt;pasid) { <br>
              -        unsigned long flags; <br>
              - <br>
              - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              -        idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
              vm-&gt;pasid); <br>
              -
              spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              - <br>
                        /* Free the original amdgpu allocated pasid <br>
                         * Will be replaced with kfd allocated pasid <br>
                         */ <br>
                        amdgpu_pasid_free(vm-&gt;pasid); <br>
              -        vm-&gt;pasid = 0; <br>
              +        amdgpu_vm_pasid_remove(adev, vm-&gt;pasid,
              &amp;vm-&gt;pasid); <br>
                    } <br>
              <br>
                    /* Free the shadow bo for compute VM */ <br>
amdgpu_bo_unref(&amp;to_amdgpu_bo_vm(vm-&gt;root.bo)-&gt;shadow); <br>
              - <br>
                    if (pasid) <br>
                        vm-&gt;pasid = pasid; <br>
              <br>
                    goto unreserve_bo; <br>
              <br>
                free_idr: <br>
              -    if (pasid) { <br>
              -        unsigned long flags; <br>
              +    amdgpu_vm_pasid_remove(adev, pasid, NULL); <br>
              <br>
              - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              -        idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
              pasid); <br>
              -
              spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              -    } <br>
                unreserve_bo: <br>
                    amdgpu_bo_unreserve(vm-&gt;root.bo); <br>
                    return r; <br>
              @@ -3133,14 +3143,7 @@ int amdgpu_vm_make_compute(struct
              amdgpu_device *adev, struct amdgpu_vm *vm, <br>
                 */ <br>
                void amdgpu_vm_release_compute(struct amdgpu_device
              *adev, struct amdgpu_vm *vm) <br>
                { <br>
              -    if (vm-&gt;pasid) { <br>
              -        unsigned long flags; <br>
              - <br>
              - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              -        idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
              vm-&gt;pasid); <br>
              -
              spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              -    } <br>
              -    vm-&gt;pasid = 0; <br>
              +    amdgpu_vm_pasid_remove(adev, vm-&gt;pasid,
              &amp;vm-&gt;pasid); <br>
                    vm-&gt;is_compute_context = false; <br>
                } <br>
              <br>
              @@ -3164,15 +3167,7 @@ void amdgpu_vm_fini(struct
              amdgpu_device *adev, struct amdgpu_vm *vm) <br>
              <br>
                    root = amdgpu_bo_ref(vm-&gt;root.bo); <br>
                    amdgpu_bo_reserve(root, true); <br>
              -    if (vm-&gt;pasid) { <br>
              -        unsigned long flags; <br>
              - <br>
              - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              -        idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
              vm-&gt;pasid); <br>
              -
              spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
              flags); <br>
              -        vm-&gt;pasid = 0; <br>
              -    } <br>
              - <br>
              +    amdgpu_vm_pasid_remove(adev, vm-&gt;pasid,
              &amp;vm-&gt;pasid); <br>
                    dma_fence_wait(vm-&gt;last_unlocked, false); <br>
                    dma_fence_put(vm-&gt;last_unlocked); <br>
              <br>
              -- <br>
              2.32.0 <br>
              <br>
            </blockquote>
            <br>
          </blockquote>
          _______________________________________________ <br>
          amd-gfx mailing list <br>
          <a class="moz-txt-link-abbreviated"
            href="mailto:amd-gfx@lists.freedesktop.org"
            moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a> <br>
          <a class="moz-txt-link-freetext"
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C3285a973b5a4498f3b0608d93558d909%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637599478002028860%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=QLv4hbUpPF9H%2BVL4eOQlTeROWQA%2FG1LrPGFBzCQRt7o%3D&amp;amp;reserved=0"
            moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C3285a973b5a4498f3b0608d93558d909%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637599478002028860%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=QLv4hbUpPF9H%2BVL4eOQlTeROWQA%2FG1LrPGFBzCQRt7o%3D&amp;amp;reserved=0</a>
          <br>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------68C16E65E81FFA868BAA7D65--

--===============0273197455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0273197455==--
