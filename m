Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE16C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84EC110E1B2;
	Wed, 22 Feb 2023 06:41:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C4F010E1B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry2fH74ph37Ne0ptW0Z4JAVf0liJa05Q4lR4L18B/hNmBt8oGS5qs7Xwrum1OCxXvSBoEme5NEaoFF8DCqmbZZuTLGyc5d01aMOZakWls5XftvtJ66RdcE68VLJSloqaj0xuoHut+DKqCgrgfOh+5/GM5kEjtD/nDcMWKky65CrGAlVFc6l4ehOytD2Avtyjk7uv9bDz8Q9w5eL/cRDBenvMZptb6N+y58TMTyXlMUNYJB3euv0BKrO5VsrRTma4Fub0ybQQpmeSlNVA3/+NLpc8lRA6L+BA5vVVtnvtMn5XGCmASl/7UYyyBOqcuZHPIUSYygHJjpBxX5HY2dWSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuBx2/QaZ1UkJzEz0QDtuPRrn9pKmZroS2Zu8rrzoT4=;
 b=QFDbaTqFGX0Nh39fR+S7Z2O21pA0khArScnkFWVJX+kqKQR1Kc3++b0jctDzj4AGGnvOfHoaZRKjxz3DnpnZLRfyGJFLJLi1FG1mitsIgLid1UtB3s6zMs25tmJvfM+tT95T7Q5DlPd+ywugaorqYSqGCw1EO6zMO1d26mMhMHiphNdxy/n+C0+Fnahunpi3J4hlO/0sYtAc62dvg4I7PuQjkFCpBRI6BxJUpcg4LP7bM0wPhH0eK9b93fRTVQu62gjBFKx6mGDwbhzoNmhVKpOu58kDR0OiE1nzrK0VW3qiU+ugmDwXehL5OvO6Dv4flJmqidtb3DHftBPgT5Auwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuBx2/QaZ1UkJzEz0QDtuPRrn9pKmZroS2Zu8rrzoT4=;
 b=IZRLIEHlzLr+jd7QAEnzkyX5h3TPEmm5KIGFGuIMtbkH8hI5O8VhWiiTkFYUMMxFpEkokdbXmWcegDuNd3FnAnzzv8OvSmH31VrnaL8qpy+bYO/2UTynAPYBhyew+39WHLGEthu/BHk3lWKbUSg3TDe1M6AqzXSV4YYEnnD26hI=
Received: from DM6PR12CA0012.namprd12.prod.outlook.com (2603:10b6:5:1c0::25)
 by BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 06:41:12 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::84) by DM6PR12CA0012.outlook.office365.com
 (2603:10b6:5:1c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19 via Frontend
 Transport; Wed, 22 Feb 2023 06:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:41:12 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:41:04 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/20] drm/amd/display: Ext displays with dock can't
 recognized after resume
Date: Wed, 22 Feb 2023 01:40:22 -0500
Message-ID: <20230222064041.2824-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|BY5PR12MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f45580-97dd-47ed-d61f-08db149fc9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gxegz5F6ON3V2qiBzec4sJ6z0mmtAKo9OgBL0jDvEJf0ZNOwXRcy9M3DWQlX5BWa84nvry7/9s9wLjYbeYCze9mO2CvaJo8l0mL2LApxFQCqD7D6miLRwhfd6gDmpijbqYWYGARLh3KZ7hX43ZrqI6DidLgyYaLHSag01eiYQvGL5CxmorWlN5Rd5gNM3OnDEzROhERI8q1N4u9SPMJRzCK5IFLiE9Q1nDDWG629iO9JzOkNZJjCq6+WU7p/vX9hwuDS1I8kLOuHRzzXUglCQb+5G8j5A9ycyjpbWlVVe1qtvt0aXla9j1GIo+1LFjYllipP7BSvyl1zekVOCD3v91FN4kr5MBqhsUfk1yob+wE+QaEtUmHHlj7Kusd+g+qLYFwfBQ1vWucQuTB8/4gxI4d02xzzFPDwhvRraVVRruz5UevyLdseXq33FowTNKjJbc0Yd6WVqXM97QtPBuVkmsLKPpBzTDF+oseHAZ7skQCeD9RpgJjd+YfhaU2lwIVc2bdKipxcVt7Yp5ooAMNkKSheNEsTYf574ptHCbpGJkhE0KmN+mGqxVaK/wgdLqljrj5KVcXhaYyTvUcNxbsMNOEifqn2jNowZvvRMH1h7imhqcejFmNaj/hMUJ0V/Oz0BRQgYN9UwWNmEnFVD3YzItPdUP5gkAKyJamDS+8BtoOW6xzFYtSEusdO2wDjRfK2cyOFXaFY7jF/5kPPFR200BIlz84f6CedgmjFs5brsUA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(186003)(26005)(16526019)(40480700001)(6916009)(4326008)(70586007)(70206006)(8676002)(5660300002)(36756003)(83380400001)(8936002)(1076003)(6666004)(2616005)(336012)(40460700003)(478600001)(47076005)(426003)(316002)(356005)(41300700001)(54906003)(82740400003)(86362001)(81166007)(82310400005)(44832011)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:41:12.2176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f45580-97dd-47ed-d61f-08db149fc9e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
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
 solomon.chiu@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, Ryan Lin <tsung-hua.lin@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ryan Lin <Tsung-hua.Lin@amd.com>

[Why]
Needs to set the default value of the LTTPR timeout after resume.

[How]
Set the default (3.2ms) timeout at resuming if the sink supports
LTTPR

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Ryan Lin <tsung-hua.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 10 ++++++++++
 .../gpu/drm/amd/display/dc/link/protocols/link_ddc.h   |  1 +
 .../amd/display/dc/link/protocols/link_dp_capability.c |  2 --
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 84d056b6ec60..8be9fb8ada55 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -41,6 +41,8 @@
 #include "dpcd_defs.h"
 #include "link/protocols/link_dpcd.h"
 #include "link_service_types.h"
+#include "link/protocols/link_dp_capability.h"
+#include "link/protocols/link_ddc.h"
 
 #include "vid.h"
 #include "amdgpu.h"
@@ -2302,6 +2304,14 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 		if (suspend) {
 			drm_dp_mst_topology_mgr_suspend(mgr);
 		} else {
+			/* if extended timeout is supported in hardware,
+			 * default to LTTPR timeout (3.2ms) first as a W/A for DP link layer
+			 * CTS 4.2.1.1 regression introduced by CTS specs requirement update.
+			 */
+			try_to_configure_aux_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
+			if (!dp_is_lttpr_present(aconnector->dc_link))
+				try_to_configure_aux_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
+
 			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
 			if (ret < 0) {
 				dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
index 86e9d2e886d6..aaa5064408ba 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
@@ -33,6 +33,7 @@
 #define DPVGA_DONGLE_AUX_DEFER_WA_DELAY 40
 #define I2C_OVER_AUX_DEFER_WA_DELAY_1MS 1
 #define LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD 3200 /*us*/
+#define LINK_AUX_DEFAULT_TIMEOUT_PERIOD 552 /*us*/
 
 #define EDID_SEGMENT_SIZE 256
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 4874d1bf1dcb..d4370856f164 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -60,8 +60,6 @@
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
 #endif
 
-#define LINK_AUX_DEFAULT_TIMEOUT_PERIOD 552 /*us*/
-
 struct dp_lt_fallback_entry {
 	enum dc_lane_count lane_count;
 	enum dc_link_rate link_rate;
-- 
2.34.1

