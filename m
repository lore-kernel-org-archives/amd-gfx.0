Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D993FC56202
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C66722D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cEAOPYIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C66722D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42DA6E929;
	Fri, 20 Nov 2020 20:20:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28EA6E920
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDGkk90gzGYrQguhM+lQNsm8sETHBkaYAFYBnPgB2f4dD3wvwevYARFeHp83z7f2yWr47xPQgbeTH/tSsMPe4tLSP4n5nZvqi5ovDgR06or8di6wB1pbHUdberqOyAV4lZ9Vkm5WoNfiYwFiloo/IAnGSibUGG56AaFZhXzZcO8QIqwAJhuUZuwXrz+2VvApGvdv0SMmcm3uIWUUEhUbmDmo7OMnXXRKWyBhJWN581z8bOK1QHQu/U0ZeoBWa74BOauGFluAi2hx2Hjlladm0ckzq5lSx34Xh8tI4DeCuh3OCO5JzV7VPQVx9dcGLbCV0n58vBlo7CkZmBQRIirfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQMJ85Ny9myWQF3xqfkB6YQ60WQ5/hMKZ+REm3u08BY=;
 b=AH/6p+ipDxOTNf+1nej8ii+qnJF0iFkl3eHo+fs9ptTv13/1kI37Kr8POW7nyY6cxHloblQQpt9Yjl5J8zA4I46YF4SGkS3Da7D2udm2Y6JwEgfTlfvPWQZ8W3SRm+ZW5l+8Wie+hutXLicOmzgMwcm+vDkPjYU3UB6BHw8LCT3Sso8/J+MFr3VeJEg2BL6NBUl3mPSzrQrMZ5UNw2frCY24XV745wZyVOkXRrIQhj9TwxOG9eHsEKWqxrvQxPB9s4QpYD8lhMImCVR/2by0L/4hEufsLKO2DGfSEZ/HhIHYB5GPfGC8eMRx2AmFKIQx7jd+su+gihfILDo3+FaT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQMJ85Ny9myWQF3xqfkB6YQ60WQ5/hMKZ+REm3u08BY=;
 b=cEAOPYIrjYZD2DBo8+PF/nW/FuqedVwGXkw8ploh4yoRlqWo+CeZnWqGJgjkrym7CaDUzJdA3pPid6TXCr3PbEh6gom6WqW4tVH8tyUV54fss6xqsKLUciwW90BiHq0n3Bd8BMVLyt7P05HX7vKe46kVSq3WP/QS5tHtX3xYAnA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Fri, 20 Nov
 2020 20:20:27 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:27 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/18] drm/amd/display: expose clk_mgr functions for reuse
Date: Fri, 20 Nov 2020 15:19:47 -0500
Message-Id: <20201120201958.2455002-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05d828ed-ccd6-482e-1fbc-08d88d91b7db
X-MS-TrafficTypeDiagnostic: CH2PR12MB4261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB426146CC5538A4C4CD8CE39F98FF0@CH2PR12MB4261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:78;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DP5qrFmo9em7rGr3u0rc747kWlhQ4pZ9ndqDLk0gZcS3c0tgRXQccZ2qqU6r7qSVRLKb9/FauSjwsvgAYdq0jKliNjlvl/l2yrULDyHbG1X1FL8iFwHPuAVzIragALb4xSMWlb1qbuRKRkMO1+ONv9SeWfozF+c+nMfIeFXThiPiPpdLlaiUfgtV8QC+M/9EOJfLOpABNhTugNIh3k5L7+ohFWsI53N8eTm+5qHdBnSFrA+hVyWNdiyntfAMTTLjol6M/hY9p2pNQGEGFFn3ioZAHmaVWXUw3YjJOjfF+AWMFb07NORv9APSFfybJ+toff6UVi7FRJuUVMGGLeYZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(5660300002)(83380400001)(1076003)(6512007)(66476007)(66556008)(186003)(6486002)(66946007)(4326008)(2906002)(16526019)(86362001)(6916009)(316002)(8936002)(36756003)(6506007)(8676002)(54906003)(52116002)(6666004)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: IXkw914lj+k5yLNGLKPcgaZNyb27UlvT9dR1vZil332ER77R02C9NzvndDgz1jqQ/S3xqoe97BDMtksZR0gHjvfwFEGxUOLww0Zvun/DzWMVg1IG5HP0vuNVuf4qiBuVhj7CJvDctrvn56U/mt8mNWhIFLLoG3I0R9i+snp4bt/SmsHmoF+eN76G5Vy4tpemN4kXvZQAEnjBJ8uftN4LUnaj/F+5/CGNl/uheLpFDbXRYRao1c4T/jA6X+86gzN0JnSqCK70XOiok4/3l2wqyQyX1XOdao97KQWW19PO0XRRCwb64a9MjGVu2PZQLwLHwrsq5bLoDIdTkjBHH3ekMddULG1BECztIbLBUAtQKhSuveXAkry5en2p8QEto72hWna7Pmfw1TEnOPqW28t9YUK7AUnR15h4voLoXO1KKWdkavIKmrt1iWUQ9VEF7UugU1r5G0JlxDyDZ04WAyNlx/lqCGHcTKnI6UYobT03JofaekgWxNIG2+uLMfiu62lhgESxfBBXq8Vaxh0jAmQEZeCGW2DYNi0/kMFlWHVqeSCTC0fP/6JRt92jSl3KxK/NBGXzLMV6lAv9MyvoMMGORyvz6IXKPHRDYkpGXSGLWKRHFQ0b6PYiJizbFuhn006Qp1y9S5WFCxXnM2g+Rtc2naaXs1LdG/edreCb+E7CzEHiwuSV94SHOREIKBPOQ5hptNiq4lv3l0XaByjTwzApRnMYt/xg/6U7lEdbquSLnzmenD2YDEuHahSqlUiU4VnlDjr8pFUkmwVg5cpfoF18lucrn5cLWXF4Wr4wGihK/tWXsh+qJvrdapb+KenDSSp9/uCJwTWx0N1cBSgKd7wyJzg6dz+JqXWUYw2F7q+muJpQDdDdl2Yf2U1uY2eJw5XvLYz8QNviN8wzO+663wSO8vMlcPDJNHo3odE3KX6WdNDiE0+XGzxK4aPE+wcedutQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d828ed-ccd6-482e-1fbc-08d88d91b7db
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:26.9209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k15gvfvx778YdKCXsmp6QWXhAVFQCK3x14JtahuG95OsjbD7ktxUsLKmouXaQZivj3AVJsnsh3OJwlCRF9ZfZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |  8 ++++----
 .../gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 98cbb0ac095c..9a8e66bba9c0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -32,9 +32,9 @@
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
 
-#include "vg_clk_mgr.h"
 
-#include "dcn301_smu.h"
+
+#include "vg_clk_mgr.h"
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dm_helpers.h"
@@ -631,7 +631,7 @@ static unsigned int find_dcfclk_for_voltage(const struct vg_dpm_clocks *clock_ta
 	return 0;
 }
 
-static void vg_clk_mgr_helper_populate_bw_params(
+void vg_clk_mgr_helper_populate_bw_params(
 		struct clk_mgr_internal *clk_mgr,
 		struct integrated_info *bios_info,
 		const struct vg_dpm_clocks *clock_table)
@@ -709,7 +709,7 @@ static struct vg_dpm_clocks dummy_clocks = {
 
 static struct watermarks dummy_wms = { 0 };
 
-static void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
+void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 		struct smu_dpm_clks *smu_dpm_clks)
 {
 	struct vg_dpm_clocks *table = smu_dpm_clks->dpm_clks;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
index 80497df20ba7..b5115b3123a1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
@@ -39,5 +39,15 @@ void vg_clk_mgr_construct(struct dc_context *ctx,
 
 void vg_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr);
 
+#include "dcn301_smu.h"
 void vg_notify_wm_ranges(struct clk_mgr *clk_mgr_base);
+
+void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
+		struct smu_dpm_clks *smu_dpm_clks);
+
+void vg_clk_mgr_helper_populate_bw_params(
+		struct clk_mgr_internal *clk_mgr,
+		struct integrated_info *bios_info,
+		const struct vg_dpm_clocks *clock_table);
+
 #endif //__VG_CLK_MGR_H__
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
