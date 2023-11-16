Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94936C197A0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 15:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1128710E621;
	Thu, 16 Nov 2023 15:41:24 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C662310E621
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 15:41:22 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6d30d9f4549so507630a34.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 07:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700149282; x=1700754082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WVk08GBfM7U/3lTYlcSwN2O+PSWLvCC8n0/LVUcGNM0=;
 b=nTS1qo4azq1lcUT5VHOO7IjjZWDJHfLzOxjp6ptDov68dfwv5TOpH5Vm/vOSqr4smq
 2agd9MKLhohbwi9muCggT7Nt13VKP37kgSZnSVGiY+JnQaxp1ktObU+ZSdkOd9uoSwxG
 25Q700/GFG24zF75hrSlgNA1sK1raj/5aK28LmkMJQNpo4NBIgf0GtnKDn7RVdB4GGyx
 CNqGCGjS2W5AeKfy4NGuWJfL8bN3Lo7VEXvH2OzjHz1KjkPXDE/+CxBOtaEc19FFQWrM
 IONLDptJlL5ywkvI1BLMIZ881s0pQVNjU++JISzyyeX+XAQ7PgcVdaA0LEos3C7ib3+B
 0RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149282; x=1700754082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WVk08GBfM7U/3lTYlcSwN2O+PSWLvCC8n0/LVUcGNM0=;
 b=HkxZHCBnC7j3/xXkDxHaKm65gHLVYc5ShDz/HU6MNvNOyzYvqmRf102Xnv93VIigtL
 5kqBveM31PKki9McAtHD+kWqvqy8A9pfH8Z9k7L3bDr/AHUdM6Fo7t1zbe6gb3gDWdfJ
 iBzlr3AyuwDFBODNCui5MMY4n7VgOtJSkBEBUzhKeDBN3+K/N6yz1YVxf2amU4FI539f
 KEa2T7H14wQJE2zEOl1c5CwUNmSH0X2uTE+ROjHxqPTh+X1VOodWHI/J8JwuJ+6ehpeO
 KNRbRvQWMLdM+oXWIAxpnG763ynDQhqDYBzmmsou5N/CkUk1VhU9smFnJerVB/5iAo+y
 f33w==
X-Gm-Message-State: AOJu0Yw7zqTcyOJr918lHYEDUo8obyf7otPgS6sZ/0+NLNG/y2uUFXnC
 Lk7mWqxydJJj1wQA/68YBLaVD7bEQ6HRTLrAnIjAESx8
X-Google-Smtp-Source: AGHT+IE2ptxWYERDYl14F2mnCGFukMRfyKeEa8fAabd4GiD3u6XZizeszXT1qUCRlmm9TMDkc6LuCBatF8T7wU7PtUg=
X-Received: by 2002:a05:6870:e94:b0:1ef:b0df:1347 with SMTP id
 mm20-20020a0568700e9400b001efb0df1347mr20571910oab.29.1700149281134; Thu, 16
 Nov 2023 07:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20231109205125.513643-1-alexander.deucher@amd.com>
 <20231109205125.513643-5-alexander.deucher@amd.com>
In-Reply-To: <20231109205125.513643-5-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Nov 2023 10:41:09 -0500
Message-ID: <CADnq5_M8Qy42Vtgg=hiXG06Jn7mABaHuga0cSOFiuG87nSS07w@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu/gmc9: disable AGP aperture
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series.

Alex

On Fri, Nov 10, 2023 at 1:37=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> We've had misc reports of random IOMMU page faults when
> this is used.  It's just a rarely used optimization anyway, so
> let's just disable it.  It can still be toggled via the
> module parameter for testing.
>
> v2: leave it configurable via module parameter
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 22375fc23412..bd69cf61de06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1630,7 +1630,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgp=
u_device *adev,
>         } else {
>                 amdgpu_gmc_vram_location(adev, mc, base);
>                 amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_=
BEST_FIT);
> -               if (!amdgpu_sriov_vf(adev) && (amdgpu_agp !=3D 0))
> +               if (!amdgpu_sriov_vf(adev) && (amdgpu_agp =3D=3D 1))
>                         amdgpu_gmc_agp_location(adev, mc);
>         }
>         /* base offset of vram pages */
> --
> 2.41.0
>
