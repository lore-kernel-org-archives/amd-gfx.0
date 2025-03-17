Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0D4C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 15:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C70510E426;
	Mon, 17 Mar 2025 15:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DjpgqMyD";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F89710E426
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 15:07:03 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2240b4de10eso12577935ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742224023; x=1742828823; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdHI3OVZPAQ9vB3y8yWnzPOv1rMtJ4AwdqCctY43pVQ=;
 b=DjpgqMyD0WSi9uvy0/OSR89J83YuwTUOGxeG6IHVM7K4V/ICChNH+WbLcGGy/jk3Qp
 ckykjOJg3HOTRvNXNTMjDI3QLEC6gbAYXiGKg6cvvrQ2mpvNj22AOMuv9ZW6xFvO4nDt
 vXX2DrMIcWESaua2PNNAi7YQlN9/kP4K2vy73Ta4wKWeSt1gNBYqNu5aYqqsp/5k+Fmi
 vu+r9iZjr6guZQ4ahokcjyIDzK39fi+bt/OjKyWZ/FoKEFFZNuKo8HRgomNQ65/DQkUF
 MO3eNxH6/uRpMjymkS6F/CMJd0oOPM00Mt9WoIle8xzDwmR3xbmsOS7Zev1F+d3Cmt6p
 WwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742224023; x=1742828823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BdHI3OVZPAQ9vB3y8yWnzPOv1rMtJ4AwdqCctY43pVQ=;
 b=t7Ig11vJMDDLrP2cb5bWYfpgpPdk01JIIeRB2OWOepmgkTO2idEvrx+VMDpIAo3UBG
 SYThWh9QsuCm42mRFykbFO+e5NKk0doKtLJBZBF7Yhx8RwEeVj6ur5mW82UZ4m5WR5Qp
 +4+KD/piL1Lj5l0MXi2BQSRg5lxFHu+rmqLqTU6MgNrxktlobiguoDu44/oY0Cm2ThqN
 PJLQkDWn6ABhEHCf2FKrSJnnFqxNrLdI5EMvAytplns8rU6rpZvd3kIFY7Jq+f6GzjLE
 C8f/SIHukM9NkIBfBa2nEgE181ynj4lecsVShdDk8D8K2KvAElfxxbdsqodevg739YMS
 xR7w==
X-Gm-Message-State: AOJu0YxnNf6iJ5ItJBOlSu3ZFRefDf1wVwO3aNmRIF9TVQKghRiwIy4y
 QYJazayWO74rvqSU1+iLoxpHHBI3l1Zv4ysGUhGx3y0Zdc3FZeDv6qfNBbNGNLfYxdHqw9/5uxU
 7we+HRq4DyMp8ej5qu9k5LzCbSRk=
X-Gm-Gg: ASbGncsgqLB4Ie9g9XaNNQ11xuhdL9BHr+QrHHSDdWS7dnMK1nIK4r9gi0VaH8a4BZL
 kBLTOfv7zFdWE2Ompq9vzVceonvXEhpZnU07rgQKKSOXUEzy1zOk2n3dbwGuz2ySvugjXOyz4+M
 QqvVh1aUUddxEiGeSM9YgHaT+n2w==
X-Google-Smtp-Source: AGHT+IGrg0fnjRiyOqZdJgIjNv4NDm4XXGpf+OYjvNwkD5H6rvvcMou77YbkBlt3RnTvq4U7d6xstGK2CCVJZfR+yhw=
X-Received: by 2002:a17:902:ea05:b0:224:1212:7da1 with SMTP id
 d9443c01a7336-225e0adb84amr60438145ad.13.1742224022618; Mon, 17 Mar 2025
 08:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
 <20250317060702.5297-13-alexandre.f.demers@gmail.com>
In-Reply-To: <20250317060702.5297-13-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Mar 2025 11:06:50 -0400
X-Gm-Features: AQ5f1JooSdBDMrhSMkENAktIynWZiLr2PhUQ7fNOdVOtWH_mpkjRYKIFctaCdMY
Message-ID: <CADnq5_NhUnkFaWOQODH5to6nsFAKsR0C1Y0rkwKYdckTEOTTBA@mail.gmail.com>
Subject: Re: [PATCH 12/18] drm/amdgpu: fix GFX6 variables for sid.h cleanup
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Mar 17, 2025 at 2:08=E2=80=AFAM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>

Please include a patch description.  Is this just whitespace changes?

Alex

> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index 5f85c3b63971..f34980c79a7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1731,10 +1731,14 @@ static void gfx_v6_0_constants_init(struct amdgpu=
_device *adev)
>         gfx_v6_0_get_cu_info(adev);
>         gfx_v6_0_config_init(adev);
>
> -       WREG32(mmCP_QUEUE_THRESHOLDS, ((0x16 << CP_QUEUE_THRESHOLDS__ROQ_=
IB1_START__SHIFT) |
> -                                      (0x2b << CP_QUEUE_THRESHOLDS__ROQ_=
IB2_START__SHIFT)));
> -       WREG32(mmCP_MEQ_THRESHOLDS, (0x30 << CP_MEQ_THRESHOLDS__MEQ1_STAR=
T__SHIFT) |
> -                                   (0x60 << CP_MEQ_THRESHOLDS__MEQ2_STAR=
T__SHIFT));
> +       WREG32(mmCP_QUEUE_THRESHOLDS,
> +               ((0x16 << CP_QUEUE_THRESHOLDS__ROQ_IB1_START__SHIFT) |
> +               (0x2b << CP_QUEUE_THRESHOLDS__ROQ_IB2_START__SHIFT)));
> +
> +       /* set HW defaults for 3D engine */
> +       WREG32(mmCP_MEQ_THRESHOLDS,
> +               (0x30 << CP_MEQ_THRESHOLDS__MEQ1_START__SHIFT) |
> +               (0x60 << CP_MEQ_THRESHOLDS__MEQ2_START__SHIFT));
>
>         sx_debug_1 =3D RREG32(mmSX_DEBUG_1);
>         WREG32(mmSX_DEBUG_1, sx_debug_1);
> --
> 2.48.1
>
