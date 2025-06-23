Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940C4C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 15:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 407EF10E3D6;
	Mon, 23 Jun 2025 15:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ixIw+RvU";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7996210E3D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 15:32:11 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-313290ea247so812110a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750692731; x=1751297531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tirA7pMxjYLfDKLSnAy/viqp8X9gamHeDRjvjquel0=;
 b=ixIw+RvUL2Yg4r/I6dc3p8HnfcR4CwtYlOeJ74ABI7cfiJKOUAKd5HLPCYRIAVfFle
 dK3ZvVbe7guJs7AHawu5LT8OTwRaTGFVUMm65IpX5FOI53JZJGegg7MHfDeBKgkiH8ek
 QCoGmZCPxQOHSv+yLIdQxNwq3U+cheWMO1fTBe/59xbA6BaCNfLAxU8TU9iPnpXHXRaU
 p0VTjliCp02ZxChjbLNV02asvbDuHgMxup/aJL3E6qCt5UCL65ZmJzwlib+A9JSWKiVc
 IMAZ1vwN3dsoESQ0pYPI0h0wY63uc5PWpruv+T6DK5Cp0I28foF6BFb8fb5wL3B+v31R
 +HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750692731; x=1751297531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tirA7pMxjYLfDKLSnAy/viqp8X9gamHeDRjvjquel0=;
 b=BQEh4QsMOie8T3bexOWHuK5lkyPpmtMsbl8m4LS5+ZsrtGHsDsqfAqYOdf0n/vqHDC
 R/M30wTbOaG4070PA+UEQB1UNPgCagiXzFmk3eguLMDOAXy/+lNxelP5I+bJXV7C0R1Z
 BPEYIJ0TUFQlM/lW3JmLA67OvJZsxC4+/IYa63eZRVlxX3ga17fZoDM+ZFuO4uwflMfp
 UQOfBzVBq7VPpA+pwfRaWG7Skw19Vm8Y3ipBw7ejrfiFIzjclbGKDmKG7KfsYOeI0J+3
 Rym0pizW/RAxRjE88aGmjSf8ruysEtPM/Iy1bqN+oABqflm/tFWWKbQcffoYeI1yI1GC
 9LUA==
X-Gm-Message-State: AOJu0YyaqxLisrcAfQ1sZMnDiw6u8f7J15QDIANJjSqFQV7XwZ7Olxwp
 7gmo8GQ9forRechF9ZEl+b6uZ2rHkaPljGW4fRYDDbl0NfhnlsQWzsp/Ir3BylOjVDf9+1M48LK
 gia/15veepGqV7bPAvdXVpxr/GWl+ZtHpOm9T
X-Gm-Gg: ASbGnculSBaUf711mqlYK2vqyQ83NxeJpB1HeEsYkk2eGU4URYY1k6qEGm9SyfvSzNM
 2BYr4vc4be4p8e3BQ1OyDV3uJtc4t0P9O9HZMX54+E0mNtV1vhCcPe8BqvhoufLLfBTg4RAfWge
 c72lJ5GmFehD4CekETkGnnzIIDE4DOezzKBm9PBLBn5wTc
X-Google-Smtp-Source: AGHT+IHZgYJt/4Zlk6qN9Loz+l4T4xmxweyiEv7bS73JV8TvQkvJtpY+IJTx6rG1ETXSml0oQuiB/pd8CVrbdfPJe7E=
X-Received: by 2002:a17:90b:5105:b0:312:1d2d:18f8 with SMTP id
 98e67ed59e1d1-3159d8facf9mr6894543a91.7.1750692730932; Mon, 23 Jun 2025
 08:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250623144821.745908-1-mario.limonciello@amd.com>
In-Reply-To: <20250623144821.745908-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Jun 2025 11:31:59 -0400
X-Gm-Features: AX0GCFtAyy-waOaM0N_CoCG8vp8EVKA82qpt9q3S5knctjFA0W4jgthJGIKySJg
Message-ID: <CADnq5_N=OXLgXBozZybiHROTsf16PwWbwh6xz-G6=dmJKhBXmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Mon, Jun 23, 2025 at 10:49=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 16dc8bc27c2aa ("drm/amd/display: Export full brightness range to
> userspace") adjusted the brightness range to scale to larger values, but
> missed updating AMDGPU_MAX_BL_LEVEL which is needed to make sure that
> scaling works properly with custom brightness curves.
>
> Fixes: 16dc8bc27c2aa ("drm/amd/display: Export full brightness range to u=
serspace")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I think this will break the old non-DAL backlight handling.  See
atombios_encoders.c.  Might be better to just add a new #define for
them.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_mode.h
> index 6da4f946cac0..004450cc41c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -435,7 +435,7 @@ struct amdgpu_mode_info {
>         struct drm_property *regamma_tf_property;
>  };
>
> -#define AMDGPU_MAX_BL_LEVEL 0xFF
> +#define AMDGPU_MAX_BL_LEVEL 0xFFFF
>
>  struct amdgpu_backlight_privdata {
>         struct amdgpu_encoder *encoder;
> --
> 2.49.0
>
