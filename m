Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FE8C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB17E610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB17E610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 877386EB87;
	Fri, 16 Apr 2021 14:34:34 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205276EB86
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1gMgKK5I0Q1SFrszIaNkcLuqzPgvORIu6cU5CnawWHAj0HQyjrt/9suW2i1xs53fOQQ3eykC8q0bYhf3QFAOMmK0tUvBXMrDw3dAO5ApPGZ8Xdr3c6JyNOGgnl2t/i7YL/5yJZkpHM6MQQLXYn9sLpsLRlfIrQzCsn9AQy8doVTFo3EEXN4EiF/P4l8iBYiTqGOiq7CEtmoxjVs7dFNAI0lqXIbaKS5NbTVKCUqqJZ+mUiI9RjX8pe0NFjG3MWE+1wb1EejXVbhZmpqu4sQtTsq+Mh51mU2H7/rHS2quZukawR2+omf9yKDF4bcyvHXiFVvkcqvc3FOSIR3S/8pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrOQ/YwTl88g2j8rEFhnnBZGON+SvEVbY3DDbA85KMw=;
 b=VtskXZQ0/jGBB2trBTYGOG8EmYPtHXvrACA0M2qhS5ljZUAqP9nhVErCIwFBJ7sLsCPprVDicze2yk6+QUD3zEbvkg1NwWSYOh41bQBaJXTNiJJmBEXCxioPQy+iWcUVrlxGZf2gCSYH9Ge39fkLnsc9aDFsSxEr2M0yRRKJGiQhGrVHoUoNRy4uh68xLOvGb/Ck+gXOy5BBKcZWx/gZ++1O1aLheKm4MSACGP+1CDV8xiJjVSVGVHQFk3hvV9gPfg5uh4XV5oZPc6akVR8TxWPe9uG24p6NwQG1/6E5o+Q5V7y56Vi7YEyUoQyLsKMsoXnmLZzLCBk4Dgj+uSIhFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrOQ/YwTl88g2j8rEFhnnBZGON+SvEVbY3DDbA85KMw=;
 b=AtGEakzNe2fePkZAvuPTXhvV7q6IvnLqyrgwX9TwBNUWS/JT37GatQuJSY21xQgCYvUn6I7NQuVTmBfuqQ7jsX7GdJTQfTrbdEEqRq9/5xzF9SP57ky0wMgtnJlnkFIaPHPtdX/r3IHahj+miqba/fam6G/v0Lw9qOxAIBCKB+4=
Received: from BN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:e6::27)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 14:34:31 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::64) by BN0PR03CA0022.outlook.office365.com
 (2603:10b6:408:e6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:30 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:30 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/19] drm/amd/display: Unconditionally clear training pattern
 set after lt
Date: Fri, 16 Apr 2021 10:34:07 -0400
Message-ID: <20210416143417.611019-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dec220b1-c49a-432c-ed02-08d900e4bf69
X-MS-TrafficTypeDiagnostic: SA0PR12MB4397:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4397818B0AEBFB1CF8AE81818B4C9@SA0PR12MB4397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orVqSzyN4jZpQWqj8eULQER7aqOXZPg9MviULDTn36ZjOwgN7mrsYH14hDzP4mA+P07v0cVFVipnBx8Mj2wH0vWCEVLJCJjEurMGVPVevIwGe1v+hpkq7lYwnD/P+RD/TiUzOXaeTptO6r3rWING5ZFWLyLIjwdkBYn0sWCsF2+QFUczE+WdEhdU3l+PI7NcdHGkSkDPIZUj9+clqkcAaoFHOsYJrFoauPdgux9/dLkAjyWQVEdFkdRwIf3X0mKQh1ZMlyf373sBuLyqiCZdgDc26RQuvt9gnY8gzyBX+BknTy8ZP/iD9YGC7rhzuv8IRMwN8/H6eBHm+oKPSuMx0tQV2tDpwuWw2KOKq/+qvonoqLF/Pg+qiIeD+s/VHRao1v/rBF2qFS0A6zY0ngx5LZ8QLpEAAdrSl8bHunsGM0sPIHU8AK5Rrl7CTnXihkqbqkKyGh8J4WTGV14KFF58qBjLfsdLj7QeHUndbeQzmMhCXlvA+0dDHv8U0mmKlTKTY9K+lk0BWkteNB1TEc2FebCyDKGKC/uUzr/oAku0frxkiAQ5jtVaqq0rbGV4Bm8UQ4xiAqHgfa/Ffcznx3FawrOAXv1TFaW8VwG1xgRRvMeNkGLx5G8GSflK4DEI7BuqjYH15hbOuhgczUToYleiBMZCDfgPflMMGTZMwcFvQalVLxcSE9emiqB+TZQieKfE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(356005)(426003)(70206006)(44832011)(478600001)(36756003)(4326008)(86362001)(8936002)(70586007)(54906003)(336012)(7696005)(81166007)(36860700001)(2616005)(82310400003)(8676002)(6666004)(83380400001)(26005)(5660300002)(2906002)(1076003)(47076005)(6916009)(316002)(186003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:31.3129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec220b1-c49a-432c-ed02-08d900e4bf69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
While Link Training is being performed,
and the LTTPRs are in Non-LTTPR or LTTPR Transparent mode,
any DPCD registers besides those used for Link Training are not to be
accessed.

The spec defines the link training registers as DP_TRAINING_PATTERN_SET
(102h) to DP_TRAINING_LANE3_SET (106h), and DP_LANE0_1_STATUS (202h)
to DP_ADJUST_REQUEST_LANE2_3 (207h).

[HOW]
Move the current write to DPCD Address DP_LINK_TRAINING_PATTERN_SET out
of its conditional block.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index e6f8f3c255bc..bbf2865b25c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1132,11 +1132,6 @@ static inline enum link_training_result perform_link_training_int(
 	enum link_training_result status)
 {
 	union lane_count_set lane_count_set = { {0} };
-	union dpcd_training_pattern dpcd_pattern = { {0} };
-
-	/* 3. set training not in progress*/
-	dpcd_pattern.v1_4.TRAINING_PATTERN_SET = DPCD_TRAINING_PATTERN_VIDEOIDLE;
-	dpcd_set_training_pattern(link, dpcd_pattern);
 
 	/* 4. mainlink output idle pattern*/
 	dp_set_hw_test_pattern(link, DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
@@ -1560,6 +1555,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 {
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	struct link_training_settings lt_settings;
+	union dpcd_training_pattern dpcd_pattern = { { 0 } };
 
 	bool fec_enable;
 	uint8_t repeater_cnt;
@@ -1624,6 +1620,9 @@ enum link_training_result dc_link_dp_perform_link_training(
 		}
 	}
 
+	/* 3. set training not in progress*/
+	dpcd_pattern.v1_4.TRAINING_PATTERN_SET = DPCD_TRAINING_PATTERN_VIDEOIDLE;
+	dpcd_set_training_pattern(link, dpcd_pattern);
 	if ((status == LINK_TRAINING_SUCCESS) || !skip_video_pattern) {
 		status = perform_link_training_int(link,
 				&lt_settings,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
