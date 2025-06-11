Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2447C61CE7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 10:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F9E889316;
	Wed, 11 Jun 2025 10:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t1xw2vHc";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466DE10E328
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 10:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoWKmB532smiwWly5UGd81yw8P/Z/uTgXXfYrZ6/K3jVwwEHEPDVxKoKwf9nVfp+2x1r8+5/JWp8LlHntrU66aKKn8wanpRV+QCovdRZjOFRKek8gUYQ1pks1j+eZ7xjseFelXS63KFuvU0E//N00xEDz2oIo4qO7fMiBHPVImXWI21PyNv0PbvdiazQzeRdYAeT7z4NLmoLx9wEyGoBORfAoimpsv0eJ6UhFOWqEcY6xCtV3nYGQS+FWYFzhtOlSAIq7HCbBLOjllG6cOKNmX0NSlYy+dqRcPxTH0md5UIuDfWKY7nbKacuUzHo8rLU/P95tfrlu+J1FKfmxQK3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHSF4JeftLNXeUrwvHkrwrUyd/k3EYIslC43/WNYKy4=;
 b=nh+c6l6Uxx5TVJyPQ7VU6aJpuiExrcEGt8vvRF4oMFnXT4HNKF6kvzXIwwa7xQYTyAmUaCJsmOzIb6FGE2gGEdIPu6NQ7daETWSLRKFz+bpzzEroMzPyvV+o000T9ngVTfqp437pecqDzsjFJJm/4mO1NRd58od9D2nN74UbPBny6vgLpwTZvYGH1fc1n9qb/WjMNJzMRyJeFUA9hSHcG6seBqttcgzJNbYfyLACArWy1Hw6jQKt5NILi+peS6qgZYMMHeDYG1w8JBMcYObO9ry1KclqT0GWhhYzah6HelSHhOphZnYi5YjmbrHqcEIo9aU7h9pbGs9cEQBoV09C4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHSF4JeftLNXeUrwvHkrwrUyd/k3EYIslC43/WNYKy4=;
 b=t1xw2vHcAXLmGaAanlLtjLM2w0rotkbKpYzEu1VuB/BcetXd7GBwQ2VCxhQgydVaEkURMzMFeXQhZrKKpaWPuSR7ADwEqLMHabYy0JtEOWeMI6JN9WJ0rAa1lWKz6ut5JvAI0HwXynlQcEEQdtMHFge5HTcaGMCR16wLUEg2wuk=
Received: from SA9PR10CA0011.namprd10.prod.outlook.com (2603:10b6:806:a7::16)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Wed, 11 Jun
 2025 10:04:59 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::83) by SA9PR10CA0011.outlook.office365.com
 (2603:10b6:806:a7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 10:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 10:04:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 05:04:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 05:04:58 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Jun 2025 05:04:51 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v4 1/3] drm/amdgpu: Fix SDMA engine reset with logical instance ID
Date: Wed, 11 Jun 2025 18:04:43 +0800
Message-ID: <20250611100445.3379455-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: dddd5173-de5d-4e15-f232-08dda8cf6c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DBijWEAFXpH6P3wy4ziMYWGRhy3Qu9Mq6PBshduvaf0Tag9qVZZ2QOjb1qjL?=
 =?us-ascii?Q?zVFDxIxIC0RnKUlHbgFELyj7VrJKvipQ6THUap6Mq+y9xvI/ji20ldFHd9+q?=
 =?us-ascii?Q?S1EkpdKWLJxdw2V3OCxvtquIDghPYIp0m3OF5iuJ3D3hC/EzJAiDEAAolKW4?=
 =?us-ascii?Q?pOrMCWBTNasfVtj6PbgYgoLUfgaHDZC1jD1QRkgUR6ENL9gy2R71IPxIVg6d?=
 =?us-ascii?Q?vL/a1qLI1vhyszTWE7lM1n58qHFswfUnQ6CiuNsCdYSg96ApUtMQ4Zfwzx5Y?=
 =?us-ascii?Q?lW0GBfrFN/5TrJII1EV+cVJRfClkyJRLpG4ytT++j7EGEdFdfsZ1x4U9NHrv?=
 =?us-ascii?Q?8h2Q+M7NAphGC6ws0ue4pZFwRV/MLh6Fc9snpMKcoWnZ7Z3DSLUZna7L+FcT?=
 =?us-ascii?Q?VqKRh5ACZEiTdSMksRkhWN84zn3Z1qzuH9uaeA6tANxzI5s8pEKykU+Nifvh?=
 =?us-ascii?Q?zZtizKIAB7N5/9nBI85rkbMw4KwspiyffIDp9cyQrbdoOBqyo3M57T68z6xe?=
 =?us-ascii?Q?j0l8cw3UuSvgrA6Klnc8U+FdFb5wf6vHxJ7O/LuKm0AKwUHMUD8GyQnn7PTG?=
 =?us-ascii?Q?JOwgjTbAmjZ/kqSITkpmIBRAlfZa0iuRe1BGNMYSGmYrXChWoT2dcQ3hg6Y8?=
 =?us-ascii?Q?96Azki9muKJD51Xj2fmKa6Rpz62SqUQ/2Tlk9d6lT4K5KqS4k2R0aE+mvs8l?=
 =?us-ascii?Q?abHBjud7O3lkuFtvjUaLGCXkXbZXUMSVnxzIjq2UoBgwXI6kpnMaxsr5MiNL?=
 =?us-ascii?Q?NtCpQclJodp8wGiR+nd6oaogIRfzo7xgJo3Z+PvPjXQu+dM+qpfC+GErtMVQ?=
 =?us-ascii?Q?A8UdTE4wumn3PKQyHaRRuSFiZCzIWrsOXcFQaTVxAUrAOj7rmDGtQ6Lfxxm6?=
 =?us-ascii?Q?ZSUH6ScoqU6Ha00tKSjCiuRaSBoW0sed8HKAEJuXGsKiMDyMhkiqD6s5XL7M?=
 =?us-ascii?Q?svVXy5w9BOcbiTOjCGZ5RT28UEZoAOQPfxaNHwWNWeePwZ2wv1dwSM4Y8w8t?=
 =?us-ascii?Q?626g47zEcMufiz42pdmU7tz3Q6Bxg4KPZCpvnr/SYDckCuaFSNQOzSYCT6RM?=
 =?us-ascii?Q?cWlzJNQ4Qsm82uTKILPttv5ssaWP0BQR7aLutPvzOD0Xf4UYWJmGv10IQOau?=
 =?us-ascii?Q?ra65EWfnxJjf7tNPUB+gECsQ1r0ECgZcSGq6wLWGf1M0t8SA/WJUZxirqX3D?=
 =?us-ascii?Q?CcYweLVx46rUnxxDUm8fhncWECfpNxI2BdsA0Ak65u9bZHfBc72XOFXNAb7h?=
 =?us-ascii?Q?dL/T8Yu5WWj6Aig2wtEJq5kisMX6OfMMsdafYOThX6gBHhCBO+Jn/R0yE9kF?=
 =?us-ascii?Q?5VtocQPEFgo936NOHNlKzwJIscIz0IHvE6p6wv4jfDB5XZihbvk9sFOkuoZU?=
 =?us-ascii?Q?Avt5SWtKJ4NUAnyEVMTjay/ULCCqc1swa76mbewDMuvPWeH0SrrSW3M13/qt?=
 =?us-ascii?Q?N1jW5zRH019a5/wuI7tfFqHdaTckO8WWYPOlXbZ8mkW3phb0q/1cYvLjmNd1?=
 =?us-ascii?Q?0JcDXndXXcacyU4WdBskO5OAhxd0tIRjCIf+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:04:58.9796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dddd5173-de5d-4e15-f232-08dda8cf6c9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
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

This commit makes the following improvements to SDMA engine reset handling:

1. Clarifies in the function documentation that instance_id refers to a logical ID
2. Adds conversion from logical to physical instance ID before performing reset
   using GET_INST(SDMA0, instance_id) macro
3. Improves error messaging to indicate when a logical instance reset fails
4. Adds better code organization with blank lines for readability

The change ensures proper SDMA engine reset by using the correct physical
instance ID while maintaining the logical ID interface for callers.

V2: Remove harvest_config check and convert directly to physical instance (Lijo)

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 6716ac281c49..9b54a1ece447 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -540,8 +540,10 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 	case IP_VERSION(4, 4, 2):
 	case IP_VERSION(4, 4, 4):
 	case IP_VERSION(4, 4, 5):
-		/* For SDMA 4.x, use the existing DPM interface for backward compatibility */
-		r = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+		/* For SDMA 4.x, use the existing DPM interface for backward compatibility,
+		 * we need to convert the logical instance ID to physical instance ID before reset.
+		 */
+		r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, instance_id));
 		break;
 	case IP_VERSION(5, 0, 0):
 	case IP_VERSION(5, 0, 1):
@@ -568,7 +570,7 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 /**
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
- * @instance_id: ID of the SDMA engine instance to reset
+ * @instance_id: Logical ID of the SDMA engine instance to reset
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
@@ -601,7 +603,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	/* Perform the SDMA reset for the specified instance */
 	ret = amdgpu_sdma_soft_reset(adev, instance_id);
 	if (ret) {
-		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
+		dev_err(adev->dev, "Failed to reset SDMA logical instance %u\n", instance_id);
 		goto exit;
 	}
 
-- 
2.34.1

