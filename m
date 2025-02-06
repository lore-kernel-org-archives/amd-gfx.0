Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D477EC02196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 13:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED8610E829;
	Thu,  6 Feb 2025 13:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GHi2DlKO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9462610E2FE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iauJF9yZe3ljoxe0yBg/deVHM3jXd9aBJMGGD/mjtuxgNw1+XzEG26j3B9H+CmIzoO1RX/nhB4lRQO6OqRcw28svnCjz9oN4KuYFBStdrCbm+iodriQRawHLgSZhiq+fVbwEqAP+oacv460XFgmOmVcEAdROSQpbzoq14H/6mz+l+FQQoAzmjirMp5+H3/blw/dxmNwHkSgbnfvEQEqfP89nfSco9wixUv7nuo1OYBUxWH8aFgUtvC1BSDIxeobJq6Qem9O0JKK0nnUPf0wuF4BicAydp1TedPNd2u6JgwzAI9PT/v764e1Usomc45F8GQjqiTbaFcxRK7NJpBzDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F36jJ0UhQSNCvlq2DB+1CZDNdUaVXL5Yua5Nouq/ESs=;
 b=rV9Q/L2Ot9zIh0UirDok7vYZxScDmhNsSvIAzOOckxKuYORMDkVGBTQH+bkU6FpMItyybVFlZ+R05rsaNI+LQVJTkjKjxxDBoWf0QGZtvAxtOGeoAG1lufG0JKl5aPjheEBrlNm7GqgSR511bumRf70Lo0HsGGYUpPzxNVvz4wudbqgbEZWEXjJGMnx1ZgDjwzMEpLiBxvtCRq2VL9RVH7PyYS3f2LEvp2dfW5jrUgflJtqZXyArhviSD4YvjuGk4lsLxZr9yRCElhNpkyZnADIAXtZXurhTAnC76LH/yllGnY05KtbnE6faqL0LLAIGRCSUD83H3gDgY5zGS5z7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F36jJ0UhQSNCvlq2DB+1CZDNdUaVXL5Yua5Nouq/ESs=;
 b=GHi2DlKOiHxsWgBqOSwH/JTV3SHZ2qM9fg9wNAx+CtICgp8kQQctBLN8lq8CNjAu/B2jdVt9UxJ87SpwT0H37E4RHXaK1SjLT3wC29IJup3oEvHxPG+l51rmuDotMrKUIdCBUh0o+nkYh6XTKTTC7lVCPiDfT/A4gc8Nz91X3zY=
Received: from BYAPR07CA0008.namprd07.prod.outlook.com (2603:10b6:a02:bc::21)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 13:13:16 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::8d) by BYAPR07CA0008.outlook.office365.com
 (2603:10b6:a02:bc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Thu,
 6 Feb 2025 13:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 13:13:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 07:13:13 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: <Hawking.Zhang@amd.com>, <Jonathan.Kim@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Move xgmi definitions to xgmi header
Date: Thu, 6 Feb 2025 18:42:55 +0530
Message-ID: <20250206131258.1970391-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d58595-1ceb-4d1b-b8cc-08dd46b004b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NCDscKJz1bFohvd5e3DDCvuJA7q82qcdxSHzNNT9p1exQV4eKnowptt8Z2Vm?=
 =?us-ascii?Q?AB7IeslF32oIlD/q9XIuKmloRz7EKgg3GHbJWC2RBA6Fo1NyxYDskK3uVGzK?=
 =?us-ascii?Q?CIBtqc4HwiqERmYPCjRuajLzxuJNV5LNfN5dGGx3TplrAuvV/ThqFJ0flFfj?=
 =?us-ascii?Q?EsHToTuFshGBA3HTvK02/drP4/g8BZ+x4Oo0U8xP6kgQgm9AW/gK/nPUw//r?=
 =?us-ascii?Q?b4p9mOYH/yfUpUOz9wR4M+wwoNro0wuuS5q81tHJVxrqq08TCIpiQfzFfXdt?=
 =?us-ascii?Q?tqRZFHAhkcjsE/CTvZtcRxA1EvoQuNkCEPXN4YPqkShmpSYfpGoc1DEh9l/K?=
 =?us-ascii?Q?Q07HYwg0Apz5vZi0ShGR8KdbYKGddJPS57lkXHvQUE9BdfbjEZhS8PuYhzxh?=
 =?us-ascii?Q?KfrGN0di0Qs4GsePIjWmi9BA2spDi+E/feEUjnBPvsFYmJICvCGheAOkitUN?=
 =?us-ascii?Q?ihTjZCRgccz9ZPpx+4L9w46PY4jZIJ+BbYo9koyRZwXS5TnDW4onbQNE3hHF?=
 =?us-ascii?Q?UKRJ81bluQWtkVso65q4k+0j3r/8xA3sJQBvSksKOFlAknkYZVgw1rWSH4b0?=
 =?us-ascii?Q?mx25evSB+HjwJRydwc29BhjafT9+d6XkZmOzhCq2+AQO6AhGrLbNPxS//1Sv?=
 =?us-ascii?Q?AiArU2iRp6tv7m2+M8EbS2FJqe7pXEPlSAaeVdm/m0/ge9zW/bbjg62bUZEY?=
 =?us-ascii?Q?NyBThYbb7b9ApVZRRQxccYmr1g/tPcYRtYiEcIZf0bnpsurMyKNgye6N4mbq?=
 =?us-ascii?Q?m7CfnufK0eDz1r0Su4EMNiHbJh6qjdm/LLG7RfCghjsm2Gw17NQOTmhnsDfK?=
 =?us-ascii?Q?MtZhRrZyZpD8UBZxFL7TUhD0XPfZ0wWuGtJmlOVkdZ+BkSNohogsXn1UUG88?=
 =?us-ascii?Q?5yk3VXhVJCoO55pm8eIt6D701Bp7YMO/jv2lcmwdszWWb6wkHSBp0JR/bQhG?=
 =?us-ascii?Q?MQ7t2kiJXOSf3uGckl+HelBXDvfrO9nx/k5zcb0TS6HdghhENHHipfHqMN5R?=
 =?us-ascii?Q?jqAQM/fF4hJn0yMqu9Qa4zoRnVXem/eYKPZogeWjAlNrCCiCmY7i6kC0pmZg?=
 =?us-ascii?Q?0h4q5jBR8DdTDcOEgkcmyuN2Z/NLCHnsUhEBLKA6jASip+RtLqSMElIoDaoj?=
 =?us-ascii?Q?JH/0cU+Tct+HpVfpD10YmXSXaloI/pOTUuwrui/TdOHV9HmH5MdeGVNMGPUN?=
 =?us-ascii?Q?OOcMvLgBhgoZbao/NntMRZX26IZ7cZ+DnhBAXzhrCHevPElquoP8MRPOq8Ae?=
 =?us-ascii?Q?ceNGQn92AkCJyDxw7f7hD9LqMq05AkXSqlsPx783TglIcNMbM0MDOj6NilCV?=
 =?us-ascii?Q?kBvhS6a8frRV7p/eeCbJeS0Xr5HsCiHSI94REnpOLLdr0kEOkrAPiamX68yC?=
 =?us-ascii?Q?RjG0lHMyoGEwb1Dx0C0aOmE3HizFbUk1xkqDt7oI8Td6XzINLhHHszMQNqdd?=
 =?us-ascii?Q?PR2/r5Je5X2UIhjzwRkje1rdpfwZZffZxrY71QHGUJ15/u+y4K1ewQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:13:16.1991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d58595-1ceb-4d1b-b8cc-08dd46b004b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
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

Move definitions related to xgmi to amdgpu_xgmi header

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  | 23 +---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 35 +++++++++++++++++-------
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 459a30fe239f..bd7fc123b8f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 
 #include "amdgpu_irq.h"
+#include "amdgpu_xgmi.h"
 #include "amdgpu_ras.h"
 
 /* VA hole for 48bit addresses on Vega10 */
@@ -174,28 +175,6 @@ struct amdgpu_gmc_funcs {
 	bool (*need_reset_on_init)(struct amdgpu_device *adev);
 };
 
-struct amdgpu_xgmi_ras {
-	struct amdgpu_ras_block_object ras_block;
-};
-
-struct amdgpu_xgmi {
-	/* from psp */
-	u64 node_id;
-	u64 hive_id;
-	/* fixed per family */
-	u64 node_segment_size;
-	/* physical node (0-3) */
-	unsigned physical_node_id;
-	/* number of nodes (0-4) */
-	unsigned num_physical_nodes;
-	/* gpu list in the same hive */
-	struct list_head head;
-	bool supported;
-	struct ras_common_if *ras_if;
-	bool connected_to_cpu;
-	struct amdgpu_xgmi_ras *ras;
-};
-
 struct amdgpu_mem_partition_info {
 	union {
 		struct {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 74b4349e345a..03d909c7b14b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1671,3 +1671,11 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
 
 	return r;
 }
+
+bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
+			   struct amdgpu_device *bo_adev)
+{
+	return (amdgpu_use_xgmi_p2p && adev != bo_adev &&
+		adev->gmc.xgmi.hive_id &&
+		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index d1282b4c6348..044c4f6be44a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -23,7 +23,6 @@
 #define __AMDGPU_XGMI_H__
 
 #include <drm/task_barrier.h>
-#include "amdgpu_psp.h"
 #include "amdgpu_ras.h"
 
 struct amdgpu_hive_info {
@@ -55,7 +54,29 @@ struct amdgpu_pcs_ras_field {
 	uint32_t pcs_err_shift;
 };
 
-extern struct amdgpu_xgmi_ras  xgmi_ras;
+struct amdgpu_xgmi_ras {
+	struct amdgpu_ras_block_object ras_block;
+};
+extern struct amdgpu_xgmi_ras xgmi_ras;
+
+struct amdgpu_xgmi {
+	/* from psp */
+	u64 node_id;
+	u64 hive_id;
+	/* fixed per family */
+	u64 node_segment_size;
+	/* physical node (0-3) */
+	unsigned physical_node_id;
+	/* number of nodes (0-4) */
+	unsigned num_physical_nodes;
+	/* gpu list in the same hive */
+	struct list_head head;
+	bool supported;
+	struct ras_common_if *ras_if;
+	bool connected_to_cpu;
+	struct amdgpu_xgmi_ras *ras;
+};
+
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
 void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
@@ -70,14 +91,8 @@ bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
 					struct amdgpu_device *peer_adev);
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 					   uint64_t addr);
-static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
-		struct amdgpu_device *bo_adev)
-{
-	return (amdgpu_use_xgmi_p2p &&
-		adev != bo_adev &&
-		adev->gmc.xgmi.hive_id &&
-		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
-}
+bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
+			   struct amdgpu_device *bo_adev);
 int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev);
 
-- 
2.25.1

