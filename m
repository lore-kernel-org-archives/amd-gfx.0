Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1819BCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 14:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862BA10E751;
	Tue,  2 Sep 2025 14:27:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FREWXA5u";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA3FE10E751
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 14:27:57 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b4c2630ae12so171579a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756823277; x=1757428077; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgp3IjrVvFw0VnCquGpM33r52XGksV+6ZG4k/lx7b7M=;
 b=FREWXA5u3g4FHkE7KP2d/HFgRoNydY0KB9idQnOsDuAyfF4gU2twpfwrlQ6OaFJ8Uy
 69ngApHRtdJqaA+lAxDNSWuHgtaWv1o5mU2U3ywbDfYsuD5S59GgN0guYHux3nxe5vuy
 Z6QdnB2O5n3ZQ6GNZ+3rwQpYri1s+BS+w8iI1brKfvSx5zJ+mFWLdTV6rcD/OQlYC6ME
 lXrbgV0dG42XwjTIyTu0dd+9KCcaw2NsWGjQcldoz/n6FPCdwPAY2rFOWWX0e1DmAEp3
 t5znylQMBDGpSyfvIgUoa1cq/GcAJ6ZB6WWpRY6PSh+Y+GxXDyHFktPFfxYUziAkNacj
 X7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756823277; x=1757428077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zgp3IjrVvFw0VnCquGpM33r52XGksV+6ZG4k/lx7b7M=;
 b=f2rCIghkve2FH30dPpX30ubj0NGKZyZyXI/AlE4KC5sCE+fRmVzmOVOsmF7Box5p5H
 V9otNRRisBwB5xcfSqFyHAJMnZ46QjyxyGWM7QH8D8TZuyoTlZq5h9jNm45zoljrHgeq
 3exIwXqXtN/BE0ZXFHWHJvFK16O27yirFnufzUEj4D5bBq8hIxYeWo2hPseGVaRJmvXM
 nRUO048w2zGinv5x3XPm+kUp6GIwEZ3be0XC02RQbgSBnQmxrZZruAyyB0QBCXTJIE+x
 yGw8R8FnQZRFgZslucJ1rjeQFXtNl50Tg4yMUx72a7PHLZuWvP1HBHX2RRrGA8WzOC07
 Xk2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuEBJ2hssxJQJobE53MFPErJSFZ8Q5lST6S+lylbGpWsTQPTkScynApMI50cRa0yyKabWmLMoH@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyk2RyeaVdmcdRM/oHztjc/v/a6O7fftaIhDLJNuCAKiutp627A
 dVS8+I6AQ/dK+B6IuxjT18THq/VXq4R+aNd+41hAOL7/SPAFCd23Nova4NRvbnWyT4lWF1C79UI
 SZ0adrfXM4KRCwJEhF/3/fjlxuMDdY/Q=
X-Gm-Gg: ASbGncsd0Ak26M+dQqGwgYtF7Zy6PKWxtDA2eXuzn5uaYhcmEirIdEvpVWUma3pyfv2
 8iuKt6bd30M4y8LzVxu+ZdrpryXQfz8SWC1g8pNWz1QD+O097ltOuPjPqbb8pFn43tf5HvcpIuB
 Razy84w7sGesspNEloofYXQukbprBlhto0s6YwRQ2d3d6qkkcyVKirCx1cVa2GKNiiGJaYvkTHV
 UcgUu75ZHcQDH/M2w==
X-Google-Smtp-Source: AGHT+IFYMGmzME4JjnXcZGO842UqBL8ssUEpu/2NDP2gMEyDUdv7L7u0Gb0m71/tejOwC9ChhkUX1d8EN608Rtb72Xg=
X-Received: by 2002:a17:902:ea0e:b0:246:a152:2afc with SMTP id
 d9443c01a7336-2490f6e2a41mr119882375ad.3.1756823277403; Tue, 02 Sep 2025
 07:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250831100245.400199-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250831100245.400199-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Sep 2025 10:27:44 -0400
X-Gm-Features: Ac12FXx6oqi60ptrmmCPxNmEXemUxXDSnQcxlYQAwU5PShRwlF_r8KR4bopVtEs
Message-ID: <CADnq5_NrFh5Tk2=GGZqv-yOe1Yz3_cJq6AxY3vyKe4Jpo9=SWw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix function header names in
 amdgpu_connectors.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Sun, Aug 31, 2025 at 6:13=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Align the function headers for `amdgpu_max_hdmi_pixel_clock` and
> `amdgpu_connector_dvi_mode_valid` with the function implementations so
> they match the expected kdoc style.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:1199: warning: This commen=
t starts with '/**', but isn't a kernel-doc comment. Refer Documentation/do=
c-guide/kernel-doc.rst
>  * Returns the maximum supported HDMI (TMDS) pixel clock in KHz.
> drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:1212: warning: This commen=
t starts with '/**', but isn't a kernel-doc comment. Refer Documentation/do=
c-guide/kernel-doc.rst
>  * Validates the given display mode on DVI and HDMI connectors.
>
> Fixes: b80998750589 ("drm/amdgpu: Respect max pixel clock for HDMI and DV=
I-D (v2)")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_connectors.c
> index a381de8648e5..bf38fc69c1cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -1196,7 +1196,10 @@ static void amdgpu_connector_dvi_force(struct drm_=
connector *connector)
>  }
>
>  /**
> - * Returns the maximum supported HDMI (TMDS) pixel clock in KHz.
> + * amdgpu_max_hdmi_pixel_clock - Return max supported HDMI (TMDS) pixel =
clock
> + * @adev: pointer to amdgpu_device
> + *
> + * Return: maximum supported HDMI (TMDS) pixel clock in KHz.
>   */
>  static int amdgpu_max_hdmi_pixel_clock(const struct amdgpu_device *adev)
>  {
> @@ -1209,8 +1212,14 @@ static int amdgpu_max_hdmi_pixel_clock(const struc=
t amdgpu_device *adev)
>  }
>
>  /**
> - * Validates the given display mode on DVI and HDMI connectors,
> - * including analog signals on DVI-I.
> + * amdgpu_connector_dvi_mode_valid - Validate a mode on DVI/HDMI connect=
ors
> + * @connector: DRM connector to validate the mode on
> + * @mode: display mode to validate
> + *
> + * Validate the given display mode on DVI and HDMI connectors, including
> + * analog signals on DVI-I.
> + *
> + * Return: drm_mode_status indicating whether the mode is valid.
>   */
>  static enum drm_mode_status amdgpu_connector_dvi_mode_valid(struct drm_c=
onnector *connector,
>                                             const struct drm_display_mode=
 *mode)
> --
> 2.34.1
>
