Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C91C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08092077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="APwXCtX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08092077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98D66EB74;
	Wed, 11 Dec 2019 15:33:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEB46EB73
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI6XKLeQ6xHLwjjgz9QvVl5U85VIkXQi8lyFX6RCmWDlEDSnacRNGgnRvT6olYRsbMIS9qMx1ZWxmT/XbXyn50D8Z+UY5i4LtfbgsnoUqJgIGEhvKC9evN3RtRsVpZorfzQOI2k8qhT2etrroNDhZbcESB70K7yz7I3OI+arLdl/W69ersbaqAQwluFRXGh5Xztz/xdYRceLwFoQDRARdOxvMkjH7CzY6gkth62sSH3V02szyiYi1Ut4Jff0wTr49pcYCl5vptUBO1ZrWkAw4HtleWyk86Xw2mSoa/cO5YGOmYpvGE985EN59g/YZvlFOblU7UkY7LuY/aSrXR1AAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rip1Wfj4Q10k/32x/htqk7iI1WitA18uAGsxEq78WpI=;
 b=cmdTazIo/VcV5sJv/0vKPPrqywLptWiyIsoi0K41FYAKTXwnmamhQg+f5sSBqu/GVRvVTlapsCYO5ME6EY/meiVQ7vdv3roifw48svc3zxwmaiN+3+h1ONyDy253LsqvTEVK6OtPeAVxcKz8dUWZReEvGrqbMHQA6EEY+VKv+GO5W1zvA2te0wtOxLqHqyHJrBZyIwqj4QUuAXbnLCBf99k6olV3nM3cbbxsym3+k6DAt+MRFedmVelANykjt0rC94MSIjoPHhn/pXzb9lp9KYmkSY214h0OOk0wXdnPo/vhMKbhtXV18zAGBGVg4E6BDSl6uWHqOu1qU+gponhvQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rip1Wfj4Q10k/32x/htqk7iI1WitA18uAGsxEq78WpI=;
 b=APwXCtX2T3gzt+ABa8AfpSK0cWUML/QQgCAp0tq/nBMacXAr44AHRXiBg53Z9XGdGxU3suVdx6yiaFr5uM7VeFpGG6VBqIhfuFsnFk8ChkBhWntDhCT+cv3q3tuEh31Hk1fv2pkWOWLgYXfWUB6H9u/tBjtVDCcWOAuVK6WSvhs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2426.namprd12.prod.outlook.com (52.132.184.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:18 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:18 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/39] drm/amd/display: Add wait for flip not pending on pipe
 unlock
Date: Wed, 11 Dec 2019 10:32:17 -0500
Message-Id: <20191211153253.2291112-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49b01552-b6cc-405b-f46d-08d77e4f7285
X-MS-TrafficTypeDiagnostic: MW2PR12MB2426:|MW2PR12MB2426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24268787CE002E887B58A834985A0@MW2PR12MB2426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:138;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(86362001)(6512007)(1076003)(478600001)(54906003)(4326008)(6486002)(66556008)(66476007)(66946007)(2616005)(316002)(2906002)(81156014)(8676002)(26005)(36756003)(52116002)(8936002)(186003)(6916009)(81166006)(5660300002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2426;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nygYvBiEKDd+0wl6mW9pDq2KCWcEuNI1vHGysvyKXxBMPy5VWV2hwvQUWluFJtCGr+4ZtPxV4Jvr0qv1ft/zCZEcNh2nWkRSvMlWAORWEZldIHKmXvHn6HrPWL3V+vMR2SweosdaIeW/wXESH1xhySK1pHQHieQ7Bl6Yrxof/jXDuRKzUq3NZ1IrpYhztjiB/37LMiFsCUzVHkgpyokwmJKZA8yufL+kg4S2V3/0CXIN7JJLDjAzJiWKr6oXVrP4DZwHLUre4HpfS/uiVlMJqKZZCjPh6l/qVpOdG8UxjVU8VK1fQt1u9S/sJEwmIru9spWUDFzkX+J2p3lYX060tS85HBGnLY/BQYEFyf1c6DGva3LA7/p/SsG0UcO3iOVcxcjCg1XCdN+8N2Ob7Wb+nDlPadhLbtfVpiPPWfJX5WcUXjHLNfrcaNZZBfBd4T5H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b01552-b6cc-405b-f46d-08d77e4f7285
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:18.7300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: forOtCRsD4SEvsWqUBvyn+ly6Jn4RX+1LwpYkK5w5kojbzUUgGAhcjVYhCmxfQ+2HyCrje+G4jjmsQBXMigZZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2426
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Harry.Wentland@amd.com,
 Noah Abradjian <noah.abradjian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Noah Abradjian <noah.abradjian@amd.com>

[Why]
Lack of proper timing caused intermittent underflow on unplug external DP.
A previous fix was invalid and caused S0i3 regression, so had to be reverted.

[How]
When unlocking pipe, wait for no pipes to have flip pending before unlocking.

Signed-off-by: Noah Abradjian <noah.abradjian@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 39 ++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 39fe38cb39b6..879cedd79d9e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -66,6 +66,9 @@
 
 #include "dce/dce_i2c.h"
 
+#define CTX \
+	dc->ctx
+
 #define DC_LOGGER \
 	dc->ctx->logger
 
@@ -783,6 +786,33 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 	dc_release_state(current_ctx);
 }
 
+static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	int count = 0;
+	struct pipe_ctx *pipe;
+	PERF_TRACE();
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->plane_state)
+			continue;
+
+		/* Timeout 100 ms */
+		while (count < 100000) {
+			/* Must set to false to start with, due to OR in update function */
+			pipe->plane_state->status.is_flip_pending = false;
+			dc->hwss.update_pending_status(pipe);
+			if (!pipe->plane_state->status.is_flip_pending)
+				break;
+			udelay(1);
+			count++;
+		}
+		ASSERT(!pipe->plane_state->status.is_flip_pending);
+	}
+	PERF_TRACE();
+}
+
 /*******************************************************************************
  * Public functions
  ******************************************************************************/
@@ -1224,9 +1254,12 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 
 	dc_enable_stereo(dc, context, dc_streams, context->stream_count);
 
-	if (!dc->optimize_seamless_boot)
-			/* pplib is notified if disp_num changed */
-			dc->hwss.optimize_bandwidth(dc, context);
+	if (!dc->optimize_seamless_boot) {
+		/* Must wait for no flips to be pending before doing optimize bw */
+		wait_for_no_pipes_pending(dc, context);
+		/* pplib is notified if disp_num changed */
+		dc->hwss.optimize_bandwidth(dc, context);
+	}
 
 	for (i = 0; i < context->stream_count; i++)
 		context->streams[i]->mode_changed = false;
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
