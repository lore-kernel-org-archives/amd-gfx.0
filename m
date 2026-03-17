Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EBBFD7091
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1369110E662;
	Tue, 17 Mar 2026 20:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dStanAaU";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7653110E5E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaXiUD1FfEU0ndc8qa4+dgjvEBrQF/5IQR8VpGlUhKDLuB0Z0u9zMBQpITeQD73jYpqCsuCGrHAiLSjVaaNlDyNakpryDajXcG4YeYHnGN+xsjl9MLmO6c2nlt1HnxCYyYKqlms9WF6rjCB0mg3Bji3MDRiD/1VKez0vQiNJPkJPxx0EZ8klptTg+8dG9hHJFQ9TvvrfFgWGVkguYvfyhR/QCisNSgvjCfxnEdLJ74TYmqZWhhdQJMAhUnQRlyKGjgnf+4bLLahJ3x9ooe4RBV753dKp4ytvg/oYUj01zmLYIDd4lXcuQ6ma/SQFhQFIBiEwEcZy18ePzR0MRl1qPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+a+hFs7inQPG2kRojyKpZ7WaAsYjbkczyiNj/TGl1Y=;
 b=ilhC5a2G4j0Ksb2Pqo8GXODF9+lhtigdPF967kcN41WxdBOdTWOf5yK12WKjz1s/oF9kC3gEQ4p4WIB8MpwBo4EbJYVl/49bcYCgPDF1Vn/skPyXeWOS5a29WpBYfjPOF1pBULXJNEm03uX6i1k7ZEuG45Hmi9FAMdJoZ2VauKMt9bVFV8cz/h/dfwREJkeUitxQDD3H1dKsElcxVS3Qy0d9y++4YiDRqmUUVcgYAftmuL/QCoVUjP5cFfbcFq6Y7iry+DC9D18RlFVWUQIDU9cE+O1M8eovn7aBO6+TSPR6gMjqRpB3IwYDrnurpUU5M2qMydD81IiY+e/N7Xijfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+a+hFs7inQPG2kRojyKpZ7WaAsYjbkczyiNj/TGl1Y=;
 b=dStanAaUPpbcSeiqguSCoXgG5i0VtsU3FpGKNHeo0EM1CqFePjA8jFQtZ9ow3vVuCqJyjot13q7eczYsve0g7QAIDXL9TrhQUUciHCBfnvCLkXP4+uP4JgyNIxupI/firg+NfeBOii1NHo97MgRAAZvx5z3UffOerrjYuX5RlUs=
Received: from BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::11)
 by DS4PR12MB9586.namprd12.prod.outlook.com (2603:10b6:8:27e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 20:13:17 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::ea) by BY1P220CA0023.outlook.office365.com
 (2603:10b6:a03:5c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:13:07 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 19/25] drm/amd/pm: Add ppt1 support
Date: Tue, 17 Mar 2026 16:12:35 -0400
Message-ID: <20260317201242.3808136-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|DS4PR12MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e960b5-ec30-43ef-29c1-08de8461a0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qrguhYpead9AhP4qwFOuS8VdABpAHMvAKGQoFbGowsZ5uNArO1PxMiqnJFdB156YwRQBcExOBdLPrUhA9KNr9ZKNOZvf63TsM7OBWleAYSz6USODQexAIEvSFZaPkZ7lTqP4KTLPzPCIfTbbn2coPW42k88AAYSMCZcldtZ4kch27jOmeN6jAEOxoborA/5whde3qkxh8mGMQmC4/45hOK18KfY61PcRFSZ33mo6mDr+64YM1Ku1F7BXg8bYewz9+C6z2/xtHfEY1sBuLxI/G1hEiJTVSjqUOqQ9cfuOKZvLvpEKiJWCgo/FA1PSX3VvqD20JtGn4Nzj+CnkQSZWS6RWDXsQ2Hmo2K4ihdq0xn4yMADl4q2nQehJC25mHuwIAHjFGFx4qapPlZ9du3d8bENn3GifruPf1SYZ75eNOhbP5iFC8eFGHOXJvoiA+x5yqfF6ibiS1sq//t1y75Qp1gy3/woa03qVX/y1mRsBlMc6PidQyKamtLUVLuaSP1mspzKekPxCV7EJXrMX8C8eAC4m1kn2czPJ5aeiXMB7BUYBCSYX3BYKDcK79V+XO2pELjw4ahs72RqdXKU5lLl/2eDucGEyU8y4pUupXmgWuAyZRqCh22jds//KFKFTPtZJwB55npaXko3U/yr1EDe55DgDSpg+RRVHPbUvdzaS8BlTYfEMcF9uPcffqIe62KG0rGR+EeKacPF7BjlQ278outNGjzAR8H3emKbjTBHE5TOvU3ngxVbC7aPbaJ1cA6I7Hwqtc/l/SNabXE8yK1uczg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lmh2425nRfbruyJNtv7aPnuzME+82i5PamqyebAC1nPtZcfn7OGUMiOeOOmOocUvtJItM+FyLHxKMdTU4syfEe4o5AgbM6QuQlzcxC2kifo/Udoqn9OClDgstg/C8H9Tf3LcKGUI5ORE3j0vFY/36ER2FlJqEVH5pThespJm1sZk1xjVVTu/mmYieIguT/BOoc9LqgsDMPduW0hIp18HVjA4XQ+IbGQ07JFkngkCwlDJpxWkiccglmRRfx9iFafuybHZDWxygK4I9LYLWg3zoA52k0D20wah+A8QAbqE6jb3f74sugp2/RnBaCVt9MWGSYFwSE2itjQGhbR7jqoe1Hh4NxYETCq+tZ7eShSjRQQ1hr6NfryKaxMUenRBmRgP4sphhOvgt+Ie2tczI5eRrBj7lm30/m7PCf9zc58shk1GrUFRyDYFuTZ0qu5UdVFP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:17.5020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e960b5-ec30-43ef-29c1-08de8461a0b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9586
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

From: Asad Kamal <asad.kamal@amd.com>

Add ppt1 support for smu_v15_0_8

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 75 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 7a5582253f5d4..7dc5100700808 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1715,6 +1715,78 @@ static int smu_v15_0_8_get_thermal_temperature_range(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v15_0_8_set_power_limit(struct smu_context *smu,
+				       enum smu_ppt_limit_type limit_type,
+				       uint32_t limit)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	PPTable_t *pptable = (PPTable_t *)smu_table->driver_pptable;
+	int ret;
+
+	if (limit_type == SMU_FAST_PPT_LIMIT) {
+		if (!pptable->PPT1Max)
+			return -EOPNOTSUPP;
+
+		if (limit > pptable->PPT1Max || limit < pptable->PPT1Min) {
+			dev_err(smu->adev->dev,
+				"New PPT1 limit (%d) should be between min %d and max %d\n",
+				limit, pptable->PPT1Min, pptable->PPT1Max);
+			return -EINVAL;
+		}
+
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetFastPptLimit,
+						      limit, NULL);
+		if (ret)
+			dev_err(smu->adev->dev, "Set fast PPT limit failed!\n");
+
+		return ret;
+	}
+
+	return smu_v15_0_set_power_limit(smu, limit_type, limit);
+}
+
+static int smu_v15_0_8_get_ppt_limit(struct smu_context *smu,
+				     uint32_t *ppt_limit,
+				     enum smu_ppt_limit_type type,
+				     enum smu_ppt_limit_level level)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	PPTable_t *pptable = (PPTable_t *)smu_table->driver_pptable;
+	int ret = 0;
+
+	if (!ppt_limit)
+		return -EINVAL;
+
+	if (type == SMU_FAST_PPT_LIMIT) {
+		if (!pptable->PPT1Max)
+			return -EOPNOTSUPP;
+
+		switch (level) {
+		case SMU_PPT_LIMIT_MAX:
+			*ppt_limit = pptable->PPT1Max;
+			break;
+		case SMU_PPT_LIMIT_CURRENT:
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPptLimit,
+						   ppt_limit);
+			if (ret)
+				dev_err(smu->adev->dev,
+					"Get fast PPT limit failed!\n");
+			break;
+		case SMU_PPT_LIMIT_DEFAULT:
+			*ppt_limit = pptable->PPT1Default;
+			break;
+		case SMU_PPT_LIMIT_MIN:
+			*ppt_limit = pptable->PPT1Min;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		return ret;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.init_allowed_features = smu_v15_0_8_init_allowed_features,
 	.set_default_dpm_table = smu_v15_0_8_set_default_dpm_table,
@@ -1741,7 +1813,8 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.get_gpu_metrics = smu_v15_0_8_get_gpu_metrics,
 	.get_unique_id = smu_v15_0_8_get_unique_id,
 	.get_power_limit = smu_v15_0_8_get_power_limit,
-	.set_power_limit = smu_v15_0_set_power_limit,
+	.set_power_limit = smu_v15_0_8_set_power_limit,
+	.get_ppt_limit = smu_v15_0_8_get_ppt_limit,
 	.emit_clk_levels = smu_v15_0_8_emit_clk_levels,
 	.populate_umd_state_clk = smu_v15_0_8_populate_umd_state_clk,
 	.set_performance_level = smu_v15_0_8_set_performance_level,
-- 
2.53.0

