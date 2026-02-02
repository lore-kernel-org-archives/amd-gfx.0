Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B826E73164
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 13:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB91710E2B2;
	Mon,  2 Feb 2026 13:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="BNXro2sS";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD0B810E2B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 13:20:24 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-658f1fde4bfso3291793a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 05:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1770038423; x=1770643223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9sHQ2CHMaMKAzw3oPt3jUdD3nVQc1ytSeghpw/Atx9k=;
 b=BNXro2sSjqqRL9GZ1UcMoCHzU85D1poI4hSas27npzoDExY2nc8rWoHvCtggu9Atbf
 9xxQ0h4NRSm3aKILFH6fPPCfG73+kFZhZkxk/vum8hJR/OdEpXOAab7EDPtRfhObFO78
 2lMNXZrtMbYPsr9e04GmrA7+Usa0fqmY18q7WXw5WPM/ogTgzf4r4XOsGqBwHsUrgYr1
 Odz347xofSZvjo4cjYEBnM+0tts6uEX5xpWRCBgbPtdDdgGAG/8TNqcl5UXXdWpLSAgp
 eNj41B8YH2x5u1NO73zbSnN80yBEHuPEQ5T4MCK+8kpf6+Yg9gFdu0jOzuP+y84D3hKv
 exYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770038423; x=1770643223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9sHQ2CHMaMKAzw3oPt3jUdD3nVQc1ytSeghpw/Atx9k=;
 b=I2nULkeHQ5HqFjNxSSawRzKoLjkWcJlBWYdp7WrRg1FnPVSV42fk272NrDCXBgDMUz
 cd2/GgFAKTn7wBVvPQHILAfKdPi1n6nE/kvAAZNiGf5vymPA0QmafpI8FmQJCFG4jdij
 FmoVFKXJI13awiyPRDO/GGFaZeNZGLyjonuaDgd66IS1Zvd1/zeklxiNp/7hdVKUJSxZ
 QIazIAyfzpXL2PXLlFdatbawOmqLTGPp6B55iK6WO9WEM+DFTT7z+8heKuOSaz/cVE1/
 /+QF2bX0BieXPLKGczTOQq5Rro6ehGAM1v9ea7MVRn+EuttXJJZ/rmDvK/33BKXviosy
 LjeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVimOsEsRpF8AbR9ctwN1RQtp7fKI6J0oA+tNuk956m61anmGqlBfBRJBPct0cha1YGabvpbSJK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuRDWu5a3i0lkRDhYRQgpH+ep/sAOcFLtlhB/oeg9lpq9bPdCC
 Y4a3lgEyTxIK5oMWvIiFIq3wa0T470Q4mixymWHBE4hQFO9RhUiDTIKg7j8dfROyKtU=
X-Gm-Gg: AZuq6aJ2dn1LvegzW4Cy/SHyVvF8KYDYL52ojuCQHYD8FdRSFwmhwt5yJlAVNnc7ooJ
 dK2wH31u1JHiarwWxwQm4zHHeQx4e1Qyh1i6mng89MtxmOREYXi9Off6JYXQ97EEzZPOuEmsNhZ
 tN3HKncWWoq7+qZ6rjyMBE56O4IiliprwsoKgUBjqxJf0tTurVeEhnx2056KttpwT+ztEGfHC8q
 Wsc9a3qjgGoYPJQqdGkCQbunc363TK4VzVoJwx8O+W2D9BVdP8AmTEXHwxbxalcgOZyHJKtccEY
 SbwhLgMzn71seCsBkMYTnIPpOecKJyXi7dBboRBKohkgnnexN0td1+6NVqyyFyARsfkELtbhivf
 uA0iDN1VJrek3O2IXs0OWIyDS9wNqlq3WnQC6XwwN+nKWkb7FT13FN52kdLWvyykBces8Gir6u7
 yPU5pHz9/q3zyo4Ug1LEZZq0s/qC74Ys6J
X-Received: by 2002:a17:907:9704:b0:b88:2862:2802 with SMTP id
 a640c23a62f3a-b8ddf805072mr930124366b.1.1770038422894; 
 Mon, 02 Feb 2026 05:20:22 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbf183ccbsm859707766b.34.2026.02.02.05.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 05:20:22 -0800 (PST)
Message-ID: <396cab54-71ce-41a8-aab6-0108430fb217@ursulin.net>
Date: Mon, 2 Feb 2026 13:20:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drm/amdgpu: make amdgpu_user_wait_ioctl more resilent
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260129125327.11786-1-christian.koenig@amd.com>
 <20260129125327.11786-7-christian.koenig@amd.com>
 <45e5c024-8d21-4d4d-85dc-66fe31c05421@ursulin.net>
 <05c545db-b6e5-4f0b-b62a-f2ef1570c383@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <05c545db-b6e5-4f0b-b62a-f2ef1570c383@amd.com>
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


On 02/02/2026 12:33, Christian König wrote:
> On 1/29/26 16:16, Tvrtko Ursulin wrote:
>>
>> On 29/01/2026 12:53, Christian König wrote:
>>> When the memory allocated by userspace isn't sufficient for all the
>>> fences then just wait on them instead of returning an error.
>>
>> Hmm..
>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 52 ++++++++++---------
>>>    1 file changed, 28 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index ee8a5fbbd53b..d059712741fb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -734,7 +734,7 @@ amdgpu_userq_wait_count_fences(struct drm_file *filp,
>>>                num_fences++;
>>>        }
>>>    -    wait_info->num_fences = num_fences;
>>> +    wait_info->num_fences = min(num_fences, USHRT_MAX);
>>
>> Oh it is actually a weakness in the uapi with wait_info->num_fences being u16. I did not pick that from the commit message straight away.
> 
> No, that's not a weakness. It just doesn't make sense to return so many addr/value pairs.

Okay I couldn't tell from the commit message if this was hit in testing 
or just pre-emptively prevented by the patch.

And maybe not a weakness in the uapi per se, but a weakness in the 
combination of the uapi and the implementation. What I mean here that 
the 1st pass of the uapi works on the exploded fence view, while the 2nd 
pass works on the per-context view, but the implementation of the 2nd 
pass relies on the temporary storage sized by the 1st, which is 
therefore an irrelevant number from the _uapi_ point of view.

>> De-dup the array when over the uapi limit, and retry?
> 
> No, giving back addr/value pairs to userspace is just an optimization and not for technical correctness.
> 
> We could wait for everything inside the kernel, but that inserts a CPU bubble when submissions from multiple applications depend on each other.
> 
>> Is it userq fences or other fences that cause the spill in practice? If the former then the patch adds a kernel wait where there wasn't one before so de-duping more aggressively could maybe limit that path.
> 
> This is actually not a practical issue for performance. We just need to make sure that userspace can't abuse the API to kill X/Wayland for example by giving a BO to display with tons of fences on it.

Let  me try to better explain what I meant. Considering the current flow 
is like this:

1. Enumerate
2. De-dupe
3. a) Pass userq fences to userspace
    b) Wait on other fences in kernel

This patch adds (theoretical) kernel waits on *any* fence to the "1. 
Enumerate" stage even if the fence ends up being discarded in the 
de-dupe pass, and regardless of the fence type/owner.

I suppose my suggestion was just to add a de-dup pass to the out of 
space branch. Along the lines of:

static int
amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
			    struct dma_fence **fences, unsigned int *num_fences,
			    struct dma_fence *fence)
{
	/* As fallback shouldn't userspace allocate enough space */
	if (*num_fences >= wait_info->num_fences)
		*num_fences = dma_fence_dedup_array(fences, *num_fences);
		if (*num_fences >= wait_info->num_fences)
			return dma_fence_wait(fence, true);
	}

	fences[(*num_fences)++] = dma_fence_get(fence);
	return 0;
}

But I agree, if the expectation is the overflow if purely theoretical 
then it doesn't really matter.

Regards,

Tvrtko

>>>        r = 0;
>>>      error_unlock:
>>> @@ -743,6 +743,19 @@ amdgpu_userq_wait_count_fences(struct drm_file *filp,
>>>        return r;
>>>    }
>>>    +static int
>>> +amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
>>> +                struct dma_fence **fences, unsigned int *num_fences,
>>> +                struct dma_fence *fence)
>>> +{
>>> +    /* As fallback shouldn't userspace allocate enough space */
>>> +    if (*num_fences >= wait_info->num_fences)
>>> +        return dma_fence_wait(fence, true);
>>> +
>>> +    fences[(*num_fences)++] = dma_fence_get(fence);
>>> +    return 0;
>>> +}
>>> +
>>>    static int
>>>    amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>                        struct drm_amdgpu_userq_wait *wait_info,
>>> @@ -786,12 +799,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>                goto free_fences;
>>>              dma_fence_unwrap_for_each(f, &iter, fence) {
>>> -            if (num_fences >= wait_info->num_fences) {
>>> -                r = -EINVAL;
>>> +            r = amdgpu_userq_wait_add_fence(wait_info, fences,
>>> +                            &num_fences, f);
>>> +            if (r)
>>>                    goto free_fences;
>>> -            }
>>> -
>>> -            fences[num_fences++] = dma_fence_get(f);
>>>            }
>>>              dma_fence_put(fence);
>>> @@ -808,12 +819,11 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>            if (r)
>>>                goto free_fences;
>>>    -        if (num_fences >= wait_info->num_fences) {
>>> -            r = -EINVAL;
>>> +        r = amdgpu_userq_wait_add_fence(wait_info, fences,
>>> +                        &num_fences, f);
>>> +        if (r)
>>>                goto free_fences;
>>> -        }
>>>    -        fences[num_fences++] = fence;
>>>            dma_fence_put(fence);
>>>        }
>>>    @@ -844,13 +854,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>              dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
>>>                        DMA_RESV_USAGE_READ, fence) {
>>> -            if (num_fences >= wait_info->num_fences) {
>>> -                r = -EINVAL;
>>> -                goto error_unlock;
>>> -            }
>>> -
>>> -            fences[num_fences++] = fence;
>>> -            dma_fence_get(fence);
>>> +            r = amdgpu_userq_wait_add_fence(wait_info, fences,
>>> +                            &num_fences, f);
>>> +            if (r)
>>> +                goto free_fences;
>>>            }
>>>        }
>>>    @@ -861,13 +868,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>              dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
>>>                        DMA_RESV_USAGE_WRITE, fence) {
>>> -            if (num_fences >= wait_info->num_fences) {
>>> -                r = -EINVAL;
>>> -                goto error_unlock;
>>> -            }
>>> -
>>> -            fences[num_fences++] = fence;
>>> -            dma_fence_get(fence);
>>> +            r = amdgpu_userq_wait_add_fence(wait_info, fences,
>>> +                            &num_fences, f);
>>> +            if (r)
>>> +                goto free_fences;
>>>            }
>>>        }
>>>    
>>
> 

