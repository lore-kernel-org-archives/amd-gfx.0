Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8051AC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 18:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424216197F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 18:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424216197F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51F56EA6D;
	Fri, 19 Mar 2021 18:18:45 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655AA6EA6D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 18:18:44 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 h6-20020a0568300346b02901b71a850ab4so9399141ote.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mYXFCEPg6KrxpY4oyZYUwxPZYmNvXsmmDs77FxCT5Ew=;
 b=MIZxnV+o4DcZTc/cTTidlYysdCG1rnxW70SkQ6u8+jGMHOfoz5CJM9H0gnvY0Em7WK
 MSZo7PogViS8/32i1QE0E/GmH6R4FIfVtbrWg+/7kWFi9YmMWpS9pphi17e8BY1cf7p8
 0NKxY6vHKs9zFBa0dkiGVukG2F3d8U91OeYowl242TfD/RBixcgXm4tVJJpuX9/EDLdA
 VTP7IstsaMrfEKCPsv8IOM+Om4QIz7iWpUNoAofCjZw/haPucHsYnJu/sNZWzFrJ1HQm
 uZ6h4Uw4ujHtDlukvUUrUtL2o6Y8sM6YrJJaOVYPIXSwEhsqt2JPy4HpfQWc4QbjGXYl
 uNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mYXFCEPg6KrxpY4oyZYUwxPZYmNvXsmmDs77FxCT5Ew=;
 b=funj6p+CkZJTieDhwrRizRfsfWLVuZgTnr/vybOrSZMi9LnPQ6STaDVJjnX34q21nY
 Mo7XW+FCJfBiM39MpFpVtqQMG+ddkH1IqnNR1RDWbkLX3jzPyqkYDVn5cRwgqLovam5V
 TksuYKfRLUqPC66NidbXbQ0BQWnW6vjLwrolhYnXAicc9By7CRNRH5L0yY6qQqcyQSaZ
 6IrIwGNtQ3G0PQ0lAgciy8doJX5AvMhxq36/qRbEM+x3JhYe6pg2qJYYGL3yRP0TmIu4
 fmDMnQNcJTEajMQ63VSM4X+LpvY5djUFUcdis2unChSt+vpOHSbDfITXb3T+8sJiQzZN
 PfrA==
X-Gm-Message-State: AOAM5331ViS80x6gswWAMvVtMzeccK5pXoGGl19KP8Sm2w3Viyxj90Js
 zByyRFoH+xr7+osSncqrotxA1QJIaKbqrIhKFo4=
X-Google-Smtp-Source: ABdhPJyWAcQjpe6/e+l2kQOIj0B50ttn/h4PWisZx/HNvjQSEsNuPUc3B8kn/7xGX/IABtPA08ljr4iB1dENjn4TP+4=
X-Received: by 2002:a9d:750e:: with SMTP id r14mr2104447otk.311.1616177923784; 
 Fri, 19 Mar 2021 11:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210319021743.493548-1-alexander.deucher@amd.com>
In-Reply-To: <20210319021743.493548-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Mar 2021 14:18:32 -0400
Message-ID: <CADnq5_NyRkgZ0j8GHm6u02iByce8gb8jjNfqrdV3dtXM2eG+mg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: properly guard
 dc_dsc_stream_bandwidth_in_kbps
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Dillon Varone <dillon.varone@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Thu, Mar 18, 2021 at 10:18 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Move the function protoype to the right header and guard
> the call with CONFIG_DRM_AMD_DC_DCN as DSC is only available
> with DCN.
>
> Fixes: a03f6c0e26b2 ("drm/amd/display: Add changes for dsc bpp in 16ths and unify bw calculations")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Dillon Varone <dillon.varone@amd.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
>  drivers/gpu/drm/amd/display/dc/dc_dsc.h       | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 10e34e411e06..f9a33dc52c45 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -3498,17 +3498,17 @@ void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
>         }
>  }
>
> -uint32_t dc_dsc_stream_bandwidth_in_kbps(uint32_t pix_clk_100hz, uint32_t bpp_x16);
> -
>  uint32_t dc_bandwidth_in_kbps_from_timing(
>         const struct dc_crtc_timing *timing)
>  {
>         uint32_t bits_per_channel = 0;
>         uint32_t kbps;
>
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>         if (timing->flags.DSC) {
>                 return dc_dsc_stream_bandwidth_in_kbps(timing->pix_clk_100hz, timing->dsc_cfg.bits_per_pixel);
>         }
> +#endif
>
>         switch (timing->display_color_depth) {
>         case COLOR_DEPTH_666:
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
> index 0c5d98524536..c51d2d961b7a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
> @@ -88,4 +88,6 @@ void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit);
>
>  void dc_dsc_policy_set_enable_dsc_when_not_needed(bool enable);
>
> +uint32_t dc_dsc_stream_bandwidth_in_kbps(uint32_t pix_clk_100hz, uint32_t bpp_x16);
> +
>  #endif
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
