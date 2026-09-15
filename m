Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3D5C982C3
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 13:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E4E710E2CC;
	Tue, 15 Sep 2026 13:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h3M7X2SO";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E0A10E2CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 13:59:21 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396673bd283so798431a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 06:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789480761; cv=none;
 d=google.com; s=arc-20260327;
 b=OTinXLLdEVeIgf7SoZl6YCoMxBr/AFJAmAGP9LFxeIdKG+HOm2hzdk3pKwRvY+VGt+
 kOz4NwAMiB+diKlezz2BHY0OU8l1TwfUoaat9Ge6w3vnefcXfL026G5BpYGFyOOavvxL
 objLzr1ClDaysjCuC/uV5RBo/OiwZ/3Al5IizBY4HYUN4vGn1bZ6kjih9274Ho05blmP
 XRJDIsGizxv2eESZYTYXL86+M3jLNW3mUFS82L+28S4RZZOTWoHmU+IC2jz2OBETwQUI
 fiakwEC3aPb6LM6IAJJ7Ono9UywYFCSxLSCxuEvf9T3hxfrnzlGnXdLVIX9O42ykQaX3
 rX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d8JpxrsroPnvVBzr3wlJUhtToX0fPqhamyD94ZgvcsI=;
 fh=yhJ0bpBjc0n/45ODJUZ55iNKHQA8W3lzzuLjZlVKViY=;
 b=Yh81DRiYyIVk3smjeDHeYnjhawvuZjDdjJQ1MhwiLxOkDGJtbXVwqDUw9xTcs0x9l9
 STFtPBJljuDRdettVfn+TbOq6ZJ1OyE/eoeV+L4x5CpuOk2mTnCseA4Q2iS7mep0L0iB
 ve8P4LQ29FVTStpTu6JK2OSXbno2qLa/jBv6JCUGkV7UhxVlWCT5Afv2hLK3iaVvDO6/
 3gudPW0kmpNiSGAr1ZzxHU5OHxL4e3j1rPNXTCEkztif3vT92pN9/Ax+FeD1p14kmmT3
 ZDWUGleASa1zT1H4XQN5Z5ngxNdOmUNFmXXb1tIGMr3PIlUdo53gN50oqA9uxfyrHLpt
 vtUA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789480761; x=1790085561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d8JpxrsroPnvVBzr3wlJUhtToX0fPqhamyD94ZgvcsI=;
 b=h3M7X2SO8GjwcPWOEXZ6Ym4kF0MbwMgQ7I5HLZkNwcSZlJQ8/QcrRDmUUApGgu1SQ6
 W89+6yJYbA4kgh/F6ss7f2uQmAX3uA//IMjlCgni9JI0WT4GwSHUxdKBwF8VLaP/+bOv
 e44nYnYl7wTH/TxA0JemR8estQoMwCQVHwrSZTOLkjk9/S+zIrJTl16oNC8ABOEIYveA
 btc1to6EvLUFiFMxSJQXnz4G1KdN/DO4XFk322zaMFdFzLnQe5LMnrwFEJBwwELQa65k
 XFuqXo/YxxDyIHXXkFm/gAroB3gjcNWIMMIJXXjic3SEWuh8ErEM04pj+Igxy/wOQnYB
 N37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789480761; x=1790085561;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d8JpxrsroPnvVBzr3wlJUhtToX0fPqhamyD94ZgvcsI=;
 b=uewSWRt2+D3I8jI2C0NxhGowPRgcwZHtMOtetV8NEWCvB6p9pXLWtAgjJFA7yvvRZ/
 uyjBukzx2cA9GvJ4NsO+8eDoMfJOl2tSef55H+7F80nxw8K+7XW0qGAxLRXALVoRz9JF
 JGBtd5QBjvhnZ2SS4QoMa6rsiLzeLz87B4jL7UcaTuZ6To8gpsi+4mvyvvz9X1HjaMCA
 MZH0dS/0EnP2HNIv7d6+XbIbdqz7VgESWMxbxMg3rkcmn2mfv+mFhXfbDcs92tABKFUu
 bhLeINmujwjYYkjdgjfVgcju8GXtGdHEv96muhM+m6N9TzNFvEZLzK9r2I0haAxo33KR
 uUvQ==
X-Gm-Message-State: AFuF++npvVlUlzyzw3wy7+KM3O25FicTrfXLKC0HHVNE9gWq9D38wjER
 j2vNUOFjssJ6SWaXpGW7VyPl1IsZZi1XsCab7+3KZCa1Qrkd4jHelSVRRl+h9s+c1oLe09yi0H7
 /5sas2v9AJrDlGNkY9eO1BF/1qQUEEti01Q==
X-Gm-Gg: AYBFou0xmFp3xUtBasnXajQLWr3FRJck2j6ts97YHFRaG+oV/k3xkBXX8NJeXyEVVcc
 fwXHf4AvaGNDX4zl8ZBxd92N5d5iYQ4dVo+hdXBqIs+W16mzSFk+6xCL9qvRBo0UNdNsMKcffei
 P2SuYp6134a9IliiaNTzTk8EzbnoaLyQxq0uRH0UaYOnmUAd+isc0X73HGPVp7n4qPIwBsGt4Xs
 9fhZ9Nt+5jg+yGKsTMUsPQqQR9+RaLhEUKrvXuvCWg5rMxHIotjI1StgeuF3Dkxc0ntFnp9PoUg
 SjeNi1bEX8qrewYOH4dbZL+Yl8VyjxwVpfae3HJnGLDJE/t/Dr7nKxDmXxDopai46ZS4pJfgVh3
 BHFXpCSmmqQWMqOp6JKLq8aXdxkdhBiwMmH/VbBBn5M4=
X-Received: by 2002:a17:90b:2742:b0:39d:e1f2:3400 with SMTP id
 98e67ed59e1d1-39dec24fbedmr10057534a91.5.1789480760506; Tue, 15 Sep 2026
 06:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAF9RqJ7gJuo7NqR5HW3Z6_xQ29B8hq3Gvn8bLyLfFVD3Bvo4Mw@mail.gmail.com>
In-Reply-To: <CAF9RqJ7gJuo7NqR5HW3Z6_xQ29B8hq3Gvn8bLyLfFVD3Bvo4Mw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 09:59:07 -0400
X-Gm-Features: AcwNN1VMX9_pr6GaS9Zgg4LFHYZjGlx8biXYW0bUn4k0Go9xTnxCrLW1uqQg2Go
Message-ID: <CADnq5_OOOo36AyaDn7QF_5hQ2qPcyHT6EmM_A4Z+w1NQheP32A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: fix comment typos in amdgpu and radeon
To: Ruslan Vagner <rusya92266@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com
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

Applied.  Thanks!

On Tue, Sep 15, 2026 at 9:21=E2=80=AFAM Ruslan Vagner <rusya92266@gmail.com=
> wrote:
>
> Fix the spelling in comments. No functional change.
>
> Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c                       | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c                       | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h                       | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c             | 2 +-
>  .../amd/display/dc/dml2_0/dml21/dml21_translation_helper.c    | 2 +-
>  drivers/gpu/drm/radeon/radeon_fence.c                         | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index d53259a5b82f..acafa8c59cc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -532,7 +532,7 @@ static int amdgpu_ctx_query(struct amdgpu_device *ade=
v,
>         out->state.flags =3D 0x0;
>         out->state.hangs =3D 0x0;
>
> -       /* determine if a GPU reset has occured since the last call */
> +       /* determine if a GPU reset has occurred since the last call */
>         reset_counter =3D atomic_read(&adev->gpu_reset_counter);
>         /* TODO: this should ideally return NO, GUILTY, or INNOCENT. */
>         if (ctx->reset_counter_query =3D=3D reset_counter)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 8a2d64f0ebc3..f8be73e5fec9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -228,12 +228,12 @@ void amdgpu_pasid_free_delayed(struct dma_resv *res=
v,
>   */
>
>  /**
> - * amdgpu_vmid_had_gpu_reset - check if reset occured since last use
> + * amdgpu_vmid_had_gpu_reset - check if reset occurred since last use
>   *
>   * @adev: amdgpu_device pointer
>   * @id: VMID structure
>   *
> - * Check if GPU reset occured since last use of the VMID.
> + * Check if GPU reset occurred since last use of the VMID.
>   */
>  bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>                                struct amdgpu_vmid *id)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 44fe40f9e8df..57bd34981be0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -31,7 +31,7 @@
>  #define AMDGPU_PREAMBLE_IB_PRESENT          (1 << 0)
>  /* bit set means preamble IB is first presented in belonging context */
>  #define AMDGPU_PREAMBLE_IB_PRESENT_FIRST    (1 << 1)
> -/* bit set means context switch occured */
> +/* bit set means context switch occurred */
>  #define AMDGPU_HAVE_CTX_SWITCH              (1 << 2)
>  /* bit set means IB is preempted */
>  #define AMDGPU_IB_PREEMPTED                 (1 << 3)
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
> b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
> index 5bc3bc60a2ac..ebbe7900205e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
> @@ -46,7 +46,7 @@ static void dcn20_wait_for_vmid_ready(struct dcn20_vmid=
 *vmid)
>         /* According the hardware spec, we need to poll for the lowest
>          * bit of PAGE_TABLE_BASE_ADDR_LO32 =3D 1 any time a GPUVM
>          * context is updated. We can't use REG_WAIT here since we
> -        * don't have a seperate field to wait on.
> +        * don't have a separate field to wait on.
>          *
>          * TODO: Confirm timeout / poll interval with hardware team
>          */
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translatio=
n_helper.c
> b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
> index 1b0d55e2d7b0..1c9a3fe0f64c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helpe=
r.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helpe=
r.c
> @@ -977,7 +977,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const
> struct dc *in_dc, struct dc_s
>
>  void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx,
> struct dc_state *context)
>  {
> -       /* TODO these should be the max of active, svp prefetch and idle
> should be tracked seperately */
> +       /* TODO these should be the max of active, svp prefetch and idle
> should be tracked separately */
>         context->bw_ctx.bw.dcn.clk.dispclk_khz =3D
> in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.dispclk_khz;
>         context->bw_ctx.bw.dcn.clk.dcfclk_khz =3D
> in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.active.dcfclk_=
khz;
>         context->bw_ctx.bw.dcn.clk.dramclk_khz =3D
> in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.active.uclk_kh=
z;
> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c
> b/drivers/gpu/drm/radeon/radeon_fence.c
> index 299865569252..8e9402b8811b 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -191,7 +191,7 @@ static int
> radeon_fence_check_signaled(wait_queue_entry_t *wait,
>   * @ring: ring index the fence is associated with
>   *
>   * Checks the current fence value and calculates the last
> - * signalled fence value. Returns true if activity occured
> + * signalled fence value. Returns true if activity occurred
>   * on the ring, and the fence_queue should be waken up.
>   */
>  static bool radeon_fence_activity(struct radeon_device *rdev, int ring)
> @@ -262,7 +262,7 @@ static bool radeon_fence_activity(struct
> radeon_device *rdev, int ring)
>   * @work: delayed work item
>   *
>   * Checks for fence activity and if there is none probe
> - * the hardware if a lockup occured.
> + * the hardware if a lockup occurred.
>   */
>  static void radeon_fence_check_lockup(struct work_struct *work)
>  {
> --
> 2.54.0.windows.1
