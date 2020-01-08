Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66AAC282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A0622072A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz5iifl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0622072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8146E8BB;
	Wed,  8 Jan 2020 16:26:22 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F326E8BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 16:26:20 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id y11so4046262wrt.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 08:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3M4pqI2y3WfgCTnMleNB3X1GKxbTef01Oc/L3PIa9pc=;
 b=Oz5iifl/StwsxuTYbyG+Ejh05GD2HBo0AgyUpuMEQAiJw2sxw1eCW8vhqZn43APtmt
 FWD0BCQ73QI0CDRw5FXUsO9HT7eEV8mZTXzPuhdpoayjYNvldj0b8UzijtGzmtxGJwQu
 Yo+Vyk+sHI1C9+FXqAtFAAqGZjyVDwytrCdHBh/n8a0oOKWpjH4UvxQ4Wk0W4DncdTMy
 MXhNwcpgXWHl/cbmHFMNyoNyHkLFGL70yaVJ8X0QwSGlwoe2X97u81Oeyhf9ElaOiIp6
 V1DUODLX4LpeBQuMRCFf/MKh5GlEmkoA6ixIdruhT97yYBSUj9us6xWzIgPayOCnG9CA
 SgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3M4pqI2y3WfgCTnMleNB3X1GKxbTef01Oc/L3PIa9pc=;
 b=BeYCwyGJu0Dex/FQQqJoSpyRGAQnQ79L8TV/qEXrrzOAmr/O/V0n5TcKh7OY9q9QFx
 vSM0A10Qt91Pow81gno80rSAOFjzLeYBUGaGUWT9KDIbuxtNLYfZV031ceMIEeebKvmf
 nUK6bVwwXdxRe0A/zSDUE9rYZ5y62fLnXJkHf5FQ4N4NOviIeaoM7L5Acpa6QpZlJ0n0
 D1GneYfF5SDfaa1oC78d2HVGh4p+7M9m0QlDXIqHWuNNZtOyfAGZrljzodzeFHmU6Y+/
 NmvydEoSOs2msVNh1+IwY3qO21HF1pZpbkxAjfhOR0Q/IWsmWEDTyKDHETSHrCjDd2G1
 Cb+w==
X-Gm-Message-State: APjAAAWyaVe8ayMEJedyTzLkhAv0NGHOg8Of/eN/JWKTDUtA4moTnelV
 9E9afvYKykCfV4OkWiQc9TYaeMvetR+zDnz76+E=
X-Google-Smtp-Source: APXvYqxfoEGPifRkLEokp9C/qRcBfiHt/HjqE01H7ggzaHOyUi+xq0I0vToTv6vN6A9tG24o2ImiDK7mH+esLeWav/0=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr5667917wrn.50.1578500779291; 
 Wed, 08 Jan 2020 08:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20200108161721.7727-1-Hawking.Zhang@amd.com>
 <20200108161721.7727-2-Hawking.Zhang@amd.com>
In-Reply-To: <20200108161721.7727-2-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jan 2020 11:26:04 -0500
Message-ID: <CADnq5_N7ZkXaNjPeAA7+2Zsv2JOOm_HRyoBPEFQ_9Uss4v5pbg@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: add query_ras_error_count function for
 sdma v4
To: Hawking Zhang <Hawking.Zhang@amd.com>
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
Cc: Gang Long <Gang.Long@amd.com>, Guchun Chen <Guchun.Chen@amd.com>,
 Tao Zhou <Tao.Zhou1@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Candice Li <Candice.Li@amd.com>,
 John Clements <John.Clements@amd.com>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 8, 2020 at 11:17 AM Hawking Zhang <Hawking.Zhang@amd.com> wrote:
>
> query_ras_error_count function will be invoked to query
> single bit error count detected in sdma ip block
>
> Change-Id: I1b17df7c66e71739ae4c31900bd96c5359af2240
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   6 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 163 +++++++++++++++++++++++
>  2 files changed, 169 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 957791673fcd..9e87a97f81fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -50,6 +50,11 @@ struct amdgpu_sdma_instance {
>         bool                    burst_nop;
>  };
>
> +struct amdgpu_sdma_ras_funcs {
> +       int (*query_ras_error_count)(struct amdgpu_device *adev,
> +                       uint32_t instance, void *ras_error_status);
> +};
> +
>  struct amdgpu_sdma {
>         struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
>         struct drm_gpu_scheduler    *sdma_sched[AMDGPU_MAX_SDMA_INSTANCES];
> @@ -61,6 +66,7 @@ struct amdgpu_sdma {
>         uint32_t                    srbm_soft_reset;
>         bool                    has_page_queue;
>         struct ras_common_if    *ras_if;
> +       const struct amdgpu_sdma_ras_funcs      *funcs;
>  };
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 4074314695c3..a00b85934b04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -82,6 +82,7 @@ static void sdma_v4_0_set_ring_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_0_set_vm_pte_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev);
> +static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev);
>
>  static const struct soc15_reg_golden golden_settings_sdma_4[] = {
>         SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
> @@ -257,6 +258,105 @@ static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
>         SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000)
>  };
>
> +static const struct soc15_ras_field_entry sdma_v4_0_ras_fields[] = {
> +       { "SDMA_UCODE_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_UCODE_BUF_SED),
> +       0, 0,
> +       },
> +       { "SDMA_RB_CMD_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_RB_CMD_BUF_SED),
> +       0, 0,
> +       },
> +       { "SDMA_IB_CMD_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_IB_CMD_BUF_SED),
> +       0, 0,
> +       },
> +       { "SDMA_UTCL1_RD_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +        SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_UTCL1_RD_FIFO_SED),
> +       0, 0,
> +        },
> +       { "SDMA_UTCL1_RDBST_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_UTCL1_RDBST_FIFO_SED),
> +       0, 0,
> +       },
> +       { "SDMA_DATA_LUT_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_DATA_LUT_FIFO_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF0_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF0_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF1_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF1_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF2_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF2_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF3_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF3_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF4_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF4_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF5_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF5_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF6_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF6_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF7_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF7_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF8_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF8_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF9_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF9_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF10_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF10_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF11_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF11_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF12_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF12_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF13_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF13_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF14_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF14_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MBANK_DATA_BUF15_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF15_SED),
> +       0, 0,
> +       },
> +       { "SDMA_SPLIT_DAT_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_SPLIT_DAT_BUF_SED),
> +       0, 0,
> +       },
> +       { "SDMA_MC_WR_ADDR_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
> +       SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MC_WR_ADDR_FIFO_SED),
> +       0, 0,
> +       },
> +};
> +
>  static u32 sdma_v4_0_get_reg_offset(struct amdgpu_device *adev,
>                 u32 instance, u32 offset)
>  {
> @@ -1687,6 +1787,7 @@ static int sdma_v4_0_early_init(void *handle)
>         sdma_v4_0_set_buffer_funcs(adev);
>         sdma_v4_0_set_vm_pte_funcs(adev);
>         sdma_v4_0_set_irq_funcs(adev);
> +       sdma_v4_0_set_ras_funcs(adev);
>
>         return 0;
>  }
> @@ -2417,6 +2518,68 @@ static void sdma_v4_0_set_vm_pte_funcs(struct amdgpu_device *adev)
>         adev->vm_manager.vm_pte_num_scheds = adev->sdma.num_instances;
>  }
>
> +static void sdma_v4_0_get_ras_error_count(uint32_t value,
> +                                       uint32_t instance,
> +                                       uint32_t *sec_count)
> +{
> +       uint32_t i;
> +       uint32_t sec_cnt;
> +
> +       /* double bits error (multiple bits) error detection is not supported */
> +       for (i = 0; i < ARRAY_SIZE(sdma_v4_0_ras_fields); i++) {
> +               /* the SDMA_EDC_COUNTER register in each sdma instance
> +                * shares the same sed shift_mask
> +                * */
> +               sec_cnt = (value &
> +                       sdma_v4_0_ras_fields[i].sec_count_mask) >>
> +                       sdma_v4_0_ras_fields[i].sec_count_shift;
> +               if (sec_cnt) {
> +                       DRM_INFO("Detected %s in SDMA%d, SED %d\n",
> +                               sdma_v4_0_ras_fields[i].name,
> +                               instance, sec_cnt);
> +                       *sec_count += sec_cnt;
> +               }
> +       }
> +}
> +
> +static int sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,
> +                       uint32_t instance, void *ras_error_status)
> +{
> +       struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
> +       uint32_t sec_count = 0;
> +       uint32_t reg_value = 0;
> +
> +       reg_value = RREG32_SDMA(instance, mmSDMA0_EDC_COUNTER);
> +       /* double bit error is not supported */
> +       if (reg_value)
> +               sdma_v4_0_get_ras_error_count(reg_value,
> +                               instance, &sec_count);
> +       /* err_data->ce_count should be initialized to 0
> +        * before calling into this function */
> +       err_data->ce_count += sec_count;
> +       /* double bit error is not supported
> +        * set ue count to 0 */
> +       err_data->ue_count = 0;
> +
> +       return 0;
> +};
> +
> +static const struct amdgpu_sdma_ras_funcs sdma_v4_0_ras_funcs = {
> +       .query_ras_error_count = sdma_v4_0_query_ras_error_count,
> +};
> +
> +static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
> +{
> +       switch (adev->asic_type) {
> +       case CHIP_VEGA20:
> +       case CHIP_ARCTURUS:
> +               adev->sdma.funcs = &sdma_v4_0_ras_funcs;
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
>  const struct amdgpu_ip_block_version sdma_v4_0_ip_block = {
>         .type = AMD_IP_BLOCK_TYPE_SDMA,
>         .major = 4,
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
