Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F61AE77180
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 20:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC7B10E3C4;
	Tue, 10 Dec 2024 20:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uiCe59i7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE14310E3C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 20:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8VbXVEP11mZ1Cau6GetGDZtcQWuI+AJhJeBvjAl+c5xpDueOiV4W4qIws4toZzgTK9eTIBY4GHg82s1u4KiNe88DgU1gFlhRoq/kLjfSqQN5qX7xJliJHzbOOEeTwR5j71htLPqSuPXN54g1wtZ9odo3LXLDvjt4RWBCynZN5q7lBmfhvKpYKKatqAOCGKYiYEcjhNDwka+BjLZ6Q6XyKdPs55LuRzxRe0NdhU3jX8oODCR6cunnt3FKyi58xGG5eyVlplTyxalbxXnyLnfjqjuVcK+VtS60jshNnpBgC08XxrFFNPIg7m4NTfrS8VAHOESMMUXjkyrZU6uAC5meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lTBlV0Orbp6YwLYbfR7E+hLpjupAxRzYj97nlZuS20=;
 b=t5SLgdKDInSzXws8XQToZhUEU/DJURYcMmXyKMJIYLKI/LUfweWWF9FC7bEplXqTHn9nxsiX3/wNYIX2GrwQYqbxJXfK3+uuEcqIhT5Mv4B1OXOibZJEsVZHRqoLE8kZm+a91/3crBc+FP+4WYEyL3r8L5vqZiZHygBaxT/hzSiDVLbjGcCDseZMxigodfGptB3jVRMkG/zTAizK1NUpmBtVJqBtr4R/2eZCrBBlS1uTdQv1jV4fEjpdRY3zPJi1V6S7Qye4QRFvAcNx8bGLmWeXkTmKK0YPzK9ysMaxgzKRQW/5LFjHOntR1zuyk+LQfVKwhj5lZ9F05URz9kmdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lTBlV0Orbp6YwLYbfR7E+hLpjupAxRzYj97nlZuS20=;
 b=uiCe59i7bovWvqO+OEDQZKxPV49JoYsWsVGB2KQmnbuGNcp631h9VkEjyvYDrv7ztGIz7qAMRUZEPev32ou9L/QOs7pXtVSB+qIejtXjciY5xwUi1HjNNuwQPzkgPwr1lSMcD3VEePY7mSuicGkvGTM4LCBSEGZTAMz0j0X2QfI=
Received: from CY8PR12CA0063.namprd12.prod.outlook.com (2603:10b6:930:4c::26)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 20:04:07 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:4c:cafe::66) by CY8PR12CA0063.outlook.office365.com
 (2603:10b6:930:4c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.18 via Frontend Transport; Tue,
 10 Dec 2024 20:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 20:04:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 14:04:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add ip_dump support for vcn 5.0.1
Date: Tue, 10 Dec 2024 15:03:51 -0500
Message-ID: <20241210200352.3465587-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e88ae09-108a-4c72-1357-08dd1955cd72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DrXC4W85EklWAwiliCRpDLJXqtrCGcCRVY5/5WCMZ45472p0kUz9IFrXrz8O?=
 =?us-ascii?Q?Qr3ySHjFWLuluuRnp7XKf3DC1ssxugsxFlNzkQJky3wUJ6g7z8Jgc+KemG9y?=
 =?us-ascii?Q?KlEr01abrN+tO6cYLM3UtA7R/VDE+iDLb4igLYsphGIJq97dzxi1Kw1bGQeF?=
 =?us-ascii?Q?9FvQtDNhbyRe6+MyPa96hCn4rWDbzC86L1lLG+oDuTzGunY6Tkr8A9IKUuKR?=
 =?us-ascii?Q?y91sqDYd2t4i16eruvh//Agq4nn1GaR5MWdLU70a0VfmrHhYk4grmIEccZI8?=
 =?us-ascii?Q?vfNZ1h0Eakk4eMkgDgq/OYKvijsHnvm7NNb1dFrjGzvk7iG1b+uL+zmS8mA7?=
 =?us-ascii?Q?JwM71vlP1WHZ98E2zUPQT2AUxcifkNy0NQkbQqevcvtwibb9DUhXj1ofEq+C?=
 =?us-ascii?Q?cXla/41S5oVRPRa+fvLkm7FNnLIsaHompLOA1Y0rmQ9r+RjaQ1RBEt0d1V0j?=
 =?us-ascii?Q?H1AatrDR+OmwIacC/D+9761vO8Xom8fTTFCCmr5ufJuoHVaxOORR3vZEEA6V?=
 =?us-ascii?Q?RWd46+DX1/MySW+/ihRnv+ASvev9mrNALzbSS1YYZ9oyMiHC3zlfEinbajgR?=
 =?us-ascii?Q?oWBuKko3xV2rtfE53mxM47pt2BpCuos7g2lad0f+aPAeM/IVuT49tQgHYQ/F?=
 =?us-ascii?Q?O8gtKKjbqnTYcN0t//EtdD81ADqGn6Xt9Wk0e0ZyjPS9mvlxUs5XJKUxTARf?=
 =?us-ascii?Q?OlTubTOTW9KRjKX81awCqRb6Zq7uXKZqeDnX0HlYPEnS+t/tn6lGahDXAkFd?=
 =?us-ascii?Q?cz4ZOaMRgXv8d/u+55JDxHHEjEiFa2UktiXGdqX49Yl2vMe75vm/kNYVyiOK?=
 =?us-ascii?Q?93YLRyQcqNC3sL9Yp8SPVdHoOA36xtipiZ7Lzg3tLvo1AvdmfoQOFXt68ces?=
 =?us-ascii?Q?/CCsyy4Fn/4gFFdA+ope2n1zkCofo89IUiEWLmdk3QD8oDk49DzTKFOvNX+S?=
 =?us-ascii?Q?gy22cQ8tTmZFu+Titdsqj0VBGMIV3WiFpRZQ/vXxO/OK7Lw1pccil94bdUhx?=
 =?us-ascii?Q?/b997kFeyl4WXsXgDE282opjrCQVaTa+dcbqb/5V2nJKgDur0VfvLb+bSIJW?=
 =?us-ascii?Q?IVtwtlkiYttMV3dp8j9OBfWZRQVGIh/zUcFLo1DKS1Rsfbn9vPCrzmvFcuhw?=
 =?us-ascii?Q?Zs5RS7PgUp3tJPdGZXTFRRKP6zyfw2QRLJcjlgqj0JISlqlE64ImCRlJBdUC?=
 =?us-ascii?Q?dXL5wTulamC+aT1EW7rIVj+LRUNYNiag2lj0nxtijI1mktU3xeY2/KUSjMPX?=
 =?us-ascii?Q?daWD/9rgiRaHwsQaKtf/6yma1RFKMNS40Irai3i5nzOxGD8Kh43LMcNvJem9?=
 =?us-ascii?Q?2yawHFN3rYqnAb3FEdF4gppO2qUjiuQZJHSQ20kFMZRziH1fqn8EH3E0cTlj?=
 =?us-ascii?Q?D621CWF+RbIxPAT4qcJhs+jINJFAkAttmzIWYmCq1bnSgLxQMgOfKcZbmOL5?=
 =?us-ascii?Q?/yEA8MtKVcHFEM3984XOIceg1SFcbwrp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 20:04:06.4479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e88ae09-108a-4c72-1357-08dd1955cd72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
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

Shared with vcn 5.0.0.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 35 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h |  5 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c |  7 +++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h |  8 ------
 4 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 097b9ad1721fe..b6d78381ebfbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -105,6 +105,21 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 	return amdgpu_vcn_early_init(adev);
 }
 
+void vcn_v5_0_0_alloc_ip_dump(struct amdgpu_device *adev)
+{
+	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
+	uint32_t *ptr;
+
+	/* Allocate memory for VCN IP Dump buffer */
+	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
+	if (!ptr) {
+		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
+		adev->vcn.ip_dump = NULL;
+	} else {
+		adev->vcn.ip_dump = ptr;
+	}
+}
+
 /**
  * vcn_v5_0_0_sw_init - sw init for VCN block
  *
@@ -117,8 +132,6 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
-	uint32_t *ptr;
 
 	r = amdgpu_vcn_sw_init(adev);
 	if (r)
@@ -177,14 +190,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v5_0_0_pause_dpg_mode;
 
-	/* Allocate memory for VCN IP Dump buffer */
-	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
-	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
-		adev->vcn.ip_dump = NULL;
-	} else {
-		adev->vcn.ip_dump = ptr;
-	}
+	vcn_v5_0_0_alloc_ip_dump(adev);
 
 	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
 	if (r)
@@ -1357,7 +1363,8 @@ static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
+void vcn_v5_0_0_print_ip_state(struct amdgpu_ip_block *ip_block,
+			       struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
@@ -1389,7 +1396,7 @@ static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 	}
 }
 
-static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
+void vcn_v5_0_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, j;
@@ -1430,8 +1437,8 @@ static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
 	.wait_for_idle = vcn_v5_0_0_wait_for_idle,
 	.set_clockgating_state = vcn_v5_0_0_set_clockgating_state,
 	.set_powergating_state = vcn_v5_0_0_set_powergating_state,
-	.dump_ip_state = vcn_v5_0_dump_ip_state,
-	.print_ip_state = vcn_v5_0_print_ip_state,
+	.dump_ip_state = vcn_v5_0_0_dump_ip_state,
+	.print_ip_state = vcn_v5_0_0_print_ip_state,
 };
 
 const struct amdgpu_ip_block_version vcn_v5_0_0_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h
index 51bbccd4360ff..b8927652bc50c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h
@@ -32,6 +32,11 @@
 #define VCN_VID_IP_ADDRESS                         0x0
 #define VCN_AON_IP_ADDRESS                         0x30000
 
+void vcn_v5_0_0_alloc_ip_dump(struct amdgpu_device *adev);
+void vcn_v5_0_0_print_ip_state(struct amdgpu_ip_block *ip_block,
+			       struct drm_printer *p);
+void vcn_v5_0_0_dump_ip_state(struct amdgpu_ip_block *ip_block);
+
 extern const struct amdgpu_ip_block_version vcn_v5_0_0_ip_block;
 
 #endif /* __VCN_V5_0_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index daca18bfff062..a076ffb3867ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -33,6 +33,7 @@
 #include "vcn/vcn_5_0_0_offset.h"
 #include "vcn/vcn_5_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
+#include "vcn_v5_0_0.h"
 #include "vcn_v5_0_1.h"
 
 #include <drm/drm_drv.h>
@@ -118,6 +119,8 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	vcn_v5_0_0_alloc_ip_dump(adev);
+
 	return 0;
 }
 
@@ -151,6 +154,8 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_vcn_sw_fini(adev);
 
+	kfree(adev->vcn.ip_dump);
+
 	return r;
 }
 
@@ -1094,6 +1099,8 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v5_0_1_set_clockgating_state,
 	.set_powergating_state = vcn_v5_0_1_set_powergating_state,
+	.dump_ip_state = vcn_v5_0_0_dump_ip_state,
+	.print_ip_state = vcn_v5_0_0_print_ip_state,
 };
 
 const struct amdgpu_ip_block_version vcn_v5_0_1_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h
index 6587879de458e..82ac709f44bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.h
@@ -24,14 +24,6 @@
 #ifndef __VCN_v5_0_1_H__
 #define __VCN_v5_0_1_H__
 
-#define VCN_VID_SOC_ADDRESS                        0x1FC00
-#define VCN_AON_SOC_ADDRESS                        0x1F800
-#define VCN1_VID_SOC_ADDRESS                       0x48300
-#define VCN1_AON_SOC_ADDRESS                       0x48000
-
-#define VCN_VID_IP_ADDRESS                         0x0
-#define VCN_AON_IP_ADDRESS                         0x30000
-
 extern const struct amdgpu_ip_block_version vcn_v5_0_1_ip_block;
 
 #endif /* __VCN_v5_0_1_H__ */
-- 
2.47.1

