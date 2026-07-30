Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5434EC55160
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 13:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E710910E165;
	Thu, 30 Jul 2026 13:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="em5bw9y1";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 784D710E165
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 13:23:11 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3856d4015e0so187198a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 06:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785417791; cv=none;
 d=google.com; s=arc-20260327;
 b=CJTHaFemDT+78zP9NJ664zvrVuYXhtdNtuo6uKoMvp4SbLK0ePzlIBzIPxTFp6PycO
 REU1RQybW9S80583ocIm49Ob0nZhRfu46u7RvXrmzDpDq0bjFKD36fns1XlK0aX6eRBj
 +jWQh482s9m1yTS8Fke/D7stDOZH/Je1kX3UYVrJ4kapcioQuQEvAFEg1w/LcVVTLnZ8
 AWDLhYWAYYGXAR2ZgMG7gw0GNg3L/6Jnd7J+YEfhUP4QHjJzHOehjg5wwTmU9yoPhD6U
 5mpCMnDr6AViX0iNfzj5s4Q8IHHVJYV2bDtHJQ+9CXUaeYv4kWNiaI7ZpU/08rdDTL50
 pfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eiO9AlycSvB7reIypDwr+RKc2EG5upEokIqWQ0C5TEE=;
 fh=AajwJS1JdmeCA/R2a2iHSEDl9rLQk6bWvk/8uoWqlmM=;
 b=g8pjqZe2D16fHuSHB32OgHYaTfopaMIfLRKzLqWVz3+60a4mSyyqz03NzQJMjckaEI
 6ir11XU5yl/uYVphYWDMw2aWV8xm2UQG6mcDF3H0X4y/i2BEJtwnchGArq03KEUy2wiS
 5FvyTG2uyOj5Vvh0Vhz+mzsrROlxtubB0VuV9dtW33DpCBM+48b1Q5lub0tJcBx6lQqN
 iIPn+vlJg6iROweq3+IJiTbhx0a8pTn/URCMlYq7f+vRCXrnsr36teq7QY2FOqdkK6ra
 fXWXVkMNw21XREs2JlhKYCGsqmVdkNcy5aR2iMLYmKJ7KCr+zEvogtzHxu06B4kF5FJM
 ukSw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785417791; x=1786022591; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eiO9AlycSvB7reIypDwr+RKc2EG5upEokIqWQ0C5TEE=;
 b=em5bw9y14Aw0pDbvXJXjgqbExHFT2WHROnU2ZFERR0upHIeJOmzp6QU9cRkLhpH0Wk
 mNGVIsDoP7nUyEbCBdANJjFjz9DxkSPKw0eHCR4ucbjx+dN/0o1TkIOd0+FvFnCC+tJh
 7frlmvG9km+LksE9PemGDQaNJo8ZpDydBTtVVrXcoPYKQAuf1GLPksTsmEG88QHEkQ+X
 CrhcvlqoqG025CEXfvIZ2xvf5269vNFikfzYLDp8L4qoOxYmA7iRM5KC3qR7h7BMp5rr
 kTsQCW36DNf7/2OCAmkV1H7/1W4rfl9Q6pP+dGvxkNiLdD01T/jRMm4T3wTgW8XQMuze
 rN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785417791; x=1786022591;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eiO9AlycSvB7reIypDwr+RKc2EG5upEokIqWQ0C5TEE=;
 b=BDme77HRWSElv5v2EhxFFqPd6rXtuYhrHHZ0hxOkC08Lr6o6aS7ovNIbfbwtDtvd1W
 3A5ckeR2451U1guLIx398+t2Zk6CgBAmtPEtZxMmwUXCHFlZjenfViosNBA5a6KRmvQ0
 HQWOvxo1MDJYRILE5rty2lEKYEQGnWieBJscHJe+o/cauMM9HmWK+5lKAF6TwBgbUWCp
 3I6BCUGUjsStDALDO1qYKA1JbU5Ozjq9jPOrCYJayepDsng1He0UubDpVMatwMxe7mJo
 aDSeBa9syJ2/vKeK/re6Zt6l0Xo2QTw6My+lS/vIIopf2toCej1os00MxgA6ypvp6BhS
 RMlg==
X-Gm-Message-State: AOJu0Yx4VlRCNFV/MlQWbGFETjvSjyiWWofLQwuOev2nRSoXsxSXeY/r
 W+WfYJ91l4TnZDCQLNiQ4bODjsS4Zy33dJ41yYCEipmRl0PfFwMWJIcbFHa0IqOlqeyRaDF+Rs0
 sJ01esc1JlNCb094Jf+vXDdJ5cxE446g=
X-Gm-Gg: AR+sD10Zj8DoSq67BQrUruWKtDojDG1EyAveD0QFq5BnPcbfNmQhxLN0Ws/c2eTnuuR
 nylR4hrHg2Qj3BPtEGlzMEDqLCFWnKSlBOxXrOphtOcDSfyCyaENHJLNMnEn9rM/NH+SHLU+bxM
 5xkXN3ow3WTURxosko/ABoIdtbjQTNA+09F15CznKYNUk+J+Rb+DKcLoVychko+D1njzSdixn4T
 +KutBkf+v7WlOpk0UNZSQJuRI2c3BHCVR+JBZ9jtDJOtjZ8gWqo5g7bptbdN8ykUS4w1MPe2kui
 ZsMntZtAPsiRC6B5hRfCQKDXYJHeksU8Gv9xuuuJ8WsBfhT0mT2B1n0yZhKY30VAhad9+RXGR2P
 7NrBjvBj7FcC55TwQ8bwoKI13I8+sAXQ=
X-Received: by 2002:a17:90b:4487:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-38fa8094a00mr48536a91.2.1785417790828; Thu, 30 Jul 2026
 06:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260730124723.3500677-1-candice.li@amd.com>
In-Reply-To: <20260730124723.3500677-1-candice.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Jul 2026 09:22:57 -0400
X-Gm-Features: AUfX_mxjqhO7Yo4eSxQXrrLOCeUJ011UT9ZJHVHEMQNJm5CTkxhkOayWRsiOaYM
Message-ID: <CADnq5_PNpG_1_Le=qpSsf-AccFdn_P+r2Sn_YTgBBt2Do_e-ug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix userq VA validation for sub-page buffers
To: Candice Li <candice.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Alexander Deucher <alexander.deucher@amd.com>
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

On Thu, Jul 30, 2026 at 8:58=E2=80=AFAM Candice Li <candice.li@amd.com> wro=
te:
>
> amdgpu_userq_input_va_validate() converts expected_size to page count
> with a plain right shift. For expected_size smaller than one GPU page,
> the computed size becomes 0 and the range check is effectively bypassed.
>
> This allows sub-page userq buffers (e.g. EOP/CSA) to pass validation
> as long as the start VA is mapped, without verifying the full span.
>
> Fix it by rejecting zero expected_size, checking overflow when
> computing end address, and deriving page span from [start_addr,
> end_addr] inclusive.
>
> Signed-off-by: Candice Li <candice.li@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 25 +++++++++++++++--------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 3fe10d6af7575d..652599f0899024 100644
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
> @@ -238,24 +239,30 @@ int amdgpu_userq_input_va_validate(struct amdgpu_de=
vice *adev,
>  {
>         struct amdgpu_bo_va_mapping *va_map;
>         struct amdgpu_vm *vm =3D queue->vm;
> -       u64 user_addr;
> -       u64 size;
> +       u64 start_addr;
> +       u64 end_addr;
> +       u64 start_page;
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
> +       start_addr =3D addr & AMDGPU_GMC_HOLE_MASK;
> +       if (check_add_overflow(start_addr, expected_size - 1, &end_addr))
> +               return -EINVAL;
> +
> +       start_page =3D start_addr >> AMDGPU_GPU_PAGE_SHIFT;
>
> -       va_map =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +       va_map =3D amdgpu_vm_bo_lookup_mapping(vm, start_page);
>         if (!va_map)
>                 return -EINVAL;
>
> -       /* Only validate the userq whether resident in the VM mapping ran=
ge */
> -       if (user_addr >=3D va_map->start  &&
> -           va_map->last - user_addr + 1 >=3D size) {
> +       /* Lookup guarantees start_page is mapped; ensure full span is co=
vered. */
> +       if ((end_addr >> AMDGPU_GPU_PAGE_SHIFT) <=3D va_map->last) {
>                 va_map->bo_va->userq_va_mapped =3D true;
> -               *va_out =3D user_addr;
> +               *va_out =3D start_page;
>                 return 0;
>         }
>
> --
> 2.25.1
>
