Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8716CA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59CC010E0A8;
	Tue, 13 Oct 2026 11:17:01 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989E810E0A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X99BKMn83mIAV0toG7DvFv+Z8u1A+F/34hk4qWJs2CTIsOmELa6wBdKfKqJFf+muIDOl+pq/MwuwFPCRHbonrHEdW58010WlsgVVBrDnU9JQHYLpswqoHrYgXKbXEC8d71RYh60Gx4TyEVKa8bh6h8Jn46WGBuYWezSDt3+iAyFdiu+cN3WKNYwYDa/bZMEfOQsrc4DObQuY6is9E0+JvT9zXki0TOzCHatS532RK6UXajReDpb9k3cHc0e5ziOTr8UaYAovLpH2Pq7N5XpKFb5c30DxjH/QTf4anMfENGFSveoOxNcDeNJE/6PpdbHveNLRsMdQY5xPJ+0/FA431w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IwN2ORmoWXmQ0BQF4Rw+W5Oa7wJA3S2rErCwZh05EU=;
 b=InErgO8QBPAgY/XVT/bEe2mxYRGgjjsTPLi+NcSnCWM6dVcAF8Vxa6zUzWKRk+XVMMNb0PeEEbKeIHLyP+esWbQGhREP00PvinEdrrzc5V8s6/RgHeJjrkw6P4JX2zbktOINW8SkMZwhotgR4fXg/tJRvkKuTQpk/JkzMVT7g2ng0YLaAcfrWHYN+WV1MS5LTwwFgcLeCf5XEjaE+uibU/mEOkfjbDyA+hZ2QXIJNTsjvuhzDdZJ9mq/r1Z8g5pf2E2fnfrOilfFiKhc07H/F71+01exF/7Qqs/NSuesXWSXDz5AtwD0xncmGsme7xoWMxNFnX0xsy7/YxGy7KbnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IwN2ORmoWXmQ0BQF4Rw+W5Oa7wJA3S2rErCwZh05EU=;
 b=eS53dsgrD7vrUOuG+FPsxAcbL9wnn6q3dkoppsEWyzVQJ/+q1Lu0b/hwUxUL/+4jnnDZMwBpEr0ZNR3Ic5eU0SuId+RwI1M2APyRdgr9vfIK9Y7EK9Ghz1uhR7ZTFe6Rid5/CtN2fdtE76rx6U9O4LWb4+oYCP5W1cDdb4pvNjI=
Received: from MW4PR03CA0129.namprd03.prod.outlook.com (2603:10b6:303:8c::14)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:16:51 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::ae) by MW4PR03CA0129.outlook.office365.com
 (2603:10b6:303:8c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:16:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:16:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:16:27 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:16:19 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 04/30] drm/amd/display: Simplify hdmi_automation debugfs with
 debugfs_create_bool
Date: Tue, 13 Oct 2026 19:07:51 +0800
Message-ID: <20261013111616.2267344-5-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 8598a95e-6982-402f-d9eb-08df291b7ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: M8VqFFlqELfHj6aJyHF4xiitYNSZ41xUXlXdYnplvb0zex0LMmMyPGlhUbl1ZNbhhFydo34CmoibVIcu7wgt+WzUAqU3CSQ/DfyqmtKkEgqm88VjeNIPFpg+9vEmdZt5OlacavgQrKF4i9zObhnJRPinmmvNzAW3gyXjPuXFEd91+T6EwTpeis+f3/utkKG5avgqhHNTVRrofU4h+ah9K2AD7rX0IpBeODYc0byEz/MlgBRBOegeHx2GzgsPogjo2wLc+mLGcYKKYQCxsrdF8XjIvMDhs9a1owb/vVOirHg2fuuuYGO/1hIFLUusU0P9Gwt318iYkEZjS3VOShT0GnWmoXOrmFoe+TVQscE+1WDvxPLWW+fSjAHtYlc4CP3R1YqzzmwtoJxRh3LVmvXGoL/X5O+T+kuLHtH2NqOcdbIJsr/AlQTIP/YgV5O15Q9E3ulkzmUq4gIyIKn1iR+6BNLiG3h5VqnfLiJKfQnuAKBt4jSZmuyd0LYA4flgC3WpQXZLMYSzxYTT85ynl8UXTk11ldfPQCblFz75jTy/a39mJ0HAdJDgOuNrIpT2/fyR3oxUyRSoujb/ieQWdYdbmZ30ysmc9aAHnQ1sBquJeW24e9XxdS3ot/sRFwh2km5bhfxUCAo+2f4IPR/2lJesXcssLbBLulKv7Za67W9jPNuvsusutmdjjUvHy6eyunZULcFeKd5qxuGNYpx+nv293A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ei6jS6aD/c/5aAnLFtdQ4q9fD0OGlZ7/9sX+WmZsnZDNLXD9SYTvQo8HdqouzOcnxAq81IapDuGdm9nevhwc5mRie25MQ6kgGSmQJa7O+jNmlMxokhnEfY2cYy9GW+yy6H8O8dzvZKTJhejfujswCaJ2VH5HgoMspHCeX255RqWXHQTiSu0E2nI/CRwkW6gdho6aUK60PZ3kxgsbIDOU+FLZrNNAj3FxE6P27PLRK6vAGT2Fh4vkKAdm8xTGn4p3YhFHE3qiU1vUsqslRBmZ8W+lWFH2lUQJb28zW/ygf9xtmgk9jKmOyfHtBziF4f+XzPBLEIwjQNkcaYMrT7lgjvifewRRGRwU7/cYc0D+1OvREVsJAUhgACHWucSRqNNzZRIUrqo0/HC8pRJsNvTwucKJzusMqebj80I8TvjTgNdvs6wTEODaresczAlj1x0j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:16:51.1347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8598a95e-6982-402f-d9eb-08df291b7ae5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

[Why & How]
Existing hdmi_automation debugfs entry
hand-rolled the boolean parsing (scratch buffer,
parse_write_buffer_into_params(), a switch and kfree) that the debugfs
core already provides.

hdmi_comp_auto is a plain bool, so bind it directly with
debugfs_create_bool() and drop the custom write handler, its
file_operations and the hdmi_debugfs_entries[] row.

Fixes: 442b2e9dc9e9 ("drm/amd/display: Add Support for HDMI Compliance Automation")
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 69 +------------------
 1 file changed, 3 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 36f32ed4b87c..6622a686e5e0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2995,64 +2995,6 @@ static ssize_t hdmi_cec_state_write(struct file *f, const char __user *buf,
 	return size;
 }
 
-/**
- * hdmi_automation_enable - Enable/Disable HDMI automation feature
- * @f: file structure.
- * @buf: userspace buffer. set to '1' to enable; '0' to disable automation feature.
- * @size: size of buffer from userpsace.
- * @pos: unused.
- *
- * Return size on success, error code on failure
- */
-static ssize_t hdmi_automation_enable(struct file *f, const char __user *buf,
-	size_t size, loff_t *pos)
-{
-	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
-	char *wr_buf = NULL;
-	const uint32_t wr_buf_size = 40;
-	int max_param_num = 1;
-	uint8_t param_nums = 0;
-	long param[2];
-	bool hdmi_comp_auto;
-
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-	if (!wr_buf)
-		return -ENOSPC;
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   (long *)param, buf,
-					   max_param_num,
-					   &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	if (param_nums <= 0) {
-		kfree(wr_buf);
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		return -EINVAL;
-	}
-
-	switch (param[0]) {
-	case 0:
-		hdmi_comp_auto = false;
-		break;
-	case 1:
-	default:
-		hdmi_comp_auto = true;
-		break;
-	}
-
-	/* Persist setting across sink re-detection/hotplug. */
-	aconnector->hdmi_comp_auto = hdmi_comp_auto;
-
-	kfree(wr_buf);
-	return size;
-}
-
 DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
@@ -3171,12 +3113,6 @@ static const struct file_operations dp_mst_link_settings_debugfs_fops = {
 	.llseek = default_llseek
 };
 
-static const struct file_operations hdmi_automation_debugfs_fops = {
-	.owner = THIS_MODULE,
-	.write = hdmi_automation_enable,
-	.llseek = default_llseek
-};
-
 static const struct {
 	char *name;
 	const struct file_operations *fops;
@@ -3209,8 +3145,7 @@ static const struct {
 	const struct file_operations *fops;
 } hdmi_debugfs_entries[] = {
 		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
-		{"hdmi_cec_state", &hdmi_cec_state_fops},
-		{"hdmi_automation", &hdmi_automation_debugfs_fops}
+		{"hdmi_cec_state", &hdmi_cec_state_fops}
 };
 
 /*
@@ -3975,6 +3910,8 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 					    0644, dir, connector,
 					    hdmi_debugfs_entries[i].fops);
 		}
+
+		debugfs_create_bool("hdmi_automation", 0644, dir, &connector->hdmi_comp_auto);
 	}
 }
 
-- 
2.43.0

