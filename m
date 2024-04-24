Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0892C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7785C10FE2B;
	Wed, 24 Apr 2024 08:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SIR1r6se";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB67C10FE2B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoQKMU3ws8y1N7x+o6iawEo8c/bDRRJ1gTL7ZD0X0jUrASza0flmN4mDeKbcNGlxuimPV8shuiUWFhvtDbF+i+/AU4f2YV6pTIdwiGDIXO7PstLmphOxcwLxb4+PkJbJVUhjFEZx3QYiQPRAvNQZpPOtzS/MVukZP1a8uo3OKpvQ6x2EVIcblOpKzP6WMpbYDXfKTGzbwrDy9dTwCTzTm2vDXJsKMEAC88k9dqpUc400kwUu0CDrLsqcDyIb3GIm8whluzZumiVMtADoCsVJkWophB1b0iBJQHc1KjlwRr+pqOs/dv/6DRu3nKowt9pvmp/8aldNGQDBU0mqfweV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3sgFp7IC1pTkYTXLG3XvDt5k1KAVuvuEv8grK78RAs=;
 b=W3HRINZfMmU7/4pYHUOkgr882FAkMZzZ4Du5v57rauXsRBCvosuZbiM8RZWwSBMrKPpJKGj7LdhilCjNRXSR89nt0+MPYiPQxBiO2IXSFXUJMv7l5naDkQVPNJh498x8gOsWoBfhHR/S2Jebs0sqHqDe6giagBQapHfuRiIxzl3vg7CJc2h63SeyzWP8Smevvl1moWDTUbI6MGwFHX6+cnmGOo0I60AYfHk3bGMO+uXljKxZ5MAB7yBO3GWIExWLPWdDcnGls9Y0zzex/LP/WVPwL98V+7Smetx43WITxGcu8SZlpchUg44x8gVBmux5cXGsUWFTa6FNYROeHQbepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3sgFp7IC1pTkYTXLG3XvDt5k1KAVuvuEv8grK78RAs=;
 b=SIR1r6seq/DbhUvlX+V1xdBeP3I2UWhfRnQ3vM/q3obgXEWbojzRUdRe2D+/Lx12FbJ5t7goGoQXirF2GJomyrJ2rqUwCOKfs7Z484fxb4fIcHK0aXVvA/rtkKCN15yQFbDMpzas2mJ/oFYVqlcHalm8qXWhesIY6HeJoCD7Pro=
Received: from BN9PR03CA0154.namprd03.prod.outlook.com (2603:10b6:408:f4::9)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:53:26 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::d6) by BN9PR03CA0154.outlook.office365.com
 (2603:10b6:408:f4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Wed, 24 Apr 2024 08:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:53:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:25 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:53:21 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nevenko Stupar
 <nevenko.stupar@amd.com>, Chaitanya Dhere <chaitanya.dhere@amd.com>
Subject: [PATCH 34/46] drm/amd/display: gpuvm handling in DML21
Date: Wed, 24 Apr 2024 16:49:19 +0800
Message-ID: <20240424084931.2656128-35-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbfaa73-99f2-433e-bdc2-08dc643c0148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nbjLxVChjzh/AliHSiYkPsjvv8WqW4dwZUn+XL3C8eLP8Vjanbx5H0itCZxT?=
 =?us-ascii?Q?tLVD+JegXArZ3/h+GES5QrEGZxWtYKDlSkDEM7t/xy7vwZO1TVkcyVHKEzxT?=
 =?us-ascii?Q?o05CI0yvPcxUsGWmiDHUwmm4Z0EjPGexik6yZ49sTbr51icwZI3J3N7unhgW?=
 =?us-ascii?Q?c9jecTuMPD13mdUAaOiDPXPtMtFCmr1Mw0dU+2ydP0MtwPP4OnTRLZFHD/hy?=
 =?us-ascii?Q?RxSyd3Tza6SxTY69nVBwxyNv5JD8MzorqE4H4C1FOsrllS0iq+JZnJwOr/wu?=
 =?us-ascii?Q?HtKdmZyBdI0VStKNm4meRZyaA2s06scktc0JwSpmYUC/9m2wvu5KHpVJDP3B?=
 =?us-ascii?Q?l+AzY2IvN7lGTz2YdbpBsndydKuh2J6Kpr9vZ+aumsGAsGxTjzW2oLiji7KU?=
 =?us-ascii?Q?BGQ/OxQ9r5rmitlTUkzGPFUhGvKqd+6yqCYZtjzZ32VHRbMJZtITAhjqA/QX?=
 =?us-ascii?Q?F8Z6OvS4eSL+bH1R2oYK/GsvXm+5TXV9f5BDmBVgF6UaDX7d+Cg3Lc4PqD7Z?=
 =?us-ascii?Q?HO83Ua5s6kbnYR8Rmf0qzYigbzewstcC9R8O8ZXhDqYUcWhKdlSRXMKsmuT/?=
 =?us-ascii?Q?9TULnlTZWTMJXMz5bgkREpDAdkciRst+vliRUQ8lci6lssRidNQUTHEyzFnp?=
 =?us-ascii?Q?Be0MYoKhWQeu6oWWq5rEvS+yl9yMKz4n+O0uY/8ngr+M6mWryV4tCM0xIhle?=
 =?us-ascii?Q?EYVqph5zqK+8z15NHVp4k3ZKp2Q5DLM9/qTIarEVt4XwrQ+8mPqkIiNUDXLp?=
 =?us-ascii?Q?U3p0koe0RaNmtZIpZsaJlaHE1DVKlsr9kJUVqj0XxH7PXeX581vaTF1d9Mht?=
 =?us-ascii?Q?O69P9JhXbgezaMJV4SB+6pMVU8QXLB12Wn5ms8VqcZO9V/9BnhJYNGbsutv9?=
 =?us-ascii?Q?YfZb0y2+X89ulwlmNPz7vx6FVaicc3NmvERaffAWJo4FPMXUPwP1vfcoAmAZ?=
 =?us-ascii?Q?0ymkcpSvrLNFzCTNAaHkKnfGmm16kPwmpl0xPuPj+G+I5W9OoXhxSriM6tKX?=
 =?us-ascii?Q?+CEr8cXlMAGHpLNe2p6G+49+ZCUCht2g8UbC2+ewrJ7K3BCgxjbEoH00Zj3T?=
 =?us-ascii?Q?QNSSufsY6gMHEAgzM3xi9TNdc0c+0TTMb1zW3inO2SaGcd2TN2qehAUwwdyH?=
 =?us-ascii?Q?YkF5C0joqVIDneN1TdVSHjziGJQs18cBJSCHBBlu/TZ6j8cQI4ZYWi36+Ftv?=
 =?us-ascii?Q?wzUkWxUHwx4UWvhdTNiYj4pUuW4+BIQBlSLbK+QiaO1GBuCVsFartcbsc2Il?=
 =?us-ascii?Q?LMeLWZQ4MFDzOP7R4GK2JJtoarJP/JB+WPt5ZZh50F0yYdVKhdOzern7SpJ+?=
 =?us-ascii?Q?hx8o5NfSk/ptkdiGXixAHL/X1lB1sO+D+EUvIlBMLHsU8RCj9F8SVFf503e+?=
 =?us-ascii?Q?fwAcFsQZly9WCYEpdoBvaJD0eo13?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:53:26.1658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbfaa73-99f2-433e-bdc2-08dc643c0148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
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

From: Nevenko Stupar <nevenko.stupar@amd.com>

[Why & How]
Currently in DML2.1 gpuvm_enable was hardcoded.

Use passed info from DC for DML21 to be in sync with
what is used in DC.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c              | 1 +
 .../drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h              | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
index eda2152dcd1f..d1e68dc57a2a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
@@ -47,6 +47,7 @@ int dc_setup_system_context(struct dc *dc, struct dc_phy_addr_space_config *pa_c
 		 */
 		memcpy(&dc->vm_pa_config, pa_config, sizeof(struct dc_phy_addr_space_config));
 		dc->vm_pa_config.valid = true;
+		dc->dml2_options.gpuvm_enable = true;
 		dc_z10_save_init(dc);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index b3602f897872..63f9bda3b130 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -943,7 +943,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 
 	memset(&dml_ctx->v21.dml_to_dc_pipe_mapping, 0, sizeof(struct dml2_dml_to_dc_pipe_mapping));
 
-	dml_dispcfg->gpuvm_enable = true;
+	dml_dispcfg->gpuvm_enable = dml_ctx->config.gpuvm_enable;
 	dml_dispcfg->gpuvm_max_page_table_levels = 4;
 	dml_dispcfg->hostvm_enable = false;
 	dml_dispcfg->minimize_det_reallocation = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 97e013ce5516..4e4ed1678d91 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -232,6 +232,7 @@ struct dml2_configuration_options {
 	bool map_dc_pipes_with_callbacks;
 
 	bool use_clock_dc_limits;
+	bool gpuvm_enable;
 };
 
 /*
-- 
2.37.3

