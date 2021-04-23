Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A779FC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427EC61437
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427EC61437
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCDE86EB26;
	Fri, 23 Apr 2021 02:40:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA966EB26
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbZ4+JByN23OHFdYVPKIEO/B6HQKLwxdD6UnkSdVuQEXffRs6e+BCwumvyP5U5K6aBHObtamLjI2iWCVp9mteB4DuDYA8ccQdTvK81JZTzcnSSgclwiTQnfxElSvd7LfIGYcp9fS/ZK9D+WR730d1zW5CE2nAMyTK5IvIe/3tXf/WlvB4GKGKce5jFfPyKp5Q+PDJktfVe5dQtCUJB7J0tgWXdnDcDzjvoJTSolvic8IQ+Hg4CeT7j3d0Gxn/t4bHpFbBAhD96GqhMmj2DTvlh71JoPNgEVCnVcwq1JiWG7p5f5ZOpFW4ocgprZhpqMR93klXcabaYk8j+D9FzzniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSFEdAkF3kQTpO/HebIygyrdBzhSLnNwsHi38orlLTQ=;
 b=X1963CznqfgqxiU64dSEmQzzQhz2DuR8IdT95N4NhRy5Qm0wSvFKClEqpwa9jZtg5U/gMeSMD01vGBFaNdRHNHnAGyj0EWVH5tHTGfRsqgeGXQBi+WsL+T42qIEVUSVf3SZnUH9fXt6LGRLCnc29P7HHkzXe28upXYQUvJuidQh1KKAau6UfMnImf8Ly066gcqLkhZg/EASyjFDVdw+KOLZCT0pj8C8+uPM+U0a+epc6GpXFud6R8RS3T5wNNaR+3kqugh9L2HilL50ocf4MmQ8L4bq4qxhWL2+NJMerFfpPetUJmXB5zDqdzCuR4l2pOV2QrDXWU43u4NjbzPk4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSFEdAkF3kQTpO/HebIygyrdBzhSLnNwsHi38orlLTQ=;
 b=Yx8Z9GXVt3qLeblwtX/9npruFDYy/Avf4y2O6CHCcUHliigG1j2n3w3VO8zaXP4A5RvxWcEDjDerudOaL2tTNXeewfzUqCXBYVsNodxP8xEeBJw79uzX/Qo4magHcfZvoyoFwDOxw5mq0eMuwHlpZe7nMA0luB+xeqQdgfKVeQA=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by BN6PR12MB1153.namprd12.prod.outlook.com (2603:10b6:404:19::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 23 Apr
 2021 02:40:09 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::c8) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:07 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:05 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: Expose internal display flag via
 debugfs
Date: Fri, 23 Apr 2021 10:37:03 +0800
Message-ID: <20210423023714.22044-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c156290-115b-447d-74f3-08d906011c4b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1153:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1153C408481B1BE5EA1B3AF3FC459@BN6PR12MB1153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33ei2GYzLvK+U5nbwjWuyxT8Tp3ghf/3X608KJcsRoeBoSlnfV0RqsGJpb3XKFggVPNNGjUm4qSCTveLyb3wP2a73PfxNcu+XzfQk+o5itZKUb6ZkSfwSO/pAYKv/v3QcqDy2wmYBb1NGT8mEfn3TbA5riuE0eTXyME2Brq+e0BiUMOJnfd2OyOEVMZV+3DgY8P9BzzVJh4/5jYdXIik9qRKb1mGEaMI1uEjgWkZvP9jcNZJN0Vjpy4JH5CccDUIioR2g69CDJW1j4CskzpS6/x23kK8l52l+6MzHA+mbc5/sdIv5i0S3Wc5rwt0vv6LHk31X4SPQ3/U7C6+sTim60QRssIVNeiMXUTDqE0o24rxIM8ECsFUOL2jv0MtET6ewTNVKpAerCnj74bKWsYGcDLTZy51dtOvh6bKXJb4xcN+bOm40TlBSlzybOFqGW+57SZIOI8TWrXjM++DfttUaUQoD2zKaP90bqWus1ZKQKWWUqUBllHuVHCo2hstlXR1AwjySsafrg34FeaP+2SWcbzp8WzkqlCQBB/tjCZv41jzgcDVcKIlQIPrVJyVEow4rUO3Dv4dJ8qi7Z06MYJdQF3OUg32N1Ct98wYc81nFHwob/Z5bU0hu4z2AJf1dOv8T4bdyLm24f58A/z7ozOnC4BVapchenADCJPm/8P8n+fpalibQUKGdUpMP8n+1wgR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(5660300002)(356005)(8936002)(8676002)(2906002)(86362001)(83380400001)(426003)(47076005)(36756003)(7696005)(36860700001)(2616005)(82740400003)(82310400003)(70206006)(478600001)(4326008)(316002)(81166007)(1076003)(186003)(70586007)(6916009)(336012)(26005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:08.7487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c156290-115b-447d-74f3-08d906011c4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1153
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why & How]
Add a per-connector debugfs entry to expose internal display flag,
which is indication that the display is "internally connected"
and not hotpluggable.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 529545045a3e..656bc8f00a42 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -925,6 +925,22 @@ static int hdcp_sink_capability_show(struct seq_file *m, void *data)
 	return 0;
 }
 #endif
+
+/*
+ * Returns whether the connected display is internal and not hotpluggable.
+ * Example usage: cat /sys/kernel/debug/dri/0/DP-1/internal_display
+ */
+static int internal_display_show(struct seq_file *m, void *data)
+{
+	struct drm_connector *connector = m->private;
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct dc_link *link = aconnector->dc_link;
+
+	seq_printf(m, "Internal: %u\n", link->is_internal_display);
+
+	return 0;
+}
+
 /* function description
  *
  * generic SDP message access for testing
@@ -2369,6 +2385,7 @@ DEFINE_SHOW_ATTRIBUTE(dp_lttpr_status);
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
 #endif
+DEFINE_SHOW_ATTRIBUTE(internal_display);
 
 static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
 	.owner = THIS_MODULE,
@@ -2600,7 +2617,8 @@ static const struct {
 } connector_debugfs_entries[] = {
 		{"force_yuv420_output", &force_yuv420_output_fops},
 		{"output_bpc", &output_bpc_fops},
-		{"trigger_hotplug", &trigger_hotplug_debugfs_fops}
+		{"trigger_hotplug", &trigger_hotplug_debugfs_fops},
+		{"internal_display", &internal_display_fops}
 };
 
 void connector_debugfs_init(struct amdgpu_dm_connector *connector)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
