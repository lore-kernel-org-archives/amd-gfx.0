Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC88C47422
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C0310F63E;
	Wed, 24 Jan 2024 07:03:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A56CC10F63E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn9w0KpEh53tUY+0yLvuhavrHIwGzi8Inpu7MscLw6w8StIS0KejSYqAtoVgBpaTkBnc66iVT+lSQMUOvFL2jzXfBwEw2qkgaoWVdgSJvJdizaPeVQ4yzpbuEEyiNRdz8w4yCiEtbG53dfBK2p0uTFEKe55FBIC+tOCH9qXUgKMn7onY7SbXOFa9HJjB6ETGc2gtE48gMn40RHjDeb2E5j2+cGPUCalVmov1u7Uxok6SiDvDVHIIapqwFGB50lCaPtSUSA3D9fb4/NrdAYsONKoXQJD3P9+fMXKNYEOlRHxAl7aCPwdKC3yI/ylEJsYPqz0RWu4Qz9nah3iktaRZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb1Zza4D9YQnTNfX6plGFxljnaRGFRrrAF5HCsrP3N8=;
 b=h/SpEuO63s5oKPL7w0ibeu/N30CSzC1LDdDsm2+Hf1rs93ePwTSVmhdNAUID2XeCwzX8ZiCZ4AVH5N59JXOUxC3b8wedgFLj+n5i/v9zTSeDY9yHs/yUkWBvIGox5rJFzERlo38Z2U+YkFEWXco+INBxWpBfx0o5iQAH29cw0tWgUbah968O5dx41LDtIR11q6hTscrjf2cCV2T6MR6R5AUiogsu4ymaNq7xhMo0rckKsLaU4Lc/7kUj6VZ4VyC50jSV86duykvpEyxhb1efVXYDkmlccfMSHVUjfnA0NhPE8Y6p9wyGBQLlGa6hf4HC1O+iTrTVeQlA/Ws7JlBdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb1Zza4D9YQnTNfX6plGFxljnaRGFRrrAF5HCsrP3N8=;
 b=zjnURQEkNy3nPTmY2sVLSdYAbxOnOBLMIjEz8OPEKpNMmCESi3XlLDXad+mLZFfB5CzRlRMR+xcoAJpb/KKxTUNyG3rM2kOSv9DZ0WOHyCMV/qEuTisPZNsWk6Rn5WWrZ3A5oEts7YtWRe0+p3IF2O0xkPYZ5bCvnwMkXbnadJI=
Received: from MW4PR04CA0119.namprd04.prod.outlook.com (2603:10b6:303:83::34)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 07:02:49 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::67) by MW4PR04CA0119.outlook.office365.com
 (2603:10b6:303:83::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:47 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:44 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/22] drm/amd/display: fix invalid reg access on DCN35 FPGA
Date: Wed, 24 Jan 2024 15:01:49 +0800
Message-ID: <20240124070159.1900622-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 8271c257-20f5-4a76-5e2c-08dc1caa7986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtvv1KJOIGX7Xqw2BoxD39rzeNJVfmzV9kA0S3XHWjzS6ztDVqVBpNaKKfpf4GYDKA9BGSc8m3+Gn5b+WZujkxfPDcKBTRodbaPCtlAfrw2nmF3tlVCbctNGYa9YKueZMmWg04B9l+hYHIhcPoOGF6FchMd8AcpJeH24Q/G+It2wV3CGA7IHnclfQ4cc63it93WWpJdigtQJVGbAG9B7twcDbl3pgA6zB5E6I2XBX/amfKSCadfQfvvz+TjIpAg7T5VtDDORl5xNV19qAUc2FgprVmh+mzFez3aaBtt1d7i7rCzoW3a7sJAXI5gyAEppzTBVGEe//TcYKd25Pw5MruIShAZ3L5qBBxbuuzg60h+5fj8GYheigpJTzqJB9fezLLDitKIB9P/Ak1V3z0O58J1i6+na5yDC5/twtkdJNlwZGBP9chVtdy7/hSiJLl/cLwlQAOWyXBj+iLMj0zPTgXNstprWZzTgvxlocLHqXM8RSMsg1D10m4IAKXrdOBFUZGEiAbiyf1A4SJdABzf5sZR+orc4WRSjQZAwrurs1eY2/5o+Zo0KlZATt7l6B/IpsnzAUyIQIWOUGtwA7fmeht/VF12O7pzqXNM0knQ+r+mUGCOl7BDR0PjGJKqRK3QNUPX6VlQFMcvOVrcc00r6D9Q0RKKzh43K7FJpehKi6D0B6TqCUJpQVIaqxbLRKUGTlN6Drr2GdSqwYQpZmNuBVaaABcLn25dYs22hIdk6LpL8SK/LztYBdr4cjPn7J1ilqixvM/IzDs/+fBhySR3QgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(36860700001)(4326008)(8936002)(7696005)(8676002)(6916009)(478600001)(336012)(2616005)(70586007)(70206006)(54906003)(86362001)(316002)(1076003)(5660300002)(2906002)(26005)(36756003)(426003)(41300700001)(47076005)(40480700001)(356005)(40460700003)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:48.7228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8271c257-20f5-4a76-5e2c-08dc1caa7986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Eric Yang <eric.yang@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 Sung joon Kim <sungjoon.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <eric.yang@amd.com>

[Why]
Unguarded SMU and CLK IP access cause issue on FPGA

[How]
Guard them for FPGA environment

Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Eric Yang <eric.yang@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 12 ++++++++----
 .../drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 3d1a60cc2908..e1b035380f6a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -408,13 +408,12 @@ static void dcn35_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 		struct clk_mgr_dcn35 *clk_mgr)
 {
 }
-void dcn35_init_clocks(struct clk_mgr *clk_mgr)
+
+static void init_clk_states(struct clk_mgr *clk_mgr)
 {
 	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
-
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 
-	// Assumption is that boot state always supports pstate
 	clk_mgr->clks.dtbclk_en = true;
 	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
 	clk_mgr->clks.p_state_change_support = true;
@@ -422,6 +421,11 @@ void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 	clk_mgr->clks.pwr_state = DCN_PWR_STATE_UNKNOWN;
 	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
 }
+
+void dcn35_init_clocks(struct clk_mgr *clk_mgr)
+{
+	init_clk_states(clk_mgr);
+}
 static struct clk_bw_params dcn35_bw_params = {
 	.vram_type = Ddr4MemType,
 	.num_channels = 1,
@@ -883,7 +887,7 @@ static uint32_t dcn35_get_idle_state(struct clk_mgr *clk_mgr_base)
 
 static void dcn35_init_clocks_fpga(struct clk_mgr *clk_mgr)
 {
-	dcn35_init_clocks(clk_mgr);
+	init_clk_states(clk_mgr);
 
 /* TODO: Implement the functions and remove the ifndef guard */
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index 6d4a1ffab5ed..a07f7e685d28 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -447,6 +447,9 @@ void dcn35_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable)
 
 void dcn35_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable)
 {
+	if (!clk_mgr->smu_present)
+		return;
+
 	dcn35_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_EnableTmdp48MHzRefclkPwrDown,
@@ -458,6 +461,9 @@ int dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr)
 {
 	int retv;
 
+	if (!clk_mgr->smu_present)
+		return 0;
+
 	retv = dcn35_smu_send_msg_with_param(
 		clk_mgr,
 		VBIOSSMC_MSG_DispPsrExit,
@@ -470,6 +476,9 @@ int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr)
 {
 	int retv;
 
+	if (!clk_mgr->smu_present)
+		return 0;
+
 	retv = dcn35_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_QueryIPS2Support,
@@ -481,6 +490,9 @@ int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr)
 
 void dcn35_smu_write_ips_scratch(struct clk_mgr_internal *clk_mgr, uint32_t param)
 {
+	if (!clk_mgr->smu_present)
+		return;
+
 	REG_WRITE(MP1_SMN_C2PMSG_71, param);
 	//smu_print("%s: write_ips_scratch = %x\n", __func__, param);
 }
@@ -489,6 +501,9 @@ uint32_t dcn35_smu_read_ips_scratch(struct clk_mgr_internal *clk_mgr)
 {
 	uint32_t retv;
 
+	if (!clk_mgr->smu_present)
+		return 0;
+
 	retv = REG_READ(MP1_SMN_C2PMSG_71);
 	//smu_print("%s: dcn35_smu_read_ips_scratch = %x\n",  __func__, retv);
 	return retv;
-- 
2.34.1

