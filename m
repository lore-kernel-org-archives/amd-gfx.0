Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60770C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 13:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F143310E122;
	Wed, 22 Mar 2023 13:58:55 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 985D610E122
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 13:58:54 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id ew6so10376333edb.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 06:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679493533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hqNIchXJim/0kjoOmqmrC++Cit1IAj+mPEq4naz2WpM=;
 b=Fnf3fCx57kRl1LS5cb5VuuayAgzWaExuVWZMgkf1hRyrr4xRisja/VdAQXtPOwWzSk
 HrSsUo9oOA/74k1oQU/u3M9+PHHWjZLG5V6uUYPAnue4KkXzVXEZ8cuKbyLhEkm5GKKR
 Zj6Eq7jfCs27Pt5faKwCXA8ayr51s6dIroqT+jH4J4eqY4YzAOi+QPJvBvHzq14KV75s
 7rLMrwvjgxKVh17u4Q7HEcMGSXGdy2hhCXmcJvFOQpub+x56lhvvseyWUQs9Hg2j1fve
 imqzuEYSEGxGySkvn7kPpPMRgVMhn6fuXnjfmV4VVDl9cNDdMkxuHMzUJDT53O+pjUGT
 DC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679493533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hqNIchXJim/0kjoOmqmrC++Cit1IAj+mPEq4naz2WpM=;
 b=G/ebqDA9c2De2BbkiZqDsWkOGeAT6BCnzGY28SQ29SKjBgd4at0y3+IvrctCXA/UIA
 KRoFM5xxnEakcUvdLtwmrDvcwlk7LrNnBW7eRXUkb5w4xjx0SWvkjd314L9t5jNn0Cls
 9la1JAxSsuXXe9bXBgTGyqiPySVs5IrOiPcCHuw5XyJQulTIfexYJAdTQ+QoVi74RwdV
 VTXQht4ugT8WtdDxPxuikNcvpwv7JRZt6R3UH/AS0NXnFQjRonUdsYlL+i7Qam9eX8RO
 tnzRbJUk75dwtbjRCmcJ+4EaO3FowbDn0SxPIuCKnKh1eybBzWV0efRURbNvrtgVqADc
 cYXw==
X-Gm-Message-State: AO0yUKUG+rEOFiCoqXCM3NiJW4jrF6i4OPowxpaNWSiQNSxNV66rFPHQ
 JiHHbDQU/nJ8R/jydcm+kvp4jm8T5gw=
X-Google-Smtp-Source: AK7set/9sqFCPDSL9neVZntu161JcV2te3EzR55XO+ShslhzqDn061GwSojoj6S04rip8M/lMRZkIw==
X-Received: by 2002:a17:906:1705:b0:92c:a80e:2260 with SMTP id
 c5-20020a170906170500b0092ca80e2260mr7860063eje.54.1679493533126; 
 Wed, 22 Mar 2023 06:58:53 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:65e5:3673:f4af:8235?
 ([2a02:908:1256:79a0:65e5:3673:f4af:8235])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a1709067d9300b008cff300cf47sm7230322ejo.72.2023.03.22.06.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Mar 2023 06:58:52 -0700 (PDT)
Message-ID: <22ef9485-11e1-1e23-34d1-f8a40698b226@gmail.com>
Date: Wed, 22 Mar 2023 14:58:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] drm/amdgpu: track MQD size for gfx and compute
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230321193922.2029808-1-alexander.deucher@amd.com>
 <07b35e4b-c574-0ad8-9c71-591dc5457979@gmail.com>
 <CADnq5_OAZZ-SYLprOFzzJgsQBxs15FdxTWc28MpUQ-abM4ZLHA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_OAZZ-SYLprOFzzJgsQBxs15FdxTWc28MpUQ-abM4ZLHA@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.03.23 um 14:26 schrieb Alex Deucher:
> On Wed, Mar 22, 2023 at 4:48 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 21.03.23 um 20:39 schrieb Alex Deucher:
>>> It varies by generation and we need to know the size
>>> to expose this via debugfs.
>> I suspect we can't just use the BO size for this?
> We could, but it may be larger than the actual MQD.  Maybe that's not
> a big deal?

I don't really know either. Maybe just go ahead with this approach here, 
but I usually try to avoid stuff like that because it can be an 
additional source of errors when the allocation size is not correct.

Christian.

>
> Alex
>
>
>> If yes the series is Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 2 ++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
>>>    2 files changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index c50d59855011..5435f41a3b7f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -404,6 +404,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>>>                                        return r;
>>>                                }
>>>
>>> +                             ring->mqd_size = mqd_size;
>>>                                /* prepare MQD backup */
>>>                                adev->gfx.me.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
>>>                                if (!adev->gfx.me.mqd_backup[i])
>>> @@ -424,6 +425,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>>>                                return r;
>>>                        }
>>>
>>> +                     ring->mqd_size = mqd_size;
>>>                        /* prepare MQD backup */
>>>                        adev->gfx.mec.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
>>>                        if (!adev->gfx.mec.mqd_backup[i])
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 7942cb62e52c..deb9f7bead02 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -257,6 +257,7 @@ struct amdgpu_ring {
>>>        struct amdgpu_bo        *mqd_obj;
>>>        uint64_t                mqd_gpu_addr;
>>>        void                    *mqd_ptr;
>>> +     unsigned                mqd_size;
>>>        uint64_t                eop_gpu_addr;
>>>        u32                     doorbell_index;
>>>        bool                    use_doorbell;

