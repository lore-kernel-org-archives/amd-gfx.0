Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A26EEA865
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 22:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305A810E20C;
	Thu, 12 Feb 2026 22:13:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c/28XcNg";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F7C10E20C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 22:13:23 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1244bce2c17so27937c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 14:13:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770934402; cv=none;
 d=google.com; s=arc-20240605;
 b=WxfvPYxAMHvsPS+NbpoM0Rc9aShvs3VJGRSItUxXwW/jWf7FIkOSIHHhMF1o3zS5KB
 1/GTqoA51DDIRN/2lWW3F67i872AllRSKAdYe6hZKL4iXL//24ANu8JzmOgLeJl1tYdG
 WtDilw9s5pyvqOC3BqQLmDvBSVDDP6UPIhAGl1WcG1I2G4f9qT16Bmm6nFj63vZuHJED
 LODG36fkBFGV3eEZlHBguS8mwV9JYH2pngrFWexMxHQjR0cLOyHgth9LWDdmoygyRrrH
 pxO9ipp0OBpR2CCVIFADX9S+3ZeridfpbhHkBkY24y3h6edEsQQymHt91AV89TQotk+f
 vUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i2XOFxD7C1wDiHie/2gI5jhuP0uc2GZRwvg4bAKIS+E=;
 fh=/8r8BWErwTrUMlX9EAOQL8FE74/nDT+nIXg2uv9QIHc=;
 b=S8UUf9i+hIDxWrjh5NHEHLOLUloqjUJMUQgWzCzSEo3Kr0dskodXG5+HKBHu5wWXNK
 a0i+/cq+lg1TEdEz172ncTskgt0mLzPL59mLaDp7N8RJoF5YgvEEG1lzVHj0tGdL9s4G
 GVdf6qrKze6SNQ02PYqaj8OpxJfiCaEt1YSHcHIQYV28e+VVoABRhUHzg0xgPJSoj2EQ
 vb/l8I0c2WN+iW3n3ri5FoZGqcEwM1IAGRjzoPsnB1LfcdWPfuuqBpadxRZsETl1e+cT
 JymPrIzkAObz96VdBvjtzc1yoaEyLCoyNvYhbiyPHRrQC93D90Hn0mA4W4H0ahh5EKnW
 aliQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770934402; x=1771539202; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2XOFxD7C1wDiHie/2gI5jhuP0uc2GZRwvg4bAKIS+E=;
 b=c/28XcNgvQg6soMTLVcJUPR2O1NoQp+OGb+OZC30/DXsyihIVmu4HUmvqCl9M8SgPp
 OgPGxb9dLduq/C1/4ivtvLhY6Ou933vx+5rnWLfJxOjxSzL72W7HcmBGoRq/IM5XiyZ6
 3RTHDloDLM1fBlE1ILK7C4w2jCJvZ7LGjTDq7L73P8ZedZlfsmvi9n2cLmJmNqur/eCc
 tHGzg4qJ3S7NehYVxG/rASJNXLT91w9b5Npt8PM4j8eOg/6Htdtej4Z6Xcbi95uDAydD
 wLtv28L4Y6Wc/WFsWXMpsoVVtJYpoNMjcRx4zq486b/qVUDYsWtLmmdAJzr9qXCoKB7e
 7N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770934402; x=1771539202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i2XOFxD7C1wDiHie/2gI5jhuP0uc2GZRwvg4bAKIS+E=;
 b=LxX1ouMscddtLZFp8FUmi6TZYqaOj4gU9rtMrblNzp8as1rYIFTucz0j9rYDW784vN
 WOwCnJIMBSLumMafgSAfxYDbv3jQo8rStc09uJMpsdXNC8cESMemjrwfH2/GTFuIAeGQ
 qwtQKhdWgnnZ8S3Sxi/w0Zs94osUT553sE7V0sFYJd1G0ZW4M5sGmPeYC4+hhjojSNWb
 0aFbuIacB9BxmcPeCcHbprJMSEX5JSz9PXpQolvx0gImZ9AQ0CNt0lgqaTPoCtntdyqb
 GvWrmHv1H5jXG89zRrd59clPHvuCgF1g5V4GYrg7HviglgLh6D7HZ3UT8oW4wKjyndTl
 cNyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk7Kh+9dmsKLA+eA/lGWSbaCkEsls1p/QP8qhnaXKGbaw8d1NrkDY7/cm1+7jlfYA7kGEgEL6o@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQSpSlWQUlV7w95RdWhyNuVGoizZIJXJaDtDuLHfsU5cVn9as2
 Ap43FUQlHJAKQUSI/iJWvjUJ9LbJ9B8FN/ltdezlU8nIvlcul0eS9aUtJkPXxbfgtHlbwR+16Um
 BvsXXJZyUomKo6I/AvAJJp0m1sNQOOHA=
X-Gm-Gg: AZuq6aIYaf55YkC7P6vzT9VZWuk/FldCzLdee1bTAMRJs3nL7DpQODkCiyhFhDPyF1Y
 ENUSgBjZDqVWZO2hNqA2MwuYnu8TRRlXjAiUcJTJ4Uv/QxU7mC3AzCGS23A/tV1ztYstuY/hAjh
 6mdU3ZjxsypRT0Cgp3H6b5/qlUGwu4fJYPA0p1W+P2VXeLC3BaweCc4SNWJazI5Y9+a9btNCG8l
 pW/Ln0y+XT5faOrib6oIQYu+OQ+rDNeNBivnKWYkqE+VYI0+7W9zNZctHxEX8h2ZX8zeUIDgB+o
 zAfL7kbN
X-Received: by 2002:a05:7022:6b98:b0:123:308f:667b with SMTP id
 a92af1059eb24-12739793cc8mr139216c88.2.1770934402255; Thu, 12 Feb 2026
 14:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20260205162846.106865-1-Alysa.Liu@amd.com>
 <SJ2PR12MB8650F18EDC866027298677818C60A@SJ2PR12MB8650.namprd12.prod.outlook.com>
 <DM6PR12MB440105A544332F3281D7013EE360A@DM6PR12MB4401.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB440105A544332F3281D7013EE360A@DM6PR12MB4401.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Feb 2026 17:13:10 -0500
X-Gm-Features: AZwV_Qg0Fxq9Gcb2r9gMeoJkXHamDfb6XtmTDIwVM3grITliFbKwDxadSJ7l760
Message-ID: <CADnq5_O1XTsw9uKWbaj+LMr6K1ON9hvzd+geHF6pr_+EMJdvWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Liu,
 Alysa" <Alysa.Liu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Thu, Feb 12, 2026 at 2:32=E2=80=AFPM Chen, Xiaogang <Xiaogang.Chen@amd.c=
om> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> Let parent/child process share same vm will cause multiple issues. There =
is no use case or need for that. It should be prevented at uses space, not =
work around at this specific place in driver.
>

I agree that userspace shouldn't to stupid things, but if it does, the
kernel needs to gracefully handle it.

Alex

>
>
> Regards
>
> Xiaogang
>
>
>
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kasivi=
swanathan, Harish
> Sent: Thursday, February 12, 2026 12:31 PM
> To: Liu, Alysa <Alysa.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
>
>
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
>
> Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>
> ________________________________
>
> From: Liu, Alysa <Alysa.Liu@amd.com>
> Sent: Thursday, February 5, 2026 11:28 AM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Hari=
sh <Harish.Kasiviswanathan@amd.com>; Liu, Alysa <Alysa.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
>
>
>
> Replace non-atomic vm->process_info assignment with cmpxchg()
> to prevent race when parent/child processes sharing a drm_file
> both try to acquire the same VM after fork().
>
> Signed-off-by: Alysa.Liu@amd.com <Alysa.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 00ea69baa126..f7b2358a0303 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1432,7 +1432,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void =
**process_info,
>                  *process_info =3D info;
>          }
>
> -       vm->process_info =3D *process_info;
> +       if (cmpxchg(&vm->process_info, NULL, *process_info) !=3D NULL) {
> +               ret =3D -EINVAL;
> +               goto already_acquired;
> +       }
>
>          /* Validate page directory and attach eviction fence */
>          ret =3D amdgpu_bo_reserve(vm->root.bo, true);
> @@ -1472,6 +1475,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void *=
*process_info,
>          amdgpu_bo_unreserve(vm->root.bo);
>  reserve_pd_fail:
>          vm->process_info =3D NULL;
> +already_acquired:
>          if (info) {
>                  dma_fence_put(&info->eviction_fence->base);
>                  *process_info =3D NULL;
> --
> 2.34.1
