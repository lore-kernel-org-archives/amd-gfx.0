Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49D1C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 16:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F1F10E452;
	Thu, 23 Jun 2022 16:51:19 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02DE210E3B6;
 Thu, 23 Jun 2022 16:51:17 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id cf14so19640781edb.8;
 Thu, 23 Jun 2022 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZOox6HqgRBUv7icqURUJML9abJah70/U25bI8X8Eyc0=;
 b=kfqCOp4uGyXjRICRfEG2lcRUgea96b9kksgdi1ldi2t1fN0InFIsPiqt4nqCLdfD/p
 5BV+fuCzoVB2zfwoFAGFjymKkjfwyhmh+MmXr42ycq8dvVwWI2VXrr0EOxscM6UOmfUt
 uI/j4WGJ5wfuNByUoQrhC++RY6pXGjOgLYLNpkXoMwfbWnWuirJq0TdYdVd8FCV35/VG
 TwNAf8QZLaY3zIsBXsuJhAhs63Z/R3uwUYTtxAxLcYTV50pGABiUgGnf0cjW8ynvhaWG
 tWY+f99eYGIoXq+TBANdoWe0YoEKdd9IaE870Jpwbx4CmYDD0jzZloR8qNw2Ki+A0ef5
 HPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZOox6HqgRBUv7icqURUJML9abJah70/U25bI8X8Eyc0=;
 b=7rXa+2IplGyLoHX1TkPhhsCjGDEkojnksWg6E6OTgOwBMK9ZSMS8NIzHQqxKwEucVh
 vqgJLZCcNv2TAo/emsjrceWcUi6dTWkyPC9Rng8fUNbGC0qf9SEroARdVuYQ4IcFrJta
 mj1fTJ+PBdqf/TnYqMEVeUlOXJiTd5iHHivp2+MameoDYIZycxmEKVzWMEjbMgF0e1O+
 AwXX6NWQi/cVJTc9J2i/N2tm5r5mp38iy+75SlPeKKFQSpS8fh4Ge2fphWt+0KtDkvD+
 +Za6DfCGb/SSVZedlusbD/V0nJn/Hq+JnT0LwiwY9QA0dua8FeGcCbeCaPpH809pXj12
 yvbg==
X-Gm-Message-State: AJIora/VIwQIvHpycMFnEEsyh8IqkKIA5wzxbi+SsnogpRBb0Yq95vuJ
 1FNl/JKbUye/Q9hxS8wlN6D/EyiDA4CuA5wl0iu+HOsE
X-Google-Smtp-Source: AGRyM1seSiLtqCIe8T9UCrc/sPscS+2NaSYNj41ONsIdzNTTytILIW4ECo/OCFVlLa6XL8bIlCV+qiVNMuLc7ZT3Ttw=
X-Received: by 2002:a05:6402:50ce:b0:435:9249:dfe9 with SMTP id
 h14-20020a05640250ce00b004359249dfe9mr12079163edb.310.1656003076595; Thu, 23
 Jun 2022 09:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220623101448.30188-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220623101448.30188-1-jiangjian@cdjrlc.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Jun 2022 12:51:04 -0400
Message-ID: <CADnq5_P1VQo71hENT-RZUXY1T_+46bwPzRQ+OED-mTwRG52gnA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop unexpected word 'for' in comments
To: Jiang Jian <jiangjian@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>, Dave Airlie <airlied@linux.ie>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, xinhui pan <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Jun 23, 2022 at 6:15 AM Jiang Jian <jiangjian@cdjrlc.com> wrote:
>
> there is an unexpected word 'for' in the comments that need to be dropped
>
> file - drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> line - 245
>
>  * position and also advance the position for for Vega10
>
> changed to:
>
>  * position and also advance the position for Vega10
>
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index 3df146579ad9..1d5af50331e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -242,7 +242,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   * @entry: IV entry
>   *
>   * Decodes the interrupt vector at the current rptr
> - * position and also advance the position for for Vega10
> + * position and also advance the position for Vega10
>   * and later GPUs.
>   */
>  void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
> --
> 2.17.1
>
