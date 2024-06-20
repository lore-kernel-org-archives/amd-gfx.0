Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0124C41513
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CEF10EADC;
	Thu, 20 Jun 2024 16:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yCGGQ49b";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 955E610EADC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAlw6YaeSCUNzLw1tuG+td/KVk7ZwHQJ3Pix3GhtIGLGDHzfHYdry1JAI+uZSv6qh/B+DK4VzCE9YiqgG2BqDkAk9LS2YJOwRioV6jk3sVv4B489KJS1pS6sClO0yJX8NLppZPlFCxjopjIzf/zyMWVqVWjTxKuPWk98W2QN7tVLbD7zWrOWTzT7F1l2uxXHuthoIlGC7q/GBr0uqzQ3hWy3oSZmxz24909EhNdM8w4Lxn/DIPr6Dr44RuQ1dSNragmpWNMhByBB/PfazXaCgj9Nb54oZ1WE1ZYV7C8EkqPvEI5rfyfj6wEEJA5dm9b+P/8xkkUHzr9YUqTNJPJBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7EK3bm2pEFQToIQUeY++n8nEMxUV956X7QAFC5dxB0=;
 b=Kf5klEeAISFhokfb2gWFpqkqFlIYWqaPufuGkELSwRAAvA0tbcDkhj8Q18ofyCbb0M8embU1ZB/HCRmTBYMQUOfkCQoglDJiOVVm5VLtteE5vKYRcdymKlUx1JUa3Kzm6nB4l5TSQAK3qEvCgRfSkvZsx1pxQHtainWW5ah55TpT3ZzYTN5TWPGpAVmCj2MLOhOV7JQ+DEuzBWNdKH5764QIiPFH06aFLAY8Z95YSam7Jma5LhGNGZk8FPMDX0aR8afjJliiw5IcKfAYuOiopvYNHDfCkBh1+dzAFBdZx5bH9K1aKsXoqmVuGwM3aPq2UDHOPbnFAzAUChhaokO2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7EK3bm2pEFQToIQUeY++n8nEMxUV956X7QAFC5dxB0=;
 b=yCGGQ49b3hkFNBhBxshzlHiSKnhw0LeiUkzm58BjhA58HkoJ2jDFH918hEfKdLgTk12flph2JieOG+nKf4IyxTdnOG9krKYNPFxeI/5uquyz/Fuh+djTXYj5qYcP6Lzr2FZXE3NdSY6Z30SbmOvXRZEI9miwZQ3/NRXkAMDdISw=
Received: from PH1PEPF000132F3.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::38)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 16:12:32 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2a01:111:f403:c936::) by PH1PEPF000132F3.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Thu, 20 Jun 2024 16:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:12:31 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:12:29 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Relja Vojvodic <relja.vojvodic@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 02/39] drm/amd/display: Refactor
 dccg401_get_other_enable_symclk_fe
Date: Thu, 20 Jun 2024 10:11:08 -0600
Message-ID: <20240620161145.2489774-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e518c31-9ad8-47bb-c412-08dc9143ca32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|376011|36860700010|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5gpTY0aRcLVt7UzPrMLocmLm9TMZMIFp8wclKVCPoVrbzi7IyZkm8++yaw1c?=
 =?us-ascii?Q?pYG5xzvdYSHEu9V0tM0s5INlSayK/5H4QU0AXnQ4e1rUGoQYY0D76rlvRgaR?=
 =?us-ascii?Q?rgiGXuiA41/XSuOvKke1tBRd2ttLTd21YipukqwGOeT/JmdZQpfSVfmlOjvg?=
 =?us-ascii?Q?TZlaV7Mse/tItgmmEPZcOht74VNfypYAHzUlKWkqhjq801dj5cp3Kcr3BaO8?=
 =?us-ascii?Q?gZF8misMaRrczq2cTkcxA8ejeNaupD7oPgDmSM9qBFEq1V5GqiclmZgMYHE3?=
 =?us-ascii?Q?wsDTzQmIrz5CwAa2vxjz7ukxUT7nqboWixixSTBV9J3xNV39nIXL3zQU4bum?=
 =?us-ascii?Q?YHb/S1tRbHtuQhO+SCK2M+KYMDKP8PuJO/hM5unVyrQdzQ6XFxJcEeuagWWk?=
 =?us-ascii?Q?ewsNdemes1iWhoLKKBt3h5pYuEWBt2EQdSH4xcwBEvUbJEPvm917jjcw+GiO?=
 =?us-ascii?Q?0SOjoPmMFyiHoaDEJF6icSUBYgtpHqLHx1kYAMSEFGXu4TCgccf/L82C/577?=
 =?us-ascii?Q?GrpwvlvuRqGZ5or53vHHXcSfu6zxhMhdbJWL6M0VOR7o+LvAXqxYnKl2uGrK?=
 =?us-ascii?Q?PkeVtHD2orR0gevrJnv4yYasFW+mcz6ksX212q4Jdl4jTWqaLV1JIehWH6AO?=
 =?us-ascii?Q?+G1n7CwAKoZHrsORHjtLXzZwu3J4fKV+pZ59Kb8qugOHuhM1VqC7l1bTGido?=
 =?us-ascii?Q?PhoDEVzb5buruivGDi8wwxC2jhmAiNHh87ZmBgkjVj//5HCSSDTgNVyz2C5C?=
 =?us-ascii?Q?apSDzchRHG0EIM8F8qJRUGfw4JGAakM2PbJXb99s5+SfKat7Zg7tQwICpMpL?=
 =?us-ascii?Q?ogXA1TVD4VY/OoXhp6pvvlLpPVPeKw23ookQGjjSUnbZ9n7QISmAcKnSxwAx?=
 =?us-ascii?Q?ANpMXAZVuPYDD0kI6qJMgSDoZdr9zFdeLVq41+vOCKpRa/GbWwAeA4DieuE9?=
 =?us-ascii?Q?U3A0IB6F9snuovlHDO8fc/QAfJV66T8fjnARonvsW8n5uuBwr84jyxma6fpZ?=
 =?us-ascii?Q?KSjhz4KhHPvlAA7HFNZmUfi0Q7TWHp+ax2W1kQue7P0YFFRqCX+6xCPdW6R+?=
 =?us-ascii?Q?wvoBP3U+i8/TH01185e1k2aEJy0R98erUlCYH8iEsy0xN+cpDQJ1IUA0BTDg?=
 =?us-ascii?Q?Exja8FTwzmi+s6OHHyFxCq/zGtyRpqjenIlQUdYX/rYg8ch3a39JhAJtGATo?=
 =?us-ascii?Q?BMiM25b6NxZwCPvq9geLrikLgUhVEbaDJrlPvCqrplwFtNFqwXfk3ZN/O5wD?=
 =?us-ascii?Q?i5Um17crtlydjA5Ob62aw3pLRzsjN94eSxE7B/89YQV+qj54792de1o+mwA4?=
 =?us-ascii?Q?uWXSSonwDkXRodSxLW3Do+8ZJBgR5U5dX6LeWAdgfLBHDlBvJNs6zqcjJHJU?=
 =?us-ascii?Q?dIAxlqoVsN8EGPMfMj4D/KaRso2rzsPC/7SXyQPQ6to1GwTb3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(376011)(36860700010)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:12:31.9678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e518c31-9ad8-47bb-c412-08dc9143ca32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

From: Relja Vojvodic <relja.vojvodic@amd.com>

[WHY]
Function was used to check the number of FEs connected to the current BE.
This was then used to determine if the symclk could be disabled, if all
FEs were disconnected. However, the function would skip over the primary
FE and return 0 when the primary FE was still connected. This caused black
screens on driver disable with an MST daisy chain hooked up.

[HOW]
Refactored the function to correctly return the number of FEs connected to
the input BE. Also renamed it for clarity.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Relja Vojvodic <relja.vojvodic@amd.com>
---
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  | 57 +++++++------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 6a467c49b4a4..07f1f396ba52 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -853,43 +853,30 @@ static void dccg401_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst
 }
 
 /*get other front end connected to this backend*/
-static uint8_t dccg401_get_other_enabled_symclk_fe(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+static uint8_t dccg401_get_number_enabled_symclk_fe_connected_to_be(struct dccg *dccg, uint32_t link_enc_inst)
 {
 	uint8_t num_enabled_symclk_fe = 0;
-	uint32_t be_clk_en = 0, fe_clk_en[4] = {0}, be_clk_sel[4] = {0};
+	uint32_t fe_clk_en[4] = {0}, be_clk_sel[4] = {0};
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	uint8_t i;
 
-	switch (link_enc_inst) {
-	case 0:
-		REG_GET_3(SYMCLKA_CLOCK_ENABLE, SYMCLKA_CLOCK_ENABLE, &be_clk_en,
-				SYMCLKA_FE_EN, &fe_clk_en[0],
-				SYMCLKA_FE_SRC_SEL, &be_clk_sel[0]);
-				break;
-	case 1:
-		REG_GET_3(SYMCLKB_CLOCK_ENABLE, SYMCLKB_CLOCK_ENABLE, &be_clk_en,
-				SYMCLKB_FE_EN, &fe_clk_en[1],
-				SYMCLKB_FE_SRC_SEL, &be_clk_sel[1]);
-				break;
-	case 2:
-			REG_GET_3(SYMCLKC_CLOCK_ENABLE, SYMCLKC_CLOCK_ENABLE, &be_clk_en,
-				SYMCLKC_FE_EN, &fe_clk_en[2],
-				SYMCLKC_FE_SRC_SEL, &be_clk_sel[2]);
-				break;
-	case 3:
-			REG_GET_3(SYMCLKD_CLOCK_ENABLE, SYMCLKD_CLOCK_ENABLE, &be_clk_en,
-				SYMCLKD_FE_EN, &fe_clk_en[3],
-				SYMCLKD_FE_SRC_SEL, &be_clk_sel[3]);
-				break;
-	}
-	if (be_clk_en) {
-	/* for DPMST, this backend could be used by multiple front end.
-	only disable the backend if this stream_enc_ins is the last active stream enc connected to this back_end*/
-		uint8_t i;
-		for (i = 0; i != link_enc_inst && i < ARRAY_SIZE(fe_clk_en); i++) {
-			if (fe_clk_en[i] && be_clk_sel[i] == link_enc_inst)
-				num_enabled_symclk_fe++;
-		}
+	REG_GET_2(SYMCLKA_CLOCK_ENABLE, SYMCLKA_FE_EN, &fe_clk_en[0],
+			SYMCLKA_FE_SRC_SEL, &be_clk_sel[0]);
+
+	REG_GET_2(SYMCLKB_CLOCK_ENABLE, SYMCLKB_FE_EN, &fe_clk_en[1],
+			SYMCLKB_FE_SRC_SEL, &be_clk_sel[1]);
+
+	REG_GET_2(SYMCLKC_CLOCK_ENABLE, SYMCLKC_FE_EN, &fe_clk_en[2],
+			SYMCLKC_FE_SRC_SEL, &be_clk_sel[2]);
+
+	REG_GET_2(SYMCLKD_CLOCK_ENABLE,	SYMCLKD_FE_EN, &fe_clk_en[3],
+			SYMCLKD_FE_SRC_SEL, &be_clk_sel[3]);
+
+	for (i = 0; i < ARRAY_SIZE(fe_clk_en); i++) {
+		if (fe_clk_en[i] && be_clk_sel[i] == link_enc_inst)
+			num_enabled_symclk_fe++;
 	}
+
 	return num_enabled_symclk_fe;
 }
 
@@ -921,9 +908,9 @@ static void dccg401_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_ins
 		break;
 	}
 
-	/*check other enabled symclk fe */
-	num_enabled_symclk_fe = dccg401_get_other_enabled_symclk_fe(dccg, stream_enc_inst, link_enc_inst);
-	/*only turn off backend clk if other front end attachecd to this backend are all off,
+	/*check other enabled symclk fe connected to this be */
+	num_enabled_symclk_fe = dccg401_get_number_enabled_symclk_fe_connected_to_be(dccg, link_enc_inst);
+	/*only turn off backend clk if other front ends attached to this backend are all off,
 	 for mst, only turn off the backend if this is the last front end*/
 	if (num_enabled_symclk_fe == 0) {
 		switch (link_enc_inst) {
-- 
2.34.1

