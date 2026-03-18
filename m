Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC931077604
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 18:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3968110E44B;
	Wed, 18 Mar 2026 18:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rtPrIhQY";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78BE610E43D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 18:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFxLX95LiFDceqogMQrQN4vjwjI3MnQadqmoIcliKkzvE129KEh8C/XXe5FY4Sd12LiRwbsP+S2gQ/31dXWYAe5zE6cs41Bjxx5i9V+iIY0WTyCVCvuJzaoh9qShLoK4yi1qcgnsqwK9mSLeWvoHuSOoKXqyu9l1+qM00EdFoau5miyGItfEMXiRpFRhi0ZjaIewSiU2F2tFwjocZYMs5dtdCGYJyyNPh8REeZXZHdRyrq/FpQ9Qdf9LpE3ZeUo/FbSzieR6cUjrKut70rFrOh86wn+GcMEkUkvPseQxKMYrMZ0ub5lpxNIXDypHOLzExurYQPbE6k2NoNrkbP0TpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50xY9HTl17eBtKNcbrh2faKXUzk7MX2PUUYIsPOX1BY=;
 b=ygiSWLqaTLln+171jER2e0M/9A1PAbhWDuBM4/hrCt9lbLCbU/mLPBgWWyIem4GwQKN0vn5bW78a9exzMMII8Rv+48ixxVHFLH5PLUHvSXUtc6ZwZd9AaUwj5vgXbOt/KZUY+WedjyuoveXY41SUbj0KK4SMFymaFCeeFyk8T26e8O+GAt6y5MsO5ZLxxXcd2+EIZzINhFu/Kjjov2kQZIOxQCqZz7CQvy3q4UOv25/OXcR4fh2uPoP5SPriMQyrV9o39ANxJDCRoKJz0IX/5VuPbHUCcfCYqyFLi9YSOVLvZrPcazi4prqlFZ8nL7edBFW7MxsD8qs+EOQVAzVSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50xY9HTl17eBtKNcbrh2faKXUzk7MX2PUUYIsPOX1BY=;
 b=rtPrIhQYaiyHVggtd5LIySpTioAWKExGXS9DwJafMMEvjPgxex6jdF1yEBLhtmzYwmRxjHfBXnkeswKGReMJaBLeJ9ap39S8y18QZYgYwcDzMs1AAFj8kuLfRT2Izw1BCLHsXDH8J5mqdQb8f7MR7MgdsGSUUf3Tjy0qkFJJth4=
Received: from MW4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:303:16d::9)
 by CY3PR12MB9704.namprd12.prod.outlook.com (2603:10b6:930:102::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 18:36:18 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::53) by MW4PR02CA0024.outlook.office365.com
 (2603:10b6:303:16d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 18:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 18:36:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Mar
 2026 13:36:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Mar
 2026 13:36:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 13:36:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: simplify VCN reset helper
Date: Wed, 18 Mar 2026 14:36:02 -0400
Message-ID: <20260318183604.16505-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318183604.16505-1-alexander.deucher@amd.com>
References: <20260318183604.16505-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CY3PR12MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: a7536f5d-b129-4b1a-1728-08de851d3e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yCyQ5igF9YIQNPFjHyTz1SRWiiIkE1LIuIM0UiKXZaMihcmnPD35p/3AYJalaV36dU5Rrfk5GowfOnv0VhmSJvpHrC/PZvDqOEPvp8S9qpm9YQZrpijSm3NnexRmSn3O8lh4Bu6l9Bk6m3HzRZqswrpZpyQWiZalrISJcOh6jk/fuEq8YcTTjlyx3WnCul6lqgOe8bV3RVkBXp73vIvZxY3UfyMrCIhN9RauRCO5+l9if8gsWwLMBvLr48l3LGvd24G/BZuIVc3VKKizNKvv5psI5IYex758gTr4aPRwj8arMpjWCQsRJyexDaaXRgBDUH+qPZGRA66h324nVKgsuOPTefxzFUdRe033iNHs30ty8TiQY9NCpPxYp1L8XV8WItfECK2F2bZzVNhtgRcLzMfwPLyhJlm7h7K8fzKd1RD6Mdh5u1PiBMkd4PMopx7qdiCXDutdN4Xvhj7xlcSi3c91dIc9rVg/LzYOsbHpGJjigt1AGCq2TzNNbmMrEkUUt0IE9kfoO+ur2WNsNq2u0ik4D9Q3NwibQfzI+X/JVZ8rq9wkrF74E1Huc+NhSMlR+xRTCO625/18EkNj5PFpnl+DzIN1DpVuxZvslHaJBuDEwbf1NoqrQ571yjG783ztg5nfFK478mS0cptc9LLqPwq9zWcIJhPKeuVotzd6bBPSIbFk/0Rp5nP0x6CP8gjWbPh3FUVfOgYQfkpZpTCg0j1KZdcs/C9cI+uEXgKdG+xul47X9YNZNnklrpakBEWUTGevlie5pTBClfEdA1edxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BZlSqHQlEK2f4adfbdhF3nvNmzxnlFoLEpF9FROk2raqtkUTH94T09yFW0fuqExxxyq8km+f6y6L7VjkjDbYkGgJosSuVLrQaFhYlEK+LkJcYDiJibQsY8PHrdDSXqO2rAO66iQp9YPkDfdvnnc5MuuCjgMVBJChFGGaXlRHw6BSKi2FUJI+q9FqA13mwpP/t506O9847Nno7Oc4xFT/DwPxrWYKjfJj4PrTXEa9dhs5imYdhKLJGXnHEEWU9scMDMzdKeeVzoyd5lpUVgMJx8qP8tgBie2xEKqMxzlERlY4r0m34cP/6wauyy27tvWAkNqM4F+RyGKaUVD5w+WI7tFc6Bl+QJfgumY4fuynJ3+7hpyVewiygho0KbqCPtvRRhv6EpcePI5UIENQxVilNO7A3ZWEQddn33ViSflb9xEZtcWIAtPFSjAsmGWIDIip
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:36:18.0061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7536f5d-b129-4b1a-1728-08de851d3e72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9704
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

Remove the wrapper function.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 41 ++++++++-----------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 46af6475c4899..6314a8824146e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1485,19 +1485,27 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 }
 
 /**
- * amdgpu_vcn_reset_engine - Reset a specific VCN engine
- * @ring: Pointer to the VCN ring
- * @timedout_fence: fence that timed out
+ * amdgpu_vcn_ring_reset - Reset a VCN ring
+ * @ring: ring to reset
+ * @vmid: vmid of guilty job
+ * @timedout_fence: fence of timed out job
  *
+ * This helper is for VCN blocks without unified queues because
+ * resetting the engine resets all queues in that case.  With
+ * unified queues we have one queue per engine.
  * Returns: 0 on success, or a negative error code on failure.
  */
-static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
-				   struct amdgpu_fence *timedout_fence)
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r, i;
 
+	if (adev->vcn.inst[ring->me].using_unified_queue)
+		return -EINVAL;
+
 	mutex_lock(&vinst->engine_reset_mutex);
 	/* Stop the scheduler's work queue for the dec and enc rings if they are running.
 	 * This ensures that no new tasks are submitted to the queues while
@@ -1541,29 +1549,6 @@ static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
 	return r;
 }
 
-/**
- * amdgpu_vcn_ring_reset - Reset a VCN ring
- * @ring: ring to reset
- * @vmid: vmid of guilty job
- * @timedout_fence: fence of timed out job
- *
- * This helper is for VCN blocks without unified queues because
- * resetting the engine resets all queues in that case.  With
- * unified queues we have one queue per engine.
- * Returns: 0 on success, or a negative error code on failure.
- */
-int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
-			  unsigned int vmid,
-			  struct amdgpu_fence *timedout_fence)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	if (adev->vcn.inst[ring->me].using_unified_queue)
-		return -EINVAL;
-
-	return amdgpu_vcn_reset_engine(ring, timedout_fence);
-}
-
 int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
 			     const struct amdgpu_hwip_reg_entry *reg, u32 count)
 {
-- 
2.53.0

