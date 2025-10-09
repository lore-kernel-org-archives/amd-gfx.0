Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F78CCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 19:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 752AB10EB02;
	Thu,  9 Oct 2025 19:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="efiBOmj4";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D2E710EB02
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 19:30:45 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-776379289dcso74780b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760038245; x=1760643045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrEPr8z4joClefRtCxiVa1e9VUPxUm7GN9UTnFzGyFs=;
 b=efiBOmj4qEMFhTH1fka5ovZfc4ZTjPIjz0RppB1YIxqqe7+uABfejwz3SS6pAGMiYk
 KqBrFX4qMg5kanQDK4881bzFq90aVTSdbirahYnkNwTb9d32PHj9SHO0xWHERPIQmQbg
 7JBIQwTYIlqcffQ9stanFnZs6mnq1D28EkGUczFPymqCZtFK1n75DLeUys40z7LI46I4
 sPCJCVtifyGI3lc0BK4FquhZ7QCjUqhDwSLqiqYzFYvW7Sop6k5wHHtk+aGL5EPaNpIc
 8DKhKjtX4mMCWI0Z030/LdV5XrATh350r5pfc4x5ZsaAQ7ICkzDTamWdS1OvUpAP6Mho
 eEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760038245; x=1760643045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrEPr8z4joClefRtCxiVa1e9VUPxUm7GN9UTnFzGyFs=;
 b=jWf3hsOzJE38dPoyivGEbFKs4cwBWbI7lw8Y+H6H5qNXj567bYnxXGv8OLXpg65o+w
 3JC/wZ9vAPzBlqDfMiKCpOXsp5AYhIjbbb/D0o3sZ3kh0d8nr/0C4MlnZfdmG06YFcPi
 HeF5U0zXZOGy1EEA+DtBLpbrA8MbqFMw4X3GuPfb1PXv6XT6pIJMgF55PqAzzXmtemA6
 QvbJb1ob92SwbmIPFU+FUzd32aFgWmC78b4FLmA7ql/Pka7+QB4h0pLfN6KrhWQMDz0s
 SEgSc8fvSnND2FM06OpiZJF3/rk7SdmCrh/HwraxoM6P5i4mX3cYYYt+MsxN+GByEU3d
 cUCg==
X-Gm-Message-State: AOJu0YzgVW+sfuroGTnjJwJZR7AwDgfxm1gY5epIn+BOXr/Uc4R4PnAc
 SM6DSCHKI0NOCYObzjNTtiAHB1dmPp68LW0KKkCRcWtrMTu3J3JNxzDCcjM4IG9XJt1zDTu3PbU
 QXH9ola9m//8cIxfzKASeoRn3/vsnV94=
X-Gm-Gg: ASbGncs/n1botAZKvoOsDk+aUzn4urh9UP0VU3u4YNXyUAZUH1IW1Q3hPp9qvi02ipd
 guzdF1S3aCgFzmYQFOg/vhauXGQBc30fmufuTEjyyTrHQuwEV7jVkQLnmCS5fbPhgn1yhv8T0y8
 ASVE7Y0kAl5YhjXSshFO5JKRho9BZ1ZSVbOTrcCPRW6zN8cN481QD4FaHmShwRbp4XhVZqWulN3
 kmdLEPkUppMh2dZRRO3zGWv81b4cwE=
X-Google-Smtp-Source: AGHT+IEiiTykvoCX/TpQC+KDqQA+XbTkrEAlCnOmpTpbg2sRrGWdDUtj9RUk68NH5Oas/Qpait3y6V6g+o3BVbylqLQ=
X-Received: by 2002:a17:903:493:b0:27e:eee6:6df2 with SMTP id
 d9443c01a7336-2902743e52emr48059815ad.7.1760038244962; Thu, 09 Oct 2025
 12:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250926182614.26629-1-timur.kristof@gmail.com>
 <20250926182614.26629-2-timur.kristof@gmail.com>
In-Reply-To: <20250926182614.26629-2-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 15:30:31 -0400
X-Gm-Features: AS18NWCBDiXh4k-_bBa3F1OW9PtcxupGQrAGWri9uXfz9FuA2CgHqXK4G1aq3-I
Message-ID: <CADnq5_PbqxvK5uer3f4HhpnorykLw8SDqMfLSeDh1WJ95r1a5w@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amd/pm: Disable MCLK switching on SI at high
 pixel clocks
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 alex.hung@amd.com, harry.wentland@amd.com, siqueira@igalia.com, 
 christian.koenig@amd.com
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

On Fri, Sep 26, 2025 at 2:26=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On various SI GPUs, a flickering can be observed near the bottom
> edge of the screen when using a single 4K 60Hz monitor over DP.
> Disabling MCLK switching works around this problem.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index cf9932e68055..3a9522c17fee 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -3500,6 +3500,11 @@ static void si_apply_state_adjust_rules(struct amd=
gpu_device *adev,
>          * for these GPUs to calculate bandwidth requirements.
>          */
>         if (high_pixelclock_count) {
> +               /* Work around flickering lines at the bottom edge
> +                * of the screen when using a single 4K 60Hz monitor.
> +                */
> +               disable_mclk_switching =3D true;
> +
>                 /* On Oland, we observe some flickering when two 4K 60Hz
>                  * displays are connected, possibly because voltage is to=
o low.
>                  * Raise the voltage by requiring a higher SCLK.
> --
> 2.51.0
>
