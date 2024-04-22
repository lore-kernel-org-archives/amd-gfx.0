Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF72C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 14:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D05112B21;
	Mon, 22 Apr 2024 14:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lWuXZx0E";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4DFC112B21
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 14:04:24 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2a2d82537efso2976151a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713794664; x=1714399464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBgAPrFZ5lCCMEYZ+PydteNpegMeSTwLNfYeFT8AVFI=;
 b=lWuXZx0E7kDsIDLZNMMmpNEA6Vi52LZmvRXYxnGal9KJjYRtQkyIFmnAVeebYBLEWS
 lTKWXPoltSvA139DJbSBFiasHXkS9Qm/vyKoSe0FSX/YvdgZlGB3lVGVeHvUDmRUPNuG
 1FNLdRcqhdezbubLcsIMfmvCn6KCYms9cnTKGAu/0+YuUAE6ug9ke1E0ao3yYb/tYXbh
 k8VXPNYLwpkhhML9AaORPh/9KU+XeWgcE2lCwsiRRtAmo33fQZA0xUgnXz4BxUVBHZpa
 OoxemvjGJy3jlrCHRfy/w4Psq3w+bFlu+mtM7OG1zNDhJor6uC9FTR/DP/lu4A7WMZsZ
 mbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713794664; x=1714399464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBgAPrFZ5lCCMEYZ+PydteNpegMeSTwLNfYeFT8AVFI=;
 b=H/iT4PPkzFIkt04AdAq5J0aMBimOD/ta5Bzf008YYjjRUnZvzb7dmqPnQmLEx949JV
 1Pu+zP0kiCytnjTSOJ61iXzNWuSPPiFLVvODFUoNBiA+9Amr2a96I8bjjqZo39jbu9T9
 jTqm6joxnwUpySwgmgNoh0uH8jWLihYYB7tlOoNeZ7T26WTsH36UDAviOJFm+An+4kQ8
 XTy4iVPeHhyY+CqcmH0pjL7BI5fJ9tqvZjKpQ/xyfAEPcZQqYRSJqlHcNAPfvS0Ga6Jf
 cq5NKrLQtgd/7AJKuxBdQKJ5qRp3fv4qrw7joxBEfbTwmg7GRMaySKIMN6nSKjJVL5iW
 TbIQ==
X-Gm-Message-State: AOJu0YzMUp8gXKFYEoL5C9ugc6BoRpS6nSChxyMiNnE485+Qg6HcrjHK
 F8X3mfu3kbd7xd7hX+qKNc0oWoHHZMXTFoSNopM2o2bS0IYgjPeY/66qUUo2LtVXXMvKqqm24q0
 pGZqk4CjJmrg84RoD8862XLgPzVY=
X-Google-Smtp-Source: AGHT+IHueWuh7C2sCQS3yod0jUlFnjju35YVCLpLn7ItNxGjkHseJVkKcTmIgFfRLUCuEhamU68fE8QeCxp6lyPJ0/8=
X-Received: by 2002:a17:90a:6b47:b0:2a5:cf58:ad03 with SMTP id
 x7-20020a17090a6b4700b002a5cf58ad03mr9595914pjl.37.1713794664060; Mon, 22 Apr
 2024 07:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240422135157.3341796-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240422135157.3341796-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Apr 2024 10:04:11 -0400
Message-ID: <CADnq5_M6+jawmfqWnhZrx26jLCLZCf+CCtA7wxLzXt1h4z_2Lg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Add fallback configuration when
 set DRR"
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Mark Broadworth <Mark.Broadworth@amd.com>, 
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
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

On Mon, Apr 22, 2024 at 10:02=E2=80=AFAM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> This reverts commit 5ea4581611d14a6a0e8df40965802ec7bee9c671.
>
> This change must be reverted since it caused soft hangs when changing
> the refresh rate to 122 & 144Hz when using a 7000 series GPU.
>
> Reported-by: Mark Broadworth <Mark.Broadworth@amd.com>
> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c    | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/dri=
vers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
> index c4f0e1951427..52eab8fccb7f 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
> @@ -293,16 +293,9 @@ static void optc32_set_drr(
>                 }
>
>                 optc->funcs->set_vtotal_min_max(optc, params->vertical_to=
tal_min - 1, params->vertical_total_max - 1);
> -               optc32_setup_manual_trigger(optc);
> -       } else {
> -               REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
> -                               OTG_SET_V_TOTAL_MIN_MASK, 0,
> -                               OTG_V_TOTAL_MIN_SEL, 0,
> -                               OTG_V_TOTAL_MAX_SEL, 0,
> -                               OTG_FORCE_LOCK_ON_EVENT, 0);
> -
> -               optc->funcs->set_vtotal_min_max(optc, 0, 0);
>         }
> +
> +       optc32_setup_manual_trigger(optc);
>  }
>
>  static struct timing_generator_funcs dcn32_tg_funcs =3D {
> --
> 2.43.0
>
