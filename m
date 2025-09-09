Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AB7CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 20:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F57910E25A;
	Tue,  9 Sep 2025 20:07:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IeTZue2P";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA2D10E25A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 20:07:55 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-32baaf13944so671543a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757448475; x=1758053275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcntwuxZ3oT7oFN+1Q6d5xBh9D2T7d+KW33ERPH++oo=;
 b=IeTZue2PLpcEAStgZFjxMJJaVrfmO+zDBwApko9VDk4CCmxIoBLbqWfv5+rWhiQJl7
 3bTwelMQrVfKDQUKHkE/j0AaLMJ75YUUI3MAdsPQlSxfXucBSRr88KvuIDNzKAPFnOLK
 gjwj2O7XwcSH1RNw6wjiBupCejOZ0JrBx25lGXI+Fb7DnU+YVpQJ6/+4cVMQ4wdtjbAn
 FaMQJCTCNnWMCuox5WID2yZiyevWFN+Ems7eogyUQ3pR54q7b4YdDJlxEEf3N/Jz51t9
 /2xtnImOu24fdajt5gET6VrHCLP5C+wT5Cwhd1BBrZoWONUfCVY5yMHvsHmnzIvMmMoo
 w2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757448475; x=1758053275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcntwuxZ3oT7oFN+1Q6d5xBh9D2T7d+KW33ERPH++oo=;
 b=vXi2t+2R3ngP/L/bjpVAUPs84dSGtCJJHSsPKlx+OBN0XnK78mwVSimJbkZ0uK9TPG
 TTP7FxIY7E0uN4oeqsopFx3HMMZb8nfGwz7Ak/gSWykUs5+40s1wEEc4yrXuceWEfmMR
 z33a/jfvwQSZE86TM4uVAvZLSyLFPWUKkjE+YiRncAKljg/uAH27lsBhpslVjjbv4ibn
 Ko/qbo0rFNd621OhYQ4RY6CVVdf4GEd2oCKeNWq4dBoIEXEeVsx0RpxCyCh5CgO8Nn6J
 w2i1opUk41CfbIoN9h3VBLd1H34RTtQeXImPZzIX7VvSvxFRvGqRCg2Py7OzxpbEZvsq
 NdAg==
X-Gm-Message-State: AOJu0YxLOgN6FX4zKIE+rujffWmYk5uXMN9gtHQSkU6XduIzU4dnAAlV
 3IuZi7qoVZJpjBMKR8kRIR8BpOQ8ToSnp6/DRIPfZ40zl/aee/CLmmhoMh3fNtoJJop6x4fw1BJ
 CkJllnRMmz1TFd6y6uTFFdZYnykd+nm4=
X-Gm-Gg: ASbGncvj/5sE48ofWaoATj79xVHThYi9XVDAujkg8yd/zWJK8wu20zaelcQwOcyfAQ3
 moRLEkfuKnGV4A08mLQlKHndQQ1b7d7l2rJjJm/beG6PtT/8JijP82I3Z21zK/FnjK1qVAkihqQ
 rA759kGY0g4CgXAfemvSC2/p+krKYdv2XSpVTuRA+3oe2Bx4Osa2Dnsh2qPowY5AP397/zaZYGu
 pVeOmoNQnAAG3SyMg==
X-Google-Smtp-Source: AGHT+IEdCBJ3VuJTbQNiNUaN6Lfwo04QTMgvPXUgeK0pImUrVUOgTo6VMG1fAqtbIA1EgUrT0R/7WgPDdL8AsV70L+E=
X-Received: by 2002:a17:90b:4d0d:b0:32a:e70a:fe88 with SMTP id
 98e67ed59e1d1-32d440c4cf9mr9037111a91.7.1757448475211; Tue, 09 Sep 2025
 13:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250905032026.3256999-1-Jesse.Zhang@amd.com>
 <20250905032026.3256999-2-Jesse.Zhang@amd.com>
In-Reply-To: <20250905032026.3256999-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 16:07:42 -0400
X-Gm-Features: Ac12FXxX0ofG-QWYvSaHAyQjvOkBmMhRT3b---SM37i4V3zEX43xLK6piM0Vcc4
Message-ID: <CADnq5_N9Bipy=hoXW_FBBfA26FBh+d7hS_R2A2k8PXJiMqJyeA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Switch user queues to use preempt/restore
 for eviction
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

On Thu, Sep 4, 2025 at 11:20=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> This patch modifies the user queue management to use preempt/restore
> operations instead of full map/unmap for queue eviction scenarios where
> applicable. The changes include:
>
> 1. Introduces new helper functions:
>    - amdgpu_userqueue_preempt_helper()
>    - amdgpu_userqueue_restore_helper()
>
> 2. Updates queue state management to track PREEMPTED state
>
> 3. Modifies eviction handling to use preempt instead of unmap:
>    - amdgpu_userq_evict_all() now uses preempt_helper
>    - amdgpu_userq_restore_all() now uses restore_helper
>
> The preempt/restore approach provides better performance during queue
> eviction by avoiding the overhead of full queue teardown and setup.
> Full map/unmap operations are still used for initial setup/teardown
> and system suspend scenarios.
>
> v2: rename amdgpu_userqueue_restore_helper/amdgpu_userqueue_preempt_helpe=
r to
> amdgpu_userq_restore_helper/amdgpu_userq_preempt_helper for consistency. =
(Alex)
>
> v3: amdgpu_userq_stop_sched_for_enforce_isolation() and
> amdgpu_userq_start_sched_for_enforce_isolation() should use preempt and r=
estore (Alex)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Patches 1, 2 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 53 ++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index f941787e3506..7772de16f12b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -45,7 +45,7 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_de=
vice *adev)
>  }
>
>  static int
> -amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
> +amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
>  {
>         struct amdgpu_device *adev =3D uq_mgr->adev;
> @@ -54,6 +54,49 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_=
mgr,
>         int r =3D 0;
>
>         if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
> +               r =3D userq_funcs->preempt(uq_mgr, queue);
> +               if (r) {
> +                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +               } else {
> +                       queue->state =3D AMDGPU_USERQ_STATE_PREEMPTED;
> +               }
> +       }
> +
> +       return r;
> +}
> +
> +static int
> +amdgpu_userq_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
> +                       struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *userq_funcs =3D
> +               adev->userq_funcs[queue->queue_type];
> +       int r =3D 0;
> +
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> +               r =3D userq_funcs->restore(uq_mgr, queue);
> +               if (r) {
> +                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +               } else {
> +                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> +               }
> +       }
> +
> +       return r;
> +}
> +
> +static int
> +amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
> +                         struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *userq_funcs =3D
> +               adev->userq_funcs[queue->queue_type];
> +       int r =3D 0;
> +
> +       if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) ||
> +               (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)) {
>                 r =3D userq_funcs->unmap(uq_mgr, queue);
>                 if (r)
>                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> @@ -591,7 +634,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_=
mgr)
>
>         /* Resume all the queues for this process */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -               r =3D amdgpu_userq_map_helper(uq_mgr, queue);
> +               r =3D amdgpu_userq_restore_helper(uq_mgr, queue);
>                 if (r)
>                         ret =3D r;
>         }
> @@ -748,7 +791,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mg=
r)
>
>         /* Try to unmap all the queues in this process ctx */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -               r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
> +               r =3D amdgpu_userq_preempt_helper(uq_mgr, queue);
>                 if (r)
>                         ret =3D r;
>         }
> @@ -933,7 +976,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
uct amdgpu_device *adev,
>                         if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) =
||
>                              (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPU=
TE)) &&
>                             (queue->xcp_id =3D=3D idx)) {
> -                               r =3D amdgpu_userq_unmap_helper(uqm, queu=
e);
> +                               r =3D amdgpu_userq_preempt_helper(uqm, qu=
eue);
>                                 if (r)
>                                         ret =3D r;
>                         }
> @@ -967,7 +1010,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(s=
truct amdgpu_device *adev,
>                         if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) =
||
>                              (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPU=
TE)) &&
>                             (queue->xcp_id =3D=3D idx)) {
> -                               r =3D amdgpu_userq_map_helper(uqm, queue)=
;
> +                               r =3D amdgpu_userq_restore_helper(uqm, qu=
eue);
>                                 if (r)
>                                         ret =3D r;
>                         }
> --
> 2.49.0
>
