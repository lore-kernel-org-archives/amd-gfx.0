Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B71C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7492074B
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft1rVAHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7492074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B78BB6E406;
	Tue,  2 Jun 2020 15:01:49 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190C56E406
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 15:01:49 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d128so3487805wmc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c7vXJtrFdYzQ1lEPamJ4lEVZM97pljHIlKMcwNctAws=;
 b=Ft1rVAHmXAk+8yzkaoxmTKXF+/nnuvDGVnszL6rRUR7RuJbB0tfSfOcBkaFDBFe9DX
 qOfGp+ZubMjhTgBXRvxxHjpd5kjcdB6d5NzkAWQTvWaHxC/xqiT/fUAFs4zJNNYTSLDg
 ufVcaHNwycd4tR3a47dhsvAYvpRxeqEzK5xWT36qg6gDnrSxx8iPaqAefQgMtEXMyrhp
 wJZDZpJHxma0LDMwZ97604A0Xv4CUKs9ADy4GRl/R5k5LEiZFuZr0BGUQ98wqV1QXUWU
 r7Z+S9wnnd3g9qizY5MvafA6uNRGpL/fOKHr4sWO4/H39k8XntQN4C3LYPn2xrPMTnYT
 44RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c7vXJtrFdYzQ1lEPamJ4lEVZM97pljHIlKMcwNctAws=;
 b=FL0BZ7crrwR6IS9LGr08QiYtCNNTpZKRsrNL8/+/xkBODgBJn/hYS/9bZ3A2K2Y9bD
 3aS/h6QMrhN6g+cQftTu335VgdU0VMVXXhUB4EJNFz6QsNDxl2iM4Zp7SeuC8vLjCEBs
 Zl4cJT/htQQT5eTM1s9dtaJ5v4yqbRvGycxGWvmUbSd7DD5ZV/2wc8IHdzY8GJZv/CcN
 mypzWTOL8jeE2G3fxMCoQFyluQPtlIA3tCrhC5JwrPRupVeMcmRv03IhBPzqXZuitsGM
 D006DL/o+nIVv1MaNdYkAOAS7OXZU2FNSY6XlN9DtjI0VfaGPcyAK8OiBrZELqkJE92T
 ufEw==
X-Gm-Message-State: AOAM5336wSQn6WV/8taZbs4ibi31axm0253ji8D8o2lbykux2k9ScoHT
 nDqbtKUllCSwBGkGeJrMj5mZdwpagCjeIfDvs6M=
X-Google-Smtp-Source: ABdhPJx//UEqm1WTP10E9uwDRziX39rKsvEh4S+6F7AlcwfdGipknWzhHRRP6K7GeUhOBJ3loyJiLEt8dWDUw6vxJUQ=
X-Received: by 2002:a7b:cd96:: with SMTP id y22mr4587824wmj.56.1591110107598; 
 Tue, 02 Jun 2020 08:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200601073003.13044-1-evan.quan@amd.com>
 <20200601073003.13044-4-evan.quan@amd.com>
In-Reply-To: <20200601073003.13044-4-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 11:01:36 -0400
Message-ID: <CADnq5_Oh0t+So5N9r4MRp00fZXYeRFyYG343fwmED0sGi6WZwA@mail.gmail.com>
Subject: Re: [PATCH 4/9] drm/amd/powerplay: clean up the APIs for bootup clocks
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

On Mon, Jun 1, 2020 at 3:30 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Combine and simplify the logics for retrieving bootup
> clocks.
>
> Change-Id: Ifca28c454f3769dece0cc705ba054ff34db0ab60
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |   4 -
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |   1 -
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   1 -
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |   2 -
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |   1 -
>  drivers/gpu/drm/amd/powerplay/smu_internal.h  |   2 -
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 141 +++++++-----------
>  7 files changed, 51 insertions(+), 101 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 70c7b3fdee79..9bafa6b3e123 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1132,10 +1132,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>                 if (ret)
>                         return ret;
>
> -               ret = smu_get_clk_info_from_vbios(smu);
> -               if (ret)
> -                       return ret;
> -
>                 /*
>                  * check if the format_revision in vbios is up to pptable header
>                  * version, and the structure size is not 0.
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index e856ad36ab01..902c8cfa4a3b 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2423,7 +2423,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .check_fw_status = smu_v11_0_check_fw_status,
>         .setup_pptable = smu_v11_0_setup_pptable,
>         .get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> -       .get_clk_info_from_vbios = smu_v11_0_get_clk_info_from_vbios,
>         .check_pptable = smu_v11_0_check_pptable,
>         .parse_pptable = smu_v11_0_parse_pptable,
>         .populate_smc_tables = smu_v11_0_populate_smc_pptable,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 5bb1ac821aeb..223678e329a5 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -505,7 +505,6 @@ struct pptable_funcs {
>         int (*check_fw_status)(struct smu_context *smu);
>         int (*setup_pptable)(struct smu_context *smu);
>         int (*get_vbios_bootup_values)(struct smu_context *smu);
> -       int (*get_clk_info_from_vbios)(struct smu_context *smu);
>         int (*check_pptable)(struct smu_context *smu);
>         int (*parse_pptable)(struct smu_context *smu);
>         int (*populate_smc_tables)(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 71f829ab306e..5b785816aa64 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -161,8 +161,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu);
>
>  int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
>
> -int smu_v11_0_get_clk_info_from_vbios(struct smu_context *smu);
> -
>  int smu_v11_0_check_pptable(struct smu_context *smu);
>
>  int smu_v11_0_parse_pptable(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 652728f18271..bea6a96b5afb 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2320,7 +2320,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>         .check_fw_status = smu_v11_0_check_fw_status,
>         .setup_pptable = smu_v11_0_setup_pptable,
>         .get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> -       .get_clk_info_from_vbios = smu_v11_0_get_clk_info_from_vbios,
>         .check_pptable = smu_v11_0_check_pptable,
>         .parse_pptable = smu_v11_0_parse_pptable,
>         .populate_smc_tables = smu_v11_0_populate_smc_pptable,
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 6c59eeef2590..a31df7f4e91a 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -47,8 +47,6 @@
>
>  #define smu_get_vbios_bootup_values(smu) \
>         ((smu)->ppt_funcs->get_vbios_bootup_values ? (smu)->ppt_funcs->get_vbios_bootup_values((smu)) : 0)
> -#define smu_get_clk_info_from_vbios(smu) \
> -       ((smu)->ppt_funcs->get_clk_info_from_vbios ? (smu)->ppt_funcs->get_clk_info_from_vbios((smu)) : 0)
>  #define smu_check_pptable(smu) \
>         ((smu)->ppt_funcs->check_pptable ? (smu)->ppt_funcs->check_pptable((smu)) : 0)
>  #define smu_parse_pptable(smu) \
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 3b22f66e3fbc..be6dca8c6014 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -558,6 +558,32 @@ int smu_v11_0_fini_power(struct smu_context *smu)
>         return 0;
>  }
>
> +static int smu_v11_0_atom_get_smu_clockinfo(struct amdgpu_device *adev,
> +                                           uint8_t clk_id,
> +                                           uint8_t syspll_id,
> +                                           uint32_t *clk_freq)
> +{
> +       struct atom_get_smu_clock_info_parameters_v3_1 input = {0};
> +       struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
> +       int ret, index;
> +
> +       input.clk_id = clk_id;
> +       input.syspll_id = syspll_id;
> +       input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
> +       index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
> +                                           getsmuclockinfo);
> +
> +       ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +                                       (uint32_t *)&input);
> +       if (ret)
> +               return -EINVAL;
> +
> +       output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
> +       *clk_freq = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
> +
> +       return 0;
> +}
> +
>  int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
>  {
>         int ret, index;
> @@ -616,102 +642,37 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
>         smu->smu_table.boot_values.format_revision = header->format_revision;
>         smu->smu_table.boot_values.content_revision = header->content_revision;
>
> -       return 0;
> -}
> +       smu_v11_0_atom_get_smu_clockinfo(smu->adev,
> +                                        (uint8_t)SMU11_SYSPLL0_SOCCLK_ID,
> +                                        (uint8_t)0,
> +                                        &smu->smu_table.boot_values.socclk);
>
> -int smu_v11_0_get_clk_info_from_vbios(struct smu_context *smu)
> -{
> -       int ret, index;
> -       struct amdgpu_device *adev = smu->adev;
> -       struct atom_get_smu_clock_info_parameters_v3_1 input = {0};
> -       struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
> +       smu_v11_0_atom_get_smu_clockinfo(smu->adev,
> +                                        (uint8_t)SMU11_SYSPLL0_DCEFCLK_ID,
> +                                        (uint8_t)0,
> +                                        &smu->smu_table.boot_values.dcefclk);
>
> -       input.clk_id = SMU11_SYSPLL0_SOCCLK_ID;
> -       input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
> -       index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
> -                                           getsmuclockinfo);
> -
> -       ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> -                                       (uint32_t *)&input);
> -       if (ret)
> -               return -EINVAL;
> +       smu_v11_0_atom_get_smu_clockinfo(smu->adev,
> +                                        (uint8_t)SMU11_SYSPLL0_ECLK_ID,
> +                                        (uint8_t)0,
> +                                        &smu->smu_table.boot_values.eclk);
>
> -       output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
> -       smu->smu_table.boot_values.socclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
> +       smu_v11_0_atom_get_smu_clockinfo(smu->adev,
> +                                        (uint8_t)SMU11_SYSPLL0_VCLK_ID,
> +                                        (uint8_t)0,
> +                                        &smu->smu_table.boot_values.vclk);
>
> -       memset(&input, 0, sizeof(input));
> -       input.clk_id = SMU11_SYSPLL0_DCEFCLK_ID;
> -       input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
> -       index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
> -                                           getsmuclockinfo);
> -
> -       ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> -                                       (uint32_t *)&input);
> -       if (ret)
> -               return -EINVAL;
> -
> -       output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
> -       smu->smu_table.boot_values.dcefclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
> -
> -       memset(&input, 0, sizeof(input));
> -       input.clk_id = SMU11_SYSPLL0_ECLK_ID;
> -       input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
> -       index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
> -                                           getsmuclockinfo);
> -
> -       ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> -                                       (uint32_t *)&input);
> -       if (ret)
> -               return -EINVAL;
> -
> -       output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
> -       smu->smu_table.boot_values.eclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
> -
> -       memset(&input, 0, sizeof(input));
> -       input.clk_id = SMU11_SYSPLL0_VCLK_ID;
> -       input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
> -       index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
> -                                           getsmuclockinfo);
> -
> -       ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> -                                       (uint32_t *)&input);
> -       if (ret)
> -               return -EINVAL;
> -
> -       output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
> -       smu->smu_table.boot_values.vclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
> -
> -       memset(&input, 0, sizeof(input));
> -       input.clk_id = SMU11_SYSPLL0_DCLK_ID;
> -       input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
> -       index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
> -                                           getsmuclockinfo);
> -
> -       ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> -                                       (uint32_t *)&input);
> -       if (ret)
> -               return -EINVAL;
> -
> -       output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
> -       smu->smu_table.boot_values.dclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
> +       smu_v11_0_atom_get_smu_clockinfo(smu->adev,
> +                                        (uint8_t)SMU11_SYSPLL0_DCLK_ID,
> +                                        (uint8_t)0,
> +                                        &smu->smu_table.boot_values.dclk);
>
>         if ((smu->smu_table.boot_values.format_revision == 3) &&
> -           (smu->smu_table.boot_values.content_revision >= 2)) {
> -               memset(&input, 0, sizeof(input));
> -               input.clk_id = SMU11_SYSPLL1_0_FCLK_ID;
> -               input.syspll_id = SMU11_SYSPLL1_2_ID;
> -               input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
> -               index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
> -                                                   getsmuclockinfo);
> -
> -               ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> -                                               (uint32_t *)&input);
> -               if (ret)
> -                       return -EINVAL;
> -
> -               output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
> -               smu->smu_table.boot_values.fclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
> -       }
> +           (smu->smu_table.boot_values.content_revision >= 2))
> +               smu_v11_0_atom_get_smu_clockinfo(smu->adev,
> +                                                (uint8_t)SMU11_SYSPLL1_0_FCLK_ID,
> +                                                (uint8_t)SMU11_SYSPLL1_2_ID,
> +                                                &smu->smu_table.boot_values.fclk);
>
>         return 0;
>  }
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
