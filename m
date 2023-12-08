Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3D6C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 22:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874B210EB53;
	Fri,  8 Dec 2023 22:52:53 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9EC10EB4D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 22:52:50 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1ef36a04931so1546907fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Dec 2023 14:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702075969; x=1702680769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UiwvFaUD8EPefWqgf6uhsqnQZ1rIaVFjILMSr5E6V/k=;
 b=Bz4dz8FtJT4rDDKyi24hcQcKOtgJJEgHViD+AanxPn7t0/wyMA2H3lByQL6GMshK/S
 3EIF46i1p1IvcF6A4ddn/o0PGcJoTVUh+/bkCSkN9zYr6KiKqvCTckEvazik3xOY9S3I
 k4Kj66YGzhsfwcgWa8DOKRxb9LE1oaxFsmMX0P8FXiRu/FCzFkq1Pkmi4Ah2y1xXyHbY
 TBdGqCXrqE9u8rCIQa1HnWIX4ATasoapy15q2+YFtqiNpxNcCCsl35CiTLj0WtKXnRy5
 N+er/rzicznaUGv730QtvSE/bICdbwm60UCdnbn4mDfbam5M+MeoiaWvUkamU0LBr8+E
 w29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702075969; x=1702680769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiwvFaUD8EPefWqgf6uhsqnQZ1rIaVFjILMSr5E6V/k=;
 b=PLVpVEv+QEEjayygQOY9bSpYBk2uM9H5OQOJUK1w6V7FgxB4RpYSyr1GhTcQuLfoAF
 6zy0cgbn3G1jTCBiQVsya3J7qus/FhcVDhBaf4fIut671y/g0RhwQpxul1cC4rFpW3fQ
 fAQJmh5RIdvviphWh2DpYfU3KpSfQWzFjtu8uuhldnCdW9KFbA+vkDZgr4Rx5koCaOCP
 ESPP5XCKcT+kp5wiU6Em80YtY+iOD1OA2YVO5RFqBYd2TkdRfqqbrrFRjjNS2SJ3zl5m
 gJt48nkTc/uoyNIXhBA63RC/y/oEpEjFR/UpkQxKpW3rs0xKjbQdWS0LwmvLW+d6E2oo
 1DuQ==
X-Gm-Message-State: AOJu0YxJ34FhneRgAQ8cL1SjYvVzxIl+8+G1L/3AVcMxFeaJdDA5vTEZ
 k9oAQpwRDkMHL9Knj/dg0zDja8TqT5kBpNqfpBWBpi+WZOQ=
X-Google-Smtp-Source: AGHT+IE5QbbsqveIxfo5nbcwPGTiDjBweiWpU8ul4EEui/F2kPuQ0Yli8ws52OZqqK9icyBQuKaFimZVMuK666Kaq8U=
X-Received: by 2002:a05:6870:164d:b0:1fb:75a:c43d with SMTP id
 c13-20020a056870164d00b001fb075ac43dmr922665oae.102.1702075969345; Fri, 08
 Dec 2023 14:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20231208221928.5679-1-alexander.deucher@amd.com>
In-Reply-To: <20231208221928.5679-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Dec 2023 17:52:37 -0500
Message-ID: <CADnq5_PP7hVFa-d19_fw+ZMH1KJZd9D_rQGzENDNzYWPukWaoA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/sdma: add begin_use/end_use helpers
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 8, 2023 at 5:19=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Add helper functions to disallow GFXOFF while SDMA has work.
> This should avoid corner cases where GFXOFF is erroneously
> entered when SDMA is still active.  For now just allow/disallow
> GFXOFF in the begin and end helpers until we root cause the
> issue.  This should not impact power as SDMA usage is pretty
> minimal and GFXOSS should not be active when SDMA is active
> anyway, this just makes it explicit.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Since sdma5.2 is the only version that currently needs this I think we
can just squash this all into sdma5.2.  There may even be 5.2.x
variants that don't need this.  Better to keep it all in that code.
Will send out a v2.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 14 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 1d9d187de6ee..d4b08d03970c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -326,3 +326,17 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *ad=
ev)
>
>         return 0;
>  }
> +
> +void amdgpu_sdma_ring_begin_use(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +
> +       amdgpu_gfx_off_ctrl(adev, false);
> +}
> +
> +void amdgpu_sdma_ring_end_use(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +
> +       amdgpu_gfx_off_ctrl(adev, true);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index 173a2a308078..b52d16829204 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -171,4 +171,7 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_devic=
e *adev,
>          bool duplicate);
>  int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>
> +void amdgpu_sdma_ring_begin_use(struct amdgpu_ring *ring);
> +void amdgpu_sdma_ring_end_use(struct amdgpu_ring *ring);
> +
>  #endif
> --
> 2.42.0
>
