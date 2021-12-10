Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00498C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6762210E3FB;
	Fri, 10 Dec 2021 23:05:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145A510E423
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwlhUBsRezmEmeyeC0r9/VS7abLPsk/IpNP3p88VXHbfyU5Qm3FTDkgjttcAq2gp4zvPelW84hEqmErSZiW+LpdL0PHVdd6iH1fUsKF4st/X7fe/o1G0vSkG67YbCmPpjqLp1++uMo8kHddk3w2VftPu1nurQE36XOsvFGPV88eriy18xRN3v75gcA5oRNf2dMsyOGHcbF9NwitkoyD3ZFBawBepDAUcsi9Z69CfdAZ/sI3OXRk5MJvYxIJa4Zw1F8FE4VLdhdCGoPIDCHgJJNgTG56dg0OLwpJwYtyz7sOfPVht9LBB+U35xNR8neNTCA0aoC3JVfhhQvBTCVL8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6g9rAr2VVltW6imG935SRy6kqJbIWf9iir9Pek1yDk=;
 b=NNhUxeNe7M8z0kAFfhnCUj78TQCecQlR7OcoDcIvKCIAVGPDO8j/5eYr3EZgeMTp8Vw9zPIJSnoKatS6ai5tz4H5vdiHaCm6FipKIFhVH/ebQQ/A088Atyqb3AtCm6k+xAuYGrCopC5HdOlVbw2NnhXhYREvb8RC/06Ryo2f1iMeSOqpb/wLr+7XOeZFJu3l390ccDlXJHM6JJm2xl808/7WyLJn78MhZVcDOJxV1Vn7yIDudYKxiubMxXQxcMpymPflHWHAvqo+37fZ2luXEn3pi73CWP6TKoAL5Qe0gJ9H9CRL28xEWi1QnONFMB5kB84fGNk80gEUB1d9nu3xpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6g9rAr2VVltW6imG935SRy6kqJbIWf9iir9Pek1yDk=;
 b=Mqk/8JxxCEntai9ougfw84dWOVjB9tgxqTTd0DgSTdhhYN++72oQoCYCxRY8E1xUx7DTKGJdNjIrJiMlMQ/XXEoh5UjiwkXMSI8uyFDeKlhcgBd8VXsmWvOtesqr/pOBywTc//ke4oFMJwRqsVyTBDD++Qb5aU/8vbl11wN75j4=
Received: from DS7PR05CA0014.namprd05.prod.outlook.com (2603:10b6:5:3b9::19)
 by MWHPR12MB1901.namprd12.prod.outlook.com (2603:10b6:300:113::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 23:05:13 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::fe) by DS7PR05CA0014.outlook.office365.com
 (2603:10b6:5:3b9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.8 via Frontend
 Transport; Fri, 10 Dec 2021 23:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 23:05:12 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 17:05:11 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/10] drm/amd/display: Add debugfs entry for ILR
Date: Fri, 10 Dec 2021 15:04:00 -0800
Message-ID: <20211210230408.619373-3-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
References: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f202f51-98fe-420d-a771-08d9bc31858b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1901:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB19016DA0535B73BECA0E9D81FC719@MWHPR12MB1901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TI7ZO9UCH7vllbdBbZGB4vTOZpYmevSKH9hWASCDL3XxFFw/6A7JUcBI5/nIEnRcqPGICBpnC7t0+RSrO4JttOWD5Enfr1SDOzBm/8sFmqLw1mqAy/ZTBD66JwqyBmcccoyiOQ1cWF+1SIRB6vcRswSEMK0EVtw6ECTWUc9Hm72lfAOrQQN9ZKvLf9csqu7kamFPq1g8nIoFDOVfg+U22p2VyE/LlBYF8T/sL26iFgOTHxZlJ/Pnp+XWiMordc4xBiw+PWbYDeJZ4dM1UjFBBDGBPC8rUAUxTu71NOH0z6a/H5QZxPE+Wq6QUJ7sQwnDbUBn9FSxy7v/MgzGeI4M+CEmFhsdD5tU60wPfZ0JChpia38GlXQCMfMymFB586yAdb6NfJJtqVQHU0UfxwatxyxXP6QuHTA1QHv3H6Inzk/vjkrfanzpudBay++P5bUgsOofr4elc9flE9yV+KaW2JALGp15YFXxgnjt9UT/oifDpgIsKeFqoulTbu3wKHZjhjs0gn6BzzKYmt69HIa2QUCnYjwbUZ+tKY3BENIKX2SYn2IdzMc6MRQz6Gv6JPNx7BxdPP7wheBsaIb4zEKr4E7Ps5Rq2TzSmpJ6tq0XEG7dmE3oJzBKyPksAVceFpgAyyWoJ/f4RqBRRen072PuDpj+uIx/uezAfLSEddtrTnNMP9i9tSlkZQZAhDRmOVCoy6uGaQ+GjaWCIARXlqgyDagSr7hr2bmWJ4HRpzl0jr6FeLbl0ryMEkaxj2ccw5WcI9kf0OpiX+lfk9MbXQsAatOHSLbL8fLVaUBZPYNKalo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(316002)(16526019)(508600001)(356005)(4326008)(6916009)(8936002)(83380400001)(1076003)(6666004)(86362001)(7696005)(26005)(2906002)(54906003)(5660300002)(81166007)(70206006)(47076005)(2616005)(36860700001)(82310400004)(8676002)(336012)(426003)(36756003)(40460700001)(70586007)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 23:05:12.8639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f202f51-98fe-420d-a771-08d9bc31858b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1901
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
In order to know the intermediate link rates supported by the eDP
panel and test to select the optimized link rate to save power,
create a new debugfs entry "ilr_setting" for
setting ILR.

Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1779c7daaf72..88d533469bd9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2755,6 +2755,138 @@ static const struct {
 		{"internal_display", &internal_display_fops}
 };
 
+/*
+ * Returns supported customized link rates by this eDP panel.
+ * Example usage: cat /sys/kernel/debug/dri/0/eDP-x/ilr_setting
+ */
+static int edp_ilr_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(m->private);
+	struct dc_link *link = aconnector->dc_link;
+	uint8_t supported_link_rates[16];
+	uint32_t link_rate_in_khz;
+	uint32_t entry = 0;
+	uint8_t dpcd_rev;
+
+	memset(supported_link_rates, 0, sizeof(supported_link_rates));
+	dm_helpers_dp_read_dpcd(link->ctx, link, DP_SUPPORTED_LINK_RATES,
+		supported_link_rates, sizeof(supported_link_rates));
+
+	dpcd_rev = link->dpcd_caps.dpcd_rev.raw;
+
+	if (dpcd_rev >= DP_DPCD_REV_13 &&
+		(supported_link_rates[entry+1] != 0 || supported_link_rates[entry] != 0)) {
+
+		for (entry = 0; entry < 16; entry += 2) {
+			link_rate_in_khz = (supported_link_rates[entry+1] * 0x100 +
+										supported_link_rates[entry]) * 200;
+			seq_printf(m, "[%d] %d kHz\n", entry/2, link_rate_in_khz);
+		}
+	} else {
+		seq_printf(m, "ILR is not supported by this eDP panel.\n");
+	}
+
+	return 0;
+}
+
+/*
+ * Set supported customized link rate to eDP panel.
+ *
+ * echo <lane_count>  <link_rate option> > ilr_setting
+ *
+ * for example, supported ILR : [0] 1620000 kHz [1] 2160000 kHz [2] 2430000 kHz ...
+ * echo 4 1 > /sys/kernel/debug/dri/0/eDP-x/ilr_setting
+ * to set 4 lanes and 2.16 GHz
+ */
+static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
+				 size_t size, loff_t *pos)
+{
+	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
+	struct dc_link *link = connector->dc_link;
+	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
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
+	if (size == 0)
+		return -EINVAL;
+
+	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
+	if (!wr_buf)
+		return -ENOMEM;
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
+	if (param[1] >= link->dpcd_caps.edp_supported_link_rates_count)
+		valid_input = false;
+
+	if (!valid_input) {
+		kfree(wr_buf);
+		DRM_DEBUG_DRIVER("Invalid Input value. No HW will be programmed\n");
+		prefer_link_settings.use_link_rate_set = false;
+		dc_link_set_preferred_training_settings(dc, NULL, NULL, link, true);
+		return size;
+	}
+
+	/* save user force lane_count, link_rate to preferred settings
+	 * spread spectrum will not be changed
+	 */
+	prefer_link_settings.link_spread = link->cur_link_settings.link_spread;
+	prefer_link_settings.lane_count = param[0];
+	prefer_link_settings.use_link_rate_set = true;
+	prefer_link_settings.link_rate_set = param[1];
+	prefer_link_settings.link_rate = link->dpcd_caps.edp_supported_link_rates[param[1]];
+
+	mutex_lock(&adev->dm.dc_lock);
+	dc_link_set_preferred_training_settings(dc, &prefer_link_settings,
+						NULL, link, false);
+	mutex_unlock(&adev->dm.dc_lock);
+
+	kfree(wr_buf);
+	return size;
+}
+
+static int edp_ilr_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, edp_ilr_show, inode->i_private);
+}
+
+static const struct file_operations edp_ilr_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.open = edp_ilr_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.write = edp_ilr_write
+};
+
 void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 {
 	int i;
@@ -2775,6 +2907,8 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 				    &current_backlight_fops);
 		debugfs_create_file("amdgpu_target_backlight_pwm", 0444, dir, connector,
 				    &target_backlight_fops);
+		debugfs_create_file("ilr_setting", 0644, dir, connector,
+					&edp_ilr_debugfs_fops);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(connector_debugfs_entries); i++) {
-- 
2.32.0

