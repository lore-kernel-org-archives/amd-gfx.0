Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC57C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 16:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1DB10E392;
	Wed,  5 Feb 2025 16:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NfAbTWIn";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65CE10E391
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 16:04:57 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2f7d35de32dso1535052a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Feb 2025 08:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738771497; x=1739376297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRnx/AmYmWtwizLz5VGv9VOdt6wgTBuQNInwovXscS4=;
 b=NfAbTWInbXOlJdaMdhcC+cYw6HgcgBSm5vQkleAfgVBoWmoyt/IhUsVRjMO7OfBxtc
 5DBfNo1dvWYxrZ3/47bKH/mnzrZO2jKWTuF3lCvTt9fNEUczmWEkMXuJsNrHl+ZtrqBp
 xIxSPgu1db9D1bkGOjDUAITxursNOREW8bFF4wip/Hr/lZLqhRVm5RER47CTo/VayePU
 r3wc5RKSVADdiSuDpVduMAsCYfEKWqa/5OBWSz7eIsEKBCfnImkrGTFNLcwN31wgFp+j
 kmvd8E8rjtcAfMNUHRWYh3l4QFxu/3H5h+X/zqJuzGjqjoPEpXwKNCY6Cm5t1TfHzClv
 ruwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738771497; x=1739376297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRnx/AmYmWtwizLz5VGv9VOdt6wgTBuQNInwovXscS4=;
 b=DX4dQOLhY2aJdXFxjBkQ0zwbO+2aFO6R449mysDIzigq/48eh0qv8i7u4BPg7oFHZJ
 GY5F9bGxApiQHPfIwEI+/v7R7Gbu7tkA0OiZbcQ26ujWlFNHzp4wwvwSbnRH5QUDcwdM
 PIuKPBD2F4APwFvg158hmfw7TNi4KUMqN251f+6d22KkASIhaRh/BRSzeIO9KCiGxu8Q
 FQ26kedewIaT0zfdNDrkS5H1adV7F+pQ4WMk4Pqbb/E4ErGrAX1RSg/LTJRXNEttUcTH
 mMvymD+3hjA2cmAAWtr66X3DppujANNoXChxmHCD7GKWkM5VoRcxMKrt179wnp5Fg6Yo
 0yjQ==
X-Gm-Message-State: AOJu0Yzv+GjA3OeThvGus2L8DKXnoA+rEsdxI2YmDNHLjLy24FQuvaMP
 atjpUWfHiQfqHEzJ0xEZYvr30aOwLbsqY7x0ipBvWAvsH1P6ymEC++Y6+dIo/HW0ihIPiwXprn0
 osw1wu4bTJuLMk6IcwefIlXOF+nA=
X-Gm-Gg: ASbGncv9hCEJLbj6CW0wGbpjWtLn+yJ+TKwxZfmcUVpe2p9b3terVUO0A33VZSwLoDF
 d1RQNls4W10fUftxZG8lkAxfZEV5Pflt5PWxyIs9GbuIFoFGgZFH7wtOInvXKw3Z+q/mBF1PX
X-Google-Smtp-Source: AGHT+IGXP3vG8IuYmaA2Bjtm3mbzr5gMf/Yt59qlFppTuLZ6RZQ4Y7Ek2NV5x/vrvluuOmnXxM6fFMzZfqlawTz/S/s=
X-Received: by 2002:a17:90b:380d:b0:2ee:b665:12c2 with SMTP id
 98e67ed59e1d1-2f9e074ca7dmr2031870a91.2.1738771497100; Wed, 05 Feb 2025
 08:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
 <20250203214349.1400867-5-alexander.deucher@amd.com>
In-Reply-To: <20250203214349.1400867-5-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Feb 2025 11:04:45 -0500
X-Gm-Features: AWEUYZmvSv_6AfI63X0Ds9ak49dIgjJa1JW3OCDt-BMYRRxAnBXHhce2w2TrpNk
Message-ID: <CADnq5_OjpjBrLCFcQfzAarZhY9QkxH7yrwTpJUim0fb5VPA8eQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] drm/amdgpu/sdma5.2: use
 amdgpu_gfx_off_ctrl_immediate()
To: Alex Deucher <alexander.deucher@amd.com>
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

ping on patches 1-5 of this series.

Alex

On Mon, Feb 3, 2025 at 4:52=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> In begin_use/end_use use amdgpu_gfx_off_ctrl_immediate()
> rather than amdgpu_gfx_off_ctrl() as we don't need the
> extra delay before we allow gfxoff again.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index b1818e87889a2..7f2e1962b5755 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1882,7 +1882,7 @@ static void sdma_v5_2_ring_begin_use(struct amdgpu_=
ring *ring)
>          * doorbells when entering PG.  If you remove this, update
>          * sdma_v5_2_ring_set_wptr() as well!
>          */
> -       amdgpu_gfx_off_ctrl(adev, false);
> +       amdgpu_gfx_off_ctrl_immediate(adev, false);
>  }
>
>  static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
> @@ -1893,7 +1893,7 @@ static void sdma_v5_2_ring_end_use(struct amdgpu_ri=
ng *ring)
>          * disallow GFXOFF in some cases leading to
>          * hangs in SDMA.  Allow GFXOFF when SDMA is complete.
>          */
> -       amdgpu_gfx_off_ctrl(adev, true);
> +       amdgpu_gfx_off_ctrl_immediate(adev, true);
>  }
>
>  static void sdma_v5_2_print_ip_state(struct amdgpu_ip_block *ip_block, s=
truct drm_printer *p)
> --
> 2.48.1
>
