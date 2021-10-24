Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D106C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF4F600D4
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4AF4F600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B5C6E12C;
	Sun, 24 Oct 2021 13:32:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2C36E12C
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCkOZlbhvtRVEQICxfxJjvZpn6U3WeEIGuELFD8GgPlQ9Pb7hNYBTWtDcDKk21VCVV4KysNxAPmZa7COeJSFEKDYsVO/z/759vHwTRpXcSbxfa0Mfu2cqBo60vSEzOo8ehZQxUuAKZA0/OVmwdxC3apOM2bvyGgLqM1MTswPQgYHHzlSHQ0x4NGmvt8o8HCiizZluoool6bHk1nhgVdezcsqnKJ8tutmfWI7NSNzCrwdQGLkayg5oJw2kgU1PaImCaLwY8D3FyzuOO95JC9zS0n3ylUqdPkj2NkSyuA+3mmThCjCLKXUfzK6eve31kYr3Y2BLoNrs94PrNDNwuOxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PRYbzxSPSW27b67+HrxWmFOtz5lbjfNmLboMl5CUX4=;
 b=I0zYcj5VJd8gp1ucGphGodBIZbLMttP4y8U3c3OQvkZFpDaPnDGq2Jjvui5XIfBte1uZL3diXD1iyrRp/KHuiqCJw+YPQKgGjNVHdBS7D2sdGe3kFNPayxxMVm5IZQEURs7BfOoXvwoG08gSrUqCReBXbaUn96i4wlFuEXNIHTqUUCicMROcvqMPe20fyLBV8pVxRl7izrW9ZzaxWh0ND+gG1ri4icu7wA3dkh+x+IySpKpvlAdsHpWBSpbJvRSiJdccV/4iyneSK7a+IvwDv7DojFTWLnz4iDWScXPTzk+vo9BxpDDRq7z3EUaNADcKd6n49V9jQ+ptXLJjADM9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PRYbzxSPSW27b67+HrxWmFOtz5lbjfNmLboMl5CUX4=;
 b=22+W+oxtR+uZCBCpN33HzYiLWN1sCG6mwj9cGlrIt/uvEi6tgCHm99ESxy8m+wrmQlH5FZpOFQw3qot52+Sd74lgPPJC5PU2ZCMOLPTgZP46K9aLzNMYt2UEeYX15ZW5YrGhZgnm8dJL+TPxTIt+0SQpdwCH3IVOfEy79L28QEE=
Received: from MW3PR06CA0002.namprd06.prod.outlook.com (2603:10b6:303:2a::7)
 by DM6PR12MB2857.namprd12.prod.outlook.com (2603:10b6:5:184::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Sun, 24 Oct
 2021 13:32:47 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::e0) by MW3PR06CA0002.outlook.office365.com
 (2603:10b6:303:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:46 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:43 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Eric Yang
 <eric.yang2@amd.com>
Subject: [PATCH 32/33] drm/amd/display: fix link training regression for 1 or
 2 lane
Date: Sun, 24 Oct 2021 09:31:40 -0400
Message-ID: <20211024133141.239861-33-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9341c6a-d7c2-4b20-3c3d-08d996f2c45c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2857:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2857466E287B55C6324A093198829@DM6PR12MB2857.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHvpGe6TqgjdeVHNEVIZHQG7DBJHthJ8Uzzf5LTMS+b+SMxPNdss1uRn/OYVdhFooPTBiJZua2tM7B6N7yWnQEig/5zoTFOBWRwH8H3yc39tQtsTPERYcAsDRebnFQv6ZUju1k3Gpu7Nl+SvPwlB5MQ4neWbTrC43QcSkUS74BzRqj8WbWiYO5kv7qfg8ub8Q5195FMI56YzI1ldWmtEfuQl7WLxn/+gkXU/5JUZuAq0Q5YZR7Xygz6RFQ3yiyyl4lnfVYxAhAIHDnFe3sZvhmDYJqCs1+ihUeQ8J6wRUUqbsdHmA+fslZODh3hCmmgvhKGKoFKuuUUFXwH0AQvKeA9Osip3IksINxSpyBmQc9/U4erqVi/QhD+aT6LQ5IIT9fp1lTpC32jcefDo3IXGxSKo1re8byj/8laaQi/FnRtV9oYUBoF5IG0hl6m3q/iQCycBnA1J2Jjswi218aUZP+T/lOJ4HCBIT5bMrJD7vpdNuQFhokI5q2ZBJ20NtpMrhdhcRAoF4uEAnlQBK4R0Y2D5z00llC+wFx4XzQITvH0aobn9NjFkMbA7cACO3qJYw2rKWkzD7ksfySVc2Zk8nIW4jls7QEyudfnEeJrCR6SxpEYsGLZZpv4Ze6hfT9WmRZFyG+ykG+F2mG/2h/qlO8OAKGBVWPYMd2umwv9QdY8icwy1XdDj8PeF1RMFNV4+Txt83ndLb8ciiB+0SoCK2skkBarNWNgHuDNbpDzOcg8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(47076005)(508600001)(86362001)(316002)(54906003)(6916009)(1076003)(2616005)(8936002)(70206006)(70586007)(81166007)(4326008)(186003)(26005)(83380400001)(2906002)(36860700001)(16526019)(82310400003)(426003)(36756003)(336012)(5660300002)(8676002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:46.8747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9341c6a-d7c2-4b20-3c3d-08d996f2c45c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2857
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
We have a regression that cause maximize lane settings to use
uninitialized data from unused lanes.
This will cause link training to fail for 1 or 2 lanes because the lane
adjust is populated incorrectly sometimes.

Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 35 +++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 653279ab96f4..f6ba7c734f54 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -108,6 +108,9 @@ static struct dc_link_settings get_common_supported_link_settings(
 		struct dc_link_settings link_setting_b);
 static void maximize_lane_settings(const struct link_training_settings *lt_settings,
 		struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
+static void override_lane_settings(const struct link_training_settings *lt_settings,
+		struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
+
 static uint32_t get_cr_training_aux_rd_interval(struct dc_link *link,
 		const struct dc_link_settings *link_settings)
 {
@@ -734,15 +737,13 @@ void dp_decide_lane_settings(
 		}
 #endif
 	}
-
-	/* we find the maximum of the requested settings across all lanes*/
-	/* and set this maximum for all lanes*/
 	dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
 
 	if (lt_settings->disallow_per_lane_settings) {
 		/* we find the maximum of the requested settings across all lanes*/
 		/* and set this maximum for all lanes*/
 		maximize_lane_settings(lt_settings, hw_lane_settings);
+		override_lane_settings(lt_settings, hw_lane_settings);
 
 		if (lt_settings->always_match_dpcd_with_hw_lane_settings)
 			dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
@@ -833,6 +834,34 @@ static void maximize_lane_settings(const struct link_training_settings *lt_setti
 	}
 }
 
+static void override_lane_settings(const struct link_training_settings *lt_settings,
+		struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
+{
+	uint32_t lane;
+
+	if (lt_settings->voltage_swing == NULL &&
+			lt_settings->pre_emphasis == NULL &&
+#if defined(CONFIG_DRM_AMD_DC_DP2_0)
+			lt_settings->ffe_preset == NULL &&
+#endif
+			lt_settings->post_cursor2 == NULL)
+
+		return;
+
+	for (lane = 1; lane < LANE_COUNT_DP_MAX; lane++) {
+		if (lt_settings->voltage_swing)
+			lane_settings[lane].VOLTAGE_SWING = *lt_settings->voltage_swing;
+		if (lt_settings->pre_emphasis)
+			lane_settings[lane].PRE_EMPHASIS = *lt_settings->pre_emphasis;
+		if (lt_settings->post_cursor2)
+			lane_settings[lane].POST_CURSOR2 = *lt_settings->post_cursor2;
+#if defined(CONFIG_DRM_AMD_DC_DP2_0)
+		if (lt_settings->ffe_preset)
+			lane_settings[lane].FFE_PRESET = *lt_settings->ffe_preset;
+#endif
+	}
+}
+
 enum dc_status dp_get_lane_status_and_lane_adjust(
 	struct dc_link *link,
 	const struct link_training_settings *link_training_setting,
-- 
2.25.1

