Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC8FCD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 15:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FF410EEF9;
	Wed, 13 May 2026 15:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S63zJkP/";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013021.outbound.protection.outlook.com
 [40.93.196.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E6C10EEF9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 15:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wn94gvvYRnT7YVLWArQTWbyj0E1wXIVkNzpODu6n+cQqVOO6uj162yT0G89uyDByRfV9o8x8orI2cP928UBIl3QmSS3hmLG1vGjaYe1JnGu+2QSqVG3UCeijUGDKqqJRPrFtqs8RWncqOewVGLyq2Y6nPbdz6LUWk+XN1Gl8oQ3RAQx2uiiEyq8ZS+vxqJBLTkyfJLNxVkKMRWemRZMP8Ve7bwnA9rgn3RvfkOsbxCKUARK9OIgQ4Pt/GNXxuEHcT1/VYpcywHudnmLf1C6pfv29DBuRxSuA9OvX47U3IQ+wd4GxuACQwVGyk3P9ysWIY565l0sHNQAYY+xwQ+vLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4i15L5Ra9lhxSc2xtUdrXT+Z7OUZ2QG4aAP+lowUAqA=;
 b=WoaACkHORvPFU7/jY1Zgr82VTftv6BD9uipAQ6czgro5opwAIuDYK1+vWj1/qvmRHbwISquNypKldrExZ9wxl1T9CIrt4qaFfe7k0Phk/gVg9F3ru+cblh7q4eSS9gm9oPraTylZp40yre97ilsuOapz1dTJI3ivGuzq+CwhH7hKYo7xPKyKyX0wgndIKD68kL8rS2DWSJnCKCA2pv7ZHMjHdExyL2nl9JOMQvpvijHEqb6/ZdybDzP8/N0T0HRcxL1IW+zDuu7mwK+7wD3Sm7gOGILT9WH+pc3tgXqr0zRpwLCdmKc4lg54jjPk2YW+e57ZgYiE1zFoGEqI1Mh/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4i15L5Ra9lhxSc2xtUdrXT+Z7OUZ2QG4aAP+lowUAqA=;
 b=S63zJkP/KrF5EAo5AYRsSb1poKddgxVjLjwAJcKL9M1ZZjTTTR2ylC40W7dW++h1TnUPaiG33oxc/riZS8+63PR1Qk23+WIWi/yNBhP6ar10d4ATY1VLeAGydJYHx5lXBjZlHbbBGZvInGU46WHL9ieg/g9qJS71QmlRfG6NS6s=
Received: from SJ0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:a03:3a0::27)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 15:02:52 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::a1) by SJ0PR03CA0262.outlook.office365.com
 (2603:10b6:a03:3a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 15:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 15:02:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 10:02:50 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 10:02:49 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Ivan
 Lipski" <ivan.lipski@amd.com>, Max Chernoff <git@maxchernoff.ca>
Subject: [PATCH] drm/amd/display: Write REFCLK to 48MHz on DCN21
Date: Wed, 13 May 2026 11:01:03 -0400
Message-ID: <20260513150102.1857531-2-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c8ef6b-c417-4f07-e859-08deb100b3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qAiaqsdQzfxPugXx57Xgojqe57nKqfP9S0VTO/zcGPAAfap6HH+eIqEFvrT0eOr+gUi2KqEG6wMN7DMGlKAT0oi3NBVpEuc4btQ41gKeL02r4bi0XgsKWcCm7iUx4PHJGHXAWnWCZ1a0ojO7EYwitQPrmT2WH5fo2vWvIPq7/+xutENn6VEtEgA/lyU/1eCSQEL0Svkti+7IcrhsHLmwB2+TvA+mDoCtrpM1Z+eZKdkj4wkFIk1KcsWCtQV2+dWvWeOCow9lLWCK+8zW82WgKX0BIKYsTSfie4gQxFo+S/bEDPedPX25e6sPPwvyT2wKAlXco4x+oSFY9Pr9t4RVbDtD3rMibLqmwjynXcbvcbde7pPg/YO68r6aTawW1WGtljs4bl+IUfxddGiF43wxM9ulyJxYmcz2tv7IVzb4lgcaUpDkTYLtwyyJnonomCXPxO0uiarQ0tUj1ep7ipC/oQtZBFvQgUrR6W0vKfV63pUXTsC5zzr5nCkRWZdcIVZX1NimmSvN/p2+D/856w7C1UYgLrlOdHCAP3r5CesiRim65E7dnsRtRja+Hao8MlMinXZncNOrHOG2bBhJ90IiyuG1TpbFRQX37/WcMcU3FucDjJliC7V2okDY2vE51b8FXtRgkmimoOMKR338NQi57/hkRQ7H+M+XXYG2p7CzjoKZA+UQnb98OXoNXsB/Y5bN5U3CuhEckMsIbvPxg3fAbyIK2Au2ziKy1+CbE3Yat2Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YV/QvYSdpG3weGemOaiOwJw1jlI5473v/nDGDioKnc/fDjU7sqnopYj/7hW2ejCb1NPTwmxD6jF2pUDcJG5LiCDLXNTgSyN32k5YKx6S5pSSuBOJdLF6k18Y7FI5/58OyOg0QnoaE4UfItrTu4hU/7EsOflXMSpNodoTztUanEiCvePEH4qennAR9DJvtNh4p4NOy1BB3GL5gpdVktaN/3XPx6Rb9swXgd0gjc4/guCTxDEeF3qSQJnfZrDpB/e+zSThh6WPHMCCKV4AL4F2h/Tff0yA5y8PBgK+F/xXC8bLn1Pnhop4crPmkkij0uNjP6Fqnu+WayL3oWIg8GYl/AC/Br/6Zl9QvhNX++Vwnfm4gSfwgbac/RPneWw0m/4tOQf4+QQuQ0TbZuow3QA458t9NoMRmb0K5BTOlTGzysDaPWOjM6Z7ZxqvAo546cql
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:02:50.4066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c8ef6b-c417-4f07-e859-08deb100b3a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
dccg21_init() calls dccg2_init() which hardcodes 100MHz refclk values
for MICROSECOND_TIME_BASE_DIV and MILLISECOND_TIME_BASE_DIV. DCN21
uses 48MHz refclk, so the wrong values corrupt DCCG timing and cause eDP
link training failure on cold boot.

Write the correct 48MHz values directly instead of calling dccg2_init().

Fixes: b7dfeea1e168 ("drm/amd/display: Add missing DCCG register entries for DCN20-DCN316")

Reported-by: Max Chernoff <git@maxchernoff.ca>
Tested-by: Max Chernoff <git@maxchernoff.ca>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c  | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
index bdc3ce5d4f47..3d1dbd5a2c20 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
@@ -105,15 +105,26 @@ static void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppcl
  * dccg2_init() unconditionally overwrites MICROSECOND_TIME_BASE_DIV to
  * 0x00120264, destroying the marker before it can be read.
  *
- * Guard the call: if the S0i3 marker is present, skip dccg2_init() so the
+ * Guard the call: if the S0i3 marker is present, skip init so the
  * WA can function correctly. bios_golden_init() will handle init in that case.
+ *
+ * DCN21 uses 48MHz refclk, not 100MHz, so we must explicitly set the correct
+ * values (48MHz is taken from rn_clk_mgr_construct()).
  */
 static void dccg21_init(struct dccg *dccg)
 {
-	if (dccg2_is_s0i3_golden_init_wa_done(dccg))
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (dccg2_is_s0i3_golden_init_`wa_done(dccg))
 		return;
 
-	dccg2_init(dccg);
+	/* 48MHz refclk from rn_clk_mgr_construct() */
+	REG_WRITE(MICROSECOND_TIME_BASE_DIV, 0x00120230);
+	REG_WRITE(MILLISECOND_TIME_BASE_DIV, 0x0010bb80);
+	REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0x0e01003c);
+
+	if (REG(REFCLK_CNTL))
+		REG_WRITE(REFCLK_CNTL, 0);
 }
 
 static const struct dccg_funcs dccg21_funcs = {
-- 
2.43.0

