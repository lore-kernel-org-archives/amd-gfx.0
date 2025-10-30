Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0228CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 20:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 688B010EA1F;
	Thu, 30 Oct 2025 20:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bm647/T7";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C02B10EA1F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 20:49:40 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-32ebcef552eso250816a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 13:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761857380; x=1762462180; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MhkgAUMKOV9HXlk+s8+cg3Mqe1pJL2T4DxPb1i+FBw=;
 b=bm647/T7fHJayBSiEHWkYyP0sAEm6Eme4CSOPpSenZqbEgQytr2ec1LRgfzjeHRL+C
 VUiUhwHU/1wi3ZoULhBO14ILEc8+U8+kjpAS2+rae4LzVGGXlT4aVlVZadD48647Ac3i
 zqDvBz/y5k4wDK2NgJZTUYmwmIAvxgFLC8ffwzAubBG2q2p/b4W1NogPw9485mWh/ml/
 xny06JrJERp5MOQH85NHqsQNSNZrLjABRJEikQUpfi+dU8RC+2AGsBkk93SpQMLLtqVl
 8oNtj4bysgm9FGL61ooUqaB2Hd//TM1sGaoZbNLF7SX38l78w1xoGyb5q5pHDQ1kIK17
 h8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761857380; x=1762462180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5MhkgAUMKOV9HXlk+s8+cg3Mqe1pJL2T4DxPb1i+FBw=;
 b=CKC72iO+rNXcTPxWC9Gve8WpfPXlb9Faa4hsyFkb6ACnSWr5VpiEO8jm/RWifl5oeS
 lO3XrNx9wKZhzOpq3oqJZa1/PLAkAfmeV/QBtvH0HQg8BEJTrSiqjKOJoAynN7ie4LkM
 9uUjoSCgeWUZfUF6YxD15dvIwioRnphW/fYWvgtw/x5S5ohqbjE7fxEFGVXgSXLPQhaT
 EYsuizXLdbb5yicU8kFdFVlmvQEFWJ91rs9aLCSQ4S0Fkd1E0Ep1HyKxOUXT/M2jfagK
 Bzepg0fQRecIFN4suMkoQW1NGDu4w+U+1dLC2VM0lrSmGOQeXUg1JltfF6X1aJQV9eQ1
 d5ig==
X-Gm-Message-State: AOJu0Ywn6iWGHKNnKQwbe7NsOsPoHoU2DDFP7035cHZDDlzYRaiEUfHI
 LTgk9hQ43NF9a95qUgaMT7XFS3g4q5JKwUTp1Bz5bQdDoAovLYaaKD6X+4qfsOGm1hIcaULg71g
 CXvtCl87Cb18ytUji5mAshlUOUnTnbJc=
X-Gm-Gg: ASbGncut/bNbU4ffFQNrrdM1cg5l71XTJqsjI3qgzI+ljOx4KKs/eZZoQpRlT+PEMqy
 JSowA6ScHxONBj7n+hErEWrErxYGWlZwNN0aYQLCW7Bmm/G8eqbj3pdmPCJXabZY1u+UwWXoyAH
 C7f3lZYwupy0S/150vyHG9WjY3BfGN4Q21MYR1dwkloekAmkJFHFupkQaAVtY9P2024H6CW8I2R
 U6s/+l3rupDfO6cyy6rERcNSikf4ujv5ttL+zF4LTD/loLck4eg0ms1kw9NPSjzd+qAJ4E=
X-Google-Smtp-Source: AGHT+IFbCD1Q3ccsOLRXX07f4q9lNZMoR/p+cyMaUrXpyqy5PGUh6CX2RvIQus21sUe3a4xnXPK2NMfNC65bkYqAWWs=
X-Received: by 2002:a17:902:e415:b0:257:3283:b859 with SMTP id
 d9443c01a7336-2951a53baaemr5261425ad.9.1761857379947; Thu, 30 Oct 2025
 13:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251030193943.4064454-1-superm1@kernel.org>
In-Reply-To: <20251030193943.4064454-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Oct 2025 16:49:28 -0400
X-Gm-Features: AWmQ_bmw7COUPndW9iLbKLuUDkDJJyMDNxb0_ktVkl5byGDVNG_ceHOGBBAYF0E
Message-ID: <CADnq5_N==TV+c99gq+PaxRpi9OVZpcCMZF6ro==JKp0n1zrWhw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Don't stretch non-native images by
 default in eDP
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
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

On Thu, Oct 30, 2025 at 4:16=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> commit 978fa2f6d0b12 ("drm/amd/display: Use scaling for non-native
> resolutions on eDP") started using the GPU scaler hardware to scale
> when a non-native resolution was picked on eDP. This scaling was done
> to fill the screen instead of maintain aspect ratio.
>
> The idea was supposed to be that if a different scaling behavior is
> preferred then the compositor would request it.  The not following
> aspect ratio behavior however isn't desirable, so adjust it to follow
> aspect ratio and still try to fill screen.
>
> Note: This will lead to black bars in some cases for non-native
> resolutions. Compositors can request the previous behavior if desired.
>

We may end up getting bug reports about the black bars.  We had a
similar debate about what the right default was for radeon 15 years
ago.  That said, at least with this the pixels will be square with
this patch.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Fixes: 978fa2f6d0b12 ("drm/amd/display: Use scaling for non-native resolu=
tions on eDP")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4538
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 29b9197bbbc32..5b279182e66a8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8078,7 +8078,7 @@ static int dm_encoder_helper_atomic_check(struct dr=
m_encoder *encoder,
>                                        "mode %dx%d@%dHz is not native, en=
abling scaling\n",
>                                        adjusted_mode->hdisplay, adjusted_=
mode->vdisplay,
>                                        drm_mode_vrefresh(adjusted_mode));
> -                       dm_new_connector_state->scaling =3D RMX_FULL;
> +                       dm_new_connector_state->scaling =3D RMX_ASPECT;
>                 }
>                 return 0;
>         }
> --
> 2.43.0
>
