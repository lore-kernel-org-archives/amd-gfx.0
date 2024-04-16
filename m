Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB45C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 12:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38DF910F08F;
	Tue, 16 Apr 2024 12:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mX+8msL3";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E63110F08F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 12:54:40 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-34665dd7610so1809676f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713272078; x=1713876878; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KYF1TXJib8sUu+hXNxlc+Zu7+j3dgbW6g6/8gGPgYbQ=;
 b=mX+8msL349ed1DfPSHItIWzsgL5kuvLkUpBz4BSzvNRqRIGNJUt8HzWcW1KtYs78DM
 UIgyuVvxrTJ5qRGvl21G8JNRoSDgToLCbSAfiFSr/rk+vKp0Gzwl7oJNH/Q3pNSkua52
 CF2jyauq9EzOH+godO4qGY/0qUvxysHZ/1CFQ7+LjRgHT+KaFaRzk7uH7s000CqrWa28
 E1Cm/bh1ifEgD4dD6w+MEjh24U1u8eLSRpC1Rog2eBjrz24L27Yso4zCLUze4OzpIet+
 VSZuwYOx4mNhWWzXqX0J0nqXMYBWN2BAMs+JI8n7MYYFagl066NkJkdbq1XHF7FaHRtQ
 6Qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713272078; x=1713876878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KYF1TXJib8sUu+hXNxlc+Zu7+j3dgbW6g6/8gGPgYbQ=;
 b=oKQYbJlEUmJD7A4tlSdHvd09hzyBJ3CaPJFXNA8tZV38Lzop6JD0XdFv0z6X9kI0MF
 UmS8Rt9xJxZ6t3hH+xDAavkPZYCqnGi4BlNiCSwwBVNl3F0kFSvngaecSTBfbhj9B1Q+
 8BLy1P7EB1lVhJ2VwCLPykttSpAMb45U4B1vWV4inmuJCCATk+EhpD6GzQu4DDjzyCLi
 pzZdsrj8Gbe8oczGzLyic1DE44Gxy045to08F9EoCNBaamBAL3yhTCvC9PilEnp48K1X
 cy9s3N90tg08asCFVmiD1ZpxbvV0Y3Sbft3wJuLT2iGiSTPKDjaseI7cL8Uq2CVAXRSk
 6rHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcOzWR38Ac0S/znnQj7zapKfpVfIwi6LRmOVg+9T9PnAxnWmCi5x4SQ09f/WP3vm9qvhFbdqvKV0wHYLe7EAqiBMnVLSTQe/uNx7+vLw==
X-Gm-Message-State: AOJu0YxporrTdUtEM1xn8CxaV9W13DV4OLDcnBs9DLoLeefbLCZ6XkZ3
 ZwoYgoCKgzJ4LeDBqfCTu/5OmcE7TNciHFr/LG8a0zP5eYVMdar2P5KYndN2
X-Google-Smtp-Source: AGHT+IHf/QJ2lxmz/dTfbWQDtIAVTG3RQYw3soM4XeaLrZlbepl9vyupgc5dSArg/tVbnw1ldUB42w==
X-Received: by 2002:a05:6000:178d:b0:341:adf8:23c5 with SMTP id
 e13-20020a056000178d00b00341adf823c5mr10068647wrg.56.1713272077718; 
 Tue, 16 Apr 2024 05:54:37 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 q25-20020a056000137900b003455d32e944sm14691130wrz.96.2024.04.16.05.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 05:54:37 -0700 (PDT)
Message-ID: <4d822dcf-a655-41a4-8d65-42cf2adfbed3@gmail.com>
Date: Tue, 16 Apr 2024 14:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear seq64 memory on free
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240415184837.299965-1-Arunpravin.PaneerSelvam@amd.com>
 <662576a5-4597-4a3e-bead-4b80852eb19c@gmail.com>
 <5383bac8-c097-4975-8022-181d1d2f0877@amd.com>
 <7e532341-cf37-42c9-97e3-41d10e7871e5@amd.com>
 <616481ae-9a79-4800-ab98-d45c7fbc3731@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <616481ae-9a79-4800-ab98-d45c7fbc3731@amd.com>
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

Am 16.04.24 um 14:34 schrieb Paneer Selvam, Arunpravin:
> Hi Christian,
>
> On 4/16/2024 5:47 PM, Christian König wrote:
>> Am 16.04.24 um 14:16 schrieb Paneer Selvam, Arunpravin:
>>> Hi Christian,
>>>
>>> On 4/16/2024 2:35 PM, Christian König wrote:
>>>> Am 15.04.24 um 20:48 schrieb Arunpravin Paneer Selvam:
>>>>> We should clear the memory on free. Otherwise,
>>>>> there is a chance that we will access the previous
>>>>> application data and this would leads to an abnormal
>>>>> behaviour in the current application.
>>>>
>>>> Mhm, I would strongly expect that we initialize the seq number 
>>>> after allocation.
>>>>
>>>> It could be that we also have situations were the correct start 
>>>> value is 0xffffffff or something like that instead.
>>>>
>>>> Why does this matter?
>>> when the user queue A's u64 address (fence address) is allocated to 
>>> the newly created user queue B, we see a problem.
>>> User queue B calls the signal IOCTL which creates a new fence having 
>>> the wptr as the seq number, in
>>> amdgpu_userq_fence_create function we have a check where we are 
>>> comparing the rptr and wptr value (rptr >= wptr).
>>> since the rptr value is read from the u64 address which has the user 
>>> queue A's wptr data, this rptr >= wptr condition
>>> gets satisfied and we are dropping the reference before the actual 
>>> command gets processed in the hardware.
>>> If we clear this u64 value on free, we dont see this problem.
>>
>> Yeah, but that doesn't belongs into the seq64 handling.
>>
>> Instead the code which allocates the seq64 during userqueue created 
>> needs to clear it to 0.
> sure, got it.

Yeah, but fixing that aside. We should probably initialize the seq64 
array to something like 0xdeadbeef or a similar pattern to find issues 
were we forget to initialize the allocated slots.

Regards,
Christian.

>
> Thanks,
> Arun.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Thanks,
>>> Arun.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 6 +++++-
>>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>>>> index 4b9afc4df031..9613992c9804 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>>>> @@ -189,10 +189,14 @@ int amdgpu_seq64_alloc(struct amdgpu_device 
>>>>> *adev, u64 *va, u64 **cpu_addr)
>>>>>   void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
>>>>>   {
>>>>>       unsigned long bit_pos;
>>>>> +    u64 *cpu_addr;
>>>>>         bit_pos = (va - amdgpu_seq64_get_va_base(adev)) / 
>>>>> sizeof(u64);
>>>>> -    if (bit_pos < adev->seq64.num_sem)
>>>>> +    if (bit_pos < adev->seq64.num_sem) {
>>>>> +        cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
>>>>> +        memset(cpu_addr, 0, sizeof(u64));
>>>>>           __clear_bit(bit_pos, adev->seq64.used);
>>>>> +    }
>>>>>   }
>>>>>     /**
>>>>
>>>
>>
>

