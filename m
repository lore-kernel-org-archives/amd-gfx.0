Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5C606A89B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XMDodPE6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08ECB10E406;
	Thu, 12 Nov 2026 13:44:01 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013028.outbound.protection.outlook.com
 [40.93.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E745910E406
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 13:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNn8WX5dGGt//fbGkmVVa7tKCFZa4VIDW4MwOkXGuWoJDcUY8MCGdli9tcOtKrmXOXLwUg/5WjvYS3NoGrFoPT6T0HbaDoxpAIXPZnPJx4zMEEyMgYeF0fP5ykcGC7JzYl0WHA/SC22WWXDN2GqdeGdS7fWhoHSbEaPS1Cht7c9LZrkcoJqppWR9V46IB/PaT4Y+VBQX6Sr3R5jPmAD/p5dqJdkvBljNkwTdmHb6f8iYLcRqLS+jn/1/jC6Mvb3tiaBjb+XlQMGVKm8Pp0HpN+fXClAqyTGnlsEAIC9Y70MRncKKCUJnFw3aS/cLLBzRRuu+5qbI+kTGuPLdK/IgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1594iqntFUh84HXoaaLKkWgSCPCcj7Z3KJMTwydTms=;
 b=gChbI3muicx/GGA8LXAHnr/Xo1wXPvoF2jbz+tc0d1GNr8FqnbHsgAypEol4eLFWn9ZDlio5oheVA67Dfl7gPsEe1sO46vkAgIJ2VJnaDe6HAeQNuucAN7XLMgPz732Y1mKmUVufcpXmqMOxuuIgFYAV3DMTAY0TZCZHWqCaZB5x8e8mX5Q35I2Qa/O0PLHhZ6OwzvbWCcdLEu3WYJiJeCMTrQ1qktSF1/0PLxeHavrRRorpDqEVBdljflIB64ATB8+WJ27Tse0Y/EXy+GmHBdOPMm31DG1qqSzMroMCCvRXIQ5u+KOSjBygq5rapJIjbLhVMPlTq+gEGywUPdlrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1594iqntFUh84HXoaaLKkWgSCPCcj7Z3KJMTwydTms=;
 b=XMDodPE6Ue55YtDFpNGHxBXliWu/YllzR2XHrVP802++OxOJg9jpJkjWLm6OMlKoXq3lGMKfFxfY05+1xe5iIeHy3ZnPDRV8Zt5/OOAVmnT3YnEMsYL7+TNWzUKO4A7wjSF3MhzWmzIt91PWCNwXxUtEUmdAYTQcxEAXUHrkQNo=
Received: from DM6PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:333::34)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 13:43:51 +0000
Received: from CH7PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:333:cafe::99) by DM6PR03CA0101.outlook.office365.com
 (2603:10b6:5:333::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 13:43:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF00000016.mail.protection.outlook.com (10.167.244.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 12 Nov 2026 13:43:51 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 07:43:50 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, <gang.ba@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Fix fault shader cleaner on MI3
Date: Thu, 12 Nov 2026 08:43:39 -0500
Message-ID: <20261112134340.4122401-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112134340.4122401-1-kent.russell@amd.com>
References: <20261112134340.4122401-1-kent.russell@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000016:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 2049a1dc-fb2c-4c21-eec1-08df40c2fc73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|22082099003|261009223027099003|18002099003|261021121427099003|261102123227099003|261021123027099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: jcJ9dHDqdO+5m3Bn7TNANlBPWKYaCPiDNm90p8QGnmdRZ6ircSM0nYlvHXH9bd5SWyXwQB/1hT+nn1rDnhjadGA1EU1wEqS532meIgV8J6BHQZ7HaDmxkAmYUdHcSnuYJDBTcS/c75iTCStuPG3Z+wxIIQWSO3+AI29cOnnJYOfkrDuoUGLDfyDrG6cga5ORY/yZEq10w4G9AL++KrLih3HlxdFXSSd2hUpeZYMowR4sFNaVM8VHX9vcPuPXDqbvMVY8MeqabiSmiJEbQOXsf42aYNqzUYeEk05/HQjlY1XPhiCb0uwG5Jate06Irk3sDjZgJhw+DnFX2QHaC2uOV6TPSIKdXce3iaRJjh3fuHCWfxmQvC0+0zeKpM5enAcbJnD8UkpC4Nk11gK/HziJb2KmHcUpr6kjmxDH2D231cf/K95Fv4GOLoTwOHJT1ejXWWZQe377dYO3Pb3A4hQRS5tQbx3cY1Yr69XbmHWL4jU/s2EVFRMUjdytcYey+sKOPbWFlywPuwrSP2paTywtlwJQf4N6+p+t8b60dwXVornUUd1A+dvy+d3K1WtNcL+is8pY8i1iZq5kJ4EJz2B+J+31zQz3o+0LJp23Je6epj2WcFg8gkOsgiVm6bJzIUoXP4ZkyCpjhEXdRgPWTMu/766yMtaSKVT35qwF7adoZj5cCdF7aMfqn+3+DJ7LGwjKYZt+UUwTSESC2Glp5Rj4vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(22082099003)(261009223027099003)(18002099003)(261021121427099003)(261102123227099003)(261021123027099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ujf+Ide+UPyFUhvx0YlfZSheARH1kedyQRaXYr2p9xY7pI2A40MosZ+ObOjmlwEsDpnC8ZAxcsoYQ9lavG/HKuAXL5n33Dj6V7huoEOwAUjS0T2pbxjVup7wOr5FoQN88g35KlvQ7ycnVB0D6XQXepW3spMT6DoZDk1yGDA1B+FoChbPrhwNJlTBPMHdMNG1FFnyTNcHf0Dt/kGUl1InaIEH1UX8bcm3S1hE0/4JhlHZQa247rz6nxG4GApiHNsMmfxsxh++Y0ulHEGn/C8HwWSZsBCuEJdxi5o7gnP7NhOHnKEz7qyeYhOGFLQ/ewu18K/I5Rz/vlnjbhk0ch/2Sn0dTYHCwOdzpfVOh0CAYLYojzXh3Sipn2XYvvlyzt3spZlTSQUIIAVZJaueoud1X8KhOHaStx5Iqpdheou9xgfkTuK5eqgnVN2Q9Acxw/Mo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:43:51.2653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2049a1dc-fb2c-4c21-eec1-08df40c2fc73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 24 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h |  3 +++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index dc46133ed506..95789f8d7018 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -23,12 +23,14 @@
 #include "amdgpu.h"
 #include "soc15.h"
 #include "soc15d.h"
+#include "soc15_common.h"
 
 #include "gc/gc_9_4_2_offset.h"
 #include "gc/gc_9_4_2_sh_mask.h"
 #include "gfx_v9_0.h"
 
 #include "gfx_v9_4_2.h"
+#include "gfx_v9_4_3.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_gfx.h"
 
@@ -723,6 +725,8 @@ static int gfx_v9_clean_shaders(struct amdgpu_device *adev)
 	struct amdgpu_ib wb_ib;
 	struct amdgpu_ring *ring;
 	struct dma_fence *fence = NULL;
+	const struct soc15_reg_entry *init_regs;
+	u32 init_regs_size;
 	u32 pattern = 0xa;
 	int xcc_id;
 
@@ -731,6 +735,20 @@ static int gfx_v9_clean_shaders(struct amdgpu_device *adev)
 		return 0;
 	}
 
+	/* gfx943+ has different register layout compared to gfx942.*/
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+		init_regs = gfx_v9_4_3_fault_cleaner_init_regs;
+		init_regs_size = GFX_V9_4_3_FAULT_CLEANER_INIT_REGS_SIZE;
+		break;
+	default:
+		init_regs = fault_cleaner_init_regs_aldebaran;
+		init_regs_size = ARRAY_SIZE(fault_cleaner_init_regs_aldebaran);
+		break;
+	}
+
 	for_each_inst(xcc_id, adev->gfx.xcc_mask) {
 		ring = &adev->gfx.compute_ring[xcc_id * adev->gfx.num_compute_rings];
 
@@ -752,9 +770,9 @@ static int gfx_v9_clean_shaders(struct amdgpu_device *adev)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index da031caa4e9e..d352d2ef4a5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -164,6 +164,20 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9_4_3[] = {
 
 struct amdgpu_gfx_ras gfx_v9_4_3_ras;
 
+const struct soc15_reg_entry gfx_v9_4_3_fault_cleaner_init_regs[] = {
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
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h
index 42d67ee0e7ef..e39d3f397259 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h
@@ -28,4 +28,7 @@ extern const struct amdgpu_ip_block_version gfx_v9_4_3_ip_block;
 
 extern struct amdgpu_xcp_ip_funcs gfx_v9_4_3_xcp_funcs;
 
+extern const struct soc15_reg_entry gfx_v9_4_3_fault_cleaner_init_regs[];
+#define GFX_V9_4_3_FAULT_CLEANER_INIT_REGS_SIZE 11
+
 #endif /* __GFX_V9_4_3_H__ */
-- 
2.43.0

