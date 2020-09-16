Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF22C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 17:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD2B20731
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 17:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ACWEydos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD2B20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C4D6EA7A;
	Wed, 16 Sep 2020 17:09:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9106EA7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 17:09:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJuBJV4Dns4JGYTfFZoxxy5T8gdKh66eCgK5W/FQzl+EldG6mLY7URwwmRwzmetKx0e8YauH7+LegvP3ouuFtNnG7zC2z3llIee4i1l1Md8DrkgO1PglHRh4QgbzGhitdLT24ucRBEH+27cHE9Tk1J4SqLmIhRRxvTvh5m8jTvdxl8xQhBFlopV+PEsCOSZxdVHRRsQI/kOQpwgnabOI4w4j4Eg9VP3oJoSEJuTFsYdf/5YU4BLPYtN4x0uosQDmmYTz180RMlUnvoSVyM/tN5GGiGajoxe4nfEv4f1HV+rSUzmoksBhNw9GWo090lazdf2H2ghib8vYtzKeIJx9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hrz+mVr2SlfeD48J+Nu3urgpGDPO2/HLr36vQJflgDo=;
 b=VfsPkM0NpovabAWVQ1Rif0D9fMMahsancFkt1fPUJdYEhRtr4Bq4sOqBGFrIJXaNDw+G/pXWn2OXrb0qWamAxbdtUHv92L/Ss9ZxdfkCxWnwEjdZzgbworLBNMcs1/Qh5e8TS37PSNxT83/qtTcx10GWfUlSodAEWyeTc8S9dzrLZLl9l3uxqcFVPHBb91fJEG1GcqtvoHkp1Lyww9DM/w3j+Cmw9Ztu5ADXg5H0NCQTYdH6wGagJ4VDRSXNW+biyIqYOdth9D/ePR+JuEDu0d4fx9P2Z5MfzOrGgWmOm6SeQG1Kzq6hg3MEUOuQ4or2CAPQV1EgzFFU/Bg7EW/7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hrz+mVr2SlfeD48J+Nu3urgpGDPO2/HLr36vQJflgDo=;
 b=ACWEydos8R8dIMYH1bBSUZ/0togNA+YXbivmOO2RVTn2aGZJMKHHTdEcWnRReagQOuv2utp5biPcz12sGOp5a8vFMR21gWqh6u0gTfXkV+3e0OupeN+3Uyho3rQReu5uzPszR4SZ7XMaZV4VFSgUuw9qu/pnWTBvKWsti1ezNoQ=
Received: from MWHPR12CA0043.namprd12.prod.outlook.com (2603:10b6:301:2::29)
 by MN2PR12MB3903.namprd12.prod.outlook.com (2603:10b6:208:15a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 17:09:42 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::6b) by MWHPR12CA0043.outlook.office365.com
 (2603:10b6:301:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 17:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 17:09:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 12:09:41 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 12:09:40 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 12:09:40 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>
Subject: [PATCH] drm/amd/display: Add missing "Copy GSL groups when committing
 a new context"
Date: Wed, 16 Sep 2020 13:08:51 -0400
Message-ID: <20200916170851.2509294-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 165625af-2986-4e8c-5a01-08d85a634d75
X-MS-TrafficTypeDiagnostic: MN2PR12MB3903:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3903B0519F1EB7FD41B909B8F9210@MN2PR12MB3903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHdpHkzAFDl0zhrC5L9Whar/WvpRxb6yOXUbPBiXaVEfEd2JRd4VETVldxoaC3v2G3Pm3CZF4kyhXF7Lc/X3Ap17nlPT3AWs4vvJk+ODFj38IjeDtztSZ9VT4vfcrVIO73RpUy5vHrIp8fGegDBzJb0dX7J9R/HW6emNBZP9IoOiL+IVcDue3BUlsJywD3mPS9VC2bNX8vRMRMfexKn6ULaPhCCouj/xV0G3gUA/8XhvGedZgSGgPHRazbX+p+XGOzXBSap482bYgg+AFQpPg7AFLaeqoRo5VE7SLuN0sAgTAeNkL0so8lc83gVdELuT+SUG0KgllKhnIr+wpTd9ihaDwGwQKFR/f/fqs5KxPlCaW0+dQNuYCY91O1DyvAP9cuGFuE3n10ieVcpsgHLzDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966005)(83380400001)(26005)(7696005)(6666004)(478600001)(5660300002)(82740400003)(336012)(1076003)(37006003)(36756003)(2616005)(54906003)(8676002)(82310400003)(4326008)(70586007)(2906002)(356005)(8936002)(316002)(426003)(47076004)(70206006)(186003)(81166007)(86362001)(6862004)(6636002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 17:09:41.9144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 165625af-2986-4e8c-5a01-08d85a634d75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3903
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
Cc: alexander.deucher@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
"Copy GSL groups when committing a new context" patch was accidentally
removed during a refactor

Patch: 21ffcc94d5b ("drm/amd/display: Copy GSL groups when committing a new context")

[How]
Re add it

Fixes: b6e881c9474 ("drm/amd/display: update navi to use new surface programming behaviour")
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 5720b6e5d321..01530e686f43 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1642,6 +1642,17 @@ void dcn20_program_front_end_for_ctx(
 	struct dce_hwseq *hws = dc->hwseq;
 	DC_LOGGER_INIT(dc->ctx->logger);
 
+	/* Carry over GSL groups in case the context is changing. */
+       for (i = 0; i < dc->res_pool->pipe_count; i++) {
+               struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+               struct pipe_ctx *old_pipe_ctx =
+                       &dc->current_state->res_ctx.pipe_ctx[i];
+
+               if (pipe_ctx->stream == old_pipe_ctx->stream)
+                       pipe_ctx->stream_res.gsl_group =
+                               old_pipe_ctx->stream_res.gsl_group;
+       }
+
 	if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
