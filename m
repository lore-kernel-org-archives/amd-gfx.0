Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52908CD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98FB10ECDC;
	Wed,  6 May 2026 07:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mRFfT32S";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011016.outbound.protection.outlook.com
 [40.93.194.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 435D110ECDC
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFuYrMhEOwQYRtdxwx2zox9CysW+Xbgx1BfOFVYS7sggoJYURFtNzD/+++JlM6PpqdUvg6vlIJIL6Iaw7EqLeyjncRBRcPKWahlga7iN+0kJ0MYf0oJQ/7JYJTCSjdm0MifVzxXN58kwuMftQg8uQItHNTJziFjHML7LSGLLelQOTPGdAe/ZVOt1iArGVh7f6aWavvpNbGd5kcasdBkUhrP7hUdCyhT9tKSNdAR73h737q7xBZj7ZG+iTBuCHeInsvIlgVMwEmFPuef4W6sIuD25gMeiv+0/wiZOhJGdyID9yxadbIamzvoiIaRNk+vknc6D37VxrNPfcEqVMmbU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CW9zxTGnUa8XJyAupHStTiPQJg1O/WLvQ68JmLs+0Tk=;
 b=RtTWdub+NDSDyvqFTxPigni0r4i9o4qlUkrsEppdMwP+Lsh7ZzuiXc4L1hiT+FQD4vAH0LGaFzRaGun40gJVXdFgeEOV+5AzUKaPhvf49haqXJeX4u0OkdQ5DzkELTTQ8FfpG9VJJtkUkOwLCzRXIGZCkbOx6ZjHObMgd+LsOpFPEsassqijpkdsAIC0Ia5K9efx7BLt+/PpITetegNZpQ8l3nYoQO7KwwiBmcDqCORAChJ9L7XvwQEYqZMP31ilepAisYLdfGRdiRAIkD6w2PzrDzy1aEd/sKIwUblNRB0AeOcpXPXdgqItT6tk2d/xz/felzrwOD5Yh3y9N0lV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CW9zxTGnUa8XJyAupHStTiPQJg1O/WLvQ68JmLs+0Tk=;
 b=mRFfT32Su8Nz7U6LkAOWvb2ts9hy1RtlUxqr+dhpJHzamCl+Cgq+1ih4yB/DA6ZM1XcO6py5rLOpFExvaddz5hv9OLfK3blqwmz68Gtq+nx/L6Ye3DWTg6Ui7HSoQ6qPJR+rQCcDqHr4DsAp3j/NZlx30tBrWajVuQomGT5Rh00=
Received: from MN2PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:23a::10)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:04:14 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::24) by MN2PR03CA0005.outlook.office365.com
 (2603:10b6:208:23a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Wed,
 6 May 2026 07:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:04:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:04:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:04:03 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:03:54 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Clay King <clayking@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 07/20] drm/amd/display: Fix warnings
Date: Wed, 6 May 2026 12:31:05 +0800
Message-ID: <20260506043342.2164710-8-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SA1PR12MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: c71940f1-e009-4eaa-6604-08deab3dae32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003|20052099010;
X-Microsoft-Antispam-Message-Info: BITN7vlumBEW/M+GHdvN/+skoibq3WoOJXrh6QI3ds+N/QErFIoLbC7B5DpOIb+C5i6PqBHYReqrOfYb2KPpTHEujZJJj9a7+6ypBjyhpQrJrf8OjZ8P6oPM6p3C+DWJvMpoF2jU9U9K5PpFcIsppbshpR6bih5GXnugjdaQX7ztR0i8wmHrnKTg1DbhJ2VOONUBWGu2ExBP+JtnD/iQ8/Z39AbKZE1qTnquv289aYdl8gJ5cwR4EXz2+9aIdfIueh1mAbhEg9i+r7jozf5ObHKE2xFI9sqjKAjW/NNmHdVdOpvQqcNJIStrfw3kpHgNkVuzNjBv2gyJkML2pVZxFiDk1WgkRk9H0sLErCsuIDzkG3y3SLRc4rJ1jP3cIZs/urnUjmn3PHQ+exiMZO5Xu+e/zeSK4ObcxiCW97vhPjFpaBdcSadfZOV3kEM7oehzSLZchmhcbIUBxCLmU5rwd6B8xVdEUSgVptwbqaZQZadMC7x7xCikVuH0+TCkjq/mmvlWS/Ou9EjBUxT3lzdZOM3Z7ML7jqzkQADnVjKLyxmFut3Mg99bApeArsPVyewpiBBLCGMbnevNnHVXb541faHPtZiLJiBJEPNA6SeZ+tyAveezUkWZEdgbXuVobB15OGNOzZpnY9oCk15aMn7g+N1Q4qeLJbUUJemphJ0eXgt9G38Rh1PibOqpSgxeS8pEal018niDa8PU8jb7qOrw5S/h3sRxbRQzdm04QRwqrrY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(20052099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sxLvuH9bSSk4PgePbJU6+X5BL4bT9j3sALy3l/IPu9xasbaAPEV7tuCYFziFb8HJF7vKCVcb20Pg9bH0Mx7eIMETgb31KvIq5B8Z8y3Ut5vIao8/L/hIu67srolxuf/jvNXHt6pl06GQMViawQqXZur1816ZjuMy5rnbNnIA99NTm7H2KcIVv6MWbAIyvHsF+7ZVIRmDFcJFbkjG+ETuAuGzPJDL+bvFhEc7cqGsOrdf1FHsqACIlE0hbOKtLAXMKe2+Vahm/2Knbo9/E9VHYD2k0aRvHQRrlXb+RuOs2Pamz++mbwvZU46MzpKOImX05zcyIcSUQO3pUqPnqKvgDU/3uL2aBJRT6/nUH9NtQfPlIVMXAwwHRT9Ixgh/Wp/dUUGY8ih3yn2kX+lXoobRYM34O7KpZNZgFgtuH9YPj/mx8lA0RS3zxiAXBkxVP2ZB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:04:13.6712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71940f1-e009-4eaa-6604-08deab3dae32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492
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

[Why & How]
Fix various warnings related to unsigned/signed mismatches
-  Consistently use the same signedness for a given value
-  Explcitly cast between types when needed

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |   6 +-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |   2 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   8 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  |   4 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h  |   2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   2 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   4 +-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   |   4 +-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |   2 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +-
 .../drm/amd/display/dc/core/dc_link_exports.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  18 +-
 .../drm/amd/display/dc/core/dc_vm_helper.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  68 +--
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +-
 .../amd/display/dc/dcn21/dcn21_link_encoder.c |   2 +-
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |   2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   4 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |  28 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        | 342 +++++++--------
 .../dc/dml/dcn31/display_mode_vba_31.c        | 408 +++++++++---------
 .../dc/dml/dcn314/display_mode_vba_314.c      | 400 ++++++++---------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   2 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   8 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   8 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |  12 +-
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |   2 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   2 +-
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |   2 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   8 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   8 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |  10 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   4 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |   4 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |   8 +-
 .../gpu/drm/amd/display/dc/inc/link_service.h |   2 +-
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   |  72 ++--
 .../drm/amd/display/dc/link/link_detection.c  |   2 +-
 .../drm/amd/display/dc/link/link_detection.h  |   2 +-
 .../link/protocols/link_edp_panel_control.c   |   8 +-
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |   2 +-
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c  |   6 +-
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.c  |   2 +-
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.h  |   2 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   2 +-
 .../gpu/drm/amd/display/include/fixed31_32.h  |   6 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.c   |   2 +-
 59 files changed, 769 insertions(+), 767 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 6d41df52d7c9..808e24f0e88f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -88,7 +88,7 @@ static const struct state_dependent_clocks dce80_max_clks_by_state[] = {
 /* ClocksStatePerformance */
 { .display_clk_khz = 625000, .pixel_clk_khz = 400000 } };
 
-int dentist_get_divider_from_did(int did)
+unsigned int dentist_get_divider_from_did(unsigned int did)
 {
 	if (did < DENTIST_BASE_DID_1)
 		did = DENTIST_BASE_DID_1;
@@ -155,8 +155,8 @@ static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	int dprefclk_wdivider;
-	int dprefclk_src_sel;
+	uint32_t dprefclk_wdivider;
+	uint32_t dprefclk_src_sel;
 	int dp_ref_clk_khz;
 	int target_div;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
index f6622f58f62e..9ea1b0a9923d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
@@ -54,6 +54,6 @@ int dce_set_clock(
 
 void dce_clk_mgr_destroy(struct clk_mgr **clk_mgr);
 
-int dentist_get_divider_from_did(int did);
+unsigned int dentist_get_divider_from_did(unsigned int did);
 
 #endif /* _DCE_CLK_MGR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index c0abbdd2cf5c..cbd989b6a3df 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -430,8 +430,8 @@ void dcn2_read_clocks_from_hw_dentist(struct clk_mgr *clk_mgr_base)
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	uint32_t dispclk_wdivider;
 	uint32_t dppclk_wdivider;
-	int disp_divider;
-	int dpp_divider;
+	unsigned int disp_divider;
+	unsigned int dpp_divider;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DPPCLK_WDIVIDER, &dppclk_wdivider);
@@ -534,8 +534,8 @@ void dcn20_clk_mgr_construct(
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
-	int dprefclk_did;
-	int target_div;
+	unsigned int dprefclk_did;
+	unsigned int target_div;
 	uint32_t pll_req_reg;
 	struct fixed31_32 pll_req;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
index 827bc2431d5d..e36233127b15 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
@@ -123,12 +123,12 @@ bool dcn30_smu_test_message(struct clk_mgr_internal *clk_mgr, uint32_t input)
 	return false;
 }
 
-bool dcn30_smu_get_smu_version(struct clk_mgr_internal *clk_mgr, unsigned int *version)
+bool dcn30_smu_get_smu_version(struct clk_mgr_internal *clk_mgr, int *version)
 {
 	smu_print("SMU Get SMU version\n");
 
 	if (dcn30_smu_send_msg_with_param(clk_mgr,
-			DALSMC_MSG_GetSmuVersion, 0, version)) {
+			DALSMC_MSG_GetSmuVersion, 0, (uint32_t *)version)) {
 
 		smu_print("SMU version: %d\n", *version);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h
index ca9f5296be94..67e93f9cac71 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h
@@ -31,7 +31,7 @@
 struct clk_mgr_internal;
 
 bool         dcn30_smu_test_message(struct clk_mgr_internal *clk_mgr, uint32_t input);
-bool         dcn30_smu_get_smu_version(struct clk_mgr_internal *clk_mgr, unsigned int *version);
+bool         dcn30_smu_get_smu_version(struct clk_mgr_internal *clk_mgr, int *version);
 bool         dcn30_smu_check_driver_if_version(struct clk_mgr_internal *clk_mgr);
 bool         dcn30_smu_check_msg_header_version(struct clk_mgr_internal *clk_mgr);
 void         dcn30_smu_set_dram_addr_high(struct clk_mgr_internal *clk_mgr, uint32_t addr_high);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index f78b33076e70..2dc244d5a55f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -475,7 +475,7 @@ static int dcn32_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	uint32_t dispclk_wdivider;
-	int disp_divider;
+	unsigned int disp_divider;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
 	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 2654f4dacee3..7c2b716d5d2a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -1490,7 +1490,7 @@ static int dcn401_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	uint32_t dispclk_wdivider;
-	int disp_divider;
+	unsigned int disp_divider;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
 	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
index 97a1ce1e8a9e..370d2ddd6064 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
@@ -17,14 +17,14 @@ union dcn401_clk_mgr_block_sequence_params {
 		uint32_t ppclk;
 		uint16_t freq_mhz;
 		/* outputs */
-		uint32_t *response;
+		int *response;
 	} update_hardmin_params;
 	struct {
 		/* inputs */
 		uint32_t ppclk;
 		int freq_khz;
 		/* outputs */
-		uint32_t *response;
+		int *response;
 	} update_hardmin_optimized_params;
 	struct {
 		/* inputs */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
index 3a263840893e..82ccd9b407f4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c
@@ -143,12 +143,12 @@ static bool dcn401_smu_send_msg_with_param_delay(struct clk_mgr_internal *clk_mg
 	return false;
 }
 
-bool dcn401_smu_get_smu_version(struct clk_mgr_internal *clk_mgr, unsigned int *version)
+bool dcn401_smu_get_smu_version(struct clk_mgr_internal *clk_mgr, int *version)
 {
 	smu_print("SMU Get SMU version\n");
 
 	if (dcn401_smu_send_msg_with_param(clk_mgr,
-			DALSMC_MSG_GetSmuVersion, 0, version)) {
+			DALSMC_MSG_GetSmuVersion, 0, (uint32_t *)version)) {
 
 		smu_print("SMU version: %d\n", *version);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
index 4f5ac603e822..1addbed1cb99 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h
@@ -10,7 +10,7 @@
 
 struct clk_mgr_internal;
 
-bool dcn401_smu_get_smu_version(struct clk_mgr_internal *clk_mgr, unsigned int *version);
+bool dcn401_smu_get_smu_version(struct clk_mgr_internal *clk_mgr, int *version);
 bool dcn401_smu_check_driver_if_version(struct clk_mgr_internal *clk_mgr);
 bool dcn401_smu_check_msg_header_version(struct clk_mgr_internal *clk_mgr);
 void dcn401_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool support);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 41729426d08c..245a217894a7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -879,7 +879,7 @@ int dcn42_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 	(void)clk_mgr_base;
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	uint32_t dispclk_wdivider;
-	int disp_divider;
+	unsigned int disp_divider;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
 	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0e9ea06d7297..842a8b11b17a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -7006,7 +7006,7 @@ bool dc_can_clear_cursor_limit(const struct dc *dc)
 	return false;
 }
 
-void dc_get_underflow_debug_data_for_otg(struct dc *dc, int primary_otg_inst,
+void dc_get_underflow_debug_data_for_otg(struct dc *dc, unsigned int primary_otg_inst,
 				struct dc_underflow_debug_data *out_data)
 {
 	struct timing_generator *tg = NULL;
@@ -7024,7 +7024,7 @@ void dc_get_underflow_debug_data_for_otg(struct dc *dc, int primary_otg_inst,
 		dc->hwss.get_underflow_debug_data(dc, tg, out_data);
 }
 
-void dc_get_power_feature_status(struct dc *dc, int primary_otg_inst,
+void dc_get_power_feature_status(struct dc *dc, unsigned int primary_otg_inst,
 				struct power_features *out_data)
 {
 	(void)primary_otg_inst;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index f4e99ca7918f..5ac5ad86bd01 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -282,7 +282,7 @@ unsigned int dc_dp_trace_get_link_loss_count(struct dc_link *link)
 struct dc_sink *dc_link_add_remote_sink(
 		struct dc_link *link,
 		const uint8_t *edid,
-		int len,
+		unsigned int len,
 		struct dc_sink_init_data *init_data)
 {
 	return link->dc->link_srv->add_remote_sink(link, edid, len, init_data);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ad377a991451..f57e9d85563e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -982,7 +982,7 @@ static struct rect calculate_mpc_slice_in_timing_active(
 }
 
 static void calculate_adjust_recout_for_visual_confirm(struct pipe_ctx *pipe_ctx,
-	int *base_offset, int *dpp_offset)
+	unsigned int *base_offset, unsigned int *dpp_offset)
 {
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	*base_offset = 0;
@@ -1004,7 +1004,7 @@ static void calculate_adjust_recout_for_visual_confirm(struct pipe_ctx *pipe_ctx
 static void reverse_adjust_recout_for_visual_confirm(struct rect *recout,
 		struct pipe_ctx *pipe_ctx)
 {
-	int dpp_offset, base_offset;
+	unsigned int dpp_offset, base_offset;
 
 	calculate_adjust_recout_for_visual_confirm(pipe_ctx, &base_offset,
 		&dpp_offset);
@@ -1015,7 +1015,7 @@ static void reverse_adjust_recout_for_visual_confirm(struct rect *recout,
 static void adjust_recout_for_visual_confirm(struct rect *recout,
 		struct pipe_ctx *pipe_ctx)
 {
-	int dpp_offset, base_offset;
+	unsigned int dpp_offset, base_offset;
 
 	calculate_adjust_recout_for_visual_confirm(pipe_ctx, &base_offset,
 		&dpp_offset);
@@ -1692,7 +1692,7 @@ bool resource_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 	struct pipe_ctx *test_pipe, *split_pipe;
 	struct rect r1 = pipe_ctx->plane_res.scl_data.recout;
 	int r1_right, r1_bottom;
-	int cur_layer = pipe_ctx->plane_state->layer_index;
+	unsigned int cur_layer = pipe_ctx->plane_state->layer_index;
 
 	reverse_adjust_recout_for_visual_confirm(&r1, pipe_ctx);
 	r1_right = r1.x + r1.width;
@@ -4103,9 +4103,9 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc)
 static bool planes_changed_for_existing_stream(struct dc_state *context,
 					       struct dc_stream_state *stream,
 					       const struct dc_validation_set set[],
-					       int set_count)
+					       unsigned int set_count)
 {
-	int i, j;
+	unsigned int i, j;
 	struct dc_stream_status *stream_status = NULL;
 
 	for (i = 0; i < context->stream_count; i++) {
@@ -4141,10 +4141,10 @@ static bool add_all_planes_for_stream(
 		const struct dc *dc,
 		struct dc_stream_state *stream,
 		const struct dc_validation_set set[],
-		int set_count,
+		unsigned int set_count,
 		struct dc_state *state)
 {
-	int i, j;
+	unsigned int i, j;
 
 	for (i = 0; i < set_count; i++)
 		if (set[i].stream == stream)
@@ -4182,7 +4182,7 @@ static bool add_all_planes_for_stream(
  */
 enum dc_status dc_validate_with_context(struct dc *dc,
 					const struct dc_validation_set set[],
-					int set_count,
+					unsigned int set_count,
 					struct dc_state *context,
 					enum dc_validate_mode validate_mode)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
index d1e68dc57a2a..3743555133f6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
@@ -34,9 +34,9 @@ void vm_helper_mark_vmid_used(struct vm_helper *vm_helper, unsigned int pos, uin
 	vmids.vmid_usage[1] = 1 << pos;
 }
 
-int dc_setup_system_context(struct dc *dc, struct dc_phy_addr_space_config *pa_config)
+unsigned int dc_setup_system_context(struct dc *dc, struct dc_phy_addr_space_config *pa_config)
 {
-	int num_vmids = 0;
+	unsigned int num_vmids = 0;
 
 	/* Call HWSS to setup HUBBUB for address config */
 	if (dc->hwss.init_sys_ctx) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9bd4b0bb47df..e5933e3a8206 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -540,7 +540,7 @@ struct dc_config {
 	bool use_default_clock_table;
 	bool force_bios_enable_lttpr;
 	uint8_t force_bios_fixed_vs;
-	int sdpif_request_limit_words_per_umc;
+	unsigned int sdpif_request_limit_words_per_umc;
 	bool dc_mode_clk_limit_support;
 	bool EnableMinDispClkODM;
 	bool enable_auto_dpm_test_logs;
@@ -944,20 +944,20 @@ struct dc_virtual_addr_space_config {
 };
 
 struct dc_bounding_box_overrides {
-	int sr_exit_time_ns;
-	int sr_enter_plus_exit_time_ns;
-	int sr_exit_z8_time_ns;
-	int sr_enter_plus_exit_z8_time_ns;
-	int urgent_latency_ns;
-	int percent_of_ideal_drambw;
-	int dram_clock_change_latency_ns;
-	int dummy_clock_change_latency_ns;
-	int fclk_clock_change_latency_ns;
+	unsigned int sr_exit_time_ns;
+	unsigned int sr_enter_plus_exit_time_ns;
+	unsigned int sr_exit_z8_time_ns;
+	unsigned int sr_enter_plus_exit_z8_time_ns;
+	unsigned int urgent_latency_ns;
+	unsigned int percent_of_ideal_drambw;
+	unsigned int dram_clock_change_latency_ns;
+	unsigned int dummy_clock_change_latency_ns;
+	unsigned int fclk_clock_change_latency_ns;
 	/* This forces a hard min on the DCFCLK we use
 	 * for DML.  Unlike the debug option for forcing
 	 * DCFCLK, this override affects watermark calculations
 	 */
-	int min_dcfclk_mhz;
+	unsigned int min_dcfclk_mhz;
 };
 
 struct dc_qos_info {
@@ -990,7 +990,7 @@ struct link_service;
 struct dc_debug_options {
 	bool disable_dsc;
 	enum visual_confirm visual_confirm;
-	int visual_confirm_rect_height;
+	unsigned int visual_confirm_rect_height;
 
 	bool sanity_checks;
 	bool max_disp_clk;
@@ -1026,23 +1026,23 @@ struct dc_debug_options {
 	bool disable_io_clk_power_gate;
 	bool disable_mem_power_gate;
 	bool disable_dio_power_gate;
-	int dsc_min_slice_height_override;
-	int dsc_bpp_increment_div;
+	unsigned int dsc_min_slice_height_override;
+	unsigned int dsc_bpp_increment_div;
 	bool disable_pplib_wm_range;
 	enum wm_report_mode pplib_wm_report_mode;
 	unsigned int min_disp_clk_khz;
 	unsigned int min_dpp_clk_khz;
 	unsigned int min_dram_clk_khz;
-	int sr_exit_time_dpm0_ns;
-	int sr_enter_plus_exit_time_dpm0_ns;
-	int sr_exit_time_ns;
-	int sr_enter_plus_exit_time_ns;
-	int sr_exit_z8_time_ns;
-	int sr_enter_plus_exit_z8_time_ns;
-	int urgent_latency_ns;
+	unsigned int sr_exit_time_dpm0_ns;
+	unsigned int sr_enter_plus_exit_time_dpm0_ns;
+	unsigned int sr_exit_time_ns;
+	unsigned int sr_enter_plus_exit_time_ns;
+	unsigned int sr_exit_z8_time_ns;
+	unsigned int sr_enter_plus_exit_z8_time_ns;
+	unsigned int urgent_latency_ns;
 	uint32_t underflow_assert_delay_us;
-	int percent_of_ideal_drambw;
-	int dram_clock_change_latency_ns;
+	unsigned int percent_of_ideal_drambw;
+	unsigned int dram_clock_change_latency_ns;
 	bool optimized_watermark;
 	int always_scale;
 	bool disable_pplib_clock_request;
@@ -1067,8 +1067,8 @@ struct dc_debug_options {
 	uint8_t seamless_boot_odm_combine;
 	uint8_t force_odm_combine_4to1; //bit vector based on otg inst
 
-	int minimum_z8_residency_time;
-	int minimum_z10_residency_time;
+	unsigned int minimum_z8_residency_time;
+	unsigned int minimum_z10_residency_time;
 	bool disable_z9_mpc;
 	unsigned int force_fclk_khz;
 	bool enable_tri_buf;
@@ -1117,7 +1117,7 @@ struct dc_debug_options {
 	uint8_t fec_enable_delay_in100us;
 	bool enable_driver_sequence_debug;
 	enum det_size crb_alloc_policy;
-	int crb_alloc_policy_min_disp_count;
+	unsigned int crb_alloc_policy_min_disp_count;
 	bool disable_z10;
 	bool enable_z9_disable_interface;
 	bool psr_skip_crtc_disable;
@@ -1291,7 +1291,7 @@ void dc_hardware_init(struct dc *dc);
 int dc_get_vmid_use_vector(struct dc *dc);
 void dc_setup_vm_context(struct dc *dc, struct dc_virtual_addr_space_config *va_config, int vmid);
 /* Returns the number of vmids supported */
-int dc_setup_system_context(struct dc *dc, struct dc_phy_addr_space_config *pa_config);
+unsigned int dc_setup_system_context(struct dc *dc, struct dc_phy_addr_space_config *pa_config);
 void dc_init_callbacks(struct dc *dc,
 		const struct dc_callback_init *init_params);
 void dc_deinit_callbacks(struct dc *dc);
@@ -1520,7 +1520,7 @@ struct dc_plane_state {
 	bool visible;
 	bool flip_immediate;
 	bool horizontal_mirror;
-	int layer_index;
+	unsigned int layer_index;
 
 	union surface_update_flags update_flags;
 	bool flip_int_enabled;
@@ -1550,7 +1550,7 @@ struct dc_plane_state {
 	struct dc_csc_transform cursor_csc_color_matrix;
 	bool adaptive_sharpness_en;
 	int adaptive_sharpness_policy;
-	int sharpness_level;
+	unsigned int sharpness_level;
 	enum linear_light_scaling linear_light_scaling;
 	unsigned int sdr_white_level_nits;
 	struct cm_hist_control cm_hist_control;
@@ -1573,7 +1573,7 @@ struct dc_plane_info {
 	bool global_alpha;
 	int  global_alpha_value;
 	bool input_csc_enabled;
-	int layer_index;
+	unsigned int layer_index;
 	enum chroma_cositing cositing;
 };
 
@@ -1965,7 +1965,7 @@ enum dc_status dc_validate_plane(struct dc *dc, const struct dc_plane_state *pla
 
 enum dc_status dc_validate_with_context(struct dc *dc,
 					const struct dc_validation_set set[],
-					int set_count,
+					unsigned int set_count,
 					struct dc_state *context,
 					enum dc_validate_mode validate_mode);
 
@@ -2072,7 +2072,7 @@ struct dc_sink_init_data;
 struct dc_sink *dc_link_add_remote_sink(
 		struct dc_link *dc_link,
 		const uint8_t *edid,
-		int len,
+		unsigned int len,
 		struct dc_sink_init_data *init_data);
 
 /* Remove remote sink from a link with dc_connection_mst_branch connection type.
@@ -2869,9 +2869,9 @@ bool dc_can_clear_cursor_limit(const struct dc *dc);
  * including OTG underflow status, current read positions, frame count, and per-HUBP debug data.
  * The results are stored in the provided out_data structure for further analysis or logging.
  */
-void dc_get_underflow_debug_data_for_otg(struct dc *dc, int primary_otg_inst, struct dc_underflow_debug_data *out_data);
+void dc_get_underflow_debug_data_for_otg(struct dc *dc, unsigned int primary_otg_inst, struct dc_underflow_debug_data *out_data);
 
-void dc_get_power_feature_status(struct dc *dc, int primary_otg_inst, struct power_features *out_data);
+void dc_get_power_feature_status(struct dc *dc, unsigned int primary_otg_inst, struct power_features *out_data);
 
 /*
  * Software state variables used to program register fields across the display pipeline
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 101bce6b8de6..7cb34e2b44a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -92,7 +92,7 @@ uint32_t dc_dsc_stream_bandwidth_in_kbps(const struct dc_crtc_timing *timing,
 
 uint32_t dc_dsc_stream_bandwidth_overhead_in_kbps(
 		const struct dc_crtc_timing *timing,
-		const int num_slices_h,
+		const uint32_t num_slices_h,
 		const bool is_dp);
 
 void dc_dsc_dump_decoder_caps(const struct display_stream_compressor *dsc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 32f7c7c076c8..1649fbab08aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -159,8 +159,8 @@ struct luminance_data {
 	int luminance_millinits[LUMINANCE_DATA_TABLE_SIZE];
 	int flicker_criteria_milli_nits_GAMING;
 	int flicker_criteria_milli_nits_STATIC;
-	int nominal_refresh_rate;
-	int dm_max_decrease_from_nominal;
+	unsigned int nominal_refresh_rate;
+	unsigned int dm_max_decrease_from_nominal;
 };
 
 enum dc_drr_trigger_mode {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 12ce4a059231..3ec49f4e277f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -917,7 +917,7 @@ struct dsc_dec_dpcd_caps {
 	union dsc_slice_caps2 slice_caps2;
 	int32_t lb_bit_depth;
 	bool is_block_pred_supported;
-	int32_t edp_max_bits_per_pixel; /* Valid only in eDP */
+	uint32_t edp_max_bits_per_pixel; /* Valid only in eDP */
 	union dsc_color_formats color_formats;
 	union dsc_color_depth color_depth;
 	int32_t throughput_mode_0_mps; /* In MPs */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
index 36456c9971c8..fcaa3884d705 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
@@ -205,7 +205,7 @@ static bool update_cfg_data(
 static bool dcn21_link_encoder_acquire_phy(struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	int value;
+	uint32_t value;
 
 	if (enc->features.flags.bits.DP_IS_USB_C) {
 		REG_GET(RDPCSTX_PHY_CNTL6,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
index 872ea3646023..59b68422334d 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
@@ -450,7 +450,7 @@ static uint8_t get_frontend_source(
 unsigned int dcn10_get_dig_frontend(struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	int32_t value;
+	uint32_t value;
 	enum engine_id result;
 
 	REG_GET(DIG_BE_CNTL, DIG_FE_SOURCE_SELECT, &value);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 71710d96ffe3..ed7c989a5b13 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1105,7 +1105,7 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 }
 
 static void dcn20_adjust_freesync_v_startup(
-		const struct dc_crtc_timing *dc_crtc_timing, int *vstartup_start)
+		const struct dc_crtc_timing *dc_crtc_timing, unsigned int *vstartup_start)
 {
 	struct dc_crtc_timing patched_crtc_timing;
 	uint32_t asic_blank_end   = 0;
@@ -1253,7 +1253,7 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 
 static void swizzle_to_dml_params(
 		enum swizzle_mode_values swizzle,
-		unsigned int *sw_mode)
+		int *sw_mode)
 {
 	switch (swizzle) {
 	case DC_SW_LINEAR:
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 3ff71751db1e..961b705acfa9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -296,7 +296,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		double UrgentOutOfOrderReturn,
 		double ReturnBW,
 		bool GPUVMEnable,
-		int dpte_group_bytes[],
+		unsigned int dpte_group_bytes[],
 		unsigned int MetaChunkSize,
 		double UrgentLatency,
 		double ExtraLatency,
@@ -307,7 +307,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		double SRExitTime,
 		double SREnterPlusExitTime,
 		double DCFCLKDeepSleep,
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		bool DCCEnable[],
 		double DPPCLK[],
 		double SwathWidthSingleDPPY[],
@@ -346,7 +346,7 @@ static void CalculateDCFCLKDeepSleep(
 		double BytePerPixelDETC[],
 		double VRatio[],
 		double SwathWidthY[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		double HRatio[],
 		double PixelClock[],
 		double PSCL_THROUGHPUT[],
@@ -390,7 +390,7 @@ static void CalculatePixelDeliveryTimes(
 		double                 VRatioPrefetchC[],
 		unsigned int           swath_width_luma_ub[],
 		unsigned int           swath_width_chroma_ub[],
-		int                    DPPPerPlane[],
+		unsigned int           DPPPerPlane[],
 		double                 HRatio[],
 		double                 PixelClock[],
 		double                 PSCL_THROUGHPUT[],
@@ -436,7 +436,7 @@ static void CalculateMetaAndPTETimes(
 		unsigned int           meta_row_height[],
 		unsigned int           meta_req_width[],
 		unsigned int           meta_req_height[],
-		int                   dpte_group_bytes[],
+		unsigned int           dpte_group_bytes[],
 		unsigned int           PTERequestSizeY[],
 		unsigned int           PTERequestSizeC[],
 		unsigned int           PixelPTEReqWidthY[],
@@ -477,8 +477,8 @@ static double CalculateExtraLatency(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
 		int HostVMMaxPageTableLevels,
@@ -5257,7 +5257,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		double UrgentOutOfOrderReturn,
 		double ReturnBW,
 		bool GPUVMEnable,
-		int dpte_group_bytes[],
+		unsigned int dpte_group_bytes[],
 		unsigned int MetaChunkSize,
 		double UrgentLatency,
 		double ExtraLatency,
@@ -5268,7 +5268,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		double SRExitTime,
 		double SREnterPlusExitTime,
 		double DCFCLKDeepSleep,
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		bool DCCEnable[],
 		double DPPCLK[],
 		double SwathWidthSingleDPPY[],
@@ -5543,7 +5543,7 @@ static void CalculateDCFCLKDeepSleep(
 		double BytePerPixelDETC[],
 		double VRatio[],
 		double SwathWidthY[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		double HRatio[],
 		double PixelClock[],
 		double PSCL_THROUGHPUT[],
@@ -5749,7 +5749,7 @@ static void CalculatePixelDeliveryTimes(
 		double VRatioPrefetchC[],
 		unsigned int swath_width_luma_ub[],
 		unsigned int swath_width_chroma_ub[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		double HRatio[],
 		double PixelClock[],
 		double PSCL_THROUGHPUT[],
@@ -5870,7 +5870,7 @@ static void CalculateMetaAndPTETimes(
 		unsigned int meta_row_height[],
 		unsigned int meta_req_width[],
 		unsigned int meta_req_height[],
-		int dpte_group_bytes[],
+		unsigned int dpte_group_bytes[],
 		unsigned int PTERequestSizeY[],
 		unsigned int PTERequestSizeC[],
 		unsigned int PixelPTEReqWidthY[],
@@ -6126,8 +6126,8 @@ static double CalculateExtraLatency(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
 		int HostVMMaxPageTableLevels,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 3c9040117cc4..f0b1bfb408f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -285,8 +285,8 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 static void CalculateDCFCLKDeepSleep(
 		struct display_mode_lib *mode_lib,
 		unsigned int NumberOfActivePlanes,
-		int BytePerPixelY[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelY[],
+		unsigned int BytePerPixelC[],
 		double VRatio[],
 		double VRatioChroma[],
 		double SwathWidthY[],
@@ -327,7 +327,7 @@ static void CalculateUrgentBurstFactor(
 static void UseMinimumDCFCLK(
 		struct display_mode_lib *mode_lib,
 		struct vba_vars_st *v,
-		int MaxPrefetchMode,
+		unsigned int MaxPrefetchMode,
 		int ReorderingBytes);
 
 static void CalculatePixelDeliveryTimes(
@@ -345,7 +345,7 @@ static void CalculatePixelDeliveryTimes(
 		double PSCL_THROUGHPUT[],
 		double PSCL_THROUGHPUT_CHROMA[],
 		double DPPCLK[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelC[],
 		enum scan_direction_class SourceScan[],
 		unsigned int NumberOfCursors[],
 		unsigned int CursorWidth[][2],
@@ -370,35 +370,35 @@ static void CalculateMetaAndPTETimes(
 		bool GPUVMEnable,
 		int MetaChunkSize,
 		int MinMetaChunkSizeBytes,
-		int HTotal[],
+		unsigned int HTotal[],
 		double VRatio[],
 		double VRatioChroma[],
 		double DestinationLinesToRequestRowInVBlank[],
 		double DestinationLinesToRequestRowInImmediateFlip[],
 		bool DCCEnable[],
 		double PixelClock[],
-		int BytePerPixelY[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelY[],
+		unsigned int BytePerPixelC[],
 		enum scan_direction_class SourceScan[],
-		int dpte_row_height[],
-		int dpte_row_height_chroma[],
-		int meta_row_width[],
-		int meta_row_width_chroma[],
-		int meta_row_height[],
-		int meta_row_height_chroma[],
-		int meta_req_width[],
-		int meta_req_width_chroma[],
-		int meta_req_height[],
-		int meta_req_height_chroma[],
-		int dpte_group_bytes[],
-		int PTERequestSizeY[],
-		int PTERequestSizeC[],
-		int PixelPTEReqWidthY[],
-		int PixelPTEReqHeightY[],
-		int PixelPTEReqWidthC[],
-		int PixelPTEReqHeightC[],
-		int dpte_row_width_luma_ub[],
-		int dpte_row_width_chroma_ub[],
+		unsigned int dpte_row_height[],
+		unsigned int dpte_row_height_chroma[],
+		unsigned int meta_row_width[],
+		unsigned int meta_row_width_chroma[],
+		unsigned int meta_row_height[],
+		unsigned int meta_row_height_chroma[],
+		unsigned int meta_req_width[],
+		unsigned int meta_req_width_chroma[],
+		unsigned int meta_req_height[],
+		unsigned int meta_req_height_chroma[],
+		unsigned int dpte_group_bytes[],
+		unsigned int PTERequestSizeY[],
+		unsigned int PTERequestSizeC[],
+		unsigned int PixelPTEReqWidthY[],
+		unsigned int PixelPTEReqHeightY[],
+		unsigned int PixelPTEReqWidthC[],
+		unsigned int PixelPTEReqHeightC[],
+		unsigned int dpte_row_width_luma_ub[],
+		unsigned int dpte_row_width_chroma_ub[],
 		double DST_Y_PER_PTE_ROW_NOM_L[],
 		double DST_Y_PER_PTE_ROW_NOM_C[],
 		double DST_Y_PER_META_ROW_NOM_L[],
@@ -421,18 +421,18 @@ static void CalculateVMGroupAndRequestTimes(
 		bool GPUVMEnable,
 		unsigned int GPUVMMaxPageTableLevels,
 		unsigned int HTotal[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelC[],
 		double DestinationLinesToRequestVMInVBlank[],
 		double DestinationLinesToRequestVMInImmediateFlip[],
 		bool DCCEnable[],
 		double PixelClock[],
-		int dpte_row_width_luma_ub[],
-		int dpte_row_width_chroma_ub[],
-		int vm_group_bytes[],
+		unsigned int dpte_row_width_luma_ub[],
+		unsigned int dpte_row_width_chroma_ub[],
+		unsigned int vm_group_bytes[],
 		unsigned int dpde0_bytes_per_frame_ub_l[],
 		unsigned int dpde0_bytes_per_frame_ub_c[],
-		int meta_pte_bytes_per_frame_ub_l[],
-		int meta_pte_bytes_per_frame_ub_c[],
+		unsigned int meta_pte_bytes_per_frame_ub_l[],
+		unsigned int meta_pte_bytes_per_frame_ub_c[],
 		double TimePerVMGroupVBlank[],
 		double TimePerVMGroupFlip[],
 		double TimePerVMRequestVBlank[],
@@ -446,27 +446,27 @@ static void CalculateStutterEfficiency(
 		double ReturnBW,
 		double SRExitTime,
 		bool SynchronizedVBlank,
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		unsigned int DETBufferSizeY[],
-		int BytePerPixelY[],
+		unsigned int BytePerPixelY[],
 		double BytePerPixelDETY[],
 		double SwathWidthY[],
-		int SwathHeightY[],
-		int SwathHeightC[],
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
 		double DCCRateLuma[],
 		double DCCRateChroma[],
-		int HTotal[],
-		int VTotal[],
+		unsigned int HTotal[],
+		unsigned int VTotal[],
 		double PixelClock[],
 		double VRatio[],
 		enum scan_direction_class SourceScan[],
-		int BlockHeight256BytesY[],
-		int BlockWidth256BytesY[],
-		int BlockHeight256BytesC[],
-		int BlockWidth256BytesC[],
-		int DCCYMaxUncompressedBlock[],
-		int DCCCMaxUncompressedBlock[],
-		int VActive[],
+		unsigned int BlockHeight256BytesY[],
+		unsigned int BlockWidth256BytesY[],
+		unsigned int BlockHeight256BytesC[],
+		unsigned int BlockWidth256BytesC[],
+		unsigned int DCCYMaxUncompressedBlock[],
+		unsigned int DCCCMaxUncompressedBlock[],
+		unsigned int VActive[],
 		bool DCCEnable[],
 		bool WritebackEnable[],
 		double ReadBandwidthPlaneLuma[],
@@ -486,32 +486,32 @@ static void CalculateSwathAndDETConfiguration(
 		enum scan_direction_class SourceScan[],
 		enum source_format_class SourcePixelFormat[],
 		enum dm_swizzle_mode SurfaceTiling[],
-		int ViewportWidth[],
-		int ViewportHeight[],
-		int SurfaceWidthY[],
-		int SurfaceWidthC[],
-		int SurfaceHeightY[],
-		int SurfaceHeightC[],
-		int Read256BytesBlockHeightY[],
-		int Read256BytesBlockHeightC[],
-		int Read256BytesBlockWidthY[],
-		int Read256BytesBlockWidthC[],
+		unsigned int ViewportWidth[],
+		unsigned int ViewportHeight[],
+		unsigned int SurfaceWidthY[],
+		unsigned int SurfaceWidthC[],
+		unsigned int SurfaceHeightY[],
+		unsigned int SurfaceHeightC[],
+		unsigned int Read256BytesBlockHeightY[],
+		unsigned int Read256BytesBlockHeightC[],
+		unsigned int Read256BytesBlockWidthY[],
+		unsigned int Read256BytesBlockWidthC[],
 		enum odm_combine_mode ODMCombineEnabled[],
-		int BlendingAndTiming[],
-		int BytePerPixY[],
-		int BytePerPixC[],
+		unsigned int BlendingAndTiming[],
+		unsigned int BytePerPixY[],
+		unsigned int BytePerPixC[],
 		double BytePerPixDETY[],
 		double BytePerPixDETC[],
-		int HActive[],
+		unsigned int HActive[],
 		double HRatio[],
 		double HRatioChroma[],
-		int DPPPerPlane[],
-		int swath_width_luma_ub[],
-		int swath_width_chroma_ub[],
+		unsigned int DPPPerPlane[],
+		unsigned int swath_width_luma_ub[],
+		unsigned int swath_width_chroma_ub[],
 		double SwathWidth[],
 		double SwathWidthChroma[],
-		int SwathHeightY[],
-		int SwathHeightC[],
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
 		unsigned int DETBufferSizeY[],
 		unsigned int DETBufferSizeC[],
 		bool ViewportSizeSupportPerPlane[],
@@ -528,22 +528,22 @@ static void CalculateSwathWidth(
 		unsigned int SurfaceHeightY[],
 		unsigned int SurfaceHeightC[],
 		enum odm_combine_mode ODMCombineEnabled[],
-		int BytePerPixY[],
-		int BytePerPixC[],
-		int Read256BytesBlockHeightY[],
-		int Read256BytesBlockHeightC[],
-		int Read256BytesBlockWidthY[],
-		int Read256BytesBlockWidthC[],
-		int BlendingAndTiming[],
+		unsigned int BytePerPixY[],
+		unsigned int BytePerPixC[],
+		unsigned int Read256BytesBlockHeightY[],
+		unsigned int Read256BytesBlockHeightC[],
+		unsigned int Read256BytesBlockWidthY[],
+		unsigned int Read256BytesBlockWidthC[],
+		unsigned int BlendingAndTiming[],
 		unsigned int HActive[],
 		double HRatio[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		double SwathWidthSingleDPPY[],
 		double SwathWidthSingleDPPC[],
 		double SwathWidthY[],
 		double SwathWidthC[],
-		int MaximumSwathHeightY[],
-		int MaximumSwathHeightC[],
+		unsigned int MaximumSwathHeightY[],
+		unsigned int MaximumSwathHeightC[],
 		unsigned int swath_width_luma_ub[],
 		unsigned int swath_width_chroma_ub[]);
 static double CalculateExtraLatency(
@@ -558,8 +558,8 @@ static double CalculateExtraLatency(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
 		double HostVMMinPageSize,
@@ -573,8 +573,8 @@ static double CalculateExtraLatencyBytes(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		unsigned int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
 		double HostVMMinPageSize,
@@ -2888,18 +2888,18 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	// Display Pipe Configuration
 	double BytePerPixDETY[DC__NUM_DPP__MAX] = { 0 };
 	double BytePerPixDETC[DC__NUM_DPP__MAX] = { 0 };
-	int BytePerPixY[DC__NUM_DPP__MAX] = { 0 };
-	int BytePerPixC[DC__NUM_DPP__MAX] = { 0 };
-	int Read256BytesBlockHeightY[DC__NUM_DPP__MAX] = { 0 };
-	int Read256BytesBlockHeightC[DC__NUM_DPP__MAX] = { 0 };
-	int Read256BytesBlockWidthY[DC__NUM_DPP__MAX] = { 0 };
-	int Read256BytesBlockWidthC[DC__NUM_DPP__MAX] = { 0 };
+	unsigned int BytePerPixY[DC__NUM_DPP__MAX] = { 0 };
+	unsigned int BytePerPixC[DC__NUM_DPP__MAX] = { 0 };
+	unsigned int Read256BytesBlockHeightY[DC__NUM_DPP__MAX] = { 0 };
+	unsigned int Read256BytesBlockHeightC[DC__NUM_DPP__MAX] = { 0 };
+	unsigned int Read256BytesBlockWidthY[DC__NUM_DPP__MAX] = { 0 };
+	unsigned int Read256BytesBlockWidthC[DC__NUM_DPP__MAX] = { 0 };
 	double dummy1[DC__NUM_DPP__MAX] = { 0 };
 	double dummy2[DC__NUM_DPP__MAX] = { 0 };
 	double dummy3[DC__NUM_DPP__MAX] = { 0 };
 	double dummy4[DC__NUM_DPP__MAX] = { 0 };
-	int dummy5[DC__NUM_DPP__MAX] = { 0 };
-	int dummy6[DC__NUM_DPP__MAX] = { 0 };
+	unsigned int dummy5[DC__NUM_DPP__MAX] = { 0 };
+	unsigned int dummy6[DC__NUM_DPP__MAX] = { 0 };
 	bool dummy7[DC__NUM_DPP__MAX] = { 0 };
 	bool dummysinglestring = 0;
 	unsigned int k;
@@ -3381,7 +3381,7 @@ static double TruncToValidBPP(
 void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
 {
 	struct vba_vars_st *v = &mode_lib->vba;
-	int MinPrefetchMode, MaxPrefetchMode;
+	unsigned int MinPrefetchMode, MaxPrefetchMode;
 	int idx, start_state;
 	unsigned int i, j, k, m;
 	bool   EnoughWritebackUnits = true;
@@ -4550,7 +4550,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	for (i = start_state; i < mode_lib->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
-			int NextPrefetchModeState = MinPrefetchMode;
+			unsigned int NextPrefetchModeState = MinPrefetchMode;
 
 			v->TimeCalc = 24 / v->ProjectedDCFCLKDeepSleep[i][j];
 
@@ -5153,8 +5153,8 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 static void CalculateDCFCLKDeepSleep(
 		struct display_mode_lib *mode_lib,
 		unsigned int NumberOfActivePlanes,
-		int BytePerPixelY[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelY[],
+		unsigned int BytePerPixelC[],
 		double VRatio[],
 		double VRatioChroma[],
 		double SwathWidthY[],
@@ -5306,7 +5306,7 @@ static void CalculatePixelDeliveryTimes(
 		double PSCL_THROUGHPUT[],
 		double PSCL_THROUGHPUT_CHROMA[],
 		double DPPCLK[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelC[],
 		enum scan_direction_class SourceScan[],
 		unsigned int NumberOfCursors[],
 		unsigned int CursorWidth[][2],
@@ -5411,35 +5411,35 @@ static void CalculateMetaAndPTETimes(
 		bool GPUVMEnable,
 		int MetaChunkSize,
 		int MinMetaChunkSizeBytes,
-		int HTotal[],
+		unsigned int HTotal[],
 		double VRatio[],
 		double VRatioChroma[],
 		double DestinationLinesToRequestRowInVBlank[],
 		double DestinationLinesToRequestRowInImmediateFlip[],
 		bool DCCEnable[],
 		double PixelClock[],
-		int BytePerPixelY[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelY[],
+		unsigned int BytePerPixelC[],
 		enum scan_direction_class SourceScan[],
-		int dpte_row_height[],
-		int dpte_row_height_chroma[],
-		int meta_row_width[],
-		int meta_row_width_chroma[],
-		int meta_row_height[],
-		int meta_row_height_chroma[],
-		int meta_req_width[],
-		int meta_req_width_chroma[],
-		int meta_req_height[],
-		int meta_req_height_chroma[],
-		int dpte_group_bytes[],
-		int PTERequestSizeY[],
-		int PTERequestSizeC[],
-		int PixelPTEReqWidthY[],
-		int PixelPTEReqHeightY[],
-		int PixelPTEReqWidthC[],
-		int PixelPTEReqHeightC[],
-		int dpte_row_width_luma_ub[],
-		int dpte_row_width_chroma_ub[],
+		unsigned int dpte_row_height[],
+		unsigned int dpte_row_height_chroma[],
+		unsigned int meta_row_width[],
+		unsigned int meta_row_width_chroma[],
+		unsigned int meta_row_height[],
+		unsigned int meta_row_height_chroma[],
+		unsigned int meta_req_width[],
+		unsigned int meta_req_width_chroma[],
+		unsigned int meta_req_height[],
+		unsigned int meta_req_height_chroma[],
+		unsigned int dpte_group_bytes[],
+		unsigned int PTERequestSizeY[],
+		unsigned int PTERequestSizeC[],
+		unsigned int PixelPTEReqWidthY[],
+		unsigned int PixelPTEReqHeightY[],
+		unsigned int PixelPTEReqWidthC[],
+		unsigned int PixelPTEReqHeightC[],
+		unsigned int dpte_row_width_luma_ub[],
+		unsigned int dpte_row_width_chroma_ub[],
 		double DST_Y_PER_PTE_ROW_NOM_L[],
 		double DST_Y_PER_PTE_ROW_NOM_C[],
 		double DST_Y_PER_META_ROW_NOM_L[],
@@ -5584,18 +5584,18 @@ static void CalculateVMGroupAndRequestTimes(
 		bool GPUVMEnable,
 		unsigned int GPUVMMaxPageTableLevels,
 		unsigned int HTotal[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelC[],
 		double DestinationLinesToRequestVMInVBlank[],
 		double DestinationLinesToRequestVMInImmediateFlip[],
 		bool DCCEnable[],
 		double PixelClock[],
-		int dpte_row_width_luma_ub[],
-		int dpte_row_width_chroma_ub[],
-		int vm_group_bytes[],
+		unsigned int dpte_row_width_luma_ub[],
+		unsigned int dpte_row_width_chroma_ub[],
+		unsigned int vm_group_bytes[],
 		unsigned int dpde0_bytes_per_frame_ub_l[],
 		unsigned int dpde0_bytes_per_frame_ub_c[],
-		int meta_pte_bytes_per_frame_ub_l[],
-		int meta_pte_bytes_per_frame_ub_c[],
+		unsigned int meta_pte_bytes_per_frame_ub_l[],
+		unsigned int meta_pte_bytes_per_frame_ub_c[],
 		double TimePerVMGroupVBlank[],
 		double TimePerVMGroupFlip[],
 		double TimePerVMRequestVBlank[],
@@ -5700,27 +5700,27 @@ static void CalculateStutterEfficiency(
 		double ReturnBW,
 		double SRExitTime,
 		bool SynchronizedVBlank,
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		unsigned int DETBufferSizeY[],
-		int BytePerPixelY[],
+		unsigned int BytePerPixelY[],
 		double BytePerPixelDETY[],
 		double SwathWidthY[],
-		int SwathHeightY[],
-		int SwathHeightC[],
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
 		double DCCRateLuma[],
 		double DCCRateChroma[],
-		int HTotal[],
-		int VTotal[],
+		unsigned int HTotal[],
+		unsigned int VTotal[],
 		double PixelClock[],
 		double VRatio[],
 		enum scan_direction_class SourceScan[],
-		int BlockHeight256BytesY[],
-		int BlockWidth256BytesY[],
-		int BlockHeight256BytesC[],
-		int BlockWidth256BytesC[],
-		int DCCYMaxUncompressedBlock[],
-		int DCCCMaxUncompressedBlock[],
-		int VActive[],
+		unsigned int BlockHeight256BytesY[],
+		unsigned int BlockWidth256BytesY[],
+		unsigned int BlockHeight256BytesC[],
+		unsigned int BlockWidth256BytesC[],
+		unsigned int DCCYMaxUncompressedBlock[],
+		unsigned int DCCCMaxUncompressedBlock[],
+		unsigned int VActive[],
 		bool DCCEnable[],
 		bool WritebackEnable[],
 		double ReadBandwidthPlaneLuma[],
@@ -5854,42 +5854,42 @@ static void CalculateSwathAndDETConfiguration(
 		enum scan_direction_class SourceScan[],
 		enum source_format_class SourcePixelFormat[],
 		enum dm_swizzle_mode SurfaceTiling[],
-		int ViewportWidth[],
-		int ViewportHeight[],
-		int SurfaceWidthY[],
-		int SurfaceWidthC[],
-		int SurfaceHeightY[],
-		int SurfaceHeightC[],
-		int Read256BytesBlockHeightY[],
-		int Read256BytesBlockHeightC[],
-		int Read256BytesBlockWidthY[],
-		int Read256BytesBlockWidthC[],
+		unsigned int ViewportWidth[],
+		unsigned int ViewportHeight[],
+		unsigned int SurfaceWidthY[],
+		unsigned int SurfaceWidthC[],
+		unsigned int SurfaceHeightY[],
+		unsigned int SurfaceHeightC[],
+		unsigned int Read256BytesBlockHeightY[],
+		unsigned int Read256BytesBlockHeightC[],
+		unsigned int Read256BytesBlockWidthY[],
+		unsigned int Read256BytesBlockWidthC[],
 		enum odm_combine_mode ODMCombineEnabled[],
-		int BlendingAndTiming[],
-		int BytePerPixY[],
-		int BytePerPixC[],
+		unsigned int BlendingAndTiming[],
+		unsigned int BytePerPixY[],
+		unsigned int BytePerPixC[],
 		double BytePerPixDETY[],
 		double BytePerPixDETC[],
-		int HActive[],
+		unsigned int HActive[],
 		double HRatio[],
 		double HRatioChroma[],
-		int DPPPerPlane[],
-		int swath_width_luma_ub[],
-		int swath_width_chroma_ub[],
+		unsigned int DPPPerPlane[],
+		unsigned int swath_width_luma_ub[],
+		unsigned int swath_width_chroma_ub[],
 		double SwathWidth[],
 		double SwathWidthChroma[],
-		int SwathHeightY[],
-		int SwathHeightC[],
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
 		unsigned int DETBufferSizeY[],
 		unsigned int DETBufferSizeC[],
 		bool ViewportSizeSupportPerPlane[],
 		bool *ViewportSizeSupport)
 {
 	(void)HRatioChroma;
-	int MaximumSwathHeightY[DC__NUM_DPP__MAX] = { 0 };
-	int MaximumSwathHeightC[DC__NUM_DPP__MAX] = { 0 };
-	int MinimumSwathHeightY = 0;
-	int MinimumSwathHeightC = 0;
+	unsigned int MaximumSwathHeightY[DC__NUM_DPP__MAX] = { 0 };
+	unsigned int MaximumSwathHeightC[DC__NUM_DPP__MAX] = { 0 };
+	unsigned int MinimumSwathHeightY = 0;
+	unsigned int MinimumSwathHeightC = 0;
 	long RoundedUpMaxSwathSizeBytesY = 0;
 	long RoundedUpMaxSwathSizeBytesC = 0;
 	long RoundedUpMinSwathSizeBytesY = 0;
@@ -6049,22 +6049,22 @@ static void CalculateSwathWidth(
 		unsigned int SurfaceHeightY[],
 		unsigned int SurfaceHeightC[],
 		enum odm_combine_mode ODMCombineEnabled[],
-		int BytePerPixY[],
-		int BytePerPixC[],
-		int Read256BytesBlockHeightY[],
-		int Read256BytesBlockHeightC[],
-		int Read256BytesBlockWidthY[],
-		int Read256BytesBlockWidthC[],
-		int BlendingAndTiming[],
+		unsigned int BytePerPixY[],
+		unsigned int BytePerPixC[],
+		unsigned int Read256BytesBlockHeightY[],
+		unsigned int Read256BytesBlockHeightC[],
+		unsigned int Read256BytesBlockWidthY[],
+		unsigned int Read256BytesBlockWidthC[],
+		unsigned int BlendingAndTiming[],
 		unsigned int HActive[],
 		double HRatio[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		double SwathWidthSingleDPPY[],
 		double SwathWidthSingleDPPC[],
 		double SwathWidthY[],
 		double SwathWidthC[],
-		int MaximumSwathHeightY[],
-		int MaximumSwathHeightC[],
+		unsigned int MaximumSwathHeightY[],
+		unsigned int MaximumSwathHeightC[],
 		unsigned int swath_width_luma_ub[],
 		unsigned int swath_width_chroma_ub[])
 {
@@ -6157,8 +6157,8 @@ static double CalculateExtraLatency(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
 		double HostVMMinPageSize,
@@ -6193,8 +6193,8 @@ static double CalculateExtraLatencyBytes(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		unsigned int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
 		double HostVMMinPageSize,
@@ -6251,7 +6251,7 @@ static double CalculateUrgentLatency(
 static noinline_for_stack void UseMinimumDCFCLK(
 		struct display_mode_lib *mode_lib,
 		struct vba_vars_st *v,
-		int MaxPrefetchMode,
+		unsigned int MaxPrefetchMode,
 		int ReorderingBytes)
 {
 	double   NormalEfficiency = 0;
@@ -6276,7 +6276,7 @@ static noinline_for_stack void UseMinimumDCFCLK(
 			double ExtraLatencyBytes = 0;
 			double ExtraLatencyCycles = 0;
 			double DCFCLKRequiredForPeakBandwidth = 0;
-			int NoOfDPPState[DC__NUM_DPP__MAX] = { 0 };
+			unsigned int NoOfDPPState[DC__NUM_DPP__MAX] = { 0 };
 			double MinimumTvmPlus2Tr0 = 0;
 
 			TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 173251d738f2..f9224a433220 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -157,7 +157,7 @@ static bool CalculatePrefetchSchedule(
 		double *Tdmdl_vm,
 		double *Tdmdl,
 		double *TSetup,
-		int *VUpdateOffsetPix,
+		unsigned int *VUpdateOffsetPix,
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix);
 static double RoundToDFSGranularityUp(double Clock, double VCOSpeed);
@@ -218,19 +218,19 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *MetaRowByte,
 		unsigned int *PixelPTEBytesPerRow,
 		bool *PTEBufferSizeNotExceeded,
-		int *dpte_row_width_ub,
+		unsigned int *dpte_row_width_ub,
 		unsigned int *dpte_row_height,
 		unsigned int *MetaRequestWidth,
 		unsigned int *MetaRequestHeight,
 		unsigned int *meta_row_width,
 		unsigned int *meta_row_height,
-		int *vm_group_bytes,
+		unsigned int *vm_group_bytes,
 		unsigned int *dpte_group_bytes,
 		unsigned int *PixelPTEReqWidth,
 		unsigned int *PixelPTEReqHeight,
 		unsigned int *PTERequestSize,
-		int *DPDE0BytesFrame,
-		int *MetaPTEBytesFrame);
+		unsigned int *DPDE0BytesFrame,
+		unsigned int *MetaPTEBytesFrame);
 static double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime);
 static void CalculateRowBandwidth(
 		bool GPUVMEnable,
@@ -285,7 +285,7 @@ static void CalculateVupdateAndDynamicMetadataParameters(
 		double *Tdmbf,
 		double *Tdmec,
 		double *Tdmsks,
-		int *VUpdateOffsetPix,
+		unsigned int *VUpdateOffsetPix,
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix);
 
@@ -318,8 +318,8 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 static void CalculateDCFCLKDeepSleep(
 		struct display_mode_lib *mode_lib,
 		unsigned int NumberOfActivePlanes,
-		int BytePerPixelY[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelY[],
+		unsigned int BytePerPixelC[],
 		double VRatio[],
 		double VRatioChroma[],
 		double SwathWidthY[],
@@ -377,7 +377,7 @@ static void CalculatePixelDeliveryTimes(
 		double PSCL_THROUGHPUT[],
 		double PSCL_THROUGHPUT_CHROMA[],
 		double DPPCLK[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelC[],
 		enum scan_direction_class SourceScan[],
 		unsigned int NumberOfCursors[],
 		unsigned int CursorWidth[][DC__NUM_CURSOR__MAX],
@@ -402,35 +402,35 @@ static void CalculateMetaAndPTETimes(
 		bool GPUVMEnable,
 		int MetaChunkSize,
 		int MinMetaChunkSizeBytes,
-		int HTotal[],
+		unsigned int HTotal[],
 		double VRatio[],
 		double VRatioChroma[],
 		double DestinationLinesToRequestRowInVBlank[],
 		double DestinationLinesToRequestRowInImmediateFlip[],
 		bool DCCEnable[],
 		double PixelClock[],
-		int BytePerPixelY[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelY[],
+		unsigned int BytePerPixelC[],
 		enum scan_direction_class SourceScan[],
-		int dpte_row_height[],
-		int dpte_row_height_chroma[],
-		int meta_row_width[],
-		int meta_row_width_chroma[],
-		int meta_row_height[],
-		int meta_row_height_chroma[],
-		int meta_req_width[],
-		int meta_req_width_chroma[],
-		int meta_req_height[],
-		int meta_req_height_chroma[],
-		int dpte_group_bytes[],
-		int PTERequestSizeY[],
-		int PTERequestSizeC[],
-		int PixelPTEReqWidthY[],
-		int PixelPTEReqHeightY[],
-		int PixelPTEReqWidthC[],
-		int PixelPTEReqHeightC[],
-		int dpte_row_width_luma_ub[],
-		int dpte_row_width_chroma_ub[],
+		unsigned int dpte_row_height[],
+		unsigned int dpte_row_height_chroma[],
+		unsigned int meta_row_width[],
+		unsigned int meta_row_width_chroma[],
+		unsigned int meta_row_height[],
+		unsigned int meta_row_height_chroma[],
+		unsigned int meta_req_width[],
+		unsigned int meta_req_width_chroma[],
+		unsigned int meta_req_height[],
+		unsigned int meta_req_height_chroma[],
+		unsigned int dpte_group_bytes[],
+		unsigned int PTERequestSizeY[],
+		unsigned int PTERequestSizeC[],
+		unsigned int PixelPTEReqWidthY[],
+		unsigned int PixelPTEReqHeightY[],
+		unsigned int PixelPTEReqWidthC[],
+		unsigned int PixelPTEReqHeightC[],
+		unsigned int dpte_row_width_luma_ub[],
+		unsigned int dpte_row_width_chroma_ub[],
 		double DST_Y_PER_PTE_ROW_NOM_L[],
 		double DST_Y_PER_PTE_ROW_NOM_C[],
 		double DST_Y_PER_META_ROW_NOM_L[],
@@ -453,18 +453,18 @@ static void CalculateVMGroupAndRequestTimes(
 		bool GPUVMEnable,
 		unsigned int GPUVMMaxPageTableLevels,
 		unsigned int HTotal[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelC[],
 		double DestinationLinesToRequestVMInVBlank[],
 		double DestinationLinesToRequestVMInImmediateFlip[],
 		bool DCCEnable[],
 		double PixelClock[],
-		int dpte_row_width_luma_ub[],
-		int dpte_row_width_chroma_ub[],
-		int vm_group_bytes[],
+		unsigned int dpte_row_width_luma_ub[],
+		unsigned int dpte_row_width_chroma_ub[],
+		unsigned int vm_group_bytes[],
 		unsigned int dpde0_bytes_per_frame_ub_l[],
 		unsigned int dpde0_bytes_per_frame_ub_c[],
-		int meta_pte_bytes_per_frame_ub_l[],
-		int meta_pte_bytes_per_frame_ub_c[],
+		unsigned int meta_pte_bytes_per_frame_ub_l[],
+		unsigned int meta_pte_bytes_per_frame_ub_c[],
 		double TimePerVMGroupVBlank[],
 		double TimePerVMGroupFlip[],
 		double TimePerVMRequestVBlank[],
@@ -492,29 +492,29 @@ static void CalculateStutterEfficiency(
 		bool ProgressiveToInterlaceUnitInOPP,
 		bool Interlace[],
 		double MinTTUVBlank[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		unsigned int DETBufferSizeY[],
-		int BytePerPixelY[],
+		unsigned int BytePerPixelY[],
 		double BytePerPixelDETY[],
 		double SwathWidthY[],
-		int SwathHeightY[],
-		int SwathHeightC[],
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
 		double NetDCCRateLuma[],
 		double NetDCCRateChroma[],
 		double DCCFractionOfZeroSizeRequestsLuma[],
 		double DCCFractionOfZeroSizeRequestsChroma[],
-		int HTotal[],
-		int VTotal[],
+		unsigned int HTotal[],
+		unsigned int VTotal[],
 		double PixelClock[],
 		double VRatio[],
 		enum scan_direction_class SourceScan[],
-		int BlockHeight256BytesY[],
-		int BlockWidth256BytesY[],
-		int BlockHeight256BytesC[],
-		int BlockWidth256BytesC[],
-		int DCCYMaxUncompressedBlock[],
-		int DCCCMaxUncompressedBlock[],
-		int VActive[],
+		unsigned int BlockHeight256BytesY[],
+		unsigned int BlockWidth256BytesY[],
+		unsigned int BlockHeight256BytesC[],
+		unsigned int BlockWidth256BytesC[],
+		unsigned int DCCYMaxUncompressedBlock[],
+		unsigned int DCCCMaxUncompressedBlock[],
+		unsigned int VActive[],
 		bool DCCEnable[],
 		bool WritebackEnable[],
 		double ReadBandwidthPlaneLuma[],
@@ -539,32 +539,32 @@ static void CalculateSwathAndDETConfiguration(
 		enum scan_direction_class SourceScan[],
 		enum source_format_class SourcePixelFormat[],
 		enum dm_swizzle_mode SurfaceTiling[],
-		int ViewportWidth[],
-		int ViewportHeight[],
-		int SurfaceWidthY[],
-		int SurfaceWidthC[],
-		int SurfaceHeightY[],
-		int SurfaceHeightC[],
-		int Read256BytesBlockHeightY[],
-		int Read256BytesBlockHeightC[],
-		int Read256BytesBlockWidthY[],
-		int Read256BytesBlockWidthC[],
+		unsigned int ViewportWidth[],
+		unsigned int ViewportHeight[],
+		unsigned int SurfaceWidthY[],
+		unsigned int SurfaceWidthC[],
+		unsigned int SurfaceHeightY[],
+		unsigned int SurfaceHeightC[],
+		unsigned int Read256BytesBlockHeightY[],
+		unsigned int Read256BytesBlockHeightC[],
+		unsigned int Read256BytesBlockWidthY[],
+		unsigned int Read256BytesBlockWidthC[],
 		enum odm_combine_mode ODMCombineEnabled[],
-		int BlendingAndTiming[],
-		int BytePerPixY[],
-		int BytePerPixC[],
+		unsigned int BlendingAndTiming[],
+		unsigned int BytePerPixY[],
+		unsigned int BytePerPixC[],
 		double BytePerPixDETY[],
 		double BytePerPixDETC[],
-		int HActive[],
+		unsigned int HActive[],
 		double HRatio[],
 		double HRatioChroma[],
-		int DPPPerPlane[],
-		int swath_width_luma_ub[],
-		int swath_width_chroma_ub[],
+		unsigned int DPPPerPlane[],
+		unsigned int swath_width_luma_ub[],
+		unsigned int swath_width_chroma_ub[],
 		double SwathWidth[],
 		double SwathWidthChroma[],
-		int SwathHeightY[],
-		int SwathHeightC[],
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
 		unsigned int DETBufferSizeY[],
 		unsigned int DETBufferSizeC[],
 		bool ViewportSizeSupportPerPlane[],
@@ -574,31 +574,31 @@ static void CalculateSwathWidth(
 		int NumberOfActivePlanes,
 		enum source_format_class SourcePixelFormat[],
 		enum scan_direction_class SourceScan[],
-		int ViewportWidth[],
-		int ViewportHeight[],
-		int SurfaceWidthY[],
-		int SurfaceWidthC[],
-		int SurfaceHeightY[],
-		int SurfaceHeightC[],
+		unsigned int ViewportWidth[],
+		unsigned int ViewportHeight[],
+		unsigned int SurfaceWidthY[],
+		unsigned int SurfaceWidthC[],
+		unsigned int SurfaceHeightY[],
+		unsigned int SurfaceHeightC[],
 		enum odm_combine_mode ODMCombineEnabled[],
-		int BytePerPixY[],
-		int BytePerPixC[],
-		int Read256BytesBlockHeightY[],
-		int Read256BytesBlockHeightC[],
-		int Read256BytesBlockWidthY[],
-		int Read256BytesBlockWidthC[],
-		int BlendingAndTiming[],
-		int HActive[],
+		unsigned int BytePerPixY[],
+		unsigned int BytePerPixC[],
+		unsigned int Read256BytesBlockHeightY[],
+		unsigned int Read256BytesBlockHeightC[],
+		unsigned int Read256BytesBlockWidthY[],
+		unsigned int Read256BytesBlockWidthC[],
+		unsigned int BlendingAndTiming[],
+		unsigned int HActive[],
 		double HRatio[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		double SwathWidthSingleDPPY[],
 		double SwathWidthSingleDPPC[],
 		double SwathWidthY[],
 		double SwathWidthC[],
-		int MaximumSwathHeightY[],
-		int MaximumSwathHeightC[],
-		int swath_width_luma_ub[],
-		int swath_width_chroma_ub[]);
+		unsigned int MaximumSwathHeightY[],
+		unsigned int MaximumSwathHeightC[],
+		unsigned int swath_width_luma_ub[],
+		unsigned int swath_width_chroma_ub[]);
 
 static double CalculateExtraLatency(
 		int RoundTripPingLatencyCycles,
@@ -612,8 +612,8 @@ static double CalculateExtraLatency(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double HostVMInefficiencyFactor,
 		double HostVMMinPageSize,
 		int HostVMMaxNonCachedPageTableLevels);
@@ -627,8 +627,8 @@ static double CalculateExtraLatencyBytes(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double HostVMInefficiencyFactor,
 		double HostVMMinPageSize,
 		int HostVMMaxNonCachedPageTableLevels);
@@ -652,7 +652,7 @@ static void CalculateUnboundedRequestAndCompressedBufferSize(
 		int CompressedBufferSegmentSizeInkByteFinal,
 		enum output_encoder_class *Output,
 		bool *UnboundedRequestEnabled,
-		int *CompressedBufferSizeInkByte);
+		unsigned int *CompressedBufferSizeInkByte);
 
 static bool UnboundedRequest(enum unbounded_requesting_policy UseUnboundedRequestingFinal, int TotalNumberOfActiveDPP, bool NoChroma, enum output_encoder_class Output);
 
@@ -869,7 +869,7 @@ static bool CalculatePrefetchSchedule(
 		double *Tdmdl_vm,
 		double *Tdmdl,
 		double *TSetup,
-		int *VUpdateOffsetPix,
+		unsigned int *VUpdateOffsetPix,
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix)
 {
@@ -1818,19 +1818,19 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *MetaRowByte,
 		unsigned int *PixelPTEBytesPerRow,
 		bool *PTEBufferSizeNotExceeded,
-		int *dpte_row_width_ub,
+		unsigned int *dpte_row_width_ub,
 		unsigned int *dpte_row_height,
 		unsigned int *MetaRequestWidth,
 		unsigned int *MetaRequestHeight,
 		unsigned int *meta_row_width,
 		unsigned int *meta_row_height,
-		int *vm_group_bytes,
+		unsigned int *vm_group_bytes,
 		unsigned int *dpte_group_bytes,
 		unsigned int *PixelPTEReqWidth,
 		unsigned int *PixelPTEReqHeight,
 		unsigned int *PTERequestSize,
-		int *DPDE0BytesFrame,
-		int *MetaPTEBytesFrame)
+		unsigned int *DPDE0BytesFrame,
+		unsigned int *MetaPTEBytesFrame)
 {
 	(void)SourcePixelFormat;
 	struct vba_vars_st *v = &mode_lib->vba;
@@ -3278,18 +3278,18 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	// Display Pipe Configuration
 	double BytePerPixDETY[DC__NUM_DPP__MAX];
 	double BytePerPixDETC[DC__NUM_DPP__MAX];
-	int BytePerPixY[DC__NUM_DPP__MAX];
-	int BytePerPixC[DC__NUM_DPP__MAX];
-	int Read256BytesBlockHeightY[DC__NUM_DPP__MAX];
-	int Read256BytesBlockHeightC[DC__NUM_DPP__MAX];
-	int Read256BytesBlockWidthY[DC__NUM_DPP__MAX];
-	int Read256BytesBlockWidthC[DC__NUM_DPP__MAX];
+	unsigned int BytePerPixY[DC__NUM_DPP__MAX];
+	unsigned int BytePerPixC[DC__NUM_DPP__MAX];
+	unsigned int Read256BytesBlockHeightY[DC__NUM_DPP__MAX];
+	unsigned int Read256BytesBlockHeightC[DC__NUM_DPP__MAX];
+	unsigned int Read256BytesBlockWidthY[DC__NUM_DPP__MAX];
+	unsigned int Read256BytesBlockWidthC[DC__NUM_DPP__MAX];
 	double dummy1[DC__NUM_DPP__MAX];
 	double dummy2[DC__NUM_DPP__MAX];
 	double dummy3[DC__NUM_DPP__MAX];
 	double dummy4[DC__NUM_DPP__MAX];
-	int dummy5[DC__NUM_DPP__MAX];
-	int dummy6[DC__NUM_DPP__MAX];
+	unsigned int dummy5[DC__NUM_DPP__MAX];
+	unsigned int dummy6[DC__NUM_DPP__MAX];
 	bool dummy7[DC__NUM_DPP__MAX];
 	bool dummysinglestring;
 
@@ -3429,7 +3429,7 @@ static void CalculateVupdateAndDynamicMetadataParameters(
 		double *Tdmbf,
 		double *Tdmec,
 		double *Tdmsks,
-		int *VUpdateOffsetPix,
+		unsigned int *VUpdateOffsetPix,
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix)
 {
@@ -3783,7 +3783,7 @@ static noinline void CalculatePrefetchSchedulePerPlane(
 		&v->VReadyOffsetPix[k]);
 }
 
-static void PatchDETBufferSizeInKByte(unsigned int NumberOfActivePlanes, int NoOfDPPThisState[], unsigned int config_return_buffer_size_in_kbytes, unsigned int DETBufferSizeInKByte[])
+static void PatchDETBufferSizeInKByte(unsigned int NumberOfActivePlanes, unsigned int NoOfDPPThisState[], unsigned int config_return_buffer_size_in_kbytes, unsigned int DETBufferSizeInKByte[])
 {
 	int total_pipes = 0;
 	unsigned int i;
@@ -3804,7 +3804,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	int idx;
 	unsigned int i, j, k, m;
 	int ReorderingBytes;
-	int MinPrefetchMode = 0, MaxPrefetchMode = 2;
+	unsigned int MinPrefetchMode = 0, MaxPrefetchMode = 2;
 	bool NoChroma = true;
 	bool EnoughWritebackUnits = true;
 	bool P2IWith420 = false;
@@ -5119,7 +5119,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			double HostVMInefficiencyFactor = 1;
 			int NextPrefetchModeState = MinPrefetchMode;
 			bool UnboundedRequestEnabledThisState = false;
-			int CompressedBufferSizeInkByteThisState = 0;
+			unsigned int CompressedBufferSizeInkByteThisState = 0;
 			double dummy;
 
 			v->TimeCalc = 24 / v->ProjectedDCFCLKDeepSleep[i][j];
@@ -5774,8 +5774,8 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 static void CalculateDCFCLKDeepSleep(
 		struct display_mode_lib *mode_lib,
 		unsigned int NumberOfActivePlanes,
-		int BytePerPixelY[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelY[],
+		unsigned int BytePerPixelC[],
 		double VRatio[],
 		double VRatioChroma[],
 		double SwathWidthY[],
@@ -5926,7 +5926,7 @@ static void CalculatePixelDeliveryTimes(
 		double PSCL_THROUGHPUT[],
 		double PSCL_THROUGHPUT_CHROMA[],
 		double DPPCLK[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelC[],
 		enum scan_direction_class SourceScan[],
 		unsigned int NumberOfCursors[],
 		unsigned int CursorWidth[][DC__NUM_CURSOR__MAX],
@@ -6050,35 +6050,35 @@ static void CalculateMetaAndPTETimes(
 		bool GPUVMEnable,
 		int MetaChunkSize,
 		int MinMetaChunkSizeBytes,
-		int HTotal[],
+		unsigned int HTotal[],
 		double VRatio[],
 		double VRatioChroma[],
 		double DestinationLinesToRequestRowInVBlank[],
 		double DestinationLinesToRequestRowInImmediateFlip[],
 		bool DCCEnable[],
 		double PixelClock[],
-		int BytePerPixelY[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelY[],
+		unsigned int BytePerPixelC[],
 		enum scan_direction_class SourceScan[],
-		int dpte_row_height[],
-		int dpte_row_height_chroma[],
-		int meta_row_width[],
-		int meta_row_width_chroma[],
-		int meta_row_height[],
-		int meta_row_height_chroma[],
-		int meta_req_width[],
-		int meta_req_width_chroma[],
-		int meta_req_height[],
-		int meta_req_height_chroma[],
-		int dpte_group_bytes[],
-		int PTERequestSizeY[],
-		int PTERequestSizeC[],
-		int PixelPTEReqWidthY[],
-		int PixelPTEReqHeightY[],
-		int PixelPTEReqWidthC[],
-		int PixelPTEReqHeightC[],
-		int dpte_row_width_luma_ub[],
-		int dpte_row_width_chroma_ub[],
+		unsigned int dpte_row_height[],
+		unsigned int dpte_row_height_chroma[],
+		unsigned int meta_row_width[],
+		unsigned int meta_row_width_chroma[],
+		unsigned int meta_row_height[],
+		unsigned int meta_row_height_chroma[],
+		unsigned int meta_req_width[],
+		unsigned int meta_req_width_chroma[],
+		unsigned int meta_req_height[],
+		unsigned int meta_req_height_chroma[],
+		unsigned int dpte_group_bytes[],
+		unsigned int PTERequestSizeY[],
+		unsigned int PTERequestSizeC[],
+		unsigned int PixelPTEReqWidthY[],
+		unsigned int PixelPTEReqHeightY[],
+		unsigned int PixelPTEReqWidthC[],
+		unsigned int PixelPTEReqHeightC[],
+		unsigned int dpte_row_width_luma_ub[],
+		unsigned int dpte_row_width_chroma_ub[],
 		double DST_Y_PER_PTE_ROW_NOM_L[],
 		double DST_Y_PER_PTE_ROW_NOM_C[],
 		double DST_Y_PER_META_ROW_NOM_L[],
@@ -6223,18 +6223,18 @@ static void CalculateVMGroupAndRequestTimes(
 		bool GPUVMEnable,
 		unsigned int GPUVMMaxPageTableLevels,
 		unsigned int HTotal[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelC[],
 		double DestinationLinesToRequestVMInVBlank[],
 		double DestinationLinesToRequestVMInImmediateFlip[],
 		bool DCCEnable[],
 		double PixelClock[],
-		int dpte_row_width_luma_ub[],
-		int dpte_row_width_chroma_ub[],
-		int vm_group_bytes[],
+		unsigned int dpte_row_width_luma_ub[],
+		unsigned int dpte_row_width_chroma_ub[],
+		unsigned int vm_group_bytes[],
 		unsigned int dpde0_bytes_per_frame_ub_l[],
 		unsigned int dpde0_bytes_per_frame_ub_c[],
-		int meta_pte_bytes_per_frame_ub_l[],
-		int meta_pte_bytes_per_frame_ub_c[],
+		unsigned int meta_pte_bytes_per_frame_ub_l[],
+		unsigned int meta_pte_bytes_per_frame_ub_c[],
 		double TimePerVMGroupVBlank[],
 		double TimePerVMGroupFlip[],
 		double TimePerVMRequestVBlank[],
@@ -6342,29 +6342,29 @@ static void CalculateStutterEfficiency(
 		bool ProgressiveToInterlaceUnitInOPP,
 		bool Interlace[],
 		double MinTTUVBlank[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		unsigned int DETBufferSizeY[],
-		int BytePerPixelY[],
+		unsigned int BytePerPixelY[],
 		double BytePerPixelDETY[],
 		double SwathWidthY[],
-		int SwathHeightY[],
-		int SwathHeightC[],
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
 		double NetDCCRateLuma[],
 		double NetDCCRateChroma[],
 		double DCCFractionOfZeroSizeRequestsLuma[],
 		double DCCFractionOfZeroSizeRequestsChroma[],
-		int HTotal[],
-		int VTotal[],
+		unsigned int HTotal[],
+		unsigned int VTotal[],
 		double PixelClock[],
 		double VRatio[],
 		enum scan_direction_class SourceScan[],
-		int BlockHeight256BytesY[],
-		int BlockWidth256BytesY[],
-		int BlockHeight256BytesC[],
-		int BlockWidth256BytesC[],
-		int DCCYMaxUncompressedBlock[],
-		int DCCCMaxUncompressedBlock[],
-		int VActive[],
+		unsigned int BlockHeight256BytesY[],
+		unsigned int BlockWidth256BytesY[],
+		unsigned int BlockHeight256BytesC[],
+		unsigned int BlockWidth256BytesC[],
+		unsigned int DCCYMaxUncompressedBlock[],
+		unsigned int DCCCMaxUncompressedBlock[],
+		unsigned int VActive[],
 		bool DCCEnable[],
 		bool WritebackEnable[],
 		double ReadBandwidthPlaneLuma[],
@@ -6649,42 +6649,42 @@ static void CalculateSwathAndDETConfiguration(
 		enum scan_direction_class SourceScan[],
 		enum source_format_class SourcePixelFormat[],
 		enum dm_swizzle_mode SurfaceTiling[],
-		int ViewportWidth[],
-		int ViewportHeight[],
-		int SurfaceWidthY[],
-		int SurfaceWidthC[],
-		int SurfaceHeightY[],
-		int SurfaceHeightC[],
-		int Read256BytesBlockHeightY[],
-		int Read256BytesBlockHeightC[],
-		int Read256BytesBlockWidthY[],
-		int Read256BytesBlockWidthC[],
+		unsigned int ViewportWidth[],
+		unsigned int ViewportHeight[],
+		unsigned int SurfaceWidthY[],
+		unsigned int SurfaceWidthC[],
+		unsigned int SurfaceHeightY[],
+		unsigned int SurfaceHeightC[],
+		unsigned int Read256BytesBlockHeightY[],
+		unsigned int Read256BytesBlockHeightC[],
+		unsigned int Read256BytesBlockWidthY[],
+		unsigned int Read256BytesBlockWidthC[],
 		enum odm_combine_mode ODMCombineEnabled[],
-		int BlendingAndTiming[],
-		int BytePerPixY[],
-		int BytePerPixC[],
+		unsigned int BlendingAndTiming[],
+		unsigned int BytePerPixY[],
+		unsigned int BytePerPixC[],
 		double BytePerPixDETY[],
 		double BytePerPixDETC[],
-		int HActive[],
+		unsigned int HActive[],
 		double HRatio[],
 		double HRatioChroma[],
-		int DPPPerPlane[],
-		int swath_width_luma_ub[],
-		int swath_width_chroma_ub[],
+		unsigned int DPPPerPlane[],
+		unsigned int swath_width_luma_ub[],
+		unsigned int swath_width_chroma_ub[],
 		double SwathWidth[],
 		double SwathWidthChroma[],
-		int SwathHeightY[],
-		int SwathHeightC[],
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
 		unsigned int DETBufferSizeY[],
 		unsigned int DETBufferSizeC[],
 		bool ViewportSizeSupportPerPlane[],
 		bool *ViewportSizeSupport)
 {
 	(void)HRatioChroma;
-	int MaximumSwathHeightY[DC__NUM_DPP__MAX];
-	int MaximumSwathHeightC[DC__NUM_DPP__MAX];
-	int MinimumSwathHeightY;
-	int MinimumSwathHeightC;
+	unsigned int MaximumSwathHeightY[DC__NUM_DPP__MAX];
+	unsigned int MaximumSwathHeightC[DC__NUM_DPP__MAX];
+	unsigned int MinimumSwathHeightY;
+	unsigned int MinimumSwathHeightC;
 	unsigned int RoundedUpMaxSwathSizeBytesY;
 	unsigned int RoundedUpMaxSwathSizeBytesC;
 	unsigned int RoundedUpMinSwathSizeBytesY;
@@ -6829,31 +6829,31 @@ static void CalculateSwathWidth(
 		int NumberOfActivePlanes,
 		enum source_format_class SourcePixelFormat[],
 		enum scan_direction_class SourceScan[],
-		int ViewportWidth[],
-		int ViewportHeight[],
-		int SurfaceWidthY[],
-		int SurfaceWidthC[],
-		int SurfaceHeightY[],
-		int SurfaceHeightC[],
+		unsigned int ViewportWidth[],
+		unsigned int ViewportHeight[],
+		unsigned int SurfaceWidthY[],
+		unsigned int SurfaceWidthC[],
+		unsigned int SurfaceHeightY[],
+		unsigned int SurfaceHeightC[],
 		enum odm_combine_mode ODMCombineEnabled[],
-		int BytePerPixY[],
-		int BytePerPixC[],
-		int Read256BytesBlockHeightY[],
-		int Read256BytesBlockHeightC[],
-		int Read256BytesBlockWidthY[],
-		int Read256BytesBlockWidthC[],
-		int BlendingAndTiming[],
-		int HActive[],
+		unsigned int BytePerPixY[],
+		unsigned int BytePerPixC[],
+		unsigned int Read256BytesBlockHeightY[],
+		unsigned int Read256BytesBlockHeightC[],
+		unsigned int Read256BytesBlockWidthY[],
+		unsigned int Read256BytesBlockWidthC[],
+		unsigned int BlendingAndTiming[],
+		unsigned int HActive[],
 		double HRatio[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		double SwathWidthSingleDPPY[],
 		double SwathWidthSingleDPPC[],
 		double SwathWidthY[],
 		double SwathWidthC[],
-		int MaximumSwathHeightY[],
-		int MaximumSwathHeightC[],
-		int swath_width_luma_ub[],
-		int swath_width_chroma_ub[])
+		unsigned int MaximumSwathHeightY[],
+		unsigned int MaximumSwathHeightC[],
+		unsigned int swath_width_luma_ub[],
+		unsigned int swath_width_chroma_ub[])
 {
 	(void)BytePerPixY;
 	enum odm_combine_mode MainPlaneODMCombine;
@@ -6960,8 +6960,8 @@ static double CalculateExtraLatency(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double HostVMInefficiencyFactor,
 		double HostVMMinPageSize,
 		int HostVMMaxNonCachedPageTableLevels)
@@ -7006,8 +7006,8 @@ static double CalculateExtraLatencyBytes(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double HostVMInefficiencyFactor,
 		double HostVMMinPageSize,
 		int HostVMMaxNonCachedPageTableLevels)
@@ -7061,7 +7061,7 @@ static noinline_for_stack void UseMinimumDCFCLK(
 		int ReorderingBytes)
 {
 	struct vba_vars_st *v = &mode_lib->vba;
-	int dummy1;
+	unsigned int dummy1;
 	unsigned int j, k;
 	unsigned int i;
 	double NormalEfficiency,  dummy2, dummy3;
@@ -7081,7 +7081,7 @@ static noinline_for_stack void UseMinimumDCFCLK(
 			double ExtraLatencyBytes;
 			double ExtraLatencyCycles;
 			double DCFCLKRequiredForPeakBandwidth;
-			int NoOfDPPState[DC__NUM_DPP__MAX];
+			unsigned int NoOfDPPState[DC__NUM_DPP__MAX];
 			double MinimumTvmPlus2Tr0;
 
 			TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = 0;
@@ -7226,7 +7226,7 @@ static void CalculateUnboundedRequestAndCompressedBufferSize(
 		int CompressedBufferSegmentSizeInkByteFinal,
 		enum output_encoder_class *Output,
 		bool *UnboundedRequestEnabled,
-		int *CompressedBufferSizeInkByte)
+		unsigned int *CompressedBufferSizeInkByte)
 {
 	double actDETBufferSizeInKByte = dml_ceil(DETBufferSizeInKByte, 64);
 
@@ -7244,7 +7244,7 @@ static void CalculateUnboundedRequestAndCompressedBufferSize(
 	dml_print("DML::%s: UseUnboundedRequestingFinal = %d\n", __func__, UseUnboundedRequestingFinal);
 	dml_print("DML::%s: actDETBufferSizeInKByte = %f\n", __func__, actDETBufferSizeInKByte);
 	dml_print("DML::%s: UnboundedRequestEnabled = %d\n", __func__, *UnboundedRequestEnabled);
-	dml_print("DML::%s: CompressedBufferSizeInkByte = %d\n", __func__, *CompressedBufferSizeInkByte);
+	dml_print("DML::%s: CompressedBufferSizeInkByte = %u\n", __func__, *CompressedBufferSizeInkByte);
 #endif
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index d6dcebb1ab14..dd9dc0c8cb43 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -166,7 +166,7 @@ static bool CalculatePrefetchSchedule(
 		double *Tdmdl_vm,
 		double *Tdmdl,
 		double *TSetup,
-		int *VUpdateOffsetPix,
+		unsigned int *VUpdateOffsetPix,
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix);
 static double RoundToDFSGranularityUp(double Clock, double VCOSpeed);
@@ -227,19 +227,19 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *MetaRowByte,
 		unsigned int *PixelPTEBytesPerRow,
 		bool *PTEBufferSizeNotExceeded,
-		int *dpte_row_width_ub,
+		unsigned int *dpte_row_width_ub,
 		unsigned int *dpte_row_height,
 		unsigned int *MetaRequestWidth,
 		unsigned int *MetaRequestHeight,
 		unsigned int *meta_row_width,
 		unsigned int *meta_row_height,
-		int *vm_group_bytes,
+		unsigned int *vm_group_bytes,
 		unsigned int *dpte_group_bytes,
 		unsigned int *PixelPTEReqWidth,
 		unsigned int *PixelPTEReqHeight,
 		unsigned int *PTERequestSize,
-		int *DPDE0BytesFrame,
-		int *MetaPTEBytesFrame);
+		unsigned int *DPDE0BytesFrame,
+		unsigned int *MetaPTEBytesFrame);
 static double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime);
 static void CalculateRowBandwidth(
 		bool GPUVMEnable,
@@ -294,7 +294,7 @@ static void CalculateVupdateAndDynamicMetadataParameters(
 		double *Tdmbf,
 		double *Tdmec,
 		double *Tdmsks,
-		int *VUpdateOffsetPix,
+		unsigned int *VUpdateOffsetPix,
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix);
 
@@ -327,8 +327,8 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 static void CalculateDCFCLKDeepSleep(
 		struct display_mode_lib *mode_lib,
 		unsigned int NumberOfActivePlanes,
-		int BytePerPixelY[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelY[],
+		unsigned int BytePerPixelC[],
 		double VRatio[],
 		double VRatioChroma[],
 		double SwathWidthY[],
@@ -386,7 +386,7 @@ static void CalculatePixelDeliveryTimes(
 		double PSCL_THROUGHPUT[],
 		double PSCL_THROUGHPUT_CHROMA[],
 		double DPPCLK[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelC[],
 		enum scan_direction_class SourceScan[],
 		unsigned int NumberOfCursors[],
 		unsigned int CursorWidth[][DC__NUM_CURSOR__MAX],
@@ -411,35 +411,35 @@ static void CalculateMetaAndPTETimes(
 		bool GPUVMEnable,
 		int MetaChunkSize,
 		int MinMetaChunkSizeBytes,
-		int HTotal[],
+		unsigned int HTotal[],
 		double VRatio[],
 		double VRatioChroma[],
 		double DestinationLinesToRequestRowInVBlank[],
 		double DestinationLinesToRequestRowInImmediateFlip[],
 		bool DCCEnable[],
 		double PixelClock[],
-		int BytePerPixelY[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelY[],
+		unsigned int BytePerPixelC[],
 		enum scan_direction_class SourceScan[],
-		int dpte_row_height[],
-		int dpte_row_height_chroma[],
-		int meta_row_width[],
-		int meta_row_width_chroma[],
-		int meta_row_height[],
-		int meta_row_height_chroma[],
-		int meta_req_width[],
-		int meta_req_width_chroma[],
-		int meta_req_height[],
-		int meta_req_height_chroma[],
-		int dpte_group_bytes[],
-		int PTERequestSizeY[],
-		int PTERequestSizeC[],
-		int PixelPTEReqWidthY[],
-		int PixelPTEReqHeightY[],
-		int PixelPTEReqWidthC[],
-		int PixelPTEReqHeightC[],
-		int dpte_row_width_luma_ub[],
-		int dpte_row_width_chroma_ub[],
+		unsigned int dpte_row_height[],
+		unsigned int dpte_row_height_chroma[],
+		unsigned int meta_row_width[],
+		unsigned int meta_row_width_chroma[],
+		unsigned int meta_row_height[],
+		unsigned int meta_row_height_chroma[],
+		unsigned int meta_req_width[],
+		unsigned int meta_req_width_chroma[],
+		unsigned int meta_req_height[],
+		unsigned int meta_req_height_chroma[],
+		unsigned int dpte_group_bytes[],
+		unsigned int PTERequestSizeY[],
+		unsigned int PTERequestSizeC[],
+		unsigned int PixelPTEReqWidthY[],
+		unsigned int PixelPTEReqHeightY[],
+		unsigned int PixelPTEReqWidthC[],
+		unsigned int PixelPTEReqHeightC[],
+		unsigned int dpte_row_width_luma_ub[],
+		unsigned int dpte_row_width_chroma_ub[],
 		double DST_Y_PER_PTE_ROW_NOM_L[],
 		double DST_Y_PER_PTE_ROW_NOM_C[],
 		double DST_Y_PER_META_ROW_NOM_L[],
@@ -462,18 +462,18 @@ static void CalculateVMGroupAndRequestTimes(
 		bool GPUVMEnable,
 		unsigned int GPUVMMaxPageTableLevels,
 		unsigned int HTotal[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelC[],
 		double DestinationLinesToRequestVMInVBlank[],
 		double DestinationLinesToRequestVMInImmediateFlip[],
 		bool DCCEnable[],
 		double PixelClock[],
-		int dpte_row_width_luma_ub[],
-		int dpte_row_width_chroma_ub[],
-		int vm_group_bytes[],
+		unsigned int dpte_row_width_luma_ub[],
+		unsigned int dpte_row_width_chroma_ub[],
+		unsigned int vm_group_bytes[],
 		unsigned int dpde0_bytes_per_frame_ub_l[],
 		unsigned int dpde0_bytes_per_frame_ub_c[],
-		int meta_pte_bytes_per_frame_ub_l[],
-		int meta_pte_bytes_per_frame_ub_c[],
+		unsigned int meta_pte_bytes_per_frame_ub_l[],
+		unsigned int meta_pte_bytes_per_frame_ub_c[],
 		double TimePerVMGroupVBlank[],
 		double TimePerVMGroupFlip[],
 		double TimePerVMRequestVBlank[],
@@ -501,29 +501,29 @@ static void CalculateStutterEfficiency(
 		bool ProgressiveToInterlaceUnitInOPP,
 		bool Interlace[],
 		double MinTTUVBlank[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		unsigned int DETBufferSizeY[],
-		int BytePerPixelY[],
+		unsigned int BytePerPixelY[],
 		double BytePerPixelDETY[],
 		double SwathWidthY[],
-		int SwathHeightY[],
-		int SwathHeightC[],
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
 		double NetDCCRateLuma[],
 		double NetDCCRateChroma[],
 		double DCCFractionOfZeroSizeRequestsLuma[],
 		double DCCFractionOfZeroSizeRequestsChroma[],
-		int HTotal[],
-		int VTotal[],
+		unsigned int HTotal[],
+		unsigned int VTotal[],
 		double PixelClock[],
 		double VRatio[],
 		enum scan_direction_class SourceScan[],
-		int BlockHeight256BytesY[],
-		int BlockWidth256BytesY[],
-		int BlockHeight256BytesC[],
-		int BlockWidth256BytesC[],
-		int DCCYMaxUncompressedBlock[],
-		int DCCCMaxUncompressedBlock[],
-		int VActive[],
+		unsigned int BlockHeight256BytesY[],
+		unsigned int BlockWidth256BytesY[],
+		unsigned int BlockHeight256BytesC[],
+		unsigned int BlockWidth256BytesC[],
+		unsigned int DCCYMaxUncompressedBlock[],
+		unsigned int DCCCMaxUncompressedBlock[],
+		unsigned int VActive[],
 		bool DCCEnable[],
 		bool WritebackEnable[],
 		double ReadBandwidthPlaneLuma[],
@@ -547,32 +547,32 @@ static void CalculateSwathAndDETConfiguration(
 		enum scan_direction_class SourceScan[],
 		enum source_format_class SourcePixelFormat[],
 		enum dm_swizzle_mode SurfaceTiling[],
-		int ViewportWidth[],
-		int ViewportHeight[],
-		int SurfaceWidthY[],
-		int SurfaceWidthC[],
-		int SurfaceHeightY[],
-		int SurfaceHeightC[],
-		int Read256BytesBlockHeightY[],
-		int Read256BytesBlockHeightC[],
-		int Read256BytesBlockWidthY[],
-		int Read256BytesBlockWidthC[],
+		unsigned int ViewportWidth[],
+		unsigned int ViewportHeight[],
+		unsigned int SurfaceWidthY[],
+		unsigned int SurfaceWidthC[],
+		unsigned int SurfaceHeightY[],
+		unsigned int SurfaceHeightC[],
+		unsigned int Read256BytesBlockHeightY[],
+		unsigned int Read256BytesBlockHeightC[],
+		unsigned int Read256BytesBlockWidthY[],
+		unsigned int Read256BytesBlockWidthC[],
 		enum odm_combine_mode ODMCombineEnabled[],
-		int BlendingAndTiming[],
-		int BytePerPixY[],
-		int BytePerPixC[],
+		unsigned int BlendingAndTiming[],
+		unsigned int BytePerPixY[],
+		unsigned int BytePerPixC[],
 		double BytePerPixDETY[],
 		double BytePerPixDETC[],
-		int HActive[],
+		unsigned int HActive[],
 		double HRatio[],
 		double HRatioChroma[],
-		int DPPPerPlane[],
-		int swath_width_luma_ub[],
-		int swath_width_chroma_ub[],
+		unsigned int DPPPerPlane[],
+		unsigned int swath_width_luma_ub[],
+		unsigned int swath_width_chroma_ub[],
 		double SwathWidth[],
 		double SwathWidthChroma[],
-		int SwathHeightY[],
-		int SwathHeightC[],
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
 		unsigned int DETBufferSizeY[],
 		unsigned int DETBufferSizeC[],
 		bool ViewportSizeSupportPerPlane[],
@@ -582,31 +582,31 @@ static void CalculateSwathWidth(
 		int NumberOfActivePlanes,
 		enum source_format_class SourcePixelFormat[],
 		enum scan_direction_class SourceScan[],
-		int ViewportWidth[],
-		int ViewportHeight[],
-		int SurfaceWidthY[],
-		int SurfaceWidthC[],
-		int SurfaceHeightY[],
-		int SurfaceHeightC[],
+		unsigned int ViewportWidth[],
+		unsigned int ViewportHeight[],
+		unsigned int SurfaceWidthY[],
+		unsigned int SurfaceWidthC[],
+		unsigned int SurfaceHeightY[],
+		unsigned int SurfaceHeightC[],
 		enum odm_combine_mode ODMCombineEnabled[],
-		int BytePerPixY[],
-		int BytePerPixC[],
-		int Read256BytesBlockHeightY[],
-		int Read256BytesBlockHeightC[],
-		int Read256BytesBlockWidthY[],
-		int Read256BytesBlockWidthC[],
-		int BlendingAndTiming[],
-		int HActive[],
+		unsigned int BytePerPixY[],
+		unsigned int BytePerPixC[],
+		unsigned int Read256BytesBlockHeightY[],
+		unsigned int Read256BytesBlockHeightC[],
+		unsigned int Read256BytesBlockWidthY[],
+		unsigned int Read256BytesBlockWidthC[],
+		unsigned int BlendingAndTiming[],
+		unsigned int HActive[],
 		double HRatio[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		double SwathWidthSingleDPPY[],
 		double SwathWidthSingleDPPC[],
 		double SwathWidthY[],
 		double SwathWidthC[],
-		int MaximumSwathHeightY[],
-		int MaximumSwathHeightC[],
-		int swath_width_luma_ub[],
-		int swath_width_chroma_ub[]);
+		unsigned int MaximumSwathHeightY[],
+		unsigned int MaximumSwathHeightC[],
+		unsigned int swath_width_luma_ub[],
+		unsigned int swath_width_chroma_ub[]);
 
 static double CalculateExtraLatency(
 		int RoundTripPingLatencyCycles,
@@ -620,8 +620,8 @@ static double CalculateExtraLatency(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double HostVMInefficiencyFactor,
 		double HostVMMinPageSize,
 		int HostVMMaxNonCachedPageTableLevels);
@@ -635,8 +635,8 @@ static double CalculateExtraLatencyBytes(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double HostVMInefficiencyFactor,
 		double HostVMMinPageSize,
 		int HostVMMaxNonCachedPageTableLevels);
@@ -660,7 +660,7 @@ static void CalculateUnboundedRequestAndCompressedBufferSize(
 		int CompressedBufferSegmentSizeInkByteFinal,
 		enum output_encoder_class *Output,
 		bool *UnboundedRequestEnabled,
-		int *CompressedBufferSizeInkByte);
+		unsigned int *CompressedBufferSizeInkByte);
 
 static bool UnboundedRequest(enum unbounded_requesting_policy UseUnboundedRequestingFinal, int TotalNumberOfActiveDPP, bool NoChroma, enum output_encoder_class Output);
 static unsigned int CalculateMaxVStartup(
@@ -887,7 +887,7 @@ static bool CalculatePrefetchSchedule(
 		double *Tdmdl_vm,
 		double *Tdmdl,
 		double *TSetup,
-		int *VUpdateOffsetPix,
+		unsigned int *VUpdateOffsetPix,
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix)
 {
@@ -1835,19 +1835,19 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *MetaRowByte,
 		unsigned int *PixelPTEBytesPerRow,
 		bool *PTEBufferSizeNotExceeded,
-		int *dpte_row_width_ub,
+		unsigned int *dpte_row_width_ub,
 		unsigned int *dpte_row_height,
 		unsigned int *MetaRequestWidth,
 		unsigned int *MetaRequestHeight,
 		unsigned int *meta_row_width,
 		unsigned int *meta_row_height,
-		int *vm_group_bytes,
+		unsigned int *vm_group_bytes,
 		unsigned int *dpte_group_bytes,
 		unsigned int *PixelPTEReqWidth,
 		unsigned int *PixelPTEReqHeight,
 		unsigned int *PTERequestSize,
-		int *DPDE0BytesFrame,
-		int *MetaPTEBytesFrame)
+		unsigned int *DPDE0BytesFrame,
+		unsigned int *MetaPTEBytesFrame)
 {
 	(void)SourcePixelFormat;
 	struct vba_vars_st *v = &mode_lib->vba;
@@ -3297,18 +3297,18 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	// Display Pipe Configuration
 	double BytePerPixDETY[DC__NUM_DPP__MAX];
 	double BytePerPixDETC[DC__NUM_DPP__MAX];
-	int BytePerPixY[DC__NUM_DPP__MAX];
-	int BytePerPixC[DC__NUM_DPP__MAX];
-	int Read256BytesBlockHeightY[DC__NUM_DPP__MAX];
-	int Read256BytesBlockHeightC[DC__NUM_DPP__MAX];
-	int Read256BytesBlockWidthY[DC__NUM_DPP__MAX];
-	int Read256BytesBlockWidthC[DC__NUM_DPP__MAX];
+	unsigned int BytePerPixY[DC__NUM_DPP__MAX];
+	unsigned int BytePerPixC[DC__NUM_DPP__MAX];
+	unsigned int Read256BytesBlockHeightY[DC__NUM_DPP__MAX];
+	unsigned int Read256BytesBlockHeightC[DC__NUM_DPP__MAX];
+	unsigned int Read256BytesBlockWidthY[DC__NUM_DPP__MAX];
+	unsigned int Read256BytesBlockWidthC[DC__NUM_DPP__MAX];
 	double dummy1[DC__NUM_DPP__MAX];
 	double dummy2[DC__NUM_DPP__MAX];
 	double dummy3[DC__NUM_DPP__MAX];
 	double dummy4[DC__NUM_DPP__MAX];
-	int dummy5[DC__NUM_DPP__MAX];
-	int dummy6[DC__NUM_DPP__MAX];
+	unsigned int dummy5[DC__NUM_DPP__MAX];
+	unsigned int dummy6[DC__NUM_DPP__MAX];
 	bool dummy7[DC__NUM_DPP__MAX];
 	bool dummysinglestring;
 
@@ -3535,7 +3535,7 @@ static void CalculateVupdateAndDynamicMetadataParameters(
 		double *Tdmbf,
 		double *Tdmec,
 		double *Tdmsks,
-		int *VUpdateOffsetPix,
+		unsigned int *VUpdateOffsetPix,
 		double *VUpdateWidthPix,
 		double *VReadyOffsetPix)
 {
@@ -3897,7 +3897,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 	unsigned int i;
 	unsigned int k, m;
 	int ReorderingBytes;
-	int MinPrefetchMode = 0, MaxPrefetchMode = 2;
+	unsigned int MinPrefetchMode = 0, MaxPrefetchMode = 2;
 	bool NoChroma = true;
 	bool EnoughWritebackUnits = true;
 	bool P2IWith420 = false;
@@ -5205,7 +5205,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 			double HostVMInefficiencyFactor = 1;
 			int NextPrefetchModeState = MinPrefetchMode;
 			bool UnboundedRequestEnabledThisState = false;
-			int CompressedBufferSizeInkByteThisState = 0;
+			unsigned int CompressedBufferSizeInkByteThisState = 0;
 			double dummy;
 
 			v->TimeCalc = 24 / v->ProjectedDCFCLKDeepSleep[i][j];
@@ -5867,8 +5867,8 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 static void CalculateDCFCLKDeepSleep(
 		struct display_mode_lib *mode_lib,
 		unsigned int NumberOfActivePlanes,
-		int BytePerPixelY[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelY[],
+		unsigned int BytePerPixelC[],
 		double VRatio[],
 		double VRatioChroma[],
 		double SwathWidthY[],
@@ -6019,7 +6019,7 @@ static void CalculatePixelDeliveryTimes(
 		double PSCL_THROUGHPUT[],
 		double PSCL_THROUGHPUT_CHROMA[],
 		double DPPCLK[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelC[],
 		enum scan_direction_class SourceScan[],
 		unsigned int NumberOfCursors[],
 		unsigned int CursorWidth[][DC__NUM_CURSOR__MAX],
@@ -6144,35 +6144,35 @@ static void CalculateMetaAndPTETimes(
 		bool GPUVMEnable,
 		int MetaChunkSize,
 		int MinMetaChunkSizeBytes,
-		int HTotal[],
+		unsigned int HTotal[],
 		double VRatio[],
 		double VRatioChroma[],
 		double DestinationLinesToRequestRowInVBlank[],
 		double DestinationLinesToRequestRowInImmediateFlip[],
 		bool DCCEnable[],
 		double PixelClock[],
-		int BytePerPixelY[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelY[],
+		unsigned int BytePerPixelC[],
 		enum scan_direction_class SourceScan[],
-		int dpte_row_height[],
-		int dpte_row_height_chroma[],
-		int meta_row_width[],
-		int meta_row_width_chroma[],
-		int meta_row_height[],
-		int meta_row_height_chroma[],
-		int meta_req_width[],
-		int meta_req_width_chroma[],
-		int meta_req_height[],
-		int meta_req_height_chroma[],
-		int dpte_group_bytes[],
-		int PTERequestSizeY[],
-		int PTERequestSizeC[],
-		int PixelPTEReqWidthY[],
-		int PixelPTEReqHeightY[],
-		int PixelPTEReqWidthC[],
-		int PixelPTEReqHeightC[],
-		int dpte_row_width_luma_ub[],
-		int dpte_row_width_chroma_ub[],
+		unsigned int dpte_row_height[],
+		unsigned int dpte_row_height_chroma[],
+		unsigned int meta_row_width[],
+		unsigned int meta_row_width_chroma[],
+		unsigned int meta_row_height[],
+		unsigned int meta_row_height_chroma[],
+		unsigned int meta_req_width[],
+		unsigned int meta_req_width_chroma[],
+		unsigned int meta_req_height[],
+		unsigned int meta_req_height_chroma[],
+		unsigned int dpte_group_bytes[],
+		unsigned int PTERequestSizeY[],
+		unsigned int PTERequestSizeC[],
+		unsigned int PixelPTEReqWidthY[],
+		unsigned int PixelPTEReqHeightY[],
+		unsigned int PixelPTEReqWidthC[],
+		unsigned int PixelPTEReqHeightC[],
+		unsigned int dpte_row_width_luma_ub[],
+		unsigned int dpte_row_width_chroma_ub[],
 		double DST_Y_PER_PTE_ROW_NOM_L[],
 		double DST_Y_PER_PTE_ROW_NOM_C[],
 		double DST_Y_PER_META_ROW_NOM_L[],
@@ -6317,18 +6317,18 @@ static void CalculateVMGroupAndRequestTimes(
 		bool GPUVMEnable,
 		unsigned int GPUVMMaxPageTableLevels,
 		unsigned int HTotal[],
-		int BytePerPixelC[],
+		unsigned int BytePerPixelC[],
 		double DestinationLinesToRequestVMInVBlank[],
 		double DestinationLinesToRequestVMInImmediateFlip[],
 		bool DCCEnable[],
 		double PixelClock[],
-		int dpte_row_width_luma_ub[],
-		int dpte_row_width_chroma_ub[],
-		int vm_group_bytes[],
+		unsigned int dpte_row_width_luma_ub[],
+		unsigned int dpte_row_width_chroma_ub[],
+		unsigned int vm_group_bytes[],
 		unsigned int dpde0_bytes_per_frame_ub_l[],
 		unsigned int dpde0_bytes_per_frame_ub_c[],
-		int meta_pte_bytes_per_frame_ub_l[],
-		int meta_pte_bytes_per_frame_ub_c[],
+		unsigned int meta_pte_bytes_per_frame_ub_l[],
+		unsigned int meta_pte_bytes_per_frame_ub_c[],
 		double TimePerVMGroupVBlank[],
 		double TimePerVMGroupFlip[],
 		double TimePerVMRequestVBlank[],
@@ -6436,29 +6436,29 @@ static void CalculateStutterEfficiency(
 		bool ProgressiveToInterlaceUnitInOPP,
 		bool Interlace[],
 		double MinTTUVBlank[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		unsigned int DETBufferSizeY[],
-		int BytePerPixelY[],
+		unsigned int BytePerPixelY[],
 		double BytePerPixelDETY[],
 		double SwathWidthY[],
-		int SwathHeightY[],
-		int SwathHeightC[],
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
 		double NetDCCRateLuma[],
 		double NetDCCRateChroma[],
 		double DCCFractionOfZeroSizeRequestsLuma[],
 		double DCCFractionOfZeroSizeRequestsChroma[],
-		int HTotal[],
-		int VTotal[],
+		unsigned int HTotal[],
+		unsigned int VTotal[],
 		double PixelClock[],
 		double VRatio[],
 		enum scan_direction_class SourceScan[],
-		int BlockHeight256BytesY[],
-		int BlockWidth256BytesY[],
-		int BlockHeight256BytesC[],
-		int BlockWidth256BytesC[],
-		int DCCYMaxUncompressedBlock[],
-		int DCCCMaxUncompressedBlock[],
-		int VActive[],
+		unsigned int BlockHeight256BytesY[],
+		unsigned int BlockWidth256BytesY[],
+		unsigned int BlockHeight256BytesC[],
+		unsigned int BlockWidth256BytesC[],
+		unsigned int DCCYMaxUncompressedBlock[],
+		unsigned int DCCCMaxUncompressedBlock[],
+		unsigned int VActive[],
 		bool DCCEnable[],
 		bool WritebackEnable[],
 		double ReadBandwidthPlaneLuma[],
@@ -6742,40 +6742,40 @@ static void CalculateSwathAndDETConfiguration(
 		enum scan_direction_class SourceScan[],
 		enum source_format_class SourcePixelFormat[],
 		enum dm_swizzle_mode SurfaceTiling[],
-		int ViewportWidth[],
-		int ViewportHeight[],
-		int SurfaceWidthY[],
-		int SurfaceWidthC[],
-		int SurfaceHeightY[],
-		int SurfaceHeightC[],
-		int Read256BytesBlockHeightY[],
-		int Read256BytesBlockHeightC[],
-		int Read256BytesBlockWidthY[],
-		int Read256BytesBlockWidthC[],
+		unsigned int ViewportWidth[],
+		unsigned int ViewportHeight[],
+		unsigned int SurfaceWidthY[],
+		unsigned int SurfaceWidthC[],
+		unsigned int SurfaceHeightY[],
+		unsigned int SurfaceHeightC[],
+		unsigned int Read256BytesBlockHeightY[],
+		unsigned int Read256BytesBlockHeightC[],
+		unsigned int Read256BytesBlockWidthY[],
+		unsigned int Read256BytesBlockWidthC[],
 		enum odm_combine_mode ODMCombineEnabled[],
-		int BlendingAndTiming[],
-		int BytePerPixY[],
-		int BytePerPixC[],
+		unsigned int BlendingAndTiming[],
+		unsigned int BytePerPixY[],
+		unsigned int BytePerPixC[],
 		double BytePerPixDETY[],
 		double BytePerPixDETC[],
-		int HActive[],
+		unsigned int HActive[],
 		double HRatio[],
 		double HRatioChroma[],
-		int DPPPerPlane[],
-		int swath_width_luma_ub[],
-		int swath_width_chroma_ub[],
+		unsigned int DPPPerPlane[],
+		unsigned int swath_width_luma_ub[],
+		unsigned int swath_width_chroma_ub[],
 		double SwathWidth[],
 		double SwathWidthChroma[],
-		int SwathHeightY[],
-		int SwathHeightC[],
+		unsigned int SwathHeightY[],
+		unsigned int SwathHeightC[],
 		unsigned int DETBufferSizeY[],
 		unsigned int DETBufferSizeC[],
 		bool ViewportSizeSupportPerPlane[],
 		bool *ViewportSizeSupport)
 {
 	(void)HRatioChroma;
-	int MaximumSwathHeightY[DC__NUM_DPP__MAX];
-	int MaximumSwathHeightC[DC__NUM_DPP__MAX];
+	unsigned int MaximumSwathHeightY[DC__NUM_DPP__MAX];
+	unsigned int MaximumSwathHeightC[DC__NUM_DPP__MAX];
 	int MinimumSwathHeightY;
 	int MinimumSwathHeightC;
 	unsigned int RoundedUpMaxSwathSizeBytesY;
@@ -6919,31 +6919,31 @@ static void CalculateSwathWidth(
 		int NumberOfActivePlanes,
 		enum source_format_class SourcePixelFormat[],
 		enum scan_direction_class SourceScan[],
-		int ViewportWidth[],
-		int ViewportHeight[],
-		int SurfaceWidthY[],
-		int SurfaceWidthC[],
-		int SurfaceHeightY[],
-		int SurfaceHeightC[],
+		unsigned int ViewportWidth[],
+		unsigned int ViewportHeight[],
+		unsigned int SurfaceWidthY[],
+		unsigned int SurfaceWidthC[],
+		unsigned int SurfaceHeightY[],
+		unsigned int SurfaceHeightC[],
 		enum odm_combine_mode ODMCombineEnabled[],
-		int BytePerPixY[],
-		int BytePerPixC[],
-		int Read256BytesBlockHeightY[],
-		int Read256BytesBlockHeightC[],
-		int Read256BytesBlockWidthY[],
-		int Read256BytesBlockWidthC[],
-		int BlendingAndTiming[],
-		int HActive[],
+		unsigned int BytePerPixY[],
+		unsigned int BytePerPixC[],
+		unsigned int Read256BytesBlockHeightY[],
+		unsigned int Read256BytesBlockHeightC[],
+		unsigned int Read256BytesBlockWidthY[],
+		unsigned int Read256BytesBlockWidthC[],
+		unsigned int BlendingAndTiming[],
+		unsigned int HActive[],
 		double HRatio[],
-		int DPPPerPlane[],
+		unsigned int DPPPerPlane[],
 		double SwathWidthSingleDPPY[],
 		double SwathWidthSingleDPPC[],
 		double SwathWidthY[],
 		double SwathWidthC[],
-		int MaximumSwathHeightY[],
-		int MaximumSwathHeightC[],
-		int swath_width_luma_ub[],
-		int swath_width_chroma_ub[])
+		unsigned int MaximumSwathHeightY[],
+		unsigned int MaximumSwathHeightC[],
+		unsigned int swath_width_luma_ub[],
+		unsigned int swath_width_chroma_ub[])
 {
 	(void)BytePerPixY;
 	enum odm_combine_mode MainPlaneODMCombine;
@@ -7049,8 +7049,8 @@ static double CalculateExtraLatency(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double HostVMInefficiencyFactor,
 		double HostVMMinPageSize,
 		int HostVMMaxNonCachedPageTableLevels)
@@ -7095,8 +7095,8 @@ static double CalculateExtraLatencyBytes(
 		bool GPUVMEnable,
 		bool HostVMEnable,
 		int NumberOfActivePlanes,
-		int NumberOfDPP[],
-		int dpte_group_bytes[],
+		unsigned int NumberOfDPP[],
+		unsigned int dpte_group_bytes[],
 		double HostVMInefficiencyFactor,
 		double HostVMMinPageSize,
 		int HostVMMaxNonCachedPageTableLevels)
@@ -7147,7 +7147,7 @@ static noinline_for_stack void UseMinimumDCFCLK(
 		int ReorderingBytes)
 {
 	struct vba_vars_st *v = &mode_lib->vba;
-	int dummy1, j;
+	unsigned int dummy1, j;
 	unsigned int i, k;
 	double NormalEfficiency,  dummy2, dummy3;
 	double TotalMaxPrefetchFlipDPTERowBandwidth[DC__VOLTAGE_STATES][2];
@@ -7166,7 +7166,7 @@ static noinline_for_stack void UseMinimumDCFCLK(
 			double ExtraLatencyBytes;
 			double ExtraLatencyCycles;
 			double DCFCLKRequiredForPeakBandwidth;
-			int NoOfDPPState[DC__NUM_DPP__MAX];
+			unsigned int NoOfDPPState[DC__NUM_DPP__MAX];
 			double MinimumTvmPlus2Tr0;
 
 			TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = 0;
@@ -7314,7 +7314,7 @@ static void CalculateUnboundedRequestAndCompressedBufferSize(
 		int CompressedBufferSegmentSizeInkByteFinal,
 		enum output_encoder_class *Output,
 		bool *UnboundedRequestEnabled,
-		int *CompressedBufferSizeInkByte)
+		unsigned int *CompressedBufferSizeInkByte)
 {
 	double actDETBufferSizeInKByte = dml_ceil(DETBufferSizeInKByte, 64);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 03e49d298a85..1b1ab6a6d53a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1400,7 +1400,7 @@ static void try_odm_power_optimization_and_revalidate(
 		display_e2e_pipe_params_st *pipes,
 		int *split,
 		bool *merge,
-		unsigned int *vlevel,
+		int *vlevel,
 		int pipe_cnt)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 8a2dbb4a2fbb..15f5248340a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -2954,7 +2954,7 @@ void dml32_UseMinimumDCFCLK(
 		unsigned int VTotal[],
 		unsigned int VActive[],
 		unsigned int DynamicMetadataTransmittedBytes[],
-		unsigned int DynamicMetadataLinesBeforeActiveRequired[],
+		int DynamicMetadataLinesBeforeActiveRequired[],
 		bool Interlace[],
 		double RequiredDPPCLKPerSurface[][2][DC__NUM_DPP__MAX],
 		double RequiredDISPCLK[][2],
@@ -5631,7 +5631,7 @@ void dml32_CalculateStutterEfficiency(
 		bool   Interlace[],
 		double    MinTTUVBlank[],
 		unsigned int   DPPPerSurface[],
-		unsigned int      DETBufferSizeY[],
+		unsigned int   DETBufferSizeY[],
 		unsigned int   BytePerPixelY[],
 		double    BytePerPixelDETY[],
 		double      SwathWidthY[],
@@ -5663,10 +5663,10 @@ void dml32_CalculateStutterEfficiency(
 		/* Output */
 		double   *StutterEfficiencyNotIncludingVBlank,
 		double   *StutterEfficiency,
-		unsigned int     *NumberOfStutterBurstsPerFrame,
+		int      *NumberOfStutterBurstsPerFrame,
 		double   *Z8StutterEfficiencyNotIncludingVBlank,
 		double   *Z8StutterEfficiency,
-		unsigned int     *Z8NumberOfStutterBurstsPerFrame,
+		int      *Z8NumberOfStutterBurstsPerFrame,
 		double   *StutterPeriod,
 		bool  *DCHUBBUB_ARB_CSTATE_MAX_CAP_MODE)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 5d34735df83d..9ea36f3ff27c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -614,7 +614,7 @@ void dml32_UseMinimumDCFCLK(
 		unsigned int VTotal[],
 		unsigned int VActive[],
 		unsigned int DynamicMetadataTransmittedBytes[],
-		unsigned int DynamicMetadataLinesBeforeActiveRequired[],
+		int DynamicMetadataLinesBeforeActiveRequired[],
 		bool Interlace[],
 		double RequiredDPPCLKPerSurface[][2][DC__NUM_DPP__MAX],
 		double RequiredDISPCLK[][2],
@@ -1013,7 +1013,7 @@ void dml32_CalculateStutterEfficiency(
 		bool   ProgressiveToInterlaceUnitInOPP,
 		bool   Interlace[],
 		double    MinTTUVBlank[],
-		unsigned int   DPPPerSurface[],
+		unsigned int    DPPPerSurface[],
 		unsigned int      DETBufferSizeY[],
 		unsigned int   BytePerPixelY[],
 		double    BytePerPixelDETY[],
@@ -1046,10 +1046,10 @@ void dml32_CalculateStutterEfficiency(
 		/* Output */
 		double   *StutterEfficiencyNotIncludingVBlank,
 		double   *StutterEfficiency,
-		unsigned int     *NumberOfStutterBurstsPerFrame,
+		int      *NumberOfStutterBurstsPerFrame,
 		double   *Z8StutterEfficiencyNotIncludingVBlank,
 		double   *Z8StutterEfficiency,
-		unsigned int     *Z8NumberOfStutterBurstsPerFrame,
+		int      *Z8NumberOfStutterBurstsPerFrame,
 		double   *StutterPeriod,
 		bool  *DCHUBBUB_ARB_CSTATE_MAX_CAP_MODE);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 07993741f5e6..cde84dfb0953 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -472,7 +472,7 @@ struct vba_vars_st {
 	unsigned int VTotal[DC__NUM_DPP__MAX];
 	unsigned int VTotal_Max[DC__NUM_DPP__MAX];
 	unsigned int VTotal_Min[DC__NUM_DPP__MAX];
-	int DPPPerPlane[DC__NUM_DPP__MAX];
+	unsigned int DPPPerPlane[DC__NUM_DPP__MAX];
 	double PixelClock[DC__NUM_DPP__MAX];
 	double PixelClockBackEnd[DC__NUM_DPP__MAX];
 	bool DCCEnable[DC__NUM_DPP__MAX];
@@ -739,7 +739,7 @@ struct vba_vars_st {
 	/* ms locals */
 	double IdealSDPPortBandwidthPerState[DC__VOLTAGE_STATES][2];
 	unsigned int NoOfDPP[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
-	int NoOfDPPThisState[DC__NUM_DPP__MAX];
+	unsigned int NoOfDPPThisState[DC__NUM_DPP__MAX];
 	enum odm_combine_mode ODMCombineEnablePerState[DC__VOLTAGE_STATES][DC__NUM_DPP__MAX];
 	double SwathWidthYThisState[DC__NUM_DPP__MAX];
 	unsigned int SwathHeightCPerState[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
@@ -900,7 +900,7 @@ struct vba_vars_st {
 	int PTEBufferSizeInRequestsForChroma;
 
 	// Missing from VBA
-	int dpte_group_bytes_chroma;
+	unsigned int dpte_group_bytes_chroma;
 	unsigned int vm_group_bytes_chroma;
 	double dst_x_after_scaler;
 	double dst_y_after_scaler;
@@ -1100,8 +1100,8 @@ struct vba_vars_st {
 	unsigned int DETBufferSizeCThisState[DC__NUM_DPP__MAX];
 	bool NoUrgentLatencyHiding[DC__NUM_DPP__MAX];
 	bool NoUrgentLatencyHidingPre[DC__NUM_DPP__MAX];
-	int swath_width_luma_ub_this_state[DC__NUM_DPP__MAX];
-	int swath_width_chroma_ub_this_state[DC__NUM_DPP__MAX];
+	unsigned int swath_width_luma_ub_this_state[DC__NUM_DPP__MAX];
+	unsigned int swath_width_chroma_ub_this_state[DC__NUM_DPP__MAX];
 	double UrgLatency[DC__VOLTAGE_STATES];
 	double VActiveCursorBandwidth[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
 	double VActivePixelBandwidth[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
@@ -1172,7 +1172,7 @@ struct vba_vars_st {
 	int ConfigReturnBufferSizeInKByte;
 	enum unbounded_requesting_policy UseUnboundedRequesting;
 	int CompressedBufferSegmentSizeInkByte;
-	int CompressedBufferSizeInkByte;
+	unsigned int CompressedBufferSizeInkByte;
 	int MetaFIFOSizeInKEntries;
 	int ZeroSizeBufferEntries;
 	int COMPBUF_RESERVED_SPACE_64B;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
index 2b8afe46ff1c..53b21adc6267 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
@@ -307,7 +307,7 @@ void dpp1_cm_set_output_csc_default(
 {
 	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
 	const uint16_t *regval = NULL;
-	int arr_size;
+	uint32_t arr_size;
 
 	regval = find_color_matrix(colorspace, &arr_size);
 	if (regval == NULL) {
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index d24f02d201f4..8faffc2993b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -548,7 +548,7 @@ bool dpp3_get_optimal_number_of_taps(
 
 static void dpp3_deferred_update(struct dpp *dpp_base)
 {
-	int bypass_state;
+	uint32_t bypass_state;
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
 	if (dpp_base->deferred_reg_writes.bits.disable_dscl) {
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
index 8170a86ad0ea..99581f35e54b 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
@@ -317,7 +317,7 @@ void dpp3_set_hdr_multiplier(
 static void program_gamut_remap(
 		struct dcn3_dpp *dpp,
 		const uint16_t *regval,
-		int select)
+		unsigned int select)
 {
 	uint16_t selection = 0;
 	struct color_matrices_reg gam_regs;
@@ -379,7 +379,7 @@ void dpp3_cm_set_gamut_remap(
 {
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 	int i = 0;
-	int gamut_mode;
+	uint32_t gamut_mode;
 
 	if (adjust->gamut_adjust_type != GRAPHICS_GAMUT_ADJUST_TYPE_SW)
 		/* Bypass if type is bypass or hw */
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 8dcdda46ee1e..9aa5adb15103 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -1336,7 +1336,7 @@ uint32_t dc_dsc_stream_bandwidth_in_kbps(const struct dc_crtc_timing *timing,
 
 uint32_t dc_dsc_stream_bandwidth_overhead_in_kbps(
 		const struct dc_crtc_timing *timing,
-		const int num_slices_h,
+		const uint32_t num_slices_h,
 		const bool is_dp)
 {
 	struct fixed31_32 max_dsc_overhead;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index 7ee31cae5959..cede9588bad8 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -228,9 +228,9 @@ bool dsc2_get_packed_pps(struct display_stream_compressor *dsc, const struct dsc
 void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
-	int dsc_clock_en;
-	int dsc_fw_config;
-	int enabled_opp_pipe;
+	uint32_t dsc_clock_en;
+	uint32_t dsc_fw_config;
+	uint32_t enabled_opp_pipe;
 
 	DC_LOG_DSC("enable DSC %d at opp pipe %d", dsc->inst, opp_pipe);
 
@@ -253,7 +253,7 @@ void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe)
 void dsc2_disable(struct display_stream_compressor *dsc)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
-	int dsc_clock_en;
+	uint32_t dsc_clock_en;
 
 	DC_LOG_DSC("disable DSC %d", dsc->inst);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
index 17acb64a9d80..d84c3399d386 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
@@ -79,9 +79,9 @@ void dsc35_construct(struct dcn20_dsc *dsc,
 static void dsc35_enable(struct display_stream_compressor *dsc, int opp_pipe)
 {
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
-	int dsc_clock_en;
-	int dsc_fw_config;
-	int enabled_opp_pipe;
+	uint32_t dsc_clock_en;
+	uint32_t dsc_fw_config;
+	uint32_t enabled_opp_pipe;
 
 	DC_LOG_DSC("enable DSC %d at opp pipe %d", dsc->inst, opp_pipe);
 
@@ -96,7 +96,7 @@ static void dsc35_enable(struct display_stream_compressor *dsc, int opp_pipe)
 	REG_GET(DSC_TOP_CONTROL, DSC_CLOCK_EN, &dsc_clock_en);
 	REG_GET_2(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN, &dsc_fw_config, DSCRM_DSC_OPP_PIPE_SOURCE, &enabled_opp_pipe);
 	if ((dsc_clock_en || dsc_fw_config) && enabled_opp_pipe != opp_pipe) {
-		DC_LOG_DSC("ERROR: DSC %d at opp pipe %d already enabled!", dsc->inst, enabled_opp_pipe);
+		DC_LOG_DSC("ERROR: DSC %d at opp pipe %u already enabled!", dsc->inst, enabled_opp_pipe);
 		ASSERT(0);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index 363e83ad21db..749547960046 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -145,16 +145,16 @@ void dsc401_set_config(struct display_stream_compressor *dsc, const struct dsc_c
 void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe)
 {
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
-	int dsc_clock_en;
-	int dsc_fw_config;
-	int enabled_opp_pipe;
+	uint32_t dsc_clock_en;
+	uint32_t dsc_fw_config;
+	uint32_t enabled_opp_pipe;
 
 	DC_LOG_DSC("enable DSC %d at opp pipe %d", dsc->inst, opp_pipe);
 
 	REG_GET(DSC_TOP_CONTROL, DSC_CLOCK_EN, &dsc_clock_en);
 	REG_GET_2(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN, &dsc_fw_config, DSCRM_DSC_OPP_PIPE_SOURCE, &enabled_opp_pipe);
 	if ((dsc_clock_en || dsc_fw_config) && enabled_opp_pipe != opp_pipe) {
-		DC_LOG_DSC("ERROR: DSC %d at opp pipe %d already enabled!", dsc->inst, enabled_opp_pipe);
+		DC_LOG_DSC("ERROR: DSC %d at opp pipe %u already enabled!", dsc->inst, enabled_opp_pipe);
 		ASSERT(0);
 	}
 
@@ -170,7 +170,7 @@ void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe)
 void dsc401_disable(struct display_stream_compressor *dsc)
 {
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
-	int dsc_clock_en;
+	uint32_t dsc_clock_en;
 
 	DC_LOG_DSC("disable DSC %d", dsc->inst);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 3c7a6569b692..302515128358 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -63,10 +63,10 @@ void hubp401_enable_3dlut_fl(struct hubp *hubp, bool enable)
 	REG_UPDATE(HUBP_3DLUT_CONTROL, HUBP_3DLUT_ENABLE, enable ? 1 : 0);
 }
 
-int hubp401_get_3dlut_fl_done(struct hubp *hubp)
+uint32_t hubp401_get_3dlut_fl_done(struct hubp *hubp)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
-	int ret;
+	uint32_t ret;
 
 	REG_GET(HUBP_3DLUT_CONTROL, HUBP_3DLUT_DONE, &ret);
 	return ret;
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
index 4570b8016de5..4116834c552d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
@@ -324,7 +324,7 @@ bool hubp401_construct(
 
 void hubp401_init(struct hubp *hubp);
 
-int hubp401_get_3dlut_fl_done(struct hubp *hubp);
+uint32_t hubp401_get_3dlut_fl_done(struct hubp *hubp);
 
 void hubp401_set_unbounded_requesting(struct hubp *hubp, bool enable);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 2c2fa320df40..fc2587ca56ec 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2485,7 +2485,8 @@ void dcn10_enable_vblanks_synchronization(
 	(void)group_index;
 	struct output_pixel_processor *opp;
 	struct timing_generator *tg;
-	int i, width = 0, height = 0, master;
+	int i, master;
+	uint32_t width = 0, height = 0;
 
 	DC_LOGGER_INIT(dc->ctx);
 
@@ -2551,7 +2552,8 @@ void dcn10_enable_timing_synchronization(
 	(void)group_index;
 	struct output_pixel_processor *opp;
 	struct timing_generator *tg;
-	int i, width = 0, height = 0;
+	int i;
+	uint32_t width = 0, height = 0;
 
 	DC_LOGGER_INIT(dc->ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 408d417318c2..09dfbb16dd29 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -147,7 +147,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 // Given any pipe_ctx, return the total ODM combine factor, and optionally return
 // the OPPids which are used
-static unsigned int get_odm_config(struct pipe_ctx *pipe_ctx, unsigned int *opp_instances)
+static unsigned int get_odm_config(struct pipe_ctx *pipe_ctx, int *opp_instances)
 {
 	unsigned int opp_count = 1;
 	struct pipe_ctx *odm_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index fd42f0afc3a9..415b3f875f0d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1119,7 +1119,7 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 * Given any pipe_ctx, return the total ODM combine factor, and optionally return
 * the OPPids which are used
 * */
-static unsigned int get_odm_config(struct pipe_ctx *pipe_ctx, unsigned int *opp_instances)
+static unsigned int get_odm_config(struct pipe_ctx *pipe_ctx, int *opp_instances)
 {
 	unsigned int opp_count = 1;
 	struct pipe_ctx *odm_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index a094c8b40a85..1a0123338dfa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -403,7 +403,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 // Given any pipe_ctx, return the total ODM combine factor, and optionally return
 // the OPPids which are used
-static unsigned int get_odm_config(struct pipe_ctx *pipe_ctx, unsigned int *opp_instances)
+static unsigned int get_odm_config(struct pipe_ctx *pipe_ctx, int *opp_instances)
 {
 	unsigned int opp_count = 1;
 	struct pipe_ctx *odm_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h b/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h
index d567d4bd585d..3fdd9a770334 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h
@@ -126,7 +126,7 @@ static inline struct bw_fixed bw_div(const struct bw_fixed arg1, const struct bw
 static inline struct bw_fixed bw_mod(const struct bw_fixed arg1, const struct bw_fixed arg2)
 {
 	struct bw_fixed res;
-	div64_u64_rem(arg1.value, arg2.value, (uint64_t *)&res.value);
+	div64_u64_rem((uint64_t)arg1.value, (uint64_t)arg2.value, (uint64_t *)&res.value);
 	return res;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 0530b214c4b6..1c18898aa475 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -305,7 +305,7 @@ struct hubp_funcs {
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_y_g,
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cr_r);
-	int (*hubp_get_3dlut_fl_done)(struct hubp *hubp);
+	uint32_t (*hubp_get_3dlut_fl_done)(struct hubp *hubp);
 	void (*hubp_program_3dlut_fl_config)(struct hubp *hubp, struct hubp_fl_3dlut_config *cfg);
 	void (*hubp_clear_tiling)(struct hubp *hubp);
 	uint32_t (*hubp_get_current_read_line)(struct hubp *hubp);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
index e1428a83ecbc..73cc34ea7726 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
@@ -356,8 +356,8 @@ struct opp_funcs {
 
 	void (*opp_program_dpg_dimensions)(
 				struct output_pixel_processor *opp,
-				int width,
-				int height);
+				uint32_t width,
+				uint32_t height);
 
 	bool (*dpg_is_blanked)(
 			struct output_pixel_processor *opp);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 2f70bb476c97..3a80369cde16 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -32,9 +32,9 @@ struct dc_bios;
 
 /* Contains CRTC vertical/horizontal pixel counters */
 struct crtc_position {
-	int32_t vertical_count;
-	int32_t horizontal_count;
-	int32_t nominal_vcount;
+	uint32_t vertical_count;
+	uint32_t horizontal_count;
+	uint32_t nominal_vcount;
 };
 
 struct dcp_gsl_params {
@@ -321,7 +321,7 @@ struct timing_generator {
 	const struct timing_generator_funcs *funcs;
 	struct dc_bios *bp;
 	struct dc_context *ctx;
-	int inst;
+	uint32_t inst;
 };
 
 struct dc_crtc_timing;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index 57bb82e94942..d0609443af49 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -110,7 +110,7 @@ struct link_service {
 	struct dc_sink *(*add_remote_sink)(
 			struct dc_link *link,
 			const uint8_t *edid,
-			int len,
+			unsigned int len,
 			struct dc_sink_init_data *init_data);
 	void (*remove_remote_sink)(struct dc_link *link, struct dc_sink *sink);
 	bool (*get_hpd_state)(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h b/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
index 26cb1459b743..7a1ecb8d986f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
@@ -155,63 +155,63 @@
  * read given register and fill in field value in output parameter */
 #define REG_GET(reg_name, field, val)	\
 		generic_reg_get(CTX, REG(reg_name), \
-				FN(reg_name, field), val)
+				FN(reg_name, field), (uint32_t *)val)
 
 #define REG_GET_2(reg_name, f1, v1, f2, v2)	\
 		generic_reg_get2(CTX, REG(reg_name), \
-				FN(reg_name, f1), v1, \
-				FN(reg_name, f2), v2)
+				FN(reg_name, f1), (uint32_t *)v1, \
+				FN(reg_name, f2), (uint32_t *)v2)
 
 #define REG_GET_3(reg_name, f1, v1, f2, v2, f3, v3)	\
 		generic_reg_get3(CTX, REG(reg_name), \
-				FN(reg_name, f1), v1, \
-				FN(reg_name, f2), v2, \
-				FN(reg_name, f3), v3)
+				FN(reg_name, f1), (uint32_t *)v1, \
+				FN(reg_name, f2), (uint32_t *)v2, \
+				FN(reg_name, f3), (uint32_t *)v3)
 
 #define REG_GET_4(reg_name, f1, v1, f2, v2, f3, v3, f4, v4)	\
 		generic_reg_get4(CTX, REG(reg_name), \
-				FN(reg_name, f1), v1, \
-				FN(reg_name, f2), v2, \
-				FN(reg_name, f3), v3, \
-				FN(reg_name, f4), v4)
+				FN(reg_name, f1), (uint32_t *)v1, \
+				FN(reg_name, f2), (uint32_t *)v2, \
+				FN(reg_name, f3), (uint32_t *)v3, \
+				FN(reg_name, f4), (uint32_t *)v4)
 
 #define REG_GET_5(reg_name, f1, v1, f2, v2, f3, v3, f4, v4, f5, v5)	\
 		generic_reg_get5(CTX, REG(reg_name), \
-				FN(reg_name, f1), v1, \
-				FN(reg_name, f2), v2, \
-				FN(reg_name, f3), v3, \
-				FN(reg_name, f4), v4, \
-				FN(reg_name, f5), v5)
+				FN(reg_name, f1), (uint32_t *)v1, \
+				FN(reg_name, f2), (uint32_t *)v2, \
+				FN(reg_name, f3), (uint32_t *)v3, \
+				FN(reg_name, f4), (uint32_t *)v4, \
+				FN(reg_name, f5), (uint32_t *)v5)
 
 #define REG_GET_6(reg_name, f1, v1, f2, v2, f3, v3, f4, v4, f5, v5, f6, v6)	\
 		generic_reg_get6(CTX, REG(reg_name), \
-				FN(reg_name, f1), v1, \
-				FN(reg_name, f2), v2, \
-				FN(reg_name, f3), v3, \
-				FN(reg_name, f4), v4, \
-				FN(reg_name, f5), v5, \
-				FN(reg_name, f6), v6)
+				FN(reg_name, f1), (uint32_t *)v1, \
+				FN(reg_name, f2), (uint32_t *)v2, \
+				FN(reg_name, f3), (uint32_t *)v3, \
+				FN(reg_name, f4), (uint32_t *)v4, \
+				FN(reg_name, f5), (uint32_t *)v5, \
+				FN(reg_name, f6), (uint32_t *)v6)
 
 #define REG_GET_7(reg_name, f1, v1, f2, v2, f3, v3, f4, v4, f5, v5, f6, v6, f7, v7)	\
 		generic_reg_get7(CTX, REG(reg_name), \
-				FN(reg_name, f1), v1, \
-				FN(reg_name, f2), v2, \
-				FN(reg_name, f3), v3, \
-				FN(reg_name, f4), v4, \
-				FN(reg_name, f5), v5, \
-				FN(reg_name, f6), v6, \
-				FN(reg_name, f7), v7)
+				FN(reg_name, f1), (uint32_t *)v1, \
+				FN(reg_name, f2), (uint32_t *)v2, \
+				FN(reg_name, f3), (uint32_t *)v3, \
+				FN(reg_name, f4), (uint32_t *)v4, \
+				FN(reg_name, f5), (uint32_t *)v5, \
+				FN(reg_name, f6), (uint32_t *)v6, \
+				FN(reg_name, f7), (uint32_t *)v7)
 
 #define REG_GET_8(reg_name, f1, v1, f2, v2, f3, v3, f4, v4, f5, v5, f6, v6, f7, v7, f8, v8)	\
 		generic_reg_get8(CTX, REG(reg_name), \
-				FN(reg_name, f1), v1, \
-				FN(reg_name, f2), v2, \
-				FN(reg_name, f3), v3, \
-				FN(reg_name, f4), v4, \
-				FN(reg_name, f5), v5, \
-				FN(reg_name, f6), v6, \
-				FN(reg_name, f7), v7, \
-				FN(reg_name, f8), v8)
+				FN(reg_name, f1), (uint32_t *)v1, \
+				FN(reg_name, f2), (uint32_t *)v2, \
+				FN(reg_name, f3), (uint32_t *)v3, \
+				FN(reg_name, f4), (uint32_t *)v4, \
+				FN(reg_name, f5), (uint32_t *)v5, \
+				FN(reg_name, f6), (uint32_t *)v6, \
+				FN(reg_name, f7), (uint32_t *)v7, \
+				FN(reg_name, f8), (uint32_t *)v8)
 
 /* macro to poll and wait for a register field to read back given value */
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 026c55ca0196..1ac6a22fecfe 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1562,7 +1562,7 @@ static bool link_add_remote_sink_helper(struct dc_link *dc_link, struct dc_sink
 struct dc_sink *link_add_remote_sink(
 		struct dc_link *link,
 		const uint8_t *edid,
-		int len,
+		unsigned int len,
 		struct dc_sink_init_data *init_data)
 {
 	struct dc_sink *dc_sink;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.h b/drivers/gpu/drm/amd/display/dc/link/link_detection.h
index 1ab29476060b..e8d29fa1550d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.h
@@ -32,7 +32,7 @@ bool link_detect_connection_type(struct dc_link *link,
 struct dc_sink *link_add_remote_sink(
 		struct dc_link *link,
 		const uint8_t *edid,
-		int len,
+		unsigned int len,
 		struct dc_sink_init_data *init_data);
 void link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink);
 bool link_reset_cur_dp_mst_topology(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 6aa65815af22..72b5921227d2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -47,9 +47,9 @@
 #define DP_SINK_PR_ENABLE_AND_CONFIGURATION		0x37B
 
 /* Travis */
-static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
+static const char DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
 /* Nutmeg */
-static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
+static const char DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
 
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 {
@@ -1210,9 +1210,9 @@ int edp_get_backlight_level(const struct dc_link *link)
 		fw_set_brightness = dmcu->funcs->is_dmcu_initialized(dmcu);
 
 	if (!fw_set_brightness && panel_cntl->funcs->get_current_backlight)
-		return panel_cntl->funcs->get_current_backlight(panel_cntl);
+		return (int)panel_cntl->funcs->get_current_backlight(panel_cntl);
 	else if (abm != NULL && abm->funcs->get_current_backlight != NULL)
-		return (int) abm->funcs->get_current_backlight(abm);
+		return (int)abm->funcs->get_current_backlight(abm);
 	else
 		return DC_ERROR_UNEXPECTED;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
index 0779db249765..0f2294bedcc3 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
@@ -375,7 +375,7 @@ void mpc1_mpc_init(struct mpc *mpc)
 void mpc1_mpc_init_single_inst(struct mpc *mpc, unsigned int mpcc_id)
 {
 	struct dcn10_mpc *mpc10 = TO_DCN10_MPC(mpc);
-	int opp_id;
+	uint32_t opp_id;
 
 	REG_GET(MPCC_OPP_ID[mpcc_id], MPCC_OPP_ID, &opp_id);
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
index 4e91e9f6f11a..d7a07e29d23a 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
@@ -1067,7 +1067,7 @@ static void program_gamut_remap(
 		struct dcn30_mpc *mpc30,
 		int mpcc_id,
 		const uint16_t *regval,
-		int select)
+		uint32_t select)
 {
 	uint16_t selection = 0;
 	struct color_matrices_reg gam_regs;
@@ -1129,7 +1129,7 @@ void mpc3_set_gamut_remap(
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 	int i = 0;
-	int gamut_mode;
+	uint32_t gamut_mode;
 
 	if (adjust->gamut_adjust_type != GRAPHICS_GAMUT_ADJUST_TYPE_SW)
 		program_gamut_remap(mpc30, mpcc_id, NULL, GAMUT_REMAP_BYPASS);
@@ -1201,7 +1201,7 @@ void mpc3_get_gamut_remap(struct mpc *mpc,
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 	uint16_t arr_reg_val[12] = {0};
-	int select;
+	uint32_t select;
 
 	read_gamut_remap(mpc30, mpcc_id, arr_reg_val, &select);
 
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
index ce826a5be4c7..83730bbe26a8 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
@@ -293,7 +293,7 @@ void opp2_set_disp_pattern_generator(
 
 void opp2_program_dpg_dimensions(
 		struct output_pixel_processor *opp,
-		int width, int height)
+		uint32_t width, uint32_t height)
 {
 	struct dcn20_opp *oppn20 = TO_DCN20_OPP(opp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h
index fb0c047c1788..8944fa6c8f79 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h
@@ -156,7 +156,7 @@ void opp2_set_disp_pattern_generator(
 
 void opp2_program_dpg_dimensions(
 		struct output_pixel_processor *opp,
-		int width, int height);
+		uint32_t width, uint32_t height);
 
 bool opp2_dpg_is_blanked(struct output_pixel_processor *opp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 60e546b69a05..07895d5f4dfa 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -101,7 +101,7 @@ static void optc32_set_odm_combine(struct timing_generator *optc, int *opp_id, i
 void optc32_get_odm_combine_segments(struct timing_generator *tg, int *odm_combine_segments)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(tg);
-	int segments;
+	uint32_t segments;
 
 	REG_GET(OPTC_DATA_SOURCE_SELECT, OPTC_NUM_OF_INPUT_SEGMENT, &segments);
 
diff --git a/drivers/gpu/drm/amd/display/include/fixed31_32.h b/drivers/gpu/drm/amd/display/include/fixed31_32.h
index 990fa1f19c22..109093311984 100644
--- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
+++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
@@ -445,7 +445,7 @@ static inline struct fixed31_32 dc_fixpt_pow(struct fixed31_32 arg1, struct fixe
  */
 static inline int dc_fixpt_floor(struct fixed31_32 arg)
 {
-	unsigned long long arg_value = arg.value > 0 ? arg.value : -arg.value;
+	unsigned long long arg_value = (unsigned long long)(arg.value > 0 ? arg.value : -arg.value);
 
 	if (arg.value >= 0)
 		return (int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
@@ -459,7 +459,7 @@ static inline int dc_fixpt_floor(struct fixed31_32 arg)
  */
 static inline int dc_fixpt_round(struct fixed31_32 arg)
 {
-	unsigned long long arg_value = arg.value > 0 ? arg.value : -arg.value;
+	unsigned long long arg_value = (unsigned long long)(arg.value > 0 ? arg.value : -arg.value);
 
 	const long long summand = dc_fixpt_half.value;
 
@@ -479,7 +479,7 @@ static inline int dc_fixpt_round(struct fixed31_32 arg)
  */
 static inline int dc_fixpt_ceil(struct fixed31_32 arg)
 {
-	unsigned long long arg_value = arg.value > 0 ? arg.value : -arg.value;
+	unsigned long long arg_value = (unsigned long long)(arg.value > 0 ? arg.value : -arg.value);
 
 	const long long summand = dc_fixpt_one.value -
 		dc_fixpt_epsilon.value;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
index 5cb979c2cf8c..1164fd96b714 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
@@ -44,7 +44,7 @@ void mod_hdcp_dump_binary_message(uint8_t *msg, uint32_t msg_size,
 		for (i = 0; i < msg_size; i++) {
 			if (i % bytes_per_line == 0)
 				buf[buf_pos++] = '\n';
-			sprintf(&buf[buf_pos], "%02X ", msg[i]);
+			sprintf((char *)&buf[buf_pos], "%02X ", msg[i]);
 			buf_pos += byte_size;
 		}
 		buf[buf_pos++] = '\0';
-- 
2.43.0

