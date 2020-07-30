Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29F8C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D54206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sIpFMK1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D54206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B98B6E95E;
	Thu, 30 Jul 2020 19:12:41 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680045.outbound.protection.outlook.com [40.107.68.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544BC6E95E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfVINRnkliZzsTec06DkBIon3YDllif8mu5OoOvwskG++wi/LjPOtDkXDXiS2s9548qhwkBqqEyhj20eA6vBcAjT7uuGT5zAD+X26A1xX5mHIEiBDRgKllQ7xPdm+hpOjtxknzVkDt3+TAtH57ME7gepBCBY0oyKwjYJTmxI74d6PsusAMvrE2n18Gk+G3VPFjlMHFSS47Si+MDytsrFNX4wOTmbbOAyYcrhcdOElWrxh3s7nLzzUXBZE8BfhI23ffo2Axttpi1JVNKvBSv5CQeAkXBKpnAkdz55KHEfaaTB0g2KiRYmogIBveyhuSaM1gGhWaf/fU/FLXpEU/Z0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2Bzx+14ELs+RNDEmPhFSeHZhRQqkEHQs9rUOa1dHo8=;
 b=esVG7/Yvr3A0A1O3b8U8sUQue7UtNuwMgz4zGJhQ/eXuJH2JGtVb4nriGJ4qkVWWI0Vceg4DrvXpW18to9lWYsYA/ozWIqZ3O9Yj6P8B38vCHxr7uFp0dQ6LCJ3eAnOANcT+7vWI5j79zASvpgfg/gjk3e25WTmA0NL23FevCJixxATBPWSBojr0hCKzqF9L5dwF/9FJIX6sC5r4MGxD9nrAweIptbrLf141jlKqG3Tn4dMsiyzu4sUSqr0WFuurrOG/Y0Z8OTHS616jd7+wOINfgVzYGRNBh/Y7xYV9Q1BO9DAb7fL3DvC7u8Ja0VT0LdoFvOykCV+Gc6plfzpxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2Bzx+14ELs+RNDEmPhFSeHZhRQqkEHQs9rUOa1dHo8=;
 b=sIpFMK1Dp0OQclbhSMwJTVIE5urG/n4Ur50OTtA6VJZrd08hiDxlAc3jfMwlmA13RUFtD6vu7g5UPo7JK85h9iuq/0hgtxkTRdDXU0J/6VXQ/POIUFuhKPieZaSSbnS0PW8uUaMZ6Ak5Yzx/gnxQvzK7HfQiXHD8wtyvGzgWG+k=
Received: from BN6PR22CA0028.namprd22.prod.outlook.com (2603:10b6:404:37::14)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Thu, 30 Jul
 2020 19:12:35 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::cc) by BN6PR22CA0028.outlook.office365.com
 (2603:10b6:404:37::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.20 via Frontend Transport; Thu, 30 Jul 2020 19:12:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:35 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:34 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:34 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: Add debugfs for forcing stream timing
 sync
Date: Thu, 30 Jul 2020 15:11:43 -0400
Message-ID: <20200730191146.33112-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caf69dd8-5fe7-4b06-0950-08d834bc8486
X-MS-TrafficTypeDiagnostic: MW3PR12MB4395:
X-Microsoft-Antispam-PRVS: <MW3PR12MB43956F9CCBEBF56DB5FC48FA8B710@MW3PR12MB4395.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pfCrKgDG9CPvCauOSLdujABlTzfgz6sV8/z+AGjeoIKa3m1vjJ+whkHKKQ/N7rqWn1JKtBkcgUHykR8/Kz8DStgU6lzW8K9rsbydHfXeU+9KVMjiyJAPU2CrmTe9pqH2I5XwxfP3a6eAbAEtGOH//8MWivpg7lj38rLln4glH/ox9uFFQmeBt4tib6zhoXV12QfMR4kKNCm49ftJX4S45KOeh7ZV8KiTeyMJNnMqX2MwEyMM4o2vK6lMWuko+d0JQmbKa9SfkrXo/rWIWbANuKs6KHdYNrKLZNmoT6Xu0Dlp6aWk09z+Jr0AY7XjEJ0N52kbW0z8mz6g22yQ+h5hahPSO8y6fbJAAcZiftgrdpZZv5ktaurxU6NJHa1vQdGg+DrP2lZm2jGht79QO9qgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(26005)(54906003)(4326008)(336012)(83380400001)(36756003)(8936002)(6916009)(5660300002)(478600001)(1076003)(86362001)(2616005)(356005)(7696005)(316002)(82310400002)(426003)(2906002)(44832011)(8676002)(6666004)(81166007)(82740400003)(186003)(70206006)(47076004)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:35.4378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf69dd8-5fe7-4b06-0950-08d834bc8486
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Lu <victorchengchi.lu@amd.com>

[why]
There's currently no method to enable multi-stream synchronization from
userspace and we don't check the VSDB bits to know whether or not
specific displays should have the feature enable.

[how]
Add a debugfs entry that controls a new DM debug option,
"force_timing_sync". This debug option will set on any newly created
stream following the change to the debug option.
Expose a new interface from DC that performs the timing sync and a helper
to the "force_timing_sync" debugfs that iterates over the current streams
and modifies the current synchornization state and grouping.

Example usage to force a resync (from an X based desktop):

echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_force_timing_sync
xset dpms force off && xset dpms force on

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 35 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 ++++---
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 ++
 5 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a64c2d5789df..0e1921a8f08c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8130,6 +8130,13 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			goto fail;
 		}
 
+		/*
+		 * TODO: Check VSDB bits to decide whether this should
+		 * be enabled or not.
+		 */
+		new_stream->triggered_crtc_reset.enabled =
+			dm->force_timing_sync;
+
 		dm_new_crtc_state->abm_level = dm_new_conn_state->abm_level;
 
 		ret = fill_hdr_info_packet(drm_new_conn_state,
@@ -9268,3 +9275,22 @@ static bool amdgpu_dm_psr_disable(struct dc_stream_state *stream)
 
 	return dc_link_set_psr_allow_active(stream->link, false, true);
 }
+
+void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
+{
+	struct amdgpu_device *adev = dev->dev_private;
+	struct dc *dc = adev->dm.dc;
+	int i;
+
+	mutex_lock(&adev->dm.dc_lock);
+	if (dc->current_state) {
+		for (i = 0; i < dc->current_state->stream_count; ++i)
+			dc->current_state->streams[i]
+				->triggered_crtc_reset.enabled =
+				adev->dm.force_timing_sync;
+
+		dm_enable_per_frame_crtc_master_sync(dc->current_state);
+		dc_trigger_sync(dc, dc->current_state);
+	}
+	mutex_unlock(&adev->dm.dc_lock);
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3114f6e938e3..16455898972e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -340,6 +340,7 @@ struct amdgpu_display_manager {
 	 * fake encoders used for DP MST.
 	 */
 	struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
+        bool force_timing_sync;
 };
 
 struct dsc_preferred_settings {
@@ -494,6 +495,8 @@ void dm_restore_drm_connector_state(struct drm_device *dev,
 void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 					struct edid *edid);
 
+void amdgpu_dm_trigger_timing_sync(struct drm_device *dev);
+
 #define MAX_COLOR_LUT_ENTRIES 4096
 /* Legacy gamm LUT users such as X doesn't like large LUT sizes */
 #define MAX_COLOR_LEGACY_LUT_ENTRIES 256
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 4f6393332c7a..84360f3a0162 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2203,6 +2203,38 @@ static const struct drm_info_list amdgpu_dm_debugfs_list[] = {
 	{"amdgpu_mst_topology", &mst_topo},
 };
 
+/*
+ * Sets the force_timing_sync debug optino from the given string.
+ * All connected displays will be force synchronized immediately.
+ * Usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_force_timing_sync
+ */
+static int force_timing_sync_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	adev->dm.force_timing_sync = (bool)val;
+
+	amdgpu_dm_trigger_timing_sync(adev->ddev);
+
+	return 0;
+}
+
+/*
+ * Gets the force_timing_sync debug option value into the given buffer.
+ * Usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_force_timing_sync
+ */
+static int force_timing_sync_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	*val = adev->dm.force_timing_sync;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(force_timing_sync_ops, force_timing_sync_get,
+			 force_timing_sync_set, "%llu\n");
+
 /*
  * Sets the DC visual confirm debug option from the given string.
  * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_visual_confirm
@@ -2262,5 +2294,8 @@ int dtn_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_file_unsafe("amdgpu_dm_dmub_fw_state", 0644, root,
 				   adev, &dmub_fw_state_fops);
 
+	debugfs_create_file_unsafe("amdgpu_dm_force_timing_sync", 0644, root,
+				   adev, &force_timing_sync_ops);
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 92eb1ca1634f..5aa3b89471c3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1238,6 +1238,14 @@ bool dc_enable_stereo(
 	return ret;
 }
 
+void dc_trigger_sync(struct dc *dc, struct dc_state *context)
+{
+	if (context->stream_count > 1 && !dc->debug.disable_timing_sync) {
+		enable_timing_multisync(dc, context);
+		program_timing_sync(dc, context);
+	}
+}
+
 /*
  * Applies given context to HW and copy it into current context.
  * It's up to the user to release the src context afterwards.
@@ -1297,10 +1305,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	if (result != DC_OK)
 		return result;
 
-	if (context->stream_count > 1 && !dc->debug.disable_timing_sync) {
-		enable_timing_multisync(dc, context);
-		program_timing_sync(dc, context);
-	}
+	dc_trigger_sync(dc, context);
 
 	/* Program all planes within new context*/
 	if (dc->hwss.program_front_end_for_ctx) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 633442bc7ef2..37743073772b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -397,6 +397,8 @@ bool dc_enable_stereo(
 	struct dc_stream_state *streams[],
 	uint8_t stream_count);
 
+/* Triggers multi-stream synchronization. */
+void dc_trigger_sync(struct dc *dc, struct dc_state *context);
 
 enum surface_update_type dc_check_update_surfaces_for_stream(
 		struct dc *dc,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
