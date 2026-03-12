Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1377106FD9A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026E310EB40;
	Fri, 13 Mar 2026 08:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ISOm+kS3";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 549B410EA8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 16:54:44 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-359f35dfef6so729599a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 09:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773334484; cv=none;
 d=google.com; s=arc-20240605;
 b=QpEl5zqsyoxrH9btTYTUQ7JPav9ZQIyflTre6oxmimMrEInZZvPUg3pnDHuBgmPjUi
 TZrQUt+yWEp3NCCFwNPiE8gHrhkM1ygH/8Sixkk2tFSCV1ziNAkJqPlM+ZoRpVlWWzD5
 jaKiBwrIwcBIf599ZgEjhftFhoSLFqfZGODVhAxb1bX/bNImyjLmsPCZsy3a03RIioYh
 ljyR9U5JcYto167dD8HksjrkFwuJCoa0ASEz1rB8EMZAaQk3vqeUOweqKuwVLFspGD9b
 MgloZ/bvVoU+IcXjyLZJYHTv6qY7vN2xRCLUcqcKThY0YKqLvcoErYWZA5jRQIALXmZ/
 ehOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+kWy5KRAZzJ0k+gfnUe4+KiD3cukw8nZMNARL7dWDnQ=;
 fh=XPdxs8CPFN03gjyEM3vzgkVFOhftRsugoYkJ6u2AbX4=;
 b=OeT4yq+FMDmdXgV30eAfnXzAiHGqgn55VZVIOOwoia+8DrbuWLFLnEN2qdsGSCwmsM
 9C3Nx4pTkBuW68ybT0H2eVEEeuATRj0ZZhQbiGJdAoqhc2e3of8/1SGpFzjGa48PEac+
 r357Gt1os5Jc6F9UUyaNhuwEZTBZSO2+TzvXrK2ore3wUZUByYve9i5KXkIV/MBxjH+Q
 4L9Bc946difsYeGT7DZUfSU/SLvntWOIf/fmHUa7CIeAMiqJ+F9YPqfQMTYxzhVy73Wh
 QEUhn5bK3oTmhGayzmoYxZuSVjaIYk4nS9RDrSP/DUZ5OMGtvi3O6No3wN0dmRTMGLQk
 wvPw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773334484; x=1773939284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kWy5KRAZzJ0k+gfnUe4+KiD3cukw8nZMNARL7dWDnQ=;
 b=ISOm+kS3Rwsg0aGDOR3bJ28z57pbDPY2RAPyQt4eZFz/obKDFQrUwlZsN6ovv5bdjd
 EVC7ZoHWfaocLpRdqLi8LiJ05lAPPmM7d8gD6XoJAvmre/ySwJ86cnuxA6hnIZvDLvF9
 PPH9Xd1v2TzS+7lzNdGgYSQNg4BAbRTpUJJXr3Q+8u/3vgeAj+g9BB4Gq5mMomUGlpWZ
 d+YX9s3k0vkGJD6AFmRoj2LuOCWnYApD6Vbepdofevo150hzDm8hZLD8oCcxA96Y1kv3
 5vG5vf85A91aM7JKm8O7Z/SSta82Vnw5nBWh7ceb2FA/uAeMYFzfEaNht0jQcMCrDKDo
 nMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773334484; x=1773939284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kWy5KRAZzJ0k+gfnUe4+KiD3cukw8nZMNARL7dWDnQ=;
 b=SwwLLX+EVzGeBdSuw95oInOu+8sj1/DdB/d3d0+kGcZd0jn4h0Bb4j7VAjzl5O+9x3
 D8F7SASjpPb+mqMzVUazFNS8W8rHHbC9t5pSwcRP5+knTnqXGmTH3ks1hTKkkqGPl1/v
 Yerlkv7XpzDzTKTmU/bKdeNwA6rNRsdsTqDII5sHqT++T2LaYqP5DkJvO5ebdLoydhni
 q8TVyoa20FGk6ZXqZskhWmOqimYxM1ny8e9fPO7blQEnOx2tx32WIhb62rColHUE3TAt
 P3aZjqDjPOLVwHo7M0L/Wzlrzqgro/A+C8W2dfz4HmoElUdvRoPUylh1yGgXwu/8ATop
 +BEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUm27nBYhZs4F6rofaXdnBezCwyAMrdiVRf231RGKZTRVafROuFKFwIAq7tGG01eIGbVQmAzNP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKg6uwEsSvLGa8wpTLXFDWtoeWKDslL99ha+liC26s5vS0mTNy
 y3cd0tdf4qFTY2R9AHdgdOn5ovVDTKFs5yz1I8Blqda7uLgnPSAZuJgGLq7XXyM44FkDkmIYXia
 mOWAgKCsxeK1VXLGslPWcfSv5Z4rXXR0=
X-Gm-Gg: ATEYQzxA11ws0/859NCUeD2z+TQpyBqVUgsokX/8Z5N5UsyLytWNH2+KbFj8ZHc0hzP
 zRjdD8hrmzhYX0/yuh2b3L1UMyXszahDv4cL7iMv7wryziM+LzTtUXuTVc2OAURHv+2A8D9sNiS
 xDV13+aNUZkBdAU3JZb2V5HscdeBsn1xSEBQxlLCXYOmTsFMnUcdfmncs8GJP1rzX4asdZNhxts
 pb5dABGKgKZh+zfTnNjzln/qLfh5xsKsWCpCO34Jhe6gpXtlNLuO/6fvSb5h93gAX+/UZy0987U
 kvUftPTMOV1MxkpqcTs8A7I=
X-Received: by 2002:a17:90b:288e:b0:359:8d0d:5905 with SMTP id
 98e67ed59e1d1-35a21eba194mr250522a91.9.1773334483388; Thu, 12 Mar 2026
 09:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com>
 <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com>
 <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com>
 <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
In-Reply-To: <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 09:54:29 -0700
X-Gm-Features: AaiRm51tg7oVvkVGab0X55k0oYxIuUltKNvtNsrbO-Cw57of2y67mwv1ziUvJS0
Message-ID: <CAEf4BzbnfyhCqp0ne=2gRnVxp-mdGmuZwDeFRyhRYH+eDcz2-w@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>, 
 Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, 
 Jon Maloy <jmaloy@redhat.com>, Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-sctp@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, dev@openvswitch.org, 
 Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
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

On Thu, Mar 12, 2026 at 9:15=E2=80=AFAM Vineeth Remanan Pillai
<vineeth@bitbyteword.org> wrote:
>
> On Thu, Mar 12, 2026 at 11:49=E2=80=AFAM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > On 2026-03-12 11:40, Steven Rostedt wrote:
> > > On Thu, 12 Mar 2026 11:28:07 -0400
> > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > >
> > >>> Note, Vineeth came up with the naming. I would have done "do" but w=
hen I
> > >>> saw "invoke" I thought it sounded better.
> > >>
> > >> It works as long as you don't have a tracing subsystem called
> > >> "invoke", then you get into identifier clash territory.
> > >
> > > True. Perhaps we should do the double underscore trick.
> > >
> > > Instead of:  trace_invoke_foo()
> > >
> > > use:  trace_invoke__foo()
> > >
> > >
> > > Which will make it more visible to what the trace event is.
> > >
> > > Hmm, we probably should have used: trace__foo() for all tracepoints, =
as
> > > there's still functions that are called trace_foo() that are not
> > > tracepoints :-p
> >
> > One certain way to eliminate identifier clash would be to go for a
> > prefix to "trace_", e.g.
> >
> > do_trace_foo()
> > call_trace_foo()
>
> This was the initial idea, but it had conflict in the existing source:
> call_trace_sched_update_nr_running. do_trace_##name also had
> collisions when I checked. So, went with trace_invoke_##name. Did not
> check rest of the suggestions here though.
>
> Thanks,
> Vineeth
>
> > emit_trace_foo()
> > __trace_foo()

this seems like the best approach, IMO. double-underscored variants
are usually used for some specialized/internal version of a function
when we know that some conditions are correct (e.g., lock is already
taken, or something like that). Which fits here: trace_xxx() will
check if tracepoint is enabled, while __trace_xxx() will not check and
just invoke the tracepoint? It's short, it's distinct, and it says "I
know what I am doing".

> > invoke_trace_foo()
> > dispatch_trace_foo()
> >
> > Thanks,
> >
> > Mathieu
> >
> >
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > https://www.efficios.com
>
