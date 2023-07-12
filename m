Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A558FEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C6510E5A7;
	Wed, 12 Jul 2023 17:12:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5BAE10E5A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp+tIijMwxpBCacKKN66z2Pky6+uLX/AxQZvQ7v9UQ9+sXkNnzA+Lnq3nDvi7UWD4Cy5VFXM5LsNeKW/0kmBHd799UyJuKDH5+KZb3qjBc/VsPFl1AHGPiArrIETkjQjZFaYmd2qKhSGTS1BbvDGESscwxF+v8aBQfMsWya+Reg8wiHjFmwirZ8P7XcIq7mXAePRQc1N8D6j0DaTrNV+CIAqm+3bOCbbDcBJs/0vLh411VKjqSEMAIECOLfMNj0MEvqv+84okZnmPF2JGHxmB9b5gCdJC/jv8vF/R/26MSwpc4BLLoACFwiOZ3QrIFSMTjklHGGu4DneDY7g4E71kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4VP2bAuiPynLYTGBKloNGfcu3nwFLw/DnRjPq4JcXU=;
 b=IRRuiPdaUbJweQ/g0NJoyqLHfF0Fq8D4R197wck7Mtfn/o16CcH0Zkgnvj6eHVtNzjRo4F/1tbLB1H65d5MhMpDVQkgfTMNc+bWSAzRXp1rXsemNQoNhLGPrMqNbL6AfxIz/H8ZWXUTv5AxF72zSewR6ssZGtGWko5ILHQzWBAw6L3dcv5HHy3vhb2ZTtgrCafebiIwHybbT3bfOzsvZaEkbEiZS9KK3iqoQL0exe1v2jzZb+Uwegwuw+q+nwDi0l9SjaPWQQLOEmeWQJKhdVo1fweCopKTtDKh7tFjt+fqfbLP01yFRw2iIEGtwilPtkqZigX6tZ0F75GqMrPruJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4VP2bAuiPynLYTGBKloNGfcu3nwFLw/DnRjPq4JcXU=;
 b=3mDkCA/lxElNvi5ZbyB6iFf0nbhhpxmZ14txR3nbJ6vSggyCxjvptVOkCHlWkGln0asyxoKMmJ2fp25Bsp9idrumA1dxLeyaO6wyDziT1+5II5yhjux1NfFEocovlePuHfdjLr4m2ClYYmlT0JTo64qBToVNWReaQdOBrP4T2Jc=
Received: from BN8PR15CA0025.namprd15.prod.outlook.com (2603:10b6:408:c0::38)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.35; Wed, 12 Jul
 2023 17:12:52 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::8f) by BN8PR15CA0025.outlook.office365.com
 (2603:10b6:408:c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Wed, 12 Jul 2023 17:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:12:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:12:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:12:50 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:12:42 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/33] drm/amd/display: Hardcode vco_freq for dcn316
Date: Thu, 13 Jul 2023 01:11:12 +0800
Message-ID: <20230712171137.3398344-9-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d5a802-15ab-46e5-7a3b-08db82fb39b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KkbnuhufPsihcWfxtJ4Wyolkqk8VOCs9+kg5l4xXrocCzrDwfSUnckxHV/51iUMem5awTQgNrmM9O5BltXbqTANDp+cdGcPpWOxeHkaA+H7D2W4YuWJ6fvVXnYRdVUP17H9EflwC2bejY8QZkmmd04yB4wc4nd6otR6oEaL6Pcoa7y7JCpE3QxtPOmxMyBSraLdreZQqvHECBAedrNze8dRBFbSyxv5HrU3kvxf4Je0Q8Ob7gVa52whyyoPsdmH3eoB0ICkWRXE4AqU++vFtXBZcCgYOmd9igkaucWP5domDYuET00+VDFO1AgFyPkM58AaUoD/e8F3BqU+odEACQ/ifIXOWFDpCtwqIMr8TU5g0oRYd/9yG3efBUdPbtAbiIkt3n02M7NNYVK4CJPhLQiNOWId8Ks4twEqgFVg8lrpRQajFLsD6YYPv5TDtWNa9/rebA7E4hOE/DECVbaMvDFpQP3irXpMDe4LDB+mpLweq9NksaCHvaQNi9wBNLU382aJKPgr3Erf+1BBLOuqwUSCwzyWpshcTpdgWhYSJjvr3QXKfexUEBErgnMHGOOAbTq6+V1Kx9PU/wbUaDJgXd0PylaqqCVa7qDi7rECVix5yMCjbj91juy3QVpuvnVgDXN5ibNFEacMePhiSRA7sBTTSIfWX0FuN9jbr24VYp3NyysItI2iZdI7Q5HCZ6qfO8g41g6SOdc0zKCyNDojYYGlUs/jppx5/8QNMjmsxBhEbCUe/Gvuy7mtS1B67X2xiB9V+/dPjUnwuim9PU9y56w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(6666004)(7696005)(4326008)(54906003)(186003)(26005)(1076003)(2906002)(82310400005)(8676002)(8936002)(41300700001)(6916009)(19627235002)(70206006)(316002)(70586007)(5660300002)(81166007)(356005)(82740400003)(40460700003)(86362001)(2616005)(426003)(83380400001)(336012)(47076005)(36756003)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:12:51.9447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d5a802-15ab-46e5-7a3b-08db82fb39b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alan Liu <haoping.liu@amd.com>

There is no need to calculate the VCO frequency. In our internal branch
we've hard-coded this for a while, so it's well-tested. This also allows
us to remove the now unused code for calculating the VCO frequency.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Alan Liu <haoping.liu@amd.com>
---
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        | 44 +------------------
 1 file changed, 2 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index d7de756301cf..0349631991b8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -55,14 +55,6 @@ struct IP_BASE
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
 };
 
-static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0, 0 } },
-                                        { { 0x00016E00, 0x02401C00, 0, 0, 0, 0 } },
-                                        { { 0x00017000, 0x02402000, 0, 0, 0, 0 } },
-                                        { { 0x00017200, 0x02402400, 0, 0, 0, 0 } },
-                                        { { 0x0001B000, 0x0242D800, 0, 0, 0, 0 } },
-                                        { { 0x0001B200, 0x0242DC00, 0, 0, 0, 0 } },
-                                        { { 0x0001B400, 0x0242E000, 0, 0, 0, 0 } } } };
-
 #define regCLK1_CLK_PLL_REQ						0x0237
 #define regCLK1_CLK_PLL_REQ_BASE_IDX			0
 
@@ -73,9 +65,6 @@ static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0,
 #define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK		0x0000F000L
 #define CLK1_CLK_PLL_REQ__FbMult_frac_MASK		0xFFFF0000L
 
-#define REG(reg_name) \
-	(CLK_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
-
 #define TO_CLK_MGR_DCN316(clk_mgr)\
 	container_of(clk_mgr, struct clk_mgr_dcn316, base)
 
@@ -577,36 +566,6 @@ static struct clk_mgr_funcs dcn316_funcs = {
 };
 extern struct clk_mgr_funcs dcn3_fpga_funcs;
 
-static int get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
-{
-	/* get FbMult value */
-	struct fixed31_32 pll_req;
-	unsigned int fbmult_frac_val = 0;
-	unsigned int fbmult_int_val = 0;
-
-	/*
-	 * Register value of fbmult is in 8.16 format, we are converting to 31.32
-	 * to leverage the fix point operations available in driver
-	 */
-
-	REG_GET(CLK1_CLK_PLL_REQ, FbMult_frac, &fbmult_frac_val); /* 16 bit fractional part*/
-	REG_GET(CLK1_CLK_PLL_REQ, FbMult_int, &fbmult_int_val); /* 8 bit integer part */
-
-	pll_req = dc_fixpt_from_int(fbmult_int_val);
-
-	/*
-	 * since fractional part is only 16 bit in register definition but is 32 bit
-	 * in our fix point definiton, need to shift left by 16 to obtain correct value
-	 */
-	pll_req.value |= fbmult_frac_val << 16;
-
-	/* multiply by REFCLK period */
-	pll_req = dc_fixpt_mul_int(pll_req, clk_mgr->dfs_ref_freq_khz);
-
-	/* integer part is now VCO frequency in kHz */
-	return dc_fixpt_floor(pll_req);
-}
-
 void dcn316_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_dcn316 *clk_mgr,
@@ -660,7 +619,8 @@ void dcn316_clk_mgr_construct(
 		clk_mgr->base.smu_present = true;
 
 	// Skip this for now as it did not work on DCN315, renable during bring up
-	clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
+	//clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
+	clk_mgr->base.base.dentist_vco_freq_khz = 2500000;
 
 	/* in case we don't get a value from the register, use default */
 	if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
-- 
2.34.1

