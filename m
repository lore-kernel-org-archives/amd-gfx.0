Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7413AC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D6D10E880;
	Fri,  1 Dec 2023 13:29:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F04A110E8A5
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSyv6zCMzc3+jkngTvXkHrN7p+j4NEgapa3v3W85GR19YgRWtObuvqntf9DI3DTGVUDgXgStvoK9O+kmw9+l9iQOIuvucH1Zrq2kj2hSEqJtB1kJfIOORA7oZOsWa2a41ALZ7FGP6aHyZnQi2qqcsjo8UIJ9H9BAIigt2PQrwNZBcHa+nCSNeaUShWUie2rnZjS/P+miCC8YcnrVOyiaiG/JbNb2Xx85q+weXJzOE+hi9tYDyxBD29zLXjYiWAsq/W2yiUAFsTHsIjmAaWusL/8A4CCZbAg4M8Ddm5v0zUYrGhMlnkDLsYvY8vOETqy3Zv7nl0gPvOdTcNzQRcTgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9B9IEUzBdnk58M2WxV7eEaWlyChSTXcRk/XvXGGgOo=;
 b=HPr2Dd1zZP/UuiwS2gKCIpjScVzW4aOQmivvEOjBhuQ9UEOchTP1/4o38rY4H5N4ajE1Of3AnAq2P+3e9Llc7+WStUPYzaRk3tKA0e3jRhKlMN04AmPYWsnHzi6SYMX01QIPyUzVP4tTMvItv8AaQiJClcyMgO4IX0S/KA5IiD2nNGla+p1SRf7cWHw9xwMw1ePAwE0S+gKiH307aGBE+RDZBZJG4rTBbzowKisc5xSKbsy9q7ntzPBmlQi0XtclkGkTShs4swyROv1/42KXqSyg8XlPI/ziAWew+gPaPlosPSKIYkiBTad6bZu/W0fGv5VK2hnpdXclw+mWNcvAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9B9IEUzBdnk58M2WxV7eEaWlyChSTXcRk/XvXGGgOo=;
 b=M2dLDcIrBEZoK2+kNyEX37yBjJTIs2zv946w4hOwkZYGLhAwxnw4y2b0a4cEYU1+J/yj5KGDS+nelVW1WtXFNUWJD/WWnEpuG94umRMMYVLiBsP/S1EuwO9U93mkBGyxC1R1FrKff7RVNP4UgxRTXLakCiGT0EpgDRFqWUqxTps=
Received: from DS0PR17CA0005.namprd17.prod.outlook.com (2603:10b6:8:191::6) by
 BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:40 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::81) by DS0PR17CA0005.outlook.office365.com
 (2603:10b6:8:191::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:37 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/47] drm/amd/display: add MPC MCM 1D LUT clock gating
 programming
Date: Fri, 1 Dec 2023 06:25:17 -0700
Message-ID: <20231201132731.2354141-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|BL0PR12MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 165630ea-07f6-4c7c-cd08-08dbf2716e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n84jqgO8wYbtInl96CK69VbCYTxA175ltWAw8XNZmYt0uzU4d0d30F30OYkgXvTqcC5BHJsB1L0/0HRwjrGcuQTa7Tm+8OvhjmCiW4OQrJV+U11odTujzVk4adx0pF9+QRMjL0EIRVJin+8xbWEZct2x1TyCISKdnqr4STiWS2vAxIS1i9tMPqAY/txERl/E1QdP7P7or/MEv9ZrOjCNn7YKoq9HzKweE1pA4DfDqNnQ2uNOfcUwb4PIOwKv0Z4t5roDIvZJEBBhO/S5dwe2Ti9e2P22HW6D8CKwjp7AH6xONT179EWsVNHw+hk+bzlKVgBU/bpa/TiqzTqwh3fo98g0rMKgUSR7McUODcAaiVmFLbr2J5lJEHApYe7RO3pHvuscd1C5GN6gLdngi/Db9U1N32asfWD+2uZEga+Tr2nLzw+frMEm5JqZ4JPem71be6KEyztI2HoSXXWZ9E5BfhvDpNkGkaGwAKiubCl6cy9Vm5EtNcdr0F5Q96dIdYUZ6bok9/9pjl3kQPyGlxtt5SMJGwTikgHBYs6p4lfEmSrBLMTk4g7lr/I0HMYNV1gY00tKaOwzNiHEVV+lSWEr5PJ4fyxpB7HCin0rwpc3FTNDRPBeIy4ZIhAwpzf7/ai0dZTP19z8y6i+p6rGlsSNEJvpTPNcuhvnBHP5oRaN+yYEiu0KeIkQdVzoNjC1nLkppb7l0d1d43yc53QEJaXoH6WDbQUT0uVMzwSL3+jVGXDwwYbfM8B2mUqJ9dXZrDYuOvtj201i8X0/lTughHxS1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(1076003)(5660300002)(2906002)(8676002)(316002)(6916009)(54906003)(4326008)(70586007)(70206006)(8936002)(40480700001)(16526019)(26005)(41300700001)(6666004)(478600001)(2616005)(83380400001)(426003)(336012)(40460700003)(47076005)(36860700001)(82740400003)(356005)(81166007)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:39.7832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 165630ea-07f6-4c7c-cd08-08dbf2716e49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
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
Cc: stylon.wang@amd.com, Yihan Zhu <yihan.zhu@amd.com>, jerry.zuo@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Chris Park <chris.park@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yihan Zhu <yihan.zhu@amd.com>

Missing clock gating programming blocks memory power on from boot up.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Yihan Zhu <yihan.zhu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c               | 3 ++-
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
index 994b21ed272f..e789e654c387 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
@@ -71,12 +71,13 @@ void mpc32_power_on_blnd_lut(
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
+	REG_SET(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], 0, MPCC_MCM_1DLUT_MEM_PWR_DIS, power_on);
+
 	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.cm) {
 		if (power_on) {
 			REG_UPDATE(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_1DLUT_MEM_PWR_FORCE, 0);
 			REG_WAIT(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_1DLUT_MEM_PWR_STATE, 0, 1, 5);
 		} else if (!mpc->ctx->dc->debug.disable_mem_low_power) {
-			ASSERT(false);
 			/* TODO: change to mpc
 			 *  dpp_base->ctx->dc->optimized_required = true;
 			 *  dpp_base->deferred_reg_writes.bits.disable_blnd_lut = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 1a0ed1c7e2d4..13324422ff50 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -736,7 +736,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.i2c = true,
 			.dmcu = false, // This is previously known to cause hang on S3 cycles if enabled
 			.dscl = true,
-			.cm = false,
+			.cm = true,
 			.mpc = true,
 			.optc = true,
 			.vpg = true,
-- 
2.42.0

