Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C248D609AB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 15:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50FA10E765;
	Tue, 16 Dec 2025 15:23:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UnXxUdLf";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 316ED10E765
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 15:23:31 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7ba92341f07so336190b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 07:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765898611; x=1766503411; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XR+t369wv+bas3M67ipIVWAfRtYwhPjKxcM9mAwtnUw=;
 b=UnXxUdLfHOIuaNqs47+wgK8aqot6Q/boVrqbF7fYrQpI94O7emXJiAkWFUkPO18ObZ
 aLZ1NpxbEs4jSzrG1jmFNvw/aOL1WfAJp/zorsC7Gw0ceN9JhgMIlFzh7e1Y1VupCH18
 4vp4qBvJz6+arLESp9A9UqTseo6o0gpeNZ16p1S0GjHgszMON7PSwW+ZpkB4v8zJiVB2
 F/utyIzq9tDc1RJ0w1ndL6B9pPMJBhiUKcP9KTr+pIELaaM+nxI0o4rvaD4UZ3YJB0At
 bgApTJKrvliA3AbSpfHqe+uii6i1seoSCSTBsLpgJ9e2tVzMi94b6tXkp9QPappKtMdr
 DDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765898611; x=1766503411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XR+t369wv+bas3M67ipIVWAfRtYwhPjKxcM9mAwtnUw=;
 b=oNjPnhmY9MFt7Io+Nqoek+1z8abXUZRKbWGbhJmRTE0iCGIxY/n+9SDdT0ciNi4IJ9
 vEcGOHJF1/PBXVQ2oJxS3u2y6ZRGJtmj8LLSRw8xufWov2Gv58eg1Akn38TkExm3KuEL
 +c+Gyf8e7tLQDnCKom0ozalyURC7llc+vfe0jHrbwAdYsxSG+/nN/lOimzNY9uGLrrKH
 v8eJEuPrNoOfjRSwGLKcafDFATXlto/LhraH8U3npfjfLCTnApAxI/XT5N9+nrjS8rve
 zBFFT0XKxBGddvIip8g096OmxWOILgr7vvdfOGG8MbNJrvSbHegq3KrvY1mGPZmrvo0V
 Wd/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBHCaMjauDZZECal3JPPX2rkgVjTnQoKd3A4c/i7ndx2ilETUkZ9ujiFd9xutaayzVIR/J7PvN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlXmRSRxPekkASq9gz/+nOaxbn/2Bm19s+8pLM1Q5bfe1OKyPJ
 HETxcHWRLBzIGTFVqsEFzjPkAGIzMO7a9enP+65yAOvoztTlB+78505rkdROfJffHojM58TMGzu
 MYCVKVyJiWyJ87RNXAzn/G7xBnuTPE+k=
X-Gm-Gg: AY/fxX4EvTfoUSZ6qsbaOtyex0h2J98Kv3DJ08YrEGrUzPRzgUDWJAHXhokmRio4NfI
 pL3od6VBvZjyMhbMiwl+i3Jfr4TTWHfcB+EmKUH9QswuV45Nd/O+2y78Nysg4PwfqvJMSn8mSmK
 wrrbAlm1vOY8ayXx+lnYYriGKePW6ItZLud2gyDd0hqmkffZfUv99d/QyVNpZUoZvccls5z9ByV
 85NHXxCLPETMP9kDbwzOmgDIoqMh4memg8HFyT8eExTjMb3ILsvRSX3CjgBFL+3uKdkwAge
X-Google-Smtp-Source: AGHT+IFdzuCoHjPEOwY52cy6vSKFW7QA40hHd4WfrvQRRPvroBHT2Yyi/Jbe/QP0xNlYctFf88OiJIVTRV1RKQmmjTQ=
X-Received: by 2002:a05:7022:e1c:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-11f34c47b8cmr6828951c88.4.1765898610527; Tue, 16 Dec 2025
 07:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20251209231107.1968472-1-tomasz.pakula.oficjalny@gmail.com>
In-Reply-To: <20251209231107.1968472-1-tomasz.pakula.oficjalny@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 10:23:18 -0500
X-Gm-Features: AQt7F2phVx4TD_H9eREZQpgS9-LiVwlra0nNWZzCY7J0G8DDRmiFp1kek07smh4
Message-ID: <CADnq5_PV-Ya3bviUowEw79ipLEfSp+m-ErBoj6uU9exOSNQeHA@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: Add CH7218 PCON to the VRR whitelist
To: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
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

+ Harry, Leo

On Wed, Dec 10, 2025 at 4:24=E2=80=AFAM Tomasz Paku=C5=82a
<tomasz.pakula.oficjalny@gmail.com> wrote:
>
> From: Tomasz Paku=C5=82a <forest10pl@gmail.com>
>
> Chrontel CH7218 found in Ugreen DP -> HDMI 2.1 adapter (model 85564)
> works perfectly with VRR after testing. VRR and FreeSync compatibility
> is explicitly advertised as a feature so it's addition is a formality.
>
> Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
>  drivers/gpu/drm/amd/display/include/ddc_service_types.h   | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index d0f770dd0a95..f01f30a245ad 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -1374,6 +1374,7 @@ static bool dm_is_freesync_pcon_whitelist(const uin=
t32_t branch_dev_id)
>         case DP_BRANCH_DEVICE_ID_0060AD:
>         case DP_BRANCH_DEVICE_ID_00E04C:
>         case DP_BRANCH_DEVICE_ID_90CC24:
> +       case DP_BRANCH_DEVICE_ID_2B02F0:
>                 ret_val =3D true;
>                 break;
>         default:
> diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/dr=
ivers/gpu/drm/amd/display/include/ddc_service_types.h
> index 1c603b12957f..e838f7c1269c 100644
> --- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> +++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> @@ -36,6 +36,7 @@
>  #define DP_BRANCH_DEVICE_ID_006037 0x006037
>  #define DP_BRANCH_DEVICE_ID_001CF8 0x001CF8
>  #define DP_BRANCH_DEVICE_ID_0060AD 0x0060AD
> +#define DP_BRANCH_DEVICE_ID_2B02F0 0x2B02F0 /* Chrontel CH7218 */
>  #define DP_BRANCH_HW_REV_10 0x10
>  #define DP_BRANCH_HW_REV_20 0x20
>
> --
> 2.52.0
>
