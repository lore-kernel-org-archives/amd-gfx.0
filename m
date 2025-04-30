Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D29AC369DC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 21:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DC710E123;
	Wed, 30 Apr 2025 21:40:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BjxjunkF";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC74410E123
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 21:39:59 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2ff6b9a7f91so36880a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 14:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746049199; x=1746653999; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLEPVWK0arDEUtwliIpxPflFwn6s5Cg1IQcr+SylnTw=;
 b=BjxjunkFR5dsgkn215sIW9QAv4OP1h6xgiCskYuwcJAY4QGEqCunne6NcM9mOkQfBh
 urJpjXWj3hE24bYgEunZ/zHDPX4UCLbMZ0BJ0wxF3KvdWd8nOYYoykrs+UDJjtQH+fhH
 e9Gk42zEJI7uzHNyVBwFOFyROwk9NgAlc8YeBPA+KZBAEkscXY/2XJs530kKhu5Rkw16
 sWKTY6fzTi2Mm7aPchg0St0C89/ORfdIdndhNeNJlWo5JEYxggUL12zI9acjl+gRD4lK
 gTtR3y8ItFGPJHG4ytBMbVMCWbsO9257+d8zy7Go17Wrr9wNkRVvEx4LUAFf6mEzHoJQ
 BOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746049199; x=1746653999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLEPVWK0arDEUtwliIpxPflFwn6s5Cg1IQcr+SylnTw=;
 b=YQ1gyUozZX8IwfB270Ok6fB+MN05ebmgQsas9Vd+vRwpmTrUWF1r91+M3LoWXYH4em
 Qyjy0qfilWuOhkcBgZxHNUnsu4oOoOqPRWxkXI0UYwV0H+s/Aj+GVOuYfuxpgBswa0SX
 44QCSYWIy4hFcIevMrjCFKAFsfbSc5yxKbWYLYpDMJ6WKSxh1Xj+uyGGupTe0ehHFJJW
 AiPDQo7futc4odni5IavYMdq0GQuxH/BJPJpfM4JWF+nP1gT+wwxhEXE81rjSU97B/aB
 VTw0P/hFkMakKXzk62FkKMJamiVJgRAumv/sTm0txuf1JhzZI4I7InFlJYCtnVRIEbt+
 j5Iw==
X-Gm-Message-State: AOJu0Yzg3N0iaaMUwSZ12f/+iFV94NmJyXoVtxOxti7OF8Tsj8tMNVcs
 IQATRkMlw7B1WTLRpAqBvDRKXcglqxP9fpttLt5XADk6CvYi2cJpbNQUA/MoXuqaWW/eLZvVD/w
 RKurOUy3iXZ1Wj50IfVZsTm1Y+yw=
X-Gm-Gg: ASbGncsjrs9o3VnLir8gDFyk23yOala8bKvdQJ3eG1w0Bn5bJxsrLyI8lpIXlBZ0nhu
 C2rqsAF9aZoukIs/GSXXX9PO5QCl3YpgCjtJf4zqBPnnREdwNqGMdE2bH7VmaD9tkZPMKlvYzTt
 tMdysvxxxhya0AsD+Bs++o2g==
X-Google-Smtp-Source: AGHT+IGCKzq6mI+5zDxsz+5a7cz4DgSh8Tq4ink5W4A2oHRFL4yPsCwLtwBkYcg/DRiUxHq7PpmFxz9xax0lk5C2evc=
X-Received: by 2002:a17:90b:3ec1:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-30a3ba8cdefmr1275468a91.1.1746049198985; Wed, 30 Apr 2025
 14:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
In-Reply-To: <20250429112429.5646-3-john.olender@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Apr 2025 17:39:47 -0400
X-Gm-Features: ATxdqUGsBLjTQzKFzjbGCN7205BmwWsbE7Cwc7APRTGg2PqiWTODg6YTrM7hV8A
Message-ID: <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
To: John Olender <john.olender@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
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

+ Christian

On Tue, Apr 29, 2025 at 7:25=E2=80=AFAM John Olender <john.olender@gmail.co=
m> wrote:
>
> If the vcpu bos are allocated outside the uvd segment,
> amdgpu_uvd_ring_test_ib() times out waiting on the ring's fence.
>
> See amdgpu_fence_driver_start_ring() for more context.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3851
> Signed-off-by: John Olender <john.olender@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 36 ++++++++++++++-----------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index 74758b5ffc6c..a6b3e75ffa2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -139,15 +139,20 @@ static void amdgpu_uvd_force_into_uvd_segment(struc=
t amdgpu_bo *abo);
>
>  static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
>                                            uint32_t size,
> -                                          struct amdgpu_bo **bo_ptr)
> +                                          struct amdgpu_bo **bo_ptr,
> +                                          bool interruptible)
>  {
> -       struct ttm_operation_ctx ctx =3D { true, false };
> +       struct ttm_operation_ctx ctx =3D { interruptible, false };
>         struct amdgpu_bo *bo =3D NULL;
> +       u32 initial_domain =3D AMDGPU_GEM_DOMAIN_GTT;
>         void *addr;
>         int r;
>
> +       if (!interruptible && adev->uvd.address_64_bit)
> +               initial_domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
> +
>         r =3D amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
> -                                     AMDGPU_GEM_DOMAIN_GTT,
> +                                     initial_domain,
>                                       &bo, NULL, &addr);
>         if (r)
>                 return r;
> @@ -319,19 +324,23 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>         if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
>                 bo_size +=3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode=
_size_bytes) + 8);
>
> +       /* from uvd v5.0 HW addressing capacity increased to 64 bits */
> +       if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_U=
VD, 5, 0))
> +               adev->uvd.address_64_bit =3D true;
> +
>         for (j =3D 0; j < adev->uvd.num_uvd_inst; j++) {
>                 if (adev->uvd.harvest_config & (1 << j))
>                         continue;
> -               r =3D amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> -                                           AMDGPU_GEM_DOMAIN_VRAM |
> -                                           AMDGPU_GEM_DOMAIN_GTT,

I think we can just make this VRAM only.  Or something like:
adev->uvd.address_64_bit ? AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM

If that fixes it, this should be tagged with:
Fixes: 58ab2c08d708 ("drm/amdgpu: use VRAM|GTT for a bunch of kernel
allocations")

Alex

> -                                           &adev->uvd.inst[j].vcpu_bo,
> -                                           &adev->uvd.inst[j].gpu_addr,
> -                                           &adev->uvd.inst[j].cpu_addr);
> +               r =3D amdgpu_uvd_create_msg_bo_helper(adev, bo_size,
> +                               &adev->uvd.inst[j].vcpu_bo, false);
>                 if (r) {
>                         dev_err(adev->dev, "(%d) failed to allocate UVD b=
o\n", r);
>                         return r;
>                 }
> +               adev->uvd.inst[j].gpu_addr =3D
> +                               amdgpu_bo_gpu_offset(adev->uvd.inst[j].vc=
pu_bo);
> +               adev->uvd.inst[j].cpu_addr =3D
> +                               amdgpu_bo_kptr(adev->uvd.inst[j].vcpu_bo)=
;
>         }
>
>         for (i =3D 0; i < adev->uvd.max_handles; ++i) {
> @@ -339,11 +348,8 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>                 adev->uvd.filp[i] =3D NULL;
>         }
>
> -       /* from uvd v5.0 HW addressing capacity increased to 64 bits */
> -       if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_U=
VD, 5, 0))
> -               adev->uvd.address_64_bit =3D true;
> -
> -       r =3D amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd=
.ib_bo);
> +       r =3D amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd=
.ib_bo,
> +                       true);
>         if (r)
>                 return r;
>
> @@ -1236,7 +1242,7 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *=
ring, uint32_t handle,
>         if (direct) {
>                 bo =3D adev->uvd.ib_bo;
>         } else {
> -               r =3D amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo);
> +               r =3D amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo, tr=
ue);
>                 if (r)
>                         return r;
>         }
> --
> 2.47.2
>
