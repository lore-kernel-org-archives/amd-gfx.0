Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91850F417F3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294C410E514;
	Mon,  9 Mar 2026 14:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v3jFk+FT";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E63DA10E514
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Glz7Rgx+0CxFGW/V6dd+2lYcy3t23OrQhkCRTyU+YRmuDfR6iTBBoy+Qn6W9zCLQMtHozGHKumj+sbQ6evrv8v5USjoJhmtnRK8Eu46nbLIJJay9wUjh6ilvqgla46yiF6zqmZ78h0pHCVcMuoU8VN+J2y+k+buel2LJQUZImq0VVRjAHCmr3ttB4o2yFK0gjokqJ/Ul6qPs/t2nw5fSjndHPF7yyes1qVVPHfROePRaqX/TuW9Z1+RwOF5vKCF5dM7EQMqS9VsopuJnAQDkDEQEhwCas0tNA0AzL3u6t0WjBgxp6guTKOxxIRsn7xjK+sarbR3pd8c1GVFQiCrh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjoIQM1dP8A/JsZDK4hVBbOJXdyqyMkGTNsyEph3S1I=;
 b=a7sFhywWD0QZ7GIjJ9Kk2bpXVqhZwYFxwp8uSsfQQA9HUSzOdwEEVfKHQlsE/uiGhZHLI975ImhzRYvV44JZpg3TgH16lyiEh9zjnh4AfknpQP5bTt9U9rxZ9OLXUTW5NVctZBRl1ZsutMxm6wGREhMzmChh2y7HfvqEbj3hmRfz7u9O50e2+tVDVw2r2llugOIl2RS5L+v1+WGtL4lO1hMvLzmnJ6oVWw84YfpS465ao7EGDwkxRGTkF7TqH5s3U3qNDYehLdnTXnmpAcLtMElntmAyqSdq12CtuBoZep8D6AnyZazMm/JywLsxMnu1ccpwllMdjf+t9O9Lq6onpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjoIQM1dP8A/JsZDK4hVBbOJXdyqyMkGTNsyEph3S1I=;
 b=v3jFk+FTK9gwpdmM/0tPsV7tFDa1Hr9hWiybRL3YhUxGk5asKd97N1g9ZPUgHe0pf4nRYMdjg0YRtS/S4XNTkL3Q+Oh5VJxNkpHo5lLB7LQDuO7gseJ3g3i5iwp5V9w/bcaaxlEBew81RrQGQ50tsADpixt4N/Cl30YHkgucd7w=
Received: from SJ0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:a03:39f::8)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:56:41 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::b0) by SJ0PR03CA0213.outlook.office365.com
 (2603:10b6:a03:39f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:56:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:41 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Support forcing MTYPE_RW
Date: Mon, 9 Mar 2026 10:56:12 -0400
Message-ID: <20260309145629.2844495-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3fb414-8c2f-477f-69fc-08de7dec12e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: RjUFOGcau66H0RyMj7F4+J2kWchzGn2ko2R6SW3q0YvbZCq6cs02fpDz4vD4V37q/5OVnKuMAXokJPzWqL2y7RYbxP20KcdX60tKhQioyxQiWEmUb1UAQqRVu8m5CVbPI809r/zFq7yRBb3A41kGxXzdSTlltA0+bNM7hCs8r/gh5vffXY/AOeW1tg9Cy231ZLzjUBICMj5hDKL0zu7eOxbMUQfMK6ZC2QivJU5f0p6DU/f853gJlAUQXHTaoAJ/is8oeLBGNlcYQ1vhHavpbeey+cjKmSDLZFlUiOby6tyT7Ku5YrygdVGZB0oVoZKj2E7/7f5zvMNivVZOWuQAdCEulPxz1hccCXyUr6+YqiCeQHxOVeCYsf+e5VKNtY/oki2TuGQTOnUp54PW37YmrEMsPIiuzoTjQZmmrKuNYDbx/NRzcK6JVYiXT+vPDlcmBo7wdTlxL9bFwbFZY7RfW5ibnmu15JflDGmxZUGW90jl+3z9UgdPeJ6D3c02s8ELWp8IfuQl9aoGEnutS4hSWAkYHUS4rNgWu+UUkkPA/ujv2Y5weh1gdAjFT+mrJMDAd4LL4NaXu2zmhwIHW/oTzhUR0GPF6PC4yMtz/r7x82vi3ZqF8XDheLuZh2R9Kbpg5bx3rxxhBNnY0RohXwQW760mSJuflS0hNnCFP+cqrbqcU+1XpQtt+mTQKjGwg84EUlRWMOl2g7dll2TJKvUhNugQFSbpd/lmVup8T0V2SyKZnlywLn1o6TI/g/JBGjPsxvrWM2tIM3ZVCInzlPsN2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +xy9c5df0Ky+JCvRSsp3Zohtte0dMT77ZX7oikbEaGvBGpS1viho8Xcr+A0sGWzDZtyZasWjQndncKkVDr3uOLTO9mAS2pOSGn9bus+nlZTFUAxjUMVlqTu/g6EVLXNENSxD0W1/XVEPZTFzgQq1I08Acn2hWMYH7ziXNV6eWFbLdy5lZVAphbrTOiNGpwosoSrf6Sfq5dsmAUEawM/0IZnNabU4nPokkWWYlYnXQose/yoIlFZjNjp1Vdh+vRKbfOY4OwjHKAzMRcHXv0HkpBH0/laMt8rPsWGpl6a9Qgxi+W2Ju7pijEXK1DJZpdwHjDtcqPDhc89TAWccz2Kruvvo5M7QyEmq+VJiSWpJeynf0wYHn45GEob8oWwmbIdxyHtuO8hJFMYX1yJKSJVZn9hsSHY6T5bp2J2tF6JSOVHImXEUG/mAAfXX9QfHS23I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:56:41.4898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3fb414-8c2f-477f-69fc-08de7dec12e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Set default value of module parameter amdgpu_mtype_local to -1. This
allows to force MTYPE_RW on ASICs where MTYPE_RW is not default.

v2: Fix SDMA get_vm_pte_pde MTYPE

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  |  9 ++++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c  | 21 +++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  6 +++---
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 03814a23eb540..9c50f054f1c10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -839,8 +839,8 @@ module_param_named_unsafe(no_queue_eviction_on_vm_fault, amdgpu_no_queue_evictio
 /**
  * DOC: mtype_local (int)
  */
-int amdgpu_mtype_local;
-MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (0 = MTYPE_RW (default), 1 = MTYPE_NC, 2 = MTYPE_CC)");
+int amdgpu_mtype_local = -1;
+MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (default: ASIC dependent, 0 = MTYPE_RW, 1 = MTYPE_NC, 2 = MTYPE_CC)");
 module_param_named_unsafe(mtype_local, amdgpu_mtype_local, int, 0444);
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index bc86e6c8e063a..5e3102d072c4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -534,13 +534,16 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 
 		mtype_local = is_aid_a1 ? MTYPE_RW : MTYPE_NC;
 		mtype_remote = is_aid_a1 ? MTYPE_NC : MTYPE_UC;
-		if (amdgpu_mtype_local == 1) {
+		if (amdgpu_mtype_local == 0) {
+			DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
+			mtype_local = MTYPE_RW;
+		} else if (amdgpu_mtype_local == 1) {
 			DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
 			mtype_local = MTYPE_NC;
 		} else if (amdgpu_mtype_local == 2) {
-			DRM_INFO_ONCE("MTYPE_CC not supported, using MTYPE_RW instead for local memory\n");
+			DRM_INFO_ONCE("MTYPE_CC not supported, using %s for local memory\n", is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
 		} else {
-			DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
+			DRM_INFO_ONCE("Using %s for local memory\n", is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
 		}
 
 		is_local = (is_vram && adev == bo_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 03bf1f86098f1..f20e0fc3fc743 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1129,12 +1129,21 @@ static void sdma_v7_1_vm_set_pte_pde(struct amdgpu_ib *ib,
 	/* for physically contiguous pages (vram) */
 	u32 header = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_PTEPDE);
 
-	if (amdgpu_mtype_local)
-		header |= SDMA_PKT_PTEPDE_COPY_HEADER_MTYPE(0x3);
-	else
-		header |= (SDMA_PKT_PTEPDE_COPY_HEADER_MTYPE(0x2) |
-			   SDMA_PKT_PTEPDE_COPY_HEADER_SNOOP(0x1) |
-			   SDMA_PKT_PTEPDE_COPY_HEADER_SCOPE(0x3));
+	/* TODO:
+	 * When VM_L2_CNTL5.WALKER_FETCH_PDE_MTYPE_ENABLE is enabled, change below MTYPE
+	 * to RW for AID A1 and UC for AID A0. NC needs additional GCR flush and need not
+	 * be supported. Also, honour amdgpu_mtype_local override. RW would additionally
+	 * require setting SCOPE bits in the header.
+	 *
+	 * header |= (SDMA_PKT_PTEPDE_COPY_HEADER_MTYPE(0x2:RW) |
+	 *           SDMA_PKT_PTEPDE_COPY_HEADER_SNOOP(0x1) |
+	 *           SDMA_PKT_PTEPDE_COPY_HEADER_SCOPE(0x3:SYS_SCOPE));
+	 */
+
+	/* VM_L2_CNTL5.WALKER_FETCH_PDE_MTYPE_ENABLE is 0 which defaults to UC. So,
+	 * use MTYPE_UC (0x3). For ref. MTYPE_RW=0x2 MTYPE_NC=0x0
+	 */
+	header |= SDMA_PKT_PTEPDE_COPY_HEADER_MTYPE(0x3) | SDMA_PKT_PTEPDE_COPY_HEADER_SNOOP(0x1);
 
 	ib->ptr[ib->length_dw++] = header;
 	ib->ptr[ib->length_dw++] = lower_32_bits(pe); /* dst addr */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 35c16c77ba65b..8167fe642341c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1311,9 +1311,9 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 		bool is_local = (domain == SVM_RANGE_VRAM_DOMAIN) &&
 				(bo_node->adev == node->adev);
 
-		mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
-							is_aid_a1 ?
-							AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
+		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
+				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
+				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
 		mtype_remote = is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
 		snoop = true;
 
-- 
2.53.0

