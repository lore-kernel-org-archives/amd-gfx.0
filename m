Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E8FC28B24
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 15:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D64410E9E1;
	Thu,  6 Mar 2025 15:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q7QJIeB/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA12810E9DF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 15:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnpqv9RmWhFPuODF1qNakqPM4fIj37cGxOYhaphe0dyxqx1DLhSgE91zCdKRWzRaoogbO1vYALAjD44X+XyrA/aCOVSs8JgIXnRBzaOXfrMXatHeDTdA5oSZFqKzGPdNHO6gwJPHTRaFGexNGal15lGRLw8wYSk1BznezC9tnD08ACPLLEtCAFog3xyLLgLILGROltUeurhJa9zxbFTXFvKNbr5b70vCVInymaUybM70DkSPLp3MDvdM5ehnEJKPCJcVVYGgl+1Ee+RxBGpP8KiEd9dStRODG8ubKE5xNLR0S0mpQs8FkXFlbsmo9gvLc8TxvUvdA0/o324ewSLIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYgIuTav480WCcR4qSEqQ8QUz50yUTm5DELoPAC+XG4=;
 b=HefcTO5Z3UWhcIcRRrLhSzFpwd66FJLZ6x2tpbgsNLmWCHwaZ8wt/Bj6sjOiBheNeg63ztbZJpCgN8zmoI3eKeo/9Ged/sKDem+z7Pt+SLYfPXwKkk9AKGGDdVO+CRIq1jfxvaVVwt9u4s3cg1VRMKWlOSNg6oAjOf1Uk37NPQhnBxXIssvtfE6s9L552xailrJyaLzC4ZEBupIqUBGonpbL3WjWK9YWUzj8cgw6uBUUiqFRh/o6pf5xuLwb8NoLbxH6ATqY1BWWs6yNfkpch3U35JzAiL4+bzRlHEnCycgIYbdE/HFxhFpGCAxPYWqsky6Yk09nrDRIXK0sLGR4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYgIuTav480WCcR4qSEqQ8QUz50yUTm5DELoPAC+XG4=;
 b=q7QJIeB/tjBLfFKht2jZSRvxMeZlKtQAFMUh1a/HEPsemRfWTcy+7N8zRALmcTRQFJ1drvt6VSHeKiOT447f/GdQ1fTnhwbz548Sy4HrGRYthhfzul6D2v0wSc+pVTJMHFlVeBJbeAt6laXId8pm1aFgJvtzCzco8jO8DgxEE4g=
Received: from SJ0PR05CA0148.namprd05.prod.outlook.com (2603:10b6:a03:33d::33)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 15:56:21 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::48) by SJ0PR05CA0148.outlook.office365.com
 (2603:10b6:a03:33d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 15:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 15:56:20 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 09:56:19 -0600
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: Set per-process flags only once cik/vi
Date: Thu, 6 Mar 2025 10:55:53 -0500
Message-ID: <20250306155555.4687-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 85122a57-149e-428d-e2ce-08dd5cc77048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6dk3XtyBIbuxoA5v1e75MgP0sDPtOJB6YqdtGT9Z+lcfdObspgZN/+RIe3hm?=
 =?us-ascii?Q?PYgW5R2/0BBv1MYsXrVXw9u8HLTheV3wuA44UsN0zNorWj7gkDOIMXZyJdYj?=
 =?us-ascii?Q?CUexLxI1alJcY1S3sq2bjJrfNIcBsu16uz8M4kgOAaxidlSFSbb4T+EQ5+fU?=
 =?us-ascii?Q?Le6k2rTVvMyhMNj7ehFJZDdVJFeOb2X7vawLwMDqWG6I97LHDM3NUFg402aB?=
 =?us-ascii?Q?ksy4/qQS8Gm6VN/BZ9zdkYQbDE015oXsnfxnWLhmHLdbDTBaBKXuzRporSQf?=
 =?us-ascii?Q?Ruzj9c5yUocWsMy5asNmk+C2El4XI9j218X+rfoNbgJf8mN8xgkApR8UYTFZ?=
 =?us-ascii?Q?CdqN/knjKAkY7qQ+a91jp3UpeJU4R9TOgZPDezFp+CIdkoS4pRba5b8DXHQp?=
 =?us-ascii?Q?6mSNFlhAYqDkknr0HlvE48TPk9WzL8fxFpf0e8DweP4+DSI/5pYW0T2hqSUp?=
 =?us-ascii?Q?fcXGvSuYajGqwxkQVbkYdMt+cop8/yIqC2wgyaH7/c/OITBmre/p0UQoSz9n?=
 =?us-ascii?Q?3ftSxeiMKr3TbMzGQeL0R2DxZF8+Br/njCexC020ptMkeFBEpP3dax/7TZqS?=
 =?us-ascii?Q?ykctuxKye8hvqWwl626iNIRCKdfKTtVuddu4f0AQQK6KaTAzjQOZFLOEHqts?=
 =?us-ascii?Q?tdkLH4+5rk0rUZaN4sKA6VoGYpt4KWKFXUZlXa3ed3fZOQCtgcg7rAJMF/Hl?=
 =?us-ascii?Q?zeyOASeTGAZ3tSQJiG7D7ssJxj9Tf8zH56ZtoRSTfL+kFCVJeEDQFOynXGpr?=
 =?us-ascii?Q?HkqPYO7/HlQM2y0HExtidiKQipU6tJU8lseWVdivPdy89fMk0gX0pXhy3/8b?=
 =?us-ascii?Q?5TqTHJZOhl5D1CEP2B5hSGHUOY6MKbqB/AGtoCGv/055ViNTfx8UCoTUUl6T?=
 =?us-ascii?Q?NqXSu/upMCSnXJiDegupz6DDEW/nMBZXy/n+fPAgayEpJ791BAeTW1NKzXLb?=
 =?us-ascii?Q?TW3TtgdxwUqcPvgRy+WLoiBZrkOBeHsXtLTPv49YVRXamdVYf/TOfOwDjvyG?=
 =?us-ascii?Q?T3JWVcNpaerSGIBqwiiAWntm8ysab0GxVRiHZ7TGV0mThX2ry36bo/yiUXw5?=
 =?us-ascii?Q?hKwyXDnPvCTiVuU8i5BgwEPV6PopKAoFwhnCtuyJaKdf8T79B8QC+vQqoGE1?=
 =?us-ascii?Q?6UKlc/Iczp7K8hdqZXRKa7i4SQOWVqlCfQ8lRxIKy+zDZqHEGvNrV/w5j7LT?=
 =?us-ascii?Q?B2eRCHGTd6DElqBfhhuIR1ZBKbVFMBJ4gTPEsicd7juqatM7tBc4gRjoInxN?=
 =?us-ascii?Q?yHcM8sekZo56uYesuRJ5iSKxgPBjZjmZMJadPEBpaxj8UQuHbpHarHoOBG9k?=
 =?us-ascii?Q?ARNh/unjkO63pyCNyh47z4oftuq8VPvbMI2v/vZ5y/FlJw5qdtlqWsL5Y81m?=
 =?us-ascii?Q?M9HLua+S74cjzuGG9wodOrjyS1d+kkRT6cAKJ9/GXp3BprQlxsyjEJxyi2Ku?=
 =?us-ascii?Q?ED3NjWGLk6dHbJOZLhxpfBu4ll01zTPyqB8FIeAqxBmsyhT/CUiiFqGTwhdS?=
 =?us-ascii?Q?WBqUq6pdZL4+ijg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:56:20.7144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85122a57-149e-428d-e2ce-08dd5cc77048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238
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

