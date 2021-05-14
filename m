Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E0CC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8950960FDB
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8950960FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 460896E429;
	Fri, 14 May 2021 21:06:06 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1ED56E429
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 21:06:04 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id d21so691448oic.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JcoV12G/T4HCrpX85fM/i7mgOUqPQ5xftOx2K9d7GPo=;
 b=USBkLG3khv48zaH8KF61W38UBMcAKGQQ45L7RcQpyK5qVkGp9R5ey/7a4lkIHI757N
 ua2pu8ua5a7R04B0POB0bkhqfMQMMs8o0B88Z5axVuJwp+0L3o+q8HRt8xvN6TBNn/gd
 iPNO67TZnFqW1xw5r0d0F8JGNDUM8e3F/nIAqQe1u/nWbd975dRPcyTG6i1yoQSgIqv6
 HAGXJ/IeHchlHLPrxtuSJvZj73KCq8R+4t9AlUEp5DNkPDWmSGYW6xzoQA/xuNoiZbMQ
 bJk65BfvcCCzIn8MQQiDRl2J51Hkb660P8uit7GsXiSphD75pVcJ5GID0lPQjZd65zQY
 iKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JcoV12G/T4HCrpX85fM/i7mgOUqPQ5xftOx2K9d7GPo=;
 b=fV0Wc9zoCRDtV6axyLyYvPw4C0LPzyGqVMV1iJwmZFvCniMBh5K90dF5YjKD4jrsGW
 gIUoXUA+y1WsptfbsZutq7TkulZm4KN6M3t0qmJ29yOyQwXZNwUyO6GVRJDY2903kXm+
 dYIv9Q+wyK4gF8HGptfPtzf7lgqNx54/4SrhLupKJ3otLtzeVFES8Njrc7o6Yn13tnpC
 LaV4mAht88+jH/lvQHGw/1vQ+zUkHaROKAJAZMtu0Pc9npdQdmrAB53Cc95b7a4eeas0
 A0MJoQaNV8PYZRgEWeOedYgoCzmKiiwOJZXWwHb/rqWnFrDY8JkwJWgxXU0KTsWD5ZUG
 H6jg==
X-Gm-Message-State: AOAM532AEEPTaeBDGdIGuH/1/HhUyWX575P+S0A+hlVCtwyl16Wbu4tj
 wHWzME9A2DSe+SnI1plzUkOpm8avTAUuH7KQzLQ=
X-Google-Smtp-Source: ABdhPJyLlJZAiq3/t0BoYavGhqE5g3tKcgyQH90SigViaYk5M3C/lepkksNBzmk0n4BscHjTz7gMvune/ML+yaz41OA=
X-Received: by 2002:a05:6808:68a:: with SMTP id
 k10mr34790520oig.120.1621026364247; 
 Fri, 14 May 2021 14:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
 <20210514072706.4264-16-PengJu.Zhou@amd.com>
In-Reply-To: <20210514072706.4264-16-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 May 2021 17:05:53 -0400
Message-ID: <CADnq5_M=B2L2fTAMWgiAmxZRuH7EJbicv91Ssh-v1=tts5M0Nw@mail.gmail.com>
Subject: Re: [PATCH v4 16/16] drm/amdgpu: Update gfx_v9 rlcg interface
To: Peng Ju Zhou <PengJu.Zhou@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 14, 2021 at 3:27 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> the interface on gfx v10 updated, the gfx v9 and v10
> share the same interface, update v9's interface.
>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>

This should be squashed with patch 4 to avoid a build breakage.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 357f9405f1aa..ce7f9d01083b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -490,7 +490,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>             adev->gfx.rlc.funcs &&
>             adev->gfx.rlc.funcs->is_rlcg_access_range) {
>                 if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
> -                       return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0);
> +                       return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0, 0);
>         } else {
>                 writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 16a3b279a9ef..59f3d8f922cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -734,7 +734,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
>         mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
>  };
>
> -static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
> +static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
>  {
>         static void *scratch_reg0;
>         static void *scratch_reg1;
> @@ -787,15 +787,16 @@ static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32
>
>  }
>
> -static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
> +static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
> +                              u32 v, u32 acc_flags, u32 hwip)
>  {
>         if (amdgpu_sriov_fullaccess(adev)) {
> -               gfx_v9_0_rlcg_rw(adev, offset, v, flag);
> +               gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
>
>                 return;
>         }
>
> -       if (flag & AMDGPU_REGS_NO_KIQ)
> +       if (acc_flags & AMDGPU_REGS_NO_KIQ)
>                 WREG32_NO_KIQ(offset, v);
>         else
>                 WREG32(offset, v);
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
