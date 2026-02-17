Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4EDE909CF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 16:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD1E10E50A;
	Tue, 17 Feb 2026 16:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VaVSSD7b";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E705C10E50A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 16:20:52 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so254994c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 08:20:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771345252; cv=none;
 d=google.com; s=arc-20240605;
 b=Aq82p8tcCTrKtq+n0wUYoH3FWS89AMkoAKsL4SXhyorsZ8gwg1Kfy4zP1LYcEDwq5t
 GAdy+EP+2QfZA8wXTAOy6Bi6Ci08q+sJCKZQl8BFM18PwqEvjVT/XGUUZ8Y0pAh0ZUYn
 fQvsK205FW1Qr88P1ETfikN2phI3rBhX6KcDgELbEysC1wFiYgZxMJpPul4Zw0URsh6y
 KTTNLt6EbJWlZJgD2U91Mq2Bvh7f6Xn26R2xbHVCm1+X2XRIMrmifekYxIv8SjN4/pSU
 i4vU57insCfeitwX7oWtnR+GCgKTErbu4HbL6X4rErw+PSDD5R4WOtrRZoqcm2Kt1Xrm
 L+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9i55LZieGKs05yWNPk9MKUvqSoDlPgmRzyXhZLZD6vQ=;
 fh=W/t5VKYshKuIcQw5JFKDY9O+VIhdeHtkBGUkXPswkMU=;
 b=Ysu/kqf6OL6PaA2pUkH8kN2jRCdSxsanmOikUjjKnWpfbOVlo2sM+WYdqu1h3NC9fo
 nz73uyynbs6YDjj4Tq1SBny7faMB2OfCccjgVk3qbhf7hUaHc5cY7XjcKw20ueveYfV7
 b4bUZ5nRIjmZsYwpDnvH8eVzi774wOkUZa4xu2Le25c3rHIQRiiHvDx32mIBceLvQneo
 sgrlhLCQebNjeBT37bTjDdFCZ4nG5mTgQGcLnMGw6mnvZV4XpAVBZ6gy6gFPATAHreYZ
 SmPgKjpZI/jqyWxx+aXutYN8BO3veEJ5b4Kd7XOITEOsM+0DZm8aAqOsBK77G9JFMcL3
 kJIA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771345252; x=1771950052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9i55LZieGKs05yWNPk9MKUvqSoDlPgmRzyXhZLZD6vQ=;
 b=VaVSSD7b+EpWvlK9NAPPW4SjrPb5s2Z/+Tw6+zOGwYgfA7eHl5zoHkhDM9eyqQTAm5
 vhrUh/G+jaG5BXnx81MOCP5C0TdHFu3uxx2OP9aXaIqho6ZdoVhCfFCc4jIFZyJcBdlg
 5ZWG/nw66vy7xF2sOkQ7Ew+dWiv8pljkRbbL7KtZYF+UHL6HA6YwaDutwP/bjy0JvtB3
 OyjOxznmxn05QHY0nNuqRBJ2uA1iikwV2GkdsY3WExiRhmDzm6JKVE8z3PuYVDT45OhY
 uUp7DkexzPQOsolH5ibPtgZZYe0h7cVwR2VKX59sDVt5hlQNpg77rUz4xPsjKG85Z7+2
 Rusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771345252; x=1771950052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9i55LZieGKs05yWNPk9MKUvqSoDlPgmRzyXhZLZD6vQ=;
 b=fXHkPwcAykNT48/JcCjxsNsXpx2KTwjd3AX4sJB4hnzBxxltSyUNVj6b7RMxu2j7pc
 lyyVX/3HIl9V2+WJLiqFisiRU8L4ebTskdtoNCeTILjVy9nN5PdkPHDqI5Aa/I7kCfeb
 SE4on99oUgPYTy3hB3rF+iErVhoUgjtFWDjSqckFEC+833qo6NSwTePIPnPmdZc9hgJ5
 87fNvR9L5UMCnrmlin4EtZO0u+xajUICBmURn+/c8S7XMvM29t5hhMDwcMiwYYvn5ly3
 llRzA5Jd2X11e/DsFKctGdHCNMGt3jSunt/PzxHqHessIkRnx6w5srpGbJEMQpvWMiLF
 fpww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMRWrLQ3p7tClQLlVFG43pVC3NaTkwEjtUtZQbJ1cD8lCxVXUz4EOtqgjQSV9yMv9vbHI5A4fN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyC9hD800ld22QzIq+GJYaRf178If6rsMbHOulMWUA91Haj/olw
 4XxWuCCkggY3XsIMzKOHOewwGC9q1rlZz24LIGMndrvPO6mJtNuGwzR0Fehc3bgSEKPBUFEIBVR
 kIx1R1IzFo5QbWcqcb93Y82VKnCJGrtY=
X-Gm-Gg: AZuq6aLrtX4zxAVmoAZKbUgylgVmmA/WduRbwXGa2O51VfQ13mY7Fka8ekBGJ9BFWgh
 Evd/i4c1ufrnyo/u9XoiC51SzXVDpeXZ0Fm8YmjfRKlYWY46xNUsbc5cGf1rTVP91tzYi2E0p2j
 U4YBsposcS6i5MQslsJuPhImem1elegGyr0kRjKwXEuRvS7XQgZAq+RSJMBg3rPgEa1+346brbG
 roXJFPdxJYZQSSFRCCzHngM/CXFQCDlG1GeMloWisM+eGETdSXj2RAHgQnMxiJeNqQDCl9K+3/J
 A3xpO5FMNKtSSBLKzCDoE4YHJJM99162EtgqGbYSf+EfFktAWVCx5gFUfoxna/R9vjILWGhDSYY
 L4tME
X-Received: by 2002:a05:7022:3f09:b0:124:94b6:2a1f with SMTP id
 a92af1059eb24-127398118b9mr2362895c88.3.1771345252051; Tue, 17 Feb 2026
 08:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20260211102657.4180-1-pierre-eric.pelloux-prayer@amd.com>
 <20260211102657.4180-6-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260211102657.4180-6-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Feb 2026 11:20:40 -0500
X-Gm-Features: AaiRm50d9cmG136ZAb4BP8CYmpO7L52Et3tMmtNHutM6CWuRv-FRvnuQyTDqA0U
Message-ID: <CADnq5_Ndh2zaQ5VcoA1jNjAohkurqofd5_TweCfX+iaKz9h+vA@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] drm/amdgpu: dump job ibs in the devcoredump
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Feb 11, 2026 at 6:07=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Now that we have a worker thread, we can try to access the
> IBs of the job. The process is:
> * get the VM from the PASID
> * get the BO from its VA and the VM
> * map the BO for CPU access
> * copy everything, then add it to the dump
> Each step can fail so we have to be cautious.
> These operations can be slow so when amdgpu_devcoredump_format
> is called only to determine the size of the buffer we skip all
> of them and assume they will succeed.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 84 ++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index d0af8a294abf..d576518c212d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -200,12 +200,20 @@ static void amdgpu_devcoredump_fw_info(struct amdgp=
u_device *adev,
>  static ssize_t
>  amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_core=
dump_info *coredump)
>  {
> +       struct amdgpu_device *adev =3D coredump->adev;
>         struct drm_printer p;
>         struct drm_print_iterator iter;
>         struct amdgpu_vm_fault_info *fault_info;
> +       struct amdgpu_bo_va_mapping *mapping;
>         struct amdgpu_ip_block *ip_block;
> +       struct amdgpu_res_cursor cursor;
> +       struct amdgpu_bo *abo, *root;
> +       uint64_t va_start, offset;
>         struct amdgpu_ring *ring;
> -       int ver, i, j;
> +       struct amdgpu_vm *vm;
> +       u32 *ib_content;
> +       uint8_t *kptr;
> +       int ver, i, j, r;
>         u32 ring_idx, off;
>
>         iter.data =3D buffer;
> @@ -323,6 +331,80 @@ amdgpu_devcoredump_format(char *buffer, size_t count=
, struct amdgpu_coredump_inf
>         else if (coredump->reset_vram_lost)
>                 drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>
> +       if (coredump->num_ibs) {
> +               if (buffer)
> +                       vm =3D amdgpu_vm_lock_by_pasid(adev, &root, cored=
ump->pasid);
> +               else
> +                       vm =3D NULL;

Is there any point in doing the loop if the vm is NULL?

> +
> +               for (int i =3D 0; i < coredump->num_ibs && (!buffer || vm=
); i++) {
> +                       ib_content =3D kvmalloc_array(coredump->ibs[i].ib=
_size_dw, 4,
> +                                                   GFP_KERNEL);

Shouldn't this be GFP_NOWAIT?

Alex

> +                       if (!ib_content)
> +                               continue;
> +
> +                       if (!vm)
> +                               goto output_ib_content;
> +
> +                       va_start =3D coredump->ibs[i].gpu_addr & AMDGPU_G=
MC_HOLE_MASK;
> +                       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, va_st=
art / AMDGPU_GPU_PAGE_SIZE);
> +                       if (!mapping)
> +                               goto free_ib_content;
> +
> +                       offset =3D va_start - (mapping->start * AMDGPU_GP=
U_PAGE_SIZE);
> +                       abo =3D amdgpu_bo_ref(mapping->bo_va->base.bo);
> +                       r =3D amdgpu_bo_reserve(abo, false);
> +                       if (r)
> +                               goto free_ib_content;
> +
> +                       if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)=
 {
> +                               off =3D 0;
> +
> +                               if (abo->tbo.resource->mem_type !=3D TTM_=
PL_VRAM)
> +                                       goto unreserve_abo;
> +
> +                               amdgpu_res_first(abo->tbo.resource, offse=
t,
> +                                                coredump->ibs[i].ib_size=
_dw * 4,
> +                                                &cursor);
> +                               while (cursor.remaining) {
> +                                       amdgpu_device_mm_access(adev, cur=
sor.start / 4,
> +                                                               &ib_conte=
nt[off], cursor.size / 4,
> +                                                               false);
> +                                       off +=3D cursor.size;
> +                                       amdgpu_res_next(&cursor, cursor.s=
ize);
> +                               }
> +                       } else {
> +                               r =3D ttm_bo_kmap(&abo->tbo, 0,
> +                                               PFN_UP(abo->tbo.base.size=
),
> +                                               &abo->kmap);
> +                               if (r)
> +                                       goto unreserve_abo;
> +
> +                               kptr =3D amdgpu_bo_kptr(abo);
> +                               kptr +=3D offset;
> +                               memcpy(ib_content, kptr,
> +                                      coredump->ibs[i].ib_size_dw * 4);
> +
> +                               amdgpu_bo_kunmap(abo);
> +                       }
> +
> +output_ib_content:
> +                       drm_printf(&p, "\nIB #%d 0x%llx %d dw\n",
> +                                  i, coredump->ibs[i].gpu_addr, coredump=
->ibs[i].ib_size_dw);
> +                       for (int j =3D 0; j < coredump->ibs[i].ib_size_dw=
; j++)
> +                               drm_printf(&p, "0x%08x\n", ib_content[j])=
;
> +unreserve_abo:
> +                       if (vm)
> +                               amdgpu_bo_unreserve(abo);
> +free_ib_content:
> +                       kfree(ib_content);
> +               }
> +               if (vm) {
> +                       amdgpu_bo_unreserve(root);
> +                       amdgpu_bo_unref(&root);
> +               }
> +       }
> +
>         return count - iter.remain;
>  }
>
> --
> 2.43.0
>
