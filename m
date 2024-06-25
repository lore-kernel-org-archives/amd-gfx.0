Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36C5C2BBCA
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jun 2024 17:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A6410E6F9;
	Tue, 25 Jun 2024 17:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RxOMOCRz";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD76F10E6F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jun 2024 17:44:27 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1f480624d10so47978495ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jun 2024 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719337467; x=1719942267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SS3V0C+18fww8zA/48pi1hh4msNYL1IHOzJTe1sKwyk=;
 b=RxOMOCRzHgEbvNZj4JKK0D+9DkXTs/0sNT3lu1om/8Xd8UdHL5JDvur85YTR5nC74U
 KW2jDU0mmfPG25Uj1Gdy2ZKm/7sylGNbZkTC5jPOE6kck7x5coixr9ZfxQTnkEvHnrMf
 59yyvYeOOc6JklpLYI1cqQkfOhAUaWzk9tc8ixoI+9L2IkJI/p1/fno3vcgRZGK+nTrO
 BVvviJL8OABcR8cejG0QZcFS573yCTj5ku+22vY9UgS2JO4ReCBJnJBUh69DmtqXo56L
 rV0uVvwN+jodUHBgxWyGs/LwVI+Bx/LnUJhO/pcbVrK7Ln/gEjLQfF8FUVyCxy8Qp3HU
 UL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719337467; x=1719942267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SS3V0C+18fww8zA/48pi1hh4msNYL1IHOzJTe1sKwyk=;
 b=pf87iWLoX5EITaXZ4KfKsQIt52GXzNXtF4/QCfsMP7mNwztCdl4nbRFjfuk2NLp3gN
 XwG65bRhzKEDjvCielYMN06ylTQ5Oiip7BirrnEIt3iQDOMZLbwUGsezhzbZFgXSILQQ
 0Qfb8mZGhr7nHKqHiX+Y4MMOObFx/g6Y3c75zqhg33Zqh/QFafG/bs+Ca8GuYu/TwHAP
 +n2X/JJWUsXfEapgnUxg+wZOa2+ckZLCXpeAV3ZykSAf7qmzWIGXFAEqK/3GNxbLfXSv
 FUEx6OsPHhZhpKYB93Cbpab+zWA8urDnBVGQ5lHN46ktvT8evPU1aZ2jxkBveKi2lXG2
 37Og==
X-Gm-Message-State: AOJu0YxLuGa8sbnSBI7mLVwF3YttYnIbg7AZhhzR0pX+oqt0wR2X8sTb
 CkmMRznMlnGNRe0zw8kbiWmdpR0m49dZF64XgOAvHI/5Rfqo+fNqx89qrtblUfHgGaRTuB3h92J
 xjXeG8u60+BHZRWLBrCgklmCZ4kPmqw==
X-Google-Smtp-Source: AGHT+IHxA76yH8m5cKsSjRCNqAMo9TWWgkvgCdBnKJLaHAvJkAb63dKct9u2rTTKJwKBbaEHsmru6VN1MyeLKEncDGM=
X-Received: by 2002:a17:902:e812:b0:1f7:1ba3:b91c with SMTP id
 d9443c01a7336-1fa1d3de7cbmr105624455ad.1.1719337467173; Tue, 25 Jun 2024
 10:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240625142418.156810-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20240625142418.156810-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jun 2024 13:44:15 -0400
Message-ID: <CADnq5_N+ofUFOWhDvKkWSy2zXYMHaHHD0m63hAPLs4EG6mTVzw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: check bo_va->bo is non-NULL before using it
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 alexander.deucher@amd.com
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

On Tue, Jun 25, 2024 at 10:32=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> The call to radeon_vm_clear_freed might clear bo_va->bo, so
> we have to check it before dereferencing it.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 3fec3acdaf28..27225d1fe8d2 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -641,7 +641,7 @@ static void radeon_gem_va_update_vm(struct radeon_dev=
ice *rdev,
>         if (r)
>                 goto error_unlock;
>
> -       if (bo_va->it.start)
> +       if (bo_va->it.start && bo_va->bo)
>                 r =3D radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo.res=
ource);
>
>  error_unlock:
> --
> 2.45.2
>
