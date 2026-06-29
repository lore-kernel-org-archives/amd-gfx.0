Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC322C43327
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 13:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D7F88FAE;
	Mon, 29 Jun 2026 13:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S0+X+ldK";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3992010E8B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 13:34:14 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-30c5fcfc947so243882eec.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 06:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782740053; cv=none;
 d=google.com; s=arc-20260327;
 b=qmbdry/tCkogZjLZzezQLh3Cgz9mi3ni5OrNBrkVON9B2beXhUR27Kmpl1aRWUtZgV
 Fj6eb2kMddP5ozCLkzwPsEeJ+k+QOhCxC3YAYpu7E5QCMlNxGsDWX4IrZkJhNje/ydeS
 XKlduIJFSB8/nXXyBNTTw17LVUntmmobUz3Ni3I4uDrxlEUGJ6c/KPPUD0vsn+FF+LlL
 YYQN/BDjJf4C95tk07fvMQHYoFqaLtmeTYUjZE0MX/Lo/JCPJQhjGY9kW8ytGNx26Me0
 patWiIT5rFnQYby9wPYzusUXjN8ilMMEXi8hpoXiileSxwj4FkndBGhJ7nZhcXF9jVql
 ZhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=44UNaQnKFeG81xaHvo2bhlsa17OB2yqW1zzJDfcCq7g=;
 fh=Mnri66E0GbSr/Eaqxk9yAynUI9+zUbrN+6RYs7L2l0c=;
 b=ZqU1zxb3/x8tQ5DYxapi8/E7xLcZVw9N2SesgfsN7BonzQXIZR89B0C5Qu8dEwcZUu
 JSzLqxdiXgfxNNX4UZKad6jS0oyxAJvZCjph1zxmXQWoweYTvzaA+EjJbTiCJUskZd3E
 GEpQh31KA2hGobfLGmIdHYAvxjjdJ/PK9EFkPSudF3LsQ6kJVVJGaknE44omm0bDgjnF
 tQkerUyKqPfbzgRpCmIeNo0AcQgBoILj+i3YrZsuu1xVPvvwtkKxZrzF9LO0rWvgqyCG
 NYvqlT80SnjcCAvA+9+QGWzvTNxfr2ohZL8jA41vjNq0IN1f1UPHF2H/dBHw284cxqvR
 Ft4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782740053; x=1783344853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=44UNaQnKFeG81xaHvo2bhlsa17OB2yqW1zzJDfcCq7g=;
 b=S0+X+ldKhMApiqgaUccg2wXD1X3Yf0AvB1GsckS58lnriV5kguQJFYhcvox9sEuUQE
 68v+3rFyODVIHGIkwXZ70s3NXp49ZIKuQOuCzqwLtTAr9Rjk5sCH3hu+p7jOO3EVPtCD
 GuCnClIucFF2rRJeO4zOnHZW+fhd27fv//OQrh3OINjS2Gt62p0RykxECFMYxWkaNQd1
 7KrPDMy9OdNiA3tu0VFvh3UiOpSyKHc6FUnS1biKCCabATebuSFWmZK0o7/nnsG3v44Q
 HxJc0vnXoC0AkkT9YJKcT1bWioCRpCFkoblU8xzleBFJ0E6bh/0YkL/4dlgQ8EhMyQSW
 MvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740053; x=1783344853;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=44UNaQnKFeG81xaHvo2bhlsa17OB2yqW1zzJDfcCq7g=;
 b=ixPeWq9zeYfu/nuhdSemIngkQeeBWGQh/VfNNNNa5I7SE6ryJ64e/fMf3TYYXS+lOk
 4Y6Ozh6yHQwzfBTjuneFm6RXYQJe02rUXnBPO38mkG/sj6LZ34zXCTKRYP+YFxz+h/A+
 d2cjQLJxWsBEkKrNY5yIKT1uMv5jse+ZZQrUCN3nYYq4ZwotJIcTb20Db73SpbPegohx
 UtCXcwV5OgHOIFFudQM0e+R14LVVLiXWe9Pbi+J8JnnJ7qPnN2CyVJbz2/5lknqlCR6A
 JZEkBva2htXMbYlPVLALB5ptviKmbYRiHzeq9bu1FIl/MKnL5Yt8ktgR4PHsIpdpFRsW
 UsSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dHrhpQ4wBKhDnBe4PLkHgMHQN9ed15NuA3tbjYgAl8yJLtviOgsbFlVi7w1+ttG5ZRccCJoyR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsWtBhH2OCS6Gw1WgMWPbl3eBkSZpvMlCXKN1TBnAUtDByoKoI
 981U3MmLNElxYR2K1hmof/0oaOkYgmkN38eYhXZtqbP1PDjDXHNHWJlAu73ueTMIXSycyUTqtIq
 QLp3N+nDdESJSg4u4Xbmp/iNvuGSK8mQ=
X-Gm-Gg: AfdE7cnNVeBqojn4YBMjGAoBSE1gduut2JmxMxQZVPjllnJVoswFv1X1gepvyTjsPqy
 cvhismPKwqo6Oj7fB6Jl8qJkKKpxm4m19A7rTqlsFOJQgCO2n8t0RtsGyCjY2ZqUWL9qjHRu+hp
 lWsAwpRgNzmArQMhFM54SdRU0hnk4gsjUzxoNIH0en3jQI1ltZfGf3N/3NHdLKlqH6V7eAlg9PY
 9rHd9INXV1mPxdCScLq/pls76K+edUh95emBIpe1YaFeGbOiKjGIOe64tPlomyMuSc2dB58BriZ
 YfrsjhXw9p0Sk3QG8ct4WEgup4MGtnHxPuNIXd+qogWb5IAR83wsr48/DH4=
X-Received: by 2002:a05:7023:b0f:b0:134:cf44:5fa9 with SMTP id
 a92af1059eb24-139db9529c6mr6328632c88.0.1782740053301; Mon, 29 Jun 2026
 06:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260626180145.6213-1-christian.koenig@amd.com>
 <CADnq5_MQfj8svtHLj5bB6R8hBnTX8tC5r1qdRn+wHH-DdfeBaw@mail.gmail.com>
 <c3332376-cd3b-4a36-b89b-5b4d469e1545@amd.com>
In-Reply-To: <c3332376-cd3b-4a36-b89b-5b4d469e1545@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Jun 2026 09:34:00 -0400
X-Gm-Features: AVVi8CeRAE1B6qWzWLK_LQGeJPufHCsKjviLBIybHgLL5seVVtWnC2-vKH4W4kQ
Message-ID: <CADnq5_MUUYNN1mF0CVaFLu50gC3nBRrW8h3XZB3h5DhViWjiUg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Sun, Jun 28, 2026 at 11:12=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 6/26/26 21:31, Alex Deucher wrote:
> > On Fri, Jun 26, 2026 at 2:01=E2=80=AFPM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >>
> >> For a short moment during alloc/free the userptr BO is not part of his=
 VM,
> >> so bo->vm_bo can be NULL.
> >>
> >> Keep a reference to the VM root PD as parent of the userptr BO so that
> >> we can always use that to wait for all submissions of the VM instead o=
f
> >> only the one involving the userptr BO.
> >>
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Fixes: 5cd5f99b7b9b ("drm/amdgpu: fix waiting for all submissions for =
userptrs")
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5399
> >
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 1 +
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 3 +--
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gem.c
> >> index 28f89ae8ca74..686be2bb8c37 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >> @@ -535,6 +535,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *de=
v, void *data,
> >>         bo =3D gem_to_amdgpu_bo(gobj);
> >>         bo->preferred_domains =3D AMDGPU_GEM_DOMAIN_GTT;
> >>         bo->allowed_domains =3D AMDGPU_GEM_DOMAIN_GTT;
> >> +       bo->parent =3D amdgpu_bo_ref(fpriv->vm.root.bo);
> >
> > Do you need an unref to match this?
>
> That's in amdgpu_bo_destroy(), we use bo->parent for multiple other thing=
s already.

Thanks, might be useful to add a comment to that effect.  With the
Closes tag, patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Christian.
>
> >
> > Alex
> >
> >>         r =3D amdgpu_ttm_tt_set_userptr(&bo->tbo, args->addr, args->fl=
ags);
> >>         if (r)
> >>                 goto release_object;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_hmm.c
> >> index b38788228d0b..eaf02f90fddf 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> >> @@ -67,7 +67,6 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_int=
erval_notifier *mni,
> >>  {
> >>         struct amdgpu_bo *bo =3D container_of(mni, struct amdgpu_bo, n=
otifier);
> >>         struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> >> -       struct amdgpu_bo *vm_root =3D bo->vm_bo->vm->root.bo;
> >>         long r;
> >>
> >>         if (!mmu_notifier_range_blockable(range))
> >> @@ -78,7 +77,7 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_int=
erval_notifier *mni,
> >>         mmu_interval_set_seq(mni, cur_seq);
> >>
> >>         amdgpu_vm_bo_invalidate(bo, false);
> >> -       r =3D dma_resv_wait_timeout(vm_root->tbo.base.resv,
> >> +       r =3D dma_resv_wait_timeout(bo->parent->tbo.base.resv,
> >>                                   DMA_RESV_USAGE_BOOKKEEP, false,
> >>                                   MAX_SCHEDULE_TIMEOUT);
> >>         mutex_unlock(&adev->notifier_lock);
> >> --
> >> 2.43.0
> >>
>
