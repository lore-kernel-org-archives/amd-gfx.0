Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26841C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 02:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBBA410F258;
	Fri, 22 Mar 2024 02:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xBJ8Dvb3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E0110F258
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 02:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhBLAUavqM6+OSPq1auK2Bh8NzkW7wfWHLPBnTf3l4PgCq4FtqS32zJ02GonlmnL6jpx3V1bFh3BJmyidk2jxaHg00CFm1Vi5oTcNTX84VJ3rqRtfnVuMA/jiz9lRrNe0qSNzNNWXtYhZ8CWdUjVGUrg8+R10rwFMIIA+FxmAYW8gyAWUUVAuFdsDLSnH0I/n7id4Bgk7eml3+D0stLVbIHAlYeOwNj1EJY2DSu3+Eutr4G5ZKPmpLBdw62+6tscl+8dYP+PoVUnTjOtEDDax8+yXIBmKvx98Bmfrua366q5UJ1k5KzKYA+qWpAhVsseSu7EOFDM+gT+yfjc3OXcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U6nCtedQGfZ9TEl8BHFzUaJmOLnelbMKBlAh+p2+H4=;
 b=ncftLAkyTtyIllnbFhV246ryps9hrf+IsZ6QZmtmQG5bWyxoAVw2ZnQr7q2TItxbRFICWVXGh953gEP3M/yzWqEBswo0WSrRUd3gaypeVODaRkz3VC3+oFUIc9OBcugks5SSkYVn5nO4pGJSJj18AXHLnhgEDjwGL724xG79SbUqToRYvEZDuYDx0fyt83B946y/NYLCyfVCz+pmHdiCzMwGDvkx5ydZlWaZOhkGUmVAiOv8Vvo+7w/VYlT8X95gsNn6r2Herue8QsoQW8mhKIbkNJvpFQcub4aImg2o0SoJF7pVGozTHks5jmkJOXJdzwUyvh0zd1ERWCUgpJd50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U6nCtedQGfZ9TEl8BHFzUaJmOLnelbMKBlAh+p2+H4=;
 b=xBJ8Dvb3nrPMC8SibsY/O18/gUrVV/X3Kfb5yCVUtSEC6816BuDaDkIvZi6JNL6baFuO5e+cccYRyKynSmAI0COFH337f64r/BDRu7Rrk0m+2ROD4qB0wFNRVN1UruI8uF6jfrfKRgLO0a6tV1OA4ZJ4QG3m5FRRNhFVJOZNXrI=
Received: from SJ0PR05CA0068.namprd05.prod.outlook.com (2603:10b6:a03:332::13)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 02:54:07 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::18) by SJ0PR05CA0068.outlook.office365.com
 (2603:10b6:a03:332::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Fri, 22 Mar 2024 02:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 02:54:06 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 21:53:58 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lang Yu <Lang.Yu@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: enable UMSCH 4.0.6
Date: Fri, 22 Mar 2024 10:53:14 +0800
Message-ID: <20240322025314.3104595-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240322025314.3104595-1-Lang.Yu@amd.com>
References: <20240322025314.3104595-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b582d0-1e5b-4915-a93c-08dc4a1b575f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIsLInGWroZsG6aJvcDzzc56KKmKSDsfCPtuTr2g5AC80WxVBY7xHhTGGUeIVkAVBuk0pzxDcbF3J5LaTs1xJymGI4Ni7E8kPQSqTo4Le9Cmz6uiXdONvh8OTUojdWLYd4mwLngbnrSftZuB46j9gqN+eNU/JA3ih8TafUjqwD3s/M4Pjdg0/fLcb4WPMfbZHKUFaUCpIF/Ffnxuo1SF+I2eVK7ppbCBIu22V0xJQ2S9CO0Pb6np54Ga73Z5LFSnDGrNjHBzDBH6jif09xOneLuDmwTxOc6L8SO2ELsOa66bPNyBtbsw+59+63o0g4hjqHrg38oHOQwtMV8+D+g7PGg9QNhNKFFn5rL0DBuWPEYG4GjKZwqnkpniYC2tmDyfxcPt85e6TiO6SAE0e/PFb/AhHVymflt1a853N6Wft4F1+qNMEgq8sA7xSzY2JD3PR31OwJGpAuEyg17y8eplBYDpuuIF5eJ6slVz5XiuypYgkjmFhVMxPZfw3Zg0CM7J89dEo1BNbWpiqNF7Iu69a4JbkgZAQdC5DsqM97U8qL5gmDdjuPqyPED7W6NVyxzrklWDz/rBpf0hrabEJBRoeLjnPygyVcJRnoMrj8QgD3XoHOfU2k5gtrw5hPv4mXeXbFEpZ1bj9YTipAMNlvonKgyu01p1MNtdeqAL82FDZQrLOFs22FYEDxTUxqlxs8W9URrISs8HHqV0qHEe/E7lQa3TqdcnRwUZuftwjX5nKV2Nt1mmG8oUo4CMjmishghT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 02:54:06.8977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b582d0-1e5b-4915-a93c-08dc4a1b575f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645
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

Share same codes with 4.0.5 and enable collaborate mode for VPE.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c    |  7 +++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3c407164837b..07c5fca06178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2247,6 +2247,7 @@ static int amdgpu_discovery_set_umsch_mm_ip_blocks(struct amdgpu_device *adev)
 {
 	switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
 	case IP_VERSION(4, 0, 5):
+	case IP_VERSION(4, 0, 6):
 		if (amdgpu_umsch_mm & 0x1) {
 			amdgpu_device_ip_block_add(adev, &umsch_mm_v4_0_ip_block);
 			adev->enable_umsch_mm = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 99210a3b1044..95f80b9131a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -189,10 +189,13 @@ static void setup_vpe_queue(struct amdgpu_device *adev,
 	mqd->rptr_val = 0;
 	mqd->unmapped = 1;
 
+	if (adev->vpe.collaborate_mode)
+		memcpy(++mqd, test->mqd_data_cpu_addr, sizeof(struct MQD_INFO));
+
 	qinfo->mqd_addr = test->mqd_data_gpu_addr;
 	qinfo->csa_addr = test->ctx_data_gpu_addr +
 		offsetof(struct umsch_mm_test_ctx_data, vpe_ctx_csa);
-	qinfo->doorbell_offset_0 = (adev->doorbell_index.vpe_ring + 1) << 1;
+	qinfo->doorbell_offset_0 = 0;
 	qinfo->doorbell_offset_1 = 0;
 }
 
@@ -287,7 +290,10 @@ static int submit_vpe_queue(struct amdgpu_device *adev, struct umsch_mm_test *te
 	ring[5] = 0;
 
 	mqd->wptr_val = (6 << 2);
-	// WDOORBELL32(adev->umsch_mm.agdb_index[CONTEXT_PRIORITY_LEVEL_NORMAL], mqd->wptr_val);
+	if (adev->vpe.collaborate_mode)
+		(++mqd)->wptr_val = (6 << 2);
+
+	WDOORBELL32(adev->umsch_mm.agdb_index[CONTEXT_PRIORITY_LEVEL_NORMAL], mqd->wptr_val);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (*fence == test_pattern)
@@ -571,6 +577,7 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch)
 
 	switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
 	case IP_VERSION(4, 0, 5):
+	case IP_VERSION(4, 0, 6):
 		fw_name = "amdgpu/umsch_mm_4_0_0.bin";
 		break;
 	default:
@@ -750,6 +757,7 @@ static int umsch_mm_early_init(void *handle)
 
 	switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
 	case IP_VERSION(4, 0, 5):
+	case IP_VERSION(4, 0, 6):
 		umsch_mm_v4_0_set_funcs(&adev->umsch_mm);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index 8e7b763cfdb7..84368cf1e175 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -60,7 +60,7 @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
 
 	umsch->cmd_buf_curr_ptr = umsch->cmd_buf_ptr;
 
-	if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 5)) {
+	if (amdgpu_ip_version(adev, VCN_HWIP, 0) >= IP_VERSION(4, 0, 5)) {
 		WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
 			1 << UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
 		SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
@@ -248,7 +248,7 @@ static int umsch_mm_v4_0_ring_stop(struct amdgpu_umsch_mm *umsch)
 	data = REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 0);
 	WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);
 
-	if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 5)) {
+	if (amdgpu_ip_version(adev, VCN_HWIP, 0) >= IP_VERSION(4, 0, 5)) {
 		WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
 			2 << UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
 		SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
@@ -271,6 +271,8 @@ static int umsch_mm_v4_0_set_hw_resources(struct amdgpu_umsch_mm *umsch)
 
 	set_hw_resources.vmid_mask_mm_vcn = umsch->vmid_mask_mm_vcn;
 	set_hw_resources.vmid_mask_mm_vpe = umsch->vmid_mask_mm_vpe;
+	set_hw_resources.collaboration_mask_vpe =
+		adev->vpe.collaborate_mode ? 0x3 : 0x0;
 	set_hw_resources.engine_mask = umsch->engine_mask;
 
 	set_hw_resources.vcn0_hqd_mask[0] = umsch->vcn0_hqd_mask;
@@ -346,6 +348,7 @@ static int umsch_mm_v4_0_add_queue(struct amdgpu_umsch_mm *umsch,
 	add_queue.h_queue = input_ptr->h_queue;
 	add_queue.vm_context_cntl = input_ptr->vm_context_cntl;
 	add_queue.is_context_suspended = input_ptr->is_context_suspended;
+	add_queue.collaboration_mode = adev->vpe.collaborate_mode ? 1 : 0;
 
 	add_queue.api_status.api_completion_fence_addr = umsch->ring.fence_drv.gpu_addr;
 	add_queue.api_status.api_completion_fence_value = ++umsch->ring.fence_drv.sync_seq;
-- 
2.25.1

