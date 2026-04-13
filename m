Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5246F3ED7E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 06:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A3710E30B;
	Mon, 13 Apr 2026 06:22:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BCDE10E31A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 06:22:01 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 63D6LuBI4051040; Mon, 13 Apr 2026 11:51:56 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 63D6Lu6f4051039;
 Mon, 13 Apr 2026 11:51:56 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 3/6] drm/amdgpu: add job->pasid in check as amdgpu_job
 could be NULL
Date: Mon, 13 Apr 2026 11:51:50 +0530
Message-Id: <20260413062153.4050981-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413062153.4050981-1-sunil.khatri@amd.com>
References: <20260413062153.4050981-1-sunil.khatri@amd.com>
MIME-Version: 1.0
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

In below stack job->pasid is accessed while job is NULL. Access it
within the check when job is non NULL.

Failure call stack.
[  222.653622] BUG: kernel NULL pointer dereference, address: 000000000000014c
[  222.653625] #PF: supervisor read access in kernel mode
[  222.653628] #PF: error_code(0x0000) - not-present page
[  222.653630] PGD 0 P4D 0
[  222.653635] Oops: Oops: 0000 [#1] SMP NOPTI
[  222.653639] CPU: 1 UID: 0 PID: 12 Comm: kworker/u96:0 Not tainted 6.19.0-amd-staging-drm-next #271 PREEMPT(voluntary)
[  222.653644] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
[  222.653646] Workqueue: amdgpu-reset-dev amdgpu_userq_reset_work [amdgpu]
[  222.653961] RIP: 0010:amdgpu_coredump+0x8b/0x470 [amdgpu]
[  222.654158] Code: 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 c9 31 ff 31 d2 31 f6 45 31 c0 45 31 db e9 8c a9 1a e2 88 58 48 44 88 68 49 <41> 8b b7 4c 01 00 00 89 b0 80 00 00 00 4d 85 ff 48 89 45 d0 0f 84
[  222.654161] RSP: 0018:ffffce68c0147c00 EFLAGS: 00010282
[  222.654165] RAX: ffff8bc337407740 RBX: 0000000000000000 RCX: 0000000000000000
[  222.654167] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  222.654170] RBP: ffffce68c0147c48 R08: 0000000000000000 R09: 0000000000000000
[  222.654172] R10: ffff8bc337407740 R11: ffffffffc10dda10 R12: ffff8bc2d2e00000
[  222.654174] R13: 0000000000000001 R14: ffff8bc2d2e5b368 R15: 0000000000000000
[  222.654176] FS:  0000000000000000(0000) GS:ffff8bc64a5fe000(0000) knlGS:0000000000000000
[  222.654179] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  222.654182] CR2: 000000000000014c CR3: 0000000135eca000 CR4: 0000000000350ef0
[  222.654184] Call Trace:
[  222.654187]  <TASK>
[  222.654190]  ? amdgpu_ip_block_resume+0x28/0x70 [amdgpu]
[  222.654376]  ? srso_return_thunk+0x5/0x5f
[  222.654382]  amdgpu_device_reinit_after_reset+0x184/0x320 [amdgpu]
[  222.654552]  amdgpu_do_asic_reset+0x129/0x160 [amdgpu]
[  222.654720]  amdgpu_device_asic_reset+0x92/0x710 [amdgpu]
[  222.654890]  amdgpu_device_gpu_recover+0x2ae/0x3d0 [amdgpu]
[  222.655060]  amdgpu_userq_reset_work+0x76/0xa0 [amdgpu]
[  222.655229]  process_scheduled_works+0x1f0/0x450
[  222.655235]  worker_thread+0x27f/0x370

Fixes: f9839cc47e53d ("drm/amdgpu: store ib info for devcoredump")
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 3f1cc2265645..3d7aa6b09815 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -511,7 +511,6 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	coredump->skip_vram_check = skip_vram_check;
 	coredump->reset_vram_lost = vram_lost;
-	coredump->pasid = job->pasid;
 
 	if (job && job->pasid) {
 		struct amdgpu_task_info *ti;
@@ -521,6 +520,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 			coredump->reset_task_info = *ti;
 			amdgpu_vm_put_task_info(ti);
 		}
+		coredump->pasid = job->pasid;
 		coredump->num_ibs = job->num_ibs;
 		for (i = 0; i < job->num_ibs; ++i) {
 			coredump->ibs[i].gpu_addr = job->ibs[i].gpu_addr;
-- 
2.34.1

