Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A26F106FD69
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 02:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEEA410EACC;
	Fri, 13 Mar 2026 02:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ML7gPgxq";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E4010EACC
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 02:28:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvrBiWVnNJBrRmjAOwVvxsPilLCLXvDADYF1TCUjVtZsr97qcKQ9hUG1ss5b5mgkWnriNV2dx9dB1wJXYCe5uYiit6trwmhPDf7/TXoAwBNmQx7WPiHdslfTjTJRktoaMfiwjrKQevRUDvUUEFNmxyWnYpA3A2AKpPcTbIrIBHvaVWp+Yyq/mYFQmkd+quEs/Kz4/vK/VlHsXM0yeYkmWQ3uhrnhK3oik1uSZl+BS/ex+UqHZZznbWp4UQ/LN38djugzgg79L1cEy09HuJKDxS3fOeh3XBmhnFlvXa69WG4Bu+fKBXBvWUaFUS6D6wy3rtFqt6zEEJq7MibkuDOeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHeB8+vYcmb1iwJrMxxce5KZZ85KkLxvfRZZS+DFGVg=;
 b=T+GCXm7A0ZJM+6lqL2zrKALn5ihUWfz1YWwTpTMBnOehThmdBX+jo8/PwTAzQRfTcHkiiKdIsQGdNQu77knBFxL2KLBNKU8P0n4vPI0Up7ikhFHO4UckmmLN8w9bYzL/qNuTqRinxzVG1efc4GbjSLtujLmZrTVWSyaRXu/A3+kg9HD3MIM+WtmV7N1l1pyhJj5GB6zPsAvqIHeeXAxOpU8GzXjwDqgvsPcXi8Pjtp7ELXXnTBlw4oZ9LAPqChEgyXoTE3EcVe2EKKEzPCLJJHMJCKlKCgdC5Ki+tAcdkHmqU5Yebsg1SdMMkdHCcBpWMfzYZy8Nqb7ptPJGLZxHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHeB8+vYcmb1iwJrMxxce5KZZ85KkLxvfRZZS+DFGVg=;
 b=ML7gPgxq/7J+Pd4gHuzVk4cuGU5pN2irYqPfumAARl66vjIrhZZca0qo1l5NSukWzVUGUZZDLZmW46pfjemiDbeVT72CCjF2VD72W+AM1THkSyb5u6lv4rKVCngE3MaetFIUXjI9hqocL4pmbtQnBED4bYZBz+ValM35mgzjnw0=
Received: from BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 02:28:49 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::ac) by BY5PR03CA0020.outlook.office365.com
 (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Fri,
 13 Mar 2026 02:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 02:28:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 21:28:47 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 12 Mar 2026 21:28:41 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix build errors due to declarations after
 labels
Date: Fri, 13 Mar 2026 10:27:54 +0800
Message-ID: <20260313022840.1549516-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d012db-147e-4cea-65ef-08de80a84215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Biy2SQnaw6+yyvELmBQbuTecEd0igxYG6VHcZ5YbkrxRCWKCHVMUB5khb9iMl/31spPdEcqWyguNJTyrGBlY0nLgztCOTFFDJ2gsjwrj0cMJI0h4Oau8RHyrrnRr33jNFG3tZBppTo+3qVkO0PcGLmFbbilPI5VrtuUJHylz/LSdYYEtmhxsxCsFTmL6wc2Sxt1ldmn8H1sWCqsgve8XZtLGEd7utYCdGpcyrrQe04s4h88ifAIPO8E2DZu1/vRQ3jpo7U9gEkIn2vjAUwReFhqX9R0flSF5zATRQmOcGWEY3QmJ5OqiaVeeiYhVmS88pjvHROYEc7rUy7RY/VLdPVlLeP9K5nUavblH9PCglO+DRu5VAOUzOdgyR2XbL0HcF6FBLp9lCtVZMhRfgy1Xhyg/ZIrptsDmYT6BHxELgHT60moEtJ2UHkkUKfrO9Sjl+CyWvSQE+1y4R07Begte9LX0E/uNWhrHN6izGPz4kg7+pbB//8PSrnFE6lc8Tf0QDUCHcUKh4ODQqOj23GhNw+O8buYLbeMVvFs7SV3YNSrqjOE0hDiTRcRIMQFTsaQ0jDLmILYXyE//dM3fbC1Zvxtzgm0nJ+Ani+ao7cThTMN76FbKDaEZoG02mBrtl3s+wl1ByKxb3MnC+jSZvV/ZUapHEEpybeexFIxsshl1FFO8HR/j6lSCl7ZHksV8jmgz9uYySD09Lbsu59RNXX4amfXbff9NWCh3pWPkhwJMbMRe9JOQXTnxI72VfT8Eg4cgI5Y0693epSE0d0nTRXW3JQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uIdH+dBE+yPDDUfbxDIoCpSQr5PtH88YslIwP1MqJH5B1gGQ2oIErJRLt9FnRk3hdHkwwMnh37yFWcsWcKDWso3qNvvO4froVzGT//3mFyUR6RfarOl9On+oqER4lhtdZZ3LRo0lAmVnonTXPs9dpKUGk62Et1A3wcq/AJEM2U9PpbHCAxExTs6RMkKT/W18tWMbNeVi1m4hFokkb3FKJwIU6rDoqG/kttKfrFqpU/ac3gV92LD+RIg1ZydNZgXlGg4Ea3FNNCLljLJypXJmXXmwrehSTkKeKwVsMg5rPy0JuQcUKseJS6ilWdU8z7GJkyQ6/4y8CgCHBZmwMeCj67Z3ia1R/lwVaHzyXn9rCGJAL2CwR9fZjy2CzY5mA4pICHXzUGmd776Lo/4zaCXxpLSBAznKIu4JvyTBVsEHxalJ1qQTp/pdGbwBmJpkKKmH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:28:48.3363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d012db-147e-4cea-65ef-08de80a84215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198
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

In C90 (which the kernel uses with -std=gnu89), declarations must
appear at the beginning of a block and cannot follow a label. The
switch cases in amdgpu_discovery.c and gmc_v12_1.c contained variable
declarations immediately after case labels, causing the compiler to
error:

drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:560:3: error: a label can
only be part of a statement and a declaration is not a statement
drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c:533:3: error: a label can only be
part of a statement and a declaration is not a statement

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 ++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  5 +++--
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f77a03ea4d90..f3d0640d800e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -548,6 +548,11 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 	struct table_info *info;
 	bool check_table = true;
 	char *table_name;
+	struct ip_discovery_header *ihdr;
+	struct gpu_info_header *ghdr;
+	struct harvest_info_header *hhdr;
+	struct vcn_info_header *vhdr;
+	struct mall_info_header *mhdr;
 
 	r = amdgpu_discovery_get_table_info(adev, &info, table_id);
 	if (r)
@@ -557,7 +562,7 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 
 	switch (table_id) {
 	case IP_DISCOVERY:
-		struct ip_discovery_header *ihdr =
+		ihdr =
 			(struct ip_discovery_header *)(discovery_bin + offset);
 		act_val = le32_to_cpu(ihdr->signature);
 		exp_val = DISCOVERY_TABLE_SIGNATURE;
@@ -565,7 +570,7 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 		table_name = "data table";
 		break;
 	case GC:
-		struct gpu_info_header *ghdr =
+		ghdr =
 			(struct gpu_info_header *)(discovery_bin + offset);
 		act_val = le32_to_cpu(ghdr->table_id);
 		exp_val = GC_TABLE_ID;
@@ -573,7 +578,7 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 		table_name = "gc table";
 		break;
 	case HARVEST_INFO:
-		struct harvest_info_header *hhdr =
+		hhdr =
 			(struct harvest_info_header *)(discovery_bin + offset);
 		act_val = le32_to_cpu(hhdr->signature);
 		exp_val = HARVEST_TABLE_SIGNATURE;
@@ -581,7 +586,7 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 		table_name = "harvest table";
 		break;
 	case VCN_INFO:
-		struct vcn_info_header *vhdr =
+		vhdr =
 			(struct vcn_info_header *)(discovery_bin + offset);
 		act_val = le32_to_cpu(vhdr->table_id);
 		exp_val = VCN_INFO_TABLE_ID;
@@ -589,7 +594,7 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 		table_name = "vcn table";
 		break;
 	case MALL_INFO:
-		struct mall_info_header *mhdr =
+		mhdr =
 			(struct mall_info_header *)(discovery_bin + offset);
 		act_val = le32_to_cpu(mhdr->table_id);
 		exp_val = MALL_INFO_TABLE_ID;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 38c366b9a88b..7ea7b9c30bca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -527,10 +527,11 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 	unsigned int mtype, mtype_local, mtype_remote;
 	bool snoop = false;
 	bool is_local = false;
+	bool is_aid_a1;
 
 	switch (gc_ip_version) {
 	case IP_VERSION(12, 1, 0):
-		bool is_aid_a1 = (adev->rev_id & 0x10);
+		is_aid_a1 = (adev->rev_id & 0x10);
 
 		mtype_local = is_aid_a1 ? MTYPE_RW : MTYPE_NC;
 		mtype_remote = is_aid_a1 ? MTYPE_NC : MTYPE_UC;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8167fe642341..9b4143328371 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1220,6 +1220,7 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
 	bool ext_coherent = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENT;
 	unsigned int mtype_local, mtype_remote;
+	bool is_aid_a1, is_local;
 
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
 		bo_node = prange->svm_bo->node;
@@ -1307,8 +1308,8 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 		mapping_flags |= AMDGPU_VM_MTYPE_NC;
 		break;
 	case IP_VERSION(12, 1, 0):
-		bool is_aid_a1 = (node->adev->rev_id & 0x10);
-		bool is_local = (domain == SVM_RANGE_VRAM_DOMAIN) &&
+		is_aid_a1 = (node->adev->rev_id & 0x10);
+		is_local = (domain == SVM_RANGE_VRAM_DOMAIN) &&
 				(bo_node->adev == node->adev);
 
 		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
-- 
2.49.0

