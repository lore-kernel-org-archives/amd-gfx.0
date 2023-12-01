Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B8AC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BFB010E892;
	Fri,  1 Dec 2023 13:29:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2DD10E896
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoELjclrwUaHSts781gGybeQbE2+jeZammJ76V1JurW/IckvYVFyqRZzvV5VdmwXAM8oLASd2iN1BQjDqak+xceLhVdOSYGEX9hiXgLCwfreOtToizPuyHm5igFKVoeD0KXSWIiOzoXYMLDHQ+ZQJhdbo48XUJNCNpYLLq8oU+8pr3pREH5rpRNkyOHdKpUW5yxCcXBwOTvblI9t+XiFFsXpGkD76n/bmkqxWsojsPauh4aZ/EvEX5qis8UL0/5NgTtKUziJLCKWp1oGsTKfH3iP4tMKNp/svcXqfq+RJKy+X4lri1xXThGWyDBkmNFPxNlhWBaCdWp2ahXEQzAWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z89nD3i5eHyCF1ggnlkb1uAFsgWI6dj8YhahcRTKU9M=;
 b=W4bh07m8XPSwE9Ihpdme6FYD/ag8aVfvocdJgaxJRUSeM4EPy8/NXesFznNvsaJ6MwASM+xpfzk764g2uAgyEgabxKz4t6Z2WojeM1aqb6TFgYe9b1QlfD+XvQy6/yf4KKU9y9ZRaUaHvpyKNFMiHedll4RqXI8XM3id85UODZrSfvoN/3LweJZfZz6kzT4Ut/C7A5gRmKgg6LPrR0mR+InFUfniwEbwrXESuV6VxX0A28/pNQjbXkEOBI/yDlaMyAmsJ+RgcV1mTIccmWOR4p/1zaYkXlJaYsWYKsO9IVS9O6CHK0bxDyFxfl0heLZ1SlxER280Rto2309GwH/aMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z89nD3i5eHyCF1ggnlkb1uAFsgWI6dj8YhahcRTKU9M=;
 b=wiM2HRnVS+GvxBlLlOl1nIFF/8yyBwGfpCpVRHlXRmGkKLW3ZA66tJDId/cpVUdl2HvYn+XYlm+9zfMFfBD0dc1Am6q3h1aKYi/OQc19TLDh3u44zKfTZa57zPQbp7nvXuTXnooU9GWxrqvP5tcckfK0DxJ5XhvvAq6X0y1w/oY=
Received: from BYAPR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:40::20)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 13:29:15 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::f) by BYAPR04CA0007.outlook.office365.com
 (2603:10b6:a03:40::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:15 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:12 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/47] drm/amd/display: Create amdgpu_dm_wb_connector
Date: Fri, 1 Dec 2023 06:25:29 -0700
Message-ID: <20231201132731.2354141-34-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c8090a-2105-41a1-37a7-08dbf2718365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lCl/b1+V60n6W8/Or46Ru0/dcjOquv8o48Ims3Xul5U4KuXZkvpTbdUp0tiXYFpplpHliT9oJXpE+fkP0pvvwoVcCRXz6V2q92Ai4XHrkijNENE6mNqwATLfB1ez8GHqVZoIRgZF8KhVL9oTAtySLF1HnK8qI//4k+WbVDY5xlRROTE4Il/mPNewJJPN33lO8RhlptCJFU78jeaL67/GvpmpR+QSopZaQvOGLsI1ruNDF9lK52euZhDiBQ6eg6Z1rrXKayMXJ/mdB0ayO7WJFKruA/JYGsIaEBDrhRegaUhBKdSsC1nyNow4f7SNcEzsXXe3xLYfr/wphJEUOYFy4YZBgOqk8FVLeWsTu439PcCNHNvTe8hf9G2z3ifayx6sO5+9yn7xjSKN513nWAyZHMzwMkVHV416ycuH9d44g0vRIs6r5ynKBCziaIRJFTZgmQMVJmXdT2sV9LGeRPRrGGKLaGCJrvi4AVP6NYS8mLAc0bGHLk0YV1YPu/QdB4/ffaTEALtgAsZ1UgZRtWmshZiC9FPVntrg5H/7Kl1fEhUuQmTavixXV2saWlTxD9smYL6OyTtwb2OWK4hWlLgVn2EmwoI+Y7xl1GrhwPlDmXyb5T7/5lHiz2hOC1JmaHw814V88phFvZCENQdeZJHVUleAS0f8yeKfT9JT8tYnbwMwEqCZ3Afe1NYEJ1aFjmftEndzr7bWajg4zyCbnsgY2bURo9BfK0sZwhVRnqCh5W9JKM5yRRksgIyOjyyHfZ8ikNkIa2vZEnqjZMYwTorLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(356005)(47076005)(83380400001)(26005)(1076003)(16526019)(2616005)(54906003)(70586007)(70206006)(40460700003)(316002)(8676002)(5660300002)(2906002)(4326008)(86362001)(8936002)(6916009)(81166007)(41300700001)(36756003)(6666004)(478600001)(426003)(336012)(82740400003)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:15.1794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c8090a-2105-41a1-37a7-08dbf2718365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[WHY]
We need to track the dc_link and it would get confusing if
re-using the amdgpu_dm_connector.

[HOW]
Creating new amdgpu_dm_wb_connector.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  5 +++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h    |  8 ++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 16 +++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h |  3 ++-
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index eb9f9d77127a..6df23fa9c3ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4478,14 +4478,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
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
@@ -7589,6 +7589,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	struct dc_link *link = dc_get_link_at_index(dc, link_index);
 	struct amdgpu_i2c_adapter *i2c;
 
+	/* Not needed for writeback connector */
 	link->priv = aconnector;
 
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3710f4d0f2cb..0a9974017eba 100644
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
2.42.0

