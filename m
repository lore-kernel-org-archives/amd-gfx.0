Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFCBC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 19:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D7110EA71;
	Thu,  6 Mar 2025 19:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X8YCD7ud";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8BF10EA71
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 19:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVnbTLRu8JlQJa5WDjoSsthELuxYqNYvnKkLa9HD+bpcpombe/ZnCIrBjL8L7Hhv+AAoxLV9QGpGkXG2DKsxpTaODhtV4k+9/W1w6/CN8ueVQW/Vi4YGS4e+zni9MsEz1QG3Wl94m1Nah+EfuuQDT4NQiDQUYR0aqEc8Bw1PsAAXFe+EzflUSJpq5xqKD2EuqOhOXI90Qc54Sumb2ZcGx4rsF91Oru104g5aV85GzCOBj2qDD6uTSrrjUZEDl5srlcn5ZK7QvZieUDEH/awF+ulU1FBsA6y3tmrzR9fFlMDCVmT5vPX49U4zTfbMnkmfFxO6pBxqiK0KYUPLxWj0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtbwSpemgrgaEA8t3f5+LYnCWB8j/Re982OsZ3U8Il8=;
 b=BWJxg7uhykmQtMfgGL1RcoXzIjVtxmm6JssJTNqqqFslbA4u0peExEIiQyqpo7/G1dhlet/avuVcQEIeNnBwdF6Oe2XfmHAM7frpF20ypooQdUHQnkl53ZatIXK4rXUeC0fFIkA+U4wz0TI15TpKTzctrTAB8pWbZLNnr4/z3JCYyB0yjQ09fD5Cgdvsiy2MaegzzZ3mHm8hrlORgQsaIziYmRVrLHApOo2iZzyZdq3Ynh9Ke0TlN8ZAMOEMSn+/0YoDfk+B4Rzmt1up+mt6gpcWLRk0HAfpA9MIg5EW3lkXwXQTg4YgIAd9oXMSKHF/SECmbCsyPkGFWxTKYOaxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtbwSpemgrgaEA8t3f5+LYnCWB8j/Re982OsZ3U8Il8=;
 b=X8YCD7udBrKEMmZeZX8oU2MDSx+i2sOGsc4/SVmIqwvfgM1xKxMhCehQwHJBVtAD1hhcn0cehrNBaK9I9+e8o91qw1r+WQq3EUStNkCfmatzI3eAFUa4rCS2Waf3b3deoqT8CBbVOmzT2PeF7/hen5U44wBV6xble/I0UQuAQl4=
Received: from DM6PR02CA0041.namprd02.prod.outlook.com (2603:10b6:5:177::18)
 by CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 19:38:54 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::32) by DM6PR02CA0041.outlook.office365.com
 (2603:10b6:5:177::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 19:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 19:38:54 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Mar 2025 13:38:53 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v3 2/3] drm/amdkfd: Set per-process flags only once for
 gfx9/10/11/12
Date: Thu, 6 Mar 2025 14:38:32 -0500
Message-ID: <20250306193833.14258-2-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306193833.14258-1-Harish.Kasiviswanathan@amd.com>
References: <20250306193833.14258-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 18aef799-e933-4534-c17d-08dd5ce687ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gc9/e6HjpuadXHlRJ+MOlTwmRjNBaoJe5ns7beNRitH6YFZyd11o+mPKMa4G?=
 =?us-ascii?Q?reUI/ODoLXwCjpUJ8/mPMROfJ4XsNSlaD2M0mo1JjHIPONLEkwFWROYNLVaS?=
 =?us-ascii?Q?iWA+GnYwOF+Jdo70uday8c1n+Dwd2yV1250nzV50cdAbjssXQqItg/Zr4bwN?=
 =?us-ascii?Q?JP2IFWuM5do7n8p4+VDldyYcShuhg4RCXk1+JT8t2iRgDaHYsKhtX2bf4QJQ?=
 =?us-ascii?Q?RI95lAH4TKbsp/JrJA8bDXzxi9pYHjfbNm005iiFbND7pdN3Eop658/eWGJb?=
 =?us-ascii?Q?2lgjYdbqBZMMtKbVAMwqsOh28TJZZfm1MC4IsqLpZ7GuVjZ2tmZL/wdfUnSq?=
 =?us-ascii?Q?cfe6O9+taqDG6TL/X172KfXYWWKUxpbRxQG6AFD63G1O24hka0gvN4SPwTkg?=
 =?us-ascii?Q?wSz1h44/ataG4bdu56yzgyK+vaqTkE9nlsnK+v4/iVwxbj2FAahpnHd9bxqC?=
 =?us-ascii?Q?UjF9sSC027bCjy51jh5NlB4hZvfhZtQ/CoKEPDmshAFrRhYXJAEEGGFSgqS9?=
 =?us-ascii?Q?4c+kjL77O3ARalJZO65pID9nMBc9gmF2VImn2Bwl1/RWiVYzCwEI6zWFbkMT?=
 =?us-ascii?Q?OZA5qaiw8h3nEuRmvESUHHt/4WGewldLj5CcyE7XL9F2r4gLc0mTujyQq1qB?=
 =?us-ascii?Q?eMBFaHIjJJnhyqjgWSw0mQ2GMxC7rdTmLvSxuQQzWNLMmvF4OpNMKINDPAaw?=
 =?us-ascii?Q?6jGHs/lxzgnN1MS6uzMQnk+GUKkbAQFwaKwgr26l5cnXe7AYPD/u/QzFl86/?=
 =?us-ascii?Q?rcpI+w++65jXnBelOstmw7LZ9H6UfJYXs52ylJb0XJ8hZtSVKOrf1+MGHFZF?=
 =?us-ascii?Q?Jj1dWvn5mNdDKk5GafMpnRjrkJ+/zA3rmDXpbR0HPsYlvBsGUvcmEsZD1G/v?=
 =?us-ascii?Q?CYTaMedUVLf47Q3psjXzPFkBs1Y+0136ish/nOoNWYcubEuR7/BqMj3tMswF?=
 =?us-ascii?Q?DSPaKiS5RTRWYtluMszbuDbYiISxZf/wjV/bgZQ0Rc/J/cKxrpKPgwOxqIiN?=
 =?us-ascii?Q?M8CJkDfn/n3p4RkGQi2Hil5RiSTDQAxf4bEXzcEJ2CnVzMLfVvXLQzgL8EbW?=
 =?us-ascii?Q?pPtV5j8pQMlbq4NlU/ZclADNAoJsDbE7F6uebteZ+fCyutCdGkQXqU7Oi+vR?=
 =?us-ascii?Q?LgZtifzRkz6vGubEn6BA4JBZ+MAhDL+His1670q0vknES2sHeV9Olmcv2M0p?=
 =?us-ascii?Q?KT/3fuK0PT1t6YHdqhj6P3Yzigt2jm3eoaJn30H5bnWVvaURUDOTwFHhDcbD?=
 =?us-ascii?Q?I4WL8mpoFAZTtWOFSYmvKJgOVMSjpC5VfGxZtWwgOOrWm5+MLjBZguMYgF3r?=
 =?us-ascii?Q?V7jgjLFvGtERLMWrL+ucv3h9X1Wca7oQ+uI13WaDAonN5/LHaQxNAyoswah0?=
 =?us-ascii?Q?E9z4DwjqQ6rFYk20ylfwTOf40sEVG9BwPQLhMmHc4jJpDlypVMNY4G4tqrQh?=
 =?us-ascii?Q?FjWebT+ViSI3Gp9Viu011nE0kkhShFkHhDd0NMRM6S8kRNXnB6FsOfyCvtWi?=
 =?us-ascii?Q?3tIp1btXb9nrDAc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 19:38:54.3995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18aef799-e933-4534-c17d-08dd5ce687ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023
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

Define set_cache_memory_policy() for these asics and move all static
changes from update_qpd() which is called each time a queue is created
to set_cache_memory_policy() which is called once during process
initialization

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 .../amd/amdkfd/kfd_device_queue_manager_v10.c | 41 +++++++++++--------
 .../amd/amdkfd/kfd_device_queue_manager_v11.c | 41 +++++++++++--------
 .../amd/amdkfd/kfd_device_queue_manager_v12.c | 41 +++++++++++--------
 .../amd/amdkfd/kfd_device_queue_manager_v9.c  | 36 +++++++++++++++-
 4 files changed, 107 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
index 245a90dfc2f6..b5f5f141353b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
@@ -31,10 +31,17 @@ static int update_qpd_v10(struct device_queue_manager *dqm,
 			 struct qcm_process_device *qpd);
 static void init_sdma_vm_v10(struct device_queue_manager *dqm, struct queue *q,
 			    struct qcm_process_device *qpd);
+static bool set_cache_memory_policy_v10(struct device_queue_manager *dqm,
+				   struct qcm_process_device *qpd,
+				   enum cache_policy default_policy,
+				   enum cache_policy alternate_policy,
+				   void __user *alternate_aperture_base,
+				   uint64_t alternate_aperture_size);
 
 void device_queue_manager_init_v10(
 	struct device_queue_manager_asic_ops *asic_ops)
 {
+	asic_ops->set_cache_memory_policy = set_cache_memory_policy_v10;
 	asic_ops->update_qpd = update_qpd_v10;
 	asic_ops->init_sdma_vm = init_sdma_vm_v10;
 	asic_ops->mqd_manager_init = mqd_manager_init_v10;
@@ -49,27 +56,27 @@ static uint32_t compute_sh_mem_bases_64bit(struct kfd_process_device *pdd)
 		private_base;
 }
 
-static int update_qpd_v10(struct device_queue_manager *dqm,
-			 struct qcm_process_device *qpd)
+static bool set_cache_memory_policy_v10(struct device_queue_manager *dqm,
+				   struct qcm_process_device *qpd,
+				   enum cache_policy default_policy,
+				   enum cache_policy alternate_policy,
+				   void __user *alternate_aperture_base,
+				   uint64_t alternate_aperture_size)
 {
-	struct kfd_process_device *pdd;
-
-	pdd = qpd_to_pdd(qpd);
-
-	/* check if sh_mem_config register already configured */
-	if (qpd->sh_mem_config == 0) {
-		qpd->sh_mem_config =
-			(SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
-				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
-			(3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
-		qpd->sh_mem_ape1_limit = 0;
-		qpd->sh_mem_ape1_base = 0;
-	}
-
-	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
+	qpd->sh_mem_config = (SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
+			      SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
+			      (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
+	qpd->sh_mem_ape1_limit = 0;
+	qpd->sh_mem_ape1_base = 0;
+	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(qpd_to_pdd(qpd));
 
 	pr_debug("sh_mem_bases 0x%X\n", qpd->sh_mem_bases);
+	return true;
+}
 
+static int update_qpd_v10(struct device_queue_manager *dqm,
+			 struct qcm_process_device *qpd)
+{
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c
index 2e129da7acb4..f436878d0d62 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c
@@ -30,10 +30,17 @@ static int update_qpd_v11(struct device_queue_manager *dqm,
 			 struct qcm_process_device *qpd);
 static void init_sdma_vm_v11(struct device_queue_manager *dqm, struct queue *q,
 			    struct qcm_process_device *qpd);
+static bool set_cache_memory_policy_v11(struct device_queue_manager *dqm,
+				   struct qcm_process_device *qpd,
+				   enum cache_policy default_policy,
+				   enum cache_policy alternate_policy,
+				   void __user *alternate_aperture_base,
+				   uint64_t alternate_aperture_size);
 
 void device_queue_manager_init_v11(
 	struct device_queue_manager_asic_ops *asic_ops)
 {
+	asic_ops->set_cache_memory_policy = set_cache_memory_policy_v11;
 	asic_ops->update_qpd = update_qpd_v11;
 	asic_ops->init_sdma_vm = init_sdma_vm_v11;
 	asic_ops->mqd_manager_init = mqd_manager_init_v11;
@@ -48,28 +55,28 @@ static uint32_t compute_sh_mem_bases_64bit(struct kfd_process_device *pdd)
 		private_base;
 }
 
-static int update_qpd_v11(struct device_queue_manager *dqm,
-			 struct qcm_process_device *qpd)
+static bool set_cache_memory_policy_v11(struct device_queue_manager *dqm,
+				   struct qcm_process_device *qpd,
+				   enum cache_policy default_policy,
+				   enum cache_policy alternate_policy,
+				   void __user *alternate_aperture_base,
+				   uint64_t alternate_aperture_size)
 {
-	struct kfd_process_device *pdd;
-
-	pdd = qpd_to_pdd(qpd);
-
-	/* check if sh_mem_config register already configured */
-	if (qpd->sh_mem_config == 0) {
-		qpd->sh_mem_config =
-			(SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
-				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
-			(3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
-
-		qpd->sh_mem_ape1_limit = 0;
-		qpd->sh_mem_ape1_base = 0;
-	}
+	qpd->sh_mem_config = (SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
+			      SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
+			      (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
 
-	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
+	qpd->sh_mem_ape1_limit = 0;
+	qpd->sh_mem_ape1_base = 0;
+	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(qpd_to_pdd(qpd));
 
 	pr_debug("sh_mem_bases 0x%X\n", qpd->sh_mem_bases);
+	return true;
+}
 
+static int update_qpd_v11(struct device_queue_manager *dqm,
+			 struct qcm_process_device *qpd)
+{
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c
index 4f3295b29dfb..62ca1c8fcbaf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c
@@ -30,10 +30,17 @@ static int update_qpd_v12(struct device_queue_manager *dqm,
 			 struct qcm_process_device *qpd);
 static void init_sdma_vm_v12(struct device_queue_manager *dqm, struct queue *q,
 			    struct qcm_process_device *qpd);
+static bool set_cache_memory_policy_v12(struct device_queue_manager *dqm,
+				   struct qcm_process_device *qpd,
+				   enum cache_policy default_policy,
+				   enum cache_policy alternate_policy,
+				   void __user *alternate_aperture_base,
+				   uint64_t alternate_aperture_size);
 
 void device_queue_manager_init_v12(
 	struct device_queue_manager_asic_ops *asic_ops)
 {
+	asic_ops->set_cache_memory_policy = set_cache_memory_policy_v12;
 	asic_ops->update_qpd = update_qpd_v12;
 	asic_ops->init_sdma_vm = init_sdma_vm_v12;
 	asic_ops->mqd_manager_init = mqd_manager_init_v12;
@@ -48,28 +55,28 @@ static uint32_t compute_sh_mem_bases_64bit(struct kfd_process_device *pdd)
 		private_base;
 }
 
-static int update_qpd_v12(struct device_queue_manager *dqm,
-			 struct qcm_process_device *qpd)
+static bool set_cache_memory_policy_v12(struct device_queue_manager *dqm,
+				   struct qcm_process_device *qpd,
+				   enum cache_policy default_policy,
+				   enum cache_policy alternate_policy,
+				   void __user *alternate_aperture_base,
+				   uint64_t alternate_aperture_size)
 {
-	struct kfd_process_device *pdd;
-
-	pdd = qpd_to_pdd(qpd);
-
-	/* check if sh_mem_config register already configured */
-	if (qpd->sh_mem_config == 0) {
-		qpd->sh_mem_config =
-			(SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
-				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
-			(3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
-
-		qpd->sh_mem_ape1_limit = 0;
-		qpd->sh_mem_ape1_base = 0;
-	}
+	qpd->sh_mem_config = (SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
+			      SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
+			      (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
 
-	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
+	qpd->sh_mem_ape1_limit = 0;
+	qpd->sh_mem_ape1_base = 0;
+	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(qpd_to_pdd(qpd));
 
 	pr_debug("sh_mem_bases 0x%X\n", qpd->sh_mem_bases);
+	return true;
+}
 
+static int update_qpd_v12(struct device_queue_manager *dqm,
+			 struct qcm_process_device *qpd)
+{
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index 67137e674f1d..c734eb9b505f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -30,10 +30,17 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 			 struct qcm_process_device *qpd);
 static void init_sdma_vm_v9(struct device_queue_manager *dqm, struct queue *q,
 			    struct qcm_process_device *qpd);
+static bool set_cache_memory_policy_v9(struct device_queue_manager *dqm,
+				   struct qcm_process_device *qpd,
+				   enum cache_policy default_policy,
+				   enum cache_policy alternate_policy,
+				   void __user *alternate_aperture_base,
+				   uint64_t alternate_aperture_size);
 
 void device_queue_manager_init_v9(
 	struct device_queue_manager_asic_ops *asic_ops)
 {
+	asic_ops->set_cache_memory_policy = set_cache_memory_policy_v9;
 	asic_ops->update_qpd = update_qpd_v9;
 	asic_ops->init_sdma_vm = init_sdma_vm_v9;
 	asic_ops->mqd_manager_init = mqd_manager_init_v9;
@@ -48,10 +55,37 @@ static uint32_t compute_sh_mem_bases_64bit(struct kfd_process_device *pdd)
 		private_base;
 }
 
+static bool set_cache_memory_policy_v9(struct device_queue_manager *dqm,
+				   struct qcm_process_device *qpd,
+				   enum cache_policy default_policy,
+				   enum cache_policy alternate_policy,
+				   void __user *alternate_aperture_base,
+				   uint64_t alternate_aperture_size)
+{
+	qpd->sh_mem_config = SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
+				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
+
+	if (dqm->dev->kfd->noretry)
+		qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+
+	if (KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 3) ||
+		KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4) ||
+		KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 5, 0))
+		qpd->sh_mem_config |= (1 << SH_MEM_CONFIG__F8_MODE__SHIFT);
+
+	qpd->sh_mem_ape1_limit = 0;
+	qpd->sh_mem_ape1_base = 0;
+	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(qpd_to_pdd(qpd));
+
+	pr_debug("sh_mem_bases 0x%X sh_mem_config 0x%X\n", qpd->sh_mem_bases,
+		 qpd->sh_mem_config);
+	return true;
+}
+
 static int update_qpd_v9(struct device_queue_manager *dqm,
 			 struct qcm_process_device *qpd)
 {
-	struct kfd_process_device *pdd;
+	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 
 	pdd = qpd_to_pdd(qpd);
 
-- 
2.34.1

