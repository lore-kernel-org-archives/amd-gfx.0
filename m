Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF4CEE14A5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 15:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8351010E698;
	Wed,  6 Sep 2023 15:23:34 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD70610E698
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 15:23:32 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a9b41ffe11so2579734b6e.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Sep 2023 08:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694013812; x=1694618612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/TH2evQIp+CoJtfN171lYGKefuMWM9Y9UP0/gsryA0=;
 b=T3nOmv+Ejbi3SPCMOUR9fwiVhJvdLrYCwm2Em4lGjocQF8KHUfIXXhDAd3PCiB1KKM
 DdCm9X8bdhULhDqqCH5Br+AWvPxgguO7NXPBFrQdC8NmV/GTl/hIi1RQReGBLk13maPn
 qFBp9XDAYgswbqwYUg3qMzVcp/b4gbh1Rj0apEM0aI9DlnCsTUY+AKeHBPrLwLlzn41U
 W2W7/r1BUyt7GU2hIIPUhp+CP27KWPT0YFbv4q4Opps8ghYAy4DrAa5/qK2mSM+LBV4p
 3FvB+buYoewNQKZJjkqd2cyjbqSLsj9tlvEXIYkZeCjcmMw0hWK+HQ5oANXObYJV9VyQ
 iGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694013812; x=1694618612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/TH2evQIp+CoJtfN171lYGKefuMWM9Y9UP0/gsryA0=;
 b=TBmCMIo1HJX6ubtu33xrvTKkeab/wh+Fv/UlvO36sk29QnnfipqI4tTSN/nbVoOH2C
 0ZnQJAphe6qcQFES6hG8/J3Ey+7absnywA+hZxY9IhE6v1rQNBwlpXbkqsvi9jFUtay2
 eOwOEblBk+T62pPAvR+/UZyaY5jFnYhlGs30DlmTv7UlvTEAuxg+gZKr2GqM49K9f697
 zie+Rq3dT982Dl3dGLnLKg0jo/JuGp2UNW0r3GA8pd0RnL+kW0aZXjZG4YdvqdKNt48U
 hEfQ/aYLR58A+TPftfIwYFP2UpBggGHzOSVp7YQ1Z9eg0nQLSNWQ78bm6D5+rZ8rl2BS
 Nq0g==
X-Gm-Message-State: AOJu0YzgG9rI6ZJZG8TVURIWF74xFYw/SaZA5+WkEf+8VIW9SqaTeDjf
 KkbsDj55LiTqvCc15Lu295z99Zq0qtQpgxDpQPdn23FL
X-Google-Smtp-Source: AGHT+IEjq0pMEmcDGtCjxkH7LU9UHC9VxlI485hI+Ft8G7TR4dZOE+lwQpePMUFEd3XGpMEaqZczxobaneSUOEZFHJ0=
X-Received: by 2002:a05:6808:168d:b0:3a1:e7fb:76fc with SMTP id
 bb13-20020a056808168d00b003a1e7fb76fcmr19598511oib.17.1694013811861; Wed, 06
 Sep 2023 08:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230906035647.952389-1-lijo.lazar@amd.com>
In-Reply-To: <20230906035647.952389-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Sep 2023 11:23:20 -0400
Message-ID: <CADnq5_P0bXrSOOs=UBLA9pasWnL=R8jeusScy3j5qHhE-fvs6A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix refclk reporting for SMU v13.0.6
To: Lijo Lazar <lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 6, 2023 at 12:05=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> SMU v13.0.6 SOCs have 100MHz reference clock.
>

Do we want to use the vbios value on boards that have a vbios?  If
it's the same on all variants, then this is probably fine as is.

Alex

> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index f5be40d7ba36..28094cd7d9c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -325,7 +325,8 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
>         u32 reference_clock =3D adev->clock.spll.reference_freq;
>
>         if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 0) ||
> -           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1))
> +           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1) ||
> +           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 6))
>                 return 10000;
>         if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 0) ||
>             adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 1))
> --
> 2.25.1
>
