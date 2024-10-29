Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEB2D5B86D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 14:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF3F10E675;
	Tue, 29 Oct 2024 14:18:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YC0UfI4V";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EBB110E675
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 14:18:42 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-71e4c2e36d5so204686b3a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730211521; x=1730816321; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYEFvuFALsjnWSlNNeisw7ilQv3imeEN+ME4YbTbNY0=;
 b=YC0UfI4VYRFxBlu8By2+sw9SLK5Ux2X6+7R1CFqIxBD6ZPkhO9odr5UY3YY2liSL/i
 5RgdHK9kek/7cG0mB3f6y9dNnc6Vd5gdWzOQo9d2Dg8NBeQIuvkgMR26lWD4RUFR0zdS
 y6a/9MW/s5ZE/vbvWFJWGapQbA9Ua+LCYKna6u+7sMRa+nT8GfCybpx3YHwQ16DFKmzA
 HeKkCuH+nihs2UBPKGfWE3IBH+1/LyO+NWaJUbRJzEDbPbRTnFtlNhviqhh7+Rkql88Q
 eUOVXIA3hS3V/8+Xg/NZ7oTTa+bcpxQfFd8Lz6Z5nIomwZlqjRvpYxMUKvQZi3efSk+N
 2v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730211521; x=1730816321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYEFvuFALsjnWSlNNeisw7ilQv3imeEN+ME4YbTbNY0=;
 b=dE1SMAh5ca5u8M6VGIJxM4EvcsY0WmD27xmHBO55/JrZADK1mVAZ1UqggwqjXlWseN
 Gqu4pM0y+0JYihV2n4IafTiRuESpPpmGwpSzNR7unh4SGNUBlIyDEiGA0c+P51Y8CA8x
 qFGO8vrPltF1KIoRVOxvfLX1Gzmzei50pRs1122Ao7iimRKV65cFjdf2wus09aqRnLAn
 5T72h+IJhD9D40L/L1OeDGodn8KUaf7rWp8ycmpjlb78Wwitif+QZViHpjJLZJKAGHWJ
 jumwxeZxStgY3kMewf6lELt00zc6z/h1v1Gb7mCMv1XIGagp+Hb4m47NR7aFAABO2K8K
 vGWw==
X-Gm-Message-State: AOJu0YzzO1/iAVAhJxeZbIyuP9fAutAJuUh1MipaZdRWNZMAKzqPvjNp
 J+NlWzY9H8Lim7FdQ1/8SkNKl37oQIBYw2ZzxknKcjCNp4h+O2cveu/o9uuCGsk1YHhuBAXRuVu
 OIcf+iV2Q+BHhK7+FFTvV36i8uQUIYg==
X-Google-Smtp-Source: AGHT+IF47exhSArHsExNupgX77jH1cXs63emCN0mhifVwV/OyaM5AccKkm0H8NTo6jtVGapqYn4GajQanRBJzqbYsA8=
X-Received: by 2002:a05:6a00:2d25:b0:71e:658f:c43d with SMTP id
 d2e1a72fcca58-72062ed3c37mr7244664b3a.2.1730211520059; Tue, 29 Oct 2024
 07:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <43965fdb4f4a7c4223885c8e417bdc69@aosc.io>
In-Reply-To: <43965fdb4f4a7c4223885c8e417bdc69@aosc.io>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 10:18:27 -0400
Message-ID: <CADnq5_NNBe38-yiQGCcdxOSDksN18cr3R9JWzYiZZn5_Z1SJfA@mail.gmail.com>
Subject: Re: [PATCH] drm: amdgpu: fix comment about amdgpu.abmlevel defaults
To: jeffbai@aosc.io
Cc: amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

Alex

On Thu, Oct 24, 2024 at 9:07=E2=80=AFAM <jeffbai@aosc.io> wrote:
>
> Since 040fdcde288a2830edc31dd507963d6aadf990d2 ("drm/amdgpu: respect the
> abmlevel module parameter value if it is set"), the default value for
> amdgpu.abmlevel was set to -1, or auto. However, the comment explaining
> the default value was not updated to reflect the change (-1, or auto;
> not
> -1, or disabled).
>
> Clarify that the default value (-1) means auto.
>
> Fixes: 040fdcde288a2830edc31dd507963d6aadf990d2 ("drm/amdgpu: respect
> the abmlevel module parameter value if it is set")
> Reported-by: Ruikai Liu <rickliu2000@outlook.com>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 81d9877c8735..b248d7096abc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -892,7 +892,7 @@ module_param_named(visualconfirm,
> amdgpu_dc_visual_confirm, uint, 0444);
>    * the ABM algorithm, with 1 being the least reduction and 4 being the
> most
>    * reduction.
>    *
> - * Defaults to -1, or disabled. Userspace can only override this level
> after
> + * Defaults to -1, or auto. Userspace can only override this level
> after
>    * boot if it's set to auto.
>    */
>   int amdgpu_dm_abm_level =3D -1;
> --
> 2.47.0
>
