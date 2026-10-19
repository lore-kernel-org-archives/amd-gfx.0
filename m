Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DABCCF2D6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 06:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A93A10E7C2;
	Mon, 19 Oct 2026 06:49:19 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A4D10E7C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W29reFyUn/2zdXphgW3sSo6eu0ZL5t925QbR5nIBNkkrVXUMIcYFnRs7uJM4LknqfqoIrJXNWMLtpXb0ET3JAPc8q9bjdljcIXc+HPJthUBce9xtMnUVULLask+Aliobn4ui8I0m1ccImth19p/uXToQ4tS2z4Ea5SWa+HPeucMndgAeXa8XSpM/SObvMLJWKjeEefg2bS4f0mWDVXLx4GOamWH2OuMw0FHHNNshlNe9UKJc77jjDu6cZCOEGLhQ3Q95kclTv8BX/pTyLU38KdPEuHrF7q1bO63sODR4SRkc6DmkNje/omRnY9LQoTwd1CK+gKH9UvE+Q+mVzShhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElBBXeg7QQX0PqrtW2RnWWCTiFocrdlkpatoef15FOs=;
 b=dSFtbUUPs9jFI9ABfFPYW7by5hQ24UEHTQmcvbARddHkDsAdxONAAwYpdzhMqsJcOIrm4HmjKYfQhbCdiccn6ZhQLZ6gaMBRD3JaowO4+I4vTUJ++plVpcKjcCqI557Q6UhrDkzpOtW5GcSK21YJmaiuYCyT9zm6EHTP3uU8MDT4HJvNpPYHaNFyMCCtzzCGlyd0h/WG2D39AN9uQs/DBnsWZPaKh2Nr/KfxVkgHCWuy+Bp2yQwmIS4rz4zBiKxiPPOE6ZXTE/tXKzxqjGVCTGpa8LtFGxGEgFRmZZRlmjgZ44jy5FAnsXyau0+fmdcINJ0nKPw9ciB/+e6Qn9jezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElBBXeg7QQX0PqrtW2RnWWCTiFocrdlkpatoef15FOs=;
 b=QVhBVbHVVt464btwi7Xa0aFmKj2Rm7DYcfR4eL7O+s+au9YwLC+UZxJodY+BausC4CQOnpyXa5B2ARyYNxN+XxVyVsKpxNrJKX9iqlwQo3eg19Hy1oOv/E2l+PdfjHNmzKwk/m4PY6UYntvNNwepI1wXhJDbOWN8rtlEVr4o484=
Received: from SJ2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:a03:505::22)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 06:49:06 +0000
Received: from EA8PEPF00000009.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::35) by SJ2PR07CA0018.outlook.office365.com
 (2603:10b6:a03:505::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 06:49:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000009.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:49:06 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:48:56 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 07/10] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Date: Mon, 19 Oct 2026 14:48:35 +0800
Message-ID: <20261019064838.2577746-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019064838.2577746-1-Prike.Liang@amd.com>
References: <20261019064838.2577746-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000009:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 005ad344-f730-45af-2382-08df2dad11fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|11063799006|5023799004|56012099006|261009223327099003|261009223027099003|261009221727099003|261009220027099003|261009221227099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: iTzHsnddtm4gdbDwcb9iRawHceTF1IbzG3Fz6jqhay+J++cJ+JmwN0DSLe1Ey9GmUSWJEV3v2ED05kOgRIqsp08D2uLV4P63Y8B7T/ITIPn7pKdt23yp3QYeeohCMNo+9lObqpmObR/Js3sGOkFRNIGVd7WEap7XvnJkIXhAnwWfjxSJ5YpofSnufTCtOVuX15k8828Lu5/b1UhtodeQdmHxMA/4Y60rh7kiPZHvpbLVRZCKxKGNoXOWIMJwnO2OoMw6rBofxUrvy93+8wZch4F7NLXmssmVkPtk0PfMcTsFmi4XZNG0TBfUNqxI52pp/q63HFFS1cfCZvot4spwSpsVsl/yvc2pwhBnWLaN4xLMKyKZFecQ8vNlNE0uyTnmhazaZnLM8AB7RLi9mIaoFJrREs5NPHfFlUIO6s8P8twwV7tTUyONDWpbuD/h+HgcTJ7oliGBROzSIw2ON3Xc3NyBghKKe1YaReGIzwG1Q5CTx29by27uy+ap61kwVFRvdMYKtY7iPo2SA1fhyS02bEH2cAkj2dTF1tSD81uL/WgwF9ewsCFC1Ti5j1QjYSQ+ZWxggMbpzQ5H4JL1ltq87V9M/4GenklsJD+D5kquEJq/37AdWnWGD7ciLdMkSip6tYtI8F+Io4tNeyhuQaFGAxsQStmWmLIw9P4DQJjSAVJJh+yf7p6FtlfYr1ae8+DVIB1dzARFhPSHWgP7ekpwIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(5023799004)(56012099006)(261009223327099003)(261009223027099003)(261009221727099003)(261009220027099003)(261009221227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LYIm5RYzSxFbkE6Ip09W8LL4/29poIAwhLWYottTxruPLgYcH0uhxuKooNA6hDNd8xE9Qo9bLJ3puabMrxfDwRnswlNrwTCg2cAhWjlI+qNL0LYF4RvXHgm/1OR2krV2h933R/iWSQFIlBA2qNgFGM67BpeGxHyRte9CabjYQaf85KWlSKRBqWc4BPp9JMscwkzEDtIXbxhZqvRuyyEnXuLkp/YOvfE91iyNgBHIZydE/Y5NWY1cpZe+/abrT19KDoS/h26KJiAc/EQHsXcOHCbUuB0Jb8fEfhPhbJJKP4p56T2F+SeIC9MwPqde1RdFy/1Fd19D87VJCbfJQ+BCYFv3bTiP/U1TShzPnWuIRXQ8XZrUO85MBYTe9qbdHbFBy7IlnBv7QDA4P+wZLQ3u2/WIKrYnsw/FaJBgHHNxRtiC/Ngyo81RZ9pIO9PbeoGV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:49:06.3008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 005ad344-f730-45af-2382-08df2dad11fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000009.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437
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

The common JPEG and VCN idle workers program power gating and DPG pause,
so they must not run while a GPU reset is in progress. Recovery must not
wait for them either, since everything the workers depend on then
becomes a dependency of GPU recovery.

Cancel the idle work without waiting in hw_fini/suspend and begin_use,
which also run during recovery. A flag set under the power gating lock
keeps the worker away from a block that has been shut down, until the
next begin_use. The worker gates, drops the power profile and re-arms
only under that lock, so nothing of a running worker can touch the
block once the flag is set. Only sw_fini cancels synchronously, and it
never runs with the reset semaphore held.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 36 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 39 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  3 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 +-
 24 files changed, 88 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 87f879a2e4f4..a8a529e8eb53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -74,6 +74,8 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 {
 	int i, j;
 
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1U << i))
 			continue;
@@ -97,7 +99,11 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 
 int amdgpu_jpeg_suspend(struct amdgpu_device *adev)
 {
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* Never wait for the idle work, this also runs in GPU recovery */
+	cancel_delayed_work(&adev->jpeg.idle_work);
+	mutex_lock(&adev->jpeg.jpeg_pg_lock);
+	adev->jpeg.idle_disabled = true;
+	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 
 	return 0;
 }
@@ -114,6 +120,17 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 	unsigned int fences = 0;
 	unsigned int i, j;
 
+	/* Nothing holding the reset semaphore waits for this work */
+	down_read(&adev->reset_domain->sem);
+
+	mutex_lock(&adev->jpeg.jpeg_pg_lock);
+	if (adev->jpeg.idle_disabled)
+		goto unlock;
+
+	/* Check submissions before fences so a concurrent end_use isn't missed */
+	if (atomic_read_acquire(&adev->jpeg.total_submission_cnt))
+		goto reschedule;
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1U << i))
 			continue;
@@ -122,13 +139,17 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 			fences += amdgpu_fence_count_emitted(&adev->jpeg.inst[i].ring_dec[j]);
 	}
 
-	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt)) {
-		mutex_lock(&adev->jpeg.jpeg_pg_lock);
+	if (!fences) {
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
 						       AMD_PG_STATE_GATE);
-		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
-	} else
-		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
+		goto unlock;
+	}
+
+reschedule:
+	schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
+unlock:
+	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
+	up_read(&adev->reset_domain->sem);
 }
 
 void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
@@ -136,9 +157,10 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
-		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+		cancel_delayed_work(&adev->jpeg.idle_work);
 
 	mutex_lock(&adev->jpeg.jpeg_pg_lock);
+	adev->jpeg.idle_disabled = false;
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
 						       AMD_PG_STATE_UNGATE);
 	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 05d58e6bbfab..1dc86d8c9c8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -137,6 +137,8 @@ struct amdgpu_jpeg {
 	struct delayed_work idle_work;
 	enum amd_powergating_state cur_state;
 	struct mutex jpeg_pg_lock;
+	/* the block is shut down, the idle work must not touch it */
+	bool idle_disabled;
 	atomic_t total_submission_cnt;
 	struct ras_common_if	*ras_if;
 	struct amdgpu_jpeg_ras	*ras;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 34e1242d66ea..1b8e1c456161 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -269,6 +269,8 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
 	if (adev->vcn.harvest_config & (1 << i))
 		return;
 
+	cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+
 	amdgpu_bo_free_kernel(
 		&adev->vcn.inst[i].dpg_sram_bo,
 		&adev->vcn.inst[i].dpg_sram_gpu_addr,
@@ -459,6 +461,15 @@ void amdgpu_vcn_put_profile(struct amdgpu_device *adev)
 	mutex_unlock(&adev->vcn.workload_profile_mutex);
 }
 
+void amdgpu_vcn_stop_idle_work(struct amdgpu_vcn_inst *vcn_inst)
+{
+	/* Never wait for the idle work, this also runs in GPU recovery */
+	cancel_delayed_work(&vcn_inst->idle_work);
+	mutex_lock(&vcn_inst->vcn_pg_lock);
+	vcn_inst->idle_disabled = true;
+	mutex_unlock(&vcn_inst->vcn_pg_lock);
+}
+
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
@@ -470,6 +481,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (adev->vcn.harvest_config & (1 << i))
 		return;
 
+	/* Nothing holding the reset semaphore waits for this work */
+	down_read(&adev->reset_domain->sem);
+
+	mutex_lock(&vcn_inst->vcn_pg_lock);
+	if (vcn_inst->idle_disabled)
+		goto unlock;
+
+	/* Check submissions before fences so a concurrent end_use isn't missed */
+	if (atomic_read_acquire(&vcn_inst->total_submission_cnt))
+		goto reschedule;
+
 	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
 		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
 
@@ -490,15 +512,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
 	fences += fence[i];
 
-	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
-		mutex_lock(&vcn_inst->vcn_pg_lock);
+	if (!fences) {
 		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
-		mutex_unlock(&vcn_inst->vcn_pg_lock);
 		amdgpu_vcn_put_profile(adev);
-
-	} else {
-		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
+		goto unlock;
 	}
+
+reschedule:
+	schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
+unlock:
+	mutex_unlock(&vcn_inst->vcn_pg_lock);
+	up_read(&adev->reset_domain->sem);
 }
 
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
@@ -507,9 +531,10 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
 
 	if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
-		cancel_delayed_work_sync(&vcn_inst->idle_work);
+		cancel_delayed_work(&vcn_inst->idle_work);
 
 	mutex_lock(&vcn_inst->vcn_pg_lock);
+	vcn_inst->idle_disabled = false;
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index bea95307fd42..d4e7d3e27054 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -323,6 +323,8 @@ struct amdgpu_vcn_inst {
 	uint32_t		vcn_codec_disable_mask;
 	atomic_t		total_submission_cnt;
 	struct mutex		vcn_pg_lock;
+	/* the block is shut down, the idle work must not touch it */
+	bool			idle_disabled;
 	enum amd_powergating_state cur_state;
 	struct delayed_work	idle_work;
 	unsigned		fw_version;
@@ -526,6 +528,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
 int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
+void amdgpu_vcn_stop_idle_work(struct amdgpu_vcn_inst *vcn_inst);
 
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
 				enum vcn_ring_type type, uint32_t vcn_instance);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 72069b77f6f1..b048fd4b8b59 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -177,7 +177,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 2968256d4cd7..f6a9258ae3ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -239,7 +239,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 564e40899df2..922711aa06a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -192,7 +192,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index b29ca3a49939..fe7ab9cb35bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -221,7 +221,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 0343a64595f2..f4896ad9d1de 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -455,7 +455,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 4da3f9c995c1..87efc3c2b9e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -250,7 +250,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index dcdb089b4308..91968ad26f17 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -189,7 +189,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index f2debf6b6bd0..27116d1e9e64 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -326,7 +326,7 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index dd0abce73687..7e068c2d4d6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -299,7 +299,7 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 8ddd12740a04..16daeb61114c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -172,7 +172,7 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 76793a5caa70..470d8f110799 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* Override the work func */
-	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
+	/* Own lockdep class, this work is still cancelled synchronously */
+	INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work, vcn_v1_0_idle_work_handler);
 
 	amdgpu_vcn_setup_ucode(adev, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 7d2b9e4b913a..cbc67fdee9ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
-	cancel_delayed_work_sync(&vinst->idle_work);
+	amdgpu_vcn_stop_idle_work(vinst);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 	    (vinst->cur_state != AMD_PG_STATE_GATE &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 10ef5616b2f5..9dd4c313cbe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		/* Override the work func */
-		adev->vcn.inst[j].idle_work.work.func = vcn_v2_5_idle_work_handler;
+		/* Own lockdep class, this work is still cancelled synchronously */
+		INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work, vcn_v2_5_idle_work_handler);
 
 		amdgpu_vcn_setup_ucode(adev, j);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0f4f4d66e2e4..14a19d286db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -449,7 +449,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_stop_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4b7f7bbe18da..6543d1454be4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -374,7 +374,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_stop_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3f39aa83c319..204504e10988 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -417,7 +417,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_stop_idle_work(vinst);
 
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f30f80c1b07f..7823594e808a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -327,7 +327,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_stop_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 7b7c3bc9f046..c2b87b0783ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -291,7 +291,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_stop_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index c9e990ab297d..537e56f32aad 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -364,7 +364,7 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		amdgpu_vcn_stop_idle_work(&adev->vcn.inst[i]);
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index ed47ddd5b08c..dbda56c7c534 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -279,7 +279,7 @@ static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		amdgpu_vcn_stop_idle_work(&adev->vcn.inst[i]);
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
-- 
2.34.1

