Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB25CC54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5677210E1B1;
	Wed, 28 May 2025 02:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bVELtv6x";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5013510E2B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:53:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4EDazZR9U1Lnv3J0Q9r+YdQJjHz6BMzMsp5y/PQyRm7L6p/ME4YgO+q7wyOxNt0ZGQ/CxfDnNoixSvmuaLDdgoexXWjzeg8FgwRkJ/+WX2gKiqG53LIyM2XZoZp33x9mLwDMlKHTYlEMNezJq8aF/mec0fGWuNah+m35w1U3caD7x4bNtPJhWnSlWJ8veEDxkP3DqT1q8LDhXN3/7CTB7UP7nCaZkpHpAQmWBvZskmlfsSTTThPDT0mIVdbyJQ7QepTFRFhNtYihAIc9FflQv3zwhHzMOOA3GChs5+uCkHg2eg4RKbqAxHYOUmUvYbIup49l+0eT7kylRXsx6s0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTar9lbiMgE6RHVefa/xAfiDMJGmW2uGF/0je8VlfoI=;
 b=pRPk8pEXCNE0e9a0ADKhWfY+pmIYe85ORerCxuoWC/KTbCxpQEhWKU9KUVIBtfz+EiqHd8e072sUTzvN6ddCAcOspmM5GqRJnbebxFxwbwdrdH3jXIDyhnc79ZTewiadQLWdB9UifrlHTspY2qggYIQusdyaNCLeIag6aIRRm8dF1Yz8S/NHT3Vp4W9sAukQGo+9IDkQX8IsSIrP8S/qAfyZfaDxIw/vAPolg+DvzUxTwUjfSE8QW/3KdXTRYC8BZU1+3j/aKa+CyKtNccvKIX+ga7kHZbPF8YWi4UodRffaxzWO/5cOLL3T0kv3TVZCNetZNZOFb5ky4iCJbvigEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTar9lbiMgE6RHVefa/xAfiDMJGmW2uGF/0je8VlfoI=;
 b=bVELtv6xSSa9zQvrEFdQB2bjwalSwtIeP1/ylSzbXoQVP7+Wrikia/g5JkIMPA9x21Tz7C+c9K/T1wxKXo9BzAo8vBr1hLcTN7sBeeGGKO8b2xK4MTnNkuxeKBMNUabptnaUYpyBTVA9tpld7blFgPSrzLl5Qm6SRVla5L/yzmA=
Received: from CH0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:610:77::8)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 28 May
 2025 02:53:22 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::e3) by CH0PR04CA0033.outlook.office365.com
 (2603:10b6:610:77::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Wed,
 28 May 2025 02:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:53:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:21 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:53:16 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Oleh Kuzhylnyi
 <okuzhyln@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 12/24] drm/amd/display: Add DML path for FAMS methods
Date: Wed, 28 May 2025 10:49:07 +0800
Message-ID: <20250528025204.79578-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: f029b46b-4f88-49ff-ac8c-08dd9d92cf01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vGnzwYjcsjGxhIPUbAwAnnjpw302l/5qd7NizR7UapqU9JMRB0RMr2FGz5Na?=
 =?us-ascii?Q?raF2bwAKapqmeggcQINeNFh1RV6c8n0mg9FyDYi/Xdy3TBd/8/HyFooEh6nL?=
 =?us-ascii?Q?2O3pXMfHomJP8rs61M2l48lHDkbw4Esj14FCkfv/yAvFtdzH8CXf7jVCRjtB?=
 =?us-ascii?Q?cCXeVr8v8F6q4rFNJrz3lzH0W45Tl+7UY19z3j5KNdcWSO/bWNIBYnl5DQ+z?=
 =?us-ascii?Q?+dlALEnR9WGSab0p2BKOPynb+4afou6qSi5mxSqTCJ84XU6nLpF72SidJZwy?=
 =?us-ascii?Q?25Key7rd/Zp1boWJWJ8fy2qSirPnWRVDju6zMUM/pB9DTk3b2vkzzlI9O+AY?=
 =?us-ascii?Q?8w1ziNnPSELeNWbi5uPor/qlsb2CGA5Ov2kfUUWHOlL+E5btZkY8lNPb1SPT?=
 =?us-ascii?Q?7CJc+Z7oi7zqZ6ShUOWZGhUrlFfwPrusDEFkyAOBchKDygVn+Lj2BP9dGt/l?=
 =?us-ascii?Q?rRyylhKm0P578ErGCd2DCjJe5hf0laaf54zCVbN+ADCT8IvYMPzq316I+Mgm?=
 =?us-ascii?Q?wB6vkWmF0T/nXd53GqHj64njO4WDcet7UCponygcwTolPueqgiAqmaNBke4W?=
 =?us-ascii?Q?FAT1WURuT5lQwx+4I+qp/21Rb2QG6adtNiaCRSrkL9abRNpShFbug/2iUquU?=
 =?us-ascii?Q?t4T4wA463De2LyZK9WcijLMcCL2hLPVV/V/WGLJAJsyncIo7x5I+x5yKoC5/?=
 =?us-ascii?Q?D0li70o7/ZnNbDqr6SrYX2vPQ06AbbAaI8v3fBtoio5Xf75/qM6O0ExbtD17?=
 =?us-ascii?Q?Pwe2Bw3oQECzE6un8gELozdhVW9D0qCjSoHfip/4QUY03F8EfxHs3FxAw5qI?=
 =?us-ascii?Q?sxRed3AYvmxbY0jb0NATZFYBJ8M7P0XHm7F6Kd3prO98FJ9avciD9T8v28DT?=
 =?us-ascii?Q?uv8mySXFhFH7dYDvDQojWkP3WVTJgyCle9PUTC10Vo86X86ybEYKQu2FOhGj?=
 =?us-ascii?Q?2i2eTyhVkTwErp5Q3sJ1IPSK1aF7pZdhtVcQ1Zt0qcE89weBeMZ5dzc4nY6s?=
 =?us-ascii?Q?iajXZRwFkUc1kkqJFn4c+nRxtnd/TDYDy3ENzRSqt6qL9mSesr/axyuhEgAZ?=
 =?us-ascii?Q?6isUd8an4Ak6TDTGFGglqMSsQzIMkGEyucALaS+2C+9fHw4WkpZmKgjP7g0J?=
 =?us-ascii?Q?nZw98WzIjy9WCxHrONsvsAK4LrXNoKynHBQlt+pJRftNGVD3lefQXE/yNo2O?=
 =?us-ascii?Q?OVfEqXfdbjkEqevYXt47HKAV14E1oO9aTOO06trOQejyIKux2vXGsizpQORH?=
 =?us-ascii?Q?BkWvfOnKzz9uhcg8y9QfCdFml0UURNL6qWF08UswFs+Eldz4jIyFS/h3lT4s?=
 =?us-ascii?Q?ThpA51/h73vPiLj1bcLSQ+a4MPDeUKPzw0JEGQOfhOSML34rQqpVF/o8Edjx?=
 =?us-ascii?Q?awC9vGTmFCLWvF14APrtkST/hymkIsVNgvciY/hjhp1YxoTNi22asBnJt9u0?=
 =?us-ascii?Q?WArywIdR9Te+uNFrB7DUvdqjOTvreiBqNcwy96oUknFw3zwbFGReex9me7cd?=
 =?us-ascii?Q?HVMZPY+tcP75SM9PIRSV5pEyZbDM/39PP4x8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:53:21.9707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f029b46b-4f88-49ff-ac8c-08dd9d92cf01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356
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

From: Oleh Kuzhylnyi <okuzhyln@amd.com>

[Why]
DML needs a path for FAMS methods.

[How]
Apply instance of fams2_stream_sub_params_v2 structure with
a FAMS placeholder for DML.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Oleh Kuzhylnyi <okuzhyln@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |  2 +-
 .../drm/amd/display/dc/dml2/dml21/dml21_utils.c    | 14 +++++++++++---
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |  5 ++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 8c52d3fea1d8..00ea81fa9573 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1758,7 +1758,7 @@ static void dc_dmub_srv_ib_based_fams2_update_config(struct dc *dc,
 
 			/* copy stream static sub-state */
 			memcpy(&config->stream_v1[i].sub_state,
-				&context->bw_ctx.bw.dcn.fams2_stream_sub_params[i],
+				&context->bw_ctx.bw.dcn.fams2_stream_sub_params_v2[i],
 				sizeof(config->stream_v1[i].sub_state));
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index 930e86cdb88a..ee721606b883 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -384,6 +384,7 @@ void dml21_build_fams2_programming(const struct dc *dc,
 	/* reset fams2 data */
 	memset(&context->bw_ctx.bw.dcn.fams2_stream_base_params, 0, sizeof(union dmub_cmd_fams2_config) * DML2_MAX_PLANES);
 	memset(&context->bw_ctx.bw.dcn.fams2_stream_sub_params, 0, sizeof(union dmub_cmd_fams2_config) * DML2_MAX_PLANES);
+	memset(&context->bw_ctx.bw.dcn.fams2_stream_sub_params_v2, 0, sizeof(union dmub_fams2_stream_static_sub_state_v2) * DML2_MAX_PLANES);
 	memset(&context->bw_ctx.bw.dcn.fams2_global_config, 0, sizeof(struct dmub_cmd_fams2_global_config));
 
 	if (dml_ctx->v21.mode_programming.programming->fams2_required) {
@@ -414,9 +415,16 @@ void dml21_build_fams2_programming(const struct dc *dc,
 			memcpy(static_base_state,
 					&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_base_params,
 					sizeof(union dmub_cmd_fams2_config));
-			memcpy(static_sub_state,
-					&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_sub_params,
-					sizeof(union dmub_cmd_fams2_config));
+
+			if (dc->debug.fams_version.major == 3) {
+				memcpy(&context->bw_ctx.bw.dcn.fams2_stream_sub_params_v2[num_fams2_streams],
+						&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_sub_params_v2,
+						sizeof(union dmub_fams2_stream_static_sub_state_v2));
+			} else {
+				memcpy(static_sub_state,
+						&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_sub_params,
+						sizeof(union dmub_cmd_fams2_config));
+			}
 
 			switch (dc->debug.fams_version.minor) {
 			case 1:
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 0cf349cafb3e..56b0b3f59efc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -556,7 +556,10 @@ struct dcn_bw_output {
 	struct dml2_mcache_surface_allocation mcache_allocations[DML2_MAX_PLANES];
 	struct dmub_cmd_fams2_global_config fams2_global_config;
 	union dmub_cmd_fams2_config fams2_stream_base_params[DML2_MAX_PLANES];
-	union dmub_cmd_fams2_config fams2_stream_sub_params[DML2_MAX_PLANES];
+	union {
+		union dmub_cmd_fams2_config fams2_stream_sub_params[DML2_MAX_PLANES];
+		union dmub_fams2_stream_static_sub_state_v2 fams2_stream_sub_params_v2[DML2_MAX_PLANES];
+	};
 	struct dml2_display_arb_regs arb_regs;
 };
 
-- 
2.43.0

