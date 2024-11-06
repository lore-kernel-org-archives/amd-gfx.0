Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61B2D44D77
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 14:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467D010E166;
	Wed,  6 Nov 2024 14:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tds6aq+K";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F324D10E166
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 14:13:41 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2e2da8529e1so661151a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Nov 2024 06:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730902421; x=1731507221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkzDIJBLDpzrRNx05a/Y7CfdjEzAgFpo9KZdki0kInw=;
 b=Tds6aq+KktUbgTy8qnKIqSGBBzYkRodI5W884DdzXhkQq4xBWHGU5edZkfCEe+kRcE
 6h+3qK0kFGJxfmfxwFJsOS3ah5qO9ZXhTZT7cfxsZ6bswAR52BHOh3678SBlsJ+BsJxa
 dO6wynNBpNMrCy6C7foZ0bc2iSPNAyz8UNLHgbkAO3U3fPtN7W+OlRbYCrA+pi4Epmhd
 jMawl7O+Z2PT0qkyHR4FQljgTgypvCHEHse9qrAvBKS9YnBY7KWqhcSISC2seLGuuh+A
 nxlRRKccucQDvysUIO7eo4Sp+vlGWSq1xtRnket4C5nSNTyD0kM8JqGhog6fKehPSzJj
 7pvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730902421; x=1731507221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkzDIJBLDpzrRNx05a/Y7CfdjEzAgFpo9KZdki0kInw=;
 b=BS9EUi4AsdRhZt6/MdPwRlDsL8zj+7bIQ2T5aXIqHoAn0soO8Q5pn2bYrCkKu1jsfn
 uq4MGNjFbsybE2mvXNYF6nijE7YoqO893aVZ/wUV8/txKWlK9OxN4Q6IuipuRybERicU
 FAfXaDqwV/Ba2wjefU8fZxwQdiCde8uxvBNGcecUNZtgKNxsLKtde5z+Ib8VVKMzJpzu
 RpgQRvDBvusooweVgMkuQW6WUsabiJOTvfTpI61DTupbpR4W7VkLs/5lR0MlAkp1sVk7
 Q/0elYKdIfTrPrBcRhQK07RFe4AUGspj1iCFOJ2z03afS2g9CUY8TH9lQ5yJe6Q5gfYr
 qctA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXONfjNMMFbQ/9NY329rH4KrYsjkTm7Uh3PUgtI1h+IaTFG3QT5Aoi7qkR/PW5ZdcAHnvXaExP@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8fkeV1zbyHr52Vmqzys06sg4KnWsSnIYMUOc0FYX3Qqm/4+Q6
 fm8nklW5HUKd2TD/88hKb99tYZ3zj8901MoElDeYCzz+fD3Xe9bJ90TQ48x4hJAksgAE5wYxnbn
 HDfm/fBPiTDgn+5vRiQnFSfDaiWk0UQ==
X-Google-Smtp-Source: AGHT+IFrpHbhUwMs1+HneKEgv58UfTqcxijyolwrrvuBOuC5FHCKYG/KK1LDcRvQBTTYWdHG3C6MDaGp44rbkCl+ogM=
X-Received: by 2002:a17:90b:510:b0:2db:60b:eec with SMTP id
 98e67ed59e1d1-2e8f11bf830mr19099903a91.7.1730902420977; Wed, 06 Nov 2024
 06:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20241106021900.4104215-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241106021900.4104215-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Nov 2024 09:13:29 -0500
Message-ID: <CADnq5_MjmeN2HDzubBEp96rYiG-ji5W+f5eTbXdbFGfnoF0x4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Add cleaner shader for GFX10.3.0
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

On Tue, Nov 5, 2024 at 9:19=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit adds the cleaner shader microcode for GFX10.3.0 GPUs. The
> cleaner shader is a piece of GPU code that is used to clear or
> initialize certain GPU resources, such as Local Data Share (LDS), Vector
> General Purpose Registers (VGPRs), and Scalar General Purpose Registers
> (SGPRs).
>
> Clearing these resources is important for ensuring data isolation
> between different workloads running on the GPU. Without the cleaner
> shader, residual data from a previous workload could potentially be
> accessed by a subsequent workload, leading to data leaks and incorrect
> computation results.
>
> The cleaner shader microcode is represented as an array of 32-bit words
> (`gfx_10_3_0_cleaner_shader_hex`). This array is the binary
> representation of the cleaner shader code, which is written in a
> low-level GPU instruction set.
>
> When the cleaner shader feature is enabled, the AMDGPU driver loads this
> array into a specific location in the GPU memory. The GPU then reads
> this memory location to fetch and execute the cleaner shader
> instructions.
>
> The cleaner shader is executed automatically by the GPU at the end of
> each workload, before the next workload starts. This ensures that all
> GPU resources are in a clean state before the start of each workload.
>
> This addition is part of the cleaner shader feature implementation. The
> cleaner shader feature helps resource utilization by cleaning up GPU
> resources after they are used. It also enhances security and reliability
> by preventing data leaks between workloads.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  15 +++
>  .../drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h |  56 ++++++++
>  .../amd/amdgpu/gfx_v10_3_0_cleaner_shader.asm | 124 ++++++++++++++++++
>  3 files changed, 195 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_3_0_cleaner_shader=
.asm
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 4607d5c071ce..4f1cc61f9c43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -45,6 +45,7 @@
>  #include "clearstate_gfx10.h"
>  #include "v10_structs.h"
>  #include "gfx_v10_0.h"
> +#include "gfx_v10_0_cleaner_shader.h"
>  #include "nbio_v2_3.h"
>
>  /*
> @@ -4733,6 +4734,20 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                 break;
>         }
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       case IP_VERSION(10, 3, 0):
> +               adev->gfx.cleaner_shader_ptr =3D gfx_10_3_0_cleaner_shade=
r_hex;
> +               adev->gfx.cleaner_shader_size =3D sizeof(gfx_10_3_0_clean=
er_shader_hex);
> +               if (adev->gfx.me_fw_version >=3D 64 &&
> +                   adev->gfx.pfp_fw_version >=3D 100 &&
> +                   adev->gfx.mec_fw_version >=3D 122) {
> +                       adev->gfx.enable_cleaner_shader =3D true;
> +                       r =3D amdgpu_gfx_cleaner_shader_sw_init(adev, ade=
v->gfx.cleaner_shader_size);
> +                       if (r) {
> +                               adev->gfx.enable_cleaner_shader =3D false=
;
> +                               dev_err(adev->dev, "Failed to initialize =
cleaner shader\n");
> +                       }
> +               }
> +               break;
>         default:
>                 adev->gfx.enable_cleaner_shader =3D false;
>                 break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h b/driv=
ers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
> new file mode 100644
> index 000000000000..bc8417063af9
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/* Define the cleaner shader gfx_10_3_0 */
> +static const u32 gfx_10_3_0_cleaner_shader_hex[] =3D {
> +       0xb0804004, 0xbf8a0000,
> +       0xbe8203b8, 0xbefc0380,
> +       0x7e008480, 0x7e028480,
> +       0x7e048480, 0x7e068480,
> +       0x7e088480, 0x7e0a8480,
> +       0x7e0c8480, 0x7e0e8480,
> +       0xbefc0302, 0x80828802,
> +       0xbf84fff5, 0xbe8203ff,
> +       0x80000000, 0x87020002,
> +       0xbf840012, 0xbefe03c1,
> +       0xbeff03c1, 0xd7650001,
> +       0x0001007f, 0xd7660001,
> +       0x0002027e, 0x16020288,
> +       0xbe8203bf, 0xbefc03c1,
> +       0xd9382000, 0x00020201,
> +       0xd9386040, 0x00040401,
> +       0xd70f6a01, 0x000202ff,
> +       0x00000400, 0x80828102,
> +       0xbf84fff7, 0xbefc03ff,
> +       0x00000068, 0xbe803080,
> +       0xbe813080, 0xbe823080,
> +       0xbe833080, 0x80fc847c,
> +       0xbf84fffa, 0xbeea0480,
> +       0xbeec0480, 0xbeee0480,
> +       0xbef00480, 0xbef20480,
> +       0xbef40480, 0xbef60480,
> +       0xbef80480, 0xbefa0480,
> +       0xbf810000, 0xbf9f0000,
> +       0xbf9f0000, 0xbf9f0000,
> +       0xbf9f0000, 0xbf9f0000,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_3_0_cleaner_shader.asm b/=
drivers/gpu/drm/amd/amdgpu/gfx_v10_3_0_cleaner_shader.asm
> new file mode 100644
> index 000000000000..83c7be34515d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_3_0_cleaner_shader.asm
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +// This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 Dwords =
or 256 bytes of 192 Dwords cleaner shader.
> +//To turn this shader program on for complitaion change this to main and=
 lower shader main to main_1
> +
> +// Navi2 : Clear SGPRs, VGPRs and LDS
> +//   Launch 32 waves per CU (16 per SIMD) as a workgroup (threadgroup) t=
o fill every wave slot
> +//   Waves are "wave32" and have 64 VGPRs each, which uses all 1024 VGPR=
s per SIMD
> +//   Waves are launched in "CU" mode, and the workgroup shares 64KB of L=
DS (half of the WGP's LDS)
> +//      It takes 2 workgroups to use all of LDS: one on each CU of the W=
GP
> +//   Each wave clears SGPRs 0 - 107
> +//   Each wave clears VGPRs 0 - 63
> +//   The first wave of the workgroup clears its 64KB of LDS
> +//   The shader starts with "S_BARRIER" to ensure SPI has launched all w=
aves of the workgroup
> +//       before any wave in the workgroup could end.  Without this, it i=
s possible not all SGPRs get cleared.
> +
> +
> +shader main
> +  asic(GFX10)
> +  type(CS)
> +  wave_size(32)
> +// Note: original source code from SQ team
> +
> +//
> +// Create 32 waves in a threadgroup (CS waves)
> +// Each allocates 64 VGPRs
> +// The workgroup allocates all of LDS (64kbytes)
> +//
> +// Takes about 2500 clocks to run.
> +//   (theorhetical fastest =3D 1024clks vgpr + 640lds =3D 1660 clks)
> +//
> +  S_BARRIER
> +  s_mov_b32     s2, 0x00000038  // Loop 64/8=3D8 times  (loop unrolled f=
or performance)
> +  s_mov_b32     m0, 0
> +  //
> +  // CLEAR VGPRs
> +  //
> +label_0005:
> +  v_movreld_b32     v0, 0
> +  v_movreld_b32     v1, 0
> +  v_movreld_b32     v2, 0
> +  v_movreld_b32     v3, 0
> +  v_movreld_b32     v4, 0
> +  v_movreld_b32     v5, 0
> +  v_movreld_b32     v6, 0
> +  v_movreld_b32     v7, 0
> +  s_mov_b32         m0, s2
> +  s_sub_u32     s2, s2, 8
> +  s_cbranch_scc0  label_0005
> +  //
> +  s_mov_b32     s2, 0x80000000                     // Bit31 is first_wav=
e
> +  s_and_b32     s2, s2, s0                                  // sgpr0 has=
 tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is=
 set
> +  s_cbranch_scc0  label_0023                         // Clean LDS if its=
 first wave of ThreadGroup/WorkGroup
> +  // CLEAR LDS
> +  //
> +  s_mov_b32 exec_lo, 0xffffffff
> +  s_mov_b32 exec_hi, 0xffffffff
> +  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to thread-ID (0.=
.63)
> +  v_mbcnt_hi_u32_b32  v1, exec_lo, v1        // Set V1 to thread-ID (0..=
63)
> +  v_mul_u32_u24  v1, 0x00000008, v1          // * 8, so each thread is a=
 double-dword address (8byte)
> +  s_mov_b32     s2, 0x00000003f                    // 64 loop iterations
> +  s_mov_b32     m0, 0xffffffff
> +  // Clear all of LDS space
> +  // Each FirstWave of WorkGroup clears 64kbyte block
> +
> +label_001F:
> +  ds_write2_b64  v1, v[2:3], v[2:3] offset1:32
> +  ds_write2_b64  v1, v[4:5], v[4:5] offset0:64 offset1:96
> +  v_add_co_u32     v1, vcc, 0x00000400, v1
> +  s_sub_u32     s2, s2, 1
> +  s_cbranch_scc0  label_001F
> +
> +  //
> +  // CLEAR SGPRs
> +  //
> +label_0023:
> +  s_mov_b32     m0, 0x00000068  // Loop 108/4=3D27 times  (loop unrolled=
 for performance)
> +label_sgpr_loop:
> +  s_movreld_b32     s0, 0
> +  s_movreld_b32     s1, 0
> +  s_movreld_b32     s2, 0
> +  s_movreld_b32     s3, 0
> +  s_sub_u32         m0, m0, 4
> +  s_cbranch_scc0  label_sgpr_loop
> +
> +  //clear vcc
> +  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
> +  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
> +  s_mov_b64 vcc, 0          //clear vcc
> +  s_mov_b64 ttmp0, 0        //Clear ttmp0 and ttmp1
> +  s_mov_b64 ttmp2, 0        //Clear ttmp2 and ttmp3
> +  s_mov_b64 ttmp4, 0        //Clear ttmp4 and ttmp5
> +  s_mov_b64 ttmp6, 0        //Clear ttmp6 and ttmp7
> +  s_mov_b64 ttmp8, 0        //Clear ttmp8 and ttmp9
> +  s_mov_b64 ttmp10, 0       //Clear ttmp10 and ttmp11
> +  s_mov_b64 ttmp12, 0       //Clear ttmp12 and ttmp13
> +  s_mov_b64 ttmp14, 0       //Clear ttmp14 and ttmp15
> +
> + s_endpgm
> +
> +end
> +
> +
> --
> 2.34.1
>
