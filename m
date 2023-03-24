Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2EAC6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B3F10E4E6;
	Fri, 24 Mar 2023 06:52:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0967C10E4E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjBBkW7H9UyJsOtBMeM57XAAfBsTQTWXNGCTAxPm5U8hVIlPqg2kzH33QH70av+wHk7fUIFzm9SjIRd/0hQqubG+WR0l8svRg14LjFOy+r/vB26uvAn8v86PI8bgjwEaC03c+wYrK/QlBwpEx31wuWQ4FPA90zOCzvaGpDwPSS+zleUbPcaQU/rFcd+P0xt6w8HROQklSdAbVchnzEHHd0HCrw/1TKZrR7VJB7iAXoIM5Gzo8b74gNGxNtKTd3EI+byjRy5pe6MuRZVev0U0dIRfT2MbJHIbRMWTfId7SsbJXjkJl8OS/pEnNG6xy6j3IZRCKOmNt0vqzXRChH+jaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKjLLFm08u2gNm7YFH6q9JLGUtScci59ZJhkjC5ZHkA=;
 b=jxeHE3O4uABRzJ+gxNuYQ13EfT5G0nxCrs16kwkmuulqDNQvyNV1rse04ObO10UXO0MGirElK5fWqox/cfg3nZa6dIbr02EVC6sxdGoZbhVdOYlPI1Jmar8NjthZ7J8oH4TorC//2yckSuYstLLHdXq82mNI+Vad7GIFz2zgYQl3XXPSOLcM8AetuRG/+2Z7qI2TtZ7AJ2oiIJnhey0jIhvbYaA9Zza1ASv7yUdnsYiKsrEwNc3tNs//jH3SD8QPjz4xSu+SirShpVEMKZPp0wnTXNDCLXgG0PFxMX6CQcsLollRE+YdSHtvYCPWjzFgYuhExWFO28gsLO4rEZgxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKjLLFm08u2gNm7YFH6q9JLGUtScci59ZJhkjC5ZHkA=;
 b=TE8tHulumEr8Ex05ohMhvNFRzeMa6W9oB6xO95aVoZbsliz1Zv01yHLZLAS0km28JYltATVKtCaDCs2LRudW6VtCaSblS+Zd2hrA3th2mi9G9IXBHyBsRhX8sSkeLp79qzYykx4zykKTrw0BOE5K9fKbQvD6nITXmxSfF9trJSE=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:52:31 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::1d) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 06:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.21 via Frontend Transport; Fri, 24 Mar 2023 06:52:30 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:52:16 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/19] drm/amd/display: w/a for dcn315 inconsistent smu clock
 table
Date: Fri, 24 Mar 2023 02:50:59 -0400
Message-ID: <20230324065111.2782-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 325fb9c2-cc62-45f4-717b-08db2c3456dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYBz3+RAxqfeavJ9wlqHWHuB8YyBhH/7cXRNMAU1I05OHWdMkX7AKmbJrz/oP7gTRXsFmpIOrhbssR1le/QUa87ATc1yoSKSByOqRmsoWv4h5BrjJBIT1Is5V3oEM5OBg8cyf1c0moX+cpWM2mdnP0PzlRdvnsaNxgEPb5ODUHf+ytBYwOjAxhet8ZqJP498nkCvG4V7vFynzzQvbGkEWk1k3Vlj6KaSiff+8cEjTxdtkOilNvrjjdyLLQ/8OH1z64FIAzF1UulLDoJW4UOI4GFovrYgBEPkJCwxt5LuDtiI0SqiRUFrA/2kWk5/Gunl66fnCFUd09CU0pUdXA9JRX+eZTrDznGiWZYOv3ivfFGaZB2xQtwxfDcnfPqpsD6WCLbfZvTiK7A+T4gIqB4FuJ+HC3RoNfqmCOFSzT2Q/1W+eOPsUlYA9lK0DQZs8dSFAG8q2j5+MU4SXG+NWHHgCYrc06et42P7iZNElGUXWu3rlfm3ZMGxTDGwrUuHarqfjV7W6pa5Q9D1WLnzM5bD9snua/ARc/TkvLecjziLWlAUtDDz7ds4MLxzVVc2DvlSud9WuZjgwqmpFUc76SfFPh7dU1ZKFPPlbOXN+LuRIbftkKBW8sZ8NuKru9UZ1FRBWXCCBzRpFxYQB8+ICiVHO8C/Kc7WXkfP+5hhFT8A94Yzr/VYftXSSWIgyy9Q+Lr+HgGTLoSKnYvYEl+d55jXqNIvHBypPyzyO3QYVTm1WkU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(83380400001)(186003)(26005)(336012)(16526019)(2616005)(478600001)(356005)(426003)(6666004)(47076005)(4326008)(8676002)(6916009)(316002)(54906003)(70586007)(70206006)(1076003)(41300700001)(8936002)(82740400003)(2906002)(5660300002)(81166007)(44832011)(36860700001)(40460700003)(82310400005)(40480700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:52:30.8860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 325fb9c2-cc62-45f4-717b-08db2c3456dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[Why & How]
w/a for dcn315 inconsistent smu clock.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c   | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index a737782b2840..b737cbc468f5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -522,6 +522,11 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 		bw_params->clk_table.entries[i].dcfclk_mhz = clock_table->DcfClocks[0];
 		bw_params->clk_table.entries[i].wck_ratio = 1;
 		i++;
+	} else if (clock_table->NumDcfClkLevelsEnabled != clock_table->NumSocClkLevelsEnabled) {
+		bw_params->clk_table.entries[i-1].voltage = clock_table->SocVoltage[clock_table->NumSocClkLevelsEnabled - 1];
+		bw_params->clk_table.entries[i-1].socclk_mhz = clock_table->SocClocks[clock_table->NumSocClkLevelsEnabled - 1];
+		bw_params->clk_table.entries[i-1].dispclk_mhz = clock_table->DispClocks[clock_table->NumDispClkLevelsEnabled - 1];
+		bw_params->clk_table.entries[i-1].dppclk_mhz = clock_table->DppClocks[clock_table->NumDispClkLevelsEnabled - 1];
 	}
 	bw_params->clk_table.num_entries = i;
 
-- 
2.34.1

