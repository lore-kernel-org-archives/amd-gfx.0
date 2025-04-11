Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E295EC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D96310EC26;
	Fri, 11 Apr 2025 16:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QR64KMPP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C33F310EC26
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwgwbHIxNDW7HXBqJ3JOd6qmfM/S2mDRxaqZFoJC5+HBtEGMllS4zTWLSAHS9KCx+EEVNm9cPBUgQxQuphqi1IWBBOEEtyzOjqPvGuDhgGDmQf1paLoITDbO6eLltAXAlyWtYxUseVI/m+3q8kopBgRGxAVYNo+TKYD8R2u9BBdfzm4JEKzsxbbvbG28uVsyxMrIDTwOw8MLXBn1WhXhliFLlOleldiMN+ztGngYcwoUQcaf+PY571mj6kfeTKwaAIH77bpY5einvKHhQzAxoKxzoS2isrCIVIsmsqPBINmAc1YFlfUqSkR5h06+NWbGA7NIjQP84Oi/W1cn/WV6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTxIuljTKTFvrB0JBe26ro7WcpjF+uUOtcCSd7zwiXk=;
 b=XAnZsKruMNJljyOj3TOY77FduRZOZDSMys4uVCoRwN/MCEUltE9AJui6Mj0GqC2BXcaaRKWrNsxs4IK9ljSrKXfFbBNpgFAvu03ouSXDtje7XWr2gOyr9eDbaMP6SRqC1MWfY4bnUkHEnZX0AT+70WCd1ebrXciHKGMFvpDiHio61wO6gWfOLUIwUrwDjgTJwWUpyvrZDDhjfvxx8CNarokH/8ezmctZQYuBnTYgKKZ+G/MF5DIphXtNqxtoBkuL3yz4iDuGBPZ+XyE+evxhbRerEXMSBaUVAX6lSZQNqpcXqCohZVntyF638pxpvZfkNB2vcnoLxKmHdKUk2MBUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTxIuljTKTFvrB0JBe26ro7WcpjF+uUOtcCSd7zwiXk=;
 b=QR64KMPPBc+nMstPzzFQ0RwTRw22eBKQ0KqBXHgN7zWbD0xZ5/YhB2Kzp5vn4YzNni6M0SHajB6b50k4hF4u8AJNmm5Ja2gCG9cKvztpWl/slanFKzb+S9lmFMFOdvj9w9GsZ5ShBlOJ9LSNnRIOUG7hKuAd1KAhBbpozNgG3FA=
Received: from SJ0PR03CA0089.namprd03.prod.outlook.com (2603:10b6:a03:331::34)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 16:36:27 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::ff) by SJ0PR03CA0089.outlook.office365.com
 (2603:10b6:a03:331::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 16:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 16:36:26 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 11:36:23 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Jonathan Kim <jonathan.kim@amd.com>
CC: Shane Xiao <shane.xiao@amd.com>
Subject: [PATCH] drm/amdkfd: Add rec SDMA engines support with limited XGMI
Date: Sat, 12 Apr 2025 00:36:08 +0800
Message-ID: <20250411163608.682746-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c62ca1-3adf-469a-fb80-08dd7917012b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Swe1CWVXWqruIhegiJUUiJIKsMGJHD3HkQ+s+yjjUZlI/7R/+4jcVXEk8Lai?=
 =?us-ascii?Q?aVZW1viIQhMsq2OWoK7qF63Yx0kDEmszlGjXa/9ovjyoq3C4FFVLPuvL9nHn?=
 =?us-ascii?Q?g4wcBuWc1Xp21VFpThvXFcOnq72x9pny6rwS3nzXFoJrJwlLk02HlyYWmETI?=
 =?us-ascii?Q?GsMiSdOlH8ocj3OOSfMtIAlL4CDm4HI1kLWBEpwmbnH0OQZBwCIquEsxdH3u?=
 =?us-ascii?Q?Va9KlDCc09HUbAK0R/ernjsDrQme0Bn5ZypMQhEXjKJkgOBOFnOsnZxH0yzI?=
 =?us-ascii?Q?gJGRy3rVhVJmIFJFrDPvUFdi5d10VEGi47Rpt8NFVPRKcQasVuA+7ewFeUCO?=
 =?us-ascii?Q?XBhYPOPGEx+7wUMVL0koTIv40vvJTww1xFKSYR4J51p5ATmb1nN2aeE4IrDy?=
 =?us-ascii?Q?fimfNt7DF4ufCiMbdVfT1EhqIbHir0SfP6NG0g8mdgUpvhR2Uiim8Spr5qq6?=
 =?us-ascii?Q?3Q4MmNpHM1RR2sjsdKwMSme4MhysNyM9ma1grIH7VGLZSoqthT3w2LJaF0Ga?=
 =?us-ascii?Q?XYUIOAGLtRqqtjf5AO27Pv4VuqcojM8z0/boXc4uGXVtxMbAiCTd1PXM1h7H?=
 =?us-ascii?Q?6tLry/C2wX/Q+5E9R5ZRHQ8CCwvTju8z/AJbzGgwD0kks9duhLsejAb3eptX?=
 =?us-ascii?Q?/xXiBEKgMCxq8OXAKUy8U+j/yYM3XcrVSuh/ybeXDFJ6yWPD4itcio8XA79W?=
 =?us-ascii?Q?NIU7xW6Qoj6sCba8A6R/GMe0vXBAiFhAd4QRzYlzT3iVfmmcmydFSWIxjMzV?=
 =?us-ascii?Q?MoWsKCuuL90OUfjFqh2ROa5aXxzWpyy1uLX1g+oBGuSrAWSK4YdW8+2d4wzf?=
 =?us-ascii?Q?WRNQtgdMrpYjoBbBYHXjzDRfRWBxB+XPlSIdnyd94v1mc2l66Yj590ovn510?=
 =?us-ascii?Q?TuEk5UFfS+zG0fjqo6w+r5TLFX1tpnO/eCILEBX1+SOEwvzkVJxEOfZSh8iU?=
 =?us-ascii?Q?o24+zF4ke1KNLecQW3HyAEhIRe60jZovXx6Xaqdy60uErxo3vYqRcZNQPldS?=
 =?us-ascii?Q?vsxFmQlei2CIMbssMslnJd2BbLL4HJx/ThlOKL4LuopcpIdwJGi7LuM479Tf?=
 =?us-ascii?Q?IbgY2BYaQvFCockeY8B7APwQAUXP0Gj4Q65LFsw3sKLiRG9uLS4aTZHCY2uM?=
 =?us-ascii?Q?DMtJYBKKGWqv4oeG+TKx4v7lRld4UTv69Rzjo2/VhDMaISFgyFO39ZHF4nEj?=
 =?us-ascii?Q?Nh4MvUYxpiH5WFMS2wAa/XhzwSJ/rFMUl5miyfi5BmnfZDy3v/NUi8oxbkBq?=
 =?us-ascii?Q?1HsTv+1boySLUVhi7qF4J/wbKBhZMzd7ELM3PTUbRRgsTvGwlxEDajtPTYZY?=
 =?us-ascii?Q?PBf4C1ovnZkJ9pK4Prd8RcRElpbCg0kw5BhKz+7rpnx0N7njvRMXBDsUfxaa?=
 =?us-ascii?Q?PYNCA7n/oHBS6epP3PW4EJ5GNkPtWjUDJ/mhCsY0XRUwufq4UfI0VowuiUYm?=
 =?us-ascii?Q?X9bBon/Pf6A82Z4E9UB6oKN3a/yLju4iqodQB4UD8r2XuwDlhF7F2kDcvgxo?=
 =?us-ascii?Q?iRWy6uv3APuHmgGRWGA+1EsBpvETj+alaXYl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:36:26.5784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c62ca1-3adf-469a-fb80-08dd7917012b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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

This patch adds recommended SDMA engines with limited XGMI SDMA engines.
It will help improve overall performance for device to device copies
with this optimization.

v2: Update the formatting issues and data type

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 41 +++++++++++++----------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 9bbee484d57c..c4eb48fe1f4b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1267,34 +1267,41 @@ static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
 {
 	struct kfd_node *gpu = outbound_link->gpu;
 	struct amdgpu_device *adev = gpu->adev;
-	int num_xgmi_nodes = adev->gmc.xgmi.num_physical_nodes;
+	unsigned int num_xgmi_nodes = adev->gmc.xgmi.num_physical_nodes;
+	unsigned int num_xgmi_sdma_engines = kfd_get_num_xgmi_sdma_engines(gpu);
+	unsigned int num_sdma_engines = kfd_get_num_sdma_engines(gpu);
+	uint32_t sdma_eng_id_mask = (1 << num_sdma_engines) - 1;
+	uint32_t xgmi_sdma_eng_id_mask =
+			((1 << num_xgmi_sdma_engines) - 1) << num_sdma_engines;
+
 	bool support_rec_eng = !amdgpu_sriov_vf(adev) && to_dev->gpu &&
 		adev->aid_mask && num_xgmi_nodes && gpu->kfd->num_nodes == 1 &&
-		kfd_get_num_xgmi_sdma_engines(gpu) >= 14 &&
-		(!(adev->flags & AMD_IS_APU) && num_xgmi_nodes == 8);
+		num_xgmi_sdma_engines >= 6 && (!(adev->flags & AMD_IS_APU) &&
+		num_xgmi_nodes == 8);
 
 	if (support_rec_eng) {
 		int src_socket_id = adev->gmc.xgmi.physical_node_id;
 		int dst_socket_id = to_dev->gpu->adev->gmc.xgmi.physical_node_id;
+		unsigned int reshift = num_xgmi_sdma_engines == 6 ? 1 : 0;
 
 		outbound_link->rec_sdma_eng_id_mask =
-			1 << rec_sdma_eng_map[src_socket_id][dst_socket_id];
+				1 << (rec_sdma_eng_map[src_socket_id][dst_socket_id] >> reshift);
 		inbound_link->rec_sdma_eng_id_mask =
-			1 << rec_sdma_eng_map[dst_socket_id][src_socket_id];
-	} else {
-		int num_sdma_eng = kfd_get_num_sdma_engines(gpu);
-		int i, eng_offset = 0;
+				1 << (rec_sdma_eng_map[dst_socket_id][src_socket_id] >> reshift);
 
-		if (outbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
-		    kfd_get_num_xgmi_sdma_engines(gpu) && to_dev->gpu) {
-			eng_offset = num_sdma_eng;
-			num_sdma_eng = kfd_get_num_xgmi_sdma_engines(gpu);
-		}
+		/* If recommended engine is out of range, need to reset the mask */
+		if (outbound_link->rec_sdma_eng_id_mask & sdma_eng_id_mask)
+			outbound_link->rec_sdma_eng_id_mask = xgmi_sdma_eng_id_mask;
+		if (inbound_link->rec_sdma_eng_id_mask & sdma_eng_id_mask)
+			inbound_link->rec_sdma_eng_id_mask = xgmi_sdma_eng_id_mask;
 
-		for (i = 0; i < num_sdma_eng; i++) {
-			outbound_link->rec_sdma_eng_id_mask |= (1 << (i + eng_offset));
-			inbound_link->rec_sdma_eng_id_mask |= (1 << (i + eng_offset));
-		}
+	} else {
+		uint32_t engine_mask = (outbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
+				num_xgmi_sdma_engines && to_dev->gpu) ? xgmi_sdma_eng_id_mask :
+				sdma_eng_id_mask;
+
+		outbound_link->rec_sdma_eng_id_mask = engine_mask;
+		inbound_link->rec_sdma_eng_id_mask = engine_mask;
 	}
 }
 
-- 
2.25.1

