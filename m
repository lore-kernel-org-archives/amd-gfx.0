Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C7EC6FD1E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 20:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D9110E340;
	Fri, 10 Mar 2023 20:14:20 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E04210E340
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 20:14:19 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-17638494edbso7103501fac.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 12:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678479258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7N/Vr0NeiaCoDpgqZ5a/l7K3g8tsi2/ObRU0lyi+aY=;
 b=p+hUdD7MOu0ArLyEVj7gxnMzGohpVAkZwDwxwrvFg+HsInUtCuPDAuyXXrimeP7lnf
 p3lJaUWB2/hgrtEzMPi1FMsFcOrcVqjHsgcpg2/pFMJxJNlPIUu+LmsMn1rkm8CdEMQc
 NKJ9iTJkjul8l1L6wNuR9ZTHWIj3qqsMeqUbLle9AkB4M1kSFWDgXUMJue13tWLGr9YR
 ecBGsrISfapddF6NGCQljZ1KwJtJNl6IcSRy5S/CRg83nANhcPJOUH+F6yfl/ann0C8r
 lWJ+b/rQH8U3C3ED6Ka2Ruret0m8naE9YJdQdp8akKUa9KhA8T3asyhodr4sugq8YRrP
 dSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678479258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7N/Vr0NeiaCoDpgqZ5a/l7K3g8tsi2/ObRU0lyi+aY=;
 b=K+9YbyNN2LhchnYynTYDCVnplOopoAOpJKLDwizf5Ld7SCmV73GLsTEvHXFW1PUtnY
 6zf/GTMc9jGjm4L1rbdTJHbkb7597dz4YBx7xS7PknQwifSdEH6z7ogzsgCAqFxBK4Bi
 f/veZcOfcUUIZrEvCwFXnFAnEUdRomig8Wzcw/rB0bnDU9wv3KuT1mcTzoy2AJDPULHM
 GxqY1UGRza4LMcxSmxRh8pBfRCnq5Cis7rhowUpEGwm4A9c5VbQ7fZCD161rTel9Jjrt
 utDpUyuusA2GYNgb97CNdXPVzRKqHmTeA4g8yAkeeX8ddqYeGd18I0xoqZC+zhjrtXYW
 7KrQ==
X-Gm-Message-State: AO0yUKXmMhJxaAF59k8OPTt6K3CHafL8Fcuu7oHjWLZA531BH4ZBQRAd
 R9vgNYwQi8ZSCyREK926LXZHXFeOALsglawejBg=
X-Google-Smtp-Source: AK7set9fAwAp/BZoq6UbZnk35UIYwEbWuoeJr9spvs0NLPK/4r1RVW05lrj6zPqoFhGWz0nZ3N4PoVOiqyKZo3RTkXs=
X-Received: by 2002:a05:6870:9a8a:b0:176:aee9:99e9 with SMTP id
 hp10-20020a0568709a8a00b00176aee999e9mr1590058oab.3.1678479258210; Fri, 10
 Mar 2023 12:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20230310185702.1150794-1-xiaogang.chen@amd.com>
In-Reply-To: <20230310185702.1150794-1-xiaogang.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Mar 2023 15:14:06 -0500
Message-ID: <CADnq5_PYFxw10c42XKhst+FaH2K_waGnsa+7s5X07XDzJH3iuw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix warnings in kfd_migrate.c
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Mar 10, 2023 at 1:57 PM Xiaogang.Chen <xiaogang.chen@amd.com> wrote=
:
>
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c: In function =E2=80=98=
svm_migrate_copy_to_vram=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:393:1: warning: label =
=E2=80=98out=E2=80=99 defined but not used [-Wunused-label]
>   393 | out:
>       | ^~~
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:525:29: note: format s=
tring is defined here
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:40:22: warning: format=
 =E2=80=98%d=E2=80=99 expects argument of type =E2=80=98int=E2=80=99, but a=
rgument 4 has type =E2=80=98long int=E2=80=99 [-Wformat=3D]
>    40 | #define dev_fmt(fmt) "kfd_migrate: " fmt
>   525 |   dev_dbg(adev->dev, "fail %d to alloc vram\n", r);
>
> Fixes: b0b7d79469d9 ("drm/amdkfd: Get prange->offset after svm_range_vram=
_node_new")
> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_migrate.c
> index 734b4eeb0f3e..6a7dd6574646 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -390,7 +390,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, =
struct svm_range *prange,
>                 migrate->dst[i + 3] =3D 0;
>         }
>  #endif
> -out:
> +
>         return r;
>  }
>
> @@ -522,7 +522,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uin=
t32_t best_loc,
>
>         r =3D svm_range_vram_node_new(adev, prange, true);
>         if (r) {
> -               dev_dbg(adev->dev, "fail %d to alloc vram\n", r);
> +               dev_dbg(adev->dev, "fail %ld to alloc vram\n", r);
>                 return r;
>         }
>         ttm_res_offset =3D prange->offset << PAGE_SHIFT;
> --
> 2.25.1
>
