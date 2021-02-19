Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A00C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7448F60C3E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7448F60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E416EC67;
	Fri, 19 Feb 2021 22:17:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C106EC34
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F46GRzd5LGt5ePmoIA0vv1tVUnbZ3cuce5Rzjso0a50J+zRKWLiGHh96lptfUDayXdwehz1RkuPJp1HHfKSE+TM03biHRFsG8eOCK4GAjl4oBqzi1kLlefYA3X8QBtsQV6r+ikQyrKXjqMdRhwDf7X/v1Ci+jEMFidP84naI7FZSiDGghmJEC6yEsdKJz2Xhmzg/fIRtrOJwXrR5K7UIOkvztByn+sGXu2vPcEXal4cTw/LfkkdB17GBdeNQ0FoHjsZfdqvwi6WlQshBEgHH7dY5tlzD9m/gXb9B6mHHIppYZ9wA9Jdzs0rR8hTkOc1ZgClov/SKUWU3HQ2lOLRzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXqaDiIBR0yZQPzqbf36wbwrYNLnqlAZ993WibRt6ZE=;
 b=QFe/zHIGgmK38WUVqFZ+3GekklqKY18ZnE0G8oR5enJ0y5WGYK2X7MnUrJm7eZ964tzZ79MwSv6J7Y0UEQbV1elsChEG/YUXK/JhSL3ebM5e/YXkQSCFga2nTANz//7WQTmVsgBVUzo05Cg3RIwJTXaiB+wUm0UGPJu5A6p7Ha+gUhiz2Vid+SzEf4KTN6zOCAjQM5B2s+gCi+2NYDrDDhZOVO3NKFdfkNXBpP13BeuaMI9BLpgyvlwfEJbAzS6Bxbw/goWYSdr6wIDZ0v7mi/BXiw/AOsaYxUByQzq7KT778/ihktrUPadlh9X8oRP0ikiV6L6d56rkU6h04Z9lDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXqaDiIBR0yZQPzqbf36wbwrYNLnqlAZ993WibRt6ZE=;
 b=Wyd8tdlVtcDXUaYtlxVotwmUcb6VbzKDFYFJo9ubtIF7vUPl/TReKtD4Oe26jUSBQIdDy/t9PAuEgd8MoEVqif/FJ16I2Qmb1aZxZkyjf3xMMw/8rNR76LjoBF+D/xeWGchU573gQmgsN+bQ3/KOSyw7rmvlw3tahnw8RoTZ2bI=
Received: from BN0PR04CA0136.namprd04.prod.outlook.com (2603:10b6:408:ed::21)
 by DM6PR12MB3290.namprd12.prod.outlook.com (2603:10b6:5:189::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Fri, 19 Feb
 2021 22:17:07 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::ce) by BN0PR04CA0136.outlook.office365.com
 (2603:10b6:408:ed::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 22:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:17:05 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:51 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:51 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/13] drm/amd/display: reduce scope for local var
Date: Fri, 19 Feb 2021 17:16:09 -0500
Message-ID: <20210219221612.1713328-11-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7927bf58-470c-4d1f-b514-08d8d5241746
X-MS-TrafficTypeDiagnostic: DM6PR12MB3290:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3290800381DB7BC0A6BBBCCAF5849@DM6PR12MB3290.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:517;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3eIwzdJetO1G3qnHkfnXdQqSDSBu+uOrVaeWnzqmEpUOt+KZ2xLz43zbd6/zXflSgRXzB4w1X6fHGeZJxf0azJS82ao7JGkjdmLcnjK+4qp+HmFnAJ4GVyYHgobzW/l9Kbl/nP9e8lYl1Rk5AZ6Nx6kZHN67ZXhp81ZWmtZVvvk0DkZswAqsdFuDZ2kbgr4Zk/sTpPROM8SxnvtUSRgkj/dxU3x1tfWtDUU1hsgvkijboK5rp3i6ZNkhMX68tK+o2dzD++2mJaYDrfVaTEop66q/M5fQaSPr0dD5D/Gh7T3gDDXD4ya05Qm+mKyhRzmDt+KTt5BWoYfQfWTHrQk0DOVzyejcjPcA0CYhwVJr5NlS88oF1mLyXQSV7hUpsv++xkaJaDrCta/lt8Dr0KEvCuoAFqLagrcwC16hnBrQ+OczgZ4mETkK2xO86aKCJf2c/EOPSdTYer4cyde9JHS8ogVh0daULVU69K3UcTwyO0gHIfRvsqHKfPDPa99OllEWDRM3U/IXyNPWehJlUw9YXCL8yp+eACDvmRui22LWfQMWQ9bqhs7tlVUyRSBvzdYUa7SQxCruxeiLN0p4VxFH6E7TYMEhYvZjWjb8hyg9ebCWeEfb5lNZk0nzFdWJesQAzMqPrzvAbLNjgC7oWRORNojir1pryurTpIJA1gXpihYKrYGf0ue2ebNF01mPtij
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(46966006)(2906002)(47076005)(336012)(316002)(36756003)(36860700001)(82310400003)(83380400001)(8936002)(426003)(6916009)(2616005)(356005)(81166007)(82740400003)(86362001)(8676002)(186003)(7696005)(4326008)(1076003)(478600001)(5660300002)(70586007)(70206006)(6666004)(54906003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:17:05.8524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7927bf58-470c-4d1f-b514-08d8d5241746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3290
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
No reason to have uninitialized var at top of function

[How]
Move it to minimum scope where it's actuallty used

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4df26a67e570..6a1e758eaa77 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2348,7 +2348,6 @@ static void commit_planes_do_stream_update(struct dc *dc,
 		struct dc_state *context)
 {
 	int j;
-	bool should_program_abm;
 
 	// Stream updates
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
@@ -2424,7 +2423,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 			}
 
 			if (stream_update->abm_level && pipe_ctx->stream_res.abm) {
-				should_program_abm = true;
+				bool should_program_abm = true;
 
 				// if otg funcs defined check if blanked before programming
 				if (pipe_ctx->stream_res.tg->funcs->is_blanked)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
