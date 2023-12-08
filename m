Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527A4C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 13:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938FB10E1BE;
	Fri,  8 Dec 2023 13:24:26 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08EA10E1BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 13:24:24 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3334a701cbbso2125881f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Dec 2023 05:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702041863; x=1702646663; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZOcLPk4rPX3jDSIw82dL6cO5sH5pCmGSDNWWXhAuILo=;
 b=jSeAQXy0KPn3pTDKGGC2kZC+yeZ8C8GtBtJ0078M/4eZczdjaFEdSQGGBWjDcdKULN
 NvhbflCawPpt/sKqk0oUqwzstuQvC8DKiVpVKwfw4O4P1eqC4ehLarMe7zb70Fv20gRV
 T3203O2dmZLePMUBtP3R4aKtK4v391lkrEAEypy281w+BoLVcpoCLyfoMjJfRV/kvX+9
 Nz3Tm2bMJBUVM0VgIxIobR8fmUtvGndNeGnjHpQaLNQhzIBRur7wGk0qiytT+KiM5ggC
 4kq/S1kvWTZDLjWL/7IuPjh7QVTqfctwg59N1nAazHNU7dEi5LDP0gnRIBT/eiEMnzhH
 YekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702041863; x=1702646663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZOcLPk4rPX3jDSIw82dL6cO5sH5pCmGSDNWWXhAuILo=;
 b=fLfZsdIBffLUzlOhn/ykRaoWbm0kavlFiRBYyYE1uPsyaWzJLdpdCGOHdwJVwcBq4k
 nHArq1V9yl8N2/+eZwa+DFI4j/nNjNDLUsmaUU2YtfA84OlTLknSM41t2yy8wI98JHVb
 JeQT8HnwQPVGLoPrst0LPJOGtSEVbuSTdvoaCFsxgRVxMhAPTB5bgxkAV2/rCnY2fdpl
 Zaptw01gUWQp6S6YkENFmUtjFAkOG+C6su4XA4zFxbKnGrxT8Dp9JsgHVy/x79lpilIW
 tHBqCFjJptYFiuyL/hXklT78asQsHp0R7u+PE3IWYny0nP4cXo05oJsFcwVzEljyO3DK
 Xdyw==
X-Gm-Message-State: AOJu0YyxcyuEfPKgBcYoqwPwHt+R0hfVzHNmKgDrYdDs28AlLCos00JC
 ju6O2T5bjMNrpnck/CJzAfI=
X-Google-Smtp-Source: AGHT+IHjfPN7AMcvUdy92ta2xRqlfEIEqA+XcRQ9FVOIS1pOxqJD/5NwJBbNjmLe4ao6d/yTy6ZuCQ==
X-Received: by 2002:a5d:6242:0:b0:333:3c06:b433 with SMTP id
 m2-20020a5d6242000000b003333c06b433mr16389wrv.0.1702041862796; 
 Fri, 08 Dec 2023 05:24:22 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a5d5192000000b0033339027c89sm2023394wrv.108.2023.12.08.05.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 05:24:22 -0800 (PST)
Message-ID: <84229452-a063-46d2-bc04-46c38b2911ff@gmail.com>
Date: Fri, 8 Dec 2023 14:24:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/debugfs: fix error code when smc register
 accessors are NULL
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20231127223234.891204-1-alexander.deucher@amd.com>
 <CADnq5_OpHe527RoVPzgyj_TOw+RT=dZnfmfB7TGWD=8Zzt10cQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_OpHe527RoVPzgyj_TOw+RT=dZnfmfB7TGWD=8Zzt10cQ@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The second patch never made it into my inbox, but the first one is 
Reviewed-by: Christian König <christian.koenig@amd.com>.

Christian.

Am 07.12.23 um 18:39 schrieb Alex Deucher:
> Ping on this series?
>
> Alex
>
> On Mon, Nov 27, 2023 at 5:52 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>> Should be -EOPNOTSUPP.
>>
>> Fixes: 5104fdf50d32 ("drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL")
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 0e61ebdb3f3e..8d4a3ff65c18 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -755,7 +755,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>>          int r;
>>
>>          if (!adev->smc_rreg)
>> -               return -EPERM;
>> +               return -EOPNOTSUPP;
>>
>>          if (size & 0x3 || *pos & 0x3)
>>                  return -EINVAL;
>> @@ -814,7 +814,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
>>          int r;
>>
>>          if (!adev->smc_wreg)
>> -               return -EPERM;
>> +               return -EOPNOTSUPP;
>>
>>          if (size & 0x3 || *pos & 0x3)
>>                  return -EINVAL;
>> --
>> 2.42.0
>>

