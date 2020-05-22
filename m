Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50592C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 10:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8E220738
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 10:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW2P1TTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8E220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8BAA6E9BA;
	Fri, 22 May 2020 10:28:18 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46B86E9BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 10:28:17 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id x1so12388816ejd.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 03:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=miBI6wuob9DcW81kVZPOP3LTZjIZH1G3YuGehQ80TBs=;
 b=lW2P1TTLGDy5NhL4k3EWhPlz18MyTU0e6Ns4sSZT9c410Bw4MJ9UApfq7Zs7jZGlEx
 jtPUv9JVqw+fXJ7/oWLNaBANg00nYF0MGl6eOBIZrQSIhIaNv4HvdHzYTKi0tXeiZV2W
 PmwA7qSEjUSSBwmIA9HDs1GBaykNHHvHEkv/kcsMuhzg9Dopd/NHK1J9B+zxZ6oSgqXs
 S3+GhvaUklyM7/2g9cZVqhkQyhWUm1WRK/R203bKgYGkQzh9o8vUTJxBy73PFHW40L7w
 WWnLBP7Z3/QorG7pxTJM2EnUezf28c9Q4VoCsIXGy6dewcFg8NoXfJiDs//ToJOFKn6H
 iIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=miBI6wuob9DcW81kVZPOP3LTZjIZH1G3YuGehQ80TBs=;
 b=rH1iIPULEV4GUjqtDBH+ts+hXQt31uhN7cykx1ROHyLkwdU62sPs6xLZVxTJsfFXJk
 All1Z7EfE/0CBXh2G2bKFsoycsZwmPI7JHAcMJIZmzhqyMclP9FFNrJl5EK4aQ8tNzrx
 nE+X7hWDoOXb0Qlv/+kEWuvPciLL4xasTUIsw2gj9I67zDmhMQNzF05gXPIMPPQh62Sr
 297uf3ppsEfOQ0FWnvR699bSfG6yXnnX7ucuEZLRnKb1bQYx3kIKDvjXgNQpC/xYgPTg
 Pe9cdJF3Gxw+x8noCRdjY0+BNEOpAodRMeZWg528cZ+WQG/O1a626Hy3SIR8C+1Y4mI0
 4ysA==
X-Gm-Message-State: AOAM5319kzXoYpvJzEuVey6uq3WnZpoOgDHDQN+4RRGqVx0zsmOMXsvO
 8xFtGhWB7xDZC9VW0EKAK0EUK8cw
X-Google-Smtp-Source: ABdhPJzl2XUWvjoi2xqqd5cnNEUpZQYam9T3z3KUSINTK2gner8isnAZkTtR8Y55KxuGv0cwy8Io9g==
X-Received: by 2002:a17:906:14db:: with SMTP id
 y27mr7755864ejc.427.1590143296212; 
 Fri, 22 May 2020 03:28:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id g20sm7601662ejx.85.2020.05.22.03.28.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 May 2020 03:28:15 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: Advise if unable to resize BAR
To: Alex Deucher <alexdeucher@gmail.com>,
 Alan Swanson <reiver@improbability.net>
References: <20200521202931.15726-1-reiver@improbability.net>
 <20200521202931.15726-2-reiver@improbability.net>
 <CADnq5_NAhJvZYfmHpCRSPR0zv_6pXoR=2ZQgFWhgpfrT8ebcUQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e3688ca7-6eb4-a69e-664b-39a6ac9922a5@gmail.com>
Date: Fri, 22 May 2020 12:28:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_NAhJvZYfmHpCRSPR0zv_6pXoR=2ZQgFWhgpfrT8ebcUQ@mail.gmail.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.05.20 um 23:32 schrieb Alex Deucher:
> On Thu, May 21, 2020 at 4:45 PM Alan Swanson <reiver@improbability.net> wrote:
>> Even with the "Above 4G decoding" (or similar) BIOS option enabled,
>> many BIOS do not assign the PCI root bus a 64-bit address space.
>>
>> If available, "MMIOH Base" and "MMIO High Size" (or similar) BIOS
>> options should allow mapping to the desired address spaces.
>>
>> Signed-off-by: Alan Swanson <reiver@improbability.net>
>> ---
>> Useful to know why bar resizing isn't happening.
> This will spam a lot of people and probably cause confusion.  I'd
> prefer to drop this one.

Agreed, you can just look at /proc/iomem to figure out if resources 
above 4GB are available or not.

Christian.

>
> Alex
>
>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 2f0e8da7b..39a7f7212 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -919,8 +919,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>>          }
>>
>>          /* Trying to resize is pointless without a root hub window above 4GB */
>> -       if (!res)
>> +       if (!res) {
>> +               DRM_INFO("Unable to resize BAR as PCI bus address space below 4GB.");
>>                  return 0;
>> +       }
>>
>>          /* Disable memory decoding while we change the BAR addresses and size */
>>          pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
>> --
>> 2.26.2
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
