Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BED4C25B78
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FCF10EDC6;
	Thu, 16 May 2024 19:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="485SruBV";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D8610EDA7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVmoT9DMvOt+7owFEsPP4ZI0mUtgqbsTXvXDZODyRTtixYqOATiZH+dWcSVGNKK/8FbuB7MORheDyJtd1Xtuk6jD/NEVvPZiSbOYLuQDprSaBgqPtTI3qqCk1oALrW0gHtd4+yllFUljp+wUG3QMsTLrY2JIwxKKZR3hU4DiIkpcw7NCr3X/e4WYpAkDR4f1pB4yBbdtCUUktpvfghkBce4O7AFV6ag2qSSzcM0nGNPKJjC2d3K7PbADArJbw+xm4kD+dGhmT61vaYtwHtKhW+9iePmf/7UeeWy/lIshr51nBVBzL8N/b6fbcWtm5YRo1fHA28sKqL4IqSza6l3dKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQfiSP+0LZop9T/mtOjl2fl1h3fgFwsCQpNSZH2+dbU=;
 b=X5Zc4xGiSUD+rD3BzTppZYTlQWQuPrzxqHJX7B6qhWVUJ+jS54nec4mswVf1laY2+Bo7XyRJg7yb1JGEGpb0sJAJc+Xifhk8TCKu+QIyDDzRQXvTWKaOTAHDXii/3T7YQkc60GeGur1DQGcE1rV1BPzyb55sq7iW8hYyeSA1dpFFsSTS1sX1DbvqhpnP+fe8soj5J+EVhLgS0LpYYc/FAMqYfqlWJ9uqUc/Z+9gNgd97D4QCyHBZrWZ1+Pb1Ui4FaN8m+hp3MVStCyBFodV35iVxdByOKNluFqdh76bVbIP48h2SRMpdeWzJLWi7COZFcW4PttLUZbg6OcIfxIrZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQfiSP+0LZop9T/mtOjl2fl1h3fgFwsCQpNSZH2+dbU=;
 b=485SruBVISbmrO9ktyLpZSRrKHoBpjJ6zbHPYttBYjR5XsyS80+WQEdS2khcuPsIyhVuALShoLSCIhJ9737PEKAyeriNE9eYBfiH7Txqsngs3S+cu2b99kcUi9Sq5Ln+kAbfb7WbNHpvqG2+ihe7FtGOMHlk6akvdpi9KcuuXD8=
Received: from MN2PR06CA0008.namprd06.prod.outlook.com (2603:10b6:208:23d::13)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Thu, 16 May
 2024 19:26:57 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::2a) by MN2PR06CA0008.outlook.office365.com
 (2603:10b6:208:23d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Thu, 16 May 2024 19:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:26:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:26:56 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:26:55 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 03/24] drm/amd/display: Add missing enable and disable
 symclk_se functions for dcn401
Date: Thu, 16 May 2024 15:26:26 -0400
Message-ID: <20240516192647.1522729-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 673908dc-7ba3-4c04-2e22-08dc75de26b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o022kO/qsVZU3B4HFmMh+J4igQ5GMhE0KHFzdLlV9F2mx49bZkUeZgL5Sd5Z?=
 =?us-ascii?Q?C1F5wAnz0rjeucLLGEfMJayUU1i/jWPoww8++GoBf68QVJhWkqY+HbF4EzIN?=
 =?us-ascii?Q?9719Egpxou0yTn5Z+vmgGSSchVFU0/VRUgP6zWY//pMylmfOrigCtLbJSX2O?=
 =?us-ascii?Q?l9hFJF66lGb8YdxepzoKJoH2u0oQuK6Kfgg1cXyP43ZlZrKfihEYr7IKnxoq?=
 =?us-ascii?Q?f4wZAMOd9TdGMK91D3qtdb7+IAd6QDfwY3hsnppvqvqATTnK5D7p7QXcMD7Q?=
 =?us-ascii?Q?O/JjuVECkHNdF/AwfzVwTQkmYdw4mF/lUP+TimyhKpd3EAsKR2/kBntLHVpm?=
 =?us-ascii?Q?ARZHVgm0ZczHRK4qh3GjSfzW7RBCGIXIuf4wFhagroYMAcsaJwHEfRKvEekn?=
 =?us-ascii?Q?fYu//d2m68ME8q5QJAhexVMCZc5FItC/tGqHaeNb5ZNFdaQjaxS/1idQd33J?=
 =?us-ascii?Q?gdinj+08yjcxPRmvyVvrIoa7Kw3NDv1/NCt2hkJJJ84w3tpGw3uP7ziptr6g?=
 =?us-ascii?Q?cRnHARYC+208pdeWZSCApzs9PvGxuCzOVtlREed/r4kQbJWkHRKkzm9bIyK2?=
 =?us-ascii?Q?p2cbsOD8IcA7djHryd+vjJUbms/DNOZbmYP9ir9uW/n2CI0KZO0v/4gR0st9?=
 =?us-ascii?Q?U2mEKZ0S6Bu6v0zZ5d/lHKp0N6K5hRfuRZh0p83+g+q9RuDcMRQUqgK5A/NJ?=
 =?us-ascii?Q?ucqEVQOg0v7ya1R9aD+3C7Tl8pFFUlBieW2L+DTT06bT16W4KSXfID4XZZbZ?=
 =?us-ascii?Q?e4hx5o08mziYGbGp0xSh7kCoXvixDXaKtoZamHb8Twoav2e4oN79H+N8jplu?=
 =?us-ascii?Q?W6artADKedHuf7vxuFSe7upkJDZVGGytTJO/1RhfJM/7EVV0kHt3+NxlLSiB?=
 =?us-ascii?Q?mVaiFEwi+fynVWehXJfqY5DPaW3nqkaSC/3Jkzwrev5AayLQJNrwtLQvhLYS?=
 =?us-ascii?Q?Qzmsd8/IQfHpvvNwZ0viI6WbGk1DFN5bdP1LYpIUQTFf8guhwj6qiYBdTsP2?=
 =?us-ascii?Q?sLBu/iKARHEUVoZSExCDvOBcqDMQj782TGHy6WsxnCNPCjAovJmyG4lk4k0j?=
 =?us-ascii?Q?PHjZicCyBoR7NhQy9w8Xd6SUmwK0Ow3JVOsDI4briv/SY38xDV5BKM3JBiLM?=
 =?us-ascii?Q?S3m31wozaSM1ArQzqGlfUzpuqvzWgaHTpWh6Q6BhzfuTBEfBUjZ5z5ImY/11?=
 =?us-ascii?Q?e1GdwMOtW3WMUdsp2p7hEB7Jp7MUxz71OxX3pVNrUaC5I1jK/+AtfbuYWXhc?=
 =?us-ascii?Q?vnS5p6mTZBBauMLhKKvgtEjeqLlqz+1GGxU4mEZgKNzPHiMkX0smwSP5ZWqr?=
 =?us-ascii?Q?uWMWfpYWEsSVZy6jJ52HULmf22faUqushU6se23vxIafXEW+F96oVwzYhO8k?=
 =?us-ascii?Q?ok3Ag+oDmzdG8rTlZui2UosEdJIk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:26:57.1921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 673908dc-7ba3-4c04-2e22-08dc75de26b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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

From: Wenjing Liu <wenjing.liu@amd.com>

The functions are missing. These two functions are required to support
MST.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  | 159 ++++++++++++++++++
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |  12 ++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   5 +
 .../dc/resource/dcn401/dcn401_resource.h      |   6 +-
 4 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 72cbff8632dd..a496a250f892 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -785,6 +785,163 @@ static void dccg401_set_ref_dscclk(struct dccg *dccg,
 	}
 }
 
+static void dccg401_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (link_enc_inst) {
+	case 0:
+		REG_UPDATE(SYMCLKA_CLOCK_ENABLE,
+				SYMCLKA_CLOCK_ENABLE, 1);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_ROOT_GATE_DISABLE, 1);
+		break;
+	case 1:
+		REG_UPDATE(SYMCLKB_CLOCK_ENABLE,
+				SYMCLKB_CLOCK_ENABLE, 1);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_ROOT_GATE_DISABLE, 1);
+		break;
+	case 2:
+		REG_UPDATE(SYMCLKC_CLOCK_ENABLE,
+				SYMCLKC_CLOCK_ENABLE, 1);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_ROOT_GATE_DISABLE, 1);
+		break;
+	case 3:
+		REG_UPDATE(SYMCLKD_CLOCK_ENABLE,
+				SYMCLKD_CLOCK_ENABLE, 1);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_ROOT_GATE_DISABLE, 1);
+		break;
+	}
+
+	switch (stream_enc_inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLKA_CLOCK_ENABLE,
+				SYMCLKA_FE_EN, 1,
+				SYMCLKA_FE_SRC_SEL, link_enc_inst);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_FE_ROOT_GATE_DISABLE, 1);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLKB_CLOCK_ENABLE,
+				SYMCLKB_FE_EN, 1,
+				SYMCLKB_FE_SRC_SEL, link_enc_inst);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_FE_ROOT_GATE_DISABLE, 1);
+		break;
+	case 2:
+		REG_UPDATE_2(SYMCLKC_CLOCK_ENABLE,
+				SYMCLKC_FE_EN, 1,
+				SYMCLKC_FE_SRC_SEL, link_enc_inst);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_FE_ROOT_GATE_DISABLE, 1);
+		break;
+	case 3:
+		REG_UPDATE_2(SYMCLKD_CLOCK_ENABLE,
+				SYMCLKD_FE_EN, 1,
+				SYMCLKD_FE_SRC_SEL, link_enc_inst);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_FE_ROOT_GATE_DISABLE, 1);
+		break;
+	}
+}
+
+/*get other front end connected to this backend*/
+static uint8_t dccg401_get_other_enabled_symclk_fe(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+{
+	uint8_t num_enabled_symclk_fe = 0;
+	uint32_t be_clk_en = 0, fe_clk_en[4] = {0}, be_clk_sel[4] = {0};
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (link_enc_inst) {
+	case 0:
+		REG_GET_3(SYMCLKA_CLOCK_ENABLE, SYMCLKA_CLOCK_ENABLE, &be_clk_en,
+				SYMCLKA_FE_EN, &fe_clk_en[0],
+				SYMCLKA_FE_SRC_SEL, &be_clk_sel[0]);
+				break;
+	case 1:
+		REG_GET_3(SYMCLKB_CLOCK_ENABLE, SYMCLKB_CLOCK_ENABLE, &be_clk_en,
+				SYMCLKB_FE_EN, &fe_clk_en[1],
+				SYMCLKB_FE_SRC_SEL, &be_clk_sel[1]);
+				break;
+	case 2:
+			REG_GET_3(SYMCLKC_CLOCK_ENABLE, SYMCLKC_CLOCK_ENABLE, &be_clk_en,
+				SYMCLKC_FE_EN, &fe_clk_en[2],
+				SYMCLKC_FE_SRC_SEL, &be_clk_sel[2]);
+				break;
+	case 3:
+			REG_GET_3(SYMCLKD_CLOCK_ENABLE, SYMCLKD_CLOCK_ENABLE, &be_clk_en,
+				SYMCLKD_FE_EN, &fe_clk_en[3],
+				SYMCLKD_FE_SRC_SEL, &be_clk_sel[3]);
+				break;
+	}
+	if (be_clk_en) {
+	/* for DPMST, this backend could be used by multiple front end.
+	only disable the backend if this stream_enc_ins is the last active stream enc connected to this back_end*/
+		uint8_t i;
+		for (i = 0; i != link_enc_inst && i < sizeof(fe_clk_en); i++) {
+			if (fe_clk_en[i] && be_clk_sel[i] == link_enc_inst)
+				num_enabled_symclk_fe++;
+		}
+	}
+	return num_enabled_symclk_fe;
+}
+
+static void dccg401_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+{
+	uint8_t num_enabled_symclk_fe = 0;
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (stream_enc_inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLKA_CLOCK_ENABLE,
+				SYMCLKA_FE_EN, 0,
+				SYMCLKA_FE_SRC_SEL, 0);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLKB_CLOCK_ENABLE,
+				SYMCLKB_FE_EN, 0,
+				SYMCLKB_FE_SRC_SEL, 0);
+		break;
+	case 2:
+		REG_UPDATE_2(SYMCLKC_CLOCK_ENABLE,
+				SYMCLKC_FE_EN, 0,
+				SYMCLKC_FE_SRC_SEL, 0);
+		break;
+	case 3:
+		REG_UPDATE_2(SYMCLKD_CLOCK_ENABLE,
+				SYMCLKD_FE_EN, 0,
+				SYMCLKD_FE_SRC_SEL, 0);
+		break;
+	}
+
+	/*check other enabled symclk fe */
+	num_enabled_symclk_fe = dccg401_get_other_enabled_symclk_fe(dccg, stream_enc_inst, link_enc_inst);
+	/*only turn off backend clk if other front end attachecd to this backend are all off,
+	 for mst, only turn off the backend if this is the last front end*/
+	if (num_enabled_symclk_fe == 0) {
+		switch (link_enc_inst) {
+		case 0:
+			REG_UPDATE(SYMCLKA_CLOCK_ENABLE,
+					SYMCLKA_CLOCK_ENABLE, 0);
+			break;
+		case 1:
+			REG_UPDATE(SYMCLKB_CLOCK_ENABLE,
+					SYMCLKB_CLOCK_ENABLE, 0);
+			break;
+		case 2:
+			REG_UPDATE(SYMCLKC_CLOCK_ENABLE,
+					SYMCLKC_CLOCK_ENABLE, 0);
+			break;
+		case 3:
+			REG_UPDATE(SYMCLKD_CLOCK_ENABLE,
+					SYMCLKD_CLOCK_ENABLE, 0);
+			break;
+		}
+	}
+}
 
 static const struct dccg_funcs dccg401_funcs = {
 	.update_dpp_dto = dccg401_update_dpp_dto,
@@ -806,6 +963,8 @@ static const struct dccg_funcs dccg401_funcs = {
 	.otg_drop_pixel = dccg401_otg_drop_pixel,
 	.set_pixel_rate_div = dccg401_set_pixel_rate_div,
 	.set_dp_dto = dccg401_set_dp_dto,
+	.enable_symclk_se = dccg401_enable_symclk_se,
+	.disable_symclk_se = dccg401_disable_symclk_se,
 	.set_dtbclk_p_src = dccg401_set_dtbclk_p_src,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
index 8d9e26a760a3..8bcddc836347 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
@@ -181,6 +181,18 @@
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DPPCLK2_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DPPCLK3_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, HDMISTREAMCLK0_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(SYMCLKA_CLOCK_ENABLE, SYMCLKA_CLOCK_ENABLE, mask_sh),\
+	DCCG_SF(SYMCLKB_CLOCK_ENABLE, SYMCLKB_CLOCK_ENABLE, mask_sh),\
+	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_CLOCK_ENABLE, mask_sh),\
+	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_CLOCK_ENABLE, mask_sh),\
+	DCCG_SF(SYMCLKA_CLOCK_ENABLE, SYMCLKA_FE_EN, mask_sh),\
+	DCCG_SF(SYMCLKB_CLOCK_ENABLE, SYMCLKB_FE_EN, mask_sh),\
+	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_FE_EN, mask_sh),\
+	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_FE_EN, mask_sh),\
+	DCCG_SF(SYMCLKA_CLOCK_ENABLE, SYMCLKA_FE_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKB_CLOCK_ENABLE, SYMCLKB_FE_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_FE_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_FE_SRC_SEL, mask_sh),\
 
 void dccg401_init(struct dccg *dccg);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index c01cf2a2f786..c3bed33eb5d6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -32,6 +32,7 @@
 #include "dcn401_hwseq.h"
 #include "dcn401/dcn401_resource.h"
 #include "dc_state_priv.h"
+#include "link_enc_cfg.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -966,6 +967,8 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 	int dp_hpo_inst = 0;
 	unsigned int tmds_div = PIXEL_RATE_DIV_NA;
 	unsigned int unused_div = PIXEL_RATE_DIV_NA;
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
 	dcn401_enable_stream_calc(pipe_ctx, &dp_hpo_inst, &phyd32clk,
 				&tmds_div, &early_control);
@@ -978,6 +981,8 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 		} else {
 			/* need to set DTBCLK_P source to DPREFCLK for DP8B10B */
 			dccg->funcs->set_dtbclk_p_src(dccg, DPREFCLK, tg->inst);
+			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
+					link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index d4dce2b4b6c1..5d5e01903ca1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -576,6 +576,10 @@ bool dcn401_validate_bandwidth(struct dc *dc,
 	SR(DCCG_GATE_DISABLE_CNTL3),\
 	SR(DCCG_GATE_DISABLE_CNTL4),\
 	SR(DCCG_GATE_DISABLE_CNTL5),\
-	SR(DCCG_GATE_DISABLE_CNTL6)
+	SR(DCCG_GATE_DISABLE_CNTL6),\
+	SR(SYMCLKA_CLOCK_ENABLE),\
+	SR(SYMCLKB_CLOCK_ENABLE),\
+	SR(SYMCLKC_CLOCK_ENABLE),\
+	SR(SYMCLKD_CLOCK_ENABLE)
 
 #endif /* _DCN401_RESOURCE_H_ */
-- 
2.34.1

