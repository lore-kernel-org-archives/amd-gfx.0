Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F24EC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C38820774
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsTM1JDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C38820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245C46EB30;
	Thu,  9 Jul 2020 20:39:31 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB356EB30
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 20:39:30 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id q15so3420926wmj.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MW4y/3Lrm34zFiVszkQx1H7hY3SP3dFvpkxsfIxzMx8=;
 b=UsTM1JDQK1ZKCTnSz7gr0z9wc3Yam0eH2iDVsjGIujk382Sx+/Pyj3qRrHq8M6TEdH
 zjE9AzrFjTiaVVEyDQZu9trJ3bMdnYRI5xyqMR35rfkPwRvPQGioEQ36hHzaEEGMnv1V
 IEipjGD4aVsJnHC6TZnE+zvYWf4Olnrrm+P8JBN8VmDrMcgNOyHELsaZAVyYEtq+b2Gt
 ZspXyUyXfG4w6GfxRpYpGsP1mJ4BPLOLV7QFQsGGdNB6Z3YUudxuWDjorjCw7dyyOWRA
 7ul2V+To3MQ4WebT7XN1P5PN1Un6DTnrNex5IpYXHQCFjlq/5oHKiKfdWHjIMBT11PL/
 iccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MW4y/3Lrm34zFiVszkQx1H7hY3SP3dFvpkxsfIxzMx8=;
 b=MxzcEGRxZKSHlMYPk+kLWNvbnYos26h7GdGFOtqrz72Rfb9lr8bKfwxrurOof0qYvT
 HYwbMhk1fyY4+lan9VLT83BGbMCzxt2RWZSCgQT8olDjjmNAnncwLl63fLC8tWxCrz8r
 KcgzpWifT6RqMZGRH3202TRxXs70PVgaLq97MZlVBz7sOq/ZAqNglhfyrwvB6bG858ho
 /Apj62uTGb1OJy35C8yQdMP7My0YIDw5IH9XOgKTrXGjoLJhjsTRJW6PVhC5evMYOeGv
 jHcLht4yjyPAE0xlxnq0sE1x1RTKZhzZiwUoEx7NYTSlmyXDFrzCHtHvhd5nS9FsqKFR
 FMLw==
X-Gm-Message-State: AOAM533H4JQo4RrzP4nTq8Fhy2rtCnTT+r/2iSDDbMY/Jd2CMi56hJqN
 nDUHvPpWs500SPsYoNOhEc+qMj52f36maK3dgxV8jw==
X-Google-Smtp-Source: ABdhPJyeSmO6rnZOpiipGZQe7mlRoyYwpFNDGepriIiLq+SFmSk+A5BmdBb/4H21WCv9LuEBpTb+TEs1Nqda99YLFtw=
X-Received: by 2002:a1c:de07:: with SMTP id v7mr1759440wmg.56.1594327168899;
 Thu, 09 Jul 2020 13:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200703083303.478-1-evan.quan@amd.com>
In-Reply-To: <20200703083303.478-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jul 2020 16:39:17 -0400
Message-ID: <CADnq5_NCOxgDL=qSpEWjgBGqCuBXRGTQ0tYXcy4R6ZoSPxfdMw@mail.gmail.com>
Subject: Re: [PATCH 01/14] drm/amd/powerplay: add more members for dpm table
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 3, 2020 at 4:33 AM Evan Quan <evan.quan@amd.com> wrote:
>
> These members can help to cache the clock frequencies for all
> dpm levels. Then simplifying the code for dpm level switching
> is possible.
>
> Change-Id: Ic80359adb8c0e018f306782f24e3f8906436f5e2
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 3d746b75396e..289c571d6e4e 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -48,6 +48,7 @@
>
>  #define SMU11_TOOL_SIZE                        0x19000
>
> +#define MAX_DPM_LEVELS 16
>  #define MAX_PCIE_CONF 2
>
>  #define CLK_MAP(clk, index) \
> @@ -91,9 +92,17 @@ struct smu_11_0_max_sustainable_clocks {
>         uint32_t soc_clock;
>  };
>
> +struct smu_11_0_dpm_clk_level {
> +       bool                            enabled;
> +       uint32_t                        value;
> +};
> +
>  struct smu_11_0_dpm_table {
> -       uint32_t    min;        /* MHz */
> -       uint32_t    max;        /* MHz */
> +       uint32_t                        min;        /* MHz */
> +       uint32_t                        max;        /* MHz */
> +       uint32_t                        count;
> +       bool                            is_fine_grained;
> +       struct smu_11_0_dpm_clk_level   dpm_levels[MAX_DPM_LEVELS];
>  };
>
>  struct smu_11_0_pcie_table {
> @@ -107,7 +116,9 @@ struct smu_11_0_dpm_tables {
>         struct smu_11_0_dpm_table        uclk_table;
>         struct smu_11_0_dpm_table        eclk_table;
>         struct smu_11_0_dpm_table        vclk_table;
> +       struct smu_11_0_dpm_table        vclk1_table;
>         struct smu_11_0_dpm_table        dclk_table;
> +       struct smu_11_0_dpm_table        dclk1_table;
>         struct smu_11_0_dpm_table        dcef_table;
>         struct smu_11_0_dpm_table        pixel_table;
>         struct smu_11_0_dpm_table        display_table;
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
