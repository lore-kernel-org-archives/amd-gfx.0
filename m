Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BF5C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 12:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B99F10EB9C;
	Fri, 11 Apr 2025 12:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aTfcuCZR";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D4D910EB9C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 12:47:43 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-301001bc6a8so279634a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 05:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744375662; x=1744980462; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+yybrggFwRAsQiRt99WyhZWGB0o+zi51+S0PwFndXo=;
 b=aTfcuCZRriwoDP65Oc9yY5UeAd5nMMTBuBeRRF41zboN9eZSGBRkEYHo/bpkOeAsUT
 qb3CxgeyieLnnUu1ug05spLK01l8+UpV0BWF51JNN8dJWZZvgc1iaBGfX8njYIdy9pjx
 kTMWhb4SPHJ73wrV47K/xyykCNflfZas3ImfKbq61yUjfaJMGE8KEE1yc3OTgAa+dTfv
 PIPxqr7vocTzJrkbWNrJFqAqFNzQYBkEhY8iuyltuDpuYszAy+OEoCcqKgCHgYe+TvTX
 9kBXMtNSWvC+U2ZlSUSxZseaziUrvQ9DebF1qHa7an43zsFQNYwSiqOuop5Bo+fDRmxk
 rsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375662; x=1744980462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+yybrggFwRAsQiRt99WyhZWGB0o+zi51+S0PwFndXo=;
 b=cTGR6RkN//PLH0AbjcPHg6BnaGlfc7LnW53gXVIiOOXgF7bpa+qr3+Ka3FT/Syw5JG
 8ENZuXHMDAaDgoQZrEwIIl0ZW0VUVMv76EunxUIQ9lQgCduYsokpmmAOAKeIw3QjFzta
 Uem6G+fAKplINteBuAsRHNSZFhbVShFurHIazyZG9bnLKJyirej3fRCYac+9QKFtkc80
 Ge7ctDGY6atqRt6wwu8djM6VB2dFUoULK6Kro80PamMIOdvrCDlz5KVpMXsxf2l2xfnf
 Cw+KZa6/dsH/79ErlFiJ6OHczGejEs9lV6SMGdYH+Tn6GpWIlSpHMM1Wgm1IDlLtQQJ6
 pmeA==
X-Gm-Message-State: AOJu0Yx3yakPCULwhTXIUOeEyHzNcRs3Ml8/5mbpgUVgkbbgNCmOyAVe
 MjbLsgFkcBFr+4/3d0VQJtp/27klbYNZoWfSfuhD8ENbCynhEbxCQLqnpvBAVSCXkde87UIJa32
 6LVnQxz8tQ2w2SQjYE3GEYNWnfAo=
X-Gm-Gg: ASbGnct9+FLY93SBRj3CDwZoObnONWlHxJf6wprRuec6/oIFd8rOoV5z1HRNvyfly2m
 LscFtOIU/2u7EFXy4Rw9Ctta9UEm4NxWSYyBjRv/nf2QcXmdmb2LCvFW6vDFVVNulvIHbF9Y5Om
 tWrwAGGLV1AavBltXlyP+zow==
X-Google-Smtp-Source: AGHT+IGFozpbX/w2ged2l9Q4QEtNNIJnI/C1R5+bST/hYImIlrNEpWp97hk+47kErhT0daZgnkRM4EbHYRzAFojz+4I=
X-Received: by 2002:a17:90b:3a8b:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-308235c3c9emr1585806a91.0.1744375662316; Fri, 11 Apr 2025
 05:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250411121524.589317-1-lijo.lazar@amd.com>
 <20250411121524.589317-2-lijo.lazar@amd.com>
In-Reply-To: <20250411121524.589317-2-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 08:47:29 -0400
X-Gm-Features: ATxdqUFyCqpEgixUgbUQIZkeG5xR2UHEWH_qcTSJiyH62Ie08x344woJp8gATng
Message-ID: <CADnq5_NFi1T16zkWj5PsdjQZat+80wRNm2+3U+PME-g2hcJ5yA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Use the right function for hdp flush
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 11, 2025 at 8:16=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> There are a few prechecks made before HDP flush like a flush is not
> required on APU bare metal. Using hdp callback directly bypasses those
> checks. Use amdgpu_device_flush_hdp which takes care of prechecks.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 12 ++++++------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/psp_v14_0.c |  2 +-
>  10 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index f5dcb72a6bf5..00eb4cfecf8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6172,7 +6172,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(stru=
ct amdgpu_device *adev)
>         }
>
>         if (amdgpu_emu_mode =3D=3D 1)
> -               adev->hdp.funcs->flush_hdp(adev, NULL);
> +               amdgpu_device_flush_hdp(adev, NULL);
>
>         tmp =3D RREG32_SOC15(GC, 0, mmCP_PFP_IC_BASE_CNTL);
>         tmp =3D REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0);
> @@ -6250,7 +6250,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struc=
t amdgpu_device *adev)
>         }
>
>         if (amdgpu_emu_mode =3D=3D 1)
> -               adev->hdp.funcs->flush_hdp(adev, NULL);
> +               amdgpu_device_flush_hdp(adev, NULL);
>
>         tmp =3D RREG32_SOC15(GC, 0, mmCP_CE_IC_BASE_CNTL);
>         tmp =3D REG_SET_FIELD(tmp, CP_CE_IC_BASE_CNTL, VMID, 0);
> @@ -6327,7 +6327,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struc=
t amdgpu_device *adev)
>         }
>
>         if (amdgpu_emu_mode =3D=3D 1)
> -               adev->hdp.funcs->flush_hdp(adev, NULL);
> +               amdgpu_device_flush_hdp(adev, NULL);
>
>         tmp =3D RREG32_SOC15(GC, 0, mmCP_ME_IC_BASE_CNTL);
>         tmp =3D REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0);
> @@ -6702,7 +6702,7 @@ static int gfx_v10_0_cp_compute_load_microcode(stru=
ct amdgpu_device *adev)
>         }
>
>         if (amdgpu_emu_mode =3D=3D 1)
> -               adev->hdp.funcs->flush_hdp(adev, NULL);
> +               amdgpu_device_flush_hdp(adev, NULL);
>
>         tmp =3D RREG32_SOC15(GC, 0, mmCP_CPC_IC_BASE_CNTL);
>         tmp =3D REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 91d29f482c3c..fa39ae17222f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -2481,7 +2481,7 @@ static int gfx_v11_0_config_me_cache(struct amdgpu_=
device *adev, uint64_t addr)
>         }
>
>         if (amdgpu_emu_mode =3D=3D 1)
> -               adev->hdp.funcs->flush_hdp(adev, NULL);
> +               amdgpu_device_flush_hdp(adev, NULL);
>
>         tmp =3D RREG32_SOC15(GC, 0, regCP_ME_IC_BASE_CNTL);
>         tmp =3D REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0);
> @@ -2525,7 +2525,7 @@ static int gfx_v11_0_config_pfp_cache(struct amdgpu=
_device *adev, uint64_t addr)
>         }
>
>         if (amdgpu_emu_mode =3D=3D 1)
> -               adev->hdp.funcs->flush_hdp(adev, NULL);
> +               amdgpu_device_flush_hdp(adev, NULL);
>
>         tmp =3D RREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_CNTL);
>         tmp =3D REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0);
> @@ -2570,7 +2570,7 @@ static int gfx_v11_0_config_mec_cache(struct amdgpu=
_device *adev, uint64_t addr)
>         }
>
>         if (amdgpu_emu_mode =3D=3D 1)
> -               adev->hdp.funcs->flush_hdp(adev, NULL);
> +               amdgpu_device_flush_hdp(adev, NULL);
>
>         tmp =3D RREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_CNTL);
>         tmp =3D REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
> @@ -3206,7 +3206,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode_rs64=
(struct amdgpu_device *adev)
>         amdgpu_bo_unreserve(adev->gfx.pfp.pfp_fw_data_obj);
>
>         if (amdgpu_emu_mode =3D=3D 1)
> -               adev->hdp.funcs->flush_hdp(adev, NULL);
> +               amdgpu_device_flush_hdp(adev, NULL);
>
>         WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_LO,
>                 lower_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
> @@ -3424,7 +3424,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode_rs64(=
struct amdgpu_device *adev)
>         amdgpu_bo_unreserve(adev->gfx.me.me_fw_data_obj);
>
>         if (amdgpu_emu_mode =3D=3D 1)
> -               adev->hdp.funcs->flush_hdp(adev, NULL);
> +               amdgpu_device_flush_hdp(adev, NULL);
>
>         WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_LO,
>                 lower_32_bits(adev->gfx.me.me_fw_gpu_addr));
> @@ -4620,7 +4620,7 @@ static int gfx_v11_0_gfxhub_enable(struct amdgpu_de=
vice *adev)
>         if (r)
>                 return r;
>
> -       adev->hdp.funcs->flush_hdp(adev, NULL);
> +       amdgpu_device_flush_hdp(adev, NULL);
>
>         value =3D (amdgpu_vm_fault_stop =3D=3D AMDGPU_VM_FAULT_STOP_ALWAY=
S) ?
>                 false : true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 2474006b1a34..f347921fa909 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -2389,7 +2389,7 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64=
(struct amdgpu_device *adev)
>         amdgpu_bo_unreserve(adev->gfx.pfp.pfp_fw_data_obj);
>
>         if (amdgpu_emu_mode =3D=3D 1)
> -               adev->hdp.funcs->flush_hdp(adev, NULL);
> +               amdgpu_device_flush_hdp(adev, NULL);
>
>         WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_LO,
>                 lower_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
> @@ -2533,7 +2533,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(=
struct amdgpu_device *adev)
>         amdgpu_bo_unreserve(adev->gfx.me.me_fw_data_obj);
>
>         if (amdgpu_emu_mode =3D=3D 1)
> -               adev->hdp.funcs->flush_hdp(adev, NULL);
> +               amdgpu_device_flush_hdp(adev, NULL);
>
>         WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_LO,
>                 lower_32_bits(adev->gfx.me.me_fw_gpu_addr));
> @@ -3503,7 +3503,7 @@ static int gfx_v12_0_gfxhub_enable(struct amdgpu_de=
vice *adev)
>         if (r)
>                 return r;
>
> -       adev->hdp.funcs->flush_hdp(adev, NULL);
> +       amdgpu_device_flush_hdp(adev, NULL);
>
>         value =3D (amdgpu_vm_fault_stop =3D=3D AMDGPU_VM_FAULT_STOP_ALWAY=
S) ?
>                 false : true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index b6ac4c7adc8a..7648e977b44b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -268,7 +268,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>         ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>
>         /* flush hdp cache */
> -       adev->hdp.funcs->flush_hdp(adev, NULL);
> +       amdgpu_device_flush_hdp(adev, NULL);
>
>         /* This is necessary for SRIOV as well as for GFXOFF to function
>          * properly under bare metal
> @@ -965,7 +965,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device=
 *adev)
>         adev->hdp.funcs->init_registers(adev);
>
>         /* Flush HDP after it is initialized */
> -       adev->hdp.funcs->flush_hdp(adev, NULL);
> +       amdgpu_device_flush_hdp(adev, NULL);
>
>         value =3D (amdgpu_vm_fault_stop =3D=3D AMDGPU_VM_FAULT_STOP_ALWAY=
S) ?
>                 false : true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 5c91d4445418..7f5ca170f141 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -229,7 +229,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>         ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>
>         /* flush hdp cache */
> -       adev->hdp.funcs->flush_hdp(adev, NULL);
> +       amdgpu_device_flush_hdp(adev, NULL);
>
>         /* This is necessary for SRIOV as well as for GFXOFF to function
>          * properly under bare metal
> @@ -895,7 +895,7 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device=
 *adev)
>                 return r;
>
>         /* Flush HDP after it is initialized */
> -       adev->hdp.funcs->flush_hdp(adev, NULL);
> +       amdgpu_device_flush_hdp(adev, NULL);
>
>         value =3D (amdgpu_vm_fault_stop =3D=3D AMDGPU_VM_FAULT_STOP_ALWAY=
S) ?
>                 false : true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index d544419e3b44..b645d3e6a6c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -297,7 +297,7 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>                 return;
>
>         /* flush hdp cache */
> -       adev->hdp.funcs->flush_hdp(adev, NULL);
> +       amdgpu_device_flush_hdp(adev, NULL);
>
>         /* This is necessary for SRIOV as well as for GFXOFF to function
>          * properly under bare metal
> @@ -877,7 +877,7 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device=
 *adev)
>                 return r;
>
>         /* Flush HDP after it is initialized */
> -       adev->hdp.funcs->flush_hdp(adev, NULL);
> +       amdgpu_device_flush_hdp(adev, NULL);
>
>         value =3D (amdgpu_vm_fault_stop =3D=3D AMDGPU_VM_FAULT_STOP_ALWAY=
S) ?
>                 false : true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 8d3560314e5b..53050176c244 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2425,7 +2425,7 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         adev->hdp.funcs->init_registers(adev);
>
>         /* After HDP is initialized, flush HDP.*/
> -       adev->hdp.funcs->flush_hdp(adev, NULL);
> +       amdgpu_device_flush_hdp(adev, NULL);
>
>         if (amdgpu_vm_fault_stop =3D=3D AMDGPU_VM_FAULT_STOP_ALWAYS)
>                 value =3D false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v11_0.c
> index bb5dfc410a66..215543575f47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -533,7 +533,7 @@ static int psp_v11_0_memory_training(struct psp_conte=
xt *psp, uint32_t ops)
>                         }
>
>                         memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> -                       adev->hdp.funcs->flush_hdp(adev, NULL);
> +                       amdgpu_device_flush_hdp(adev, NULL);
>                         vfree(buf);
>                         drm_dev_exit(idx);
>                 } else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v13_0.c
> index 17f1ccd8bd53..f5f616ab20e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -610,7 +610,7 @@ static int psp_v13_0_memory_training(struct psp_conte=
xt *psp, uint32_t ops)
>                         }
>
>                         memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> -                       adev->hdp.funcs->flush_hdp(adev, NULL);
> +                       amdgpu_device_flush_hdp(adev, NULL);
>                         vfree(buf);
>                         drm_dev_exit(idx);
>                 } else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v14_0.c
> index 7c49c3f3c388..256288c6cd78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> @@ -498,7 +498,7 @@ static int psp_v14_0_memory_training(struct psp_conte=
xt *psp, uint32_t ops)
>                         }
>
>                         memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> -                       adev->hdp.funcs->flush_hdp(adev, NULL);
> +                       amdgpu_device_flush_hdp(adev, NULL);
>                         vfree(buf);
>                         drm_dev_exit(idx);
>                 } else {
> --
> 2.25.1
>
