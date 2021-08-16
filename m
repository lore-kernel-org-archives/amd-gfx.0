Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF6C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 21:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C0760EE5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 21:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94C0760EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 419B96E062;
	Mon, 16 Aug 2021 21:05:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736D96E062
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 21:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc+qNpAKcyT0zJWYtw950jWRtAAoHd7mBdGn4hU04Wj9lGHWc8O6ZXnQdZqS862SeApQyH6ncEeEEO6OlH7+F65bLGpVYsRjpdj+AOCnJW/60dGJdP8S9lxjG4hhBLdsa44CjHUEAKC3b+hTZwP0CMeqaIEEQ0Z5CEf4ZLX73Ir/HnTX7MRWQbB8cOkCj1bLm6bsxOurXqGekOnUVKfAt5pm9u93OnEyq/Zz3wX4Hp/lVMFLXYM0GOyU4tLOem9VmlQJBBR2n0J2jmmtyPUW5W/VAaNWa6JJ/rHa3WuAecFkiOkxyAP9GlXjsYC6b8zkzG42820CwoNxnd15FhbDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPBMZkxGFnpg5iTBhE55E6sACvtwg14I5PC1eZdK+vM=;
 b=HwRVpcjsBKnz4ICdUXNT7eels2SQZne6OnT4kjjN2YsMlZGfjVNZaRrjIm4XJn4tTx14YEBM85r0sLHbyyfeNOlgAWz6E3aC0B91diZrN61uWccnSxBbmxFa0PksJUupux3Flj/QedJGDXlpr4xTrrnFbUTVqUA7qRfOKJittgSSExp7uK9JFI/XlxJCzKFThz4cD+VIeDV1SKnopTb/uBGPEsMWXtrq6n27sk26U2xVx5ns3ZYgyEia4yE2QKW0WWiaytWlQ5dSYrkdubL6sIEoqGsrm1ZN/DAow3WbkZAkCk1zz2jishUN2N/Fx+hqq0ZIimRDM38W0arjzWMUNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPBMZkxGFnpg5iTBhE55E6sACvtwg14I5PC1eZdK+vM=;
 b=xuk/LeyXAKLsC5W/AhqBZrXuHrZjY2UtYEhZawIaA/59oVr59/OZL3MN8WH75wZce9tqVusRCqX83VBvxhKprUit2rgxU/PGJ11rkARJDT4t/eGggh3B+WD3Q0NVFnEE3zHZ3WLm6AwISdNF/7IGtlSZZ/HMyL/WQt3T72Mx3eQ=
Received: from MWHPR13CA0032.namprd13.prod.outlook.com (2603:10b6:300:95::18)
 by BYAPR12MB3495.namprd12.prod.outlook.com (2603:10b6:a03:ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 21:05:02 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::1) by MWHPR13CA0032.outlook.office365.com
 (2603:10b6:300:95::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11 via Frontend
 Transport; Mon, 16 Aug 2021 21:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 21:05:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 16 Aug
 2021 16:05:01 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 16 Aug 2021 16:04:59 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.kazlauskas@amd.com>,
 <harry.wentland@amd.com>
CC: <wayne.lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 4/6] drm/amd/display: Add DP 2.0 DCCG
Date: Mon, 16 Aug 2021 16:59:17 -0400
Message-ID: <20210816205919.614691-5-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816205919.614691-1-Jerry.Zuo@amd.com>
References: <20210816205919.614691-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ad389a3-4e69-4e26-4a2b-08d960f9839b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3495:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3495F4A5D797787ACDC94506E5FD9@BYAPR12MB3495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUcq8jA0VprYXPPoLLZ80FfKuYHNT54X88/81pBbKm5u3ncfyQVcIP9XdIxB2+0J9Fmj4DwBhUWAo8rH50uwm7oHYWW4A6ouJq4ACdmJSPemwg+DJYMWWfqzlKr/Xc7sSMSeys7XWIgoFpvcmNF0n2YNERknq3L+RNtklX2fZk5yvqu2Q0RR9EOyRCJ1Jv38+p6RvIcszSgZMvtkm2tNT3yFPtD1vsDx10BRN2140FsWjwqy0FiJ1khiWeFQHthXMEE03c2yEr9zXSlqgQrDwBv8xSDikQ+xvwKq2WTAFMyLLD3Hmpx0+dW3tQUpob1fCRaEjvItzyyWJpipWslZ000YPOFxCT34L/Y7gQffZjaEIb3jsLw2lF+eC31wI84itoYQxrFKuO1hty+WWgULmkhmv0PChzvUvSx1OopabAgGR9XMTjDhRqBcH/q/T3aQomLXVhpVluc0EEl5mDWNPVsrR0Y64sbEmXVEN6i6S9u0+tOGzmrADkvAWu6b+IaAAt+p1r/KNUvTvvI5hTX2jB2953YGBVbgyfEbzsUEdae6VHBZBAlkaunL6bgrDvg54kDO1ycSpEM3NaN3CNKN4++KgFyPNikncwhJ0+hInFWM95OYmAXH2694DlLWK6s+i5gE1l1piK6ZA506OpTo9xEy5qMyk9lH+b3UtRWCdFzuIF+hgoemPle9Dj9tG7DCpuxFRCN0dfvX/xreg0zA449VCP5ZyxnorgZImZbRb8h6r9kEYJs38IhL5QpNw0IB7IYCXYSnvgaoLU490Rr9WA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(478600001)(4326008)(186003)(426003)(8936002)(356005)(7696005)(1076003)(2906002)(6636002)(36756003)(54906003)(110136005)(316002)(336012)(26005)(82310400003)(2616005)(47076005)(34020700004)(5660300002)(70586007)(70206006)(6666004)(36860700001)(83380400001)(82740400003)(81166007)(86362001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 21:05:01.9212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad389a3-4e69-4e26-4a2b-08d960f9839b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3495
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

HW Blocks:

        +--------+  +-----+  +------+
        |  OPTC  |  | HDA |  | HUBP |
        +--------+  +-----+  +------+
            |          |        |
            |          |        |
    HPO ====|==========|========|====
     |      |          v        |
     |      |       +-----+     |
     |      |       | APG |     |
     |      |       +-----+     |
     |      |          |        |
     |      v          v        v
     |     +---------------------+
     |     |  HPO Stream Encoder |
     |     +---------------------+
     |                 |
     |                 v
     |      +--------------------+
     |      |  HPO Link Encoder  |
     |      +--------------------+
     |                 |
     v  ===============|=============
                       v
              +------------------+
              |  DIO Output Mux  |
              +------------------+
                       |
                       v
                    +-----+
                    | PHY |
                    +-----+
                       | PHYD32CLK[0]
                       v
                    +------+
                    | DCCG |
                    +------+
                       |
                       v
                   SYMCLK32

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 162 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |  18 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  21 +++
 .../amd/display/dc/inc/hw/timing_generator.h  |   1 +
 4 files changed, 202 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 696c9307715d..9896adf67425 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -42,6 +42,155 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
+void dccg31_set_dpstreamclk(
+		struct dccg *dccg,
+		enum hdmistreamclk_source src,
+		int otg_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* enabled to select one of the DTBCLKs for pipe */
+	switch (otg_inst) {
+	case 0:
+		REG_UPDATE(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK_PIPE0_EN, (src == REFCLK) ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK_PIPE1_EN, (src == REFCLK) ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK_PIPE2_EN, (src == REFCLK) ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK_PIPE3_EN, (src == REFCLK) ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg31_enable_symclk32_se(
+		struct dccg *dccg,
+		int hpo_se_inst,
+		enum phyd32clk_clock_source phyd32clk)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* select one of the PHYD32CLKs as the source for symclk32_se */
+	switch (hpo_se_inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE0_SRC_SEL, phyd32clk,
+				SYMCLK32_SE0_EN, 1);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE1_SRC_SEL, phyd32clk,
+				SYMCLK32_SE1_EN, 1);
+		break;
+	case 2:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE2_SRC_SEL, phyd32clk,
+				SYMCLK32_SE2_EN, 1);
+		break;
+	case 3:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE3_SRC_SEL, phyd32clk,
+				SYMCLK32_SE3_EN, 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg31_disable_symclk32_se(
+		struct dccg *dccg,
+		int hpo_se_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* set refclk as the source for symclk32_se */
+	switch (hpo_se_inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE0_SRC_SEL, 0,
+				SYMCLK32_SE0_EN, 0);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE1_SRC_SEL, 0,
+				SYMCLK32_SE1_EN, 0);
+		break;
+	case 2:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE2_SRC_SEL, 0,
+				SYMCLK32_SE2_EN, 0);
+		break;
+	case 3:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE3_SRC_SEL, 0,
+				SYMCLK32_SE3_EN, 0);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg31_enable_symclk32_le(
+		struct dccg *dccg,
+		int hpo_le_inst,
+		enum phyd32clk_clock_source phyd32clk)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* select one of the PHYD32CLKs as the source for symclk32_le */
+	switch (hpo_le_inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLK32_LE_CNTL,
+				SYMCLK32_LE0_SRC_SEL, phyd32clk,
+				SYMCLK32_LE0_EN, 1);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLK32_LE_CNTL,
+				SYMCLK32_LE1_SRC_SEL, phyd32clk,
+				SYMCLK32_LE1_EN, 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg31_disable_symclk32_le(
+		struct dccg *dccg,
+		int hpo_le_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* set refclk as the source for symclk32_le */
+	switch (hpo_le_inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLK32_LE_CNTL,
+				SYMCLK32_LE0_SRC_SEL, 0,
+				SYMCLK32_LE0_EN, 0);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLK32_LE_CNTL,
+				SYMCLK32_LE1_SRC_SEL, 0,
+				SYMCLK32_LE1_EN, 0);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
 void dccg31_set_physymclk(
 		struct dccg *dccg,
 		int phy_inst,
@@ -241,12 +390,25 @@ static void dccg31_set_dispclk_change_mode(
 
 void dccg31_init(struct dccg *dccg)
 {
+	/* Set HPO stream encoder to use refclk to avoid case where PHY is
+	 * disabled and SYMCLK32 for HPO SE is sourced from PHYD32CLK which
+	 * will cause DCN to hang.
+	 */
+	dccg31_disable_symclk32_se(dccg, 0);
+	dccg31_disable_symclk32_se(dccg, 1);
+	dccg31_disable_symclk32_se(dccg, 2);
+	dccg31_disable_symclk32_se(dccg, 3);
 }
 
 static const struct dccg_funcs dccg31_funcs = {
 	.update_dpp_dto = dccg2_update_dpp_dto,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
 	.dccg_init = dccg31_init,
+	.set_dpstreamclk = dccg31_set_dpstreamclk,
+	.enable_symclk32_se = dccg31_enable_symclk32_se,
+	.disable_symclk32_se = dccg31_disable_symclk32_se,
+	.enable_symclk32_le = dccg31_enable_symclk32_le,
+	.disable_symclk32_le = dccg31_disable_symclk32_le,
 	.set_physymclk = dccg31_set_physymclk,
 	.set_dtbclk_dto = dccg31_set_dtbclk_dto,
 	.set_audio_dtbclk_dto = dccg31_set_audio_dtbclk_dto,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index 706ad80ba873..1e5aabcb7799 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -130,6 +130,24 @@ struct dccg *dccg31_create(
 
 void dccg31_init(struct dccg *dccg);
 
+void dccg31_enable_symclk32_se(
+		struct dccg *dccg,
+		int hpo_se_inst,
+		enum phyd32clk_clock_source phyd32clk);
+
+void dccg31_disable_symclk32_se(
+		struct dccg *dccg,
+		int hpo_se_inst);
+
+void dccg31_enable_symclk32_le(
+		struct dccg *dccg,
+		int hpo_le_inst,
+		enum phyd32clk_clock_source phyd32clk);
+
+void dccg31_disable_symclk32_le(
+		struct dccg *dccg,
+		int hpo_le_inst);
+
 void dccg31_set_physymclk(
 		struct dccg *dccg,
 		int phy_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 0afa2364a986..f179af35ef61 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -79,7 +79,28 @@ struct dccg_funcs {
 	void (*otg_drop_pixel)(struct dccg *dccg,
 			uint32_t otg_inst);
 	void (*dccg_init)(struct dccg *dccg);
+	void (*set_dpstreamclk)(
+			struct dccg *dccg,
+			enum hdmistreamclk_source src,
+			int otg_inst);
+
+	void (*enable_symclk32_se)(
+			struct dccg *dccg,
+			int hpo_se_inst,
+			enum phyd32clk_clock_source phyd32clk);
+
+	void (*disable_symclk32_se)(
+			struct dccg *dccg,
+			int hpo_se_inst);
+
+	void (*enable_symclk32_le)(
+			struct dccg *dccg,
+			int hpo_le_inst,
+			enum phyd32clk_clock_source phyd32clk);
 
+	void (*disable_symclk32_le)(
+			struct dccg *dccg,
+			int hpo_le_inst);
 	void (*set_physymclk)(
 			struct dccg *dccg,
 			int phy_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 03f47f23fb65..1216a71d02ce 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -100,6 +100,7 @@ enum crc_selection {
 
 enum otg_out_mux_dest {
 	OUT_MUX_DIO = 0,
+	OUT_MUX_HPO_DP = 2,
 };
 
 enum h_timing_div_mode {
-- 
2.25.1

