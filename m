Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19187E85367
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 13:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B5410E0DF;
	Fri,  3 Apr 2026 13:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G+x+xH8u";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ECC410E0DF
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 13:06:56 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12a70b4de9bso99119c88.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 06:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775221615; cv=none;
 d=google.com; s=arc-20240605;
 b=GSvLZQnedpi6tc3zt3nli6My+/AdabogYd8vvl9je5I1s3V9hfUZHkunlbtpCLihQ9
 F7pG9wzqreAz5iFN3o2s7InzWkv0JEDI8DMPt8hpEiiMrXRTlyaPrtbSwA8mLT5TJL2o
 hPjWplpAEG6qcp6xbF7etLqo2DZps8ViTv4uq+TgPFuQd4PVGIBt2yRfEDHFSVnt3I1W
 r/+jxH41eWJsYEGOB5WDpk4IzOBtKig1EwzyzNN8Zdk0c2eaA9mJfBAmfR+X/gRFM3QT
 n42H6YSxYOsgZ+UoEuEj1CfRN4eF/k3jpnjOLAGHIHRNoXWGCl4Z3zHnooWxdw9JbO+9
 1qLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f3oqFhX43HW9sWcUMw7pLeeM1qy1V4CeoOACTAi/IGg=;
 fh=vwH+z4rW0AhcHXbAs3qH4QlXhPdlWOpRz+aKiYkebl8=;
 b=JXZ2w0sEehrdh2ryB4JTLWmshthvsvigipxjKbgZgvG/7KOphyLxl7imbsiuZrL7ef
 EG2hh+S1wRg8BHx/9YdjQfPmPbb0PyWX2bnbg2Knoq4xQJG7p99TS/hQmvSUaGtejSfk
 mvol+9CUMOCqOxgF0gLHkltbR87uB2t8Ya0UtV5VlxKx4xtrO2/lHz980HJBjkzDY32F
 rlTvMWvWsDmT+4lUCe3djeE961pQcCgTFSoYmMiN/b4ah44qt1aa/uqEjtPD/FGfsHDC
 TlI1NYWAXkQkEWbU+f9cb2yHKOzppDuwsnZKoM2iOceOmvCHODt0sgn+OY5ejkq10uLB
 Zo5g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775221615; x=1775826415; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3oqFhX43HW9sWcUMw7pLeeM1qy1V4CeoOACTAi/IGg=;
 b=G+x+xH8uuZ8GbmkLO+GwZTxYkpWyQlf5WvdWriHwTMNUIxw7kZCzCOTsJqeWfRkELt
 YGft3DyGOFTaYRM9F4yk1eIiByXy4ch/2VmjlWaJdNt1q3OK/DAs4lHizi9ZhSy14hoy
 qomlpAb+hOFLCoOB02cA3Tkpkd08vwxVjH7mqfg+1VRELG5Dtwub02UGgw3TNbopT/q1
 q+byTTRuwEHzHMOU3As3V1/4PZDiB2/A7leAFOpHb7RDTZV69+B6kztzA0RSAsCJovef
 loYU/xdJyCxvDdFc8Ypjr1xMciUBcbuFzKmuB9Vs0eBHJTSSyRv4uZTS/qWFL+iPUofF
 Si8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775221615; x=1775826415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f3oqFhX43HW9sWcUMw7pLeeM1qy1V4CeoOACTAi/IGg=;
 b=r6BenYs0BRENjdzBVSTmS6FcW6MfAfyLQbLMDcVfDs/XxkRobK4wKIKGTMUI1bUCCg
 4dh1/Krh/pXAWX0HCmlwYgnSDUzafUqAhqz7FfQiMBo/2cz9Wc4SU1IARNsmWtA8Un6b
 //b2PW7cGptLIct9cRXadXsPz5b4iy18NDc9V3q54agk9qZ3+esKzAnmb32MqemgpCkh
 sqJ0IZK5MRC6uqeQXJ+a7AzVDtHfSAMe8Hid7J2nXQCK6mU67lHsRh1JJEZt0djb+YgY
 d4H04iQSb/O6Y4fTIPf7W9+JxCBCkBbCzrJxWsBlrJv7qSv3lgYW4J1HMORQv9dZ1zK/
 WZYg==
X-Gm-Message-State: AOJu0YxF/JCODu6P/SgNjL/swLyJue4gjap1IV8I85TCYKnkKPMNvWBJ
 +4k1E+viniULcn2RTdk9rHphqhWGUG2VVvOmgk6q+FoLQhX5ZAUFILxlUNewoxl9Dchu8kcvpFj
 QwNd32QHFa7M/WeTDexDENryGkbVV3r4=
X-Gm-Gg: ATEYQzyF61U+7Jr9QCFO+GAO2MmTR2UZwXizHTjaRwiz5RLTiJNut9vNPL71EBQ/QEs
 CQHm1hdRaxXBj0Njzd1EBu79a6Exb3Oy3Fc9mLagMlyxk36Nej/tnCA+JVXGShV9pgdvG6mc8L7
 CVC0ZGQwdM+4H20tyrKsCv1xmNiNGgRBaAizuEQISKEmWDQ9B6JUJ/Bb/qwRWDh1SgwDnrHbBSU
 +vuPmyNm4j268dRm4Gc7v467/ocvIFWSn018aoTqEaYCO39HSzp1kRL8f3XWx4PsxC2ljc/T1MJ
 AmiAMoz3A64tPzIQycEoh50OeOl89sfcJf2NPjMScszT2xuYGkq6iqxlNjotUh9h39ERjGc4GUE
 CuT0K
X-Received: by 2002:a05:7022:ea28:b0:123:2d38:929b with SMTP id
 a92af1059eb24-12bfb77bbb4mr571708c88.6.1775221615237; Fri, 03 Apr 2026
 06:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260403092529.2238333-1-Jesse.Zhang@amd.com>
 <20260403092529.2238333-2-Jesse.Zhang@amd.com>
In-Reply-To: <20260403092529.2238333-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2026 09:06:43 -0400
X-Gm-Features: AQROBzCTbkbBwkJCQo5pqLCmIV_ltFs8eZRuVKIrHZ50BrE4bZql13w_jYr27-c
Message-ID: <CADnq5_My-8QMZr0FX156wyidiF6WE1gt=pRk6gw26e1QxSm3Xw@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amdgpu/gfx11: enable per-pipe reset support for
 compute queues
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Prike Liang <Prike.Liang@amd.com>
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

On Fri, Apr 3, 2026 at 5:34=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> Previously, the per-pipe reset sequence was incorrect, leading to unrelia=
ble
> recovery and potential firmware hangs. The reset logic has now been fixed
> to properly handle HQD cleanup while the pipe is held in reset before
> bringing it out of reset.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 18b92990179d..43a89816f794 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1851,6 +1851,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                     !adev->debug_disable_gpu_ring_reset) {
>                         adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_QUEUE;
>                         adev->gfx.gfx_supported_reset |=3D AMDGPU_RESET_T=
YPE_PER_QUEUE;
> +                       adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_PIPE;
>                 }
>                 break;
>         default:
> @@ -1858,6 +1859,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                     !adev->debug_disable_gpu_ring_reset) {
>                         adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_QUEUE;
>                         adev->gfx.gfx_supported_reset |=3D AMDGPU_RESET_T=
YPE_PER_QUEUE;
> +                       adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_PIPE;
>                 }
>                 break;
>         }
> @@ -6906,6 +6908,11 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring =
*ring,
>         return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>
> +static bool gfx_v11_compute_pipe_reset_support(struct amdgpu_device *ade=
v)
> +{
> +       return !!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_P=
ER_PIPE);
> +}

I think you can replace both gfx_v11_compute_pipe_reset_support() and
gfx_v11_pipe_reset_support() with
amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_PIPE).

Alex

> +
>  /*
>   * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_RE=
QUEST for
>   * every queue on (me, pipe). HQDs must be torn down while pipe reset st=
ays
> @@ -6941,7 +6948,7 @@ static int gfx_v11_0_reset_compute_pipe(struct amdg=
pu_ring *ring)
>         uint32_t reset_val, clean_val;
>         int r;
>
> -       if (!gfx_v11_pipe_reset_support(adev))
> +       if (!gfx_v11_compute_pipe_reset_support(adev))
>                 return -EOPNOTSUPP;
>
>         gfx_v11_0_set_safe_mode(adev, 0);
> --
> 2.49.0
>
