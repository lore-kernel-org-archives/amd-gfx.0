Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97522107BCD5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D3010ECBD;
	Fri, 13 Mar 2026 16:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="OUXLcKf+";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67CDF10E120
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 14:02:46 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso2323773d50.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 07:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773410565; cv=none;
 d=google.com; s=arc-20240605;
 b=a4Q2Irz6eSBxSlqZSulmgirTL8W/0UaXQpugt0J/mMRIFt9FvKLqubrXK2usmCcYf5
 uU1yIVee1Bu9/ye+aNsg/J23by4+qsK31GF/PScx+4pHadSb4/2LpV2i0m+NquW0rUHg
 uTOgGUIR2Sizj4/B9hywbj9FHyZGhPMi29ikT7NECi044bwurURcbP/OEG1F8qFR9CNl
 Du8jWKrqZAgusXWy4k/8e67rzp/B08IPbiwXtMKu4QY0Md1NX4VYtlscpFCOqdH1Ii9R
 lvTypqdCPheafafYPsUTRNOheoP887i8q60GzclF4OzxrkZr0WrtGdYVGTo7muMSuJKn
 c8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
 fh=6W8sOAh8vuVRtAWKls/HB5BpgUUgz1HVcn+4Y4vYNCI=;
 b=F18ohRg/xLGxSfBLdupWCdxzERlcDsx0n/ba6mpNrYru6yc3nXL1eFItNP+7YexcVR
 CJS2Fn9c+C1WhrioR3yKsrKKZfHOmV/minL3+5fv+K4tuWgUScev+V1g+Sw1Hm24TTym
 vE45KSQfyvWDZnJBQOWYye6Jm9pWNFSNbtI/6XshEpaXGuxkFiGnjZI72ceck0TmIQKg
 +K62OPRdG1o+u2n7whCMXEBIeKBLr18N/Vh4XnZWHnxaD6oyODiLsd5zz+gwEdaLckOA
 pdSTLYokcRFzmwro+4zrmFYhpO9LR4HA08cAldr4AsyNd28YNFHJ7uJeU76k5R7KU90+
 Ge3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1773410565; x=1774015365;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
 b=OUXLcKf+YxtlG+gu5P6spfXm+Rd+FyDQSobBvy5ObOZv+K9msK0AizkIFBfwpuwV2j
 8goaxk6Mw3Oiel/n5AP3Wir5nu9vY/VtM490IwubJOw8z3sgBkJIJsWCBQ7tGPgVH4bD
 1KOT35FXflCnoNJF8Hf9EXNbZY7+8guN6yziCmIWgaZqYQZ2OJ5VlxBCh263gWfCo6Uf
 e6Yqwmy0LKc8sgcNl+UJzhCKgZooSyyrdUPZgs2CBZ7btBZWXflBmGCLLDQ+Nzjctmux
 Rpfb6Ms30RtQjdcIbR8ZZmOuxYtdVTHLm8a0QcLvJwWwNBL8GqQaUEbTH2a+j23vq5BU
 D2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773410565; x=1774015365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
 b=ol+utomEcv313ElPK2fwt+IohGaka1IPIUv0/ik7z0fkO9OtutpI+Mp0XigF++YFaB
 zoLDF86Qb2ntJE9nCqhrAHaQpxht/KCm95kG4+coITXCeys2JgN0IChBFqnReTW+Gm4N
 xm014FGPkQAvsVi800tD7mSTv5UAYiur9sX51ceTsuaf83O0WpFYW5f3dhVEusBTP6cR
 JY9QU7UPYBxVBibW4fVVY2RnsxY0YxmxaE6TIUOzizT6oN0E8TfKcS0lGxm5VU4Prrqx
 6l6L7WaPg1YMp1tAMGv4VOCHq6pAFXN9Jp92cb9VEsPFpnIaHuSdDmU0+IGIYwLhtrLt
 i/xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYI5s6C+70BJy44ifbIugsFiBEjDdCUKt6ia7G7AM9n0J7VqlVqy3EvjsfGnc7tLsTPO5FG5Nl@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8BPtqQXqR/8VIRmRL6G0qtiRT1vq+z21k0Ds5kK7AHUoRl4H8
 Ji8Da2zOGMWAazmyRC4/L/zaVLI49Nvn2Z8zFqvir3CHzEd2PhOP/2eLXnfhR0uRifBxXVCirpN
 6JkQAwY68ddcfIHQXPAnV6Zyh4eoI9/oPl0Ntjtm2pg==
X-Gm-Gg: ATEYQzy3Uwz+kuM6WHapblvRPzEQLPmILdvb8Y97Mp6zXP6tUve5byu5lyOOK8LkSQL
 su1YUfe641uy2xEyD4qzWkxVoA1pjmcODfWokvimAzCI7177gVqid7X3yrS0rPQKDAhwAlbriD0
 yHU8qUbg7C8e6xkjC99d/Yk/5Wtq4ajSMS1GTV1VjL/YdYGpY+Q/xyYFeEkVsFKdsaT/m0qE0V1
 86DP99LCbOCsrq2QAWcA5qd2LS8ObKkQfc7ZgFKd/PPAea4U6i/xSsGaQVxVt0tJDaocwyOl+G8
 RmMQ7CY=
X-Received: by 2002:a53:eccf:0:b0:64d:568b:bcb3 with SMTP id
 956f58d0204a3-64e62eeb40fmr2691449d50.9.1773410564388; Fri, 13 Mar 2026
 07:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com>
 <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com>
 <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com>
 <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
 <CAEf4BzbnfyhCqp0ne=2gRnVxp-mdGmuZwDeFRyhRYH+eDcz2-w@mail.gmail.com>
 <20260312130255.6476e560@gandalf.local.home>
In-Reply-To: <20260312130255.6476e560@gandalf.local.home>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Fri, 13 Mar 2026 10:02:32 -0400
X-Gm-Features: AaiRm51K5Hc3O7_rOVK2jMiMzft9bvuP5pyZ-VF_j7db91GKvyylhuGDp34sRoA
Message-ID: <CAO7JXPgHYZ9zF1HFahb2447X85YRZCQQBHB6ihOwKSDtiZi8kQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, 
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
X-Mailman-Approved-At: Fri, 13 Mar 2026 16:51:10 +0000
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

On Thu, Mar 12, 2026 at 1:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 12 Mar 2026 09:54:29 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > > > emit_trace_foo()
> > > > __trace_foo()
> >
> > this seems like the best approach, IMO. double-underscored variants
> > are usually used for some specialized/internal version of a function
> > when we know that some conditions are correct (e.g., lock is already
> > taken, or something like that). Which fits here: trace_xxx() will
> > check if tracepoint is enabled, while __trace_xxx() will not check and
> > just invoke the tracepoint? It's short, it's distinct, and it says "I
> > know what I am doing".
>
> Honestly, I consider double underscore as internal only and not something
> anyone but the subsystem maintainers use.
>
> This, is a normal function where it's just saying: If you have it already
> enabled, then you can use this. Thus, I don't think it qualifies as a "yo=
u
> know what you are doing".
>
> Perhaps: call_trace_foo() ?
>
call_trace_foo has one collision with the tracepoint
sched_update_nr_running and a function
call_trace_sched_update_nr_running. I had considered this and later
moved to trace_invoke_foo() because of the collision. But I can rename
call_trace_sched_update_nr_running to something else if call_trace_foo
is the general consensus.

Thanks,
Vineeth
