Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AE1C4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 03:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC0C238E2
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 03:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC0C238E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B9289AEB;
	Wed,  9 Dec 2020 03:33:07 +0000 (UTC)
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9087189AEB
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 03:33:06 +0000 (UTC)
Received: by mail-oo1-xc41.google.com with SMTP id x203so57018ooa.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Dec 2020 19:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K5y977BqnDNZHK/8MYzY6GoT669C6J+HF6tXLHCsmGE=;
 b=ACOU+jYmw0DhxOZN33ZFb2tp7L/XUQr4KTg88/h2CQbfxzn4EWZtkl/4fRzas+NLJO
 pcmYi/vnu7/4LJQWgW1mT1YQpk62FhIQaCWIt5nUhcS74WSjSx3OySQI1WSOf/HztiSJ
 eWGxuMeLSNKVb7fCR3mF3XipkBNP6txPCMCIpKhR3Tzk0QJo0e4ZmpLAA7chcmpGbxT3
 Gd0jxNNBM2CUlpNGsk42Ia3PolYYut8D7DYKX3bgdA25b09jGSoYlQpjvlFs9mzZwKQS
 CfI+Ax1NOeG+LQzc2FkfrwijmVUWHKstKsxHJ32+7qskUHtV1gVxcHA7dBD/3/E1eYtT
 5y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K5y977BqnDNZHK/8MYzY6GoT669C6J+HF6tXLHCsmGE=;
 b=ERma/Z7AvaS/2HZGX5z6QM/a6V6KmmdSqhUMm1blMAcUF0perIshwTUNSTS+NGUu4a
 WqNcw6rQ8kbF3bpE+qEE0N+ag5u6grzYJr3OIqt+W9ReEOIiSVwjDJ3NjbAbqKW+ddaz
 mccnsIfGIWfyqO+kmWVF5BOt7VjsM60mRbIxIO5hdBcB3yGCZsQZfu4FszM/HZnel3wi
 U5vParKhMdXltRMGUlSe6hqRLuwz1nm97O+nfTJfDFk5Glip2oQIDEKT69Y5TnOPTa2p
 3515JXxhWLhjNCygX3LmVzXsq2JkePkBRFPnjqu3E8k79MHstaDTMRidO2S93/YlW9s2
 Q4KQ==
X-Gm-Message-State: AOAM531wkVYAFzpnCwFymcCE6p1Sg2dHu3WmlL7l4uxVpf6plTEle8ur
 WxmHwMxtruDAAX7YnOs/Hd7+9cp1l47cADuSEM1qM70X
X-Google-Smtp-Source: ABdhPJyd0tK4boeCjVy6ecXWIW7AXqqUsFEQ9CBDtReyXURodL7kMxuqYTvj3GvwEGITmxzfk15PSWr/XO39mjxqYKE=
X-Received: by 2002:a4a:d5d3:: with SMTP id a19mr283065oot.61.1607484785797;
 Tue, 08 Dec 2020 19:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20201130235852.457569-1-alexander.deucher@amd.com>
In-Reply-To: <20201130235852.457569-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Dec 2020 22:32:54 -0500
Message-ID: <CADnq5_PD1cEQtWye6ikrbUgmfW=tCpm2YMLDB7Cp2FLfc9GfVw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: move link_bandwidth_kbps under
 CONFIG_DRM_AMD_DC_DCN
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Mon, Nov 30, 2020 at 6:59 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> It's only used when CONFIG_DRM_AMD_DC_DCN is set.  Fixes and set but
> not used warning.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 08539f431586..c0e61c13b3fc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5076,9 +5076,8 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>         int preferred_refresh = 0;
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>         struct dsc_dec_dpcd_caps dsc_caps;
> -#endif
>         uint32_t link_bandwidth_kbps;
> -
> +#endif
>         struct dc_sink *sink = NULL;
>         if (aconnector == NULL) {
>                 DRM_ERROR("aconnector is NULL!\n");
> @@ -5160,11 +5159,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>                                       aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
>                                       aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
>                                       &dsc_caps);
> -#endif
>                 link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
>                                                              dc_link_get_link_cap(aconnector->dc_link));
>
> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>                 if (aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE && dsc_caps.is_dsc_supported) {
>                         /* Set DSC policy according to dsc_clock_en */
>                         dc_dsc_policy_set_enable_dsc_when_not_needed(
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
