Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470E7C76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 17:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6CED10E251;
	Mon, 10 Apr 2023 17:32:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5EAA10E251
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 17:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxbzIuSUCC4u5iBf6oN6wVEAdqKfAR1WTsr2+9syoErhNhctrRxceqfVkIrCsVc1JQzUsjE9dO70lHZWgDYBeqLT2617wDxHFQRJWQKk5t5oI0m3buAWIQdJDv1c4+np+LWp/WxlWQhJaxxqyeVZudknST1i3E6oL3SS+LM3uC/4HAXhEP46/Zxc8Va49KKTpftrQ0QCt1FdW9DqulKK3krpGIaHKBkJyDUk+zDiVFkGqpqPFxWsiHyOMzX7OsG25A3LWQ+ypnQEj5xo/I1UwHIjsJMIhDVyD1MWS3F301mPUrjgLHzlI0YD4plg3ozHFn7ERkRWJaAwHV+JHXX+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgiL05X/6J1Xg7R7mEVstIyjPLMgBoZTmwDx7ufYxNE=;
 b=ocRXizYM6zDN4tC9f+UCOfyF06h8ZJUrWx7XXlaEuN2qbkaO3oy9n5NViZTVhKNkuVMhqtLOX53iP0ZQRqhYUYgaMguwko37IwTG8umh3XXfUyM8NlLnNJqeHk4ef1oj9cmdO2DEa6YCXme0YnCFHzSl2YADl0U7WCUB+rKRZDGH2Z8q3bcc6QV51GodWaVLJKPmxmcjsKzAIngxmzRbM4Xnrwx7wxpRnDD3jR6tB2ut2vXH6FI8420zA6oKcCRSeyqmazmjI703Q+BF20/roWXGzBbkatx84Qqqi0hCvdFO2oLhMx81mTxYTL8MNk+sexupcFRmewfFGoeCPn8SZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgiL05X/6J1Xg7R7mEVstIyjPLMgBoZTmwDx7ufYxNE=;
 b=uwRMdxs4oDITHq9/BjYrKwkTpDp6pTI50Wdy8i4Mphmz+vqG73pe8DMnB0KQ0Fv1WLMieWJHsb+InPAWhiq41MZXY7d05GTYz0DX0LJXH3ZE8HjifjLkWPXUOo/4zg98FwEkwqYYk62jqPJKYOARWtG8ilenQbR0gjtIe7zwIgM=
Received: from MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::28)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Mon, 10 Apr
 2023 17:32:18 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::7) by MW4P220CA0023.outlook.office365.com
 (2603:10b6:303:115::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36 via Frontend
 Transport; Mon, 10 Apr 2023 17:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 17:32:18 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 12:32:16 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 "Li Sun peng" <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amd/display: Add logging for DP link traning Test
 Pattern Seqeunces
Date: Mon, 10 Apr 2023 23:02:00 +0530
Message-ID: <20230410173200.1881023-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|BN9PR12MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d27bb2c-3f0c-4d94-64ec-08db39e988a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z64iN+AkIT2fcP6lq/fcfTrUFKWhsR8x8ocu3hpNhzim/IrNtoGh9rQX4ScywRtdyYKDFKJrPPbEpQL3A2oVRze4n6s5x6WifFGxC7bWYyiwj3sPq/LGtlgFv9+b6CZ6gz5P+ullAbG8ASddhRRQRyq8SYkMgsFSfVfFwvKfvug/p0BjsQ+FEO8KSZPoi3m5FgBT0m7UXNH4xkd9m0A1DoAkKGGxvXv7ZKOnS9Z71JLBPzUO8FJrHdn02o3mbAKcuZtxOCeNArqG6KhCpXhr/oHOzlY1QmI83kqTgQLe4G9yWBkR6jbvmMKfZQB8pAs84izWmc59mUwtuhdEjxZ5fIr5t36zgPnRODz+W+wJ7N4Bd0oXb+kcaCRNm1G7CSsANh2zGucdOgNrIxQni575kzOcTvRXQfbz7YVDfoqBzECIgXgOleiIgl1ApCWGYYOaImqXC8b17z9ZfL2+mSyXYqETTLM0dMSm9Fj+JwHl47one7d2u7neBus7qVJVM3Utw/H6Sk6IjpFRRdmHcggmZ6JKC1s4n1EbXazEEXjrcUDDbVLrMSPsfIyvKitjI+odj/P66KJn1Y3TEFDU22e5wYI0hXN0epbdF2uC91qXyCzTr1tgfkfZn9H/YADhJxqBLYJ2bvStgZXts3k76qBwN3hj90c1E46+2sBBaVfinimuVDwvU0wRQ1h9CVfKBOXo2emyAcGtORWJfEbNgoI3jllp1nWFkwUPJZj06q5KShI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(44832011)(2906002)(4326008)(8676002)(70586007)(70206006)(8936002)(41300700001)(5660300002)(478600001)(54906003)(110136005)(316002)(6636002)(40460700003)(7696005)(26005)(47076005)(40480700001)(186003)(1076003)(426003)(6666004)(36756003)(2616005)(336012)(82740400003)(36860700001)(82310400005)(81166007)(16526019)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 17:32:18.4173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d27bb2c-3f0c-4d94-64ec-08db39e988a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add some more logging for DP link traning test pattern seqeunces
for better debugging.

Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_training.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 70fc0ddf2d7e..265233979cf8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -212,27 +212,36 @@ enum dpcd_training_patterns
 
 	switch (pattern) {
 	case DP_TRAINING_PATTERN_SEQUENCE_1:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern TPS1\n", __func__);
 		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_1;
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_2:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern TPS2\n", __func__);
 		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_2;
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_3:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern TPS3\n", __func__);
 		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_3;
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_4:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern TPS4\n", __func__);
 		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_4;
 		break;
 	case DP_128b_132b_TPS1:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP 128b/132b training pattern TPS1\n", __func__);
 		dpcd_tr_pattern = DPCD_128b_132b_TPS1;
 		break;
 	case DP_128b_132b_TPS2:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP 128b/132b training pattern TPS2\n", __func__);
 		dpcd_tr_pattern = DPCD_128b_132b_TPS2;
 		break;
 	case DP_128b_132b_TPS2_CDS:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP 128b/132b training pattern TPS2 CDS\n",
+					__func__);
 		dpcd_tr_pattern = DPCD_128b_132b_TPS2_CDS;
 		break;
 	case DP_TRAINING_PATTERN_VIDEOIDLE:
+		DC_LOG_HW_LINK_TRAINING("%s: Using DP training pattern videoidle\n", __func__);
 		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_VIDEOIDLE;
 		break;
 	default:
-- 
2.25.1

