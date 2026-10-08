Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9485CA6011
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 17:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8794A10FAA1;
	Thu,  8 Oct 2026 17:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eq1IS3GR";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3190210FAA1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 17:33:54 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-486e8faff03so1822232f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791480832; x=1792085632; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=apSg04ofG9JT17gTFMqyZX3rIV33q37d0TfAc3UMcCs=;
 b=eq1IS3GRS0qtP0fA3KBH+CGDs9SyZ9hKiilZk8m1FGw2EXXEspcwmTd3bk7S6BNEpu
 re8f8dGkch6skFvXXaOGiKycKa8iLZ+ZAyB5rsa3BsYMGO7QHNWhbdQ4J9nA2vT7EUYJ
 kmh1H9xbl/UCpmnFuL1WJcszKGSkMmlwALdlO4EAHpKaQCRPqfdZQCJmT4l4JkwjqiXZ
 lg8WaaY0uUYknOftLlNWCc3k9UB5EBINI5Q8Tm4hmO4h2Y3VDE0E+sYfuHGvIVSSgMqC
 sdfUzGlv2hV2Y93iWwLBVRM7etAt9FrPyaDDT+V+/ZImOuJ6UX54LHzO9IhpF9BdvdKJ
 LgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480832; x=1792085632;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=apSg04ofG9JT17gTFMqyZX3rIV33q37d0TfAc3UMcCs=;
 b=u7yFhXxClBatSEutBgB30hKf+F5XJy7jJivK3Grip8UH6pdGOMqRmIttA13DTkNcTQ
 /ZCjzj9dffxVT/NTjt3ufbTqIYI6Et9vyqRGZLMm3t+Zdr0RNIbVei6IWa+wLcOw2sbb
 a0tmJlOWzAXHAUmOGtuXCPZrR8mH1DINii+eOLbzOE/SgTLza0DyYhFT83ICVHdsM0wu
 2XXP8kYT9gl89hF7iYW3ZxmhzTJcz90Dyp5fp5MP0/MZw+F8JzbEzgCMYXNn1ya60XpK
 70Cg6Bor3fpJMBeMYpGmtNaXzLGTZtoRklXpZTnBGf0+xPKGENtIZxrqsTS+VS+nlH57
 DitA==
X-Gm-Message-State: AFq9FYLDZU7HxH+qf5DD8Cbkavu46h59oRTFWR8NEoCWouXmofHb4K/6
 S10MiZ8O5GmsGW4YM2HT6cGkf0JUgkOMslFXPYkJ7MMqZojrTcdmo/MT4o/d8ZPu7q4=
X-Gm-Gg: AYBFou2qLogkct2GLSC3yC1Ww6HFRHPHlijHHsf3lhGNBKZYEJkd9a2EBC1drtQUku8
 70YOa52Wg5gU0+mS5YBqpK3nvK3Z0u8I09kLPDzUf9mnazxzx0VTAImIGsxabp3VG+qo22NvD3r
 7rQ3PZLI1E44D4wNI2KGi/q7DRkLI9gT9ypt8wFs9Ea8dQ5+fRXuuWFMh8ypGHOT4K2P4G/MUNu
 22q/W/u2d4Q8LWl3QhUVryc/OgjoghqisgjpdK+PXZqVDjsG6qeNbTPmw5qxATfeuc2z8msMkLf
 aeHjK8sNDUP/dCWby/m2Y6mzkHZV2nphg6WW9iI5R1Pbx7k4z178P4SYfHVJZypaIW8S3foA3Va
 1ir9BerDUbaeZo77dvmzVSF/JL08UCu12zREX2BpIuo26uUDRzrtdvCR6RywJffO2QcYMrAu+ET
 g2HZC6vdrxQheQd+sGITWqzxdKO6zTdywbdizM4nFM+6lOd6bQSlu+461pW96s/WP1tMgG/7s4N
 lLKuT8MBxkuftWEYjvjFTJ14usGdIW57tr+rohupYf8UziivTvk4uN1G+MYLkRhg5NixhksYOc0
 e2A36h9jkwgwLulv2P9qaL9M/lYgpwwKCCqintPWc4q/YE4OZdg87Jw6/Jin3+xI6ntFFhbRCgW
 XqpBCejMwQ+5za3txoRdbsAUx76vVNqiWfsrevTTmaTS0517h6TbtkIPr9q7Ph5Sen+zMyPSv/S
 0chXTuPOvvScLNP5w=
X-Received: by 2002:adf:e19c:0:b0:48c:4f94:2214 with SMTP id
 ffacd0b85a97d-48c726fcc83mr11517500f8f.3.1791480832266; 
 Thu, 08 Oct 2026 10:33:52 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:415e:bf71:e574:69b7:f11e:4204])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db652e593sm659451f8f.34.2026.10.08.10.33.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Oct 2026 10:33:52 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Olivier Kaloudoff <kaloudoff@icloud.com>
Subject: [PATCH v5 0/3] drm/amdkfd: fix wedged teardown on surprise removal
Date: Thu,  8 Oct 2026 19:33:47 +0200
Message-ID: <20261008173350.40455-1-olivier.kaloudoff@gmail.com>
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
   section or the faulting task indefinitely.

Verified on MI50 behind Thunderbolt (2 GB SVM workload, PCIe slot
power cut): the workload takes SIGBUS, coredump completes,
kfd_processes_count drains in ~7s, pciehp removal finishes without
warnings, and the device re-enumerates cleanly on slot re-power.
Previously the same repro wedged the host every time.

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

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  5 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c      | 29 +++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_device.c           |  9 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c          | 36 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c              |  2 +-
 5 files changed, 70 insertions(+), 11 deletions(-)

-- 
2.47.3
