Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D63E909BA
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 15:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99CEB10E4EE;
	Tue, 17 Feb 2026 15:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NisM8SzN";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D03E810E4EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 15:28:28 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-124a7216c9cso267313c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 07:28:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771342108; cv=none;
 d=google.com; s=arc-20240605;
 b=T6SGNHMzIZtJqupOJyPwAf6a3U7bQjJXojLy85OXjdLTkoshcYtG1HjcCNoPAiPHu8
 pIzJy6oZp7CPkhUhfxp1Scw4vXpjz9KhSJikGZKCdgp+aUKBUcg7zmSGs48/yGezbv+c
 sIe8oEPV/f1u0mSNvON/DjCdcpqXes4623QvEdXh5f4348hG3q4mhQXm49JdoCsXNt6S
 LTkalYhVhEbHBOOvipmwnPreuOfMvNc97Hh+lTEJy2v2WTVgdqI1Kk2hayDKC+wxXHdm
 VtHcKYxDPbhAImfsKze98gadu1HHUgAvvpO168YEM0uIyrK2rXLXTy5FVXaRxpPeER2X
 GEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ufmQD3OIHdNDkqyN8QBdlJ5fh07kgQpg6MLvFRxVA8Q=;
 fh=bVuJeTjm6D+KiLW00+lXIpM5IeTQ8rvAwjdu2ta+i4Y=;
 b=KdBpUIHSUg2JGfAHsqPiH/IMyez6yKOe0WaAPnTRwPR2MXIc/J0dYKPBACSgO+NHeR
 s8INPdIjmpNrDYdUUx6TWgJtwOhsjwb8EDfU2BBJb+i7KqcqAfMl9Q+oYTnZQ+XYHg2m
 MyWtqpoziWZBnoZQLLEXagSKhX1ZLl3ArOvv6gMHQl3kPwrtKFKDxV2HUj0ssgWPGg1b
 e4BEa3BERcdtQugnKfJVY/t7M37IPxVpJ8zPTY578/88dG4u/oViQw7RV1q3l7s0JtqQ
 fzzMzx+Zq5uF+F9VymE6n2vg/P8Eo4C5UZRgOacUw9nTctTt9ZLXFJm+0Oyf7v70mcpO
 xXww==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771342108; x=1771946908; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufmQD3OIHdNDkqyN8QBdlJ5fh07kgQpg6MLvFRxVA8Q=;
 b=NisM8SzNp97ssof/mSbKKUCxEvk+uw0lNIJWrLylN/6gVEQbf7Hy2EUaXVXqB8rNEg
 5gPNv2Bdz1HpJXWsPBI0GsNhQ0bebkK1kB9UyPr5jwps/0sHByLpusib+KAWPIGUeB8u
 q5rxBgLV9ifUxNuDJD6lxneqoeHtdBRyx9fBwZIMfOKAqPPk69A7jV/YaE55Pf6nDRvS
 xiypQMMtGRBNnNzqlUEcz+eELnp+FnOSHxk/sHo1BMCgASXjs1TL8x7wAk3gesID1yCI
 2QTWxiK4LzEkBFucLDozzAcFsm9C1Qki4LBV5jT25BJeZZmz5MPhCRxXbVVb1r9YHSPF
 cxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771342108; x=1771946908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ufmQD3OIHdNDkqyN8QBdlJ5fh07kgQpg6MLvFRxVA8Q=;
 b=Wp7xNegZRGC/qGOJDPFiH+aZEjzXlH1aBcBUJjv4SDtOxjn9WzGjrQrmYOLYdvGDcV
 Bfjx13N1wXp4klWApG1dtN8tx5i1Ye+PdZ9NVIerWggflg5xXz7Wf90gfNJWc+1HXz4D
 r1tjDa7CUPOU6hwCcJZwZIU7WT8dri6Tr4BvnGsVLLkd1CIH9SzxC2r4V8hcYHisqTV7
 3ZEa0yQ35Z8pfcpyprgavu0hsPEtCuYZLJLALYLTUjmQjyyXIGUl6eQzNIoS3qJfcbGG
 G9Mej92H9RUQFRl73+nQrQNCvbMuIZ1VULmg5iHVO2IEOWkLVzIUegvhFIcP0fPqn1gU
 aNjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdX2ga04aSw8AMBX6dEOheeE630sH45JZNd2h/20bA0jqgNU+i27wo2wnHCf6lEPJlwrLPsAUI@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyw4/Vk5FsKySxLVIzURr2hM8sg77kOC3yKHiyV9qgV4rBYYP2d
 yu1N76+QAEkQl/fRJ4sgaKCXJnX8nqgSAVOXlN9Fg81Ix4M11aTVPudBAQ5Qjsbg/mdxHa14M0Q
 jJe0ZGtbbIAlBYc4/8LfSi9Df7QxrHoA=
X-Gm-Gg: AZuq6aLWfF0xn0htLQuxnBzfN+JWuOohsSqXfI7J5I4RavEh3RBpe7+8YECPt4doEiZ
 2FBDuF28xvDmiED5GEjpic88KruA/ezfezK6wCBQnemo0LZmccNUI3G3SHgS392OCetplClNCet
 03JL7S1PKYg7Seq2jzqycLOd0iNt2+1oVIVHUV4ac8Nvlg/tmYhev/Wkm7ZIF7D60oA2v4X2tEI
 NoASFOeVMjeabAFuUdO6YEnwiu3FkuLtkAJlWKQ5FwOrz4gnesY2L1HvTL5UzQZ+DFYuEUOrfgE
 YMEbLSNbYiAAhqKGeKKr2Sh3DXGVg4u9h5Sr70amsaX9NKBBkObZqQ6iVCr5jtAG+5h0sw==
X-Received: by 2002:a05:7022:3a8e:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-1273985af47mr2882583c88.4.1771342107925; Tue, 17 Feb 2026
 07:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20260217100114.2019-1-christian.koenig@amd.com>
In-Reply-To: <20260217100114.2019-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Feb 2026 10:28:16 -0500
X-Gm-Features: AaiRm52fflMVUd_YLBu1e7nlIGqO5PzGoR7iSDQT7SMlGU3wIH2fiKzN0j9V6NI
Message-ID: <CADnq5_P9FJfN_khqm0YcLcf_VCs0ODmgOzJF2JdoNuTm-TfyeQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix 4-level paging if GMC supports 57-bit VA
 v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
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

On Tue, Feb 17, 2026 at 5:10=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> It turned that using 4 level page tables on GMC generations which support
> 57bit VAs actually doesn't work at all.
>
> Background is that the GMC actually can't switch between 4 and 5 levels,
> but rather just uses a subset of address space when less than 5 levels ar=
e
> selected.
>
> Philip already removed the automatically switch to 4levels, now fix it as
> well should it be enabled by module parameters.
>
> v2: fix AMDGPU_GMC_HOLE_MASK as well, fix off by one issue pointed out
>     by Philip
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
>  3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index e8e8bfa098c3..0e8a52d96573 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -33,9 +33,9 @@
>  #include "amdgpu_ras.h"
>
>  /* VA hole for 48bit and 57bit addresses */
> -#define AMDGPU_GMC_HOLE_START  (adev->vm_manager.root_level =3D=3D AMDGP=
U_VM_PDB3 ?\
> +#define AMDGPU_GMC_HOLE_START  (adev->vm_manager.max_level =3D=3D 4 ?\
>                                 0x0100000000000000ULL : 0x000080000000000=
0ULL)
> -#define AMDGPU_GMC_HOLE_END    (adev->vm_manager.root_level =3D=3D AMDGP=
U_VM_PDB3 ?\
> +#define AMDGPU_GMC_HOLE_END    (adev->vm_manager.max_level =3D=3D 4 ?\
>                                 0xff00000000000000ULL : 0xffff80000000000=
0ULL)
>
>  /*
> @@ -45,8 +45,8 @@
>   * This mask is used to remove the upper 16bits of the VA and so come up=
 with
>   * the linear addr value.
>   */
> -#define AMDGPU_GMC_HOLE_MASK   (adev->vm_manager.root_level =3D=3D AMDGP=
U_VM_PDB3 ?\
> -                               0x00ffffffffffffffULL : 0x0000fffffffffff=
fULL)
> +#define AMDGPU_GMC_HOLE_MASK   (adev->vm_manager.max_level =3D=3D 4 ?\
> +                               0x01ffffffffffffffULL : 0x0000fffffffffff=
fULL)
>
>  /*
>   * Ring size as power of two for the log of recent faults.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index dfad7d11826c..c6fd3a091613 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2409,6 +2409,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *ad=
ev, uint32_t min_vm_size,
>         }
>
>         adev->vm_manager.max_pfn =3D (uint64_t)vm_size << 18;
> +       adev->vm_manager.max_level =3D max_level;
>
>         tmp =3D roundup_pow_of_two(adev->vm_manager.max_pfn);
>         if (amdgpu_vm_block_size !=3D -1)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 139642eacdd0..806d62ed61ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -456,6 +456,7 @@ struct amdgpu_vm_manager {
>         bool                                    concurrent_flush;
>
>         uint64_t                                max_pfn;
> +       uint32_t                                max_level;
>         uint32_t                                num_level;
>         uint32_t                                block_size;
>         uint32_t                                fragment_size;
> --
> 2.43.0
>
