Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8DCC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 14:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55DA9112649;
	Mon, 15 Apr 2024 14:56:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X5xXLGio";
	dkim-atps=neutral
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B62112649
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 14:56:01 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-2d717603aa5so40770581fa.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713192960; x=1713797760; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jdIwsXxGNqtT98SB0ef9KbxX4P0pfLsecpKbDJNJYNE=;
 b=X5xXLGio/M2A83ZXGwdrIdJPebs0XBxgk9j0F0CVXUkaxabuk5EfdE05+5K/tpFcbg
 J50WOY9w+Ns7hsrD8Xwy3Opy7LrLqGOjX+xUcS2kHS2ne6XBFTsTOQoJE1Vr2E5jpzjQ
 Deg1WEL/QdoAYPm6WPsfQyCt3gEbwh8o2KS4QKyoQcNZZIrlJwz7vwt2xdxtpQElvua0
 GzHuMg92oSaozedFvjzX3MEO4S+mOWHzEZfAAXVVqxDNeJGVzeuLZgmEynbSC4I6UTRg
 rFfjDNxrRRtcVmo+L2tNFpy/S3obJ0jUfT2pi1XteOpyq9aaO3l27VGvEEjDc96qXq4H
 oJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713192960; x=1713797760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jdIwsXxGNqtT98SB0ef9KbxX4P0pfLsecpKbDJNJYNE=;
 b=X8ql8rHqzrYxTJcMJsK4X0H9wgeYE0x4z3c/i/7O+uWPLLD2q+zmjGnjquJBhwJUeI
 9cnpMaPBxWPpJ1OSrlOwMV35yVq/1mD9V1FpbUY9Vn9U9T4hca+4C60hoqWZ3yzOYy1s
 nBlNYxgeqlUM8GKpEHi4BytpGSFDU4UquTSibYh2W4yHR3lWT3A4RU9vsGJy6Tx85FrF
 JT5mjf7PjEY/7K+LXgSG/rdEiiOLXXJAEz8HHHJQME9lGmccTBAPYtVpGJA30PbKjOGS
 Gkidb5TV/Zr5GuQVfeyC+/DWjTlTkHfb2ktYQzo15mRe8eMLYAZT9mQzbm9iUCgq+zA2
 DRUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS67ntHf6VnRQ0ASUwFKwrVe58p6WuaXWSwMf8cTP3VWb5LZ2z8u8pHw3Ig9S4vd7NPuhXfBE33QFc+ErJnmYLkp9qS6WgvCPuV0TR8Q==
X-Gm-Message-State: AOJu0YwuexUD2oHSdCSOEu6hV0SCKhiPntU6+WwHJeMRrjsCIkygVabZ
 8C70w0QwMk1Jvf468E2kJ/jZ1fl/Iuu7PjXKUJJS4U+fOxTy6Egw
X-Google-Smtp-Source: AGHT+IFehFPkDVuScA1kX6gZv+bCMNqDB3mELbK71UjH2RidSFqW1/5J1SBBisK3oUCQnTpkuIWohQ==
X-Received: by 2002:a05:651c:b09:b0:2d8:274a:db16 with SMTP id
 b9-20020a05651c0b0900b002d8274adb16mr7720705ljr.17.1713192959543; 
 Mon, 15 Apr 2024 07:55:59 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c1d8c00b0041884675767sm318555wms.42.2024.04.15.07.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 07:55:59 -0700 (PDT)
Message-ID: <c2e4d05a-b245-4a33-acf8-54f650616d07@gmail.com>
Date: Mon, 15 Apr 2024 16:55:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: make -fstrict-flex-arrays=3 happy
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kees Cook <keescook@chromium.org>
References: <20240415133816.1053794-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240415133816.1053794-1-alexander.deucher@amd.com>
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

Am 15.04.24 um 15:38 schrieb Alex Deucher:
> The driver parses a union where the layout up through the first
> array is the same, however, the array has different sizes
> depending on the elements in the union.  Be explicit to
> fix the UBSAN checker.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3323
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kees Cook <keescook@chromium.org>

Acked-by: Christian König <christian.koenig@amd.com>

But I have a bad feeling messing with that old code.

Regards,
Christian.

> ---
>   drivers/gpu/drm/radeon/radeon_atombios.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
> index bb1f0a3371ab5..10793a433bf58 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.c
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.c
> @@ -923,8 +923,12 @@ bool radeon_get_atom_connector_info_from_supported_devices_table(struct
>   		max_device = ATOM_MAX_SUPPORTED_DEVICE_INFO;
>   
>   	for (i = 0; i < max_device; i++) {
> -		ATOM_CONNECTOR_INFO_I2C ci =
> -		    supported_devices->info.asConnInfo[i];
> +		ATOM_CONNECTOR_INFO_I2C ci;
> +
> +		if (frev > 1)
> +			ci = supported_devices->info_2d1.asConnInfo[i];
> +		else
> +			ci = supported_devices->info.asConnInfo[i];
>   
>   		bios_connectors[i].valid = false;
>   

