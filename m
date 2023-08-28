Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D65BC83F12
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 22:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BCF10E366;
	Mon, 28 Aug 2023 22:45:35 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F48910E366
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 22:45:34 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1c4f4d67f5bso2548709fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693262734; x=1693867534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Hk5UwdI3UfH8jKH2BKnJ8DJ2aE7EPC+cpqSssqp4eA=;
 b=b6C8An41MxIyvr/LuxD3alZODbgWyg0y9PC3FBBDAHA1sR0bTxOidog8/71072XwDI
 qeoZVBOC0KrGr06U3Az4ImKmvqvhW5dpq/w00lxjGnFv2NX3AK/Qa8lMgbhvt6AMDyy4
 Xf7MzCFJpnJcptQTfVAKyz3NRYMPu5h1UywP7X7k/U3JelWQZoiDfFKWyqcT0RnRwaSu
 P3tJxQy87L3zoZlnM7Mu1yyD7yJNgnjz03d6hPHUg3b2AQjrnQaJJVVKHyqJAtEORoui
 ofp3xbCDRi4X8OK8RVidbY3HFaOWdWkyNxZ1EMYV5wkhDfltujl4C2DpM1vnwPdr/FZn
 ERng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693262734; x=1693867534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Hk5UwdI3UfH8jKH2BKnJ8DJ2aE7EPC+cpqSssqp4eA=;
 b=bJmynOgjVtL18GwdfP2V94gOlM9eNQ4jFUHb/42hJkchgqslONfsCFoPdyJPuzPovw
 xCPNcVgx7k5k3aUVZCNCYIs7wnv6DPhPIuBprKR7cXpfSk/lQGVuX6cuZe3pKnu6Dv6W
 dnytWxvdo5IPgfJxKe2/Nb+81pOm1jXoNVHFZ0wInbmY04a19YAjQV/1ODJxw5/NMKi4
 scX9w4wFMZC7tCL0+zoFT02k3Lb8XlmTpzhjmuYkmIu5GGS8uMdZ4xhe3C7bkYz1FKQ8
 kQCsG4HCNieJgwPykLrcWIkHwTCtufhKv6ReLYUP5fC2kj9Jl7eXCXofDrKlr/ArJ5cR
 kfaw==
X-Gm-Message-State: AOJu0YyXq6nhE3P0Xg4fBrdb/Iox/OnTa7c3tVYBDhI0B395PV2MyWO+
 LxJ2xc09JRAjZcpqvMOMdxhBAn6PYfh1Ia1UMTfOdlu2
X-Google-Smtp-Source: AGHT+IHtnPKYjRiQDcYAqYgJugOls2u94wVEaPIsCX6fa8j7kyFRaGnhYj2nslHtnBEMxasR44EFlG0s1As8wGhUvno=
X-Received: by 2002:a05:6870:8088:b0:1bb:a891:47fc with SMTP id
 q8-20020a056870808800b001bba89147fcmr13827168oab.8.1693262733777; Mon, 28 Aug
 2023 15:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230828063926.5240-1-zhenguo.yin@amd.com>
In-Reply-To: <20230828063926.5240-1-zhenguo.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Aug 2023 18:45:22 -0400
Message-ID: <CADnq5_Nk6PZ5-0v2zkut3svsDnwy=Erj0Tw3btLRGwGM4kB36w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: access RLC_SPM_MC_CNTL through MMIO in SRIOV
To: ZhenGuo Yin <zhenguo.yin@amd.com>
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
Cc: yifan.zha@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Aug 28, 2023 at 2:50=E2=80=AFAM ZhenGuo Yin <zhenguo.yin@amd.com> w=
rote:
>
> Register RLC_SPM_MC_CNTL is not blocked by L1 policy, VF can
> directly access it through MMIO.
>
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 10 ++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 10 ++--------
>  2 files changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 0aee9c8288a2..65619f73f717 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7901,18 +7901,12 @@ static void gfx_v10_0_update_spm_vmid_internal(st=
ruct amdgpu_device *adev,
>
>         /* not for *_SOC15 */
>         reg =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
> -       if (amdgpu_sriov_is_pp_one_vf(adev))
> -               data =3D RREG32_NO_KIQ(reg);
> -       else
> -               data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> +       data =3D RREG32_NO_KIQ(reg);
>
>         data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
>         data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_=
MC_CNTL__RLC_SPM_VMID__SHIFT;
>
> -       if (amdgpu_sriov_is_pp_one_vf(adev))
> -               WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
> -       else
> -               WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
> +       WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
>  }
>
>  static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsign=
ed int vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index b0c32521efdc..7f8c5c6fd36e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4989,18 +4989,12 @@ static void gfx_v11_0_update_spm_vmid(struct amdg=
pu_device *adev, unsigned vmid)
>         amdgpu_gfx_off_ctrl(adev, false);
>
>         reg =3D SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
> -       if (amdgpu_sriov_is_pp_one_vf(adev))
> -               data =3D RREG32_NO_KIQ(reg);
> -       else
> -               data =3D RREG32(reg);
> +       data =3D RREG32_NO_KIQ(reg);
>
>         data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
>         data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_=
MC_CNTL__RLC_SPM_VMID__SHIFT;
>
> -       if (amdgpu_sriov_is_pp_one_vf(adev))
> -               WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
> -       else
> -               WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
> +       WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
>
>         amdgpu_gfx_off_ctrl(adev, true);
>  }
> --
> 2.35.1
>
