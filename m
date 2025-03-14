Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078D0C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 14:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9D410E9FC;
	Fri, 14 Mar 2025 14:20:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GCzHWJZ3";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1643B10E9FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 14:20:08 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so20862615e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741962006; x=1742566806; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Si10sBfN43oEKtQmHtIx6jOa50ffyn80dW5QWGKBzVE=;
 b=GCzHWJZ3IYgPugDGfsdDZlJ0bDANYy0WNFmh8KNtHa4FwsTnRA2yI16TpDyf6efaX6
 ds/+fMFDVSkGf1n8C5XlIUOGZ7+qQwKltB9ABtOx3+tMubWYL/oWYkHZz9/+ux5hIEOS
 rFDDDiXdh6+jxg3hNZsTeWMeaP5TR57Ci6R21k8BG7mKN/V1YXfhc3FxWbo2h2i06id+
 Wk0R3B8rG+BAUxCulCVGETfainvKt0RcgK5t/fDjKh5plhW4bsE1BAXw73RiG/jaD7qe
 obvXiCE7sxk0V8Y3tBZHeMZHHvH0dtvddNEQhTgXMbRoijGRuw+cgKBBlmGjJiN6ahEz
 ddMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741962006; x=1742566806;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Si10sBfN43oEKtQmHtIx6jOa50ffyn80dW5QWGKBzVE=;
 b=hpEwMPLRb3I4mcTRCKaRlmQYdT7JjfrWa3I35KvKNV5w+et3rHRQvdJPHPDV9g9Zkn
 3apcOv9Sz5q8anGKj1v4E+7+OqEexp82qnmvSHBN+M0MaspWtDasuSGfVMzLMLTOeFku
 yG65tP5Z5iX4p9DvmhoqzU5CxFcV3ag/QxfZ6uS6hXW3A6bAX3+AhdjxPDvtuqB89WOs
 2lLFUak+/KyuwcVP/ceDv8b2/cj0po7nblzvK+JiwDgI8TkJpXL7YPGoBAHAhJMIeDkQ
 v5KM8eK6pMS/iFkd4lZ7EAi798tNmSrIm0fjo0OeR4tTdM8xLsxauZ494aQeqDujNlCc
 0JCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQniXh8FoOifrsGqONtdD6l0Nmatfvxpv9RP5VO5XcPjenqVgYhqRLZd4IbiHoZbTN3DJt308+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHtGIou60v+m8U0OJXBRxq/3nHxrR6DpQAQPxGPqd2C9LMg/Mo
 crtvT+I613L7AlnxleWcIh+WoHE89wF5ExnWFCAAS4zepkAA2pYF
X-Gm-Gg: ASbGncvwdB26B54s+dw8p7Us5T+s1IhQHpZ6hIC3fkYA0s0FK8jWCZS5UgbFpY99wCW
 ikSwGrmZ7ad5I5JVzn3DhzLNmMUQDMkXillz/6sUsMBeypd6DMQAF5S5i9Ow2ySHDrtAKu32Nii
 yO4a2WWepqrN4R61w8GOhRLzsC1V8RiREudPvCdZR5FPsQqpElsXOo8SjDdA+C2pHlje5aBf0/7
 JuTWF1SZbpbyW/fJbn2LH67m3+iZZIuaj2XnZSDGyr65YrbUOxq4Qp/Su022YcFUXsPHBqEqzue
 icde+G/nRBJ8NCiqx/aLyIjO5tmdE9LFQwChESLY68pjPn8qEDduyc2KRF9TIPKz3KRkl6Ktpg=
 =
X-Google-Smtp-Source: AGHT+IG3BPT0UDg5Vl3dEA4+v2wjwLMNE4k0IOqUDtuTA/8utboc7AlG2g5yXh2VprIa/cQxobe4VQ==
X-Received: by 2002:a05:600c:458e:b0:43c:fffc:787b with SMTP id
 5b1f17b1804b1-43d1ec84d93mr35616005e9.12.1741962006031; 
 Fri, 14 Mar 2025 07:20:06 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda15dsm19366695e9.3.2025.03.14.07.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 07:20:05 -0700 (PDT)
Message-ID: <ff0378be-671c-4c60-8086-03fb4c21bc0b@gmail.com>
Date: Fri, 14 Mar 2025 15:20:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgpu: grab an additional reference on the gang
 fence v2
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250307134816.1422-1-christian.koenig@amd.com>
 <de0e6edc-c3a8-4c9f-b0f3-37cfd8776db5@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <de0e6edc-c3a8-4c9f-b0f3-37cfd8776db5@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Am 14.03.25 um 05:09 schrieb SRINIVASAN SHANMUGAM:
>
> On 3/7/2025 7:18 PM, Christian König wrote:
>> We keep the gang submission fence around in adev, make sure that it
>> stays alive.
>>
>> v2: fix memory leak on retry
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 198d29faa754..337543ec615c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -6889,18 +6889,26 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>>   {
>>       struct dma_fence *old = NULL;
>>   +    dma_fence_get(gang);
>>       do {
>>           dma_fence_put(old);
>>           old = amdgpu_device_get_gang(adev);
>>           if (old == gang)
>>               break;
>>   -        if (!dma_fence_is_signaled(old))
>> +        if (!dma_fence_is_signaled(old)) {
>
> Here, should we need to check ?

The gang is initialized to a dummy fence on bootup. So even when there is never any gang submission the old value is never NULL.

Regards,
Christian.

>
>     // Check if old fence isn't signaled
>     if (old && !dma_fence_is_signaled(old)) {
>
>> +            dma_fence_put(gang);
>>               return old;
>> +        }
>>         } while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
>>                old, gang) != old);
>>   +    /*
>> +     * Drop it once for the exchanged reference in adev and once for the
>> +     * thread local reference acquired in amdgpu_device_get_gang().
>> +     */
>> +    dma_fence_put(old);
>
> if (old)
>     dma_fence_put(old); // Ensure to release old reference  only if it is valid?
>
>
>>       dma_fence_put(old);
>>       return NULL;
>>   }

