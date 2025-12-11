Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1221CD41C3A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 14:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD6C10E2CE;
	Thu, 11 Dec 2025 14:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TAGi7W5u";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331C810E2CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 14:01:32 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7c9011d6039so10846b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 06:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765461692; x=1766066492; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJqI93+9kUGR7Q9x9buz3aB1tNGs8bMaOWR2wz5h3jc=;
 b=TAGi7W5uoiAXg38A3/FmCmvA3XAxRoIy9GEJMYXpJhWhCfxFyY16qPmEcwf/U8Z2py
 62wmJkUPadqm5fBzKhAznyLXl1ZyRwlLmlAyWHRYiVXK41+SZez2iYe4J9+RSMd/CHJs
 YSoG436izihDCLRje6bPWwvDVgsywqQHDi6qojuClt3TMdvn6oad8pS/9C+9oythhbWL
 yd1tnxJRj9cBADz4CfBblGTADVCWm6/c4w85nC3VKjOWeUADQnAgQh2Apec0rKRi0Rot
 xRAlTOhvB9Hyme5eSetNhKvE/Ax5/0A+dOWEI1PQui40KSByaJPiLAGFNNXQ/ImTe5Hd
 UZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765461692; x=1766066492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PJqI93+9kUGR7Q9x9buz3aB1tNGs8bMaOWR2wz5h3jc=;
 b=Qt7xBaKSyD0pSv6oengKxPrMTJE3mCYwf6Y1XNQx+NVoDxqOoXTcbZ8Gw4XpH3iSKC
 HxZmTri4XSjap9W7Cq6w5n8qDonB3CjC6f7hLvarDvHbMB4PIiYVovoqvNjDX6jck3Qd
 QhzYrt5R6PHTe3H5K0E+LqLlKHaLDibWIIKBJ1cq0wgcogeWeW0VtaCfme+6L9+9VX4H
 eELhQO8YmwvvJYsRKqctl8VaY+ojjzp7He9+Mf7ywxmkF2uos4ZEFqmmIV4JMJ4dJ7Bu
 rjmNYuo44Fe/SfyXt+g+VhKt0BnyskSaOaF16Mz+TFboX0xHJAJrvAVGF3DCseflFzW0
 REVQ==
X-Gm-Message-State: AOJu0YxA5eluC/o5E32GZpLsrgS6Tcd8NUOJvtyc4U0yYruVdWst3gHe
 jOm0Aerlv9Wvhr4gGDUdLGRmyrtpRhSlgRfH3ULmDTsdcmJ1hBNK3mJRQQSWYWEF7U3bbo5BY5p
 exxBUctg67dRht+SYUjEXYuQzbyyQTSM=
X-Gm-Gg: AY/fxX4d75n0zsR7ECnHCM6nOB3Mq9lYlRKXA7Ua+wAlwRs+j0AGBs54Ca6qRenqsMz
 60V9Eig5i7YOEO2A5VMYluC49BYN2uJZ09j91JG/Q5N2+w/Tu+M21sqlxvbiGSnLA+HVYQxnLpz
 RkZ2h+4jN+tHeDQrS50vk/DS4QMI3BpS/QCrIT58bEweNKstBKKyqyt0gAytzZW3H8+suR0l8G6
 b6zJ5/7rSupGfh0srKnI69PR6e6avZ082Rqnkj96Nw55ec9Ro6sLtphL0YylCvQLyTrF4Y=
X-Google-Smtp-Source: AGHT+IEjjqjy5dwaDZJQPl+fyfIORlyQF+U74g99pFrDocrzGgLMAlPVEySPBv4SYJpMXmi8FkZc7aG0MYzKT2PGFWk=
X-Received: by 2002:a05:7022:3847:b0:119:e56a:4fff with SMTP id
 a92af1059eb24-11f296c903fmr2469235c88.4.1765461691537; Thu, 11 Dec 2025
 06:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20251211051635.652412-1-kevinyang.wang@amd.com>
In-Reply-To: <20251211051635.652412-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Dec 2025 09:01:19 -0500
X-Gm-Features: AQt7F2qQT53G31E_KLSNq0L7i9Omy2X3E0ZesdRn7R-NSptA9x6vEc8Ak6smGnQ
Message-ID: <CADnq5_Owz_0ywh5Q_AxWwRn9zeeuOgBeFuyE9GqF1-8DvkA96w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix wrong pcie parameter on navi10
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com, 
 alexander.deucher@amd.com, Kenneth Feng <kenneth.feng@amd.com>
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

On Thu, Dec 11, 2025 at 12:24=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com>=
 wrote:
>
> fix wrong pcie dpm parameter on navi10
>
> Fixes: 1a18607c07bb ("drm/amd/pm: override pcie dpm parameters only if it=
 is necessary")

Assuming this fixes the gitlab ticket:

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4671

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> Co-developed-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 882830770b79..0c26fe6fb949 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2216,8 +2216,8 @@ static int navi10_update_pcie_parameters(struct smu=
_context *smu,
>                                                                         p=
ptable->PcieLaneCount[i] > pcie_width_cap ?
>                                                                         p=
cie_width_cap : pptable->PcieLaneCount[i];
>                         smu_pcie_arg =3D i << 16;
> -                       smu_pcie_arg |=3D pcie_gen_cap << 8;
> -                       smu_pcie_arg |=3D pcie_width_cap;
> +                       smu_pcie_arg |=3D dpm_context->dpm_tables.pcie_ta=
ble.pcie_gen[i] << 8;
> +                       smu_pcie_arg |=3D dpm_context->dpm_tables.pcie_ta=
ble.pcie_lane[i];
>                         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                                         SMU_MSG_OverrideP=
cieParameters,
>                                                         smu_pcie_arg,
> --
> 2.34.1
>
