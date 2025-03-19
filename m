Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAED1C35FF1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 05:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD0E890BE;
	Wed, 19 Mar 2025 05:07:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JHdzdjwW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFA810E1A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 05:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RK8zmF/B8nkA6JJhm90P5c/mrzFPnUVb3kBG4zvakpZb6OU8QuK20e/HsHDwu13T/2l4sr8DKIQYm+3NJM9UEC5rUXjtqzTZWYFQE4Bd/QqPQJonhlW/pXq0ValIePRuebFan6073eRjt6jvLarFZMC6/VbsdJEpYM8yzuwA+V53dKrku1PyxYA7Hixz4OPoVIQLyfUvX48IC2lWtpMwkYIxnYhXI661INtqc8QzqgdetaRE9uBsVFnJ8C/rN8vPYkYqMfy2fIn6R70FrOf7iNzwirQXcxmvJVHly1kNe1i+0xtFeaXR9WEf4pWoNeVjEa57L1i8HVXx3+fVK6YfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvgBhkeQ0TAz8M0/C67RBtl7SY4C7jjbaQGQqcBOJgw=;
 b=Xuj8t+aN1Fdo6nJF32LibQzWDqf9hrt3aKvQAE/w0vvpsHhURai/G+zAq+5u2Or8CxmI+Am7cOZIA5B+UDcKyOWFlu07+JTH3ZJU38340Z16oedG2CR1kdQY8g2wPG+zALSi9RenCDdmyyjkVceKZz4H4xn9gIQZKdxfF+7SXdS5MKLTyr4A/KDgFWDOSb2GyS/7gKuLZ7Em+fwzxFeGBjMlBW78xXysJ45ZZfxBNeSiljYpjiFFUgEvRsHWOguIX89MpkAtjePv3Vf4UBGvs6FRdAgeGgbRpGTuqziP+FqvAvKCffHjv2cWyQTzQDFz1yvfVQuSjj1KHKs31hXdjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvgBhkeQ0TAz8M0/C67RBtl7SY4C7jjbaQGQqcBOJgw=;
 b=JHdzdjwWQJIyfre2WCAkMT2+L+tUVM3yPeZ7l3hZb7przJ0lMcYG60ffigpLQTeMK+ORnIX2+HL3miyJIsghlVEJh0zYsBOeOIUEBitEM53yjAqUMgDqwwR9TiTazmP5UtzqCU29CVDKR0idGIBkOo5ucxamXY4IjCbsGFLqi0Y=
Received: from MW4PR04CA0090.namprd04.prod.outlook.com (2603:10b6:303:6b::35)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 05:07:44 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::c0) by MW4PR04CA0090.outlook.office365.com
 (2603:10b6:303:6b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 05:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 05:07:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 00:07:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 00:07:42 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 00:07:35 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>
Subject: [PATCH 2/3 V8] drm/amdgpu: Optimize VM invalidation engine allocation
 and synchronize GPU TLB flush
Date: Wed, 19 Mar 2025 13:07:26 +0800
Message-ID: <20250319050727.4099266-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250319050727.4099266-1-jesse.zhang@amd.com>
References: <20250319050727.4099266-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 924dccdf-f0da-4594-5b97-08dd66a3fb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4YzR2MmNFTkK6eViKlpl8licyiML3KS220ihXJWI5Q0qvTDT72lzQkAtKdex?=
 =?us-ascii?Q?3MsFY/V79+1KLzk0B+DjgRr/6osltDb0+cmJH+O1ozmRejODpbjFp9IYVGnd?=
 =?us-ascii?Q?kESCi0TRpmLsBf0Qj6T0oWQwzC5TpYdmxNJ+kvCmYkGZcCmynGoh0byJ+A+K?=
 =?us-ascii?Q?rZvTabnxXPW0d/lMkCwZsjE4aDq557p9vG33b6F3BPTjZEOa9qfs7AVd9POb?=
 =?us-ascii?Q?l0QUnztRMYO4wHAjcDkeXC5WOL5Gn4/2bCu3DP96VaJbSSHeUtr2XzlVWE8m?=
 =?us-ascii?Q?Ri0zWdA+cgt56m5hGBeS7GpkM9fI2zulARkXJdSNfMUk0dE1guBzveLcKCe/?=
 =?us-ascii?Q?krqhKa0BCx+JpZLz64EqruZDj+9Rpi072BDar8gow3iuh5i8hV/3jPFDsEbp?=
 =?us-ascii?Q?dBdkBvsHWXI55q2QIbOvcxTxpSkp/+xy0f9RGvgwBLOPJLTc23mxtbkLNbPv?=
 =?us-ascii?Q?zRdEQ2oGeUlkfII5Q5xBbglwF/YIHyZ4DA9r2Rl8l4uLPccMkT34zsNoZGLo?=
 =?us-ascii?Q?3vMj/OnPkRE3TlKxNRR1zaGwhcPpnUXEesilzf4UYFlkU0QF4RSccCyX6Sss?=
 =?us-ascii?Q?Q8Xh8mN4rgMjd7ID13wuNMkgHAMZhK58L82hyYLO1vsnhFJ92M5eDVdAxrgj?=
 =?us-ascii?Q?+iNekLr61bQSQPflPfQCithfGgu2o0jcw6yN19D84ykiXO4hZpVz6aiQRvQ/?=
 =?us-ascii?Q?0LpgJir2BYZ4rr65Kn2kDTcBM20D5XH/8CL9QE5D6PcJSDuXThNYFVKR9TcD?=
 =?us-ascii?Q?ci98LwvyUJ+4f3h8njcjog9ZF29JiHgLVIzVfRhMXgO6WPAYX/Rna+ub3x0w?=
 =?us-ascii?Q?d/+4Q6u8s3vD6LCLEEukENJJ+DvXek+I3/5S7dyk6EI76084Hy8HA7+J34GG?=
 =?us-ascii?Q?xHr0QpaiHGQf8Ioow1fRiu0pz3/MQl+7uy0lf3kQ9dLldyRHSakFPJeaG8w3?=
 =?us-ascii?Q?AOA3f4g7xuRfctLKy4SUthW321nT8iqjaKrkiYRQ/dWdlkKhrIQG2kwCqfUB?=
 =?us-ascii?Q?jRasts/CZ/G0JAU48RhqGnjw6CNPB29gYNnPZbKUArhydI2r0eZdAnbtgF0V?=
 =?us-ascii?Q?RmOoYUgfSUVQaqWEJAit8zeDOK+a6NH200D/F9raRYUT0ahfeI+DtHrJqATk?=
 =?us-ascii?Q?TaP9p/KYQSR9dY0zx8c6PVwBc7IgeR7DI2Eb0jheS+zmgJVrHAICCrgagWCY?=
 =?us-ascii?Q?o+VHtfP+BkByzB5yVORb18C1XG77rrjkAMhtejHOMgnnXJe/2kppOgRvdft3?=
 =?us-ascii?Q?2rPoHd7XkzaoRATnk32Kn42eMeZOG7H+BcQika3esDjCMJPV6p5BsKfsHjND?=
 =?us-ascii?Q?JhoWOJd8UjAUqxEmXSteijMcRjWNZtmi8ieWKkjPs2/IWio7NCBid4BWSQih?=
 =?us-ascii?Q?sB70R4TL7FODwyJ9d+iXRxgR4OWKU1Sy+cNz6fsbiv/UctSb6zyKUfChtJ5T?=
 =?us-ascii?Q?qIilqrXxIzDHO59wvLDyqjqj97jOWpX78R5noaq16+MsiLN9zJIZvWHewB7i?=
 =?us-ascii?Q?uQk9VgwssK0QeB8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 05:07:43.2635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924dccdf-f0da-4594-5b97-08dd66a3fb02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
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
 v6: Added search shared ring function amdgpu_sdma_get_shared_ring (Lijo)

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 19 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 33 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4eefa17fa39b..26a90576792c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -573,6 +573,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] = {0};
 	unsigned i;
 	unsigned vmhub, inv_eng;
+	struct amdgpu_ring *shared_ring;
 
 	/* init the vm inv eng for all vmhubs */
 	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
@@ -602,6 +603,24 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
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
+		 if (amdgpu_sdma_is_shared_inv_eng(adev, ring)) {
+			shared_ring = amdgpu_sdma_get_shared_ring(adev, ring);
+			if (shared_ring) {
+				ring->vm_inv_eng = shared_ring->vm_inv_eng;
+				dev_info(adev->dev, "ring %s shares VM invalidation engine %u with ring %s on hub %u\n",
+						ring->name, ring->vm_inv_eng, shared_ring->name, ring->vm_hub);
+				continue;
+			}
+		}
+
 		ring->vm_inv_eng = inv_eng - 1;
 		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 39669f8788a7..6287159dab62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -504,6 +504,37 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 	}
 }
 
+struct amdgpu_ring *amdgpu_sdma_get_shared_ring(struct amdgpu_device *adev, struct amdgpu_ring *ring)
+{
+	if (adev->sdma.has_page_queue && ring == &adev->sdma.instance[ring->me].page)
+		return &adev->sdma.instance[ring->me].ring;
+	else
+		return NULL;
+}
+
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
+		return (ring == &adev->sdma.instance[i].page);
+	else
+		return false;
+}
+
 /**
  * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
  * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
@@ -545,7 +576,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
 {
 	struct sdma_on_reset_funcs *funcs;
 	int ret = 0;
-	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];;
+	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
 	struct amdgpu_ring *page_ring = &sdma_instance->page;
 	bool gfx_sched_stopped = false, page_sched_stopped = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 965169320065..77288bfb4e76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -194,4 +194,7 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
 int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring);
+struct amdgpu_ring *amdgpu_sdma_get_shared_ring(struct amdgpu_device *adev,
+	struct amdgpu_ring *ring);
 #endif
-- 
2.25.1

