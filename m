Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF778C00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D8FBAF69D;
	Sat, 13 Aug 2022 02:13:26 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77016ADA78
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CS4UwKf3CpLwrlicTPlmhSUarirpf2XwOgd0+OISUHDtnoFM+gszLQbp0bL9t7tbdUNVq/5yybwty2zYOAaGzmdazjy5C/AZ0YHjIfDOCYgo4gcgwNQ3vgWDXqshIzXjKxtO0asp/QK/98BXzx9l1iCxr/f/KdlAD6jjq9cvO806/JO2HIrUyJ2eO2MiYGxI6bDhufVy/mCXdbjj0KQOWQCWyOjTOppxk+ohej3HjYcLKCXsdp6SbQM9hJOhz2X6zq70lKDTYCf8IcmGmyqIo4EitMzZCDAqxMBPqAzHXKkT8pV4Tl8J5roYoZ66tqbE8+qG1itlq2FVzBcziZ2c/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiNLNeHnaz4R42iFZWaJGs+e6h7rBuXyCMtgGXNGcAk=;
 b=FMb5SOuRLJwuHpRUGrBxNFiWL6VdHFix8sWL3HMY6Si/fxqAnUBsfDbaNaOhxwbKPjm7H1SCWoBDEo5qXYS9fg2e1+7PVxwXjfcM+HXEmA5zxkLXWye/F49UWnVqG3Wb8RSUkvTJuNIrxp+X752HVZpLzu+hbaAN6ZnG+Td4cfOUMirAn4mHXc8k+hPoqiDC47RT9sYSqXfSdCmw8fO22citR1J0UG6EAzSKrZmSSWHX7sr6Eb23It8kKTW7U5M+co/4+UL+rM+b6PytOstLUath4YIckPY1+ADY2PXp8OwaAc4m6oweFeRNRgYsjK2yKcDi7s6m40v0sD8q1UtqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiNLNeHnaz4R42iFZWaJGs+e6h7rBuXyCMtgGXNGcAk=;
 b=R9KQzJEr7roMv2otPNuPnEY8CLAq/RfLzKGhk1ZeVv/tuVe6S+OYHB86vTacGjO9fJ/VxekwIL5u5atzodZn1fppquwudt9cki1hjoDX0e7uVZ4L+zefP7ByDtM5a02LAW4IYQMTOREGvUgj2DiIbY+/k/g7+HqkZ0znJrLNj9o=
Received: from BN9P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::17)
 by MN2PR12MB3855.namprd12.prod.outlook.com (2603:10b6:208:167::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Sat, 13 Aug
 2022 02:12:58 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::fa) by BN9P220CA0012.outlook.office365.com
 (2603:10b6:408:13e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17 via Frontend
 Transport; Sat, 13 Aug 2022 02:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:12:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:12:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 19:12:57 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:12:53
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amd/display: Add debug parameter to retain default
 clock table
Date: Sat, 13 Aug 2022 06:12:15 +0800
Message-ID: <20220812221222.1700948-8-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 999877b2-4c1e-4320-8a02-08da7cd157a2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3855:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+nYm+qC0fUBASpvPkCzLtiOCPZsMHEU4Zr1VS7XDLwIBAxc/lNS6O+yeoVpgI4Wk+s0mrxEUfT+D7CJolkKtYTtArr8Npof5uVkb4JDjUfgGBZ0CMoVNhMS2mLIgZxhiUEQ9YSTyPWlrzG7M0Ttrc/DJ1rJ0RziesBmBH0JgEkFPjepQ+A2AmL48iGpOJJhs20gVbTYmoC1yhDg2AZO5MBencvW3ZCQ0TUS6EDhGItIDFpjS6LHlEmuZi3QmLdrQGDhSMOQXVLsZCVOgHUrwOLjwML7lqoZlY+7hW+IxMeDK/1K4hn7lMWTQnNWfzq6B8t9bBbK/n94mOv46n4nF83axn3rcKmMY5/BKq4vwYrk1euSSWj6vWmwtO71FMqAHYeE/j/4E51Qkne04TXOdRZnaj1s7YxLpjKcHwka0Pl6OD7d66EwolVkHak4K0izUMYLwWbXspRqzBRVAGYpcSgJMP/dOBKomH9yDDdCVnfBL96R1uroov8AJiYxRDOAD2YzOJ6L0oPEsAZ3A1pnpi/pCukU3pWCSrWww9Aq3GLfEbakuEuxWcnGa9Q2ECAQkSSihpelrH5zTkf6i0YtUFw2bOQHTa+gaDAOZzI0EoX38hZ2ALgPVMJsXALR5QxO0/U4xhiUzq4d9vQpxc5caCbl/NG28IsUdxR4s23qtRwvkru0EHn7O53ON+hWGPuKK4Hsy/WvKbfMpdI3fz9LUsEhlYN0/QTFlKMkBkSzBs6+MTmfNvVP6vOYv/foBm3m5CqQtGPKStul2HQDAiK32bC7M8/JP4qjvZeFMIumcPrZ2z2YxaCusqW6pvvXu8uK6NZTkKYdggZMc8lzXL3h7oTIcJrwQl25MhA4isvF11M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(40470700004)(36840700001)(82740400003)(86362001)(186003)(6666004)(41300700001)(81166007)(26005)(2616005)(336012)(7696005)(356005)(1076003)(47076005)(426003)(36860700001)(4326008)(8676002)(83380400001)(40480700001)(82310400005)(36756003)(40460700003)(5660300002)(2906002)(54906003)(6916009)(70206006)(70586007)(8936002)(316002)(478600001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:12:58.6000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999877b2-4c1e-4320-8a02-08da7cd157a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3855
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
Cc: stylon.wang@amd.com, Daniel Miess <Daniel.Miess@amd.com>,
 Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <Daniel.Miess@amd.com>

[Why]
Need a way to retain default clock table to aid
the investigation into why 8k@30 display not
lighting up on dcn314

[How]
Use flag to prevent execution of bw_params helper
function and function for updating bw_bounding_box

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Daniel Miess <Daniel.Miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dc.h                            | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c         | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 7af19823a29d..c74f2d5bbbc5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -719,7 +719,7 @@ void dcn314_clk_mgr_construct(
 	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
 		dcn314_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
 
-		if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
+		if (ctx->dc_bios && ctx->dc_bios->integrated_info && ctx->dc->config.use_default_clock_table == false) {
 			dcn314_clk_mgr_helper_populate_bw_params(
 					&clk_mgr->base,
 					ctx->dc_bios->integrated_info,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5de2c445ac31..cc2e9b572b87 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -404,6 +404,7 @@ struct dc_config {
 	bool use_pipe_ctx_sync_logic;
 	bool ignore_dpref_ss;
 	bool enable_mipi_converter_optimization;
+	bool use_default_clock_table;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index c80307a6af1b..34a5d0f87b5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -189,7 +189,7 @@ void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 	dc_assert_fp_enabled();
 
 	// Default clock levels are used for diags, which may lead to overclocking.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
+	if (!IS_DIAG_DC(dc->ctx->dce_environment) && dc->config.use_default_clock_table == false) {
 
 		dcn3_14_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
 		dcn3_14_ip.max_num_dpp = dc->res_pool->pipe_count;
-- 
2.25.1

