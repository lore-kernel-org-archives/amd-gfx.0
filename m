Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC27DCA1010
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 13:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC5C10E87B;
	Wed,  3 Sep 2025 13:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YyOcRf63";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886B010E87B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 13:19:35 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b4741e1cde5so800872a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Sep 2025 06:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756905575; x=1757510375; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/8sIE4ICMQ+/9JUTXmw6dqI9owT1QCy9+HMqC1Zqo4=;
 b=YyOcRf63ev0ArsLpdv3loLwZgBOfQ0dPwN6qXnJ+gQW6FqKcBrgMvF+iZtk0JDMeB4
 dOFF9imJOlRInI8PJYjLfF9Z8d4gJum9xSsH/g5YuDuXn0ESzTfpiDTnJMqerGd80KAc
 CUY5Jz0hdfv7tpWLw3Ba4+KlSTvyRafhMiuOkmUwCMTzCNbf3FjqyU+Gx98wcjTrjO6+
 ylTrXta3EHREjalt2/PmorEKZ9my8QQw0EFIcZlG7jiGM5SGfD63UGwbpk4x0/W+XvWj
 hrY0KR6QX/cdiTkbtpjidI0kMvSPvegZoDZXHXS+KddbyD3Ty5m9LbGFCNU5SjwpHMY5
 RceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756905575; x=1757510375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/8sIE4ICMQ+/9JUTXmw6dqI9owT1QCy9+HMqC1Zqo4=;
 b=JoGfjNdQLGmZyvOjwtIZPWNqQNG/u/8LwWoIKh2zeXeTBVvg+d9vwcenQRT2fF78fB
 GEM+2kbAfLsYpOJWzA9C+EWPEYSLqkqhAx90AxNPkD3tJY9x/H2WoCIkBGeyw0Z3Rjqg
 qjwj4hSk/vEZAkIbzZyTsrPOs2EhcLruIADdyi7czstscBjgL4DCuRkAbnOLBgj8J8dv
 NJv5ktkrAYPqGyfEoKpKq9JeQlWmIsMhrC8SZpgnY0mbX9KDr+koEeq76M1Kl4K1jsNO
 ZVnbCeOuFNJ2zhLbmPSED8wIBXu1TVQo6vIE3GJv+BKr0QiKPrjzz1ZKfpIsLuS4urzD
 tpnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbnDLQI5piKCZF2djGm60S2xoDhGroC/9BrM9n7Ym+2XxE759cdqn0U5fEdPP64rnwh66EjXKy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKgQZbck3Kb9RcTZ2O0aeAaMr/Fq3UKze8jzlEY7l7q9ZWA2ae
 sbMb+/bRLZ27JUAzLkVJse0wRQgmMRJJzekYCjzYoSPq3u3jIJIcNCIAT5NBSEqO6i6oBc2j3gI
 4yv2lmfJHzui1OvgilaBQUu2ikv4rIdY=
X-Gm-Gg: ASbGncsRHH02a3vlqZR52ECcNGSJ80ykXDNzUtxgAil54VPGjLCd4NWbGiuiw+6jokY
 lYEXCuenbJCsufu/NJlIN1fUfYsJIjxw5cbRRFwOeKIZXI+dRCd2erx3PaKANPS2pMPslWvqTIY
 EWf8RXVu0X8agT7IG3zyst+U6r7297IinnpccV2mq8xtXxaOmudlkvkMGg1dGNIrIhOzacB0kDH
 7bUYLqvl/J/tp7DxA==
X-Google-Smtp-Source: AGHT+IEjiGzAk+52UzR0IjlSnbASVt0MDxdrZ9Uq/uk4dnXJL5DvCyBXooo33oxFu8/N1YTnX25UeGJbbhNWeDGVB4c=
X-Received: by 2002:a17:902:c40c:b0:248:a01f:a549 with SMTP id
 d9443c01a7336-2491f27a5ccmr146753135ad.11.1756905574799; Wed, 03 Sep 2025
 06:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
 <20250902145213.486199-9-srinivasan.shanmugam@amd.com>
 <fc8e033f-ad1b-4ea9-88ff-55b200f68ebf@amd.com>
 <10bcd2e4-864f-46ef-9cb1-520a4cf8b54d@amd.com>
In-Reply-To: <10bcd2e4-864f-46ef-9cb1-520a4cf8b54d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Sep 2025 09:19:22 -0400
X-Gm-Features: Ac12FXxnFZAk5ffuNSk55PVvEN4BLoOU9Fbub5FxDNjSkpMwfsZQQaCgZOm6HqQ
Message-ID: <CADnq5_M-X7PiDXMyj=Lb+QBnfp1V=2xf1eCig1AF5UWW=DpwPg@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] drm/amdgpu/gem: Return Handle to MMIO_REMAP
 Singleton in GEM_CREATE
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Sep 3, 2025 at 7:54=E2=80=AFAM SRINIVASAN SHANMUGAM
<srinivasan.shanmugam@amd.com> wrote:
>
>
> On 9/3/2025 1:07 PM, Christian K=C3=B6nig wrote:
>
> On 02.09.25 16:52, Srinivasan Shanmugam wrote:
>
> Enable userspace to obtain a handle to the kernel-owned MMIO_REMAP
> singleton when AMDGPU_GEM_DOMAIN_MMIO_REMAP is requested via
> amdgpu_gem_create_ioctl().
>
> Validate the fixed 4K constraint: if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE
> return -EINVAL; when provided, size and alignment must equal
> AMDGPU_GPU_PAGE_SIZE.
>
> If the singleton BO is not available, return -ENODEV.
>
> v2:
> - Drop READ_ONCE() on adev->mmio_remap.bo (use a plain pointer load).
>   The pointer is set `bo =3D adev->mmio_remap.bo;` ie., The pointer is
>   written once during init and not changed while IOCTLs run. There=E2=80=
=99s no
>   concurrent writer in this execution path, so a normal read is safe.
>   (Alex)
>
> v3:
> - Drop early -EINVAL for AMDGPU_GEM_DOMAIN_MMIO_REMAP; let the
>   MMIO_REMAP fast-path (For MMIO_REMAP, if asked, we don=E2=80=99t alloca=
te a
>   new BO =E2=80=94 we just check size/alignment, grab the one pre-made BO=
,
>   return a handle) handle it and return the singleton handle.
>
> v4:
>  - Return -EOPNOTSUPP if the singleton isn=E2=80=99t available; drop PAGE=
_SIZE
>    check from IOCTL; inline the MMIO_REMAP fast-path and keep
>    size/alignment validation there. (Christian)
>
> v5:
>  - Reword comments (no =E2=80=9C=3D=3D=3D=E2=80=9D), explain why the sing=
leton is returned.
>  - Pass &args->in to amdgpu_gem_get_mmio_remap_handle() (drop local
>    =E2=80=98size=E2=80=99) (Christian)
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 58 ++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index d3c369742124..7676eafbedbf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -424,6 +424,47 @@ const struct drm_gem_object_funcs amdgpu_gem_object_=
funcs =3D {
>   .vm_ops =3D &amdgpu_gem_vm_ops,
>  };
>
> +/**
> + * amdgpu_gem_get_mmio_remap_handle - Create a GEM handle for the MMIO_R=
EMAP BO
> + * @file_priv: DRM file of the caller
> + * @adev: amdgpu device
> + * @in: GEM create input parameters from userspace (size/alignment field=
s may be unset (0))
> + * @handle: returned GEM handle for userspace (output)
> + *
> + * Creates a GEM handle to the kernel-owned singleton MMIO_REMAP buffer =
object
> + * (adev->rmmio_remap.bo). The BO is expected to be allocated during TTM=
 init
> + * when the hardware exposes a remap base and PAGE_SIZE <=3D 4K.
> + *
> + * Although @in can specify size or alignment, this BO is fixed and uniq=
ue;
> + * those fields are only validated, not used for allocation.
> + *
> + * drm_gem_handle_create() acquires the handle reference, which will be =
dropped
> + * by GEM_CLOSE in userspace.
> + *
> + * Returns 0 on success,
> + *         -EOPNOTSUPP if the singleton BO is not available on this syst=
em,
> + *         or a negative errno from drm_gem_handle_create() / validation=
.
> + */
> +static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
> +    struct amdgpu_device *adev,
> +    const struct drm_amdgpu_gem_create_in *in,
> +    u32 *handle)
> +{
> + struct amdgpu_bo *bo =3D adev->rmmio_remap.bo;
> +
> + if (!bo)
> + return -EOPNOTSUPP;
> +
> + /* MMIO_REMAP is a fixed 4K page; enforce only if userspace specified t=
hem. */
> + if (in->bo_size !=3D AMDGPU_GPU_PAGE_SIZE)
> + return -EINVAL;
>
> + if (in->alignment !=3D AMDGPU_GPU_PAGE_SIZE)
> + return -EINVAL;
>
> You misunderstood me on teams :(
>
> Only the size must be exactly AMDGPU_GPU_PAGE_SIZE. The alignment can als=
o be smaller than that, just not larger.
>
> In other words the check here is probably best written as "if (in->alignm=
ent <=3D AMDGPU_GPU_PAGE_SIZE)".
>
> Hi Christian,
>
> Thanks a lot for all your quick reviews and feedback's onto this series.
>
> Just to double check "if (in->alignment <=3D AMDGPU_GPU_PAGE_SIZE)". " <=
=3D" is rejecting for buffer alignment "#define BUFFER_ALIGN (4*1024)" in I=
GT, so is that is that this check should be lesser than 4K
>
> if (in->alignment < AMDGPU_GPU_PAGE_SIZE) atleast for this MMIO_REMAP BO =
case?

if (alignment > AMDGPU_GPU_PAGE_SIZE)
   return -EINVAL;

Alex

>
> Best regards,
> Srini
