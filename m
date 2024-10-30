Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F65D5CCB5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 14:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C20C10E7B9;
	Wed, 30 Oct 2024 14:58:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VmQYB4Lu";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B03C10E3F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 14:58:08 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2e5b1aaad96so1072185a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730300288; x=1730905088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UL6LoGlt4ujwPKWB1qA/RAIgdLe7SuoovhFz3Cb6n2Y=;
 b=VmQYB4LubEEJroZ8GYq4jDJrtLejyM448PS53lERmVPMK0MEoVGO9R8RKIhbgJCnYm
 qgIw55ggYXB23eCgJ1nDxGhYWsTDfBxWxRbiYzRgpslI8rgmlzmSy3wuk5SEN8GyWm+d
 JX/A9dJ0VCD7iKo9gXMrgpVEiyFE7beYM6Dq/VpDSxAfrAkfOjeBFc95Y9mLaXYbpG7W
 B5iy5iaB8SJMTUzeGYG7jxhqHKH1rVNGeHYYHoXuKRJl7K9FNaxerT7s8JSe3wz/tuf6
 Mh7YI1iA3dmKcstJnZvirtzCUDhwp//Je25lv6f9TVOQow1JmYv8GGCwJ4hkwIRzLZwn
 PKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730300288; x=1730905088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UL6LoGlt4ujwPKWB1qA/RAIgdLe7SuoovhFz3Cb6n2Y=;
 b=et2HmkWx78X9eamkcTfFURfWi7BfD0nhEXf4FV3zVYeAqwbgK8l76kGGtQ8T5/DptI
 5p9kaWa9T3a7qKVY155CSIjCLHEKm4l3tKLwHBM70kFs53isDBeEbO28ZeDS1VrQ7f4w
 5DlAIZteUzx2k7/oFfC3s249Gv1UFZ7Ce4VY+67S2WS0GejcosB1TmSBMWNiP8ckq7Dg
 CPRNVOiXL3wYxldGKz24RrRjVrVfkS3obW12Ym4RAndwhdN8j0mm3mXCLPS0vS7V9fFS
 qfcdNMtrm7rr1H/OdLcI1+hw/DEAsEn4ffP3ffurmX99O/QH238pO5NTVyvsiUv8cKsk
 jqgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8VweSzfRREIxPGeit/VjcJZtrDV2XRW/1eMR+pdSyYPpLkHCxee/6mPN3jgqT7+GfAnNMBCdJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhO7wqZJjyO8JZT6ZluhEHdcl+Zqclec+tdk9WAMhOK9Co/dpR
 XIMp/MGmZ4xnZ8zkqnYob1DivIkit7fximwcFSsfkmN9g1a2SU+Qid709Ze8//IWG9x0MHSQGns
 QBQdnNYVt8cxc3584EmL08l9e1SSV/g==
X-Google-Smtp-Source: AGHT+IHAgKlMNLPwv8Pr80RXSR+9vQN4hmfl0CPd0UI6SRIC+ef2et4bKSKUZKknXp3DEWgvV3HkfkA0Ef1BDAG8Z2Q=
X-Received: by 2002:a17:90b:1a8e:b0:2e0:9d55:3784 with SMTP id
 98e67ed59e1d1-2e8f0d4d329mr7617469a91.0.1730300287732; Wed, 30 Oct 2024
 07:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241030142920.1525517-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241030142920.1525517-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Oct 2024 10:57:55 -0400
Message-ID: <CADnq5_O+VWfD2AUmrtw=MgX6CMcJQ3sa2eTFL9Mtn8Vr3RAT1A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx9: Add cleaner shader for GFX11.0.3
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

On Wed, Oct 30, 2024 at 10:29=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit adds the cleaner shader microcode for GFX11.0.3 GPUs. The
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
> (`gfx_11_0_3_cleaner_shader_hex`). This array is the binary
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

Subject references gfx9, should say gfx11.  With that fixed, plus the
other things I discussed with you, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  18 +++
>  .../amd/amdgpu/gfx_v11_0_3_cleaner_shader.asm | 118 ++++++++++++++++++
>  .../drm/amd/amdgpu/gfx_v11_0_cleaner_shader.h |  56 +++++++++
>  3 files changed, 192 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3_cleaner_shader=
.asm
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_cleaner_shader.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 5aff8f72de9c..ce05b7161e9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -46,6 +46,7 @@
>  #include "clearstate_gfx11.h"
>  #include "v11_structs.h"
>  #include "gfx_v11_0.h"
> +#include "gfx_v11_0_cleaner_shader.h"
>  #include "gfx_v11_0_3.h"
>  #include "nbio_v4_3.h"
>  #include "mes_v11_0.h"
> @@ -1545,6 +1546,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         int i, j, k, r, ring_id =3D 0;
>         int xcc_id =3D 0;
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       u32 mes_ver =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MASK=
;
>
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(11, 0, 0):
> @@ -1588,8 +1590,24 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>         }
>
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       case IP_VERSION(11, 0, 3):
> +               adev->gfx.cleaner_shader_ptr =3D gfx_11_0_3_cleaner_shade=
r_hex;
> +               adev->gfx.cleaner_shader_size =3D sizeof(gfx_11_0_3_clean=
er_shader_hex);
> +               if (adev->gfx.mec_fw_version >=3D 2450 &&
> +                   adev->gfx.me_fw_version  >=3D 2280 &&
> +                   adev->gfx.pfp_fw_version >=3D 2370 &&
> +                   mes_ver >=3D 99) {
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
> +               break;
>         }
>
>         /* Enable CG flag in one VF mode for enabling RLC safe mode enter=
/exit */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3_cleaner_shader.asm b/=
drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3_cleaner_shader.asm
> new file mode 100644
> index 000000000000..3c0c63a07d97
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3_cleaner_shader.asm
> @@ -0,0 +1,118 @@
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
> +// Navi3 : Clear SGPRs, VGPRs and LDS
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
> +shader main
> +  asic(NAVI31)
> +  type(CS)
> +  wave_size(32)
> +// Note: original source code from Brian (SQ team)
> +
> +// Takes about 2500 clocks to run.
> +//   (theorhetical fastest =3D 1024clks vgpr + 640lds =3D 1660 clks)
> +//
> +  S_BARRIER
> +
> +  //
> +  // CLEAR VGPRs
> +  //
> +  s_mov_b32     m0, 0x00000058  // Loop 96/8=3D12 times  (loop unrolled =
for performance)
> +
> +label_0005:
> +  v_movreld_b32     v0, 0
> +  v_movreld_b32     v1, 0
> +  v_movreld_b32     v2, 0
> +  v_movreld_b32     v3, 0
> +  v_movreld_b32     v4, 0
> +  v_movreld_b32     v5, 0
> +  v_movreld_b32     v6, 0
> +  v_movreld_b32     v7, 0
> +  s_sub_u32     m0, m0, 8
> +  s_cbranch_scc0  label_0005
> +  //
> +  //
> +
> +  s_mov_b32     s2, 0x80000000                      // Bit31 is first_wa=
ve
> +  s_and_b32     s2, s2, s0                          // sgpr0 has tg_size=
 (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
> +  s_cbranch_scc0  label_0023                        // Clean LDS if its =
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
> +  s_mov_b64 vcc, 0          //clear vcc
> +  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
> +  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_cleaner_shader.h b/driv=
ers/gpu/drm/amd/amdgpu/gfx_v11_0_cleaner_shader.h
> new file mode 100644
> index 000000000000..3218cc04f543
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_cleaner_shader.h
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
> +/* Define the cleaner shader gfx_11_0_3 */
> +static const u32 gfx_11_0_3_cleaner_shader_hex[] =3D {
> +       0xb0804006, 0xbe8200ff,
> +       0x00000058, 0xbefd0080,
> +       0x7e008480, 0x7e028480,
> +       0x7e048480, 0x7e068480,
> +       0x7e088480, 0x7e0a8480,
> +       0x7e0c8480, 0x7e0e8480,
> +       0xbefd0002, 0x80828802,
> +       0xbfa1fff5, 0xbe8200ff,
> +       0x80000000, 0x8b020002,
> +       0xbfa10012, 0xbefe00c1,
> +       0xbeff00c1, 0xd71f0001,
> +       0x0001007f, 0xd7200001,
> +       0x0002027e, 0x16020288,
> +       0xbe8200bf, 0xbefd00c1,
> +       0xd9382000, 0x00020201,
> +       0xd9386040, 0x00040401,
> +       0xd7006a01, 0x000202ff,
> +       0x00000400, 0x80828102,
> +       0xbfa1fff7, 0xbefd00ff,
> +       0x00000068, 0xbe804280,
> +       0xbe814280, 0xbe824280,
> +       0xbe834280, 0x80fd847d,
> +       0xbfa1fffa, 0xbeea0180,
> +       0xbeec0180, 0xbeee0180,
> +       0xbef00180, 0xbef20180,
> +       0xbef40180, 0xbef60180,
> +       0xbef80180, 0xbefa0180,
> +       0xbfb00000, 0xbf9f0000,
> +       0xbf9f0000, 0xbf9f0000,
> +       0xbf9f0000, 0xbf9f0000,
> +};
> --
> 2.34.1
>
