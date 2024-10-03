Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7908CF34D7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597F510E99F;
	Thu,  3 Oct 2024 23:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gCNlhtBu";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5117510E99C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyW0u2GNJjPN25wA5lGi4FGAXEMpM19/r1OMlTEmdHzwJpcWoko8XgMvk/fyxO9OnKoZPlrFKCygxoF2u3sNmQ9SeTRp7Ujptg7eyZTXU6WyHAKPEjpU/ljYs2f3epRGPgN1+mdG78K7CKzsnMr+N59Yht9z4Z6tsFJWzgoW6qv3WWbWOOOz44QtNCPIf1eQ1QcEdWiG5B+/psspIKj4w00po0a9U2YngjB2OPm1VOIOf34xxyXrjcbt2hAAClyWOv4d3Muk5V7vw7EqyJnvVjtsdrdE9jODSMM7/OevD1yAJf9nBA9f2KYKyzBVZ5mZU0C9UJ3aZiUHY1aqdLlpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8r3YCPSZowi2iqxFelxPHeRK3yvqch9Ki4jbvEkZdk=;
 b=SOFtLlFVQUJ9fC3Hm0p4SG/Kz828FIRk11eHxvltgyWGfKNakQKVPTkCogForcKgzG93ezAwoxJD5fgzb3V9khvZsDtC3P5cL90Bm9nDiWYZvOFJNkekoPpOxJ0eu/omF5bbM49/cvDNWjLGdQmLNPiElhikORm8OgJT7v9Tzb2/y0SJtnSA3xxw20AQ5aJsg0QsEuv4n8QDjUnDkaVOuOzeTN0TdYlofbi0748JMETFbw8d/eRNsFUFSEF43Wh0AdP69CnmsJvwZCLN8zloasNeZlfFGErfk95UIZSTtSj+YXIcgr0oYxzS5NMNvMWBSt7unRxnsk72K+VKuwMSww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8r3YCPSZowi2iqxFelxPHeRK3yvqch9Ki4jbvEkZdk=;
 b=gCNlhtBuZKsMgJSga7RY/S99WyhhaZY6BYkcFh60c31WE5JsgnYiEQMR4OobIX4HbQkYECDYV8nIF5z8Z2K5rG/qrvo/6fwdXzRxA4/4t4HqRxdCoOwxLirThjVZFaSdEu54S0DlguZs11Zrys3zbnciPUI0EdpKpgxWmEqbBY8=
Received: from DS7PR03CA0300.namprd03.prod.outlook.com (2603:10b6:5:3ad::35)
 by SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 23:35:48 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::26) by DS7PR03CA0300.outlook.office365.com
 (2603:10b6:5:3ad::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:47 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:45 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Sridevi Arvindekar <sarvinde@amd.com>, "Ariel
 Bernstein" <eric.bernstein@amd.com>
Subject: [PATCH 06/26] drm/amd/display: Assign socclk in dml
Date: Thu, 3 Oct 2024 17:33:24 -0600
Message-ID: <20241003233509.210919-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 252df743-82b1-490e-f13e-08dce4041bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IMpq8yqKposbeFlSvhBw/D9YlYMn+VOeFXuGf9Y9NsIi0jVGP4CfaVq4+zrz?=
 =?us-ascii?Q?jklCWO0ObgFHunSgCqMlrlUjgV4OX2VnQO4fytS4XjaAE8JS+DHV/3tJ6LC/?=
 =?us-ascii?Q?0nSFprxNZ6S9R4h6kiYEPSnGXaEhqULjYHmb6qGp1m5kj/11T/+5UwKCjoHX?=
 =?us-ascii?Q?cIcQ1sntqEXuyK5lLNtarXDK3eXgXl1ENKOxdRGoccUo16lxUqXrIHrxA7GC?=
 =?us-ascii?Q?d3/gKDiDZcdnjbuQE+RqSOLH0ZOwMdkS83Fp2KmnkRklZVK+VIqGPnYOsVhR?=
 =?us-ascii?Q?zhkDTVrcDnybt5oEbhfN2JxNKOUR8p2bMyvD9Sn6SJ40mAQF7v9W6PGU3x2O?=
 =?us-ascii?Q?26HbVTtQmdTe3M9uen647dcm9kNrCIUgysaomhyZsK/NkVXW7uQMV13czetQ?=
 =?us-ascii?Q?9aobcFpKs77J5x8vV2TrwYIGh+PHWwR+3cUVWrAlEeY6OrT5iO4HXefn7REb?=
 =?us-ascii?Q?60++jrrPhGfpTZNwMmmEIvMWr8e+rw3JlsBOQkmlbhD8hr49+VN1Oiy8eysX?=
 =?us-ascii?Q?nNm3T6/kaAS6p5tlsGVajc29focny6yD7vGOalz1pJbeatGaEhfcyjVMYoYt?=
 =?us-ascii?Q?vYGJd5a5urCbgnMg+Nq5+FuQfSJ4fSzWac4+d8Wr/Br/+bf9n6J2Wd9sXyim?=
 =?us-ascii?Q?yfW+8/127QPWBht0/fUR39mpmEXJOmRYxb0Ee3bG0lwrfYxUdafJad/nhL0J?=
 =?us-ascii?Q?JRvJKmdAFe/PRleJiO7vl8JcugZqCXJvvanq9/92L/ogYVNu3DYVDCBIK6nT?=
 =?us-ascii?Q?he9fbrlHL0XhgfYrlQ/uO0/dX3RBmUQAqoOy+gMv/RjmlXL0hejdORXWJufC?=
 =?us-ascii?Q?8V7SQ1Ywg7gfiEN+uVcKN2CmZSsrw86viVyMGaiomoeNTHlNh6R1mQc9COjw?=
 =?us-ascii?Q?ZmyTU/0DhakYzGx1rpyWxHClB0pXNxqidCahzNyNJr8Tll+iOKg3KegZWcMT?=
 =?us-ascii?Q?nEO5+G4U32mWQ4GukQcmT/0zw/j7S2D5C3C+4i3RQHzejmo0Rt+5Po3/2gLj?=
 =?us-ascii?Q?1c9/MC4gN+q815X/SS5BpPrxKpLTDo3wEYdi9VSZ8NMJBVUeWeY5miwm/Vwd?=
 =?us-ascii?Q?Yq7dl+5lwSc6chfBHUYghumzo+TrCMRB29zHXJX+2ja3BelvOkyUgDcr9zaw?=
 =?us-ascii?Q?xYr55GqWmislquj24a0C6nOHRp2clwjUPfmmCYtHxFcxkjUzZa8snpw9+28j?=
 =?us-ascii?Q?RM5k+B/rq1Y8rinvXwaZ/vBVHUs4Uropf/fxXXcaEn/Xd7t1H1Ju8Z5xvroA?=
 =?us-ascii?Q?ZjSjh4ei9quRqFbJ4P8LTGwgwHbrgMzeQWd+BREQEYFrN2m8ypMErslbcKWb?=
 =?us-ascii?Q?I9XLT4FE+QQrtMP/cM3rQv2vx0h+J5dlmqBQGWkU7bYWFM5PmLWsr9q1gQvC?=
 =?us-ascii?Q?3adc9nwA1c9kvNgzSUM65qKJzRcG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:47.4484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 252df743-82b1-490e-f13e-08dce4041bbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928
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

From: Sridevi Arvindekar <sarvinde@amd.com>

Assign socclk_khz value from dcn4x.

Reviewed-by: Ariel Bernstein <eric.bernstein@amd.com>
Signed-off-by: Sridevi Arvindekar <sarvinde@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 8697eac1e1f7..7a01a956e4bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -1036,6 +1036,7 @@ void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx, struct dc_state
 	context->bw_ctx.bw.dcn.clk.p_state_change_support = in_ctx->v21.mode_programming.programming->uclk_pstate_supported;
 	context->bw_ctx.bw.dcn.clk.dtbclk_en = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.dtbrefclk_khz > 0;
 	context->bw_ctx.bw.dcn.clk.ref_dtbclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.dtbrefclk_khz;
+	context->bw_ctx.bw.dcn.clk.socclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.socclk_khz;
 }
 
 void dml21_extract_legacy_watermark_set(const struct dc *in_dc, struct dcn_watermarks *watermark, enum dml2_dchub_watermark_reg_set_index reg_set_idx, struct dml2_context *in_ctx)
-- 
2.45.2

