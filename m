Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0D9D2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 15:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B181510E61A;
	Tue, 20 Jan 2026 15:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SPUwtCtW";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AACB10E619
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 15:08:28 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-122008e73c7so206932c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:08:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768921707; cv=none;
 d=google.com; s=arc-20240605;
 b=K6fExRkmXs7I5gIkxpkQynIxw6+3gVPAS6WKONFFVWA7CDH31nbJC3IhOjEFiCUuq6
 IglS8mjmt2t+t4shsBmzjvwP8FJU0Rnj0bG6TVLmbLSZOSAeHB6SIUMUeZcg5UrTDhqH
 rQzQJNNIet3ahnk9NAI3bqaHQAA27eShOSOChoEc9blS3UJBZJeQHEDnIqZ2MAcWoeZW
 dPMFLv1kUiXIIsJD4T4y2DgmGFHqHlij5GyH4usR39CY441arRhARZ/Y/66re1kzP/q2
 41CkQOH2IYcUVKxRefXE/JueVA5cNbRaOsuWPy1eku0j8AnveOy2AYlLo0JeXT3w7WhI
 wllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mUmrSu31ONwAekOtCK0Hi13CBA3nu0/xLAwS+OlZz4Q=;
 fh=pbK9CkuE3Nql9ZzV/CJotgTXPTtV1p82ljkHFqwkH7g=;
 b=Oos+JC6iz46OHMBDh/Yp9qTsZHwbvHz6zMt5Y/Xq1DJTChYa9IPU554UkSNaLzjgAQ
 cnSVqnJyNzMvST5P40fp43lnTkxy5lDQAOw/DeV4uFxEwh5IzwgqWSEWPPzU3Poql57p
 z594oikVd984eJPsiYREtg0gV1dp+X9CMAb+0Lbsn9A1LnfVgo+7Vxr5smqZzl0CGQBt
 pmaN04kQCylRUBtevvsBJzhLP3dvKjUUNJerJdn1vsFA01nhEjmQUTNjBBWCsUL756g3
 ObQnZQ2x8LFc9OMFXs4UfYAgZmz5tKTm+y3kDRKMKAEoGfV8uilA84lQHwmV9R3Ggimm
 g+Lg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768921707; x=1769526507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUmrSu31ONwAekOtCK0Hi13CBA3nu0/xLAwS+OlZz4Q=;
 b=SPUwtCtWWKSMzUG/iIYXp+bi6Ebh5pAahUYLs7xpNklT/iObIxClo1JP8I8ezR3oW5
 NknoFHngwle28RkYHHus5rZYyO4Ew0BdE8uH29+43hmxWEGfbI6+qXZFwuOC3fqsew6/
 v0ZbyGqScMQmw+ZKkdvt4GDkljpHWdyY404dknYQlPQ3ERLE+77/5TS4YhViEiuMc7NB
 StdoVp+Je0hbsKJbWkXSL5HhglGeybdV3CdhwSNON8ACJBlw1Fm++jcItATuGNcHBPAy
 pnFTXWIeAey1YZT9cf9GPyGdivh3lQgTSppH0m2PCFY5p9BTItZhFyxk6GqZ5qb8NMFB
 fM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768921707; x=1769526507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mUmrSu31ONwAekOtCK0Hi13CBA3nu0/xLAwS+OlZz4Q=;
 b=HlGqRPBjvv0xZKSGbDBm/Y9zm7d/223+cA5lf6ebTiKoQyCxQUHwuxD5oOa2NBjYGY
 xz+MPHz0R94iN+wiEehkthyPz19OQ81QSUKp+mqKmplLg30gz6PnZlsoKKGcP3+ve0R4
 XnV5yUXkNF2971bnLJo/i+7jvsnjbwFZFrsb8IowQ0dJ7B95ubufbTx8EN//CeCFzERD
 rQS27o9g6/2ezQf0yN9uSCzHyl/Qd4QtBCwIb3aB2xkHTU5831ls5NnaYaKZj/8FpK6S
 +w27y0r+gmxj7xhCvp6/kLHiHhOIOWmw77thc+6r8o59k9xzkJOCityhRfaH2y+tV7zR
 FoYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv5r9K+JxNloM/2PjV/d9ACyxmiyhUiChiMAtOUgyq6h5pEFuZSQNgC7gV4Ul6ekx4NhLr9M4S@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBZk8o/QK8yUcEGaLU9XmcuVdPvqQh9fl4oWnJbYB79CHUiZAE
 t+CUm+CkM6LW5v5tTfwZ/AfBOENXCIom2iHzC4n273vVySd6yuWSPM+CrIp+P5BxkuC1XSIEL+w
 uxz3J2dT0/WZacUVJibF8OlFsoPtTx44=
X-Gm-Gg: AY/fxX5fL+jJpW1Di9+b945XRA8gPgihfFy+g/DSIhogmA3uyM3XDo+CX50GAIEjGav
 tBzhwyVlNiCne8FUJU3BKdYF0Z0Mi70+izh3RehozGZguEN6oBUFAE20ct/fPkzf7vluwzL9Hsh
 QwUo7m4v3qLSBbGzDOtz0GKngV8nwv4o1/jJAtbjr6Q84WbLIgb9kqbanUW9aAfZHU0qoqqT7ZD
 6sHpiCfXaQLQ289SI2Je2sr8cVbnVDkIq6pZaZ2Z8J76qSNbET/eF0kBqQcK4V8M8fzqcdUA5R2
 zscstao=
X-Received: by 2002:a05:7022:988:b0:11e:3e9:3ea5 with SMTP id
 a92af1059eb24-1244a784d5amr5877902c88.7.1768921707433; Tue, 20 Jan 2026
 07:08:27 -0800 (PST)
MIME-Version: 1.0
References: <b6bd1fdd-fae7-4ee9-ae06-9abe168adbd4@amd.com>
 <20260120063718.203785-1-mukeshogare871@gmail.com>
In-Reply-To: <20260120063718.203785-1-mukeshogare871@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Jan 2026 10:08:15 -0500
X-Gm-Features: AZwV_QgXgb-PwVx8LhgBmWAgQ7P5qiwZoXFZFMd3tgmE88AqA_JFQA7mJqDS-oU
Message-ID: <CADnq5_PnT9iMTvgzGCDVqVdkCO0Mcyr13VSz3Xqrgatgd5JuUg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: convert VCE logging to drm_* helpers
To: Mukesh Ogare <mukeshogare871@gmail.com>
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Jan 20, 2026 at 3:26=E2=80=AFAM Mukesh Ogare <mukeshogare871@gmail.=
com> wrote:
>
> Replace legacy DRM_INFO() logging in the VCE code with drm_info()
> helper that takes a struct drm_device.
>
> This provides proper device context in dmesg on multi-GPU systems and
> aligns the radeon driver with current DRM logging practices.
>
> Note that this change logs firmware version information at info level
> and does not indicate a failure.
>
> Signed-off-by: Mukesh Ogare <mukeshogare871@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_vce.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon=
/radeon_vce.c
> index bdbc1bbe8a9b..ed631c0e5e28 100644
> --- a/drivers/gpu/drm/radeon/radeon_vce.c
> +++ b/drivers/gpu/drm/radeon/radeon_vce.c
> @@ -121,8 +121,9 @@ int radeon_vce_init(struct radeon_device *rdev)
>         if (sscanf(c, "%2u]", &rdev->vce.fb_version) !=3D 1)
>                 return -EINVAL;
>
> -       DRM_INFO("Found VCE firmware/feedback version %d.%d.%d / %d!\n",
> -                start, mid, end, rdev->vce.fb_version);
> +       drm_info(&rdev->ddev,
> +                       "Found VCE firmware/feedback version %d.%d.%d / %=
d!\n",
> +                       start, mid, end, rdev->vce.fb_version);
>
>         rdev->vce.fw_version =3D (start << 24) | (mid << 16) | (end << 8)=
;
>
> --
> 2.43.0
>
