Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10229C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 02:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28FD206F6
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 02:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28FD206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FC66E8F5;
	Thu, 21 May 2020 02:17:57 +0000 (UTC)
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A866E8BD;
 Thu, 21 May 2020 00:10:13 +0000 (UTC)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.80) (envelope-from <a.darwish@linutronix.de>)
 id 1jbYmC-0006mO-Af; Thu, 21 May 2020 02:09:32 +0200
Date: Thu, 21 May 2020 02:09:30 +0200
From: "Ahmed S. Darwish" <a.darwish@linutronix.de>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v1 13/25] dma-buf: Use sequence counter with associated
 wound/wait mutex
Message-ID: <20200521000930.GA359643@debian-buster-darwi.lab.linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-14-a.darwish@linutronix.de>
 <e28c251e-5771-598c-37dd-c6be2de4b9e1@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e28c251e-5771-598c-37dd-c6be2de4b9e1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-Mailman-Approved-At: Thu, 21 May 2020 02:17:56 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 dri-devel@lists.freedesktop.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "Sebastian A. Siewior" <bigeasy@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Sumit Semwal <sumit.semwal@linaro.org>, David Airlie <airlied@linux.ie>,
 Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 20, 2020, Christian K=F6nig wrote:
> Am 19.05.20 um 23:45 schrieb Ahmed S. Darwish:
> > A sequence counter write side critical section must be protected by some
> > form of locking to serialize writers. If the serialization primitive is
> > not disabling preemption implicitly, preemption has to be explicitly
> > disabled before entering the sequence counter write side critical
> > section.
> >
> > The dma-buf reservation subsystem uses plain sequence counters to manage
> > updates to reservations. Writer serialization is accomplished through a
> > wound/wait mutex.
> >
> > Acquiring a wound/wait mutex does not disable preemption, so this needs
> > to be done manually before and after the write side critical section.
> >
> > Use the newly-added seqcount_ww_mutex_t instead:
> >
> >    - It associates the ww_mutex with the sequence count, which enables
> >      lockdep to validate that the write side critical section is proper=
ly
> >      serialized.
> >
> >    - It removes the need to explicitly add preempt_disable/enable()
> >      around the write side critical section because the write_begin/end=
()
> >      functions for this new data type automatically do this.
> >
> > If lockdep is disabled this ww_mutex lock association is compiled out
> > and has neither storage size nor runtime overhead.
>
> Mhm, is the dma_resv object the only user of this new seqcount_ww_mutex
> variant ?
>
> If yes we are trying to get rid of this sequence counter for quite some
> time, so I would rather invest the additional time to finish this.
>

In this patch series, each extra "seqcount with associated lock" data
type costs us, exactly:

  - 1 typedef definition, seqcount_ww_mutex_t
  - 1 static initializer, SEQCNT_WW_MUTEX_ZERO()
  - 1 runtime initializer, seqcount_ww_mutex_init()

Definitions for the typedef and the 2 initializers above are
template-code one liners.

The logic which automatically disables preemption upon entering a
seqcount_ww_mutex_t write side critical section is also already shared
with seqcount_mutex_t and any future, preemptible, associated lock.

So, yes, dma-resv is the only user of seqcount_ww_mutex.

But even in that case, given the one liner template code nature of
seqcount_ww_mutex_t logic, it does not make sense to block the dma_resv
and amdgpu change until at some point in the future the sequence counter
is completely removed.

**If and when** the sequence counter gets removed, please just remove
the seqcount_ww_mutex_t data type with it. It will be extremely simple.

> Regards,
> Christian.
>

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
