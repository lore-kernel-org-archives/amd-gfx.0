Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D25BC369BD
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 15:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212CF10E7D5;
	Tue, 15 Apr 2025 15:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v2mIcDFo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D54C10E7D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 15:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YH4e4HonQpjuELxbGM6r+DWbksjlol/NJpIFCN88Oo9Dfi3c2s5Af1Fa3qs7cYaIVPETn2HNclgGm14ZGcql58jmtTMtEE7r8DBXdJrnxsPoM5OEbtLqKTDIWND25kO/RK7YUn6fq1UsGTfjZw+xgSWv//Gn2giwukm+Xdv59uzuGXFrG2BWj5A6KR4XoHF7VSzEZ8It1UAmkHOTBSzx10FXON3tqcjSh+USO13l4Gu3Ma9b0IGlZkByPFmggnZLXgPVVFNt1LgAMzkQ6fPdg9GJL83R0Fj/jGI+pi+z2+94Haayr4Ren3fWmkorcT4VADF99t9HSUn4O33+kEHFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1weCq3ju68QDjh4J5/j770cyONJEcwKdE5s/PlXXB1g=;
 b=n9jjSu9Xm2nW4LXa7Ib8xTJ9T0bDsaFzEscHXTMfEaMX0j63elGatXZxuLL+Qb8n+B8t1f4cGHSNStMexf9lYkO7DMLeJQ4vy2U9ze7tSbNtGFCFzy1bGjztZ3t8UA09l2SpEbwHg5Dr4D51GtMfEGZuPV6NFTrFK16qVCSWVm9z9TcRLOaJ2ldqpTfprF4r2GXYUBlnJ9vS4wbh824+AMvwT5jp2iJo9aO//1jVOK9k1nziy9E6v9ekwoOe4cKSz4eyBiHl7Zaq9YAgiY4bLJ4nNjhEtY81bv7QA87IWrCOvAsJ5lK9E07RKyI0Z3JBPKEsB3juM8Fo3mevCaQmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1weCq3ju68QDjh4J5/j770cyONJEcwKdE5s/PlXXB1g=;
 b=v2mIcDFozBD3RuRFT0xOc49s7U43Yg9dQkccGqj2s34wdNzqvEj8LTshWrfzRU2KDqOhtGC5SpUmEFpru/tU7hbj+9qsOzWM9q9N69L13yUOsJFmznJ35VVeVLdYsrSTDEhh8vkCUt4bUHmIBaHHc4e+r/sxlM/s1sMypeLKpIk=
Received: from SN6PR01CA0036.prod.exchangelabs.com (2603:10b6:805:b6::49) by
 CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Tue, 15 Apr 2025 15:00:03 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::9a) by SN6PR01CA0036.outlook.office365.com
 (2603:10b6:805:b6::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Tue,
 15 Apr 2025 15:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 15:00:02 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:59 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 17/22] drm/amd/display: Init DCN35 clocks from pre-os HW values
Date: Tue, 15 Apr 2025 10:59:03 -0400
Message-ID: <20250415145908.3790253-18-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 3314825e-72b4-4ec6-91c3-08dd7c2e3360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EakW5r/LTSyI7tmG/ktCiyWhfaYb1GREBvnkbfPgvn8VrEo41tzQp2xAc+kd?=
 =?us-ascii?Q?EXYyOhsBpHIeINyq1OJqI34SRqzNvSe+cGCIc2cr5NEzg0k4vgzeUorzqeQ8?=
 =?us-ascii?Q?SF5Qdv09BCeLrKcoyFLC3/6NeaYH4otg28KB115/Xv5PLZYfJ9b12N7YXL2R?=
 =?us-ascii?Q?aGpSusQPREgb/gt4w7GqKWrnUvcTAzgP+hq4HywiCK7cOYqxApLffgtV0TIb?=
 =?us-ascii?Q?fvYZA+1ehqs1mfgniqb464rOHEJnRD0sRbHONTKeBj5FpwtuWbdDlKmuwA8w?=
 =?us-ascii?Q?tp4RbEcypmnyqGNOVtZqqep8yL999ij3OOIRbnIird3w8WuW5jARGqfPL2F7?=
 =?us-ascii?Q?qe7xqehCULqzl7FG6UivNbwsJ+uvWdOIof5G3wQESHPMg5IydDWlovSpJ0VO?=
 =?us-ascii?Q?O6FMGFYAVLvsLN3c/e/eJhoqrmABAklQQJEePI5RtK/4lqNO2mBtF1IDiHzf?=
 =?us-ascii?Q?U34/kNbxZEb7Uw+5zYimWDLJXl84cG6TMn8fjWdDwaJkIQuk0e5ZzZZKflGw?=
 =?us-ascii?Q?Cm4Vpp9X/Xub8KCeFls4uPAwcw6/fTdbcqTvQSvZHJQBB2e6bJA7lJ44xDev?=
 =?us-ascii?Q?v0zcWUcI+FEyZgKNOl/1q9H3EawwoKxWcedTQovvvwzMygSP+R4h4nkPom+O?=
 =?us-ascii?Q?U0ufnHldSRt5/r+Djq6cCTzjQteIMwmSxjyMunR78Kio1VuoOM/SqxNrOjn8?=
 =?us-ascii?Q?kmwPQBNq9c1ULrruRdqwIN+sIkikpe+OHdVz2d4jPA6x29YpnAscozAbh5Fh?=
 =?us-ascii?Q?YD/Aw+prSllekDLmKVXkcRZVFnoW/QcIU/BKyzVrTyFMMTfepxVH1xVeTqfa?=
 =?us-ascii?Q?VCbzekeMtlOgUSXRXmN0liGUZu3vDxd/ZnrhtS3iua40NZAJRQMfRf1aq/4Y?=
 =?us-ascii?Q?7xHl1jl044VBun7ChIIV8DaSxoKfXLb253YQW1bwGVfsqKF9M7EGvxunwuPU?=
 =?us-ascii?Q?xwYcKq1tnXyHNjlYJ2Rxut36DKI0YIdAEOaxInRoguQpzD0P8+1O4+ZnzQt7?=
 =?us-ascii?Q?X6lO8UHx8qidNLJn/rzmf+f8ZWNsi2vF+57Ft2K2T/XU6/YM2dOVG8kVUm/z?=
 =?us-ascii?Q?CM/JrxKNqsO6+yh0iAzoQzliCacuhqtFO0aJVdq3y7wYBYlqfx3Lyoy6EWdh?=
 =?us-ascii?Q?B+hFEzKCEqj8yBtBbUEjdZXUfaCPI9GyJe6rW8I7J5A6Ns7WUl+vvXQNKiYs?=
 =?us-ascii?Q?2bAGL1e5RM+ODYTqudXMsLpCrm235qda8mT7uY1H5QomD6G61BTbtUpHuezv?=
 =?us-ascii?Q?wvHvXKqbGWRT+UnIj2tP9X+XwAlE/kXaaW+qr6VVWx3InIiriChoy+OGdP0t?=
 =?us-ascii?Q?NUdRFOgL4XluSKR3W4MAhdrv1RMeg7IQOuVeIVP0epAHnO3XLSIAkN+nnViF?=
 =?us-ascii?Q?GqlaCX7KDzPTp4A+mADpe48iqY8hAdK2oAICkfjHO+ldHKxOJPnq0cWUyl3e?=
 =?us-ascii?Q?UDBTQFzdnt0/vP1JCJhf+VrUOVbXUlQdMuXf/Y/YcA5QNT4FQW/zpXkokx19?=
 =?us-ascii?Q?dw3yuoklN2Hi9stc6PIuQwuUOvHNssSyXzpT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 15:00:02.8160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3314825e-72b4-4ec6-91c3-08dd7c2e3360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

We did not initialize dc clocks with boot-time hw values during init.
This lead to incorrect clock values in dc, causing `dcn35_update_clocks`
to make incorrect updates.

DCN35+ also allows 0 dtbclk -- current dm_init policy disallows it.

[How]

Correctly initialize DC with pre-os clk values from HW.
Allow 0 dtbclk in dm_init.
s/dump/save/ as that accurately reflects the purpose of the functions.

Fixes: 8774029f76b9 ("drm/amd/display: Add DCN35 CLK_MGR")

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 121 +++++++++++++++++-
 2 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 236e73115812..fc9fb7500254 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2120,6 +2120,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.flags.disable_ips_in_vpb = 0;
 
+	/* DCN35 and above supports dtb clk disable */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 5, 0))
+		init_data.flags.allow_0_dtb_clk = true;
+
 	/* Enable DWB for tested platforms only */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
 		init_data.num_virtual_links = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index bb1ac12a2b09..0e638bc6bf77 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -587,9 +587,118 @@ bool dcn35_are_clock_states_equal(struct dc_clocks *a,
 	return true;
 }
 
-static void dcn35_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
+static void dcn35_save_clk_registers_internal(struct dcn35_clk_internal *internal, struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	// read dtbclk
+	internal->CLK1_CLK4_CURRENT_CNT = REG_READ(CLK1_CLK4_CURRENT_CNT);
+	internal->CLK1_CLK4_BYPASS_CNTL = REG_READ(CLK1_CLK4_BYPASS_CNTL);
+
+	// read dcfclk
+	internal->CLK1_CLK3_CURRENT_CNT = REG_READ(CLK1_CLK3_CURRENT_CNT);
+	internal->CLK1_CLK3_BYPASS_CNTL = REG_READ(CLK1_CLK3_BYPASS_CNTL);
+
+	// read dcf deep sleep divider
+	internal->CLK1_CLK3_DS_CNTL = REG_READ(CLK1_CLK3_DS_CNTL);
+	internal->CLK1_CLK3_ALLOW_DS = REG_READ(CLK1_CLK3_ALLOW_DS);
+
+	// read dppclk
+	internal->CLK1_CLK1_CURRENT_CNT = REG_READ(CLK1_CLK1_CURRENT_CNT);
+	internal->CLK1_CLK1_BYPASS_CNTL = REG_READ(CLK1_CLK1_BYPASS_CNTL);
+
+	// read dprefclk
+	internal->CLK1_CLK2_CURRENT_CNT = REG_READ(CLK1_CLK2_CURRENT_CNT);
+	internal->CLK1_CLK2_BYPASS_CNTL = REG_READ(CLK1_CLK2_BYPASS_CNTL);
+
+	// read dispclk
+	internal->CLK1_CLK0_CURRENT_CNT = REG_READ(CLK1_CLK0_CURRENT_CNT);
+	internal->CLK1_CLK0_BYPASS_CNTL = REG_READ(CLK1_CLK0_BYPASS_CNTL);
+}
+
+static void dcn35_save_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr_dcn35 *clk_mgr)
 {
+	struct dcn35_clk_internal internal = {0};
+	char *bypass_clks[5] = {"0x0 DFS", "0x1 REFCLK", "0x2 ERROR", "0x3 400 FCH", "0x4 600 FCH"};
+
+	dcn35_save_clk_registers_internal(&internal, &clk_mgr->base.base);
+
+	regs_and_bypass->dcfclk = internal.CLK1_CLK3_CURRENT_CNT / 10;
+	regs_and_bypass->dcf_deep_sleep_divider = internal.CLK1_CLK3_DS_CNTL / 10;
+	regs_and_bypass->dcf_deep_sleep_allow = internal.CLK1_CLK3_ALLOW_DS;
+	regs_and_bypass->dprefclk = internal.CLK1_CLK2_CURRENT_CNT / 10;
+	regs_and_bypass->dispclk = internal.CLK1_CLK0_CURRENT_CNT / 10;
+	regs_and_bypass->dppclk = internal.CLK1_CLK1_CURRENT_CNT / 10;
+	regs_and_bypass->dtbclk = internal.CLK1_CLK4_CURRENT_CNT / 10;
+
+	regs_and_bypass->dppclk_bypass = internal.CLK1_CLK1_BYPASS_CNTL & 0x0007;
+	if (regs_and_bypass->dppclk_bypass < 0 || regs_and_bypass->dppclk_bypass > 4)
+		regs_and_bypass->dppclk_bypass = 0;
+	regs_and_bypass->dcfclk_bypass = internal.CLK1_CLK3_BYPASS_CNTL & 0x0007;
+	if (regs_and_bypass->dcfclk_bypass < 0 || regs_and_bypass->dcfclk_bypass > 4)
+		regs_and_bypass->dcfclk_bypass = 0;
+	regs_and_bypass->dispclk_bypass = internal.CLK1_CLK0_BYPASS_CNTL & 0x0007;
+	if (regs_and_bypass->dispclk_bypass < 0 || regs_and_bypass->dispclk_bypass > 4)
+		regs_and_bypass->dispclk_bypass = 0;
+	regs_and_bypass->dprefclk_bypass = internal.CLK1_CLK2_BYPASS_CNTL & 0x0007;
+	if (regs_and_bypass->dprefclk_bypass < 0 || regs_and_bypass->dprefclk_bypass > 4)
+		regs_and_bypass->dprefclk_bypass = 0;
+
+	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
+		DC_LOG_SMU("clk_type,clk_value,deepsleep_cntl,deepsleep_allow,bypass\n");
+
+		DC_LOG_SMU("dcfclk,%d,%d,%d,%s\n",
+				   regs_and_bypass->dcfclk,
+				   regs_and_bypass->dcf_deep_sleep_divider,
+				   regs_and_bypass->dcf_deep_sleep_allow,
+				   bypass_clks[(int) regs_and_bypass->dcfclk_bypass]);
+
+		DC_LOG_SMU("dprefclk,%d,N/A,N/A,%s\n",
+			regs_and_bypass->dprefclk,
+			bypass_clks[(int) regs_and_bypass->dprefclk_bypass]);
+
+		DC_LOG_SMU("dispclk,%d,N/A,N/A,%s\n",
+			regs_and_bypass->dispclk,
+			bypass_clks[(int) regs_and_bypass->dispclk_bypass]);
+
+		// REGISTER VALUES
+		DC_LOG_SMU("reg_name,value,clk_type");
+
+		DC_LOG_SMU("CLK1_CLK3_CURRENT_CNT,%d,dcfclk",
+				internal.CLK1_CLK3_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK1_CLK4_CURRENT_CNT,%d,dtbclk",
+					internal.CLK1_CLK4_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK1_CLK3_DS_CNTL,%d,dcf_deep_sleep_divider",
+					internal.CLK1_CLK3_DS_CNTL);
+
+		DC_LOG_SMU("CLK1_CLK3_ALLOW_DS,%d,dcf_deep_sleep_allow",
+					internal.CLK1_CLK3_ALLOW_DS);
+
+		DC_LOG_SMU("CLK1_CLK2_CURRENT_CNT,%d,dprefclk",
+					internal.CLK1_CLK2_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK1_CLK0_CURRENT_CNT,%d,dispclk",
+					internal.CLK1_CLK0_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK1_CLK1_CURRENT_CNT,%d,dppclk",
+					internal.CLK1_CLK1_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK1_CLK3_BYPASS_CNTL,%d,dcfclk_bypass",
+					internal.CLK1_CLK3_BYPASS_CNTL);
+
+		DC_LOG_SMU("CLK1_CLK2_BYPASS_CNTL,%d,dprefclk_bypass",
+					internal.CLK1_CLK2_BYPASS_CNTL);
+
+		DC_LOG_SMU("CLK1_CLK0_BYPASS_CNTL,%d,dispclk_bypass",
+					internal.CLK1_CLK0_BYPASS_CNTL);
+
+		DC_LOG_SMU("CLK1_CLK1_BYPASS_CNTL,%d,dppclk_bypass",
+					internal.CLK1_CLK1_BYPASS_CNTL);
+
+	}
 }
 
 static bool dcn35_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
@@ -623,6 +732,7 @@ static void init_clk_states(struct clk_mgr *clk_mgr)
 void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 {
 	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
+	struct clk_mgr_dcn35 *clk_mgr_dcn35 = TO_CLK_MGR_DCN35(clk_mgr_int);
 
 	init_clk_states(clk_mgr);
 
@@ -633,6 +743,13 @@ void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 	else
 		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
 
+	dcn35_save_clk_registers(&clk_mgr->boot_snapshot, clk_mgr_dcn35);
+
+	clk_mgr->clks.ref_dtbclk_khz =  clk_mgr->boot_snapshot.dtbclk * 10;
+	if (clk_mgr->boot_snapshot.dtbclk > 59000) {
+		/*dtbclk enabled based on */
+		clk_mgr->clks.dtbclk_en = true;
+	}
 }
 static struct clk_bw_params dcn35_bw_params = {
 	.vram_type = Ddr4MemType,
@@ -1323,7 +1440,7 @@ void dcn35_clk_mgr_construct(
 		dcn35_bw_params.wm_table = ddr5_wm_table;
 	}
 	/* Saved clocks configured at boot for debug purposes */
-	dcn35_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
+	dcn35_save_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
 
 	clk_mgr->base.base.dprefclk_khz = dcn35_smu_get_dprefclk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
-- 
2.34.1

