Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20EBC282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 21:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0CE10E07C;
	Mon, 10 Mar 2025 21:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jWRoUUsE";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8BE10E07C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 21:52:42 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2f74e6c6cbcso1269003a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741643562; x=1742248362; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JD1+cheXKXy4Xc2q3SUXFtZ5uJuU6Vb0rzlw0y9HYk8=;
 b=jWRoUUsE8QPeSevgCXCfLy6x86YMBRSgltsHN4DuTbcZX5tLppLXBgEr+LMXrVzG7X
 YppJdSHBpec8KSfNlPckWkXd2IoVM7lvYmHSZcjmV4cbC8HZl7YMJPiZfgP23gfl+aEf
 r8o3SBg6FLsijK1EfRIRvYvep7r2kGOK6thGqKKZ1BvizWlfMptobloqI37AQ0y4yp2F
 TO7xFhh+Qlr4WkedE7WGjiMCJeuL1cRoQBOWEHdZ9XHKtbygTaN7UT41tDKLYCSe7Kv0
 MqIkg8+Q80Q7oHGAWg3Sw69DqgF5hsyV8QPzpWOxcfgjRv/BK2nOgTboKwT4kX+oE3q1
 KIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741643562; x=1742248362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JD1+cheXKXy4Xc2q3SUXFtZ5uJuU6Vb0rzlw0y9HYk8=;
 b=D0ROOObpoASYIsdIqX2XMnyU0/Rx7I+KC3D9jH1EBwWVCMoH7/+RR8sJkOWZE3nQDr
 Ygn03JuW187KeKWZkvvhHvV5Rxn5/CTC9SusrkQRBfWOhi0Cy5E+7tZF3uOVYAl+RpgU
 k5kl7taVBSe91gKH/uHYPaU6Hqs62Ja8SPrg2vP5ZUrmv8QnqJIgWNgUYOdQoYBOpvn0
 t+I65+AZtiaHiatPDCpYY8W+QMwuH8PFFwqzYUXjWpgMxrj1ZlbkmoU0nirt+0xPX7YQ
 Ei6YB+nflx2nOvGtlh5vBC8zV+I8KE3rEgBDC4NGzZfBrR/LeMGl9aimD+1wYkMSxkPO
 9czA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkqOc/Egbe2WjdjbJHzbbZu5fGcp2oAJOFb0TVrUMirF31G/TDB+hWTFfxkZHP7NKn7fj6mqQQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqQHvEo4r6c+kY65MISupTHEi7m1rYZt8zGmCH7pBUd9Atxdl8
 Jj8XbecvBjjBfbVGpMM9POSGGuUYPsWlzjs+FZGR+CRE3xe537110H9ZNotRlGNRv4lWOH0la/l
 pkt0mxnCjABMuUaXB2E/Sjyzdj61xcA==
X-Gm-Gg: ASbGncuJho/2093hC/dUF/0JyJI1WFhmtQGuYH+ofkfxSw8A6vcAUEgAMBFOgJn0oae
 eohYCViEwHfStoPH7ecnoyRS4Wy+cwqHLhvZy3GZ3/ln9TOnoD0FneBC6MDpDbSlbaCRJInsG8d
 +PG+kBirsdhHa3+s+WUp3EnQ+Hcw==
X-Google-Smtp-Source: AGHT+IErdffVLIybkBaYleQkRaqkA3aOGmv6V85hQb4wzhhcrVgbYFu7KVMtJ7SnE1we6bwcQMmJtNoYuwoInzrtv2I=
X-Received: by 2002:a17:90b:1b48:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-300ff380401mr665450a91.0.1741643561665; Mon, 10 Mar 2025
 14:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250310170805.37536-1-natalie.vock@gmx.de>
 <4bc6ed60-0f9c-4d4f-bb36-2e076a0fabd2@amd.com>
In-Reply-To: <4bc6ed60-0f9c-4d4f-bb36-2e076a0fabd2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Mar 2025 17:52:30 -0400
X-Gm-Features: AQ5f1Jog1pGfRP6urJW6QOCeYOylZxWXstI0TO2HgfUNGd9gmxIcJq4gWy5WLNY
Message-ID: <CADnq5_M1f-Z-j_4jT_kL19YkaL1LZ1x-8-2UrF6hZn8MywEwLQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: NULL-check BO's backing store when
 determining GFX12 PTE flags
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Natalie Vock <natalie.vock@gmx.de>, amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

On Mon, Mar 10, 2025 at 2:03=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 10.03.25 um 18:08 schrieb Natalie Vock:
> > PRT BOs may not have any backing store, so bo->tbo.resource will be
> > NULL. Check for that before dereferencing.
> >
> > Fixes: 0cce5f285d9ae8 ("drm/amdkfd: Check correct memory types for is_s=
ystem variable")
> > Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v12_0.c
> > index ea7c32d8380ba..bf8d01da88154 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > @@ -528,8 +528,9 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_devi=
ce *adev,
> >
> >       bo_adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> >       coherent =3D bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> > -     is_system =3D (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT) ||
> > -             (bo->tbo.resource->mem_type =3D=3D AMDGPU_PL_PREEMPT);
> > +     is_system =3D bo->tbo.resource &&
> > +             (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT ||
> > +              bo->tbo.resource->mem_type =3D=3D AMDGPU_PL_PREEMPT);
> >
> >       if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
> >               *flags |=3D AMDGPU_PTE_DCC;
> > --
> > 2.48.1
> >
>
