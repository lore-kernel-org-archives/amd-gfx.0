Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3272D30016
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 15:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB5110E943;
	Fri, 18 Oct 2024 15:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fMCk0vxN";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C0E10E943
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 15:09:08 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2e3c0d1ccc6so246501a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729264148; x=1729868948; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gzL0Q2+uEdHkWoeJIITm9cFg30aic+ViNZZR6IsndM=;
 b=fMCk0vxNNPGPLjnhPTtuIAFQ/2L5bl+NyOJx6zzgwh9ucVaLIkEQvUmivrTlajj90F
 9tNuRoIUG8oggOY0W4Mh2ucGUOxmIeYjpzRIFO4pfpyEkw0Faum+hyRJmdfzyIzV1AP6
 uUWLMJ1jmQDoMGtQ3hdQW96VWgmygxmXZlOHUCANvOmgF7ZQHiRNt9eNQ3KdeNjd4zEC
 Uw7IrmURTPr9dvHxvhGezv1/N7cyBJYnXEQwSjlQwjqFTpnYGWNZwhM1/4Gm/L/lm01g
 C0yDAjQCQlYGMNMRGaM8FibAAeDb4pSyQHcGeKjh++SY44s4q70vVzGBBGqoItOtvSCg
 C6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729264148; x=1729868948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6gzL0Q2+uEdHkWoeJIITm9cFg30aic+ViNZZR6IsndM=;
 b=uwG6ObQlolh4121c6Wq94UAC7JX41+3BRJ0+uhQSf2gyGortEr9Ghzh+8euGSUFGsv
 R0KmAXeqEQMRCWRA4u6zZ0fwdHazbnZPP1gMpdXIjhJWxcqkpXWV3wX/omJzSzhpg7lw
 AiLEgAMYvxuaQRxRUjOkaCOTqN6gboqfLG2FXHVKvOIO2Qap59URb8ygNtFwZPUi4xca
 m+RvHFN847pTGWwBcRSr/JkheX127UfsaZ5IT2vKr0fg8MZAr+cSIedD7zgkk9XebWWh
 rdU2WhhQ5aiicWxJp+rBJIPlgYFeIzj8IQ+ztIZDbf1x2jfpgmp9DK26WyBEk7HUlrvL
 +1gw==
X-Gm-Message-State: AOJu0Yx6957nnwYn0tzs35/jvRaH84rgyqA0cskqO9fHsTcjiFARCBqB
 M6wgGrmEycnaxDTFjkfSaLXwZprFb13+JIuQtjzdQ5y3N3BGXduATkCU4ePCkmn/tiDy6bNCgNu
 9gHcwN0JKR7aXGUPQkWKboPcMByk=
X-Google-Smtp-Source: AGHT+IHZ1FgeKN7/CGeY/XMvHp2HwZ4BIdY8cAq8KfAKv9/8SyEHXLp2/v5Jao3MI3cF/pmEw/qiF8Pttj1NL6FzeUM=
X-Received: by 2002:a17:90b:1c0d:b0:2e2:c3c7:bce8 with SMTP id
 98e67ed59e1d1-2e56172b2a0mr1522595a91.7.1729264147819; Fri, 18 Oct 2024
 08:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241018094602.30492-1-lang.yu@amd.com>
In-Reply-To: <20241018094602.30492-1-lang.yu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Oct 2024 11:08:55 -0400
Message-ID: <CADnq5_OAc0J-vfFiD1YLD3PfDJCfoz+dQTuGQX6MFzfH4d-vRw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: refine error handling in
 amdgpu_ttm_tt_pin_userptr
To: Lang Yu <lang.yu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian Koenig <christian.koenig@amd.com>
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

On Fri, Oct 18, 2024 at 5:46=E2=80=AFAM Lang Yu <lang.yu@amd.com> wrote:
>
> Free sg table when dma_map_sgtable() failed to avoid memory leak.
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 74adb983ab03..0637414fc70e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -812,7 +812,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_devic=
e *bdev,
>         /* Map SG to device */
>         r =3D dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
>         if (r)
> -               goto release_sg;
> +               goto release_sg_table;
>
>         /* convert SG to linear array of pages and dma addresses */
>         drm_prime_sg_to_dma_addr_array(ttm->sg, gtt->ttm.dma_address,
> @@ -820,6 +820,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_devic=
e *bdev,
>
>         return 0;
>
> +release_sg_table:
> +       sg_free_table(ttm->sg);
>  release_sg:
>         kfree(ttm->sg);
>         ttm->sg =3D NULL;
> --
> 2.25.1
>
