Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A6DC3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 18:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D78A210E4DA;
	Thu, 15 Aug 2024 18:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OAhuig37";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E1C710E4DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 18:18:04 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-201ed196debso11366735ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723745884; x=1724350684; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K82kYMTyNhtXCa7q7yg5V5dCtS9tkQpgnj3DjQQtuIo=;
 b=OAhuig37Vco01NIjm1PpP0SePYJMU/RkML6tYfC/5mnI8NwaJhm8IELqA4FavlLSH7
 KAQK4AChBNZ4zxFzkTNEKYTtGblhQqE9ywNB5gXaAzJMjNI4/p7YFxUocUcLAmbgnA9J
 t2divOUut/6yNGZ7vvoZrkwK6lT5J09teOAf5m6iZcmug3wWgOHRVLX4/Ox1x1rIBcq4
 1+EaHi5w+YEchAoof3pEbFKNDRheQosDmHMjNyJBI56TFn2WFvrUBSMo+ABVeFGcDSR4
 n+qAln6DSSefyYFH882SnAoqPmojsRzx15y+uu4SKkeqAWU8OPxPfE7PQHieuJu+Kku+
 5Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723745884; x=1724350684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K82kYMTyNhtXCa7q7yg5V5dCtS9tkQpgnj3DjQQtuIo=;
 b=KZVkV9Z/UyYu3EqU7Y3C4FrIQeCg3cLRH2xMOeP/cP+K+KIkWnj6C57qk2Rn26xwUi
 81+nJwB1tE7qgOBrlILpIGXZth/lkt6tXj9jiLG+1YXZRRCzu8x/Y3221a5QaW56sbgy
 5k4gp55tur4qxxc3y4+WKwvKfOfEfAH1XE0pUijkoGAbIs4aPqhzaNPR+qWGOiZni/JM
 b46vXzz3fAjnPfLtaoR8dNu0hHTQnaRxiGnRYQdP4Iz4vkvcDmxfRHCSTxAcJ2b5eNFB
 nIomTCMvMRh17T5rgdXwQzTPQsghSFqH3DbLsAFkGgAHmDBCij+LZNiidqE8Tq26PSTH
 LL0w==
X-Gm-Message-State: AOJu0Yx26TLgMrCu3vWsK+1xisjIBT5jIKkOA5NgCKkPfMruL3Q3qLd7
 pD+a9S6M7fP4H+/tjX1M0xjhli6Ahwl59GJ8QNF4rFo01oM9OZMOdYzSeH8p8kFrYCurzXqSwTC
 9CX/sdscuorOn/XmxA1wVr5Rq90ct7g==
X-Google-Smtp-Source: AGHT+IGjVw6V8Avesxs1+A2fBW2HkkdLp3iiV9rHqia2V0g0f/RSI3WJyjPtpN3Kp9zYHln7jvddIOilcGbRcsMHlgw=
X-Received: by 2002:a17:902:db05:b0:202:2ed:b3d2 with SMTP id
 d9443c01a7336-20203ec387cmr5983215ad.36.1723745883645; Thu, 15 Aug 2024
 11:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240814232754.1119319-1-mukul.joshi@amd.com>
 <20240814232754.1119319-2-mukul.joshi@amd.com>
In-Reply-To: <20240814232754.1119319-2-mukul.joshi@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Aug 2024 14:17:52 -0400
Message-ID: <CADnq5_MFfMud-4Xfp2Ryud-E+JjNEqjz0T_xArSxmYCsATRcWA@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] drm/amdkfd: Update queue unmap after VM fault with
 MES
To: Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, 
 alexander.deucher@amd.com
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

On Wed, Aug 14, 2024 at 7:28=E2=80=AFPM Mukul Joshi <mukul.joshi@amd.com> w=
rote:
>
> MEC FW expects MES to unmap all queues when a VM fault is observed
> on a queue and then resumed once the affected process is terminated.
> Use the MES Suspend and Resume APIs to achieve this.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v1->v2:
> - Add MES FW version check.
> - Separate out the kfd_dqm_evict_pasid into another function.
> - Use amdgpu_mes_suspend/amdgpu_mes_resume to suspend/resume queues.
>
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++++++++++++++-
>  1 file changed, 77 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f6e211070299..cb5b866eee3b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -319,6 +319,42 @@ static int remove_all_queues_mes(struct device_queue=
_manager *dqm)
>         return retval;
>  }
>
> +static int suspend_all_queues_mes(struct device_queue_manager *dqm)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->=
adev;
> +       int r =3D 0;
> +
> +       if (dqm->is_hws_hang)
> +               return -EIO;
> +
> +       r =3D amdgpu_mes_suspend(adev);
> +       if (r) {
> +               dev_err(adev->dev, "failed to suspend gangs from MES\n");
> +               dev_err(adev->dev, "MES might be in unrecoverable state, =
issue a GPU reset\n");
> +               kfd_hws_hang(dqm);
> +       }
> +
> +       return r;
> +}
> +
> +static int resume_all_queues_mes(struct device_queue_manager *dqm)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->=
adev;
> +       int r =3D 0;
> +
> +       if (dqm->is_hws_hang)
> +               return -EIO;
> +
> +       r =3D amdgpu_mes_resume(adev);
> +       if (r) {
> +               dev_err(adev->dev, "failed to resume gangs from MES\n");
> +               dev_err(adev->dev, "MES might be in unrecoverable state, =
issue a GPU reset\n");
> +               kfd_hws_hang(dqm);
> +       }
> +
> +       return r;
> +}
> +
>  static void increment_queue_count(struct device_queue_manager *dqm,
>                                   struct qcm_process_device *qpd,
>                                   struct queue *q)
> @@ -2835,6 +2871,40 @@ void device_queue_manager_uninit(struct device_que=
ue_manager *dqm)
>         kfree(dqm);
>  }
>
> +static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
> +                                  struct qcm_process_device *qpd)
> +{
> +       struct device *dev =3D dqm->dev->adev->dev;
> +       int ret =3D 0;
> +
> +       /* Check if process is already evicted */
> +       dqm_lock(dqm);
> +       if (qpd->evicted) {
> +               dqm_unlock(dqm);
> +               goto out;
> +       }
> +       dqm_unlock(dqm);
> +
> +       ret =3D suspend_all_queues_mes(dqm);
> +       if (ret) {
> +               dev_err(dev, "Suspending all queues failed");
> +               goto out;
> +       }
> +
> +       ret =3D dqm->ops.evict_process_queues(dqm, qpd);
> +       if (ret) {
> +               dev_err(dev, "Evicting process queues failed");
> +               goto out;
> +       }
> +
> +       ret =3D resume_all_queues_mes(dqm);
> +       if (ret)
> +               dev_err(dev, "Resuming all queues failed");
> +
> +out:
> +       return ret;
> +}
> +
>  int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
>  {
>         struct kfd_process_device *pdd;
> @@ -2845,8 +2915,13 @@ int kfd_dqm_evict_pasid(struct device_queue_manage=
r *dqm, u32 pasid)
>                 return -EINVAL;
>         WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>         pdd =3D kfd_get_process_device_data(dqm->dev, p);
> -       if (pdd)
> -               ret =3D dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> +       if (pdd) {
> +               if (dqm->dev->kfd->shared_resources.enable_mes)
> +                       ret =3D kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
> +               else
> +                       ret =3D dqm->ops.evict_process_queues(dqm, &pdd->=
qpd);
> +       }
> +
>         kfd_unref_process(p);
>
>         return ret;
> --
> 2.35.1
>
