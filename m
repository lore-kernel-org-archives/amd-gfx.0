Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A5CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7334A6101D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7334A6101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD1066E997;
	Tue, 12 Oct 2021 14:16:10 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288ED6E997
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 14:16:10 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 w10-20020a056830280a00b0054e4e6c85a6so17016960otu.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XSG0pa5AXmzojSQ5ymZkcc5Wsi2oX0xsMI1PPZ25Oow=;
 b=JUDmLkSZVEgMyCUByenw72e2E1Qrk9Zua/9WRNdtFAUeTEMymtePzwQpZMsgv/c7U0
 /dcpn7bL6Q8JwaF4V4QuAcBfJ6tGxRSyzWDJ/CNWo8z0gaEC/xq4iSRNmsYRv378c0G2
 dxYQNfQgravoAIGXG4KA72M7mzmG2uX9AlXV4QkQgOEm+1y2B+fuRgF3NJ7VLQxyFc+L
 PCyHXyddXu0x3K17r/g3MqkNSokNaIrBGTGrbFkj7NZMg1ZsyiLDlZv7Jlr8jITCFA7E
 gXUOzJXjh5KCdcKevn0weyHyjd5nOBBtYd8lm3fA7ngbFfL2mkQZE9+P/3oafgLmBp4p
 vSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XSG0pa5AXmzojSQ5ymZkcc5Wsi2oX0xsMI1PPZ25Oow=;
 b=c9MkIA9xmY32gsnGaBBjnEAtqi3GyXjPD+PG+htetAyS2mDXrMLzy2GGgmo9pHKWH2
 +3+4+ZvXnbFvFVBZdDjEfJew0yax0o3PLRo2N8nitHwifWxG4rOsapHG+W336CBU5raF
 EWW0pSHHwpxyydnotsnd7R4UwFzGkUZD6R6lyqQWGYcfjhLq9bcUQ0hziMj60zDKYYK0
 VelgBqk8GgV8oXQ5F8z/sua0ezDqeRzQ4yZyrYVdrUjmq24jO6GReosr2XjQAHo3Lfi+
 k8PUUDsvTOz1QIjPJoiulGhy7/iHBdscgYNR4QauhyjfAFncnCOHBCUHJjuTtivBDv+k
 mMgw==
X-Gm-Message-State: AOAM531ywIRPfcRX7vZJ1BN8lDjiPR25HmZw2aGnhZRq166dxd6iTyX6
 ZpwsTGftTB02ClJDouQ39EEEk2M0fSTYwEIaXtc=
X-Google-Smtp-Source: ABdhPJzVYNsavkAeiIX7V/5ktgD3CPDHvRoohFKsL+8CAMwzlscEnDdl6gI8qbdZ3AFxEpcrUyuwGVVv5TX25j4CfNI=
X-Received: by 2002:a05:6830:214c:: with SMTP id
 r12mr25691888otd.200.1634048169284; 
 Tue, 12 Oct 2021 07:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211012141102.4590-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20211012141102.4590-1-nicholas.kazlauskas@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Oct 2021 10:15:58 -0400
Message-ID: <CADnq5_NU2PQjmJSuta-aBUZbuM=cLgrEFeGxtXSONRNF3D2Rkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix surface optimization regression on
 Carrizo
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Oct 12, 2021 at 10:11 AM Nicholas Kazlauskas
<nicholas.kazlauskas@amd.com> wrote:
>
> [Why]
> DCE legacy optimization path isn't well tested under new DC optimization
> flow which can result in underflow occuring when initializing X11 on
> Carrizo.
>
> [How]
> Retain the legacy optimization flow for DCE and keep the new one for DCN
> to satisfy optimizations being correctly applied for ASIC that can
> support it.
>
> Fixes: ab37c6527bb1 ("drm/amd/display: Optimize bandwidth on following fast update")
> Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Reported-by: Tom St Denis <tom.stdenis@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index da942e9f5142..f9876e429f26 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3118,8 +3118,13 @@ void dc_commit_updates_for_stream(struct dc *dc,
>                         if (new_pipe->plane_state && new_pipe->plane_state != old_pipe->plane_state)
>                                 new_pipe->plane_state->force_full_update = true;
>                 }
> -       } else if (update_type == UPDATE_TYPE_FAST) {
> -               /* Previous frame finished and HW is ready for optimization. */
> +       } else if (update_type == UPDATE_TYPE_FAST && dc_ctx->dce_version >= DCE_VERSION_MAX) {
> +               /*
> +                * Previous frame finished and HW is ready for optimization.
> +                *
> +                * Only relevant for DCN behavior where we can guarantee the optimization
> +                * is safe to apply - retain the legacy behavior for DCE.
> +                */
>                 dc_post_update_surfaces_to_stream(dc);
>         }
>
> @@ -3178,6 +3183,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
>                 }
>         }
>
> +       /* Legacy optimization path for DCE. */
> +       if (update_type >= UPDATE_TYPE_FULL && dc_ctx->dce_version < DCE_VERSION_MAX) {
> +               dc_post_update_surfaces_to_stream(dc);
> +               TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
> +       }
> +
>         return;
>
>  }
> --
> 2.25.1
>
