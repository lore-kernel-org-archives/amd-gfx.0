Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15528C30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 13:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44A510EAE1;
	Thu,  4 Jul 2024 13:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q03LSdXJ";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF19E10EAF2
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 13:04:03 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-42562fde108so4192435e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jul 2024 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720098242; x=1720703042; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=56TF0NcgU4W5QoZvLKGhKdizMMkKE+ds9Wjh5mFg14g=;
 b=Q03LSdXJlvx2Ci7otDvzk+42bTYAK2WcCmi/l8kPtrQBOjfcEch/omkbeF1mxLgsta
 w/NnSEHnmGRKxmEUZIYWDxx8dxcm4jPYfmtGYX8tCMqQnGlxjK0o/yuV7xBlH+hZsw3U
 ixo9I2FlMZHnYI/H4UuXdY4jndOAeBhBtGvzOSzEa52DWhleokG6IXUeT8kANw5YDfCf
 IujCXjpQsGqbaYcwerUKgojgHwgHz6cKPWORM6S7o2XAS1q+cLdwqnBrmtWQ5XPp6PJG
 JmBoSTovEnSgk9gQ5GbP3K1OfUexr1SbV7mbWgFDKmTClbBIGJjIY7XXOsrUk9AprL6x
 EP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720098242; x=1720703042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=56TF0NcgU4W5QoZvLKGhKdizMMkKE+ds9Wjh5mFg14g=;
 b=YqTfeKUSKKwpb8Ju8t6QwtwrcluPYQcn/QLx1YWXJBfp9OKhkBjQfI1fDDuOXdt/1A
 mJZtuVovUzjouPSZPm1vWf0WKxz2s0SuGl+9mQiK8XdSsdrygbZ3Hkcx5N+gfPjpfkjM
 icOFkWg5Tuk5Vn76fY/meny4J8HcRajFURT/4Kk3VF85Io6f1DvLl44qGo8HXptSg8us
 AAW7L3CvCLZ8MlcyW3OSUEkKyyW+QnDDzreiZ3EAbwxBwnHqWdkDhTGuGciFjpbSWQ1x
 FbTEXOeSyyZV4a+nTTBGPOrrSEU7Qk29+p4wG37nvrJiqJs4syu8h1ztxi9m/29VxQN7
 LKjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi/1l0PG/wZn6KRkIx1+nNM5xaDEhEfSS5edYzjJRTvMTeJSJH53/1iMLT91/yTVDLrW94Y5bc4pJJL6gvk4HvulXcVSeP/bq3TZjEpA==
X-Gm-Message-State: AOJu0Yz3NlZFts34pZkxtT3+e/Ja2SYjaSusAsTx/QzObrb2Pi2mj1JB
 VLHqEzEWYqvlKoJCihfi206HLYAX7YSgqJO/BxM4Oakd/1+Yts2OilYwKFmi
X-Google-Smtp-Source: AGHT+IGAQsoJXwM2vsWUG34+H30S4RzH/FwVaF7w5ouC8sREEx3qQ1uDehR/VqYCZIel0TanV+O5bA==
X-Received: by 2002:a7b:ce19:0:b0:424:abef:e952 with SMTP id
 5b1f17b1804b1-4264a4562fdmr12025685e9.29.1720098241701; 
 Thu, 04 Jul 2024 06:04:01 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1dd952sm23470285e9.13.2024.07.04.06.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 06:04:00 -0700 (PDT)
Message-ID: <a43c0b42-612d-4988-ab22-72dbee32c099@gmail.com>
Date: Thu, 4 Jul 2024 15:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: remove redundant semicolons in RAS_EVENT_LOG
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, tao.zhou1@amd.com
References: <20240704055240.1722656-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240704055240.1722656-1-kevinyang.wang@amd.com>
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

Am 04.07.24 um 07:52 schrieb Yang Wang:
> remove redundant semicolons in RAS_EVENT_LOG to avoid
> code format check warning.
>
> Fixes: 951c09c88fca ("drm/amdgpu: fix compiler 'side-effect' check issue for RAS_EVENT_LOG()")
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Ah, yes one of the most common mistakes of all times :)

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 9224fc6418e4..518b10f190ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -72,7 +72,7 @@ struct amdgpu_iv_entry;
>   #define RAS_EVENT_ID_IS_VALID(x)	(!((x) & BIT_ULL(63)))
>   
>   #define RAS_EVENT_LOG(adev, id, fmt, ...)	\
> -	amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__);
> +	amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__)
>   
>   #define amdgpu_ras_mark_ras_event(adev, type)	\
>   	(amdgpu_ras_mark_ras_event_caller((adev), (type), __builtin_return_address(0)))

