Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A8AC2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 11:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559D410E3FC;
	Mon, 24 Jun 2024 11:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ScnOoiuh";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59D8910E3FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 11:49:28 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-35f090093d8so2915183f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719229766; x=1719834566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M/IuSOve3u0jM9/Cb3Oqv1LmbJtnbSsnEWtEv6MuWg8=;
 b=ScnOoiuhvB2L3/Me6ndt3Q4+lTDLWafeM4UKGua7tGwIHMzwndPlHbZr15F+mVyuZP
 hDWXX6gsSuejN/quCHyn9SgT7FF9EvhFIvw/yVmu3MTJQn8wp7C6z6Cgacj8JRI9wBtc
 B1Qd0pfsgGGHxyHH59evva7kPPwHQt962SRT451FYTlsfL1siYfIuWUh/hotPgmTdk63
 yCR3U3xI9aG6NKWXqdS6HQvkN0Bzl3JqJJVr8Wv7LhI2yiZnU9hkDg8AQauBpL73YLKu
 pXzZF1YQ5CND10rg2lNjRh+Mtet/SS/Sb4Ypwc6EoLqtiO3jv+zUIThA9KpGUrYaGYh+
 mZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719229766; x=1719834566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M/IuSOve3u0jM9/Cb3Oqv1LmbJtnbSsnEWtEv6MuWg8=;
 b=HxzHBhfjNiMXe227T0rFRA7azQUFmv3b26iZR40ONENChBTkeYllQF2DdoqLnzsI3p
 +GP+m7p9pa+aamflGm+XXTtFKXO/Y1UFgMu4MWkaNIUKEQfhKhdjbbMdFKv44WTIdk42
 c84qVqh4P0gAU6II0AN4TZYWjYgZYuuanqkvgWaiTKZXWRYqnQcgUtYd8JdggJASqRIL
 Sb94t/kHmraYQ/BVQ5WzImjQVukLoaPAAzPTCVk/fI2lTDEhF1ZnC+AKIOb4qdqB6cbd
 ebsld6uFmMNTZ0wZH2/Cbb1ljM7x9pxR8BuBJsmOEsFyUXlcwZiCgfmJmtt4eTWWdgoO
 3Lvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB9ZDiqVeGqoQa6gW34HUYDEHrBBdf34dh7725pxJh9u5QXuYbkKiT0GlhxzBKBRNsihG8kPzRS48+aGI/IwA2CqplQ4axa5324EwxBw==
X-Gm-Message-State: AOJu0YxCv19gbf8B3XvTmdXATvied2KSEmC8MoGot/vOURrQayGI8U9Z
 PoIB0b7j2KcZEzWSkYjmjxVhTng8MJyJfRkpRlYFjxFd/Jw86UPJ
X-Google-Smtp-Source: AGHT+IHoimd7DvYDRQc8sjU0VSYIQthmV1NgIE04cpdVwdtic2w0yFvJYGFLEEyKim7wq4+T0X9r3w==
X-Received: by 2002:adf:f54f:0:b0:362:ac86:4903 with SMTP id
 ffacd0b85a97d-366e7a38f1emr3906951f8f.42.1719229766010; 
 Mon, 24 Jun 2024 04:49:26 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f6ac2sm9964912f8f.76.2024.06.24.04.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 04:49:25 -0700 (PDT)
Message-ID: <543fd667-6e91-4efb-b3e2-49d0c9a5c467@gmail.com>
Date: Mon, 24 Jun 2024 13:49:22 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ddc93078-bebc-4414-b6c9-07e01d663838@amd.com>
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

Am 24.06.24 um 11:52 schrieb Lazar, Lijo:
>
> On 6/24/2024 3:08 PM, Christian König wrote:
>> Am 24.06.24 um 08:34 schrieb Lazar, Lijo:
>>> On 6/24/2024 12:01 PM, Vignesh Chander wrote:
>>>> correctly handle the case when trylock fails when gpu is
>>>> about to be reset by dropping the request instead of using mmio
>>>>
>>>> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
>>> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++----------
>>>>    1 file changed, 21 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index a7ce8280b17ce7..3cfd24699d691d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -613,10 +613,11 @@ uint32_t amdgpu_device_rreg(struct
>>>> amdgpu_device *adev,
>>>>          if ((reg * 4) < adev->rmmio_size) {
>>>>            if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>> -            amdgpu_sriov_runtime(adev) &&
>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>> -            ret = amdgpu_kiq_rreg(adev, reg, 0);
>>>> -            up_read(&adev->reset_domain->sem);
>>>> +            amdgpu_sriov_runtime(adev) {
>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>> +                ret = amdgpu_kiq_rreg(adev, reg, 0);
>>>> +                up_read(&adev->reset_domain->sem);
>>>> +            }
>> What has actually changed here? As far as I can see that isn't
>> functionally different to the existing code.
>>
> In earlier logic, if it fails to get the lock, it takes the 'else' path.
> The 'else' path is not meant for sriov/vf.

Yeah, but the read or write is then just silently dropped.

That can't be correct either.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>>>            } else {
>>>>                ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
>>>>            }
>>>> @@ -681,10 +682,11 @@ uint32_t amdgpu_device_xcc_rreg(struct
>>>> amdgpu_device *adev,
>>>>                                 &rlcg_flag)) {
>>>>                ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag,
>>>> GET_INST(GC, xcc_id));
>>>>            } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>> -            amdgpu_sriov_runtime(adev) &&
>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>> -            ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>>>> -            up_read(&adev->reset_domain->sem);
>>>> +            amdgpu_sriov_runtime(adev) {
>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>> +                ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>>>> +                up_read(&adev->reset_domain->sem);
>>>> +            }
>>>>            } else {
>>>>                ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
>>>>            }
>>>> @@ -740,10 +742,11 @@ void amdgpu_device_wreg(struct amdgpu_device
>>>> *adev,
>>>>          if ((reg * 4) < adev->rmmio_size) {
>>>>            if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>> -            amdgpu_sriov_runtime(adev) &&
>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>> -            amdgpu_kiq_wreg(adev, reg, v, 0);
>>>> -            up_read(&adev->reset_domain->sem);
>>>> +            amdgpu_sriov_runtime(adev) {
>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>> +                amdgpu_kiq_wreg(adev, reg, v, 0);
>>>> +                up_read(&adev->reset_domain->sem);
>>>> +            }
>>>>            } else {
>>>>                writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>>>>            }
>>>> @@ -812,11 +815,12 @@ void amdgpu_device_xcc_wreg(struct
>>>> amdgpu_device *adev,
>>>>                                 &rlcg_flag)) {
>>>>                amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag,
>>>> GET_INST(GC, xcc_id));
>>>>            } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>> -            amdgpu_sriov_runtime(adev) &&
>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>> -            amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>>>> -            up_read(&adev->reset_domain->sem);
>>>> -        } else {
>>>> +            amdgpu_sriov_runtime(adev) {
>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>> +                amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>>>> +                up_read(&adev->reset_domain->sem);
>>>> +            }
>>>> +            } else {
>>>>                writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>>>>            }
>>>>        } else {

