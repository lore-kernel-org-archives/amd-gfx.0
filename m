Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AC2C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 16:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5312E10E453;
	Thu, 25 May 2023 16:52:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C98510E453
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 16:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRBvDKBImWHFt84hvugeVIlrHzcjTQgTONiFlYZILQo7DinSv0mRwmkSSkzhfJdnR8Pfc/2vIgmoLlmPyidjWXPkYgcuObIDCNJWq5VdbWouRmq0U7t/eTrMcMCI1ewbO6OIadAwEr+/fC6MfIedGH/tUPzvuHBvaF1Nf6oTHoXgWdauGmjQ5+taDe51PyvIriX3mmwiXducEcXvfMJnKRrIbjZw3Jg2qFNcPT/+om84qLwPdPqYs69JcxarDgr48hggcGSLgy5nJnH5IzPiHQ5WWhF3+XZ0vG86FLM1ZwHCDkSy2CiWSv3cuFySIHFvwKfa8gMCJarFBgQrzTZCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69e151XkdI9SRcvUvHkS5oG+737uI1xW6rHJq4otgvs=;
 b=FOPATDFEdnN7xeBDIQzDKa3vXAuRqB+MkMI/y5e7tA+G4KSdFIkroSj/gnbzxn0azkp+uRZMX0v8IzOSro5D6ld3f5fjo1YDj5zzm5qXzrv1gnC8lIg0xBPR/+qbDwYjy7WbUAuJAwbuOgt03FCjWCdFJoSfvvTvs6jE1s8GknMR9cGak3odisDvzjZQu2hkvb0FmQ7AWS96rAegV57dcqT+Jq9nwxc+1Qu6Lu/zfF44IC0R+WDxHdwp8e5m/dhHcK8f2F5GI/KLgm4PIaUIPQwK63cvCf389eJMHC9WIWod4cRsSVZGEGK2SzkwZMKe9HZSIfQ6txhYnC2Y30Q8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69e151XkdI9SRcvUvHkS5oG+737uI1xW6rHJq4otgvs=;
 b=5QYRvJETGpLYggiGbvjini6BQHpRIqUO7S6Qtk6Xlv3lq5LlSZ930Hqd0LGS/1rRsVETVWxOyZyqA7laQ7XwXs9Q5yWWu4F8k7mzu/tRZPnei+gm4PLYVn7SpCIxXqVSsdnD6E+wlTsnCUwmb/QabRHXhKuoPyzGMKJ7N6jcnD8=
Received: from BN9PR03CA0283.namprd03.prod.outlook.com (2603:10b6:408:f5::18)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 16:52:41 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::5b) by BN9PR03CA0283.outlook.office365.com
 (2603:10b6:408:f5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17 via Frontend
 Transport; Thu, 25 May 2023 16:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.16 via Frontend Transport; Thu, 25 May 2023 16:52:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 11:52:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: cache gpuvm fault information for gmc7+
Date: Thu, 25 May 2023 12:52:18 -0400
Message-ID: <20230525165219.544671-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525165219.544671-1-alexander.deucher@amd.com>
References: <20230525165219.544671-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|BN9PR12MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: b75e3cc4-cf4c-477e-74f5-08db5d407485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gT2Q5AsZRRtLIR3oJ6rrpLTAWpf6n5LqulUz4a5DTwQBF4wWU+Oe6ZnzEtK9PG3o8WCGAPkxV4LJxRaothbwjc/TKjMoEAqs8/NlHF8kBfErdobvLxk50iAT1UjHRGAF4qM8wRAuiOsq7GX8fFuJAI3zs63FjJuGqVlqqq+x4jrZspWxLcgDNV9ZjuVX/8uhSRZZNlqp4FqLwYJ5ikTpO9P6M64Yb0NHTB1LmQlkdDZ3fiTJA7TShd7sItpkbF734twhVCrVcreNTI5Px2kEbsEPLH5QGR4LSBr6ugfSgJvs7v9saiDVQR3HVfC6TGnVLr3ss7jYs4pcOTpxlIzaddnS/FyEW0cTLNzQDStuSdwQCS2dRzeTkd9l5EN5gfThyz8qwieaWbV0vsqaTl4zFXFal5eMsC+tDEUYEt+xA4aaVNdaNAq05Q51D7zaHsuwmU8ttn0/rthmVZQSkFZ2rjVI21UKWLKePsupN+PPR5wTymxqe+74QhDa/0/zPhdiFhzf8O4fq0vOr5pYYvg8VAsQ4hrAjwfnhkQS6XjhKS+/QZmRl73ZABm92eLzNEaBVCdpxYczwBBsG5SUQBCe/L4Dh+JzDtlUJAYpxTJ4wPjI1a6AW3bQu5V4lboN3AqBcW+ZhE0lrVZCd1KL6qGataM1pcfxQ49wALZWdIG8F5WjZV0R3teEQz94vAkvmvNTeiR42j6Cmm/fgJ0t0hGQdoLsESmV9gDd6Z6eGlQA1URVHcAkd2BQ9gYk9I+ii29jxfEEsDySf2SrRNHC2KAGyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(6916009)(70206006)(70586007)(478600001)(54906003)(316002)(4326008)(86362001)(36756003)(47076005)(83380400001)(2616005)(26005)(426003)(36860700001)(16526019)(1076003)(186003)(336012)(5660300002)(41300700001)(8676002)(8936002)(2906002)(40480700001)(7696005)(6666004)(82310400005)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 16:52:41.6938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75e3cc4-cf4c-477e-74f5-08db5d407485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
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
Cc: Alex Deucher <alexander.deucher@amd.com>, samuel.pitoiset@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cache the current fault info in the vm struct.  This can be queried
by userspace later to help debug UMDs.

Cc: samuel.pitoiset@gmail.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 11 +++++++----
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 01bd45651382..5f88db5432b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -155,6 +155,9 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
+					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
 
 	if (!printk_ratelimit())
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 4bf807d825c0..087f1ec3cf54 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -115,6 +115,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
+					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
 
 	if (printk_ratelimit()) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 6f53049619cd..1386e2b2e773 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1272,6 +1272,9 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 	if (!addr && !status)
 		return 0;
 
+	amdgpu_vm_update_fault_cache(adev, entry->pasid,
+				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status, AMDGPU_GFXHUB(0));
+
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
 		gmc_v7_0_set_fault_enable_default(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 48475077ca92..6d46390ee9e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1447,6 +1447,9 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 	if (!addr && !status)
 		return 0;
 
+	amdgpu_vm_update_fault_cache(adev, entry->pasid,
+				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status, AMDGPU_GFXHUB(0));
+
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1e8b2aaa48c1..28a66aa377f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -555,6 +555,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub;
 	const char *mmhub_cid;
 	const char *hub_name;
+	unsigned int vmhub;
 	u64 addr;
 	uint32_t cam_index = 0;
 	int ret, xcc_id = 0;
@@ -567,10 +568,10 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 
 	if (entry->client_id == SOC15_IH_CLIENTID_VMC) {
 		hub_name = "mmhub0";
-		hub = &adev->vmhub[AMDGPU_MMHUB0(node_id / 4)];
+		vmhub = AMDGPU_MMHUB0(node_id / 4);
 	} else if (entry->client_id == SOC15_IH_CLIENTID_VMC1) {
 		hub_name = "mmhub1";
-		hub = &adev->vmhub[AMDGPU_MMHUB1(0)];
+		vmhub = AMDGPU_MMHUB1(0);
 	} else {
 		hub_name = "gfxhub0";
 		if (adev->gfx.funcs->ih_node_to_logical_xcc) {
@@ -579,8 +580,9 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			if (xcc_id < 0)
 				xcc_id = 0;
 		}
-		hub = &adev->vmhub[xcc_id];
+		vmhub = xcc_id;
 	}
+	hub = &adev->vmhub[vmhub];
 
 	if (retry_fault) {
 		if (adev->irq.retry_cam_enabled) {
@@ -626,7 +628,6 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
@@ -663,6 +664,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, RW);
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
+	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
+
 	dev_err(adev->dev,
 		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-- 
2.40.1

