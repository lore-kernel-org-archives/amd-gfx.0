Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2847606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nja1Ym0p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 772ED112406;
	Thu, 22 Oct 2026 08:35:04 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F99112406
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPA2C0dxXERbSg7m8vKruLqxvmcwGBW9+wm9U2ULI9fJYuKiTtX+iSAcpKh03H4NVxCVVJHw1GfYzVq2zD/RTs6kGH54n0YqyO7+GZ68rSxU8oymJHyffRyPr+h1tQDpp/cExAioV+CYUQrj9TakTt18DTdg13bPdOeE1GaTl6ydlU+KNpLH93o0dkOcxMRMYqx+uACLQ6uSYyLb3bRhwrw2Fd0XsELaz16B8/PwnOgUtwH37RDpV0QVNmrOdS79ruXZPJHqha1xDjfikZ817suDKXKc5J8EUIPUQsFAxcS2rtaeOr9pS9E+oVsAFsYubB9pe+GXIs1vZl60Ze/u6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07OnD3YQtyGrXaYFnd93/NtLhdLzjVJQP8OQylhMvpI=;
 b=w5jgcp6mtPM3OER7VZf6VqN3zbKrKPeTc8jSbZZGlCIXYeMy46s58k4CLSdV7Ar3DlYZAAtpifpAGrOwwyiUD6036NX6FIJ58/2TIWeLI0DcyayMT+p+1d5onYbZEukTE4ijFrxZXLrBCRRgSwq6AWPio+lSlVQC6UN8WM3Ci6cJiztbnhnNa7UnlXMeQMpJ5bw3gbiCR3JWEdoxAkf5lLY+4ygwgF/8Xw0sZUQ45Lu3K4l5Q34awmRR4/t3fE4NyPFWI4qRs9TdK69Q3tkD2U80hU7JtxieaISFD1hMXkdkIdWIuZTCtEjC0l9icR6i9ImSaXxQc8UrrbQzQiMd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07OnD3YQtyGrXaYFnd93/NtLhdLzjVJQP8OQylhMvpI=;
 b=nja1Ym0pcsASot9BDip6w/c/FaJIHOMC4Y9kgT+n0KnsoA5LJkEpvk6MbU8TOCBaHv9KL7vUVl/7wqwDf48aMb7ILnAMSlDBHMPx4ZKSUNiIAjc888I8nm7kfeLkAjqc3QHZU6v/09X0DwOZRbY8T56yuOlSSaefoWaIrl7HBuI=
Received: from CH0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:610:32::7)
 by CY3PR12MB9605.namprd12.prod.outlook.com (2603:10b6:930:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:33:52 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::8) by CH0PR07CA0002.outlook.office365.com
 (2603:10b6:610:32::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 08:33:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:33:52 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:33:49 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 6/9] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN idle
 work
Date: Thu, 22 Oct 2026 16:33:28 +0800
Message-ID: <20261022083331.3019779-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022083331.3019779-1-Prike.Liang@amd.com>
References: <20261022083331.3019779-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|CY3PR12MB9605:EE_
X-MS-Office365-Filtering-Correlation-Id: 3920a834-b361-4132-5cfc-08df301733d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|6133799003|22082099003|18002099003|261021121427099003|13003099007|3023799007|261021123027099003|11063799006|5023799004|261009220027099003|261009221227099003|261009223027099003|10067099003|261009221727099003|261009223327099003|260925022911599003|260925021911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info: 7f6H5wMPlcWrlpWes+Z2q+vtv57paqqeHb2qk9QXD5j6sDMw65A/fbzgCS43XsSEfpDZoIUwU06G4sJmh9BHD27NRD3UFgvJRXEeEWFxobzW0n5V3/kG6d/AZosww+iUTj67EtDViPGtCR1RPNt03ghamEyLBufWT3wh4/z9fkZCaBraKwDihVTGaHPqwDwAk3wcJ0Ri+HuC4KZqcv72cEOyUeEpAWg4eNHsbP8dHIP0wFuCOmsquxQfOq0eaJrpVzQPEpO0uwTinOPjP/lU/2k5NYipfQsIAQX4ojEYbBEOqAQL5eBR9Gn4xaonb/MLlm5sHYPCIviq+8o2+mBpwb63giv167SLwLp46Jz2tMCbMfcruLPHsH1xZc65N3Zy3yt80r3Sdaxc0iPMLlWMGcE+wHqWagvMjaXlYGaKKcGOHFxIRTCWQtLuLkJRCZSyIkTJKn9xq1WAiLt7KZ2n/FJY/g7gq4B8Je3KKaDjMI47HTE8yl8FYVmBOgCRY5qJczgigRClbD8ijVsLAdYJCSpSVff8xcMSIMH27yG15zrm2WQ2hmWCEvBCLDxyocTHK2fWRekECX4xvUXj7Qm7HZf8FMtCwd0VIwZuX2jgJN5nKGe5VFvF8371sbPh796wvT7v0VQYJed1KAqw+UQirQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(261021121427099003)(13003099007)(3023799007)(261021123027099003)(11063799006)(5023799004)(261009220027099003)(261009221227099003)(261009223027099003)(10067099003)(261009221727099003)(261009223327099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jddykosUQl8YXIoABFs7pVMnpeMXcjit7o9F2VjPvT9ZhiQ544uYmjauvPv3ag38WOmvrtn7Y8GL2xqiCS3kmduN5hoUpkJH9G1VjbR6G8ZxU9ev9flMxgxUnARGTcpeqwLRfTVkQcxAHSWHjdRWzWgbF0l3qENFPvOdr0LSQONtndqw/+yLeenBG/TVdAHbb/tcT38J+InC+0aUO/i8i/dSVlvrST008r4E404/qpPLXqpmaW8JegSwn9OjxJydyvphBANOOHOr14CpL3lGRd6AykmJEJX+eEUAP4++WSaM7+0tVC9AT4LsVRZlqGn7wZRVd3wq70aAfubQz0nfL7NKvgEvyNS6MaerH/ouYE3zk4RiXmutitbXX3UPBbhfGZviFN2VapRjbKtBe7yJrLzRnxnfoV9FYFsiYRb3/G4Cb5nYRTrKyGQ2fwim806A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:33:52.1376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3920a834-b361-4132-5cfc-08df301733d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9605
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The common JPEG and VCN idle workers program power gating and DPG pause,
so they must not run while a GPU reset is in progress. Recovery must not
wait for them either, since everything the workers depend on then
becomes a dependency of GPU recovery.

Make the workers take reset_domain->sem for read, so they wait for a
running reset instead of touching the hardware. hw_fini/suspend run from
GPU recovery as well as from system suspend and unload, so only skip
waiting for the idle work when the reset itself calls them. The reset
holds the semaphore for write and would otherwise deadlock on a worker
blocked on it. Outside a reset the cancel stays synchronous, so no
worker touches a block that has been shut down.

begin_use also runs in recovery for the IB tests, so it never waits. The
worker now checks the submission count and gates the block under the
power gating lock, so it can't gate the block behind a concurrent
begin_use. sw_fini still cancels synchronously, it never runs with the
reset semaphore held.

Update versions: https://lore.kernel.org/amd-gfx/PH7PR12MB6000698A62D208E47BB358D7FB662@
PH7PR12MB6000.namprd12.prod.outlook.com/

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 32 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 35 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  1 +
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
 23 files changed, 76 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 87f879a2e4f4..3c1e7bf31a08 100644
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
+	/* The reset mustn't wait for the idle work, which waits for the reset */
+	if (amdgpu_in_reset(adev))
+		cancel_delayed_work(&adev->jpeg.idle_work);
+	else
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	return 0;
 }
@@ -114,6 +120,14 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 	unsigned int fences = 0;
 	unsigned int i, j;
 
+	/* Nothing holding the reset semaphore waits for this work */
+	down_read(&adev->reset_domain->sem);
+
+	mutex_lock(&adev->jpeg.jpeg_pg_lock);
+	/* Check submissions before fences so a concurrent end_use isn't missed */
+	if (atomic_read_acquire(&adev->jpeg.total_submission_cnt))
+		goto reschedule;
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1U << i))
 			continue;
@@ -122,13 +136,17 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
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
@@ -136,7 +154,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
-		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+		cancel_delayed_work(&adev->jpeg.idle_work);
 
 	mutex_lock(&adev->jpeg.jpeg_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 34e1242d66ea..fee6bea52e5e 100644
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
 
+void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst)
+{
+	/* The reset mustn't wait for the idle work, which waits for the reset */
+	if (amdgpu_in_reset(vcn_inst->adev))
+		cancel_delayed_work(&vcn_inst->idle_work);
+	else
+		cancel_delayed_work_sync(&vcn_inst->idle_work);
+}
+
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
@@ -470,6 +481,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (adev->vcn.harvest_config & (1 << i))
 		return;
 
+	/* Nothing holding the reset semaphore waits for this work */
+	down_read(&adev->reset_domain->sem);
+
+	mutex_lock(&vcn_inst->vcn_pg_lock);
+	/* Check submissions before fences so a concurrent end_use isn't missed */
+	if (atomic_read_acquire(&vcn_inst->total_submission_cnt))
+		goto reschedule;
+
 	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
 		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
 
@@ -490,15 +509,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
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
@@ -507,7 +528,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
 
 	if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
-		cancel_delayed_work_sync(&vcn_inst->idle_work);
+		cancel_delayed_work(&vcn_inst->idle_work);
 
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index bea95307fd42..a6438950854e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -526,6 +526,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
 int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
+void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst);
 
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
index 7d2b9e4b913a..ba451f2a2534 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
-	cancel_delayed_work_sync(&vinst->idle_work);
+	amdgpu_vcn_cancel_idle_work(vinst);
 
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
index 0f4f4d66e2e4..3e85abd1e82c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -449,7 +449,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4b7f7bbe18da..5b47a643d725 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -374,7 +374,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3f39aa83c319..5aa09c3bd79b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -417,7 +417,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f30f80c1b07f..9693950cd16d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -327,7 +327,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 7b7c3bc9f046..0c189063a6ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -291,7 +291,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index c9e990ab297d..3fa553fb41d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -364,7 +364,7 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index ed47ddd5b08c..eb13f792e25d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -279,7 +279,7 @@ static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
-- 
2.34.1

