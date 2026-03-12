Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97483105F78A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D68410EB5B;
	Fri, 13 Mar 2026 08:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="P6jfkVRh";
	dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED1010EA57;
 Thu, 12 Mar 2026 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=5pK/vbHjomF7ZCz8kPkvw2tTjUJzJ46B59krQRBArKA=; b=P6jfkVRhJlvjsFD7S+pYuzAuv4
 MLDDYDxGdAfivMXXxo/ZUVApw1nd+jENAw0Lyqc4uWfI7XnqjHOAqA7ttXYJsxG4TAasEr7BjpDWo
 aIeA1snKPi45aV1ULkpxeeIBktxDuhCSFmRpLsMt1+ttYrsG44v3EOWhuPyWXdpRzlHxyEOn74GDA
 Z1CGVzkjGPeaU2YAiJd8rj+ihgYeubYRKoTBEzXo+qEnQBbcOv9+Up7MVLIY/DcZTAGZThMyG8xOO
 o5W6SO+boLGEUOkS89Aq38o86dricntUVfJsA834gNk6HDFKQEuSPpArtEtoOedubfSWkO9Rzjeky
 ZIr57Svw==;
Received: from
 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl
 ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1w0iLn-00000001W9V-24Bg; Thu, 12 Mar 2026 15:53:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id 6325030049C; Thu, 12 Mar 2026 16:53:26 +0100 (CET)
Date: Thu, 12 Mar 2026 16:53:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Dmitry Ilvokhin <d@ilvokhin.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-sctp@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, dev@openvswitch.org,
 Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>,
 dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Len Brown <lenb@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 linaro-mm-sig@lists.linaro.org, Eddie James <eajames@linux.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-i2c@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] tracepoint: Add trace_invoke_##name() API
Message-ID: <20260312155326.GB1282955@noisy.programming.kicks-ass.net>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-2-vineeth@bitbyteword.org>
 <20260312111255.7925b4e2@gandalf.local.home>
 <CAO7JXPhg-Etspj9YahZrq8cmZ2K6AGWDrMnHO+oD96P_SmOLBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO7JXPhg-Etspj9YahZrq8cmZ2K6AGWDrMnHO+oD96P_SmOLBw@mail.gmail.com>
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:55:38 +0000
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

On Thu, Mar 12, 2026 at 11:39:06AM -0400, Vineeth Remanan Pillai wrote:
> On Thu, Mar 12, 2026 at 11:13 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 12 Mar 2026 11:04:56 -0400
> > "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
> >
> > > Add trace_invoke_##name() as a companion to trace_##name().  When a
> > > caller already guards a tracepoint with an explicit enabled check:
> > >
> > >   if (trace_foo_enabled() && cond)
> > >       trace_foo(args);
> > >
> > > trace_foo() internally repeats the static_branch_unlikely() test, which
> > > the compiler cannot fold since static branches are patched binary
> > > instructions.  This results in two static-branch evaluations for every
> > > guarded call site.
> > >
> > > trace_invoke_##name() calls __do_trace_##name() directly, skipping the
> > > redundant static-branch re-check.  This avoids leaking the internal
> > > __do_trace_##name() symbol into call sites while still eliminating the
> > > double evaluation:
> > >
> > >   if (trace_foo_enabled() && cond)
> > >       trace_invoke_foo(args);   /* calls __do_trace_foo() directly */
> > >
> > > Three locations are updated:
> > > - __DECLARE_TRACE: invoke form omits static_branch_unlikely, retains
> > >   the LOCKDEP RCU-watching assertion.
> > > - __DECLARE_TRACE_SYSCALL: same, plus retains might_fault().
> > > - !TRACEPOINTS_ENABLED stub: empty no-op so callers compile cleanly
> > >   when tracepoints are compiled out.
> > >
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > > Assisted-by: Claude:claude-sonnet-4-6
> >
> > I'm guessing Claude helped with the other patches. Did it really help with this one?
> >
> 
> Claude wrote and build tested the whole series based on my guidance
> and prompt :-). I verified the series before sending it out, but
> claude did the initial work.

That seems like an unreasonable waste of energy. You could've had claude
write a Coccinelle script for you and saved a ton of tokens.
