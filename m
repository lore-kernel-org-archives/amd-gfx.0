Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B59C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 19:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBCC10E362;
	Wed, 19 Feb 2025 19:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mTN5EnYV";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B65010E362
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 19:23:13 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2fc8482c62dso31765a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 11:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739992993; x=1740597793; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRAjz95NI3rbyQapsiIwvuE0ET1X08y61NLMUyCeAq4=;
 b=mTN5EnYVhY24vtpswkOqaicEYuhqA8rOjNyMr7rWXqA/8voS42Yp5vemfPuStqPDkb
 wZTG6d5TOl6Z0l/jonxI+1TZB6nJ+ezi3V3ZGaODeBcuNjyrJbaUxn5sLWGIlKmTFSFG
 ko9wzS9EQnw+iRDhsae5YkKtN3ZaNxcrliaMNg1JokxIc6VvAs209S6KpS2XdG7I80+J
 QzYjlF9iR5SHe1ysYz4XNUamHYrzJ3mRrz/h4DBWkd7InFv5gJYZL/XXoY5ChxjwdD/S
 98Jsq47qfOAGxVcqMlHDIqh3heZq2vIghdyVB8WmwiDrsgGVw0j7vXMYeOyDLLTMxET6
 dHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739992993; x=1740597793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRAjz95NI3rbyQapsiIwvuE0ET1X08y61NLMUyCeAq4=;
 b=XokWvngzMabmSNEQHtGfibzuDU3Br5sNhAkqWjo+aGerSCIl12xdNak+2Q8C1Ka9P9
 +bM3a8brrgB0zj55zoqFEcxMkOFWxpdhJPNDfhiAjyyrEcJXIMUGmRooTFKubPa35ATx
 jP/kg1WrWFwJ8he0S6ODeXdOpRS58mnM+1fH39DDLH5nJKZokFWE/EJMFGmO+3hK78vS
 jngm2ma7bQa2B5WOsQXykuGcK6kioDQ+evqG3UwyiXFz4v4kD5BvN5N9IIaY3z76yDr7
 uodeGm0V4bSvAZSwYd7duxgwUli+qqqLEdspsLLvfFOto1l7uPCBhcAoBwKSAMoazwJs
 TR/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUgLjcNPgrq3o6yqcM+F0oXIjuu9LPipxiIy7SSIjf2PIHUuvjcLLZm6epsyDRhzvDyROJR8Eh@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7+cDqmgWgjusGpr4EGdAKLYa3MwOBQG8B6XyHb09Tvocf/dY4
 2Xg2KNDvuZkCXhw0vxkPdqY3GfvjHkWb2q/+aoRENDy++mFFgUj5oVsl5W5Xp/BITP0M0O/ojqq
 tE3oyXuuSmh/Nd0rVil31LF3HSCk=
X-Gm-Gg: ASbGncsfkXEVAXljUZccUciGZD9h64NwRbudVMT7M6DLDYkerpHFmaz10T45BfdU4uF
 W6eJiWLn3UpkW95zjgRDuluiyZ7mGesyx2Z6bCuQlO7MGcxswOCsPXCdfBTVjiJKMGL5erY0p
X-Google-Smtp-Source: AGHT+IE1ISuTDXhZ9Y/67eBad6giWuhN/qICM4dTnI5Us9GDw58KYuvgo1GF/ber62sWolWZoZpThcwzPF9Bz5dT5Po=
X-Received: by 2002:a17:90b:3c4e:b0:2fc:15e8:b499 with SMTP id
 98e67ed59e1d1-2fc41175957mr11528476a91.8.1739992992760; Wed, 19 Feb 2025
 11:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20250219185415.243896-1-siqueira@igalia.com>
In-Reply-To: <20250219185415.243896-1-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Feb 2025 14:23:00 -0500
X-Gm-Features: AWEUYZkJXLydwfQaksWZ4JpKDqM7EYnX3WdKK3w3ScR9Hw7bc2y3LD5GOwWaR4Q
Message-ID: <CADnq5_MUPph86+JiTZ7PY6_BuDcrc-Kjxmp6Fvp9b+XdSMQb7A@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation/gpu: Add acronyms for some firmware
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

On Wed, Feb 19, 2025 at 1:55=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
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
> Changes since v1:
> - Expand acronym meanings based on Alex Deucher suggestions.
>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>

Applied.  Thanks!

Alex

> ---
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 45 ++++++++++++++++++--
>  1 file changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation=
/gpu/amdgpu/amdgpu-glossary.rst
> index 00a47ebb0b0f..1e9283e076ba 100644
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
> @@ -68,6 +71,9 @@ we have a dedicated glossary for Display Core at
>      IB
>        Indirect Buffer
>
> +    IMU
> +      Integrated Management Unit (Power Management support)
> +
>      IP
>          Intellectual Property blocks
>
> @@ -80,6 +86,12 @@ we have a dedicated glossary for Display Core at
>      KIQ
>        Kernel Interface Queue
>
> +    MC
> +      Memory Controller
> +
> +    ME
> +      MicroEngine (Graphics)
> +
>      MEC
>        MicroEngine Compute
>
> @@ -92,6 +104,9 @@ we have a dedicated glossary for Display Core at
>      MQD
>        Memory Queue Descriptor
>
> +    PFP
> +      Pre-Fetch Parser (Graphics)
> +
>      PPLib
>        PowerPlay Library - PowerPlay is the power management component.
>
> @@ -99,7 +114,10 @@ we have a dedicated glossary for Display Core at
>          Platform Security Processor
>
>      RLC
> -      RunList Controller
> +      RunList Controller. This name is a remnant of past ages and doesn'=
t have
> +      much meaning today. It's a group of general-purpose helper engines=
 for
> +      the GFX block. It's involved in GFX power management and SR-IOV, a=
mong
> +      other things.
>
>      SDMA
>        System DMA
> @@ -110,14 +128,35 @@ we have a dedicated glossary for Display Core at
>      SH
>        SHader array
>
> -    SMU
> -      System Management Unit
> +    SMU/SMC
> +      System Management Unit / System Management Controller
> +
> +    SRLC
> +      Save/Restore List Control
> +
> +    SRLG
> +      Save/Restore List GPM_MEM
> +
> +    SRLS
> +      Save/Restore List SRM_MEM
>
>      SS
>        Spread Spectrum
>
> +    TA
> +      Trusted Application
> +
> +    TOC
> +      Table of Contents
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
