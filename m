Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5CCCD4F46
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 09:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4208E10E642;
	Fri, 22 Sep 2023 09:58:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A5E10E643
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 09:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzwIeKvzLhc75ua3M7oCuMfTrugCX2cV394UQuayX1PIdVmK3gLdFqkCBVNzAiqNRywVeWYKL+mki2Df7zc3cJNfgtvc7wuHV+WPTiDLdr8hp1yB3pvqPInDl3lga2dlqlcdks9vcnQa8e3Vzn+Wz0F3t/QDQnon46fXBdVevkA9Zb8XiyAGWOchuzSXnji+KzDgGb3xHK+EBzfNWzodQvmc3ppHWKgGXD8d6ZCgfV/rbZtz7RXU3yQkyuXh+Zx0G1LVOjQ9Yx+MV5Zg0fInZy28HqrLj+mBBYzj3BttaB2xs/S4ODsH/5ZwCAQ/hYuBLNuiepwUZDNifYa3QjqpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/dMiq6z3jcBTkozBXgCIdWoHIHzXOS/yuJ1MU9UhVU=;
 b=JhfBKHQDUn29l1AV59jZ2s30W7x5IkqHymlQp1aYql10/epsxqDMxf2858tzXCT1TcPRBLki9AJR31uhV9IdEbuxuetqbKDiXHNAWSiXXd72v2PONo76RkGB4jD0pJHGtMwQqtEqGSx96+d7LMfY9QTud0dyjiRH3sSMgi0afj8bv7JJzuSewNtiB20ZqznAXLC26jEjAsOhrQkAlZnR9SsaTPc/i6WEQ1syaEE/LaMJrmznzY2NHicxd4AVrISta5jAAXqi5bg2SZE/+nQEuo4YgHNNWLhqe1AIdKBzLYIeGuga1t9qGMq+Zq6cQBtsbgjMQrD2gRQq5192J+wvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/dMiq6z3jcBTkozBXgCIdWoHIHzXOS/yuJ1MU9UhVU=;
 b=zFjpErGFDZqxYoO9T4jeeWjUVWEaZYIFekBLQOSJQ/kSIkCzAsyHYLxqhBmt/S6cmHfS8GSyfaBDuL9LA7XALgrwocfHEbEfoJJtnDMbBPBXaEzndHNqi0+mocra2WLSEfehVpE6dWz8Og4aGABm2ykG2HVn5f+TXysDKOagbCQ=
Received: from BL0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:2d::14)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 09:58:42 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::31) by BL0PR03CA0001.outlook.office365.com
 (2603:10b6:208:2d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 09:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 09:58:02 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 04:57:57 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Remove unused DPCD declarations
Date: Fri, 22 Sep 2023 17:58:05 +0800
Message-ID: <20230922095816.702784-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 17580c66-ab18-439b-da9b-08dbbb52806c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6KOnSIxZ12yt848+g6W7Z3Hk7iauvfcUn8L+ySJAPLF83GONhgoDipaK9oItfht3P9UQ7XPfPTzWSN2W9S130QdtsRuT0iR+VptUe8v7R0mWd8hn0qS2sRvmCjlhf3z+Pz72t2WZJpkkqTLnRl8tE1AOsVC8tl9bx7HreyLFrf90ypngP0eepERKPGs5Cu3dBbvx3zX4WF/WTr/zkODGmb8hdwkGMcwblzkx+xCkFZnzfPMfHoQNDAk7qFXkSl7HhV//+1o9wmfCBvDt9otVVMniBkvwFqHqvdcmffk4YT/d0qtBWPe/mmGKwSk0ITD2mQfFYzTCVYHjA5uXP15E49qeCFtOEHDqjU/0uMTtjiZaoyawaSuSMMPanNRCPfOgwrAfrtZN77bfbiTyvJtWKw8ZyYOJMhz6HLJgC2Ukn8s01oqh2vxkvo2/Bk0Tnjt8xi8R9Q+8/cARS0zcz7cf5/HLQM+yIx9pNAHOD5N/r7WQE+SBli+AlMgb94fs70yRHd3inhQV/XiuiP0oQ+/ABpDX7Y9aAJtEhdbgPf1vyHdtv1aF0wPc6UphWU+DflPHtdafH3MK8Nx8iSmr5JrpHwE6GqGr4TqXdSX7+UUJEiz8X6AIbFPKN0symLwQ+lxGg9iSzRmAV8f0FEYBcfxLCANuzCAe1g4cpX7cc65CQrClrPB7cIqjUxpPuOCX4qV/rND/xVT4msXYj+HqU5oSmqNkx9e4rQCjCmDEZFQZCWWrRgpFwLSQubjDeeEnvk0psWTcamwiRk8rvuLNjmSjJ8tAkn6TWlsMYUNMMfOup/xAShjSv0qcN+We7vNKwpAp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230921699003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(47076005)(40460700003)(478600001)(86362001)(36860700001)(41300700001)(2906002)(5660300002)(44832011)(4326008)(8936002)(82740400003)(8676002)(54906003)(6916009)(70586007)(70206006)(81166007)(316002)(83380400001)(36756003)(26005)(40480700001)(356005)(336012)(2616005)(1076003)(426003)(16526019)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 09:58:02.1576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17580c66-ab18-439b-da9b-08dbbb52806c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
These DPCD addresses are either declared in other header files
where it makes more sense or simply not used by any DC code.
Remove them to reduce redundancies and potential confusion.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h | 59 +-------------------
 1 file changed, 1 insertion(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index cfaa39c5dd16..35ae245ef722 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -916,73 +916,16 @@ struct dpcd_usb4_dp_tunneling_info {
 	uint8_t usb4_topology_id[DPCD_USB4_TOPOLOGY_ID_LEN];
 };
 
-#ifndef DP_MAIN_LINK_CHANNEL_CODING_CAP
-#define DP_MAIN_LINK_CHANNEL_CODING_CAP			0x006
-#endif
-#ifndef DP_SINK_VIDEO_FALLBACK_FORMATS
-#define DP_SINK_VIDEO_FALLBACK_FORMATS			0x020
-#endif
-#ifndef DP_FEC_CAPABILITY_1
-#define DP_FEC_CAPABILITY_1				0x091
-#endif
 #ifndef DP_DFP_CAPABILITY_EXTENSION_SUPPORT
 #define DP_DFP_CAPABILITY_EXTENSION_SUPPORT		0x0A3
 #endif
-#ifndef DP_DSC_CONFIGURATION
-#define DP_DSC_CONFIGURATION				0x161
-#endif
-#ifndef DP_PHY_SQUARE_PATTERN
-#define DP_PHY_SQUARE_PATTERN				0x249
-#endif
-#ifndef DP_128b_132b_SUPPORTED_LINK_RATES
-#define DP_128b_132b_SUPPORTED_LINK_RATES		0x2215
-#endif
-#ifndef DP_128b_132b_TRAINING_AUX_RD_INTERVAL
-#define DP_128b_132b_TRAINING_AUX_RD_INTERVAL		0x2216
-#endif
 #ifndef DP_TEST_264BIT_CUSTOM_PATTERN_7_0
 #define DP_TEST_264BIT_CUSTOM_PATTERN_7_0		0X2230
 #endif
 #ifndef DP_TEST_264BIT_CUSTOM_PATTERN_263_256
 #define DP_TEST_264BIT_CUSTOM_PATTERN_263_256		0X2250
 #endif
-#ifndef DP_DSC_SUPPORT_AND_DECODER_COUNT
-#define DP_DSC_SUPPORT_AND_DECODER_COUNT		0x2260
-#endif
-#ifndef DP_DSC_MAX_SLICE_COUNT_AND_AGGREGATION_0
-#define DP_DSC_MAX_SLICE_COUNT_AND_AGGREGATION_0	0x2270
-#endif
-#ifndef DP_DSC_DECODER_0_MAXIMUM_SLICE_COUNT_MASK
-#define DP_DSC_DECODER_0_MAXIMUM_SLICE_COUNT_MASK	(1 << 0)
-#endif
-#ifndef DP_DSC_DECODER_0_AGGREGATION_SUPPORT_MASK
-#define DP_DSC_DECODER_0_AGGREGATION_SUPPORT_MASK	(0b111 << 1)
-#endif
-#ifndef DP_DSC_DECODER_0_AGGREGATION_SUPPORT_SHIFT
-#define DP_DSC_DECODER_0_AGGREGATION_SUPPORT_SHIFT	1
-#endif
-#ifndef DP_DSC_DECODER_COUNT_MASK
-#define DP_DSC_DECODER_COUNT_MASK			(0b111 << 5)
-#endif
-#ifndef DP_DSC_DECODER_COUNT_SHIFT
-#define DP_DSC_DECODER_COUNT_SHIFT			5
-#endif
-#ifndef DP_MAIN_LINK_CHANNEL_CODING_SET
-#define DP_MAIN_LINK_CHANNEL_CODING_SET			0x108
-#endif
-#ifndef DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER
-#define DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER	0xF0006
-#endif
-#ifndef DP_PHY_REPEATER_128b_132b_RATES
-#define DP_PHY_REPEATER_128b_132b_RATES			0xF0007
-#endif
-#ifndef DP_128b_132b_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1
-#define DP_128b_132b_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1	0xF0022
-#endif
-#ifndef DP_INTRA_HOP_AUX_REPLY_INDICATION
-#define DP_INTRA_HOP_AUX_REPLY_INDICATION		(1 << 3)
-/* TODO - Use DRM header to replace above once available */
-#endif // DP_INTRA_HOP_AUX_REPLY_INDICATION
+
 union dp_main_line_channel_coding_cap {
 	struct {
 		uint8_t DP_8b_10b_SUPPORTED	:1;
-- 
2.42.0

