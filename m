Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB17C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389A010E8C1;
	Thu, 13 Mar 2025 14:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GIjMGfIt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A07010E8C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uo2OezcSqmB9KQS4jBNd1loe/I8OUg7tg46fN/J+Y9eSJj2t17sn5aCMizpvqaK2YDqudCpbudfrpf4dzvwJ0R9LGK9c3ByFh8l7fMLw+ibhRkrOPl6JQhFtF48CnG9lvkSe4HR9ZWLj/cNrniQfVUrP7FdprcPhaW8ziONP0Q4EOP1BhlmdY8Rmqxnv973V1tCsxkSNTJQPFCDs3KY/ri6D3L5k73EsgfIgIx5FHEnE4LOjUi3RqgTixpJYcutNSq/n1qpKG6+W9zgkjWPH6MJQOcWBeJavi0C2Gp5YhQi/rPJoAdXbi3NMlFfS3/dtQw9iVu2VDr7y+dthbo5gPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX4tFpYhVZCP+mzspCJDly5vhKM/YINwNWl83/cP9hI=;
 b=PO34eRQXAS51zsZJJ5ZxdVk/CMqZGWk6dipi0g2FzjjRdQuXBAm2WQBbTH2kq0FXCB6u+QhKbE+Z9AA/g50aJrcdocwdpOTOa5vrO/m1PLu3QixoHyAkWVeCpLRcNxtPNxfW90Ib0SjEmHJjQ4+SRaIVG4vXprQRWTHgWAyQwroOpM3Tl1XnzHkngses/YMU9wtR8SIXSZJ2x8U7pc01Fl8wBza/jS3cJGIRFGPuc5Q4e44DeV432alNKFHtPECNHqDWAO5XVf2b24wLPfAEdA2X8BG39LDOekDx4YpHzAkBJVydEpZ9/721cSWWZobeUatklReAT8SIRvM99tVRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX4tFpYhVZCP+mzspCJDly5vhKM/YINwNWl83/cP9hI=;
 b=GIjMGfItZKDv5MdpgalGgNMXW65wFynLqWs1T18KojSimLQAFch3NSjvQ3tLdL64VRAa7KdJFppe670FV9HBBacEwZXDKHazOgM1oD9VUgdEv4EzoByo017ViJUwaohVVNDYFyaW4LS5Uc51MsnG12K+uNMmvJ/on2+44mEiqdI=
Received: from BL1PR13CA0337.namprd13.prod.outlook.com (2603:10b6:208:2c6::12)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 14:41:55 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::b1) by BL1PR13CA0337.outlook.office365.com
 (2603:10b6:208:2c6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Thu,
 13 Mar 2025 14:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 14:41:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 09:41:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 04/11] drm/amdgpu/mes: centralize gfx_hqd mask management
Date: Thu, 13 Mar 2025 10:41:29 -0400
Message-ID: <20250313144136.1117072-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313144136.1117072-1-alexander.deucher@amd.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|MW6PR12MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 171f2162-3e65-4c78-2091-08dd623d33a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dSC7bPEbtE+vgl56kOuYZ3LxY6Hm0floUUsHV9KdYS+0rroH8lUx7YKbYjXw?=
 =?us-ascii?Q?+SnPPPjgdyGXFpJuAhq0LlV43oqZcTMOPr4H2pAJuWW986Bc429LMwJUzOOy?=
 =?us-ascii?Q?EJw9A2up7zNisIvQ9Yih50Lq+n79/75BkroYg6MeH7IluOJXv/DnNRF/VDdM?=
 =?us-ascii?Q?x59h7H7aAxpLguLArxKLcptFxtSns0yrBR0hXct85O40iHx4neahZilxV/ZB?=
 =?us-ascii?Q?E01pS6xFfK+eQ1ZL3LM9vkKHUvYhozPSZBk6FyKQE9PcjBaAL+X7J5+1778G?=
 =?us-ascii?Q?SCu1+fwfjiB9G0m6NN0q1P01VQJZoPrz9fno+NtkUxzEok9PLFLXw8yltfgL?=
 =?us-ascii?Q?xUFTscWp7Lr0KiMXNAoJdpXOCh2thL/BCDm59wM0BkVe1W6dcpWkDjqWE7J/?=
 =?us-ascii?Q?v133uWnl3Kr9RNvRPaAyxVtL2SnY06zjxdDcVvLb7cuEIthoNQGKiwu4X1+x?=
 =?us-ascii?Q?dtBsd/o3lFvxjWme97PRpyHtZ8aTYNXc73RYMrjUlnQomKxu0LP24SId+VmC?=
 =?us-ascii?Q?QIFLsNPKFErxUUS+d++VDZqnpFGTZQTRT1N+1voRKv/ATMIuZBDzs/fKxxus?=
 =?us-ascii?Q?5F+P/cP1/KHSuR87koPTvYC+3ra8EDghUFLeMFNyz3Xyehp+lyz+VSVobvX4?=
 =?us-ascii?Q?WS4C7bBlpcDzSNwWtZKo09kwH6YuSrfKvhcMf2eRvXrc2ZDsETYQ+spqRF8S?=
 =?us-ascii?Q?/3/uPO0ZRqbyT8bXIaol5g/8OLlPewDqoBew3xEXf6TXiaSWhxKsUuYterKd?=
 =?us-ascii?Q?0aDFJWrr60tDzW5xU3WNkc10Oh5j5o0+wtBdLv1Z8IeT1LT8lME7nMx8a9mO?=
 =?us-ascii?Q?cLfYacmk7ReVlaZ2FhpON34QbabOdXuZwoU3bLbuPP9IsljF/Udw47TePOwM?=
 =?us-ascii?Q?qLYi9kN3DcfgGR4sRZfIpy8lw+jqkLSpjqtY/air64ZU1Xz/xTfvdvDUq8bk?=
 =?us-ascii?Q?KM+USvY7BUSCFIvjQ1AfJl9sY7LmTlSuxC/1YfS2EYkwGH3PpPmuDyQvNzdA?=
 =?us-ascii?Q?M/ju/bOXr6mjGv/zKxe2yDNJEQim+u8md10dX8ffnYUpsvJZQ6hjU1Yabhkj?=
 =?us-ascii?Q?bwnjr5Bv0X026LmBmaSkPBiKFpspzM0EgTxM5HCS9bpzKBSLKe9N0ZA+EiQ0?=
 =?us-ascii?Q?URe5LXBi66Kc+C6h9b76pT74EOF6XrKXCHWZqaph08PJGG7V9XefFLvfg1rb?=
 =?us-ascii?Q?ghhZ/MlwKCbwTc4YYF95KwO4OLobarwZotvqzYENKPeY2KbgRqpNWYZ9N30v?=
 =?us-ascii?Q?b4L1DTRx2ITr2MRejfO9wZuu+d37XlpVv3BHWCZXnzxoVhc2e1jaH+9rm6Oa?=
 =?us-ascii?Q?5LgNQmrtRsa5yjnL53ZuIj5eSVC8HSLSeWMkKq2Ddmf7ud2b8Xwu+Z4eomOX?=
 =?us-ascii?Q?796W37M+k93lz3Pv2oNbdzkcLUOzI6aRqHHmw5/ShCmNGwyLr6JwhjvhtLy2?=
 =?us-ascii?Q?7Tf8cn53hd567TMxFOpsMQdn8QP2pNfRAy2Na7EbbMxoMZ2q9L3kLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:41:55.4799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 171f2162-3e65-4c78-2091-08dd623d33a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072
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

Move it to amdgpu_mes to align with the compute and
sdma hqd masks. No functional change.

v2: rebase on new changes

Reviewed-by: Sunil Khatri<sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 16 +++-------------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 15 +++------------
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 6f5e272d7ded3..5abc1ca0fee98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -108,6 +108,28 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
 	adev->mes.vmid_mask_gfxhub = 0xffffff00;
 
+	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
+		/* use only 1st ME pipe */
+		if (i >= adev->gfx.me.num_pipe_per_me)
+			continue;
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
+		    IP_VERSION(12, 0, 0))
+			/*
+			 * GFX V12 has only one GFX pipe, but 8 queues in it.
+			 * GFX pipe 0 queue 0 is being used by Kernel queue.
+			 * Set GFX pipe 0 queue 1-7 for MES scheduling
+			 * mask = 1111 1110b
+			 */
+			adev->mes.gfx_hqd_mask[i] = 0xFE;
+		else
+			/*
+			 * GFX pipe 0 queue 0 is being used by Kernel queue.
+			 * Set GFX pipe 0 queue 1 for MES scheduling
+			 * mask = 10b
+			 */
+			adev->mes.gfx_hqd_mask[i] = 0x2;
+	}
+
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		/* use only 1st MEC pipes */
 		if (i >= adev->gfx.mec.num_pipe_per_mec)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a569d09a1a748..39b45d8b5f049 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -669,18 +669,6 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__MISC, api_status));
 }
 
-static void mes_v11_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1 for MES scheduling
-	 * mask = 10b
-	 * GFX pipe 1 can't be used for MES due to HW limitation.
-	 */
-	pkt->gfx_hqd_mask[0] = 0x2;
-	pkt->gfx_hqd_mask[1] = 0;
-}
-
 static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 {
 	int i;
@@ -705,7 +693,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
 			mes->compute_hqd_mask[i];
 
-	mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+	for (i = 0; i < MAX_GFX_PIPES; i++)
+		mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+			mes->gfx_hqd_mask[i];
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 96336652d14c5..519f054bec60d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -694,17 +694,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
-static void mes_v12_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
-{
-	/*
-	 * GFX V12 has only one GFX pipe, but 8 queues in it.
-	 * GFX pipe 0 queue 0 is being used by Kernel queue.
-	 * Set GFX pipe 0 queue 1-7 for MES scheduling
-	 * mask = 1111 1110b
-	 */
-	pkt->gfx_hqd_mask[0] = 0xFE;
-}
-
 static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 {
 	int i;
@@ -727,7 +716,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 			mes_set_hw_res_pkt.compute_hqd_mask[i] =
 				mes->compute_hqd_mask[i];
 
-		mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
+		for (i = 0; i < MAX_GFX_PIPES; i++)
+			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+				mes->gfx_hqd_mask[i];
 
 		for (i = 0; i < MAX_SDMA_PIPES; i++)
 			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
-- 
2.48.1

