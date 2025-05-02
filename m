Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AC6C3ABAC
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 21:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440A810E22E;
	Fri,  2 May 2025 21:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eViN3JYh";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC7010E22E
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 21:42:35 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7370f389d07so355107b3a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746222155; x=1746826955; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teETOkVzHCVAIRkqHtYDuoEoEvxv2/xFnGBQZialUU4=;
 b=eViN3JYh7rfhZwH/i8CitDRgRxp0a/gdjQaYIHEXLjw8/Sxy2hWekp7OvfC89RKeOw
 qLa6NVY0NaiSDqh0FjL26YEqalJz8gY/OENbut1IInv0rez6/xuCzttxr02Ing+mX8IK
 /Dqh5nnvvM2nV6BLVXxOuAnsGM17odyqt+5M4fyXMqX8QSkXSxF4yoUtQgoYUxKAcG2f
 ETkzTG1CEy4PC3ikXt5C77ZDc8hZiP+Q/tzArEebEjBohh6YNSCAp3GidQPot+oNdbmB
 XvP7G0v+KmuQo3m9kHzhf2oE/ggi2JEH1nIc66juK9w3coxMnDIG2rt376tj2Q/z4vb9
 AyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746222155; x=1746826955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teETOkVzHCVAIRkqHtYDuoEoEvxv2/xFnGBQZialUU4=;
 b=iBOl8piUNQ6M0gJKpnWWlZzk7tsk1PkkLZWAqmp9bCWaRXQSNW8WW1hej6l0ayOBqP
 jaiVbx2XrjFIixfsOEjHYk/Lev32KpYBZ5zgP5siawG3VrocYpoG0z9aQ+37j2nAz1W4
 olLRSyDbcTol6LRSd2lMOFUA0jynoFt+CH//ENsmspKEiVcnjXeg5J5MImODFeZ8vXeZ
 YKG+0mfdO917cv5/hIqPO9/SUvuRrqJeMTPlsiLkFiAVwuwso4moCbK2oSiR4RVbvpan
 OxQGJwEsaYBlbEhdwyRVmH2rCQyIWcuoHksrILBJMcrZihwDHj/Jr5Y9v5x/2knjyT2d
 gRzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxRhLkrjfoNh3IOXfJ0R3MEi5Gzs2h/UgplgcbWr9jr8PPRU2jfaaccqCrxlImekTZn7GX7sap@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjGfGBkLF6BnpeUFf969boBjJf8zgz4UtPcBAZ625m61er7Jii
 JN7Aq15V15BuWQ8BQBPjzdNnCCbQ/oQnStlkVLjdYF6cZOvoaBBxz49WKkf5T9m/NtFl3Jr/jyD
 xqIwzmK6Fl8uu8kpMTAPsCZUn160Wld63
X-Gm-Gg: ASbGncvXseLIDjWdReULX/spuUQrxEyhidPct0YEtY7BOTdiM1WO+uncWo1nMARu/1S
 a5Dri1la4fIR6uN+TlyOMogQ1o0OQAlP6jyqKZ+WKxbWpFMRGeAa98j/6NOXJtlUbX3JYW18d5V
 LUpE9tRdzPTLuBamClMFwvCQ==
X-Google-Smtp-Source: AGHT+IHAu4glf+eo/5F2eilVLXEabMKKQfO6XrIfu/T6Ofr/69/jF3A9LIur80wHBSaOVaMfCPygcT6NtK2C7yZKg6A=
X-Received: by 2002:a17:90b:3b47:b0:2fe:b45b:e7ec with SMTP id
 98e67ed59e1d1-30a4e6f8226mr2536199a91.8.1746222154954; Fri, 02 May 2025
 14:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250502161720.1704-1-christian.koenig@amd.com>
 <20250502161720.1704-5-christian.koenig@amd.com>
In-Reply-To: <20250502161720.1704-5-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 May 2025 17:42:23 -0400
X-Gm-Features: ATxdqUEcBjka-2lzZP9oHXkDiEkT8nYj1j-qniH1w0wHFo0er9nT7yBaimv9978
Message-ID: <CADnq5_N8x_1X=9FrM6qJC=4n46AJ=nMDQwDN=hiA=0yKd_31Fw@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: rework gfx10 queue reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Fri, May 2, 2025 at 12:17=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Apply the same changes to gfx10 as done to gfx9.
>
> The general idea to reset the whole kernel queue and then asking the kiq
> to map it again didn't worked at all. Background is that we don't use per
> application kernel queues for gfx10 on Linux for performance reasons.
>
> So instead use the gfx9 approach here as well and only reset all
> submissions from a specific VMID instead of the whole queue.
>
> Navi 10 seems to be stable, but Navi 2x still shows hangs during over
> night testing. This needs more investigation, but the result is clearly
> better than before.

For gfx 10.3, we enable the second gfx pipe as a high priority queue.
Disabling that might help.  Revert:

commit b7a1a0ef12b81957584fef7b61e2d5ec049c7209
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Date:   Mon Jun 6 13:59:13 2022 +0530

    drm/amd/amdgpu: add pipe1 hardware support

    Enable pipe1 support starting from SIENNA CICHLID asic

    Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2117
    Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.co=
m>
    Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 57 ++++++++------------------
>  1 file changed, 16 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 75ea071744eb..41cc0d6db15b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8746,7 +8746,17 @@ static void gfx_v10_0_ring_emit_pipeline_sync(stru=
ct amdgpu_ring *ring)
>         int usepfp =3D (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
>         uint32_t seq =3D ring->fence_drv.sync_seq;
>         uint64_t addr =3D ring->fence_drv.gpu_addr;
> +       struct amdgpu_device *adev =3D ring->adev;
>
> +       amdgpu_ring_emit_reg_wait(ring,
> +                                 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET=
),
> +                                 0, 0xffff);
> +       amdgpu_ring_emit_wreg(ring,
> +                             SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
> +                             0);
> +       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> +                              ring->fence_drv.sync_seq,
> +                              AMDGPU_FENCE_FLAG_EXEC);
>         gfx_v10_0_wait_reg_mem(ring, usepfp, 1, 0, lower_32_bits(addr),
>                                upper_32_bits(addr), seq, 0xffffffff, 4);
>  }
> @@ -9046,21 +9056,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait=
(struct amdgpu_ring *ring,
>                                                            ref, mask);
>  }
>
> -static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
> -                                        unsigned int vmid)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t value =3D 0;
> -
> -       value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
> -       amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -       WREG32_SOC15(GC, 0, mmSQ_CMD, value);
> -       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> -}
> -
>  static void
>  gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
>                                       uint32_t me, uint32_t pipe,
> @@ -9529,38 +9524,21 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring=
 *ring, unsigned int vmid)
>         struct amdgpu_ring *kiq_ring =3D &kiq->ring;
>         unsigned long flags;
>         u32 tmp;
> -       u64 addr;
>         int r;
>
>         if (amdgpu_sriov_vf(adev))
>                 return -EINVAL;
>
> -       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> -               return -EINVAL;
> -
>         spin_lock_irqsave(&kiq->ring_lock, flags);
>
> -       if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_=
size)) {
> +       if (amdgpu_ring_alloc(kiq_ring, 5)) {
>                 spin_unlock_irqrestore(&kiq->ring_lock, flags);
>                 return -ENOMEM;
>         }
>
> -       addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj) +
> -               offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
>         tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid)=
;
> -       if (ring->pipe =3D=3D 0)
> -               tmp =3D REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1=
 << ring->queue);
> -       else
> -               tmp =3D REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE1_QUEUES, 1=
 << ring->queue);
> -
>         gfx_v10_0_ring_emit_wreg(kiq_ring,
>                                  SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET)=
, tmp);
> -       gfx_v10_0_wait_reg_mem(kiq_ring, 0, 1, 0,
> -                              lower_32_bits(addr), upper_32_bits(addr),
> -                              0, 1, 0x20);
> -       gfx_v10_0_ring_emit_reg_wait(kiq_ring,
> -                                    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RE=
SET), 0, 0xffffffff);
> -       kiq->pmf->kiq_map_queues(kiq_ring, ring);
>         amdgpu_ring_commit(kiq_ring);
>
>         spin_unlock_irqrestore(&kiq->ring_lock, flags);
> @@ -9569,13 +9547,12 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring=
 *ring, unsigned int vmid)
>         if (r)
>                 return r;
>
> -       r =3D gfx_v10_0_kgq_init_queue(ring, true);
> -       if (r) {
> -               DRM_ERROR("fail to init kgq\n");
> -               return r;
> -       }
> +       if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 7))
> +               return -ENOMEM;
> +       gfx_v10_0_ring_emit_pipeline_sync(ring);
> +       amdgpu_ring_commit(ring);
>
> -       return amdgpu_ring_test_ring(ring);
> +       return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
>  }
>
>  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> @@ -9882,7 +9859,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_gfx =3D {
>         .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v10_0_ring_emit_reg_write_reg_wa=
it,
> -       .soft_recovery =3D gfx_v10_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
>         .reset =3D gfx_v10_0_reset_kgq,
>         .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
> @@ -9923,7 +9899,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_compute =3D {
>         .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v10_0_ring_emit_reg_write_reg_wa=
it,
> -       .soft_recovery =3D gfx_v10_0_ring_soft_recovery,

Same comment as the rest of the series for compute.

Alex

>         .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
>         .reset =3D gfx_v10_0_reset_kcq,
>         .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
> --
> 2.34.1
>
