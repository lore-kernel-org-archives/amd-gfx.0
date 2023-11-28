Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9411EC4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Nov 2023 13:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B26010E519;
	Tue, 28 Nov 2023 13:18:45 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF19310E52A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 13:18:42 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-332c0c32d19so3761753f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701177521; x=1701782321; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fg3y8uj57KjPJzryTOjkfBNZcZnHKXJovwZNF9HthYE=;
 b=TzRzc+CSjhC4w1KeyCh2QLgonTlOEoqbMoVmHfvcz+0weOeucFuY+viiLzLaVDxTV0
 7L5SbrxL7I/kj99Vxxji7UJTpmslIoyTzlbULM4mGFjKfOqMCdOROHKpeaqvxUJ6+qdX
 L1JM9eGbNCcgxBXvTE7dRBULWijCUBlkb3Y6HRuh9ndPnPxFPO57+LPOl7WnD+DYJy9H
 EhnPx3pqoYOXZV8w59Ry20UuTPVJHHgrIDtUPLrqLy7n0tvb1yT4wiAVsdajuKr5+ZC7
 xIwampfRzWUjG3LXaQmf9DWGUdfz9tzjVKtYVn3jl5J7hY4ce5HnEtbrWU7YowoYtWTo
 W7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701177521; x=1701782321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fg3y8uj57KjPJzryTOjkfBNZcZnHKXJovwZNF9HthYE=;
 b=OOUJJ8ntm0n5OaEOuN1AkKT99cITcAB0XNrJM1p6Ix+61LbMA4I0sMY9aPwSCbiohb
 5BA0MA8Y09V6NBpM8to/YNWYm2Adbr6di/zZZZpRLvqzvVxX1inJbTjQnvHJQ3ibOM1S
 HM9xactQPDKEZaDAWsRdT7DNxI6ZYT/oQLlJ+xnPYq1lafwcyNwRK0FUOSjt6I46N3n2
 +21b/Rhj7uhMKf1Iuvqtw5vedSY8xwa3DUFABD5O+c9X2MYskdfj7y6Yv8lylKCaNJ+N
 I5HUMtIuV2yuc0XLrDSFDrnd4mXRFmW1Uz+UnHdZBK9iR/fuvY9OJGp56r/2aWTVKGtz
 2Klg==
X-Gm-Message-State: AOJu0YxssAVnPaipexnkeqcoaQPrb+LVd1QxYjrTK5AHFkfgM6h9VbHg
 ZLhZZxy6C42EYJ2lQWnwGR6XJ+loWtk=
X-Google-Smtp-Source: AGHT+IE75A360j/tbucbzjADH+JaFxh2uL72fCf8BbPUmmrKjS21McqJ/PhDehgADAyxiTx8dUnfhQ==
X-Received: by 2002:a5d:4b88:0:b0:332:cb97:2cbf with SMTP id
 b8-20020a5d4b88000000b00332cb972cbfmr9720788wrt.24.1701177520881; 
 Tue, 28 Nov 2023 05:18:40 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 a2-20020adff7c2000000b003258934a4bcsm12029650wrq.42.2023.11.28.05.18.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 05:18:40 -0800 (PST)
Message-ID: <4664a573-da9a-4d48-bee7-4b2bef3081b6@gmail.com>
Date: Tue, 28 Nov 2023 14:18:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix uninitialized return value
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20231127182945.1109556-1-lijo.lazar@amd.com>
 <ac4bc87d-7ae1-45d3-8f85-0e294289ad3a@gmail.com>
 <CADnq5_NA0fi8cGvrSzCtmtsWpgKhaG4O8T6cW+ObJoCm=iwzSQ@mail.gmail.com>
 <1c1877d8-c062-4648-950b-4e05f568b356@gmail.com>
 <a61886fc-358c-4f89-961d-8145f70d31ee@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <a61886fc-358c-4f89-961d-8145f70d31ee@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.11.23 um 10:49 schrieb Lazar, Lijo:
>
> On 11/28/2023 3:07 PM, Christian König wrote:
>> Am 27.11.23 um 22:55 schrieb Alex Deucher:
>>> On Mon, Nov 27, 2023 at 2:22 PM Christian König
>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>> Am 27.11.23 um 19:29 schrieb Lijo Lazar:
>>>>> The return value is uniinitialized if ras context is NULL.
>>>>>
>>>>> Fixes: 0f4c8faa043c (drm/amdgpu: Move mca debug mode decision to ras)
>>>>>
>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>> index 1a8668a63e67..f6b47ebce9d6 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>> @@ -3410,7 +3410,7 @@ int amdgpu_ras_reset_gpu(struct 
>>>>> amdgpu_device *adev)
>>>>>    int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, 
>>>>> bool enable)
>>>>>    {
>>>>>        struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>>>> -     int ret;
>>>>> +     int ret = 0;
>>>> That's usually considered very bad coding style and complained 
>>>> about by
>>>> automated checkers.
>>>>
>>>> Instead explicitly set the return value in the code paths not actually
>>>> setting it.
>>> In this case, the function is so short, I think it makes things less
>>> readable to do that.
>>
>> Yeah, indeed but that doesn't help us with the coding style checkers.
>
> Are these checkers for real? I see many instances of variable 
> initialization including in core kernel code (ex: workqueue) code.

Yes, I've got multiple complains about that already.

What people basically seem to do is to search for patterns like "int ret 
= 0;... ret = whatever();.. return ret;" with cocci.

This then results in a note that an initialization isn't necessary and 
should be avoided.

Same for things like return after else, e.g. when you have something 
like this "if (...) { ret = whatever(); if (ret) return ret; } else { 
... ret = 0;} return ret;".

Regards,
Christian.

>
> Thanks
>
> Lijo
>
>>
>> We could do something like this instead:
>>
>> if (!con)
>>     return 0;
>>
>> ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
>> ...
>>
>> Regards,
>> Christian.
>>
>>>
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>        if (con) {
>>>>>                ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
>>

