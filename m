Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F47C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88935610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88935610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C716E218;
	Fri, 24 Sep 2021 19:10:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997FC6E216
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlfKmg51qMPjEbeUjTloDGadq8UeaZ04Z9I9jo//jkA3Us8hCa4DLsScaBJHYSm8QnpDafLc5M7bsd/N5IXK5i3PbUtd0hQRDH3CyfH//amq1xaOlSYl87x1AKZ3RmPryQG7zfzBPfmrK0X6FR4gRURSmytCckGr/MGjKo9cAvXCHK0mNfmYRND5dRo1a0JEHSCe0iBJ7kyndJYfOjWN6U2Ab0oZQLNF8vgwi6D9oV3ciHJf20ovB09DdlXzqdcVNwpulhPusf28LKi+tmP3f1aLIPw6K23BcwvmZiXDsEJj06cHJTcaxj12bMjuVX3+YQrNNY50uRVFXe5L9MWrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=QN4EtlKxZOj3YFGyBL3UDG0zqVz+qdv3x8AJ3oA+HZ8=;
 b=P229ZfZoMD/lnaxUqgVV/PrC328sMsHWEfP9ijXe0i+h0qX0hBTXg9fzWxsIQdehzM4SdyStdXywASUM93sLTiQOS4tIyIbFNO81voHuS9TIAc3qDyNHyHsEnnAuJbRzSPN6g0Y5SPwPa7tixNGk6/Ffcdzy4nRlDu17ZWKIaCsIUxV4BXuTgAxR/Gb6Pp5pBp/Mmsn7qcfqt5qHsytvGYNfQzOVnnBJIahJwEPOl9VgSplJXdJ4G/3P2FUktTlRcIurs5wnsHnN2yAHjaTOYQf3Ns6w3ekLga8dab2cG7g/goPRGFM1X4tPKl6cNR1q45fCJ8fUFo6NdEptei33Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN4EtlKxZOj3YFGyBL3UDG0zqVz+qdv3x8AJ3oA+HZ8=;
 b=uP9ShoKiIA/NUpM/7G/IwBOh9a/qky87TjXOS5gP63dW8Yf28GX/pPovcIZtJd6peUaBkolkfhtrqSQ7I0bo1a7rwaJUtIkky15ZZe6o7XGMOrEBYrzB9gFCQiWAhr+yI+Kqa6ssAVWboGo/Sy85os4bra4Gpeqv69b/JGhFRHY=
Received: from CO2PR05CA0092.namprd05.prod.outlook.com (2603:10b6:104:1::18)
 by CH2PR12MB3654.namprd12.prod.outlook.com (2603:10b6:610:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Fri, 24 Sep
 2021 19:10:10 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::83) by CO2PR05CA0092.outlook.office365.com
 (2603:10b6:104:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:06 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:04 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 11/24] drm/amd/display: add two lane settings training options
Date: Fri, 24 Sep 2021 15:09:21 -0400
Message-ID: <20210924190934.1193379-12-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25e76c0e-0e49-407c-b727-08d97f8eed88
X-MS-TrafficTypeDiagnostic: CH2PR12MB3654:
X-Microsoft-Antispam-PRVS: <CH2PR12MB365455231D425E7210C97877EBA49@CH2PR12MB3654.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WC9zkfUUu3TXowtgMpEPDWy6qcdi9/Uptq8JMWxcJzWK6I6Ls5jRxhNun1t2a6BmNr4BYkp946VAcKLXoFUeNd1eni+QDH9Iv8G2gPdT41O/tI/Tu2FcTlu5ejWaoCYtbUUeo72jrLUymfLjCJnGfcoXKjKUWk6wNCsEY6r3ORqh50QiYOnjkWysSoKdBH5EfE8W1gMg9eCRpE+cCLnxQIQie6wGTx4LLpP7slgedGp/zBb5aYWqvJyV6Bs6FaFBMdmg6ujj5pa3WGF1c/13U+Mjv9Dpc0eEV73+3bJ0iSOTIKDR25AM0pUKit3s92n6ObnHdA6CuEdJFynjfKnEmwRRfuKvzXRSCEkb5Ykmpsm0doIKkIxH6cbLPNpcjyqbrQLyo72Z88GqT3nHLhXr3AjjBsaOTr7ZpbhS37r0WszJVF8+M623R384svdqPZAwBMoAHA1mcsVMIdXc/mhfmNCi+GeGaq5qyIfeqCgoLfpS2+zRNKeQw/d6E+cznZsC4XRYnjpzLuF2YmfpHnHfy08DekerBzsq1FllDyXMgvpTx2Y9KBV1grz+bX66Sye4COuzzdZ0VRyuoI52xR+LiH0D02KfjYhDsX7qMKzm5I0fMciux0Q5drhC4yKjtgFkrEfQuLBN6dwwu9pcDLJwrBwKNbJs0IOMfYjxnNn8V5jfthluetVeK2WUFRjoey7vL+CCpcwbJ6ONBXWz4qvuVWaupGivngsIpT5tSLdYf/I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(5660300002)(316002)(4326008)(81166007)(2906002)(36756003)(36860700001)(356005)(6916009)(86362001)(47076005)(6666004)(8936002)(186003)(83380400001)(26005)(2616005)(426003)(1076003)(7696005)(8676002)(336012)(82310400003)(508600001)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:09.5340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e76c0e-0e49-407c-b727-08d97f8eed88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3654
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
option 1: disallow different lanes to have different lane settings
option 2: dpcd lane settings will always use the same hw lane settings
 even if it doesn't match requested lane adjust

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c   | 18 ++++++++++++------
 .../amd/display/include/link_service_types.h   |  6 +++++-
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index f13bf8ca93aa..f55dac1c7ea1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -733,12 +733,16 @@ void dp_decide_lane_settings(
 #endif
 	}
 
-	/*
-	 * We find the maximum of the requested settings across all lanes
-	 * and set this maximum for all lanes
-	 */
-	maximize_lane_settings(hw_lane_settings);
 	dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
+
+	if (lt_settings->disallow_per_lane_settings) {
+		/* we find the maximum of the requested settings across all lanes*/
+		/* and set this maximum for all lanes*/
+		maximize_lane_settings(hw_lane_settings);
+		if (lt_settings->always_match_dpcd_with_hw_lane_settings)
+			dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
+	}
+
 }
 
 static uint8_t get_nibble_at_index(const uint8_t *buf,
@@ -1455,6 +1459,8 @@ static inline void decide_8b_10b_training_settings(
 	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_setting);
 	lt_settings->enhanced_framing = 1;
 	lt_settings->should_set_fec_ready = true;
+	lt_settings->disallow_per_lane_settings = true;
+	lt_settings->always_match_dpcd_with_hw_lane_settings = true;
 	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 }
 
@@ -1481,6 +1487,7 @@ static inline void decide_128b_132b_training_settings(struct dc_link *link,
 			link->dpcd_caps.lttpr_caps.phy_repeater_cnt) + 1) * 20000;
 	lt_settings->lttpr_mode = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) ?
 			LTTPR_MODE_NON_TRANSPARENT : LTTPR_MODE_TRANSPARENT;
+	lt_settings->disallow_per_lane_settings = true;
 	dp_hw_to_dpcd_lane_settings(lt_settings,
 			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 }
@@ -3593,7 +3600,6 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 	dp_hw_to_dpcd_lane_settings(&link_training_settings,
 			link_training_settings.hw_lane_settings,
 			link_training_settings.dpcd_lane_settings);
-	link_training_settings.allow_invalid_msa_timing_param = false;
 	/*Usage: Measure DP physical lane signal
 	 * by DP SI test equipment automatically.
 	 * PHY test pattern request is generated by equipment via HPD interrupt.
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 3fc868b19f2f..e94bcdb3e134 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -116,9 +116,13 @@ struct link_training_settings {
 #endif
 
 	bool enhanced_framing;
-	bool allow_invalid_msa_timing_param;
 	enum lttpr_mode lttpr_mode;
 
+	/* disallow different lanes to have different lane settings */
+	bool disallow_per_lane_settings;
+	/* dpcd lane settings will always use the same hw lane settings
+	 * even if it doesn't match requested lane adjust */
+	bool always_match_dpcd_with_hw_lane_settings;
 
 	/*****************************************************************
 	* training states - parameters that can change in link training
-- 
2.25.1

