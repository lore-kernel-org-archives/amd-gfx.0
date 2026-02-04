Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A15EA7940
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 19:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 740A210E763;
	Wed,  4 Feb 2026 19:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V7Mg+8jD";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D6910E1DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 19:24:17 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2b7063004daso7531eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 11:24:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770233057; cv=none;
 d=google.com; s=arc-20240605;
 b=AIRzU+lTZOrufjDR0Wy1W45JnP7ZnDtK4u4rvXSNFDWVjcAozYOFL5DnMRRzNffKP5
 Q3qMqnXY2CXkpeQwlcjy3DyL6GeV7+fQcQYQGQE1iAzQeGJ3wTfL7jZctobX8yprFNnL
 S0kk4GYTB7Jm3Qm+Tg/IIFsPGosRSMmfjSziPVC64LjXBlPRAKePoCPiV4xrT1fkTHis
 lVYyPEoyI0/ZZErLSkPKen5XKd0ctbUYC0KbEFBxfVR1ETEm28KpILdDpOABlpzoZOK0
 HN9idsu7qzuJspy2ovdMTTtLt3/7gTOdoOi1wFc8qcIHQRHmMQTWRSamFp+W/kKEEyA3
 qu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UKukgjt8euGwYaYyNP6Iji1G1ogK+ObIjS9GWi2QjMo=;
 fh=ywufY45N7y/CseTzJSY/Zn4uTF9dYMGbgs7NvBuPwNE=;
 b=INo1pf3qMcDn5sQmT5mFxyjJENKvLpd+jQvTIusBkO19ztWIKnKlfr/1pww+GItN5E
 9hX+kXHBC2Cr+zkVwEuZJpebiJOUb/gMCAjm2jw7e+tfVZQ6nr2b31GHGOoWEBS+W9o8
 WE1eIwpqrC4BxwYqfHJsAFgDNiO/7YbqvrKzS4xbSTpOXqrfcuwJ5Irlm4ilKNK7C5Na
 h0IJh5/FAEGOgrBHVjx7nKtQ83B+Hn+LvuA5K6yjdcrKCuBYkVyjp4VaEUefE9T+ot2G
 yEGQ0nY2O/V+sQf+RGjFF3ZspEa5ZIppTNa/XQE+AsZjYwHKF152UnsmeLNeYu21Qj8h
 yD+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770233057; x=1770837857; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKukgjt8euGwYaYyNP6Iji1G1ogK+ObIjS9GWi2QjMo=;
 b=V7Mg+8jDpRcqzpP6Im8HhvqYagsR5wOz6c8MI2M1wT7eExJXNsLTT6IN2KCqa5rAG3
 0YqGakWply/Soer3+P0/8lku3AF2Dp0aEiGxLgoXpuie8wnGOghXHVHMMm1yYHkCkwRv
 p4RfqbFjmm4zGh6Mf5KAzOQx+88cEV2OiMutSBPu98WWtZgu5ImtjXNSpOyV5O7b4f79
 OJOW34hr5wXpYERmDp9uqLA9Omly4cZvS0Aa1A0jteufQJOr/vmIyKhXz0mE3L7bHUhu
 Hn0Fg6oy99ohw9yqRRcKRJmK7fT29EOk2Y2W42jow8FTdCL2qPwRqu7TddeYr5FyW/6P
 lBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770233057; x=1770837857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UKukgjt8euGwYaYyNP6Iji1G1ogK+ObIjS9GWi2QjMo=;
 b=OhGxFguMFdmBtF+Cx7MkWPrTeNHsQxcu/t2dsE1c0teITl8GGcx9OdZjvC7kowVUNn
 qcCLvKe4d9i2YF5j6C2PaWBOrcjMggkvvPYA94bPhSpPkHnNipMTY6Ap/0CxrpGa8ZRh
 t+M3vf6/HaEB4njw/O7WSxAZYQr7OZ+/kqaeQzj9abhk6tW1els5GssdGgqXxVBryrYR
 fxJ8Heu+xtA9bZa/jYbt4DzOuXZuub1dwwrZZEmycORxbZIa0ut7zeiiBj2K3ywf8BYr
 zfV2/tBFS209wY7Q/DPu2Yty5HVQsRBIooljtYuwhsrYUDB/nOEgS508KDT60A8G8bjC
 qJlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpkFi0L/y5OLDYDCAZaxQHweUJJt+bKJfKLvxx5pXJTGxFGoJTj1V4AhRDwcwzTnpY5qcIMwyn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzB3yqQTPtN5bGmv9oP629XaCozmdaMbNncTb6jbfk2B74WFtO0
 ms+RnzIIQd+Gu4e15jN5kFEF+KNMXuL0rTHIiju9Dl8sPrJ83uVZg4q0/PbaYuXumo2n9/PXEj/
 ciWzAHJr9evDediH/XyOyy+JxBKvQqjQFIC47
X-Gm-Gg: AZuq6aK69m14mZZPuH4TaB1A8kPfZCRIol16xhXJtM5WBVW9FNjcLnr5sfhdt4Er7Xi
 RHNs4+IzyRYoxXIywRW+aiYTGE5SpXw+/ujHR7w/q7+MnXvxcVLExK4NJCuuC1eAzQfKbLTPy5X
 y6p+zx9IXuht+VV7/mYkCQ3u4dAwVcP30usqeyBZdr/qaFz0FTjRvuxIAAiP7EvlEvdigSAVBDl
 0dnwsPXBnBydqAQ7seC0fLCFePo8uanyzYWhcRoz6PAwK1Imoz6dgAIHxLx49mpsGLEBrsLyaWO
 emO1KwU=
X-Received: by 2002:a05:701b:2510:b0:11e:3e9:3e9c with SMTP id
 a92af1059eb24-126f48d6177mr656593c88.7.1770233057197; Wed, 04 Feb 2026
 11:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
 <20260204044338.96093-11-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260204044338.96093-11-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Feb 2026 14:24:04 -0500
X-Gm-Features: AZwV_QiiKzE7Xy0QSICYJ54jm_YWkUWKKvJgtAgLNopJFc_AhhmorQKekVjin6o
Message-ID: <CADnq5_Mu_2xh1PVoLmZArK0mv2BcpTeapJeJ8YzsxZq0NMJiaA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] drm/amd/smu: Fix User mode stable P-states SMU15
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Tue, Feb 3, 2026 at 11:52=E2=80=AFPM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> SMU 15_0_0 exports only soft limits for CLKs
> Use correct messages
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index 140e5b8c0489..8e6b7574d159 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -1033,26 +1033,21 @@ static int smu_v15_0_0_set_soft_freq_limited_rang=
e(struct smu_context *smu,
>         switch (clk_type) {
>         case SMU_GFXCLK:
>         case SMU_SCLK:
> -               msg_set_min =3D SMU_MSG_SetHardMinGfxClk;
> +               msg_set_min =3D SMU_MSG_SetSoftMinGfxclk;
>                 msg_set_max =3D SMU_MSG_SetSoftMaxGfxClk;
>                 break;
>         case SMU_FCLK:
> -               msg_set_min =3D SMU_MSG_SetHardMinFclkByFreq;
> +               msg_set_min =3D SMU_MSG_SetSoftMinFclk;
>                 msg_set_max =3D SMU_MSG_SetSoftMaxFclkByFreq;
>                 break;
>         case SMU_SOCCLK:
> -               msg_set_min =3D SMU_MSG_SetHardMinSocclkByFreq;
> +               msg_set_min =3D SMU_MSG_SetSoftMinSocclkByFreq;
>                 msg_set_max =3D SMU_MSG_SetSoftMaxSocclkByFreq;
>                 break;
>         case SMU_VCLK:
>         case SMU_DCLK:
> -               msg_set_min =3D SMU_MSG_SetHardMinVcn0;
> -               msg_set_max =3D SMU_MSG_SetSoftMaxVcn0;
> -               break;
> -       case SMU_VCLK1:
> -       case SMU_DCLK1:
> -               msg_set_min =3D SMU_MSG_SetHardMinVcn1;
> -               msg_set_max =3D SMU_MSG_SetSoftMaxVcn1;
> +               msg_set_min =3D SMU_MSG_SetSoftMinVcn;
> +               msg_set_max =3D SMU_MSG_SetSoftMaxVcn;
>                 break;
>         default:
>                 return -EINVAL;
> --
> 2.43.0
>
