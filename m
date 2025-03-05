Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEA2C282D3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 03:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED0C10E6C5;
	Wed,  5 Mar 2025 03:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5RdHpQvJ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E9F010E4B9
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 03:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNbVc5gp9sYwocMzZ8URfvR8cPqL6ReHGSCjT9FLjqtmGgCs6+qK8WQJUNh7VGlgf0eyTrQPpiXIK4IlGqI+i6QMg61G/8Av6/p510+5QXWRW/oy+qq7Ur+e/pPzYmppCdjvwLz2NslEKQUva4xRIChnIQdEGhIiDDbj4KwvYrsUK7U5IJImd+or719eAGQPhWzV/4jX/z/raw8aEzwoawIBbp/HlGCgGMDa1GHAzoJl3NekzTxwgkIaOH7b8Ek1mMMRMtFbX6W/3udTxq4zOFoNo/jQwGgPBpsIsIMtpewOc5CFffTgUag+vBsVEGCgz2RwRPVVfMCH4NYkaKyx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uASDiKh2MeO6/3XZ5oBH2FgY/iqyXVGsRSPL07YGTAc=;
 b=yXKFLuKUSLuuTha5r7K1mdu6Rg8DrnN1PMdmCpz/NXkzltyDexJDGJi1wbc7W8Z4j5wTqTbr1FSYWe214BlYPa3TlaJqkVi6qhYi9+DJA7rM/J+A3MEkaHMQsn6IS8eTNJeVomLO89cEOQ1Q6eVaXHGK883KD8ynLyim2qKdBGtMqm9DzhG4FGIpEuYpyE7P3mthJHzOfi5yHo+1/3PudTKy2kSwpJ0ELZGj3XsCt2i7Nis5QeYD16NBeBxdbV9ZpXnrwMhRgUmC1wThuoU0K6p3egIIwHygM2gA/bDPMcxqBvE2fA/PysuufnxkIRVL2PwZmku3kPyisBuRsBexLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uASDiKh2MeO6/3XZ5oBH2FgY/iqyXVGsRSPL07YGTAc=;
 b=5RdHpQvJZQurhQ/kPzG6SznjGgqLKjaiFTro8NA1Y4luh1jHF9VJBPuhyYOpGRYDPJLAfSJxUh6QXwxy3vrIxlWzEo4ou0UmLK7rJNv4V3NamkV4nqWw3hSQZ1zeRxXxmkfG8Aw7v2yoy7pKI374l0RsK2aCoNGtcQKn4dZTbnM=
Received: from PH8PR21CA0005.namprd21.prod.outlook.com (2603:10b6:510:2ce::21)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Wed, 5 Mar
 2025 03:25:38 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::29) by PH8PR21CA0005.outlook.office365.com
 (2603:10b6:510:2ce::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.8 via Frontend Transport; Wed, 5
 Mar 2025 03:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 03:25:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 21:25:35 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 21:25:35 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 4 Mar 2025 21:25:28 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, <jiadong.zhu@amd.com>,
 "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH V7 2/3] drm/amdgpu: Optimize VM invalidation engine allocation
 and synchronize GPU TLB flush
Date: Wed, 5 Mar 2025 11:25:19 +0800
Message-ID: <20250305032520.1745117-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305032520.1745117-1-jesse.zhang@amd.com>
References: <20250305032520.1745117-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: d484f7f9-a116-4da2-c260-08dd5b9565c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oCPrJbm3VwqFpH+2TpABloIUtbrMSiwT0I9i+oY08YCzFSmFQe4C4lUjWPDN?=
 =?us-ascii?Q?sTItVBcNMnMx5mekHiSV9ZpQKRA7tPdKzoyeKDXTvRFHjhfpc8Rbs1HOiTuF?=
 =?us-ascii?Q?/MmWAH5NWUdTQd/4n213mxj9jsIlaygxE++Xq5VoLDs7H84q8oXVabm7XiAj?=
 =?us-ascii?Q?BOg70mvow0lcAjc5g+JzJvaHEBPpXCPgMQCNZfAow2B7YteSavE1XgbETZ5V?=
 =?us-ascii?Q?WP41YsjbPLRKgW3GJIGdP3R5qBXl01q5g9/5U4L74oE32wgTOTSfJUxRGfi4?=
 =?us-ascii?Q?kXz1zIYmrHRf+WMSStjid24975rSoz2+YLsjfnKLYX7dfGJb35S4Rd68UZHv?=
 =?us-ascii?Q?itqZ113o3jzFUz/SfNc9gk8NFsuWpw1v69QIjfI788TpMdFi1hHNBNKjpJuI?=
 =?us-ascii?Q?ZraYMhnoURrGsU1/xk/moRHGIBOGWHmiohgJ6pg3931j+BFaqIh8sLP67z8G?=
 =?us-ascii?Q?i8Q3b1ifk1EjfwTdvX66q/fOjZRHQo89aNIKhPgKSPchd2T4gRWnSODTga4L?=
 =?us-ascii?Q?3u95hTHDLD87LZZL7Ubl6GsK7ozXmJiziziFmhSniRVQgtX3K7Llz6hrjbUC?=
 =?us-ascii?Q?Q9r1TNzjxlCnDQq20256d9uMpLDWEBi8Tw3bMy96cAC7Dwdojoqnd8JcYmq4?=
 =?us-ascii?Q?6rRTlsyNAE8kBkpmw9KYLQANwl8gMpoSRxpOxzJLS7Mdkvw5PlDpZeaJnf+H?=
 =?us-ascii?Q?5b8PeZQ9AoseQc8Iv3DUJU9/aXtUqRM4/ehKTR9QqCTWSzUks1kEAj28GAVF?=
 =?us-ascii?Q?2Db/TDnNZL6W4+gTqeaCahxNOYHpa5IuU8bgcIuAxXd1k4YjiNYVQYv3DRaS?=
 =?us-ascii?Q?7qoxDzGKOtabkvMgiot+E78xS6F6aPzTbaqZERX8J6gFP9npXHTHDecgtVAF?=
 =?us-ascii?Q?T4Bmy2Rk2q/fyFSFllaqxAV3zFUYglKONJBQTzGxp6Q5qWe+S42MN3diA8j+?=
 =?us-ascii?Q?CeOKF/gdyLhMJVN+YFlki56BRHlja4o5VBWuZSY/wid71uYmsEHC+kT/jFeV?=
 =?us-ascii?Q?ggE6ECGSFhZPDrux7FnRqBQNgth6ijFPYvzGWCRVeGTS50mCbHi+ul9zrxJb?=
 =?us-ascii?Q?RF57Rx+JSoXK03cXpWlpc/bLn20VmR6mnr/PMZHHT6e7LhUU+523nZDN5r3g?=
 =?us-ascii?Q?NDHPyANsGbyzZOeuWV4G8R2czEqsUyC19vhARKe7wlxF2A3gCbxwVfhU+fpH?=
 =?us-ascii?Q?J8vFaXrfluWFlET2waNyDGgpzGI8MGRJNiCsubwJRTE73e8hcBCXVxA82xqp?=
 =?us-ascii?Q?AUEnWBPMc+Id6Mq7rUa0HRoisxSRmuEcbEtyD0+tfPOEWY9qtL4xMnPvdYEq?=
 =?us-ascii?Q?BR+2jpP7dEjJw65tsSiqoqv7LXWMsCQ+DLZdhdcS5qbWlucxcz90Q1Ir4Eyq?=
 =?us-ascii?Q?uFGOe2RXOU+bls06w+EIgydxmq7UH8MVKMB+XL0MqMZqmd0XEfujMRB1sGCt?=
 =?us-ascii?Q?Srq1U43qfsr+fOImZ/ovmO9CBgTn49KDLJSxTz+HtYuclZmXBTvmbOQRhv4T?=
 =?us-ascii?Q?UPN/SNa/30lTVCk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:25:37.0211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d484f7f9-a116-4da2-c260-08dd5b9565c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

- Modify the VM invalidation engine allocation logic to handle SDMA page rings.
  SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
  allocating a separate engine. This change ensures efficient resource management and
  avoids the issue of insufficient VM invalidation engines.

- Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
  Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
  during TLB flush operations. This improves the stability and reliability of the driver,
  especially in multi-threaded environments.

 v2: replace the sdma ring check with a function `amdgpu_sdma_is_page_queue`
 to check if a ring is an SDMA page queue.(Lijo)

 v3: Add GC version check, only enabled on GC9.4.3/9.4.4/9.5.0
 v4: Fix code style and add more detailed description (Christian)
 v5: Remove dependency on vm_inv_eng loop order, explicitly lookup shared inv_eng(Christian/Lijo)

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 31 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 26 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4eefa17fa39b..35cc45f4fd88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -571,7 +571,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
 	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] = {0};
-	unsigned i;
+	unsigned i, j;
 	unsigned vmhub, inv_eng;
 
 	/* init the vm inv eng for all vmhubs */
@@ -602,6 +602,35 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 			return -EINVAL;
 		}
 
+		/* SDMA has a special packet which allows it to use the same
+		 * invalidation engine for all the rings in one instance.
+		 * Therefore, we do not allocate a separate VM invalidation engine
+		 * for SDMA page rings. Instead, they share the VM invalidation
+		 * engine with the SDMA gfx ring. This change ensures efficient
+		 * resource management and avoids the issue of insufficient VM
+		 * invalidation engines.
+		 */
+		if (amdgpu_sdma_is_shared_inv_eng(adev, ring)) {
+			/* Find the shared invalidation engine for this ring */
+			for (j = 0;  j < i; j++) {
+				struct amdgpu_ring *shared_ring = adev->rings[j];
+				if (shared_ring->me == ring->me && shared_ring != ring) {
+					if (amdgpu_sdma_is_shared_inv_eng(adev, shared_ring)) {
+						/* Assign the shared engine to this ring */
+						ring->vm_inv_eng = shared_ring->vm_inv_eng;
+						dev_info(adev->dev, "ring %s shares VM invalidation engine %u with ring %s on hub %u\n",
+							ring->name, ring->vm_inv_eng, shared_ring->name, ring->vm_hub);
+						break;
+					}
+				}
+			}
+
+			/* Skip further allocation if the engine is already assigned */
+			if (j < i) {
+				continue;
+			}
+		}
+
 		ring->vm_inv_eng = inv_eng - 1;
 		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 39669f8788a7..f2b8113d5279 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -504,6 +504,30 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 	}
 }
 
+/**
+* amdgpu_sdma_is_shared_inv_eng - Check if a ring is an SDMA ring that shares a VM invalidation engine
+* @adev: Pointer to the AMDGPU device structure
+* @ring: Pointer to the ring structure to check
+*
+* This function checks if the given ring is an SDMA ring that shares a VM invalidation engine.
+* It returns true if the ring is such an SDMA ring, false otherwise.
+*/
+bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring)
+{
+	int i = ring->me;
+
+	if (!adev->sdma.has_page_queue || i >= adev->sdma.num_instances)
+		return false;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+		return (ring == &adev->sdma.instance[i].ring ||
+			ring == &adev->sdma.instance[i].page);
+	else
+		return false;
+}
+
 /**
  * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
  * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
@@ -545,7 +569,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
 {
 	struct sdma_on_reset_funcs *funcs;
 	int ret = 0;
-	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];;
+	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
 	struct amdgpu_ring *page_ring = &sdma_instance->page;
 	bool gfx_sched_stopped = false, page_sched_stopped = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 965169320065..1fa2049da6c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -194,4 +194,5 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
 int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 #endif
-- 
2.25.1

