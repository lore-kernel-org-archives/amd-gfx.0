Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B899CC83F33
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 15:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D82710E158;
	Tue,  5 Sep 2023 15:39:14 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1B5B10E0C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 15:39:11 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5734f54dc44so1584006eaf.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693928351; x=1694533151; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbugR0H7GcXh5sAV/MYh74xqjv2HlXFsYaudCXsU2P4=;
 b=VdSTdeWMcMB3g7dUXSkLFTKUJrMdrRq8AZlkTRPsLZEakBZrMCvrG6ProgAUjH8/1s
 DXK9K/iHAfdQfx7e1hgYDio/h3Rm6w+NhQF3YNlOBlgp4Yd2UrB71FlnL+uknneyommp
 nCcp8nVYyZAW9E4Zlud76qp6MZWki2K1uziBfHlxjr+XnzZBZK653cOo/4oUKHPq0baB
 emfl7Yn8aacRtOO2GLygejpL1LLF45CFhEfseLFkXCW0QckWu+tE7tUnjEFfvLYjw65l
 vI7F/hsIxqYL1e0uhEzIIBzbc3Q9YXkvoR6GT+P3mUE7LE/2XpN+ip+dahW1m/zIF4MD
 PiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693928351; x=1694533151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbugR0H7GcXh5sAV/MYh74xqjv2HlXFsYaudCXsU2P4=;
 b=Uf5h1MsQX7jrsyAo803qqgQxtvqlBnSNauGZGfj6sxS7nCdXQRAxRmglVBXYcylcsE
 k96SO35TtYZAqGbLrEvTBw+iwH6LfcG0cZBT3Yge3tXgB2sdrCbqzTtqN1BoR8aDv/bF
 VqDFcR4kGW/llFkapkwQ7e5MZh6G3FzI0woxKhB5UVL2tcLtIQYQe1NxkdG8tpMYC660
 LG6OdtSbZOTRDjnpkRiUAEx1ntpML2eahQZb3sLaEgopZ0h4rQvpk57E2zSAcpzE+8am
 U8sqxTAo6+n1z9X4QqW2Wgc+2sU/TcR/xJ7b2edc8my00xeIVDqqK2cJxC+2UOTqfeRv
 KZJw==
X-Gm-Message-State: AOJu0YxOHVA/46rfWUwVzvRU1K/GmnjO4ASLV11xkHuQ/csMrHNTYQCX
 vzMVdOZRiFmS1fnfEsYtmQl4JL3nnRHXBOw1p9E=
X-Google-Smtp-Source: AGHT+IFy8ggNrDLFWGR4/MvilmIXUSSJUUinKLFBeVRH/5VnB6bK3HeGVyTR5xx0IMkZq2grWeNq/kgPTwu/hDa03ds=
X-Received: by 2002:a4a:764d:0:b0:56c:cd0c:1d67 with SMTP id
 w13-20020a4a764d000000b0056ccd0c1d67mr10965751ooe.7.1693928350756; Tue, 05
 Sep 2023 08:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230904042259.3070136-1-Lang.Yu@amd.com>
In-Reply-To: <20230904042259.3070136-1-Lang.Yu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 11:38:59 -0400
Message-ID: <CADnq5_PBU2j2wdJRNp1njg7i7fs5G1oBapbAhsx2qgpnYxmc2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix incompatible types in conditional
 expression
To: Lang Yu <Lang.Yu@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>, kernel test robot <lkp@intel.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 4, 2023 at 1:00=E2=80=AFAM Lang Yu <Lang.Yu@amd.com> wrote:
>
> Fixes: ab041551f4a7 ("drm/amdgpu: add VPE 6.1.0 support")
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202309020608.FwP8QMht-lkp@int=
el.com

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c   | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vpe.h
> index b590205d6a28..29d56f7ae4a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
> @@ -31,7 +31,7 @@ struct amdgpu_vpe;
>
>  struct vpe_funcs {
>         uint32_t (*get_reg_offset)(struct amdgpu_vpe *vpe, uint32_t inst,=
 uint32_t offset);
> -       void (*set_regs)(struct amdgpu_vpe *vpe);
> +       int (*set_regs)(struct amdgpu_vpe *vpe);
>         int (*irq_init)(struct amdgpu_vpe *vpe);
>         int (*init_microcode)(struct amdgpu_vpe *vpe);
>         int (*load_microcode)(struct amdgpu_vpe *vpe);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/=
amdgpu/vpe_v6_1.c
> index 1259b150dc96..756f39348dd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
> @@ -254,13 +254,15 @@ static int vpe_v6_1_process_trap_irq(struct amdgpu_=
device *adev,
>         return 0;
>  }
>
> -static void vpe_v6_1_set_regs(struct amdgpu_vpe *vpe)
> +static int vpe_v6_1_set_regs(struct amdgpu_vpe *vpe)
>  {
>         vpe->regs.queue0_rb_rptr_lo =3D regVPEC_QUEUE0_RB_RPTR;
>         vpe->regs.queue0_rb_rptr_hi =3D regVPEC_QUEUE0_RB_RPTR_HI;
>         vpe->regs.queue0_rb_wptr_lo =3D regVPEC_QUEUE0_RB_WPTR;
>         vpe->regs.queue0_rb_wptr_hi =3D regVPEC_QUEUE0_RB_WPTR_HI;
>         vpe->regs.queue0_preempt =3D regVPEC_QUEUE0_PREEMPT;
> +
> +       return 0;
>  }
>
>  static const struct vpe_funcs vpe_v6_1_funcs =3D {
> --
> 2.25.1
>
