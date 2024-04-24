Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDAAC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6310711392F;
	Wed, 24 Apr 2024 08:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JqtlpmxG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342D311392F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaS6jvK7MMlwL+BPyHvpahiWATTTvjrWnc8filZFMGLsZJm8RwH2FuI8k5luT3PFzhYN96m2CDDDOcSx/Qh+yeHgZmWVi/Sh8rIrQAGuxHnxXNbPdl+H76vLp1i+HNsvf/MkE6becStEsj+ViaP1zgJ0epwJXJaepwl4xS2kaYxQTQ8rTli1a9MR1y8F1LPchcpZahBFC6i8XyX/FLMgALsvoCL9pCXqDD8K8YX28UwoE0+nov1iw8T3qWdz6q9gSI/rPhRu6pe6MU66DkpT+MYxCfFlzXx4XjeOKfAWrA/fanabbImuay8NGOqpipWcZyGa9G9AwOpPE3Xpa6gOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F2UwGXmCDet6vTac2W69I+kyMxgbfF3b/JXjwua6SA=;
 b=GYbAZD8vAfzD0MERoScmdg8BPfJvxTriX2qEx89sFYiwnYWqgbg2V41MDAcwujUCFx9+X9QThjNFpkF3fyGzePS64gtj3/F+nJLr0pb0k/W3+XnhoFZ0YDAMjiQsg8NteCgTyzL2yPMbRKJ8vqjKq1BAutQ4ApWbHly13lRdowfmgd/S+TPS0bQAmJxwJC3q7kvC6Fd9lsNKhCSFZfoljCWMM+LSDqxHKXFStCd4WUNgowaetSDmiT0iTKbCPZ+Ie1bXTmd2jvqX5brpq3mv9X8BUrTo0cWyFb0hhgL9USy31TidGll4DzEdsa3CJ4uxaV+kBEClH0+11DjuRCcgFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F2UwGXmCDet6vTac2W69I+kyMxgbfF3b/JXjwua6SA=;
 b=JqtlpmxGQZ/cGRKRm0aOh65MWLQR0YcRi06pPD5/CwOXj93cgOKFecendV46hiurhljfmjFHtw/rOTOMvrQo0eFSiW2KpgWDNNW2D/+ZwW3+uTx4LtNvDpyR16WT+yOFcnmQf7g51PSAM3L4Wa7viVYPYhZnmSjM2gG3nqp1quw=
Received: from PH7PR17CA0048.namprd17.prod.outlook.com (2603:10b6:510:323::11)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:41:54 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::f8) by PH7PR17CA0048.outlook.office365.com
 (2603:10b6:510:323::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24 via Frontend
 Transport; Wed, 24 Apr 2024 08:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:41:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:41:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:41:53 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:41:49 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 13/46] drm/amd/display: Adjust codestyle for dcn31 and hdcp_msg
Date: Wed, 24 Apr 2024 16:31:29 +0800
Message-ID: <20240424083202.2647227-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 1153cb5f-cf8c-44be-60bf-08dc643a64f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ig+ZThYifwnkhcqRkzgPfDwkZY9qMsJ8ynaO9cX45TuCWsOVdzsvMuGkbVw4?=
 =?us-ascii?Q?3jinu29XNUoTjqJU4mKSrwWOBnz07NzBLH04zDleIzMnMsSoz4pVjJH8J31R?=
 =?us-ascii?Q?Glby0PD9Co9CXfHnr+aZxMoIQxnrOkJc7i/JrFraazsYtcjH8AsmO555na+q?=
 =?us-ascii?Q?fL5IKS9l+kSpoZSog/baJhx1kc7LsG+BAQi8h2Im87/cXTrFvHqZOt5jaiu6?=
 =?us-ascii?Q?AcAmTcIvL7uXyPN8C2AXXPrs+Kod3rb5aQw8XbYBXeIqqgEQ3l3gydxwAQcv?=
 =?us-ascii?Q?YUHpbNVk/PRRF7HCxxi7DSDIFNuRfWzwnG4hwfKES2iwLoAM0H9rDuSXJtb1?=
 =?us-ascii?Q?rtWNjy4AZMMvuL5XUX6DUoSjC00kFlFpNmnXBzKhxkNr/BDGFPXtr1gWt6af?=
 =?us-ascii?Q?09nmO/esnrOdGzs3eYNcFuqpdKH35GVeo+Utfwv3EIhO9bcCtsKXN72qQEa6?=
 =?us-ascii?Q?EFF4g9URaEpa2omv9Exw7x6FFB3PB8hvcpYtDLxQjyEjup6KPOAYMFMwGUvV?=
 =?us-ascii?Q?Zq8vNGETkBkTL67fTJ+S3Jh6cChgx0Iqc7qlYcftRd/k69y/6CeFes4yGpSK?=
 =?us-ascii?Q?0ZeHYRZDD4jz+UFFCMRZRszo3A1drt0kFgTny52zs71simsbSwpv6CSmKxgc?=
 =?us-ascii?Q?wKc9ACVFO/R0bEiG3E07yERgbUEI8tsm4lyYMaBLT+PIqAZk4CbJJTF0fiVg?=
 =?us-ascii?Q?JcKF36xHBPkA58HScw5cNXJ+GhIMs7RJI8nvX3po2G9yoOWyfkDc4M1xzPkl?=
 =?us-ascii?Q?zEvvt3ZfKxh7hBLrpv/IWjKYzSHhsauQt1i+/EZbWRH6zIUWN6PFJsDPloe/?=
 =?us-ascii?Q?vhgx3Kmm2oHeLr3DAfFx5BzsTUI0PLBfKDV9ME98v+TGa+tzehq8ANpfHQhQ?=
 =?us-ascii?Q?hZ2mOkxppu4vXBBmthhR/BeUUQyP3r2kv3avN1wHErxUUzk9YDYGaG9zUFlE?=
 =?us-ascii?Q?QwRY4NcJOCTa8m0D++Lj5P0GUgqEbh7dBOZF5Tx3GbE2fA4wpDpIugd8VVZ6?=
 =?us-ascii?Q?Hc5MZs8pjufweDu3QPTAOCr59Z+TOV9YxQT1HYQQf6KXnvajm1EwPShwn9Jk?=
 =?us-ascii?Q?y4+HhQMybSQ2omop6F85HduniuQ7dOAWMHr953jrgVtTJD1xn45dxPJhqka4?=
 =?us-ascii?Q?jgVtuZW5Gv2TmD80mb2gWLvgsz/s04A2/YJqknmFYRbNiF5Yx2n6fzeROw05?=
 =?us-ascii?Q?1OpWTu3EVG68kBuWlSesJ20DP08ZthTsWSjfJLvI3Vb6fow1pmrQ3wiyF/HV?=
 =?us-ascii?Q?XasvUfRwfIV+ssErJvUDShxuktXNJHePqS6e8eVjwfJ0O4izq3mdKVVGLO2p?=
 =?us-ascii?Q?L8u10MPlQWYIVtbsjvVnk+6NSPru1f/8u4i7oIGagP0sdNP8ffMvr+xoifb/?=
 =?us-ascii?Q?Cy/CHsJgwawx4UoKgaN/NKpHsrH0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:41:54.3382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1153cb5f-cf8c-44be-60bf-08dc643a64f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit just update the code style in two if conditions and in an
static array.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c | 8 ++++----
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c       | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 59a902313200..4407640c5f87 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -645,9 +645,9 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 			dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
 		s[i].phyclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 	}
-	if (clk_table->num_entries) {
+
+	if (clk_table->num_entries)
 		dcn3_1_soc.num_states = clk_table->num_entries;
-	}
 
 	memcpy(dcn3_1_soc.clock_limits, s, sizeof(dcn3_1_soc.clock_limits));
 
@@ -797,9 +797,9 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 			dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
 		s[i].phyclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 	}
-	if (clk_table->num_entries) {
+
+	if (clk_table->num_entries)
 		dcn3_16_soc.num_states = clk_table->num_entries;
-	}
 
 	memcpy(dcn3_16_soc.clock_limits, s, sizeof(dcn3_16_soc.clock_limits));
 
diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index 99e17c164ce7..076a829c2378 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -70,7 +70,7 @@ static const bool hdcp_cmd_is_read[HDCP_MESSAGE_ID_MAX] = {
 	[HDCP_MESSAGE_ID_WRITE_REPEATER_AUTH_STREAM_MANAGE] = false,
 	[HDCP_MESSAGE_ID_READ_REPEATER_AUTH_STREAM_READY] = true,
 	[HDCP_MESSAGE_ID_READ_RXSTATUS] = true,
-	[HDCP_MESSAGE_ID_WRITE_CONTENT_STREAM_TYPE] = false
+	[HDCP_MESSAGE_ID_WRITE_CONTENT_STREAM_TYPE] = false,
 };
 
 static const uint8_t hdcp_i2c_offsets[HDCP_MESSAGE_ID_MAX] = {
-- 
2.37.3

