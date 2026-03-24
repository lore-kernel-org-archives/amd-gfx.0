Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8477DFEC11C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F33D10E5F5;
	Tue, 24 Mar 2026 21:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RSW2XVUf";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010032.outbound.protection.outlook.com
 [40.93.198.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A604B10E326
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AydDvPWyHsPFeev+UAlwkKE10xNJcZIednuhGizdugrz6BtSl7QMpzFUVleQ5731crUnVWnN5vv/LSKhhbG/zFZTzjucPfEReDT/rprd3J/CI9eOkUoRETow21MKf90JzPHCdYXUi7hbS/pnaLrUNBtQR2NSYpaGjDK3YHTdXq0RbgkN694XVsblT9Ioxf0x8D1TvHHTxTZgRh7bwu9a/0IQyFnPA0W7PUc4oPMYuehvL1tZRYgn2lnYHZnlpYJkZp97NMSf+DuYTFt9TNt+7Dd3G5ImOBdJr9gjz/DRn+DNHA7T6F3SthIipn9xLlrm1ZXp+SqdJNDDNaEKQIwZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryqOsyfHN8/JkRRs0+snDMtKa93SlyfYfVa5p7O8OE0=;
 b=JW9RGozDQG5M0L46wvI4vXPNazDkRyWmFyAxgySAgSzjbiiOPZpx+He0LOa/H8qnwWBwgUVILq9nyLRDiXl4HtwQpzcRnaNIA/MJuLqgGPk3cC55IQ7eIC5gCDSy7mWL6I1TVFzIT9tmf+Z626K2Ki3uIF4T4bjE4ehE8lbr5AGz6C64j9YhMvMRF+CJIrEmO8p6ShXgLKqpHMRQXTPfImciiJxJoYDoTRdxsuVT5f5wyiq6/59Pvtv/3WHDKVWl2bclK7/F4bXxloNHkveRUdNoU+49/UOqEAc+6ZNZmMxzz26RMoKukp34HnvEsIpXIffQKKTbltaA41iKUmh2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryqOsyfHN8/JkRRs0+snDMtKa93SlyfYfVa5p7O8OE0=;
 b=RSW2XVUfiLaG7b6nioJTD78kl/eijNIXKRj7o6QlfaHQDICtAUubBTuCY/HDucVuwjbsvgRUWqt4DQYwVxrPP2TTOEPyhTVzqynJVjvQpZRZKphyeiel/QoYO7gi9kyuNDH7TUjv2VrWfBT38eDMVvSq/1Xy9Lgu8GHHaCn9jds=
Received: from SA1PR03CA0005.namprd03.prod.outlook.com (2603:10b6:806:2d3::6)
 by SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Tue, 24 Mar
 2026 21:21:02 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::e6) by SA1PR03CA0005.outlook.office365.com
 (2603:10b6:806:2d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:21:02 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:47 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 15/17] drm/amdgpu: workaround for hw stall issue
Date: Tue, 24 Mar 2026 17:20:28 -0400
Message-ID: <20260324212030.822932-16-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b9dd2b-0b46-41a6-9e75-08de89eb4067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 76wX6xfsXkNpKdaThS6rE5QfP/taDyeSz43+ogacPEkfzcWcSyOb49tetKg0ZV7pjUolHNWT8fF+7anGGDpByZjjuYBfNdtWQxBS9kbkmbP8nxGHtXN89z5s3eEocTiKszKuZ3pnnRPhHCQt+G8r7j5LSMWtMBo+6W2QyCZSi2Y2Z67q41Fz7FPmUA1eUuw76N27FOV//e3d2kSrat3FeUWfTOKavROpiWJs46I06Xsl/MWhjsdD0P/YignjXQobfZnzPYQneM8Dw79kIVkb3ykYqf97FZ62MAMjpeNUt7GeeZh5Mo0LT3w+egXeOaVFqhODr1PutLlT+cDMY7xiNvhzh/1G6MSXoFOKFPgvxF08r1wPEevCL8uBhBPOo7rD4kV36JOvcqgAK0my+7XehT2yY4Mv9CHCwUfdjIznPlfW7t89ga/6uMubc8AuFEpXQLFhmFxFIxDJUCbd6BMdPRkZf74gSKii1Gd5CewRU+53Lp0S751rkhHU7eQkwtN948CkV4ZuxpRIge9LZnRt99rkiQ6UIa2AX5DeL4ZftXQbXEVyFikwXXil0UGD1TnfXu1l3U5cNGOhaEcQdkpgH18QBHqwOtRqPNM+o7cqXkmH1iIpDXfZeKFXulVQFDtYuquZhf0ooLj++pay29/tKL05VZ4bls+Q/dqxBVexs1vakjR3ORk+c4edy1tlD/dg6R8wNFt/z2XmesYiYXlxcQS3gX/UtykfQ6FzaQSgo6j70xZnPEIViGMA4sk4dRvntPlMddY2OtwNPm+3Un7TvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iRi/NgLqNeWw5ue6oHios8c6Ze30N8kubl70y6KgSsnHI6rQnCR5plvNBcv/LEjvAf+5YAuozUIVXEzmDDdlWFyiP6CJR3VP5JKDFR0a6RyT+rqv7V8v5dQh0rdwElzaPqJA9/eScwUeBQKQZFRPUMm7ZPnK6xtoAjiVbbuaRcpNz2doZLJaQsTXp63egQ6dGzCHr8yZySnruS7Ix+UqBM2uF4HWzYgiv8BUca55g3t2sUUTV1JHNmWY0egCI5mejwY9zqBJJxOwds37VSKyB95QvU/GNieiwULF+l6L3eKnghBxIuYDFQcdjGE8r+6nNKZcrCxY0tc9RzYeUqdcbWMrjXTS5GiKMwV8a8YwfW9dMfAUGqjb85A/u1D3zNlfxOdy3MBjoiXogAonHFL36Fd6t/6KJOv7SMmxsD4e5TYYACqo0h7ZhpD4QYy0TPTN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:21:02.3384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b9dd2b-0b46-41a6-9e75-08de89eb4067
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
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

When RLC_SPM_PERFMON_CNTL.PERFMON_RING_MODE is set to 0x11, the SPM
hardware is designed to fire a warning interrupt when the ring fill level
reaches RLC_SPM_SEGMENT_THRESHOLD, and stall only when the ring is
completely full. A hardware bug causes both the stall and the warning
interrupt to trigger simultaneously at RLC_SPM_SEGMENT_THRESHOLD, resulting
in an unexpected early hardware stall at interrupt time, which causes data
loss before the ring buffer is actually full.

This patch replaces interrupt-driven ring drain scheduling with a software
polling monitor thread to avoid triggering the premature stall.

Software polling monitor (amdgpu_spm_monitor_thread):
  A kthread named "spm_<render_index>" polls each active XCC instance
  in a tight loop with usleep_range(1, 11) (1-11 us per iteration).
  On each iteration, it attempts to acquire spm_worker_mutex with
  mutex_trylock() (skipping if contended) and for each active XCC checks
  whether the amount of unconsumed data in the ring exceeds half the ring
  capacity, computed as:
    (ring_size + ring_wptr - ring_rptr) % ring_size > (ring_size >> 1)
  This condition fires only once per rptr advancement (guarded by
  warned_ring_rptr != ring_rptr) to avoid redundant scheduling.
  When triggered, schedules amdgpu_spm_work to drain the ring and logs
  a "soft interrupt" debug message with the current rptr and wptr.

warned_ring_rptr (u32, added to amdgpu_spm_base):
  Tracks the rptr value at which the last soft interrupt was issued.
  Initialized to ~0U (U32_MAX) on acquire and on each SPM start/stop to
  ensure the first polling check always passes. Updated to the current
  rptr at the start of each ring buffer read to suppress duplicate
  scheduling for the same rptr position.

Monitor thread lifecycle:
  - Started lazily on the first SET_DEST_BUF call that starts the SPM
    hardware (dest_buf != NULL, is_spm_started transitions false→true).
    Only one thread is created per SPM session regardless of XCC count.
  - Stopped on SET_DEST_BUF with dest_buf=NULL (SPM stopped) and on
    AMDGPU_SPM_OP_RELEASE. spm_monitor_thread is initialized to NULL
    in amdgpu_spm_acquire() and set back to NULL by the thread itself
    on exit.

amdgpu_spm_interrupt():
  - schedules amdgpu_spm_work directly. But when detects affected hardware
    via ip_versions[GC_HWIP][0] < IP_VERSION(12, 0, 0), the polling thread
    is responsible for all ring drain scheduling in this mode. the hardware
    interrupt only sets has_data_loss=1  under spm_irq_lock (indicating the
     ring reached the stall threshold) and logs a debug message.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 94 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  2 +
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 9b7bb15a3785..ee0fbf75709c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -38,6 +38,77 @@
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
 
+static int amdgpu_spm_monitor_thread(void *param)
+{
+	struct amdgpu_spm_mgr *spm_mgr = param;
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+
+	allow_signal(SIGKILL);
+	while (!kthread_should_stop() &&
+			!signal_pending(spm_mgr->spm_monitor_thread) && spm_mgr->spm_cntr) {
+		bool need_schedule = false;
+		u32 inst;
+
+		usleep_range(1, 11);
+
+		if (!mutex_trylock(&spm_mgr->spm_cntr->spm_worker_mutex))
+			continue;
+
+		for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+			struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+			u32 warned_ring_rptr;
+			u32 ring_size;
+			u32 ring_rptr;
+			u32 ring_wptr;
+
+			if (!spm->is_spm_started)
+				continue;
+
+			ring_size = spm->ring_size;
+			ring_rptr = spm->ring_rptr;
+			warned_ring_rptr = spm->warned_ring_rptr;
+			ring_wptr = READ_ONCE(spm->cpu_addr[0]);
+
+			if (need_schedule || (ring_rptr != warned_ring_rptr &&
+				(ring_size + ring_wptr - ring_rptr) % ring_size >
+					(ring_size >> 1))) {
+				spm->warned_ring_rptr = ring_rptr;
+				if (!need_schedule) {
+					dev_dbg(adev->dev,
+						"[SPM#%d] soft interrupt rptr:0x%08x--wptr:0x%08x",
+						 inst, ring_rptr, ring_wptr);
+					need_schedule = true;
+				}
+			}
+		}
+		mutex_unlock(&spm_mgr->spm_cntr->spm_worker_mutex);
+		if (need_schedule)
+			schedule_work(&spm_mgr->spm_work);
+	}
+	spm_mgr->spm_monitor_thread = NULL;
+	return 0;
+}
+
+static int amdgpu_spm_monitor_thread_start(struct amdgpu_spm_mgr *spm_mgr)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	char thread_name[16];
+	int ret = 0;
+
+	snprintf(thread_name, 16, "spm_%d", adev->ddev.render->index);
+	spm_mgr->spm_monitor_thread =
+		kthread_run(amdgpu_spm_monitor_thread, spm_mgr, thread_name);
+
+	if (IS_ERR(spm_mgr->spm_monitor_thread)) {
+		ret = PTR_ERR(spm_mgr->spm_monitor_thread);
+		spm_mgr->spm_monitor_thread = NULL;
+		dev_dbg(adev->dev, "Failed to create spm monitor thread %s with ret = %d.",
+			thread_name, ret);
+	}
+
+	return ret;
+}
+
 static void amdgpu_spm_preset(struct amdgpu_spm_base *spm, u32 size)
 {
 	uint64_t *overflow_ptr, *overflow_end_ptr;
@@ -122,6 +193,7 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr, int inst)
 	if (spm->ring_rptr == ring_wptr)
 		goto exit;
 
+	spm->warned_ring_rptr = spm->ring_rptr;
 	if (ring_wptr > spm->ring_rptr) {
 		size_to_copy = ring_wptr - spm->ring_rptr;
 		ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
@@ -246,6 +318,7 @@ static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct
 	 */
 	spm->ring_size -= 0x20;
 	amdgpu_spm_preset(spm, spm_mgr->spm_overflow_reserved);
+	spm->warned_ring_rptr = ~0;
 
 	goto out;
 
@@ -290,6 +363,7 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	INIT_WORK(&spm_mgr->spm_work, amdgpu_spm_work);
 
 	spin_lock_init(&spm_mgr->spm_irq_lock);
+	spm_mgr->spm_monitor_thread = NULL;
 	spm_mgr->file = filp;
 
 	goto out;
@@ -340,6 +414,9 @@ static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 		goto out;
 	}
 
+	if (spm_mgr->spm_monitor_thread)
+		kthread_stop(spm_mgr->spm_monitor_thread);
+
 	for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
 		spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
 		spm_mgr->spm_cntr->spm[inst].is_spm_started = false;
@@ -526,7 +603,10 @@ static int amdgpu_set_dest_buffer(struct amdgpu_spm_mgr *spm_mgr, void *data)
 				 * wptr will become 0, adjust rptr accordingly.
 				 */
 				spm->ring_rptr = 0;
+				spm->warned_ring_rptr = ~0;
 				spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+				if (!spm_mgr->spm_monitor_thread)
+					amdgpu_spm_monitor_thread_start(spm_mgr);
 			} else {
 				/* If SPM was already started, there may already
 				 * be data in the ring-buffer that needs to be read.
@@ -542,7 +622,10 @@ static int amdgpu_set_dest_buffer(struct amdgpu_spm_mgr *spm_mgr, void *data)
 			 * Adjust rptr accordingly
 			 */
 			spm->ring_rptr = 0;
+			spm->warned_ring_rptr = ~0;
 			spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+			if (spm_mgr->spm_monitor_thread)
+				kthread_stop(spm_mgr->spm_monitor_thread);
 		}
 	}
 
@@ -606,8 +689,15 @@ void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
 
 	spm_mgr = &(adev->prof_mgr.prof_xcp_mgr[xcp_id].spm_mgr);
 
+	/*  watermark threshold is triggered */
 	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
-	if (spm_mgr->spm_cntr && spm_mgr->spm_cntr->spm[xcc_id].is_spm_started)
-		schedule_work(&spm_mgr->spm_work);
+	if (spm_mgr->spm_cntr && spm_mgr->spm_cntr->spm[xcc_id].is_spm_started) {
+		if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(12, 0, 0))
+			spm_mgr->spm_cntr->spm[xcc_id].has_data_loss = 1;
+		else
+			schedule_work(&spm_mgr->spm_work);
+	}
 	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+	dev_dbg(adev->dev, "[SPM#%d:%d] ring buffer stall.", xcp_id, xcc_id);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index f00a4751643e..db440b2e11f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -41,6 +41,7 @@ struct amdgpu_spm_base {
 	bool   has_user_buf;
 	bool   is_user_buf_filled;
 	bool   is_spm_started;
+	u32    warned_ring_rptr;
 };
 
 struct amdgpu_spm_cntr {
@@ -53,6 +54,7 @@ struct amdgpu_spm_cntr {
 };
 
 struct amdgpu_spm_mgr {
+	struct task_struct *spm_monitor_thread;
 	struct drm_file *file;
 
 	struct task_struct *lead_thread;
-- 
2.34.1

