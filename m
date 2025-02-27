Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75B9C19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 11:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDAE10E23D;
	Thu, 27 Feb 2025 11:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g4KbrjNz";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F7210E23D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 11:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pa3bVFAGryvDKLGHtbGtrv4TKmohNcVHlByRt/fQEpoWAlF8K/JPDeItlflT8DP+gQ9Cx3MoA8VbbtNQCwbJBVDpd16byGbv5rmbLToeFLikvatPLbYJX3rqUEp+pkmxOFXjJOCfl8SVn7Sb98BWhxIkU63ycthUwzvKZti9c1vDjmWGTDm4CFhRgWitIfxj0Uaw2YmoU5JumC8G2JjEb6BJT/8alb5+u67+7oB+Y7zXNJeTGTFw3rFBYqkYE+dEpOgQj8ObXKAxP7JibwTbE5EguGXfuDIDB3j3KKOkDh0vD+YXSqlW4BiSCrrt/MoYOcA6A2CtT8CQF8kAo+dxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxTyybaEjQ0Ic1tBVusgiGE7XE8n/tr5R9UFo2lW6+Y=;
 b=bDMDlp/KX3kQXq678/C5zagTwL460GM6QymjNDeeyFZAgdtuUM2FjURmIXkJ4aQxYcHuyrBlLUydx9WdZc+DRpV6qxgV0HlqhYit8M9ZxYyovNZRKR61FuEqOtdUhLoilgSGpszPWrwDGnbFnmumiogTxqASLfI+D2VYmYqGRMVZtiGr1ruOwM+kTgcRHzcLtKWa0Zl525JhZIhUNxAtMP9eUyJFgoCWdJ2AJ0/mg9eqyg32GwfIMRazSPVK5K1ExXWtQUS4ubK98c70MERQuKr/arA4jbEOZ9nzvwV9hT9l/6Bj217ju3GinYRw1NLR9bgf8m3t4aMgRJt4ai30PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxTyybaEjQ0Ic1tBVusgiGE7XE8n/tr5R9UFo2lW6+Y=;
 b=g4KbrjNzDyBmJlrEcj5cIJ9Wxxh78KD7WoLWGB711fWYfrRrW2ZeZtdYDrP8a6VZyxIzsJ90HzKzCZXcD/ycpirfuR6n2at1hKkV5rm/rONs36QwtCvDlnMhtiLWozD9LgtoGymnot5JUMvxLDCLCis3PW6QmCGoHo3o80i58XI=
Received: from CH2PR07CA0055.namprd07.prod.outlook.com (2603:10b6:610:5b::29)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 11:48:39 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::7f) by CH2PR07CA0055.outlook.office365.com
 (2603:10b6:610:5b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Thu,
 27 Feb 2025 11:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 11:48:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 05:48:38 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 27 Feb 2025 05:48:31 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 2/3 v5] drm/amdgpu: Optimize VM invalidation engine allocation
 and synchronize GPU TLB flush
Date: Thu, 27 Feb 2025 19:47:54 +0800
Message-ID: <20250227114755.444535-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227114755.444535-1-jesse.zhang@amd.com>
References: <20250227114755.444535-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b398a0-a089-485a-ac87-08dd5724ad1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oydxrou8NDnx91Z24jVnW80i2nmDBIGUtQATn+nwjM12K+KdBDBVPtuG+w7F?=
 =?us-ascii?Q?TH2WBpyp1JAQVQdpLIGgbMbUdLhN26G8LzXPu7oTxGRdY0RyH91J3Krpsi97?=
 =?us-ascii?Q?pdsyZs0/HKwuCnuJDvdBwn/L4abxk1gORAXLOZez96kS7SUD+fCKG+cF/2el?=
 =?us-ascii?Q?9wN5M7AEdlUmJnY9McdLze1C+I55HrV+tbj0qF/kPrL2YpK4cJyYWzaupeUs?=
 =?us-ascii?Q?wFkx68E+b1Yv+1PXkYRNq9GfjDZa9bOYAcX+HakO61A8698x8h/vQPJsSIx0?=
 =?us-ascii?Q?A+hfSPjPNO6kewZIWA9TGIBWmWFwIfAAI4b+9B4W/Q7e51u7dggcKQiJ/NNZ?=
 =?us-ascii?Q?QLWTxXNFvBQJOmbaxmB80s2fjs45zyl+1W3gaDZaG/RYA4GeigoArjEoTbeh?=
 =?us-ascii?Q?ayRrsrpPoMbokAwZXBYMUpFimSkVLNom2reEaca5yiBwFMNJosQftjoscFdO?=
 =?us-ascii?Q?OpBAVHA9Q6YvJ10WzO/RCfZvyCVAIkDsAanuQk8q81xDbAX/c9nl0rNeCvwr?=
 =?us-ascii?Q?oWP4r3PQVHHcuUeO5DGNGHOKcDi6GQYDCfuD5vvqJblRBmWqkZrznzLDC4Y6?=
 =?us-ascii?Q?/LRHJ7As1eXBws6Xw6W7Dv9kh37wd7F1C7+uHsaRL52+Q977zj9ASweHwhXl?=
 =?us-ascii?Q?K+qw103SEzuuXCxFg6W+RjgV3OFfZS8hAu3Bdn/mjIBExPCdhKw8lna/f3BB?=
 =?us-ascii?Q?7Uj28F8okkuaV2Ay5LkGVjIMnf3bqRNqCKLwc+7XAZB+dwWXw4WPMoI+c7Dc?=
 =?us-ascii?Q?2GP0IxvGUjeDgR92G7E+lt3+P6fMHdRAwUMDf3tw8guOZNlNVzeo+fJfA2PH?=
 =?us-ascii?Q?D0vYqJhIfiNIqK9Jtlqg/RQRHr7f8u3c1s2ptGfoWGSuzvP5AGh4LfG6U8qG?=
 =?us-ascii?Q?tOhfCIy05daVIaDLcni/weuApw3xoVnM9QYn37+7mfpK6pXj6p/NlLTWo/iu?=
 =?us-ascii?Q?JT66kVh8U/vDI9c96D2pMksXsN7wHisfhnaH/y2G0AZi9NGGMvren+mvU1oq?=
 =?us-ascii?Q?YXMWbGIOJLXy6XJLNg0ajqcC82oRgVbax3coE5HOkVbMK27sZ+kk99MOfuHF?=
 =?us-ascii?Q?+Nz1mEV+QQtXU77DnggdmmQ3ls6aRTh52g13zLzg1cj6wPTPwPh73D85x/pm?=
 =?us-ascii?Q?GpUlkx9pwedQBXKURHWzzr4ZJwMlXYKtiLReac2m1qiOmI1nlCn8bBqMG936?=
 =?us-ascii?Q?MBpAGNIrBE8lDFHDjM3agVeKbmWdXknHKxFv8ZC44s9Oghvxp97YuGS9G2Xa?=
 =?us-ascii?Q?eNnctMX6WJMq7E8ZvtA8DNtTk8YJwajF5rcb/yZRctZH4o3Il1ywy3Bn0dP0?=
 =?us-ascii?Q?xARniKEE4ZIlYnmET6L3b+s0//zEZo0xlj+/rrDLbT2fHg1QwEkepQQbua/m?=
 =?us-ascii?Q?82UZKn0YQO+qUuLDQrF9cK9PyPYyMeWvuj5/6B/NJoJRzxTPALzFIE0LTyDA?=
 =?us-ascii?Q?n/aJ7kAk94jCYktu9SCbRGFyftHl4V+WvgbcZQlz/tUn39pctVpr0ff6KWOj?=
 =?us-ascii?Q?C27fckwkrVIil/0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:48:39.0564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b398a0-a089-485a-ac87-08dd5724ad1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
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

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c6e5c50a3322..68088d731c23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -602,8 +602,15 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
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
index 39669f8788a7..019f670edc29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -504,6 +504,29 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 965169320065..dcc8fd7a6784 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -194,4 +194,5 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
 int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring* ring);
 #endif
-- 
2.25.1

