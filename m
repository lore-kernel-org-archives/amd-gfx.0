Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156A11094480
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2026 16:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA6510E25B;
	Sat, 21 Mar 2026 16:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lrqanM9H";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013034.outbound.protection.outlook.com
 [40.107.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB31810E04A
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Mar 2026 16:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EG0zhVHi/P26vPGZ15QuQli6MktmOpII9/C9ZKyZIO6EnbQImF67WC5zuaZKLwBt5BysakJ+4jNy7cRVIuuQyEccjHxPmKJY7kfmUJm+iCJYQxbaBPlYFrnAuqhq8d3H1vZ58eFbUHPE3TdU3PINjuYtEglXrFvhVBoPE8DQQmkCXzxxKsC6FKrWN/ZWvzg93nic5Rws/8C4EKz7olDYL1qFVYE5h64Ogt/cwPh8iLYikVYCjMbGqaK9hd3HWD5gJ7ZfYTPgIflTt+kcDVR3fh6N6ilkF7Ia9TWqrWZev/KI7XK7oGo5eYC2Ij53Qry8peYy93QmH2U5qeZqpP0yHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPaO5s1j8/uq3XIAI1vhnWHwZLtaCdYQ3THZwdH6gRI=;
 b=WZUhAWwMnRUo+wJBduDmoEix7R8qRsYJPJjlA9VLuGXnKaiQhUhaf6LQKlZux4611qk4hLOqKG6IDea4EsnGRZeKrgkT5bUdDqyqc8xCPj2odBzsfKDasGtCfwMhmKLuoCBxtW1SY1UjZnFqcWcoqemcKrlpVjArHO4JW2Df2z1Jgjl/ni19Y2GP3mVZkANxq+yiNM/qrdmV8JVWbJSn8iWoG0ktQGiPsVqIVZii4QbymNkBB+RF1rsvvWD7oijTIOe58oezGNChfHEY9/sQHiCyXEyvcnD9BHe9MDhd+9C9nCZLFoKEolpN4EOtRscxzrYLknaK0F00g+w8cxehbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPaO5s1j8/uq3XIAI1vhnWHwZLtaCdYQ3THZwdH6gRI=;
 b=lrqanM9H5Lc0xX1eJYj1WQu58LJGzZISZdRq61LCwcPNOwCNUxMfbXhWTFqjus13hNNzPstofUwfHHLKnE6zd93BoXU1E+nXsM9ZpCBwJrrFXBntvl36RevA1f2+p4n4Y2ibNS4QdMyaEWm6ou9cgbiScuEiI7YgTCOyQoyIH1Y=
Received: from IA1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::9)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Sat, 21 Mar
 2026 16:12:12 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::7e) by IA1P220CA0003.outlook.office365.com
 (2603:10b6:208:461::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Sat,
 21 Mar 2026 16:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Sat, 21 Mar 2026 16:12:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 21 Mar 2026 11:12:09 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Add NULL check for integrated_info in
 clk_mgr_construct
Date: Sat, 21 Mar 2026 21:41:22 +0530
Message-ID: <20260321161122.2024242-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5e86dc-4643-42d1-c0a0-08de87649c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: J0AcApq3Of6lwIO2C9l4HmTxmP/72Z6SJ+UbH3xZ4GaKAUOoWUINlsfgZelgDTMykvswnXvJtq3Ji71Jm8E60x9BnuUOcH+VadJR7NMyqUpQdOmngHP4pFKZ1SovYPvDz0qiE+MTMC3KOnyIxVrT3aLARA426qXNeWlDc2lOtCiHWpU5UczR6mvcUseQ13eVyitsKwo6ZGdW+FoQL0g8LiGH2BddXx0R9rPcYJH+X6TonRcmIz0EHWfLVNYk3MZO2naVI+mX630jluIjgHYTZntntmyuQKPs6GFsa9WXZPdKPi4F4L7zTx8zupOCNT4SUqnkND0fpp9b7XdhIRDLXLmQX3IGdpnRsypjSR0sVgZg/SGQSriLxebsUrTKTcGi+aN+4vveYQNVgjuAUiW2DftxXh9kXgNAFWVLXNbPJsvKhdYh9uoJ31VZzjrB425ElDF9216eiC7SCsVOfp/ZyNek/KCyPLb+IuQ+fx61RONXCHBEqAE82KzoJsH18qiSvzSSwcX2katuio29H+9QydF1WFv9t0NS+5cBmJKzKXGSG1WmHz6G6DTNruTH5G5d3CFTPc52tIZSLh8bd8SuWd3JhT0JnbUnoZZMYTAP6a8am0VWLhUXJTG9UjB17YAjUIMEHAgmmKG3kM2w/+3kbGD6TXq4ATMgtEpUEAr+hrAMMA1JFcOjmUESkBCK3nTfTHzEr4Q3MsQMC5eyUYtksUBwL7j+tijsvMH1w25M/0PfxxAjBRpBHJSXHWobbdyt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aiQREBeiia8sidj4bHD8rG7uuRqxgCcPGlNc2a0N3TogE5lZhBMmaBWYm8uKp5VwXS2RdR5J7j7JQOVmxQLRQ/4tV2gKNPkHbKB+GWyqJXNu+HINOC20RSHLWGh1Sw0Kj66Bl80NOBnPu2dpV8EEXa3gbACPgjTCxafwXAmmZc8MbzndqI7Ve4SEEewfm9iO/5pXEE5e+4udMSXk7PvffpMmhVOwstnCJCWlNq2qRXRWQuJzyYfqGH5fo/Kg1EVE6UxqVwptlxyQYEra9iCdWHStLROBu+iuloPOjHzwSu+m2DUeZrY2cTuIALjhEd9g3ONSeZ6H10RgVeZgWZJIK5RhuAN0JmSI1Hwy7SQ3TLCUg8MLav/+kvfkPNWrGepC3z8xo1aXr95tMVSv586imCAl0shJefkvwBTan/odJJw5MRnhSI5dJgDJ4tRhpJj+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 16:12:12.0517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5e86dc-4643-42d1-c0a0-08de87649c3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947
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

clk_mgr_construct() initializes display clock and memory bandwidth
settings during driver bring-up.

As part of this, the driver selects a watermark table based on the
memory type (DDR4, LPDDR4, LPDDR5) from ctx->dc_bios->integrated_info.

The display pipeline continuously reads pixel data from memory,
processes it (such as scaling, color conversion, and blending), and
sends it to the screen. To keep this pipeline running smoothly, the
driver must ensure there is enough memory bandwidth and that clocks are
increased when needed.

Watermark tables define when the GPU should increase clocks to ensure
there is enough bandwidth to feed pixel data without underflow.

However, ctx->dc_bios->integrated_info is dereferenced without checking
for NULL in multiple clk_mgr_construct() implementations. On some
platforms, BIOS may not provide this information, and accessing it
directly can cause a NULL pointer dereference during initialization.

Fix this by adding a NULL check before accessing integrated_info.

If integrated_info is not available, the driver safely falls back to
default watermark tables.

Fixes:
../dcn21/rn_clk_mgr.c:775 rn_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 743)
../dcn301/vg_clk_mgr.c:750 vg_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 736)
../dcn31/dcn31_clk_mgr.c:789 dcn31_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 728)
../dcn314/dcn314_clk_mgr.c:906 dcn314_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 845)
../dcn315/dcn315_clk_mgr.c:716 dcn315_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 655)
../dcn316/dcn316_clk_mgr.c:660 dcn316_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 639)
../dcn35/dcn35_clk_mgr.c:1540 dcn35_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 1467)

Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  | 3 ++-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c | 7 ++++---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   | 7 ++++---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 3 ++-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 7 ++++---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c | 7 ++++---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 7 ++++---
 7 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index e18097f82091..09e83097a623 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -740,7 +740,8 @@ void rn_clk_mgr_construct(
 	if (clk_mgr->base.dentist_vco_freq_khz == 0)
 		clk_mgr->base.dentist_vco_freq_khz = 3600000;
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr4MemType) {
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr4MemType) {
 		if (clk_mgr->periodic_retraining_disabled) {
 			rn_bw_params.wm_table = lpddr4_wm_table_with_disabled_ppt;
 		} else {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 7aee02d56292..57ba7bc4d16e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -733,11 +733,12 @@ void vg_clk_mgr_construct(
 	if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
 		clk_mgr->base.base.dentist_vco_freq_khz = 3600000;
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
 		vg_bw_params.wm_table = lpddr5_wm_table;
-	} else {
+	else
 		vg_bw_params.wm_table = ddr4_wm_table;
-	}
+
 	/* Saved clocks configured at boot for debug purposes */
 	vg_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 051052bd10c9..44bf48f96183 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -725,11 +725,12 @@ void dcn31_clk_mgr_construct(
 	/* TODO: Check we get what we expect during bringup */
 	clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
 		dcn31_bw_params.wm_table = lpddr5_wm_table;
-	} else {
+	else
 		dcn31_bw_params.wm_table = ddr5_wm_table;
-	}
+
 	/* Saved clocks configured at boot for debug purposes */
 	dcn31_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
 				 &clk_mgr->base.base, &log_info);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 0cb37827a62b..c69ec7a0e0ae 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -842,7 +842,8 @@ void dcn314_clk_mgr_construct(
 	/* TODO: Check we get what we expect during bringup */
 	clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
 		dcn314_bw_params.wm_table = lpddr5_wm_table;
 	else
 		dcn314_bw_params.wm_table = ddr5_wm_table;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index c49268db85f6..8d6949ad700d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -652,11 +652,12 @@ void dcn315_clk_mgr_construct(
 	if (clk_mgr->base.smu_ver > 0)
 		clk_mgr->base.smu_present = true;
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
 		dcn315_bw_params.wm_table = lpddr5_wm_table;
-	} else {
+	else
 		dcn315_bw_params.wm_table = ddr5_wm_table;
-	}
+
 	/* Saved clocks configured at boot for debug purposes */
 	dcn315_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
 				  &clk_mgr->base.base, &log_info);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 1769b1f26e75..b858e21ca070 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -636,11 +636,12 @@ void dcn316_clk_mgr_construct(
 		clk_mgr->base.base.dentist_vco_freq_khz = 2500000; /* 2400MHz */
 
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
 		dcn316_bw_params.wm_table = lpddr5_wm_table;
-	} else {
+	else
 		dcn316_bw_params.wm_table = ddr4_wm_table;
-	}
+
 	/* Saved clocks configured at boot for debug purposes */
 	dcn316_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
 				  &clk_mgr->base.base, &log_info);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 6fc524752613..2798088842f4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -1464,11 +1464,12 @@ void dcn35_clk_mgr_construct(
 	/* TODO: Check we get what we expect during bringup */
 	clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
 
-	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
+	if (ctx->dc_bios->integrated_info &&
+	    ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
 		dcn35_bw_params.wm_table = lpddr5_wm_table;
-	} else {
+	else
 		dcn35_bw_params.wm_table = ddr5_wm_table;
-	}
+
 	/* Saved clocks configured at boot for debug purposes */
 	dcn35_save_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
 
-- 
2.34.1

