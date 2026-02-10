Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E756EA811C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A82410E581;
	Tue, 10 Feb 2026 13:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dU8FPrJs";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010048.outbound.protection.outlook.com
 [40.93.198.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD04610E581
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyudfChwwAitVxzBu3dlEbjSUFoCsUVvfy/zPSqAqBd+WCw1xQo1L/FcO/QTIERhJmpps+EFAQ0y5EFTRIuqaKaunCw34ie9euTUDs+GkF14pQ7kdVqCBQb7W4q2WyFnaKRsNprlxc9mpkcesj63qEknH6lm3Tk0SkyXP5qC1Zyb7+BN3X28rEKZkfCLmrPtTaAnd53noMhGjXZaJuzEhON9sAjYJeI04jxbZc4l6qFpcNKzBTWm8QDD+AoxJnP5ms7Vm9lRndqXgcEVjwWfw8x/3ZCc+7aVO00vx42giZJ2XksB/NsJI72LzrPhHH7OPftDW5kyQ51Kru4U0WeeVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNJya/FH2mpa/CyYkgOIoBnIiuSJHC0FqqkgERBLTaw=;
 b=lbAQ7tmbK10fZ3KuhVzInF4Ur/QBCACLU8LBvkPfAe8bqCK605B298BtNHes7g/46LMEH+nj5KN4rmhgXTPhG6gvM7HDggbUsIJeuNkFmy/HtFpoELVJlLrlr8ukK1S+itiHRPiZVpUUaIs4TgZqkfLdnYi6BW0s9vrnP6qe03Q2QXIDjlz89zXWhUORcYM8K1j9AVWKDp1i3jsbgYEwaaMuyKW8OUZ2E63PWFf6r4hcy2K2dITcW4+9Fnc03pz1DbNDbHRQ1mGmO0uokeKnRuvepYbSotscoc2z2/VuA6Nsk42tYrwP+1f+i0EL4M4XTCFbkbpCHCLZn6VtVvdYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNJya/FH2mpa/CyYkgOIoBnIiuSJHC0FqqkgERBLTaw=;
 b=dU8FPrJssP/NTwjcVCVwuoE+PwjVq32suKZ5n+zGJk2c+bGiob7TBrA71Y59ybr7ylkz4e1aDxNrLveXZLpqqzGvL+MzxoLXNrKU2Jn2Z4v1zArySVtqVktPA37v4YhtuveaFCbOkeQ8Pe0a6OhftQXUCg+Y97hFISuq8CBBH2o=
Received: from DM6PR01CA0027.prod.exchangelabs.com (2603:10b6:5:296::32) by
 SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.17; Tue, 10 Feb 2026 13:55:44 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::f9) by DM6PR01CA0027.outlook.office365.com
 (2603:10b6:5:296::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 13:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 13:55:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:55:43 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:55:43 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:55:35 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Carbones <Nicholas.Carbones@amd.com>, "Joshua
 Aberback" <joshua.aberback@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 10/18] Revert "drm/amd/display: Correct hubp GfxVersion
 verification"
Date: Tue, 10 Feb 2026 21:50:03 +0800
Message-ID: <20260210135353.848421-11-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d636fb-eb4b-429c-bcb5-08de68ac15d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I6gweD368GQp+FStVDJhiomGeDWpXP0lFgra5Phss0ww2i2Q1XxystBZt9du?=
 =?us-ascii?Q?dN6+qEx08Fa/7kbifNc5KKbpQVXaGZ0PwbaQLYXO9pR6IWLw4CqxLl+1e4sj?=
 =?us-ascii?Q?skeJnyGfxp2ix+OU/2aVA4JrZ6Jd1VQUeVZIc2tDOWbEQrCsVCGgg0h4US/0?=
 =?us-ascii?Q?SDzK8sddqsfnSMqhX33m04/yzDim+mvW3bEqbGL1Iu7AWLB+IDzSlmfK/4xw?=
 =?us-ascii?Q?QkxOitIhilPsEa3pqjaU+CmdGc7yARjjbOHcfOX5xTeifito0On0ETRh0mQE?=
 =?us-ascii?Q?+QtgB/PDnVB2g1nn4rsFMu1A0tBGVX97VtrnQ+pIJnBKx9ZqBLJrqBok6efl?=
 =?us-ascii?Q?/pzpPK0dBb5aeBZS2IKAnKZT+k8BIiL3ebXLOaHqJSKchx8Kd7ejAESIWE2V?=
 =?us-ascii?Q?dscMqpstz+a3/7pJNjmPb+sKyFU90+tkQMFr8jqQRjbLuYCnbbR0mmAuPFHi?=
 =?us-ascii?Q?BUDlASRgx1SngxMWsIIlsoDGOymFw11RTh7CYJ+lZcxWIhFD07wGh0+1//ic?=
 =?us-ascii?Q?iLfYySVu1evxRO3Ur0wnlK0dxqBKWFNKNzSNbcMoonZhbQW/97N2YbeE4G1E?=
 =?us-ascii?Q?AuxlmNFkfKKZGMY3bTWJKk63XQEwGKGnwhNfJgEt2edk9FKwzxdRLvd0gSGg?=
 =?us-ascii?Q?bfJcJAehFQ+AB6O8pOU0X2d2ax0I2IphxGaH4unPyaJhkESMXqVr6IR5MmLi?=
 =?us-ascii?Q?fboQDCwjJPxsIBtOPbnBm17cdHux+O1fqf5LzB2IGkZnGz3A8jAD4VVWcd9Q?=
 =?us-ascii?Q?51qSXnrd5yxnYmxn3mhamX8lJRp7o1jXV6KAmzQFYGUfTi4GAY/2qnY2xIq2?=
 =?us-ascii?Q?//PjknXjT98S37/m3Y/wcE5fjkhAXnyv/nyb9PIXsa1VU9X7BxlsI2Z54pOw?=
 =?us-ascii?Q?I1cB0+DzOfcttzLnmH2FmMHX1sqcFsf3hWvQh2UWPhrsdyHfo04D5AvNqYSs?=
 =?us-ascii?Q?Sv9hwycTxtW6HyXtO1DyJBE4jzU1L25OPkHJRaVLyW30Hof8fb8td18ezxl1?=
 =?us-ascii?Q?cqGWcgrwkJE6TH2R2HiU6ODRh++X1NzpA4ODC2JnXskOjaYiMx1qDBl2bJ0H?=
 =?us-ascii?Q?RoHSgVmw2f7+9Ea95AFMNAGEwj2/xfkfAGXgHcIGjOSkvc5DCmuv+rMDS9b2?=
 =?us-ascii?Q?C63fbgNbGOO7PCJMHc9K63264jVRMWb0ZPQTFVAuNCK3f2iTHZGlWFf5EbCi?=
 =?us-ascii?Q?5yytOIsOUgNJyWhatJGHkRGEeq/fTyLSw2atTf8Vacic4rEgkJjr73UoZ7t+?=
 =?us-ascii?Q?a7z5YftSE+fPdpnwFcqNnNoiZTHL8Kdl6Kz4zbgHx0R4GxxB/SaRbFPEQMeE?=
 =?us-ascii?Q?uAgUMnsKGGMTWEum6zqzWlka88vJSZXSEectGJTGgmZ0uOZ+Ggqzg7csOXT0?=
 =?us-ascii?Q?FKk8AowyR1+m91vSmaugHtjhvHViqr0xhkBlbymho4PrMags1aQTd86/aDcs?=
 =?us-ascii?Q?TTAasAH2kOOz8bSITxX37eI9bokZ97ecyLE3LZQHPmo1L7Zx4IiDMEeECHGx?=
 =?us-ascii?Q?Qw49WGCYjDniyz6LP0rCOym/P8DpwLEESKknI3VaM2IwfZi76OCdrkK3m4w5?=
 =?us-ascii?Q?HymlYBJhlJcz/5rKC5Kimtp67uh31wzTCA4H+AgVFLG/LYpozmJI+stcHf8e?=
 =?us-ascii?Q?gVXRJRZ9EGiXtzC6UC11+3KZZvtCBHQoE3g3Gkghkkl4u6vsyUkkkKNqe4rL?=
 =?us-ascii?Q?G8oyoQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I22nfOWrsUaQHQyZ6hrnkyMhRRy+xpctanIMkNYOUoS2c19AGROj/iZfj8By67zVITORbPk5ADoePRgopfa5YYCAWPc28jL5dZcFPz9anT6XbbGTNecrJZby2oZOBF7jAcMSv1Sd4EcKDzYkILbzTnQDJBH8aKUpdiFw1nBoniUan30PIA2zqHMRgp2wtqFh2ZHkl39jOlFqWCDntqw316D1p91j59XiWOmxXCh4yHs+R8cNj5vbRLZozkOa1PpnVceTEp+IvWsZ1PZNvcnQ4K8yjCjmP6btpgc6YQhRXJW8lj91PS/o3PdTeIK4Q7Pp0sQyrpVVczx2w0eL+e3RWtj1bW+RVhYLkHSyyDzlhlJ3H0uOBiZnGvWZPiCV89fnLS31kuirHjgwIVuVl1eL/4+5896nilzslQVaEkKcD8m4b+8PLMRJ3t+O9tCgDNqa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:55:44.2126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d636fb-eb4b-429c-bcb5-08de68ac15d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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

From: Nicholas Carbones <Nicholas.Carbones@amd.com>

This reverts commit 5ea2687f98a ("drm/amd/display: Correct hubp GfxVersion verification")

Reason for revert: Got blank screen issues while doing PNP

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Nicholas Carbones <Nicholas.Carbones@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    | 35 ++++++++-----------
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    | 28 +++++++--------
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 28 +++++++--------
 3 files changed, 39 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index 78c866688c61..e697d9bf1b44 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -145,26 +145,21 @@ void hubp1_program_tiling(
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
 
-	ASSERT(info->gfxversion == DcGfxVersion9 || info->gfxversion == DcGfxBase);
-
-	if (info->gfxversion == DcGfxVersion9) {
-		REG_UPDATE_6(DCSURF_ADDR_CONFIG,
-				NUM_PIPES, log_2(info->gfx9.num_pipes),
-				NUM_BANKS, log_2(info->gfx9.num_banks),
-				PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
-				NUM_SE, log_2(info->gfx9.num_shader_engines),
-				NUM_RB_PER_SE, log_2(info->gfx9.num_rb_per_se),
-				MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags));
-
-		REG_UPDATE_4(DCSURF_TILING_CONFIG,
-				SW_MODE, info->gfx9.swizzle,
-				META_LINEAR, info->gfx9.meta_linear,
-				RB_ALIGNED, info->gfx9.rb_aligned,
-				PIPE_ALIGNED, info->gfx9.pipe_aligned);
-	} else {
-		hubp1_clear_tiling(&hubp1->base);
-	}
-
+	ASSERT(info->gfxversion == DcGfxVersion9);
+
+	REG_UPDATE_6(DCSURF_ADDR_CONFIG,
+			NUM_PIPES, log_2(info->gfx9.num_pipes),
+			NUM_BANKS, log_2(info->gfx9.num_banks),
+			PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
+			NUM_SE, log_2(info->gfx9.num_shader_engines),
+			NUM_RB_PER_SE, log_2(info->gfx9.num_rb_per_se),
+			MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags));
+
+	REG_UPDATE_4(DCSURF_TILING_CONFIG,
+			SW_MODE, info->gfx9.swizzle,
+			META_LINEAR, info->gfx9.meta_linear,
+			RB_ALIGNED, info->gfx9.rb_aligned,
+			PIPE_ALIGNED, info->gfx9.pipe_aligned);
 }
 
 void hubp1_program_size(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index aaa8f8cf6c30..4715e60e812a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -313,22 +313,18 @@ static void hubp2_program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
-	ASSERT(info->gfxversion == DcGfxVersion9 || info->gfxversion == DcGfxBase);
-
-	if (info->gfxversion == DcGfxVersion9) {
-		REG_UPDATE_3(DCSURF_ADDR_CONFIG,
-				NUM_PIPES, log_2(info->gfx9.num_pipes),
-				PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
-				MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags));
-
-		REG_UPDATE_4(DCSURF_TILING_CONFIG,
-				SW_MODE, info->gfx9.swizzle,
-				META_LINEAR, 0,
-				RB_ALIGNED, 0,
-				PIPE_ALIGNED, 0);
-	} else {
-		hubp2_clear_tiling(&hubp2->base);
-	}
+	ASSERT(info->gfxversion == DcGfxVersion9);
+
+	REG_UPDATE_3(DCSURF_ADDR_CONFIG,
+			NUM_PIPES, log_2(info->gfx9.num_pipes),
+			PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
+			MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags));
+
+	REG_UPDATE_4(DCSURF_TILING_CONFIG,
+			SW_MODE, info->gfx9.swizzle,
+			META_LINEAR, 0,
+			RB_ALIGNED, 0,
+			PIPE_ALIGNED, 0);
 }
 
 void hubp2_program_size(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 2126830a5a9e..207c2f86b7d7 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -321,22 +321,18 @@ void hubp3_program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
-	ASSERT(info->gfxversion == DcGfxVersion9 || info->gfxversion == DcGfxBase);
-
-	if (info->gfxversion == DcGfxVersion9) {
-		REG_UPDATE_4(DCSURF_ADDR_CONFIG,
-			NUM_PIPES, log_2(info->gfx9.num_pipes),
-			PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
-			MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags),
-			NUM_PKRS, log_2(info->gfx9.num_pkrs));
-
-		REG_UPDATE_3(DCSURF_TILING_CONFIG,
-				SW_MODE, info->gfx9.swizzle,
-				META_LINEAR, info->gfx9.meta_linear,
-				PIPE_ALIGNED, info->gfx9.pipe_aligned);
-	} else {
-		hubp3_clear_tiling(&hubp2->base);
-	}
+	ASSERT(info->gfxversion == DcGfxVersion9);
+
+	REG_UPDATE_4(DCSURF_ADDR_CONFIG,
+		NUM_PIPES, log_2(info->gfx9.num_pipes),
+		PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
+		MAX_COMPRESSED_FRAGS, log_2(info->gfx9.max_compressed_frags),
+		NUM_PKRS, log_2(info->gfx9.num_pkrs));
+
+	REG_UPDATE_3(DCSURF_TILING_CONFIG,
+			SW_MODE, info->gfx9.swizzle,
+			META_LINEAR, info->gfx9.meta_linear,
+			PIPE_ALIGNED, info->gfx9.pipe_aligned);
 
 }
 
-- 
2.43.0

