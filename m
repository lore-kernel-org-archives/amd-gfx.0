Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C036CCF9C6F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 13:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6348510E2B5;
	Tue, 24 Sep 2024 13:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SlP01Ett";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D30810E2B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 13:43:41 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2054fea6f26so3019365ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727185420; x=1727790220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6nONw4zr1hAeEu8Ht4WTO8JE5AVjag+tRsf7kdctuA=;
 b=SlP01Ett5v0ou0FuWlB4sEs7MO2Q0TsxZzMi1uahK2+8lefOdzybpE/i3pJT+0866d
 1ypKU6qW6gb3MptKQP8q83nrAeBbiyk44O3gMA+2BB/FFBOywzjIgpEVkVUl944EDQd3
 N1NPxPFac6TVMTXhzzcFUcQ7KFQ5TqLaC15D/dfm/dRS6es8VzorUDNHb4n7CYglOus1
 LV35vYZDhlcT/tXDutYxT0lPNfBmqJ93SFP+53y6KPUlGtRtlGXEMO+IvH8SS0xv0ntR
 zhE19L8EMYMPczv9dBJlK2yxlNP1G0SYH2mhydC3KVbmNIMyNoniPzIChDg1Z+R4BS56
 XINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727185420; x=1727790220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6nONw4zr1hAeEu8Ht4WTO8JE5AVjag+tRsf7kdctuA=;
 b=CMlKOrzyafRZdPf21W7VDODDppK+Sb4iUQZmFrvPVwuvy74h7mSY+P+pZirMAIeE5J
 Z38SE4WFKpYrOW92tDjV/y91ZzcwA/MeBZ0rOSvluQXkOwUNROmAQ8sWiw+hueJTZ46a
 x4fjl281Df50a5lvGlZFztU4BFzNAVroo2XIvngz8wpIyKpXB5i+FwHy2sgI2XtUB2Ve
 gcNXQ98u8CnlanVuu8bgeEVUUR5NPL7uGiqFB19jQwFU8rNYPwrlkVD8GkggfgKaU5pc
 qRFTqjH/phwwvV7yJZIB9Pf3nua2VULRqxnKd6p917cRH68ajaE18Aef78jbntVZBD4y
 Sk6Q==
X-Gm-Message-State: AOJu0YwQxOkOvyiRm91rcwzVKx8gllel0dgzdQhxT9kp9eWQMgFg/yXQ
 lDqDcoNgMq4dNfg2XCViVx5TIigh0BVezPv/RdHGoAbv77IMb+518axQR2hn6Gc/0ddT6ub+EXQ
 02KT1Hr+OT/5GUihsXwEKXBFb3UymFQ==
X-Google-Smtp-Source: AGHT+IGPJZQOz8PkSvCq2ilsaeNxEvtkp4wDhuGusfu1Qto0W7ndUo2fcXkV4md+IBbg0ErvSL1UYv3ZcTIbDgQmQNo=
X-Received: by 2002:a17:903:22ca:b0:206:b618:1d8f with SMTP id
 d9443c01a7336-208d85483bdmr96252485ad.11.1727185420486; Tue, 24 Sep 2024
 06:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240920063112.370961-1-jiadong.zhu@amd.com>
 <20240920063112.370961-2-jiadong.zhu@amd.com>
In-Reply-To: <20240920063112.370961-2-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Sep 2024 09:43:29 -0400
Message-ID: <CADnq5_Pb_4JvmCMQc7a27pr+35+vVQDhYQYBvTojNNQ_FBfHaA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu/sdma5: implement ring reset callback for
 sdma5
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

On Fri, Sep 20, 2024 at 2:43=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Implement sdma queue reset callback via MMIO.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 81 ++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index e813da1e48aa..7fd7ef22d571 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1555,6 +1555,86 @@ static int sdma_v5_0_soft_reset(void *handle)
>         return 0;
>  }
>
> +static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int =
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

Do we need to enter safe mode here?

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
> +                       return -ETIMEDOUT;
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
> +       return sdma_v5_0_gfx_resume_instance(adev, i, true);


And exit safe mode here?

Alex

> +}
> +
>  static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
>  {
>         int i, r =3D 0;
> @@ -1897,6 +1977,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_rin=
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
