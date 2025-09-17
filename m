Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444CCCAC59A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA43D10E844;
	Wed, 17 Sep 2025 14:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MwPjWFM9";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DED010E844
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:07:24 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-24602f6d8b6so11849685ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758118044; x=1758722844; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IprkCY42ZU+tUVdOEl1u+74oX6sQlsHo8PN49MQrJiw=;
 b=MwPjWFM9kDqq9FbyVjKOA1So3XVXjqPPJyLmtVA+IYyX0uX6187JIKMwj4Kb9Elatf
 fTTK+Re+DalCzfC4GefsLgmvfmdvrlNTHYSsrX2nGgTB312B40ouNq/c1gTcup3rKJ9R
 USvhVgGnw3799HYPlBb88tTnl8B9K8Kj0SMoSV7OopCJKPLhjNmEIHsPk4DA06IG+gwe
 1HGoWYuf24Iesa7B2qKMqy17OBLD87g36g2FtwQk8HFqQe8y7QrS6Fiw7Pjq/2XvUUsc
 1NqX6lO+H+M0lYE2v3T6Iqf8wm6gYNpDKeeJlnxv3HySsq7JXNbSdQRcmxLWVTQh1qBh
 RedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758118044; x=1758722844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IprkCY42ZU+tUVdOEl1u+74oX6sQlsHo8PN49MQrJiw=;
 b=J1OR//MOBp3vME1YNBwPnJzR1K/v9ld97D+FYnx8FfwfdokSwKAwZhu2vSN8I5U1TS
 9wyPjU1sq3jWjViAMdAf9gKP6g9aCfdw4b4HH9xnXtb4r5yfqVVss3Ye6bnzZ/NLaZFF
 FsjZrOYjQgbsZojWfhG1HHLE3URQMWsIyacew3W6vHM2YhPYDsjMzPbZ8Wrc687by++P
 nn720VqF58r1nKgWTmF9xlDk8D7Jx/0ymQlh9iTz1pKb7RFS/+taEGLpdWpEFPv3DJPY
 8dZtO+E5PuLWT2W/IUdFiTkeh0o9ICzp9nxYVeS4OxWizOlxSn5bysZZhFCizam3nU02
 66Ig==
X-Gm-Message-State: AOJu0YxSUlkZt19G2tNs+qRFkiuf/NFk3qVAxqanMLSBMlMAPVZ9BS0f
 Yfcj8EHsrHIYi/ZpWwziu5ECmODH0CL8jKn0T5aO5b9yn2AcRCGN6DRtc7huzJZS13NdaPT85/W
 UcGU0C3D+FT+nD6rBiR0rfwA5ERRthjw=
X-Gm-Gg: ASbGnct8MaypNFcheKTohGcORTBszTnqCBGRZfM43C3YMQTxTGloA/m597PgqZbXrpR
 PSilpn9YZWdhsufJKCFE3V4B2l31A3uW3SVt3a3oFk9AlqxNzZZa6UNydIO3bbcvg0Uck05AsUx
 htLsQY84RbF5sfk21n/1GQCjHbaas+q85mVmcQCr8olnBf+HXj5EFiHoQcFMDuogMTW3qhdwA4a
 0HA/iSU
X-Google-Smtp-Source: AGHT+IEsOuxHNbkKpe+lBQL//8y6nGhXZ8/0l41bfyjB69LQd4WoQMge8XJapL+EsP1ldONFDxFYcbhvRZlO+/ZgAb4=
X-Received: by 2002:a17:902:e752:b0:267:731c:42cb with SMTP id
 d9443c01a7336-268118b9400mr17564735ad.2.1758118043595; Wed, 17 Sep 2025
 07:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
 <20250912055518.2719533-8-Prike.Liang@amd.com>
In-Reply-To: <20250912055518.2719533-8-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Sep 2025 10:07:11 -0400
X-Gm-Features: AS18NWDOxbVF2RmsCfm4Pu5ZZz_KKp-YWCgFiYPaO9Ca5-hHrw8xBUxOy7_5NGs
Message-ID: <CADnq5_Pi6RsZHPtbKBToO9+FZ6pWMDRrWZo4mW2zLpyRtTP7uw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] drm/amdgpu: validate the queue va for resuming the
 queue
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Fri, Sep 12, 2025 at 2:04=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> It requires validating the userq VA whether is mapped before
> trying to resume the queue.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 24 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 957b26ca2eb7..a13f186f0a8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -115,6 +115,23 @@ bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm =
*vm, u64 addr)
>         return r;
>  }
>
> +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_userq_va_cursor *va_cursor, *tmp;
> +       int r;
> +
> +       list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, l=
ist) {
> +               r +=3D amdgpu_userq_buffer_va_mapped(queue->vm, va_cursor=
->gpu_addr);
> +               dev_dbg(queue->userq_mgr->adev->dev, "validate the userq =
mapping: %p va:%llx r:%d\n",
> +                       queue, va_cursor->gpu_addr, r);
> +       }
> +
> +       if (r !=3D 0)
> +               return true;
> +
> +       return false;
> +}
> +
>  int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm,
>                                u64 addr)
>  {
> @@ -772,6 +789,13 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq=
_mgr)
>
>         /* Resume all the queues for this process */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +
> +               if (!amdgpu_userq_buffer_vas_mapped(queue)) {
> +                       drm_file_err(uq_mgr->file, "trying restore queue =
without va mappping\n");
> +                       queue->state =3D AMDGPU_USERQ_STATE_INVALID_VA;
> +                       continue;
> +               }
> +
>                 r =3D amdgpu_userq_map_helper(uq_mgr, queue);
>                 if (r)
>                         ret =3D r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index b71fff65a896..8cd307be7256 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -156,4 +156,5 @@ bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *=
vm, u64 addr);
>  int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
>  int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,
>                                 struct amdgpu_usermode_queue *queue);
> +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)=
;
>  #endif
> --
> 2.34.1
>
