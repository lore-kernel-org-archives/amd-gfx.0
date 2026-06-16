Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD88BCD98D2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 21:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD1510ED12;
	Tue, 16 Jun 2026 21:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VP1m0gx8";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6116110ED12
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 21:51:45 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-304f9bc869aso562026eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 14:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781646705; cv=none;
 d=google.com; s=arc-20240605;
 b=Q3NvPBJpB0jQX321R2PRiWQBrI6/BFRzFEEALRCcvnYuG4dADpApVSFCZm2QDHzPBx
 Axd3MAK7+6zSjfCrG9n/RL/5c69QGh25h8w91IMW9swJ7VfoHfKZwiK2le72+99tGS+N
 1gE3APalp+G+086Q+HQkIbfS21xaa644QISnH3syNfQ0YPM412Ia2Y1wK2FL7G4tP9sq
 3GxVovC+7WogKBHE10evqOnsojiGG9p4e4sFWKty1fulN+ThvXUyJE9EOJz15aZSgw8u
 rEBEBMv4TBJXmeY2BMxh8wqSx7KqoePYZ2Z0uONsXqlirpeATozpj6YG89iy9DRQ8YGp
 wn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LU5Z2vvo3M8Bpnq5T9r1IB15bIlIeTbMSCSpx/TfUGE=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=AEJyuUvl6Fxfq4nPWt19G3rpexfgLxMLI9yT/YyHtNfrJN1m0jAfSbT9SqZdKN0lI2
 GNOUjralbDtER5qXmV1puEnNnTgaZIxa5j4jiTZz+tEsYY5kcGhhrA1sEHSnO/+QQ11P
 9TodSmx44gbD83pml0nMc2qMP1yzaWEB1xY7rTkRbnoDUqIegnUSWUVRSWGg4l5iBpgg
 ofqHxqvo7KGc9GSjyc68vWjO61u48VyX+hnPLcyYVAkKqh7w49Dhemx5sE1KCs4Je8Ah
 b7qNs1l0JGYnHi9/ZTbfUmFtU+6I1xuRHlrhS1M0uZSMef4GQ/+gn+FWnOJorM+pBWrH
 Cuyg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781646705; x=1782251505; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LU5Z2vvo3M8Bpnq5T9r1IB15bIlIeTbMSCSpx/TfUGE=;
 b=VP1m0gx8zI1t6DVKfQM+fZyjhJCOlGo4qOwNAV/hXaMqNT9yKQ9E9Xo2UgCkfJcPbT
 yALhGZJGKdujg4r5puTJV9BmoSurN8vUJwsrnpjD6QQh/+8hycCwYq0WugkWXSvA8KVG
 uEfmrO7MYmO1HGoDUlJgu2cqF8HmAC7mgFC+CZinrBLb9cyqucwlelu8KYJOg7ekQJiZ
 jLHYWLpMRLug3Xo1DXCqiLHb7ir0LkIG6oNrYmNG4bqkP+MMXND8f4t4V8dDV7y4xwYc
 OJZIod/qz85com5ARz9lki+QCUesVKfQl67jaTIeDvoltStTh8MuwH7GgxS7rDmLrRfQ
 RNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781646705; x=1782251505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LU5Z2vvo3M8Bpnq5T9r1IB15bIlIeTbMSCSpx/TfUGE=;
 b=YY4Pco2L1K154sXXkmP1QoVQGyDwrShf9DkClr4VaoVzZmvpGXit4IMYHUfPZsgQYd
 KQuHbXAriYx6tAoPGxvOEDnyCvIG8Za9HazqzljhHMN1M/QfOJ66MvZT8oM8t05J5Ov7
 +7rQahv+7ke2IcqDpip63KRPlVtAiJ5TEu87twjCfmKwgQ7k9oOUg5a1MCXVmHU1hz3f
 CLOVuYYgSUOYqRULRN8toiJTsYQAHwa3bY2FIcSn5gltu5qOoV9yHvkUdhzZQdCubY3C
 kIZHc1uVvs33uNwyUDo6alaHOUuf5/ZMEdZVnS48r/mn8eAf/kKnu4bK3q7P64JNnkAm
 IRig==
X-Gm-Message-State: AOJu0YzIwV+S65xvpRZ64kFKKZQsyv0cCC1Hbo1lgNK4/UCPROyeDKPm
 8b0lJMiNoR7S0cqjO8hN1JZLQqHMk6Y8dWTJMKEU68BSIwVhujlvOurt/O3eRLcgxzXZk2QmVyc
 zmxwhg2xN62h4DdUONlKt1aSN1PpaP34=
X-Gm-Gg: Acq92OHX7lh7/07ylMIOCLif2F/A7BzoWIXiyobIsQG5dsN/7sAm0+CAAEGp6RWU7qE
 UDTPNCr8AHrNKEn6wXGfHV7SsbFgYuN7xHxkFFaUFqQn2P5oRG96CTfKFY7wqfcqXI/TmTwxm2w
 s93fvdvArQAyMchGNQakvRAekqiQZ5bT9SM3/tuWS5xl3CyQ0U2b+P+Q5BjJBIkk5TpDLh76pVJ
 WHEn2wm5gKIWQymAauCTVIiUA1W2tZ7dU1Gyo9mXXqBUROt+4x/G8PjERAhP+t3c3jr7LD8YRKd
 7grM8KsvfRYYG1kktVw1QRrPG1R/bTyRXA8nTWs8CvN8bex7yOfu/JskA6KUpGNd/ZIWwg==
X-Received: by 2002:a05:7022:6b98:b0:12d:c389:ae54 with SMTP id
 a92af1059eb24-1398f630734mr205639c88.2.1781646704615; Tue, 16 Jun 2026
 14:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260611035747.548780-1-Jesse.Zhang@amd.com>
 <20260611035747.548780-7-Jesse.Zhang@amd.com>
In-Reply-To: <20260611035747.548780-7-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 17:51:31 -0400
X-Gm-Features: AVVi8CeL9_iksydEsfoTmiPB1cmeZEn0AENqMDW_AaE8WEN5ai6i72Kqt58nX4E
Message-ID: <CADnq5_M6Hf4zxcQcVKZSkNY3rbwp6GCTZJd3a=SXdMWSXQ3W1w@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] drm/amdgpu/gfx12: try KQ first in EOP IRQ
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Wed, Jun 10, 2026 at 11:58=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> KCQ EOPs were misrouted into the userq fence path when enable_mes
> is true. Try KQ by ring_id first (KCQ and UQ never share a HW
> slot); fall back to amdgpu_userq_process_fence_irq() on miss.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

I think you can squash 5 and 7 into one patch.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 30 ++++++++++++++++----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index d9b1fc29e9d8..c5fbfc6d8338 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4843,31 +4843,32 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device=
 *adev,
>                              struct amdgpu_iv_entry *entry)
>  {
>         u32 doorbell_offset =3D entry->src_data[0];
> -       u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
>
>         DRM_DEBUG("IH: CP EOP\n");
>
> -       if (adev->enable_mes && doorbell_offset) {
> -               amdgpu_userq_process_fence_irq(adev, doorbell_offset);
> -       } else {
> -               me_id =3D (entry->ring_id & 0x0c) >> 2;
> -               pipe_id =3D (entry->ring_id & 0x03) >> 0;
> -               queue_id =3D (entry->ring_id & 0x70) >> 4;
> +       if (!adev->gfx.disable_kq) {
> +               u8 me_id =3D (entry->ring_id & 0x0c) >> 2;
> +               u8 pipe_id =3D (entry->ring_id & 0x03) >> 0;
> +               u8 queue_id =3D (entry->ring_id & 0x70) >> 4;
> +               struct amdgpu_ring *ring;
> +               int i;
>
>                 switch (me_id) {
>                 case 0:
>                         /*
>                          * MES splits gfx HQDs per (me,pipe): KGQ owns qu=
eue=3D0,
>                          * userq gfx owns queue>=3D1 (see amdgpu_mes_get_=
hqd_mask).
> +                        * Require a strict (me,pipe,queue) match so user=
q gfx
> +                        * EOPs fall through to amdgpu_userq_process_fenc=
e_irq().
>                          */
>                         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
>                                 ring =3D &adev->gfx.gfx_ring[i];
>                                 if ((ring->me =3D=3D me_id) &&
>                                     (ring->pipe =3D=3D pipe_id) &&
> -                                   (ring->queue =3D=3D queue_id))
> +                                   (ring->queue =3D=3D queue_id)) {
>                                         amdgpu_fence_process(ring);
> +                                       return 0;
> +                               }
>                         }
>                         break;
>                 case 1:
> @@ -4880,13 +4881,20 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device=
 *adev,
>                                  */
>                                 if ((ring->me =3D=3D me_id) &&
>                                     (ring->pipe =3D=3D pipe_id) &&
> -                                   (ring->queue =3D=3D queue_id))
> +                                   (ring->queue =3D=3D queue_id)) {
>                                         amdgpu_fence_process(ring);
> +                                       return 0;
> +                               }
>                         }
>                         break;
> +               default:
> +                       break;
>                 }
>         }
>
> +       if (adev->enable_mes && doorbell_offset)
> +               amdgpu_userq_process_fence_irq(adev, doorbell_offset);
> +
>         return 0;
>  }
>
> --
> 2.49.0
>
