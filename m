Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867DAC5516F
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 18:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC79A10F03E;
	Thu, 30 Jul 2026 18:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n6XCFUYW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D90B110F03E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 18:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0BP06dLjFhXr+jGkl00jAAzqvvcN5jkZf8pFj+oRgfW1JfiRc71cGXRyEncmlexaKe9XTy4flypQjJh8FiY5L5PKMTgezVMDIQ/5HqOXr02M4pnP7WsrjxmphQlRjPSJdPWhqX7uMXX+ws8f8cB/4Ayhm9woeohsPIstisEp5lDdTO+zZ9/ihODbt2eJHTi44cqIejnYA5hUvUoWyCWJF+zw1WpennHfx1/YHbUoy9Px4MbGky//VP3fAr3bTKnf4SQgF6sjAKFAtnFiidr41jkW+m5TwmMj/QBU+ptyaCwpWoIm0lsNF9mzdyeMfLF9xvXaYISgppD9XVB6cVhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+dXSNCVHlIIGs+SJicqwP1DROfXSQemUaceyGzbCUs=;
 b=ZvcrvNe5gGNTBtNdcOC4LrdG+VlyjmW2PHpcDNEJlsAUkjbIL1wvbfs8DPrGkFZPbKc7G6gOYGngMNef2Z5L98bfvAv2ZcV/3Scj4R7Cf1oT21griZo1YfXPIAljzawqsyPPiqPQKIMZ1ADKuMEZd0673It7ZRZ92nsMfIdtGiX2tHEN1+2ooNvRljBbXxaCT7rHGXUW4rtVETzdxhuy3w5oSmA3OV+K5S6ZnQCaA8mkT0Jq6Y+u4mkChnVMpZXcPBU6nCoDbhNWFcR3IICvbBhzdg4UE68VNt/L5JspkEKlJQGlfsnEKfyCzNxqorxVGADh8l8x2R7RzCJAvROkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+dXSNCVHlIIGs+SJicqwP1DROfXSQemUaceyGzbCUs=;
 b=n6XCFUYW/HM+LWtlqnJ5CBxxSGJZSxCfsFhFpATZUuf13HfxPrAFPJLgSyuytYY9+anZy4KeD8p/Phddu/pFrJqZErK/1EOt5idc38Cb6zGm+x8lFb9dec13PXcKfJVQHFI9sjwfXUxJauUtOw4bUYo45VJ5sxeRBVczTYrLOwI=
Received: from BN8PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:d4::16)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 18:41:47 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::79) by BN8PR04CA0042.outlook.office365.com
 (2603:10b6:408:d4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 18:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 18:41:46 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 13:41:45 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicolas.frattaroli@collabora.com>,
 <krzk@kernel.org>
CC: Fangzhi Zuo <jerry.zuo@amd.com>
Subject: [PATCH] drm/amd/display: Simplify hdmi_automation debugfs with
 debugfs_create_bool
Date: Thu, 30 Jul 2026 14:41:03 -0400
Message-ID: <20260730184103.916125-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: ed835704-23a6-472c-cfa2-08deee6a359b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Gwchk6zq8nEzb3ZAeCp4FUSKNSiUa4ux1uj8y1s+8tG5dKxKDUmEq9q4aCfrm4EaRrqVeyULAByitGnlgpRT4A9wo3JCEOPaiEHMdJBy0Et9h7g126gvcN5Tc2WbBg8Gdg19gDdbAGNkJb+yA4o8rDhMGBbLpDZ4/iX7VoI/KN9O9hkErGRLmFduJjId7swpJUw/ktDkomWo950wRtVGjt5lgsssTvy262jKtQQxGaM9XGmGOoIdZ78WG3BX5bAgmu8TrJqaNhekDkzf3oPjwEi13HeIYGal+NgcmP125RG6L1AcO4uIXS0X0Pj6dOx46OFqDQhtOEcKqOIu8w1/2YQX6pwgNuobPfMmEcxXDqYP1YrVJt/mJ3Fbphv6U3E8RHXAvYP/2mxuZE0bJABGDbvgwfqLrR64Zlv9lT0vjvj85pZAewhvNaZqrLSQ2zTSWAGYSfS01VswXIW6WD7S5bIZMhxbK/iEztePHSejiZmKeP4xrWSNDwW2G5kbIf/y9q5yvMLY5TRkLsQMu2Rq7cH486hPk3f7ciz8OagFaruBM3OgHUK0WxE9gbh2YX89OfICnUcWesqR+Jx++O8uThst7Po6LU2feFFIgIJT8U1FO11ZswLFJ2ZKUa40aLO3Gl5GEIK3TCo1eQ+QyObxl/QLvmVTfkrfmmdfBXeSIWn7fj8Y0LzUyT+GtunN8Luv0KD949VTLl9GBJQQrRpFlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: onDYV0/DOF1ozM6aSG+NUfGTt6NfxwwP2zHMBjOgmbuYJE+orWxe7tANHzfg6EIvgYRNAKtfdzapV6Gs4H0q0SaZUqfJ7SdP794yNUJKnKmgXozFe+cwsq78w/PWR8rdGGyP3aZ5qUReoBZDX8tlQ9tzoNzb2YbBklUQTsu7Ba8Qp7K40kgcWUcQtvQQjv5/W2+sLoPOB22+parpoyE8Rh2zsZ268o1HIX0lzO4wUdJzc9wrnn2i9Gst+HaZO1wY1N9hUSRQ3UKXwSHKwImK6vlHgDoHmYP1HS+L4z8NyLSukwR7W27R8pbdGEAAMR8e8zX3EbglF4hVbzLQ0QYFUcRCxrGDLQftTFaqM74yPADklfEYqnDOmuhaCo/3+1LQ2DBgrB7x7TDuwXVnP8qetQTh3dPYkc00rtIdKSZDbByH0of5UpDMpkzAVr8lAjo3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 18:41:46.4344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed835704-23a6-472c-cfa2-08deee6a359b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
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

Follow-up fix for commit 442b2e9dc9e9 ("drm/amd/display: Add Support for
HDMI Compliance Automation"), whose hdmi_automation debugfs entry
hand-rolled the boolean parsing (scratch buffer,
parse_write_buffer_into_params(), a switch and kfree) that the debugfs
core already provides.

hdmi_comp_auto is a plain bool, so bind it directly with
debugfs_create_bool() and drop the custom write handler, its
file_operations and the hdmi_debugfs_entries[] row.

Fixes: 442b2e9dc9e9 ("drm/amd/display: Add Support for HDMI Compliance Automation")
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 69 +------------------
 1 file changed, 3 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 830cf8da06b4..45249bebe9fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2981,64 +2981,6 @@ static ssize_t hdmi_cec_state_write(struct file *f, const char __user *buf,
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
@@ -3156,12 +3098,6 @@ static const struct file_operations dp_mst_link_settings_debugfs_fops = {
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
@@ -3194,8 +3130,7 @@ static const struct {
 	const struct file_operations *fops;
 } hdmi_debugfs_entries[] = {
 		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
-		{"hdmi_cec_state", &hdmi_cec_state_fops},
-		{"hdmi_automation", &hdmi_automation_debugfs_fops}
+		{"hdmi_cec_state", &hdmi_cec_state_fops}
 };
 
 /*
@@ -3908,6 +3843,8 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 					    0644, dir, connector,
 					    hdmi_debugfs_entries[i].fops);
 		}
+
+		debugfs_create_bool("hdmi_automation", 0644, dir, &connector->hdmi_comp_auto);
 	}
 }
 
-- 
2.53.0

