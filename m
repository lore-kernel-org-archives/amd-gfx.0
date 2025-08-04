Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68CCC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 17:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E1D10E37A;
	Mon,  4 Aug 2025 17:23:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SX/Ts1kA";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F0C110E37A
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 17:23:05 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-31f3fe66edbso512559a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754328185; x=1754932985; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1lQ+KSbA2O7h9aJfctMSiPzKaSdFTBTM1SCCYRZ5NE=;
 b=SX/Ts1kAkfe/MZRjIt+60siFBciVqMYpKRs7NzPzoJWcQgG2pswIoTHNvZhDP59/68
 9SHmI/+NWr5EACY99EC7GLGeXG3Yi7Y9YO3+KyZhKdW1HE6C8N7vmiyVIygpwptdzUAH
 boVm21TaGNY6yY2Datd5cJfiHdlHNw/S/fkpYd3LAzzSIZFgC7wgKZBB0UrbzozxhtNA
 m4pWng4n/jB65GOjt+VteeVWuQ6SVw/iaZi1O6ssau2u0zsvta2QuSbx507bHae/i811
 zFH1KljRuPnXIZSJvYFaX6cZHQf90FttJg0Bd/ExvEYZ4XP1LLCY3+RV1r2IDHOcxjrw
 jYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754328185; x=1754932985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1lQ+KSbA2O7h9aJfctMSiPzKaSdFTBTM1SCCYRZ5NE=;
 b=TDaGUPsjJkWvSZkgLhk1KEKZbB8/t0uZIkVL/PhjMMhFw0t5fODotC6z3bfVsJkKiS
 s7EC159YrQLA91RZfRkGF1PRt68+XAQ69kzCVZebAohopBErvFOZZRgoD20s3TIfv0mH
 kIUQIDEvgWR3+MzRW84QvY4XGJ7gMB/lQZfKHh2riuSMxnLfTi8DEVmGOh4RkISZYMNa
 Wn0ay9weRcqckrCioF3wFgKkqaAszh8YwetnUz7Ya1yMeWEJWGui8ngbAF8ySy3hpNkz
 d8aR8hwH+xpkTFMVAOcdqslFuGSLXTMOxUyxv09RC8yd6h9HodWGvx9OSeH0074+mTOj
 4vxA==
X-Gm-Message-State: AOJu0Yz6t4S1wvQaAi2yg2cfRPFqeGDp6caHk0rbAaGMvEx9KgqhyO2q
 R4hQHAE3abpgdamk4IiKStm28wc7pNFr2MFH4JqIXJXEOWKCgWrWM5aflnwGDRVg6Pc25fED1xc
 JhpuiWTitadgkX+0sMpv5GxDr0g8OeTdSZg==
X-Gm-Gg: ASbGncsyS4E2YpjxcZdjybcJHAiHuljxPgra06+NOsK3qlPZGW0GdEg9KhCxx0jXnrv
 9GqMOBTa12HQGsb7MIxp+WEo4s699xECdzMDdz0uszSWx/3Ax6H1t0wpQpJDw8gWlpWjWiFXyEg
 26wgA5ea1W4o/cVy5LtDmwKU/TpDMzo3uuy4AYzu/pGnx2OQ/6oxjyM0xgzSx7E/av1fpohntYt
 A21mfV2SVldnpaMA5U=
X-Google-Smtp-Source: AGHT+IHqc1Pl7TXgm93hE+GebvafREju/en/1JFrQu6FkEoeBbF5shlgDWrlvSkGx1FO5g0+4VbVq+2mT5uwDWs6Nzc=
X-Received: by 2002:a17:90b:4c47:b0:31e:ffd4:ecdc with SMTP id
 98e67ed59e1d1-321163044d3mr6226421a91.7.1754328184560; Mon, 04 Aug 2025
 10:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
 <20250804084029.863138-13-Jesse.Zhang@amd.com>
In-Reply-To: <20250804084029.863138-13-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:22:52 -0400
X-Gm-Features: Ac12FXycDbmw9SDacp5uxlZH9yylJ_wLyC8q88w3XP0gbe7N_BUbpASM__Xcc30
Message-ID: <CADnq5_NjcFURmDAQdf3wdM_iDbyyMDXxAA2TkyJjkMw36gyvCQ@mail.gmail.com>
Subject: Re: [v6 13/13] drm/amdgpu: Implement queue preemption using
 suspend/resume API
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
> Replace the queue remove/add approach with suspend/resume semantics
> for user queue preemption. This change:
>
> 1. Maintains queue scheduling registration while only preempting executio=
n
>    - Previously used remove_queue/add_queue would fully deregister queues
>    - New suspend/resume approach keeps scheduler state while preempting
>
> 2. Introduces proper preemption helpers:
>    - amdgpu_userqueue_preempt_helper(): Suspends queue execution
>      - Transitions MAPPED=E2=86=92UNMAPPED state on success
>      - Marks as HUNG and triggers reset on failure
>    - amdgpu_userqueue_restore_helper(): Resumes queue execution
>      - Transitions UNMAPPED=E2=86=92MAPPED state on success
>      - Triggers GPU reset on failure

I would move the preempt/restore patches to the start of the series.
Use preempt/restore for all of the cases where we need to preempt the
queues and only use map/unmap for device init/fini and system
suspend/resume.

Alex

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 64 +++++++++++++++++++----
>  1 file changed, 53 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 0c91302162fa..3a8da1f47159 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -72,7 +72,7 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_user=
q_mgr *uq_mgr)
>         bool has_gfx =3D false, has_compute =3D false, has_sdma =3D false=
;
>         struct amdgpu_usermode_queue *userq;
>         bool gpu_reset =3D false;
> -       int gpu_suspend, id, r =3D 0;
> +       int id, r =3D 0;
>
>         if (idr_is_empty(&uq_mgr->userq_idr))
>                 return false;
> @@ -98,7 +98,6 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_user=
q_mgr *uq_mgr)
>                 dev_err(adev->dev, "userq reset disabled by debug mask\n"=
);
>         } else if (amdgpu_gpu_recovery) {
>                 if (has_compute && userq_compute_funcs->detect_and_reset)=
 {
> -                       gpu_suspend =3D amdgpu_mes_suspend(adev);
>                         r =3D userq_compute_funcs->detect_and_reset(adev,=
 AMDGPU_RING_TYPE_COMPUTE);
>                         if (r) {
>                                 gpu_reset =3D true;
> @@ -127,9 +126,6 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_us=
erq_mgr *uq_mgr)
>         if (gpu_reset)
>                 amdgpu_userq_gpu_reset(adev);
>
> -       if ((!gpu_suspend) && has_compute)
> -               amdgpu_mes_resume(adev);
> -
>         return r;
>  }
>
> @@ -143,7 +139,8 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq=
_mgr,
>         bool gpu_reset =3D false;
>         int r =3D 0;
>
> -       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
> +       if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED)  ||
> +                       (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED=
)) {
>                 r =3D userq_funcs->unmap(uq_mgr, queue);
>                 if (r) {
>                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> @@ -185,6 +182,54 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_=
mgr,
>         return r;
>  }
>
> +static int
> +amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
> +                         struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *userq_funcs =3D
> +               adev->userq_funcs[queue->queue_type];
> +       int r =3D 0;
> +
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
> +               r =3D userq_funcs->preempt(uq_mgr, queue);
> +               if (r) {
> +                       amdgpu_userq_detect_and_reset_queues(uq_mgr);
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
> +amdgpu_userqueue_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
> +                       struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *userq_funcs =3D
> +               adev->userq_funcs[queue->queue_type];
> +       bool gpu_reset =3D false;
> +       int r =3D 0;
> +
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> +               r =3D userq_funcs->restore(uq_mgr, queue);
> +               if (r) {
> +                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +                       gpu_reset =3D true;
> +               } else {
> +                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> +               }
> +       }
> +
> +       if (gpu_reset)
> +               amdgpu_userq_gpu_reset(adev);
> +
> +       return r;
> +}
> +
>  static void
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>                                  struct amdgpu_usermode_queue *queue)
> @@ -639,7 +684,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_=
mgr)
>
>         /* Resume all the queues for this process */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -               r =3D amdgpu_userq_map_helper(uq_mgr, queue);
> +               r =3D amdgpu_userqueue_restore_helper(uq_mgr, queue);
>                 if (r)
>                         ret =3D r;
>         }
> @@ -794,10 +839,9 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_m=
gr)
>         int queue_id;
>         int ret =3D 0, r;
>
> -       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>         /* Try to unmap all the queues in this process ctx */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -               r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
> +               r =3D amdgpu_userqueue_preempt_helper(uq_mgr, queue);
>                 if (r)
>                         ret =3D r;
>         }
> @@ -900,7 +944,6 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *u=
serq_mgr)
>         uint32_t queue_id;
>
>         cancel_delayed_work_sync(&userq_mgr->resume_work);
> -
>         mutex_lock(&adev->userq_mutex);
>         mutex_lock(&userq_mgr->userq_mutex);
>         amdgpu_userq_detect_and_reset_queues(userq_mgr);
> @@ -909,7 +952,6 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *u=
serq_mgr)
>                 amdgpu_userq_unmap_helper(userq_mgr, queue);
>                 amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
>         }
> -
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 if (uqm =3D=3D userq_mgr) {
>                         list_del(&uqm->list);
> --
> 2.49.0
>
