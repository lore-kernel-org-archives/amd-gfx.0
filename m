Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F396C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 23:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F7F10E0CD;
	Fri, 14 Feb 2025 23:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZwpgwzGo";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65AB310E0CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 23:27:03 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2fc29ac55b5so328093a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739575623; x=1740180423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFzSHm9eoEhtoxQNqPwszvlIslybTi8OxJYunJkNKpA=;
 b=ZwpgwzGofN4Krrj4pBf6YD2BsveDNhZLf1b1OLcz8HOL38ohXR56+xTmaQOIDC2vl2
 lzpVhhmV7VwP0zUtvchW/avqemslbtlqOtdBbrnLHM0ZiS9tFDMvZELDl0JCpgkTj4tJ
 56oZSIka7CenO9eQtiCQzGtPdkLCuZOyEmnBwYXdyMmFR1w5bKrjv9yuNDw8xEl3h/1x
 IyAUztdywjqBAnkmqSR9TnvFYhI1OS3b29KXt5sXepu6LuvBULoZjpwoN3SD1UVi+u/p
 1T0EyPTs7QjyhFtc7U9mHxoug48XXvpvm6zDjKQd6N5UQ6VyQt3VLwDG6QuXA6MXs8Ic
 9YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739575623; x=1740180423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFzSHm9eoEhtoxQNqPwszvlIslybTi8OxJYunJkNKpA=;
 b=cSwQz6wNTAHpoeKAVtZ2hEdOH4siXsxysLLOzEfpsvUBzGkbSzcQ/TvWQBCGLbS4Ye
 gzgb+a3RjqiTuQasEJhDuxhrWemWPDktH9c4lgWbyWRD6GaNbxdYgSzT9NYHDARaU06J
 uKN9DCePBjQxMZhqKsiIwb6Yh2mbRJGVryIQO1V5FX15EZ4exuA3l9ne8fZ4tylIRirk
 4PFsXNqHSY2BQ0AZ/5EcW3L0/qKsPWeBPE4cCYtNBuzP9qsFAy3w7JOVFsLHCxTy5Gsw
 /C/gHszdnSEfTSN+HhmKlI9EfqlWUjxN2V54KC4uVfFCiBrJB21m1i0v4P7aAwpEm4vE
 7o2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0a07ie8HjMJ/axdvE0KRaes02rpbyx8n49qKNFNkqLqDCp59djJi8FXyDWiYQPKvmdW9oS9BO@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxe0j5ht4iFWLTX9amLAlCF7GTjGFksWTqVMwGU+lCm7wUn+t65
 TpHB9BEpgrcyCIFSlRa6JdIJrTaTlea7TlK+U0Wzwld+VO1uRzPEm2VqnPY8ELXtvlbsr0SNBH9
 B8bKGzXHQc3w0+WCFF0GBwQDfat0=
X-Gm-Gg: ASbGncsOB4F0rR/q7kozx4AEVN2XBmVxJ7sUNyUN5tJ3QoTbzcLyuL6h1DhLAmtm5zv
 VINLRlZIIsxfQz09Rp36G6XUx7PShwSUIxhLRnnUA+ditFhNINYqH0Ok85gPe33lajYxaTXqa
X-Google-Smtp-Source: AGHT+IEsmyFl9902Sw64uSHGmFMugCDjef098RzrQDd2x9CwbfePTG9SHWWNkAjXSFsIjegulfSfvV2O0JSkhBQ1Aig=
X-Received: by 2002:a17:90b:1e05:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-2fc407909c6mr551323a91.0.1739575622822; Fri, 14 Feb 2025
 15:27:02 -0800 (PST)
MIME-Version: 1.0
References: <20250214230011.439163-1-siqueira@igalia.com>
In-Reply-To: <20250214230011.439163-1-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Feb 2025 18:26:51 -0500
X-Gm-Features: AWEUYZm_3C3ScBYYXalbDOFMjEEr48IkWl1qEVpoAcaoFrbVzDXbMp8gF3DNTbE
Message-ID: <CADnq5_P0BX1VT6F1Bo6Zip+9fsV98Y=XVQDpv-B3NeOKNnDX7w@mail.gmail.com>
Subject: Re: [PATCH] Documentation/gpu: Add acronyms for some firmware
 components
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 kernel-dev@igalia.com, Mario Limonciello <mario.limonciello@amd.com>
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

On Fri, Feb 14, 2025 at 6:00=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> Users can check the file "/sys/kernel/debug/dri/0/amdgpu_firmware_info"
> to get information on the firmware loaded in the system. This file has
> multiple acronyms that are not documented in the glossary. This commit
> introduces some missing acronyms to the AMD glossary documentation. The
> meaning of each acronym in this commit was extracted from code
> documentation available in the following files:
>
> - drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> - drivers/gpu/drm/amd/include/amd_shared.h
>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation=
/gpu/amdgpu/amdgpu-glossary.rst
> index 00a47ebb0b0f..3242db32b020 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -12,6 +12,9 @@ we have a dedicated glossary for Display Core at
>        The number of CUs that are active on the system.  The number of ac=
tive
>        CUs may be less than SE * SH * CU depending on the board configura=
tion.
>
> +    CE
> +      Constant Engine
> +
>      CP
>        Command Processor
>
> @@ -80,6 +83,9 @@ we have a dedicated glossary for Display Core at
>      KIQ
>        Kernel Interface Queue
>
> +    ME
> +      Micro Engine

This is part of Graphics so maybe something like:

ME
    MicroEngine (Graphics)

> +
>      MEC
>        MicroEngine Compute
>
> @@ -92,6 +98,9 @@ we have a dedicated glossary for Display Core at
>      MQD
>        Memory Queue Descriptor
>
> +    PFP
> +      Pre-Fetch Parser

This is also part of GFX.

PFP
Pre-Fetch Parser (Graphics)

> +
>      PPLib
>        PowerPlay Library - PowerPlay is the power management component.
>
> @@ -110,14 +119,26 @@ we have a dedicated glossary for Display Core at
>      SH
>        SHader array
>
> +    SMC
> +      System Management Controller
> +
>      SMU
>        System Management Unit

These two are synonyms.

How about
SMU / SMC
System Management Unit / System Management Controller

Other than that, looks good.

Alex

>
>      SS
>        Spread Spectrum
>
> +    TA
> +      Trusted Application
> +
> +    UVD
> +      Unified Video Decoder
> +
>      VCE
>        Video Compression Engine
>
>      VCN
>        Video Codec Next
> +
> +    VPE
> +      Video Processing Engine
> --
> 2.48.1
>
