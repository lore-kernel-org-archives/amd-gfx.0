Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E13AC6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F142B10E4F7;
	Fri, 24 Mar 2023 06:53:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6626210E4F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/dHjjEN0t24tg75+JYLCBX1jyE02/QBoGzUY1sOqIygrUfEZL/JPC5jSYBTKqBRr0V4fncdIMI3FzFi/kdj8AiuSJl3ZJt/WEAvhiCN1lsWCxOj9gfyK8P7Dz4kOFQjdW5luHBixlD8uy2R416zVyVRpmmMk95nrjCIpFgHdi6wG2RismFkCNjX0f2GLzll2rIxOcucQZZ0zMwDNQ5i6mQWQyKm3pKbtH3u2Vsz3M82rtqaQE4MeYAO6ljWV5KoJQWMebnc7QjeMFw2qvAWmJ8/peqvhEz2yr0H1GVYZ9U6e2sTBtuB2XbA6anT/h61OD7L02lBjlMsvbNPxjdAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDJh3zFIrNnVZxmEURPG/Oyma0wonjt02LZ3QwZW7Bc=;
 b=ZyA+6dnD50/lBGWcMuNlx11ol0Y2hnMU46P41TsPpEcw4g37DDU5RaZ/9aOY6tRpU4CxmhP/A1KFRuzKJl+zy1XOxvNZXGkyRhbX/GwjcewhFhzXL7VxrzAJdI5TG0YBvLd8D1Jcfm+HHTGTOWY4huczz6Uo2+ss41SF0lcJpiFopiVvWvof8XeGW7Lr1rQVgV2zpTPj6UY6CQW5UAUzOH7Vt5ZZ9Ziz4oq2AXoW/t8TQ3YSwN5/cdnTvLU0a208hAEjuvmc5MwlD2DjoHxqPrmUwx8bGQ4sTkaolvR1OIuEconocJHHYHGL8Km0zk5G0WXUahPgw8ctCNiITpsu+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDJh3zFIrNnVZxmEURPG/Oyma0wonjt02LZ3QwZW7Bc=;
 b=l5z+4q4vORqJEZToSUY7OhUeHhmtz0ZWfu9PesqO6HbFNgAZFa0b7AQxsj2hjG0bEjYT9dD5JGlncHuilOJ4v164QS/vXKJ8oQt89v5PD6kl4gaasMYiFFYnB9x7sj+ZK7N7jZkEpJcGL31TWesYFbIIoWBFy2L5lk4yjodOGfI=
Received: from MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48) by
 SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 06:53:02 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::b) by MW2PR16CA0035.outlook.office365.com
 (2603:10b6:907::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 06:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 06:53:01 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:52:54 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/19] drm/amd/display: Conditionally enable 6.75 GBps link
 rate
Date: Fri, 24 Mar 2023 02:51:05 -0400
Message-ID: <20230324065111.2782-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|SA1PR12MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: c65be370-93bc-49a0-4f8e-08db2c346958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: po8eIAphLrs+nxTKbq0AoLtjbtslLNyYO90TZh3TdRs6iJc2Su6mH6L1PVG8GTWq3WGTdoemVwQShSgXQhHSEXD+l+HTSW3EWQ4DMZIMd/sfPc8h8SBOnPMlfSMpnRxgTBLI9G7aoi6cNe9rVfl9PVLxw4Z/TqsdqlhXsikawjsApHldoKO48tj5j+OMJpF/EE+l+g24uOTz0n9zKoBB7QD+KGAAzyB55w0TkUCmJJCS01xiFwuCab0w3SoHTPOa2D+U9lF/9YZnpj+UzYWMbqF0OWwQNBcrDAxbTVJ8zqaIcQBTdi6WeY2rRB+2D4ZxkISwZsnjvaLGbAC5TfebKwJim1mBERDL3VlakmIJOBUfHsDbLZHqJGaN4pEFCt2EopoHiXxYHSt+QWB0Ix4pGRdxDEPDtk18Ms0b9kNY7zlymJ7jZR3LTaHB2GiSzzj8jgRXX+UHR//YbcmT4XHSDCss8XrZxp9VOAu2mJntrRoS4XEJ2Qd5e4PqLziDW5URku6Plxy8PNYyzmYJs+xBhl5yluICKLNgUrUpCB8+wqwRT2Pj/hjZebv6/RTvpamCNsG4h7w4i2/SRmF+ly1MTPpcGkyCzPL+cLAJ84zdjmqwc/tn0HKzd+iMsTwXxANhV3LoQckM3yFCryt9Cgfdfu4xZNhgX8kxUhpZxKCI3zT8qdl66wwEvrJ3z6CwfSiWUXym3SDL9yj4T9jakzrnSs8DRjBP5JT5BB1anRAoIXg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199018)(36840700001)(46966006)(40470700004)(66899018)(40460700003)(4326008)(8676002)(41300700001)(8936002)(6916009)(44832011)(2906002)(82740400003)(86362001)(356005)(36756003)(36860700001)(81166007)(5660300002)(1076003)(316002)(6666004)(70586007)(47076005)(70206006)(2616005)(40480700001)(82310400005)(426003)(478600001)(83380400001)(54906003)(186003)(26005)(16526019)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:53:01.8967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65be370-93bc-49a0-4f8e-08db2c346958
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8697
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
Cc: stylon.wang@amd.com, Artem Grishin <Artem.Grishin@amd.com>,
 Charlene Liu <Charlene.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Artem Grishin <Artem.Grishin@amd.com>

[Why]
The 6.75 GBps link rate is part of the new eDP specification
version 1.5 is going to be supported in the future.

Since this standard is very new and there are no existing 6.75 GBps
panels on the market yet, we should put a condition in the driver
on enabling this feature until we can validate it with real hardware.

[How]
- Add boolean flag support_eDP1_5 in struct dc_debug_options.
- Enable the 6.75 link rate in reduce_link_rate(...) only when
  the flag is true.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Artem Grishin <Artem.Grishin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../dc/link/protocols/link_dp_capability.c    | 23 +++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2d2621abf012..1b77d50cfd89 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -874,6 +874,7 @@ struct dc_debug_options {
 	bool temp_mst_deallocation_sequence;
 	bool override_dispclk_programming;
 	bool disable_fpo_optimizations;
+	bool support_eDP1_5;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 7d7edbb2cf52..c840ef17802e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -447,8 +447,12 @@ static enum dc_lane_count reduce_lane_count(enum dc_lane_count lane_count)
 	}
 }
 
-static enum dc_link_rate reduce_link_rate(enum dc_link_rate link_rate)
+static enum dc_link_rate reduce_link_rate(const struct dc_link *link, enum dc_link_rate link_rate)
 {
+	// NEEDSWORK: provide some details about why this function never returns some of the
+	// obscure link rates such as 4.32 Gbps or 3.24 Gbps and if such behavior is intended.
+	//
+
 	switch (link_rate) {
 	case LINK_RATE_UHBR20:
 		return LINK_RATE_UHBR13_5;
@@ -457,13 +461,22 @@ static enum dc_link_rate reduce_link_rate(enum dc_link_rate link_rate)
 	case LINK_RATE_UHBR10:
 		return LINK_RATE_HIGH3;
 	case LINK_RATE_HIGH3:
+		if (link->connector_signal == SIGNAL_TYPE_EDP && link->dc->debug.support_eDP1_5)
+			return LINK_RATE_RATE_8;
+		return LINK_RATE_HIGH2;
+	case LINK_RATE_RATE_8:
 		return LINK_RATE_HIGH2;
 	case LINK_RATE_HIGH2:
 		return LINK_RATE_HIGH;
+	case LINK_RATE_RATE_6:
+	case LINK_RATE_RBR2:
+		return LINK_RATE_HIGH;
 	case LINK_RATE_HIGH:
 		return LINK_RATE_LOW;
+	case LINK_RATE_RATE_3:
+	case LINK_RATE_RATE_2:
+		return LINK_RATE_LOW;
 	case LINK_RATE_LOW:
-		return LINK_RATE_UNKNOWN;
 	default:
 		return LINK_RATE_UNKNOWN;
 	}
@@ -586,7 +599,7 @@ bool decide_fallback_link_setting(
 	case LINK_TRAINING_LQA_FAIL:
 	{
 		if (!reached_minimum_link_rate(cur->link_rate)) {
-			cur->link_rate = reduce_link_rate(cur->link_rate);
+			cur->link_rate = reduce_link_rate(link, cur->link_rate);
 		} else if (!reached_minimum_lane_count(cur->lane_count)) {
 			cur->link_rate = max->link_rate;
 			if (training_result == LINK_TRAINING_CR_FAIL_LANE0)
@@ -608,7 +621,7 @@ bool decide_fallback_link_setting(
 		if (!reached_minimum_lane_count(cur->lane_count)) {
 			cur->lane_count = reduce_lane_count(cur->lane_count);
 		} else if (!reached_minimum_link_rate(cur->link_rate)) {
-			cur->link_rate = reduce_link_rate(cur->link_rate);
+			cur->link_rate = reduce_link_rate(link, cur->link_rate);
 			/* Reduce max link rate to avoid potential infinite loop.
 			 * Needed so that any subsequent CR_FAIL fallback can't
 			 * re-set the link rate higher than the link rate from
@@ -624,7 +637,7 @@ bool decide_fallback_link_setting(
 	case LINK_TRAINING_EQ_FAIL_CR:
 	{
 		if (!reached_minimum_link_rate(cur->link_rate)) {
-			cur->link_rate = reduce_link_rate(cur->link_rate);
+			cur->link_rate = reduce_link_rate(link, cur->link_rate);
 			/* Reduce max link rate to avoid potential infinite loop.
 			 * Needed so that any subsequent CR_FAIL fallback can't
 			 * re-set the link rate higher than the link rate from
-- 
2.34.1

