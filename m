Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5A5C531FC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81AFF10F1CE;
	Thu, 23 Jul 2026 20:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uJpKsfQk";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180A210F1C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4+kSM7zv2WvPWct5gLNI+MGQK1/f7UV5xp+5sYSTY6c4WVpUcN72CD4g4udyzq8vthLya5WHXU5Yy+Jy7uRYID96r3wFChVSKc2fL9DrHz6vZpGYjnU2VM2US25yq95Kb38CeEosMECPuatYxgNZ+KanaPtWBL+v5q1sWyfGLRGiuTz+eNC3RGnCTp10h8SL0IdYgvhgBHkAYbk2vMSvIja0ZpyXkuYpaX9i5IgbJfOCkmozeugCYZjwaaN00YJ/j3lqAnggbjRIlYJchDEdSIK7gjnawdFsYGyqobhux7iJbSW8t0lc6wWUk2V9nw65QuzTh8zOfs+aRr1mfIJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qkGLPt/1xtZoj3tuRB86PlrXUCUAHZ/gZzD5Jnz+pI=;
 b=xX+403l4pJgp4w1AVOep7oPfhMb7bYGmgO/RVq2H1RyaD7SDgXyLGWD9Ls3h3NGMquHiIJHHNl11vExlAJyXeipQx0GyWfu5q3wDWpWnXqJ0dXPzIL2UpVzKeUnDxnRLp9kqii8PF0zif0LDaJXrXIayeOsfV3O2VQUor279fog5GZMiJF2JnnyBDgYP5ruVhVyV9P+YavQVNNWBv658eosFdiD2NPoFvqJsR6V/pRRC8Rr6MSAMG4cmbhzbR6YAnL4OiYyHDTKZIT7e0Z58ajcMVPj2UQ57TXVLL8pkgTBiEm9MNzgkRN/N/RdiwYUTydBCZ1ML3e6ZffS08TCwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qkGLPt/1xtZoj3tuRB86PlrXUCUAHZ/gZzD5Jnz+pI=;
 b=uJpKsfQkkZ5fTyxeBwjyHePkl/J3DF5u169hnyAzGkPYWm5zgf804irjvK+GyMvWaJ6DUU9jVCOmSzaYQUX5Tjx0yGVwKNG8uvTMaQq7SE1fQ6q4LiK0dPcGAuokylGIPNvCXWT8FFONG0I2lSiZo9M564pzLSyCIWIi4Gr6wdk=
Received: from MN0P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::7)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:00 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::2) by MN0P223CA0009.outlook.office365.com
 (2603:10b6:208:52b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:18:59 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:56 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Yihan Zhu
 <yihan.zhu@amd.com>
Subject: [PATCH 11/49] drm/amd/display: revert "convert dcn42 GPIO translation
 to lookup tables"
Date: Thu, 23 Jul 2026 16:13:19 -0400
Message-ID: <20260723201908.373300-12-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 63aa313d-05f9-49c5-b91f-08dee8f7a189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: k2FwPGMyD+pMkvGQ6eYsQj+RMdrBaq6N17VYeeXVlzQTj3UiouGeCoDkgq0cws0nqZUNBX4ckSIlLJdNk2P5AzPs9Vu4tUBjKdJZ/cNVT5zcEhMw6tQ6UilRoWUAGv0WXOuiZ8cAj3++F8Ie5CxWAr1DysfCpiThUP/aixxmdlrjPjKRc6KmgIQ3SsgSsaPzfqB4JotiTUZkKQj+Sh+iONP6zr7wxoD6jat+kxB1ze/WJdxZo26u9q0N0X9Xw96tS4h5rnboN7gN0NfMtnRS8+hOdQ2pVytUJcGadPTBWMCGmu13NJLyxetXJ84oLj2AWpnK9epMmlUptRn5HuIarhA6bXz4HZYhsHvylDZtjDUE+KxtEKdT9HAuCQTSJPVSblaMioD/Cy/M2ks6oiMyZEeMbTRb2dluxLJ/jywKqJEkhGRuWca2uzxHeJ1Wd8unl/ROP5H4kSaCBW/LFB8bgwSDTg/VjMkrGyeP7h/MkONo0CfeCxPQFNzOXPKYxGDWjEq1nrhCsE1KuD6GkwBNp2bimwLQkc1oZ+4cN9hZlIRT6XLUvbtPYSQfdPGNSCtfOR1aNap6nkq7y8YUJ5et4Lv/0jmSBbWFWW+dVEL7qiHZIqg+UdGlNjnlmgiHn4GlPb+UiwPfQRXv2pno6ewYrpNcmOv5mXRI6o8cSWMvdirAFz+BcEXw2LC7qJaVDvvcUMNBMjQJTwEztLa5T9zOeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K9Lprqo9v/4oJxx9CMx8ypNNQIHqATQ72Q1Zkqc3u9cKdarADRr+u6EdGB3geDeGA48JbYVwIp8JXcXxkccex/GLt1ZbaI3+E7EqCcuWEN7VkXZrXnINUh864aRouBfEMHBzk51ZvwJd+dJncOrTkswT+EwBChxLUU05H52P3nM6htHu3SI/Y99BDidvwxtrtpU5WWMsLKEO7Ar2WPIQFlcvXm5rol5w0ZNf1Sl0PgNWtVWABQi9RCW4LafdXdBZnyNXfuvuUfmzgxrgbG2OVRVyGY9q+WXjUijJrWkgoL+wJrhfuYZN1tqpoHvpyG0Qij7txQ5Ro60SI9dxhDRoHiSSIQ1Tr2a72r7Tx9MT7uAwtKYkq9htZgrY3ewWzC3BwO4aUE9PO3xor2vYv3JsogmPFeAkJy1n2jRSG7Z90AbcUUTkImXqLT7yZBwTWB0d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:18:59.7467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63aa313d-05f9-49c5-b91f-08dee8f7a189
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
This reverts commit b536028ffbce3c3f026ba7c9b42b8f66cfb186e9.

Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../dc/gpio/dcn42/hw_translate_dcn42.c        | 193 +++++++++++-------
 .../dc/gpio/dcn42/hw_translate_dcn42.c.orig   | 153 ++++++++++++++
 2 files changed, 276 insertions(+), 70 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
index 7b2c4cd42450..e7e1d9979876 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
@@ -39,76 +39,62 @@
  * end *********************/
 
 
-static const struct gpio_id_offset_entry gpio_offsets[] = {
-	/* HPD */
-	GPIO_ENTRY(HPD0_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_1),
-	GPIO_ENTRY(HPD1_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_2),
-	GPIO_ENTRY(HPD2_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_3),
-	GPIO_ENTRY(HPD3_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_4),
-	GPIO_ENTRY(HPD4_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_5),
-};
-
-
-/* DDC */
-static const struct gpio_ddc_offset_entry ddc_offset_map[] = {
-	{ REG(DC_GPIO_DDC1_A), GPIO_DDC_LINE_DDC1 },
-	{ REG(DC_GPIO_DDC2_A), GPIO_DDC_LINE_DDC2 },
-	{ REG(DC_GPIO_DDC3_A), GPIO_DDC_LINE_DDC3 },
-	{ REG(DC_GPIO_DDC4_A), GPIO_DDC_LINE_DDC4 },
-	{ REG(DC_GPIO_DDC5_A), GPIO_DDC_LINE_DDC5 },
-	{ REG(DC_GPIO_DDCVGA_A), GPIO_DDC_LINE_DDC_VGA },
-};
-
-
-static const struct gpio_pin_entry gpio_pins[] = {
-	/* DDC */
-	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC1,
-		DC_GPIO_DDC1_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
-	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC2,
-		DC_GPIO_DDC2_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
-	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC3,
-		DC_GPIO_DDC3_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
-	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC4,
-		DC_GPIO_DDC4_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
-	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC5,
-		DC_GPIO_DDC5_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
-	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC_VGA,
-		DC_GPIO_DDCVGA_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
-	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC1,
-		DC_GPIO_DDC1_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
-	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC2,
-		DC_GPIO_DDC2_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
-	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC3,
-		DC_GPIO_DDC3_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
-	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC4,
-		DC_GPIO_DDC4_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
-	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC5,
-		DC_GPIO_DDC5_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
-	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC_VGA,
-		DC_GPIO_DDCVGA_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
-};
-
-
 static bool offset_to_id(
 	uint32_t offset,
 	uint32_t mask,
 	enum gpio_id *id,
 	uint32_t *en)
 {
-	if (dal_hw_translate_gpio_ddc_offset_to_id(
-			ddc_offset_map,
-			ARRAY_SIZE(ddc_offset_map),
-			offset, en))
+	(void)mask;
+	switch (offset) {
+	/* HPD */
+	case REG(HPD0_DC_HPD_INT_STATUS):
+		*id = GPIO_ID_HPD;
+		*en = GPIO_HPD_1;
 		return true;
-
-	if (dal_hw_translate_gpio_offset_to_id(
-			gpio_offsets,
-			ARRAY_SIZE(gpio_offsets),
-			offset, mask, id, en))
+	case REG(HPD1_DC_HPD_INT_STATUS):
+		*id = GPIO_ID_HPD;
+		*en = GPIO_HPD_2;
 		return true;
-
-	ASSERT_CRITICAL(false);
-	return false;
+	case REG(HPD2_DC_HPD_INT_STATUS):
+		*id = GPIO_ID_HPD;
+		*en = GPIO_HPD_3;
+		return true;
+	case REG(HPD3_DC_HPD_INT_STATUS):
+		*id = GPIO_ID_HPD;
+		*en = GPIO_HPD_4;
+		return true;
+	case REG(HPD4_DC_HPD_INT_STATUS):
+		*id = GPIO_ID_HPD;
+		*en = GPIO_HPD_5;
+		return true;
+	/* DDC */
+	/* we don't care about the GPIO_ID for DDC
+	 * in DdcHandle it will use GPIO_ID_DDC_DATA/GPIO_ID_DDC_CLOCK
+	 * directly in the create method
+	 */
+	case REG(DC_GPIO_DDC1_A):
+		*en = GPIO_DDC_LINE_DDC1;
+		return true;
+	case REG(DC_GPIO_DDC2_A):
+		*en = GPIO_DDC_LINE_DDC2;
+		return true;
+	case REG(DC_GPIO_DDC3_A):
+		*en = GPIO_DDC_LINE_DDC3;
+		return true;
+	case REG(DC_GPIO_DDC4_A):
+		*en = GPIO_DDC_LINE_DDC4;
+		return true;
+	case REG(DC_GPIO_DDC5_A):
+		*en = GPIO_DDC_LINE_DDC5;
+		return true;
+	case REG(DC_GPIO_DDCVGA_A):
+		*en = GPIO_DDC_LINE_DDC_VGA;
+		return true;
+	default:
+		ASSERT_CRITICAL(false);
+		return false;
+	}
 }
 
 
@@ -117,14 +103,81 @@ static bool id_to_offset(
 	uint32_t en,
 	struct gpio_pin_info *info)
 {
-	if (dal_hw_translate_id_to_offset(
-			gpio_pins,
-			ARRAY_SIZE(gpio_pins),
-			id, en, info))
-		return true;
-
-	ASSERT_CRITICAL(false);
-	return false;
+	bool result = true;
+
+	switch (id) {
+	case GPIO_ID_DDC_DATA:
+		info->mask = DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK;
+		switch (en) {
+		case GPIO_DDC_LINE_DDC1:
+			info->offset = REG(DC_GPIO_DDC1_A);
+		break;
+		case GPIO_DDC_LINE_DDC2:
+			info->offset = REG(DC_GPIO_DDC2_A);
+		break;
+		case GPIO_DDC_LINE_DDC3:
+			info->offset = REG(DC_GPIO_DDC3_A);
+		break;
+		case GPIO_DDC_LINE_DDC4:
+			info->offset = REG(DC_GPIO_DDC4_A);
+		break;
+		case GPIO_DDC_LINE_DDC5:
+			info->offset = REG(DC_GPIO_DDC5_A);
+		break;
+		case GPIO_DDC_LINE_DDC_VGA:
+			info->offset = REG(DC_GPIO_DDCVGA_A);
+		break;
+		case GPIO_DDC_LINE_I2C_PAD:
+		default:
+			ASSERT_CRITICAL(false);
+			result = false;
+		}
+	break;
+	case GPIO_ID_DDC_CLOCK:
+		info->mask = DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK;
+		switch (en) {
+		case GPIO_DDC_LINE_DDC1:
+			info->offset = REG(DC_GPIO_DDC1_A);
+		break;
+		case GPIO_DDC_LINE_DDC2:
+			info->offset = REG(DC_GPIO_DDC2_A);
+		break;
+		case GPIO_DDC_LINE_DDC3:
+			info->offset = REG(DC_GPIO_DDC3_A);
+		break;
+		case GPIO_DDC_LINE_DDC4:
+			info->offset = REG(DC_GPIO_DDC4_A);
+		break;
+		case GPIO_DDC_LINE_DDC5:
+			info->offset = REG(DC_GPIO_DDC5_A);
+		break;
+		case GPIO_DDC_LINE_DDC_VGA:
+			info->offset = REG(DC_GPIO_DDCVGA_A);
+		break;
+		case GPIO_DDC_LINE_I2C_PAD:
+		default:
+			ASSERT_CRITICAL(false);
+			result = false;
+		}
+	break;
+	case GPIO_ID_SYNC:
+	case GPIO_ID_VIP_PAD:
+	default:
+		ASSERT_CRITICAL(false);
+		result = false;
+	}
+
+	if (result) {
+		info->offset_y = info->offset + 2;
+		info->offset_en = info->offset + 1;
+		info->offset_mask = info->offset - 1;
+
+		info->mask_y = info->mask;
+		info->mask_en = info->mask;
+		info->mask_mask = info->mask;
+	}
+
+	return result;
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig
new file mode 100644
index 000000000000..7b2c4cd42450
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#include "hw_translate_dcn42.h"
+
+#include "dm_services.h"
+#include "include/gpio_types.h"
+#include "../hw_translate.h"
+
+
+#include "dcn/dcn_4_2_0_offset.h"
+#include "dcn/dcn_4_2_0_sh_mask.h"
+#include "dpcs/dpcs_4_0_0_offset.h"
+#include "dpcs/dpcs_4_0_0_sh_mask.h"
+
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+
+/* begin *********************
+ * macros to expend register list macro defined in HW object header file */
+
+/* DCN */
+#define block HPD
+#define reg_num 0
+
+#undef BASE_INNER
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
+
+#define BASE(seg) BASE_INNER(seg)
+
+#undef REG
+#define REG(reg_name)\
+		(BASE(reg ## reg_name ## _BASE_IDX) + reg ## reg_name)
+#define SF_HPD(reg_name, field_name, post_fix)\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+
+/* macros to expend register list macro defined in HW object header file
+ * end *********************/
+
+
+static const struct gpio_id_offset_entry gpio_offsets[] = {
+	/* HPD */
+	GPIO_ENTRY(HPD0_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_1),
+	GPIO_ENTRY(HPD1_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_2),
+	GPIO_ENTRY(HPD2_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_3),
+	GPIO_ENTRY(HPD3_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_4),
+	GPIO_ENTRY(HPD4_DC_HPD_INT_STATUS, GPIO_ID_HPD, GPIO_HPD_5),
+};
+
+
+/* DDC */
+static const struct gpio_ddc_offset_entry ddc_offset_map[] = {
+	{ REG(DC_GPIO_DDC1_A), GPIO_DDC_LINE_DDC1 },
+	{ REG(DC_GPIO_DDC2_A), GPIO_DDC_LINE_DDC2 },
+	{ REG(DC_GPIO_DDC3_A), GPIO_DDC_LINE_DDC3 },
+	{ REG(DC_GPIO_DDC4_A), GPIO_DDC_LINE_DDC4 },
+	{ REG(DC_GPIO_DDC5_A), GPIO_DDC_LINE_DDC5 },
+	{ REG(DC_GPIO_DDCVGA_A), GPIO_DDC_LINE_DDC_VGA },
+};
+
+
+static const struct gpio_pin_entry gpio_pins[] = {
+	/* DDC */
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC1,
+		DC_GPIO_DDC1_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC2,
+		DC_GPIO_DDC2_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC3,
+		DC_GPIO_DDC3_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC4,
+		DC_GPIO_DDC4_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_DATA, GPIO_DDC_LINE_DDC_VGA,
+		DC_GPIO_DDCVGA_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC1,
+		DC_GPIO_DDC1_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC2,
+		DC_GPIO_DDC2_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC3,
+		DC_GPIO_DDC3_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC4,
+		DC_GPIO_DDC4_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC5,
+		DC_GPIO_DDC5_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+	GPIO_PIN_ENTRY(GPIO_ID_DDC_CLOCK, GPIO_DDC_LINE_DDC_VGA,
+		DC_GPIO_DDCVGA_A, DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK),
+};
+
+
+static bool offset_to_id(
+	uint32_t offset,
+	uint32_t mask,
+	enum gpio_id *id,
+	uint32_t *en)
+{
+	if (dal_hw_translate_gpio_ddc_offset_to_id(
+			ddc_offset_map,
+			ARRAY_SIZE(ddc_offset_map),
+			offset, en))
+		return true;
+
+	if (dal_hw_translate_gpio_offset_to_id(
+			gpio_offsets,
+			ARRAY_SIZE(gpio_offsets),
+			offset, mask, id, en))
+		return true;
+
+	ASSERT_CRITICAL(false);
+	return false;
+}
+
+
+static bool id_to_offset(
+	enum gpio_id id,
+	uint32_t en,
+	struct gpio_pin_info *info)
+{
+	if (dal_hw_translate_id_to_offset(
+			gpio_pins,
+			ARRAY_SIZE(gpio_pins),
+			id, en, info))
+		return true;
+
+	ASSERT_CRITICAL(false);
+	return false;
+}
+
+
+/* function table */
+static const struct hw_translate_funcs funcs = {
+	.offset_to_id = offset_to_id,
+	.id_to_offset = id_to_offset,
+};
+
+
+/*
+ * dal_hw_translate_dcn42_init
+ *
+ * @brief
+ * Initialize Hw translate function pointers.
+ *
+ * @param
+ * struct hw_translate *tr - [out] struct of function pointers
+ *
+ */
+void dal_hw_translate_dcn42_init(struct hw_translate *tr)
+{
+	tr->funcs = &funcs;
+}
+
+
-- 
2.53.0

