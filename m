Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF71CCD1BF
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Oct 2025 16:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B0C10E31F;
	Sat, 25 Oct 2025 16:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nWPU24uV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C9510E31F
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Oct 2025 16:24:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EDA2C45234;
 Sat, 25 Oct 2025 16:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E732CC4CEF5;
 Sat, 25 Oct 2025 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761409487;
 bh=wvAWs6ffZ8/EudcI9iqCygFmY/F0Spig1HAEhGSfBVs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nWPU24uVibJi2nlx30yskvsnzyqX9L565PVXKABhpkvNe8BOwRREo6moxSGKwYwp7
 59+1sHXuKDtNORnhnPk1lBH7/ZW5y/SVjQVrPFSb9DXaMfR078v+wiJqVdc8Htjql/
 2o6SB/lPyMuEIVIX/bD/aVV+sB3xx2fIsyBTorTuKYnqpBk+T0oBxuW/c4vn3T0Kal
 u+htVpw5mdgS7iQPvU3SyJmIG0Tg1TXSwjKkd8zOyxTQY/mur5OIKCNYB11BRKLIZi
 BeFgTK4LfzhuIvWj0+4mzQFYcBqGXhcfGw9IosccmqU6kSN2g5iLgdT9TyEGaO5bim
 mpls7j1/vxKlw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.17-6.6] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Date: Sat, 25 Oct 2025 11:59:38 -0400
Message-ID: <20251025160905.3857885-347-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
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

From: Yifan Zhang <yifan1.zhang@amd.com>

[ Upstream commit 99d7181bca34e96fbf61bdb6844918bdd4df2814 ]

There is race in amdgpu_amdkfd_device_fini_sw and interrupt.
if amdgpu_amdkfd_device_fini_sw run in b/w kfd_cleanup_nodes and
  kfree(kfd), and KGD interrupt generated.

kernel panic log:

BUG: kernel NULL pointer dereference, address: 0000000000000098
amdgpu 0000:c8:00.0: amdgpu: Requesting 4 partitions through PSP

PGD d78c68067 P4D d78c68067

kfd kfd: amdgpu: Allocated 3969056 bytes on gart

PUD 1465b8067 PMD @

Oops: @002 [#1] SMP NOPTI

kfd kfd: amdgpu: Total number of KFD nodes to be created: 4
CPU: 115 PID: @ Comm: swapper/115 Kdump: loaded Tainted: G S W OE K

RIP: 0010:_raw_spin_lock_irqsave+0x12/0x40

Code: 89 e@ 41 5c c3 cc cc cc cc 66 66 2e Of 1f 84 00 00 00 00 00 OF 1f 40 00 Of 1f 44% 00 00 41 54 9c 41 5c fa 31 cO ba 01 00 00 00 <fO> OF b1 17 75 Ba 4c 89 e@ 41 Sc

89 c6 e8 07 38 5d

RSP: 0018: ffffc90@1a6b0e28 EFLAGS: 00010046

RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000018
0000000000000001 RSI: ffff8883bb623e00 RDI: 0000000000000098
ffff8883bb000000 RO8: ffff888100055020 ROO: ffff888100055020
0000000000000000 R11: 0000000000000000 R12: 0900000000000002
ffff888F2b97da0@ R14: @000000000000098 R15: ffff8883babdfo00

CS: 010 DS: 0000 ES: 0000 CRO: 0000000080050033

CR2: 0000000000000098 CR3: 0000000e7cae2006 CR4: 0000000002770ce0
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
0000000000000000 DR6: 00000000fffeO7FO DR7: 0000000000000400

PKRU: 55555554

Call Trace:

<IRQ>

kgd2kfd_interrupt+@x6b/0x1f@ [amdgpu]

? amdgpu_fence_process+0xa4/0x150 [amdgpu]

kfd kfd: amdgpu: Node: 0, interrupt_bitmap: 3 YcpxFl Rant tErace

amdgpu_irq_dispatch+0x165/0x210 [amdgpu]

amdgpu_ih_process+0x80/0x100 [amdgpu]

amdgpu: Virtual CRAT table created for GPU

amdgpu_irq_handler+0x1f/@x60 [amdgpu]

__handle_irq_event_percpu+0x3d/0x170

amdgpu: Topology: Add dGPU node [0x74a2:0x1002]

handle_irq_event+0x5a/@xcO

handle_edge_irq+0x93/0x240

kfd kfd: amdgpu: KFD node 1 partition @ size 49148M

asm_call_irq_on_stack+0xf/@x20

</IRQ>

common_interrupt+0xb3/0x130

asm_common_interrupt+0x1le/0x40

5.10.134-010.a1i5000.a18.x86_64 #1

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Philip Yang<Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- `kfd_cleanup_nodes` nulls out each entry in `kfd->nodes` while tearing
  the device down (`drivers/gpu/drm/amd/amdkfd/kfd_device.c:654-676`).
  If an interrupt fires in that window, the old code in
  `kgd2kfd_interrupt` still dereferences the stale slot and immediately
  touches `node->interrupt_lock`, so a NULL entry explodes exactly as
  shown in the panic log (offset 0x98 into a NULL `node`).
- The patch now defends that loop: before grabbing the lock it verifies
  the slot is still populated and bails out if it is already NULL
  (`drivers/gpu/drm/amd/amdkfd/kfd_device.c:1137-1144`). That mirrors
  the teardown progress—once the first node is gone we are already in
  device finalization—so dropping the interrupt is harmless, and more
  importantly it eliminates the crash.
- The change is tiny, self-contained, and has no functional impact while
  the device is operational because `kfd->nodes[i]` remains non-NULL
  outside of teardown. It only touches this ISR path and does not rely
  on newer framework helpers, so it applies cleanly to older trees.
- The bug has already been observed on production kernels (panic log
  from 5.10), making this a real user-visible regression. Given the
  severity (interrupt-time NULL dereference) and the minimal risk of the
  guard, it is a strong stable backport candidate.

 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 349c351e242b5..051a00152b089 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1133,7 +1133,15 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 	}
 
 	for (i = 0; i < kfd->num_nodes; i++) {
-		node = kfd->nodes[i];
+		/* Race if another thread in b/w
+		 * kfd_cleanup_nodes and kfree(kfd),
+		 * when kfd->nodes[i] = NULL
+		 */
+		if (kfd->nodes[i])
+			node = kfd->nodes[i];
+		else
+			return;
+
 		spin_lock_irqsave(&node->interrupt_lock, flags);
 
 		if (node->interrupts_active
-- 
2.51.0

