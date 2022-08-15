Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88391C00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 18:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF45CFFB4;
	Mon, 15 Aug 2022 18:16:38 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511F9D0013
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 18:16:18 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id y3so10578028eda.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=9cQL62kPBMoRcoy0ebkfHR1f7scO2r7fSGP5Y18WMEo=;
 b=oSJaPOtf3rly2EhPlV6XG+H7M88y5kvt2RGINcAoSraWjEV3sNlNZj7vG0k6wrTRYR
 lRU6vLPIDC0LIlgjb72QzYxwKrY39vvUxTr2khD1j3OIJY8Qz+wdyAgOB/Mhr9KY3v8O
 sxVElERlk0jtLT+B82VMziYBdD1NxhFXaadZtVs3CvdFtHVlFsY5SWc60OE3enCC4BzH
 KRrOopNt16zOuj6Az1YrLHqxNGp1JCRE18ovfFJ4/U+JPBx4/BA9ckvJo8DvF8vSDiVQ
 NQXWve+QpAiESchoCesCN2DUhk4WDhZ/xSjsz2Z3+UPW9VnoWCBauzyUiB81eN9HmKd5
 nmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=9cQL62kPBMoRcoy0ebkfHR1f7scO2r7fSGP5Y18WMEo=;
 b=A3u6WY5JsaXymWKY6Fmxz67Iu1B2rjJK2lRvYcPPcKNhltxCR1F+kGkyVRs82tgS9m
 3zd8m8VUVHJWdd1d6TG+ckAUe359LNmqwQ4kagynJZnoeTt3vJ/kHTxoxJ/do4To7kpi
 DfC58pEZsYF02qiHn3FkjJ2dPvSMOLJaAoRY99+YcduyQvvGzJ9enDxXjMo8zJ2yPlDf
 +Zn+89XmPaScov1gKH4oS9i6c8blbCphTMX8Ad4H+Xku7Jvui1ev6DXLzPorRuudOcfA
 kWtxGnHazGWkJ+YohWnlV00O9kOkyA5k86fluEKUpcfQP2xbRNPAtSS8j8nb06h3Ip+U
 DtZw==
X-Gm-Message-State: ACgBeo0FBlyJsUNGe3NfuxyhCzjARQltWrE3N+VPZPVJk9UHzHy93i0Z
 RVo08TvH6KFYK3RFFWHxobw=
X-Google-Smtp-Source: AA6agR6/CHqB1sraYI+Mk5BdD2uNmhuHKSZxO1KZw873FoydJSgs5zv1UkC1tuDLVR/dArucQaX6/Q==
X-Received: by 2002:a05:6402:12cb:b0:43d:6e77:19a7 with SMTP id
 k11-20020a05640212cb00b0043d6e7719a7mr15835636edx.342.1660587376694; 
 Mon, 15 Aug 2022 11:16:16 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fde9:87ac:35f4:a1a9?
 ([2a02:908:1256:79a0:fde9:87ac:35f4:a1a9])
 by smtp.gmail.com with ESMTPSA id
 d26-20020a056402401a00b004438a13ab73sm4372213eda.5.2022.08.15.11.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Aug 2022 11:16:16 -0700 (PDT)
Message-ID: <ec5415f2-267c-1011-13a2-2ffd9c8a2210@gmail.com>
Date: Mon, 15 Aug 2022 20:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix interrupt handling on ih_soft ring
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220812205624.2902630-1-mukul.joshi@amd.com>
 <c761f5f9-eb52-c04b-e66f-1c05cfb2c2c1@gmail.com>
 <04d1f7d0-354f-4a64-5ceb-b378997e1203@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <04d1f7d0-354f-4a64-5ceb-b378997e1203@amd.com>
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

Am 15.08.22 um 17:16 schrieb Felix Kuehling:
> Am 2022-08-14 um 13:27 schrieb Christian König:
>> Am 12.08.22 um 22:56 schrieb Mukul Joshi:
>>> There are no backing hardware registers for ih_soft ring.
>>> As a result, don't try to access hardware registers for read
>>> and write pointers when processing interrupts on the IH soft
>>> ring.
>>
>> Mhm, the original plan was to have different ih function for the 
>> rings but I think we just forgot to implement this fully.
>>
>> When you do it this way you need to apply it to a bunch of different 
>> hw generation as Felix mentioned as well.
>>
>> Might be easier to clean that up.
>
> Right now ih_funcs cannot be different per ring. Are you suggesting 
> moving the ih_funcs into the amdgpu_ih_ring structure?

IIRC we even discussed on that already and thought that would be the 
best approach.

It's just that nobody ever came around to do it.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> index 3b4eb8285943..2022ffbb8dba 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> @@ -385,9 +385,11 @@ static u32 vega20_ih_get_wptr(struct 
>>> amdgpu_device *adev,
>>>       u32 wptr, tmp;
>>>       struct amdgpu_ih_regs *ih_regs;
>>>   -    if (ih == &adev->irq.ih) {
>>> +    if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
>>>           /* Only ring0 supports writeback. On other rings fall back
>>>            * to register-based code with overflow checking below.
>>> +         * ih_soft ring doesn't have any backing hardware registers,
>>> +         * update wptr and return.
>>>            */
>>>           wptr = le32_to_cpu(*ih->wptr_cpu);
>>>   @@ -461,6 +463,9 @@ static void vega20_ih_set_rptr(struct 
>>> amdgpu_device *adev,
>>>   {
>>>       struct amdgpu_ih_regs *ih_regs;
>>>   +    if (ih == &adev->irq.ih_soft)
>>> +        return;
>>> +
>>>       if (ih->use_doorbell) {
>>>           /* XXX check if swapping is necessary on BE */
>>>           *ih->rptr_cpu = ih->rptr;
>>

