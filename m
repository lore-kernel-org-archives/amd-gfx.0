Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9638CE8E9B
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42DF910E9E2;
	Fri, 25 Oct 2024 02:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nBnJL7Lm";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0152E10E9D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4JyjMT9qxjrPN02Xt2Tsj4CmfChyEPASSwztp5brS6ji2bJ9MloOosr6dP7DXO3AmLNTF172Urgpf8ohd3QepJ2xd/4ugFeikjVaS3I5KIu9oYLnLyFIw+52eCRn5o7cq/RCseTneJRtNGjiNENmtUUHZrRdvF26xVl43B1wD16n6OYpBJ5F7KRmDC/NW/6t/HUIu351GMep44j0eonldtb5+o09POOYygV/0GhtjpxtlWgTlA/plW8CUvVnaYd7rSLMHdD7hfBRumejqb+XfKZLfV4RxXjxd7Xq6ubTT+l0ybMAwzk5+S6VLaliyUNqLZErnB3oKNBjOYLRndPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c39E8h8idoBEE9w1nI1DtGw4EnlY6WdXVALevvejvzk=;
 b=PesdImYirkvC/BuN+GrRfk6pRjfHL/dxG1AjHtnNyZ48BjVdWw5zOnKc52wxHFBm96uFO/HwuFvHTYuNtY4KJqwy0lpWI1/lHzLDSEnyW0tkOuCnJpYfthzE3aOlFzmFFnTtXe64KLcst058t7bR2rndCmoAxxqD6eHWu7kfwJ3x7PseWU8c+jHRpxSpe1MdgjRnObkZUoYJi8XEYvIx5mfBObZ9OYDlDDWeSxhCruBYrbdU3TuNZu8Tev/KY5UyvGpOyLYsFmjalgkAfq7V+H5PKiHchMx89SBxgLmqA5wPYnd+rIRHtykwVhYOtEc0qfpsg/S5ivFPlrYl36g0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c39E8h8idoBEE9w1nI1DtGw4EnlY6WdXVALevvejvzk=;
 b=nBnJL7LmBfE6WpiRTVHYscH+5LSexnBjGe44we/iQUJowMxab5yTKTTRoofacjBSMvRZe3U80tFwXocZKhOPURWQ/+gePGT6OT4UFcAPPWtF8Oe+MVCaZ7l/XvTVj37MLyNTAWZYTPYF9YGvk7kC96hEknwzBXfpxg9AhRLUNqk=
Received: from DM6PR18CA0011.namprd18.prod.outlook.com (2603:10b6:5:15b::24)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 02:36:21 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::c1) by DM6PR18CA0011.outlook.office365.com
 (2603:10b6:5:15b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:15 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 21/29] drm/amdgpu: sw_init for each vcn instance
Date: Thu, 24 Oct 2024 22:35:37 -0400
Message-ID: <20241025023545.465886-22-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 445ec102-2d02-435e-f5c1-08dcf49dcf96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?33LMJjwzAq2tDPUlDBXvk3AtP7AY0Q+UdBwKbn99dtrmZ1iqOrP16CfZ8Aqp?=
 =?us-ascii?Q?McNVuKbpXEDBYDo2xpfGV+rLL5HO7WNzXJDSbNrwSOpwXvpAhLmvYxYDt9T1?=
 =?us-ascii?Q?6tph0tCMYjCNCLcFh4UjIisGO++IW82iLspKnG42NZuyNZNQ3iXMSxRIW1Uh?=
 =?us-ascii?Q?BqswVt8YzrC3ND9SYXB4wamOt53nZkNLX0SBxDQ2axq3Lip9Nlh1Dt+uT9AX?=
 =?us-ascii?Q?Qi7YSyZY0RPYFqUKLctEbjTT9H7jcUlwjqbCzl4X9vV5flPQVBMSibABgFgJ?=
 =?us-ascii?Q?ahpKQv4OQNMcMRqW8CGcLgp0WrhO9DnEX0r6KdPSdAQ1E7FcwBnsEPP/2556?=
 =?us-ascii?Q?OMCnFN+VHBHNKtHXSGaoC1FAc64KxruxvCCPaL/fJdxadj+cIZY/8AJkwyPp?=
 =?us-ascii?Q?Q9HTGfgbOqefBSnU+ZI9VxbgWKq84VC7qr8NafE/sIG1F8GBjD3QPv8M1mrK?=
 =?us-ascii?Q?Fw4Vk4DZRlYsNNavS40ctmpC7v7Ej8k0A/VzltD88Dyy8imUysn1oUn2HW1b?=
 =?us-ascii?Q?ycR0WLsKBPTSiht0shc5oQJSQG+WPhvzUM5h5cQkxWP6PsZOTS5GN1S/p+er?=
 =?us-ascii?Q?VOolqJBxctuLx3ncetZkzXq5WrCZhjEaHLuuuvmQqNUwzFnj1qljVU6klRia?=
 =?us-ascii?Q?zi2+PrLDG/rLkIB3obpostljbgqT7/9nclioJv2oOwBzVyzFKxjRCaXIKoi1?=
 =?us-ascii?Q?JFxzJ/7eCZ6Y1Vf/TVmcTCOAoeZVffXgMEqV/7a/EpCrXXlzzvsVXF5DHmdk?=
 =?us-ascii?Q?TpDlHCX0/Rv43YIjHrccrkIUZwllWnLDjqYf79VAUAQvptVw3PwIFMubqQA4?=
 =?us-ascii?Q?3zSwo/42RxUjONIu/tvzxYI7bLUJA26MgbU+FkgB8MStOWIktZOlKPP4CFbv?=
 =?us-ascii?Q?W3AMb2j/3fXJkvJmnjLGYSuvAQ3uOfIParl9PMSZ1GHXW405blSHdWumyK+8?=
 =?us-ascii?Q?N2S4LzWtmePQOrhjXd80yBHuzWTaAn4knWlMj95cAWQx3KAALl1REFIJH75j?=
 =?us-ascii?Q?mJ97W0Gc2DIDfEflODY9JPJ+Wa/ujFHhnQoOOoz5FG4WTSny13swVRYKiBH0?=
 =?us-ascii?Q?9AQWjPPPuxvbhNqvHD6swJ7lxABHFNiuHaLN0lOf17zeQa4qfLaWoeK/b35j?=
 =?us-ascii?Q?Ef6BKlkeIvfwJqx8eWWnGkGEcEezkw+sDD76WTeledlcKZyEtR3QcjmC6woT?=
 =?us-ascii?Q?0grppbGceDRTVAc7yInHdnWY/T52VjALLHQsWyTdDFhoa0y+1APEzaMQp35O?=
 =?us-ascii?Q?S1TLkLWxXgOpOkneJlkcP21Pn838HPzqfW0eIP+oXxx14ZQpFoipWFHWpz1L?=
 =?us-ascii?Q?4M+XpHOBreRLP/AasxGuZU0wZ0GDvXGLe7A3WtOpznzJug292fGb6QgpRxCJ?=
 =?us-ascii?Q?Scu4pOWkwIHm6BdDPeEQLJiK0gaSyXQNzlrNA19U1t8ENkntRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:20.7712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445ec102-2d02-435e-f5c1-08dcf49dcf96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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

Pass instance parameter to amdgpu_vcn_sw_init(), and perform
sw init ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 83 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  7 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  7 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  7 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  7 ++-
 10 files changed, 69 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 21701738030f..2c55166e27d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -111,24 +111,23 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst)
 	return r;
 }
 
-int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
+int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
 {
 	unsigned long bo_size;
 	const struct common_firmware_header *hdr;
 	unsigned char fw_check;
 	unsigned int fw_shared_size, log_offset;
-	int i, r;
+	int r;
+
+	adev->vcn.inst[inst].adev = adev;
+	adev->vcn.inst[inst].work_inst = inst;
+	INIT_DELAYED_WORK(&adev->vcn.inst[inst].idle_work, amdgpu_vcn_idle_work_handler);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		adev->vcn.inst[i].adev = adev;
-		adev->vcn.inst[i].work_inst = i;
-		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
-	}
 	mutex_init(&adev->vcn.vcn_pg_lock);
 	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
 	atomic_set(&adev->vcn.total_submission_cnt, 0);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
-		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
+
+	atomic_set(&adev->vcn.inst[inst].dpg_enc_submission_cnt, 0);
 
 	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
@@ -206,45 +205,43 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	if (amdgpu_vcnfw_log)
 		bo_size += AMDGPU_VCNFW_LOG_SIZE;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_VRAM |
-					    AMDGPU_GEM_DOMAIN_GTT,
-					    &adev->vcn.inst[i].vcpu_bo,
-					    &adev->vcn.inst[i].gpu_addr,
-					    &adev->vcn.inst[i].cpu_addr);
-		if (r) {
-			dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
-			return r;
-		}
+	r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
+					AMDGPU_GEM_DOMAIN_VRAM |
+					AMDGPU_GEM_DOMAIN_GTT,
+					&adev->vcn.inst[inst].vcpu_bo,
+					&adev->vcn.inst[inst].gpu_addr,
+					&adev->vcn.inst[inst].cpu_addr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
+		return r;
+	}
 
-		adev->vcn.inst[i].fw_shared.cpu_addr = adev->vcn.inst[i].cpu_addr +
-				bo_size - fw_shared_size;
-		adev->vcn.inst[i].fw_shared.gpu_addr = adev->vcn.inst[i].gpu_addr +
-				bo_size - fw_shared_size;
+	adev->vcn.inst[inst].fw_shared.cpu_addr = adev->vcn.inst[inst].cpu_addr +
+			bo_size - fw_shared_size;
+	adev->vcn.inst[inst].fw_shared.gpu_addr = adev->vcn.inst[inst].gpu_addr +
+			bo_size - fw_shared_size;
 
-		adev->vcn.inst[i].fw_shared.mem_size = fw_shared_size;
+	adev->vcn.inst[inst].fw_shared.mem_size = fw_shared_size;
 
-		if (amdgpu_vcnfw_log) {
-			adev->vcn.inst[i].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
-			adev->vcn.inst[i].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
-			adev->vcn.inst[i].fw_shared.log_offset = log_offset;
-		}
+	if (amdgpu_vcnfw_log) {
+		adev->vcn.inst[inst].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
+		adev->vcn.inst[inst].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
+		adev->vcn.inst[inst].fw_shared.log_offset = log_offset;
+	}
 
-		if (adev->vcn.indirect_sram) {
-			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
-					AMDGPU_GEM_DOMAIN_VRAM |
-					AMDGPU_GEM_DOMAIN_GTT,
-					&adev->vcn.inst[i].dpg_sram_bo,
-					&adev->vcn.inst[i].dpg_sram_gpu_addr,
-					&adev->vcn.inst[i].dpg_sram_cpu_addr);
-			if (r) {
-				dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", i, r);
-				return r;
-			}
+	if (adev->vcn.indirect_sram) {
+		r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_VRAM |
+				AMDGPU_GEM_DOMAIN_GTT,
+				&adev->vcn.inst[inst].dpg_sram_bo,
+				&adev->vcn.inst[inst].dpg_sram_gpu_addr,
+				&adev->vcn.inst[inst].dpg_sram_cpu_addr);
+		if (r) {
+			dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", inst, r);
+			return r;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 58fbb87e5ec4..4809da69bd1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -484,7 +484,7 @@ enum vcn_ring_type {
 };
 
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
+int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
 int amdgpu_vcn_resume(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 6fd509e6744d..808d69ab0904 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -126,11 +126,12 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block->adev;
 
 	/* VCN DEC TRAP */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
@@ -146,7 +147,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8f7038190a43..a86cff00d761 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -131,11 +131,12 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block->adev;
 	volatile struct amdgpu_fw_shared *fw_shared;
 
 	/* VCN DEC TRAP */
@@ -154,7 +155,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 74814370ddc9..9967ac3fc51b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -156,12 +156,12 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block->adev;
-	int inst = ip_block->instance;
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		goto sw_init;
@@ -185,7 +185,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 sw_init:
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index a7fb5dda51dd..e89088e3cd1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -160,14 +160,15 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
-	int inst = ip_block->instance, j, r;
 	int vcn_doorbell_index = 0;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block->adev;
+	int j, r;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index c0c2a071ea15..1b492197c2b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -168,14 +168,15 @@ static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
  */
 static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
-	int inst = ip_block->instance, r;
+	int inst = ip_block->instance;
+	struct amdgpu_ring *ring;
+	int r;
 
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
 	uint32_t *ptr;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 1d1ee6da7647..5b61000f3004 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -127,12 +127,13 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
-	int inst = ip_block->instance, r, vcn_inst;
+	int r, vcn_inst;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
 	uint32_t *ptr;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 81efc53e7cd3..4d944636d02b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -131,13 +131,14 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
-	int inst = ip_block->instance, r;
+	int inst = ip_block->instance;
+	struct amdgpu_ring *ring;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
 	uint32_t *ptr;
+	int r;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 7873ca91da4c..8efedf943581 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -115,13 +115,14 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
-	int inst = ip_block->instance, r;
+	int inst = ip_block->instance;
+	struct amdgpu_ring *ring;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
 	uint32_t *ptr;
+	int r;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
-- 
2.34.1

