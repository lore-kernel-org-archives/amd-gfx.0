Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D85C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 12:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A27D10E483;
	Tue, 29 Apr 2025 12:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A68dI0rp";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7DDE10E483
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 12:50:43 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3087a70557bso780147a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745931043; x=1746535843; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czI5TWJl8mdw4CieWgjxC0JXX5T0Qno2KRQVSoSNEoY=;
 b=A68dI0rpwM+1ngJ/An4zGs44VmAb7tIKZenu5gz2++oCuWS2UEZSoZNkCKguzvt9cQ
 1jda6AQb76tjXLaMDqdOr0HzUwNWgJvVhpgoPXRb1ta++bFhUydBfZDQIH2m6O5tukwX
 3DwWShyyHTsugF+JDvz9aPMy2Es4tgC1d33E2fB6SXMHHtFAjCrT5UoqV31bc9UcpgLM
 tETlgat1M51G81az2BWLSamt9+s9QF/SO5wipGKauVTKYv5VXtmlX6i8OfsiyesTMbAd
 Rl+NGtTf+Eylk49WwPhKT72ERJDdwxR4I4bRRQiXHn8FEX/xZtTgWYxwLeerw+QOHqzZ
 in7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745931043; x=1746535843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=czI5TWJl8mdw4CieWgjxC0JXX5T0Qno2KRQVSoSNEoY=;
 b=Qyxo1/upsSzoxEh1n7Ie6CnO3SzgE5MSc+SWmuBJXEax8FtFGbIVEzC8Uqp+lNZb6o
 0NWnVArG4I6Q92rRlOS5eapBApUQJ60d9lbd+iHqrYR1A5oV9azzBnYVMjqPxktY030F
 8fX+fraKXMjq376yDk2FM0QrBdlZUQsmSkFgfKMF11nJe0a2DMtPy1rrCfnabyocLYpJ
 m6T9Cu+wDaCE2qverhimVaY8OZiQvVcxYYF/nyXdk+DIEyeYHGVv2sg5/sgC5NNPcINS
 eWit5++WT6dX/XBbv4CAErCQ3zOCEHNVjLJ4j24G+eH9qGSE9zsS7INC61FuB6azc/sf
 5MAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzpHkYaoh507mYg7skC4VKuDHCbT5fn9yTFhuGKtmkGZitVsZzhRWg0xrAst20Rs3OJlIae+e5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuuwjPI+c9wj2JqH38LFtahadEa7be0oXVNr8atWjkQm+1tDMc
 coHws/dfKJJ2gO2iiqvWD3nClTOQPXgvQQ/mdW3KxEPti76uck0Oeshj/ADY7sSQ9RuQRDp+s9y
 jS2IE1Xr0Eqs90SPtqrMXshrS4vPkiQ==
X-Gm-Gg: ASbGncttMV3/zLsBrDYH7rF0vDmIozlXXBxhFAS4subodkZbe2X9jzfFuV/ecKQbskf
 zVYC34eoS016jR/BSLxntCrUGCqM9qJJO2/dX2S1qByF5oWPO7XksnbOVfwVgktpQwB85OBXCRZ
 0D3+dII/GbNJBL1iMJOLNn5g==
X-Google-Smtp-Source: AGHT+IEDz/Q+ZEVzKw3NUwe9fat3TqvpD4VcAymVKG1aEkCUjz6nj+XKjyF+6vmHuutDkmm/+5aWppO0l7rvOLjld+g=
X-Received: by 2002:a17:90b:4d08:b0:304:eacf:8bba with SMTP id
 98e67ed59e1d1-30a220c9efdmr1726933a91.4.1745931043182; Tue, 29 Apr 2025
 05:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250425183855.165199-1-alexander.deucher@amd.com>
 <DM4PR12MB5152A0CA5EFC61285E4E6DA9E3802@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152A0CA5EFC61285E4E6DA9E3802@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Apr 2025 08:50:30 -0400
X-Gm-Features: ATxdqUFzqGJ-zeRsPHRV2ScNV8jyK0nHW4t8II-h5v4JYtLTs0NphtHXJhkhejU
Message-ID: <CADnq5_MmpAKRrUpgQePG+SJLvQLU56fpDbhLxp0VBeY73xZH+g@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amdgpu/mes: remove more unused functions
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Mon, Apr 28, 2025 at 9:38=E2=80=AFPM Zhang, Jesse(Jie) <Jesse.Zhang@amd.=
com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alex,
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Saturday, April 26, 2025 2:39 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/9] drm/amdgpu/mes: remove more unused functions
>
> These were leftover from mes bring up and are unused.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 62 -------------------------  =
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 --------  drivers/gpu/drm/amd/=
amdgpu/mes_v11_0.c  | 26 -----------  drivers/gpu/drm/amd/amdgpu/mes_v12_0.=
c  | 27 -----------
>  4 files changed, 134 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 38ea64d87a0ac..b5a7e2ae72aff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -285,68 +285,6 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
>         return r;
>  }
>
> -int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id) =
-{
> -       unsigned long flags;
> -       struct amdgpu_mes_queue *queue;
> -       struct amdgpu_mes_gang *gang;
> -       struct mes_reset_queue_input queue_input;
> -       int r;
> -
> -       /*
> -        * Avoid taking any other locks under MES lock to avoid circular
> -        * lock dependencies.
> -        */
> -       amdgpu_mes_lock(&adev->mes);
> -
> -       /* remove the mes gang from idr list */
> -       spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
> -
> -       queue =3D idr_find(&adev->mes.queue_id_idr, queue_id);
> -       if (!queue) {
> -               spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
> -               amdgpu_mes_unlock(&adev->mes);
> -               DRM_ERROR("queue id %d doesn't exist\n", queue_id);
> -               return -EINVAL;
> -       }
> -       spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
> -
> -       DRM_DEBUG("try to reset queue, doorbell off =3D 0x%llx\n",
> -                 queue->doorbell_off);
> -
> -       gang =3D queue->gang;
> -       queue_input.doorbell_offset =3D queue->doorbell_off;
> -       queue_input.gang_context_addr =3D gang->gang_ctx_gpu_addr;
> -
> -       r =3D adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
> -       if (r)
> -               DRM_ERROR("failed to reset hardware queue, queue id =3D %=
d\n",
> -                         queue_id);
> -
> -       amdgpu_mes_unlock(&adev->mes);
> -
> -       return 0;
> -}
> -
> -int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue=
_type,
> -                                  int me_id, int pipe_id, int queue_id, =
int vmid)
> -{
> -       struct mes_reset_queue_input queue_input;
> -       int r;
> -
> -       queue_input.queue_type =3D queue_type;
> -       queue_input.use_mmio =3D true;
> -       queue_input.me_id =3D me_id;
> -       queue_input.pipe_id =3D pipe_id;
> -       queue_input.queue_id =3D queue_id;
> -       queue_input.vmid =3D vmid;
> -       r =3D adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
> -       if (r)
> -               DRM_ERROR("failed to reset hardware queue by mmio, queue =
id =3D %d\n",
> -                         queue_id);
> -       return r;
> -}
> -
>  int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
>                                 struct amdgpu_ring *ring)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index be3390d263012..af6e341f6411e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -235,18 +235,6 @@ struct mes_remove_queue_input {
>         uint64_t        gang_context_addr;
>  };
>
> -struct mes_reset_queue_input {
> -       uint32_t        doorbell_offset;
> -       uint64_t        gang_context_addr;
> -       bool            use_mmio;
> -       uint32_t        queue_type;
> -       uint32_t        me_id;
> -       uint32_t        pipe_id;
> -       uint32_t        queue_id;
> -       uint32_t        xcc_id;
> -       uint32_t        vmid;
> -};
> -
>  struct mes_map_legacy_queue_input {
>         uint32_t                           queue_type;
>         uint32_t                           doorbell_offset;
> @@ -377,9 +365,6 @@ struct amdgpu_mes_funcs {
>
>         int (*reset_legacy_queue)(struct amdgpu_mes *mes,
>                                   struct mes_reset_legacy_queue_input *in=
put);
> -
> -       int (*reset_hw_queue)(struct amdgpu_mes *mes,
> -                             struct mes_reset_queue_input *input);
>  };
>
>  #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev)) @@ =
-394,10 +379,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev);  int am=
dgpu_mes_suspend(struct amdgpu_device *adev);  int amdgpu_mes_resume(struct=
 amdgpu_device *adev);
>
> -int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id);=
 -int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_=
type,
> -                                  int me_id, int pipe_id, int queue_id, =
int vmid);
> -
>  int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
>                                 struct amdgpu_ring *ring);
>  int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev, diff --git=
 a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_=
v11_0.c
> index 0a5b7a296f08d..5ce62a3f01e7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -475,31 +475,6 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_=
mes *mes, uint32_t queue_typ
>         return r;
>  }
>
>
> mes_v11_0_reset_hw_queue and mes_v12_0_reset_hw_queue are used for user q=
ueue reset on your topic branch.
> Do we really want to remove these two functions?

They are no longer used.  See this patch series.

Alex

>
>
> Thanks
> Jesse
> -static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
> -                                   struct mes_reset_queue_input *input)
> -{
> -       if (input->use_mmio)
> -               return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
> -                                                 input->me_id, input->pi=
pe_id,
> -                                                 input->queue_id, input-=
>vmid);
> -
> -       union MESAPI__RESET mes_reset_queue_pkt;
> -
> -       memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
> -
> -       mes_reset_queue_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> -       mes_reset_queue_pkt.header.opcode =3D MES_SCH_API_RESET;
> -       mes_reset_queue_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> -
> -       mes_reset_queue_pkt.doorbell_offset =3D input->doorbell_offset;
> -       mes_reset_queue_pkt.gang_context_addr =3D input->gang_context_add=
r;
> -       /*mes_reset_queue_pkt.reset_queue_only =3D 1;*/
> -
> -       return mes_v11_0_submit_pkt_and_poll_completion(mes,
> -                       &mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt)=
,
> -                       offsetof(union MESAPI__REMOVE_QUEUE, api_status))=
;
> -}
> -
>  static int mes_v11_0_map_legacy_queue(struct amdgpu_mes *mes,
>                                       struct mes_map_legacy_queue_input *=
input)  { @@ -817,7 +792,6 @@ static const struct amdgpu_mes_funcs mes_v11_=
0_funcs =3D {
>         .resume_gang =3D mes_v11_0_resume_gang,
>         .misc_op =3D mes_v11_0_misc_op,
>         .reset_legacy_queue =3D mes_v11_0_reset_legacy_queue,
> -       .reset_hw_queue =3D mes_v11_0_reset_hw_queue,
>  };
>
>  static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev, d=
iff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/am=
dgpu/mes_v12_0.c
> index 1f7614dccb005..a3391810c897c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -494,32 +494,6 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_=
mes *mes, uint32_t queue_typ
>         return r;
>  }
>
> -static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
> -                                   struct mes_reset_queue_input *input)
> -{
> -       union MESAPI__RESET mes_reset_queue_pkt;
> -       int pipe;
> -
> -       memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
> -
> -       mes_reset_queue_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> -       mes_reset_queue_pkt.header.opcode =3D MES_SCH_API_RESET;
> -       mes_reset_queue_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> -
> -       mes_reset_queue_pkt.doorbell_offset =3D input->doorbell_offset;
> -       mes_reset_queue_pkt.gang_context_addr =3D input->gang_context_add=
r;
> -       /*mes_reset_queue_pkt.reset_queue_only =3D 1;*/
> -
> -       if (mes->adev->enable_uni_mes)
> -               pipe =3D AMDGPU_MES_KIQ_PIPE;
> -       else
> -               pipe =3D AMDGPU_MES_SCHED_PIPE;
> -
> -       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> -                       &mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt)=
,
> -                       offsetof(union MESAPI__REMOVE_QUEUE, api_status))=
;
> -}
> -
>  static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
>                                       struct mes_map_legacy_queue_input *=
input)  { @@ -914,7 +888,6 @@ static const struct amdgpu_mes_funcs mes_v12_=
0_funcs =3D {
>         .resume_gang =3D mes_v12_0_resume_gang,
>         .misc_op =3D mes_v12_0_misc_op,
>         .reset_legacy_queue =3D mes_v12_0_reset_legacy_queue,
> -       .reset_hw_queue =3D mes_v12_0_reset_hw_queue,
>  };
>
>  static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
> --
> 2.49.0
>
