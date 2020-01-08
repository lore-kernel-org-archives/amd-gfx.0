Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E6BC33CA1
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976992072A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoDWGJSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976992072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61DF66E2EA;
	Wed,  8 Jan 2020 16:27:41 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A3EC6E8B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 16:27:39 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z3so4075649wru.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 08:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6XNkmKK6qS9xXUET7EwsPlVghFJuGA2/wx/mxC2aVVg=;
 b=qoDWGJSeFx9Bsx06jhjZweBLsAT3zFhwBnTycG5Ee14H15gowsKGTCNzlL7j154TxL
 5MdVHRGEfI9nKF8xxfyG1TuO1vFojKABTmStT57/11X92F+jWAUf8tcHcdNbesmMOPTC
 M0JD9DnrdFwF62jg4GWuZ66f8mhbouy3w+6oTjDAj9v6zfcJBp9KuXcJTFx4fDeyz1TB
 WTaNrKM0f12xjgCeL/Vu3ZMqbyiVSIH8PLtuRNWKwr0fDwRfif5wgftsI0wC5poqaNIK
 yIf2LuUKJfNfRYq27AtwKqrpO/2EcLAQ7avGBMjAYoB9fWfm8oxEFMlBrghRMcv88AZG
 0xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6XNkmKK6qS9xXUET7EwsPlVghFJuGA2/wx/mxC2aVVg=;
 b=Ay0t0UX7F8gkSfYXlcIdWjk1fU8LNPsCycd6e8lEnNbdiMwzWwD+C1DDvG8/XyOgd5
 477C4e4Wf8O3NPTbAq27bJ4Yn2+MsLyVcvN4GAliv/TTP5bClm/qE9IwFJrbEspiC1JT
 0MWijss09fj05+NW4I+jpWoIFise527aG/3mJeJSBBZ5Wb6ktrAwLkGhCAz6RTV/FX9I
 ybkp+upbRMwWRbnFMipYY7qD6vSomNPeU8DH3UHX/iYHE+uNFcSk8EAvu4N7DLwE/Nlt
 TLJFcBSSvKO1c9b7nbrExXGDTAauK7kiGQ83QasPRoADpfnzCU9AWI9JNFacSjs4bTjh
 nOXA==
X-Gm-Message-State: APjAAAWGXlXEUNSJ4U/X/ndBd0k42PMxb5YDhadJkP7Pqr+9buwbg6PA
 TjsfIao1gAtw9SohBAmUDBFkhOaBsMqFFkWPk/Y=
X-Google-Smtp-Source: APXvYqyrTlC8kzX1w80Z1BnoWoL/A9p/FKIUi9ltbQlFqTAP46Ho8mYS3Fq8+RxRBAaaZ8/CNTltRyilejQXr/DoNzs=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr5704572wrq.206.1578500858503; 
 Wed, 08 Jan 2020 08:27:38 -0800 (PST)
MIME-Version: 1.0
References: <20200108161721.7727-1-Hawking.Zhang@amd.com>
 <20200108161721.7727-5-Hawking.Zhang@amd.com>
In-Reply-To: <20200108161721.7727-5-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jan 2020 11:27:25 -0500
Message-ID: <CADnq5_M=Ujo2QuWsHU--D8bqpyOorO4uqwwmRmthbb1-_=9thw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: read sdma edc counter to clear the
 counters
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

On Wed, Jan 8, 2020 at 11:18 AM Hawking Zhang <Hawking.Zhang@amd.com> wrote:
>
> SDMA edc counter registers were added in gfx edc counters
> array. When querying gfx error counter in that array, there
> is no way to differentiate sdma instance number for different
> asic and then results to NULL pointer access when trying to
> read sdma register base address for instances greater
> than 2 on Vega20.
> In addition, this also results to wrong gfx error counters
> since it actually added sdma edc counters.
> Therefore, sdma edc counter registers should be separated
> from gfx edc counter regsiter array and only get initialized
> when driver tries to enable sdma ras.
>
> Change-Id: I206917f9d7b81670a8fed84dc749085ce5a6f678
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 11 +----------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  7 +++++++
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 33d1c57aaaf1..c9ade16bbcc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4038,14 +4038,6 @@ static const struct soc15_reg_entry sec_ded_counter_registers[] = {
>     { SOC15_REG_ENTRY(GC, 0, mmTCA_EDC_CNT), 0, 1, 2},
>     { SOC15_REG_ENTRY(GC, 0, mmSQC_EDC_CNT3), 0, 4, 6},
>     { SOC15_REG_ENTRY(HDP, 0, mmHDP_EDC_CNT), 0, 1, 1},
> -   { SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER), 0, 1, 1},
> -   { SOC15_REG_ENTRY(SDMA1, 0, mmSDMA1_EDC_COUNTER), 0, 1, 1},
> -   { SOC15_REG_ENTRY(SDMA2, 0, mmSDMA2_EDC_COUNTER), 0, 1, 1},
> -   { SOC15_REG_ENTRY(SDMA3, 0, mmSDMA3_EDC_COUNTER), 0, 1, 1},
> -   { SOC15_REG_ENTRY(SDMA4, 0, mmSDMA4_EDC_COUNTER), 0, 1, 1},
> -   { SOC15_REG_ENTRY(SDMA5, 0, mmSDMA5_EDC_COUNTER), 0, 1, 1},
> -   { SOC15_REG_ENTRY(SDMA6, 0, mmSDMA6_EDC_COUNTER), 0, 1, 1},
> -   { SOC15_REG_ENTRY(SDMA7, 0, mmSDMA7_EDC_COUNTER), 0, 1, 1},
>  };
>
>  static int gfx_v9_0_do_edc_gds_workarounds(struct amdgpu_device *adev)
> @@ -4109,7 +4101,6 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>                                                 adev->gfx.config.max_sh_per_se;
>         int sgpr_work_group_size = 5;
>         int gpr_reg_size = compute_dim_x / 16 + 6;
> -       int sec_ded_counter_reg_size = adev->sdma.num_instances + 34;
>
>         /* only support when RAS is enabled */
>         if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> @@ -4249,7 +4240,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>
>         /* read back registers to clear the counters */
>         mutex_lock(&adev->grbm_idx_mutex);
> -       for (i = 0; i < sec_ded_counter_reg_size; i++) {
> +       for (i = 0; i < ARRAY_SIZE(sec_ded_counter_registers); i++) {
>                 for (j = 0; j < sec_ded_counter_registers[i].se_num; j++) {
>                         for (k = 0; k < sec_ded_counter_registers[i].instance; k++) {
>                                 gfx_v9_0_select_se_sh(adev, j, 0x0, k);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index fd20594b6d6e..f4107f9b75f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1802,6 +1802,13 @@ static int sdma_v4_0_late_init(void *handle)
>         struct ras_ih_if ih_info = {
>                 .cb = sdma_v4_0_process_ras_data_cb,
>         };
> +       int i;
> +
> +       /* read back edc counter registers to clear the counters */
> +       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
> +               for (i = 0; i < adev->sdma.num_instances; i++)
> +                       RREG32_SDMA(i, mmSDMA0_EDC_COUNTER);
> +       }
>
>         return adev->sdma.funcs->ras_late_init(adev, &ih_info);
>  }
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
