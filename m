Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25385EB3624
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 18:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8005010E58B;
	Mon,  2 Mar 2026 18:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BwbX7wCe";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F155410E58B
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 18:47:58 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-124a5810e41so336984c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2026 10:47:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772477278; cv=none;
 d=google.com; s=arc-20240605;
 b=fVab9SnZ/bSlUNhzuXHtQIXuXAYn/BIMOOwlK2DeeXXZs/kpen16IEPLSuZfNJiNfI
 Ny4dRA2Aezf9jJIKoCaAqIfknwfwEvtnP+5xaT04jzNxkcpCUVm2+HprYh+rafaOMSek
 CSyXR1Na25drNdOzKW5vv2IGBXdKm1zJOL1QS4JezYs1KfygJbtU/B5ZGkKuAaeDSb9u
 gYfyFOIiuJVIMvHcuFFUZjs90ptTbOvxfQTNiNCLfw5QIZwI2a1JPrBwqBv7YY1qaZyF
 VCY8N/1T+lbcqCZcMlbGOWlYHVvj55ZbYCfQ5I4MlvXvNvmRrCf+jH8PZJmXldS2VVVE
 tQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PhaxULRQYchacioDU3vakiclpPLY/jVd5nFbk4UvYrY=;
 fh=5o17x/9fV3VzOOnqJBPsbzDynGsLhZlIGkzGL+sZ5OY=;
 b=VdZWBgQK6MicpIS3upcogEQWrikm6x3Z30V/6U/RUnlQaNIlPr/ez63Z16TbsyaDSJ
 5t5sXIIGvmvDrFXEtmUC/dzi8GEr//oxtQCqVmgb9wSzYr351ZQ9Z5cmGZno53e+/ckR
 DRB1eArcL0wq16p2UH5IdzGBa5UZW4rVDrww+uRz0Ip4c4/5/QFEwUcCaHTD10P8icep
 ylc1YvTK5v/ZngD5x356RT69cE9uX9E/iSjFQMiBsOWO4g10dwp0bDfqrxtm5NSe7c6S
 FCTjEb/vtkTXCOZ4ySxlG1jxQfRyRvV6huDU22fE5f3mB1okUJA/jN61z0EMc0GdA1gD
 4utA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772477278; x=1773082078; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhaxULRQYchacioDU3vakiclpPLY/jVd5nFbk4UvYrY=;
 b=BwbX7wCeslJVMpNQZBrdKQPmRqoGPEBJCxTNGIzzRqCaqG6A/pt6DMzsfNb/MKMYR4
 NkHsSbPu4rKnIatuhXs/jKD1OygQOTyswjuFX7zHYYQQa0pNkISoofM+qK3PHh70F92K
 YtEpdNMYNKpq7xQlaEKLc6u/LDn8LzjZcrHhfoszBPQGl6XS5WPq6MIqwj5FdXILwbb5
 UpZqejffU4UF79c573OBYeFF85PLuUfZzk1xox/IKhhY1cV23ZZIv7Wx13pp1pexahrf
 lKPKJ2Sve4cN1614Wq7Qc8vndZ/ccppFbiGLzWV6J/3b/NANc9TsPX22bEjE/Nx3ZeeZ
 n1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772477278; x=1773082078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PhaxULRQYchacioDU3vakiclpPLY/jVd5nFbk4UvYrY=;
 b=QnNhjXMy9yXvdObMxyQ0F2HECDe1aZtEloX1eke3rj1bNkINFevRO7tjTzgrKnqqky
 KsqVVCfJHUaklSbN1te8VMRlBhUhlQgZYTIO4GQc9H0Lyeb5dwFcjvk1xYmLR2B3iUHi
 MB1IPTfCHY7QIZYjHDlkRW7MRm+ndbP8G3fOJpXQnYyVuT/PMxKD78kGSq8eNSTGasbc
 Lmu+rNFdzbATVFuS7iVESOR2xkEFR3jyQj7QjkpyWrujc5+hzgv7/J3uma4MZHUeX7OS
 uRhtOFgnG0afPX4/SsioIyQg/wKFricv3651T/f7zuWRhsttt4NEC7zusBDgXcdHZfKH
 osPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuYIBqTKNU88SaJFXO/aNG0KUTt0z8ZTiduEYDB0fnfr9wXaw0yIJX8Roorj8OtxpPJV/lQdH1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxykWauLB17i4EcN8i2TG6nWmqzrl+QSiCKjMblYSRbFfzE1BfJ
 sdJIgQ/GQ6lOXHNpSztkQLwGddNXppIowQtAbJs+MQRloyeE9dDozpBAw496bL4MiqYfWxxJtDf
 0LJYkzm4+RZA8zUsY/zgrOzHqnZLTYEg=
X-Gm-Gg: ATEYQzwWzaCpK7Lwjmy84oB4CR0wsCT2mTQ7NRwdX3aFERw53x/6fbx4TwewNiSIubI
 les3N2T8xS3WC5e9OftI//SEW3KFkF45xbrr/bWEntjkwNsHxEPaXo4p0YknzJPR9sVk1+/b32h
 pfdwkUoL/48tx8VWL4VTdSb3O14pnU79LObsPiRH78fwjO3ZTuXWdRaDUL14GWSMBOt8QH+y70i
 sGc2sWf0A67Mjfv5WYtsiW7EevsDh67cOaZazktrS+Bzf53Uw/0fLAcxZ1ybGgaqdOZO5EmhsDp
 od7sI2fsxqDkWSpP1cpliZgCT1z2Gc1HaQz/l6Jn+Iu1GgowOXBOTFMqcVoXISyyK3LAHg==
X-Received: by 2002:a05:7022:439e:b0:127:1186:812f with SMTP id
 a92af1059eb24-1278fd12699mr2707242c88.7.1772477277777; Mon, 02 Mar 2026
 10:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20260226093727.2584-1-pierre-eric.pelloux-prayer@amd.com>
 <20260226093727.2584-6-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260226093727.2584-6-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Mar 2026 13:47:45 -0500
X-Gm-Features: AaiRm52KgTUh-oE9R4J6uimSKwR89a_13yJJU7x5eCzcIbspb-yc-pcKUsAVKa4
Message-ID: <CADnq5_NMc0HSQy7x3DxZaox6myjjDkCtBEO7cp0523XNs+X1Jg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/amdgpu: dump job ibs in the devcoredump
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

On Thu, Feb 26, 2026 at 4:49=E2=80=AFAM Pierre-Eric Pelloux-Prayer
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
> ---
> v2: added some comments
> ---
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 93 ++++++++++++++++++-
>  1 file changed, 92 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index d0af8a294abf..e489bf089bc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -200,14 +200,24 @@ static void amdgpu_devcoredump_fw_info(struct amdgp=
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
> +       bool sizing_pass;
>
> +       sizing_pass =3D buffer =3D=3D NULL;
>         iter.data =3D buffer;
>         iter.offset =3D 0;
>         iter.remain =3D count;
> @@ -323,6 +333,87 @@ amdgpu_devcoredump_format(char *buffer, size_t count=
, struct amdgpu_coredump_inf
>         else if (coredump->reset_vram_lost)
>                 drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>
> +       if (coredump->num_ibs) {
> +               /* Don't try to lookup the VM or map the BOs when calcula=
ting the
> +                * size required to store the devcoredump.
> +                */
> +               if (sizing_pass)
> +                       vm =3D NULL;
> +               else
> +                       vm =3D amdgpu_vm_lock_by_pasid(adev, &root, cored=
ump->pasid);
> +
> +               for (int i =3D 0; i < coredump->num_ibs && (sizing_pass |=
| vm); i++) {
> +                       ib_content =3D kvmalloc_array(coredump->ibs[i].ib=
_size_dw, 4,
> +                                                   GFP_KERNEL);
> +                       if (!ib_content)
> +                               continue;
> +
> +                       /* vm=3DNULL can only happen when 'sizing_pass' i=
s true. Skip to the
> +                        * drm_printf() calls (ib_content doesn't need to=
 be initialized
> +                        * as its content won't be written anywhere).
> +                        */
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
