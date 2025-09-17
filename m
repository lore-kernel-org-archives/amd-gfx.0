Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66028CAC599
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 13:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AEE910E611;
	Wed, 17 Sep 2025 13:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OarR96Zr";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A20110E611
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 13:52:28 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-32da2bd7044so772125a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758117148; x=1758721948; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VY0vVHXUdremw05fYdAPQlJObtRC8ItzIqCdEyuk/vU=;
 b=OarR96Zrb8ovlYYJCgLA9KkoE/TEZXLqz2xd25NGOp1xXryTLwjYreaoiU8Nommydm
 qm0bqK4DLtBY25dXwN9/c0jYm4UPIna5GKpoyue4S/lqgZSccTjn+DGCQcQvX6B/bVa1
 GAPKGP6lZuf8VyiFv/sZY7gA9qlA3dkBhaNmg3vSZrJg/s9LbOXAqc3iTmNltQgkcwfQ
 8yMhk5a//ej6gB41rLh8Cb9chG3DKxKmv/S3QItbe5LANZruR/vbTdPgGRH7yWw16HXt
 FV+j6dH/JydWRRKf+e/LrO8WyO1VNPuNM1Oqz3E9dAs4BKQyAzrFfKFxpJu/N6VqZ9bU
 Z3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758117148; x=1758721948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VY0vVHXUdremw05fYdAPQlJObtRC8ItzIqCdEyuk/vU=;
 b=unQg3Y8LbsnXgM1VHGlwmZ0lf9RJ3IEdUiN+d1UBnpWgw288/dH0kr412oS9eHULKe
 UbiatMaCxEFj85d839OBIC2pwYx+kXO7joORPc5nf+g+xG9uqHmVuJqUqyPuyY6FEffC
 C3Cxuf/oqkw1ANFGrTp+qlmOnt2rxR8/1TAt+Ls6MGgMMLV8GixFmlJWt0dV/KpQYvpE
 sbcXFdE8UuuCKj6czZFSkEUTyxxtMvCitSDWmNU4RFXmpK3EwINm/d4EJIQuVPQvwM42
 nRjSeevvbmSIyWafueanRZBPuqrrE/D0YGtKyep+tjyUkt8jZRNDs+pMz/uUEVZ8tvXb
 KrGg==
X-Gm-Message-State: AOJu0YyFm0brZmOZ1tO+hp+RV3Fvf/94vTspQRi6tVME0TZ0eNunQpKr
 beTwejySh8Y6z/TJlfD3QMYaLrM5eiSQ/2Fa5z20Jv/1Nu0m8oNs3oeU5S14toKsDpfZd3+FTHV
 9Cvzz9ZDpigj1GNxv4XckKXFuuxJsj60=
X-Gm-Gg: ASbGncs05YoXN3uZLMrQ7saR1EhMUFECXkcNk82TBCy6w3v4lndy+KasZdOgE4pDXue
 OtaDwmiURl+EPEa/lDJjunixA2xqnUYEfOVch/yX5cmaucYCDGeXGySl0wsc+I5vVhoTRE9kXe5
 PGSzwBkgORDMOUlXcgRkIevDVJy71aEHgtK2jXSQrRsM+psXCxS5j+jwbXw8xjSFKbz3E4cRlbU
 6U4h/0F
X-Google-Smtp-Source: AGHT+IHle2oX2ycamrElXOiu/ZUYUj7rC66rhF0PdYPGyQ75YS7lnzb2G6nJgT3tCVw+FXu212PTOhvKxjwdyrM5fRk=
X-Received: by 2002:a17:90b:1c01:b0:32e:731c:4136 with SMTP id
 98e67ed59e1d1-32ee3fb97f2mr1481437a91.8.1758117146909; Wed, 17 Sep 2025
 06:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
 <20250912055518.2719533-4-Prike.Liang@amd.com>
In-Reply-To: <20250912055518.2719533-4-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Sep 2025 09:52:15 -0400
X-Gm-Features: AS18NWCGaJM_B6ZzIwg-XuZ0Mto4hQMU60Fi-wmucjYdEq1kGxHuUCPiOFH8HZs
Message-ID: <CADnq5_PN0n-mWLSfDrX5RPf=DEbgx5E-LPNDYtdN2JCg-To1nQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] drm/amdgpu/userq: extend userq state
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

On Fri, Sep 12, 2025 at 2:14=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Extend the userq state for identifying the
> userq invalid cases.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 83f0ecdaa0b7..ba7be4db5a01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -576,6 +576,8 @@ amdgpu_userq_query_status(struct drm_file *filp, unio=
n drm_amdgpu_userq *args)
>                 args->out_qs.flags |=3D AMDGPU_USERQ_QUERY_STATUS_FLAGS_H=
UNG;
>         if (queue->generation !=3D amdgpu_vm_generation(adev, &fpriv->vm)=
)
>                 args->out_qs.flags |=3D AMDGPU_USERQ_QUERY_STATUS_FLAGS_V=
RAMLOST;
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_INVALID_VA)
> +               args->out_qs.flags |=3D AMDGPU_USERQ_QUERY_STATUS_FLAGS_I=
NVALID_VA;
>
>         mutex_unlock(&uq_mgr->userq_mutex);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 2260b1fb8a22..33a582200dda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -37,6 +37,7 @@ enum amdgpu_userq_state {
>         AMDGPU_USERQ_STATE_MAPPED,
>         AMDGPU_USERQ_STATE_PREEMPTED,
>         AMDGPU_USERQ_STATE_HUNG,
> +       AMDGPU_USERQ_STATE_INVALID_VA,

Split this patch into 2 parts, one to add the new queue state and one
to update the query status IOCTL.  Then move patches 1-3 and the query
status part of this patch to the end of the series so that we can land
the validation code while we work on adding query status to mesa.

Alex

>  };
>
>  struct amdgpu_mqd_prop;
> --
> 2.34.1
>
