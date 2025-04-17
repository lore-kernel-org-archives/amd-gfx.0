Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E684EC369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 15:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9593210E1D2;
	Thu, 17 Apr 2025 15:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GapYHsGW";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BFA310E1D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 15:48:04 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3054e2d13a7so140057a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 08:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744904884; x=1745509684; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HHQguANKPHVWgpeIILQ62cW4iwgZHykMvXb+QNgBcc=;
 b=GapYHsGWyR4TiSTdMrHeAzFBRcJhCqezJTz+4bKhpB59DiTwwk+MlgiECBOjD2b/P+
 oJMyJ/MF/zUdnlzdha+gWFG8fvj1d00KpxjaAuSDtU0paF5i6EKqpgNUOUMX5lvY/bMA
 bDNJ+yDd79jXjQ7JmBwPJNd1TnebP7KzyVP1KkCNgwa5lanpobckQ30N6T6lJWnvaGdk
 6xLLCe6kCLkkn3GTuRMdCoUFE99ISq3HKIhgVi+jQP2XAesYe9M7UXR6Gn4jDZrXRszv
 ir2z0Qe+4qHWmj8HU8fg5QiTihqJe9AVYArLfI2OdM+YMwUGBqIbrKOcpURla8r+42d8
 MjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744904884; x=1745509684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HHQguANKPHVWgpeIILQ62cW4iwgZHykMvXb+QNgBcc=;
 b=O9XPjmSi2oMvDCSLDU5xvghxq0fx4UEv5eJKNz+NxGm9AuoZM3SgH4VTIAs8ggDOda
 DQ4IM2qVFI1RGWuzUi4jAP8+vcra+0EaPu8uquan5P4qfsRwu3Qtij22Vz8Q1K62XoTC
 xEy41PYGKCM2T7IX8LIqa9wB1v0NilkVhiNtsJxyJdx89XLx/Hlae/7lsvwnUl5IaVTJ
 jBIHC5111pohZU5viuKjyYyfkU7d6SU6jMoPJGdh/DUMysNez8ZLXLBEfXDJ+5UqTUJ3
 O9GjVADzG8wrAIxKFOHXoegnw0RPdVHULVtKKJ02BWhmh2hqAnb5/xVnrvLY2SjseGHg
 XiEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8F3cuJTr1rJ1vAng8UjLdLZcdN6d0QlyczeWaFyaTz6GRHrLgqalDLWcbKrIHtio94A3uxLhE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwL+qw3EuKNhBrgMUDf2jcxmf/dDT1IKVBcAIg0pVInFrFBGVmE
 AgqEfVEwLgLwmKRQosquxNX1wyP6jkr1u8z8CtG3vk9ocatJjjOxLGf+xUZwGH2pSGwKDKfOjtk
 k+X9QmuIPNJB5LSPYPBfag2XfZeGEYQ==
X-Gm-Gg: ASbGncu/nKWw+4U5XyCYmwlmhWgw95FdCkKqMtr1sR5uAvihjb4ueRu7Nij9+jjFCM1
 dpmVwgOK76Uce0I5cmeiev3a5SGd3ARiukFpp7sypUKargLP9tawd8UoUP4lxsuLIqFdjZ9cGG6
 gpEfg6MpRpxYFGbMy2AchziQ==
X-Google-Smtp-Source: AGHT+IFmEmgb6v58LQI8LZ4TSry0S6dNJUVrQkWP5gcdd3FbXuseqZ8tEhgvUtK4VItFrWs24HbFlUjk7TrWm6pae8I=
X-Received: by 2002:a17:90b:4c10:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-3086d4748admr1945822a91.7.1744904883969; Thu, 17 Apr 2025
 08:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250417154421.3752158-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250417154421.3752158-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Apr 2025 11:47:52 -0400
X-Gm-Features: ATxdqUGyWGlfVG594X5H-CFSLlZULpBFCw-4zJYMGdwkNP2JnihT0G8Uu9JJEC4
Message-ID: <CADnq5_N1vHeq3LVYsPutVv0oXQryiO+TOtyv=R9=6qzx31rh6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Refine Cleaner Shader MEC firmware version
 for GFX10.1.x GPUs
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

On Thu, Apr 17, 2025 at 11:44=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Update the minimum firmware version for the Cleaner Shader in the
> gfx_v10_0_sw_init function.
>
> This change adjusts the minimum required firmware version for the MEC
> firmware from 152 to 151, allowing for broader compatibility with
> GFX10.1 GPUs.
>
> Fixes: 25961bad9212 ("drm/amdgpu/gfx10: Add cleaner shader for GFX10.1.10=
")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 00eb4cfecf8f..e140f673d25a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4828,7 +4828,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                 adev->gfx.cleaner_shader_size =3D sizeof(gfx_10_1_10_clea=
ner_shader_hex);
>                 if (adev->gfx.me_fw_version >=3D 101 &&
>                     adev->gfx.pfp_fw_version  >=3D 158 &&
> -                   adev->gfx.mec_fw_version >=3D 152) {
> +                   adev->gfx.mec_fw_version >=3D 151) {
>                         adev->gfx.enable_cleaner_shader =3D true;
>                         r =3D amdgpu_gfx_cleaner_shader_sw_init(adev, ade=
v->gfx.cleaner_shader_size);
>                         if (r) {
> --
> 2.34.1
>
