Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD61C83F3E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 19:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D2210E4D3;
	Tue,  5 Sep 2023 19:53:43 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C07A10E4D3
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 19:53:41 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1c0fa9dd74fso2383285fac.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693943620; x=1694548420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=baBXgK4g6SDhnKLsbLf53kRJe1QC4e6O7SFw1quCrTk=;
 b=dplnK5b9oiv46yVJ5l/KSV/wWbfkKTLdZ2vuViHL6Tdq3x7508YUN94/fZC/gDDvrh
 HLvOUeRVsa1f4PO8H1RFO0mWTpZ6mSRT+tP4Mgy4uHyNijzAuIUlDItzKHrgRQBtO2UY
 UUrC0VDQTcNekmnPDwABbXqFcCYtqA0ubPRftaOl4FAcxqsGw88PYH752elsYHCqPPUg
 Rqwjg4vfNrHEt3RmHYV2iDn1jzXZ8sGmTy1rcjfr2K7LP0PrYpGHocjfNCPsMTytjPMN
 J/R1k9BHH8QMKpvyaHpEGm6hhIWrVgW29sUtQa+RcI6Z/Gz9ArfogT0inxhtbk3E/PR8
 PP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693943620; x=1694548420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=baBXgK4g6SDhnKLsbLf53kRJe1QC4e6O7SFw1quCrTk=;
 b=JpZByfdy3p8oTzLUk+pHM1jaWyIvOUQQKgdqMVC3cdlnQ+L7pT9wpB7P5qHsm9zThd
 IldTDHNcO54eVQRvyBLhduXxlpETNzSwNFcSoEOSl6dRbEKFLPS4/TG1ToBuygEBO/GX
 bIndTUTn/BrG30O22ope42+QAwyGrn9gpfj7oAsS4HMQthfJMgkuzOXsGT8xT5m5C3Qo
 48R7b46Q2w6z3QOPR1oyMmzzj0abrQqem5H+LkAqfjIZFL7H+mHtrFQvytHaFN7LM+/S
 AGdW4X/M5SvzM4HhfjbtSlnTNTomKSGtOQSf2RcWaEi2S5wlhX++dmDw6m6yXU+pG7Zf
 bLmQ==
X-Gm-Message-State: AOJu0YzOHt36VebX+2KAVqdGOfD6urYDechq9kO3OuZdBUqBe6LZrZaZ
 mbUi1FPnH9bs/c2Ox85Zhk3hENn2A9L/P9kAZO0=
X-Google-Smtp-Source: AGHT+IHZIRI1pSYZU8oBTPWlR7HOuJdP2d9oCi+XP61eC2kTRhOlGS3geKRy2lUvztXK1VD5NZz+g9y9t7pSRRGHT/Q=
X-Received: by 2002:a05:6870:6093:b0:1d0:bd4f:d998 with SMTP id
 t19-20020a056870609300b001d0bd4fd998mr18603821oae.55.1693943620322; Tue, 05
 Sep 2023 12:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230905192600.32449-1-mario.limonciello@amd.com>
 <20230905192600.32449-3-mario.limonciello@amd.com>
In-Reply-To: <20230905192600.32449-3-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 15:53:29 -0400
Message-ID: <CADnq5_NbV=EJvEtWkOLKTUwjkfaTHtbdqvMRBQU=icNQZX59qQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amd: Move seamless boot check out of display
To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 5, 2023 at 3:50=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> This will allow base driver to dictate whether seamless should be
> enabled.  No intended functional changes.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 21 +++++++++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +------------------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 --
>  4 files changed, 23 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 1f846650cc8b..7fb282574fa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1306,6 +1306,7 @@ void amdgpu_device_pci_config_reset(struct amdgpu_d=
evice *adev);
>  int amdgpu_device_pci_reset(struct amdgpu_device *adev);
>  bool amdgpu_device_need_post(struct amdgpu_device *adev);
>  bool amdgpu_sg_display_supported(struct amdgpu_device *adev);
> +bool amdgpu_seamless_boot_supported(struct amdgpu_device *adev);
>  bool amdgpu_device_pcie_dynamic_switching_supported(void);
>  bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
>  bool amdgpu_device_aspm_support_quirk(void);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index d45f5ea57583..72a5f77fc7b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1271,6 +1271,27 @@ bool amdgpu_sg_display_supported(struct amdgpu_dev=
ice *adev)
>         return true;
>  }
>
> +/*
> + * Check whether seamless boot is supported.
> + *
> + * So far we only support seamless boot on select ASICs.
> + * If everything goes well, we may consider expanding
> + * seamless boot to other ASICs.
> + */
> +bool amdgpu_seamless_boot_supported(struct amdgpu_device *adev)

amdgpu_device_seamless_boot_supported() for consistency with the rest
of the file.

Alex

> +{
> +       switch (adev->ip_versions[DCE_HWIP][0]) {
> +       case IP_VERSION(3, 0, 1):
> +               if (!adev->mman.keep_stolen_vga_memory)
> +                       return true;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return false;
> +}
> +
>  /*
>   * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dyn=
amic
>   * speed switching. Until we have confirmation from Intel that a specifi=
c host
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1bb1a394f55f..8961e2ec3b51 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1675,7 +1675,7 @@ static int amdgpu_dm_init(struct amdgpu_device *ade=
v)
>
>         init_data.flags.seamless_boot_edp_requested =3D false;
>
> -       if (check_seamless_boot_capability(adev)) {
> +       if (amdgpu_seamless_boot_supported(adev)) {
>                 init_data.flags.seamless_boot_edp_requested =3D true;
>                 init_data.flags.allow_seamless_boot_optimization =3D true=
;
>                 DRM_INFO("Seamless boot condition check passed\n");
> @@ -10924,27 +10924,6 @@ int amdgpu_dm_process_dmub_set_config_sync(
>         return ret;
>  }
>
> -/*
> - * Check whether seamless boot is supported.
> - *
> - * So far we only support seamless boot on CHIP_VANGOGH.
> - * If everything goes well, we may consider expanding
> - * seamless boot to other ASICs.
> - */
> -bool check_seamless_boot_capability(struct amdgpu_device *adev)
> -{
> -       switch (adev->ip_versions[DCE_HWIP][0]) {
> -       case IP_VERSION(3, 0, 1):
> -               if (!adev->mman.keep_stolen_vga_memory)
> -                       return true;
> -               break;
> -       default:
> -               break;
> -       }
> -
> -       return false;
> -}
> -
>  bool dm_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cmd=
 *cmd, enum dm_dmub_wait_type wait_type)
>  {
>         return dc_dmub_srv_cmd_run(ctx->dmub_srv, cmd, wait_type);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index a2d34be82613..4c74245add90 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -825,8 +825,6 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(struct d=
c_context *ctx, unsigned in
>  int amdgpu_dm_process_dmub_set_config_sync(struct dc_context *ctx, unsig=
ned int link_index,
>                                         struct set_config_cmd_payload *pa=
yload, enum set_config_status *operation_result);
>
> -bool check_seamless_boot_capability(struct amdgpu_device *adev);
> -
>  struct dc_stream_state *
>         create_validate_stream_for_sink(struct amdgpu_dm_connector *aconn=
ector,
>                                         const struct drm_display_mode *dr=
m_mode,
> --
> 2.34.1
>
