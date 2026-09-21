Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35AAC982FA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1679510E4D3;
	Mon, 21 Sep 2026 20:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VI0ElqB6";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACE910E4C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Meadmx0ubdbh896OQ27XuswTLhW1RIZhW2b7rJBZHL+qxECUj+fLbB5OQ0WZ2gXjxwSOVlqher6XASE7n5t9qIOC6qlChmRtRwHM3oGJ2JmE4RoKuiTsxfHYAxlP2Bv8IYxDX+Try1PhOk78I44srEw0ywLyzY3d7r9jnjn2fjqVny/a3KAnVxMKPHxMFNEKldXr76sNMFH+wW/i3xPdGiuADqHsgby+LfWUik81ZJl5AzjRDZQedbdqBV5kC/+ADYckw+i5t0ZkGxLpuiwdGs9lXZy/6gpNPqYmBUoUDyfwGOu92X0D63rVl1GWXEpWtmC0gxiWSjGn9x/zdLEw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5Ecvh5CyQy9haI4kKQwLpE70b0TNWlEh/00sHKMJAI=;
 b=mQZjQaznRh/bzu04moYOub6CU2LlTTZGAyVZzF71SQaUXAJGtopgwy81hPZXOx348tJXZWb7AS/xi6L2pgR5lrtbIwpuobgrNogf2ppaGHCC1dAnnNTPxAIHv4b+XIh3VD/dECGWojcFkc995K/rzSuLGandYSPT+WnogVlknmAsejCNFdC1GRkGbqitLhdssdi2NTaKzuy/WULrClAgGcZHnTJDlYKRvr8FYdzCB848GMWi0voL/ROp3vJKAHpnWYXm7ge2D3Q6n+FYoI9ulFp2DhNUa9q+r5YvciI7JRqyUVMQ+Rh5fultYXA9ITKmU/YH6irR2mIHOx/bpLnOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5Ecvh5CyQy9haI4kKQwLpE70b0TNWlEh/00sHKMJAI=;
 b=VI0ElqB6WzO3RaLLV/DvdMgA2Y0j+EDKqKdGWMWF1z68YLatF198223t/1umoqdV250aqYqMRaTH7P6uPYB0ujf+1EY0cPEWK9x8iI8EDtccBFAavWCAuimCZLTUT/qen5EZJN22s/uQPWJyJ2m39cZRN+LAjH3LD8tqg0e7dQo=
Received: from CH5P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::8)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:03:26 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:610:1ef:cafe::a5) by CH5P220CA0017.outlook.office365.com
 (2603:10b6:610:1ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:03:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 20:03:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:23 -0500
Received: from work-495456.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:22 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>, Bing Ma <bing.ma@amd.com>
Subject: [PATCH 10/12] drm/amdgpu: add SPM ring-buffer polling thread for
 pre-GFX12
Date: Mon, 21 Sep 2026 16:03:11 -0400
Message-ID: <20260921200313.865829-10-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921200313.865829-1-James.Zhu@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df9acd2-fa0b-4484-2692-08df181b655d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|10067099003|6133799003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jE7x6LHO3nbPP5UHlwojEYPI7zUmxUBXJY0FA71v0jdFOWJevoBaWF9HCcTSDFWoxn77O92YDycsWFxFkZAYMPIve85bR8WAstaY9pu4Cl3ROxLv3EebAxeUOlFEhV1/8K3rWHHRdLzpA5vuTPTUGHZ0zOHPwPxZkoepG96qaKc6AEEZQKW6plw14+ynjolh2a/lE6iDu/KcMCNCcz7pu8JzVREhhZmaGJaIIObZ+eTWn2MH1DV21x2ikpWRmPvh2JELt0VxHTNY+g3mVQ3vkvSiFe9lxCNGTBVubJFjYVU7fi6cVyLv7+AvMbDKJTZUF/yp7X0DFOEOts6RH4IWxcpF24uiLnNv5oHQfkDtncyN9ZePXN8JSnrVU1vdzyh4QsVRwgbXHzhC/tBZR41pTdB3ZZPSXd2QuyLjR1ZzJWzzTYECU8Tkp6fxJ9gmvcILGAzuPZ2tKagKUzTg8Hr45H1P4ChECukx70WixBTTmDa++rEbbiM9aj6MNvSGuT/Wk1WKnSgubonfVyMnoC/g7TldM5NdGQIohbI/mfnTebHZclfCHhWICiNtbqI5TrX+swt2pBUJpDqFn0HPIFWkCDds0OOkQyJdGT3fF5JdukiDAtWebHpM/am0g3umrkP1vcrc+6rJxGltx2ULru4/EFEiAD+qksd1k9ocXkzCyw/z1blx8M+htmTvXagg6xTCn2AOoxI1LBuc4hInSe5Rhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(6133799003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hukrk1U99oGBgwohXxPsa+Zi0RTwNJ9j4yYGmgHwXcKEsX+iMyXQPcKZKPSalMmKR46NcA4HAuYm/zcgLmVsAv6HhETg0DR6GJ+ue9UQl1YL+SGE9kFnC2qgWIcD52/6lOG2Ej/5E3f+J4vq4kktM3sgM/msSskOE8EyWZ6FQ6f+B01y50GM+OupipufRjBgaGuuC9rYO9jUueErTIhltj7uOexHZMjjgrt6qdA2TrJ12lPo/RnLgVmSyTsFuAxSjWwIS+ISA2dxauVlu/LWSkyBE6Q38eO6WtwpoS+28hMKGs2WuP5xgmjHjrnB/yMlNJEycQXiP9znX7aMFC2IJIiqMiqCvyjSq0vpYdjtuUwm3dGkDgvmg3fpcTw5Q7Ib7UBRT5Tl8PC3F8pyTcp26347cQpO41058LspMGIATQtrPePsyz15+Q6IPg6hEc/G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:03:25.3267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df9acd2-fa0b-4484-2692-08df181b655d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357
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

Implement a kernel thread for polling SPM ring buffer on pre-GFX12
hardware that lacks IRQ support for profiler events.

The thread runs at 100us intervals to prevent ring buffer overflow on
hardware without watermark interrupts. When the buffer exceeds the
50% watermark threshold, the thread schedules drain work via
schedule_work(). The 100us polling cadence ensures the 4MB ring buffer
cannot overflow at typical SPM data rates while limiting the thread to
~10k wakeups/s per active render node.

The thread is created on the first _spm_start() and stopped from
_spm_stop() with kthread_stop_put(). The creator holds a task_struct
reference for the thread's lifetime, because the thread can still
return early if amdgpu_xcp_get_xcc_mask() fails.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <bing.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 149 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |   2 +
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 532d1bc34f89..1b10618dde08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -21,6 +21,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
@@ -54,6 +55,105 @@ static bool amdgpu_spm_is_owner(struct amdgpu_spm_mgr *spm_mgr, struct drm_file
 	return spm_mgr->file == filp;
 }
 
+static int amdgpu_spm_monitor_thread(void *param)
+{
+	struct amdgpu_spm_mgr *spm_mgr = param;
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =
+							to_prof_xcp_mgr(spm_mgr, spm_mgr);
+	struct amdgpu_device *adev = prof_xcp_mgr->adev;
+	u32 xcp_id = prof_xcp_mgr->xcp_id;
+	u32 xcc_mask;
+	int ret;
+
+	ret = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
+	if (ret)
+		return 0;
+
+	/* Snapshot spm_cntr once per iteration: kthread_stop() (synchronous)
+	 * joins this thread before release clears and frees spm_cntr.
+	 */
+	while (!kthread_should_stop()) {
+		struct amdgpu_spm_cntr *spm_cntr = READ_ONCE(spm_mgr->spm_cntr);
+		bool need_schedule = false;
+		u32 inst;
+
+		if (!spm_cntr)
+			break;
+
+		/* Pre-GFX12 lacks watermark interrupts, poll every 100us to prevent overflow */
+		usleep_range(100, 110);
+
+		if (!mutex_trylock(&spm_cntr->spm_worker_mutex))
+			continue;
+
+		for_each_inst(inst, xcc_mask) {
+			struct amdgpu_spm_base *spm = &spm_cntr->spm[inst];
+			u32 last_drain_rptr;
+			u32 ring_size;
+			u32 ring_rptr;
+			u32 ring_wptr;
+			bool above_watermark;
+
+			if (!spm->is_spm_started || !spm->ring_size)
+				continue;
+
+			ring_size = spm->ring_size;
+			ring_rptr = READ_ONCE(spm->ring_rptr);
+			last_drain_rptr = READ_ONCE(spm->last_drain_rptr);
+			ring_wptr = READ_ONCE(((u32 *)spm->cpu_addr)[0]);
+
+			if (ring_wptr >= ring_size)
+				continue;
+
+			/* Evaluate watermark condition per-instance independently */
+			above_watermark = (ring_rptr != last_drain_rptr &&
+					   (ring_size + ring_wptr - ring_rptr) % ring_size >
+					   (ring_size >> 1));
+
+			if (above_watermark) {
+				WRITE_ONCE(spm->last_drain_rptr, ring_rptr);
+				dev_dbg(adev->dev,
+					"[SPM#%d] soft interrupt rptr:0x%08x--wptr:0x%08x\n",
+					 inst, ring_rptr, ring_wptr);
+				need_schedule = true;
+			} else if (need_schedule) {
+				/* Another instance triggered drain, update our reference too */
+				WRITE_ONCE(spm->last_drain_rptr, ring_rptr);
+			}
+		}
+		mutex_unlock(&spm_cntr->spm_worker_mutex);
+		if (need_schedule)
+			schedule_work(&spm_mgr->spm_work);
+	}
+
+	/* The thread never clears spm_monitor_thread: the pointer and its
+	 * task reference are owned by the start/stop paths.
+	 */
+	return 0;
+}
+
+static int amdgpu_spm_monitor_thread_start(struct amdgpu_spm_mgr *spm_mgr)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(spm_mgr, spm_mgr);
+	struct amdgpu_device *adev = prof_xcp_mgr->adev;
+	struct task_struct *task;
+
+	task = kthread_create(amdgpu_spm_monitor_thread, spm_mgr, "spm_%d_%u",
+			      adev->ddev.render->index, prof_xcp_mgr->xcp_id);
+	if (IS_ERR(task)) {
+		dev_dbg(adev->dev, "Failed to create spm monitor thread (%ld).\n",
+			PTR_ERR(task));
+		return PTR_ERR(task);
+	}
+
+	/* Pin the task_struct before waking: the thread can exit on its own. */
+	get_task_struct(task);
+	spm_mgr->spm_monitor_thread = task;
+	wake_up_process(task);
+
+	return 0;
+}
+
 /* Re-arm overflow detection region with magic values.
  *
  * Called with size = spm_overflow_reserved at acquire time to arm the entire
@@ -191,6 +291,7 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr,
 	if (ring_rptr == ring_wptr)
 		goto exit;
 
+	WRITE_ONCE(spm->last_drain_rptr, ring_rptr);
 	if (ring_wptr > ring_rptr) {
 		size_to_copy = ring_wptr - ring_rptr;
 		ret = amdgpu_spm_data_copy(spm_mgr, spm_cntr, ring_rptr, size_to_copy, inst);
@@ -415,6 +516,7 @@ static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct
 	 */
 	spm->ring_size -= AMDGPU_SPM_META_SIZE;
 	amdgpu_spm_preset(spm, spm_mgr->spm_overflow_reserved);
+	spm->last_drain_rptr = ~0;
 
 	goto out;
 
@@ -479,6 +581,10 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 		spm_mgr->spm_cntr->spm_use_cnt++;
 	}
 
+	/* No thread can be live here: release and both start/stop failure paths
+	 * clear it, and a live session blocks re-acquire.
+	 */
+	WARN_ON_ONCE(spm_mgr->spm_monitor_thread);
 	spm_mgr->file = filp;
 
 	goto out;
@@ -524,13 +630,39 @@ static int _spm_start(struct amdgpu_spm_mgr *spm_mgr,
 	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
 	spm->is_spm_started = true;
 	WRITE_ONCE(spm->ring_rptr, 0);
+	WRITE_ONCE(spm->last_drain_rptr, ~0);
 	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
 
+	/* Pre-GFX12 lacks HW watermark interrupts, so start a polling thread.
+	 * GFX12+ uses amdgpu_spm_interrupt() instead. spm_monitor_thread is
+	 * never touched from IRQ context, so the mutex above is enough.
+	 */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0) &&
+	    !spm_mgr->spm_monitor_thread) {
+		ret = amdgpu_spm_monitor_thread_start(spm_mgr);
+		if (ret) {
+			/* Thread failed to start, revert state */
+			dev_dbg(adev->dev,
+				"Failed to start SPM monitor thread, ret = %d\n", ret);
+			spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+			spm->is_spm_started = false;
+			spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+			return ret;
+		}
+	}
+
 	ret = amdgpu_rlc_spm_cntl(adev, inst, 1);
 	if (ret) {
+		struct task_struct *monitor_thread;
+
 		spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
 		spm->is_spm_started = false;
+		monitor_thread = spm_mgr->spm_monitor_thread;
+		spm_mgr->spm_monitor_thread = NULL;
 		spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+		if (monitor_thread)
+			kthread_stop_put(monitor_thread);
 	}
 	return ret;
 }
@@ -538,9 +670,23 @@ static int _spm_start(struct amdgpu_spm_mgr *spm_mgr,
 static void _spm_stop(struct amdgpu_spm_mgr *spm_mgr,
 		      struct amdgpu_device *adev, int inst)
 {
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(spm_mgr, spm_mgr);
 	struct amdgpu_spm_base *spm = &spm_mgr->spm_cntr->spm[inst];
+	struct task_struct *monitor_thread;
 	unsigned long flags;
 
+	lockdep_assert_held(&prof_xcp_mgr->mutex);
+
+	/* Stopping any instance tears down the manager-scoped monitor thread.
+	 * Safe because callers always stop the whole started set, which is
+	 * all-or-nothing.
+	 */
+	monitor_thread = spm_mgr->spm_monitor_thread;
+	spm_mgr->spm_monitor_thread = NULL;
+
+	if (monitor_thread)
+		kthread_stop_put(monitor_thread);
+
 	amdgpu_rlc_spm_cntl(adev, inst, 0);
 	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
 	spm->is_spm_started = false;
@@ -548,6 +694,7 @@ static void _spm_stop(struct amdgpu_spm_mgr *spm_mgr,
 	 * Adjust rptr accordingly.
 	 */
 	WRITE_ONCE(spm->ring_rptr, 0);
+	WRITE_ONCE(spm->last_drain_rptr, ~0);
 	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
 }
 
@@ -639,7 +786,7 @@ static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	/* Stop hardware SPM for all instances and free their ring buffers.
 	 * spm_worker_mutex locks out the drain worker, which would otherwise
 	 * keep updating rptr after the reset and read the ring after it is
-	 * freed.
+	 * freed. Monitor thread is stopped on the first _spm_stop() call.
 	 */
 	mutex_lock(&spm_cntr->spm_worker_mutex);
 	for_each_inst(inst, xcc_mask)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index 552c5701e08c..b057d763fddf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -46,6 +46,7 @@ struct amdgpu_spm_base {
 	bool   has_user_buf;
 	bool   is_user_buf_filled;
 	bool   is_spm_started;
+	u32    last_drain_rptr;
 };
 
 struct amdgpu_spm_cntr {
@@ -68,6 +69,7 @@ struct amdgpu_spm_cntr {
 };
 
 struct amdgpu_spm_mgr {
+	struct task_struct *spm_monitor_thread;
 	struct drm_file *file;
 
 	struct task_struct *lead_thread;
-- 
2.34.1

