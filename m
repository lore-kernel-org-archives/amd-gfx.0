Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDB3C2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4420B10EAE3;
	Thu, 20 Jun 2024 16:13:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k1pc846A";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31EFB10EAE3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAVDyfHY9WWXJ3loKQKrKyiA6o7QzFCBTGZB8qoUEScQ+LqS23l6xJ9OTgt75LPDWtHG84zFj3gCtgGqIJdcUxNP1W9zO/6ZiAPuM+at62mSE3YtSr2mbctVfHEnIlfBtQgy1lUNHK16C+KIZiFE0GL0k+FzrujO4b6iqwarNeLKvvgUUvILEF8s5fIj4wFTdBIcVx2At2YWhZzm2zs6JJwiIKI3Dn0zaoILA893hhBHlYpsy8ETLTtAMcybvlOB0XYUKMGZD+z5UI6ltaO27RcG1sayK0SRIBpjrzo8Eo/ZAWBkjBd8sGS0lcT7HdPMHCEW3aXnkkefe1Rj8hNd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K/aQ0y36wpQORBfWowJub/8LrVH0rSpbcm0I94ENXc=;
 b=CdIJXYEn8msUJdHifjkweV6UZQvTIv/GYKVXeUMRlXCn5e6hPaT5lnMiIQRftPdh5J5UA0+b7x5GcHUDRcRfy/FuJ5YklBQXyMZKVGqrHDelAwDi/mWK0zq7u+eeG9eIGuh+uBcVN38qj6mvuu614Up1KlAv2+9wy9pGP26XGC4uO7qArZKL1SK8Oh3JBAGVfUL+pX3h2HryDpSEnEQnYaI+h3lA9McUQ3GfrFfPGr6WzZ3fdOiT8ECU267jVImTlO2JW7mIsV3RDnWbhH/WECvvac+wdTHTdYkuRDaWSP8kX/v8uwgKCMm0YwJCw0FyxLaI73Bjlunzbedf3x3a+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K/aQ0y36wpQORBfWowJub/8LrVH0rSpbcm0I94ENXc=;
 b=k1pc846AWU+rBJegzzg7U1zdj4wTyGrPcx2K3QmSGOCaomjMxtVnXAFvkRueibpU/Pb4a1l3oZnppI0/2u3ESLr3jIkXgRzu61HFV7k2aTj4xlQvHB6+j0XVERShL5AZGcUOmqdWvhc88MkaPGxsDLW8vqlyUMnyIj0vrZ09oiM=
Received: from PH7PR10CA0018.namprd10.prod.outlook.com (2603:10b6:510:23d::15)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 16:12:59 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::48) by PH7PR10CA0018.outlook.office365.com
 (2603:10b6:510:23d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 16:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:12:58 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:12:56 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ivan Lipski <ivlipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 04/39] drm/amd/display: Remove unnecessary variable
Date: Thu, 20 Jun 2024 10:11:10 -0600
Message-ID: <20240620161145.2489774-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ba1147-667a-41f9-3a5b-08dc9143da30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|376011|82310400023|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9nHL0+IAFO9BMQ7OSYy63IqNJ6T9KdkrR42BhSiD+V+UosUiKZWZbyxhtWXd?=
 =?us-ascii?Q?Gu1Tga+DbkTfSRYKDoU5Dx7IVCgWGKR2fRM/dC2nbMJnQqZYlqAaCG4lH7+I?=
 =?us-ascii?Q?t2znPfQlOBsaNsI9Be/MZmQmxLbqoptKW9FSfPiaEarEh5YZPTikHKmVs/Hg?=
 =?us-ascii?Q?ojYgASAkiJ1TVfukzLBCy9pskoGi0JK4J1RicJPD7fAl9fxqobNPCsUG1bDn?=
 =?us-ascii?Q?/5BI67bm8CkchLN1wGkKupqi8ZvIfyPNlcdnh2w2PNzf4S5FC0NS4+hcsReP?=
 =?us-ascii?Q?VYLMiHrAkC7dWp0gbMGApHi5SxXvc9+FVLnNZ9NqGneYew9J6ujQrqkalxiW?=
 =?us-ascii?Q?2Gyf3IrC2Fr9aufKXshTm2IziM9ZwTu4EFFF4XYTY2HZBfRfxU8kR5fb5YMX?=
 =?us-ascii?Q?9ytPpXi8lO3t5IP+6pmGN25JgaBW5Lim1D+r0dfu0X/asExqTpBVxcajF8DS?=
 =?us-ascii?Q?AL0hC43xp2a1Ze92Ah9C2zsj1gnybTxNy0mHk3P9Q9mbIqNkPA0cLqcYXz82?=
 =?us-ascii?Q?XYob/iBKCmh3kMFw3cuMk5cglTDIUzSeNiyxQZdyAMuAhWdvpD3R8s4hV6rz?=
 =?us-ascii?Q?CEIMPSU2UC/e9mrUKHh57c7czjRKe098oaRneSER9Nj18rEBPFiX/bPr9ihX?=
 =?us-ascii?Q?y7sZPXNs/m+3+Xp6OaOROSCyJJ28nFfRLGQ0z4nrgm/9qETxnZ/u9G/Z7xPE?=
 =?us-ascii?Q?AX+GdXStpRFAvegw9tkf9HZZ6tbWogOOjDdSiBKOa1KL8RfAUVusywH2NG0q?=
 =?us-ascii?Q?qxE3SHfbSF6sWiWg6Pg+iN1oaPnTGz+k57eGtLXbYBmJucpSKRRYlVgdQba3?=
 =?us-ascii?Q?cfDzKjH146qPjqupck67ulvb3Z3XN+bM1SWgRbamjzJaovVSIcQbbwUUlwL0?=
 =?us-ascii?Q?bMmeOSyms6E+beJypbRSW1xK3KnoHl0mnEwfIdAJmB4Lltd6JJ0XXnVOHRyd?=
 =?us-ascii?Q?pD5gxicwOAIjPVGGxjxfT+DkMTwg465zW0xhKqjZ7VgjGwjAht36XPAmLsbK?=
 =?us-ascii?Q?HR06AnF3Une3/w9GZFma6VeLUHdm0e6oqCoDZ/Qv8IzzrKmWWEkRP+nGAuqi?=
 =?us-ascii?Q?DpIWMpONRCFycL4U+pFX6kGngzZ3+BbUMPXlEf8Y1PbXs1weAMKND9UgXs2V?=
 =?us-ascii?Q?ykc4vTXUlEENqRDhIs0Brgi6WpWHkruwbKAFt4j18a45BJt/R91wXjLlA9Cx?=
 =?us-ascii?Q?2tjNoZP3jLIFycPgEb0URaAs1d1SEN6bxzBO2PNM7XTK9Sbe/EC0EtlcdxPO?=
 =?us-ascii?Q?vgW1uIGl4QRUWrSJ+d/J24pl51o1vRIdR0KUL08bINq83ySZ8+EJVDm0R2Iz?=
 =?us-ascii?Q?PxTFvjxS2C4KLnKAXH8qYrrTEtmBtuA/GtbOcFzXhMLv8rX8MifndnbA7JRR?=
 =?us-ascii?Q?+ErQ0Q9AWrAlIBQxautgEL2R8ppfWAGOvNPWYwW192BsJRki8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(82310400023)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:12:58.7947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ba1147-667a-41f9-3a5b-08dc9143da30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Coverity analysis flagged this code as DEADCODE because
the condition '(!need_recovery)' is never true.

The variable 'need_recovery' is initialized as 'true',
is not assigned to 'false' anywhere before the
conditional statement.

Since the variable is only used for the conditional check,
but the check can never be true, the variable itself is
redundant.

[HOW]
Removed the variable 'need_recovery'.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 35151dd056cb..4ef329a4d764 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1134,26 +1134,9 @@ static bool dcn10_hw_wa_force_recovery(struct dc *dc)
 {
 	struct hubp *hubp ;
 	unsigned int i;
-	bool need_recover = true;
 
 	if (!dc->debug.recovery_enabled)
 		return false;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx =
-			&dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx != NULL) {
-			hubp = pipe_ctx->plane_res.hubp;
-			if (hubp != NULL && hubp->funcs->hubp_get_underflow_status) {
-				if (hubp->funcs->hubp_get_underflow_status(hubp) != 0) {
-					/* one pipe underflow, we will reset all the pipes*/
-					need_recover = true;
-				}
-			}
-		}
-	}
-	if (!need_recover)
-		return false;
 	/*
 	DCHUBP_CNTL:HUBP_BLANK_EN=1
 	DCHUBBUB_SOFT_RESET:DCHUBBUB_GLOBAL_SOFT_RESET=1
-- 
2.34.1

