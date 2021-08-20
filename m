Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C2BC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5458F61183
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5458F61183
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBCC6EB33;
	Fri, 20 Aug 2021 23:30:44 +0000 (UTC)
X-Greylist: delayed 902 seconds by postgrey-1.36 at gabe;
 Fri, 20 Aug 2021 23:30:43 UTC
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C1B66EB33
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 23:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7TOcEk5/vguTSKr4yYDUuwgmS7R0eWmAFIVVFyx8FUZzU01K0gyeYRY3ytrFfae6cwBtrLf4KH5kglwqlF23f5Iij39GkE5LKK5uwDaycwub3Nx6byUX+Nj78fW9S/EYbQ96X8QYkR4/Led5Dee5a7YpdOKCJsRMHf/yeMqr/IoMUxk8QpgApc3RmO38EmEh4P8DfU5RfJ3Wn67QSz37uMEqK3Xgqu0TrY3TzOuSYMu4ZC9Gt2gbUXkBD7MXAOPxKUIM+Is9utI+Av7GQAAUliZiy2gQF7n2CaOB7090iqttQbfwd7Acj/tzZqo3yXSb7U1179RNLKS593Z3JK0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6ZFSq+TJYcGl+oVLiNpbYqBc19pLS547GfXvvBMhLs=;
 b=TLbSETjlgtrVx6qsOzxzKwD8xKSNbc3memygrHiDYmJYjQDwAuGtEDVCkrgdyNdA0xfiBX+e0amwAFp+sIICRSijEsCDIgmxlifSkqtfwZ3j9tL6vRW2v7N+7puYrH06cG5lkU7Osy2MPZ9h82A0/K0Iup89A5OhEk73mkTXm3Asx7wlyk+wyr+L3TwI5gc5kgyC7sqq84Xjh55SPovgtHKRb+qydasPswPB849V8Ts9Q4/xzv2ev9fQuOQjsBjuNkO6YPMQ89Gv3Q1yzcTV+rEVPmMcUYptxljk6vEqwnPKseBpLzQqDBy9wn7CILKFvT2dGyjjsnGOA4l3RiPBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6ZFSq+TJYcGl+oVLiNpbYqBc19pLS547GfXvvBMhLs=;
 b=Ak6ikKYnDLdTaitPPtiIPP3ifjRq7Jk4lFIclKoz40pMJCrh5EKCbXQ++6NFc3uP0gFFKAU3xq9Z7gGlhbSsCfSYCYoANzPY/XLR8DKDN1IMyWIvFED0GImrbLPVBiplOSCFgOBhHFuvbLPD53WChoXY9b1f665Q2arQd5MPPyU=
Received: from BN8PR04CA0004.namprd04.prod.outlook.com (2603:10b6:408:70::17)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 23:15:35 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::b7) by BN8PR04CA0004.outlook.office365.com
 (2603:10b6:408:70::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 23:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 23:15:35 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 18:15:33 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, Jude Shih <shenshih@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 02/10] drm/amd/display: Support for DMUB HPD interrupt handling
Date: Fri, 20 Aug 2021 19:15:12 -0400
Message-ID: <20210820231520.1243509-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
References: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ec3e939-8ea0-4544-794a-08d964306a4e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4440:
X-Microsoft-Antispam-PRVS: <MN2PR12MB44408357393B1884FAF03019FBC19@MN2PR12MB4440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KApieXrGatMig6BkD3wYHYOTnYFx+NcQ6SD8q09LKffr3oJQF2qtjjKhbMRD8ev7+KTq+lZcBwAaSbFRrvCu2J3S00OE8tuA8n5uv8kUA4mMbuGZ+PX4vyG871i+iGMFqYU/l07wdVRx6nEHt5su/7n2IWdjMUZj3lCDhzPpOQZ4zC5DvueuejycY1Gd/3DM4lQwDn71eemHp//8k7oz8/y6Qd4YfnlsAtIfGpLlegruogLHbcsFxFtm78/4aHzZXrTQVQwansfRw0fj2cHsPiaTZCzJnWxUHKi0hAbyf09Lh4nJp5iTYsJDzUhrh9ZHG4S5EPd3qjR773zAvpUK/DXYRPmHwHuyxUJr3yeFXY4JDrbhakSVL/fUKiEGgqwlevB1Ccg0ToMRfCDml1e8+aUu++8UjinY9Q9Zcl56Hzqvw6nwqbcdJu3vI0TeWSYhLV0qYJRehkFnamZqfdI0PwhuPuEQUQAqt6N0LzzFhO9ZpRrh67C4/HSvbxjuz9y0snxoZzt7m4oGwIxUm3ioHbiPoKdXqdsqtotp3WE+6iyTCQxho3vc3M4gPhUv7vkgl4v21aS6V0++fYVPjFtd07J3a57R4rtdschu9dlG2d+HcxzfGeSs0p0utBrGNd7oo/uUtjxi9X07zCiDFi5lFFtZ08lRC/6xi22TzNrjgLkQQq5RHJ4dIdApO4bCVMWv+Aj9Vt5MyW6Q6fAXssIIsfu/HFBZ8CrEBY7Km7VSpwt3nnjoxp0KsH2mbpndhHRQKPNU9Cgg5FIh+yEKD8ajTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(36840700001)(83380400001)(478600001)(316002)(16526019)(47076005)(36860700001)(4326008)(36756003)(30864003)(1076003)(54906003)(44832011)(2906002)(2616005)(34020700004)(86362001)(26005)(8676002)(8936002)(6916009)(426003)(5660300002)(6666004)(336012)(82740400003)(81166007)(82310400003)(356005)(70586007)(186003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 23:15:35.3931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec3e939-8ea0-4544-794a-08d964306a4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jude Shih <shenshih@amd.com>

[WHY]
To add support for HPD interrupt handling from DMUB.
HPD interrupt could be triggered from outbox1 from DMUB

[HOW]
1) Use queue_work to handle hpd task from outbox1

2) Add handle_hpd_irq_helper to share interrupt handling code
between legacy and DMUB HPD from outbox1

3) Added DMUB HPD handling in dmub_srv_stat_get_notification().
HPD handling callback function and wake up the DMUB thread.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Jude Shih <shenshih@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 171 +++++++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  40 ++++
 2 files changed, 203 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 816723691d51..162a8208f74f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -215,6 +215,8 @@ static void handle_cursor_update(struct drm_plane *plane,
 static const struct drm_format_info *
 amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
 
+static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector);
+
 static bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state);
@@ -618,6 +620,116 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
 }
 #endif
 
+/**
+ * dmub_aux_setconfig_reply_callback - Callback for AUX or SET_CONFIG command.
+ * @adev: amdgpu_device pointer
+ * @notify: dmub notification structure
+ *
+ * Dmub AUX or SET_CONFIG command completion processing callback
+ * Copies dmub notification to DM which is to be read by AUX command.
+ * issuing thread and also signals the event to wake up the thread.
+ */
+void dmub_aux_setconfig_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
+{
+	if (adev->dm.dmub_notify)
+		memcpy(adev->dm.dmub_notify, notify, sizeof(struct dmub_notification));
+	if (notify->type == DMUB_NOTIFICATION_AUX_REPLY)
+		complete(&adev->dm.dmub_aux_transfer_done);
+}
+
+/**
+ * dmub_hpd_callback - DMUB HPD interrupt processing callback.
+ * @adev: amdgpu_device pointer
+ * @notify: dmub notification structure
+ *
+ * Dmub Hpd interrupt processing callback. Gets displayindex through the
+ * ink index and calls helper to do the processing.
+ */
+void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+	struct dc_link *link;
+	uint8_t link_index = 0;
+	struct drm_device *dev = adev->dm.ddev;
+
+	if (adev == NULL)
+		return;
+
+	if (notify == NULL) {
+		DRM_ERROR("DMUB HPD callback notification was NULL");
+		return;
+	}
+
+	if (notify->link_index > adev->dm.dc->link_count) {
+		DRM_ERROR("DMUB HPD index (%u)is abnormal", notify->link_index);
+		return;
+	}
+
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+
+	link_index = notify->link_index;
+
+	link = adev->dm.dc->links[link_index];
+
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+		aconnector = to_amdgpu_dm_connector(connector);
+		if (link && aconnector->dc_link == link) {
+			DRM_INFO("DMUB HPD callback: link_index=%u\n", link_index);
+			handle_hpd_irq_helper(aconnector);
+			break;
+		}
+	}
+	drm_connector_list_iter_end(&iter);
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+
+}
+
+/**
+ * register_dmub_notify_callback - Sets callback for DMUB notify
+ * @adev: amdgpu_device pointer
+ * @type: Type of dmub notification
+ * @callback: Dmub interrupt callback function
+ * @dmub_int_thread_offload: offload indicator
+ *
+ * API to register a dmub callback handler for a dmub notification
+ * Also sets indicator whether callback processing to be offloaded.
+ * to dmub interrupt handling thread
+ * Return: true if successfully registered, false if there is existing registration
+ */
+bool register_dmub_notify_callback(struct amdgpu_device *adev, enum dmub_notification_type type,
+dmub_notify_interrupt_callback_t callback, bool dmub_int_thread_offload)
+{
+	if (callback != NULL && type < ARRAY_SIZE(adev->dm.dmub_thread_offload)) {
+		adev->dm.dmub_callback[type] = callback;
+		adev->dm.dmub_thread_offload[type] = dmub_int_thread_offload;
+	} else
+		return false;
+
+	return true;
+}
+
+static void dm_handle_hpd_work(struct work_struct *work)
+{
+	struct dmub_hpd_work *dmub_hpd_wrk;
+
+	dmub_hpd_wrk = container_of(work, struct dmub_hpd_work, handle_hpd_work);
+
+	if (!dmub_hpd_wrk->dmub_notify) {
+		DRM_ERROR("dmub_hpd_wrk dmub_notify is NULL");
+		return;
+	}
+
+	if (dmub_hpd_wrk->dmub_notify->type < ARRAY_SIZE(dmub_hpd_wrk->adev->dm.dmub_callback)) {
+		dmub_hpd_wrk->adev->dm.dmub_callback[dmub_hpd_wrk->dmub_notify->type](dmub_hpd_wrk->adev,
+		dmub_hpd_wrk->dmub_notify);
+	}
+	kfree(dmub_hpd_wrk);
+
+}
+
 #define DMUB_TRACE_MAX_READ 64
 /**
  * dm_dmub_outbox1_low_irq() - Handles Outbox interrupt
@@ -634,18 +746,33 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct dmcub_trace_buf_entry entry = { 0 };
 	uint32_t count = 0;
+	struct dmub_hpd_work *dmub_hpd_wrk;
 
 	if (dc_enable_dmub_notifications(adev->dm.dc)) {
+		dmub_hpd_wrk = kzalloc(sizeof(*dmub_hpd_wrk), GFP_ATOMIC);
+		if (!dmub_hpd_wrk) {
+			DRM_ERROR("Failed to allocate dmub_hpd_wrk");
+			return;
+		}
+		INIT_WORK(&dmub_hpd_wrk->handle_hpd_work, dm_handle_hpd_work);
+
 		if (irq_params->irq_src == DC_IRQ_SOURCE_DMCUB_OUTBOX) {
 			do {
 				dc_stat_get_dmub_notification(adev->dm.dc, &notify);
-			} while (notify.pending_notification);
+				if (notify.type > ARRAY_SIZE(dm->dmub_thread_offload)) {
+					DRM_ERROR("DM: notify type %d larger than the array size %ld !", notify.type,
+					ARRAY_SIZE(dm->dmub_thread_offload));
+					continue;
+				}
+				if (dm->dmub_thread_offload[notify.type] == true) {
+					dmub_hpd_wrk->dmub_notify = &notify;
+					dmub_hpd_wrk->adev = adev;
+					queue_work(adev->dm.delayed_hpd_wq, &dmub_hpd_wrk->handle_hpd_work);
+				} else {
+					dm->dmub_callback[notify.type](adev, &notify);
+				}
 
-			if (adev->dm.dmub_notify)
-				memcpy(adev->dm.dmub_notify, &notify, sizeof(struct dmub_notification));
-			if (notify.type == DMUB_NOTIFICATION_AUX_REPLY)
-				complete(&adev->dm.dmub_aux_transfer_done);
-			// TODO : HPD Implementation
+			} while (notify.pending_notification);
 
 		} else {
 			DRM_ERROR("DM: Failed to receive correct outbox IRQ !");
@@ -1251,7 +1378,25 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			DRM_INFO("amdgpu: fail to allocate adev->dm.dmub_notify");
 			goto error;
 		}
+
+		adev->dm.delayed_hpd_wq = create_singlethread_workqueue("amdgpu_dm_hpd_wq");
+		if (!adev->dm.delayed_hpd_wq) {
+			DRM_ERROR("amdgpu: failed to create hpd offload workqueue.\n");
+			goto error;
+		}
+
 		amdgpu_dm_outbox_init(adev);
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_AUX_REPLY,
+			dmub_aux_setconfig_callback, false)) {
+			DRM_ERROR("amdgpu: fail to register dmub aux callback");
+			goto error;
+		}
+		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD, dmub_hpd_callback, true)) {
+			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
+			goto error;
+		}
+#endif
 	}
 
 	if (amdgpu_dm_initialize_drm_device(adev)) {
@@ -1333,6 +1478,8 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	if (dc_enable_dmub_notifications(adev->dm.dc)) {
 		kfree(adev->dm.dmub_notify);
 		adev->dm.dmub_notify = NULL;
+		destroy_workqueue(adev->dm.delayed_hpd_wq);
+		adev->dm.delayed_hpd_wq = NULL;
 	}
 
 	if (adev->dm.dmub_bo)
@@ -2611,9 +2758,8 @@ void amdgpu_dm_update_connector_after_detect(
 		dc_sink_release(sink);
 }
 
-static void handle_hpd_irq(void *param)
+static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 {
-	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
 	enum dc_connection_type new_connection_type = dc_connection_none;
@@ -2672,6 +2818,15 @@ static void handle_hpd_irq(void *param)
 
 }
 
+static void handle_hpd_irq(void *param)
+{
+	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
+
+	handle_hpd_irq_helper(aconnector);
+
+}
+
+
 static void dm_handle_hpd_rx_irq(struct amdgpu_dm_connector *aconnector)
 {
 	uint8_t esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index d1d353a7c77d..be796c2fed7d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -47,6 +47,8 @@
 #define AMDGPU_DM_MAX_CRTC 6
 
 #define AMDGPU_DM_MAX_NUM_EDP 2
+
+#define AMDGPU_DMUB_NOTIFICATION_MAX 5
 /*
 #include "include/amdgpu_dal_power_if.h"
 #include "amdgpu_dm_irq.h"
@@ -86,6 +88,21 @@ struct dm_compressor_info {
 	uint64_t gpu_addr;
 };
 
+typedef void (*dmub_notify_interrupt_callback_t)(struct amdgpu_device *adev, struct dmub_notification *notify);
+
+/**
+ * struct dmub_hpd_work - Handle time consuming work in low priority outbox IRQ
+ *
+ * @handle_hpd_work: Work to be executed in a separate thread to handle hpd_low_irq
+ * @dmub_notify:  notification for callback function
+ * @adev: amdgpu_device pointer
+ */
+struct dmub_hpd_work {
+	struct work_struct handle_hpd_work;
+	struct dmub_notification *dmub_notify;
+	struct amdgpu_device *adev;
+};
+
 /**
  * struct vblank_control_work - Work data for vblank control
  * @work: Kernel work data for the work event
@@ -190,8 +207,30 @@ struct amdgpu_display_manager {
 	 */
 	struct dmub_srv *dmub_srv;
 
+	/**
+	 * @dmub_notify:
+	 *
+	 * Notification from DMUB.
+	 */
+
 	struct dmub_notification *dmub_notify;
 
+	/**
+	 * @dmub_callback:
+	 *
+	 * Callback functions to handle notification from DMUB.
+	 */
+
+	dmub_notify_interrupt_callback_t dmub_callback[AMDGPU_DMUB_NOTIFICATION_MAX];
+
+	/**
+	 * @dmub_thread_offload:
+	 *
+	 * Flag to indicate if callback is offload.
+	 */
+
+	bool dmub_thread_offload[AMDGPU_DMUB_NOTIFICATION_MAX];
+
 	/**
 	 * @dmub_fb_info:
 	 *
@@ -439,6 +478,7 @@ struct amdgpu_display_manager {
 	 */
 	struct list_head da_list;
 	struct completion dmub_aux_transfer_done;
+	struct workqueue_struct *delayed_hpd_wq;
 
 	/**
 	 * @brightness:
-- 
2.25.1

