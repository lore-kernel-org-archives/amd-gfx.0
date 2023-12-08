Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3DCC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 21:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4383110EB3A;
	Fri,  8 Dec 2023 21:32:38 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770F610EB3A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 21:32:36 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6d9d59d6676so1668765a34.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Dec 2023 13:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702071155; x=1702675955; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIY4k+sxPPmWyf+e8n9SG8gARJRleKd044+N96teJrw=;
 b=dMpMSArwjS6k3Q/0EmJqTZYe8Ksy1SCv4wo9hT+rD3VbDj6FXCS59WjyBl20SG0Hwe
 t5vLGkVjBnsVxXBW/Uyg91vMBXHaVwG07hwpI+ERyO9ZuSh4ZuBuSqh4xvKMG40IT0HC
 ujFRhtEJ2EiDt63C0/3OH9jYPlhKwHO0+IohvcmUR+MYyxn/Pk6HSo0eGvufw48G2rZm
 1JR1c6nGbLJQ9TrX222a7Hh67u04Cwjvn0j2dIxM+WYnhmHrkYLqU30ekkrljwPdr2ls
 osZ6rmgDClydufIZWW0WJHPGxM6ZQc3Yz8OqBkPLS+ey/SnXK3B4oKt/i/3BICnEcpqA
 JJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702071155; x=1702675955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIY4k+sxPPmWyf+e8n9SG8gARJRleKd044+N96teJrw=;
 b=BYs8o4WiJuSsJ2zfkFgK0Kd/aAYrZrua6Wwvgo3PkZItshubgvkuxFxB04DiKQuX01
 1Hf6zhUpP1ZBcLTLrCoqc9w0Z5FeDZUMYVptRQE7sxM+pmcnp9IHScsMkndQKp1Pm96s
 GUjlswJytkeKpzcif3yLWRD/Jqm3AtsDiVncly6M12fLvbobGDo/zDMiZ4K5qYlAq+Uz
 GqULytmLfoxowwCxt5vKD2jJv5Tl+K699hsNQ/Ed2zpN7U7IEuPUjH+vUGP8jZ5KSzwC
 b2tPknOUbn1zBLH+fcTPV19dd554X7hQpwe8P6mFX5HQLhPHgWmCiq+BFp3K94zpp2ba
 SAew==
X-Gm-Message-State: AOJu0YyYbejrR2z+8mCv1bcTzbx+5VDQiNN/8RcToiQQxG4TBnNvrUFx
 Z2KNroZWsUUsmT/kigdTibStobt1qhHupWVYnEw4Z2fP
X-Google-Smtp-Source: AGHT+IF72SWaPkNr8mufNUvPI5baDZDHPcbpP/kzqDT0QES6xwjNk5uXH/qoZqcCguyKK7iGWMnnDG8b8cQQXqoP7ag=
X-Received: by 2002:a05:6871:7a83:b0:1fb:75b:2fb1 with SMTP id
 pd3-20020a0568717a8300b001fb075b2fb1mr696122oac.72.1702071155589; Fri, 08 Dec
 2023 13:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20231208125520.2278-1-christian.koenig@amd.com>
In-Reply-To: <20231208125520.2278-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Dec 2023 16:32:24 -0500
Message-ID: <CADnq5_NE70yh9+0JhzSJNT=Mb8r6gErZiG6fVrAkqnjoo-UyRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix tear down order in amdgpu_vm_pt_free
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 8, 2023 at 7:55=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> When freeing PD/PT with shadows it can happen that the shadow
> destruction races with detaching the PD/PT from the VM causing a NULL
> pointer dereference in the invalidation code.
>
> Fix this by detaching the the PD/PT from the VM first and then
> freeinguthe shadow instead.

typo.  Should read:
freeing the shadow.

WIth that fixed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/2867
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_pt.c
> index a2287bb25223..a160265ddc07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -642,13 +642,14 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_b=
ase *entry)
>
>         if (!entry->bo)
>                 return;
> +
> +       entry->bo->vm_bo =3D NULL;
>         shadow =3D amdgpu_bo_shadowed(entry->bo);
>         if (shadow) {
>                 ttm_bo_set_bulk_move(&shadow->tbo, NULL);
>                 amdgpu_bo_unref(&shadow);
>         }
>         ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
> -       entry->bo->vm_bo =3D NULL;
>
>         spin_lock(&entry->vm->status_lock);
>         list_del(&entry->vm_status);
> --
> 2.34.1
>
