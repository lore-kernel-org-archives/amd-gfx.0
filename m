Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CF9CCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2B110E033;
	Tue,  4 Nov 2025 08:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="WsdfIlOW";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C2410E435
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 15:58:03 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-475dc0ed8aeso31260425e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762185482; x=1762790282; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ks3pir6UgwzDtWvI5xfb6btd0LOWX1yOz6qXljAdndA=;
 b=WsdfIlOW1+NP/8fzazvASHwywlD+A20dA4MkP5JRGcWAZibqISiwqvYwVuEkSStX5L
 nDa4HITTXxMwujn+NOU9Aqg/yWUP8R9wclUybFyUSOhpS849Dnqj8VTAlIAgDyIcjN+v
 YRn5NPbHFtKPSumqLF4tzaihpq+/wnlsIVgRS8HC91RyIlbujySgXrA3Fxh9rApxRNMs
 Jb6AxMu9pQ4niVoJd3Sv3HNPXFq+OqOThyCfpR2Mwb2sALgnVFJYCvbxXmcskGKXpUsv
 l7PBv8DutbdqadN0ztjArXINJ6+Et/uMr75AhgJAcr82zOjRk5Lj9cFr8oYXm5kGMsb+
 8vKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762185482; x=1762790282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ks3pir6UgwzDtWvI5xfb6btd0LOWX1yOz6qXljAdndA=;
 b=BBcfjH0eNdenML0rIond44GwH3HEVSMJBgPhnyhIqVAesA2fnBf1S9g7XSzMEzs+ZQ
 vVtOYMRJr0iM6Ffe2ZFyh+L1Bb11316I8bvkkDJTZKJUXCcjtLY4tXVkc3oNnZ/G71Id
 SI6ejZ9g8InvvBXJw4mKjwFsJ478uhj+DDJsXswJ8o7n8UM7SaaXurdbrimMYEv0RUM3
 uraIMpPw6YFBTIcLHnGZPR0SpceD3n/RswIO1kqyrbdDLuKtkjuM7lQmpSHF8NuQPv/m
 3MZ5hCoDL3qhPsbG06s7eRpIwBcK8iApT/KsN+9H5C+NYDgyKUXZtJSE31bOOXabA6im
 96UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfrJaRzKFMDP5vd9zGdeiPp1kRhnJhdvLqK1kS0fU0Ox/zRfqnht6HrPx49GMMNHK7d4FqBIgf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRd6edy0zkyWxC0zdGBGIi9q24wLPIjgmqmNlFftjGu/o0zBcA
 wwF9KFAlgbiolV+77dFQw9FH3PhJtJ7bqGhYWCrBPvaNOxc+eoQ+3itWahYlq8kpXe4=
X-Gm-Gg: ASbGncul1VqlwCRvqizKRlXtnh1LLdwV6+ZX9vA2h4sT41TU2SbQm2mmKZD0D7V+E24
 Zuwhf47e5QQ6uYCeinlv9Z5LnUhGcxRucCopkrQcv9tDwjWIocydHm9ZwzTcbuFAtbn4RMGnb5J
 QrK9UdOjVul/pQP325RMpq9EqnhxBhqipG3qZr1Hifbj9aA7a/bj28Ai79XWMNC+FgDYr+2tQ1S
 MzaXiq4qLlVwh5wNMbmuDiBurbSPTGXxJd9Ze3nsw3SJp5SJa7Xtjb5kCL8oUzi+kjNTIDzAXdk
 DmmzTSL/DQD7HnDcRMjuaf07HldiyIwlX9P8Ipj4n7rKeB3+Dt/vT6I1Cwe6fBi1mwe2I14vN00
 9ZnpeaRB15EXlIFkcim4WR9jjhp3h4bpgoIbuP5C4rhBoAxJB6ljs2sCGWIl8dKBepg77rMyCZf
 T6BIKTQKlLWUbcMu6+9rmWQb9pSqOoIxfu6G0=
X-Google-Smtp-Source: AGHT+IH2AwkZW9XycQosIy4+zjrxvNZTD/pU4xDf9vZ24FbI7K8D4vqtE4qlKSR3Kfp8+HSpcK7r0w==
X-Received: by 2002:a05:600c:3548:b0:471:16b1:b824 with SMTP id
 5b1f17b1804b1-4773088be8bmr151144365e9.28.1762185482402; 
 Mon, 03 Nov 2025 07:58:02 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47754adcd08sm48245e9.5.2025.11.03.07.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 07:58:02 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philip Yang <yangp@amd.com>
Subject: [PATCH v2 3/4] amd/amdkfd: add WQ_UNBOUND to alloc_workqueue users
Date: Mon,  3 Nov 2025 16:57:39 +0100
Message-ID: <20251103155740.250398-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103155740.250398-1-marco.crivellari@suse.com>
References: <20251103155740.250398-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Nov 2025 08:30:34 +0000
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

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Because of that, add WQ_UNBOUND to alloc_workqueue users to make sure
they are unbound.

The above change introduced in the Workqueue API has been introduced by:

commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ddfe30c13e9d..a41ebf257756 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -690,7 +690,8 @@ void kfd_procfs_del_queue(struct queue *q)
 int kfd_process_create_wq(void)
 {
 	if (!kfd_process_wq)
-		kfd_process_wq = alloc_workqueue("kfd_process_wq", 0, 0);
+		kfd_process_wq = alloc_workqueue("kfd_process_wq", WQ_UNBOUND,
+						 0);
 	if (!kfd_restore_wq)
 		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq",
 							 WQ_FREEZABLE);
-- 
2.51.1

