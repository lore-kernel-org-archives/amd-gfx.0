Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9DDC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 15:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5272053B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 15:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etcyWxJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5272053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A22897E9;
	Mon, 27 Jul 2020 15:24:08 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C7C89AAD
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 15:24:08 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id f1so14760591wro.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Foqs0bpQtN3Rlo5274TrlPyZalcJ4N0adiT6vAFdLnk=;
 b=etcyWxJ7uBDZ5loRLtUPDt0rEWN9iup0H+5lrGIPu7jOy0z9wXYcg50UkXkvL2CSZ4
 TxX++Jh4bynABVRvWXvDfBXcl3bMEiNucrwbNFDmyluE1W9VDLMQ5xAKtdENiyqYslCH
 sjl5lCdTgEroW13M+B8Y90C/h7eoaockHAUb5UuVrjK9YU5N0w7U5wwa98zJ66PF9Vuy
 6lzfzJJ78QnKa9xH3lwNrKr6/+twNK4PJv40Tj8MdGluDqDqBMVjKhDH/6o20ydPGRnT
 tx5RM/YZmtdOPn3KYuShL8lAqYQxPOXPbiQq6yv64ta+paPEtisVpAgZh+AR+RiMOLL/
 kDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Foqs0bpQtN3Rlo5274TrlPyZalcJ4N0adiT6vAFdLnk=;
 b=QBfsGG+DxZTtMenmIFeBXeLJAnEiY7RO/Y6gsfVdUKeVN6zrZJTdPrrtNouOk4ftf6
 j8D5xIZKOx8thVJRgFwqSyageuAXYRNJfqpnKe/upE6+A7kN3BLHXv3Iu13eIeEKaSYG
 ajZRuAs5odDNVEaW8b8uP43mxxUBK5dtZvgDaf+NNopciKTAktsgZVXAnNFY7KN07NOk
 9+t6yVoIPWR0Iw9R/5pq4+DQ14xzWexzN1+EJ2c81rYgJug53MNGfeYPFRQP4KYM94W4
 8TJ613tILhCn/lpxdYjCdB9JXfpc9EvAhacg+7EfLxiv1jP4u6fmhR4Y4Gayl/yrYB9Y
 LMVg==
X-Gm-Message-State: AOAM531TBGIxFgo1TjE4Pp+Ij79BBX7rckpwVbkyGnC6G4GKFIBKAQA3
 GYYkPOQqYbdsnWjIzFZpBsyb8wItkGZQoDNwknI=
X-Google-Smtp-Source: ABdhPJx6+buf9SQvvgBuZ9n2Wb6DPol8T3a4Tn3sG1f9O2WbRGI5h4WHnS/yD7RWlk+rk+GoYqK+N+HwHL1O9hdAXq4=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr22335940wrs.124.1595863445960; 
 Mon, 27 Jul 2020 08:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200727152204.12523-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200727152204.12523-1-Bhawanpreet.Lakha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jul 2020 11:23:54 -0400
Message-ID: <CADnq5_O=1RPvx0b++rHNgn1ibY2buqBtU+m8eADC3CnUZBLypw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use proper abm/backlight functions for
 DCN3
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 27, 2020 at 11:22 AM Bhawanpreet Lakha
<Bhawanpreet.Lakha@amd.com> wrote:
>
> Use DCN21 functions instead of DCE110
>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> index 1b354c219d0a..9afee7160490 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> @@ -26,6 +26,7 @@
>  #include "dce110/dce110_hw_sequencer.h"
>  #include "dcn10/dcn10_hw_sequencer.h"
>  #include "dcn20/dcn20_hwseq.h"
> +#include "dcn21/dcn21_hwseq.h"
>  #include "dcn30_hwseq.h"
>
>  static const struct hw_sequencer_funcs dcn30_funcs = {
> @@ -87,8 +88,8 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
>         .set_flip_control_gsl = dcn20_set_flip_control_gsl,
>         .get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
>         .apply_idle_power_optimizations = dcn30_apply_idle_power_optimizations,
> -       .set_backlight_level = dce110_set_backlight_level,
> -       .set_abm_immediate_disable = dce110_set_abm_immediate_disable,
> +       .set_backlight_level = dcn21_set_backlight_level,
> +       .set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
>  };
>
>  static const struct hwseq_private_funcs dcn30_private_funcs = {
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
