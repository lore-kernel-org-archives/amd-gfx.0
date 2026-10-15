Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D2BCC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A54E110E5BA;
	Thu, 15 Oct 2026 19:30:16 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B410210E5BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:30:10 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso41219915e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792092609; x=1792697409; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tCA7tgHMTElt/DB21Y9IyITwJ975dZJFw/SRY6QoU68=;
 b=HKxAEeoHYs3x6LeImLDlJdlT4WDp6fOk6dHcbniyjs8mi3XsCbPphnm/nxoBvEphH6
 FwHMO9G1Oc7tY8JiW9Mn969hTPT5MEuOPFn0L41C2ZoAnqpV4pWaEL60eqwUi3KiGo4f
 5/APOCP6vtGN5KnKIsDmZ3cgk0M+8iE/7UyQDYUJcC+p5PfgWesE45QluDMjZOAKCaSS
 d9B15UYu0BQi9aDB0zcbXPN/7eKHqX0vcA+LuDJYv5B4eFN2YOcKh7DqTwx+SuArYH54
 CdcfNUi3vGrA3CrKwXFzC00pzZFPBNnDcPVdah1uP7dXA9wH8wzUFNpMh5z9WIab5qbZ
 f6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092609; x=1792697409;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tCA7tgHMTElt/DB21Y9IyITwJ975dZJFw/SRY6QoU68=;
 b=aTWf1BZGSRKFK+L4LYrPcyHwjqSyvUi/wqt7BezFI+rkl7QOarVsCktuhr0zcZn6hp
 jk2L65RAfJlSQddGHSwzmWoSyuRRBJr6d7Jt1QLvdvE7ZGYDz3Y03fCBJhktYehqXQMl
 dChDZ8XRatDUI5GYXBJ4X6wr1aEj0Fmce7+sYkgprBFOIzrkX7E2s0DRg/XcKKy+0yRu
 btSdEe0mZUAOB61MdfG0MoOGlAIV+mXy6MviJP7PNX1utxfzADH+BCyOTBBaRk3DTk/T
 jqqnCrvvYwgHStQf48VjlaraIPwjeL9wT3iqhwdJQgLe61WRRiX95BA3GCCDVovfnSDT
 /dGw==
X-Gm-Message-State: AFq9FYLKA3lO+2MsYQPLuFcGfqW4yY1kS9Q6shSJXKBIRvrBsCubFTsI
 0hstzpG9viIsflu24C9496pf3G6QhBzXoQ3h/kJfhNQQGP0xzExflhNs2J25Rg==
X-Gm-Gg: AYBFou3fGh9VSuMOxXzf7egcMxg6Bo3nfc9sQ5F/8srH66vzan9aDRt2YOS+X9hjUyv
 ldjGy6GbOIBa0dP+SbPZKW/Qco5H7SR3FeZEmp9D+A0yzGZyg2ZWSdpjA/6FFag19fe7pS1F3Yz
 j2QwPB6/rUr4bQd/E9zOdAeA/WUWGTO/UYrdryt4S+1ZF7FY3pZ+TEnOG4RyXchdMqWCc5ch3LH
 FzeDlXMd/bR7Hq2qys2jzkr5pK4PKmNDO1jznz49UFyMcavbt9qxWkRiJz/UyWOSzProKh7kc09
 KcHqY7vjyf/uaszByw/VPq7zoYrMbvp7cKjyJ8+plPkSn2xwlYm95qlFCygFAwwilBlkPtf5KVk
 +WU4kQPa2Fs2fjhnTSn+BLr9yh1QFxez8pkDwYD+0o/WmDQFQb3r8q+mGuJU/la2JOD56FVTdHv
 X6Qyh+iT1Sd0/N+cCpUvHpvPi8lOdRdwS/oerpYcWBZFSVFmvUfF94vxDuycmz411CHQn2X4/i/
 Lhuu7hW2lSZu+bLW7xRsq3GfQ28EH1tU39KcciyRKAo3Urlt/ssYjjO2alnlcgaWIHN1n7oJDq+
 fGqZZr+DLV5H6FSImD5PiThlzwexWB1g3+4cvrBr5wCKR8QLaEesm+3FnWgwCYnZU5MpQaqSUUT
 XKvyb/e52c4gZVoPej/D8aYydhFKX6N7L0iV2rZLCKp8Pj10oz/fBhIXdYymHuejOYl5W093oNe
 aWTd9aMmOZ9clJsx8=
X-Received: by 2002:a05:600c:19cf:b0:4a1:7b56:1151 with SMTP id
 5b1f17b1804b1-4a18e48f00dmr399823055e9.18.1792092609022; 
 Thu, 15 Oct 2026 12:30:09 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:41be:7420:c1d9:bb43:318e:b925])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9a88bbsm94694375e9.3.2026.10.15.12.30.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 12:30:08 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 alexander.deucher@amd.com, xiaogang.chen@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v6 0/3] drm/amdkfd: fix wedged teardown on surprise removal
Date: Thu, 15 Oct 2026 21:30:04 +0200
Message-ID: <20261015193007.86066-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
