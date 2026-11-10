Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6AF606A33C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SEQj2byq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3785010F74C;
	Tue, 10 Nov 2026 14:45:56 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DA710F74C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 14:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLQdjBXCscNtkPpURaRk8rLh29LtZnJnUf81KxzMIv6b+YQg/oVTO6H/UODvMJiOxGsRNvflD+DX2aeZojxw97TpZW7e6WyMNgyokwKvs3puagSR+7c+4996wK67PzB4qQA8kOs9QD0aHCR9cOlkwNeWS0u47aBERqwYUsDaGjMEA4sa2Yd4caXsC2RDjJHGiH21vNET9c4jmYh3LLQzOsVVHjK/cPZ+LLTUvVRi+y1cBzoGgeCI48ThuMqRwTLj8Mq5KFwlozvf7E3bBkc1mAh6Dn+SDAEX9fu6YFr/Ivn6AakZIbwgnw9v2t6aw2BoP5j03ba8tno95+TSyOwQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PO8EJAjlAmIW9L/1XapNUVcm6Muofx3Pg95Gf2YGxKQ=;
 b=ugz75oY+G8vbT96ERQ5gkxIdisyS59Zs+FhpEsXY7+9laaKszPP+DtXARetPNd/SxzCStebUC6sncVO6bQU9CFgfvfVjMAxz9w3tDKbBR5knCdhqd2z8gxFJ61viydygPWyMOy0QfHg8uG4E3W/jNeFSeIiodweAQd6SLB/3dTUrXJNJd2YVA4Ccy41hvqj3enWvGq2DvgWNWqjCE5WPDOZUtJvHvUq2DTAMW8P4eMaM4IDYAUobLO9uXg2aTi49NVqwQ0NMHxafsT+kCralHgBhtYvb+OPVtnyE9QNOZz/UrfdH0vjfLsC5q+deaUi8NEQV0dmYwtB31EYAA9R0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO8EJAjlAmIW9L/1XapNUVcm6Muofx3Pg95Gf2YGxKQ=;
 b=SEQj2byqh8XmKGBGP0Ti+iOwmYM6nkkVrTo7x86pK0rdMTv85KfoxmI0R66Ds93LKHWvPFb4WAWf/RjXXOWo2VYf6QG5LmQJ5rWPAml3df9nvwNM6vygv8R/qYIn4saZ7m+MhPLWrK58arQZLyt1stK6BXEFtJ1BRwwrgcFrCqY=
Received: from CH0PR08CA0001.namprd08.prod.outlook.com (2603:10b6:610:33::6)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:45:18 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::6a) by CH0PR08CA0001.outlook.office365.com
 (2603:10b6:610:33::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 14:45:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 14:45:18 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 08:45:17 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, <gang.ba@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Fix fault shader cleaner on MI3
Date: Tue, 10 Nov 2026 09:45:05 -0500
Message-ID: <20261110144506.3946989-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110144506.3946989-1-kent.russell@amd.com>
References: <20261110144506.3946989-1-kent.russell@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a818f1-0eca-4220-ad21-08df3f393d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|22082099003|18002099003|6133799003|56012099006|11063799006|261102123227099003|261021123027099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: ln8qsisF5iaK4DBrvegKEg1aus7fT/qf1bD7rLCkG5SFZgXygI/SA2wtN6jhewHTV1mEq3Kv9wMn4bShDC4FY2Zw43pE1SDHaoYzyEFl/Q+CWbTlxvNay2Ls2faANtx1mN5sJym46uzD+AtYsq5IEWG2cisc5XeDJGEHQYt6sxi2e/eMxOck9JwRnn5DUbBlfggybShqbSOXfNF2dXKDreDQOAf3OXd7GN8Mbvz4seYkgf8o9BTj67eD0+jdPkMcHXaTUhTNDAZYZVPDDF+bvdt5I7WQFKiJWbCBocpp+onVhFjTO1+hoeRBBbOMpzSmCz6hcrb7c3Bjy34j0QZLp8I5lvWSHbyupXSnIXhYfg/m43WBbAI+Ipkf2uAEimpzwxrAuBy9Ksfl0e6xriyGvZYPAQvaEwD+l9trC1sPFa6k7Fu03kSvNO9z3AS/JQdTjjtxooZNfkNuJV68qQ67iCozhrJL6tqW1DZGta9sGc8GhMoA/mECFNmiXVVWuPGWIM60itkFrwxcd7AG04HSR4Nqzhg9/YnLxkIPiWHdCt6jFZxOzlqxfmYrP4w66sFCWqhfmzDjhpVdkkJRutnTRxBR1EyzpmdWNgelywFml2Nyivrq4u9LrhPbL0XTA2rhqKfrqYe0A6El9ad7NstdgLfh0vXAmbc6t64CDn6cjwXhsviBcvTFxI8/MihaPv0KVnwc2U3LJHylN6i5xLj1RA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P0kMslWgIxObkbylZuvOgWYMEutlWrKGEBUo86UwlqYAjx1dXtXr07h7coulsc4UlSPbDRMrrm1xMpndGasIzLRGvjkbUPkAdtW8wJblCBPQCK63iCT93TqorP5VgtZou7HA0zEsc4EDUvRRsbDOJXdOmgBIW0avBcVmjJt+L7/RlEzR2ZtbWeJvF/Y4VOrJihoAz0d4+rtAZ7G6WKbTSKK0B/zmoCh00wK+06auFC4Q1A2/OJW98jXjKqmzvnnE4d/gp2jcDQ8Is7srEqSb1erpr/V/Lx+jDkHvDsZhp4QHG0JcaOSiNNnAH+UVSmYmo4hFa3DQAVeulqYV/1mn6RfwE040Dxckyj4TWeQAONCAQfivOB+goJZQEGjjXItYZSM3GGoCrY1PttDYwM1IEL6HGS3w3iAVqsnK1jYmdcR1N3MEPQoaJq/IfbXth+rQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:45:18.7305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a818f1-0eca-4220-ad21-08df3f393d82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
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

MI300/MI350 have a different register layout, and cannot reuse the same
definitions from MI2. The shader cleaner can be reused, but not the
initialization steps.

Also change the dim_x to ensure that we cover all wave slots per SIMD.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 37 +++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index dc46133ed506..a9f42d99d5c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -23,6 +23,7 @@
 #include "amdgpu.h"
 #include "soc15.h"
 #include "soc15d.h"
+#include "soc15_common.h"
 
 #include "gc/gc_9_4_2_offset.h"
 #include "gc/gc_9_4_2_sh_mask.h"
@@ -365,6 +366,20 @@ const struct soc15_reg_entry fault_cleaner_init_regs_aldebaran[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0xffffffff },
 };
 
+static const struct soc15_reg_entry fault_cleaner_init_regs_aqua_vanjaram[] = {
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x000000000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 1 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x00af0000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x000000c0 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x00000000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },
+};
+
 static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 				 struct amdgpu_ring *ring,
 				 const u32 *shader_ptr, u32 shader_size,
@@ -723,6 +738,8 @@ static int gfx_v9_clean_shaders(struct amdgpu_device *adev)
 	struct amdgpu_ib wb_ib;
 	struct amdgpu_ring *ring;
 	struct dma_fence *fence = NULL;
+	const struct soc15_reg_entry *init_regs;
+	u32 init_regs_size;
 	u32 pattern = 0xa;
 	int xcc_id;
 
@@ -731,6 +748,20 @@ static int gfx_v9_clean_shaders(struct amdgpu_device *adev)
 		return 0;
 	}
 
+	/* gfx943+ has different register layout compared to gfx942.*/
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+		init_regs = fault_cleaner_init_regs_aqua_vanjaram;
+		init_regs_size = ARRAY_SIZE(fault_cleaner_init_regs_aqua_vanjaram);
+		break;
+	default:
+		init_regs = fault_cleaner_init_regs_aldebaran;
+		init_regs_size = ARRAY_SIZE(fault_cleaner_init_regs_aldebaran);
+		break;
+	}
+
 	for_each_inst(xcc_id, adev->gfx.xcc_mask) {
 		ring = &adev->gfx.compute_ring[xcc_id * adev->gfx.num_compute_rings];
 
@@ -752,9 +783,9 @@ static int gfx_v9_clean_shaders(struct amdgpu_device *adev)
 				ring,
 				fault_cleaner_compute_shader_aldebaran,
 				sizeof(fault_cleaner_compute_shader_aldebaran),
-				fault_cleaner_init_regs_aldebaran,
-				ARRAY_SIZE(fault_cleaner_init_regs_aldebaran),
-				adev->gfx.cu_info.number * 32,
+				init_regs,
+				init_regs_size,
+				adev->gfx.cu_info.number * SIMD_ID_MAX * WAVE_ID_MAX,
 				wb_ib.gpu_addr, pattern, &fence);
 
 		if (r) {
-- 
2.43.0

