Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D19C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 15:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B34C210E991;
	Thu, 20 Feb 2025 15:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SEv4cLJD";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61E910E991
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 15:25:00 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-439a4dec9d5so8637905e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 07:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740065099; x=1740669899; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IUTlN6Z7ZWoVNB3MnRqm+QOUgt1Rgacum4S7x/HdIYI=;
 b=SEv4cLJD+mE99cti2vhT9IE6XxT/3AFyBUoDrUgmHFSaeP2ql1UOzhRL85o3tiRGo2
 z5jGJbe7xP6RFn/livIV6Ek9uSLvmWHT8mHJ0PvU0J/BRYiYvvzEWFX2BNm/25pxxMTZ
 dKDCM1aeiU1mZ8qdF6jMX/ss3vf0b1q9izJhh4+4zTv+ICjzx2dPZ/yzP8Xq/GFJqaSs
 2L3Zr3PZTHyNFlflYaIdcc28NEN8vqGIziAbZXVyi9Yw0mxHuEsg1Ahgtkp5nLC55isM
 eBCeEg/87fZlTABrB9/VHxgdCi9iwSzmQJKBYHahXtE48CKoGmR5pMvXp7EiGnoINOOI
 XhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740065099; x=1740669899;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IUTlN6Z7ZWoVNB3MnRqm+QOUgt1Rgacum4S7x/HdIYI=;
 b=oAYjKhAaQFaVIqodHz0loGFGxPj9fs3SyrETKRRzkrmGhMKrfQIAVMmzE8QHX4K3t7
 NHT2OJoE6QthQ+GJdNNuPI8oVlFEXhOFqxjfRY83SzEQDL9IKwajnQAoW0jSvN6Pkv1w
 JejHr0zxJus4SCNCsb8xzrnZ8bPjo+Zwfxl/8pOnwoVjF2tHq/pTdZoLakA+/oeXV085
 r0mJqEBJBoIN9R9v8u7UkeGXgbS+kwWoOjd0FqzqQdJUa5JmCEHDQj9ELwSchwku4rFS
 KdHWgUpsdGcTxxJwYyn0uRaKB0A7ot5cD0KUleywcyA8XVnm1QFNKy6DvEGoOq5J4Dsq
 alvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViNYCaizF4zugKYr/rgOMWqUjUMNIm94u/asvjVfUGgecPIQ3eSDuA54fglZ/ah0EnM4r1vmBQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwCfkfUkqckOVQjgQ4RAaKIRFF5+tcxVnLGVVzpdfFScpyAdj4
 S3qlH4vQ4+tv7JJExodrdMFl2yUXEYpvOUstTfMLIqC8yUOeMRCpEIn+ZLt+
X-Gm-Gg: ASbGncuhmeR0yqegSyZaSE4hWA9Jx5BHs5iu+iM4zkxu6MAiqVDpfSOsEwqnav2hfUO
 GTPMQKH4FJkN29tUBqObh8DRlL6ctKBgKHy0GH3e5kG6lGUNpceIQUtqpeqcGVVQ0jZGoOwDY51
 yKIKUv/VtEVPjlJvk3CCEpetVg8Z9fIbM1K2JOLtQd36x7laYxI25BQd4z/5udLRz2S9lKG6OtC
 CVyGjcrln3rd3ZvxsoavT9WLei7ieWCRlRc/9uKwvAKWqpZL6Dcb8LnjW4o5nGiPGoFBA4TxsZW
 g0CUnJburGxaYnukfdmafVI3obuXlFaLEN/26SdioA8H
X-Google-Smtp-Source: AGHT+IH+X881KwjCvoBUyPqWIPwwgfw/x/aQ4Lk5NCBP56vxmIXj7QhgMSM47yMZwpqSao/W+SwaaQ==
X-Received: by 2002:a05:600c:3b22:b0:439:8bc3:a6a3 with SMTP id
 5b1f17b1804b1-4398bc3ad73mr154321615e9.3.1740065098832; 
 Thu, 20 Feb 2025 07:24:58 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25915688sm21248334f8f.57.2025.02.20.07.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 07:24:58 -0800 (PST)
Message-ID: <d89ff02e-b458-4aa8-8671-ad7e61220bca@gmail.com>
Date: Thu, 20 Feb 2025 16:24:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update amdgpu maintainers list
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250212144454.2438143-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250212144454.2438143-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Am 12.02.25 um 15:44 schrieb Alex Deucher:
> Xinhui's email is no longer valid.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8b35ca294a02..d39b272a6a751 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19213,7 +19213,6 @@ F:	drivers/net/wireless/quantenna
>  RADEON and AMDGPU DRM DRIVERS
>  M:	Alex Deucher <alexander.deucher@amd.com>
>  M:	Christian König <christian.koenig@amd.com>
> -M:	Xinhui Pan <Xinhui.Pan@amd.com>
>  L:	amd-gfx@lists.freedesktop.org
>  S:	Supported
>  B:	https://gitlab.freedesktop.org/drm/amd/-/issues

