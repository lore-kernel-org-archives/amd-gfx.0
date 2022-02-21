Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA23C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 18:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2580A10E22A;
	Mon, 21 Feb 2022 18:15:27 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ECEA10E22A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 18:15:25 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id r13so12311509ejd.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=2p/KTvOdFBZHS2wgaLneSyM/12uTssiSfcmpmu1qWJU=;
 b=GQBMCUgfSDYdENuOttRcxNsk5MAz4nyO3mOdv2dMaUt5EpSyB0e/s5C3PENSExdwIg
 c3qWcGmWj1gnA+F8HbjG+HGe/NOK2JLlCsGImg5bdqcXkRMOysQYvk2omaDLuGPoIVCV
 S4HuecqG7bu5kebD/pO+c6jmZYQ59AzFRUXzr5lNSyKjqQWjlrWXZMRKsFIDiNaImIGC
 vKrKuYA0lokRGjpdCcOe5T/1WFIhTuAe+vyWdNrAEcuQxkDMpA63eLHOT/mR7LdWSECF
 0pX+O1ddb/h9ivX9z70Clyq9zSkJzVWY5NLVHdQHl0oBX6E3BjOrvF9SnxkA2C6NQTUG
 fs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2p/KTvOdFBZHS2wgaLneSyM/12uTssiSfcmpmu1qWJU=;
 b=1gfbooWq7Wd1oWQ0QtF89LXryHrlUJcIxg8MzjYPadqXCBCw1J0zkEytX/vJPGiCau
 2bsZH6XA1RJBjWc2Ee/rVbwBfV+9YuUTP9rIJk1x4owCgwCDl7yzx8bmDkbJSeYu5jcs
 Bex1iwgEENp41hWmd4rSLRRV+0LdS2zJA4AkY17dPUqTujEs8uHpVCXAv+svPAZsu+hr
 6UUTLa8tAprzLVcAReVpEJQzwj2LiltCDh9hm1aRfZ1FP6XS6p5/OTNqMIYCCRvq2FPZ
 8xUPpFhOyJN7Pwr8oF1Y66M2jszKkL9d6wzsXpWrHEXXQ169auOdMNF6mxuiwdf5IZX8
 PkCw==
X-Gm-Message-State: AOAM5326wmZpxVsTVFOxwQS8Ajwf70nOrMvSoHGrzaPrvHwnyS9UK7QQ
 2mv7euWtbF4i1jkSvEln3Hg=
X-Google-Smtp-Source: ABdhPJxQ9XEqISa2gSf7Ib5Vqs16zeP4ehOCvlyQO9+hxEoC5tBaB9+VgY/PHURs4VYjcXIeBd1LRg==
X-Received: by 2002:a17:906:6b8d:b0:6cf:ebab:ef81 with SMTP id
 l13-20020a1709066b8d00b006cfebabef81mr16489913ejr.5.1645467323624; 
 Mon, 21 Feb 2022 10:15:23 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:c040:4508:cf:7951?
 ([2a02:908:1252:fb60:c040:4508:cf:7951])
 by smtp.gmail.com with ESMTPSA id e4sm5411806ejm.116.2022.02.21.10.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Feb 2022 10:15:23 -0800 (PST)
Message-ID: <d6c977a1-ce77-a7a8-b55b-6c07628a430e@gmail.com>
Date: Mon, 21 Feb 2022 19:15:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amd/display: add GTT domain support for dcn 3.1.5
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Yifan Zhang <yifan1.zhang@amd.com>
References: <20220221101451.809067-1-yifan1.zhang@amd.com>
 <CADnq5_N9cAnrcJLN57BA0q2_=Mcr4bDCynkmNyYWPMGpy7kieQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_N9cAnrcJLN57BA0q2_=Mcr4bDCynkmNyYWPMGpy7kieQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 "Tianci.Yin" <tianci.yin@amd.com>, "Wentland, Harry" <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 21.02.22 um 15:27 schrieb Alex Deucher:
> On Mon, Feb 21, 2022 at 5:15 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>> From: "Tianci.Yin" <tianci.yin@amd.com>
>>
>> this patch adds GTT domain support for dcn 3.1.5
>>
>> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> index 9709368b4915..88ee1224541c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> @@ -523,6 +523,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>>                          case IP_VERSION(3, 0, 1):
>>                          case IP_VERSION(3, 1, 2):
>>                          case IP_VERSION(3, 1, 3):
>> +                       case IP_VERSION(3, 1, 5):
> Should also add 3.1.6 as well?

I'm really wondering if that check shouldn't be something like >= 
IP_VERSION(3, 1, 0) instead.

Christian.

>
> Alex
>
>
>>                                  domain |= AMDGPU_GEM_DOMAIN_GTT;
>>                                  break;
>>                          default:
>> --
>> 2.25.1
>>

