Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0C6C021B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 19:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735C210E880;
	Wed, 19 Feb 2025 19:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yf1+kJ82";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0333B10E880
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 19:57:09 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2fc317ea4b3so40645a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 11:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739995028; x=1740599828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JE6QnxKevNpOqFY7ULKSq35Oiy0oJ+6o9BM6KTDk5Mc=;
 b=Yf1+kJ82VYlytvwKAE7a2Gv4IkE1LbXPinOG4RoLTIFQp3+okEwg7wM8y4zqnlV/8P
 7rs+FuHv65vWCR0wPQsBtxC/5LcMpJbS44nQenslQICrgWxKh/LxPqOt4H0z0aFRQKiz
 xj1v4S9RhW/DyOTujChhWjtjL6gYieQ4/9QWtSL77AzR6CbyaU7k0bGtpvl2YiIF7IVo
 r9nBaGQjKIKhdACFJUeGoTzF4akKrq4pY5fMN50wXtuqRkQd4Bp4ie4hxutM2EyA9zXL
 CnxLRSrTkMD6MQ27X0sZesRkrm1ZorFuOKN2sKwm6R5KGtBebLws+dL45TMbX84l7tVG
 ObPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739995028; x=1740599828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JE6QnxKevNpOqFY7ULKSq35Oiy0oJ+6o9BM6KTDk5Mc=;
 b=RCOhpMjhPQd/aUqRuT1TLhQ+ek4XYXcJ/Vo2ywgKM9/etbPlTdTmkwXhZCGbMFAFAM
 OJW7JpTJlACRQeIE9qcW+kZFcAfgd0iiYOwp86VaxTzuV0GAVNJRKTu0t/Dg9K5s27+H
 C9MEenfJ7G4v5TN57JsK/Zx8/HQ6N4bz1XsRwtBOaR5D+BhgxY2Cd7kq5GSid2R8Vhre
 ispxEFOLVCv+0bczwStNv1cshT3Mmv2XMnBLT5G6XBSVoTSn+ou9Xfz8KS0aUVXVFTfw
 be++VF2TR86Hphmh/hH0HB01R4SXN3DSGd+UfWzRSEeO7BClBN6qTnCN84Q1/CuhLCMU
 OEGg==
X-Gm-Message-State: AOJu0YxoXEnVdrZHNqTGK87AJxWT0EQH+v3/YK76ulVRbEP0jPnMUPx7
 b/JJao4+7mf8HfNCO8QWn+fpywiwEi3BA2ALDiDhOuzc1HVPGPZYgmC5jeVHmzIdPwz+3zUh1dG
 NjH4PMSJFodH6t/P8qMcNfaM6HN+V/w==
X-Gm-Gg: ASbGnct6jpGahWes4wRdESUL9cEuC9jMCLZBKgI12uE4rqqCKwK0yAkO8E6XkVREcpS
 i8enRcSw/Ys85ST/bKG9PNtsR90YzuI+7Pzq+K8i4pPpXAETr0YLarRL8LfSSyybgcV47gTtr
X-Google-Smtp-Source: AGHT+IHrLUXpSnfU4V4LJ/D+ueksjZjaS/H0aho3AsfxF+44GN+1ke8KMQ1NzCBD1F+3OdPrCUIV42F50lqk1r+aT3c=
X-Received: by 2002:a17:90b:3a8f:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2fc40d126a3mr11857423a91.1.1739995028334; Wed, 19 Feb 2025
 11:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20250126083733.3331474-1-Prike.Liang@amd.com>
 <20250126083733.3331474-2-Prike.Liang@amd.com>
In-Reply-To: <20250126083733.3331474-2-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Feb 2025 14:56:56 -0500
X-Gm-Features: AWEUYZnZ_01wzd0-hb6zzOrJZT4ItnnSHPBA-kwo8tlAP2J3sYFaFbVUYrRtLfI
Message-ID: <CADnq5_NDOpgA434kk-t5O8MD3Oc+oU6yJLfMAtZDfVfpzC8KhQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu/gfx11: Implement the GFX11 KCQ pipe reset
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Lijo.Lazar@amd.com
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

On Sun, Jan 26, 2025 at 3:38=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Implement the GFX11 compute pipe reset. As the GFX11 CPFW
> still hasn't fully supported pipe reset yet, therefore
> disable the KCQ pipe reset temporarily.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 139 ++++++++++++++++++++++++-
>  1 file changed, 136 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 395872bb1401..39fd3ce67ec9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -66,6 +66,7 @@
>  #define regPC_CONFIG_CNTL_1_BASE_IDX   1
>
>  static uint32_t me_fw_start_pc;
> +static uint32_t mec_fw_start_pc;

Same comment here as on patch 1.

Alex

>
>  MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
> @@ -2937,6 +2938,7 @@ static void gfx_v11_0_config_gfx_rs64(struct amdgpu=
_device *adev)
>
>         /* cache the firmware start PC */
>         me_fw_start_pc =3D RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_=
INSTR_PNTR1));
> +       mec_fw_start_pc =3D RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC_RS64=
_INSTR_PNTR));
>  }
>
>  static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device=
 *adev)
> @@ -3812,7 +3814,7 @@ static int gfx_v11_0_cp_compute_load_microcode(stru=
ct amdgpu_device *adev)
>                              le32_to_cpup(fw_data + mec_hdr->jt_offset + =
i));
>
>         WREG32_SOC15(GC, 0, regCP_MEC_ME1_UCODE_ADDR, adev->gfx.mec_fw_ve=
rsion);
> -
> +       mec_fw_start_pc =3D RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INS=
TR_PNTR));
>         return 0;
>  }
>
> @@ -6764,6 +6766,135 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring=
 *ring, unsigned int vmid)
>         return amdgpu_ring_test_ring(ring);
>  }
>
> +static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
> +{
> +
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
> +       reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> +       clean_pipe =3D reset_pipe;
> +
> +       if (adev->gfx.rs64_enable) {
> +
> +               switch (ring->pipe) {
> +               case 0:
> +                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> +                                                  MEC_PIPE0_RESET, 1);
> +                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_R=
S64_CNTL,
> +                                                  MEC_PIPE0_RESET, 0);
> +                       break;
> +               case 1:
> +                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> +                                                  MEC_PIPE1_RESET, 1);
> +                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_R=
S64_CNTL,
> +                                                  MEC_PIPE1_RESET, 0);
> +                       break;
> +               case 2:
> +                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> +                                                  MEC_PIPE2_RESET, 1);
> +                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_R=
S64_CNTL,
> +                                                  MEC_PIPE2_RESET, 0);
> +                       break;
> +               case 3:
> +                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> +                                                  MEC_PIPE3_RESET, 1);
> +                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_R=
S64_CNTL,
> +                                                  MEC_PIPE3_RESET, 0);
> +                       break;
> +               default:
> +                       break;
> +               }
> +               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
> +               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
> +               r =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) - me=
c_fw_start_pc;
> +       } else {
> +               if (ring->me =3D=3D 1) {
> +                       switch (ring->pipe) {
> +                       case 0:
> +                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME1_PIPE0_=
RESET, 1);
> +                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME1_PIPE0_=
RESET, 0);
> +                               break;
> +                       case 1:
> +                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME1_PIPE1_=
RESET, 1);
> +                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME1_PIPE1_=
RESET, 0);
> +                               break;
> +                       case 2:
> +                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME1_PIPE2_=
RESET, 1);
> +                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME1_PIPE2_=
RESET, 0);
> +                               break;
> +                       case 3:
> +                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME1_PIPE3_=
RESET, 1);
> +                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME1_PIPE3_=
RESET, 0);
> +                               break;
> +                       default:
> +                               break;
> +                       }
> +                       /* mec1 fw pc: CP_MEC1_INSTR_PNTR */
> +               } else {
> +                       switch (ring->pipe) {
> +                       case 0:
> +                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME2_PIPE0_=
RESET, 1);
> +                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME2_PIPE0_=
RESET, 0);
> +                               break;
> +                       case 1:
> +                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME2_PIPE1_=
RESET, 1);
> +                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME2_PIPE1_=
RESET, 0);
> +                               break;
> +                       case 2:
> +                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME2_PIPE2_=
RESET, 1);
> +                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME2_PIPE2_=
RESET, 0);
> +                               break;
> +                       case 3:
> +                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME2_PIPE3_=
RESET, 1);
> +                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> +                                                          MEC_ME2_PIPE3_=
RESET, 0);
> +                               break;
> +                       default:
> +                               break;
> +                       }
> +                       /* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
> +               }
> +               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
> +               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
> +               r =3D RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNT=
R)) - mec_fw_start_pc;
> +       }
> +
> +       soc21_grbm_select(adev, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +       gfx_v11_0_unset_safe_mode(adev, 0);
> +
> +       dev_info(adev->dev,"The ring %s pipe resets to MEC FW start PC: %=
s\n", ring->name,
> +                       r =3D=3D 0 ? "successfully" : "failed");
> +       /*FIXME:Sometimes driver can't cache the MEC firmware start PC co=
rrectly, so the pipe
> +        * reset status relies on the compute ring test result.
> +        */
> +       return 0;
> +}
> +
>  static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vm=
id)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -6774,8 +6905,10 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring =
*ring, unsigned int vmid)
>
>         r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true)=
;
>         if (r) {
> -               dev_err(adev->dev, "reset via MMIO failed %d\n", r);
> -               return r;
> +               dev_warn(adev->dev,"fail(%d) to reset kcq and try pipe re=
set\n", r);
> +               r =3D gfx_v11_0_reset_compute_pipe(ring);
> +               if (r)
> +                       return r;
>         }
>
>         r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> --
> 2.34.1
>
