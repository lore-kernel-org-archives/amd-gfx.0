Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87308C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3130410EA25;
	Thu, 28 Aug 2025 15:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BEvc+zNm";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95EB310EA25
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:21:30 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3234f8df749so111993a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756394490; x=1756999290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZhLyduQPqsaOqfoSr0TdXUahVL1YfwRqgH8SYEXxRY=;
 b=BEvc+zNmytGpPTvQTBkKmWWdNzR2j665HtphGiOGD95vnUgx3ZrA84cjY0lQK90bXM
 eReaK8+qCYDUetc2JptO0GIOw9iN6CYBzzd6zjfWIxAX3lrBOZGM5hwjTkC2yw0FYSSk
 WyYMRPO6bFC3B5VORrOToA+DdmYqCgsLIegTBAfB/IsJI5yJsInZ7auK6WlAIRnA83sc
 nlMxmLSzNYIkZD5cr1Q+toFdseY+Nea2iy+bfEN9jdxXPiV6pK4+mKbeqFlkQjXGE0va
 U0upQTmMYph+ZVDSlY19HEdoyRSlBiGY1gJ9PH2YQEZisOH51JWq2zt+xE4DdIiw/9ug
 Ge4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394490; x=1756999290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZhLyduQPqsaOqfoSr0TdXUahVL1YfwRqgH8SYEXxRY=;
 b=O3ABuBl3NQxjUuMnriwCV54kcE3zgLAoBQY3SkJE/b7BmO+J1ZChPWnrFDAI73lLBj
 /kD07hlTAKaSnM/GYxbfyKta64tHRn4NtUGvlxf7nzxRqvX8fIWVZNyBQA7wU7uCvWqY
 pczAFg4sMoaidE30rUVPLhaukJUYLrwhDq14icoRNmXux20UYR6zkPeuL5zvSZDcZ5d2
 PZolFgzozs5iLRk0scxc6qmH+ePoAHXxcdugaoa4rcZ2RJ7q+0wWISLdGzrtvu66vr1V
 QC+mDb/GEgIzMG2ys0nJKalbw4rSHFW2LIePKbWpZqeRcqS914Iz7DiZ84Gaz0Vie/hg
 ytHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcCSkYiRMfJqFGbKWIDG2q2RdhfT2OBK5vHfJt1LQ+/A1KyeTYZRAASdrMErWm0Hj9OIQdibF0@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxq63X1r6CjB5OSthwxe/v0FzG/T2ba0Ivr7ofLUjxp7A60qF9G
 KnM765uQLGKrD2TOQmb443NLbTk3A4T9DjWwtx6RzOFkOSL+NX/CyoPR5Ap6UxB82Ftj/3gbWA9
 g/tF8qp3gk0xFW2imoMwAaRMehgdmHSY=
X-Gm-Gg: ASbGncuuUu+bjaBHlfxejdy0I08x31SQSiNcYjX8tZqAcPFIvIVzj04gxHRMbv8/NGZ
 p3/ixndNL7GjDqoQGsW23M5X5ttl/zG3i0RIc7ZSGiff25Mh3+pAVW61rdk4wNO/sl8zsYG+6+i
 qF/3iSqO9rCanCzeTfbj/QtvVfnu631v1YQP+dXWW41bGqpy56TnT7vI+L/hdDsNI9HXQaNWRPU
 mWhKzE=
X-Google-Smtp-Source: AGHT+IGAi8RdN5iat5NqmlNEn4wCCwfC1LO1duiJ0mp708vYdqwlzvnP7PZcFyB9YeqOlErJ9uh/SF0ov/EOF9ql784=
X-Received: by 2002:a17:90b:1c8b:b0:327:4fab:1dd3 with SMTP id
 98e67ed59e1d1-3274fab1ff2mr7159267a91.4.1756394489926; Thu, 28 Aug 2025
 08:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
 <20250828064530.3948378-4-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250828064530.3948378-4-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 11:21:17 -0400
X-Gm-Features: Ac12FXxanjHNhdVnVyeqjiO-7mdXNbDzmcXzcxbEYdnyFYiz0v4klgZazXWKwnY
Message-ID: <CADnq5_NaDyXZxJsZVnwaR+nEox5yvDqb0mYT48+mFEUkfG662g@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP
 Placement
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

On Thu, Aug 28, 2025 at 5:53=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Introduce a kernel-internal TTM placement type AMDGPU_PL_MMIO_REMAP
> for the HDP flush MMIO remap page
>
> Plumbing added:
> - amdgpu_res_cursor.{first,next}: treat MMIO_REMAP like DOORBELL
> - amdgpu_ttm_io_mem_reserve(): return BAR bus address + offset
>   for MMIO_REMAP, mark as uncached I/O
> - amdgpu_ttm_io_mem_pfn(): PFN from register BAR
> - amdgpu_res_cpu_visible(): visible to CPU
> - amdgpu_evict_flags()/amdgpu_bo_move(): non-migratable
> - amdgpu_ttm_tt_pde_flags(): map as SYSTEM
> - amdgpu_bo_mem_stats_placement(): report AMDGPU_PL_MMIO_REMAP
> - amdgpu_fdinfo: print =E2=80=9Cmmioremap=E2=80=9D bucket label
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index 2309df3f68a9..bb17987f0447 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -34,7 +34,8 @@
>  #define AMDGPU_PL_OA           (TTM_PL_PRIV + 2)
>  #define AMDGPU_PL_PREEMPT      (TTM_PL_PRIV + 3)
>  #define AMDGPU_PL_DOORBELL     (TTM_PL_PRIV + 4)
> -#define __AMDGPU_PL_NUM        (TTM_PL_PRIV + 5)
> +#define AMDGPU_PL_MMIO_REMAP   (TTM_PL_PRIV + 5)
> +#define __AMDGPU_PL_NUM        (TTM_PL_PRIV + 6)
>
>  #define AMDGPU_GTT_MAX_TRANSFER_SIZE   512
>  #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS        2
> --
> 2.34.1
>
