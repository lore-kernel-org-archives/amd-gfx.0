Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428B7C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 19:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64AFC10E23D;
	Fri, 26 Jun 2026 19:31:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XeeFVPTH";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A4A10E23D
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 19:31:23 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1397a4855beso82892c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 12:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782502283; cv=none;
 d=google.com; s=arc-20260327;
 b=QR4i2LfK31WbdfKu1F3rHp0bSE6f5kX8PRzjHUj2PPKklxq3vgLhjmPkYWaGSSzoTG
 kO1YSouPEd2YHSfm6ni+iCl7ySU8r7BrU7/obKdus5bDM8RPohXuR43hQTvJa+k1/YFu
 f82bnTE0yh++pY5lb8LzzLHLbKfbC7XbF3ZEQuNrm+HQUTNyyl/hsu5zZCK1w6GUNcnl
 WN0PwI+aV1QZt2alnlyBHfTucE1BbxsokmBODvbzuEHNdoaUYp90+EkofA+Ecvks//Z3
 Os2glFVCL35CKH2P9BuKVN3NhKftClGuLQTb9OO9ljdS98fkl+VxW39mG3fvC29t3/RM
 2oIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HrlxuybmI8Y66r+W/TceSqlvs9Lyp8GdVA7sVMol1AI=;
 fh=T6luZhFAIbrG4Mp7ur79m9u6UAR2uzuFUw/q97Yq65w=;
 b=d4snjMYg8dXGz1MnzS5oabBIvP7ZOVOJqrLhSUMqWqXP9wyF/BC701R2f0PK9acApA
 EhwFgJULc+HB+DuejqDy0kvwPGaQZUu771Otx7IZqHe71/rtw7ncN5BnXrOwOhOHMzUq
 wToipE2Q6nnDc53Iza73GHTx5PzizWMpFl0bI9krO2GkucNU3+Keo88cEsAdxuqmfwYn
 PfouoIx9E+cYoJlopSDPcV5uQz1tLaoYuUB7FOsg2s1ZBh7G3m5fm/++JocDmX9TlcvQ
 85IRETFpNsx2Iy8M8Ofr/5N4Uwt+Jvgi0eW3gUKGwKrjsaQaYEBsw/9jNNIN+n/Q3UQ8
 TvJQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782502283; x=1783107083; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HrlxuybmI8Y66r+W/TceSqlvs9Lyp8GdVA7sVMol1AI=;
 b=XeeFVPTHThnNiAAYJREiTBmbUUic8nSy1pUFzJbp9ipDxe9JwhUl889664C8E47NMQ
 Q29A8ohe8gT8lLl1NO9IqvMh/23fV2Q9Qn2nRzOevmon6mIoB+S+nYR7zrnWy073AbOF
 wMmIdaeF00llGtWPSKCnb1uRGeSt/1XmviHct0GNwqB+PlXWZoS6mYj1yqyIz7uwkCVY
 iF5TFJx67+9um4D8HFQ8T7yIsPRq0BqHuSlUPED0oE1fNVD0/5ibdoluormnqqDkug74
 8JFa3auukZZ6BHmwM+ZsJFCKp05t8QK3j3IcGRbe5OVnNowbUGz4tj6z9VoFPQzwfc0j
 kcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782502283; x=1783107083;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HrlxuybmI8Y66r+W/TceSqlvs9Lyp8GdVA7sVMol1AI=;
 b=PlCM4zdqgg6HeabajJivm5mgUpnU93OkPKk8pBRZiR7vulmESY6fAl1FSkMN5/ziku
 ynMnMsJmdg2wh1zRnnnsXhqywrmBgE3zCJdmRRtfYKTnfsEB15UQiP1JzSrg+u6/jpCG
 gI1J9Xz2iJXBu491DCD9du3hOo4x1SmCsITEdx2P2JvtwdBRDyvGB1iFDKwEFGqVqMGw
 IusuZFd0PdnpLqfohEcVqNU4l4oTTeyx27yfB5w8FC8jBkrc/Ip0758xonDoCNKqapw1
 lrlcPSuvzbPqRbAj3EP5mNxC5Rtb8ld8zbS8SLWxcuoP73DIwxAw8ystkmRua3l8iMrW
 +Akg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9A8qEtLeqBHTtDT7zdLhPf3eAWkiEyd1jq54XmuXEBq1l15mOvv/xjMaXWNRWB51RQMDgj/M5P@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzwDAFyRckL3VlJLs/j9OZSIsGbx3T8yryuRmfaWgqaMyZ8uGg
 WsZOY7X4pF9ayo/EbxkoBVqOhyBux0EJ5kdX4q5is8cNEP+zFPRhcLQn+k7ltvuEylHvUptCTyE
 6uFGI5Qvk+E7ucSbN65Y3UpGGTuxElcA=
X-Gm-Gg: AfdE7cnCM83RI1nA1P9B+d3eipFBS1IFQ5S1pi66T89pNdQ0rRAaDkq7NAyI5cWLoqV
 +NYIleO7rMMHEHoN7HHJDMGfnY+vvZduvfy54A26umce+1WXmNH3qc6ATM99kqlokl/dUsK1IFb
 IA6hn/taBMY73F7TQ59g/nVkZ1XlVboPQUamM8ZuYHg3cY2S4+s2/BpRmKmEslRw70/3IUoZMkL
 zRmGyuyUbpnVNsX5chNbV0QW44GUgpxWLw0ElCJtXxHntOUIvFJ3vNIH1yhjznhcQ+K35IhHJj6
 dv73KxXcF1KnUmVKlXRV8qwEWW2bmxjWKLqHviuoDNDVpoOvFoYjKGLCrfM=
X-Received: by 2002:a05:7022:fe04:b0:12c:888b:aa92 with SMTP id
 a92af1059eb24-139db9e78bcmr2876349c88.1.1782502282587; Fri, 26 Jun 2026
 12:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260626180145.6213-1-christian.koenig@amd.com>
In-Reply-To: <20260626180145.6213-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jun 2026 15:31:11 -0400
X-Gm-Features: AVVi8CdrCwHa3usuHv5pFKhT8Etf0BCQPRAtu-XRrHuWcOLoq2RZxP8a5jpo3J8
Message-ID: <CADnq5_MQfj8svtHLj5bB6R8hBnTX8tC5r1qdRn+wHH-DdfeBaw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx
To: christian.koenig@amd.com
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

On Fri, Jun 26, 2026 at 2:01=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> For a short moment during alloc/free the userptr BO is not part of his VM=
,
> so bo->vm_bo can be NULL.
>
> Keep a reference to the VM root PD as parent of the userptr BO so that
> we can always use that to wait for all submissions of the VM instead of
> only the one involving the userptr BO.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: 5cd5f99b7b9b ("drm/amdgpu: fix waiting for all submissions for use=
rptrs")

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5399

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 28f89ae8ca74..686be2bb8c37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -535,6 +535,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, =
void *data,
>         bo =3D gem_to_amdgpu_bo(gobj);
>         bo->preferred_domains =3D AMDGPU_GEM_DOMAIN_GTT;
>         bo->allowed_domains =3D AMDGPU_GEM_DOMAIN_GTT;
> +       bo->parent =3D amdgpu_bo_ref(fpriv->vm.root.bo);

Do you need an unref to match this?

Alex

>         r =3D amdgpu_ttm_tt_set_userptr(&bo->tbo, args->addr, args->flags=
);
>         if (r)
>                 goto release_object;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_hmm.c
> index b38788228d0b..eaf02f90fddf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -67,7 +67,6 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_interv=
al_notifier *mni,
>  {
>         struct amdgpu_bo *bo =3D container_of(mni, struct amdgpu_bo, noti=
fier);
>         struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> -       struct amdgpu_bo *vm_root =3D bo->vm_bo->vm->root.bo;
>         long r;
>
>         if (!mmu_notifier_range_blockable(range))
> @@ -78,7 +77,7 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_interv=
al_notifier *mni,
>         mmu_interval_set_seq(mni, cur_seq);
>
>         amdgpu_vm_bo_invalidate(bo, false);
> -       r =3D dma_resv_wait_timeout(vm_root->tbo.base.resv,
> +       r =3D dma_resv_wait_timeout(bo->parent->tbo.base.resv,
>                                   DMA_RESV_USAGE_BOOKKEEP, false,
>                                   MAX_SCHEDULE_TIMEOUT);
>         mutex_unlock(&adev->notifier_lock);
> --
> 2.43.0
>
