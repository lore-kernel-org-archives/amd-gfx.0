Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4AAC021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 08:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A430C10E479;
	Wed, 19 Feb 2025 08:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IzjdPPuF";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D68110E479
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 08:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjfvqYFramaGpG+2j8T7yTGqLJ9dCl5Avo6T0zozqUrSuK4+iFvSEQHzkw6gTKrLTQL3IW2VXGW75sTRLlaXT4xSg2/3rZdYk0kKLvtic0/DJlRueJhE6NWZhNyseCl2qoE9XmSgSP9UiFIHhvtiKziWLQHAGc1bVaTjwkwPU8rOtj58pLc1c+VBF5JpOiTV0VEBTo0TKruF5ZOFNpZwWKafjX43ZtRElqzOAkriEt0N5iFHEPGmlHaDAd5QFLeJe8Yvaa+oy3rruRyZTI+GZRBLXiCs31bl3ZPA705eTYuCjQ8Bj++aOE+pQOylgfGosbxCrXW6FnShiIw+QPdZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1J0HeOcuc7sDeQGe8t3Xpfk3DN9cckqssd6XNJOoBZw=;
 b=G5I90hWqo2ppXplRB4g+esqOUe+xySaccjzpkOcY+YEqbvPPCuMUZ4yBWj5Cy2OrzcrLmKjLffdHZLtimaYSoug39HQeZC2AAu6T0/uUqmMW4K07RApfmuuJymWamdFyK8MLrL3S2nge1BC0h2Vy1DmAPSMoj+f3tQEvo6HEF5sMNjdoWZ4fOlGXjn8Wsq/tT/hi5qP2u66F03AusSOrVRR3hAIbGMlou34rDo5mjC/Z+chs/3d7P7+45Vmi3gBqLtitAV4Y28C8l53xhUKyM52KpSy5DgmpPwDySNOROGZBGPokvbSKtEHg5s/LXgjOJsxEsaqxgn5BBNuAKDZ9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J0HeOcuc7sDeQGe8t3Xpfk3DN9cckqssd6XNJOoBZw=;
 b=IzjdPPuF+0jeKg6X7EuQXLe44CR/6YpQYP/Htv2WWJ9RUMqS1y87qaHegnX/q9dIeO0Kqmg+bUzkrzbzUAv6b0Nys6OOEPcG4/YhcWLk/NDgW3ia5NSmSjbUl4MGMEwTclsTY/KvrF+TgVgQvy4/AzNzNeDJSvljuLkTSSe8TWE=
Received: from SN4PR0501CA0050.namprd05.prod.outlook.com
 (2603:10b6:803:41::27) by SN7PR12MB8169.namprd12.prod.outlook.com
 (2603:10b6:806:32f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 08:00:46 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:803:41:cafe::b1) by SN4PR0501CA0050.outlook.office365.com
 (2603:10b6:803:41::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 08:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 08:00:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 02:00:44 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Feb 2025 02:00:42 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH V2 2/2] drm/amdgpu: Optimize VM invalidation engine allocation
 and synchronize GPU TLB flush
Date: Wed, 19 Feb 2025 16:00:40 +0800
Message-ID: <20250219080040.3547468-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219080040.3547468-1-jesse.zhang@amd.com>
References: <20250219080040.3547468-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efff1e1-85eb-4e3f-4a37-08dd50bb8389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ldKa+QVvKgKKXuvRgyFjsqf77/MADg9NoEqJFtWo/21ToSwc+2twJPMhek8W?=
 =?us-ascii?Q?I2rwYK6PSDCdsF/n2wZwUW3vwWxaa43s7zMWw6kVDM6KSf5r/XRQbILWeWmH?=
 =?us-ascii?Q?BxesvZ5tJuJdn497c8cZEi6MjR9Lu7vKFaMpq3ky8oaAPnCTeN8MNS0cHQWg?=
 =?us-ascii?Q?NJyU50YVp31Dt4S6bcARnzu51Vw24u/VynukAbniN1zhv4ikO/ArVJcRy0wD?=
 =?us-ascii?Q?eK5Utxisu7qnzCIS49e/Ns1VpHNKkH9OeR8UTEvBOQD4GZKx9pZip60sIAT/?=
 =?us-ascii?Q?vrfkjfGYuHAhYxMWk4J/ew+UjaLLAoTNXw0Jf8OjjJvFh+iYjUSfDiUKNdVS?=
 =?us-ascii?Q?pBai/AnRXM1sAmAsyPtEK3khlbXx+qmVvfoluKLSjy4DuWwTQz3ImpwMVJyE?=
 =?us-ascii?Q?kgSqbbnIlchkKjM3FUhPPbzJDLK77xRHqKNxerdwU9DueI829ohPgLQRUuGZ?=
 =?us-ascii?Q?Nuiwp5wVrzR/nmc+AK2WhJG/axNiQ0zVvET6MBM4dlC9HGhUW5EGz2ke7Osf?=
 =?us-ascii?Q?2FA6FFf0rzj8C8WqwyI+6xNX7iCQLVgjJdZrfpJVkUS3eZh2bqTLxxfG/0d9?=
 =?us-ascii?Q?v1tditQBbFg91z/eHDfMxfkJu/PtNOOI1EZ5wDLHWNlmK7tJbSsHfK+CI/kC?=
 =?us-ascii?Q?i/dyKP23N4ao7yFUmS+Z0BJX+iNj11yQ16mlxU+lO91gio6ReNJl3J0Eb4MP?=
 =?us-ascii?Q?DwJsk++zMbzWpteR6m6OzY6fU9FnuD/q8znPiPAUhnYumGuQHHgtdxUhtkNI?=
 =?us-ascii?Q?f0yLVceTo0T64TDQPJm1GlWB0EwndvWek+Q9Nzumw9q3VlKOw2MG44SU1lhS?=
 =?us-ascii?Q?R43yyamODv5FISJdzpqLh4hKo+cKuhUe7bYZSiB9inFr2Sul7MQUEpZdQ5bA?=
 =?us-ascii?Q?7Tu2wqDtjLT/KhShhOBVhEkkeIUyBhf69WkMc7FeQo1hhaIEolwXTokQbOSk?=
 =?us-ascii?Q?6TJayP6+qYO2rnUTh+egRb/om7GP+CI9riif2GGgnQUGWj0YcbpaXb9I6M5d?=
 =?us-ascii?Q?a2xZQdRvKFotDhB+XVD9zr2eyC8VqVBKldeqOubgshZr2gODMid5w1c5cqSO?=
 =?us-ascii?Q?iquCdj9CjxToIh6rzemKMQ1f2RSqLCNfMkVtbEVfRrMzBQAYm3sUIaTwz7kG?=
 =?us-ascii?Q?P/U/Vc41gJjD748492aUFjDLokAHkG8dT3DhO/xdi0ao4/q+yHFwcsMG7JcN?=
 =?us-ascii?Q?LIbWixHPjYja9fQwTwgOpWqL667qgx0/sCyLzMTRfOL/KgV8dab4Xhd4yFQ1?=
 =?us-ascii?Q?B++umNOpW2kL4IIH7zZp/xkU1Pj+xedeayoTGvtCn7RQayTsDv26T4paiZnV?=
 =?us-ascii?Q?sfSrf2IeCBQ0xbcELNyEi4x6m5qRyoO2o3mbcp0/52Kwd8pJo4dEnLHwdzXz?=
 =?us-ascii?Q?GobLzHpCHx0sQ5NjtNbW0fWRDrWvSck+g09njIv3OLdwhi6u5rVDuQ0viBIw?=
 =?us-ascii?Q?NDGANn/IQZ6xak7Of3tdc0ghNMfksxlxZjy+a8wSm0wtbXiy6dI1Bsgz7hk+?=
 =?us-ascii?Q?l8FnF4Dmtw85dNM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 08:00:45.1460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efff1e1-85eb-4e3f-4a37-08dd50bb8389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169
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

 replace the sdma ring check with a function `amdgpu_sdma_is_page_queue`
 to check if a ring is an SDMA page queue.(Lijo)

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  2 ++
 4 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index cb914ce82eb5..da719ec6c6c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -601,8 +601,15 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 			return -EINVAL;
 		}
 
+	if(amdgpu_sdma_is_page_queue(adev, ring)) {
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
index 8de214a8ba6d..96df544feb67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -503,6 +503,24 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 	}
 }
 
+/**
+* amdgpu_sdma_is_page_queue - Check if a ring is an SDMA page queue
+* @adev: Pointer to the AMDGPU device structure
+* @ring: Pointer to the ring structure to check
+*
+* This function checks if the given ring is an SDMA page queue.
+* It returns true if the ring is an SDMA page queue, false otherwise.
+*/
+bool amdgpu_sdma_is_page_queue(struct amdgpu_device *adev, struct amdgpu_ring* ring)
+{
+	int i = ring->me;
+
+	if (!adev->sdma.has_page_queue || i >= adev->sdma.num_instances)
+		return false;
+
+	return (ring == &adev->sdma.instance[i].page);
+}
+
 /**
  * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
  * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 7effc2673466..c2df9c3ab882 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -194,4 +194,5 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
 int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+bool amdgpu_sdma_is_page_queue(struct amdgpu_device *adev, struct amdgpu_ring* ring);
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

