Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF746CD5BAB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4273110E580;
	Fri, 22 May 2026 00:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PvN92+js";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2990610E578
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ufjx/ntkY6DI9Yytf/JIvHPBXJL3ydi5lzxoCEN06JYoSXAFNkvXWnjrdBb6JT6jv1hCCnaEhxR66fA2F3EYIblDyNHPulonb91rCWR0myHPp/LjpO6KK4O1PQ6D1kbaAW7VFO7tr93buXx10NOc1aUAOQObdykIVrJJiurZEVk9UWbhFK5TmH2mozsw6CKSO+9KwCNOrM6EHEssDgpqFMc7CtadYl/+rSS/oWsadeSwPVNcaJID5h0w7qFwRJr6UjKeFGdVB4jsjvPDERntLcsIVdaQzexrumXArxnc/wYnXeyKqkK9bizJ0OCOrkdzYwZEog46Lkiqa23bZuzhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i/BYWC2YPOt0i+JkNiRZFiNlu05YFYjRA+eZdOMmkw=;
 b=DY8gYcqeM1EosEUAciXIPyEFJkeTr7eYH72qSSZUadC6Xe7CgJIMBrjnAM7JcSOFrgwCkirObJ1i8EUZtQ4/FN6OsO3w1/hg9/xfZ8apiyw8zlQXb50zFJXR4UhcCewpLszuevkPXQYtJDEktw7bBNlaGIDMKxT/CdN/8kTGHTq+DE3s+/jxQotkYu8sLjH6YS7zoXu272dMYTnEWhYNYR3YCj07ig1SOQ484j+EsoMKaEtYx4LG09RlR7wSewV1BK3Cx9KiFu1XrJcO9BBBiLg7KZ3Ftq9rEvku39boCNXcopnNwSnYFY2wIiaMp8/1cKjHkBQAdlVCVbP5fWYanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i/BYWC2YPOt0i+JkNiRZFiNlu05YFYjRA+eZdOMmkw=;
 b=PvN92+js9qR0GftctCnIKBEo8FtXZ/mh1W/eYUS5kIF2Qg7Q/EEBgiDUelTNNVFyTk5rF3wzc9pV5Daae4RAGXILwyj6kVO/3jC1rH/8zdWw2Cm58KQwVqSHce7wBu5BJ4ngKEbpNYSCgclvssvCw44boFPiu9vzHYEOhDHPA3U=
Received: from DS7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::28) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Fri, 22 May 2026 00:21:30 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::fa) by DS7P222CA0029.outlook.office365.com
 (2603:10b6:8:2e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/42] drm/amdgpu/vcn: handle pipe reset more gracefully
Date: Thu, 21 May 2026 20:20:12 -0400
Message-ID: <20260522002048.98506-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: fdab85ee-db23-41db-1536-08deb7981260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: Fl2HKtmq807Znx6FsBopQqK72vftzZMA1CxwIRbJccKojsTjc251HAZy2aqD3psj5RaDkCjHKrrfJHzzy2SJVsJNfPbZW+F9lIyQP84vDPsUx3IkAd0uveAB4yNIpk3+fEAAJnj1Ec9rSDZlb2gYJ/uWXEDPJbNhVfA2hJcMarbisgGMvnJZq0Q77GgMERSWwAcbHSsDjcreijEjGnpuaNpG1M7xdH/eBW+eNt4OTn6bhmv64nrGB4qjh7xJHtEFe1wz0+rUxtl8DgCCCyUjBSVrUEQbic714w4RWVJmwzzm1xBp9566tWaYp+aLkO9YHtJPxD8sydKWIasEVMQ1YtCVLAQ0e01dFz6cZVXjxGCfEeKv7XpL5pkrxvquKRt8TBjmOZup57jEpiLJ1+ITBHhCCjpgQFy55Zzt4p4rwZVGX+QJVocj0mKFakitmzL0NN64c1Phq5LuVFr4sGCYYOr+j4psL28ceUPl8zPbMg1zKf/DpkjZvgegZevfwF5mglW+bN+t0rqFZc/lvsW8aI61xiDwi4RpVHxxQiOC1Aegd1mZnjL1cjSWHB4XOfuhMzehI90+FMuKGMjVu3vmIlv65+SO22tGuLqQu84pzVO8jtcT4vxvTTZ9r7gkLC9r2TzHjUMeSDv/Rb+nEaJ0slZFvmp/0clYGV3Rxy2DHKBuLB+cQsTq5IlIPzsHSEdqWIJAWwMz0MRF2fEN1Kip4Nr1fBDGob78J+4exUNKG6U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ChS2Yh+oORSA/isHIt9NRwqo2BKg2kuV8kEPbx5O5nDO2LxfX/wSZ+9kXMqQJFGr6fcO8dhHeMVez8eZXvsW9abcvHdoXOy9qREQL6l9GFIhbjmf9q3/rxBvGV6IxdFYthQjcOUVuPjrRHYxRdVSG0dFkGVG0DOZQoe6dlboyzoUVpAGOnmrUytm2Gv5qFE3xKvfQOYcAk2ldsLMc0vh/eR+gwoLAzHOp8CakUuIF82om+MzE2rR4O6yLThpS8qsjUMc0aIFkjdWrjrD1RGP0AFddfyq7sXFFtMB0b1O5YSgyQKD+QOfj3mdHN9BOLMNdhptn1HoRGQYeDB5Myj7ggZbdPNRithfoZQyzqAiPM3SJxMVfNxWQf5QGe8JrSo+auTiY6/FmsAIZedk8s1mzz9npo/7aQ7M6fCq95mh5mfcGPLu5eSftrqkzrZrxdiX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:30.3602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdab85ee-db23-41db-1536-08deb7981260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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

Save any unprocessed work in the queues using the
new ring helper.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 64 +++++++++++++++----------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 616967519869e..e4d435d4a629d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1485,6 +1485,37 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return ret;
 }
 
+static struct amdgpu_fence *
+amdgpu_vcn_ring_reset_begin_helper(struct amdgpu_ring *ring,
+				   struct amdgpu_ring *guilty_ring,
+				   struct amdgpu_fence *timedout_fence)
+{
+	struct amdgpu_fence *fence;
+
+	drm_sched_wqueue_stop(&ring->sched);
+	if (ring == guilty_ring)
+		fence = timedout_fence;
+	else
+		fence = amdgpu_ring_find_guilty_fence(ring);
+	amdgpu_ring_reset_helper_begin(ring, fence);
+
+	return fence;
+}
+
+static int
+amdgpu_vcn_ring_reset_end_helper(struct amdgpu_ring *ring,
+				 struct amdgpu_fence *fence)
+{
+	int r;
+
+	r = amdgpu_ring_reset_helper_end(ring, fence);
+	if (r)
+		return r;
+
+	drm_sched_wqueue_start(&ring->sched);
+	return 0;
+}
+
 /**
  * amdgpu_vcn_ring_reset - Reset a VCN ring
  * @ring: ring to reset
@@ -1502,48 +1533,33 @@ int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	struct amdgpu_fence *dec_fence;
+	struct amdgpu_fence *enc_fence[AMDGPU_VCN_MAX_ENC_RINGS];
 	int r, i;
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		return -EINVAL;
 
 	mutex_lock(&vinst->engine_reset_mutex);
-	/* Stop the scheduler's work queue for the dec and enc rings if they are running.
-	 * This ensures that no new tasks are submitted to the queues while
-	 * the reset is in progress.
-	 */
-	drm_sched_wqueue_stop(&vinst->ring_dec.sched);
+	dec_fence = amdgpu_vcn_ring_reset_begin_helper(&vinst->ring_dec, ring,
+						       timedout_fence);
 	for (i = 0; i < vinst->num_enc_rings; i++)
-		drm_sched_wqueue_stop(&vinst->ring_enc[i].sched);
+		enc_fence[i] = amdgpu_vcn_ring_reset_begin_helper(&vinst->ring_enc[i], ring,
+								  timedout_fence);
 
 	/* Perform the VCN reset for the specified instance */
 	r = vinst->reset(vinst);
 	if (r)
 		goto unlock;
-	r = amdgpu_ring_test_ring(&vinst->ring_dec);
+
+	r = amdgpu_vcn_ring_reset_end_helper(&vinst->ring_dec, dec_fence);
 	if (r)
 		goto unlock;
 	for (i = 0; i < vinst->num_enc_rings; i++) {
-		r = amdgpu_ring_test_ring(&vinst->ring_enc[i]);
+		r = amdgpu_vcn_ring_reset_end_helper(&vinst->ring_enc[i], enc_fence[i]);
 		if (r)
 			goto unlock;
 	}
-	amdgpu_fence_driver_force_completion(&vinst->ring_dec,
-					     (&vinst->ring_dec == ring) ?
-					     &timedout_fence->base : NULL);
-	for (i = 0; i < vinst->num_enc_rings; i++)
-		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i],
-						     (&vinst->ring_enc[i] == ring) ?
-						     &timedout_fence->base : NULL);
-
-	/* Restart the scheduler's work queue for the dec and enc rings
-	 * if they were stopped by this function. This allows new tasks
-	 * to be submitted to the queues after the reset is complete.
-	 */
-	drm_sched_wqueue_start(&vinst->ring_dec.sched);
-	for (i = 0; i < vinst->num_enc_rings; i++)
-		drm_sched_wqueue_start(&vinst->ring_enc[i].sched);
-
 unlock:
 	mutex_unlock(&vinst->engine_reset_mutex);
 
-- 
2.54.0

