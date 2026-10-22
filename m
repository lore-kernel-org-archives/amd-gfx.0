Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D602606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 09:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FD210E35D;
	Thu, 22 Oct 2026 09:48:39 +0000 (UTC)
X-Greylist: delayed 403 seconds by postgrey-1.36 at gabe;
 Thu, 22 Oct 2026 09:48:38 UTC
Received: from yocto-server-2.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B954610E35D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 09:48:38 +0000 (UTC)
Received: by yocto-server-2.amd.com (Postfix, from userid 1009)
 id 013CCA05DF; Thu, 22 Oct 2026 09:48:36 +0000 (UTC)
From: jyotiranjan <jyotiranjan.bhuyan@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>,
 Jyotiranjan Bhuyan <Jyotiranjan.Bhuyan@amd.com>
Subject: [PATCH v1] drm/amd/display: skip hotplug uevent when sink is unchanged
Date: Thu, 22 Oct 2026 09:48:25 +0000
Message-ID: <20261022094835.591175-1-jyotiranjan.bhuyan@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jyotiranjan Bhuyan <Jyotiranjan.Bhuyan@amd.com>

Resume always sent a DRM hotplug even when the panel did not change.
amdgpu_device_resume() fired a device-wide event for every DC resume,
and dm_resume() fired another after link detection. Userspace treated
that as a connector change and restarted modeset, including across
s2idle.

Compare dc_link type and local_sink before and after detection. Any
changed root connector sends one device-wide hotplug event. No change
sends nothing. An MST root that stays an MST branch is unchanged here;
port changes stay with drm_dp_mst_topology_queue_probe(). Drop the
duplicate event from the DC path in amdgpu_device_resume().

Signed-off-by: Jyotiranjan Bhuyan <Jyotiranjan.Bhuyan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  7 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 60 ++++++++++++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |  2 +-
 4 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9269e780feb7..d25e62e8166a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4755,10 +4755,13 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 #ifdef CONFIG_PM
 		dev->dev->power.disable_depth++;
 #endif
+		/*
+		 * Display Core detects sink changes and sends any required
+		 * hotplug event from dm_resume(). Avoid sending a duplicate
+		 * event here.
+		 */
 		if (!adev->dc_enabled)
 			drm_helper_hpd_irq_event(dev);
-		else
-			drm_kms_helper_hotplug_event(dev);
 #ifdef CONFIG_PM
 		dev->dev->power.disable_depth--;
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 47a0ff2ed035..fe3fa59d5a4a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1843,6 +1843,40 @@ static void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev)
 	}
 }
 
+/*
+ * Compare link type and local_sink from before dc_link_detect() with the
+ * values after detection.
+ *
+ * A type change is a plug or unplug. When the type is unchanged, compare
+ * sinks only if the pointer changed. Both NULL is unchanged: local_sink
+ * is NULL for a disconnected link and for an MST branch after
+ * discover_dp_mst_topology() calls link_disconnect_sink().
+ * are_sinks_equal() returns false when either pointer is NULL.
+ * Downstream MST port changes are reported by
+ * drm_dp_mst_topology_queue_probe().
+ */
+static bool dm_resume_connector_changed(struct drm_connector *connector,
+					struct dc_link *link,
+					enum dc_connection_type old_type,
+					struct dc_sink *old_sink)
+{
+	enum dc_connection_type new_type = link->type;
+	struct dc_sink *new_sink = link->local_sink;
+	bool changed = false;
+
+	if (old_type != new_type)
+		changed = true;
+	else if (old_sink != new_sink)
+		changed = !are_sinks_equal(old_sink, new_sink);
+
+	drm_dbg_kms(connector->dev,
+		    "resume: %s type %d -> %d, sink %p -> %p, changed=%d\n",
+		    connector->name, old_type, new_type,
+		    old_sink, new_sink, changed);
+
+	return changed;
+}
+
 static int dm_resume(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1855,6 +1889,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
 	int i, r, j;
+	unsigned int connector_changes = 0;
 	struct dc_commit_streams_params commit_params = {};
 
 	if (dm->dc->caps.ips_support) {
@@ -1987,6 +2022,8 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
 		bool ret;
+		enum dc_connection_type old_type;
+		struct dc_sink *old_sink;
 
 		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
@@ -1997,8 +2034,8 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 			continue;
 
 		/*
-		 * this is the case when traversing through already created end sink
-		 * MST connectors, should be skipped
+		 * Leaf connectors set mst_root to the root connector.
+		 * The root connector itself has mst_root == NULL.
 		 */
 		if (aconnector->mst_root)
 			continue;
@@ -2009,6 +2046,12 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 			continue;
 
 		guard(mutex)(&aconnector->hpd_lock);
+
+		old_type = aconnector->dc_link->type;
+		old_sink = aconnector->dc_link->local_sink;
+		if (old_sink)
+			dc_sink_retain(old_sink);
+
 		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
 			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
@@ -2027,6 +2070,13 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		if (aconnector->fake_enable && aconnector->dc_link->local_sink)
 			aconnector->fake_enable = false;
 
+		if (dm_resume_connector_changed(connector, aconnector->dc_link,
+						old_type, old_sink))
+			connector_changes++;
+
+		if (old_sink)
+			dc_sink_release(old_sink);
+
 		if (aconnector->dc_sink)
 			dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
@@ -2070,7 +2120,11 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_dm_smu_write_watermarks_table(adev);
 
-	drm_kms_helper_hotplug_event(ddev);
+	if (connector_changes) {
+		drm_dbg_kms(ddev, "resume: hotplug, changes %u\n",
+			    connector_changes);
+		drm_kms_helper_hotplug_event(ddev);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 74a8735168aa..257599df4e60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1251,7 +1251,7 @@ void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_hpd_rx_irq_work_suspend);
 
-STATIC_IFN_KUNIT bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
+bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
 {
 	if (!sink1 || !sink2)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index bc16ecc67329..3c79b3f325e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -142,6 +142,7 @@ struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqueue(stru
 void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm);
 int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev);
 void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work);
+bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2);
 
 /* IRQ handlers */
 struct amdgpu_crtc *amdgpu_dm_get_crtc_by_otg_inst(struct amdgpu_device *adev,
@@ -156,7 +157,6 @@ struct amdgpu_iv_entry;
 enum amdgpu_interrupt_state;
 
 enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type);
-bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2);
 const char *dmub_notification_type_str(enum dmub_notification_type e);
 int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,

base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.43.0

