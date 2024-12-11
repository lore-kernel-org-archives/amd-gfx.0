Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AABE7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 17:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A562110EBC4;
	Wed, 11 Dec 2024 17:13:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1iiGUBLz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9BB10EBC6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 17:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSuO2JihlT6xczyZ+88VMJJ69xJ9K65vnLEThx1FoMPFFY6Tyhajcx45MNOfLSlqPsJ4i/gc9cp3dv4ewpTOG1oM9xQ+lSb1QdnbjF7OfrUOxU+fM3PZN+LVO/qnO32sXdqNAKrtAvW5iLbdMOIS0ao4f7w0QBBL0H1x4GclGWhcyuYMInI55hRIYlllTEtfSu1kj4PzopC7jbgAU16jJBivuB22EjO+3lqWND4NMY6IEnJid61cavriXFNHlbsclOjskz0wsMCZyMpuBczbRjq+KbznlPp+Ewc7dVJS/QMo0VroF79HteivJvIDYEMsBXbWgHTwYJBTbBrG6QBbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3CY2GZaajR6zoIJX+w8mbO/qsb6Jvapk7mR5yWe0NQ=;
 b=LCa0C+m5RvtSryW8+U4iEb80Ts/j0qf5NOD/irGo2TQsCJhFWDlQ5dvQ1g6GJWqixY4W75rD1eBuTDoW7XSK1hDG8hEHU4XHy7dtNn8SpnfnuOztjxiwuEdA+YydUefRdUx1s4CJzzxsAMB+Qei2LRbK84RqxarJbL2VKQ1m8Y5YkEENU9tCCuuo4BQaKs62tq8gpfKnb5jw9v4rhNcSipCnrd4Es8RyRu/nKMutgdhOsVEwCshbqTwYgNaiLrVGtFaMBf7UEEQ8YN5KoZPQypJT97KlJ9tGr+m3Beuab4kbf9cV2dASRxNnR1qIHwd7p4GPPKcsLVuTcOZB1uXtCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3CY2GZaajR6zoIJX+w8mbO/qsb6Jvapk7mR5yWe0NQ=;
 b=1iiGUBLztp+AUDNfRY5E0WwWYMPQ+BFPY8n1F0qQfiTV8JbvNRRIM0nfTjvr/GJRXrs8gtN86Hcux652LA/YY6qJeHl1b589KUUwMTfIhbGlnE3GEMTJgoNe84wxOzehu2WM1XXummeyVZx9oQtDO6Ixa3AwvZmOOB2BpJQE4tY=
Received: from SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 17:12:59 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::15) by SJ0PR13CA0110.outlook.office365.com
 (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.13 via Frontend Transport; Wed,
 11 Dec 2024 17:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 17:12:58 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 11:12:56 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: drop the amdgpu_device argument from
 amdgpu_ib_free
Date: Wed, 11 Dec 2024 18:10:49 +0100
Message-ID: <20241211171238.805137-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211171238.805137-1-pierre-eric.pelloux-prayer@amd.com>
References: <20241211171238.805137-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc87f74-9521-41a3-c4b5-08dd1a070fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HPe9QHa7wCrNW1O/I84n8xcenqu5mE4GNQqRd0jw8vloxsM+fu8kNezqLTqD?=
 =?us-ascii?Q?/UoPuyd+Sie8h4UlxZUjkne5V8TVaHONWkhp4abRAUhL+zn6W3hPUbzEv4uj?=
 =?us-ascii?Q?GZvXD/YRdl6vrc6TCefTUy/YPTvyZodeaBmAFln5T8oa3wJY7gZLcNJ2xYR6?=
 =?us-ascii?Q?kWQ59tGUl/YX5MNqtnbIp0otKkAzYDkO0FPgTgDOgw2B+9xqN2BvVC6g72L0?=
 =?us-ascii?Q?utfcrdVvgiTWo/+QjjWb+gSBFsAjPLWI1SZD2r8W4tt6aH8mPE39KYbBj4D+?=
 =?us-ascii?Q?/+1nPl7psJJb7yqcvSYEjoMuKheRKxDIXj2mCL2XJr3ZX1byMugwuCTlYEAg?=
 =?us-ascii?Q?Pa+ElUfSpwSTHrWvFIlfNFbALgRlcPfZgH3ykx5kisL53UCtydeQc6yC0Epf?=
 =?us-ascii?Q?VBvdG4uy8HgGfozr98oeO7zu4D3PK62wjhxA12goIsVRRV18q0OnvBQhXm2t?=
 =?us-ascii?Q?b+LfMYpp+/gVYp2NHhGcYsKNxrMYKyQZ9SrgUa7gTngzkV9mfAOifhrnVw8L?=
 =?us-ascii?Q?hhjJBMKSe7PdfBIbxbTAoldP1L+M+bvQeyIeDlkyifvoubkqahWZq3C1UYmr?=
 =?us-ascii?Q?D113DuJnJ113AWamwTHPDEuTwCAWmn3a/A5nrQc0O3UWx7oZf714ONG7l13i?=
 =?us-ascii?Q?niJchqhfr3VuES9kpF+Dc5fRNaNNUCW73a/QvBYh797AOmrTZJl3KH0vwQom?=
 =?us-ascii?Q?zvqU6DDjLsWMLteWQc2Ob6NVZ8IybCINVPMTWb/dI/yNsdldi89rSaMpSmiq?=
 =?us-ascii?Q?IqcJMj91ESNtwqm3+kbuJ9/fRJpAkfU5tukb0acBq7TerxSybqnojt+NAupg?=
 =?us-ascii?Q?Gu1rHXbn0GTLn961UcGgWKEjCFR4vffJmVIh0YDCbDL7caJ4vU+wNclRwogy?=
 =?us-ascii?Q?hSGnPYiSS5CBrwc6mp1AND3CtfTMy1xE0XZp5nxyp+9cnn8hEuIz9ZoVGKjw?=
 =?us-ascii?Q?RkFjncXvXLtXfKgYfiClPbs+acokbkUvUZYOXH1jz8y/AoXK5PNofU5ia/RZ?=
 =?us-ascii?Q?TU+Dz6fC9/WnR6kXGTJs/mzm85viYmP2gOcZXqeDCpnweKJr3j6ZBBAa5hMW?=
 =?us-ascii?Q?04FXkv+brjwaORRE7Cl5bh7bfeulvp3F2IBhRfKwQ+l7xod04EXcUsrM20Ca?=
 =?us-ascii?Q?kZMIIo9/4ljycvDBTCRee2PldgzOWGxTiTKXduoV3Z+eocdtIjVdcyNiuDb/?=
 =?us-ascii?Q?THb7/FdnJt/NiWyjs+VPWQziQFw496rS1g4GcNaBDz9D94Nkaz7sRRDu/xlH?=
 =?us-ascii?Q?e1bK5FZww71RZESySPfQGxjJXoCSrcJEFETcoJTGcE5CXip/ZmdCo0zj/2WJ?=
 =?us-ascii?Q?sdlaV1uCCkbWzProB6Gfc+/NTIujBSto5HY2ReZebyCd0rWCtFtn3ZsqGL8M?=
 =?us-ascii?Q?b55pZxXSoTwohk2bX/9NX6ltCWZdy2s4PYcR7BJdgwYqYVYxle6DRxsZU8kE?=
 =?us-ascii?Q?JYF2tL4iweAB/IUa3RMJsRrpi3cw/m9l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:12:58.6890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc87f74-9521-41a3-c4b5-08dd1a070fc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476
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

It's unused.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     |  6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c     |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c    | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c        |  2 +-
 27 files changed, 40 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 8b512dc28df8..d751995dc131 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -89,16 +89,14 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 /**
  * amdgpu_ib_free - free an IB (Indirect Buffer)
  *
- * @adev: amdgpu_device pointer
  * @ib: IB object to free
  * @f: the fence SA bo need wait on for the ib alloation
  *
  * Free an IB (all asics).
  */
-void amdgpu_ib_free(struct amdgpu_device *adev, struct amdgpu_ib *ib,
-		    struct dma_fence *f)
+void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
 {
-	amdgpu_sa_bo_free(adev, &ib->sa_bo, f);
+	amdgpu_sa_bo_free(&ib->sa_bo, f);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 9ec8d5a8e48c..e9e2e107ed45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -268,7 +268,7 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 		f = NULL;
 
 	for (i = 0; i < job->num_ibs; ++i)
-		amdgpu_ib_free(NULL, &job->ibs[i], f);
+		amdgpu_ib_free(&job->ibs[i], f);
 }
 
 static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index ce3314152d20..ab3fe7b42da7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -342,8 +342,7 @@ int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,
 int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
 		     struct drm_suballoc **sa_bo,
 		     unsigned int size);
-void amdgpu_sa_bo_free(struct amdgpu_device *adev,
-		       struct drm_suballoc **sa_bo,
+void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
 		       struct dma_fence *fence);
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 36fc9578c53c..dee5a1b4e572 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -462,8 +462,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		  unsigned size,
 		  enum amdgpu_ib_pool_type pool,
 		  struct amdgpu_ib *ib);
-void amdgpu_ib_free(struct amdgpu_device *adev, struct amdgpu_ib *ib,
-		    struct dma_fence *f);
+void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f);
 int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
 		       struct dma_fence **f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index 10df731998b2..39070b2a4c04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -93,8 +93,7 @@ int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
 	return 0;
 }
 
-void amdgpu_sa_bo_free(struct amdgpu_device *adev, struct drm_suballoc **sa_bo,
-		       struct dma_fence *fence)
+void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo, struct dma_fence *fence)
 {
 	if (sa_bo == NULL || *sa_bo == NULL) {
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 65387f6943b4..b9060bcd4806 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -503,7 +503,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 		ib->ptr[i] = 0x0;
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
-	amdgpu_ib_free(ring->adev, &ib_msg, f);
+	amdgpu_ib_free(&ib_msg, f);
 	if (r)
 		goto err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 96da27b86811..83faf6e6788a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -586,7 +586,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	if (r)
 		goto err_free;
 
-	amdgpu_ib_free(adev, ib_msg, f);
+	amdgpu_ib_free(ib_msg, f);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -597,7 +597,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 err_free:
 	amdgpu_job_free(job);
 err:
-	amdgpu_ib_free(adev, ib_msg, f);
+	amdgpu_ib_free(ib_msg, f);
 	return r;
 }
 
@@ -779,7 +779,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	if (r)
 		goto err_free;
 
-	amdgpu_ib_free(adev, ib_msg, f);
+	amdgpu_ib_free(ib_msg, f);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -790,7 +790,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 err_free:
 	amdgpu_job_free(job);
 err:
-	amdgpu_ib_free(adev, ib_msg, f);
+	amdgpu_ib_free(ib_msg, f);
 	return r;
 }
 
@@ -1020,7 +1020,7 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = 0;
 
 error:
-	amdgpu_ib_free(adev, &ib, fence);
+	amdgpu_ib_free(&ib, fence);
 	dma_fence_put(fence);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 2c12840ea444..121ee17b522b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -834,7 +834,7 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	ret = (le32_to_cpu(adev->wb.wb[index]) == test_pattern) ? 0 : -EINVAL;
 
 err1:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index a5cd950c94be..d9bd8f3f17e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -698,7 +698,7 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c4e15418e187..9484f3b5a9b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4036,7 +4036,7 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 67cd42031571..80aa89bf6b66 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -617,7 +617,7 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 err2:
 	if (!ring->is_mes_queue)
-		amdgpu_ib_free(adev, &ib, NULL);
+		amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	if (!ring->is_mes_queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d0697b0869e3..5e48a56900a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -515,7 +515,7 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 err2:
 	if (!ring->is_mes_queue)
-		amdgpu_ib_free(adev, &ib, NULL);
+		amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	if (!ring->is_mes_queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 1b4c0dcee7e1..f26e2cdec07a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1910,7 +1910,7 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 error:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 17a07e1adffa..84745b2453ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2330,7 +2330,7 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 error:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 576d21858c94..af73f85527b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -914,7 +914,7 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err2:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
@@ -1656,7 +1656,7 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 		RREG32(sec_ded_counter_registers[i]);
 
 fail:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 30d9b6dacb6e..4b5006dc3d34 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1243,7 +1243,7 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err2:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
@@ -4788,7 +4788,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	}
 
 fail:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 3f4fd2f08163..d81449f9d822 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -412,7 +412,7 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	r = amdgpu_ib_schedule(ring, 1, ib, NULL, fence_ptr);
 	if (r) {
 		dev_err(adev->dev, "ib submit failed (%d).\n", r);
-		amdgpu_ib_free(adev, ib, NULL);
+		amdgpu_ib_free(ib, NULL);
 	}
 	return r;
 }
@@ -611,16 +611,16 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	}
 
 disp2_failed:
-	amdgpu_ib_free(adev, &disp_ibs[2], NULL);
+	amdgpu_ib_free(&disp_ibs[2], NULL);
 	dma_fence_put(fences[2]);
 disp1_failed:
-	amdgpu_ib_free(adev, &disp_ibs[1], NULL);
+	amdgpu_ib_free(&disp_ibs[1], NULL);
 	dma_fence_put(fences[1]);
 disp0_failed:
-	amdgpu_ib_free(adev, &disp_ibs[0], NULL);
+	amdgpu_ib_free(&disp_ibs[0], NULL);
 	dma_fence_put(fences[0]);
 pro_end:
-	amdgpu_ib_free(adev, &wb_ib, NULL);
+	amdgpu_ib_free(&wb_ib, NULL);
 
 	if (r)
 		dev_info(adev->dev, "Init SGPRS Failed\n");
@@ -687,10 +687,10 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 	}
 
 disp_failed:
-	amdgpu_ib_free(adev, &disp_ib, NULL);
+	amdgpu_ib_free(&disp_ib, NULL);
 	dma_fence_put(fence);
 pro_end:
-	amdgpu_ib_free(adev, &wb_ib, NULL);
+	amdgpu_ib_free(&wb_ib, NULL);
 
 	if (r)
 		dev_info(adev->dev, "Init VGPRS Failed\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index cc038f300a56..a5bdcaf7a081 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -503,7 +503,7 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err2:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 269bf1e3337b..135c5099bfb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -633,7 +633,7 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index c9ad9ec48688..c611328671ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -906,7 +906,7 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err1:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index defabd163d17..b48d9c0b2e1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1565,7 +1565,7 @@ static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 5e1cb1c2c0f8..4c8308b2878b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1130,7 +1130,7 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 23599a5d4a12..b764550834a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1194,7 +1194,7 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	if (!ring->is_mes_queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 10352cfddca5..b1818e87889a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1050,7 +1050,7 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	if (!ring->is_mes_queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index f9b84359e56d..b0cce5270dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1067,7 +1067,7 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	if (!ring->is_mes_queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 10ddf2c9e1fd..f24f10c6b7b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1064,7 +1064,7 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	if (!ring->is_mes_queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 9f62b2b7fe0e..dbd78d5345a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -286,7 +286,7 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(adev, &ib, NULL);
+	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.43.0

