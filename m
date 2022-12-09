Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62872C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE0A10E56C;
	Fri,  9 Dec 2022 16:38:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B2210E558
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhijpmW3daXlfSbOkju9ME5RfOkSgWnWjWBhX+Vkfg4CpNfAZMdSV05HgL+lUT7EmJohz4XI7VR+u5OYCMOSnZtaWXDtD4TI5Zc8AoJNUhIrCiZvE9FtHqpVqD2koriMk50SxKPeNj6cyK3fuW0u3x50itBMeAYYHAQr+sAQMoBP67pJaE+yh+6I3JQQu64vfuumXceWNA8PXa8BPGELodRhy3gpdvSd+Wp3/mJzDF8sZRvWZHmQEhByOnGx19cAjlUGWevMNx/CnR60rS2O6V5Psz3VLWX9eV7zD5UUQ+aG7t00GyrC6fgknIu2m0Ug0F3a3lrh/bN9qRTS5dq5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjZwmQ04Wml/6ConlLe8zSkX6gXvR4CM2bSV3asn+Rs=;
 b=n2PWEQVjy8GV21igL4DCt5/BQJd9M/eIrFHPTxa0F6W6ELwZHTvqUlrfGf7r1fWyq/Do+eZbz0TS4U3b5z9p/PQ1jgDDrqZZX//qEVG8EP16nv2vJbr+WaIKkN21Rsi4IS1/4j/7bDD/Wk3ah54hIonEE8w2fBMxvkKMjz/fd1Af2bygvdsx+QFJqm7YKsSsL0bZzCPBwuv1dKrkj05KwDS+EhkuweG6e16twxiywVVVyqzJtW44ERdbQPJ48RDc8P0d/b+MOg6a+Ge1eILLZ8OJnjcKpoNQCGFbOcWXXbWlTzzKL1dlFUK0zkXO5kP52AdEBovhIpN5/l0r9opj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjZwmQ04Wml/6ConlLe8zSkX6gXvR4CM2bSV3asn+Rs=;
 b=XlGjivLobjgcuJdNGNiwV/swp+6UwmrR0MWVAlakXQSl1Rvx3LUyX5Ordok3Haf9mhvSO2DGzFP+Vwq0DrFbvqlAQ+pEO0SXo7um8yoME/JVAaC2QHoE2HMd5z2vuOkI3PTABgKKyM5LMS26rtycaC9uEyu8xjxfdcUejDGkpPY=
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by DM4PR12MB5279.namprd12.prod.outlook.com (2603:10b6:5:39f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 16:37:22 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::e8) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:21 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:19 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/23] drm/amd/display: phase2 enable mst hdcp multiple
 displays
Date: Fri, 9 Dec 2022 11:36:29 -0500
Message-ID: <20221209163647.25704-6-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|DM4PR12MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ba5eb2-fb68-4ea7-a977-08dada03a552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjqH9n1mOgk0YOrMlguix8yBYuJ8bN9WOV6+xdL0ev4+ioDtJLFHlU6fr3mp7sfpVJvxBBvbzkUxaTJwXrYUJcAs4jdTHVFvfDxBEwbSbiHKKZHfNxlfUdl9y/45YKgMS3Qik6hZIM+9ba9GjR0FdpKFH+HIIzmmXx+swXxiYfXrxjHhQok0gdo2JHFlx6SlMygdBcbKp4tGefkhJLl1smGEXydKsKC/njJi8B+Z7buc9Ypzm9/vluivhfsrrFTjYX0AAVnzs+JAG/13H92WNDGPw+YuToo4yeGbNmFCHH+PpZiNQj2S+6A5vB/KLp6kk1jO4M26fPnH5NXYqWQVIbzYVs3X4mAbGiH4ogqES1LIXh5pl8RfVxHzEt9vKcLJG3otrnOVz6VGeIDU7nmox8XpxHJSbN/uivUIdX5o5MZ+wYk9EeGBELK5Z99MgaEqUY9XAvkpZ8uOsW4xU52//+H233USk8ql5wLm9ApmnM/r4k85v1PojSykMvHxZiZpf2GVL7jLxIuG1aUmXUOhobL6QbAkW1umjy9YzMC3LLyFrKplp22Gvqyw+fHIoE1fzLl0hLHTckCTAs9/e7/UZK7/3nhYnRIcXl/x+jTLuG+OtsGHXaCvoKj0eIU1KVf9MeHLxr5lFpniSFs+Ck5yoy76Z4dOg3YPLyIx6MrJKoCtSIuXdaB2cOLrUfExi9xJbSzdsixmgB/1OOssZHLgiCUSUA/ni6j7GOT2hBCgFbE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(40460700003)(70206006)(8676002)(40480700001)(36756003)(4326008)(70586007)(41300700001)(336012)(2616005)(16526019)(186003)(1076003)(5660300002)(426003)(47076005)(478600001)(6666004)(8936002)(54906003)(30864003)(6916009)(316002)(81166007)(356005)(83380400001)(82740400003)(26005)(82310400005)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:21.8199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ba5eb2-fb68-4ea7-a977-08dada03a552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, hersen wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
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

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 160 +++++++++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   4 +-
 2 files changed, 122 insertions(+), 42 deletions(-)

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
index 09294ff122fe..6e2537e579fa 100644
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
@@ -51,7 +51,7 @@ struct hdcp_workqueue {
 	struct mod_hdcp_display display;
 	struct mod_hdcp_link link;
 
-	enum mod_hdcp_encryption_status encryption_status;
+	enum mod_hdcp_encryption_status encryption_status[AMDGPU_DM_MAX_DISPLAY_INDEX];
 	uint8_t max_link;
 
 	uint8_t *srm;
-- 
2.34.1

