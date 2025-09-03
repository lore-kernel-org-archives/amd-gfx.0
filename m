Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160E7CA1013
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 22:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE04510E95A;
	Wed,  3 Sep 2025 22:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7wdseYV";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7110410E95A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 22:40:20 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-24b132bd90dso654835ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Sep 2025 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756939220; x=1757544020; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqkmw9g5PJQPsB3dAzgo+oWVIL8ZgSjwyAv5/zQFBOg=;
 b=S7wdseYVy+R8/m9ynX63NnDWZI0wCRb/la3q2KaRoO3X6KSZUj+9ndYwUri4XQbz4k
 zAzDZcxZBu1ZGEY0TYZ30jjw6ScfjnJjEjx+/jraI9enRmb8h1buO8fuqTyXNuJLaCiL
 A/eV7B4wEJGvxxW1U/QRr9bc0QlYptebV4LRtkT012W0CJoTjHOR8tML7IKNvLTcWd5w
 EbfBLtMSxWssPce/jjYM9sTsuIbZcC7LUKAWubSIQGhKXtsN3jZ5TgTbniDVm+ylE6gv
 b/Vh18sUcDfQNPxHJAZ838pD1q0nXwcEWs3PgSaDGAYhJlv560D3iYStzimkGmoBfzai
 YVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756939220; x=1757544020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqkmw9g5PJQPsB3dAzgo+oWVIL8ZgSjwyAv5/zQFBOg=;
 b=uihgqyIrTDHMJpsetUIFYq8uPA4FMsvEWxLOl92mDQuo+mwgyqhb5EeDg1OxCW1Y0b
 o3NlC/nfhXGBNrDt6NFEhk5DI9uTRo8AMVmqPyx0mAa4qzLGbMikjyT02pPXonS/aGks
 68mdSvpCv37RVBRuowDzDR3z42Md/mhuW0k1GzRzpknhR7HjkaHFLX85afjZ7pQhqTT3
 WYCFNbQqgTO/lLPqkAC9arUsAvXPdksfFAAEhTm3EH8jDdLbaifjcjwNUF8D8YDPO7jc
 4kY0xISj3MKW3TF2Q2L2Qjk5900czGjU+9EjHnwYZmxu/v0GwF3ljH8xKp5jwPAGbFwb
 NAdA==
X-Gm-Message-State: AOJu0YzRd+8RBLDCzzIUvghYUIs6jBk0TSji4bPOsRkHrkm+R/7myPck
 jx9N556XuPjNNbxj2E8ZJGxPSDeiW0mXycyHm45vaUts5pWW1UeSv3wfdJ+f9i1UC7D8Z4XLDXy
 rkvjhZwNqa4u59LctSNcYM8RnXzwWnms=
X-Gm-Gg: ASbGncssZps8GuqcMXl8IWeeYnl6rVC9kGJapewx4SBqMK9kKutwXWFR68NcZY75GJY
 LNNGa28zzIjPeCgz61hKXdET0VLLQwaZ9XP34IsyXu1D989Pvon84w+EFaXJNmYVroPSkbZXWA2
 X09VQiaXD/9SqzpvkvnZR+iy+9WjlcPyPLeQPuJjCKDwFQkH1lcoPiaKUPBuMcxu1UFHW6O3+Gu
 HYVjxPbcYZ+PhigbIRr/xEAogX7
X-Google-Smtp-Source: AGHT+IErVuxG6UgYGuHwXQlBQ5SIwOy/PdQSakaKOChrTO/d10oI/ZDWYL9tQspJjQDk5TlOZHbaoFNuajYaEYtxm3s=
X-Received: by 2002:a17:903:1d1:b0:248:cd0b:343a with SMTP id
 d9443c01a7336-2491e0f807cmr148982965ad.2.1756939219827; Wed, 03 Sep 2025
 15:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
 <20250903083914.2604482-2-Jesse.Zhang@amd.com>
In-Reply-To: <20250903083914.2604482-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Sep 2025 18:40:08 -0400
X-Gm-Features: Ac12FXwhYTim_y990sAwbTk-DGFQn_vD7d7rSJPBW1ve_JmXGxKeMIJIyGkTMKw
Message-ID: <CADnq5_OUguzT1Zk96Zo_M0YSy6Buv4yNNKXndRSfvQ=HYDzWxQ@mail.gmail.com>
Subject: Re: [v14 02/11] drm/amdgpu: adjust MES API used for suspend and resume
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

On Wed, Sep 3, 2025 at 8:29=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> wr=
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
> v4: allocate another per queue buffer for the suspend fence, and  set the=
 sequence number.
>     also wait for the suspend fence. (Alex)
> v5: use a wb slot (Alex)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index d6f50b13e2ba..502fa0a40107 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -347,9 +347,80 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mg=
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
> +       u64 fence_gpu_addr;
> +       u32 fence_offset;
> +       u64 *fence_ptr;
> +       int i, r;
> +
> +       if (queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> +               return 0;
> +       r =3D amdgpu_device_wb_get(adev, &fence_offset);
> +       if (r)
> +               return r;
> +
> +       fence_gpu_addr =3D adev->wb.gpu_addr + (fence_offset * 4);
> +       fence_ptr =3D (u64 *)&adev->wb.wb[fence_offset];
> +       *fence_ptr =3D 0;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
> +       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PR=
OC_CTX_SZ;
> +       queue_input.suspend_fence_addr =3D fence_gpu_addr;
> +       queue_input.suspend_fence_value =3D 1;
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r) {
> +               DRM_ERROR("Failed to suspend gang: %d\n", r);
> +               goto out;
> +       }
> +
> +       for (i =3D 0; i < adev->usec_timeout; i++) {

For other operations, I think the default timeout for MES is 2
seconds.  We use 2100000; /* 2100 ms */ in
mes_v11_0_submit_pkt_and_poll_completion().

Alex

> +               if (*fence_ptr =3D=3D 1)
> +                       goto out;
> +               udelay(1);
> +       }
> +       r =3D -ETIMEDOUT;
> +
> +out:
> +       amdgpu_device_wb_free(adev, fence_offset);
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
