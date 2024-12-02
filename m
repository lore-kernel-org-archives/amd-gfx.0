Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B65E69E81
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 19:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A9CD10E819;
	Mon,  2 Dec 2024 19:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ghqdTSJt";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAA310E819
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 19:19:50 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-434a14d6bf4so42169975e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Dec 2024 11:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733167189; x=1733771989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzKZZMnme43U9yomWVvVD3AriDhZGyNqkQ9qAhBwBdc=;
 b=ghqdTSJtbQpwzX47BnIUzVi8CWyxe8thvmqnkmAwrdiR7YlzBhGJImKlekFHj1WKMX
 eqNOVf5RJhmJIFt3Vv9JeZNx57M8efuPJkizhmEbNA9W5SHthia/oPZhBSSBEFehUJvh
 8JGBG6UMFMJYfaq6QWMExflK1vf468DGZWEjfVFjlEMc+XR20+4s9r56BAPuSXSd5lpi
 IPV8xPs0ihz1js/oI9YYlXT/PlRI2fDUr3LBKaM3hSrVUcUjuitBFwmYZ5U6fgVa9EH9
 SFZZSNHtPdnbqDzldjTHTuMMdE/j1YLAhucjy6lY2gGafG6UAwrI5cUZx9wpbyTqpzvf
 rEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733167189; x=1733771989;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qzKZZMnme43U9yomWVvVD3AriDhZGyNqkQ9qAhBwBdc=;
 b=Ot09EBcCF/dEJYcixxSI9qbxL48DYZlzdJ1G2N9ENA78RTG0fdhC3z8xsUJIpH/dA3
 0kpi/YVDLyBSCR+nydE+uiKlCByJWF45jhL6EiW1nk+nb6HHlvhTD+ThlhWpOjyOMUpz
 Mwi5ha7heQ3pmGyJeoCZwb3TtcPFmG8UXU89uJoP2nhjkOkohazBat8cOqsz9oPRXESF
 DfLT4LPdowLFGpWD3ioYn6GdnsIiYM47FS/j2Hbjxs5CVMlMbsXzSuvUw6S6RvTzMqqi
 n374HAS38pWHXo3Rv/PChSIO3ez+oXX7UcnhgTj9TywodPTp+LU4xbt0eSFa5ju+G+qY
 2QMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSfAr/UVQC8SkVxgJ7PyhF7rBG/V7CCHYmZMKx5LOpMZgCwuncp7Iggu6Zzs3NsySGME7Y8YLQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+SGVeKl1mHjTwUff/vOpe4auhWQl53F4qssTpfAOAOCekADRx
 bTO+2ddxilH3/kuyDLDf0A4hT1AP2sLKVSfnxcyPtZ8mIEqhSGRhv7Qh6g==
X-Gm-Gg: ASbGnctRj8diaUf2JyGKR6MEv/ALjUK4DAGvEGU2yNykscC/88FWla9WiIPeIhvHZmN
 ASfuf3VbTpzarO0Eqo3Xu6dH3qcTP9W+Wt2THkeTzufj3/mVzuulTshIpy4F4a+n65dDhajLVsY
 DHBOrWuLyr8oLWHUihrwOh12JnWEAo3T3ZCvz5k5xX754ndiHZZPkReNE1HXvJn5kvZCmEfA4Ds
 a8vT10Z2fq6FqNW8S389N1cSlm1teb580WT1+CIBLUOrxQjFqeQResekFN8p82/Q8iirweau4nH
 QdQ=
X-Google-Smtp-Source: AGHT+IFZ3e042qsx06+ExUIVWHq1eFe0UCYFeFCTKnqpgD86uc4SaMUVspG+WjOUaeTWhoOZqeoUUg==
X-Received: by 2002:a05:6000:280b:b0:385:ee59:4500 with SMTP id
 ffacd0b85a97d-385ee59479cmr4021574f8f.39.1733167188396; 
 Mon, 02 Dec 2024 11:19:48 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385f343f293sm3344849f8f.36.2024.12.02.11.19.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 11:19:47 -0800 (PST)
Message-ID: <1f65b7d2-7e4f-48ef-ade1-bdd3f2edb8ad@gmail.com>
Date: Mon, 2 Dec 2024 20:19:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: rework resume handling for display (v2)
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241202165237.971604-1-alexander.deucher@amd.com>
 <c8bb8b47-314c-402e-87bb-3641b63eb6f7@gmail.com>
Content-Language: en-US
In-Reply-To: <c8bb8b47-314c-402e-87bb-3641b63eb6f7@gmail.com>
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

Am 02.12.24 um 20:18 schrieb Christian König:
> Am 02.12.24 um 17:52 schrieb Alex Deucher:
>> Split resume into a 3rd step to handle displays when DCC is
>> enabled on DCN 4.0.1.  Move display after the buffer funcs
>> have been re-enabled so that the GPU will do the move and
>> properly set the DCC metadata for DCN.

BTW: We might want to add a WARN_ON() to the CPU copy path to make sure 
that we don't try to copy DCC buffers while the SDMA is turned off.

Christian.

>>
>> v2: fix fence irq resume ordering
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 +++++++++++++++++++++-
>>   1 file changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 2a25e0742f8e7..d882d46de1416 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3764,7 +3764,7 @@ static int 
>> amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
>>    *
>>    * @adev: amdgpu_device pointer
>>    *
>> - * First resume function for hardware IPs.  The list of all the 
>> hardware
>> + * Second resume function for hardware IPs.  The list of all the 
>> hardware
>>    * IPs that make up the asic is walked and the resume callbacks are 
>> run for
>>    * all blocks except COMMON, GMC, and IH.  resume puts the hardware 
>> into a
>>    * functional state after a suspend and updates the software state as
>> @@ -3782,6 +3782,7 @@ static int 
>> amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>>           if (adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_COMMON ||
>>               adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_GMC ||
>>               adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_IH ||
>> +            adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_DCE ||
>>               adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
>>               continue;
>>           r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
>> @@ -3792,6 +3793,36 @@ static int 
>> amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>>       return 0;
>>   }
>>   +/**
>> + * amdgpu_device_ip_resume_phase3 - run resume for hardware IPs
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Third resume function for hardware IPs.  The list of all the 
>> hardware
>> + * IPs that make up the asic is walked and the resume callbacks are 
>> run for
>> + * all DCE.  resume puts the hardware into a functional state after 
>> a suspend
>> + * and updates the software state as necessary.  This function is 
>> also used
>> + * for restoring the GPU after a GPU reset.
>> + *
>> + * Returns 0 on success, negative error code on failure.
>> + */
>> +static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
>> +{
>> +    int i, r;
>> +
>> +    for (i = 0; i < adev->num_ip_blocks; i++) {
>> +        if (!adev->ip_blocks[i].status.valid || 
>> adev->ip_blocks[i].status.hw)
>> +            continue;
>> +        if (adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_DCE) {
>> +            r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
>> +            if (r)
>> +                return r;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * amdgpu_device_ip_resume - run resume for hardware IPs
>>    *
>> @@ -3821,6 +3852,13 @@ static int amdgpu_device_ip_resume(struct 
>> amdgpu_device *adev)
>>       if (adev->mman.buffer_funcs_ring->sched.ready)
>>           amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>   +    if (r)
>> +        return r;
>> +
>> +    amdgpu_fence_driver_hw_init(adev);
>> +
>> +    r = amdgpu_device_ip_resume_phase3(adev);
>> +
>>       return r;
>>   }
>>   @@ -4909,7 +4947,6 @@ int amdgpu_device_resume(struct drm_device 
>> *dev, bool fbcon)
>>           dev_err(adev->dev, "amdgpu_device_ip_resume failed 
>> (%d).\n", r);
>>           goto exit;
>>       }
>> -    amdgpu_fence_driver_hw_init(adev);
>>         if (!adev->in_s0ix) {
>>           r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
>> @@ -5489,6 +5526,10 @@ int amdgpu_device_reinit_after_reset(struct 
>> amdgpu_reset_context *reset_context)
>>                   if (tmp_adev->mman.buffer_funcs_ring->sched.ready)
>> amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
>>   +                r = amdgpu_device_ip_resume_phase3(tmp_adev);
>> +                if (r)
>> +                    goto out;
>> +
>>                   if (vram_lost)
>>                       amdgpu_device_fill_reset_magic(tmp_adev);
>

