Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BDBC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 15:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB0610E17A;
	Thu,  6 Mar 2025 15:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oy+XGMuW";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED0C910E17A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 15:21:13 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2fc92215d15so201200a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Mar 2025 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741274472; x=1741879272; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3URxZsGqFL5KUWU35j4XVG3HTinn5D1jyjUTkpC5Jg4=;
 b=Oy+XGMuWzw4sHmxmq92fmcYt6u7v2ozpIVK4ry7utyb09JZ9Uqu/ofFRHjToU6ao2A
 8cBE6ZgNOIcJMJ8LV//mUyxSuMp2HA5ThoIQaftgeUpxNO8fA6yT5ALSvntcIPCvvshw
 +iBrb9AEdBHSgZo5qhUQ+blx9EkSiE54gUFk5jxO16wKpvq7nrqQC06WP79IaQX++b3n
 h18WUidVQb31Px0wj4pn9/x1zhFxr559abkVBBwEc39Kj66aCRi8J/IbY54M2QZSkM/O
 h4lzY/n0FUAP35z+sEsWH4+2oeq0/RBFZEz+HWh7EJVDgeHrtwDMFKxy4/W8tkKTYHCa
 OATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741274472; x=1741879272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3URxZsGqFL5KUWU35j4XVG3HTinn5D1jyjUTkpC5Jg4=;
 b=I/ayy1lBuSiWmI95nQXEBcZDfDHjz3UVqNuZAfpNJaTCh6Cj9lvybspE2rtRRmErI8
 +Lo4dNvacLqVmNdaiZUcCHWQB3IUDESvKkNCY5lgaXUpsDBOikhUcV4cUo0I6b9Yd/as
 2VDbV9TPaxmDKLfFOMrIyImqPhzs/qfuLSwXEejYhZd0uYfN9EZZsbVScNYfvPfWxMm6
 0Daji27gQSMBdp/zIl4M7/pVdBImk0d018IjJ08CfJ4aJyECKSXNPB6LDMeA1297ctts
 FUjBGtI9ZFXgdwADmGF5MRvUTeEcFusKcA6TV/cEwr6CcJW8GVqAuX1KHhZ1rw5+uHyM
 0iPQ==
X-Gm-Message-State: AOJu0Yyaqq+hHx7EzxUgBNFR8gPCiuLlCAh44PEq25VU2Lvi+z3vEP/d
 EIGlDeUV5rvP+V7kui9Lq7uDXoQNr2Ht+bAylvpBC+XX557rCXvb3zTgkPfV5U9gTpzBvXalJ+3
 S1InOFwOTKr/DOh2WnDqVXsXMN0z1/A==
X-Gm-Gg: ASbGncsFLQQccgCcEbvQyA8Bbr5Gi/s72dOXaStXPvt+Mww08l0fZQmJkhV5l5FR+9i
 Ir9MG+UQV5v/6VGvIhwjkOQ4AhyeWbsDtSvR/gM8PobLalo4NnBtNz5bOwsdMB0BfH1H9GPYigc
 tUWy3n9sHA1SkMRZqozVaj3R/1lA==
X-Google-Smtp-Source: AGHT+IFf6HnmkGa131X6aoJQ2e0fJmfYNVC9zf5GZ0MlAzEqJsrg3zAxI3RGgnZhKISJSvf2lUyRJosq4/ilQr51FlI=
X-Received: by 2002:a17:90b:5202:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-2ff4b7af1dcmr1430497a91.3.1741274471726; Thu, 06 Mar 2025
 07:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20250306014958.785021-1-alexandre.f.demers@gmail.com>
 <20250306014958.785021-3-alexandre.f.demers@gmail.com>
In-Reply-To: <20250306014958.785021-3-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 10:20:59 -0500
X-Gm-Features: AQ5f1Jpk_3vLqFLeUwc7AYIC3ufZB-vccpF696TjkgZIx5svZ6w17OUs3_-hynQ
Message-ID: <CADnq5_NE4rXzF69y5ARSw8zEEd=eTgJyyao-4qfoSxarw=oYkg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/amdgpu: add defines for pin_offsets in DCE8
To: Alexandre Demers <alexandre.f.demers@gmail.com>
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

Applied.  Thanks.

On Wed, Mar 5, 2025 at 9:08=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Define pin_offsets values in the same way it is done in DCE8
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/cikd.h     |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 14 +++++++-------
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cikd.h b/drivers/gpu/drm/amd/amdg=
pu/cikd.h
> index 06088d52d81c..279288365940 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cikd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/cikd.h
> @@ -51,6 +51,15 @@
>  #define HPD4_REGISTER_OFFSET                 (0x1813 - 0x1807)
>  #define HPD5_REGISTER_OFFSET                 (0x1816 - 0x1807)
>
> +/* audio endpt instance offsets */
> +#define AUD0_REGISTER_OFFSET                 (0x1780 - 0x1780)
> +#define AUD1_REGISTER_OFFSET                 (0x1786 - 0x1780)
> +#define AUD2_REGISTER_OFFSET                 (0x178c - 0x1780)
> +#define AUD3_REGISTER_OFFSET                 (0x1792 - 0x1780)
> +#define AUD4_REGISTER_OFFSET                 (0x1798 - 0x1780)
> +#define AUD5_REGISTER_OFFSET                 (0x179d - 0x1780)
> +#define AUD6_REGISTER_OFFSET                 (0x17a4 - 0x1780)
> +
>  #define BONAIRE_GB_ADDR_CONFIG_GOLDEN        0x12010001
>  #define HAWAII_GB_ADDR_CONFIG_GOLDEN         0x12011003
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index 04b79ff87f75..5e657b43a159 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -1395,13 +1395,13 @@ static void dce_v8_0_audio_enable(struct amdgpu_d=
evice *adev,
>  }
>
>  static const u32 pin_offsets[7] =3D {
> -       (0x1780 - 0x1780),
> -       (0x1786 - 0x1780),
> -       (0x178c - 0x1780),
> -       (0x1792 - 0x1780),
> -       (0x1798 - 0x1780),
> -       (0x179d - 0x1780),
> -       (0x17a4 - 0x1780),
> +       AUD0_REGISTER_OFFSET,
> +       AUD1_REGISTER_OFFSET,
> +       AUD2_REGISTER_OFFSET,
> +       AUD3_REGISTER_OFFSET,
> +       AUD4_REGISTER_OFFSET,
> +       AUD5_REGISTER_OFFSET,
> +       AUD6_REGISTER_OFFSET,
>  };
>
>  static int dce_v8_0_audio_init(struct amdgpu_device *adev)
> --
> 2.48.1
>
