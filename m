Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0217DCF3196
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A52F010E68F;
	Wed,  2 Oct 2024 04:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mAaLZA6e";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4B3A10E68F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6SJnvENis8aET5TPgDJ37DNN/hDvfpyqEZ5pBb6mVWJ+CBL6PJCo8Sv4/t416/hMSbxkrxWXEdSAFDSZ3GcZbeDEc3Prd9/jdrpqwym39Lk1BNiVM4KrVxDTn9may1c2O4J7JrfWmmwEs5OTFspQGxlCL/ilcw1uvlNK+LELtsZsA405QbpQ2129L7WvDf/6Gk3KZjgryEJCo/JCuiou49HU8HcZS9xXy//jnsjJBgSg28+7bAUyK4IodUHewHfPyU0roDYKZZK1/g7cpfUCwGKDJI2j7HVSUw5WeL6baxiDc75lMsYX5e8hzTWmGsWUGB38TOtHm4TXk6y0PjTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3QK0SwX7J4x9vndZhIK6GdP1sc+WWRMTSHXUiML/ls=;
 b=ViHLaejKC3oi/2/uxANtzPr1+R03bJce++YRL/COAim5iBX4PXv0m3wwYM04ahxo3nUURk8TMEm8Q6kuuBlempPIoOvAM8ak0xFKo3RGYYuEGZcCrSxEsCLyO0aTZ99vbRDxp/u3jLinVPbym/f4vU6gF/94OIdEUYJZK8dIiUXqqdveUwdGIOhbnM/7WyudFzR2uUG6G57RIbCIOWy1RhY5ztFXV5w5+HwYuLm/jgtRhhmmop3dxq2qmTIXMTNciybp4lm9YccKsXw2QnXULEZy60kTzAbMQEAUtGlKlzmDQrBVeJVhYwwaQL0LnAQkaZzKsroVtcm0/uKKzu0M6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3QK0SwX7J4x9vndZhIK6GdP1sc+WWRMTSHXUiML/ls=;
 b=mAaLZA6eymH7wKKtzZZImqxRs5BP5RkBDL3IkabujSdbIkDwxr2xRRkSFv/RS3F4BRF47BMofECIqoW2L861wYeRN9ySvlLTbwm2A2ra7+seJVPvpYO2bztZgIo3fITDcgliM/vX31t2E3X2oOySS/ht4XO7Bu8DJKWnug9z2l0=
Received: from SJ0PR13CA0143.namprd13.prod.outlook.com (2603:10b6:a03:2c6::28)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Wed, 2 Oct
 2024 04:40:08 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::ae) by SJ0PR13CA0143.outlook.office365.com
 (2603:10b6:a03:2c6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Wed, 2 Oct 2024 04:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:40:07 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:52 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 16/18] drm/amdgpu: power vcn 4_0_5 by instance
Date: Wed, 2 Oct 2024 00:36:25 -0400
Message-ID: <20241002043627.102414-17-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 61041179-0414-4082-242c-08dce29c4afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|30052699003|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cTDpbmaP/xn5kg7nUj6U9aabuQ7qzL1zv2JLUtXqL4RDqOlKQAySSWqds0PT?=
 =?us-ascii?Q?Kp30kWdsexP4qQ7NKvb8aix1SM9zW+j+rdflqa7wYBrlBg1CMUTOMrvNLAlP?=
 =?us-ascii?Q?vl1fI8gdfK1K2dLDRQ6gddVcREqhBeWqGOG5fFK1iNDmoy8Bhskg2bc2ZT7O?=
 =?us-ascii?Q?v+xulPZfGoBJSbkWamv2H9GcLv3DKLUxVYonHIlQv8a43vrc+Y8v00AyAFsv?=
 =?us-ascii?Q?Puv5SoKJ6qvbgOryc7FhdZJUEtqsnXjrhJXTD+lpZH4wFpaNjhnbpjoknA0j?=
 =?us-ascii?Q?brJB9haAXF9q12UD49u22ep4BmOiEVitEl2O8bd4CTZiw0YDYrSUES0/pEaq?=
 =?us-ascii?Q?pLp6O2dmMTtvq+ZwE3IrgfeH7WJLLglugApCbAVeFJh4PzF1dn2PLb7JlvFf?=
 =?us-ascii?Q?IZk+EsZLW/5D3vgvV16hLl83hSwwkgf9nWHFMzXk8yImWZd5hR9E9UpcgyCj?=
 =?us-ascii?Q?Qm8Pr3vUJw8cKIj8rKqysg2BydvPIpmiBsz3Kbvv/igNxtOXqqcFhiJDlvpE?=
 =?us-ascii?Q?Jx6qHgErC6FL4No1mS7QF3gfwNgD+suGGhXzHfnc5XjQ97LlFFhBHKo3E2vb?=
 =?us-ascii?Q?1aRIzZ92AOtTZY9pznK1GCHYRgYD4szdvF7RBHpWYQljnlcDPECj6arXB3Fj?=
 =?us-ascii?Q?K/FIS1uZYD0l5mWWLWlgrpml0lRBPYpiuAjjGo8DsGWJFJwiHAqIvxsS7tgi?=
 =?us-ascii?Q?/nBgSL3VjnOQ29QaZlrM4ai9kIXWjEU4PxRzxzHu2ju07A15s3gCZZqvj1gd?=
 =?us-ascii?Q?Qxx3L3dLDzAbOittjINv4KR+fPKT6aF2qfyWLQSm5CUIaT3ZfsY8IeuWZnIq?=
 =?us-ascii?Q?+N5zlkDMD5lHK7qu5JYqcpjq4kKsmVcUKNqkE+htgQHbgD7NqOjbH6/W69d7?=
 =?us-ascii?Q?N+KhYWWDAObF+lCK1znHQcAiow79Zhk95FpTs6ndLUvOOLo6LUbHh0QQtR5W?=
 =?us-ascii?Q?+Xx2KFkD/WioOKvCqdBoxruIw/2N3kDO4jftcZ8ywLmwYkBijx2YpMEF+dMo?=
 =?us-ascii?Q?29N29zeYDbfTjc09iDFJfvRyH2VhbieV54zvpiOggECjjNjvRuaWwg1+9wyH?=
 =?us-ascii?Q?uj/PEhJosQDGzAb8RrbP/1gBg6BUAVdmmtyJ/GiHooSmWnfK4uwua+MTOJ0I?=
 =?us-ascii?Q?RSXPaIYWSaQz4AOdWePjQ0lVYZpDATNTyOpnZDsuy0odX33l4BGourL5Oj/S?=
 =?us-ascii?Q?1QK1B+Nvm4A71d7HpqpLl7pBOrtv6me5c1Ucg2R6JBrMwRSh4fK2RK5gHY/q?=
 =?us-ascii?Q?bWwLNvSSK1YOx/V/FT4LlI87WG3e7BKltouZhb4oRu794jHTYKZ4W+z+xUX0?=
 =?us-ascii?Q?TReFjKwADvHzrFEVaojWUN44oHUL2Ywyt6Trnp3AnO2L9MeyIHmHU+be1/lp?=
 =?us-ascii?Q?bDLoCJB8TaHZdNk0mRx9jca9L470?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(30052699003)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:40:07.9306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61041179-0414-4082-242c-08dce29c4afe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

For vcn 4_0_5, add ip_block for each vcn instance during discovery stage.

And only powering on/off one of the vcn instance using the
instance value stored in ip_block, instead of powering on/off all
vcn instances. Modify the existing functions to use the instance value
in ip_block, and remove the original for loop for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 531 +++++++++---------
 2 files changed, 264 insertions(+), 270 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 909a97b502d5..2f177bd39ed8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2357,7 +2357,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			break;
 		case IP_VERSION(4, 0, 5):
 		case IP_VERSION(4, 0, 6):
-			amdgpu_device_ip_block_add(adev, &vcn_v4_0_5_ip_block);
+			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+				amdgpu_device_ip_block_add_instance(adev, &vcn_v4_0_5_ip_block, i);
 			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_5_ip_block);
 			break;
 		case IP_VERSION(5, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index a3bb42893803..1eae0a84e908 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -132,7 +132,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r;
+	int inst = ip_block->instance, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
 	uint32_t *ptr;
 
@@ -146,57 +146,55 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		atomic_set(&adev->vcn.inst[i].sched_score, 0);
+	atomic_set(&adev->vcn.inst[inst].sched_score, 0);
 
-		/* VCN UNIFIED TRAP */
-		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
-		if (r)
-			return r;
+	/* VCN UNIFIED TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
+	if (r)
+		return r;
 
-		/* VCN POISON TRAP */
-		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].irq);
-		if (r)
-			return r;
+	/* VCN POISON TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[inst].irq);
+	if (r)
+		return r;
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		ring->use_doorbell = true;
-		if (amdgpu_sriov_vf(adev))
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-						i * (adev->vcn.num_enc_rings + 1) + 1;
-		else
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-						2 + 8 * i;
-		ring->vm_hub = AMDGPU_MMHUB0(0);
-		sprintf(ring->name, "vcn_unified_%d", i);
-
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-				AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
-		if (r)
-			return r;
+	ring = &adev->vcn.inst[inst].ring_enc[0];
+	ring->use_doorbell = true;
+	if (amdgpu_sriov_vf(adev))
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					inst * (adev->vcn.num_enc_rings + 1) + 1;
+	else
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					2 + 8 * inst;
+	ring->vm_hub = AMDGPU_MMHUB0(0);
+	sprintf(ring->name, "vcn_unified_%d", inst);
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
-		fw_shared->sq.is_enabled = 1;
+	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
+			AMDGPU_RING_PRIO_0, &adev->vcn.inst[inst].sched_score);
+	if (r)
+		return r;
 
-		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
-		fw_shared->smu_dpm_interface.smu_interface_type = (adev->flags & AMD_IS_APU) ?
-			AMDGPU_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+	fw_shared->sq.is_enabled = 1;
 
-		if (amdgpu_sriov_vf(adev))
-			fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
+	fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
+	fw_shared->smu_dpm_interface.smu_interface_type = (adev->flags & AMD_IS_APU) ?
+		AMDGPU_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
 
-		if (amdgpu_vcnfw_log)
-			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
-	}
+	if (amdgpu_sriov_vf(adev))
+		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
 
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
+done:
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -997,178 +995,176 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
  *
  * Start VCN block
  */
-static int vcn_v4_0_5_start(struct amdgpu_device *adev)
+static int vcn_v4_0_5_start(struct amdgpu_device *adev, unsigned int inst)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
-	int i, j, k, r;
+	int j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true, 1);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
-		}
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v4_0_5_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
+		return r;
+	}
 
-		/* disable VCN power gating */
-		vcn_v4_0_5_disable_static_power_gating(adev, i);
-
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
-
-		/*SW clock gating */
-		vcn_v4_0_5_disable_clock_gating(adev, i);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
-				~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-
-		/* setup regUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
-				UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
-				UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-				UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-				UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup regUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
-		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
-				((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-				 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-				 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-				 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
-				((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-				 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-				 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-				 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
-				((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
-				 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
-				 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
-
-		vcn_v4_0_5_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
-				adev->gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
-				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		for (j = 0; j < 10; ++j) {
-			uint32_t status;
-
-			for (k = 0; k < 100; ++k) {
-				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
-				if (status & 2)
-					break;
-				mdelay(10);
-				if (amdgpu_emu_mode == 1)
-					msleep(1);
-			}
+	/* disable VCN power gating */
+	vcn_v4_0_5_disable_static_power_gating(adev, inst);
+
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, inst, regUVD_STATUS, tmp);
+
+	/*SW clock gating */
+	vcn_v4_0_5_disable_clock_gating(adev, inst);
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
+			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN), 0,
+			~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_LMI_CTRL2), 0,
+			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
+	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL, tmp |
+			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup regUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_MPC_CNTL);
+	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, inst, regUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUXA0,
+			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+			 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+			 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+			 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUXB0,
+			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+			 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+			 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+			 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUX,
+			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+			 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+			 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v4_0_5_mc_resume(adev, inst);
 
-			if (amdgpu_emu_mode == 1) {
-				r = -1;
-				if (status & 2) {
-					r = 0;
-					break;
-				}
-			} else {
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, inst, regUVD_GFX10_ADDR_CONFIG,
+			adev->gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL), 0,
+			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j < 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k < 100; ++k) {
+			status = RREG32_SOC15(VCN, inst, regUVD_STATUS);
+			if (status & 2)
+				break;
+			mdelay(10);
+			if (amdgpu_emu_mode == 1)
+				msleep(1);
+		}
+
+		if (amdgpu_emu_mode == 1) {
+			r = -1;
+			if (status & 2) {
 				r = 0;
-				if (status & 2)
-					break;
-
-				dev_err(adev->dev,
-					"VCN[%d] is not responding, trying to reset VCPU!!!\n", i);
-				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-							UVD_VCPU_CNTL__BLK_RST_MASK,
-							~UVD_VCPU_CNTL__BLK_RST_MASK);
-				mdelay(10);
-				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+				break;
+			}
+		} else {
+			r = 0;
+			if (status & 2)
+				break;
+
+			dev_err(adev->dev,
+				"VCN[%d] is not responding, trying to reset VCPU!!!\n", inst);
+			WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
+						UVD_VCPU_CNTL__BLK_RST_MASK,
 						~UVD_VCPU_CNTL__BLK_RST_MASK);
+			mdelay(10);
+			WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
+					~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-				mdelay(10);
-				r = -1;
-			}
+			mdelay(10);
+			r = -1;
 		}
+	}
 
-		if (r) {
-			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
-			return r;
-		}
+	if (r) {
+		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", inst);
+		return r;
+	}
+
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN),
+			UVD_MASTINT_EN__VCPU_EN_MASK,
+			~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_STATUS), 0,
+			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
-				UVD_MASTINT_EN__VCPU_EN_MASK,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
+	ring = &adev->vcn.inst[inst].ring_enc[0];
+	WREG32_SOC15(VCN, inst, regVCN_RB1_DB_CTRL,
+			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+			VCN_RB1_DB_CTRL__EN_MASK);
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
-				~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+	WREG32_SOC15(VCN, inst, regUVD_RB_BASE_LO, ring->gpu_addr);
+	WREG32_SOC15(VCN, inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst, regUVD_RB_SIZE, ring->ring_size / 4);
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
-				ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-				VCN_RB1_DB_CTRL__EN_MASK);
-
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
-
-		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
-		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
-		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
-		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
-
-		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
-		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
-
-		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
-		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
-		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
-	}
+	tmp = RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
+	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+	WREG32_SOC15(VCN, inst, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, 0);
+
+	tmp = RREG32_SOC15(VCN, inst, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, tmp);
+	ring->wptr = RREG32_SOC15(VCN, inst, regUVD_RB_WPTR);
+
+	tmp = RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
 	return 0;
 }
@@ -1208,81 +1204,79 @@ static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  *
  * Stop VCN block
  */
-static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
+static int vcn_v4_0_5_stop(struct amdgpu_device *adev, unsigned int inst)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
-	int i, r = 0;
+	int r = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
-
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			vcn_v4_0_5_stop_dpg_mode(adev, i);
-			continue;
-		}
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
-
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
-
-		/* disable LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
-
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
-				UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-				~(UVD_VCPU_CNTL__CLK_EN_MASK));
-
-		/* apply soft reset */
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v4_0_5_stop_dpg_mode(adev, inst);
+		goto done;
+	}
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		/* apply HW clock gating */
-		vcn_v4_0_5_enable_clock_gating(adev, i);
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* enable VCN power gating */
-		vcn_v4_0_5_enable_static_power_gating(adev, i);
-	}
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL),
+			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
+			UVD_VCPU_CNTL__BLK_RST_MASK,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
+			~(UVD_VCPU_CNTL__CLK_EN_MASK));
+
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
+
+	/* clear status */
+	WREG32_SOC15(VCN, inst, regUVD_STATUS, 0);
+
+	/* apply HW clock gating */
+	vcn_v4_0_5_enable_clock_gating(adev, inst);
+
+	/* enable VCN power gating */
+	vcn_v4_0_5_enable_static_power_gating(adev, inst);
+done:
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false, 1);
 
 	return 0;
 }
@@ -1535,20 +1529,19 @@ static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i = ip_block->instance;
 	int ret;
 
-	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == adev->vcn.cur_state[i])
-			return 0;
+	if (state == adev->vcn.cur_state[i])
+		return 0;
 
-		if (state == AMD_PG_STATE_GATE)
-			ret = vcn_v4_0_5_stop(adev);
-		else
-			ret = vcn_v4_0_5_start(adev);
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_5_stop(adev, i);
+	else
+		ret = vcn_v4_0_5_start(adev, i);
 
-		if (!ret)
-			adev->vcn.cur_state[i] = state;
-	}
+	if (!ret)
+		adev->vcn.cur_state[i] = state;
 
 	return ret;
 }
-- 
2.34.1

