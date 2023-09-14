Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85070EEAA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 18:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E8F10E15A;
	Thu, 14 Sep 2023 18:50:07 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CEB910E15A
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 18:50:06 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-57358a689d2so775796eaf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694717405; x=1695322205; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fn+vGWvfCg+cffDi23GevCWEnRyx5DxlhXIfoOyj4Qc=;
 b=GwoLbvEQ7+4wSpeax07n2DW2yRKqEwtLcUQuid67wq2Z+zEqEfx4YI2r/W57mO7pgj
 aGQkZtzFDzBXUmgMBYPbMAldOJvXKQrcwlrWEFZiE168exU25iqkdax1eamEjerIU6Sf
 a3PTw8fU5o6Fz+7tSbF5nNvgZa1Dl2JsSu6Z75Ieunip2eCXrQvrNY2cb5UI4rdRfPdt
 R8T6Np6VT0YRAU1ito5B73xAL6hcJ4lxOhnM2bF94CMuTw88vyrakJTZQKHZOsijGd40
 cdEJDV8U0UTld6/t7xJI6kX/ZahACa5AeGcC50a9Dnbj0NJUKv4ZkERAk2ziUCngI1Zr
 BliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717405; x=1695322205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fn+vGWvfCg+cffDi23GevCWEnRyx5DxlhXIfoOyj4Qc=;
 b=Xf/u8/V79alzUd773pf5a6IXFOLY06yLtD606+o5NZEf/507eCFObH+Hz6gZN6sFyX
 TxzB4eVsPUkmjIi/yfOj7T+6upxI+FkuoWpz+LZ+RsvM7PnQiF4ood5Z7NUqHO9erPnI
 8FfYFoAGIL2k4sERwO9sRTqVwR3NjnzMX4Dh+09j/hRULlz5ZA7liWcQ7MyYeuqARK/W
 nvezHj9t6ToEpMX7E101whfrNGqJHlo0xRGIc6QkAye/gyp3OYa3RLf6cSfBBFEDFgky
 HTHjqmIuu3EpLpG7O+TnImd4EfTTbw0s/CzG/KAYSaP7rV+OhPwFW0F9a7mas5fJt+Fu
 BngQ==
X-Gm-Message-State: AOJu0YyEGMj2dLqIEU18AbFNVZnJLGrxJcLZuT1J9c3ip8XODMf+Rg35
 6GgojIGzzOmvhXTK/zyy9RKk0ZZ86c6Rv5V831E=
X-Google-Smtp-Source: AGHT+IG+gydLHgg4ec5w6gf8jotpQctAB6S0U2sp0t+mkd+fkWbwm9eYjmBk5reU+zAeEQ24a8AF/6Wwg7NlRSFTwk8=
X-Received: by 2002:a05:6870:a2d1:b0:1d4:d016:22a3 with SMTP id
 w17-20020a056870a2d100b001d4d01622a3mr6617480oak.7.1694717405322; Thu, 14 Sep
 2023 11:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230914182200.679059-1-alexander.deucher@amd.com>
 <20230914182200.679059-4-alexander.deucher@amd.com>
In-Reply-To: <20230914182200.679059-4-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Sep 2023 14:49:54 -0400
Message-ID: <CADnq5_OucfrjjRtTsV=yiaCcYJT8oADr5xdQLUsrBhfNs_npDw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu/gmc11: disable AGP on GC 11.5
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 14, 2023 at 2:31=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> AGP aperture is deprecated and no longer functional.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 6947b598e9b2..7ee91b66f761 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -745,6 +745,9 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *ad=
ev)
>                 adev->gmc.gart_placement =3D AMDGPU_GART_PLACEMENT_LOW;
>         else
>                 adev->gmc.gart_placement =3D AMDGPU_GART_PLACEMENT_HIGH;
> +       /* AGP aperture is removed on GC11.5 */
> +       if (amdgpu_ip_version(adev, GC_HWIP, -2) >=3D IP_VERSION(11, 5, 0=
))

Not sure what happened here.  I've replaced the -2 with 0 locally.

Alex

> +               adev->gmc.no_agp =3D true;
>
>         gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
>
> --
> 2.41.0
>
