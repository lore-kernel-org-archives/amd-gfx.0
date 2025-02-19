Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1071EC021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 19:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A05D410E063;
	Wed, 19 Feb 2025 19:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NPTEGqK9";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ECC110E063
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 19:56:23 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fc0ab102e2so41526a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 11:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739994983; x=1740599783; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maKztO1eOvgxgENbFijNIYqtBRpZC5lg3aik5qN5vBs=;
 b=NPTEGqK9nKYq17xnvYITUI3Uw4WocxcPYlkzkaDOAAb4GXavHo/mVdU2D4+5iNriEK
 isSR2n2/vULbT3km24WUQeHkviaPMZkA4SEOQ57NYEXas5nqpe+5SKpOcOmODZFUB+ki
 vgaYcSS8Zx70cRER6m9/Pbv/aWJpNUZkw/zIL2lYwtAV3g9hl5FoqvfQ0p4v10BYuMbn
 oUBWVLLjKcD1dtjkPumPEwAsrCGCSs7Rl7cOuUljdjPWOaKRr3hKg4IuFI0S5Xi/R6Vk
 HSAmPkQh5AAL2z6/uX2H96xAv5CX++JWAJGGta0TWp1J+g5aMxk9tk+hWR6BcORs4bkz
 nsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739994983; x=1740599783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maKztO1eOvgxgENbFijNIYqtBRpZC5lg3aik5qN5vBs=;
 b=gsQHcY4A0+ZRFKqQV/Kdhoy4uC3YmYcWro2X+PmffbHn7o0bj5Nn4n/kF7Jxe+vWcD
 /Ju2YAehWW74MaTn8OaYstmPHJuWu8kiYQwKHlTXov1gb3aQoUYEyTk176HfVX5Q0tHm
 rERPhLoUQEcthqZ89PZ8JXeNMYKBUi3lR+xIEHPoX+ZVOnDSTc1AKZwQSW/gXBQhyP5Y
 xwmfsnyBNaF2+MZrSsyIY3PaNUHOrd532bcDHMFvyScUchcmsKqi1BdTas4XbvgSFsgH
 yvD9C1iogPWiDtN7PWyjdO1GobsQ+tgPb/a2ALwPNv5N+yMzC0by9Vga6/mnidJVLV7d
 T4vg==
X-Gm-Message-State: AOJu0Yx5W+54oiF0Gp//l05Dl4ShmljI4IvNS04QXGRDfj9HpKvM2wZH
 T6Q9CFU4r4EIyBXeMk3qfTAPjdr2fUsWdoeDcMvdHck3EV56pklDaI2myLLKA485kXvvTkWIvR/
 Ic164o96hViMq8lqycei5dkrNlkyZ0g==
X-Gm-Gg: ASbGncskMi0tvVDzQK5y5vf6jLIXdwawam70R2pZuHgvMvBcEoHXP3lVPBT39kyE0kS
 tDiLdagtLueycxN5OlHFdbq35QdJ6X4wtw7c3DfL5cC4Ob+tqFnsHOCPFcM5T9hs1TOew1rG8
X-Google-Smtp-Source: AGHT+IGvxDrOfVB9wdpT6b0pr5QAZj+K+h+l7iLubLis/qXdzSGOPKUgUGN3Oj6/881CYOzzQDKGey6kSaec1AZ9kQ4=
X-Received: by 2002:a17:90b:4c07:b0:2ee:948b:72d3 with SMTP id
 98e67ed59e1d1-2fc40d124bbmr11626061a91.1.1739994982866; Wed, 19 Feb 2025
 11:56:22 -0800 (PST)
MIME-Version: 1.0
References: <20250126083733.3331474-1-Prike.Liang@amd.com>
In-Reply-To: <20250126083733.3331474-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Feb 2025 14:56:11 -0500
X-Gm-Features: AWEUYZmQAJIuVe3b7ZmoOnuqTgOCb7iOb8OKyNTIjXDeoRFN__VJ8NuS94rcvA0
Message-ID: <CADnq5_PEMn-K9APP6dtRXz-xVcU_Zx21b27J0Z0m+TJKVBTmbw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu/gfx11: Implement the GFX11 KGQ pipe reset
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
> Implement the kernel graphics queue pipe reset,and the driver
> will fallback to pipe reset when the queue reset fails. However,
> the ME FW hasn't fully supported pipe reset yet so disable the
> KGQ pipe reset temporarily.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 76 +++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 89d17750af04..395872bb1401 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -65,6 +65,8 @@
>  #define regPC_CONFIG_CNTL_1            0x194d
>  #define regPC_CONFIG_CNTL_1_BASE_IDX   1
>
> +static uint32_t me_fw_start_pc;
> +
>  MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_0_mec.bin");
> @@ -2932,6 +2934,9 @@ static void gfx_v11_0_config_gfx_rs64(struct amdgpu=
_device *adev)
>         tmp =3D REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE2_RESET, 0);
>         tmp =3D REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE3_RESET, 0);
>         WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
> +
> +       /* cache the firmware start PC */
> +       me_fw_start_pc =3D RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_=
INSTR_PNTR1));

You can't use a global variable.  It won't work if you have multiple
GPUs in the system.

Alex

>  }
>
>  static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device=
 *adev)
> @@ -6654,6 +6659,68 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_=
ring *ring)
>         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>  }
>
> +static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev)
> +{
> +       /* Disable the pipe reset until the CPFW fully support it.*/
> +       dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.=
\n");
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
> +       r =3D RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1))=
 - me_fw_start_pc;
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
> @@ -6663,8 +6730,13 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring =
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
