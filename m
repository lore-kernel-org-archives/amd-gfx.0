Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85311D39015
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D88E10E672;
	Wed, 14 Jan 2026 20:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="alnh/Ylv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0DD10E672
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4bx6dAqtrlhyFvYjcfUj8Qn4oAyljatgjeaDTFyS85MiihanfXj1xnZOs9g+/hg5HaUYvjEAcKyGZMhNUoofu2/tk1M3viV6N1SFepOEmN1BEIfPMICyivtd1nek0cXR6QD0V6jQDE9sQsd0tG8+QVeeQm/zgDlQra1gY05WO8S6jiPXw/9unTSIrW5YpadW4+8wfVrcjd37onTOnVu1Lp2mThzI9/uev2a6/0GAU9+ioxMD00MdxO5kpOP8ne5SqKdwEJPEwxokHajXO0Gk1cjf/u3Xrj7PJ9L0m2c5xkY+1kT+ss1K2LfGK6f0Ac7T9Htpmr0TQ07ykTb+pHieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOuwZGI1l20QYvS5DNdhA4gE8sMD8yDM95CVUnuk39I=;
 b=tpN++J0DDUU4QfyonRYc21SArGXafv0oI4C7L7y/2XwJruhvgdcaMUYoh+m0IPtWmXztlpTS/Ufbz1lE22D8nJAX2JJNiAvJ6woW7+i7a5YNF7icog8pWPFukmkhDQ5QDqJl0WgvXjfh4sKrZ/efhk5+pN440glnFmsiNr2VnPsva7Hdp1/jIFRsTgHzPYc9x0OBwT9w2yxG2IRSfknOIduj/5J1sWQPebUI/NVGI4/gu/OIIrbZA3/esJvdYJ2k9TgCrHBX2/Ry9+JxHYU3w/iTpvzuLT0Mx4ePnFcJOPsaGTEXw2Edv9gtHQp1jU9Nvj3nb5vG7srlALtFfpiHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOuwZGI1l20QYvS5DNdhA4gE8sMD8yDM95CVUnuk39I=;
 b=alnh/YlvNIjV7dmAFVwP/VpONCgu7osAKeel1/9i72sE4G3UWVDlbeW4piKDv4TvoJ/bTlmyrlyRtO5ZrN7X82KoxQRJMw8YSKtHoAU+/kbUxPrhjuEaCiRSzaamQG4254DMlDYgTzgY5QGutMRV1lGT3eU3Fr2plVB1uP3NR78=
Received: from CH0PR03CA0246.namprd03.prod.outlook.com (2603:10b6:610:e5::11)
 by SA5PPF634736581.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 20:24:06 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::e4) by CH0PR03CA0246.outlook.office365.com
 (2603:10b6:610:e5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 20:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:05 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:04 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 06/14] drm/amd/display: Initialize a default to phyd32clk
Date: Wed, 14 Jan 2026 15:21:47 -0500
Message-ID: <20260114202421.3654137-7-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: 44829eb9-a198-4c08-2b10-08de53aadd5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RUdl4FI0qMeHiG0sPbSYukzRwPSXbdlJiXqvC5OB8qVvk+FddVy7qdBFtus4?=
 =?us-ascii?Q?VXU+8kZdz7D1CvT0Mhsd9s0O5WzyZAs1gTKqkwRjb49wcr692hT2Zm6mIU8U?=
 =?us-ascii?Q?XwsuK/rnKzbfj/h+GTkWBbGaY1dHvjwG/qTA97X3zKnR/3vknVCky6duFxii?=
 =?us-ascii?Q?rPyG5/j7emuxEye+gLBJZU/0qffNizEu7PNrkBCy8MTrWcwSVbKztHXUuERj?=
 =?us-ascii?Q?lA3vyaFT5rd43LWvSTlE4Fgr8KJbHQ+ysM2dnjsmMvbiOiq0CkeE1151dm5U?=
 =?us-ascii?Q?+7U5B9W95an7ixxnCzxKWicF3IoSboe1b63/35b8ZDUkQJvCRnePd11KKjaH?=
 =?us-ascii?Q?z2RM8XxZaNALnSecpO0DjgNdmsOZLQ+ZpR6prvSUmZcsxI8S1r+jLgz1Pvx5?=
 =?us-ascii?Q?XMPcJdCvskPnySTK0UXNQz+2X4zXeFICAiUcKs6I6NcYr1LcXTJ55WXzH8oU?=
 =?us-ascii?Q?jfvEtn6WsTkR9UzyD4Hx+eMrnC/oO7AKqKwJYWVWL53y2aUQBMV5UxLTwc+J?=
 =?us-ascii?Q?SjR4XVXzmWKumGJawhY6Okx7e1gSucCkDJihdcc1/0bCVD4EBCMKjP/PW/2u?=
 =?us-ascii?Q?pQwBXv6c4CS1gluihTozC4M24uTFFxUAbdUYpGzcq2RlvRjndIPGEs4p4XZS?=
 =?us-ascii?Q?JD+yPPAGKJK/fSuyY1ew81dfSOnYowDgbx2RfuXdPyj6wXF+ak+DegWLYrvp?=
 =?us-ascii?Q?QAeK+4Q7vfl81qJDr7jyGpl5gcCE99JLbLVkM5r7YXLYykHRgu85CLhLq1q5?=
 =?us-ascii?Q?lrmIhw9Xun6HhsGBCq6zrzqMuakMkkIJ7z3MxgRuuRDL8VVipRebYC0B7Haq?=
 =?us-ascii?Q?hu6YmB9UjpjqSOxQtlj9PnYmCWoF/BNhTbS2w4IEYqnUAenvwdbl9hcrlmNI?=
 =?us-ascii?Q?LD/b4SrH4KtNHTVyDFyLZEsAm7i8bbQPr3OQ2sgf+EaAQi8F1I6TbsKixit2?=
 =?us-ascii?Q?Ayc7aOGXn8u527HW66KJaEvElGhi599/HwJYI/CPGhEN0e0U4RMhJNgBIa0u?=
 =?us-ascii?Q?+9keJMXQQYZF9d1AcDPVqSRYaM1r7E6OmKWwa0QV1wzqaI6+R2ixg6dXgrPS?=
 =?us-ascii?Q?pxOYziyP+nVJKLMZ6LhmJBgrvGjd0rpUPTlOn/G5Q70kfVAFMh2yc5tclvxB?=
 =?us-ascii?Q?MbxU8Cuxjy/QAdjEE63kYAdXrY0SDnvylum1m3g71da0KmLIf8yK4FjT2XUu?=
 =?us-ascii?Q?k1nokwcBL861JV8RCYPIs7dOpuoNZr5UvmRLxFB5PCss79wNaXR0ir+vyU/N?=
 =?us-ascii?Q?QVIfB3SOuORI8VCO3d8eI90pFu/h32evNRU2sAuTpRnLvy/zLY/ce8UaZNvE?=
 =?us-ascii?Q?fEweGK8wG9CIgmO7MQwfsxUI8G6Wa0t5n6Yt1X2hmHeZcjFCQ3H17hr6+URX?=
 =?us-ascii?Q?KTcOJTbQYqPqOk9BwQmRtV9zX/EAV2mbuAxZCgjinaJ5mFkr8OmkJ1vqzrH8?=
 =?us-ascii?Q?sunlRdMuVHnzk4HBPmrj6WPUZXmHx+PHrs+RO4RpRY4G4vHCkMomA3wMkRvc?=
 =?us-ascii?Q?aNNqhE6eBJMCOjDofQXXHipc1A/jJXjimBDWAgrSTmCkq1yXXKzH4AMXNEQn?=
 =?us-ascii?Q?nczYIzSbDVqsmYsGeRDPZUImmmiZUncV0MpThPKt3G0JCVvfaMF/Y7AavYEH?=
 =?us-ascii?Q?ETRzoI5heOIegbZPddkSjQDHC5qhuxhiMBdcKI581iQUxgB/Ezxb0CuzFdCZ?=
 =?us-ascii?Q?MrxBgA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:05.6124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44829eb9-a198-4c08-2b10-08de53aadd5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
phyd32clk may not be assigned before used. Give it a value based
on the default from get_phyd32clk_src().

This is reported as an UNINIT error by Coverity.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 22c1d5e68420..86400938abd2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -948,7 +948,7 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dccg *dccg = dc->res_pool->dccg;
-	enum phyd32clk_clock_source phyd32clk;
+	enum phyd32clk_clock_source phyd32clk = PHYD32CLKA;
 	int dp_hpo_inst = 0;
 	unsigned int tmds_div = PIXEL_RATE_DIV_NA;
 	unsigned int unused_div = PIXEL_RATE_DIV_NA;
-- 
2.52.0

