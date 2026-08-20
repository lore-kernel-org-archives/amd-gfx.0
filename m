Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C31FC5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 21:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99E610E7A2;
	Thu, 20 Aug 2026 21:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCJkZ989";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 216E210E7A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 21:11:08 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-392af6bda98so30638a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 14:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787260267; cv=none;
 d=google.com; s=arc-20260327;
 b=ZpzASgMCUV3VgrrO/89HMLUkArUJ2AUm37TELR80ncuY5lR2KlP3zHzRTtYdhkluXC
 kyfUwpIaAN0Yadq1i45D38R1dEu5gNz0GG3sY2dSP2oLBv640UT+0LSAuI4hc2+k7ye7
 HN3C2lrakpFB+agi895ZXaJOo/3bafK0T7yUgfiXJ6dHQ0sfOzLn8dpFV9t/1W9rOYwg
 6A0UU85S8LhCDpJ1nbrpRm623J3WDPkNT0t3Dv5MzS87/FfuMjJterCzx+nhLX9UBzin
 VCJxork8fVwudpK9K2KDG9+gLmGPg35+suvOdK1vMYKjZHUS6wbvXkJ9oikdEVYcvrfR
 qUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+58ppq7/IWpYfDH5uV4f+qEE0t5tg8bvsSH5WVPCSWM=;
 fh=+HtJfrqdzjrp2YWDzHTzmQ3etLwu7LlEjZ2EqLXECpc=;
 b=M+y2EYyl4XMez/SKFPOvjtL0exyeqteVoYYdc1ktgiBCkI7rB0LDTyKrTOgSBAMuSu
 A6JJ+QfMTT0ma7m2kSFK1rQkvX0JopArPWnVyUAzpf3Cvx5vU89NFuk78MvI6I7t6CFW
 /9tQfhfjFbuxZ+3vIoR6sFANt6Xe8Wvq7aYBJ/zPZpzRSPZ6VWdYQ/P4xcHMQ/JEg9fc
 LxbtGMRscmHJN2wgp5eMdFUU/tLMcI1yI2qpd6B/sZxzzlgKzBghfWpKUIMOJA3clHOJ
 HGCm4Xz8OzGG+qBMItVk+4kpd6fOnKUrmhv7rH7M7Z6uh4NLSYzP5jpEhz+lJ1bnBpMZ
 Kkug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787260267; x=1787865067; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+58ppq7/IWpYfDH5uV4f+qEE0t5tg8bvsSH5WVPCSWM=;
 b=gCJkZ989CoT909pSCFzbTHUa+4pKMy7p1ONBhS1I+W0NhTqDU2sxDVomA27qsMNgMl
 DAayTzLVD7Slghu3eFYHQAJNNluM81WAYBI/yIEICme6h6pyP00Sd1Xq+CsdNbsjCOib
 b2m3FCmDAnYMNO0FVfbJYtzN7Ab4znjO40gq48A42ZgPoaGzWH4uBqRjgx2H1KQeywJW
 A5OEuFnujj8icuENStKAEY6NTbo6TiQjTutq2K0wn9y9okPAM6Kk9qoSG8eLDeWnjA64
 v6p/Qc0FjCvatJL43/y8kRbUEx3YVJY5DWOZbznezku+OH5oNW5Mtl1aSocFJQuAER8+
 kdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787260267; x=1787865067;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+58ppq7/IWpYfDH5uV4f+qEE0t5tg8bvsSH5WVPCSWM=;
 b=lbYT7jVRNigixT0qkDfosyuSv/XggdTqbvR7RB6sVVfpdSTQ5fr1YTl5TpPf0Ke2Pe
 VuFDCh4ehB1eO91cIt0PwNAiUFQ30x/M7FTJf6v0WYBHqEDrD9PRB6qStk/SKqC1g1GB
 54ekkNhf96GNhyCtG9MdQnz7G8ImUttJXniyGQDYxcxxQcryJfK846PLQnau4VZeCQ/X
 oPYe0h0hpkjG3NxJe71jGs0bLQx0wiLI6ZXrf4uqJR+bJChu0pec0p3Rzpl2L5c6wMFA
 9pDvWCA35wb1K/QgJ/dVQRD1ZSUU71Hdplo4uTpvzzoI/HQRRKPasUOS+IT3CnjHp4YQ
 O3Cw==
X-Gm-Message-State: AFuF++mexphXKPJitfIsTZTw+GTksMfoEaoz5PKwkzc1/lrQGyjOnPbs
 fUCXcxp2JgOXlInmSx5wLyuFVBTM3UpUfmMLzlk+KFkgkIc8EmejjCxnhFqTH9BFukoNrr3WGvZ
 rVowRSOzCt6WCPvUQnzmhAiS7eSXdhqg=
X-Gm-Gg: AR+sD12qknOU26zMZW2B40hBvsBxpowbkGW5BARANYjJuM5EFYbv4xDMcsjEVFmRKYN
 +dGaZcO4LSarVw4MAmWb6QAbbknWHxKsYFcdaSxIl0W8wv1GTRqzs0QE4lmXNLPaWL0sCQejMIw
 8ujS2Mp2L04iZxLDDDxcr5wLwrMj+5fsxy48HYe035XqkwvKKxxz/IzynUIzVVnGIqrO3pL3eBE
 aGpSv5nPGhj/7wmEeM+kvTg5fXfTHkNvArZnKVmf/JDP8WQWls4UNeN4N1yM8W2PKhXAJDOGOJE
 U1btgzkK7DBkzmRs6cG8XxAok5f/P+zWX3HH1YcyqEBmQvxzwaWUmMy4baqJXhXgHpeGFWLXTnp
 taEtj8esvyQeHVzaAF7U5SSKXKfuj1js=
X-Received: by 2002:a17:90b:4484:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-395c33571d5mr1031283a91.1.1787260267517; Thu, 20 Aug 2026
 14:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260819185349.29407-1-pisarevden@gmail.com>
In-Reply-To: <20260819185349.29407-1-pisarevden@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Aug 2026 17:10:55 -0400
X-Gm-Features: AcwNN1Vai7aWO5WsKEL-otmSiwSsfGMkQzj2Cck3gdB3K6hYszYtDUormEy7lTs
Message-ID: <CADnq5_M5yrY+QW2-8phcYhZ7McE-zpFvDh9beZ6jvzTEH1A1xw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] drm/amdgpu: MMIO TLB invalidation fallback when
 KIQ is wedged after S4 resume
To: Denis Pisarev <pisarevden@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, mario.limonciello@amd.com, ionut_n2001@yahoo.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 19, 2026 at 3:30=E2=80=AFPM Denis Pisarev <pisarevden@gmail.com=
> wrote:
>
> Hi,
>
> This RFC follows up on bugzilla 219492 ("failed to write reg 28b4 wait
> reg 28c6" after hibernation) and on the resume_gpu_stable proposal
> rejected in January:
>
>   https://lore.kernel.org/amd-gfx/20260106125929.25214-6-sunlightlinux@gm=
ail.com/
>
> The rejection argued that (a) kiq sched.ready is managed correctly -
> set false in suspend, set true again only after ring tests pass on
> resume - and (b) the proposed flag would have disabled the KIQ flush
> path permanently. Both points are correct, and this RFC takes a
> different route: nothing is disabled proactively; the driver reacts to
> observed failures.
>
> MEASURED FAILURE MODE (Cezanne iGPU, Ryzen 7 PRO 5850U, 7.1.8, KDE
> Wayland, no ROCm):
>
> - S4 resume -> "failed to write reg 28b4/28c6" + "1a6f4/1a706" pairs
>   begin in the same second as the thaw and continue at 80-140/hour
>   for 9+ hours until reboot. kiq sched.ready is true throughout (the
>   ring test at resume passed).
> - Two user-visible consequences: each failed flush burns the ~5 s KIQ
>   retry window (desktop-wide sluggishness), and the invalidation is
>   then silently dropped (stale TLBs - correctness).
>
> TRIGGER ISOLATION (single-variable tests, one hibernate cycle each):
>
> - stock (GFXOFF allowed across S4):    ~70-140 errors / 30 min of use
> - GFXOFF held off across S4:                    0 errors (30 min)
> - GFXOFF re-enabled 40 min after the clean
>   resume:                                      0 errors (15 min;
>   gating resumption not independently verified)
>
> So the wedge forms in the S4 resume window while GFXOFF is allowed,
> and is consistent with the existing semaphore workaround comment in
> gmc_v9_0.c about losing invalidate-acknowledge state across
> power-gating cycles. A boot-time amdgpu.pg_mask=3D0 does not even
> initialize on this part (probe -ETIMEDOUT), so runtime debugfs
> control was used.
>
> THE PATCH (1/1):
>
> - amdgpu_gmc_fw_reg_write_reg_wait() returns -ETIME on failure and
>   counts consecutive failures
> - gmc_v9_0_flush_gpu_tlb() uses its existing MMIO path as fallback
>   when the KIQ submit fails (invalidations no longer dropped), and
>   after 3 consecutive failures skips the KIQ path entirely until the
>   counter resets - so wedged systems stop paying 5 s per flush
> - counter resets on every success and in gmc_v9_0_hw_fini(); each
>   suspend/resume cycle re-arms KIQ. No proactive disabling anywhere.
> - gmc_v10/v11/v12 call sites unchanged and compile-safe (int return
>   used as statement); extending the fallback to them is trivial once
>   the approach is agreed.

I think it would be better to get KIQ and MES out of the TLB path.  If
they get hung, we have bigger problems.  Can you give this branch a
spin?
https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework?ref_typ=
e=3Dheads
It switches over to using SDMA and only falls back to MMIO if SDMA is
not available.  If you use MMIO, you need to disallow gfxoff before
you touch the registers over MMIO otherwise you'll hang GFX.

Alex

>
> This mirrors what the sibling PASID path already does (KIQ submit,
> -ETIME on timeout, MMIO variant as fallback), applied to the per-VMID
> path.
>
> OPEN QUESTIONS:
>
> 1. Root cause in the S4 window: RLC/ME not processing KIQ invalidates
>    while GFXOFF is allowed? Happy to run tracing (amdgpu.vm_debug,
>    VM_INVALIDATE ack registers) on the affected hardware on request.
> 2. Should the latch be per-xcc-inst?
> 3. Should amdgpu_gmc_flush_gpu_tlb_pasid()'s KIQ branch share the
>    latch?
>
> Patch 1/1 follows. Comments very welcome - especially on whether the
> failure-driven fallback is the right shape vs. fixing the S4 resume
> ordering directly.
>
> Denis Pisarev
>
> Denis Pisarev (1):
>   drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
>     unresponsive
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 +++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 18 ++++++++++++++----
>  4 files changed, 30 insertions(+), 9 deletions(-)
>
> --
> 2.55.0
>
