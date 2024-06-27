Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155EFC2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98BF610EB6A;
	Thu, 27 Jun 2024 21:15:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZI/qOHlE";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5666710EB67
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4iFPc7Bzr5z5BhlduhFbjVm1KwKMdOxhT+ZjuecEplXFa8tyBh004Y9V/YsocT6YuWevVrB+6WkV03YhXLELLCku2pe32tFwAOuR6qOZylFp3lCUawnPJJpKp8mzCuC2VvHmfBpER8mDAKpos79wnbno5NYE04MH+ZALtcvqc9IRF9ZeUuSXvmqzXZ+2cQ4F1DYQQU2oDn5rV8rMSfaohTLND3Crc0sgPIB1/bTptRRDtAnyEgtDaRH69HJPyuaIubT7WxWWsZdtzhWpO2i+/noREngx/DAt1WCIwi+WHFydE1wk81bbPJLS2rHkYmBm5XqQRGIjAmdqCcpTTkw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1+v+KvFWruaimdNEqYv+gUrOzcO7yKBlSZWmzi03BI=;
 b=nHdV3QXOauoI8UH9ZkWdAFDASxsOMeIkgm4a1IyzqhOrlLFqHGhESt2FLCVdMqY9iejhDDL3ujkS/R0kvuB3GcC9q+0GAlQPIiYmlm62DQXTa0qw+dJjtTPhDujXe6uCyXGRqCoAUUsTA13JYhE3BeOAks0DkykJghykA5C6RfXVtzBtoV5lnuPAw0eR3MBziXMnGHXO4aus9/f0eD93c+wfriTuYpJzPVVN7HpBmbGz7zdVYbGVM3H5/Ywq/8GPiE/BDxj9rWqVRPNs7EGDP4MO+7/6765rujpQbuv0oroqB4ZbZtQr+QX3cXgWTqQSjxh51wkj94Biz8/x65JhrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1+v+KvFWruaimdNEqYv+gUrOzcO7yKBlSZWmzi03BI=;
 b=ZI/qOHlE/VlM+hhPnvobx76EZU1r0Oh6wErjmG91r5rRNHNIzIeqOkwy/MOa6K2qUFcgw7q1ZLpvoTWP8NbmETmkhr+tuKNXMgugmMT2OxBW0D0hPeH1t3y2luffAXF9WeB0dGpF/vYqJj1GY8IabxU2sSKUyk2UzvhqTrJv2Fc=
Received: from CH0P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::18)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 21:15:13 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::3b) by CH0P221CA0030.outlook.office365.com
 (2603:10b6:610:11d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:15:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:15:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:15:10 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:15:04 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 25/26] drm/amd/display: Fix array-index-out-of-bounds in
 dml2/FCLKChangeSupport
Date: Thu, 27 Jun 2024 17:13:28 -0400
Message-ID: <20240627211329.26386-26-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d39bb7c-1ce8-4ce4-ee3c-08dc96ee3be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SaemumfvfnbydVe+IHDw5lTdDa5j5NH+orq6GxmKtA4zZ5DUk5eoUL8YdC+w?=
 =?us-ascii?Q?ONfT18oedowtcCeGMG5UMTsvgSMf1fGQO/8onsnu56RU24BQvQhwhwtx2saE?=
 =?us-ascii?Q?xwwVYQTfH5mBI3OFC1BvXBjH2JVJSophVQwapXx4Rl8DiPPnVIXQc7eoTwUc?=
 =?us-ascii?Q?8Hz6UpMjgakOlwNgog9GSK191kEvkaMKcXNkR7MVKMgFV9k3o+0rQBrdUJk2?=
 =?us-ascii?Q?S6iM3A1iX/LECE5M1iZkDny7RDEQ1v6gsmVCMuiYKu0vH/gY1FZZgm9qTN0b?=
 =?us-ascii?Q?0RTILBpuq0rlTb9iR130PXtrJvdo1kCptEj7/j85abSyrioIZkzCxNPTKhJR?=
 =?us-ascii?Q?lpHJDLuVAetaMVJVT72R/l9M71DjXWJfP7c4WtyvPVHe9arJvuVXJYeiDqUW?=
 =?us-ascii?Q?LMOfYf7qJliuMkPLtBuYTTFNcQhETv9Pvw2X7f2H1b/YVff+sgz9o10SXdCA?=
 =?us-ascii?Q?TOK35x62mNWlCus4RKCDZWYqWdhMTblUQ0ptW7s/emrzM1oE9akwN4WXk7Xq?=
 =?us-ascii?Q?SdTs5UlyD7PfQ0ydwnBUFSUjW+vmfv5OiOfOMxt9HqydHeciuoBq00TPJLB+?=
 =?us-ascii?Q?bBIpClxbSA0tnCd+XJhjFXyS3s2c/qfrJ2r1JumS0PqymzuXVNaEVrFflxN3?=
 =?us-ascii?Q?uW9YUcbxCFqBZE4Lkw2wFPc+zuHDtcHUYTAN9rDjcrw9PZHirhzFapfgratU?=
 =?us-ascii?Q?H2KJqnlKWLB2hNF1tgnYm4nT2Ez+Se8QnS3snEuCwI+VYZHf4aV5Xo+neYSD?=
 =?us-ascii?Q?j++U0mPp6RZaENvq596ZB9g4sOb+0id1fn7MXqBwQazuBy8g8Z7HD2KHF58H?=
 =?us-ascii?Q?KPs7ASGE0tkw95hzOs8GCiXcqb7IGNd9pN5bpr+nfOHI01MtT6cr++BhzTc6?=
 =?us-ascii?Q?8RpH89tkTmyX107r2gcW7saVre7DgtwlQn+ftC+1M0vJg2qEfTHFkrhY9Ebv?=
 =?us-ascii?Q?dm2kM8fTkLqipqP1/2vksic+qlxPLyk1SuNOxmffT/M26uAouD6fnDImpVrT?=
 =?us-ascii?Q?1npW5nGi1nF8PApcJsBhZIbL7CeQIsGk3qJ9LNKO9snY+dOFqAOaodrLV9ZK?=
 =?us-ascii?Q?aBGm0EbkKFmxgGagfLwMh0tYt3qriangYLbCL4vhiaJwTNFypMx9eVBWY57S?=
 =?us-ascii?Q?cAYevq036YEMF5SirieWHWVKFWpGvQoyxtQ3rzk9b6/nmX7MeTw4kV9L1RwT?=
 =?us-ascii?Q?bZG6jc3z4/0FnciG/lWisqyTYvNlQc67PVVwo+SJSQSgxg4x+gN0vMrsMeSA?=
 =?us-ascii?Q?0wjKxvAQQR+Z9oQ4arKuQ6tXq93Q1F05B7nzflOtVqmE4AJE3bIv2ru1Nr/F?=
 =?us-ascii?Q?+vEiC7FDBagtWM+dQID5ApSng/GS0bUaw/kpULtXdL+AG2jq0bL4VyowiLqD?=
 =?us-ascii?Q?9qbuy/+sC4aBlKUsBlIjbB/ju0FnGHVBLdsZakIXCUrZLHwcTV/z5ztNCKV0?=
 =?us-ascii?Q?cq4q9eKVnskAQC3B0c4U+nwVOB/SXDtn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:15:12.9265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d39bb7c-1ce8-4ce4-ee3c-08dc96ee3be6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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

From: Roman Li <Roman.Li@amd.com>

[Why]
Potential out of bounds access in dml2_calculate_rq_and_dlg_params()
because the value of out_lowest_state_idx used as an index for FCLKChangeSupport
array can be greater than 1.

[How]
Currently dml2 core specifies identical values for all FCLKChangeSupport
elements. Always use index 0 in the condition to avoid out of bounds access.

Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index d91948d6ff97..92238ff333a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -293,7 +293,7 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 	context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = (unsigned int)in_ctx->v20.dml_core_ctx.mp.DCFCLKDeepSleep * 1000;
 	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
 
-	if (in_ctx->v20.dml_core_ctx.ms.support.FCLKChangeSupport[in_ctx->v20.scratch.mode_support_params.out_lowest_state_idx] == dml_fclock_change_unsupported)
+	if (in_ctx->v20.dml_core_ctx.ms.support.FCLKChangeSupport[0] == dml_fclock_change_unsupported)
 		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = false;
 	else
 		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = true;
-- 
2.34.1

