Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A32C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B46A21D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Rqg62jcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B46A21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A2C6E94D;
	Thu, 10 Sep 2020 13:47:45 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700085.outbound.protection.outlook.com [40.107.70.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156BD6E955
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1gn4Q5UMbBLHEoLbqrhAUXjC9y5uO2w+Z8XOaSHo4/1865Ke+uLnIkdJaPwLNwP5KZyj4h7X/NKoKu++iZsMiFYbbJ7gHwzHoGDfBJ/I7hSxdTtMvh9qvsQb1Ukqjot6t7PIMBLBhU5lZpskn7Y5cRrH/SO0n9L/Qk5H9kYvjcCGdcsbbeY6CJlnby0o4A5rHTj6C2oz4lZiWCXlAvkLyKugIWeMk45D+zzrV4/L22+22UVZLlGJnQk2ugwyTD8yCYwRGvf33aVsfinS4Idkg1M+ljPT5vFX0q4iR7F3PEujuY6j0s/sxx9xeogI03oz2iaPi81ka0nfWKTX5dkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngGvPaAogeHVcZeWbwzDQbxEexyLLp88ktN+ONfc7ho=;
 b=HQsOu5An+Q8dSPHXr8IHCb88GcA28UGDn8St8tNwc0y8ugAciptgQFgWrOyl7uzqHF9bGfMHCNPANIh8Qdzq3cZHPwD+/g/QmHtdgRb8/IOHPM+i81VHmZl86kqlRjHxD9LAkzvdkr/3eYm3LEmbrboxu0B/HPYAzSFpsocoxDCjDYA+cUxlAsOJqO3pR2Hp9/w7qIacRe7amdNKOpPKb+pX6gEYqIlh7uorScXrnoMiJRzanvvCHs7bcmtUvfZFs2Nviad9BYXZDc5PTGc0JfQxn9i6SngvtkmBLC8E2i6fy1iXXOZRNhE4GBND6VfrtKezHhukcf6Fl7RrNeukRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngGvPaAogeHVcZeWbwzDQbxEexyLLp88ktN+ONfc7ho=;
 b=Rqg62jcI9dO+u3QzdrcTpdku/bZxu8pLUydIYoG2Cm0sxpxssK1ZJIQKaoqbVxvnUKD1JWYF15q4jqy3MOHdt4kpmwG3l4qOre8HxADxc78DdpQpoZxoe/EU8C7gA2JguUkW8ED89CSk+OMLKJoc5dGm6jitrPRn99pwYpvaz/c=
Received: from DM5PR04CA0047.namprd04.prod.outlook.com (2603:10b6:3:12b::33)
 by CH2PR12MB3782.namprd12.prod.outlook.com (2603:10b6:610:23::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:41 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::dd) by DM5PR04CA0047.outlook.office365.com
 (2603:10b6:3:12b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:40 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:40 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:39 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/42] drm/amd/display: Multi display cause system lag on mode
 change
Date: Thu, 10 Sep 2020 09:47:05 -0400
Message-ID: <20200910134723.27410-25-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 420347fa-28cf-49d6-4bbf-08d85590165f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3782:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37827EA7BD48D8A0E985BB2E8B270@CH2PR12MB3782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1PLLE+Oh7UcJS6ozFdgXfBEG3O9g1/DeB8TuXbz1bxbLOIkGl+DqmU40fgQ9FxSOIwUO9vTHRjOMXXrmkxNnB8HaogPD62MdGLGZdRlfNnScNXiJAZz3IGtokhTTlWiskW8E2wyBR/HktZ+thCBXQtHVz++j0AhqoOtkVt3rHso/mHMJyRKxZ1E/N76ZoUwrAWX5RO0Wzm5BvATiPO3lJL4jyf08nsH9QCtjctYr913Xqsu1wKoToaU/7ldsdWRkkmB1s5D8rBR4qDEmOqs3HM3iVVhcnL2R+RC5E+yfUa2tIwHG83Fzz0fZ/ZqvpUPy5cpYCOJ7MRyJa3dEzOfLE2elFY0djs/QvTBuXER6s8aPrEfDH3xJHFsBDxchvpjk0QGd3b02e2ujU+Nfuuy4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966005)(8936002)(5660300002)(44832011)(186003)(356005)(70206006)(70586007)(36756003)(6916009)(336012)(2616005)(426003)(83380400001)(86362001)(478600001)(82310400003)(7696005)(82740400003)(47076004)(6666004)(2906002)(8676002)(1076003)(54906003)(26005)(4326008)(316002)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:41.0941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 420347fa-28cf-49d6-4bbf-08d85590165f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3782
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
DCValidator is created/destroyed repeatedly for cofunctional validation
which causes a lot of memory thrashing, particularly when Driver Verifer
is enabled.

[How]
Implement a basic caching algorithm that will cache DCValidator with a
matching topology.  When a match is found, the DCValidator can be
reused.  If there is no match, a new one will be created and inserted
into the cache if there is space or an unreference entry can be evicted.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 511ab25b3f1a..ce5303c76b11 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1481,13 +1481,8 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 	return true;
 }
 
-struct dc_state *dc_create_state(struct dc *dc)
+static void init_state(struct dc *dc, struct dc_state *context)
 {
-	struct dc_state *context = kvzalloc(sizeof(struct dc_state),
-					    GFP_KERNEL);
-
-	if (!context)
-		return NULL;
 	/* Each context must have their own instance of VBA and in order to
 	 * initialize and obtain IP and SOC the base DML instance from DC is
 	 * initially copied into every context
@@ -1495,6 +1490,17 @@ struct dc_state *dc_create_state(struct dc *dc)
 #ifdef CONFIG_DRM_AMD_DC_DCN
 	memcpy(&context->bw_ctx.dml, &dc->dml, sizeof(struct display_mode_lib));
 #endif
+}
+
+struct dc_state *dc_create_state(struct dc *dc)
+{
+	struct dc_state *context = kzalloc(sizeof(struct dc_state),
+					   GFP_KERNEL);
+
+	if (!context)
+		return NULL;
+
+	init_state(dc, context);
 
 	kref_init(&context->refcount);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
