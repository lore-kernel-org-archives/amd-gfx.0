Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822F8C001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD3310E4B8;
	Wed,  2 Aug 2023 06:53:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE14E10E4B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxvUlXfPuXAtUWcwpLXu8l3ZqVdzf4i3ezZz21q+YvGPH/tmNG3ud/aaBuINigU5xpUD5X+opvAGq3HsNXfLJvsqj436DXJ8ktsYbcARpWWDJ+rt8/uOc0ngSs1D1is6G9DaGfZ5Zd3sqlrgxpKjJINZj6kXwjl0eHaEk3vgiVy0WgtspsSToWyC2z7qunX+y80lp7stbU4ETkmtC6TtxlmiSoniOXOYGcztqo5ZxrEHAM+ZbYr0AKTJOV8r4ZtYbQ3977Bfj0Dhcbug7ICDdIwye8D8LIcq+oIYyn47HwKJOwNktHdQUSWudr/W/8ZvNAlNwl4OU9pJEPFu/fXZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qmwSqJ49QeaVjBRdPVKNRD3Y4cSzqC/E9tPBKEMabc=;
 b=cVKD4oC5KiWAX67R3LSCfjTxY9oyRPQJmd8il7xxXUdUowwuGreaD+VDOKLyDjGXDnrIK7VH18qzI8TOH4IZM+39rqtUsVgUIgWLOowgcNF/haoXYDAdqayYFaL00P9USLYaHm5Zv7xmZckNwg+i1vzlm5P8FWO+zDmYRbaf20byiXrwZ0CuC9+pECiiR1aapO2tV8yDgYpJHONAb7pVnG3EB3x27c9Npg68eDLNinklQ8Gyq2MehH8WtPCn2eT9/WcjqUWOjjBdOuLwn/fAx+/Gp+FuHcJXYKyhluvbhNaNdQ66zUbVZLkaDBsLuriPzSgm97L483xGoVwG5sjQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qmwSqJ49QeaVjBRdPVKNRD3Y4cSzqC/E9tPBKEMabc=;
 b=ah6zz4WaOMEQ72Ef2ljTjSDPkEEGMbVFlKMZ+I9ooSMEoHYirpL2kdwEAksJc+v34IGSd8ZCANYnq/kxpFnh3Ndq/araGtm2uXkRhDQIX53MESi4k5KlQ7847C+6ffZuBNizO32FyPFJJKqaRQrI9Z19mpA2nzwF4UalvwZ4puU=
Received: from MW4PR04CA0325.namprd04.prod.outlook.com (2603:10b6:303:82::30)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:53:46 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::12) by MW4PR04CA0325.outlook.office365.com
 (2603:10b6:303:82::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:53:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:45 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:53:36 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/22] drm/amd/display: Change HDCP update sequence for DM
Date: Wed, 2 Aug 2023 14:51:31 +0800
Message-ID: <20230802065132.3129932-22-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e5c7d8-8df3-48c7-274d-08db932537de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XpKvLEV+ACthP0lQ87mmGejGiSZuvcffSe6cOmu7JR05paRMq7xViLg//iYsEntmDbSHJSFF9DU9BOU4vgXPfsxt1MOXSl1g9yxCtQM5OJjSoRRzlOtxfov9uDAHjxQI0A358EEMykaGgYtC26GSbLr7LYdaqTwTUPoMR8GpgZ7b5Q/Dp5AmIEenqzgLh2aRwvZcq6jjsf19lXDzrS0/sF30zDnNK0c0/xMfjz+hOxqEuDReD1YYZUUo8bxiMtqbcOKj5Mfe+sXu2EHx0ZqX9uOP2sBGzxqZE3YNDOJMSeZFRtqUunhovi8zbkbBJrub2sI6DkzgLED4SZQkOcN3OSktNNcqZSWZYmtyK/DW41m+u0n4kfqFwfmjFcGD5oxQJtJrvtKj9m8G6tQUgx8acjhK5mTTy90Tyu4rD12mk6pbQZlx19b8u4I0AUycaug9zZO5eDbYuptCbzDaDAkO42ofoH8Lt9LEBXLO/Wd+NCMNE+tM2aQG8br32QAMg/o5k3GNSE0ToTLs2p3uFe16iJyiG6TF9Stw5g9yV8PXnIt8e/ErLwUoF4lNMOAh6c39x3RU2BVxK4bR8G+wuAhQyha/iS2hnBRDRAFgPQCk7Ya1jKe+zTIMXXzoFqArhA+9HY8q8gVq3nn9jSfH1e/C6utjckx8Yq3idHQ8w1Ik5yMN4bq0GTa9e5uAglv7WvL9zEwPa2bVxHoIaop0hYDvzfbh8B/O+eEpI3WBb7Xtx7SGZcA0X39kWgvbgpHI1p+bGfK0zdp+6Qvy7FWomysxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(336012)(40460700003)(2616005)(186003)(316002)(86362001)(478600001)(81166007)(54906003)(70586007)(70206006)(6666004)(356005)(7696005)(6916009)(4326008)(82740400003)(36756003)(41300700001)(26005)(426003)(15650500001)(8676002)(5660300002)(8936002)(47076005)(1076003)(2906002)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:53:46.1873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e5c7d8-8df3-48c7-274d-08db932537de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Refactor the sequence in hdcp_update_display() to use
mod_hdcp_update_display().

Previous sequence:
	- remove()->add()

This Sequence was used to update the display, (mod_hdcp_update_display
didn't exist at the time). This meant for any hdcp updates (type changes,
enable/disable) we would remove, reconstruct, and add. This leads to
unnecessary calls to psp eventually

New Sequence using mod_hdcp_update_display():
	- add() once when stream is enabled
	- use update() for all updates

The update function checks for prev == new states and will not
unnecessarily end up calling psp via add/remove.

Reviewed-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 80 +++++++++----------
 1 file changed, 38 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 8db47f66eac0..20cfc5be21a4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -168,53 +168,45 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 			 bool enable_encryption)
 {
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
-	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
-	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
-	struct mod_hdcp_display_query query;
+	struct mod_hdcp_link_adjustment link_adjust;
+	struct mod_hdcp_display_adjustment display_adjust;
 	unsigned int conn_index = aconnector->base.index;
 
 	mutex_lock(&hdcp_w->mutex);
 	hdcp_w->aconnector[conn_index] = aconnector;
 
-	query.display = NULL;
-	mod_hdcp_query_display(&hdcp_w->hdcp, aconnector->base.index, &query);
-
-	if (query.display) {
-		memcpy(display, query.display, sizeof(struct mod_hdcp_display));
-		mod_hdcp_remove_display(&hdcp_w->hdcp, aconnector->base.index, &hdcp_w->output);
-
-		hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
-
-		if (enable_encryption) {
-			/* Explicitly set the saved SRM as sysfs call will be after
-			 * we already enabled hdcp (s3 resume case)
-			 */
-			if (hdcp_work->srm_size > 0)
-				psp_set_srm(hdcp_work->hdcp.config.psp.handle, hdcp_work->srm,
-					    hdcp_work->srm_size,
-					    &hdcp_work->srm_version);
-
-			display->adjust.disable = MOD_HDCP_DISPLAY_NOT_DISABLE;
-			if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0) {
-				hdcp_w->link.adjust.hdcp1.disable = 0;
-				hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
-			} else if (content_type == DRM_MODE_HDCP_CONTENT_TYPE1) {
-				hdcp_w->link.adjust.hdcp1.disable = 1;
-				hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_1;
-			}
+	memset(&link_adjust, 0, sizeof(link_adjust));
+	memset(&display_adjust, 0, sizeof(display_adjust));
 
-			schedule_delayed_work(&hdcp_w->property_validate_dwork,
-					      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
-		} else {
-			display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
-			hdcp_w->encryption_status[conn_index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
-			cancel_delayed_work(&hdcp_w->property_validate_dwork);
+	if (enable_encryption) {
+		/* Explicitly set the saved SRM as sysfs call will be after we already enabled hdcp
+		 * (s3 resume case)
+		 */
+		if (hdcp_work->srm_size > 0)
+			psp_set_srm(hdcp_work->hdcp.config.psp.handle, hdcp_work->srm,
+				    hdcp_work->srm_size,
+				    &hdcp_work->srm_version);
+
+		display_adjust.disable = MOD_HDCP_DISPLAY_NOT_DISABLE;
+
+		link_adjust.auth_delay = 2;
+
+		if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0) {
+			link_adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
+		} else if (content_type == DRM_MODE_HDCP_CONTENT_TYPE1) {
+			link_adjust.hdcp1.disable = 1;
+			link_adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_1;
 		}
 
-		display->state = MOD_HDCP_DISPLAY_ACTIVE;
+		schedule_delayed_work(&hdcp_w->property_validate_dwork,
+				      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
+	} else {
+		display_adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
+		hdcp_w->encryption_status[conn_index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+		cancel_delayed_work(&hdcp_w->property_validate_dwork);
 	}
 
-	mod_hdcp_add_display(&hdcp_w->hdcp, link, display, &hdcp_w->output);
+	mod_hdcp_update_display(&hdcp_w->hdcp, conn_index, &link_adjust, &display_adjust, &hdcp_w->output);
 
 	process_output(hdcp_w);
 	mutex_unlock(&hdcp_w->mutex);
@@ -513,7 +505,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	int link_index = aconnector->dc_link->link_index;
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
-	struct drm_connector_state *conn_state;
+	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
 	struct dc_sink *sink = NULL;
 	bool link_is_hdcp14 = false;
 
@@ -556,7 +548,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
 	link->adjust.auth_delay = 2;
 	link->adjust.hdcp1.disable = 0;
-	conn_state = aconnector->base.state;
+	hdcp_w->encryption_status[display->index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
 
 	DRM_DEBUG_DRIVER("[HDCP_DM] display %d, CP %d, type %d\n", aconnector->base.index,
 			 (!!aconnector->base.state) ?
@@ -564,9 +556,13 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 			 (!!aconnector->base.state) ?
 			 aconnector->base.state->hdcp_content_type : -1);
 
-	if (conn_state)
-		hdcp_update_display(hdcp_work, link_index, aconnector,
-				    conn_state->hdcp_content_type, false);
+	mutex_lock(&hdcp_w->mutex);
+
+	mod_hdcp_add_display(&hdcp_w->hdcp, link, display, &hdcp_w->output);
+
+	process_output(hdcp_w);
+	mutex_unlock(&hdcp_w->mutex);
+
 }
 
 /**
-- 
2.25.1

