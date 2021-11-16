Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CD9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 10:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E8D60ED5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 10:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46E8D60ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAF9E6E958;
	Tue, 16 Nov 2021 10:44:00 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA9F6E958
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 10:44:00 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id s13so36692084wrb.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=DNlrW0U6Yq8JoZRUHbq8UexhS2SyhBGAM/OB1qK7/I0=;
 b=FEoILWgMxpNbXywFEoF7LbEvD4Dkwtoi3MJwoXgn/s+QcbH0YUOJnUztc42yk8OTnu
 /4BczhNjey9sP3sAXvFdCuPA7iXQzti52ZlRR7yecNyk874rpnGBwVRn+Qb+s2MPqmi1
 lVtcZO1VhdDa7cP0FGtJFKYHFcvowSSyLaRCbmoZegqUNg42nfjBQec4crEB1k4gmRMc
 SV6lOoKTn3qc9JvLtxFzSXeOegerECSrZ6agHhurDwfD4JF/SMSFmUCoUQ3KrzbDIoqe
 Jy9cNbH///DZGC0emvT5Y20mKh5mLZLtxdW/shT71jwN/VPRtoxZFYS8d7Nyegw09ZqG
 iR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=DNlrW0U6Yq8JoZRUHbq8UexhS2SyhBGAM/OB1qK7/I0=;
 b=ithSW74662gnRKF4mPB2RqwGVydxtj4DJUKBHV5OChJowJ6g5lPqZDe0SLiRu2FcKo
 P1j6S0Hx6kkKNe9rJ1gbafq4J5NfdQOdt2TtqlGCSzTkdsI74/4TPq/JE7jA1EOhtOlv
 a1qUv0o4LAxi3pAEG6etI+Z/Cm/xc0J6TECAWDFIiQkw0yWHANOSjKxynFcm2K3yCVZZ
 8KeciK58pNMUiyS7tKEjootvlx8KV92JcaHdEhMQywbTFO3XC0L1RwKSY+o3q5JXlPd9
 NnOWKnxxctwj/tBvZjzhRHp8P7xtx/A+Mtr/Y7u3p7r5LvFhRKZYupYPbLU8Werv+yJg
 E7Aw==
X-Gm-Message-State: AOAM5307RkUC3RJqkxUzsI00zECx11Vbu6Q6Q7fnTSvAz2IpAsIhJqFh
 tY+6F9i5Syq+5MNXrQNKruE=
X-Google-Smtp-Source: ABdhPJyT97jQWH5WbLbRneOC3+3RnNGvJHWR/nxqoHCnOXcSLqjWsyit9ACrbRQFEPSPZFwJBu8VFg==
X-Received: by 2002:a5d:6c6a:: with SMTP id r10mr8319191wrz.211.1637059438900; 
 Tue, 16 Nov 2021 02:43:58 -0800 (PST)
Received: from [192.168.178.21] (p57b0b77b.dip0.t-ipconnect.de.
 [87.176.183.123])
 by smtp.gmail.com with ESMTPSA id l7sm21183206wry.86.2021.11.16.02.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Nov 2021 02:43:58 -0800 (PST)
Subject: Re: [PATCH 2/6] drm/amdgpu: stop getting excl fence separately
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <Alexander.Deucher@amd.com>
References: <20211028132630.2330-1-christian.koenig@amd.com>
 <20211028132630.2330-2-christian.koenig@amd.com>
 <d82038f9-c1f5-2ede-f867-efe843cee1a6@gmail.com>
Message-ID: <e263bccc-41f0-4183-884e-dc07ca1bcbc9@gmail.com>
Date: Tue, 16 Nov 2021 11:43:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d82038f9-c1f5-2ede-f867-efe843cee1a6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adding Alex.

Once more a ping to the mailing list.

Thanks,
Christian.

Am 11.11.21 um 09:58 schrieb Christian König:
> Just a ping to the amd-gfx list.
>
> Trivial cleanup, can anybody give me an rb for that?
>
> Thanks,
> Christian.
>
> Am 28.10.21 um 15:26 schrieb Christian König:
>> Just grab all fences for the display flip in one go.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 +-----
>>   2 files changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d58e37fd01f4..4da7eb65e744 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -457,7 +457,6 @@ struct amdgpu_flip_work {
>>       uint64_t            base;
>>       struct drm_pending_vblank_event *event;
>>       struct amdgpu_bo        *old_abo;
>> -    struct dma_fence        *excl;
>>       unsigned            shared_count;
>>       struct dma_fence        **shared;
>>       struct dma_fence_cb        cb;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> index dc50c05f23fc..68108f151dad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> @@ -83,9 +83,6 @@ static void amdgpu_display_flip_work_func(struct 
>> work_struct *__work)
>>       unsigned i;
>>       int vpos, hpos;
>>   -    if (amdgpu_display_flip_handle_fence(work, &work->excl))
>> -        return;
>> -
>>       for (i = 0; i < work->shared_count; ++i)
>>           if (amdgpu_display_flip_handle_fence(work, &work->shared[i]))
>>               return;
>> @@ -203,7 +200,7 @@ int amdgpu_display_crtc_page_flip_target(struct 
>> drm_crtc *crtc,
>>           goto unpin;
>>       }
>>   -    r = dma_resv_get_fences(new_abo->tbo.base.resv, &work->excl,
>> +    r = dma_resv_get_fences(new_abo->tbo.base.resv, NULL,
>>                   &work->shared_count, &work->shared);
>>       if (unlikely(r != 0)) {
>>           DRM_ERROR("failed to get fences for buffer\n");
>> @@ -253,7 +250,6 @@ int amdgpu_display_crtc_page_flip_target(struct 
>> drm_crtc *crtc,
>>     cleanup:
>>       amdgpu_bo_unref(&work->old_abo);
>> -    dma_fence_put(work->excl);
>>       for (i = 0; i < work->shared_count; ++i)
>>           dma_fence_put(work->shared[i]);
>>       kfree(work->shared);
>

