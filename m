Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBC0C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 19:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD8F610A0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 19:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CD8F610A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C616F6F48A;
	Fri, 12 Nov 2021 19:52:50 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2EAC6E85F;
 Fri, 12 Nov 2021 17:54:55 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6771D60EBD;
 Fri, 12 Nov 2021 17:54:53 +0000 (UTC)
Date: Fri, 12 Nov 2021 12:54:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v10 08/10] dyndbg: add print-to-tracefs, selftest with
 it - RFC
Message-ID: <20211112125451.76b00818@gandalf.local.home>
In-Reply-To: <cfbc074c-73a5-b6be-580b-dae398d95d6b@akamai.com>
References: <20211111220206.121610-1-jim.cromie@gmail.com>
 <20211111220206.121610-9-jim.cromie@gmail.com>
 <20211112114953.GA1381@axis.com>
 <f3914fa9-8b22-d54e-3f77-d998e74094b9@akamai.com>
 <20211112120721.3a4827ce@gandalf.local.home>
 <cfbc074c-73a5-b6be-580b-dae398d95d6b@akamai.com>
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

On Fri, 12 Nov 2021 12:32:23 -0500
Jason Baron <jbaron@akamai.com> wrote:

> Ok, it looks like Vincent's patch defines a dyndbg event and then uses
> 'trace_dyndbg()' to output to the 'main' log. So all dynamic output to
> the 'main' ftrace buffer goes through that event if I understand it
> correctly. Here's a pointer to it for reference:
> 
> https://lore.kernel.org/lkml/20200825153338.17061-3-vincent.whitchurch@axis.com/
> 
> Would you be ok with that approach?

Yes that approach is fine, because it doesn't actually go to the main log
unless you enable the dyndbg trace event in the main buffer. You could
also enable that event in an instance and have it go there.

-- Steve
