Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3ACC43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13A5E10EB10;
	Sat, 16 Jul 2022 14:36:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8875E10E275
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpsDSYO6woEqt3w6dUr3HQsSyKbnONtffbAPMgKNXKStS+9hT4r8i5pxrFSAtd1me1OjIgIyZgDjoWwomAyQcN+GJnhLMwsLM5nwRj1H6u5gYoZBpFPaZ1ly08hUsIb5KDPIxQJBGJFIaQqBV2V0+7mDlU/7gUP2QZ+XWRyyqKPR0LHU1M/Nlh6622H6GPisNSRaWS611AhKNdZZCN3wqcvUL01PFgsmKy+bOh5Q7ksiU03HOwA2/4m7DmuV5R/lF2J8GWyWowahV41+eCuBClFQUl+1YBc47525F2OgN9D2HCKtXPp3/E6UYDTIHXqVOmlQEYDzAivR5h8B0Tnlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l52ZiKuuCdXxTwENQ1zdk08IC+2RDwzIkrzMEI9bPe0=;
 b=OVhZmSSUIUoBXaOTOTvUtUJNlYdVAb4Z1qES4YlpcJkWhcZx0dOsyC4jIQSk4pCGbdRrcEHy+GH1wRwfm8bq0zxpynW8QBVSGZUcNui6o75UzSo3+gK6jX0gHc56HhfR/z21uCLfS+10sO+BE2MiEIgE3IpoAxlRfLZwHDbYcGK+uN1W73ICfZ47vVxFslJzdWXFkuwICkxGvtfCiK1nsj+eu3iz7L/61ry3XmOPZT+5dwrsOWD2BqFYvN5nePuzNZ+1i1zNO1EkMh2ybkX49gR88RYZ3uLqZ6GOml6ZDRY7vIVZ7kpRjqQlKiXkYaNGI3tHuE3wDYJLO+rdteRrSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l52ZiKuuCdXxTwENQ1zdk08IC+2RDwzIkrzMEI9bPe0=;
 b=EwUC1ydkrzz8OcQYdwLp9gkdD2Tw4CHy+962+rxaXt2F5a3Y+KY6QvW7c7Zvk0SW+gKuwUwOsQXqiIiM0YA91hLI8OkS6/hJgkKt44fQp46JACgm9+f0OmCKBoP3iYz9PCjYtMz+ZiA0NJR1V8MvrGsyNBnZ/tw7GTA0MXKo26s=
Received: from DS7PR03CA0147.namprd03.prod.outlook.com (2603:10b6:5:3b4::32)
 by BN6PR12MB1411.namprd12.prod.outlook.com (2603:10b6:404:1f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Fri, 15 Jul
 2022 18:17:36 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::b7) by DS7PR03CA0147.outlook.office365.com
 (2603:10b6:5:3b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:35 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 11:17:35 -0700
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:29 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/31] drm/amd/display: Add tags for indicating mst progress
 status
Date: Fri, 15 Jul 2022 14:16:41 -0400
Message-ID: <20220715181705.1030401-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d445e718-1451-41fa-af48-08da668e4b40
X-MS-TrafficTypeDiagnostic: BN6PR12MB1411:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwXB/fDPNEx57RISayaW9fdGMw4Pebn9CF9VWT0Kqd3ZxeOc/1lEpFSKceRkIYRsrILdtUCdTD/zQLU4B185Sy/cSMdt5Jrihkbfv2joO4dJhLW9cRGC9HnVZ3lWFHln8OA0b1RjkpoQJyScWN2c/tukxmEWz5kRMKnZax0G+O9c2hMIr8fE65slnNgQgJ3efXHTwKC+yPmdq61jya9VRcsep/3DRYZK/FwTrRtgFVX+GCoLMEju+3fxbdr3C2UZ2RSBCM/XayFOt38Ie3wnTaCGGSHCIpHeszV4WHvXXBNu2iqTSK4Gm7Hl5ShjsPLP0vZ7eNDX+Gsitr+8zwGv6QludahNhFaMPsVzFKKdYO95Nlka2rRVb7G2oDp1tOZt+mD8sPH5HtmXqzqLIrwPrCE5+ZsUhGZ0gk1/0tpRSsQuPSS3geBDqhOEajQhh52Vj9sjLVkvpJDWBBqxl+h7mdhpoxHqM5t5Jt8nD6ytPVhV5gAz5dhYAUPiRJ0iZ81n9Le2+x7vsZCHLM1zP3Ks1Q5MYGeRjwf84KapuNzFl2V6QE2jjqmwFmCkpjVUX6s+OEH+JwNDVIUm+YGNT4VsCY7dpzziyb94p1iW85sjYdx8+e0TTp8T7BnsAoh1ix5FtFSJCwdH8OrFfe9IMqYBIAO5+NIFOEzRburvzqlMZB06GmNlDY1ClMO+d8zpVs05HxOlucAmcKqZd9tTLlccMbr7zY9CsIe8RTbCGoJayBp9BmXbkrtW9qBC5u03zjztiA7hRQevflSIEl3wDy1zxjtX4JFmH+PLTYvBqg5kx4ks/h8dMBtr0x9kaWFO+3YbZN6rVjdKmRmCFBVB52RPBF4mU/wmm3k8iWyOBEaiz1w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(40480700001)(86362001)(426003)(478600001)(82740400003)(336012)(54906003)(4326008)(70586007)(8676002)(47076005)(70206006)(36756003)(36860700001)(186003)(356005)(83380400001)(1076003)(81166007)(41300700001)(2906002)(316002)(6666004)(40460700003)(26005)(6916009)(82310400005)(2616005)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:35.9328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d445e718-1451-41fa-af48-08da668e4b40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1411
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
In order to leverage igt tool to maintain mst feature, expose new
debugfs entry "mst_progress_status".

In our dm flow, record down the result of each phase of mst and user
can examine the mst result by checking whether each phase get completed
successfully.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 20 ++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 46 ++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 18 +++++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 13 ++++++
 4 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 33d66d4897dc..cdfd32c4128c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -571,6 +571,14 @@ struct dsc_preferred_settings {
 	bool dsc_force_disable_passthrough;
 };
 
+enum mst_progress_status {
+	MST_STATUS_DEFAULT = 0,
+	MST_PROBE = BIT(0),
+	MST_REMOTE_EDID = BIT(1),
+	MST_ALLOCATE_NEW_PAYLOAD = BIT(2),
+	MST_CLEAR_ALLOCATED_PAYLOAD = BIT(3),
+};
+
 struct amdgpu_dm_connector {
 
 	struct drm_connector base;
@@ -623,8 +631,20 @@ struct amdgpu_dm_connector {
 	struct drm_display_mode freesync_vid_base;
 
 	int psr_skip_count;
+
+	/* Record progress status of mst*/
+	uint8_t mst_status;
 };
 
+static inline void amdgpu_dm_set_mst_status(uint8_t *status,
+		uint8_t flags, bool set)
+{
+	if (set)
+		*status |= flags;
+	else
+		*status &= ~flags;
+}
+
 #define to_amdgpu_dm_connector(x) container_of(x, struct amdgpu_dm_connector, base)
 
 extern const struct amdgpu_ip_block_version dm_ip_block;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 991e58a3a78c..cd8db385eda0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -49,6 +49,13 @@ struct dmub_debugfs_trace_entry {
 	uint32_t param1;
 };
 
+static const char *const mst_progress_status[] = {
+	"probe",
+	"remote_edid",
+	"allocate_new_payload",
+	"clear_allocated_payload",
+};
+
 static inline const char *yesno(bool v)
 {
 	return v ? "yes" : "no";
@@ -2607,6 +2614,41 @@ static int dp_is_mst_connector_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
+/*
+ * function description: Read out the mst progress status
+ *
+ * This function helps to determine the mst progress status of
+ * a mst connector.
+ *
+ * Access it with the following command:
+ *
+ *	cat /sys/kernel/debug/dri/0/DP-X/mst_progress_status
+ *
+ */
+static int dp_mst_progress_status_show(struct seq_file *m, void *unused)
+{
+	struct drm_connector *connector = m->private;
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct amdgpu_device *adev = drm_to_adev(connector->dev);
+	int i;
+
+	mutex_lock(&aconnector->hpd_lock);
+	mutex_lock(&adev->dm.dc_lock);
+
+	if (aconnector->mst_status == MST_STATUS_DEFAULT) {
+		seq_puts(m, "disabled\n");
+	} else {
+		for (i = 0; i < sizeof(mst_progress_status)/sizeof(char *); i++)
+			seq_printf(m, "%s:%s\n",
+				mst_progress_status[i],
+				aconnector->mst_status & BIT(i) ? "done" : "not_done");
+	}
+
+	mutex_unlock(&adev->dm.dc_lock);
+	mutex_unlock(&aconnector->hpd_lock);
+
+	return 0;
+}
 
 DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
@@ -2619,6 +2661,7 @@ DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
 DEFINE_SHOW_ATTRIBUTE(internal_display);
 DEFINE_SHOW_ATTRIBUTE(psr_capability);
 DEFINE_SHOW_ATTRIBUTE(dp_is_mst_connector);
+DEFINE_SHOW_ATTRIBUTE(dp_mst_progress_status);
 
 static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
 	.owner = THIS_MODULE,
@@ -2762,7 +2805,8 @@ static const struct {
 		{"dp_dsc_fec_support", &dp_dsc_fec_support_fops},
 		{"max_bpc", &dp_max_bpc_debugfs_fops},
 		{"dsc_disable_passthrough", &dp_dsc_disable_passthrough_debugfs_fops},
-		{"is_mst_connector", &dp_is_mst_connector_fops}
+		{"is_mst_connector", &dp_is_mst_connector_fops},
+		{"mst_progress_status", &dp_mst_progress_status_fops}
 };
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 137645d40b72..d66e3cd64ebd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -312,6 +312,8 @@ bool dm_helpers_dp_mst_send_payload_allocation(
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_dp_mst_topology_mgr *mst_mgr;
 	struct drm_dp_mst_port *mst_port;
+	enum mst_progress_status set_flag = MST_ALLOCATE_NEW_PAYLOAD;
+	enum mst_progress_status clr_flag = MST_CLEAR_ALLOCATED_PAYLOAD;
 
 	aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
 
@@ -325,8 +327,20 @@ bool dm_helpers_dp_mst_send_payload_allocation(
 	if (!mst_mgr->mst_state)
 		return false;
 
-	/* It's OK for this to fail */
-	drm_dp_update_payload_part2(mst_mgr);
+	if (!enable) {
+		set_flag = MST_CLEAR_ALLOCATED_PAYLOAD;
+		clr_flag = MST_ALLOCATE_NEW_PAYLOAD;
+	}
+
+	if (drm_dp_update_payload_part2(mst_mgr)) {
+		amdgpu_dm_set_mst_status(&aconnector->mst_status,
+			set_flag, false);
+	} else {
+		amdgpu_dm_set_mst_status(&aconnector->mst_status,
+			set_flag, true);
+		amdgpu_dm_set_mst_status(&aconnector->mst_status,
+			clr_flag, false);
+	}
 
 	if (!enable)
 		drm_dp_mst_deallocate_vcpi(mst_mgr, mst_port);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 168d5676b657..c69c1086b35c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -179,6 +179,8 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 		aconnector->dc_sink = NULL;
 		aconnector->edid = NULL;
 	}
+
+	aconnector->mst_status = MST_STATUS_DEFAULT;
 	drm_modeset_unlock(&root->mst_mgr.base.lock);
 }
 
@@ -279,6 +281,9 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		edid = drm_dp_mst_get_edid(connector, &aconnector->mst_port->mst_mgr, aconnector->port);
 
 		if (!edid) {
+			amdgpu_dm_set_mst_status(&aconnector->mst_status,
+			MST_REMOTE_EDID, false);
+
 			drm_connector_update_edid_property(
 				&aconnector->base,
 				NULL);
@@ -309,6 +314,8 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		}
 
 		aconnector->edid = edid;
+		amdgpu_dm_set_mst_status(&aconnector->mst_status,
+			MST_REMOTE_EDID, true);
 	}
 
 	if (aconnector->dc_sink && aconnector->dc_sink->sink_signal == SIGNAL_TYPE_VIRTUAL) {
@@ -430,6 +437,10 @@ dm_dp_mst_detect(struct drm_connector *connector,
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
 		aconnector->edid = NULL;
+
+		amdgpu_dm_set_mst_status(&aconnector->mst_status,
+			MST_REMOTE_EDID | MST_ALLOCATE_NEW_PAYLOAD | MST_CLEAR_ALLOCATED_PAYLOAD,
+			false);
 	}
 
 	return connection_status;
@@ -526,6 +537,8 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	connector = &aconnector->base;
 	aconnector->port = port;
 	aconnector->mst_port = master;
+	amdgpu_dm_set_mst_status(&aconnector->mst_status,
+			MST_PROBE, true);
 
 	if (drm_connector_init(
 		dev,
-- 
2.37.0

