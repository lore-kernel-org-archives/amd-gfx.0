Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03F4CD6E4A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 13:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D4210FF78;
	Fri, 29 May 2026 13:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qJLW/RcW";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E05510FF78
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 13:53:56 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304cf9a02f9so231209eec.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 06:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780062835; cv=none;
 d=google.com; s=arc-20240605;
 b=KveD2OKupQYnuOQzBXbrpoh7C9gmNA+AhZjGmtoEZKA7RwJ2ZpBI7im/e3tWLQYeO1
 N9cMg+YqKosA7xWYoAO6OgC5qvxy8F+BUK1FfH/ezVKdoINSKBSFsB124wunrsHtwhpI
 RVTilqsFumGrOandQ2wkovEfVRjQxnvK/gI6N6NwDHerstbi+Fh5PEBwvnA6/gObW7Mc
 peJqbd0an2ueHRuN9pENYiLTuxwUP3wKl8jwMCK9HtloJhMZFuRPtWift7KMxMNsnmtI
 XTeEYqBX3rqg62plLdlHedrVkoJUj74pTil1dW9tmyFoVVs2gZjIv4ADk95A6PA90KRD
 RCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/cI1vJ78aR+YejF3lLdQizJWnc8ohIpsIq/Ifv181ro=;
 fh=PhCGDoLFYU3pW02okGmSl//bIdTEhu1mm1IJmsKNSXk=;
 b=QE+aRkwKQypxNi+qlpXaq5+oR1jPKbsQfSaonZqI3DiANmMA62bMjnxEVoZ/BepIA3
 CTMJTbk4ONWP36JsswbkHc9Tk5aLEaCdOWmE3Wi1/sS1JKNTVty1o1JkQ0irubXqg7sq
 HYFIK32e3eeXUZ85Ci7vhCLmlRiunA1VcK9yyfHLVLGafDjrRt5+edJrI3IIUD4nY6Ly
 UkH0eDRTmH8eKkr6CGjq1/WAh7MdiGOU+9hnAbNXjE0KwZExVT8IWQf2hKGg29gQHYqf
 +RDLGNa/EVvoGmH83/FhbkovQ24V4oBdfTag0cJR7sYC0W9sJvf7U5n29YzMRP6gyDoR
 KUVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780062835; x=1780667635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/cI1vJ78aR+YejF3lLdQizJWnc8ohIpsIq/Ifv181ro=;
 b=qJLW/RcW2CdBB6CeTgdwdczWQguX41NENLAq5F8vgSWnnbOqY+fnArk5B/8qdMTPIe
 ezeD6bSPfezpiFUujukSS7ESmzQY+c+6F2hVuCus0W9+IVhjc8zc9eDN3Xhb1i8yYZgA
 VHx9CCdk5THIZqVAQPShgU/qB7D40oZICR87WcZjqVs+zyICKD24ezDTpZPyZC3uzIXh
 Oug8EvhQNSWwVkR51pLgBZJ5g0NikFRq0Xei0qqmVhGL6dTDDxvB8cmFN8DyYAxY+xFx
 bIFhPs8DwH+29E/0KpCqoAnawFx0lhESFYeZcyXON7XSMvbb1H2+YrSb5XNSww7DLr1O
 NGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780062835; x=1780667635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/cI1vJ78aR+YejF3lLdQizJWnc8ohIpsIq/Ifv181ro=;
 b=rfUnvsyVMpvIinur+hy1wTLaNJgak9SE0s7hA5AIG8bLQ12qC1eCuNiQ+nzGlWyS5r
 rV7SVuxRLfkI6SwLONBpZeYzJxwsH13hVCiCP+J3DeYlj387jX+jjwEL6y3GiOIqqrZF
 exncg+zlM1akha5srkg/oUpARRsI5aspkG+yhivE3XhpUoIhcXjYte23ND8CfeRjuizS
 NaVYezi+uEreD7WGNpnrB0DW0U5risz695yYPshj83oL8sUbWT8NmIAJkwCdOqJ2JpsF
 xjrsveOShIVT9l9PlGXo2a5Qb9GH0cO3W3HPg4MTVeIgGyH6mZ+oaJutYdSE10kBgqXs
 7Lfw==
X-Gm-Message-State: AOJu0YxMW2mvLSUPxtAI98gIzUxn0beOfxEn9l+yN6+Bx4Nh4y5etIzI
 Ng+QFFoJ8DRMUaj3rG8a9RUY56FzdR9ZjQLkjOzb8SIFFRB2DjEnWhwjUyWV9HHo7pl0WDHNn9O
 yqXXE73w/Y9EqZw4/CpVJiBWqpwqpDD4=
X-Gm-Gg: Acq92OHXB5AgyL8R7zeqzkZGUgNia44FX30a4JiLX5Mp600GYsf7ELdh6mWww+4M4s+
 ZZc4p9g+lM9ePUMyzU204aABaIHmCTtFZ18VsLpkLG5OU2D2+STjJXfUatYOeu672kYad1tEee9
 2DYOTqU9oJrYr11iI/ZQPOgZjzoZaH9VgEnn6n9qykL3zjnT6kLUKw7ATbDsJkrhL/Wn1bcTKSP
 d6Mz5Gnl5z4u0V8Uxw/FOtw+tcNTog1cbjk56yL6WhWqzZAE6QfTY4c/+mge7UtWEvweTD+mQd8
 kVcgHUJKPvbFIOP5uZysoeCFV5yeaSz3wZGGzqgWGTlcQ6V2gbn9ESppmGNIWcOCrHpekB0XhO4
 4SHcyDSfTi1NJ400=
X-Received: by 2002:a05:7022:785:b0:12c:897a:5219 with SMTP id
 a92af1059eb24-137af10897dmr489258c88.5.1780062835452; Fri, 29 May 2026
 06:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260529092322.81977-1-tvrtko.ursulin@igalia.com>
In-Reply-To: <20260529092322.81977-1-tvrtko.ursulin@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 May 2026 09:53:43 -0400
X-Gm-Features: AVHnY4Ik2gqLDh3-e28buVnkDgPch6LWZ5zs5TAt3VQ__Cr-omjbLHuuHHTWDbU
Message-ID: <CADnq5_OjFSSuyr+XSUczspwfYcuM39EkU5hHBBmO4Qx0mC4QrQ@mail.gmail.com>
Subject: Re: [PATCH] amd/amdkfd: Fix profiler lock init order
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, 
 Benjamin Welton <benjamin.welton@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
 Kent Russell <kent.russell@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
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

On Fri, May 29, 2026 at 5:23=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
> A call chain at driver probe exists where profiler lock is used before it
> is initialized:
>
> [   12.131440] kfd kfd: Allocated 3969056 bytes on gart
> [   12.131561] kfd kfd: Total number of KFD nodes to be created: 1
> [   12.132691] ------------[ cut here ]------------
> [   12.132703] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> [   12.132705] WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x616/=
0x1150, CPU#0: (udev-worker)/569
> ...
> [   12.133051] Call Trace:
> [   12.133055]  <TASK>
> [   12.133059]  ? mark_held_locks+0x40/0x70
> [   12.133068]  ? init_mqd+0xe1/0x1b0 [amdgpu 5154987db73e842b9b4f761e2bd=
86e17c7ada65c]
> [   12.133671]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
> [   12.133683]  ? init_mqd+0xe1/0x1b0 [amdgpu 5154987db73e842b9b4f761e2bd=
86e17c7ada65c]
> [   12.134235]  init_mqd+0xe1/0x1b0 [amdgpu 5154987db73e842b9b4f761e2bd86=
e17c7ada65c]
> [   12.134781]  init_mqd_hiq+0x12/0x30 [amdgpu 5154987db73e842b9b4f761e2b=
d86e17c7ada65c]
> [   12.135340]  kq_initialize.constprop.0+0x309/0x400 [amdgpu 5154987db73=
e842b9b4f761e2bd86e17c7ada65c]
> [   12.135898]  kernel_queue_init+0x44/0x80 [amdgpu 5154987db73e842b9b4f7=
61e2bd86e17c7ada65c]
> [   12.136439]  pm_init+0x70/0x100 [amdgpu 5154987db73e842b9b4f761e2bd86e=
17c7ada65c]
> [   12.136984]  start_cpsch+0x1dc/0x280 [amdgpu 5154987db73e842b9b4f761e2=
bd86e17c7ada65c]
> [   12.137525]  kgd2kfd_device_init+0x70f/0xd10 [amdgpu 5154987db73e842b9=
b4f761e2bd86e17c7ada65c]
> [   12.138070]  amdgpu_amdkfd_device_init+0x172/0x230 [amdgpu 5154987db73=
e842b9b4f761e2bd86e17c7ada65c]
> [   12.138618]  amdgpu_device_init+0x246a/0x2960 [amdgpu 5154987db73e842b=
9b4f761e2bd86e17c7ada65c]
>
> The human readable call chain is:
>
> kgd2kfd_device_init
>   kfd_init_node
>     kfd_resume
>       node->dqm->ops.start
>
> Where start can be start_cpsch, which calls pm_init, etc, which ends up
> calling kq->mqd_mgr->init_mqd, which takes the profiler lock:
>
> init_mqd()
> {
> ...
>         mutex_lock(&mm->dev->kfd->profiler_lock);
> ...
>
> Fix it by initializing the mutext at the top of kgd2kfd_device_init().
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: a789761de305 ("amd/amdkfd: Add kfd_ioctl_profiler to contain profi=
ler kernel driver changes")
> Cc: Benjamin Welton <benjamin.welton@amd.com>
> Cc: Perry Yuan <perry.yuan@amd.com>
> Cc: Kent Russell <kent.russell@amd.com>
> Cc: Yifan Zhang <yifan1.zhang@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index c2c59781feee..1c57e11220a7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -736,6 +736,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>         int partition_mode;
>         int xcp_idx;
>
> +       kfd->profiler_process =3D NULL;
> +       mutex_init(&kfd->profiler_lock);
> +
>         kfd->mec_fw_version =3D amdgpu_amdkfd_get_fw_version(kfd->adev,
>                         KGD_ENGINE_MEC1);
>         kfd->mec2_fw_version =3D amdgpu_amdkfd_get_fw_version(kfd->adev,
> @@ -936,9 +939,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>
>         svm_range_set_max_pages(kfd->adev);
>
> -       kfd->profiler_process =3D NULL;
> -       mutex_init(&kfd->profiler_lock);
> -
>         kfd->init_complete =3D true;
>         dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->ven=
dor,
>                  kfd->adev->pdev->device);
> --
> 2.54.0
>
