Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72093E95A96
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 13:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BA610E0B7;
	Mon,  9 Oct 2023 13:13:20 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66AA210E0B7
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 13:13:18 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so4500512f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696857197; x=1697461997; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N9Z6Mvux0hHTgmZtbZR76jHnRusRA/JNmSZfvaBXMkw=;
 b=RDDZBFNw2Bdr8bLaI4laqK4KlQqeQ6GYpuxujGvY3cOZUP5G08wK3znYngllMDydM5
 0H2muZg+s18eD0gEsYdDqvbL9FVtkdIslHoJUkjkLdi71+npC2tcydyd+UkQLTr8cqnI
 ZG15v/ytk0TzgYqstxh5wad8/wp7fIrCn8e5eHhFFsggs20uh4AU7Agbkv8s/exFeB2M
 GSBCsKsy2r4T8n+GbKCDRRe+LVJZX7+XoVPWFHaCGv2m0GaTY1kj+bhJL+Oq1mbjNBVV
 /O94EsQXrYWpJ8Wd4AfYOsKpMbbF6tditGi7SemYOCXJRhr77VDSYj5gpzV9ITWUbzfs
 Vbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696857197; x=1697461997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N9Z6Mvux0hHTgmZtbZR76jHnRusRA/JNmSZfvaBXMkw=;
 b=nuv7gDdBiWbItCveNFBhqYugIGBVTtap/iZvVCeM1PLWVjOyJLxHyAPIrgWnqtE6+b
 OFy7uefdNLXAP4whakNQ2CjtR1Tn5mEMMv6UGDC+5YNPYZhsy1fYuqrRnyZ9imLwOrqi
 wYWiatsxfA/4HLHTIz0IG/tWvD1ojGG9gWCQhAlvrxCwICb5IfahwJjIzkuHAAY7kmHr
 9qbhYoj3GFYbT8ARtjkVpJEmg8GyBGoFTk6JTMyEDZuRFlW+TePvEftZpjtEsU7Ql38+
 rQNBcdK3ni1H+PTBezKCTFc3lCHxciesmq5BTBl3J8iKyRlWwquGiM/kuUuXtUJJFF3U
 Y4fQ==
X-Gm-Message-State: AOJu0YzkrfBuJBHGJn/1WlFpqsbqlQF1Gwa2E/U2GoNc0RlW+wB5u5LJ
 2VUKxzv2/Ndok2rtiwtCzyQ=
X-Google-Smtp-Source: AGHT+IF/GzKzx4xhJegcpwG/XEcmXRaffzaa8o5m0G+HiFkMIHqfbMN3PI9WiIrgfQD6Y9NCyVUM6A==
X-Received: by 2002:adf:e383:0:b0:320:1c4:e213 with SMTP id
 e3-20020adfe383000000b0032001c4e213mr13168102wrm.1.1696857196457; 
 Mon, 09 Oct 2023 06:13:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1d:6120:aabc:7bed:38ed:c94a?
 ([2a01:e0a:1d:6120:aabc:7bed:38ed:c94a])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c219100b0040646a708dasm11151163wme.15.2023.10.09.06.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 06:13:16 -0700 (PDT)
Message-ID: <b57be307-2986-949a-9275-ce5d36f8e88f@gmail.com>
Date: Mon, 9 Oct 2023 15:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] drm/amdgpu: add missing NULL check
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231006121151.1502-1-christian.koenig@amd.com>
Content-Language: en-US
From: Samuel Pitoiset <samuel.pitoiset@gmail.com>
In-Reply-To: <20231006121151.1502-1-christian.koenig@amd.com>
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

I can confirm this patch fixes the kernel crash I reported.

But as discussed with Christian, we should find the root cause.

On 10/6/23 14:11, Christian König wrote:
> bo->tbo.resource can easily be NULL here.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index f3ee83cdf97e..d28e21baef16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -252,7 +252,7 @@ static inline bool amdgpu_bo_in_cpu_visible_vram(struct amdgpu_bo *bo)
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	struct amdgpu_res_cursor cursor;
>   
> -	if (bo->tbo.resource->mem_type != TTM_PL_VRAM)
> +	if (!bo->tbo.resource || bo->tbo.resource->mem_type != TTM_PL_VRAM)
>   		return false;
>   
>   	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);
