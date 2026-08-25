Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD3AC61DB9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 13:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E2110EA7C;
	Tue, 25 Aug 2026 13:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C+NFYFla";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA6810EA79
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 13:59:25 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-396555b8c7cso127514a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 06:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787666365; cv=none;
 d=google.com; s=arc-20260327;
 b=f98Z9YTpoR0D1fWepypOtRqRTgnRbPwn04kOrs/6Tjv3xrD2isSpA1RVm+WET86RYq
 uYwYFvMx0Gu0tukH7KDBkrvMBDMiTPlJkOLnQF+luglEB1IZsJDFsvWVxdrxiU7xpTdr
 hrWuWSZlNOI6/uRNakbvaAzgYmhajEKG5YeMr94G1Yij5KZmdXrdI8ZKyA1T54dHNj+4
 8aaqAJ56YdSRhWImK2MnfiCw8GLjwx7/aU0JgSfxHOzU/9qb0M+75/KX/QA1oA5jODJI
 cuhC2PJwOAjjQFlvsPS2zoaMd/63EXnd3dXbZLFYbR4Sv7xSRVfH9y0/X+TAZ6k1sE+v
 EkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z22dd3Q8MSrQ3UHas6q5gA0zbxI0XGCd+AwV0aCcOgY=;
 fh=dEKwsp8Qku4pnjZ/5YpZi3K3xLKrfvQRZ/dp0sAP38M=;
 b=bn/K07zRd3FM/eXgRFytYXrJqduPAWCIwGJ60JnPgA7R96nglUYLzaVaNFXeE6px9+
 VfiZ+2YGgD/03MNdc/wvcXK4bHa2uIAtxmCEvHLqFqLpL5VOeH7JQR77Yveo9Ga7zauK
 yudyuQgAsfHqX9ODTZA4u7qjRZkvfXuTE6JWWQ6irNP4BDLaOfC8iFb8wOTKHYqE/3CK
 X2eP9Tjib9e1XLIBIFqU7mf7TNaA1tePyGN+KCcrDgGmVD65lo8KyND5UqeWsupfL5wq
 amD765Sj1jBVDOyEJ/TxaTKfHaCLbki8PUKYIQmMRjWkvYZROaH672yd+fpQzI7ZAE7v
 zeBQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787666365; x=1788271165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z22dd3Q8MSrQ3UHas6q5gA0zbxI0XGCd+AwV0aCcOgY=;
 b=C+NFYFlaEoC4l+VxX8oqbU33Fw2kKNMjIeWPVXBLC3a4I9dl8WG/CcqHwkLbDa2NrA
 DK5mOQIBD+GVbRyBSgavq9siLBxKoz20Tep0Rxez4XZAGAb6nLsi41tADueVmt1H1vUY
 mp34lxAG4LyeJXw37dsy/F457J3MZSIJmW7/uY/07zmEt6dyRQ5uHMwLSsjGCHwVFmlC
 WujoofhyH3B6rL3ifemZRsvd/3cHDQ3d2tfzp9dqd3dXMYy3XRmCwtrB7m1NEpGotWLn
 RgtzPI0RTkeVDZh8D+oPya4RwA7H/oPp6Iqk376GletSUcTXJK6FBWA4DEV+GpjBVV6V
 Vkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787666365; x=1788271165;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z22dd3Q8MSrQ3UHas6q5gA0zbxI0XGCd+AwV0aCcOgY=;
 b=KTlPztdEZ00NqGkYyS7PB+mN+q4j1s9MiH21LWVWlbp9S+D0eAZEIbHM7bZNAp5GPO
 o2Zt7tIAy1Ry8l7ALqt+VsNF5sum/PzRTJsaUqs1cmTH310E8j8Wezxl/bxy7flLfgJN
 fAxEsQhzMH1iw8sEQ8ocTxFn97JBt3stOsLayw7L3K/X5IZSWxxcC29UL2DqRqXbj3S5
 3W31vYbty8CwxlFsWST32me5MXhPLrNlnluBbAraNh5twtfvMgzxuZnAZWFiZdcLZ5nS
 rySgEuY7VH+OXXA/Wa3SUn5QC4tIZaOcXK+T4oMolRh6tGPT7N+nh3wxhwfPhFRF4Q7/
 rCgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWuJuILLmCknNManyndzkjyTSe7QkdPI+FmUWNFFA/U0K6OQ2szYgxfmytbeSQ9vmXxcVr+XN/@lists.freedesktop.org
X-Gm-Message-State: AFuF++kERTaXy0nlH+3gQoyWhjBJLxJlBEstiVfAh8FvhaS0aKa9iB0a
 wyuAClJduIkvS5AHrY4ZOit+S1/x8iwdnqph7iX0HOZgLMAcRToUU28sjdIx1PEuq8yKl5j/KVC
 O1WWNg92FQYIneq8Chvh3PcUCdQHd0n4=
X-Gm-Gg: AR+sD10YW+hD45y5rTqFhICBiz1wa5y1X5K/wtnBAzWeCUqcVNUHF5Th1+LczGdzNVZ
 K1z5L6Dc+0HyAfW+PJaUzSI8AwxtWU3TjxUEsXQ3QB6BCRaHP7C0h6LFd/dF5LQ2aa9gJdQH1jd
 1MVtJeV07T0nCwLmqGaQk4H1Ens7dfAowqq8KIR0nMjy6UL0tner51WlG8mEtBoRfhvB+gqAkK2
 60+WDyJhL1PgirR1xQkfkHQH8d5//yRbZug5zvE0KKrn2s7MCgRMhS6q/2ylJ9s28GsMER25Y9V
 UwzTICg/NTQUiKxQoDYEwo5QkS1hUTKufz37V4rg0uv9XmJA0KnP02dZEHrVPicPE3X/K/fXe4M
 AdnP6QxQV6UMRFFQAQI7Fxroh6W/tW7c=
X-Received: by 2002:a17:90b:4484:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-395c33571d5mr26876026a91.1.1787666364729; Tue, 25 Aug 2026
 06:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Aug 2026 09:59:13 -0400
X-Gm-Features: AcwNN1VEggx8dHQqDqRsScGfB5r819oHtakJsyj6ZrtcawtiDDZ2hLQXiLY1_UU
Message-ID: <CADnq5_OB=KziYNrGRwKiL6X6NMD0_930wzfsQkQiuOK4SeO7Cg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] drm/amdgpu: Render-node second-level trap handler
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Lancelot Six <lancelot.six@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
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

On Thu, Aug 20, 2026 at 3:40=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> When a GPU shader hits an error or exception, the hardware calls a trap
> handler. AMD GPUs support two levels: a first-level handler that runs
> inside the kernel (via CWSR), and an optional second-level handler that
> runs in userspace. The second-level handler lets a runtime or debugger
> catch shader exceptions without any kernel changes.
>
> KFD already provides this for compute workloads. Render-node user queues
> use the same first-level CWSR trap infrastructure but had no way to
> install a second-level handler. This series adds that support.
>
> The second-level handler is a per-process (per-VM) setting. All shader
> queues belonging to the same process share the same hardware VMID, so
> one SET_L2_TRAP call covers every GFX and compute queue for that
> process. This setting belongs in the VM ioctl (DRM_AMDGPU_VM), not in
> the CWSR ioctl, because it is not specific to the first-level handler
> mechanism.
>
> UAPI backward compatibility
> ---------------------------
> The drm_amdgpu_vm_in struct gains a 32-byte union for the new op data.
> Existing ops (RESERVE/UNRESERVE_VMID) only use the first 8 bytes and
> are unaffected. The DRM framework automatically zero-fills the new fields
> for older userspace programs. No existing Mesa or ROCr code is broken.
>
> Implementation
> --------------
> On discrete GPUs the CWSR scratch buffer (TMA) may live in VRAM, which
> is accessed through MMIO on some CPU platforms. Direct CPU pointer writes
> are unsafe there. The driver uses struct iosys_map for all TMA writes,
> which picks the right accessor automatically (regular memory or MMIO).
>
> Installing a new TBA/TMA requires two separate memory writes, which
> creates a race: a shader that traps between the two writes would see a
> mismatched TBA/TMA pair and could crash. To prevent this, the driver
> stops all user queues, flushes the GPU TLB, writes both values, then
> restarts the queues.
>
> GEM_VA UNMAP and CLEAR operations must always succeed =E2=80=94 they cann=
ot
> return an error. If userspace removes a TBA or TMA buffer without first
> calling CLEAR_L2_TRAP, the driver detects the overlap, runs the same
> stop-flush-clear sequence, and lets the unmap proceed silently. Queues
> that lose their trap handler this way are marked invalid and not
> restarted =E2=80=94 a queue cannot safely run without a valid trap handle=
r.
>
> TTMP register layout
> --------------------
> When a shader wave enters the second-level trap handler, these hardware
> registers carry the relevant state:
>
>   ttmp0/1    faulting shader PC (set by hardware)
>   ttmp14/15  second-level TMA address (set by first-level handler)
>   ttmp2/3    free for the handler to use as temporaries
>   ttmp6[30]  wave stopped flag (set by second-level handler/debugger)
>   ttmp6[29]  saved halt flag (set by second-level handler/debugger)
>   ttmp11[23] debug mode enabled (set by first-level handler)
>

I think it would be good to add some kernel doc for this.  We should
document the GPR usage per GFXIP version and explain how the trap
handler works in general.  For reference, the trap handler is per
GPUVM, not per queue.  As such, the trap handler is allocated by the
kernel driver and mapped into every GPUVM which needs a trap handler
at the same GPU VA.  This means the trap handler needs to be unified
for gfx and compute and needs to handle CWSR for compute.  If an
application wants to register its own trap handler, you can register
one with the primary trap handler.  This works by setting a flag in
the secondary trap handler and a GPU VA to jump to for the secondary
handler.  The application would call the trap handler IOCTL to
register the secondary trap handler and specify the GPU VA of the trap
handler it wants to register.  The IOCTL would then modify the primary
trap handler to enable the secondary handler.

Before we enable trap handlers for gfx, we need to modify the current
trap handlers in the kernel driver to handle gfx.

Alex

> Only compilation tested.
>
> Based on: amd-unified-interface branch
> Base commit: 0f354d789fdc ("drm/amdgpu: Drop vm_manager PASID to VM
>              mapping")
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: James Zhu <james.zhu@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
>
> Srinivasan Shanmugam (3):
>   drm/amdgpu/uapi: Add second-level trap handler ops to VM ioctl
>   drm/amdgpu: Add VM ioctl handlers for second-level trap handler
>   drm/amdgpu: Disable L2 trap handler when its VA range is unmapped
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c  | 341 ++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h  |  54 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   |  24 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  15 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  26 ++
>  include/uapi/drm/amdgpu_drm.h             |  80 ++++-
>  8 files changed, 469 insertions(+), 77 deletions(-)
>
>
> base-commit: 0f354d789fdcd03147eb77ab2e3ecdd5a67a1fad
> --
> 2.34.1
>
