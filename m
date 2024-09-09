Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E991ECE587
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D6C10E696;
	Mon,  9 Sep 2024 20:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0e9SN7D0";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D9710E697
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCi6bUwwyyB/YmSTKn9lhBE5gaV0xkFV5f5zrZtdVV7JokUdmhch0X4r4qJM0Jzf2oBgs7HXAnnNiImvNVe9rUzyHO2SlMExx3m0Sy+/3F1hN8I3rQj04wI446FtiniEUmmYFDBmBZZW0aN2yipzVNTGuaW1iOuxvTImyJOofXGwxOnueF6ACIaqciv5SsqQ5xl2bys3ETovW8uKgbWB1VVRnNq384ud2GXO0gecb4RVOt34hC5ID7fWRYckfzDH/P5WwlphcwNbPYKw3QrKulxWT75syeKR91tMYckAzhQZZhFvypgfR/h4MfH33emggI1S6Fw+UT4tDjotzBi7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xF3JFTmpJJ0qEIL/NGpg8YNLlUoz34vx2MAoT2gp7CE=;
 b=ZCoWbIZ/stLzUwTzablffqNPO1KlJBw9xcwRr0NtUXbu4yiYesUy6i+QKXDT8pToDN+wKQVgPh56bQGY35Oe6ohNy7DAgqMDO7A+hEuFM+GG1gayzeU7q+oEzowJbpnGoHUw9VrJx1ceGI12A4UCzEZijW9MdxnHqePeW+ury5VXQziQP28kh3/8qeGjlvdnHW4SZNlHiYLa5qHRaHi65IWV6BEddHPlSGV+KU4sgOA7uLy7kVMeIrCBc8O/+I9LN8TemgVrVG0sefRGQKgIxqdKHQftomeQp88fZU6NoFnBbLBAKQFTqY+HVPxJ5cWR3+vRDgp3+ZCADHmQdc4KaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF3JFTmpJJ0qEIL/NGpg8YNLlUoz34vx2MAoT2gp7CE=;
 b=0e9SN7D0OWJ/T97CUB2ZZHo/KdyeuPkVO137NUma2c9LlVD7886RiiWe3foWohHICa+oWmgIYe+FGrRiul6xb0JdVnXIfp1/ZvKXptaONyw4TDD2uw6Jby6cCJDnI6gD3Jt5hVv/8SVis1OIIZ6SZGYgdwPTccBN15DeJmioezc=
Received: from MW4PR03CA0314.namprd03.prod.outlook.com (2603:10b6:303:dd::19)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 20:07:27 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::b3) by MW4PR03CA0314.outlook.office365.com
 (2603:10b6:303:dd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Mon, 9 Sep 2024 20:07:27 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:23 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <Arvind.Yadav@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH v11 25/28] drm/amdgpu: Add input fence to sync bo unmap
Date: Mon, 9 Sep 2024 22:06:11 +0200
Message-ID: <20240909200614.481-21-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: d81d8f31-8d5f-4ae8-1d15-08dcd10b0720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XiNur2t3tTiUucimz3dndGyuzQ3J7dTe3/2NIQ+4N0uM/IUUlLPKZ/zroFk5?=
 =?us-ascii?Q?nRBervCgTKS9Sch6Xdhl1LNfu8mRSYeyZXDSis/h7lQB5z52Nh8puVAgsOUL?=
 =?us-ascii?Q?/jgSyQtGBAagl/tTL6P3IjF8+cVMDKOvqrDtGsI4Ld+ksMRKdUGoZXTRSo8n?=
 =?us-ascii?Q?MdziEPBelp05zkiFn3whJICK7cMBICDIKiF+UkMaYDRuXMIYOZ7OTUD3Usvs?=
 =?us-ascii?Q?1I9KbFxOXWohDxEpvXggvvWwIlCm/wqM+v1H0FZsULTR+QPJs+D2Hi/s+ssg?=
 =?us-ascii?Q?ghK4MekpmD8HXaqDMMLHJTaTpMQpqHBe/Ff3prM3nQQCko/o7aU/eYQ4gM/U?=
 =?us-ascii?Q?PBstcouc5yvqbtCURFt0dCQyk7hSqgRNMhhdxeGkaC4jieQUoovJ5obiNHuv?=
 =?us-ascii?Q?VfbgbXx9m4NmWl/Q9Frq/6zfEN5D/vQmGX11oFb3xFMZMkBhcIQz3jy9jxfz?=
 =?us-ascii?Q?VQ+7WMRjlBE7VRug93UbrXonHaWliCjoA2ECZZ0b8quSsfeD/1oUwZ5Hedm+?=
 =?us-ascii?Q?/OoOfreJDhkfjt4y20pM5q6boeyBvXuFoaJ0IqUrxNwdeyrm5dzZYhIlIvQ8?=
 =?us-ascii?Q?Vrmy/T77G14LYp5DpWZwvDDocgnQUfNSLirhU1AB2bcbpT0ea/2FRPhDr5Ss?=
 =?us-ascii?Q?owH1bbvHXknK3rtU2KguFPl+hDiayks322mU+ZYjUUJdOvC/GhWyptiCAzQJ?=
 =?us-ascii?Q?CF3tdCgB2VCYsQSncjeDi4zC2t7pYcwRBfr2m+V5bREUq3kCnTAbYAVfCTRe?=
 =?us-ascii?Q?4k0Ptf2Q3rhEZOOeqGV2jG1A1/1baA4+wFabHUN6HA6iX9MYKS25zfQjRSZL?=
 =?us-ascii?Q?xoHJEoGgDKQJg+TNYDTd3+s9s5CzXNGLIaBgnjy0jOCM/44jEBaxND+gLXO6?=
 =?us-ascii?Q?SISTQsLeVtnYEASlzQ8X/Tkm1H+XWx7LjZtZ56j6zdtr8lL8Ucm850xZOVyt?=
 =?us-ascii?Q?mg1k8DjUUhNEjMfx17p7aQ81yISBnpGNhDfZXY5Vi4btqrLHmJ3t4kOexXVi?=
 =?us-ascii?Q?XOm/2iazEzKmwdRlcDaj4m+X8pBzAp/IJyb8ipgRWisSF515sRMmYjx84Wha?=
 =?us-ascii?Q?hSHPyOrw0dz+fi5BXE43W3aqOqRS4HPD6WtGptQc4Urzg2H6metphTukozcJ?=
 =?us-ascii?Q?E68uv7ZgZTeg/e2ocaLWNS3MgDq7DwIla+stK9RILaVEtPMpaPmhfLglZsad?=
 =?us-ascii?Q?noh7Ryou/MpFbYNqbn7i96Mbzwx/uFFFMtTs22HUpVtbbXyIQdyQ3hbwow6U?=
 =?us-ascii?Q?9j66MrXOi5C0WkycB/YXE9ARBrK8NML5wHVU/pG7wFRlaaGwN0AyWThWk7ru?=
 =?us-ascii?Q?sm8ZRpS5LAIsv2YoUyPpbbFUzdopq0BhwvqirDjl/6/2NfKW76lPEeFd+KsS?=
 =?us-ascii?Q?p08iTkSkbe53vvjs2S/dhJRhwhtZR2VBmIotnDtJl+/LHp8DqWV9W/Q6ZvYM?=
 =?us-ascii?Q?aCPJvaSlKzQdGbmcYQLadPpNJuq5X/Ts?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:27.2594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d81d8f31-8d5f-4ae8-1d15-08dcd10b0720
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
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

From: Arvind Yadav <Arvind.Yadav@amd.com>

This patch adds input fences to VM_IOCTL for unmapping an object.
The kernel will unmap the BO only when the fence is signaled.

V2: Bug fix (Arvind)
V3: Bug fix (Arvind)
V4: Rename UAPI objects as per UAPI review (Marek)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Change-Id: Ib1572da97b640d80e39d73c9c166fa1759d720b5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 41 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  4 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index c9b4a6ce3f14..7823faa3dbaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -36,6 +36,7 @@
 #include <drm/drm_exec.h>
 #include <drm/drm_gem_ttm_helper.h>
 #include <drm/ttm/ttm_tt.h>
+#include <drm/drm_syncobj.h>
 
 #include "amdgpu.h"
 #include "amdgpu_display.h"
@@ -45,6 +46,39 @@
 
 static const struct drm_gem_object_funcs amdgpu_gem_object_funcs;
 
+static void amdgpu_userqueue_add_input_fence(struct drm_file *filp,
+					     uint64_t syncobj_handles_array,
+					     uint32_t num_syncobj_handles)
+{
+	struct dma_fence *fence;
+	uint32_t *syncobj_handles;
+	int ret, i;
+
+	if (!num_syncobj_handles)
+		return;
+
+	syncobj_handles = memdup_user(u64_to_user_ptr(syncobj_handles_array),
+				      sizeof(uint32_t) * num_syncobj_handles);
+	if (IS_ERR(syncobj_handles)) {
+		DRM_ERROR("Failed to get the syncobj handles err = %ld\n",
+			  PTR_ERR(syncobj_handles));
+		return;
+	}
+
+	for (i = 0; i < num_syncobj_handles; i++) {
+
+		if (!syncobj_handles[i])
+			continue;
+
+		ret = drm_syncobj_find_fence(filp, syncobj_handles[i], 0, 0, &fence);
+		if (ret)
+			continue;
+
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+	}
+}
+
 static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
@@ -809,6 +843,13 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		bo_va = NULL;
 	}
 
+	if (args->operation == AMDGPU_VA_OP_UNMAP ||
+	    args->operation == AMDGPU_VA_OP_CLEAR ||
+	    args->operation == AMDGPU_VA_OP_REPLACE)
+		amdgpu_userqueue_add_input_fence(filp,
+						 args->input_fence_syncobj_array_in,
+						 args->num_syncobj_handles_in);
+
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1dc1dba6b024..8dd0d1808e37 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -840,6 +840,10 @@ struct drm_amdgpu_gem_va {
 	__u32 timeline_syncobj_out;
 	/** Timeline point */
 	__u64 timeline_point_in;
+	/** Array of sync object handle to wait for given input fences */
+	__u64 input_fence_syncobj_array_in;
+	/** the number of syncobj handles in @input_fence_syncobj_array_in */
+	__u32 num_syncobj_handles_in;
 };
 
 #define AMDGPU_HW_IP_GFX          0
-- 
2.45.1

