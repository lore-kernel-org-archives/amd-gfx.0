Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EA5C7EE26
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 15:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04AB10E4C6;
	Wed, 10 May 2023 15:02:43 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF85910E4C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 15:02:41 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3909756b8b1so2300442b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683730961; x=1686322961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbfqfiDwtGCZvQv/p0gEu5UQDR/t48k5wMxIoqLQcIQ=;
 b=owr9Pg2CIrwVdSw/Rbkedq0SZKhC3fn8WoZR71O4jm/5LNCm+60ATQWpn4ZuMga50l
 iyS6DC0CGhg59Y2hzs1qLOwU4+4ip/WSqs6ND39Zu9z1covPobmV0QCym6PTg/OvPgPY
 Tu38FR+jNYVbAQqX5oe7QhWyLi1NeRpkWNJ5aC3c6Xa/po5eorVz55ZHPurRozMPxXoZ
 2OCKgeWPi71id5GvQhWW2LEwO/dkt8dF7BW7G3+TXyqjYmRcMME6he7WLJKJstsixY/4
 MNdiygAZK7fko7dXf+ZdwTCD79S81Ymr8ou+QAZg5E3YLzeDhFM5Yc8AOPShpTsBwTZt
 T/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683730961; x=1686322961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JbfqfiDwtGCZvQv/p0gEu5UQDR/t48k5wMxIoqLQcIQ=;
 b=N4bxLhl6gTTWj3C/tx+XlqxOyW5HesMaE5csW0trTf3dqK6nJyCmzyp0FiIB1XQEVI
 2mRgvId8saLRFtLGa/zMnhYp8Pv3bEZ+F8diJdBeHbvUhdfzacXj8PLPUt7vdnzp3QwM
 lGAobdsFZ3COj06ENY8EjTSBZ0lP3n8Ho0oRyxi4F/3VVJWUqBwNj5SKziboyRHgNE/u
 sUf/Zea3aMedZ0sDWVAp4grPSs1l1oRgqCX6Q7rcNSoMIkK4rEF5KEUZXfvUisQa7tIf
 z42nR6Svdce2hAUccNEzCAn8PR1xUntImm/UsJ3Tyb4bnxLtMbMCM9CKwExueVueFUQT
 JdWg==
X-Gm-Message-State: AC+VfDw/iYrwvwYbuNxVH64FGHdIxRVH/cL5zl/ZFHCoSzkkN5FkGRLs
 vG+X1ZoJxVYFe8fNh0RVQmf++o1tZgt9zhZACzQ=
X-Google-Smtp-Source: ACHHUZ5uCdK3dPaqOUYsv5IZefIu3K1NZ2DTgp49rYI9oe2KngVbTA0GNvOA/w8jgtZnhoeYxa2LW4iGGf9RueFiqiw=
X-Received: by 2002:a54:458e:0:b0:394:2cbf:28ce with SMTP id
 z14-20020a54458e000000b003942cbf28cemr1015397oib.35.1683730960537; Wed, 10
 May 2023 08:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230509221738.477282-1-alexander.deucher@amd.com>
 <20230509221738.477282-2-alexander.deucher@amd.com>
 <d6475a52-c420-f6dd-81a2-30c9e047cddf@amd.com>
In-Reply-To: <d6475a52-c420-f6dd-81a2-30c9e047cddf@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 May 2023 11:02:29 -0400
Message-ID: <CADnq5_OGNQO4Oad1BJv_bUNDXULJKngxq4LSrsC10Vn52iUJOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Remove skiping userptr buffer mapping when
 mmu notifier marks it as invalid
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 10, 2023 at 11:00=E2=80=AFAM Felix Kuehling <felix.kuehling@amd=
.com> wrote:
>
> Am 2023-05-09 um 18:17 schrieb Alex Deucher:
> > From: Xiaogang Chen <xiaogang.chen@amd.com>
> >
> > mmu notifier does not always hold mm->sem during call back. That causes
> > a race condition between kfd userprt buffer mapping and mmu notifier
> > which leds to gpu shadder or SDMA access userptr buffer before it has b=
een
> > mapped to gpu VM. Always map userptr buffer to avoid that though it may=
 make
> > some userprt buffers mapped two times.
> >
> > Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> > Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> This patch is no longer needed and should not be applied. It was
> originally applied to amd-staging-drm-next as patch
> fcf00f8d29f2fc6bf00531a1447be28b99073cc3 in November 2022. This fixed a
> race condition due to incorrect assumptions about the mmap lock and MMU
> notifiers. This hunk was added back by my later patch f95f51a4c335
> ("drm/amdgpu: Add notifier lock for KFD userptrs") in December, using
> our own notifier lock that doesn't suffer from those races.
>

Thanks.  Dropped.

Alex

> Regards,
>    Felix
>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ----------
> >   1 file changed, 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 58a774647573..40078c0a5585 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -1942,16 +1942,6 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
> >        */
> >       mutex_lock(&mem->process_info->lock);
> >
> > -     /* Lock notifier lock. If we find an invalid userptr BO, we can b=
e
> > -      * sure that the MMU notifier is no longer running
> > -      * concurrently and the queues are actually stopped
> > -      */
> > -     if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
> > -             mutex_lock(&mem->process_info->notifier_lock);
> > -             is_invalid_userptr =3D !!mem->invalid;
> > -             mutex_unlock(&mem->process_info->notifier_lock);
> > -     }
> > -
> >       mutex_lock(&mem->lock);
> >
> >       domain =3D mem->domain;
