Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2D0103E302
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB6B10EB4F;
	Fri, 13 Mar 2026 08:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="iESGdEhB";
	dkim-atps=neutral
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC05110EA5C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 16:05:48 +0000 (UTC)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-64c9c8f8783so1433670d50.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 09:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773331548; cv=none;
 d=google.com; s=arc-20240605;
 b=FmyjdNVDvhgKxYs5rhebNZT/gtGR67UseQOc5N2GzUuFIDptPQewqKTsjw5CnEGjeP
 jfpjCDNKeOuLgl8pyr4qSyA3R/eJT+OUnX3VuzV9ErTONAI+N6E3P2yEKNDU6B+qOl6Y
 zj5MCoKQv+1zSDlziCrTC/uFcFRmGigojbMWhH+9hG66Lq7y80C5KwkpyP/A38eJw245
 hLWR/KrxEcGx3TIrc9Qtz1ofwOtU2k9RGG/TpFWhrqhm6a/EJat3lN9dNuM3fF2/wQhF
 7UJ71WYmHHifPWTF1YM0ExxROPeBsHY+1sT1kht6R10c+/Pf7Fp4cjlFtR5q/4Hm2+q9
 p+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JmKlkavBf/yAOF4s82cTsdoYBcDg+c1w7g0d5bSER7o=;
 fh=GsHJsPHMeuCcf4/cBtolTJ/KvkOKTC68C/HdPJl/GAY=;
 b=C8CvkmDgO5d154MPn5YARIpg7NqDfN0JWGdNzSZvksfrjI4VQSeeT0NM9iBy1Xmgd6
 90t7eTUJ87/bH9TQQf/a1MvH6Jrv0dGAUWxcgpHbLLUkOV1PuqOX9AiBrHjATnQYAROM
 pOfs674qTGDV1ulHCK9FfWvRrGQIXMEG6g/uT4HE7JT21VI2Cci6fOgDbW0uHhyO7/SA
 spnv6fBy+OAUMs+w63wco4AAOgJ9u9l/0v5InjBsfl1HHrUw6X4JHPx/eDD8A+yz6lbz
 Z+DrtMZRg5ZIMDDVT4qcGDaruC/sRMv8+JbhsIXTq1JNL7TbgmLaWFw0b0Afc9HFwLrN
 +/Kw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1773331548; x=1773936348;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmKlkavBf/yAOF4s82cTsdoYBcDg+c1w7g0d5bSER7o=;
 b=iESGdEhBFZg/W/YjekYdA4vH14/+v6TXLCQWyZpSiCNXePW6noDvHVAmfFj7xzcC8l
 EUmQz90WdDx1Lg++KuWYwPVaUhhJ68UR0afySOcCTWup5ELxhkbS3ytwiqo6fj9cYpaA
 E+taQeJxfy/xQiJXvvl3oSCvOen3JGTjachCg0SQ/YspViLk9FqfkYX6b/oIuUnyXfL4
 cw8zRFFBUOyUfmtikzxh9cqrmhLtEkgmDYjwIX/ZhPqGJN0M5jfaO3j4nlq1vb0fYQQS
 C+vqXmJV+TWyX48o/cDx3guk+kzvrTcgxUP5UdUknZM+J/Sc6u6SamGwCMRfcyF3nUXF
 acBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773331548; x=1773936348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JmKlkavBf/yAOF4s82cTsdoYBcDg+c1w7g0d5bSER7o=;
 b=XzhG/S7vejemMLqVJIknR13z116RJFIsSFD6qjFwhBeJJT66GyRkq/7bCm5OKTWacc
 5CMNyPxQdjgH1sJjJK3t4mVrnVDe93ijvN0ig1MDYfUClbTis5o8KhsrKBWK1nt/ueUG
 8tuoldU7WDXY2UrOPMlX1G+Zs1KOY73OM4axUxwI3768Y3r0Y+1y1NwFc4sLsLPgGSqP
 aKXTa0/PorblJ+lfSJiJc/oPoyjp2wUks69s5hsmO2uLfqQ2fnCxpGO1nyqB3zjxu3qM
 wDBTyHUxMXvxhxdzzIupe6y5bDCk2YLEwZGZK13GItxgxjXhsP8KHlwURibkglPkWxFY
 do+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX20hxWLPVqDnKTg1qGt4HcMOIZZTeHiLr+sPud/elJXNPWH7jmn9w2OlXrA1XFqbw3x+HipBva@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQCrzmLyIU2L0G2CeIaesspDqRntZbYpMGg0he+G6KQqA78Rj3
 XGz9WE0eFe7sAHyJpZygl+/2iPvvqcJ5P36owYt2bSI0Hp9Z7dZ8RJ6WhTJZ7S8cMEaqp21KSIr
 9F5+g/qANm6ZxZ5KF/FcHR/Sl4XVKhDtV5XLbl/0zlg==
X-Gm-Gg: ATEYQzxAhtjlTpOemqAFAlD64PWYYucEEM0bqneXYvEynwWmTSigTSL68kQOVIf2cPx
 C/PK5uWKwBk5PlS8W9nGTC6R2i4P9AM/i8gZrg0uCzqb5tB8zVzbk12yc/oEjMuf9xoL4vsADE1
 Exiizimp6y5LGy10GLXAoXVs+1QE4xWkDPiPFioocUdTEGzX8hf87/YE//AMMs25agjc051nDPs
 WDjdqx2JnaDBDg7Y2bMBwzkWDi5a5UrI5ovZ4glwgo8CERJF9oCOKXszFRegfMyFBkHiXhH3+gE
 Q2DTtLk=
X-Received: by 2002:a53:df06:0:b0:646:9ddf:5f2 with SMTP id
 956f58d0204a3-64e62869514mr137952d50.31.1773331547890; Thu, 12 Mar 2026
 09:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-2-vineeth@bitbyteword.org>
 <20260312111255.7925b4e2@gandalf.local.home>
 <CAO7JXPhg-Etspj9YahZrq8cmZ2K6AGWDrMnHO+oD96P_SmOLBw@mail.gmail.com>
 <20260312155326.GB1282955@noisy.programming.kicks-ass.net>
In-Reply-To: <20260312155326.GB1282955@noisy.programming.kicks-ass.net>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Thu, 12 Mar 2026 12:05:37 -0400
X-Gm-Features: AaiRm52SVVT4jiV0FzOGXISct6FMh2E9oWpuKL1FA2qkv7l8yLE2a6rVIE8wyUY
Message-ID: <CAO7JXPiu8-LE_gG001_GQLoGVYakPdzmH2SXLqfzJjEUxbn1Rw@mail.gmail.com>
Subject: Re: [PATCH 01/15] tracepoint: Add trace_invoke_##name() API
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, 
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

On Thu, Mar 12, 2026 at 11:53=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Thu, Mar 12, 2026 at 11:39:06AM -0400, Vineeth Remanan Pillai wrote:
> > On Thu, Mar 12, 2026 at 11:13=E2=80=AFAM Steven Rostedt <rostedt@goodmi=
s.org> wrote:
> > >
> > > On Thu, 12 Mar 2026 11:04:56 -0400
> > > "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
> > >
> > > > Add trace_invoke_##name() as a companion to trace_##name().  When a
> > > > caller already guards a tracepoint with an explicit enabled check:
> > > >
> > > >   if (trace_foo_enabled() && cond)
> > > >       trace_foo(args);
> > > >
> > > > trace_foo() internally repeats the static_branch_unlikely() test, w=
hich
> > > > the compiler cannot fold since static branches are patched binary
> > > > instructions.  This results in two static-branch evaluations for ev=
ery
> > > > guarded call site.
> > > >
> > > > trace_invoke_##name() calls __do_trace_##name() directly, skipping =
the
> > > > redundant static-branch re-check.  This avoids leaking the internal
> > > > __do_trace_##name() symbol into call sites while still eliminating =
the
> > > > double evaluation:
> > > >
> > > >   if (trace_foo_enabled() && cond)
> > > >       trace_invoke_foo(args);   /* calls __do_trace_foo() directly =
*/
> > > >
> > > > Three locations are updated:
> > > > - __DECLARE_TRACE: invoke form omits static_branch_unlikely, retain=
s
> > > >   the LOCKDEP RCU-watching assertion.
> > > > - __DECLARE_TRACE_SYSCALL: same, plus retains might_fault().
> > > > - !TRACEPOINTS_ENABLED stub: empty no-op so callers compile cleanly
> > > >   when tracepoints are compiled out.
> > > >
> > > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > > > Assisted-by: Claude:claude-sonnet-4-6
> > >
> > > I'm guessing Claude helped with the other patches. Did it really help=
 with this one?
> > >
> >
> > Claude wrote and build tested the whole series based on my guidance
> > and prompt :-). I verified the series before sending it out, but
> > claude did the initial work.
>
> That seems like an unreasonable waste of energy. You could've had claude
> write a Coccinelle script for you and saved a ton of tokens.

Yeah true, Steve also mentioned this to me offline. Haven't used
Coccinelle before, but now I know :-)

Thanks,
Vineeth
