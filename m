Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681E5C48BE0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39342611B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39342611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC0B6ED90;
	Thu, 10 Jun 2021 16:29:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25EAB6ED8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLVMWvX1zB5kE+hOZihrDZi9C7kb8EECRbYl2j4CktRI2otpfmTzAqYxALluLCZhTuMm4L9aZzjcG4J6GcvA1JpU2nGthlSdgkzs4bHqU2BHirui8ubR88k+QGIbDkGwHwZgP5ea2Liayz0/7CFZP48Ria4/h+paHE8SLWmPF6/LXK4Tj6W+MaQRxMkGpQPCu04b2CmAx+jH1SUFfarzQ6RzuZCwl0iB54g6x4tq0BdkpJ0x8tkFOZDxQIoxYwU+IQqnPhyMF1gpP66o3e0Ko4aOkfy1oexMhs/pxQ2PdV9kDDSAugn3JpWzOSn7NBmbLMHDzlad0roC3FDYo1n9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdfCBd9bXe/UrjCDWjOrWg5nkP3dCKWJ6rXSU6WUbqY=;
 b=K/gF/D41yJhenKp9nGha089VbEbgmMCdVvUUSVnx3XRvJGHAUr+doCr1L5VyEyIoetzAEZm+eehRmaAD+EeSIF1Q7R6wYINARcYuKZfhoBkOdmYiE2YhQ1Q/jtLLh2WzNljR4Pt3lqsOpepNbh8jVsGdMDINTFkxWNoijgUAXKdUpTE0FskKDyan763YLGFACVZ6AT854Oyxkah9JxogLKQ00NQidHDd0e25FM5kvj74/MaGj8TE8tVrk9eLZ674FmiMMT2Cl1uDAqUaduVGSA547X09Z5170dnKbQigCYc2hBu/hjvbJqL0Ke9I2a0W8B/1+3Qz4zUmxWTsU6eCFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdfCBd9bXe/UrjCDWjOrWg5nkP3dCKWJ6rXSU6WUbqY=;
 b=DckoHcOz4jyMPatZHEaqeReQ+HoSPt6wikTo75zEqh41tzumNkT7r8rvI6LqGO+nL3mCiEzlpoxQyJjbqyYQSSPFt/qYS7qSVXW/hL6Hv6EKn7BTXSNHjSAqtNxob6J3xv+iLU7LfB+OKUScjTJVqUaLxfFmTqWW7E62ew1sVUY=
Received: from MWHPR22CA0044.namprd22.prod.outlook.com (2603:10b6:300:69::30)
 by CY4PR12MB1495.namprd12.prod.outlook.com (2603:10b6:910:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 16:29:16 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::86) by MWHPR22CA0044.outlook.office365.com
 (2603:10b6:300:69::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:14 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:13 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/24] drm/amd/display: Change swizzle visual confirm
 reference pipe
Date: Thu, 10 Jun 2021 12:28:20 -0400
Message-ID: <20210610162838.287723-7-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa910d6e-caca-4246-78ec-08d92c2ce384
X-MS-TrafficTypeDiagnostic: CY4PR12MB1495:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1495B2BA9CC1FB5706E3D3D8EB359@CY4PR12MB1495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2pX8tyL9UozI5T8hYSRJp41kn52VqiauMdOloDO8qZA30Tq/XIMs+D9cU3ThBPOBYlbeDSsPNIzyVz6fgi2uAPOV/93NoIlrgb6CLc4QDs8lktfz7cgU7TCMH42Av8wZxdCX1Lgbk2TIaHP+aXDPuc6Djt/kF2IXp6JAb+scYow5uBYaNCe7fSFOS3vMutQHxonG3yai+Lf/R5qFikxaz5+2//pTKddTaB8s40dDm6+p0DO4Z0jzxg36jy7oXdKBSZsxGisdFE1w50W7Wwh2zyiI1aXyQrF/HcoGSnh1rY3Mif5H28Gk1jkKnnfrw72rGf4nDTYkWBB7anfHM5plUnMSVO0CXHbizLfdtPq4yh/3d1tLy8qakrdwnBZilhLP3/kCwkd0q81rqgFUix80J+DjCC5ghu08M3VhtYkGyrycEDf2qwvSEKN0z003C7pq7z5ZkqgCS0FL0WFFKmJ9vvBIk+vvbiK8EyXjr4MGZc8//OyGyKswNdIeZJ/BBx8f8G4Sc2Gk5yycmXbHFChd1k5Z+pKLMIF9rr5ElSvujNCOs2wklPgHA/DLObjD3Mh2myOpz1wmeMoNzyD+NcMMbE0uk6mVOrY7/uaCYNSv0x5RtymPhs2+whA1eZtpRsFuSlw1cu41Eer3dXWAqbrSH7eZRDEHuIPPSYZHnrn8JCy/E9xalPiH8EvBmtg79VJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39850400004)(136003)(376002)(46966006)(36840700001)(36860700001)(1076003)(2906002)(6666004)(336012)(83380400001)(81166007)(186003)(82740400003)(5660300002)(7696005)(426003)(47076005)(36756003)(356005)(86362001)(8936002)(4326008)(82310400003)(2616005)(478600001)(316002)(70586007)(8676002)(26005)(70206006)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:15.5249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa910d6e-caca-4246-78ec-08d92c2ce384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1495
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Po-Ting Chen <robin.chen@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Po-Ting Chen <robin.chen@amd.com>

[Why]
To change the swizzle visual confirm reference pipe from top pipe to
bottom pipe due to bottom pipe information would be more important
for multiple overlay case.

Signed-off-by: Po-Ting Chen <robin.chen@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 15f987a63025..9039fb134db5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -409,13 +409,13 @@ void get_surface_tile_visual_confirm_color(
 		struct tg_color *color)
 {
 	uint32_t color_value = MAX_TG_COLOR_VALUE;
-	/* Determine the overscan color based on the top-most (desktop) plane's context */
-	struct pipe_ctx *top_pipe_ctx  = pipe_ctx;
+	/* Determine the overscan color based on the bottom-most plane's context */
+	struct pipe_ctx *bottom_pipe_ctx  = pipe_ctx;
 
-	while (top_pipe_ctx->top_pipe != NULL)
-		top_pipe_ctx = top_pipe_ctx->top_pipe;
+	while (bottom_pipe_ctx->bottom_pipe != NULL)
+		bottom_pipe_ctx = bottom_pipe_ctx->bottom_pipe;
 
-	switch (top_pipe_ctx->plane_state->tiling_info.gfx9.swizzle) {
+	switch (bottom_pipe_ctx->plane_state->tiling_info.gfx9.swizzle) {
 	case DC_SW_LINEAR:
 		/* LINEAR Surface - set border color to red */
 		color->color_r_cr = color_value;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
