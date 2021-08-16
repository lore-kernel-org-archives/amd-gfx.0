Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BD2C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 21:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C68960F39
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 21:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C68960F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA8B66E06D;
	Mon, 16 Aug 2021 21:07:40 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F0A66E06D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 21:07:39 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id be20so28662931oib.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yw2O/wVhf0u17xamJQdejdrUxy1n0oVjTKorIDDyUvc=;
 b=ITDWA9kLz6dlrLfWkGjnOXHtaSoqKHJz3+nsTUR6UTk0Hdk6tovwxwXGZI/et3XN9w
 HYwt0+9oKz9Kphw3CgtV0S2kl6DdnLCGQUqOXgs428UFrVSv7ZKLyxs342ICSJ7s6YLe
 yt6PSqkzqLw4ItUoAFLNcgdtNgZwwo0MLNkA0BKqRDyyb+BuKDNE0NVs/eY//Sb/8mm6
 MNCG3A+gFNq7iV9YNpdbx8LLhCDXHJH6PYLRvLDsp5tw1nYRZYBuYVjwNpBJQA9ORFgh
 NNbx4LXNHOBYPQ4o85aqXmFsbDqdjcAUt5LcUxm8Sjzc2kFTlQVOVR1EK0TAPRomFpSK
 beWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yw2O/wVhf0u17xamJQdejdrUxy1n0oVjTKorIDDyUvc=;
 b=i7t4L9k7Z0LF+VpyrERvaxNmuqC0rzzxKJ8NGcPjh3La4yVMGhCKiGMINf5C554Z5i
 INrWkIcdgNQ8FV8wOZK5Av3Srho7rHKjp+Mt5NP/NUx0tZma7am6uldx7ayhFzR/F86Y
 24cKtj8UcaCU32p6J/1bsp7iTPTf4mFK6KNrn+WxTjBTbi/z7bikc/wJKdsZvMst16Pm
 U4VqAc53TUA5NadQY5Li8O9BEOeNrpgWz1IWzd8b6DL6Wy4j6l+rV3a3GCuFIisI+ehL
 H+02pgVPUDmi+LvhRzu2vUM/m7wYM3WA2C/UnrMQ8gfddS2X21lQOfnT6pFupAOez/EO
 p7aw==
X-Gm-Message-State: AOAM532B+KA6FnFUV66/B/MON3B+3shsNHy/h87u3+8bp9W3EP8SFvH6
 Edwe/mQPn8HaCI/4ojyB217EWHmVbfzbfK5hrYc=
X-Google-Smtp-Source: ABdhPJxE4mxhYIukuwPa4k9je3Y60zcVTE7isTkQNUSwzPtnVGljobcLFyHFKCz48Ohadz0b8dZO9710m5sAIj+UriU=
X-Received: by 2002:a05:6808:b1c:: with SMTP id s28mr580183oij.5.1629148058695; 
 Mon, 16 Aug 2021 14:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210816205919.614691-1-Jerry.Zuo@amd.com>
 <20210816205919.614691-3-Jerry.Zuo@amd.com>
In-Reply-To: <20210816205919.614691-3-Jerry.Zuo@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Aug 2021 17:07:27 -0400
Message-ID: <CADnq5_MxuMkomnaqa7jcu1PfDVLqBr+xwEUSCJH-tW_XsuHL5Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amd/display: Add DP 2.0 HPO Stream Encoder
To: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Wayne Lin <wayne.lin@amd.com>
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

On Mon, Aug 16, 2021 at 5:03 PM Fangzhi Zuo <Jerry.Zuo@amd.com> wrote:
>
> HW Blocks:
>
>         +--------+  +-----+  +------+
>         |  OPTC  |  | HDA |  | HUBP |
>         +--------+  +-----+  +------+
>             |          |        |
>             |          |        |
>     HPO ====|==========|========|====
>      |      |          v        |
>      |      |       +-----+     |
>      |      |       | APG |     |
>      |      |       +-----+     |
>      |      |          |        |
>      v      v          v        v
>            +----------------------+
>            |  HPO Stream Encoder  |
>            +----------------------+
>
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  35 +
>  drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
>  .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    | 761 ++++++++++++++++++
>  .../dc/dcn31/dcn31_hpo_dp_stream_encoder.h    | 241 ++++++
>  .../drm/amd/display/dc/dcn31/dcn31_resource.c |  85 ++
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +
>  .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   1 +
>  .../amd/display/dc/inc/hw/stream_encoder.h    |  79 ++
>  drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 +
>  .../amd/display/include/grph_object_defs.h    |  10 +
>  .../drm/amd/display/include/grph_object_id.h  |   6 +
>  11 files changed, 1227 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index df8a7718a85f..cffd9e6f44b2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -466,6 +466,41 @@ void dcn10_log_hw_state(struct dc *dc,
>
>         log_mpc_crc(dc, log_ctx);
>
> +#if defined(CONFIG_DRM_AMD_DC_DCN3_1)

CONFIG_DRM_AMD_DC_DCN3_1 was merged into CONFIG_DRM_AMD_DC_DCN a while
ago.  This check should be removed or changed to CONFIG_DRM_AMD_DC_DCN
depending on the circumstances.

Alex
