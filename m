Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698F2C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 09:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07AFC113AFB;
	Thu, 18 Apr 2024 09:00:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PpKC5+v5";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCABA113AFE
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 09:00:52 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4167fce0a41so10041505e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713430851; x=1714035651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yN8ixenI76YTKw3OERnpEkTxh6K0Y0g8MJmM958CDGg=;
 b=PpKC5+v5YCwEDMKnZ/J99RNElIEpP3muaOhnji6Oo7X4/ucUhibGmJVTKnBPWvJi1F
 je5RreP15WVO6SovnUpNE/ErbikXZEO0lBkFnIwUME0ACX4eHKFqEYEoZOwCaHudgmYO
 B1LNED0rIAX9UmwI9qtKO6y/8PxzCw8GtovenVXLsb+trwskCdfqF7RHQYl+0ChEq+X9
 gXLZ78hlddrXnnoFTUcaRjS1JMIYdcHsaDfKS8Vsyq1nm9HrQe++gJsk1CCGqX/Fa7fC
 pbUgXRW7rEAYBA28rFRyEqA7kCNOm9FnzHkGCNAzWgQDWvuEinLtqI0LNkU5nNsKXvdD
 BtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713430851; x=1714035651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yN8ixenI76YTKw3OERnpEkTxh6K0Y0g8MJmM958CDGg=;
 b=Ctd457S8Tiv/TgeZhWoMHjTkUa1f6fbf4AVXasi9me46WOmup3/ldkpowMnAtOs3xE
 6QoOgXoYYY/jPah7Z3iR+FSR6a2IA9crBLSafx0dQFIIOMkbIszmJ3AfiZG5FCP7Anr5
 pYgfCUfHtznPfUphDdnIdkRKnAex6s1Mz6vY3rhbkez6EDry8fBCUZd/SEqIHXZJ6Hwu
 bMuWC4Ry62zrUrJm94+sp3D/sDYuVD/C4KautylBPju69bGUZxLZfvo3/n+AthSkp9c4
 YsQaxmM9mD6iZPnbo7YHYVcltA4nCxalmRO93SdIG6Wlag7L93MrHnO4RseLmKcVoftn
 9iXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcmXFZA+M7SoyZqUXx6WkldKnm5GBK0K4s6OKlFcrMO6K2u/3ok/fsykPF83XllIQIUg1qhPHfik4XroiCfxUHVU862IPlanQ2vG8EgA==
X-Gm-Message-State: AOJu0YwPJngvQ0LabUhWStyo48l061Y1W+8YFhWisU4Bk3Hzfx5UJNUW
 6PAXkl0Pc9/zSxFdnlS5hAZVZE/sqLwVPo+RMNeLxhbGTAYq7EG7
X-Google-Smtp-Source: AGHT+IGLl10EN8LLnOutqdCxC9hWB5fwE6dS9g67tqykeNqWILTwg+x6cbUXRvofsPSox7Ah1BfYAQ==
X-Received: by 2002:a5d:5104:0:b0:345:6cec:4e02 with SMTP id
 s4-20020a5d5104000000b003456cec4e02mr1177762wrt.12.1713430850748; 
 Thu, 18 Apr 2024 02:00:50 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a056000100c00b00349ceadededsm1303834wrx.16.2024.04.18.02.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 02:00:50 -0700 (PDT)
Message-ID: <17718699-72cc-400e-bef8-5b4314a06386@gmail.com>
Date: Thu, 18 Apr 2024 11:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] drm/amdgpu: Use new interface to reserve bad page
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: yipechai@amd.com, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com,
 Candice.Li@amd.com, KevinYang.Wang@amd.com, Stanley.Yang@amd.com
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-15-YiPeng.Chai@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240418025836.170106-15-YiPeng.Chai@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.04.24 um 04:58 schrieb YiPeng Chai:
> Use new interface to reserve bad page.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index d1a2ab944b7d..dee66db10fa2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2548,9 +2548,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>   			goto out;
>   		}
>   
> -		amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
> -			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT,
> -			AMDGPU_GPU_PAGE_SIZE);

Were is the call to reserve the VRAM range now moved?

Regards,
Christian.

> +		amdgpu_ras_reserve_page(adev, bps[i].retired_page);
>   
>   		memcpy(&data->bps[data->count], &bps[i], sizeof(*data->bps));
>   		data->count++;

