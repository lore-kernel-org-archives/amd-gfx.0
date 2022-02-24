Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05A0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 18:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50BB110EA55;
	Thu, 24 Feb 2022 18:24:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5605810EA3E
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 18:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+oLoaIGw0GqMSwCExoYRXO18D3mU/TVCflGuyOx6wjYfU+OPX3tTe2ZlsewnJTsSJ84sw0UI7iw8252uGLPHdgEuB/t7lhOkdKl1tI5xEZDVy/oKKJybXNN0YvhobltnYFkh1K3GlPqYRogBuvVSbIEO7ZvR6ECVQMokjEy3WxsCCPOxwRiXtm/1ur6X5f4OJo36QY8zu8dWOf6NL+QrLfbKRC2fpOOjgLqzs2R2574gVIcikPR7cRDQDC8YhQWdV3Ll8wNalUyonq537BppCHR9dEPWnarbHwFzHg/QbA/HWFGnvWJVABvHCoXkUP0XkWChJRnqpGlKiOMWtYlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQixdFbMTxSSG3+mKuQxgweqFLSxd7FAkgzmN/BtkSI=;
 b=k7E5l/wHhP7QF/J3aE/X0Nq7Lcgigzu7g2b4HOdjkUEABa7+zgFZblQDEXLd42Ryy84IPimi2BgfqL6TkJ+WD1wHm40RgVtZNr+6NTg/55rDbMOq4E8T3TWVvG8xMnzClRQDexJ08nok30al8uOiyCGcSDZl39gK4ieaqIYmyKZmijnj9nzMk+Tzjmc3t36PyDEo9EDzacfs7VnSYida+HD0FwuOsSPgHY5zk/6qG0+T+vbq4AgaqRj0g0VfPResEj9khY70mITP3vtiFTmtcyB0THZKgTvEYmdgeK8eFGE+hcXiTiVdwcQPUEWdE1wjplnBI6fqc5JHPL+CtPquOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQixdFbMTxSSG3+mKuQxgweqFLSxd7FAkgzmN/BtkSI=;
 b=tKIImkxSdZqVlNQ/NTWeA6L+r0xuxjQeQKevmIwi0cN9cQJ/mMJRNyWbEKa8kEwTU06ZK5kl0jAbLsx/R6xa/1pO+VIk4m2Pkft8eSx7FKAWldS4CeD7RP4TLK8XNndqwucey8Vk1NbL6Zkgo35vya1n3obVjB8LIn0t0mi8CyE=
Received: from DM5PR12CA0072.namprd12.prod.outlook.com (2603:10b6:3:103::34)
 by CY4PR12MB1781.namprd12.prod.outlook.com (2603:10b6:903:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 18:24:50 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::13) by DM5PR12CA0072.outlook.office365.com
 (2603:10b6:3:103::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Thu, 24 Feb 2022 18:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 18:24:50 +0000
Received: from leodev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 12:24:49 -0600
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix DC definition of PMFW Pstate table for
 DCN316
Date: Thu, 24 Feb 2022 13:24:26 -0500
Message-ID: <20220224182426.1399145-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d96341d-81d4-41c3-06c8-08d9f7c2f203
X-MS-TrafficTypeDiagnostic: CY4PR12MB1781:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB17810FA5EAE6385898E33996823D9@CY4PR12MB1781.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /O24vjahdQsqs4dr2THdML6K0k7Fc8Xjru8WFmSBtEmU8hTVmhA1fLorpCmgws7UArJaUPjqhRoMgbeu7O1YblXnOgl680pcn0xcGT+aZOZgAvvdlJxcPLGB8KJDjRAo5RCsnT5LewhuK2tvw+a3K18rArYKhUbBWb8gLQechL7vlchcZl4DaFQqBXrubBK3rdfoUQ1To7zFuBmZIwl7MnDDnstZm3YY7976JeHIKEYJ574cK2s5SaBz0Z05rRvcnXC4RNba5rkVTzBAFg43DBKWjoaw9kpLYm2qFW+7m/bMRISfdqcdMuoWxr9CaON4g8rfKVoAmuxHwkfvhGMhuJR0p6FwmXYh78w5jFjD136qbjAzoUZyGjJKbbCqKchm69g1qVqhYQEsHPAbZ9lXqesYeQiOfvnUq1DtIx3C+k0TMtmx23pNjGXLFErQQx7LkEFC1DHpsxurmmLKMWKntUI5elyZsk/W8abNK562YF2LvP2PnIR32dk4SeQmz91qntiRThi5lgicum93/iykv4vDKeFRrFEen5vHtNqVWsRcUHhgDRV+3QBFc7AxCLZz7eYNXdCRR4a4FFoi8f16tMTLDGEc60R2nCinCGZdvu7hYhflbqRXAb0IQaEfu63p7rg5ogft92wZzDEVZJw/nxsS1p1+IC2ZKQQBbpdYlLu2h/gIJ9UYmAClz61RV2wT1b8IU+jRRW9ULKTdIJcpPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(16526019)(82310400004)(2906002)(356005)(81166007)(1076003)(36860700001)(426003)(2876002)(186003)(83380400001)(26005)(336012)(8936002)(5660300002)(70206006)(70586007)(4326008)(6916009)(6666004)(36756003)(54906003)(316002)(86362001)(8676002)(7696005)(47076005)(508600001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 18:24:50.4542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d96341d-81d4-41c3-06c8-08d9f7c2f203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1781
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
Cc: alexander.deucher@amd.com, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why]

During DC init, we read power management tables from PMFW. This info is
exchanged in the form of a binary blob inside gpu memory. In order to
parse the binary blob, the correct struct needs to be used.

[How]

Fix dcn316's definition of the DfPstateTable_t struct to align with PMFW

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c    | 11 ++++++++++-
 .../drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h    |  9 +++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 02a59adff90d..c940635b7a74 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -530,7 +530,16 @@ static void dcn316_clk_mgr_helper_populate_bw_params(
 		bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[j].FClk;
 		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].MemClk;
 		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].Voltage;
-		bw_params->clk_table.entries[i].wck_ratio = 1;
+		switch (clock_table->DfPstateTable[j].WckRatio) {
+		case WCK_RATIO_1_2:
+			bw_params->clk_table.entries[i].wck_ratio = 2;
+			break;
+		case WCK_RATIO_1_4:
+			bw_params->clk_table.entries[i].wck_ratio = 4;
+			break;
+		default:
+			bw_params->clk_table.entries[i].wck_ratio = 1;
+		}
 		temp = find_clk_for_voltage(clock_table, clock_table->DcfClocks, clock_table->DfPstateTable[j].Voltage);
 		if (temp)
 			bw_params->clk_table.entries[i].dcfclk_mhz = temp;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
index 4c6b202fe622..658b36d0e107 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
@@ -57,10 +57,19 @@ typedef enum {
   WM_COUNT,
 } WM_CLOCK_e;
 
+typedef enum{
+  WCK_RATIO_1_1 = 0,  // DDR5, Wck:ck is always 1:1;
+  WCK_RATIO_1_2,
+  WCK_RATIO_1_4,
+  WCK_RATIO_MAX
+} WCK_RATIO_e;
+
 typedef struct {
   uint32_t FClk;
   uint32_t MemClk;
   uint32_t Voltage;
+  uint8_t  WckRatio;
+  uint8_t  Spare[3];
 } DfPstateTable_t;
 
 //Freq in MHz
-- 
2.35.1

