Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923B6C10F16
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 15:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37DD610EABC;
	Fri,  3 May 2024 15:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JXbp+Si5";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A19A810EABC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 15:22:57 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-613a6bb2947so4187681a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714749777; x=1715354577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cG5TgSwy1BLG/h7n0zeCm26BR2GQ6sfZMOLNq7Jy7mU=;
 b=JXbp+Si5Te8bxWO2VDMDQLbdHMdwW7eS+80bc8YIAbCdfBb3BbO7lh/8CAgSbo6K3O
 UOWQqxb7Y8jYMLqGTtaCyh83THbRuCUh+mlZ+D2exbqOx4Y2tPTM+0LP7uYDSKmAkzxg
 h+6M/aRQK5HMGOMYAYq7B3g+suDNgIkdhoHPbQpSk88wujHCFMZr9cOKwb3fvAENcHSi
 rAUQ4zdN5vIa+zihRNwSflE8oKhUElkSbH2uKG2ywGZ4oVm0myt8Yt8imSgcQpsjKXiS
 tht/P+C7j3Y0pVtPBRckXZaYHE8ciJFaZKvWhKH75Zul8657iOksXOtxOMlaX4uDPArb
 gdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749777; x=1715354577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cG5TgSwy1BLG/h7n0zeCm26BR2GQ6sfZMOLNq7Jy7mU=;
 b=dVa5/VsX8Ec7g+ROsVS1MhDupSiOnNARRKv0ivj0IqrnaRSre0pUMD8v++UBl3GfrM
 exfY8maOawc1K72GIZYgiAz7qMrRMaDv1QGxNhpreD0NvtHRGFcY3cIabnC5GJSDd6dN
 mTrgIz2FczAMPGxdMb8JvSYSydXdOnA+mbjX6tff9fFFI4oULxzSWetwZDP0yZXb3hni
 n6zQPO5Cwu8GuRRd/Wh86TxbNEub1ciBfzt8yPkHXJ8uGFgolMAaiY1tqjvkk/5cGI5t
 KMGf0VT0xIXQ6rc8/CFXYESNM9lmDtTzHLXo1+UdXrL08JEyMOyRZUY0RiZ4EbJ5L1jB
 LXWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUvLyqTB4hGugBcWyMRBzqV+8x79IRG9P9qSgtmCkfyyP0p9JpcUoqjNkk5U+ayIUIn6HT7WrBJJoNyK5AC/zEKYARXcs+YNpDJSx04A==
X-Gm-Message-State: AOJu0Yy5/eYhFWP/8KHProJ8wt/qm0AkQnVCEjC5aXzkBdPdMKiTuIZ9
 +SaMN8T5QVv//eN0hN0l0g7fkGXvYAtBNx/HfCg0mv54+kSOHtqgyaEWaz5kxops5lTmWVYp1Jl
 AZ9MPvN/I44xzLCaKgoGHLQ1joSqZbeHO
X-Google-Smtp-Source: AGHT+IEOOtAcNYmxI3m/3WA+P5XuSjCKORMeeWGvA4XGW4qWUbCkcfzb/frXxkOhfzBh58wpJhhuRl0g+sdSanf8XQY=
X-Received: by 2002:a17:90a:bd86:b0:2b4:3659:83f6 with SMTP id
 z6-20020a17090abd8600b002b4365983f6mr2058750pjr.2.1714749776705; Fri, 03 May
 2024 08:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240503084447.2451529-1-sunil.khatri@amd.com>
 <20240503084447.2451529-4-sunil.khatri@amd.com>
In-Reply-To: <20240503084447.2451529-4-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 May 2024 11:22:45 -0400
Message-ID: <CADnq5_OYxPY6_qUwkbEqMQmDLaiDwopFKdeREn=WabnKjbBA8A@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] drm/amdgpu: add compute registers in ip dump for
 gfx10
To: Sunil Khatri <sunil.khatri@amd.com>
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

On Fri, May 3, 2024 at 4:45=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> add compute registers in set of registers to dump
> during ip dump for gfx10.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 42 +++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 953df202953a..00c7a842ea3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -378,7 +378,47 @@ static const struct amdgpu_hwip_reg_entry gc_reg_lis=
t_10_1[] =3D {
>         SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
>         SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
>         SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
> -       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
> +       /* compute registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_VMID),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PERSISTENT_STATE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PIPE_PRIORITY),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUEUE_PRIORITY),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUANTUM),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_REQUEST),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_EVENTS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_SIZE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_WG_STATE_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_SIZE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GDS_RESOURCE_STATE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_ERROR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR_MEM),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_WG_STATE_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_STATUS)

The registers in patches 3 and 4 are multi-instance, so we should
ideally print every instance of them rather than just one.  Use
nv_grbm_select() to select the pipes and queues.  Make sure to protect
access using the adev->srbm_mutex mutex.

E.g., for the compute registers (patch 3):
    mutex_lock(&adev->srbm_mutex);
        for (i =3D 0; i < adev->gfx.mec.num_mec; ++i) {
                for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
                       for (k =3D 0; k < adev->gfx.mec.num_queue_per_pipe; =
k++) {
                 drm_printf("mec %d, pipe %d, queue %d\n", i, j, k);
                nv_grbm_select(adev, i, j, k, 0);
                       for (reg =3D 0; reg < ARRAY_SIZE(compute_regs); reg+=
+)
                       drm_printf(...RREG(compute_regs[reg]));
                    }
                }
    }
    nv_grbm_select(adev, 0, 0, 0, 0);
    mutex_unlock(&adev->srbm_mutex);

For gfx registers (patch 4):

    mutex_lock(&adev->srbm_mutex);
        for (i =3D 0; i < adev->gfx.me.num_me; ++i) {
                for (j =3D 0; j < adev->gfx.me.num_pipe_per_me; j++) {
                    for (k =3D 0; k < adev->gfx.me.num_queue_per_pipe; k++)=
 {
                              drm_printf("me %d, pipe %d, queue %d\n", i, j=
, k);
                                nv_grbm_select(adev, i, j, k, 0);
                       for (reg =3D 0; reg < ARRAY_SIZE(gfx_regs); reg++)
                       drm_printf(...RREG(gfx_regs[reg]));
            }
                }
        }
    nv_grbm_select(adev, 0, 0, 0, 0);
    mutex_unlock(&adev->srbm_mutex);

Alex

>  };
>
>  static const struct soc15_reg_golden golden_settings_gc_10_1[] =3D {
> --
> 2.34.1
>
