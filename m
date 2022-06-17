Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0324C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D55B10F47D;
	Fri, 17 Jun 2022 19:36:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BAB810F48A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YT4EEpSetdSzh+oGdDyV4cs6dTFVJZWsLmlO77wJDTKz5k/aW8Ueo4QNWNWy0BVHOnTDg35M2qSrPbMKP9koddNWdrZgD4yAHJcUCJKmNF2Hqe8kAsGiXlF9Z3V4jHRShWA+H9RJMCGhp7jHOmY/ZQp23F1O6wX9uUGYjKTNzkK7BIrtWihsLgURwD7GdFHwWjXlWV6TA17YnQCgJ6O0fLtxLb2i3d1HqeWgv1yBjTv4PLrVE1BMIsFhS7LzAACeS7rIkOL0SkzwIlhD8LzLphv9Mc9kB82+1OkGHYc797fK6eU2iCQSQ8SlTRt2uNldXZ8c7a82zSFbs2vwa47tEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JGa6JPYTDAFRoN0JSjx1i6+ztv6/jDYMdx3eKJ9+8Q=;
 b=mOewZW1LFmD7aHX3Et8Ax7xk3RuTJ7pvQ5ZHuaFHXSRzm0luoMQdcKQgBge7jT61IX2rvesVfh9njjycAc+Pp2quFoGVxFz750hgWqWoc9dDhX+JLUEZ4419I4xW0ZJosVtQPRUUvnsuWEBW3UFL8MYXSITmZitCiPHBwNfASQiTTVj/yg5R6VciKNBEb3Xa7kJaPGrXqdFf5QKrcQSJBTN57IRN2cjeW1/GZpH4T+h3EBkGxJmtWHRUdP/HiDeBXlTwOpfJ6Q0YYKHpOj6Lg6zpAeGJ78jX/B3kHNZ9rLe6f2AWYjCyEThWJSj8Ok/CGtLgS4hslDSGrDPvHTHsOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JGa6JPYTDAFRoN0JSjx1i6+ztv6/jDYMdx3eKJ9+8Q=;
 b=ft2gnBW2AgScNAVw6QPKGFrzS4/RZJx92jkuW0FPEzAI8m3ing0DGxie0lfVgjuFT/hKJHq2sthncma8HhgddMsx8+L5yMzLQWkdxepdPLfvxpgGL89YWMQWuFE3cEfuhQ8A31ac/UP2t0huvYaWIEnnN4WscUOlWnxy0P0DVIU=
Received: from BN9PR03CA0771.namprd03.prod.outlook.com (2603:10b6:408:13a::26)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Fri, 17 Jun 2022 19:36:09 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::fa) by BN9PR03CA0771.outlook.office365.com
 (2603:10b6:408:13a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 19:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:36:08 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:36:03 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/31] drm/amd/display: Implement a pme workaround function
Date: Fri, 17 Jun 2022 15:35:09 -0400
Message-ID: <20220617193512.3471076-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e7f4a1c-63d2-4b93-7431-08da5098a0c6
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6373787228CD33CFE92CB4CE98AF9@DM4PR12MB6373.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1jd6JbZhDvlBWIkt2h9ambxny+Fs9+ZqSQ5BCPHG+Gje52JTK1jnJkbuLyM53MHXdpwRBXBpAIFU+ZHNKGWASSFDInTodlJeq3x5zM3+jwZTp6Wf5/YLyQQHASKEQwBkTMpLZ+Lx8AaO3+Dzku9HMyn755CwzDhoEMcwTJS73Ht6vDEr3eoF3WguCSJ5T+PvhZQ1ADgwWqRwb5uHLW2lH0vxLZh8w4Z6uQ67qZgdZlW4NlZGItMCXy8Eit5WScr01iFIs0NvxGMsWh/5uyXR5svBvoZvNTCJ/97mlLHEGkIx6+dl/cwBoBcH75hMfKEhk1GRblBZEITAF6QV5dCDFU43+l95hHInXUz+4CtKrC8DFHxf41KB9D5uKRzZPtanqglSI58wmT3Al9ZwSyty+TsKrrLoIkBLQt7p9dXrZNTFUo3MzYW4gaOZLejmxEpnIzhUGaylGGu530FHTJe9fcoAD9zEL7/vHxqW+A79dcfjgsZCRxygVjo2mQJsSXpdOWLrgTd/daA/Mz7if2+OLq7ErRg7gm80mbUgDYyhfllmIqnM/BNXt0GtvhO3hnQaus+JP+kr/GAgji6YVqkolthU60dhHgE+xRpSNmXCKTGKWsDc9YR1Ra/BmWeMO/r07xgvUzfDHCjKZDOy31Ve00EH2L3at5dMG3vxRbxz1GAGgHdlAXy3RaUKT0JoisUsXy1tWXKHev7fDmoNUSMEAC1WshS2Juq88DDgtue/w7u/DKkWtdPYix0KFPiDPHu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(70206006)(26005)(356005)(81166007)(4326008)(70586007)(498600001)(5660300002)(36756003)(86362001)(2616005)(8676002)(8936002)(7696005)(40460700003)(36860700001)(316002)(54906003)(2906002)(1076003)(47076005)(426003)(16526019)(6916009)(336012)(186003)(43170500006)(83380400001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:08.8176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7f4a1c-63d2-4b93-7431-08da5098a0c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chaitanya Dhere <chaitanya.dhere@amd.com>

[Why]
For DCN32 we do not have a pme workaround function defined that sends a
BacoAudio message. Default code had uses the DCN30 function for pme
workaround. PMFW headers are inconsistent with their message ID
definitions which cause ID's to clash leading to inconsistent system
behaviour. There is a clash with FCLK message due to inconsitent PMFW
headers.

[How]
Implement a new BacoAudio function to workaround the problem of
inconsistent PMFW headers in order to avoid BacoAudio message clasing
with FCLK Enable message.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 2 +-
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  | 8 ++++++++
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h  | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index e3abadeca0a6..b31adf5238d0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -757,7 +757,7 @@ static void dcn32_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 	if (!clk_mgr->smu_present)
 		return;
 
-	dcn30_smu_set_pme_workaround(clk_mgr);
+	dcn32_smu_set_pme_workaround(clk_mgr);
 }
 
 static bool dcn32_is_smu_present(struct clk_mgr *clk_mgr_base)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
index d7c99e9179be..67ed8bf4510b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
@@ -115,6 +115,14 @@ void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr)
 			DALSMC_MSG_TransferTableDram2Smu, TABLE_WATERMARKS, NULL);
 }
 
+void dcn32_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr)
+{
+	smu_print("SMU Set PME workaround\n");
+
+	dcn32_smu_send_msg_with_param(clk_mgr,
+		DALSMC_MSG_BacoAudioD3PME, 0, NULL);
+}
+
 /* Returns the actual frequency that was set in MHz, 0 on failure */
 unsigned int dcn32_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
index 352435edbd79..a68038a41972 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
@@ -39,6 +39,7 @@
 void
 dcn32_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool enable);
 void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
+void dcn32_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr);
 void dcn32_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsigned int num_ways);
 void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
 unsigned int dcn32_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz);
-- 
2.25.1

