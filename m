Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FE3C4338F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 15:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4B361165
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 15:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E4B361165
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369206EB8F;
	Fri,  6 Aug 2021 15:45:36 +0000 (UTC)
X-Greylist: delayed 4055 seconds by postgrey-1.36 at gabe;
 Fri, 06 Aug 2021 15:37:29 UTC
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D956E02E
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 15:37:29 +0000 (UTC)
Received: (Authenticated sender: hadess@hadess.net)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B0F8BC0002;
 Fri,  6 Aug 2021 15:37:26 +0000 (UTC)
Message-ID: <38ddd7e5b2056d6efbf0267eb74ace4245d09ea8.camel@hadess.net>
Subject: Re: Power-saving/performance toggles for amdgpu
From: Bastien Nocera <hadess@hadess.net>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Date: Fri, 06 Aug 2021 17:37:26 +0200
In-Reply-To: <CADnq5_ORyFoNHk0Zng_6Ei6NEm557bpdtR6o5zE=3fpBp3qddw@mail.gmail.com>
References: <36ccfc64de628c060a736b8e05ae076246b686fc.camel@hadess.net>
 <CADnq5_NdfbJ9RAqMMxLYfvC70QPyuTQ8ggRZM2uYZAOuQx_vSQ@mail.gmail.com>
 <3524e3fb29d40003e59645a9ee5364ac62d34879.camel@hadess.net>
 <CADnq5_ORyFoNHk0Zng_6Ei6NEm557bpdtR6o5zE=3fpBp3qddw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Aug 2021 15:45:35 +0000
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

On Fri, 2021-08-06 at 11:08 -0400, Alex Deucher wrote:
> On Fri, Aug 6, 2021 at 10:29 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > Nearly a year later, hello again, :)
> > 
> > On Mon, 2020-09-14 at 01:46 -0400, Alex Deucher wrote:
> > > On older radeons (e.g., pre-GCN hardware), there were separate
> > > power
> > > states for battery and AC, but these asics are supported by the
> > > radeon
> > > kernel driver.  None of the hardware supported by amdgpu exposes
> > > anything like that anymore.  The rest is mainly for profiling and
> > > debugging.  For more information see the relevant kernel
> > > documentation:
> > > https://www.kernel.org/doc/html/latest/gpu/amdgpu.html#gpu-power-thermal-controls-and-monitoring
> > > I don't think there is anything you'd want to tweak there.
> > 
> > Is the power_dpm_force_performance_level sysfs property for the
> > amdgpu
> > driver not something that one could tweak?
> > https://www.kernel.org/doc/html/latest/gpu/amdgpu.html#power-dpm-force-performance-level
> > 
> > System76's own power management daemon changes it:
> > https://github.com/pop-os/system76-power/blob/master/src/radeon.rs
> > 
> > So I'm wondering whether it would have any effect, for example, I
> > would
> > expect setting "high" when a performance mode is requested so that
> > there's little latency in terms of frequency switching, "low" to
> > force
> > minimal power draw in a power saving mode, and "auto" the rest of
> > the
> > time.
> 
> One could, but it's mainly there for debugging or profiling.  There
> is
> a microcontroller on the GPU that dynamically adjusts the clocks and
> voltages at runtime based on GPU load.  It's tuned to do a good job
> in
> as many cases as possible by default.  If you really want to tweak
> things, it would probably be better to adjust pp_power_profile_mode.
> That has a bunch of preset profiles (or you can specify a custom one)
> that adjust the heuristics (how quickly the clocks ramp up/down,
> etc.)
> for the dynamic reclocking done by the GPU.

But the microcontroller doesn't really know user-intent, and can't
really predict the future, which is the reason why a lot of OSes still
have power profile selection knobs.

So I'm mostly wondering whether:
- those clock ramping transitions could be a problem on heavy workloads
with varying intensity, say stuttering in a game that needs to be able
to go from simple to really complicated in short order
- setting the minimum clock would avoid short bursts of activity
clocking up then down (in a GPU-based desktop environment for example),
thus reducing the battery life

>   That said, for most
> workloads, I doubt you'll see much of a change.

I would indeed expect "automatic" to work as expected, but not always
be what the user intends for the GPU to be doing.

>   When the GPU is idle,
> clock and power gating kick in for most blocks and we also support
> runtime power management so the dGPU will effectively get turned off
> if it's idle.  The only tricky part with runtime power management, is
> that we can't enable it if the framebuffer console is enabled because
> the kernel keeps a persistent kmap of the framebuffer, so we can't
> power down the GPU because we never know when an access might come
> in.
> We probably need some sort of deferred IO or shadow framebuffer
> design
> to handle that, but we haven't had time to delve into fixing that.
> 
> Alex

