Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9064CCFA07
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D2410E54B;
	Tue,  4 Nov 2025 08:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="X+b65Vnw";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F8F10E434
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 15:58:04 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so24676875e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 07:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762185483; x=1762790283; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSjslf49+4C1KeXizurd3u1HRFo6JeAJTXRM556HvGI=;
 b=X+b65VnwGamedqlRBC3nUBTdTvkA1xLkaLZT31yrWPcLcNmMF+OKMAvnQIEMwLluSz
 9GofmgCNthQebg+oW9Vw0UdJKkwWHuayNtdKXxHUsHiHJMr8FF3+bpHeFhjDywaN9WWt
 SSSBgxAqkM1m8C1jLgK+gCblpHg2DcYViPd1t91zooNA0YFi6vjW3DOimLDzmvTbM+pF
 fgjdKdnG8TBAnME6TUQjbB/zu/xGQMIToPiI6nu9D3mzz0imVZnhjCs7OHTKRPFUvRct
 ev7hpV1rDbtA9KxOa16h5FwjoUK6H40x9vCOdqf+3uUgZkmubY7fotPHc0AJx6XHNxA0
 UnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762185483; x=1762790283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSjslf49+4C1KeXizurd3u1HRFo6JeAJTXRM556HvGI=;
 b=W3unN41a7yypmmz/M499AAHdYxhwwONSo5Gp81QWFZThAHWS24BbFfAjWLZGG5ZKdN
 tVqQUzT6K0MBjleJFNnpNlxXVSbp+rqsj6XG9FuyJqk4aR4e5uWlRrDsaU3KTIzW+STj
 UMHJOZWYW42QJY2sgMants02AC61+qjuZMW8emd7+1BSRdZezi2H0yIKoCiZDaLMfuZ/
 NCkydajjTWsCYegJ4NKierFTTaJzmHP5JpsyiGSmyOyz3WQESxLsspMOTkcp0CTm4kl5
 DVAyxmLz66yZ8SCJMlLca07nV1HrFPwqYz2kG8VGlsjCEpIeNAh3Z+KBgdDP19KM8cUG
 Youw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaAjjV5I5c5YmZ26aBXoD1ZigC0fHCerX998RrY23EywWTFoyUvldJYmWn3ePqPWdSsDV4r3WM@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz983h5/RfXoL/1jUTtGZJA2zrJ4shJO7qgjvZl6PPI2XXnu8Jf
 0DcURhaaTQldhK8ZZg30316SktMBK+NzgsGWkM1Vv+pp2ZD4PMEljKZ49oTS9roNXNA=
X-Gm-Gg: ASbGncuxtsyqC+auMFYkfHUfZxNXus2TbO5Hul3tDTE1teyudqIyTL5Xm0E1oy4a9Ae
 RT1duxdR3KYCZUHlbk7zyVjk5dMnspBWfC3yQN5Au7BE9RI/ZC/APj0z0GzPvIBLQvH96fVn/LN
 03LxXHVwdwkRqvh+A3rii+drRlMjjCGKGlK9nAnCLrQM9v6t4Dknk6pih5uOb6vjEnwi7U3FWjv
 mVWugSQDFsdqj6as+5Tf0CiyxWuRzA8v8ZwWdroxEgH80oj8NiYV9Omee9AH2uKxplcUbIwoWGg
 2FOAcNYytiTpOJ1BqbWRCX7mOxhpl1xjEJl97q45N+6FJdV2bMFqYHUpWl/hn6RYN3mm+5AOpMQ
 N7JFDLqopgRpp/iVvYP62oOusLr2CFIX8IZ2NFLY+2T5WtVGdHbW/axKNfDvFdiR+eaeghIS4ax
 dYG+OPx2uW7OXh+0a4SFcabEsUjk6HBOqqLB4=
X-Google-Smtp-Source: AGHT+IEBOwqlZ6rp5xc4yApoAq4SvaoICYZIEJ//QiOLN7wf/ONd9RM56bwB3wHPfebuEpSn8JNvnA==
X-Received: by 2002:a05:600c:b85:b0:471:9da:5252 with SMTP id
 5b1f17b1804b1-477308900e0mr115180965e9.29.1762185483424; 
 Mon, 03 Nov 2025 07:58:03 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47754adcd08sm48245e9.5.2025.11.03.07.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 07:58:03 -0800 (PST)
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
Subject: [PATCH v2 4/4] drm/radeon: add WQ_PERCPU to alloc_workqueue users
Date: Mon,  3 Nov 2025 16:57:40 +0100
Message-ID: <20251103155740.250398-5-marco.crivellari@suse.com>
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

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

The above change introduced in the Workqueue API has been introduced by:

commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/radeon/radeon_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 351b9dfcdad8..3c8aa5274c51 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -687,7 +687,8 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	if (radeon_crtc == NULL)
 		return;
 
-	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc",
+						  WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!radeon_crtc->flip_queue) {
 		kfree(radeon_crtc);
 		return;
-- 
2.51.1

