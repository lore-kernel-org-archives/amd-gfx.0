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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B62C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA522076A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG03zqPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA522076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC0E26EB37;
	Thu,  9 Jul 2020 20:50:58 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1A66EB37
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 20:50:57 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id s10so3723145wrw.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 13:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ldLlN569TZoZWvIaE6kqOoLRr0lf/eanVEM6JGUdxaU=;
 b=EG03zqPYm3MAtQfzefQf1tP6l+oKinphw6wOrIicB0aRjoF9Ch/TtukxkJEyWDBhYz
 UbogFnh3Xn3F4h73VawgUQfC48kuiW2BAQXvBOJQLXQwct8wbOEDWq9v0PIxww1nxDKX
 0SdJBT7YH6ee4LD4uLZFH1yutKzN9elszbkdQFspWCpsO6rZ73RCi4K04IV/w9s3kTnn
 h/bS3A39DWH6zujppZ7MT4JgHkCpOJORs3sG/Oe3Z1egTk/yyvAcgLuRftNi9QeBjjKr
 eGQjWV8uV59uMUEo/z3BYlXd4bbGW1LxNfBCcqd8MFUT5duKHgbPTh7s3bML/JcRweFV
 jF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ldLlN569TZoZWvIaE6kqOoLRr0lf/eanVEM6JGUdxaU=;
 b=ccpQE0xTCHB1IU/2Ul0+kdSgowT7Puqre4NB4L+qR365irIBS06rv2I2yqFXBqNzbR
 v41ZLMDAfUCltNEDl8phCeUDvfEdML3zak+XWm7pVn4hDZaX0eN5z2FwxNGyDlddiHyf
 jE/5fktBDuwoaL/jFul5qIZo23uQma+PtU5m7IFYXodJAypoWppuOAsE3lCkttWBqhjn
 4lVaZHrWpZ94FPJO4ykLYOvkxzukAWKCVn9j14gkCTFg1Yr0aIuvGhBeoWgIEPujlG0I
 bCvy70Ce5FJsOYAVscjmxWMX5K3ZBTLEvo/ZOfgDU8IaWnY3S6wmr/AoH2BrvRfJsKpM
 9OgA==
X-Gm-Message-State: AOAM531V0BDHRjwZ0i9grM0CemW+kLbna/PRYTeBj8p/G/ZenvbtjN6v
 UuluvFFGUAeByoIOTsLSUyDZey3A/2NHWqILoSyIa6JO
X-Google-Smtp-Source: ABdhPJxy7/ctb/rAoEN3hLhdiulJJkRHXb0ezysEto1hldI9gRtP9KlDX6RH4k6WSCNserMf6qeZIxFL+rGQqnEAj9s=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr63783853wrl.362.1594327856119; 
 Thu, 09 Jul 2020 13:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200703085515.7552-1-evan.quan@amd.com>
 <20200703085515.7552-2-evan.quan@amd.com>
In-Reply-To: <20200703085515.7552-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jul 2020 16:50:45 -0400
Message-ID: <CADnq5_O=Upoc3-L+AbSEGoOQLE+FVOEZw-e2G8VwPXRLntZMqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: correct the supported pcie
 GenSpeed and LaneCount
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

On Fri, Jul 3, 2020 at 4:55 AM Evan Quan <evan.quan@amd.com> wrote:
>
> The LCLK dpm table setup should be performed in .update_pcie_parameters().
> Otherwise, the updated GenSpeed and LaneCount information will be lost.
>
> Change-Id: I028c26ca0e54098cb93d9e9266719f1762ba2d7e
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c      | 17 +++++++----------
>  .../gpu/drm/amd/powerplay/sienna_cichlid_ppt.c  | 17 +++++++----------
>  2 files changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 3db5e663aa6f..97d14539c95e 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -693,7 +693,6 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
>         PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
>         struct smu_11_0_dpm_table *dpm_table;
>         int ret = 0;
> -       int i;
>
>         /* socclk dpm table setup */
>         dpm_table = &dpm_context->dpm_tables.soc_table;
> @@ -857,12 +856,6 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
>                 dpm_table->max = dpm_table->dpm_levels[0].value;
>         }
>
> -       /* lclk dpm table setup */
> -       for (i = 0; i < MAX_PCIE_CONF; i++) {
> -               dpm_context->dpm_tables.pcie_table.pcie_gen[i] = driver_ppt->PcieGenSpeed[i];
> -               dpm_context->dpm_tables.pcie_table.pcie_lane[i] = driver_ppt->PcieLaneCount[i];
> -       }
> -
>         return 0;
>  }
>
> @@ -1936,12 +1929,16 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
>                                      uint32_t pcie_gen_cap,
>                                      uint32_t pcie_width_cap)
>  {
> +       struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
>         PPTable_t *pptable = smu->smu_table.driver_pptable;
> -       int ret, i;
>         uint32_t smu_pcie_arg;
> +       int ret, i;
>
> -       struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
> -       struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
> +       /* lclk dpm table setup */
> +       for (i = 0; i < MAX_PCIE_CONF; i++) {
> +               dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pptable->PcieGenSpeed[i];
> +               dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pptable->PcieLaneCount[i];
> +       }
>
>         for (i = 0; i < NUM_LINK_LEVELS; i++) {
>                 smu_pcie_arg = (i << 16) |
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 7a108676f90a..46be02e4b93c 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -601,7 +601,6 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
>         PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
>         struct smu_11_0_dpm_table *dpm_table;
>         int ret = 0;
> -       int i;
>
>         /* socclk dpm table setup */
>         dpm_table = &dpm_context->dpm_tables.soc_table;
> @@ -819,12 +818,6 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
>                 dpm_table->max = dpm_table->dpm_levels[0].value;
>         }
>
> -       /* lclk dpm table setup */
> -       for (i = 0; i < MAX_PCIE_CONF; i++) {
> -               dpm_context->dpm_tables.pcie_table.pcie_gen[i] = driver_ppt->PcieGenSpeed[i];
> -               dpm_context->dpm_tables.pcie_table.pcie_lane[i] = driver_ppt->PcieLaneCount[i];
> -       }
> -
>         return 0;
>  }
>
> @@ -1722,12 +1715,16 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
>                                          uint32_t pcie_gen_cap,
>                                          uint32_t pcie_width_cap)
>  {
> +       struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
>         PPTable_t *pptable = smu->smu_table.driver_pptable;
> -       int ret, i;
>         uint32_t smu_pcie_arg;
> +       int ret, i;
>
> -       struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
> -       struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
> +       /* lclk dpm table setup */
> +       for (i = 0; i < MAX_PCIE_CONF; i++) {
> +               dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pptable->PcieGenSpeed[i];
> +               dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pptable->PcieLaneCount[i];
> +       }
>
>         for (i = 0; i < NUM_LINK_LEVELS; i++) {
>                 smu_pcie_arg = (i << 16) |
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
