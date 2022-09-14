Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA32ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D7D10E55F;
	Wed, 14 Sep 2022 05:13:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D4110E556
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqd96BUjalqvpYJI+TvBIqP1uTtPb5PGLpoYRWDkZ7E3qTrG94g5mYVkci6uFRlvgdbCZeq888Ookr5SPSxMMqlwnovOfye4A2ZQfT2jXga28L6Ta0LDt9sJM1wAWBta8TeWG5c3oZkOpQwwKPff1dWVi/kAFAiL6ovlKao2PyTuN+qHv7MbqroFs+H65gVnPQv2aTYSGNI07msjkwD1LDe8fBi9XHAQmB+wP4Lpc+ocbqqjjvTTuCiyn2vstSvb1Ba6D3/Ww8U1b1QB9CQ6ltF8O3y5Pz+vKQg0CA9OTfFbv+2sDuWfPYZsGbqo0s5iFjUJei8XPxahfyrDv+pQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxI/JHXzr5GZadyNViiN58V6lSDcbbOZdCxsdmfwu74=;
 b=PyMi2vPQICci4YVjp8zxyXuJtqwQQi7CWKNs/Ve9SnsTmNvDnSLMmqQavKAyLyJhTqR+mFr0ubgCzSrBBrzgC3433mA770T75isVqYIkGnuthJB6BNiqn+SIGUg2+Q9SUaZhdmNzdSAEyE9SnOruVJfsfryafnygMzaHBDEb4XcDtWiB6nXJlmsyFO3YoSv5Wmd3pTolMMhD24EmdtY0vz9vPKc/666AW/g7xu5mQuwVYhQVj+k+zVkj4dlu7kXVJ5nlCOWEhhNBp8a/zseiapTm0uF1To/CvxDaBf/xfzh9t5uFgjZRpkFyMsWyLtz/hmN8s2YJIX2R1FTksGXotw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxI/JHXzr5GZadyNViiN58V6lSDcbbOZdCxsdmfwu74=;
 b=okilErs/2WoHaW2RaNPsil7K8HXA5YdQjr/U7KAtgJ9bcj6EfS3UxtOBthjFGSxPaSrq2Owc9WUsALZq0ztsQHA204VpImWlIQGNWNVjW8odGwKyKyd1yCYTdQGSM6dlMZpKImbDXOxA1yErRy5CTpJ52rr7guF04V4LPdb328Q=
Received: from DM6PR11CA0057.namprd11.prod.outlook.com (2603:10b6:5:14c::34)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:13:13 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::51) by DM6PR11CA0057.outlook.office365.com
 (2603:10b6:5:14c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:13:13 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:13:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:12:58 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:12:53 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 09/47] drm/amd/display: Assume an LTTPR is always present
 on fixed_vs links
Date: Wed, 14 Sep 2022 13:10:08 +0800
Message-ID: <20220914051046.1131186-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: eec19d7c-fb3c-40f2-1b9c-08da960fd2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7NBlEGo9QZFNnyowACehC9BqYFoKzFvGlxZSsYzqAuBlI6XxauK7ASxfvBZIXtTNRYQzWsEXFV4WD83DPFsA3k5UUcwQeATcA8eQukVmstu02jmuiki3vUnQc6VG7N0oKCA638GWhlhRn4JNuFoTwgFci+YPCNJT1LMUqeyI/BfXEKFWWdHwAJyuBhg0mrInl1cNki9b4yILG/2WrLQc+orZUn7C2cbPECVxenswGUxF0VbJGcnEK2D0cPSYYjqFEWa9qYZSP2AGKv1jWJFLfwJETqFxw8rlksRcvhbgrQHspGNKB4/dSB2AH1CnScLK4gkgbXT8IoogTpKkwhby7xlnKzKXmuczP0CmkRp/v7itnirH1o8DoH32PruI44D5Q8gK8ajTgN1fVFo7e+JngQbmZ/kbb4suJ36zrHfKat/1wbFIepwpftewG1SzTDvz4qAKGttB5/JO1Bxs7ro6U3lgPZtiNrFl/eQAENt0j7Z47AU2exzD3GDjBwwyM6ekkMDjbw6t6yBCWp6WiiCRhXjX3Gv9My50jl8Q6uVfti9vEsM61tljgIso3+Z5gZkY6f9PkHRLCovJwMUO08WdFL7xx3OPs1smQjlJ32xuaiBNbAblefhQddwJdOObG4fpgQ48difUD7xWGXUntqzS5j8TO6aYEPiC9LMBBBUzskbcaKRp1169Saj1tmGEVb8qdAbcuH9pAfp9ZFoTDy3RU1Mg4MX/PVS12hmgKk3F89/drfn1xg3kRBtmfyPKv+oPkPreEKDSfOB+r1DZZrBk0Tl1LiKTMNrxTSvinD/Ay4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(478600001)(6666004)(47076005)(426003)(336012)(86362001)(82740400003)(54906003)(70586007)(70206006)(4326008)(8676002)(26005)(6916009)(2906002)(356005)(2616005)(186003)(1076003)(82310400005)(81166007)(36756003)(8936002)(316002)(7696005)(41300700001)(40480700001)(5660300002)(83380400001)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:13:13.3691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec19d7c-fb3c-40f2-1b9c-08da960fd2fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956
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
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
LTTPRs can in very rare instsances fail to increment DPCD LTTPR count.
This results in aux-i LTTPR requests to be sent to the wrong DPCD
address, which causes link training failure.

[HOW]
Override internal repeater count if fixed_vs flag is set for a given link

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 11e13c45a338..40bdf9708d76 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5133,6 +5133,14 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 				lttpr_dpcd_data[DP_PHY_REPEATER_128B132B_RATES -
 								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
+		/* If this chip cap is set, at least one retimer must exist in the chain
+		 * Override count to 1 if we receive a known bad count (0 or an invalid value) */
+		if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN &&
+				(dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == 0)) {
+			ASSERT(0);
+			link->dpcd_caps.lttpr_caps.phy_repeater_cnt = 0x80;
+		}
+
 		/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
 		is_lttpr_present = (link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
-- 
2.37.3

