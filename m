Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB49C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7EA310ED5F;
	Mon,  7 Mar 2022 05:51:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C2210ED5B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMTq94h4LiX6vytMeJU2MX9u8VHOcmui6CUyfX2nR6OOmgWz3hE800FMHPgxcQk7S/vc2AuVQcs5giTMWImFbLtc/YmJ7OU6oKabrIxkMady69nrnpiL4cbRMLlJ07MSDXS8FrYOmA3Ez/1aKEKHjQR2Osh11jxVXZYCvZboApNqRo36kEl8peW03yw3CrYF9jnzYufaguekzJPGV8OZqdY1jx9NiIISVaBvuFIBk/KgC1Sasty/va4s/dfaEILtz/PZKB5MBBDJGAhkH1wVv5GIAZEOlTIhwmtBjgxIJA0xjpH704g/r5PpyfM0oCK1VrYO742FeLRGEql5BN4Sbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+t2zfg0sh2ygwsRd9jUl6rtSOqRZHGRG/tpYiWVN8g=;
 b=Q8sWTZd2z2wnOYzJH4RcTrFzzLxiWNuXLjH3nkqMOcNF0vnuUnWXJHSfsGhYJznjyEq4A583GfykMh9HHS9oTxdzq26CcWgeivEQnBfRqFmU+u6OUb1BGJxze4bIPM5AXtxSfLZjYSgWVC0tRTRMDcpdHxk90dL5SJhyy8uTaGK34TUBn6IO7Nmvo7/6iy/lDUI232F3rNUMppymqu9Hdnxgml6ZEgjOQzdkMjvL5Q6zLnfyixEk7tOoun2n5DZ8rIyw5qVX32nSsY9SMPxWrJOHG+apzy2R1+8l74pn8LEF4bO2yYxAHcvt6ZApIucwqS9DXbrXcKv0FSVcsUeICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+t2zfg0sh2ygwsRd9jUl6rtSOqRZHGRG/tpYiWVN8g=;
 b=DbjCiay7+WFZBq7L7eP9Nfy/C0pJ0K2g0hBru2MqpSDvRZNuAttrtoVckJckBlH32l6aJEmzUB3lWxys5zNAzf3HoXN1gh0OwRK1sy20wSpE3AxCIs5X4fwfJLfLbwijcrnFOewQbl/FuIa+zvVo1DFnVvCj/AjSyLfWP/7s2Z8=
Received: from DM3PR12CA0047.namprd12.prod.outlook.com (2603:10b6:0:56::15) by
 BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 05:51:14 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::5e) by DM3PR12CA0047.outlook.office365.com
 (2603:10b6:0:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:51:14 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:51:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 21:51:07 -0800
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:51:04 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/21] drm/amd/display: handle DP2.0 RX with UHBR20 but not
 UHBR13.5 support
Date: Tue, 8 Mar 2022 05:09:35 +0800
Message-ID: <20220307210942.444808-13-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b95c1bea-3aaa-4c6b-b99c-08d9fffe7d8d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5177:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB51773D8FF53397425CA17723F5089@BN9PR12MB5177.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZRkgy537pmoeQ4GXYlG+FjiYaBB8vlXReb/TY8IydRvPJzXIDGv4VZob1DTuoNyzM3dOCsJldQLG0Om0nu++29Ig/igvh+V/vdQggUjtkrVZAOrAXuYHTuuA4lDOGCGITBZwncmV0k86M6uNtMzvDF+yh6v8l0GW8TU40bPHN4AonDfoov7pfROVqZpmZFp4O5Mc9WOcmK7RTAutRtdCM8hIzm1Czla5LvkRIOECkZ6iusGmwE8Qj0lGsAWgX0gNUugRVxH4gNPA6NMIx5/v/O6lApItFFtq+uTUPf9EqcgGQMYCwPbd3eb1kuXD+/wpCnLhX84JN7lhagvtB0o/3ErKrI58GzLl172hfj2aKB+ajtoMsjHPKW9QVXuHlsKTxOqrm/pPMgYyFDHlNcg+XCuv7eiXwD4h4yC/pRcULxpkR2omgFFk1pPrpRoezX4FUxGnbaYR96JEdbNRSaE++hg80xL8fZpLuU6W3SsL1RK0C46bTm6kylEdxGb9CNxdS1u8/cfeZ0TAHq0n3vy/dFID0gZ2el8gE6qdntS/ZNRai/0LxU8s8IbT+yvplxyMBcV8sZQFH1c1J1sERw2AGixY51I8KsIflXxDeivhXWtz6302MuqA9NgWuCZKJxuR57Hs+7r8NuJ9sCAM+hb14CGpjjbYjQSZ5efvZpBesae8qit2ZuUlO7UaOYOo3JOpLGnFYHYQ9r0k5829ZPRTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(86362001)(36756003)(47076005)(83380400001)(2906002)(40460700003)(356005)(81166007)(7696005)(70586007)(70206006)(6916009)(8676002)(4326008)(54906003)(36860700001)(6666004)(508600001)(426003)(5660300002)(336012)(186003)(26005)(8936002)(82310400004)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:51:14.1914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b95c1bea-3aaa-4c6b-b99c-08d9fffe7d8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
DP2.0 defines DP2.0 RX capability using bit maps. This means there is
a corner case the DP2.0 RX can declare UHBR20 capability but not UHBR13.5 support.
In this case we should skip UHBR13.5 selection and continue to our next option
in decide liink settings.

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 49 ++++++++++++++-----
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 0e84c54dc67e..7d88165e8fa2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3470,7 +3470,8 @@ static enum dc_lane_count increase_lane_count(enum dc_lane_count lane_count)
 	}
 }
 
-static enum dc_link_rate increase_link_rate(enum dc_link_rate link_rate)
+static enum dc_link_rate increase_link_rate(struct dc_link *link,
+		enum dc_link_rate link_rate)
 {
 	switch (link_rate) {
 	case LINK_RATE_LOW:
@@ -3482,7 +3483,15 @@ static enum dc_link_rate increase_link_rate(enum dc_link_rate link_rate)
 	case LINK_RATE_HIGH3:
 		return LINK_RATE_UHBR10;
 	case LINK_RATE_UHBR10:
-		return LINK_RATE_UHBR13_5;
+		/* upto DP2.x specs UHBR13.5 is the only link rate that could be
+		 * not supported by DPRX when higher link rate is supported.
+		 * so we treat it as a special case for code simplicity. When we
+		 * have new specs with more link rates like this, we should
+		 * consider a more generic solution to handle discrete link
+		 * rate capabilities.
+		 */
+		return link->dpcd_caps.dp_128b_132b_supported_link_rates.bits.UHBR13_5 ?
+				LINK_RATE_UHBR13_5 : LINK_RATE_UHBR20;
 	case LINK_RATE_UHBR13_5:
 		return LINK_RATE_UHBR20;
 	default:
@@ -3491,12 +3500,17 @@ static enum dc_link_rate increase_link_rate(enum dc_link_rate link_rate)
 }
 
 static bool decide_fallback_link_setting_max_bw_policy(
+		struct dc_link *link,
 		const struct dc_link_settings *max,
-		struct dc_link_settings *cur)
+		struct dc_link_settings *cur,
+		enum link_training_result training_result)
 {
 	uint8_t cur_idx = 0, next_idx;
 	bool found = false;
 
+	if (training_result == LINK_TRAINING_ABORT)
+		return false;
+
 	while (cur_idx < ARRAY_SIZE(dp_lt_fallbacks))
 		/* find current index */
 		if (dp_lt_fallbacks[cur_idx].lane_count == cur->lane_count &&
@@ -3509,11 +3523,22 @@ static bool decide_fallback_link_setting_max_bw_policy(
 
 	while (next_idx < ARRAY_SIZE(dp_lt_fallbacks))
 		/* find next index */
-		if (dp_lt_fallbacks[next_idx].lane_count <= max->lane_count &&
-				dp_lt_fallbacks[next_idx].link_rate <= max->link_rate)
-			break;
-		else
+		if (dp_lt_fallbacks[next_idx].lane_count > max->lane_count ||
+				dp_lt_fallbacks[next_idx].link_rate > max->link_rate)
+			next_idx++;
+		else if (dp_lt_fallbacks[next_idx].link_rate == LINK_RATE_UHBR13_5 &&
+				link->dpcd_caps.dp_128b_132b_supported_link_rates.bits.UHBR13_5 == 0)
+			/* upto DP2.x specs UHBR13.5 is the only link rate that
+			 * could be not supported by DPRX when higher link rate
+			 * is supported. so we treat it as a special case for
+			 * code simplicity. When we have new specs with more
+			 * link rates like this, we should consider a more
+			 * generic solution to handle discrete link rate
+			 * capabilities.
+			 */
 			next_idx++;
+		else
+			break;
 
 	if (next_idx < ARRAY_SIZE(dp_lt_fallbacks)) {
 		cur->lane_count = dp_lt_fallbacks[next_idx].lane_count;
@@ -3542,8 +3567,8 @@ static bool decide_fallback_link_setting(
 		return false;
 	if (dp_get_link_encoding_format(&initial_link_settings) == DP_128b_132b_ENCODING ||
 			link->dc->debug.force_dp2_lt_fallback_method)
-		return decide_fallback_link_setting_max_bw_policy(&initial_link_settings,
-				current_link_setting);
+		return decide_fallback_link_setting_max_bw_policy(link, &initial_link_settings,
+				current_link_setting, training_result);
 
 	switch (training_result) {
 	case LINK_TRAINING_CR_FAIL_LANE0:
@@ -3698,7 +3723,7 @@ static bool decide_dp_link_settings(struct dc_link *link, struct dc_link_setting
 							current_link_setting.lane_count);
 		} else {
 			current_link_setting.link_rate =
-					increase_link_rate(
+					increase_link_rate(link,
 							current_link_setting.link_rate);
 			current_link_setting.lane_count =
 					initial_link_setting.lane_count;
@@ -3813,7 +3838,7 @@ static bool decide_edp_link_settings_with_dsc(struct dc_link *link,
 				/* minimize lane */
 				if (current_link_setting.link_rate < max_link_rate) {
 					current_link_setting.link_rate =
-							increase_link_rate(
+							increase_link_rate(link,
 									current_link_setting.link_rate);
 				} else {
 					if (current_link_setting.lane_count <
@@ -3834,7 +3859,7 @@ static bool decide_edp_link_settings_with_dsc(struct dc_link *link,
 									current_link_setting.lane_count);
 				} else {
 					current_link_setting.link_rate =
-							increase_link_rate(
+							increase_link_rate(link,
 									current_link_setting.link_rate);
 					current_link_setting.lane_count =
 							initial_link_setting.lane_count;
-- 
2.25.1

