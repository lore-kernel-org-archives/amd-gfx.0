Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E68C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C41110F466;
	Fri, 17 Jun 2022 19:36:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D66710F4A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvCS8ZvRyIXAgYK7i2+9LhwILPTnWh5AJt4yVCKJ7xf4s2fGCr/+fdTX/1aMFvgj/2drSUGvv/p4Gd4+xw1RYkNNutxg4o0Ag7wIz6PwxSu1Uz6wGlzX03xAS1tdbbY1Q9/s6EjB5bZcc9nalWFNc3bOKDl6DGce4Md04upUmSCDgtOwC28hBNofMTfMg4OyuzgpPTrWHpPqc1+8qxaLDQXDuQ4xWgE+J0YgF1cGnSYdMeHpsta3/ifoQ8cXcKvhaVVRKtJcA1y3jvi/0rqWerYvylYO087rDZqCHFbP1RD4O05cDuWbN8oiZWZd020u3UbzxnyP7lZ18nTScDkLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDBtuW4ufXQdmbAKK/lWIfWmi21VwYIiFuwuQWMkslY=;
 b=Gy8jUPtEby7pFgNF9+sBEO4qE030CNMYamntiu7ePKKYV7LnYRA42HUbF8VFsV/VZmorNtMGn/ObCLbiWnQrqlrJ3RbLw+5u+AKP2qDnhKAAIWCUN9svTUrNzSmaRE9zh4gDbBH3Qeo4pOZ5OJxz50rnUr5RLhEEr0y2FhMjVOZeIT2X6xuHcfxHKaWpo3YFvdNboMxjBbi5Nj4kC1jIUKxc5SRKYQwT8w0+Bv5eFaVUxOxavMYp+EKSBOQ+ZJCJsNb99xymN4dD8ddD8pejk3XmEY4ANVZWEO/ArL1ezm9Zp4IL8Fx34qQNm3Zp3Wk/7QFZqKc8QCpCVSyz8bobyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDBtuW4ufXQdmbAKK/lWIfWmi21VwYIiFuwuQWMkslY=;
 b=gaubkjqI+DJZ/lpWZtCXA3zk3y+3L2ptEa8JHTUcqOuBYgQjZAjJ0GrG1yoU28Pfxr+Ip33t0GS63mDMqU6AwP/YtOk0feduQ8IIIORG45BLkuSPIcBnOdwQuURJnmaYZswZ6e4Il0WLNGtZHtrqt4oRHiYxXKVXIivo+LcsAWY=
Received: from BN9PR03CA0776.namprd03.prod.outlook.com (2603:10b6:408:13a::31)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 19:36:08 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::5c) by BN9PR03CA0776.outlook.office365.com
 (2603:10b6:408:13a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
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
 2022 14:36:02 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/31] drm/amd/display: Get VCO frequency from registers
Date: Fri, 17 Jun 2022 15:35:08 -0400
Message-ID: <20220617193512.3471076-28-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b47eb77-fe90-46b8-2c4f-08da5098a05b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5923:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB59230C14EBF322F544B357D598AF9@BL1PR12MB5923.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLGrTh8BFELkM/wdr8SMOdbbD7cteFbYGtw0pcrKqRD3NbsHEgEP2sFlZ6Fuc3/D228y8crJicF+RjN2LEdJsPYQyEqLLXxiG74ZWp0v7+Y569WMiieECXQArE6eqsgBr7NbB2ghTaKXUbhUlRWmWqRGNllI6bbnyX8xjQ4GsUxiKyl3mczDUm9j9Py3VU+Y1qqQ1cruEkiXzrf6CZmunbtVMYzBdU1gOZpLNF8NHq0hOTtVYSuGoo42CcoNNKWL5O0Yw33NSB0y8Gi9Lwk+8HrwqKYhMBgZyYERd14W3UYGVaYTmce9aZ7eeZs6S5u+T/wLYumvvsrdumKhmmqnzZr927scNAV4tfJafj3La0j9ynSLRelE4KaWTPnRRIFgCfsQ5kN48bUkm7AmKIkc2X3uNaypmlYmWFT4qrjUVFuIA61jiK0JlbWjO61tUT7AEmkxUKoZX41++g+KZvjJExlOCDvQypSDpP9vz+zhnnqdS4S4paKCZPAZu2UMy2ZiUyHJmrB/YFOLQxg03yiQ/gG0gtLvdAREOP0K0uqAZMKLADsYh+JYcmVZWlVUnds1zcQ71yWl42uEKJrg2sO16n+miLSCXIdbbQHUB0+dF/raVg9MYFRjqRN9EY/tWIpgrXzrvCyD72NG7Z5FPcCV1t9L/cAg7ygLXt28jag77XrCIBbg4lYdKCycypZBWTP9ktXpiE6NG4j2GImQTPlyOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(316002)(498600001)(8936002)(16526019)(2616005)(336012)(5660300002)(6916009)(1076003)(54906003)(186003)(26005)(47076005)(426003)(36860700001)(83380400001)(356005)(70586007)(36756003)(2906002)(7696005)(8676002)(70206006)(40460700003)(4326008)(86362001)(82310400005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:08.1302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b47eb77-fe90-46b8-2c4f-08da5098a05b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support to get VCO frequency from registers.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 94 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  3 +
 2 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 90ba9576a6fb..e3abadeca0a6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -531,6 +531,96 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 				clk_mgr_base->clks.dispclk_khz / 1000 / 7);
 }
 
+static uint32_t dcn32_get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
+{
+		struct fixed31_32 pll_req;
+		uint32_t pll_req_reg = 0;
+
+		/* get FbMult value */
+		if (ASICREV_IS_GC_11_0_2(clk_mgr->base.ctx->asic_id.hw_internal_rev))
+			pll_req_reg = REG_READ(CLK0_CLK_PLL_REQ);
+		else
+			pll_req_reg = REG_READ(CLK1_CLK_PLL_REQ);
+
+		/* set up a fixed-point number
+		 * this works because the int part is on the right edge of the register
+		 * and the frac part is on the left edge
+		 */
+			pll_req = dc_fixpt_from_int(pll_req_reg & clk_mgr->clk_mgr_mask->FbMult_int);
+		pll_req.value |= pll_req_reg & clk_mgr->clk_mgr_mask->FbMult_frac;
+
+		/* multiply by REFCLK period */
+		pll_req = dc_fixpt_mul_int(pll_req, clk_mgr->dfs_ref_freq_khz);
+
+		return dc_fixpt_floor(pll_req);
+}
+
+static void dcn32_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
+		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	uint32_t dprefclk_did = 0;
+	uint32_t dcfclk_did = 0;
+	uint32_t dtbclk_did = 0;
+	uint32_t dispclk_did = 0;
+	uint32_t dppclk_did = 0;
+	uint32_t target_div = 0;
+
+	if (ASICREV_IS_GC_11_0_2(clk_mgr->base.ctx->asic_id.hw_internal_rev)) {
+		/* DFS Slice 0 is used for DISPCLK */
+		dispclk_did = REG_READ(CLK0_CLK0_DFS_CNTL);
+		/* DFS Slice 1 is used for DPPCLK */
+		dppclk_did = REG_READ(CLK0_CLK1_DFS_CNTL);
+		/* DFS Slice 2 is used for DPREFCLK */
+		dprefclk_did = REG_READ(CLK0_CLK2_DFS_CNTL);
+		/* DFS Slice 3 is used for DCFCLK */
+		dcfclk_did = REG_READ(CLK0_CLK3_DFS_CNTL);
+		/* DFS Slice 4 is used for DTBCLK */
+		dtbclk_did = REG_READ(CLK0_CLK4_DFS_CNTL);
+	} else {
+		/* DFS Slice 0 is used for DISPCLK */
+		dispclk_did = REG_READ(CLK1_CLK0_DFS_CNTL);
+		/* DFS Slice 1 is used for DPPCLK */
+		dppclk_did = REG_READ(CLK1_CLK1_DFS_CNTL);
+		/* DFS Slice 2 is used for DPREFCLK */
+		dprefclk_did = REG_READ(CLK1_CLK2_DFS_CNTL);
+		/* DFS Slice 3 is used for DCFCLK */
+		dcfclk_did = REG_READ(CLK1_CLK3_DFS_CNTL);
+		/* DFS Slice 4 is used for DTBCLK */
+		dtbclk_did = REG_READ(CLK1_CLK4_DFS_CNTL);
+	}
+
+	/* Convert DISPCLK DFS Slice DID to divider*/
+	target_div = dentist_get_divider_from_did(dispclk_did);
+	//Get dispclk in khz
+	regs_and_bypass->dispclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+
+	/* Convert DISPCLK DFS Slice DID to divider*/
+	target_div = dentist_get_divider_from_did(dppclk_did);
+	//Get dppclk in khz
+	regs_and_bypass->dppclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+
+	/* Convert DPREFCLK DFS Slice DID to divider*/
+	target_div = dentist_get_divider_from_did(dprefclk_did);
+	//Get dprefclk in khz
+	regs_and_bypass->dprefclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+
+	/* Convert DCFCLK DFS Slice DID to divider*/
+	target_div = dentist_get_divider_from_did(dcfclk_did);
+	//Get dcfclk in khz
+	regs_and_bypass->dcfclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+
+	/* Convert DTBCLK DFS Slice DID to divider*/
+	target_div = dentist_get_divider_from_did(dtbclk_did);
+	//Get dtbclk in khz
+	regs_and_bypass->dtbclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+}
+
 static void dcn32_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
 {
 	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
@@ -680,6 +770,7 @@ static bool dcn32_is_smu_present(struct clk_mgr *clk_mgr_base)
 static struct clk_mgr_funcs dcn32_funcs = {
 		.get_dp_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 		.update_clocks = dcn32_update_clocks,
+		.dump_clk_registers = dcn32_dump_clk_registers,
 		.init_clocks = dcn32_init_clocks,
 		.notify_wm_ranges = dcn32_notify_wm_ranges,
 		.set_hard_min_memclk = dcn32_set_hard_min_memclk,
@@ -730,7 +821,8 @@ void dcn32_clk_mgr_construct(
 	}
 
 	/* integer part is now VCO frequency in kHz */
-	clk_mgr->base.dentist_vco_freq_khz = 4300000;//dcn32_get_vco_frequency_from_reg(clk_mgr);
+	clk_mgr->base.dentist_vco_freq_khz = dcn32_get_vco_frequency_from_reg(clk_mgr);
+
 	/* in case we don't get a value from the register, use default */
 	if (clk_mgr->base.dentist_vco_freq_khz == 0)
 		clk_mgr->base.dentist_vco_freq_khz = 4300000; /* Updated as per HW docs */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 4dd461e6c14b..9ae9439c8f7b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -245,6 +245,9 @@ struct clk_mgr_funcs {
 
 	void (*init_clocks)(struct clk_mgr *clk_mgr);
 
+	void (*dump_clk_registers)(struct clk_state_registers_and_bypass *regs_and_bypass,
+			struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info);
+
 	void (*enable_pme_wa) (struct clk_mgr *clk_mgr);
 	void (*get_clock)(struct clk_mgr *clk_mgr,
 			struct dc_state *context,
-- 
2.25.1

