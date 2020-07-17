Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE8FC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 04:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6AE20734
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 04:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VphZGRk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6AE20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DAA36ECD4;
	Fri, 17 Jul 2020 04:47:33 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07EA6ECD4
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 04:47:31 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id q5so9622799wru.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MJT8bVlxAjLYa3rL+nz1+6+26QXbsurxcltLjde/Xhk=;
 b=VphZGRk6J/sF8yWdttPa7+uQDQgFKD3cBLt0NG04mlgUbxfsdyt9p4TzKxtDgPUxFR
 lbn05YQcKr9mLBJlE1XYb+PzJRehGHAWf0qFF2zyIAnOBHB9FDPOC/w4W41iFjdOWkdH
 kzfxqymvGTTmDeA0q5ODZkEodQRURW4NrdDGx4KYX88J//j0cO+lqy+15rqTFH0GhO2O
 e5Alo42JV0bZ3uxkdxkMRpLLh3OY5fzDmmwQggg6PSZ2jtWSMKXiq9n9G6vbZ5zlfM0U
 WGOl3mwz+xRQupkTTHLUbz5rjVPszSPJFP4ZFTcdhkKr1G5TpGSMMWg0R4xrN98CQe5K
 iLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MJT8bVlxAjLYa3rL+nz1+6+26QXbsurxcltLjde/Xhk=;
 b=mdiz63eu/+ZNRuUz7+AEk/cdFYua3CDawYE0S+uK6fi5HAWfH2V4kiATTta+ujO50w
 GjkyYEDML2JGVYnF40eCv6bc265CCkiPDOfJM0BMOqQNGSbxYKjygxsFu9XuewKuajzy
 XQ8zgLjB6Hj8l8R1hBrROkEPhG0Bee/40hfAeXZfuOGZhNIjBqB8DhWYTKg8g8uJHRXT
 DiJ7/17rOt/1WOfx17WkVJjuNVzuC71H5JtjRd8j2lHTo7M3FmhunsYF6y8vZvhqSWee
 GypuvwJCNqynXV+OIeAFyykmSCrpezNFV/G145Fs7rjigjJ0et4N3dBhZV/CPmJMjHAg
 uTqg==
X-Gm-Message-State: AOAM531/fL6hM04oNVN+l5T8ANrk8HSxXhJRl8XjCwvfTdPwMAjP3FNk
 vDR0X0StwXLb07+K03OiGraJmbxwZh6FSrbEi/0jTg==
X-Google-Smtp-Source: ABdhPJw0eOAD57/5ga21BiZKBNc9KgibOeapDiBHWQpT9pvQjGjCiC/uZpGHFlc5DnjOtBVgfIjfyjqtVQSSOmJuLu8=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr8219951wrl.362.1594961250188; 
 Thu, 16 Jul 2020 21:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200716051226.23316-1-evan.quan@amd.com>
In-Reply-To: <20200716051226.23316-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Jul 2020 00:47:18 -0400
Message-ID: <CADnq5_PnW+MMwcPEkE2V2bbvS96v5JdWQZ=2bfwo=AcQS4s2Uw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: widely share the API for data table
 retrieving
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

On Thu, Jul 16, 2020 at 1:12 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Considering the data table retrieving can be more widely shared,
> amdgpu_atombios.c is the right place.
>
> Change-Id: Id89476c14709b5676bbf043371a27f27b94a58ed
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c    | 17 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h    |  7 +++++++
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c      | 16 ----------------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c    |  3 ++-
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h  |  4 ----
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c      |  5 +++--
>  .../gpu/drm/amd/powerplay/sienna_cichlid_ppt.c  |  3 ++-
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c       |  5 +++--
>  8 files changed, 34 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index c687432da426..29f767e026e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -2036,3 +2036,20 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
>         return 0;
>  }
>
> +int amdgpu_atombios_get_data_table(struct amdgpu_device *adev,
> +                                  uint32_t table,
> +                                  uint16_t *size,
> +                                  uint8_t *frev,
> +                                  uint8_t *crev,
> +                                  uint8_t **addr)
> +{
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> index fd8f18074f7a..1321ec09c734 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> @@ -216,6 +216,13 @@ int amdgpu_atombios_get_svi2_info(struct amdgpu_device *adev,
>                               u8 voltage_type,
>                               u8 *svd_gpio_id, u8 *svc_gpio_id);
>
> +int amdgpu_atombios_get_data_table(struct amdgpu_device *adev,
> +                                  uint32_t table,
> +                                  uint16_t *size,
> +                                  uint8_t *frev,
> +                                  uint8_t *crev,
> +                                  uint8_t **addr);
> +
>  void amdgpu_atombios_fini(struct amdgpu_device *adev);
>  int amdgpu_atombios_init(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 03125c8a2145..01d669a36e1f 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -676,22 +676,6 @@ static int smu_late_init(void *handle)
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
> index 56dc20a617fd..578c50e294c7 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -27,6 +27,7 @@
>  #include "smu_internal.h"
>  #include "atomfirmware.h"
>  #include "amdgpu_atomfirmware.h"
> +#include "amdgpu_atombios.h"
>  #include "smu_v11_0.h"
>  #include "smu11_driver_if_arcturus.h"
>  #include "soc15_common.h"
> @@ -488,7 +489,7 @@ static int arcturus_append_powerplay_table(struct smu_context *smu)
>         index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                            smc_dpm_info);
>
> -       ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
> +       ret = amdgpu_atombios_get_data_table(smu->adev, index, NULL, NULL, NULL,
>                                       (uint8_t **)&smc_dpm_table);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 70181ba7ee0c..ba9beffb887d 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -678,10 +678,6 @@ bool smu_mode1_reset_is_support(struct smu_context *smu);
>  int smu_mode1_reset(struct smu_context *smu);
>  int smu_mode2_reset(struct smu_context *smu);
>
> -extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
> -                                  uint16_t *size, uint8_t *frev, uint8_t *crev,
> -                                  uint8_t **addr);
> -
>  extern const struct amd_ip_funcs smu_ip_funcs;
>
>  extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index ead135f39c7e..0c21e5de8997 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -28,6 +28,7 @@
>  #include "smu_internal.h"
>  #include "atomfirmware.h"
>  #include "amdgpu_atomfirmware.h"
> +#include "amdgpu_atombios.h"
>  #include "soc15_common.h"
>  #include "smu_v11_0.h"
>  #include "smu11_driver_if_navi10.h"
> @@ -467,7 +468,7 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
>         index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                            smc_dpm_info);
>
> -       ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
> +       ret = amdgpu_atombios_get_data_table(adev, index, NULL, NULL, NULL,
>                                       (uint8_t **)&smc_dpm_table);
>         if (ret)
>                 return ret;
> @@ -487,7 +488,7 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
>                         sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
>                 break;
>         case 7: /* nv12 */
> -               ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
> +               ret = amdgpu_atombios_get_data_table(adev, index, NULL, NULL, NULL,
>                                               (uint8_t **)&smc_dpm_table_v4_7);
>                 if (ret)
>                         return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 5faef41b63a3..389d8350534a 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -28,6 +28,7 @@
>  #include "smu_internal.h"
>  #include "atomfirmware.h"
>  #include "amdgpu_atomfirmware.h"
> +#include "amdgpu_atombios.h"
>  #include "smu_v11_0.h"
>  #include "smu11_driver_if_sienna_cichlid.h"
>  #include "soc15_common.h"
> @@ -399,7 +400,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
>         index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                             smc_dpm_info);
>
> -       ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
> +       ret = amdgpu_atombios_get_data_table(smu->adev, index, NULL, NULL, NULL,
>                                       (uint8_t **)&smc_dpm_table);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 829c15984847..06a2ea12cba0 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -32,6 +32,7 @@
>  #include "smu_internal.h"
>  #include "atomfirmware.h"
>  #include "amdgpu_atomfirmware.h"
> +#include "amdgpu_atombios.h"
>  #include "smu_v11_0.h"
>  #include "soc15_common.h"
>  #include "atom.h"
> @@ -416,7 +417,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
>                 index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                                     powerplayinfo);
>
> -               ret = smu_get_atom_data_table(smu, index, &atom_table_size, &frev, &crev,
> +               ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
>                                               (uint8_t **)&table);
>                 if (ret)
>                         return ret;
> @@ -631,7 +632,7 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
>         index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>                                             firmwareinfo);
>
> -       ret = smu_get_atom_data_table(smu, index, &size, &frev, &crev,
> +       ret = amdgpu_atombios_get_data_table(smu->adev, index, &size, &frev, &crev,
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
