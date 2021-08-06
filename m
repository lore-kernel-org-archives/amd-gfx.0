Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5ABC4338F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 15:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6005961165
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 15:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6005961165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E521C6EB8D;
	Fri,  6 Aug 2021 15:45:35 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C3E6EB8D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 15:45:34 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 c2-20020a0568303482b029048bcf4c6bd9so9360706otu.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Aug 2021 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oLpPc7fcDZONquVi3xJTWslZSBkD2Q+v/Wk7EF0BfWw=;
 b=MeaP8WLOoaZ1kVUFVY6aBFG1Vnzy2qwGkzBIsCHx6TGGUIPaDHSvPKhrwBvYXsidG4
 wtT9Icv5uh/6/SK7jSfNmFkYMklLn6jrQHkLc55DD6RjHuop19jkSqGYVjChEh3iA473
 XJk05LN9cmLpGHx+/U+bLrOU8Dpwuh22YeAyz7b6aGOYdud8Fftou4ZZKBlYzBSWr23s
 wK8JA5AzmVzlgnhsuTstO2LK6hEbtWk+ZFRDhH29ugdoCrnMc8nqYv74mjmIbQxVLdV4
 vcAYzPF8u/0EJzhn40/TrT9GdibyNlSKDx3OAuyaDzzlUZ1gxKezKLOv+WskytCYflTq
 0rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oLpPc7fcDZONquVi3xJTWslZSBkD2Q+v/Wk7EF0BfWw=;
 b=VOmWrgwNOMrR8uxfvlj4wmDdbG5+JL4ZoAGToEiUocRFtQ9miEYE+Um3r4hRIOgCCC
 vkaYLJucB0enqBh95tU+yQhhs9RNKDUEW2FlSFwFozaUqmz9qJ59QxmyZ5pyUegcL8Al
 0QKSyW4TG6cGkltuRusdptMQU2GxygPlc2AgmhJ4Tij68KlEuSn9hiZ5ST64LPzHNgN+
 DkIhnOk93wgKS8HE5aQSsv1UL56NG5V28/pFZM5fwbK3G3JDGYjrvFoSlM0qHyQvX/gk
 la2MXoFfZYWt696pSvMigBnAgRViB4K026Zr9a+LGDvTPBuKWv1X0OMtEHZFjJhCBHp1
 BoKg==
X-Gm-Message-State: AOAM532KkYyeCIGPN5KWh9oxhWCSgMyAXg8Pw2oPLuOFRDHUw7RTTsvt
 DfG0Worymgs0yIyfQSVNIpy2up8O5nsGOJZDQbQ=
X-Google-Smtp-Source: ABdhPJytpce+5xZnM0HEqqVmcx+XUnL9U2q2qU2itVt8ZbazGW0bYEiHCagaTNaRGMSg7wNXi3rlFWKzjO3eglZQ7To=
X-Received: by 2002:a9d:70c3:: with SMTP id w3mr7911199otj.311.1628264733638; 
 Fri, 06 Aug 2021 08:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <36ccfc64de628c060a736b8e05ae076246b686fc.camel@hadess.net>
 <CADnq5_NdfbJ9RAqMMxLYfvC70QPyuTQ8ggRZM2uYZAOuQx_vSQ@mail.gmail.com>
 <3524e3fb29d40003e59645a9ee5364ac62d34879.camel@hadess.net>
 <CADnq5_ORyFoNHk0Zng_6Ei6NEm557bpdtR6o5zE=3fpBp3qddw@mail.gmail.com>
 <38ddd7e5b2056d6efbf0267eb74ace4245d09ea8.camel@hadess.net>
In-Reply-To: <38ddd7e5b2056d6efbf0267eb74ace4245d09ea8.camel@hadess.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Aug 2021 11:45:22 -0400
Message-ID: <CADnq5_MQq3BYiJTb6YMVZ3pPzfgLrQYXFncohYdThGrNmJXuKw@mail.gmail.com>
Subject: Re: Power-saving/performance toggles for amdgpu
To: Bastien Nocera <hadess@hadess.net>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Aug 6, 2021 at 11:37 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Fri, 2021-08-06 at 11:08 -0400, Alex Deucher wrote:
> > On Fri, Aug 6, 2021 at 10:29 AM Bastien Nocera <hadess@hadess.net>
> > wrote:
> > >
> > > Nearly a year later, hello again, :)
> > >
> > > On Mon, 2020-09-14 at 01:46 -0400, Alex Deucher wrote:
> > > > On older radeons (e.g., pre-GCN hardware), there were separate
> > > > power
> > > > states for battery and AC, but these asics are supported by the
> > > > radeon
> > > > kernel driver.  None of the hardware supported by amdgpu exposes
> > > > anything like that anymore.  The rest is mainly for profiling and
> > > > debugging.  For more information see the relevant kernel
> > > > documentation:
> > > > https://www.kernel.org/doc/html/latest/gpu/amdgpu.html#gpu-power-thermal-controls-and-monitoring
> > > > I don't think there is anything you'd want to tweak there.
> > >
> > > Is the power_dpm_force_performance_level sysfs property for the
> > > amdgpu
> > > driver not something that one could tweak?
> > > https://www.kernel.org/doc/html/latest/gpu/amdgpu.html#power-dpm-force-performance-level
> > >
> > > System76's own power management daemon changes it:
> > > https://github.com/pop-os/system76-power/blob/master/src/radeon.rs
> > >
> > > So I'm wondering whether it would have any effect, for example, I
> > > would
> > > expect setting "high" when a performance mode is requested so that
> > > there's little latency in terms of frequency switching, "low" to
> > > force
> > > minimal power draw in a power saving mode, and "auto" the rest of
> > > the
> > > time.
> >
> > One could, but it's mainly there for debugging or profiling.  There
> > is
> > a microcontroller on the GPU that dynamically adjusts the clocks and
> > voltages at runtime based on GPU load.  It's tuned to do a good job
> > in
> > as many cases as possible by default.  If you really want to tweak
> > things, it would probably be better to adjust pp_power_profile_mode.
> > That has a bunch of preset profiles (or you can specify a custom one)
> > that adjust the heuristics (how quickly the clocks ramp up/down,
> > etc.)
> > for the dynamic reclocking done by the GPU.
>
> But the microcontroller doesn't really know user-intent, and can't
> really predict the future, which is the reason why a lot of OSes still
> have power profile selection knobs.
>
> So I'm mostly wondering whether:
> - those clock ramping transitions could be a problem on heavy workloads
> with varying intensity, say stuttering in a game that needs to be able
> to go from simple to really complicated in short order
> - setting the minimum clock would avoid short bursts of activity
> clocking up then down (in a GPU-based desktop environment for example),
> thus reducing the battery life

You could set one of the profiles which sets more or less aggressive
clocking, but you still get the advantages of the SMU being able to
dynamically adjust the clocks.  If you manually force the clock to low
or high, you end up forcing all clocks, even if a particular engine is
not in use.  E.g., if you are not using video decode, there is no need
to force the decoder clocks high as well.  Also, if the userspace tool
dies for some reason, that will leave the clocks in the forced state.

Alex

>
> >   That said, for most
> > workloads, I doubt you'll see much of a change.
>
> I would indeed expect "automatic" to work as expected, but not always
> be what the user intends for the GPU to be doing.
>
> >   When the GPU is idle,
> > clock and power gating kick in for most blocks and we also support
> > runtime power management so the dGPU will effectively get turned off
> > if it's idle.  The only tricky part with runtime power management, is
> > that we can't enable it if the framebuffer console is enabled because
> > the kernel keeps a persistent kmap of the framebuffer, so we can't
> > power down the GPU because we never know when an access might come
> > in.
> > We probably need some sort of deferred IO or shadow framebuffer
> > design
> > to handle that, but we haven't had time to delve into fixing that.
> >
> > Alex
>
