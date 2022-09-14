Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57914ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F3B10E7F5;
	Wed, 14 Sep 2022 03:33:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FCF110E7F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4ktamnA5fU1A6aXzF9bKvSfDOwx/iqOW1KSjW7cf0UHOLBaa4OUHTycN30Llij/eEh6XkI1L1/DR8lVozuNpKcV2/ThU/L5UfOrv/F/0gOdbn5j7Ddhe6w+vJcrRNjVlWZ68woCytKH3hmz1gpFk8YkKWT+z6oyEPVDSVmXUw7J6mkKdKCffhu/EwYOmMSuKnha9nQY4ltsN57CrWshFodc5hllZAjVi1wUjQW2StpHvfLgLBg5Cxy4SvaERMHl3IT15c61WFmi+V/5A7UAVqCKd/uDfOaD+1OEupnASK4uRR3sMjhvfje9W+HtHSaHDAfBmh/ewatAkK/FUzCNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpdw30ij4Fwu8LPqV26bibIITnnD9ShCLNuGUxOJp7A=;
 b=SocPx1fIbI1TwY0gV8aBI0t84OblXPS+alwobTxfgFVaUWDnUn5KCDr12fSuOr2MVx6Tfb+ysqE27GbiSm118apjF86NFFHeLQqYy1f+0GlhOXFb1VbE0IzRcOC+zJd1l8/uxFs6/DF01KfBUrDEFP8gZbPA1g79mFLB0149F077R3EP5HtSGERPLQpAkE3dLRztJa3iCPcFEM+ehPmEvoa3yXcsXfQ/M8xaTOYo32rZf6JHPB71v8AXsaYB6nyvd47IV1rSsQaSerLiJ2CfIgNY+oExhzW2ucWe63bmvU+GMHygb+j2Fot+qt86hVfTlxiBTHnO1orobXdY3cg9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpdw30ij4Fwu8LPqV26bibIITnnD9ShCLNuGUxOJp7A=;
 b=2NxH7gk/cm8HC8TmflK6Qfwi4ba6pJHzgFhmXXpL2dC7vtwwVc3dGXgQKn2ZB/tpbjIQzD/FTUQLjgpDLSmQ0ms4E3DaI9Hsg5YV4RcgtviKgRmqS+rG7prWVgMK5ICmI8nRy6RocjX+DWMymcWCMMfsDSeXFI0Me0UBkiKlq10=
Received: from BN8PR16CA0032.namprd16.prod.outlook.com (2603:10b6:408:4c::45)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 03:33:22 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::26) by BN8PR16CA0032.outlook.office365.com
 (2603:10b6:408:4c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 03:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:33:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:33:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:33:17 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:33:13 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/47] drm/amd/display: Fix urgent latency override for
 DCN32/DCN321
Date: Wed, 14 Sep 2022 11:24:17 +0800
Message-ID: <20220914032441.1075031-24-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 6123d676-2549-4b0e-149d-08da9601dfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ARVRO8m1e5P6vXxCfyozOMEuKy1HyhW2gkBbNAzI3ONO1FuMkefDODliBJDu/m3niNk0hmO88UNN+A9vJr9e3ZwfHVCEHHUjNuWollNA5M2R1F6fybEQV+OBrHoB8XOmhB/3Vi+jMy/D5lsfyWVkusRBI6rpv8W3/puktNVcq1k905J7eomUvmn4ZZBF9Hrvlfxvuquzyy4PNY4fTrmOyc1wUoZ8rfyHM2c6fWwTtzOUEpasno6TK3g7yN16hWivi/nd1sLYQHglEEi8qI4VzsIPktpDlcBWAkT1Z4k9CJ3biVpd+ckaEmYf9x++vpLRXIRMyFK+Ywk1lqdToDIXRFE/6QYxTgxDZKzsS0iWHgoe8xYxRoFM/Bxjq3pbyfecdztC5yLcsiSehOIFZ/KfqqPwyGa1U2crMjIp7phdodJJbhcRq61GrSG60Kwg5yf2ht8UsdYjO6G+QBUQPEvYklsvrSX2rBIhCLytRTiFOZMfDmgRVSRdGz604Ea+glT1KE8NBXn42+QC9RJx/1cshXKyVLC8cfAPHPoSgV6WTxVAg3pGRJV/DedVaLI8CCVy+id8TbA8Sbes+f1iYT/QmMXFqlNYF4FufcqJVaMXVcLdv/jqH8s9/99hkVvzaTUr6vSQkURjR5+hoOa8gWgDTrf3v96YnOr/0699nDZvsVsIGChbDqTtowJzrLECCD6F+zHmYrid8S6OhwC2fi5b7FF52Wq/8ibDCvB8LrHSEFqmb5ZNPGfFwKaBmclRzX4+VK3hGv4LdPqrA83gDBhHuLkvQoBDq5TDII+DsOzKDgHAC7DSH8b5wACaI0zSppH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(8676002)(2616005)(41300700001)(82740400003)(81166007)(336012)(8936002)(40480700001)(426003)(26005)(40460700003)(1076003)(4326008)(186003)(70586007)(86362001)(70206006)(5660300002)(356005)(36860700001)(83380400001)(7696005)(47076005)(82310400005)(478600001)(36756003)(316002)(2906002)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:33:21.9286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6123d676-2549-4b0e-149d-08da9601dfc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
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
 qingqing.zhuo@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <Nevenko.Stupar@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
The urgent latency override is useful when debugging issues
relating to underflow.

Current overridden variable is not correct and has no effect
on DCN3.2 and DCN3.21 DML calculations.

[How]
For DCN3.2 and DCN3.21, override the correct urgent latency
variable when bounding box override is present.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 7ff7cd8b5c93..b8d4547a885f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2197,6 +2197,7 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 		if ((int)(dcn3_2_soc.urgent_latency_us * 1000) != dc->bb_overrides.urgent_latency_ns
 			&& dc->bb_overrides.urgent_latency_ns) {
 			dcn3_2_soc.urgent_latency_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
+			dcn3_2_soc.urgent_latency_pixel_data_only_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
 		}
 
 		if ((int)(dcn3_2_soc.dram_clock_change_latency_us * 1000)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 7ebf25e87933..dd90f241e906 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -489,6 +489,7 @@ void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 		if ((int)(dcn3_21_soc.urgent_latency_us * 1000) != dc->bb_overrides.urgent_latency_ns
 			&& dc->bb_overrides.urgent_latency_ns) {
 			dcn3_21_soc.urgent_latency_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
+			dcn3_21_soc.urgent_latency_pixel_data_only_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
 		}
 
 		if ((int)(dcn3_21_soc.dram_clock_change_latency_us * 1000)
-- 
2.37.3

