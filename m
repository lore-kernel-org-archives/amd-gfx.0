Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5547FD5B857
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6ADF10E5FD;
	Mon, 15 Dec 2025 16:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s9xlxn/z";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 264F310E55F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0fZMbda1JW/w881b0j902wtkOcKTXHBRN1s2oaP+/N+F8jZc/zjroFNOGcpDwu2eV4jhZgjlvhqaADssp8KQBcGcjimiS6PKvq7dzMNCXbQicDyd40eFsRBrYYW1pOTzUtSWVCE5cMCGixK+8P7UU4b/wE2jTBjvGbAgF1r3zxkvKqciNieSsnNDyAGNPtxNBl+074zkB+iW8c+xXmAhCHNhfivnxHKElUIw4PCU1EC/st8NkKX1Mg3iOsyo3W78JBmW9ZMLwozN79q7e/xkv/vs3ZOh2ojPwmZQidOr0QQj9GQbw5paXBboYCeQRL/J968ZUxgbIE/8+x9iMT/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liIypi8yxwY4RSZba47lqJKDrRdSHJqCrs9k2+Ql5nY=;
 b=UHLlDp3DEGaOs+IGLkPIEi2vgQIpsaS2LMc1/+I534v5qTE5xbrI8jkvs/PjV+/PTu3jjmb7j+n9DWf4Pd/2phXJdjwIjlRoGRbRXPW2SA5yql//kPV3MyNo7CrHRzs8HDLB0LDK3dOMxeTnMN2hHBrnKrNhfsPRF+hTz4ZL+EovGwXOMKHbbbrgpZbTqV+yaP/R1uSBOosMfoPPuRj77VUusZ/vrPYrqUK8PZIV/1uvYlfEGEvVKMAyjvWTH0CwAHVUiivF8URv2GDqYSoqYcF+l8EebgC7FAOdc2RcmeooCaCxokuz20ZpJdCgpv1IaPs8vCGxNYPe7Fr3JhzDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liIypi8yxwY4RSZba47lqJKDrRdSHJqCrs9k2+Ql5nY=;
 b=s9xlxn/zTLx6BIQ0lmKL76qPaymV81VEe/wpR330QkUPgjzIKHOIaJ7wJKz+60f2ht2aiuB0bse9+B8m5V6osEe5+EESd/5qfM/rK7pzVX/FfUeNtBwl1mK3X3cPKglQCugASkJfS4WSNCvGI6kAeMLVMWnN+O8BIVkPqU+9ehI=
Received: from DM6PR06CA0051.namprd06.prod.outlook.com (2603:10b6:5:54::28) by
 CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:57:11 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::d0) by DM6PR06CA0051.outlook.office365.com
 (2603:10b6:5:54::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 16:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 16:57:10 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 10:56:51 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v6 5/6] drm/amdgpu: Add helper to alloc GART entries
Date: Mon, 15 Dec 2025 11:56:29 -0500
Message-ID: <20251215165630.1172383-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215165630.1172383-1-Philip.Yang@amd.com>
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: 94309f5f-1ae4-4e26-15ad-08de3bfafcf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RLYjzPThRvV191sFaH8pGQjRnrwP3YM2QFvC+lxhc4GlINyRbBkBZqINY//0?=
 =?us-ascii?Q?iQqX4qH/hvUCeOHc/pm2o3Kc/tPsXu8DdhfG/krHL3rA+Uj8Dodl/xOjaXLO?=
 =?us-ascii?Q?7Sxs+xux1MScyFuXREh5cJyektmM0WZFLDbWCP2CLos6a4PbEVi9mgFQW2yY?=
 =?us-ascii?Q?nYXjzP4yD/yBDr4fLLeSmf2unxYPx7O1BHZzHTPLE881WpjluM6rkaoFgGWN?=
 =?us-ascii?Q?+fY8Yi0070ufNrg2MfBeuNZwec1d2uE4ltFgzegJOXxWBvTP+Jx5FkHHm+os?=
 =?us-ascii?Q?QqA8AFjxDABo7DX6oOiC9l98H7zwAEmAofFSDN2XBjrUUIj3dL/vM4aBHlZ8?=
 =?us-ascii?Q?zpjcaUCMvpHKYGW1BYLVBYuOO7+r9OWzgw8R6EbmJd0Ws4zQMqFLeY4QZG/n?=
 =?us-ascii?Q?vSynSC2bfvsJaNJfvYlXx0aW5DqTniKALZaM26KFPJEMgQf/AaAdATEO4qiT?=
 =?us-ascii?Q?OcfnaWJO1itLSobF/7XwhXSg3zz8Z5M2O/Z5NA3hxu8QB3QkWg5i3m0rkPep?=
 =?us-ascii?Q?Ynbnx2PurQfJ7PXESYyGez4newdz5fqbBkrBjNR1e0sZuJmMT555/YArEVml?=
 =?us-ascii?Q?TrV6pah4AWO17YqoOZedYqNGG3Wed9ssWQAJO0TOTQ5t/x8PyX2/Qlpu0ixr?=
 =?us-ascii?Q?tAGI4z9PA4LZD7AKJLOELZjvmoQr6sn+bgyNXaZpFbwNkRLhUsugLvE0GNOd?=
 =?us-ascii?Q?CEUHnm1/I09uyv80U5NmGkspo+TVU/sJ58utqMeyegbvZN3gcEG/uNu6xs/P?=
 =?us-ascii?Q?Faex3fpquYJoN/jPt6sENeNmUVgT4m2ljjyz9dqAwy1692JYuh7ggsqo/fAx?=
 =?us-ascii?Q?/8fsRfszYRd0onrg1cz88RpjnDqSqjXxMmqWrlgIOBT/otTZ41WFSvNtazKm?=
 =?us-ascii?Q?6O4UHCO5he9ELnX/eHVx+WgfcdVNRDYIn63LB18pZsV/bBNE2PPQ8hvC1+XW?=
 =?us-ascii?Q?Z3mrrwhuaQU8DsDLJHY9cg/+Is0WbVnu7mY857VHwX6jNm07jTCgmPiHcRzB?=
 =?us-ascii?Q?Emhov+X2WQvdqKwdKODP/EpicrrgMV5QEyzxT9I7e2MH+quXRutUEw0CEdoK?=
 =?us-ascii?Q?4ecxvSpMgrK5oxjbaRsf38PR0xh/1NddDdTN1WEmNq74kRQVVVWDYjSzZtUv?=
 =?us-ascii?Q?og06eDXVICFbotryWUe4ReYJNYkG5b4PS18rAqtVHDfWhD7KE2PoE6TJd6fG?=
 =?us-ascii?Q?ASRzgpds31W5nUP40EOJUsS0t4N8pY6yTQPSkh4rhPBhN9ExEuvR0Ph3x5S9?=
 =?us-ascii?Q?1wc6xMqRSrPgldnFCq6AbNwCRWGiMS3bRFnUtzuY7RaE/koFFXLmDZOvqc1H?=
 =?us-ascii?Q?2EtNTA+EZxLO7KdU6FB9MWmV9phmmslACfrpKq18TTOfOSGTwlh1eG45utVB?=
 =?us-ascii?Q?Nc31hwkCAzFkHMQt7WDInv/DTmPzTIW8Gjc4JPPG3+tgab55yJYv5haotITM?=
 =?us-ascii?Q?jL2J4Jrj0+QHuuj3KLLRP0nGahlNgUvdA5J3zLDunLbnmOc9Hn8t1pcWF7Xo?=
 =?us-ascii?Q?nSjCxnt6xQPv+sAYlZMYGuNSj0uxK0w5GGM5KXUbJIMLy1Ls53guoswHcaQU?=
 =?us-ascii?Q?Rk77s+2JETJgv56rLks=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:57:10.4238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94309f5f-1ae4-4e26-15ad-08de3bfafcf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702
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

Add helper amdgpu_gtt_mgr_alloc/free_entries, define GART_ENTRY_WITOUT_BO_COLOR
color for GART node not allocated with GTT bo, then amdgpu_gtt_mgr_recover skip
those mm_node.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 48 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  6 +++
 2 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 895c1e4c6747..285177070895 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -26,6 +26,8 @@
 
 #include "amdgpu.h"
 
+#define GART_ENTRY_WITOUT_BO_COLOR	1
+
 static inline struct amdgpu_gtt_mgr *
 to_gtt_mgr(struct ttm_resource_manager *man)
 {
@@ -180,6 +182,49 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
 	kfree(node);
 }
 
+/**
+ * amdgpu_gtt_mgr_alloc_entries - alloc GART entries without GTT bo
+ *
+ * @mgr: The GTT manager object
+ * @mm_node: The drm mm node to return the new allocation node information
+ * @num_pages: The number of pages for the new allocation
+ * @mode: The new allocation mode
+ *
+ * Helper to dynamic alloc GART entries to map memory not accociated with
+ * GTT BO, for example VRAM BO physical memory, remote physical memory.
+ */
+int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
+				 struct drm_mm_node *mm_node,
+				 u64 num_pages,
+				 enum drm_mm_insert_mode mode)
+{
+	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
+	int r;
+
+	spin_lock(&mgr->lock);
+	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
+					0, GART_ENTRY_WITOUT_BO_COLOR, 0,
+					adev->gmc.gart_size >> PAGE_SHIFT,
+					mode);
+	spin_unlock(&mgr->lock);
+	return r;
+}
+
+/**
+ * amdgpu_gtt_mgr_free_entries - free GART entries not accocaited with GTT bo
+ *
+ * @mgr: The GTT manager object
+ * @mm_node: The drm mm node to free
+ */
+void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
+				 struct drm_mm_node *mm_node)
+{
+	spin_lock(&mgr->lock);
+	if (drm_mm_node_allocated(mm_node))
+		drm_mm_remove_node(mm_node);
+	spin_unlock(&mgr->lock);
+}
+
 /**
  * amdgpu_gtt_mgr_recover - re-init gart
  *
@@ -196,6 +241,9 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
 	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
 	spin_lock(&mgr->lock);
 	drm_mm_for_each_node(mm_node, &mgr->mm) {
+		if (mm_node->color == GART_ENTRY_WITOUT_BO_COLOR)
+			continue;
+
 		node = container_of(mm_node, typeof(*node), mm_nodes[0]);
 		amdgpu_ttm_recover_gart(node->base.bo);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 72488124aa59..25640bed7dc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -141,6 +141,12 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
 void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
 
+int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
+				 struct drm_mm_node *node,
+				 u64 num_pages,
+				 enum drm_mm_insert_mode mode);
+void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
+				 struct drm_mm_node *mm_node);
 uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
 
 u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);
-- 
2.50.1

