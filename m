Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E2FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jan 2022 13:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5118410E314;
	Mon, 31 Jan 2022 13:39:08 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DECB10E314
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 13:39:07 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id k25so42906439ejp.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 05:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=oTzTzATg2mErR6l1cKB4pE5F5gHmoMv2smtijpvPfEo=;
 b=iPBcmJA+sM20axYJPJp4zunHiy9IhwtDZcWUtx9PjqvL+BR5PtmjBfNQtEPKD/7eSe
 6cUO/wemZ7xg03wf+Yk1VXdMn3idHdr+wiLmRP3m7YPOs6x7YOxUHbhyi8R5EdiEdCxJ
 5ypnCPGMs2pFp5sitpb03+voSpW54mj+mVJOts80eGKpfvpoPyxjP8/HUsPJYJ949zaa
 WsbjK6RFXi0pNYyJvMNNSgqnMJtceeNTflMdqnLfWUZpwbTqJnfotrSsP9aDMpmoq8Jf
 Obn+a/gdebVHNBmELoBKVfW3Rt4jJuQ2GIMAayD1M1EQmpOThhK/df+3O21eEhqwfQ4q
 cnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=oTzTzATg2mErR6l1cKB4pE5F5gHmoMv2smtijpvPfEo=;
 b=PCs3Q1971b8TBFnxN7qeTvOeTokq1DEJAH+q+QKVjsb/wzxXGHCKBqXesT4HJGjiZ9
 SmErc+z3JQGWwjpbAWoa4R1IHOF5QgFh0wzVNOniGqZYdVJEcGnpLk6Mi6pgB8EsVkmt
 vGtrLjAqiOBt3/49BQ7AZX6kIdzsQUMOyeL4GOP/RyHfXONBiW6zJ7KgANkacfug8BVY
 7HCksCH78sXe6WclzOILPD6/fIht/zdmdTGvYsoaLWLeW9B86BtjG67ZJ8J3UQ3tNPL7
 WLj/qYUZrJRDb+joix17v7B6FWP0fnKCfis9977VQ3u/4oN261v5p4JWzbVXUUuPIbbO
 ifMQ==
X-Gm-Message-State: AOAM531SzayFQUuU8GY2BEbeHCNVCuAeHzX3lhoxR1FUqg9IAm3c7ELp
 tEfnyBWWGbE5h4ebP6gsNBxNcgcw8vY=
X-Google-Smtp-Source: ABdhPJxgl8sT1TyP6ZiJOeYEhNRnXpFVfchQbwkT18+cea1euLVFWehmGwZPhOlGQScXIaDMWk7DdA==
X-Received: by 2002:a17:906:910:: with SMTP id
 i16mr16418295ejd.677.1643636345988; 
 Mon, 31 Jan 2022 05:39:05 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:a1a5:68e2:5791:313f?
 ([2a02:908:1252:fb60:a1a5:68e2:5791:313f])
 by smtp.gmail.com with ESMTPSA id d16sm13313870ejy.135.2022.01.31.05.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jan 2022 05:39:05 -0800 (PST)
Message-ID: <279aa99d-2146-1362-ac66-0781fafc67e7@gmail.com>
Date: Mon, 31 Jan 2022 14:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: restructure amdgpu_fill_buffer
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, harish.kasiviswanathan@amd.com,
 benjaminadam.price@amd.com, amd-gfx@lists.freedesktop.org
References: <20220128151637.1403-1-christian.koenig@amd.com>
 <20220128151637.1403-2-christian.koenig@amd.com>
 <a08812d4-a464-de08-8b5a-3c13408efff5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <a08812d4-a464-de08-8b5a-3c13408efff5@amd.com>
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



Am 28.01.22 um 16:55 schrieb Felix Kuehling:
>
> Am 2022-01-28 um 10:16 schrieb Christian König:
>> [SNIP]
>> -    if (bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
>
> As far as I can see, you didn't add this check back elsewhere. The 
> promise for preemptible BOs is, that we never have to wait for the GPU 
> to finish accessing the BOs because the context using it is 
> preemptible. This was a necessary condition to disable GTT usage 
> accounting for such BOs. If you allow filling such BOs with this 
> function, you're breaking that promise.

That's now part of amdgpu_ttm_map_buffer(), but unfortunately as 
BUG_ON(). I've added a patch to change that into a warning.

[SNIP]
>> +        cur_size = min_t(u64, dst.size, AMDGPU_GTT_MAX_TRANSFER_BYTES);
>
> For VRAM, the cur_size could be much bigger because we're not limited 
> by the GART transfer window. I'm pretty sure that 2MB is going to add 
> too much overhead. For the extreme 60GB BO example, it would require 
> 30-thousand IBs and IB frames to fill the entire buffer. That's a lot 
> of VMID-switching, IB execution, fence signalling, interrupts, etc.

I've restructured the mapping function so that we can now copy/fill in 
256MiB chunks when no GART window is involved.

>
>
>> +
>> +        r = amdgpu_ttm_map_buffer(&bo->tbo, bo->tbo.resource, &dst,
>> +                      PFN_UP(cur_size), 1, ring, false,
>> +                      &to);
>> +        if (r)
>> +            goto error;
>> +
>> +        r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, resv,
>> +                    &next, false);
>
> If amdgpu_ttm_map_buffer updated the page tables, shouldn't the 
> vm_needs_flush parameter be true? This flag should probably be 
> returned by amdgpu_ttm_map_buffer.

Ah, yes. That's indeed a typo. For now I've didn't added the 
vm_needs_flush parameter, but that's something we could optimize.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>> +        if (r)
>> +            goto error;
>> +
>> +        dma_fence_put(fence);
>> +        fence = next;
>> +
>> +        amdgpu_res_next(&dst, cur_size);
>> +    }
>> +error:
>> +    mutex_unlock(&adev->mman.gtt_window_lock);
>> +    if (f)
>> +        *f = dma_fence_get(fence);
>> +    dma_fence_put(fence);
>> +    return r;
>> +}
>> +
>>   /**
>>    * amdgpu_ttm_evict_resources - evict memory buffers
>>    * @adev: amdgpu device object
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index d9691f262f16..bcd34592e45d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -35,6 +35,8 @@
>>     #define AMDGPU_GTT_MAX_TRANSFER_SIZE    512
>>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS    2
>> +#define AMDGPU_GTT_MAX_TRANSFER_BYTES (AMDGPU_GTT_MAX_TRANSFER_SIZE * \
>> +                     AMDGPU_GPU_PAGE_SIZE)
>>     #define AMDGPU_POISON    0xd0bed0be

