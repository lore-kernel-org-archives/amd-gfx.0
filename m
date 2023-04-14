Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA21BC77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C75110EDDB;
	Fri, 14 Apr 2023 15:54:42 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CDE210EDDB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDFqumeUt4wRemKvMxur3Cr5zm+uWpF/XURQfj6LxRtgFuMLCI5Zy+Ecs906pZkZSsGoXiLLGp2xi8g8hzqaH973dylOyBvDLxQQDFebO0dWV2o2w2JjkTAEgixCvnIlVbDLCfrLLVYWU8L7i9QVNwOKUq4Kf1xXse6fOiXJprc7+bi7CsZwriN0gQApFZIzYp02RnRL3XFZaBzIQs8SWfI2eQaoPQViwS11KkoZbj7QGIkFshEgsPP59D5xAwq7ZbFcRZgz6/uqyL+vi/uD6wslw0u95tC1Zu2nvkwuO6t8zxj3poexHnGUA1Ymgj7CIqN1uORYeEL3zCxMy+qrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fs3j8bZNuzPcf8EwY5lo8gWGMOQwNBtIa3lbUXxqHA=;
 b=CdeLyYuUn7Yvvyinj69OERCBJn3cBfzyKCLZ/zt8zOQe90pr0TnrAe2sUTQNhhal1PES5KdRiyx04K7gpVnC4PUAq8rxxw2DFBOKzgGyVR5kqikraLjygJiJga1KTtEr6vElqy7fKEeC/44FcwaU5aSW/SVVp/WhqGsEbcIud5jVnZnW/NvZQbStPzoVXE24yCMWG2CDHgSkXycUWF7Re0/CCMnmkpBeQujIIOPUBM6bJEO83b1AJ9JHvRh9j/7Fn8aCwFmmgsTzWsXEG/Oaa6tRoRixj9bsQKyCE9d4QXinCKMJCPl8XPIAmRjJ9rBcQg3kjC6ZMAgJGZD+00rzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fs3j8bZNuzPcf8EwY5lo8gWGMOQwNBtIa3lbUXxqHA=;
 b=NgZNruExkmabtJFfSXOFhexbbXf17ljGKfl9IjexKgwGpIF42AoQWzsfTk+B+RGaMX2UR4h8TuKj1EexxdP6btYXN/bYihH7LUoinyycKRpCq1LmuQr+9r2JdpKgZJwOQD6C7I/w5UUSm3uXS/UjcE9P/eBx0Quj7Uc+Dq3GhPI=
Received: from BN9PR03CA0735.namprd03.prod.outlook.com (2603:10b6:408:110::20)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:38 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::75) by BN9PR03CA0735.outlook.office365.com
 (2603:10b6:408:110::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:54:37 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:36 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 34/66] drm/amd/display: Improvement for handling edp link
 training fails
Date: Fri, 14 Apr 2023 11:52:58 -0400
Message-ID: <20230414155330.5215-35-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 849193ea-6bc9-4b5b-4fb1-08db3d008d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNg79nDTW5HO77oyFTO3ohEiwM3+lrs/6T/Ch00jGxaP2nteQ5AY6OC3EYcYvP87ImQFoMzTZ0SidKDa4Gryuo/imucuW0Gk4+EpeK/UtAcoOKRrsxbXVUlj8XhFG6cHfDci6i2HiL/uwg/12/uE5HmWL1hIEy4N3gzIX2PBxcLSc7rUcS6lR7aNlPVLHM0RS3pBeK3qQXOiw3ydPu2vV2CLAU4qxIuHBErC8rzqFzGiSbkbmfgBHe35Kd2mXFZiS8LmSbSG9OGNNwAHWp8wLf1Nnvw3yl+wugr48aZXh5fr8C+W++1jUCLkRo6sDckyFbednmKlQzMz7jPPDNg+51dwNHZyCzi4hhzTAxZ0J/VIsaDxzapXcB/mD9qBu6Z6SA7sn+UYJqozNNa0EuXUiI3tQDWJaWrG9q9AGA4WYY0pzE7mOO4VUyB3bcVAOZ3zGLaJ8a8mDd31Iw4SjR7kag54XD6kffIQsaTe4MnLYYE4sojs+54Y5K53HSRd7vquUY+ylc7dFQ1jb3vfumGlLmwwnEJhMh+SKT7FTkn2nqdYoqptUFZPZ2dr8FZjjCfrXU0ZvZMiKZj+cMtN0CFgtfilS3vQrZGZsx8WOJvN27vfCcpzdLM5YxT8rp6ZJkExUzpkE1/q3PjOq/YrixMTCm+zJ63I7Qz70LNfx/XQnNY+ILscdU7+21xOQgXv8b9+Mfg/LT4eEQ3CPlGAdiLV/+GK8HSF0WrkFSp4+H/xfrE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(54906003)(40460700003)(478600001)(356005)(81166007)(316002)(82740400003)(41300700001)(8676002)(8936002)(5660300002)(70206006)(4326008)(40480700001)(70586007)(26005)(36756003)(1076003)(426003)(336012)(16526019)(6916009)(36860700001)(186003)(83380400001)(6666004)(82310400005)(2906002)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:37.9481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 849193ea-6bc9-4b5b-4fb1-08db3d008d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Jingwen Zhu <Jingwen.Zhu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jingwen Zhu <Jingwen.Zhu@amd.com>

[Why]
The eDP retrain will cause the DPCD 300 to be reset to default.
And cause the brightness can't be set correctly.

[How]
delete the call to edp panel power control in both
enable_link_output/disable_link_output entirely and
only call edp panel control in enable_link_dp and 
disable_link_dp once.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Jingwen Zhu <Jingwen.Zhu@amd.com>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 19 +++++++++++--------
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  5 +++++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 9fe0ce91db00..8d2460d06bce 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -3031,10 +3031,12 @@ void dce110_enable_dp_link_output(
 	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
 	unsigned int i;
 
-
+	/*
+	 * Add the logic to extract BOTH power up and power down sequences
+	 * from enable/disable link output and only call edp panel control
+	 * in enable_link_dp and disable_link_dp once.
+	 */
 	if (link->connector_signal == SIGNAL_TYPE_EDP) {
-		if (!link->dc->config.edp_no_power_sequencing)
-			link->dc->hwss.edp_power_control(link, true);
 		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
 	}
 
@@ -3096,11 +3098,12 @@ void dce110_disable_link_output(struct dc_link *link,
 
 	link_hwss->disable_link_output(link, link_res, signal);
 	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
-
-	if (signal == SIGNAL_TYPE_EDP &&
-			link->dc->hwss.edp_backlight_control)
-		link->dc->hwss.edp_power_control(link, false);
-	else if (dmcu != NULL && dmcu->funcs->lock_phy)
+	/*
+	 * Add the logic to extract BOTH power up and power down sequences
+	 * from enable/disable link output and only call edp panel control
+	 * in enable_link_dp and disable_link_dp once.
+	 */
+	if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 027ad1f0144d..2267fb097830 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1927,6 +1927,11 @@ static void disable_link_dp(struct dc_link *link,
 
 	dp_disable_link_phy(link, link_res, signal);
 
+	if (link->connector_signal == SIGNAL_TYPE_EDP) {
+		if (!link->dc->config.edp_no_power_sequencing)
+			link->dc->hwss.edp_power_control(link, false);
+	}
+
 	if (signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		/* set the sink to SST mode after disabling the link */
 		enable_mst_on_sink(link, false);
-- 
2.34.1

