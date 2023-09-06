Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913BBEB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B7410E636;
	Wed,  6 Sep 2023 12:49:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2261210E637
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5v7UaZlRh1ZZQhUynLfA989pd+x6l4ZYPxJH9FuHTYdCNOmb4TPI2VzcC/WxjZtbasVbGHQNj5NFAnDPIIxKgZ1577LaNcGkrNEUcUy0vEsUplfvdlEWcqWpfmT2lqYtAdIAHFcSP0zxmDJ0JwD1nRQv8/xIl3lvy3nwX9H+T2DSlLiWmMs3FxcI+9otOduvgQBGiv3Benh5E2r3NTMcn/1LnFGEW4mYP0FC+eF9BZVdEHlNQSvcZzj3Tv5tdbXSIc8vOzZ/52r086wRUDgSrpRYssM/K00NQeC6c+7s3a6MmtPwRoXprz8T2Z3eRlJxa3Kfr/KXM8hKahFAnqx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyB46IcRfl94NwbNToKDEj+W8xYu2LZa6zNwBCLGdiY=;
 b=L++j70nzI81XhBhsJIYAe3c0kR8K2p5mG5sjeqJsutMhN6k0YAOH94gOCj2dvv1JRaBZJDotN47Yyf+QThXgNTjA8S63IE2SufBk+dCpVXwxypZxpyiT3jdVeR1e82t8NY3VN9Dssb4DaEmNJnXaF9nZmzIs1gA0xTR/D7STL+4eKT8fOxBrYT8X0rPnfRLiR9CqXtv2Ok3ykjTFqZkJshsjcUkaDfy/HFFbFMMmoY9eMaxQ7Ld1eV6yWJeyMZAPA9MggEq9ELI4c4H+h5P4ai0k/PJBWTJJLK3IVUyFWgcZwwo9RTNf8R8VDZpiYvwA185VH5ZubAXtjIBpMZ7HWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyB46IcRfl94NwbNToKDEj+W8xYu2LZa6zNwBCLGdiY=;
 b=DWbL7elCbWNC7ylKHJcT9slZAZy40gMs6+1/bjs7+0UgNtX3K8+6bGM6jXLHIBD22js/lxLmokKwUZhLqHZx8+dLtYS2SPU4wcZu/8aXUI0COfwnDVvSE0St7UMU9WG2RwRpGvfgvz9ZP/AWuPJGEUbOIC8EP1j9EWbic0eUxL4=
Received: from DS7PR03CA0196.namprd03.prod.outlook.com (2603:10b6:5:3b6::21)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:49:47 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::46) by DS7PR03CA0196.outlook.office365.com
 (2603:10b6:5:3b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:47 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:43 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/28] drm/amd/display: support main link off before specific
 vertical line
Date: Wed, 6 Sep 2023 20:28:16 +0800
Message-ID: <20230906124915.586250-12-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|MN2PR12MB4566:EE_
X-MS-Office365-Filtering-Correlation-Id: dc640fa1-b5a4-4d0d-4977-08dbaed7c082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2zbFlyQG2NUVmHXh7kFZAbFHHoUxeewKAb8+eQAwozITX1oqkqv0HhZ2UNChvF8iogZAIHxH6S00Kl8230bs3/n1tIVGUMxPDvq6xu8mgnxoLz4FSkTImX/YCalYzBiybThx9ZD5RgQlpj9omLeVoAp+Usw4sW2rBfY7u59hjJBDkzM323uiOwFJpC89zCtiDzMZamHarsK81SPaZXcqJgfca2FwoCpc5DdQBbd0XCzROoNvea+/IR5IARoW4s//Y2WeS+dL0TMFUQn6OqA8ljy1cocTj1yIRPEQU1+DLntyooFfws95RyvUM5uU1ZUp9WhCmHSc/Qa9cSPhOMy7zhyit1w3dCGwK7hlcvldShK//VG69MNV4jiOi1fS+GYF45cnxPh5NWMOiud34cHXfTna7+eashSY0vv3K150mJByNjOm2A/DtYWmnoisn2cJsWPFBl35dYGePB5L0LGloARvGqYwewlvrzpp8nkxUg/cHt5CaHftFb+dop/hujjuFZKeCUIoXW02lF/T0Dof1TxiiSLGRcWG0MlxKcgLFWU3XFD5wgy4iSHexQtDn5a+g4cNWKRc9Vu5Mlp2f8fpDtKZiGmdHGZpcc+2dss0UbhkoBP2mpkareMcQtzKgzBogEXwsNttah7xtsxFQsd1p5SwzB7RRsbKvmwJK+7b7Eu9c7mP0OMl9vLZLFoFKErWbSxJu9LoVyRLzI4oEtyq67jHg6Gnw1z5IBovtB0eb0J8C6xNStIzXwtq7WRdFCY60S7WXKWwWgtA8GKW1udfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(36860700001)(44832011)(5660300002)(86362001)(6666004)(478600001)(2906002)(4326008)(8936002)(8676002)(70586007)(70206006)(54906003)(6916009)(316002)(26005)(16526019)(1076003)(7696005)(2616005)(40460700003)(356005)(81166007)(426003)(336012)(82740400003)(36756003)(47076005)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:47.2929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc640fa1-b5a4-4d0d-4977-08dbaed7c082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Paul Hsieh <paul.hsieh@amd.com>, Robin Chen <robin.chen@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
Some panels request main link off before specific vertical line.
If source turn off main link after specific vertical line then
panel defect will be exposed.

[How]
Add interface to support turn off main link before specific
vertical line

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c          | 10 +++++++++-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h        |  4 ++--
 .../gpu/drm/amd/display/include/ddc_service_types.h    |  1 +
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 0f24b6fbd220..f27cc8f9d0aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -35,6 +35,7 @@
 
 static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
 static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
+static const uint8_t DP_SINK_DEVICE_STR_ID_3[] = {0x42, 0x61, 0x6c, 0x73, 0x61};
 
 /*
  * Convert dmcub psr state to dmcu psr state.
@@ -295,7 +296,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		struct psr_context *psr_context,
 		uint8_t panel_inst)
 {
-	union dmub_rb_cmd cmd;
+	union dmub_rb_cmd cmd = { 0 };
 	struct dc_context *dc = dmub->ctx;
 	struct dmub_cmd_psr_copy_settings_data *copy_settings_data
 		= &cmd.psr_copy_settings.psr_copy_settings_data;
@@ -408,6 +409,13 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	else
 		copy_settings_data->debug.bitfields.force_wakeup_by_tps3 = 0;
 
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_1 &&
+		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_0022B9 &&
+		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_3,
+			sizeof(DP_SINK_DEVICE_STR_ID_3))) {
+		copy_settings_data->poweroff_before_vertical_line = 16;
+	}
+
 	//WA for PSR1 on specific TCON, require frame delay for frame re-lock
 	copy_settings_data->relock_delay_frame_cnt = 0;
 	if (link->dpcd_caps.sink_dev_id == DP_BRANCH_DEVICE_ID_001CF8)
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 0367d0850495..6e705b219872 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2283,9 +2283,9 @@ struct dmub_cmd_psr_copy_settings_data {
 	 */
 	uint16_t dsc_slice_height;
 	/**
-	 * Explicit padding to 4 byte boundary.
+	 * Some panels request main link off before xth vertical line
 	 */
-	uint16_t pad;
+	uint16_t poweroff_before_vertical_line;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 68dfc7968017..1c603b12957f 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -39,6 +39,7 @@
 #define DP_BRANCH_HW_REV_10 0x10
 #define DP_BRANCH_HW_REV_20 0x20
 
+#define DP_DEVICE_ID_0022B9 0x0022B9
 #define DP_DEVICE_ID_38EC11 0x38EC11
 #define DP_DEVICE_ID_BA4159 0xBA4159
 #define DP_FORCE_PSRSU_CAPABILITY 0x40F
-- 
2.42.0

