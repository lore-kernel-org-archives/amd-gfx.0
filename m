Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB53CA0EDB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 19:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5470E10E3E3;
	Tue, 12 Aug 2025 19:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qx30dBC1";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E8A010E3E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 19:36:39 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2400b3008e8so8941355ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755027399; x=1755632199; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVbnCcHq4ZHLgCqT6z3dE12/S9qItC8KRk5cVH1D4is=;
 b=Qx30dBC1ibpofADju18CP+rL3W5apbuFpYIAssybcLQAbevBD+5UgyAOSErt1RDDL6
 tTJTng+0PAMqWC31l93GQ6Mpy9hZqQ0jVSDgOJUI8kq4qLFUJcmj7ov8+JJu4n5lFFws
 u84K13+pVNNn76FqcnFLb5ZJtXSiUph6udMiBtEo8W/xVTVpOfOFIeQiB/5zmlqk7hIw
 dWsso1dPwp6QcbqI/UtifEiI855aNabTXBuC8kKAbbqEdu/Zqhbr/VIe77VGspYOsYqv
 Hkn7/mSl6Jvz6REPIdOmFGUoMN2z6n7pDuYFdILi9Ef+QUzSCabb8TfBm+LOqtELAVBD
 lz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755027399; x=1755632199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVbnCcHq4ZHLgCqT6z3dE12/S9qItC8KRk5cVH1D4is=;
 b=ux2imrRi5Qz+ppwtdKiNXFxv8615ln/K/22X0MrnGnrloc/+2NUTRuTV5UcCqOY/j1
 1FUareoKmL9Ah06KY3HyABweMPMSJpiJzmNBoD0pcOJ/kaGzqJWYwNsDDYiKLrQzUaee
 FyvKgJte4UvXgZNCto5RUh4k6UEDRXO5z7RDv5LiAExfitLeHpKLjMaNdV1JWk1f6w3g
 eX5EyvF/ZEoH9maSE3ynnx/bvA5KPA48eE95OmnRJu1P/eCp964BjdKJF7eV00vyquo1
 IuZ/RH2sbzTAbdY6Ut/BKKIOd3ZkcW3m42888Qsr+g1xise5dpVkq/jiDOF4cPHDx/c8
 vjgQ==
X-Gm-Message-State: AOJu0Yz3I5stqTqx++SSNe94/zd2Zqhe3AG+x3lZbKRU9Thhycp0kWDl
 5W0qYNZCsZ1vhdIGXflWDtKG0QOhpNoAC2PEl11pjW/cz7z67GelsX5JHG+tr5P+EhEfEWqwvN7
 ZYZOQx3c13NhHPMWe7El3rlrMCQc6zdl0vA==
X-Gm-Gg: ASbGnct3UsC0aMSq6hl+j77AH9619LgyO1SaF1skIPBMbth8E7SJhzcK53zJIzviCN1
 mkVr+ZhheztQ3l8b6qybrGCSiEvAL/FCV5mqRQVAdeBDiBU8gVLRcrlvp94syU+AZYqxPqtRClS
 lIl0iy3KivQUoY5mUZQU7/u878WWLa73yHwPae5MULrszPjgnZfqIFj0ubB/SRisLmkcCTbO290
 aEDU3R8QQ3PF0qARA==
X-Google-Smtp-Source: AGHT+IF2ESBTFFAcQR3mla5mjYIQ6notl9jaLAw5n5iNkkWI+BehorH1b1MlSGtNYQaAPKPdH4C53IEbe9kHf0oCElE=
X-Received: by 2002:a17:903:1112:b0:240:33c7:fbf9 with SMTP id
 d9443c01a7336-2430d297958mr2358755ad.11.1755027398770; Tue, 12 Aug 2025
 12:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
 <20250811095937.1978747-2-Jesse.Zhang@amd.com>
In-Reply-To: <20250811095937.1978747-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Aug 2025 15:36:27 -0400
X-Gm-Features: Ac12FXx_ZH0qzswwxS4I0UGRG_2ch7vCJLs3-mFRNa_XeHjMSAAV_Z9vc5aG9h0
Message-ID: <CADnq5_Mvb-5F13rB4=iFjc6n6qAxzQSn=W-OsgLTeCUcYk=tbw@mail.gmail.com>
Subject: Re: [v8 02/11] drm/amdgpu: adjust MES API used for suspend and resume
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Mon, Aug 11, 2025 at 6:18=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Use the suspend and resume API rather than remove queue
> and add queue API.  The former just preempts the queue
> while the latter remove it from the scheduler completely.
> There is no need to do that, we only need preemption
> in this case.
>
> V2: replace queue_active with queue state
> v3: set the suspend_fence_addr
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index d6f50b13e2ba..46b24035e14c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -347,9 +347,60 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mg=
r,
>         amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }
>
> +static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
> +                            struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct mes_suspend_gang_input queue_input;
> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> +       int r;
> +
> +       if (queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> +               return 0;
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)
> +               return 0;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
> +       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PR=
OC_CTX_SZ;
> +       queue_input.suspend_fence_addr =3D queue->fence_drv->gpu_addr;

This will overwrite the user fence value with 0.  You need a separate
allocation for this.  You might also need to wait for this value to
verify if the suspend completed successfully.

Alex


> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r)
> +               dev_err(adev->dev, "Failed to suspend queue, err (%d)\n",=
 r);
> +       return r;
> +}
> +
> +static int mes_userq_restore(struct amdgpu_userq_mgr *uq_mgr,
> +                           struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct mes_resume_gang_input queue_input;
> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> +       int r;
> +
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG)
> +               return -EINVAL;
> +       if (queue->state !=3D AMDGPU_USERQ_STATE_PREEMPTED)
> +               return 0;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
> +       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PR=
OC_CTX_SZ;
> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r)
> +               dev_err(adev->dev, "Failed to resume queue, err (%d)\n", =
r);
> +       return r;
> + }
> +
>  const struct amdgpu_userq_funcs userq_mes_funcs =3D {
>         .mqd_create =3D mes_userq_mqd_create,
>         .mqd_destroy =3D mes_userq_mqd_destroy,
>         .unmap =3D mes_userq_unmap,
>         .map =3D mes_userq_map,
> +       .preempt =3D mes_userq_preempt,
> +       .restore =3D mes_userq_restore,
>  };
> --
> 2.49.0
>
