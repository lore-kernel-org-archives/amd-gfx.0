Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCB1C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 14:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F738F687;
	Mon, 22 Aug 2022 14:02:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C638F589
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 14:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBjbTsKE/iRLveBIbNF6PFsholjSqEysrz+TAbOU8g6O0N4TwPGQ7DrjvuzdcLipvdxSv3eZeVT/304xbjMTXeutytcnCmcoGQGLATYe13OuLNs5HY5C8tapQib/vL4rwFX4DKZedGf4PfRlswUIZcw5DshjRjHwVYt8CGOIOolesH0YKUfXeK0tmOAnxZesargGA0dRcR6ZezQeLgO44DxPe46sQ2Z3iUPdtGRl8uOGethFkuIWd2Hr3kTuV7NKJ5lUEdb4pp+NZXyq5D8hH1Wa2nhMyFa629CzEvjyIubl+okEIt78Ea5TfFj6AIMGqY14vBAcl6ft0tvU1/3+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xW6eh03RJTsinsr3JnAdGL3J37Kg4s18NosZVk0VEA=;
 b=oaRrucsD1EgGTtqfDyiyp+YiU/NK/MCFwsEmIaUBGdFyTd40FzY+JeBsUzWB6P5ZBuxE6z94UbNbl8kBrUlXnSE461gOZIUPQT1ZS7NZ20pstBvI6W/+p/LtTNYayIIoYMFokoWKAD1vjgdJDqEQcnqGicutc4ank44U9ZJkuk++pm4Bpm4u210Sd/3v57X403voeq/JC1hu3Hrgy1BX+xYj7BEBSTvdLc1h8A1y5qlRMSEYYSIOZbvMphci8XKcDGaEsARgy3b2x/yFnXB77iFogTm/XcN1wvvto0nqs0O4GHMDxrEazg67Bhl+fszI5RbMsSKSoMWCKI8qgz02xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xW6eh03RJTsinsr3JnAdGL3J37Kg4s18NosZVk0VEA=;
 b=EA/m9VuiiBMFqmAgVVRmRTba+xAsbt0jlwyQGF1Znzhm+1+JNGFEbzIM8wFa93TBlEm+9UycSvXao/mKVb3hvi1WBK6nItMO+LX/ExMpQ6W/EAFsLOlHSkIwjPPZHe0wVJvN0vxeJmbrxU9i6Z32+xSUy2Qgf3ueNMQyOLVzkuM=
Received: from DS7PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:3bb::32)
 by SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Mon, 22 Aug
 2022 14:01:38 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::fd) by DS7PR03CA0087.outlook.office365.com
 (2603:10b6:5:3bb::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Mon, 22 Aug 2022 14:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 14:01:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 09:01:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 07:01:15 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 09:01:11
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/display: Adding log clock table from SMU
Date: Mon, 22 Aug 2022 17:57:51 +0800
Message-ID: <20220822095752.3750614-14-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff5bca0e-cae1-45c6-529f-08da8446d522
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5407:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeG5ukkkkOc9cJgpA5t64ReWfZDm7aCw1aCjpAEEsjLk+DyVcZEXpXKYkK815S5NPHeJifuo/ceXYQTR5C/Qq0YM7Y3zqnu6FySAumfEBt3HupB14aR0HKinctXLAevib+PeWh2WqeAPwroRMrP08RfPsKklqdYctxNlH+FJulcmJz36c8NyEsQALoy8/nXkJPn3RIBUzlrqMbzg6q9kul88oSXVBM4MaFC7CxPl37bm8iefg+92b81CbujJDdhZVPc+5N94czqGwC7+pgBzTdqXGzoR+p7oqEBrLoHOF3ohWQSKT4Dcoa0CvHH+XRa1Tb5JKuK7sanqo2g7UTC1uPxWy4LMq+PM/yOMd10UVjHu5uZsUZ54zY6uRqxM5GFerlrstXTS/2BL2h8S7Q5pm8JhflDa6n9iQsw3jqZTxhRzhA4vWfMYi+ZkbrR3zwWoZuVqvUrlbPAYAYpb1lzDABCkIuO9v27iquemwuzWZGAsPQFnuI45QHa9l9T22O/jJ7hRWyyC1xvDtxoepr3dou7N9ouq+aB6gRBVIMMn6/wy3KlrDOIm0rc12fsVl/tZ4IXUZuj+bzRLE71egOjUlNuSGdEkV6gETDNaDpXiTZS8gJr6+pTbUA+0fhBJfVF4cjKV8Zaaf7KiMepsQd8xE6ZN+IlD0w1D7lvqWm8k4QzVVD9Un+r37jGBSN+T9zWJxiSW9qESy4o3vZKU97QyJXshfaU30kT+l2IPmrVbV2mEkSw3BXC58fic6rYBgQjqyIRM3bPO5Vqv95/6Jm4dJmWl6/yoGl7xAH6siiecrLNChRK1g/g3XzTKhW3ZbAvOdmJk2vKNOuDSAXToMVptCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(40470700004)(36840700001)(4326008)(8676002)(54906003)(70586007)(70206006)(316002)(6916009)(82310400005)(40480700001)(40460700003)(8936002)(5660300002)(2906002)(82740400003)(36860700001)(36756003)(86362001)(81166007)(478600001)(356005)(6666004)(7696005)(426003)(47076005)(186003)(336012)(1076003)(83380400001)(26005)(41300700001)(2616005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 14:01:38.3470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5bca0e-cae1-45c6-529f-08da8446d522
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Leo Chen <sancchen@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How]
Adding log for clock table from SMU helps with the debugging process.
Implemented using DC_LOG_SMU to output log.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 46 ++++++++++++++++++
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 48 +++++++++++++++++++
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 46 ++++++++++++++++++
 3 files changed, 140 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index c09be3f15fe6..d43258e3cd4f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -48,6 +48,11 @@
 
 #include "dc_dmub_srv.h"
 
+#include "logger_types.h"
+#undef DC_LOGGER
+#define DC_LOGGER \
+	clk_mgr->base.base.ctx->logger
+
 #include "yellow_carp_offset.h"
 
 #define regCLK1_CLK_PLL_REQ			0x0237
@@ -737,8 +742,49 @@ void dcn31_clk_mgr_construct(
 	clk_mgr->base.base.bw_params = &dcn31_bw_params;
 
 	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
+		int i;
+
 		dcn31_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
 
+		DC_LOG_SMU("NumDcfClkLevelsEnabled: %d\n"
+				   "NumDispClkLevelsEnabled: %d\n"
+				   "NumSocClkLevelsEnabled: %d\n"
+				   "VcnClkLevelsEnabled: %d\n"
+				   "NumDfPst atesEnabled: %d\n"
+				   "MinGfxClk: %d\n"
+				   "MaxGfxClk: %d\n",
+				   smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->VcnClkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->NumDfPstatesEnabled,
+				   smu_dpm_clks.dpm_clks->MinGfxClk,
+				   smu_dpm_clks.dpm_clks->MaxGfxClk);
+		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->DcfClocks[%d] = %d\n",
+					   i,
+					   smu_dpm_clks.dpm_clks->DcfClocks[i]);
+		}
+		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->DispClocks[%d] = %d\n",
+					   i, smu_dpm_clks.dpm_clks->DispClocks[i]);
+		}
+		for (i = 0; i < smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocClocks[%d] = %d\n",
+					   i, smu_dpm_clks.dpm_clks->SocClocks[i]);
+		}
+		for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++)
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocVoltage[%d] = %d\n",
+					   i, smu_dpm_clks.dpm_clks->SocVoltage[i]);
+
+		for (i = 0; i < NUM_DF_PSTATE_LEVELS; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks.DfPstateTable[%d].FClk = %d\n"
+					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].MemClk= %d\n"
+					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].Voltage = %d\n",
+					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].FClk,
+					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].MemClk,
+					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].Voltage);
+		}
 		if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
 			dcn31_clk_mgr_helper_populate_bw_params(
 					&clk_mgr->base,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index beb025cd3dc2..f2f9d2d3908c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -51,6 +51,13 @@
 #include "dc_link_dp.h"
 #include "dcn314_smu.h"
 
+
+#include "logger_types.h"
+#undef DC_LOGGER
+#define DC_LOGGER \
+	clk_mgr->base.base.ctx->logger
+
+
 #define MAX_INSTANCE                                        7
 #define MAX_SEGMENT                                         8
 
@@ -775,7 +782,48 @@ void dcn314_clk_mgr_construct(
 	clk_mgr->base.base.bw_params = &dcn314_bw_params;
 
 	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
+		int i;
+
 		dcn314_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
+		DC_LOG_SMU("NumDcfClkLevelsEnabled: %d\n"
+				   "NumDispClkLevelsEnabled: %d\n"
+				   "NumSocClkLevelsEnabled: %d\n"
+				   "VcnClkLevelsEnabled: %d\n"
+				   "NumDfPst atesEnabled: %d\n"
+				   "MinGfxClk: %d\n"
+				   "MaxGfxClk: %d\n",
+				   smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->VcnClkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->NumDfPstatesEnabled,
+				   smu_dpm_clks.dpm_clks->MinGfxClk,
+				   smu_dpm_clks.dpm_clks->MaxGfxClk);
+		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->DcfClocks[%d] = %d\n",
+					   i,
+					   smu_dpm_clks.dpm_clks->DcfClocks[i]);
+		}
+		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->DispClocks[%d] = %d\n",
+					   i, smu_dpm_clks.dpm_clks->DispClocks[i]);
+		}
+		for (i = 0; i < smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocClocks[%d] = %d\n",
+					   i, smu_dpm_clks.dpm_clks->SocClocks[i]);
+		}
+		for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++)
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocVoltage[%d] = %d\n",
+					   i, smu_dpm_clks.dpm_clks->SocVoltage[i]);
+
+		for (i = 0; i < NUM_DF_PSTATE_LEVELS; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks.DfPstateTable[%d].FClk = %d\n"
+					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].MemClk= %d\n"
+					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].Voltage = %d\n",
+					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].FClk,
+					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].MemClk,
+					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].Voltage);
+		}
 
 		if (ctx->dc_bios && ctx->dc_bios->integrated_info && ctx->dc->config.use_default_clock_table == false) {
 			dcn314_clk_mgr_helper_populate_bw_params(
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index bff0f57e7fe6..14071aef5eab 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -41,6 +41,11 @@
 
 #include "dc_dmub_srv.h"
 
+#include "logger_types.h"
+#undef DC_LOGGER
+#define DC_LOGGER \
+	clk_mgr->base.base.ctx->logger
+
 #include "dc_link_dp.h"
 
 #define TO_CLK_MGR_DCN315(clk_mgr)\
@@ -666,7 +671,48 @@ void dcn315_clk_mgr_construct(
 	clk_mgr->base.base.bw_params = &dcn315_bw_params;
 
 	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
+		int i;
+
 		dcn315_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
+		DC_LOG_SMU("NumDcfClkLevelsEnabled: %d\n"
+				   "NumDispClkLevelsEnabled: %d\n"
+				   "NumSocClkLevelsEnabled: %d\n"
+				   "VcnClkLevelsEnabled: %d\n"
+				   "NumDfPst atesEnabled: %d\n"
+				   "MinGfxClk: %d\n"
+				   "MaxGfxClk: %d\n",
+				   smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->VcnClkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->NumDfPstatesEnabled,
+				   smu_dpm_clks.dpm_clks->MinGfxClk,
+				   smu_dpm_clks.dpm_clks->MaxGfxClk);
+		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->DcfClocks[%d] = %d\n",
+					   i,
+					   smu_dpm_clks.dpm_clks->DcfClocks[i]);
+		}
+		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->DispClocks[%d] = %d\n",
+					   i, smu_dpm_clks.dpm_clks->DispClocks[i]);
+		}
+		for (i = 0; i < smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocClocks[%d] = %d\n",
+					   i, smu_dpm_clks.dpm_clks->SocClocks[i]);
+		}
+		for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++)
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocVoltage[%d] = %d\n",
+					   i, smu_dpm_clks.dpm_clks->SocVoltage[i]);
+
+		for (i = 0; i < NUM_DF_PSTATE_LEVELS; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks.DfPstateTable[%d].FClk = %d\n"
+					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].MemClk= %d\n"
+					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].Voltage = %d\n",
+					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].FClk,
+					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].MemClk,
+					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].Voltage);
+		}
 
 		if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
 			dcn315_clk_mgr_helper_populate_bw_params(
-- 
2.25.1

