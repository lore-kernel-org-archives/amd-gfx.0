Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CDED77892
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 17:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13BC310EB75;
	Fri, 23 Jan 2026 17:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mOmwl92a";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BDF310EB68
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 17:19:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/Yy5PypOsnRJNMaop2CvhStbAHMs0L40+jirWarggE+9+MRM+LHXZ3yA7uhA9N9AfoTdkT+0SFsFERcrOj4HyqE3vFJvBm5ps7xL34AlHkcScE3OZngdCearaRhdfsu5EYvboEZEx2Q4Rhy8ozcX6NdxJyVutH1ea4sIU4h8Z0ckfg5v8vbH+RF+aaoR9o4jwbLxu2J7AXwD1jWmT7Uo4iBD3LC/XwRQIp2RnSr5iL8F/IZDIqftkxnGOuVqWvH++Zkp0uBDsl1+XnUGrLfF7yz70OuomZxhhoBfR5Jadcr8fMNTpfwfkx2l/kHxUxrQj3P2K3jZumnGfy63FtHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQBUTPex+wLXzSug1A5R/EVq8YtzhW7g6eth1voshIc=;
 b=qKPD043Lpse+iINBJzWEG9PydtdkcoemxNN/ruqL/oOAqe4v9CCPU0X4zNFlDxcHDFjM0/2AO3oNis4YTWSSI9+xdd24m3OmRdlFbBFY6mHX64uVF3J5ioj0uopRvE1DQJD2mm1YSZstR8l1UEZz1vw4WHYijkVbJXcY+TqDbMPVRvV1Vh+L87OM8jWekqGhVU0ywk1XWlPAy7SrF6X3DO2u+x9GmEr1/0aY6t/xXSVsT9DoQcwVVzSOKRxCOsHBt9TXHTBSpg23r6Y7WQGLMWalLWYqcChbcwaLiTd8Zf91lruIopfHeGpQxK/pW9wlHt/Hz6oCxdnfpwx0JU0jpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQBUTPex+wLXzSug1A5R/EVq8YtzhW7g6eth1voshIc=;
 b=mOmwl92aDLWvRNHKIAALEcxkepSEuNnKmIqxi/jCMIEndwYxL9dA23ipzVOVDCluwD74skA/upG0LHXdTr+cdtq1bzlM8wgE989QN9/w7Ullb5A2syKDJ4rofJQAnPR4u+KBwavN7CwXpOJLMTdbte+d8yU3op/NxGH+OtkUNIs=
Received: from BL1PR13CA0323.namprd13.prod.outlook.com (2603:10b6:208:2c1::28)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 17:19:54 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::d8) by BL1PR13CA0323.outlook.office365.com
 (2603:10b6:208:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.4 via Frontend Transport; Fri,
 23 Jan 2026 17:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:19:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 23 Jan
 2026 11:19:49 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Jan
 2026 11:19:49 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 11:19:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 08/11] drm/amdgpu: simplify VCN reset helper
Date: Fri, 23 Jan 2026 12:19:34 -0500
Message-ID: <20260123171938.16814-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123171938.16814-1-alexander.deucher@amd.com>
References: <20260123171938.16814-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 300d12bb-0f57-4085-d87f-08de5aa3a008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Zd6kANcWCrSETkdRP4iqSOD4sMo48iqFpcFslVDPDUxbOUUpQmYYFgwbjQ2?=
 =?us-ascii?Q?+eNnCJsWvX/fBa6dkHEjb88KpzvtH5PvXtFTHa5lgFvr7o4yO6JNPf/ya2+F?=
 =?us-ascii?Q?a0gy8z+V8RmxH+IMkFI8ZZ9OBO96miaga1JQGFiWff2x1070vEWT4xPjqRVm?=
 =?us-ascii?Q?SuPLEXEGePwGiMAugN2FEV2WEc9frETF8589zKVf8lfI9eIKxNr/lh5K+ZE2?=
 =?us-ascii?Q?e9acf7zfbefBEmiiSmnkqqNRIcwqLW2fJNwMd1+C6WLVbw8NU5qR06iElBc3?=
 =?us-ascii?Q?osB7sL2OG4drW2Dyhx31CA9Gyc+VhXIwjVu2mRSeBP1hLVC8yoRq+1cUYzfz?=
 =?us-ascii?Q?gDA2P0kf0TZ2zRNnxqmiwzoJdKlb6LH+vAvxwv4DpSkN3Gcib9+ln9NIQMyF?=
 =?us-ascii?Q?YwqGBykyoJ1T3kPQoohrpIPaNDyZneYsAbdQxfM+B3PJPclUQ9QKOOraP+Nr?=
 =?us-ascii?Q?qF/o8Uj9zTI6BkQeAIiTnNDwd498rTdQRIOqqQljbddCd6aIzEqkGOzATkrh?=
 =?us-ascii?Q?iM2P2CduIZO5yKgZbPHThx0BgTPFSQ6k8TxOD8rJhGbFsW+an8H708hQM+p8?=
 =?us-ascii?Q?AYOXZ8goO5rU2xI+PTlym4rwIqeIIuO1+XLeLxWQjR06djyrqG2+f0Gh3FhH?=
 =?us-ascii?Q?LL7keta9WhjUP3T735Rj1UWgQW7y1cqKWH2B+uaMBDe5I8ob7R+1ln97SQCg?=
 =?us-ascii?Q?RmeTboya93EgwGAoNi/S8bP4QIh9w3GyR0Jj6s0ahD5/iKa+pIiHwSSwsrrD?=
 =?us-ascii?Q?CGCylKIo7dPXBuPsWS2uriDtDSI/1zf7AOrFdavcYbOwnILX2OsbHg2gjdcb?=
 =?us-ascii?Q?/5BtJhlkkMUd3HiuoEMuCgC7vDGdYt0WIJvqtAA4HbLT6N25JW9R2KMORpOU?=
 =?us-ascii?Q?g6IF9KGMFPoNlGtrUCzn0TEOG30h5iD7j0Sgk8xwOV/jq+/kDlTTg6y0dcJ3?=
 =?us-ascii?Q?cnZnjOvuG+4t4ppCeSo6PL+vAtBv6yfpJ1shL0GkEMb1CjBRIZVhS4fBxF7O?=
 =?us-ascii?Q?gOZgwtoG12e6yrLIEj+dlDe8dFZsXO1EGjagIn3WdjbUJtR4IIYe5+yizAhh?=
 =?us-ascii?Q?lfUnlxt5kcUIdDCfX9plcLxpxV0AjmCFfbWWh+NqsQrw74swAextVWKnY0kF?=
 =?us-ascii?Q?CIDzbZgPX/2eV2YHo17ZI5QYh8tJIGH0GhHNd1v/8ABsSIIC5m2aFaIK5MC4?=
 =?us-ascii?Q?6PiuBi0xr0f1NEHRVJZ5TJE7NToTgkJqTfzgfz6AQwsIluPVntRboQCkhwnu?=
 =?us-ascii?Q?AeLAcymfBLR21U49Q21gaEuk/1K33Yn422hFTjKz+wV6fRLL+cB626AeCPPZ?=
 =?us-ascii?Q?lDEstX5Pt2vbg5W5UGHVzVM+Ekm9223Y04uT6z8L8vrKNwCrdt50kMDRuQ1s?=
 =?us-ascii?Q?FNWu9Sf1gpRi5rqEAEmhHAQlM+gyfOvYznlcnhQqCKQAmXdoBmB43oH/6oPT?=
 =?us-ascii?Q?l0zJBQS2J488D7GRVS7GrpfjHaV4ab9QmrA52666r2gDjXBm3HPg37E2K7Dd?=
 =?us-ascii?Q?vtvamLq/jrvZ0hbz+6t/3GvM4aZKxY4xp/nVZl46yQsSYsfSYGTZTnMHrxa8?=
 =?us-ascii?Q?ZpojFMAK7eK7zB67qQ063p5vVicG3ZvYPxJGP5Isllijq9wzXvLfsI0/BvGM?=
 =?us-ascii?Q?p4wxV3w8tPl81OFHeaPEwUgCkuZUAoY2YoHwuibicklC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:19:54.3862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300d12bb-0f57-4085-d87f-08de5aa3a008
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
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
index d22c8980fa42b..4de5c8b9a4cc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1481,19 +1481,27 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
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
@@ -1537,29 +1545,6 @@ static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
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
2.52.0

