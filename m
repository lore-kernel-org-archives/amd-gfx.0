Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511B0C07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36B910FE25;
	Wed, 24 Apr 2024 08:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yxHH4N6x";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689BF10FE1A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5iJZvrj1w0Pgvx0+TSfm49l5CkEiZCyI2GQzH3YN3ADwYIFJmtc2WdgXg5OwjG4PkeSObjcW6fPA+VQ94RUrodF5v6oY0u7VOs3qC6ieh5SScd0EEhTABErnfvph89hEOZIquOHCGxzIBGtAlD0CV5ounUQLDjpNbSGxk2LzE/Zhf34UsmWIQUvx5klE0Zda75sEoHwpbMeMPkE7RTYGwrwut9VizdlcoXQGDlPXLx1saE/SKZ/5G722ODwz9Dm6RBfc4QS3jkGE0zWPEbUgRB0l50MHrfoVMjEHIEghhvWkdVo/B7xYSWqD3X2DydKwPnnoeaRNQKfKYJOdJVCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwZTmgI9flL0dLckiwSLgUUUvXOgrTjqj/uDRa5oQTA=;
 b=mKFOoAIjp4zc400Imp4fJ56OYqoanTQOOmBU8aJJ9FMcLY/JkyphJzLn0MGhuo0nx88at0+AYtOwGSIH+uaOOQ/JYYJ0qa+7jfsLfwS0VSnEaxnzQDZxOKUQuyO9Ui8R4qNv7yb5TuwmYhrG+QS6sjffvrQ7q24dXShZZtFf4j4Bb3awHyTPb2PH/4HP5KKmVtnXC118lvTdI0wKVRraDO5r1FCmFZ5HjXBbvY4H9/Md2g5prP9rzQNt6lWDphTYQkD2r6Nl0skj4vL3HEgjgpD4sdXHmyFhllOCaID9l2vfXw4TbOUDcsG+XxbGmM15EKr7y328Mt/E+EK8PJZECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwZTmgI9flL0dLckiwSLgUUUvXOgrTjqj/uDRa5oQTA=;
 b=yxHH4N6xie5uu19qhGEcOISLK81yGdF0t6kiEdY/X0BLrbNNYc3FJGAUkW21SR/+j89I5dYaoDsP7uavc2OLA+mJNWxb0/kNWL6yCNo4GQ4dbJ+4W6TTKUZ8m6GO+hZHQWAV7GOO2DRPkZ8R2sz+v/Irf49XmOpzbrGWILxFnqU=
Received: from BN6PR17CA0055.namprd17.prod.outlook.com (2603:10b6:405:75::44)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 08:53:02 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:405:75:cafe::bd) by BN6PR17CA0055.outlook.office365.com
 (2603:10b6:405:75::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 08:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:53:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:00 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:52:56 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Webb Chen <yi-lchen@amd.com>,
 Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 29/46] drm/amd/display: Revert "dc: Keep VBios pixel rate div
 setting util next mode set"
Date: Wed, 24 Apr 2024 16:49:14 +0800
Message-ID: <20240424084931.2656128-30-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 98efeab8-addc-4684-5554-08dc643bf2b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0wJWBS72lXLN8cV0KoDCX7C54VtQAOtGcK1gEnxpJIVYzGv1V/8DQZDXR174?=
 =?us-ascii?Q?kyydXk5QVePj58Xs+DSDHZ9t07OmjkSANOx8GllPQVmKcBe3DQOOhHkGd0RH?=
 =?us-ascii?Q?LZLO15LVbenoiY/80jTFy5hvIsJnv+FBJDL1u9ikmrFWFDMHYViY7urhyO3r?=
 =?us-ascii?Q?5fpHNXkSJ2/tZUqO2UiLKH/eQVHsYlBgYsn5HjO0ShZ2M6O3d/S6OleheQ1I?=
 =?us-ascii?Q?y3TQu6I7gIXp3a7sW6JRjpFMkNBU8RYhEgADLlKRX7s9EJd/LOEPvrtzMYXs?=
 =?us-ascii?Q?WE6XmViRwxBGZnT1+BJr8JNlxBnwxYCoUYbWGIU8BqHjfAqU1kECbmLIHUbB?=
 =?us-ascii?Q?YNuk9PtHn/psUwFAHAv01H+tTkHSVxRpdcoL2rpMM2EfcmSasE2eb0udfqcu?=
 =?us-ascii?Q?FqbsRjpE6M/AcNF9EmwzxFe6IDciSgfZIaNTcMoLodlEeyvZGCMWqElLOeH0?=
 =?us-ascii?Q?jX2Xoe/1tTvv2qq93nWP6zi0XKGGK7gbcxmfuEGmOa5Iw3oygdEbAdgUQN2D?=
 =?us-ascii?Q?pRqMZ44XoEEUtz7o3F1hdO22H5Rpl6X75IMrLX1bJ+a6Y8G8osUYQilwNP+k?=
 =?us-ascii?Q?O4L1FhRAVNvgvQwEeteKxpNtory2+utXQrxZmGG+Xy0K1wDD8tL7H5ixoxUh?=
 =?us-ascii?Q?XV3hTEzouAJnhmpTVgCFDlTWfZRAXbuIpP8K1oium8vwVAQB97dq1oiQOc5A?=
 =?us-ascii?Q?vgsJZJO9fdVn+OznnYpiKdFRVEQKHT/+Om3QhKQIdO7SZAcdiccUdgTzUacn?=
 =?us-ascii?Q?kFciYWTfzUDv0a9+MfgQ3HegHthY3lj5S8C+U5UBmjBADfN9jiZspwmeOtyl?=
 =?us-ascii?Q?R8hLhum/NnnwsLDj9A7Mp/DOIc7eriSFkDC7CisBtis9UJcDyPY8hDuUR4tX?=
 =?us-ascii?Q?5jBZ95G7PvwBG5A0e2gGrBZon04y17uKFQIeVf7HD4xxmH5NDJOUChzKdqpc?=
 =?us-ascii?Q?H44/dZFjn25WdEIP5JhnTUB5MfmXSx4GhknXSHVoOYII1KiwDU/fLQGn7sd9?=
 =?us-ascii?Q?i0adHZCi57gisJKCqMq0ot6ls8I8aAyol5sOC+VvxfW6VcPao+FpGSq/bORx?=
 =?us-ascii?Q?9D8exCC5NNfZ3tAlPMn3b6i3CJmVijdLVBaATm9YZLbUIz0KKHa8EiQMjMBc?=
 =?us-ascii?Q?iEonjMx/ad9DDJpPWR3Lilz4JfHgQIQ7tXWu2+q1eQQJftOJzuNvgGTuGC5U?=
 =?us-ascii?Q?gYshGCfh661rLQB6LhXFHuphviSO5o88zMRHB+7HwBwJ9B3sW7LX0W91G3Ob?=
 =?us-ascii?Q?5sej2i8hxloOVcBfVkODePrxSOnVxwkLIxP8TmW1nwme5/hzdKPOGXCVt2bp?=
 =?us-ascii?Q?+TXVLGhScn1da7nCaf2zZIkulce2cYIsLjSYHGsE4pYHMGRQCBkXV4Js5RQ/?=
 =?us-ascii?Q?F8+QbXjIuCRLOU6OJtBlSTlIYrLT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:53:01.6855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98efeab8-addc-4684-5554-08dc643bf2b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

From: Webb Chen <yi-lchen@amd.com>

This reverts commit f7131558f362 ("drm/amd/display: Keep VBios pixel rate div
setting util next mode set") which causes issue.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Webb Chen <yi-lchen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  4 --
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   | 12 +++--
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 12 +++--
 .../dc/dcn32/dcn32_dio_stream_encoder.c       | 40 +++++++++++++++--
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |  8 ++--
 .../dc/dcn35/dcn35_dio_stream_encoder.c       | 36 ++++++++++++++-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 24 ++--------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 21 ++++++---
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 23 ----------
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |  4 --
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 -
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 44 ++++---------------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  4 --
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 -
 .../display/dc/hwss/hw_sequencer_private.h    |  3 --
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  7 ---
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  5 ---
 .../amd/display/dc/inc/hw/stream_encoder.h    |  1 -
 20 files changed, 111 insertions(+), 141 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 25c64fdcfa44..263e21756481 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -49,7 +49,6 @@
 #include "link/hwss/link_hwss_hpo_dp.h"
 #include "link/hwss/link_hwss_dio_fixed_vs_pe_retimer.h"
 #include "link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.h"
-#include "hw_sequencer_private.h"
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/dce60_resource.h"
@@ -3903,9 +3902,6 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 		if (res != DC_OK)
 			goto fail;
 
-		if (dc->hwseq->funcs.calculate_pix_rate_divider)
-			dc->hwseq->funcs.calculate_pix_rate_divider(dc, context, add_streams[i]);
-
 		if (!add_all_planes_for_stream(dc, add_streams[i], set, set_count, context)) {
 			res = DC_FAIL_ATTACH_SURFACES;
 			goto fail;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 8f6edd8e9beb..17a1174b8d80 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -58,8 +58,8 @@ static void dccg314_trigger_dio_fifo_resync(
 static void dccg314_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
-		uint32_t *k1,
-		uint32_t *k2)
+		enum pixel_rate_div *k1,
+		enum pixel_rate_div *k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
@@ -93,8 +93,8 @@ static void dccg314_get_pixel_rate_div(
 		return;
 	}
 
-	*k1 = val_k1;
-	*k2 = val_k2;
+	*k1 = (enum pixel_rate_div)val_k1;
+	*k2 = (enum pixel_rate_div)val_k2;
 }
 
 static void dccg314_set_pixel_rate_div(
@@ -104,8 +104,7 @@ static void dccg314_set_pixel_rate_div(
 		enum pixel_rate_div k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-	uint32_t cur_k1 = PIXEL_RATE_DIV_NA;
-	uint32_t cur_k2 = PIXEL_RATE_DIV_NA;
+	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
 
 	// Don't program 0xF into the register field. Not valid since
 	// K1 / K2 field is only 1 / 2 bits wide
@@ -374,7 +373,6 @@ static const struct dccg_funcs dccg314_funcs = {
 	.disable_dsc = dccg31_disable_dscclk,
 	.enable_dsc = dccg31_enable_dscclk,
 	.set_pixel_rate_div = dccg314_set_pixel_rate_div,
-	.get_pixel_rate_div = dccg314_get_pixel_rate_div,
 	.trigger_dio_fifo_resync = dccg314_trigger_dio_fifo_resync,
 	.set_valid_pixel_rate = dccg314_set_valid_pixel_rate,
 	.set_dtbclk_p_src = dccg314_set_dtbclk_p_src
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 21a6ca5ca192..56385cede113 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -58,8 +58,8 @@ static void dccg32_trigger_dio_fifo_resync(
 static void dccg32_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
-		uint32_t *k1,
-		uint32_t *k2)
+		enum pixel_rate_div *k1,
+		enum pixel_rate_div *k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
@@ -93,8 +93,8 @@ static void dccg32_get_pixel_rate_div(
 		return;
 	}
 
-	*k1 = val_k1;
-	*k2 = val_k2;
+	*k1 = (enum pixel_rate_div)val_k1;
+	*k2 = (enum pixel_rate_div)val_k2;
 }
 
 static void dccg32_set_pixel_rate_div(
@@ -104,8 +104,7 @@ static void dccg32_set_pixel_rate_div(
 		enum pixel_rate_div k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-	uint32_t cur_k1 = PIXEL_RATE_DIV_NA;
-	uint32_t cur_k2 = PIXEL_RATE_DIV_NA;
+	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
 
 	// Don't program 0xF into the register field. Not valid since
 	// K1 / K2 field is only 1 / 2 bits wide
@@ -344,7 +343,6 @@ static const struct dccg_funcs dccg32_funcs = {
 	.otg_add_pixel = dccg32_otg_add_pixel,
 	.otg_drop_pixel = dccg32_otg_drop_pixel,
 	.set_pixel_rate_div = dccg32_set_pixel_rate_div,
-	.get_pixel_rate_div = dccg32_get_pixel_rate_div,
 	.trigger_dio_fifo_resync = dccg32_trigger_dio_fifo_resync,
 	.set_dtbclk_p_src = dccg32_set_dtbclk_p_src,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index 1a9bb614c41e..2fef1419ae91 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -52,11 +52,11 @@
 
 static void enc32_dp_set_odm_combine(
 	struct stream_encoder *enc,
-	bool two_pixel_per_cyle)
+	bool odm_combine)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
-	REG_UPDATE(DP_PIXEL_FORMAT, DP_PIXEL_PER_CYCLE_PROCESSING_MODE, two_pixel_per_cyle ? 1 : 0);
+	REG_UPDATE(DP_PIXEL_FORMAT, DP_PIXEL_PER_CYCLE_PROCESSING_MODE, odm_combine ? 1 : 0);
 }
 
 /* setup stream encoder in dvi mode */
@@ -241,12 +241,46 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 	return two_pix;
 }
 
+static bool is_h_timing_divisible_by_2(const struct dc_crtc_timing *timing)
+{
+	/* math borrowed from function of same name in inc/resource
+	 * checks if h_timing is divisible by 2
+	 */
+
+	bool divisible = false;
+	uint16_t h_blank_start = 0;
+	uint16_t h_blank_end = 0;
+
+	if (timing) {
+		h_blank_start = timing->h_total - timing->h_front_porch;
+		h_blank_end = h_blank_start - timing->h_addressable;
+
+		/* HTOTAL, Hblank start/end, and Hsync start/end all must be
+		 * divisible by 2 in order for the horizontal timing params
+		 * to be considered divisible by 2. Hsync start is always 0.
+		 */
+		divisible = (timing->h_total % 2 == 0) &&
+				(h_blank_start % 2 == 0) &&
+				(h_blank_end % 2 == 0) &&
+				(timing->h_sync_width % 2 == 0);
+	}
+	return divisible;
+}
+
+static bool is_dp_dig_pixel_rate_div_policy(struct dc *dc, const struct dc_crtc_timing *timing)
+{
+	/* should be functionally the same as dcn32_is_dp_dig_pixel_rate_div_policy for DP encoders*/
+	return is_h_timing_divisible_by_2(timing) &&
+		dc->debug.enable_dp_dig_pixel_rate_div_policy;
+}
+
 void enc32_stream_encoder_dp_unblank(
 	struct dc_link *link,
 	struct stream_encoder *enc,
 	const struct encoder_unblank_param *param)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	struct dc *dc = enc->ctx->dc;
 
 	if (param->link_settings.link_rate != LINK_RATE_UNKNOWN) {
 		uint32_t n_vid = 0x8000;
@@ -257,7 +291,7 @@ void enc32_stream_encoder_dp_unblank(
 
 		/* YCbCr 4:2:0 : Computed VID_M will be 2X the input rate */
 		if (is_two_pixels_per_containter(&param->timing) || param->opp_cnt > 1
-			|| param->pix_per_cycle > 1) {
+			|| is_dp_dig_pixel_rate_div_policy(dc, &param->timing)) {
 			/*this logic should be the same in get_pixel_clock_parameters() */
 			n_multiply = 1;
 			pix_per_cycle = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index 795320a25fd2..02ec16bf381f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -146,8 +146,8 @@ static void dccg35_set_dppclk_root_clock_gating(struct dccg *dccg,
 static void dccg35_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
-		uint32_t *k1,
-		uint32_t *k2)
+		enum pixel_rate_div *k1,
+		enum pixel_rate_div *k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
@@ -192,8 +192,7 @@ static void dccg35_set_pixel_rate_div(
 		enum pixel_rate_div k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-	uint32_t cur_k1 = PIXEL_RATE_DIV_NA;
-	uint32_t cur_k2 = PIXEL_RATE_DIV_NA;
+	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
 
 	// Don't program 0xF into the register field. Not valid since
 	// K1 / K2 field is only 1 / 2 bits wide
@@ -1019,7 +1018,6 @@ static const struct dccg_funcs dccg35_funcs = {
 	.disable_dsc = dccg35_disable_dscclk,
 	.enable_dsc = dccg35_enable_dscclk,
 	.set_pixel_rate_div = dccg35_set_pixel_rate_div,
-	.get_pixel_rate_div = dccg35_get_pixel_rate_div,
 	.trigger_dio_fifo_resync = dccg35_trigger_dio_fifo_resync,
 	.set_valid_pixel_rate = dccg35_set_valid_pixel_rate,
 	.enable_symclk_se = dccg35_enable_symclk_se,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
index 2595cbef5942..62a8f0b56006 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
@@ -273,12 +273,46 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 	return two_pix;
 }
 
+static bool is_h_timing_divisible_by_2(const struct dc_crtc_timing *timing)
+{
+	/* math borrowed from function of same name in inc/resource
+	 * checks if h_timing is divisible by 2
+	 */
+
+	bool divisible = false;
+	uint16_t h_blank_start = 0;
+	uint16_t h_blank_end = 0;
+
+	if (timing) {
+		h_blank_start = timing->h_total - timing->h_front_porch;
+		h_blank_end = h_blank_start - timing->h_addressable;
+
+		/* HTOTAL, Hblank start/end, and Hsync start/end all must be
+		 * divisible by 2 in order for the horizontal timing params
+		 * to be considered divisible by 2. Hsync start is always 0.
+		 */
+		divisible = (timing->h_total % 2 == 0) &&
+				(h_blank_start % 2 == 0) &&
+				(h_blank_end % 2 == 0) &&
+				(timing->h_sync_width % 2 == 0);
+	}
+	return divisible;
+}
+
+static bool is_dp_dig_pixel_rate_div_policy(struct dc *dc, const struct dc_crtc_timing *timing)
+{
+	/* should be functionally the same as dcn32_is_dp_dig_pixel_rate_div_policy for DP encoders*/
+	return is_h_timing_divisible_by_2(timing) &&
+		dc->debug.enable_dp_dig_pixel_rate_div_policy;
+}
+
 static void enc35_stream_encoder_dp_unblank(
 		struct dc_link *link,
 		struct stream_encoder *enc,
 		const struct encoder_unblank_param *param)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	struct dc *dc = enc->ctx->dc;
 
 	if (param->link_settings.link_rate != LINK_RATE_UNKNOWN) {
 		uint32_t n_vid = 0x8000;
@@ -289,7 +323,7 @@ static void enc35_stream_encoder_dp_unblank(
 
 		/* YCbCr 4:2:0 : Computed VID_M will be 2X the input rate */
 		if (is_two_pixels_per_containter(&param->timing) || param->opp_cnt > 1
-			|| param->pix_per_cycle > 1) {
+			|| is_dp_dig_pixel_rate_div_policy(dc, &param->timing)) {
 			/*this logic should be the same in get_pixel_clock_parameters() */
 			n_multiply = 1;
 			pix_per_cycle = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 43200f8b1c3c..5920d1825a4c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1782,7 +1782,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	struct dc_stream_state *edp_streams[MAX_NUM_EDP];
 	struct dc_link *edp_link_with_sink = NULL;
 	struct dc_link *edp_link = NULL;
-	struct pipe_ctx *pipe_ctx = NULL;
 	struct dce_hwseq *hws = dc->hwseq;
 	int edp_with_sink_num;
 	int edp_num;
@@ -1819,26 +1818,9 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 				can_apply_edp_fast_boot = dc_validate_boot_timing(dc,
 					edp_stream->sink, &edp_stream->timing);
 				edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
-				if (can_apply_edp_fast_boot) {
-					DC_LOG_EVENT_LINK_TRAINING("eDP fast boot Enable\n");
-
-					// Vbios & Driver support different pixel rate div policy.
-					pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, edp_stream);
-					if (pipe_ctx &&
-						hws->funcs.is_dp_dig_pixel_rate_div_policy &&
-						hws->funcs.is_dp_dig_pixel_rate_div_policy(pipe_ctx)) {
-						// Get Vbios div factor from register
-						dc->res_pool->dccg->funcs->get_pixel_rate_div(
-							dc->res_pool->dccg,
-							pipe_ctx->stream_res.tg->inst,
-							&pipe_ctx->pixel_rate_divider.div_factor1,
-							&pipe_ctx->pixel_rate_divider.div_factor2);
-
-						// VBios doesn't support pixel rate div, so force it.
-						// If VBios supports it, we check it from reigster or other flags.
-						pipe_ctx->pixel_per_cycle = 1;
-					}
-				}
+				if (can_apply_edp_fast_boot)
+					DC_LOG_EVENT_LINK_TRAINING("eDP fast boot disabled to optimize link rate\n");
+
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index e5f864ca5204..26b19de687cc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -828,14 +828,17 @@ enum dc_status dcn20_enable_stream_timing(
 	struct mpc_dwb_flow_control flow_control;
 	struct mpc *mpc = dc->res_pool->mpc;
 	bool rate_control_2x_pclk = (interlace || optc2_is_two_pixels_per_containter(&stream->timing));
+	unsigned int k1_div = PIXEL_RATE_DIV_NA;
+	unsigned int k2_div = PIXEL_RATE_DIV_NA;
+
+	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
+		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
 
-	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
 			pipe_ctx->stream_res.tg->inst,
-			pipe_ctx->pixel_rate_divider.div_factor1,
-			pipe_ctx->pixel_rate_divider.div_factor2);
-
+			k1_div, k2_div);
+	}
 	/* by upper caller loop, pipe0 is parent pipe and be called first.
 	 * back end is set up by for pipe0. Other children pipe share back end
 	 * with pipe 0. No program is needed.
@@ -2896,6 +2899,9 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	struct dccg *dccg = dc->res_pool->dccg;
 	enum phyd32clk_clock_source phyd32clk;
 	int dp_hpo_inst;
+	struct dce_hwseq *hws = dc->hwseq;
+	unsigned int k1_div = PIXEL_RATE_DIV_NA;
+	unsigned int k2_div = PIXEL_RATE_DIV_NA;
 	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
@@ -2916,13 +2922,14 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
 						      link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
+	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
+		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
 
-	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
 			pipe_ctx->stream_res.tg->inst,
-			pipe_ctx->pixel_rate_divider.div_factor1,
-			pipe_ctx->pixel_rate_divider.div_factor2);
+			k1_div, k2_div);
+	}
 
 	link_hwss->setup_stream_encoder(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 5bfe08a7fef0..093f4387553c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -332,29 +332,6 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 	return odm_combine_factor;
 }
 
-void dcn314_calculate_pix_rate_divider(
-		struct dc *dc,
-		struct dc_state *context,
-		const struct dc_stream_state *stream)
-{
-	struct dce_hwseq *hws = dc->hwseq;
-	struct pipe_ctx *pipe_ctx = NULL;
-	unsigned int k1_div = PIXEL_RATE_DIV_NA;
-	unsigned int k2_div = PIXEL_RATE_DIV_NA;
-
-	pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
-
-	if (pipe_ctx) {
-		pipe_ctx->pixel_per_cycle = 1;
-
-		if (hws->funcs.calculate_dccg_k1_k2_values)
-			hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
-
-		pipe_ctx->pixel_rate_divider.div_factor1 = k1_div;
-		pipe_ctx->pixel_rate_divider.div_factor2 = k2_div;
-	}
-}
-
 void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 {
 	uint32_t pix_per_cycle = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
index fb94e327d4ee..eafcc4ea6d24 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
@@ -39,10 +39,6 @@ void dcn314_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
 unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
-void dcn314_calculate_pix_rate_divider(struct dc *dc,
-	struct dc_state *context,
-	const struct dc_stream_state *stream);
-
 void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
 
 void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index f9120b1c1c1f..29b56736fa84 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -152,7 +152,6 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn314_calculate_dccg_k1_k2_values,
-	.calculate_pix_rate_divider = dcn314_calculate_pix_rate_divider,
 	.set_pixels_per_cycle = dcn314_set_pixels_per_cycle,
 	.resync_fifo_dccg_dio = dcn314_resync_fifo_dccg_dio,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 7222055fa854..9f1a86ddadb5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1159,14 +1159,15 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 
 void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 {
-	uint32_t pix_per_cycle = pipe_ctx->pixel_per_cycle;
+	uint32_t pix_per_cycle = 1;
 	uint32_t odm_combine_factor = 1;
 
 	if (!pipe_ctx || !pipe_ctx->stream || !pipe_ctx->stream_res.stream_enc)
 		return;
 
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
-	if (optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing) || odm_combine_factor > 1)
+	if (optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing) || odm_combine_factor > 1
+		|| dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
 		pix_per_cycle = 2;
 
 	if (pipe_ctx->stream_res.stream_enc->funcs->set_input_mode)
@@ -1212,8 +1213,8 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 	struct dc_link *link = stream->link;
 	struct dce_hwseq *hws = link->dc->hwseq;
 	struct pipe_ctx *odm_pipe;
+	uint32_t pix_per_cycle = 1;
 
-	params.pix_per_cycle = pipe_ctx->pixel_per_cycle;
 	params.opp_cnt = 1;
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 		params.opp_cnt++;
@@ -1229,14 +1230,13 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 				pipe_ctx->stream_res.hpo_dp_stream_enc,
 				pipe_ctx->stream_res.tg->inst);
 	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
-		if (optc2_is_two_pixels_per_containter(&stream->timing) || params.opp_cnt > 1)
-			params.pix_per_cycle = 2;
-
-		if (params.pix_per_cycle == 2)
+		if (optc2_is_two_pixels_per_containter(&stream->timing) || params.opp_cnt > 1
+			|| dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx)) {
 			params.timing.pix_clk_100hz /= 2;
-
+			pix_per_cycle = 2;
+		}
 		pipe_ctx->stream_res.stream_enc->funcs->dp_set_odm_combine(
-				pipe_ctx->stream_res.stream_enc, params.pix_per_cycle > 1);
+				pipe_ctx->stream_res.stream_enc, pix_per_cycle > 1);
 		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
 	}
 
@@ -1257,32 +1257,6 @@ bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx)
 	return false;
 }
 
-void dcn32_calculate_pix_rate_divider(
-		struct dc *dc,
-		struct dc_state *context,
-		const struct dc_stream_state *stream)
-{
-	struct dce_hwseq *hws = dc->hwseq;
-	struct pipe_ctx *pipe_ctx = NULL;
-	unsigned int k1_div = PIXEL_RATE_DIV_NA;
-	unsigned int k2_div = PIXEL_RATE_DIV_NA;
-
-	pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
-
-	if (pipe_ctx) {
-		pipe_ctx->pixel_per_cycle = 1;
-
-		if (dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
-			pipe_ctx->pixel_per_cycle = 2;
-
-		if (hws->funcs.calculate_dccg_k1_k2_values)
-			hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
-
-		pipe_ctx->pixel_rate_divider.div_factor1 = k1_div;
-		pipe_ctx->pixel_rate_divider.div_factor2 = k2_div;
-	}
-}
-
 static void apply_symclk_on_tx_off_wa(struct dc_link *link)
 {
 	/* There are use cases where SYMCLK is referenced by OTG. For instance
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index d6345a2408be..f55c11fc56ec 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -91,10 +91,6 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 
 bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
 
-void dcn32_calculate_pix_rate_divider(struct dc *dc,
-		struct dc_state *context,
-		const struct dc_stream_state *stream);
-
 void dcn32_disable_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 033dca8b9a47..b1f79ca7d77a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -161,7 +161,6 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 	.resync_fifo_dccg_dio = dcn32_resync_fifo_dccg_dio,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
-	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
 	.populate_mcm_luts = dcn401_populate_mcm_luts,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 7f2cbfac9099..8e5b87798192 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -162,7 +162,6 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 	.resync_fifo_dccg_dio = dcn314_resync_fifo_dccg_dio,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
-	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.dsc_pg_control = dcn35_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
 	.enable_plane = dcn35_enable_plane,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 91484b71b7da..701b66634e2d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -160,7 +160,6 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
-	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.dsc_pg_control = dcn35_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
 	.enable_plane = dcn35_enable_plane,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 7553d6816d36..7bfb4fb50dad 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -177,9 +177,6 @@ struct hwseq_private_funcs {
 			struct dc_state *context,
 			struct dc *dc);
 	bool (*is_dp_dig_pixel_rate_div_policy)(struct pipe_ctx *pipe_ctx);
-	void (*calculate_pix_rate_divider)(struct dc *dc,
-			struct dc_state *context,
-			const struct dc_stream_state *stream);
 	void (*reset_back_end_for_pipe)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 634d52fe111e..286f3219b77e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -399,11 +399,6 @@ union pipe_update_flags {
 	uint32_t raw;
 };
 
-struct pixel_rate_divider {
-	uint32_t div_factor1;
-	uint32_t div_factor2;
-};
-
 enum p_state_switch_method {
 	P_STATE_UNKNOWN						= 0,
 	P_STATE_V_BLANK						= 1,
@@ -469,8 +464,6 @@ struct pipe_ctx {
 	bool has_vactive_margin;
 	/* subvp_index: only valid if the pipe is a SUBVP_MAIN*/
 	uint8_t subvp_index;
-	uint32_t pixel_per_cycle;
-	struct pixel_rate_divider pixel_rate_divider;
 };
 
 /* Data used for dynamic link encoder assignment.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index d6248a73c7c1..d4c7885fc916 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -176,11 +176,6 @@ struct dccg_funcs {
 			enum pixel_rate_div k1,
 			enum pixel_rate_div k2);
 
-	void (*get_pixel_rate_div)(struct dccg *dccg,
-			uint32_t otg_inst,
-			uint32_t *div_factor1,
-			uint32_t *div_factor2);
-
 	void (*set_valid_pixel_rate)(
 			struct dccg *dccg,
 			int ref_dtbclk_khz,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 60228f5de4d7..75b9ec21f297 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -99,7 +99,6 @@ struct encoder_unblank_param {
 	struct dc_link_settings link_settings;
 	struct dc_crtc_timing timing;
 	int opp_cnt;
-	uint32_t pix_per_cycle;
 };
 
 struct encoder_set_dp_phy_pattern_param {
-- 
2.37.3

