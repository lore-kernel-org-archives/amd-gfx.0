Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2069C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA6010E628;
	Tue, 10 Jan 2023 16:59:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCC310E626
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeHdG75Tav+087UeEDyka4F3JhFu1JjtWTkeRwJi8GgfXH1zhjStDj0BvnuzeqAM7xamcDJ3A4ZaIG26u5qkZRCAm5tnyZD0UxkfqpK0w9zOrvw6H/tAoPB9KUfIsCVItukI/SyWLKhrQ5FeyGRjaHSNdOVgmA2Em2Q9U1mUV4qJ1eMaoV8gLSQIBtYphB0/kuWqiNJsNThNMh/eWAaVO9SkXbX20NzXUfTTSWlaRNbq4nGtheNYYE3J9A3rayV3D51djIvd63u2oaWnul/bX+ZmEY45ik0DDI2wKJGIX/MLJtXi5V9xJCKkkjOXXI5GMh5NmmU6SF9LmJGhzrjOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaa/dTCgrIAAClf7keT2q7mMWkgqOeywBvGZ2HzoNv8=;
 b=OduiRrixcUZCqSu0tjCExDMDpPbRbu7aACooOPRs+BqVnL+vOwRrGgMYBcX/RuKt+FCJvZyB9H+1KFIaXyNsdJtuBa3wYm7PxSYiiHzGUm46Rb1izgnD3vqsOT7F0f+E3g5pEqNbc/Hf5eKT70H0wxuBIWf70D6L4S5WDU75lYv7Cg4SCgqciSH7bJ6vwKzW61EAzagSxQAJbqLLKqnzN9E1kYcaNStWxtumzShuAJa6rivOJSt45+bDiWtUzN+t3VshrT9d2j0rsQJq9G4HSHr0kNZUL7zbFzc4prIUQfdMdEo0LgDvVVrsX4WTvhdjCD3OU2yJiO5idHF/gFiDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaa/dTCgrIAAClf7keT2q7mMWkgqOeywBvGZ2HzoNv8=;
 b=SZkPmEolCybnvoI9oMk0uup1/8pugvkWAlenqRDI4ynhnjsgk4Iz6aBKSVO59N5NvgL9xEphQTizHNPmMRTi8WXpGk9J+0XQ2fKmqx5Owd5G4OTREHB0Wcsz9P3lQaTA8S2BO+9kDB1RG89WuDeeTod2OBgryq4RbP3GGT8bp/g=
Received: from MW4PR04CA0200.namprd04.prod.outlook.com (2603:10b6:303:86::25)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:59:00 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::16) by MW4PR04CA0200.outlook.office365.com
 (2603:10b6:303:86::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Tue, 10 Jan 2023 16:59:00 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:58 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 35/37] drm/amd/display: phase2 enable mst hdcp multiple
 displays
Date: Tue, 10 Jan 2023 11:55:33 -0500
Message-ID: <20230110165535.3358492-36-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 3221d700-846f-4df3-a758-08daf32bf894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkOzNJMmMEDVBIz1BrSVzgKBoLW3Rk73ovVqghDHaL7lLyUwZXRu4hVhAU4sowPqkijt0QFI7z5l6gjg93vJ8M4n7nVsJ/ZgYTjvX8Hv74N51l+06DY0BSG0dJCp9/Dy1QpyGI3r88U3qVzPnLimOez+S1I0mdGxdrykiCHTUOaLUwVOHxSHXpiz+6Y9wqFJbbLVaX1TDc2EHHTG3hGtvbFrJK2qbjuufIC3835dmPpCqBM+kAe4q4f+i3ymWM+LVZfN4pLMOiu4Kx47DFNpYa0uwplEdz6h9yMY/4WiNOdLJriCowGaoYYhBvsZa1LNUBui0NVfqdFU3dEQZ1TOxGNicttbQIhK0lav9peGbNoYOGB+ZVO+hluD/2em2KUGeHtcl5AAoUCWItVZW4VjruyLuHz2Qe26ThiFfO1e/fZnF/Lo5EzvUhH7iou81u/BVkeKVYQL70AJSKJAxAfhci4muQOYTtFvfFafn7mPVD4lO8WZwY8PwtPli3Kxr8lZtwrzdiXKVc6ag5s99x9pCT94GMPGgwGVfzTSJ+cKvugDzXSkDpQxdK3G6jMEJkDbQkG3pDLlsSgyf15ESwC0ey34oG+RzThZjtzEXyOS9lPyDr2OWELLIcGLbd/V/6cOqE2GrWOY/0xLaS1UTI6cCvXnTqVvbD9W8bI1M7B20XY3ii9QaMHirFHROG41JPg91HodGIRIVlfgif75/ZsbXDIgteHf74odlHBP5j1e9hc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(7696005)(26005)(478600001)(16526019)(186003)(6666004)(47076005)(316002)(6916009)(4326008)(36756003)(8676002)(70206006)(70586007)(336012)(2616005)(54906003)(426003)(40460700003)(1076003)(41300700001)(30864003)(5660300002)(83380400001)(82740400003)(8936002)(40480700001)(82310400005)(36860700001)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:59:00.4575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3221d700-846f-4df3-a758-08daf32bf894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersen wu <hersenxs.wu@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[why]
For MST topology with 1 physical link and multiple connectors (>=2),
e.g. daisy cahined MST + SST, or 1-to-multi MST hub, if userspace
set to enable the HDCP simultaneously on all connected outputs, the
commit tail iteratively call the hdcp_update_display() for each
display (connector). However, the hdcp workqueue data structure for
each link has only one DM connector and encryption status members,
which means the work queue of property_validate/update() would only
be triggered for the last connector within this physical link, and
therefore the HDCP property value of other connectors would stay on
DESIRED instead of switching to ENABLED, which is NOT as expected.

[how]
Use array of AMDGPU_DM_MAX_DISPLAY_INDEX for both aconnector and
encryption status in hdcp workqueue data structure for each physical
link. For property validate/update work queue, we iterates over the
array and do similar operation/check for each connected display.

Signed-off-by: hersen wu <hersenxs.wu@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 160 +++++++++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   5 +-
 2 files changed, 122 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index a7fd98f57f94..0301faaf5d48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -170,9 +170,10 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
 	struct mod_hdcp_display_query query;
+	unsigned int conn_index = aconnector->base.index;
 
 	mutex_lock(&hdcp_w->mutex);
-	hdcp_w->aconnector = aconnector;
+	hdcp_w->aconnector[conn_index] = aconnector;
 
 	query.display = NULL;
 	mod_hdcp_query_display(&hdcp_w->hdcp, aconnector->base.index, &query);
@@ -204,7 +205,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 					      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
 		} else {
 			display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
-			hdcp_w->encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+			hdcp_w->encryption_status[conn_index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
 			cancel_delayed_work(&hdcp_w->property_validate_dwork);
 		}
 
@@ -223,9 +224,10 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 {
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
 	struct drm_connector_state *conn_state = aconnector->base.state;
+	unsigned int conn_index = aconnector->base.index;
 
 	mutex_lock(&hdcp_w->mutex);
-	hdcp_w->aconnector = aconnector;
+	hdcp_w->aconnector[conn_index] = aconnector;
 
 	/* the removal of display will invoke auth reset -> hdcp destroy and
 	 * we'd expect the Content Protection (CP) property changed back to
@@ -247,13 +249,18 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
 {
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
+	unsigned int conn_index;
 
 	mutex_lock(&hdcp_w->mutex);
 
 	mod_hdcp_reset_connection(&hdcp_w->hdcp,  &hdcp_w->output);
 
 	cancel_delayed_work(&hdcp_w->property_validate_dwork);
-	hdcp_w->encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+
+	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX; conn_index++) {
+		hdcp_w->encryption_status[conn_index] =
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+	}
 
 	process_output(hdcp_w);
 
@@ -290,49 +297,83 @@ static void event_callback(struct work_struct *work)
 
 
 }
+
 static void event_property_update(struct work_struct *work)
 {
-
 	struct hdcp_workqueue *hdcp_work = container_of(work, struct hdcp_workqueue, property_update_work);
-	struct amdgpu_dm_connector *aconnector = hdcp_work->aconnector;
-	struct drm_device *dev = hdcp_work->aconnector->base.dev;
+	struct amdgpu_dm_connector *aconnector = NULL;
+	struct drm_device *dev;
 	long ret;
+	unsigned int conn_index;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
 
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-	mutex_lock(&hdcp_work->mutex);
+	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX; conn_index++) {
+		aconnector = hdcp_work->aconnector[conn_index];
 
+		if (!aconnector)
+			continue;
 
-	if (aconnector->base.state && aconnector->base.state->commit) {
-		ret = wait_for_completion_interruptible_timeout(&aconnector->base.state->commit->hw_done, 10 * HZ);
+		if (!aconnector->base.index)
+			continue;
 
-		if (ret == 0) {
-			DRM_ERROR("HDCP state unknown! Setting it to DESIRED");
-			hdcp_work->encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
-		}
-	}
+		connector = &aconnector->base;
+
+		/* check if display connected */
+		if (connector->status != connector_status_connected)
+			continue;
 
-	if (aconnector->base.state) {
-		if (hdcp_work->encryption_status != MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF) {
-			if (aconnector->base.state->hdcp_content_type ==
+		conn_state = aconnector->base.state;
+
+		if (!conn_state)
+			continue;
+
+		dev = connector->dev;
+
+		if (!dev)
+			continue;
+
+		drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+		mutex_lock(&hdcp_work->mutex);
+
+		if (conn_state->commit) {
+			ret = wait_for_completion_interruptible_timeout(
+				&conn_state->commit->hw_done, 10 * HZ);
+			if (ret == 0) {
+				DRM_ERROR(
+					"HDCP state unknown! Setting it to DESIRED");
+				hdcp_work->encryption_status[conn_index] =
+					MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+			}
+		}
+		if (hdcp_work->encryption_status[conn_index] !=
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF) {
+			if (conn_state->hdcp_content_type ==
 				DRM_MODE_HDCP_CONTENT_TYPE0 &&
-			hdcp_work->encryption_status <=
-				MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON)
-				drm_hdcp_update_content_protection(&aconnector->base,
+				hdcp_work->encryption_status[conn_index] <=
+				MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON) {
+
+				DRM_DEBUG_DRIVER("[HDCP_DM] DRM_MODE_CONTENT_PROTECTION_ENABLED\n");
+				drm_hdcp_update_content_protection(
+					connector,
 					DRM_MODE_CONTENT_PROTECTION_ENABLED);
-			else if (aconnector->base.state->hdcp_content_type ==
+			} else if (conn_state->hdcp_content_type ==
 					DRM_MODE_HDCP_CONTENT_TYPE1 &&
-				hdcp_work->encryption_status ==
-					MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON)
-				drm_hdcp_update_content_protection(&aconnector->base,
+					hdcp_work->encryption_status[conn_index] ==
+					MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON) {
+				drm_hdcp_update_content_protection(
+					connector,
 					DRM_MODE_CONTENT_PROTECTION_ENABLED);
+			}
 		} else {
-			drm_hdcp_update_content_protection(&aconnector->base,
-				DRM_MODE_CONTENT_PROTECTION_DESIRED);
+			DRM_DEBUG_DRIVER("[HDCP_DM] DRM_MODE_CONTENT_PROTECTION_DESIRED\n");
+			drm_hdcp_update_content_protection(
+				connector, DRM_MODE_CONTENT_PROTECTION_DESIRED);
+
 		}
+		mutex_unlock(&hdcp_work->mutex);
+		drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	}
-
-	mutex_unlock(&hdcp_work->mutex);
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 }
 
 static void event_property_validate(struct work_struct *work)
@@ -340,19 +381,51 @@ static void event_property_validate(struct work_struct *work)
 	struct hdcp_workqueue *hdcp_work =
 		container_of(to_delayed_work(work), struct hdcp_workqueue, property_validate_dwork);
 	struct mod_hdcp_display_query query;
-	struct amdgpu_dm_connector *aconnector = hdcp_work->aconnector;
-
-	if (!aconnector)
-		return;
+	struct amdgpu_dm_connector *aconnector;
+	unsigned int conn_index;
 
 	mutex_lock(&hdcp_work->mutex);
 
-	query.encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
-	mod_hdcp_query_display(&hdcp_work->hdcp, aconnector->base.index, &query);
+	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX;
+	     conn_index++) {
+		aconnector = hdcp_work->aconnector[conn_index];
+
+
+		if (!aconnector)
+			continue;
+
+		if (!aconnector->base.index)
+			continue;
+
+		/* check if display connected */
+		if (aconnector->base.status != connector_status_connected)
+			continue;
 
-	if (query.encryption_status != hdcp_work->encryption_status) {
-		hdcp_work->encryption_status = query.encryption_status;
-		schedule_work(&hdcp_work->property_update_work);
+		if (!aconnector->base.state)
+			continue;
+
+		query.encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+		mod_hdcp_query_display(&hdcp_work->hdcp, aconnector->base.index,
+				       &query);
+
+		DRM_DEBUG_DRIVER("[HDCP_DM] disp %d, connector->CP %u, (query, work): (%d, %d)\n",
+			aconnector->base.index,
+			aconnector->base.state->content_protection,
+			query.encryption_status,
+			hdcp_work->encryption_status[conn_index]);
+
+		if (query.encryption_status !=
+		    hdcp_work->encryption_status[conn_index]) {
+			DRM_DEBUG_DRIVER("[HDCP_DM] encryption_status change from %x to %x\n",
+				hdcp_work->encryption_status[conn_index], query.encryption_status);
+
+			hdcp_work->encryption_status[conn_index] =
+				query.encryption_status;
+
+			DRM_DEBUG_DRIVER("[HDCP_DM] trigger property_update_work\n");
+
+			schedule_work(&hdcp_work->property_update_work);
+		}
 	}
 
 	mutex_unlock(&hdcp_work->mutex);
@@ -686,6 +759,13 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 		hdcp_work[i].hdcp.config.ddc.funcs.read_i2c = lp_read_i2c;
 		hdcp_work[i].hdcp.config.ddc.funcs.write_dpcd = lp_write_dpcd;
 		hdcp_work[i].hdcp.config.ddc.funcs.read_dpcd = lp_read_dpcd;
+
+		memset(hdcp_work[i].aconnector, 0,
+		       sizeof(struct amdgpu_dm_connector *) *
+			       AMDGPU_DM_MAX_DISPLAY_INDEX);
+		memset(hdcp_work[i].encryption_status, 0,
+		       sizeof(enum mod_hdcp_encryption_status) *
+			       AMDGPU_DM_MAX_DISPLAY_INDEX);
 	}
 
 	cp_psp->funcs.update_stream_config = update_config;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index bbbf7d0eff82..69b445b011c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -43,7 +43,7 @@ struct hdcp_workqueue {
 	struct delayed_work callback_dwork;
 	struct delayed_work watchdog_timer_dwork;
 	struct delayed_work property_validate_dwork;
-	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_dm_connector *aconnector[AMDGPU_DM_MAX_DISPLAY_INDEX];
 	struct mutex mutex;
 
 	struct mod_hdcp hdcp;
@@ -51,8 +51,7 @@ struct hdcp_workqueue {
 	struct mod_hdcp_display display;
 	struct mod_hdcp_link link;
 
-	enum mod_hdcp_encryption_status encryption_status;
-
+	enum mod_hdcp_encryption_status encryption_status[AMDGPU_DM_MAX_DISPLAY_INDEX];
 	/* when display is unplugged from mst hub, connctor will be
 	 * destroyed within dm_dp_mst_connector_destroy. connector
 	 * hdcp perperties, like type, undesired, desired, enabled,
-- 
2.39.0

