Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4EAC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 13:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A8810E39B;
	Thu, 20 Mar 2025 13:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OguD6KRp";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E5210E39B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 13:07:03 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2ff5544af03so203369a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 06:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742476023; x=1743080823; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2Z/Fx0jqKudPB2y/VmrKgS7H6rkz3M2z9bZsqQgxdU=;
 b=OguD6KRpbJa48vq1sASGisgnKOPF6IOXS1YtFAy4BK1BptEOkBAauzZrSiOAl/QHzM
 wsHD+yV4v+snXnbGysLYbedecdic2xRCgFpq+NR1H+QrPH70I+S5z0QlFq8d4XU6RORa
 UrHpWzoBcwBfyHIC4XvzTTrWjyyzvCO4lPGZ+Lc8TQXYH2FP/Ix8nFAsdpD4EkHtHToY
 gyiD+n3FSMJqcITizu9MSyrj8aTqzBYJx69Y/lyIaXEWZYlDnJb1CB5Ld5ApjBtYM4UT
 B1cTnAOA9o8oHej8nvZHK6V/9Zp7ZuOBCuhDacWbVncGuQ+f2V502Xe6Tnm47E49IIPU
 Kh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742476023; x=1743080823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2Z/Fx0jqKudPB2y/VmrKgS7H6rkz3M2z9bZsqQgxdU=;
 b=bxvZEf+cbAvurzURbG12uL5hI6gTUfUUrYu/pTLkM1uHLkt6+KZndcrfDayxw83JW6
 lp/Ljm0Yf2imr/idKOtUOVi7ydweW3fP/URJoU3d5bVqtriRCrzvkSmkSBTVtiYKHu/x
 YJRHBli8J9UzbYLL0bEzRzifgpmmDdq8HsPjgCj7rcmxIv8HpomwwUdE7JDuB32WBxWo
 oZWJCEQKa4xceMwQgGoL1JhEQevcreFzYolHID5NOXrMQaWCXLQjrJ0cJDAbqKPv5EOK
 05KCrabwWJMpt/XUcjMNheOmQ33DmvgYSnYgpoIPjyVUx15QoF1uihqgGitiQkkL73KT
 wVcQ==
X-Gm-Message-State: AOJu0YyPIzDRQvcwJa9TT8g3dxi+0AK7ZUErd3Mr6zI8tP/NNlgspuHf
 EyBAAdcogbIz9Z5hHIHtCtOg8eveTMtIr4EqM3VzNgxTT4/rJUNO/6hOpulXGX/U9A/56szWtWa
 RSBy+iInKpaDTL+1bAiAhCzSgcVbZpg==
X-Gm-Gg: ASbGncu01oT6J60Ca9acLF/UouhlXzH7cC3fdq8sYry+pAMxU8UWHyNyuNCCQ4LbEbA
 HgERzH5qubxWvYDnJmY/aWYn/kG+lz7z8EwKgSbtJFoW9H9y247v7DDynHauKUixmo7YTb/8k5A
 BvNevKvo4hmvx3lTLVOUO7+Np1hw==
X-Google-Smtp-Source: AGHT+IHb9PmVBSOt26Da34UXKxR6gIMkS+bF3I8gfeUmvAoZCVTeHUMW6sYFDZRWf9ncSRZ9CsuwMLpPiPq48uy7Pmk=
X-Received: by 2002:a17:90b:388b:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-301bfca3fe5mr3221887a91.7.1742476022625; Thu, 20 Mar 2025
 06:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250314095428.2914973-1-flora.cui@amd.com>
 <20250314095428.2914973-3-flora.cui@amd.com>
In-Reply-To: <20250314095428.2914973-3-flora.cui@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Mar 2025 09:06:49 -0400
X-Gm-Features: AQ5f1JoYK-aUeTv99wbiirpUNFWtPynP_7z6zfO9U_0ntzs-WXBypTWiYUOgtAg
Message-ID: <CADnq5_NFisDoMkXeYKQwPq4qh4iMrrqwf2hM-=q3TPft0NYPag@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/discovery: optionally use fw based ip
 discovery
To: Flora Cui <flora.cui@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, Li.Meng@amd.com
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

On Fri, Mar 14, 2025 at 6:03=E2=80=AFAM Flora Cui <flora.cui@amd.com> wrote=
:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> On chips without native IP discovery support, use the fw binary
> if available, otherwise we can continue without it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 38 +++++++++++++++----
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index fff438baf64b..cf286fde18d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2536,6 +2536,36 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>  {
>         int r;
>
> +       switch (adev->asic_type) {
> +       case CHIP_VEGA10:
> +       case CHIP_VEGA12:
> +       case CHIP_RAVEN:
> +       case CHIP_VEGA20:
> +       case CHIP_ARCTURUS:
> +       case CHIP_ALDEBARAN:
> +               /* this is not fatal.  We have a fallback below
> +                * if the new firmwares are not present.

Update this comment to add that some of this will be overridden below
to keep things consistent with the current behavior.  With that fixed,
the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +                */
> +               r =3D amdgpu_discovery_reg_base_init(adev);
> +               if (!r) {
> +                       amdgpu_discovery_harvest_ip(adev);
> +                       amdgpu_discovery_get_gfx_info(adev);
> +                       amdgpu_discovery_get_mall_info(adev);
> +                       amdgpu_discovery_get_vcn_info(adev);
> +               }
> +               break;
> +       default:
> +               r =3D amdgpu_discovery_reg_base_init(adev);
> +               if (r)
> +                       return -EINVAL;
> +
> +               amdgpu_discovery_harvest_ip(adev);
> +               amdgpu_discovery_get_gfx_info(adev);
> +               amdgpu_discovery_get_mall_info(adev);
> +               amdgpu_discovery_get_vcn_info(adev);
> +               break;
> +       }
> +
>         switch (adev->asic_type) {
>         case CHIP_VEGA10:
>                 vega10_reg_base_init(adev);
> @@ -2700,14 +2730,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 1, 0);
>                 break;
>         default:
> -               r =3D amdgpu_discovery_reg_base_init(adev);
> -               if (r)
> -                       return -EINVAL;
> -
> -               amdgpu_discovery_harvest_ip(adev);
> -               amdgpu_discovery_get_gfx_info(adev);
> -               amdgpu_discovery_get_mall_info(adev);
> -               amdgpu_discovery_get_vcn_info(adev);
>                 break;
>         }
>
> --
> 2.43.0
>
