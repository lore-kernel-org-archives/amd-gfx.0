Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8B8C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 14:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0624410E3BB;
	Mon, 16 Jun 2025 14:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ng9eKcZ0";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA82C10E3BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 14:58:43 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b26fabda6d9so619471a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750085923; x=1750690723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgWbaIbOwH8kD8zcFFssBG2xEoLhWgMmSgc45XkRTxg=;
 b=Ng9eKcZ0O2rlElA7byMtyETK0m+1eLV0ZXr2TaLsdXDqKzkLoS5o+XjeLfzmJ0r5IG
 yvcpime0S09mApTqyIAos6BUXULf5fea6DXrFHs/u2pXbjTE4qh/l+ukf4L+B0F+QPrn
 CeAJlZXVDR9RXObvfIVm4E9x71a0gFz1jK0a35jogI0IPgQXzrvwjvWFz+lB9zsEYf5F
 RWJVQMqmLdNcvtq++OrJF5in9bpNltaQIP8D0tBAQ/NHi6CFW2tEnc7+XZkZ1Gb9aUoF
 3CrUmL7aPo794U+gP7qjmqefKNTJWKQ+JNyjgbW9bHsWNNfZqAqCVybK3AVtpnzmZ6DG
 ZmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750085923; x=1750690723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgWbaIbOwH8kD8zcFFssBG2xEoLhWgMmSgc45XkRTxg=;
 b=Ub3IAR2a1/RAkA8cIuK4EnMS/d1BEmi4f7wxvnMpZS/2+miWKD4QVY//mv3Y0SBTE9
 /tOVTb+RP5MPyacdVqEPcDIuWbUy2UDDOYZ/hoSNxK1usbMAltl7JSrb1T2uHXmnOJqw
 km2yT5K1JyT1SFv4sfo7SG7kZXoJbOTNLotI6NA4jotrIZRHsx+kukwmeTTiGncRZKML
 VTetiXzxqkpCgmBkxBts1GroU7PpjL3viaHCjCdIWiC7rKNDmu7WTPD+Cf32iiejeXP1
 8p96g9Y61Et+WKnyMUoSrzvdF61qL/PC6q6GAKsDhPvWFvZtEFxb1h9I2t7cV/TIH2n5
 ehiw==
X-Gm-Message-State: AOJu0YyYvC8eEKWBsKUNg6/rn09crLxu6wWe9VI7HrddK/ty10wm6PJK
 oWyasOPCAtf7iuk1T2qlMVjLPGli18GXScRkXltv230p1NsHaX5zhcG/GHT/7O6uz3EyymOD2ng
 rNaW0Ei9FYxzIxULsEVshOUtNhzeMfev91kbm
X-Gm-Gg: ASbGncvzSIttzw6u/4Dqsc+SjzHyffPtIEttqDmGD1r2WZikBrrGto5zyi1SbGs1cBJ
 fskDbajDpqO1Ww4q7hxAc3/AP8VvSCxXtVODj+HH1rF+Qejakfw9Fof/9xMIdUECwSeNcCCBRlA
 8zaCcWd1dsV6dpmK6O8X+Al8CpNKNYH5nxCUDb89AXbAHT
X-Google-Smtp-Source: AGHT+IGeNyuSV3YPBJqTemyUOvmWknj2wpqszDrcK6S2wDWT/V3Fbkkc4OPqOuLvCvN08XvMDaLE0gNzeJaVE+nGLXM=
X-Received: by 2002:a17:90b:274d:b0:311:488:f506 with SMTP id
 98e67ed59e1d1-313f1ce1d3amr5644487a91.6.1750085923015; Mon, 16 Jun 2025
 07:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250616144030.3497914-1-jesse.zhang@amd.com>
In-Reply-To: <20250616144030.3497914-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jun 2025 10:58:31 -0400
X-Gm-Features: AX0GCFsyWo_W5-YPq-tU42Iaoi-EPALgAjbM10BThFYpzR2-JoBxN4Zw7mWkyao
Message-ID: <CADnq5_OpAaiBZaxU6RxNRvY3wcpz5WhDzX1iscuUnsu7gebrhg@mail.gmail.com>
Subject: Re: [PATCH V2] drm/amdgpu: Fix SDMA UTC_L1 handling during start/stop
 sequences
To: Jesse Zhang <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>
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

On Mon, Jun 16, 2025 at 10:47=E2=80=AFAM Jesse Zhang <jesse.zhang@amd.com> =
wrote:
>
> This commit makes two key fixes to SDMA v4.4.2 handling:
>
> 1. disable UTC_L1 in sdma_cntl register when stopping SDMA engines
>    by reading the current value before modifying UTC_L1_ENABLE bit.
>
> 2. Ensure UTC_L1_ENABLE is consistently managed by:
>    - Adding the missing register write when enabling UTC_L1 during start
>    - Keeping UTC_L1 enabled by default as per hardware requirements
>
> Fixes the commit 7f03b1d14d51 ("drm/amdgpu:
> Remove sdma halt/unhalt during frontdoor load") by maintaining proper
> SDMA controller state during initialization sequences.

Proper fixes tag formatting:

Fixes: 7f03b1d14d51 ("drm/amdgpu: Remove sdma halt/unhalt during
frontdoor load")

>
> v2: Correct SDMA_CNTL setting (Philip)
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index e6af50c947a1..52157acab55a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -492,7 +492,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_d=
evice *adev,
>  {
>         struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
>         u32 doorbell_offset, doorbell;
> -       u32 rb_cntl, ib_cntl;
> +       u32 rb_cntl, ib_cntl, sdma_cntl;
>         int i;
>
>         for_each_inst(i, inst_mask) {
> @@ -504,6 +504,9 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_d=
evice *adev,
>                 ib_cntl =3D RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
>                 ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_E=
NABLE, 0);
>                 WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
> +               sdma_cntl =3D RREG32_SDMA(i, SDMA_CNTL);
> +               sdma_cntl =3D REG_SET_FIELD(sdma_cntl, SDMA_CNTL, UTC_L1_=
ENABLE, 0);
> +               WREG32_SDMA(i, regSDMA_CNTL, sdma_cntl);
>
>                 if (sdma[i]->use_doorbell) {
>                         doorbell =3D RREG32_SDMA(i, regSDMA_GFX_DOORBELL)=
;
> @@ -997,6 +1000,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_devi=
ce *adev,
>                 /* set utc l1 enable flag always to 1 */
>                 temp =3D RREG32_SDMA(i, regSDMA_CNTL);
>                 temp =3D REG_SET_FIELD(temp, SDMA_CNTL, UTC_L1_ENABLE, 1)=
;
> +               WREG32_SDMA(i, regSDMA_CNTL, temp);
>
>                 if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) < IP_VERSION(4=
, 4, 5)) {
>                         /* enable context empty interrupt during initiali=
zation */
> --
> 2.34.1
>
