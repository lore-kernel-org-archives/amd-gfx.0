Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB54C04A94
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1BA010E2D7;
	Wed, 16 Aug 2023 06:07:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA6110E2D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwVXYG1rj/UImFOLdg6b45pjngIDxr7qbn1vVid7OKi1xHkNGlkCYtsDBEMCTq+l2ydzdfgSQi5FOl29e8N6ZPVE36WKn0IbtOW6bHr5ATNaPkyDT+UOUv7w2xqqsOI5X6qKDOwxE7YBPcASySrqR028KoXOl4D/s+sNExhSaKqBJY+QIbzdB9fxU31q/OSYt0bLAIsXn4JePPG8cOJPsB/5p+XlNJsCWqkv4O2t1qIIrDJLuB/1FlzAsWFGbMwklM3WQKk//XE2DUGgaiD/w/AiTfBRKEYyculg4kgrP/uNOkrh66SqjoVx6GKhXEUc92XZ63OFPrYAqDDgyV3pLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJg0r4/is7hb8k9KIEHbmwee6eQLx6gDT9SGpQPLntM=;
 b=iOx5AutZFPAEeTVLTHq5GsCHg6pO6QRoDqAv7ULhjsP6qp2+Ac4xglNxuLJ+92OFpzsdsZa0nhSyQo2CcIky29UcwGSgTCAVZLXrTHIbyA09h6R9lxxuQ/tj7+AdnizO2xHb2orIk14j6HVt1u5XJ4Bz8oXRWFFlxBotYatfjTb5G6ic/ZL9u4ohHs/t4/34j8lryAq70LZJFFmPx6OxvAqbmUsO1u32fC5rURL91bdmxjjXJC0Ue6THZo42sAuZgHpvF5d28cFPlbSMSY6Q+grqPmzggICfyWiYPe68WvpGm3o95tDr8Q0Z9lNbq4rL17mI1wAfexexiFjwYgn8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJg0r4/is7hb8k9KIEHbmwee6eQLx6gDT9SGpQPLntM=;
 b=0R/DqtVkDfHq4XVAPcRC26+lMt0GH8NC5JGt9FjuHtgUWWy2GBxouHiw5YsnGJDKMqsRqLMg1qLFi2DEYeQh8pJNysqoHi7ooL/582Ylv+6gbtfaao+aVZ09QQRBG+beHp9YrDwyRFws4jeOKuKUjhDT9jvUqPJxqV+/PKwUsBo=
Received: from MW4PR04CA0323.namprd04.prod.outlook.com (2603:10b6:303:82::28)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 06:07:24 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::40) by MW4PR04CA0323.outlook.office365.com
 (2603:10b6:303:82::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 06:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 06:07:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:07:22 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:07:12 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: Expose mall capability
Date: Wed, 16 Aug 2023 14:06:43 +0800
Message-ID: <20230816060658.2141009-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: f09c949c-811f-4ac6-b1f9-08db9e1f0f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: waG6NuWyyOglTlin3Cz+U4mbub8CL7PyEhs5lnAwme65DmoQQfgm8ZrhpUzidkD4Mq4by+Bk3tT8wHQhNmDVNwzgsw2ENCdsMt4z2f4JbamohVxEAQkUd/T+yINP34+B6t2JahtbNak61WYS8H+fIlI5j6kzd7I4TdLCFggePSb3AISoEPtPOT1+OKk7RihSNyg2jhBmk89Z2nkWuKR3D+hFAXCoeLzVzz0kgfJPdzf97zxy1T/BXbbo3rGdERfnKhW0xJis1vvWhpaC4XY9+FhOMUEXB7F2zNKhvtHw3mDd58LTHe+EG3e0mkH7Q+48WshRYk5pfzpPrZQ8xCh6buTXPJBHcHDXqcovF/iQMg2cp8m192jggb91HArUllLntAX9HdSDibBUHMTgyrlz9ol0fU3Z3eM/QvirXX00sH/D6Z9zzVGH6PRuxFOyg5gnXinZDA3+di79Cx9qFYPbCz0X9kKtmwfdm8CbdQqtFF7xfSteTd996f1ZZDPFaEGDOPmSaTXEduLqlSeGDwZbbaRfR6+E2c9WA7i+Zm+KZTptIOTKEM+Xxq/Q4kGXPyW/KcN0Y4fEqpslOHx1Q4AjjTW7BASarl8rdELeXVjN8ZjgS7DXcgi7+CnRz70fTgq4+MOvmKA9Alj4bokYcPPG2oz/7pgyNZHlH8cMZeqSsnEd67LMilfVYj/3uiBcpBq/+qbdhxQnPrIkySbn6XoGaE2gFAbMQwcn50Gj4oy7rwLdd+vTXclsf17tM0WwyhA8yrjYcrSDMWNegupqcmm9Fg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:07:24.1279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f09c949c-811f-4ac6-b1f9-08db9e1f0f67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Export a debugfs file to report whether MALL cache is supported by the
asic or not.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 7c21e21bcc51..b5f3b33b625d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3605,6 +3605,23 @@ static int disable_hpd_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
 			 disable_hpd_set, "%llu\n");
 
+/*
+ * Returns 1 if hardware supports MALL cache
+ * 0 otherwise.
+ */
+static int capabilities_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct dc_caps caps = adev->dm.dc->caps;
+	bool mall_supported = caps.mall_size_total;
+
+	seq_printf(m, "mall: %s\n", mall_supported ? "yes" : "no");
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(capabilities);
+
 /*
  * Temporary w/a to force sst sequence in M42D DP2 mst receiver
  * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp_set_mst_en_for_sst
@@ -3798,6 +3815,8 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 
 	debugfs_create_file("amdgpu_mst_topology", 0444, root,
 			    adev, &mst_topo_fops);
+	debugfs_create_file("amdgpu_dm_capabilities", 0444, root,
+			    adev, &capabilities_fops);
 	debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
 			    &dtn_log_fops);
 	debugfs_create_file("amdgpu_dm_dp_set_mst_en_for_sst", 0644, root, adev,
-- 
2.37.3

