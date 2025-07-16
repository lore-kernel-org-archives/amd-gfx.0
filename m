Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A89C83F27
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 11:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966D010E798;
	Wed, 16 Jul 2025 11:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WPuiwXcg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 121C810E797
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 11:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNCYUHxECmJ0pjp9Fy7I0N3CrSFo2oGz8KO3QwCeRPDbKD5j5X8TINU4gxaYDbtM6r70+B2aH3II5cfw3IuyHv59I5yKEYeaE3zhvFumc7ThY3sBbR7KpqgjDpumFwqp8HojHWWvHOfxXtUG1dzAgnje8PinOsbc3AQNOQm90BEX58qBq+dIIA8z+rWQmysaGEhkdQoeX3Vv1J65vzYeil6Gh+FgkT0exPD/EwKZ8dY2lM/6hgimF9KeKwZqtMycuv0LHtVDVIvZuD/gWQSRVIF/eOyvp/vGFydcSqVdx62G37lwmSIGUNgqS70jL0YD6JKsAgEHG52e7C+QJZkKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5PyCdrTxwH3BIC0bACBz/Vs2z14+r2cvoft55E1+mc=;
 b=PmxbHzVuGiV/R/oHMM8nPkkLT0a/0HyleCejCaYz7PEBwwzNf2O6hQoC62rIt/cUEEfjO8TkxSbACV9dxngKJ3USWur8Hc0UjQ1koTpAM8cPZfFW0y3uMllSobNSMRxAS+nIUA4emfffbJl3m8Z1WU01GfzfkVsmMPxC++UPaaDUWOalBxOGCZbvR/lXl70lgajPvLXi68QP5u51m7na3SegAFKwJUSr9095yaH/50k0wLuUpu8SF/8mvPLo5a2rPxsALX/75tbPwyyiva2ZdXRRaBR7/1e6CLKn0UEe4hJP7pMjJ1YMbO245xCFqGOXcwnPqKY8E1Mf/4ORxtodPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5PyCdrTxwH3BIC0bACBz/Vs2z14+r2cvoft55E1+mc=;
 b=WPuiwXcgPhllUzO4mJlGkunv+8sqpi1MQm9CAtOgkDI7WAMHYv3++xXa5oaFIR4ZtA/u5JzhfD9KblubA91G8PTn2SouWELXVTACbhu+iTBIgiXQjIC2p4vUsjyTdFrg85f3PaSWzuQO8B6utLOb4J/Nx9oWS7reS0QMiAsbAsw=
Received: from MW4PR04CA0136.namprd04.prod.outlook.com (2603:10b6:303:84::21)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 16 Jul
 2025 11:00:20 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::2a) by MW4PR04CA0136.outlook.office365.com
 (2603:10b6:303:84::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 11:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.1 via Frontend Transport; Wed, 16 Jul 2025 11:00:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:18 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 06:00:17 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [v4 01/11] drm/amd/amdgpu: Add HQD PQ address retrieval support for
 GFX11
Date: Wed, 16 Jul 2025 18:59:21 +0800
Message-ID: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d53085d-b7cf-4f3b-573e-08ddc457f460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+rEQYMSc3dyhfvK5CbJ6vgWilqYilhXNk6B1wzXayHKQgUEa8y4Jr+aQ3EMF?=
 =?us-ascii?Q?W9f+t12y6eo/6q260O4jaMNsCV+T4DZ5Txl9kPU0dCb36MX5dZ1rt/Fk7+bn?=
 =?us-ascii?Q?eC6gwVu0Oyyw38+p19MpphSx77mqiWxfLzJJwZAzzQI4o2BjOG6TRT8azn6n?=
 =?us-ascii?Q?SddgPD0JNcTv7qEK/fmVFoOSxyQitw3rImtNPTyTlAH1C0O5vT3tqZyZtYOh?=
 =?us-ascii?Q?dtGqpibEbhg+St4gP0ule+utS6AqrEaAZLip0VD2vp4PZv7mpF2Rlf+7tNsm?=
 =?us-ascii?Q?NqZKu7Jz01CZ9Cke0LQx4aPD2FBQyCC0SornQ+JT77EX7wDZryXwPkFOCLrO?=
 =?us-ascii?Q?FOx4L7N3ZfHcZG2xpe1CPei1F5m++dVxI9m+gU89OEoIODowoo7iPSIKjEOL?=
 =?us-ascii?Q?YZSZwxsDC6AwnEbSr+/IHbMwyTQFBBoB42CwBD8Fxbshnep49cWRsrIhZdRG?=
 =?us-ascii?Q?Ta75Dg9zO+9d9U/DHYWXHZQ7YebyRfAE1DHaK1FaQKiBHvmAsS3tdfxboLWO?=
 =?us-ascii?Q?a7YPq7n98o2uVcr4SehavvwKE/9oQzWtKZNWgCcDmD0qbv6e+jknnlmeTADR?=
 =?us-ascii?Q?78UHXw6x8bW6fUUAsdOjrvSLiStuT3x09k8/AjJmWJ6Lg7jjjXRdYUV3+CsH?=
 =?us-ascii?Q?tBjONaKBP3/6okuV1qxjUOKgjFVmWAdZfegnbgam+h48VEyb871FIfbrJRMk?=
 =?us-ascii?Q?5FaoqEoJ28f1UfcaOMJYBubac50HCPRRBPpP+BGDbK88hmUELzzzzZQygx+T?=
 =?us-ascii?Q?rsoc+0CaDqIInZ/CTb4uB77oNTNE8q2afuHc0fWtg8Tu5VGlbMU5J/4FU14H?=
 =?us-ascii?Q?EEsXIrlUjyYPtx7Js9UdjLxTBkkmAGut96/GpgNSxHjthtOEjIiTj1Z6LGD7?=
 =?us-ascii?Q?1C49YMf3Azo4A8CvIFAPDMdyv/97u+iXeSRiD9RyhJj1TqbGDFyMfD0FENqN?=
 =?us-ascii?Q?5j1YwSRZAB1SXkWZfsPQydMRKkixXW0B2sbnSLzmxP2Qi7Nm3GtSEtfTPu9k?=
 =?us-ascii?Q?gME4rEE/zklKr/Fh7ATUgg386Pp4xdtblY8uUGukw0EmKsbKUkz6rDqDlbjj?=
 =?us-ascii?Q?DYC+5bThhKfrucienjPybtwO9ZTdqlDmTRMSmpcBmwGoCeFmdB/iQFECrU78?=
 =?us-ascii?Q?3p/+D/RrmKYU2k1ab/oH+omxZKaM8N7vN6NEPLZSW2Q4WnhTEqchz0KtORXd?=
 =?us-ascii?Q?5bqUGoY9bKJIp4pwwOY5FVrfoJ51WDaDSyoQ+ccsUdyUIMbYTkWoWyH9rPcl?=
 =?us-ascii?Q?tN8kBXBQVTOabZVvuzJpvf0yE+Lk4PBeRXOgZyhv7bVJQXmz9OtMgNLI1NMY?=
 =?us-ascii?Q?w5RggtVS9B/olmIZXqZrS1PViuJaqvLQT/FSQabPUrgNqJCF1cvJVyx4uhIp?=
 =?us-ascii?Q?G/RLNdDr+sweyvVGpkbRYV/bQhRgBGYCkYcGrVD0ccN31LESMZYjfVHXTTb3?=
 =?us-ascii?Q?F9H3N45/xMNj4X4Dy+vQBv1ygzZkOHGhgHfVNDFTjH2uNdpiJRYm5BnnkDlh?=
 =?us-ascii?Q?E9XyGUT8STbGBJ+pUODEy+d6Kfz2W3hMK1+5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:00:19.5559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d53085d-b7cf-4f3b-573e-08ddc457f460
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512
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

This commit introduces HQD PQ address retrieval functionality for GFX11
hardware by:

1. Adding hqd_get_pq_addr function pointer to amdgpu_mqd structure
2. Implementing gfx_v11_0_hqd_get_pq_addr() for GFX11
3. Registering the function in gfx_v11_0_set_mqd_funcs()

Key features:
- Supports XCC instances for Compute queues
- Checks HQD active status before accessing registers
- Provides accurate queue address calculation combining high/low registers
- Maintains compatibility with existing reset mechanisms

This functionality will be used for hang detection and queue management
operations that need to identify specific hardware queues.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  4 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 49 ++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a1737556a77e..d06c86013bb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -889,6 +889,10 @@ struct amdgpu_mqd {
 	unsigned mqd_size;
 	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
 			struct amdgpu_mqd_prop *p);
+	uint64_t (*hqd_get_pq_addr)(struct amdgpu_device *adev, uint32_t queue_type,
+				    uint32_t me_id, uint32_t pipe_id, uint32_t queue_id,
+				    uint32_t xcc_id, uint32_t *vmid);
+
 };
 
 struct amdgpu_pcie_reset_ctx {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 372dceceff35..fa2d26f70adb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4162,6 +4162,51 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+static uint64_t gfx_v11_0_hqd_get_pq_addr(struct amdgpu_device *adev, uint32_t queue_type,
+                    uint32_t me_id, uint32_t pipe_id, uint32_t queue_id,
+                    uint32_t xcc_id, uint32_t *vmid)
+{
+	uint32_t low = 0, high = 0, active = 0;
+	uint64_t queue_addr = 0;
+
+	mutex_lock(&adev->srbm_mutex);
+	/* Enter safe mode to safely access HQD registers */
+	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
+
+
+	/* Select the specific ME/PIPE/QUEUE to access its HQD registers */
+	soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX) {
+		active = RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE);
+		if (!(active & 1))
+			goto unlock_out;
+
+		*vmid = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
+		low = RREG32_SOC15(GC, 0, regCP_GFX_HQD_BASE);
+		high = RREG32_SOC15(GC, 0, regCP_GFX_HQD_BASE_HI);
+
+		queue_addr = (((uint64_t)high << 32) | low) << 8;
+	} else if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		active = RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE);
+		if (!(active & 1))
+			goto unlock_out;
+
+		*vmid = RREG32_SOC15(GC, 0, regCP_HQD_VMID);
+		low = RREG32_SOC15(GC, 0, regCP_HQD_PQ_BASE);
+		high = RREG32_SOC15(GC, 0, regCP_HQD_PQ_BASE_HI);
+
+		queue_addr = (((uint64_t)high << 32) | low) << 8;
+	}
+
+unlock_out:
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	return queue_addr;
+}
+
 static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -7428,11 +7473,15 @@ static void gfx_v11_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v11_gfx_mqd);
 	adev->mqds[AMDGPU_HW_IP_GFX].init_mqd =
 		gfx_v11_0_gfx_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_GFX].hqd_get_pq_addr =
+		gfx_v11_0_hqd_get_pq_addr;
 	/* set compute eng mqd */
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size =
 		sizeof(struct v11_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v11_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].hqd_get_pq_addr =
+		gfx_v11_0_hqd_get_pq_addr;
 }
 
 static void gfx_v11_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.49.0

