Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F514F4613D
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 09:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6238210E641;
	Tue, 24 Mar 2026 09:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Wj4fEqwb";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B666E10E42D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 16:01:21 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c2af7d09533so2674896a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1774281681; x=1774886481;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eViZzzv8Sc/M5QSGBQX9CwMHZ/34uumJnzvDlBpaGpc=;
 b=Wj4fEqwbCQkp4L7/JJxJrpsZDmeAVtRQEEa9gcTWv8UJHUdo/f1O5tf08SHE/R8cV0
 O5i/P7tz6Gi87e3JyGJXwbnwF4a0nfOVX6DV7nFZ1ASfxtEKm1NV3JPhI1Tdv2x8POwZ
 hmTC7xbKc8Zs/nzU3cGNeczYdnbsW4kWQcxrmV2Idgy3ZCdzAfvlMCCSnwrU5VJJolMV
 1rKOBOyL6fA6UEek/F7CnAJukwIaXaGMTkitAPrXqwM0l4ena8yuLACGqft2SXBg8p72
 +EE7PVIGUf2u6zm1yGPzA1ixPJYQyO9K4vWzr5rPhc7XbUd6UqjFI2zwNH6pMlTPuFIi
 GgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281681; x=1774886481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eViZzzv8Sc/M5QSGBQX9CwMHZ/34uumJnzvDlBpaGpc=;
 b=EL3DCdPQ/JzX8Oaeqj6CAl2jZBba+PxjgLKwxfxDBxOf+mpf4TZIW6DUGsH9sItrLU
 937J+CmfLtH52LY9eaVLW5RirNIktyw40hCgMO6V2FEHYq5aigXUPJ4KOPxrrf6bgGNQ
 fQIP2XXCmp9vw8yDUb+r0Vyni/CFJ3PsOC1y8UYWhQw9UAl24E8/XHGLK5Nc7KGhgfP7
 W4ZmE8pWYO4FrMqtPUEgxh5klLeXq36aTi1xyns7oGS1vxfE2lkuERReKrbJ+8v4aWFR
 g23Sm1fvHv9iej3JZXhVBiqRCsgTFXKvcmVjLT/sGbXw/MrSTtRi5I4FA/hp+uCNojMs
 fXfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbwTyrgq1ykMMJGh9JDFiFDgq3A399FuacBSbQHN4c1jo38QTyQA2MVui9OPE66VeyIMQ33EAq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzP6r6HEnKydtqty/8+D8zQEUzBdHv/E7+p4NSaqUPWoIBUFwfe
 JL4kDCSFmu/6reKObfXpdnUhP9w6HNILrv7R2BT47/O0kb9IjXRentZpBUo996kdsYc=
X-Gm-Gg: ATEYQzyaaJc1TzwobMOrqChigcmE3mFt4SdeNNI0zk8BHH+IrD68JiUlo6RaiORQ3mo
 EfWCzQUgac0F4BSt6glMq2UAdzGQWYdXDXxf1e3QSMIeRkDpcpFHIrQu5QBldyN0J+WVA+Ygxfp
 +0+wcKBSkSmZi24Ra0FjWemq5ms6tNwPSmdSFsEOYHcHnqH/EpvPHJITdnH0hsy0z8g6EPyis/n
 ePKHzXUpd1LuG2LW6bSprKlxRnzkBU2fT7NH0yK6LjQJ/U8/p+ozCjwRDVSmVCClwtmRfrBT/wB
 zzj+a7AAHMoYhngqlII6Qz8vbPBbB6pVC2DFMzJiTMugmmeJUKwwOOA7Ms/2KItl+lEpNFKTzzZ
 id3UmUuLHPSdun74DhUoKm1RH0UXmA64M+pccWy6ryingVo6TVf3iLree0ed8oMhlQkW/0rb+Uq
 1u8XRDJN09p/E2tMQxl2pfxshyQwVAwHa24UuCxXnIYuwtUI06X1yjzjszU8EGnAvu1Q==
X-Received: by 2002:a05:620a:198a:b0:8cd:8d4c:aa0c with SMTP id
 af79cd13be357-8cfc7a796e7mr1828317285a.0.1774281661473; 
 Mon, 23 Mar 2026 09:01:01 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net.
 [73.143.21.186]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:01:00 -0700 (PDT)
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
 Jiri Pirko <jiri@resnulli.us>, Oded Gabbay <ogabbay@kernel.org>,
 Koby Elbaz <koby.elbaz@intel.com>, dri-devel@lists.freedesktop.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
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
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>,
 linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/19] tracepoint: Add trace_call__##name() API
Date: Mon, 23 Mar 2026 12:00:20 -0400
Message-ID: <20260323160052.17528-2-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Mar 2026 09:12:39 +0000
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

Add trace_call__##name() as a companion to trace_##name().  When a
caller already guards a tracepoint with an explicit enabled check:

  if (trace_foo_enabled() && cond)
      trace_foo(args);

trace_foo() internally repeats the static_branch_unlikely() test, which
the compiler cannot fold since static branches are patched binary
instructions.  This results in two static-branch evaluations for every
guarded call site.

trace_call__##name() calls __do_trace_##name() directly, skipping the
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
index 22ca1c8b54f32..ed969705341f1 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -294,6 +294,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+	}								\
+	static inline void trace_call__##name(proto)			\
+	{								\
+		__do_trace_##name(args);				\
 	}
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
@@ -313,6 +317,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+	}								\
+	static inline void trace_call__##name(proto)			\
+	{								\
+		might_fault();						\
+		__do_trace_##name(args);				\
 	}
 
 /*
@@ -398,6 +407,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE_COMMON(name, proto, args, data_proto)		\
 	static inline void trace_##name(proto)				\
 	{ }								\
+	static inline void trace_call__##name(proto)			\
+	{ }								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto),		\
 			      void *data)				\
-- 
2.53.0

