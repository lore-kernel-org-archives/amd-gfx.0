Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ECBC282C5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 10:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B96C810EC58;
	Fri, 28 Feb 2025 10:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YQU6/y8V";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A8510EC58
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 10:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsDczUDQgUyadkERgZZ/sdaE08eebsUrwt82SgeMmBdVljotQ30BUKI6WI+euqiXGRy0/d7RySPqzOnGC2/RWsUYK527RMUQb23vmzLE9a6I/tQCFPz2smAEcEM7hfEQ9K8HqwwaCPznZHOajVj+EyqX7LgLhokt4b6VwHS2ZB2tGafButYHeCI9/ypGxSlfPqcD8b1T7fP5FsnQVw2RqyWp+5M/f8opFlCV2IhEjRuqOhQNQXx1Iy27RMF7pF8e7S31Dr3nOyt2fb32D33tZ/9OWKPMl5G2p36LyUUMWisSZmMqQt+tbIje2Rlo7QRPIRBT00526/HQWY39UD5xQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ep/SLRXpen/IGOPxg8+xZuxjxXapt88XwUaYcpl1Y1o=;
 b=EZPA4ov6RewytEgFPl4o7j79gKvUdwwD0qeTat4DPB5iJgADEmutHUSvjRY0GclJYyYlZfOOtXfZLVr9y/QsdCs5J6AhTJb2UD8K1Dj4Mx1UxVgnn9EovkIBCLzmfQfdvHVzNgBnW0Z/iMM0zauKD4Dpej7MHSeqAAZEmuxf1sRL+1i3rUhw1YsHj2w8+c4O9eZBp5TI+l8HGkHHC8jQQs3T3ff9KgOKwCUb4psLNriCJgHuxVssm8L3yjNGmshq7g637mHyvwsj4glzB0aYKq0rfbKaH/UYqfQ0PpaOM/cP0hmcpBP/Ez0zPhq1swZL1qJ0S+kIEHZILDBAkznUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep/SLRXpen/IGOPxg8+xZuxjxXapt88XwUaYcpl1Y1o=;
 b=YQU6/y8V+XfJrX4hkCCjeAwaQqaV2kYDJQ+ItThFk+Kqa8etHPjPBxKRU/Ln9GqZjgjGefDczxkzVb0IsiKsHtgGEFuH6JT0q+yOJPQc/NqLspm0Mz0vraN78h5S4JaYMaXRekh/p9MARE+Xyd0wjqcDRVSC7Om9z3nstZHSycY=
Received: from CH2PR18CA0042.namprd18.prod.outlook.com (2603:10b6:610:55::22)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 10:27:40 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::2e) by CH2PR18CA0042.outlook.office365.com
 (2603:10b6:610:55::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 10:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 10:27:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:27:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:27:39 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 28 Feb 2025 04:27:32 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH V6 2/3] drm/amdgpu: Optimize VM invalidation engine allocation
 and synchronize GPU TLB flush
Date: Fri, 28 Feb 2025 18:27:10 +0800
Message-ID: <20250228102711.832036-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250228102711.832036-1-jesse.zhang@amd.com>
References: <20250228102711.832036-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c90b57e-386f-437b-f509-08dd57e28792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y/gIS02eF5YePYaq2GbrGb88eaNcpzagSgZBoxgMi7bo6Pa96gGv0DvfUTuz?=
 =?us-ascii?Q?deNP7Y4yj5rztKz6DLitEmBmylAdJm46GMJNO1NhaytGeF0iSjQnQqe9AaAU?=
 =?us-ascii?Q?Cp3AmQcETOEArz2dklpUfdUNQeQt7FYxXTsLL/zG3iKgTJuOkDA7Fi2w7wOw?=
 =?us-ascii?Q?LebFr3703NzJCu4OQWMFFyo8EUDEGuE0P15kxHHbd/IhXG2uZ2nnSKsXOoJW?=
 =?us-ascii?Q?Dk6vqHZ/kn2M3cr9FtXQj8N3xsmLm59wAZBmBfq97+X7Jr5y9lkG7HC378F0?=
 =?us-ascii?Q?2UZFWasO6p40ldONXEu5AzV0EbQRm7QFmuFjlCft8HzTcQqJ0twMCKi72mXc?=
 =?us-ascii?Q?LyumFwu1dUVvfPsO7zCpeWYkKRluozM19TJqSFkF0Q6hApsWkUfcsJ4sPAum?=
 =?us-ascii?Q?SFKDS0/62jVFrSKQhfNydS5d1BEyDBaL15s02kAYF+CTYhA8244eZr6LJpj5?=
 =?us-ascii?Q?tc2QM5yyELefOmAOKl6qOVbwMtWjB7hLy9FD5swRAzkh7I3it1ctTh9m5K/N?=
 =?us-ascii?Q?hNk/IEOJ/JMjRGOwhmUEk84LdKq5PCdONjEqZal65W+sT0ew9MZb0KJe4z5m?=
 =?us-ascii?Q?wN8uCfrYS2u3t0KMtAdcYWYkGxVjXEFvhg8uNfaDbBDr+DU5O97JG0VNvRs2?=
 =?us-ascii?Q?EioO8aT7k4LtZ5GzpUTIdMJgf6XWC1TD36hIpxQG07JTHH5Sw/zUGptzEX5P?=
 =?us-ascii?Q?TvEFZIRlOtjY3zgAj89t1t/FBhGGDVh0Zia8FwcndTmpy4fYochAGS7+YHXX?=
 =?us-ascii?Q?N0NS1eRWH20hf79Rs0cPhOSTsJH2eXhPj33cpR6xTJBMZigpGv2MZTHc07Px?=
 =?us-ascii?Q?n38a0gTYCFQ4vAL+YfwwSDFt1hLyKfwLXYDtkAAeu5c+hNAC08l8vI2xnLAf?=
 =?us-ascii?Q?0tP/yx0IxHAZRN6AKumB3rT0mh0E2i+8W5YXTiLPIaBWdZheSLCoHzeQV+PH?=
 =?us-ascii?Q?O+fEnhajt/dyIOV233jTpNGEg7WJUcrOdlRHb0vmjRzNuM0yMnOZ61If9/xT?=
 =?us-ascii?Q?bq50FWHgQ+M56n9xxDAupcqFri6qXuIl+MHSQtqi4x5C9TfCLNfEkgbNtuNP?=
 =?us-ascii?Q?A/F0RWR9QALwbBIcZL8/5CrgRA7yD7W3IEep79rfXtSQgzzISHfrYK6wzFgw?=
 =?us-ascii?Q?QQdbBSNjZVCwUMuhrnhMeZoNXYP9/ZeP1b/tfHqCKJKbypy9i1dmOfLju/xR?=
 =?us-ascii?Q?vSILqrVI72d1pZDfsmuhTxaOwe17Cl81JaguWIk0CFSI2sU7YWmzoayBw3GD?=
 =?us-ascii?Q?f7JB2Do2GIClg4/g3Jx0anuWp7H/zG/z3cZtAxWIXxh96Ez+JCb0pao9Bni5?=
 =?us-ascii?Q?wboi4a+V4k84W6tLEGtYN7Y69S2CFW9/NKgMxaqVjSPXwUXKrFhwzK0qmRbR?=
 =?us-ascii?Q?tNxL/BiDDabHTCbAgOM4lPAB0QMvl/7IQC+U/PcbfmiCcuhWOJh8xQDElF+y?=
 =?us-ascii?Q?kFLy22bRqbJwZUzx+xHxBght6Q1leWLsB/0txBbMoEpysBp5HxJOmiBlgQuc?=
 =?us-ascii?Q?jcSyxOX1rNh0VVA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:27:40.4477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c90b57e-386f-437b-f509-08dd57e28792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340
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

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 25 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4eefa17fa39b..aad3c5ea8557 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -602,8 +602,20 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 			return -EINVAL;
 		}
 
+	if (amdgpu_sdma_is_shared_inv_eng(adev, ring)) {
+		/* SDMA has a special packet which allows it to use the same
+		 * invalidation engine for all the rings in one instance.
+		 * Therefore, we do not allocate a separate VM invalidation engine
+		 * for SDMA page rings. Instead, they share the VM invalidation
+		 * engine with the SDMA gfx ring. This change ensures efficient
+		 * resource management and avoids the issue of insufficient VM
+		 * invalidation engines.
+		 */
+		ring->vm_inv_eng = inv_eng - 1;
+	} else {
 		ring->vm_inv_eng = inv_eng - 1;
 		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
+	}
 
 		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
 			 ring->name, ring->vm_inv_eng, ring->vm_hub);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 42a7b86e41c3..9b958d6202bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -462,6 +462,29 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
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
+		return (ring == &adev->sdma.instance[i].ring);
+	else
+		return false;
+}
+
 /**
  * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
  * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
@@ -503,7 +526,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
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

