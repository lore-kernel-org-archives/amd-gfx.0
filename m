Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76570C25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1AD710E3CF;
	Wed, 16 Aug 2023 21:30:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D105F10E3CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRwGQgk09Nh4FmWdktxqO7Zcwxufr/F2L1f5HJx2Z9KCcnsuuodu+DK04Hl3/AxTMgg460fC5mtZMmnYO+5VwAoXtz8zGIzwRsFdDLunhre3kD75Q4c4WXXw6B61Lcm2LGsfSZPbDJ8UpuxM5yxKY2FCr1/5a/Y3W44pGHQHEbNudCUpVQbd0RPhEj8jn0W2M3YDOy5McHkDm0jp4A+I+FH5tQU3ukOuDUk1EXwQPeQDUr+sTfpuYazlLjJQlRHFT1T1iObAYM/R5rFhBT020DdBGO/9E0s4hnXb3GHexQ3q7vbG1nRdFAlXk3I/3/To5ZrC1ggZFS9YwXsFJKuZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nrJMgiJbCubSNhdq575lFkuHOuN4Q1kkdwrH8BCqQ0=;
 b=LsCr/wqSYcA/mDSBI7LrSnvwSRXSO9LH/XKVAKPgA3ynWGL97LmInmgwgdAHa7VNyzfmvzNMFt4Ac7xCZ/pQ8kO3hi2/mV+ZYLXusYjnZjlES0hwxw3/0ZawBWhz4MblWDG0KmnVtx06Rx2R131wjaCtBTKXiDtZzHSOr+0vrZO50N7rq3luu1DvEx3mEms2voX++ZpweTaE6Hiftvc3hNjYMGAglJww3TAjEU6dT80luCEM390vfSzCSIKgkdFkebsqHwBLor+vplTvFQX9U23z2m6adNbHCXFcVbY3hirmeCgt3M74pX9Fu5lZGtJXkoWJ+kHpwmGppOLrWVZxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nrJMgiJbCubSNhdq575lFkuHOuN4Q1kkdwrH8BCqQ0=;
 b=dFmUsSpqHy8B5bbr1NnEZfPMCVeCV6dtfxeEHQRI5RApRW31XY+h0SJy/ynahG1N6RN0VO2spX7YObvz0qisF1wAPiY8+0gBDNmk5RRlZHG9fJBQtNjrzK2/lsXlJdrhnSKl+aFo3UHysT//I7oPQ5es+BmsXrcIfgcHOsKlSaw=
Received: from CYZPR05CA0023.namprd05.prod.outlook.com (2603:10b6:930:89::9)
 by CH2PR12MB4906.namprd12.prod.outlook.com (2603:10b6:610:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:30:14 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:89:cafe::66) by CYZPR05CA0023.outlook.office365.com
 (2603:10b6:930:89::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 16 Aug 2023 21:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:30:14 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:30:13 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/18] drm/amd/display: Create amdgpu_dm_wb_connector
Date: Wed, 16 Aug 2023 15:26:16 -0600
Message-ID: <20230816212626.987519-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CH2PR12MB4906:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fe4ebe-b8c5-4df0-f114-08db9e9ffa9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4PI1QaYxVlB2KEAWfuZ3Qwn5bcHpeHyp6+98+2YgyljpfTe2jblhrcWOTubgriqF3kNp+2Wg3BLWb6l501nV5ZmNWhVJ5HsMrY9TCMPCxIj/LLRm2mKCnQ02JyuGj6skCze4VTeUKxzjreFDgObSN42WuaNzBLMCb5wtILp0Ypc7HVnIalDaq6srU3altoKRSxEhnbsaHo1JhcU9jl9ZcEUygDlWMFd9eLpyNJw/8a81c/HxMeC0M7RVPb+yEjCRliJtS3vbs93NkfpuFvfl0VLFU4irwjPYGsymKLaopjbDmEwMZ4MGJHafioP35xpv+ZIgQharuiSoi+q073GNh1Sq7+sHyKXvNKD5ZCFfpzX0yW8j7sXRoRAVnTDLkOSm6POCK/N6YFtPd/jsrZoF8gYXdMy4aH9kdlSFZkXZYo714wbpwpFBH6WD8XFIM2C0XFyBtKv1nT2c/FpsplEAH5Q9jvt6Q7djVY49xpWCxa9pCpMbkcL5aW9CHaS6bsEC1xuxXjgVprFSx167mVQWreV9I8J0jRT0QxlmWjPHpe7bIzC67Zv5Bxsag28jtz+TZGntKegtOqLJFWGCBaCGlyiARhIr1KTFCuDx3H+L3Nqx7U4Qrb3uCKFOfeE8zVyXKtYlPd4hN3qP5mL6vgB6YqqtEYrwuel/h9tcBFuR4x7zvcv8Wg2hk9iP1jw+hzOh40IPTtnmtm0/EEMo9mSH/b6QhIoxjeR+wJAwGD0njTkhU4Ynjk2+omVvNmCzaw1JegcgKsaKAQUUMoZGbb9Pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:30:14.3475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fe4ebe-b8c5-4df0-f114-08db9e9ffa9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4906
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[WHY]
We need to track the dc_link and it would get confusing if
re-using the amdgpu_dm_connector.

[HOW]
Creating new amdgpu_dm_wb_connector.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  5 +++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h    |  8 ++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 16 +++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h |  3 ++-
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 33e7c463a0d0..b12e8393fef3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4416,14 +4416,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		link = dc_get_link_at_index(dm->dc, i);
 
 		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
-			struct drm_writeback_connector *wbcon = kzalloc(sizeof(*wbcon), GFP_KERNEL);
+			struct amdgpu_dm_wb_connector *wbcon = kzalloc(sizeof(*wbcon), GFP_KERNEL);
 
 			if (!wbcon) {
 				DRM_ERROR("KMS: Failed to allocate writeback connector\n");
 				continue;
 			}
 
-			if (amdgpu_dm_wb_connector_init(dm, wbcon)) {
+			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
 				DRM_ERROR("KMS: Failed to initialize writeback connector\n");
 				kfree(wbcon);
 				continue;
@@ -7487,6 +7487,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	struct dc_link *link = dc_get_link_at_index(dc, link_index);
 	struct amdgpu_i2c_adapter *i2c;
 
+	/* Not needed for writeback connector */
 	link->priv = aconnector;
 
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a2d0ab881c44..46acf89e5a45 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -32,6 +32,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_plane.h>
 #include "link_service_types.h"
+#include <drm/drm_writeback.h>
 
 /*
  * This file contains the definition for amdgpu_display_manager
@@ -714,6 +715,13 @@ static inline void amdgpu_dm_set_mst_status(uint8_t *status,
 
 #define to_amdgpu_dm_connector(x) container_of(x, struct amdgpu_dm_connector, base)
 
+struct amdgpu_dm_wb_connector {
+	struct drm_writeback_connector base;
+	struct dc_link *link;
+};
+
+#define to_amdgpu_dm_wb_connector(x) container_of(x, struct amdgpu_dm_wb_connector, base)
+
 extern const struct amdgpu_ip_block_version dm_ip_block;
 
 struct dm_plane_state {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 74e656696d8e..b3e634b0f712 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -30,6 +30,7 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_wb.h"
 #include "amdgpu_display.h"
+#include "dc.h"
 
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
@@ -183,13 +184,18 @@ static const struct drm_connector_helper_funcs amdgpu_dm_wb_conn_helper_funcs =
 };
 
 int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
-				struct drm_writeback_connector *wbcon)
+				struct amdgpu_dm_wb_connector *wbcon,
+				uint32_t link_index)
 {
+	struct dc *dc = dm->dc;
+	struct dc_link *link = dc_get_link_at_index(dc, link_index);
 	int res = 0;
 
-	drm_connector_helper_add(&wbcon->base, &amdgpu_dm_wb_conn_helper_funcs);
+	wbcon->link = link;
 
-	res = drm_writeback_connector_init(&dm->adev->ddev, wbcon,
+	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
+
+	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
 					    &amdgpu_dm_wb_connector_funcs,
 					    &amdgpu_dm_wb_encoder_helper_funcs,
 					    amdgpu_dm_wb_formats,
@@ -202,8 +208,8 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 	 * Some of the properties below require access to state, like bpc.
 	 * Allocate some default initial connector state with our reset helper.
 	 */
-	if (wbcon->base.funcs->reset)
-		wbcon->base.funcs->reset(&wbcon->base);
+	if (wbcon->base.base.funcs->reset)
+		wbcon->base.base.funcs->reset(&wbcon->base.base);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
index 0bc9df7e7ee1..13d31c857dee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
@@ -30,6 +30,7 @@
 #include <drm/drm_writeback.h>
 
 int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
-				struct drm_writeback_connector *wbcon);
+				struct amdgpu_dm_wb_connector *dm_wbcon,
+				uint32_t link_index);
 
 #endif
-- 
2.41.0

