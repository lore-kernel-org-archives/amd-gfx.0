Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CF9D39015
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00BD710E682;
	Wed, 14 Jan 2026 20:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FaK0Ok+9";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 935D110E682
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKAarbqph6VDy4XHNMveE4CkYOcvH/AIGN8gjdlnsm6sv6VMNpm9wuvl3kYMLe7AuiN737r4z9/X5iuWcgTRjtGnyAWGAzj2dyASmiIxnoAxiiJaYwcMOq+cSvMeRIHl3efvv9Nz7Ys5s2Dz1oQIRd4csZopMzPlNkws546ndlm55X8mmZPSxUivQgEzKEoA3hHHGTlWDRNav86mXd+q4so2h443VSIhaqqN5wWfq6OjbHxMk1UvaftTtreaEcuFvZ5SJs8m0hlS1nZ7dcxk48rwFJ/6EVUETlUyHMrZIltu+6vb11GZVSwBlld5dqISYc3rZjnnoj/YAtWDcvhbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdmNMxD1+vVpFTPKR5HGoa5ibQifUybR7YQL7ltdGXI=;
 b=SSBMQO5AsXMir7+BiGO2auN7J869vaXyrAzlotrWktBpFssByLt1/5ggV58YrEY+C5TsRg6t2BBiekVQQcGaiUtFw5J5KbmPo2CVAAdwJzIfVuYHRqOAP3nAuxh31BPC5eM1rmzvDQRRK3OD31ekA/QCwMLrpqbngn3SVbI5qXjuEPxZHb9da3SOJpUl2CtuaMwChP9lPPdrv9Hz9DbWySVjdnnEEshrbMZradvysGNMuZuMI0m4mz+9nRBKoN5oLZAVGAt+K08krkNUJsvS8RGkQT5cSewXvKhp8qms0DfyoNvEYBJJ3DzhoL/UmEH4wAfTsHqlPv9Ugar8mc0Rxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdmNMxD1+vVpFTPKR5HGoa5ibQifUybR7YQL7ltdGXI=;
 b=FaK0Ok+9xYlI5IjzBMaLmkhxamHF49dFhHBen1PJ+BohmV1lNcLRlsGBEi4ZglJLsONK5ZUS9bIeqPfgb2mKM3NSm0JbclSxfImfLASzicVJ12s5PCgayWb6hvAW5jfJURWrsLVYu9uNr2upT4sFh2n7+ijYX7QmvCcbbLlUfGo=
Received: from SJ0PR13CA0227.namprd13.prod.outlook.com (2603:10b6:a03:2c1::22)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 20:24:10 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::fa) by SJ0PR13CA0227.outlook.office365.com
 (2603:10b6:a03:2c1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 20:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:05 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:05 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Wang, Sung-huai" <Danny.Wang@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 07/14] drm/amd/display: Revert "init dispclk from bootup clock
 for DCN314"
Date: Wed, 14 Jan 2026 15:21:48 -0500
Message-ID: <20260114202421.3654137-8-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff0edbf-17c5-4243-f6c7-08de53aae053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N8vtmqQYRhOBcD7acwlZr9XiO59nOgML77Q7+r8W0l1iOIm8BkIepaXyS8XT?=
 =?us-ascii?Q?yr1/nGomALI0vkUDuj9K8ahkMaB+wWmEXjyr99pw7Pd48F7QU4vHAtKDZBgW?=
 =?us-ascii?Q?neegabMTWtcSAo0v08g7IQUl6UysKH3VsJ7Smk/MLZ2UJNLOmCYwSaw3krNc?=
 =?us-ascii?Q?ckeXnyEAOI20l6/91A1uyPMtSc1z42pLbVHKS61J7kfcUr9cYXfJIszQSC4s?=
 =?us-ascii?Q?RbiUyBuLG5Vz61wwfx32fGjY/AYs+SWcr8sfdTiFtwxK+6BaDXJ6OmR9e88N?=
 =?us-ascii?Q?V/uOgGtJxlYXh+r72D8NJ/CJANVfjvXWxDSvE/32ZTEswkD3EB3C8AlSyMJz?=
 =?us-ascii?Q?/HVEN5nrDhlr61b018LOUtHS+xeXEajOyEirbZYVddVi22DwGXZt9na9QN1R?=
 =?us-ascii?Q?TAKqLdvHQV1TY00E/sWNvS869duJxVWovxKZVb0yuruuXLI3z6kIzQbl/XnQ?=
 =?us-ascii?Q?1hHUK4qdorR4gzs9MnEsInZkhHAZ//9zZFULImJI/GCKCQym/nXwNez1I8BG?=
 =?us-ascii?Q?loEDGmCcsgCi5tQqdH3YgAeGb0u92jJqubPC4WGql48UcfH7xDJJEwQuK/Aw?=
 =?us-ascii?Q?FkqHWUSWstnu456ulEtUflhTyT2aXKNqnEHBKVjC4zzGbnNB8VUG4OiOcr6o?=
 =?us-ascii?Q?dzA9MJ/67fx9ccJUQ1xSBPl6vfat6sC70NijQNFa/9I4qvOO23Y5X2w2JrI4?=
 =?us-ascii?Q?XielihIIqVXv/dvDOrPNmvViBYNn9J4xwyZLu739LCGfr2j9DduQNREmQYTY?=
 =?us-ascii?Q?ET8Ca2nnleLAjcS05ZM7PeL3nzjB/6i/LVuxCv17PcXcFPSNlAd4UiR9IZaD?=
 =?us-ascii?Q?jg/KnYjXZAU2mUQoRPzLyHwQunyzH/GfMOf+KTixl3b1dOqxEtOzKo+MHUBo?=
 =?us-ascii?Q?e1dNY+nox5BxGxfP9SbIIr6/KvrHdkco/59lzo6lqLToGkjhp+odC8TjDFfz?=
 =?us-ascii?Q?JFp2rBTfbVO3QBp9TdjpNbcZRFj5tHhVfwhbTrAXT3T4cbsY7pQKxTcSZSgC?=
 =?us-ascii?Q?WfPvAx6CDNa7htfXqUaHD/fqPb7jpl5Xp9KQYhRK1mOl5OxeFSbDSodq87Zr?=
 =?us-ascii?Q?7eSuRNxo02ptSLcX69+IbZeUCfQUBaFDrrha45mYwVPefahRDVnQJNpNqu6K?=
 =?us-ascii?Q?MlI5TU4xBGqacjS/H99jdjqQghIqFvneDdqX2p+UpbnKqA4emqaJfKf3L4ge?=
 =?us-ascii?Q?Xn3z9BtVSy9UWRicEojwQ7BIFa2S3BWzRxDG8GHvTFglfp89ecxfTY0Hepem?=
 =?us-ascii?Q?RX+qF5qm++zoIarJ20gUEBHh5ayyC1zWj8t9NsXkvz75h03+K3AMiEy70P3u?=
 =?us-ascii?Q?UVd6WNXawaQYK87FI7RZjxKXS+QIVJ9scPBMyoPuAbRkx2x9Iop5O8DGqgCs?=
 =?us-ascii?Q?8/j1AwJxcg3sG1Oc0JmtcGiGtuYRQOiJBodDzP08KqcNFuniiVYeHkNfW1dp?=
 =?us-ascii?Q?qik4y9ouIdqlzM/wYNrz7JSC+z7+xprKrbJSO4YMRSBRrd7wJR6I8bP6Tjgd?=
 =?us-ascii?Q?ND44/NPdLyiKAWKwUPR4bWGuxr3fcWQHWI4lZaDMk9KUkNbkGuwRdvDAzshB?=
 =?us-ascii?Q?1qIN+GEN6nkg37Y84CAFg6t2TsRnwKWRayLD7iAX10FhBPzhegmR7rO6dXij?=
 =?us-ascii?Q?hwX1zDiz5WNHMYL6LZ4WzsXv/32Y42bg43ASI7Z8lsqVwHRmTytGxqBGVELk?=
 =?us-ascii?Q?MqBQbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:10.5551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff0edbf-17c5-4243-f6c7-08de53aae053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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

From: "Wang, Sung-huai" <Danny.Wang@amd.com>

[Why&How]
This reverts commit 7ced27406130.
Due to the change, the display shows garbage on startup.

We have proposed an alternative solution for the original issue. (ee13cf4d5226)

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wang, Sung-huai <Danny.Wang@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 133 +-----------------
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |   5 -
 2 files changed, 4 insertions(+), 134 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index db687a13174d..0cb37827a62b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -77,7 +77,6 @@ static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0,
 #undef DC_LOGGER
 #define DC_LOGGER \
 	clk_mgr->base.base.ctx->logger
-
 #define regCLK1_CLK_PLL_REQ			0x0237
 #define regCLK1_CLK_PLL_REQ_BASE_IDX		0
 
@@ -88,70 +87,8 @@ static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0,
 #define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK	0x0000F000L
 #define CLK1_CLK_PLL_REQ__FbMult_frac_MASK	0xFFFF0000L
 
-#define regCLK1_CLK0_DFS_CNTL				0x0269
-#define regCLK1_CLK0_DFS_CNTL_BASE_IDX		0
-#define regCLK1_CLK1_DFS_CNTL				0x026c
-#define regCLK1_CLK1_DFS_CNTL_BASE_IDX		0
-#define regCLK1_CLK2_DFS_CNTL				0x026f
-#define regCLK1_CLK2_DFS_CNTL_BASE_IDX		0
-#define regCLK1_CLK3_DFS_CNTL				0x0272
-#define regCLK1_CLK3_DFS_CNTL_BASE_IDX		0
-#define regCLK1_CLK4_DFS_CNTL				0x0275
-#define regCLK1_CLK4_DFS_CNTL_BASE_IDX		0
-#define regCLK1_CLK5_DFS_CNTL				0x0278
-#define regCLK1_CLK5_DFS_CNTL_BASE_IDX		0
-
-#define regCLK1_CLK0_CURRENT_CNT			0x02fb
-#define regCLK1_CLK0_CURRENT_CNT_BASE_IDX	0
-#define regCLK1_CLK1_CURRENT_CNT			0x02fc
-#define regCLK1_CLK1_CURRENT_CNT_BASE_IDX	0
-#define regCLK1_CLK2_CURRENT_CNT			0x02fd
-#define regCLK1_CLK2_CURRENT_CNT_BASE_IDX	0
-#define regCLK1_CLK3_CURRENT_CNT			0x02fe
-#define regCLK1_CLK3_CURRENT_CNT_BASE_IDX	0
-#define regCLK1_CLK4_CURRENT_CNT			0x02ff
-#define regCLK1_CLK4_CURRENT_CNT_BASE_IDX	0
-#define regCLK1_CLK5_CURRENT_CNT			0x0300
-#define regCLK1_CLK5_CURRENT_CNT_BASE_IDX	0
-
-#define regCLK1_CLK0_BYPASS_CNTL			0x028a
-#define regCLK1_CLK0_BYPASS_CNTL_BASE_IDX	0
-#define regCLK1_CLK1_BYPASS_CNTL			0x0293
-#define regCLK1_CLK1_BYPASS_CNTL_BASE_IDX	0
 #define regCLK1_CLK2_BYPASS_CNTL			0x029c
 #define regCLK1_CLK2_BYPASS_CNTL_BASE_IDX	0
-#define regCLK1_CLK3_BYPASS_CNTL			0x02a5
-#define regCLK1_CLK3_BYPASS_CNTL_BASE_IDX	0
-#define regCLK1_CLK4_BYPASS_CNTL			0x02ae
-#define regCLK1_CLK4_BYPASS_CNTL_BASE_IDX	0
-#define regCLK1_CLK5_BYPASS_CNTL			0x02b7
-#define regCLK1_CLK5_BYPASS_CNTL_BASE_IDX	0
-
-#define regCLK1_CLK0_DS_CNTL				0x0283
-#define regCLK1_CLK0_DS_CNTL_BASE_IDX		0
-#define regCLK1_CLK1_DS_CNTL				0x028c
-#define regCLK1_CLK1_DS_CNTL_BASE_IDX		0
-#define regCLK1_CLK2_DS_CNTL				0x0295
-#define regCLK1_CLK2_DS_CNTL_BASE_IDX		0
-#define regCLK1_CLK3_DS_CNTL				0x029e
-#define regCLK1_CLK3_DS_CNTL_BASE_IDX		0
-#define regCLK1_CLK4_DS_CNTL				0x02a7
-#define regCLK1_CLK4_DS_CNTL_BASE_IDX		0
-#define regCLK1_CLK5_DS_CNTL				0x02b0
-#define regCLK1_CLK5_DS_CNTL_BASE_IDX		0
-
-#define regCLK1_CLK0_ALLOW_DS				0x0284
-#define regCLK1_CLK0_ALLOW_DS_BASE_IDX		0
-#define regCLK1_CLK1_ALLOW_DS				0x028d
-#define regCLK1_CLK1_ALLOW_DS_BASE_IDX		0
-#define regCLK1_CLK2_ALLOW_DS				0x0296
-#define regCLK1_CLK2_ALLOW_DS_BASE_IDX		0
-#define regCLK1_CLK3_ALLOW_DS				0x029f
-#define regCLK1_CLK3_ALLOW_DS_BASE_IDX		0
-#define regCLK1_CLK4_ALLOW_DS				0x02a8
-#define regCLK1_CLK4_ALLOW_DS_BASE_IDX		0
-#define regCLK1_CLK5_ALLOW_DS				0x02b1
-#define regCLK1_CLK5_ALLOW_DS_BASE_IDX		0
 
 #define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL__SHIFT	0x0
 #define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV__SHIFT	0x10
@@ -248,8 +185,6 @@ void dcn314_init_clocks(struct clk_mgr *clk_mgr)
 {
 	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
 	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
-	struct clk_mgr_dcn314 *clk_mgr_dcn314 = TO_CLK_MGR_DCN314(clk_mgr_int);
-	struct clk_log_info log_info = {0};
 
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 	// Assumption is that boot state always supports pstate
@@ -265,9 +200,6 @@ void dcn314_init_clocks(struct clk_mgr *clk_mgr)
 			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
 	else
 		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
-
-	dcn314_dump_clk_registers(&clk_mgr->boot_snapshot, &clk_mgr_dcn314->base.base, &log_info);
-	clk_mgr->clks.dispclk_khz =  clk_mgr->boot_snapshot.dispclk * 1000;
 }
 
 void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
@@ -278,7 +210,7 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count;
+	int display_count = 0;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
@@ -287,7 +219,6 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 		return;
 
 	display_count = dcn314_get_active_display_cnt_wa(dc, context);
-
 	/*
 	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
 	 * also if safe to lower is false, we just go in the higher state
@@ -363,7 +294,7 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
-	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
+		(new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
 		int requested_dispclk_khz = new_clocks->dispclk_khz;
 
 		dcn314_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
@@ -374,7 +305,6 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 
 		dcn314_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-
 		dcn314_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
@@ -462,65 +392,10 @@ bool dcn314_are_clock_states_equal(struct dc_clocks *a,
 	return true;
 }
 
-
-static void dcn314_dump_clk_registers_internal(struct dcn35_clk_internal *internal, struct clk_mgr *clk_mgr_base)
-{
-	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-
-	// read dtbclk
-	internal->CLK1_CLK4_CURRENT_CNT = REG_READ(CLK1_CLK4_CURRENT_CNT);
-	internal->CLK1_CLK4_BYPASS_CNTL = REG_READ(CLK1_CLK4_BYPASS_CNTL);
-
-	// read dcfclk
-	internal->CLK1_CLK3_CURRENT_CNT = REG_READ(CLK1_CLK3_CURRENT_CNT);
-	internal->CLK1_CLK3_BYPASS_CNTL = REG_READ(CLK1_CLK3_BYPASS_CNTL);
-
-	// read dcf deep sleep divider
-	internal->CLK1_CLK3_DS_CNTL = REG_READ(CLK1_CLK3_DS_CNTL);
-	internal->CLK1_CLK3_ALLOW_DS = REG_READ(CLK1_CLK3_ALLOW_DS);
-
-	// read dppclk
-	internal->CLK1_CLK1_CURRENT_CNT = REG_READ(CLK1_CLK1_CURRENT_CNT);
-	internal->CLK1_CLK1_BYPASS_CNTL = REG_READ(CLK1_CLK1_BYPASS_CNTL);
-
-	// read dprefclk
-	internal->CLK1_CLK2_CURRENT_CNT = REG_READ(CLK1_CLK2_CURRENT_CNT);
-	internal->CLK1_CLK2_BYPASS_CNTL = REG_READ(CLK1_CLK2_BYPASS_CNTL);
-
-	// read dispclk
-	internal->CLK1_CLK0_CURRENT_CNT = REG_READ(CLK1_CLK0_CURRENT_CNT);
-	internal->CLK1_CLK0_BYPASS_CNTL = REG_READ(CLK1_CLK0_BYPASS_CNTL);
-}
-
-void dcn314_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
+static void dcn314_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
-
-	struct dcn35_clk_internal internal = {0};
-
-	dcn314_dump_clk_registers_internal(&internal, clk_mgr_base);
-
-	regs_and_bypass->dcfclk = internal.CLK1_CLK3_CURRENT_CNT / 10;
-	regs_and_bypass->dcf_deep_sleep_divider = internal.CLK1_CLK3_DS_CNTL / 10;
-	regs_and_bypass->dcf_deep_sleep_allow = internal.CLK1_CLK3_ALLOW_DS;
-	regs_and_bypass->dprefclk = internal.CLK1_CLK2_CURRENT_CNT / 10;
-	regs_and_bypass->dispclk = internal.CLK1_CLK0_CURRENT_CNT / 10;
-	regs_and_bypass->dppclk = internal.CLK1_CLK1_CURRENT_CNT / 10;
-	regs_and_bypass->dtbclk = internal.CLK1_CLK4_CURRENT_CNT / 10;
-
-	regs_and_bypass->dppclk_bypass = internal.CLK1_CLK1_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dppclk_bypass > 4)
-		regs_and_bypass->dppclk_bypass = 0;
-	regs_and_bypass->dcfclk_bypass = internal.CLK1_CLK3_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dcfclk_bypass > 4)
-		regs_and_bypass->dcfclk_bypass = 0;
-	regs_and_bypass->dispclk_bypass = internal.CLK1_CLK0_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dispclk_bypass > 4)
-		regs_and_bypass->dispclk_bypass = 0;
-	regs_and_bypass->dprefclk_bypass = internal.CLK1_CLK2_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dprefclk_bypass > 4)
-		regs_and_bypass->dprefclk_bypass = 0;
-
+	return;
 }
 
 static struct clk_bw_params dcn314_bw_params = {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
index 0577eb527bc3..002c28e80720 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
@@ -65,9 +65,4 @@ void dcn314_clk_mgr_construct(struct dc_context *ctx,
 
 void dcn314_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int);
 
-
-void dcn314_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
-		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info);
-
-
 #endif //__DCN314_CLK_MGR_H__
-- 
2.52.0

