Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFD3C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC9F10E544;
	Tue, 25 Feb 2025 06:46:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yjGPeIG5";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED6610E373
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CV/ixGAkQPx6COr6n170hSAMtrwtLmyCeJ3xAAUpTvGfvDmkt4qovW+1u7MJD58ybzwmOww9vEB4AJxPHK35gikErgKoRTWm4j+Q4skF/6y2rhtgWYtvINY5q55uYpdWGNsgsDSCdAXwv1flVri2J+ISvFyujTRRFeQUF58GZ7eWJDeQ+MQoilFkiitYCfoH40r+hgP3bWk2DEenZ6/gIs+5INykyzAIatiX+Q6sHteXDSgxO4M5/S0Dch3iqw+mrMuCoZR3b4bkPzeIENI28ef8d4MXQ6vFhSvNjs1zH3aMC7zEWh7g7jklF2WVHKH4KLjW2K1J5w6Rk2dbob6cFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZkitb9rOvC5xKTpgMjaxWZUWcP78vnqUHq4hKd7J4E=;
 b=Mc8SBoNfFyyJ/j4EtKOcWNuO6TkE0H8kZDL6Q3oB/gHkhgQ2NJ0veiLhKQAvq3Z8RoE12AF5+WaMqc0l4KBgbL4JlaEocEJtu919GvCITsDCbbpb1BK0wOkp8YwvnUIptwql8vubo7rM9gzFmaLIbB59OiSAIMzwSDjrWRzH6TmSGzLOLxovATf/YoMTJ/U59Sqg7A8UqCZfTgc54XoEj5Rg+7RFcsEz2DliSEaB3aGl57/jCh65NU7l7mHfbprSyNOqnEZ+7/QCG2bpwXFyelP9qyfqJM5ou+YvHTcdXkKal5qA2mfb/qr3XisLTzxCN1z88toKnXPPsFMq9zt0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZkitb9rOvC5xKTpgMjaxWZUWcP78vnqUHq4hKd7J4E=;
 b=yjGPeIG5kqJ6caP9Onh25qKA1kspiubFhT4OR7OThDoackdVKBoWwZZMraKVNktDCScQqJ3K6pWI1UhR0UMOgZ1VM90yzlHEpzpQVlv9L9vFOFFlwkNXEuuyzoXJLXOJlx64J4Jp+710p+XzKLh2JzIXKC09hfOpsoa9NstuZXw=
Received: from MW2PR2101CA0025.namprd21.prod.outlook.com (2603:10b6:302:1::38)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:45:55 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::46) by MW2PR2101CA0025.outlook.office365.com
 (2603:10b6:302:1::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.11 via Frontend Transport; Tue,
 25 Feb 2025 06:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:45:54 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:45:52 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Jonathan.Kim@amd.com>
Subject: [PATCH v3 1/4] drm/amdgpu: Move xgmi definitions to xgmi header
Date: Tue, 25 Feb 2025 12:15:33 +0530
Message-ID: <20250225064536.118278-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: dfdd78d0-b8ca-4cdb-e8ee-08dd55680da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nqNFiUlWicw8YrK5D2adMZRakxGJJBEkdYPypKF9f8fmBlLa3Ht0dD5mE0vS?=
 =?us-ascii?Q?SRaddhX0IMZQzX4DLDpAXHHvcy76CUzR2Rw3NmXFjI0p+08po+hhngS4LdCx?=
 =?us-ascii?Q?GSnFDzTcHb2IgOadRkpmuoU8knWtXpNpotdceDqnaYHj69tCb+y+F+60s/IM?=
 =?us-ascii?Q?BtPgizItyN0IF2ree7+hhtPFOWmkxnVhXtrTWeKnkONcfu+1HHhOR5MwF5UF?=
 =?us-ascii?Q?sRbruILS5GlKI6ERyQOR3YdMidMIIXV2hNH7ReVEAXSLp3afkudpf0H8nXmi?=
 =?us-ascii?Q?dXCBvjtTrt4Mwn61z/5PStcGI6KGtZpklrRp4ofnHrxRtrucMA+EWmVRS1Es?=
 =?us-ascii?Q?EvNOF+nJoaJEWHIvLn/BmOHF61a3+KyGgGRhYwG3UrsEA5019YEZpd3ZhukS?=
 =?us-ascii?Q?pC3c93MCLGLVGiTy17QIZAYWL5JOirR07SmZb2paLAw3OAA/9PwUt0lNWi7S?=
 =?us-ascii?Q?RnwVjWdW025xNjfR//EgQX5jNwXhXqQp2PpKmyAJRErGrC7CwNY+bfpJ0r0T?=
 =?us-ascii?Q?JRurn+IIpwKkAs7xPYPy8ENJiC1RTaDIVItAvEGAfDRzJdU2q2lKlTAYayOM?=
 =?us-ascii?Q?979DoMof1iX10QDLGot8Benr0wS738iki3ehzbrgrHfYUCIYwY0Zw83w2cuf?=
 =?us-ascii?Q?BbpMujnND7zZbQnH3tJnsLJ6u3GXL5kBFjtpUQqftm/aGnCfHT1Ypk70dERA?=
 =?us-ascii?Q?IPdr/QpmY0aOcovSWp6W1DXdJv49a6VGfCQOU5+amZEOM/j7ZxVDqSp2rCph?=
 =?us-ascii?Q?Vkafq6oBaf48U7FQ1/PKiLFjP9U7FG6ggi1NFtMF5ioWFX63r/qFDOtGQK0c?=
 =?us-ascii?Q?rjmOTyVQUa0IGLT4PzdP25QoVHPCGaTK17v466bHTP0/Pj4JpZxTlclPdZug?=
 =?us-ascii?Q?IMPXqhm6G9W4DKFzC3XqvZqfokUF/hY9rBGEg3iRppIZkQpg5YkVPNIPmFT8?=
 =?us-ascii?Q?5Tp8stj9bLB/1iq8ReCZOThiHcOte+RurfwgsJyR/Khd5cEZ/+cTVMYefCic?=
 =?us-ascii?Q?ULOaelC8pFHPtQz55QZZPF/4vDgy2C8rxgbcxjduPhNGACLrbiN0o0cAwWEu?=
 =?us-ascii?Q?F6SxSFXjQLKUDcFMWjMdMLWrE+j5p/vVNX3DgcqHEGRiDO+3kBPPPFAXKCmb?=
 =?us-ascii?Q?2whyRHHQ6ecrf9U9MfpTeoq9yUIe0nubdDuvbU3R+wBWoNRyRnhszZ8uiZN2?=
 =?us-ascii?Q?ep2Y0bfiS+OIPa7P54umGz6Lrn2Gbzvqyl28KPBovLQT1iAKDl//as9u6r+L?=
 =?us-ascii?Q?JWE9Dl91rNlRebMBmYbjscivR77aGWW1mAkNbqJhXc0wKw29KiglatK2T0uR?=
 =?us-ascii?Q?MGUuhnm6w8j0MX2MjYcIIsVv2NX0CsYCLTuiVKcEMj5iT+LOoiqd1AfJCEmG?=
 =?us-ascii?Q?VmOwaMGOZN3zVjl40sogsXT0na47Vqxx9UOU1mXlWjOw6K7Pui81UQZHsCoE?=
 =?us-ascii?Q?UVziBpc9A0R63vwlzYMPjYkGsv/lmlA8iH2XOH5rVawzG3WpnP7hpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:45:54.9049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdd78d0-b8ca-4cdb-e8ee-08dd55680da8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
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
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
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
index 49da137d42c9..bd1444cdfb40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1714,3 +1714,11 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
 
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
index 924da0bec509..1d4e822652a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -23,7 +23,6 @@
 #define __AMDGPU_XGMI_H__
 
 #include <drm/task_barrier.h>
-#include "amdgpu_psp.h"
 #include "amdgpu_ras.h"
 
 struct amdgpu_hive_info {
@@ -71,7 +70,29 @@ enum amdgpu_xgmi_bw_unit {
 	AMDGPU_XGMI_BW_UNIT_MBYTES
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
@@ -86,14 +107,8 @@ bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
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

