Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74503C4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 15:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1270610E8B2;
	Thu,  7 Dec 2023 15:03:18 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E1910E8B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 15:03:16 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1faea6773c9so641703fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 07:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701961395; x=1702566195; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4844r4veaJcnOIn8zsWADMOmvCyMEshKHmGqdlPchjg=;
 b=d6WPdq0pte6kCzOvyDq/pb+AWrBEBA3NTvrP7ZJImDxZ17vwW7ofQQ0M9v+ndZOuzl
 bP1CRSOAd+8x93IU1oDquf/dEAUldbRQUdD8STwQVlegrEunuELRYe+oyb08bNs+JUZC
 eEAUNz5K9LsUTQbjxy+5BgXPlD8nLgAL7N7313bKIVCAdNb5PG7FZbhijHKkkDwQ+Cly
 WhLgSsKtSo9qhhWfRAM16iusOSzujVrX9Malsy+3nCtVLwxVfLe6zgigK2IPP2eUdaVb
 UfVHNCdlt5rEygy5A8NZfxbAJCNVQPlFPVxmZRYDgPE7akfU6fD+/GU1fM+JYzqlSIWX
 +dVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701961395; x=1702566195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4844r4veaJcnOIn8zsWADMOmvCyMEshKHmGqdlPchjg=;
 b=Fxayqb7Xmj2wKex6NXpAgGDdyneZqDYYiozaDh6iUPr7Ndf56Kw4x9Al9kif4YNlKi
 l7foBX0tK4Rc3lywhaOOVJw1H0+LnpUlCcOZ0uFLZIX96KOr13S148RvJWHdC4JQ1YlQ
 IS+R1KBd7TFjjrEcdtSQEZwWqx3AnSAOB8+mbLnfz9ux8X+5mU4yJL+in2woK/IclgZU
 o1i6jGzGOqSXi2ogsvRLWr+oDAyoRxRkAXnRGebIOzzWULQ9Ib9CgkWRoywSdbKcJh8z
 p7qjF7isMfPzIvb3Vu4usKhvZNCLBgUoSKx98arzsz7GQrRrYK9nmC8QlXkPKx443+xL
 FE5w==
X-Gm-Message-State: AOJu0YxPIgrd7V7gFrfLYgxX5s7W9EJ9fOGbgE/w5Az4NxnGmvANy8Ck
 ZOJ7LiQs4n6aAdhmEA9CWRZuI3ggLTn+Az9fKiE=
X-Google-Smtp-Source: AGHT+IEMtNEXHXyOg3iJvoZKGDtk16r9BmEbBVhKv9Wwmz8+COGpOQziYzxYQ43oGD20miRWyM0yxcPVtMOkKMm53ww=
X-Received: by 2002:a05:6870:1e8e:b0:1fb:14cb:c911 with SMTP id
 pb14-20020a0568701e8e00b001fb14cbc911mr3261929oab.5.1701961395273; Thu, 07
 Dec 2023 07:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20231206180826.13446-1-mario.limonciello@amd.com>
In-Reply-To: <20231206180826.13446-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Dec 2023 10:03:04 -0500
Message-ID: <CADnq5_OrnkGPudqTtBOGm1doaWyaHfYBQaA_sJOGTw1zP4PCyA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Restore guard against default backlight
 value < 1 nit
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Mark Herbert <mark.herbert42@gmail.com>,
 Camille Cho <camille.cho@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 7, 2023 at 9:47=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Mark reports that brightness is not restored after Xorg dpms screen blank=
.
>
> This behavior was introduced by commit d9e865826c20 ("drm/amd/display:
> Simplify brightness initialization") which dropped the cached backlight
> value in display code, but also removed code for when the default value
> read back was less than 1 nit.
>
> Restore this code so that the backlight brightness is restored to the
> correct default value in this circumstance.
>
> Reported-by: Mark Herbert <mark.herbert42@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3031
> Cc: stable@vger.kernel.org
> Cc: Camille Cho <camille.cho@amd.com>
> Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Fixes: d9e865826c20 ("drm/amd/display: Simplify brightness initialization=
")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel=
_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_c=
ontrol.c
> index ac0fa88b52a0..bf53a86ea817 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_contro=
l.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_contro=
l.c
> @@ -287,8 +287,8 @@ bool set_default_brightness_aux(struct dc_link *link)
>         if (link && link->dpcd_sink_ext_caps.bits.oled =3D=3D 1) {
>                 if (!read_default_bl_aux(link, &default_backlight))
>                         default_backlight =3D 150000;
> -               // if > 5000, it might be wrong readback
> -               if (default_backlight > 5000000)
> +               // if < 1 nits or > 5000, it might be wrong readback
> +               if (default_backlight < 1000 || default_backlight > 50000=
00)
>                         default_backlight =3D 150000;
>
>                 return edp_set_backlight_level_nits(link, true,
> --
> 2.34.1
>
