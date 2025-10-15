Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64E1CCD18E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 02:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D0210E6DC;
	Wed, 15 Oct 2025 02:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0dUcgukt";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013002.outbound.protection.outlook.com
 [40.107.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5F310E6D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 02:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apaWQQ7Uj2nEQTFacfpwS4e6hTU1EIfP6fkr2nCp6feAqoiOIBnPpAOTzFQjZZ8UMbhNDbbn4mdnu/V82GUvCcwp3y7sbpLnZg9JeJWIc9mmSxrZlFGnUl3GV3rU/5cKWw89L9M7rC8jiz++C+PJP8scx3iqp66BPUzZ7uKQfS+NUf5b7ZOFXqMo9Yia03R9G4eMKDbYEWdErj4pXgxuYfqV7A7zXq+nBMNNX3c+owG1yJXnO8B23E8h7FYT8Y8jVk/Ep9am6UqKSdGQw/Q+oY3RRK8BCcBG2RHBquNM/vhxGiLBeI0FObsJN9rFLalr2sLla2lzE/R/mXuqZbeNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y/D36uyEwDx1ZIpPil46DwZnjoPwDd3a1twL/IksYs=;
 b=WpXroTsU7LSax786h7gwv2pFZmPf1MUNBzuOPoZNS2EFzrKcQKEz60OSO7kVZaHnAeFDVyF3aY/i608m0OCTjmx3y1kVZudTden1VITkp5A+Op/mK7V9kcopLyc++LiNqGM4McD6X3YuGQ8/6HU83O8ak5+fINehKXeJi/ioBXlRrYlGQwt4z7agmVCCbjuwyb/WdjuBiwkVpyMCrsC5FatwQKM4VY6h2KA+OC57BIJ1M5XoiZkfTgi6tWW59tX8fmtTAJjb8PgxIupxG1/BgThEjSwnlFV+n/+TnQzZys7PtatUBbUBqpTxofFcn8u9BYrInZFSXD/CXg1m0s9YJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y/D36uyEwDx1ZIpPil46DwZnjoPwDd3a1twL/IksYs=;
 b=0dUcguktrSi+fUUINnmmvZP69sjRf108pdzIjnwq315wAw3XwraoLoEEaFrLogcksHs85hLsYw5eaiXqRHU6qqTJcXI643qmiTpbskG5d2kPr4jCGy90VfC5Lm1IrGy5xPzsyQuI1HmGO+rJuaWdzPgtsNnnur00Wb/uyi45lMY=
Received: from MN2PR14CA0020.namprd14.prod.outlook.com (2603:10b6:208:23e::25)
 by IA4PR12MB9833.namprd12.prod.outlook.com (2603:10b6:208:55b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 02:58:53 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::65) by MN2PR14CA0020.outlook.office365.com
 (2603:10b6:208:23e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 02:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 02:58:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 19:58:52 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 19:58:52 -0700
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 19:58:49 -0700
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Lewis Huang <Lewis.Huang@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 4/8] drm/amd/display: Change clean dsc blocks condition in
 accelerated mode
Date: Wed, 15 Oct 2025 10:57:05 +0800
Message-ID: <20251015025816.1542507-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
References: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|IA4PR12MB9833:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1c66db-5cb5-47bc-654b-08de0b96c604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8TMEDfZZ7RV2Twk8FD0C6wCmYrT2RrgubnuGqBUUtFKt7ukcWHMCLbn3ZRqv?=
 =?us-ascii?Q?/W+4TkWFhjY9FHs7lPEPbPmuixglgSQgvvl41SD6MxKHeCgD2vV75ANxnHy/?=
 =?us-ascii?Q?ZiMbH04IIQWUrFLUsj7/nwM7c4YBbkuyKwYlLAefY/77oUMczkAHhEavgWxE?=
 =?us-ascii?Q?bqjXBCuWlIXoQbygMHbk0caoR04yUg2fINJ90DK1Em0Cs94kMOkDvdItRbLL?=
 =?us-ascii?Q?pS+RyZTPGFc1D7IuF5UrbH7jPZ9VqfF1PMTWJufawJi9VxC5hUMWc9UGqRP6?=
 =?us-ascii?Q?B7LksxH5aqQtgj7J8YgUu0hstWnyGWv//AKf9EbRih1xbDX+M65nLokhosnL?=
 =?us-ascii?Q?JOmZm/eKD/OpFPxqh/zFC1wuZAegDyqjjBEWG/bR8GtiizbPHiddMKSdGZ3K?=
 =?us-ascii?Q?nvbmTSqejHdEwj73rshtOgAXSyAxW6EhBzSmR9ZfvmuMOXdaAjYtyJErZS6u?=
 =?us-ascii?Q?Q3JKwxUQdJvBmbx7DyOmarAJwSMH/KEq2AwRxWZ+cGYB0GfFR+VL/nwwV0P+?=
 =?us-ascii?Q?E6rGoRsfVJ8ZiPM05dqTzBlnGHigjZn+DEU6oFCN0GsDL1azVLM+4ibS458q?=
 =?us-ascii?Q?gni1EMlA7YylY47vVUdENINGPW7aAIcsbN/5afb96ihUUo8vzmcksoz03ZXc?=
 =?us-ascii?Q?qQ9duO+6ZXxNv/sArSHxa3UXx4Dmpll9dTHuEDW3BevIk+x/B/5x1Otu89AR?=
 =?us-ascii?Q?BJ7M6fvujVJFZcAZ4jM4ZzG/pMarTiQ6EFnozmr1xzVxc0ARsmCN1vepPo64?=
 =?us-ascii?Q?R0LdvkoKlSy7zv1qlzhwGZntWl01qLKYq4BHXspO65UMtUSDHjeEqoWZA41o?=
 =?us-ascii?Q?H7tHVD84jBRc1q1+imQoL1EyBL+FFhicWPtQCqzYcdtzobMM7s4mS1GE7z24?=
 =?us-ascii?Q?n3JEang7rnDlGQD/iPt3+nkixllBLNEf5OGMrAKczhQ8Lt5aQ+OIdq/+eB9l?=
 =?us-ascii?Q?6Bx4WR4vSk9qTzIxRevMfcvdWDQ3f175mUH7n+AuVsNnYbdVjz+sR4v6qBp4?=
 =?us-ascii?Q?yItI3xVtTwgZxyn9RcLBrpVVNhFLr0PD4c9iWlkCEQBOkh4s3GGCEJEoSSgr?=
 =?us-ascii?Q?Oc3QHM5J35s3ai7htLGGvv0IBdsMzD7d2whWCXDRCxKaCKgJN+ZF1j2RHa4v?=
 =?us-ascii?Q?yf79pOeNiDZO7z1eOqkWMqaRFQR4iigCDUS4VS3ZDdVpcJvDh2Fnkrd0V4cI?=
 =?us-ascii?Q?bjkASU2TVHkMbnwq3rc2Ah7myfuOcPnDT3IdR97Ex4LgZ0I9KtlL4K8GhR7K?=
 =?us-ascii?Q?Zd8upNJ2pxmlDMEPGv9ZkodWbqTBLOFagI9KHNFpKlymWLCAbWOIpCozm8oS?=
 =?us-ascii?Q?DGmAiAkAIONZW6G1GGynroW2GQRy0yQW1R40eB/LYrKwWRrnWZsYc6xlP+3G?=
 =?us-ascii?Q?/FrEX4WjV7fU2iopfxdr8G04DHYYRRY3/My4Jj7g7rSWO1GdY3agI8FvIpK3?=
 =?us-ascii?Q?2ilwB/7CInBHy4Q8Zokfu4XDAq5vk+sm6R1yeQmfVnsdpPdIccAi0gxUUCHp?=
 =?us-ascii?Q?8zN6ejbZSN++wJblVFKn0haWI3MWe0HDlr0z6J96wUHfvJk1A6q+uXc47AMt?=
 =?us-ascii?Q?KWBkC5IRcaw2JrASqUU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:58:52.7912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1c66db-5cb5-47bc-654b-08de0b96c604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9833
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

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
On system resume from S4 with the lid closed,
DSC was not cleared because DPMS was already off.

[How]
In accelerated mode, to clean up DSC blocks if eDP dpms off is true
to align the DSC and dpms state when we are not in fast boot and
seamless boot.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 24184b4eb352..6b0566baa2f2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1913,6 +1913,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	bool can_apply_edp_fast_boot = false;
 	bool can_apply_seamless_boot = false;
 	bool keep_edp_vdd_on = false;
+	bool should_clean_dsc_block = true;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	DC_LOGGER_INIT();
 
@@ -2005,9 +2006,15 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 		power_down_all_hw_blocks(dc);
 
 		/* DSC could be enabled on eDP during VBIOS post.
-		 * To clean up dsc blocks if eDP is in link but not active.
+		 * To clean up dsc blocks if all eDP dpms_off is true.
 		 */
-		if (edp_link_with_sink && (edp_stream_num == 0))
+		for (i = 0; i < edp_stream_num; i++) {
+			if (!edp_streams[i]->dpms_off) {
+				should_clean_dsc_block = false;
+			}
+		}
+
+		if (should_clean_dsc_block)
 			clean_up_dsc_blocks(dc);
 
 		disable_vga_and_power_gate_all_controllers(dc);
-- 
2.43.0

