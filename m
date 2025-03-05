Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378EFC28B27
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE30F10E338;
	Wed,  5 Mar 2025 20:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ntg4U3Ih";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C8510E002
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuTaIGUsAn3q8rQZ8bBQsPYwQfL1piLqFqznb42k+rLF6WkYi5kDTTFSUsY2hvppY+jSCPMbsAKa1swJ/fLMt8A6rIDBmNf8LHIAKBwsqDbjo4N6HcpAQ7pl+S6ULmIT+RczeMeXLuVYXQfzv1mxGqPTW8CcsiljwvmlcGmvdix5vVpM/UDHHwfqgQagh9MkOiCJutZMkXkCq4Qg+s9TMwucdzdgu6tbq8F8Sb8N82N+izN2PlHOGoa6btDS+powLW5u51Mcjc0uT0gSDMfxaIu/a2JIbyEguna0K+yuwhZyl7rKlv5DQb19Cwn5y0hZnEOo0m7RLat9+IY6to97SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttFzJ78AcDO0tljiunaJC6z7XfK5gOOIKBuySQFHgSs=;
 b=XTDp+asY8R2W4XXCuJaTmpH3G4eXa6owMzui9c1XqsLZqqQpQLHYxcVgDHSLOafauB0UP2Ed6mMq8BznfxPYu3ktllUntniBK4ux9kgHQ05dv5BOUoX9WqFHj5yXeD/S9/3BcPP/lzkV5nJnMqtC+ArhdYNDMdHy05HAEkJjW0RrA8DB3Si7RoKxd4VyWYxUsBrCGZe8TzMt9ZnbmvCifCxV5n0njaBJBDPn2Rej5V0bvZ2ruP20R1ztw9+/Z8+eeANn2Vz3XHzLuMuKr8WGzZi1TnIZyKXw1Y0G83iyiD8PoQGwcuTRQa+lhAfKK6b7KsuYezbmzAE096b7KgJ8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttFzJ78AcDO0tljiunaJC6z7XfK5gOOIKBuySQFHgSs=;
 b=Ntg4U3Ihf+UAmmdyFL5k7xUCsDWpzwNq15IUbBzKs2XAkZQ9cV9TFy/ziafM5VgF8cKzqdsT1XlowXCo1Cd7phrgiOqhUTI2YO5MOIvROfPxsjXxwQtUI67Cyo5HMlA3cvD/6xycCgMp0T//qFWwwOnV4cenFeLdsh6pp8/PFDg=
Received: from DM6PR17CA0017.namprd17.prod.outlook.com (2603:10b6:5:1b3::30)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 20:47:40 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::18) by DM6PR17CA0017.outlook.office365.com
 (2603:10b6:5:1b3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Wed,
 5 Mar 2025 20:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:47:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:47:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
Date: Wed, 5 Mar 2025 15:47:13 -0500
Message-ID: <20250305204721.1213836-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204721.1213836-1-alexander.deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: cc914def-07a9-4ed1-24f5-08dd5c26f82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wr2yCc35OTTsMVQr6wK+FAZAEJWbvOIDGPE+knL++ZsmxvipVkZvDQ1nAOUY?=
 =?us-ascii?Q?lwvFFYFkh9vmfuuChHKDt2oAuH7bWXxPR04r4MBRtGPq8gY9SyCWtmjDUNtS?=
 =?us-ascii?Q?tSxeelAm5JKpH3GThTEv4bNv+IZqeWSkGWd2NueSJ7RwzXNwAvwuULvVnTmE?=
 =?us-ascii?Q?nGLyedO6yBxvw/IMnjQfxhqF9SyinaAFkaZ4ha6DcglnVPkXIhsZOgsBS8Jh?=
 =?us-ascii?Q?gbAgHE1G08bo+NpRPE45/PwIaYdzbihN9poY/H4HjI33GRf239iJl9+YnT4C?=
 =?us-ascii?Q?Iz12EU8ug6phAFrU5jiERU2KNrxFebb43yhRb4MIlbdB7uYf2L44H37QNvb+?=
 =?us-ascii?Q?FZH0j5G7/dL9Qg4qSDRGiiyyXFVcO4uvjVAR/6Z0151HL9KghyBw8V1IbluZ?=
 =?us-ascii?Q?BIWGZOeZ4min0yFpVf+PB8vN0jZK8GoGMN4gzi8qjrIaeszdhYsX27ZhaQtg?=
 =?us-ascii?Q?MODfa7CGn4ol9kU9qJUHfj4dIWFNyEAqZ2dL/0whoJ2BoxaveepdEnnHyn09?=
 =?us-ascii?Q?ketzB5GvZgCKzveyTdZBcVum6kQHnVeS/hB+lpJkWJ/N90ra5eGrHYi2eUpk?=
 =?us-ascii?Q?zSMrTzcuZotGqcebFOKyxN0b/G2ySzrLMoBqYGp2B3sBdPLu+UpM+AXHHitw?=
 =?us-ascii?Q?e03glWEqoMi4pCzLBzw6LUWm/cVIDyXEMho+aUv0egrLGt2U3AErQa07J+P5?=
 =?us-ascii?Q?opnA1R7mn+WstBk5e7zuQvyiEmpfpwVj6BJoEMEv0ocK0JOu5se0KcRF7OZ2?=
 =?us-ascii?Q?bxm9yIyn+xM0JBw5ujsLFCtP4hPkarAJpvX+0Y/0h9sOP7sKTOi7tr8Y4XwS?=
 =?us-ascii?Q?MJ8Z6dgB2LgQllaNWjEwrAmg95zEYcIZ30sOD0T1d217zqgQp8krY7h56Sxe?=
 =?us-ascii?Q?gcaVXsWYvy1F06FYHvUu3RQFugw9KqdosAw8tDzS6Hyzp92je2E+g1PIIaCp?=
 =?us-ascii?Q?rY6Hd4vMVhjY+8aZ0BXOX3VqyvyoLP5mCsnGsQFWGvAwvpqXZFyfP5kk8Mvk?=
 =?us-ascii?Q?EImx1+6lhW4Hs8oUfALjAkoB5jta19nC9nqn1/gk/8ELcRUEW49CSWYQGbQe?=
 =?us-ascii?Q?KXKRcPXz+DC0MBGbu6I/YRwqi7ITyClcl0+rxL85YJ17t6+AhvO35OIJcRy0?=
 =?us-ascii?Q?57n6nMRjDaHGDgRYocK2IifoMCoONyrFSAZZovs1fyuisPub3inHqR8bV3mH?=
 =?us-ascii?Q?5gssUKupgMbsXJV1oF4koOOMiV3CtxLikEhZ8DDWtnDlWtnnM29X9MD7ULV2?=
 =?us-ascii?Q?8tlSMR61DYdqLATt68p5RAI2JhZgLtxnoBIzHGhiGOZ4nMlBE9NrkmEFqGJs?=
 =?us-ascii?Q?vEZoCmw9TpSmyFd8Axo53EUUoW7I1PvfUiLGE5jif8fzMWbvfzA3WMV5mfyH?=
 =?us-ascii?Q?lsbkvyxNyAbuO0t6CZQ1ZK62rCDkml4WfroLIt2zFzQLtC8eM4d8R89vpkIB?=
 =?us-ascii?Q?LPSUxCJmBj21ynUqWzIpb+XneJUopMFEDBkGQL4C3D3X63VPunUU6A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:39.6783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc914def-07a9-4ed1-24f5-08dd5c26f82a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087
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

Add proper checks for disable_kq functionality in
gfx helper functions.  Add special logic for families
that require the clear state setup.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 92 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 2 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a194bf3347cbc..af3f8b62f6fd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -371,6 +371,18 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 	return 0;
 }
 
+static bool amdgpu_gfx_disable_gfx_kq(struct amdgpu_device *adev)
+{
+	if (adev->gfx.disable_kq) {
+		/* GFX11 needs the GFX ring for clear buffer */
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) <= IP_VERSION(12, 0, 0))
+			return false;
+		else
+			return true;
+	}
+	return false;
+}
+
 /* create MQD for each compute/gfx queue */
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			   unsigned int mqd_size, int xcc_id)
@@ -379,6 +391,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
 	u32 domain = AMDGPU_GEM_DOMAIN_GTT;
+	bool disable_kq_gfx = amdgpu_gfx_disable_gfx_kq(adev);
 
 #if !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
 	/* Only enable on gfx10 and 11 for now to avoid changing behavior on older chips */
@@ -413,7 +426,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		}
 	}
 
-	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
+	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring &&
+	    !disable_kq_gfx) {
 		/* create MQD for each KGQ */
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			ring = &adev->gfx.gfx_ring[i];
@@ -437,25 +451,28 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		}
 	}
 
-	/* create MQD for each KCQ */
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		j = i + xcc_id * adev->gfx.num_compute_rings;
-		ring = &adev->gfx.compute_ring[j];
-		if (!ring->mqd_obj) {
-			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
-						    domain, &ring->mqd_obj,
-						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
-			if (r) {
-				dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
-				return r;
-			}
+	if (!adev->gfx.disable_kq) {
+		/* create MQD for each KCQ */
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			j = i + xcc_id * adev->gfx.num_compute_rings;
+			ring = &adev->gfx.compute_ring[j];
+			if (!ring->mqd_obj) {
+				r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+							    domain, &ring->mqd_obj,
+							    &ring->mqd_gpu_addr, &ring->mqd_ptr);
+				if (r) {
+					dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
+					return r;
+				}
 
-			ring->mqd_size = mqd_size;
-			/* prepare MQD backup */
-			adev->gfx.mec.mqd_backup[j] = kzalloc(mqd_size, GFP_KERNEL);
-			if (!adev->gfx.mec.mqd_backup[j]) {
-				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
-				return -ENOMEM;
+				ring->mqd_size = mqd_size;
+				/* prepare MQD backup */
+				adev->gfx.mec.mqd_backup[j] = kzalloc(mqd_size, GFP_KERNEL);
+				if (!adev->gfx.mec.mqd_backup[j]) {
+					dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n",
+						 ring->name);
+					return -ENOMEM;
+				}
 			}
 		}
 	}
@@ -468,8 +485,10 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 	struct amdgpu_ring *ring = NULL;
 	int i, j;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
+	bool disable_kq_gfx = amdgpu_gfx_disable_gfx_kq(adev);
 
-	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
+	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring &&
+	    !disable_kq_gfx) {
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			ring = &adev->gfx.gfx_ring[i];
 			kfree(adev->gfx.me.mqd_backup[i]);
@@ -479,13 +498,15 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 		}
 	}
 
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		j = i + xcc_id * adev->gfx.num_compute_rings;
-		ring = &adev->gfx.compute_ring[j];
-		kfree(adev->gfx.mec.mqd_backup[j]);
-		amdgpu_bo_free_kernel(&ring->mqd_obj,
-				      &ring->mqd_gpu_addr,
-				      &ring->mqd_ptr);
+	if (!adev->gfx.disable_kq) {
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			j = i + xcc_id * adev->gfx.num_compute_rings;
+			ring = &adev->gfx.compute_ring[j];
+			kfree(adev->gfx.mec.mqd_backup[j]);
+			amdgpu_bo_free_kernel(&ring->mqd_obj,
+					      &ring->mqd_gpu_addr,
+					      &ring->mqd_ptr);
+		}
 	}
 
 	ring = &kiq->ring;
@@ -502,6 +523,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	int i, r = 0;
 	int j;
 
+	if (adev->gfx.disable_kq)
+		return 0;
+
 	if (adev->enable_mes) {
 		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 			j = i + xcc_id * adev->gfx.num_compute_rings;
@@ -547,11 +571,15 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 
 int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
 {
+	bool disable_kq_gfx = amdgpu_gfx_disable_gfx_kq(adev);
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	int i, r = 0;
 	int j;
 
+	if (disable_kq_gfx)
+		return 0;
+
 	if (adev->enable_mes) {
 		if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
 			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
@@ -657,6 +685,9 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	uint64_t queue_mask = 0;
 	int r, i, j;
 
+	if (adev->gfx.disable_kq)
+		return 0;
+
 	if (adev->mes.enable_legacy_queue_map)
 		return amdgpu_gfx_mes_enable_kcq(adev, xcc_id);
 
@@ -716,10 +747,14 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 
 int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 {
+	bool disable_kq_gfx = amdgpu_gfx_disable_gfx_kq(adev);
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	int r, i, j;
 
+	if (disable_kq_gfx)
+		return 0;
+
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
 		return -EINVAL;
 
@@ -1544,6 +1579,9 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
+	if (adev->gfx.disable_kq)
+		return -ENOTSUPP;
+
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ddf4533614bac..8fa68a4ac34f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -483,6 +483,8 @@ struct amdgpu_gfx {
 
 	atomic_t			total_submission_cnt;
 	struct delayed_work		idle_work;
+
+	bool				disable_kq;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
-- 
2.48.1

