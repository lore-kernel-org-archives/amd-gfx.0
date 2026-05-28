Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBF4CD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 22:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D6110F6BE;
	Thu, 28 May 2026 22:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XRL7BYJh";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9764A10F6BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 22:48:32 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-136400af2bbso63507c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 15:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780008512; cv=none;
 d=google.com; s=arc-20240605;
 b=W35195nttSyYJD4Y6iiVH1sEkqd/Qkp6p0VM7/R0mq/hpeZtzECHplpRzURaU1MMQx
 csq5uFTVwfU3lFVGLfALWBl0FD4zVGPUvMWuQ2+L1cbrtadpGQkQ5sMW2VzEe7Dtoms6
 YE5ud/nJzNDA3XGOMv+I8as3WEYn0xLArjzVX/J1m9L9xUx4Nh4GQbX3Zg2W3B68RYtM
 ifUuGFxQ+EDxcSBDZz0yhoO4FpGni6F00Caz6Qbc/dy1y+vz1z3/a7BkqbQQYKEODPN+
 GhqVtPP3AFp9gdOVyn8PJI98f0G2XJun7g2SSYgwPipYi9Nm+Z0cM2s0expf/z8y8PkY
 c84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FcSNYkWH3X2EL42Mtsjd93+Hdl9nugm/Z7ha/JuKKN0=;
 fh=R8UrUv3d+/i4o6mYGoWTaHgpCw4qAiC13nksgkDGJlo=;
 b=hL0LK97nRDQhmRm2/vuRypwQ6SZtjmtBFpj7zdOZoKlkIP5Ngx7xzCQTiNMYFu0D+F
 oYwdjXHEZ6TqOyEJGMO5iYCQCqOuzR6r+7cakqBqj+EOAGZQYleAOBAVIYH00xQsqdNJ
 VzL6q/8I7yodEwOhxOAddB17LT7ofMSaWJ86tO1RejJCOU0Xo0XjhwzsifmgN9WDUyYX
 qcujA/JxK5zZDKQxRyazL3B5DS440lmZe+vmgwvwckOlqM6r5wE/thNUYgmTYO+JubBI
 guKhkv1m5lmj80rIhqpnBwbapy/ywpO90bXMFwMgbvOauUsCQwvfVNTRrXRi/5Rw7aS0
 vBuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780008512; x=1780613312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcSNYkWH3X2EL42Mtsjd93+Hdl9nugm/Z7ha/JuKKN0=;
 b=XRL7BYJhstfupv812voCYtvBxg0L2f9ewOtCDM4X/Ekikq4BQfBRlWzyNJYhim7S30
 p6oiIArtiapiKC12g5gK9zyhfBoaPQ9hZSgaBJE9wXlN+s0w4IRAycc5slpZBwfwEW8g
 A4HxnFBS3CI9oheAensnvsYpSybQ1riG0x0vsb7z4hIEm6y1/SpuqIvmYE7P9AV6+uEQ
 qZqloADHrH5xuTExfC6WHIm+7jpkO8GLGX5qutCEQWNiCWS3DXeJTHbcCl9oqw8vR16H
 NeL2Q6s7llNXWtwHWTOl0wpyMBmzprCU3B38UdiHEUghat0AqYyQTq8D6SBbnGH97FOd
 SAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780008512; x=1780613312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FcSNYkWH3X2EL42Mtsjd93+Hdl9nugm/Z7ha/JuKKN0=;
 b=ZDSGXWFhTI+nY00V4ujShPTt+ROZ4Wf69gMxQJIzs+nfGE/yi0OOUCLibW4tA8QORi
 edwqgL6vuX1av5X6AjLeiLbJlNVKjc+Ma9qVVW4f8iM7rqkz1jKK0cBIuKvHtBxbo9FC
 7lB43TyDtJnjEdvJzsNOUO1Am/nIpDicfz4pCUg8z8Qna/17dkH3iDM44CGLr7iJOcIb
 CPI3a9847VTVCUTkUpnukwUPq7sC0PQ1YStR3A4E8Y3/McJKtAgvbBVUpj2T6nwTQFfC
 N74E0heXgiVlZ7TarALuM+UnlaZF/e12/YslU2Dx9MFwHX47B2AcSdpc5AvYpON7gGtS
 RoYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ++N4Q99xNxLZfZjxIWPODXgFIFd7seSwLmwsY+GNZs+zBs1Uf2VCfLpNc5NpPsQVfSfXA4jUcK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIqIIxJ2+o5SF39Qptv+B28lXXXYwE7H+LONS9qZXbAxEZLcst
 NCShM/+Bhd6zLcriQ3wGtot3NSSm5EpLYcEj3W+hq1qPP/A4c3E7zU7tekwEIdTC1JoMseqhbaU
 K5Nk/iUpWW+wzllZtxzY04dA+VgM1WXk=
X-Gm-Gg: Acq92OG92zZOD98PWcpW5sRcBRWF95Tr3bIzffHdIzzDtYBFuy6CaufK05uJ+s8Yel0
 eE5Ss/iXL9zMDZ2+XFsKjAy3A1ZCSdD9oEhD2ZDASatMIypvV4zdkXlhTb2WQgdTd1GWpAemDZ1
 lEYE7AAzrLO7xBV4jIZICObE6hWr/oXM5958toa8zGz1GoGOmpbltpjppWdgZ23jRptg7udzb5r
 mYOGvuNRnt2pRD4IkTESCcZsltfbPqM125hQWp1vm4/LAQPg8dKjTA9/jmqEuQ+01ZWqBkqR8jE
 HvP+axhBjWqt6YDqzrEMAi3wCibb7qRgY2vcJfaenpDDgvUZ8PlSWav2uQ5/j6dCjxphY/wHFXm
 eq8D+
X-Received: by 2002:a05:7022:6089:b0:134:cf44:5fa9 with SMTP id
 a92af1059eb24-137ae50f328mr88478c88.0.1780008511452; Thu, 28 May 2026
 15:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260527233504.1830940-1-Yunxiang.Li@amd.com>
 <20260527233504.1830940-3-Yunxiang.Li@amd.com>
In-Reply-To: <20260527233504.1830940-3-Yunxiang.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 18:48:19 -0400
X-Gm-Features: AVHnY4Ixt_GeR1zuYcwui8fCq5b5oIETTIkDOGo0rohDFBoXkUPUSwU-eTbhzrI
Message-ID: <CADnq5_N9tz-NR0o3WCod+=7j+oqZsMjX4RT6P__Cu-2DSLuy6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx: move fault and EOP IRQ get/put to
 hw_init/hw_fini
To: Yunxiang Li <Yunxiang.Li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Wed, May 27, 2026 at 7:44=E2=80=AFPM Yunxiang Li <Yunxiang.Li@amd.com> w=
rote:
>
> priv_reg / priv_inst / bad_op and (on v11+) userq EOP IRQs are
> acquired in late_init but released in hw_fini.  This split forced
> gfx_v9_0_hw_fini() to defensively guard each put with
> amdgpu_irq_enabled() because hw_fini runs on paths that may not
> reach late_init.
>
> amdgpu_ip_block_hw_fini() only runs after hw_init returns success,
> and suspend / resume cycle the refs through the same path, so
> hw_init / hw_fini pair without any extra tracking.  Move the gets
> there and drop the guards.
>
> While here, fix the pre-existing partial-failure leak in
> set_userq_eop_interrupts() (gfx11 / 12_0 / 12_1).  amdgpu_irq_get()
> increments the refcount before calling .set, so a failure partway
> through the loop leaves earlier successful gets stranded.  Track
> the loop position and roll back on the enable path.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  43 +++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 162 ++++++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 162 ++++++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 114 +++++++++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  39 +++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  35 ++---
>  6 files changed, 315 insertions(+), 240 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 58c69dcb527f7..0780c5e5de4ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7523,32 +7523,50 @@ static int gfx_v10_0_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         r =3D gfx_v10_0_cp_resume(adev);
>         if (r)
>                 return r;
>
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 3, =
0))
>                 gfx_v10_3_program_pbb_mode(adev);
>
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(10, 3, 0)=
 && !amdgpu_sriov_vf(adev))
>                 gfx_v10_3_set_power_brake_sequence(adev);
>
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> +       if (r)
> +               return r;
> +
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> +       if (r)
> +               goto err_priv_inst;
> +
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> +       if (r)
> +               goto err_bad_op;
> +
> +       return 0;
> +
> +err_bad_op:
> +       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +err_priv_inst:
> +       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>         return r;
>  }
>
>  static int gfx_v10_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         cancel_delayed_work_sync(&adev->gfx.idle_work);
>
> -       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> -       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>         amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>
>         /* WA added for Vangogh asic fixing the SMU suspend failure
>          * It needs to set power gating again during gfxoff control
>          * otherwise the gfxoff disallowing will be failed to set.
>          */
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 3, =
1))
>                 gfx_v10_0_set_powergating_state(ip_block, AMD_PG_STATE_UN=
GATE);
>
>         if (!adev->no_hw_access) {
>                 if (amdgpu_async_gfx_ring) {
> @@ -7830,40 +7848,20 @@ static int gfx_v10_0_early_init(struct amdgpu_ip_=
block *ip_block)
>         gfx_v10_0_set_gds_init(adev);
>         gfx_v10_0_set_rlc_funcs(adev);
>         gfx_v10_0_set_mqd_funcs(adev);
>
>         /* init rlcg reg access ctrl */
>         gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
>
>         return gfx_v10_0_init_microcode(adev);
>  }
>
> -static int gfx_v10_0_late_init(struct amdgpu_ip_block *ip_block)
> -{
> -       struct amdgpu_device *adev =3D ip_block->adev;
> -       int r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> -       if (r)
> -               return r;
> -
> -       return 0;

Wasn't there a reason (sequencing maybe?) these were in late_init()?
Are you sure it's ok to move them into hw_init()?

Alex

> -}
> -
>  static bool gfx_v10_0_is_rlc_enabled(struct amdgpu_device *adev)
>  {
>         uint32_t rlc_cntl;
>
>         /* if RLC is not enabled, do nothing */
>         rlc_cntl =3D RREG32_SOC15(GC, 0, mmRLC_CNTL);
>         return (REG_GET_FIELD(rlc_cntl, RLC_CNTL, RLC_ENABLE_F32)) ? true=
 : false;
>  }
>
>  static void gfx_v10_0_set_safe_mode(struct amdgpu_device *adev, int xcc_=
id)
> @@ -9798,21 +9796,20 @@ static void gfx_v10_0_ring_begin_use(struct amdgp=
u_ring *ring)
>  static void gfx_v10_0_ring_end_use(struct amdgpu_ring *ring)
>  {
>         amdgpu_gfx_profile_ring_end_use(ring);
>
>         amdgpu_gfx_enforce_isolation_ring_end_use(ring);
>  }
>
>  static const struct amd_ip_funcs gfx_v10_0_ip_funcs =3D {
>         .name =3D "gfx_v10_0",
>         .early_init =3D gfx_v10_0_early_init,
> -       .late_init =3D gfx_v10_0_late_init,
>         .sw_init =3D gfx_v10_0_sw_init,
>         .sw_fini =3D gfx_v10_0_sw_fini,
>         .hw_init =3D gfx_v10_0_hw_init,
>         .hw_fini =3D gfx_v10_0_hw_fini,
>         .suspend =3D gfx_v10_0_suspend,
>         .resume =3D gfx_v10_0_resume,
>         .is_idle =3D gfx_v10_0_is_idle,
>         .wait_for_idle =3D gfx_v10_0_wait_for_idle,
>         .soft_reset =3D gfx_v10_0_soft_reset,
>         .set_clockgating_state =3D gfx_v10_0_set_clockgating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index fabdbbd0abb7c..de0bf6e1f64d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4800,20 +4800,92 @@ static void gfx_v11_0_disable_gpa_mode(struct amd=
gpu_device *adev)
>
>         data =3D RREG32_SOC15(GC, 0, regCPC_PSP_DEBUG);
>         data |=3D CPC_PSP_DEBUG__GPA_OVERRIDE_MASK;
>         WREG32_SOC15(GC, 0, regCPC_PSP_DEBUG, data);
>
>         data =3D RREG32_SOC15(GC, 0, regCPG_PSP_DEBUG);
>         data |=3D CPG_PSP_DEBUG__GPA_OVERRIDE_MASK;
>         WREG32_SOC15(GC, 0, regCPG_PSP_DEBUG, data);
>  }
>
> +static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev=
,
> +                                             bool enable)
> +{
> +       unsigned int irq_type;
> +       int m, p, r;
> +
> +       if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
> +               for (m =3D 0; m < adev->gfx.me.num_me; m++) {
> +                       for (p =3D 0; p < adev->gfx.me.num_pipe_per_me; p=
++) {
> +                               irq_type =3D AMDGPU_CP_IRQ_GFX_ME0_PIPE0_=
EOP + p;
> +                               if (enable)
> +                                       r =3D amdgpu_irq_get(adev, &adev-=
>gfx.eop_irq, irq_type);
> +                               else
> +                                       r =3D amdgpu_irq_put(adev, &adev-=
>gfx.eop_irq, irq_type);
> +                               if (r) {
> +                                       if (!enable)
> +                                               return r;
> +                                       goto err_gfx;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
> +               for (m =3D 0; m < adev->gfx.mec.num_mec; ++m) {
> +                       for (p =3D 0; p < adev->gfx.mec.num_pipe_per_mec;=
 p++) {
> +                               irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_P=
IPE0_EOP
> +                                       + (m * adev->gfx.mec.num_pipe_per=
_mec)
> +                                       + p;
> +                               if (enable)
> +                                       r =3D amdgpu_irq_get(adev, &adev-=
>gfx.eop_irq, irq_type);
> +                               else
> +                                       r =3D amdgpu_irq_put(adev, &adev-=
>gfx.eop_irq, irq_type);
> +                               if (r) {
> +                                       if (!enable)
> +                                               return r;
> +                                       goto err_compute;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +
> +err_compute:
> +       for (p--; p >=3D 0; p--) {
> +               irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> +                       + (m * adev->gfx.mec.num_pipe_per_mec) + p;
> +               amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
> +       }
> +       for (m--; m >=3D 0; m--) {
> +               for (p =3D adev->gfx.mec.num_pipe_per_mec - 1; p >=3D 0; =
p--) {
> +                       irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> +                               + (m * adev->gfx.mec.num_pipe_per_mec) + =
p;
> +                       amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type=
);
> +               }
> +       }
> +       m =3D adev->gfx.me.num_me;
> +err_gfx:
> +       for (p--; p >=3D 0; p--) {
> +               irq_type =3D AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
> +               amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
> +       }
> +       for (m--; m >=3D 0; m--) {
> +               for (p =3D adev->gfx.me.num_pipe_per_me - 1; p >=3D 0; p-=
-) {
> +                       irq_type =3D AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
> +                       amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type=
);
> +               }
> +       }
> +       return r;
> +}
> +
>  static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>  {
>         int r;
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_siz=
e,
>                                        adev->gfx.cleaner_shader_ptr);
>
>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_RLC_BACKDOOR_A=
UTO) {
>                 if (adev->gfx.imu.funcs) {
> @@ -4897,76 +4969,57 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         gfx_v11_0_tcp_harvest(adev);
>
>         r =3D gfx_v11_0_cp_resume(adev);
>         if (r)
>                 return r;
>
>         /* get IMU version from HW if it's not set */
>         if (!adev->gfx.imu_fw_version)
>                 adev->gfx.imu_fw_version =3D RREG32_SOC15(GC, 0, regGFX_I=
MU_SCRATCH_0);
>
> -       return r;
> -}
> -
> -static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev=
,
> -                                             bool enable)
> -{
> -       unsigned int irq_type;
> -       int m, p, r;
> -
> -       if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
> -               for (m =3D 0; m < adev->gfx.me.num_me; m++) {
> -                       for (p =3D 0; p < adev->gfx.me.num_pipe_per_me; p=
++) {
> -                               irq_type =3D AMDGPU_CP_IRQ_GFX_ME0_PIPE0_=
EOP + p;
> -                               if (enable)
> -                                       r =3D amdgpu_irq_get(adev, &adev-=
>gfx.eop_irq,
> -                                                          irq_type);
> -                               else
> -                                       r =3D amdgpu_irq_put(adev, &adev-=
>gfx.eop_irq,
> -                                                          irq_type);
> -                               if (r)
> -                                       return r;
> -                       }
> -               }
> -       }
> -
> -       if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
> -               for (m =3D 0; m < adev->gfx.mec.num_mec; ++m) {
> -                       for (p =3D 0; p < adev->gfx.mec.num_pipe_per_mec;=
 p++) {
> -                               irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_P=
IPE0_EOP
> -                                       + (m * adev->gfx.mec.num_pipe_per=
_mec)
> -                                       + p;
> -                               if (enable)
> -                                       r =3D amdgpu_irq_get(adev, &adev-=
>gfx.eop_irq,
> -                                                          irq_type);
> -                               else
> -                                       r =3D amdgpu_irq_put(adev, &adev-=
>gfx.eop_irq,
> -                                                          irq_type);
> -                               if (r)
> -                                       return r;
> -                       }
> -               }
> -       }
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> +       if (r)
> +               return r;
> +
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> +       if (r)
> +               goto err_priv_inst;
> +
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> +       if (r)
> +               goto err_bad_op;
> +
> +       r =3D gfx_v11_0_set_userq_eop_interrupts(adev, true);
> +       if (r)
> +               goto err_userq_eop;
>
>         return 0;
> +
> +err_userq_eop:
> +       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +err_bad_op:
> +       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +err_priv_inst:
> +       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> +       return r;
>  }
>
>  static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         cancel_delayed_work_sync(&adev->gfx.idle_work);
>
> -       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> -       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> -       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
>         gfx_v11_0_set_userq_eop_interrupts(adev, false);
> +       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>
>         if (!adev->no_hw_access) {
>                 if (amdgpu_async_gfx_ring &&
>                     !adev->gfx.disable_kq) {
>                         if (amdgpu_gfx_disable_kgq(adev, 0))
>                                 DRM_ERROR("KGQ disable failed\n");
>                 }
>
>                 if (amdgpu_gfx_disable_kcq(adev, 0))
>                         DRM_ERROR("KCQ disable failed\n");
> @@ -5342,44 +5395,20 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_=
block *ip_block)
>         gfx_v11_0_set_gds_init(adev);
>         gfx_v11_0_set_rlc_funcs(adev);
>         gfx_v11_0_set_mqd_funcs(adev);
>         gfx_v11_0_set_imu_funcs(adev);
>
>         gfx_v11_0_init_rlcg_reg_access_ctrl(adev);
>
>         return gfx_v11_0_init_microcode(adev);
>  }
>
> -static int gfx_v11_0_late_init(struct amdgpu_ip_block *ip_block)
> -{
> -       struct amdgpu_device *adev =3D ip_block->adev;
> -       int r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D gfx_v11_0_set_userq_eop_interrupts(adev, true);
> -       if (r)
> -               return r;
> -
> -       return 0;
> -}
> -
>  static bool gfx_v11_0_is_rlc_enabled(struct amdgpu_device *adev)
>  {
>         uint32_t rlc_cntl;
>
>         /* if RLC is not enabled, do nothing */
>         rlc_cntl =3D RREG32_SOC15(GC, 0, regRLC_CNTL);
>         return (REG_GET_FIELD(rlc_cntl, RLC_CNTL, RLC_ENABLE_F32)) ? true=
 : false;
>  }
>
>  static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_=
id)
> @@ -7194,21 +7223,20 @@ static void gfx_v11_0_ring_begin_use(struct amdgp=
u_ring *ring)
>  static void gfx_v11_0_ring_end_use(struct amdgpu_ring *ring)
>  {
>         amdgpu_gfx_profile_ring_end_use(ring);
>
>         amdgpu_gfx_enforce_isolation_ring_end_use(ring);
>  }
>
>  static const struct amd_ip_funcs gfx_v11_0_ip_funcs =3D {
>         .name =3D "gfx_v11_0",
>         .early_init =3D gfx_v11_0_early_init,
> -       .late_init =3D gfx_v11_0_late_init,
>         .sw_init =3D gfx_v11_0_sw_init,
>         .sw_fini =3D gfx_v11_0_sw_fini,
>         .hw_init =3D gfx_v11_0_hw_init,
>         .hw_fini =3D gfx_v11_0_hw_fini,
>         .suspend =3D gfx_v11_0_suspend,
>         .resume =3D gfx_v11_0_resume,
>         .is_idle =3D gfx_v11_0_is_idle,
>         .wait_for_idle =3D gfx_v11_0_wait_for_idle,
>         .soft_reset =3D gfx_v11_0_soft_reset,
>         .check_soft_reset =3D gfx_v11_0_check_soft_reset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index f47928dcd8480..f66293fc675e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3648,20 +3648,92 @@ static void gfx_v12_0_init_golden_registers(struc=
t amdgpu_device *adev)
>                 if (adev->rev_id =3D=3D 0)
>                         soc15_program_register_sequence(adev,
>                                         golden_settings_gc_12_0_rev0,
>                                         (const u32)ARRAY_SIZE(golden_sett=
ings_gc_12_0_rev0));
>                 break;
>         default:
>                 break;
>         }
>  }
>
> +static int gfx_v12_0_set_userq_eop_interrupts(struct amdgpu_device *adev=
,
> +                                             bool enable)
> +{
> +       unsigned int irq_type;
> +       int m, p, r;
> +
> +       if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
> +               for (m =3D 0; m < adev->gfx.me.num_me; m++) {
> +                       for (p =3D 0; p < adev->gfx.me.num_pipe_per_me; p=
++) {
> +                               irq_type =3D AMDGPU_CP_IRQ_GFX_ME0_PIPE0_=
EOP + p;
> +                               if (enable)
> +                                       r =3D amdgpu_irq_get(adev, &adev-=
>gfx.eop_irq, irq_type);
> +                               else
> +                                       r =3D amdgpu_irq_put(adev, &adev-=
>gfx.eop_irq, irq_type);
> +                               if (r) {
> +                                       if (!enable)
> +                                               return r;
> +                                       goto err_gfx;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
> +               for (m =3D 0; m < adev->gfx.mec.num_mec; ++m) {
> +                       for (p =3D 0; p < adev->gfx.mec.num_pipe_per_mec;=
 p++) {
> +                               irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_P=
IPE0_EOP
> +                                       + (m * adev->gfx.mec.num_pipe_per=
_mec)
> +                                       + p;
> +                               if (enable)
> +                                       r =3D amdgpu_irq_get(adev, &adev-=
>gfx.eop_irq, irq_type);
> +                               else
> +                                       r =3D amdgpu_irq_put(adev, &adev-=
>gfx.eop_irq, irq_type);
> +                               if (r) {
> +                                       if (!enable)
> +                                               return r;
> +                                       goto err_compute;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +
> +err_compute:
> +       for (p--; p >=3D 0; p--) {
> +               irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> +                       + (m * adev->gfx.mec.num_pipe_per_mec) + p;
> +               amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
> +       }
> +       for (m--; m >=3D 0; m--) {
> +               for (p =3D adev->gfx.mec.num_pipe_per_mec - 1; p >=3D 0; =
p--) {
> +                       irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> +                               + (m * adev->gfx.mec.num_pipe_per_mec) + =
p;
> +                       amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type=
);
> +               }
> +       }
> +       m =3D adev->gfx.me.num_me;
> +err_gfx:
> +       for (p--; p >=3D 0; p--) {
> +               irq_type =3D AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
> +               amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
> +       }
> +       for (m--; m >=3D 0; m--) {
> +               for (p =3D adev->gfx.me.num_pipe_per_me - 1; p >=3D 0; p-=
-) {
> +                       irq_type =3D AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
> +                       amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type=
);
> +               }
> +       }
> +       return r;
> +}
> +
>  static int gfx_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
>  {
>         int r;
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_RLC_BACKDOOR_A=
UTO) {
>                 if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
>                         /* RLC autoload sequence 1: Program rlc ram */
>                         if (adev->gfx.imu.funcs->program_rlc_ram)
>                                 adev->gfx.imu.funcs->program_rlc_ram(adev=
);
> @@ -3735,77 +3807,58 @@ static int gfx_v12_0_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         /*
>          * init golden registers and rlc resume may override some registe=
rs,
>          * reconfig them here
>          */
>         gfx_v12_0_tcp_harvest(adev);
>
>         r =3D gfx_v12_0_cp_resume(adev);
>         if (r)
>                 return r;
>
> -       return r;
> -}
> -
> -static int gfx_v12_0_set_userq_eop_interrupts(struct amdgpu_device *adev=
,
> -                                             bool enable)
> -{
> -       unsigned int irq_type;
> -       int m, p, r;
> -
> -       if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
> -               for (m =3D 0; m < adev->gfx.me.num_me; m++) {
> -                       for (p =3D 0; p < adev->gfx.me.num_pipe_per_me; p=
++) {
> -                               irq_type =3D AMDGPU_CP_IRQ_GFX_ME0_PIPE0_=
EOP + p;
> -                               if (enable)
> -                                       r =3D amdgpu_irq_get(adev, &adev-=
>gfx.eop_irq,
> -                                                          irq_type);
> -                               else
> -                                       r =3D amdgpu_irq_put(adev, &adev-=
>gfx.eop_irq,
> -                                                          irq_type);
> -                               if (r)
> -                                       return r;
> -                       }
> -               }
> -       }
> -
> -       if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
> -               for (m =3D 0; m < adev->gfx.mec.num_mec; ++m) {
> -                       for (p =3D 0; p < adev->gfx.mec.num_pipe_per_mec;=
 p++) {
> -                               irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_P=
IPE0_EOP
> -                                       + (m * adev->gfx.mec.num_pipe_per=
_mec)
> -                                       + p;
> -                               if (enable)
> -                                       r =3D amdgpu_irq_get(adev, &adev-=
>gfx.eop_irq,
> -                                                          irq_type);
> -                               else
> -                                       r =3D amdgpu_irq_put(adev, &adev-=
>gfx.eop_irq,
> -                                                          irq_type);
> -                               if (r)
> -                                       return r;
> -                       }
> -               }
> -       }
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> +       if (r)
> +               return r;
> +
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> +       if (r)
> +               goto err_priv_inst;
> +
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> +       if (r)
> +               goto err_bad_op;
> +
> +       r =3D gfx_v12_0_set_userq_eop_interrupts(adev, true);
> +       if (r)
> +               goto err_userq_eop;
>
>         return 0;
> +
> +err_userq_eop:
> +       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +err_bad_op:
> +       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +err_priv_inst:
> +       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> +       return r;
>  }
>
>  static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         uint32_t tmp;
>
>         cancel_delayed_work_sync(&adev->gfx.idle_work);
>
> -       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> -       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> -       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
>         gfx_v12_0_set_userq_eop_interrupts(adev, false);
> +       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>
>         if (!adev->no_hw_access) {
>                 if (amdgpu_async_gfx_ring) {
>                         if (amdgpu_gfx_disable_kgq(adev, 0))
>                                 DRM_ERROR("KGQ disable failed\n");
>                 }
>
>                 if (amdgpu_gfx_disable_kcq(adev, 0))
>                         DRM_ERROR("KCQ disable failed\n");
>
> @@ -3920,44 +3973,20 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_=
block *ip_block)
>         gfx_v12_0_set_irq_funcs(adev);
>         gfx_v12_0_set_rlc_funcs(adev);
>         gfx_v12_0_set_mqd_funcs(adev);
>         gfx_v12_0_set_imu_funcs(adev);
>
>         gfx_v12_0_init_rlcg_reg_access_ctrl(adev);
>
>         return gfx_v12_0_init_microcode(adev);
>  }
>
> -static int gfx_v12_0_late_init(struct amdgpu_ip_block *ip_block)
> -{
> -       struct amdgpu_device *adev =3D ip_block->adev;
> -       int r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D gfx_v12_0_set_userq_eop_interrupts(adev, true);
> -       if (r)
> -               return r;
> -
> -       return 0;
> -}
> -
>  static bool gfx_v12_0_is_rlc_enabled(struct amdgpu_device *adev)
>  {
>         uint32_t rlc_cntl;
>
>         /* if RLC is not enabled, do nothing */
>         rlc_cntl =3D RREG32_SOC15(GC, 0, regRLC_CNTL);
>         return (REG_GET_FIELD(rlc_cntl, RLC_CNTL, RLC_ENABLE_F32)) ? true=
 : false;
>  }
>
>  static void gfx_v12_0_set_safe_mode(struct amdgpu_device *adev,
> @@ -5433,21 +5462,20 @@ static void gfx_v12_0_ring_begin_use(struct amdgp=
u_ring *ring)
>  static void gfx_v12_0_ring_end_use(struct amdgpu_ring *ring)
>  {
>         amdgpu_gfx_profile_ring_end_use(ring);
>
>         amdgpu_gfx_enforce_isolation_ring_end_use(ring);
>  }
>
>  static const struct amd_ip_funcs gfx_v12_0_ip_funcs =3D {
>         .name =3D "gfx_v12_0",
>         .early_init =3D gfx_v12_0_early_init,
> -       .late_init =3D gfx_v12_0_late_init,
>         .sw_init =3D gfx_v12_0_sw_init,
>         .sw_fini =3D gfx_v12_0_sw_fini,
>         .hw_init =3D gfx_v12_0_hw_init,
>         .hw_fini =3D gfx_v12_0_hw_fini,
>         .suspend =3D gfx_v12_0_suspend,
>         .resume =3D gfx_v12_0_resume,
>         .is_idle =3D gfx_v12_0_is_idle,
>         .wait_for_idle =3D gfx_v12_0_wait_for_idle,
>         .set_clockgating_state =3D gfx_v12_0_set_clockgating_state,
>         .set_powergating_state =3D gfx_v12_0_set_powergating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index 033f15e21ad33..61c3577f829fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -2728,20 +2728,64 @@ static void gfx_v12_1_init_golden_registers(struc=
t amdgpu_device *adev)
>         int i;
>
>         for (i =3D 0; i < NUM_XCC(adev->gfx.xcc_mask); i++) {
>                 gfx_v12_1_xcc_disable_burst(adev, i);
>                 gfx_v12_1_xcc_enable_atomics(adev, i);
>                 gfx_v12_1_xcc_disable_early_write_ack(adev, i);
>                 gfx_v12_1_xcc_disable_tcp_spill_cache(adev, i);
>         }
>  }
>
> +static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device *adev=
,
> +                                             bool enable)
> +{
> +       unsigned int irq_type;
> +       int m, p, r;
> +
> +       if (!adev->gfx.disable_kq)
> +               return 0;
> +
> +       for (m =3D 0; m < adev->gfx.mec.num_mec; ++m) {
> +               for (p =3D 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
> +                       irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> +                               + (m * adev->gfx.mec.num_pipe_per_mec)
> +                               + p;
> +                       if (enable)
> +                               r =3D amdgpu_irq_get(adev, &adev->gfx.eop=
_irq, irq_type);
> +                       else
> +                               r =3D amdgpu_irq_put(adev, &adev->gfx.eop=
_irq, irq_type);
> +                       if (r) {
> +                               if (!enable)
> +                                       return r;
> +                               goto err_unwind;
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +
> +err_unwind:
> +       for (p--; p >=3D 0; p--) {
> +               irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> +                       + (m * adev->gfx.mec.num_pipe_per_mec) + p;
> +               amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
> +       }
> +       for (m--; m >=3D 0; m--) {
> +               for (p =3D adev->gfx.mec.num_pipe_per_mec - 1; p >=3D 0; =
p--) {
> +                       irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> +                               + (m * adev->gfx.mec.num_pipe_per_mec) + =
p;
> +                       amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type=
);
> +               }
> +       }
> +       return r;
> +}
> +
>  static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
>  {
>         int r, i, num_xcc;
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_RLC_BACKDOOR_A=
UTO) {
>                 /* rlc autoload firmware */
>                 r =3D gfx_v12_1_rlc_backdoor_autoload_enable(adev);
>                 if (r)
>                         return r;
> @@ -2796,20 +2840,38 @@ static int gfx_v12_1_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         /*
>          * init golden registers and rlc resume may override some registe=
rs,
>          * reconfig them here
>          */
>         gfx_v12_1_tcp_harvest(adev);
>
>         r =3D gfx_v12_1_cp_resume(adev);
>         if (r)
>                 return r;
>
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> +       if (r)
> +               return r;
> +
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> +       if (r)
> +               goto err_priv_inst;
> +
> +       r =3D gfx_v12_1_set_userq_eop_interrupts(adev, true);
> +       if (r)
> +               goto err_userq_eop;
> +
> +       return 0;
> +
> +err_userq_eop:
> +       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +err_priv_inst:
> +       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>         return r;
>  }
>
>  static void gfx_v12_1_xcc_fini(struct amdgpu_device *adev,
>                               int xcc_id)
>  {
>         uint32_t tmp;
>
>         if (!adev->no_hw_access) {
>                 if (amdgpu_gfx_disable_kcq(adev, xcc_id))
> @@ -2821,55 +2883,28 @@ static void gfx_v12_1_xcc_fini(struct amdgpu_devi=
ce *adev,
>         if (amdgpu_sriov_vf(adev)) {
>                 /* Program KIQ position of RLC_CP_SCHEDULERS during destr=
oy */
>                 tmp =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_=
SCHEDULERS);
>                 tmp &=3D 0xffffff00;
>                 WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULE=
RS, tmp);
>         }
>         gfx_v12_1_xcc_cp_compute_enable(adev, false, xcc_id);
>         gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
>  }
>
> -static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device *adev=
,
> -                                             bool enable)
> -{
> -       unsigned int irq_type;
> -       int m, p, r;
> -
> -       if (adev->gfx.disable_kq) {
> -               for (m =3D 0; m < adev->gfx.mec.num_mec; ++m) {
> -                       for (p =3D 0; p < adev->gfx.mec.num_pipe_per_mec;=
 p++) {
> -                               irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_P=
IPE0_EOP
> -                                       + (m * adev->gfx.mec.num_pipe_per=
_mec)
> -                                       + p;
> -                               if (enable)
> -                                       r =3D amdgpu_irq_get(adev, &adev-=
>gfx.eop_irq,
> -                                                          irq_type);
> -                               else
> -                                       r =3D amdgpu_irq_put(adev, &adev-=
>gfx.eop_irq,
> -                                                          irq_type);
> -                               if (r)
> -                                       return r;
> -                       }
> -               }
> -       }
> -
> -       return 0;
> -}
> -
>  static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int i, num_xcc;
>
> -       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> -       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>         gfx_v12_1_set_userq_eop_interrupts(adev, false);
> +       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>
>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
>         for (i =3D 0; i < num_xcc; i++) {
>                 gfx_v12_1_xcc_fini(adev, i);
>         }
>
>         adev->gfxhub.funcs->gart_disable(adev);
>
>         adev->gfx.is_poweron =3D false;
>
> @@ -2956,40 +2991,20 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_=
block *ip_block)
>         gfx_v12_1_set_irq_funcs(adev);
>         gfx_v12_1_set_rlc_funcs(adev);
>         gfx_v12_1_set_mqd_funcs(adev);
>         gfx_v12_1_set_imu_funcs(adev);
>
>         gfx_v12_1_init_rlcg_reg_access_ctrl(adev);
>
>         return gfx_v12_1_init_microcode(adev);
>  }
>
> -static int gfx_v12_1_late_init(struct amdgpu_ip_block *ip_block)
> -{
> -       struct amdgpu_device *adev =3D ip_block->adev;
> -       int r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D gfx_v12_1_set_userq_eop_interrupts(adev, true);
> -       if (r)
> -               return r;
> -
> -       return 0;
> -}
> -
>  static bool gfx_v12_1_is_rlc_enabled(struct amdgpu_device *adev)
>  {
>         uint32_t rlc_cntl;
>
>         /* if RLC is not enabled, do nothing */
>         rlc_cntl =3D RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CNTL);
>         return (REG_GET_FIELD(rlc_cntl, RLC_CNTL, RLC_ENABLE_F32)) ? true=
 : false;
>  }
>
>  static void gfx_v12_1_xcc_set_safe_mode(struct amdgpu_device *adev,
> @@ -3869,21 +3884,20 @@ static void gfx_v12_1_emit_mem_sync(struct amdgpu=
_ring *ring)
>         amdgpu_ring_write(ring, 0xffffff);  /* CP_COHER_SIZE_HI */
>         amdgpu_ring_write(ring, 0); /* CP_COHER_BASE */
>         amdgpu_ring_write(ring, 0);  /* CP_COHER_BASE_HI */
>         amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
>         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>  }
>
>  static const struct amd_ip_funcs gfx_v12_1_ip_funcs =3D {
>         .name =3D "gfx_v12_1",
>         .early_init =3D gfx_v12_1_early_init,
> -       .late_init =3D gfx_v12_1_late_init,
>         .sw_init =3D gfx_v12_1_sw_init,
>         .sw_fini =3D gfx_v12_1_sw_fini,
>         .hw_init =3D gfx_v12_1_hw_init,
>         .hw_fini =3D gfx_v12_1_hw_fini,
>         .suspend =3D gfx_v12_1_suspend,
>         .resume =3D gfx_v12_1_resume,
>         .is_idle =3D gfx_v12_1_is_idle,
>         .wait_for_idle =3D gfx_v12_1_wait_for_idle,
>         .set_clockgating_state =3D gfx_v12_1_set_clockgating_state,
>         .set_powergating_state =3D gfx_v12_1_set_powergating_state,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index bec0720f70552..47721d0c37812 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4043,33 +4043,48 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                 return r;
>
>         r =3D gfx_v9_0_cp_resume(adev);
>         if (r)
>                 return r;
>
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2=
) &&
>             !amdgpu_sriov_vf(adev))
>                 gfx_v9_4_2_set_power_brake_sequence(adev);
>
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> +       if (r)
> +               return r;
> +
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> +       if (r)
> +               goto err_priv_inst;
> +
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> +       if (r)
> +               goto err_bad_op;
> +
> +       return 0;
> +
> +err_bad_op:
> +       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +err_priv_inst:
> +       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>         return r;
>  }
>
>  static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> -       if (amdgpu_irq_enabled(adev, &adev->gfx.priv_reg_irq, 0))
> -               amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> -       if (amdgpu_irq_enabled(adev, &adev->gfx.priv_inst_irq, 0))
> -               amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> -       if (amdgpu_irq_enabled(adev, &adev->gfx.bad_op_irq, 0))
> -               amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>
>         /* DF freeze and kcq disable will fail */
>         if (!amdgpu_ras_intr_triggered())
>                 /* disable KCQ to avoid CPC touch memory not valid anymor=
e */
>                 amdgpu_gfx_disable_kcq(adev, 0);
>
>         if (amdgpu_sriov_vf(adev)) {
>                 gfx_v9_0_cp_gfx_enable(adev, false);
>                 /* must disable polling for SRIOV when hw finished, other=
wise
>                  * CPC engine may still keep fetching WB address which is=
 already
> @@ -4856,32 +4871,20 @@ static int gfx_v9_0_ecc_late_init(struct amdgpu_i=
p_block *ip_block)
>                 adev->gfx.ras->enable_watchdog_timer(adev);
>
>         return 0;
>  }
>
>  static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int r;
>
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> -       if (r)
> -               return r;
> -
>         r =3D gfx_v9_0_ecc_late_init(ip_block);
>         if (r)
>                 return r;
>
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2=
))
>                 gfx_v9_4_2_debug_trap_config_init(adev,
>                         adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID)=
;
>         else
>                 gfx_v9_0_debug_trap_config_init(adev,
>                         adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID)=
;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 9f76e1af8a553..510266ba0c388 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2364,20 +2364,38 @@ static int gfx_v9_4_3_hw_init(struct amdgpu_ip_bl=
ock *ip_block)
>         gfx_v9_4_3_constants_init(adev);
>
>         r =3D adev->gfx.rlc.funcs->resume(adev);
>         if (r)
>                 return r;
>
>         r =3D gfx_v9_4_3_cp_resume(adev);
>         if (r)
>                 return r;
>
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> +       if (r)
> +               return r;
> +
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> +       if (r)
> +               goto err_priv_inst;
> +
> +       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> +       if (r)
> +               goto err_bad_op;
> +
> +       return 0;
> +
> +err_bad_op:
> +       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +err_priv_inst:
> +       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>         return r;
>  }
>
>  static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, =
bool enable)
>  {
>         struct amdgpu_ptl *ptl =3D &adev->psp.ptl;
>         uint32_t ptl_state =3D enable ? 1 : 0;
>         uint32_t fmt1, fmt2;
>         int r;
>
> @@ -2439,23 +2457,23 @@ static int gfx_v9_4_3_ptl_hw_init(struct amdgpu_d=
evice *adev)
>  }
>
>  static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int i, num_xcc;
>
>         if (adev->psp.ptl.hw_supported && !amdgpu_in_reset(adev))
>                 gfx_v9_4_3_perf_monitor_ptl_init(adev, false);
>
> -       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> -       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>         amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>
>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
>         for (i =3D 0; i < num_xcc; i++) {
>                 gfx_v9_4_3_xcc_fini(adev, i);
>         }
>
>         return 0;
>  }
>
>  static int gfx_v9_4_3_suspend(struct amdgpu_ip_block *ip_block)
> @@ -2604,33 +2622,20 @@ static int gfx_v9_4_3_early_init(struct amdgpu_ip=
_block *ip_block)
>
>         /* init rlcg reg access ctrl */
>         gfx_v9_4_3_init_rlcg_reg_access_ctrl(adev);
>
>         return gfx_v9_4_3_init_microcode(adev);
>  }
>
>  static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> -       if (r)
> -               return r;
>
>         if (adev->gfx.ras &&
>             adev->gfx.ras->enable_watchdog_timer)
>                 adev->gfx.ras->enable_watchdog_timer(adev);
>
>         gfx_v9_4_3_ptl_hw_init(adev);
>
>         return 0;
>  }
>
> --
> 2.51.2
>
