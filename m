Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E25C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 14:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D5510E40F;
	Tue, 11 Jan 2022 14:26:22 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA17710E532
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 14:26:20 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 a23-20020a9d4717000000b0056c15d6d0caso18682356otf.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 06:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EaK5v9cHZ51ZB5vCALmIvlFFKiU62GKCg+Y5LeYv0zs=;
 b=FNCRRIZ8k5C4bL+FpppcNg1MX6BsXGN5aKbS/x5eSlUIAoqEu/UrZasC/CTWGGs3zs
 vfMkqE+I6SfhPezOqj1SYoQvB7v0/4L3rm32TAdUUA1PZwbSEIBSOZFXf4cQUX/1hgre
 Ozayd83uzm0hlcNnpFi9f0dWJB2FRza7rBJbD7vnEpblooIXIHfQv7l5ZieNEMP+E7Yx
 uZI2IuzUjux7qhcKP5kUtjEbqD3hDgCgwHp5oCvsoAWSws07Gb+G64uKdCvKvS41qf8u
 BDAaGNU69OAid5WDCLRV44vGfjqKUXp7ThTFsFkSakmXpzb2ja6g9D0q7Cyd/bF/fzt+
 EjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EaK5v9cHZ51ZB5vCALmIvlFFKiU62GKCg+Y5LeYv0zs=;
 b=h/1aGvBrWicD6Sj98gQyIc12CmKb0J5PAuwQMU8ZLt2glgRBBhKtrSpNHkL1tnZKHB
 s56ly7GZDfTt8IfQuaB8L+nNbPhmcL4hU/AAUBSl3syiHcdiFU6iq5Hfw+jUliBK4aXH
 QIDvq8qrKDLdNPOnuZKOze8iEJ/gzZCSd5Xly7wAPpraBejjkYrSQWW2GZYIFUFxhZKk
 tOPRVRjWhPYklg7fb9qe17Tu2545iBjW/zmSMPPXjcYOfr6aNO8feGqs0UEsHaE4OXzp
 K9ZszyXffGEH+4mZWG1Pnf9ACrVtY0WT8iUI7+U3S0bsbdnzim88mRfipzOXppyRMJ4l
 1DsA==
X-Gm-Message-State: AOAM533C8kLyuifd/EhCzF3ENthjpgKkhB/Txg9ZQ7zfagyIAjjtRRIY
 reka3FqiaUYLrbBGT4o/wmgTwBF5qU08MkGAVOc=
X-Google-Smtp-Source: ABdhPJyYV5/erg1hgN7nhJ0HVnjLKymwd+0jL8ODX8DOFQghDuqIvYK2iliCWh/RWVRAlWKDPZ74DobbQj98fdZL1zw=
X-Received: by 2002:a9d:6390:: with SMTP id w16mr3582119otk.200.1641911179991; 
 Tue, 11 Jan 2022 06:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20220111071119.5464-1-Amaranath.Somalapuram@amd.com>
In-Reply-To: <20220111071119.5464-1-Amaranath.Somalapuram@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Jan 2022 09:26:09 -0500
Message-ID: <CADnq5_PdtKnRxvQFJpFr=22FOiaw4PzFHnd18SZGDTmX2gnVVQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: add reset register dump function for
 gfx_v10_0
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 11, 2022 at 2:11 AM Somalapuram Amaranath
<Amaranath.Somalapuram@amd.com> wrote:
>
> Implementation of register dump function when the AMD GPU resets
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 55 +++++++++++++++++++++++-
>  drivers/gpu/drm/amd/include/amd_shared.h |  2 +
>  2 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index dbe7442fb25c..dbd74204f06d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7466,7 +7466,6 @@ static int gfx_v10_0_hw_init(void *handle)
>  {
>         int r;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
>         if (!amdgpu_emu_mode)
>                 gfx_v10_0_init_golden_registers(adev);
>
> @@ -7580,6 +7579,59 @@ static int gfx_v10_0_hw_fini(void *handle)
>         return 0;
>  }
>
> +static int gfx_v10_0_reset_reg_dumps(void *handle,
> +               uint32_t (**dump)[2], uint32_t *n_regs, char ***r_names)
> +{
> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +       uint32_t i = 0;
> +
> +#define N_REGS (17)
> +#define DUMP_REG(addr) do {                            \
> +               (*dump)[i][0] = (addr);                 \
> +               (*dump)[i++][1] = RREG32(addr);         \

For soc15 and newer asics (e.g., vega and newer), we need to use the
RREG_SOC15 macros rather than the regular RREG macros.

Alex


> +       } while (0)
> +
> +       char *reg_names[N_REGS] = {
> +               "mmGRBM_STATUS2", "mmGRBM_STATUS_SE0", "mmGRBM_STATUS_SE1",
> +               "mmGRBM_STATUS_SE2", "mmGRBM_STATUS_SE3", "mmSDMA0_STATUS_REG",
> +               "mmSDMA1_STATUS_REG", "mmCP_STAT", "mmCP_STALLED_STAT1",
> +               "mmCP_STALLED_STAT1", "mmCP_STALLED_STAT3", "mmCP_CPC_STATUS",
> +               "mmCP_CPC_BUSY_STAT", "mmCP_CPC_STALLED_STAT1", "mmCP_CPF_STATUS",
> +               "mmCP_CPF_BUSY_STAT", "mmCP_CPF_STALLED_STAT1"
> +       };
> +
> +       *dump = kmalloc(N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
> +       if (*dump == NULL)
> +               return -ENOMEM;
> +       DUMP_REG(mmGRBM_STATUS2);
> +       DUMP_REG(mmGRBM_STATUS_SE0);
> +       DUMP_REG(mmGRBM_STATUS_SE1);
> +       DUMP_REG(mmGRBM_STATUS_SE2);
> +       DUMP_REG(mmGRBM_STATUS_SE3);
> +       DUMP_REG(mmSDMA0_STATUS_REG);
> +       DUMP_REG(mmSDMA1_STATUS_REG);
> +       DUMP_REG(mmCP_STAT);
> +       DUMP_REG(mmCP_STALLED_STAT1);
> +       DUMP_REG(mmCP_STALLED_STAT1);
> +       DUMP_REG(mmCP_STALLED_STAT3);
> +       DUMP_REG(mmCP_CPC_STATUS);
> +       DUMP_REG(mmCP_CPC_BUSY_STAT);
> +       DUMP_REG(mmCP_CPC_STALLED_STAT1);
> +       DUMP_REG(mmCP_CPF_STATUS);
> +       DUMP_REG(mmCP_CPF_BUSY_STAT);
> +       DUMP_REG(mmCP_CPF_STALLED_STAT1);
> +
> +       *n_regs = i;
> +
> +       (*r_names) = kcalloc(N_REGS, sizeof(char *), GFP_KERNEL);
> +       for (i = 0; i < N_REGS; i++) {
> +               (*r_names)[i] = kcalloc(30, sizeof(char), GFP_KERNEL);
> +               strcpy((*r_names)[i], reg_names[i]);
> +       }
> +
> +       return 0;
> +}
> +
>  static int gfx_v10_0_suspend(void *handle)
>  {
>         return gfx_v10_0_hw_fini(handle);
> @@ -9359,6 +9411,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>         .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>         .set_powergating_state = gfx_v10_0_set_powergating_state,
>         .get_clockgating_state = gfx_v10_0_get_clockgating_state,
> +       .reset_reg_dumps = gfx_v10_0_reset_reg_dumps,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 4b9e68a79f06..98291a8f57dd 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -298,6 +298,8 @@ struct amd_ip_funcs {
>                                      enum amd_powergating_state state);
>         void (*get_clockgating_state)(void *handle, u32 *flags);
>         int (*enable_umd_pstate)(void *handle, enum amd_dpm_forced_level *level);
> +       int (*reset_reg_dumps)(void *handle,
> +                       uint32_t (**dump)[2], uint32_t *n_regs, char ***r_names);
>  };
>
>
> --
> 2.25.1
>
