Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BF3C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56009610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56009610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED8D6EB95;
	Fri, 16 Apr 2021 14:34:49 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700073.outbound.protection.outlook.com [40.107.70.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC6D6EB90
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhLQpZ10Bw2DXBgVxemt4qje9FVJlGOofQuw2i/nLaCrHk+7Js20/kCds741UtAi1sOlVXsUgLRxGQhnMxQcLqLhcJLbBJyAlP5JXjNczP+9R8j0QdSzic4/k+n6lIQLCIaydlpyNo3+dwJCqNOOG3GPj6SnitmbjAxAqzm6gwgiQYMTT4MO+SEXpwgTvlEsjfDiTy1ZAz07iPAHo5faULW5L4WGbBSNLDszM+WAL0kxy/ckdhg6O0Y8r18IqpjOEs1ufONSoSm0L8SUkG7USq/fIkgprHxFtp8+9Pr9sepvNHj86oi9Ugx57a7h58bQ1FQ03y4c92mt1sTemSn7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUU/3Utlqt7CpmZMq222AwV2xUJ5p/U4rBq++BszqRA=;
 b=Xuf4xo6iSGvSrsm/LUsK8el37fO3mRBh0WDW1nUHNdPHcaVmVV9cHkVZLZ4Ea9Qf7q1luIWa1eeHujgFKrLdd7z4IXK7LIb4J1LXveV3ykTu12N7gLnGGMZ7opzoaXOwB4aX0q+AQb9MIYnKgOG5+zwbeiEfKHyyxAOY1A4LK1WC4D2W4xoHt2ntNXmkKv5s5HtHjAJP+dgCgh4NRBsUV/BkBT6VrE1oVODxNqyxrIYmjs56jz+heDR/w/SL33E+vc7cpubjp119OfaR+S6ZcX5Az8iyuwcBGB3VwOiWaMzl7Fd1j3ZqpS9ZVuqidEGOUqP4CY/ffLDgLzDa9eXSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUU/3Utlqt7CpmZMq222AwV2xUJ5p/U4rBq++BszqRA=;
 b=PvIbmofJfSYmH1xa2AtYYUCw6ttHz9P3K5wUH2RzXA15STAUBVpFDoswvIortS+gCzlhiUNf7co8bhYu6BzbappHWiNJJMOrIlEV4FtvYhWO1qGrMwyxtUfgS6GB2H0YQLb9vqE7NDHXpXN52RYy5ZQ6VbCTRhw3N8CVAjHpbBA=
Received: from BN9PR03CA0482.namprd03.prod.outlook.com (2603:10b6:408:130::7)
 by CH2PR12MB3750.namprd12.prod.outlook.com (2603:10b6:610:14::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 14:34:45 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::83) by BN9PR03CA0482.outlook.office365.com
 (2603:10b6:408:130::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:44 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:39 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/19] drm/amd/display: fix HDCP drm prop update for MST
Date: Fri, 16 Apr 2021 10:34:12 -0400
Message-ID: <20210416143417.611019-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16da223c-90d3-4b1d-9d2a-08d900e4c7cb
X-MS-TrafficTypeDiagnostic: CH2PR12MB3750:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3750FCE6E53FEE5EC32D1A458B4C9@CH2PR12MB3750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:304;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmWB8CJQ+2AlcRw62N+9vJomAKrnRXBDuz59mWxvpAQrBnMFS7CCyVhqt1Ttf3/XofvnFd5G1p81kWwRlwvWcPQvH8EdbKqZOR49BfazW6d/k6KUnHiOJaUaFZq4APr/Me15TbUAuWVYMihNUjmq54H46vTbgAkfAis8vsU4pLJRtgmzPOAYNVTWLjcVeR7Llon5c9NNnSmjGZHf402Sw95YsN169zP59CJLDfdLnAm3mSsC59T6GfA2bEnDyjhKphyT0qjdtR5gfij35ymsfR1UmXodr3gnwu7GVv0ao7yOG9/WTLVe8m7Wr0V1Nr5T1O/3YYdwT7xPr20U06nUX32eukNq1iyNfeTrEzNqg+NVw51BRQof/m8O6d8n3iMQHHPumRxJLRRLUcMGBFB8/Y+rj8u/k9IMnbqpzCwtNEFuZ2wHgUxhoxRpMuMHm7X17rI57FNmCa86wj3nG+fJ4tDvLTs/mGo0orEaG+W5WWXIP9MoOUVfxPmc3IVyAD1dzmJIYngIfBqQ92g8PWWvjQgaMJjMwoOtIWh7ExHNndsAHxejPqLq8Rz/Fi6UjKgh9asDXVnzY2biN+KTu1Ew3Nzy48HXgiXsbx67V8VxRjKscfro8JEWLziHrHw5ne+CrZ8Y4XM5DwKMQnxvY5BiJv1B+7UycV6QCII2pncj+NDmhoZAX4+hjYbmGbQwcjeY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(426003)(36756003)(36860700001)(336012)(8676002)(5660300002)(81166007)(4326008)(8936002)(2906002)(15650500001)(70586007)(86362001)(7696005)(70206006)(47076005)(83380400001)(2616005)(356005)(316002)(26005)(54906003)(6916009)(186003)(1076003)(82310400003)(82740400003)(30864003)(478600001)(44832011)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:45.3729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16da223c-90d3-4b1d-9d2a-08d900e4c7cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3750
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
Cc: Dingchen Zhang <Dingchen.Zhang@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Dingchen (David) Zhang" <dingchen.zhang@amd.com>

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
Use array of MAX_NUM_OF_DISPLAY for both aconnector and encryption
status in hdcp workqueue data structure for each physical link.
For property validate/update work queue, we iterates over the array
and do similar operation/check for each connected display.

Signed-off-by: Dingchen (David) Zhang <dingchen.zhang@amd.com>
Reviewed-by: Dingchen Zhang <Dingchen.Zhang@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 109 +++++++++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   6 +-
 2 files changed, 81 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 50f6b3a86931..2ec076af9e89 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -171,9 +171,10 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
 	struct mod_hdcp_display_query query;
+	unsigned int conn_index = aconnector->base.index;
 
 	mutex_lock(&hdcp_w->mutex);
-	hdcp_w->aconnector = aconnector;
+	hdcp_w->aconnector[conn_index] = aconnector;
 
 	query.display = NULL;
 	mod_hdcp_query_display(&hdcp_w->hdcp, aconnector->base.index, &query);
@@ -205,7 +206,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 					      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
 		} else {
 			display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
-			hdcp_w->encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+			hdcp_w->encryption_status[conn_index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
 			cancel_delayed_work(&hdcp_w->property_validate_dwork);
 		}
 
@@ -224,9 +225,10 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 {
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
 	struct drm_connector_state *conn_state = aconnector->base.state;
+	unsigned int conn_index = aconnector->base.index;
 
 	mutex_lock(&hdcp_w->mutex);
-	hdcp_w->aconnector = aconnector;
+	hdcp_w->aconnector[conn_index] = aconnector;
 
 	/* the removal of display will invoke auth reset -> hdcp destroy and
 	 * we'd expect the CP prop changed back to DESIRED if at the time ENABLED.
@@ -247,13 +249,16 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
 {
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
+	unsigned int conn_index;
 
 	mutex_lock(&hdcp_w->mutex);
 
 	mod_hdcp_reset_connection(&hdcp_w->hdcp,  &hdcp_w->output);
 
 	cancel_delayed_work(&hdcp_w->property_validate_dwork);
-	hdcp_w->encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+
+	for (conn_index = 0; conn_index < MAX_NUM_OF_DISPLAYS; ++conn_index)
+		hdcp_w->encryption_status[conn_index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
 
 	process_output(hdcp_w);
 
@@ -290,38 +295,67 @@ static void event_callback(struct work_struct *work)
 
 
 }
+
+static struct amdgpu_dm_connector *find_first_connected_output(struct hdcp_workqueue *hdcp_work)
+{
+	unsigned int conn_index;
+
+	for (conn_index = 0; conn_index < MAX_NUM_OF_DISPLAYS; ++conn_index) {
+		if (hdcp_work->aconnector[conn_index])
+			return hdcp_work->aconnector[conn_index];
+	}
+
+	return NULL;
+}
+
 static void event_property_update(struct work_struct *work)
 {
 
 	struct hdcp_workqueue *hdcp_work = container_of(work, struct hdcp_workqueue, property_update_work);
-	struct amdgpu_dm_connector *aconnector = hdcp_work->aconnector;
-	struct drm_device *dev = hdcp_work->aconnector->base.dev;
+	struct amdgpu_dm_connector *aconnector = find_first_connected_output(hdcp_work);
+	struct drm_device *dev;
 	long ret;
+	unsigned int conn_index;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+
+	if (!aconnector)
+		return;
+
+	dev = aconnector->base.dev;
 
 	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
 	mutex_lock(&hdcp_work->mutex);
 
+	for (conn_index = 0; conn_index < MAX_NUM_OF_DISPLAYS; ++conn_index) {
+		aconnector = hdcp_work->aconnector[conn_index];
+
+		if (!aconnector)
+			continue;
 
-	if (aconnector->base.state->commit) {
-		ret = wait_for_completion_interruptible_timeout(&aconnector->base.state->commit->hw_done, 10 * HZ);
+		connector = &aconnector->base;
+		conn_state = aconnector->base.state;
+		if (conn_state->commit) {
+			ret = wait_for_completion_interruptible_timeout(&conn_state->commit->hw_done, 10 * HZ);
 
-		if (ret == 0) {
-			DRM_ERROR("HDCP state unknown! Setting it to DESIRED");
-			hdcp_work->encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+			if (ret == 0) {
+				DRM_ERROR("HDCP state unknown! Setting it to DESIRED");
+				hdcp_work->encryption_status[conn_index] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+			}
 		}
-	}
 
-	if (hdcp_work->encryption_status != MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF) {
-		if (aconnector->base.state->hdcp_content_type == DRM_MODE_HDCP_CONTENT_TYPE0 &&
-		    hdcp_work->encryption_status <= MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON)
-			drm_hdcp_update_content_protection(&aconnector->base, DRM_MODE_CONTENT_PROTECTION_ENABLED);
-		else if (aconnector->base.state->hdcp_content_type == DRM_MODE_HDCP_CONTENT_TYPE1 &&
-			 hdcp_work->encryption_status == MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON)
-			drm_hdcp_update_content_protection(&aconnector->base, DRM_MODE_CONTENT_PROTECTION_ENABLED);
-	} else {
-		drm_hdcp_update_content_protection(&aconnector->base, DRM_MODE_CONTENT_PROTECTION_DESIRED);
-	}
+		if (hdcp_work->encryption_status[conn_index] != MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF) {
+			if (conn_state->hdcp_content_type == DRM_MODE_HDCP_CONTENT_TYPE0 &&
+			    hdcp_work->encryption_status[conn_index] <= MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON)
+				drm_hdcp_update_content_protection(connector, DRM_MODE_CONTENT_PROTECTION_ENABLED);
+			else if (conn_state->hdcp_content_type == DRM_MODE_HDCP_CONTENT_TYPE1 &&
+				 hdcp_work->encryption_status[conn_index] == MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON)
+				drm_hdcp_update_content_protection(connector, DRM_MODE_CONTENT_PROTECTION_ENABLED);
+		} else {
+			drm_hdcp_update_content_protection(connector, DRM_MODE_CONTENT_PROTECTION_DESIRED);
+		}
 
+	}
 
 	mutex_unlock(&hdcp_work->mutex);
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
@@ -332,19 +366,28 @@ static void event_property_validate(struct work_struct *work)
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
+	for (conn_index = 0; conn_index < MAX_NUM_OF_DISPLAYS; ++conn_index) {
+		aconnector = hdcp_work->aconnector[conn_index];
+
+		if (!aconnector)
+			continue;
+
+		query.encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+		mod_hdcp_query_display(&hdcp_work->hdcp, aconnector->base.index, &query);
 
-	if (query.encryption_status != hdcp_work->encryption_status) {
-		hdcp_work->encryption_status = query.encryption_status;
-		schedule_work(&hdcp_work->property_update_work);
+		pr_debug("[HDCP_DM] display %d, CP %u, (query->enc_st, work->enc_st): (%d, %d)\n",
+			 aconnector->base.index, aconnector->base.state->content_protection,
+			 query.encryption_status, hdcp_work->encryption_status[conn_index]);
+
+		if (query.encryption_status != hdcp_work->encryption_status[conn_index]) {
+			hdcp_work->encryption_status[conn_index] = query.encryption_status;
+			schedule_work(&hdcp_work->property_update_work);
+		}
 	}
 
 	mutex_unlock(&hdcp_work->mutex);
@@ -655,6 +698,10 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 		hdcp_work[i].hdcp.config.ddc.funcs.read_i2c = lp_read_i2c;
 		hdcp_work[i].hdcp.config.ddc.funcs.write_dpcd = lp_write_dpcd;
 		hdcp_work[i].hdcp.config.ddc.funcs.read_dpcd = lp_read_dpcd;
+
+		memset(hdcp_work[i].aconnector, 0, sizeof(struct amdgpu_dm_connector *) * MAX_NUM_OF_DISPLAYS);
+		memset(hdcp_work[i].encryption_status, 0,
+			sizeof(enum mod_hdcp_encryption_status) * MAX_NUM_OF_DISPLAYS);
 	}
 
 	cp_psp->funcs.update_stream_config = update_config;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 09294ff122fe..570863160d60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2019 Advanced Micro Devices, Inc.
+ * Copyright (C) 2019-2020 Advanced Micro Devices, Inc. All rights reserved.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -43,7 +43,7 @@ struct hdcp_workqueue {
 	struct delayed_work callback_dwork;
 	struct delayed_work watchdog_timer_dwork;
 	struct delayed_work property_validate_dwork;
-	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_dm_connector *aconnector[MAX_NUM_OF_DISPLAYS];
 	struct mutex mutex;
 
 	struct mod_hdcp hdcp;
@@ -51,7 +51,7 @@ struct hdcp_workqueue {
 	struct mod_hdcp_display display;
 	struct mod_hdcp_link link;
 
-	enum mod_hdcp_encryption_status encryption_status;
+	enum mod_hdcp_encryption_status encryption_status[MAX_NUM_OF_DISPLAYS];
 	uint8_t max_link;
 
 	uint8_t *srm;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
