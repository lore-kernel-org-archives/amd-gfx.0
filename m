Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBF6C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176C110E4CF;
	Wed,  7 Jun 2023 12:16:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02A6010E4CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGQpKmMW6hzKJI6mGtBuxDNix5fHPGqOp7tcp1fXHdSCE+wgXgVurCLJiD7FzsGbPfYMZOxSaCxsLcCQuf1Oe8grNTkTnPrLulbjNnqer8IHDuVt6yDEZJWidOT4LAyhZVvlz3X3dG5hp+BI24b73mbT/0FMOIwc0Q/4mgqYDIwtUA5QYXtz3e4wfh1ZLnfj3SSUlhY7d+6G7nJMBEJTwBR/NHmfB9hul0CqmJycJi703DN0zn+VtlL6ji6SpSAlxgP3mcb+YdWraclPvkVqA4hmvzQ4d3F5NDKG6kgduXtjwvJtTMxNuwtY07KTiMGKWYoeqk90AaD7BVeSx0im6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlsZYsCOIVld9JzYviZn+IadQlPyLZNGWIx/2zQ3XeI=;
 b=b9dKOLxnH9JMZTSeH03RID9yk2BQENL6Z0zQenmSkA9NV5MRkZPlFAkqWJDVitdH/1x6Co66SJ608Fuh+YfD+Rkyf8qf/PXe8VGiPRbMdHLceZJMGPIy5Pg86HtmzzHc7BCafLCFSCg2Lu3fMQW13NmeLGDjSfNYT0I+c+KAgWqsPqpvvc997A6MwjiLAIczzMB/is9u1daoRfuAYi3XiDfh3RF9KS/LUDs9kQnZwqBKQYF9LcNpjETahs1IvkEDq4Vw0SbxDDE/ciGFZFmAnPE+Jk86S73LrVmxQzlqD6Yl5aOYxS98Kh56NjjcQBYHd8LE9J019Hm5hvHezIhPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlsZYsCOIVld9JzYviZn+IadQlPyLZNGWIx/2zQ3XeI=;
 b=QwLwSgBDvZVt8rnYuYU5ikcgKLcx75xnTrabcbmkPWl+rjIuKRbaLbz1QXmmDlN02dbr7C8qqr/B99UUtTcyLsFvkDgitk3lnAwJVECtvgW8aXf2vYnSfGhfK+6njWlQ5GrqcI7X4hAZqm//x4mg/kIMv+hqmgqRm5CTIW0XCYI=
Received: from DM6PR13CA0029.namprd13.prod.outlook.com (2603:10b6:5:bc::42) by
 IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 12:16:20 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::60) by DM6PR13CA0029.outlook.office365.com
 (2603:10b6:5:bc::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 7 Jun 2023 12:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:16:19 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:15 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/20] drm/amd/display: add debugfs for
 allow_edp_hotplug_detection
Date: Wed, 7 Jun 2023 20:15:30 +0800
Message-ID: <20230607121548.1479290-3-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 4949cc22-f29f-4457-f1aa-08db67510053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDZORXifT4LONkIyVGo64bhub4qmDfhFeIe4OEvDhuWdfrGKcqPMUBPqWodDv1NRDFBy+WpNEyVnXx5IfMgwX5HuAClGERpsCHCNBH4t6cWkuoGAPZVgSRZuNNi4M4VJdmefGhmjt8yUQEq23/t64YzRUSc9CC8DR5J5GACQsiQskMCTFtvCMkDrXdLattcHsuBStFWZ/or9JpgpYAbDvR/mRGqrDnvEsYd6V9VHNFsUj0aEQ/vuL4vp/xXWUICCGWCVsIdpDfit6qQMKB/+JTBIVWRxeGHZ3LPsoyQJCOGTbr4ekVpog0/Mz/25K2mxz3KtwJYKLY5uc+TQnicDkXeUGuFnFQ8Q8GXq6outUp4CHoCmzrjVx8RRjU55E3UktVJ5fEUUu9lBsBOhVeRbhzjkRxjC1pUFSRxgqOTwOSUSRGw+sJFykV2WXJkv4zFAGQz1nOCAEdkvPmrnpg5+S4/5z4iTszn+xJKYgCn+hWCPMdivGh7h45nS1hRakJAThOyssOHSQ3uKSq5YcSSIToFQRM7n96tQvFsvyVmM9RemEBf6Cm3PrAa6WZ0venNETu9qX0RSJn+S1aZqe/aFGma7xj9iuIxud91kq4ntxEYYNkLLonoSA20j4saZWCsdzjV3d8rtgVVw1E+ZP+dSVG5SvqLcK8uNAFM1x5si+opu663Z931gF51X//SaeQx8ISiAu92yED3X+/HEw4FQ1IiDJkaJhQBfny+7pf3s7qAY6yKMmKFzCKedkqfUnScRwcgtlahzy47isgEjc/sL0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(54906003)(186003)(81166007)(356005)(478600001)(40460700003)(70206006)(8936002)(8676002)(316002)(6916009)(4326008)(70586007)(2616005)(41300700001)(36860700001)(426003)(16526019)(6666004)(7696005)(83380400001)(1076003)(26005)(336012)(82740400003)(47076005)(44832011)(86362001)(5660300002)(82310400005)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:16:19.7632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4949cc22-f29f-4457-f1aa-08db67510053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[Why] within dc_link_detect, edp edid is read only for the first time
and saved. edid will not be read after the first time read. to run edp
edid read test, need read edp edid for each dc_link_detect. dc->config
flag allow_edp_hotplug_detection could be used for edp edid test.

[How] add debugfs for dc->config.allow_edp_hotplug_detection

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 82234397dd44..2ff88562c27a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2705,6 +2705,32 @@ static int psr_read_residency(void *data, u64 *val)
 	return 0;
 }
 
+/* read allow_edp_hotplug_detection */
+static int allow_edp_hotplug_detection_get(void *data, u64 *val)
+{
+	struct amdgpu_dm_connector *aconnector = data;
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	*val = adev->dm.dc->config.allow_edp_hotplug_detection;
+
+	return 0;
+}
+
+/* set allow_edp_hotplug_detection */
+static int allow_edp_hotplug_detection_set(void *data, u64 val)
+{
+	struct amdgpu_dm_connector *aconnector = data;
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	adev->dm.dc->config.allow_edp_hotplug_detection = (uint32_t) val;
+
+	return 0;
+}
+
 /*
  * Set dmcub trace event IRQ enable or disable.
  * Usage to enable dmcub trace event IRQ: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
@@ -2743,6 +2769,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
 DEFINE_DEBUGFS_ATTRIBUTE(psr_residency_fops, psr_read_residency, NULL,
 			 "%llu\n");
 
+DEFINE_DEBUGFS_ATTRIBUTE(allow_edp_hotplug_detection_fops,
+			allow_edp_hotplug_detection_get,
+			allow_edp_hotplug_detection_set, "%llu\n");
+
 DEFINE_SHOW_ATTRIBUTE(current_backlight);
 DEFINE_SHOW_ATTRIBUTE(target_backlight);
 
@@ -2913,6 +2943,8 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 				    &target_backlight_fops);
 		debugfs_create_file("ilr_setting", 0644, dir, connector,
 					&edp_ilr_debugfs_fops);
+		debugfs_create_file("allow_edp_hotplug_detection", 0644, dir, connector,
+					&allow_edp_hotplug_detection_fops);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(connector_debugfs_entries); i++) {
-- 
2.40.1

