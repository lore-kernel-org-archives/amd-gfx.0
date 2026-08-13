Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70551C5CFEB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 14:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE6110E390;
	Thu, 13 Aug 2026 14:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="adLsgk7l";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8989210E390
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 14:36:37 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38f57e312ecso488204a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 07:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786631797; cv=none;
 d=google.com; s=arc-20260327;
 b=nhe+FlvN01Hitu/hhsH3vnmj8vaHWcDniu8/N7PITiHgJc3Qsk0omNZoyrlrK7Tp8T
 fEhq/ZNrxxCm41armV7YrAjXbWZhP5pTJqzMcv10713mmzoVnDpFDUFyiFo+gvyyLoi8
 PAOwGMOhB8I6ILiaVKdvgG+oS6sCiCp/L9dBt5e/HGMvDmJmT1JcA6MeiGe5YFCBDIS9
 8me9vcPTEHv4icPqwS5Ce+cEhNjEpj94KMaH+H8kPzYciurFC5Xn/utwZkBmsVHPU6ig
 gANKli2bGxWppVBek0R99qkcvmSmuHvXpbb6DQMAFBNvjT7EVtXZYlL4Ol0AXFE3no0F
 ot0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TBZQegHWWJ4npNgqOFdAManbGXYYgACplVoTDe5yX6o=;
 fh=Ol5/ZITjsaUslyKZPfb++5Ys0i+URMJbztudueBwBkA=;
 b=HAlA+ZliGkLr8s9VtkWYBAELKnKhHlBwIwN5wxhOlKu5ywogRRB1PeRdc1ZL/XqZ2c
 Z3C5dEUMGSw+q6Gg2ABP+4MNtXdJ7zvXRQpWyY4rZz1jZoIQ0+eH88l/HdceZwubx8di
 M4V018r2aQ9KpL2jq8HYOQ0pERxHjls3cNYp5rPyGuGuE4u11Z252PERHd+2ZulXbxwD
 HtmrfgL35rSlWkFZqtW2FHJeVnHw2cL8GzC0KuzEwMblztVeDScKYpR6aJD/k4vogd61
 jtRWu2An4RpN7BzYkBCUEtlBDB6XN5osqKrfjmBPGtr+OcxWRbHSytwGEw89RcDHNuOI
 GBTA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786631797; x=1787236597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TBZQegHWWJ4npNgqOFdAManbGXYYgACplVoTDe5yX6o=;
 b=adLsgk7lijbtz+E7KmyUGPlK9E8z410/7lpkgfU54V9ITXaF1dVQgBFKU7axRZz5xJ
 wjh+iFCvTluHO+niy6rebpJIBlQrkLQB8lu8FpHUqr0qZfdTkgP8z+j0tAS3zWfLeX3r
 C6jUWUu/kqgnAoHbSe+vJBbixyYkWI+pmGLtmBiyWwUSR3twLNEk8x3xLUYrTcZmza7e
 TqqBh5daA1Z1ehG24x7Q99iHIsRNuxtrv4YpXYzVqhSkRS8R2VW5LwAOait04/aUL/+I
 RoeX/cUhiQ2/Q+x6rtTtQswKfMVoUwMtfpxRsLqGr09sGLkQozSsj1Dm8m10rBdd/jHn
 Rhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786631797; x=1787236597;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TBZQegHWWJ4npNgqOFdAManbGXYYgACplVoTDe5yX6o=;
 b=UdrI0RcyW/6GF4LDD9suEMQMJz4fboGCdZzib7phDk6vvpQ1GB/SCP4l5mHaquJS9h
 EEBfWNhrq24XTWiWfkc6dLBvNt7nsxNk6urxEOiJWktjYTQRtW1Tm+cNwtE7nBu3eShI
 idnp5IOywNcpkc5aD2ehDwSb/rdUAATG7rm/RLoLAhO3oRYfzoCVx0VsVizIX2qBnzhI
 MYuaN76y04KazpDS+y9eitgOD/qfA+AAsJiGfK2n8XbnP3NOFt4N0pw5fR2FAdV9ZQdH
 oqyk67dVZLMfWwFUDh8pS2jLAEbTEl7017c+EgZg/lYsl2/j39Xkp2WRL2EURGyJ21G+
 U06w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqoC3oGMM6V3V9wHRSC12R3vu0St2uPEYIbM3Uo1a9dSpbzHu/oa4nHC3nQyoKoYXhIRqwcfsQ8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQgs8h4DMHIsDEn5VMXJRXalCZ1oO6UCaZZUBFETPNDZPmqfpi
 U9VYTTo5wPfTTpa7jpzYrR2yBxC0EsQA+sB9fcwIcPlSG0oG8Koh/5Is/D7GrVWL6p18yWGgN0K
 weuULFIqmpSZ4sfF3fl3c8PRdxxd5R/6aGQ==
X-Gm-Gg: AR+sD10FDYTIndSn9AJf9UPwkJw+14THnBMeoDMK6XFsl2r9Dg8f7j1MaKBmN8GsDWW
 NeywkhAzAvpvXwDc1BeI84c6leDnR83eLQLrnkZtQONVo/BfwPc9wMcy7GE0wP3wrxCfs02kPim
 xco0xRfMI9RJghcN2f8FwAEpbqjpt7s+wfM4vswNc0WlrBYYcciD0OXfRQQgWvzzl8zOK8+WQM7
 uYP2CwrDPj2VkjuCP2hWwpwQoliUzCP+bheDpcU/23w8vMvUmpaO6DhoPFF1DQ8lsFrGkrjApS7
 pNDEyIXIo6pf7ZBlpbgyhEMzoPtAchK1nW+lAW6jJHMwNJaZCc/M61sA0AWm/5yivKtDeCAudxI
 FUwnDX/MUBcGgpM8XgUlsCuUfoWzVVatsOt9NG/GDuQ==
X-Received: by 2002:a17:90b:2ec7:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-393233744femr4809255a91.4.1786631796845; Thu, 13 Aug 2026
 07:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260813112956.28616-1-lingshan.zhu@amd.com>
In-Reply-To: <20260813112956.28616-1-lingshan.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 10:36:25 -0400
X-Gm-Features: AUfX_mwqBYdSESZ3qPx12H2PTDFUlZU1-B-JQi6oPSn0CB1UhuNZLhYlXFqv0Rw
Message-ID: <CADnq5_MGXq-yHuR0_GxLpPsD20B=NgzAgKgVfqktJm+Enpedwg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: validate rptr and wptr of a userq
To: Zhu Lingshan <lingshan.zhu@amd.com>
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, 
 felix.kuehling@amd.com, Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, Aug 13, 2026 at 7:45=E2=80=AFAM Zhu Lingshan <lingshan.zhu@amd.com>=
 wrote:
>
> rptr and wptr of a userq are 8 bytes aligned, and may
> not placed on a page boundary.
>
> This commit checks whether rptr and wptr are 8 bytes
> aligned, and expectes 8 bytes when validates rptr/wptr VA.
>
> With above changes, this commit fixes an regression
> in amdgpu_userq_input_va_validate, where
> end_addr is caculated by:
> check_add_overflow(start_addr, expected_size - 1, &end_addr).
> Wptr and rptr are very likely not to be page aligned,
> when validating rptr and wptr, if they are located in the last
> mapped page(or only one page is mapped)
> and expected_size is PAGE_SIZE, end_addr will exceed the last
> mapped page, means (end_addr >> AMDGPU_GPU_PAGE_SHIFT) > va_map->last,
> and causing an -EINVAL, even it is a valid VA.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> Fixes: e91d10a5aacd ("drm/amdgpu: fix userq VA validation for sub-page bu=
ffers")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 04639f894903..17cc48d87c4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -702,10 +702,10 @@ amdgpu_userq_create(struct drm_file *filp, union dr=
m_amdgpu_userq *args)
>                                            args->in.queue_size,
>                                            &queue->userq_vas.va.queue_rb)=
 ||
>             amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va,
> -                                          AMDGPU_GPU_PAGE_SIZE,
> +                                          sizeof(u64),
>                                            &queue->userq_vas.va.rptr) ||
>             amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va,
> -                                          AMDGPU_GPU_PAGE_SIZE,
> +                                          sizeof(u64),
>                                            &queue->userq_vas.va.wptr)) {
>                 r =3D -EINVAL;
>                 amdgpu_bo_unreserve(fpriv->vm.root.bo);
> @@ -850,6 +850,12 @@ static int amdgpu_userq_input_args_validate(struct d=
rm_device *dev,
>                         drm_file_err(filp, "invalidate userq queue rptr o=
r wptr\n");
>                         return -EINVAL;
>                 }
> +
> +               if (!IS_ALIGNED(args->in.wptr_va, sizeof(u64)) ||
> +                   !IS_ALIGNED(args->in.rptr_va, sizeof(u64))) {
> +                       drm_file_err(filp, "user queue rptr or wptr is no=
t 8-byte aligned\n");
> +                       return -EINVAL;
> +               }
>                 break;
>         case AMDGPU_USERQ_OP_FREE:
>                 if (args->in.ip_type ||
> --
> 2.53.0
>
