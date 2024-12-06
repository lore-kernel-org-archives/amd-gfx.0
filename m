Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14494E7717B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 14:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10FC10E023;
	Fri,  6 Dec 2024 14:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UFOdWq4i";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619EA10E023
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 14:37:52 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-7c3d415f85eso142126a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2024 06:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733495872; x=1734100672; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQOlP3X2RFwzzWnDD8TXyNYqP/NfnnvxjdNupYhnIww=;
 b=UFOdWq4ipgC2BE3V/ApmVpKEYDBkx9Q3bf1SYtJ1lwp/MSu8O4voefdvf9Ku4R3Onm
 NdvVfPeHYnLtfcKzOup+/IiWDwbvgHYGNg+Z8RwfPVkFQDFQLqH0sBQt3HnqUYbQLcfl
 Wc/B+3puN+VFltYEARjorKremmnUnnkPwC8EvrxK5yD+gqZMk8sMk07liR/sGAN3XN9A
 X2X/wJnzC1PI98wDM2JM6RVaBPrwC7eY7xjma4MLxawAvwUE8EOJPfLWQtc+bPM4YJIE
 ZVYuVsEG1vW0w9ACTnK7app8QN7IWUidFsDI+cq5ArUhTrDW58EX7qD7ljfKJ6hdTwWT
 EHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733495872; x=1734100672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQOlP3X2RFwzzWnDD8TXyNYqP/NfnnvxjdNupYhnIww=;
 b=LgYHeqmJyC5QGeyFARZ4jJj309gAEiRca8REYVSvTBDOUagDmvkmy/unp13q4QtzhB
 TQlKF0sfqGhfIpm7Kh3QteESlVIDLWdbAVNJDzhr2Mi+bbVCUHxgBwsbmM17f4XUnzY7
 eQJOmPU3ZQZZNKCSNxWYjbsTKKbYZvS6EVNdk0GzKW5BtY6tLS9mwYRmvKbXawhyjinP
 fYo8daDiKZZv7KSHqdb4UIQ888dpNirneZZp13C7ZjUji/mm786+R/X1ax5gfjvG+MD1
 I+wb4w84FXZB2fvEZZJsPgxBUyTAYhbiri6d7qw8aklTETL9vkMQzqdvebPCO4QX7qUX
 y0dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzhEhu8ElE0d3sUfBjU43nSJuuREiwBkPXHgTxh2zXhGAqXMTkCgdcHS1hzklZtXfOr4kvTEHO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkZ8DwX5RfQm8muC2tMpw6voxr835vLtozae6JKL6zL4/Sm1UE
 yXafpGaQ3+mMLv26OwS9Xh3F/2bHQbNRdRIHj1xImAtaZ+mQVjnJVs7hd4mhtd/vNeOKQ1pW0wx
 aZaQwNzRTUeLIopZMV2qQZUAuKWM=
X-Gm-Gg: ASbGncssP3PiBRXahR4aC80VBYYldfhhfKGyU+diGVABVG89IPUz6MFg+dVMUxWXI5k
 WEHChUIlYAZGfsOG4zrNR+x3k7EaLvMs=
X-Google-Smtp-Source: AGHT+IF49iDlmHoAYtUvooLNTSK+GCb8e/dZU1TPHqxmZbNHOOC+6hgox7JcJU6pVd+cCOLdLSRIGBQwCgofQ5wfNYU=
X-Received: by 2002:a05:6a21:7896:b0:1cf:52f5:f5 with SMTP id
 adf61e73a8af0-1e1870a773bmr2409735637.2.1733495871596; Fri, 06 Dec 2024
 06:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20241206143537.2272-1-christian.koenig@amd.com>
In-Reply-To: <20241206143537.2272-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Dec 2024 09:37:40 -0500
Message-ID: <CADnq5_Mvt5nSa-JMDeYbF=hkn_0Mx2xOXohUgL9JWCs2q1kk7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix when the cleaner shader is emitted
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: srinivasan.shanmugam@amd.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Fri, Dec 6, 2024 at 9:35=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Emitting the cleaner shader must come after the check if a VM switch is
> necessary or not.
>
> Otherwise we will emit the cleaner shader every time and not just when it=
 is
> necessary because we switched between applications.
>
> This can otherwise crash on gang submit and probably decreases performanc=
e
> quite a bit.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 68dd4130b5ad..db913d533898 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -674,11 +674,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,
>         pasid_mapping_needed &=3D adev->gmc.gmc_funcs->emit_pasid_mapping=
 &&
>                 ring->funcs->emit_wreg;
>
> -       if (adev->gfx.enable_cleaner_shader &&
> -           ring->funcs->emit_cleaner_shader &&
> -           job->enforce_isolation)
> -               ring->funcs->emit_cleaner_shader(ring);
> -
>         if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
>                 return 0;
>
> @@ -690,6 +685,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,
>         if (need_pipe_sync)
>                 amdgpu_ring_emit_pipeline_sync(ring);
>
> +       if (adev->gfx.enable_cleaner_shader &&
> +           ring->funcs->emit_cleaner_shader &&
> +           job->enforce_isolation)
> +               ring->funcs->emit_cleaner_shader(ring);
> +
>         if (vm_flush_needed) {
>                 trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);
>                 amdgpu_ring_emit_vm_flush(ring, job->vmid, job->vm_pd_add=
r);
> --
> 2.34.1
>
