Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D5FECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE5E10E6B3;
	Thu, 27 Oct 2022 18:02:08 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7334710E6B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:02:05 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-13bd19c3b68so3163619fac.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H+upmWfn5kuv8yTkGYHHYYOogNdYBRwjQvIIu5YnRNg=;
 b=NQ1OEoNt1ER3TArClTWqOOMCC55cgoY9YBaePAZSDpD4usrNqhgbnO+G2iv4VU70ga
 XfGDTxCcVVSmVgYg19hvCDHN3pA7PzSjwsv9a7oLfI/RbswiRzmGUAtZGRDUatO4KFrn
 C3MoJmTxUuaz7Cd42t6FaPF06u083GRplQZVFPkYRpyPDGTw4Q+0EabvnIGfY0j7XkO+
 wr1aBO2C8VKHYKC67HJ1LvldswlmMHx+QpqeXBlNcFSh3blIhckKmRNvEbhxo3CHIT9p
 wNCT4YmIbj4ckb7WSLtMsr9wkWSZRXP9CfZ4gfs1EdzX5T/5KEuB8BRWdmrBb4Nd8PBm
 Xkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H+upmWfn5kuv8yTkGYHHYYOogNdYBRwjQvIIu5YnRNg=;
 b=Gia+yXvSHDsyz2ndqEa/moch6s+9zfIiqkB0SbSFzI1U6iB7frbKa8DQW71ZNdAuF1
 3LyCERUA934qytuigYnFoTjaIl1OfAIa7on8g+98MycIlXXN/Jb1GyxaTpTfARyNBzb4
 s9T6M/1y1wrMQ83DJjBa8x5MzaUJg6PZ0UHEL/OlLrmOZpzdMN4i3mH8y7uACMfvuvWx
 bmFb4jgB2Z99i9OcYQjM9jQx/QB5VdmRHabyQpVWtljwrqHcwP7Jlere1a3GUxjlnIUG
 ucDUjoFuIuCodFLXZbh8khCap7wVTlvjvMFTQg4RHKfTSynk/WZRqEf4K/isJ1VEuYD6
 fAfg==
X-Gm-Message-State: ACrzQf01VTmkLa5ZYUquvzrs6SvnPs0jTWuFYDf+ugd109Y5Ewqscgpo
 y+spUI4uG9aIdcGUoHQcpGASzTqT0vcCXG5hhIjMP/Hc
X-Google-Smtp-Source: AMsMyM6JTpFS0fgVg8a3uL/WbX1N86u1IxGHdZbcQRcWcOXkmxuF3+7fyq/xt0w0E4pjzwsV6ixMxE4uvF2B8g175DI=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr6388923oao.96.1666893724279; Thu, 27
 Oct 2022 11:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221011212820.2669221-1-alexander.deucher@amd.com>
In-Reply-To: <20221011212820.2669221-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Oct 2022 14:01:52 -0400
Message-ID: <CADnq5_N95f0zOYzsyU86Dqz6bZa=RMtg+ef0ePdjd1zvB8OEvA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: switch to select_se_sh wrapper for gfx v9_0
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, Oct 11, 2022 at 5:28 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> From: Hawking Zhang <Hawking.Zhang@amd.com>
>
> To allow invoking ip specific callbacks
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Reviewed-by: Le Ma <le.ma@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 28 +++++++++----------
>  2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 81e3b528bbc9..e92b93557c13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -787,7 +787,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
>         for (se_idx = 0; se_idx < se_cnt; se_idx++) {
>                 for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
>
> -                       gfx_v9_0_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);
> +                       amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);
>                         queue_map = RREG32_SOC15(GC, 0, mmSPI_CSQ_WF_ACTIVE_STATUS);
>
>                         /*
> @@ -820,7 +820,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
>                 }
>         }
>
> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>         soc15_grbm_select(adev, 0, 0, 0, 0);
>         unlock_spi_csq_mutexes(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 0320be4a5fc6..456c8e189b7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1564,7 +1564,7 @@ static void gfx_v9_0_init_always_on_cu_mask(struct amdgpu_device *adev)
>                         mask = 1;
>                         cu_bitmap = 0;
>                         counter = 0;
> -                       gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
> +                       amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
>
>                         for (k = 0; k < adev->gfx.config.max_cu_per_sh; k ++) {
>                                 if (cu_info->bitmap[i][j] & mask) {
> @@ -1583,7 +1583,7 @@ static void gfx_v9_0_init_always_on_cu_mask(struct amdgpu_device *adev)
>                         cu_info->ao_cu_bitmap[i][j] = cu_bitmap;
>                 }
>         }
> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>         mutex_unlock(&adev->grbm_idx_mutex);
>  }
>
> @@ -1605,7 +1605,7 @@ static void gfx_v9_0_init_lbpw(struct amdgpu_device *adev)
>
>         mutex_lock(&adev->grbm_idx_mutex);
>         /* set mmRLC_LB_INIT_CU_MASK thru broadcast mode to enable all SE/SH*/
> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>         WREG32_SOC15(GC, 0, mmRLC_LB_INIT_CU_MASK, 0xffffffff);
>
>         /* set mmRLC_LB_PARAMS = 0x003F_1006 */
> @@ -1654,7 +1654,7 @@ static void gfx_v9_4_init_lbpw(struct amdgpu_device *adev)
>
>         mutex_lock(&adev->grbm_idx_mutex);
>         /* set mmRLC_LB_INIT_CU_MASK thru broadcast mode to enable all SE/SH*/
> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>         WREG32_SOC15(GC, 0, mmRLC_LB_INIT_CU_MASK, 0xffffffff);
>
>         /* set mmRLC_LB_PARAMS = 0x003F_1006 */
> @@ -2324,13 +2324,13 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
>         mutex_lock(&adev->grbm_idx_mutex);
>         for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
>                 for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
> -                       gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
> +                       amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
>                         data = gfx_v9_0_get_rb_active_bitmap(adev);
>                         active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
>                                                rb_bitmap_width_per_sh);
>                 }
>         }
> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>         mutex_unlock(&adev->grbm_idx_mutex);
>
>         adev->gfx.config.backend_enable_mask = active_rbs;
> @@ -2467,14 +2467,14 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
>         mutex_lock(&adev->grbm_idx_mutex);
>         for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
>                 for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
> -                       gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
> +                       amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
>                         for (k = 0; k < adev->usec_timeout; k++) {
>                                 if (RREG32_SOC15(GC, 0, mmRLC_SERDES_CU_MASTER_BUSY) == 0)
>                                         break;
>                                 udelay(1);
>                         }
>                         if (k == adev->usec_timeout) {
> -                               gfx_v9_0_select_se_sh(adev, 0xffffffff,
> +                               amdgpu_gfx_select_se_sh(adev, 0xffffffff,
>                                                       0xffffffff, 0xffffffff);
>                                 mutex_unlock(&adev->grbm_idx_mutex);
>                                 DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
> @@ -2483,7 +2483,7 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
>                         }
>                 }
>         }
> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>         mutex_unlock(&adev->grbm_idx_mutex);
>
>         mask = RLC_SERDES_NONCU_MASTER_BUSY__SE_MASTER_BUSY_MASK |
> @@ -6482,7 +6482,7 @@ static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev)
>         for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) {
>                 for (j = 0; j < gfx_v9_0_edc_counter_regs[i].se_num; j++) {
>                         for (k = 0; k < gfx_v9_0_edc_counter_regs[i].instance; k++) {
> -                               gfx_v9_0_select_se_sh(adev, j, 0x0, k);
> +                               amdgpu_gfx_select_se_sh(adev, j, 0x0, k);
>                                 RREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_0_edc_counter_regs[i]));
>                         }
>                 }
> @@ -6544,7 +6544,7 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>         for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) {
>                 for (j = 0; j < gfx_v9_0_edc_counter_regs[i].se_num; j++) {
>                         for (k = 0; k < gfx_v9_0_edc_counter_regs[i].instance; k++) {
> -                               gfx_v9_0_select_se_sh(adev, j, 0, k);
> +                               amdgpu_gfx_select_se_sh(adev, j, 0, k);
>                                 reg_value =
>                                         RREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_0_edc_counter_regs[i]));
>                                 if (reg_value)
> @@ -6559,7 +6559,7 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>         err_data->ce_count += sec_count;
>         err_data->ue_count += ded_count;
>
> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>         mutex_unlock(&adev->grbm_idx_mutex);
>
>         gfx_v9_0_query_utc_edc_status(adev, err_data);
> @@ -6963,7 +6963,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>                         mask = 1;
>                         ao_bitmap = 0;
>                         counter = 0;
> -                       gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
> +                       amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
>                         gfx_v9_0_set_user_cu_inactive_bitmap(
>                                 adev, disable_masks[i * adev->gfx.config.max_sh_per_se + j]);
>                         bitmap = gfx_v9_0_get_cu_active_bitmap(adev);
> @@ -6996,7 +6996,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>                         cu_info->ao_cu_bitmap[i % 4][j + i / 4] = ao_bitmap;
>                 }
>         }
> -       gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>         mutex_unlock(&adev->grbm_idx_mutex);
>
>         cu_info->number = active_cu_number;
> --
> 2.37.3
>
