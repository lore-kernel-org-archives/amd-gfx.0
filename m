Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615C6C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 22:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB6510E0A9;
	Tue,  7 Nov 2023 22:04:04 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DDC210E0A9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 22:04:02 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-586ad15f9aaso3126465eaf.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Nov 2023 14:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699394642; x=1699999442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSMa+zN8sbumqOwToPA8qkYcFWdUVxmYNybrIZQt/1o=;
 b=Q9XXSy6D8ubpwcvcSOK8zwn2NSax/T54t2X9pL3acXTkXt3DxA6oZMsV73X9pC3E0M
 qQWlGlsWsVrelJbmATK9JobL2qak7m4LErOswqwGMPwOA3bkjB8FPujPM27yo89r+7eE
 OnmHFCok1rQgfgvdvGN9RhXANvQTS1zAfr4bevo4fEOrIKOGCoCY+mXmFVxx2EEUUuxf
 6l8VGYONKlp90P4k7XWfPx9hZ18hX5RlgcrXlCCIy+ItJf4nVnvCmucPnKoHzByLsLe1
 E3qp6+J6HQxIaXX7lTSl07h51TPscCWjh6KThrT9tCqry75HYu6Tfw6o1V7IYwrWOGcz
 CTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699394642; x=1699999442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSMa+zN8sbumqOwToPA8qkYcFWdUVxmYNybrIZQt/1o=;
 b=ZmH0v9dxDsxnaSox+hJbFoLhSiLHvvYDu+quhbjFJQOY+COqhgapHmXKLZWHUh/q/e
 afmUvyZJ6fwV23LEpWzGXpE5Y4w9n5x2tTrIOGMJ/gcQBBJX96aZslbI3+ZbxE53f4bw
 eZaVCZmwT5fniChXuO3JO8P44jRXlvZ8MmrZFz4yRAcAuM4QiU2gN+KT4PX4yNtLGBq+
 vcjIRtu1RQ7jxkH1ql2iprw3gq5pTDK57uVnk5Kwje7AIAipaxgiCsDoTifaH+lDjCaF
 OQ+bpDVv9sLCiXkKS1nbS03gg3sKYC8pJ7vz6nh4WRMFh+VxDi+EWwiMglbxmjMJEWrZ
 q73Q==
X-Gm-Message-State: AOJu0Yx5cM2zFqNwvlKsiCUGQ5lmP5BhxaiVjAuuvDPBCrriNuBegE7D
 djAtKvLRP/7FW9RpDSTsXOqtfmC1pu/vOwfa8SU=
X-Google-Smtp-Source: AGHT+IH0RPwtoh2NyJh8+PlB+21yOmmjzWP5ls9Hehphk44yvh0EC4p/RhQDhadvHe3CwzhBpXu639JX1aekCuwUKXk=
X-Received: by 2002:a05:6871:7289:b0:1e9:b653:94d with SMTP id
 mm9-20020a056871728900b001e9b653094dmr8207oac.1.1699394641791; Tue, 07 Nov
 2023 14:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20231106071405.121981-1-lawyiu.dev@gmail.com>
 <4db20aad-c19f-4adf-ba13-97acbdb6ba16@amd.com>
In-Reply-To: <4db20aad-c19f-4adf-ba13-97acbdb6ba16@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Nov 2023 17:03:50 -0500
Message-ID: <CADnq5_PsRK58cfVEf_vP-bv3nsuocx6wAMrKhfjRFpHJSwUMzg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Skip locking KFD when unbinding GPU
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
Cc: alexander.deucher@amd.com, Xinhui.Pan@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, Lawrence Yiu <lawyiu.dev@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 6, 2023 at 6:17=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.c=
om> wrote:
>
> On 2023-11-06 2:14, Lawrence Yiu wrote:
> > After unbinding a GPU, KFD becomes locked and unusable, resulting in
> > applications not being able to use ROCm for compute anymore and rocminf=
o
> > outputting the following error message:
> >
> > ROCk module is loaded
> > Unable to open /dev/kfd read-write: Invalid argument
> >
> > KFD remains locked even after rebinding the same GPU and a system reboo=
t
> > is required to unlock it. Fix this by not locking KFD during the GPU
> > unbind process.
> >
> > Closes: https://github.com/RadeonOpenCompute/ROCm/issues/629
> > Signed-off-by: Lawrence Yiu <lawyiu.dev@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_device.c
> > index 0a9cf9dfc224..c9436039e619 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -949,8 +949,8 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_=
pm)
> >       if (!kfd->init_complete)
> >               return;
> >
> > -     /* for runtime suspend, skip locking kfd */
> > -     if (!run_pm) {
> > +     /* for runtime suspend or GPU unbind, skip locking kfd */
> > +     if (!run_pm && !drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
> >               mutex_lock(&kfd_processes_mutex);
> >               count =3D ++kfd_locked;
>
> This lock is meant to prevent new KFD processes from starting while a
> GPU reset or suspend/resume is in progress. Just below it also suspends
> the user mode queues of all processes to ensure the GPUs are idle before
> suspending. It sounds like this is not applicable to the hot-unplug use
> case. In particular, if there is no matching kgd2kfd_resume call, that
> would lead to the symptom you describe, where KFD just gets stuck forever=
.
>
> What's the semantics of GPU hot unplug? Is it more like a GPU reset or
> more like runtime-PM? In other words, do we need to notify processes
> when a GPU goes away, or is there some other mechanism that ensures a
> GPU is idle before being unplugged?
>

It's a separate PCI entry point (remove() in this case).  From a
driver perspective we quiesce any outstanding DMA and then tear down
the driver.  It's the same whether you are actually physically
hotplugging the device or just unbinding the driver from the device.

Alex

> If it's more like runtime PM, then simply call kgd2kfd_suspend with
> run_pm=3Dtrue.
>
> If it's more like a GPU reset, you can't just remove this lock. User
> mode won't be aware and will try to continue using the GPU. In the best
> case applications will just soft hang. Instead you should probably
> replace the kgd2kfd_suspend call with calls to kgd2kfd_pre_reset and
> kgd2kfd_post_reset. That would idle the affected GPU, notify user mode
> processes using the GPU that something is wrong, and resume all the GPUs
> again. You'd need to be careful about the sequence between actual unplug
> and post_reset. Not sure if post_reset would need changes to avoid
> failing on the removed GPU.
>
> Regards,
>    Felix
>
>
> >               mutex_unlock(&kfd_processes_mutex);
