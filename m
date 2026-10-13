Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399F6CC6B2C
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99E410FD52;
	Wed, 14 Oct 2026 12:47:43 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C48310E985
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 18:53:18 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so2779605e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791917596; x=1792522396; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tCA7tgHMTElt/DB21Y9IyITwJ975dZJFw/SRY6QoU68=;
 b=ShHFxHXYHMM7jzBNsu5YnSiVDaQhRyPSFsHRw5GVJnP6eKU7/tm2F4BVv+jr61KhKG
 ny+DBCav1n9dkNOfgcXQ4xeRQeIPUua1zlP9E0VuTNaOoBiqBV4+rK4wzwBwEY+3DQ/Z
 c8G1DMO7FK1Dh/QWEUEj/0bnq/YCsuGWUno6/NYDFg3Ie15niYudF+50k3FsZsO5byOl
 IgFosBDhI5XlP2eN4GihbHQmKz5SYc7z/0Jo2t5YxG51OQdHnRGQyaslGeY21CQC1dQV
 yaX63ggd12qdbvWzKnCxxm1rghch/1jX1rBvh3+ZaqHESFBD6HCRDN+wdOh16w/8Qp+d
 1D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791917596; x=1792522396;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tCA7tgHMTElt/DB21Y9IyITwJ975dZJFw/SRY6QoU68=;
 b=YKIcnJ8rJCAi/24BmrndtEq5BTFRv76xG1JXOiG2xqi/C3ld4cNnSPi7TkUhv46uYt
 KR9iRZwArLjZBx1Ytw3kEbeuj/MEfsy5g0webiqEaI1ttAm8Pd3rL5qL0w10jqbn5lut
 HANI/YlDHLvSUchBqNnz+JiELH5c5CdvTu2dtp9aSJDEowx3Jt6Cp/kNSfqj8Lz6IXfM
 hnHNoJqjItp3A5QCscjlbHuoCfeE2J0vS3/tYCZRcIa4k6Bmg9RMdZS7HM6SUlvhEr/6
 wlCqrrSxeJGPY4ky+bhg4siTH0LhJOzOpQlxBD4rn95JN2P6vkTDIUE/xaT8zy47Xugf
 7ypw==
X-Gm-Message-State: AFq9FYINWtc+pjdaRzjJt7v3hBeMgJ7HG8TRaUQDerxQUGIYvMme3bGE
 xi7gMBAjhKY4qsqzfAGWu464VbYTWh9dxAKxGGwamaiaTsjVJ4XowW+kQiuhWg==
X-Gm-Gg: AYBFou388zmujAbzP4br0Grxmq6Ubc+fw29KIHTqafZgOk6c66Jd36D0K2M9KHw8HwW
 jxEPXAbz6y4+oYgUtj+GMWki70GnKi0BCC7MHCetNjsmo7lkng5MZjBuj3FW7iJxylSroMCOBGl
 QGDzs2Yx1f9CFJbwKoOCW2Y7UlqEVw+Fhv/o5KTgMnBDqjDI10tn8FTJvlGWxfRYW1qEuqCgDOU
 8HHh99qUS1JtsLb/eAcBoSSIulPoiGdc8i8L53Qydop0eKzzNd4zZsSzoBtMSQ0AMMfzjp8ufbW
 mlRRmMqX6KEokHFfSjiLo0gJKFxdNxdonkQxyppXg/VNH+q+mUWMXsoBuxmCNB6mPrOeGZdD5mT
 D4UOGr/QZ34xVHvX0e/QShVEArWduWj3PGSh0ZLK9lI039yyygRGrqGy3iR2/6RktqFnJXL7l2C
 y0eZkNmUGR7rPhmryNUAmshqaAtI50jalEbYUJgMJFCTxciqH49R9Xv0xQs+FhG9XYPgALYLfjr
 jZgli1XHOETvyZXGFNmeP0P9NkueOmehxo0vivW9UqbC+L5+kFm8EsjMWhi4OK9d5vNm9ubybMi
 OrC0//UkK4Oj7cLvWwgGR0tCXJyZCq8CUTathIR+QXzqC2fbwWNMtEQb8HEj4q1VDo8o+lJhc5s
 KeJeyg/sqP0C5SuBObOkL28XxTebqER18WR67DQtgshbZcUkP5UU+TAd32iMTrdS+mXMF6UH8Al
 BKJWk4xKhQZ0Euxw==
X-Received: by 2002:a05:600c:5391:b0:4a1:ac66:6ac8 with SMTP id
 5b1f17b1804b1-4a1ac6671c7mr59821135e9.4.1791917596126; 
 Tue, 13 Oct 2026 11:53:16 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:412d:e9fb:680d:a947:4b50:d9e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18d12fe05sm12340585e9.4.2026.10.13.11.53.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 11:53:15 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 alexander.deucher@amd.com, xiaogang.chen@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v6 0/3] drm/amdkfd: fix wedged teardown on surprise removal
Date: Tue, 13 Oct 2026 20:53:10 +0200
Message-ID: <20261013185313.33496-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

On surprise removal of a GPU behind Thunderbolt (MI50, PCIe slot
power cut), the KFD teardown path wedges the host:

- the killed KFD process faults on its own SVM ranges during exit /
  coredump (SIGBUS -> get_dump_page -> do_swap_page ->
  svm_migrate_to_ram), submits SDMA work to an already-killed
  drm_sched entity, and waits uninterruptibly on a fence that can
  never signal;
- the dying task holds svms->lock, which wedges
  svm_range_restore_work() and prevents kfd_processes_count from
  draining;
- kgd2kfd_teardown_processes() therefore spins forever in
  cond_resched() while holding the pciehp removal thread, producing
  soft-lockup and hung-task splats.

This series:

1. tears KFD processes down in amdgpu_device_fini_hw() *before*
   amdgpu_amdkfd_device_fini_sw() frees kfd.dev on disconnect, so the
   drain happens while kfd.dev is still valid, and guards the second
   kgd2kfd_teardown_processes() call against kfd.dev already being
   gone;

2. makes the userptr and SVM range restore workers stop rescheduling
   themselves on -ENODEV;

3. guards the hardware-accessing SVM migration sections with
   drm_dev_enter()/drm_dev_exit() and bounds the job fence wait with
   AMDGPU_FENCE_JIFFIES_TIMEOUT, so a migration cannot race with
   unplug and a fence on a dead device cannot stall the critical
   section or the faulting task indefinitely. A failed copy now also
   rolls back migrate->dst and propagates the error instead of
   completing as a successful migration.

Verified on MI50 behind Thunderbolt (2 GB SVM workload, PCIe slot
power cut): the workload takes SIGBUS, coredump completes,
kfd_processes_count drains in ~9s, pciehp removal finishes without
warnings, and the device re-enumerates cleanly on slot re-power.
Previously the same repro wedged the host every time.

Changes in v6:
- patch 3: check svm_migrate_copy_done() return in both callers; on
  failure release dst pages, clear migrate->dst before finalize, and
  propagate the error (Felix Kuehling)
- patch 3: dropped the dead ret < 0 branch (Christian König)

Changes in v5:
- patch 3: dropped the drm_dev_is_unplugged() and
  pci_dev_is_disconnected() checks entirely; drm_dev_enter()/exit()
  plus the bounded fence wait is sufficient (Felix Kuehling)

Changes in v4:
- patch 3: AMDGPU_FENCE_JIFFIES_TIMEOUT instead of an open-coded 10s;
  drm_dev_enter()/exit() guarding the whole migration section
  including the bounded wait (Felix Kuehling)
- patch 2: folded in the svm_range_restore_work() -ENODEV change;
  fixed a latent uninitialized ret read on the evicted_bos-mismatch
  and confirm_valid-WARN paths

Changes in v3:
- patch 1: NULL guard for the second teardown call (Christian König)
- patch 3: new, fail fast on gone device in SVM migration paths

Changes in v2:
- patch 1: drain before fini_sw instead of bounding the wait
  (Christian König)
- patch 2: new, stop restore retries on unplug

Cc: Christian König <christian.koenig@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>

Olivier Kaloudoff (3):
  drm/amdkfd: tear down KFD processes before early fini_sw on disconnect
  drm/amdkfd: stop restore retries on device unplug
  drm/amdkfd: bound SVM migration fence wait and guard with drm_dev_enter

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c      | 29 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c           |  9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c          | 97 ++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c              |  2 +-
 5 files changed, 113 insertions(+), 29 deletions(-)

-- 
2.47.3
