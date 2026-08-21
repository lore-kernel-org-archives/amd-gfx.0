Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF23DC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2426410F339;
	Fri, 21 Aug 2026 16:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z6YzH7LA";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013070.outbound.protection.outlook.com
 [40.107.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4B310F339
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFpi4XkJeb1c0UHtrf3ZUOBaXPWIoX+hFUiGzG+2Jt4syKYPmwtTCHaKGQxdvBLHoTtEhZQF30OC6AhdgtGPfazktiH4XGC6X7TmjxWY8XkPrWT30eCnlIF8qWTKtv3OnhupkszoR6zWx5JhYf2G4rWiWUl8PmTQY0dPTOVZjxeqNq0Le/xZKNUI5MOcqvzA/uLjmpuGElS+0p5+ojnypWFBh/ABERltuyjZxv37TizXWNL8UneIg7ABA0bQAOUpm+PQ90BZH4kQfnI5zAvIOE7YUTshioeVbTlkPYISVDnU8DsdpXrkxSp0mquE4QqD0PojnE7Ogm8F7jBkKrvhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv/SWbF/wLrSRP6CX+XkoOWJH1AQaNCnR6Bv7t0mIZM=;
 b=qvWqTJmsgEGVuKQZDj4Lp8gKdawe8pqjcY9E7BFHfP00neQhZT2hUWFDkiB90aYALYhvzt9Wb/DmGZXeRAgwLZeGIIL48XnyLXR3f5GpedbuvyGpPtUhHjPiAgFI7v7wqd/ZhpkVGfAL/TB8FXbOvdMdNnMAD1xZXLJwgUipYd7XkO4+7YMLG/T0a574CfekYucP2trzR12PAcDafkDoy7/BCQydufNd+sSlgD8wjm/roF4gmKnQ1dTEzMhkHmgiCtKE6CkUaYILd9SN6eBWrbPhv/UylLYmcnn4dsIJR4/sy1Sqtodx920BRqQnT8EMANZ6KIQl6HK60PIFDwZgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv/SWbF/wLrSRP6CX+XkoOWJH1AQaNCnR6Bv7t0mIZM=;
 b=Z6YzH7LAyf49cFVrcBj/Qu/FcytIKh472jGTd4jfRtcr9oZk1bnOUAwPmruk3IxbFrsWzS+2ckfFc/e6qYBPT9gAMUgjMcY1GniFReyfsyQFGqYlpVmS8MwZBjknanpMp9U9kkOx6aTs/QXz+dUNLy/cR1mmIQ8Skw7qUlHoBp4=
Received: from SJ0PR13CA0240.namprd13.prod.outlook.com (2603:10b6:a03:2c1::35)
 by LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:04:04 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::4) by SJ0PR13CA0240.outlook.office365.com
 (2603:10b6:a03:2c1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 16:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:04:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:04:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:04:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Update SDMA engines reporting for GFX 12.1
Date: Fri, 21 Aug 2026 12:03:54 -0400
Message-ID: <20260821160354.751604-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160354.751604-1-alexander.deucher@amd.com>
References: <20260821160354.751604-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: c38f819e-5c41-48da-c59b-08deff9dd2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VXIQKT6OW/BSsQFo4omdStHr89OvTP47Y1iAavST4EmW9jM6aGDkiReB6WGC+98b0szuJ8u1zWfMe9UwfUMXEevQDvwIA8sHPuxQtzPKbraCrDKVEccrl//TBkkBJWhWEUr84eS6D/hEhtDbQLedLSoxQTaAVJTQFOW2n9k3KlxL5tAwAnwzjFeqCN5+whCE3CKo70E1HcLAA3PPe6kbR/2DDA02d8dEfCNL86es+XweUBVVha5me5BWPnE0nZEwRx3fdz1xbhkZw9sA+5R8HLGe6n+x96ODCSsZqrgMomEf/0AONtv7Y/VmyLVkqdLZIQy/cpCgR6k8Z7+N1KvKGkuoorYd3H/AK4AntmX7/mcObghtwueDYEvMDZtqr8elMKRTyJEMcoUnLd0/mrIbfOTadTL8MoxQP9FgSgHcBtl7tdfi0AlqqGRUyTY3rY0rfaWx62h8elqK5I87a76mQh5vUjBws+BaAR0SK5aWzjoI85PRHUv9axKJB8BEIjCSyZdx6DJf7I2CTQ7uI9wX5V0LS8xWYaI2q8hAJbOOH2QItMa6Jw7/d6TUCwhUU9id/Zm0Ac45K09H8qrWsjVuFtLx0IJW12SB7lqokLElY1cD5mAHJpJNOQnJjAMm7bY3oRAkQX2uXn+fpet7dGM4++vR5yKsm5/5IR2oTsXnMStgw/aGEm+DaxL8eFPpRrQDPaZuc1uppZdXxfBpAhkNrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /etKZFretao93xtShDFkqwHosREnJBewL6ugqWFGW55y+xbPXxE4C6+xq+o4Qm7y/nhuQfh2KynLad/JYXI4fBvbLb8i9bVKD16X+9qpxvDw4Iigt9bxCzFo7fFya95gPuRVVdySTcQr3pGY1fLYc79Nm6INH/E2dpFDSC02AgdD0QmZHGEfBxfoQldVKaXz49C6MZhLw3xQ2koFsMISA75nQi+DNTT1PcWRo1z3JEdvRam2ceRf6BFfCqLGphVNFEIFP6P/RJv472/7J7XuYpT4kNJcjOwraGcQeTGR6E0lH4cc7+o3KdKLLk5dQjD/GTJwVUJuGR/moh8evXAzLDfeSXaweDlSWPLcJTEj4wNrcQgTVjuMYS5oTagHisf1zHpWFGDR4Cm3H2JRAlId2A071ARO0rnQKX1/VNVtdBTTSkYowyBMU/I1OcmrTPKj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:04:04.1719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c38f819e-5c41-48da-c59b-08deff9dd2aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156
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

From: Mukul Joshi <mukul.joshi@amd.com>

On GFX 12.1, all SDMA engines are the same from HW perspective.
As a result, report all SDMA engines as regular/PCIe SDMA engines.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 586e640f13dce..1c1e7878a2a7b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1512,8 +1512,11 @@ void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
  */
 unsigned int kfd_get_num_sdma_engines(struct kfd_node *node)
 {
-	/* If XGMI is not supported, all SDMA engines are PCIe */
-	if (!node->adev->gmc.xgmi.supported)
+	/* If XGMI is not supported, all SDMA engines are PCIe.
+	 * Also, on GC 12.1, all SDMA engines are the same.
+	 */
+	if (!node->adev->gmc.xgmi.supported ||
+	    KFD_GC_VERSION(node->kfd) == IP_VERSION(12, 1, 0))
 		return node->adev->sdma.num_instances/(int)node->kfd->num_nodes;
 
 	return min(node->adev->sdma.num_instances/(int)node->kfd->num_nodes, 2);
-- 
2.55.0

