Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA88CCFA00
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 08:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 995DE10EAC9;
	Fri, 31 Oct 2025 08:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="dsCwq6ap";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FDC910E9FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 16:10:22 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-475dab5a5acso6814195e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761840621; x=1762445421; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z8txnxFWEuSZEvyBpZsokJZwR4vlD1MJiynWZzM4iDc=;
 b=dsCwq6apHDetq70bZoTeHPanLm9d7vWBga3guhnM7KRLFgZQ6/MVPXeDimm56VteU0
 L7YCjEphSe5YLQDI0aLnIkDnY7T1DQUR/APYwugUm+CAzpTyHKpAn5vcDP/KAM8FGwVB
 Q75/Yki1IPLnOYyxf10xkaOBDt9Y+34KwBtVVRIZ3uv02NuWEUo+hSecHKeDhAm+7TZ/
 oP7kC72koX5P5Zrl6chLw2TUhS8DxAKOyeDNKIY9a5tJS6QEnN18Ja1krYNITRU5hN5l
 Mf9iwJ+QzwIPNsIHt3OMtBzPYUZDvi/jAWtmWWYe4pfcv6x/YJbmv04mJV6QfEf8wyI8
 Fd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761840621; x=1762445421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z8txnxFWEuSZEvyBpZsokJZwR4vlD1MJiynWZzM4iDc=;
 b=HpagqyoJoVjMGOmkXZvZx+Gq9b4eSDhkgeYoAQSZjMe8o5vuOjnlMAwcB2Spn2cIFu
 o38r4h8b+u2Z8Ey26LMfnB/rcCx+8kiXGmlIg8ih8EQqD194Dz3eeWNo2b3bYjwPLnIN
 gU3lGR4MTLQFEt8Sw4bNBKL2nS57pnKm49x01j4Fwq44m1Skp3d6OfX3uKDtmYDCnKzq
 lu58aA2kOW2MCS/acruvfkiAva5tM1MUoqL7CBkKf+KG2KdB+RqPciF2ynaNsGzG2RDq
 92HMdrctpWQUhHYiqtIss6n8wf6ctHSz1mteMRJesVMzOBOi2IneNRQKEs0ttXm9Ib5O
 f9vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4bpEnvHaEa45iX5d5eKOebvD+YWyNqM98leFHFG4BUdaaYIe3ZLKZh1Xdn5CBJeY/te4e7Yqx@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywe4j9XUJK3eP2RSBlJoeJwvkEsDQQ5aRKrojK1na96NnUrhgZ8
 HplANR08Qgx5lXsk1MrOrZDrqXBW4hedfUS79xDAYey1EB6ppbIq9DxRwFC7d5+Mzf0=
X-Gm-Gg: ASbGncshLVMK9nHbcbAAmhyxLFGAJ3X+3dBt+SqkRaeTXm4XsAjB3nYYqV/1jpFAGPL
 a2pVj+vBQKxt4DkhLiumjpJmXeLlDYHuLsbg2CYKyuEgrK2/WT6oZwB/RqOBC5EW/6Jeh2ILEfw
 s6F49LcvsNNAECkHUDXtMfw0sjnefFHyUEaUUPs1Rr5ENU2rwqn4f95xwmr9n3FdNW/yEks7PGa
 VC6gu/34u/q5VrubKkQscbaYJMIb8XLYVTAJBw/cilCCpX8ojXEXQbgJ/ESKXqkJI4BHSU7Ti2b
 bQAVuf3+hp5ye8KHZACAJilv1EQwiDp51QxbNAzTuBBzV06ctHtQm/y9nNkkVDr9KxrppyXYKYk
 yYwVHuc4L43kbLB72o2zXyEITlbwKln2BXQJ2R0SYBTHCxMp/FAtB9gP7e1mzaIDfokWOiLMTfd
 XhOz5geNW3AC8fXpQ=
X-Google-Smtp-Source: AGHT+IFUABxe82sEBxNr7aGuyc63kqBiirRpp/f4wHw9QtuKLHHuTYMkkkGE04OiUmg1LArsF4Jd1A==
X-Received: by 2002:a05:600c:a345:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-477307c3595mr2031835e9.10.1761840620842; 
 Thu, 30 Oct 2025 09:10:20 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7a7csm33124857f8f.8.2025.10.30.09.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 09:10:20 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/4] replace old wq(s), added WQ_PERCPU to alloc_workqueue
Date: Thu, 30 Oct 2025 17:10:07 +0100
Message-ID: <20251030161011.282924-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Oct 2025 08:12:39 +0000
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

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2]  Replace uses of system_wq and system_unbound_wq

	system_wq is a per-CPU workqueue, but his name is not clear.
	system_unbound_wq is to be used when locality is not required.

	Because of that, system_wq has been replaced with system_percpu_wq, and
    system_unbound_wq has been replaced with system_dfl_wq.

2) [P 3-4] WQ_PERCPU added to alloc_workqueue()

	This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

Thanks!

Marco Crivellari (4):
  drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
  drm/amdgpu: replace use of system_wq with system_percpu_wq
  amd/amdkfd: WQ_PERCPU added to alloc_workqueue users
  drm/radeon: WQ_PERCPU added to alloc_workqueue users

 drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 3 ++-
 drivers/gpu/drm/radeon/radeon_display.c    | 3 ++-
 5 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.51.0

