Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105A6C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 08:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46FF010E3AA;
	Fri, 24 May 2024 08:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TPoHnhxe";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C58310E432
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 08:07:24 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-52905ff2a9eso1078456e87.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 01:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716538042; x=1717142842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M0qy0i3Xh6W3V0n/BvwR4LDTsNlNm+uF2veBkQHgDrk=;
 b=TPoHnhxe2L7KZ6qmG6LiEsWrLevuJ2DiWcGILl552AsiRH544/wvVRxWJ0ISR37c+N
 DaiSkckjcP5pNY5uUDl7+I4k8rVvVxWy4l//M0KW88AWkGYlHAHb1vNaWWWZzRoSa+RH
 UJHekjIzJ5INKUc/EcvRMvXHLUDCw8EpYVv1kT3HZ7Wx2SgNvsWlSfACcQeojK4D08hX
 VKdpPTyyP/B1P2CAGzK5dMnVu+GERDrT9KtuEIL8Tpx+paClouZ2kqA8Mr7k0FnGUIgY
 QKtxFaPcX3cc1P9xckbKxIqwU6RWk2DtaJnRXiqUT+zjTv/gN7bicZWsCeFF3h0ya+jl
 hXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538042; x=1717142842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M0qy0i3Xh6W3V0n/BvwR4LDTsNlNm+uF2veBkQHgDrk=;
 b=cWa21w/cRZU0xSC93DOB8QfnzmoS3c2cOohbJiDD64xh1HvPBmPx5JkKiuI+enX+k1
 lS9PE98l/US/+IrJpOJ5ZjSsq+UTkQwY8HWRtQRwNNay6muYg26K7j3QO+5NlKlyq8mD
 UPKEvoYyRsIj9ReyKdmRwnaFnLNGPoeegE62ApPqxzSiYQsJ5OKKH3GPcHazzKtUNjU8
 p9d9XD5aq8CVpH/PP5y83CWzapG9C/sc3/vQw5lMdsc8NyXBG5Po+4eJE1L6+Ze01VZ+
 cR1e1Ed3daHnOPb4Y6aRvgQlSsZ5WGzlLsnLPNcul+Ww0jebB/w0Ax/+zzVOOh68niUO
 9kqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoL+8YKyuWZGAQeAuuvMKjGwGPsCg52hPtF5u5QQPFPWPaF6fuYY7hyVTfUiI9wsyckzVMr+HtJtVuIxwGmU3PG8pxICD+O2QcjyOHfw==
X-Gm-Message-State: AOJu0YxdARKPxheol1KSl1mD9CGoM6yLIk5dwMNax2+CIIPcU4zSROqP
 wYHJF6n7HedYUg8LW6eVgggPPDPOc1qoOAYOhsSjL+lwhfPQPwda
X-Google-Smtp-Source: AGHT+IEXFTsr94cI3w6h414gxaF62nGUlJ2qmRWMlINgTYciNb95dzdKwoc2yOxy9IsAbKOheIrxqw==
X-Received: by 2002:a05:6512:52f:b0:523:dab3:39 with SMTP id
 2adb3069b0e04-529664dae29mr732318e87.55.1716538041942; 
 Fri, 24 May 2024 01:07:21 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089b041bsm13441785e9.37.2024.05.24.01.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 01:07:21 -0700 (PDT)
Message-ID: <4c0073c0-1e57-4db6-8901-2a377cd3fb5f@gmail.com>
Date: Fri, 24 May 2024 10:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: silence UBSAN warning
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240516135501.2214792-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240516135501.2214792-1-alexander.deucher@amd.com>
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

Am 16.05.24 um 15:55 schrieb Alex Deucher:
> Convert a variable sized array from [1] to [].
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/include/atomfirmware.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index af3eebb4c9bcb..f732182218330 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -3540,7 +3540,7 @@ struct atom_gpio_voltage_object_v4
>      uint8_t  phase_delay_us;                      // phase delay in unit of micro second
>      uint8_t  reserved;
>      uint32_t gpio_mask_val;                         // GPIO Mask value
> -   struct atom_voltage_gpio_map_lut voltage_gpio_lut[1];
> +   struct atom_voltage_gpio_map_lut voltage_gpio_lut[] __counted_by(gpio_entry_num);
>   };
>   
>   struct  atom_svid2_voltage_object_v4

