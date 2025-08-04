Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F2AC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 16:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1B2010E5A9;
	Mon,  4 Aug 2025 16:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GA9El5EM";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F03810E5AF
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 16:00:08 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-31ef3e9f0adso370747a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754323207; x=1754928007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gn+wyP2gZMhECxcWMr0bp9XbjqXUSh0w5yuYX9b/ZsE=;
 b=GA9El5EMH3CcaeRQxuBQLgR1ssOu05gyAcjZYdKmY9tCdZh559CyNx8JzIdOW9uF7j
 hrJH7b5Vh563cU12iGWZ46pu/nMfaSQOfJPXiXD39+GtDqOC8xQP6wLuS4Rfgwb9zOJJ
 F+Z6RjEyRUke/Xgs7wYWWwaRBP73tnwK73ExpcLOQaB83VgSasEJsCZMh1c7e61UMRtO
 kyPvGrjDo62FLpofBBs3Q7P9XRXeyrs9k8TezBD8t+y90XfO2yYKPCzUncEUcgCsloT2
 Rj7HRz2RFB6zHLb6GQnAR9n3KeLLfLb8ZeAkBmWX0cBZkLaLfy/90pulfE7kZbSG6WkI
 skLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323207; x=1754928007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gn+wyP2gZMhECxcWMr0bp9XbjqXUSh0w5yuYX9b/ZsE=;
 b=M3WEdcrT7lFAuxkFBZe5jNovRgaFPR92MdSF2GnYr+wQUT1X8Dafd0rO9Q2ver6oqQ
 Fb3XI9p5VMC43F3SIdONzwsurDiih+ipabqUbBmiabFIFFwh5wYUglLmf3ZlwfnH2Muy
 wbSs/e62B0x4MqRqTnUuTMEuVA6ktkSRGw/RTzuY5K9lB6BXO1aJHdRhj/MIvd9s7+92
 wIdinN6PBizMLdb2Yv0GvtWpDidMiBsFLjxRzMmX/QuRmsdBdkZbl/wXcNlqQUy3X+NV
 2acN9+1r9P4W0ID6+C9whveGBV4F/7itjeo21mlrOSxfR5xpHyEeWJndDt2rwYhtglt3
 dl/g==
X-Gm-Message-State: AOJu0YzIQnxrOsXNrmBid+6OnOr3mVa2gvOmqyyHYOVU+qaR2DrpCMli
 HIVEyFzDNlv1M3dc6TlWAyQUzN1g401YZbDPKlq1qA/Z8Awm3WjO4d/MR1Kd38N+PDsmg4FSUT9
 mPw5h2uRicU1kTeFIVVSiJMJ5HErewyQ=
X-Gm-Gg: ASbGncsbQ+j7PIoSjQRS2TG2ELP4Qhc6QZ+WXyT0zdJt/FaawuDIFvdm83DmdmXCBj8
 K7oL42zqZNWC+4Hu48FVDJCoRxmP4Dr/6I0tsUrX4Gz0u2ju3qYEwcuSq6hYIcn8gmz3sx5tB5M
 i7V4pbKIXFtFbFTge1f1fGUMM471bb2YqfLfGDvgDJHUGM8t+f2Yody9XoqJ4gfONUMysVPiYjZ
 lPoKaD0gld8TDgBIMU=
X-Google-Smtp-Source: AGHT+IHBWjznhnw3gFjmVKOSODS8SkS4vmjnPx1OnIuUr9iR1cENmiAbwLjlscNaiiExiW3W6a+FuTp1TRJaasvFswY=
X-Received: by 2002:a17:90b:38cf:b0:31f:23f0:2df8 with SMTP id
 98e67ed59e1d1-321162c7222mr4839966a91.6.1754323207460; Mon, 04 Aug 2025
 09:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-8-timur.kristof@gmail.com>
In-Reply-To: <20250731094352.29528-8-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:59:55 -0400
X-Gm-Features: Ac12FXxJme19djAfF-QF7n1jHWDE3FQg8r9bb_ktvXAgz00PdsE5s4tPrEW118E
Message-ID: <CADnq5_Oj_B=kPin_zJz-pzs6rgdpivEM7_CA2w36XxO1LGwJKA@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/amd/display: Fix fractional fb divider in
 set_pixel_clock_v3
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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

On Thu, Jul 31, 2025 at 5:53=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> For later VBIOS versions, the fractional feedback divider is
> calculated as the remainder of dividing the feedback divider by
> a factor, which is set to 1000000. For reference, see:
> - calculate_fb_and_fractional_fb_divider
> - calc_pll_max_vco_construct
>
> However, in case of old VBIOS versions that have
> set_pixel_clock_v3, they only have 1 byte available for the
> fractional feedback divider, and it's expected to be set to the
> remainder from dividing the feedback divider by 10.
> For reference see the legacy display code:
> - amdgpu_pll_compute
> - amdgpu_atombios_crtc_program_pll
>
> This commit fixes set_pixel_clock_v3 by dividing the fractional
> feedback divider passed to the function by 100000.
>
> Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/bios/command_table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/driver=
s/gpu/drm/amd/display/dc/bios/command_table.c
> index 2bcae0643e61..58e88778da7f 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> @@ -993,7 +993,7 @@ static enum bp_result set_pixel_clock_v3(
>         allocation.sPCLKInput.usFbDiv =3D
>                         cpu_to_le16((uint16_t)bp_params->feedback_divider=
);
>         allocation.sPCLKInput.ucFracFbDiv =3D
> -                       (uint8_t)bp_params->fractional_feedback_divider;
> +                       (uint8_t)(bp_params->fractional_feedback_divider =
/ 100000);
>         allocation.sPCLKInput.ucPostDiv =3D
>                         (uint8_t)bp_params->pixel_clock_post_divider;
>
> --
> 2.50.1
>
