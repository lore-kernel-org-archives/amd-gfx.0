Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1983BCCFA1C
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7F810E700;
	Wed,  5 Nov 2025 15:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xPgkYZy1";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013056.outbound.protection.outlook.com
 [40.107.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C24110E2D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPk4KiBjl07R8s3xh9NxBmwwt1J2CVfRBjN3+5511XMz0mmxTlHSOumCkXwBUQe5O4nqaCfzfs0thM+fB/mAZrWODzU8c3tSHNZkSGt3ZC8jvuDdW6TqNCwSybs3sA+u6DVO+5QsmGtKaqrD24adObfiVVrV2DqhQJhGoROB6Xb5t0HMIBMc093e3Fov6FhOkG1iUVGsiNBmnJDd6sjo5kw4SyWFDVJgryvoxJbhlSGQEUm1P3WljH3geTu3Lrcd/j6oVHAmdMmEuCKv5BxM17x8ieaZ2y3bpo1pXPFurN1TCvTBooEswLPLk0iZJVs5vx44KJZ1E+TDbT6Q8f9Jpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TTyg/5deR6agk/bg67mTr9UmkkLAu2ub401sCPdUfE=;
 b=JCauyhfmKAqs9SeWI0XJ8W+iiFy1khPdIo6pYPTMhzFinrxu7+c/T6OUr+HeL1izp0c52E38nE6uXhGKCCg7qivrdXeqpGoRuj4poMEI+Ft7b+t4a8Wu/B9N3b7sjVaKEteBi7Z1/iJPXaVXo1nR339VBUrFuzukxnUZb2KZnVkxFXnpYXZHmYeuQ62mxG5vvIl0Ju5pfxO58lvPXc+iZpjytfJ4rKgC5WSGBl+tW9h+FTKH2PKVxCkHVR38muVgF85tVCCkKDfsOwVUiLzby+R0sEhq3IwAcG1w8Rg6IxVVXNkNNDMXbGReUe7g/BgENhZ7MufEtWOYOnYdcAJUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TTyg/5deR6agk/bg67mTr9UmkkLAu2ub401sCPdUfE=;
 b=xPgkYZy1mG7G334u+fQtDf+moQ7UGtbJSf4mQnXTVniuoAJ9TAyqWTXKFo/p1/uY46t/sNYzQVjw+t2LbqkCkBXCJhAQvyFmErr6GfmnkTdFP7JY9zkgsXM9J73bv8aqIYR7BoeBuSLk7DKpGej8o7kYFxdT2vtaroRtxYmfpkk=
Received: from BN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:ee::18)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 15:41:04 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::de) by BN0PR04CA0013.outlook.office365.com
 (2603:10b6:408:ee::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 15:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:41:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:54 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Nov
 2025 09:40:54 -0600
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:53 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mohit Bawa <Mohit.Bawa@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Charlene Liu <charlene.liu@amd.com>, "Wenjing
 Liu" <wenjing.liu@amd.com>
Subject: [PATCH 06/13] drm/amd/display: refactor DSC cap calculation for dcn35
Date: Wed, 5 Nov 2025 10:36:21 -0500
Message-ID: <20251105154035.883188-7-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154035.883188-1-Jerry.Zuo@amd.com>
References: <20251105154035.883188-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: cae369ed-58ba-4422-8aa4-08de1c81ba8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5V9uaIhJkXIPoAuN1QW49cw5qPxe8qpKXmdDS5/OXbTWd67t7CLi4SnLeXAv?=
 =?us-ascii?Q?bXHqps49Gos5nro4i3wsIlzIdt9KgJSJLewKIerwoqf51iXCp7gb7/pTlK1h?=
 =?us-ascii?Q?0TRzN6VN9piMZzG82bejEdaxewxQBazpgtxiSzZbOoeVEmBkw5aK83EYUeuk?=
 =?us-ascii?Q?lVsbtGdZCmjQCt0zEQyIt+CC9iuSIyY3BLxjvmp3uGULW8i0SUBNF+VObAJr?=
 =?us-ascii?Q?AG8stlMzQ1HyfAwLHe6iknDCTZ6bnLKSOvsPqVhSQpBfl16DJBq2NkULsE/1?=
 =?us-ascii?Q?oEPm1NEsfXvxWpyqE+etrCLlcGbwAF9sG/Ph6RU1zD4Xc+Gy4xdAZDsCmNRY?=
 =?us-ascii?Q?FIr5KxABL4QXCXSx4ar95Mg3LGKGIo4w+uxPK6sA4GPDwaVMNQyqXS0uud2s?=
 =?us-ascii?Q?yV71gNjdtE4xoARDpRvqnSfi9JIwYlfmQ80PpnNq7PfKt9Akf+75F+6kj8gJ?=
 =?us-ascii?Q?rsQdvIW3jFt1aoXN4WcRDsQTdzNSnk5R/Tr+xA7SRPRU29bHGC/OeFvC1x/H?=
 =?us-ascii?Q?dgn/VUluDgF+l3SlFtV0M4vf0F7NjLXXYhZ8ASPJvQ2qllcDRw02jFQYOh4n?=
 =?us-ascii?Q?+C65AwcTs9cGM/LUZNtYF7FQ/y1tNm5BBJdK07IqltGwR4tF5scGGQF60Zq1?=
 =?us-ascii?Q?gBVTHtiRIfcLQpxmeUJpIlTBTlCUjY7eZ+Xg0a1D3KSqpHI0BsnZdyn4sRAK?=
 =?us-ascii?Q?Kguq9g1KtRtsQpO8kW26gd+JkJ8wUxyEZCsIPw6xbFFjnDav8pbbnoQJtJD2?=
 =?us-ascii?Q?pjlD7m+yV3kSq3nhYc5uHL75jBuCkh1OPRZHCFOfPvK+RX3XZr6a139lIX8y?=
 =?us-ascii?Q?wBWmkkk0kz5mG0ZNzUqQhemj9azMbUlVagegjwb9SP5ZA/l+K9zZ/54Fst7D?=
 =?us-ascii?Q?3Xc16+GKLEOWDQ2Bdktc5RrfBn0BopGdwKcq3GJNmLH3waKHxnwl6R0X6eaL?=
 =?us-ascii?Q?jc54yYOYQgngNbzMntKXF95US41JUGOnocym2xasgAQyI7xzwJ6hNhpUwjyF?=
 =?us-ascii?Q?VXJ4uFnrjKLjuqgp31LQMdLxeIRGhso4Bssedrw3qm9RiZkW2Gd4sEO1lG1a?=
 =?us-ascii?Q?hP0lUTudUencVbn/RIbS6R2DKRlb0NA5aShXrzV6UKbFqVwkcVkLm9tBc+EQ?=
 =?us-ascii?Q?4vtf/ykI4wnmd+2JePebjN2f0xUjkJWpoQg3l+sj+ey6llUOisANtaawa2+Q?=
 =?us-ascii?Q?80MVYbfqEP7vRrw4z9ke+rvME1tFnjv7Jca2a5XRo9O6g4w/nnubARze1ues?=
 =?us-ascii?Q?Br0E4zfYNdoGoTcKvQDCpnHFjC5piZGmJuNhx0kwKG8BoJ6NwLW1r6fZQvYH?=
 =?us-ascii?Q?0nfqauY3sQs8farxliIwFP+73vq57OonuFhW2DNh2a9mYhM9djPslWH/3KTh?=
 =?us-ascii?Q?Sv/Ep2q9EAZBna9w8Uxpd2buS4ZmEItzREKL1/1NXAGelBwsnEIBJX4bXCxZ?=
 =?us-ascii?Q?c9yG3DkL2el7izcNhiYFQxPoqIlx0NZSx5n/DISRc8WMHzESsXTUC03WD8Bf?=
 =?us-ascii?Q?eWNOLmiFvy+aKgLgbeZyu86DqTjtu/LYWTHrv6zUKya6D/GHFgsroQ0PMDKo?=
 =?us-ascii?Q?l21YIB4lhoONr1QyugE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:41:03.8971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cae369ed-58ba-4422-8aa4-08de1c81ba8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
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

From: Mohit Bawa <Mohit.Bawa@amd.com>

why:
dcn35 currently uses a hardcoded DSC display clock value which is incorrect
for some asic types. Newer DCN versions retrieve dsc display clock from
clk_mgr. The same can be done for dcn35.

how:
Refactor the DSC cap calculation using pre-existing logic.
Handle ODM combine requirements in dc_dsc.c.
Replace hardcoded display clock with actual value retrieved from clk_mgr.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Mohit Bawa <Mohit.Bawa@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 30 ++++++++++++++++++
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  | 31 ++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 35d20a663d67..dfd0c9505af0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -1295,6 +1295,35 @@ static void dcn35_update_clocks_fpga(struct clk_mgr *clk_mgr,
 	dcn35_update_clocks_update_dtb_dto(clk_mgr_int, context, clk_mgr->clks.ref_dtbclk_khz);
 }
 
+static unsigned int dcn35_get_max_clock_khz(struct clk_mgr *clk_mgr_base, enum clk_type clk_type)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	unsigned int num_clk_levels;
+
+	switch (clk_type) {
+	case CLK_TYPE_DISPCLK:
+		num_clk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_dispclk_levels;
+		return num_clk_levels ?
+				clk_mgr->base.bw_params->clk_table.entries[num_clk_levels - 1].dispclk_mhz * 1000 :
+				clk_mgr->base.boot_snapshot.dispclk;
+	case CLK_TYPE_DPPCLK:
+		num_clk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_dppclk_levels;
+		return num_clk_levels ?
+				clk_mgr->base.bw_params->clk_table.entries[num_clk_levels - 1].dppclk_mhz * 1000 :
+				clk_mgr->base.boot_snapshot.dppclk;
+	case CLK_TYPE_DSCCLK:
+		num_clk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_dispclk_levels;
+		return num_clk_levels ?
+				clk_mgr->base.bw_params->clk_table.entries[num_clk_levels - 1].dispclk_mhz * 1000 / 3 :
+				clk_mgr->base.boot_snapshot.dispclk / 3;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static struct clk_mgr_funcs dcn35_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
@@ -1306,6 +1335,7 @@ static struct clk_mgr_funcs dcn35_funcs = {
 	.set_low_power_state = dcn35_set_low_power_state,
 	.exit_low_power_state = dcn35_exit_low_power_state,
 	.is_ips_supported = dcn35_is_ips_supported,
+	.get_max_clock_khz = dcn35_get_max_clock_khz,
 };
 
 struct clk_mgr_funcs dcn35_fpga_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
index f9c6377ac66c..e712985f7abd 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
@@ -28,9 +28,9 @@
 #include "reg_helper.h"
 
 static void dsc35_enable(struct display_stream_compressor *dsc, int opp_pipe);
+static void dsc35_get_single_enc_caps(struct dsc_enc_caps *dsc_enc_caps, unsigned int max_dscclk_khz);
 
 static const struct dsc_funcs dcn35_dsc_funcs = {
-	.dsc_get_enc_caps = dsc2_get_enc_caps,
 	.dsc_read_state = dsc2_read_state,
 	.dsc_read_reg_state = dsc2_read_reg_state,
 	.dsc_validate_stream = dsc2_validate_stream,
@@ -40,6 +40,7 @@ static const struct dsc_funcs dcn35_dsc_funcs = {
 	.dsc_disable = dsc2_disable,
 	.dsc_disconnect = dsc2_disconnect,
 	.dsc_wait_disconnect_pending_clear = dsc2_wait_disconnect_pending_clear,
+	.dsc_get_single_enc_caps = dsc35_get_single_enc_caps,
 };
 
 /* Macro definitios for REG_SET macros*/
@@ -111,3 +112,31 @@ void dsc35_set_fgcg(struct dcn20_dsc *dsc20, bool enable)
 {
 	REG_UPDATE(DSC_TOP_CONTROL, DSC_FGCG_REP_DIS, !enable);
 }
+
+void dsc35_get_single_enc_caps(struct dsc_enc_caps *dsc_enc_caps, unsigned int max_dscclk_khz)
+{
+	dsc_enc_caps->dsc_version = 0x21; /* v1.2 - DP spec defined it in reverse order and we kept it */
+
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_1 = 1;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_2 = 1;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_3 = 1;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_4 = 1;
+
+	dsc_enc_caps->lb_bit_depth = 13;
+	dsc_enc_caps->is_block_pred_supported = true;
+
+	dsc_enc_caps->color_formats.bits.RGB = 1;
+	dsc_enc_caps->color_formats.bits.YCBCR_444 = 1;
+	dsc_enc_caps->color_formats.bits.YCBCR_SIMPLE_422 = 1;
+	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 0;
+	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_420 = 1;
+
+	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
+	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_10_BPC = 1;
+	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_12_BPC = 1;
+
+	dsc_enc_caps->max_total_throughput_mps = max_dscclk_khz * 3 / 1000;
+
+	dsc_enc_caps->max_slice_width = 5184; /* (including 64 overlap pixels for eDP MSO mode) */
+	dsc_enc_caps->bpp_increment_div = 16; /* 1/16th of a bit */
+}
-- 
2.43.0

