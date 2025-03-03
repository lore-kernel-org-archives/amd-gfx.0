Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FC4C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 16:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B9E10E236;
	Mon,  3 Mar 2025 16:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lbaqXljm";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85FE810E236
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 16:20:48 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2f74e6c6cbcso1365731a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Mar 2025 08:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741018848; x=1741623648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zJrA2FRdq4aomskteALnLGmcPvIFR3+0mK0egKmiWs=;
 b=lbaqXljmULJOB+oGt8N2FJ+ro58t6f1pdDRAk041HVoLflcqRDeflchz5Z38g6a1r8
 NpPf/J9Tp/QhmKMuYAvuVJc4MPhnxgMf1Z8PWI1Zw7uWLA13I8oI2aJZ2ZWIFbspu18L
 6djNWvjYB2VSG0l/VNrv9wi2YmoK+3SL+hjrXikSJ+GSWj9PgDfz2XrEJzTM5u+CpiJX
 DR0XNKllXQbKsYzW/gm3LO7ISdCMH+U8e9MMSlkrmgKOiof8Irg5p0A70zNdlX9Cdsqv
 HrDDbTr1XCHT2oxeYZyCXHRkiwYh8JMx3JknJaJ7ci73pYwnpP5mmR/kImO79SgiRc8t
 ewdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741018848; x=1741623648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zJrA2FRdq4aomskteALnLGmcPvIFR3+0mK0egKmiWs=;
 b=oEzOTA9raQS5jxX6trBJXsg0O121y4pVqenfvkoxpdRlCXdawazVtDVT7Bsf4xAldg
 LzxFuEE23O7CWO60GyBRbgV1XadSKR5nL0ngV5CS0oIfsUwPXVQHkJPzfj5TJVLD8fAF
 PO3BLXoIWrMOtcu47S8kvXRoVmJ9P83jUaTJd9HMl2kFj+uMLX7Z6Xkjk+2CMLgMWrmX
 axEzZzk90TMlqIGI+/TTroovw+5RenftXfKkEk/5D9Ya/s5FWd7tco7BJqjB4gsCQ4nE
 RouT+up0Jgz+O47+ta/KbG5X3ld2vfS1HmfqhnM0rbO5kvbFPOupXxyNEN20xmS5LjvN
 cbcQ==
X-Gm-Message-State: AOJu0YwqrPyX197S8PJRRYJ6OOnCoB6Ylc55iXsIP2n2BVdORMjt/DAd
 C7GW1JP2mXqAZGM1DEpIM8QVs7UnURVK2zZG6b3KwnCkJQi7frZroWCGivnTmjS4t+4pWWUcWSo
 MfiANQhtY1ZmHcfy2NBiP39K4LnQ=
X-Gm-Gg: ASbGncuc9vYbFz85URXMbGR7/hMHCUseMQjxVAi/DFSeI/q3J9D22jA/ykCXNM1j4oi
 g7offGicGhRNXujlTxmF+xwK5/9jfH8Q2bmykzE8dAdwv4U3cc48ZVwkWiEnC1VSvb/BMkTuqfF
 EoYi8pss/pQWuZKVH3lwQUtUc9rw==
X-Google-Smtp-Source: AGHT+IEJlqGZ69JOY2leD1g4yR//TQJiu7anmG+VvGbK41ew2KWwUjyaLd0IG6RYaO0SU3VjHUaQTik/L5uZZYk++P0=
X-Received: by 2002:a17:90b:1805:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2febabdc1cbmr8366622a91.3.1741018847891; Mon, 03 Mar 2025
 08:20:47 -0800 (PST)
MIME-Version: 1.0
References: <20250227040033.234065-1-alexander.deucher@amd.com>
 <20250227040033.234065-2-alexander.deucher@amd.com>
In-Reply-To: <20250227040033.234065-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Mar 2025 11:20:35 -0500
X-Gm-Features: AQ5f1JpSR9_FeyUSVb0cpGZrIsi8z9KxmYgz6p_ws5qzGhChD8Oq1-LeAx7QaeQ
Message-ID: <CADnq5_O2vDkbu+ARNQqsoNNXHaS-RMVNTsSySoTi8EKK6CVRnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx12: don't read registers in mqd init
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

ping on this series.

Alex

On Wed, Feb 26, 2025 at 11:09=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Just use the default values.  There's not need to
> get the value from hardware and it could cause problems
> if we do that at runtime and gfxoff is active.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 48 ++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 667c8013b7738..804e9552a608a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -52,6 +52,24 @@
>
>  #define RLCG_UCODE_LOADING_START_ADDRESS       0x00002000L
>
> +#define regCP_GFX_MQD_CONTROL_DEFAULT                                   =
          0x00000100
> +#define regCP_GFX_HQD_VMID_DEFAULT                                      =
          0x00000000
> +#define regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT                            =
          0x00000000
> +#define regCP_GFX_HQD_QUANTUM_DEFAULT                                   =
          0x00000a01
> +#define regCP_GFX_HQD_CNTL_DEFAULT                                      =
          0x00f00000
> +#define regCP_RB_DOORBELL_CONTROL_DEFAULT                               =
          0x00000000
> +#define regCP_GFX_HQD_RPTR_DEFAULT                                      =
          0x00000000
> +
> +#define regCP_HQD_EOP_CONTROL_DEFAULT                                   =
          0x00000006
> +#define regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT                           =
          0x00000000
> +#define regCP_MQD_CONTROL_DEFAULT                                       =
          0x00000100
> +#define regCP_HQD_PQ_CONTROL_DEFAULT                                    =
          0x00308509
> +#define regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT                           =
          0x00000000
> +#define regCP_HQD_PQ_RPTR_DEFAULT                                       =
          0x00000000
> +#define regCP_HQD_PERSISTENT_STATE_DEFAULT                              =
          0x0be05501
> +#define regCP_HQD_IB_CONTROL_DEFAULT                                    =
          0x00300000
> +
> +
>  MODULE_FIRMWARE("amdgpu/gc_12_0_0_pfp.bin");
>  MODULE_FIRMWARE("amdgpu/gc_12_0_0_me.bin");
>  MODULE_FIRMWARE("amdgpu/gc_12_0_0_mec.bin");
> @@ -2926,25 +2944,25 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_d=
evice *adev, void *m,
>         mqd->cp_mqd_base_addr_hi =3D upper_32_bits(prop->mqd_gpu_addr);
>
>         /* set up mqd control */
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_GFX_MQD_CONTROL);
> +       tmp =3D regCP_GFX_MQD_CONTROL_DEFAULT;
>         tmp =3D REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
>         tmp =3D REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
>         tmp =3D REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
>         mqd->cp_gfx_mqd_control =3D tmp;
>
>         /* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmi=
d */
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
> +       tmp =3D regCP_GFX_HQD_VMID_DEFAULT;
>         tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
>         mqd->cp_gfx_hqd_vmid =3D 0;
>
>         /* set up default queue priority level
>          * 0x0 =3D low priority, 0x1 =3D high priority */
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
> +       tmp =3D regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT;
>         tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LE=
VEL, 0);
>         mqd->cp_gfx_hqd_queue_priority =3D tmp;
>
>         /* set up time quantum */
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
> +       tmp =3D regCP_GFX_HQD_QUANTUM_DEFAULT;
>         tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
>         mqd->cp_gfx_hqd_quantum =3D tmp;
>
> @@ -2966,7 +2984,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_dev=
ice *adev, void *m,
>
>         /* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
>         rb_bufsz =3D order_base_2(prop->queue_size / 4) - 1;
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
> +       tmp =3D regCP_GFX_HQD_CNTL_DEFAULT;
>         tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
>         tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - =
2);
>  #ifdef __BIG_ENDIAN
> @@ -2975,7 +2993,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_dev=
ice *adev, void *m,
>         mqd->cp_gfx_hqd_cntl =3D tmp;
>
>         /* set up cp_doorbell_control */
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
> +       tmp =3D regCP_RB_DOORBELL_CONTROL_DEFAULT;
>         if (prop->use_doorbell) {
>                 tmp =3D REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
>                                     DOORBELL_OFFSET, prop->doorbell_index=
);
> @@ -2987,7 +3005,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_dev=
ice *adev, void *m,
>         mqd->cp_rb_doorbell_control =3D tmp;
>
>         /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
> -       mqd->cp_gfx_hqd_rptr =3D RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
> +       mqd->cp_gfx_hqd_rptr =3D regCP_GFX_HQD_RPTR_DEFAULT;
>
>         /* active the queue */
>         mqd->cp_gfx_hqd_active =3D 1;
> @@ -3090,14 +3108,14 @@ static int gfx_v12_0_compute_mqd_init(struct amdg=
pu_device *adev, void *m,
>         mqd->cp_hqd_eop_base_addr_hi =3D upper_32_bits(eop_base_addr);
>
>         /* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_HQD_EOP_CONTROL);
> +       tmp =3D regCP_HQD_EOP_CONTROL_DEFAULT;
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
>                         (order_base_2(GFX12_MEC_HPD_SIZE / 4) - 1));
>
>         mqd->cp_hqd_eop_control =3D tmp;
>
>         /* enable doorbell? */
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
> +       tmp =3D regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
>
>         if (prop->use_doorbell) {
>                 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> @@ -3126,7 +3144,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu=
_device *adev, void *m,
>         mqd->cp_mqd_base_addr_hi =3D upper_32_bits(prop->mqd_gpu_addr);
>
>         /* set MQD vmid to 0 */
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_MQD_CONTROL);
> +       tmp =3D regCP_MQD_CONTROL_DEFAULT;
>         tmp =3D REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
>         mqd->cp_mqd_control =3D tmp;
>
> @@ -3136,7 +3154,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu=
_device *adev, void *m,
>         mqd->cp_hqd_pq_base_hi =3D upper_32_bits(hqd_gpu_addr);
>
>         /* set up the HQD, this is similar to CP_RB0_CNTL */
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_HQD_PQ_CONTROL);
> +       tmp =3D regCP_HQD_PQ_CONTROL_DEFAULT;
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
>                             (order_base_2(prop->queue_size / 4) - 1));
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
> @@ -3161,7 +3179,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu=
_device *adev, void *m,
>         tmp =3D 0;
>         /* enable the doorbell if requested */
>         if (prop->use_doorbell) {
> -               tmp =3D RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL=
);
> +               tmp =3D regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
>                 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
>                                 DOORBELL_OFFSET, prop->doorbell_index);
>
> @@ -3176,17 +3194,17 @@ static int gfx_v12_0_compute_mqd_init(struct amdg=
pu_device *adev, void *m,
>         mqd->cp_hqd_pq_doorbell_control =3D tmp;
>
>         /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
> -       mqd->cp_hqd_pq_rptr =3D RREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR);
> +       mqd->cp_hqd_pq_rptr =3D regCP_HQD_PQ_RPTR_DEFAULT;
>
>         /* set the vmid for the queue */
>         mqd->cp_hqd_vmid =3D 0;
>
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_HQD_PERSISTENT_STATE);
> +       tmp =3D regCP_HQD_PERSISTENT_STATE_DEFAULT;
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE,=
 0x55);
>         mqd->cp_hqd_persistent_state =3D tmp;
>
>         /* set MIN_IB_AVAIL_SIZE */
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_HQD_IB_CONTROL);
> +       tmp =3D regCP_HQD_IB_CONTROL_DEFAULT;
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, =
3);
>         mqd->cp_hqd_ib_control =3D tmp;
>
> --
> 2.48.1
>
