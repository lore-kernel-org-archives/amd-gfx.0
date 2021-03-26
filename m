Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D09C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E560E619FF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E560E619FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876C46F4C5;
	Fri, 26 Mar 2021 22:06:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7A86F4C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCGHQVlpityTymYasK6ey6xPeeFw7J4AlqM5tYv56xLBjR5/BgiIk3R56YYK7DW7vu+47ziAvKJGpwJdTgfMp8XHcx5W8a4kwqcoauRNIkK2U/KlckakQFal9peohyh62F8I5t0YraxuRisH6gExtgNtJeUI/e8OyaYJIi8vAp/Y4uHM0Oj+UGPzGJ0X2Kz06C/a9HeNdHhQSzUilx3U3mUUTeJaiyG194RH38NvA6N/3ZCJAr6dgkvtLhnfEW2sMR7ZkA20ygB43xiM6IL0Mb77TKPw+1fS3VZrz1PKrO7pCe6bzIv06G/hyvI/QyXJlUNnYMiQQnVmIB0PE7QF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xBy7xwvAtTI1opR9tI5O3a0MmYnFi4Oe+dyQ0JhPRw=;
 b=jPE/htphycR3jfAI+wykgPs/q5ULsPaYe82FncP9O+vKIox5CDJwUjsdohg1a8x6xNuukQGn8+T4hYFR7FSYkg6sP4mBjyFYozb7YwfWZSCtEGGEhvsQWIWAyy/uE3c3XnZrstMKujRCzRBM4NR9np5+uL67Z/Bkv7f1r8+I7KGmQTJ7qhh39AN3Fb8rufR0YlIKWKhalfGrjOOPvJPSsaahvmb83oF5qZYlIymzaWstuv5z1rcotw7kd8u+HjFdEL8jxM6MiQmuix7qO/8bAdpHSkrID6R1oT4r28gUA+MJsr5iGgir91ITbHB2flPpVWJXINsZ/a4IqRc551HfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xBy7xwvAtTI1opR9tI5O3a0MmYnFi4Oe+dyQ0JhPRw=;
 b=EgGGnn6t/ISkBWgvwg9lb+rKkfV0C1CCmv4G6KU9ZSArgQ7d2Skd8f+a5G7dZdaUqOHr3W7/RH2WKe9JZuXEEGs57XsgnR0jLk1J2fxrs4PKK+wlpJNCSOao84QpMPU8DRjQWpZRd6gjgFhMydmDM9L054mV3j2gn7DO1OXGYGg=
Received: from DM5PR18CA0062.namprd18.prod.outlook.com (2603:10b6:3:22::24) by
 BL0PR12MB4962.namprd12.prod.outlook.com (2603:10b6:208:17e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 22:06:18 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::16) by DM5PR18CA0062.outlook.office365.com
 (2603:10b6:3:22::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:16 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:15 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/21] drm/amd/display: Set max TTU on DPG enable
Date: Fri, 26 Mar 2021 18:05:30 -0400
Message-ID: <20210326220534.918023-18-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa034664-7d67-4366-f4c4-08d8f0a3617a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4962:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4962CA57E2421FDF16EB5C34EB619@BL0PR12MB4962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xg/Ip2u10uYllTYir1253TgNn7b/JzaYo/UZV5I0EZ5iQS++HNHba79vJlS8MFTypMJnY7G8zr+6ZvnF+E9SEPNemvKer3idS2qgv2tGG4Mo8EFfTipTVUdPAjLx7YNKRS5MGuzYQbEdMi52T9fSCO9Uo//0moW7fWmOEDFUiJTVKp3XVKB5dgfho771ZStB4s4cLDRe4moixGWewK4HwvYJlzUeewG2cvYpfBXr+J3CGusrlpkFa8K0VRxA+1iOXym97sv0iuw2PrtpB6n4T8QjB8Cwc22hG+pBOtg2yuMGCTVBNInvDpz895eBHcyzhtJnQ5LHbfQWzG9IDKPOOHDUsG2biaCSypVG8Vqj3rdAFn2tkVCkZ0XMvFAQk0oWna4bueGqm/fukskviCjPmOABQDNNqPbPRH8RXD9DFMv5GLFRjS7u5EhsjVLr5B4hrXiYuCi00nGmAeguedSyUJC42Jl15PPVGJpjUKH6wFvIEyG5jIMatpsVVGGypvrBToC7cOgmi9N8xFNyCZvmXXd/V6r6x0E89JuaKO0jkWHRecveyuvf+cv6GY2oaw6ggPPRvs1ZiLe2ql2lORj9efaVBoZC1CZY0Dbdj2smYcptxmvjJ22h8rHyIvkZ8HKRUAi4mm2tuBXyprgQjHwQxIIwIe5hrs6S7Jvd3g35sQfI5H5L6ayHXsIcRg2g9Xig
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(82740400003)(70586007)(4326008)(7696005)(2616005)(70206006)(336012)(356005)(426003)(8936002)(6666004)(83380400001)(478600001)(86362001)(81166007)(1076003)(54906003)(316002)(8676002)(47076005)(26005)(36756003)(82310400003)(5660300002)(6916009)(2906002)(36860700001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:17.7789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa034664-7d67-4366-f4c4-08d8f0a3617a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4962
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
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
There is a bug in HW that causes P-State to hang when DPG is enabled in
certain conditions.

[HOW]
The solution is to force MIN_TTU_VBLANK register to maximum value
whenever DPG has been enabled.
Make stream do a full update on test pattern change, so that the TTUs
get updated.
When DPG is enabled, update the ttu_regs.min_ttu_vblank field of each
pipe in the stream's topology to the maximum value (0xffffff).

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c     | 30 +++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h |  1 +
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7a0f5057f0ff..a241b42a2fbb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -49,6 +49,7 @@
 #include "timing_generator.h"
 #include "abm.h"
 #include "virtual/virtual_link_encoder.h"
+#include "hubp.h"
 
 #include "link_hwss.h"
 #include "link_encoder.h"
@@ -2095,6 +2096,10 @@ static enum surface_update_type check_update_surfaces_for_stream(
 	if (stream_status == NULL || stream_status->plane_count != surface_count)
 		overall_type = UPDATE_TYPE_FULL;
 
+	if (stream_update && stream_update->pending_test_pattern) {
+		overall_type = UPDATE_TYPE_FULL;
+	}
+
 	/* some stream updates require passive update */
 	if (stream_update) {
 		union stream_update_flags *su_flags = &stream_update->stream->update_flags;
@@ -2491,6 +2496,14 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				}
 			}
 
+
+			/* Full fe update*/
+			if (update_type == UPDATE_TYPE_FAST)
+				continue;
+
+			if (stream_update->dsc_config)
+				dp_update_dsc_config(pipe_ctx);
+
 			if (stream_update->pending_test_pattern) {
 				dc_link_dp_set_test_pattern(stream->link,
 					stream->test_pattern.type,
@@ -2500,13 +2513,6 @@ static void commit_planes_do_stream_update(struct dc *dc,
 					stream->test_pattern.cust_pattern_size);
 			}
 
-			/* Full fe update*/
-			if (update_type == UPDATE_TYPE_FAST)
-				continue;
-
-			if (stream_update->dsc_config)
-				dp_update_dsc_config(pipe_ctx);
-
 			if (stream_update->dpms_off) {
 				if (*stream_update->dpms_off) {
 					core_link_disable_stream(pipe_ctx);
@@ -2593,6 +2599,16 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
+	if (stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE) {
+		struct pipe_ctx *mpcc_pipe;
+		struct pipe_ctx *odm_pipe;
+
+		for (mpcc_pipe = top_pipe_to_program; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
+			for (odm_pipe = mpcc_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+				odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
+	}
+
+
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			if (should_use_dmub_lock(stream->link)) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 346dcd87dc10..80e1a32bc63d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -29,6 +29,7 @@
 #include "mem_input.h"
 
 #define OPP_ID_INVALID 0xf
+#define MAX_TTU 0xffffff
 
 
 enum cursor_pitch {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
