Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7D6E7FDF5
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 22:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F6910E161;
	Mon,  2 Feb 2026 22:38:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CJYI3I8a";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB4E10E161
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 22:38:02 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2b7267ff06fso265783eec.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 14:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770071882; cv=none;
 d=google.com; s=arc-20240605;
 b=eBN4MjbwCRqk8E1yEH3DmU4R2SJ2CdoRmp0Q0JmFI8837eVXuDetKojEK6ST3MYpXc
 StkE4kaITMsCKWB9NRTzskYkqxSQOWNgRFI9XKVhzscKQs+oZofAlT31iVFJrE3JY8M5
 TJwz4eXviltvPoxhC2yxTZghWozEK43wuS345ovOoBOOd91cDrF66i0BF2q5ZIJLAOuh
 Lti5cleEW/gV6J1ocyDDpXsPADvl2/MIO/Rv2JeWryBFHqEacpjMZhXpZl3O/ky+iKt1
 oPJYbQVKweAw4jh59W8/OUpS1oKnp8huyOtr9ecO9Gd5KQU71F60o+WxikvWKnemR3jI
 90Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vgiKnX2TEs4a/BtwMXA/21AlzNUd90OhDXl77+pcoVg=;
 fh=huIj4lRj4nujxaImVDb+v//8wK6Ybf4IZ77rHUIp+vg=;
 b=RIZDajftGKQmSuxP+v2VqN4ShF020V5fyIuR7jAn+tZ9XgfO7GnHWBknuOOk2BHuhp
 eUOA9BrruWkqg2dr7nwrg5+/3qjlpI39PRUaxSVc+MlWXw2VW2oc2Rlwc3uP9yzs4b1u
 hXkKL2MoKlhU+gBBeCm1VNvzOt4HhewEHE1q6TODUdiiTFVssfHaU45jHw7FVgwgTA3n
 emGr/iOtbSJwFjb9G8avLetoOzl7gMe8gZHHZFdcJS8pK9OBVyR6WN5Kl/N9IpxfV5x0
 XVJODaGtaZlMUFUBG2g7c4faDyUjclTwrI3Zot9xzgiggbaRoXwIdUKEBemK/UoyeEYN
 XJIQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770071882; x=1770676682; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgiKnX2TEs4a/BtwMXA/21AlzNUd90OhDXl77+pcoVg=;
 b=CJYI3I8ajgCXw9zkyYti8ZjSXn8TvF5Tu28TwUJ87t3dRKS926c+h2t3g07yBHfCni
 1RGk6fCU00vftNXvj0eVMfEVsBW2E174IqRmd1wcnKdNp+vJodSqFAeinK5TTzK88nHl
 E0xMZxcm7qk3/BHpKxDzDqewnvi6ZKRxLOYqbAx3lISU/bRVsP0ZC4ylmIlNqLQRS1ML
 3dPVZ2zSKE5n1r73c7OPkeD+SKqbq6XF+ZVm3reg0Ugyb35GP8STpTrzihm2ea2JYOcT
 dxtFVvnh5BkK+MLE+YE6dn7pfooe/I5YcPSUrDj63gN0eIdbSFWG9XvmFGzMYsna5kXO
 5Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770071882; x=1770676682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vgiKnX2TEs4a/BtwMXA/21AlzNUd90OhDXl77+pcoVg=;
 b=dAoFkQFqcBoiA8ORjCbPfo1qBMlz45lf5E7opiFgJoB0JthowRaAvloI+YppK/W4uJ
 k+g6dvtJmDbKfWzZ3y8fephddiE5teldZrcuO8JEMuevP6DaxDOG8BubI+7qCHfMs6Bt
 OLgWITh/grlJClQAW3QFTWPYtCLoGmQSdiOMuPo8GR3mTBvR6ZPj9j+b4Qa9ulgtvxZ+
 fHcv8iBHOoFapJtBSRsDw4+cSCAFXKHVqJfmq+M9UDPZZ/BD57NEvDmyNjasxQyIU4p6
 66WsYGHj3wSu1NFdi9suY37PU1B4l5zVtz/lOVzWZvS3HWFIon9VaUepeAVZmI3z+GqY
 S46w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ1Rif6YfU0qHRYzVTSGv9u4FUZZmQ9N/Zmhog2NherQ3mVyvdnXUDKeiqFWrgNW8HZjYnHZip@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYL4brwNdkpY9vUpeU8M0b5Z85DoaU2mki8u0D5DNEzlu4gUqW
 goUjLCz60Cih8yuVsIaVVJsiybwBtcZnkI1doFV8Wmhf1W5hrofYg3KhUhmqDqj9sVMyjr71mUs
 a0bJJ1o5AOA5nCOpXOWQ2elLhzz1DcXCj+4cc
X-Gm-Gg: AZuq6aKyDNHFxy3g9YTiUuaNjUgnndp2APxhYGQgioHXj3k1dzEkCV6JFWZToWLbGbu
 Lsm4hAZWZpbEEfGk24/bNaKZ3d5BnqQGjLO8xSI8frwDjVMjFPcbneIQgMepVLp7KTgUIg/N6j1
 plf88hZd+H1CjTw7OrcwN/xtUQ80Bur/tOX77QEmxz/TJKm3CtglGLvFNMo6I5jsb09YHDFSPkU
 phoCAStdyZ/4f1XhxrybxqGpDGwdA30pcKFh8oDxlO+B0HgIXDyU44TQL2/H7TNVjuap9TX
X-Received: by 2002:a05:7022:660b:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-125c0f12e0cmr3058556c88.0.1770071881849; Mon, 02 Feb 2026
 14:38:01 -0800 (PST)
MIME-Version: 1.0
References: <20260202125149.2067-1-christian.koenig@amd.com>
 <20260202125149.2067-5-christian.koenig@amd.com>
In-Reply-To: <20260202125149.2067-5-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 17:37:50 -0500
X-Gm-Features: AZwV_QgVJYYvbCWLG19gpcHRxLuTCvYpsGGVMm_x8Gpv-wnIPdK54vtg58Q9V0M
Message-ID: <CADnq5_Nb1JwDtZv=3iZX5dgaCovqOjcOL=qDuTBpVyvR15vyfA@mail.gmail.com>
Subject: Re: [PATCH 5/9] drm/amdgpu: fix eviction fence and userq manager
 shutdown
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com, 
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com, 
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
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

On Mon, Feb 2, 2026 at 7:51=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> That is a really complicated dance and wasn't implemented fully correct.

I'd suggest elaborating on what was wrong with the previous flow.
It's not entirely clear from the patch.

>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 +++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          | 1 +
>  5 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 02abe85624a6..9cd44be45861 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2976,6 +2976,8 @@ static int amdgpu_drm_release(struct inode *inode, =
struct file *filp)
>
>         if (fpriv && drm_dev_enter(dev, &idx)) {
>                 amdgpu_evf_mgr_shutdown(&fpriv->evf_mgr);
> +               amdgpu_userq_mgr_cancel_resume(&fpriv->userq_mgr);
> +               amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
>                 amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>                 amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
>                 drm_dev_exit(idx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 8fe9f91f9551..ef4da6f2e2a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -146,13 +146,19 @@ void amdgpu_evf_mgr_init(struct amdgpu_eviction_fen=
ce_mgr *evf_mgr)
>  void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr)
>  {
>         evf_mgr->shutdown =3D true;
> +       /* Make sure that the shutdown is visible to the suspend work */
>         flush_work(&evf_mgr->suspend_work);
>  }
>
> -void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr *evf_=
mgr)
>  {
>         dma_fence_wait(rcu_dereference_protected(evf_mgr->ev_fence, true)=
,
>                        false);
> +       /* Make sure that we are done with the last suspend work */
>         flush_work(&evf_mgr->suspend_work);

Is it intended to flush the work here and in amdgpu_evf_mgr_shutdown()?

Alex

> +}
> +
> +void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +{
>         dma_fence_put(evf_mgr->ev_fence);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> index 527de3a23583..132a13a5dc1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -66,6 +66,7 @@ void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction=
_fence_mgr *evf_mgr,
>                                  struct amdgpu_bo *bo);
>  void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
>  void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr);
> +void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr *evf_=
mgr);
>  void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index e007f10a6c1c..60e8a993557a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1350,13 +1350,16 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr=
 *userq_mgr, struct drm_file *f
>         return 0;
>  }
>
> +void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +       cancel_delayed_work_sync(&userq_mgr->resume_work);
> +}
> +
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  {
>         struct amdgpu_usermode_queue *queue;
>         unsigned long queue_id;
>
> -       cancel_delayed_work_sync(&userq_mgr->resume_work);
> -
>         mutex_lock(&userq_mgr->userq_mutex);
>         amdgpu_userq_detect_and_reset_queues(userq_mgr);
>         xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 095c09f3d96c..13f4e356728b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -117,6 +117,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm=
_file *file_priv,
>                           struct amdgpu_device *adev);
>
> +void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>
>  int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
> --
> 2.43.0
>
