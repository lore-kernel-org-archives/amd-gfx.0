Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE40CCD193
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 18:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F04710E10C;
	Thu, 23 Oct 2025 18:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lqpxq5tN";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4082710E08C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 18:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9vQvOYH+lN6QlPPvvy/YOT9AKm/xIvsynrE7O6cZyr8tcaU9qJqoOGEFVbqM7lK/eyicrDpxTd3DXRf32zgOE35nCNID3axYsx/uzNbOzjDs0c23gqAa04GHlIMNynsR8NarW1mB57oUmSYu6K0ZLy4wUopch0xT/KqVPP4B0zkTmWnJ04i4ukXboBJlWIlxIsrCVORFGeHayTOYeFB/2p3b0y/JE0hIc8vcbdSlRZT1tTwGhHiBkYB5YitguCcuUfFuqh0LEJXf3EdbxkhS1FMD/D6e5MixN36OgyCEiOGYshLZ0UAv6+smPQRQNyseoDuJMp1/cUsq1Eius5AKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZGst3xkuOEkfvEPVH0Ej93Nb1XYuBs3waoDXIZN708=;
 b=An739t9aOy0QfwELt7nMNB/Itbb05D0j2Mh75U5iNjhofL940zXQodugIwcgD+MSp9R9/0PxgXI03kkPak3+AUxPZq0C4aEOsps/omhzbX2WopoX2dlr4NENH9mD+IazzPjwouMY6sRqDLcefjjCEQfC1DQ9RasfzVyuQT4i8RhlHWSxddLzPBGpHa3+FhevLsrV7ewDoyEBCME32IvuRfE06tEqVKxq1chraLhHVNjnM38EoocwnQE7aKYnDqmP+lY0qzqh+3SDnRTdbkkTo0v/nBzdVF9iRJRFHnoatekGu6y+Ep6JTYpjf3FqUHKyF754xv79sceMmXnbgLlJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZGst3xkuOEkfvEPVH0Ej93Nb1XYuBs3waoDXIZN708=;
 b=lqpxq5tNHYZExNgB+CRST+T4NZyojPSdVpgmjWYRAvY8/KjBTUmXuQk42rf4yD8uOURN1hMAiGnXRTTWRVCgyUaNkYqwW7mOVum24+eZgZSNLzKpcOryxTCHoV7r4h1fB09QEncrUZev6Wp6oock7gvolzCdmuSQiYAcvpXRSqg=
Received: from BL1PR13CA0165.namprd13.prod.outlook.com (2603:10b6:208:2bd::20)
 by BN7PPF0FD1DEA27.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:45:28 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::b2) by BL1PR13CA0165.outlook.office365.com
 (2603:10b6:208:2bd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 18:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 18:45:28 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Oct
 2025 11:45:19 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: move reset debug disable handling
Date: Thu, 23 Oct 2025 14:45:04 -0400
Message-ID: <20251023184504.5643-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023184504.5643-1-alexander.deucher@amd.com>
References: <20251023184504.5643-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|BN7PPF0FD1DEA27:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cc5268-c9c1-4c22-de32-08de12645600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IzIZS/YF/G3KvQODAYkeZ75WH7HhNpEEkfyOCI4Br79l0gd5/HDlxyKoD02K?=
 =?us-ascii?Q?E3rpaBAyiR5u927ZBfLSoROfQvDP97Ive9objUi65ENwwsZ1knJJq/+ydEm5?=
 =?us-ascii?Q?oxCxzOixd7BATFmKDKSZ8oSwhJ6OoAtJC/TPZ8UQLISmHKfD5NJXRX6igU3t?=
 =?us-ascii?Q?VTvka33R/szDbGpyH8S+fld9bXIHt0IVfGsp+9u2OGzL6weT+ogY129K/KXi?=
 =?us-ascii?Q?udBNQ6kdgzNAyJ/oSijTglCVo5O++IEgSr125d4FH1m3U94NRj+lgTF087ng?=
 =?us-ascii?Q?lUJgCLaD/ScEhqynTJOXydv+eaSKNtbWr5KSqBB0uLxrMscuWu6JPF6oSJga?=
 =?us-ascii?Q?pnSRKBqcJ17kFTPP2cdrMmGorJS0Nsl27SHbI594BnKabKQsyi+pdYNCPfXa?=
 =?us-ascii?Q?fFqiRXfNP4LSsOZONaqXX8Yzj7Bx0O9beKH0DSl8LM+ZpbEXoiTP1ydHj9ba?=
 =?us-ascii?Q?B6nKpBvAi57v1F4UYREOlHSza6J/VkIkb4WVJgY0cDVvZ6vNLlZFoctaizki?=
 =?us-ascii?Q?VamMzfVFwC/20EwEndrFj9MTi5pKwHVqhoLu1sAfDOPJMkAm0X6AtHk6MRJi?=
 =?us-ascii?Q?j3O42qOg3zWoxOihjZCYksBW9ymkpzDJVFQlkWzyUorVS1HR01z0T7NWZI36?=
 =?us-ascii?Q?wIwEtILW+LTcvKbv7F2/97eVNl/KLjct/wCCowefTNg7q4fqnwZdLWvGB+5F?=
 =?us-ascii?Q?Mt57SmQdZRBNFWgYswRb1v3ffJcW3jghr2fYiCFNUfIUWY3f+Oi3iZq2WIGY?=
 =?us-ascii?Q?rzMbd9hEv4e0rUf+ADjNtybqghnJpuNjeEX9VkamhyYM+wkSv5eVIUno4K0i?=
 =?us-ascii?Q?O0L7X3y6NRlD0KTPpGU/+l5ZNJxslRkJ0LdX19oKD3gk+Ou6hDrqIPaAdH8Z?=
 =?us-ascii?Q?k8Ddc41bfCOf8Zj0loXWZSfg7mR0GJwhbDpwybT0QERsPQQ4uAkcWzdVtVm8?=
 =?us-ascii?Q?bt/djCbFsUPj6uowy5ZTX0V4qS/UXzHaOETYIDXiKDPq4teu+rv6seimjrc8?=
 =?us-ascii?Q?JgFJp7e9yK0stLll4hlyMesSHXZjH4rSsCa+doKeSDg76Xuvzb4Uaze9vcgq?=
 =?us-ascii?Q?P54S44M4O267rmP1wHj+qrrZpBDALzh7QlQFFpxwRwFUB8wMQ2AesmoB+lf2?=
 =?us-ascii?Q?th0a+kazADngrxv7aybNGTV0zkGfsSAt8cCJywqKLSxLdKZBf67ymOYVZz5n?=
 =?us-ascii?Q?TGEZTbbq9gAVabeaVzMw9ohSgqNdS8+YeSYtlTYsk7ddvywl3qXKj6S+CVb0?=
 =?us-ascii?Q?C6EsIknFCLlQF+qDRa6dpY8pnnMFxb1edPdTqpxaqDG5p6r5J3QlKMLk6ejp?=
 =?us-ascii?Q?YFw6Kigsh8lgPXQMKHYIxB4rQ29dKHhDr6nrVDoj3fbzeMssQr3XH5gLK/Ce?=
 =?us-ascii?Q?e3sW9Dx77o3FgHfrHIjezKgoXLhdtVi9XeyP5OdWMUV14CgugsBnif1LYK75?=
 =?us-ascii?Q?RQbk2AikGnNGQqiHbzBVGJEjR6sRfbjm4/KSimz+2HDHf8YgIvCB8mBhWwDF?=
 =?us-ascii?Q?T/2OLoYaO0ijqWbnSHBQtqjkrhnk61AC3l7Cy5lJjXbVfUjL4koivEJ8xh2K?=
 =?us-ascii?Q?vJ811dxKhbIEizhxmPk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:45:28.1689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cc5268-c9c1-4c22-de32-08de12645600
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0FD1DEA27
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

Move everything to the supported resets masks rather than
having an explicit misc checks for this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 8 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 3 ++-
 12 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 3842a15e2df8a..3d396ab625f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -130,11 +130,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 	/* attempt a per ring reset */
-	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
-		dev_err(adev->dev, "Ring reset disabled by debug mask\n");
-	} else if (amdgpu_gpu_recovery &&
-		   amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_QUEUE) &&
-		   ring->funcs->reset) {
+	if (amdgpu_gpu_recovery &&
+	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_QUEUE) &&
+	    ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
 		ring->in_ring_reset = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 43f769fed810e..bf1b90a341d8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -468,9 +468,6 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 	ktime_t deadline;
 	bool ret;
 
-	if (unlikely(ring->adev->debug_disable_soft_recovery))
-		return false;
-
 	deadline = ktime_add_us(ktime_get(), 10000);
 
 	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5bbd264f8357c..39b8adf23a9fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4959,7 +4959,8 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
-	if (!amdgpu_sriov_vf(adev)) {
+	if (!amdgpu_sriov_vf(adev) &&
+	    !adev->debug_disable_gpu_ring_reset) {
 		adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6994fb2cbf917..e1785a8984662 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1821,13 +1821,15 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 3):
 		if ((adev->gfx.me_fw_version >= 2280) &&
 		    (adev->gfx.mec_fw_version >= 2410) &&
-		    !amdgpu_sriov_vf(adev)) {
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		}
 		break;
 	default:
-		if (!amdgpu_sriov_vf(adev)) {
+		if (!amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 8d6000c7ce26d..b86a40e7c2d3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1548,7 +1548,8 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(12, 0, 1):
 		if ((adev->gfx.me_fw_version >= 2660) &&
 		    (adev->gfx.mec_fw_version >= 2920) &&
-		    !amdgpu_sriov_vf(adev)) {
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f1a2efc2a8d0a..0148d7ff34d99 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2409,7 +2409,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset)
 		adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e0b50c690f8cb..c4c551ef6b874 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1149,14 +1149,16 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
 		if ((adev->gfx.mec_fw_version >= 155) &&
-		    !amdgpu_sriov_vf(adev)) {
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
 	case IP_VERSION(9, 5, 0):
 		if ((adev->gfx.mec_fw_version >= 21) &&
-		    !amdgpu_sriov_vf(adev)) {
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index b95afb4afd032..5ec8e28980d5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2361,11 +2361,15 @@ static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
-		if ((adev->gfx.mec_fw_version >= 0xb0) && amdgpu_dpm_reset_sdma_is_supported(adev))
+		if ((adev->gfx.mec_fw_version >= 0xb0) &&
+		    amdgpu_dpm_reset_sdma_is_supported(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	case IP_VERSION(9, 5, 0):
-		if ((adev->gfx.mec_fw_version >= 0xf) && amdgpu_dpm_reset_sdma_is_supported(adev))
+		if ((adev->gfx.mec_fw_version >= 0xf) &&
+		    amdgpu_dpm_reset_sdma_is_supported(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 7dc67a22a7a01..8ddc4df06a1fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1429,7 +1429,8 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(5, 0, 2):
 	case IP_VERSION(5, 0, 5):
 		if ((adev->sdma.instance[0].fw_version >= 35) &&
-		    !amdgpu_sriov_vf(adev))
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index d3b2ac5813383..e163369773adc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1348,12 +1348,14 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(5, 2, 3):
 	case IP_VERSION(5, 2, 4):
 		if ((adev->sdma.instance[0].fw_version >= 76) &&
-		    !amdgpu_sriov_vf(adev))
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	case IP_VERSION(5, 2, 5):
 		if ((adev->sdma.instance[0].fw_version >= 34) &&
-		    !amdgpu_sriov_vf(adev))
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 032cabd8fa8d0..fbe166a4b9b88 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1356,7 +1356,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(6, 0, 2):
 	case IP_VERSION(6, 0, 3):
 		if ((adev->sdma.instance[0].fw_version >= 21) &&
-		    !amdgpu_sriov_vf(adev))
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index cb5a9daed63ce..007f527d54e7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1337,7 +1337,8 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev) &&
+	    !adev->debug_disable_gpu_ring_reset)
 		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-- 
2.51.0

