Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D931CD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1957010E883;
	Wed, 10 Jun 2026 09:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RKF9MqtD";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7737C10E883
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNnvrlIZ4vFlS9W2o2nn7XQ9BIJUhvlK4DPuzZvEiEwKMPSo8swQMhnRRKEhW34BEHZbD3+wnZ8UfWPcxRGMjwLe92H8HgSSqG1JwUUuSNAcvyZYYwYEgtWEZFWqkzCBlZnt8r0cD7qrp72mIHfzsESZhJpz5RGi/zW889l3QziOdccNWnZubaZ+Y3AvLbwX5XCL28vvK5XelcBmyYSBDGz07897+NFwOBa5FR57mluy8vW1k6Z1FxJ8mhWGdGpZ2isMNz4iRKU7WkRTjqyTZaQUKHjydKafbYxMc/cbcbpxMqmKis8SlQ6JkGW4SfR3ZeV+QJCYGElmFgJsqbnQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMRdGnfJQ0IkqoH5FXVp6DhTQEH9biyq2d2bUoVmxaI=;
 b=hLnE+DinuNNRd5BcepuR7mZyeK1YSX8407arGsjzt8rGiotC/EwFMFsszKW1t5RwxE9sdNdD4brBN6GqFG48UoWXjjf2oymjdoPQ429E5jdecMf4zbBMbettLQJEi2nx5RXMp7YBOmjxIax6d+QWAamph1BYyq3RI+iPGGlqrkQ3ycnmkhMCfZSMk4pfLRyRnzru9cnyREHgW3vY6n+DMgw2qpJ0Ms/xoiuv2cZSj7mwVm/fkJ/Tez4rImRwaPUCoo/f+bRF71pvn9goWZH5rSKRiXWKn+ifbzpmadMBctf2SaheFV6OVnbprzE7go6uUKaMpEfvoj3blYgWe6UW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMRdGnfJQ0IkqoH5FXVp6DhTQEH9biyq2d2bUoVmxaI=;
 b=RKF9MqtDSwt5GVzBRc2rFhtJauAggUCZlrM3JwcaZY9dOEPKBxlTX2pa8dpyHrrKEzOcd7tnaroe8S+JSegGzhP4v5/w7Xj3aIDMmsnHw7YMcTz+whDfZhmhE4qEyQiXNhplIrGBZGEObzyKtwa0Z1KUSzWyxpR1MEwPsQO/PSw=
Received: from SA9PR13CA0055.namprd13.prod.outlook.com (2603:10b6:806:22::30)
 by LV2PR12MB999097.namprd12.prod.outlook.com (2603:10b6:408:353::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 09:50:31 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::c) by SA9PR13CA0055.outlook.office365.com
 (2603:10b6:806:22::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7 via Frontend Transport; Wed, 10
 Jun 2026 09:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:50:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:50:27 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:50:14 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 16/32] drm/amd/display: Add Support for HDMI Compliance
 Automation
Date: Wed, 10 Jun 2026 17:45:00 +0800
Message-ID: <20260610094639.1965367-17-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|LV2PR12MB999097:EE_
X-MS-Office365-Filtering-Correlation-Id: 95575263-3805-4c40-df95-08dec6d5b597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: l1aOItmthU5jFqXg0sL+ka2EUigTbVksDbsj6uNYlv8XnIqYZEzoMuZ+Z8Pxb3t3lx8M1cUcu+EWiizqQA/TgyRYeWR0UyACOKKULjhnaKFnV7KRYsJH08OUzJyBIksqVBua/ROM5UCekO30yDlqF6Y4fCwv9eMOqhpw3fEsg/0ij8FKQFO0SR+Wp1DQdRBh+ZJpeWy0RW+yk9xZieQgQSg13+jxnsHdGFbMnYehb8xLDwy4i/+Cgnnfrqt/qjsFs3T8rOOuUQb/HjEMu7fjxLwn+xuy66tnpJtTy6pUDOKRwMCEhtxEEFCZIiwmYJxMVbL4nxnDlOpbp3c0TN8nAxVBweWopD1KKw6z4Mj0ZDZxiWbyx0cExAseGuXxwctxTlV5TLgVj49CYVmB/wBlAOxeCuPfFswdJ2RcfT61yUAq0j4nKe4pnJ3PxSV/leX0Dd1LTQ3Rypio3Hn0QOxLho+m+rNvVCPUiKseGKc8y7ow/d4SSHtWtDqBPcZTOPLTSZ7QYH01hVHMlRlXxLZqzinXpRMhlaLahazTYgfOrjAWDhLZgL77aA5JM0E+gSkKEa5+JrEgrxyEw556KgLtJpCgwjQN2SPGGBvlhYL+kOQEtqV8j/qVXmNkhO9CCnjktzZR2huZnwUSRasOSrj/6U7mUGpIQvClwk7XVRi4C2x6UdzhfT2m/jBsb1pPJynQEsqmt8xAgNI3gfts1bmNd6eq+ZpgnGCIBg95aF79kCg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aJ3dn8eN/hcNPjARmpbdU6pqMeeFSntBrwvBzyw8hM23SZV9O5Lqwr1VCw5NtOLvZCBpiC6k43mwaCDHSEUQXFXeGC2vYmPVk+zBbdVC+kgQDCHcVFFK1yuRCKyWd6+fwz3+cUHsKcfXsJWIjZSntk4hFxjLJgHP5adM4BE3GNoYwFrClG7gs/Y1Fzg5OTK2VlJmGjLfkcvZdIxemhvRaFAtF7PP+AtVRT7A3YdnGzX+YZ4YTW9/HVDdBSoQ82Jz4m40F264Hvr9mj3kGudBdUwv8/hFoyutDdIVMBkM+6ZuGi4EISnTEyo7WliMyNw7AhnRlAbfyR/ltD5Cik/mb1SxD8c/cUGrVGdOguAUnuTXO1LHwbf0YGvvwT4zPtwIINplq8MZaeNaqs+d/Ip7Jz1hzdz4zNEFfrhJqzjRAWyELBpk+SUqzgsEQgN6kzDR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:50:30.9786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95575263-3805-4c40-df95-08dec6d5b597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999097
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Add support to get DUT trained at FRL link rate when working with
Teledyne M41h compliance automation.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  5 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 67 ++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  6 ++
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 2940dd5b7348..ba1e11e144f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -877,6 +877,9 @@ struct amdgpu_dm_connector {
 	unsigned int hdmi_hpd_debounce_delay_ms;
 	struct delayed_work hdmi_hpd_debounce_work;
 	struct dc_sink *hdmi_prev_sink;
+
+	/* HDMI compliance automation */
+	bool hdmi_comp_auto;
 };
 
 static inline void amdgpu_dm_set_mst_status(uint8_t *status,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 6ef257622f1a..59091ee32099 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -573,6 +573,11 @@ void amdgpu_dm_update_connector_after_detect(
 		amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid, true);
 		amdgpu_dm_update_connector_ext_caps(aconnector);
 		dm_set_panel_type(aconnector);
+
+		if (aconnector->hdmi_comp_auto) {
+			if (sink->sink_signal != SIGNAL_TYPE_HDMI_FRL)
+				sink->sink_signal = SIGNAL_TYPE_HDMI_FRL;
+		}
 	} else {
 		hdmi_cec_unset_edid(aconnector);
 		drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 096a855a7304..95a56e39f452 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2982,6 +2982,64 @@ static ssize_t hdmi_cec_state_write(struct file *f, const char __user *buf,
 	return size;
 }
 
+/**
+ * hdmi_automation_enable - Enable/Disable HDMI automation feature
+ * @f: file structure.
+ * @buf: userspace buffer. set to '1' to enable; '0' to disable automation feature.
+ * @size: size of buffer from userpsace.
+ * @pos: unused.
+ *
+ * Return size on success, error code on failure
+ */
+static ssize_t hdmi_automation_enable(struct file *f, const char __user *buf,
+	size_t size, loff_t *pos)
+{
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	char *wr_buf = NULL;
+	const uint32_t wr_buf_size = 40;
+	int max_param_num = 1;
+	uint8_t param_nums = 0;
+	long param[2];
+	bool hdmi_comp_auto;
+
+	if (size == 0)
+		return -EINVAL;
+
+	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
+	if (!wr_buf)
+		return -ENOSPC;
+
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+					   (long *)param, buf,
+					   max_param_num,
+					   &param_nums)) {
+		kfree(wr_buf);
+		return -EINVAL;
+	}
+
+	if (param_nums <= 0) {
+		kfree(wr_buf);
+		DRM_DEBUG_DRIVER("user data not be read\n");
+		return -EINVAL;
+	}
+
+	switch (param[0]) {
+	case 0:
+		hdmi_comp_auto = false;
+		break;
+	case 1:
+	default:
+		hdmi_comp_auto = true;
+		break;
+	}
+
+	/* Persist setting across sink re-detection/hotplug. */
+	aconnector->hdmi_comp_auto = hdmi_comp_auto;
+
+	kfree(wr_buf);
+	return size;
+}
+
 DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
@@ -3099,6 +3157,12 @@ static const struct file_operations dp_mst_link_settings_debugfs_fops = {
 	.llseek = default_llseek
 };
 
+static const struct file_operations hdmi_automation_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.write = hdmi_automation_enable,
+	.llseek = default_llseek
+};
+
 static const struct {
 	char *name;
 	const struct file_operations *fops;
@@ -3131,7 +3195,8 @@ static const struct {
 	const struct file_operations *fops;
 } hdmi_debugfs_entries[] = {
 		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
-		{"hdmi_cec_state", &hdmi_cec_state_fops}
+		{"hdmi_cec_state", &hdmi_cec_state_fops},
+		{"hdmi_automation", &hdmi_automation_debugfs_fops}
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index a2d0bb34e639..6350212b9a66 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -193,6 +193,12 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 					__func__, connector->name, edid_caps->frl_dsc_10bpc, edid_caps->frl_dsc_12bpc, \
 					edid_caps->frl_dsc_all_bpp, edid_caps->frl_dsc_native_420, edid_caps->frl_dsc_max_slices, \
 					edid_caps->frl_dsc_max_frl_rate, edid_caps->frl_dsc_total_chunk_kbytes);
+		if (aconnector->hdmi_comp_auto) {
+			edid_caps->panel_patch.hdmi_comp_auto = true;
+			link->ctx->dc->debug.force_frl_max = true;
+			link->ctx->dc->debug.force_frl_dsc = true;
+			drm_dbg_driver(connector->dev, "%s: HDMI_FRL [%s] hdmi_comp_auto --> enabled\n", __func__, connector->name);
+		}
 	}
 
 	apply_edid_quirks(link, edid_buf, edid_caps);
-- 
2.43.0

