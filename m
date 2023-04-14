Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BB1C77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C414210EDD9;
	Fri, 14 Apr 2023 15:54:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576ED10EDD9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFn2cBkqrwg7Oa4jKf6Ab4KIbCWtNHzoMTZcrm92vp1pY1DpVL9jOcRkqMuu7fh3uqVwyUSXsT4+4szrtmByEouv62qUEJSu1A+lMEudlDySwqeS7JEYKNTKiRn+69pjpZpSJc7DsaCmFY6PJ2+iCNIRN98dFGvmJm5ftFkCz+GEOai5RwtgDRvC0clhq0r1Y/jdLdGxkhe15gutsc3YCh7/GlmeUdZ1mef8pkkV+nmVKKzS26DjAZC44cCHgbzVDPsnhBa4WHEynB98yvGWjuKybAdTkcER2pUHupi48jWjq2Yim1aRdXYT9OWc4sCbz8E/R3GLUc9/snYfYnLHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOrNLmT3mUSceFT7M1oIXCw8p5QbyIaelMZB382ydzE=;
 b=mmGbfbJyi85d5SPvhwoAtWqKsuHzvl4S73JyQpF4WoTKyiMNXRMJiDLiYySkqzD3mAizo70QEsWL2vTaYNsqUZhFLf7EBUlM1QfBx/K6FJ9RM4ysjl+3rKsShe7Ss4aeBMpt+aNsZumIvilsDw57gfraIAe26c5by9nftEjdU+pgevWrma/ZOIS5IeomYb14XhnjBgvUjxBEPsB/+o2huSW/rwXo9C6EVwr7QgP0g6Y8hm3x2MQSrN1WV7sQcx/FUth16buEJejGgjNoqZxvqGLR0374H7TGydrSrdpDEzCrKQ09AQGyCvOvrXddlSEmOH98V3NVLHTkMi+oN+SHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOrNLmT3mUSceFT7M1oIXCw8p5QbyIaelMZB382ydzE=;
 b=Zu0MNim/Pb45/R/d7TYgaivvwECczdd2DCVB6Fsi0L9kov1UamTYk/Y8vZ/LT2z6bK7NwM18JMcmZ2d/+V8wD90+smv6hADScoM11gWT1Yx7gIj7l9GNwABdjgURG3ij+no8V9I0czYBP2093VhlbE4Tu9HD+H1cowY+44JKJno=
Received: from BN9PR03CA0475.namprd03.prod.outlook.com (2603:10b6:408:139::30)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Fri, 14 Apr
 2023 15:54:36 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::d1) by BN9PR03CA0475.outlook.office365.com
 (2603:10b6:408:139::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:54:36 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:34 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/66] drm/amd/display: Apply correct panel mode when
 reinitializing hardware
Date: Fri, 14 Apr 2023 11:52:57 -0400
Message-ID: <20230414155330.5215-34-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 697edbf3-c685-40b0-8d75-08db3d008c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kzx+0zyOEidL+xkHOspxPdWvoDqRcprbejcQtCdg3DBhd2HUhcRyWCDmTL2ZcSRR5n7YqmiX04EyAwnrB7wnukH8kNwalOsQk8lhs9mgIWeDpu6wgJ9zYSEUQEFOoceiupPrKV/2E0fi4bIOVj93YkLjiCrWakLkF8y1/Ga1EXMWjr5lIoleYVPUmBJhQaK1B3rq534gwa7qEGhBgFOWEmnRWBeghRqOyzOfdkSx5j7fsZrXhsIbaJkAzvGzZoA4Gws0YSe9/aRCpF+6zc17or97Tht3QfXb+xWCdcwZBMvBGrwqzIpGd62TQjrsTEJrAxsb51MzlYeknADfnVFoLMRj56JpqCCsYiAM0rHeJXcSK3bmwtx2i0KS9MnYof6O8xEJFBprT61y24SkJdk0gj4IrSF4DwBkzosdsisTiIUOiXKlU51Cyy0NYejlkvo5FCaEwIwOf1gP+4fEX4wjcz2pa2I2YeI1lOje5MjOUS7dPqugLoE3YB7u9eagRytjQ/s1N4xSUaZDIjJTWKlTvwBcTddbWT8l0TTKvpGDkzLkpT/kYH5o72x1qTO+uI8JytfcUJxi8OHHb8NrGvWBHIEVNm4zqcJsBOB9HwgfAKJqpKRUa/GJ8DM25El2bbJo27yr0wXu6STazE55hXQIbidGUED0OrPz8vjlCXNqDmQT5ConcIXO7j9k2yO2oBRzOxQ+9hnPzSnQdxNyVq3ztlzLO5wCIKqqY6PpzRxENUo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(478600001)(82740400003)(83380400001)(47076005)(36756003)(86362001)(81166007)(40460700003)(356005)(426003)(2616005)(2906002)(26005)(186003)(316002)(336012)(1076003)(16526019)(5660300002)(8936002)(6666004)(4326008)(6916009)(41300700001)(82310400005)(8676002)(70206006)(70586007)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:36.5669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697edbf3-c685-40b0-8d75-08db3d008c49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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
 Michael Mityushkin <michael.mityushkin@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Mityushkin <michael.mityushkin@amd.com>

[Why]
When link training during engine recovery, ASSR might fail causing panel
mode to be reset to default. This should not happen for eDP as it
will prevent the panel from turning back on.

[How]
Added dp_panel_mode to struct dc_link to remember previously applied
panel mode. Do not reset panel mode to default while performing link
training if previously used panel mode = eDP.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Michael Mityushkin <michael.mityushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                          | 1 +
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c | 5 ++++-
 .../amd/display/dc/link/protocols/link_edp_panel_control.c   | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3595149deceb..3b53f36029d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1456,6 +1456,7 @@ struct dc_link {
 
 	struct ddc_service *ddc;
 
+	enum dp_panel_mode panel_mode;
 	bool aux_mode;
 
 	/* Private to DC core */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 70fc0ddf2d7e..d9e8b7ceb0b6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1586,7 +1586,10 @@ bool perform_link_training_with_retries(
 				 * Report and continue with eDP panel mode to
 				 * perform eDP link training with right settings
 				 */
-				cp_psp->funcs.enable_assr(cp_psp->handle, link);
+				bool result;
+				result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
+				if (!result && link->panel_mode != DP_PANEL_MODE_EDP)
+					panel_mode = DP_PANEL_MODE_DEFAULT;
 			}
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 5ab2de12ccf8..2039a345f23a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -83,6 +83,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 			ASSERT(result == DC_OK);
 		}
 	}
+	link->panel_mode = panel_mode;
 	DC_LOG_DETECTION_DP_CAPS("Link: %d eDP panel mode supported: %d "
 		 "eDP panel mode enabled: %d \n",
 		 link->link_index,
-- 
2.34.1

