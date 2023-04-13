Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD41C77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 11:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F7E10EAC6;
	Thu, 13 Apr 2023 11:35:53 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B8F10EAC6
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 11:35:50 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id xi5so36607062ejb.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681385748; x=1683977748;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=njyAvRzpSOXk7Mi8+Wyzd1bpSqXHuFg8jVFa2oxa9Lg=;
 b=N+6xK0/Sow9E0UuRMSdkEpn3+GOTDUabC36bMBc5SUKli54szsY9rqdOQ4RuiIfM3z
 xoom+NkEprYN3Ssq02AUHkcxZLkKPWZywJUoQLLfT9F+eZS3RAqxlaOsuD7Eel+g88yo
 rflewswigda3VeDpWLOCH+M76FJBpT0AnCCMG+upJjzh79UwiXomGvxpns4PVJbWngvq
 vcBXSK51YNPYcLzR03Pxjt6K5x0xlTF71OfkwDTjuUMMx+DfEvJWfQtCzgKC/kYEDyDd
 v/QM67G7iT8i0RQro1bNYLNxXPOZjyxg2D45LDdH06pFwrP0l2sKQ9yne1Z/BbyonmD9
 MnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681385748; x=1683977748;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=njyAvRzpSOXk7Mi8+Wyzd1bpSqXHuFg8jVFa2oxa9Lg=;
 b=cJRxhq3Z7UAtcYOP0MTWDUJ1Ly2Aub2MFlYbDbNFuAwmZYhEitz1kIHWqesNTszpBn
 70mRzcNU3ht8eBrAh68x0LoT5sZLg5q/bpooABnuUveDjJDAkptVOoy+h1QLFlmNnZq/
 5gMLs6PfVhGIzLe+vjgbl2KBYuwH+Qo0hQvGlEzzNd7K75WtQ9RRtZzCxG53cQY+VGeq
 7qfC4fN097ZkjwkVzYq4VivKA1bvw7lKGxwrhoji/GyhgE9QPVgHTy4cRErkYE9Vp/oQ
 rv4HtAoi9UfJbJhxjyUFtVGgycQIxQy8vnUwBTWZq6P7k+I+CGE3BZyc+HVMKZquwOpL
 yE5g==
X-Gm-Message-State: AAQBX9fWfYs1FFhr0Nht0s5zMNb3UvbnuuBDNkQgvOOFnislU2t7myBE
 CDfLzXGYZBwUaYV4xfpuToA=
X-Google-Smtp-Source: AKy350YpYKkeVPXOPG2B1RKpGd0Fvtj1N4cVwnteCg5Yn65cSg7LQbevcBK8YTijTgignte0TyMdTw==
X-Received: by 2002:a17:907:7749:b0:94e:56c4:59f2 with SMTP id
 kx9-20020a170907774900b0094e56c459f2mr2243349ejc.26.1681385748548; 
 Thu, 13 Apr 2023 04:35:48 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 y2-20020aa7c242000000b00504937654f8sm732971edo.21.2023.04.13.04.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Apr 2023 04:35:47 -0700 (PDT)
Message-ID: <6d32ae76-08fa-64a4-6726-2d55e8c9fc08@gmail.com>
Date: Thu, 13 Apr 2023 13:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230412222511.236384-1-jinhuieric.huang@amd.com>
 <ce2de03d-27c5-a7ad-1a76-814cbd92f15e@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ce2de03d-27c5-a7ad-1a76-814cbd92f15e@amd.com>
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

Am 13.04.23 um 03:01 schrieb Felix Kuehling:
> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>> It is to avoid redundant eviction for KFD's DMAbuf import
>> bo when dmaunmapping DMAbuf. The DMAbuf import bo has
>> been set as AMDGPU_PL_PREEMPT in KFD when mapping.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> I'd like to get an Acked-by from Christian as well before submitting 
> this.

I have to admit that I only partially followed the internal discussion, 
but in general you need a *really* good explanation for this.

E.g. add code comment and explain in the commit message extensively why 
this is needed and why there are no alternatives.

Regards,
Christian.

>
> Thanks,
>   Felix
>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 2430f3e9f3a7..64795fe9eecb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct 
>> ttm_buffer_object *bo, bool evict,
>>       if ((old_mem->mem_type == TTM_PL_TT ||
>>            old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>           new_mem->mem_type == TTM_PL_SYSTEM) {
>> -        r = ttm_bo_wait_ctx(bo, ctx);
>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>> +            r = amdgpu_bo_sync_wait(abo,
>> +                        AMDGPU_FENCE_OWNER_KFD,
>> +                        ctx->interruptible);
>> +        else
>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>           if (r)
>>               return r;

