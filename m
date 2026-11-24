Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02440606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=OD1QTYth;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=OD1QTYth
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 444C610F75F;
	Tue, 24 Nov 2026 15:55:04 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A96A10F69C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530881;
 bh=AQU+11930yRVq2A3+fQwwCde5aAD+f7pP9AgU29M7Ek=;
 h=From:To:Cc:Subject:Date:From;
 b=OD1QTYthVRU86nwGEF95h5QDcef4iRBU3cv+1SCdHBGTrCdKg3grgIt7HH614y+8M
 Mi4cyrmnC3UB2Zdbnp5urzdZbJauIdq1qrgFV60sn7lBpW6T6xqfSja5gf5fkn5SNQ
 SDMlAe5T7g/ObkUap5A+YCMAJvUD50PoOVoQLNfL/R3Yr/x3yDZlpdnxlilgNG9Z7R
 dxPpGD7bkGwyZVosTQNEZ8+0N6Mlds69Y4tntZ8w2LrjRLXEaaSrrDRqct8lLZIJwV
 Yi47yj3uHNY5GII/p81YRgxro84X9ci9eKgG6wnRIOfGbjh0BPpmoqJIJVkxBs1VPX
 6pnHbekSs7vIg==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id E216417F068;
 Tue, 24 Nov 2026 15:34:41 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U9KrYLdAqWsX; Tue, 24 Nov 2026 15:34:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795530881;
 bh=AQU+11930yRVq2A3+fQwwCde5aAD+f7pP9AgU29M7Ek=;
 h=From:To:Cc:Subject:Date:From;
 b=OD1QTYthVRU86nwGEF95h5QDcef4iRBU3cv+1SCdHBGTrCdKg3grgIt7HH614y+8M
 Mi4cyrmnC3UB2Zdbnp5urzdZbJauIdq1qrgFV60sn7lBpW6T6xqfSja5gf5fkn5SNQ
 SDMlAe5T7g/ObkUap5A+YCMAJvUD50PoOVoQLNfL/R3Yr/x3yDZlpdnxlilgNG9Z7R
 dxPpGD7bkGwyZVosTQNEZ8+0N6Mlds69Y4tntZ8w2LrjRLXEaaSrrDRqct8lLZIJwV
 Yi47yj3uHNY5GII/p81YRgxro84X9ci9eKgG6wnRIOfGbjh0BPpmoqJIJVkxBs1VPX
 6pnHbekSs7vIg==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id 2DC3A17F065;
 Tue, 24 Nov 2026 15:34:41 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>
Subject: [PATCH v1 0/9] drm/amdgpu/amdkfd: fix MES queue lifecycle on multi-GPU
Date: Tue, 24 Nov 2026 15:34:23 +0100
Message-ID: <20261124143433.49736-1-zappel@simple-co.de>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:54:45 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a dual R9700 Pro (gfx 12.0.1) system running RCCL distributed
training, MES hits 2-second preemption timeouts on REMOVE_QUEUE and
SUSPEND after 90 to 120 seconds of operation. Both GPUs fail during
RCCL collectives. The timeout triggers a MODE1 reset, which loses VRAM
and cascades into a second reset on the peer GPU.

Root cause: cwsr_enable=0 prevents MES from preempting running compute
waves. When an RCCL kernel on GPU0 waits for its peer on GPU1, and
GPU1's queue gets evicted, MES cannot preempt GPU0's kernel because
there is no CWSR. The 2s MES preemption timeout fires, MES rejects the
command, and the driver treats it as a hang.

Separately, KFD frees queue storage (MQD, doorbell id, gang context)
before MES has confirmed the removal. A REMOVE_QUEUE that completes
late writes the queue state back into an MQD that has been given to the
next queue. This is a use-after-free on the firmware side.

This series fixes both problems:

  1/9  Distinguish rejected from timed-out MES commands so callers
       can tell a firmware that said no from one that stopped answering.
       Add a ticket for late completion polling.
  2/9  Factor out per-queue MES resource freeing into a helper.
  3/9  Track per-queue MES state (mapped/unmapped/pending) so the rest
       of the dqm knows whether MES may still reference storage.
  4/9  Add a quarantine for queues that MES has not released. A reaper
       workqueue polls for late completions and cleans up.
  5/9  Defer freeing of queue storage until MES has confirmed retirement
       in all four teardown paths (destroy, create failure, termination,
       process exit).
  6/9  Keep eviction and restore consistent when MES fails. Do not
       restore a queue whose eviction was not confirmed.
  7/9  Apply queue property updates only after the queue is unmapped,
       not while MES still owns it.
  8/9  Reconcile KFD queue state with MES after a scheduler restart.
       Queues from the previous firmware instance are retired.
  9/9  Force cwsr_enable=1 on gfx11+ discrete GPUs when a second MES
       GPU is present. Per-device decision, logged to dmesg.

Tested on a dual R9700 Pro system (gfx 12.0.1, Threadripper 1950X,
64GB, Gentoo, kernel 7.3.5-p1 with these patches):

  - RCCL all_reduce stress 150s: 85,582 iters, 570.5 it/s, 0 errors
  - RCCL all_reduce stress 600s: 343,647 iters, 572.7 it/s, 0 errors
  - F5-TTS dual-GPU training 50,780 steps: completed, no MES errors
  - dmesg after all tests: zero MES rejects, zero resets
  - Patch 9 override test (cwsr_enable=0 in cmdline): kernel forces 1,
    logs warning per affected GPU

Related reports:

  https://github.com/ROCm/hrx-system/issues/2938
  https://github.com/ROCm/TheRock/issues/9279
  https://github.com/ROCm/TheRock/issues/9299
  https://github.com/ROCm/rccl/issues/2193

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>

Armas Spann (9):
  drm/amdgpu/mes: distinguish rejected from timed out commands
  drm/amdkfd: factor out freeing of per-queue MES resources
  drm/amdkfd: track whether MES knows each queue
  drm/amdkfd: add a quarantine for queues MES has not retired
  drm/amdkfd: keep queue storage until MES confirmed retirement
  drm/amdkfd: keep eviction and restore consistent when MES fails
  drm/amdkfd: apply queue property updates only after unmap
  drm/amdkfd: reconcile queue state with MES after a restart
  drm/amdkfd: force CWSR on with more than one MES GPU

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  99 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  79 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  44 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  51 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  52 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  57 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  35 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 627 ++++++++++++++++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  31 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  51 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  51 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 167 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  30 +
 14 files changed, 1247 insertions(+), 128 deletions(-)

-- 
2.56.1

