Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5780FF506E0
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 14:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D70A210E58C;
	Mon, 16 Mar 2026 14:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="qMl7B0i+";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2737C10E563
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 14:44:47 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso40973395e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773672286; x=1774277086; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gXIwryu33kOi73YgBuLATX0TId7R8g7XyTL01mqIsiw=;
 b=qMl7B0i+Pg5jjpZM1IGKEb5UNmZ00qlVlUaGscWSkjb/T8o1a0mVMWgnZ84RvvuqFA
 R0VgC0vcz3xPoHbvVa0waOqk7dQWUK09VlUewQpSph2wMR2t0PVPYIbbY4aIJP7M4oCN
 GFLsCAHG/4l1xjD8q140DuDs1UC5PmttHGocC2KfSgdKETLKbXZRpy3n0dHJj9UNrCy3
 /ZbhlU+lci34Gb9nylwMGvbzKvRdZVizm0IdtCgmYJBRgFOKs7pA8dHOUVvCbCLiF68j
 zkU7/wUiVey0flkZCNXmkzMJpozDEBJ2d6pKK/jRUlNPWQAzsF6xUVC+nu9KMY49Zg3U
 ZJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773672286; x=1774277086;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gXIwryu33kOi73YgBuLATX0TId7R8g7XyTL01mqIsiw=;
 b=nGD656mR0+Boz3LmTMrC7PSUDCYDXSQkvmOT33G5i6Ws9KO+GuEnNxGdZI0TIVrFt8
 HqBaT+TMbfwwQC3mY7kIKd27xaAA9A84Mfblubv8Be+aLEw/TwgP+gNzCSSgY/ufL8dn
 KDPhn79WnqCEO2mpEIwtfTPzK6cuwYcsdiL8QhQ7Yy4+EUCF8MgFlq5IZAJLxzBbc919
 3Y2+pvcSQ3n5XAttN+aLEGsEcNEs95sxOqhwYxrCPvlPH4wOncL+E8TSsMo7pK8FIAQZ
 d6FzWs0XGdm/FNSPLHwL7hgmiQhxV0/DbU1jErAoTGCldCSsFjWrNR/CpPBNqY1MVzor
 gr8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6xmMl6zhHkm4PXn4THYaC/v5s3Auf1IuFo8lN/YJ5kvj3SRjtQIExXRYV5HtmNQFCpyVXb3mM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbAF0RPnSZ67eeFIfMqMkqUFgPuy6eA0s9Nrt/JbWonB+aWnvR
 WqRpgsF5utCUsY7QS2Cb2KKiZbyWvD7/pKWptgn9s41wrS84tI8iO+Kfcd6Q0B3DUos=
X-Gm-Gg: ATEYQzwRpQbFxgNJBAbCQeKgqN4Ll/S7A0CaOvkjbcRdyAX6c2KvBs51ScTs0W87OhR
 QsRLvIYZL1CUsx18xCdBf4lvC20Pu5RR0SicDB0gy0zF3lEf3FmlVrpp7xlv216KRSPj2QMaXmf
 gsfG7O1Gtav6wsPhOgKQTbZfZ2esRyS96vRC7VxahqamtoGJ6sA0CchkL+CznXYVY8rYLfrmQC6
 6SLdlTcIdK5fE3KZzicl7u7JCcJaZUC2yjVPEBsVCVMbjpgs1YOQzR5ViKm9Bl8WypZKDBDOgaB
 3Fft9lL87409ik/O1uK8ml2gBfNIKbuklEiB2NoDvsGjthWnzpG2Ug8bwotzBeu2tnxt5hHORnB
 l6TV9OYjy6pxGmiHgRPx3eGEBUqgdPfqvY9DAQHgXekUgX/AU3ixzoHioYctj+++mo/XU9mVKID
 Dhf8GcrPySfeRaAFfY79IWgy3xZ0CXOJyG1YKs0gAjnOE+8/SDA04Lr0w=
X-Received: by 2002:a05:600c:81c5:b0:485:3812:36da with SMTP id
 5b1f17b1804b1-485566cf00bmr201839815e9.9.1773672285235; 
 Mon, 16 Mar 2026 07:44:45 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485563903bbsm157389745e9.0.2026.03.16.07.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 07:44:44 -0700 (PDT)
Message-ID: <b0caa143-06fc-4495-8a16-bf47d4d36be9@ursulin.net>
Date: Mon, 16 Mar 2026 14:44:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/amdgpu: rework amdgpu_userq_wait_ioctl v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-7-christian.koenig@amd.com>
 <4f60cc9f-b4df-480c-9914-fa0c7f8d224c@ursulin.net>
 <649ffc71-0d29-48c0-b621-38da72a041a3@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <649ffc71-0d29-48c0-b621-38da72a041a3@amd.com>
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


On 16/03/2026 14:19, Christian König wrote:
> On 3/12/26 17:34, Tvrtko Ursulin wrote:
>>> +    /* Retrieve timeline fences */
>>> +    num_points = wait_info->num_syncobj_timeline_handles;
>>> +    for (i = 0; i < num_points; i++) {
>>> +        r = drm_syncobj_find_fence(filp, timeline_handles[i],
>>> +                       timeline_points[i],
>>> +                       DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
>>> +                       &fence);
>>> +        if (r)
>>> +            goto free_fences;
>>> +
>>> +        dma_fence_unwrap_for_each(f, &iter, fence) {
>>> +            if (num_fences >= wait_info->num_fences) {
>>> +                r = -EINVAL;
>>
>> dma_fence_put(fence);
> 
> Fixed.
> 
>>
>> Also, maybe -EAGAIN?
>>
>> Or even consider dma_fence_dedup_array() and only bail out if it couldn't compact it.
> 
> I've replaced the error with a fallback in the next patch anyway.

dma_fence_wait right, yeah I guess that de-dupes in a way as well.

>>
>>> +                goto free_fences;
>>> +            }
>>>    -        /* Array of fences */
>>> -        fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
>>> -        if (!fences) {
>>> -            r = -ENOMEM;
>>> -            goto free_fence_info;
>>> +            fences[num_fences++] = dma_fence_get(f);
>>>            }
>>>    -        /* Retrieve GEM read objects fence */
>>> -        for (i = 0; i < num_read_bo_handles; i++) {
>>> -            struct dma_resv_iter resv_cursor;
>>> -            struct dma_fence *fence;
>>> +        dma_fence_put(fence);
>>> +    }
>>> +
>>> +    /* Retrieve boolean fences */
>>> +    num_syncobj = wait_info->num_syncobj_handles;
>>> +    for (i = 0; i < num_syncobj; i++) {
>>> +        struct dma_fence *fence;
>>>    -            dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
>>> -                        DMA_RESV_USAGE_READ, fence) {
>>> -                if (num_fences >= wait_info->num_fences) {
>>> -                    r = -EINVAL;
>>
>> Same as above.
> 
> Those doesn't hold an extra reference, so dma_fence_put would underflow the refcount.

Ack. I probably misread the diff.

> 
>>> +        if (!userq_fence) {
>>>                /*
>>> -             * We need to make sure the user queue release their reference
>>> -             * to the fence drivers at some point before queue destruction.
>>> -             * Otherwise, we would gather those references until we don't
>>> -             * have any more space left and crash.
>>> +             * Just waiting on other driver fences should
>>> +             * be good for now
>>>                 */
>>> -            r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>>> -                     xa_limit_32b, GFP_KERNEL);
>>
>> Does it need to put potentially the same fence_drv multiple times into the same xarray?
> 
> That would be quite unlikely. We have one fence_drv for each fence context and de-duplicate them above.
> 
> It could only happen if you call the wait_ioctl multiple times, but I don't see an use case for that.

Right, my question is will the driver cope if userspace does that is the 
question?

And secondary is the whole purpose of this xarray just to know how many 
fence driver references the queue needs to drop at teardown time (given 
index is not used at all, not for lookup, not for anything):

static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
{
	struct amdgpu_userq_fence_driver *fence_drv;
	unsigned long index;

	if (xa_empty(xa))
		return;

	xa_lock(xa);
	xa_for_each(xa, index, fence_drv) {
		__xa_erase(xa, index);
		amdgpu_userq_fence_driver_put(fence_drv);
	}

	xa_unlock(xa);
}

It also reminds me of a patch I sent some time ago:

drm/amdgpu/userq: Stop looking after finding ourselves

When amdgpu_userq_fence_driver_destroy walks the xarray of registered
fence drivers in order to remove itself from it, it can stop iterating
once it has found itself.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 69451d0acbbe..1328fd87c10e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -202,8 +202,10 @@ void amdgpu_userq_fence_driver_destroy(struct kref 
*ref)

  	xa_lock_irqsave(xa, flags);
  	xa_for_each(xa, index, xa_fence_drv)
-		if (xa_fence_drv == fence_drv)
+		if (xa_fence_drv == fence_drv) {
  			__xa_erase(xa, index);
+			break;
+		}
  	xa_unlock_irqrestore(xa, flags);

  	/* Free seq64 memory */

Although I do not guarantee it is correct. :)

Regards,

Tvrtko

>>
>>> +            r = dma_fence_wait(fences[i], true);
>>>                if (r)
>>> -                goto free_fences;
>>> +                goto put_waitq;
>>> +
>>> +            continue;
>>> +        }
>>>    -            amdgpu_userq_fence_driver_get(fence_drv);
>>> +        fence_drv = userq_fence->fence_drv;
>>> +        /*
>>> +         * We need to make sure the user queue release their reference
>>> +         * to the fence drivers at some point before queue destruction.
>>> +         * Otherwise, we would gather those references until we don't
>>> +         * have any more space left and crash.
>>> +         */
>>> +        r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>>> +                 xa_limit_32b, GFP_KERNEL);
>>> +        if (r)
>>> +            goto put_waitq;
>>>    -            /* Store drm syncobj's gpu va address and value */
>>> -            fence_info[cnt].va = fence_drv->va;
>>> -            fence_info[cnt].value = fences[i]->seqno;
>>> +        amdgpu_userq_fence_driver_get(fence_drv);
>>>    -            dma_fence_put(fences[i]);
>>> -            /* Increment the actual userq fence count */
>>> -            cnt++;
>>> -        }
>>> +        /* Store drm syncobj's gpu va address and value */
>>> +        fence_info[cnt].va = fence_drv->va;
>>> +        fence_info[cnt].value = fences[i]->seqno;
>>>    -        wait_info->num_fences = cnt;
>>> -        /* Copy userq fence info to user space */
>>> -        if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
>>> -                 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
>>> -            r = -EFAULT;
>>> -            goto free_fences;
>>> -        }
>>> +        /* Increment the actual userq fence count */
>>> +        cnt++;
>>>        }
>>> +    wait_info->num_fences = cnt;
>>> +
>>> +    /* Copy userq fence info to user space */
>>> +    if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
>>> +             fence_info, cnt * sizeof(*fence_info)))
>>> +        r = -EFAULT;
>>> +    else
>>> +        r = 0;
>>> +
>>> +put_waitq:
>>> +    amdgpu_userq_put(waitq);
>>>      free_fences:
>>> -    if (fences) {
>>> -        while (num_fences-- > 0)
>>> -            dma_fence_put(fences[num_fences]);
>>> -        kfree(fences);
>>> -    }
>>> +    while (num_fences--)
>>> +        dma_fence_put(fences[num_fences]);
>>> +    kfree(fences);
>>> +
>>>    free_fence_info:
>>>        kfree(fence_info);
>>> -exec_fini:
>>> +    return r;
>>> +
>>> +error_unlock:
>>>        drm_exec_fini(&exec);
>>> -put_gobj_write:
>>> -    for (i = 0; i < num_write_bo_handles; i++)
>>> -        drm_gem_object_put(gobj_write[i]);
>>> -    kfree(gobj_write);
>>> +    goto free_fences;
>>> +}
>>> +
>>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>> +                struct drm_file *filp)
>>> +{
>>> +    int num_points, num_syncobj, num_read_bo_handles, num_write_bo_handles;
>>> +    u32 *syncobj_handles, *timeline_points, *timeline_handles;
>>> +    struct drm_amdgpu_userq_wait *wait_info = data;
>>> +    struct drm_gem_object **gobj_write;
>>> +    struct drm_gem_object **gobj_read;
>>> +    void __user *ptr;
>>> +    int r;
>>> +
>>> +    if (!amdgpu_userq_enabled(dev))
>>> +        return -ENOTSUPP;
>>> +
>>> +    if (wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
>>> +        wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>>> +        return -EINVAL;
>>> +
>>> +    num_syncobj = wait_info->num_syncobj_handles;
>>> +    ptr = u64_to_user_ptr(wait_info->syncobj_handles);
>>> +    syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
>>> +    if (IS_ERR(syncobj_handles))
>>> +        return PTR_ERR(syncobj_handles);
>>> +
>>> +    num_points = wait_info->num_syncobj_timeline_handles;
>>> +    ptr = u64_to_user_ptr(wait_info->syncobj_timeline_handles);
>>> +    timeline_handles = memdup_array_user(ptr, num_points, sizeof(u32));
>>> +    if (IS_ERR(timeline_handles)) {
>>> +        r = PTR_ERR(timeline_handles);
>>> +        goto free_syncobj_handles;
>>> +    }
>>> +
>>> +    ptr = u64_to_user_ptr(wait_info->syncobj_timeline_points);
>>> +    timeline_points = memdup_array_user(ptr, num_points, sizeof(u32));
>>> +    if (IS_ERR(timeline_points)) {
>>> +        r = PTR_ERR(timeline_points);
>>> +        goto free_timeline_handles;
>>> +    }
>>> +
>>> +    num_read_bo_handles = wait_info->num_bo_read_handles;
>>> +    ptr = u64_to_user_ptr(wait_info->bo_read_handles),
>>> +    r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
>>> +    if (r)
>>> +        goto free_timeline_points;
>>> +
>>> +    num_write_bo_handles = wait_info->num_bo_write_handles;
>>> +    ptr = u64_to_user_ptr(wait_info->bo_write_handles),
>>> +    r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
>>> +                   &gobj_write);
>>> +    if (r)
>>> +        goto put_gobj_read;
>>> +
>>> +    /*
>>> +     * Passing num_fences = 0 means that userspace doesn't want to
>>> +     * retrieve userq_fence_info. If num_fences = 0 we skip filling
>>> +     * userq_fence_info and return the actual number of fences on
>>> +     * args->num_fences.
>>> +     */
>>> +    if (!wait_info->num_fences) {
>>> +        r = amdgpu_userq_wait_count_fences(filp, wait_info,
>>> +                           syncobj_handles,
>>> +                           timeline_points,
>>> +                           timeline_handles,
>>> +                           gobj_write,
>>> +                           gobj_read);
>>> +    } else {
>>> +        r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
>>> +                            syncobj_handles,
>>> +                            timeline_points,
>>> +                            timeline_handles,
>>> +                            gobj_write,
>>> +                            gobj_read);
>>> +    }
>>> +
>>> +    while (num_write_bo_handles--)
>>> +        drm_gem_object_put(gobj_write[num_write_bo_handles]);
>>> +    kvfree(gobj_write);
>>> +
>>>    put_gobj_read:
>>> -    for (i = 0; i < num_read_bo_handles; i++)
>>> -        drm_gem_object_put(gobj_read[i]);
>>> -    kfree(gobj_read);
>>> +    while (num_read_bo_handles--)
>>> +        drm_gem_object_put(gobj_read[num_read_bo_handles]);
>>> +    kvfree(gobj_read);
>>> +
>>>    free_timeline_points:
>>>        kfree(timeline_points);
>>>    free_timeline_handles:
>>>        kfree(timeline_handles);
>>>    free_syncobj_handles:
>>>        kfree(syncobj_handles);
>>> -
>>> -    if (waitq)
>>> -        amdgpu_userq_put(waitq);
>>> -
>>>        return r;
>>>    }
>>
>> The rest looks good. In my RFC I found a way to not duplicate the various fence walks between the counting and waiting, but yours works as well.
>>
>> Regards,
>>
>> Tvrtko
>>
> 

