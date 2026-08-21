Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FBDC5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA43410F358;
	Fri, 21 Aug 2026 16:07:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DNXnv6o5";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A1110F355
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nK26KrC8fiSX2amjNLMLgbrtGEeysEkcziUB3lVB6w9U/d1ekEo0oiNAgPx2HMT+YCa7WdS+PsBkO9fbQtM/PjDRuGyUSrkUmOcdyQYNMLi2z8U/O+eShOnbbnLiz7qD4NLl84GF/duTUw2U7SDTQiFh6G1+kwRJk8C3d5XYoX7+SPeSCmMAXdJstcSJDV2jhX9wQNRwHGRufyQIOcGzdteyr6y1QaJn7BHFb5rucUuCd2FrOsz13o/22DpSt94aD/O9JiMjFdQi3kXK5E8h27LHE7RbmJTssI9HIReIFb2Na0CvG7HVSyTJ1iKPdUlrF45DuFp8ajHDce1zC3rVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atCYgDYqyY4WM4usI/Q4Gz9rkTn+MduztVlyuXe50jo=;
 b=X7XpSS7CUe2uWapL9MTtZ/WgkgfXCqnK4zdT/iaZxnX+GLh04oWiMCJeEGXxNxUwV/hVUS0edYkbQgSwON0jBL2Mkbx8IfMgw3O/At2ZV06YHYDYi1hKmT1W6/oOfqExR1Nhm7hAxkZ2Om6036CVK9pnNHLBIPhVsthhfDj/buMH8M+ZmpG/XEVydjIkqlOJfR8M082JwJJqRBERXiZcMprMjLUx1dPMMuLDKyLkW8Vwqcp3jOF/HoeiHPKt68Oz0UMYfIeHetENTmY4uPVihSKeyKvHL8hx6g2ae1VN0evDMlyRmcFCcZDtxIfUf1nDZmbfJRtoFc5kG/kM++mr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atCYgDYqyY4WM4usI/Q4Gz9rkTn+MduztVlyuXe50jo=;
 b=DNXnv6o5DdfgSwy14zx349da5sm7b19B6JgeFw23x+FSyG9k2+rIvjIh9IYjrgwvnpAyq8P4FJq9NrrbN4JTzJ0/1z2CEVOEhSlOxPRCUDws5XgY9+qZaMN01np8XblQfIYMRakQsGKe0268poEIe/kKqwrR+ZwG/pXgK+xR/v4=
Received: from SJ0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:a03:2ef::17)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:07:36 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::20) by SJ0PR03CA0192.outlook.office365.com
 (2603:10b6:a03:2ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:31 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/15] drm/amdkfd: set CP_IQ_WAIT_TIME2.QUE_SLEEP on GFX 12.1
Date: Fri, 21 Aug 2026 12:07:10 -0400
Message-ID: <20260821160710.752459-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 74010e94-6632-4f0c-95e0-08deff9e50c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G+ozj8WyTmIhhKXnOIaT3RQtsiZOw0V8CA/0M/VOwwYT9YQBKv36MrpcosT/0nINsmCrmHEJbTSy6f141wFDpABhv8/xKDTqIvur57i/wEUCoaH+RVQ1h8U8a8VsB6oC9vvBaPR81MMeXRBim3yte83OmoIALfCVdXMfgmka+DkXpQxUvEmilYy7ftpnteO+q6Jv0i/wBoqfV7Q/a8I7mzYOeFsDDGQrFiRXMb7UPXLUlpkO4CdylbfRkFCmNlpkZ4SVNQVN8Tar/18XJ2C7uGBLzMRcZFk8m5zFVatZ9cCtc5tmvxdsHpimuFDhMkfzkkAHUpfe2AmAkeHIWrjskdtCKtO8bs2vLJGQc00vrQgZ76nKTp2PYVdeO6/qRUGbfG38N9l3oaxsQgvnQgfgFBk0KZ2ra5VOprkMSh0egoyiH9Vk76U9bURZBH90pbZJVyemuh4z4/UujfL8fI3C4dunkCSgUu7BPXmjZiT6THqpdtiSmkz3bwP1mPUrpR9ZzPTu83XdahbxERRDD9ggh4AwPo4YpQobhOvatPFsqkM5rMeBxnQTy857mdlrRdIuY5xLW3rgrfYIBhIQl0FmbgvHXz4p0er+4wf6WAQ9BqqySWvty4v2C+Ibi+CgocE4hjZz4s1QgCauOOh4se+KnICmzl6DBVeCSqsWZ3MMTx2/wya+g9k40K96/l6Gz97DEo2PnDEMkeW8AaXHaF1r/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jt5OHV9+PeuJEQbNwbxmDEdISN5ykf6PXIDLhbb+WrERPynofoC/NbgSDE31hBrrm/oYTnAM1Rdxpatz1PuZ1DhpLyJYbjJYBgeosxp+xDRTwzUYCdEVzzf5afdgBvRdCWBI47j1sH5mD8+Ub28ijHYjxY7Q7t3aeJRu1LFGhbNl7sECQezveu6huCTX/Ku2El7l6K0EXxKp2eduHIO/lYBxpPKXkM9+nikNRZubtqZ81q/ELnk7GdsnYcPj4BbbyegYkThZamsSjdvPQriNeFUrB/CXqxObHSp0sLGJJYCSvLlSQrjIytUKaJCQRJ3rJ2hHAwE6ZZno/tM/zbmQ3GTlm/orAZUpB/IV7zjN9B3FCzLj3FUlJuPIWGDf3IbwTQ7RcrERSFqW99VX7etR0kDbun3SofXkoAfKyYCOlZ7lPo9dK0Ee1cI87K9RhcYA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:35.7496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74010e94-6632-4f0c-95e0-08deff9e50c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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

From: Mukul Joshi <mukul.joshi@amd.com>

The optimized QUE_SLEEP was only programmed on the HWS packet-manager
path via a PM4 WRITE_DATA packet, which is skipped when MES is enabled.

Add gfx12.1 get_iq_wait_times/build_dequeue_wait_counts_packet_info
callbacks and program CP_IQ_WAIT_TIME2 through the MES WRITE_REG op at
start_cpsch, per XCC.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c  | 36 ++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  3 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 40 +++++++++++++++++++
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  3 +-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 +-
 8 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 88acf75f0edd6..bc48b2ba30d11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -1026,7 +1026,8 @@ void kgd_gfx_v10_build_dequeue_wait_counts_packet_info(struct amdgpu_device *ade
 						uint32_t sch_wave,
 						uint32_t que_sleep,
 						uint32_t *reg_offset,
-						uint32_t *reg_data)
+						uint32_t *reg_data,
+						uint32_t inst)
 {
 	*reg_data = wait_times;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index a4c607c881783..df350ea67c306 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -56,7 +56,8 @@ void kgd_gfx_v10_build_dequeue_wait_counts_packet_info(struct amdgpu_device *ade
 					       uint32_t sch_wave,
 					       uint32_t que_sleep,
 					       uint32_t *reg_offset,
-					       uint32_t *reg_data);
+					       uint32_t *reg_data,
+					       uint32_t inst);
 uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
 				    uint32_t pipe_id,
 				    uint32_t queue_id,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
index 070001fd34b0f..0694bff871d2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
@@ -518,6 +518,37 @@ static void kgd_gfx_v12_1_get_cu_occupancy(struct amdgpu_device *adev,
 				adev->gfx.cu_info.max_waves_per_simd;
 }
 
+static void kgd_gfx_v12_1_get_iq_wait_times(struct amdgpu_device *adev,
+					uint32_t *wait_times,
+					uint32_t inst)
+{
+	*wait_times = RREG32_SOC15(GC, GET_INST(GC, inst), regCP_IQ_WAIT_TIME2);
+}
+
+static void kgd_gfx_v12_1_build_dequeue_wait_counts_packet_info(struct amdgpu_device *adev,
+					uint32_t wait_times,
+					uint32_t sch_wave,
+					uint32_t que_sleep,
+					uint32_t *reg_offset,
+					uint32_t *reg_data,
+					uint32_t inst)
+{
+	*reg_data = wait_times;
+
+	if (sch_wave)
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				SCH_WAVE,
+				sch_wave);
+	if (que_sleep)
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				QUE_SLEEP,
+				que_sleep);
+
+	*reg_offset = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_IQ_WAIT_TIME2);
+}
+
 const struct kfd2kgd_calls gfx_v12_1_kfd2kgd = {
 	.init_interrupts = init_interrupts_v12_1,
 	.hqd_dump = hqd_dump_v12_1,
@@ -532,5 +563,8 @@ const struct kfd2kgd_calls gfx_v12_1_kfd2kgd = {
 	.set_address_watch = kgd_gfx_v12_1_set_address_watch,
 	.clear_address_watch = kgd_gfx_v12_1_clear_address_watch,
 	.hqd_sdma_get_doorbell = kgd_gfx_v12_1_hqd_sdma_get_doorbell,
-	.get_cu_occupancy = kgd_gfx_v12_1_get_cu_occupancy
+	.get_cu_occupancy = kgd_gfx_v12_1_get_cu_occupancy,
+	.get_iq_wait_times = kgd_gfx_v12_1_get_iq_wait_times,
+	.build_dequeue_wait_counts_packet_info =
+				kgd_gfx_v12_1_build_dequeue_wait_counts_packet_info,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 2e116c06d5be3..b30ad9701bcef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1082,7 +1082,8 @@ void kgd_gfx_v9_build_dequeue_wait_counts_packet_info(struct amdgpu_device *adev
 		uint32_t sch_wave,
 		uint32_t que_sleep,
 		uint32_t *reg_offset,
-		uint32_t *reg_data)
+		uint32_t *reg_data,
+		uint32_t inst)
 {
 	*reg_data = wait_times;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 704452ca62f8e..9f43f16a1acea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -102,7 +102,8 @@ void kgd_gfx_v9_build_dequeue_wait_counts_packet_info(struct amdgpu_device *adev
 					       uint32_t sch_wave,
 					       uint32_t que_sleep,
 					       uint32_t *reg_offset,
-					       uint32_t *reg_data);
+					       uint32_t *reg_data,
+					       uint32_t inst);
 uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
 				    uint32_t pipe_id,
 				    uint32_t queue_id,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a233845711937..f6daef0e5ec09 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2046,6 +2046,43 @@ static int unhalt_cpsch(struct device_queue_manager *dqm)
 	return ret;
 }
 
+/* Program CP_IQ_WAIT_TIME2 via the MES WRITE_REG op (MES has no HIQ). */
+static int init_dequeue_wait_counts_mes(struct device_queue_manager *dqm)
+{
+	struct kfd_node *dev = dqm->dev;
+	struct amdgpu_device *adev = dev->adev;
+	uint32_t sch_wave = 0, que_sleep = 1;
+	int inst, ret;
+
+	if (!dev->kfd2kgd->build_dequeue_wait_counts_packet_info)
+		return 0;
+
+	if (KFD_GC_VERSION(dev) != IP_VERSION(12, 1, 0))
+		return 0;
+
+	/* CP_IQ_WAIT_TIME2 is per-XCC; the offset must encode the target
+	 * XCC so MES routes the write to that XCC's local register.
+	 */
+	for_each_inst(inst, dev->xcc_mask) {
+		uint32_t reg_offset = 0, reg_data = 0;
+
+		dev->kfd2kgd->build_dequeue_wait_counts_packet_info(
+				adev, dqm->wait_times, sch_wave, que_sleep,
+				&reg_offset, &reg_data, inst);
+
+		ret = amdgpu_mes_wreg(adev, reg_offset, reg_data, inst);
+		if (ret) {
+			dev_err(adev->dev,
+				"Failed to set optimized dequeue wait via MES on xcc %d\n",
+				inst);
+			return ret;
+		}
+	}
+
+	update_dqm_wait_times(dqm);
+	return 0;
+}
+
 static int start_cpsch(struct device_queue_manager *dqm)
 {
 	struct device *dev = dqm->dev->adev->dev;
@@ -2087,6 +2124,9 @@ static int start_cpsch(struct device_queue_manager *dqm)
 				KFD_DEQUEUE_WAIT_INIT, 0 /* unused */))
 			dev_err(dev, "Setting optimized dequeue wait failed. Using default values\n");
 		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
+	} else {
+		if (init_dequeue_wait_counts_mes(dqm))
+			dev_err(dev, "Setting optimized dequeue wait failed. Using default values\n");
 	}
 
 	/* setup per-queue reset detection buffer  */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 54868b81086e7..55d573fa3de38 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -306,7 +306,8 @@ static inline void pm_build_dequeue_wait_counts_packet_info(struct packet_manage
 		sch_value,
 		que_sleep,
 		reg_offset,
-		reg_data);
+		reg_data,
+		0);
 }
 
 /* pm_grace_period_0_supported - whether firmware tolerates a CWSR grace
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 965b50c8ca303..01c2631bbdff8 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -319,7 +319,8 @@ struct kfd2kgd_calls {
 			uint32_t sch_wave,
 			uint32_t que_sleep,
 			uint32_t *reg_offset,
-			uint32_t *reg_data);
+			uint32_t *reg_data,
+			uint32_t inst);
 	void (*get_cu_occupancy)(struct amdgpu_device *adev,
 				 struct kfd_cu_occupancy *cu_occupancy,
 				 int *max_waves_per_cu, uint32_t inst);
-- 
2.55.0

