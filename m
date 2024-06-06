Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A423C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BFBC10EB00;
	Thu,  6 Jun 2024 21:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QGMq+0wQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E985910EAEF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mE5/BW2oo5T8yGciEvNUa/w9NEsl4TBI2DYp5EFqc+T4WmbH12H2AoYUSBFM481d4cQJdkSTXJK6GXFQaB5AU7wBCgtv6XcVppPlyqGt51vuxGBht0tNAqtCDLdBPfgaCdIaJCQ4FDolduPn7k/eO8X6Eubkqab8DWNW2n9CSIYg03C9rZiX4fWiuUy+QuKal7KJZ2ok9oPH3/r6f0ivp+BpzxtIIGlEbwcyU84zB+Ecom/nSmsKY6zkX7VM3thXsW/UIAX93CQKkhRxwUNyZPhpHLZHNnSGeNeDxAQ9HiGfTyOEG4iug0s5iyIPzXHDA+9VPoJiIBQWPPO20HcxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHft0pj48rJjHvhNmmF/O0uuXJ04dGJon0rdAVpn9mU=;
 b=W3NiFIte7+OsGCGF4LJVokqBVK4J6upmY15/JgRM2WX9qnq8Dfz9yE2U4A7uzIMgrLU5sMJxQ+8NdJb+5Cw8sFjIP/kbGXK5rGyPcQgzxrQtaehSFzcru2RoYJsZ7osj78ihLWJuPgNR1QY+lUFHwLP536CvWljTtrPnIjhTn0MBr2g5xRfDiMaIgHUnNOiJCSDJGHFIdZEUbal0NU1MkhhqqibNVSCWsgdiGkZIQ7dLt3azbRWC2M+2scWh5KEKpVtiSKRJSTQnonhbeke7w98HvAfWJSZ3hPAx8dWuG2ndAUlsuEorrBc6xmu9mEmmRkx4br88YHtQHrLZ5DajTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHft0pj48rJjHvhNmmF/O0uuXJ04dGJon0rdAVpn9mU=;
 b=QGMq+0wQ9oxdgjNFpvGyLZsixFzpL4y/iAbXfii3/NYXmmyx6bT3Kxc52U30LiZ7w1K7QqmCMg0dUNb47sdBMyHPl53teV6VW+ufRRMES3fkWyQDbAaqSNaomL4h7r93hS00RY6RzEy46aQSVmNqzT93LdkXPU90BdTJ7Q3ElV4=
Received: from MN2PR15CA0066.namprd15.prod.outlook.com (2603:10b6:208:237::35)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:57:51 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::14) by MN2PR15CA0066.outlook.office365.com
 (2603:10b6:208:237::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:51 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:48 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Paul Hsieh <paul.hsieh@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 36/67] drm/amd/display: change dram_clock_latency to 34us for
 dcn35
Date: Thu, 6 Jun 2024 17:56:01 -0400
Message-ID: <20240606215632.4061204-37-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: a507d8a4-76ba-4aa9-2d15-08dc8673b653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NxzLbqDeLdk5oBlh41tS1M+LsE7sUUFcftBzud9Z6l6UowOsWNcZoT2Q6Ow0?=
 =?us-ascii?Q?DaRRzgkhLz6uTVLlHfcS6CtaTZyDwwwEiHp36Ycxb1FYo9aS8v7ovDRJyC6C?=
 =?us-ascii?Q?oATVurMNRIqqMjizKNa8Oi7pu8xpKzfgMFr9VjREWEFltJ6dEZ7OMdowegpk?=
 =?us-ascii?Q?9Ob6JxIoNkCE+VIksVJ2S9UMAbStAQuvsimCkGX/PTN66NGhXSukjEDzh8uo?=
 =?us-ascii?Q?Hgfmqfcc3PYLGURZz/rpbBlA3Ky5sHeG91zyjsL8HzC+6+sbOviYTWb/DftU?=
 =?us-ascii?Q?ESNhnN3IuddYWmhYFJx84q0pC3zcBrPZl7TiXIhkPy3i7FoRL6ZYvn2HgBZz?=
 =?us-ascii?Q?N10iEQbfcsxnZPk/BEIdxhsH0xYvQ0K8+v5wHcJ5m5cZc6jG9t51Shi16lpR?=
 =?us-ascii?Q?1RYfm6dako027U+RtFLGwSmby71tBLrmeafBpdAAuWGLfj64tYX9hGJbN0SM?=
 =?us-ascii?Q?h8ZxD4x3RgC4opKC71l/kMwzswUY0hLYDO6H139RDRp2y/d0usN3bL4qv+q8?=
 =?us-ascii?Q?ngD15rdwr5aBrM65J1yl/apBlUijLUe+E4RK9a1GBl6m8h/Iyc9ViG0yZdJ9?=
 =?us-ascii?Q?e0HL6oxPkMFdTEvZyAtPrhzQ6Mx/6FiScMs+AvuQuiUrg6oJr9Cux2J00JfA?=
 =?us-ascii?Q?M1qco0Wk4IhIgHa32o73//oNcrWo2foNTSo9/2PQXYov8a53clEJ0zauvcNY?=
 =?us-ascii?Q?IJ353YYox5FAy9QkI2X+KQzab5ex/ykOU8J9sTUvePI+DEnheFh90Mv2A/jw?=
 =?us-ascii?Q?3ZG4wG/FzwUsaJ9YK3wDDU/iXUahv5K6AG6CGSWtj8IX/Mt/qZMGNlKzp8u/?=
 =?us-ascii?Q?wo3Yi0HwKWd6vUrKGmIWFPcEEg9v59uAQBVnT8ZHnJIuvUjRCNI8O5rLno2B?=
 =?us-ascii?Q?8n4b0S1V3LPl4lrmQPZZ/I3jIAIHwHDt4uV92Rwkb8rZ5ptsD96iWfanCldL?=
 =?us-ascii?Q?cJgAXu55YssHTbaw4dTQCWCpned95+fa0x3H3SsoeRWe39ZWezrCopvxefAO?=
 =?us-ascii?Q?AFoFkaYWZVK7NMNwtb15GcHX9uPlSC54b7AhCpapyuRgjiTwa0mUBx8huCl3?=
 =?us-ascii?Q?i0vsI1UeIj5d9DFXuViJANsT45x2xw6cVUrSodwnqtRCywUOLUlQl9HzRMdV?=
 =?us-ascii?Q?jrq5V6Da6ryKLpQ9dfiRg1QNO1bp6bUwROlkzLy9tIVRMeNTMLDg4pKMdZ73?=
 =?us-ascii?Q?8DDMPwhH4jRKgjQhCjg/6lz/YGKb/zZEMuO2OwyrfCdJG4xLtGXhsKP13JgJ?=
 =?us-ascii?Q?x6CNZQVvYPA8i2z9qtxtAgLOt9ScWxmDe+AmWBSAKjYD4mVeGzptQmMvsAMt?=
 =?us-ascii?Q?vF2rATBpODQmMBzxcX4RVPth522q/LAVv8ARNp+/wJS3vjQCDyOiZyzrt2DP?=
 =?us-ascii?Q?f39dJGoUNiYhoBn+KxSYtze1kucKfPwy2kB2AwSvMyjdCioH3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:51.7408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a507d8a4-76ba-4aa9-2d15-08dc8673b653
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
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

From: Paul Hsieh <paul.hsieh@amd.com>

[Why & How]
Current DRAM setting would cause underflow on customer platform.
Modify dram_clock_change_latency_us from 11.72 to 34.0 us as per recommendation from HW team

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 60f251cf973b..beed7adbbd43 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -177,7 +177,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 	.urgent_latency_pixel_data_only_us = 4.0,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
 	.urgent_latency_vm_data_only_us = 4.0,
-	.dram_clock_change_latency_us = 11.72,
+	.dram_clock_change_latency_us = 34.0,
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-- 
2.34.1

