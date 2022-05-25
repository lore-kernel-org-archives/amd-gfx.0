Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A15C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0876010EEC7;
	Wed, 25 May 2022 16:20:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA5610E677
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaiSrurkZ6mXhiKU0fO5+fxy3Unh9VyOvhf0VsPxErQasYiImpETezv6j4ph4i6Ie5nMCV1720xT13XJ9DgL/gATNZfQDT3dvVNAzFemPXnqAUQxKPZ+0sdS9aIKy8f4gFdzADYUXimTjPCq78yDMeyzTZWiZXuOoKYVXdqCh1O0Upk4Ygy6sR2VLcrqwvqQ2KmgW2re0h9zluPPIleN8/7dNqvulew8RVOUBA01LmAfHZ7F7D5ZTPPgNspnQ1N35ljZfxp8b+rYMZ1HXEpnJGEIK/otfttujD1cWI8Hh5xF99MhneNJBv2umQUShVy9NkObcgfnEduWo6yw973AVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+lB99sogz4TDNDYE/3q+KBFsZj4yl5BhMYQutEWl6k=;
 b=ZxYB3ghH1AYyfUYvrciPa3tOQnFH10YlUCxI1kPKX40+ux8pqfC7asnlmHGevy7mtLTWoucSiG6XNzWSd/nosElRh7ZlDtVzMbAp/a8JLcQuBDBpL3H7+H4DGPVe7ZewGhvGwoJQBC0I/B420+33E7osEUEs62K544+Z+SJxXYUwaJIhLpH7fjmve3ZVWeoUmS41+pYGynBMI71gh7FDhKZXQLTLXImVzCzv7i0/p6KGIR7ReMyVRVngMmhm5cgaNQXeoOMw+lEamzsO9VRYg5u/cjJYu0XwvOpxupFHY5+cXDb4/CenvIGjOjAVrS1Gtg6KgDhCg5dwj9zutTWLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+lB99sogz4TDNDYE/3q+KBFsZj4yl5BhMYQutEWl6k=;
 b=WPBA2KqPnEL/I8ZTGQRTul8N12Wgh5BdhZGdYJgobO7QhFa3zzkBHGTeFx3aFZO9OV6xjVf7rUwI/ZF0wMyoGN3+YwLS4VVX9Vnr3bcvalcv0ltU9HGZl4LCsnivNlb+56SHH8yP32J7eS/mWMSigc8gYaWgKvs8G6DFLtzVxzo=
Received: from DM5PR05CA0001.namprd05.prod.outlook.com (2603:10b6:3:d4::11) by
 BN8PR12MB3300.namprd12.prod.outlook.com (2603:10b6:408:6a::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Wed, 25 May 2022 16:20:24 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::e0) by DM5PR05CA0001.outlook.office365.com
 (2603:10b6:3:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 39/43] drm/amd/display: FCLK P-state support updates
Date: Wed, 25 May 2022 12:19:37 -0400
Message-ID: <20220525161941.2544055-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea7043cd-32ef-4dc5-e013-08da3e6a78ae
X-MS-TrafficTypeDiagnostic: BN8PR12MB3300:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB330009285B409E7F5871C16FF7D69@BN8PR12MB3300.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6t573vlo48tHq38mUFpteX97gog91UYRgmgxSLxPv6HOmLL6VwoqMa7NUkTcZ8td3cDCYz3vPjEflvNoXbzeHhKmUC/N4kuANjUYbl61EYjPVEpxDA//Pap0hx6Bae/V2otwM6NlBYMU09O3mb3Q4SfsrViw17CMIje3oxKF/QDZ5w+wn5LDNtKN9hLyFoEYVJp72vLXbBmop28y43K9NJ0jbSw3G583fnE1dlCoefDyGWGwhm62JTMWd3zJ4BiEi7FTE37FA7waX76hSHd/XdK7hRZdbccV+ZeIGbNggqZXnYCoy6Kmy5zDjCg4JmMR36uRcKsWOouA+jy2A6pdveG9eWE9csGiPjMq4hP7MAla7rZuY6RcTcEhnGfh9Chon36r3S5yFWrVxUon2RYL//m0UEckY/De4ipUrA2U6bH5JeZSnlIuiPbNV/Sq8eHCI0gMmnmQUbn4mlLJQmfmxPjMlAO6DMNqhzZm7mPliaiT9ykEKg3nXQajjqJkQytTjSQku8I5A/ULXOPFBLbjPJsEJ6Rz/PUVkKVgAM4isSHIKLx7tdeIg1oUfMmWDhA8dyP9KUr2jQR4nDeSToaBQIRyw62uSCQcYyyT8ljQoKfPNxykz4LnHuzmrRTnBk90Wk1KTHWFu7fDUR6+/c2h/WQIc6oJ73l6flfRo3DTXNl25VuZIKky7KA7udAcrKwZi7cl28QAnS0dY0xDquPlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(6916009)(1076003)(336012)(4326008)(83380400001)(356005)(82310400005)(70206006)(70586007)(36860700001)(15650500001)(426003)(47076005)(186003)(16526019)(36756003)(54906003)(2616005)(8676002)(26005)(5660300002)(86362001)(40460700003)(8936002)(2906002)(508600001)(6666004)(7696005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:23.7591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7043cd-32ef-4dc5-e013-08da3e6a78ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3300
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Chaitanya Dhere <chaitanya.dhere@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chaitanya Dhere <chaitanya.dhere@amd.com>

[Why]
Previously we used to send FCLK P-state enable messages upon each call
to update_clocks based on dml output. This resulted in increased message
transactions between DC and PMFW.

[How]
Update the code to check safe_to_lower status and send the message based
on dml input only on boot. This reduces message transactions. Also
remove other unwanted code based on current code status.

Signed-off-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 11 +++++++----
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h  |  1 -
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 390432537305..6a1d7c86e6b7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -284,7 +284,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool dpp_clock_lowered = false;
 	struct dmcu *dmcu = clk_mgr_base->ctx->dc->res_pool->dmcu;
 	bool force_reset = false;
-	bool update_uclk = false;
+	bool update_uclk = false, update_fclk = false;
 	bool p_state_change_support;
 	bool fclk_p_state_change_support;
 	int total_plane_count;
@@ -371,14 +371,17 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			update_uclk = true;
 		}
 
+		/* Always update saved value, even if new value not set due to P-State switching unsupported. Also check safe_to_lower for FCLK */
+		if (safe_to_lower && (clk_mgr_base->clks.fclk_p_state_change_support != clk_mgr_base->clks.fclk_prev_p_state_change_support)) {
+			update_fclk = true;
+		}
+
 		/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
 		if (clk_mgr_base->clks.p_state_change_support &&
 				(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support))
 			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 
-		if (clk_mgr_base->clks.fclk_p_state_change_support &&
-				(update_uclk || !clk_mgr_base->clks.fclk_prev_p_state_change_support)) {
-
+		if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 && clk_mgr_base->clks.fclk_p_state_change_support && update_fclk) {
 			/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
 			dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_SUPPORTED);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
index ee6259108add..5f69cdcb9885 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
@@ -33,7 +33,6 @@
 #define FCLK_PSTATE_SUPPORTED          0x01
 
 /* TODO Remove this MSG ID define after it becomes available in dalsmc */
-#define DALSMC_MSG_SetFclkSwitchAllow	0x11
 #define DALSMC_MSG_SetCabForUclkPstate	0x12
 #define DALSMC_Result_OK				0x1
 
-- 
2.35.3

