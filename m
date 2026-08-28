Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02538C624A5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 07:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7782110E622;
	Mon, 31 Aug 2026 07:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="fSkxkPMb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DaWZaMUw";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DDB10E44D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:55:15 +0000 (UTC)
Date: Fri, 28 Aug 2026 11:55:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1787910912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HfL4Lo4u9mCbo/tmoWJN+iDCB3yeeS2jnrmcd3fTXps=;
 b=fSkxkPMbo207cmjv/vbHhPd1wtpBWn1vUFASAs4KQr4I+QSwfsgvKb+O3uKLW2OvaXQReP
 VkEUCepmHO30eVxgs0lBVZnxv6JrIefLSBXT5KydWyezcRXU1pq46TGbF1HSGtDBPPr99A
 2nfYWZ7ehNDPEbMEdCkieEPZulV+1CagHXYuIT05RKfrLsLv+ivp3l/5JGe5Nub8wZk+li
 Xda/r+fYYWOEhF8g1ZS4fjZyWrgT+5rrIyFL0JlCQYhw6RbIP/tWAxMvTlyhZ4qF8h3EtY
 TQysGAWc7zEUNmJV/zzP/lYVYjtCtsX1CQ8a4AvYx4sMHXDoT0Zza8tvPaI1EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1787910912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HfL4Lo4u9mCbo/tmoWJN+iDCB3yeeS2jnrmcd3fTXps=;
 b=DaWZaMUwsTr2V0hzD3+LQ0nml7NJQd3XP8j/hrwD++N2PID7st9W1OrcmihxPzH2FXWs3o
 C1Y2/KI9lJO5xEBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rafal Ostrowski <rafal.ostrowski@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7.2-rc6] drm/amd/display: fix usage of
 DC_FPU_{BEGIN,END} with PREEMPT_RT
Message-ID: <20260828095511.zrVXJUrU@linutronix.de>
References: <202608061233.eufnR5Qm-lkp@intel.com>
 <20260807124944.154232-1-spasswolf@web.de>
 <20260827124931.ocQEF6MW@linutronix.de>
 <bd31938661f178abaa68d3958bacdc1ebb70ff5c.camel@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd31938661f178abaa68d3958bacdc1ebb70ff5c.camel@web.de>
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:04:50 +0000
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

On 2026-08-27 23:07:08 [+0200], Bert Karwatzki wrote:
> Am Donnerstag, dem 27.08.2026 um 14:49 +0200 schrieb Sebastian Andrzej Siewior:
> > On 2026-08-07 14:49:42 [+0200], Bert Karwatzki wrote:
> > > On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
> > > converted to rt_mutex. dc_create_plane_state() can be called while
> > > inside an FPU-guarded region, resuling in "scheduling while atomic"
> > > errors on PREEMPT_RT kernels.
> > >  Fix this by calling kvzalloc_obj() with DC_RUN_WITH_PREEMPTION_ENABLED().
> > > Also fix the error path in dc_create_stream_for_sink().
> > > 
> > > Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
> > > Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/
> > > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > 
> > Thank you Bert. Got this somewhere in the meantime?
> 
> No, this is seems to be stuck somewhere ...

halp!

> > 
> > Could the FPU regions with disabled preemption be limited to where we
> > have actually have FPU usage in way that you don't have to worry when it
> > is needed to use DC_RUN_WITH_PREEMPTION_ENABLED() and when not? Also the
> > dc_fpu_begin()/ end() can nest and if they do the usage of
> > DC_RUN_WITH_PREEMPTION_ENABLED() is futile, isn't it?
> > 
> 
> I'm not very familiar with the amd display engine, and it's a lot of code,
> but there I think there's some room for improvement, e.g. dml2_destroy():
> 
> dml2_destroy is called from dc_state_free() from within DC_FP_{START,END}()
> and then basically just calls vfree with DC_RUN_WITH_PREEMPTION_ENABLED().
> (directly or through dml21_destroy()). Here both the DC_FP_*() tags and
> DC_RUN_WITH_PREEMPTION_ENABLED() could be dropped I think (not tested, yet)
> 
> Regarding nesting DC_FP_*()s: When I was searching for the cause of the
> kernel panics I monitored every DC_FP_{START,END}() with printk(), and I
> don't think I encountered nesting (the logs are lost unfortunately)

I am not saying it is nesting, just the START/STOP API is able to deal
this. Otherwise kernel_fpu_being/end() could be used directly. And
DC_RUN_WITH_PREEMPTION_ENABLED() is not able to deal with nesting.

On PREEMPT_RT it could be bad for the max observed latency if this nests
or has otherwise an unbound runtime. For crypto there an maximum amount
of input data which can be processed within a single FPU disabled
section. The "cheaper" second kernel_fpu_begin() makes it possible.

> > The first usage kernel_fpu_begin() saves the FPU state to the user task.
> > kernel_fpu_end() does not restore it. Therefore the subsequent
> > invocation of kernel_fpu_begin() is cheaper.
> > 
> > Sebastian
> 
> Bert Karwatzki

Sebastian
