Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3F0CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 15:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B1CD10EA1D;
	Fri, 19 Sep 2025 15:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZhEao5yU";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3169B10EA1D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 15:09:33 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-269ba651d06so1907385ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758294573; x=1758899373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3TlNrMx0pT9d99eLaiW72vWkrGfY0prEYSKuOObGIA=;
 b=ZhEao5yU5V5QMe9IDRn+O70x+m583Zx9mSw3HDdsuQX8KFTmk/q+4ianwZ4n3gnz0C
 bZcmnS/HNLGFZ5AkpAAwbZFlIzJJzHcku0da2vq1ehwNjK1US0glPd0grddMkQ09aNuD
 NwEzAAyz9qtRKKV/nHLWDLuQ3Zx5x8lYuoHBYY7sFzjkoSYQvjdNVVyiavTxkC6heg76
 UopV05qdar8AJIqdhUhEdX3mXbCTNkhr50CbuYOn0ovF8KqjKEeiZAJsbeO6Vh6h5MQu
 jAnOtK9TkIqhWcazzb/+jVNiMu5YIm+HRTLwg94V6cPkrCYVHRs5XEGUma3tir2YkPTp
 u+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758294573; x=1758899373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p3TlNrMx0pT9d99eLaiW72vWkrGfY0prEYSKuOObGIA=;
 b=gFeuhJtdLtiUm/LasV5H/5dkDzVP0DhsWyDc69+fw7KOz6tzTps2BCjuHzOPeO5xa2
 ozANJHrxR6GgPEd+1LyXiDk2twr4EJAfqJiUNssNjjRT+IK2vfIwwbWqiHM2jGDXEsqJ
 1YEpEBDWPhFRloYy1ETo/thhvJDn+OlFXSxXnAuJjCyAJEXrnKwtEon3uuYJQ6TRZhQL
 LmF0QEO3YUImtR5UEh4hUf9CsK43qI7SFx0/l3H8xhklcVKscRMlp0u5JfNrD93RT1UC
 v+k9agLdDXBv8uMgOkqxtX9BbpvimjiKpXaAX7uNANT5m0c1haPtO0oIOKmi8Up4fvCe
 5+9Q==
X-Gm-Message-State: AOJu0YzMWNnzRJAPRgPpmm0JKEw1htbjhnpAfCceyXCYsQjCMQpdg3KZ
 Qulqtk4EJhyOUp6dc7ty2V4s0V8KvAclY/PvGthNH8PeRixo9Osh8p/IjqtI0TIjACd5V9jsKyT
 HpvvG7gFRmSlEFlGUI8GdLSTKhOBzSo0=
X-Gm-Gg: ASbGnctAnokhpHgpMjXn8Ga9/xmYCs+74iRreN0yduJZpzvFsGsKc9MgnCisitrkBsZ
 4xo7P1fHDnCXBlv6a4/n/M4GlBardmOJFZK+HFyLNGAL78q+KtjxHNtTDqkCCynx7UjgE0V6ELr
 pPU/i4K+CZA9sXrnLoPd0j1I58Mo3cDhkOixFPl6OD7W/rc4OV8tvJURdvkIF9hCUO5Cf65eGLL
 kUBMCY=
X-Google-Smtp-Source: AGHT+IEZ2pKfsnHhbUqXxUFqJfftiAlGaC/NDlq9Yh33zisP44WS2mM8NU6Cxvrrw7PckbCXhU3Vrz7/JuHhlMHTYTQ=
X-Received: by 2002:a17:903:2451:b0:26a:f96c:3099 with SMTP id
 d9443c01a7336-26af96c339bmr20135785ad.3.1758294572507; Fri, 19 Sep 2025
 08:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250919081419.9034-1-timur.kristof@gmail.com>
In-Reply-To: <20250919081419.9034-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Sep 2025 11:09:20 -0400
X-Gm-Features: AS18NWA_r08JkkzG95QfrCfOpHANQS_-V0yHaUtygXWnjB8uKh8Oze8y6sWvdNI
Message-ID: <CADnq5_Pj43m4C2esgH5wVFfbq5rSehSeL-7NkdwHU0ByNSRdUg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Reject YUV422 encoding over DP on DCE
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 alex.hung@amd.com, harry.wentland@amd.com, siqueira@igalia.com
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

On Fri, Sep 19, 2025 at 4:14=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Mark YUV422 unsupported over DP on DCE to work around a
> regression caused by the recent YUV422 fallback patch.
>
> See https://gitlab.freedesktop.org/drm/amd/-/issues/4585
>
> The recent YUV422 fallback breaks DisplayPort on DCE6-10 because
> it can select a high refresh rate mode with YUV422 and 6 BPC,
> which is apparently not actually supported by the HW, causing
> it to boot to a "no signal" screen.
>
> Tested with a Samsung Odyssey G7 on the following GPUs:
>
> - Cape Verde (DCE 6): affected
> - Tonga (DCE 10): affected
> - Polaris (DCE 11.2): not affected
> - Vega (DCE 12): not affected
>
> Polaris and Vega are not affected because the same mode
> gets rejected by other parts of the code base, possibly the
> bandwidth calculation which exists for DCE11+ but not older HW.
>
> It is not documented whether YUV422 is actually supported over DP
> on DCE, but considering that this encoding was never used before,
> and that YUV420 is already marked unsupported, probably not.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Fixes: db291ed1732e02 ("drm/amd/display: Add fallback path for YCBCR422")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4585
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Would be good to get feedback from the display team on what the actual
capabilities are, but seems reasonable to me.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> index 0c50fe266c8a..686f6be68c91 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> @@ -798,7 +798,8 @@ bool dce110_link_encoder_validate_dp_output(
>         const struct dce110_link_encoder *enc110,
>         const struct dc_crtc_timing *crtc_timing)
>  {
> -       if (crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_YCBCR420)
> +       if (crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_YCBCR420 ||
> +               crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_YCBCR42=
2)
>                 return false;
>
>         return true;
> --
> 2.51.0
>
