Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51862C88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 08:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B28CA10F351;
	Tue, 15 Sep 2026 08:38:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ks8LeCGI";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B3E10F351
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 08:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk3e4vEo4bIWHDWjX+Zl0w8nUq5zkidmDoseu3OP0a9716jPvi38fDZSHxQT2u495oZ0/9/pu6OlKMFa9hp0/OKdw+oiOsvCU0Wjh4gFg8W98ehS/PNTWUtNZU41y6VPJDsjRT+xyrFsToiCUqZtKjk4fito8W0p2iyttA8RIky641vCGauq/tfzFZtaCiBSp9fIZ/opRcJeEF7w+fqjBt6Biq2k6C+5W5dNywdNiATC6orW7ppSGPFtAMEPgqCPKnk6D7YXG1VypxHDFxlPxGSJZ55KlBAYm6Y1bWRcZBjMLhStyQc3MVxveEqyXyWgjcnQPGpg1sSoRuboxW2vWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnDgPdHkm29+1GBAhSrfDU4WdnGEnIdmiNCjvpDj4MQ=;
 b=o3BoQK28gxMPZarwbbZ4bgGAOJksZPWVqhpJHTb/ZylShvBVDR+lD38gHzd7hnxmgGjdTDmoTQuwQjDwekrLELrCPkrlyRfWMw6bxKAAMBfltvCYesmLkegup11mP3gOTFJ+cYtNHskLxWV81s9myKNVlcxnZzR2fCkJjE37wbtonQP7IafCTvp76LPMyFFoC9TowJaqisXG5dc1NRw4aeSEKRVJAjPt4+ksLcNVXoUaLOTsxbasR0N6lxl6Ih1x751RRaR6SeY09e02ZTfyZJjixHW+VF8rsNfikR5O8io1VqgkRyDVfOXYA7XWRsnEd64K2pgcL2UCJD6kWudrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnDgPdHkm29+1GBAhSrfDU4WdnGEnIdmiNCjvpDj4MQ=;
 b=ks8LeCGIaij4ZydBxRwqSz99u0gYMilI+3uIgVivReYLyU79x58najpZotvSIH//NBQgXIMdOQl9kGdelU/K/jykuEOhSkoc/SbGj9QCnrEAZd0I724OnE1ikHD4w9odc0lbRTAKn3+t8ykZ40YK6TPdZoFdVFl56wB/U2ngVcs=
Received: from BN9PR03CA0605.namprd03.prod.outlook.com (2603:10b6:408:106::10)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 08:37:57 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:106:cafe::68) by BN9PR03CA0605.outlook.office365.com
 (2603:10b6:408:106::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 08:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 08:37:57 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 03:37:53 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, "Ivan
 Lipski" <ivan.lipski@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Roman Li
 <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix NULL dereference in dcn50/dcn60 init_hw
Date: Tue, 15 Sep 2026 14:07:39 +0530
Message-ID: <20260915083739.461232-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: e16588ff-920d-4b89-dbe8-08df1304a494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|6133799003|18002099003|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: PXiXP5yKcIvJnOaNVflVVXGWE4XJtMWBBE3aSbEN6r5sdrwBcoBEDQi+HZZIMwoHIVQIScL/sWQ99w3sUFD8OV/jzqKKVjmzBLR6iI/WDiPbAnsmDtMj9f6hpZv39APqW5OY5onDQCW0evbovyKDJxf4bFS8U7NQKaQKgvJYWH6haUcF+Oxd8CUDcAFxZijCIbxVSG1nIE5z2ivQ4xc+/Ts6a3IG2Y89iX1zHxqVc9CzDIvlVXGawXQFh5Pka0Oqw2okTM/2BwactMtie4pOM+THSDuKCq5X614UTDsJll0AK0564+6k5R24Kn6pJ94pCqsf+KnWGqnXHTutykYvxVxZK4spzIQa3fU6sOlIfdMMZVRpsbLWvETB9Aj/EcbyjS+EDULO7nC6C2co6Dep3MT8c6/uCJMOp+CPDY6dP1IxorvZzli/rWhOUcVJ/54+tXEowFQbvxQQHcRiUpwv2xUM0H8WxhcYq58ugcGGFZo7Pgg/y/h3qgbboKsZ3S//LHnxAyqE/0GtuYGcAWmVGZuGCklTfttiyBbww7oiG3zyHh5iS7Vy4R34fJ4LqldwC9sDE7AzcOWu4cwYSz8r+1wNEeed2jadyLLNhq8sSL7t/8pYed3uwzQHKifzzR9kqzI1+TyRzKB7TvWD2yEDqLuh5PKIExkoSDMD8/UizC+nP56xe1YKsL8Qc1FiHr8cTtWv7++WgB7M6R9BKs+hvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(18002099003)(5023799004)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: keBOMrw+zBZLkB2yekJW0tYc1UvbFPo6zt4fT0NmySM5eFaZe2onJkkCg+PxWwhc8ZRKtxXq13+GFUtw5zeA93REdzwFKnCbg7wBIp3yeb3mXNEc7ZofXFHsJFY0a99jLDLL5OrohWCpL/eiuIv7J2uR3bZJnF65oLySYxD7XdOz6WJGeGDMAnXE5ituFHMRMLHNTQHVa7uWp2pc8bGVzlMO8MMRNL8GZOkcSRqkMxcJfOchYzTAl8ylXLaRqk2s4JfkRe1J+kZw6hpJSJ9S2MonoHC3qhb6xK/RnR2bgHhiTpsEeZk5p8/zaGvjOT/D4Oh1K8LVWAkpKBPqsY0/CeaTcUiKotI4/QbC0TBENcjiiXL7medPPpPn1WEfHqcBBBDLpbd/31kl6TW33JsSpCsRi0TYiaTrX33s/G3U4M8VFYTfC8gdQhf6kFX8ZWgD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 08:37:57.1499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e16588ff-920d-4b89-dbe8-08df1304a494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002
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

dc->clk_mgr is checked for NULL earlier in dcn50_init_hw() and
dcn60_init_hw(), but dcn50_initialize_min_clocks() and
dcn401_initialize_min_clocks() are called without any guard,
causing Smatch to report potential NULL dereferences.

Guard both call sites with the same pattern used throughout
both functions:

  if (dc->clk_mgr && dc->clk_mgr->funcs)

Also fix dcn50_initialize_min_clocks() which calls
get_dispclk_from_dentist without checking the function pointer,
unlike the dcn401 equivalent which guards that call.

Fix kernel-doc in dcn60_hwseq.c by adding missing parameter descriptions
for @probe in dcn60_update_probe_status() and @type in
is_probe_measurement_type_for_hubbub().

Fixes: 04d9a88decbc ("drm/amd/display: Add new sources for DCN6")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Ivan Lipski <ivan.lipski@amd.com>
Cc: Dan Wheeler <daniel.wheeler@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c | 7 +++++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c | 5 ++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
index 8b63e75e5ee2..a02f03311da9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
@@ -67,7 +67,9 @@ static void dcn50_initialize_min_clocks(struct dc *dc)
 		 * audio corruption. Read current DISPCLK from DENTIST and request the same
 		 * freq to ensure that the timing is valid and unchanged.
 		 */
-		clocks->dispclk_khz = dc->clk_mgr->funcs->get_dispclk_from_dentist(dc->clk_mgr);
+			if (dc->clk_mgr->funcs->get_dispclk_from_dentist)
+				clocks->dispclk_khz =
+					dc->clk_mgr->funcs->get_dispclk_from_dentist(dc->clk_mgr);
 	}
 	clocks->ref_dtbclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
 	clocks->fclk_p_state_change_support = true;
@@ -644,7 +646,8 @@ void dcn50_init_hw(struct dc *dc)
 			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
 					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
 
-		dcn50_initialize_min_clocks(dc);
+		if (dc->clk_mgr && dc->clk_mgr->funcs)
+			dcn50_initialize_min_clocks(dc);
 
 		/* On HW init, allow idle optimizations after pipes have been turned off.
 		 *
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index a13d36ad8a9c..ef1c10bc9bfa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -769,7 +769,8 @@ void dcn60_init_hw(struct dc *dc)
 			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
 				!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
 
-		dcn401_initialize_min_clocks(dc);
+		if (dc->clk_mgr && dc->clk_mgr->funcs)
+			dcn401_initialize_min_clocks(dc);
 
 		/* On HW init, allow idle optimizations after pipes have been turned off.
 		 *
@@ -1150,6 +1151,7 @@ static void dcn60_build_hubbub_perfmon_sequence(
 /**
  * dcn60_update_probe_status - Set the valid flag on a latched probe result.
  * @status: result sink whose u was written by the GET BLS step during execute
+ * @probe: current probe state used to determine measurement type and validity
  */
 static void dcn60_update_probe_status(
 		struct dc_probe_status *status,
@@ -1187,6 +1189,7 @@ static void dcn60_update_probe_status(
 /**
  * is_probe_measurement_type_for_hubbub - Returns true if the probe type is
  * served by the hubbub perfmon block on DCN60.
+ * @type: the probe measurement type to classify
  */
 static bool is_probe_measurement_type_for_hubbub(enum dc_probe_type type)
 {
-- 
2.34.1

