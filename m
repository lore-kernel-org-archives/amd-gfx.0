Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A83C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FCBD10EC2C;
	Fri, 11 Apr 2025 16:47:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="njl2AKQB";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B377E10EC2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:47:30 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3054e2d13a7so406037a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744390050; x=1744994850; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGJG7qY/sS1yCaACMJXRFHZEZT2XKaYNB02hbAPSl0s=;
 b=njl2AKQBQ/z7NlN1Y+ThmHzKJrsgL1MVciToDoweEWE5QGuOIIjQcW5kH4N9zJLqnM
 SeZ20kaUwatRztFR6NiUZ4miD1KFX8XXWMdJD/7/i6tIKD0VbmIkYkNzjA1WFumUIWHi
 uT1zG5PA4DNDVxsqG8Xc7AzGJEZrbr8KqpehUt9PHQoduj4UA8idvVvQ737w+by5KviE
 RB22lNPrj8hZ1LZ2Pm39SqvlN8iVvLs/+onVkZfD6bFMwYwsa7CcAog9ZQBMpPsTwmj6
 GacLDIIuW462dcN4/iokqSrXhxByd8JtZ8OYd4XPbG4WOsQEIRWJ/ednFSfMB5mGgZOB
 bRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744390050; x=1744994850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGJG7qY/sS1yCaACMJXRFHZEZT2XKaYNB02hbAPSl0s=;
 b=XDDRRpNrhylXbx9zLWnbjBarapzztvEsBF0YADYpJOiLG250yEr3fGsW+kAnFEXg9e
 asNgfRDFqnD1I60nkSuLqzMNLy9rqpQn6E4ziPOpd5rYo7DWH9BTdWU5XS+F8LRgWBew
 cuQTxdefjZUfccUqUs4ArAVGw+usBwTLeF7ibvROPonHjV/aP1BlW0BoffhwdYIbTiWh
 6WO80GLWmbrXL9vyhQ331NSiY1xNGj0AWLy//m2Ba40prXCId5ciss8c26dHfSpkT5ts
 +/CmSBkUOwP39AtOwNx6O5szziWbzpoe6yEqqFmuW9sJMYiSTu+LEyGFgEI4dobGanZx
 qc+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH/OakLouRA1GqPpZxMLh9umw1qwfyhbW2QRElU3PPy2hdZuKEj3W0N6EKIrQUaQvBy6eYaNv0@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4opCLO+UIQC4snHEsilKO4x574S6iAEc89LIkOaaUJsPkORYD
 HigPLdqdsiatRhmJfM9Z4jhFrb3oZF0sfv7V3kdiVwy1Yc+i2OICD9Bgi2/2lfe6BKL+LaAkAgA
 YnJYyvkeI9ssNyx26UQMOPjN7+iON3A==
X-Gm-Gg: ASbGncsh3KrAS1PMN3UJSLwoC4GmZ/FpwpyNDcH3qnICndXbVCmjhIYUy31laPnDbto
 pBJfZg3yYskU73muHb4SPET8PaBbH8ByRI54gPjhH6n5PkVayTp0Npi0UU0DmBUbt8yi5COsgtM
 R5Lls4zQUjWtw9yrrxhgtFTw==
X-Google-Smtp-Source: AGHT+IEiFWYJKLhiu8fOkpYMPp18DZbjMFAt6Fi1YWISnI4zZz8q8jVwSnk01yPHf/YPNB/IQJGd01rJTyj1FsCg2Rg=
X-Received: by 2002:a17:90b:3b82:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-308236285dcmr2009256a91.2.1744390050306; Fri, 11 Apr 2025
 09:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250411161943.3323364-1-srinivasan.shanmugam@amd.com>
 <20250411161943.3323364-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250411161943.3323364-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 12:47:16 -0400
X-Gm-Features: ATxdqUFg-j-HAtcH52SyZbBeue3v3CzgdIsCSRZc4LSzLt793SnWlGLqgb9cf-8
Message-ID: <CADnq5_Nb39LkBmFFQYofzdV+sj=Yu7h7iCQXLgpfFm=Y4MMUcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Add PACKET3_RUN_CLEANER_SHADER_9_0 for
 Cleaner Shader execution
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

On Fri, Apr 11, 2025 at 12:28=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit introduces the PACKET3_RUN_CLEANER_SHADER_9_0 definition,
> which is a command packet utilized to instruct the GPU to execute the
> cleaner shader for the GFX9.0 graphics architecture.
>
> The cleaner shader is a piece of GPU code that is responsible for
> clearing or initializing essential GPU resources, such as Local Data
> Share (LDS), Vector General Purpose Registers (VGPRs), and Scalar
> General Purpose Registers (SGPRs). Properly clearing these resources  is
> vital for ensuring data isolation and security between different
> workloads executed on the GPU.
>
> When the GPU receives this packet, it fetches and runs the cleaner
> shader instructions from the specified location in the packet.  Thus by
> preventing data leaks and ensuring that previous job states do not
> interfere with subsequent workloads.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc15d.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/am=
dgpu/soc15d.h
> index a5000c171c02..cf93fa477674 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> @@ -552,6 +552,11 @@
>  #              define PACKET3_QUERY_STATUS_DOORBELL_OFFSET(x)  ((x) << 2=
)
>  #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 2=
5)
>
> +#define PACKET3_RUN_CLEANER_SHADER_9_0                      0xD7
> +/* 1. header
> + * 2. RESERVED [31:0]
> + */
> +
>  #define PACKET3_RUN_CLEANER_SHADER                      0xD2
>  /* 1. header
>   * 2. RESERVED [31:0]
> --
> 2.34.1
>
