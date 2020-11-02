Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B7CC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 18:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE032225E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 18:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvdmJWFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE032225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F1046E2D1;
	Mon,  2 Nov 2020 18:49:54 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E016E2D1
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 18:49:52 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id b3so9910614wrx.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2020 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vMgpYXsSTTh8uluAtKFGoczaRjMLSKVK0fd6wXBIoVI=;
 b=XvdmJWFmAG4OPf9AUKyQw5sa7GdmtgnDl2u1WVa/AaiK09koi4OCbzNXQaL9SqRiW8
 0KVGTL80r6UK6Q/5RimAfui9cgciupzCh4DnJjKS7MhZW6M/aUNyVO5RhF+KdJ3kj1hg
 KA8ktVZY77EYOdBdcE7sSjBlsW+rzVv5PzlODv5qdNof4hvjegJPuKr1al0BWCga95FC
 wOgATHtc60diCt8+82fMR8qz38vJnka94KlpwrEgzY/k1EPcy9gTmkMcE4uei4xxtMUL
 /Pk4U5oOZDrYsC9At2vQkrqQtMtz/yzwwxNmuDfumscX46LOrznc+Os2fb6WsbtXtVZJ
 qR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vMgpYXsSTTh8uluAtKFGoczaRjMLSKVK0fd6wXBIoVI=;
 b=tyIlFWE7oCKDlRe5fRTV5IujE3SxI4EF0up55eDH7b76BqOToeQsUfBOHlZzwV2HwC
 tphNMqo+HRK+JoPn304uCoI8I8tPL7cvc9kLCsWHudpyRuFVGmraSJXLx3C6Gizw4o21
 dCtG3TsAf/A+WKLlClN4hLVyyWH74KdBuGoGToZKTmyvz+lAhbQMHpzBy7Hb5xZpaGjX
 cM5prN1yPGaXis9aJm8BjFqpgpNygQ5jQdMVoSQXzN+ojO0c9T0kqDG2FfUXbENRIcPI
 09/IxZJTDEiGJBaWaPuUf+SEWQF/xr/nsARGZKthCoIulBSZ7Ez0OU4H1UGoDdxq5g0i
 6yKA==
X-Gm-Message-State: AOAM533xXT1uuYXoq3IYL7UHIafTduWPT3R1RXHsnPzI+0ygay9bFhk+
 jWCNhDZAYFSNwOYpvxKpc800T7KZ3qbCLw2wrPBlHVqY
X-Google-Smtp-Source: ABdhPJwN4s6pjM6q2PtfoLp9HsUdhKn7WPgbQhm6oD3cIc0nUgw08KAHEfRR1qsqb5+KxR4L+Gcr6N4wbN4WHthcACA=
X-Received: by 2002:adf:f246:: with SMTP id b6mr21616947wrp.111.1604342990917; 
 Mon, 02 Nov 2020 10:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20201027150356.1786991-1-alexander.deucher@amd.com>
In-Reply-To: <20201027150356.1786991-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2020 13:49:39 -0500
Message-ID: <CADnq5_MktP-NEq0s7c_gqV8wFYqxR21eQ1mVvGzEFF3b_K7vJw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: fix warnings when
 CONFIG_DRM_AMD_DC_DCN is not set
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

Alex

On Tue, Oct 27, 2020 at 11:04 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Properly protect the relevant code with CONFIG_DRM_AMD_DC_DCN.
>
> Fixes: 0b08c54bb7a3 ("drm/amd/display: Fix the display corruption issue on Navi10")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index fdb1fa72061a..843080e4c39e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -893,6 +893,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>         return 0;
>  }
>
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
>  {
>         uint64_t pt_base;
> @@ -945,6 +946,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>         pa_config->is_hvm_enabled = 0;
>
>  }
> +#endif
>
>  static int amdgpu_dm_init(struct amdgpu_device *adev)
>  {
> @@ -952,7 +954,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  #ifdef CONFIG_DRM_AMD_DC_HDCP
>         struct dc_callback_init init_params;
>  #endif
> -       struct dc_phy_addr_space_config pa_config;
>         int r;
>
>         adev->dm.ddev = adev_to_drm(adev);
> @@ -1060,6 +1061,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>         if (adev->asic_type == CHIP_RENOIR) {
> +               struct dc_phy_addr_space_config pa_config;
> +
>                 mmhub_read_system_context(adev, &pa_config);
>
>                 // Call the DC init_memory func
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
