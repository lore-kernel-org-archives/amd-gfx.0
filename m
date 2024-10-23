Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA56D2E014
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032B010E721;
	Wed, 23 Oct 2024 04:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bWN2+TK/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B1D10E72C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLUhol27uLGgljokwqyIpER/PeFl6qOK7KHRCGPCENUN5QiCICdOXsNElhzNQk9OAguBq6axldgo+kGTx6kGVuJioBdx7K550i80tHiD+2EHKs99zdgrA+1RxlqGEoqMThA9IanUPMy0dCkbtSBb3jdcjUVqaghEqz4v3rPetftqOY8vlrBikBfdtcNk3n159jYQhhByRA48AvfG/2yyylJGbzDtkCVeZ8baRQn8ONIVo8UPEFUpFs9bUYKw8+xTjuMFypqxSMIUBmXDEsxH0OD4ia8PiHWTrzBxootMzDpUg76B0wCtvgtXt76hwWb6UvNDkGWovvnE87ncw2OL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1lQRDcUWi/qh7zQ798J0h/RN0LZL8vGbO93+8EJ58c=;
 b=eqw32upJ5KE4aUM1ONNDFpe3a8m7BgPwsDJtrq8INvnPvIzbeS+jJdNY57ENHirvKdo0Uru2UEZrau08RG3H+mZVxYhYfMyamNAQUSk25zUJ50f9yMSgOh18unYSHqAaC9QxoXKVvNGGe0CwhsnJXvtFyNV1DpiWk5ngRJ6ZE1AdicZYV7dRVb3LIY5b5BPDalyU1fQhLJePxhMJoqULe3x9sVAVvRKLG8NniAsNc8gALinZOhHIXj8PGrGKTVelmUHLpVNGI9wYaCOGMh506sd0PtTFQ3Xm1IdbIBWQ/bPAmE0Qzab/83aGwaPyc3huMXAI5oKtduTf0OLi3R6pyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1lQRDcUWi/qh7zQ798J0h/RN0LZL8vGbO93+8EJ58c=;
 b=bWN2+TK/6PFQF40ImdntIQA7ccE0+77kWZOrkE1QhrzTgwh78CMe65wix3yaRirGA+pK4gjEKFPh12ArkrSBNPNUNmSonZwiPAP2DvXPytdWU1mXQS8HxntjPMsO7WzV3mItHjtRiZpleyENoBjTeexpjfCLknTZyfztXQX8b7o=
Received: from PH7P220CA0084.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::7)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 04:55:06 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::41) by PH7P220CA0084.outlook.office365.com
 (2603:10b6:510:32c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 04:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:55:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:55:04 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:55:01 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 15/16] drm/amd/display: [FW Promotion] Release 0.0.240.0
Date: Wed, 23 Oct 2024 12:53:35 +0800
Message-ID: <20241023045336.1557443-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eaf3f0a-f7fd-4d6e-12a7-08dcf31edce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4d9cAgaMgAcPcNCvCXbv1Gs8mstcSw9RNDwxwStgpKmR9NFMGbnNb0ZZ+E/B?=
 =?us-ascii?Q?vzdK6wc2tTA+wc6in9EPYObYWj2q+2loam1aJB2V1iDxyQjpkm3lEkBpvJc6?=
 =?us-ascii?Q?DUkKa7a7StYowandyQpNGVBEkvsPF3+IXPxWgwN/g9oAJ63Ef/4HhbgeVMm+?=
 =?us-ascii?Q?SOszKmfICoImutfVuK6IyL8Zep4AiVSGXIKeNiFS2zrFaVEWEUlTffdKc4WX?=
 =?us-ascii?Q?vnOpRDjlmrrBwm71cEaOiVVTmT9TFi0X1U3gddsK4QO4xaq/ChZl7Hy5ofCr?=
 =?us-ascii?Q?Zb10Cm+KOtTUKxYqNQcgd+Vvg9X/BUvU4/4txciXl0QfDQjVFs33PF09dtat?=
 =?us-ascii?Q?rvds7PMAEkzhAYlojk0l0fmliOIKHmKjRPzpn6LWng/FjEcj6rOJNh9xye/B?=
 =?us-ascii?Q?k37HB+WfW+xzhW1C0+n+v3JY0dnggRvqJrJdpCyVL9bh7ZyV0eBURpAaCaxZ?=
 =?us-ascii?Q?I/GqAQkrMv70U1uaWpJUoCh96JsB1TYw811vKbPPjH5365vUuRmedpYtY85d?=
 =?us-ascii?Q?xYY4+Y6FAsxTOvf5jxRrdQb3c63lfq6XXZJxpCIoP7YzIdGg0VOIY5hjVTC9?=
 =?us-ascii?Q?XZeN5VZajTjKkAYEhFIFXEGE/wBUFIu8SdyzgXXHLrzue2TlFOrCooCQXHDl?=
 =?us-ascii?Q?YJgqQXkI+6p32xNVZV1P6otrMgnENrcpUbpR0Fb1H3uxG0x9L3DKAAEP9Ect?=
 =?us-ascii?Q?UM1tOvSDLlU+0ZM4XFYYoi9RaEwzGK2QsH2FfGATkNmXs5h7EtCAPicjY0Fv?=
 =?us-ascii?Q?4QiXpx7IwRWTUkdm6D6xydJ8PfNg0c4qZbSCYw/0WG0aVRQOvTsQYUhzpTv6?=
 =?us-ascii?Q?2u7ARP1nPWMEou3+8i4jepbnm9jCuVOdH3GF117fkZzNrUTug+TLxQFgKdEk?=
 =?us-ascii?Q?JpSW0Y7H/S9OW0UCeTxyq04oSoqkwuXIbKXmDdbIc17UZ2oZQxehdWS426Uk?=
 =?us-ascii?Q?SeYSvtR9gQtcGfRrbe4CdeimMgr3D7kUxsbjZPmceUl/wAdLsuXpiiCiuiYx?=
 =?us-ascii?Q?uYumyAe4+LrYjzvn3AM2gOmupB5SOiuqkvJaUENJORVg/QSYToLTyDMR00Ex?=
 =?us-ascii?Q?pvcScQubDh24KHbKShBHRFuvUUoj/whxbqi4xGBu6r6OKkLXE4uLa+I3LTWM?=
 =?us-ascii?Q?axez7SXvLLa+G1r0lyBiGnoVj1oFqqTDadVYQsqb45B7VVOMGUF/pVplPHxL?=
 =?us-ascii?Q?650mfZUzCTjDB9HF4MPO1Gwbgf7lle3RzbcHbUAp7DcWWcQuyxC2Vf7WQSjL?=
 =?us-ascii?Q?wx9dIdwFg0aBPFcADp6SgJCxfPr14rd9Uc1iaREbE9PUiDQ9LZFmEUVA+Z42?=
 =?us-ascii?Q?QHiJwibf7hEnpuHbd6pJOJTrVkkm0WpM/XLgKf98W0wTdan1eY8LmEFFxNab?=
 =?us-ascii?Q?ff/SoKNTPQ/klhdA4LDgsmYee60iml6oe6xNChtFaS7hQCKU1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:55:05.8199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaf3f0a-f7fd-4d6e-12a7-08dcf31edce1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Add some scruct for secure display.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 53 +++++++++++++++----
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6d96a840d24d..3aa6c60588b5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -727,6 +727,7 @@ enum dmub_shared_state_feature_id {
 	DMUB_SHARED_SHARE_FEATURE__INVALID = 0,
 	DMUB_SHARED_SHARE_FEATURE__IPS_FW = 1,
 	DMUB_SHARED_SHARE_FEATURE__IPS_DRIVER = 2,
+	DMUB_SHARED_SHARE_FEATURE__DEBUG_SETUP = 3,
 	DMUB_SHARED_STATE_FEATURE__LAST, /* Total number of features. */
 };
 
@@ -764,6 +765,14 @@ union dmub_shared_state_ips_driver_signals {
  */
 #define DMUB_SHARED_STATE__IPS_FW_VERSION 1
 
+struct dmub_shared_state_debug_setup {
+	union {
+		struct {
+			uint32_t exclude_points[62];
+		} profile_mode;
+	};
+};
+
 /**
  * struct dmub_shared_state_ips_fw - Firmware state for IPS.
  */
@@ -816,6 +825,7 @@ struct dmub_shared_state_feature_block {
 		struct dmub_shared_state_feature_common common; /**< Generic data */
 		struct dmub_shared_state_ips_fw ips_fw; /**< IPS firmware state */
 		struct dmub_shared_state_ips_driver ips_driver; /**< IPS driver state */
+		struct dmub_shared_state_debug_setup debug_setup; /**< Debug setup */
 	} data; /**< Shared state data. */
 }; /* 256-bytes, fixed */
 
@@ -1158,6 +1168,10 @@ enum dmub_gpint_command {
 	 * RETURN: Total residency in microseconds - upper 32 bits
 	 */
 	DMUB_GPINT__GET_IPS_RESIDENCY_DURATION_US_HI = 133,
+	/**
+	 * DESC: Setup debug configs.
+	 */
+	DMUB_GPINT__SETUP_DEBUG_MODE = 136,
 };
 
 /**
@@ -5172,7 +5186,34 @@ struct dmub_rb_cmd_get_usbc_cable_id {
 enum dmub_cmd_secure_display_type {
 	DMUB_CMD__SECURE_DISPLAY_TEST_CMD = 0,		/* test command to only check if inbox message works */
 	DMUB_CMD__SECURE_DISPLAY_CRC_STOP_UPDATE,
-	DMUB_CMD__SECURE_DISPLAY_CRC_WIN_NOTIFY
+	DMUB_CMD__SECURE_DISPLAY_CRC_WIN_NOTIFY,
+	DMUB_CMD__SECURE_DISPLAY_MULTIPLE_CRC_STOP_UPDATE,
+	DMUB_CMD__SECURE_DISPLAY_MULTIPLE_CRC_WIN_NOTIFY
+};
+
+#define MAX_ROI_NUM	2
+
+struct dmub_cmd_roi_info {
+	uint16_t x_start;
+	uint16_t x_end;
+	uint16_t y_start;
+	uint16_t y_end;
+	uint8_t otg_id;
+	uint8_t phy_id;
+};
+
+struct dmub_cmd_roi_window_ctl {
+	uint16_t x_start;
+	uint16_t x_end;
+	uint16_t y_start;
+	uint16_t y_end;
+	bool enable;
+};
+
+struct dmub_cmd_roi_ctl_info {
+	uint8_t otg_id;
+	uint8_t phy_id;
+	struct dmub_cmd_roi_window_ctl roi_ctl[MAX_ROI_NUM];
 };
 
 /**
@@ -5183,14 +5224,8 @@ struct dmub_rb_cmd_secure_display {
 	/**
 	 * Data passed from driver to dmub firmware.
 	 */
-	struct dmub_cmd_roi_info {
-		uint16_t x_start;
-		uint16_t x_end;
-		uint16_t y_start;
-		uint16_t y_end;
-		uint8_t otg_id;
-		uint8_t phy_id;
-	} roi_info;
+	struct dmub_cmd_roi_info roi_info;
+	struct dmub_cmd_roi_ctl_info mul_roi_ctl;
 };
 
 /**
-- 
2.34.1

