Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02038CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 17:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9967F10E795;
	Wed, 24 Sep 2025 17:07:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Axypm7EK";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD61910E796
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 17:07:14 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2698d47e6e7so37195ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758733634; x=1759338434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uGXKv6vNmqRC6Pe2k9epdhPteSOrLTy3D+CqtuGIBc=;
 b=Axypm7EKYtINykJlv2RVIqqr/xiuCfSOgEmngV/blcxN6E3f+02mtNFpBHC2V8q6+v
 nKMLmjMXhJ9qU9flZq6MMj/GZm0Fv2oNa/2SzwxsyIFndLdMuKSdrn5W/rD+o+PoaOSS
 ZcwdxbZsMhZlhcmsi4nCvhxLyVFmKkgt2FDQtHehSg2nUlCqG5DqoBSc2YFFwkxYPx2H
 8ruwW2C7exUHntbyX1tA+B8kV2NxI/RzH9m7HYsoCIQkO0Fe8MZ5N9K+MYeB5lTf6sOc
 U1/3h5wVQ1YyH4wFWnZiS/XG5H8Lj/IxGWRCGcgbVT6e4l7VzZMpL9BoY/EQpD4Qk7Ml
 JMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758733634; x=1759338434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uGXKv6vNmqRC6Pe2k9epdhPteSOrLTy3D+CqtuGIBc=;
 b=ZWP6pE3VScQFda6j2eV1oYoz2RMANGY6wYNaEZ5+KrSFMr5QjtbisrPThv9Z2HnpRV
 OqVm2QECqaxUTStaIkCVws4kNsvsWlhN37aivULbfhyonbn3lEJ4hlpHeVq6rTIjDdVf
 xcymOAy+37kudhOud+3tP1a8hd5jI0/Ot3NrOXbjdkelABKIOfVrmLpGCZsCy76/ATTK
 0UAqHEPR3rVWHoKwU2q1uJ2yX1XTiXUCXhuREUdc8huB3VibwuzOeKOJKzqrN7G4b9mD
 MYARMLMZmKDqQuntPiena1kzSxKf73SJl9jgXot+Zd/BHzhtGCeI8AMkhmkdKhO5RrQh
 qKXg==
X-Gm-Message-State: AOJu0YwFtVEmTgAp/KKoM5vnYbDazowkgWS7anZKar9T8yCRb7BHEPDW
 foEnvrdvOMcz51+UqKm+rPIkYMdaeN+TqFZS4o4nX7MC6l69MnZZoSXYZKiP0WdZihuc1n1HNOD
 /X232eWYQ6UqSD5Z1kVKMi6OITGYwao27LA==
X-Gm-Gg: ASbGncsibRj/O/aUmdd3LxN+3meZkeDNs/tV0nXwj4s7ut5zARaKDHLSvQzYUFvSTw9
 i7SFtAiMa4lBH3qQGAV+UzSReWaJ4d4YFprL9pOMD9euoHYStt4hKI9rppSVkaHM0CriBRjtvCP
 IdsVypAB+mPTbSTfd/gkZmfFlbRUueKFBVe9UCkc/ZTke6SRqBhFN3V8kV48ze+HMObrnrldHph
 KvDEM8=
X-Google-Smtp-Source: AGHT+IHqc93a+KNaSbL0HAZT8xFpg3MjhNH0xhvBjD7ooI1wF+/6IhIyqBptzn/t3j0Ozcrrv1Guxv7hqgvmMN8jYA0=
X-Received: by 2002:a17:902:c40d:b0:269:af66:5e70 with SMTP id
 d9443c01a7336-27ed4aca730mr2281905ad.9.1758733633969; Wed, 24 Sep 2025
 10:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
 <20250924161624.1975819-6-mario.limonciello@amd.com>
In-Reply-To: <20250924161624.1975819-6-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Sep 2025 13:07:02 -0400
X-Gm-Features: AS18NWBcPPmfyO5fqqgMK7IzdOwIw07dvZkwQRlQQEfIluAxIfg1QOWd-zLOszk
Message-ID: <CADnq5_NWMG7GAWOygZbb1uskHp9fE-_OMje=sx67fLWDLHo3sg@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amd: Add name to modes from
 amdgpu_connector_add_common_modes()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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

On Wed, Sep 24, 2025 at 12:24=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> [Why]
> When DC adds common modes it adds modes with a string to match what
> they are. Non-DC doesn't. This can be inconsistent when turning on/off
> DC support.
>
> [How]
> Add a name member to common_modes[] and copy it into the drm display
> mode.
>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 26 ++++++++++---------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_connectors.c
> index 8c085ed703dd..120d8017b6f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -399,21 +399,22 @@ static void amdgpu_connector_add_common_modes(struc=
t drm_encoder *encoder,
>         struct drm_display_mode *native_mode =3D &amdgpu_encoder->native_=
mode;
>         int i;
>         int n;
> -       static const struct mode_size {
> +       struct mode_size {
> +               char name[DRM_DISPLAY_MODE_LEN];
>                 int w;
>                 int h;
>         } common_modes[] =3D {
> -               { 640,  480},
> -               { 800,  600},
> -               {1024,  768},
> -               {1280,  720},
> -               {1280,  800},
> -               {1280, 1024},
> -               {1440,  900},
> -               {1680, 1050},
> -               {1600, 1200},
> -               {1920, 1080},
> -               {1920, 1200}
> +               {  "640x480",  640,  480},
> +               {  "800x600",  800,  600},
> +               { "1024x768", 1024,  768},
> +               { "1280x720", 1280,  720},
> +               { "1280x800", 1280,  800},
> +               {"1280x1024", 1280, 1024},
> +               { "1440x900", 1440,  900},
> +               {"1680x1050", 1680, 1050},
> +               {"1600x1200", 1600, 1200},
> +               {"1920x1080", 1920, 1080},
> +               {"1920x1200", 1920, 1200}
>         };
>
>         n =3D ARRAY_SIZE(common_modes);
> @@ -435,6 +436,7 @@ static void amdgpu_connector_add_common_modes(struct =
drm_encoder *encoder,
>                 mode =3D drm_cvt_mode(dev, common_modes[i].w, common_mode=
s[i].h, 60, false, false, false);
>                 if (!mode)
>                         return;
> +               strscpy(mode->name, common_modes[i].name, DRM_DISPLAY_MOD=
E_LEN);
>
>                 drm_mode_probed_add(connector, mode);
>         }
> --
> 2.51.0
>
