Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD9DC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DDC910E58A;
	Wed,  9 Nov 2022 06:18:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 143CB10E588
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUQ1IOhTeYIQfjTRa98TK001AA3teyOE/O58DP5asFLp/SKNyLEY0MFIs+vvdIupLwtWtGhN8RJ3Gg+hsajHpwPFojwtIw9xTRSDtc5etFZD7LszHedhx31w0LloyDjay6jH8Ryh89SWNRezd1Q+DD2oWEDSvVhMWDYhk20TUuu2kueOa5oNk6+6s/je4nDtljxa3Ujk0gCa19Y0fiGNjURAeQKQojpZmOqm3QTjamA9rhz0QuBo2b29/upemyWQadS3iVnhQQLOXdTDiDoavuJdD2xmAtdXkwZ2q7oZ7NtvoQDeh3ZxxkA3fISdLAbbuqzvQOr2qlZj3U14PVHDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTqViDbMQC3sJW0/Rg3WU9hCKYbHiWVQg3tosjHpbpE=;
 b=IlSYPNp0CooTKaMPjFIibv3iRolv8nVkjw8EzfUMcw4fwC3+6JlcvHHjLiPjsIGlkXC2wN1t8apNDafptB2wCZB5iRt7O9P0kPpJqo95X9fvqALRiOUcUP1Yg4S/547ta5qtWSyhk8y8S4//1EnWo2LcdX1joBkAppv4QmZ6Tq/s1yspl9PQYTZFkD0pCUuh4Vi6ipGb1TXqhkB2xrk8AcfCmBnjnw5rA0lCUNm/PFfwH4znJHZ4dARjmnZZBnOtDzZ7Q2R/EjC4v5wyIaNk78bCKV+ZyV/a613PIl5Ft8OnIGgkGsi7V+cGd+k9m+/n0XfB2UUxTtUXh8VYCG213g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTqViDbMQC3sJW0/Rg3WU9hCKYbHiWVQg3tosjHpbpE=;
 b=LV6mQ/4Tr6xyMLh8uCbmMDgk4w0EbS58xJR3yzAvw9CLcIOdIgu+QEfojUH8OKQRQO8vEQgAI51RIIV3xo+mm2gjWeFH9LFcPSsxGztKrDG8PWe0yFDUAAK0NwKEDQIEvxYRAQ9sViDe6k0OUssxMjyHUWYqeZ9J/Vox5czEU10=
Received: from MW4PR04CA0320.namprd04.prod.outlook.com (2603:10b6:303:82::25)
 by BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:18:12 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::73) by MW4PR04CA0320.outlook.office365.com
 (2603:10b6:303:82::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:18:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:18:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:18:10 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:17:53 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/29] drm/amd/display: rework macros for DWB register access
Date: Wed, 9 Nov 2022 14:13:16 +0800
Message-ID: <20221109061319.2870943-27-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|BY5PR12MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 4940b4df-199d-48ef-a67b-08dac21a2dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjntfHdlP0lxZhnJzAZBSZp6VERwn63n3VnesBCYDQLHSxJ8dLZfzBYzZgSij/S/JLfEl1Va2O7po4dfdGkYH5gRARtm0YeUH9fHK0D3HEw+uoKSMVonRCBb3rmw6f+ksjvW0bqTteMawnnHM/H9+bAStALg4XfbHg2QMmxVf6K4T/o9FqEs9Vx7a1748FfPacyyTAPiDKjDCnyeP5+rm6mDC8xGOiMmOFZN9N7Eotbip050zBAmEN93YRhCniEpoPemta2W/28SWP2BN1ygMyUBa95BGHMY3zZ6+ZhgeYJlt5ForlduldoUacHtYtWJQ/N1uilifLodzU7rDdbAX1YIx0fhQzMjUV5IgERTQ3XT7Yc96UWADlM6exBG2sBZvIM5uMeNkYW/3iLce1wVxIwWZKRVG1n5GOSi732F/WNSsdBN8h1ZqSa0ejUNQ6awNsS2hHKA+YZqQriusZoVnpTQXRdz9hXD1G7FK/Vu5XMvkWKYy/BUPLZPJlf2ko9quwlQRmvwPFMidr/DWIHoXQ7d+Q5vZTqyJSu8kNLI1TTO8lSs4csYvQpOQjtd+N2ekZ/cbQko6NW54kB8bhwhdRD81iPMuCiPYrjekNnVMNdYlosLzFP1y2hj/WPqUVARQuukDg5axcK6hALi1gBkxxEqLZ4hAUptkTQOvhh1lAkDzUpmrSH7R/LJWlzD6cPkCA+XYPOIrhu+9G/1WDXmEElSkhVfw7VhybXG1ID3/+5wZ4jwVFohc+/NMmw2oArRnE8qj5M2WpidaNODH12gxQoKN5s02X+KPYYg92x4qtQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(426003)(47076005)(7696005)(336012)(26005)(2616005)(82310400005)(1076003)(186003)(82740400003)(2906002)(30864003)(5660300002)(40480700001)(6916009)(36860700001)(40460700003)(478600001)(6666004)(8676002)(54906003)(4326008)(41300700001)(8936002)(70206006)(316002)(70586007)(36756003)(81166007)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:18:11.7388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4940b4df-199d-48ef-a67b-08dac21a2dc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
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
 Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why]
A hack was used to access DWB register due to difference in the register
naming convention which was not compatible with existing SR/SRI* macros.
The additional macro needed were added to dwb ip specific header file
(dcnxx_dwb.h) instead of soc resource file (dcnxx_resource.c). Due to
this pattern, BASE macro had to be redefined in dcnxx_dwb.h, which in
turn needed us to undefine them in the resource file.

[How]
Add a separate macro for DWB access to the resource files that need it
instead of defining them in DWB ip header file. This will enable us to
reuse the BASE macro defined in the resource file.

Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dwb.h  | 363 ++++++++----------
 .../drm/amd/display/dc/dcn20/dcn20_mmhubbub.h |   7 -
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  11 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h |   6 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |  15 -
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.h |   7 -
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   5 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   5 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   4 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   4 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   5 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |   3 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |   5 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |   5 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   5 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   5 +-
 17 files changed, 207 insertions(+), 250 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.h
index a85ed228dfc2..a9dd9ae23ec9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.h
@@ -27,204 +27,177 @@
 #define TO_DCN20_DWBC(dwbc_base) \
 	container_of(dwbc_base, struct dcn20_dwbc, base)
 
-/* DCN */
-#define BASE_INNER(seg) \
-	DCE_BASE__INST0_SEG ## seg
-
-#define BASE(seg) \
-	BASE_INNER(seg)
-
-#define SR(reg_name)\
-		.reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
-					mm ## reg_name
-
-#define SRI(reg_name, block, id)\
-	.reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
-					mm ## block ## id ## _ ## reg_name
-
-#define SRI2(reg_name, block, id)\
-	.reg_name = BASE(mm ## reg_name ## _BASE_IDX) + \
-					mm ## reg_name
-
-#define SRII(reg_name, block, id)\
-	.reg_name[id] = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
-					mm ## block ## id ## _ ## reg_name
-
-#define SF(reg_name, field_name, post_fix)\
-	.field_name = reg_name ## __ ## field_name ## post_fix
-
-
 #define DWBC_COMMON_REG_LIST_DCN2_0(inst) \
-	SRI2(WB_ENABLE, CNV, inst),\
-	SRI2(WB_EC_CONFIG, CNV, inst),\
-	SRI2(CNV_MODE, CNV, inst),\
-	SRI2(CNV_WINDOW_START, CNV, inst),\
-	SRI2(CNV_WINDOW_SIZE, CNV, inst),\
-	SRI2(CNV_UPDATE, CNV, inst),\
-	SRI2(CNV_SOURCE_SIZE, CNV, inst),\
-	SRI2(CNV_TEST_CNTL, CNV, inst),\
-	SRI2(CNV_TEST_CRC_RED, CNV, inst),\
-	SRI2(CNV_TEST_CRC_GREEN, CNV, inst),\
-	SRI2(CNV_TEST_CRC_BLUE, CNV, inst),\
-	SRI2(WBSCL_COEF_RAM_SELECT, WBSCL, inst),\
-	SRI2(WBSCL_COEF_RAM_TAP_DATA, WBSCL, inst),\
-	SRI2(WBSCL_MODE, WBSCL, inst),\
-	SRI2(WBSCL_TAP_CONTROL, WBSCL, inst),\
-	SRI2(WBSCL_DEST_SIZE, WBSCL, inst),\
-	SRI2(WBSCL_HORZ_FILTER_SCALE_RATIO, WBSCL, inst),\
-	SRI2(WBSCL_HORZ_FILTER_INIT_Y_RGB, WBSCL, inst),\
-	SRI2(WBSCL_HORZ_FILTER_INIT_CBCR, WBSCL, inst),\
-	SRI2(WBSCL_VERT_FILTER_SCALE_RATIO, WBSCL, inst),\
-	SRI2(WBSCL_VERT_FILTER_INIT_Y_RGB, WBSCL, inst),\
-	SRI2(WBSCL_VERT_FILTER_INIT_CBCR, WBSCL, inst),\
-	SRI2(WBSCL_ROUND_OFFSET, WBSCL, inst),\
-	SRI2(WBSCL_OVERFLOW_STATUS, WBSCL, inst),\
-	SRI2(WBSCL_COEF_RAM_CONFLICT_STATUS, WBSCL, inst),\
-	SRI2(WBSCL_TEST_CNTL, WBSCL, inst),\
-	SRI2(WBSCL_TEST_CRC_RED, WBSCL, inst),\
-	SRI2(WBSCL_TEST_CRC_GREEN, WBSCL, inst),\
-	SRI2(WBSCL_TEST_CRC_BLUE, WBSCL, inst),\
-	SRI2(WBSCL_BACKPRESSURE_CNT_EN, WBSCL, inst),\
-	SRI2(WB_MCIF_BACKPRESSURE_CNT, WBSCL, inst),\
-	SRI2(WBSCL_CLAMP_Y_RGB, WBSCL, inst),\
-	SRI2(WBSCL_CLAMP_CBCR, WBSCL, inst),\
-	SRI2(WBSCL_OUTSIDE_PIX_STRATEGY, WBSCL, inst),\
-	SRI2(WBSCL_OUTSIDE_PIX_STRATEGY_CBCR, WBSCL, inst),\
-	SRI2(WBSCL_DEBUG, WBSCL, inst),\
-	SRI2(WBSCL_TEST_DEBUG_INDEX, WBSCL, inst),\
-	SRI2(WBSCL_TEST_DEBUG_DATA, WBSCL, inst),\
-	SRI2(WB_DEBUG_CTRL, CNV, inst),\
-	SRI2(WB_DBG_MODE, CNV, inst),\
-	SRI2(WB_HW_DEBUG, CNV, inst),\
-	SRI2(CNV_TEST_DEBUG_INDEX, CNV, inst),\
-	SRI2(CNV_TEST_DEBUG_DATA, CNV, inst),\
-	SRI2(WB_SOFT_RESET, CNV, inst),\
-	SRI2(WB_WARM_UP_MODE_CTL1, CNV, inst),\
-	SRI2(WB_WARM_UP_MODE_CTL2, CNV, inst)
+	SRI2_DWB(WB_ENABLE, CNV, inst),\
+	SRI2_DWB(WB_EC_CONFIG, CNV, inst),\
+	SRI2_DWB(CNV_MODE, CNV, inst),\
+	SRI2_DWB(CNV_WINDOW_START, CNV, inst),\
+	SRI2_DWB(CNV_WINDOW_SIZE, CNV, inst),\
+	SRI2_DWB(CNV_UPDATE, CNV, inst),\
+	SRI2_DWB(CNV_SOURCE_SIZE, CNV, inst),\
+	SRI2_DWB(CNV_TEST_CNTL, CNV, inst),\
+	SRI2_DWB(CNV_TEST_CRC_RED, CNV, inst),\
+	SRI2_DWB(CNV_TEST_CRC_GREEN, CNV, inst),\
+	SRI2_DWB(CNV_TEST_CRC_BLUE, CNV, inst),\
+	SRI2_DWB(WBSCL_COEF_RAM_SELECT, WBSCL, inst),\
+	SRI2_DWB(WBSCL_COEF_RAM_TAP_DATA, WBSCL, inst),\
+	SRI2_DWB(WBSCL_MODE, WBSCL, inst),\
+	SRI2_DWB(WBSCL_TAP_CONTROL, WBSCL, inst),\
+	SRI2_DWB(WBSCL_DEST_SIZE, WBSCL, inst),\
+	SRI2_DWB(WBSCL_HORZ_FILTER_SCALE_RATIO, WBSCL, inst),\
+	SRI2_DWB(WBSCL_HORZ_FILTER_INIT_Y_RGB, WBSCL, inst),\
+	SRI2_DWB(WBSCL_HORZ_FILTER_INIT_CBCR, WBSCL, inst),\
+	SRI2_DWB(WBSCL_VERT_FILTER_SCALE_RATIO, WBSCL, inst),\
+	SRI2_DWB(WBSCL_VERT_FILTER_INIT_Y_RGB, WBSCL, inst),\
+	SRI2_DWB(WBSCL_VERT_FILTER_INIT_CBCR, WBSCL, inst),\
+	SRI2_DWB(WBSCL_ROUND_OFFSET, WBSCL, inst),\
+	SRI2_DWB(WBSCL_OVERFLOW_STATUS, WBSCL, inst),\
+	SRI2_DWB(WBSCL_COEF_RAM_CONFLICT_STATUS, WBSCL, inst),\
+	SRI2_DWB(WBSCL_TEST_CNTL, WBSCL, inst),\
+	SRI2_DWB(WBSCL_TEST_CRC_RED, WBSCL, inst),\
+	SRI2_DWB(WBSCL_TEST_CRC_GREEN, WBSCL, inst),\
+	SRI2_DWB(WBSCL_TEST_CRC_BLUE, WBSCL, inst),\
+	SRI2_DWB(WBSCL_BACKPRESSURE_CNT_EN, WBSCL, inst),\
+	SRI2_DWB(WB_MCIF_BACKPRESSURE_CNT, WBSCL, inst),\
+	SRI2_DWB(WBSCL_CLAMP_Y_RGB, WBSCL, inst),\
+	SRI2_DWB(WBSCL_CLAMP_CBCR, WBSCL, inst),\
+	SRI2_DWB(WBSCL_OUTSIDE_PIX_STRATEGY, WBSCL, inst),\
+	SRI2_DWB(WBSCL_OUTSIDE_PIX_STRATEGY_CBCR, WBSCL, inst),\
+	SRI2_DWB(WBSCL_DEBUG, WBSCL, inst),\
+	SRI2_DWB(WBSCL_TEST_DEBUG_INDEX, WBSCL, inst),\
+	SRI2_DWB(WBSCL_TEST_DEBUG_DATA, WBSCL, inst),\
+	SRI2_DWB(WB_DEBUG_CTRL, CNV, inst),\
+	SRI2_DWB(WB_DBG_MODE, CNV, inst),\
+	SRI2_DWB(WB_HW_DEBUG, CNV, inst),\
+	SRI2_DWB(CNV_TEST_DEBUG_INDEX, CNV, inst),\
+	SRI2_DWB(CNV_TEST_DEBUG_DATA, CNV, inst),\
+	SRI2_DWB(WB_SOFT_RESET, CNV, inst),\
+	SRI2_DWB(WB_WARM_UP_MODE_CTL1, CNV, inst),\
+	SRI2_DWB(WB_WARM_UP_MODE_CTL2, CNV, inst)
 
 #define DWBC_COMMON_MASK_SH_LIST_DCN2_0(mask_sh) \
-	SF(WB_ENABLE, WB_ENABLE, mask_sh),\
-	SF(WB_EC_CONFIG, DISPCLK_R_WB_GATE_DIS, mask_sh),\
-	SF(WB_EC_CONFIG, DISPCLK_G_WB_GATE_DIS, mask_sh),\
-	SF(WB_EC_CONFIG, DISPCLK_G_WBSCL_GATE_DIS, mask_sh),\
-	SF(WB_EC_CONFIG, WB_TEST_CLK_SEL, mask_sh),\
-	SF(WB_EC_CONFIG, WB_LB_LS_DIS, mask_sh),\
-	SF(WB_EC_CONFIG, WB_LB_SD_DIS, mask_sh),\
-	SF(WB_EC_CONFIG, WB_LUT_LS_DIS, mask_sh),\
-	SF(WB_EC_CONFIG, WBSCL_LB_MEM_PWR_MODE_SEL, mask_sh),\
-	SF(WB_EC_CONFIG, WBSCL_LB_MEM_PWR_DIS, mask_sh),\
-	SF(WB_EC_CONFIG, WBSCL_LB_MEM_PWR_FORCE, mask_sh),\
-	SF(WB_EC_CONFIG, WBSCL_LB_MEM_PWR_STATE, mask_sh),\
-	SF(WB_EC_CONFIG, WB_RAM_PW_SAVE_MODE, mask_sh),\
-	SF(WB_EC_CONFIG, WBSCL_LUT_MEM_PWR_STATE, mask_sh),\
-	SF(CNV_MODE, CNV_OUT_BPC, mask_sh),\
-	SF(CNV_MODE, CNV_FRAME_CAPTURE_RATE, mask_sh),\
-	SF(CNV_MODE, CNV_WINDOW_CROP_EN, mask_sh),\
-	SF(CNV_MODE, CNV_STEREO_TYPE, mask_sh),\
-	SF(CNV_MODE, CNV_INTERLACED_MODE, mask_sh),\
-	SF(CNV_MODE, CNV_EYE_SELECTION, mask_sh),\
-	SF(CNV_MODE, CNV_STEREO_POLARITY, mask_sh),\
-	SF(CNV_MODE, CNV_INTERLACED_FIELD_ORDER, mask_sh),\
-	SF(CNV_MODE, CNV_STEREO_SPLIT, mask_sh),\
-	SF(CNV_MODE, CNV_NEW_CONTENT, mask_sh),\
-	SF(CNV_MODE, CNV_FRAME_CAPTURE_EN_CURRENT, mask_sh),\
-	SF(CNV_MODE, CNV_FRAME_CAPTURE_EN, mask_sh),\
-	SF(CNV_WINDOW_START, CNV_WINDOW_START_X, mask_sh),\
-	SF(CNV_WINDOW_START, CNV_WINDOW_START_Y, mask_sh),\
-	SF(CNV_WINDOW_SIZE, CNV_WINDOW_WIDTH, mask_sh),\
-	SF(CNV_WINDOW_SIZE, CNV_WINDOW_HEIGHT, mask_sh),\
-	SF(CNV_UPDATE, CNV_UPDATE_PENDING, mask_sh),\
-	SF(CNV_UPDATE, CNV_UPDATE_TAKEN, mask_sh),\
-	SF(CNV_UPDATE, CNV_UPDATE_LOCK, mask_sh),\
-	SF(CNV_SOURCE_SIZE, CNV_SOURCE_WIDTH, mask_sh),\
-	SF(CNV_SOURCE_SIZE, CNV_SOURCE_HEIGHT, mask_sh),\
-	SF(CNV_TEST_CNTL, CNV_TEST_CRC_EN, mask_sh),\
-	SF(CNV_TEST_CNTL, CNV_TEST_CRC_CONT_EN, mask_sh),\
-	SF(CNV_TEST_CRC_RED, CNV_TEST_CRC_RED_MASK, mask_sh),\
-	SF(CNV_TEST_CRC_RED, CNV_TEST_CRC_SIG_RED, mask_sh),\
-	SF(CNV_TEST_CRC_GREEN, CNV_TEST_CRC_GREEN_MASK, mask_sh),\
-	SF(CNV_TEST_CRC_GREEN, CNV_TEST_CRC_SIG_GREEN, mask_sh),\
-	SF(CNV_TEST_CRC_BLUE, CNV_TEST_CRC_BLUE_MASK, mask_sh),\
-	SF(CNV_TEST_CRC_BLUE, CNV_TEST_CRC_SIG_BLUE, mask_sh),\
-	SF(WB_DEBUG_CTRL, WB_DEBUG_EN, mask_sh),\
-	SF(WB_DEBUG_CTRL, WB_DEBUG_SEL, mask_sh),\
-	SF(WB_DBG_MODE, WB_DBG_MODE_EN, mask_sh),\
-	SF(WB_DBG_MODE, WB_DBG_DIN_FMT, mask_sh),\
-	SF(WB_DBG_MODE, WB_DBG_36MODE, mask_sh),\
-	SF(WB_DBG_MODE, WB_DBG_CMAP, mask_sh),\
-	SF(WB_DBG_MODE, WB_DBG_PXLRATE_ERROR, mask_sh),\
-	SF(WB_DBG_MODE, WB_DBG_SOURCE_WIDTH, mask_sh),\
-	SF(WB_HW_DEBUG, WB_HW_DEBUG, mask_sh),\
-	SF(WB_SOFT_RESET, WB_SOFT_RESET, mask_sh),\
-	SF(CNV_TEST_DEBUG_INDEX, CNV_TEST_DEBUG_INDEX, mask_sh),\
-	SF(CNV_TEST_DEBUG_INDEX, CNV_TEST_DEBUG_WRITE_EN, mask_sh),\
-	SF(CNV_TEST_DEBUG_DATA, CNV_TEST_DEBUG_DATA, mask_sh),\
-	SF(WBSCL_COEF_RAM_SELECT, WBSCL_COEF_RAM_TAP_PAIR_IDX, mask_sh),\
-	SF(WBSCL_COEF_RAM_SELECT, WBSCL_COEF_RAM_PHASE, mask_sh),\
-	SF(WBSCL_COEF_RAM_SELECT, WBSCL_COEF_RAM_FILTER_TYPE, mask_sh),\
-	SF(WBSCL_COEF_RAM_TAP_DATA, WBSCL_COEF_RAM_EVEN_TAP_COEF, mask_sh),\
-	SF(WBSCL_COEF_RAM_TAP_DATA, WBSCL_COEF_RAM_EVEN_TAP_COEF_EN, mask_sh),\
-	SF(WBSCL_COEF_RAM_TAP_DATA, WBSCL_COEF_RAM_ODD_TAP_COEF, mask_sh),\
-	SF(WBSCL_COEF_RAM_TAP_DATA, WBSCL_COEF_RAM_ODD_TAP_COEF_EN, mask_sh),\
-	SF(WBSCL_MODE, WBSCL_MODE, mask_sh),\
-	SF(WBSCL_MODE, WBSCL_OUT_BIT_DEPTH, mask_sh),\
-	SF(WBSCL_TAP_CONTROL, WBSCL_V_NUM_OF_TAPS_Y_RGB, mask_sh),\
-	SF(WBSCL_TAP_CONTROL, WBSCL_V_NUM_OF_TAPS_CBCR, mask_sh),\
-	SF(WBSCL_TAP_CONTROL, WBSCL_H_NUM_OF_TAPS_Y_RGB, mask_sh),\
-	SF(WBSCL_TAP_CONTROL, WBSCL_H_NUM_OF_TAPS_CBCR, mask_sh),\
-	SF(WBSCL_DEST_SIZE, WBSCL_DEST_HEIGHT, mask_sh),\
-	SF(WBSCL_DEST_SIZE, WBSCL_DEST_WIDTH, mask_sh),\
-	SF(WBSCL_HORZ_FILTER_SCALE_RATIO, WBSCL_H_SCALE_RATIO, mask_sh),\
-	SF(WBSCL_HORZ_FILTER_INIT_Y_RGB, WBSCL_H_INIT_FRAC_Y_RGB, mask_sh),\
-	SF(WBSCL_HORZ_FILTER_INIT_Y_RGB, WBSCL_H_INIT_INT_Y_RGB, mask_sh),\
-	SF(WBSCL_HORZ_FILTER_INIT_CBCR, WBSCL_H_INIT_FRAC_CBCR, mask_sh),\
-	SF(WBSCL_HORZ_FILTER_INIT_CBCR, WBSCL_H_INIT_INT_CBCR, mask_sh),\
-	SF(WBSCL_VERT_FILTER_SCALE_RATIO, WBSCL_V_SCALE_RATIO, mask_sh),\
-	SF(WBSCL_VERT_FILTER_INIT_Y_RGB, WBSCL_V_INIT_FRAC_Y_RGB, mask_sh),\
-	SF(WBSCL_VERT_FILTER_INIT_Y_RGB, WBSCL_V_INIT_INT_Y_RGB, mask_sh),\
-	SF(WBSCL_VERT_FILTER_INIT_CBCR, WBSCL_V_INIT_FRAC_CBCR, mask_sh),\
-	SF(WBSCL_VERT_FILTER_INIT_CBCR, WBSCL_V_INIT_INT_CBCR, mask_sh),\
-	SF(WBSCL_ROUND_OFFSET, WBSCL_ROUND_OFFSET_Y_RGB, mask_sh),\
-	SF(WBSCL_ROUND_OFFSET, WBSCL_ROUND_OFFSET_CBCR, mask_sh),\
-	SF(WBSCL_OVERFLOW_STATUS, WBSCL_DATA_OVERFLOW_FLAG, mask_sh),\
-	SF(WBSCL_OVERFLOW_STATUS, WBSCL_DATA_OVERFLOW_ACK, mask_sh),\
-	SF(WBSCL_OVERFLOW_STATUS, WBSCL_DATA_OVERFLOW_MASK, mask_sh),\
-	SF(WBSCL_OVERFLOW_STATUS, WBSCL_DATA_OVERFLOW_INT_STATUS, mask_sh),\
-	SF(WBSCL_OVERFLOW_STATUS, WBSCL_DATA_OVERFLOW_INT_TYPE, mask_sh),\
-	SF(WBSCL_COEF_RAM_CONFLICT_STATUS, WBSCL_HOST_CONFLICT_FLAG, mask_sh),\
-	SF(WBSCL_COEF_RAM_CONFLICT_STATUS, WBSCL_HOST_CONFLICT_ACK, mask_sh),\
-	SF(WBSCL_COEF_RAM_CONFLICT_STATUS, WBSCL_HOST_CONFLICT_MASK, mask_sh),\
-	SF(WBSCL_COEF_RAM_CONFLICT_STATUS, WBSCL_HOST_CONFLICT_INT_STATUS, mask_sh),\
-	SF(WBSCL_COEF_RAM_CONFLICT_STATUS, WBSCL_HOST_CONFLICT_INT_TYPE, mask_sh),\
-	SF(WBSCL_TEST_CNTL, WBSCL_TEST_CRC_EN, mask_sh),\
-	SF(WBSCL_TEST_CNTL, WBSCL_TEST_CRC_CONT_EN, mask_sh),\
-	SF(WBSCL_TEST_CRC_RED, WBSCL_TEST_CRC_RED_MASK, mask_sh),\
-	SF(WBSCL_TEST_CRC_RED, WBSCL_TEST_CRC_SIG_RED, mask_sh),\
-	SF(WBSCL_TEST_CRC_GREEN, WBSCL_TEST_CRC_GREEN_MASK, mask_sh),\
-	SF(WBSCL_TEST_CRC_GREEN, WBSCL_TEST_CRC_SIG_GREEN, mask_sh),\
-	SF(WBSCL_TEST_CRC_BLUE, WBSCL_TEST_CRC_BLUE_MASK, mask_sh),\
-	SF(WBSCL_TEST_CRC_BLUE, WBSCL_TEST_CRC_SIG_BLUE, mask_sh),\
-	SF(WBSCL_BACKPRESSURE_CNT_EN, WBSCL_BACKPRESSURE_CNT_EN, mask_sh),\
-	SF(WB_MCIF_BACKPRESSURE_CNT, WB_MCIF_Y_MAX_BACKPRESSURE, mask_sh),\
-	SF(WB_MCIF_BACKPRESSURE_CNT, WB_MCIF_C_MAX_BACKPRESSURE, mask_sh),\
-	SF(WBSCL_CLAMP_Y_RGB, WBSCL_CLAMP_UPPER_Y_RGB, mask_sh),\
-	SF(WBSCL_CLAMP_Y_RGB, WBSCL_CLAMP_LOWER_Y_RGB, mask_sh),\
-	SF(WBSCL_CLAMP_CBCR, WBSCL_CLAMP_UPPER_CBCR, mask_sh),\
-	SF(WBSCL_CLAMP_CBCR, WBSCL_CLAMP_LOWER_CBCR, mask_sh),\
-	SF(WBSCL_OUTSIDE_PIX_STRATEGY, WBSCL_OUTSIDE_PIX_STRATEGY, mask_sh),\
-	SF(WBSCL_OUTSIDE_PIX_STRATEGY, WBSCL_BLACK_COLOR_G_Y, mask_sh),\
-	SF(WBSCL_OUTSIDE_PIX_STRATEGY_CBCR, WBSCL_BLACK_COLOR_B_CB, mask_sh),\
-	SF(WBSCL_OUTSIDE_PIX_STRATEGY_CBCR, WBSCL_BLACK_COLOR_R_CR, mask_sh),\
-	SF(WBSCL_DEBUG, WBSCL_DEBUG, mask_sh),\
-	SF(WBSCL_TEST_DEBUG_INDEX, WBSCL_TEST_DEBUG_INDEX, mask_sh),\
-	SF(WBSCL_TEST_DEBUG_INDEX, WBSCL_TEST_DEBUG_WRITE_EN, mask_sh),\
-	SF(WBSCL_TEST_DEBUG_DATA, WBSCL_TEST_DEBUG_DATA, mask_sh),\
-	SF(WB_WARM_UP_MODE_CTL1, WIDTH_WARMUP, mask_sh),\
-	SF(WB_WARM_UP_MODE_CTL1, HEIGHT_WARMUP, mask_sh),\
-	SF(WB_WARM_UP_MODE_CTL1, GMC_WARM_UP_ENABLE, mask_sh),\
-	SF(WB_WARM_UP_MODE_CTL2, DATA_VALUE_WARMUP, mask_sh),\
-	SF(WB_WARM_UP_MODE_CTL2, MODE_WARMUP, mask_sh),\
-	SF(WB_WARM_UP_MODE_CTL2, DATA_DEPTH_WARMUP, mask_sh)
+	SF_DWB(WB_ENABLE, WB_ENABLE, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, DISPCLK_R_WB_GATE_DIS, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, DISPCLK_G_WB_GATE_DIS, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, DISPCLK_G_WBSCL_GATE_DIS, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, WB_TEST_CLK_SEL, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, WB_LB_LS_DIS, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, WB_LB_SD_DIS, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, WB_LUT_LS_DIS, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, WBSCL_LB_MEM_PWR_MODE_SEL, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, WBSCL_LB_MEM_PWR_DIS, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, WBSCL_LB_MEM_PWR_FORCE, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, WBSCL_LB_MEM_PWR_STATE, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, WB_RAM_PW_SAVE_MODE, mask_sh),\
+	SF_DWB(WB_EC_CONFIG, WBSCL_LUT_MEM_PWR_STATE, mask_sh),\
+	SF_DWB(CNV_MODE, CNV_OUT_BPC, mask_sh),\
+	SF_DWB(CNV_MODE, CNV_FRAME_CAPTURE_RATE, mask_sh),\
+	SF_DWB(CNV_MODE, CNV_WINDOW_CROP_EN, mask_sh),\
+	SF_DWB(CNV_MODE, CNV_STEREO_TYPE, mask_sh),\
+	SF_DWB(CNV_MODE, CNV_INTERLACED_MODE, mask_sh),\
+	SF_DWB(CNV_MODE, CNV_EYE_SELECTION, mask_sh),\
+	SF_DWB(CNV_MODE, CNV_STEREO_POLARITY, mask_sh),\
+	SF_DWB(CNV_MODE, CNV_INTERLACED_FIELD_ORDER, mask_sh),\
+	SF_DWB(CNV_MODE, CNV_STEREO_SPLIT, mask_sh),\
+	SF_DWB(CNV_MODE, CNV_NEW_CONTENT, mask_sh),\
+	SF_DWB(CNV_MODE, CNV_FRAME_CAPTURE_EN_CURRENT, mask_sh),\
+	SF_DWB(CNV_MODE, CNV_FRAME_CAPTURE_EN, mask_sh),\
+	SF_DWB(CNV_WINDOW_START, CNV_WINDOW_START_X, mask_sh),\
+	SF_DWB(CNV_WINDOW_START, CNV_WINDOW_START_Y, mask_sh),\
+	SF_DWB(CNV_WINDOW_SIZE, CNV_WINDOW_WIDTH, mask_sh),\
+	SF_DWB(CNV_WINDOW_SIZE, CNV_WINDOW_HEIGHT, mask_sh),\
+	SF_DWB(CNV_UPDATE, CNV_UPDATE_PENDING, mask_sh),\
+	SF_DWB(CNV_UPDATE, CNV_UPDATE_TAKEN, mask_sh),\
+	SF_DWB(CNV_UPDATE, CNV_UPDATE_LOCK, mask_sh),\
+	SF_DWB(CNV_SOURCE_SIZE, CNV_SOURCE_WIDTH, mask_sh),\
+	SF_DWB(CNV_SOURCE_SIZE, CNV_SOURCE_HEIGHT, mask_sh),\
+	SF_DWB(CNV_TEST_CNTL, CNV_TEST_CRC_EN, mask_sh),\
+	SF_DWB(CNV_TEST_CNTL, CNV_TEST_CRC_CONT_EN, mask_sh),\
+	SF_DWB(CNV_TEST_CRC_RED, CNV_TEST_CRC_RED_MASK, mask_sh),\
+	SF_DWB(CNV_TEST_CRC_RED, CNV_TEST_CRC_SIG_RED, mask_sh),\
+	SF_DWB(CNV_TEST_CRC_GREEN, CNV_TEST_CRC_GREEN_MASK, mask_sh),\
+	SF_DWB(CNV_TEST_CRC_GREEN, CNV_TEST_CRC_SIG_GREEN, mask_sh),\
+	SF_DWB(CNV_TEST_CRC_BLUE, CNV_TEST_CRC_BLUE_MASK, mask_sh),\
+	SF_DWB(CNV_TEST_CRC_BLUE, CNV_TEST_CRC_SIG_BLUE, mask_sh),\
+	SF_DWB(WB_DEBUG_CTRL, WB_DEBUG_EN, mask_sh),\
+	SF_DWB(WB_DEBUG_CTRL, WB_DEBUG_SEL, mask_sh),\
+	SF_DWB(WB_DBG_MODE, WB_DBG_MODE_EN, mask_sh),\
+	SF_DWB(WB_DBG_MODE, WB_DBG_DIN_FMT, mask_sh),\
+	SF_DWB(WB_DBG_MODE, WB_DBG_36MODE, mask_sh),\
+	SF_DWB(WB_DBG_MODE, WB_DBG_CMAP, mask_sh),\
+	SF_DWB(WB_DBG_MODE, WB_DBG_PXLRATE_ERROR, mask_sh),\
+	SF_DWB(WB_DBG_MODE, WB_DBG_SOURCE_WIDTH, mask_sh),\
+	SF_DWB(WB_HW_DEBUG, WB_HW_DEBUG, mask_sh),\
+	SF_DWB(WB_SOFT_RESET, WB_SOFT_RESET, mask_sh),\
+	SF_DWB(CNV_TEST_DEBUG_INDEX, CNV_TEST_DEBUG_INDEX, mask_sh),\
+	SF_DWB(CNV_TEST_DEBUG_INDEX, CNV_TEST_DEBUG_WRITE_EN, mask_sh),\
+	SF_DWB(CNV_TEST_DEBUG_DATA, CNV_TEST_DEBUG_DATA, mask_sh),\
+	SF_DWB(WBSCL_COEF_RAM_SELECT, WBSCL_COEF_RAM_TAP_PAIR_IDX, mask_sh),\
+	SF_DWB(WBSCL_COEF_RAM_SELECT, WBSCL_COEF_RAM_PHASE, mask_sh),\
+	SF_DWB(WBSCL_COEF_RAM_SELECT, WBSCL_COEF_RAM_FILTER_TYPE, mask_sh),\
+	SF_DWB(WBSCL_COEF_RAM_TAP_DATA, WBSCL_COEF_RAM_EVEN_TAP_COEF, mask_sh),\
+	SF_DWB(WBSCL_COEF_RAM_TAP_DATA, WBSCL_COEF_RAM_EVEN_TAP_COEF_EN, mask_sh),\
+	SF_DWB(WBSCL_COEF_RAM_TAP_DATA, WBSCL_COEF_RAM_ODD_TAP_COEF, mask_sh),\
+	SF_DWB(WBSCL_COEF_RAM_TAP_DATA, WBSCL_COEF_RAM_ODD_TAP_COEF_EN, mask_sh),\
+	SF_DWB(WBSCL_MODE, WBSCL_MODE, mask_sh),\
+	SF_DWB(WBSCL_MODE, WBSCL_OUT_BIT_DEPTH, mask_sh),\
+	SF_DWB(WBSCL_TAP_CONTROL, WBSCL_V_NUM_OF_TAPS_Y_RGB, mask_sh),\
+	SF_DWB(WBSCL_TAP_CONTROL, WBSCL_V_NUM_OF_TAPS_CBCR, mask_sh),\
+	SF_DWB(WBSCL_TAP_CONTROL, WBSCL_H_NUM_OF_TAPS_Y_RGB, mask_sh),\
+	SF_DWB(WBSCL_TAP_CONTROL, WBSCL_H_NUM_OF_TAPS_CBCR, mask_sh),\
+	SF_DWB(WBSCL_DEST_SIZE, WBSCL_DEST_HEIGHT, mask_sh),\
+	SF_DWB(WBSCL_DEST_SIZE, WBSCL_DEST_WIDTH, mask_sh),\
+	SF_DWB(WBSCL_HORZ_FILTER_SCALE_RATIO, WBSCL_H_SCALE_RATIO, mask_sh),\
+	SF_DWB(WBSCL_HORZ_FILTER_INIT_Y_RGB, WBSCL_H_INIT_FRAC_Y_RGB, mask_sh),\
+	SF_DWB(WBSCL_HORZ_FILTER_INIT_Y_RGB, WBSCL_H_INIT_INT_Y_RGB, mask_sh),\
+	SF_DWB(WBSCL_HORZ_FILTER_INIT_CBCR, WBSCL_H_INIT_FRAC_CBCR, mask_sh),\
+	SF_DWB(WBSCL_HORZ_FILTER_INIT_CBCR, WBSCL_H_INIT_INT_CBCR, mask_sh),\
+	SF_DWB(WBSCL_VERT_FILTER_SCALE_RATIO, WBSCL_V_SCALE_RATIO, mask_sh),\
+	SF_DWB(WBSCL_VERT_FILTER_INIT_Y_RGB, WBSCL_V_INIT_FRAC_Y_RGB, mask_sh),\
+	SF_DWB(WBSCL_VERT_FILTER_INIT_Y_RGB, WBSCL_V_INIT_INT_Y_RGB, mask_sh),\
+	SF_DWB(WBSCL_VERT_FILTER_INIT_CBCR, WBSCL_V_INIT_FRAC_CBCR, mask_sh),\
+	SF_DWB(WBSCL_VERT_FILTER_INIT_CBCR, WBSCL_V_INIT_INT_CBCR, mask_sh),\
+	SF_DWB(WBSCL_ROUND_OFFSET, WBSCL_ROUND_OFFSET_Y_RGB, mask_sh),\
+	SF_DWB(WBSCL_ROUND_OFFSET, WBSCL_ROUND_OFFSET_CBCR, mask_sh),\
+	SF_DWB(WBSCL_OVERFLOW_STATUS, WBSCL_DATA_OVERFLOW_FLAG, mask_sh),\
+	SF_DWB(WBSCL_OVERFLOW_STATUS, WBSCL_DATA_OVERFLOW_ACK, mask_sh),\
+	SF_DWB(WBSCL_OVERFLOW_STATUS, WBSCL_DATA_OVERFLOW_MASK, mask_sh),\
+	SF_DWB(WBSCL_OVERFLOW_STATUS, WBSCL_DATA_OVERFLOW_INT_STATUS, mask_sh),\
+	SF_DWB(WBSCL_OVERFLOW_STATUS, WBSCL_DATA_OVERFLOW_INT_TYPE, mask_sh),\
+	SF_DWB(WBSCL_COEF_RAM_CONFLICT_STATUS, WBSCL_HOST_CONFLICT_FLAG, mask_sh),\
+	SF_DWB(WBSCL_COEF_RAM_CONFLICT_STATUS, WBSCL_HOST_CONFLICT_ACK, mask_sh),\
+	SF_DWB(WBSCL_COEF_RAM_CONFLICT_STATUS, WBSCL_HOST_CONFLICT_MASK, mask_sh),\
+	SF_DWB(WBSCL_COEF_RAM_CONFLICT_STATUS, WBSCL_HOST_CONFLICT_INT_STATUS, mask_sh),\
+	SF_DWB(WBSCL_COEF_RAM_CONFLICT_STATUS, WBSCL_HOST_CONFLICT_INT_TYPE, mask_sh),\
+	SF_DWB(WBSCL_TEST_CNTL, WBSCL_TEST_CRC_EN, mask_sh),\
+	SF_DWB(WBSCL_TEST_CNTL, WBSCL_TEST_CRC_CONT_EN, mask_sh),\
+	SF_DWB(WBSCL_TEST_CRC_RED, WBSCL_TEST_CRC_RED_MASK, mask_sh),\
+	SF_DWB(WBSCL_TEST_CRC_RED, WBSCL_TEST_CRC_SIG_RED, mask_sh),\
+	SF_DWB(WBSCL_TEST_CRC_GREEN, WBSCL_TEST_CRC_GREEN_MASK, mask_sh),\
+	SF_DWB(WBSCL_TEST_CRC_GREEN, WBSCL_TEST_CRC_SIG_GREEN, mask_sh),\
+	SF_DWB(WBSCL_TEST_CRC_BLUE, WBSCL_TEST_CRC_BLUE_MASK, mask_sh),\
+	SF_DWB(WBSCL_TEST_CRC_BLUE, WBSCL_TEST_CRC_SIG_BLUE, mask_sh),\
+	SF_DWB(WBSCL_BACKPRESSURE_CNT_EN, WBSCL_BACKPRESSURE_CNT_EN, mask_sh),\
+	SF_DWB(WB_MCIF_BACKPRESSURE_CNT, WB_MCIF_Y_MAX_BACKPRESSURE, mask_sh),\
+	SF_DWB(WB_MCIF_BACKPRESSURE_CNT, WB_MCIF_C_MAX_BACKPRESSURE, mask_sh),\
+	SF_DWB(WBSCL_CLAMP_Y_RGB, WBSCL_CLAMP_UPPER_Y_RGB, mask_sh),\
+	SF_DWB(WBSCL_CLAMP_Y_RGB, WBSCL_CLAMP_LOWER_Y_RGB, mask_sh),\
+	SF_DWB(WBSCL_CLAMP_CBCR, WBSCL_CLAMP_UPPER_CBCR, mask_sh),\
+	SF_DWB(WBSCL_CLAMP_CBCR, WBSCL_CLAMP_LOWER_CBCR, mask_sh),\
+	SF_DWB(WBSCL_OUTSIDE_PIX_STRATEGY, WBSCL_OUTSIDE_PIX_STRATEGY, mask_sh),\
+	SF_DWB(WBSCL_OUTSIDE_PIX_STRATEGY, WBSCL_BLACK_COLOR_G_Y, mask_sh),\
+	SF_DWB(WBSCL_OUTSIDE_PIX_STRATEGY_CBCR, WBSCL_BLACK_COLOR_B_CB, mask_sh),\
+	SF_DWB(WBSCL_OUTSIDE_PIX_STRATEGY_CBCR, WBSCL_BLACK_COLOR_R_CR, mask_sh),\
+	SF_DWB(WBSCL_DEBUG, WBSCL_DEBUG, mask_sh),\
+	SF_DWB(WBSCL_TEST_DEBUG_INDEX, WBSCL_TEST_DEBUG_INDEX, mask_sh),\
+	SF_DWB(WBSCL_TEST_DEBUG_INDEX, WBSCL_TEST_DEBUG_WRITE_EN, mask_sh),\
+	SF_DWB(WBSCL_TEST_DEBUG_DATA, WBSCL_TEST_DEBUG_DATA, mask_sh),\
+	SF_DWB(WB_WARM_UP_MODE_CTL1, WIDTH_WARMUP, mask_sh),\
+	SF_DWB(WB_WARM_UP_MODE_CTL1, HEIGHT_WARMUP, mask_sh),\
+	SF_DWB(WB_WARM_UP_MODE_CTL1, GMC_WARM_UP_ENABLE, mask_sh),\
+	SF_DWB(WB_WARM_UP_MODE_CTL2, DATA_VALUE_WARMUP, mask_sh),\
+	SF_DWB(WB_WARM_UP_MODE_CTL2, MODE_WARMUP, mask_sh),\
+	SF_DWB(WB_WARM_UP_MODE_CTL2, DATA_DEPTH_WARMUP, mask_sh)
 
 #define DWBC_REG_FIELD_LIST_DCN2_0(type) \
 	type WB_ENABLE;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.h
index 7bcee5894d2e..5ab32aa51e13 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.h
@@ -29,13 +29,6 @@
 #define TO_DCN20_MMHUBBUB(mcif_wb_base) \
 	container_of(mcif_wb_base, struct dcn20_mmhubbub, base)
 
-/* DCN */
-#define BASE_INNER(seg) \
-	DCE_BASE__INST0_SEG ## seg
-
-#define BASE(seg) \
-	BASE_INNER(seg)
-
 #define MCIF_WB_COMMON_REG_LIST_DCN2_0(inst) \
 	SRI(MCIF_WB_BUFMGR_SW_CONTROL, MCIF_WB, inst),\
 	SRI(MCIF_WB_BUFMGR_CUR_LINE_R, MCIF_WB, inst),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index d0199ec045cb..8a0dd0d7134b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -124,8 +124,6 @@ enum dcn20_clk_src_array_id {
  * macros to expend register list macro defined in HW object header file */
 
 /* DCN */
-/* TODO awful hack. fixup dcn20_dwb.h */
-#undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
 #define BASE(seg) BASE_INNER(seg)
@@ -138,6 +136,15 @@ enum dcn20_clk_src_array_id {
 	.reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 					mm ## block ## id ## _ ## reg_name
 
+#define SRI2_DWB(reg_name, block, id)\
+	.reg_name = BASE(mm ## reg_name ## _BASE_IDX) + \
+					mm ## reg_name
+#define SF_DWB(reg_name, field_name, post_fix)\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+#define SF_DWB2(reg_name, block, id, field_name, post_fix)	\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
 #define SRIR(var_name, reg_name, block, id)\
 	.var_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 					mm ## block ## id ## _ ## reg_name
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h
index f1ef46e8da5b..e7a1b7fa2cce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h
@@ -28,12 +28,6 @@
 
 #include "vmid.h"
 
-#define BASE_INNER(seg) \
-	DCE_BASE__INST0_SEG ## seg
-
-#define BASE(seg) \
-	BASE_INNER(seg)
-
 #define DCN20_VMID_REG_LIST(id)\
 	SRI(CNTL, DCN_VM_CONTEXT, id),\
 	SRI(PAGE_TABLE_BASE_ADDR_HI32, DCN_VM_CONTEXT, id),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index ce6c70e25703..fbcf0afeae0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -94,8 +94,6 @@
  * macros to expend register list macro defined in HW object header file */
 
 /* DCN */
-/* TODO awful hack. fixup dcn20_dwb.h */
-#undef BASE_INNER
 #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
 
 #define BASE(seg) BASE_INNER(seg)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
index 1010930cf071..fc00ec0a0881 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
@@ -27,21 +27,6 @@
 #define TO_DCN30_DWBC(dwbc_base) \
 	container_of(dwbc_base, struct dcn30_dwbc, base)
 
-/* DCN */
-#define BASE_INNER(seg) \
-	DCE_BASE__INST0_SEG ## seg
-
-#define BASE(seg) \
-	BASE_INNER(seg)
-
-#define SF_DWB(reg_name, block, id, field_name, post_fix)\
-	.field_name = block ## id ## _ ## reg_name ## __ ## field_name ## post_fix
-
- /* set field name */
-#define SF_DWB2(reg_name, block, id, field_name, post_fix)\
-	.field_name = reg_name ## __ ## field_name ## post_fix
-
-
 #define DWBC_COMMON_REG_LIST_DCN30(inst) \
 	SR(DWB_ENABLE_CLK_CTRL),\
 	SR(DWB_MEM_PWR_CTRL),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.h
index 7446e54bf5aa..376620a8f02f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.h
@@ -31,13 +31,6 @@
 #define TO_DCN30_MMHUBBUB(mcif_wb_base) \
 	container_of(mcif_wb_base, struct dcn30_mmhubbub, base)
 
-/* DCN */
-#define BASE_INNER(seg) \
-	DCE_BASE__INST0_SEG ## seg
-
-#define BASE(seg) \
-	BASE_INNER(seg)
-
 #define MCIF_WB_COMMON_REG_LIST_DCN3_0(inst) \
 	SRI(MCIF_WB_BUFMGR_SW_CONTROL, MCIF_WB, inst),\
 	SRI(MCIF_WB_BUFMGR_STATUS, MCIF_WB, inst),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index af4fe695535e..ef5035d200f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -108,8 +108,6 @@ enum dcn30_clk_src_array_id {
  */
 
 /* DCN */
-/* TODO awful hack. fixup dcn20_dwb.h */
-#undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
 #define BASE(seg) BASE_INNER(seg)
@@ -142,6 +140,9 @@ enum dcn30_clk_src_array_id {
 	.reg_name[id] = BASE(mm ## block ## id ## _ ## temp_name ## _BASE_IDX) + \
 					mm ## block ## id ## _ ## temp_name
 
+#define SF_DWB2(reg_name, block, id, field_name, post_fix)	\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
 #define DCCG_SRII(reg_name, block, id)\
 	.block ## _ ## reg_name[id] = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 					mm ## block ## id ## _ ## reg_name
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index f04595b750ab..608e8c4a9917 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -107,8 +107,6 @@ enum dcn301_clk_src_array_id {
  */
 
 /* DCN */
-/* TODO awful hack. fixup dcn20_dwb.h */
-#undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
 #define BASE(seg) BASE_INNER(seg)
@@ -146,6 +144,9 @@ enum dcn301_clk_src_array_id {
 	.reg_name[id] = BASE(mm ## block ## id ## _ ## temp_name ## _BASE_IDX) + \
 					mm ## block ## id ## _ ## temp_name
 
+#define SF_DWB2(reg_name, block, id, field_name, post_fix)	\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
 #define DCCG_SRII(reg_name, block, id)\
 	.block ## _ ## reg_name[id] = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 					mm ## block ## id ## _ ## reg_name
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index d3945876aced..ede1947cd228 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -183,7 +183,6 @@ static const struct dc_plane_cap plane_cap = {
 		mm ## reg_name
 
 /* DCN */
-#undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
 #define BASE(seg) BASE_INNER(seg)
@@ -216,6 +215,9 @@ static const struct dc_plane_cap plane_cap = {
 		.reg_name[id] = BASE(mm ## block ## id ## _ ## temp_name ## _BASE_IDX) + \
 		mm ## block ## id ## _ ## temp_name
 
+#define SF_DWB2(reg_name, block, id, field_name, post_fix)	\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
 #define SRII_MPC_RMU(reg_name, block, id)\
 		.RMU##_##reg_name[id] = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		mm ## block ## id ## _ ## reg_name
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 7e7f18bef098..065da17f499e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -162,7 +162,6 @@ static const struct dc_plane_cap plane_cap = {
 		mm ## reg_name
 
 /* DCN */
-#undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
 #define BASE(seg) BASE_INNER(seg)
@@ -195,6 +194,9 @@ static const struct dc_plane_cap plane_cap = {
 		.reg_name[id] = BASE(mm ## block ## id ## _ ## temp_name ## _BASE_IDX) + \
 		mm ## block ## id ## _ ## temp_name
 
+#define SF_DWB2(reg_name, block, id, field_name, post_fix)	\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
 #define SRII_MPC_RMU(reg_name, block, id)\
 		.RMU##_##reg_name[id] = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		mm ## block ## id ## _ ## reg_name
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index cc004acb2f47..e91f7363b225 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -119,8 +119,6 @@ enum dcn31_clk_src_array_id {
  */
 
 /* DCN */
-/* TODO awful hack. fixup dcn20_dwb.h */
-#undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
 #define BASE(seg) BASE_INNER(seg)
@@ -153,6 +151,9 @@ enum dcn31_clk_src_array_id {
 	.reg_name[id] = BASE(reg ## block ## id ## _ ## temp_name ## _BASE_IDX) + \
 					reg ## block ## id ## _ ## temp_name
 
+#define SF_DWB2(reg_name, block, id, field_name, post_fix)	\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
 #define DCCG_SRII(reg_name, block, id)\
 	.block ## _ ## reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 					reg ## block ## id ## _ ## reg_name
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 3b3e093e9447..4fffc7bb8088 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -184,6 +184,9 @@ enum dcn31_clk_src_array_id {
 	.reg_name[id] = BASE(reg ## block ## id ## _ ## temp_name ## _BASE_IDX) + \
 					reg ## block ## id ## _ ## temp_name
 
+#define SF_DWB2(reg_name, block, id, field_name, post_fix)	\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
 #define DCCG_SRII(reg_name, block, id)\
 	.block ## _ ## reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 					reg ## block ## id ## _ ## reg_name
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 2d05e8d843c9..17601b13da1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -151,8 +151,6 @@ enum dcn31_clk_src_array_id {
  */
 
 /* DCN */
-/* TODO awful hack. fixup dcn20_dwb.h */
-#undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
 #define BASE(seg) BASE_INNER(seg)
@@ -185,6 +183,9 @@ enum dcn31_clk_src_array_id {
 	.reg_name[id] = BASE(reg ## block ## id ## _ ## temp_name ## _BASE_IDX) + \
 					reg ## block ## id ## _ ## temp_name
 
+#define SF_DWB2(reg_name, block, id, field_name, post_fix)	\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
 #define DCCG_SRII(reg_name, block, id)\
 	.block ## _ ## reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 					reg ## block ## id ## _ ## reg_name
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 9a82f8f66f28..b4d5076e124c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -142,8 +142,6 @@ enum dcn31_clk_src_array_id {
  */
 
 /* DCN */
-/* TODO awful hack. fixup dcn20_dwb.h */
-#undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
 #define BASE(seg) BASE_INNER(seg)
@@ -176,6 +174,9 @@ enum dcn31_clk_src_array_id {
 	.reg_name[id] = BASE(reg ## block ## id ## _ ## temp_name ## _BASE_IDX) + \
 					reg ## block ## id ## _ ## temp_name
 
+#define SF_DWB2(reg_name, block, id, field_name, post_fix)	\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
 #define DCCG_SRII(reg_name, block, id)\
 	.block ## _ ## reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 					reg ## block ## id ## _ ## reg_name
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index f6c3a2f7a228..e525b85acc63 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -106,8 +106,6 @@ enum dcn32_clk_src_array_id {
  */
 
 /* DCN */
-/* TODO awful hack. fixup dcn20_dwb.h */
-#undef BASE_INNER
 #define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
 
 #define BASE(seg) BASE_INNER(seg)
@@ -167,6 +165,9 @@ enum dcn32_clk_src_array_id {
 	REG_STRUCT.reg_name[id] = BASE(reg ## block ## id ## _ ## temp_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## temp_name
 
+#define SF_DWB2(reg_name, block, id, field_name, post_fix)	\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
 #define DCCG_SRII(reg_name, block, id)\
 	REG_STRUCT.block ## _ ## reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index e5861225f1df..498f6a6f75a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -109,8 +109,6 @@ enum dcn321_clk_src_array_id {
  */
 
 /* DCN */
-/* TODO awful hack. fixup dcn20_dwb.h */
-#undef BASE_INNER
 #define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
 
 #define BASE(seg) BASE_INNER(seg)
@@ -174,6 +172,9 @@ enum dcn321_clk_src_array_id {
 	REG_STRUCT.block ## _ ## reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
 
+#define SF_DWB2(reg_name, block, id, field_name, post_fix) \
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
 #define VUPDATE_SRII(reg_name, block, id)\
 	REG_STRUCT.reg_name[id] = BASE(reg ## reg_name ## _ ## block ## id ## _BASE_IDX) + \
 		reg ## reg_name ## _ ## block ## id
-- 
2.25.1

