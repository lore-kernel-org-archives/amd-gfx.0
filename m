Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490A1105F788
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5205110EB5D;
	Fri, 13 Mar 2026 08:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="sePnvYbH";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C54510EA59;
 Thu, 12 Mar 2026 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=J91GOtlULKSH0FD7uF5RTiGJtASwj8AkgmOe2gJa2aA=; b=sePnvYbHZ+kbIaHE9gEBIKhg7B
 pVCoLOvuCmyLbFjk3tLcl/f00fDKabfYAa4VvNVRNfhCpXmyVi0zHJRtsMooshgyJDW7xFkANyYPE
 sMZPjjycj8b1Erw8xOoAgir07AKj8fVwvyNc6ZZNyXirG5LngTpxpwPU2UoQj60rz6G6SVi4nSuM3
 tmS4r9m6mdBWwftO/r43siu6ryc1N4ZZp0w3CAB4Jn+lAP23fLg7BnPV4PveHXOcE/z8D76l+VjJA
 eviRMNd54ahakOFvDFAnWpl4LC+ZDAsMr1wjKSrb3fDGW4lOlgLQKduFf8HAzj02sJXlWJ7GzYWlo
 u6zst8rA==;
Received: from
 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl
 ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1w0iMp-0000000BYOM-0eW7; Thu, 12 Mar 2026 15:54:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id 5586730049C; Thu, 12 Mar 2026 16:54:29 +0100 (CET)
Date: Thu, 12 Mar 2026 16:54:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Dmitry Ilvokhin <d@ilvokhin.com>, Masami Hiramatsu <mhiramat@kernel.org>,
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
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
Message-ID: <20260312155429.GC1282955@noisy.programming.kicks-ass.net>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com>
 <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com>
 <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com>
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

On Thu, Mar 12, 2026 at 11:49:23AM -0400, Mathieu Desnoyers wrote:
> On 2026-03-12 11:40, Steven Rostedt wrote:
> > On Thu, 12 Mar 2026 11:28:07 -0400
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> > > > Note, Vineeth came up with the naming. I would have done "do" but when I
> > > > saw "invoke" I thought it sounded better.
> > > 
> > > It works as long as you don't have a tracing subsystem called
> > > "invoke", then you get into identifier clash territory.
> > 
> > True. Perhaps we should do the double underscore trick.
> > 
> > Instead of:  trace_invoke_foo()
> > 
> > use:  trace_invoke__foo()
> > 
> > 
> > Which will make it more visible to what the trace event is.
> > 
> > Hmm, we probably should have used: trace__foo() for all tracepoints, as
> > there's still functions that are called trace_foo() that are not
> > tracepoints :-p
> 
> One certain way to eliminate identifier clash would be to go for a
> prefix to "trace_", e.g.

Oh, I know!, call them __do_trace_##foo().

/me runs like hell


