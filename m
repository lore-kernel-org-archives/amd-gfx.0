Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48545C7EE29
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 18:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED65C10E729;
	Thu, 25 May 2023 18:01:50 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DFD10E729
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 18:01:48 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-396140d25e0so919260b6e.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685037707; x=1687629707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjQxouwT2zUIS21AB1nedRkcQFIgEAte6B/Z57cMBeU=;
 b=h5lRG6DsIcXETr9pzeMaykth11AlDMjbuqlsCYomwN3jjpdH1QUn2POjgnQ0o/yjRv
 sq99qb6ZGjdQTrTXRrk492WaOClw4QXacBnshFT+AAIFW09Nv6CgoyR+kfzxrNRmY0Cb
 LE59c7fttG3GsFOu2Iufh96HO6kfk9R+FvZmDzYerDMXIh5vfJEtl6ciNFJFfddX+I+3
 TyXPMAvgjc5aw6uyzpdhbVvyiTdFpZdoKrp497iVrAKD8yr+MNt9sOD0RcarxWFJXOC2
 4g6ltZ1VxD19MmlSVPwuDkJBBGyub8xdBf+eJwgqNxnpRZZaxuhgFn2k74P9IprJ5GBE
 XhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685037707; x=1687629707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjQxouwT2zUIS21AB1nedRkcQFIgEAte6B/Z57cMBeU=;
 b=YnBGGyyL5Fei2reLMLKRQkVRorvhBZZkXBPjyqNNGC4FXw2jlwKejQrO8H/QJSDnNU
 VOa5LOdPiERmnGzt9O32oHKmv2vUB+yJDsF8mxwe+S+Vf93msCtniHPUtHVzUr8gflW/
 TP22a7TDf4S+RC0/WE1nHxtUbzC+V0DTfJaMONUh6f/MMb0D7n1gy9CHtkU7Mdy+IDbV
 cT6ii6OIEv9lDPePZuZSwiJi0XB/7O0KzQK/haBW6HqB+7KHfvwE/6ATjdNs85TFDUtW
 xtDlP1M06oUe0w364D/N87ZuUagi01IEpsKxyx3LXIF6qBrH4/v9Zd9xXK0oJYjqvhcB
 kpEg==
X-Gm-Message-State: AC+VfDyhQOhGm9GZexx/m/5+wUXTOLF7ZeLmbf7z1ufydu5pfQ+5LT50
 h9u8jApraNMgOjdsmXmkWYerL2Vx6GTKm9708N0=
X-Google-Smtp-Source: ACHHUZ7EoRZam/YR82nOEVDeC4dqpT1enR7F7yfYr8cHJUmv9A21TWduY5/3SzImzFnuQMTwKii9x39fIOpHMPBBNcg=
X-Received: by 2002:aca:1c0e:0:b0:387:210a:6f47 with SMTP id
 c14-20020aca1c0e000000b00387210a6f47mr124464oic.21.1685037707102; Thu, 25 May
 2023 11:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230525170816.790790-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230525170816.790790-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 May 2023 14:01:35 -0400
Message-ID: <CADnq5_OnGV=_wg9_6wF5hbH0D_o5UDidG4rCfqCTXD4XEByC4A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix up kdoc in sdma_v4_4_2.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 25, 2023 at 1:08=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Address a bunch of kdoc warnings:
>
> gcc with W=3D1
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:426: warning: Function parameter=
 or member 'inst_mask' not described in 'sdma_v4_4_2_inst_gfx_stop'
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:457: warning: Function parameter=
 or member 'inst_mask' not described in 'sdma_v4_4_2_inst_rlc_stop'
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:470: warning: Function parameter=
 or member 'inst_mask' not described in 'sdma_v4_4_2_inst_page_stop'
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:506: warning: Function parameter=
 or member 'inst_mask' not described in 'sdma_v4_4_2_inst_ctx_switch_enable=
'
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:794: warning: Function parameter=
 or member 'inst_mask' not described in 'sdma_v4_4_2_inst_rlc_resume'
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:810: warning: Function parameter=
 or member 'inst_mask' not described in 'sdma_v4_4_2_inst_load_microcode'
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:854: warning: Function parameter=
 or member 'inst_mask' not described in 'sdma_v4_4_2_inst_start'

I thought someone already landed a patch for this.  If not,

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index ff41fb577cdd..8eebf9c2bbcd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -418,6 +418,7 @@ static void sdma_v4_4_2_ring_emit_fence(struct amdgpu=
_ring *ring, u64 addr, u64
>   * sdma_v4_4_2_inst_gfx_stop - stop the gfx async dma engines
>   *
>   * @adev: amdgpu_device pointer
> + * @inst_mask: mask of dma engine instances to be disabled
>   *
>   * Stop the gfx async dma ring buffers.
>   */
> @@ -449,6 +450,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_d=
evice *adev,
>   * sdma_v4_4_2_inst_rlc_stop - stop the compute async dma engines
>   *
>   * @adev: amdgpu_device pointer
> + * @inst_mask: mask of dma engine instances to be disabled
>   *
>   * Stop the compute async dma queues.
>   */
> @@ -462,6 +464,7 @@ static void sdma_v4_4_2_inst_rlc_stop(struct amdgpu_d=
evice *adev,
>   * sdma_v4_4_2_inst_page_stop - stop the page async dma engines
>   *
>   * @adev: amdgpu_device pointer
> + * @inst_mask: mask of dma engine instances to be disabled
>   *
>   * Stop the page async dma ring buffers.
>   */
> @@ -498,6 +501,7 @@ static void sdma_v4_4_2_inst_page_stop(struct amdgpu_=
device *adev,
>   *
>   * @adev: amdgpu_device pointer
>   * @enable: enable/disable the DMA MEs context switch.
> + * @inst_mask: mask of dma engine instances to be enabled
>   *
>   * Halt or unhalt the async dma engines context switch.
>   */
> @@ -785,6 +789,7 @@ static void sdma_v4_4_2_init_pg(struct amdgpu_device =
*adev)
>   * sdma_v4_4_2_inst_rlc_resume - setup and start the async dma engines
>   *
>   * @adev: amdgpu_device pointer
> + * @inst_mask: mask of dma engine instances to be enabled
>   *
>   * Set up the compute DMA queues and enable them.
>   * Returns 0 for success, error for failure.
> @@ -801,6 +806,7 @@ static int sdma_v4_4_2_inst_rlc_resume(struct amdgpu_=
device *adev,
>   * sdma_v4_4_2_inst_load_microcode - load the sDMA ME ucode
>   *
>   * @adev: amdgpu_device pointer
> + * @inst_mask: mask of dma engine instances to be enabled
>   *
>   * Loads the sDMA0/1 ucode.
>   * Returns 0 for success, -EINVAL if the ucode is not available.
> @@ -845,6 +851,7 @@ static int sdma_v4_4_2_inst_load_microcode(struct amd=
gpu_device *adev,
>   * sdma_v4_4_2_inst_start - setup and start the async dma engines
>   *
>   * @adev: amdgpu_device pointer
> + * @inst_mask: mask of dma engine instances to be enabled
>   *
>   * Set up the DMA engines and enable them.
>   * Returns 0 for success, error for failure.
> --
> 2.25.1
>
