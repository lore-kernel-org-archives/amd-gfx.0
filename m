Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C7CCA0EFA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 14:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D722210E649;
	Tue, 26 Aug 2025 14:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U25XOgMx";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC4510E649
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 14:06:57 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b49d7a11c0aso521441a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756217216; x=1756822016; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkBvvzlLFwspZwmg9aNgW8jVoQMIoU95fR3DR84PHwA=;
 b=U25XOgMx7S17cEle4umkM3Mn6v58XzsRW/ViYH2kCG0JiUnNjzwBn99fjcf9ESU3Oq
 gARv0yBGeyejHOhfnM97D7aYi+/XWQhFzHIuKSUEY0nXGwNYsgnsu+Bx/bLqvR3OWV5w
 dwnt8eQ9bK2SFDwdKjPl3GpOVeAsJ5wv3vts25H/FyM1DWpkIeoj2tPPzMB4YgQbYPK5
 esCZ/mTa/MlvXOBCulWrfRf77dEInqgMjwKZ8oTNQ806ICL6EtMn/2ante15VjRYDzZk
 Lz6x9DCIDIHhyWnhQWlMPC4GsHSae/Npm/w9bbraqNVwHSxT6RCLs+Ys02wWfe5Fyu9t
 CAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756217216; x=1756822016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GkBvvzlLFwspZwmg9aNgW8jVoQMIoU95fR3DR84PHwA=;
 b=fKo9nggEKaH2DK/RA801Kw26ojZtkM/YiHy6NzEN6pmhcZCjTF+CQqCwzQe9bXZeh0
 bkvG8eWVf5EijoeX7JDdIIf9kdCpF4jMMglu1srNJrDdOfYMQTuFYvL5fDAz+t2QT8YF
 AMmowZQsm9ev2LtyHd+b+K4dYDiVgwGajbU+weH06ELI4nkkdwllNvOq2kWCAY6vtVPH
 1Yjfi1b2dpO0Dtm4i2zes0ih2YyYbZ0vtCj0U/u9q2slBbW2UbTGeEihIP4vJmeCanZi
 w/J1cMiXVJbrShABOxxCyCejXeRG9bJZzjgYJFdnPHALICqpkz+n0JwJ5SIDcD9Wt8bF
 dFzg==
X-Gm-Message-State: AOJu0Yx4g6VJN5uVXVnf3bX9SPjSXDoqNzzHP14CTYf0nzhVjDmnIpx4
 nUDEPLkT1a0POoI3Sj7KiSmmYSUQa0cDLUU8Xh5fPcqcqbXNUVa/oO3TgbTQK3lA8fX8CKySJf8
 ssBClJUcHX0Tefgqn8dWfe3KMH22Lz/o=
X-Gm-Gg: ASbGnctO6R9nMf7MXqJiCVmYPNe7tf6Ih3e00EWweS8yiS/eMFz4Xcg2aEpeMSYSV9I
 ciH6ZXbzp1C8OGfgpXJJ28s5U3p4VX0NP+yXnSkg1on4bFtJDktnpCn3R7BqdtngxmrVpLC0mcM
 m7Z2JCuvlKURVhDSw41zeahUBGcpqrqpEt+QyLSnC4I6QfDMa8Q6GLx07DA+q4iN3QAuZ/BpB3k
 sp0xRE=
X-Google-Smtp-Source: AGHT+IEPKZJqFgelFYRRV2m+MsvvTjNv49o9Np79HlJeoH5XrLyORCwGixqV1P+ZoWPNaJU8dv4pn3WjKZjpzTjOI/0=
X-Received: by 2002:a17:902:d506:b0:246:b1cf:fec2 with SMTP id
 d9443c01a7336-246b1d002d1mr66417395ad.4.1756217216240; Tue, 26 Aug 2025
 07:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250825213333.612600-1-timur.kristof@gmail.com>
In-Reply-To: <20250825213333.612600-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 10:06:43 -0400
X-Gm-Features: Ac12FXzbk_EKD9J8jlfQ-KT15_QvtGdIOYDW4wmjNTo3vTXzXZFhTKGU7EAcvG0
Message-ID: <CADnq5_NwQCGgsgVZ1T3ofxrLJhDkq0FO3GKOViWtn8JhFC+vfw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix DVI-D/HDMI adapters
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 harry.wentland@amd.com, alex.hung@amd.com
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

On Mon, Aug 25, 2025 at 5:33=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> When the EDID has the HDMI bit, we should simply select
> the HDMI signal type even on DVI ports.
>
> For reference see, the legacy amdgpu display code:
> amdgpu_atombios_encoder_get_encoder_mode
> which selects ATOM_ENCODER_MODE_HDMI for the same case.
>
> This commit fixes DVI connectors to work with DVI-D/HDMI
> adapters so that they can now produce output over these
> connectors for HDMI monitors with higher bandwidth modes.
> With this change, even HDMI audio works through DVI.
>
> For testing, I used a CAA-DMDHFD3 DVI-D/HDMI adapter
> with the following GPUs:
>
> Tahiti (DCE 6) - DC can now output 4K 30 Hz over DVI
> Polaris 10 (DCE 11.2) - DC can now output 4K 60 Hz over DVI
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Makes sense to me, but would be good to get input from display team in
case there is anything I'm missing.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drive=
rs/gpu/drm/amd/display/dc/link/link_detection.c
> index 827b630daf49..42180e6aca91 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -1140,6 +1140,10 @@ static bool detect_link_and_local_sink(struct dc_l=
ink *link,
>                 if (sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A &&
>                     !sink->edid_caps.edid_hdmi)
>                         sink->sink_signal =3D SIGNAL_TYPE_DVI_SINGLE_LINK=
;
> +               else if (dc_is_dvi_signal(sink->sink_signal) &&
> +                       aud_support->hdmi_audio_native &&
> +                       sink->edid_caps.edid_hdmi)
> +                       sink->sink_signal =3D SIGNAL_TYPE_HDMI_TYPE_A;
>
>                 if (link->local_sink && dc_is_dp_signal(sink_caps.signal)=
)
>                         dp_trace_init(link);
> --
> 2.50.1
>
