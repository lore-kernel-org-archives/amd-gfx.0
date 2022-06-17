Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EF1C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79ED510F393;
	Fri, 17 Jun 2022 19:35:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B49010F2A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6Vm0UQRaLt1E+KW5QpnfwxBPY1mbKqYQ5uctuBhLe5ms1XqSS9Rh/Ia22SNst9DrriLPeD1GmBTDOXRHyugDfmHnNlDnUD5KSo9s8Dn0r1I0vZJHP7OExxMQfZSFG34v8htEZraG99zr05Ohpl26Q+1zO/hHa7ikZTjTWAoqt9+ytEciFsQ8fWaC1NqZSKDANuBkgavM4HmBvcTB5YeC24L7vPD1qcfHw5e6cwgJfMPmYBXSU0c0vy/QXGY3dyVy5d7G3VbZDoaa/SuC+TODKGG4P2+hHPbskYfIWt8Udu6Jx371+WgZ/tThAR4ZEYRjm44YhQH4WrFRad6zdqElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkcLvEk0XCjPs9aflSJIVxwW7XNWfh9IQg929XWJfeg=;
 b=FTawhM6rFBUzAMnQG9igSclQwjkDpy3UOxNiCMoB8Emx+VXoOBlE/c4mNH+T5yhez8aMvBvIXRx87x7MGTSrSCVNj+igl2/XJ0kOVU8hvGgchDRLuMK/3UHBPecsspzNl3CTY12m+RfrhB2NBFdaiwkikuKJDt2CaLMc9vgfpDguFH95MDZCAfCTIkCegM8UCSoPNks7EDSb889rIuh50I2CW7UmxGeTsHj7QxCKIHxaFCkmGKLWx6HhKNGjQd7YYObTU+kmgt4hJYl/yOho/C9vKr9og5r/xc4v+u/0ZdK3IQGBPVFRcv+ruKAl16mSF03pW97uAQdSlxGKRvWvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkcLvEk0XCjPs9aflSJIVxwW7XNWfh9IQg929XWJfeg=;
 b=SnnmPtxyadrJh1YgNWSGdFZiSmma6Kp56lKc5gqai4BKuXpIMN5huclfe4cqJybFbT+H1Xi1qNDbca2HTt6rUgG/NiXg8WYS/bJS64h66hrOrKOHCz9myH7Hflc/R9mSZOi9fNKTf5kuVxVQEOH5H3/poIS7bJWojnRVpLqsuew=
Received: from BN9PR03CA0150.namprd03.prod.outlook.com (2603:10b6:408:fe::35)
 by BN6PR12MB1921.namprd12.prod.outlook.com (2603:10b6:404:fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:35:52 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::c9) by BN9PR03CA0150.outlook.office365.com
 (2603:10b6:408:fe::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:52 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:50 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/31] drm/amd/display: rename lane_settings to
 hw_lane_settings
Date: Fri, 17 Jun 2022 15:34:56 -0400
Message-ID: <20220617193512.3471076-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91e2fa54-0f62-4fee-1756-08da509896de
X-MS-TrafficTypeDiagnostic: BN6PR12MB1921:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1921C28A16D6F5AE1BB1EB3E98AF9@BN6PR12MB1921.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9NidTZfqL4jy92/iDiOrG1tXEHzKVVy7tSjl27FY3YZJyQmVanRReaZKTmrb5oOrakzMtsuTgPSrDG9IEZpGgJ+QbgmFlCXw1NNXrQBPiLvYIRaOQX1TIBrdeNLhmH4O9jUJd3Gu1r4TWylQV6PdVFgZTIURY3KBcwe5olDWBj4JbSJaEXD8hEJbKwXe0MfWSvrjeTqq6GpInw/LjuL4r7chlxEY5g+8CkzVEO5o+6kW5UD8MAlOfFKPoF4ZjHkL8mxD9hFlvHLjD0oQ9fSNpuFwL91TmzyoHn8xsvmCsMCVaBIKkzB5zl+csfVhbcVDfugaw3RqlpR3mAwt+6iNKEq2LusdvL3LbWeK9uiLeGnJ5ejxKdM+g2MRGA02qxj/em41/5xoRUzrP9/aNjswn/XLWhlMoHPIn1khn6t3GayZcn0NNx6q/flTwFxuMaYBXk8gozFAYx9NDKVbW/aQQ89Ee+PMyzGGi0XJpCEEfV7EB3fYtKYFF6zvebI5Ua7sInWtG2MBdS/eK+zZNtlEcZuRfagOfbimKVbDE5cITG6MgX3cXy95oSpmBfim/yvrYC378G7A3ltQaJyOBPuSezZNTeSPwMjT3zLbjMnlofzzYcT+bbAHWU9ksWow8WZCrDBwwLGJLIJ+pZb/aTIWK/WoPDKJTHdZv9lEa+vxwX1N6ZSywTFuWVldlgAnj/mUwe7qv2TBZSbs8wBjtkwQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(70586007)(70206006)(8676002)(16526019)(186003)(4326008)(356005)(36860700001)(2616005)(36756003)(336012)(83380400001)(47076005)(82310400005)(40460700003)(1076003)(426003)(5660300002)(7696005)(86362001)(8936002)(2906002)(26005)(81166007)(54906003)(316002)(6916009)(498600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:52.1953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e2fa54-0f62-4fee-1756-08da509896de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1921
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
This is one of the major steps to decouple hw lane settings
from dpcd lane settings.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  8 ++++----
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c       | 10 +++++-----
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c     | 10 +++++-----
 .../gpu/drm/amd/display/include/link_service_types.h   |  1 -
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 9a406378d906..01c98ad06cf0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -544,11 +544,11 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 
 	/* apply phy settings from user */
 	for (r = 0; r < link_lane_settings.link_settings.lane_count; r++) {
-		link_lane_settings.lane_settings[r].VOLTAGE_SWING =
+		link_lane_settings.hw_lane_settings[r].VOLTAGE_SWING =
 				(enum dc_voltage_swing) (param[0]);
-		link_lane_settings.lane_settings[r].PRE_EMPHASIS =
+		link_lane_settings.hw_lane_settings[r].PRE_EMPHASIS =
 				(enum dc_pre_emphasis) (param[1]);
-		link_lane_settings.lane_settings[r].POST_CURSOR2 =
+		link_lane_settings.hw_lane_settings[r].POST_CURSOR2 =
 				(enum dc_post_cursor2) (param[2]);
 	}
 
@@ -742,7 +742,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	}
 
 	for (i = 0; i < (unsigned int)(link_training_settings.link_settings.lane_count); i++)
-		link_training_settings.lane_settings[i] = link->cur_lane_setting[i];
+		link_training_settings.hw_lane_settings[i] = link->cur_lane_setting[i];
 
 	dc_link_set_test_pattern(
 		link,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9f873d2cdcad..dfee3ba8b234 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1660,15 +1660,15 @@ static void override_training_settings(
 		lt_settings->always_match_dpcd_with_hw_lane_settings = false;
 	}
 	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
-		lt_settings->lane_settings[lane].VOLTAGE_SWING =
+		lt_settings->hw_lane_settings[lane].VOLTAGE_SWING =
 			lt_settings->voltage_swing != NULL ?
 			*lt_settings->voltage_swing :
 			VOLTAGE_SWING_LEVEL0;
-		lt_settings->lane_settings[lane].PRE_EMPHASIS =
+		lt_settings->hw_lane_settings[lane].PRE_EMPHASIS =
 			lt_settings->pre_emphasis != NULL ?
 			*lt_settings->pre_emphasis
 			: PRE_EMPHASIS_DISABLED;
-		lt_settings->lane_settings[lane].POST_CURSOR2 =
+		lt_settings->hw_lane_settings[lane].POST_CURSOR2 =
 			lt_settings->post_cursor2 != NULL ?
 			*lt_settings->post_cursor2
 			: POST_CURSOR2_DISABLED;
@@ -1935,8 +1935,8 @@ static void print_status_message(
 				link_rate,
 				lt_settings->link_settings.lane_count,
 				lt_result,
-				lt_settings->lane_settings[0].VOLTAGE_SWING,
-				lt_settings->lane_settings[0].PRE_EMPHASIS,
+				lt_settings->hw_lane_settings[0].VOLTAGE_SWING,
+				lt_settings->hw_lane_settings[0].PRE_EMPHASIS,
 				lt_spread);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 1b7a8774b0c9..a29ebd9dbbcd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -177,13 +177,13 @@ static uint8_t dpia_build_set_config_data(enum dpia_set_config_type type,
 		break;
 	case DPIA_SET_CFG_SET_VSPE:
 		/* Assume all lanes have same drive settings. */
-		data.set_vspe.swing = lt_settings->lane_settings[0].VOLTAGE_SWING;
-		data.set_vspe.pre_emph = lt_settings->lane_settings[0].PRE_EMPHASIS;
+		data.set_vspe.swing = lt_settings->hw_lane_settings[0].VOLTAGE_SWING;
+		data.set_vspe.pre_emph = lt_settings->hw_lane_settings[0].PRE_EMPHASIS;
 		data.set_vspe.max_swing_reached =
-			lt_settings->lane_settings[0].VOLTAGE_SWING ==
+			lt_settings->hw_lane_settings[0].VOLTAGE_SWING ==
 			VOLTAGE_SWING_MAX_LEVEL ? 1 : 0;
 		data.set_vspe.max_pre_emph_reached =
-			lt_settings->lane_settings[0].PRE_EMPHASIS ==
+			lt_settings->hw_lane_settings[0].PRE_EMPHASIS ==
 			PRE_EMPHASIS_MAX_LEVEL ? 1 : 0;
 		break;
 	default:
@@ -405,7 +405,7 @@ static enum link_training_result dpia_training_cr_non_transparent(
 
 		/* Update VS/PE. */
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-				lt_settings->lane_settings,
+				lt_settings->hw_lane_settings,
 				lt_settings->dpcd_lane_settings);
 		retry_count++;
 	}
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 23f7d7354aaa..79fabc51c991 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -94,7 +94,6 @@ struct link_training_settings {
 	/* TODO: turn lane settings below into mandatory fields
 	 * as initial lane configuration
 	 */
-	struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX];
 	enum dc_voltage_swing *voltage_swing;
 	enum dc_pre_emphasis *pre_emphasis;
 	enum dc_post_cursor2 *post_cursor2;
-- 
2.25.1

