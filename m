Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A671FE77361
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Dec 2025 15:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D550810FF4B;
	Wed, 24 Dec 2025 15:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="NcKKz6vi";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5120D10F87E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Dec 2025 14:47:16 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso3097106f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Dec 2025 06:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766587635; x=1767192435; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4t1E/MiUGXvLFw/kkXL4Czha6KPayCy2brE6GCYi5/M=;
 b=NcKKz6viv0EchhEPQbSbwmDNJlzdcruKgd27+0vUs3s8D30BfBnxTs4f4s30syYa+M
 lvhshqfB+J75kokOL+3IGbeHtCBoCCDNSXhEw5H9aXPFWXGY6svjFM9gvDik4khpbhY9
 g/5q119AypwU5zk23iwQcNYDj6xcBOVqhmGnw67qNXG6PL4b5w3O7j2mrJ+SJ3BvDT1r
 2IcelqenoK8/DWD0lXrGivIUIW25DOXfEVa6q/9O7HvZeT8ZBev1nZEnk75XUWjSjnAF
 IlxKZZccj+qWbci5cFsLz5MOPKoM5XhaLmHwJLGwpWUutaljpJRsUCvN1SLvrHk1mdr2
 b+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766587635; x=1767192435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4t1E/MiUGXvLFw/kkXL4Czha6KPayCy2brE6GCYi5/M=;
 b=CKvq+PC+J3WVm7mmPlX2nnD+SfwJPQJ3L4XVUWZhae5Zt8ChPNJdXoitEuLbbVuY6K
 ga6wiMfwcr5+g6wLNT45SN9K00D0aWsms23Ii+bSkJ7GNHsSLTcs/jWeW/M5OJ8A6MY3
 5uzvrd1x4SPS2xz4A0vYn7MwRykUtNPRzqx4lORXGmid/txQxcnT+HgVF49IEYHqzVy0
 IwoGXHgpW6SiM+nrv66r5sckQFzBzYCc1pZIRkeQD2vynL0g81l8F3VIIEnSA+amUzes
 2lMAIBrZvtpFMSUDb/WRc7bIcIia6Ij5iTOxRylBdyHi9zCE02o1WEWMPB+FL8lwpd5X
 uoJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSWWVkE+z7dPhl2MfqQjNnTPGWR+dl5PRjy/5/rWsksRFoXEpi+vti/khC59qiAOVRQIdSMIoB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJu+3cJdTVBaBQJfsg984aLAKgvJ/hlQfdrCnyWDwCR0317rpS
 eV2guSEGRZfiivoWPxDm3COKIhiTskYGGliSSYboHoFV8aejFaPJws/pTjzmBn0Xxow=
X-Gm-Gg: AY/fxX56AZHyxZXMZA08CSZ2oPWtcWT8lebV0QydNj8cROaDZCYp2zWx8XCCN+fg+gE
 yw62t8iOWazimcYTo0L7YlWHYRXXC/r5h67ELznfadlZUlzJGVI4E/h4ZFoCrY0/FNhwGvSHrJS
 t+dz3DNyEyCkOKcoYtbYteJcEX/CtOI8MT+81RIIgW4s2UCItUitt1fnLdKywZVmERJ8YPg6psu
 HyNxAg+oQd9JBg6yd85/Uq6ZcXYSGiTteChp5l+fv7NWf58syn+aux2pUCm4rKAv07sL2wic3hF
 b03szZoIE23sfl4ARKY2vYyR1o+j4+pUbYljRcC5pk8NBBW6P5qDyvb+H6KKLsXa6sdvpANh5Oj
 IIAi/TkQ9+udcIqVziOQV8DqZoUls//sk1wXGvxilUkFd+aOSF1V2MMfGoKvYZ44cvgfkermFJt
 A04gMFP/GIC1tIOzAKP/vwdNBUPGDc/qxS2Q8=
X-Google-Smtp-Source: AGHT+IEKJeulhrpJLgbK9dpob+8IyJ1NCy1xxCMBiGm/xAEDmeBwBfPB175oOr0phJbTC6PTpIqLpw==
X-Received: by 2002:adf:fd4d:0:b0:432:586f:2a9d with SMTP id
 ffacd0b85a97d-432586f2bbdmr11861326f8f.32.1766587634756; 
 Wed, 24 Dec 2025 06:47:14 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43277b82a58sm1041109f8f.6.2025.12.24.06.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 06:47:14 -0800 (PST)
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
Subject: [PATCH v3 0/4] Replace old wq name and add WQ_PERCPU and WQ_UNBOUND
 to alloc_workqueue users
Date: Wed, 24 Dec 2025 15:47:04 +0100
Message-ID: <20251224144708.61167-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Dec 2025 15:51:46 +0000
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

    Because these specific workloads have no benefits from a per-cpu wq,
    both have been replaced with system_dfl_wq.

2) [P 3] WQ_UNBOUND added to alloc_workqueue (amdfk)
    This change make sure alloc_workqueue in amd/amdfkd is unbound,
    explicitly adding WQ_UNBOUND to the alloc_workqueue() user.

3) [P 4] WQ_PERCPU added to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!

---
Changes in v3:
- improved message commits
- rebased on v6.19-rc2

Changes in v2:
- system_wq replaced with system_dfl_wq instead of system_percpu_wq, because
  a per-cpu workload is not strictly needed.

- use WQ_UNBOUND instead of WQ_PERCPU, because this workload will benefit
  from unbound work.

- commits log integrated with commits about recent Workqueue API changes.

- work rebased on v6.18-rc4


Marco Crivellari (4):
  drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
  drm/amdgpu: replace use of system_wq with system_dfl_wq
  amd/amdkfd: add WQ_UNBOUND to alloc_workqueue users
  drm/radeon: add WQ_PERCPU to alloc_workqueue users

 drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 3 ++-
 drivers/gpu/drm/radeon/radeon_display.c    | 3 ++-
 5 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.52.0

