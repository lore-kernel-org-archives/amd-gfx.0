Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038A0CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 18:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 580A610E641;
	Wed,  7 Oct 2026 18:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="poI4qqzT";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A9EF10E02B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 18:09:13 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so15548645e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791396551; x=1792001351; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pNIj9FULeNRPW7rTwFQopDPdttrY2qlGjxH4BqIIpTw=;
 b=poI4qqzTLjRsZ8D09eXf6vLnv9dP4Lrfw3T3+l7eOtCUtsR7YXQQTm/+5fUxSSHQ+m
 9EaHtreVUyGrEWB6TGrf+H0RxzFi1s5SJosHkjq4gPP44akHmPkoIWOHTQF2xSpQ3FiZ
 2bgwsIBLLMK4WsGrgn15MPVPsMz72YSc/jZ1qb3C6+hwhR0a9F8/RG0hlElY6Wh9Z/2w
 s9GLdziGrnlp50huAMOkTaz68r1dTPzL8kwlrDi8m3DHy5erklT/dNN1HBXfXobwFjv6
 nkM6SILTqyu06rCleQiNrZcGHAnYTGZ2PfCea24mDYVP9OmS1q4L6g/+e+znJASxvuS5
 KmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791396551; x=1792001351;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pNIj9FULeNRPW7rTwFQopDPdttrY2qlGjxH4BqIIpTw=;
 b=zpNXfuYriRipBiWpjGdoJCj+LciS8huTPc8AUwwsb1aG/rC/ar4AAA5VfodoGnCXEh
 hiGuWgrSPlUyu5G48SXMqYA3yq5U9AX8a8cIUdaS9tbxbeVYH1MOxpII1rO+N3ckWlbG
 8f7tWMRNOShvNUA6yzbNfKmRY7lfATmkfKyj33wzxNzI09gNEjdy9DChbU5dm3XZXGEz
 i0VrobEYewMXwbillFtul0QgzE6KtJ+z7BiHGb/Glpi087ZRQzNZ8qC7QC7K9oWn4e7o
 7DzPHoLIwJu4DTaSV+4wwlmG4X0b9szmj0zyUsyJ2BWKXOg3WT+zHf6nApc4YNRKhvo1
 GWSw==
X-Gm-Message-State: AFuF++kVtOQPB7R2r0H7y2XorsvhTLUiWBTk1V3SDAy59wf5AhFzVXoh
 kQ7Oo/ck2cSJvidKDtyblCKmfS/A75gGNm4FykQV9GDsc/2c1w0rtsZO/KOaMS1H
X-Gm-Gg: AYBFou0fFfqoKypRIqbxgIj6mNc2I4voksIJeoFBTHa/t9Lr7gmVwKerTa/ktJ0v/Hb
 Z3yxiig8fdRfy1gEqVdzIZMgY8/d37VyPGpRBxo0ImgwYttBgomybgX2/SnFYCqrbfij+nrPhE7
 JQemQNAO300K+LL8ALh4wHF4gnrEX48DpGA8w7LxMnzUeL8BCfHwae7b19nwqSBP996lxOaAYGT
 utL0x93+mqJINEktCMNpFdL6ovTwK1Ij6+XVSuu//CSEzarkyAoc65r1o7CM4PTGKvi1vZZ0dzx
 EG4V33IRU4rSyNd2u/m5n4b8LeIcODnWYo87I/0DY0wouf+CaWrrbAIlbTeiLWrVY7RchzyUgO3
 K4M9PY1Qi93iPz/voVfMhMYOINVkXer26a7wkrE4paSZ6cNlvy0n1+4hQl+mjhs+WLcmzIm2uc5
 Xy9BTHu5ICkDtFlui92wGtHA38PPACh3cO4omPJpGgC/42Y41TTm46uehREZc4le1PES/Ce66Cw
 myQdCjNhdrh91wGC7MWelCwQ4XppuqLU7xlCe05HGxZg4k+P+DwdgDOI7ZJNnFZq2Gw7rbPu/Vn
 FbAzidlubyKGvOwo0V6zF9IyLJT4Vgeg8j7yj77tHE3fvXZ2vduQN2Gbsblo/ftUXbCJridyuro
 4ZHWg2x27d/BMEfYonq7EAV15R/5mZj480Y99yALTqQCaCLJIXtk2KYPQwIMFavVlK6lDudxVGQ
 VhIl0UrcrGmZmx5fs=
X-Received: by 2002:a05:600c:1911:b0:4a1:78c5:79f5 with SMTP id
 5b1f17b1804b1-4a180455696mr52222995e9.33.1791396551394; 
 Wed, 07 Oct 2026 11:09:11 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:413e:676b:9d85:c07d:dc5e:c7c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a181aeaea2sm59416855e9.5.2026.10.07.11.09.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 11:09:11 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v4 0/3] amdkfd: survive PCIe surprise removal with live KFD
 processes
Date: Wed,  7 Oct 2026 20:09:06 +0200
Message-ID: <20261007180909.34013-1-olivier.kaloudoff@gmail.com>
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

On PCIe surprise removal (Thunderbolt eGPU link drop) with KFD
processes attached, three stacked problems wedge the removal path:

1. amdgpu_device_fini_hw() frees kfd.dev via the early
   amdgpu_amdkfd_device_fini_sw() on the disconnected path before
   amdgpu_amdkfd_teardown_processes() in ip_fini_early ever runs -
   the unguarded kfd_processes_count dereference then NULL-faults
   (or UAFs) the pciehp removal thread.

2. The KFD userptr and SVM restore workers reschedule themselves
   unconditionally on validation failure. On a gone device validation
   can never succeed; each 1ms retry takes process_info->lock and
   notifier_lock, observed as ~11k cycles until soft-lockup while
   process teardown cannot proceed.

3. The dying process's own exit path faults on its SVM ranges
   (SIGBUS -> coredump -> do_swap_page -> svm_migrate_to_ram) and
   submits a copy job to an already-killed drm_sched entity, then
   waits uninterruptibly on a fence that can never signal - holding
   svms->lock the whole time, so kfd_processes_count never drains.

Patch 1 moves the process teardown ahead of the early fini_sw() so
the drain wait runs while kfd.dev is still valid, and keeps a NULL
guard for the second teardown invocation. The wait stays unbounded
by design - returning early would just defer a use-after-free.

Patch 2 stops both restore workers rescheduling on -ENODEV.

Patch 3 makes the SVM migration paths hold drm_dev_enter() across
submit+wait so unplug cannot tear the sched entity down underneath,
keeps pci_dev_is_disconnected() as the early-out for the
physically-gone window, and bounds the fence wait with
AMDGPU_FENCE_JIFFIES_TIMEOUT as a fallback.

All three verified together on MI50 32GB behind Thunderbolt 3 (Razer
Core X, ~2GB of SVM managed ranges + queues, pciehp Surprise+ slot
power-off): SIGBUS is delivered, coredump completes, the process
count drains in ~7s, removal completes, and the device re-enumerates
cleanly on slot re-power. ftrace confirms teardown now runs before
fini_sw.

Changes in v4 (per Felix Kuehling's review):
- 3/3: drm_dev_enter/exit around the migration instead of bare flag
  checks; AMDGPU_FENCE_JIFFIES_TIMEOUT instead of open-coded 10s
- svm_range_restore_work() -ENODEV hunk moved from 3/3 to 2/3
- 2/3: also assign ret on the evicted_bos-mismatch and
  confirm_valid_user_pages paths - posted v2 read ret uninitialized
  on those two paths
- 1/3: unchanged

Changes in v3:
- 1/3: drop the 30s bound (Christian); run teardown before the early
  fini_sw; NULL guard for the second invocation
- 2/3: resubmission of the posted v2 userptr worker patch
- 3/3: new, SVM migration fail-fast

Changes in v2 of the userptr patch:
- ret not pre-initialized; no pr_warn_once (Christian König)

Olivier Kaloudoff (3):
  drm/amdkfd: teardown processes before freeing kfd.dev on surprise removal
  drm/amdkfd: stop restore retries on device unplug
  drm/amdkfd: fail fast on unplugged device in SVM migration paths

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  5 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          |  9 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c         | 33 ++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  4 ++-
 5 files changed, 60 insertions(+), 8 deletions(-)
