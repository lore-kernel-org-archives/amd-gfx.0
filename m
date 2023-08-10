Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB311C001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 15:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83FFA10E560;
	Thu, 10 Aug 2023 15:20:36 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F099710E55B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 15:20:34 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a78a29bccbso914649b6e.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691680834; x=1692285634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgY7n044Kw70G9yd3abTiO89tUc7NzwUNYX3Jd7vwjk=;
 b=PP+e1i2fcrp4cqcBXZj3yAV0TutdPKLFHeoRcLZOhtE9UZLLHI7xWe2dxVl7v6fTaZ
 uFO5y/9CsBgqZLoCxwx/c5s/MG6RfvMkY0VwA5w12U2mSljG2r4RuNE5m6zJUNeYSsnj
 y6COJyA+DVxlGsGJkWrjzDpbziH8kAb9GYyAZkWBdtNSIcY0m9Aw4WS9BWRXT1KKgR5j
 YVbM0Rn3zIzJq9osLvlwtZqElzeqrKloKKEbYEnj3yLosVEDfR2miRcG/ybqPzejuWku
 bKYFNUo0WOHxNv0Vv8ysoiyuNCM155NTR5EktFhcorWfngu0YByYAXazbLHDY2hf2xhY
 oRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691680834; x=1692285634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RgY7n044Kw70G9yd3abTiO89tUc7NzwUNYX3Jd7vwjk=;
 b=QtEXcKALeGTKlZChHPzZuNa4qTdSV6zosb1G8L0RiJt2u9HEiU3PDtR0YvuxZttfko
 XTzn7jyN6hr8O2JZIDWq4H+FXh1/QXtPdxRR4me29tTvIAOcLwGmh0RalMzuuoUyzF78
 QC8c10i9l+x0ragZvaKaiGlZVXe4A1OvkBRv1mgGJkP9QAMxpuKlfu81aWq0VmYBbkXN
 eLrzHGn3Pxc1x75S7H3OrOO3eH0w6eXlG8SewcLzGDmHksTh/vfiVOxAwOr0K8agaiYf
 mMNP5J38hk5DVAEh3yBpkZ1GBLU/Zc11PekXvQkyIAfRSZ0uBdk9+l8sbJRzbMN2JvRi
 sthg==
X-Gm-Message-State: AOJu0Yx4dd19el9TypFCvhUVs77YGuHCLmWns1de6YmQid4O1cNZWcJK
 hi0XLPA2fz/+vs28IeDpQBxrxmdJWW3Pvhhql+U=
X-Google-Smtp-Source: AGHT+IH+hYYxDM90QB98kF2qH40S5eA7FjFubtUrgguubLSJFLK73old3ogAFeJKDOpdgtwBQznCUlBYPWatZdPX2i0=
X-Received: by 2002:aca:1208:0:b0:3a7:4a89:752c with SMTP id
 8-20020aca1208000000b003a74a89752cmr2736832ois.31.1691680834116; Thu, 10 Aug
 2023 08:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230809190956.435068-1-alexander.deucher@amd.com>
In-Reply-To: <20230809190956.435068-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Aug 2023 11:20:22 -0400
Message-ID: <CADnq5_P3FJN9h_utnm-yHFDKD_bUR5bUhwyyiuLgaGkzFXsQbA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't allow userspace to create a doorbell BO
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

On Wed, Aug 9, 2023 at 3:10=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> We need the domains in amdgpu_drm.h for the kernel driver to manage
> the pool, but we don't want userspace using it until the code
> is ready.  So reject for now.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 693b1fd1191a..ca4d2d430e28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -289,6 +289,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, =
void *data,
>         uint32_t handle, initial_domain;
>         int r;
>
> +       /* reject DOORBELLs until userspace code to use it is available *=
/
> +       if (args->in.domains & AMDGPU_GEM_DOMAIN_DOORBELL)
> +               return -EINVAL;
> +
>         /* reject invalid gem flags */
>         if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>                       AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> --
> 2.41.0
>
