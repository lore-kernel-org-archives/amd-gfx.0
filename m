Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EA3C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 22:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6F610EB20;
	Wed, 19 Apr 2023 22:12:18 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D56810EB20
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 22:12:16 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-18b1f6caf03so8192fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 15:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681942334; x=1684534334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaYvIj7AJ3gLs47b7MD93kLErM1YnNq2aIhul5kgSpE=;
 b=pdd9ssdxuclnPGNN7iKB0+nPWmyIaSUozTRq2wb9AQix2cQnCXXlYOVmrDxVWrdiZq
 sHHeeuP3cM4XhslekvjgXHYf6jcbT8LL5rYRcj6DdKWjXGlXy4Snw/Dmfs6n27pwAwmx
 WZTrlaPlgctT1Mhy8f/ZQP1bOMggMX81lXyKlUrPMcrjjd0kGIXZFsZQM14AYkcCcaDS
 rKgoYYhiueNJGHGuA4NFvzd2m/mZ2bdPUcjaczztcH75z7ugs72G6Hb6eLv1rTHlM5Dt
 3m5Z3/VxkEvEAArYDW5eTXZsb1SBzHWGwC60A9XXDgwM9+AeF9gRJTfs7YmFk7Non1kh
 KrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681942334; x=1684534334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DaYvIj7AJ3gLs47b7MD93kLErM1YnNq2aIhul5kgSpE=;
 b=NQMFWzju+bpm+VL0NVoEqoF80KII/JwQ+PgN04VkjKr4QSFVcM3Oum/wR6n7wyCq95
 aoOkZo04WeaZmkXHaoZzD9WOuvV8Bof6RRr23v7rRwQsbsEL/5MqqKrwVFF7VNGydfNn
 9h9m3NIT3nadiP17Hhs5aA6n1YVyeRu0XSe4RgN4if/FMdCdtuo8ORFW6PdGUH4SZjJw
 ool2/mWk+Ma4P23zyTXpteEJvz4ujgujf/wuxSFIuMKGw+Z+LeX6N+21YO5p1kBplwjP
 q7rvwokKl3mJggp/ZyKfQJAmjE8NoFKvQ9TUMnvmW3Rin8W/o/Uc+cLCEsT7QFs1KUeL
 eQYQ==
X-Gm-Message-State: AAQBX9c3Rwmr8IIN9tSrKRPLwgyiQnN8Sc+xSamP6qA/LILTM+/p1Jyn
 Qe2GzXZQTHIhrdixKTJiwvsQT9ong1vWXXBUVGGH7y8U
X-Google-Smtp-Source: AKy350ZRm+sl0hSusCHXp2ag0ZLveD9sMgKKDddxcsJ4ZVa1Dp/eg2ZBbUQ1or4eY9rmTfHC41E0txxthJGbDLE83tA=
X-Received: by 2002:a05:6870:b017:b0:184:525b:279b with SMTP id
 y23-20020a056870b01700b00184525b279bmr644537oae.50.1681942334662; Wed, 19 Apr
 2023 15:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-11-alexander.deucher@amd.com>
In-Reply-To: <20230330191750.1134210-11-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Apr 2023 18:12:03 -0400
Message-ID: <CADnq5_NeiPf1QH3y=P-eE16FZ74VX=Z0KajQminhfAU-QBeOPQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] drm/amdgpu: add support for new GFX shadow size
 query
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

On Thu, Mar 30, 2023 at 3:18=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Use the new callback to fetch the data.  Return an error if
> not supported.  UMDs should use this query to check whether
> shadow buffers are supported and if so what size they
> should be.
>
> v2: return an error rather than a zerod structure.
> v3: drop GDS, move into dev_info structure.  Data will be
>     0 if not supported.
> v4: drop local variable r
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 0efb38539d70..fd735df92b9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -876,6 +876,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
>                 dev_info->gl2c_cache_size =3D adev->gfx.config.gc_gl2c_pe=
r_gpu;
>                 dev_info->mall_size =3D adev->gmc.mall_size;
>
> +
> +               if (adev->gfx.funcs->get_gfx_shadow_info) {
> +                       struct amdgpu_gfx_shadow_info shadow_info;
> +
> +                       ret =3D amdgpu_gfx_get_gfx_shadow_info(adev, &sha=
dow_info);
> +                       if (!ret) {
> +                               dev_info->shadow_size =3D shadow_info.sha=
dow_size;
> +                               dev_info->shadow_alignment =3D shadow_inf=
o.shadow_alignment;
> +                               dev_info->csa_size =3D shadow_info.csa_si=
ze;
> +                               dev_info->csa_alignment =3D shadow_info.c=
sa_alignment;
> +                       }
> +               }
> +
>                 ret =3D copy_to_user(out, dev_info,
>                                    min((size_t)size, sizeof(*dev_info))) =
? -EFAULT : 0;
>                 kfree(dev_info);
> --
> 2.39.2
>
