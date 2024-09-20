Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7830CF9C69
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 21:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DD310E862;
	Fri, 20 Sep 2024 21:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w5BSi9oC";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9776D10E862
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 21:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8XkmZqXWBuTeQpAF1IghBejqQlvYEdzx7YP4nnLdk5yyYIHrVQrlDlelRF5S4v7HlAoSoNr1uzvd8cBF5ac9nSmsU+AxqzypdMvrwi0Ch9gGwsinpJ5UZPg/wrgkGg1ICKqUwls6G/bU4OclQKSDL6byMS1yDt9tctrUvNpJWIyamOG032CDeoVzghK16o5hSmZcMnPfvXfJaq7JOhFJiax0d8x1/kypfG1C/M0YO5w8ZXS59LnrqUgnK3dh6v/oHWspiAnMBxfNfKjgtUs61/SaSfU+zPP784g9r1mH83/u8TY2+JV6yqaqacYCSFuHYi714c7bpUtx1VHcZk0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwPOMQgMy2xkZlHfbL2kRvY8u5b0DPT4rQzCJvMlaxc=;
 b=cEoUnA6Pyn62qR/CfaKJZtvO9rIC5e2260DuyHQPfwzTl/LikclrY8G12ThdXbynY1iKXdAslAfnEUt+u81yFpd/EYQS282BnNlyYjD6UrhyWRJCidv0zUAOKu+GK1Km6KiHZVz/j1FsLYu2+WM45MePbwr/1OoCS1ScDo3ZYSiw+kJf3TczxAnDjBNz+PB5XVoamosqNbAgrnwqYkEAwymk14KVZjoOLIJzhxSuKhp1ZgfoG111+JbWzC+P75iq21Q0BtKh3Veft6yzZvk+1S4mUA5g3yw6cGSnm/09EAs9lk3UZKcFeQkHUjuKNo6ahN+4BLVUwWQ1gpQ0ZpCySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwPOMQgMy2xkZlHfbL2kRvY8u5b0DPT4rQzCJvMlaxc=;
 b=w5BSi9oCpSy1EZMAW62TDG4TLRBopFnPssSvOC+YKsaEXPMuQ1HSyKhJe1x483fOjdOk3mnNm1B7xCwZpoA/zeWTYrL+ttXgJ9tjeNW3PnR73xHVgJikW+evqRQRTTolQeoHpgEKd62r4cUEGXinvJ2h1X6gyNzOHL+sOVm/x1k=
Received: from BY5PR17CA0051.namprd17.prod.outlook.com (2603:10b6:a03:167::28)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 21:07:34 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::3d) by BY5PR17CA0051.outlook.office365.com
 (2603:10b6:a03:167::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Fri, 20 Sep 2024 21:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 21:07:33 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Sep
 2024 16:07:32 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 1/2] drm/amdkfd: Update logic for CU occupancy calculations
Date: Fri, 20 Sep 2024 17:07:14 -0400
Message-ID: <20240920210715.64118-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SA1PR12MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: a47f302e-b747-4617-8403-08dcd9b83f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kMCo4P/1u1ciNemp9LEjyoAdUrGKmvBAGWcL+X+sW9k4sISn34sypYcn00Sv?=
 =?us-ascii?Q?tWU+HjCOifYXCGDxhKa/KPM4vvjh5uqZP0e0KpVCHy66qu/KigNnbAQh/A6x?=
 =?us-ascii?Q?VNL56nB3x00H/And+DzWda8UFXRT6bLdE2lDsCqv5wvvSD2iJbfYsDSleO3Y?=
 =?us-ascii?Q?n89pvfl06Anx+/51KPXummB/3MleHkoi+X/nXqm2Cnc7BOZzx3qYJYgnwqqH?=
 =?us-ascii?Q?wH52AKRzo53vlTzO3DsNGUSMMwjkmJJaSIqaH3I6Z36gKakN6ZqzoWhhTb+2?=
 =?us-ascii?Q?PYYnW9grYG26vTlJ0PDZxow/kDf5El057dXP60CLTwUiRtqKfsW/XY+6sR3+?=
 =?us-ascii?Q?NQHDmp9qd7PJpBahIwga5KXVPTRiRYLmy45EVm/tN+4g3LMvrIjoZgKDNwhu?=
 =?us-ascii?Q?vKgaokr1/A6n3gzj/WlPl6wN6vP/pWCVasJuWd7VqRexXy1AW+xVnSkSGe1s?=
 =?us-ascii?Q?ZNM+cjjMlprbDl5yJoZnpFAFGIZPyJ5WyOOPhCFEKCPHC9DXzC4gImcLuYMJ?=
 =?us-ascii?Q?YGAWnAfWjlcMTKO5mtLX+DNZpaVo38Ze0VjA6zE1lfzKtWQ2Ldc9XxIFJNTH?=
 =?us-ascii?Q?mFrm+ERceuDh3n21UfPutym4VVnTS2S+ZyYFwnUATNjx8wK8VnP2Ug1neCL9?=
 =?us-ascii?Q?5ba8KogEJw8dp6WX6YFCGklBLi+g9CJSH/QDgtNGHK3YW7JL6UqwGE41vaWY?=
 =?us-ascii?Q?ET+mVjZlhpK5flTiWFdG/+UjQEDeGwCWC9L0RWEQZNK+IRMMOzpbE7sxq+Ec?=
 =?us-ascii?Q?M9JaYLjQiKFx7QvaGvBTU782iy2TZPfinabV/PwVXvtA48j9sCPhE+kBlFZ0?=
 =?us-ascii?Q?sYcBRAeiqgLlrR8PcMR7E8LnHVnw2USGFKcEQ+i41+WB+Cn5nnZmNkjzo24T?=
 =?us-ascii?Q?Wr5kVIEKlU8ZnM4XfPOzfJ6olea0pvVRvKyx1JKqEBmms2qwNY8WYknG4ExW?=
 =?us-ascii?Q?KI3jsKHotOU7ie4fCXxx41vulTZ7ZvGe4QM4lynLcVoAOaUZfZtZn2ocskkE?=
 =?us-ascii?Q?igATTtGNw06KBoLWFYSNz7WTQRnOxuv0rTfCie3n2tmmYRM3P0w4EmX0IQ7T?=
 =?us-ascii?Q?SFj1I72GiG82OxuxDnBG7578aLsbiZHfupMl58ltm8qMOAq76wydr7sB5MgR?=
 =?us-ascii?Q?zylJg2bdqAKjq3amXoa6x207MXZQuZyeYLQcTHdBmcwI00wVOawnnqo5GEKg?=
 =?us-ascii?Q?HMNFI+58bsaO8poNnaN33tsXA06rA5hPNERsUOrbV/0wZEsRQo0e99OyZMPB?=
 =?us-ascii?Q?aFvuozI7cMDDpjxZBA5yFoBiXeP7TTov9LRZ71SnuyEtIRfwPnpdcp5is5UJ?=
 =?us-ascii?Q?2omZ9qe+QdJHrLU4GXR0l27+x3JpW77yqsHiqbt6MdrcG9OD5liiWZnQnvaS?=
 =?us-ascii?Q?iI+IWpX66nRgBmRzPhzyccgRu3BG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 21:07:33.6033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a47f302e-b747-4617-8403-08dcd9b83f3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
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

Currently, the code use the IH_VMID_X_LUT register to map
a queue's vmid to the corresponding PASID. This logic is racy
since the CP can update the VMID-PASID mapping anytime especially
when there are more processes than number of vmids. Update the logic
to calculate CU occupancy by matching doorbell offset of the queue
with valid wave counts against the process's queues,

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Break into 2 patches, one for the generic change
  and the other for GFX v9.4.3.
- Incorporate Harish's comments.

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 97 ++++++++-----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  5 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 ++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  3 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 14 ++-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   | 10 +-
 6 files changed, 87 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 1254a43ec96b..fe8a8e7e9a9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -950,28 +950,30 @@ static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
  * @inst: xcc's instance number on a multi-XCC setup
  */
 static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
-		int *wave_cnt, int *vmid, uint32_t inst)
+		struct kfd_cu_occupancy *queue_cnt, uint32_t inst)
 {
 	int pipe_idx;
 	int queue_slot;
 	unsigned int reg_val;
-
+	unsigned int wave_cnt;
 	/*
 	 * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
 	 * parameters to read out waves in flight. Get VMID if there are
 	 * non-zero waves in flight.
 	 */
-	*vmid = 0xFF;
-	*wave_cnt = 0;
 	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
 	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
 	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, inst);
-	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +
-			 queue_slot);
-	*wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
-	if (*wave_cnt != 0)
-		*vmid = (RREG32_SOC15(GC, inst, mmCP_HQD_VMID) &
-			 CP_HQD_VMID__VMID_MASK) >> CP_HQD_VMID__VMID__SHIFT;
+	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst,
+				  mmSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot);
+	wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+	if (wave_cnt != 0) {
+		queue_cnt->wave_cnt += wave_cnt;
+		queue_cnt->doorbell_off =
+			(RREG32_SOC15(GC, inst, mmCP_HQD_PQ_DOORBELL_CONTROL) &
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	}
 }
 
 /**
@@ -1011,30 +1013,24 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
  *    number of waves that are in flight for the queue at specified index. The
  *    index ranges from 0 to 7.
  *
- *    If non-zero waves are in flight, read CP_HQD_VMID register to obtain VMID
- *    of the wave(s).
+ *    If non-zero waves are in flight, store the corresponding doorbell offset
+ *    of the queue, along with the wave count.
  *
- *    Determine if VMID from above step maps to pasid provided as parameter. If
- *    it matches agrregate the wave count. That the VMID will not match pasid is
- *    a normal condition i.e. a device is expected to support multiple queues
- *    from multiple proceses.
+ *    Determine if the queue belongs to the process by comparing the doorbell
+ *    offset against the process's queues. If it matches, aggregate the wave
+ *    count for the process.
  *
  *  Reading registers referenced above involves programming GRBM appropriately
  */
-void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
-		int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst)
+void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
+				 struct kfd_cu_occupancy *cu_occupancy,
+				 int *max_waves_per_cu, uint32_t inst)
 {
 	int qidx;
-	int vmid;
 	int se_idx;
-	int sh_idx;
 	int se_cnt;
-	int sh_cnt;
-	int wave_cnt;
 	int queue_map;
-	int pasid_tmp;
 	int max_queue_cnt;
-	int vmid_wave_cnt = 0;
 	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
 
 	lock_spi_csq_mutexes(adev);
@@ -1048,42 +1044,30 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 			  AMDGPU_MAX_QUEUES);
 	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
 			adev->gfx.mec.num_queue_per_pipe;
-	sh_cnt = adev->gfx.config.max_sh_per_se;
 	se_cnt = adev->gfx.config.max_shader_engines;
 	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
-		for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
+		amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
+		queue_map = RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_ACTIVE_STATUS);
+
+		/*
+		 * Assumption: queue map encodes following schema: four
+		 * pipes per each micro-engine, with each pipe mapping
+		 * eight queues. This schema is true for GFX9 devices
+		 * and must be verified for newer device families
+		 */
+		for (qidx = 0; qidx < max_queue_cnt; qidx++) {
+			/* Skip qeueus that are not associated with
+			 * compute functions
+			 */
+			if (!test_bit(qidx, cp_queue_bitmap))
+				continue;
 
-			amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xffffffff, inst);
-			queue_map = RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_ACTIVE_STATUS);
+			if (!(queue_map & (1 << qidx)))
+				continue;
 
-			/*
-			 * Assumption: queue map encodes following schema: four
-			 * pipes per each micro-engine, with each pipe mapping
-			 * eight queues. This schema is true for GFX9 devices
-			 * and must be verified for newer device families
-			 */
-			for (qidx = 0; qidx < max_queue_cnt; qidx++) {
-
-				/* Skip qeueus that are not associated with
-				 * compute functions
-				 */
-				if (!test_bit(qidx, cp_queue_bitmap))
-					continue;
-
-				if (!(queue_map & (1 << qidx)))
-					continue;
-
-				/* Get number of waves in flight and aggregate them */
-				get_wave_count(adev, qidx, &wave_cnt, &vmid,
-						inst);
-				if (wave_cnt != 0) {
-					pasid_tmp =
-					  RREG32(SOC15_REG_OFFSET(OSSSYS, inst,
-						 mmIH_VMID_0_LUT) + vmid);
-					if (pasid_tmp == pasid)
-						vmid_wave_cnt += wave_cnt;
-				}
-			}
+			/* Get number of waves in flight and aggregate them */
+			get_wave_count(adev, qidx, &cu_occupancy[qidx],
+					inst);
 		}
 	}
 
@@ -1092,7 +1076,6 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 	unlock_spi_csq_mutexes(adev);
 
 	/* Update the output parameters and return */
-	*pasid_wave_cnt = vmid_wave_cnt;
 	*max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
 				adev->gfx.cu_info.max_waves_per_simd;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 988c50ac3be0..b6a91a552aa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -52,8 +52,9 @@ bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
 					uint8_t vmid, uint16_t *p_pasid);
 void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t page_table_base);
-void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
-		int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst);
+void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
+				 struct kfd_cu_occupancy *cu_occupancy,
+				 int *max_waves_per_cu, uint32_t inst);
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
 		uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 71b465f8d83e..29578550b478 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3540,6 +3540,26 @@ int debug_refresh_runlist(struct device_queue_manager *dqm)
 	return debug_map_and_unlock(dqm);
 }
 
+bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
+				 struct qcm_process_device *qpd,
+				 int doorbell_off)
+{
+	struct queue *q;
+	bool r = false;
+
+	dqm_lock(dqm);
+
+	list_for_each_entry(q, &qpd->queues_list, list) {
+		if (q->properties.doorbell_off == doorbell_off) {
+			r = true;
+			goto out;
+		}
+	}
+
+out:
+	dqm_unlock(dqm);
+	return r;
+}
 #if defined(CONFIG_DEBUG_FS)
 
 static void seq_reg_dump(struct seq_file *m,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 08b40826ad1e..80be2036abea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -324,6 +324,9 @@ void set_queue_snapshot_entry(struct queue *q,
 int debug_lock_and_unmap(struct device_queue_manager *dqm);
 int debug_map_and_unlock(struct device_queue_manager *dqm);
 int debug_refresh_runlist(struct device_queue_manager *dqm);
+bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
+				 struct qcm_process_device *qpd,
+				 int doorbell_off);
 
 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a902950cc060..d73841268c9b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -270,6 +270,10 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	struct kfd_node *dev = NULL;
 	struct kfd_process *proc = NULL;
 	struct kfd_process_device *pdd = NULL;
+	int i;
+	struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
+
+	memset(cu_occupancy, 0x0, sizeof(cu_occupancy));
 
 	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
 	dev = pdd->dev;
@@ -287,9 +291,17 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	/* Collect wave count from device if it supports */
 	wave_cnt = 0;
 	max_waves_per_cu = 0;
-	dev->kfd2kgd->get_cu_occupancy(dev->adev, proc->pasid, &wave_cnt,
+
+	dev->kfd2kgd->get_cu_occupancy(dev->adev, cu_occupancy,
 			&max_waves_per_cu, 0);
 
+	for (i = 0; i < AMDGPU_MAX_QUEUES; i++) {
+		if (cu_occupancy[i].wave_cnt != 0 &&
+		    kfd_dqm_is_queue_in_process(dev->dqm, &pdd->qpd,
+						cu_occupancy[i].doorbell_off))
+			wave_cnt += cu_occupancy[i].wave_cnt;
+	}
+
 	/* Translate wave count to number of compute units */
 	cu_cnt = (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
 	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 7744ca3ef4b1..e3e635a31b8a 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -71,6 +71,11 @@ enum kgd_memory_pool {
 	KGD_POOL_FRAMEBUFFER = 3,
 };
 
+struct kfd_cu_occupancy {
+	u32 wave_cnt;
+	u32 doorbell_off;
+};
+
 /**
  * enum kfd_sched_policy
  *
@@ -313,8 +318,9 @@ struct kfd2kgd_calls {
 			uint32_t grace_period,
 			uint32_t *reg_offset,
 			uint32_t *reg_data);
-	void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
-			int *wave_cnt, int *max_waves_per_cu, uint32_t inst);
+	void (*get_cu_occupancy)(struct amdgpu_device *adev,
+				 struct kfd_cu_occupancy *cu_occupancy,
+				 int *max_waves_per_cu, uint32_t inst);
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
 			uint32_t inst);
-- 
2.35.1

