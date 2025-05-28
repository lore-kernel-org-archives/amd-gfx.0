Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A96C5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 13:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D158510E2E5;
	Wed, 28 May 2025 13:26:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hRlRCL6G";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7323D10E2C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 13:26:38 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b2c43cbce41so242162a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748438798; x=1749043598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ec8WJJGvEuEPfnnU/CI/Qm+As6MJuB3UmlNhFsvNxqA=;
 b=hRlRCL6GDvDaoDmfOqCQwzccMv6g8/eFgB/u6NtDnAUfe8ckSBwXfIYyDBH0WnNWNK
 9l+VNqFET35mLYNCI3UNHW2yF8Sptfk2RXyHDz0CW+VL53zWEyOGaJljHWn8mvZbWnWD
 mLc+sW+qcyQ0mufyEsgU95kq2LGO43fAAEXk0AAripToWhPdthpc+HczkD34rjvsLZJt
 xFxx5ZQVFTp4fcH8Cz6DE9O7unRqt7FHJJMkaV/ijJ7F+bUyHwQG60arH6zZWGWNtLas
 DCCGWTSa2v8v5onMx7QpNbBRp4cHnOmtmkQUTqWhT/nFabum7inUwEehjbZ7JZ6kkPV4
 7Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748438798; x=1749043598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ec8WJJGvEuEPfnnU/CI/Qm+As6MJuB3UmlNhFsvNxqA=;
 b=ZTcLSDDZ4syl0L2+jidtBXmfjr1NiWA0mOBuHSdyLMyjsLn+3cBb5czMhRDhcq9Ct1
 i+/X7AUNt88Ez9bCyqout0tWvoZgcZII//Z8TzRrT34XFvQCTyzujbeT2i1ivtuVpLXb
 0sfnzb40tYT8udLV1f68MiaxzBszSyWNi3WkB4tch/nPUNLy2BOvKrhRX7ngakAqad6p
 zjOgtGDv2cQOT8sqOP2jBwbRr+HMRMDUOyYzemndJ+l0Xefet6W4VKUlOS5i+pI+xwtw
 tlBrsjoY0REHd//2DDkfxRYg0I8lKiXeyg8e6gIGPwcLQPhQRNwQACSPARan2+CghTfI
 z48A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBNYURtV2jBTDxFWUti1AHVrAy8XJDUXWCovDq0JP1GHGN+D6cgydoh76kSWIkhwcSfI2gFPio@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAW37VEzPA4vayaIFiRJZDSD5YsSe1O9Zn9c7eiP6G3gO+vbWT
 XtIItamABU7serm71kAKMtX8ufw+oszJnHDiiq2p7MWhvXDh6DF/Ze6o2HZg90DXZqY8CTYayGR
 wIb5lYMxrJ7k1BsmTiDqffiomEb+6bQdHpw==
X-Gm-Gg: ASbGncsmwzL60sZ5s+7WmVO7mtwxZjmCqTDEddnhhFjLM7E9XKNPg0y4o4uysukVI5u
 bmGx+0Dhzr862ZwAuxoVJqKKdB+ci0VUH+NL/plwfOYwu1Cmq9znKdMsZPWs3l3e9ZVQqe6Oj+2
 ArjReBO+K+BaktVgSsV6U+TY1uBu1DJ/DVDA==
X-Google-Smtp-Source: AGHT+IET+LytuwuyYz8z+RP7MTpMSFMJThrngCut676hTzlTrUxJtc6l3UxiQxTBE2Cj5OSssH+TXMOXiWm4ns5pUFk=
X-Received: by 2002:a17:903:228f:b0:234:d14c:50ff with SMTP id
 d9443c01a7336-234d14c5265mr14558865ad.6.1748438797809; Wed, 28 May 2025
 06:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250528092021.4049705-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250528092021.4049705-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 May 2025 09:26:25 -0400
X-Gm-Features: AX0GCFsrfnJ6pUeeZV5issr-Y12b6DezxqzGnaJ35bVw0kpFD9P4QMgDmsoMvSQ
Message-ID: <CADnq5_M-EaYTiXEEmo3_YaesL=Tvm9=Grv3kNrFHwVHzqYLQvA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Refine Cleaner Shader for GFX10.1.10
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Manu Rastogi <manu.rastogi@amd.com>
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

On Wed, May 28, 2025 at 5:30=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> This patch updates the cleaner shader, which is responsible for
> initializing GPU resources such as Local Data Share (LDS), Vector
> General Purpose Registers (VGPRs), and Scalar General Purpose Registers
> (SGPRs). Changes include adjustments to register clearing and shader
> configuration.
>
> - Updated GPU resource initialization addresses in the cleaner shader
>   from `be803080` to `be803000`.
> - Simplified the logic in the SGPR clearing section, ensuring all SGPRs
>   are set to zero.
>
> Fixes: 25961bad9212 ("drm/amdgpu/gfx10: Add cleaner shader for GFX10.1.10=
")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Manu Rastogi <manu.rastogi@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h   |  6 +++---
>  .../drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm  | 13 ++++++-------
>  2 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h b/driv=
ers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
> index 5255378af53c..f67569ccf9f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
> @@ -43,9 +43,9 @@ static const u32 gfx_10_1_10_cleaner_shader_hex[] =3D {
>         0xd70f6a01, 0x000202ff,
>         0x00000400, 0x80828102,
>         0xbf84fff7, 0xbefc03ff,
> -       0x00000068, 0xbe803080,
> -       0xbe813080, 0xbe823080,
> -       0xbe833080, 0x80fc847c,
> +       0x00000068, 0xbe803000,
> +       0xbe813000, 0xbe823000,
> +       0xbe833000, 0x80fc847c,
>         0xbf84fffa, 0xbeea0480,
>         0xbeec0480, 0xbeee0480,
>         0xbef00480, 0xbef20480,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm b=
/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm
> index 9ba3359253c9..54f7ed9e2801 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm
> @@ -40,7 +40,6 @@ shader main
>    type(CS)
>    wave_size(32)
>  // Note: original source code from SQ team
> -
>  //
>  // Create 32 waves in a threadgroup (CS waves)
>  // Each allocates 64 VGPRs
> @@ -71,8 +70,8 @@ label_0005:
>    s_sub_u32     s2, s2, 8
>    s_cbranch_scc0  label_0005
>    //
> -  s_mov_b32     s2, 0x80000000                     // Bit31 is first_wav=
e
> -  s_and_b32     s2, s2, s0                                  // sgpr0 has=
 tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is=
 set
> +  s_mov_b32     s2, 0x80000000                       // Bit31 is first_w=
ave
> +  s_and_b32     s2, s2, s1                           // sgpr0 has tg_siz=
e (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
>    s_cbranch_scc0  label_0023                         // Clean LDS if its=
 first wave of ThreadGroup/WorkGroup
>    // CLEAR LDS
>    //
> @@ -99,10 +98,10 @@ label_001F:
>  label_0023:
>    s_mov_b32     m0, 0x00000068  // Loop 108/4=3D27 times  (loop unrolled=
 for performance)
>  label_sgpr_loop:
> -  s_movreld_b32     s0, 0
> -  s_movreld_b32     s1, 0
> -  s_movreld_b32     s2, 0
> -  s_movreld_b32     s3, 0
> +  s_movreld_b32     s0, s0
> +  s_movreld_b32     s1, s0
> +  s_movreld_b32     s2, s0
> +  s_movreld_b32     s3, s0
>    s_sub_u32         m0, m0, 4
>    s_cbranch_scc0  label_sgpr_loop
>
> --
> 2.34.1
>
