Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C44C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE9A310E627;
	Fri,  6 May 2022 15:43:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E44C10E438
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvOs3YT58nTeWLF5mNB+t10lsBSK6/oeS2DEY3w4g/hEDOelxRsqYcD+6CN7RObDXEYpPFMmv62K80P6vXLwSW+uhrG9gIhCvZC2MrmlGynWyitW3IBUNyF1rfnB9v07i4Z4t4ZyCG1xuivXmXyjBwic5cVIFKyOjawpOgytxRzPc6mG/VVL8J9oVqnieMweV8cvpZpieg+1HnneUzHoC8/aH14qgTecV7irOPY8KrdL9EQavK6gmwNaOC2Ds5NcVrdiQqH8d3mjYgAXLXkKnndU0UkbVBNEXwbwrjigco9R+mu2377D5vWWMSrBo2Rod7UokPJuFP1K69/hoE7Xwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQXtDlGlO6mlzxwH0IKCIxHby2rAlbsI/+3sWg+PfjM=;
 b=b2m6myU7TWNtY1fq48t6OLSAIIOrjJhET4sScUWB9MUBZwh9u6UES628kFSQ5ejBINvRypBA1CIaOWrAJSPaoeouwrKHEOph+pS/D+aehRRnkd+HYzwZg9ogt0bZO6/ESJdjhC2RKPKmcacycc/+gKZYJe/MogoqSKnej4nyoZoNYF+hwPsWqs3CRLkoE1Vpj3ZIhN1uygvq0+hQlZJrpmn25sXNaE5pdSducMfJT0mJTgrLs8Kc5qYr3f4AMAhkeHBIEOROWW/xI/GTu3MWS71w4JdtwtQ4MDnanBDLwLo6GcXyOMKJ+tTPMnhVwIPXTzpOvKg0CPKjeR7jvUeiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQXtDlGlO6mlzxwH0IKCIxHby2rAlbsI/+3sWg+PfjM=;
 b=nBBK9X7srjPZqFrEUC/2szLNmnPKoRpvABCIGRDyzj6/DLURSmXhTqsBAyXVHvwhBoaoN7wiUgunrSgy3qHzg2K9mL6DkZE4qQTrBJq+K4fCmN2yHJ4q3wQ8pahff0hMgUIejE5rG2yy/U1lGmr1q6iN4t8PYa4eYa0y5kuqeXc=
Received: from MW4PR04CA0282.namprd04.prod.outlook.com (2603:10b6:303:89::17)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Fri, 6 May
 2022 15:43:45 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::c1) by MW4PR04CA0282.outlook.office365.com
 (2603:10b6:303:89::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 6 May 2022 15:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:45 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:43:39 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/15] drm/amd/display: remove unnecessary else by
 CONFIG_DRM_AMD_DC_DCN
Date: Fri, 6 May 2022 23:42:12 +0800
Message-ID: <20220506154214.3438665-14-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f921c18-99a2-4bba-208e-08da2f77348b
X-MS-TrafficTypeDiagnostic: PH7PR12MB6468:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB6468472078B3A5B3A1769F33FFC59@PH7PR12MB6468.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMVpG/tFff0dpyjSuUnjoGw9Rk2+W/tjJ6M1Z8/HZz8SPeADisgoCyWUSGKA8e6lR5yxN7Tj2sWH7jxNoYKrXuO2Q80A1ivOFMgFig/rgoLETIyOyERZD0R1u2saAAyRui7CRQ6/CYuq0p3z+F1uPj5oRNrnD6VDbOulfoUgrNQO7dsQsmCKII9y3sCVAMUa49zIClOxooTYSbLZqRKkiIBv2pwgSUIjmvxxTBE1AQrDEKpG4gIM62HQ17rd8M/csR70yOFeyY+xFTQ2yQQzXLkq2WSi0VxkOoqq5+Sh+ARAwzlif2JfVtlQd+KQKSwXYMZT3mdKXQODHHNRE9WyyVxn+rk/8Wqe27Svb/fceJRImYhhqIJeDZUi5ZpAX3QIne8tFWZ6HbEft/y3m+udYHa4yZj63fn9ryqgYQY7WWtvVfLhE13udQiXDEYpfZvmecvNr3Lvb5Z9cliAt6F4NV/rqHPmnSFHRDHcy3jWacXmJUEIMnPM0Vg3sydtxZaoE94go7GFrs9e2Rt0hV430+0fNLL4vbQIWqL9MOHFM8zi8/tINgTMmVFuXOJ+ffCy2kbaLIT9dnoz7YpfGcfS/rs/4rShcqEBNEqUuL1WWEuvhdlmDA4vwsqt9Zc+godGuTZ5g1ZjrZMDk3AC8ZYt5pE74AjhU/SGw/0Xzl+eQYhYpVe603DYaF3DOAcpMT+SF3nJyFIp8u1NSrHdgBepig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(86362001)(8936002)(2906002)(356005)(7696005)(81166007)(6666004)(508600001)(5660300002)(44832011)(54906003)(6916009)(316002)(83380400001)(36860700001)(82310400005)(40460700003)(70206006)(4326008)(336012)(8676002)(426003)(47076005)(70586007)(2616005)(16526019)(1076003)(36756003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:45.3618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f921c18-99a2-4bba-208e-08da2f77348b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[Why & How]
CONFIG_DRM_AMD_DC_DCN is used by pass the compilation failures, but DC
code should be OS-agnostic.

This patch fixes it by removing unnecessasry CONFIG_DRM_AMD_DC_DCN
guards for #if-#else clause.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f702919a2279..6774dd8bb53e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2315,14 +2315,10 @@ enum dc_status resource_map_pool_resources(
 
 	/* Add ABM to the resource if on EDP */
 	if (pipe_ctx->stream && dc_is_embedded_signal(pipe_ctx->stream->signal)) {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (pool->abm)
 			pipe_ctx->stream_res.abm = pool->abm;
 		else
 			pipe_ctx->stream_res.abm = pool->multiple_abms[pipe_ctx->stream_res.tg->inst];
-#else
-		pipe_ctx->stream_res.abm = pool->abm;
-#endif
 	}
 
 	for (i = 0; i < context->stream_count; i++)
-- 
2.35.1

