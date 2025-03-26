Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F02BC36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 08:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5C010E0FD;
	Wed, 26 Mar 2025 08:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PT0Irx15";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A510210E0FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 08:08:35 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so4109134f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742976514; x=1743581314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=75+q2z/puc5KEiBDalUbsTlKlpmxGTpxbd7S5/o5YWY=;
 b=PT0Irx15Jni756/r5vKWLjYE5R2oIxqLanliG804G1AevZIAimdNH/5XUMtiegTOyD
 +SPXd+3AwuJEDyxqQJxUFMyQ+//BSwh1IPjrlmOVV2KZkNIIpkBmsiukTV0v8JgEsHcu
 rdBenQt2rzrUTSAdJn7Hiwsf7Z94Zj5+Ra+H+clEpCUCLW9wiHcBt9u905GacFrrJCHG
 O3VxCavAkkNfXDrxacbkI9tekzvJi3OtTDK0a+QLa6Fq/cdSUssrItHmSbmoRLkMgcOi
 ArFNj5lSeC2PZZtQ5UJ67Omv3G3HOFe5093+XL3VTMxp8Q3ldyqLy9UCV7QcmI1i/RYl
 PwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742976514; x=1743581314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=75+q2z/puc5KEiBDalUbsTlKlpmxGTpxbd7S5/o5YWY=;
 b=BIFO+ZGy87cXtxiRKccjVtQrYGYKK3unWkeZvnJXd+AFZbR84gXbApzsG0/NbuBKzC
 MLqXq/U2NkN8zfRe6VDqGsoiBnUqAGPEKVqgxhncyLRgvTDQ09t86QHXCZw50HpT9Ig/
 B0iSgq8vJrqwKiPluY4gGMOEPAgNi+WPeg8M8m92+vlB1SvKvju4pLIiz+z9Z+Nfwzjz
 NSxeHYLcoE6eIg3387ZxhP3H+BiOdabKWlcGtB/dUoRUeyPVthhEKffzXS0APM0HyfLl
 sM7BZfaGlDua3CuO04ra30KzoA2LsaxtkHH2+3he7kn3cBf122Z80etYs0llOm6ZkxgK
 Lt7A==
X-Gm-Message-State: AOJu0YxYNghAL71rG5V9Zv+QTxh/dlRcMpdW0xQuqsGXL8lNrA4cdmuy
 xt6WXsypZuo2uvfO72XA/5p+nFZI/UPtJTqaP75uyBbkasaFgaD5
X-Gm-Gg: ASbGnctQKOWDS3xBX017PftZAWMGmVwIxEcFnX0LzPxmL6sBf0hmCmtEdwkYglLGHnR
 eKy8HjwlB/aNB/WPxUaDvfffHmXrZUFSL+SEJVEK5adeyfrYv9BRay1TboNS6GT599v7yAmKoDA
 rHLJ5wbFmSLkXTVVLerTA8FXFydJGM4KhprxBY8Qq/e0IkAlMlnScfWSi58YIvKFZZN7PWyHLVV
 oVxOv54+7UeO1ORM+pEkvvmY9qnWMfFxDpPOqnSxg8jrPs6z1sHZyEvz4Wknj+c9CV1lQ+y1VwP
 Qe8IQR3x1YDMkdievvV6yP0HuwtTvogYgzXNH8MqKl0J9Mbsbci0lAE2+XpA5AkZ4Sy7L3cG5A=
 =
X-Google-Smtp-Source: AGHT+IFQ0rsiaEJrRfldwBhpsceViTdVtxyi/rqnT/4yIOz4p8+qmeWYt/oc663uVzw+h51bM1vvzA==
X-Received: by 2002:a05:6000:1a8d:b0:390:f394:6271 with SMTP id
 ffacd0b85a97d-3997f94db40mr16451725f8f.43.1742976513718; 
 Wed, 26 Mar 2025 01:08:33 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3b83sm16328676f8f.33.2025.03.26.01.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 01:08:33 -0700 (PDT)
Message-ID: <f3d24ce3-9e0f-4bc8-9433-2af9ffe7f306@gmail.com>
Date: Wed, 26 Mar 2025 09:08:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] Documentation/gpu: Add new acronyms
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Melissa Wen
 <mwen@igalia.com>, =?UTF-8?Q?=27Andr=C3=A9_Almeida=27?=
 <andrealmeid@igalia.com>, =?UTF-8?Q?=27Timur_Krist=C3=B3f=27?=
 <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org,
 kernel-dev@igalia.com
References: <20250325172623.225901-1-siqueira@igalia.com>
 <20250325172623.225901-2-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250325172623.225901-2-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Am 25.03.25 um 18:18 schrieb Rodrigo Siqueira:
> This commit introduces some new acronyms extracted from the source code
> and found on some web pages around the internet (most of them came from
> ArchLinux, Gentoo, and Wikipedia links).
>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 36 ++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index 1e9283e076ba..080c3f2250d1 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -12,15 +12,27 @@ we have a dedicated glossary for Display Core at
>        The number of CUs that are active on the system.  The number of active
>        CUs may be less than SE * SH * CU depending on the board configuration.
>  
> +    BACO
> +      Bus Alive, Chip Off
> +
> +    BOCO
> +      Bus Off, Chip Off
> +
>      CE
>        Constant Engine
>  
> +    CIK
> +      Sea Islands
> +
>      CP
>        Command Processor
>  
>      CPLIB
>        Content Protection Library
>  
> +    CS
> +      Command Submission
> +
>      CU
>        Compute Unit
>  
> @@ -33,6 +45,9 @@ we have a dedicated glossary for Display Core at
>      EOP
>        End Of Pipe/Pipeline
>  
> +    FLR
> +      Function Level Reset
> +
>      GART
>        Graphics Address Remapping Table.  This is the name we use for the GPUVM
>        page table used by the GPU kernel driver.  It remaps system resources
> @@ -80,6 +95,9 @@ we have a dedicated glossary for Display Core at
>      KCQ
>        Kernel Compute Queue
>  
> +    KFD
> +      Kernel Fusion Driver
> +
>      KGQ
>        Kernel Graphics Queue
>  
> @@ -89,6 +107,9 @@ we have a dedicated glossary for Display Core at
>      MC
>        Memory Controller
>  
> +    MCBP
> +      Mid Command Buffer Preemption
> +
>      ME
>        MicroEngine (Graphics)
>  
> @@ -125,9 +146,15 @@ we have a dedicated glossary for Display Core at
>      SE
>        Shader Engine
>  
> +    SGPR
> +      Scalar General-Purpose Registers
> +
>      SH
>        SHader array
>  
> +    SI
> +      Southern Islands
> +
>      SMU/SMC
>        System Management Unit / System Management Controller
>  
> @@ -146,6 +173,9 @@ we have a dedicated glossary for Display Core at
>      TA
>        Trusted Application
>  
> +    TC
> +      Texture Cache
> +
>      TOC
>        Table of Contents
>  
> @@ -158,5 +188,11 @@ we have a dedicated glossary for Display Core at
>      VCN
>        Video Codec Next
>  
> +    VGPR
> +      Vector General-Purpose Registers
> +
> +    VMID
> +      Virtual Memory ID
> +
>      VPE
>        Video Processing Engine

