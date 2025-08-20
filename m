Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D453CA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F6910E7FC;
	Wed, 20 Aug 2025 20:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sp8P6f4A";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB7410E7F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA+oqzXZPYFD7ZfPopRLnAiH4Tl7uPxMNEnJKYbSkxKgJmLtpIxJhoKBZ2tD/s5OZMMCvNCyN5J+0q2Qj29OfFg4Vg6lAVv9WR1i96hlt7b+uoZaprAQENvLYKJsUpd3qMleIGMu5ubIZ8z+LsoSgYxMSYSJkskl0VUXHxEsSRcADntwOZcUwZdhXbJJ4tal6GEJVwylZUQRrn1eKDaTTITQ3wfA3RjkQRHIEjuHE5V6Sa0HPy2On6xRM5ilcRRHzVW2VIpWAsXkeP2evNBUOw4Y7kofZGKKwtMFKOhBwxxGyzxTIYWIJM+ulos4BhM6khu26WlkYBwyt5hWzuuPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNGyHUFXjWylAUU4TL8SVtLnNBbR23uYFQ23Q/36z7I=;
 b=GOxjn8dyGqgDjyJIdq6Y/WpKPd7qGj5+W4e1rVlL59tX7AGJB4DqSbCODJq2pSnUPYIJIZl65RoBN4igFbviM9mxJ54op3OXDgGKmhFuyUSWeRrZ1DXYFZpR+011s0LJ+5qL24rVvRvQ1t72wUyqyDuAK/r8PbU8SXU0o44h2pHDrDW2fFg8SiSRynxqjWYVirhhzgaWdBfRJfHiT936NLANulX78L/WmQRGC+37WbcL0a4C2bYFTci/gnPS6iXDwMhbtRcDeXsVd8I/asDhDDRjOEmly7SHJKCrX6Q68VqPfK4LV8JfGZXel47NePfKQnseAz0jaJXyl6EfOFxaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNGyHUFXjWylAUU4TL8SVtLnNBbR23uYFQ23Q/36z7I=;
 b=sp8P6f4AW0VfizD2UTl5XE41+YvpEy1PW/3/URgsMrlvBYwqpANl6GedSgdRWNS/1RVUQ7sY78dUkBq3nY+GQd7DuKaSSotd2M1hBrf7DCkX45/hKkqMR1swM5RLx9oR4ISBeUI2K97NjGWax8KvdJGn/eH6hYdY5CS/8FiqJBw=
Received: from DM6PR06CA0059.namprd06.prod.outlook.com (2603:10b6:5:54::36) by
 DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.25; Wed, 20 Aug 2025 20:21:12 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::d9) by DM6PR06CA0059.outlook.office365.com
 (2603:10b6:5:54::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 20:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:08 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:08 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>
Subject: [PATCH 07/12] drm/amd/display: Incorrect 'not' operator usage
Date: Wed, 20 Aug 2025 16:19:57 -0400
Message-ID: <20250820202103.1122706-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cf2612-5542-46a5-3910-08dde0271b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pppwww7Kt5R7tT05feRIlve+x8HIuOBuVph7uJifb5R0YYOEewEOsNRS0YTQ?=
 =?us-ascii?Q?0tLytBtUUvSJIgWMZR5Z3VkcG4RNauFHmR6jUvYPJbu4Oj62OhoLbJkZ7GBw?=
 =?us-ascii?Q?XPRELdgV0UnuueVae24GyDinAgbzG7Orwjz/Og07mIyDy7YHJRmWkYnXVF0K?=
 =?us-ascii?Q?e9lUf9bPZH+d9dpIQ5sdy4Rk6gPfgjJ6iFIq5qRddoTrzQBBx1YAw4dmexzq?=
 =?us-ascii?Q?53EbTxPV1K+uOP+NVtwb/0eW0mlE7cJcgw52S+HlOBiaRb/r4bs9T4axnpSc?=
 =?us-ascii?Q?jqt282A7BHhOtQhQKWsV23vtylyjM5BFOcCXfsijz1Bs91sIPW/NuzXqHyPe?=
 =?us-ascii?Q?L1HPiN3aQrirmzbLTBDIqPBqqIemsPAF8zfq7WR1cYyS4IW3ez9nVDeLO199?=
 =?us-ascii?Q?hiSWiQWRZTJcVXx4oJ64QBHCIudYZL/LAL/IxKgr5PZxMN/INn8PuKXZmdNQ?=
 =?us-ascii?Q?NRRKcSO1ScrnJCbD8fE13IDJfx65JdUBtx26lOS8/Bw0TpXewND66SKhwj4m?=
 =?us-ascii?Q?HHeWKifMcvuiJHxWTx6sW3q4UP659DQrcp9Hgwj73bO0XmBcs0otbSc3SpBg?=
 =?us-ascii?Q?Ve3ZX3vvCKdDKd9wPo+1yEgAv7TyserSXsxl6JYGgI3robwuh4le9pRqKmee?=
 =?us-ascii?Q?4ze8ZY99YpSd9b1CXlDDsPNXHft/wY4H8ETJ23/57ZJs04vOXpFgUJa9mYaO?=
 =?us-ascii?Q?EReHkBhbExQqT6KgfQD/IxKZ1qpS9NJmZ1qgOopu6CEJFTK0CWBVAM2TI2by?=
 =?us-ascii?Q?hLzOPJ2Zvis8yszhB4m6GpTA2JPCWC9dJwsiupp3KytktxCrtXhCsXLAkJt3?=
 =?us-ascii?Q?FUJK2RhfXRWU04QJxuPko4qijJhtyQ3X5PP7dLbVx1L4DZdlurHLuFAYxWoo?=
 =?us-ascii?Q?7nybTQ6VWyWmNQBqWru3a22WfCT42nMuZ4myewTUL73tGSh75c52Q28YR+vp?=
 =?us-ascii?Q?zC0boygu4akv28seOMg4mr9H1W7HFVqoaNeolHXCfgcO2Slt3wXgNt+6FQMa?=
 =?us-ascii?Q?Kkyf5tLEJclxCbEK+vYgSXXtm/NnWVE+NaqBzoJgFb6s16t9MCs8SlFzu3Ta?=
 =?us-ascii?Q?iDw+WJ7dNve6sEftuAdbTgztzrfkJTLRcnEscE1qt4/3Diocapz0IxUdjNeq?=
 =?us-ascii?Q?0YxJ1FUjLrhpHmiNNuqlMlzbM5DVAV1PEGRt9/wLflcurUBhzNSY65aI1Cly?=
 =?us-ascii?Q?79UZusEePnm7R4Pfdv04IImLhrLDQqm9NNlqWH2mvVzRa0h+I8HBVVoB0IxD?=
 =?us-ascii?Q?Ocev9YQF7JeadXr/vuiqFgybGxMJP1E/zOaHDOYiaLycs4aWqaUOnL0AFnNi?=
 =?us-ascii?Q?jpVRu/7HerHLa8DDKRnKxUvY9ROwF/7dGTkicvlS3zn1mBjIWlmnNng0pDWr?=
 =?us-ascii?Q?HDBqe2QPcoW1w5TrNrSeIyPdKcYU9ZJN9dHFeqbOU/mxdjZVL7Q+orGt50xw?=
 =?us-ascii?Q?bxBA7f+NMlxoQ1QTDmE2SACtFMGwdIYB1eiEcmM8a2LJjTAK1qAFS6TNnZFY?=
 =?us-ascii?Q?BBtoOUQkzvN15nNCdj05mkM9TtqK4DZqp57q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:12.2256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cf2612-5542-46a5-3910-08dde0271b51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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

From: Clay King <clayking@amd.com>

Consolidating multiple CodeQL Fixes for alerts with rule id: cpp/incorrect-not-operator-usage

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c                 | 2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c                 | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c   | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c   | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c   | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c   | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 0421b267a0b5..365dd2e37aea 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -591,7 +591,7 @@ static bool dce_i2c_hw_engine_submit_payload(struct dce_i2c_hw *dce_i2c_hw,
 			DCE_I2C_TRANSACTION_ACTION_I2C_WRITE;
 
 
-	request.address = (uint8_t) ((payload->address << 1) | !payload->write);
+	request.address = (uint8_t) ((payload->address << 1) | (payload->write ? 0 : 1));
 	request.length = payload->length;
 	request.data = payload->data;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
index e188447c8156..2d73b94c515c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
@@ -451,7 +451,7 @@ static bool dce_i2c_sw_engine_submit_payload(struct dce_i2c_sw *engine,
 			DCE_I2C_TRANSACTION_ACTION_I2C_WRITE_MOT :
 			DCE_I2C_TRANSACTION_ACTION_I2C_WRITE;
 
-	request.address = (uint8_t) ((payload->address << 1) | !payload->write);
+	request.address = (uint8_t) ((payload->address << 1) | (payload->write ? 0 : 1));
 	request.length = payload->length;
 	request.data = payload->data;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 390c1a77fda6..9c58ff1069d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -646,7 +646,7 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 
 	// the dpte_group_bytes is reduced for the specific case of vertical
 	// access of a tile surface that has dpte request of 8x1 ptes.
-	if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
+	if (!surf_linear && (log2_dpte_req_height_ptes == 0) && surf_vert) //reduced, in this case, will have page fault within a group
 		rq_sizing_param->dpte_group_bytes = 512;
 	else
 		//full size
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 843d6004258c..570e6e39eb45 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -646,7 +646,7 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 
 	// the dpte_group_bytes is reduced for the specific case of vertical
 	// access of a tile surface that has dpte request of 8x1 ptes.
-	if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
+	if (!surf_linear && (log2_dpte_req_height_ptes == 0) && surf_vert) //reduced, in this case, will have page fault within a group
 		rq_sizing_param->dpte_group_bytes = 512;
 	else
 		//full size
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 5718000627b0..f549da082c01 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -652,7 +652,7 @@ static void get_meta_and_pte_attr(
 	if (hostvm_enable)
 		rq_sizing_param->dpte_group_bytes = 512;
 	else {
-		if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
+		if (!surf_linear && (log2_dpte_req_height_ptes == 0) && surf_vert) //reduced, in this case, will have page fault within a group
 			rq_sizing_param->dpte_group_bytes = 512;
 		else
 			//full size
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index 8d4873f80df0..4fb37df54d59 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -620,7 +620,7 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 	if (hostvm_enable)
 		rq_sizing_param->dpte_group_bytes = 512;
 	else {
-		if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
+		if (!surf_linear && (log2_dpte_req_height_ptes == 0) && surf_vert) //reduced, in this case, will have page fault within a group
 			rq_sizing_param->dpte_group_bytes = 512;
 		else
 			rq_sizing_param->dpte_group_bytes = 2048;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index c46bda2141ac..bfeb01477f0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -615,7 +615,7 @@ static void get_meta_and_pte_attr(
 	if (hostvm_enable)
 		rq_sizing_param->dpte_group_bytes = 512;
 	else {
-		if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
+		if (!surf_linear && (log2_dpte_req_height_ptes == 0) && surf_vert) //reduced, in this case, will have page fault within a group
 			rq_sizing_param->dpte_group_bytes = 512;
 		else
 			rq_sizing_param->dpte_group_bytes = 2048;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index b7d2a0caec11..04df263ff65e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -703,7 +703,7 @@ static void get_meta_and_pte_attr(
 	if (hostvm_enable)
 		rq_sizing_param->dpte_group_bytes = 512;
 	else {
-		if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
+		if (!surf_linear && (log2_dpte_req_height_ptes == 0) && surf_vert) //reduced, in this case, will have page fault within a group
 			rq_sizing_param->dpte_group_bytes = 512;
 		else
 			rq_sizing_param->dpte_group_bytes = 2048;
-- 
2.50.1

