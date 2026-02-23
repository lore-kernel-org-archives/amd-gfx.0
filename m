Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CCFEA4FBA
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 14:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C6D10E450;
	Mon, 23 Feb 2026 14:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nx4B7mB+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA57810E450
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qE7hhenr7DQTVeQzL4oSdM3TgNEeGo2xDdKfHKGhDEI=; b=nx4B7mB+yNwgHzaeeN0r7M4UPG
 xeIlJi6r0/vF2ZsmcfifvmwKbbu8rbHok5Q88w8gEzhCRk67pPIh6z3zsdJukcCiJSwKZA7be0KFj
 GBwO4RLkRcpmQKdBoAPfHy8iDVbjqybR2/2trs/DS2If46lINPb8LEFTMcT3TLIyOrFZMgoNmrA1b
 G6A60FiGTQZcDuGYSq16sfGpPkNoxPipFjAzIl/15Gdm/3aO4ORDjnLyNBP9mdxQ2sSmXOllge34f
 xMTwonrKUEL703joK8e7GVSKICNfdjbxXlNJHxAC0iZtZNqfAVrfcYXSi7rqldc+IIoUeSZKNuzTC
 SSm1V9lQ==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vuWbA-004GDP-3s; Mon, 23 Feb 2026 15:07:44 +0100
Message-ID: <445d25ae-7c45-46ce-9de2-24c09711dfe8@igalia.com>
Date: Mon, 23 Feb 2026 14:07:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] drm/amdgpu/userq: Use drm_gem_objects_lookup in
 amdgpu_userq_wait_ioctl
To: "Khatri, Sunil" <sukhatri@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com
References: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
 <20260223124141.10641-6-tvrtko.ursulin@igalia.com>
 <0047be6b-9fd3-4424-8498-cb7aed30f38b@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <0047be6b-9fd3-4424-8498-cb7aed30f38b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 23/02/2026 13:58, Khatri, Sunil wrote:
> 
> On 23-02-2026 06:11 pm, Tvrtko Ursulin wrote:
>> Use the existing helper instead of open coding it
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 79 ++++++-------------
>>   1 file changed, 23 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/ 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index ee6f03f75b41..d779671bd0db 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -610,44 +610,29 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
>> *dev, void *data,
>>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>                   struct drm_file *filp)
>>   {
>> -    u32 *syncobj_handles, *timeline_points, *timeline_handles, 
>> *bo_handles_read, *bo_handles_write;
>> -    u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
>> -    struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>>       struct drm_amdgpu_userq_wait *wait_info = data;
>> +    const unsigned int num_write_bo_handles = wait_info- 
>> >num_bo_write_handles;
>> +    const unsigned int num_read_bo_handles = wait_info- 
>> >num_bo_read_handles;
>> +    struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>       struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>> +    struct drm_gem_object **gobj_write, **gobj_read;
>> +    u32 *timeline_points, *timeline_handles;
>>       struct amdgpu_usermode_queue *waitq;
>> -    struct drm_gem_object **gobj_write;
>> -    struct drm_gem_object **gobj_read;
>> +    u32 *syncobj_handles, num_syncobj;
>>       struct dma_fence **fences = NULL;
>>       u16 num_points, num_fences = 0;
>> -    int r, i, rentry, wentry, cnt;
>>       struct drm_exec exec;
>> +    int r, i, cnt;
>>       if (!amdgpu_userq_enabled(dev))
>>           return -ENOTSUPP;
>> -    num_read_bo_handles = wait_info->num_bo_read_handles;
>> -    bo_handles_read = memdup_user(u64_to_user_ptr(wait_info- 
>> >bo_read_handles),
>> -                      size_mul(sizeof(u32), num_read_bo_handles));
>> -    if (IS_ERR(bo_handles_read))
>> -        return PTR_ERR(bo_handles_read);
>> -
>> -    num_write_bo_handles = wait_info->num_bo_write_handles;
>> -    bo_handles_write = memdup_user(u64_to_user_ptr(wait_info- 
>> >bo_write_handles),
>> -                       size_mul(sizeof(u32), num_write_bo_handles));
>> -    if (IS_ERR(bo_handles_write)) {
>> -        r = PTR_ERR(bo_handles_write);
>> -        goto free_bo_handles_read;
>> -    }
>> -
>>       num_syncobj = wait_info->num_syncobj_handles;
>>       syncobj_handles = memdup_user(u64_to_user_ptr(wait_info- 
>> >syncobj_handles),
>>                         size_mul(sizeof(u32), num_syncobj));
>> -    if (IS_ERR(syncobj_handles)) {
>> -        r = PTR_ERR(syncobj_handles);
>> -        goto free_bo_handles_write;
>> -    }
>> +    if (IS_ERR(syncobj_handles))
>> +        return PTR_ERR(syncobj_handles);
>>       num_points = wait_info->num_syncobj_timeline_handles;
>>       timeline_handles = memdup_user(u64_to_user_ptr(wait_info- 
>> >syncobj_timeline_handles),
>> @@ -664,33 +649,19 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>> *dev, void *data,
>>           goto free_timeline_handles;
>>       }
>> -    gobj_read = kmalloc_array(num_read_bo_handles, 
>> sizeof(*gobj_read), GFP_KERNEL);
>> -    if (!gobj_read) {
>> -        r = -ENOMEM;
>> +    r = drm_gem_objects_lookup(filp,
>> +                   u64_to_user_ptr(wait_info->bo_read_handles),
>> +                   num_read_bo_handles,
>> +                   &gobj_read);
> 
> If i am not wrong even using the helper function will not avoid an OOM 
> situation in case num_read_bo_handles is a very big number? This is just 
> using the helper to reorganize the code but not having additonal 
> checks... and alos valid only on drm gem objects type...

Last part about only DRM GEM object type I did not understand. It is 
currently using drm_gem_object_lookup so that is the same.

Otherwise yes, although my understanding of the overall topic was you 
will apply the limits on top of the consolidation patches.

Regards,

Tvrtko

>> +    if (r)
>>           goto free_timeline_points;
>> -    }
>> -    for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
>> -        gobj_read[rentry] = drm_gem_object_lookup(filp, 
>> bo_handles_read[rentry]);
>> -        if (!gobj_read[rentry]) {
>> -            r = -ENOENT;
>> -            goto put_gobj_read;
>> -        }
>> -    }
>> -
>> -    gobj_write = kmalloc_array(num_write_bo_handles, 
>> sizeof(*gobj_write), GFP_KERNEL);
>> -    if (!gobj_write) {
>> -        r = -ENOMEM;
>> +    r = drm_gem_objects_lookup(filp,
>> +                   u64_to_user_ptr(wait_info->bo_write_handles),
>> +                   num_write_bo_handles,
>> +                   &gobj_write);
>> +    if (r)
>>           goto put_gobj_read;
>> -    }
>> -
>> -    for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
>> -        gobj_write[wentry] = drm_gem_object_lookup(filp, 
>> bo_handles_write[wentry]);
>> -        if (!gobj_write[wentry]) {
>> -            r = -ENOENT;
>> -            goto put_gobj_write;
>> -        }
>> -    }
>>       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>>                 (num_read_bo_handles + num_write_bo_handles));
>> @@ -947,12 +918,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>> *dev, void *data,
>>   exec_fini:
>>       drm_exec_fini(&exec);
>>   put_gobj_write:
>> -    while (wentry-- > 0)
>> -        drm_gem_object_put(gobj_write[wentry]);
>> +    for (i = 0; i < num_write_bo_handles; i++)
>> +        drm_gem_object_put(gobj_write[i]);
>>       kfree(gobj_write);
>>   put_gobj_read:
>> -    while (rentry-- > 0)
>> -        drm_gem_object_put(gobj_read[rentry]);
>> +    for (i = 0; i < num_read_bo_handles; i++)
>> +        drm_gem_object_put(gobj_read[i]);;
>>       kfree(gobj_read);
>>   free_timeline_points:
>>       kfree(timeline_points);
>> @@ -960,10 +931,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>> *dev, void *data,
>>       kfree(timeline_handles);
>>   free_syncobj_handles:
>>       kfree(syncobj_handles);
>> -free_bo_handles_write:
>> -    kfree(bo_handles_write);
>> -free_bo_handles_read:
>> -    kfree(bo_handles_read);
>>       return r;
>>   }

