Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203BBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 19:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93EF6108B
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 19:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B93EF6108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2397B882A9;
	Fri, 12 Nov 2021 19:52:54 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 168516ECC3;
 Fri, 12 Nov 2021 17:07:25 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B42A36058D;
 Fri, 12 Nov 2021 17:07:22 +0000 (UTC)
Date: Fri, 12 Nov 2021 12:07:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v10 08/10] dyndbg: add print-to-tracefs, selftest with
 it - RFC
Message-ID: <20211112120721.3a4827ce@gandalf.local.home>
In-Reply-To: <f3914fa9-8b22-d54e-3f77-d998e74094b9@akamai.com>
References: <20211111220206.121610-1-jim.cromie@gmail.com>
 <20211111220206.121610-9-jim.cromie@gmail.com>
 <20211112114953.GA1381@axis.com>
 <f3914fa9-8b22-d54e-3f77-d998e74094b9@akamai.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 12 Nov 2021 19:52:48 +0000
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
Cc: quic_saipraka@quicinc.com, catalin.marinas@arm.com,
 dri-devel@lists.freedesktop.org, will@kernel.org, maz@kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 amd-gfx@lists.freedesktop.org, mingo@redhat.com, daniel.vetter@ffwll.ch,
 arnd@arndb.de, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 seanpaul@chromium.org, intel-gvt-dev@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, sean@poorly.run,
 Jim Cromie <jim.cromie@gmail.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, robdclark@gmail.com, quic_psodagud@quicinc.com,
 mathieu.desnoyers@efficios.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 12 Nov 2021 10:08:41 -0500
Jason Baron <jbaron@akamai.com> wrote:

> > A key difference between that patchset and this patch (besides that
> > small fact that I used +x instead of +T) was that my patchset allowed
> > the dyndbg trace to be emitted to the main buffer and did not force them
> > to be in an instance-specific buffer.  
> 
> Yes, I agree I'd prefer that we print here to the 'main' buffer - it seems to keep things simpler and easier to combine the output from different
> sources as you mentioned.

I do not want anything to print to the "main buffer" that can not be
filtered or turned off by the tracing infrastructure itself (aka tracefs
file system).

Once we allow that, then the trace file will become useless because
everything will write to the main buffer and fill it with noise.

Events that can be enabled and disabled from tracefs are fine, as they can
be limited. This is why I added that nasty warning if people leave around
trace_printk(), because it does exactly this (write to the main buffer).
It's fine for debugging a custom kernel, but should never be enabled in
something that is shipped, or part of mainline.

-- Steve
