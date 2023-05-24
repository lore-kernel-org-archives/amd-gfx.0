Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8384C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 17:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2EF10E013;
	Wed, 24 May 2023 17:59:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E959C10E013
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 17:59:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk+oyoxF9oilaTy96/wiva4mzWHrsp6sJ7PRO+X5KUdGziVwd5j0h7uiPsm3A7LeRyzbHk9zszJnbyBEOIEyOH32AKdbSov5HaLcyXy5Pia+5CdOFZtip8xFrHG5mz44vcyAx6XJ0VRuAtga2dYt/+TvYhUZ8Xp1gmMgE3h9R+Pf1mLNnMHvb09t51KBawCJC7WCPz9LL7M8wr34ZJuy6k4lGC+dmmhk2+MYajxPAi94o788s9SzNG9izIfS1qJZzNthgc2pKVosEqy1z1hD077E8CNW2F4cgwAQ1AQhb5p4Wz5id8L8iiaYqLjYXtge9UwT6JAKErPneiHFsWb6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU1gTQvYjgFmG+UCUxqIx9u/g2THCeKPweyMfBdM67g=;
 b=BIORnX32koSfIclrNwBKlwePta1fd0eVC2kIz7M8seESp65geiQNILm1X9dhHqTN85CSV/UR1CJYuhrUhXncPhaDqZFesnBi67lZvwsYNP7E0kGWM23elZBv8aSZ/QLYTg3QoI4Tw80+DHzDkE8GcmYw4k3Whr81aoIBzXRlOLj3+5HGbBTDdYnCms62fuNEBOthyuiVHr9enwGLKIvrmQcFFA76+7vE17sWZm69c3L5RieOxALEq3AT1W7VzF69sDmYqgsWYnuYdGgji1SE8Is3nbHPMZDnCtsNNrZCrNE0Qp3I+EEYxQECTNF2vdNZFOX8a62Pjs5oQ2yD0O3m/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU1gTQvYjgFmG+UCUxqIx9u/g2THCeKPweyMfBdM67g=;
 b=QvPElS4GxEeXxkMDJo8f4vuftRSkhWuxvl0ER6YHgS2ICUa3tJGXUUpOXmfBTMTtBegetdd8/FMKJM//w/ZQFWe11E6K4++NAHrH+Tr21YaQfVtgYjaR6l8s7cipLCmcrxzWBDSDx4PqiO3pf5d/D156DqntpAnFbsVsP5qr93g=
Received: from MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::15)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 17:59:04 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::81) by MW4P220CA0010.outlook.office365.com
 (2603:10b6:303:115::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Wed, 24 May 2023 17:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Wed, 24 May 2023 17:59:03 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 12:59:02 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Drop debugfs access to the DPCD
Date: Wed, 24 May 2023 12:58:45 -0500
Message-ID: <20230524175845.16580-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4ac47b-088e-48e8-1c26-08db5c808fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tuHyGyDgAaKZV+KPalfUr0ZonhYVIwRJjdLl+mq2GLQWnh41Fn2pILPNMBoRY46KamBP2Dk/Cu45lnY71CmK6/TrHBj/aKlB/ioU34L/ZttxOxLxx8+tpCS8EDRWk0HkrVQoORqalJW6DSv15QHN5tscKS5DXOq/oEt9mVXhT3U7zVgJo4JfNLJZISYJXy4ohzzlEmmh/sqWrccjTplWxAsHxOZ28/oENTDgXCLHMhOBNq9Q/y7RDgLaPdXdMcahKrEnCAacWhcfJAspVr4k2myziJy/LMHZZ3mlZhXsnZbzMzYH92LJYnZt6jMYowt22PMoMqgMD14ddBP0z3s1iYZTxd5H0qQsvOo3I0apq651SY/wN8fT2btl8wTYfIjNYh6Osfybp4pj2Ya2srs9i+j3uw63NIXeYB5TSi0RWdxjeD/dEEZ1vCALmjUBu25HUJ2Ohu1Wkxm5e2LMOYJ/HZ7WuRFp3rR0LM97yhV9W/YHiTNy8Svt/W6YqsrbJKDJx9O0H7+EDE90p3JJvt3yymo59RTFHbAPwfLIlkuLjTErv6d+2qZqZEnXj0vEEXryj6aBK4LWyarEmaRgtDeaP6EyZnw8VPfCZ7tnBduWms+42ysuppCdy24aSrEDfeCkZmHKiKi5umlaUDU3bfWUYieR8CMjK8htcthY3S/9apgJvAMGOYF5cLHNrv+iHFb7adh0soAB7deTA5PVD3TtRFf4Hmk44WV1GEfAbHmKQifer/RLleoybOWFS6+QMGP7Q+hYbHAsByB6+xQF4GMHlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(356005)(1076003)(26005)(16526019)(40460700003)(186003)(81166007)(44832011)(36860700001)(47076005)(36756003)(2616005)(426003)(336012)(83380400001)(2906002)(40480700001)(7696005)(41300700001)(316002)(6666004)(82310400005)(70206006)(70586007)(6916009)(4326008)(86362001)(8936002)(5660300002)(478600001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 17:59:03.6920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4ac47b-088e-48e8-1c26-08db5c808fa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is already access to the DPCD from userspace through
`CONFIG_DRM_DP_AUX_CHARDEV`, so it's unnecessary to reinvent the wheel
with a set of extra debugfs nodes specific to amdgpu.

The character device interface behaves more like you would expect in that
you can seek/read/write all from the same file.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 -
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 107 ------------------
 2 files changed, 111 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 2e2413fd73a4..4561f55afa99 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -661,10 +661,6 @@ struct amdgpu_dm_connector {
 	struct mutex hpd_lock;
 
 	bool fake_enable;
-#ifdef CONFIG_DEBUG_FS
-	uint32_t debugfs_dpcd_address;
-	uint32_t debugfs_dpcd_size;
-#endif
 	bool force_yuv420_output;
 	struct dsc_preferred_settings dsc_settings;
 	union dp_downstream_port_present mst_downstream_port_present;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 827fcb4fb3b3..82234397dd44 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1039,88 +1039,6 @@ static ssize_t dp_sdp_message_debugfs_write(struct file *f, const char __user *b
 	return write_size;
 }
 
-static ssize_t dp_dpcd_address_write(struct file *f, const char __user *buf,
-				 size_t size, loff_t *pos)
-{
-	int r;
-	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
-
-	if (size < sizeof(connector->debugfs_dpcd_address))
-		return -EINVAL;
-
-	r = copy_from_user(&connector->debugfs_dpcd_address,
-			buf, sizeof(connector->debugfs_dpcd_address));
-
-	return size - r;
-}
-
-static ssize_t dp_dpcd_size_write(struct file *f, const char __user *buf,
-				 size_t size, loff_t *pos)
-{
-	int r;
-	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
-
-	if (size < sizeof(connector->debugfs_dpcd_size))
-		return -EINVAL;
-
-	r = copy_from_user(&connector->debugfs_dpcd_size,
-			buf, sizeof(connector->debugfs_dpcd_size));
-
-	if (connector->debugfs_dpcd_size > 256)
-		connector->debugfs_dpcd_size = 0;
-
-	return size - r;
-}
-
-static ssize_t dp_dpcd_data_write(struct file *f, const char __user *buf,
-				 size_t size, loff_t *pos)
-{
-	int r;
-	char *data;
-	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
-	struct dc_link *link = connector->dc_link;
-	uint32_t write_size = connector->debugfs_dpcd_size;
-
-	if (!write_size || size < write_size)
-		return -EINVAL;
-
-	data = kzalloc(write_size, GFP_KERNEL);
-	if (!data)
-		return 0;
-
-	r = copy_from_user(data, buf, write_size);
-
-	dm_helpers_dp_write_dpcd(link->ctx, link,
-			connector->debugfs_dpcd_address, data, write_size - r);
-	kfree(data);
-	return write_size - r;
-}
-
-static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
-				 size_t size, loff_t *pos)
-{
-	int r;
-	char *data;
-	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
-	struct dc_link *link = connector->dc_link;
-	uint32_t read_size = connector->debugfs_dpcd_size;
-
-	if (!read_size || size < read_size)
-		return 0;
-
-	data = kzalloc(read_size, GFP_KERNEL);
-	if (!data)
-		return 0;
-
-	dm_helpers_dp_read_dpcd(link->ctx, link,
-			connector->debugfs_dpcd_address, data, read_size);
-
-	r = copy_to_user(buf, data, read_size);
-
-	kfree(data);
-	return read_size - r;
-}
-
 /* function: Read link's DSC & FEC capabilities
  *
  *
@@ -2682,25 +2600,6 @@ static const struct file_operations sdp_message_fops = {
 	.llseek = default_llseek
 };
 
-static const struct file_operations dp_dpcd_address_debugfs_fops = {
-	.owner = THIS_MODULE,
-	.write = dp_dpcd_address_write,
-	.llseek = default_llseek
-};
-
-static const struct file_operations dp_dpcd_size_debugfs_fops = {
-	.owner = THIS_MODULE,
-	.write = dp_dpcd_size_write,
-	.llseek = default_llseek
-};
-
-static const struct file_operations dp_dpcd_data_debugfs_fops = {
-	.owner = THIS_MODULE,
-	.read = dp_dpcd_data_read,
-	.write = dp_dpcd_data_write,
-	.llseek = default_llseek
-};
-
 static const struct file_operations dp_max_bpc_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.read = dp_max_bpc_read,
@@ -2724,9 +2623,6 @@ static const struct {
 		{"test_pattern", &dp_phy_test_pattern_fops},
 		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
 		{"sdp_message", &sdp_message_fops},
-		{"aux_dpcd_address", &dp_dpcd_address_debugfs_fops},
-		{"aux_dpcd_size", &dp_dpcd_size_debugfs_fops},
-		{"aux_dpcd_data", &dp_dpcd_data_debugfs_fops},
 		{"dsc_clock_en", &dp_dsc_clock_en_debugfs_fops},
 		{"dsc_slice_width", &dp_dsc_slice_width_debugfs_fops},
 		{"dsc_slice_height", &dp_dsc_slice_height_debugfs_fops},
@@ -3025,9 +2921,6 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 				    connector_debugfs_entries[i].fops);
 	}
 
-	connector->debugfs_dpcd_address = 0;
-	connector->debugfs_dpcd_size = 0;
-
 	if (connector->base.connector_type == DRM_MODE_CONNECTOR_HDMIA) {
 		for (i = 0; i < ARRAY_SIZE(hdmi_debugfs_entries); i++) {
 			debugfs_create_file(hdmi_debugfs_entries[i].name,
-- 
2.34.1

