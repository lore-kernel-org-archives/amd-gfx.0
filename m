Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE686C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC8C10E828;
	Thu, 26 Oct 2023 14:21:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E808410E828
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9/gBTKgF5M5r7rhJEQ0RT4dk05QJYGMJtZhGKYRcY8kWXVdHQm4Nv6+AqpUOZyU7MXyM6FsWltXi2bL/YUA8alX3HWctcAYsxdf/EFEYgpa9PyZZWm3NMcUIrQDjfMgPILCSQKzXOnR2ceUaztaTgrmmnts77ywvu7jHCOkIPYuxbWNbfPkmZ93nDhYiihQZtv4/U2x7CgtdvuPB2ZnC9/IjCn+jmUA4sxqPbtT5e0LntgKpYXrHr5QEYavXK94lQ3oLmRdHPndgopO7X2onIZZ8YybOBM+HjfNnQH/jNiPz3ZkJKhv7Pl+h1UfDtCOjfZu4nqbM1kachdQEoArDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RCWlV9AOCsSJjFuxLC3x0V3Pydp2gp5pE/8TBrYjPU=;
 b=biZdOVtNhc8hgU8UiE85UXAkPf/WFwKzDnZ2daJ4tr9XHuiRMmFTiXf/WwGIlAK1vT3Uu8OdiBSf/CwXNAGxY2uiSZlHkesv9+aGMr3z8YvABpe6TSDxR3a8uR/mslaCOK8sPHfo8hXns2ON88MV0FCnyYzraLEt0jOaigN/7/vjGbqbYjvB48zh2mgUYBZ37LCJ41UvniMpUe5UmBY25XPVmFCqPICKKIqObMcjW6qQOqQvwGXKoiaot07BSEo2nyxlCwVid916hT7DJRmfSA4hMfHkLlk0TJN4S9vpeUpVOrtDNDf89zCeolV6JQxQ8R5Sj7nJK0pwaNe/ttucSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RCWlV9AOCsSJjFuxLC3x0V3Pydp2gp5pE/8TBrYjPU=;
 b=iBY7auTooa0KsdE8zfJ/dSqH3GhvCMrVUCpMcYY3jcpJM2+Qj8ZVzrksmQHdlioV52Bl0h59vSW2GBWFTOcQBSd71PsHpYGekTkIHoDqIuKVnhLoX0ytXCTsg5oUVy01ld3yhGgO2M9hBGTWUbKG8GThdrvB6AZjMlJ8/U3LpfY=
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 14:21:08 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::13) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Thu, 26 Oct 2023 14:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:21:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:21:07 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:21:06 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/25] drm/amd/display: Enable more IPS options
Date: Thu, 26 Oct 2023 10:20:19 -0400
Message-ID: <20231026142020.67861-25-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: a79de9ac-6951-47bf-d753-08dbd62ecbeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiu3WIHO2s5n1c2neyNg/8xr2gd+0UY+D/3Y8tMn6j11V4ETkOlj/C+jbeynyM2fNFZUmDXKiMz1LA5A3fkLKUgjLLEFMl1LuLBPEOpYanMorZYd5jvbQCAhF+8HMz/lRld23U6RwjfUalF5xDPOwa0jkYvS88el90bUMoNxn98w6Cc0TANybZHqUueonL6FD+RiHmwjJgGqWpvL/4GRjGlwdhpUkxoPpO7n4UAlDRmqdmuTLvGe5KeatARLdWRNW5bAEiRs2kN2aWri1vt6843/5Z2fKwv0LtdHJbkWUjmXqUKSysOv8DEloU7TuJRflkC9rpahAGkgOf5oqlGXYNPrxuzg+mGWnMoGdLAwv2YFSccVF5VAb6byGYGA8A9xqdGOXT0E3nc2QAiexM7jcOCJU2H7P2FoNDMtZf5HrGtg+m95agjECRhDKKuF6lYuHfN9+G0JfiBqad520do0X/FuN+Rwt6SbQDc7iLtro7sGY8fjO9dhtcfDCsWlpDNA5jifJwBA5XiENVL9MNKgKt6c+SQeUpAUfzyPpXAyVUbG5mUiEYLD0tC7LSebKy8W3MxF9l8wP5jijq0oKw2Glm3MXOfvmcmLxqpqd62z5foDml33dzq4qh/JePeXslWX4eg0dLSFVjkyHCBRzVrb8HYWwWt0qsx5YUA29syrl0LECfA8FF0H64imoRtO2OVQzZbXjdi6pb3P9ThCboauXADYyE+GdGssfUMyH1NZzre0IR0RFQHPWvoRCHq1AGnsphwzO2bXEz9puhO/Mk9RCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(82740400003)(40460700003)(36860700001)(2906002)(86362001)(41300700001)(54906003)(316002)(70206006)(70586007)(6666004)(478600001)(1076003)(81166007)(6916009)(40480700001)(336012)(426003)(356005)(83380400001)(47076005)(36756003)(5660300002)(2616005)(8676002)(4326008)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:21:07.9721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79de9ac-6951-47bf-d753-08dbd62ecbeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Sung Joon Kim <sungkim@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
To help isolate static screen and
video playback tests, we want to enable
an IPS option to allow IPS only on D3 cycle.

[how]
Add DISABLE_DYNAMIC and DISABLE_ALL
IPS disable flags for user control.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 7 ++++---
 drivers/gpu/drm/amd/display/dc/core/dc.c                 | 4 ++--
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h          | 9 ++++++---
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 25b75c44b0b3..085ac191c94f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -817,7 +817,8 @@ static void dcn35_set_idle_state(struct clk_mgr *clk_mgr_base, bool allow_idle)
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	uint32_t val = dcn35_smu_read_ips_scratch(clk_mgr);
 
-	if (dc->config.disable_ips == 0) {
+	if (dc->config.disable_ips == DMUB_IPS_ENABLE ||
+		dc->config.disable_ips == DMUB_IPS_DISABLE_DYNAMIC) {
 		val |= DMUB_IPS1_ALLOW_MASK;
 		val |= DMUB_IPS2_ALLOW_MASK;
 	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS1) {
@@ -1117,7 +1118,7 @@ void dcn35_clk_mgr_construct(
 		dm_helpers_free_gpu_mem(clk_mgr->base.base.ctx, DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
 				smu_dpm_clks.dpm_clks);
 
-	if (ctx->dc->config.disable_ips == 0) {
+	if (ctx->dc->config.disable_ips != DMUB_IPS_DISABLE_ALL) {
 		bool ips_support = false;
 
 		/*avoid call pmfw at init*/
@@ -1130,7 +1131,7 @@ void dcn35_clk_mgr_construct(
 			ctx->dc->debug.disable_hpo_power_gate = false;
 		} else {
 			/*let's reset the config control flag*/
-			ctx->dc->config.disable_ips = 1; /*pmfw not support it, disable it all*/
+			ctx->dc->config.disable_ips = DMUB_IPS_DISABLE_ALL; /*pmfw not support it, disable it all*/
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 940ceaca8545..de8e5b18a12c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4887,7 +4887,7 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 	if (dc->debug.disable_idle_power_optimizations)
 		return;
 
-	if (dc->caps.ips_support && dc->config.disable_ips)
+	if (dc->caps.ips_support && (dc->config.disable_ips == DMUB_IPS_DISABLE_ALL))
 		return;
 
 	if (dc->clk_mgr != NULL && dc->clk_mgr->funcs->is_smu_present)
@@ -4908,7 +4908,7 @@ bool dc_dmub_is_ips_idle_state(struct dc *dc)
 	if (dc->debug.disable_idle_power_optimizations)
 		return false;
 
-	if (!dc->caps.ips_support || dc->config.disable_ips)
+	if (!dc->caps.ips_support || (dc->config.disable_ips == DMUB_IPS_DISABLE_ALL))
 		return false;
 
 	if (dc->hwss.get_idle_state)
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 648a6e484523..ed4379c04715 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -619,9 +619,12 @@ enum dmub_lvtma_status_bit {
 };
 
 enum dmub_ips_disable_type {
-	DMUB_IPS_DISABLE_IPS1 = 1,
-	DMUB_IPS_DISABLE_IPS2 = 2,
-	DMUB_IPS_DISABLE_IPS2_Z10 = 3,
+	DMUB_IPS_ENABLE = 0,
+	DMUB_IPS_DISABLE_ALL = 1,
+	DMUB_IPS_DISABLE_IPS1 = 2,
+	DMUB_IPS_DISABLE_IPS2 = 3,
+	DMUB_IPS_DISABLE_IPS2_Z10 = 4,
+	DMUB_IPS_DISABLE_DYNAMIC = 5,
 };
 
 #define DMUB_IPS1_ALLOW_MASK 0x00000001
-- 
2.25.1

