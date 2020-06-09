Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B77C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 19:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F7D206D5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 19:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5GjLIuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F7D206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 663836E332;
	Tue,  9 Jun 2020 19:51:18 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B1966E332
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 19:51:17 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id p5so22653206wrw.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jun 2020 12:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eb+bDr+R32IZ48s800bAJiVCVy57jPK2BjOcUp9gDns=;
 b=l5GjLIuuNusEM+OHYOKDbAEaxhOFnzQ4m4bDOlAKAngC9seWMcQppRTRYNfXm6bIZ1
 93xjH7zzwrBTJoF7nyTo3dkRDwvBPpaKVPmiA0S1vtiB5pKuGJNV7raMJ0MMxzUzU/lW
 oTgMCt143HNb7fM7Ar5ys2b1gHN/gDAhlACcJfTxgJtYm38gSL10H1dEnYfIsS9k9aLT
 kiLBSn1fC7h0/3kcUot3MNMwL6ioD7mv1qM3pp/qNHeKnRXCFhjDlIc4rWLJ1XH+N190
 0fshVDIIYiaNQ1ocT/OWH7fKrtPJ4fTUi98fSVnQ6D3qOJ+0sRo3HMG5t5L7c9iexe51
 Ui1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eb+bDr+R32IZ48s800bAJiVCVy57jPK2BjOcUp9gDns=;
 b=jPegAKwBlL76kqRPEqGLgbj9leTlazsUbeXDI5onplZd1IxhlSv1kOTAtp04NN5KMR
 yr5CJCWzeKMXGvwpY20YjjKJccMwN22QI/4rLuc0Q5Jv6Sl/Xbi9DM7s+/pKa3M/vCTM
 9/JLga+q7RycdUW2a6/S5yWnikoByvKpjueVT0osG0sdLbfa0ANX6jEqm7T/dX5w5MHK
 JSOLTYQVZJ+tXp6emxbMiJuA0809e6hyaUyEyCcEh+MhKAJ8UXPWVdyA72tP+M+6ySzY
 /ztRXrLxqDxOuomzXOyj8SZ/pbhePiAFSplRtIIfCgYk5ySsRLtQ6GkFmRx9vj06iLcY
 SvfQ==
X-Gm-Message-State: AOAM532C8F/syUxqz8SsP5gEpkEzVPpWt1XFPs+JEcXVu9ZeVHAXdsH1
 nBAKeygalmfhvZ5vi3uB9bG1POChGgxe2V6BCAs=
X-Google-Smtp-Source: ABdhPJwbKg1hQ0lWrxlVFHvhKNlJDNPXPsIZm5Nehn3JfesEkXDIrViVnp/7POR9sj0TJEeYTWOOYoEyQWQebVWeN3s=
X-Received: by 2002:a5d:6789:: with SMTP id v9mr6639662wru.124.1591732275961; 
 Tue, 09 Jun 2020 12:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200609100953.11866-1-evan.quan@amd.com>
 <20200609100953.11866-2-evan.quan@amd.com>
In-Reply-To: <20200609100953.11866-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Jun 2020 15:51:05 -0400
Message-ID: <CADnq5_N9_AAxR9jiGXMBst3Q040QNmxp2oPn3t=7-3MArwhPVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: drop unnecessary wrapper
 .populate_smc_tables
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

On Tue, Jun 9, 2020 at 6:10 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Since .populate_smc_tables is just a wrapper of .set_default_dpm_table.
>
> Change-Id: I80e89146359d6cf5d80f1887878d371b41b41cb0
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 2 +-
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 1 -
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     | 1 -
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      | 2 --
>  drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h      | 2 +-
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 1 -
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c         | 2 +-
>  drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 1 -
>  drivers/gpu/drm/amd/powerplay/smu_internal.h       | 2 --
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c          | 9 ---------
>  drivers/gpu/drm/amd/powerplay/smu_v12_0.c          | 2 +-
>  11 files changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 89dd12536d58..78263de02678 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -813,7 +813,7 @@ static int smu_late_init(void *handle)
>          * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
>          * type of clks.
>          */
> -       ret = smu_populate_smc_tables(smu);
> +       ret = smu_set_default_dpm_table(smu);
>         if (ret) {
>                 dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 96c9a348f8b3..ee492fc77414 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2587,7 +2587,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         /* pptable related */
>         .setup_pptable = arcturus_setup_pptable,
>         .get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> -       .populate_smc_tables = smu_v11_0_populate_smc_pptable,
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
>         .set_driver_table_location = smu_v11_0_set_driver_table_location,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 3420a58fad03..0d1429fc791b 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -505,7 +505,6 @@ struct pptable_funcs {
>         int (*check_fw_status)(struct smu_context *smu);
>         int (*setup_pptable)(struct smu_context *smu);
>         int (*get_vbios_bootup_values)(struct smu_context *smu);
> -       int (*populate_smc_tables)(struct smu_context *smu);
>         int (*check_fw_version)(struct smu_context *smu);
>         int (*powergate_sdma)(struct smu_context *smu, bool gate);
>         int (*set_gfx_cgpg)(struct smu_context *smu, bool enable);
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 9ccf62e99dcb..d6cd3d74dcfa 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -164,8 +164,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu);
>
>  int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
>
> -int smu_v11_0_populate_smc_pptable(struct smu_context *smu);
> -
>  int smu_v11_0_check_fw_version(struct smu_context *smu);
>
>  int smu_v11_0_write_pptable(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> index 7fbebc1979cf..d29f75223987 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> @@ -72,7 +72,7 @@ int smu_v12_0_init_smc_tables(struct smu_context *smu);
>
>  int smu_v12_0_fini_smc_tables(struct smu_context *smu);
>
> -int smu_v12_0_populate_smc_tables(struct smu_context *smu);
> +int smu_v12_0_set_default_dpm_tables(struct smu_context *smu);
>
>  int smu_v12_0_get_enabled_mask(struct smu_context *smu,
>                                       uint32_t *feature_mask, uint32_t num);
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index abbfcce6d9ad..ef04ab1eba94 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2423,7 +2423,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>         .check_fw_status = smu_v11_0_check_fw_status,
>         .setup_pptable = navi10_setup_pptable,
>         .get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> -       .populate_smc_tables = smu_v11_0_populate_smc_pptable,
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
>         .set_driver_table_location = smu_v11_0_set_driver_table_location,
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 6b5e60b4c039..f286c1e1934f 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -951,7 +951,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>         .gfx_off_control = smu_v12_0_gfx_off_control,
>         .init_smc_tables = smu_v12_0_init_smc_tables,
>         .fini_smc_tables = smu_v12_0_fini_smc_tables,
> -       .populate_smc_tables = smu_v12_0_populate_smc_tables,
> +       .set_default_dpm_table = smu_v12_0_set_default_dpm_tables,
>         .get_enabled_mask = smu_v12_0_get_enabled_mask,
>         .get_current_clk_freq = smu_v12_0_get_current_clk_freq,
>         .get_dpm_ultimate_freq = smu_v12_0_get_dpm_ultimate_freq,
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 6a9d04cac240..9a05fda05355 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -2593,7 +2593,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .check_fw_status = smu_v11_0_check_fw_status,
>         .setup_pptable = sienna_cichlid_setup_pptable,
>         .get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> -       .populate_smc_tables = smu_v11_0_populate_smc_pptable,
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
>         .set_driver_table_location = smu_v11_0_set_driver_table_location,
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 86c09098963a..03679eb21e0d 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -45,8 +45,6 @@
>
>  #define smu_get_vbios_bootup_values(smu) \
>         ((smu)->ppt_funcs->get_vbios_bootup_values ? (smu)->ppt_funcs->get_vbios_bootup_values((smu)) : 0)
> -#define smu_populate_smc_tables(smu) \
> -       ((smu)->ppt_funcs->populate_smc_tables ? (smu)->ppt_funcs->populate_smc_tables((smu)) : 0)
>  #define smu_check_fw_version(smu) \
>         ((smu)->ppt_funcs->check_fw_version ? (smu)->ppt_funcs->check_fw_version((smu)) : 0)
>  #define smu_write_pptable(smu) \
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 5590dab46e8c..9e3fee9e4aca 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -750,15 +750,6 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
>         return ret;
>  }
>
> -int smu_v11_0_populate_smc_pptable(struct smu_context *smu)
> -{
> -       int ret;
> -
> -       ret = smu_set_default_dpm_table(smu);
> -
> -       return ret;
> -}
> -
>  int smu_v11_0_write_pptable(struct smu_context *smu)
>  {
>         struct smu_table_context *table_context = &smu->smu_table;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> index f10113fc4571..5b56e7579ff4 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> @@ -319,7 +319,7 @@ int smu_v12_0_fini_smc_tables(struct smu_context *smu)
>         return 0;
>  }
>
> -int smu_v12_0_populate_smc_tables(struct smu_context *smu)
> +int smu_v12_0_set_default_dpm_tables(struct smu_context *smu)
>  {
>         struct smu_table_context *smu_table = &smu->smu_table;
>
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
