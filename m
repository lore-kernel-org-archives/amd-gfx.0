Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC56C2D0C6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B438F2077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1ZdoIfJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B438F2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E7996EB76;
	Wed, 11 Dec 2019 15:33:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8BAA6EB73
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hza0SaSg/7ZwyQV1rpYU4DhzHPEuDPU8rJqw3TF3E652ec16kF91EAMeGJBn7I3FlHL9W5qHlWmYJNj1ACOPHbj+uije3aGgHA2Bdh+mxwTgQD3iSUQRjR79cV3PHOmx5oyVtdizSgGtkD0XKB4L98SCQFr+GxK+ULNxDSsFSQltR2Bi/2dDGdr4y295Ps6bpAI5Fz1suf+klNj8HhNDvslLic1ir/EV8hS/pXu3lQPW1+J5Vw8qNTPfUzMN936oWBVoAWLHVr1s7TxOj2JWEBm7jMDa3YV2/sFVATiqujZxfgfIgwh3hoQcHmt0fOmD/FlmCDK+ada2ekGTRtVXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvW8GFkSprXRVRIV4khBKwUXLTfGfuYZLVoI0R2OrFM=;
 b=oOUgHuozuG92T4UQ3GqrIhFUJHqj/dJ1qitmspqjxlwBVW6xuDSPori5rkNKpxwT9t0XjDn7R5yW+76YMYuFlX0RHCp01LQpKJ4JcjQaysL3RJrcxgDrso0wLkhyUbgJQRnRDKQGuCAkeEN1sx9HtFXDhZBHY8BttIWNqZVnBCiAv6gFeqN89e4D4/XlQk2NQ268KK8dv7lRBFiGmF64ftB6TIW6yLK/5ohY041l+hJd5XQPB/EEk3UDQfFtgVQsRV3Fenv/BSdzikt3FQi+zefs9o8tdqxGGqZM4p7oUFkTma/nxdzfP4zdyQmPaAp7zSOtilpT95c4PXAXUjFQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvW8GFkSprXRVRIV4khBKwUXLTfGfuYZLVoI0R2OrFM=;
 b=1ZdoIfJwmlF4ixffsJ86SmtO0oix0i2OohwTUEpbxIyPejyNEnQVV/tGTKfIVWYrGcGyLjWWaCkaxTsoOI3UtjBZAlDqhCcS7M86X4tZ32lhMLnw5Knic/hYpOYEMGPVErsl1zcP2tQQ5wc69yvdtb+ij1iShzCGZHx3NQSmkrI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2426.namprd12.prod.outlook.com (52.132.184.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:20 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:19 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/39] drm/amd/display: Get DMUB registers from ASIC specific
 structs
Date: Wed, 11 Dec 2019 10:32:18 -0500
Message-Id: <20191211153253.2291112-5-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45e02974-fb36-427e-f608-08d77e4f732a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2426:|MW2PR12MB2426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2426F51302DFC15259D7722D985A0@MW2PR12MB2426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(86362001)(6512007)(1076003)(478600001)(54906003)(4326008)(6486002)(66556008)(66476007)(66946007)(2616005)(316002)(2906002)(81156014)(8676002)(26005)(30864003)(36756003)(52116002)(8936002)(186003)(6916009)(81166006)(5660300002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2426;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qn6UOJsWQ6DWChBK59JQ+qxOABCG8tYdy3+iq6yHwIjM2fMWLvxoPxJ3es5YIb25TeCDuHoo0og1IAJXdi7QLkr26Uu5n0UfXgR+1gw4CeHmTWo7igyMkebZnLTFaMVbvt8yWdERk/zpN+FUJzlpdXY/YyS5yBTaFJXHG0Qh7lHxb0a+KnQPUQCqBS84aOHAmz+oNQ3pESqZxePqVK6kHcYXDf3U6SUgtbbzWOnVwh+nrCwqKit418cA2yVkZ1um2zj91oOENnFP1GSmRbo3b/vTBP02pjEN63JVqIY5i+mnUal+1BonznMX5BT9bUFzi5dK5ieTOXnuEFKUAAWW4U5B3NHjOGIkwTPamRORi8tFbMVho8shH8gvYaGf9gk1D54XKfpNBkNcr5bRz2P+cDhgAaao/h4UMomTyy9j7jsTYIF4N8Ht1Z8Y/yDJ8il
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e02974-fb36-427e-f608-08d77e4f732a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:19.9444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3ED5QHu5tKTyaihB7qQd/UvXeZLBEFAsTM/TjDUWSvOrPTrlXaoyfeXCMbC8AwaI7YrXBAtJH+fdrTAZv2shw==
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
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
These values can differ per ASIC and should follow the full DC style
register programming model.

[How]
Define a common list and fill in the common list separately for
dcn20 and dcn21.

Unlike DC we're not using designated initializers for better compiler
compatibility since this resides in the DMUB service.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  25 +++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h | 117 ++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c |  18 +++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.h |   4 +
 .../gpu/drm/amd/display/dmub/src/dmub_reg.h   |  10 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 +
 7 files changed, 176 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
index 528243e35add..689806b6ee31 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
@@ -76,7 +76,7 @@ extern "C" {
 /* Forward declarations */
 struct dmub_srv;
 struct dmub_cmd_header;
-struct dmcu;
+struct dmub_srv_common_regs;
 
 /* enum dmub_status - return code for dmcub functions */
 enum dmub_status {
@@ -307,6 +307,8 @@ struct dmub_srv {
 	volatile const struct dmub_fw_state *fw_state;
 
 	/* private: internal use only */
+	const struct dmub_srv_common_regs *regs;
+
 	struct dmub_srv_base_funcs funcs;
 	struct dmub_srv_hw_funcs hw_funcs;
 	struct dmub_rb inbox1_rb;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 951ea7053c7e..5760f25c3309 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -25,6 +25,7 @@
 
 #include "../inc/dmub_srv.h"
 #include "dmub_reg.h"
+#include "dmub_dcn20.h"
 
 #include "dcn/dcn_2_0_0_offset.h"
 #include "dcn/dcn_2_0_0_sh_mask.h"
@@ -33,6 +34,25 @@
 
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG##seg
 #define CTX dmub
+#define REGS dmub->regs
+
+/* Registers. */
+
+const struct dmub_srv_common_regs dmub_srv_dcn20_regs = {
+#define DMUB_SR(reg) REG_OFFSET(reg),
+	{ DMUB_COMMON_REGS() },
+#undef DMUB_SR
+
+#define DMUB_SF(reg, field) FD_MASK(reg, field),
+	{ DMUB_COMMON_FIELDS() },
+#undef DMUB_SF
+
+#define DMUB_SF(reg, field) FD_SHIFT(reg, field),
+	{ DMUB_COMMON_FIELDS() },
+#undef DMUB_SF
+};
+
+/* Shared functions. */
 
 void dmub_dcn20_reset(struct dmub_srv *dmub)
 {
@@ -47,8 +67,9 @@ void dmub_dcn20_reset_release(struct dmub_srv *dmub)
 	REG_UPDATE(DMCUB_CNTL, DMCUB_SOFT_RESET, 0);
 }
 
-void dmub_dcn20_backdoor_load(struct dmub_srv *dmub, struct dmub_window *cw0,
-			      struct dmub_window *cw1)
+void dmub_dcn20_backdoor_load(struct dmub_srv *dmub,
+			      const struct dmub_window *cw0,
+			      const struct dmub_window *cw1)
 {
 	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
 	REG_UPDATE_2(DMCUB_MEM_CNTL, DMCUB_MEM_READ_SPACE, 0x4,
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index e70a57573467..68af9b190288 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -30,6 +30,123 @@
 
 struct dmub_srv;
 
+/* DCN20 register definitions. */
+
+#define DMUB_COMMON_REGS() \
+	DMUB_SR(DMCUB_CNTL) \
+	DMUB_SR(DMCUB_MEM_CNTL) \
+	DMUB_SR(DMCUB_SEC_CNTL) \
+	DMUB_SR(DMCUB_INBOX1_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_INBOX1_SIZE) \
+	DMUB_SR(DMCUB_INBOX1_RPTR) \
+	DMUB_SR(DMCUB_INBOX1_WPTR) \
+	DMUB_SR(DMCUB_REGION3_CW0_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW1_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW2_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW3_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW4_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW5_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW6_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW7_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW0_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW1_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW2_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW3_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW4_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW5_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW6_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW7_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW0_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW1_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW2_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW3_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW4_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW5_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW6_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW7_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW0_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW1_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW2_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW3_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW4_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW5_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW6_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW7_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION4_OFFSET) \
+	DMUB_SR(DMCUB_REGION4_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION4_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_SCRATCH0) \
+	DMUB_SR(DMCUB_SCRATCH1) \
+	DMUB_SR(DMCUB_SCRATCH2) \
+	DMUB_SR(DMCUB_SCRATCH3) \
+	DMUB_SR(DMCUB_SCRATCH4) \
+	DMUB_SR(DMCUB_SCRATCH5) \
+	DMUB_SR(DMCUB_SCRATCH6) \
+	DMUB_SR(DMCUB_SCRATCH7) \
+	DMUB_SR(DMCUB_SCRATCH8) \
+	DMUB_SR(DMCUB_SCRATCH9) \
+	DMUB_SR(DMCUB_SCRATCH10) \
+	DMUB_SR(DMCUB_SCRATCH11) \
+	DMUB_SR(DMCUB_SCRATCH12) \
+	DMUB_SR(DMCUB_SCRATCH13) \
+	DMUB_SR(DMCUB_SCRATCH14) \
+	DMUB_SR(DMCUB_SCRATCH15) \
+	DMUB_SR(CC_DC_PIPE_DIS)
+
+#define DMUB_COMMON_FIELDS() \
+	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
+	DMUB_SF(DMCUB_CNTL, DMCUB_SOFT_RESET) \
+	DMUB_SF(DMCUB_CNTL, DMCUB_TRACEPORT_EN) \
+	DMUB_SF(DMCUB_MEM_CNTL, DMCUB_MEM_READ_SPACE) \
+	DMUB_SF(DMCUB_MEM_CNTL, DMCUB_MEM_WRITE_SPACE) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_MEM_UNIT_ID) \
+	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW2_TOP_ADDRESS, DMCUB_REGION3_CW2_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW2_TOP_ADDRESS, DMCUB_REGION3_CW2_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW3_TOP_ADDRESS, DMCUB_REGION3_CW3_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW3_TOP_ADDRESS, DMCUB_REGION3_CW3_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW4_TOP_ADDRESS, DMCUB_REGION3_CW4_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW4_TOP_ADDRESS, DMCUB_REGION3_CW4_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW5_TOP_ADDRESS, DMCUB_REGION3_CW5_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW5_TOP_ADDRESS, DMCUB_REGION3_CW5_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_ENABLE) \
+	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_ENABLE) \
+	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE)
+
+struct dmub_srv_common_reg_offset {
+#define DMUB_SR(reg) uint32_t reg;
+	DMUB_COMMON_REGS()
+#undef DMUB_SR
+};
+
+struct dmub_srv_common_reg_shift {
+#define DMUB_SF(reg, field) uint8_t reg##__##field;
+	DMUB_COMMON_FIELDS()
+#undef DMUB_SF
+};
+
+struct dmub_srv_common_reg_mask {
+#define DMUB_SF(reg, field) uint32_t reg##__##field;
+	DMUB_COMMON_FIELDS()
+#undef DMUB_SF
+};
+
+struct dmub_srv_common_regs {
+	const struct dmub_srv_common_reg_offset offset;
+	const struct dmub_srv_common_reg_mask mask;
+	const struct dmub_srv_common_reg_shift shift;
+};
+
+extern const struct dmub_srv_common_regs dmub_srv_dcn20_regs;
+
 /* Hardware functions. */
 
 void dmub_dcn20_init(struct dmub_srv *dmub);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
index 9cea7a2d8dbf..770d585168aa 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
@@ -25,6 +25,7 @@
 
 #include "../inc/dmub_srv.h"
 #include "dmub_reg.h"
+#include "dmub_dcn21.h"
 
 #include "dcn/dcn_2_1_0_offset.h"
 #include "dcn/dcn_2_1_0_sh_mask.h"
@@ -32,6 +33,23 @@
 
 #define BASE_INNER(seg) DMU_BASE__INST0_SEG##seg
 #define CTX dmub
+#define REGS dmub->regs
+
+/* Registers. */
+
+const struct dmub_srv_common_regs dmub_srv_dcn21_regs = {
+#define DMUB_SR(reg) REG_OFFSET(reg),
+	{ DMUB_COMMON_REGS() },
+#undef DMUB_SR
+
+#define DMUB_SF(reg, field) FD_MASK(reg, field),
+	{ DMUB_COMMON_FIELDS() },
+#undef DMUB_SF
+
+#define DMUB_SF(reg, field) FD_SHIFT(reg, field),
+	{ DMUB_COMMON_FIELDS() },
+#undef DMUB_SF
+};
 
 static inline void dmub_dcn21_translate_addr(const union dmub_addr *addr_in,
 					     uint64_t fb_base,
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
index f7a93a5dcfa5..0728b74b68cf 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
@@ -28,6 +28,10 @@
 
 #include "dmub_dcn20.h"
 
+/* Registers. */
+
+extern const struct dmub_srv_common_regs dmub_srv_dcn21_regs;
+
 /* Hardware functions. */
 
 void dmub_dcn21_backdoor_load(struct dmub_srv *dmub,
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.h
index bac4ee8f745f..c1f4030929a4 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.h
@@ -34,11 +34,15 @@ struct dmub_srv;
 
 #define BASE(seg) BASE_INNER(seg)
 
-#define REG_OFFSET(base_index, addr) (BASE(base_index) + addr)
+#define REG_OFFSET(reg_name) (BASE(mm##reg_name##_BASE_IDX) + mm##reg_name)
 
-#define REG(reg_name) REG_OFFSET(mm ## reg_name ## _BASE_IDX, mm ## reg_name)
+#define FD_SHIFT(reg_name, field) reg_name##__##field##__SHIFT
 
-#define FD(reg_field) reg_field ## __SHIFT,  reg_field ## _MASK
+#define FD_MASK(reg_name, field) reg_name##__##field##_MASK
+
+#define REG(reg) (REGS)->offset.reg
+
+#define FD(reg_field) (REGS)->shift.reg_field, (REGS)->mask.reg_field
 
 #define FN(reg_name, field) FD(reg_name##__##field)
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 5f39166d3c08..f530325a221f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -69,6 +69,8 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 	switch (asic) {
 	case DMUB_ASIC_DCN20:
 	case DMUB_ASIC_DCN21:
+		dmub->regs = &dmub_srv_dcn20_regs;
+
 		funcs->reset = dmub_dcn20_reset;
 		funcs->reset_release = dmub_dcn20_reset_release;
 		funcs->backdoor_load = dmub_dcn20_backdoor_load;
@@ -80,6 +82,8 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->is_hw_init = dmub_dcn20_is_hw_init;
 
 		if (asic == DMUB_ASIC_DCN21) {
+			dmub->regs = &dmub_srv_dcn21_regs;
+
 			funcs->backdoor_load = dmub_dcn21_backdoor_load;
 			funcs->setup_windows = dmub_dcn21_setup_windows;
 			funcs->is_auto_load_done = dmub_dcn21_is_auto_load_done;
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
