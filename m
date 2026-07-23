Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1059FC531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 908C210F1EC;
	Thu, 23 Jul 2026 20:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZlwmxVeH";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D0D10F1EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qu01opQr8LbrZ17MGtzcS3YNbPyuFBV7RUq/12Axlhl7zfQ4hfbepj6huSsRBjOGDqtiPLrALa/Zsib8OrlUCepgdevgHmnEy0IqsEbEvea4FhEqeuR2zEP7q3a8nJp125/soKxf1KnPdFRkT3V/KcOuRGNAVMmJ9SmtkDpmJ8RsIcEmKwammQBoF/n/G22sZG/0nYEiSMSg8oLwRFi+AXchNIgDpn7Jlt6zuAYMwqIJqZw5wsAXnlEyd/MG0bXxe6dvPGvgAxn77FPIMyPI7jXyOEFvmfi1YQSNjJmRlDjgL5qqgTWOrS3zmSOquTOi2IbIF4TrfIQrmcoW9sdeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBDXnCyprJNX41Igpoo13Z9zJFXxNt3FqFIbK7OsNIM=;
 b=c897xBpaKxAt3p4EdmDsl90igZZcxFZi8aGLUBzNvZX1Ffe9ac7rvJN3TThufc5poUzyyPBYkvy1jpqFLxuqQMM6ViT/+3mEHk+7u01JL6AHuuzFbUUdHVvH0Z4M4GBniiMxsT0YguM+yj52tbvZna369zesxa+HwH2oGZvo/yBg/1aW/fKc5UgKASEDFqldYkpdviTkqbt0gpBZM50liPPlmt0c9nhcwWlY7/NLDz2kmN702t7YtTknxL0CjXJKNBOBeGCdWFcCsLr9oG8dizMNafch7b6Wx2qk7LW9CP7uH6s1um02kLFWZ/ZDgYGe1sQtUlIGEB+s/88maEccxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBDXnCyprJNX41Igpoo13Z9zJFXxNt3FqFIbK7OsNIM=;
 b=ZlwmxVeH0OkoVXqNyk1/GkuxmX4lXS4yaBfIegTmzwwOjbVjcW03BddHCiyM2FM8touiiifK4k8lEhlUkKE184QvDu8PxLxHyMTKkhengyp4ODwPrONsvo3wi5UTSUYnbOJOLK9fz6bgrN5EW9a5wvEoVWeyAqO5SHOaFcRZoZ8=
Received: from BN1PR12CA0022.namprd12.prod.outlook.com (2603:10b6:408:e1::27)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:35 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::52) by BN1PR12CA0022.outlook.office365.com
 (2603:10b6:408:e1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:35 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:16 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Carbones <Nicholas.Carbones@amd.com>,
 Michael Strauss <michael.strauss@amd.com>
Subject: [PATCH 37/49] drm/amd/display: Reintroduce "convert dcn42 GPIO
 translation to lookup tables"
Date: Thu, 23 Jul 2026 16:13:45 -0400
Message-ID: <20260723201908.373300-38-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6430d1-9ccc-4dd8-3b10-08dee8f7b6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7gwlAl9Ke7dwh9Ba6GZYp9INskf0EQqYeHItm09XjxtdzXzn+12L4gPWZMCOAdO/BbqEmW69mSBXZx7AFTO4OYA3FMQcpJOLezmrgIAMVbNkQCNEYR06YR53X1khRdgAniToQqd3qKp54lHWE9lEEIx6D6Ikv7lmIKUTUOGe+r0mQD7HBYzBXcFBHmJofneeVnRpN7OwBPSVvaD5XjX6KiAObpQDKJpTPHjsc7XqvhGjHykYkG6z4YQcVKxUMAYjaDWk8l7K/LYyi62k0Te6cdSOF+HZhMElGZAEpe1fWmJdwpIsqkjD3W9YGYOVAYAp0e+A74L7CMbAzNz2aUsXx4aWwr+G34TwGyyEzHz2/1rm43YqpwI4FO5C2/eud0XTr3cOn637aGSSxCLyX1AbHao7mZM1S4JdFi0VT2yn/5SYuRW/ZZriIqZeTOfyU6H/vlYM8D0z3qTESHfq9IoAPFuU9a3EBWPmloUvJulAEE2Km+gM2EBMAiZOHHYMZl/wg0c/3AluGqZbWaYrVOrlvdmNoFszHqTaz1HfwmK9JSh4ykHxkh1L2pGrJ/DELKBo4H7LKSgA71sCxrysW3rbnsL+lwdYWBpo3et+QrZIAfn+qjNv49Rot29dLE1iYRPYPkr83blfq7Y3txvRDf9fqP3r7bCp5cHiLNCGuziKWj08rDF18iP+gozny3F+BdfTL1VQN1+nlRN1lmUNUuZgtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u5TR+tQgnjdxTQnWbzl1TlSH/vYZHtUlIhQMGjSkYMQdA/k+sHNjVKTFGOlo6m68noZDEQID5aIJnhT8G8OFBsHMBk5hCe2en50iMuCA4zMJ0jLeUUJKhmFAt7N4d39m/0qhUjsAFTuBWYhEH2Lim2xq/f1vGUNFpTfIMcHR1rxELcHU7R9rqL5HEbPgoxkEIHABwiJlvS6p774nLxRHJCpwzGJFxGxbZX/eIjWHqJgk3R7GKg7wltPioYcYCAfngs97c6FuRbsdg4EZ8zR1bazUJIGZd/emHvdAANuOGt80xPAF/4KhwGN+KCJUFIHHivQG2L53f3f/kfUv+XA0FJzbFXqSkIk0nDJdMKd3b1YInTtWbTdEbCXAN8MzMT0pBezw87n4ykZV6ZUe4Q/t9+xgXRkf4CRShDkd8JA7SXgJsRyM2PIY0oSrr7oCshpX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:35.3049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6430d1-9ccc-4dd8-3b10-08dee8f7b6bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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

From: Nicholas Carbones <Nicholas.Carbones@amd.com>

This reverts commit c371d98717539f687e6d96a63c74a7beb764c138.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Nicholas Carbones <Nicholas.Carbones@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../dc/gpio/dcn42/hw_translate_dcn42.c        | 193 +++++++-----------
 .../dc/gpio/dcn42/hw_translate_dcn42.c.orig   | 193 +++++++++++-------
 2 files changed, 193 insertions(+), 193 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
index e7e1d9979876..7b2c4cd42450 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
@@ -39,62 +39,76 @@
  * end *********************/
 
 
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
 static bool offset_to_id(
 	uint32_t offset,
 	uint32_t mask,
 	enum gpio_id *id,
 	uint32_t *en)
 {
-	(void)mask;
-	switch (offset) {
-	/* HPD */
-	case REG(HPD0_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_1;
-		return true;
-	case REG(HPD1_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_2;
+	if (dal_hw_translate_gpio_ddc_offset_to_id(
+			ddc_offset_map,
+			ARRAY_SIZE(ddc_offset_map),
+			offset, en))
 		return true;
-	case REG(HPD2_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_3;
-		return true;
-	case REG(HPD3_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_4;
-		return true;
-	case REG(HPD4_DC_HPD_INT_STATUS):
-		*id = GPIO_ID_HPD;
-		*en = GPIO_HPD_5;
-		return true;
-	/* DDC */
-	/* we don't care about the GPIO_ID for DDC
-	 * in DdcHandle it will use GPIO_ID_DDC_DATA/GPIO_ID_DDC_CLOCK
-	 * directly in the create method
-	 */
-	case REG(DC_GPIO_DDC1_A):
-		*en = GPIO_DDC_LINE_DDC1;
-		return true;
-	case REG(DC_GPIO_DDC2_A):
-		*en = GPIO_DDC_LINE_DDC2;
-		return true;
-	case REG(DC_GPIO_DDC3_A):
-		*en = GPIO_DDC_LINE_DDC3;
-		return true;
-	case REG(DC_GPIO_DDC4_A):
-		*en = GPIO_DDC_LINE_DDC4;
-		return true;
-	case REG(DC_GPIO_DDC5_A):
-		*en = GPIO_DDC_LINE_DDC5;
-		return true;
-	case REG(DC_GPIO_DDCVGA_A):
-		*en = GPIO_DDC_LINE_DDC_VGA;
+
+	if (dal_hw_translate_gpio_offset_to_id(
+			gpio_offsets,
+			ARRAY_SIZE(gpio_offsets),
+			offset, mask, id, en))
 		return true;
-	default:
-		ASSERT_CRITICAL(false);
-		return false;
-	}
+
+	ASSERT_CRITICAL(false);
+	return false;
 }
 
 
@@ -103,81 +117,14 @@ static bool id_to_offset(
 	uint32_t en,
 	struct gpio_pin_info *info)
 {
-	bool result = true;
-
-	switch (id) {
-	case GPIO_ID_DDC_DATA:
-		info->mask = DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK;
-		switch (en) {
-		case GPIO_DDC_LINE_DDC1:
-			info->offset = REG(DC_GPIO_DDC1_A);
-		break;
-		case GPIO_DDC_LINE_DDC2:
-			info->offset = REG(DC_GPIO_DDC2_A);
-		break;
-		case GPIO_DDC_LINE_DDC3:
-			info->offset = REG(DC_GPIO_DDC3_A);
-		break;
-		case GPIO_DDC_LINE_DDC4:
-			info->offset = REG(DC_GPIO_DDC4_A);
-		break;
-		case GPIO_DDC_LINE_DDC5:
-			info->offset = REG(DC_GPIO_DDC5_A);
-		break;
-		case GPIO_DDC_LINE_DDC_VGA:
-			info->offset = REG(DC_GPIO_DDCVGA_A);
-		break;
-		case GPIO_DDC_LINE_I2C_PAD:
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_DDC_CLOCK:
-		info->mask = DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK;
-		switch (en) {
-		case GPIO_DDC_LINE_DDC1:
-			info->offset = REG(DC_GPIO_DDC1_A);
-		break;
-		case GPIO_DDC_LINE_DDC2:
-			info->offset = REG(DC_GPIO_DDC2_A);
-		break;
-		case GPIO_DDC_LINE_DDC3:
-			info->offset = REG(DC_GPIO_DDC3_A);
-		break;
-		case GPIO_DDC_LINE_DDC4:
-			info->offset = REG(DC_GPIO_DDC4_A);
-		break;
-		case GPIO_DDC_LINE_DDC5:
-			info->offset = REG(DC_GPIO_DDC5_A);
-		break;
-		case GPIO_DDC_LINE_DDC_VGA:
-			info->offset = REG(DC_GPIO_DDCVGA_A);
-		break;
-		case GPIO_DDC_LINE_I2C_PAD:
-		default:
-			ASSERT_CRITICAL(false);
-			result = false;
-		}
-	break;
-	case GPIO_ID_SYNC:
-	case GPIO_ID_VIP_PAD:
-	default:
-		ASSERT_CRITICAL(false);
-		result = false;
-	}
-
-	if (result) {
-		info->offset_y = info->offset + 2;
-		info->offset_en = info->offset + 1;
-		info->offset_mask = info->offset - 1;
-
-		info->mask_y = info->mask;
-		info->mask_en = info->mask;
-		info->mask_mask = info->mask;
-	}
-
-	return result;
+	if (dal_hw_translate_id_to_offset(
+			gpio_pins,
+			ARRAY_SIZE(gpio_pins),
+			id, en, info))
+		return true;
+
+	ASSERT_CRITICAL(false);
+	return false;
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig
index 7b2c4cd42450..e7e1d9979876 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig
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
 
 
-- 
2.53.0

