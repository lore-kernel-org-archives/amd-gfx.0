Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E77606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IH4dLgDu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D262110E2B9;
	Wed, 28 Oct 2026 20:35:21 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11A3910E2B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 20:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Heer9e5NHjozid/DGVxLkg4Yj58gcv/nLBwc2ay2+gitGyKdeABTfBzPnRO+fjzhurVPBcDaz7xq7klDOLUklJ0tXUQzo+1Em5orZbsM9Tbfp2u20vqshWd5GlzpgTXmNtlywbv/DZHGASffhq5IH5MW1bzqiUoa2btQlLnWMEKQ3gPIykBoAPnIs8EfSOaw7KNQwF8NtFad5WHPlbm4sRCg2a7bszfMBRBiOS7YnyaCABX59IV5jmDwlDhpWLzOBuxwjJSGmAhy3Vf6amOF3YtVW4puHAvhb+3nf5grhB2t3lkbfb4vueLfdgVynkJdyzXtzhRmLYOLiXdXUQmOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K/2/YaKsNMdCbjHLr2Vr0dh0fYXrfNrm4g9H0/Q3GA=;
 b=wKsJ6eX4LXwhWlXm1pWECjQRhvn4rg+Cn86nNpghhpwBmvV2n/jZUZlhnLX9gf77Qn61FKYXmwFcMJ44vkE9U+yjDe/MypqUoCjS55ejUInR1WMaH3dufieN9tUbI5c4YGlxZ9dVKIDougUIxeQm+OLP5pXGNesHT3KK+7ChcDNd5A86EHgCPqaijJM7beA6Vm5LnI7cnUzK9ncTu7SPrcEk3pt0M26zKodrQUyUw+SnQoi5LNJNuhkp5PcpNm8l69FKa6hni4sxg7JhDyceRo/RwAEzg45cOl+7YXeFtUP73HLvbCbfjzNCIacFdxfEMuYD1I6euZpLbaRI7GNHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K/2/YaKsNMdCbjHLr2Vr0dh0fYXrfNrm4g9H0/Q3GA=;
 b=IH4dLgDuW07FS/b5HcuDjG5bkdNQbDTooxzW1LUQ+cdPhuPMZd/loR65dAMW8KIygsS6WhBHFbzZrDpeMc0pcvFtPb8025B15Yku2sLlPclD6uSj97M2s8MyFIyE83EXViR69WavO18xO4QZ25P02MUdG1qSfOmydng55IBUans=
Received: from DS7PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:3bb::13)
 by CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 20:35:09 +0000
Received: from PH3PEPF00059617.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::19) by DS7PR03CA0068.outlook.office365.com
 (2603:10b6:5:3bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 20:35:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF00059617.mail.protection.outlook.com (10.167.243.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 20:35:08 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 15:35:05 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, <gang.ba@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix fault shader cleaner on MI3
Date: Wed, 28 Oct 2026 16:34:53 -0400
Message-ID: <20261028203453.3463371-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028203453.3463371-1-kent.russell@amd.com>
References: <20261028203453.3463371-1-kent.russell@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059617:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a1970b-6541-40fe-d951-08df3532f4f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: afqV9HHvHCqF22XFtazOImlAfcUvVc3bICBzwn3HgxUXzCXPhTD0BKukw5ctspLCq2ZZK0gO0uSjxrmXzXYfbVT/b2tIjO86u/X+Gefd3+pOHsd5amEk8VNUiSV7397tQEFkZF8T4wRlnqbxyC+3GHKPm1AZbT4F0XbLLui/fmHyHNojPu09ENzvumYtWZvJsVQlmpLHF7odi3+9rPvARpS/rNbZaejAF/1vf/x+THnNSldloIH38w0Hrw2PhocnsJUh6aRDbwAEd0othM6KtE4e2H18v2jpVNQvEIKce+8sBbzoKiQVAVxPaPVaM3I90+EuU++MOwS5ShCmlfyQLNRu9sL1XpTkaPHVNEF/k9PLIQKxM/s1J9qHBpvMvIc7L7Nie/nSVViOQZDg1Rj88wqa9Jh48pPVq8hUXkjsFDgnqflusUhP1dCOjIi7H4khDN/b5QsUb5agDGs4yYg4IcfGWgfPzLfaZECClx+CDOvhzcFNg5/Hk0/nwfJvOK/mda0K/GEPtPASr82xQvi7mt+Hf5MXZkv96EaXR7dXyQ7wV6c9x2RfkHcyfsP2ONGe3D2PmduJPjepCWXPL9l2NU2KS7hZr8608enXb/ppY/qWUikKR5zUxKevv6piPJhW4nMa9iS2wnB+TwHuxbn0GVfM2vRMfMc9OFRcSyv2b1P90zIyzHd2iZezy0aG+z2rDFxsP5PySFtc2GFs/EO+CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gPo148IHkgzfGTO3ELyAcNPwgHq5UQbGiKMvGBJtYph9E9zPU7+88HQBSrKRWuCoRvtKo5fXW2OO8+jB7H9Rm2toB3LAZjDWuvc4YvtlR0ahwFS5+g+T1sAOFULZtxYkUne78t8yS/s9H4IKBn5vxy1UqGeapHX3jz/QWNVPMDtdsNgvsJ9kmuKrMj0R539QQYZVgxsVq2VfEm0e6suCjTNfqZsyQLJN05nBSTWy8o9DYEf2Kpjy0bBknPxUNtI5So61mbGX05uEd46DaOnuctuY5A/+HECk4UWBMllLoHNwvuAyccbGVk5QxFIu+MxOQUiXUoZGMWGXNggeWkyFgqXsfcyctCiYbWd6+C6pR4UxwDzTAL5yoSbfw0oVmhLz+44skQJEoYmtgp+Oc3RTUxWBBPNazBtXCG6oOyGSVjel5Nm9e1AHAE4jWWB5D7s0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 20:35:08.3438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a1970b-6541-40fe-d951-08df3532f4f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059617.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404
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
index dc46133ed506..7018efbc5e02 100644
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
+		 init_regs = fault_cleaner_init_regs_aqua_vanjaram;
+		 init_regs_size = ARRAY_SIZE(fault_cleaner_init_regs_aqua_vanjaram);
+		 break;
+	default:
+		 init_regs = fault_cleaner_init_regs_aldebaran;
+		 init_regs_size = ARRAY_SIZE(fault_cleaner_init_regs_aldebaran);
+		 break;
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

