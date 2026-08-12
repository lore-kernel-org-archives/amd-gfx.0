Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D306AC5B572
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 18:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CDA810E431;
	Wed, 12 Aug 2026 18:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="feZ0iJ8E";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ABEA88284
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 18:16:22 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-385b78b4f9bso257100a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 11:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786558582; cv=none;
 d=google.com; s=arc-20260327;
 b=ajjhbgi/hFUUWNPcuawbHCZwxumBwoVl/8sIbDwu2MuPbtObvxYwXMKKKrO4UQmRHP
 0tYZZQ5TCC3EoZuewxPNNiORdpLgnxWN9nGrqCVaEclzcJUm6I5RlCvSU+sZ5B365Q5o
 JJYZaxjs7Cl0v94V+GMa9Qfrr53zDsVzng3NSDseTvv22gkTETKovo93AmWarAxvPdtm
 v5bXXPooGOU4D5tVnJKAQj1H8UPlEr5tLoY3Yg9AIuNrH3mSoag+/j81NEy+BOQFnh/j
 OAhbqRa7rxIRyFWSi/NAbd6htrTPZdVuS7t1tKT+UWKnV8aG0xCFBpv2kBacRjxn/PH9
 BC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=INfKdNyfSAdKetVosriuTBst0Y0LXqyweHxayhMb5zY=;
 fh=Z6e2jdR2G/AUuX+q4GGIfqbAPmAaehXX6daJp97J0YY=;
 b=iJv/YBzFD4izVeG8TjFzQJvaTbsJei90dfq5RX+Jj8NVjWHvT0U1bBgKiUw8OCNlZz
 H+njRTmsZdlmH56NcuSotCvuUqcHSg4iIgA5wMCfrDtmZFdu522ol0d+L0dKxJIuEDHC
 jap6pxEpGrkvAoxDG7pRlczaNXXRRetNeBcktVPrtQrhOptDt8KCZr5j26o5Cf4cLzD7
 TLo/v9WtwGaRdhN9PdMykUIBsNCXZHOeW4tM35DL2mY41MuyQ8a4QwfI3umKfmsi8YI2
 ozNzuHWc7vsIsXrhoiYvbwXpHn6hR9UEVfy/74YDqWFXCYqYyIgyJV3q7jLeeLQgJq36
 UdEA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786558582; x=1787163382; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=INfKdNyfSAdKetVosriuTBst0Y0LXqyweHxayhMb5zY=;
 b=feZ0iJ8EB/03REaon3H7awaIVZOm0LVEDHW4cqDuvtfkFZTndjGbOv8V1c4bd7Nmey
 4bpZRgyM+qRnTYII0i/B3LYvvlHbAEpNou0x5Lj3xvr+lnCzgtBUuD+qp54Lc+nr5rUK
 j6QkerZz5VO6+pakZv69mNPrA/+hKUP2hJNgpHTL8Sw5NDIH25EcurhDsQwcwSHGDlos
 KIo5dNcKGVrWwCw7ry3WFeiJQpQjKn2tKM2XudU+9iTScNjfJK9CCFASSVLdpQhDsawK
 OeN3wwNhlVHR5rJ95zcMe0c8rw0uj8l23GKwh6IGLggOrxw3HecWMZJvHertvLPiS5XB
 7uCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786558582; x=1787163382;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=INfKdNyfSAdKetVosriuTBst0Y0LXqyweHxayhMb5zY=;
 b=iLL/EMsDBG6X4D8QY71ATkrEGkYDqPV4eZZS6iuz1RSV1Zky82hR1Hp0FeY9i5idjM
 jVJRGCVMKUkm60JPtrsVm4GlbX8wBPIzSTzpQt2OuuJVUKnx7hPxKw1Vq5iDlHI1mZMT
 jhtW9y1wdcdraec5sQkZyf+wAB6oLykVqBMrbrRJvv8QRxKLsgUOiKQjvdU8PD2RVqoz
 /bnbUpTmNWq+O5/UlTbeb1SMaIBN8/822b7EizBy2czf/921Em7VqMblhNbxFHA5uhKN
 juVAxQMbJlh3ukDoJS7GQ5E69qEXKBXghBqv6JZuipMAJBOgqAH3GkA47gBheqtvHTYK
 uSiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPB702DSxEfLbNVKXXq1fwger/lMaEfS81jKWKTnP7Xi6M4wOm39VvsUWdhLvB7ufrlkh6gU3E@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywo2Qe5TrpfP4dpu9xtZsiRx9l2Q9nuA30BbV+X85x94rB+I1vh
 v2coI5TqNI+pxpY0Gepm5DFdto7lwoyXN1h0c8X2JyNHQF8yLIDeUhy5B7672V4Z6iBc+MygM0t
 YjC9/bXRhjL6tnlfw159WaXoL53FPWRI=
X-Gm-Gg: AR+sD11jCOaq7NHOPxe7XGkNBp1X/CKrCpaUHbXg6l3RVuFSuNFKQL8PYjKerKOWgKL
 buTLiQCFjdri/Kx+EidBd0eaRMFqjvOsUtF9URUM8afyY38Fs1dsauYcw48LPw9k6OOrLk56tDO
 4Vfqtjiat8jh8/v0P+t7J1l8ypVHRnJ9sFbPnpbKcLduMtlThOmmyXEUoa7nuSjfab5fMGbdVim
 ICrnw4xd+CL60TDsvERriR4cAtSqMftM3prPPRDeb39ZYE4CsXaKK0EqE21xjK8vAWaoYevff13
 Vl/Q9acqTE6+gbA/0iVuNuGO8m/Wdqm+PtkdX7iqrQii9AoOYg1EoJqrDl/zoEt35Ngwefg4bPs
 h9qXBwqGGHYD+zetdPkxOMgJ+QMh6xzU=
X-Received: by 2002:a17:90b:51c1:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-3931e2dd668mr39435a91.3.1786558581695; Wed, 12 Aug 2026
 11:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260717022550.6549-1-lingshan.zhu@amd.com>
In-Reply-To: <20260717022550.6549-1-lingshan.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Aug 2026 14:16:10 -0400
X-Gm-Features: AUfX_mykETXq8O8oPfDjYHAugfOtqs_SXrCCHidInv5uqjEA9bLJiFPKSopZ29k
Message-ID: <CADnq5_NDJLhk51JcJN6T8nZeyOUiRyJV34Z2NNyGsje2Mkc7Gw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix userq page count in input_validate
To: Zhu Lingshan <lingshan.zhu@amd.com>
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Ray.Huang@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Thu, Jul 16, 2026 at 10:44=E2=80=AFPM Zhu Lingshan <lingshan.zhu@amd.com=
> wrote:
>
> amdgpu_userq_input_va_validate() converts userq
> expected_size to page count by right shift.
>
> This undercounts va buffers that less than a page.
> For example, in the AMDGPU_HW_IP_COMPUTE userq
> creation case, the expected_size 2048,
> so size(page count) becomes zero page and the
> "va_map->last - user_addr + 1 >=3D size" is always true
> once the start addr locates in the va_map mapping.
>
> A similar case is AMDGPU_HW_IP_DMA, where expected_size is 32.
>
> This commit calculates a proper page count by subtracting
> the start_addr and end_addr in pages.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 969f49592450..f9f11bdf2cef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -25,6 +25,7 @@
>  #include <drm/drm_auth.h>
>  #include <drm/drm_exec.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/overflow.h>
>  #include <drm/drm_drv.h>
>
>  #include "amdgpu.h"
> @@ -238,14 +239,21 @@ int amdgpu_userq_input_va_validate(struct amdgpu_de=
vice *adev,
>  {
>         struct amdgpu_bo_va_mapping *va_map;
>         struct amdgpu_vm *vm =3D queue->vm;
> -       u64 user_addr;
> +       u64 user_addr, end;
>         u64 size;
>
>         /* Caller must hold vm->root.bo reservation */
>         dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>
> -       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SH=
IFT;
> -       size =3D expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> +       if (!expected_size)
> +               return -EINVAL;
> +
> +       user_addr =3D addr & AMDGPU_GMC_HOLE_MASK;
> +       if (check_add_overflow(user_addr, expected_size - 1, &end))
> +               return -EINVAL;
> +
> +       user_addr >>=3D AMDGPU_GPU_PAGE_SHIFT;
> +       size =3D (end >> AMDGPU_GPU_PAGE_SHIFT) - user_addr + 1;
>
>         va_map =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>         if (!va_map)
> --
> 2.53.0
>
