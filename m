Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7E6C2D0E4
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8362921D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NbbMJEU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8362921D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF7756E934;
	Thu, 10 Sep 2020 13:47:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DFD6E945
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6OR04ZdNCCoF3u0N4M3zX4z/7Zf/2BeJGk+oN91GCKgvqDdLQMpJS5/mPvi4h3jBms/oldfg28kfwIFMM7d6lzV4xHzy88iNzF9i9f3pC8l2/yNz9F0FP+Uw1fClhIPWJVvnuCQ7+QhKmO2l443jestMX3CATRpMYdX67TRuoFwE0UAYLdLHQ5GfwkOC/aQg2AF2Y+I0ncUzSav5b5KqLKPz83pmDbwl1FxIYPTqPZNmTRHrazFUJUbnY6BmrHUcHNxZ4hsG2qqJVky879JUUffzD771fVgKQSraz3mL39pWk8UF+65F46gtHpknk+vmayrsBZ24Zpu63vrmTHnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccfS2J3ryZrhcYLsBKKmIB6RKp7SinejzbxHBWpOlF8=;
 b=RlehH7r+S5mhcd0AJOzaqDrFw+10VGJsSBYElXV/EUEeRZ7T5KONLKc+VlDuLCSVeY2sOjks8TPEWRnqj8VbKflDJZ2W5sbMBdoyLOOhv2dS4fHfn7DwlsiTygII2uUbj0ktD+Imr/zfFaP9lDJ6i2ZjG1AMGhAB64mMEdGH+olJ7ZEtKgeArv5AWstqdh3MzHQ0DANhDUZ9pCE1eTOn8U5ArmBHrY/aM7rEJOxGVxujjMb5WLogMrCwhII93ZbqQ8DaYPQBiBgwQy1bFTXnL18QIk7RVY9pBNaAfd4qsH8AhHHN9ZviioknW64xOqhPzcu27Hq+Txj5pWUCofb5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccfS2J3ryZrhcYLsBKKmIB6RKp7SinejzbxHBWpOlF8=;
 b=NbbMJEU/E7jv5dO2sa4oWUdtKSuPEtIEGlYsbGe5wQ1nLQOUJBebDGHCAnWRKO9sg1175DgjET+o1BXriDVHwkZwrqo0UJagSqa23g3ffGGnrxgA80ped7TMYIhr/Fr1cQJGgd3kWbKoDeS9aCENGMqj/Y9XOLjcYIwTZ43xd7U=
Received: from BN6PR2001CA0028.namprd20.prod.outlook.com
 (2603:10b6:405:16::14) by CY4PR12MB1909.namprd12.prod.outlook.com
 (2603:10b6:903:124::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:38 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::f1) by BN6PR2001CA0028.outlook.office365.com
 (2603:10b6:405:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:38 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:37 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:37 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/42] drm/amd/display: Enabling PSR on DCN30 on driver side
Date: Thu, 10 Sep 2020 09:47:01 -0400
Message-ID: <20200910134723.27410-21-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0f0b4f8-ccd8-473f-9f47-08d8559014ae
X-MS-TrafficTypeDiagnostic: CY4PR12MB1909:
X-Microsoft-Antispam-PRVS: <CY4PR12MB190917C4E24509B51E63EE2E8B270@CY4PR12MB1909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kFgMBj4sbz6Iiv9TYw/sxXJ44ZwvyJTwwsWKuarM4/Z1G2MOhstdoZFagLTvi/pHIYyswCyLXDLK9rgZBfYAc3a5wAff/cixcOhKS2ZgM66QnoQ74lcZp01EyhNnpxTSL++1b7AJ0kjJ2eSKwvb/WR2okgPUGs73hJT1eyunA5rcsQoIgT0k1y4jQlEs023wzTxrnsc9XPpBY31Z23DY/18h5EC4pR8XFlW6mIDjEhBxKhgHqTZZoorltEMFM4e2BpZ9L5kOdYl7JIChKPWMzz7tjXWZpiOKqOyn/0JbzOxuC2L7wPDr9pmDnHLTHmer3nVH5SPH75Xo7NEllLnHIyOR5+lOGwXK9DssfuGLxZSFPqlSPw2a+Ok40LndcByFv0sfxJ7DYVMd1suXfUtsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966005)(44832011)(6666004)(336012)(70206006)(86362001)(36756003)(6916009)(2616005)(70586007)(8676002)(1076003)(8936002)(7696005)(47076004)(186003)(26005)(356005)(81166007)(426003)(478600001)(2906002)(316002)(82310400003)(54906003)(5660300002)(4326008)(83380400001)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:38.3135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f0b4f8-ccd8-473f-9f47-08d8559014ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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
Cc: Zhan Liu <zhan.liu@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhan Liu <zhan.liu@amd.com>

[Why]
PSR needs to be enabled on DCN30. This is the driver part of PSR
enablement.

Also disabled retired DMCU on driver side, since DMCU is
not supported on DCN30 anymore.

[How]
Add necessary changes to enable PSR on DCN30.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c  | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 6746d582d723..88f23f12aeb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -79,6 +79,7 @@
 
 #include "reg_helper.h"
 #include "dce/dmub_abm.h"
+#include "dce/dmub_psr.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
 
@@ -832,7 +833,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
-	.disable_dmcu = true,
+	.disable_dmcu = true, //No DMCU on DCN30
 	.force_abm_enable = false,
 	.timing_trace = false,
 	.clock_trace = true,
@@ -849,10 +850,11 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.underflow_assert_delay_us = 0xFFFFFFFF,
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
+	.disable_psr = false,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-	.disable_dmcu = true,
+	.disable_dmcu = true, //No dmcu on DCN30
 	.force_abm_enable = false,
 	.timing_trace = true,
 	.clock_trace = true,
@@ -865,6 +867,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.scl_reset_length10 = true,
 	.dwb_fi_phase = -1, // -1 = disable
 	.dmub_command_table = true,
+	.disable_psr = true,
 	.enable_tri_buf = true,
 };
 
@@ -1313,6 +1316,9 @@ static void dcn30_resource_destruct(struct dcn30_resource_pool *pool)
 			dce_abm_destroy(&pool->base.multiple_abms[i]);
 	}
 
+	if (pool->base.psr != NULL)
+		dmub_psr_destroy(&pool->base.psr);
+
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
 }
@@ -2624,6 +2630,14 @@ static bool dcn30_resource_construct(
 		}
 	}
 	pool->base.timing_generator_count = i;
+	/* PSR */
+	pool->base.psr = dmub_psr_create(ctx);
+
+	if (pool->base.psr == NULL) {
+		dm_error("DC: failed to create PSR obj!\n");
+		BREAK_TO_DEBUGGER();
+		goto create_fail;
+	}
 
 	/* ABM */
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
