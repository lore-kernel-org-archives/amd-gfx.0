Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34722CF9C6F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 13:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C82F910E2A7;
	Tue, 24 Sep 2024 13:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="axKpVREz";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DC110E2A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 13:40:47 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-20530659f78so3715875ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727185247; x=1727790047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8XdD9bd68YGoQB2XNM1osBTkpr6OX7eHY8WS4FyZdY=;
 b=axKpVREz4QkZyisFtKhrQ/u3gGHFqtjnANMjiMLJEg/aDrTW3+xSmM/VnEc21wqPOL
 Gtl7+CRaF4uGMVMEbSWTxB23Ti7J+xwB+lVFi8N9F0LqLeht7/dPCrUmfAM7mLfpOwjb
 GOiYK/XcvhysO5AFmKv5/0b6S8laGlYjSqZIFf24HdanhPm9UpDdftBO74mZZJAVxH2Q
 cihkAvfo8+kIERO6GAmD9wNqciloLyNcfOpEUl5Xpzz5ro4CPRl+boFzEBpXq52jEUcu
 pr+bx6j0CzqMTFfEQWC7UdquZ++VOb+gkpfaTSFyEEoPXoPPYcqTxynYVBy+BCdOzD8e
 d9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727185247; x=1727790047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8XdD9bd68YGoQB2XNM1osBTkpr6OX7eHY8WS4FyZdY=;
 b=nLX8dLACnLDW/sVcTV3gRqkW1tFD9ZNWA+chZk7qYWZIQwsi35nYoTLf7m4dDhitvu
 430OPO15XY66KLRnLNbd+F7zuCjb2oUgZ+jXbmCJfepraYmYx7buxiYnCZSncOM/UaZA
 9wdhGRk9mQvxpHCO9/d/6n2GhPtKXFmAGk59E9tNLdepwqUIW+0Sa9NtTwzb3DD1rF+z
 I3qcMn3HafZz5aGAsxDhTHJL9H2UTRcUs+xWbXum34IRtkF6mh8M/DWqTaZypRc7hlxg
 PigVZh9vvMN9RNol+RUiJfwEHDvDrl/yqF6DNeaVc1ZGg/t9IIAPH2Rm2Lnbm/fxFAO8
 2FCw==
X-Gm-Message-State: AOJu0YxDXWJS75N1bDi7t/UDk5ZBbT1lAl2Z6JM3PBt0IxVlkiM/cxF0
 QYXh4NS6NL6O8FsGONRSmufLHO8aYZ005/OYAgEXBhXd7De1uvYxxvdvdggakqk0xctwF3C7qdb
 lBLO20WbcrGPszi51P1i3CebRnHA=
X-Google-Smtp-Source: AGHT+IFb3HfGy3j8KC9+2tIbUnUCaXWdeCCYWdpFF1eCD3rBePasu9X7clFMklVSnZyZuK+fwIlCb/fR62fgGbfYBpw=
X-Received: by 2002:a17:902:c407:b0:205:4415:c62f with SMTP id
 d9443c01a7336-208d839d3d8mr99196085ad.1.1727185246827; Tue, 24 Sep 2024
 06:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240920063112.370961-1-jiadong.zhu@amd.com>
 <20240920063112.370961-4-jiadong.zhu@amd.com>
In-Reply-To: <20240920063112.370961-4-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Sep 2024 09:40:35 -0400
Message-ID: <CADnq5_NKofY=gCNpxFq2fvTms_VRBKUcNO=mYtsA6Kas0TZYNA@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu/sdma5.2: implement ring reset callback for
 sdma5.2
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

On Fri, Sep 20, 2024 at 2:31=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Implement sdma queue reset callback via MMIO.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 86 +++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index 21457093eae9..3c93a8954a09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -597,7 +597,7 @@ static int sdma_v5_2_gfx_resume_instance(struct amdgp=
u_device *adev, int i, bool
>         WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_BASE), ring->gpu_addr >> 8);
>         WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_BASE_HI), ring->gpu_addr >> 40);
>
> -       if (restore)
> +       if (!restore)

Revered logic here.  Intended?  If so, it should probably be in the
previous patch.

>                 ring->wptr =3D 0;
>
>         /* before programing wptr to a less value, need set minor_ptr_upd=
ate first */
> @@ -1424,6 +1424,89 @@ static int sdma_v5_2_wait_for_idle(void *handle)
>         return -ETIMEDOUT;
>  }
>
> +static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int =
vmid)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       int i, j;
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
> +                       return -ETIMEDOUT;
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


SDMA 5.2 has SDMAx_QUEUE_RESET_REQ similar to SDMA 6.x.  Any reason to
use soft reset rather than queue reset?

Alex

> +
> +       return sdma_v5_2_gfx_resume_instance(adev, i, true);
> +}
> +
>  static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
>  {
>         int i, r =3D 0;
> @@ -1859,6 +1942,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_rin=
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
