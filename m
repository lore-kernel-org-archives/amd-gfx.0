Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DB6C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Nov 2023 09:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B50D89119;
	Tue, 28 Nov 2023 09:37:43 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B31B10E46B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 09:37:41 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40b472f98b1so13228205e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701164260; x=1701769060; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ow3aTcyCgAuJHVBk2AClWfz6hHvEGg27QnRfveSG98Y=;
 b=gd1MGzjWnPYZFLmRjPugf2goKwnK8rVsIVlSE5n27ETzwDpmbJ7m+SFoLJqcRhxWLC
 ndVCNnjBDYF/mkmq7mKN+syjQINtKL0MVG2lnSiHtnZo/7DTjWgSWay/57sAz0S7H+bt
 nueEZ/ycAWDr/i7oxAIRRYiDKUXd6391HCSNaMjOmJb+seuECXmb/N9QIQIkeURzFYoj
 mZdirrMASZGrmn5VYvfs5DD/+tkmt2IBrGUrU9+XfoSvTUo9UIhvajQYFiqZIyf2523S
 b5xSxE9TfzMx2AXqEGIiXdG21a/tJuxnTDAnUtCGGAeG6y3mwed3ucjiInSIKq0pKVP9
 4l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701164260; x=1701769060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ow3aTcyCgAuJHVBk2AClWfz6hHvEGg27QnRfveSG98Y=;
 b=X2i05SY/CX3mf37fbNIe03LmvtzGl4d1faz7y9vtg1UccnYr6SCmtXj+4wihcvBwmT
 fI/cPqAkTuCZerHvCad3t1wP7554u0hhbWJwapRSTAe8N4W6cDLAxQtqKZUQZN/O1+Zn
 n3EC68Q0V5nnq8N9Rcuzi79WojHlHWd5gZSx5u9cucoqRJ1v7uJ1LXRkyJkK6U20n2x+
 ImFmf0haduwmj4qGq4NvqfO2JGxiGbgYVQ0DzQc4ofd61krqVMVdkgSz4iUs6PiRCuUn
 8hNYbLqTulsTCdt198ABcPd/bSOX1QbFvkyY8A212F4x7PdYdLmaZyO9qDR+b+54t596
 z5rw==
X-Gm-Message-State: AOJu0YyRdLmtT2VLOM5PE9LtMsZ6FTuUzejaFOEmPBpvDpROofp+tRKV
 Iv6IMRJMv/ZognmHwh8fDtk=
X-Google-Smtp-Source: AGHT+IFt2loKvqx3mSN7g5gFZbRLQaVWt/SbjSjh35eurO2sFxC+i26YWnu1qOZnGBEoA3d07GCycQ==
X-Received: by 2002:a05:600c:3b0c:b0:40a:6235:e82d with SMTP id
 m12-20020a05600c3b0c00b0040a6235e82dmr10389263wms.15.1701164259568; 
 Tue, 28 Nov 2023 01:37:39 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 fa20-20020a05600c519400b0040b3e26872dsm11809863wmb.8.2023.11.28.01.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 01:37:39 -0800 (PST)
Message-ID: <1c1877d8-c062-4648-950b-4e05f568b356@gmail.com>
Date: Tue, 28 Nov 2023 10:37:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix uninitialized return value
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20231127182945.1109556-1-lijo.lazar@amd.com>
 <ac4bc87d-7ae1-45d3-8f85-0e294289ad3a@gmail.com>
 <CADnq5_NA0fi8cGvrSzCtmtsWpgKhaG4O8T6cW+ObJoCm=iwzSQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_NA0fi8cGvrSzCtmtsWpgKhaG4O8T6cW+ObJoCm=iwzSQ@mail.gmail.com>
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
Cc: Alexander.Deucher@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.11.23 um 22:55 schrieb Alex Deucher:
> On Mon, Nov 27, 2023 at 2:22 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 27.11.23 um 19:29 schrieb Lijo Lazar:
>>> The return value is uniinitialized if ras context is NULL.
>>>
>>> Fixes: 0f4c8faa043c (drm/amdgpu: Move mca debug mode decision to ras)
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> index 1a8668a63e67..f6b47ebce9d6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> @@ -3410,7 +3410,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
>>>    int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
>>>    {
>>>        struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>> -     int ret;
>>> +     int ret = 0;
>> That's usually considered very bad coding style and complained about by
>> automated checkers.
>>
>> Instead explicitly set the return value in the code paths not actually
>> setting it.
> In this case, the function is so short, I think it makes things less
> readable to do that.

Yeah, indeed but that doesn't help us with the coding style checkers.

We could do something like this instead:

if (!con)
     return 0;

ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
...

Regards,
Christian.

>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
>> Regards,
>> Christian.
>>
>>>        if (con) {
>>>                ret = amdgpu_mca_smu_set_debug_mode(adev, enable);

