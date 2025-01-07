Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57211E77199
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A1D10EB09;
	Tue,  7 Jan 2025 15:30:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CLKsTVaU";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E528210EB07
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhoUsC4MpLKXdCiciUawEDqN39Wp9kJEUvhAJwP3GGkfeqeoedg/xRBjSTc0lL9C2YlVEx/zjqj6ze70L5r1dVp8UKbOkLh4HRYS/to92g2IXezrEsz/fXMuK3jmTMTGmwZ1DrF4jwwD5t71+/R257sC+HWu89qq10IDv6tIavPPE9voEiY6wKWr+pWsc2AXrnbDlJQgOtGtsWaXh5EGmlU6p3f0FgL0g9y8UF7xA6NkpO0nirwRRMR4Gb7K/ZRw4iRsrdK/9AeAuKID1aeINX7JmfdXClaxmt+BkgI8L86lgbtJCShRWXFNJvlpRZpaedrsz+Eekt7glNq8vMtOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6/vp9J7gdVbxzaFhr/ezjc2OuVC5V2ydYS2ogPXFM4=;
 b=y51PPvwPo6H5l0UB0VH3H7T53X5sN6ZrpkRhsKTyVjO4VvEbTxUdPBkCwCMZYMrLXwHIaDx/giTfgUlUeScDnvlvh6iiUmEJFxQaNsJ1bGiKG8sCCKFlAEaC8TuzQlKBrgyJ0ezBgtiK2aabH1jzz/cmxaNqV+aDcUMe2ULIle0N8F6WXeLVjE4U9n0//2vHiwBg1tXasXIdp/TA+4RMODQ/ECUMtg6HchD94r540TGzGEEa1Hmr12J0wvqFVq+6CfIn9XGZSjKgpNOiBjy1Z2lEDv/+TZcGeP2apqGnVmDNibWc4c2QbvQmOu6/wzzTed+6xlixYOhb/D8l7do3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6/vp9J7gdVbxzaFhr/ezjc2OuVC5V2ydYS2ogPXFM4=;
 b=CLKsTVaUy0umfLC2aKqxLZpHfZmBr5MWIljixwvEHSkPvpbDhxNwGK3bfzT1uj8nBJ/QQ3Om+Ws1Fthq9rAFB1w2ZRAavV8Gh6RFcI62vukYkE9p92Awo2yuYxto4BgsoHPminyrr/xjRkBSthv6cmWJUKIYydmeRW+OFj3i83w=
Received: from SN1PR12CA0079.namprd12.prod.outlook.com (2603:10b6:802:21::14)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 15:30:11 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::66) by SN1PR12CA0079.outlook.office365.com
 (2603:10b6:802:21::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Tue,
 7 Jan 2025 15:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:10 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:07 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 12/24] drm/amd/display: Add SMU interface to get UMC count for
 dcn401
Date: Tue, 7 Jan 2025 23:28:43 +0800
Message-ID: <20250107152855.2953302-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 781e0938-de5a-4b14-15c4-08dd2f302cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XBVkiieVJ7UVgU1bWPaapcaFF3VRwWW4R/Afgvinvia5HTP9TzwAGTtw4UKl?=
 =?us-ascii?Q?nWj71cEIvFyfnOGRNKNKyY2i3GXx7kYpIge6CxqCLCKDby+Zw9hf9KAu+N1d?=
 =?us-ascii?Q?rCkdrkyRQ6a9AML3W1E/j9+VbfbewP+SQKVAnuOsYXdyJ6w/3YYdfF5iPmww?=
 =?us-ascii?Q?MPv87gsj66WAwdEbemUjvAEFwyk8J7hbfAlXxrhvzuxYlI/VW0vP8E4pr+jb?=
 =?us-ascii?Q?5RmJghLBLZm0UmezL08VoiYlsL1cgcAYTVTDN922M1FshGst0lu2E8B2gZ9N?=
 =?us-ascii?Q?xFVgckeWSRAmhudgDhtqs3ySIOs5+202xN4tEETzgDh6K6PYgxYCOsRGZRko?=
 =?us-ascii?Q?ymPJzjW91TtBNgycsrzOP+qKhkrn2EjzO18D9GM+jlMtnzBYtTRqjSiAvR3p?=
 =?us-ascii?Q?0OBOqoX2Klm0bOWLL1wggQPpZuiqrXSLjVGavR01iz90yqzgmunvTZhKTJAO?=
 =?us-ascii?Q?TLaVu+a7ejV5+PVd8MCEoHSMnoQwpg7eAkdlHAWa01Bb8O+plXd4dS6x+AcQ?=
 =?us-ascii?Q?vU6sSBid/jXQ8Ae6GASouIZ5Jp0Q3LjdbQ4GjU+/j7+nabrcysr1e8Q3b7zN?=
 =?us-ascii?Q?LoqWjkLdsdrAPjJuvPf36kSIPp7hMuT+OcrYJETfCNh046w+v5SqqQj5n1tO?=
 =?us-ascii?Q?qak0YA5kjrSkgVH1AWOmzwFT3/C0BNyrHY5oUk6CCc4hkBOp4oX5qaA4e3Xi?=
 =?us-ascii?Q?22z69lMCTOR4FFHWGfr37Timmw79+fdAtmJuF7Dg7MAZhxRuwSyaRW/R1qU4?=
 =?us-ascii?Q?ykrkPv47COti+hFXsm68vfvkfFVIFY28590D+nEUMB0DyMMhJOj2DsfCCVwT?=
 =?us-ascii?Q?5wo8Sg4dmD8VAdGSMqmyGvHTsFn6Xj+seAOIiSjE9Y6GJOEdJhmq4ZpnaHxc?=
 =?us-ascii?Q?U6EA7sgvQkye05avYAoF1Cr6i/b9sKJBNdoUWHSNmt5w6ZJhqlnjFxy+wRWL?=
 =?us-ascii?Q?jUObQ3wjEVMzJgzoLcjKGKkvjysiXWDyHkIMJ00iuWEtccayEq0AESzIqXfB?=
 =?us-ascii?Q?NmAwz93pUkYY9o45PaMtMxwH8tXP69jUXo5h15wDx+BYKCzudkkIIyLpxrBp?=
 =?us-ascii?Q?YAFa0Y6U/UrfLLInscoEmWfAWO4y3XfBJUvz1osbS4Pc9eLKXqR8cO2lN1/l?=
 =?us-ascii?Q?5sgH6AcZj/vzQQ0zZ25Mze/TNBtzs+sg8BDo05wbMZahGnn2ZPXpiwOL0UcN?=
 =?us-ascii?Q?AOHvg0THXpsZHihdDn7KP/4up0BTTnu3PMcVKv6jFcDUoTsdK39QrLy1gkLp?=
 =?us-ascii?Q?lF2lGNTkW5ZpZfAKpgp6xY9ZAnVb2jDlMVdXx9n9UT/h8RBzin/S7epshQ+y?=
 =?us-ascii?Q?4C3RyEpa3Q3x4euAfvwPTBeQWI2hswgDJSJlJqTuz9yp4CYKc4p2iYu2u7i/?=
 =?us-ascii?Q?n/xV9bAznb2sfAB9LOJqvCleDul24nmvJHpafYcynFtPMFzgqqyBbNbko09f?=
 =?us-ascii?Q?13CBW6hpyCLocDP4f0/HKcBwh6fGUQWMsfDpYKuKacTyWD6pvcrCCYRv9UW7?=
 =?us-ascii?Q?Obz2H2N2XQeUiLk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:11.0370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781e0938-de5a-4b14-15c4-08dd2f302cb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
BIOS table will not always contain accurate UMC channel info when
harvesting is enabled, so get the correct info from SMU.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn401/dalsmc.h    |  4 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  9 ++++
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   | 14 +++++
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |  1 +
 .../dc/dml2/dml21/dml21_translation_helper.c  |  9 +++-
 .../dc/resource/dcn401/dcn401_resource.c      | 54 +++++++++++--------
 6 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dalsmc.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dalsmc.h
index dbfdd3487da5..2e0d34fd7512 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dalsmc.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dalsmc.h
@@ -43,7 +43,9 @@
 #define DALSMC_MSG_ActiveUclkFclk                 0x18
 #define DALSMC_MSG_IdleUclkFclk                   0x19
 #define DALSMC_MSG_SetUclkPstateAllow             0x1A
-#define DALSMC_Message_Count                      0x1B
+#define DALSMC_MSG_SubvpUclkFclk                  0x1B
+#define DALSMC_MSG_GetNumUmcChannels              0x1C
+#define DALSMC_Message_Count                      0x1D
 
 typedef enum {
   FCLK_SWITCH_DISALLOW,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 204ebdd99415..8082bb877611 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -1403,6 +1403,15 @@ static void dcn401_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 	if (clk_mgr->dpm_present && !num_levels)
 		clk_mgr->dpm_present = false;
 
+	clk_mgr_base->bw_params->num_channels = dcn401_smu_get_num_of_umc_channels(clk_mgr);
+	if (clk_mgr_base->ctx->dc_bios) {
+		/* use BIOS values if none provided by PMFW */
+		if (clk_mgr_base->bw_params->num_channels == 0) {
+			clk_mgr_base->bw_params->num_channels = clk_mgr_base->ctx->dc_bios->vram_info.num_chans;
+		}
+		clk_mgr_base->bw_params->dram_channel_width_bytes = clk_mgr_base->ctx->dc_bios->vram_info.dram_channel_width_bytes;
+	}
+
 	/* Refresh bounding box */
 	clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
 			clk_mgr->base.ctx->dc, clk_mgr_base->bw_params);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
index b02a41179b41..21c35528f61f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
@@ -25,6 +25,9 @@
 #ifndef DALSMC_MSG_SubvpUclkFclk
 #define DALSMC_MSG_SubvpUclkFclk 0x1B
 #endif
+#ifndef DALSMC_MSG_GetNumUmcChannels
+#define DALSMC_MSG_GetNumUmcChannels 0x1C
+#endif
 
 /*
  * Function to be used instead of REG_WAIT macro because the wait ends when
@@ -334,3 +337,14 @@ void dcn401_smu_set_num_of_displays(struct clk_mgr_internal *clk_mgr, uint32_t n
 	dcn401_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_NumOfDisplays, num_displays, NULL);
 }
+
+unsigned int dcn401_smu_get_num_of_umc_channels(struct clk_mgr_internal *clk_mgr)
+{
+	unsigned int response = 0;
+
+	dcn401_smu_send_msg_with_param(clk_mgr, DALSMC_MSG_GetNumUmcChannels, 0, &response);
+
+	smu_print("SMU Get Num UMC Channels: num_umc_channels = %d\n", response);
+
+	return response;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
index 42cf7885a7cb..e02eb1294b37 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
@@ -28,5 +28,6 @@ bool dcn401_smu_set_subvp_uclk_fclk_hardmin(struct clk_mgr_internal *clk_mgr,
 		uint16_t fclk_freq_mhz);
 void dcn401_smu_set_min_deep_sleep_dcef_clk(struct clk_mgr_internal *clk_mgr, uint32_t freq_mhz);
 void dcn401_smu_set_num_of_displays(struct clk_mgr_internal *clk_mgr, uint32_t num_displays);
+unsigned int dcn401_smu_get_num_of_umc_channels(struct clk_mgr_internal *clk_mgr);
 
 #endif /* __DCN401_CLK_MGR_SMU_MSG_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 5d46f4e24f6b..b9c6b45f6872 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -294,12 +294,17 @@ void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_in
 		dml_soc_bb->power_management_parameters.stutter_exit_latency_us =
 			(in_dc->ctx->dc_bios->bb_info.dram_sr_exit_latency_100ns + 9) / 10;
 
-	if (in_dc->ctx->dc_bios->vram_info.num_chans) {
+	if (dc_bw_params->num_channels) {
+		dml_clk_table->dram_config.channel_count = dc_bw_params->num_channels;
+		dml_soc_bb->mall_allocated_for_dcn_mbytes = in_dc->caps.mall_size_total / 1048576;
+	} else if (in_dc->ctx->dc_bios->vram_info.num_chans) {
 		dml_clk_table->dram_config.channel_count = in_dc->ctx->dc_bios->vram_info.num_chans;
 		dml_soc_bb->mall_allocated_for_dcn_mbytes = in_dc->caps.mall_size_total / 1048576;
 	}
 
-	if (in_dc->ctx->dc_bios->vram_info.dram_channel_width_bytes) {
+	if (dc_bw_params->dram_channel_width_bytes) {
+		dml_clk_table->dram_config.channel_width_bytes = dc_bw_params->dram_channel_width_bytes;
+	} else if (in_dc->ctx->dc_bios->vram_info.dram_channel_width_bytes) {
 		dml_clk_table->dram_config.channel_width_bytes = in_dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 0767adaa6389..c1ebc6b1c937 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1297,6 +1297,29 @@ static struct hpo_dp_link_encoder *dcn401_hpo_dp_link_encoder_create(
 	return &hpo_dp_enc31->base;
 }
 
+static unsigned int dcn401_calc_num_avail_chans_for_mall(struct dc *dc, unsigned int num_chans)
+{
+	unsigned int num_available_chans = 1;
+
+	/* channels for MALL must be a power of 2 */
+	while (num_chans > 1) {
+		num_available_chans = (num_available_chans << 1);
+		num_chans = (num_chans >> 1);
+	}
+
+	/* cannot be odd */
+	num_available_chans &= ~1;
+
+	/* clamp to max available channels for MALL per ASIC */
+	if (ASICREV_IS_GC_12_0_0_A0(dc->ctx->asic_id.hw_internal_rev)) {
+		num_available_chans = num_available_chans > 16 ? 16 : num_available_chans;
+	} else if (ASICREV_IS_GC_12_0_1_A0(dc->ctx->asic_id.hw_internal_rev)) {
+		num_available_chans = num_available_chans > 8 ? 8 : num_available_chans;
+	}
+
+	return num_available_chans;
+}
+
 static struct dce_hwseq *dcn401_hwseq_create(
 	struct dc_context *ctx)
 {
@@ -1592,6 +1615,14 @@ static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 
 	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
 
+	/* re-calculate the available MALL size if required */
+	if (bw_params->num_channels > 0) {
+		dc->caps.max_cab_allocation_bytes = dcn401_calc_num_avail_chans_for_mall(
+			dc, bw_params->num_channels) *
+			dc->caps.mall_size_per_mem_channel * 1024 * 1024;
+		dc->caps.mall_size_total = dc->caps.max_cab_allocation_bytes;
+	}
+
 	DC_FP_START();
 
 	dcn401_update_bw_bounding_box_fpu(dc, bw_params);
@@ -1714,29 +1745,6 @@ static unsigned int dcn401_get_vstartup_for_pipe(struct pipe_ctx *pipe_ctx)
 	return pipe_ctx->global_sync.dcn4x.vstartup_lines;
 }
 
-static unsigned int dcn401_calc_num_avail_chans_for_mall(struct dc *dc, unsigned int num_chans)
-{
-	unsigned int num_available_chans = 1;
-
-	/* channels for MALL must be a power of 2 */
-	while (num_chans > 1) {
-		num_available_chans = (num_available_chans << 1);
-		num_chans = (num_chans >> 1);
-	}
-
-	/* cannot be odd */
-	num_available_chans &= ~1;
-
-	/* clamp to max available channels for MALL per ASIC */
-	if (ASICREV_IS_GC_12_0_0_A0(dc->ctx->asic_id.hw_internal_rev)) {
-		num_available_chans = num_available_chans > 16 ? 16 : num_available_chans;
-	} else if (ASICREV_IS_GC_12_0_1_A0(dc->ctx->asic_id.hw_internal_rev)) {
-		num_available_chans = num_available_chans > 8 ? 8 : num_available_chans;
-	}
-
-	return num_available_chans;
-}
-
 static struct resource_funcs dcn401_res_pool_funcs = {
 	.destroy = dcn401_destroy_resource_pool,
 	.link_enc_create = dcn401_link_encoder_create,
-- 
2.34.1

