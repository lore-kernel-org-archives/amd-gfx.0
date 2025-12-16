Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1B7D5E374
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4C910E2F3;
	Tue, 16 Dec 2025 21:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CasmhT2b";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EE610E2F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+8QWC+nsyq4pyPpw+eszq6X8cf8kmBvPzqFoRWkKVpTQLLMCiyMoSi+2oYu/5Eu17AtGHMydkvn37pZ1sQL5gl5xYgQp1EBHZECkXLkkLYNT7jMi0wRpy3F1CTas/ZzFuwKU/V6WA9Ye5eXywtCMchVm2FUysq2o4CnVMdVDB3fzzeRHT+z/Hptwops0+B2LCi/HbyDfZxAzErMAe/PWOMGObDsyxhi1X8+2WmnOD4s28CJ52GkXu7ES0l6uKDUcNr8deEFmKQ8oVrQE0mrLDIcxgSSv0OyPiWqKJxlvRXX3XKG44Y8oMj/pI27MYNun4snTVvZGeoG2ARSuttPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7l7ViOGvU74GStyTU+NzZS1q2IVFMnWXENIVTTqYDc=;
 b=JWd6Bs9oxCwsa2kviciNsCEtAqOv/08YeD+D5AHqqcd7BM5BbarseCY3jgL3t3N1LPMII9k0/p2qncpOTsCowxDP+9NBwNgz6GEX1HHx2GC5XhnX8O1qC6i2VmLIpFSYRDwN8Jieqj2z8yfRHfZvs+Ucno2WUIApq+92GvOYDnuY2pDcI9vSDLNLSx/gRO7SwNnpuTMxD6wdrhU15CRY4sCSmhoy1jTM8VCqlpFveArDeWfkbDycAQk3rpQfCShrhcNxPYE3Qq9JOhrvMWFWUTfphghjP1TXkFsr834PVO4YJpgcAxAN5L0XPGfEc0ID9tgtbRaqL+WebpNL9Yzytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7l7ViOGvU74GStyTU+NzZS1q2IVFMnWXENIVTTqYDc=;
 b=CasmhT2baFWkmB3zQ/D0fmDhM3NyO9Z3/zkrKXjQzo8401O4ZzHTc0+8j3Xe+C2mto8rvZ8a4I/tIpPUdwSOscDoCI/dVw+YDG2vQrP4Mdxo7T/H+VTTN1utQkSYXAQ2LQcOTUHB4ZEadlv8MOKBlZdlwuZbaJVjj2MKHO2OL7E=
Received: from BL1P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::21)
 by LV5PR12MB9755.namprd12.prod.outlook.com (2603:10b6:408:307::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:02 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::82) by BL1P223CA0016.outlook.office365.com
 (2603:10b6:208:2c4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:02 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lang Yu <lang.yu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx12.1: Don't fetch default register values from
 hardware in mqd init
Date: Tue, 16 Dec 2025 16:03:27 -0500
Message-ID: <20251216210349.1963466-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|LV5PR12MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: f72b6e6d-cfa2-47fa-c2b7-08de3ce6a3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KVJF9Vp80gWhfnB1p0j1RfuCLrh3uww7FpkJKPLxuEJSmBsDdAh9L48WT/4I?=
 =?us-ascii?Q?V3cCdCS5isIYpxnwl5WGJs1klejpoAJigZiEObt8aXr05u+yq+2ExyDA2X6N?=
 =?us-ascii?Q?ga170OFxiBm3vedgAlltbuCpYwq89jfD0WzWvXHCbD0l2V3zpiFjnlbJUTF6?=
 =?us-ascii?Q?pqehUUalN0NQ+ujo9iUszJJZ6GWn/4pU3xhoC+o2HZj8TZPUvOdrlcsZ1gAX?=
 =?us-ascii?Q?kENdhW8XzVo2zQf1UO/a5+4rod/8Z8h6rQIvCD9S+oOjAT3NS4wZmp2LPVlU?=
 =?us-ascii?Q?2jGQJE+N6QNEtEVYlB8ZiQcTZepmb2VcptpnYbQw87mX0KGIbppS3srsHRI2?=
 =?us-ascii?Q?4GNP/JvEGx6e4gZoKeej3DEuiS3RYpg6RNHa1BPm4AXI18jfF/ftijMP6+V6?=
 =?us-ascii?Q?Y008yZudDrKr/JMhzptlzD0QA1LZohYt/jKYd3ypQC+zJPs4x6v7ybyUO3E2?=
 =?us-ascii?Q?C3KNNOtl/rYF01a882cweCqMF4ayC/EZZv5LO5DMftNF5W7DZ+ByOQUkfVwv?=
 =?us-ascii?Q?+JSE4omqSxGtToYmnp+wyFR7sfN3aKmgnXWFMPjJs+l9rUg1cjgREP7VnFtz?=
 =?us-ascii?Q?GcJ/Fg2e7M3j3PVQQ1fxmwN60qO/PnFiWbYV6+AyvrqOEtUqtNdmKjtf1Jgr?=
 =?us-ascii?Q?J7XRuL+86+jBDVhVt0NmLDaebPJMOppLe/3yRhf4xn0pIy7ZYcrgJICyCUIP?=
 =?us-ascii?Q?nfTmKB66ml8yXVITb4s9ZFKvvsdQsyBwnrTCAPAa+3PPMWvFsI4DHK9Ef8gD?=
 =?us-ascii?Q?4BFsn2NLlnKGjfI6qb9nmcWgURZCfnH1umLfq7PF21krfs46sP3d06hWAuUt?=
 =?us-ascii?Q?LNUnPoms/tJ1U6CtG6Z3/a2sf1JBgx9Gy4AXs+kpr5gr9fo9t9isEEeDCVxI?=
 =?us-ascii?Q?mj6OEL+1iRPfplnZXdpCmNz+BbXg+2Wj2HM5hrsQ76j0w+PF72VyFhC7vkOt?=
 =?us-ascii?Q?Tvt1h3+LAgGkacgonTgW8MgYQr+3pXUYjn9zTbTjPBa0tFppmpfjkjaL5ToQ?=
 =?us-ascii?Q?eyoAlB4dw68pVpfCZIRhx6teihAmpYb2NNGZ+oAAUkUzqNblwU98tRckkeMy?=
 =?us-ascii?Q?8BgfCrwerb+ypWPp2whS6cufVdQPODvjaDABSwYJaqm3lepCnfaJVgyghXTD?=
 =?us-ascii?Q?ymoq6EnDZQsYslUTeAV99DqojA4r9qcqfovPWLa2xkT4D7v34H/6S5OV7hBq?=
 =?us-ascii?Q?V+ItfL1GNNaohpg1vdWYR9AZWw/zs1toD5GMu/afzqeFb0zZeK0M7oObGYnT?=
 =?us-ascii?Q?BX2eMd39DIPlGUSarlgz8oLFt+JcZpBFx7affG2Rmc3iGGujLZbTTJIPTcu9?=
 =?us-ascii?Q?BD4wzoNS5tcDA9hgLpdWdDtJ0mActAb0I6TYQ5NQ5zI2fBgcJdJcp3rjIaSe?=
 =?us-ascii?Q?BTofwf/geHZjA5vqYgY7kSFT/zN1/mMC4L2ZOq//Sq7DY3orVvylvy9Kg3tu?=
 =?us-ascii?Q?wfrclqi00xkAtxC+U5WMqv459eljgyEF1JSW6dM+HOvyX/MPo0w3b8vWQr34?=
 =?us-ascii?Q?fC/vbBeyAY0oW0VYjs1smB7mousB7tmPbPUZZFwAOYMmt4h0favYUJ8jKS41?=
 =?us-ascii?Q?uIdNBseVn+nA2MYS9yY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:02.2449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f72b6e6d-cfa2-47fa-c2b7-08de3ce6a3e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9755
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

From: Lang Yu <lang.yu@amd.com>

1. We can't assure the fetched values are always default register values.
   Observing non-zero cp_hqd_pq_rptr in mes_v12_1_self_test->init_mqd()
   where no GRBM_GFX_CNTL is specified.

2. See commit 8e06e87ec18d ("drm/amdgpu/gfx12: don't read registers in mqd init").

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 64b949195587f..c2c4cb6154fb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -50,6 +50,14 @@
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 
+#define regCP_HQD_EOP_CONTROL_DEFAULT                                             0x00000000
+#define regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT                                     0x00000000
+#define regCP_MQD_CONTROL_DEFAULT                                                 0x00000100
+#define regCP_HQD_PQ_CONTROL_DEFAULT                                              0x00308509
+#define regCP_HQD_PQ_RPTR_DEFAULT                                                 0x00000000
+#define regCP_HQD_PERSISTENT_STATE_DEFAULT                                        0x0ae06301
+#define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00100000
+
 MODULE_FIRMWARE("amdgpu/gc_12_1_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc.bin");
 
@@ -2115,14 +2123,14 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_EOP_CONTROL);
+	tmp = regCP_HQD_EOP_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
 			(order_base_2(GFX12_MEC_HPD_SIZE / 4) - 1));
 
 	mqd->cp_hqd_eop_control = tmp;
 
 	/* enable doorbell? */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PQ_DOORBELL_CONTROL);
+	tmp = regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
 
 	if (prop->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
@@ -2151,7 +2159,7 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(prop->mqd_gpu_addr);
 
 	/* set MQD vmid to 0 */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_MQD_CONTROL);
+	tmp = regCP_MQD_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
@@ -2161,7 +2169,7 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PQ_CONTROL);
+	tmp = regCP_HQD_PQ_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
@@ -2186,7 +2194,7 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = 0;
 	/* enable the doorbell if requested */
 	if (prop->use_doorbell) {
-		tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PQ_DOORBELL_CONTROL);
+		tmp = regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				DOORBELL_OFFSET, prop->doorbell_index);
 
@@ -2201,17 +2209,17 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pq_doorbell_control = tmp;
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PQ_RPTR);
+	mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
 
 	/* set the vmid for the queue */
 	mqd->cp_hqd_vmid = 0;
 
-	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PERSISTENT_STATE);
+	tmp = regCP_HQD_PERSISTENT_STATE_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x63);
 	mqd->cp_hqd_persistent_state = tmp;
 
 	/* set MIN_IB_AVAIL_SIZE */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_IB_CONTROL);
+	tmp = regCP_HQD_IB_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 1);
 	mqd->cp_hqd_ib_control = tmp;
 
-- 
2.52.0

