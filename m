Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79317C021AB
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 09:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1294610E4AE;
	Wed, 19 Feb 2025 09:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0yQxvJom";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1581310E4AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 09:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwLYpVrIB0+m5rFz5mr2s1iticfV+4z1odwAQNLoT3zDYJ4CNglRCSEGyQJIKKsCv0R5dSinzuL/9mzgV1IgvVcCBUMBTUq+zyLorCr/hdrlHq3yWAarLn2aczf7CaPdKRF+OOKgcSOnAGBa7nmVli0R8DEltFvL4fbRWY3W8rR48SL8XGDLW9vg3jQ2z2txa1b6W+AbvgMG/S7f2962eaPxJ9+3vBR9JIVJ2Exd3G3IHBI7QwMBmywRu+xQCK45wtruzzH+AqH2yI0avSKEc9V9Q8Ay6pFH3fWmSvM9LKTrbKt0YX/4vE02ZElpVKKxV45DwowiXDONTOGFLlMFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZxEQ0/Mico0IUJe7ax1vxXThKXzcD9QM1b8seiM1ao=;
 b=s1SIl9K7eWDIA+7pkrIOCKbxTf7nq4ev5RWRghsR0Q3bhxUCDxt+lckjDhSMKdLlZk8seYoX+3fqiDl1gVAz2/iwJ7XAv65dEcl1CpXH65Yz/pcAWqJyuBMqEIW9JAkZLuRADCWvPDujKIte0JxdErnGPRsOmY+1Ud5p3E5GUmQDRDWPye16w/eiZ7WUn9WTKWEjMVoX6dveNjywWN46A//BTwCyqHxnjy2tYvryeRTt4lxLMHelFh4fo0oaNTRfate2ub67Ycilv4TOQeCZUH+DHkbNpS/1mqHefcBgLTXwFREkEtdUzwOu5tYNaiBbUf1RdIcFMB84V6kHK3O1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZxEQ0/Mico0IUJe7ax1vxXThKXzcD9QM1b8seiM1ao=;
 b=0yQxvJomc4ylqL0DG1Ij4xlIrJxKJfnfQx+slrDWlzy4Qr3hwQJrj9ki3mL+EjvO1gklcafOw5rCaGBTSjp+9w6g0qfGdpI4W4RUMahupzC+2hFCaFlJz0ULLP/Z5VuBJULq+zF0COARIwoD42JXSYb26YTamX+p7BEepexdkIg=
Received: from DS7PR03CA0153.namprd03.prod.outlook.com (2603:10b6:5:3b2::8) by
 IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 09:05:13 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::1) by DS7PR03CA0153.outlook.office365.com
 (2603:10b6:5:3b2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 09:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 09:05:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 03:05:11 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Feb 2025 03:05:10 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Optimize VM invalidation engine allocation
 and synchronize GPU TLB flush
Date: Wed, 19 Feb 2025 17:05:09 +0800
Message-ID: <20250219090509.3559015-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: f0adb8aa-3867-4bd6-399e-08dd50c484f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RbfeeXemuWjkF5mtojdjU5mh2DQeF4zZobf1PkiheIbeauk2Cu+j1sDrJV1J?=
 =?us-ascii?Q?spiu6PHuCofGBsVzegem4VWAEyBHjTG+9qWwHep1lBzyB03Sy8GZIOyYk7MO?=
 =?us-ascii?Q?AY3Qb2cGDtNaJ51N3N52KC6IV0FHgwlgOEnJUC8cLgpmXBPjzr7SOK3DkikD?=
 =?us-ascii?Q?E79dgg8Uq/5vZ/A4eHmJYpuvmuUPimpDUrdKmSgbbFuMd12jypwRrL3BVMuI?=
 =?us-ascii?Q?v99MHvGsXjp2r/qYyOR36FJWF5B+1fAfHaxydwYvkSa1mhXF7p4mI6I6pA2z?=
 =?us-ascii?Q?LFqRCK7rVxwVLXrnOpc4gqasiTiHp3HDn5oSHlORg+IGd0/giHWtvwb3D/0+?=
 =?us-ascii?Q?5pxgxsvoIlyFC/BU/Pif/HF7tPAbmORzZAL6qX8gAMOx778LVMUBYqJNtTzg?=
 =?us-ascii?Q?SNR4WU/lmYwVQaFsYF91fTRtgU0nWgRrUgjuJ+T7r9tUUL7hvHIEkByNx3cE?=
 =?us-ascii?Q?jJ7VZ6Du/agdUdP3Ij7aVeQFXIUn6XEUsmyPCk3cEiINAXk2Q1xZQH8UbQHd?=
 =?us-ascii?Q?8lYYGZP+IKZie0OF6rPDp8jRHxgtKgASdpWtgfOxQW4ophwOhORrU2uZV0ZC?=
 =?us-ascii?Q?fbmSwgE05cbrqagSlger1GTjCEgi4gJsgkhGP9kX+I4e4vAgd7uxdvUNK6Fr?=
 =?us-ascii?Q?595nTvwq5QrUSkMlEBAkW9+P4KhfoTBNEOSLbnAxBeOmM0FqN+2iG3ctKWNk?=
 =?us-ascii?Q?+4BQ667acTumGCSiMQHHzc86knlktgpN791RcKt8CgSJ/nr1WRp450gXhLlJ?=
 =?us-ascii?Q?E/cxtzkrpkcvRyzdqfP5Mga0KTJ/sqO//4yPF3jI561v9wQup16p3JyoVBG3?=
 =?us-ascii?Q?PGlf7DzbyHxACu9XBnqLc8rd6cgNWK37SY63zDjX19ufusgYUjhXwGXska70?=
 =?us-ascii?Q?CDTKYUL2pxioPfogOBKofjyx/3U6edqFOC7taVAea3HCCgKdWQAvmMD4TCVT?=
 =?us-ascii?Q?946FqZiIux9KwZ6BQ33rEeLUlQVtyVfg2j10jjCoFIiIKdBT6Urq6HgvbA5T?=
 =?us-ascii?Q?JAcUJMAztcKiUTJQxFxBG8McvPZ8Xvp4m9b9GAMKGxkpJSfRhKuS3o777nqE?=
 =?us-ascii?Q?mhI41t70tkTa5+Z66FoYZJVMjfx5Aj57daI+k0VEH9g4wMl2zMx71aB0SKDe?=
 =?us-ascii?Q?OOJ9gIB8HozM6pj7EpB2b7VQP8JLHmjwR4mFHa0mgJcKm259OJNyn7hsKxbX?=
 =?us-ascii?Q?k+kdiYGQHzhMWsWikwOElTM/UrGoni7JgltFIC1WS49Rw8KHeol4cl1BmGjH?=
 =?us-ascii?Q?bT+LDEiLkf5XoBYPw3l2cn1dLgZwlx8MENliAHj+0ymHddzlJqzPz8lgpIYg?=
 =?us-ascii?Q?gRNR+x853Lh9wwfgX3X13sbJY5Yv/S9ZOsKSl5+3X3wuCsrDmBv6YierBe68?=
 =?us-ascii?Q?STP60pq8yU7zn55+C/LIAPmB6fhE/WstlxHx4DQT0y6QPDKbPUTa4yBeiEOR?=
 =?us-ascii?Q?eg/ssTJZIDww4Z4DEW5d7T9wG8kf+5TgvmuCUUeNitmCZfg69UBIyX5Qvjo3?=
 =?us-ascii?Q?lLzM2tKtazlHRaA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 09:05:12.9351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0adb8aa-3867-4bd6-399e-08dd50c484f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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

From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>

- Modify the VM invalidation engine allocation logic to handle SDMA page rings.
  SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
  allocating a separate engine. This change ensures efficient resource management and
  avoids the issue of insufficient VM invalidation engines.

- Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
  Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
  during TLB flush operations. This improves the stability and reliability of the driver,
  especially in multi-threaded environments.

V3: replace the sdma ring check with a function `amdgpu_sdma_is_shared_inv_eng`
 to Check if a ring is an SDMA ring that shares a VM invalidation engine

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  2 ++
 4 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index cb914ce82eb5..8ccc3fb34940 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -601,8 +601,15 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 			return -EINVAL;
 		}
 
+	if(amdgpu_sdma_is_shared_inv_eng(adev, ring)) {
+		/* Do not allocate a separate VM invalidation engine for SDMA page rings.
+		 * Shared VM invalid engine with sdma gfx ring.
+		 */
+		ring->vm_inv_eng = inv_eng - 1;
+	} else {
 		ring->vm_inv_eng = inv_eng - 1;
 		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
+	}
 
 		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
 			 ring->name, ring->vm_inv_eng, ring->vm_hub);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 8de214a8ba6d..159ebd9ee62f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -503,6 +503,24 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
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
+bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring* ring)
+{
+	int i = ring->me;
+
+	if (!adev->sdma.has_page_queue || i >= adev->sdma.num_instances)
+		return false;
+
+	return (ring == &adev->sdma.instance[i].ring);
+}
+
 /**
  * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
  * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 7effc2673466..da3ec6655be7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -194,4 +194,5 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
 int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring* ring);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2aa87fdf715f..2599da8677da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1000,6 +1000,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	 * to WA the Issue
 	 */
 
+	spin_lock(&adev->gmc.invalidate_lock);
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
 	if (use_semaphore)
 		/* a read return value of 1 means semaphore acuqire */
@@ -1030,6 +1031,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
 				      hub->eng_distance * eng, 0);
 
+	spin_unlock(&adev->gmc.invalidate_lock);
 	return pd_addr;
 }
 
-- 
2.25.1

