Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15569C88E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 19:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6737F10F6BA;
	Fri, 11 Sep 2026 19:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hp36Asa+";
	dkim-atps=neutral
Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com
 [74.125.227.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 878AB10F6BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 19:00:21 +0000 (UTC)
Received: by mail-vs2-f43.google.com with SMTP id
 ada2fe7eead31-781d5e2a1c6so13172137.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 12:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789153220; cv=none;
 d=google.com; s=arc-20260327;
 b=FAsS3JvpBONAr0hrSp9AfrCNvvhIWXXaU+iP55V3e/5l0T0yznYFeaQsYFmANzl4Rg
 zu2ieLjap+oG3SGvAFZrpNv339vmunbYbFHlFoVOqDsML87SbQ7VDey7/tajnF0FXJlT
 j9jJD7ryxVywXQbfjlAWADb9x96MC95C0yfCPgGNy/Yph+r9x9/MnTp4AHhq+/An2Mj4
 HMQhcocj6C+4IG2qIPN6QwdYmqTKOiyZC+RoIOMCh5+XllCzQ0eD1YUPTtcPqffr9xJD
 P1Q7aozh5V7ciwGlH56Nqcgo8emPlhtZWHgpaTew39oY+hIipiDAuO90Dl1njh9R5kFi
 T5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0kWWIhr1Ci7OdlQEamxLVjjrAhAjo3tmTNDFkk507VA=;
 fh=MV8xSw5YdrK5iIewyHRxo4ax7j3M5t3LyeF9RNB5UuI=;
 b=G3K+/FVJfQHeoG3+1Q9aXwskVoOhvzrzOUMXmPLd3vg2460dEXnNWLfNr7Zjc9o5CS
 RRmVdkpU8FvN7Fk5yOjNJvb2bo1eHfEJbGA9zyLlyiBEp5ccplPcz/LGaJrSzug3VXIZ
 ZXZPZcbhg/sSgEy8GRx9oZ8XCzfQaaJcYLzqeJPrwyasM82kay+tTIHvtfQGX/gCaw8P
 /Dxl9nS7Okfwk/ySaWHS9tmpZc2eJ5gYBeHIbGR8UBlPMiY2QkFqhTvWrJYYaU+PT9a5
 Tc+uwUpOab+0E9WJYk9v4nc+jCywzXmr7ExzLvLCzkFbIfju86p9tCLAt6LQ3e/B+Yq+
 bW9g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789153220; x=1789758020; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0kWWIhr1Ci7OdlQEamxLVjjrAhAjo3tmTNDFkk507VA=;
 b=Hp36Asa+JlacgIJrVILJfz0GJhYkB9BmYjt4h+7xc+NvQr7h0jYlo3cU0CkiQHuzu5
 vMO/n+6Y7Qij+wVeXVppYb308MXQ3RpE2kcB8RCF2UElwhUQ6Bz0X6fqzumae4WL4Brl
 obTGxX3JxpJwURP2CsL5y27BoTL+EHnXK4i+jmxHqUlgq17PQtMEADVHEVpqHlLnOtiW
 MMVthKB6e2+XXnLz1M6WLMmX0SmhINKnqwl99fOIy4KIpj7Gsx+UAOG8Zrb4VVP+zI4k
 S+Svbuw+UPywC97UjwgmKi+xL6LXJrGU71Z914Fvjf1G8xg9bDTMirM2N89F3ocw9RRz
 5Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789153220; x=1789758020;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0kWWIhr1Ci7OdlQEamxLVjjrAhAjo3tmTNDFkk507VA=;
 b=BekiNGA9soc8a3IfMqEk/g6G7M70g2HUzKRVWLv7d6h2SOeq6slTvvszPZ6UnFx1iI
 yZ5U95yAdHGpGZmjoViX6ZaYdACPgZi18HainJOdJeSae9Lz3+x0s3uTmwVkkcILCvwW
 rgkEKdYDuS3XgVW3xa2BniBH7OseRPu0Ut5VXWolON7qsdH7pihS7LnwdYCR9X3GT4X9
 tDvXDgIqRDua8KxdDDiEmNFi0OrAwMdcoIExY0SEF5+99IlcidMB0vw0sErKZideOh9H
 0tkchEWIh5y0Gr/nbcS1fDkzhzpRD/MGN5IF8o8YjNJ+9vrhv5tagirlvKvm2S+EerCD
 Zr7Q==
X-Gm-Message-State: AFuF++lDx4TdoIZEXxXREHICcEspAmalxRdLm9/P5xw7NTcOKda9d8EM
 k5/Cu/LDBB2O6avYQ/izxprI0Y3+PNaKLXTHRUqtit0Xf97+cs4oVHJ/vcSj4M4K9KCAdjfssVI
 i1UBNVMO7K8vhowo/NYBsuNWuH7hoaHo=
X-Gm-Gg: AYBFou228gerKHMWotwHf90HNAOhVuQa1l9scawJhYrOK2CWvMYJJP783hBjmqBcZEk
 DEsKnUzOaIfMLNYld2FVv8sbk+b65/Y8PjBoqJJqSzSLoSiPhv6hiAOitoS+NoobmvfbHdxyn2i
 vZFlsxl0KpxY6lr+gCbUXh6M7PAmhT8Us+8lDUtLKdj4YXKh2PBjB/buMH28lVuQPxjqrTAYe0R
 OdthQ6QXUQKQHBE2fnT6LdxYjOjdREAb6vPqmSb+xo5LAumZzhmItkFC+znqBGAAa8O3Iwyu7Y6
 PhmgCNW+e/fXe2Xc4Wu1gDaglm/GLGIIpaeo0MHD47TpsdVxzFT9c6VWQ9ra/gzAUHYVKk6FZ75
 Q3zx97aMA01xMEUppafCrJPIeLF40CYsHjYzlUG/E3QyZLEnJmoFG
X-Received: by 2002:a05:6102:149e:b0:786:8d84:5aca with SMTP id
 ada2fe7eead31-792a7a1a2d3mr2220506137.2.1789153220095; Fri, 11 Sep 2026
 12:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260907203316.159103-1-timur.kristof@gmail.com>
In-Reply-To: <20260907203316.159103-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Sep 2026 15:00:07 -0400
X-Gm-Features: AcwNN1Wpbh63Mo7XWGfYOZbmVSUX4YwCb_X9RN7QTjRcXY6osls0DQZsfWLEYLo
Message-ID: <CADnq5_P_cVmHqd5sB6vwGqYA6jSY_fY6EWQp+WofptCgC8nRLw@mail.gmail.com>
Subject: Re: [PATCH 00/12] RFC: drm/amdgpu/sdma: Refactor SDMA v4 and older
 functions to be per-instance
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com, 
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
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

On Mon, Sep 7, 2026 at 4:40=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> This series applies on top of my previous series:
> "Improve existing SDMA queue resets" (currently under review)
>
> Prepare the code for implementing recovery for
> SDMA v4 and all older SDMA (and SI DMA) versions.
> Reorganize the SDMA 4.0 code so that the functions that are
> responsible for managing the SDMA engines take an instance ID
> as an argument.
>
> This makes it possible to manage the SDMA instances
> independently of each other, which will enable us to
> also use these functions to implement resetting and
> recovering them independently. (The actual recovery
> implementation will be in a follow-up patch series
> which I will submit after this one is accepted.)

This series looks fine to me, although I think I would prefer to apply
it along with the relevant soft reset changes to avoid churning the
code until each family is ready.  E.g., apply the cik_sdma refactor
along with the CIK soft reset support, etc.  Unless you have something
else in mind.  Series in general is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Timur Krist=C3=B3f (12):
>   drm/amdgpu/sdma: Refactor SI DMA functions to be per instance
>   drm/amdgpu/sdma: Refactor SI DMA clock gating functions to be
>     per-instance
>   drm/amdgpu/sdma: Refactor CIK SDMA functions to be per instance
>   drm/amdgpu/sdma: Refactor CIK SDMA clock gating functions to be
>     per-instance
>   drm/amdgpu/sdma: Refactor SDMA v2.4 functions to be per instance
>   drm/amdgpu/sdma: Refactor SDMA v2.4 golden registers to be
>     per-instance
>   drm/amdgpu/sdma: Refactor SDMA v3.0 functions to be per instance
>   drm/amdgpu/sdma: Refactor SDMA v3.0 clock gating functions to be
>     per-instance
>   drm/amdgpu/sdma: Refactor SDMA v3.0 golden registers to be
>     per-instance
>   drm/amdgpu/sdma: Refactor SDMA v4.0 functions to be per instance
>   drm/amdgpu/sdma: Refactor SDMA v4.0 clock gating functions to be
>     per-instance
>   drm/amdgpu/sdma: Refactor SDMA v4.0 golden registers to be
>     per-instance
>
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 322 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 232 +++++-----
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 561 ++++++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 577 +++++++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/si_dma.c    | 160 ++++---
>  5 files changed, 1043 insertions(+), 809 deletions(-)
>
> --
> 2.55.0
>
