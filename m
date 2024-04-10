Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE0BCD128A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 136AA10F9CB;
	Wed, 10 Apr 2024 21:28:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hrz+rsMw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D1810F9CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqL5DDOB5C8c4KDx+2KGEzn3UD83wrY07c9a6hGiZ6H2cHGOrhjkV41v6FgalTIarU3MNl+PNj+PHF/eFeFl1/CuZSCU/dbE4yJhgl9zjVlS7DIthw8gOOH6G0gHJPoL5C+imewtTRNBXS1IE0yvvoH3E8EQ0xfv4hreUKxSAdU7HehgGMxA8ydvmw9tVrKtj0gC6CunPOv3pVTqaDFbwohXDwOrJ49q0q1vBUWjAjtQEPgCzXlv926H1Zm7D8Oceje277SvXnGTadw/XKgH4E2LAik6IQ8JNGZPjj6n80JdtF+uNSCHuXrXdA0GUnAJkgbTEBtNrtrI0wpj1buhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqK+T0hqP1NdWU/Jl5ohwNv650+nYEgkcrg/yXMZyTQ=;
 b=iChLuu3aT9tAqKoE7SXH1POUX3RITtzDuQo7g72wt25piQXPcwwSDuIFJ5n5akLhmezPeN6O1WKT+n5zcU+9MbwBuNvMd8Hj3tY09u17Flq2v4ywh+0WWh8fhK1Kqs/Liw+xRkuA4mHjsLvDybB1+XTM+NekWXiMXJkQDAfguAY9WkWIAO8uoUP4EXAGtXfDZUca/zwD4GuLccdPRoMj7xD+MDhUMOum+6hCDmBuwd1HmthSjgbouUkf2+LdHPLAs0YJ7XjxPVZI1kjIMh78/ayqOYOeEM4Ak0KbA5wU5d7gMnhahQw3Scs+kegVCjvuW9JSVKG7SsY9OD0pVJllAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqK+T0hqP1NdWU/Jl5ohwNv650+nYEgkcrg/yXMZyTQ=;
 b=Hrz+rsMwV6wfM4/qyvDk1SpyxXG9/mPrADxY3MgWklVfM3+EBsXwbXNTAVBk8H9kjOorX9RksoWR5P21VEkKKdb/h0znL84TX6SS3QRLbl/YxRTIzcRn+Vv7fGUv6YWpiCEczQiK40YaOg3SFnLJV3YYN0pIPjNkPPO7ERZOxB8=
Received: from BN9PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:fb::26)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:19 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::aa) by BN9PR03CA0051.outlook.office365.com
 (2603:10b6:408:fb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:16 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 17/25] drm/amd/display: Update some comments to improve the
 code readability
Date: Wed, 10 Apr 2024 15:26:06 -0600
Message-ID: <20240410212726.1312989-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a23fb4-c67d-46ad-bd3c-08dc59a5242c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdPypK9K7eaQX0UPkcr9C3i4gP6bsBX25/IU6CxufRu1XiK8mVvs6DUIuuhKKPQQYQ2qn2bRAegZA0Qx1HhgiqZZw3TnpMz7j9nHgb40nGqkmfGC0B+08JFwcA4KjvKWACP99KlrmBnIjgiiB2yzV841LgjBDekOIsKoe6pfdkv2HqmiFMApPESf8j1e9msC9INhl8OhP7vpFIJqler1x1kLiKr2YYEOfTnHNfVxhvkE+Hf6EmvhbDwnyLPGpy+AeDU3YFqLpgXS7GXtoVwD4QNHARDMn+edA15GRXU+zWbiiKop3Et2nK0SebamCQCGv5Piq8D0QDkf8bM66ov6ABzE4e40lQpxn2/EuYTZnHQXyVcfedzVNGtC4nYGRb64VZ7bWHa3TCqDzkp4q72b2EeI5j0KCCC40ypGmWWxoi5CxaE+AukJksLCzJF7pKBGdLEpRMzke8Co85sk3kIRIC39MhzdUhK4c3tQuA5nPxOfPoWXNTEsXLnH0s+d8wVYRgwdSACUVaLYgwCoQmaF3fvB/3TVUTzc0WOMPztskCIcC/5YZLO2KxTD6GWjH1KsQPZfYKGxV9GpNBnPUFSLS+S2u27oZFxu0tI0/KiM4JX6XRvVF6VuB3Wjf/JgVddsYGZ8Nuyvv2/o7VDCOh4dVIxgFH+nR5WC2PBjueBWcBD8XCtT6Eph4ksWTZ01LMtdrlVGa2MEwxqrj0cl36cy4mRxp5tiJTZj5aRXBGPVjOWOuw53zNp4Ycd2g4azHgeK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:19.0061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a23fb4-c67d-46ad-bd3c-08dc59a5242c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531
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

This commit updates some comments to be more precise and adds another
small comment to some other parts to improve the code readability.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                 | 10 +++++-----
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h   |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c |  5 +++++
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 188f2d401124..4e36a4f9a4a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -309,12 +309,12 @@ struct dc_dcc_setting {
 	unsigned int max_compressed_blk_size;
 	unsigned int max_uncompressed_blk_size;
 	bool independent_64b_blks;
-	//These bitfields to be used starting with DCN
+	//These bitfields to be used starting with DCN 3.0
 	struct {
-		uint32_t dcc_256_64_64 : 1;//available in ASICs before DCN (the worst compression case)
-		uint32_t dcc_128_128_uncontrained : 1;  //available in ASICs before DCN
-		uint32_t dcc_256_128_128 : 1;		//available starting with DCN
-		uint32_t dcc_256_256_unconstrained : 1;  //available in ASICs before DCN (the best compression case)
+		uint32_t dcc_256_64_64 : 1;//available in ASICs before DCN 3.0 (the worst compression case)
+		uint32_t dcc_128_128_uncontrained : 1;  //available in ASICs before DCN 3.0
+		uint32_t dcc_256_128_128 : 1;		//available starting with DCN 3.0
+		uint32_t dcc_256_256_unconstrained : 1;  //available in ASICs before DCN 3.0 (the best compression case)
 	} dcc_controls;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
index efa2adf4f83d..8da3084d933f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
@@ -147,7 +147,7 @@
 	uint32_t DCN_CUR1_TTU_CNTL1;\
 	uint32_t VMID_SETTINGS_0
 
-
+/*shared with dcn3.x*/
 #define DCN21_HUBP_REG_COMMON_VARIABLE_LIST \
 	DCN2_HUBP_REG_COMMON_VARIABLE_LIST; \
 	uint32_t FLIP_PARAMETERS_3;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c
index 35dd4bac242a..cd2bfcc51276 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubp.c
@@ -77,6 +77,7 @@ static void hubp201_program_requestor(struct hubp *hubp,
 			MRQ_EXPANSION_MODE, rq_regs->mrq_expansion_mode,
 			CRQ_EXPANSION_MODE, rq_regs->crq_expansion_mode);
 
+	/* no need to program PTE */
 	REG_SET_5(DCHUBP_REQ_SIZE_CONFIG, 0,
 		CHUNK_SIZE, rq_regs->rq_regs_l.chunk_size,
 		MIN_CHUNK_SIZE, rq_regs->rq_regs_l.min_chunk_size,
@@ -99,6 +100,10 @@ static void hubp201_setup(
 		struct _vcs_dpi_display_rq_regs_st *rq_regs,
 		struct _vcs_dpi_display_pipe_dest_params_st *pipe_dest)
 {
+	/*
+	 * otg is locked when this func is called. Register are double buffered.
+	 * disable the requestors is not needed
+	 */
 	hubp2_vready_at_or_After_vsync(hubp, pipe_dest);
 	hubp201_program_requestor(hubp, rq_regs);
 	hubp201_program_deadline(hubp, dlg_attr, ttu_attr);
-- 
2.43.0

