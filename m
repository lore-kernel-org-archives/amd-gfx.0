Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8917C43327
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 16:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E9610E1B4;
	Fri, 26 Jun 2026 16:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rdhux1Ii";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A8010E1B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 16:59:14 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c0b97e268f3so165103266b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782493153; x=1783097953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUSrLdQ2FI4LHY0dWueNCnyawFEpRnJYUQiGcaotRTs=;
 b=Rdhux1IixPoMKalP6eS9UuJL1ZntPTqBZsIgkjjtcoYXyBiLfMScFA+0VSTStN2BEq
 mthi6FfiQhKWOd6mmX+XZBv0eiMyuKLqAEAWHsQ2L3E6erN4AN31ibWt+w2JvWpvxddy
 +5eNXQ2cTtk8e/6olEliBzJYTd9MYr2MO4LT3kxd4Th/tZIMpwPwsLhdNpF78hOyMFA/
 lfCX8Tcu4TJtlTAj5L2L4VF4l80zuXoJGVpUMfOh+9fLc+I50H315zlDdVbrnQklj2mG
 zvFXapWPMfDCrOhqr8SFDRqnPvzYKSvknDcS/J02gXe0wJXkg52eGdKweawtr0vx4hav
 5gvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782493153; x=1783097953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BUSrLdQ2FI4LHY0dWueNCnyawFEpRnJYUQiGcaotRTs=;
 b=Xa3tjyU36RN3QgCei1qcrWOFbTdDW0C3KaK47Gh1IFC61Agh/WSqTG4wCKL81E83ey
 ICKkrNRGuMnKYQpmcUSpGBsoDaGOyTdsZap/WU6YC0O3fvAZ+dShRlcCtVGPSOnCdppJ
 S5HLlWFFFojWDvW/pDjEh81Hb07W1F9z864uUu5ULCHD4AxllDD6h8o6UGhkHy4eRmVi
 aEif/LKHvP7nL7nXzkQnPhMyPDSp1LMyB+xCnsa5wOzvB6NyLq6cAPOLQYz79RWVD9KE
 czBK2mZh5S5G70Uc4e5EOH7rhc8YZEzpNxKRWdtg/TYdnm4bVoqKnKGF1JjApD2e2iE8
 a4ng==
X-Gm-Message-State: AOJu0YxbjHpnoaOZl8CQMMhRx6FXXki869htXTrVEhyAaPIPmiCJavuE
 NpMKjJ22ehP7w6ftSAeyx3Jv9NNF0LkfiDt7H+fwTtK5Lalm4TdMBBXdYOtvdQ==
X-Gm-Gg: AfdE7ckDW1Pk8OLkLMYXWa80W2I2g9I6Wbbe6RfcX6I7Yq1GSi9AiE+mqLV0MvkMPBB
 Uof+KUDNevsa6NmW4e0vtbuLl0kKr7SZ8MSKgD7kYuYYzo2+xpP6V9F7nJIZHn25eYH/Uv8RCng
 mVCcThaJ8XIeBaM+/KcCE6knS8fuSw1Y5gQRjwP7ws8VLiUL1Z6m7GcGcV7JvlFtCcZR0r3oLhr
 +xserdhxlNz0jKfrXl55N8jOsjRPrDbKIuAwdeYJP8qGJ8giIpZreoyLgpu9Uw00z+0G7NYkWjj
 1MPUcpYhbRRMWKqUeg6tIj1gAxQJVzaUgLlwy14h9kRxnAIW0ha9LyDDqkeE0OGG2Ca2lMiuM7D
 Zjo2ILdfFbkQ9LioHGymdRJxC2SmHYKL15b1dcW0fXDi/3JO16W625gWF3QKyAekUnAjnBAfXY9
 g2JzP3yuYlTOgI/cbKEjvJXI1cOrA7Ww==
X-Received: by 2002:a17:906:e108:10b0:c12:29a3:e348 with SMTP id
 a640c23a62f3a-c1229a3eca4mr139568066b.27.1782493152627; 
 Fri, 26 Jun 2026 09:59:12 -0700 (PDT)
Received: from timur-max.localnet ([2a0a:f640:1701:30c:61f9:a53e:4a65:c732])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c121cd03f24sm159682066b.32.2026.06.26.09.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 09:59:12 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Remove unused amdgpu_device_ip_is_hw
Date: Fri, 26 Jun 2026 18:59:10 +0200
Message-ID: <4887714.vXUDI8C0e8@timur-max>
In-Reply-To: <20260626085558.97923-2-tvrtko.ursulin@igalia.com>
References: <20260626085558.97923-1-tvrtko.ursulin@igalia.com>
 <20260626085558.97923-2-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. j=C3=BAnius 26., p=C3=A9ntek 10:55:56 k=C3=B6z=C3=A9p-eur=C3=B3pai=
 ny=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> This function is unused so lets remove it.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Nice cleanup!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Are there any more uses left of the amdgpu_ip_block_status.hw field?
As far as I can see the field is set but never used, maybe we could remove =
it=20
too. What did this field mean anyway?

Best regards,
Timur


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 21 ---------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h |  2 --
>  2 files changed, 23 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c index 6aa54156bbc9..62285e973c5c
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> @@ -368,27 +368,6 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_dev=
ice
> *adev, return 0;
>  }
>=20
> -/**
> - * amdgpu_device_ip_is_hw - is the hardware IP enabled
> - *
> - * @adev: amdgpu_device pointer
> - * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> - *
> - * Check if the hardware IP is enable or not.
> - * Returns true if it the IP is enable, false if not.
> - */
> -bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
> -			    enum amd_ip_block_type block_type)
> -{
> -	struct amdgpu_ip_block *ip_block;
> -
> -	ip_block =3D amdgpu_device_ip_get_ip_block(adev, block_type);
> -	if (ip_block)
> -		return ip_block->status.hw;
> -
> -	return false;
> -}
> -
>  /**
>   * amdgpu_device_ip_is_valid - is the hardware IP valid
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h index 1d0df6d93957..11739fbdeaa6
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> @@ -146,8 +146,6 @@ void amdgpu_device_ip_get_clockgating_state(struct
> amdgpu_device *adev, u64 *flags);
>  int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
>  				   enum amd_ip_block_type=20
block_type);
> -bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
> -			    enum amd_ip_block_type block_type);
>  bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
>  			       enum amd_ip_block_type block_type);




