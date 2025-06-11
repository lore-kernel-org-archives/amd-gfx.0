Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B541BC61CE7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 10:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E0E10E603;
	Wed, 11 Jun 2025 10:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J6m9ZXOD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2D710E601
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 10:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gylvNKkTJutETbgG1TWiMwCbJLXc+vc13kED2OeKlhLuFZY6nqxpqgjtH7mgvUoRDLHaooImOlgvsBsxpLWHg/4Fbuy63pEvZqHE7lymgxG5hn6wd8eBXhhVH3Z0DssNQxvyOUXuIn9yRCIT7C8KtIkSVstwRTuTYuwZwT4n/CE6083mrFFtscXIs4b4jhPif0tvCutwSQrmOi52snaf9i1PKEzsddz8hpOJ3IgjC30/Shu4ja+gTmiDtUFSdl22M3htdp4h/130fbIi9TVvXj/VdnI5bQzbN7ulIjRO2dhOxahZlGuKzrQsGCQef/s5AVUd7dFwBTYi/lAV+sDqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8co2ReOiweKjQmQs8UX/Y8r/m2DfujjUU5sVRc24qA=;
 b=waGew15n6yS5Bz/j3DOLpwfvpEY8qAvyDLunhC4d7pgbc0c3/dPPlQZynfLU4FWw2vjH+pVbndGVBc/LUcozNyIOLHruULjp742l0KdStfirwCG/w4lOQarDZ0nMe80ApXlbNzImhcbZ0umeIf0MJ6XInNkWYP7zn3/LNiPYimzd3FZJ2+XtZjt8gVL19Mp5zZCyWqEnunnrsgVeE6qvFB9M6lYjM9aXcQeaoX3gGS96grqcghoSC9UEJwJCplxI7nlKxEvXjbj4Z7N4F7fVmQ1t21nzN46bzFtfmVjd7XDPVXmPskj79wodp8Ad8e89H/qhac1r7mftq+Z4daLZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8co2ReOiweKjQmQs8UX/Y8r/m2DfujjUU5sVRc24qA=;
 b=J6m9ZXODKKqn3EqcZlPnfakLyUw8XVGU01C8d0el8XlphsP0CicGjW0WfnNVWFUh5HlGzKnmSJXcssVdzeEOxL8LSTknx5tPmna/t6vcGa2O84vMme0dMWdVMfN3PXDrxEZdqnd5dmOq1PBmyCW9G+DGGIYgRlmpw1Kyp3cfC1o=
Received: from SA9PR10CA0014.namprd10.prod.outlook.com (2603:10b6:806:a7::19)
 by LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 11 Jun
 2025 10:05:08 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::96) by SA9PR10CA0014.outlook.office365.com
 (2603:10b6:806:a7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 11 Jun 2025 10:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 10:05:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 05:05:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 05:05:07 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Jun 2025 05:05:06 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [v4 3/3] drm/amdgpu: Add soft reset callback to SDMA v4.4.x
Date: Wed, 11 Jun 2025 18:04:45 +0800
Message-ID: <20250611100445.3379455-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611100445.3379455-1-jesse.zhang@amd.com>
References: <20250611100445.3379455-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|LV3PR12MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4b7617-2d6d-42fb-1900-08dda8cf7250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qbe+UcWR4Ghy5p0FIpBIs2pMlL8l5UNHspUnEwA7/RloBmFFWiV+iE/weKjx?=
 =?us-ascii?Q?ZS8ImJX5L0jMsexfHyLcSwrbFcbOORGU7cZxIwJYmSUa61RTCX8dqkSgjfmy?=
 =?us-ascii?Q?v94fSiuWZ4lzhvyV5SSMXSmGEgG+NfLqCqZTliwyyNayS5SNihHlZRSmqTQ+?=
 =?us-ascii?Q?rapTSWReHBKvsKPDNdM3c6365CkxXGc8/W2laojzD/K78gkYlsBi4ojUxcr1?=
 =?us-ascii?Q?CjVVJQWGd4IcSHQNzhQNR+YZnkvIiXqTXjdD2fPiaUJI2cm9hqC5LrYVKGjh?=
 =?us-ascii?Q?TuID9OPvdxPF+z5INzyUM9qkLtSH8XRQghw+IXqvufSZMjiFepIPCXLw+QJU?=
 =?us-ascii?Q?6aWNFu3gJ7fMYElwi43J5uPlr8CTSKBTUpazCDn+xgweUYnL/qqaWn/vfvpO?=
 =?us-ascii?Q?7m3bd6+PE/R19zr5iqC69hUxkNITdPBIeh5cL8XLkLAXe1pGTRVEWx/L+NmF?=
 =?us-ascii?Q?ESZdqXbfKZjHnbVVNwkjvGLkuc4WOOquqemxSg6fzbaVEWzmWPO1+750Zjl0?=
 =?us-ascii?Q?4qcdS92ve+F6Y9IUr9xL3YOkRdX5U2BiMsAP4gvEjXpYAZ8/UFOcJW5M0w0a?=
 =?us-ascii?Q?TnXsao8bq8rPL/DFCe1gQSLaGvTdsQrQIj7UWXADglVgGVjQALCr5ELtW81c?=
 =?us-ascii?Q?gw9OP8X9wa85b99oDZkerImWkLrEvbL9EBt/yYBige2zcY7Jatm0iVxcTYY5?=
 =?us-ascii?Q?IJwHVVbc20xMjBPxxcVyFaDsMOermsvfQMIVfhQ9U7pnvPVIDgOdlkro3KEv?=
 =?us-ascii?Q?TSCLh35jrRKg7W4lecnPZ1vvwp9e+F/FKFGVfHi0YoYkiHL5q0kOsYHNTOSh?=
 =?us-ascii?Q?dBhM1i7EiDBCQGepof1COKKAWVijXuYBzNuTq+0XEiU0wc3w4G9lHSTx6dMM?=
 =?us-ascii?Q?m3tYCSoym3VymLhYbsF4pQF9sZxe+4O/iECUapQxbV/b9ncp7vh1LDtuxnq7?=
 =?us-ascii?Q?iBFL6/ZO/aASJbxBcPOtvoQAfj6FIMDRUDKcCcp7Tlm8Zf1TJHaN2pI4EUxy?=
 =?us-ascii?Q?Mv2cFe+XGcgqAhZTE3/3eEZRtrVYYTWzSuRlOD6sHsggYzRbrPHmDC1budRG?=
 =?us-ascii?Q?hEF8NZpnHvZu6EeJe8tA4W9MMDi5Ra8cXI+rWr27EgfaLhtlgRIrKH2VtRzK?=
 =?us-ascii?Q?Z+IKLwy/5sOemxLfLJalUHTeDHYwnh//1mjMoOhPb4Z3n4XwQOdNQ/3V0G3j?=
 =?us-ascii?Q?mnwMPEvE2epuqA/UBW3HtQzCXm6QWxqf/+qpK0dgqz1BDVkPGqojuQgm093b?=
 =?us-ascii?Q?wgDxFNiKD4u3PAfcUVOQwrGYQOQImV71wAGt1BDXb9MdG2cC3IQSiEh6I/1m?=
 =?us-ascii?Q?no9zaiptlOUraMkSYDTLPRHKYnSq4ArxI4A6zuwi+aQypuVPiYU4rBpoduSm?=
 =?us-ascii?Q?+QHgjt/GWZQjfrxnqRGId0St+TCCw4xB/mJ9zPFr0B4Uug9FLpwsfYF2yjVd?=
 =?us-ascii?Q?3Ssy0x3PiRvnP62ChhPFWVQDwCh3QTu3AOROMgP9dPU6S5UJ4WzAx1w847mN?=
 =?us-ascii?Q?j4tezib3QDxt2w1CnpSD3HG4XD7YpKXFxiAH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:05:08.5368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4b7617-2d6d-42fb-1900-08dda8cf7250
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403
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

From: Lijo Lazar <lijo.lazar@amd.com>

Implement soft reset engine callback for SDMA 4.4.x IPs. This avoids IP
version check in generic implementation.

V2: Correct physical instance ID calculation in soft_reset_engine (Jesse)
v4: keep origin comments (Lijo)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 34 +++---------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 12 +++++++++
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 9b54a1ece447..a1e54bcef495 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -534,37 +534,11 @@ bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_rin
 static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 {
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
-	int r = -EOPNOTSUPP;
-
-	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
-	case IP_VERSION(4, 4, 2):
-	case IP_VERSION(4, 4, 4):
-	case IP_VERSION(4, 4, 5):
-		/* For SDMA 4.x, use the existing DPM interface for backward compatibility,
-		 * we need to convert the logical instance ID to physical instance ID before reset.
-		 */
-		r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, instance_id));
-		break;
-	case IP_VERSION(5, 0, 0):
-	case IP_VERSION(5, 0, 1):
-	case IP_VERSION(5, 0, 2):
-	case IP_VERSION(5, 0, 5):
-	case IP_VERSION(5, 2, 0):
-	case IP_VERSION(5, 2, 2):
-	case IP_VERSION(5, 2, 4):
-	case IP_VERSION(5, 2, 5):
-	case IP_VERSION(5, 2, 6):
-	case IP_VERSION(5, 2, 3):
-	case IP_VERSION(5, 2, 1):
-	case IP_VERSION(5, 2, 7):
-		if (sdma_instance->funcs->soft_reset_kernel_queue)
-			r = sdma_instance->funcs->soft_reset_kernel_queue(adev, instance_id);
-		break;
-	default:
-		break;
-	}
 
-	return r;
+	if (sdma_instance->funcs->soft_reset_kernel_queue)
+		return sdma_instance->funcs->soft_reset_kernel_queue(adev, instance_id);
+
+	return -EOPNOTSUPP;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 3de125062ee3..35b0a7fb37b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -109,6 +109,8 @@ static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring);
 static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring);
+static int sdma_v4_4_2_soft_reset_engine(struct amdgpu_device *adev,
+					 u32 instance_id);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
@@ -1337,6 +1339,7 @@ static bool sdma_v4_4_2_fw_support_paging_queue(struct amdgpu_device *adev)
 static const struct amdgpu_sdma_funcs sdma_v4_4_2_sdma_funcs = {
 	.stop_kernel_queue = &sdma_v4_4_2_stop_queue,
 	.start_kernel_queue = &sdma_v4_4_2_restore_queue,
+	.soft_reset_kernel_queue = &sdma_v4_4_2_soft_reset_engine,
 };
 
 static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
@@ -1745,6 +1748,15 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
 }
 
+static int sdma_v4_4_2_soft_reset_engine(struct amdgpu_device *adev,
+					 u32 instance_id)
+{
+	/* For SDMA 4.x, use the existing DPM interface for backward compatibility
+	 * we need to convert the logical instance ID to physical instance ID before reset.
+	 */
+	return amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, instance_id));
+}
+
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
-- 
2.34.1

