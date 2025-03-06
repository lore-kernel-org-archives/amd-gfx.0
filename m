Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC15C28B24
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 19:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFF3510E2B7;
	Thu,  6 Mar 2025 19:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eiFbZgBt";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED9210E288
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 19:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6JcsyyLGP+zXeXk9EJjVcN+xWcaRsF5LEcmeD9jH1GH6FAiFJgg8bzPQPXda5zzexZzpZ6hViY3gg6tA3j886BruyeqNJVV3XanpSU20eukDTc+Zdl8DKCcA2h8dx6MxZThnpNGg6+crqLxZ2GAoHJkq0CYrNGrB+pp9aprgJor7v4Yu5GbRYxCO7bUICz2S6vzgb45Gz/iNm0VdUTzrDJOZ/NNYKdrBHWqtq/3+jFn+jfthh3UF+q7VKaqwgPpMM0R0Ge5AM28Qv/qDrhmYCfoKKJP3qya5+rgf9dQ9+n0UZxzOiph9rkFVPlXh8nTiB4nvvD3gIXqfNen41uG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNn6k+WquV1gYTUD3x1Y69r2e/VZCpjKBr7v7Q5f8tY=;
 b=wAChJE3yaj80cIK3SzNR8uZs6Jet7aVoA15oodJU+fZFEaM+D+eK5MKgCJyL7E0jDmkOT3S6eaUTMWXpG6yaBFOCmfQz4xyKXobyYWBftm6bCrSYAFyCO0xFYo9DTw/j+WKlOXWG4Gn+kvlf9ITmutPWMfwABDRMxngWHucTb7b1UOAuv/xl/o3uuXexaiRo6mBxRS24CULN4QxmzYrCioTeF4aiYSO5H5avLHDe/fNblkry/ZDLYTvCeOsBm4/RzpTBWAx8LvoQv2Eb5kMCBF2NUrP76ENvSwgFr2iksbtFpSAZvEKZBcq82R4rLJl8VD+iFY91NQEneE3RSpmX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNn6k+WquV1gYTUD3x1Y69r2e/VZCpjKBr7v7Q5f8tY=;
 b=eiFbZgBtTuEe/ZNuOUfkiBrGek0r1/JsEX8s2WrlopFmrcusVYmzcTtK+ZYBONubpDI8vGA7DXQmBz65z3B9u8RJa8CnueByHA9OWxTVeIrtUacZFoDO8jaQpd+/NsKvA2JzWTkwmjkWUbvJy1Ac8mXtKNyqf0LegfeI7B/NiPY=
Received: from BL0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:91::20)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 19:52:40 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::f5) by BL0PR05CA0010.outlook.office365.com
 (2603:10b6:208:91::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Thu,
 6 Mar 2025 19:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 19:52:39 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Mar 2025 13:52:39 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v4 1/3] drm/amdkfd: Set per-process flags only once cik/vi
Date: Thu, 6 Mar 2025 14:52:25 -0500
Message-ID: <20250306195227.32765-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b7224c-936c-45d5-5610-08dd5ce87396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?14PoJ8vKG+VtUUek10i+6IqW1khFJ/AjUGbGSUeaketdvDm1Vow85k3/304o?=
 =?us-ascii?Q?IAAri/0rNHiMVvVnHZoZUK4zAJl0n5+4M1A7Z97oAeliPyUn6KXFZorpc61b?=
 =?us-ascii?Q?ucZqC0H8SC9W8qCXKDwCXOY896QWrWETbZtV7gluBxWr+iKdO3CKmVzrp0Qn?=
 =?us-ascii?Q?yI2H2XEtCB9jph+G22nqa+iBNtY/OaU7JeyyaGyo3N67frCNfHRaLyu6hPN9?=
 =?us-ascii?Q?76evJOpFTcEwiwRKoewIUwC7xeznoO2oS8l3hG+5sxxLm0h0yKo7DCfGZl0b?=
 =?us-ascii?Q?yFUZw2PxvCphU3KxK4CE+gqjyJ03c81PJmJcw3qzzMRKAnJYBsi0FnA31ocK?=
 =?us-ascii?Q?9zkYcgi2Q8lzHaeWi/TE5QYXxSO4ErPC5MIH9dGUDsHTGiKfwfku3LhQfKo8?=
 =?us-ascii?Q?IGKM+3vluZY1v5Aaqp1OK5U7T9+SyrwuAtxR+K+H2tR7D7FhIRI2RJ1VvOxK?=
 =?us-ascii?Q?croT1p4P7GM5kKLKFTaVoovTtVFslUQo+F1U/oJwTfTg4AWTHyv6k9+WDtKO?=
 =?us-ascii?Q?12LP1pT5owSfhjqf5zWSiL5Hh7P+wd+YL+tGDZfwz8/QlIZQBso2ALbG2xMl?=
 =?us-ascii?Q?6MW+wsf81bZOqrgYUUXWYMWaoU2dU2W9SVZ0JSZRhxbU9RqzCgPKwP/HVWwQ?=
 =?us-ascii?Q?dTEw1mMOc1jiqR0OXzZommYYVnaPBzAWz19CLA9vZPpPTJ3X3SrWKK87FLYA?=
 =?us-ascii?Q?BKW7WgvG8rSywTqLF6XTDjwAGZvV9GjjHgPlBvUrnberJIC3Fg0IypEF4O3B?=
 =?us-ascii?Q?AOSfezKPEoUNOBKlvPa0h1zGJfEzjaH8HEfbfNt/SmDVJvJjyV5OjAswoiwr?=
 =?us-ascii?Q?Ye2UoGdlGNYy91aqSuHk0m0IeUVKGziVAgpXdXoaUxH9HW8v2EOFNX9wZLnb?=
 =?us-ascii?Q?VqJLxW0EYJMhMwgflcttMTHEp+mcgZic5QVdwlB36yWow7l7xt1Uqc4N9UGl?=
 =?us-ascii?Q?BSWudFyOXgyIyzMcOVn1kJ5wR1bw/bRU1MS/8bIwJDYDaaP0ervAMMiCOQ/D?=
 =?us-ascii?Q?+NsyyyNTQT68Llzrc6aAMLMuYVk/VGaCARkdSf28lvgmFjIjTBmuqvpjhL+H?=
 =?us-ascii?Q?cmuUDdytScNH012PCROud7FWINbHOGbi4MKylPdQwp2jx2yZbkPDYLlKP0vw?=
 =?us-ascii?Q?onPiL8hmsRydPGkEf+a95u2Vg03VSRveVJ4TUOorIfMEMHl9QKwMJoOFDFpu?=
 =?us-ascii?Q?zQ1iZKgvCd4DydJsFshLGxcG625riP1evILbt3nNgPmuogTokPrvlHIHv+ht?=
 =?us-ascii?Q?Gnrscc/uFWpZPKA4qYLVhiS+Cy16aDgm/elYOPHI8d1Kd3x5InRaKxDwr7Sv?=
 =?us-ascii?Q?hCw0TaXL+hHgjqmtkyTkeDgp9tO3OysROv3O2bOK+5SfOgMePnZdtFG+d1k+?=
 =?us-ascii?Q?xp9K+B/AbNb9aY5hO22KHZrcIaF0R48CEcXQX4l3LqzEN3FQqYQJYcnV/h3S?=
 =?us-ascii?Q?S+2z+pgWBNQK/pty9OHNKaaSR8qm0d0KE13lWmndF1O2aO3TTs8DKP4nw1eP?=
 =?us-ascii?Q?2GtP4eEkpWUtvnU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 19:52:39.7410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b7224c-936c-45d5-5610-08dd5ce87396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
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

