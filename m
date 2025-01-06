Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDF2E7719B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 20:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A150110E9F9;
	Mon,  6 Jan 2025 20:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FfolKpoB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A78D010E9F9
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 20:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mx22/3sNf4EN104eN21ASZwjljAoO6xFZgp2iIva2c8/14n72hzBCLWEjxZD81xPCU69v+VsR68taV45sPorGjzqGKvSsugB4827vhdnbAEy283zCrTFfgv0/TrcGOGEm+WDhJpoOFShpHKIOzobTxB3SfiSFpTV8wk1MFuUG/Oe+uXwO4wwPFhnSO+JlOzZ9z3VeZlJ5myrHyYBdqWyatFhBb/4EmDWuWOBtUz6NPHHq0dOZxjc/Jj6heT8r7WKeC/VNVsmRPgAeSJg1okn3Tz+8bXqo6wATBz4YlrXYsqnWlip/6zd4cj4twYQEcHgoxGayfcwsRSvp4qvLo5AlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QudU/PnLAYkGH4C9+gJLC5DjFPSExIJnHLSBnrgEvo=;
 b=REtYdQW9TOqVX35W46w3agHpNButhBcgS1dhWprLPbmq9EdU5cSFk3qrVFjnOVSsK7HQNrgudu2u++2U/RIRNjd912rZFio6fZa5KJwhF/pxLVRX6gtkZUSYKFH8TbryqZ6ovs4dNgFV5N31y6o8Hp6yBkCegoeXBTqxCgSowUvux1VHZQ2yoFVOr1HCpnq+//tigRMn1sQT5mFG1gYQvK1dbdxjozYSyu8Xv1PPlt0TUFI7nlCcPDp1c2mxQs1RKe5vcel8Wh43FOinWLRON185rae4CLwr9BVGDofzYW1/ljrzzuMzVg4kbtNipxZNTN9DsWLA5OROBS9zPU7avA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QudU/PnLAYkGH4C9+gJLC5DjFPSExIJnHLSBnrgEvo=;
 b=FfolKpoBMkUp+BM4sK9U7sIvUK3xzawaeoisiRNNRBxdBpiYjAQ1SGifxDNCAsNcgBjz3nDQDDA7x8/OYkw3PgI/McApCM/wXkP44astFX/oio29YC4YQhWM5toub99mPmx8iRkExsl6J5K2woBlPaj2C5QFDCjzQEL4RX7Te84=
Received: from CH0PR08CA0014.namprd08.prod.outlook.com (2603:10b6:610:33::19)
 by IA1PR12MB9522.namprd12.prod.outlook.com (2603:10b6:208:594::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 20:33:30 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::e0) by CH0PR08CA0014.outlook.office365.com
 (2603:10b6:610:33::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 20:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 20:33:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 14:33:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/10] drm/amd/display/dc: enable oem i2c support for DCE 12.x
Date: Mon, 6 Jan 2025 15:33:07 -0500
Message-ID: <20250106203310.3349585-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106203310.3349585-1-alexander.deucher@amd.com>
References: <20250106203310.3349585-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA1PR12MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: be6598c1-d02f-44ad-1e61-08dd2e9161f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xmlBaSLcoRCrxmQ2Eh4tA3mKcWNZ1F4kxawjfaGzZSy89BbYjSSF0cyCF4O3?=
 =?us-ascii?Q?Ax+Vg77p8gTmoKw/yNBED2TcQV4dGFzKjhtsgnGblC5Eo3oh747ZJwTxv0TP?=
 =?us-ascii?Q?TupN0iZIRcj5NJ4xPlaal3ukHE1VhYQNn9AvM+x29gBZXLayA+gv6RkoN4vj?=
 =?us-ascii?Q?tP0vRbdFByySXsO7VK320R8ACyMsZ7JrPjDbkA3T029o7jGgwh76JYXJWvsV?=
 =?us-ascii?Q?YMWEacrTVzKHyxvSYAzFyMiahr//yylPqNILD4BfJ6OHmGuwbU2vZl/NOzfH?=
 =?us-ascii?Q?VdUYsRZ3De/FG6C4PvUVr+JSttgql+YMovadkHlyOzSavjcE4AmH6YgfFloO?=
 =?us-ascii?Q?UDl3BkWYRyS8JKK8QbKGdXcUMgvrJ7Ch1/MChF33voaWzcgWYjVGNoGRfzsx?=
 =?us-ascii?Q?5T9q4scccs/eKW+AzS5GZFKcMwr/7Qhl+fQMaFOmi0e4cbnGJfm1PbUOtJ0z?=
 =?us-ascii?Q?SsTWIzl0EjLCF/KnSGudT5g5CvaKlrGg90BOJ4/awxZkMsvt9w3XMM0OPFbe?=
 =?us-ascii?Q?Nr18VoNU6cDuLLnt/p/k+9yr2BRJNEhEsw0emg5eTlAGKokdV1CmPSa+5V/j?=
 =?us-ascii?Q?Jfu9y+ItEs78lxcgJmHUls4OOKL4i9IpAWpRFmbvsxNYBpuMDlRJDjODYUZj?=
 =?us-ascii?Q?RLAFea4a/IRbRAML138ekUssdJ+ovL0PJir1MJW5KYOraNiknNNNZhinX+Wu?=
 =?us-ascii?Q?pManf+KnpMBDuJmP8JenjdcN9ukRTosFG+/U7r2ZUATzXC+WiHY0CBuYIXYT?=
 =?us-ascii?Q?jby9I5pUPfruxDR8KD64yF+fw6onOFgOUkaJDUdzmEKeO0Bi5O3Gpl1KfEsU?=
 =?us-ascii?Q?2Kjmns02u5Vv6oGIna2sPZXF91eYXTSMxK8OY9YYxwm43+go9cBzK8h7bg86?=
 =?us-ascii?Q?0Eq1q8bEJZRVYbL17X3gTFhsT3lkeIjbNZ94wv6itivUscZVDmw8QOaqSg//?=
 =?us-ascii?Q?VPgd6j/mhwQAlQvTBLyO5422v8k2TKVodpRp7LJf7q3XtdYOTagSFtqNNmIx?=
 =?us-ascii?Q?gwAe5TMd4MRPFmgojyterInuy4afdcZ9CoSnM1j/VODSNaMRwgk4zCQ5SWsJ?=
 =?us-ascii?Q?XBA167w3pVQSXkk+Lt6VEZZWR5fzOJBnGFc4oYQ7FkWPA9fwoo/ZEvd8qaAC?=
 =?us-ascii?Q?3RPowBbp89rlQA9YbMT+04DC8Sw0nKNnBO7WVrldMRK9UAQhPyeU5Hm768jE?=
 =?us-ascii?Q?2I6Z1Q/rCEF40DwetUWOTtD8zU9hTDcf4ZDM67LHOBzCdKKNOv0KdpkL914t?=
 =?us-ascii?Q?CZf9z6Hs4k0CNqS8i+TpMkWCUcfCGT5MgrJBgL6/fmnZ7u3qqLlDZ/7eMO33?=
 =?us-ascii?Q?+oSuo/h2fuRCEyeBRXhZWyOL52NsvKkTZOdpERwog2bbBPUnycCCSa9FQkdn?=
 =?us-ascii?Q?yHWQg9vP3f0k+0R18kn0r7Mc80OZ3/g5s3FgQ3sys4eK990YX3VBuiGkgVDc?=
 =?us-ascii?Q?xgbRb66C5L7MWMaDm7Q+4n0e72W1iZaLIUmtR3nkGf1n7/xdd9dbNA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:33:30.4392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be6598c1-d02f-44ad-1e61-08dd2e9161f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9522
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

Use the value pulled from the vbios just like newer chips.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../dc/resource/dce120/dce120_resource.c        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index c63c596234333..eb1e158d34361 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -67,6 +67,7 @@
 #include "reg_helper.h"
 
 #include "dce100/dce100_resource.h"
+#include "link.h"
 
 #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
 	#define mmDP0_DP_DPHY_INTERNAL_CTRL		0x210f
@@ -659,6 +660,12 @@ static void dce120_resource_destruct(struct dce110_resource_pool *pool)
 
 	if (pool->base.dmcu != NULL)
 		dce_dmcu_destroy(&pool->base.dmcu);
+
+	if (pool->base.oem_device != NULL) {
+		struct dc *dc = pool->base.oem_device->ctx->dc;
+
+		dc->link_srv->destroy_ddc_service(&pool->base.oem_device);
+	}
 }
 
 static void read_dce_straps(
@@ -1054,6 +1061,7 @@ static bool dce120_resource_construct(
 	struct dc *dc,
 	struct dce110_resource_pool *pool)
 {
+	struct ddc_service_init_data ddc_init_data = {0};
 	unsigned int i;
 	int j;
 	struct dc_context *ctx = dc->ctx;
@@ -1257,6 +1265,15 @@ static bool dce120_resource_construct(
 
 	bw_calcs_data_update_from_pplib(dc);
 
+	if (dc->ctx->dc_bios->fw_info.oem_i2c_present) {
+		ddc_init_data.ctx = dc->ctx;
+		ddc_init_data.link = NULL;
+		ddc_init_data.id.id = dc->ctx->dc_bios->fw_info.oem_i2c_obj_id;
+		ddc_init_data.id.enum_id = 0;
+		ddc_init_data.id.type = OBJECT_TYPE_GENERIC;
+		pool->base.oem_device = dc->link_srv->create_ddc_service(&ddc_init_data);
+	}
+
 	return true;
 
 irqs_create_fail:
-- 
2.47.1

