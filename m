Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE88EB64DB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BDA710E163;
	Wed, 14 Jun 2023 17:58:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673D210E161
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBXO4GbwYkkSZb/dqMsjlOm3nXcD4je/WnRYbp0uOC+Ui8Z+puC6ug6WRuHDLp6nySIGIDZfsHxsaiXCQKLrCiIN+b3aWiZTG5yl5WmPoSTz4aX4zR5rX7py1cxcKRr7B9vYhyDMb/RwoKkZvROb4qfd1YMMLPj0xzwAzVH19PMp/Ok8TAqO8I3rHVbrirCkXdmJfEBvxv0RbwDWEvjfD4yfEUpqvKFa2hq78LV73YDsHCfxcPlKe2Xt9nqXvz+jCrIBiGW3toDjqa+d+16WAGb4QK1Vx53r9EgiBgCKKkjRHjp4nO9roTopBRYwYfBvHr8ykOfP3HWYFoKkCSb/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t/MXnuDkAriKvKkmJhWfHt5n02MuQ+tlctQWi3Iw74=;
 b=EZdAymA67mFrFP1KkZnA89ErEZa8dxKzb+eC+S7y1k2rT1trC2p0vq0t4jLnwg8Jjmb8vcJ2UmGGm8SZEoc7PmXTHFdmOq73VR6DpYcIM6Rj9+PFKnohCzeVs4o/0/bDSEs5cF8nBO1zhgj6s0mF7ueoWTEGHF8kLIXGp+IRS8WwWkt5CmBB9PjiCr+kWyV3x8HJP7D3cuEahnWcVyO6Rej41v4apbwoi7/31T1iy2T/u700uhJeU09w3PXmjbdMNCcKHk/9btsi0GiNMzK7J7S5+aK95HiS8jK6XOgB3vMwliZeMRQ+Y9zirMLWmfh4d+VrFQ/MAhLCQ8bce9qtNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t/MXnuDkAriKvKkmJhWfHt5n02MuQ+tlctQWi3Iw74=;
 b=u/U6nNvCLp2ID0dDYj1PzvfuhHdRmIUUW5SZrhhjG9K2yFo/fImJxDI3J2+gZevtol06g+3Yw8X6mOq3TQJtQBKq4tMLCeuB3N99LgHBiJk/adJZtyiL1G/+NNuZyoKHY6qDYKN0RAbQAbPsjJGlXYOectteN18XGxjcTej0jZo=
Received: from MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 17:58:32 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::3b) by MW3PR06CA0030.outlook.office365.com
 (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:32 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:30 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/17] drm/amd/display: Add MST Preferred Link Setting Entry
Date: Wed, 14 Jun 2023 13:57:46 -0400
Message-ID: <20230614175750.43359-14-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|DM6PR12MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: e546bb73-6c7d-4eb3-8c1a-08db6d00f7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmYQyzpcl6X+Ro4gczv1fTH5YncIiHgI0CwY1xpVHQGqp0P89Ij9q7vA+ql0C5cP8+WKOWsyH2CBRvFDDc9Gd7PvGl0gCvDzBvmUni5IYCVY39xsquMX98rzzHlBH6aRhSbTaqB9nEwNbaNMOZgtvcGUwdw93wyq6sgaOQ+usDsHnPwb3xgyV/0IKUgVgii0qTWpglJcjqTiCWotaVcoHPr37xtNGlmzfJbEwsTIY+NalFQK7yrU3e3yXSC//16J9DBC7XaYX6eDO6QOnqjyvKQkZaXg90TvaXGdb+2yaGTE46tP+o/8vCUQkAdjtJliDXvmPxcUXNvfcg4ydz+mqcSa9xIiqbLQGiAm8noX5ifKjUSW3Jfcf0gJtF1IDmUxcbZtI83Rmp5+5ARVidND9NSh6qH3aEc69eY1c8sxMFAHbG1iEEIk39mbCxt1nd++AUJrpZwBtgBq4dJL2OYxDDnIbg0WM7uYnzrDer4oCjGbaD9gpIzw3/IbsEjyJxBbnqrWQyoRLf8jMdNpvZp738bXiHe/FKG22IsStyiZ7lPoY/beJx7EsqDewA7PwO2OO9k4tVWO024jBo8zK+87LRt/9ZghcBHyLBVTk3sjC0sEFTOswZkZApX5OJlaTAXqMPRUMCTRHO2h78Mb+ZJOdRQ0MV54LakMVSDMIF1Ve9HU2TCAhiQuLiXr5iDUNOt5uhRBlEpF6wTFl11Ryp6SHLZn+j2rwdeycx3HZd78QfoXRL03Lj6yCBgTRat+Qepqh76JdMo8QAZ6+18PPbWOkTOvuSyksDHigE7fa68m93I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(8936002)(26005)(40460700003)(8676002)(41300700001)(36860700001)(81166007)(478600001)(82740400003)(36756003)(82310400005)(356005)(70586007)(70206006)(6916009)(4326008)(86362001)(1076003)(316002)(54906003)(6666004)(40480700001)(44832011)(5660300002)(83380400001)(426003)(336012)(186003)(2616005)(16526019)(47076005)(2906002)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:32.3875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e546bb73-6c7d-4eb3-8c1a-08db6d00f7a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005
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
 solomon.chiu@amd.com, Fangzhi Zuo <jerry.zuo@amd.com>,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <jerry.zuo@amd.com>

When using debugfs to change MST link settings, we need to wait until
the next stream update to apply the preferred link setting. So, trigger
a hotplug event right after the preferred link setting is applied.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 156 +++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 5ea3284b2b77..d63ee636483b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -336,6 +336,153 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	return size;
 }
 
+static bool dp_mst_is_end_device(struct amdgpu_dm_connector *aconnector)
+{
+	bool is_end_device = false;
+	struct drm_dp_mst_topology_mgr *mgr = NULL;
+	struct drm_dp_mst_port *port = NULL;
+
+	if (aconnector->mst_root && aconnector->mst_root->mst_mgr.mst_state) {
+		mgr = &aconnector->mst_root->mst_mgr;
+		port = aconnector->mst_output_port;
+
+		drm_modeset_lock(&mgr->base.lock, NULL);
+		if (port->pdt == DP_PEER_DEVICE_SST_SINK ||
+			port->pdt == DP_PEER_DEVICE_DP_LEGACY_CONV)
+			is_end_device = true;
+		drm_modeset_unlock(&mgr->base.lock);
+	}
+
+	return is_end_device;
+}
+
+/* Change MST link setting
+ *
+ * valid lane count value: 1, 2, 4
+ * valid link rate value:
+ * 06h = 1.62Gbps per lane
+ * 0Ah = 2.7Gbps per lane
+ * 0Ch = 3.24Gbps per lane
+ * 14h = 5.4Gbps per lane
+ * 1Eh = 8.1Gbps per lane
+ * 3E8h = 10.0Gbps per lane
+ * 546h = 13.5Gbps per lane
+ * 7D0h = 20.0Gbps per lane
+ *
+ * debugfs is located at /sys/kernel/debug/dri/0/DP-x/mst_link_settings
+ *
+ * for example, to force to  2 lane, 10.0GHz,
+ * echo 2 0x3e8 > /sys/kernel/debug/dri/0/DP-x/mst_link_settings
+ *
+ * Valid input will trigger hotplug event to get new link setting applied
+ * Invalid input will trigger training setting reset
+ *
+ * The usage can be referred to link_settings entry
+ *
+ */
+static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
+				 size_t size, loff_t *pos)
+{
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct dc_link *link = aconnector->dc_link;
+	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
+	struct dc *dc = (struct dc *)link->dc;
+	struct dc_link_settings prefer_link_settings;
+	char *wr_buf = NULL;
+	const uint32_t wr_buf_size = 40;
+	/* 0: lane_count; 1: link_rate */
+	int max_param_num = 2;
+	uint8_t param_nums = 0;
+	long param[2];
+	bool valid_input = true;
+
+	if (!dp_mst_is_end_device(aconnector))
+		return -EINVAL;
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
+	case LANE_COUNT_ONE:
+	case LANE_COUNT_TWO:
+	case LANE_COUNT_FOUR:
+		break;
+	default:
+		valid_input = false;
+		break;
+	}
+
+	switch (param[1]) {
+	case LINK_RATE_LOW:
+	case LINK_RATE_HIGH:
+	case LINK_RATE_RBR2:
+	case LINK_RATE_HIGH2:
+	case LINK_RATE_HIGH3:
+	case LINK_RATE_UHBR10:
+	case LINK_RATE_UHBR13_5:
+	case LINK_RATE_UHBR20:
+		break;
+	default:
+		valid_input = false;
+		break;
+	}
+
+	if (!valid_input) {
+		kfree(wr_buf);
+		DRM_DEBUG_DRIVER("Invalid Input value No HW will be programmed\n");
+		mutex_lock(&adev->dm.dc_lock);
+		dc_link_set_preferred_training_settings(dc, NULL, NULL, link, false);
+		mutex_unlock(&adev->dm.dc_lock);
+		return -EINVAL;
+	}
+
+	/* save user force lane_count, link_rate to preferred settings
+	 * spread spectrum will not be changed
+	 */
+	prefer_link_settings.link_spread = link->cur_link_settings.link_spread;
+	prefer_link_settings.use_link_rate_set = false;
+	prefer_link_settings.lane_count = param[0];
+	prefer_link_settings.link_rate = param[1];
+
+	/* skip immediate retrain, and train to new link setting after hotplug event triggered */
+	mutex_lock(&adev->dm.dc_lock);
+	dc_link_set_preferred_training_settings(dc, &prefer_link_settings, NULL, link, true);
+	mutex_unlock(&adev->dm.dc_lock);
+
+	mutex_lock(&aconnector->base.dev->mode_config.mutex);
+	aconnector->base.force = DRM_FORCE_OFF;
+	mutex_unlock(&aconnector->base.dev->mode_config.mutex);
+	drm_kms_helper_hotplug_event(aconnector->base.dev);
+
+	msleep(100);
+
+	mutex_lock(&aconnector->base.dev->mode_config.mutex);
+	aconnector->base.force = DRM_FORCE_UNSPECIFIED;
+	mutex_unlock(&aconnector->base.dev->mode_config.mutex);
+	drm_kms_helper_hotplug_event(aconnector->base.dev);
+
+	kfree(wr_buf);
+	return size;
+}
+
 /* function: get current DP PHY settings: voltage swing, pre-emphasis,
  * post-cursor2 (defined by VESA DP specification)
  *
@@ -2668,6 +2815,12 @@ static const struct file_operations dp_dsc_disable_passthrough_debugfs_fops = {
 	.llseek = default_llseek
 };
 
+static const struct file_operations dp_mst_link_settings_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.write = dp_mst_link_setting,
+	.llseek = default_llseek
+};
+
 static const struct {
 	char *name;
 	const struct file_operations *fops;
@@ -2691,7 +2844,8 @@ static const struct {
 		{"dsc_disable_passthrough", &dp_dsc_disable_passthrough_debugfs_fops},
 		{"is_mst_connector", &dp_is_mst_connector_fops},
 		{"mst_progress_status", &dp_mst_progress_status_fops},
-		{"is_dpia_link", &is_dpia_link_fops}
+		{"is_dpia_link", &is_dpia_link_fops},
+		{"mst_link_settings", &dp_mst_link_settings_debugfs_fops}
 };
 
 static const struct {
-- 
2.40.1

