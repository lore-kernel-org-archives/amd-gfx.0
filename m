Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10449C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C0F10E4BC;
	Tue, 30 Jul 2024 07:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t3jcRETX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD53810E4B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8g2WV7RNuxMehSpMBY+3RcJninFlF/r1Eo5n/5CWZetmfrQJD+7fHR1RHvG4eBFdlxXlQCYy1VoB/93hP8Ure1qidQR2+KZhPaWlJPu3uNiBTXQB7PniHVH3/3NpfKf3r+6fGOhnHU1mVh9ngVbA4oQA580I/VLnWADzavHZ2gL2yIfejtBTuzbXihAxnOg0/2H6MB0JvtYfc0qeVia8Jbg5Jcosg1i67+XD/BfvB0B6U5+Hptuc+3l4hCzU+88I/aNOP0PoN5WWcc+gmX6amPhxU4YsYTngELYv+HAqCCmPp8HaFNTmbyvO/ANGTsXa1IAyiQOhaaQp/T1cORDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZDq1DTvEvfr2I2uGBaoE0kcow8cx4fi7s1MwHKDwFI=;
 b=VgpHDwiY54zQ9rVanLEDoMUpQLayfSGW0P8RytZtCJJUVbOwGsLO8fAqCj1ujvuKd2Js7fVgJALj4vDxEvYsVQ8uEblytFOqrA8a8rvqdvlfBGb/LtsfG9iV5TqhhSaLqKZqKCsFbuMjn3fDpVLEk1me3gskqiwFLgmsV0t4aXpsXN5kPxDA1p3JBJDjYI6pdzwV6j85plGE01jSAs/+z3j0IxmqJ365pVb80yRMRvdSjQcrPXGelK/UDcL3tx45EWwInNyXdA01o3Rb4qqdi3NA0kO6eCshVCqwhZ3GYXbU42TmrgRi4deOTIyjSGl/9HQ42Rq68g2HsCgEtJBPJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZDq1DTvEvfr2I2uGBaoE0kcow8cx4fi7s1MwHKDwFI=;
 b=t3jcRETXiv+qA5O92UuMDbxgJcPF8Cq29ewLRn7IufJbSsWd3NjWJuz/QL75y6Z77cFAiMzW0lGbHpQgCUOttTNx3oOVbUzGis4VkokojRBJzAN2r4lkRamKZl6sN5SvybveVYMTSrd39q0yKuXtwuXfgw+WFBTNyU4b2FvQsyQ=
Received: from CH2PR14CA0020.namprd14.prod.outlook.com (2603:10b6:610:60::30)
 by CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:20:16 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::1c) by CH2PR14CA0020.outlook.office365.com
 (2603:10b6:610:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 07:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:20:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:20:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:20:14 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:20:07 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Hansen Dsouza
 <Hansen.Dsouza@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>
Subject: [PATCH 08/22] drm/amd/display: Add stream and char control callback
Date: Tue, 30 Jul 2024 15:18:29 +0800
Message-ID: <20240730071843.880430-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|CYYPR12MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3f1665-8129-4d88-53bb-08dcb0680f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wM5NLzu5q3+e7CteeGhQsxgyY4h5GBb/7ve0TZl3qWrfQ5AThLCd280dsTZy?=
 =?us-ascii?Q?RKzYCzhVzDjbPLntm8L7LOcHlFp/uiHbJejHtKaiBGOMh1ECBRhxn6SgX4Dq?=
 =?us-ascii?Q?nmBCOrSZJSdvGmw5WWFLNRsI7AXHOkjcZMrgBopqS2GL4yF901eKCSyvYKus?=
 =?us-ascii?Q?lq+OAJo/TWHns5CVGQ5GIWwjQ9jdBJV101j15eLPCsw/p973fKNNIxtFMJYC?=
 =?us-ascii?Q?xQPn9PprDSWGvDducclcUToE3l3h8KTfuip3NrrOY2HhByAnI/q4E+hOPIE+?=
 =?us-ascii?Q?94jG3pvegUV9wvJrCctoDRi4oHMARj5w/bDJ0J5/fkQWZhicJPzCHol7PBOA?=
 =?us-ascii?Q?yfR7NWDwhoaKOGvEPeqBEYrantH9kCqXRrpp6G5x5bMXeG9s/TOS9Z50bLII?=
 =?us-ascii?Q?s7Gu7f3VynYDVoL25hqAT7BfKSMEgYIFdgLa0nATgAKrAIuHA551Sz2CdO3k?=
 =?us-ascii?Q?GOW3wWc5J2bKN1scQA2k9RuAu6CTVx6F7H+yyR9QYP7akugTjRRkcGOlSc5U?=
 =?us-ascii?Q?iULiyN8zNryDYuoFGu1twQ683xtMsci4Ytj3ghK4VkV5oV/qYtkesREjnjGa?=
 =?us-ascii?Q?AcHMkKXRBqb+R2cNcokVh//k2di58w2OCYVu/yZpIjtMxes+OnopH/N7QPYh?=
 =?us-ascii?Q?5nFRcxMCYI/JRQMjDlsliJg/rE6P4ChgS+pDU0vKAX4nLxdpHmmU+4CMQNDV?=
 =?us-ascii?Q?of2UA+tpMC1bKhiNHg2845qh1imlmTFL6oI8znwoOLWQSE/uTQEaaTb4kSmc?=
 =?us-ascii?Q?zul5eN2ehZlaZo02qduAJOKVGlcFtGlZ3uUTVL0ZPolDbxmr+nOGxAnUoCzE?=
 =?us-ascii?Q?ybGtIs/nv3rkn9OpFYYm2pRSlY0pMmmGTzX9C23CDMNvhQZyBJ87v7EgazwB?=
 =?us-ascii?Q?QG8Lu0vf6OPWj3kAsbGN6iwvz3hw0QRRJ68qsNESwTzX5fH6/1HlzuqnTeRI?=
 =?us-ascii?Q?d6ij7dkuyN0krzI/OIdZfY+DXKIhoHQKfCj1enANQJrx6nxdwkeqan0drOV7?=
 =?us-ascii?Q?DctjUCpUDce72cUm7ngJ/KGmYy9h9/BjOjm5uHEWGB30kla1HKHNECKxvATt?=
 =?us-ascii?Q?6vHqrxNy757RQR52AQ059tKsbB1IzL1kWqWkais2GI2n7T0D9P0f6WY//3i4?=
 =?us-ascii?Q?CMWP8a7VEBJt1/7RoTX4ZfPQG5/KlIwrV7PbnkXoSrm08EFosa1MsWXCTfLx?=
 =?us-ascii?Q?PKceA50eLxvxwX2Tp51bj9TkGpk1oePq0Qe/4nPd5YSuduWCxwfeGzwgvD+Y?=
 =?us-ascii?Q?ZJR9SdC6JeHl3dTdJBpIe3jXzQKdo9Uuj/zzVk449Hn5mdGG4KJ3zTsPQojt?=
 =?us-ascii?Q?GC7X1SI9WHDmKtH+ZYYySjOjJFw0mxwSU8bv/1VfzYeN/ZYh/cO71TdTJEc3?=
 =?us-ascii?Q?HPfFiUnSYvS82ukfjVVy+xSLyrhmn1FOudfysk7WmP4KXRCr16MNt3YJsO8o?=
 =?us-ascii?Q?N0tTsp9ZH0IgEiWR+c26eE3iD6lDs9/1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:20:16.0871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3f1665-8129-4d88-53bb-08dcb0680f6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939
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

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

[why & how]
Add new stream and char control functions based on DCCG spec

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 132 ++++++++++++++++--
 1 file changed, 122 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index bd3757de51c9..13e3d64ee2f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -896,7 +896,7 @@ static void dccg35_disable_symclk32_le_new(
 	dccg35_set_symclk32_le_rcg(dccg, inst, true);
 }
 
-static void dccg35_enable_dpp_new(
+static void dccg35_enable_dpp_clk_new(
 	struct dccg *dccg,
 	int inst,
 	enum dppclk_clock_source src)
@@ -915,7 +915,7 @@ static void dccg35_enable_dpp_new(
 			  DPPCLK0_DTO_MODULO, 0xFF);
 }
 
-static void dccg35_disable_dpp_new(
+static void dccg35_disable_dpp_clk_new(
 	struct dccg *dccg,
 	int inst)
 {
@@ -956,27 +956,25 @@ static void dccg35_enable_dtbclk_p_new(struct dccg *dccg,
 }
 
 static void dccg35_disable_dtbclk_p_new(struct dccg *dccg,
-										enum dtbclk_source src,
 										int inst)
 {
 	dccg35_set_dtbclk_p_src_new(dccg, DTBCLK_REFCLK, inst);
 	dccg35_set_dtbclk_p_rcg(dccg, inst, true);
 }
 
-static void dccg35_enable_dpstreamclk_new(struct dccg *dccg,
-										  enum dtbclk_source src,
+static void dccg35_disable_dpstreamclk_new(struct dccg *dccg,
 										  int inst)
 {
 	dccg35_set_dpstreamclk_src_new(dccg, DP_STREAM_REFCLK, inst);
 	dccg35_set_dpstreamclk_rcg(dccg, inst, true);
 }
 
-static void dccg35_disable_dpstreamclk_new(struct dccg *dccg,
-										   enum dtbclk_source src,
+static void dccg35_enable_dpstreamclk_new(struct dccg *dccg,
+										   enum dp_stream_clk_source src,
 										   int inst)
 {
 	dccg35_set_dpstreamclk_rcg(dccg, inst, false);
-	dccg35_set_dtbclk_p_src_new(dccg, src, inst);
+	dccg35_set_dpstreamclk_src_new(dccg, src, inst);
 }
 
 static void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
@@ -1935,6 +1933,114 @@ static void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst
 	}
 }
 
+static void dccg35_set_dpstreamclk_cb(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		int otg_inst,
+		int dp_hpo_inst)
+{
+
+	enum dtbclk_source dtb_clk_src;
+	enum dp_stream_clk_source dp_stream_clk_src;
+
+	ASSERT(otg_inst >= DP_STREAM_DTBCLK_P5);
+
+	switch (src) {
+	case REFCLK:
+		dtb_clk_src = DTBCLK_REFCLK;
+		dp_stream_clk_src = DP_STREAM_REFCLK;
+		break;
+	case DPREFCLK:
+		dtb_clk_src = DTBCLK_DPREFCLK;
+		dp_stream_clk_src = (enum dp_stream_clk_source)otg_inst;
+		break;
+	case DTBCLK0:
+		dtb_clk_src = DTBCLK_DTBCLK0;
+		dp_stream_clk_src = (enum dp_stream_clk_source)otg_inst;
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	if (dtb_clk_src == DTBCLK_REFCLK &&
+		dp_stream_clk_src == DP_STREAM_REFCLK) {
+		dccg35_disable_dtbclk_p_new(dccg, otg_inst);
+		dccg35_disable_dpstreamclk_new(dccg, dp_hpo_inst);
+	} else {
+		dccg35_enable_dtbclk_p_new(dccg, dtb_clk_src, otg_inst);
+		dccg35_enable_dpstreamclk_new(dccg,
+										dp_stream_clk_src,
+										dp_hpo_inst);
+	}
+}
+
+static void dccg35_set_dpstreamclk_root_clock_gating_cb(
+	struct dccg *dccg,
+	int dp_hpo_inst,
+	bool power_on)
+{
+	/* power_on set indicates we need to ungate
+	 * Currently called from optimize_bandwidth and prepare_bandwidth calls
+	 * Since clock source is not passed restore to refclock on ungate
+	 * Instance 0 is implied here since only one streamclock resource
+	 * Redundant as gating when enabled is acheived through set_dpstreamclk
+	 */
+	if (power_on)
+		dccg35_enable_dpstreamclk_new(dccg,
+										DP_STREAM_REFCLK,
+										dp_hpo_inst);
+	else
+		dccg35_disable_dpstreamclk_new(dccg, dp_hpo_inst);
+}
+
+static void dccg35_update_dpp_dto_cb(struct dccg *dccg, int dpp_inst,
+				  int req_dppclk)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (dccg->ref_dppclk && req_dppclk) {
+		int ref_dppclk = dccg->ref_dppclk;
+		int modulo, phase;
+
+		// phase / modulo = dpp pipe clk / dpp global clk
+		modulo = 0xff;   // use FF at the end
+		phase = ((modulo * req_dppclk) + ref_dppclk - 1) / ref_dppclk;
+
+		if (phase > 0xff) {
+			ASSERT(false);
+			phase = 0xff;
+		}
+
+		/* Enable DPP CLK DTO output */
+		dccg35_enable_dpp_clk_new(dccg, dpp_inst, DPP_DCCG_DTO);
+
+		/* Program DTO */
+		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+				DPPCLK0_DTO_PHASE, phase,
+				DPPCLK0_DTO_MODULO, modulo);
+	} else
+		dccg35_disable_dpp_clk_new(dccg, dpp_inst);
+
+	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
+}
+
+static void dccg35_dpp_root_clock_control_cb(
+		struct dccg *dccg,
+		unsigned int dpp_inst,
+		bool power_on)
+{
+	/* power_on set indicates we need to ungate
+	 * Currently called from optimize_bandwidth and prepare_bandwidth calls
+	 * Since clock source is not passed restore to refclock on ungate
+	 * Redundant as gating when enabled is acheived through update_dpp_dto
+	 */
+	if (power_on)
+		dccg35_enable_dpp_clk_new(dccg, dpp_inst, DPP_REFCLK);
+	else
+		dccg35_disable_dpp_clk_new(dccg, dpp_inst);
+}
+
 static const struct dccg_funcs dccg35_funcs = {
 	.update_dpp_dto = dccg35_update_dpp_dto,
 	.dpp_root_clock_control = dccg35_dpp_root_clock_control,
@@ -2010,14 +2116,20 @@ struct dccg *dccg35_create(
 	(void)&dccg35_disable_symclk32_se_new;
 	(void)&dccg35_enable_symclk32_le_new;
 	(void)&dccg35_disable_symclk32_le_new;
-	(void)&dccg35_enable_dpp_new;
-	(void)&dccg35_disable_dpp_new;
+	(void)&dccg35_enable_dpp_clk_new;
+	(void)&dccg35_enable_dpp_clk_new;
 	(void)&dccg35_disable_dscclk_new;
 	(void)&dccg35_enable_dscclk_new;
 	(void)&dccg35_enable_dtbclk_p_new;
 	(void)&dccg35_disable_dtbclk_p_new;
 	(void)&dccg35_enable_dpstreamclk_new;
 	(void)&dccg35_disable_dpstreamclk_new;
+	(void)&dccg35_set_dpstreamclk_cb;
+	(void)&dccg35_dpp_root_clock_control_cb;
+	(void)&dccg35_set_dpstreamclk_root_clock_gating_cb;
+	(void)&dccg35_update_dpp_dto_cb;
+	(void)&dccg35_dpp_root_clock_control_cb;
+
 	base = &dccg_dcn->base;
 	base->ctx = ctx;
 	base->funcs = &dccg35_funcs;
-- 
2.37.3

