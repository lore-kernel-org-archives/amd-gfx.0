Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17F6CDB46B
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jun 2026 15:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F14D310E21F;
	Sat, 20 Jun 2026 15:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H1c4ntUD";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B95C510E21D
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jun 2026 15:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyI7t6Iz0SqRQGVsJFOz3Wf99miu/ismoYa36CDEWdavzUBz9MIdUmmSbH86SaYgYOm56HB2jq5RdWe1/vcNWvn4xQV7Fxa3TjW57egKQMXxmua2yF5DWZNqmCz4NktEsopB6kqGvGDSKCVYqMZUerwB9pF68y7XsA3M1n86bTAxTinrIMiSyOfAL9eiAyrj3XgOEAFueoBZrtfbvea8wB7bYqKkeijV0NHQOfLwpdGNb74U7EPLpMshQfWrKF/aBEJt19ViT8pkM2qRDYgWvbBoLCv+u1NyJszXOL3QzW9bYWntRA78hS+WjupO5dq30fuGnSV9H3oR+ZuJ7G37pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc43Gwz/F4Je/MKi2Vyc5flD9mHskjlL/1YDNhkgpSM=;
 b=qnX8D6TECezQNqLwOfQkKS8rK4uj5IfPR5vNWIaCiy1sy7IdgGpQFRf9J7MoTYXjesHHz62q2SpCqILAEsCsH3kil5fTeltwryJrb4kExXEP2B5gEpEHhs7YogTQvUgckg78mxDbOf43g2ebQM+BMxGLUmhgbm89vfu2zWYyrSSFp/wHQuLPriCJYRTrNKI1hzfnMyl59p+fl3KisRB0PRsjd5WBPQN0Dd3ifLsAVzZv+O8MMAKv1Th3HliIon25t0QuH+/4qoD3aFjuUaUXm8KftXJZkCxIVwvjAYIt+3DYSsnSfl7CcgYjyayl8mlQaXXLkDqcS3V2n1IB+QEBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc43Gwz/F4Je/MKi2Vyc5flD9mHskjlL/1YDNhkgpSM=;
 b=H1c4ntUDENMulaSL4pE/J96sFx34B31qW8rkAk2DKMdC28GjWFJ+Muv+SufWq7PjFZ7h8e/SCLhUBKT1OIK0N7KJOh+87tHm6vK+Mj/b26lSh+7uwJNWCzpcQs8bjt+w4EdGiteyAT7FEII/a0BUY4fWzCCIJ4Z5jdMliuPAygw=
Received: from DS7P220CA0080.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::13) by
 BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 15:38:00 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::54) by DS7P220CA0080.outlook.office365.com
 (2603:10b6:8:259::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.21 via Frontend Transport; Sat, 20
 Jun 2026 15:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Sat, 20 Jun 2026 15:38:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 20 Jun
 2026 10:37:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 20 Jun
 2026 10:37:59 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 20 Jun 2026 10:37:58 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: defer KCQ remap until after MES resume in
 reset flow
Date: Sat, 20 Jun 2026 23:37:35 +0800
Message-ID: <20260620153753.3061314-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260620153753.3061314-1-Jesse.Zhang@amd.com>
References: <20260620153753.3061314-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: bff760d9-905c-4ccd-63ab-08decee1e8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|22082099003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: bDnrgcLHvxvVMZJ7JLX/xPWEaFYigc6gO105EcBpPB6b3oBKAepCFgbCVBnx/XtzbSU8fm90oGIFlM0wY5Q8EhOM3YLhpxal+BdA5UwdRklF8bbwhXlNkBPtArNCuu3Rqo/thccBR6KJBxiVSOVHpBWi0kj4XIxR0WhjhlVdESAt4WBJ8LynCdxYJ4O82TeHd+VzOufQH853yuq4C2oSjfx6s7QBtaQVn2VNFXktuOSRpROGgihS2NFRpNdb2RxAC6VkfSCniER7MC0vgYghw8EMJNzWU7K7NR3gI9oS4ZVLDQI51KLChSVa3sxkfTS2F8ME0cqBGJhMUHWzjgouMamDjOWB4agM9CpE9d2vLI67XUZC/uQjCBHZ1RYf0JfZC8CVrd+YanyaqZYx1AOpemNF5mCg1YAavR1v2nh5Y4vN8y6gQSnO0ZcUxp7y3Wg7PPzrghzQI2EELgkd0DdTI9fKPLFVA3LAag0y/gob9krXwJoK7sf2U50meVg/WohmEiolEPJBLLZ7hyKJEHSmz0E0eGZ02Icm+hsQD54wyIVbYV5xXGmaMCzxpf1fpgJ0543Xp5Rk8xTT+fVtRJg/g0y81E5gOiZ6hZ2pj/PyvezAO0t+6b4wUmblK2wi6bc5UZoKRm/Gu3SF9A3dJmSRnyHF270mhVkW2afE5ljYszstU+NmFYkoDqpoGoLwpPy2mb2Dnp4bpVrgdkvPPb7q/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UxW2l+3x+Do6GPAuv3qsIpf1ZlSKyarkBMhpYu5Jw5FlvbnzYfrG7Jnw0RDWrgbVnrr2KyKkWQevoIQeCxPquifuKhzMH+og7sV6K+2L53vrqudKFgEi0Bdx6ZzJKiL+gDCSk/o6JIP3etMFsPr/cRR/kGSry6kuutmVq+g3ePs2944SDCVJPuGbuFoSQ1n+XXkb7EyUkairBwvVyW91xg91wwVZdbvqECLdvVp1D2Y+0JkcjGYz2M38HjC/8suUqCwy6i8LTbLpY0ifsDlYqKsMo0N3k5fuUauRSzkRsUhhkRFlu18UjkHsW5wGlCHKOIfYqxbCnjJOiGZ3WA/wR/8JwBqJKoqCShC9ydk/7esDwFPaqHAEV0KltTcWUxGoHuyVxgTaeN2V0zgUzqjy2jXQeUkr17KrELnrx1GaKEdFZ92Qi6uEJ18hEpt8RyjI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 15:38:00.3195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff760d9-905c-4ccd-63ab-08decee1e8e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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

Split amdgpu_gfx_mes_reset_queue_start() into reset+unmap now and queue
reinit later, and do the remap only after amdgpu_mes_resume(). Avoids
re-adding legacy queues while MES gangs are still suspended.

Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 70 +++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 982b41606d48..a5b835d0c166 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1989,10 +1989,24 @@ static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
 	return amdgpu_show_reset_mask(buf, adev->gfx.compute_supported_reset);
 }
 
+static int amdgpu_gfx_mes_reset_queue_reinit(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int r;
+
+	amdgpu_gfx_mqd_reset_restore(ring);
+
+	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+	if (r)
+		dev_err(adev->dev, "failed to remap kgq\n");
+
+	return r;
+}
+
 static int amdgpu_gfx_mes_reset_queue_start(struct amdgpu_ring *ring,
 					     unsigned int vmid,
 					     struct amdgpu_fence *timedout_fence,
-					     bool use_mmio)
+					     bool use_mmio, bool *need_reinit)
 {
 	struct amdgpu_device *adev = ring->adev;
 	bool reinit_queue;
@@ -2007,6 +2021,9 @@ static int amdgpu_gfx_mes_reset_queue_start(struct amdgpu_ring *ring,
 	else
 		reinit_queue = use_mmio;
 
+	if (need_reinit)
+		*need_reinit = false;
+
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
@@ -2018,13 +2035,9 @@ static int amdgpu_gfx_mes_reset_queue_start(struct amdgpu_ring *ring,
 						  RESET_QUEUES, 0, 0, 0);
 		if (r)
 			return r;
-		amdgpu_gfx_mqd_reset_restore(ring);
 
-		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-		if (r) {
-			dev_err(adev->dev, "failed to remap kgq\n");
-			return r;
-		}
+		if (need_reinit)
+			*need_reinit = true;
 	}
 	return 0;
 }
@@ -2034,12 +2047,19 @@ int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence,
 			       bool use_mmio)
 {
+	bool need_reinit;
 	int r;
 
+	/* Single-queue reset (no suspend/resume): re-add the queue inline. */
 	r = amdgpu_gfx_mes_reset_queue_start(ring, vmid, timedout_fence,
-					      use_mmio);
+					      use_mmio, &need_reinit);
 	if (r)
 		return r;
+	if (need_reinit) {
+		r = amdgpu_gfx_mes_reset_queue_reinit(ring);
+		if (r)
+			return r;
+	}
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
@@ -2239,7 +2259,8 @@ static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_device *adev,
 				    struct amdgpu_ring *guilty_ring,
 				    unsigned int db,
 				    struct amdgpu_ring **out_ring,
-				    struct amdgpu_fence **out_fence)
+				    struct amdgpu_fence **out_fence,
+				    bool *out_reinit)
 {
 	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
 	struct amdgpu_fence *fence;
@@ -2248,14 +2269,16 @@ static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_device *adev,
 
 	*out_ring = NULL;
 	*out_fence = NULL;
+	*out_reinit = false;
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
 		if (ring == guilty_ring)
 			continue;
 		if (ring->doorbell_index == db) {
 			fence = amdgpu_ring_find_guilty_fence(ring);
+			/* reset + unmap now; re-add (map) is deferred to after resume */
 			r = amdgpu_gfx_mes_reset_queue_start(ring, 0, fence,
-							      use_mmio);
+							      use_mmio, out_reinit);
 			if (r)
 				return r;
 			*out_ring = ring;
@@ -2306,12 +2329,16 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 fence_reset:
 	/* reset the queue this came from if specified */
 	if (ring) {
+		bool reinit = false;
+
+		/* reset + unmap now; re-add (map) is deferred to after resume */
 		r = amdgpu_gfx_mes_reset_queue_start(ring, 0, guilty_fence,
-						      use_mmio);
+						      use_mmio, &reinit);
 		if (r)
 			goto out;
 		deferred_end[n_deferred].ring = ring;
 		deferred_end[n_deferred].fence = guilty_fence;
+		deferred_end[n_deferred].reinit = reinit;
 		n_deferred++;
 	}
 	if (uq) {
@@ -2322,6 +2349,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	for (i = 0; i < num_hung; i++) {
 		struct amdgpu_ring *hr = NULL;
 		struct amdgpu_fence *hf = NULL;
+		bool hr_reinit = false;
 
 		pipe = hqd_info[i].pipe_index;
 		queue = hqd_info[i].queue_index;
@@ -2330,12 +2358,13 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 		/* reset any KCQs */
 		r = amdgpu_gfx_reset_mes_kcq(adev, ring,
 					     adev->gfx.mec.mes_hung_db_array[i],
-					     &hr, &hf);
+					     &hr, &hf, &hr_reinit);
 		if (r)
 			goto out;
 		if (hr) {
 			deferred_end[n_deferred].ring = hr;
 			deferred_end[n_deferred].fence = hf;
+			deferred_end[n_deferred].reinit = hr_reinit;
 			n_deferred++;
 		}
 		/* reset any KFD queues */
@@ -2372,12 +2401,21 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	/* resume all will enable the non-hung queues */
 	amdgpu_mes_resume(adev, 0);
 
-	/* Now CP is running again — replay backed-up commands and ring
-	 * doorbells on each reset queue.
+	/* Now CP is running again — for queues that were unmapped during the
+	 * reset, re-add (map) them only now that MES is resumed and back to a
+	 * normal state, then replay backed-up commands and ring doorbells on
+	 * each reset queue.
 	 */
 	for (i = 0; i < n_deferred; i++) {
-		int er = amdgpu_ring_reset_helper_end(deferred_end[i].ring,
-						      deferred_end[i].fence);
+		int er;
+
+		if (deferred_end[i].reinit) {
+			er = amdgpu_gfx_mes_reset_queue_reinit(deferred_end[i].ring);
+			if (er && !r)
+				r = er;
+		}
+		er = amdgpu_ring_reset_helper_end(deferred_end[i].ring,
+						  deferred_end[i].fence);
 		if (er && !r)
 			r = er;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index aefd4f03b443..9432107c96a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -550,6 +550,7 @@ struct amdgpu_gfx {
 struct amdgpu_gfx_deferred_entry {
 	struct amdgpu_ring	*ring;
 	struct amdgpu_fence	*fence;
+	bool			reinit;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
-- 
2.49.0

