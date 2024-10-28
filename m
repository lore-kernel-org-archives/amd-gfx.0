Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B3ED3E2BC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4808510E54D;
	Mon, 28 Oct 2024 19:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="enwCQOqf";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5773410E54D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:45:51 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-71e5a00d676so173525b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730144751; x=1730749551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wouVfqb+pWBTZwpjTg7ygSr5G1H8AgriDbLw8jYCMbc=;
 b=enwCQOqfOkm+2SHsnGwOnIy/ipPZgT118gMDm6qoWuRvt4yFkcF5DsgPsfTNXNNQVf
 4olNABOtT+XO3qDLoHqz4TkTrU1hsw4kJqapm1bMrv5Ma9p9YU3o/V/2z5/QiZDiMiqm
 48MVsiCpVoNgYvO4TruOrfPjSOGyrDhoCmN3KstMDB+wkjAs2JHGCeK9TZjj0TMllV4A
 hFi5FP4eSFLr8cyZQDqXSYkNcwBWgcjrPzDJhfhnxc5qVAoyakFPjUS0CXeAo+VSc7Hh
 pEK79622WoTngnj4KG/kfbezQgi+qc9yJ8rvs5jFe+RlaXvKE/OjYJq8Y9JMxbCKNasR
 Oa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730144751; x=1730749551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wouVfqb+pWBTZwpjTg7ygSr5G1H8AgriDbLw8jYCMbc=;
 b=V1Onl2hzGBkqV3YqYLV02EMYJQvjrRdyRpa+rX9K6nbdpjnsRPxgC2r5EZHlaIocf0
 p85UJrXBsWVTkoZzJqIBfWHt1Uv5NPnXq7ryQAOusEk2t5waD3cYuQqFrOWeVV4FF61M
 Dae7a4D1v5BlHgzCJ8FsDF5OhRfQLT0mmyWfGCTGrDu2wK6JK10eQK164FiTh/PduBX3
 JMKzkDo+l/+CkKYhv2ouMb3zcZN4gflM0vQmqkJraxx6JAlZIKKjd0IdA64GXVvUMKnI
 mgK9SiTWX68T0zoZbgLmqVECB2YPFn/zZ0B0uKX+MQ6qzbGN0SQESoJarpjXREtcGr/L
 JMkQ==
X-Gm-Message-State: AOJu0YzOGctJclzKb27vUr0r9pujFLCNkroykFUhUVCJEnMfGrBHDMuP
 xV3SR+iYeioqHEg+L2Sah2Wr5ertGXgcHOcMijuOXdM33J4k87zPeLnriAsS0rzxaCTth1/3Tro
 d8sa97R12End1e4qB/rms+nMfMe7Q2mR/
X-Google-Smtp-Source: AGHT+IHvh2ohxhOzboEpMCtJQRIagoSdSwSLE3jngxg1hDACGIshfzZYfy2NO7LDDZk9Si1tHmIJudkEfP1A9UIaq90=
X-Received: by 2002:a05:6a00:889:b0:71e:770d:2c00 with SMTP id
 d2e1a72fcca58-72063020e78mr5729693b3a.4.1730144750670; Mon, 28 Oct 2024
 12:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-30-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-30-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:45:38 -0400
Message-ID: <CADnq5_PJKniZ9kvu-C0M-WcpmsgJXBH6e_aSeGKz3k_VQpEOOg@mail.gmail.com>
Subject: Re: [PATCH 29/29] drm/amdgpu: set_powergating for each vcn instance
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Fri, Oct 25, 2024 at 1:13=E2=80=AFAM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Perform set_powergating_state only for the instance of the current vcn
> IP block, instead of perform it for all vcn instances.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 313 ++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  20 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  20 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  19 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  20 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  20 +-
>  6 files changed, 199 insertions(+), 213 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 34d94b09f04c..da3d55cc3ac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -612,114 +612,111 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct am=
dgpu_device *adev, int inst_idx
>   *
>   * Disable clock gating for VCN block
>   */
> -static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
> +static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, in=
t inst)
>  {
>         uint32_t data;
> -       int i;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -               /* UVD disable CGC */
> -               data =3D RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> -               if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> -                       data |=3D 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIF=
T;
> -               else
> -                       data &=3D ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
> -               data |=3D 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> -               data |=3D 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> -               WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> -
> -               data =3D RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
> -               data &=3D ~(UVD_CGC_GATE__SYS_MASK
> -                       | UVD_CGC_GATE__UDEC_MASK
> -                       | UVD_CGC_GATE__MPEG2_MASK
> -                       | UVD_CGC_GATE__REGS_MASK
> -                       | UVD_CGC_GATE__RBC_MASK
> -                       | UVD_CGC_GATE__LMI_MC_MASK
> -                       | UVD_CGC_GATE__LMI_UMC_MASK
> -                       | UVD_CGC_GATE__IDCT_MASK
> -                       | UVD_CGC_GATE__MPRD_MASK
> -                       | UVD_CGC_GATE__MPC_MASK
> -                       | UVD_CGC_GATE__LBSI_MASK
> -                       | UVD_CGC_GATE__LRBBM_MASK
> -                       | UVD_CGC_GATE__UDEC_RE_MASK
> -                       | UVD_CGC_GATE__UDEC_CM_MASK
> -                       | UVD_CGC_GATE__UDEC_IT_MASK
> -                       | UVD_CGC_GATE__UDEC_DB_MASK
> -                       | UVD_CGC_GATE__UDEC_MP_MASK
> -                       | UVD_CGC_GATE__WCB_MASK
> -                       | UVD_CGC_GATE__VCPU_MASK
> -                       | UVD_CGC_GATE__MMSCH_MASK);
> -
> -               WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
> -
> -               SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF=
);
> -
> -               data =3D RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> -               data &=3D ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> -                       | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> -                       | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> -                       | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> -                       | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> -                       | UVD_CGC_CTRL__SYS_MODE_MASK
> -                       | UVD_CGC_CTRL__UDEC_MODE_MASK
> -                       | UVD_CGC_CTRL__MPEG2_MODE_MASK
> -                       | UVD_CGC_CTRL__REGS_MODE_MASK
> -                       | UVD_CGC_CTRL__RBC_MODE_MASK
> -                       | UVD_CGC_CTRL__LMI_MC_MODE_MASK
> -                       | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> -                       | UVD_CGC_CTRL__IDCT_MODE_MASK
> -                       | UVD_CGC_CTRL__MPRD_MODE_MASK
> -                       | UVD_CGC_CTRL__MPC_MODE_MASK
> -                       | UVD_CGC_CTRL__LBSI_MODE_MASK
> -                       | UVD_CGC_CTRL__LRBBM_MODE_MASK
> -                       | UVD_CGC_CTRL__WCB_MODE_MASK
> -                       | UVD_CGC_CTRL__VCPU_MODE_MASK
> -                       | UVD_CGC_CTRL__MMSCH_MODE_MASK);
> -               WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> -
> -               /* turn on */
> -               data =3D RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
> -               data |=3D (UVD_SUVD_CGC_GATE__SRE_MASK
> -                       | UVD_SUVD_CGC_GATE__SIT_MASK
> -                       | UVD_SUVD_CGC_GATE__SMP_MASK
> -                       | UVD_SUVD_CGC_GATE__SCM_MASK
> -                       | UVD_SUVD_CGC_GATE__SDB_MASK
> -                       | UVD_SUVD_CGC_GATE__SRE_H264_MASK
> -                       | UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
> -                       | UVD_SUVD_CGC_GATE__SIT_H264_MASK
> -                       | UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
> -                       | UVD_SUVD_CGC_GATE__SCM_H264_MASK
> -                       | UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
> -                       | UVD_SUVD_CGC_GATE__SDB_H264_MASK
> -                       | UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
> -                       | UVD_SUVD_CGC_GATE__SCLR_MASK
> -                       | UVD_SUVD_CGC_GATE__UVD_SC_MASK
> -                       | UVD_SUVD_CGC_GATE__ENT_MASK
> -                       | UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
> -                       | UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
> -                       | UVD_SUVD_CGC_GATE__SITE_MASK
> -                       | UVD_SUVD_CGC_GATE__SRE_VP9_MASK
> -                       | UVD_SUVD_CGC_GATE__SCM_VP9_MASK
> -                       | UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
> -                       | UVD_SUVD_CGC_GATE__SDB_VP9_MASK
> -                       | UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
> -               WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
> -
> -               data =3D RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
> -               data &=3D ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> -               WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
> -       }
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
> +       /* UVD disable CGC */
> +       data =3D RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
> +       if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> +               data |=3D 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +       else
> +               data &=3D ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
> +       data |=3D 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> +       data |=3D 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> +       WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
> +
> +       data =3D RREG32_SOC15(VCN, inst, mmUVD_CGC_GATE);
> +       data &=3D ~(UVD_CGC_GATE__SYS_MASK
> +               | UVD_CGC_GATE__UDEC_MASK
> +               | UVD_CGC_GATE__MPEG2_MASK
> +               | UVD_CGC_GATE__REGS_MASK
> +               | UVD_CGC_GATE__RBC_MASK
> +               | UVD_CGC_GATE__LMI_MC_MASK
> +               | UVD_CGC_GATE__LMI_UMC_MASK
> +               | UVD_CGC_GATE__IDCT_MASK
> +               | UVD_CGC_GATE__MPRD_MASK
> +               | UVD_CGC_GATE__MPC_MASK
> +               | UVD_CGC_GATE__LBSI_MASK
> +               | UVD_CGC_GATE__LRBBM_MASK
> +               | UVD_CGC_GATE__UDEC_RE_MASK
> +               | UVD_CGC_GATE__UDEC_CM_MASK
> +               | UVD_CGC_GATE__UDEC_IT_MASK
> +               | UVD_CGC_GATE__UDEC_DB_MASK
> +               | UVD_CGC_GATE__UDEC_MP_MASK
> +               | UVD_CGC_GATE__WCB_MASK
> +               | UVD_CGC_GATE__VCPU_MASK
> +               | UVD_CGC_GATE__MMSCH_MASK);
> +
> +       WREG32_SOC15(VCN, inst, mmUVD_CGC_GATE, data);
> +
> +       SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
> +
> +       data =3D RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
> +       data &=3D ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> +               | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> +               | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> +               | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> +               | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> +               | UVD_CGC_CTRL__SYS_MODE_MASK
> +               | UVD_CGC_CTRL__UDEC_MODE_MASK
> +               | UVD_CGC_CTRL__MPEG2_MODE_MASK
> +               | UVD_CGC_CTRL__REGS_MODE_MASK
> +               | UVD_CGC_CTRL__RBC_MODE_MASK
> +               | UVD_CGC_CTRL__LMI_MC_MODE_MASK
> +               | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> +               | UVD_CGC_CTRL__IDCT_MODE_MASK
> +               | UVD_CGC_CTRL__MPRD_MODE_MASK
> +               | UVD_CGC_CTRL__MPC_MODE_MASK
> +               | UVD_CGC_CTRL__LBSI_MODE_MASK
> +               | UVD_CGC_CTRL__LRBBM_MODE_MASK
> +               | UVD_CGC_CTRL__WCB_MODE_MASK
> +               | UVD_CGC_CTRL__VCPU_MODE_MASK
> +               | UVD_CGC_CTRL__MMSCH_MODE_MASK);
> +       WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
> +
> +       /* turn on */
> +       data =3D RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE);
> +       data |=3D (UVD_SUVD_CGC_GATE__SRE_MASK
> +               | UVD_SUVD_CGC_GATE__SIT_MASK
> +               | UVD_SUVD_CGC_GATE__SMP_MASK
> +               | UVD_SUVD_CGC_GATE__SCM_MASK
> +               | UVD_SUVD_CGC_GATE__SDB_MASK
> +               | UVD_SUVD_CGC_GATE__SRE_H264_MASK
> +               | UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
> +               | UVD_SUVD_CGC_GATE__SIT_H264_MASK
> +               | UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
> +               | UVD_SUVD_CGC_GATE__SCM_H264_MASK
> +               | UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
> +               | UVD_SUVD_CGC_GATE__SDB_H264_MASK
> +               | UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
> +               | UVD_SUVD_CGC_GATE__SCLR_MASK
> +               | UVD_SUVD_CGC_GATE__UVD_SC_MASK
> +               | UVD_SUVD_CGC_GATE__ENT_MASK
> +               | UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
> +               | UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
> +               | UVD_SUVD_CGC_GATE__SITE_MASK
> +               | UVD_SUVD_CGC_GATE__SRE_VP9_MASK
> +               | UVD_SUVD_CGC_GATE__SCM_VP9_MASK
> +               | UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
> +               | UVD_SUVD_CGC_GATE__SDB_VP9_MASK
> +               | UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
> +       WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE, data);
> +
> +       data =3D RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL);
> +       data &=3D ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> +       WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
>  }
>
>  static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
> @@ -777,59 +774,56 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct a=
mdgpu_device *adev,
>   *
>   * Enable clock gating for VCN block
>   */
> -static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
> +static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int=
 inst)
>  {
>         uint32_t data =3D 0;
> -       int i;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -               /* enable UVD CGC */
> -               data =3D RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> -               if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> -                       data |=3D 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIF=
T;
> -               else
> -                       data |=3D 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIF=
T;
> -               data |=3D 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> -               data |=3D 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> -               WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> -
> -               data =3D RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> -               data |=3D (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> -                       | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> -                       | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> -                       | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> -                       | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> -                       | UVD_CGC_CTRL__SYS_MODE_MASK
> -                       | UVD_CGC_CTRL__UDEC_MODE_MASK
> -                       | UVD_CGC_CTRL__MPEG2_MODE_MASK
> -                       | UVD_CGC_CTRL__REGS_MODE_MASK
> -                       | UVD_CGC_CTRL__RBC_MODE_MASK
> -                       | UVD_CGC_CTRL__LMI_MC_MODE_MASK
> -                       | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> -                       | UVD_CGC_CTRL__IDCT_MODE_MASK
> -                       | UVD_CGC_CTRL__MPRD_MODE_MASK
> -                       | UVD_CGC_CTRL__MPC_MODE_MASK
> -                       | UVD_CGC_CTRL__LBSI_MODE_MASK
> -                       | UVD_CGC_CTRL__LRBBM_MODE_MASK
> -                       | UVD_CGC_CTRL__WCB_MODE_MASK
> -                       | UVD_CGC_CTRL__VCPU_MODE_MASK);
> -               WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> -
> -               data =3D RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
> -               data |=3D (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> -                       | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> -               WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
> -       }
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
> +       /* enable UVD CGC */
> +       data =3D RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
> +       if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> +               data |=3D 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +       else
> +               data |=3D 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +       data |=3D 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> +       data |=3D 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> +       WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
> +
> +       data =3D RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
> +       data |=3D (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> +               | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> +               | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> +               | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> +               | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> +               | UVD_CGC_CTRL__SYS_MODE_MASK
> +               | UVD_CGC_CTRL__UDEC_MODE_MASK
> +               | UVD_CGC_CTRL__MPEG2_MODE_MASK
> +               | UVD_CGC_CTRL__REGS_MODE_MASK
> +               | UVD_CGC_CTRL__RBC_MODE_MASK
> +               | UVD_CGC_CTRL__LMI_MC_MODE_MASK
> +               | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> +               | UVD_CGC_CTRL__IDCT_MODE_MASK
> +               | UVD_CGC_CTRL__MPRD_MODE_MASK
> +               | UVD_CGC_CTRL__MPC_MODE_MASK
> +               | UVD_CGC_CTRL__LBSI_MODE_MASK
> +               | UVD_CGC_CTRL__LRBBM_MODE_MASK
> +               | UVD_CGC_CTRL__WCB_MODE_MASK
> +               | UVD_CGC_CTRL__VCPU_MODE_MASK);
> +       WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
> +
> +       data =3D RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL);
> +       data |=3D (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> +               | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> +       WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
>  }
>
>  static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx=
,
> @@ -1032,7 +1026,7 @@ static int vcn_v2_5_start(struct amdgpu_device *ade=
v, unsigned int inst)
>                 return 0;
>
>         /*SW clock gating */
> -       vcn_v2_5_disable_clock_gating(adev);
> +       vcn_v2_5_disable_clock_gating(adev, inst);
>
>         if (adev->vcn.harvest_config & (1 << inst))
>                 return 0;
> @@ -1471,7 +1465,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev=
, unsigned int inst)
>         /* clear status */
>         WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
>
> -       vcn_v2_5_enable_clock_gating(adev);
> +       vcn_v2_5_enable_clock_gating(adev, inst);
>
>         /* enable register anti-hang mechanism */
>         WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
> @@ -1794,6 +1788,7 @@ static int vcn_v2_5_set_clockgating_state(struct am=
dgpu_ip_block *ip_block,
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         bool enable =3D (state =3D=3D AMD_CG_STATE_GATE);
> +       int inst =3D ip_block->instance;
>
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
> @@ -1801,9 +1796,9 @@ static int vcn_v2_5_set_clockgating_state(struct am=
dgpu_ip_block *ip_block,
>         if (enable) {
>                 if (!vcn_v2_5_is_idle(adev))
>                         return -EBUSY;
> -               vcn_v2_5_enable_clock_gating(adev);
> +               vcn_v2_5_enable_clock_gating(adev, inst);
>         } else {
> -               vcn_v2_5_disable_clock_gating(adev);
> +               vcn_v2_5_disable_clock_gating(adev, inst);
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 451858f86272..b78c6da0a3cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -2122,19 +2122,17 @@ static int vcn_v3_0_set_clockgating_state(struct =
amdgpu_ip_block *ip_block,
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         bool enable =3D state =3D=3D AMD_CG_STATE_GATE;
> -       int i;
> +       int inst =3D ip_block->instance;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               if (enable) {
> -                       if (RREG32_SOC15(VCN, i, mmUVD_STATUS) !=3D UVD_S=
TATUS__IDLE)
> -                               return -EBUSY;
> -                       vcn_v3_0_enable_clock_gating(adev, i);
> -               } else {
> -                       vcn_v3_0_disable_clock_gating(adev, i);
> -               }
> +       if (enable) {
> +               if (RREG32_SOC15(VCN, inst, mmUVD_STATUS) !=3D UVD_STATUS=
__IDLE)
> +                       return -EBUSY;
> +               vcn_v3_0_enable_clock_gating(adev, inst);
> +       } else {
> +               vcn_v3_0_disable_clock_gating(adev, inst);
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index fa7cf10e8900..8aa30a4bddbf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1993,19 +1993,17 @@ static int vcn_v4_0_set_clockgating_state(struct =
amdgpu_ip_block *ip_block,
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         bool enable =3D state =3D=3D AMD_CG_STATE_GATE;
> -       int i;
> +       int inst =3D ip_block->instance;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               if (enable) {
> -                       if (RREG32_SOC15(VCN, i, regUVD_STATUS) !=3D UVD_=
STATUS__IDLE)
> -                               return -EBUSY;
> -                       vcn_v4_0_enable_clock_gating(adev, i);
> -               } else {
> -                       vcn_v4_0_disable_clock_gating(adev, i);
> -               }
> +       if (enable) {
> +               if (RREG32_SOC15(VCN, inst, regUVD_STATUS) !=3D UVD_STATU=
S__IDLE)
> +                       return -EBUSY;
> +               vcn_v4_0_enable_clock_gating(adev, inst);
> +       } else {
> +               vcn_v4_0_disable_clock_gating(adev, inst);
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index d05dcadb3e81..64b738f929b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1587,18 +1587,17 @@ static int vcn_v4_0_3_set_clockgating_state(struc=
t amdgpu_ip_block *ip_block,
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         bool enable =3D state =3D=3D AMD_CG_STATE_GATE;
> -       int i;
> +       int inst =3D ip_block->instance;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (enable) {
> -                       if (RREG32_SOC15(VCN, GET_INST(VCN, i),
> -                                        regUVD_STATUS) !=3D UVD_STATUS__=
IDLE)
> -                               return -EBUSY;
> -                       vcn_v4_0_3_enable_clock_gating(adev, i);
> -               } else {
> -                       vcn_v4_0_3_disable_clock_gating(adev, i);
> -               }
> +       if (enable) {
> +               if (RREG32_SOC15(VCN, GET_INST(VCN, inst),
> +                                regUVD_STATUS) !=3D UVD_STATUS__IDLE)
> +                       return -EBUSY;
> +               vcn_v4_0_3_enable_clock_gating(adev, inst);
> +       } else {
> +               vcn_v4_0_3_disable_clock_gating(adev, inst);
>         }
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index 307c8e204456..c901255a05ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1490,19 +1490,17 @@ static int vcn_v4_0_5_set_clockgating_state(struc=
t amdgpu_ip_block *ip_block,
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         bool enable =3D (state =3D=3D AMD_CG_STATE_GATE) ? true : false;
> -       int i;
> +       int inst =3D ip_block->instance;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               if (enable) {
> -                       if (RREG32_SOC15(VCN, i, regUVD_STATUS) !=3D UVD_=
STATUS__IDLE)
> -                               return -EBUSY;
> -                       vcn_v4_0_5_enable_clock_gating(adev, i);
> -               } else {
> -                       vcn_v4_0_5_disable_clock_gating(adev, i);
> -               }
> +       if (enable) {
> +               if (RREG32_SOC15(VCN, inst, regUVD_STATUS) !=3D UVD_STATU=
S__IDLE)
> +                       return -EBUSY;
> +               vcn_v4_0_5_enable_clock_gating(adev, inst);
> +       } else {
> +               vcn_v4_0_5_disable_clock_gating(adev, inst);
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 50022bbb276e..6973fee37c12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1217,19 +1217,17 @@ static int vcn_v5_0_0_set_clockgating_state(struc=
t amdgpu_ip_block *ip_block,
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         bool enable =3D (state =3D=3D AMD_CG_STATE_GATE) ? true : false;
> -       int i;
> +       int inst =3D ip_block->instance;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               if (enable) {
> -                       if (RREG32_SOC15(VCN, i, regUVD_STATUS) !=3D UVD_=
STATUS__IDLE)
> -                               return -EBUSY;
> -                       vcn_v5_0_0_enable_clock_gating(adev, i);
> -               } else {
> -                       vcn_v5_0_0_disable_clock_gating(adev, i);
> -               }
> +       if (enable) {
> +               if (RREG32_SOC15(VCN, inst, regUVD_STATUS) !=3D UVD_STATU=
S__IDLE)
> +                       return -EBUSY;
> +               vcn_v5_0_0_enable_clock_gating(adev, inst);
> +       } else {
> +               vcn_v5_0_0_disable_clock_gating(adev, inst);
>         }
>
>         return 0;
> --
> 2.34.1
>
