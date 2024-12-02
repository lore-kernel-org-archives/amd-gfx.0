Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2FBE69E95
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDAE10E86D;
	Mon,  2 Dec 2024 21:50:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZkNe4IVd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A296A10E86D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFt4TLZsWYMrKe3jB8YPrzsIF5+K4b7Uo2IvvScCttofvtP6IzwMItJCpU15DCw2GqP4d+S6GWRbQriBCwc0ZjzMKtR5BXmORSyxH620gM+iPZxXYInEtbYMIU26lr8gPeICBFRconaCK6V/njGpMQXpu6H3haMNWhjH/XaDnLXwSgdMsfKuD7XBSBSwcn5TwI9KdBBKm814IFeQpva//PdXbTnU52Ygc3FeeVnUsPJ1Mg5SO/QxEVFOH9twNzTT3nTUlAUYH2KmOjFlaXmvK7g34G5gEFCIlfGVIwHpszTvOG/PSeHnvg3GbG3JMUm1PPzD0BPRpeog4OFTNx1HXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0i6wZP4mDPWdTJSI+FAqXH2dN4IQNmGH/JO4mrYwes=;
 b=A5Pc658AvgoI5HODsR4kPDO2ZcNUiket1TRvW8RwosJJ1UxE5+1bv6eNBEoXTNzr9XggCYyCvRMLPxTCqDwtxvlpVyp07b+dFgGLmNieSm2QvBzeJHBudrsaqUIeYYB+QCqIIlS1DpheeefRDeY8uj+p5//nalnp1PQMsffQD3xP0o7urer3/c2UBh2/O6l49LEALUwcBMb7IfPAKedvJGGsqKA9Q3hGbeBcmmggCLt+V6lDlErRt6G/dl1SRsW4fCX46L2TRUZo7HaESw/yY5W4OP4xLilW3PwN3jfBYoY0042gnppgI5qSu62xrTHtL2VHfWBmtteMrfVEZMHVwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0i6wZP4mDPWdTJSI+FAqXH2dN4IQNmGH/JO4mrYwes=;
 b=ZkNe4IVdWCgd4nQj4cGcKvt82jVkeEfAfaH7rv6wWYp4FRZrANb/9ePpzYh2xuO4R5q301l7JBDzUA4pERgTsbc5JC+GTbij+ATuP30ZvFpM+s9bikkpP0aQU3K85fPD8TwRCMiJpvE6eNd+9woPMpIoerJVVO4Sd8n6k+Y8cDE=
Received: from MN2PR15CA0060.namprd15.prod.outlook.com (2603:10b6:208:237::29)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 21:50:14 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::db) by MN2PR15CA0060.outlook.office365.com
 (2603:10b6:208:237::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 21:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 21:50:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 15:50:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Harish Kasiviswanathan
 <harish.kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/11] drm/amd: update mtype flags for gfx 9.5.0
Date: Mon, 2 Dec 2024 16:49:46 -0500
Message-ID: <20241202214952.1125211-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202214952.1125211-1-alexander.deucher@amd.com>
References: <20241202214952.1125211-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c64b8c2-6b58-4d8a-0423-08dd131b4dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cXJQnV856tBrdnZhuVKU+WtHbWsP+OCr12ge6Y1Mn2/iaAvDTYpSDcOkWOy5?=
 =?us-ascii?Q?gDIiJSxEOTaXGz55cWZSNSaBOetvjaz0eu9ZD35b5125ruwDpM219x8wMdmK?=
 =?us-ascii?Q?WMS2Bv5ZeWjJ4ZosQjXqmLU90Irt9buSPt4OGy0q3ibSHiEDdicxjL7UeVqA?=
 =?us-ascii?Q?8atPyaKgLzC8GeO1YuvA3RF3b5SWCYvp3vKFmnDsHgNAV8ykMuKJydnPN0jh?=
 =?us-ascii?Q?EzbuMrhkb8zg7QMZx4jRzK7z2GEB5Rph7wGXi+EDckMBVQPvIyee2SSTbPNj?=
 =?us-ascii?Q?Zv02pDsre1G1yKjf+UXNL0OTswBpsjznvyMnUnoIhepSRP2iq7YxxanD5fCh?=
 =?us-ascii?Q?jNCQnBRRRriKMbwvQFlJDF1HxXSawXkWLn12l5ZTFy8BPXTTYpHqEUQl9vwJ?=
 =?us-ascii?Q?H6163jQyr71zuMBOFNNwIOkWBRHsDB8yGlYUfOotO52OpDLGR79mBIFjgOX9?=
 =?us-ascii?Q?u1/kJRVRhDlVDfIxPWyMAWNEWjNICCmRdz7Mm1mGGFCZ4dVem6W7remnwNRf?=
 =?us-ascii?Q?Tr57zvF5JnvZBKtFI39HEBamjd07Is3JngdwYKbBppBhmsUdLEV3I/ycZM+z?=
 =?us-ascii?Q?bUmkreqizT35ceY7Zb9pBC4q/jqv23MRSQBTJOx0r5ANt+vvhJVldsjO5698?=
 =?us-ascii?Q?/N4s8v4KAHZouBf6Xpl/ANqEeAKguWl36YnJJfQ9JI4C6tG4NCIj5DExNKT0?=
 =?us-ascii?Q?NsmvcpkzZvp/bxTXRyQd8g6ENR8Q7++lyNjjvpR/Wjsfmpl2gQhmpTHwYsAj?=
 =?us-ascii?Q?rBlGq+UbvV65n4yXuD0m/SPSnimyJG3IWBUufijgVTjIf7Pugqwaj5rklLP1?=
 =?us-ascii?Q?QuxnHo2uBO9o0JE1o/6ZL9riq9A+0V7SS098+u2e9Fd1L4rWL2xjFSnoT5mK?=
 =?us-ascii?Q?yEADur0OWTyZdspwsWHKrzov+AANk8geHzu2ckDieRiASmNx7rBQmjLl2mhH?=
 =?us-ascii?Q?5yS5gMhJnYdOkqOOWiY6VgpiBlB4SlJX6Tls5vSQnSTxNfLGttsY1iFxQdp0?=
 =?us-ascii?Q?6iKTdyXNt0dPZyiAbL6pAnNJcj2kYpcEPenSoQfh8A8b1cF1kwWWHPXib4Fe?=
 =?us-ascii?Q?VGdKHODjI/Uu+iKT1QJlqLKPGvjT/WrdADi2/loCT6SlYXd1F+Mx00FCOf/V?=
 =?us-ascii?Q?XFo5z2rtOX2a58zEDv5OLj+Ogpt6e/HiDDq9JkXtLMbJGKirVWJpYnfUAcBw?=
 =?us-ascii?Q?JOdE1vvLcHYhlO12fQphe9mwfsnIR4uQVomv6pTXrDf7pCX53wwnJqEh4S5i?=
 =?us-ascii?Q?XKyZJewHZrLjzTiWn2Qzm5duNiI5pqitq64KD6NlUqbFttC+bfrULVaAX8b4?=
 =?us-ascii?Q?2gOQg4c/tI6d/OOkFVQAFR5Loe20na88FrRiqwJ6mkRnZ7nhgaiGvDC5n942?=
 =?us-ascii?Q?h7QzM8pDP1U3ReUn92hKTaVWrV3nzdhbMouJdvSX2zGIM8ycCLTPE0cIohBa?=
 =?us-ascii?Q?qzImUXHTbn/zGDcZ8ZHEnwME5hBxMte0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:50:14.5761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c64b8c2-6b58-4d8a-0423-08dd131b4dc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
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

From: Alex Sierra <alex.sierra@amd.com>

Update mtype flags to meet gfx 9.5.0 requirements for remote GPU
memory and system memory.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |  8 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1f95a5b15ea2e..1ecba0de12b76 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1209,7 +1209,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		if (uncached) {
 			mtype = MTYPE_UC;
 		} else if (ext_coherent) {
-			if (adev->rev_id)
+			if (gc_ip_version == IP_VERSION(9, 5, 0) || adev->rev_id)
 				mtype = is_local ? MTYPE_CC : MTYPE_UC;
 			else
 				mtype = MTYPE_UC;
@@ -1219,10 +1219,10 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 			/* dGPU */
 			if (is_local)
 				mtype = mtype_local;
-			else if (is_vram)
-				mtype = MTYPE_NC;
-			else
+			else if (gc_ip_version < IP_VERSION(9, 5, 0) && !is_vram)
 				mtype = MTYPE_UC;
+			else
+				mtype = MTYPE_NC;
 		}
 
 		break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 315916bec6709..bd3e20d981e0c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1244,7 +1244,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	case IP_VERSION(9, 4, 4):
 	case IP_VERSION(9, 5, 0):
 		if (ext_coherent)
-			mtype_local = node->adev->rev_id ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_UC;
+			mtype_local = (gc_ip_version < IP_VERSION(9, 5, 0) && !node->adev->rev_id) ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_CC;
 		else
 			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
 				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
@@ -1259,9 +1260,13 @@ svm_range_get_pte_flags(struct kfd_node *node,
 			 */
 			else if (svm_nodes_in_same_hive(bo_node, node) && !ext_coherent)
 				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-			/* PCIe P2P or extended system scope coherence */
-			else
+			/* PCIe P2P on GPUs pre-9.5.0 */
+			else if (gc_ip_version < IP_VERSION(9, 5, 0) &&
+				 !svm_nodes_in_same_hive(bo_node, node))
 				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			/* Other remote memory */
+			else
+				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		/* system memory accessed by the APU */
 		} else if (node->adev->flags & AMD_IS_APU) {
 			/* On NUMA systems, locality is determined per-page
@@ -1273,7 +1278,10 @@ svm_range_get_pte_flags(struct kfd_node *node,
 				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		/* system memory accessed by the dGPU */
 		} else {
-			mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			if (gc_ip_version < IP_VERSION(9, 5, 0))
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			else
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
 		}
 		break;
 	case IP_VERSION(12, 0, 0):
-- 
2.47.0

