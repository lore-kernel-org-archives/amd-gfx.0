Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D77C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 13:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7702461058
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 13:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7702461058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173346EABF;
	Thu,  4 Nov 2021 13:16:43 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81FD6EABF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 13:16:41 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 s7-20020a056830148700b0055ad72acb7eso7168672otq.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Nov 2021 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LTGBdaelkXIrnMkLbRT9jmgM13Bs4WMYnI706ddKncI=;
 b=VtPWGXQNi3Y55N3tIUARnre5h+NGcx3duL7A7OkRX063Wu3MvTflgkPacBNesFG8oK
 Vcn4ex7ap5tnv9uXbEGEWOOmShA26LUfUQoIEN4bgkio5vfmxXxDQQF7dje6DVN+Kjnq
 D9o1ZqeMypOhbtp54xLrXSDTtl2q6BzAQmyjH2YG0gab0xM/mD3P2E/uMnJvc0Po20pN
 GlgwySFBWIhQldCaQbbLuxCM5pzk6asQMmIw7OyKKi2vEdvYOSeybXJc/KZwOPEcMWPk
 YwvlV8+8c7BxkcHTqiF+gaxdOMCtxGNYZHjTdq/eG3/xGderVKRT64wSUHffdN4Laatf
 STzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LTGBdaelkXIrnMkLbRT9jmgM13Bs4WMYnI706ddKncI=;
 b=hHt7YVuUZ8ydKJFp3vvWlU5/o0LFTaMlTC4Q0s9+R1izlCXKqoffslsjcYtCidWMLp
 r6X8FINePiZOrocpwCOBskRJi118HgAcTpPAGPv0rpynvsL/5BtUWIxeE6z3lyCvzJWD
 vDzmBeGGvrWGpU6UUVanwKcFOQaJWEsncim9yOLVrB5gr4fFV7YuzDUpbQeLTey8sNA+
 8mYanYqcecoVJYFfvAty9e0JM0aKH+f1Pkx9vzGGMHfNzfmgcW2Z6td1y64pQZVNdTHE
 RdQ+Mm+/719R8PAuGom/IDLyH1Y83w4HdfC81r5Zp9nTzWigWXw7rc5fq1Fcd6V7Mtiu
 jE+A==
X-Gm-Message-State: AOAM530XvbnrEkwnYscn9eQu/nZe31Ft1qI/WGmLZ5B/vU+sgTWfXIUy
 Qc2KeGnCDaXtEvJGeGH+1AngI5UhodtmJ5ipGBE=
X-Google-Smtp-Source: ABdhPJz7wwjjMUC+MNYudezCkNPXVp7Ryv/eDWI3yXKcnPOYV9f7PP4LQYax3W7QoBfEVGcfs/9cLjUr4ySqj6swO1s=
X-Received: by 2002:a9d:639a:: with SMTP id w26mr3972176otk.357.1636031800996; 
 Thu, 04 Nov 2021 06:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211104061948.111865-1-evan.quan@amd.com>
In-Reply-To: <20211104061948.111865-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Nov 2021 09:16:29 -0400
Message-ID: <CADnq5_OM2imZXDRJwrDGbmPtOrZEcJ2kAHGsyWWT3BxJQAf5ag@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: correctly toggle gfx on/off around RLC_SPM_*
 register access
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 4, 2021 at 2:20 AM Evan Quan <evan.quan@amd.com> wrote:
>
> As part of the ib padding process, accessing the RLC_SPM_* register may
> trigger gfx hang. Since gfxoff may be already kicked during the whole period.
> To address that, we manually toggle gfx on/off around the RLC_SPM_*
> register access.
>
> This can resolve the gfx hang issue observed on running Talos with RDP launched
> in parallel.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Ifae152e8151fecd25a238ebe87dffb3b17cdb540

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 4 ++++
>  4 files changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index fa03db34aec4..10fc9197602e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8388,6 +8388,9 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>  static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
>  {
>         u32 reg, data;
> +
> +       amdgpu_gfx_off_ctrl(adev, false);
> +
>         /* not for *_SOC15 */
>         reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
>         if (amdgpu_sriov_is_pp_one_vf(adev))
> @@ -8402,6 +8405,8 @@ static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
>                 WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
>         else
>                 WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
> +
> +       amdgpu_gfx_off_ctrl(adev, true);
>  }
>
>  static bool gfx_v10_0_check_rlcg_range(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 37b4a3db6360..d17a6f399347 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3575,12 +3575,16 @@ static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
>  {
>         u32 data;
>
> +       amdgpu_gfx_off_ctrl(adev, false);
> +
>         data = RREG32(mmRLC_SPM_VMID);
>
>         data &= ~RLC_SPM_VMID__RLC_SPM_VMID_MASK;
>         data |= (vmid & RLC_SPM_VMID__RLC_SPM_VMID_MASK) << RLC_SPM_VMID__RLC_SPM_VMID__SHIFT;
>
>         WREG32(mmRLC_SPM_VMID, data);
> +
> +       amdgpu_gfx_off_ctrl(adev, true);
>  }
>
>  static void gfx_v7_0_enable_cgcg(struct amdgpu_device *adev, bool enable)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index aefae5b1ff7b..1a476de20d08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5727,6 +5727,8 @@ static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
>  {
>         u32 data;
>
> +       amdgpu_gfx_off_ctrl(adev, false);
> +
>         if (amdgpu_sriov_is_pp_one_vf(adev))
>                 data = RREG32_NO_KIQ(mmRLC_SPM_VMID);
>         else
> @@ -5739,6 +5741,8 @@ static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
>                 WREG32_NO_KIQ(mmRLC_SPM_VMID, data);
>         else
>                 WREG32(mmRLC_SPM_VMID, data);
> +
> +       amdgpu_gfx_off_ctrl(adev, true);
>  }
>
>  static const struct amdgpu_rlc_funcs iceland_rlc_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 08e91e7245df..d9367747fed3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5218,6 +5218,8 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
>  {
>         u32 reg, data;
>
> +       amdgpu_gfx_off_ctrl(adev, false);
> +
>         reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
>         if (amdgpu_sriov_is_pp_one_vf(adev))
>                 data = RREG32_NO_KIQ(reg);
> @@ -5231,6 +5233,8 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
>                 WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
>         else
>                 WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
> +
> +       amdgpu_gfx_off_ctrl(adev, true);
>  }
>
>  static bool gfx_v9_0_check_rlcg_range(struct amdgpu_device *adev,
> --
> 2.29.0
>
