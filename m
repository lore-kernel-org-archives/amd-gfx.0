Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E96C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 08:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9E1910E5BE;
	Tue, 25 Feb 2025 08:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rkt1I2R4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E11610E5BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 08:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlqCfaXAFERCl3vdnfx8yzt4wxkOvpgoPHhIRYA9GmkMa8Q0mQlNd5iSM2TtTCHM8DR3gF4hd47y3Z+BFGt2OC8nruYHL5O7kfFqz0ZOD1LU/TZf9iL6zsT/3CM4eIEzCTRmU2hm7gmjFA755Knw8PKjQucBJs2E+flhhkRJ4+bWkoEFBJXI5N+pr/iBJBvfU823xxVFiAMvfRrFp05px26yWh91Ks2WS+aro4V0yGBdbx/yVJ9aYzOwEp9rj5pghvDilELx4CFNYZldSXKJlzlKSPFWVuU6Np9YLqOXZPkPEiNdpbhNQarclqHitTUd57fMmf7TOGTkYkIwiWApfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxTyybaEjQ0Ic1tBVusgiGE7XE8n/tr5R9UFo2lW6+Y=;
 b=nti3vdmNI59qgcDD5zhl9k6XNWbQnqU9lEObkxnMHMgHYF2R0+Hkko29xMW6rTA5T7F3ff1I6Ce4gnREeIztTORc7/YKlIB02oo0CleMvaGjnOugz/RfznK/pFmDpWiOrkdYtOqW9/eSEqemvvNwUjhzZrP8CkFcU49AZxU7oSP4m6yVdLdlCBO112G+to1pHFFvT6iyonGyPdtCc1LLpgI4bgvECdX1h7bxxypd6SjsB962fXllhiUizMEC3yc0cb1fVzjzrpd9wFUkNz4HCdG9pVzPB3jxXoM/fb0pZDiEYCnnYB3rQaEr3h/9pXDl8USR71ATV+GPNaVL5cmmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxTyybaEjQ0Ic1tBVusgiGE7XE8n/tr5R9UFo2lW6+Y=;
 b=Rkt1I2R4COUHAv/k6J1VzLw8+PuXnYh/VMvUxrMHIQlFIbgICxrQ1C+rab+7iEeOO7Utne2rICYmQIqtO2e90CMBFh7ZI8FO0fePf1Yif1ICAR9yUNaYiG/ccn2XQ1C/n3i8WsXzX+C2tns/51RchgQrunZB0zeqRbTUNyDL/cs=
Received: from CH2PR17CA0027.namprd17.prod.outlook.com (2603:10b6:610:53::37)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 08:43:32 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::ef) by CH2PR17CA0027.outlook.office365.com
 (2603:10b6:610:53::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 08:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 08:43:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 02:43:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 02:43:30 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 25 Feb 2025 02:43:23 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH V4 2/3] drm/amdgpu: Optimize VM invalidation engine allocation
 and synchronize GPU TLB flush
Date: Tue, 25 Feb 2025 16:43:14 +0800
Message-ID: <20250225084315.40087-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225084315.40087-1-jesse.zhang@amd.com>
References: <20250225084315.40087-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 2046d132-45ed-4093-f9bb-08dd55787b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ER5eWfUu/StqcAWM7eqhy+cD6n481fFhoYJPEDM4cgXRwRQnhQ40Gt1pk6zC?=
 =?us-ascii?Q?QL+bLbuyXcDkNpSiuDe+WOfoVbHynuZIhUDDMpeTeGc13ThCGshAreiIKpkS?=
 =?us-ascii?Q?YomBJ3sY+iPJ5t9AfmkhyaPkIsd2hsesLbjcZzCBRJALQmkcc1GVgAcbWzy2?=
 =?us-ascii?Q?qRe1E1b3tjT1vwxWaX1707Y/WLpiDppQ1Mb3K4D7J4l/UWjw63OOtFp6EiF7?=
 =?us-ascii?Q?4j9/jiP47oXC7pdjDRmBkiKH5zk4HXB6lQpLudeFKkzYUc90aQmq1P0rNcJA?=
 =?us-ascii?Q?qRxgnipx+oQTjFYaLaqcL6aC60R5z+YZ1aXSW5cZvDMNVn9bHXDx8X1RSqv7?=
 =?us-ascii?Q?sTS6t7PCvueq9K2zJ95dN2S4hFr1CA/TSEIBWgGhKSDfTUKGj8X4rfQjgGpv?=
 =?us-ascii?Q?9QvpUdzJ2gDZDTGHFI6IdfLYGTt+MlKEhpLOXp9vd/QmHi1nx8ozK48/RJPI?=
 =?us-ascii?Q?c0cOowjCspkmSwIMC7ha4RIK3EhEA8Vw/gakGEgOGdtlq9alNaZJ+oFzd3Ul?=
 =?us-ascii?Q?UO4rGgI05Jm19+XT14OsrvJWslgosu9j0+3GND4OySOYu9t/ii+9v98YHMpD?=
 =?us-ascii?Q?AkBrruPXcJkUJ3DAIMR1301VA8dJGAOX9pJvr7xYFaQFT1xNgawpLeOvphYt?=
 =?us-ascii?Q?Jcw9r9avFGqRbdI978acrCPNVdIsUdev8wC9iON3QjX7+PoPdJiCyG87xnGj?=
 =?us-ascii?Q?PPrErKICTY6Pl4dZiO4MNja0rOg8S1cZpDJzf4TTz9WUL646PTV+cPFvbGRw?=
 =?us-ascii?Q?zifkzzy4BUXJaV/ZOVAjmINYpKBbs8w3a/libY9y/2yzicsOGtlkbKH4CztS?=
 =?us-ascii?Q?BvavNoTp45TwtLMF+/8x7jutetDBtgrr7gTY+CkEzL4NfADfs8SusAAATNpu?=
 =?us-ascii?Q?ahr3xWs4+kFxvfTwBiN+QnaUwlXq9ZILNh0PQy6NQpRDAAEAzJ416wZptz5y?=
 =?us-ascii?Q?mjUo+ljkyH8v11ijCBxo9PEAnbi5rkkXFyQ5w3yAbfeImdsIYMnxYJh89JGc?=
 =?us-ascii?Q?j28dyM050b7HUzqJhJUYDd6Tgk5GLw69nAs4BQC4xMrS3o3HF/GOCITnCZR9?=
 =?us-ascii?Q?7fvpBzvRph4q3/Cdheyd3SLNSloN5SwAg2pb0lhXmZf6uZVV0gDQKF3/wRtp?=
 =?us-ascii?Q?jt1QfzNCFtQPKXkthVhPU+ME5nkOr3xJncwEAduCNdozDvju9CEPfOu9NiDy?=
 =?us-ascii?Q?L6UdcmHzjQiEfKyQQwk8zYoMFXgVt5krPO3OdRBbDZTQME0y7A8NQce1lo7t?=
 =?us-ascii?Q?ZDQVZdESmkvhkPMhh6966ClXU6ae6IcK6oJPkihPjR9r54Cid8bC3LwIJRZN?=
 =?us-ascii?Q?lEVnuF29IXqKD0MzH93crfSvEVs5YO6jx6BRdPumnWLynsUz9ayWqjqcMLiz?=
 =?us-ascii?Q?BcFjROZ1CgMMcSwvZNVnvXGbBgGIlJvH7JEr2AlpzjGCqtPaJl0Yqcgv7qCq?=
 =?us-ascii?Q?Bok7mHeuruoctwFyBEznTtHa/qKkkHuoZsKaCsMJTns35/9INHY5nYgvpsiA?=
 =?us-ascii?Q?RBma/1YhSpS0hhA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:43:31.0046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2046d132-45ed-4093-f9bb-08dd55787b5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
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

