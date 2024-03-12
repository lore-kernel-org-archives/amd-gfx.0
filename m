Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DC7C54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67EC3112B70;
	Tue, 12 Mar 2024 09:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QAx+Z35M";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3592D112B70
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIL5h+XVYTPUvlh/9NrxVvvOkz72tLvnEFp2x0H9tlEio8BlOC/D1Ph3ahVuQ60sF0U3seu6DUfTPeehRlU7ppbZtjQptpq+L7e16Wk2mQ7KeFk+l3qvo0L0KETqKiZTtu5NaI0IXaxQ5b2EJiNTCZD8kBWR0fIkLYegt6xgltAX1cPseYDv04BKnctn0PDOEhVYenKXJEi+PLtFpB48hNH20iVf8pMEGCOULhWAN3dT1+nhE+ELM7H2qOjh8co6r3VU7B4RDlbqMxE0nBk/Bbwhd4p0yI4aEOpqLU6VkxbaZNV1O8dFPSg8B2dWTimq1RZOURG7kW+69bO+0PkcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3mLN2J6qclXAs+v9AjzhMfDbz2CuNGqOx6BM1uCBIU=;
 b=dF/iObggNGtQQkCeR9wIak91SXXsdFsuN0ftujMXFqX/RNgohnh/NEd908nEp7jmp/6Sp1kPDSM+C8sBZEQ6IbVxrb6sgV+1ZfSgTlGyZvJxoEbzWiqU0Ymk/pmiJ2HLNHCT42RIveN7W1cvCBbbpdpzwzQ9VrCGhb7s+dEiYsEgBHTQOI3EvzElK2fo+W8bEl001chDriq9HElV1D9GITFC/LIUkpOiw4ilmsF3wD4VIWVdCp2YnbAd6uYIFOcKHR16gYA5Cm8liwv+MLpbbIhEKBD31Z+CUuEOl+38YjG8VzS0j323lyjQwgu0qH32baZ648R0eObsZH8RVP+JSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3mLN2J6qclXAs+v9AjzhMfDbz2CuNGqOx6BM1uCBIU=;
 b=QAx+Z35M0zRAk/H2dje2KNbUaW4BD/xgHo9G7mlD7CEhOatgKGLHFQ4L87vAOF27RWmaFcgqOzmiql+sJM3jLm3XNd4DlyipWRD7lE4PkhxgJl9mvAM5DwybIKwUfNQpR95DuOM8fyzWZwVF02UAtR93UEjMaveKEI7BjftzltU=
Received: from DM6PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:40::34) by
 MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:22:49 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::2) by DM6PR03CA0021.outlook.office365.com
 (2603:10b6:5:40::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:22:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:22:48 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:22:44 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Zhongwei
 <zhongwei.zhang@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 18/43] drm/amd/display: To adjust dprefclk by down spread
 percentage
Date: Tue, 12 Mar 2024 17:20:11 +0800
Message-ID: <20240312092036.3283319-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 78330e43-53c1-4a84-03ee-08dc4275fc61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2lQ+mINMkfP4CL2Sga2arJlqsDMuTjlKhm4QAW8Gjrjq8Eq/dvYzFyMxeHVRm7gs34PJGAxMePhbVB3v3CyEwJ74MqXWmDoEoFX+L0OEfKANWnhE6PFP6kQFzHl/+nYM1EAP7aMKt7V/OEpLUuih8O/Xb11H7IB7d3ZNRfWRjkgGR5D6iXT317lQ+6rtjvEi/l2h0ea5T6ji4SkZuaCvCd4fC+U/F0K+brIKShNrOelSJZ7bQasiXmW+aEB16PAbB0N8vWP/wRVfH/iR9p7AT7pAFmCI/z8W93A0I3VbnAUIRez9E0cF3DXj2t7wit8OUzL81GpmkOrLs36t6O1kji4a6GKFZsPIUv65oLAIoK94B7sNRNEzioBCC4N1+B53wju89o/fG9xOV1fgCYA56/2glkvd/mkMg9lIHmEadlp4NOsC+leICGuiur2pjbCte0eHIXet8kkuQyJAgxkKZLXIvTAMZk4e3liKXci4gZRk+0irmAoET4TvRM3jx/U8DLvM/nAPtVzqNL/iCrxrHDOBN/wcZBiKtY6gkKu6dXADKwn4XUj8MKLBgRcW0ixjx0lXraiEvHf/vSyJYY3CSSpZHtHarVk/V1/lXIHthxVER6eY2fl8F6V6wix76wMnjkdJi6nk7BdXjhi44icZ6SGpWUnoO+N/hUp9jm89CvQhjkwR0C52ARIzlsugYHRe0y0JxAcxOYwCNTuMsbjBcBOiWQ6cf0xvzptykeBLpvnCjUoFfk6ifIEG03NBG02
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:22:49.1653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78330e43-53c1-4a84-03ee-08dc4275fc61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189
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

From: Zhongwei <zhongwei.zhang@amd.com>

[Why]
OLED panels show no display for large vtotal timings.

[How]
Check if spread spectrum is enabled and read from lut for spread spectrum
percentage. Adjust dprefclk as required.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Zhongwei <zhongwei.zhang@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index c6030bed95a0..96c3562276f4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -73,6 +73,12 @@
 #define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK		0x00000007L
 #define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV_MASK		0x000F0000L
 
+#define regCLK5_0_CLK5_spll_field_8				0x464b
+#define regCLK5_0_CLK5_spll_field_8_BASE_IDX	0
+
+#define CLK5_0_CLK5_spll_field_8__spll_ssc_en__SHIFT	0xd
+#define CLK5_0_CLK5_spll_field_8__spll_ssc_en_MASK		0x00002000L
+
 #define REG(reg_name) \
 	(ctx->clk_reg_offsets[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
 
@@ -410,6 +416,17 @@ static void dcn35_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 {
 }
 
+static bool dcn35_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dc_context *ctx = clk_mgr->base.ctx;
+	uint32_t ssc_enable;
+
+	REG_GET(CLK5_0_CLK5_spll_field_8, spll_ssc_en, &ssc_enable);
+
+	return ssc_enable == 1;
+}
+
 static void init_clk_states(struct clk_mgr *clk_mgr)
 {
 	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
@@ -424,7 +441,16 @@ static void init_clk_states(struct clk_mgr *clk_mgr)
 
 void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 {
+	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
 	init_clk_states(clk_mgr);
+
+	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
+	if (dcn35_is_spll_ssc_enabled(clk_mgr))
+		clk_mgr->dp_dto_source_clock_in_khz =
+			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
+	else
+		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
+
 }
 static struct clk_bw_params dcn35_bw_params = {
 	.vram_type = Ddr4MemType,
@@ -513,6 +539,28 @@ static DpmClocks_t_dcn35 dummy_clocks;
 
 static struct dcn35_watermarks dummy_wms = { 0 };
 
+static struct dcn35_ss_info_table ss_info_table = {
+	.ss_divider = 1000,
+	.ss_percentage = {0, 0, 375, 375, 375}
+};
+
+static void dcn35_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
+{
+	struct dc_context *ctx = clk_mgr->base.ctx;
+	uint32_t clock_source;
+
+	REG_GET(CLK1_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL, &clock_source);
+
+	if (dcn35_is_spll_ssc_enabled(&clk_mgr->base) && (clock_source < ARRAY_SIZE(ss_info_table.ss_percentage))) {
+		clk_mgr->dprefclk_ss_percentage = ss_info_table.ss_percentage[clock_source];
+
+		if (clk_mgr->dprefclk_ss_percentage != 0) {
+			clk_mgr->ss_on_dprefclk = true;
+			clk_mgr->dprefclk_ss_divider = ss_info_table.ss_divider;
+		}
+	}
+}
+
 static void dcn35_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn35_watermarks *table)
 {
 	int i, num_valid_sets;
@@ -1057,6 +1105,8 @@ void dcn35_clk_mgr_construct(
 	dce_clock_read_ss_info(&clk_mgr->base);
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
+	dcn35_read_ss_info_from_lut(&clk_mgr->base);
+
 	clk_mgr->base.base.bw_params = &dcn35_bw_params;
 
 	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
-- 
2.37.3

