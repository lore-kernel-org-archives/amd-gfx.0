Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71EEE87835
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 14:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6842E10E02B;
	Tue,  3 Feb 2026 14:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cr/7iWGW";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DCCF10E02B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 14:06:33 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2b7063004daso313034eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 06:06:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770127593; cv=none;
 d=google.com; s=arc-20240605;
 b=V+OB72+f9S2szaHzaGW5V+NoEA7fnKE+wIzRE9rgcFJZnhfnRpFpf3A1rg8Yx+HgI7
 hcq+FnQx8qSzFda0JkfV7VKc6O8qBEeAwOUt9R6YCLu1FwqycZxCqjvlwhJdy0Gfelp8
 piKZwfpzVGuC72mTWGq7dqjwBA3I2bbyDY9K1l3LYFfwxEupCc8dpWK3Ze/Tumr2JGpH
 uTkEs1g3jh3FBXfB2s2aJk99UDKJiS3Zit65S2vhzhcwwXRTqEMayJAhF3EoXiI2qZDV
 bl4FLXJO8ZL8ZasFSnyrKxK0qUwFrO+yjF4OB/eMkdIoduIZmsYnbF8aj2XWbQW3Eg/U
 40dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9Q9vxpnhvP+ymL8SZBTUO3CVxUpz/KCCp46DvrfmMDI=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=iipBpbNq+jC0SfIXrLjFsQPUgR8RRssf6USuLoIszEN/eJxNbnTfGSKnrZ335vIb6e
 28fbJMYCKiTcRjDf4TYMH+VzmF6aOvhkMs912MoeIoTsZeCloijjDruti0sPyb7bhins
 jDrWJ/XjQh4FY5SEqncFKVo9WBpu3QoPKh14+D5cwiyswSz6ok0pAnIIefK5J3W/grVZ
 /I8+SJGIkAF3y0Ruck51rwA+JarpD0RVHOx5MgwQMBXvKwH6DwVGT6JWu6LdTpBWNrEN
 ggtUrWZQOOB8xp/gzRHLG8XOafJPhJBZidK/imI7frFctdUk4CmvASzrhKrpAFeYMAt4
 adnA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770127593; x=1770732393; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Q9vxpnhvP+ymL8SZBTUO3CVxUpz/KCCp46DvrfmMDI=;
 b=cr/7iWGWZgcHGWX/wCm/WzH85+TmetkX8VIVhjdRmdSk5DMdVtXZKK4cBqROWpee4V
 sBYHwOrR9U0020Apjg9e7QO5C+C0toBmw/Kn2q05id5nleBkpzoGILEpXhz55g6JdCrh
 Es83ZkHBRphn0VKPoDIq8s2c6k3DQGWOzZhnWPecmMkCH75gt5fc+JKzFtiqCtg6LOjk
 LzrQOfOs8Tk/6n2b8m6qTrkv+HesWW5fE+KgySEVZJUCgRYu55VayR1rrH+FHq8Ddg6O
 wexmUNABSXUHvcVeBqTAKx+zUSbAKjru8+4QNCzM/RQYxaq1z1m1+K7RkLpopXsP+xrf
 okfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770127593; x=1770732393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Q9vxpnhvP+ymL8SZBTUO3CVxUpz/KCCp46DvrfmMDI=;
 b=KGve7jhYPK1gVnSZst2D6hErVc2db6+Pl7JOobEGMuQME5QuslRXxh1BxA7u+YNTqX
 UZ+x3XZvtqTz9M/6yWt5Bb0Cxyg6G7A59tq+x+2Eil5kbCev9yzYdysBGW8WrZ6gpavv
 xBRE7T8l4w3jVEvl5YeTWOK6gQDVQLqNgvYrktjcWUpHm4rYQpM8UH2H2NbhzvsBwe5X
 GjZxYbyMxG4lGsBfBX/o/uyR8jJGqtLb9Z4aPMKVKiA+Vg4wDpqkeLa8RJLnI7HAVuw9
 beqEdkoxRs9UVqDP8iVO2HMMZYe8TYlF2DQ1NWC9asOMIHl1pZD/WEEo4eAdPXyybVlg
 qK6A==
X-Gm-Message-State: AOJu0YyPVv93R+gWSorMyY08DIzLiXa5rESOghMYOy+1ouiIKyygCQHy
 seTkXdVinJccgspHs13OG7kg6ACJfJ4Cvh7r6TUY6OKbHHHYf1LMjFu85lJ3dPgE0WQFCjTaLJj
 RyJS8o9ZUOdmzROp+MtU3S8FU8+b+qKc=
X-Gm-Gg: AZuq6aIYCDp2Bsu2dy/dRP542LmJrzATWa+lX9Q1Yndz8ycqDxe7ZFRIvFSkruEe8Y6
 G34+yXikVYJ79du0fF9iN7hVUT0jpOz5R0raHHqbj2Me2+zEfMQVeuctJnbirs+aRWDOmT3pMIX
 zEPTl7WSnn8fXjAHrGDSII8pPhJMWJ7Vhc6B38gWpLieY/w2aAiNKWv2FPoHd+O3geOcgbTrXfx
 +d3JN6B1KvQXQJvDrXLj7XruSyC7a4fb5SwfDekgbP+KCR4yR0kUrdmFw1siIUz1kTZ3php
X-Received: by 2002:a05:7022:906:b0:11e:3e9:3e9c with SMTP id
 a92af1059eb24-125c1018f83mr3584271c88.7.1770127592548; Tue, 03 Feb 2026
 06:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
 <20260128105847.2898288-6-Jesse.Zhang@amd.com>
In-Reply-To: <20260128105847.2898288-6-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Feb 2026 09:06:20 -0500
X-Gm-Features: AZwV_QiPd6Emi2jfXyIrXgm-_0uQ3zBkUQxdFcrOT5oY1D2Duoy74LvxlD17WF4
Message-ID: <CADnq5_OdPXon5npmXr5jrVDJfy=2JEmR=iwyJPO-ODBATaVJdw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] drm/amdgpu: add MODIFY operation for compute queues
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

On Wed, Jan 28, 2026 at 6:07=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Implement the AMDGPU_USERQ_OP_MODIFY ioctl operation to enable runtime up=
dates
> of compute queues.
>
> v2: move queue size validate to a separate patch
>     remove the check for AMDGPU_HW_IP_COMPUTE  (Alex)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 61 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 ++
>  include/uapi/drm/amdgpu_drm.h             |  1 +
>  3 files changed, 65 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 256ceca6d429..3003aba22e1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -837,6 +837,7 @@ static int amdgpu_userq_input_args_validate(struct dr=
m_device *dev,
>
>         switch (args->in.op) {
>         case AMDGPU_USERQ_OP_CREATE:
> +       case AMDGPU_USERQ_OP_MODIFY:
>                 if (args->in.flags & ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PR=
IORITY_MASK |
>                                        AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SE=
CURE))
>                         return -EINVAL;
> @@ -901,6 +902,60 @@ bool amdgpu_userq_enabled(struct drm_device *dev)
>         return false;
>  }
>
> +static int amdgpu_modify_queue(struct drm_file *filp, union drm_amdgpu_u=
serq *args)
> +{
> +       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_usermode_queue *queue;
> +       const struct amdgpu_userq_funcs *userq_funcs;
> +       int r;
> +
> +       mutex_lock(&uq_mgr->userq_mutex);
> +       queue =3D amdgpu_userq_find(uq_mgr, args->in.queue_id);
> +       if (!queue) {
> +               drm_file_err(uq_mgr->file, "Queue %u not found\n", args->=
in.queue_id);
> +               r =3D -EINVAL;
> +               goto unlock;
> +       }
> +
> +       userq_funcs =3D adev->userq_funcs[queue->queue_type];
> +
> +       /*
> +        * Unmap the queue if it's mapped or preempted to ensure a clean =
update.
> +        * If the queue is already unmapped or hung, we skip this step.
> +        */
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED ||
> +           queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> +               r =3D amdgpu_userq_unmap_helper(queue);
> +               if (r) {
> +                       drm_file_err(uq_mgr->file, "Failed to unmap queue=
 %llu\n",
> +                                       queue->doorbell_index);
> +                       goto unlock;
> +               }
> +       }
> +
> +       r =3D userq_funcs->mqd_update(queue, &args->in);
> +       if (r)
> +               goto unlock;
> +       /*
> +        * If the queue is considered active (has valid size, address, an=
d percentage),
> +        * we attempt to map it. This effectively starts the queue or res=
tarts it
> +        * if it was previously running.
> +        */
> +       if (AMDGPU_USERQ_IS_ACTIVE(queue)) {
> +               r =3D amdgpu_userq_map_helper(queue);
> +               if (r)
> +                       drm_file_err(uq_mgr->file, "Failed to remap queue=
 %llu after update\n",
> +                               queue->doorbell_index);
> +       }
> +
> +unlock:
> +       mutex_unlock(&uq_mgr->userq_mutex);
> +
> +       return r;
> +}
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>                        struct drm_file *filp)
>  {
> @@ -920,6 +975,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void =
*data,
>                         drm_file_err(filp, "Failed to create usermode que=
ue\n");
>                 break;
>
> +
> +       case AMDGPU_USERQ_OP_MODIFY:
> +               r =3D amdgpu_modify_queue(filp, args);
> +               if (r)
> +                       drm_file_err(filp, "Failed to modify usermode que=
ue\n");
> +               break;
>         case AMDGPU_USERQ_OP_FREE:
>                 r =3D amdgpu_userq_destroy(filp, args->in.queue_id);
>                 if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 833468b58603..7cd1ea94e368 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -31,6 +31,9 @@
>  #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, bas=
e)
>  #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mg=
r)
>  #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr,=
 name)
> +#define AMDGPU_USERQ_IS_ACTIVE(q) ((q)->userq_prop->queue_size > 0 &&  \
> +                           (q)->userq_prop->hqd_base_gpu_addr !=3D 0 && =
 \
> +                           (q)->userq_prop->queue_percentage > 0)
>
>  enum amdgpu_userq_state {
>         AMDGPU_USERQ_STATE_UNMAPPED =3D 0,
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index c52949ea8c1e..aa9b31578c6b 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -330,6 +330,7 @@ union drm_amdgpu_ctx {
>  /* user queue IOCTL operations */
>  #define AMDGPU_USERQ_OP_CREATE 1
>  #define AMDGPU_USERQ_OP_FREE   2
> +#define AMDGPU_USERQ_OP_MODIFY 3
>
>  /* queue priority levels */
>  /* low < normal low < normal high < high */
> --
> 2.49.0
>
