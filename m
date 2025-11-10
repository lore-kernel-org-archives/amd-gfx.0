Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7A9CCF9E3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 18:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CAB110E2E5;
	Mon, 10 Nov 2025 18:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JfUdZfUQ";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528F410E2E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 18:34:45 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b6a42604093so314139a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 10:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762799685; x=1763404485; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROLslryezymzPMZ6PfLEI0gTUycqN4z9adPbZ8CNSyE=;
 b=JfUdZfUQxmFtr01cfwX0Per6W6tdOkLU2lKw38t526iKxo/06l40LCU2+BNGdkGjHm
 Iidi7V2vcCknV6BnBDV4gJl0Z8ucD2NkZVXAJbkpHfCGsdkMecviuStZV5bmHg27PnKl
 cgpDU7wj3WKrNNK5oehnGSIxge+AcHPtAk5Es18x+9TBiXJhA4cJDdWPCy61vpWdChUL
 5XqxG2D7N0coGnDaoSrV7GKXkNx0CODDCF4TQInt7r1gC40PWgPa72LmuOy/TgAxypsC
 3lULPuzkOM7VJwMms0rBBlqdASgQ4ZsToRgG+W7rOTR9VOMIl9vwkLqx/eJ9vBdLJV19
 hkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762799685; x=1763404485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ROLslryezymzPMZ6PfLEI0gTUycqN4z9adPbZ8CNSyE=;
 b=X/wzGE5MlvkwDAHW2Zw7dhTkZxvcW9Jg9GjJtszdGvLKGb5s8TnlDLzIqwnskG1/bO
 +lXE1Up1zjKYYJTVxIVletPlgzH706XR0G75h7rCPKDZ3HYRjJ/flRSK/XX/CuymGEf1
 SaAUb5jTAcxqat4uAJh/VWO3JJCmrM7DnLr8xVq/W/98sQ067IpzT51nloO1GFT8VyeF
 d69T3ZZ6svKgIe/kxU0q/ktIunTM3l3fFRsqokQBSFLaH4iiykfHRs8y3pvrfRYuQn9z
 VsorWmaEScQB6zaBbL4qYONWugka4yF8j7LpNR8Jh3SLrWVnOa+DoGjkkcKozi5W2ft8
 NUoA==
X-Gm-Message-State: AOJu0YzlEU+JsGSzmT+3K2dAcHxcMdNDbT1zPvteaCO2rgEeTdXglf1/
 TfuiUbNuE+s+9EKY0OwUyRGkcC2f0Wryq6nEiRDXHjDBvB2uWXkt7VTinnJohy1Q4MTaaOCWME0
 M90K82XU96W+OQJoqwgQeructK/GIfIc=
X-Gm-Gg: ASbGnctyxrhrBBUlG7nSocjqBjzZuvu+6RmIAVn6JkWBJf4lFcotqqRdMeGQSkVFXi4
 iQMcT3GIebnNOWuXd1d67BkRAO2gVbQF/HSXQ+UN3nMlzJqaaiFfEsvpnfMhfpP2NHbBBGdeNrh
 vzhi/i7U4EgLIQQjd6hB45AKkwsH+FCMJ9/KVJwc7Fig0zz70COimNu73SUkEDFHhK0HKlv6IbL
 wzvs0XJ0jbTeqdgndvN1Q/qq8gdYs1MdpOEVYkOGozNHtysRKcMI2wt4Akw
X-Google-Smtp-Source: AGHT+IFtIf7AN36n+AKEXXl4TovI+E1Up+/HeQcTT8Mw8GaVzvHWC1Ok3RcqzHKyqLnr2puoEj0AQlai/UimKfveMf8=
X-Received: by 2002:a17:902:f0d5:b0:297:deff:aebb with SMTP id
 d9443c01a7336-297e5749a93mr44112445ad.11.1762799684620; Mon, 10 Nov 2025
 10:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20251109182640.58237-1-timur.kristof@gmail.com>
In-Reply-To: <20251109182640.58237-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Nov 2025 13:34:32 -0500
X-Gm-Features: AWmQ_bkLndLfkfvtpl-WTFDXnUjqQvTJdW8XmlLSfrujatP-A9DmIjqBrugZ1cw
Message-ID: <CADnq5_Pw6hbc=Aa++51Wah-kCfT1k_CULxB8AaQ8Fam=T3XFbg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use DC by default on SI dGPUs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
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

Applied.  Thanks!

On Sun, Nov 9, 2025 at 1:26=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> Now that DC supports analog connectors, it has reached feature
> parity with the legacy non-DC display driver on SI dGPUs.
> Use the DC display driver by default on SI dGPUs, unless it is
> explicitly disabled using the amdgpu.dc=3D0 module parameter.
>
> DC brings proper support for DP/HDMI audio, DP MST,
> 10-bit colors, some HDR features, atomic modesetting, etc.
>
> Also clarify the comment about what is missing to have full
> DC support for CIK APUs.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 1e8725abcded..860ac1f9e35d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4249,24 +4249,13 @@ bool amdgpu_device_asic_has_dc_support(struct pci=
_dev *pdev,
>         case CHIP_PITCAIRN:
>         case CHIP_VERDE:
>         case CHIP_OLAND:
> -               /*
> -                * We have systems in the wild with these ASICs that requ=
ire
> -                * LVDS and VGA support which is not supported with DC.
> -                *
> -                * Fallback to the non-DC driver here by default so as no=
t to
> -                * cause regressions.
> -                */
> -#if defined(CONFIG_DRM_AMD_DC_SI)
> -               return amdgpu_dc > 0;
> -#else
> -               return false;
> -#endif
> +               return amdgpu_dc !=3D 0 && IS_ENABLED(CONFIG_DRM_AMD_DC_S=
I);
>         case CHIP_KAVERI:
>         case CHIP_KABINI:
>         case CHIP_MULLINS:
>                 /*
>                  * We have systems in the wild with these ASICs that requ=
ire
> -                * VGA support which is not supported with DC.
> +                * TRAVIS and NUTMEG support which is not supported with =
DC.
>                  *
>                  * Fallback to the non-DC driver here by default so as no=
t to
>                  * cause regressions.
> --
> 2.51.1
>
