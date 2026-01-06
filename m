Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7B9CE9D79
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 16:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FDF710E054;
	Tue,  6 Jan 2026 16:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CXzFwDEe";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2BB10E526
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 16:26:47 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-121a15dacd1so39410c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jan 2026 08:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767716806; x=1768321606; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AG9L4ZWEdmUjgKxr7cq0dXKpvZsFkz5w7ptgld1wYxg=;
 b=CXzFwDEeX4o5AYQrwsQQcx8eBKvoZ37Vqypr/dxHSGqT/HdHb/CtUUnmwMBXSetqyz
 8M9Cvs3OJeczQ29nsbVlU+IOS8to1oL0q+n62+EtkeTRyIENOTVWloMsBJmYRLarBqfl
 8UTciulXu0UAfYdN0LcFH0qvjYfFFrkp+56XzwPX/Bt4MvrzyCahKBD+tp/tPDxV9AgP
 yIbRBtOVfHcsTgGSf7EbKwSaqsqIpZ4teM0awrlJ6DGAynP2Xs+R0g3CUUSr+uJ/8huC
 LF0XisoSNN2Ydx+NJe7EEEJqCWBVIc7ZXjJF2s5JfG8RFLsY/Y2P/dVBZf4AM9tLBs2e
 biTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767716806; x=1768321606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AG9L4ZWEdmUjgKxr7cq0dXKpvZsFkz5w7ptgld1wYxg=;
 b=AyuNTvO33AizLYixQAdglqb384XCvGKLGlGphPfKrRuQAcRnxWQ1weLVBLPg/IS9bK
 TeBNWt3iie9YRbyHJJHehpPi1PLt6vltN1HLgJkr4CitrVkidu2aA6qIlG4gshsw4+iC
 plkqZWd275IgR46fsTNxaJXJHy+8z+qDCJQFHsYBBtBQDNg+tjKB90eTbgooO+aORDvK
 QTqN+SCMSVJKRccEtFtI/BS1rxNHiEqu6qTHtpD1sf67dQDasYTDJZbGSOrV/sMEfthh
 8CYnjIiZrrwgHe9Tk6ltvrbH3Nz6Pc3OsbnJeBe/TQki+gj6wDdsAqMuAR07uK27jXoz
 g56A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtG3XXtDXKbp+PuQQ9NngVV3o/nmzCJOlxLwUZrJpNJv1IfEmQ/HoQfSLUzmRALP/lSJyJjvHv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywbo5LRfiPrYFKhHR2Qa2q7OOLCbpoG7sYVaD8YhtdbdTFs1wLF
 0nAajQFcA4nmVvhejB6/yViYdwmf9y5FV25+3/HYshwEz22ewIcdjuZx/joMkt3GXJ49n6J9c6i
 RpLlEfsa32OGp1CgLKZOlEWgePLd2zUI=
X-Gm-Gg: AY/fxX78mU6/z/wq7bOtemUQHpGqzhpuLsPBK5F35qN2zjrj73Zcy6EceYefxSYEl6q
 q5I18yo8nPpsbKkDKjqzp4HmeURksAH+2Ydk/+GURRmjqqfFwEPIJLiFL99aGILBpNAQ3CRIWFi
 B8LRbhtnoSpCHJjXly/gApdDj9mE72D77z59+MyhY056hWZLSmmzzW7VqhBBqCG2l/i4EzNJ/kV
 QKf344yDC39k3wR34mxF0b2HL1cKp97SbGeTGrkoJz3UskqWh0tMS6hwQhA41tp8BoyVuGy
X-Google-Smtp-Source: AGHT+IHIac84RfHA+TIKRHgbh75XFCdFgfYv2yl5WN9oEksNcVxI1vlkL4CK+saPHUSICa+XcCg0P25jvNseELu7qKc=
X-Received: by 2002:a05:7022:62b:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-121f18a2c70mr1735957c88.1.1767716806383; Tue, 06 Jan 2026
 08:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20260106125929.25214-3-sunlightlinux@gmail.com>
 <20260106125929.25214-6-sunlightlinux@gmail.com>
In-Reply-To: <20260106125929.25214-6-sunlightlinux@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Jan 2026 11:26:33 -0500
X-Gm-Features: AQt7F2o4rSn2VdQBavi2YtVjakztHrrwk3TGdqKgLsWoUmoZFr7fLjtaNWrSelI
Message-ID: <CADnq5_OXJnREtCUhyq4JWjKmih=k7hnc4w_y8mNd3J1g437V8Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix TLB flush failures after hibernation
 resume
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mario Limonciello <superm1@kernel.org>, Ionut Nechita <ionut_n2001@yahoo.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Tue, Jan 6, 2026 at 9:16=E2=80=AFAM Ionut Nechita (Sunlight Linux)
<sunlightlinux@gmail.com> wrote:
>
> From: Ionut Nechita <ionut_n2001@yahoo.com>
>
> After resume from hibernation, the amdgpu driver experiences TLB
> flush failures with errors:
>
>   amdgpu: TLB flush failed for PASID xxxxx
>   amdgpu: failed to write reg 28b4 wait reg 28c6
>   amdgpu: failed to write reg 1a6f4 wait reg 1a706
>
> Root Cause:
> -----------
> The KIQ (Kernel Interface Queue) ring is marked as ready
> (ring.sched.ready =3D true) during resume, but the hardware is not
> fully functional yet. When TLB invalidation attempts to use KIQ
> for register access, the commands fail because the GPU hasn't
> completed initialization.
>
> Solution:
> ---------
> 1. Add resume_gpu_stable flag (initially false on resume)
> 2. Force TLB invalidation to use direct MMIO path instead of KIQ
>    when resume_gpu_stable is false
> 3. After ring tests pass in gfx_v9_0_cp_resume(), set
>    resume_gpu_stable to true
> 4. From that point forward, use faster KIQ path for TLB invalidation
>
> This ensures TLB flushes work correctly during early resume while
> still benefiting from KIQ-based invalidation after the GPU is stable.
>
> Changes:
> --------
> - amdgpu.h: Add resume_gpu_stable flag to amdgpu_device
> - amdgpu_device.c: Initialize resume_gpu_stable to false on resume
> - amdgpu_gmc.c: Check resume_gpu_stable in flush_gpu_tlb_pasid
> - gfx_v9_0.c: Set resume_gpu_stable after ring tests pass
> - gmc_v9_0.c: Check resume_gpu_stable before using KIQ path
>
> Tested on AMD Cezanne (Renoir) with ROCm workloads after hibernation.
> Result: Eliminates TLB flush failures on resume.
>
> Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 10 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  6 +++++-
>  5 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 9f9774f58ce1c..6bf4f6c90164c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1225,6 +1225,7 @@ struct amdgpu_device {
>         bool                            in_s4;
>         bool                            in_s0ix;
>         suspend_state_t                 last_suspend_state;
> +       bool                            resume_gpu_stable;
>
>         enum pp_mp1_state               mp1_state;
>         struct amdgpu_doorbell_index doorbell_index;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 12201b8e99b3f..440d86ed1e0d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5457,6 +5457,12 @@ int amdgpu_device_resume(struct drm_device *dev, b=
ool notify_clients)
>                 goto exit;
>         }
>
> +       /*
> +        * Set resume_gpu_stable to false BEFORE KFD resume to ensure
> +        * extended timeouts are used for TLB flushes during hibernation =
recovery
> +        */
> +       adev->resume_gpu_stable =3D false;

This change disables TLB flushes via KIQ permanently.  This is called
after gfx_v9_0_cp_resume() so resume_gpu_stable is only set to true
between the calls to amdgpu_device_ip_resume() and here.

kiq sched.ready should be handled correctly.  kiq sched.ready gets set
to false in suspend via:

gfx_v9_0_suspend() -> gfx_v9_0_hw_fini() -> gfx_v9_0_cp_enable()

Then on resume, kiq sched.ready gets set to true again via:

gfx_v9_0_resume() -> gfx_v9_0_hw_init() -> gfx_v9_0_cp_resume() ->
gfx_v9_0_kcq_resume() -> amdgpu_gfx_enable_kcq() ->
amdgpu_ring_test_helper()

At that point the KIQ hardware is ready. If it weren't, then the above
sequence would not have worked.  The gfx and compute ring tests are
irrelevant.

Alex

> +
>         r =3D amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev-=
>in_runpm);
>         if (r)
>                 goto exit;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 869bceb0fe2c6..83fe30f0ada75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -731,7 +731,12 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_dev=
ice *adev, uint16_t pasid,
>         if (!down_read_trylock(&adev->reset_domain->sem))
>                 return 0;
>
> -       if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
> +       /*
> +        * After hibernation resume, KIQ may report as ready but not be f=
ully
> +        * functional. Use direct MMIO path until GPU is confirmed stable=
.
> +        */
> +       if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
> +           !adev->resume_gpu_stable) {
>                 if (adev->gmc.flush_tlb_needs_extra_type_2)
>                         adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pa=
sid,
>                                                                  2, all_h=
ub,
> @@ -835,9 +840,9 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_d=
evice *adev,
>                 goto failed_kiq;
>
>         might_sleep();
> +
>         while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
>                !amdgpu_reset_pending(adev->reset_domain)) {
> -
>                 msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
>                 r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WA=
IT);
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 0148d7ff34d99..fbd07b455b915 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3985,6 +3985,16 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device=
 *adev)
>                 amdgpu_ring_test_helper(ring);
>         }
>
> +       /*
> +        * After successful ring tests, mark GPU as stable for resume.
> +        * This allows KIQ-based TLB invalidation to be used instead of
> +        * slower direct MMIO path.
> +        */
> +       if (!adev->resume_gpu_stable) {
> +               adev->resume_gpu_stable =3D true;
> +               dev_info(adev->dev, "GPU rings verified, enabling KIQ pat=
h\n");
> +       }
> +
>         gfx_v9_0_enable_gui_idle_interrupt(adev, true);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 8ad7519f7b581..8a0202f6b3e3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -855,9 +855,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>
>         /* This is necessary for SRIOV as well as for GFXOFF to function
>          * properly under bare metal
> +        *
> +        * After hibernation resume, KIQ may report as ready but not be f=
ully
> +        * functional. Use direct MMIO path until GPU is confirmed stable=
.
>          */
>         if (adev->gfx.kiq[inst].ring.sched.ready &&
> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> +           adev->resume_gpu_stable) {
>                 uint32_t req =3D hub->vm_inv_eng0_req + hub->eng_distance=
 * eng;
>                 uint32_t ack =3D hub->vm_inv_eng0_ack + hub->eng_distance=
 * eng;
>
> --
> 2.52.0
>
