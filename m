Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02222CA1012
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 22:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A5510E211;
	Wed,  3 Sep 2025 22:46:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mmSMw/rB";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 552CD10E211
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 22:46:05 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-24b14d062acso706275ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Sep 2025 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756939565; x=1757544365; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2VjivpWreKW27xo8cLHBjhUODL8V5McbLeEHENv0lE=;
 b=mmSMw/rBJYIykl8+8rMxX31cAmS/NYtai0xK5F7YETD0xuMG1HG8/39acPKVe5cvEg
 4kV2jVk4i8qPgh9XPVChlaWxJbJ6ArIKekulf63J2MA3CAc0+v2n1wG62ebLZ50KRCGE
 EELRrAgPsawYonqn8uy+DjNgN5ZfnKh6waHwuc7IKb4NyB40PoWGKK0fkB0Yp8NXpV8r
 /VBrJjY8MpnmdHV/lxlWNPOOw9w9kDv66hGYyzUJ7uBTn9LAz8pQAQnHZL0wVgnem4Lf
 4E7oQ+Zxp/gZLP74Y0M8EDJY0UzEb0cA6vlHc55U32OjsnITM9Yzys4d46FOkeDdNk2w
 KQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756939565; x=1757544365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2VjivpWreKW27xo8cLHBjhUODL8V5McbLeEHENv0lE=;
 b=wHEQENZbeq7B+SxMRj+iMsoHhSLaYPwkHx3Ln7BZm2mHht0QGgzOGCe3pgzO7BEuE9
 /Xdz8GuiR41bnxy3w4Ou0ysKyMIHX/oNZMF0QYTJk0Uk4p0A5iGCCgzEth4L/PKjfJ5u
 p4Ls0rJH6m15mMRW/7pVwgOE/qM3/IaP6w7ifghGRbXbbFAGXROShhatEmcppzgTiaHY
 smEZ/Yy5GLiwQJGATXzGSRFoKRxSKbeqewEXvCK3uq9yB2NL02OzkJrvfSZBJzPdDhbq
 qIpn02M1yuGIryxHz6i9q7J1K68J0kxLPFnLdlaTH9d+2/cvkMUhbjlshl+Kml/VVg0l
 nt6Q==
X-Gm-Message-State: AOJu0Yw+xV/s41D9SpTzGhcvxpwskjOa3GTDOyM+ehN2U63yIMmNsSYj
 LxDO6gLxp9oqDQUjTSxKtw97NukUC6zEbCx4GvLtnjkkrrQb33jNuLbRxcLRBJ6cc07E4zFwPVY
 wGTQicB24BgU8Hkq3FNduPa4rwHE9ZOY=
X-Gm-Gg: ASbGncux/ezcnBwy+niMHxlQiv1fhohegJAssz581fVR1LwAz9KqFwXy4Cr5DppVIOf
 JX1ffLcNLHHLPMS0YdLnNWCRHK3gUQvTql5qawxcasyE99eMTrLN1NREjkh5pO6yuUlu1gMKgiG
 Pwm3yVqfXTxrpmc1M6vawzSdjbgdcAVEv1JkD6OrJdQgzrqB10upHA8VnVTkhT4FTNACxOV7rbD
 TaRtFg=
X-Google-Smtp-Source: AGHT+IG+C7ZXe7ohplpZW3XRBOCL7qp8cyQIKfMqFEhkqHsv8czGN7kzT/W/gVac5hUvGsEAktESJrm3FWXBbmqTwiU=
X-Received: by 2002:a17:902:db03:b0:246:e1ff:b223 with SMTP id
 d9443c01a7336-2491f1393cemr143893705ad.6.1756939564740; Wed, 03 Sep 2025
 15:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
 <20250903083914.2604482-10-Jesse.Zhang@amd.com>
In-Reply-To: <20250903083914.2604482-10-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Sep 2025 18:45:53 -0400
X-Gm-Features: Ac12FXyhTy-tsLcBQlY_YnD3k54EbesttSkTX-CkFFIXtyWIWknY-bTzBE__5cA
Message-ID: <CADnq5_N06GmfZG3NjQa7ChjU72APr+tN3RtPc+A4ux7yjZfDQw@mail.gmail.com>
Subject: Re: [v14 10/11] drm/amdgpu: Switch user queues to use preempt/restore
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

On Wed, Sep 3, 2025 at 4:49=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> wr=
ote:
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
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 49 +++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index aac0de86f3e8..54851ba8756a 100644
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
> @@ -536,7 +579,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_=
mgr)
>
>         /* Resume all the queues for this process */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -               r =3D amdgpu_userq_map_helper(uq_mgr, queue);
> +               r =3D amdgpu_userq_restore_helper(uq_mgr, queue);
>                 if (r)
>                         ret =3D r;
>         }
> @@ -693,7 +736,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mg=
r)
>
>         /* Try to unmap all the queues in this process ctx */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -               r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
> +               r =3D amdgpu_userq_preempt_helper(uq_mgr, queue);
>                 if (r)
>                         ret =3D r;
>         }

I think amdgpu_userq_stop_sched_for_enforce_isolation() and
amdgpu_userq_start_sched_for_enforce_isolation() should use preempt
and restore as well.

Alex

> --
> 2.49.0
>
