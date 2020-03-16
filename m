Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF9DC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6832051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T3jfDnH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6832051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18246E489;
	Mon, 16 Mar 2020 13:50:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78CC6E479
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0hSMSIQ/CRI+RHWKE9CIYvFIBMAYjK8a7lG006WAxCSgIB0qjfBT7hd7GQYymk/fyNWMOBieTVIJAk+0a7qgOX8nlE8bnDkyB82VDEhjYw04YtHL1jauf3EFKcN+YK/pFDVyLKw5w33IXa6UDpQJknB6KlwRA0KNGDdB+aFxN9GME4wARJpYcw6eiHOj4XacgfEFRoW6f1i6LgIcuZwKrzrLfsfsexDfhVjoi1h4wH7hZAakqfcGsv+OcjQl1BYT0ES5W/Wf+4jzGeOqDLToaKXbS8GhSOPF5kQUy2Xc3cNUqx8ckzMdrfij6vAvhkH53C/MaV6ZYNC8C+NkVk3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPbwzunEax//SLiWwC6dlrhcbwUL3BDklclgTR8WIHA=;
 b=JpLh7BRpt81hTLUkLOhH0lHmTr5D6lYscYBvJMDdC0SchWZ1fvngecnf38hX8Gnwqhvy9nwvnSk9XDJMC3K4e48gcg/aHltlyshWynBgVohLJsTNwMbiXPWBVnN/jjvdKS2U/ZXYGFP9v1By6V6zSu5/nOWVSwLZxyV7mrbCnF51SniVF/mbNW5SPrD6LnRrZp5DQl/Pm5aihLMNqDs4gz+DZq28is+hLzl6gcaWBgcLo0Fn2P0uHczh6mZCy2TF3ZvWdZf3+Z6spyC9T/RRkvEb9ma4UFq9UyoggLJuNSKkire5pqOC3TShpnlZ1Cfn9aV9HsLVb/IaG6LxiD79cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPbwzunEax//SLiWwC6dlrhcbwUL3BDklclgTR8WIHA=;
 b=T3jfDnH6VIi9IRsbmu4tSOPw8eXXwgN7JL3aE/c+2P32b3almkh5cQRrD6pOBeOK3H7Pztw493CGfqMpcD51N6ej/JNYaXSHqS/fmzXEL0YIncrtTtTMeDExZKJVJjF1c8IBFnu+YgeY9+kUue1FdGqZucVCBOjp+nm5hOLw47M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:50:11 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:50:11 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/19] drm/amd/display: DPP DTO isn't update properly.
Date: Mon, 16 Mar 2020 09:49:18 -0400
Message-Id: <20200316134920.2526155-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:50:10 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbbc09a4-201f-4151-6c83-08d7c9b0f249
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB239623EEC43CEE204956B99A98F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(54906003)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(15650500001)(66476007)(8936002)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1Dd4Vi7PdJQ8PhfOgHsdtqZmv0Abap+MIHe4TIfUSrUzSrlttyLT2XL171hlUoX7v/EoXqYWpEt2CW3zwiibTV5rkffN89iUnPyr3iaejGecqBrJGl9aFJn5reZKprQJbBFwRF2Xcu2RUIrdQhVBtRNXeDmXqJ/qKPZdteKbip1zHZj+wjxBDFX+uyPT8v+ZeLDQARWRum1MzYYYq3slMnRB6c43PY3HKDmJWGbwUolKCcTd+qjnG9Lk3aaWEjfck1qefP6cgmd2FSxeIqAe5vvJiPF4fOttc6rPcTlCtoIsHvXy4NWmebbw+iST0YVlpbi0bwFIWBCb9tHBmgw19/fmZS1rGk1yIPxiuM5akAdPXh1iI9n8t/7o1xBR4cvLrGjZ2urvSiNNVte5FXcqq0YKc8DIeo+RHpI/A4yxV+A8IV7Cjvb4qQtJEbcm76I
X-MS-Exchange-AntiSpam-MessageData: YEpZ6O8HFresUSSP5+FjqX6duqCSxYphKpI8U2FpNmqfGdg0sauhA56doTBB0JUj3yr0LBZXiJoS3FDko5hwj7VzxxoLt5sn2zUi3ABMQDHO3LxynKqqT63RKocy3UhQihn0CQ194vAEr42HVtNejQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbc09a4-201f-4151-6c83-08d7c9b0f249
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:50:11.5398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUgX4ymKqXy3BfB/phhsNkkUxTfI5hBXJB1bOm6CjM+24kfxj17/GzLtgxbRzpeMNkJN89Fj2YV8l5HEK6qfOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
before update dpp DTO, we check dppclks in context to determine it is
changed or not, but dppclks in context will be updated anyways after
flip is done, so compare dppclks in context will always get an equal
result.

[How]
Add pipe dpp clks in dccg and compare values between dccg and context.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 5 ++---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c            | 2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h                 | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 368d497bc64b..55d09adbf0d9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -115,12 +115,11 @@ void dcn20_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 		dpp_inst = i;
 		dppclk_khz = context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
 
-		prev_dppclk_khz = clk_mgr->base.ctx->dc->current_state->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
+		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[i];
 
-		if (safe_to_lower || prev_dppclk_khz < dppclk_khz) {
+		if (safe_to_lower || prev_dppclk_khz < dppclk_khz)
 			clk_mgr->dccg->funcs->update_dpp_dto(
 							clk_mgr->dccg, dpp_inst, dppclk_khz);
-		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
index 50bffbfdd394..62cc2651e00c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
@@ -70,6 +70,8 @@ void dccg2_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 		REG_UPDATE(DPPCLK_DTO_CTRL,
 				DPPCLK_DTO_ENABLE[dpp_inst], 0);
 	}
+
+	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
 }
 
 void dccg2_get_dccg_ref_freq(struct dccg *dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 05ee5295d2c1..336c80a18175 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -27,11 +27,12 @@
 #define __DAL_DCCG_H__
 
 #include "dc_types.h"
+#include "hw_shared.h"
 
 struct dccg {
 	struct dc_context *ctx;
 	const struct dccg_funcs *funcs;
-
+	int pipe_dppclk_khz[MAX_PIPES];
 	int ref_dppclk;
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
