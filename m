Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC96103E305
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF22A10EB49;
	Fri, 13 Mar 2026 08:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="LZq/2ZuL";
	dkim-atps=neutral
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479C410EA34
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 15:05:39 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d7653db148so821262a34.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1773327938; x=1773932738;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cNc1V3lTb2QUW0xjd0W9BOVRtnhujjy4WaV1yGr6BKQ=;
 b=LZq/2ZuLY9AgMoYSWTubX/qsG6sRFdco6GSeMtPlizBO92vftgr1cYKukcuJIpiFAV
 Sazbu9ftqSo5vPflBZEV8gvCt/klZ7xCTzviVH9iaVdhU1h22mWJ1FS41WWyU0iOkcHd
 seHvraATsw3KUoIZfZgxzakRExs1+vVOisNfLucfw75gfa+TCdnf36+ezjf7Tm2il4uQ
 zMBMKeFv51OkuBco7wZPBBX7I9Mf8ACh2B5NVWeCQSI61K0sCZTiEeVk4mcWeYD0IkSO
 UTh56AcTnq8eDeS8fMd1s7ZUkH2ipXKuXOevJdJIORqgJaRtG666amDo3FpsYPeL1H4X
 wPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773327938; x=1773932738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cNc1V3lTb2QUW0xjd0W9BOVRtnhujjy4WaV1yGr6BKQ=;
 b=JhC3ObfoNRq/wMQb1jwLTQXmVftzfIe5EA5Gwp7K8d45HLCm92x3fsytjj3IXJdsFw
 4AjSyqHUnf8A5xbFSK219XkZ2/VfUyZ0KSdgtercDjYZyZid6QJWUW8tYeZY8KVu+MdJ
 3bvQgsiQDzLBKFwYAzRWVN1lXtPUaz4dVci1s0LyhYQTicVHsRkYUaiV659c3I6wLa+o
 3KdM7EgyPFy7xValS+bf8PndnwvRDmkOhMnnsytXeIEA25VdaJE9AIyNffH5uZrit1CU
 l7LO19zuWh+tDzmp7hwUmdW2w8ARI3ze3yLFSn0rahZZBTvNl8q95Xy3aNP1KutUxIhN
 QwPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHSdnK9qmA7tykQ8JIYh4zTNS/bHg9RO9/idAL3NCldn0UFZIh0rDPQTdOkbCwAZvy0feaCaz6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoqyXDY6PjItBYGbWPwE2ynJk8YrhVKM2HuFl94rS7k7phCGW4
 0LMmGCcXVuHZPg67FhJU9jEi2NuYWyEKUGIbLpyltNxPqju26f1iURu088k02tOBBpc=
X-Gm-Gg: ATEYQzzmI1z4XuiDKR1qJ2OFLPgJNDoM7KPd5Qc/ikvESryCCLaEQKUVZa4/HSoMuKz
 lponxx0m4c2FOaen+0ZZPEotGs8qCYgu65H+60vl7pq4yypaaT1lIUVNTJ3gqbUmHnFCle+D3pY
 nisk51o//+7+52GzYu/ij+OvxmIN0eit4CtZuGq7PQPTJDw8iVFKwjZgRIPwZl89Sg71r2/FT6V
 TA1XNFwnDYTiZjsB3AfluYnPInVgInzBel0QHKDOEDELCpfWxBIGTwomJ+ZLOSm6yW4ON7J05uI
 bzb7d5J+eDfV8YgkdGIO183YaT//jO0k300rHk9UuIuHdw6Ip+v5A+6g0nHKwwLguAdmUEJlZy0
 p2396YZiCumgR0brhtkK3IvrQdH0vUWBonIfpFyaf97BbBoFG2R8KYNxS8y7rh9AU+U8PpqB8/C
 hXaTY1Q6bya0g7KaqWXqW9WT27fECxSGHlIZkKYsNjVz8V9T4HyA049km9MtlBJlxjDfEGlaWkE
 o0g
X-Received: by 2002:a05:6830:3113:b0:7c6:d001:afb2 with SMTP id
 46e09a7af769-7d76a85b34cmr3668805a34.35.1773327936791; 
 Thu, 12 Mar 2026 08:05:36 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net.
 [73.143.21.186]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 08:05:36 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org,
 Eddie James <eajames@linux.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] tracepoint: Add trace_invoke_##name() API
Date: Thu, 12 Mar 2026 11:04:56 -0400
Message-ID: <20260312150523.2054552-2-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add trace_invoke_##name() as a companion to trace_##name().  When a
caller already guards a tracepoint with an explicit enabled check:

  if (trace_foo_enabled() && cond)
      trace_foo(args);

trace_foo() internally repeats the static_branch_unlikely() test, which
the compiler cannot fold since static branches are patched binary
instructions.  This results in two static-branch evaluations for every
guarded call site.

trace_invoke_##name() calls __do_trace_##name() directly, skipping the
redundant static-branch re-check.  This avoids leaking the internal
__do_trace_##name() symbol into call sites while still eliminating the
double evaluation:

  if (trace_foo_enabled() && cond)
      trace_invoke_foo(args);   /* calls __do_trace_foo() directly */

Three locations are updated:
- __DECLARE_TRACE: invoke form omits static_branch_unlikely, retains
  the LOCKDEP RCU-watching assertion.
- __DECLARE_TRACE_SYSCALL: same, plus retains might_fault().
- !TRACEPOINTS_ENABLED stub: empty no-op so callers compile cleanly
  when tracepoints are compiled out.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 include/linux/tracepoint.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 22ca1c8b54f32..07219316a8e14 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -294,6 +294,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+	}								\
+	static inline void trace_invoke_##name(proto)			\
+	{								\
+		__do_trace_##name(args);				\
 	}
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
@@ -313,6 +317,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+	}								\
+	static inline void trace_invoke_##name(proto)			\
+	{								\
+		might_fault();						\
+		__do_trace_##name(args);				\
 	}
 
 /*
@@ -398,6 +407,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE_COMMON(name, proto, args, data_proto)		\
 	static inline void trace_##name(proto)				\
 	{ }								\
+	static inline void trace_invoke_##name(proto)			\
+	{ }								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto),		\
 			      void *data)				\
-- 
2.53.0

