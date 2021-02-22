Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EE6C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 21:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38C764DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 21:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38C764DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D716E7E6;
	Mon, 22 Feb 2021 21:46:01 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D256E7E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 21:46:01 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id q186so15547683oig.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 13:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R9C4RLYNzziHklillKchCXH0Tppt5RsNCBZ/qzAfShY=;
 b=lPkininezHkP2ummzqAsjQx9RdYLCSX0u6WguwTMDpUExyD77GwY+2PtpW51F/nfMk
 m4tTqsZeIOc9deyVnrJlurOqzzq5iGVy1uB3pCmyFFKlBiss3Ao2LpDZpDNJ5zBs1yP9
 btzkTFucvsPbUnVwYMl9A9KCtyhMF5TfvGdN1v1MPG4jelBmjkGEv8nRBRotgqo1/Sj6
 pqB1rqBqGUudp9B0jaUhG9hsrBvvcuw1HjSuCusZ1oxuoDx0W05z9jmcjCwX26A8YrMR
 OQim+7Roc9euhh/CQtCMSLKdy4cxb+Ic7ZfOUNS0njN3w8D5Z0yN51CRd/f5xtamHdtj
 TS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R9C4RLYNzziHklillKchCXH0Tppt5RsNCBZ/qzAfShY=;
 b=ByxiAH9NklRqvkwPpdOtnC0St7Psxw7pC58tm/fEtsjPa0ECqE7cOTJNKxhtpdKshY
 ed8AtVS1NY06/IhxZ85hcx3SN/+sU2oUMO3NoXr93J4fxt1Ir7kW36lJPJHhDOqxDNHd
 SEo171McctHDW4uPWSBPpiHROagNXixkLJYzDUemJtVTDZDtrsrPLL4ia7XfNcZx1jlE
 vTcStTKmQwNHmjGWhAzyahKTCtBE99cUor6ir2Iqa9ona67dIcCqDcXDn5t7WDlYtQqE
 B7O2L/Ggm3GHqRWl/Yfqjj8ZuKtx4exly/qcrcBKwM9W/IlPhx7cxKI9O1ffSiMeXY+u
 IFHQ==
X-Gm-Message-State: AOAM532+So7oUy5e8heUdb84EM0tRB0CABXIjDaYUtI1yHydLJBTBbuE
 Nrj2DAhl6imhRYNFrgvZcLnVFFLYvWWSNMeE+ng=
X-Google-Smtp-Source: ABdhPJxX3bCr+j06SoadhavKJFTs+K5oq0y9CH73mDpRCmw2SMJDbC0CncZNKYYWLn6iT9TfyU5JphLU5ddC7z4qbro=
X-Received: by 2002:a05:6808:f15:: with SMTP id
 m21mr12548629oiw.123.1614030360435; 
 Mon, 22 Feb 2021 13:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20210222040329.1280956-1-evan.quan@amd.com>
In-Reply-To: <20210222040329.1280956-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Feb 2021 16:45:49 -0500
Message-ID: <CADnq5_PzDTq-499hdRQ-VL4PCPaWafMS-a-eE-Xg-83gaXrCnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: correct gpu metrics related data
 structures
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Feb 21, 2021 at 11:03 PM Evan Quan <evan.quan@amd.com> wrote:
>
> To make sure they are naturally aligned.
>
> Change-Id: I496a5b79158bdbd2e17f179098939e050b2ad489
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Won't this break existing apps that query this info?  We need to make
sure umr and rocm-smi can handle this.

Alex


> ---
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h        | 11 ++++++-----
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                |  4 ++--
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  8 ++++----
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  8 ++++----
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c        |  8 ++++----
>  5 files changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 828513412e20..3a8f64e1a10c 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -332,9 +332,9 @@ struct amd_pm_funcs {
>  };
>
>  struct metrics_table_header {
> -       uint16_t                        structure_size;
> -       uint8_t                         format_revision;
> -       uint8_t                         content_revision;
> +       uint32_t                        structure_size;
> +       uint16_t                        format_revision;
> +       uint16_t                        content_revision;
>  };
>
>  struct gpu_metrics_v1_0 {
> @@ -385,8 +385,9 @@ struct gpu_metrics_v1_0 {
>         uint16_t                        current_fan_speed;
>
>         /* Link width/speed */
> -       uint8_t                         pcie_link_width;
> -       uint8_t                         pcie_link_speed; // in 0.1 GT/s
> +       uint16_t                        pcie_link_width;
> +       uint16_t                        pcie_link_speed; // in 0.1 GT/s
> +       uint8_t                         padding[2];
>  };
>
>  struct gpu_metrics_v2_0 {
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index 50dd1529b994..f4e7a330f67f 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -284,11 +284,11 @@ int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
>
>  int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu);
>
> -int smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
> +uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
>
>  int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu);
>
> -int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
> +uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
>
>  int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
>                               bool enablement);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> index c0753029a8e2..95e905d8418d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> @@ -52,8 +52,8 @@
>
>  #define LINK_WIDTH_MAX                         6
>  #define LINK_SPEED_MAX                         3
> -static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
> -static int link_speed[] = {25, 50, 80, 160};
> +static uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
> +static uint16_t link_speed[] = {25, 50, 80, 160};
>
>  static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
>                 enum pp_clock_type type, uint32_t mask);
> @@ -2117,7 +2117,7 @@ static int vega12_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr)
>                 >> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
>  }
>
> -static int vega12_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
> +static uint16_t vega12_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
>  {
>         uint32_t width_level;
>
> @@ -2137,7 +2137,7 @@ static int vega12_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
>                 >> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
>  }
>
> -static int vega12_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
> +static uint16_t vega12_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
>  {
>         uint32_t speed_level;
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index 87811b005b85..3d462405b572 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -57,8 +57,8 @@
>
>  #define LINK_WIDTH_MAX                         6
>  #define LINK_SPEED_MAX                         3
> -static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
> -static int link_speed[] = {25, 50, 80, 160};
> +static uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
> +static uint16_t link_speed[] = {25, 50, 80, 160};
>
>  static void vega20_set_default_registry_data(struct pp_hwmgr *hwmgr)
>  {
> @@ -3279,7 +3279,7 @@ static int vega20_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr)
>                 >> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
>  }
>
> -static int vega20_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
> +static uint16_t vega20_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
>  {
>         uint32_t width_level;
>
> @@ -3299,7 +3299,7 @@ static int vega20_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
>                 >> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
>  }
>
> -static int vega20_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
> +static uint16_t vega20_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
>  {
>         uint32_t speed_level;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 60ef63073ad4..86af9832ba9c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -99,8 +99,8 @@ MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_smc.bin");
>  #define mmCG_THERMAL_STATUS_ARCT               0x90
>  #define mmCG_THERMAL_STATUS_ARCT_BASE_IDX      0
>
> -static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
> -static int link_speed[] = {25, 50, 80, 160};
> +static uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
> +static uint16_t link_speed[] = {25, 50, 80, 160};
>
>  int smu_v11_0_init_microcode(struct smu_context *smu)
>  {
> @@ -2134,7 +2134,7 @@ int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu)
>                 >> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
>  }
>
> -int smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
> +uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
>  {
>         uint32_t width_level;
>
> @@ -2154,7 +2154,7 @@ int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu)
>                 >> PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
>  }
>
> -int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
> +uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
>  {
>         uint32_t speed_level;
>
> --
> 2.29.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
