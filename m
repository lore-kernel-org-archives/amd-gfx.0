Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B0D103E300
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 696FC10EB52;
	Fri, 13 Mar 2026 08:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="r3v6YNRB";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 612C110EA49
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 15:39:19 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-64ca09f2170so1287205d50.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 08:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773329958; cv=none;
 d=google.com; s=arc-20240605;
 b=gft7FYZARBFyPnk3ArzjEpbMafcUUv8U8BRh/RXqv7u6YAlOKBGCCXS9euHjN7WWvB
 lf5JtueINr5C3Z2pfMGyheEFQCoW2ydu+/cHrjV1tBltfHPIxXRAcUlLAOiCceUs9XOF
 Ks5/JzvdNE5ooWcU5sR+wVw6pl9zeHVLqhmDZP3yVHQErhULzkvRg/tjXdrofuSRJakR
 HAxePGh0TpwOMbDLYOwwkARrdqLw14ton8eCNuGWP8DxZXC95CdHh1aSGI1QdDx3gVUM
 NdnXWaPsMKF9hK2NO5D/uzIfi4GpOC7QuFcPhCwrRl07hEkolCO/ptgyO4KjP/o5X/3L
 j1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
 fh=5Gay9eb8HgC7gS+vPbK+Gr/X3vA1tHrrkGgjeb3+xgM=;
 b=D/AjIKDbZzaXN5wu862Pf/yy4znpPd2Jg71mg+KRrmF5Lr7Bh8LJuTf0kByVVbDeMD
 4iryhmTSDihPtjpPOu+6LH5/kEXLOTNbpJZ/AUkkv4O8shCHW62526o9wRUPLcBpSkFH
 2kndkulB46jokVCVKxZJQ9ubqJteS8fiCCQjSBS3faJgr/7qQt/d0oa2Aa2kSSvs4wKX
 ScHb6gZeNTUnWaNR3eyRjneqnCVcRV7nntFWLr1LvyiwAWpAok2csDkXPRiVwkow8fdP
 JdoO/fBZKNFMQSARU/AD8KZ6sbwlLW6RQDMxM5cxw2bV8QdY7GW/uxbGgYU9UVQ3B54E
 uV5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1773329958; x=1773934758;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
 b=r3v6YNRBKV8ljpLvUdr6W9yLDlB4cBBWnG1Kdnq5eWYbo/iOO6hDzMn8abQGTF0uCn
 VDZUwQokG7APZTqVdshB1v+SiZzFgXZMrA8CS2HXxoDoP8UMtQK0588YCFi58ZntaLF5
 o/UO0bI+oVEUYzErYQ8Fnl8qY+Edk338xCQ+Ovhd+0QopGQtLyYgmcvf3EgE31Cz3ZL+
 uJ1siD/78TkpGte1orgqlg/hVOU+wqfZYEE71wNKodjAyu+J6U2pUugqfdn1TCe9IfB7
 FZFAT3khfOjZ7UBbxTA3LrUpqSfYJlxIGbBrvfHMtxYI+GyAebxi1qJSn96D/qa7Yggt
 BZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773329958; x=1773934758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
 b=VkUWnSnNeCAYra/xq9WOBWn/JKJ4gWXN7nYg6wdAsEydcCPypuJmsuS0JmFt4KoKc/
 IbXZJTCR7bCQ1/Zcd5o0miqQja1f2OTUYN+J3/D+gaV9XBVw1G0Snfj3OwiQKqYOONKh
 66kkSh5oiNXHgB8u6SVQGXkPOatysXqyclJoskZaMJeWtBk8+byGjx/EC8Fvwy82pycs
 90+zIvXFUnD8Ceb0tbBcFT111smrKM/bQiPpLGNI2D+M45PYWVwrIyOXX2H4NnSyABy2
 e8roVmjsfKM+eiReTBpgiN8FpTa5ibpYD31kteNlNAs9D2sSJkNgRm4IXepcE5eQ0dTk
 yOjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDEFZnefOsUNBUu0N1SJdrU4rGP9x4l1PdAzeeJCSnKLs3PwtJ6XyyQ0VMz5f6SCo+YO3GVxMH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzapH5nBAcRG9+k5TRbfUMgN9fjONPBZLuv/cDGGRKrMi1Laakg
 sFPQNUx4I6QbzeqMYflP5NwNJQDkiMWpZgSvRU1PHp9sQ7YSaStDMQd5k1BfL0utz7XQ6HprIpX
 MK09bAwfkOnfg0wENEBfb1XySAt2UjID7ysMHtzJ7BQ==
X-Gm-Gg: ATEYQzyj1XQf42b/Kqe7jRj9lHw3UcM4bD+UyNOLzwY7bjcgwPek1jeeAWHWN5rDlWZ
 0HIyl1S+H2lvShKRZ4+zm89TT4yjmG8vwzZCnz03NFmAv1dlRSR+Ncx/KmLpZV9Re8dETgkrYc7
 3wQD00uZ+cqrHAHfPKKx6PVovLB7tLbs2mBUJPr5d53oEOsyOXrrd2Awd+/sfgrCufmcIuDYMS0
 gupsNxqS9sUZpiKbndetghDBbpFACp+NAQKDHuiHQNit+hLh7I5Aljl6i18a0LQTiqnrRy2Bs2l
 aM4TXPxvNu8H7J0pOA==
X-Received: by 2002:a53:bb8d:0:b0:64d:5742:5ab0 with SMTP id
 956f58d0204a3-64d6577eb37mr4463263d50.43.1773329958142; Thu, 12 Mar 2026
 08:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-2-vineeth@bitbyteword.org>
 <20260312111255.7925b4e2@gandalf.local.home>
In-Reply-To: <20260312111255.7925b4e2@gandalf.local.home>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Thu, 12 Mar 2026 11:39:06 -0400
X-Gm-Features: AaiRm53MQsKCFNMcydaZ5MLANW9ImopAkQThe-DUzJ0WQT8Ah4MCG48E4vTQfog
Message-ID: <CAO7JXPhg-Etspj9YahZrq8cmZ2K6AGWDrMnHO+oD96P_SmOLBw@mail.gmail.com>
Subject: Re: [PATCH 01/15] tracepoint: Add trace_invoke_##name() API
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
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
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:55:39 +0000
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

On Thu, Mar 12, 2026 at 11:13=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 12 Mar 2026 11:04:56 -0400
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
>
> > Add trace_invoke_##name() as a companion to trace_##name().  When a
> > caller already guards a tracepoint with an explicit enabled check:
> >
> >   if (trace_foo_enabled() && cond)
> >       trace_foo(args);
> >
> > trace_foo() internally repeats the static_branch_unlikely() test, which
> > the compiler cannot fold since static branches are patched binary
> > instructions.  This results in two static-branch evaluations for every
> > guarded call site.
> >
> > trace_invoke_##name() calls __do_trace_##name() directly, skipping the
> > redundant static-branch re-check.  This avoids leaking the internal
> > __do_trace_##name() symbol into call sites while still eliminating the
> > double evaluation:
> >
> >   if (trace_foo_enabled() && cond)
> >       trace_invoke_foo(args);   /* calls __do_trace_foo() directly */
> >
> > Three locations are updated:
> > - __DECLARE_TRACE: invoke form omits static_branch_unlikely, retains
> >   the LOCKDEP RCU-watching assertion.
> > - __DECLARE_TRACE_SYSCALL: same, plus retains might_fault().
> > - !TRACEPOINTS_ENABLED stub: empty no-op so callers compile cleanly
> >   when tracepoints are compiled out.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > Assisted-by: Claude:claude-sonnet-4-6
>
> I'm guessing Claude helped with the other patches. Did it really help wit=
h this one?
>

Claude wrote and build tested the whole series based on my guidance
and prompt :-). I verified the series before sending it out, but
claude did the initial work.

Thanks,
Vineeth
