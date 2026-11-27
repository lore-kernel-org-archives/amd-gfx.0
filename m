Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230A606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1f9pAvno
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16FA411284E;
	Fri, 27 Nov 2026 08:29:32 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0312011282C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 08:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbpKHoqy+uGndknMOsUdzSTqM/st9dLaCd1qOjsWAhcAtFMLdyeei+tmuUAZOJm9T24eHc6WIx2/ss68dl4QuBP6ZmvOr8QjOUA6ns+wnwzKC5vNpId3msnpe+dft9n0/8XqS9LP+LGsxhyqcWkpfpXek9OeFTyFjqazaIG7d2vtP0RAKTFD6JhBcjZWe8jZOULJwq2wx9F4hpN8Ay6+A6LL9RakSJa86G+gPg3YLoDfQjj3B/h8y6k8wdcsZXU6XZ5M8qVsv3OB/aWfW7ypE9u7WDm126pGw9seb6CkuAANhHcL90yrMe4GTrbO6igoXs8wNe5X18J9o0W7wbYpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBvsizuvKWU6AwEIbWz+U4kCJ0FYqCPSAK0ooUee3ss=;
 b=OsOGnvJ631dzLFjWiqjpqdq+tU2BRV4Sv9uM7PTW1Gm1w0My7EH+pGVPWc/jCSVs+qOPTPdJJ1XcoPYiWSlg2MA5Aa+X8+VZeBEv5NA1/Z7l5hTkGZg0P9gcZg1T/jQzycaidPHWVGGJt0FsBPinUbDJwZe8Y1Z7HCQAYU7hJYqQ5f90oJ/gBYaIRMvfj/I4bBs8BkUXcb+xxmnFsXgQVVBNEJqC+ejDo6ZTsLHOAFlaDYk/dIjdlptOan8F0FNCQx6gerv7stFZFVyazZ3JATKKSymoLSV6JQElLWHoVF/gHSYEhRSyoPTpHskCCa9+xU989wvfgp3LlZP8tWdP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBvsizuvKWU6AwEIbWz+U4kCJ0FYqCPSAK0ooUee3ss=;
 b=1f9pAvnoD9/sF3zro8LJ11u/YIM2BldZm4dUgSLW4wOzGV2RCEoxLWgJ1rZ+v0s99Is9LFbgNSh2u5gFBFpsTV4WUKq0EzudZP3kN6ovyXbAs5Z/vHLn3j49Hy7zIRkyZwS8aQq2D2klW8yNWrgUqAJ8YaluDe+fQi/hFJSlSfI=
Received: from MW4PR04CA0259.namprd04.prod.outlook.com (2603:10b6:303:88::24)
 by CY8PR12MB7539.namprd12.prod.outlook.com (2603:10b6:930:96::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 08:29:09 +0000
Received: from MWH0EPF000DD310.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::27) by MW4PR04CA0259.outlook.office365.com
 (2603:10b6:303:88::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 08:29:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000DD310.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:29:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:29:08 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:29:08 -0600
Received: from rtgbeta01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Fri, 27 Nov 2026 02:29:05 -0600
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Strahinja Stamenkovic
 <strahinja.stamenkovic@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
CC: Priya Hosur <Priya.Hosur@amd.com>, Pratik Vishwakarma
 <Pratik.Vishwakarma@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: bound the APU GTT pool size by KFD's system
 memory limit
Date: Fri, 27 Nov 2026 13:58:54 +0530
Message-ID: <20261127082854.112025-3-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127082854.112025-1-Priya.Hosur@amd.com>
References: <20261127082854.112025-1-Priya.Hosur@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD310:EE_|CY8PR12MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 803d6a3d-2bc4-4fca-1886-08df4c6081fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|11063799006|6133799003|261009223027099003|22082099003|18002099003|10067099003|56012099006|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261102123227099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: RKdhip9fgNxEcJq1J3ocSkNHn48ouZCQ50EJ7dCrfDnCdWYGLXQX3cMp2q7hHg4owedb4igu272jkuM0dq5Jyy64HY7NGjG/OtahEtXAFSeWh/goWJWz4v8HzJ8FeXRQ/SVfo8SpUVOSxSR/hotryqEWtfs9vo1J5wwUdrwtArXaTBmek45i9xDZm36advy97QqEK7V1xYpO19hYplaEwxDhiNXOBvpZx8jyDTT0aiJwTo3fv5LnYIDK5KlGJ0835Ljg8LT1pOnOv4D0KKoax/ywCbVvtl534J/Mb9xweojaDDC/tAjkBn2X1JMe9cWTPdgFFJvWGWJIO9U+EJW1c19fgPQSknKWbE/rYzRBll35i+vTXYn0hO6XGEMaieJY4EHB7QLOYXlqEA2Po1pvZUkQH+p0nairpg8ic0e1Wbboj2KbMq5kiVdLWBmTOwRxS4mYcHXQkUBDNwzPdwod/idg9euKNgV3fSkHSmpKAIYLxT2o0jEHf6pghDuy1QHv+rb6ptU/C/FtHCfWJbbhYquNVRNU24DtWZH24QFdd1x2cfD9syU7SefeYCdyx5vIs3LmPNTMd5EHypju8j4EHi1T78cuKAqzjBKWnpJiaCl9dEO48jsioH4DTCDj3SGwFbiKymNCWC6ljTLseGanJbkKYvDjgOGPa20zvW4/IgLOH96CxbAvZJ8q7j35jLN9BG4qRYqVYyg3uwaTSHYDSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(6133799003)(261009223027099003)(22082099003)(18002099003)(10067099003)(56012099006)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261102123227099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w//zIGkMnF1bHWsqONFaAjO61lgksH6Mfgxb8B046GuKba/dbTN1pzC75MyznhTLWWsi+5ksPKmD4azgHcDqMmBfQaih618V5/UbArw5N+/f9X67dgzNjYZ+PKpZB7CitXUxk8aYd3pEQY6eh93Q6D9CyJwp0A2dYYnZmyg3b8QXgzd+xcMndie1scV4hu+kAPMfCoyew+aI3TJnUcR4BXbbi7ZjnUR4TrpNQmmkUNp7QVEm9QLdrOEOEog/z08+wndxvtbi5/ibDrTgbZkfXTvgJfpqmBsb9u9yeGgRbRMtGltUwJ1GXiJQIhJ3Y1RwJqUgQ0VeUEQq10cTlIJBekPkXjP2U8+OiBSNM4eQuH34ja4YGFSJ8kPuZHxf71HRCL/85w0c3s63gEi3xJ/S0F6y+uimeTULd2jnupmsjUd11uqSXZo3rdQvbO2pzqFX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:29:09.0311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 803d6a3d-2bc4-4fca-1886-08df4c6081fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000DD310.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7539
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With apu_prefer_gtt, KFD reports ttm_tt_pages_limit() as the local
memory size, which HIP exposes as the device's total memory. TTM may
legitimately be configured above physical memory, since it can swap
buffers out, but KFD allocations are additionally bounded by
kfd_mem_limit.max_system_mem_limit, which is derived from physical
memory. KFD therefore advertises a pool it will never allocate from: on
a Ryzen AI MAX+ 395 with 62 GiB RAM and ttm.pages_limit set to 80 GiB,
HIP reports 80 GiB total while KFD caps allocations at 59.69 GiB, so
applications sizing against a fraction of total fail.

Report the smaller of the TTM limit and KFD's system memory limit, via a
new amdgpu_amdkfd_system_mem_limit() accessor. When no_system_mem_limit
is set to allow overcommit, the TTM limit is reported unchanged. GTT and
TTM sizing are not affected.

Co-developed-by: Strahinja Stamenkovic <strahinja.stamenkovic@amd.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  9 +++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0dab267eb382..17c12edca437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -521,6 +521,17 @@ uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
 	return 0;
 }
 
+/*
+ * Size of the GTT-backed pool reported on APUs. TTM may be configured above
+ * physical RAM, but KFD will not allocate beyond its system memory limit, so
+ * don't report more than that.
+ */
+static u64 amdgpu_amdkfd_gtt_pool_size(void)
+{
+	return min((u64)ttm_tt_pages_limit() << PAGE_SHIFT,
+		   amdgpu_amdkfd_system_mem_limit());
+}
+
 void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 				      struct kfd_local_mem_info *mem_info,
 				      struct amdgpu_xcp *xcp)
@@ -535,7 +546,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 			mem_info->local_mem_size_private =
 					KFD_XCP_MEMORY_SIZE(adev, xcp->id);
 	} else if (adev->apu_prefer_gtt) {
-		mem_info->local_mem_size_public = (ttm_tt_pages_limit() << PAGE_SHIFT);
+		mem_info->local_mem_size_public = amdgpu_amdkfd_gtt_pool_size();
 		mem_info->local_mem_size_private = 0;
 	} else {
 		mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
@@ -863,7 +874,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 
 		return ALIGN_DOWN(tmp, PAGE_SIZE);
 	} else if (adev->apu_prefer_gtt) {
-		return (ttm_tt_pages_limit() << PAGE_SHIFT);
+		return amdgpu_amdkfd_gtt_pool_size();
 	} else {
 		return adev->gmc.real_vram_size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 74dc307e5140..f504f133f2a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -400,6 +400,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
 void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo, int xcp_id);
 void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int xcp_id);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
+u64 amdgpu_amdkfd_system_mem_limit(void);
 #else
 static inline
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
@@ -426,6 +427,11 @@ static inline
 void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int xcp_id)
 {
 }
+
+static inline u64 amdgpu_amdkfd_system_mem_limit(void)
+{
+	return U64_MAX;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0a04516e137e..5b530ddf06b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -130,6 +130,15 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 		(kfd_mem_limit.max_ttm_mem_limit >> 20));
 }
 
+/* Returns U64_MAX if the system memory limit is disabled or not yet set up. */
+u64 amdgpu_amdkfd_system_mem_limit(void)
+{
+	if (no_system_mem_limit || !kfd_mem_limit.max_system_mem_limit)
+		return U64_MAX;
+
+	return kfd_mem_limit.max_system_mem_limit;
+}
+
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
 {
 	kfd_mem_limit.system_mem_used += size;
-- 
2.43.0

