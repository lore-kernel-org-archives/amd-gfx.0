Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5437EC982DA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 16:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8983110E8D9;
	Fri, 16 Jan 2026 16:20:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jSZmSJ6n";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5358810E8D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 16:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7gfFMSL3FvMlHBn5pi7kDsaAi4opwgnCkT0GpUXbEO3wpEdsf0/ocB3sGAD5OO25F16jfrMaxi/rwLxJ0MgPLKRzUpnguvm6sg0UDuDLY1kPSh9fkVUZsWUnz3e1XZFyarlT4yEC+7052sdTEVXpRu2jfcKmO3mbVWseM8Th0E8YleDl/74Qsc/2YGAn1zqeLUrHS5mefBHROg8ZfdD4IQSHmtunfNTAZCLb+aRnoPWRL/0mpNcZgQu0ImB+lrqklRVSe1uc2EJjrXKlQYNlXI2yi1VHEadHIAF+sSf9U5p60Yd5y+72Ly3isBui1YQZIFv/jcIuMB6/mNIZCD2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrZ+KM+v1+iAoxCIGeFlgKrkCEYG5WJxAWBix6NbgXo=;
 b=iNsMODRIL9AVuZ9nihifi3AdE7D7E5rbSKeZO7ULffOt17rzgI5FVQVkK4zcgeE90FrHKFSM4wJo53nBF+xD28cIxNKCcy7PZ08qye2Ff6QBi+apdx4B/Zu7Ywh1zPa0PvynwCsUxPsh+4MyxPWLhmAo+ED6ALZd8olos8WVuW8DeBmmxXRt6U4eMy3LHCtD6X2R/JtXn7pbSxCwFwMbRyfmloEFeSQ+9DRy3qGbuqP08G1wZRuba7nJt4oQMY72Lo9PMLpS9tANnXO1TGcMOY8sRHxQWKAWg3Ay1S6ieGq4Ff4ErHaOpRsprWwEdSKLezjgDxybqNH5aAFF7C1MGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrZ+KM+v1+iAoxCIGeFlgKrkCEYG5WJxAWBix6NbgXo=;
 b=jSZmSJ6nHj1snPgkI7wudkompGO2UvNtGwfddh4um3SuZUayQQKsCz/CLXoCpwf+a89BjqTy5gLtU3j9LL/2Jc2U54O7MzImZ2t+7prcMMLTPEuoOMj2HNjWqxEuBsTagQL+NKhVV2h48nUmZ8Ji4CI9KV4iG2uMQ1WBu57sxu4=
Received: from CH0PR08CA0016.namprd08.prod.outlook.com (2603:10b6:610:33::21)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Fri, 16 Jan
 2026 16:20:47 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:33:cafe::33) by CH0PR08CA0016.outlook.office365.com
 (2603:10b6:610:33::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 16:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Fri, 16 Jan 2026 16:20:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:45 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 08:20:44 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 10:20:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/10] drm/amdgpu: simplify VCN reset helper
Date: Fri, 16 Jan 2026 11:20:26 -0500
Message-ID: <20260116162027.21550-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116162027.21550-1-alexander.deucher@amd.com>
References: <20260116162027.21550-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c54db3-bccc-476e-1bfe-08de551b33ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k/HlkyEVIs3ebSr+pHw8u5L3ClYnbv+/2cS+176Sa+pkH8QBBapq0GA/xd6A?=
 =?us-ascii?Q?jqgel7jXvHCrLLzAILlhaa9+lNMho3Jb9QqDK5fRaT47kEwFQOfr182SJjNB?=
 =?us-ascii?Q?FwS2HOoQbXxFVGssOjMr+Rj3s9t6+sX/GwZmvwIkDlCSJ4XSz3cgTnFV+p/K?=
 =?us-ascii?Q?C92jw16+zGScnORMgNteZ7V9xO10ZzYLerbRdk5iGHravIGhD8Hh3s5gye3X?=
 =?us-ascii?Q?6CTj2c4anAWu7Gmk898T00SN1qm6XfKCN2g9Ii5PT7PgUlDPrbA9UTKezDCH?=
 =?us-ascii?Q?J2vFeW+HpjxEMlcQrCU8tMjlVHBXSlcHIcKbSJ4Mo2e+EMS7iXyJ7g1FkJ7Y?=
 =?us-ascii?Q?grLc3FsoOoo3I/zgc4q0/zfQ2PhJtCdpZuTSupb3e4IHfneLq/1DY1KylsGX?=
 =?us-ascii?Q?PdP2YGX5pgSVgkqZutyT9XXEBF10Fuob14UW6hnbLAnv9j2bybkOt0byFJa/?=
 =?us-ascii?Q?5QHwiy4oMQwg88OwmPhiEVJZo8BMJ0osPmBoipoqpqNEGHteiI0E3hqotm4H?=
 =?us-ascii?Q?B7TownIl7fUPNUNOCBRnfmWRsh0+jpc3nFfMRko0cQdQK/EaA/yUurilBW1H?=
 =?us-ascii?Q?nR4Pm4tJybSV0VeHfh5qoEEuqkhqm5LmwWpKJZLDyJbjbxKh3fK8x8ZnKOEM?=
 =?us-ascii?Q?LJ1UwlKKusoL5nSxyNLgXS7YgRsYRiUGZG5IANVxgzptC5zmdxBLlouFsmUN?=
 =?us-ascii?Q?0AS3HPNIufq4s2m30Q1OAOJCcxtSRxC7kLOyJl3ya+Go3/BQz2xLqNTGMnRX?=
 =?us-ascii?Q?t6BqUraPTNZA21PGjtTzD1bYJyEtB6GI3RO2tuvdFUWfgbwNJyOkOqCV68+i?=
 =?us-ascii?Q?KoD1x9buWcNg+YVCe7fZnZYUZ16r6zN2xRnElVV9JZ9Jc4k7o6KKblseyqkN?=
 =?us-ascii?Q?bgulc7lZCS8emPvSLNCmU1WvRFXPYNFE/67AdHUZWsjYCJdmycGgzQ+iY8uz?=
 =?us-ascii?Q?r/zlEbgkNE/4HF/9zEnME/6D2tpX1eCysLuj9BiAyZ9T6L4QLZxw/jNTqLze?=
 =?us-ascii?Q?DdvS8ENPoh3LmbR1WvGvB0ojgZKy7D1gS9pfvTwOM78xrk2u3SmMPgn7o3am?=
 =?us-ascii?Q?Kpxg3bGxvjTP2MgrYRNBShcM/YaXQz42OhRghlYs+HB1lEYCPImfvPfDekSF?=
 =?us-ascii?Q?ydXnrV8T4ixDVJZ1pDJRnD94X/8eEY6wqAJrBcM0LXhCJh9W+9yAwygo+NQ5?=
 =?us-ascii?Q?to3di7Ya/QYm9kRhOX42J/YeeIU1C33UFZ4aOZgeyOA7wLsxc/8NdoRnWnU2?=
 =?us-ascii?Q?3T7VBYKtE8YMeONmz1XdVf5+3kHgKBptlkJOwEelqYQOFEvQMZt3IqPp5sD/?=
 =?us-ascii?Q?vWpJqwxkCE3NoR/mKW9nDcNIeggVvtAb3uxojZ6OOJxNmvxT1phxaN5O3NkR?=
 =?us-ascii?Q?l7J5iV3wthpb26U4PxSS21XfyOp5q7jfwDmXXwpq38/vG6Ys+pHpiB86pDzy?=
 =?us-ascii?Q?pCHEK/qxjO/Kuvo5mJW8SBlLOgnVL2IdJFN+n/PdfXq7wg9a3s7G4zXgK/KJ?=
 =?us-ascii?Q?q1yWyWm+QSB68xbexgD6OuIpn/AZPbUPvTFbt6bhCPM5qTPa4S6ym4XDpmLn?=
 =?us-ascii?Q?9ZqMcLJr4f560huI+XlbS1DmCNTueIVVQrpG4XTJDxRxpvz/8MWjb8wOSSsO?=
 =?us-ascii?Q?Lhk6OhPihsmvXjxgrCfbPJX8kH+qW0Ed9T65yHkDOXU1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:20:45.7472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c54db3-bccc-476e-1bfe-08de551b33ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
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

