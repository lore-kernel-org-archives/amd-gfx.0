Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC9ED3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 18:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC31310E17F;
	Mon,  8 Dec 2025 18:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="id3my1dX";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D441110E17F
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 18:03:49 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7b90db89b09so531607b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 10:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765217029; x=1765821829; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vOCAH4lOk+838/HzcNleg2yED3cGd87nnFwiWGkZi8=;
 b=id3my1dXcCGz9zb+bB6XPGrcjChX/yT8M1jO71XSywl6/HZctPUjkjTtJMfYbJPtfD
 7esO4Z9P00TEDOmFzTnLzRpceB/U9HIzmlViOnsnFWGqGse89zzy0ZtjPfeJMrrD8Qya
 G1ggUhL4LLh6dDQpN8vs2r77eX+lWLKtqOhl3n1FTmEEEOIaECL15veECJp4AbdGu/sA
 6ICwG1D2KwUgSNJU2UGiY4lJziTNpDMjFgmVEPpb8wq5EBzTnr5lBhPXTQQDhNt5TTNL
 C/553ptvIg6hDyaelI+ApEDtWyhot47b3HTx74V+EJAkVpyDK0MW12P52dPtX1ub2t0s
 zJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765217029; x=1765821829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vOCAH4lOk+838/HzcNleg2yED3cGd87nnFwiWGkZi8=;
 b=qwjnkMqGAwgKXS5SWPPlq+JIBvSR6TG8iMx4lk0/oHUfNTHzomk5weH8P7x9lqCsg/
 YFz0/8QmA9WjkCYoUI5wNoegHatDHGRWCr8v7Qd1+MaJIPOCBWRVGUzPXvRDUNPG/bhg
 KkuanqqRLFtZ/kkcvZWs9g+itUnzaqUAeD9CPlZEIJfA6+Gm2LpEq3Zwjxt+zuHvGzwf
 m2EUc8F6Cb2SGuHIOUstMyXR1JnMcAY3jyKh5le6b3iWC5y0KMHPVLsKvwfTAwr2qmDD
 wvWZD7Q1Dh16/49qBFlLUs9qF/l07wRsRoB8PqM5z8VKjmZEqUoOOQ4x014vBYEuf+yP
 Fvow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZvfPZ4KonAclXhMJ2L6SLKWn1iDcdFAcaJJObiWY0Iv8rAMJCw9MM9ugsCzzg8f5rBKIbtK8D@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWxEd+ncugbDzvQLSwa3ziFoS81rlrO6rVMki9OE+CH6vIZLjk
 os1fNI3SOAsDcwwOElorp5UQrXA35mOyqkaUstOiWBEwjHxdMS8k3e3yXVEqb9JDrdParSlbM33
 ESD1YOvkU0ogqrJmLMyCGp9mKmXROaYQ=
X-Gm-Gg: ASbGncu06RnvIVAXjItCpnYvLrN9gQxa/22SgFpvxDLwCp8OP8EjD1hfRvNI9CtKE0u
 qODmfEtUfGHagyDeKjSbHfLrI57e/huPJv+zTgdhk23iDskdPA5JdOrslU0PYotSahS2BowTCcF
 LnPNnfU6EPwv4S9sYCS63W2TP0aWqXLVzwAaIq/mrN8zgayTd+3gozRPqgd9Yso444/1VLkdTSu
 UqGjlymdSVEE0bSyr1n98rKPZczDFzfNaDxP2uB3pztYlB5L9Q69IJiieh6H18ETTGnTCM=
X-Google-Smtp-Source: AGHT+IEGbeiaSC984Pl2Pf0gDXkXkb7v0x2d1CNdHwaqyWLamKbg21jLDlqtEvB5/2m+nau36+elf7O8geMD2ya6zHo=
X-Received: by 2002:a05:7022:670e:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-11e032cc75amr3168906c88.4.1765217029050; Mon, 08 Dec 2025
 10:03:49 -0800 (PST)
MIME-Version: 1.0
References: <20251205121442.408502-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251205121442.408502-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Dec 2025 13:03:36 -0500
X-Gm-Features: AQt7F2rxswjaErxRnQAK5fIxjC6TLERXya0z0c1-M3GoDw0Yzsa_LQGTd6lfFvs
Message-ID: <CADnq5_O4YHbOQHvS6T63AsAYybsQwjCpnBpUUNORph=6tKU9oA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Reduce stack usage in MES v11 helpers
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Dec 5, 2025 at 7:24=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> mes_v11_0_set_hw_resources(), mes_v11_0_set_hw_resources_1() and
> mes_v11_0_query_sched_status() were using large MESAPI packet unions on
> the stack.
>
> When these helpers are inlined into mes_v11_0_hw_init(), the stack frame
> grows and can hit the
>
> stack frame size (1144) exceeds limit (1024) in 'mes_v11_0_hw_init'
> [-Wframe-larger-than]
>
> Change these helpers to allocate the packet with kmalloc(GFP_KERNEL)
> instead of placing it on the stack. The code now fills the packet, calls
> mes_v11_0_submit_pkt_and_poll_completion(), and then frees the packet
> with kfree() on all paths.
>
> This reduces stack usage in mes_v11_0_hw_init(), and keeps the behaviour
> the same.

Allocating memory for every MES submission adds a lot of overhead and
puts memory allocation in potentially atomic paths.   Also, why is
this just showing up now?  This code has existed for ~5 years and
never been a problem.

Alex

>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 129 ++++++++++++++-----------
>  1 file changed, 74 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 5159f4a9787c..5533098530de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -582,17 +582,25 @@ static int mes_v11_0_resume_gang(struct amdgpu_mes =
*mes,
>
>  static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
>  {
> -       union MESAPI__QUERY_MES_STATUS mes_status_pkt;
> +       union MESAPI__QUERY_MES_STATUS *pkt;
> +       int r;
>
> -       memset(&mes_status_pkt, 0, sizeof(mes_status_pkt));
> +       pkt =3D kmalloc(sizeof(*pkt), GFP_KERNEL);
> +       if (!pkt)
> +               return -ENOMEM;
>
> -       mes_status_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> -       mes_status_pkt.header.opcode =3D MES_SCH_API_QUERY_SCHEDULER_STAT=
US;
> -       mes_status_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +       memset(pkt, 0, sizeof(*pkt));
>
> -       return mes_v11_0_submit_pkt_and_poll_completion(mes,
> -                       &mes_status_pkt, sizeof(mes_status_pkt),
> +       pkt->header.type =3D MES_API_TYPE_SCHEDULER;
> +       pkt->header.opcode =3D MES_SCH_API_QUERY_SCHEDULER_STATUS;
> +       pkt->header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       r =3D mes_v11_0_submit_pkt_and_poll_completion(mes,
> +                                                    pkt, sizeof(*pkt),
>                         offsetof(union MESAPI__QUERY_MES_STATUS, api_stat=
us));
> +
> +       kfree(pkt);
> +       return r;
>  }
>
>  static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
> @@ -671,93 +679,104 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *me=
s,
>
>  static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>  {
> -       int i;
> +       int i, r;
>         struct amdgpu_device *adev =3D mes->adev;
> -       union MESAPI_SET_HW_RESOURCES mes_set_hw_res_pkt;
> +       union MESAPI_SET_HW_RESOURCES *pkt;
>
> -       memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
> +       pkt =3D kmalloc(sizeof(*pkt), GFP_KERNEL);
> +       if (!pkt)
> +               return -ENOMEM;
>
> -       mes_set_hw_res_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> -       mes_set_hw_res_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC;
> -       mes_set_hw_res_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +       memset(pkt, 0, sizeof(*pkt));
>
> -       mes_set_hw_res_pkt.vmid_mask_mmhub =3D mes->vmid_mask_mmhub;
> -       mes_set_hw_res_pkt.vmid_mask_gfxhub =3D mes->vmid_mask_gfxhub;
> -       mes_set_hw_res_pkt.gds_size =3D adev->gds.gds_size;
> -       mes_set_hw_res_pkt.paging_vmid =3D 0;
> -       mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr =3D mes->sch_ctx_gpu_addr=
[0];
> -       mes_set_hw_res_pkt.query_status_fence_gpu_mc_ptr =3D
> +       pkt->header.type =3D MES_API_TYPE_SCHEDULER;
> +       pkt->header.opcode =3D MES_SCH_API_SET_HW_RSRC;
> +       pkt->header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       pkt->vmid_mask_mmhub =3D mes->vmid_mask_mmhub;
> +       pkt->vmid_mask_gfxhub =3D mes->vmid_mask_gfxhub;
> +       pkt->gds_size =3D adev->gds.gds_size;
> +       pkt->paging_vmid =3D 0;
> +       pkt->g_sch_ctx_gpu_mc_ptr =3D mes->sch_ctx_gpu_addr[0];
> +       pkt->query_status_fence_gpu_mc_ptr =3D
>                 mes->query_status_fence_gpu_addr[0];
>
>         for (i =3D 0; i < MAX_COMPUTE_PIPES; i++)
> -               mes_set_hw_res_pkt.compute_hqd_mask[i] =3D
> -                       mes->compute_hqd_mask[i];
> +               pkt->compute_hqd_mask[i] =3D mes->compute_hqd_mask[i];
>
>         for (i =3D 0; i < MAX_GFX_PIPES; i++)
> -               mes_set_hw_res_pkt.gfx_hqd_mask[i] =3D
> -                       mes->gfx_hqd_mask[i];
> +               pkt->gfx_hqd_mask[i] =3D mes->gfx_hqd_mask[i];
>
>         for (i =3D 0; i < MAX_SDMA_PIPES; i++)
> -               mes_set_hw_res_pkt.sdma_hqd_mask[i] =3D mes->sdma_hqd_mas=
k[i];
> +               pkt->sdma_hqd_mask[i] =3D mes->sdma_hqd_mask[i];
>
>         for (i =3D 0; i < AMD_PRIORITY_NUM_LEVELS; i++)
> -               mes_set_hw_res_pkt.aggregated_doorbells[i] =3D
> -                       mes->aggregated_doorbells[i];
> +               pkt->aggregated_doorbells[i] =3D mes->aggregated_doorbell=
s[i];
>
>         for (i =3D 0; i < 5; i++) {
> -               mes_set_hw_res_pkt.gc_base[i] =3D adev->reg_offset[GC_HWI=
P][0][i];
> -               mes_set_hw_res_pkt.mmhub_base[i] =3D
> -                               adev->reg_offset[MMHUB_HWIP][0][i];
> -               mes_set_hw_res_pkt.osssys_base[i] =3D
> -               adev->reg_offset[OSSSYS_HWIP][0][i];
> +               pkt->gc_base[i] =3D adev->reg_offset[GC_HWIP][0][i];
> +               pkt->mmhub_base[i] =3D adev->reg_offset[MMHUB_HWIP][0][i]=
;
> +               pkt->osssys_base[i] =3D adev->reg_offset[OSSSYS_HWIP][0][=
i];
>         }
>
> -       mes_set_hw_res_pkt.disable_reset =3D 1;
> -       mes_set_hw_res_pkt.disable_mes_log =3D 1;
> -       mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
> -       mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
> -       mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
> -       mes_set_hw_res_pkt.oversubscription_timer =3D 50;
> +       pkt->disable_reset =3D 1;
> +       pkt->disable_mes_log =3D 1;
> +       pkt->use_different_vmid_compute =3D 1;
> +       pkt->enable_reg_active_poll =3D 1;
> +       pkt->enable_level_process_quantum_check =3D 1;
> +       pkt->oversubscription_timer =3D 50;
> +
>         if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D=
 0x7f)
> -               mes_set_hw_res_pkt.enable_lr_compute_wa =3D 1;
> +               pkt->enable_lr_compute_wa =3D 1;
>         else
>                 dev_info_once(mes->adev->dev,
>                               "MES FW version must be >=3D 0x7f to enable=
 LR compute workaround.\n");
>
>         if (amdgpu_mes_log_enable) {
> -               mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
> -               mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D
> -                                       mes->event_log_gpu_addr;
> +               pkt->enable_mes_event_int_logging =3D 1;
> +               pkt->event_intr_history_gpu_mc_ptr =3D mes->event_log_gpu=
_addr;
>         }
>
>         if (adev->enforce_isolation[0] =3D=3D AMDGPU_ENFORCE_ISOLATION_EN=
ABLE)
> -               mes_set_hw_res_pkt.limit_single_process =3D 1;
> +               pkt->limit_single_process =3D 1;
>
> -       return mes_v11_0_submit_pkt_and_poll_completion(mes,
> -                       &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
> +       r =3D mes_v11_0_submit_pkt_and_poll_completion(mes,
> +                                                    pkt, sizeof(*pkt),
>                         offsetof(union MESAPI_SET_HW_RESOURCES, api_statu=
s));
> +
> +       kfree(pkt);
> +       return r;
>  }
>
>  static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
>  {
> -       union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
> -       memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
> +       union MESAPI_SET_HW_RESOURCES_1 *pkt;
> +       int r;
>
> -       mes_set_hw_res_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> -       mes_set_hw_res_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
> -       mes_set_hw_res_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> -       mes_set_hw_res_pkt.enable_mes_info_ctx =3D 1;
> +       pkt =3D kmalloc(sizeof(*pkt), GFP_KERNEL);
> +       if (!pkt)
> +               return -ENOMEM;
> +
> +       memset(pkt, 0, sizeof(*pkt));
> +
> +       pkt->header.type =3D MES_API_TYPE_SCHEDULER;
> +       pkt->header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
> +       pkt->header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +       pkt->enable_mes_info_ctx =3D 1;
>
> -       mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =3D mes->resource=
_1_gpu_addr[0];
> +       pkt->cleaner_shader_fence_mc_addr =3D mes->resource_1_gpu_addr[0]=
;
>         if (amdgpu_sriov_is_mes_info_enable(mes->adev)) {
> -               mes_set_hw_res_pkt.mes_info_ctx_mc_addr =3D
> +               pkt->mes_info_ctx_mc_addr =3D
>                         mes->resource_1_gpu_addr[0] + AMDGPU_GPU_PAGE_SIZ=
E;
> -               mes_set_hw_res_pkt.mes_info_ctx_size =3D MES11_HW_RESOURC=
E_1_SIZE;
> +               pkt->mes_info_ctx_size =3D MES11_HW_RESOURCE_1_SIZE;
>         }
>
> -       return mes_v11_0_submit_pkt_and_poll_completion(mes,
> -                       &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
> +       r =3D mes_v11_0_submit_pkt_and_poll_completion(mes,
> +                                                    pkt, sizeof(*pkt),
>                         offsetof(union MESAPI_SET_HW_RESOURCES_1, api_sta=
tus));
> +
> +       kfree(pkt);
> +       return r;
>  }
>
>  static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
> --
> 2.34.1
>
