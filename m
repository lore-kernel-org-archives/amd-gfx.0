Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36984CCF9E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 07:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F6D10E2C3;
	Mon, 27 Oct 2025 07:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WQKtJpLC";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B9910E2C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 07:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlHDP2lRPGPQqy3LTSnhGwdjv0+MGIXdqV+Y8rUz13fBkg1CBGywgj76VTVMPPCz7uY+aBbvPqo4u6BW5UtGRP6/W5priYsn2r2VpsHP7gnmM3DVfJtIpIcPK2H3oyJTHn6Vvm5lOMgcNc9fJOydDjmgY/MF5an8GX3XCmQF5XxvI0RP2GS9s5085F7bQitwRyDY0s1CxAO1ZbVzgbPfzEFTFt5wJvKElvgxCjVzNH7/0rNWg9J6rK/geoarbXYxtDl6D5NxlPTmmCH3CwC6v2t/36E/EARN2f5ecA13WwCKd56GsEpCZt8n2yfMMpNsQv8mV95WK8Fdf0uXj9lp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs9+DkAYn+cYQdPwKcqSGZfTrxUtE269c0mVoD3FxnI=;
 b=U464sLIQQ3cyYU9UQNrxbbf6hjymByRS2NNoY1QRExq8gRgeGHGB1jMygTXhHCfl0Z2f9p/UMBRIJULLZ5j8EoeJyyQXWtkX3YqpOYJbbkgj7H4ZMNm2rwqNWM8QVac4AmVqDRDP6ixs4fChcrx6/cg6pXooYiKQMW31RjShuql3b8AzP+BG3RnBMfkH3ilA0S0MhW/oSgC093ttj+8bFUza8ABly16cFMBuvfnOIacNQZatri5xnM+6fgfxtVl71pTf/NLlToD4U6f2cJJmiSpy3um2Pk9eNUlbHIa9w24VL9BcTh1T103+P9dX0a/R3BM6WPDxPpY4kFP2etCCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs9+DkAYn+cYQdPwKcqSGZfTrxUtE269c0mVoD3FxnI=;
 b=WQKtJpLCDFlFrwCesNUZtCUasEUamA6N6kyMl/J9irf9YXN52Dd9TxqevJQ/JGOONyKqAsjC47jkhcMa7N46G7Qy1egWBo5pNALiTN4tf7kjWhRmNeeWFkAMHbAWDnaKq2jdDWRC3r3/zaUbZwVMPUqYWYsIG8qlIfz7I5tU7TQ=
Received: from CH0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:610:b3::32)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 07:28:12 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::cc) by CH0PR03CA0057.outlook.office365.com
 (2603:10b6:610:b3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Mon,
 27 Oct 2025 07:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 07:28:11 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Oct
 2025 00:28:08 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>,
 <lijo.lazar@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Fix incomplete null pointer issue for smu v13.0.6
Date: Mon, 27 Oct 2025 15:27:57 +0800
Message-ID: <20251027072757.1267995-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: b00981e4-f710-4f56-49f5-08de152a6280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oj3aCBGQtjFb0McOhpJn7LBf+pZFmTOa/cmPVkOn3snPaBIZeHoDyk5CEzHG?=
 =?us-ascii?Q?EWPK6+bcc0acSIGTCJnmUR3ZffCmRe62qxIQLy2/jHNuZo1RoZlLzj5Mt4AD?=
 =?us-ascii?Q?5y1rbt0U2Tj6tvPE5gKiPhl8yXRUzZirAGVmnKdLH6XKs5QwNtudIK6VCHG9?=
 =?us-ascii?Q?iCnXiEbl4gKICAzmXJv4pLc8EuBCZwYNLDP1gsArCzFs9QkoAwOPzlKy54IJ?=
 =?us-ascii?Q?+525YOdpUqNZf0LeGUBxUsMAmsgl+M/ybJcocHZ3w4/uLyc/RwnRDaIKnhxH?=
 =?us-ascii?Q?ycGlSGr0WuIuOq39X5cy4Z2MWRQJcEXtuHpR6plZblNDRvyt+iLZ+y7oWwHq?=
 =?us-ascii?Q?eM/0l+1zkDMboyfJJN5HiuQFXToNuWL+a9b9Bb/DHdRm28ffXsuka2iFwC8N?=
 =?us-ascii?Q?/yirRfJPUT2R8vToDc/qY7Ls79ppZhnJsNUXV2X+lW6rw2xOSmgnb9gpueX+?=
 =?us-ascii?Q?04kt8R+oIHRry/ZOtf/4Q8rjzVfc4hR5Y9EA6wC+3gP1aWYMvo3ZM+cIwydC?=
 =?us-ascii?Q?CFdLvoEy5A/vqPjqdXfO9SPXKAs6FSYr5fHsR1HEthmiE21ApiTXt1MrK9Sq?=
 =?us-ascii?Q?VdevZY+wHgNwP6WBx7t4wexigXvU5qyyCnXMkGFgNJRM0ieXymgLckemoPjA?=
 =?us-ascii?Q?r59QykN3tL8JkdyfMTNyRBGympRCU4jdu+u/kMJzwY+xd1TNzvCehBR7i3Is?=
 =?us-ascii?Q?GbwY/DNxwB/Xy36LVc2Od8mhMKN7tIZsgPe0WDWStcdP1jMGD/b7XR9UGeMO?=
 =?us-ascii?Q?u4646nBF19q9j6lMcu6lZ11TONoi9zT6bebwHkGxtYFukO5pdG/3xsLonyq7?=
 =?us-ascii?Q?H2DoiGvjpELogw2ONyn5teKoZplRbOfF4eePLagEgGxar1qXoNFclskzwWL0?=
 =?us-ascii?Q?vTI9EX7y75xVaO7VjIsCULnTS4NkYDkfQ2VSIPJ9Z+g9P31u/CwkDJZ4XhQP?=
 =?us-ascii?Q?Dokz0o8zzRTTOgBkdeUiAQ7964alBz1mG8luKTPnF3oP3plV3p36ZgpfCyYe?=
 =?us-ascii?Q?CZJOSxVIdUGjmyekY+CnG9EvyZZqOjVXGKmc32YbT/Ywyrnb6GzUjpID+iEP?=
 =?us-ascii?Q?jW1RbNDtaU7AF/gXFIrjkHzJIqHRcpiW2uX2k7q+kPw+sJ8gFPqDrY11c+3W?=
 =?us-ascii?Q?+Q2nVETSkh5Wpi97PWWZl7osaXfETxXs24V+SeroHXEeUTZmO00uecdBBvEd?=
 =?us-ascii?Q?oB7qHQ7SR+Dw0HslWS13NJuuQ9B1TqOqXw4DyvZsXJt/MnjfyTr33vtC+hkM?=
 =?us-ascii?Q?ZNEkZXtO56xPQOQaPLg1fNDNf77OjX3YInKEGCima8z5RcqEDU8ewBFoyOk8?=
 =?us-ascii?Q?Em9SPincc0UY8t4rQgV2meXxVu8XQ+dedA/BaXyPeO2RV9jBrM3XMxUJ7fJM?=
 =?us-ascii?Q?o1C7/JxB4BBT2aZZk48TjaVQa4mBGTeN5NVflsXDgr2lEjaZadL0t74tk8WG?=
 =?us-ascii?Q?RhoRnE1bKFVr6GpGjyLf65yS/YtvtlaOAp8wIuXb61JJLnwNY7v819FFza3U?=
 =?us-ascii?Q?OqR42pYy5oNbbHywB99FpbDdEL/W8MP05x48kTLFz2xntV0uxvLq58RM8GVN?=
 =?us-ascii?Q?LU62jYsRinYKaVGTI0k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 07:28:11.7773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b00981e4-f710-4f56-49f5-08de152a6280
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573
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

the smu v13.0.6 driver should handle return value of smu_v13_0_6_print_clks()
to avoid null pointer issue.

Fixes: 0354cd650daa ("drm/amd/pm: Avoid writing nulls into `pp_od_clk_voltage`")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 41 ++++++++++++++-----
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 39ae6701147c..22fe4d3508fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1514,9 +1514,14 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					      now, "mclk");
+		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					     now, "mclk");
+		if (ret < 0)
+			return ret;
+
+		size += ret;
 
+		break;
 	case SMU_SOCCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_SOCCLK,
 								&now);
@@ -1528,9 +1533,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					      now, "socclk");
+		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					     now, "socclk");
+		if (ret < 0)
+			return ret;
 
+		size += ret;
+		break;
 	case SMU_FCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_FCLK,
 								&now);
@@ -1542,9 +1551,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					      now, "fclk");
+		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					     now, "fclk");
+		if (ret < 0)
+			return ret;
 
+		size += ret;
+		break;
 	case SMU_VCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_VCLK,
 								&now);
@@ -1556,9 +1569,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					      now, "vclk");
+		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					     now, "vclk");
+		if (ret < 0)
+			return ret;
 
+		size += ret;
+		break;
 	case SMU_DCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_DCLK,
 							       &now);
@@ -1570,9 +1587,13 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
 
-		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					      now, "dclk");
+		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
+					     now, "dclk");
+		if (ret < 0)
+			return ret;
 
+		size += ret;
+		break;
 	default:
 		break;
 	}
-- 
2.34.1

