Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27FFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0591113FEA;
	Fri, 10 Jun 2022 20:53:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A093113FD0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2HOS90I/wxf+qEbt2wgX55deDGy9eL9mkztxqmjWV6A5Ws2ODu+DyffEnR4na0sU3PJZWpynjNd+9GaR6j2YQc4g59LA6CERynYE2vOqqRqHwPyhPgz3k940KKTa6ypSvoE610gU9hn5nJ+WDtQBxT4D5ZvhUDbplhrB3HtiNg6qiSii38QvKplluM/eO1/ADtHd3teH7p3P2GnUyMHVy9RCMhDVPGP+Kobci/jtoyO1vG0IQCBEJFF0aNS7SNlwcVq+x3P1Onone8A5AQuxTmZuxv5OKc695fKHkRrm1K8okUAdKIQlR8vAWyY61a9PwbhrQ8laZs7APPJdtiBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdff8JO+HEln1XCM7fOoakEpGKEFC5TCNhHWu1YYfNc=;
 b=K5b4OWXqItPO0eTAQVEJ6YAtyIfMMomLEvQ9oU/Ioe8HdKsBylFdQt2y4rs4DOoMO22vBvBlzkpd66fgBgRRrC0fTlQ+vHS3IeysAfoUXeRL20lsGJ73/QgX9DoIp2DnaBs7LgRZRzoRuRsZIau5DKgjZyUJtjm785JyESsj69/75nSptwVWXMux96mMQVFPjRuDdXGoaRpAQWiK3rQ4KFlrjXAfIkKHZz4eWlYucvOnr8CPpI0KAFLaWMipbzN5asmFAmWH3MkrMiPV204ZwiZCG2SQOVNFe2DH1+fsSw28wzHREXO6koxzLpu/hTffgXHedrG6GHNjzbSzVYQbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdff8JO+HEln1XCM7fOoakEpGKEFC5TCNhHWu1YYfNc=;
 b=F7MUT1kDkjgmOiZM7tpusT236a7lmnu+Jrw6Aj35MR6rP1s/ywG9/tV/ILDI0BciSYkvF7LDTIKmX3vpwGQi5m0dsPOT47V5vVNleYH82UKhoxczGd0wb5smzKmDmvz9ttfYVmG0UBHU8dpvuQkTMg4DFE7p4I81Js/Zrb+kf08=
Received: from MW4PR03CA0169.namprd03.prod.outlook.com (2603:10b6:303:8d::24)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Fri, 10 Jun
 2022 20:53:27 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::b) by MW4PR03CA0169.outlook.office365.com
 (2603:10b6:303:8d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:27 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:25 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/23] drm/amd/display: DAL ACR, dc part, fix missing dcn30
Date: Fri, 10 Jun 2022 16:52:36 -0400
Message-ID: <20220610205245.174802-15-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 345417e1-a8f6-4193-cb76-08da4b234497
X-MS-TrafficTypeDiagnostic: PH7PR12MB6562:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB656278AB96D1E010E73C82FBF4A69@PH7PR12MB6562.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqU663qDW+/Ure/7AMGK1B0sPu+kx6VHkPdvW/UIjlQ8bU7iRnydkyJvEsKuy1+BPDbyFyEn2SuTZkUr50TXLqkr0tUT1OA/QBzAaVNLtOhwyCc9pEMdzVO0vkqhH41PDzo1rX3kYKiAe+Inj8JODHlw74MI1acUnNWLfZtFYpyBfoC//lzUYcDfISh6jdSCUBth0Fy9ybS2Zt5GN5gI/35MSjaN1pfhhIOcBz1KV2T+nA1gSv6DuU921jJkm5jEJ8b8B1B2GiTb+uU6qzy68GSW9h3DJyy+51HLYK6KP/VNVKOBkUzSb58sYI7xMi72d+zzG1jOFJpPb7xHN6XeIdgZjgwurmFcTLSh8kLx5vgQytXR6zfkI16qush88T5mWEOPmXLo0yuQWUPfENcZ+IwVDfz9On2nZBzYY8DBSvEm8Upi9/gC34lrIPmMvJrDSbXjdLdFuPk2bPFfY1SaX8DjWQy/JrCmJBPkYI2aCl2CnoydBu8wMesNPx+XMmRIUtLUeYGHsddwnFeOfyPhLZpR/DjiJcFmvkdoiWX/ScVzqMYBpmpqaQT72696R0OhbsK4o42rSK1YxfKTc4YX1/LseSzFCV0+f632Y94wmJVHwuuQymGTfoM8UfMajPoeEm47HR4SmZGL+tQvCzFU64hKa7GIuLkyMXeG2kVoItdoQR/BGTQn+7l/WN8XcQSinE+P+S2p3x/cmUiyQL99khPn6vgFlg/QQvrl9ahU6Z4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(8676002)(356005)(86362001)(70586007)(336012)(47076005)(5660300002)(4326008)(8936002)(82310400005)(70206006)(83380400001)(6916009)(36860700001)(44832011)(36756003)(54906003)(426003)(81166007)(40460700003)(6666004)(26005)(316002)(2906002)(2616005)(1076003)(186003)(7696005)(16526019)(508600001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:27.1365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 345417e1-a8f6-4193-cb76-08da4b234497
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Alan Liu <HaoPing.Liu@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

[Why]
- missing in dcn30 function
- Fix a divide by 0 when ACR trigger

[How]
- Add IS_SMU_TIMEOUT() to dcn30_smu_send_msg_with_param
- Add zero check in dcn20_update_clocks_update_dentist

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 22 +++++++++++++------
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  | 11 +++++++++-
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index fb82e9f9738e..0d30d1d9d67e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -126,16 +126,24 @@ void dcn20_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 
 void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr, struct dc_state *context)
 {
-	int dpp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-			* clk_mgr->base.dentist_vco_freq_khz / clk_mgr->base.clks.dppclk_khz;
-	int disp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-			* clk_mgr->base.dentist_vco_freq_khz / clk_mgr->base.clks.dispclk_khz;
-
-	uint32_t dppclk_wdivider = dentist_get_did_from_divider(dpp_divider);
-	uint32_t dispclk_wdivider = dentist_get_did_from_divider(disp_divider);
+	int dpp_divider = 0;
+	int disp_divider = 0;
+	uint32_t dppclk_wdivider = 0;
+	uint32_t dispclk_wdivider = 0;
 	uint32_t current_dispclk_wdivider;
 	uint32_t i;
 
+	if (clk_mgr->base.clks.dppclk_khz == 0 || clk_mgr->base.clks.dispclk_khz == 0)
+		return;
+
+	dpp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+		* clk_mgr->base.dentist_vco_freq_khz / clk_mgr->base.clks.dppclk_khz;
+	disp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+		* clk_mgr->base.dentist_vco_freq_khz / clk_mgr->base.clks.dispclk_khz;
+
+	dppclk_wdivider = dentist_get_did_from_divider(dpp_divider);
+	dispclk_wdivider = dentist_get_did_from_divider(disp_divider);
+
 	REG_GET(DENTIST_DISPCLK_CNTL,
 			DENTIST_DISPCLK_WDIVIDER, &current_dispclk_wdivider);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
index bfc960579760..1fbf1c105dc1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
@@ -28,6 +28,8 @@
 
 #include "clk_mgr_internal.h"
 #include "reg_helper.h"
+#include "dm_helpers.h"
+
 #include "dalsmc.h"
 #include "dcn30_smu11_driver_if.h"
 
@@ -74,6 +76,7 @@ static uint32_t dcn30_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, un
 
 static bool dcn30_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, uint32_t msg_id, uint32_t param_in, uint32_t *param_out)
 {
+	uint32_t result;
 	/* Wait for response register to be ready */
 	dcn30_smu_wait_for_response(clk_mgr, 10, 200000);
 
@@ -86,8 +89,14 @@ static bool dcn30_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, uint
 	/* Trigger the message transaction by writing the message ID */
 	REG_WRITE(DAL_MSG_REG, msg_id);
 
+	result = dcn30_smu_wait_for_response(clk_mgr, 10, 200000);
+
+	if (IS_SMU_TIMEOUT(result)) {
+		dm_helpers_smu_timeout(CTX, msg_id, param_in, 10 * 200000);
+	}
+
 	/* Wait for response */
-	if (dcn30_smu_wait_for_response(clk_mgr, 10, 200000) == DALSMC_Result_OK) {
+	if (result == DALSMC_Result_OK) {
 		if (param_out)
 			*param_out = REG_READ(DAL_ARG_REG);
 
-- 
2.36.1

