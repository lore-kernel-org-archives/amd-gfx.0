Return-Path: <SRS0=r+dI=MK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA03C636CA
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D57261182
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D57261182
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03E989DFA;
	Sun, 18 Jul 2021 14:06:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5977D89DEC
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jul 2021 14:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBCBE/FyMRX4WsIcCVKK9NX73klq1c0pyPB9zl4Kk2KcNt4RQrqmRN0R1b9mSERQuOg62O5pcTDv0jZej4OF7m3gWaiKir9sGaUwpPvZ5RqQi2jJo/PuJ7m26xcprf+d4YcfYpU+LEEj3OzkUt6hAr/5gblF4Ihwc0B5f1k/aeNZYnSF7BfRDkJuN9p+y+O8CgVkcqUCdU4Lad/9pG7FJKwAMOtqFnjr9yKaQsLxOvPMS/kA9lrxlF47+HJoVAQZ6b2pOl3Fu+oVx+mmqS/WY2XheN+fVeN6nWBG2EIkCB2hl4bzoXCP/gkKGOdkAfLWiYkd99GvaLLoNfyiwQO0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYR+LKOQFUAfz1OnTI5gVnHwImiP36FODscn0Hmjr3k=;
 b=Vee9e6mIuK/qvluAxnRg7te81c89vpjIyXvk0iJdA6aQPRU2+/XjpRG+WcioIiuD3Xm+ZaVk5mTLiprKDkeWI4qVf9xptCcR/PLKCroudf0hdk32MdLFUocY6r995P8vNdMjci4xyIdKoQLVtXhgBzvc01+QClQFAr7HKv4znTw6ELSXwZJFGI9wzNBU62mpsPNypJZmdMCndk4cEaLxtnczmJBsj9wUbW1kxIOo6IELuIRLu71S+BFg9DEo2SwMiz3zzHIKCC1Slncj76POT4DOGaX10coMpPq+kulgW6c3O0jcnyaedQDsIhNCCfqvZXvPsOYNtlva0WTg0h4CVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYR+LKOQFUAfz1OnTI5gVnHwImiP36FODscn0Hmjr3k=;
 b=dyGEUChOEDJX9nsW54ixhrBoJlaQHReIBzpqMbBfxNrS6ZvLt5/FfoAr+athLlghSV3UoVMdW1WbobbsQ15zO/zYzsRTA1h46XoOezGbQHjm75NXjipHH1d/bTI5dykPw11fE87ZL/34Xo03/TTwoP78YZGfHhoULXip0AvUZZs=
Received: from MW3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:303:2b::9)
 by BN8PR12MB2962.namprd12.prod.outlook.com (2603:10b6:408:47::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Sun, 18 Jul
 2021 14:06:25 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::6e) by MW3PR05CA0004.outlook.office365.com
 (2603:10b6:303:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend
 Transport; Sun, 18 Jul 2021 14:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 14:06:25 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Jul
 2021 09:06:23 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/32] drm/amd/display: Assume active upper layer owns the HW
 cursor
Date: Sun, 18 Jul 2021 10:05:40 -0400
Message-ID: <20210718140610.1584616-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
References: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b940284a-b61c-4c16-5b95-08d949f53af5
X-MS-TrafficTypeDiagnostic: BN8PR12MB2962:
X-Microsoft-Antispam-PRVS: <BN8PR12MB296204C8A7CE5608F12BB2CF98E09@BN8PR12MB2962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3PRL4MBAaedJ8jMNwDGAIo6pWNBsMYpZdapaWsdjSdKZZDmPqZley/skzLZyskkdIWkJHUQZ1rGsVFTr/4EPCiGTnhLy5Uj2DTSu/aNwOxKdx/9r90qRsOHzl6WLe96PmUmQLjh3ITP5xWGYtbvaIIY5CXx5x5lkVfM0KnVybkX0ZJqBwdfmyxNmo43tD6XRuZ+Eqg6eYEbzZDG7n8m3bTOQsdhNhloKJ56UCMEweUp7pVK4X0vHaM9YOiDe0Z6tz5oafs+9Ojdz6Otx7kHRLTT0tl0T0V+ifk4ADtMhEMGD3oepFyzK72GeyQ5fsFBkpSqCX2lJOqkZ1M6WH77mXcJo5fpR+zvjgrul7nsrCFQzVnfh188iAhhhQtDH0fk73t7zkTP0vLXUqXevHKCnNEez/48MynqeK5tSoD6Rhf7NcIrKxKHKCb0cBphhiLI6mTBd9rLw3qi77jlapyfny3ldErO62cA4gw8TxH4wbcLjZwmnipl5OLv6JJUjIzBhexH+ZRuIVNZYrV3begfG8QSfmPz7cLDC+TsUtt21+N4s8e+c3nle2HzrlzsAFPDhsxM3EfPRl+KIYxhKvQKSzaSRGMgeFrc8fgSZrky8xPQoExy0M4X8zqen7Cezvt0m2z42dT2lRAiVCI7jW6fZszTcwQQIsHWW5apQ1OXFv5bTQWz+kYuwJuF5UbEIhBIzlE8PlPQU8UOTlN6n5tw4a79Orav7Hc3ia29qKJ+9rn8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(1076003)(82310400003)(86362001)(47076005)(8676002)(81166007)(82740400003)(6666004)(36860700001)(2906002)(316002)(356005)(83380400001)(478600001)(26005)(70206006)(70586007)(54906003)(36756003)(186003)(16526019)(8936002)(4326008)(5660300002)(6916009)(426003)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 14:06:25.2900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b940284a-b61c-4c16-5b95-08d949f53af5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2962
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
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Krunoslav Kovac <Krunoslav.Kovac@amd.com>

[why]
The current logic checks if there's an upper pipe whose viewport
completely covers the current pipe viewport.
This fails in pipe splitting case as you can have layer 1 pipe that
crosses the two layer 0 pipes where it's contained in both, but neither
covers it completely, hence we allow the cursor on both layers.

[How]
Instead of trying to "sum up" rectangles from the higher level pipes
which could leave gaps and would not work generically, we will assume if
there's an upper layer that is active, it will control the HW cursor.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c545eddabdcc..f0f234ee5827 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3180,24 +3180,18 @@ void dcn10_update_dchub(struct dce_hwseq *hws, struct dchub_init_data *dh_data)
 static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 {
 	struct pipe_ctx *test_pipe;
-	const struct rect *r1 = &pipe_ctx->plane_res.scl_data.recout, *r2;
-	int r1_r = r1->x + r1->width, r1_b = r1->y + r1->height, r2_r, r2_b;
+	int cur_layer = pipe_ctx->plane_state->layer_index;
 
 	/**
-	 * Disable the cursor if there's another pipe above this with a
-	 * plane that contains this pipe's viewport to prevent double cursor
-	 * and incorrect scaling artifacts.
+	 * Disable the cursor if there's there's an upper layer active,
+	 * assume it's the one owning the cursor
 	 */
 	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
 	     test_pipe = test_pipe->top_pipe) {
 		if (!test_pipe->plane_state->visible)
 			continue;
 
-		r2 = &test_pipe->plane_res.scl_data.recout;
-		r2_r = r2->x + r2->width;
-		r2_b = r2->y + r2->height;
-
-		if (r1->x >= r2->x && r1->y >= r2->y && r1_r <= r2_r && r1_b <= r2_b)
+		if (test_pipe->plane_state->layer_index < cur_layer)
 			return true;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
