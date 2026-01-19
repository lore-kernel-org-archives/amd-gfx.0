Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA31BD29C2E
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 15:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D09D10E2AC;
	Mon, 19 Jan 2026 15:32:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QkQHq+Pp";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A160B10E19B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 15:32:44 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1232de2e2c6so150999c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 07:32:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768836764; cv=none;
 d=google.com; s=arc-20240605;
 b=SPgw6n2DbXj8oDuXadPriRFbHB+Tw7evWr7B9+N5HCkC4OrMt0fgdGQGIrWB+H3jkG
 FxltrC8L5BKaIFo+B2nFbebY3wT4ue5AZU6oIm8uXdGmwIa5tmPTQcroi3hjafnhxE15
 /+pO6RO2vIS/9cInUqV8AggKb94y4xDBJj7IC+W47xvnXJJlmOvhrJk77cC3+MK0SpRJ
 Q8BrWCoJnsgKBQthkUEhcQO0ibSUAf6A9uYcl8Ju2OIReuABlz6h5dTVq0VfUfDzjMDi
 0NzPByuRIqrmwh/2kwaMraE1wXuzP4vzXtUAzwhA5kvtUEVOwjBiuvuIeoei7/JLMhjQ
 OeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fImTte1fxp7A+UUuGPcjOwlAej0rmxglegz09JzZSyY=;
 fh=zj3Jd+fzpo9qt8sMCXtcTVwniZFQ6Xn0PkEjoMm/MKM=;
 b=NHuXNu3Z5LS6hNi2pd2mn6FPC7DHnn3dsvIH23he+qn2OeEiA8r62t+SZJPMbjuxGa
 rwE19X2AO9QcyNg8O7QSafqpezzImdAIMMLHQZ5vRyrMb54QuOD/vaC3BhTGurxPBt1l
 P+nsRavP447McX1jWhk9+0aNJfEOjzVRn0ErPtmPnfh526d4LwjOfwuzuwYZpPK/u4AI
 uBqTC6JfIZZvkD0tnZYSxsqqDIUbyTHsbSZI4wpQWMJL41JvHaEAurBFo3qFgfSS+yp4
 ZmoEzn1YBOOGb/0X3DQ0EmHvURpfa08E1ITOc6tOAZwnxz2Ac5P7a8wJLeu7cZEbbkds
 km2g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768836764; x=1769441564; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fImTte1fxp7A+UUuGPcjOwlAej0rmxglegz09JzZSyY=;
 b=QkQHq+PpnnUkcz4spL3GzL5pW+n/szuxcp/s3/NYy4m76G51TRIji4XCHj8x3/HBmR
 2sJH2j7UKvqiuh6QVYgj+hKG3MXQm1/26bThD0w0628+HHeTYW1RBjq/8KcJ5lvW+g0v
 hAOS73HsFeTUPwpIGP+WHwulKNYhjq0FZj6AsWe++0rFPo8S9Js7mllh+ChOb7GWfkbT
 zmqxTZsJXiARtMbFYDKfbR6HSnDejbi5bo+tpAfFbUI6zeLtAD4MBks0CrGh1wB0YvFk
 pE9fpqnb7/Q/UaG3fFcrAmPAWKcr3zunyzzdIS6aVIhbRfxyWkMjYOkJv9zX/7n8+akJ
 pFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768836764; x=1769441564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fImTte1fxp7A+UUuGPcjOwlAej0rmxglegz09JzZSyY=;
 b=OyDmDSsnlBNF7ez9p1olBcfwE7zGkRHVW4Etc9TE3SZZyk87H5xvdCyAQxrsF97vJu
 cj9JLlTZlIunztOE/UUQRBPqOs+wJWvbTGlImysjPAeGTTxVZkK/zSTFO7CrbE2vxy0L
 dy0MTu9ul9wluBzhA9t4INKle2wgbsIbapdzQKRLNBbTDjwiTbCC0QDvuKZs2CQbkXDn
 ltob4Ib/yYi/5iAt9G/81rfv//C77B+L0qaPGng8sXTZd/XoA9srGsMsq9L9S06yry54
 l1t0sKiss4RJvUVo4qU/5ohpPt3QiSven0mmNdH+nrkfJSHskXlJ5V7zpG8WZcPmrmWt
 hLQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvWjmpTEHWdplaShGiHtUJyJItN3qD/zLykyyBS+/7s82mjoHbRLjKlCsNklmpaaLiAOba1g8L@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFPsCm5AnRkwBATEdU0wNOdkXxyKOmyxkZPQezuQNUoGp4gAlK
 JREtXADJ8K2UTagZCzKiFYJzhbEqweHy7kmK+s2waD7YSrYYXwkTZ96pfMDi+H1v2GW9dcOj7IO
 YtqFCu5XIfFdA9Ad5PCnoyU+ed1eTcAc=
X-Gm-Gg: AY/fxX7TiuEeyVyY0S18vO74KE5Q2bMaryTSEJFFafR1I3b49gEqtyA2nzfq/XEo2bd
 Oz/bDQdlL2MV3F8mqqmlu4L1pZ9wdcnICO1K5WgPTrnQ5rE0klr1KEWtxubJydPL2YwfDnrt+Sa
 V3r6fIw5Z3mCCn9WEhaxxPEYwQ6sDpRi0MCnx7N3ad4DYYakos4h2v9doh5Xq46qi5lRbXvuGRA
 L09tA09o+w3bGvfOUigct2kQESA29V8RBWYW83x9V72En9WqfCiKBWKeEthgOA7ksA9grch
X-Received: by 2002:a05:7022:e80d:b0:119:e55a:95a0 with SMTP id
 a92af1059eb24-1244a713d6bmr4923545c88.2.1768836763824; Mon, 19 Jan 2026
 07:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20260117095421.12700-1-decce6@proton.me>
In-Reply-To: <20260117095421.12700-1-decce6@proton.me>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Jan 2026 10:32:32 -0500
X-Gm-Features: AZwV_QiPXB_jMj4_9o148eXT2DvApiGgXceyKtRNlHPzqDodG8vQjdvbrt6w9gY
Message-ID: <CADnq5_Nrp6xsEOgs8PVy5cmO3rV9QhdoyBDB6DdTdOtXpmnZ6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/[radeon|amdgpu]: Add HAINAN clock adjustment
To: decce6 <decce6@proton.me>
Cc: kenneth.feng@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Sat, Jan 17, 2026 at 2:17=E2=80=AFPM decce6 <decce6@proton.me> wrote:
>
> Currently, the AMD Radeon R5 M420 GPU is unstable when operating at the d=
efault maximum 850MHz/1000MHz (core/memory) clock speeds. For example, a ga=
me may stop working within one minute after starting up. When using the amd=
gpu driver, the process stops with exitcode 6 and the following message is =
printed: "amdgpu: The CS has cancelled because the context is lost. This co=
ntext is innocent."
>
> From my testing, limiting the clock speeds to 800/950 MHz makes it work p=
erfectly stably.
>

Thanks for the patch.  What revision is your chip?  Can you add the
revision check as well?  Can you also split this into two patches, one
for amdgpu and one for radeon?

Alex

> Signed-off-by: decce6 <decce6@proton.me>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 ++++
>  drivers/gpu/drm/radeon/si_dpm.c            | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index 1f539cc65f41..fcb9e0e20175 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -3468,6 +3468,10 @@ static void si_apply_state_adjust_rules(struct amd=
gpu_device *adev,
>                         max_sclk =3D 60000;
>                         max_mclk =3D 80000;
>                 }
> +               if (adev->pdev->device =3D=3D 0x666f) {
> +                       max_sclk =3D 80000;
> +                       max_mclk =3D 95000;
> +               }
>         } else if (adev->asic_type =3D=3D CHIP_OLAND) {
>                 if ((adev->pdev->revision =3D=3D 0xC7) ||
>                     (adev->pdev->revision =3D=3D 0x80) ||
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_=
dpm.c
> index 9deb91970d4d..2f386ea8827f 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -2925,6 +2925,10 @@ static void si_apply_state_adjust_rules(struct rad=
eon_device *rdev,
>                         max_sclk =3D 60000;
>                         max_mclk =3D 80000;
>                 }
> +               if (rdev->pdev->device =3D=3D 0x666f) {
> +                       max_sclk =3D 80000;
> +                       max_mclk =3D 95000;
> +               }
>         } else if (rdev->family =3D=3D CHIP_OLAND) {
>                 if ((rdev->pdev->revision =3D=3D 0xC7) ||
>                     (rdev->pdev->revision =3D=3D 0x80) ||
> --
> 2.43.0
>
>
