Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED37FC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 14:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A230489CB3;
	Mon, 24 Feb 2025 14:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kaRRQiTC";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DBC89CB3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 14:17:26 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-220d27d490dso10403335ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 06:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740406646; x=1741011446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBKiOVeHwPJXwsCP+AdAY4wpbdUB6R0YbqIN6hLB1Ww=;
 b=kaRRQiTCIowr582hcFQFDVJ+cxj1kcBTzOUeOnqevj1mdOR2Nz00u2pwfU/58wP2KV
 zJkbitdnlECzQm4qKAJ3BBmU2UC5fLfRasaiYWucq2d8nGsVbKqIPnx503tERy1YKbYs
 5ABIXz6OAdppHnpGC1dveVCTDUPFPrwN5fdQDlvhCyvsdtQpzhO237Cl7GHBEkfOR8PB
 DdjhfsIVoyTENzZO+6tGeaq3TljiHLhJRrw3ATQmzuZ3Pv0JXOxnBLP6BA/6+F/uHdve
 mgwHGFdi2TRZ4qZ1y9WgU66yoh+KNovYlbwRRGNTF2tMMpG/4Kq3C81NOg9T7yVgV65s
 eHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740406646; x=1741011446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBKiOVeHwPJXwsCP+AdAY4wpbdUB6R0YbqIN6hLB1Ww=;
 b=tA6e41Wedab3XS/LF4qCVBWMmS82mNMMEN+W3cLqAh9Uy4DnsxN/lgxN0DMv8M5ML9
 zsMgRcwSjOxUqTP00PMidMj9Jeh3At88CYqXP4ys/8PjypbtU6s+oBZ9fqJQ56E8XOEm
 uvQGumLxKj01Vl1PF3GMy4r8Ts3bcjoHz3u4E+DH5/4yhMqWqlw7ErHjDk9eyD/wAcRE
 1a/LCw81hvSzoaE3gFHLojetr8Mo8X50hC9UZv3dO6SxjUEyc73F7AS3jtqWbOFmIYNB
 XfptLfx0yktI9eqWZzKr5soedVJrBMxK5zn0BFDKTF8aXRlFS3Xgz4hPaXYSL00F2T+A
 jxHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFTFbQrXx8kFBlhEgFjhXrynMcFUdutU3iDqvSoZEMiz9IQabrDRgkuvoKjTnUt5sTZUFasA3C@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBMNG688Tt/UofEYMhfYMMOsi3xCxln3tJiH5LIwQmHdnM9lQz
 i8adVnvJ8Tda9Vs5WdRz8Qc5BaJZdLlhvf/hZk9KqYo9Hd81omN2Rnv2kxhEgui9cJcmHXSA98H
 yNo/OCMhvgILzJ5UJHlqG44q6DUZ0bA==
X-Gm-Gg: ASbGnctYVXKLjvAdYj9ZFfkQOJyylehoP5QgeA2LqNNBpwjPr6RB44vboPsU9LFMjE6
 dPL/rbWKXleWLXVAPj2GeaXJL/ztt2EFUgu/06MCV2m4MIQ0ege3nQ+k30dTFTMXr9dTVduRPrQ
 RUwKnK50U=
X-Google-Smtp-Source: AGHT+IHI2kVT/nvwfz1EimDtKrsluN2CGfXULLB+h4mOEYevpbN6Idy++pg+P0/8WQc1b9Ejbaq5XjOp8gE6U9YTxlc=
X-Received: by 2002:a17:902:e74e:b0:21f:1365:8bcf with SMTP id
 d9443c01a7336-2219ffbdef8mr89948805ad.10.1740406645887; Mon, 24 Feb 2025
 06:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20250224115751.2306233-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250224115751.2306233-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Feb 2025 09:17:14 -0500
X-Gm-Features: AWEUYZkNBVq_fjkr8JvFynWcKRByoeXhCh3jOA3x2lsIWQaWMf-6d0acTiEWjeA
Message-ID: <CADnq5_PfHeJYd4yeO0sehJMaGu9FTHxPr9RyV5pJxOJ_RYfzkw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix correct parameter desc for VCN idle check
 functions
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Feb 24, 2025 at 7:24=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the kdoc for the following VCN idle check functions by updating
> the parameter description from 'handle' to 'ip_block':
>
> - vcn_v4_0_is_idle
> - vcn_v4_0_3_is_idle
> - vcn_v4_0_5_is_idle
> - vcn_v5_0_1_is_idle
>
> Fixes the below with gcc W=3D1:
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c:935: warning: Function parameter =
or struct member 'ip_block' not described in 'vcn_v5_0_1_is_idle'
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c:935: warning: Excess function par=
ameter 'handle' description in 'vcn_v5_0_1_is_idle'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1972: warning: Function parameter o=
r struct member 'ip_block' not described in 'vcn_v4_0_is_idle'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1972: warning: Excess function para=
meter 'handle' description in 'vcn_v4_0_is_idle'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1583: warning: Function parameter=
 or struct member 'ip_block' not described in 'vcn_v4_0_3_is_idle'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1583: warning: Excess function pa=
rameter 'handle' description in 'vcn_v4_0_3_is_idle'
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1200: warning: Function parameter=
 or struct member 'ip_block' not described in 'vcn_v5_0_0_is_idle'
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1200: warning: Excess function pa=
rameter 'handle' description in 'vcn_v5_0_0_is_idle'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1460: warning: Function parameter=
 or struct member 'ip_block' not described in 'vcn_v4_0_5_is_idle'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1460: warning: Excess function pa=
rameter 'handle' description in 'vcn_v4_0_5_is_idle'
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index fe539f7957f0..0dd844243531 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1964,7 +1964,7 @@ static void vcn_v4_0_set_unified_ring_funcs(struct =
amdgpu_device *adev)
>  /**
>   * vcn_v4_0_is_idle - check VCN block is idle
>   *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block structure
>   *
>   * Check whether VCN block is idle
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index dda5ee187948..c936bd08963e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1575,7 +1575,7 @@ static void vcn_v4_0_3_set_unified_ring_funcs(struc=
t amdgpu_device *adev)
>  /**
>   * vcn_v4_0_3_is_idle - check VCN block is idle
>   *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block structure
>   *
>   * Check whether VCN block is idle
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index a482658cbf86..5e6ad825cc47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1452,7 +1452,7 @@ static void vcn_v4_0_5_set_unified_ring_funcs(struc=
t amdgpu_device *adev)
>  /**
>   * vcn_v4_0_5_is_idle - check VCN block is idle
>   *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block structure
>   *
>   * Check whether VCN block is idle
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_1.c
> index 721c29f52451..40f36c9a4132 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -927,7 +927,7 @@ static void vcn_v5_0_1_set_unified_ring_funcs(struct =
amdgpu_device *adev)
>  /**
>   * vcn_v5_0_1_is_idle - check VCN block is idle
>   *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block structure
>   *
>   * Check whether VCN block is idle
>   */
> --
> 2.34.1
>
