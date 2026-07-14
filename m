Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B79C44501
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 15:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B52610EDEB;
	Tue, 14 Jul 2026 15:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EVl5FAyQ";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FC710EDE9
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 15:54:47 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cad85b7b5aso6316065ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784044487; cv=none;
 d=google.com; s=arc-20260327;
 b=SniH1mujOYTJVxzNC0w3NOsMcXyPRXITvV0lKXIWZjIrQfH05MYU6gviccwr/jowha
 iC8x/WSjAOme6SLkhr6K2yM3DSoNB2F+CsZnnEOWA36W+3UXmEn5SSiyxtYrV+lmZNVv
 mYFgwth8s5o1F2cNmrtWAAFSFsQmyGrfClrwGhcvK6LueNpgYmcwxqbnbyZgerkgEVKQ
 xB5UY1EDcS5O8Tgsi7QxO5wqM2UMrNp3zOMiYDjhKmxuhK1lfh4WX/ZyIYb48aWx87rW
 AI2YUEsGNn/t8Z80nCknxizV7L7FONHTYAhCPmW8F5p/Hr/7Q8lxmBbP1UJ+dzUuMQ1Y
 30+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m6D46s8NJr7qK3sVHu66F8E79I00qTDm1gxjChzZa+s=;
 fh=RAAmxE/pUHdPd+XTvkc4GjMsd7mnnAvd6H4dWa4ydf0=;
 b=WTP86Ry8swxV0eQruP69s25cDaawvpBHnr4VD4k4+dxrMoEw+pOfv1NBJwVdfFdHek
 5HIKQIVWTHte4H+LmIPoMqdFx/1OMy5/f/AnQMyog0XMZIRPUE3TkG0ibxcxlvk2WD0L
 sOoOTcfmHt+4f6/BLxlVFOx3IZtGI0et9o051q1EhmGtx1H8KIfEgO7Pmxn7GhHcUSp8
 e8j+jvadI1JPw2nVy7cXh74lCCHxeXF+OoVWmDPUa9L5vl5l+WAZG7ozLBK39x/wFAEC
 33n30UKlHOMg+iKWmXTElhk51LvpiGy49xEHGLiBwyraiaflRs7k4khy4GbADiG2Tr5H
 3uYA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784044487; x=1784649287; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m6D46s8NJr7qK3sVHu66F8E79I00qTDm1gxjChzZa+s=;
 b=EVl5FAyQLTKEu01Dk1Zv0yrg+hncV2Bsp8FVMHtOlrPQh6feDSdQvM3Xnj1I/n0C4x
 4Y2pqy1zOtogw5pZ1b1UWo95p5jvCpXwhlSkcjw/TphEiOR8+VdrOKb6PgOiONhQMzBp
 4rP0pTd0GrU1z5GoVBccmfFNlwJXJntWz8NwB8+GlCLQx8du6mlvnRhy2XcJ63kXVVsy
 5MkC7o7krPxypppzzUb4ps/Zwiq/ZSwtoAb/Qe2eN1KvwN6WtTeysho3L2XsmFgw3zX+
 jVtdBUJRfcQeBPme4TNfAFqEY+wYVBw3AQPMh4+MwhcjU4GLda8rK9sZiRBpwKOJZ1Na
 vcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784044487; x=1784649287;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m6D46s8NJr7qK3sVHu66F8E79I00qTDm1gxjChzZa+s=;
 b=WnzHlW7L+gQZc0zwKk4kSZDyrB8yu5WwmbsplqDrNIqlzhstqVHUO7B5Pem8TE/tbB
 8aCQP1YHezg+Ftlx3Inptd2n3ivTnXXlELSNNuiKlG2Et86V6JV2feXse2Nu19vd6MfG
 J9vvNtvCRPg9fB8PXZZH840CPW+PfEUy2V7cmfN/UnH/n6G+iCahG3yLxtIHm3FXruaD
 8y3cMD4/BE/qPJXrI09gcj2iA86esUxB/pxxIIkjlVCFyuEXTFtClHq9E62+rZ+0uV5v
 zteuKmjTxYIh1Fif7GoOJd2v7L5JjW23edp6gL9BCmBqhKI/del5VWbhJR1as3XCZ8LJ
 9KGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKosL61+DdWx3u7YIY9pTSdFlbN9GgrKEAUSB+KHFqr3EKReNbe8ygGhGXqdgCTzIQBHK3VpUx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdmJKaDGosLLOc9wjjGeozKtCr7q4bvuP7RROIEE/GY6c8qwxS
 NVLqWqMzEQFvdHSpcewX03/EVcl2p66VoorKebtxlougQ/BCNwswTGIgWcAPuS/N20AWAs5JtUN
 G/LH8g3r6yKr+BHAj3x2R5bzdpYmPlpOG8A==
X-Gm-Gg: AfdE7cl5RgHFd5vKxfVbu9VU7brYMPnj2DCZSXoT4VzUYtcblJOfcJ4Qse6b/QDFUiN
 goBo8QGGTiHHIOP2jBRBQrhmmM+Lkd0Lb7EJUfaJhAC91sj3O9+XtQD2fivl4mVqwVvEkvEaqgu
 1ytgGvMIRCiHH0qaGuMVZQck3GyducaSsqxmvr2Te0CAom/X2ShoXdUrPxIzdD6H41Pk31Fztzt
 OvBvvxGWAr3ZI16JQwkTNgVJW1dK945oGrEMznHdxd522qCsDB+wqWskMPfomEUNt4mxe1mwpRk
 wjqCmYtQxHjZO8XqyrSBG9hSTr8l+sK8MDRBF9ZYq3UTeCjSUiXBNKQmZDVXbk+HIXDJPQ==
X-Received: by 2002:a17:902:fc45:b0:2cc:e7f3:d39e with SMTP id
 d9443c01a7336-2ce9e29f5b2mr113712015ad.2.1784044486800; Tue, 14 Jul 2026
 08:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260714151536.3315492-1-suresh.guttula@amd.com>
In-Reply-To: <20260714151536.3315492-1-suresh.guttula@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 11:54:34 -0400
X-Gm-Features: AUfX_myKpftClMniaESWfdl8YJIbtKtoHrNDGLnWNgK4W__j9VZWMSbHRlDydJA
Message-ID: <CADnq5_Pt+hfvEL8AwGLC2-sgDkZpv-gEWf2mjMMbbfwJnAEW3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu : update mmhub eco sec lvl for vcn5_3
To: Suresh Guttula <suresh.guttula@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Tue, Jul 14, 2026 at 11:16=E2=80=AFAM Suresh Guttula <suresh.guttula@amd=
.com> wrote:
>
> This patch requests PSP to set the sec lvl for
> vcn and jpeg.
>
> Signed-off-by: Suresh Guttula <suresh.guttula@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 27 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 24 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 26 +++++++++++++++++++++++
>  5 files changed, 79 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index a36cbfc1f6f1..64281553c6d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1222,6 +1222,33 @@ int psp_memory_partition(struct psp_context *psp, =
int mode)
>         return ret;
>  }
>
> +int psp_set_mmhub_eco_sec_level(struct amdgpu_device *adev)
> +{
> +       int ret;
> +       struct psp_context *psp =3D &adev->psp;
> +       struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
> +
> +       cmd->cmd_id =3D GFX_CMD_ID_SET_MMHUB_ECO_SEC_LEVEL;
> +
> +       ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr=
);
> +       if (ret) {
> +               dev_err(psp->adev->dev,
> +                       "PSP request failed to set mmuhub eco sec level w=
ith ret=3D%d\n", ret);
> +               release_psp_cmd_buf(psp);
> +               return ret;
> +       }
> +
> +       if (cmd->resp.status) {
> +               dev_err(psp->adev->dev,
> +                       "MMHUB ECO SEC LEVEL command 0x%x failed, PSP res=
ponse status: 0x%X\n",
> +                               cmd->cmd_id, cmd->resp.status);
> +               ret =3D -EIO;
> +       }
> +       release_psp_cmd_buf(psp);
> +
> +       return ret;
> +}
> +
>  static int psp_ptl_fmt_verify(struct psp_context *psp, enum amdgpu_ptl_f=
mt fmt,
>                                                  uint32_t *ptl_fmt)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index 2d838b1b2b11..3d7744d60fac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -656,5 +656,6 @@ int amdgpu_psp_reg_program_no_ring(struct psp_context=
 *psp, uint32_t val,
>  void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
>  int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
>                            enum psp_gfx_fw_type *type);
> +int psp_set_mmhub_eco_sec_level(struct amdgpu_device *adev);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_3_0.c
> index 66d4c487eee5..4dcdbf84745e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -399,6 +399,25 @@ static void jpeg_v5_3_0_stop_dpg_mode(struct amdgpu_=
device *adev, int inst_idx)
>         WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
>  }
>
> +/**
> + * jpeg_v5_3_0_set_mmhub_eco_sec_level - set jpeg sec lvl reg
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * request psp to set secure lvl
> + */
> +static int jpeg_v5_3_0_set_mmhub_eco_sec_level(struct amdgpu_device *ade=
v)
> +{
> +       int r =3D 0;
> +
> +       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
> +               //Request to PSP to program JPEG secure lvl
> +               r =3D psp_set_mmhub_eco_sec_level(adev);
> +       }
> +
> +       return r;
> +}
> +
>  /**
>   * jpeg_v5_3_0_start - start JPEG block
>   *
> @@ -424,6 +443,11 @@ static int jpeg_v5_3_0_start(struct amdgpu_device *a=
dev)
>         if (r)
>                 return r;
>
> +       /* program JPEG secure lvl register */
> +       r =3D jpeg_v5_3_0_set_mmhub_eco_sec_level(adev);
> +       if (r)
> +               return r;
> +
>         /* JPEG disable CGC */
>         jpeg_v5_3_0_disable_clock_gating(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/am=
d/amdgpu/psp_gfx_if.h
> index ac34bac3c839..ad618b78685f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> @@ -110,6 +110,7 @@ enum psp_gfx_cmd_id
>      GFX_CMD_ID_PERF_HW            =3D 0x0000004C,   /* performance monit=
or */
>      GFX_CMD_ID_FB_FW_RESERV_ADDR  =3D 0x00000050,  /* Query FW reservati=
on addr */
>      GFX_CMD_ID_FB_FW_RESERV_EXT_ADDR =3D 0x00000051,  /* Query FW reserv=
ation extended addr */
> +    GFX_CMD_ID_SET_MMHUB_ECO_SEC_LEVEL =3D 0x0000005D,  /* Set MMHUB ECO=
 sec lvls on VCN block */
>  };
>
>  /* PSP boot config sub-commands */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 45580e9c4e0c..0ca87ab2bfc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -795,6 +795,27 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_v=
cn_inst *vinst,
>         return 0;
>  }
>
> +/**
> + * vcn_v5_0_0_set_mmhub_eco_sec_level - set vcn sec lvl reg
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * request psp to set sec lvl
> + */
> +static int vcn_v5_0_0_set_mmhub_eco_sec_level(struct amdgpu_device *adev=
)
> +{
> +       int r =3D 0;
> +
> +       if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(5, 3, =
0)) {
> +               if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
> +                       //Request to PSP to program VCN secure lvl

C style comments please.  With at fixed,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +                       r =3D psp_set_mmhub_eco_sec_level(adev);
> +               }
> +       }
> +
> +       return r;
> +}
> +
>  /**
>   * vcn_v5_0_0_start - VCN start
>   *
> @@ -819,6 +840,11 @@ static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *=
vinst)
>
>         fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
>
> +       /* program VCN secure lvl register */
> +       r =3D vcn_v5_0_0_set_mmhub_eco_sec_level(adev);
> +       if (r)
> +               return r;
> +
>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>                 return vcn_v5_0_0_start_dpg_mode(vinst, adev->vcn.inst[i]=
.indirect_sram);
>
> --
> 2.43.0
>
