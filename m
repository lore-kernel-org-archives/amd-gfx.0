Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13089C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 19:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A918210E4C9;
	Mon, 24 Mar 2025 19:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A0kPEqIk";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097B710E4C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 19:48:29 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3032a9c7cfeso846808a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 12:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742845708; x=1743450508; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xj5zCFXJqAlBaBpz6CFSrQponWXxjC1PRlTxdyToEM=;
 b=A0kPEqIkiwcHcFtbVbLZ2sGe6UGTI5O0c51bn+1G2XJTNaJAlFYQ0A0aQZA6cNUptR
 iDSF5sw779J779kz1FjSxfZI16O5ZtE/hyywwNq2I2ZSdxUDAXOEZfWOEG5/wLqjEz5L
 69dPZyfh1gu27HAtXyIx19YkDZHM5rhmMZFGIQNHKriZZI/0H2kexsPS3bkCqd/ceaWm
 l6rJ9lXYxavzwXbXAUkiUSGYjQBfSAJreql5oKYIZgS95f2pT4GpJaO3GN1UOZ3bzXcb
 wQOewHiWpwBqox6WgczK1CRx4pxApVJjGLtveUPa5/htEDTAho0xGW4/8mjoyWp7VXg7
 MBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742845708; x=1743450508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5xj5zCFXJqAlBaBpz6CFSrQponWXxjC1PRlTxdyToEM=;
 b=wqVzvTftdL+r9LdR+vLphOkD2rXAlZ0aBGle0PY9hmJxY+E6hGsf1kRJk8ZVdKxaPB
 iFA7RrpIVyjTikpGHzAsNE1DtLjGTwIOpizdbmohxi99cT1Z1fZkVglHKKi1CZKWxzu0
 NoerP7v4hkLVQFSufWTeqrX3O7NWztsgA4es83TvTgDHM3yodxrxOWhrhoWpXjndF5bR
 boboiJl/ICTn270w/hVZrq8k3U2TrUpYY8vXdQok+WVCeXTqnmSrX42swyFMtI2/djx6
 gzIGs+HVULXN9e72nnbh5oatLcklbekmiAueTBwoA4iW2WTi4cn9vUNo0DcXaxXhZtW1
 BRlA==
X-Gm-Message-State: AOJu0Yw7Ynrlf6P6lrVtIkkDAPFpA3amXyaTrnTQxj3xrCY1KEeblNQ2
 7tDjUdn+ghGbrxqWyp2Iaz9yens4mI4MLAWPZQiyPuplQfCisux1yuFDNue4ZHb5tbEyk35UZX7
 mLIkUN/ogPpi8PgWRm0nSG9Cov9TT0w==
X-Gm-Gg: ASbGncsLOKb1gzXQkZOFbXT7O16Y4jMdy6MK4Rjo1idzkWhwFA9onJGu+DLjpQ/qnH6
 GjFaKn0NK/CjJ6EmapWh0QxtnefzchcLS8ZHhr6HFcEM2drdmeUGp2m1BaahHTzOKnpN/KobCc7
 90apArvrTzIBjfy8wLV30lS5eiuTzMiynCaxmC
X-Google-Smtp-Source: AGHT+IGL50/2HNOBZyUc8WLlxJxGK88ZNRJ/h7Zt5YksoBLKrwN/56Qu9AVeK0xQrMiOjawhNoJ7rNbWPEIJxe9TKfA=
X-Received: by 2002:a17:90b:3a8d:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-3036b4abf73mr138506a91.5.1742845708313; Mon, 24 Mar 2025
 12:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250320203549.1345822-1-alexander.deucher@amd.com>
In-Reply-To: <20250320203549.1345822-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 15:48:15 -0400
X-Gm-Features: AQ5f1JoNMOa86fZ9rQ4TnnUHbaSKGkligtjKsBaT-1l07rCwFRrZrk88GGVFWH0
Message-ID: <CADnq5_O_hotchYfpWvcatLTL6_s1YJD2qBwL5yqvXkhDQ2+swg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx: make amdgpu_gfx_me_queue_to_bit()
 static
To: Alex Deucher <alexander.deucher@amd.com>
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

ping on this series?

On Thu, Mar 20, 2025 at 4:36=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> It's not used outside of amdgpu_gfx.c.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 72af5e5a894a2..04982b7f33a8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -74,8 +74,8 @@ bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_devi=
ce *adev,
>                         adev->gfx.mec_bitmap[xcc_id].queue_bitmap);
>  }
>
> -int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev,
> -                              int me, int pipe, int queue)
> +static int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev,
> +                                     int me, int pipe, int queue)
>  {
>         int bit =3D 0;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 75af4f25a133b..319e6e547c734 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -551,8 +551,6 @@ bool amdgpu_gfx_is_high_priority_compute_queue(struct=
 amdgpu_device *adev,
>                                                struct amdgpu_ring *ring);
>  bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *ad=
ev,
>                                                 struct amdgpu_ring *ring)=
;
> -int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
> -                              int pipe, int queue);
>  bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
>                                     int pipe, int queue);
>  void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
> --
> 2.49.0
>
