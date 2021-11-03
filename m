Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8D1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 17:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255396112E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 17:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 255396112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C6E73D1D;
	Wed,  3 Nov 2021 17:46:35 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6B073D1D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 17:46:34 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 q33-20020a056830442100b0055abeab1e9aso4579609otv.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Nov 2021 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cGHSDHSam/Ag8tmZti9XFFBurtO9eS/udFvGqHQpIBs=;
 b=o7ADPkD7V76rlmm+NnRgy4kQlEL3KAGSwtFESHFvQbvLFlqwa94lM6nPR8qoibfEs+
 2bt4ct9JEEnm/Cm1l/a5eieVNWV/lQBF/+nI3X38XKG+xorizEYKpAwv+e67qhpt3d0u
 o6I+yM0SYSH5p5GfrpeIYielIa8E0sXmT7AhBZF1DQuHB0elSJO2Cm9NzE9/Uk5AkL4x
 eK6ayeJHK2JmxxndDQQsCNaoTP9uVYZAMyk/g5DMU6QFdrpsaYirUb/gVE6KEwqxphA9
 7v2ykfBvvq4z7rM2u3Cr79M5sYjsRTjQHicK2ozgf1g/HNpLsJjjNWK1ENhKgmAvGR2n
 n8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cGHSDHSam/Ag8tmZti9XFFBurtO9eS/udFvGqHQpIBs=;
 b=ON3hqEyJglCN7q70X6Si/xrZwPwprfx/kMqJgjbNwYNdEvw37t8cYRStiHK4JYbBGr
 ZMoGzUhLF/DK6jEb0iripuSUqIzEbUZUCx9tFFFtF7Z0uoTKQ3l9iwWI+VbtPSzrc5O8
 KMrkUUW1KNXApK+RV8kCwq7uhc8SeotvWoS9am+h7UAG+MOriglhQPzfjGkcw+X8dQT2
 ONFSxq4bY5w6HE+Jk8ZCuRnUtfyWaYxG1GZumU5MBFZ8CPg9oNE8wxDS/fvlC7g8S0xh
 eWbu+YbrX5mHbCVj8lXmAFJPs5QrFpfxY2dZY7nGRUwo/x4Oo2doIJsIlCsY2mzlJywh
 mKNQ==
X-Gm-Message-State: AOAM5332wUMTBQAKT4wZsKCs5QAqIcBKNOjsWeqo9D8JwCnX/i+VgMTA
 nN16D0Fu2DukdfbjGZLAnSazURYIc9ZhSOs5CUvMB4o7
X-Google-Smtp-Source: ABdhPJyfM27ahRWYFl2R3xdxc9mB8XXkAIiLyR68vdnFZzOJR2pQMCYlkuJgU2ggk1JDcJ+omen5lSAszE/1GPwD45U=
X-Received: by 2002:a9d:2d87:: with SMTP id g7mr4799278otb.299.1635961594126; 
 Wed, 03 Nov 2021 10:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211103150427.18518-1-shaoyun.liu@amd.com>
In-Reply-To: <20211103150427.18518-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Nov 2021 13:46:23 -0400
Message-ID: <CADnq5_NtesY5Wqcd3RyNH3wMDAZcXZN1buvD2oTQLmyBr98ucA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdkfd: Don't sent command to HWS on kfd reset
To: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 3, 2021 at 11:05 AM shaoyunl <shaoyun.liu@amd.com> wrote:
>
> When kfd need to be reset, sent command to HWS might cause hang and get unnecessary timeout.
> This change try not to touch HW in pre_reset and keep queues to be in the evicted state
> when the reset is done, so they are not put back on the runlist. These queues will be destroied
> on process termination.
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c               | 6 +++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 6 +++++-
>  4 files changed, 13 insertions(+), 3 deletions(-)
>  mode change 100644 => 100755 drivers/gpu/drm/amd/amdkfd/kfd_device.c
>  mode change 100644 => 100755 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>  mode change 100644 => 100755 drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>  mode change 100644 => 100755 drivers/gpu/drm/amd/amdkfd/kfd_process.c

Please fix the mode change.

Alex

>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> old mode 100644
> new mode 100755
> index c8aade17efef..536ef766d09e
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1100,6 +1100,8 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>         if (!kfd->init_complete)
>                 return 0;
>
> +       kfd->is_resetting = true;
> +
>         kfd_smi_event_update_gpu_reset(kfd, false);
>
>         kfd->dqm->ops.pre_reset(kfd->dqm);
> @@ -1132,6 +1134,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>
>         kfd_smi_event_update_gpu_reset(kfd, true);
>
> +       kfd->is_resetting = false;
> +
>         return 0;
>  }
>
> @@ -1168,7 +1172,7 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>                 return ret;
>
>         /* for runtime resume, skip unlocking kfd */
> -       if (!run_pm) {
> +       if (!run_pm && !kfd->is_resetting) {
>                 count = atomic_dec_return(&kfd_locked);
>                 WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
>                 if (count == 0)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> old mode 100644
> new mode 100755
> index e9601d4dfb77..0a60317509c8
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1430,7 +1430,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>
>         if (!dqm->sched_running)
>                 return 0;
> -       if (dqm->is_hws_hang)
> +       if (dqm->is_hws_hang || dqm->is_resetting)
>                 return -EIO;
>         if (!dqm->active_runlist)
>                 return retval;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> old mode 100644
> new mode 100755
> index bfe7bacccb73..e4bcc2a09ca8
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -275,6 +275,8 @@ struct kfd_dev {
>         struct device_queue_manager *dqm;
>
>         bool init_complete;
> +       bool is_resetting;
> +
>         /*
>          * Interrupts of interest to KFD are copied
>          * from the HW ring into a SW ring.
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> old mode 100644
> new mode 100755
> index f8a8fdb95832..f29b3932e3dc
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1715,7 +1715,11 @@ int kfd_process_evict_queues(struct kfd_process *p)
>
>                 r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
>                                                             &pdd->qpd);
> -               if (r) {
> +               /* evict return -EIO if HWS is hang or asic is resetting, in this case
> +                * we would like to set all the queues to be in evicted state to prevent
> +                * them been add back since they actually not be saved right now.
> +                */
> +               if (r && r != -EIO) {
>                         pr_err("Failed to evict process queues\n");
>                         goto fail;
>                 }
> --
> 2.17.1
>
