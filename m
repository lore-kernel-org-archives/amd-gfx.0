Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20432C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97956113FB8;
	Fri, 10 Jun 2022 20:53:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15879113FB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKKuaLFi2itDvhy5rmNXH3Kbvg2sNVwnieYWrg+y+d6XowdPxRp+xjYoeD1Nlpb9aMppPO4WeDD7a5BDWoYSjYDnqs0rGstag/Z7A4ishJcrejFz9okfvVQ2NkCQDVCWtKNtLEzJRXVay8bPnOyZra22toQNvDAnKMs47I1MCRRptw1n/wK2TCXQ7079HR1nKuBP2qZDyiAgUxouatWJS/ABD/lE118fNIa8RNf4evI7w89ZIAp3Le19pebvqPD2vCctNhOuUytdH43llSh1s66ARL3vYwztb+LwEr6wkYJkyitdUdigUE7V4GZ/uxlK/ddXWo1uAHvJWeONLhE3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcduLYrlbhCdkj2xZ1FzjUAxZan+2rEIG/Q5sZgUzj4=;
 b=LIcljUi9jRdN/0iN9TKi/O64WCmElTzQyLpKkXXzHCxk+ychcdqElmfPxQJTJ6SY6RQQ9/hxp7OncdRINNOx0zY3HmRuN1W6avd3qcW9xKgkqPgqFYz2xCfOsxfAzmTLf+OX6f2LiGWImPTGQn1YLIj3xBsEgRl+npGNEcneS9ANccQVjRx7g0iyfe3wsnXvWkztDSfpYv2nWp/JnjE1wgEZOV+lVHOCtU4t3IjGx0RFs2036rPUpfLXlxZtTuGqB8PZ8YcLY9lGOG1AaO6dFJ/m0IF7EvMni+j02XVBc0VMruJnmk8BCoNCXKufBm/igBwttdCh/pqrpEssCNgeag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcduLYrlbhCdkj2xZ1FzjUAxZan+2rEIG/Q5sZgUzj4=;
 b=0nK2/jHXsJeXlVL4ZkG+Buym2a8oElFZOd5c15yQ+abHC9T2ZnvOIZ9lSh7hF25gpU1+QiJr99lYzq0bhtFB3HIPqm1IxnFjYz/RHYjvo7LN5+c/+XrPXFAMhhN/08OYBkeoBrMXe8nV3vesgaX+WJD8gPmaU/FDrflnsF7Q7f0=
Received: from MW4PR04CA0330.namprd04.prod.outlook.com (2603:10b6:303:82::35)
 by BY5PR12MB3730.namprd12.prod.outlook.com (2603:10b6:a03:1ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 20:53:03 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::2f) by MW4PR04CA0330.outlook.office365.com
 (2603:10b6:303:82::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:03 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:00 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/23] drm/amd/display: lower lane count first when CR done
 partially fails in EQ
Date: Fri, 10 Jun 2022 16:52:24 -0400
Message-ID: <20220610205245.174802-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3db5f681-7b36-4a63-a231-08da4b23363e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3730:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3730BCBE0F5CB9CE9DDCC2ABF4A69@BY5PR12MB3730.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jak5jynOjHGRr2xGxn4e19Q7cXD5P7elDHt8DTSgb8Io/wOlXWkpy99k7xDhKGtJTxM6Q/YTBeY2x+IYCgVH8LlkC1PGQGPL/C+N9V5o/WBdRzmEfq+WYiLJCkG9FZdNw/ds07p5JhEo/pNr485jnspmKIKaE9I9L1BW/a+eSOe5A/t0y7RShsx+HWvmi4zD1LVeMH8uEBvBvWT4eCFO+860QquI8sDIrPMs1o8Y2GsBQX7bPsQoEXcqStfkZ3hrjwTLvjEV65PthKG00fdWnz1o3h5ZvYZeuQXVvARtEVUTdYWCK2iLBB/UDKReZ5RfKRVH6EZ52mXpl5p9qQn9HYPi9Lz6gQO4VylQ+IQ0oNp/Zxe5lCmGp4Ze+3ZJK3Zy7kJLAnKtzEJ6/q8XM1b0Wn5hKVEHBqy+wwzpARBhaFDvKgQPe/u6tbH38r8Rez3nQXVH1hXdb25l4UZP7/DpbWICnAd8lXfSYA9Xk7mcxofAdi8du7hloKDfpUtZDHiLC3NDXGgE2/e/ZzdeovdWL8zYGHOtO2kL8SKLxRAOz0kaD4NcZINRkWLClr6cd3FxL8Ox5eOyAfG/b3xWqfmWheqZnyA07Ie5Wkn4hCogMhCzMER+ZHLTwAmZZ2kVwAFsvFKBGtzIUWzCsLcFiLjFE3sao7/PGjtTq9UL/gfsKH89yAhg8qtNYxO7E2nplQNCiKc1dWj4/K/wCXR6eIc9tQiRyz7eCirPwUlmG4B7HeMpJGqHe89GKfPI2q5xW9u
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(6916009)(54906003)(8936002)(16526019)(83380400001)(186003)(6666004)(44832011)(5660300002)(1076003)(7696005)(2616005)(336012)(426003)(47076005)(26005)(36756003)(316002)(82310400005)(356005)(86362001)(2906002)(508600001)(81166007)(36860700001)(70586007)(70206006)(40460700003)(4326008)(8676002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:03.0484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db5f681-7b36-4a63-a231-08da4b23363e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3730
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
According to DP specs, in EQ DONE phase of link training, we
should lower lane count when at least one CR DONE bit is set to 1, while
lower link rate when all CR DONE bits are 0s. However in our code, we will
treat both cases as latter. This is not exactly correct based on the specs
expectation.

[how]
Check lane0 CR DONE bit when it is still set but CR DONE fails,
we treat it as a partial CR DONE failure in EQ DONE phase, we
will follow the same fallback flow as when ED DONE fails in EQ
DONE phase.

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c    | 13 +++++++------
 .../drm/amd/display/include/link_service_types.h    |  2 ++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c1207049dbc5..f9c10d044da6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1326,7 +1326,9 @@ static enum link_training_result perform_channel_equalization_sequence(
 
 		/* 5. check CR done*/
 		if (!dp_is_cr_done(lane_count, dpcd_lane_status))
-			return LINK_TRAINING_EQ_FAIL_CR;
+			return dpcd_lane_status[0].bits.CR_DONE_0 ?
+					LINK_TRAINING_EQ_FAIL_CR_PARTIAL :
+					LINK_TRAINING_EQ_FAIL_CR;
 
 		/* 6. check CHEQ done*/
 		if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
@@ -1882,6 +1884,9 @@ static void print_status_message(
 	case LINK_TRAINING_EQ_FAIL_CR:
 		lt_result = "CR failed in EQ";
 		break;
+	case LINK_TRAINING_EQ_FAIL_CR_PARTIAL:
+		lt_result = "CR failed in EQ partially";
+		break;
 	case LINK_TRAINING_EQ_FAIL_EQ:
 		lt_result = "EQ failed";
 		break;
@@ -3612,11 +3617,6 @@ static bool decide_fallback_link_setting(
 		struct dc_link_settings *cur,
 		enum link_training_result training_result)
 {
-	if (!cur)
-		return false;
-	if (!max)
-		return false;
-
 	if (dp_get_link_encoding_format(max) == DP_128b_132b_ENCODING ||
 			link->dc->debug.force_dp2_lt_fallback_method)
 		return decide_fallback_link_setting_max_bw_policy(link, max, cur,
@@ -3646,6 +3646,7 @@ static bool decide_fallback_link_setting(
 		break;
 	}
 	case LINK_TRAINING_EQ_FAIL_EQ:
+	case LINK_TRAINING_EQ_FAIL_CR_PARTIAL:
 	{
 		if (!reached_minimum_lane_count(cur->lane_count)) {
 			cur->lane_count = reduce_lane_count(cur->lane_count);
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 447a56286dd0..23f7d7354aaa 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -67,6 +67,8 @@ enum link_training_result {
 	LINK_TRAINING_CR_FAIL_LANE23,
 	/* CR DONE bit is cleared during EQ step */
 	LINK_TRAINING_EQ_FAIL_CR,
+	/* CR DONE bit is cleared but LANE0_CR_DONE is set during EQ step */
+	LINK_TRAINING_EQ_FAIL_CR_PARTIAL,
 	/* other failure during EQ step */
 	LINK_TRAINING_EQ_FAIL_EQ,
 	LINK_TRAINING_LQA_FAIL,
-- 
2.36.1

