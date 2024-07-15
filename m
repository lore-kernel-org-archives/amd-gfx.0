Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCE7C3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 15:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 879DC10E42C;
	Mon, 15 Jul 2024 15:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NuNTAC+S";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D03EE10E415
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 15:30:30 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3678aa359b7so3331567f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721057429; x=1721662229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2WdKTxYlmE86q+32t7HCDEeSeWZlJZIPdimvsP/UG74=;
 b=NuNTAC+SvzJxFhYukayDFw9HW9Eb+m0TBv5hu5Sv+qkD7YQ3cDpH7LYmvXt/ubenXN
 IL1eq0DBEkHE+MrrLJnJcM70AdwqIMgHvCVBF4ZCbXR+86OlrsehC1m+y/j03LpUAeGG
 8HLcLQ4WJF6qSi6cvUA2hQrumzhrT9FEmERcmIGYr7i5E5LmIzY/W+jjwPOi0wDzU7da
 KOGaFVLNdnogC+HL7yOzVwjnPgcQP6N0TXRWZq5i/QE291hypVpB27z2N3Ac7hltuGlq
 +nPak5azW7as+oU7zntC0CbrYrcveMMSc+uDLSkVLQw8QiWLLvjhVR40OXht8yylX7uP
 fIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721057429; x=1721662229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2WdKTxYlmE86q+32t7HCDEeSeWZlJZIPdimvsP/UG74=;
 b=BZzMh+HFfmRKZefeTBrzyqUohJJxZfDHXMy5OJ99I8tqSZubbnHEszazBNkFA/706F
 OvYx9d1x6p/9lRGPMy3qAMgatid4G6b2T7FcPfq7lcaL4477UIRi6J+DJ6OpMYuvShbn
 rAlabi5UVNN7cokzN05w5yfZvcTfGVHld5Fcs8Of4KHXO99sDKRrGi8i7S1viUe/yvTU
 DTKie//Y+Di3mUOla2e7/aVqAYCLC+wvEMHQ6xiVoY32T510WQJJHfECygligQd10MfZ
 GaPcT3v3Nlv4h6oaS3bSQWMT/XZ2Jjhx0XLzVZF0hGbIl/7wsO226qHa9DzEN1/4gWbD
 Xd5A==
X-Gm-Message-State: AOJu0YwQnHQAXl6vJWLazoo+ts/hiYEE3o0bfOpa9LyuZxpV1eNtDhSV
 nA3h5TAvMWWCmzFljZ6VlmliYV2EyzMLBTT8lWSQVXAUGL6ztc9cRBRIlQ==
X-Google-Smtp-Source: AGHT+IHDqSZXicoC5DX1M5VqsihwSVc/se6x4e6uZoqCjUfb5A23TtSmZoYDY7zxNQKXEa7WuZ2egw==
X-Received: by 2002:a5d:6dc4:0:b0:367:895f:619e with SMTP id
 ffacd0b85a97d-367ff6edd0amr8340254f8f.11.1721057428655; 
 Mon, 15 Jul 2024 08:30:28 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3e71sm6710245f8f.12.2024.07.15.08.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 08:30:28 -0700 (PDT)
Message-ID: <d9d079fe-3368-4a58-b5af-2ae1f6b2b5f7@gmail.com>
Date: Mon, 15 Jul 2024 17:30:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add empty HDP flush function to JPEG
 v4.0.3
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Jane Jian <Jane.Jian@amd.com>,
 Haijun.Chang@amd.com, Victor.Zhao@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240715144748.168556-1-Jane.Jian@amd.com>
 <cf9dc5a2-39d1-4973-b06b-6b791f6298b6@gmail.com>
 <ac0f50d7-9133-45ac-8ba3-cd8567963f61@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ac0f50d7-9133-45ac-8ba3-cd8567963f61@amd.com>
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

Am 15.07.24 um 17:08 schrieb Lazar, Lijo:
>
> On 7/15/2024 8:28 PM, Christian König wrote:
>>
>> Am 15.07.24 um 16:47 schrieb Jane Jian:
>>> From: Lijo Lazar <lijo.lazar@amd.com>
>>>
>>> JPEG v4.0.3 doesn't support HDP flush when RRMT is enabled. Instead,
>>> mmsch fw will do the flush.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> index 04d8966423de..ea601047dab0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> @@ -621,6 +621,14 @@ static uint64_t
>>> jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
>>>                ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
>>>    }
>>>    +static void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>> +{
>>> +    /* VCN engine access for HDP flush doesn't work when RRMT is
>>> enabled.
>>> +     * This is a workaround to avoid any HDP flush through VCN ring.
>>> Instead
>>> +     * HDP flush will be done by driver while submitting doorbell.
>> I think that should read "HDP flush will be done by firmware ....".
>>
>> Or is it really the driver which should do this? In this case the patch
>> here would be wrong.
>>
> That's a copy-paste mistake. This comment was originally in the initial
> version of the patch.

Yeah thought so.

> Discussed with Jane and she'll be sending a revised version. Also, there
> is a third patch expected which does normalization of register offsets
> when submitted through ring.

Another question is if we have ever released JPEG/VCN firmware which 
doesn't do the flush?

If yes then we need a version check here to provide backward 
compatibility with already released firmware.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>> +     */
>>> +}
>>> +
>>>    /**
>>>     * jpeg_v4_0_3_dec_ring_set_wptr - set write pointer
>>>     *
>>> @@ -1072,6 +1080,7 @@ static const struct amdgpu_ring_funcs
>>> jpeg_v4_0_3_dec_ring_vm_funcs = {
>>>        .emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
>>>        .emit_fence = jpeg_v4_0_3_dec_ring_emit_fence,
>>>        .emit_vm_flush = jpeg_v4_0_3_dec_ring_emit_vm_flush,
>>> +    .emit_hdp_flush = jpeg_v4_0_3_ring_emit_hdp_flush,
>>>        .test_ring = amdgpu_jpeg_dec_ring_test_ring,
>>>        .test_ib = amdgpu_jpeg_dec_ring_test_ib,
>>>        .insert_nop = jpeg_v4_0_3_dec_ring_nop,

