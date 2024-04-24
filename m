Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EEDC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5479610FE11;
	Wed, 24 Apr 2024 08:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q5PY5OK/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B6D10FE11
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnj19dBVFHg+uSdkAB+MItLz4GS9qeM2wwhyPxGskobwRmBZzxoRENDnqZVv+gHJI0qUzFx6qeYXAfFeqtrXRep+M2p7lsjARcJ71y5UcqYhsiR81EUVGpMc3h/Blg52yKoPrLg2ffch2iaa6oeWcMzSmN+4s7kPLVv5LI38dmRGlYKn7ugBcncdoG5THrCb63UIOhoutg2PGmlYgGzzQlUiYKXdD4QwGnTt6Uf+dQsPqIMNAv9SvMk2ATo4Qvq1BTXcI35W+S9V/XT3Nj8jeQVkqaZlTfIanyeqK9+QDgzv7Vrqc+THZKHMJOjFO+LNEU8YYfHH7SmKGBvr2/XCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE3eXtUzeNHGc7YzDGbufuuejLQDdGE8yd+F5egPPO4=;
 b=IE5xqdZOYSVBb0Lntc86kh311eDNu+P/DVWc2WqWuO3BzJxQUBJUar6rYMADOtOB1eivproV/E1vqX8NPrRpFufsoK+rAgNJLGF+YiDyDHgKx9dgDHnZNq2Bl4X6k0Z0SIjZmOlgpIl8acyOaJMVNiDT+3+SEa8AhyncTAWLDVvx+tVGM6hRhKTVJagAMpMhS62X3v4Xa/77cFs4pAn6+2lmSVOjG6L0my9/iQjVlSWLZIIfy8o+K6kG/HIOYY/Ufteyb4m5gAGcWTgOSJSCCVjlHdl9anPuytWdpTIzoI0g3VqHBmE02dJn0Nux9fGJ8nzpDKvilFHkDr5kamk4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE3eXtUzeNHGc7YzDGbufuuejLQDdGE8yd+F5egPPO4=;
 b=Q5PY5OK/CNBujxbgb34Fo1/OlYuUBoN2JPnbQmF8Q0X5Q0rVfbUXvQ7Ge01VfUEiHJ+M/aFWLM6IoMc8BOVPRcv4BSQWP2yOYhxzyK2+wMANdcCIGRcTv6lP2u5p4pw+zC6BSQpSnT8vbiSjPJ4i0VNFVIVvBkuK6LfPB8guVhc=
Received: from BN9PR03CA0152.namprd03.prod.outlook.com (2603:10b6:408:f4::7)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Wed, 24 Apr 2024 08:52:51 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::10) by BN9PR03CA0152.outlook.office365.com
 (2603:10b6:408:f4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:50 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:52:46 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 27/46] drm/amd/display: Add trigger FIFO resync path for DCN35
Date: Wed, 24 Apr 2024 16:49:12 +0800
Message-ID: <20240424084931.2656128-28-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8ad65f-f37a-4c10-bb4f-08dc643bec94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J1gcYH46MuXijBg66pns3bOyniXm/HaGAdX3aMjCDwpKJKdP5t9dObgSnri0?=
 =?us-ascii?Q?O6mHIn08j2Qu4aD/xzrUy2w04IFegzuRKQbxb2CxwbwkRXVh9gdk1itn82uh?=
 =?us-ascii?Q?7mb5Yqi36mwuxUR2w3OAXfa/TufqG4/071IL/I3lX633bT58Dh8c/aCFXooO?=
 =?us-ascii?Q?DHHAqOPXXChNDw4f4lgGZFOtFhAhhT8sMAZDPfsZkqvl/jaL1BCUQoLh67FV?=
 =?us-ascii?Q?GuCppR19EBz3yGHMbTjMCrpNUtdx9GfQcmocGVVQ8cHfoa4+mjSE9k9Ppv3j?=
 =?us-ascii?Q?Y5zB9RHhHM85zUxzTuiDV2QqR82l3Euit3g5El67ZenCWmILxeS+tkyergPg?=
 =?us-ascii?Q?0aGg7ZjUzcD3dgwOLd1vr92LNsY3chsCzhysCXkEU98FVbL0R4eWlEwmefON?=
 =?us-ascii?Q?GpdcB3bllEgboByvJw4gXZi6SFlUFC3KpgQpAWcZwMC5SoEYcOM+8Aq7j8sn?=
 =?us-ascii?Q?NjFA7BRuazOF99pvVqvLOe5gm0nkDe17J+a8qkdTB1qx4RWiqbK3/26ux/YL?=
 =?us-ascii?Q?d6MgfP4wDKyBdTsZYawHrVc48tZzTDUA4vN6k5skkQ5Dlv/BGfXj+lRa/KuV?=
 =?us-ascii?Q?elDYjFalZfXhnXXGttr0tfPRltg4YKBKaSFkxkCh/Kd0UJ1Ncw1lspcM18H2?=
 =?us-ascii?Q?kMgQzsYii7C38IqOSO1qhW1cYMcJ00zJyZYhvKzxXOUzD7tr8Svbt/fC63UD?=
 =?us-ascii?Q?kFTkBK4x+4B8bMBe5EcowaMLki8dNISV9Sp22B8uQLLed0CnsQPbyafDZhaU?=
 =?us-ascii?Q?a8Th34QQ6H8e1GtVkD0vB8ALCOFzEhnNXcHyIAf6yqM2+I6+SwErMRiCIuyE?=
 =?us-ascii?Q?uXO0XY7BBVtNkEok6+GHbCein8Kng4JBmW1CZiNZfMJ42PABlfPbkQDf7QQ4?=
 =?us-ascii?Q?i6I6EU7KJUzIlIHO5URW+IirTEkg8jIhvBjemkZzejtIWkSWEHMVx1mv0Vbc?=
 =?us-ascii?Q?qG44d4ICUigNHiwlok0K+k6II/siX/b0gfmC+u5xCqx8TTUg1fvoDQkUdZKF?=
 =?us-ascii?Q?V63BthsgTw+jZ5Xvp1ak9UiQ64zdRQoQB9Cdzt7PuwVAdv5UdQumANN2Khf+?=
 =?us-ascii?Q?DJPc+I8pz50efBzbBUm9W/hrUFNxpRAEJhEJ49AZzEkLV451ZKfSfZ+iPpLe?=
 =?us-ascii?Q?llBk4i+X5JYCaZ5dArY+oFk5H4ySSI6lST/I709kuG3KrfDx/dITDQnrMSi3?=
 =?us-ascii?Q?X8b/HRh9WBIbvXJGzeqQOxOzWFH9S5pg2ldtzEWrrR4EqtE3Qpkia7Hke8Zk?=
 =?us-ascii?Q?DC5PjTGJFL0t5KvnC8+nqtsGSiECtnKdNoA/796kmMn5fuo/yN8qq4T//HoM?=
 =?us-ascii?Q?8BVvetMu5Q0iUIScKeObMSOzheCMQ1CFjCkWoLjvyGnR6XHwXLpWCiyt2Wil?=
 =?us-ascii?Q?6Ps727HGSwDUQyUTdDxemzPopF7Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:51.4317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8ad65f-f37a-4c10-bb4f-08dc643bec94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
FIFO error can occur if we don't trigger a DISPCLK change after
touching K1/K2 dividers. For 4k144 eDP + hotplug of USB-C DP display
we see FIFO underflow.

[How]
We have the path to trigger the resync as the workaround in
DCN314/DCN32, it just needs to be ported over to DCN35.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c      | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index 4c53e339e325..4b282b7e0996 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -41,6 +41,15 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
+static void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	uint32_t dispclk_rdivider_value = 0;
+
+	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_RDIVIDER, &dispclk_rdivider_value);
+	REG_UPDATE(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, dispclk_rdivider_value);
+}
+
 static void dcn35_set_dppclk_enable(struct dccg *dccg,
 				 uint32_t dpp_inst, uint32_t enable)
 {
@@ -1056,6 +1065,7 @@ static const struct dccg_funcs dccg35_funcs = {
 	.enable_dsc = dccg35_enable_dscclk,
 	.set_pixel_rate_div = dccg35_set_pixel_rate_div,
 	.get_pixel_rate_div = dccg35_get_pixel_rate_div,
+	.trigger_dio_fifo_resync = dccg35_trigger_dio_fifo_resync,
 	.set_valid_pixel_rate = dccg35_set_valid_pixel_rate,
 	.enable_symclk_se = dccg35_enable_symclk_se,
 	.disable_symclk_se = dccg35_disable_symclk_se,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 7ed5de5c5ec1..0e87f3503265 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -31,6 +31,7 @@
 #include "dcn30/dcn30_hwseq.h"
 #include "dcn301/dcn301_hwseq.h"
 #include "dcn31/dcn31_hwseq.h"
+#include "dcn314/dcn314_hwseq.h"
 #include "dcn32/dcn32_hwseq.h"
 #include "dcn35/dcn35_hwseq.h"
 
@@ -158,6 +159,7 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
+	.resync_fifo_dccg_dio = dcn314_resync_fifo_dccg_dio,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.dsc_pg_control = dcn35_dsc_pg_control,
-- 
2.37.3

