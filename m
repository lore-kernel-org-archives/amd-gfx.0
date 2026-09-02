Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894B4C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 09:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC34510F085;
	Wed,  2 Sep 2026 09:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eZce0S3R";
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A409D10F085
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 09:06:56 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-6b19e291cc6so633875eaf.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2026 02:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788340015; cv=none;
 d=google.com; s=arc-20260327;
 b=RaCh07bZ/EEIgs3baz5xsvwlfqFN7JPx35GwmyZPb/WRWlDBRru0d3EEDuTXmExvUv
 ifGuiKkFYAlR0y3es1t1gtop/0UkoVx+Un8wKqPVIOr4owbbqKyqvefSeW5s529ZucIF
 UHALrTXYAvEyW9oB6CFyFIhAhs5RKpZcgQBxtONzRUSymnZhB0BYhHhk40vIvmaMMaDU
 /EKcdjekdc2Rs4AhdpMiFY6suVsNeyxbWeKdmF0G/uBELfaqV3VbsQzy2ydLB4NU1KZD
 BXj0piZpOIyGyVA+9ATKz0v180a+0sdLAIl4D8OCKkt+uoHlMa/tdvlt7Lw2xaLMqf0L
 d6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RvG7k49zHG3a3L7t1TLI0SMoKt3IOzcysRODmcBXppE=;
 fh=KhfpioGojBUCBm+MCFH3unGApxl6/5cSB6QWi0kRpP8=;
 b=fqcHgCfXi9yIxdeW2Ad0jnAfZ0ANXxL4Apo7mFtGdrQqq0yIFfIzCGwFgtF0P0xkig
 HlEgZyIwQ/qEi2lodPbqTCGJm+O2zF/VpRbQ4yfLru5T7B9RF6Ik36e/gLsFopUnJZ2N
 elT0sC2MgQXpp7vt+7lVwAdyzXHmO2cOJ4jntPWGgOo+i3txAJu3ZQRF35trfQg9cGTn
 cIOUQtNNTtEyT8FVPQOnXmm4pjX4hfgMdTEJy9BYzHkezMzZhf3WjIwzMW5IBrYw+CQ/
 pcEteMeVwA95VhbJ0a7/sgoscloLcDYJX5D2fnQp0nxO4tO4p/E8DK3fHtnmxlOVApmg
 RffQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788340015; x=1788944815; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RvG7k49zHG3a3L7t1TLI0SMoKt3IOzcysRODmcBXppE=;
 b=eZce0S3R0FjK9Mpcza6ZXsK77yi3gc4lVE3ouFz3JiPHHruWN/qU8r5pWgLaZFswXi
 lhAMU8tiaS3kNXFy223zlQb2slOcvEktOBeOmJohytqeV+LpIYmAPM2isebFLLG8pvnc
 HPd1GGzlTnhvbxR+VEf5sGmOUsuCOZZrv7mxFOV6/VCQwHJGrloWdc1EFWoc4VGbocG4
 9Uzvs6i24sf16IyIcotKkdeAIrw33XbyNg9votD2nH9BM8sq6Z9LoqFsb9laZN4Wl9kg
 v+EjnlaZosC++BKYlXmml2vzUsdbyhpx44riz1/J8Vh8AeQE+vQNLsJIRZt+pFbHnhFA
 SToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788340015; x=1788944815;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RvG7k49zHG3a3L7t1TLI0SMoKt3IOzcysRODmcBXppE=;
 b=oA/7nmIf58xLJ2Qj6KD+WzpXCn8V8ddvP0NdIZBM57m78JOor8aFIlCenRQ3Y41ko7
 9RjphQoCFScHyEJv7e/N6DQcBBeNyPo7vSdjNPSq6CZuEB57m+n/sqr8gNJJX8eh21il
 XnLbOKW7l8xhFz5xIfGn06uiYFC2KoiL7BFNaBO9IZIrUcJNGFTpqJs82eFC5cM1uKpJ
 tpNfyhLD4Gog20K410ZF6RGJxB5Uvrnts0+873Z3UKZPgJK0CC00ujcDAutl0sMZH37R
 Mrkl0Nt0h4x+Kg/G2ueChNQy3kYcG28Bdq5PHADAjVzHkGXUAeJVOrVoj+DHklNwWfqM
 UC4g==
X-Gm-Message-State: AFuF++lPkvAQWhtAwqO158pPnPwlOtcJJLWe3HsbhH2JKsU+mQAbHzPJ
 oU6s764pSCS6JM9v+4eXMB7v0h6taR9AnKgYb/Oxol/YuRHFybU/a+U56iGX/3UO6xfUd0QEIMW
 cxZLl+WIdoOU9SEuOS8nATVbvBxIQXSDVQaHU3MrSp0f5
X-Gm-Gg: AR+sD10iS3yeLY5Ymbnjt1SRGAZlB++nPwVSwtUjng1RiLORWMl5kb1xtiAX73wqbb/
 85pF2kRGXl1584yY5dBmAT3HogR8Bxlnxk3efzO9/YSJf7/niUs7SxieuIfE4LsYi0BmSVryWe/
 Rmk3UK5P+nly6Moi+mnoWMYeCJDepNHousQ0RHFdvAFYC+a/Lysy3mSbRv6AcTXGGtcaWlLwQJj
 D+E+v20PwTxGM4SFSO9lBcENwKfJFI3vIqsriNdzOIFNYkUYzPFm6GIOSmG0Jot3RWFAhEPCIjL
 9oOUMnOQX4LjsbbBeHFnSTQVcEhUjriVjLbBuOxD/BDN+UBXDITFyjCIIMDvoz43mcPuws2Gucv
 1VN7XFD9KMg1VTVLBrLqc6mlU/n1jrA==
X-Received: by 2002:a05:6820:609:b0:6b1:ab9c:3ef4 with SMTP id
 006d021491bc7-6b481436a76mr2278065eaf.27.1788340014534; Wed, 02 Sep 2026
 02:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260819185349.29407-1-pisarevden@gmail.com>
 <20260824153542.491012-1-pisarevden@gmail.com>
 <CADnq5_MEb72btY3NtbEVgZm=H_7OV6k1xC_t5YXVM_ONrZ2b3A@mail.gmail.com>
 <CAMpx=TVt=iHo-Tj=3yFv+E0PKxMf+e-GO7oeMZMhLJCm4kKD_w@mail.gmail.com>
 <CADnq5_PvB8BeQTGRowzF2jkdUOpEdXb7C7S-Y0tFiqJqCEHP4g@mail.gmail.com>
 <CAMpx=TVjGYemrPJ7d+VBvLx9TELMd68QF2ML4PAsy++e62cjiA@mail.gmail.com>
In-Reply-To: <CAMpx=TVjGYemrPJ7d+VBvLx9TELMd68QF2ML4PAsy++e62cjiA@mail.gmail.com>
From: Denis Pisarev <pisarevden@gmail.com>
Date: Wed, 2 Sep 2026 11:06:18 +0200
X-Gm-Features: AcwNN1Vk1uWPPZDkyYCHBKq0rnk7KZXDH15oIM8nEmhE7Nf2ZLkzjc9_51g_SfM
Message-ID: <CAMpx=TUwhvDF_eBrSW04qyia7c-tuF3LmOb6kE95gC12GbM1Bg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/1] drm/amdgpu: MMIO TLB invalidation fallback
 when KIQ is wedged after S4 resume
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, mario.limonciello@amd.com, ionut_n2001@yahoo.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Denis Pisarev <pisarevden@gmail.com>, alexander.deucher@amd.com
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

Correction to my earlier test report: it turns out my system
updated linux-firmware-amdgpu (20260622 -> 20260810), amd-ucode,
and the kernel (7.1.8 -> 7.1.9) between the failing reproductions
and the tlb_inv_rework test, so the clean result on your branch is
confounded.

Stock 7.1.9 + firmware 20260810 is now also clean: two hibernate
cycles today, zero "failed to write reg" errors (previously 4/4
cycles failed on firmware 20260622). Upstream 7.1.9 only has two
trivial amdgpu display fixes, so my theory is that the amdgpu
firmware refresh fixed the S4 KIQ wedge.

If it's useful I can downgrade linux-firmware-amdgpu to 20260622
from the pacman cache and try to reproduce again on stock to
confirm the firmware attribution.

On Tue, 1 Sept 2026 at 16:45, Denis Pisarev <pisarevden@gmail.com> wrote:
>
> Hi Alex,
>
> Tested tlb_inv_rework (tip: cd3e1ff4f (HEAD ->
> amdgpu-kiq-mmio-fallback-v3) drm/amdgpu: fall back to MMIO
> TLB invalidation when KIQ is unresponsive, kernelrelease
> 7.1.0-MANJARO+) on the affected machine (Cezanne / Ryzen
> 7 PRO 5850U, previously reproducing 100% across hibernate
> cycles).
>
> Result: hibernate resume is clean.
>
> - stock conditions (no GFXOFF workaround, hook removed)
> - fresh boot: 0 "failed to write reg" errors
> - after S4 resume + 30 min of normal desktop use: 0 errors
>   (control on 7.1.8 stock)
> - the amdgpu MODE2 reset at resume still occurs as on stock, but no
>   invalidation failures follow
> - one caveat from my testing: kernel was built with a trimmed
>   localmodconfig from the running distro config, not the full distro
>   config
>
> The GFXOFF correlation stands from the earlier single-variable test
> (GFXOFF held off across S4 -> zero errors), but with your rework the
> KIQ dependency for invalidation is gone, so the wedge no longer
> matters for this workload.
>
> Anything else you'd like tested on this machine (multiple hibernate
> cycles, sleep, specific tracing)?
>
>
> On Tue, 25 Aug 2026 at 19:20, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Tue, Aug 25, 2026 at 9:19=E2=80=AFAM Denis Pisarev <pisarevden@gmail=
.com> wrote:
> > >
> > > Hi Christian, Alex,
> > >
> > > Understood regarding the fallback - dropping that approach. A working
> > > KIQ after S4 resume is the real fix.
> > >
> > > Regarding GFXOFF, I agree that a gated-off CP/ME/KIQ would also fail
> > > the ring test, which aligns with the data. The ring test passes upon
> > > resuming and sched.ready is set; however, the write-reg/wait-ack
> > > handshake begins to fail during runtime, starting in the same second
> > > as the thaw and persisting for hours (80-140 errors per hour, measure=
d
> > > over 9+ hours). So the KIQ initialises fine, but then stops completin=
g
> > > those packets.
> > >
> > > The GFXOFF attribution comes from a single-variable experiment only:
> > > same workload, one hibernation cycle each. GFXOFF held off across the
> > > whole S4 cycle (disabled before hibernating and verified to be still
> > > off after resuming): zero errors. Also zero errors over 15 minutes
> > > after re-enabling it post-resuming. Plain S3 suspend never triggers
> > > it. This is merely a correlation; I cannot prove that it is a
> > > mechanism. The existing semaphore workaround comment in gmc_v9_0.c
> > > about losing invalidate acknowledge state across power-gating cycles
> > > appears to be relevant, but I cannot prove that. I am happy to run
> > > whatever tracing is required to identify the mechanism from the
> > > affected machine (RLC/ME state, gfx_off_state sampled at the time of
> > > failure, KIQ fence timestamps and register dumps).
> >
> > Can you try this branch?
> > https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework?ref=
_type=3Dheads
> >
> > Alex
> >
> > >
> > > Thanks,
> > > Denis
> > >
> > > On Mon, 24 Aug 2026 at 20:31, Alex Deucher <alexdeucher@gmail.com> wr=
ote:
> > > >
> > > > On Mon, Aug 24, 2026 at 12:30=E2=80=AFPM Denis Pisarev <pisarevden@=
gmail.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > v3 addresses the two findings from the sashiko-bot review of v2.
> > > > > Failure data and trigger isolation are unchanged (bugzilla 219492=
):
> > > > > S4 resume on Cezanne (gmc_v9, GFXOFF) wedges KIQ TLB flushes at
> > > > > 80-140/hour for 9+ hours with sched.ready true throughout; holdin=
g
> > > > > GFXOFF off across the S4 cycle produces zero errors.
> > > > >
> > > > > 1. [High] "VFs and interrupt contexts silently drop TLB flushes o=
nce
> > > > >    the threshold is reached" - correct, and fixed. In v3 the latc=
h
> > > > >    only reroutes bare metal process context to MMIO. VFs and IRQ
> > > > >    contexts keep submitting to KIQ exactly as before this patch, =
with
> > > > >    per-failure logging, because they have no MMIO alternative; th=
ere
> > > > >    is no longer any code path that drops a flush without attempti=
ng
> > > > >    and logging.
> > > > >
> > > > > 2. [High] "KIQ and MMIO race on the same invalidation engine if K=
IQ
> > > > >    recovers" - this remains the documented open question; no code
> > > > >    change in v3. Our analysis: once latched, this path submits no=
 new
> > > > >    KIQ commands, so the exposure is limited to already-queued sta=
le
> > > > >    commands and the recovery transition window. The engine serial=
izes
> > > > >    requests internally, so the realistic worst case is a lost flu=
sh
> > > > >    request caught by the existing ACK timeout ("Timeout waiting f=
or VM
> > > > >    flush ACK!"), not silent state corruption. If maintainers cons=
ider
> > > > >    a fence necessary (or a dedicated invalidate engine for the MM=
IO
> > > > >    path), guidance on the preferred mechanism would be welcome.
> > > > >
> > > > > Full patch history: v1 (initial fallback+counter), v2 (GFXOFF hol=
d,
> > > > > per-instance counter, irqsave, VF/IRQ restrictions, MES error
> > > > > propagation) - all from bot review; v3 (this one) fixes the VF/IR=
Q
> > > > > drop regression the bot found in v2.
> > > > >
> > > > > Also still open from the cover letters: the alternative direction=
 of
> > > > > fixing the S4 resume ordering itself (RLC/ME vs GFXOFF) instead o=
f a
> > > > > runtime fallback. Happy to run tracing on the affected hardware.
> > > > >
> > > >
> > > > If that's a problem, that should be fixed.  That said, did you have
> > > > any success with the branch I proposed?
> > > >
> > > > Alex
> > > >
> > > > > Patch 1/1 follows.
> > > > >
> > > > > Denis Pisarev
> > > > >
> > > > > Denis Pisarev (1):
> > > > >   drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
> > > > >     unresponsive
> > > > >
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   2 +
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  18 ++--
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   2 +-
> > > > >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 123 ++++++++++++++++++=
+-----
> > > > >  5 files changed, 114 insertions(+), 33 deletions(-)
> > > > >
> > > > > --
> > > > > 2.55.0
> > > > >
>
>
>
> --
> Best regards,
> Denis Pisarev.
> pisarevden@gmail.com



--=20
Best regards,
Denis Pisarev.
pisarevden@gmail.com
