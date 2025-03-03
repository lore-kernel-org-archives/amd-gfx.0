Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89B3C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 14:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7018A10E43B;
	Mon,  3 Mar 2025 14:47:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mHAHcyzB";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B2F10E22F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 14:47:09 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2fe82430bb4so1220746a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Mar 2025 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741013229; x=1741618029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XK+Hd/k0ByF1L35UfVMhnlWN42x9v5/BoEVtRFuZejE=;
 b=mHAHcyzBJ5bWrWPPOQIgCzdy/1zXARFF4eZfc5ScAG0oh7LCqsdJaKoINb9VWv0lWH
 /dmwGaXUbducuhRkPNoo/xzXegvyOQVK7T619SJM1xzU4MDD+ysDHMxE/M4SqTzUptBP
 QcubBjm/wciPmT28FvbGA1gdWzCX29ZcPG0RoVGLKy5idm+D9Vj2UmEg2uENKfMA53Bd
 9OJStpabUdGgud/pJpbVnczYOBAvysg2nStgywD3Or4Xoe2yaN82P969aXFwf3FldgsZ
 R9X1XpsZQtqVTaZVU4SzA4aME5w2kr7GEX+FVoovwDLmeu5o59ybgEHRJS6UItdKfGax
 AQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741013229; x=1741618029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XK+Hd/k0ByF1L35UfVMhnlWN42x9v5/BoEVtRFuZejE=;
 b=sH6BEm5RbhGEKeS0co7yOTs8dEjRNUn0EGQGUStmP5pqW1eiVVR+hhDOTYTWdV/agP
 Cne4KcrXPSVvpPeMTj8q9pu2R+bVGhn8x9JoSEm3sLYrb+CfigwhdqU7f9tgUA9Ik3iI
 do6Ih/0OxaSlMv6Y/KiRwS/y4ZUBZ67kl1xHzNMR51n9eHWeu1XvByJc6JyzGwPnnNWv
 dF6BfdtUgTHeKglciZLING78Fmgs16FmxF+hZU3hUPO/1BzZhtEu4yMt2OGO9R39IsQT
 B4I4CYT/FZkuNSShiiwLopJk0cr5gFEedQmEv4m7kChnCzrFxEuMAeneCjo3tIu5vkVD
 Vrsg==
X-Gm-Message-State: AOJu0Yz5xYtqbz0SNdiF/5P2VRTfv3nS18lu2rMdHIkCHjTmWJNZXXAS
 y7+QHdESFmov9hnifq4TTbq2fGP7dkORjukxehXWN8fVliC8Kd+BnXSko2IpyT9jl0vkHT7YnJs
 BWg84S9+w/t5hNh37iLDsrp2jdpw=
X-Gm-Gg: ASbGncuvxhnU9GWCohAD2r9JV8/cbfmRabZU3sylfUoYAZeazt0yEBY6yw8jkgCJP33
 a+007iQO3O6xd0RYyy69QBOYNiOoEzBjvOSNoH+TC1OsTAqM+gn9FWqNfIwU0vBGZ3rPK24Mjfl
 uw+ZGMJZiW3PvuwgaV40/CZTQqSw==
X-Google-Smtp-Source: AGHT+IHwNNbpFiw2qhe/XfcovBmRgTFMaEOi3pPJ2wR5mQlUY7dE+I2mjulGKYDbtuVHtq2he+HdEjnHmpngei6wGHI=
X-Received: by 2002:a17:90b:1e46:b0:2fc:3262:9465 with SMTP id
 98e67ed59e1d1-2febabf49c6mr8249462a91.5.1741013228706; Mon, 03 Mar 2025
 06:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20250221130030.3703750-1-Prike.Liang@amd.com>
In-Reply-To: <20250221130030.3703750-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Mar 2025 09:46:56 -0500
X-Gm-Features: AQ5f1Jp88L6FQz7MRKdLQQGzWXIl-PyUL9-EClPUZT-fAlVsWb_Xs--yT9U_bpA
Message-ID: <CADnq5_N+=TF6EvmoOEV3RNayDHtbZBysopu1=CcuKiL9DFtQxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/amdgpu/gfx11: Implement the GFX11 KGQ pipe
 reset
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

On Fri, Feb 21, 2025 at 8:38=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Implement the kernel graphics queue pipe reset,and the driver
> will fallback to pipe reset when the queue reset fails. However,
> the ME FW hasn't fully supported pipe reset yet so disable the
> KGQ pipe reset temporarily.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 71 ++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.h
> index 4eedd92f000b..06fe21e15ed6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -25,6 +25,8 @@
>
>  #include "amdgpu_socbb.h"
>
> +#define RS64_FW_UC_START_ADDR_LO 0x3000
> +
>  struct common_firmware_header {
>         uint32_t size_bytes; /* size of the entire header+image(s) in byt=
es */
>         uint32_t header_size_bytes; /* size of just the header in bytes *=
/
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 2c7f0bb242ff..7e53c0b63f88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6653,6 +6653,68 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_=
ring *ring)
>         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>  }
>
> +static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev)
> +{
> +       /* Disable the pipe reset until the CPFW fully support it.*/
> +       dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.=
\n");

I'd drop these or make them debug only for now.  Same for gfx12.  With
that fixed, the series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>


> +       return false;
> +}
> +
> +
> +static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> +       int r;
> +
> +       if (!gfx_v11_pipe_reset_support(adev))
> +               return -EOPNOTSUPP;
> +
> +       gfx_v11_0_set_safe_mode(adev, 0);
> +       mutex_lock(&adev->srbm_mutex);
> +       soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> +
> +       switch (ring->pipe) {
> +       case 0:
> +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> +                                          PFP_PIPE0_RESET, 1);
> +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> +                                          ME_PIPE0_RESET, 1);
> +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> +                                          PFP_PIPE0_RESET, 0);
> +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> +                                          ME_PIPE0_RESET, 0);
> +               break;
> +       case 1:
> +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> +                                          PFP_PIPE1_RESET, 1);
> +               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
> +                                          ME_PIPE1_RESET, 1);
> +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> +                                          PFP_PIPE1_RESET, 0);
> +               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
> +                                          ME_PIPE1_RESET, 0);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
> +       WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
> +
> +       r =3D (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)=
) << 2) - RS64_FW_UC_START_ADDR_LO;
> +       soc21_grbm_select(adev, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +       gfx_v11_0_unset_safe_mode(adev, 0);
> +
> +       dev_info(adev->dev,"The ring %s pipe reset to the ME firmware sta=
rt PC: %s\n", ring->name,
> +                       r =3D=3D 0 ? "successfuly" : "failed");
> +       /* FIXME: Sometimes driver can't cache the ME firmware start PC c=
orrectly, so the pipe reset status
> +        * relies on the later gfx ring test result.
> +        */
> +       return 0;
> +}
> +
>  static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vm=
id)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -6662,8 +6724,13 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring =
*ring, unsigned int vmid)
>                 return -EINVAL;
>
>         r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false=
);
> -       if (r)
> -               return r;
> +       if (r) {
> +
> +               dev_warn(adev->dev,"reset via MES failed and try pipe res=
et %d\n", r);
> +               r =3D gfx_v11_reset_gfx_pipe(ring);
> +               if (r)
> +                       return r;
> +       }
>
>         r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
>         if (unlikely(r !=3D 0)) {
> --
> 2.34.1
>
