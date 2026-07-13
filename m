Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB91C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 14:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5E310E5E2;
	Mon, 13 Jul 2026 14:09:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GmjHM1xq";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B31B10E5E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 14:09:17 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-381d656c36eso227658a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 07:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951757; cv=none;
 d=google.com; s=arc-20260327;
 b=IAnuSlJg+6t5nbJIfUcyuEe8sbuyRPzqhmA5Shoin9dYGEn2picPlhk1i0IA7j/bYc
 rC/P2iinZB9byDC43r2d8FcXjDYaofh67+PFfYGL10iDK7BFk9d9/aq2sF8ygGGkwLBf
 5NuD85UOTEm5RiRWU5s3AbWt270PF/1BUWpitOgwTKtIlU9C/akLFSoJ0mj7pQox3NNA
 Ma8Ws9rQ1XYNTcsLeV7CnDHfwJ23JcBj+BrBvOcUlzDnH0CXoWhMe9vZZT9PaPg+JveB
 jvpHLFF6VzLMjKQKv3jPBD/kRcsOaYtlSVZHlfieIRX8kw/PNDxLb9tow9urriX67WXG
 iHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Iqz3PzcMAT9OeuKMMBY/xNxb5BdndsauKwJWxurxn0s=;
 fh=HeCrNI7cw8ZNH8ybYljUoSzRC5RPOPc0WCtG/c3Kv1M=;
 b=GADHg+Ae2+0SD4Q9TipUN9MUDNqnSVvkhkR9UCmssAcXceMN66mQpBYBisOE52SY4Z
 nnTya7tkDHSd+32tBuxTwZZs3DS2NldiNbuA5DBjzkZz2s7jFcCR2C3U0OXOzRHAU0LH
 j95HdMCaBJS19urePuUeISLQMQoBwYpdcBmnckkfz6QnLdR8oH2J+Klo+eEcpywgVvBk
 wHpAcFLb6EDOv+lHMsgnS9vroUnMK45wuT06S3/3hCNc0k7484OYjYzTEC9uaYC6oyPj
 qOEP3r9jRQewT2Zza8FYrdvcFGEpqJhSK4cc9u2D+rZPkLo4OIan6xzGOl3BiuGYmK9y
 7UKw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783951757; x=1784556557; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Iqz3PzcMAT9OeuKMMBY/xNxb5BdndsauKwJWxurxn0s=;
 b=GmjHM1xq4aeix0RR1iltmJqjOQdKoG/3eA/9tO2Z+vZcrT/jpT/HGNqRN/3Q3mcvlZ
 AAu3CWhGaqNRzKGpuzmbmQCwN92vH3eiF5kwr1KgJae5QRkSmMq16Qlax30Gs6hbDYHO
 fAEwn2hvgC1hWTYz+zErUODWFyhU2lFpmho6elCDq1UjuuFlPtcIDUfI94RS8pEvntS7
 j025PMet5wiqf8VAtQjKsI8NEkGpjMtFzi5WHuJI9o1CCmdWXBFQg2dmq91mhRr4t6uL
 XcTA+askgziKjGKHNSTThKnQGU7tmzh/Lwa4qAq/hpYDOgkHtEP7XL1xAAb+H8PdCdDb
 wAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783951757; x=1784556557;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Iqz3PzcMAT9OeuKMMBY/xNxb5BdndsauKwJWxurxn0s=;
 b=HAxE3FbLlkGpu6yHbntztGIBldbV1lpJjyVBr4ZHu+YaeEEswKEajaSDpHaOd9BIVA
 p5oo5GPTrVi2KDOcwAi6kghV6tt7Fs+PkE/UAue+lP74gUwIDgs05/MAK/csZI0JacBa
 YJxSJ5Bv9mYchNLazDyNY93d3RFdGKq5gUMDVY4ldtN7iSbr+OTs20wPB5iDFaEVD5yO
 8Kl0NYkFDEwTMuR9ItMWBG9kJiaHbvoxzzU2GjLdhpw/YoHKIz34euvhSu0bzINFzS8I
 fYYMA8eufWi3Q+/0A8vEXAG5rt69L5Yn54hJmt97IMSaXUCNa0qk+5dD+H+IuoX1HH+r
 Gysw==
X-Gm-Message-State: AOJu0YwhL/8pZt1OhrzQh0plzJDMePkh+fjwvQ0grytVAQnnvZfEKCCS
 JxGEAP6gtCKNM1dCfDhD4UvT459SnjqqbIQLVR6rIgo5fIHa/S75E7aHWpaMFnd4JOlJxMnXXcP
 4RL+qUraupz71WTYhQbfajcENihxy4o8=
X-Gm-Gg: AfdE7ckzCKCsYeLUfRVSVWcyJmb/gvr/QEEaHTOMMo9mtuB8mNaP0oX0hoEk+taHkc7
 X+2F+XLXQXtjk1uQkdxYsgvaTPweVdjBLn3XaJ2IKcLGIL1DQHcIQL0AF99fQY4Q4FA4eXlssT6
 shmX6WJpP6D4j1/G9Vj6LtwFqJi5PfoN0EoFLyM1TSCwvXm2CVkCNR8AYu2NVFT+L51c71AeBie
 1v10LV4YR5jtuLQaMH6uDH1Vx+tNY0yf3ZeMkbHJjC/B5WpXP3f015e3bIQzsAFXXE6prDAy113
 Ox/e4l6E5/5qr/snN+m+BI1luZAp1r2FIwOguJN6B+SQ0WA1IueUytzsZ1E=
X-Received: by 2002:a17:90b:3e48:b0:380:7688:fc06 with SMTP id
 98e67ed59e1d1-38dc7849860mr6743253a91.8.1783951756794; Mon, 13 Jul 2026
 07:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260711115000.40655-1-timur.kristof@gmail.com>
In-Reply-To: <20260711115000.40655-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 10:09:05 -0400
X-Gm-Features: AVVi8Cfi4TBXTT4yBIHXS6K2s_Zak6FY-Obdqn0ngE9PBD2licArnx9k4pGJ3Mo
Message-ID: <CADnq5_P5F1_v3ZqUBprSM0t93Lbcn4RfzPtw_PZuTvVmkGuWPQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/ttm: Consider concurrent VM flushes for
 buffer entities
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>, 
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
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

Applied the series.  Thanks!

On Sat, Jul 11, 2026 at 7:59=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Allow using multiple SDMA schedulers only on GPUs where
> we are allowed to do concurrent VM flushes.
> This consideration is necessary because all GART windows
> are mapped in VMID 0 (the kernel VMID) so each buffer
> entity would flush VMID 0 concurrently.
>
> Practically this means that we can't use multiple SDMA
> engines for TTM on GFX6-8 and Navi 1x.
>
> Fixes: 01c836788b37 ("drm/amdgpu: pass all the sdma scheds to amdgpu_mman=
")
> Fixes: e4029f7a9474 ("drm/amdgpu: only use working sdma schedulers for tt=
m")
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 74ada995bd8e..9eb55df6e692 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2685,12 +2685,22 @@ void amdgpu_sdma_set_buffer_funcs_scheds(struct a=
mdgpu_device *adev,
>                 return;
>         }
>
> -       /* Navi1x's workaround requires us to limit to a single SDMA sche=
d
> -        * for ttm.
> -        */
>         hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
> -       adev->mman.num_buffer_funcs_scheds =3D hub->sdma_invalidation_wor=
karound ?
> -               1 : n;
> +
> +       /*
> +        * Allow using multiple SDMA schedulers only on GPUs where
> +        * we are allowed to do concurrent VM flushes.
> +        * This consideration is necessary because all GART windows
> +        * are mapped in VMID 0 (the kernel VMID) so each buffer
> +        * entity would flush VMID 0 concurrently.
> +        *
> +        * Also consider the SDMA invalidation workaround on
> +        * Navi 1x GPUs, which also prevents us from using
> +        * multiple SDMA engines on VMID 0 at the same time.
> +        */
> +       adev->mman.num_buffer_funcs_scheds =3D
> +               (adev->vm_manager.concurrent_flush &&
> +                !hub->sdma_invalidation_workaround) ? n : 1;
>  }
>
>  #if defined(CONFIG_DEBUG_FS)
> --
> 2.55.0
>
