Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FC8C282DE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 19:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35DAA10EA57;
	Thu,  6 Mar 2025 19:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KyWda96a";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E38D10EA57
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 19:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOguRT7Vu09e4Sn4x4hBJu7QOkTSbsYR7BpBMnm12Wm9qED6vQcaZDtrlpFQIaRsase+zI3WtLq651pwe2UdSBQeP2WZcPhzjF29aV6ubs2ljJFOg+SdWuWTLhxJQOrF1S8xbnokbtiR/jgwtmhH3Byguavg3MDRo+MBq7AgsrqpCLNLKBQLJd8ZsZeePdHVry1PuINq2KQC8JMFSKqV8S6+YhEl6uLdidLDtQPOF5tSIoOxJZGTOEFkHh8FYUvGV4Pwzu9bKr2eaf/K7xh2y6ucPz7T26fPX2VYykBRtiMICyiD+GHytVQNtU87NBEGu2O9Yh/kKYfplyGEb4mxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNn6k+WquV1gYTUD3x1Y69r2e/VZCpjKBr7v7Q5f8tY=;
 b=Ia1S06i1OEGQn11jv1+GyADG15s7gzYOqKehMKFPVqTuBDS1Xn2vtWPytwE9QuU4qV1sFL5jKF+ocgPRAYaP3uMZvDYKzDpbuTeNRMXOuo/YcQkEZop7uyI21gH7MQED8eENZguzpRQKlLcieuhn7T+sbZJG7ykm6H7Xz2csXqpMB7F9N+/+PTaiixkDjkT4rcOcYLWH5xBwLzwoqesC9j8pHo2ndc7V6MkmJWhBa4QpRjANZLr7I2B3QPKd3fntG94SH2GVXFiaVk/feF98XZdGe+EznG82mE/X847pcLLZRkzeDMMJJzh/slLJMMI4iwnwfd6yAp+kXmJ7+pm86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNn6k+WquV1gYTUD3x1Y69r2e/VZCpjKBr7v7Q5f8tY=;
 b=KyWda96azM6AY/EVT/yj751HyECRHmxdYMRgbWS8haO9Fm1guUz/eC2h2FWD54vd81qZDqbmoBy13wlGHXQ7LnMcPuWLr2Hnfs4EXB5fPjILqin/HA8yCd7SqfZeT1WUHczmQ8GVppJCsLRU3+6SBFesRVwQhhOSqHhvomew8m8=
Received: from CH0PR03CA0415.namprd03.prod.outlook.com (2603:10b6:610:11b::26)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 19:38:46 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::f4) by CH0PR03CA0415.outlook.office365.com
 (2603:10b6:610:11b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Thu,
 6 Mar 2025 19:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 19:38:46 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Mar 2025 13:38:44 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v3 1/3] drm/amdkfd: Set per-process flags only once cik/vi
Date: Thu, 6 Mar 2025 14:38:31 -0500
Message-ID: <20250306193833.14258-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 7605c096-3081-4744-1701-08dd5ce682b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SOITi3iEp26Q+Oul6GwqGv/5UzhWn83tir1xxkrA4nP7XTaZn1mYnfQa3ukw?=
 =?us-ascii?Q?cGEON7/nIWFKB7EoJcjzEAr2bbBYDiMvw6FxxkBnrgAoHfUMc4H+xkiqQuz/?=
 =?us-ascii?Q?5D7C/tPW5/xH0FmVa2L9U3OcW7mHJbOM+Zo++8R6MbQpfz+Rs+GOGJpWLNsp?=
 =?us-ascii?Q?ZbPO0k4+1NNNukY3Tf2YPz9WWV2iMcidQQhBsdoSeXdpwhk6Mqy547XoHEdq?=
 =?us-ascii?Q?Ric3j2OCMQqkcFSVMjNxb7V6QpHjxsyks1sGqUkXJZsyLc3pQqbHdS6UWnHp?=
 =?us-ascii?Q?8NtbIzKUJFidGabtN1iXISKq/mzF/GqrJ8GJ58ulFLUvOxtR/6LNy6wD2Am/?=
 =?us-ascii?Q?rOi/easaQjhTAF3eY5Qz82nRPAN/XmualTQc37uEqPc0sw0d/wNKGxq/vl6b?=
 =?us-ascii?Q?XLhgaTLP7iU0RBLg9XHkTdRBg0Zrsu633TCXrywZBhv4eCfllwZv886xVAF8?=
 =?us-ascii?Q?xzVTB4/+bENNfdUJvJv6l6nIVquvt58zECL7o4VP9PTr/Z0+zeiGoiMm5pe8?=
 =?us-ascii?Q?ezujnvu87X/Nk1dhxZf0JL/BJPAd3aXYz9WqGmPFfdptha6QIPwdwKAI1MHK?=
 =?us-ascii?Q?gj0obrlcYlAbwJIM3+4AJx9yIcGmGCFBpCcZoC+LqJZRxGJDKBYOnQkHlS05?=
 =?us-ascii?Q?5Z5S71ejt70R2fbpuEbHZSPA2HJy2FWV9/eBuSaVj2+yz3w+M/B1+FZIh2vg?=
 =?us-ascii?Q?2DY5D4rjwVWY5gyGWq9QeDUnR72qNw/+QIQCDFuOqmYZ800Ix8tLnFzR93UJ?=
 =?us-ascii?Q?lf6fqQl7N4aE8lf0Eq2wxcObEaP2FXOwaxiD0wu7JqJLs8bdLtxo3dO5Aw9B?=
 =?us-ascii?Q?RrRpKxq4qFnJGDLVnFOBHwiZuXFpmEkf869ejaf41E3cs/m2gn22QgtOTHqY?=
 =?us-ascii?Q?fONZug4q8/7KTnAAtkU4eY3sWbxZcNYQkYZcqaCq8jPC6dEZ+agNUaWFerFM?=
 =?us-ascii?Q?MZ9sFrhY675po7yoGTzt0KEwGO7QM1XYMd9IHNOMzDQgt//8igSK4xmO++D+?=
 =?us-ascii?Q?N6iaSnDt690F7YYuZduHQTBdz3+89AKcOJQplXL8eL+WuxWVr292SbO3edYf?=
 =?us-ascii?Q?2lJyNLlmBrKb0O/ir9QqKfPQGCGKv6nn+w7abxfBzn0guXWSCtVb4+Mf1De5?=
 =?us-ascii?Q?LNeRVjKNxw6KJDsDhxCMOkT83+Im5ElcgOvwjVygg/bEuyD1o21OlyJIbUAG?=
 =?us-ascii?Q?OVrjL7T8EPh0r390iaOSRgROhlEyGVm5rIcVPbYL3+SgOcdg45AJ0oRyhzB7?=
 =?us-ascii?Q?w5i14CpaAqViuVUwA/7hh2qGgHoWc0b3UF/6boii8+DhBiAgvTshbNBAzg/J?=
 =?us-ascii?Q?9S4HQNqOWCh31g+fImeBy0ILN60fOsiHtl0J2vmcx4IJ2PMpAwW6CswH/69h?=
 =?us-ascii?Q?9++ODRnCtlf6wWzFeQofm9MeATVKsSf4NQhFAhpubjiMCMUu4soNQKPoMsZx?=
 =?us-ascii?Q?OdngMT3QObH4mn5xiV8stXjl7wQl09rfwDsBAKqEzV8WafvZfSsd04Sl5jiF?=
 =?us-ascii?Q?rBYmF7Hnyd4xby8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 19:38:46.0483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7605c096-3081-4744-1701-08dd5ce682b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
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

Set per-process static sh_mem config only once during process
initialization. Move all static changes from update_qpd() which is
called each time a queue is created to set_cache_memory_policy() which
is called once during process initialization.

set_cache_memory_policy() is currently defined only for cik and vi
family. So this commit only focuses on these two. A separate commit will
address other asics.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 39 +---------
 .../amd/amdkfd/kfd_device_queue_manager_cik.c | 69 ++++++++++++------
 .../amd/amdkfd/kfd_device_queue_manager_vi.c  | 71 ++++++++++++-------
 3 files changed, 94 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f3f2fd6ee65c..d23c6a358d34 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2591,14 +2591,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	return retval;
 }
 
-/*
- * Low bits must be 0000/FFFF as required by HW, high bits must be 0 to
- * stay in user mode.
- */
-#define APE1_FIXED_BITS_MASK 0xFFFF80000000FFFFULL
-/* APE1 limit is inclusive and 64K aligned. */
-#define APE1_LIMIT_ALIGNMENT 0xFFFF
-
 static bool set_cache_memory_policy(struct device_queue_manager *dqm,
 				   struct qcm_process_device *qpd,
 				   enum cache_policy default_policy,
@@ -2613,34 +2605,6 @@ static bool set_cache_memory_policy(struct device_queue_manager *dqm,
 
 	dqm_lock(dqm);
 
-	if (alternate_aperture_size == 0) {
-		/* base > limit disables APE1 */
-		qpd->sh_mem_ape1_base = 1;
-		qpd->sh_mem_ape1_limit = 0;
-	} else {
-		/*
-		 * In FSA64, APE1_Base[63:0] = { 16{SH_MEM_APE1_BASE[31]},
-		 *			SH_MEM_APE1_BASE[31:0], 0x0000 }
-		 * APE1_Limit[63:0] = { 16{SH_MEM_APE1_LIMIT[31]},
-		 *			SH_MEM_APE1_LIMIT[31:0], 0xFFFF }
-		 * Verify that the base and size parameters can be
-		 * represented in this format and convert them.
-		 * Additionally restrict APE1 to user-mode addresses.
-		 */
-
-		uint64_t base = (uintptr_t)alternate_aperture_base;
-		uint64_t limit = base + alternate_aperture_size - 1;
-
-		if (limit <= base || (base & APE1_FIXED_BITS_MASK) != 0 ||
-		   (limit & APE1_FIXED_BITS_MASK) != APE1_LIMIT_ALIGNMENT) {
-			retval = false;
-			goto out;
-		}
-
-		qpd->sh_mem_ape1_base = base >> 16;
-		qpd->sh_mem_ape1_limit = limit >> 16;
-	}
-
 	retval = dqm->asic_ops.set_cache_memory_policy(
 			dqm,
 			qpd,
@@ -2649,6 +2613,9 @@ static bool set_cache_memory_policy(struct device_queue_manager *dqm,
 			alternate_aperture_base,
 			alternate_aperture_size);
 
+	if (retval)
+		goto out;
+
 	if ((dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) && (qpd->vmid != 0))
 		program_sh_mem_settings(dqm, qpd);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c
index d4d95c7f2e5d..32bedef912b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c
@@ -27,6 +27,14 @@
 #include "oss/oss_2_4_sh_mask.h"
 #include "gca/gfx_7_2_sh_mask.h"
 
+/*
+ * Low bits must be 0000/FFFF as required by HW, high bits must be 0 to
+ * stay in user mode.
+ */
+#define APE1_FIXED_BITS_MASK 0xFFFF80000000FFFFULL
+/* APE1 limit is inclusive and 64K aligned. */
+#define APE1_LIMIT_ALIGNMENT 0xFFFF
+
 static bool set_cache_memory_policy_cik(struct device_queue_manager *dqm,
 				   struct qcm_process_device *qpd,
 				   enum cache_policy default_policy,
@@ -84,6 +92,36 @@ static bool set_cache_memory_policy_cik(struct device_queue_manager *dqm,
 {
 	uint32_t default_mtype;
 	uint32_t ape1_mtype;
+	unsigned int temp;
+	bool retval = true;
+
+	if (alternate_aperture_size == 0) {
+		/* base > limit disables APE1 */
+		qpd->sh_mem_ape1_base = 1;
+		qpd->sh_mem_ape1_limit = 0;
+	} else {
+		/*
+		 * In FSA64, APE1_Base[63:0] = { 16{SH_MEM_APE1_BASE[31]},
+		 *			SH_MEM_APE1_BASE[31:0], 0x0000 }
+		 * APE1_Limit[63:0] = { 16{SH_MEM_APE1_LIMIT[31]},
+		 *			SH_MEM_APE1_LIMIT[31:0], 0xFFFF }
+		 * Verify that the base and size parameters can be
+		 * represented in this format and convert them.
+		 * Additionally restrict APE1 to user-mode addresses.
+		 */
+
+		uint64_t base = (uintptr_t)alternate_aperture_base;
+		uint64_t limit = base + alternate_aperture_size - 1;
+
+		if (limit <= base || (base & APE1_FIXED_BITS_MASK) != 0 ||
+		   (limit & APE1_FIXED_BITS_MASK) != APE1_LIMIT_ALIGNMENT) {
+			retval = false;
+			goto out;
+		}
+
+		qpd->sh_mem_ape1_base = base >> 16;
+		qpd->sh_mem_ape1_limit = limit >> 16;
+	}
 
 	default_mtype = (default_policy == cache_policy_coherent) ?
 			MTYPE_NONCACHED :
@@ -97,37 +135,22 @@ static bool set_cache_memory_policy_cik(struct device_queue_manager *dqm,
 			| ALIGNMENT_MODE(SH_MEM_ALIGNMENT_MODE_UNALIGNED)
 			| DEFAULT_MTYPE(default_mtype)
 			| APE1_MTYPE(ape1_mtype);
-
-	return true;
-}
-
-static int update_qpd_cik(struct device_queue_manager *dqm,
-			  struct qcm_process_device *qpd)
-{
-	struct kfd_process_device *pdd;
-	unsigned int temp;
-
-	pdd = qpd_to_pdd(qpd);
-
-	/* check if sh_mem_config register already configured */
-	if (qpd->sh_mem_config == 0) {
-		qpd->sh_mem_config =
-			ALIGNMENT_MODE(SH_MEM_ALIGNMENT_MODE_UNALIGNED) |
-			DEFAULT_MTYPE(MTYPE_NONCACHED) |
-			APE1_MTYPE(MTYPE_NONCACHED);
-		qpd->sh_mem_ape1_limit = 0;
-		qpd->sh_mem_ape1_base = 0;
-	}
-
 	/* On dGPU we're always in GPUVM64 addressing mode with 64-bit
 	 * aperture addresses.
 	 */
-	temp = get_sh_mem_bases_nybble_64(pdd);
+	temp = get_sh_mem_bases_nybble_64(qpd_to_pdd(qpd));
 	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(temp);
 
 	pr_debug("is32bit process: %d sh_mem_bases nybble: 0x%X and register 0x%X\n",
 		qpd->pqm->process->is_32bit_user_mode, temp, qpd->sh_mem_bases);
 
+out:
+	return retval;
+}
+
+static int update_qpd_cik(struct device_queue_manager *dqm,
+			  struct qcm_process_device *qpd)
+{
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
index b291ee0fab94..320518f41890 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
@@ -27,6 +27,14 @@
 #include "gca/gfx_8_0_sh_mask.h"
 #include "oss/oss_3_0_sh_mask.h"
 
+/*
+ * Low bits must be 0000/FFFF as required by HW, high bits must be 0 to
+ * stay in user mode.
+ */
+#define APE1_FIXED_BITS_MASK 0xFFFF80000000FFFFULL
+/* APE1 limit is inclusive and 64K aligned. */
+#define APE1_LIMIT_ALIGNMENT 0xFFFF
+
 static bool set_cache_memory_policy_vi(struct device_queue_manager *dqm,
 				       struct qcm_process_device *qpd,
 				       enum cache_policy default_policy,
@@ -85,6 +93,36 @@ static bool set_cache_memory_policy_vi(struct device_queue_manager *dqm,
 {
 	uint32_t default_mtype;
 	uint32_t ape1_mtype;
+	unsigned int temp;
+	bool retval = true;
+
+	if (alternate_aperture_size == 0) {
+		/* base > limit disables APE1 */
+		qpd->sh_mem_ape1_base = 1;
+		qpd->sh_mem_ape1_limit = 0;
+	} else {
+		/*
+		 * In FSA64, APE1_Base[63:0] = { 16{SH_MEM_APE1_BASE[31]},
+		 *			SH_MEM_APE1_BASE[31:0], 0x0000 }
+		 * APE1_Limit[63:0] = { 16{SH_MEM_APE1_LIMIT[31]},
+		 *			SH_MEM_APE1_LIMIT[31:0], 0xFFFF }
+		 * Verify that the base and size parameters can be
+		 * represented in this format and convert them.
+		 * Additionally restrict APE1 to user-mode addresses.
+		 */
+
+		uint64_t base = (uintptr_t)alternate_aperture_base;
+		uint64_t limit = base + alternate_aperture_size - 1;
+
+		if (limit <= base || (base & APE1_FIXED_BITS_MASK) != 0 ||
+		   (limit & APE1_FIXED_BITS_MASK) != APE1_LIMIT_ALIGNMENT) {
+			retval = false;
+			goto out;
+		}
+
+		qpd->sh_mem_ape1_base = base >> 16;
+		qpd->sh_mem_ape1_limit = limit >> 16;
+	}
 
 	default_mtype = (default_policy == cache_policy_coherent) ?
 			MTYPE_UC :
@@ -100,40 +138,21 @@ static bool set_cache_memory_policy_vi(struct device_queue_manager *dqm,
 			default_mtype << SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT |
 			ape1_mtype << SH_MEM_CONFIG__APE1_MTYPE__SHIFT;
 
-	return true;
-}
-
-static int update_qpd_vi(struct device_queue_manager *dqm,
-			 struct qcm_process_device *qpd)
-{
-	struct kfd_process_device *pdd;
-	unsigned int temp;
-
-	pdd = qpd_to_pdd(qpd);
-
-	/* check if sh_mem_config register already configured */
-	if (qpd->sh_mem_config == 0) {
-		qpd->sh_mem_config =
-				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
-					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT |
-				MTYPE_UC <<
-					SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT |
-				MTYPE_UC <<
-					SH_MEM_CONFIG__APE1_MTYPE__SHIFT;
-
-		qpd->sh_mem_ape1_limit = 0;
-		qpd->sh_mem_ape1_base = 0;
-	}
-
 	/* On dGPU we're always in GPUVM64 addressing mode with 64-bit
 	 * aperture addresses.
 	 */
-	temp = get_sh_mem_bases_nybble_64(pdd);
+	temp = get_sh_mem_bases_nybble_64(qpd_to_pdd(qpd));
 	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(temp);
 
 	pr_debug("sh_mem_bases nybble: 0x%X and register 0x%X\n",
 		temp, qpd->sh_mem_bases);
+out:
+	return retval;
+}
 
+static int update_qpd_vi(struct device_queue_manager *dqm,
+			 struct qcm_process_device *qpd)
+{
 	return 0;
 }
 
-- 
2.34.1

