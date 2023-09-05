Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC4EEE49AD
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 22:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E06A10E3C9;
	Tue,  5 Sep 2023 22:47:43 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9717810E3C9
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 22:47:41 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3aa139a0ab2so2258827b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693954061; x=1694558861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FmsZzeyCRBlqyvHoHfiBgB2mEpki4O044MNtSmLBIlI=;
 b=BbCfv27JPWebHe0t/k68wz7DVlj1MqZJ8MoXE2gfEEzzcm/q+125TAbfOz0YHJEpKC
 oAQW2XSZDyAy7u/cRPlTiyfFMm2qeY9D0td+h6fvkDOuQ8EsLxESWvyzNafNDIoqKXIs
 F0S8RH6Kc3VboMa7tfpUBFtQVsgoLbivbKZ0eXOZdOsW/UaEWKiTf7TgxWKaIYn3NFNZ
 4LpqadtJXgcJRSTYDXGou6Uf60iPv1PRgwoPpbXfSKPNFGQwC8FDK8bnT5i21soWcHRt
 BMBWvmOh8v4m6YeU0TLNLpvzxPig6e1ydBDjee86/rb1+FkE0golR3TC3fzDZsZiY6dn
 zVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693954061; x=1694558861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FmsZzeyCRBlqyvHoHfiBgB2mEpki4O044MNtSmLBIlI=;
 b=ImQ5XM0RBBL2rsWyruyQg5HChbnXFLo4t4rqIDigO7GAwjEfNgPvuNo3c/v2Yey6Vh
 QLpuZCwHCV5YxpkIcW6JuCpxqsFqbBGjF8n2RyzhwKCavpUqV868kBRiqqTVFwa7tLY4
 RJhW4HMNEl8Mvwh0dxr9VBln9bR54sYarAUj4b4ZLc8Dpj4zsHZgbNy9ERWbZCJ26jzp
 gyXxsLtB/beAfPwFtPYm7/Hv9xI54+m9HL6B91J9MF60SBJsKi7GDc/DLKJll0sYxMN3
 gmgZk8738oCJ8gocN6mmdVjiwXiD/30W+pHd86CwrTIn1qypAo1jPo7cpJ/kR3zYg6QI
 A+vw==
X-Gm-Message-State: AOJu0Yzd9yG0/htNHHizGg2ay9egOM4kMs2pmxc+mYze6TR4UlcLymb/
 gZ+MxS+gm8ul+WxrWahwHzjchGiU8M3kSEn1EAP6h37zd2Q=
X-Google-Smtp-Source: AGHT+IGA3ehnKttusdc0zsHvpTcw1oDaNYlBkZcTERNrR1OBj6ZBTZ2z9iUD6G/+VfJmfUKuuByYf6jESTG+N3QjITI=
X-Received: by 2002:a05:6808:220c:b0:3a8:5502:35aa with SMTP id
 bd12-20020a056808220c00b003a8550235aamr17768906oib.14.1693954060795; Tue, 05
 Sep 2023 15:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-9-christian.koenig@amd.com>
In-Reply-To: <20230905060415.1400-9-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 18:47:29 -0400
Message-ID: <CADnq5_PRQVxGuUA=0d-HamUm6bpW975AajmOpxbt0gozxyW5CA@mail.gmail.com>
Subject: Re: [PATCH 08/11] drm/amdgpu: fix and cleanup
 gmc_v11_0_flush_gpu_tlb_pasid
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 5, 2023 at 3:00=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The same PASID can be used by more than one VMID, reset each of them.
>
> Use the common KIQ handling.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 63 ++++++++------------------
>  1 file changed, 19 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 3c3ad3f17c6a..aa39c1087e44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -303,54 +303,27 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amd=
gpu_device *adev,
>                                         uint16_t pasid, uint32_t flush_ty=
pe,
>                                         bool all_hub, uint32_t inst)
>  {
> +       uint16_t queried;
>         int vmid, i;
> -       signed long r;
> -       uint32_t seq;
> -       uint16_t queried_pasid;
> -       bool ret;
> -       struct amdgpu_ring *ring =3D &adev->gfx.kiq[0].ring;
> -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> -
> -       if (amdgpu_emu_mode =3D=3D 0 && ring->sched.ready) {
> -               spin_lock(&adev->gfx.kiq[0].ring_lock);
> -               /* 2 dwords flush + 8 dwords fence */
> -               amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + =
8);
> -               kiq->pmf->kiq_invalidate_tlbs(ring,
> -                                       pasid, flush_type, all_hub);
> -               r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_W=
AIT);
> -               if (r) {
> -                       amdgpu_ring_undo(ring);
> -                       spin_unlock(&adev->gfx.kiq[0].ring_lock);
> -                       return -ETIME;
> -               }
> -
> -               amdgpu_ring_commit(ring);
> -               spin_unlock(&adev->gfx.kiq[0].ring_lock);
> -               r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_tim=
eout);
> -               if (r < 1) {
> -                       dev_err(adev->dev, "wait for kiq fence error: %ld=
.\n", r);
> -                       return -ETIME;
> -               }
> -
> -               return 0;
> -       }
>
>         for (vmid =3D 1; vmid < 16; vmid++) {
> -
> -               ret =3D gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
> -                               &queried_pasid);
> -               if (ret && queried_pasid =3D=3D pasid) {
> -                       if (all_hub) {
> -                               for_each_set_bit(i, adev->vmhubs_mask, AM=
DGPU_MAX_VMHUBS)
> -                                       gmc_v11_0_flush_gpu_tlb(adev, vmi=
d,
> -                                                       i, flush_type);
> -                       } else {
> -                               gmc_v11_0_flush_gpu_tlb(adev, vmid,
> -                                               AMDGPU_GFXHUB(0), flush_t=
ype);
> -                       }
> +               bool valid;
> +
> +               valid =3D gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmi=
d,
> +                                                             &queried);
> +               if (!valid || queried =3D=3D pasid)
> +                       continue;
> +
> +               if (all_hub) {
> +                       for_each_set_bit(i, adev->vmhubs_mask,
> +                                        AMDGPU_MAX_VMHUBS)
> +                               gmc_v11_0_flush_gpu_tlb(adev, vmid, i,
> +                                                       flush_type);
> +               } else {
> +                       gmc_v11_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB=
(0),
> +                                               flush_type);
>                 }
>         }
> -
>         return 0;
>  }
>
> @@ -918,8 +891,10 @@ static int gmc_v11_0_gart_enable(struct amdgpu_devic=
e *adev)
>
>  static int gmc_v11_0_hw_init(void *handle)
>  {
> -       int r;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       int r;
> +
> +       adev->gmc.flush_pasid_uses_kiq =3D !amdgpu_emu_mode;
>
>         /* The sequence of these two function calls matters.*/
>         gmc_v11_0_init_golden_registers(adev);
> --
> 2.34.1
>
