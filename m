Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7A5CD1288
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CE5112E75;
	Wed,  3 Apr 2024 19:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aD7uhKrF";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE7B112E70
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMs1yOpaJ0omVbOpAhIrZNZvqGNg8XBHXDBpE824SDZqvTbck8tzCAA1eRneMDp4FUmyn2JRa/BfVGjlWZTSewQ9l9YcMCPjqeomc2rLDs7sUOFw2zf+lBAynbwCeuoRE1U2AXE9+kv28y4JfreWtTPhPnBMW+2JRotzeR1TdSEbXEkfHJLXNwIVCt6hGCA3xwwDxjffjDyVZvif51g9EEufUbGqDkAS1ITE7XvLhdnuGs7HdJPaxNrGaWFq7z1psAo1kllGYVaoa16ELcLSPiHWKonCL+GytOKrvBCWDBQzcr4XfbrSteRW2l3Co4rWRtQ5p8adq1+rH9pFGbsIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzJtFNTsryAlmOx9p0/m1ry+5CqwFtrxcB+9Kt2ZlSY=;
 b=Y3OdexVDf/4gO/bprWPD3BvxXKYrNbksfvNOqJ14vg5Qy5C8jwsGZ+E0KYpWj3o7GOIozAiKvKMtWuMqrJ9a2dXpa1PiA4GurgQsa2KGwRPEIyTXflhKR9BkBs6Ceu31rIqWEwmp5wRkiP1UMJIKPCTc2oxTArOQbLqXiiPo89nkkpG90nf9c7wXFXqBxCdqG4F62xNJ5f9QB4Lgqs/K+ti/LNMvoLlgHMANE9nv0HZu2MAJ/7CiT6kPHlE/6IqgSTRUEJQk49OZt/31+wmGv0R1MEmXEdMDNFvzyCh07Iq+EFaXoksN7Or7X5EkmRgS/Q5gIdobozvvb67F+eC8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzJtFNTsryAlmOx9p0/m1ry+5CqwFtrxcB+9Kt2ZlSY=;
 b=aD7uhKrFiycFa4j2PLGCnoRgcKc9Ce2KyUon5zQRLfXiTOjGUMUyMdwAg1mtZJ9QjcQuCDy4DD1F9XHRJyRzmuHizmuKNaUrAqVRrXgehytND8l5qz6RKJTv2anqtN6uCXvXtF1a+RLiih5KW419F5aetwJomgitgKgeL0PqWYY=
Received: from CH2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:610:60::14)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:32 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::ac) by CH2PR14CA0004.outlook.office365.com
 (2603:10b6:610:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:32 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:31 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Lewis Huang
 <lewis.huang@amd.com>, Anthony Koo <anthony.koo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 01/28] drm/amd/display: Add option to configure mapping policy
 for edp0 on dp1
Date: Wed, 3 Apr 2024 15:48:51 -0400
Message-ID: <20240403195116.25221-2-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 6514dc7b-eb46-4b62-75f6-08dc5417762a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XRTkph3/D4lB65/QCipc9rftiKNx32oUnnrXZcJ1RCE17R3y5AnM1466/R8Su5ghPRRysRawHrakGkkoKL23QPapjPbVRdcaF65OEHsn4uc32FI28TyoWDIaY4KrkuYrcbn+5w3I5F0+5gIsDnHrD59N9j2PZZJNXrlDxdtgCDxjyEjkz2OlN7Cwarog3cnTwfFuRMfVG2CJPjmHtdPmX/fJJIKrrUsCEBCvM3tEaODqfP3n7BreIcV5zxucd7P4OXeMiFgtqYnE6wroqu4ujqsaR3h2ZknybAjj6yHiFBO7URDulGheOyZGuOP6vYD22gkifA2mMl/KvphfSgv0Wt5HuaeaQWWwoPr0EJTq4u8FymUExLzUzMtdXoB9ZHqGwkud86SDKKUBz/GBXyiLDh6r+qTNmixkHakWs28BzffBVb7ZNMLBP1XqN1BYihrGw1UnGajNzhR5ec1f3+Jy0wIUvStvshbKeDSI5oPHDN/h8iHzLe/pRbm5WITiiFKf81uyKdFjufm0gX1/+PPftT2XQviQ4FKMnjfVL84/TC5pq2IJnb8aCulPjwDxerRScANhsUGbVIkL2IJ7NTAPHqV7cdKWojA64AWZyjPP5dP7Ly4eCe6+p/oE6hL+SPYubV15FmI9uhFCNhlfI017GhIxOS0EMUY5giHyKSv4SjDMHkqw5F0Nq2pGmyuObjwPH4B4AB3wRcBr0nr87fXZbbW5nkejcjUze0/kjutIS9miBbBfU3Xxe6UUKSy61K3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:32.2617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6514dc7b-eb46-4b62-75f6-08dc5417762a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
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

From: Lewis Huang <lewis.huang@amd.com>

[Why]
We want flexibility to choose how pwrseq instance is mapped to eDP panel

[How]
Add configuration option to choose the pwrseq mapping policy.
When enabled, allow fixed mapping between DIG inst to pwrseq inst.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Lewis Huang <lewis.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 46be4845ec28..db87f9cdd567 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -437,6 +437,7 @@ struct dc_config {
 	bool usb4_bw_alloc_support;
 	bool allow_0_dtb_clk;
 	bool use_assr_psp_message;
+	bool support_edp0_on_dp1;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index 281be20b1a10..20c6fe48567f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -173,5 +173,12 @@ void dcn31_panel_cntl_construct(
 		break;
 	}
 
-	dcn31_panel_cntl->base.pwrseq_inst = pwrseq_inst;
+	if (dcn31_panel_cntl->base.ctx->dc->config.support_edp0_on_dp1)
+		//If supported, power sequencer mapping shall follow the DIG instance
+		dcn31_panel_cntl->base.pwrseq_inst = pwrseq_inst;
+	else
+		/* If not supported, pwrseq will be assigned in order,
+		 * so first pwrseq will be assigned to first panel instance (legacy behavior)
+		 */
+		dcn31_panel_cntl->base.pwrseq_inst = dcn31_panel_cntl->base.inst;
 }
-- 
2.44.0

