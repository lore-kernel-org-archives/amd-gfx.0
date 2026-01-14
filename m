Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CE3D39013
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A9B110E690;
	Wed, 14 Jan 2026 20:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OLQrTWWW";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 731EA10E695
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:48:03 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12336c0ae91so22207c88.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 12:48:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768423683; cv=none;
 d=google.com; s=arc-20240605;
 b=UPk8cbD4T3DjpZqbHsH/ikijYdZ9MJORQtHEbLo9+08IkefDDL2rbw+66hwBD+yLJp
 RD/DxfmWeJ86UNjdf/O4+Vd1kYMEH1e4iNStG3oDZtl7xO9S0JS+WqJmQFmfQEnaMIZC
 Reu6O0syZkENAK/Vlau6WXhgB30MAjHu3d1qQrccY+W1uXhF/spt07XLLRxV8ak1NJDI
 TxkUHqwXzNditRB3SpbdQo6ElEBu68lvTtX7b+8N7iTwsmJC4xENYmziKiyDvkf13m+C
 9ImSZzHgVoUZypZG/gQK6HMbUkpCUjkTaXvfsyp9eK1Wg52VToimIDdLzJFt9sPYY5Ci
 40dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LDy1PXIQMXMdMyCw3ajqHr4m61fgVqIDMcV+IKkV6dY=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=h2dU4KeXSZw9mAvbOPV0s7K6dolPzZmnimuNtPQSXXqu/DEqZyIAyuPq0mH1SfVgVT
 WQCuShtGP4bsmihZq/1bVHbDx5ro43XFkmLQuNs8ktPK4e9vAfwz22ulnhImidKC96hd
 2LM6hcj962KcJLbC3V7dzcqzHIZKUDm5MhnIbF+x+U559pttkVzEU/X7AfUSfOV2aJ/1
 6tYLWEbUPIW7Xev81Wfnh7Kr2+wtsDsZ7v9io/xouHIW6WRFzsDQ1AnlQHjuG9I2ipEO
 H90oVBE/bnpf3RWX5LIOuPc2m63q0IJH85CNGeai0hxjP9m02fiTKxAoCEqcZQ2SEzZR
 8qIw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768423683; x=1769028483; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDy1PXIQMXMdMyCw3ajqHr4m61fgVqIDMcV+IKkV6dY=;
 b=OLQrTWWWiFKicBfzBuWSXzm91yrFjsvPSvxHhnrveOpjs5ECwHO1G3Hl+GOzsU+O6J
 sk2xwHtl7ka+Y2d3+2Rgu8DRmxfyXs5V3fjsAUFhYsvDnhAqTr+CSbVrvB1/iFa65mIP
 V4IhyKKu5AiKtZUh/Laq72/rxNLWHVhD+4Cd/ui9Bf0QWght8mfkjsrQz4A48PLkd0XM
 jFNHBZclVCqbNivmAm/if8WkhUDYfPa69GJ9Egf23ZaAUzkS39NcFSyyD5ebUH9QDDft
 Bj0/EHBGqWc1kCk+ydMGTemjQxerzyBmL8PdDktSy+P1WTnHblhz2SF4dyxPPtOYNlTW
 6u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768423683; x=1769028483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LDy1PXIQMXMdMyCw3ajqHr4m61fgVqIDMcV+IKkV6dY=;
 b=keqS0YNScP11ifyrryPr/wXdT7AQUFgBNcRM24XfpfJzqqzgfA90k+tR+LVkCmvD/f
 WnYHYsPwnYYF9Nk/2LAKSvPFCosep5yvI+CZ29e+ju2GzyoPkcepVKxTW6rO0YTO0HeS
 Td4jUq/b/qBRVDQnJ3ynHj1noZQaOxahiPHWE3JiCNurb8TGOFotBCAuAQLCmjXYx7UM
 Rnbp+W0dVVVAa9ZBZWexqK/ipTALd/4vE3pT+ifSBATeXtJHLDzQBhV56LnP5vC46nQF
 C97VbWTUlIZ+vMTFa41RpwlMkIwxaRqS+v5g0br4ox03nUWNJZ1sfORIp3T9B7StYX8d
 iOdw==
X-Gm-Message-State: AOJu0Yyj/SCWjMtuioptVfRrqMywix9VyQm7ukpfbvYZp8+G3FTxoA0x
 0qC+7DBsHFNYuHOoXNKSVpw9XAccr47435YoLszQJRZPARYuMXyAQD0Sso5BoXwWhHziI4PGZZl
 cObJOrsMQl5DbVxE3Ex7yYv6S6Oc0w80=
X-Gm-Gg: AY/fxX7Hd7ABHSjRlVwjDqvfggcvjp16rdvKP5HQqQMrrvDS/2ztMaXVz0uPemkuOQz
 47XaWJd5s2EIn8FTZ5KyhGZSJArgecFijy2muLsHVwzaNY4nXVVk9kF4IgE96coghEpA275wXtw
 KBin02udSzG84L+69qqsyJKxTLMQbeSwCDM2djq82C9Y72cr7X7n+Jt9aWZkPT1suJXO5jLL2Qz
 OkLh4RgOs566u1Uh3X0+5nVx67esXflxLxqgUdDGvRB74siH9Ud7pmGSPoGqe2errfaXF5I
X-Received: by 2002:a05:7022:150c:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-12336aa506emr2507130c88.7.1768423682566; Wed, 14 Jan 2026
 12:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20260114164727.15367-1-alexander.deucher@amd.com>
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Jan 2026 15:47:50 -0500
X-Gm-Features: AZwV_QjpTHmhfJcsZLqU5XSjlC_kTJpTot0Rsk11TUJSgvNZ9v_ND_VW9LfcbR0
Message-ID: <CADnq5_M+fyhPgV9OY7=Ftb1pmbpVg7KdAvZrJ3GuVOu1Kr3e5w@mail.gmail.com>
Subject: Re: [PATCH 00/42] Improvements for IB handling V2
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Wed, Jan 14, 2026 at 11:47=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> This set contains a number of bug fixes and cleanups for
> IB handling that I worked on over the holidays.  The first
> the patches from V1 are already reviewed, so I didn't include
> them in V2.
>
> Patches 1-24:
> Removes the direct submit path for IBs and requires
> that all IB submissions use a job structure.  This
> greatly simplifies the IB submission code. V2 uses
> GFP_ATOMIC when in reset.
>
> Patches 26-42:
> Split IB state setup and ring emission.  This keeps all
> of the IB state in the job.  This greatly simplifies
> re-emission of non-timed-out jobs after a ring reset and
> allows for re-emission multiple times if multiple resets
> happen in a row.  It also properly handles the dma fence
> error handling for timedout jobs with adapter resets.
> V2 fixes the set_q handling by saving the ring state in
> the job and redetermining the offsets as the packet
> stream is replayed.  Jobs whose IBs are skipped still
> handle the set_q state properly so the re-emitted packet
> streams are always coherent.

Also available here:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/ib_improvements?ref_ty=
pe=3Dheads

Alex

>
> Alex Deucher (42):
>   drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
>   drm/amdgpu/vpe: switch to using job for IBs
>   drm/amdgpu/gfx6: switch to using job for IBs
>   drm/amdgpu/gfx7: switch to using job for IBs
>   drm/amdgpu/gfx8: switch to using job for IBs
>   drm/amdgpu/gfx9: switch to using job for IBs
>   drm/amdgpu/gfx9.4.2: switch to using job for IBs
>   drm/amdgpu/gfx9.4.3: switch to using job for IBs
>   drm/amdgpu/gfx10: switch to using job for IBs
>   drm/amdgpu/gfx11: switch to using job for IBs
>   drm/amdgpu/gfx12: switch to using job for IBs
>   drm/amdgpu/gfx12.1: switch to using job for IBs
>   drm/amdgpu/si_dma: switch to using job for IBs
>   drm/amdgpu/cik_sdma: switch to using job for IBs
>   drm/amdgpu/sdma2.4: switch to using job for IBs
>   drm/amdgpu/sdma3: switch to using job for IBs
>   drm/amdgpu/sdma4: switch to using job for IBs
>   drm/amdgpu/sdma4.4.2: switch to using job for IBs
>   drm/amdgpu/sdma5: switch to using job for IBs
>   drm/amdgpu/sdma5.2: switch to using job for IBs
>   drm/amdgpu/sdma6: switch to using job for IBs
>   drm/amdgpu/sdma7: switch to using job for IBs
>   drm/amdgpu/sdma7.1: switch to using job for IBs
>   drm/amdgpu: require a job to schedule an IB
>   drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
>   drm/amdgpu: mark fences with errors before ring reset
>   drm/amdgpu: don't call drm_sched_stop/start() in asic reset
>   drm/amdgpu: drop drm_sched_increase_karma()
>   drm/amdgpu: plumb timedout fence through to force completion
>   drm/amdgpu: simplify VCN reset helper
>   drm/amdgpu: change function signature for emit_pipeline_sync()
>   drm/amdgpu: drop extra parameter for vm_flush
>   drm/amdgpu: move need_ctx_switch into amdgpu_job
>   drm/amdgpu: store vm flush state in amdgpu_job
>   drm/amdgpu: split fence init and emit logic
>   drm/amdgpu: split vm flush and vm flush emit logic
>   drm/amdgpu: split ib schedule and ib emit logic
>   drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
>   drm/amdgpu: add an all_instance_rings_reset ring flag
>   drm/amdgpu: add helper to save and restore ring state
>   drm/amdgpu: rework reset reemit handling
>   drm/amdgpu: simplify per queue reset code
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 302 +++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  53 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  12 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  83 ++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  41 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c      |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  52 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 ++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 ++++-----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
>  drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
>  56 files changed, 1007 insertions(+), 993 deletions(-)
>
> --
> 2.52.0
>
