Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4484CC282DE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 15:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B8510E9E3;
	Thu,  6 Mar 2025 15:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fUDCM+H1";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5076A10E9DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 15:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEzrTckx3cVqacpbYBXOZMeWiXB672rWUVNs4V5fbF14fMPujvXyZKppXUk7RbH79kBSr3tgs+04JGZwZgdWKypXWsrzEXYy1qv/abYIub909OR6AJYx6MDXw5uMV0gMNkSMPjPzCA2LPVualIkwQZa7EsVez53aoz1nOKKp54+ktKc2w7YKBKw/wKx+1WCosyMcRUqoYlFmCIdnwRJMPgaCvMmKQDznfhJW1byyQxP58y6fGFd6rX/Lj++0068QmCdJezUqnvjm0kOZz14ZbtvuaEqdlsZLJ+i3ofC1qcjHAAJFwfr8cCNxamaT+D4vkwteb9AzkzVJc7kavKG7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v39yEQUN8qUv8r1RbDoa1tMR7FGxStfOIVMC2kMdx88=;
 b=hpt+g8trk2nmRmYPF2THZtWToFh19zGoodPrV4QHbIcrg1hPz5+u3HmdbBz8XmVebFLFUJBhN8H+7wgjAStA1d7pkh0IdpyTKP/yF53pvpoUQTnUyjbnOYVCv2n+7GSsS+zKgt5CtOUupE4ePpQItChjsc2XGF8Fcn63iAgsM+s8xtwDnZdevqUXfoDRbry/B7whRz+m1xzHyDHXJLNphhJN0dJIJ3HNsWiY+5oMkdEovNh4d3i8rPP15bUFVoHTSnLONRdB2pAOIIcXYsRJ1//M3wksCtrYHxj4uUbTUjdFQh74nk+nwWvlJkDJNaup+bYVeqhskDwmSme3qR5vfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v39yEQUN8qUv8r1RbDoa1tMR7FGxStfOIVMC2kMdx88=;
 b=fUDCM+H1E4Rs5mneeTCGuUhP347wD4l0+VrnhKLk5/Dau9IB1hLOSqebMU9JcjCFoEtZ/JL4NMRtSBS6nmJ7IS3dQv9HyyF/Qn375Pa8XwLTuvqZjPiYDLpLqLvj8G2ZuChv7NFvbIsPNteVx9nJ9Ux/D/I0db/2oGeZJw0BT0o=
Received: from SJ0PR05CA0124.namprd05.prod.outlook.com (2603:10b6:a03:33d::9)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 15:56:22 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::88) by SJ0PR05CA0124.outlook.office365.com
 (2603:10b6:a03:33d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Thu,
 6 Mar 2025 15:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 15:56:22 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 09:56:20 -0600
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: Set per-process flags only once for
 gfx9/10/11/12
Date: Thu, 6 Mar 2025 10:55:54 -0500
Message-ID: <20250306155555.4687-2-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306155555.4687-1-Amber.Lin@amd.com>
References: <20250306155555.4687-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 975f52d8-2abf-4fbd-8942-08dd5cc77132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?18Hm8XNi51MAQf6HaJDM4cH8vDANae2Rhp/gjctJ6DgYP6Fakb4NZkBW6KeE?=
 =?us-ascii?Q?atXuJ3t7kSdKvWMxnDLelRg2om56ts1VNgyHKdBIFByQ7LhoHnQiKi9mlLzl?=
 =?us-ascii?Q?kraA4OZnOAHrTYFso4qyjt/r/h/6NStjIRgcIBCey/udzf0N7YVIhQUWoVpy?=
 =?us-ascii?Q?W9Q8ObcPtJE5iWYQ0uk03OXnDiWdT1pqDUmkzuk+SJtW0sG4ziTU/jeO5NMi?=
 =?us-ascii?Q?PPIrR5b2jfOUxOvX/v+r7Uzgyxc9RRBK8OaBN8Rqk1OMLZHYZ8+W4sic91Qm?=
 =?us-ascii?Q?Ca4XZbs68KzRxK12dcKJyIE9hginoq5JHlYroIFCTAStH1ncVhZxTLfBPQkh?=
 =?us-ascii?Q?qLuiuPNejY2+sdfJanT1Pm60RmN+l5PRLLH7DrwEsLIfJ5NiejhIID7oJHGw?=
 =?us-ascii?Q?OaZTY97z9XwpEiP9Bacah0q4io6neSQk8/bFJmPde8wPmdNLMTDQEV+1y5Ms?=
 =?us-ascii?Q?D16ZxCAupQismtmh2BUZr3HY570nJshLcM6hawEr/hbaiuPhDGlrmS3MLZbf?=
 =?us-ascii?Q?UZjhGGHN451EFUYUHOLsZi35CnXNZRT95Wbl9u4mIbktPSt8hXuNX1jQez/e?=
 =?us-ascii?Q?8mqBQ8sZ/PIWxB+3Es1pNvbVc/QaFqOWw6bvLPv3tjn0Mp5ay6PofFvTpYz2?=
 =?us-ascii?Q?DAfhFmcvEw3NVxC8XbjY8r2ggtC76Ic6Ezumum4bo8ipXfVEKeIpGv0llogP?=
 =?us-ascii?Q?DWpSj/OUxA7yFeUVlWj95cPP7QWJkTSE5dnHdf63DM8CGUtgpiycEbs47FZK?=
 =?us-ascii?Q?3R2fZo+7IagMNtwAOHXjTUMEZi0NmSoAyyAr/ra280H2NylEtbradrvLQiQc?=
 =?us-ascii?Q?FrhHGTq66YU1KaoY0CN3D5CBEUr8jieovREICgfTGCdWBiQnI+Xj8Jety2fY?=
 =?us-ascii?Q?BrJi8bJVIq4uWWiiIG6I+otr1T1+WnB9H9daem/GLcBkMWvHQHxAkurWG1bT?=
 =?us-ascii?Q?izrKfZ7CEszsSqatSr5NIK5DpDukuxZGQ1Eu4viDhI+TBmPoUz7KHV9gAZDs?=
 =?us-ascii?Q?dtual3fqQ9Uw+tY3i8QssWDamlJdTnshLgjd4xMOm3pWvLpI4nVZg6Gyu0eB?=
 =?us-ascii?Q?H1nMGtRS26ImipQQFuNEIEhcmk6SDTmxju/+zn6VagtzF8n8Tbdm0bnWR3XN?=
 =?us-ascii?Q?KzIuKub+r5KKSEBYQGGjEYKtqHOxkItnwgs3rW1gEbWJ2o/vLiErF1JceIsA?=
 =?us-ascii?Q?4MAYIfVPdVydu7RDiSNRboNrvbnGLUg/ZNmeUs76wr6wKpRTgaWdmri/q8LM?=
 =?us-ascii?Q?BsmzsHlBTd5f2/ZNMwJeuwXv8ak47zMpIDUlWtIqYxzFJtDAv/L3g1kfQlVO?=
 =?us-ascii?Q?yMQKDBdVLFtOxlQT8w6o97KlxGW0iPF+7inApxGfKfVjDH/HfdBz2ugf16E0?=
 =?us-ascii?Q?dkKtcEbQt2ZuOaFy8eCHs9puGNAlLEY3/7jbaWHHWUfFtUT9BKIfeo5fUHp5?=
 =?us-ascii?Q?QnIdfYMfIdQAt4Q4Uor3kP3fUDVYnvZsYjO4BCrTOKzA69WUwwSU+Y4UNF0l?=
 =?us-ascii?Q?F/aiwJh1YoezHqw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:56:22.2456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 975f52d8-2abf-4fbd-8942-08dd5cc77132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
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

