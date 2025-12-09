Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F9CD1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42DEB10E4CC;
	Tue,  9 Dec 2025 08:57:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XOPQm2w+";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55AB010E4CC
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzzG3qFlwXeGohrNGqEWZ+QQ3Wa4wTX0qyJ0+CX4Q53fZjsfHTesKqzmJsc9g+R6sIwGMsr2sUCujVuWTTzpWbODoAWtW4tX2iRR2nvSmjYEo+c/HgH0yNQkCHEUg/UdszwcL7lqInamWS0SrJPuP84HiVVxNh0NOievF0YrBM6JEld2qa0NlZe2yBwc/CUlRVGAdLOLuuXrmLjxIA1kGCnaMPtrAxDzguFhQNOZXc9e3G95DSeasMlAVzopuK/GOMlN8+vyL0TkLbMsyFNd/45npb2I0FK/SlyLypTci5v/xKKbdKXvMwCirddjO8udKxJAZNW+oJXGbavc6coutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeyVANk1wBBAj+JtA4AMN/ErCpRsjJF2d7azAYlDWy0=;
 b=ShvekM93qzCq3D7buBXnAo1SOzcrKd4EHHzkwGoUiNsc6/VCpELwiYb7FVtlFMd49ljOAQBiMCho5L5hDqL/6yhzpTce5t7fTcZTF3xWLFZRsLxpfo7kCqLqT4I18ROgov1zy3eyhiNvSF4U9iuCGsR/4TpGVO1Nf149QeJlNeAO5ZFw/qCyfKnf92MyEorXOdudIdO6tTMMLODVffWmbXA8/TSXKFZNu0G9mg1FW09vnXVp9V/i7c2pZ2w4CW5ylPjwpKaKe2KCim85FfqukwabdjkWQUJ/8FtZHmvPfa1A2oyEJKAQYlIdpzNh46fIpAKt8Sx1D5RwaJlGr4YM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeyVANk1wBBAj+JtA4AMN/ErCpRsjJF2d7azAYlDWy0=;
 b=XOPQm2w+QInL92VPFO2O5rzNzc5/UDoCLOlsUaPAwnSzmI2SPcBSXl+JVYoOkE8JMKri6iqKmUXlSdawUHumImUyi7gAaBsSmZUJjE0PTNdXlD6YLN8kW+xRCUH4HAjyeeHmAvlg1IwQHGkxWe/QG+q/8gkkAFzD6ri54yHDx1A=
Received: from SA1P222CA0062.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::13)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:57:48 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::92) by SA1P222CA0062.outlook.office365.com
 (2603:10b6:806:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 08:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:57:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 02:57:47 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 00:57:47 -0800
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:57:44 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Swapnil Patel
 <swapnil.patel@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 04/15] drm/amd/display: Fix DP no audio issue
Date: Tue, 9 Dec 2025 16:55:07 +0800
Message-ID: <20251209085702.293682-5-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f54a7e-a43a-4864-22a2-08de370106e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4aCdedUuVB6m78dR5AshSzfK9TM7lXFvPChVANEAgFvMSToXZgaCgxffMTEV?=
 =?us-ascii?Q?Va2H7hbjkbhheegyrZ4fkJc28VlTaXQDMg67JIbJkMOS6iArBSG6vjIYNMGB?=
 =?us-ascii?Q?HGjUb/tpRNH9zx6FrwUqI3pfL+Q5xC9O33X5fN8XBa41Km1ZLCWA0N4L86Fy?=
 =?us-ascii?Q?B1aWEAQy7cUkV6V2mt3NOjEhE6ycYlofQSzWM5yUzBt8nUhnfSLLELs1v9uT?=
 =?us-ascii?Q?fVEDKpPEWSGt/ifCN2L1/CiT3fP51yAQklzJpWCwY5Rgydn1+lK2wYkH6MVY?=
 =?us-ascii?Q?Q4xaB3OTN7+r5n3b8UnHWL69VLPuemYI7lCclpnqUn9SrSbnK4P1cYp3bHwZ?=
 =?us-ascii?Q?UlJKoydJHe6Il0CHkCGXVUJw1LT1JCiLDDaAUvtP+LPAV4MyQ8NvYB4e4JTf?=
 =?us-ascii?Q?YHVNJIlSEUVV03H1j3rZnNXIdk3vKu8K9dm1WatUlF8ABsbzHhh0Tk0NiDkd?=
 =?us-ascii?Q?Oo7QI9nyi3I2Y+ZErHEo7Cz11WHkFNAzQ3jjFalYykdjtYnv3EuXfER1RxFp?=
 =?us-ascii?Q?G5U9DYqNpIubzHE8J0bJB7qzqMfJPrNzF9kHZRnPD5A69Se3mgvacoO2WHBh?=
 =?us-ascii?Q?31TDevMJWt6vlmYhlon7ZMXN1GtZ5+oDL6pB/8aRJBHSzrI0GHrsvTVvV/0Z?=
 =?us-ascii?Q?8btnb0sYZZL8h/SgoDby3pBLmx1q/7o4F9s2gRi63cuFDsfQodEyxlQ5ZIsH?=
 =?us-ascii?Q?/nY9SI+lHNTP23G83uTOz3n+2SayfH3GIVd7PMpXl0+XeLDHZMCgV4+BEjEA?=
 =?us-ascii?Q?26MHKwmIo68cZ6SYaPWH1XZoIvq8/VEetLSsQkq8afv5GNNZ+O9cdOc31kAa?=
 =?us-ascii?Q?rFPZ0I5uptq1K6Eb7jWN4Ja20qd8mgsvKcv2cdfzj37voSofrJUMQm1AObWl?=
 =?us-ascii?Q?aYxvESEy78Fv0ZN4tLIY5seVynH3zmRDWwG8RoMo9XS9vW7bPvRe1+ljNfcb?=
 =?us-ascii?Q?JuLiSb238zMKVnSGF4TYRvS7sCEcdUt08vsYzL9I+KbowkrHm0uzoTVtlTyD?=
 =?us-ascii?Q?68419bt/F78zinmdjF3FPdFvneKlsTMrnR7atztlvbsLWgeXi0Tad713NGEE?=
 =?us-ascii?Q?tjaEmYqac+V8QTwU0tBQ7BcEr4skUMnYo3FgN8rP/EendCQwZMIUDZqdOIFe?=
 =?us-ascii?Q?+4KOSSfko86fKK52S5Lzi3nilh9n+zbt5PP/k43DGb6OLU5Tl6mM+2eToUbd?=
 =?us-ascii?Q?A2ng3F/LyhIDR9BhXaWYI+9lSAMjdPHVnIAIKLmxFtl2ReMWoTbP2RRxDAl/?=
 =?us-ascii?Q?Uve6CsAZG6D38eN23PrLJylaecm1GMddWqlqu7JRWQOPQ1ZET6mX8o8ioulY?=
 =?us-ascii?Q?ggARbJkl44s3Y+3/1wcRohmlr79z3qjOGqQ9rBs/0ZkXqSKmtj0Shp5aC12d?=
 =?us-ascii?Q?Mgf5cgl3pWorMCidGrwAVI5WPMWcu7rYGyx2b+c0zkauMbQCja2KjAoBAvkg?=
 =?us-ascii?Q?xineknwI6zP/GYYk+ERp0Xu7JBeuSzVfCqgOwr2ZLgja7bgJKUYNjJAdlOYD?=
 =?us-ascii?Q?xECh+mWTF3FD+HnPLv5mUn5vTMhqXPkToeeY515SBNOU+rlp4mQUni80shBD?=
 =?us-ascii?Q?kR611aA0DCRQIN+q+xY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:57:48.2564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f54a7e-a43a-4864-22a2-08de370106e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
need to enable APG_CLOCK_ENABLE enable first
also need to wake up az from D3 before access az block

Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 8 ++++----
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 7e736f2ee701..ebdb885826aa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1098,13 +1098,13 @@ void dce110_enable_audio_stream(struct pipe_ctx *pipe_ctx)
 			if (dc->current_state->res_ctx.pipe_ctx[i].stream_res.audio != NULL)
 				num_audio++;
 		}
+		if (num_audio >= 1 && clk_mgr->funcs->enable_pme_wa) {
+			/*wake AZ from D3 first before access az endpoint*/
+			clk_mgr->funcs->enable_pme_wa(clk_mgr);
+		}
 
 		pipe_ctx->stream_res.audio->funcs->az_enable(pipe_ctx->stream_res.audio);
 
-		if (num_audio >= 1 && clk_mgr->funcs->enable_pme_wa)
-			/*this is the first audio. apply the PME w/a in order to wake AZ from D3*/
-			clk_mgr->funcs->enable_pme_wa(clk_mgr);
-
 		link_hwss->enable_audio_packet(pipe_ctx);
 
 		if (pipe_ctx->stream_res.audio)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 3e6797653223..63cd13d4617a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -297,7 +297,6 @@ void dcn401_init_hw(struct dc *dc)
 			}
 		}
 	}
-
 	for (i = 0; i < res_pool->audio_count; i++) {
 		struct audio *audio = res_pool->audios[i];
 
-- 
2.43.0

