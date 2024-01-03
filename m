Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89581C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 15:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2AB110E315;
	Wed,  3 Jan 2024 15:19:50 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B075C10E315
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 15:19:49 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bbd6ea06f5so215591b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 07:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704295189; x=1704899989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fV5+0cEZbON1I0dJsxJNU2euqhSOzqc+Oc1fVHAOyEM=;
 b=k+aqYJ3tikd1tWOYSh164n0xgwCxoryjp7X94D/qqRwFFtNsG7zqAz6AltbtGk+ebo
 73nj6xvweN3xuP0vPndZuilzrwJYp4VbU31fqj4oLWizlMJVbWgsihXdH4427tAwNv6T
 r43vuAv3dNGXeiVeJj9U5WpeTxde1iE5tjJprjtMO6uijdh8hUXg16JHnCEr7xVM/Tc0
 LT6sbsj7xI9AfiC6CQe3XJFZ8eHMgHmdRnXAJ/65a4angevoYcWDy4jZzuyhbdNmtGWl
 c9PREmb7LewaIkYZVHFi/4nqqFM43ADQ2qrWdztHyOuQA0xF3QCVct3tzExU4YLQIT/o
 PMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704295189; x=1704899989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fV5+0cEZbON1I0dJsxJNU2euqhSOzqc+Oc1fVHAOyEM=;
 b=DLRypcgt8Tlx27/JpEqEIW3S+yXgeTm0FoAb2BogkAC9k1uFXjwg6r/uq9rZ6YBuut
 spwAgI2ZM6pUwOXkzjTX7t7Dk+gh40bTvWqp8nYkK/uwikFQpNDf8MPQnZKYLG1d6PZv
 5X+TMGvY5dGlzQMgZpVC1cSZbZW4oo9z+IA/HBGJajnJC+kV3b9tE/lsIetFzkSgrx28
 HlTUTe0bUa71VWWpAUvo9B92ZzcnlztU0FLCFHtZs/FeWdPShk7AoH9wAj21UsxukdQS
 YHSo/hUGsMKjThCVjB+01ievNQAbLnMBKOtOcY6yesx9DoYnq03ydX6+oFvO4sb1yM7g
 iNDA==
X-Gm-Message-State: AOJu0YxQOCU0/TX2SITtR3WI+/33jlT3g6CH+EtEufYD8zA3l9JQb0q5
 LYjGEvrL3Lcoy89G7JBi/3nalizfkM7VqWwFcp0=
X-Google-Smtp-Source: AGHT+IEu/54M5jN/9UQuNqf5vS3E6nClg5SC4c8sBD9+nJzwUC5FztbqlVv7lt0bZJTqdSgqccy95oJu1hk1u4DH/uE=
X-Received: by 2002:a05:6808:4248:b0:3bb:c393:4963 with SMTP id
 dp8-20020a056808424800b003bbc3934963mr392500oib.17.1704295188919; Wed, 03 Jan
 2024 07:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20240103043000.23971-1-ent3rm4n@gmail.com>
In-Reply-To: <20240103043000.23971-1-ent3rm4n@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 10:19:37 -0500
Message-ID: <CADnq5_NexkgrEKbM39QVGo+hOmd2G0Yc0sui3jWuJsKAyb3ONg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of
 VM hole"
To: Kaibo Ma <ent3rm4n@gmail.com>, Jay Cornwall <jay.cornwall@amd.com>, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
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

+ Jay, Felix

On Wed, Jan 3, 2024 at 5:16=E2=80=AFAM Kaibo Ma <ent3rm4n@gmail.com> wrote:
>
> That commit causes NULL pointer dereferences in dmesgs when
> running applications using ROCm, including clinfo, blender,
> and PyTorch, since v6.6.1. Revert it to fix blender again.
>
> This reverts commit 96c211f1f9ef82183493f4ceed4e347b52849149.
>
> Closes: https://github.com/ROCm/ROCm/issues/2596
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2991
> Signed-off-by: Kaibo Ma <ent3rm4n@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 26 ++++++++++----------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/d=
rm/amd/amdkfd/kfd_flat_memory.c
> index 62b205dac..6604a3f99 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -330,12 +330,6 @@ static void kfd_init_apertures_vi(struct kfd_process=
_device *pdd, uint8_t id)
>         pdd->gpuvm_limit =3D
>                 pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>
> -       /* dGPUs: the reserved space for kernel
> -        * before SVM
> -        */
> -       pdd->qpd.cwsr_base =3D SVM_CWSR_BASE;
> -       pdd->qpd.ib_base =3D SVM_IB_BASE;
> -
>         pdd->scratch_base =3D MAKE_SCRATCH_APP_BASE_VI();
>         pdd->scratch_limit =3D MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>  }
> @@ -345,18 +339,18 @@ static void kfd_init_apertures_v9(struct kfd_proces=
s_device *pdd, uint8_t id)
>         pdd->lds_base =3D MAKE_LDS_APP_BASE_V9();
>         pdd->lds_limit =3D MAKE_LDS_APP_LIMIT(pdd->lds_base);
>
> -       pdd->gpuvm_base =3D PAGE_SIZE;
> +        /* Raven needs SVM to support graphic handle, etc. Leave the sma=
ll
> +         * reserved space before SVM on Raven as well, even though we do=
n't
> +         * have to.
> +         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so that=
 they
> +         * are used in Thunk to reserve SVM.
> +         */
> +        pdd->gpuvm_base =3D SVM_USER_BASE;
>         pdd->gpuvm_limit =3D
>                 pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>
>         pdd->scratch_base =3D MAKE_SCRATCH_APP_BASE_V9();
>         pdd->scratch_limit =3D MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
> -
> -       /*
> -        * Place TBA/TMA on opposite side of VM hole to prevent
> -        * stray faults from triggering SVM on these pages.
> -        */
> -       pdd->qpd.cwsr_base =3D pdd->dev->kfd->shared_resources.gpuvm_size=
;
>  }
>
>  int kfd_init_apertures(struct kfd_process *process)
> @@ -413,6 +407,12 @@ int kfd_init_apertures(struct kfd_process *process)
>                                         return -EINVAL;
>                                 }
>                         }
> +
> +                        /* dGPUs: the reserved space for kernel
> +                         * before SVM
> +                         */
> +                        pdd->qpd.cwsr_base =3D SVM_CWSR_BASE;
> +                        pdd->qpd.ib_base =3D SVM_IB_BASE;
>                 }
>
>                 dev_dbg(kfd_device, "node id %u\n", id);
> --
> 2.42.0
>
