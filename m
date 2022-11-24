Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BD4C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 885C010E26E;
	Thu, 24 Nov 2022 21:14:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6935510E259
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVRkOC3lzuLU6Y+lUSgAOv3dLeSdPfOWfgcdoEVMSngvV/6gp2vb7PRDOl6AfRk3cY09ZvW8eDoiPq7/yyG60IyTv8wMAkVRBHM906aGuD+e8k3lNr/8dEWXrUeAXoBWmQgHBGdNAdycTZRAGElnfUslcYwmD5UAIruKsBQ0g8B6oDcmSVWhQ43x/lwVOoY9kAlnlOH0AY/yXFIuZDiQEaXOBqHkZwgdzZnGwen2vyLe5+s6BZKwun/uCh0YtEuIQVEysxBM1DdCw3SB5JnCo7zf2BSw1UMWCXyrAV9JoLdhxCbKzxt3mCX3Pa8p73bToAKem5haqpJSX8YvGOkNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e5fAxjp7v6GF3o4yh8IF+ZADBdA9pePNyzPuO5mGGk=;
 b=cgZZo7ogRxh+1vcs7xJDUBPbw7ZaY9NDCgR7mX5f5X4mi5MSjzZ0/dsiQc+Jam8oXivJ8g4/60Zf3Nu1+if39K1TQgQ7+aSVCVKR/YFzL7ZNjaxL7TG0m+H6gFGdYr9ekCZB2bNAwmyf4Hb8ZiDK1EisS1bZnX9hTFf/Sj8fvaHRAt9Lt50pFhl/9waUBmoDeyXvwRXUjuk6T9ofomGPCsMVelmKlFxewpMDhRBJ5XGXfuEOM4BnOgCnuTmzDU459gxB+SOFT92Gn50RnEzMod9plaIFxCSljubeCr7thjML1b32tBBc4jxIcsSPTQGgA3tytD64mRpul+knzZHjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e5fAxjp7v6GF3o4yh8IF+ZADBdA9pePNyzPuO5mGGk=;
 b=o+joLL04aTxlHcR8W21Edis57uak3mjTi9DVh9veWHtx1peQVh+hAmUsYFZv1jTWYcAbMC3/fdiGbNQoyR3cwK7EGnKA99bZI359S6xgbpzYMkQu5Cs1qrOc0O/p18w6RUMvxkyfeCV49QEngqSYORMQF9AvUADCWObXj9J85Ig=
Received: from BN9PR03CA0406.namprd03.prod.outlook.com (2603:10b6:408:111::21)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 21:14:04 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::bd) by BN9PR03CA0406.outlook.office365.com
 (2603:10b6:408:111::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Thu, 24 Nov 2022 21:14:03 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Nov 2022 15:14:02 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/display: Create debugfs to tell if connector is
 DPIA link
Date: Thu, 24 Nov 2022 16:13:39 -0500
Message-ID: <20221124211348.214136-4-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124211348.214136-1-jdhillon@amd.com>
References: <20221124211348.214136-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb711a1-0c63-4220-68ee-08dace60d087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELjMkMYZlcXiAO4vQGKFiKbKHQy55iI1j/b0H2HwEHv2TQC6iHN2yv2kKy0f8HLqF3FWA8OfoHiePbUrsTo+0wNSRpnb+ipulVgzMzwBQW/yVWolc6Ox5I1ykaNcTr9x6TKgXNaIuqo2z+QNulf/f80KF4JVK4YvxyNwWZXxIhLiSfGeCm6/TPP9LMekxgXwXLoyjMlaS/fTkHq1EEDsgDMEFfOsxdO/L9Ms5Z8i+c90L4V5qbUjJmpGLO/1qE5Q+DYebikaNa1ZZ8mikdj2Uu8ZD69R2tgrEL85lPMkikOaafDLtC9AUPTN018MrSloG8RRy6p74BviaUmBR240e2xyyBzwtlwxKpyHNeQRiV3pX2I4tviydphbhT19lrdr0Wo6Wqe42hRnPxL6VFvyFm+ezUW0SdVH1XU1gWTkwM5N0zRvV8XXm++3q9qcFSIpD/FjZokM+qf4+HIoK36v5PN6Ce2OK/g28FFHI+KwjEuEYfn8kmvMjqAerCgTGrKkGAdnF4p+CyFhYnzRDkl7wrJK43cQjYZhHEOdDBi+odaxJkuAZoMiRl8WIUXiC1ObX5KS0EZ3O5pGbAZ22HNoSfCf5b4mfCbUtyiXyncOG11+fIUPwbvT4efcEb+lAByTIC2gDyLCKvb+UgATFjxjcpIy+LkH+IOqh5S4R9tsOiDpCEHOuNHSatbCCu/JYrFlbVGDQ/bvBu+MjtoDzluy1a/3DxWNAPEfy5LEzKYG0Rw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(356005)(83380400001)(336012)(186003)(2616005)(426003)(1076003)(81166007)(82740400003)(316002)(47076005)(36860700001)(2906002)(8936002)(5660300002)(82310400005)(4326008)(478600001)(40460700003)(41300700001)(26005)(70586007)(8676002)(40480700001)(6666004)(70206006)(45080400002)(6916009)(16526019)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:14:03.6751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb711a1-0c63-4220-68ee-08dace60d087
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Tests need to tell if display is connected via USB4 DPIA link.
Currently this is only possible via analyzing dmesg logs.

[How]
Create a per-connector debugfs entry to report if the link is
tunneled via USB4 DPIA.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 2c43cdd2e707..461037a3dd75 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2639,6 +2639,25 @@ static int dp_mst_progress_status_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
+/*
+ * Reports whether the connected display is a USB4 DPIA tunneled display
+ * Example usage: cat /sys/kernel/debug/dri/0/DP-8/is_dpia_link
+ */
+static int is_dpia_link_show(struct seq_file *m, void *data)
+{
+	struct drm_connector *connector = m->private;
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct dc_link *link = aconnector->dc_link;
+
+	if (connector->status != connector_status_connected)
+		return -ENODEV;
+
+	seq_printf(m, "%s\n", (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) ? "yes" :
+				(link->ep_type == DISPLAY_ENDPOINT_PHY) ? "no" : "unknown");
+
+	return 0;
+}
+
 DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
@@ -2650,6 +2669,7 @@ DEFINE_SHOW_ATTRIBUTE(internal_display);
 DEFINE_SHOW_ATTRIBUTE(psr_capability);
 DEFINE_SHOW_ATTRIBUTE(dp_is_mst_connector);
 DEFINE_SHOW_ATTRIBUTE(dp_mst_progress_status);
+DEFINE_SHOW_ATTRIBUTE(is_dpia_link);
 
 static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
 	.owner = THIS_MODULE,
@@ -2794,7 +2814,8 @@ static const struct {
 		{"max_bpc", &dp_max_bpc_debugfs_fops},
 		{"dsc_disable_passthrough", &dp_dsc_disable_passthrough_debugfs_fops},
 		{"is_mst_connector", &dp_is_mst_connector_fops},
-		{"mst_progress_status", &dp_mst_progress_status_fops}
+		{"mst_progress_status", &dp_mst_progress_status_fops},
+		{"is_dpia_link", &is_dpia_link_fops}
 };
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-- 
2.34.1

