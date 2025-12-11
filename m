Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2FDD3E793
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 05:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E16E10E6E7;
	Thu, 11 Dec 2025 05:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qrGFWsNL";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48ADF10E298
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 05:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdsiF3lHGRsrWa2J9qvFC/n9dkW4j8InuGJCk8/PvKuR6ha0v3Jim6+qECJeKP+gS/IAUjGJtrPFw+OBOv/GQ51mNbAG3Z1rLXzsOmwUWqdnspyXi5tS7vXi4qtxTwDh9qlV9Edt69lPrdSdu4Ny2jL+qg9NALHbzzg6J4uUKgTX8AHrKMCXLBn168jOjhOsddvQtvlYW4+1YPUbPf7MV+2fMZnK2rFPp4xkQ2dWVp13W+R0uFPAfAEdgtsE0xxDBaJH3IM8XTNpbQzwJYQfps0rdDUsaY8k5hFFvl3JHe/GfaYDomTdfJDIBc5cSPP+LZs6YmvrC7gG6pSN9BMXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++SJegCPz9rwQG4e30OPmIpdmyTdSMDKASKptnpyjcE=;
 b=czsAuuuMCzBYwyCD5T6swOmJmPwDdv90lrmnRw/KyS3vRWw/L2r/F0nBlXpq/0S6v+KMZoBRxC/MQUHTrQ9lDBQq+DVn1xk8kVal61cR8TqkYjkCZ+lUk8HkLPDlthciVpDyhD/zSDroNIQyAIHsAuQFJAKjaSznJHlRkXM+HrmBXTA/++/SwE0WHWE+QXEdmkdxWvZk3OTlYSLdHG0nnjl4gudTk6xve7V5dZ2wrjz1hDIek7GoUeMfiH83LlJLZ/iDfD8re1RwqCK5wVHIIC6ntXGbuQ4IltdV5MLFF+dGrsoOlAeGayeVdKTqTngQA4kBouI6L3SjJ5ZxokuBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++SJegCPz9rwQG4e30OPmIpdmyTdSMDKASKptnpyjcE=;
 b=qrGFWsNLGGvSblhYCmXQepRix8uSPj8DPhfO85910Yj0o2x5tEzzHZMTF8B8hVQg7NIiDvBU1bqYDwrxoOs3746yi05q3J7PW9a/qMcrV4h+jsbyX2hd7PcmxJ74Cay74ve4lii8Ey+C6TRo0jG27QQjYDGiqF1S7FJuXcpcwKo=
Received: from BN9PR03CA0614.namprd03.prod.outlook.com (2603:10b6:408:106::19)
 by SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 05:16:15 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::ee) by BN9PR03CA0614.outlook.office365.com
 (2603:10b6:408:106::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Thu,
 11 Dec 2025 05:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 11 Dec 2025 05:16:15 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 23:16:14 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: fix pp_dpm_pcie wrong state issue for smu
 v13.0.0
Date: Thu, 11 Dec 2025 13:15:54 +0800
Message-ID: <20251211051555.652129-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211051555.652129-1-kevinyang.wang@amd.com>
References: <20251211051555.652129-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: edd29035-ee29-41a2-0556-08de387468a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0oKhO1An0Rj9AGsfgqhuO9/dKaHMDSNLQ3aM9elOaxCw2F3jS6M3zAMWIz1O?=
 =?us-ascii?Q?77EX2H57sgWgJkBeckV6opuxyD8byahsmuFaYabOv9LQ6TrdzNgRVkn5roLp?=
 =?us-ascii?Q?04wlNKi6ht4fCdGy8KOFmNuf/SBwxR4Vs/r60DuYE3VzXHAUZ0WCFEze3R3u?=
 =?us-ascii?Q?RZRgAntmNNdJ6+2l5sZ6IlvgMwmojVMqWaspmK5pCQhffb+PwcxI9cGZqQcG?=
 =?us-ascii?Q?4SuQrIJX5eix5jZcT3K1IkjhUqQJtddFUx8eyR3+XAqY2Dn5NZjZfh09DAhI?=
 =?us-ascii?Q?uWuCpLg/3jzsanP3y4Mh9A8BBV7DUQBN7vVO2ymvOZ9M+q+D2g8/wjalYSqr?=
 =?us-ascii?Q?rjWm6AumRiPhlpGA/m0mdOl1WFx1jxsLQyKg/ATYfH/P69WNk2JWTVC0gDHe?=
 =?us-ascii?Q?nsimMGt8TWHK1yGvJHKq/cmjd+XFzut2tXSeXeQT8C/W5MH9yjDMriYNcUYE?=
 =?us-ascii?Q?JjRtS8dfx8PxEch6QvowUeSFuer3vMmBAIX/KUQNvCEi05Po9xh3T3+H7vKJ?=
 =?us-ascii?Q?BVl+tk2X4XgO/W+t9moq+MMivlrPq0WzvjWuuXLgGfy0nnQARdAAHSncPOdY?=
 =?us-ascii?Q?TWY/Zr05x/M2j/NUS6nDpVPS1B65/A5Xi12dq+4QFNss5ok4+mzrK/EMq3lV?=
 =?us-ascii?Q?MQjqhZE3cFT4gIH2SKLzAGuzVHAhUiPG5VfAmJu7SlkolOXQVobRNEVOnSUg?=
 =?us-ascii?Q?cDrSdQAp/lKGWIJx+rsRFNIpD5lhkO8GSkxgX8A2/5cKwAcGOaacZ48VfSHR?=
 =?us-ascii?Q?QFSWiomYACRw/ttM3S5Z7u+PTVXQLoQEkeE7v4JZaMlP2TnxkAKXzyAigDvh?=
 =?us-ascii?Q?5pXSdU2CXQiLUxyjrxEnOCqS3qqmyRyNWbFM8Ss+X3ZN3bzAeJ96d44Ptzft?=
 =?us-ascii?Q?bPiD+y5hhHoKQPHRd8R6cwLzriOpfX1DTlIPZtvRuWWCmIE90tClmycRQ2MY?=
 =?us-ascii?Q?vK8XqNUhlQstb1SaXZdgpX3GK2otxKNPEPfTUrjHPDsWFddLTCkzqKkwDsH4?=
 =?us-ascii?Q?+BoWcAtbYcOdnW+7F+DKTZCnfdt4k5wltFcd3w2jb39Bi3SUpLb3FLVbTfaE?=
 =?us-ascii?Q?f1qJVMJknVvol5VpffN41Pg24KR9nS4VnebcNbtNMoWPA6URTaRk6Nf83Kku?=
 =?us-ascii?Q?HXlAw4B7mKBzX61ugRGp4ol9AXOhjfgQA0pGVN6aOwjxB8Zhd9rPPHo+Qod4?=
 =?us-ascii?Q?CPWSOhjKID5pNJcEcQaPuy9MBs1vO3PXVeOMJDPldPYbly5BmHjRJfa46iQn?=
 =?us-ascii?Q?S1HVwlFDV2ejni2kqltSoV7P/mKi0nhOS63vS8OiYXPWdizcpjWpwbNXTlNb?=
 =?us-ascii?Q?i2+pVe/atALHy6DPAlWAzCiXGYUrYWDyYr6EVAGs9wuW/0JRYUjwHPOcHZ2k?=
 =?us-ascii?Q?xIaSNc8LpbxRke92Z/jWhNy8McJkKe/yPpcVLBs/ZxRlQWlxvHzMRhsjz4Kq?=
 =?us-ascii?Q?NAdldrINzx+CIKuFZuu0DFmz78WSICVOjHlZdAJMj++sAuB/zqSFsqa/yDEq?=
 =?us-ascii?Q?+CATlrxPdGd7JbxkBhY2R3vcaDbO8xHGJomHxclKIxYouTiNWQt22S1TmbY5?=
 =?us-ascii?Q?nBuFtuq05njt6CjFN44=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 05:16:15.5961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd29035-ee29-41a2-0556-08de387468a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844
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

put wrong value into incorrect data into following function,
which caused it to fail to match the correct item on smu v13.0.0:
smu_cmn_print_pcie_levels()

Fixes: 5ab288d9e21e ("drm/amd/pm: Use common helper for smuv13.0.0 dpm")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index aee365bcdbff..faa577aebd89 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1255,8 +1255,10 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 			return ret;
 
 		pcie_table = &(dpm_context->dpm_tables.pcie_table);
-		return smu_cmn_print_pcie_levels(smu, pcie_table, gen_speed,
-						 lane_width, buf, offset);
+		return smu_cmn_print_pcie_levels(smu, pcie_table,
+						 SMU_DPM_PCIE_GEN_IDX(gen_speed),
+						 SMU_DPM_PCIE_WIDTH_IDX(lane_width),
+						 buf, offset);
 	case SMU_OD_SCLK:
 		if (!smu_v13_0_0_is_od_feature_supported(smu,
 							 PP_OD_FEATURE_GFXCLK_BIT))
-- 
2.34.1

