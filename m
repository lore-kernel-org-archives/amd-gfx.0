Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD97C6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA3A10E818;
	Wed, 14 Sep 2022 03:56:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A7510E817
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpW/Na/ppHE3z3OdywOGHeYyw30MhxszDv1vpldq/8wAsATiUx6nsFhd+JsJnLjtziSlvPJnwx3A5zSGDDrGHfOwTzdcQ8HZtnWpf+ZCHxCKT/XvosmrmlYjA4QzcngwWgFatSfV1TR5iAh8miIUT8LKz8Ox5OJzAvJovqxJiH03d40zFkrS1CvZTLb40+MDFCUglSZWeD50Q3vJSeUwoRhCYpaS1cQda166S8/+8U4uSWDz2CPKG8x/9EAtvx0T819lYhJ5fBtAPXuevr40wJ7B0qh9dE0rUOlgNKHGK9YHhlQx72kLRctObwHKNrzOPb3uxuLEk+4Snk5NnUHymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FkHtfd2bgbh/3aJv2AIFJH+sk0LeCzDdjT9PKfux/M=;
 b=R6VgbIxoMspbFxkV0WzEDU82vDkJmo3uYUJ4II+5kFWYT6SFJKNlu4CvGMEsL8xrKtmpACjnENUsr+nA9pkjag60GhOXmqpHv2f6Mh/GF0MdhjCL140S6pP5yvjMQK3XbdCQ7q5AuuiFVVUm1ya2/lkd2oVraXYNEIgdnoeh2Uau2UuPDghVISLJ2wp0XHLDNO6JU2USmMxkiTPAIgoapAAw6rlI8D9RipbwB61vdANPobvosd9UzNhKuwuXdRhx3uqXmCGTRekVKaVO6JhzhoRR8zBVZYA43GkEYUoklQL4eDRuklm0JSqYIHbEjy5CaanwCAYdPJYtOqkY80l0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FkHtfd2bgbh/3aJv2AIFJH+sk0LeCzDdjT9PKfux/M=;
 b=z9U0uM3vTD63R3YPC5ERrdQ6oiWPGEcALVkFQfd8si0c5HzdRF5CclcjuWn7fk94bcB0e7R/v8p94lCC8GI3LnqbsmlKHZKBwYReH+1MIYcIEctCxgaUcg5DDaddYJDyuqfqbA7r9p6jAGP0l10KbQpZHI9vmVpOuHwWSUeJ4TU=
Received: from BN9PR03CA0472.namprd03.prod.outlook.com (2603:10b6:408:139::27)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:56:00 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::e0) by BN9PR03CA0472.outlook.office365.com
 (2603:10b6:408:139::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:56:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:55:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:55:20 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:55:16 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 30/47] drm/amd/display: Fix DP MST timeslot issue when
 fallback happened
Date: Wed, 14 Sep 2022 11:47:51 +0800
Message-ID: <20220914034808.1093521-31-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|DM8PR12MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: b30d4f21-ddf5-4e93-0009-08da9605098b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEf+9yaK0AI2uLyipHuroMZfqRB9osg6NV6rlZz44a6aeBT6IEi1fSdroLIw9q6r+xuBBNQEVvuA14MzO2rXeKTiclPrfvtfsFTxP5BDPoIP2eiQJc/lk4CGdSZ59v+nBKz7/4na+NfMVwTDisMQrd9dyWY5Ah4i0Q+xcIGoLkc72MxT4yqpAt9cz0D6vx0L9D5mDt4EwZ60zm4W8BtxE28Ho0Dm1k2B1jXY2FF9uiobZ8EzS2UCNSzo+P8Km+t3OaqDDBK6hCJi+8lwJ9q50yfLmYks8gPAeUSZ9pvBpad14d6aJF8cqObWbehyYYD+tzFn9RBEMXlZHiCad9Xvqs6OWjLGbExx+cuEht3i/7PXAdRPbAA5gwZpXm8s4eCd2u+rItTQInrYKy3GQ4fPyauGjD/w04s5mtuuXUA1xmtPtg5JQCT6g5TxZHhHWTXsCvzF2SVuwP9/5e8DOUQcIBBCdWVSW1FxYb7aYYw3xFbhRzKzpCBh0CJv87BsETgxnay6j5tlZHAy4qf8aSMAR20CHQAn2Onrb2g0cjXOVGepb8SE9trWt3Gg6AlaufCCfHo3J+cErzqow0AdNQKN7+MnaARMnRQerncisf5DS+dGAWoyTKh0zDxaDrJaQr4KZ7A1pdU3/1T9Zl3pIwqt6ZoZkFB5xEudiX/qNcYyNL7CenOMA8YVUgudOEaW5AX+gCSAxb+ycOpGgVfhPuGXioffwBvoxON6eHXs2BchmXsOV70vAe6J2VtnPIF9eCFiplEz6dQktn6GaxgePt9ogpY7Bp3csUZADjRihb8Ats0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(4326008)(41300700001)(8676002)(82740400003)(7696005)(356005)(47076005)(86362001)(426003)(81166007)(70206006)(316002)(186003)(83380400001)(36756003)(1076003)(2616005)(336012)(6666004)(54906003)(8936002)(2906002)(26005)(82310400005)(478600001)(6916009)(36860700001)(40480700001)(70586007)(5660300002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:56:00.4672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b30d4f21-ddf5-4e93-0009-08da9605098b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Cruise Hung <Cruise.Hung@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Cruise Hung <Cruise.Hung@amd.com>

[Why]
When USB4 DP link training failed and fell back to lower link rate,
the time slot calculation uses the verified_link_cap.
And the verified_link_cap was not updated to the new one.
It caused the wrong VC payload time-slot was allocated.

[How]
Updated verified_link_cap with the new one from cur_link_settings
after the LT completes successfully.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index f317e48c2721..3118e6f808f0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2758,8 +2758,14 @@ bool perform_link_training_with_retries(
 						skip_video_pattern);
 
 				/* Transmit idle pattern once training successful. */
-				if (status == LINK_TRAINING_SUCCESS && !is_link_bw_low)
+				if (status == LINK_TRAINING_SUCCESS && !is_link_bw_low) {
 					dp_set_hw_test_pattern(link, &pipe_ctx->link_res, DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
+					/* Update verified link settings to current one
+					 * Because DPIA LT might fallback to lower link setting.
+					 */
+					link->verified_link_cap.link_rate = link->cur_link_settings.link_rate;
+					link->verified_link_cap.lane_count = link->cur_link_settings.lane_count;
+				}
 			} else {
 				status = dc_link_dp_perform_link_training(link,
 						&pipe_ctx->link_res,
-- 
2.37.3

