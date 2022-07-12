Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2D3C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 02:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA73C8F7F4;
	Tue, 12 Jul 2022 02:55:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7BE48F7F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 02:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lqhi9yGfMie7p5ENUZqwxMp+cD5SJnM1NSg8zpi3w0Bw7C4dsONXk0ixgOag6PqHb/GMyqd6QEE/HNUD32Ll7hsvf+UMH1TLr1WuDrEaXoTrNQiCINMIIBb+ouynJkbAoZSXU5vyTYxq+0M9YZegfaNF5VesRZU8DUcXdvB+MbIFJ22Yi2qcYkuFGDUGxFG3KLna4buMlkKXzp3aE6X5f/o2ojp0fBoXw9M7F0EKKjizWGTtSML3NJS7LrJruUSrcYX/pUhDSvxxV8Mllz1KXn2guNSuWbHXDY84oeI5aOGUdtsuTim+lpLeSCCwUZtjWcYsZwkBgElFKfn1YV5E7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0LbxHIk718QcDehZ1Dr5+37LgiFrJlIliwiEaFMy00=;
 b=hzfrDA++Zq/GTbVpGnEgUatRG+/2Ga4iyhd9KawjS8tOFhhjpMNbv5hl8wsib+sz4/HAI6MsGmeSdcxVkiLoPwpT+nXYWJzzIPyc4ZI4dJnihLA+aI/JHjTGcSvzWQsdc9IVzeKRzK0ke5G2CPT5PbFLPOktL4dLfCpNV6BuqygctA464XBM8Ur/Ltka0eG1R0HHSK9TOiv25Yez3UH1ZoxQ6XFExhiFC1jq/9a8DNLRdf6eRf6GkWKK8eQ0HTb5HZ/WwKosBXSZHXI6zDhnUzzP/JzqhdeBngv0T+BbkByqzwZCtLPFuPIIK8g/v7ITjxPdZh1s2lNzNlmp2L237g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0LbxHIk718QcDehZ1Dr5+37LgiFrJlIliwiEaFMy00=;
 b=L155bKE51UjjY1OZCFCxeUvDj25+y5IPk8Cm06mIlSAqn9oB+lr1FQ+Nrpnpmp0bJpZQCNL/6syXgxTe0dGqIAs/2oPaKKjAEHcW3kW7rWtg5SWl05ACnTsmtpaDeM65w88JImAlwwy0eCyMf2auzDRG5JFCLGv/vSW0O1ZaKdc=
Received: from BN9PR03CA0310.namprd03.prod.outlook.com (2603:10b6:408:112::15)
 by DM6PR12MB3561.namprd12.prod.outlook.com (2603:10b6:5:3e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 02:55:22 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::f1) by BN9PR03CA0310.outlook.office365.com
 (2603:10b6:408:112::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Tue, 12 Jul 2022 02:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 02:55:22 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 21:55:20 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu/mes: init aggregated doorbell
Date: Tue, 12 Jul 2022 10:54:57 +0800
Message-ID: <20220712025501.2083086-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 914ee80c-a187-4d38-7a6a-08da63b1f682
X-MS-TrafficTypeDiagnostic: DM6PR12MB3561:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ny0TUdB9zWyGCTZnGnaPt6k3Soay5eqS/Ozhek925LMMbOzENE7CGHGf9FSXrXtPswYvHLAPFshdlNfUKmK3cWaqPCXDXKj+jgi+jYoOkpgBx85EWdkCnj340I8gu6a3Y1hU7pIJYaiWfkMULv5RWSrJ4LH9P4VDGFsROea3BI003Vzv4NXMlpR9ofHTVvy6RBhdyiaf3VI549wNIlXaK0MBIEZn7scZX7ApLozZ321lNrgqSeAm02II/EZzfeUqU4GL0HW5au7yEiAxGVPuqgPkRZbihVK3lwNYfFhREp653Qx1Ng0HSgdUqvCK8bJCUr+/h8+lQUYqub7k7H+Aywmu2kQ2SxVCYWGLhId17ZvlehWsCx0j/YKDQpiLkrlhJpl/PwFMZcOyWvrp0qmDHliz1WxDncJV2ZPwQBuDvecPhLVhStib07EHY7lgcjF6+dSGEm93fpS5/dlPUBAuKruIE6QbPmL+Osr/m2wJFN/H2XL8CYThE6o9z3Bq6Yi/rJ0QUoaJKVGINFlekJzTfHDKT7gxOZZ+AexBqSjvJt/LxqtuwlinmD2W9tCLQI8sLAhu0WS7jlkXSqmhKIDQtOpDC6yongrR7XWRX48n8quxASBycWyHA0Rj2tQlv4Q0PUr2z4tPNgiOk2/tpnrqHol/SllD5IpbYMEQ5RNuUCZYX4pyAYQjuaMw40DU2bdTSUOiYOW5HG5xQjWgJ24cVUQ/efochOj3b1cUav82YBc3BaKpDRAt2Z1s+Et8hGg/Ssyo3xaAboRzDmtH7PxQUpW+8pXg4TigV69W4x8SVMK9S05Wv0OWW/zfzwM7qOmE+jq6vA0AkqZnlQ5tV7w4YheyHYHKyH7+GY3y2oZq7r0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(40470700004)(46966006)(336012)(70586007)(186003)(1076003)(86362001)(356005)(8676002)(82740400003)(82310400005)(7696005)(16526019)(426003)(6666004)(4326008)(41300700001)(2616005)(47076005)(478600001)(2906002)(26005)(6916009)(5660300002)(70206006)(40480700001)(316002)(36860700001)(40460700003)(8936002)(36756003)(83380400001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 02:55:22.1828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 914ee80c-a187-4d38-7a6a-08da63b1f682
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3561
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
Cc: Le Ma <le.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Allocate and enable aggregated doorbell.

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 16 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 58 ++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index de80161fb27b..e664f714e4ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -114,8 +114,14 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 	size_t doorbell_start_offset;
 	size_t doorbell_aperture_size;
 	size_t doorbell_process_limit;
+	size_t aggregated_doorbell_start;
+	int i;
 
-	doorbell_start_offset = (adev->doorbell_index.max_assignment+1) * sizeof(u32);
+	aggregated_doorbell_start = (adev->doorbell_index.max_assignment + 1) * sizeof(u32);
+	aggregated_doorbell_start =
+		roundup(aggregated_doorbell_start, PAGE_SIZE);
+
+	doorbell_start_offset = aggregated_doorbell_start + PAGE_SIZE;
 	doorbell_start_offset =
 		roundup(doorbell_start_offset,
 			amdgpu_mes_doorbell_process_slice(adev));
@@ -135,6 +141,11 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 	adev->mes.doorbell_id_offset = doorbell_start_offset / sizeof(u32);
 	adev->mes.max_doorbell_slices = doorbell_process_limit;
 
+	/* allocate Qword range for aggregated doorbell */
+	for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++)
+		adev->mes.aggregated_doorbells[i] =
+			aggregated_doorbell_start / sizeof(u32) + i * 2;
+
 	DRM_INFO("max_doorbell_slices=%zu\n", doorbell_process_limit);
 	return 0;
 }
@@ -174,9 +185,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			adev->mes.sdma_hqd_mask[i] = 0xfc;
 	}
 
-	for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++)
-		adev->mes.agreegated_doorbells[i] = 0xffffffff;
-
 	r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs);
 	if (r) {
 		dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 3730df05f6b9..9b011a40906b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -112,7 +112,7 @@ struct amdgpu_mes {
 	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
 	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
 	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
-	uint32_t                        agreegated_doorbells[AMDGPU_MES_PRIORITY_NUM_LEVELS];
+	uint32_t                        aggregated_doorbells[AMDGPU_MES_PRIORITY_NUM_LEVELS];
 	uint32_t                        sch_ctx_offs;
 	uint64_t			sch_ctx_gpu_addr;
 	uint64_t			*sch_ctx_ptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 88317e77c0a8..0082e2e1e0b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -294,7 +294,7 @@ static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
 
 	for (i = 0; i < AMD_PRIORITY_NUM_LEVELS; i++)
 		mes_set_hw_res_pkt.aggregated_doorbells[i] =
-			mes->agreegated_doorbells[i];
+			mes->aggregated_doorbells[i];
 
 	for (i = 0; i < 5; i++) {
 		mes_set_hw_res_pkt.gc_base[i] = adev->reg_offset[GC_HWIP][0][i];
@@ -313,6 +313,60 @@ static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
 			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
 }
 
+static void mes_v10_1_init_aggregated_doorbell(struct amdgpu_mes *mes)
+{
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t data;
+
+	data = RREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL1);
+	data &= ~(CP_MES_DOORBELL_CONTROL1__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL1__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL1__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_LOW] <<
+		CP_MES_DOORBELL_CONTROL1__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL1__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL1, data);
+
+	data = RREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL2);
+	data &= ~(CP_MES_DOORBELL_CONTROL2__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL2__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL2__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_NORMAL] <<
+		CP_MES_DOORBELL_CONTROL2__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL2__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL2, data);
+
+	data = RREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL3);
+	data &= ~(CP_MES_DOORBELL_CONTROL3__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL3__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL3__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_MEDIUM] <<
+		CP_MES_DOORBELL_CONTROL3__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL3__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL3, data);
+
+	data = RREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL4);
+	data &= ~(CP_MES_DOORBELL_CONTROL4__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL4__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL4__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_HIGH] <<
+		CP_MES_DOORBELL_CONTROL4__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL4__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL4, data);
+
+	data = RREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL5);
+	data &= ~(CP_MES_DOORBELL_CONTROL5__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL5__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL5__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_REALTIME] <<
+		CP_MES_DOORBELL_CONTROL5__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL5__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL5, data);
+
+	data = 1 << CP_HQD_GFX_CONTROL__DB_UPDATED_MSG_EN__SHIFT;
+	WREG32_SOC15(GC, 0, mmCP_HQD_GFX_CONTROL, data);
+}
+
 static const struct amdgpu_mes_funcs mes_v10_1_funcs = {
 	.add_hw_queue = mes_v10_1_add_hw_queue,
 	.remove_hw_queue = mes_v10_1_remove_hw_queue,
@@ -1112,6 +1166,8 @@ static int mes_v10_1_hw_init(void *handle)
 	if (r)
 		goto failure;
 
+	mes_v10_1_init_aggregated_doorbell(&adev->mes);
+
 	r = mes_v10_1_query_sched_status(&adev->mes);
 	if (r) {
 		DRM_ERROR("MES is busy\n");
-- 
2.35.1

