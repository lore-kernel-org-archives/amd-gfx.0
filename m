Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F61C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 16:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1364210E0D4;
	Fri, 18 Jul 2025 16:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o/ZK9Ap4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB85310E9FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 16:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urcNhk+lD3nNEpjzcTcPoj0a2mBLsQBU7lUouLmhah5qyOFpKk9il3Xz2Hvg44qZeERmaRIWk1cWcNA8/H7vujl1h6jFRnBXlBWTXaTJ8hedTC0WpzknffkkEIpRIDPkfRXYR9OSdRHvS13uyHxzvm0zBZG0wpIjaQRoN6aR2FTsmxmQNUkgMWsjD6eLP2795pBLcy23ucUREPrdclSMoIRO56jkUHAdDJ6QFD23Hocj7/Jk6dVYeC/RMuIckGmJvBxq1P9L4qF8TWe5TdVNBmezDJ18IMKKf8r4eg7Xc6zeodB4plCe6l9SjfyFnbxSbMgp8OTt9oD3BW8cJY852g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwiHsgaCd3xg4QHp6n3kk4PYSWCI0wWHFYVkvuiw2s0=;
 b=kXK7eRc2CkjSYnhepGzyd+hl248nPqqeOFIXf8TofoP20scmIZ8ZASr+OO5bN6bscBOIOxFoHnzqFBlVi/rvzBH1oqDtOE80z4q1dzEzno9AGlSwKMxTsfpDm0KFZAS6eujCl6k8g6qsUeal6jtdZCyA1dSDlYU4Ko8t/yaU5dOPj22d/4m30wGMla2QHBjMwPo4b6aoH49JazK8aYVjtSrjG1tNEbW/Mf+SePDmeUyukDrZQ/UqakVh/5ndFjwW+9B6zguHhgj14428cDMsRLQYfXmmErlm4upO1ITq0ru7BiijeTa0Tm03prAsaf7gg1nJlW07iazQHnksKggczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwiHsgaCd3xg4QHp6n3kk4PYSWCI0wWHFYVkvuiw2s0=;
 b=o/ZK9Ap4+9qaFC/3S0/ekS6mQP6P2o3y1J+60cFxbSH1SYgdP3CUc63wM2Sbi0SETMckYW2TPvma1eGmkygpUFKvL+aYhUXkOPkKotT8HSM0QVtZlMumufRh87c6z2xxpfKnaTlPCvpuhfPs4ze3TszMKy6WgvDLFF8xkxRsWwM=
Received: from SJ0PR13CA0097.namprd13.prod.outlook.com (2603:10b6:a03:2c5::12)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 16:09:56 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::51) by SJ0PR13CA0097.outlook.office365.com
 (2603:10b6:a03:2c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.15 via Frontend Transport; Fri,
 18 Jul 2025 16:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 16:09:56 +0000
Received: from sclement-U2202a.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 11:09:55 -0500
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Sunday.Clement@amd.com>, <Joseph.Greathouse@amd.com>,
 <Kent.Russell@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Ignore user ctl_stack_size on queue creation on
 gfx9
Date: Fri, 18 Jul 2025 12:09:28 -0400
Message-ID: <20250718160928.1154323-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 111148ae-c047-4b7a-dca2-08ddc6158995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/1u5FTW/mMfnfFh7hO4QdXn34qYQ+q4fZyLdGQ2RVuEuovTPvs6f+o4T86M5?=
 =?us-ascii?Q?XfSm1fsO6kuMOhTPrIXBzwH7N1y4gcX2j0pD/rnJygh0LQcdmHTs/CCtR85Q?=
 =?us-ascii?Q?ac1SiAGIs7p0tW4StgO2/wwJ+ls96SaFzFq5YQe6wHBIpFPHYzwiWM2Zzooh?=
 =?us-ascii?Q?f1SG4OI8OrcNUsIc7zryPcwnNDqCNQVv9mWP6HaBhqUOb1ZZIx73wcbepwqM?=
 =?us-ascii?Q?skDS9PKUGEbMOmIOYQdjqCdGNV8YsL0cU2y+/XiHY70BN38hGPPUfmaIrn3Z?=
 =?us-ascii?Q?dfdvjRquQP/wX0lrhNRMAGXEC1k4SwDV0ytP0upPkebEtJpcM3q4yqyiFe8x?=
 =?us-ascii?Q?8AwlgODlZwQOCG0Do3HsAvh55DFqZrK1il7LLmqEyBClvHCsjOIJCCqv6YOq?=
 =?us-ascii?Q?g3ocEqZhN8Yfl2unudQNuTYp7B1jmx99gMNlAlCFzprAx3Zd0oM4W/VHymV3?=
 =?us-ascii?Q?Mvmm0RRsiYx+k0QH7AaVrCM9yBtvF3IPuPIZCR32cKKP9pCR7n1/VVPxX3+9?=
 =?us-ascii?Q?/0w6uHcgyNsGnGS4dIklehyUp08LJ9Sj/0AutX+wnu8KPqYNhK26eGtmKKYY?=
 =?us-ascii?Q?FrFLe+NyFqZ+JOJTebO4h+2JX5o6qTQhC1Dnqcgj9aPxccmqfhDQ3jjUFUXV?=
 =?us-ascii?Q?9SoEW+DjV+cTRci4j2HMKgO7U39tK4/XDEZ3JI8YcjmPMbAuYADSPbb6Jnh4?=
 =?us-ascii?Q?vvAJvEQkf15QVQA54XMvO6m6J7xPoYiPZ7O4xQErnUwMoYu9y2CNEFdaq8Ld?=
 =?us-ascii?Q?KAT2CNrOoL1VZBzDYHqq2oqDuEJx0jfNsYawy6X7AgtIdEoNjR6U4FpSJinw?=
 =?us-ascii?Q?P6BorSpG5zzagKSYVpI7BH/5e73hb0/tTKDmmZniWg+Dp3GKVqGxYxakgMAc?=
 =?us-ascii?Q?1Mf16XCZIIqhxyS4OUpUR9wNJA4uLG93qa+7T89102/w62raHEn2XznqSDwW?=
 =?us-ascii?Q?3FJxYC8GlxWEwd8/FgzJJdfriRXKQVnkHF0CNx5nkDep/uGHAivWveExlCNQ?=
 =?us-ascii?Q?tKLDlJLBZdFloowD+HLVknYxXg87gIg8bLXnCfZKSL+28+kVfbSczaLhkrug?=
 =?us-ascii?Q?mQ09e6zGeazdckQjLR0Liq71nJnmdkOC6zvAgHKf//zyVOOu4jqCnhkVQpnb?=
 =?us-ascii?Q?lFXpBQDyBimtOb6GXS51TxBrbHhv/FE0GLaB7czWI7KNXS2i3rEDppgm6f9Q?=
 =?us-ascii?Q?9mv9OcGxngLaxe7sEx91+GdSNTKDamHsYA8k8zm3OLsVPYyVpAjtVAXLQILd?=
 =?us-ascii?Q?6/ivUvi4+/SbWiPfM/fwcpyeBMZ+zAvStZ75MTK+doEz22X5OtFhxJQkd1zp?=
 =?us-ascii?Q?eZ2F/JcLXrk3CetOd7Ccu/Y69t0EZH8bWMYSn26BoeG7VIAg02pZc2mC6U6u?=
 =?us-ascii?Q?tNMMr8Ee1ZMsDagOIXIjE13jNVIrWlzvE6vlrtFN7ssoNbzYf6G+Vmevi1l+?=
 =?us-ascii?Q?K/m0og72sZpW8m+TErnOuYx0wKRJCBR5yZbq6/gLzrwTm/mo06lFUBXsI+WP?=
 =?us-ascii?Q?Rlk2+hvjaGN3ceqOSLMKdNcbv38VitvYtJUl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 16:09:56.0037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 111148ae-c047-4b7a-dca2-08ddc6158995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

For security reasons it is safer to have the kernel driver handle
calculating the sizing for the control stack on queue creation for
gfx9, rather than having it done in userspace where arbitrarily large
values can be passed in potentially wasting space in VMID0.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 97933d2a3803..8841411050a3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -135,8 +135,25 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 		mqd_mem_obj = kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
 		if (!mqd_mem_obj)
 			return NULL;
+
+		uint16_t xcc_mask = node->adev->gfx.xcc_mask;
+		uint32_t num_xccs = NUM_XCC(xcc_mask);
+		uint32_t num_cu = node->adev->gfx.cu_info.number;
+
+		if (num_xccs == 0) {
+			pr_err("Invalid XCC mask: %u\n", xcc_mask);
+			kfree(mqd_mem_obj);
+			return NULL;
+		}
+
+		num_cu /= num_xccs;
+
+		uint32_t num_waves = num_cu * 40;
+		/* Add Bytes to accommodate ContextSaveAreaHeader */
+		uint32_t ctl_stack_size = (num_waves * 8) + 8 + 42;
+
 		retval = amdgpu_amdkfd_alloc_gtt_mem(node->adev,
-			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
+			(ALIGN(ctl_stack_size, PAGE_SIZE) +
 			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
 			NUM_XCC(node->xcc_mask),
 			&(mqd_mem_obj->gtt_mem),
-- 
2.43.0

