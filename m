Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A658E7E656
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 17:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E3510E40E;
	Tue, 26 Sep 2023 17:30:41 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEAC10E40E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 17:30:39 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1dcfb21f9d9so3164536fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 10:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695749439; x=1696354239; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxNlm12VxRyoKg7iG++JO4DT5DpZXQ6YDSz9MlzGuX4=;
 b=AtL180RrQeVscHHY/GEQVCh13kgTuo7htqz9iaHKTWxI2aBf9P2FZLWPPhbSNZKFVz
 SGu/DBJjidLyPs20YTjfeAFaANc+zOlIgZxIAeuitBNfOl1/ciHT7uZle5ueO+QPcGjQ
 /qv+FRCue5zKtemcIBFkCU2hYGCEAZdaLkv30lkJkzmuzlIhtDNxK/8x6e6knDlzGHQb
 /Np+djOvM7QvJ7cTHyWQ5o10Loqg3qh2tCpCjlZfwVkCdt+KBvOSfoi9EwDTqSWqMQcC
 NGrsyp2gC7bulg0IGdDG+3cI+rSUwf1uAtevTSjYqtNOdz3yPoM0dS0dvs+jl28e5Obz
 Hqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695749439; x=1696354239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxNlm12VxRyoKg7iG++JO4DT5DpZXQ6YDSz9MlzGuX4=;
 b=UNaDCwQQNu5fBx9VhIfhbX/NLf1ueXGqGWFYRbRVOTPhnpxffCg+jxWlpHyQ8N+PwB
 NA84ErIJB95qlkRdhZlTxBEZaaN7ny6WQtb7oE48Try6tEgixOiWfBGQUZ6nIuB76xGD
 mFbc1c2HaHMLimaqaz6yufR6Zcz7tqFi4JRHVp61umSslAqytngFWRa9kqqae5TCmccM
 zFK7vkH8BmSWSugZbiAcjcdfzyMtXWO67o9mFafWSXItJenQa9FmPSH0v4DH1ntGKzE7
 xXrOSesQy+rahRiVxc3PQ5Ih2kliAPamj9OCAy3q53gR+z/f3/ADB3FZUtyfKiMxh4Kp
 CfnA==
X-Gm-Message-State: AOJu0YzGZrZcVcCJkQPxuhn2v3EbwtVvst76vWWq7Y3IybCpcsUrZj1S
 1StwEiiCpFnfGVMWbLVFEIdAfPsnaiuKydKZLCtAn0vq
X-Google-Smtp-Source: AGHT+IFi7HLH6ylwOcG7ZkfIIvoXjrGYgUfChMh5Bkoh+t05ZJVMAlcQt3I+0DfUvb+ifyXkBdBGk1bLRaFmOQh96TQ=
X-Received: by 2002:a05:6870:7027:b0:1d5:91d6:65f3 with SMTP id
 u39-20020a056870702700b001d591d665f3mr12087213oae.7.1695749438704; Tue, 26
 Sep 2023 10:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230921214019.926691-1-alexander.deucher@amd.com>
In-Reply-To: <20230921214019.926691-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Sep 2023 13:30:27 -0400
Message-ID: <CADnq5_OSqC1MbV1MJr778CEJsLx5HyaVHDsGae7phReoKMCnuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: add a way to force a particular
 placement for GART
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

Ping on this series?

On Thu, Sep 21, 2023 at 5:46=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> We normally place GART based on the location of VRAM and the
> available address space around that, but provide an option
> to force a particular location for hardware that needs it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 +++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  8 ++++++++
>  2 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index f74a51a93ebb..d1d98488373b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -287,11 +287,22 @@ void amdgpu_gmc_gart_location(struct amdgpu_device =
*adev, struct amdgpu_gmc *mc)
>                 mc->gart_size =3D max(size_bf, size_af);
>         }
>
> -       if ((size_bf >=3D mc->gart_size && size_bf < size_af) ||
> -           (size_af < mc->gart_size))
> -               mc->gart_start =3D 0;
> -       else
> +       switch (mc->gart_placement) {
> +       case AMDGPU_GART_PLACEMENT_HIGH:
>                 mc->gart_start =3D max_mc_address - mc->gart_size + 1;
> +               break;
> +       case AMDGPU_GART_PLACEMENT_LOW:
> +               mc->gart_start =3D 0;
> +               break;
> +       case AMDGPU_GART_PLACEMENT_BEST_FIT:
> +       default:
> +               if ((size_bf >=3D mc->gart_size && size_bf < size_af) ||
> +                   (size_af < mc->gart_size))
> +                       mc->gart_start =3D 0;
> +               else
> +                       mc->gart_start =3D max_mc_address - mc->gart_size=
 + 1;
> +               break;
> +       }
>
>         mc->gart_start &=3D ~(four_gb - 1);
>         mc->gart_end =3D mc->gart_start + mc->gart_size - 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index dd0ede75e5d7..fcef057b9213 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -199,6 +199,12 @@ struct amdgpu_mem_partition_info {
>
>  #define INVALID_PFN    -1
>
> +enum amdgpu_gart_placement {
> +       AMDGPU_GART_PLACEMENT_BEST_FIT =3D 0,
> +       AMDGPU_GART_PLACEMENT_HIGH,
> +       AMDGPU_GART_PLACEMENT_LOW,
> +};
> +
>  struct amdgpu_gmc {
>         /* FB's physical address in MMIO space (for CPU to
>          * map FB). This is different compared to the agp/
> @@ -339,6 +345,8 @@ struct amdgpu_gmc {
>         bool flush_tlb_needs_extra_type_0;
>         bool flush_tlb_needs_extra_type_2;
>         bool flush_pasid_uses_kiq;
> +
> +       enum amdgpu_gart_placement gart_placement;
>  };
>
>  #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_=
funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
> --
> 2.41.0
>
