Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE31CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 13:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777DB10E1D5;
	Wed, 13 Aug 2025 13:09:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HPK0UETX";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5FC10E1D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 13:09:28 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-240358f4aa2so5154395ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755090568; x=1755695368; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuPKhstn/bjNwp0etjc4b5aGFH6uxoU5SzTyhORYv1Y=;
 b=HPK0UETXjtW2JDmSfSGWIe548P5/8jjWU8oGZPmoT4AC6f6X8CU+07+MRU4q7vS7GC
 xtAd5msRRX6+ul1PqHpw8ixjuQzT63Vg3dmtdPXefkoswnDOeX8NfvTo7SaNuIBpta7f
 FELi6SesBLZ/8DtY7MjFcvSbbNObnci5xmeGOveLWt9ZQTkc/QDLaD7sDV131SVAfJYc
 ENxpzjrRm84A84pgC0Q6VssX3OyRNVlQnyWoHBGnjUf3h6GjXaKlT4ifHJ1YC9ElfxMp
 pzc/s+oUR/utANNlfI5YoBF7OsAK8y/bA1dRzuL8/xRsh+oEu6IZkSxaQIrAOqIYUMin
 1bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755090568; x=1755695368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuPKhstn/bjNwp0etjc4b5aGFH6uxoU5SzTyhORYv1Y=;
 b=q7D//IZqigqLIR+Ea9C8DBeT3Q1eTFAUEdB23YTrFhwvsAVBjNver8tHJ10c07J7Il
 kXRPEprzq+xRDC5QMQ8JYSMTeAMnEDZy2iu6OjChV05vSmGieAhwD3B2HJfcgQLAfUPz
 ShMDPCmdzjDQsEjs35gqSvBIEAsezRwL/wT1UHO7R7fSI4wp0G4WaRLoeSpNvQxNdWM8
 oAjDvliNtGFZ7txpohePQPPgN4uDw6SFXL5ci9fM5kEGLPgtgNbIHrEAId9Dj+iFvOWr
 CI8wqT7ksfmmCDtQdwoRjzyCVRndxLFi75ofrflQ/jA9TB2yaTFuksB2yib4sTPsE1dz
 ZZKg==
X-Gm-Message-State: AOJu0YxON5YnHpWkBjNzxrYuyBjR5jS0/9wvnLDFl97UYFYzkp1ytDcQ
 K8XOPObdmO7C7OKTzoe7W7pP6Pv/MAhYU7BpazUaZQuZrjavnHyomygbiyu3rYi6r4Dy8obb4Pq
 H94U+DBdS0C4zAX2BaXE9mbxH4eelBE67VA==
X-Gm-Gg: ASbGncudhBzYNYFEInn+ZuxGFpP2HpWRkooTlsWF6fHKJRl5OtZ2rNZeSuaya1fnQY+
 9pPPbJ/zRn/uFUDRtftTy8WaDwKh4ZC2Budm4E5QR9UFLsSn0/tm9qmmPEJWwO708ywb/6YGKkr
 4lrmE6affXBoQbx1/n0rI1hIx861ZIWuRLS1a8OACismuGj2Ak2t4kUwSimGNdrHj0VQpj9vKEu
 wQxRRw=
X-Google-Smtp-Source: AGHT+IHOEooZ2AOS8NtHgO/OzzoDvkw0oKvOMoX46wIcwfcdmsX+/s+TC1z8c5hTvbe4h9XggI7b87m1DgNnihswDJ8=
X-Received: by 2002:a17:902:c408:b0:240:3e72:ef98 with SMTP id
 d9443c01a7336-2430d2f5151mr22417675ad.10.1755090568031; Wed, 13 Aug 2025
 06:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250808151517.1596616-1-alexander.deucher@amd.com>
In-Reply-To: <20250808151517.1596616-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Aug 2025 09:09:16 -0400
X-Gm-Features: Ac12FXyuqPURw1JAMGIy4NOxBc47f3CyqOjVyMxSUTMs7jMVtIWNRYFYsa1g1XM
Message-ID: <CADnq5_OozSsP_qXBPjgYR9-1cChsYTJtg-y8RPb2wA9Xn9dfoA@mail.gmail.com>
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

Ping?

On Fri, Aug 8, 2025 at 11:23=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> We already disable the audio pins in hw_fini so
> there is no need to do it again in sw_fini.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4481
> Cc: stable@vger.kernel.org
> Cc: oushixiong <oushixiong1025@163.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 5 -----
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 5 -----
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 5 -----
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 5 -----
>  4 files changed, 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v10_0.c
> index bf7c22f81cda3..ba73518f5cdf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -1462,17 +1462,12 @@ static int dce_v10_0_audio_init(struct amdgpu_dev=
ice *adev)
>
>  static void dce_v10_0_audio_fini(struct amdgpu_device *adev)
>  {
> -       int i;
> -
>         if (!amdgpu_audio)
>                 return;
>
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v10_0_audio_enable(adev, &adev->mode_info.audio.pin[i=
], false);
> -
>         adev->mode_info.audio.enabled =3D false;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v11_0.c
> index 47e05783c4a0e..b01d88d078fa2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -1511,17 +1511,12 @@ static int dce_v11_0_audio_init(struct amdgpu_dev=
ice *adev)
>
>  static void dce_v11_0_audio_fini(struct amdgpu_device *adev)
>  {
> -       int i;
> -
>         if (!amdgpu_audio)
>                 return;
>
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v11_0_audio_enable(adev, &adev->mode_info.audio.pin[i=
], false);
> -
>         adev->mode_info.audio.enabled =3D false;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 276c025c4c03d..81760a26f2ffc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1451,17 +1451,12 @@ static int dce_v6_0_audio_init(struct amdgpu_devi=
ce *adev)
>
>  static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
>  {
> -       int i;
> -
>         if (!amdgpu_audio)
>                 return;
>
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i]=
, false);
> -
>         adev->mode_info.audio.enabled =3D false;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index e62ccf9eb73de..19a265bd4d196 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -1443,17 +1443,12 @@ static int dce_v8_0_audio_init(struct amdgpu_devi=
ce *adev)
>
>  static void dce_v8_0_audio_fini(struct amdgpu_device *adev)
>  {
> -       int i;
> -
>         if (!amdgpu_audio)
>                 return;
>
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v8_0_audio_enable(adev, &adev->mode_info.audio.pin[i]=
, false);
> -
>         adev->mode_info.audio.enabled =3D false;
>  }
>
> --
> 2.50.1
>
