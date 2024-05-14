Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB2AC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 21:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E341810E0AA;
	Tue, 14 May 2024 21:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M1Ruj8cm";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7014210E0AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 21:30:17 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2b43490e0e2so4146653a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 14:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715722216; x=1716327016; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JB+Uw2jJXtgRuMB+0OfSZrniItkRTv4oBN++5fs1tp4=;
 b=M1Ruj8cma+4teQWHhUDJ5J3lnOdIHt0irNm+/wy/DAjWeM98qJOuOWLb9rb4USHOaf
 4xpjHmXbEjnvydt6JDpLZ/IX31rVDwJwiQj4Dh/T+fzfh9IcG4aPBPZ1M2t4pNPCVw3F
 K79bszv9RXv6iG0nMxy963UJAfeR7KYwy8sDr+EkpdoKJpgI+K37m1DVUG0pcVksA0W/
 z3YEOGD2yvwzWV2eDYTC1O8tRlMdRjDe539kvvU/QOuJhdSU/RpnoOyDp54kimwoAqxK
 kPQ6rQfsQffX3eAuXPpFfBG/od7ckQ5v65hgyM2ZWxQj7OI7nJP9lMHhX1tveQfzvys0
 A07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715722216; x=1716327016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JB+Uw2jJXtgRuMB+0OfSZrniItkRTv4oBN++5fs1tp4=;
 b=P+9Ur15C+U2wJRgEv25g5B+0D4qSF2CXX9Xbc+wfKv+5wMENC6AXGTsci8T7ag6PBx
 hSRubVK7BCiTTIy2XXbdqDTJFA77q0Ry03cGJw82KPc5XCdq4hHRdUtz4rcey8webqHf
 GTam85vjrA3nV4u6TNsB7ToJDf7HW84gtKUaNnu0jk/9Sx3jTCJuU17lUj5gQDGcNFqC
 bCSdusWlDBd5gLuKCaW4kvzI/JSASOD1lXaSWryHlfQF+BIfR3UDh+jQtfTLO98igTp7
 cEPCZk+94MIkHbzrZwx0ZPqdFa9eeqWQGXbv5AnkNIgnzi8730GYM485OB3j9R/Aiz7e
 nKuQ==
X-Gm-Message-State: AOJu0YwS/L6spiyYkJLdI5KrHXABn7R7TWUyppnGzToSRnYowtbOEYjR
 uLGXlIXUJs0iQTAEHXB2sOQRW1NvUtn8hFODIgrcINhETa2y5sHrrNjQrDVinztGZIFD2ey5Tuh
 YaAmEVbDPGcejsk0WOrahsrrSCJQ=
X-Google-Smtp-Source: AGHT+IGdoziOrvlRFFPonJ8n/XyxCUXOEC478Fl7+G7+69F+LztNhogNRJghUf3Uvzo4aHcSlj+Co9MlbCxiwGV9jO0=
X-Received: by 2002:a17:90b:2cd0:b0:2ae:e1e0:3d8f with SMTP id
 98e67ed59e1d1-2b6cc144333mr11146569a91.2.1715722216422; Tue, 14 May 2024
 14:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240514204714.1230427-1-alexander.deucher@amd.com>
In-Reply-To: <20240514204714.1230427-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 May 2024 17:30:04 -0400
Message-ID: <CADnq5_OH6ezhLLcGKzVhdRoQQrsJGXhkw_=eZ+F9MVed13eohA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix Kconfig for ISP
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Pratap Nirujogi <pratap.nirujogi@amd.com>
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

Ignore this.  Better, functional patch sent out.

Alex

On Tue, May 14, 2024 at 5:12=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Add new config option and set proper dependencies for ISP.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig  |  1 +
>  drivers/gpu/drm/amd/amdgpu/Makefile |  2 ++
>  drivers/gpu/drm/amd/isp/Kconfig     | 17 +++++++++++++++++
>  3 files changed, 20 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/isp/Kconfig
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amd=
gpu/Kconfig
> index 22d88f8ef5279..aa037ac7ef24f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -83,3 +83,4 @@ config DRM_AMDGPU_WERROR
>  source "drivers/gpu/drm/amd/acp/Kconfig"
>  source "drivers/gpu/drm/amd/display/Kconfig"
>  source "drivers/gpu/drm/amd/amdkfd/Kconfig"
> +source "drivers/gpu/drm/amd/isp/Kconfig"
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 12ba76025cb7c..c95ec19a38264 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -325,6 +325,8 @@ amdgpu-y +=3D $(AMD_DISPLAY_FILES)
>  endif
>
>  # add isp block
> +ifneq ($(CONFIG_DRM_AMD_ISP),)
>  amdgpu-y +=3D amdgpu_isp.o
> +endif
>
>  obj-$(CONFIG_DRM_AMDGPU)+=3D amdgpu.o
> diff --git a/drivers/gpu/drm/amd/isp/Kconfig b/drivers/gpu/drm/amd/isp/Kc=
onfig
> new file mode 100644
> index 0000000000000..afa3579901009
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/isp/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: MIT
> +menu "ISP (Image Signal Processor) Configuration"
> +       depends on DRM_AMDGPU
> +
> +config DRM_AMD_ISP
> +       bool "Enable AMD Image Signal Processor IP support"
> +       depends on DRM_AMDGPU
> +       select MFD_CORE
> +       select PM_GENERIC_DOMAINS if PM
> +       help
> +       Choose this option to enable ISP IP support for AMD SOCs.
> +       This adds the ISP (Image Signal Processor) IP driver and wires
> +       it up into the amdgpu driver.  The ACP block provides the DMA
> +       engine for the V4L mipi driver. It is required for camera
> +       on APUs which utilize a mipi camera.
> +
> +endmenu
> --
> 2.45.0
>
