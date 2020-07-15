Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B55C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 17:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9A720656
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 17:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLMvK32N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9A720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99106EBAB;
	Wed, 15 Jul 2020 17:58:39 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAB16EBAB
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 17:58:38 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z15so3667178wrl.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Kg52lOnalNxiPxP9kzQTKmcGAyfAk7IlVeAFPnBaLwI=;
 b=NLMvK32Nctf1zEuMgHzhxY15ydrbZEGTUX8n3MdINxtPFSXc315ehTsj2tlpEW3DhR
 xKyZXMm3hV5arSdDZJFxDxIH+gIYuqbpdOVIpivie3AxznzKdMEJ/TjXsTD4Mo+Auddk
 WUiTblSWM9L9j+JS9h1gLDYgO3eRTLx1OhhWW3s2OmngjWzBHouIIYaM+EOv81NXkFET
 Zcbqcf0ZwpmvcHQE3LPsVRRa8UBo3Im2YrZvP3WBw6viFaXn2ZI7lZwpr9pEdyJW1QBE
 wHPx8vD7yC5PrGbTmdqYuKEq1FYNCEH8M2rShhE4LhvwJCRdALYEGwjDBJjnuDqx44M4
 wdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kg52lOnalNxiPxP9kzQTKmcGAyfAk7IlVeAFPnBaLwI=;
 b=pfkQqLw/DzSpuIIKtncIkvGV7BHQ2ILWwmSernM3fpmQHtSirklZ+gDigRzsV/Lz3y
 43+Eou+ikx92Uz0SDYQAOrtcei9wtmq8woCnPSwjA2ptV3jTeWU+9u/M/hCDAWyZTuD8
 WHNlVUn3nCAmcKl62zllhJaDiHN6RDEl31G+T9By6ihQWB9ROQG/iw065Tx64OfPRUov
 5AxMFug9U3fMC+GkCqliUsDdieMqpYfEEfSZBkop3uHrTludhxPFaMx/GuZeLnLjhL5a
 LQDz4alWXv+1rmpyk9vOsyHtRC3Mf8c9VPo4jzDZdGAM+h17FOXfGhhnRLVaJkw2FHlI
 fgyw==
X-Gm-Message-State: AOAM532d6gqTWPu6BMFpMgyA2A/IlU8nhcd7sIblbkM1bDZiV6cQLjPl
 2dHj/cbBb9UGDzQjD01OUYoEqvx9WKh0upFYul/Alg==
X-Google-Smtp-Source: ABdhPJwsXNACC3Iwazioayim6S/MIB3Y/FrGUSTIbuzhxx7egkrmvjwxwNBB++v4d7hE+uFvcterNVqnEe+2NQP0hgo=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr545387wrl.362.1594835916708; 
 Wed, 15 Jul 2020 10:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200714080416.6506-1-evan.quan@amd.com>
In-Reply-To: <20200714080416.6506-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jul 2020 13:58:25 -0400
Message-ID: <CADnq5_OBuTLPY9hcFzxCwesykAr3HcT6Etxar3xexhG4eNGNpw@mail.gmail.com>
Subject: Re: [PATCH 01/17] drm/amd/powerplay: move the API shared by SMU v11
 to smu_v11_0.c
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

On Tue, Jul 14, 2020 at 4:04 AM Evan Quan <evan.quan@amd.com> wrote:
>
> To fit our original desgin and this can help to maintain
> clear code layer.
>
> Change-Id: Id89476c14709b5676bbf043371a27f27b94a58ed
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 16 ---------------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  2 +-
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  4 ----
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  4 ++++
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  4 ++--
>  .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  2 +-
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 20 +++++++++++++++++--
>  7 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 16ff64644e2e..0daea412d0a0 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -675,22 +675,6 @@ static int smu_late_init(void *handle)
>         return 0;
>  }
>
> -int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
> -                           uint16_t *size, uint8_t *frev, uint8_t *crev,
> -                           uint8_t **addr)
> -{
> -       struct amdgpu_device *adev = smu->adev;
> -       uint16_t data_start;
> -
> -       if (!amdgpu_atom_parse_data_header(adev->mode_info.atom_context, table,
> -                                          size, frev, crev, &data_start))
> -               return -EINVAL;
> -
> -       *addr = (uint8_t *)adev->mode_info.atom_context->bios + data_start;
> -
> -       return 0;
> -}
> -
>  static int smu_init_fb_allocations(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 56dc20a617fd..03361d0194fe 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -488,7 +488,7 @@ static int arcturus_append_powerplay_table(struct smu_context *smu)
>         index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                            smc_dpm_info);
>
> -       ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
> +       ret = smu_v11_0_get_atom_data_table(smu, index, NULL, NULL, NULL,
>                                       (uint8_t **)&smc_dpm_table);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 52e5603dcc97..28894b8bab67 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -674,10 +674,6 @@ int smu_baco_exit(struct smu_context *smu);
>
>  int smu_mode2_reset(struct smu_context *smu);
>
> -extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
> -                                  uint16_t *size, uint8_t *frev, uint8_t *crev,
> -                                  uint8_t **addr);
> -
>  extern const struct amd_ip_funcs smu_ip_funcs;
>
>  extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 9b724e4aceaa..8a4053d8eb8c 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -175,6 +175,10 @@ int smu_v11_0_fini_power(struct smu_context *smu);
>
>  int smu_v11_0_check_fw_status(struct smu_context *smu);
>
> +int smu_v11_0_get_atom_data_table(struct smu_context *smu, uint32_t table,
> +                           uint16_t *size, uint8_t *frev, uint8_t *crev,
> +                           uint8_t **addr);
> +
>  int smu_v11_0_setup_pptable(struct smu_context *smu);
>
>  int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 41bd6d157271..ff717b800086 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -467,7 +467,7 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
>         index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                            smc_dpm_info);
>
> -       ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
> +       ret = smu_v11_0_get_atom_data_table(smu, index, NULL, NULL, NULL,
>                                       (uint8_t **)&smc_dpm_table);
>         if (ret)
>                 return ret;
> @@ -487,7 +487,7 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
>                         sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
>                 break;
>         case 7: /* nv12 */
> -               ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
> +               ret = smu_v11_0_get_atom_data_table(smu, index, NULL, NULL, NULL,
>                                               (uint8_t **)&smc_dpm_table_v4_7);
>                 if (ret)
>                         return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 48c5424f6f37..8a25921d28a9 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -398,7 +398,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
>         index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                             smc_dpm_info);
>
> -       ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
> +       ret = smu_v11_0_get_atom_data_table(smu, index, NULL, NULL, NULL,
>                                       (uint8_t **)&smc_dpm_table);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index fbd561a4d0eb..416aa536a57e 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -370,6 +370,22 @@ static int smu_v11_0_set_pptable_v2_1(struct smu_context *smu, void **table,
>         return 0;
>  }
>
> +int smu_v11_0_get_atom_data_table(struct smu_context *smu, uint32_t table,
> +                           uint16_t *size, uint8_t *frev, uint8_t *crev,
> +                           uint8_t **addr)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       uint16_t data_start;
> +
> +       if (!amdgpu_atom_parse_data_header(adev->mode_info.atom_context, table,
> +                                          size, frev, crev, &data_start))
> +               return -EINVAL;
> +
> +       *addr = (uint8_t *)adev->mode_info.atom_context->bios + data_start;
> +
> +       return 0;
> +}

This is not really smu11 specific.  I think it would be better in the
smu_cmn file or even amdgpu_atombios.c.

Patches 2-17:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +
>  int smu_v11_0_setup_pptable(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
> @@ -406,7 +422,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
>                 index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                                     powerplayinfo);
>
> -               ret = smu_get_atom_data_table(smu, index, &atom_table_size, &frev, &crev,
> +               ret = smu_v11_0_get_atom_data_table(smu, index, &atom_table_size, &frev, &crev,
>                                               (uint8_t **)&table);
>                 if (ret)
>                         return ret;
> @@ -621,7 +637,7 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
>         index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                             firmwareinfo);
>
> -       ret = smu_get_atom_data_table(smu, index, &size, &frev, &crev,
> +       ret = smu_v11_0_get_atom_data_table(smu, index, &size, &frev, &crev,
>                                       (uint8_t **)&header);
>         if (ret)
>                 return ret;
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
