Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B0BC4450B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F4610F6FA;
	Thu,  9 Jul 2026 21:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iMPATrEU";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013064.outbound.protection.outlook.com
 [40.93.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B771510F6F6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq8eg7LfLdU99cUt/d/4s+2bH4wBWYKiiCRqCp0/YWtQjwIoio05hkQt3OZ678tmY53j87qHgxlyLf3xiSMZ34AD4sbce7KxmQWHgPHuyjT5v7t0y/RIGVQUggggV9XzvdV5NsYJrCoeaJt/EgDlQ1qTO/VMC2zmnqH+gTVfNlYIb2h3Ar+JxwmJl9bNOWkCHjzEWJYKaonHfNQ86bsRs+T8BCvrNFmmH8vaFQVx6fYOU6yLCnd13/ept44X5JUsnJpNdvGlAGAXG0V7ZiJf0fLqP+i6OADZI1LTisAiDmESubLWXXNO9nw8x7TQV0Irpnf7sbET3owtJwBOs9AjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDFVvFeb6GSCEciupCHCY4QXZDdPRkViN43aIHZGKeA=;
 b=dIm6BCo/drICd6VBX5GE1EzGPoD1oPzPYzrdce2jn5JneagV9T+5THLKvM3pHBAbOW//FQNVs1S91NCQIcFROwFYAyEeyZ594skDFfrJKXZr4zioBGZLqd64Ad8EMNFUHeajciQXVIGMYTeiMazOTxdPMxTkog7DMwC0knzRoOdXCJgGLI4GIWl5JwyNkabLKw8/qoh62Cnsee/T4G6lCGxRFmkbE8tx62vmikNZmVRobUOSykMHPQlxyfTY4hB1b4wnY75aLRB2fn4d5hYxp3Zj8iiD7XPUN6dLL5J+eBdsBBA2cRlJLtyccpfMdLaATE4cNMD9i4lq76wVhcUQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDFVvFeb6GSCEciupCHCY4QXZDdPRkViN43aIHZGKeA=;
 b=iMPATrEUREDe1hz4Xx0VdsTCY8tgDbZLwU7nAbDUpi8tl6qB+L+z4m3QB1QNYACTXLg2NpmlkdiUrMx3xriJVSnKGOnox2OWILFlCeK/2EjlRbllHBoRmgDLbDJ6D3+8Qdujxu85sqWzUdeJJXpkKEzpIVkNnA2Xqb12cm94SxM=
Received: from BLAPR03CA0164.namprd03.prod.outlook.com (2603:10b6:208:32f::20)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:39 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32f:cafe::7) by BLAPR03CA0164.outlook.office365.com
 (2603:10b6:208:32f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:39 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:32 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Taimur Hassan <syed.hassan@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 74/80] drm/amd/display: fix dcn42 det allocation order
Date: Thu, 9 Jul 2026 16:48:42 -0400
Message-ID: <20260709205936.5719-75-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: a95032da-9044-4d2a-1fb6-08deddfd68f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xHze0+NjvGUhllAQ0ROSnUG5UySoNQSarux7nS4hVndMWM8n09lZ2iBQiV6OovUEZyHgNIqQUQgKNLP6m6hCWKs8Fln4xCjU/6C5JI1z3htfPAN0AN/WfXPXTb0sB0Uqch6ymK4+3PLkZBsLiqYLIzLPmGT+W/3AX3xEA5IoHrEbw2pmyLNNwcFD1dz6ORw2yQVkIy/WnzRYfAQ/895QwhEOkede9hQunHMnfyDxfsACDRqpBPhcmiHYKwOiBTtMC0FfSxzFL6eMn+K/a3sS8/VtsqUn0vN4YWzBEAm9OFhk4qtj6f930ZloWD4TG7aWNhnpC1DOJst2fo3pRbISNxMJgfGWBBOmnRhPz9TdsHprsH0xDb21KXR/8B6TSHEpazRJZ6zwptCdEG2iZ+2lolvY0WBfbsKk2v0WrZZt5DdCLLcdXuh5xoSQFZpJ4V1HUJnc5aC9T1SDyZwOY85AFnRJGY0BPezG+yGTLhFnyg33Fxf1Glq/M4WUIoWiYJLCDyhiTREHnEHNnLBPh+zI1Y0YIe8FH2D+TKNvqGonb3yM4zt0RUsSpPycJgl+EHcb1NLtllZ5dbOuGBpOxHguZYIklhvaUzvRXBXwBtY/A9hgGzv9hhNZVi2vDD9c81Ad1Wni2JWnT8vwI+mQoFdrJZH8lgmy/aPJDCsndtLEOW2vxDaIYSR8lhbVTPrBZr28gJyhm0fEP48VoBRsGG4Ocw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BjVocf1C/+FQEjaresbbAsWnGVyG5v/T+tM3WsGx9IJXViuxeMKS2E2zwaQAdNySn06rhiR4wnkNMlzyb+yzRdh6yhLpwVHiYQij/AytpnI8t3K8KkfQ42QoFTnlXrIVncfm4wPr/5le7Lz+EpSb5kHTAKBdZceas32xMRzrjdGSrv1uxEtPJCx8vK3flB6JhnpWsOqTuehLXO24lWsNDdIQCL0P/BRL9hFlKZ+tAUojDsCNq5cUiM18hMcDZNaUr7Al+AgqpajUK2p+omiOz1S1Y2noAPtlpBV31d6SD4A8BBwHMDv9JDc8ESjZXu0t4oeoJMUlKr4SABQ0Mn2U+3ptytueQJk5Zkuk9dNI36xTQL+sbpri8TcLU9O9rtN5u0LHTOVGR+g03ag941EdV4YJ+a9MYW8sQYtXVpMtOrXRSv036V6f4GoqZgQCqma3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:39.0094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95032da-9044-4d2a-1fb6-08deddfd68f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

set_pipe_unlock_order needs to be set to true for the pipes to be unlocked
in correct order to avoid det overallocation

Reviewed-by: Taimur Hassan <syed.hassan@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 640a5a422f90..e40e246bcc82 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -2145,6 +2145,7 @@ static bool dcn42_resource_construct(
 	dc->config.use_pipe_ctx_sync_logic = true;
 	dc->config.dc_mode_clk_limit_support = false;
 	dc->config.enable_windowed_mpo_odm = true;
+	dc->config.set_pipe_unlock_order = true; /* Need to ensure DET gets freed before allocating */
 	/* Use psp mailbox to enable assr */
 	dc->config.use_assr_psp_message = true;
 	/* dcn42 and afterward always support external panel replay */
-- 
2.55.0

