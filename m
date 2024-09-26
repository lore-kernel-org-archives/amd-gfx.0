Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280ECCDE005
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 13:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC03810EB4C;
	Thu, 26 Sep 2024 13:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQBB9d1d";
	dkim-atps=neutral
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B6210EB4C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 13:33:34 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-49bddb14797so58052137.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 06:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727357614; x=1727962414; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bo3fjlMGq0LoMWvVzsh4Sp7ZSxmJk2Vyw3TPLp/R2Bo=;
 b=QQBB9d1dFMsTWabKy6g8ZFx48Z4Ii89dbXttC9VzBT7HJFzTgQHCBlFy1895s8IAM2
 ZVESLWcVhkNItDcAETbzV/5stfA9IK06ubmyWXP5aB/6A4544jddA+kD7zaIbX1Hmhdc
 hY6+MDhx/FhxCPQT6rviX+N/ZcjWlZkrKzSFxl6PjD/JlroE7Yr366qhkkGCzhutyD9N
 v/+esEx9aNJ+tYZAnwYaXCt1sljLZUNR1vqcf1IdvNLJ+uR0urux/ZoHlkd7qfGFdReM
 FGJs7PJ+5H6wxZZ1JYwUm2FYTI29pzyKZzlcSY56LFQFotJ2msKb6b/E9PHrWzwBdwVQ
 wIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727357614; x=1727962414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bo3fjlMGq0LoMWvVzsh4Sp7ZSxmJk2Vyw3TPLp/R2Bo=;
 b=LBjGGwK7SUHBN4h3cpbZ5EKYMuA5D2xGTZu+Xu/n7DlTeG4X4+bq3ymrrcDmOJ5IuG
 XFboDG60h9MBkufb2lpJJQAqjxpP/rnumY6A37ln+qQ5uvUaYXZQ4ZVlyiLBt76buI5C
 C6W8SeN9iU3A8M5KFUjWmFNb4wsPtlgv9Qsddwp45E5hEGpeiD4WE5C9JFApknO7RyQ4
 pEMqJ2hWOdMaHGnSanCFQW/q+cgc5mY+GlA2u5r2vMgbObELwVnA3LMwJ5leRXYe1JYi
 rR0l7ComasZHxuGJQgArt6wLZxUD2hYU4pqaIv5EMG1jflli7uAVKV82oBDEWNn9nKah
 7atw==
X-Gm-Message-State: AOJu0Yyklv/fAL328goz88XrofKHlRog2zy8ChoFx5vuWiT2aTszGbMi
 ASIkMVkBuIc5AHbRstZ3oJ+6p2teC1WDmXaDbUcrstL/ivQkJPXgf2KHISpBZN73OGRZF+7lxj3
 q8IPPhlNtcvO72e+4xfTy7JaD9Vk=
X-Google-Smtp-Source: AGHT+IGiCn7rp0udj9wrHMvIthXYUD7iQpMVNIE8tITu+Q6SLH62oNetrV17Ys+Nu8ayc+mwvS/yM4AlMdWrUVSK15s=
X-Received: by 2002:a05:6122:468b:b0:502:c196:7961 with SMTP id
 71dfb90a1353d-505c20ad3b9mr1926324e0c.3.1727357613734; Thu, 26 Sep 2024
 06:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240926074536.22211-1-jiadong.zhu@amd.com>
 <20240926074536.22211-4-jiadong.zhu@amd.com>
In-Reply-To: <20240926074536.22211-4-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Sep 2024 09:33:22 -0400
Message-ID: <CADnq5_Oxb5+dx8cBiu8FfdFLr-KJd0Gf=H1ttP62N0DE+8aetQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/amdgpu/sdma5.2: implement ring reset callback
 for sdma5.2
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

On Thu, Sep 26, 2024 at 3:48=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Implement sdma queue reset callback via MMIO.
>
> v2: enter/exit safemode for mmio queue reset.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 91 ++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index 37534c6f431f..8e8f8be01539 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1424,6 +1424,96 @@ static int sdma_v5_2_wait_for_idle(void *handle)
>         return -ETIMEDOUT;
>  }
>
> +static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int =
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
> +       ib_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_=
IB_CNTL));
> +       ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, =
0);
> +       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib=
_cntl);
> +
> +       rb_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_=
RB_CNTL));
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, =
0);
> +       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb=
_cntl);
> +
> +       /*engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bi=
t to 1 */
> +       freeze =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZ=
E));
> +       freeze =3D REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 1);
> +       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze)=
;
> +
> +       for (j =3D 0; j < adev->usec_timeout; j++) {
> +               freeze =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDM=
A0_FREEZE));
> +
> +               if (REG_GET_FIELD(freeze, SDMA0_FREEZE, FROZEN) & 1)
> +                       break;
> +               udelay(1);
> +       }
> +
> +
> +       if (j =3D=3D adev->usec_timeout) {
> +               stat1_reg =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mm=
SDMA0_STATUS1_REG));
> +               if ((stat1_reg & 0x3FF) !=3D 0x3FF) {
> +                       DRM_ERROR("cannot soft reset as sdma not idle\n")=
;
> +                       r =3D -ETIMEDOUT;
> +                       goto err0;
> +               }
> +       }
> +
> +       f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32=
_CNTL));
> +       f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
> +       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_c=
ntl);
> +
> +       cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +       cntl =3D REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
> +       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
> +
> +       /* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT =3D 0 mmGRBM_SOFT_RESET=
.SOFT_RESET_SDMA0/1 =3D 1 */
> +       preempt =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_=
PREEMPT));
> +       preempt =3D REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT,=
 0);
> +       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), pr=
eempt);
> +
> +       soft_reset =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +       soft_reset |=3D 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << =
i;
> +
> +
> +       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
> +
> +       udelay(50);
> +
> +       soft_reset &=3D ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT <=
< i);
> +
> +       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
> +
> +       /* unfreeze and unhalt */
> +       freeze =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZ=
E));
> +       freeze =3D REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
> +       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze)=
;
> +
> +       r =3D sdma_v5_2_gfx_resume_instance(adev, i, true);
> +
> +err0:
> +       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +       return r;
> +}
> +
>  static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
>  {
>         int i, r =3D 0;
> @@ -1859,6 +1949,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_rin=
g_funcs =3D {
>         .emit_reg_write_reg_wait =3D sdma_v5_2_ring_emit_reg_write_reg_wa=
it,
>         .init_cond_exec =3D sdma_v5_2_ring_init_cond_exec,
>         .preempt_ib =3D sdma_v5_2_ring_preempt_ib,
> +       .reset =3D sdma_v5_2_reset_queue,
>  };
>
>  static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)
> --
> 2.25.1
>
