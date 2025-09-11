Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26418CAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 19:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8BB710EB88;
	Thu, 11 Sep 2025 19:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gyt9Go/q";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E4610E03C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 19:15:51 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-24b150fb800so2037815ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 12:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757618151; x=1758222951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nF2wvtU0ar+MlglgKsQo8QMjQiw+ubjuETRzAGVJyPM=;
 b=gyt9Go/qyfbaqWkbvKSMMBvKSDZYqxLrmuqrcrm6KfOqqf9mbOqMNgha7SNzYHlyHn
 Wd6jFw/k0+Vn8LEjFmB84qRs2p8NXc15mTM0EOi7T0T7HMLQxi585L0Q26zUOA9GN/me
 681esw+Zr/71XB9D92djMI+n2JXz/U9pd89xGJTzo91MCrDZGrvS6kAcUGZ25kztg78R
 vEFVT/+JXs4zspOvod7SSH/rC/WyTlRX3cz3msX47KEdeeutFjxny2qHQPrTAvggoehZ
 bm/xw8/Ifi90oOJI7ZsXa5Z21HqSyjWERG0YtQvB7LQH/Xf5Y6FGEYRm9W1ENWIWJOTb
 Bb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757618151; x=1758222951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nF2wvtU0ar+MlglgKsQo8QMjQiw+ubjuETRzAGVJyPM=;
 b=OJHFzAjR0VYXWLb6Evu0kxH8Reqw4UqX1ORKye10G8oNs0qtjmR3aU347K5uxidX2R
 ZtfXowRFBOA4fEm8aSFkCDoV3bNEoEBlz4Akabrtw/BmzxaL1gar3A+KJf5EpJIrrKXZ
 84RDfpWDp1lqdhTOwKySnzypoFD7bLqnzCL9Bd1QCv1x2DBwC16V5nKj8EM+Qy8QbXki
 lvzbHS69WZWs/2xVpnK8o38e0T7kUACCbA4AP+u9J32rvaPHQV7XWSuIz4YcdecMeG+M
 g2tEWQZOU4fZcZjVuSG6Ll/CDZlIykYF5tjAvZyPLRghxIrNhFcmiJ4WZ5aEWRra0Mzb
 AgKg==
X-Gm-Message-State: AOJu0Yzi9xMgDSRpikVAf8BHLD2VcC6m8qnTyILwxgQuFrWHp3vMv8RG
 9tjgDarfmMBbepOd4lQ6OauM+a29clpHRSrO8MAt7pJVA57jefv/BrBPAO8MBvfZ1K0L1erWrum
 2yXgza5eonG6wQL8R/XVtVHOOa79GZcg=
X-Gm-Gg: ASbGncvTbyY8n6D2hsDFWrq40BH3B2eVQh4TwrJbBda//+7r1eOL8FqiuoJisCpUYZ1
 P4c3/d8i3OEtOZ4WrbkVrICLdXuAadfro7cWKK5ly5tUDAygHxS0tmyo1dklruuY0aZZAbaHALA
 abgf3tKiHK7FCKjt5KEV29kZy8Omgdpi9pLJxeQc/z2c2m5rYk0fm2jXKYsR3XYHdX1zLjEyZEB
 zehvjM=
X-Google-Smtp-Source: AGHT+IFHBsgrLn4NUfOT+SYaFlFCgh/U76Hel2N5Fwym6H7SoY5PxHVG4TrbU6c6IQBBZqN6wM63cAgHCDk7IHldxNQ=
X-Received: by 2002:a17:903:ac5:b0:25c:b66e:9c2a with SMTP id
 d9443c01a7336-25d27c1df3cmr2559985ad.6.1757618150537; Thu, 11 Sep 2025
 12:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
 <20250910113731.2688320-8-Prike.Liang@amd.com>
In-Reply-To: <20250910113731.2688320-8-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 15:15:38 -0400
X-Gm-Features: Ac12FXxjIP6Whz5DAhSpayJx6oE1PbDZM4TTONr8Fa-yPZSNyHWW_kntMo6qk6Q
Message-ID: <CADnq5_OONqSykgfMfR5=E5VS7i6O7Y9UsvQ9f73dchXXWGAwfQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] drm/amdgpu: validate the queue va for resuming the
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

On Wed, Sep 10, 2025 at 7:37=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> It requires validating the userq VA whether is mapped before
> trying to resume the queue.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 31 ++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>  2 files changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 2626a41a8418..fa44a47b2734 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -101,15 +101,12 @@ int amdgpu_userq_buffer_va_get(struct amdgpu_usermo=
de_queue *queue,
>  bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>  {
>         struct amdgpu_bo_va_mapping *mapping;
> -       u64 user_addr;
>         bool r;
>
> -       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SH=
IFT;
> -
>         if (amdgpu_bo_reserve(vm->root.bo, false))
>                 return false;
>
> -       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, addr);
>         if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->user=
q_va_mapped))
>                 r =3D true;
>         else
> @@ -119,6 +116,24 @@ bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm =
*vm, u64 addr)
>         return r;
>  }
>
> +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
> +                                   struct amdgpu_usermode_queue *queue)

All you need is the queue here.  you can get to the vm from queue->vm.
Other than that, it looks reasonable to me.

Alex


Alex

> +{
> +       struct amdgpu_userq_va_cursor *va_cursor, *tmp;
> +       int r;
> +
> +       list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, l=
ist) {
> +               r +=3D amdgpu_userq_buffer_va_mapped(vm, va_cursor->gpu_a=
ddr);
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
>  int amdgpu_userq_buffer_va_put(struct amdgpu_usermode_queue *queue,
>                                u64 addr)
>  {
> @@ -774,11 +789,19 @@ static int
>  amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
>         struct amdgpu_usermode_queue *queue;
> +       struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
>         int queue_id;
>         int ret =3D 0, r;
>
>         /* Resume all the queues for this process */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +
> +               if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
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
> index 3623c8f6899a..cd63f7d79a95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -157,4 +157,6 @@ int amdgpu_userq_buffer_va_put(struct amdgpu_usermode=
_queue *queue, u64 addr);
>  int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,
>                                 struct amdgpu_vm *vm,
>                                 struct amdgpu_usermode_queue *queue);
> +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
> +                                   struct amdgpu_usermode_queue *queue);
>  #endif
> --
> 2.34.1
>
