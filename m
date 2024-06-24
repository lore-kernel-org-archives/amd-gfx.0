Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDAEC2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 12:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377A310E406;
	Mon, 24 Jun 2024 12:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+q58WD/";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6193110E406
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 12:01:23 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4248ff53f04so6882025e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 05:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719230481; x=1719835281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8bUz86E0epq/MK4DAOyV6oJPWzbgnia4TeJib1//Ai4=;
 b=U+q58WD/+MV9i0fw4HHjouTzzY2q5gfnprXFKfodPtHXx0EiR41TTG6Jc6mOl0v/9a
 4wprK9OqLeRCWX3+KcI5GKUA/P1pGH1agGE+n/RkQ4fa8coRxDxZxZlR36SkW8bgdsXs
 x/FGjnADLu/6H/ckILYBGGiOj4vpdkNfy45HYehBLYMGWdrZZb0ada/3rs5j/s+PaLpw
 LooTqYsbUvmpFO/7BBzgoFqIdILbSvpAuhlKiZpobg+1Nd2MX/XWs7rQnc6/Fj+/cbE8
 WmFQqhQEih2iSMsP6DBM31kBfMfLpDtcyb3GX8SSfO0B1rFinZSWCcf5Ea4gHjewAP7J
 mIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719230481; x=1719835281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8bUz86E0epq/MK4DAOyV6oJPWzbgnia4TeJib1//Ai4=;
 b=f7p++bmfOt0uaqhKD4fH2reQoOrPlBx9TnfDP9KdAXf7biOTvynvNKQ/XkGXqRL+gH
 D74R0+NXQh2Dq7Xb9Oi4BZHcZ9zqRYxDMjvV6sHlbLFyyG8c7p3unLV/2eL847Tl8LRG
 Zf/PeS4g8t1rxGFhTIzqCdsu8+nQr5+9+7vo/RQL5korBn8IFlI68LbAU3KG3RrssTN+
 0rW5ZnhfO2VzC7JPymKZ+My/PuntR/zUDIgc/I7SbpyNSjWRnUER6wEmoCvCnDOLuuz5
 7U7s3f9B3QsvmQk16CshDvkTkK+X+yI3aBdIswaRxj4ez+TbLFQe2CUDDqGQu6HbaGyJ
 GVpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfTO+HtdFEqzpcCuPNZVtNtQXKJhWXq7us99tt0MJA8YsqlfpzQ8KVwWHoEepLT4S6tmOBxBOi3lfUKS8Z55+SOQzNKhfO4RF1g8VeMg==
X-Gm-Message-State: AOJu0YzbZJe50gTaA7PpumbScH0B6mSK9VNu6Ua98GuEk+Ozk7E1+RBV
 9UgTXDow78ssbr5nooWw/32mfUm6wsRM8+LyF6x9M+JihW58PFYm
X-Google-Smtp-Source: AGHT+IHhtuLcemkOvcLi/A7unBj+95OYxVQubw1JqzOkLOZif7oG/MhdJfZB6vZ9LluMH247R1qupQ==
X-Received: by 2002:a05:600c:68d7:b0:424:8c1a:abb5 with SMTP id
 5b1f17b1804b1-4248c1aac15mr36301685e9.1.1719230481114; 
 Mon, 24 Jun 2024 05:01:21 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8c8aa6sm9917713f8f.105.2024.06.24.05.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 05:01:20 -0700 (PDT)
Message-ID: <95ef35d7-4056-42a7-9e81-46e84eeed315@gmail.com>
Date: Mon, 24 Jun 2024 14:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop kiq access while in reset
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Vignesh Chander <Vignesh.Chander@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jeffrey.chan@amd.com, zhigang.luo@amd.com
References: <20240624063109.655690-1-Vignesh.Chander@amd.com>
 <6f21496a-282c-428e-b66d-92edb82b21d8@amd.com>
 <5d63de6b-0d46-422f-bc6e-6f59fce6104a@gmail.com>
 <ddc93078-bebc-4414-b6c9-07e01d663838@amd.com>
 <543fd667-6e91-4efb-b3e2-49d0c9a5c467@gmail.com>
 <fae5960b-b782-4f7f-b8b2-64a1af62f61f@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <fae5960b-b782-4f7f-b8b2-64a1af62f61f@amd.com>
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

Am 24.06.24 um 13:57 schrieb Lazar, Lijo:
> On 6/24/2024 5:19 PM, Christian König wrote:
>> Am 24.06.24 um 11:52 schrieb Lazar, Lijo:
>>> On 6/24/2024 3:08 PM, Christian König wrote:
>>>> Am 24.06.24 um 08:34 schrieb Lazar, Lijo:
>>>>> On 6/24/2024 12:01 PM, Vignesh Chander wrote:
>>>>>> correctly handle the case when trylock fails when gpu is
>>>>>> about to be reset by dropping the request instead of using mmio
>>>>>>
>>>>>> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
>>>>> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38
>>>>>> ++++++++++++----------
>>>>>>     1 file changed, 21 insertions(+), 17 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index a7ce8280b17ce7..3cfd24699d691d 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -613,10 +613,11 @@ uint32_t amdgpu_device_rreg(struct
>>>>>> amdgpu_device *adev,
>>>>>>           if ((reg * 4) < adev->rmmio_size) {
>>>>>>             if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>>> -            ret = amdgpu_kiq_rreg(adev, reg, 0);
>>>>>> -            up_read(&adev->reset_domain->sem);
>>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>>> +                ret = amdgpu_kiq_rreg(adev, reg, 0);
>>>>>> +                up_read(&adev->reset_domain->sem);
>>>>>> +            }
>>>> What has actually changed here? As far as I can see that isn't
>>>> functionally different to the existing code.
>>>>
>>> In earlier logic, if it fails to get the lock, it takes the 'else' path.
>>> The 'else' path is not meant for sriov/vf.
>> Yeah, but the read or write is then just silently dropped.
>>
>> That can't be correct either.
>>
> These are void funcs. Moreover, the drops will happen if there is
> concurrent access from another thread while a reset is going on. That is
> expected and those accesses during a reset won't help anyway.

Nope, Teddy has been working on that for a while as well.

Trying to make those accesses while the reset is going on is wrong in 
the first place. What we need to do is to grab the reset lock in the 
higher level function so that the whole sequences of reads and writes 
are protected.

What this logic here does is to use readl()/writel() from the reset 
thread itself. Dropping that is incorrect and could lead to broken reset.

So clear NAK from my side to this patch here.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>> Thanks,
>>> Lijo
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>>             } else {
>>>>>>                 ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
>>>>>>             }
>>>>>> @@ -681,10 +682,11 @@ uint32_t amdgpu_device_xcc_rreg(struct
>>>>>> amdgpu_device *adev,
>>>>>>                                  &rlcg_flag)) {
>>>>>>                 ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag,
>>>>>> GET_INST(GC, xcc_id));
>>>>>>             } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>>> -            ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>>>>>> -            up_read(&adev->reset_domain->sem);
>>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>>> +                ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>>>>>> +                up_read(&adev->reset_domain->sem);
>>>>>> +            }
>>>>>>             } else {
>>>>>>                 ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
>>>>>>             }
>>>>>> @@ -740,10 +742,11 @@ void amdgpu_device_wreg(struct amdgpu_device
>>>>>> *adev,
>>>>>>           if ((reg * 4) < adev->rmmio_size) {
>>>>>>             if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>>> -            amdgpu_kiq_wreg(adev, reg, v, 0);
>>>>>> -            up_read(&adev->reset_domain->sem);
>>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>>> +                amdgpu_kiq_wreg(adev, reg, v, 0);
>>>>>> +                up_read(&adev->reset_domain->sem);
>>>>>> +            }
>>>>>>             } else {
>>>>>>                 writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>>>>>>             }
>>>>>> @@ -812,11 +815,12 @@ void amdgpu_device_xcc_wreg(struct
>>>>>> amdgpu_device *adev,
>>>>>>                                  &rlcg_flag)) {
>>>>>>                 amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag,
>>>>>> GET_INST(GC, xcc_id));
>>>>>>             } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>>> -            amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>>>>>> -            up_read(&adev->reset_domain->sem);
>>>>>> -        } else {
>>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>>> +                amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>>>>>> +                up_read(&adev->reset_domain->sem);
>>>>>> +            }
>>>>>> +            } else {
>>>>>>                 writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>>>>>>             }
>>>>>>         } else {

