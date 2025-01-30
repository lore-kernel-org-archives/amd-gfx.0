Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD606C02193
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 20:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CA810E9D0;
	Thu, 30 Jan 2025 20:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mG6cX4C2";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31AD10E9C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 20:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5hLbI2cGw/hSLjCPrkakkANeT2hAeTSL2xvzzLBHW7jy77dMYbf5G1tOASqn6jbtDha5OFkiD/Sjojw5wNGWkRqVAv8npSlKVRxXNcVfFRpJcnqJlx0yazmHHANeKyCIEsZ5n3JnfwFwkLOA6cyRSzKY3qh2ybRjG2TxOo+rphYey0CdU85N/ldhJnnpAFiq9zEPzjDUHjs7Xy+cITlpZUANIjBiT6AxucW9ZzlnWCKhMb3j/9iYFHVZBaIEz0W06LsTm5IiumCuSv6OX2ukJhWAUDBYkdZeIeW+pBqyU0ozz7Ng5OIh9Im29aE9DDj/Lv8d85+SRRqlY3i4UL22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtoHcXGDErUHrKcCWcfKHWYa2Gzklej0CBr9AYal9Wk=;
 b=WsWjHAD8afAHf6P7a0PIvnmFt7+ZN8HAWr+KSwckPSf1DUXkacs8EcXSiT4xcduaZS6XvWXnUxkm0KemNrgSQmh9fy3pVa0hymwStJUYX6/WkqoJgBZdO5l7dbyEB6W4ch0+9OUoR1Z332BCcQ5WZ232TKqXezW9aEzWpxAYBaro5uvOHbWOLCscG78ajJURhJaP081h7JRm7FK4bHhA90mXQIwcPFB/BXhNSxPSNFmaleiHATxxxZvfNzubmaiTpNFxIUHSOyofipOiNYRpKMNn0Z+PZzdhVc3VvFEeilAKAKkbNtbdC0jPalO6dtmyhfWXuB28+Pt9D7gE0ItNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtoHcXGDErUHrKcCWcfKHWYa2Gzklej0CBr9AYal9Wk=;
 b=mG6cX4C2vlF7Wj6Sdrekweosrgvt5LQI3dzlzwuy5OXON8a+2R49I/o+xmQXxhPpxiTzo20EY/sdFV4rQDeSpNpPu5eQrcyF0mGcSogiV99SJWJ38b/DlqgOGbaYfI4cnqYPjdySSyomE0NPvKy3U0kOI2Y000j7Espmolig3PI=
Received: from BN9P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::15)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 20:51:31 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::f) by BN9P220CA0010.outlook.office365.com
 (2603:10b6:408:13e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 30 Jan 2025 20:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 20:51:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 14:51:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: add a new flag to manage where VRAM
 allocations go
Date: Thu, 30 Jan 2025 15:51:09 -0500
Message-ID: <20250130205110.811511-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: f458e85c-1587-414d-ca62-08dd416fdfcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L7a/1QZtKAW+gYRWsbupcGJj1Z2P/Dw6h9kWfy4IcxmviCxhtHgTTn7lwgKU?=
 =?us-ascii?Q?82M7oQiKlRPU5GRSIdjEAAKDQUHAfuk41rlNNkVbPw7clRrCREAI8guwbcxI?=
 =?us-ascii?Q?q4sMiSJ5HtF/fPzQ+rvfo9SxcJhfQRF7ULUNWW8mrURQzF7db+W3SqE8RD+S?=
 =?us-ascii?Q?I/8ZGwWyIzIfP9+9xPh0MR+TKGCVaivjnwZRdNous7VKhhcMlr4R5AKPWChk?=
 =?us-ascii?Q?10QRD0KxjEH6UuSmuRdGJqCoJRsyCZRar1zK2J/tHblV00Oy+NpGft0lDPB9?=
 =?us-ascii?Q?ZXhhX2NLGitFJ+i5qZrm5O7NaQ+7HKB1y7Dx/T2P4j5vygoxjqH9m1gJ8EAw?=
 =?us-ascii?Q?JaPSQV9pUTz3vmbhz8bsozmA+yqpTDHYdyp4c4wyle/WuJtYfnZWQdyJPh1B?=
 =?us-ascii?Q?KKSOpdb5s8IUyKyRi+IVXDNycTw2bXoNRPe1EmwLH/68lEMyXBgaOorHs4Hz?=
 =?us-ascii?Q?JrZrTcVcHo9LBiI8kPwG7zadcQKceTcOI9HAYSAYweX5c6skYT+7HB6YEvDa?=
 =?us-ascii?Q?dU2D9LMMCxVKjIQ0hjJoRiGXee2PVdbEcFiUJz+AzAbnW7JxzfwVAU57do7X?=
 =?us-ascii?Q?EV7VRB0Da2IS3GibSw9xSGfeth4DDz9zWGQ4tJu3uwUT4FTLfUc3aKc1/+dn?=
 =?us-ascii?Q?LHCE/KKAZYqrBrsHkg1VlZY+R3Ep0sPweSY9E9uq5dHDBBY0bCIGXHXivqI2?=
 =?us-ascii?Q?ohIcqi62F6PnpsO+K61/+jBLJEm4OhH9O8QBzegylHGwAiabNF+CDvTTmjlU?=
 =?us-ascii?Q?v7M1NE5/OH8Ft2f6QRGenEHEYAq6Odf04kiI+pNrP7vgMW7mxBZ9oGexZFeG?=
 =?us-ascii?Q?8/G5RA04m1fg7Wm9GPUAoK2safeq9mUGcQqCdQArmpeBbE9/7e9JHrQZ2ide?=
 =?us-ascii?Q?WTo2Yva74bWV3ASzUvasAy3r5GvHWYVuQvXIYGLYRcJzVGZfyOiKLTCtBK4p?=
 =?us-ascii?Q?+FetgxZlgFkquGK+/fitiA7JgmWmH8sF/lXaDQfcbFygv9TjJp05H0lCbtN0?=
 =?us-ascii?Q?WzX3ifsVC+ARi/XqkKNCg4lFT2KiYV6f6uCzj6eZCHIhP957wANmOBNdJDXf?=
 =?us-ascii?Q?TVJQcEbF3FAgHzNVpMojHiGu/Pcn1R7b2KcLQH3j9DJI9qbniiM55fDMtZKY?=
 =?us-ascii?Q?v+E3rarBIfXnebuFgFzQIUNtTDjviwVndBP1HEYD9iCUNlDsi3VZTiSTgD1Q?=
 =?us-ascii?Q?4rkhNiZjtu4H43paWet4fkSuoFUboQrFi44m5intIjc8wBtMYV3FdfFkttzh?=
 =?us-ascii?Q?T0LZedXLtkOh3Ie/+CUbHjMayKWZ4qJItEPxcU3vuOOlpKyKTOZn1t/n1FPy?=
 =?us-ascii?Q?beoiOYMlmp9bJ3D+GKIPlBaoSk3utg9+PCZHOTsvRqUb0yqweYqZ04lTOzOh?=
 =?us-ascii?Q?BgbRGC3V6Ts8C0kDgAQ+9eoIhuzzfCrsVwNOMy2q6Jv/lF49PN/OxECnpoNX?=
 =?us-ascii?Q?/Y4JSwfXT06x73kG+scZ2A6Pwitf2BjBQDgBfpZ6VDzLTxoIqBeyFktsIM3N?=
 =?us-ascii?Q?55IJ01C/xFsMDXA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 20:51:30.7965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f458e85c-1587-414d-ca62-08dd416fdfcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235
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

On big and small APUs we send KFD VRAM allocations to GTT
since the carve out is either non-existent or relatively
small.  However, if someone sets the carve out size to be
relatively large, we may end up using GTT rather than VRAM.

No change of logic with this patch, but it allows the
driver to determine which logic to use based on the
carve out size in the future.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h             |  2 +-
 7 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5e55a44f9eef6..dea0246a23c65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1209,6 +1209,11 @@ struct amdgpu_device {
 	struct mutex                    enforce_isolation_mutex;
 
 	struct amdgpu_init_level *init_lvl;
+
+	/* This flag is used to determine how VRAM allocations are handles for APUs
+	 * in KFD; VRAM or GTT.
+	 */
+	bool                            apu_prefer_gtt;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 2c1b38c5cfc62..0312231b703e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -459,7 +459,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 		else
 			mem_info->local_mem_size_private =
 					KFD_XCP_MEMORY_SIZE(adev, xcp->id);
-	} else if (adev->flags & AMD_IS_APU) {
+	} else if (adev->apu_prefer_gtt) {
 		mem_info->local_mem_size_public = (ttm_tt_pages_limit() << PAGE_SHIFT);
 		mem_info->local_mem_size_private = 0;
 	} else {
@@ -818,7 +818,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 		}
 		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
 		return ALIGN_DOWN(tmp, PAGE_SIZE);
-	} else if (adev->flags & AMD_IS_APU) {
+	} else if (adev->apu_prefer_gtt) {
 		return (ttm_tt_pages_limit() << PAGE_SHIFT);
 	} else {
 		return adev->gmc.real_vram_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2b4d3840e5bca..60062c10b083f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -197,7 +197,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 			return -EINVAL;
 
 		vram_size = KFD_XCP_MEMORY_SIZE(adev, xcp_id);
-		if (adev->flags & AMD_IS_APU) {
+		if (adev->apu_prefer_gtt) {
 			system_mem_needed = size;
 			ttm_mem_needed = size;
 		}
@@ -234,7 +234,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	if (adev && xcp_id >= 0) {
 		adev->kfd.vram_used[xcp_id] += vram_needed;
 		adev->kfd.vram_used_aligned[xcp_id] +=
-				(adev->flags & AMD_IS_APU) ?
+				adev->apu_prefer_gtt ?
 				vram_needed :
 				ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
 	}
@@ -262,7 +262,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 
 		if (adev) {
 			adev->kfd.vram_used[xcp_id] -= size;
-			if (adev->flags & AMD_IS_APU) {
+			if (adev->apu_prefer_gtt) {
 				adev->kfd.vram_used_aligned[xcp_id] -= size;
 				kfd_mem_limit.system_mem_used -= size;
 				kfd_mem_limit.ttm_mem_used -= size;
@@ -890,7 +890,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 	 * if peer device has large BAR. In contrast, access over xGMI is
 	 * allowed for both small and large BAR configurations of peer device
 	 */
-	if ((adev != bo_adev && !(adev->flags & AMD_IS_APU)) &&
+	if ((adev != bo_adev && !adev->apu_prefer_gtt) &&
 	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
@@ -1667,7 +1667,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 		- reserved_for_pt
 		- reserved_for_ras;
 
-	if (adev->flags & AMD_IS_APU) {
+	if (adev->apu_prefer_gtt) {
 		system_mem_available = no_system_mem_limit ?
 					kfd_mem_limit.max_system_mem_limit :
 					kfd_mem_limit.max_system_mem_limit -
@@ -1715,7 +1715,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
 
-		if (adev->flags & AMD_IS_APU) {
+		if (adev->apu_prefer_gtt) {
 			domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
@@ -1966,7 +1966,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	if (size) {
 		if (!is_imported &&
 		   (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
-		   ((adev->flags & AMD_IS_APU) &&
+		   (adev->apu_prefer_gtt &&
 		    mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
 			*size = bo_size;
 		else
@@ -2393,7 +2393,7 @@ static int import_obj_create(struct amdgpu_device *adev,
 	(*mem)->bo = bo;
 	(*mem)->va = va;
 	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) &&
-			 !(adev->flags & AMD_IS_APU) ?
+			 !adev->apu_prefer_gtt ?
 			 AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
 
 	(*mem)->mapped_to_gpu_memory = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8b6162217b322..9d2a3e2ad9df5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1985,6 +1985,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
 		 (unsigned int)(gtt_size / (1024 * 1024)));
 
+	if (adev->flags & AMD_IS_APU)
+		adev->apu_prefer_gtt = true;
+
 	/* Initialize doorbell pool on PCI BAR */
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.size / PAGE_SIZE);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index d05d199b5e448..79251f22b7022 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1027,7 +1027,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
 		return -EINVAL;
 
-	if (adev->flags & AMD_IS_APU)
+	if (adev->apu_prefer_gtt)
 		return 0;
 
 	pgmap = &kfddev->pgmap;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e32e19196f6b2..db3034b00dac2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2692,7 +2692,7 @@ svm_range_best_restore_location(struct svm_range *prange,
 		return -1;
 	}
 
-	if (node->adev->flags & AMD_IS_APU)
+	if (node->adev->apu_prefer_gtt)
 		return 0;
 
 	if (prange->preferred_loc == gpuid ||
@@ -3441,7 +3441,7 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 		goto out;
 	}
 
-	if (bo_node->adev->flags & AMD_IS_APU) {
+	if (bo_node->adev->apu_prefer_gtt) {
 		best_loc = 0;
 		goto out;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index bddd24f04669e..6ea23c78009ce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -202,7 +202,7 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
  * is initialized to not 0 when page migration register device memory.
  */
 #define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
-					((adev)->flags & AMD_IS_APU))
+					((adev)->apu_prefer_gtt))
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
-- 
2.48.1

