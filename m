Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77789C30653
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6B010EB58;
	Thu, 27 Jun 2024 21:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xh/xRbtI";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D89CF10EB58
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkrlWy6kUInNquDdAsdPI3RMfjUvU0PRPgKJ8WHNi6G0BJcmKkhHdGIq5pdmxKaMLQRnFu0UFqHk9Y25j08oL4E2BokpkPcBeZfN35dW+pWGMYxdEzFREWBu/MXO5+UDI+SU7S/NKred8o4LdlpdU0h6Yyvo3C/mAMrcHY1mq4L9pJi0dQtF/EMnaQtGTreELitKK8zEsrOsT0Ia/X7M9YocniFrSzmGptJvxG5O43IONNT8zKSjGfvRXCan0EST6jbmDDGbYkDZ/fvZjYVPo53w/ZAoXVHhQ5SNsrBOx519yZQcLziE6WqvY/LBDU0g+OdPflRi5lieGcGqhMsdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxxbSfUZl4IVeIUhHpyAhFpX9EQLiJxT3lgOKQVeFI0=;
 b=fd0h7e3vqG2XdnAHd2WBahug+yBPr6d8ZmyveX6hSjBOJTC1wpPNfr/qY1JzNY1n+vCbQT9xMrVCFq5jiY0WK3GI/sLzlgZD3ULr8+mX95+sIJQjpORpEKW51wymMiIOZhcJw/yeAOHQxUDrzp0t/pTOTXLMfZ1nyu93y0lXRDFHtneo8FOIZkMt7wOFVOF7O6B6a/bd6jDmyH4QwlIQeuefjKUfWhJusMAO5YSHizZlZout66g/IfNN/ppe0c1eS+H7hCGNBFoIDPApBUslALr+qGPS+K8Ki7FxyGrggDc2dVpJg9s0yffTl3KG33i1N06WpI+o1iO0jCNZ89wqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxxbSfUZl4IVeIUhHpyAhFpX9EQLiJxT3lgOKQVeFI0=;
 b=Xh/xRbtIqqlGs3TIKErnBlg82me2Saawk5vv+bSfKel59Aql7k88KOqvnVODK7EIHpoesDWh+BhpvbcPOXwfLRJDEuLT1rwSuwNEl9wQ9OiYKtPYvZLH9/3JFLXcO4aVHGQu3LtSITBJhobFbvdPEu8ihAuyPepE7f8aTX7IOTQ=
Received: from BN9PR03CA0575.namprd03.prod.outlook.com (2603:10b6:408:10d::10)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 21:14:04 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::cd) by BN9PR03CA0575.outlook.office365.com
 (2603:10b6:408:10d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:58 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:13:58 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, George Shen <george.shen@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 07/26] drm/amd/display: Add ASIC cap to limit DCC surface width
Date: Thu, 27 Jun 2024 17:13:10 -0400
Message-ID: <20240627211329.26386-8-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4e308a-99ac-4800-92ef-08dc96ee1282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0B0yHPHy+Ywy0eKPgGFwIiZ+Qjl6aemrhY+LKy6YOkPzB+VI9rY48XrBMiD5?=
 =?us-ascii?Q?iQZQ18zIaxERDjX2lqDhF2FHQOSvKfql0AF9AL7jO2B1zMb7EafjwhjLamME?=
 =?us-ascii?Q?fCXUj+ubgvdBaVqGq9ySRLu/OkdzsE9RZNPVyVs9Db+cXFfgAFqbr6iqiEF5?=
 =?us-ascii?Q?5NG7bWlgfHNVXWQS/qgRmTB9Tt5EurjwzaKc/yOe5fKBhdiAvghCrvV9wrQc?=
 =?us-ascii?Q?6kkBG2nlY/Lh/bZh/Hu4JmtPmcsAsmvzOzzPzfUcFisYucdvt8EGCIPTxW+J?=
 =?us-ascii?Q?xjPz/OMbkoFqyENs43kLBIF8OMxj5M2gu7fZ9gdLT4GYy201vOIH8l9Xt4zi?=
 =?us-ascii?Q?OUzr12kjlhV+BLmXEA5bQClM8w+NGqdl1EJndNPngyYQ7kO5mBgfxjuRvOzB?=
 =?us-ascii?Q?5OTucFeqZYhrihRpR4Jr4GM3qRIAieF3XCqHl0MVyRtxEBUezaammZs5hBad?=
 =?us-ascii?Q?YLkrN+5Pu3sCXPz+9vSdKCFSYVtRyN/66zQ6aKEZ0ECNWAYBEnx7UtyQeaTU?=
 =?us-ascii?Q?TKS/Q7RXtbJmRzKLRt6amn6OF85Iyv2A1KQcu0w+kJJ3aRR49mb8QVb9hT3a?=
 =?us-ascii?Q?kkJa7Dpmfq2bt3uR9hCd+A4e0tkb9FnWQExHOFgnVVZbYqUqqI+JDaTaLaU9?=
 =?us-ascii?Q?W6GWSvNk/34PDgboKmxPR9fmxYHmqKZYDN0l0NCClkdNEsUD1DbEnwRizukt?=
 =?us-ascii?Q?ffGFQyLKmfKiW4jraF1IjbJbSqDk/8y1Le7K1iF+a27jTosKaRx98nF11UuZ?=
 =?us-ascii?Q?KQ+RzAPLXjZrEL/bql6RTfkF2UIUY5qtYzOO/9Drsjgo5M4HTzir6vmzXO9R?=
 =?us-ascii?Q?k9V7OFrRZu3Uch4fK+Npk5/rrqszYbhDTHJ9cek/Hw4p6CPambO0c38puWWz?=
 =?us-ascii?Q?6mTlSO1YBxk8xOVSCvOqJohhCs+xPiqKKMTExRdN2mXIkOyF0VnLDq4l75h7?=
 =?us-ascii?Q?EQfmSl3xudgUozpu/eV9Ybam7SJmynngPsUM8rcSIIdGUyzYGFTKsF/f0QFv?=
 =?us-ascii?Q?lm/eeWZ8O5Ax8qJXEeki5wPCoJyZEB0f2q+VHfTbK03k/Bq+F7c+mai3qBff?=
 =?us-ascii?Q?IFquOroC057xNOyeLQOQMQ1kLsxj396Q42w3mE1qKLwj7OAwKvFlNzYVnBMg?=
 =?us-ascii?Q?t3t1vFtDNzZKmbV6phh4TroLHdSjZCLJikHcVW9MrxQ1VFMbQQWE3XXHD241?=
 =?us-ascii?Q?PrpWpzP66x3duj+vr7kibHaNKY3wK2km1emqOSS/Qn12fiKgMgpFY7xoUTuc?=
 =?us-ascii?Q?xA7sXNYEYF6f+Gmc8FwHDjPD1nEFuCumEGOB6PbNstEXDvmMsEgVwLOW5U0C?=
 =?us-ascii?Q?IXDokN5i5h/Gb7V0D+0fbPLK5JJqn3Hiw0tADDUPZcmgS5hWqbVxhqRbIP2E?=
 =?us-ascii?Q?3/I5eAYdQRW4iK+CBIbVKUuzzGeP8DM43j3DlGrWTPj4uvrtoySz9UCyjsY9?=
 =?us-ascii?Q?lPqCPly/HKSF/Xsz5mF8gfUxFIaLEnay?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:03.4197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4e308a-99ac-4800-92ef-08dc96ee1282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
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

From: George Shen <george.shen@amd.com>

[Why]
Certain configurations of DCN401 require ODM4:1 to support DCC for 10K
surfaces. DCC should be conservatively disabled in those cases.

The issue is that current logic limits 10K surface DCC for all
configurations of DCN401.

[How]
Add DC ASIC cap to indicate max surface width that can support DCC.
Disable DCC if this ASIC cap is non-zero and surface width exceeds it.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                         | 2 ++
 .../gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c    | 6 ++++++
 .../drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 900892855436..55b94a72ddc2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -293,6 +293,8 @@ struct dc_caps {
 	bool cursor_not_scaled;
 	bool dcmode_power_limits_present;
 	bool sequential_ono;
+	/* Conservative limit for DCC cases which require ODM4:1 to support*/
+	uint32_t dcc_plane_width_limit;
 };
 
 struct dc_bug_wa {
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index 5126d603f0b1..181041d6d177 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -829,6 +829,7 @@ bool hubbub401_get_dcc_compression_cap(struct hubbub *hubbub,
 		struct dc_surface_dcc_cap *output)
 {
 	struct dc *dc = hubbub->ctx->dc;
+	const unsigned int max_dcc_plane_width = dc->caps.dcc_plane_width_limit;
 	/* DCN4_Programming_Guide_DCHUB.docx, Section 5.11.2.2 */
 	enum dcc_control dcc_control;
 	unsigned int plane0_bpe, plane1_bpe;
@@ -843,6 +844,11 @@ bool hubbub401_get_dcc_compression_cap(struct hubbub *hubbub,
 	if (dc->debug.disable_dcc == DCC_DISABLE)
 		return false;
 
+	/* Conservatively disable DCC for cases where ODM4:1 may be required. */
+	if (max_dcc_plane_width != 0 &&
+			(input->surface_size.width > max_dcc_plane_width || input->plane1_size.width > max_dcc_plane_width))
+		return false;
+
 	switch (input->format) {
 	default:
 		is_dual_plane = false;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 4e27d2cee9fb..a05a2209a44e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1822,6 +1822,9 @@ static bool dcn401_resource_construct(
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 
+	if (ASICREV_IS_GC_12_0_1_A0(dc->ctx->asic_id.hw_internal_rev))
+		dc->caps.dcc_plane_width_limit = 7680;
+
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
 	dc->caps.color.dpp.input_lut_shared = 0;
-- 
2.34.1

