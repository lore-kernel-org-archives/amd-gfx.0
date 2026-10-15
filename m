Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B517DCCA466
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 18:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E0D411243A;
	Thu, 15 Oct 2026 18:57:30 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 853C9112437
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 18:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAlokPBpk94aF5dVmVArnygqSEaFEYszgn6W7dk2wR2z9yhmOm7qf8oFQJ3qA/hrztDEJYpt7/5UPYyWO2whVIMg8auRNKh85J/OAI30gl6fzi1oFcestbsHNgecBd2M9GvQT2mYogZH8+PCFxauNqXpAS08T9Nn0rhqsDOXkkE8h67t6FYvElKOS/Z17MtYpAU/S+ZMmI15g3BR+sQHIgMzMuFS2Ir07djZ52C3f1eLgfdck80Qsc7jJ/5qwD80wWgrKXA+9/KgVDcSiGVu74gyTrMURJdO7rptAcqNerV9tW0aTmtb+hmr/fS/B7wKDLbJauwWuCBH2iU3C+hvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9YUxS1Qu5icBSHM/Hn5iukvCphOiQj5C3O0RM9s8ss=;
 b=h2Y+smhlCTWPrTAfs69enDJGZRvvX0SbEbvjS0LN4Cvi7vFY0f9MzClKY7mW7rBFUjbvR1RfRbyu9WMMvZae4+mfxRpEb6XEsFrRADPkARA4X7lYBYgiLYOa82KeqT1jqNQtz6xHMCJkQawilsvd7+AyY765Em1in34dzpVGL0DQzu5IQa+RIf/ZrHBzFvb+w5pLGMQj/vh9ozFq5SrGz/mVaQzg12axqxL9RHKXzqPpMJFpxKY2QJGzMKKuilCC0HZgdZWPkIsBMSGtAVPZO/sO2nG1qcay9wuaWHZ94effb73CJRDEPyI0lKTa0DDUUqlHl0gKtrGPOeoj/hW1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9YUxS1Qu5icBSHM/Hn5iukvCphOiQj5C3O0RM9s8ss=;
 b=RqJP2ggqhSsa/KbtnPMpCailP5uwXRviFm6lp1YiRpNPNODSc6wTKo4nUTNftbRUpowdeA8xWfSiSpq/fZH5Zk9VpJJualMqSg2GMDqv+uZS4Ss8zBmZyHEzwrIEv28PW45BW80iEWQHvcAjArnfD8vG1WZyzyXReIneVlclVAo=
Received: from PH7P221CA0063.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::11)
 by CY1PR12MB9557.namprd12.prod.outlook.com (2603:10b6:930:fe::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 18:57:18 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::1a) by PH7P221CA0063.outlook.office365.com
 (2603:10b6:510:328::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 15 Oct 2026 18:57:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 18:57:17 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 13:57:10 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add gfx 12.1 SDMA MQD definition
Date: Thu, 15 Oct 2026 14:56:53 -0400
Message-ID: <20261015185654.499608-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|CY1PR12MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c026f0a-b56d-4589-3ded-08df2aee2279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: BxNQNaf6XIjYRU6/8NKtb38Wly/Ks7ExdOUW0jp3CNpibx+gC8HPwnxq3ApZD4fFheLBEOyt9AN1sGADCQiL2eC3043G9HE+HxPCW74roPI1DTqMVdTRmVpUFoio1ZFsLlFDy/a+5qWLGMq9+XVMgsdK9Cx2ob040bqwuy+jHzLNS0WufBhbsGMsJ433arYPSKC7RTtkoF8F+Qq2h7maO75vRDrPVfl8W1L52zV77LgKFlMQeOqspB8qeAxcJwNGL0GdXdjATDXFBQXKz9KVtcN+g2O/U6hTrJwNT3uopz+S49GHswe2ZFV8xWDrRcGclFxJrnlpifjgFYFSMs/+PtGGrcHOV5GLe/v6fdDePAv1qKoOt3X7OeZ3facwQaAIPR7iai7RPNHcmoXhaQlPBRjh9Vr8I7sZL372zS312rKIpTpb1UYg5X1vMxwr+okOZOpj0ZSmehuRYciypM5esptzb47jzHmJGiG9q1OcsvH2noFi4X+35rmp8PutwO+aX6TV8Vo1sXkMo9Wjx2GSgK/PgSlm/cPcIlzzT8pZjX9VZlGF44GGMfqOLPxMzbKdg0qM1oKezEpbVmAvlh8Mp/aUmqFO+BSkroBek6fSUcQ20BTtgGjW1aymK/nkofAGcfMM6hFI1kYPCUNEPS8gsW/EoTMfGIfcmnw94pJF5PU0sCfwDnhB+s11tN1JXaLXST5Uc9cpLmVuP1KEuHD/Dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 19TcpsOaniBNnfzKkvAZqi6JtkIp138EXiu6ihsv41txLhJzBji2sbBukPVhi/VCMp7KsTlgBDL/JlN59HXh7dL0KKOxwTOHBMrxv+fJWlKLthg2dli6arpeXtrOMoYYyGBtD19XV16xzaNPbVBoY+YymVPbhOB7AQm7sAt3hnypI2Tpb+eqRcZ1juds7wHGa0Jzz4IBWfpn0DWcMKb8qM8SWyR9cE0VaStHwW6iwFMo4AOkJj7PAdMhqcl+5su47HReXzxcZrXN7quCAesH5gDZ0d6357gQbmJbz71V8Z7ouchU+eQZnJxcemAHtCYXz0X/Kr/YIfdWOyVIyqB0EaRFgcbnbPrjEKYONebdFdkWnZ3XYqFBHeLZ+Z6R9iov/6gOhjxn8bJEteoCJn3yUUBlIQx3BR+0Auv1ZLiRzIT4IUaUvAYiyB6NLRMkMqIf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 18:57:17.7563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c026f0a-b56d-4589-3ded-08df2aee2279
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9557
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

Add a dedicated SDMA MQD definition for GFX 12.1 and switch the
GFX 12.1 paths (sdma_v7_1 and kfd_mqd_manager_v12_1) to it.
No functional change.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        |  34 ++---
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |  38 ++---
 drivers/gpu/drm/amd/include/v12_structs.h     | 133 ++++++++++++++++++
 3 files changed, 169 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 966aabdc1a53..bc7de4c3861f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -857,47 +857,47 @@ static int sdma_v7_1_inst_start(struct amdgpu_device *adev,
 static int sdma_v7_1_mqd_init(struct amdgpu_device *adev, void *mqd,
 			      struct amdgpu_mqd_prop *prop)
 {
-	struct v12_sdma_mqd *m = mqd;
+	struct v12_1_sdma_mqd *m = mqd;
 	uint64_t wb_gpu_addr;
 
-	m->sdmax_rlcx_rb_cntl =
+	m->sdmax_queuen_rb_cntl =
 		order_base_2(prop->queue_size / 4) << SDMA0_SDMA_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
 		1 << SDMA0_SDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
 		4 << SDMA0_SDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
 		1 << SDMA0_SDMA_QUEUE0_RB_CNTL__MCU_WPTR_POLL_ENABLE__SHIFT;
 
-	m->sdmax_rlcx_rb_base = lower_32_bits(prop->hqd_base_gpu_addr >> 8);
-	m->sdmax_rlcx_rb_base_hi = upper_32_bits(prop->hqd_base_gpu_addr >> 8);
+	m->sdmax_queuen_rb_base = lower_32_bits(prop->hqd_base_gpu_addr >> 8);
+	m->sdmax_queuen_rb_base_hi = upper_32_bits(prop->hqd_base_gpu_addr >> 8);
 
 	wb_gpu_addr = prop->wptr_gpu_addr;
-	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits(wb_gpu_addr);
-	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr);
+	m->sdmax_queuen_rb_wptr_poll_addr_lo = lower_32_bits(wb_gpu_addr);
+	m->sdmax_queuen_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr);
 
 	wb_gpu_addr = prop->rptr_gpu_addr;
-	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
-	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
+	m->sdmax_queuen_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
+	m->sdmax_queuen_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
 
-	m->sdmax_rlcx_ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, 0,
+	m->sdmax_queuen_ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, 0,
 							regSDMA0_SDMA_QUEUE0_IB_CNTL));
 
-	m->sdmax_rlcx_doorbell_offset =
+	m->sdmax_queuen_doorbell_offset =
 		prop->doorbell_index << SDMA0_SDMA_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
 
-	m->sdmax_rlcx_doorbell = REG_SET_FIELD(0, SDMA0_SDMA_QUEUE0_DOORBELL, ENABLE, 1);
+	m->sdmax_queuen_doorbell = REG_SET_FIELD(0, SDMA0_SDMA_QUEUE0_DOORBELL, ENABLE, 1);
 
-	m->sdmax_rlcx_doorbell_log = 0;
-	m->sdmax_rlcx_rb_aql_cntl = 0x4000;	//regSDMA0_SDMA_QUEUE0_RB_AQL_CNTL_DEFAULT;
-	m->sdmax_rlcx_dummy_reg = 0xf;	//regSDMA0_SDMA_QUEUE0_DUMMY_REG_DEFAULT;
+	m->sdmax_queuen_doorbell_log = 0;
+	m->sdmax_queuen_rb_aql_cntl = 0x4000;	//regSDMA0_SDMA_QUEUE0_RB_AQL_CNTL_DEFAULT;
+	m->sdmax_queuen_dummy_reg = 0xf;	//regSDMA0_SDMA_QUEUE0_DUMMY_REG_DEFAULT;
 
-	m->sdmax_rlcx_csa_addr_lo = lower_32_bits(prop->csa_addr);
-	m->sdmax_rlcx_csa_addr_hi = upper_32_bits(prop->csa_addr);
+	m->sdmax_queuen_csa_addr_lo = lower_32_bits(prop->csa_addr);
+	m->sdmax_queuen_csa_addr_hi = upper_32_bits(prop->csa_addr);
 
 	return 0;
 }
 
 static void sdma_v7_1_set_mqd_funcs(struct amdgpu_device *adev)
 {
-	adev->mqds[AMDGPU_HW_IP_DMA].mqd_size = sizeof(struct v12_sdma_mqd);
+	adev->mqds[AMDGPU_HW_IP_DMA].mqd_size = sizeof(struct v12_1_sdma_mqd);
 	adev->mqds[AMDGPU_HW_IP_DMA].init_mqd = sdma_v7_1_mqd_init;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index d508ac5a18f8..2e795adfda96 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -42,9 +42,9 @@ static inline struct v12_1_compute_mqd *get_mqd(void *mqd)
 	return (struct v12_1_compute_mqd *)mqd;
 }
 
-static inline struct v12_sdma_mqd *get_sdma_mqd(void *mqd)
+static inline struct v12_1_sdma_mqd *get_sdma_mqd(void *mqd)
 {
-	return (struct v12_sdma_mqd *)mqd;
+	return (struct v12_1_sdma_mqd *)mqd;
 }
 
 static void mqd_symmetrically_map_cu_mask_v12_1(struct mqd_manager *mm,
@@ -408,9 +408,9 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 		struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 		struct queue_properties *q)
 {
-	struct v12_sdma_mqd *m;
+	struct v12_1_sdma_mqd *m;
 
-	m = (struct v12_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+	m = (struct v12_1_sdma_mqd *) mqd_mem_obj->cpu_ptr;
 
 	memset(m, 0, PAGE_SIZE);
 
@@ -427,39 +427,39 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 		struct queue_properties *q,
 		struct mqd_update_info *minfo)
 {
-	struct v12_sdma_mqd *m;
+	struct v12_1_sdma_mqd *m;
 
 	m = get_sdma_mqd(mqd);
-	m->sdmax_rlcx_rb_cntl = (ffs(q->queue_size / sizeof(unsigned int)) - 1)
+	m->sdmax_queuen_rb_cntl = (ffs(q->queue_size / sizeof(unsigned int)) - 1)
 		<< SDMA0_SDMA_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
 		q->vmid << SDMA0_SDMA_QUEUE0_RB_CNTL__RB_VMID__SHIFT |
 		1 << SDMA0_SDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
 		6 << SDMA0_SDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
 		1 << SDMA0_SDMA_QUEUE0_RB_CNTL__MCU_WPTR_POLL_ENABLE__SHIFT;
 
-	m->sdmax_rlcx_rb_base = lower_32_bits(q->queue_address >> 8);
-	m->sdmax_rlcx_rb_base_hi = upper_32_bits(q->queue_address >> 8);
-	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
-	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
-	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
-	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits((uint64_t)q->write_ptr);
-	m->sdmax_rlcx_doorbell_offset =
+	m->sdmax_queuen_rb_base = lower_32_bits(q->queue_address >> 8);
+	m->sdmax_queuen_rb_base_hi = upper_32_bits(q->queue_address >> 8);
+	m->sdmax_queuen_rb_rptr_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
+	m->sdmax_queuen_rb_rptr_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
+	m->sdmax_queuen_rb_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
+	m->sdmax_queuen_rb_wptr_poll_addr_hi = upper_32_bits((uint64_t)q->write_ptr);
+	m->sdmax_queuen_doorbell_offset =
 		q->doorbell_off << SDMA0_SDMA_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
 
-	m->sdmax_rlcx_sched_cntl = (amdgpu_sdma_phase_quantum
+	m->sdmax_queuen_sched_cntl = (amdgpu_sdma_phase_quantum
 		<< SDMA0_SDMA_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT)
 		 & SDMA0_SDMA_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK;
 
 	m->sdma_engine_id = q->sdma_engine_id;
 	m->sdma_queue_id = q->sdma_queue_id;
 
-	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
+	m->sdmax_queuen_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
 
 	/* Allow context switch so we don't cross-process starve with a massive
 	* command buffer of long-running SDMA commands
-	* sdmax_rlcx_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
+	* sdmax_queuen_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
 	*/
-	m->sdmax_rlcx_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
+	m->sdmax_queuen_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK;
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
@@ -662,7 +662,7 @@ static int debugfs_show_mqd(struct seq_file *m, void *data)
 static int debugfs_show_mqd_sdma(struct seq_file *m, void *data)
 {
 	seq_hex_dump(m, "    ", DUMP_PREFIX_OFFSET, 32, 4,
-		     data, sizeof(struct v12_sdma_mqd), false);
+		     data, sizeof(struct v12_1_sdma_mqd), false);
 	return 0;
 }
 
@@ -806,7 +806,7 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd_sdma;
 		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
 		mqd->is_occupied = kfd_is_occupied_sdma;
-		mqd->mqd_size = sizeof(struct v12_sdma_mqd);
+		mqd->mqd_size = sizeof(struct v12_1_sdma_mqd);
 		mqd->mqd_stride = kfd_mqd_stride;
 		mqd->restore_mqd = restore_mqd_sdma_v12_1;
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/include/v12_structs.h b/drivers/gpu/drm/amd/include/v12_structs.h
index 7fa0c07b51c6..425117fbe7f2 100644
--- a/drivers/gpu/drm/amd/include/v12_structs.h
+++ b/drivers/gpu/drm/amd/include/v12_structs.h
@@ -671,6 +671,139 @@ struct v12_sdma_mqd {
 	uint32_t sdma_queue_id;
 };
 
+/* GFX 12.1 SDMA MQD: diverges from v12_sdma_mqd at offset 0x2B, same total size. */
+struct v12_1_sdma_mqd {
+    uint32_t sdmax_queuen_rb_cntl; // offset: 0  (0x0)
+    uint32_t sdmax_queuen_rb_base; // offset: 1  (0x1)
+    uint32_t sdmax_queuen_rb_base_hi; // offset: 2  (0x2)
+    uint32_t sdmax_queuen_rb_rptr; // offset: 3  (0x3)
+    uint32_t sdmax_queuen_rb_rptr_hi; // offset: 4  (0x4)
+    uint32_t sdmax_queuen_rb_wptr; // offset: 5  (0x5)
+    uint32_t sdmax_queuen_rb_wptr_hi; // offset: 6  (0x6)
+    uint32_t sdmax_queuen_rb_rptr_addr_lo; // offset: 7  (0x7)
+    uint32_t sdmax_queuen_rb_rptr_addr_hi; // offset: 8  (0x8)
+    uint32_t sdmax_queuen_ib_cntl; // offset: 9  (0x9)
+    uint32_t sdmax_queuen_ib_rptr; // offset: 10  (0xA)
+    uint32_t sdmax_queuen_ib_offset; // offset: 11  (0xB)
+    uint32_t sdmax_queuen_ib_base_lo; // offset: 12  (0xC)
+    uint32_t sdmax_queuen_ib_base_hi; // offset: 13  (0xD)
+    uint32_t sdmax_queuen_ib_size; // offset: 14  (0xE)
+    uint32_t sdmax_queuen_doorbell; // offset: 15  (0xF)
+    uint32_t sdmax_queuen_doorbell_log; // offset: 16  (0x10)
+    uint32_t sdmax_queuen_doorbell_offset; // offset: 17  (0x11)
+    uint32_t sdmax_queuen_csa_addr_lo; // offset: 18  (0x12)
+    uint32_t sdmax_queuen_csa_addr_hi; // offset: 19  (0x13)
+    uint32_t sdmax_queuen_sched_cntl; // offset: 20  (0x14)
+    uint32_t sdmax_queuen_ib_sub_remain; // offset: 21  (0x15)
+    uint32_t sdmax_queuen_preempt; // offset: 22  (0x16)
+    uint32_t sdmax_queuen_dummy_reg; // offset: 23  (0x17)
+    uint32_t sdmax_queuen_rb_wptr_poll_addr_lo; // offset: 24  (0x18)
+    uint32_t sdmax_queuen_rb_wptr_poll_addr_hi; // offset: 25  (0x19)
+    uint32_t sdmax_queuen_rb_aql_cntl; // offset: 26  (0x1A)
+    uint32_t sdmax_queuen_minor_ptr_update; // offset: 27  (0x1B)
+    uint32_t sdmax_queuen_mcu_dbg0; // offset: 28  (0x1C)
+    uint32_t sdmax_queuen_mcu_dbg1; // offset: 29  (0x1D)
+    uint32_t sdmax_queuen_context_switch_status; // offset: 30  (0x1E)
+    uint32_t sdmax_queuen_midcmd_cntl; // offset: 31  (0x1F)
+    uint32_t sdmax_queuen_midcmd_data0; // offset: 32  (0x20)
+    uint32_t sdmax_queuen_midcmd_data1; // offset: 33  (0x21)
+    uint32_t sdmax_queuen_midcmd_data2; // offset: 34  (0x22)
+    uint32_t sdmax_queuen_midcmd_data3; // offset: 35  (0x23)
+    uint32_t sdmax_queuen_midcmd_data4; // offset: 36  (0x24)
+    uint32_t sdmax_queuen_midcmd_data5; // offset: 37  (0x25)
+    uint32_t sdmax_queuen_midcmd_data6; // offset: 38  (0x26)
+    uint32_t sdmax_queuen_midcmd_data7; // offset: 39  (0x27)
+    uint32_t sdmax_queuen_midcmd_data8; // offset: 40  (0x28)
+    uint32_t sdmax_queuen_midcmd_data9; // offset: 41  (0x29)
+    uint32_t sdmax_queuen_midcmd_data10; // offset: 42  (0x2A)
+    uint32_t sdmax_queuen_utilization_lo; // offset: 43  (0x2B)
+    uint32_t sdmax_queuen_utilization_hi; // offset: 44  (0x2C)
+    uint32_t sdmax_queuen_wait_unsatisfied_thd; // offset: 45  (0x2D)
+    uint32_t sdmax_queuen_mqd_base_addr_lo; // offset: 46  (0x2E)
+    uint32_t sdmax_queuen_mqd_base_addr_hi; // offset: 47  (0x2F)
+    uint32_t sdmax_queuen_mqd_control; // offset: 48  (0x30)
+    uint32_t sdmax_queuen_context_status; // offset: 49  (0x31)
+    uint32_t sdmax_queuen_dummy_reg1; // offset: 50  (0x32)
+    uint32_t sdmax_queuen_dummy_reg2; // offset: 51  (0x33)
+    uint32_t reserved_52; // offset: 52  (0x34)
+    uint32_t reserved_53; // offset: 53  (0x35)
+    uint32_t reserved_54; // offset: 54  (0x36)
+    uint32_t reserved_55; // offset: 55  (0x37)
+    uint32_t reserved_56; // offset: 56  (0x38)
+    uint32_t reserved_57; // offset: 57  (0x39)
+    uint32_t reserved_58; // offset: 58  (0x3A)
+    uint32_t reserved_59; // offset: 59  (0x3B)
+    uint32_t reserved_60; // offset: 60  (0x3C)
+    uint32_t reserved_61; // offset: 61  (0x3D)
+    uint32_t reserved_62; // offset: 62  (0x3E)
+    uint32_t reserved_63; // offset: 63  (0x3F)
+    uint32_t reserved_64; // offset: 64  (0x40)
+    uint32_t reserved_65; // offset: 65  (0x41)
+    uint32_t reserved_66; // offset: 66  (0x42)
+    uint32_t reserved_67; // offset: 67  (0x43)
+    uint32_t reserved_68; // offset: 68  (0x44)
+    uint32_t reserved_69; // offset: 69  (0x45)
+    uint32_t reserved_70; // offset: 70  (0x46)
+    uint32_t reserved_71; // offset: 71  (0x47)
+    uint32_t reserved_72; // offset: 72  (0x48)
+    uint32_t reserved_73; // offset: 73  (0x49)
+    uint32_t reserved_74; // offset: 74  (0x4A)
+    uint32_t reserved_75; // offset: 75  (0x4B)
+    uint32_t reserved_76; // offset: 76  (0x4C)
+    uint32_t reserved_77; // offset: 77  (0x4D)
+    uint32_t reserved_78; // offset: 78  (0x4E)
+    uint32_t reserved_79; // offset: 79  (0x4F)
+    uint32_t reserved_80; // offset: 80  (0x50)
+    uint32_t reserved_81; // offset: 81  (0x51)
+    uint32_t reserved_82; // offset: 82  (0x52)
+    uint32_t reserved_83; // offset: 83  (0x53)
+    uint32_t reserved_84; // offset: 84  (0x54)
+    uint32_t reserved_85; // offset: 85  (0x55)
+    uint32_t reserved_86; // offset: 86  (0x56)
+    uint32_t reserved_87; // offset: 87  (0x57)
+    uint32_t reserved_88; // offset: 88  (0x58)
+    uint32_t reserved_89; // offset: 89  (0x59)
+    uint32_t reserved_90; // offset: 90  (0x5A)
+    uint32_t reserved_91; // offset: 91  (0x5B)
+    uint32_t reserved_92; // offset: 92  (0x5C)
+    uint32_t reserved_93; // offset: 93  (0x5D)
+    uint32_t reserved_94; // offset: 94  (0x5E)
+    uint32_t reserved_95; // offset: 95  (0x5F)
+    uint32_t reserved_96; // offset: 96  (0x60)
+    uint32_t reserved_97; // offset: 97  (0x61)
+    uint32_t reserved_98; // offset: 98  (0x62)
+    uint32_t reserved_99; // offset: 99  (0x63)
+    uint32_t reserved_100; // offset: 100  (0x64)
+    uint32_t reserved_101; // offset: 101  (0x65)
+    uint32_t reserved_102; // offset: 102  (0x66)
+    uint32_t reserved_103; // offset: 103  (0x67)
+    uint32_t reserved_104; // offset: 104  (0x68)
+    uint32_t reserved_105; // offset: 105  (0x69)
+    uint32_t reserved_106; // offset: 106  (0x6A)
+    uint32_t reserved_107; // offset: 107  (0x6B)
+    uint32_t reserved_108; // offset: 108  (0x6C)
+    uint32_t reserved_109; // offset: 109  (0x6D)
+    uint32_t reserved_110; // offset: 110  (0x6E)
+    uint32_t reserved_111; // offset: 111  (0x6F)
+    uint32_t reserved_112; // offset: 112  (0x70)
+    uint32_t reserved_113; // offset: 113  (0x71)
+    uint32_t reserved_114; // offset: 114  (0x72)
+    uint32_t reserved_115; // offset: 115  (0x73)
+    uint32_t reserved_116; // offset: 116  (0x74)
+    uint32_t reserved_117; // offset: 117  (0x75)
+    uint32_t reserved_118; // offset: 118  (0x76)
+    uint32_t reserved_119; // offset: 119  (0x77)
+    uint32_t reserved_120; // offset: 120  (0x78)
+    uint32_t reserved_121; // offset: 121  (0x79)
+    uint32_t reserved_122; // offset: 122  (0x7A)
+    uint32_t reserved_123; // offset: 123  (0x7B)
+    uint32_t reserved_124; // offset: 124  (0x7C)
+    uint32_t reserved_125; // offset: 125  (0x7D)
+	/* reserved_126,127: repurposed for driver-internal use */
+	uint32_t sdma_engine_id;
+	uint32_t sdma_queue_id;
+};
+
 struct v12_compute_mqd {
     uint32_t header; // offset: 0  (0x0)
     uint32_t compute_dispatch_initiator; // offset: 1  (0x1)
-- 
2.55.0

