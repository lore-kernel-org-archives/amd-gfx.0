Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE2CCA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 20:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E20810EAC1;
	Thu, 28 Aug 2025 20:37:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bLEmaztK";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF6BE10EAC1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 20:37:57 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b4c27bdc259so240036a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756413477; x=1757018277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGgC8E2tk3qaEgHgJbfF62uB9w516lATThX+wP0SEM0=;
 b=bLEmaztKTyVdklvGoJtylf+okBwReBph+idAuT8Mrev0KiMRzshdVUNYkx/S/aqfWq
 gGqNfAX1oaMf2O/n/BfdRCD6pRAO4epJg73mb0BxUwRPs6QNK9vf1wlbuKEWIQK0E019
 YlDOqxB32hXRQpDB10Zmi5AgchW6xsUavapVXhHgXfNbjfrSAyqtBhB1ox0BNuOG/N9h
 9+YyPnuox5uReqDMYFNufoLAiIkjKwpA+tCz8dGM7VykGWiwYh327puxYgw75+dNp6y7
 2EBuIj3RxINBZSSqTCmUj4nkvqHiM346LTuqVer4Y/QskQCogaMAeQuVsFP5LZGnXdIU
 nQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756413477; x=1757018277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGgC8E2tk3qaEgHgJbfF62uB9w516lATThX+wP0SEM0=;
 b=w8suGx51/bavRayp+S4xC9+s+N0Cj9bVMJbIokI/Abzh0vM0TPgF4p+dc6SfmFAmOC
 LNkt+ZYyJKJrH1oLGd/TcWglVGSd3blV2FuabZZWeqYx55wKohUVHB2AQt/A5jSrjtGE
 RH+t0JoykASIG37BNWtCeid+7O3DWEuzRSjrdJx1+uLfP+s+nwNEWmvyV+44wGpK7s4U
 FL8CZVVjRfLak8pxM51WLzEVOuYSWf5xq2i6FVZmB7DXLrxkGv2X6nXBBYZT5zs1dLXK
 9BwcbasxCJp6kpyZYyoy6G5IxncKSFZ3vv2sgLUJAsxiO+zF/2gX7iSNSKgGzHPBPHr2
 qMAQ==
X-Gm-Message-State: AOJu0YwFISYmplLCRjYjLBk9ptare9xf7PTg5lVOXd0Xn79urhFtVpy2
 iBf7moS7rQkK2qeTfXc9fsMcwIlzcKU52vpDSUKugn3tnmJEEZ61w/VRVASFe7JroiYdSPcMGdb
 /SITyS8rj3wPS0LKvn0tx4xNV+AKVlEmCyFQD
X-Gm-Gg: ASbGncuGfAbQQzVU3kg/ng8px3XDUUMs4pXuB/gmk2KcLg/27T187QD2JW+PyjRjnIX
 EX5fsuFcekuPZyfG1HUJoGkIwWt8t9fkkH2sqUmNJN1RUlp4wnRATM3EEFRfsEwv0qaZo3DQxiL
 EXi3yMWUz+1ckUn/r3wobph7y4T6T6cOD57qZToPOWdBWqQTv1bVcsbbk/Doimv4/+oObliM5Ei
 xs6i4EPxboX/JtKGw==
X-Google-Smtp-Source: AGHT+IEF1HvzRvuJ6whx+d2bpm0wf7KdibMHdpgAQax15P9YbKILX7WVGoi9fv0/O3+Pq75wGVOnp3btNyEEe7DP8/4=
X-Received: by 2002:a17:90b:4f45:b0:31e:ffd4:ecdc with SMTP id
 98e67ed59e1d1-32515ef2adcmr15381245a91.7.1756413477257; Thu, 28 Aug 2025
 13:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
 <20250828084457.1999535-10-Jesse.Zhang@amd.com>
In-Reply-To: <20250828084457.1999535-10-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 16:37:45 -0400
X-Gm-Features: Ac12FXyrsZ7ZNUmQ5fDDg30R5UXFGoJWe1cLbyio5uQeOMtNOMS44_QHSike-ww
Message-ID: <CADnq5_NR_q9RpSSkR1cz9NM+ThVpb3odN+cn23uemLtZuczEZg@mail.gmail.com>
Subject: Re: [v12 10/11] drm/amdgpu: Switch user queues to use preempt/restore
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

On Thu, Aug 28, 2025 at 5:23=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
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
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 49 +++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index aac0de86f3e8..decedf8057ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -45,7 +45,7 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_de=
vice *adev)
>  }
>
>  static int
> -amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
> +amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,

amdgpu_userq_preempt_helper() for consistency.

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
> +amdgpu_userqueue_restore_helper(struct amdgpu_userq_mgr *uq_mgr,

amdgpu_userqueue_restore_helper() for consistency.

With that fixed, patches 1-10 look good to me.

Alex


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
> @@ -536,7 +579,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_=
mgr)
>
>         /* Resume all the queues for this process */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -               r =3D amdgpu_userq_map_helper(uq_mgr, queue);
> +               r =3D amdgpu_userqueue_restore_helper(uq_mgr, queue);
>                 if (r)
>                         ret =3D r;
>         }
> @@ -693,7 +736,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mg=
r)
>
>         /* Try to unmap all the queues in this process ctx */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -               r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
> +               r =3D amdgpu_userqueue_preempt_helper(uq_mgr, queue);
>                 if (r)
>                         ret =3D r;
>         }
> --
> 2.49.0
>
