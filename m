Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF3AC001DE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 17:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5CA410E336;
	Mon,  7 Aug 2023 17:14:10 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52DE110E330;
 Mon,  7 Aug 2023 17:14:07 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6b9e478e122so3952569a34.1; 
 Mon, 07 Aug 2023 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691428446; x=1692033246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3EBbZKi3RkEqdqagrdNXc65Wt2bOkGGaDnR6Sxbz/TU=;
 b=Qk5swv/rGyqvsGjlOFfJ0Eay/dnLGQMDdxpB7Z+8yqfQuDyGpSyqB6bDT158gP1Njg
 /GG+KK2Js0vHJmMHmMKKQN8IRMf6wGIbPw5z29lUjzsavTXUyVPT0BLOQBDZ6Phtp5Er
 WMQdzQ4PcGeLGF+gEZyv6Q5JvvB00w5oYLzayYnDNtQ7AKKn9wBtlFLWCy+PJFmmYUcm
 sYZ2eV6JaCXSvGcsrlAUQRyEhNXq2g/zmmy0qkoX+WBiGn2vjBhmKXpdNQ9172k4wLj/
 8cM8GBR4uyZ02T7GkCJyNNNVpHdD46XUBb6B7hJ2D1Cpq0uekYwByOV98M+VNgwHtpQj
 Jodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691428446; x=1692033246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3EBbZKi3RkEqdqagrdNXc65Wt2bOkGGaDnR6Sxbz/TU=;
 b=BxeZbGEA152OUkiOoj1mHBtinuTT98KeSfUuu3xhvKmNZfuCb5bmqzmL89b/LF1Y8F
 2hW+bYlRCGig0vn4WiEUNcMA99pkkQbUXGxvpJFxjRgqXUWDdnA5B+xK4EtpDRQU3I/P
 yg7rhbuSTp2riS5NbY8QT7gGcAt/NtR2mamGe/pmn3BJOde9CQ3ZBJyaB6ZrGlvCY9xu
 sK+XK5RYwL1/NDItrv4DJra15VmnpS6pypIWci0RXpIYJRw9+taLPEXDGu/C7887JcFI
 diYn8JkQgmGgkuQD0/f/FXQo5aKP6+rjNezDaMMcRD5JJCcUn1KIShl/0VFi4BM5h7Gu
 Pv8g==
X-Gm-Message-State: AOJu0YwqT0i3VVKtmeFhf07sDIGtoZXzMFcrSl3UMxcNl2rPBRXEa/dJ
 1EUNKb/UlZc7XY+raZC2xGU3PxGVc9SUVHWLEuw=
X-Google-Smtp-Source: AGHT+IFc0NAbYU5nU/5o1tjMWmuS8uQgHR8QgnNK+2Zu4oa67IfIMb8gua5e9zY5SdJnbhTMerc9FVwW6XDxVCPgFS8=
X-Received: by 2002:a05:6870:42d0:b0:1bb:84f4:d787 with SMTP id
 z16-20020a05687042d000b001bb84f4d787mr11938381oah.10.1691428446578; Mon, 07
 Aug 2023 10:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230802061423.11155-1-sunran001@208suo.com>
In-Reply-To: <20230802061423.11155-1-sunran001@208suo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Aug 2023 13:13:55 -0400
Message-ID: <CADnq5_Ob=reocYAdj8QhB03bREr-3xRY0uTt3EQtA3Ld-exBeQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in dc_stream.c
To: Ran Sun <sunran001@208suo.com>
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Wed, Aug 2, 2023 at 2:14=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_stream.c
> index ea3d4b328e8e..05bb23bc122d 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -71,8 +71,7 @@ static bool dc_stream_construct(struct dc_stream_state =
*stream,
>
>         /* Copy audio modes */
>         /* TODO - Remove this translation */
> -       for (i =3D 0; i < (dc_sink_data->edid_caps.audio_mode_count); i++=
)
> -       {
> +       for (i =3D 0; i < (dc_sink_data->edid_caps.audio_mode_count); i++=
) {
>                 stream->audio_info.modes[i].channel_count =3D dc_sink_dat=
a->edid_caps.audio_modes[i].channel_count;
>                 stream->audio_info.modes[i].format_code =3D dc_sink_data-=
>edid_caps.audio_modes[i].format_code;
>                 stream->audio_info.modes[i].sample_rates.all =3D dc_sink_=
data->edid_caps.audio_modes[i].sample_rate;
> --
> 2.17.1
>
