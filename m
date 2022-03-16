Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7A3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 09:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F46010E555;
	Wed, 16 Mar 2022 09:26:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B5410E555
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 09:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDzxNtuJAR4Q0Q4IBifnMDCYhafjyLKGggaZZcrrE0+kPq5sD6sClXlQyh2mfEt5FZazltLBfpEtU8bZAKk7ia826QGA1hUyASGBm7BTpoaHJT/+UZ6x0OaWvOvQwvm+luNYTj0ZWDuPlG7IOA68OmtT0RvBoT1qqnMZyVDoKmWaunhULpxB5jSXirwt6saYFSVYNDFBuFhGxp04Qdrs76TwBP4hjp7zN0m5zcJyM/lNG7UecIV2W6GTnliiwJezjBj4reVfkC68DOC/nDLtXe632XbTSQc9Ri1d3QjXlUpAl871Hc6pMwChHMai0MRij7ZUFbQrHI852/b16JGQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z08qCQmSopCeeCVhBKLPTvWorWxuP3MIlT+GjaJsSmM=;
 b=E0Xpnc73qryf6z/xBlTH8W46oyY4ZRvEtlo8U0OsQlJ2p/c5YCPfwAbG8rjW0ZwvvErn8XlKUwlK0JCgTB/keMhlFYVlmlYXWe8dOJm5TtZh7i2eskzcqJE6sKmh3UbfVunsm1jynIy3EGq9+PHQqz9MIQ6uJRJuPHhJ8zLtg43ASBPjxl4pGKrKKxsDkk1V50g6Xo026UUrwkjDk6ls4IE+BI7BdMV1+OjWgwzN3UXcdgrp0v11mQ00J6M8o8mpzVwthNybND1Cg30exBvyKsugtRPnV9xrrQG1o3Et36pnTCAhT55mK3TrRj/Kn7v3koN9GczRlvnOueeiJxKqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z08qCQmSopCeeCVhBKLPTvWorWxuP3MIlT+GjaJsSmM=;
 b=vQ4Lm6iGc16nLZ3FZQ2jJxX6JfmepM2RortB0lwkpx2nknnsuJC0m+2rVbYnFN+ua8C0alHoSDOlSy7aGYCPowY24j6d1gES3kAVB5JPT8TqCPeye/ivbL1MAClAqxu3NTDCq3aXm8EYWzGyZlqqPJT/tbvNcW2lqbl2q1lly4s=
Received: from DM3PR12CA0098.namprd12.prod.outlook.com (2603:10b6:0:55::18) by
 BYAPR12MB3624.namprd12.prod.outlook.com (2603:10b6:a03:aa::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.26; Wed, 16 Mar 2022 09:26:44 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::7e) by DM3PR12CA0098.outlook.office365.com
 (2603:10b6:0:55::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Wed, 16 Mar 2022 09:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 09:26:43 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 16 Mar
 2022 04:26:40 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Felix.Kuehling@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add UTCL2 RAS poison query for Aldebaran (v2)
Date: Wed, 16 Mar 2022 17:26:26 +0800
Message-ID: <20220316092627.17359-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316092627.17359-1-tao.zhou1@amd.com>
References: <20220316092627.17359-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b11b93d3-0ef7-4fb3-0410-08da072f15e6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3624:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB362495202E88AD3AA444E036B0119@BYAPR12MB3624.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6qSRwOq5a1oV2NvKrxmf1j+OTtbOpYFSXlZkS+KDuc2/31Q0RLpsWBt+lauAEsXaX2DHgjlPclyvtNBnb2HeVAqwC/ERRHfesA7rb1ORVGjiMN21ukbo/8cJoo4+FM/4XcClAeXWArLBSMbWXAlrNfEahS5XQxzNduK71L7E9ze7FYcg9M97DbJ6aofk9HC2psxBScl/QdpXndjxYVWPxAjpdWHZIEMxdkho+753Qs6d1kgtHWZokkK+hyV6i2uRKIpVtlxCTI+CrSDt+yeb9w6cPa9t8DsbAScuDpqSrMwbVnoE5YYEkQOyy6IZXVsLPuIcDzONgiPOBABPacuS1v8RvMDKbJGwGysIKPkucbEcytbVSomlyd4DkShP91sHuzZlsWwkEewiRZsZKr/QEyePKW/xpnHEkdDxPDLBHpCjG0wtJA71V6NYz7Iy6ENo4PQv73lZw1C6CYTibhDeVlx1ihxG5zOLf5zQpcuWh/M1bIXQOqwuapPZdL2o6oBBxeiQBVDVjgCxMTYj0J4kglkym20fCfaV+kPEopiW7jfCrGNTlTKWLMhFZlfqHEis4WQQwyDkLV2QquWE0SNMYaEZT2akYtPuKYwHGNeY6vNwP7orvP/WHkK1fg2hB/L0qYS30pb+bH+9QEe3GZ2iqLtwz+BFRoJ+s4QtbMUVCrgk9Aaw4kKFH34CqOX9UiQrehd+sAiLOplaRMkfLqRIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(8676002)(81166007)(356005)(40460700003)(186003)(83380400001)(26005)(86362001)(16526019)(1076003)(7696005)(2616005)(336012)(47076005)(426003)(6666004)(70206006)(70586007)(36756003)(508600001)(82310400004)(316002)(6636002)(110136005)(8936002)(2906002)(5660300002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:26:43.7506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b11b93d3-0ef7-4fb3-0410-08da072f15e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3624
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add help functions to query and reset RAS UTCL2 poison status.

v2: implement it on amdgpu side and kfd only calls it.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c    | 14 ++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 6ca1db3c243f..c18c4be1e4ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -724,3 +724,11 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, bo
 	else if (reset)
 		amdgpu_amdkfd_gpu_reset(adev);
 }
+
+bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev)
+{
+	if (adev->gfx.ras->query_utcl2_poison_status)
+		return adev->gfx.ras->query_utcl2_poison_status(adev);
+	else
+		return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4cb14c2fe53f..0838926a8ef0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -301,6 +301,7 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
 bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
+bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev);
 
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index dcb3c7871c73..5ed9b8a4c571 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -202,6 +202,7 @@ struct amdgpu_cu_info {
 struct amdgpu_gfx_ras {
 	struct amdgpu_ras_block_object  ras_block;
 	void (*enable_watchdog_timer)(struct amdgpu_device *adev);
+	bool (*query_utcl2_poison_status)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_gfx_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 7653ebd0e67b..e0890e00eedf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1930,6 +1930,19 @@ static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev)
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
+static bool gfx_v9_4_2_query_uctl2_poison_status(struct amdgpu_device *adev)
+{
+	uint32_t status = 0;
+	struct amdgpu_vmhub *hub;
+
+	hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	status = RREG32(hub->vm_l2_pro_fault_status);
+	/* reset page fault status */
+	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+	return REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
+}
+
 struct amdgpu_ras_block_hw_ops  gfx_v9_4_2_ras_ops = {
 		.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
 		.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
@@ -1943,4 +1956,5 @@ struct amdgpu_gfx_ras gfx_v9_4_2_ras = {
 		.hw_ops = &gfx_v9_4_2_ras_ops,
 	},
 	.enable_watchdog_timer = &gfx_v9_4_2_enable_watchdog_timer,
+	.query_utcl2_poison_status = gfx_v9_4_2_query_uctl2_poison_status,
 };
-- 
2.35.1

