Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B461C4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3765822AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3765822AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E40886EC79;
	Fri,  4 Dec 2020 21:30:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACD56EC79
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:30:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK1m9KffGpWpJMevcb5pRJBpuizn7cB/JqGuX3dmPgkymq0Ol/yjV8jah5fIC27QmyNAIPa64roxj5WLGYtCsua2DbBGVlCA/lLKjPhEDmNFXNuuKD6TCpD7tqlYlvrfim1UVK4aYTxCN+M0PabPV9+VNMhO13uZaHtqxrXeQMwo0M/d3OxfbZfbQSQRKK9ydLL+OwqH2hXms/fZmwPHpI53vpoBqBZ+U6Nzusp+HphuXBgF2vCv5paPQuX2rYntQU+MI/63bfHBVh/A1wxdQwFulSB2hy3hzDk3qkJBZOgszDRejgYzTgblYn/VLhbVNN3DGvafACRI9wXJACIKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dQiu2Ri0O++I9PlUOk//xhe/5HkX5yIdZ+ytoipNH4=;
 b=Cv19a8FUbx24YK9COONxsoKLPsfVw591xx48e+vta3Hn9Y2g8LulIZd4PVgo54dww3I3sd1/Yyf3FFPsFbN9F4bbmHpIik83GMOnNi9up8vOlZ28i9ThZT9nour2mr71P9qqvoHFhtH9Hawed8DswCU4RAuE2DHHrd4/InbvAe51wpGTrvZxoYtSrBo89Bn0b1GzfNGAk2LO5H3S+1qKb6rpSBdy0FKkNR0E0NWQwxkuXPTK5z2uYCPCLJyo1hvglGWohLmI3g8VbZmjjWdn7uj61Co/AsQ/o0/u4rjZTBm7Hz7nm0yrpM1o/th4PKPG+7/lo9DmfyZXA0uokpQDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dQiu2Ri0O++I9PlUOk//xhe/5HkX5yIdZ+ytoipNH4=;
 b=n6yZ3my5s5gpzcod5kaOPjCPK1qBdxAaxf2FIke9P0clDlLd/TEYWcEppkyDCGfSGyXaxEa6Vp8TUt7yZz8cmOzWTaAIOr5GgSoSdmPsQVyMYjeAMqhzM3+z0bA8LnAuAC2rvAQ2Cw8hsaUHQ9Mw53a+w3gkE2H/FcYEXwpoc9E=
Received: from BN6PR10CA0026.namprd10.prod.outlook.com (2603:10b6:404:109::12)
 by MN2PR12MB3901.namprd12.prod.outlook.com (2603:10b6:208:16c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 21:30:56 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::b5) by BN6PR10CA0026.outlook.office365.com
 (2603:10b6:404:109::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 21:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:30:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:36 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:36 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:30:30 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/17] drm/amd/display: Use provided offset for DPG generation
Date: Fri, 4 Dec 2020 16:28:42 -0500
Message-ID: <20201204212850.224596-10-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1809043e-54fd-4a6a-7a07-08d8989be240
X-MS-TrafficTypeDiagnostic: MN2PR12MB3901:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39014A0F25CE49EF1F1BA35CE5F10@MN2PR12MB3901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6r+XX2bRIta3gEMTtAWcs/rXCdjdYpr4hRmvZMe6AVBWuOrVroSOJpu0nyvxl9+o/dw8+uxvcI+qpu8+3a9fmKwbNZoynyr/E5NuL2ZkDhDbdfTj3YS35q/Ux8ST+UFryTLpmSaSM+szdUtGnNYV1HoziJfLrv5esB5cSevGuRjUgOKb5RyIgQzGMnKVHacH/qEy2MTLRXX0KRXJg10Nk8GAj2aBIsFwM4MvUfvVdg8K70RzwEzIvOluODXTzFEj11tp53NDBmZwQCi8N2O/X9HriuSvmGBe+rnfAVGbNggTk65rrGFOAZvSDzoEBA9P33cZy1O06U2QyUqXbu1HZ7elHgsRbURbN3Auu75pw9ImjQG2yzXAU57ash+BIW8CYqcGiklyna1DsQuRD7YG4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966005)(81166007)(70206006)(70586007)(83380400001)(86362001)(5660300002)(356005)(44832011)(47076004)(1076003)(336012)(6666004)(2616005)(82310400003)(4326008)(82740400003)(26005)(186003)(8676002)(8936002)(2906002)(316002)(426003)(54906003)(478600001)(6916009)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:30:55.5634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1809043e-54fd-4a6a-7a07-08d8989be240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Samson Tam <Samson.Tam@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[Why]
Currently, the offset provided to dcn30_set_disp_pattern_generator is
not forwarded to OPP for display pattern generation, resulting in
misaligned patterns and test failures.

[How]
Use the provided offset.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 7a7efe9ea961..283995ab9eeb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -832,5 +832,5 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		int width, int height, int offset)
 {
 	pipe_ctx->stream_res.opp->funcs->opp_set_disp_pattern_generator(pipe_ctx->stream_res.opp, test_pattern,
-			color_space, color_depth, solid_color, width, height, 0);
+			color_space, color_depth, solid_color, width, height, offset);
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
