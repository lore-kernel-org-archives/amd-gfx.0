Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1116DC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0690110E584;
	Wed,  9 Nov 2022 06:17:39 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E6210E582
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1X4ekpL4Cx0JhbxVfKpsoiFZ4+QqOxkMhmyMPTJWV3SNNqvkPcWamze1j4pVsV/k5A4kmNIaSL0jabow5CfxfyIzroxP+yPcFDCS5vS+ekbQCEzlkmy8ioOLhcyR7PItfXglGbT3GdEhERGXy6TjqLc3m18yd1tlHIQdDzjqsWB6JyAxLUs4NKBfTs1VGGk56zlO9jm4WfzxX0gkO296u1DwTowx0rCeoJZN7P1LAWarJa1JodKq1dlQn0mRfz3oLcpFWtjtBG39JR/gSNXJRio6gxdbFTTcjZhMBG7O7z7wWY8dkAIBgN1ajnJGw5LNHpxPNmpxvRKGodoG0HY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eG6ft2TlXfwKQBIBOgBoAagi+JY0WLtXbRaY9MMzscA=;
 b=UgxDtSDteb8+NpV8jGuHWSONePPc+bWMP2MFX7M6KQedIZX+Nun0B0mhriFk+3wArJeH6zUzj1TJRX5ilUms7NUfN3QcIgSquZ8xMIy8GIL+LTTUfDtOJ4IDKISTTkXEYa+kYgHry9bs4ThcWVQTOl8b5bckxkW3Kam01DFXiFXZvO2NB9cLL1TLNRXgV0eHAaqgjddYnRV4GPdjSBtOmNKVOijmG+lXiAKrk5v2Eqh4E9PAdUhr+5SRM/ZiAtwCIafMH1ArwDKHzlZlzASHl0a5qF9nQXG88IXhOTDWUFwq7K0RzaZv2c7oxv189MmHyVM7neAzdgtBufBhSgXnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eG6ft2TlXfwKQBIBOgBoAagi+JY0WLtXbRaY9MMzscA=;
 b=xDuifGUUFnMNcbny3z4batT5SWH3R/TK8jVd9c3wDo0Cf+6h8L4eep0njK6pMo37xBv38v6X1rdJqNpzUlGmAVKoda4E525x4sb20ETU5ZgCoa0eOlc7Fy7f1wBoSe0Co1somdSyetwxXWHkq6xF+4LPW5OJzaA4R2vW4dEjcf0=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:17:31 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::71) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Wed, 9 Nov 2022 06:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:17:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:17:29 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:17:02 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:16:53 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/29] drm/amd/display: fix array index out of bound error in
 bios parser
Date: Wed, 9 Nov 2022 14:13:10 +0800
Message-ID: <20221109061319.2870943-21-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1965f5-9455-4563-2fef-08dac21a1568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: houiSipBp1LNIeNy0BauEb6/SucdYSo8o1EkO+RJYo0MdCuZ3QiW7oSAxa1NY0AVdaY9bYBHmlilbVptIkI4zKqCLYPUdgo32tjk1fuzX5wVG0VLR7PnddDfRND5x2HZ6OCC0bhm4nZorkAzZz6i0ZjSaK492jr/9bnyiKgvs3uqRn/YV+Kg2zjfWJaBNPUgjq+OUEnqESqDMg9wNdecBAros5ep9iR3+uI+331tt+uPhVWhGUXJaiCzKP8lB4MXQek6wEGs8g2orkHgENr4cHkN9XYDNqUHuI1Y+WoDGECMY+LXeVaQnLAkElBu0wNaVVJDq907BzWfGGbpiPSYKmwmft7nGENilFKeQD59Cy+HfVIcBCAVcbx7qLcimlciVbqjZN+gUaJ0+MDC2h/LnuE3fvkWaO+uIa82SLIVjlCHiy+YNfsjjqhDJNLkc1r1y+rQqPXgYMKfX+sm8W79pMZmGyCeaz1/+vzgNHm4Eh+NUFXcD6KFr5CJKUZQXoBthLCEtlMpXstB64Pdm0FtEkES2MNc/uyocrAFE6vIzJwEm9OqFMPcABpDhlbi2ZgvYMNzK3hW/990/eNnZr/wDOVynQDx9kfH4qfoUB+oaKD4Xv4gE5iK4b2XbNTG45TCoVXn3u3Eu1Co9LHhdQtUmItYuJbj4h3VTQL5oxJfpxzMgffl4bENlnd23tNi9ZqnURGvorv5korp1zBXIfhHudV0VBmDI+ZhTCCs2kNXDfKYbMsi2TLt2rcAB4MmkX1pxSvE0h11QTpAlQBDfUye4R03YlFPMiA4W1Cbe2YZ/V6bmWGtFOqCmQ+SEqJii0QY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(36756003)(7696005)(26005)(336012)(478600001)(2616005)(6666004)(81166007)(2906002)(1076003)(186003)(40460700003)(356005)(40480700001)(82740400003)(86362001)(426003)(83380400001)(47076005)(82310400005)(36860700001)(8676002)(4326008)(70586007)(316002)(54906003)(6916009)(41300700001)(5660300002)(70206006)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:17:30.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1965f5-9455-4563-2fef-08dac21a1568
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Firmware headers dictate that gpio_pin array only has a size of 8. The
count returned from vbios however is greater than 8.

Fix this by not using array indexing but incrementing the pointer since
gpio_pin definition in atomfirmware.h is hardcoded to size 8

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser2.c   | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index e0c8d6f09bb4..074e70a5c458 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -462,6 +462,7 @@ static enum bp_result get_gpio_i2c_info(
 	uint32_t count = 0;
 	unsigned int table_index = 0;
 	bool find_valid = false;
+	struct atom_gpio_pin_assignment *pin;
 
 	if (!info)
 		return BP_RESULT_BADINPUT;
@@ -489,20 +490,17 @@ static enum bp_result get_gpio_i2c_info(
 			- sizeof(struct atom_common_table_header))
 				/ sizeof(struct atom_gpio_pin_assignment);
 
+	pin = (struct atom_gpio_pin_assignment *) header->gpio_pin;
+
 	for (table_index = 0; table_index < count; table_index++) {
-		if (((record->i2c_id & I2C_HW_CAP) == (
-		header->gpio_pin[table_index].gpio_id &
-						I2C_HW_CAP)) &&
-		((record->i2c_id & I2C_HW_ENGINE_ID_MASK)  ==
-		(header->gpio_pin[table_index].gpio_id &
-					I2C_HW_ENGINE_ID_MASK)) &&
-		((record->i2c_id & I2C_HW_LANE_MUX) ==
-		(header->gpio_pin[table_index].gpio_id &
-						I2C_HW_LANE_MUX))) {
+		if (((record->i2c_id & I2C_HW_CAP) 				== (pin->gpio_id & I2C_HW_CAP)) &&
+		    ((record->i2c_id & I2C_HW_ENGINE_ID_MASK)	== (pin->gpio_id & I2C_HW_ENGINE_ID_MASK)) &&
+		    ((record->i2c_id & I2C_HW_LANE_MUX) 		== (pin->gpio_id & I2C_HW_LANE_MUX))) {
 			/* still valid */
 			find_valid = true;
 			break;
 		}
+		pin = (struct atom_gpio_pin_assignment *)((uint8_t *)pin + sizeof(struct atom_gpio_pin_assignment));
 	}
 
 	/* If we don't find the entry that we are looking for then
-- 
2.25.1

