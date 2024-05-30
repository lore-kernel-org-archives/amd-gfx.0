Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C78AC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 10:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9BC10E71A;
	Thu, 30 May 2024 10:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="WOoU5g/L";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC1E10E71A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 10:18:00 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-52ab11ecdbaso865437e87.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 03:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1717064279; x=1717669079;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lR7sR9cgw7Lv/mjtsOBMd8q/HIc01MFJqhSI+mWDogs=;
 b=WOoU5g/LbjPNmyNTL+4xEh3DqRWgVD7mS2d0jRl0IUCigFIjVywcQ08btWPEkUwjGw
 4BgqRe3SQgyH7AFNKka2PI2mOGqR6aoYMIHbv8/U5RhN9lieSGaNDnEyj5/9OaV4qoHe
 ycvFspsdg9p2ENkTgRopHzu586FXtC2tHIgoWYD7q+BN9WfvRzSRGlhyrMq7NvwH9GsQ
 GIg9cDl1betSA7U3nT2sKuVwMj6YKl8LBwk76GNLqdbU6OmQa4KcB7ZRgPpY7FU0vzFM
 wuLqFBGYqzdwYy/JmACIyaDFVi7JPjs3swAQRdyrhAxFrmu5QdWBvbUufuDFGlFRieJi
 8NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717064279; x=1717669079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lR7sR9cgw7Lv/mjtsOBMd8q/HIc01MFJqhSI+mWDogs=;
 b=bXoCpj0pEBetVTC83yg5idX8Wdna3MMbYptGSmvukwQrPvOCqKbJ2aRCu9GesaZXSX
 cAMxla6cclrWXluwraO7yTMZ27G4TFUipfh5X72KxMTpaDtSrhu6kAEz63KkwVCNN4n0
 DQqSWNCOzjAtd0v20LMb/LV+nuLITzGxydCx1QRkX9IkDeyIMz9/rQ2HJP9uIn5NGKTe
 4jXi/mR5lU3+ntFjpanL5SyNnEMqPuYdLbT06geM0Xbps+adyNNztHGWm7ToHWKyzW5D
 bC68UXArNQVGE/jaWcvpz2s2hEXy/v7/IihIg8Lex8hsVVDywyVCc+gBaCUTrYognYNk
 2Ung==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNNli+LgRctoP/GepGfHSqcRe2eaqVeDTBCu8yG6c53DtUfTiTf5iI1c+asGns5S8EoI5sLjLV95qzIXy6eVKMPDu82PV6EMqbrxwGmA==
X-Gm-Message-State: AOJu0Yzug7YywQAVK5qp7jEXsdsz1FMU3MVi6BS5/Op+gqp0Sdhg80t4
 rQnWCwRY8WGmIn60usTxgea/8II/z2Wu8hpD7XDk3BpyNmsn58/Gs0w2EqHGooo=
X-Google-Smtp-Source: AGHT+IF7oxrnDredpBAtJBUwA1cjU17tIe5nhRzekKSg64NyvnJ4KUokR+OyEUZajse+umDDlUQpjw==
X-Received: by 2002:a05:6512:4883:b0:526:81ab:191 with SMTP id
 2adb3069b0e04-52b7d48c5eemr1050274e87.60.1717064278872; 
 Thu, 30 May 2024 03:17:58 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212706170dsm20549565e9.11.2024.05.30.03.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 03:17:58 -0700 (PDT)
Message-ID: <b794fecd-4f06-4e17-8f83-77912c5e1e01@ursulin.net>
Date: Thu, 30 May 2024 11:17:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] Discussion around eviction improvements
Content-Language: en-GB
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Friedrich Vock <friedrich.vock@gmx.de>
References: <20240516121822.19036-1-tursulin@igalia.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240516121822.19036-1-tursulin@igalia.com>
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


Hi,

On 16/05/2024 13:18, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Reduced re-spin of my previous series after Christian corrected a few
> misconceptions that I had. So lets see if what remains makes sense or is still
> misguided.
> 
> To summarise, the series address the following two issues:
> 
>   * Migration rate limiting does not work, at least not for the common case
>     where userspace configures VRAM+GTT. It thinks it can stop migration attempts
>     by playing with bo->allowed_domains vs bo->preferred domains but, both from
>     the code, and from empirical experiments, I see that not working at all. When
>     both masks are identical fiddling with them achieves nothing. Even when they
>     are not identical allowed has a fallback GTT placement which means that when
>     over the migration budget ttm_bo_validate with bo->allowed_domains can cause
>     migration from GTT to VRAM.
> 
>   * Driver thinks it will be re-validating evicted buffers on the next submission
>     but it does not for the very common case of VRAM+GTT because it only checks
>     if current placement is *none* of the preferred placements.
> 
> These two patches appear to have a positive result for a memory intensive game
> like Assassin's Creed Valhalla. On an APU like Steam Deck the game has a working
> set around 5 GiB, while the VRAM is configured to 1 GiB. Correctly respecting
> the migration budget appears to keep buffer blits at bay and improves the
> minimum frame rate, ie. makes things smoother.
> 
>>From the game's built-in benchmark, average of three runs each:
> 
> 						FPS
> 		migrated KiB	min	avg	max	min-1%	min-0.1%
>    because	   20784781	10.00  37.00   89.67    22.00    12.33
>    patched	    4227688	13.67  37.00   81.33    23.33    15.00

Any feedback on this series?

As described above, neither migration rate limiting or re-validation of 
evicted buffers seems to work as expected currently.

Regards,

Tvrtko

> Disclaimers that I have is that more runs would be needed to be more confident
> about the results. And more games. And APU versus discrete.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Friedrich Vock <friedrich.vock@gmx.de>
> 
> Tvrtko Ursulin (2):
>    drm/amdgpu: Re-validate evicted buffers
>    drm/amdgpu: Actually respect buffer migration budget
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 112 +++++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  21 ++++-
>   2 files changed, 103 insertions(+), 30 deletions(-)
> 
