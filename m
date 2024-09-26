Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA03CDE005
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 13:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2730810EB49;
	Thu, 26 Sep 2024 13:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Avci+RYw";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5181E10EB45
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 13:33:04 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-84e83028d15so24368241.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727357583; x=1727962383; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tifCPIQ/xHIjuG+SgBy0zc0sgsiXZq3PCZDaKHn5cHA=;
 b=Avci+RYwdFsDf4ic1MH3RLt9LQWv752wF95+qiic4E0nx6zLs+0aLziSJGMuAKYcYT
 Gqn7TnXXCHcpn/BGMmEQ3QIUCPN2V5tnfUtzEGOnMbmaffvovCCFRHGpg/RncSGndODK
 hJwrO4uGZGhtWVhYP5V3NmvuZBaeXGKwqIw4YhYd1I+s2jMWNHbt49Z3a2njZ3cB1dJD
 LB60iW3my14AD2uEP+zwQtrPLRijDMqrKMY5+nsa2XR4RPRImCYnRLHjdZbEljYEU2og
 oHxtXxX6MMm36/UhH2ynxsi3Moi3Xv6h128dHRNCSTAsNzJ7R+a6wTjOkJzvlKr4r3+X
 8FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727357583; x=1727962383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tifCPIQ/xHIjuG+SgBy0zc0sgsiXZq3PCZDaKHn5cHA=;
 b=E14oasIvaTsrXppA46Eel8cPFbH8XZfkbtk4b8pn7Wl1G5LNdli6wHukhC8oaUOnIG
 f0x4YFK7X3I2h8rial4uOGi/Of/gr+c35HUTKkkNLWLHxxA3b2KMu+r8Cc4mu4pw6MIa
 +lhWNEceIwYGOnvFlMoYk4MhcMEoDPO/ndlut9lAt8sody4ziNRyRhiElnxABYGJvkBY
 voQ7llAdeHvFqVbcIrEZZLrB6Cwix8zoaFeIWTwfLs3v6gpVC074zYx4aPlK9nGXrxvG
 YI8k3SoNbptgCJyd3hxdLn5hTFsf2c/oIFGCPQj3wOB7EdF+5yon2mlyHlRxYTXB0Tdx
 rIxA==
X-Gm-Message-State: AOJu0YwVSIqwMwGE7WPbC+ZGQHF/elOY0b2kRtOMLTZjCVtmELR2qQuW
 FmCOORpmUJh6k6MZRpyh5QFu0/1Ea7khxum7v+pQ/sJTkCuwMjpfNkWmwlt8MIe9PJqriWd4yEi
 ouJpWoFCjfPqRd5rsFujTxoO2oRo=
X-Google-Smtp-Source: AGHT+IEYiijijRGeuPBGaKx5seUFE36p4B2Unx75C7v4tj6hFOzDKyEL3iRYhKiiKXuYKeZRTudS85C/gBK5athMUMg=
X-Received: by 2002:a05:6122:2510:b0:4fa:c06a:3768 with SMTP id
 71dfb90a1353d-505c1d29511mr1955509e0c.1.1727357582967; Thu, 26 Sep 2024
 06:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240926074536.22211-1-jiadong.zhu@amd.com>
 <20240926074536.22211-2-jiadong.zhu@amd.com>
In-Reply-To: <20240926074536.22211-2-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Sep 2024 09:32:50 -0400
Message-ID: <CADnq5_O4poAX0xOUkHc98-xEuZiSx3Sq7f2r1ijSnw1Qid4fSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm/amdgpu/sdma5: implement ring reset callback
 for sdma5
To: jiadong.zhu@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Thu, Sep 26, 2024 at 3:58=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Implement sdma queue reset callback via MMIO.
>
> v2: enter/exit safemode when sdma queue reset.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 88 ++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index e813da1e48aa..416273d917e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1555,6 +1555,93 @@ static int sdma_v5_0_soft_reset(void *handle)
>         return 0;
>  }
>
> +static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int =
vmid)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       int i, j, r;
> +       u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, preempt, soft_reset=
, stat1_reg;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               if (ring =3D=3D &adev->sdma.instance[i].ring)
> +                       break;
> +       }
> +
> +       if (i =3D=3D adev->sdma.num_instances) {
> +               DRM_ERROR("sdma instance not found\n");
> +               return -EINVAL;
> +       }
> +
> +       amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> +
> +       /* stop queue */
> +       ib_cntl =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_=
IB_CNTL));
> +       ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, =
0);
> +       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib=
_cntl);
> +
> +       rb_cntl =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_=
RB_CNTL));
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, =
0);
> +       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb=
_cntl);
> +
> +       /* engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze b=
it to 1 */
> +       freeze =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZ=
E));
> +       freeze =3D REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 1);
> +       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze)=
;
> +
> +       for (j =3D 0; j < adev->usec_timeout; j++) {
> +               freeze =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDM=
A0_FREEZE));
> +               if (REG_GET_FIELD(freeze, SDMA0_FREEZE, FROZEN) & 1)
> +                       break;
> +               udelay(1);
> +       }
> +
> +       /* check sdma copy engine all idle if frozen not received*/
> +       if (j =3D=3D adev->usec_timeout) {
> +               stat1_reg =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mm=
SDMA0_STATUS1_REG));
> +               if ((stat1_reg & 0x3FF) !=3D 0x3FF) {
> +                       DRM_ERROR("cannot soft reset as sdma not idle\n")=
;
> +                       r =3D -ETIMEDOUT;
> +                       goto err0;
> +               }
> +       }
> +
> +       f32_cntl =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32=
_CNTL));
> +       f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
> +       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_c=
ntl);
> +
> +       cntl =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +       cntl =3D REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
> +       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
> +
> +       /* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT =3D 0 mmGRBM_SOFT_RESET=
.SOFT_RESET_SDMA0/1 =3D 1 */
> +       preempt =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_=
PREEMPT));
> +       preempt =3D REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT,=
 0);
> +       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), pr=
eempt);
> +
> +       soft_reset =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +       soft_reset |=3D 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << =
i;
> +
> +       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
> +
> +       udelay(50);
> +
> +       soft_reset &=3D ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT <=
< i);
> +       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
> +
> +       /* unfreeze*/
> +       freeze =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZ=
E));
> +       freeze =3D REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
> +       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze)=
;
> +
> +       r =3D sdma_v5_0_gfx_resume_instance(adev, i, true);
> +
> +err0:
> +       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +       return r;
> +}
> +
>  static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
>  {
>         int i, r =3D 0;
> @@ -1897,6 +1984,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_rin=
g_funcs =3D {
>         .emit_reg_write_reg_wait =3D sdma_v5_0_ring_emit_reg_write_reg_wa=
it,
>         .init_cond_exec =3D sdma_v5_0_ring_init_cond_exec,
>         .preempt_ib =3D sdma_v5_0_ring_preempt_ib,
> +       .reset =3D sdma_v5_0_reset_queue,
>  };
>
>  static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
> --
> 2.25.1
>
