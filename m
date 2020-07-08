Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76D7C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 20:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5007920739
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 20:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dzRM9T28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5007920739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9576E0FD;
	Wed,  8 Jul 2020 20:34:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C846E0FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 20:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7tAqVB7/Yh62ECUC/aLSS+Vflp8aNfaL+7l/ogn+LvEF8Qie3sNBDtyJ0tFEX1K/5SfNFpddLQfFvQs5Giy2tkYq8VSrz8sDZslEitPO7DZOx9I1xz/TT9+6M+Vn4D1Pnkfk6qGsfkG2ZWrju5JpFLXWXQIvkXlM6lGUck14i3wQ9sztQfdxOy2ewavXQ0hg3DrL+3KvqcpfmK04tEmd58EGhJ7i7BcaV+gRlEVU8IQh/oaTeBwrFs8GQC53dckFMlltmWMaLuhXfOmGKZyGOW+cm5gX8k3CC5zO4F17UTEs07Q5ljowcBlBw3zkSVG6i29iKjkX4UCDx9V++gBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MO3GY2qwbeii6Q8k/qb8B/3xiUS//A30yAJCDOg2FA=;
 b=C/SwLxLAWlO76ixp1vdlqdQyRCdl2rIBx15mWahEiMHk2x4Zr20l2/Qr4ebijFrVgq9phkVEe3M0k4vdmWQryKsyo3B+Bmapzzb2gVqQed/hkkFwxyikpfiu7KTnoL5F0v8RdOi9Tm37GCjcU5+JzjEVC/MxQfdKxL/VNnnh5XGvEbzv+3YVpQfQK0FLqRYcdiftufUO6s/DToaarD1zm3oVQivnZlPCF0+mn1gSC1MF0eaW1hw7JyDR3C2qsx6s2YUrsedqruLfxo85jSzetWWr9MK0hS6Qp8uBJ+vQzQZBn+AY9ri5lDEbuYqtALrIlzYp8xjJCfw+0oW+dRsKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MO3GY2qwbeii6Q8k/qb8B/3xiUS//A30yAJCDOg2FA=;
 b=dzRM9T28TQRKQSleNeqlEyJZLGhsVsfTz9nQAboNojX0NV7H6ZeC7kbp53txwgwS0pdJ8K3YsFFqINshxOAjaKkZZJy1HHODGLIzRZnFc2AS0qopcGpgAiuTmzJ7eHWlx+508ysiW9Nxyw53Fz0hF8SpmZthnx17Nd2VrvvLueo=
Received: from DM5PR1101CA0011.namprd11.prod.outlook.com (2603:10b6:4:4c::21)
 by CY4PR12MB1128.namprd12.prod.outlook.com (2603:10b6:903:3e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 20:34:32 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::7) by DM5PR1101CA0011.outlook.office365.com
 (2603:10b6:4:4c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Wed, 8 Jul 2020 20:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3153.24 via Frontend Transport; Wed, 8 Jul 2020 20:34:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jul 2020
 15:34:32 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jul 2020
 15:34:31 -0500
Received: from DESKTOP-3JO4JG6.localdomain (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 8 Jul 2020 15:34:31 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix CSC remap matrix not being applied on
 dcn30
Date: Wed, 8 Jul 2020 16:34:04 -0400
Message-ID: <20200708203404.23838-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966005)(8936002)(4326008)(6666004)(478600001)(26005)(186003)(82310400002)(70586007)(70206006)(83380400001)(336012)(2906002)(54906003)(2616005)(47076004)(316002)(44832011)(1076003)(36756003)(356005)(86362001)(5660300002)(426003)(81166007)(8676002)(82740400003)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa4acc09-82cc-4bba-188d-08d8237e5266
X-MS-TrafficTypeDiagnostic: CY4PR12MB1128:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1128F6BDDABE212D1A0A3B75EC670@CY4PR12MB1128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NoOA/PeFXg5l/6c9vBpA1Nmtpjt+YyI6Lw8KpdSg9ke17Q/vgODwwP1gna9M493qsRlfUV4Rz+axF0wxsDbRG1iH2MRlm2te+k77NkB+IuGHgESbvcWUPQXk2/y2LmqAUJcoyFieOvbNFR6n/X+YrIXeO2RDSa3zxtStBcOaTMHyuYdVi9+XGSaoPC2F/KMHXok/0Xxn/mQvAtNjPGEIB0sXRHrBlZ7i8hrZlQMy5wmV1u6oC6kgWFth+JMo4G2mUxWIdOc7MIYxoqLbuTvmfzVSZXHXSwPawabZ6eLfZdOfeGqYlKXh8HIeu89IvHlE4rUKYhYGtTeVg8eTHI/tffhPfdKma5UfNptHARCgqKtNWMx0RvzSqq47B3pXA4swCFZss91uzRchsvaqIWHxkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 20:34:32.7369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4acc09-82cc-4bba-188d-08d8237e5266
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1128
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
Cc: Aric Cyr <aric.cyr@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
DCN3 has two gamut remap matrices. When using CSC adjustment the CM
remap is set to bypass and MPCC remap is used. However to bypass CM
some state in the context is modified and not restored correctly
resulting in subsequent calls to disable MPCC remap as well.

[How]
Fix logic for save/restore of remap enable flag when programming MPCC
remap matrix.

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 5621c95177d2..7725a406c16e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1482,22 +1482,23 @@ static void dcn20_update_dchubp_dpp(
 
 			memset(&adjust, 0, sizeof(adjust));
 			adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
-			/* save the enablement of gamut remap for dpp*/
+
+			/* save the enablement of gamut remap for dpp */
 			enable_remap_dpp = pipe_ctx->stream->gamut_remap_matrix.enable_remap;
-			/*force bypass gamut remap for dpp/cm*/
+
+			/* force bypass gamut remap for dpp/cm */
 			pipe_ctx->stream->gamut_remap_matrix.enable_remap = false;
 			dc->hwss.program_gamut_remap(pipe_ctx);
-			/*restore gamut remap flag for the top plane and use this remap into mpc*/
-			if (pipe_ctx->top_pipe == NULL)
-				pipe_ctx->stream->gamut_remap_matrix.enable_remap = enable_remap_dpp;
-			else
-				pipe_ctx->stream->gamut_remap_matrix.enable_remap = false;
-
-			if (pipe_ctx->stream->gamut_remap_matrix.enable_remap == true) {
-				adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
-				for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
-					adjust.temperature_matrix[i] =
-						pipe_ctx->stream->gamut_remap_matrix.matrix[i];
+
+			/* restore gamut remap flag and use this remap into mpc */
+			pipe_ctx->stream->gamut_remap_matrix.enable_remap = enable_remap_dpp;
+
+			/* build remap matrix for top plane if enabled */
+			if (enable_remap_dpp && pipe_ctx->top_pipe == NULL) {
+					adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
+					for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
+						adjust.temperature_matrix[i] =
+								pipe_ctx->stream->gamut_remap_matrix.matrix[i];
 			}
 			mpc->funcs->set_gamut_remap(mpc, mpcc_id, &adjust);
 		} else
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
