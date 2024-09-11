Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A402EEE57C0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A42F10EA53;
	Wed, 11 Sep 2024 16:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jot3hGzO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7654A10EA53
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dujOt8lPFmeKq5Hdxh+7KdWrx3GWQeZ9kQS53aquCn15VlZzODU7fRuGhcxJ5XXUdGMON2s2xZGhDm+8JbwAUZZPnbwePKhfnjMMlWeTe/lHDPmdAJfQmi+qU479vJPseimahIriB30XaytSydUhDY9P10Y2tDoUJLjcZGZq7t9k2bcca8HK/xCOkCG6mOu7m+/45LGMXKzkzApuKcGNroom5bkxWn/Tmg5Lk8TQc/DuXK/2As2h84hRucGUpb8axWo/Rp6SGiAw4Li4IlsLql3GwV4yEIK7ss0m0B7++PQwLJfkHCIvqDoPNff/PzAKTJ6QqmnH8/9s/mfMOSgKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyTrshQWtGskjwkP5qINJYh8LkbEnVtxcxLvDzty2Gc=;
 b=p7Ma9Ms8j+AoiQslIMPZqjrOStwjBCrFxsPMF13XbNR3L3WJt+z9Fy52RkeD3L6TbqJcT5+/tKlu/RCCCBLEJIBf5jiUFDu8XhKMCOwHzxJUjJniFHLU4gcSaXj7YUwcUTJ7LhoFDxd40ldcNzittPvwYLxyEOyK+jV/oxA2JpJ20BqHsg0994IrfVGSUo754t4+5O2x0CCQHK8LNcyrICvygMxE87yCS7muMmfovBfyLexmvgVj/3WgLzPGRwVSlMigbBtLA835bfNLQfb6wb/J8E82O5VEqag0YziDD7uBcMGGzRYGxcGYA+HzKCoPZY6dkz9rONW3lSg1vOvH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyTrshQWtGskjwkP5qINJYh8LkbEnVtxcxLvDzty2Gc=;
 b=Jot3hGzO/jz8fY0MicSoylVmb6kfRNEa91Qcean3RpBdHBVI9+LwpyHuNmWVdShWXNQBQKl5mX/en5okRKjzzSiCJs5N8jV64KEDI7K+uVe4H+EWdZb80n8Sy9CkZ0KN/+4T7yoILEe6XJbXLgsh8r7zFjUGm7qvqVqD7S3gwzs=
Received: from BN9PR03CA0922.namprd03.prod.outlook.com (2603:10b6:408:107::27)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Wed, 11 Sep
 2024 16:23:57 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::ca) by BN9PR03CA0922.outlook.office365.com
 (2603:10b6:408:107::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 16:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:23:57 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:23:54 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Martin Tsai <martin.tsai@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Charlene Liu
 <charlene.liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 10/23] drm/amd/display: Clean up dsc blocks in accelerated mode
Date: Wed, 11 Sep 2024 10:20:52 -0600
Message-ID: <20240911162105.3567133-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: cdadee50-bd22-4cf1-0517-08dcd27e22e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3V6JHqJ4C38WupFWBoN24qRMr6vzuwdC0C5zpxWws27s/NWKK5G5DFFcJcjN?=
 =?us-ascii?Q?xSVWPXbofIv0jbn1wvsnYSJjR//OD3xLMMQJ+DyKnihf79wuU47F+wKgBQVG?=
 =?us-ascii?Q?hkN51xdDbzNAwyJvtAw7HiWHJ/Y8ZE5leUyfpZxtOVWcYIxferyPe6MkCKGq?=
 =?us-ascii?Q?kvZWPh24bncMbY7caUZoImESdqKCSI6jezaMkp3Jd65hxv/9ojtzNE2MAb34?=
 =?us-ascii?Q?J40Npvo6QH2J2/pdLTSsHiKS5gNUkPaeM6HU7slDVUqQ8FxyDgo9CaIAkw1Y?=
 =?us-ascii?Q?q0vrcKSOwPUhNM+xgcWlPnicoWSaL2P5WTDUDBfDClS7WU2AxGna9qxNh4FI?=
 =?us-ascii?Q?wIbTtTJlLsCriRQL8E6pveeCWcLAJyokm5jvudSwoREj9y1C9WzN/WiBCEHo?=
 =?us-ascii?Q?ppBsuoJCdGDrRuiZRR5KDYMwupLVeWF4HRz5Y7IKowYo94u4xRIfEz+Xzu72?=
 =?us-ascii?Q?YEBKUwjagH04BfkEs8T1BTaXUK8aFxal/LDCCBB/xqz3Cn9xkwo3VVIAOmyP?=
 =?us-ascii?Q?1PJJOEYalZRgtcLUNNZj2VfXdDh+RhN5t2h1nupbmSiNxy3/vf7bnN1ed69n?=
 =?us-ascii?Q?Mt0qWsFjraguwO448PbSxCcxbmNq7Sfv3Ro/Y/yGzfPrB8vjZHnA5QCgxAzQ?=
 =?us-ascii?Q?siSslvjIoRzt9QySD4SaaqGWCxPoowsRfs3UyPkVHPXjaaYz2g6HJxwLHFft?=
 =?us-ascii?Q?bJCIfx+nowt2oZ6Qp/p8Vau+z56L0UcsFfD4+a1yO+xW+V5QOh7G92VXrRiM?=
 =?us-ascii?Q?TcrsFwIj6zk1UxDHAd35srmjvvKe8Vgld+T6EHI7egtIhzih50CUCUHyIEdW?=
 =?us-ascii?Q?ofL4Wc4PdizucWRA7DIBXqlWRg/RHhiWczUTUHaMd4K3jhys2++gbDPCLKzD?=
 =?us-ascii?Q?BXutfc9qYQ2glEclFLW9h2TbOhcTSep8Jon0tUlXLIp/vTawx7QAZ+F4JW3G?=
 =?us-ascii?Q?iEHqN1MGcxLZ+d7cRymqpMed7FI2JVpCrTOA+EB7b1Cr6pBTEyv2GEX7fuDl?=
 =?us-ascii?Q?nJ5AYs9rxFZf9ROso4iUCwQMWBCPTA8h3W4HFAmdsvBnQc+y3tEUuyCvvjf6?=
 =?us-ascii?Q?QOzQos+OWiftduAHI/THYchUGxeU7FCscfOu0hbdgOPxbqwkIIQkHvec1z6h?=
 =?us-ascii?Q?CauQh0OnRfbpLvwrZ5IhVB46Qu94Yl7NRSn3sTnq35S91nxfQQcTXFrgwLoB?=
 =?us-ascii?Q?r3jCJeRhpqA91EkME5SAi3ZCBVPnjn8RNFzlreIAcZxawNUqI0cfr3qTo3x6?=
 =?us-ascii?Q?R8pZiFgkLBK/gw7Zkio9iUakrWWPZ6Kbi32kMkBPIzorFpQKcYdyJQmR4Q3i?=
 =?us-ascii?Q?F16DPno4FWbdGwEoH73dn57/bRuLxW/0nKqSKKJAtJCpgJ/5pd8SsTs1MO0r?=
 =?us-ascii?Q?FW1uGkG5TWdxD0Ga1yRbCPrxOWKlSTsW/Vuq8Y6RF0UQIFemXvauGKEJ0Vy+?=
 =?us-ascii?Q?m+BP42qpq2jc7tUZRAXQPVljwao6z906?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:23:57.1936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdadee50-bd22-4cf1-0517-08dcd27e22e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
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

From: Martin Tsai <martin.tsai@amd.com>

[WHY]
DSC on eDP could be enabled during VBIOS post. The enabled
DSC may not be disabled when enter to OS, once the system was
in second screen only mode before entering to S4. In this
case, OS will not send setTimings to reset eDP path again.

The enabled DSC HW will make a new stream without DSC cannot
output normally if it reused this pipe with enabled DSC.

[HOW]
In accelerated mode, to clean up DSC blocks if eDP is on link
but not active when we are not in fast boot and seamless boot.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index d52ce58c6a98..aa7479b31898 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -57,6 +57,7 @@
 #include "panel_cntl.h"
 #include "dc_state_priv.h"
 #include "dpcd_defs.h"
+#include "dsc.h"
 /* include DCE11 register header files */
 #include "dce/dce_11_0_d.h"
 #include "dce/dce_11_0_sh_mask.h"
@@ -1823,6 +1824,48 @@ static void get_edp_links_with_sink(
 	}
 }
 
+static void clean_up_dsc_blocks(struct dc *dc)
+{
+	struct display_stream_compressor *dsc = NULL;
+	struct timing_generator *tg = NULL;
+	struct stream_encoder *se = NULL;
+	struct dccg *dccg = dc->res_pool->dccg;
+	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
+	int i;
+
+	if (dc->ctx->dce_version != DCN_VERSION_3_5 &&
+		dc->ctx->dce_version != DCN_VERSION_3_51)
+		return;
+
+	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+		struct dcn_dsc_state s  = {0};
+
+		dsc = dc->res_pool->dscs[i];
+		dsc->funcs->dsc_read_state(dsc, &s);
+		if (s.dsc_fw_en) {
+			/* disable DSC in OPTC */
+			if (i < dc->res_pool->timing_generator_count) {
+				tg = dc->res_pool->timing_generators[i];
+				tg->funcs->set_dsc_config(tg, OPTC_DSC_DISABLED, 0, 0);
+			}
+			/* disable DSC in stream encoder */
+			if (i < dc->res_pool->stream_enc_count) {
+				se = dc->res_pool->stream_enc[i];
+				se->funcs->dp_set_dsc_config(se, OPTC_DSC_DISABLED, 0, 0);
+				se->funcs->dp_set_dsc_pps_info_packet(se, false, NULL, true);
+			}
+			/* disable DSC block */
+			if (dccg->funcs->set_ref_dscclk)
+				dccg->funcs->set_ref_dscclk(dccg, dsc->inst);
+			dsc->funcs->dsc_disable(dsc);
+
+			/* power down DSC */
+			if (pg_cntl != NULL)
+				pg_cntl->funcs->dsc_pg_control(pg_cntl, dsc->inst, false);
+		}
+	}
+}
+
 /*
  * When ASIC goes from VBIOS/VGA mode to driver/accelerated mode we need:
  *  1. Power down all DC HW blocks
@@ -1927,6 +1970,13 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
 
 		power_down_all_hw_blocks(dc);
+
+		/* DSC could be enabled on eDP during VBIOS post.
+		 * To clean up dsc blocks if eDP is in link but not active.
+		 */
+		if (edp_link_with_sink && (edp_stream_num == 0))
+			clean_up_dsc_blocks(dc);
+
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);
-- 
2.34.1

