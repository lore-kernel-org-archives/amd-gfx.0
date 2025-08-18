Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37B2CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 15:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB3C10E486;
	Mon, 18 Aug 2025 15:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ud6h270c";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FAD10E486
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 15:42:40 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b47170382a5so242944a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755531760; x=1756136560; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWjR9wVlQD2RfvrWT/us7U/22C2c5eA2O2hDzhadvrQ=;
 b=Ud6h270cHTyHAFbcY7+FZCR0O8hchJaXJqrShoFvBAE7e2hFvV8OXzGPLjCfAZlLeQ
 DOmxIO8Yy0YFoRa9+NQyBhN+b7At8oOJk5Nayr6TQk3wwVdTKLU2hsKmdZMszGrMeHIm
 46RyRQGbVkv6G5CFvp+/3bgD2rQmdOg8FERBpSlqxKBLkoTStTsPiQoJ3cj5c59a3j+l
 JzMSDXrXqRZV3D17SdX4UzKzKFgJMJERaa8IjLaKsNQCj4Nu0zMBEn6cHMUMVffVFiul
 MOZdCbyejOOvIWTMeugbiHHxvi8jHebqtWMTRDSSsg/JHkk8LI35EUWhXher2nSxv1J7
 9FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755531760; x=1756136560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWjR9wVlQD2RfvrWT/us7U/22C2c5eA2O2hDzhadvrQ=;
 b=cOy2VEEcEdUzuKOxNvHxIfBizMCXSzVr2iNuriNmRnxxzkMC1WJRecl6SVtBDcaSgc
 tJt0WY862x5b6r2EwSqfZ+TEi7jnVrVoNgRMX0D3sdsmqlxUq5bFMUQYI3sEcO+9a1eE
 IZ5zOgRDjpR3j3Y1swGdvbZTevaFj8ddKjzwN3+6sGdeFE1lUiGB5BWvdzcVC6Yr1dLT
 UvqTFeIlU6h8zMRws5UawEfQ1UObf0gJDU6+MYLKitIW1IP8unTLdlQy648MFBTwiR5u
 dGhpgiCQDZ1slPRq2ynxkLjwSMB8MEud67ytMBgbkImToBv50tHjyio534tJbG6dt0FC
 osXg==
X-Gm-Message-State: AOJu0YwZ6PJ8GsDgivVDCUF1L6dDa1MWVxdivSQALzlb/Q8JRMpQd9UY
 rfnE+7iVsBOMivkNa3jnTvDHjTCCa8d/IaChv1fQSBp8ov4milNh+lynMWq5W1RlTcyU76l/vIm
 5xNmNrDhwwuVxfyHc9diUJx4YyOooNSI=
X-Gm-Gg: ASbGncuQEgWWuEOydQapj+M0wYBE7nk3SVAcyjAgDD7HqjzIjhwKYU1maCD/9Y/47mg
 bAb4lnC2PmuXba/OJO9hwClkd/JP0EzQgOECZKys6UG7dorn51UOmVpzKsWQoGHEdfXEm2UqfZ5
 F/sOuUsQTeodTQODg4gwwpwR47Cr5GtSucE7d+q6WajmMJQEgCkcfKztzrwbgjt08udz/3A84zJ
 P+I+CVf7vkIo4i9LA==
X-Google-Smtp-Source: AGHT+IFlzppuD9dNSIJnnHhIzNxU5p8tpYd3DxpTg9wZMmRJq7jnDuFScfIHVkPHYC+uCbocydQz1sTTgeL7QGR7YWw=
X-Received: by 2002:a17:902:ecc2:b0:240:bd35:c4ec with SMTP id
 d9443c01a7336-2446d893254mr59572885ad.6.1755531759554; Mon, 18 Aug 2025
 08:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250808151517.1596616-1-alexander.deucher@amd.com>
 <CADnq5_OozSsP_qXBPjgYR9-1cChsYTJtg-y8RPb2wA9Xn9dfoA@mail.gmail.com>
In-Reply-To: <CADnq5_OozSsP_qXBPjgYR9-1cChsYTJtg-y8RPb2wA9Xn9dfoA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 11:42:26 -0400
X-Gm-Features: Ac12FXw9pe0IzLWcAt9ziG1lWfA0qbYNMRZKjTIdFRf8u6BBDl4yqo6FHvRpRUw
Message-ID: <CADnq5_Mt2Lxjso_1d+7jJbw7WGqFuY85iKL-Y1ZNCXg3VB0iqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop hw access in non-DC audio fini
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, 
 oushixiong <oushixiong1025@163.com>
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

Ping again?

Alex

On Wed, Aug 13, 2025 at 9:09=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping?
>
> On Fri, Aug 8, 2025 at 11:23=E2=80=AFAM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > We already disable the audio pins in hw_fini so
> > there is no need to do it again in sw_fini.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4481
> > Cc: stable@vger.kernel.org
> > Cc: oushixiong <oushixiong1025@163.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 5 -----
> >  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 5 -----
> >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 5 -----
> >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 5 -----
> >  4 files changed, 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/dce_v10_0.c
> > index bf7c22f81cda3..ba73518f5cdf3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> > @@ -1462,17 +1462,12 @@ static int dce_v10_0_audio_init(struct amdgpu_d=
evice *adev)
> >
> >  static void dce_v10_0_audio_fini(struct amdgpu_device *adev)
> >  {
> > -       int i;
> > -
> >         if (!amdgpu_audio)
> >                 return;
> >
> >         if (!adev->mode_info.audio.enabled)
> >                 return;
> >
> > -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> > -               dce_v10_0_audio_enable(adev, &adev->mode_info.audio.pin=
[i], false);
> > -
> >         adev->mode_info.audio.enabled =3D false;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/dce_v11_0.c
> > index 47e05783c4a0e..b01d88d078fa2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> > @@ -1511,17 +1511,12 @@ static int dce_v11_0_audio_init(struct amdgpu_d=
evice *adev)
> >
> >  static void dce_v11_0_audio_fini(struct amdgpu_device *adev)
> >  {
> > -       int i;
> > -
> >         if (!amdgpu_audio)
> >                 return;
> >
> >         if (!adev->mode_info.audio.enabled)
> >                 return;
> >
> > -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> > -               dce_v11_0_audio_enable(adev, &adev->mode_info.audio.pin=
[i], false);
> > -
> >         adev->mode_info.audio.enabled =3D false;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/dce_v6_0.c
> > index 276c025c4c03d..81760a26f2ffc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > @@ -1451,17 +1451,12 @@ static int dce_v6_0_audio_init(struct amdgpu_de=
vice *adev)
> >
> >  static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
> >  {
> > -       int i;
> > -
> >         if (!amdgpu_audio)
> >                 return;
> >
> >         if (!adev->mode_info.audio.enabled)
> >                 return;
> >
> > -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> > -               dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[=
i], false);
> > -
> >         adev->mode_info.audio.enabled =3D false;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/dce_v8_0.c
> > index e62ccf9eb73de..19a265bd4d196 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > @@ -1443,17 +1443,12 @@ static int dce_v8_0_audio_init(struct amdgpu_de=
vice *adev)
> >
> >  static void dce_v8_0_audio_fini(struct amdgpu_device *adev)
> >  {
> > -       int i;
> > -
> >         if (!amdgpu_audio)
> >                 return;
> >
> >         if (!adev->mode_info.audio.enabled)
> >                 return;
> >
> > -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> > -               dce_v8_0_audio_enable(adev, &adev->mode_info.audio.pin[=
i], false);
> > -
> >         adev->mode_info.audio.enabled =3D false;
> >  }
> >
> > --
> > 2.50.1
> >
