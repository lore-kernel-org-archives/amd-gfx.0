Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280E9C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 20:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06D310E11A;
	Tue, 11 Mar 2025 20:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qx0L3/mx";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE9910E68A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 20:06:23 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ff73032ac0so1440224a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741723583; x=1742328383; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNpI0fehGVLxFo1CNRTgkj25bnMelwe72aLSqM18dWA=;
 b=Qx0L3/mx4ZajwNKqM8qky99YrIrCPkS7rY24bsXaDGVJBk6HyQsYrZP4VQvp8ZkEsD
 LI0A/Ln77LgZ9/S9UB2dAZpzknPIpCo7qAu2Uq6a+fZ+ZAXbISdqdypk3iUUCHuopxYh
 PRQTo0vQZock1P2vFxnFfkNCATzGes3khNUiQtAbMkZKoyt98uK8IoXReHlcbOMfO9PC
 13Z42rWMh21CpPc+eEAavXGbJ82nse2cfX6zoLwhpROQyiRfBqhchTMFXSfkef6Oi8EK
 Ugoe0BHwN1RzwTJk6xpM5ooj9yK/6NsvPT7JTFfP1kYh+6XTWvFHwmnhi0AhyOKYeGtV
 QWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723583; x=1742328383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNpI0fehGVLxFo1CNRTgkj25bnMelwe72aLSqM18dWA=;
 b=rhbIIAVNGg0Y2y9NCccIQLVNUGUs6oL/BhxIg1vt34WKtp/JkVj4t+yR6zYmMig8cc
 ZLPWP2gKmBnsgyDSBGw7NlaSaL2RvwTzecfzK2mnFYAFgvMAjXqlG4wszze9Red6oorV
 SVlQA4tZh39RAPxgUX3jScWpSnBPrRoBHf9dvRDO9ibVrQOFHQQrsdadOjD0E0cFp2ht
 CBzltsEv8yZM0qZWc71qWAxMOPnQG0/gBXGb1sqSERVFbSEKjUQQVzIrV43nl/WvYfQt
 pA3ZeV6FsBC/NaPKxFyKh9oInwTxuDTX4+TqymblkS6WjsjYkcQTEoC66NG9Ck41W2rG
 fecQ==
X-Gm-Message-State: AOJu0YzraSEkPGm1F5oqoDK0yAcou3GsYjpF2ApYAQka0Slmqm82eyZh
 pVQfzFGuahzEFd3Fcmno9yNFqlC/AKw8NoKGVCecpEpMZDGVV3u8658tRV8L/4wVQmxCapVtA2o
 LUReLAqQKk4eLvbTPjh2u/8hI8c5uIQ==
X-Gm-Gg: ASbGnctPXoDzrn2b2SDAcdTdrONcsIKvZqK5/drMYkb9jpsCjQGRnZR0NXWX52NURw7
 H1G471NDN7GqJsbLdb2prt5loSOoqLAij//tDGHDz418G/yKW2YR16JN+bKYxUsmtDGI7ao+c8e
 CKvLJFLhx2qF574S5RNJ5nppqV4Q==
X-Google-Smtp-Source: AGHT+IHvw3//J+KgZLTUpDvjtWh/vd66AbbSd351nmU7zgSNpXA/lYERRNIvVCaXfjuVuVCmDo+m8xFeVAel7WlBH5w=
X-Received: by 2002:a17:90b:1809:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-300ff380aaemr2466730a91.0.1741723583322; Tue, 11 Mar 2025
 13:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250305204929.1214682-1-alexander.deucher@amd.com>
 <20250305204929.1214682-2-alexander.deucher@amd.com>
In-Reply-To: <20250305204929.1214682-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Mar 2025 16:06:11 -0400
X-Gm-Features: AQ5f1JrxYu5SndipfpcWTslNDdcqWXw952FxGmGnggoBF90Y_kj_HTJphMe_2dE
Message-ID: <CADnq5_PgS0K+nRv3Hk6UzfFwgFLkRRt_MuTzcBVk6+J10PE3CA@mail.gmail.com>
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

Ping on this series?

Thanks,

Alex

On Wed, Mar 5, 2025 at 4:07=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
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
> index 8fde7b239fdbb..d729eb0ddb268 100644
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
> @@ -2933,25 +2951,25 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_d=
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
> @@ -2973,7 +2991,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_dev=
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
> @@ -2982,7 +3000,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_dev=
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
> @@ -2994,7 +3012,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_dev=
ice *adev, void *m,
>         mqd->cp_rb_doorbell_control =3D tmp;
>
>         /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
> -       mqd->cp_gfx_hqd_rptr =3D RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
> +       mqd->cp_gfx_hqd_rptr =3D regCP_GFX_HQD_RPTR_DEFAULT;
>
>         /* active the queue */
>         mqd->cp_gfx_hqd_active =3D 1;
> @@ -3097,14 +3115,14 @@ static int gfx_v12_0_compute_mqd_init(struct amdg=
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
> @@ -3133,7 +3151,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu=
_device *adev, void *m,
>         mqd->cp_mqd_base_addr_hi =3D upper_32_bits(prop->mqd_gpu_addr);
>
>         /* set MQD vmid to 0 */
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_MQD_CONTROL);
> +       tmp =3D regCP_MQD_CONTROL_DEFAULT;
>         tmp =3D REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
>         mqd->cp_mqd_control =3D tmp;
>
> @@ -3143,7 +3161,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu=
_device *adev, void *m,
>         mqd->cp_hqd_pq_base_hi =3D upper_32_bits(hqd_gpu_addr);
>
>         /* set up the HQD, this is similar to CP_RB0_CNTL */
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_HQD_PQ_CONTROL);
> +       tmp =3D regCP_HQD_PQ_CONTROL_DEFAULT;
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
>                             (order_base_2(prop->queue_size / 4) - 1));
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
> @@ -3168,7 +3186,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu=
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
> @@ -3183,17 +3201,17 @@ static int gfx_v12_0_compute_mqd_init(struct amdg=
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
