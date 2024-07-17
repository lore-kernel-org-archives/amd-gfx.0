Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D19FC3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A9B10E36D;
	Wed, 17 Jul 2024 19:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RrC9nOR6";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4038310E37B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQqjIzidstiOcozu6lufe8wp5vdaUY/SvGDGny4lK5wGHeITdt0qoCwD5NM0JxwVPP9+CzbkyBi9Vap1hXxqdZRFOnQtU9alH2Pot2UIB+WvGuPrj94T7gUqfmTpT8jFEa0yYrBv4kbgvHOvNuUdQFoq8wXWvRbrDWzliaJrgRJnah9KkjX2qNtSY45p2liWJa1F/NmTdV+XhHDvzd+8AzDVq3Hl3BKhOW1oS3kSrERV6/zamiLHs++8df2RxrH7PsX2Odawzi8jstYJ423oP837PeriiNOVJwOv1ZKQ/yzI/6yHs7Hp4nHzJC/SHqSTOrw1eQ/SHpQxAIb4VYehMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLSYEaOCEqvaWRx+hZ+zuI+AV5/hbIVbNRzO0E559Vg=;
 b=zSoyxHNb1dbyHHteb/oy2RuCjR0vFK8qcvUZFI4sdiodgZvzKeaTozhR7aDBy8a8R81gHRcUCCEfuJeS+qK3142NmWKBhQI70N6t2CdYp+X7tl4v+CpMgboCNxQcP8djcpEhTeoJuB9vKWXfMXLnFSav36iv9kNL5kcGxcPPQdiXi68FAGd8GEDVcJkNMsRPnhv4QpzFMc0CslyKHcAISMAh1ugqe8Sg1R0RDpyIP/oh+8Xlqdu0lBsMtfa/kKF+6UT3/MXZ0vjP4vPu7xJ1LURSSOwMcA1trN05TS0Ybxxou5Pb8tzVKN6NL7+S5XuJ7QpN7L+NYqdFjsSYOVlVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLSYEaOCEqvaWRx+hZ+zuI+AV5/hbIVbNRzO0E559Vg=;
 b=RrC9nOR6/vQaUf4MhWSh1OSzAP9dcW36ZLs/fc4VyrrMp6zRz8f5GSU9NRHy5O3t4IakKCJM873U9xsA7GedeMQafAFL52C/BM1zTqAWVKp4NqKhFROA8hH1pXdg57uXnrSUlBvSvKRkuMpTkuqWVcVUxIQUa50Q/Rw9nhk0PrI=
Received: from DM6PR03CA0033.namprd03.prod.outlook.com (2603:10b6:5:40::46) by
 CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 19:39:25 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::b7) by DM6PR03CA0033.outlook.office365.com
 (2603:10b6:5:40::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27 via Frontend
 Transport; Wed, 17 Jul 2024 19:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:39:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:24 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:39:19 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Hansen Dsouza
 <hansen.dsouza@amd.com>, Chris Park <chris.park@amd.com>, Yihan Zhu
 <yihan.zhu@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 03/22] drm/amd/display: Add private data type for RCG
Date: Wed, 17 Jul 2024 19:38:42 +0000
Message-ID: <20240717193901.8821-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4ec468-6024-4e44-803b-08dca6982a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dZ83K9zSvGGgw//7ncpt2NblD5FEHMRpnhPG0CzfqFuJhr46bVx9pSYZa0Wh?=
 =?us-ascii?Q?eCge31G5mf0C/oRGPMAiqbiuilqCcnfdIKLFHI2KplfoHVKXB+yqxGfX+Jur?=
 =?us-ascii?Q?ToNGunB3XAvcgOoHeAXYaT680Qp8izzDTEa9jQNetN7kBSSXw7laPO2WYdma?=
 =?us-ascii?Q?1vKvhHU5zSuxtmGWsMeK79yGmj6iWw2mKLJCP/AeEBHuz3eWyFoG7JDVbYIr?=
 =?us-ascii?Q?gx4s1zhV1vFn2gS8n1WLuxeGx5vhdlnhiOQQtz1Ib9HisiXkI1ABk/kWWVer?=
 =?us-ascii?Q?UQhRL+l1j/fLsnfai3AeXj8QcnZIyzoTvF0Cwql84xHu8ludIyF6044Zj1im?=
 =?us-ascii?Q?hL2kaoK7CQ2zIyNyNkCCTkeoOs+pySm8j9I6/QQV3j2dj1G8W1deMgoQCNUJ?=
 =?us-ascii?Q?hOp9+jqAqnpFZ3uc5f/jA/V/ZzmAiM1KtlMMPIAnV4hS8qjsGkNmMBRiXpo0?=
 =?us-ascii?Q?3KJn7myWf8pwd4al9X8W6OKB6O0e5oQi1z+8RO5HOj1vW1YqnCrQ9vH6kPN0?=
 =?us-ascii?Q?QVjTjLWWIdlMv3qGGGyXGcUo5BOxv7N+qJUoggO7GK9mwQqmRWcYsDnDFrZG?=
 =?us-ascii?Q?XxPl2XetbC6uvmaEuJ0JE9p3Fhw9qvtFNTxQoP1guMQaQMxGPpRL0NQLh/r4?=
 =?us-ascii?Q?Mx3D3HwNRL4vp88vJlIBsBoQAiXdXZMhqMLcCLSZCg0G4IXZ/8/YgZRM5kzc?=
 =?us-ascii?Q?v2pLYqRc8n2ihfJd2+pdxs46ich4SUDg2NGGhTzc0HiGOqi8DNAZ27M7B+43?=
 =?us-ascii?Q?f37G5+ncPz2ZETyIODYZAgCHISZEUQyNl5SHe42oJBf0WxNICibofCU5vLyz?=
 =?us-ascii?Q?AwAO08IoLWBUrufkh4NfE7/7Sa0q/Q4BKLXcfporTfRwYGA/UH0Z+ShVBlPu?=
 =?us-ascii?Q?belhJOojAPSHl1FQkRkTO2etrkZlCf7adeEJrp3asw/TdEsl5lnx229NDNnP?=
 =?us-ascii?Q?hUJkWIHdLagGbwDdYosN+bNbCqKXmB7DNnehMl17dpMw6pOqTr1cJjGTWcrE?=
 =?us-ascii?Q?C2ySMOTZpzwu4KmOHz7sv+9fgw2fVNxKE+Kofy9FdMX/ILb8a/LV4rseCN5b?=
 =?us-ascii?Q?hIXtC3ehwDBwrrzZiF+AOfKag6Rv/EppOA4hqQmAq+wxv/UBAXklLbPL54sw?=
 =?us-ascii?Q?pgm62+PxiiQB1OMQ8SH8/vZf9GCRmSac43NxjOJ/7DaV2jzkHYWWQ+0ooCe0?=
 =?us-ascii?Q?8M+GZQMjktkHF1nzYXc/4VaU9zcFr9IV82R1wcpo4jQH/ShJ0+6pmGq1Ujgh?=
 =?us-ascii?Q?Z1aryyskcwMrcSN8jjANa2aVbdnbTKZgtSGSeAM9tDBlMvpJP/ckuiKRx3gX?=
 =?us-ascii?Q?CwHoWz6pL3sDv1IIfh2/zzKFBkZG9965/7NcguYhpxxHUGj4aRd6Nhr2sak2?=
 =?us-ascii?Q?dCshfXSR204dBXQeFe9CmQ0lc1g3guaYnTU54GHsRCQ7vXZ2aZca8McMeo7z?=
 =?us-ascii?Q?twBAV8UDFZUGwlf6ApivqceZ2Ac8M8Dj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:39:25.4553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4ec468-6024-4e44-803b-08dca6982a5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
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

From: Hansen Dsouza <hansen.dsouza@amd.com>

[why & how]
Add private data types for better RCG control

Reviewed-by: Chris Park <chris.park@amd.com>
Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Hansen Dsouza <hansen.dsouza@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 68cd3258f4a9..64b25e5d9d7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -41,6 +41,87 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
+enum physymclk_fe_source {
+	PHYSYMCLK_FE_SYMCLK_A = 0,	// Select functional clock from backend symclk A
+	PHYSYMCLK_FE_SYMCLK_B,
+	PHYSYMCLK_FE_SYMCLK_C,
+	PHYSYMCLK_FE_SYMCLK_D,
+	PHYSYMCLK_FE_SYMCLK_E,
+	PHYSYMCLK_FE_REFCLK = 0xFF,	// Arbitrary value to pass refclk selection in software
+};
+
+enum physymclk_source {
+	PHYSYMCLK_PHYCLK = 0,		// Select symclk as source of clock which is output to PHY through DCIO.
+	PHYSYMCLK_PHYD18CLK,		// Select phyd18clk as the source of clock which is output to PHY through DCIO.
+	PHYSYMCLK_PHYD32CLK,		// Select phyd32clk as the source of clock which is output to PHY through DCIO.
+	PHYSYMCLK_REFCLK = 0xFF,	// Arbitrary value to pass refclk selection in software
+};
+
+enum dtbclk_source {
+	DTBCLK_DPREFCLK = 0,		// Selects source for DTBCLK_P# as DPREFCLK (src sel 0 and 1 are same)
+	DTBCLK_DPREFCLK_0,			// Selects source for DTBCLK_P# as DPREFCLK (src sel 0 and 1 are same)
+	DTBCLK_DTBCLK0,				// Selects source for DTBCLK_P# as DTBCLK0
+	DTBCLK_DTBCLK1,				// Selects source for DTBCLK_P# as DTBCLK0
+	DTBCLK_REFCLK = 0xFF,		// Arbitrary value to pass refclk selection in software
+};
+
+enum dppclk_clock_source {
+	DPP_REFCLK = 0,				// refclk is selected
+	DPP_DCCG_DTO,				// Functional clock selected is DTO tuned DPPCLK
+};
+
+enum dp_stream_clk_source {
+	DP_STREAM_DTBCLK_P0 = 0,	// Selects functional for DP_STREAM_CLK as DTBCLK_P#
+	DP_STREAM_DTBCLK_P1,
+	DP_STREAM_DTBCLK_P2,
+	DP_STREAM_DTBCLK_P3,
+	DP_STREAM_DTBCLK_P4,
+	DP_STREAM_DTBCLK_P5,
+	DP_STREAM_REFCLK = 0xFF,	// Arbitrary value to pass refclk selection in software
+};
+
+enum hdmi_char_clk {
+	HDMI_CHAR_PHYAD18CLK = 0,	// Selects functional for hdmi_char_clk as UNIPHYA PHYD18CLK
+	HDMI_CHAR_PHYBD18CLK,
+	HDMI_CHAR_PHYCD18CLK,
+	HDMI_CHAR_PHYDD18CLK,
+	HDMI_CHAR_PHYED18CLK,
+	HDMI_CHAR_REFCLK = 0xFF,	// Arbitrary value to pass refclk selection in software
+};
+
+enum hdmi_stream_clk_source {
+	HDMI_STREAM_DTBCLK_P0 = 0,	// Selects functional for HDMI_STREAM_CLK as DTBCLK_P#
+	HDMI_STREAM_DTBCLK_P1,
+	HDMI_STREAM_DTBCLK_P2,
+	HDMI_STREAM_DTBCLK_P3,
+	HDMI_STREAM_DTBCLK_P4,
+	HDMI_STREAM_DTBCLK_P5,
+	HDMI_STREAM_REFCLK = 0xFF,	// Arbitrary value to pass refclk selection in software
+};
+
+enum symclk32_se_clk_source {
+	SYMCLK32_SE_PHYAD32CLK = 0,	// Selects functional for SYMCLK32 as UNIPHYA PHYD32CLK
+	SYMCLK32_SE_PHYBD32CLK,
+	SYMCLK32_SE_PHYCD32CLK,
+	SYMCLK32_SE_PHYDD32CLK,
+	SYMCLK32_SE_PHYED32CLK,
+	SYMCLK32_SE_REFCLK = 0xFF,	// Arbitrary value to pass refclk selection in software
+};
+
+enum symclk32_le_clk_source {
+	SYMCLK32_LE_PHYAD32CLK = 0,	// Selects functional for SYMCLK32 as UNIPHYA PHYD32CLK
+	SYMCLK32_LE_PHYBD32CLK,
+	SYMCLK32_LE_PHYCD32CLK,
+	SYMCLK32_LE_PHYDD32CLK,
+	SYMCLK32_LE_PHYED32CLK,
+	SYMCLK32_LE_REFCLK = 0xFF,	// Arbitrary value to pass refclk selection in software
+};
+
+enum dsc_clk_source {
+	DSC_CLK_REF_CLK = 0,			// Ref clock selected for DSC_CLK
+	DSC_DTO_TUNED_CK_GPU_DISCLK_3,	// DTO divided clock selected as functional clock
+};
+
 static void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-- 
2.39.2

