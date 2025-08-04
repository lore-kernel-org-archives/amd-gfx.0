Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC74EC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 17:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9EC10E360;
	Mon,  4 Aug 2025 17:17:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lrHrqA8K";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0BF310E360
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 17:17:10 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-240240f1478so9786175ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754327830; x=1754932630; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fEG+Z0RUFNyE68XDSCxSMirBktlz2o/elTXo9HkwFpw=;
 b=lrHrqA8K1tt4k4CKyFzseYCsY+vUBPojnjWQZG2utWGGRVBWvlkWpzMvZqVjOoMRTk
 k9acrndMYf7a5/uEUGbpdFoJaqwEynaGBDwhi+O+ePEIgdgckNSsIW1XVOkm6W29dbmk
 uWzxZkDko3rcRwRBq+6319Td2Xm0wgTdtzkakL2mwMEPfr9kwsfAHP3LIU3tUfU9yAmf
 8RfkvxVKLZ2bU5pUY+MJmbVbSdmnxfJA//mwW9K02Pnc2Kepgv/O/odSzrWc9nwiparP
 +KtXxaNQMIRHFkto2kT+ct0Sd/kQBaKqAlrTYEMmERYzUBqxwfT1l0ibbnhFipv2BkML
 jjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754327830; x=1754932630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEG+Z0RUFNyE68XDSCxSMirBktlz2o/elTXo9HkwFpw=;
 b=ZMPNhAfzMqPDUmAv3vmeoDvUQdraJ5jAJuTB3vsYuInnl5KztsZVuVxNCEg5wU0vru
 0kBhqc42W//ML3+zoHSLDu+ikR5p2fNJy7HHIAB1ftsdPGAwPR/0gxwCbcI1jxi4WQ7S
 RYpaEjqvTbViLZfponRUGnMhjK4b7BTI7kQeL+884QE5iZ5dUUoLCKFi62DB1I2F3Shu
 Cy2lo482eThmR0oSSyaqQQ9D/PlR30dYmCaCLbml6Zl9fRwQxJQZiE2m4qSvcXcFLx3D
 AfvHbU2E2u8tWZOZJkikDqXFmY0fXJw+jcVmbpEVFwn8ac7ysIslbk9eUmV2x399oJeq
 BMKA==
X-Gm-Message-State: AOJu0Yw9uB//0pRHteMyAFsiUSwnGp74brUGXATny/TtK1ygJkMcmdYN
 V0xjxAjab5kWnynfAd1H/rsLbrBr+BA7jNuUFNUM8RPzAfLp46dV22ujXA7wUPFTly3h7RHMnl7
 CzXfIrFJECjUPLtKjHOk7WucZMV/ojwMjLnpQ
X-Gm-Gg: ASbGncsGwuqpqvfUsZ+bnZz4CW7KFNAIvTN9fMAuMrMfR0FhehUPQ9vSVinQNkjRz7u
 n7qSNWcLqOESdGUsFVwS8WfbuVFXcG02fqieIicVn0/voqBazHIfu3t49WzkWisgt/8/6z+Vx9Z
 eZDZfH5T9NqJF2N2QQ8v4HOA/oEBlUa9lR73Yfx0DrkDw7cgJDRSCv+yM52Iw9qv07XwB8dmnhk
 3NFC5sI
X-Google-Smtp-Source: AGHT+IFpsVzM8OaGn7ygTRORgK9310GYmhM+/N3wL/UTAntxkbjj7UyqY4E/doaFWs+tZO7pPdrwQWyxR6biRQjc52c=
X-Received: by 2002:a17:902:d2ca:b0:240:280a:5443 with SMTP id
 d9443c01a7336-24246f2d787mr58534465ad.3.1754327830276; Mon, 04 Aug 2025
 10:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
 <20250804084029.863138-8-Jesse.Zhang@amd.com>
In-Reply-To: <20250804084029.863138-8-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:16:58 -0400
X-Gm-Features: Ac12FXwbfNydTNUsvfiG-imGRxcBI9XBdf2n4gd2y4AJx3eQ1-EwBVCDkXKWg78
Message-ID: <CADnq5_NOs_cmJBfUwFNP8J=_88B9+XxGbyC5DkRzq+bd8DmRbA@mail.gmail.com>
Subject: Re: [v6 08/13] drm/amdgpu: adjust MES API used for suspend and resume
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

On Mon, Aug 4, 2025 at 4:41=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> wr=
ote:
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
> index a871bac71e1e..8934d7113d58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -395,10 +395,61 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_m=
gr,
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

You need to allocate a separate buffer for this.  You should also set
the fence value we are waiting for.  The driver then needs to wait on
this fence location to make sure the suspend is complete.  You can use
a wb allocation similar to the status stuff in
mes_v11_0_submit_pkt_and_poll_completion().

I think you also need to specify the doorbell offset for the queue you
want to target since this function is per queue.

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
>         .detect_and_reset =3D mes_userq_detect_and_reset,
>  };
> --
> 2.49.0
>
