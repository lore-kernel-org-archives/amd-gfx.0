Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D50CC6B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A839410F611;
	Tue, 13 Oct 2026 08:25:34 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3042D10E75F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsIFue88hH5Vge2k0juBeQ3Pa4BmYjriTveiYQfSpNc/mUHngo5TNcmhGFWFwzQSPoYoUplikE+GxFpSFyElCaxpdryapK9xvZnqYKTpoptNb86wjqZM0zDWhqLX20tRDN6wrADIqBTCBRmvaBicjrKLPo+WTxV3ndXQKRqCCsaaKFR2xYWt3RSmEpAJMudnFi67wSwT2uAAoAL4XEukW7ViGowT2Njgt+bps+tItO9QmBU5LcXYaeolprsTVv2byoNbarSCwTRD+OntVt4meG1ogekFnKP5IyLqB4hTeM/Oa7kVM88cx0CTThAdFMl3QQSK7BUAUblYTfiTKiC46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VynFU9MA2TRtD+sZqfiVcJVLi8gh6m6vnIuxG0Ayqvw=;
 b=Pp65AFcqsAOy2/wUFAB6PwpAGJ+d9QGFjADVVrhttDhV0yOw6FzcWRLSjszECDg9seVt57c633e8BukPRfcSKhqaEktAw8AF8H0hQZObH+8+afksfs5U7sDZk19bTn7lvm39gCsNXISIU5ELcrsemkIIFPYvLdJVe9B02wqgBPUWVYsM4VZORVV6ulibDjY4IaVj2kD74e/USMnLIn/RHeHyZEpErqORWh/310sslKjA4YOcavheO7NpyikqBtVAY9OyxFTlBMdjky7Boa1JNf9ek4h8lSPgSTVfk0KS0BKFRvyNKxGo51mVYmeVufOw6BppVJiU23nntZC2iJqzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VynFU9MA2TRtD+sZqfiVcJVLi8gh6m6vnIuxG0Ayqvw=;
 b=JwLV8Tk8Z7gZBQR+L2+b/KhrjhedQI+SiIDyr00nERMFG8tAfl99LstfAMjTD83ycm50iisskzbV4sw0hLQtk+dULTchLyOG1aJjdljKzYmyI4Hx1oEa8K6xE7PzN6Pd5PWDkRY/zIoxTp8fN8Qk5AZm3rHJmvjdrjhXq8Z8rDc=
Received: from DS7PR05CA0020.namprd05.prod.outlook.com (2603:10b6:5:3b9::25)
 by DM4PR12MB9735.namprd12.prod.outlook.com (2603:10b6:8:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Tue, 13 Oct
 2026 08:25:23 +0000
Received: from DS1PEPF00053451.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::11) by DS7PR05CA0020.outlook.office365.com
 (2603:10b6:5:3b9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 08:25:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00053451.mail.protection.outlook.com (10.167.23.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:25:23 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:25:12 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 6/9] drm/amdgpu: serialize JPEG and VCN idle work with GPU
 reset
Date: Tue, 13 Oct 2026 16:24:54 +0800
Message-ID: <20261013082457.2492273-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013082457.2492273-1-Prike.Liang@amd.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053451:EE_|DM4PR12MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca7a3e8-a6e9-4fb9-74b0-08df290386f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|6133799003|18002099003|260925021311599003|260925021911599003|260925022911599003|10067099003|22082099003|3023799007|11063799006|261009223027099003|261009220027099003|261009223327099003|261009221727099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info: y3vOjg+SFVikCQGxXaHvhOKZ+Y6p6KM9AyikO0bjDbJFvCCZOr01tZ5LDdr6CfFDDYsqgL6o7NlzAV2Hi6U7qEgqA0It4dCfdIkrhVi6bbyxy92N6aCjPWfkDCWBxssBuBRirVxdWn7hq0bx8RrqRnjInAkNQurVHtA0NRI2+DmVvfUi4u+XWJnmkKleyfDImZ4BbzWsTFyQIHHwEZYGjbDinH98GZC0IbtSbXb8S8thisSC8jw3WH54sNVgxS34EacUPgKw024heuQJ/UJLInp5iG1O9LisG7/D0cRuDpL+eHh9zeEvKbJum3HBpQuAM/BYHahXp/v3gJ7TevGLAEOfMXRSwOhcLLcTsOO9lw5R3pKPuDB/kj7HzhMLrzkle9BBxQJP8AVGXb5wmB1RhsnkogjZvyIMqmtYrtsCYFxXSm6uRSJCtqeK0OybsrNs2SsDv7McmaEr7okbtvBeEMVPaqdtUGpfX4uQO+BtGeKYSD58ZvjNaub+EJuPZNqVKSuH/A4GGUrnUu4/wl/ncLpYsxGpD1rxkt/PO+hyu6amee0Q4G9gTbvZTfHiGKCWvQRzcI0FumEqj5U44zdHHgIMyJvmfHNuIPd/D2zfCYYsbvQh0oU0XzreuxX6vwifdWrZY3LLnNp/1iB+minljwK1gsyiCHOj61qiFDQ95rfCeuAHuOeOBq+LdUwu/Zo0CvDXJ7i0TLGzdwiCWRbRFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(22082099003)(3023799007)(11063799006)(261009223027099003)(261009220027099003)(261009223327099003)(261009221727099003)(261009221227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2euKJ3jZKwbwVOlFvYnWrlx0sf77tqUNuR4Db4WIxufaea9lw8LmVHGkh1tYjqmfR3xlRNs0L8TXRiKYEMk4s7Z7b7j+SZJm7nNeic1UI5iaeXcIjUuk3LT+525UKASEnZaBqoKMn2oBsd87bK3JRH1xZ0jvXpioxXZL91sCwZ4+l0CQEQi4JTx4sfRsPwrlVTeQsHecHR9MjPm08ivSXYoc3pnVp7UTI7rVekCLq7ViaYnwE/7m5MYOSIr68FdbqT5eJ+e6Jnxum7vYMDroDUcJolfCsY55MASsoNG4KTmyK/SS3CWrqxj/L9eaSItC0q/whhr5OFTqeVbwS4e0mzIUHxc4wSpFfbpKd8GLIKTGv8/JmeU/kz9IQDA9dPwfW+IZ80VF/FEj9PvEPBzqwRVIszXvpEz8W2GhTLmE0Tog1sA+vUtwKfsmNUX4HAv9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:25:23.5178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca7a3e8-a6e9-4fb9-74b0-08df290386f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053451.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9735
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

Take the reset-domain read semaphore in the common JPEG and VCN idle
workers so their hardware accesses wait for GPU recovery to finish.
Keep end-use scheduling, including from recovery ring tests, so idle
engines can power down even if no further jobs arrive.

Do not synchronously cancel these workers from recovery while holding
the reset write semaphore. Use nonblocking cancellation in the common
ring begin-use paths and during reset-time hardware finalization, while
retaining synchronous draining for normal suspend and teardown.

Serialize the idle decision and VCN DPG pause updates with begin-use
under the power-gating mutex. Check the submission count before reading
fences, with acquire ordering against end-use, so a running worker cannot
miss a submission that completes between the two checks.

VCN 1.0 and 2.5 override the common idle worker and retain their existing
worker and cancellation behavior.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 28 +++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 32 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 +-
 21 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 9887a4f99aed..39b53730f59a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -97,7 +97,11 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 
 int amdgpu_jpeg_suspend(struct amdgpu_device *adev)
 {
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* The idle worker may be waiting for the reset writer to release sem. */
+	if (amdgpu_in_reset(adev))
+		cancel_delayed_work(&adev->jpeg.idle_work);
+	else
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	return 0;
 }
@@ -114,6 +118,12 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 	unsigned int fences = 0;
 	unsigned int i, j;
 
+	down_read(&adev->reset_domain->sem);
+	mutex_lock(&adev->jpeg.jpeg_pg_lock);
+	/* Check submissions before fences, while excluding a new begin_use. */
+	if (atomic_read_acquire(&adev->jpeg.total_submission_cnt))
+		goto reschedule;
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1U << i))
 			continue;
@@ -122,13 +132,17 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
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
@@ -136,7 +150,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
-		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+		cancel_delayed_work(&adev->jpeg.idle_work);
 
 	mutex_lock(&adev->jpeg.jpeg_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 17db7264269e..d37f36d554df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -459,6 +459,15 @@ void amdgpu_vcn_put_profile(struct amdgpu_device *adev)
 	mutex_unlock(&adev->vcn.workload_profile_mutex);
 }
 
+void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst)
+{
+	/* The idle worker may be waiting for the reset writer to release sem. */
+	if (amdgpu_in_reset(vcn_inst->adev))
+		cancel_delayed_work(&vcn_inst->idle_work);
+	else
+		cancel_delayed_work_sync(&vcn_inst->idle_work);
+}
+
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
@@ -466,10 +475,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	struct amdgpu_device *adev = vcn_inst->adev;
 	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
 	unsigned int i = vcn_inst->inst, j;
+	bool idle = false;
 
 	if (adev->vcn.harvest_config & (1 << i))
 		return;
 
+	down_read(&adev->reset_domain->sem);
+	mutex_lock(&vcn_inst->vcn_pg_lock);
+	/* Check submissions before fences, while excluding a new begin_use. */
+	if (atomic_read_acquire(&vcn_inst->total_submission_cnt))
+		goto unlock;
+
 	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
 		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
 
@@ -490,15 +506,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
 	fences += fence[i];
 
-	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
-		mutex_lock(&vcn_inst->vcn_pg_lock);
+	idle = !fences;
+	if (idle)
 		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
-		mutex_unlock(&vcn_inst->vcn_pg_lock);
-		amdgpu_vcn_put_profile(adev);
 
-	} else {
+unlock:
+	mutex_unlock(&vcn_inst->vcn_pg_lock);
+	if (idle)
+		amdgpu_vcn_put_profile(adev);
+	else
 		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
-	}
+	up_read(&adev->reset_domain->sem);
 }
 
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
@@ -507,7 +525,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
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
index 4da3f9c995c1..5a0132407a30 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -250,7 +250,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
@@ -883,4 +883,3 @@ const struct amdgpu_ip_block_version jpeg_v4_0_5_ip_block = {
 	.rev = 5,
 	.funcs = &jpeg_v4_0_5_ip_funcs,
 };
-
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
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 7d2b9e4b913a..50378ee5a463 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
-	cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 	    (vinst->cur_state != AMD_PG_STATE_GATE &&
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

