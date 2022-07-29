Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1239C00144
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 18:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D80C10E252;
	Fri, 29 Jul 2022 18:58:22 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375B410E252
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 18:58:20 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id os14so10083435ejb.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 11:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2xqqTnQzZUDDAP4Z3T0ZkazF60wdi/Y6fs9s8NzRgZU=;
 b=BUQ3WofswdGgqnbzL6DZxoXn7fHIu6x9jTnjARng7eDn+2fXM0WonBXyiFIlvoQHiv
 dN0d2Qoi5fi5sGZ+dTSsvuvDc+q263MUGwVR7FRx9dkv09K703HnmnyheZ811Wc2Banf
 2+QdbFafrPc1MooyAmcepZ6ynNxs7MsKYndAKOg+zyUUPRjMhrcJzEJcyruND61VSTG7
 KHo9WnX9YsfkN1XcXY7x7dfK4Ops/g0abV575an+pc7mXOA8FkzwBNLXCwJQxSu7giNq
 dWuaPF0PKZNPNwa27xd5oAnxo2+N+7w9DzmaqqYNwtCuhHMdTU5obmgBqps5HX2suW2u
 Dk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2xqqTnQzZUDDAP4Z3T0ZkazF60wdi/Y6fs9s8NzRgZU=;
 b=VrnQ9zy41vPNNPaO0KsGWFGhQTSYU1/z8NkCEH9Uh4VEHARd3ekGzLp0fZVeFpYDKf
 A3wviWP1LqXQ9e5Q1xcoU5SBPg1uGrA+UKK/Lu2dMhCGlqpEJqxPd0/gy5lyPr3g8php
 qwFKmTrK0Qg7GP9BREznrTw7HUpOz8H+0wpnTqQ2TAo3sPMz5+Wv6awzA4+lZAMtrX/K
 M2WGSacyvDk4gkZACjboqBAVsZIzvWeSbOndY4Kf7rUGrNOB+Pp34DJASrgiZYpky0Sj
 ME4T+mNagdf7sl+MWZYegDb7JEw4thg24Ayg50ArtmGgcFt8To2dmoceBUUaoL3hYhdR
 j3fA==
X-Gm-Message-State: AJIora/KZMeVL8MnYITNaSOZHIpaeqjs+M2pHhABkUlXIfs/YesSrEml
 UgGteMpzgztgVdY5WSJNpHRP+QKM3+7ORtB7SGrj1QzY
X-Google-Smtp-Source: AGRyM1tPziVQwlxLLnqwCFgMF9KNbXfImfdy4F48g29Avmh+dtrLLqZq14tdG2bTIsU6HWqqNJG9uTxlPu/FocqOL7g=
X-Received: by 2002:a17:907:a427:b0:72b:8cc5:5487 with SMTP id
 sg39-20020a170907a42700b0072b8cc55487mr3797985ejc.354.1659121087995; Fri, 29
 Jul 2022 11:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220729174156.346685-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220729174156.346685-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Jul 2022 14:57:56 -0400
Message-ID: <CADnq5_MVvqvAERSciUTa2YFJny5LSZaHzcv=SprHi9hpjyVsnQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add a missing register field for HPO DP
 stream encoder
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
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
Cc: harry.wentland@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Jul 29, 2022 at 1:42 PM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> [Why&How]
> Add the missing definition to set the register field
> HBLANK_MINIMUM_SYMBOL_WIDTH
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
> index 7c77c71591a0..82c3b3ac1f0d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
> @@ -162,7 +162,8 @@
>         SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, AIP_ENABLE, mask_sh),\
>         SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, ACM_ENABLE, mask_sh),\
>         SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL, CRC_ENABLE, mask_sh),\
> -       SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL, CRC_CONT_MODE_ENABLE, mask_sh)
> +       SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL, CRC_CONT_MODE_ENABLE, mask_sh),\
> +       SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL, HBLANK_MINIMUM_SYMBOL_WIDTH, mask_sh)
>
>
>  #define DCN3_1_HPO_DP_STREAM_ENC_REG_FIELD_LIST(type) \
> --
> 2.37.1
>
