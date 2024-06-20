Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AA4C2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 14:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BC310E0C5;
	Thu, 20 Jun 2024 14:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m4Ypr3X1";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 051DA10EA67
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 14:59:26 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2c7fe2dcdf6so408837a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718895566; x=1719500366; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPXcVfUr1j+fLb6lIJUVnoCOekS7kyqi+VwHKDiK3x0=;
 b=m4Ypr3X1N5Gfj4SoHm/xby4Wpf5y6Qhl34PusFkWK9Yzm5GLPD/XzcZMml6k4QyjrY
 HmDQDld7oN9PkkN88cqv0+t1nZBmXKqsYdBZUJ07MuD6vdERn6jZfeI3jX/TZ2mUOqGo
 93Sh8PebmU1QEYF9o9H01BDuyIOSWuz5Hl1geLsgs5gmxfrFpenRtF1oe1B76qBpFN4e
 FsjNRjl6xDrOCt0JOEmn/iPpTf6Y3NSJmDWDntEa+S9R1Cw7YOqqrC8Xgdh3yW+Bd6Xm
 1f2TG60P4v+PGBJ9tjYjsM8qpw6mxk9K+d5IHCrl99tkuHSpwuAkSf/rVVaWXTZdsG0m
 3nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718895566; x=1719500366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qPXcVfUr1j+fLb6lIJUVnoCOekS7kyqi+VwHKDiK3x0=;
 b=ew7vKhb5LlVP8GPxyl+sdmn+9BDfdZlmbKJkPQQQNRxrFRR/+DoDYUpslkLA9P/FA8
 /pe+ZNHV06Y4tLowzjRv40DykoYJqLU2NrDi2HShz6XWVxNUUjYmTfa75AwEkGlT0459
 Y/8X6emzzl1Q2pTRsREMm5nVp79tpYq4Ll+NJoJEwQqKNmhymD3Kw0hGG8cPyne/Qsvs
 kRKd0GQKxrBZ9HAhbgNQyOEJYngHGOYWJLqDAT/QBVTef1iwRWGJV3kXfhut8fADZBjz
 6k8yXw6mBL+06P4gq2ddiAnzyLZ5/vAUM3NZ+lu3bPBe6q3QrImIIsozpjgL72f5cGyz
 mRjQ==
X-Gm-Message-State: AOJu0Yw2BaFuYkpRJCLqQw8uqndjiG50PKWkPx8GUDpyS8blXpFJvP4y
 XXxTBt5R/dXvX3c8tsxObFWrv9ZGlHYj8BZnGauamO/7SmB0bwT6zi6jkG+DmC+M+e+UMWijjdj
 Xbv9+8miDMFTyZbiSUTIQu1qSmt0=
X-Google-Smtp-Source: AGHT+IGH69BRCAuM9TDln05OzQ0yrx8tJJFn8WYrLBCFTQdkcH5qgS1nEVyUGCTtAFapYf776EDqv4CZB4ASjPymrxE=
X-Received: by 2002:a17:90b:fc1:b0:2c4:f357:b7b8 with SMTP id
 98e67ed59e1d1-2c7b5dca901mr5374311a91.43.1718895566329; Thu, 20 Jun 2024
 07:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240620074006.11922-1-bob.zhou@amd.com>
In-Reply-To: <20240620074006.11922-1-bob.zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jun 2024 10:59:13 -0400
Message-ID: <CADnq5_Oz3cBte-8R3aEYcay5bTrbm6X9qV391e-aFUSdmiViRw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add missing error handling in function
 amdgpu_gmc_flush_gpu_tlb_pasid
To: Bob Zhou <bob.zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tim.Huang@amd.com, jesse.zhang@amd.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com
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

On Thu, Jun 20, 2024 at 3:47=E2=80=AFAM Bob Zhou <bob.zhou@amd.com> wrote:
>
> Fix the unchecked return value warning by warning reported by
> Coverity, so add error handling.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>

Looks like there are a few other places in the driver where
amdgpu_ring_alloc() is not checked.  Can you fix those up too?

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 322b8ff67cde..3a7622611916 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -718,7 +718,11 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_dev=
ice *adev, uint16_t pasid,
>                         ndw +=3D kiq->pmf->invalidate_tlbs_size;
>
>                 spin_lock(&adev->gfx.kiq[inst].ring_lock);
> -               amdgpu_ring_alloc(ring, ndw);
> +               r =3D amdgpu_ring_alloc(ring, ndw);
> +               if (r) {
> +                       spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> +                       goto error_unlock_reset;
> +               }
>                 if (adev->gmc.flush_tlb_needs_extra_type_2)
>                         kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all=
_hub);
>
> --
> 2.34.1
>
