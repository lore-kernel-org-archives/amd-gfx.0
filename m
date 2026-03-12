Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF0A105F787
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7202410EB5E;
	Fri, 13 Mar 2026 08:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="djt0k3hV";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7146A10EA5D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 16:09:02 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-799569f6e9dso13123807b3.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 09:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773331741; cv=none;
 d=google.com; s=arc-20240605;
 b=LTiX0jdqAKin7UXP9nb39gemxyNmLjBHa+YVmHymQvmFMxgwkKX25dbCBbdOCuvtk3
 tWc8Bn/DPPfW5hiFnFxLe0ebYiQVkpydHeKYee0lFxEHwLU9hYQ98Ofoen2u9xbFsr0V
 DzFpQXJBUzY67EJVugXPd3VKOzmkKRyfAo8xaU6DM63vpQ1FKynDQcEwGLONhfrXOeCV
 AzerfGHb+jEZSqODYvi54DdtorzdNALCMX9MNIrw8jTl+qwmpJtNkfQxLpJYGOVTvOn3
 9fkqItjeyR8rI/aOycJXgH+brDxXjYsCniqytShrWh06HpJqbi+2FlrMyccTW6j3cmPO
 xxpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kI5PTFr09piXXwe+dHgxbmefu5uh1N96l8rxcGpDT20=;
 fh=Upi2MgkPcH7oglcJquoebJfwSvAfHaxaibvfRvO/+Co=;
 b=YO/HyGYAqv6lFJBUzHsGFnGaa/fn+fO68FvUGAcGabP7U/qgF0gRJ5NIrCOYMsX3V8
 NGXrPPfGGcGvoXRZ27mOsaIKC3gKSFk4LkrUi9+QCpP8m4O9/WG9DkEwXY6gFhxms/jY
 1g7OH42Eo1gRLEwkAiv8n44hhfwA8dcOaHb4tR6fzJgHRpBjyS3vmtZGTOVtXFnndXnj
 rdYMK6GsaUMpOLjD4kYq25NHIW+Bbrk7ELFyonw4wzNb8r4s04VTBxU2YF+wCe5Hcinx
 jca5ZT7aa8n/UFoCQoBN1Epm+D6eisHc6VI7dRwy5mD/DuBmoTEGEtL1mqfGaAhwGPkj
 4C8g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1773331741; x=1773936541;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kI5PTFr09piXXwe+dHgxbmefu5uh1N96l8rxcGpDT20=;
 b=djt0k3hVDFJGreJ12+f86xeUGd8Whif7lOAhQ73hsr+DWs5WvKnpXLwJ5/4A1aPvdT
 UNAwotzKkDEV91p4vZBhWHcL6LfvRuXGTg6xnU70+QpWO4S2yWvt8awhB3NXfMgM5o3L
 u8pylWxHVnA9gRkRsG3C2eRmAD+GAt007PF14TqZWYE9UdrhkaRLM7TFkok72LFlvmgr
 7aIE2cEDvZIw0xsuEpdqLUOoMRuyBKQfP91G0xytXw1dtp8xiD5e28YC8kwLoB++6ji/
 RCnLkxQU3FZVY+2GEggWnzMx1QcPvE0aE9IF2SnpSUR8QdJo2ZGW/OPV4DxvPa7CUP+C
 40Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773331741; x=1773936541;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kI5PTFr09piXXwe+dHgxbmefu5uh1N96l8rxcGpDT20=;
 b=lHlnCCdE7U691Ug7QBHGSNKNddPhF1/dlFq0injUX+KJKDt0Z50C06KshDE4VQnb4Z
 /AaCq0OWsgLhi/Set0GQbSmVLykdobeSjdnsKZQv2qDzCOfYdFh9GvurXRvJg5VuGBEl
 j/Wz6AltxBMOGxD1uLY9iAwNhS5hRUxq14YuKhRWZ+l0wF+spSKSI7DF9BPLQVH0sNbm
 U2thqrFDMAJTdHCNRNmjtcibD99twXawjOVrkzb1RfwoDoAB9lHWA0iIhI/EcUIpLOLO
 AfVoY0D6QiH3/9zfqY/zMhYF0RiQJdip5fzvqjHYciTZIROq8vZb5B4P5v6F44G+es4v
 LImQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZMD4zvKAqJAGA4pZw01wtph3MIZfDlYiwlNdUjkBT7Y8h+dPWkTmw4Y5JtULnAQuovPr2JKcd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvEToSE1j5y7VzK2RehrBrz1AbirKRms5q6UB+gcTPUyRuYnmD
 kWpKsvWL3IGg7WtAiX06RNWqLEqJAG93v9wh5xOhR91R5ZFXkLZDt6hU0RNoLqViADydawoYP9q
 CkWSb6D3LGcIDqwF5FgcwzjY31hlDCmz3vsdOZhPqhg==
X-Gm-Gg: ATEYQzydQ5U+789IjLpRMhdoEaS5f4rMjyOvKzYxb4NT6fz8phy4K1HQOesWAQ8lBnC
 bXzeCSmKGiQSFqDCO2F30ak57RYFYe7eb7CSfONYBxso3Z1ccH6cJB53M4BWRZbrJBk3hfrlov2
 gje4nCpM55BXRIRCTCsf/gqZNwN10MFWKSzPF5bBuuz/gKWhI97+9VYMFR0TKgTnJhFEt4xERET
 VSmoOU35q2mKKuhJ9BXkMboybMIrpiq+sR5Bk31bYp7IUAZvEhoYCDICZoBkOuISyPglVoUGoUd
 hOIP8BQ=
X-Received: by 2002:a05:690e:448d:b0:64a:e799:1d9c with SMTP id
 956f58d0204a3-64e63079bb0mr62693d50.60.1773331741406; Thu, 12 Mar 2026
 09:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com>
 <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com>
 <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com>
In-Reply-To: <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Thu, 12 Mar 2026 12:08:49 -0400
X-Gm-Features: AaiRm50l09G2avZYKQas6kLTqrDst8ZjnHTnngudy3h6MyVa79lzABXaRh3Trz0
Message-ID: <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
 Dmitry Ilvokhin <d@ilvokhin.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 dev@openvswitch.org, Oded Gabbay <ogabbay@kernel.org>,
 Koby Elbaz <koby.elbaz@intel.com>, 
 dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
 Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 Len Brown <lenb@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
 Eddie James <eajames@linux.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 12, 2026 at 11:49=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2026-03-12 11:40, Steven Rostedt wrote:
> > On Thu, 12 Mar 2026 11:28:07 -0400
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >
> >>> Note, Vineeth came up with the naming. I would have done "do" but whe=
n I
> >>> saw "invoke" I thought it sounded better.
> >>
> >> It works as long as you don't have a tracing subsystem called
> >> "invoke", then you get into identifier clash territory.
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
>
> do_trace_foo()
> call_trace_foo()

This was the initial idea, but it had conflict in the existing source:
call_trace_sched_update_nr_running. do_trace_##name also had
collisions when I checked. So, went with trace_invoke_##name. Did not
check rest of the suggestions here though.

Thanks,
Vineeth

> emit_trace_foo()
> __trace_foo()
> invoke_trace_foo()
> dispatch_trace_foo()
>
> Thanks,
>
> Mathieu
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
