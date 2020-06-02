Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3672EC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E80206C3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkBPLRe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E80206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C348889D1D;
	Tue,  2 Jun 2020 15:13:12 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37CFE89D00
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 15:13:11 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id l10so3761803wrr.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7qiCOwtD2niGi0YagCh79qudY/6zZQr93DHu9Ghhq0w=;
 b=BkBPLRe90/GvL78N8Enn1pUamYejHmd3IKDglk+GRTDPLoxIeDGkNao3TKABOwNElG
 jRL1HFN2B8VFIhnna0Ozl2TdEfAi+veHWlvUJYTWQAs+yS0k/1mRWQg3J4rEFUhaPDwe
 UQfC95M2TtviOlqZ8xJvHB4IV8FIXQR8KQA1dPI/bQ+7M3WvSxK5JMAeVBwgVAmDVbBO
 QPAzY8iokLVmsh7RxpazmKtaGlT9Qh4kszX3WhBpjLzhKOu+Mfq4Nq66sahsZupHGGYX
 z+nvpjNw/cnrjd03nzVurjbiS8W4CfNw8/VmpJI4xIIUe2Q29EnH4F1izA1yCrTMUF3G
 ZX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7qiCOwtD2niGi0YagCh79qudY/6zZQr93DHu9Ghhq0w=;
 b=hQPUlZnrvALzaKZ6dr1aKNDzdjQZbDA/A1bu4uimMFXZsDrTV05btMElHOoYldEC52
 SvGzJm4f1zSfaFHB+ouXpUJRegTRsMmPNf8wuJ9k4VZvE0QQeyQrPiXq/YdcMWOig6/3
 6LVcYw42ucWAjDYn94sxxa+C0bp9iVUSYXLIRMswD+LqYuIsjM6XzLpqVvDZT2yYeUP1
 z35TPOmcYAhpUygjfVZYVJNXIBhiSYsMpKCYRTOxwpjqRKvmubmYO0alE1fD4SEu6kom
 o0tAGG0Gz3usPnjeQ7PEaoYIl00Q+FFaX9voSdjzvICEbfM366yL6nPJbAwsnYwskQcF
 PvvQ==
X-Gm-Message-State: AOAM531wxVojcV9w1SHtvpQTVSdE9l0YnP7JnuzKHBJLwUKiTJG6vRiQ
 YMi16zPHaHwhemrHPqXoPcAu02r+NIMzr5scCvE=
X-Google-Smtp-Source: ABdhPJwUuLJdFePd55p1yPa5tZQ+PthRqav+klkO/lRd44Bhw+dAUGFAtCOp88u/QrU5KaVk6V1cUKQH7ED7d911LQ8=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr28428761wrp.419.1591110789855; 
 Tue, 02 Jun 2020 08:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200601073003.13044-1-evan.quan@amd.com>
 <20200601073003.13044-9-evan.quan@amd.com>
In-Reply-To: <20200601073003.13044-9-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 11:12:58 -0400
Message-ID: <CADnq5_N1eHGS2Lcs=FmKfERYkewv5Xs0_t+_rzDbLoDEL+2WbQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] drm/amd/powerplay: add firmware cleanup on sw_fini
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

On Mon, Jun 1, 2020 at 3:31 AM Evan Quan <evan.quan@amd.com> wrote:
>
> To avoid possible memory leak.
>
> Change-Id: I4740eac7fc2c6e934ec8f503e5a98057f0902f4a
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 2 ++
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   | 1 +
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h  | 2 ++
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c     | 1 +
>  drivers/gpu/drm/amd/powerplay/smu_internal.h   | 2 ++
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 9 +++++++++
>  7 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index b353ac1b0f07..197fef6f59a8 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1127,6 +1127,8 @@ static int smu_sw_fini(void *handle)
>                 return ret;
>         }
>
> +       smu_fini_microcode(smu);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index c5c23126ec2d..db2d86e3953b 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2435,6 +2435,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .i2c_eeprom_fini = arcturus_i2c_eeprom_control_fini,
>         .init_microcode = smu_v11_0_init_microcode,
>         .load_microcode = smu_v11_0_load_microcode,
> +       .fini_microcode = smu_v11_0_fini_microcode,
>         .init_smc_tables = smu_v11_0_init_smc_tables,
>         .fini_smc_tables = smu_v11_0_fini_smc_tables,
>         .init_power = smu_v11_0_init_power,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 7fed2556213f..718aecde88c0 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -495,6 +495,7 @@ struct pptable_funcs {
>         int (*get_dpm_clock_table)(struct smu_context *smu, struct dpm_clocks *clock_table);
>         int (*init_microcode)(struct smu_context *smu);
>         int (*load_microcode)(struct smu_context *smu);
> +       void (*fini_microcode)(struct smu_context *smu);
>         int (*init_smc_tables)(struct smu_context *smu);
>         int (*fini_smc_tables)(struct smu_context *smu);
>         int (*init_power)(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 8d317e05f65b..4da5f5e87c81 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -145,6 +145,8 @@ enum smu_v11_0_baco_seq {
>
>  int smu_v11_0_init_microcode(struct smu_context *smu);
>
> +void smu_v11_0_fini_microcode(struct smu_context *smu);
> +
>  int smu_v11_0_load_microcode(struct smu_context *smu);
>
>  int smu_v11_0_init_smc_tables(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index caa4355b601e..ebbbe38dfb63 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2311,6 +2311,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>         .update_pcie_parameters = navi10_update_pcie_parameters,
>         .init_microcode = smu_v11_0_init_microcode,
>         .load_microcode = smu_v11_0_load_microcode,
> +       .fini_microcode = smu_v11_0_fini_microcode,
>         .init_smc_tables = smu_v11_0_init_smc_tables,
>         .fini_smc_tables = smu_v11_0_fini_smc_tables,
>         .init_power = smu_v11_0_init_power,
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 0c7d5f0b1cd1..dbdb870011d3 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -27,6 +27,8 @@
>
>  #define smu_init_microcode(smu) \
>         ((smu)->ppt_funcs->init_microcode ? (smu)->ppt_funcs->init_microcode((smu)) : 0)
> +#define smu_fini_microcode(smu) \
> +       ((smu)->ppt_funcs->fini_microcode ? (smu)->ppt_funcs->fini_microcode((smu)) : 0)
>  #define smu_init_smc_tables(smu) \
>         ((smu)->ppt_funcs->init_smc_tables ? (smu)->ppt_funcs->init_smc_tables((smu)) : 0)
>  #define smu_fini_smc_tables(smu) \
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index e2b1c619151f..10ae4575ccb2 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -195,6 +195,15 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
>         return err;
>  }
>
> +void smu_v11_0_fini_microcode(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +
> +       release_firmware(adev->pm.fw);
> +       adev->pm.fw = NULL;
> +       adev->pm.fw_version = 0;
> +}
> +
>  int smu_v11_0_load_microcode(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
