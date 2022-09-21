Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B3DECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 23:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0266910E9D5;
	Wed, 21 Sep 2022 23:18:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2059710E970
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 23:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUYIMViNgVCR/cFKWXxSDmAcFRReREaRqC+2PTY3ojW/HoUt+7YdIn/DcY57vl9MSAJl9JuCOpfMc1lq2vBvdOe6y0vHBpgrIPF8WqCBXrdVxrImE8oTZOAc66vKiqxebQPcCBDmEBd4jmXqB+g3d5BgXH0KtkkFY6nWMkJ52mbknnvdfBl4oKna0bjI2shLyovK9rX9wse3/zPcO1E8kvMUarwDv77IeTBcDSaqLDjHRiv+TnrZGzTjB06r7xOGfbTMWc79Hdk15rw7ckvtd6TYpKpyWxna6MGw0WK5GzAnv30raiwTkn8z9I/lfFBlR4tQ60IpPPwQd4hqeQSdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/C/M2Z7V5ro//YxIjq2IKMBOdPEsBvybxPV0oK6PSk=;
 b=WcnUIZmX5m2k1b9GozgwjnZ3nJNx6aD5sBz3Q7qVgytmZzmeruIANKZSMA4C/5Y9qLAXoHIeQ3LhWhbD/H9WKQ3rs7Uo1JNrg9qpwPqZ6OEJTs9e16ttANUAl6wXQt6sAYvHH/v3SfjiVljDLk50y6l9ugFl/dN+zMmO2ZAIBR0KlGi9kEwyVF5NUAXG4pPfHZWhh2Q91ol+7g27HDPrTddElV+Xb+gMOauImVWKAQu/sV8XS4BnlmYPbeFvMLRPvn+OHI7AISHERKpz5iMiqzYvWFkdEjxNJtIfEDy1DjvWMy6eu0sHzofiTyi6AYE4FluY16jY0hWHFWEmgCMcEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/C/M2Z7V5ro//YxIjq2IKMBOdPEsBvybxPV0oK6PSk=;
 b=hvndCTWNuOlznBygX5cRCLEpVB2smq/QBr8Zq3TsTfbk+n/shHfgqqvZ8MO98h/05kY2Yy7UnJlH9Q2MbzmUPPNdWGD7VJzzBVROHg45ez8OAUzsdg/NHJasUSNMlYfjxSoYLbGqzIKKuo26tbza0UcYTEPSaEPPFSzPvRVJxaQ=
Received: from MW4PR03CA0090.namprd03.prod.outlook.com (2603:10b6:303:b6::35)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 23:17:40 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::c9) by MW4PR03CA0090.outlook.office365.com
 (2603:10b6:303:b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Wed, 21 Sep 2022 23:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 23:17:40 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 18:17:36 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/31] drm/amd/display: Avoid avoid unnecessary pixel rate
 divider programming
Date: Wed, 21 Sep 2022 19:16:48 -0400
Message-ID: <20220921231714.303727-6-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921231714.303727-1-jdhillon@amd.com>
References: <20220921231714.303727-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 6354ba71-b2fe-4cd1-bfd1-08da9c277aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fui1Ciiicywcm89M2Moid6jlhmxRBZCICIh+BfFNDxMu9IA93OtWwDE3E1QwpG26P9izVCHlOgrmfAxnUAsPQZjdz5eJXZpKpUc8LoLQ//EO7Aak7Uz0h9bYBl+nLvtWef3L/ebTZiSvTXdx1hngLHTdp74Ji6ADnFyImHBQmA/NaelyDD49JGfXsnKqXwubSv4OiSoFxc1pVWdHEAFAmX0HwcldSm9w7PMxqBl9OrX2VhpWBPhHBaQ9EMTDcj1h69yl7FVffbt/byet8BpeNe0b0THE5eKnwHOvonAL0T3UlhEigLFNsrYCLhLEqsy9rYKcJcLmzGdwdcsmnpy11LjkaaZ0ZZuMWZAPBQ+XOwc4QIOs3E5A0vMQTbX5uOcdILTNa5WI9ZZ4eroV7EyXwkrJ0ihXPjjCxO6EyxBSG0EeN7DfzbBleRAM1ssaJB7XGVpOTumSHSoPWvnTjD780Ce7FKqxBWgHZw+Yp3KD0Lc3x/feHCTg8JF4t1jo1bQjKIyUSSMnyJhAW2A/7suUioiH1GptZUMb2NLVebPemwG3jzaFsTUy7Ke5/0J+wFuQk+IpF9LrZVZUBQt/M2rbyf1uVvLMQp4M3R8zlrCGU9H/vu1WNL8ehPFl7YYb0XLHiGptZGiupkEK5nBG0c1auorcGHhfDs8O8EnapIQNJBH0SR+MPG3FRfAq8fTQSoWjAcxi3qgeeOa2G7Is+Mj/fBEJEd6mClEGf4Be4rNReG+NIdGs0RJ5cwHDlzajEUguAga6QNABzMnQL0Yor5kS/6SBlpVdfCOX9/QlBWSFMyU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(478600001)(6916009)(36756003)(54906003)(70586007)(70206006)(8676002)(186003)(4326008)(41300700001)(6666004)(81166007)(1076003)(356005)(26005)(82310400005)(8936002)(336012)(316002)(40460700003)(5660300002)(16526019)(82740400003)(2616005)(40480700001)(426003)(47076005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 23:17:40.1188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6354ba71-b2fe-4cd1-bfd1-08da9c277aba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why]
Programming pixel rate divider when FIFO is enabled can cause FIFO error.

[How]
Skip divider programming when divider values are the same to prevent FIFO
error.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 36630d532c18..171e1580291a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -45,6 +45,48 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
+static void dccg314_get_pixel_rate_div(
+		struct dccg *dccg,
+		uint32_t otg_inst,
+		enum pixel_rate_div *k1,
+		enum pixel_rate_div *k2)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
+
+	*k1 = PIXEL_RATE_DIV_NA;
+	*k2 = PIXEL_RATE_DIV_NA;
+
+	switch (otg_inst) {
+	case 0:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG0_PIXEL_RATE_DIVK1, &val_k1,
+			OTG0_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	case 1:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG1_PIXEL_RATE_DIVK1, &val_k1,
+			OTG1_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	case 2:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG2_PIXEL_RATE_DIVK1, &val_k1,
+			OTG2_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	case 3:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG3_PIXEL_RATE_DIVK1, &val_k1,
+			OTG3_PIXEL_RATE_DIVK2, &val_k1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	*k1 = (enum pixel_rate_div)val_k1;
+	*k2 = (enum pixel_rate_div)val_k2;
+}
+
 static void dccg314_set_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
@@ -52,6 +94,11 @@ static void dccg314_set_pixel_rate_div(
 		enum pixel_rate_div k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
+
+	dccg314_get_pixel_rate_div(dccg, otg_inst, &cur_k1, &cur_k2);
+	if (k1 == PIXEL_RATE_DIV_NA || k2 == PIXEL_RATE_DIV_NA || (k1 == cur_k1 && k2 == cur_k2))
+		return;
 
 	switch (otg_inst) {
 	case 0:
-- 
2.25.1

