Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A94BCCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95E5210E80B;
	Wed, 29 Oct 2025 17:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k1Saa1mE";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010024.outbound.protection.outlook.com
 [40.93.198.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F315110E809
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUSqlEpzca3ooz4zkhWUvyhpppFcWwC0XLYY5X2+ujIiFMjvWmVbGjnz9PvUn5lF66x0bXbD5J6NKqhsiksI79A3fQ+Ek+dc7BNxN64APo+S/vbU3UytokU+ZftB2IYc+SKhzkxqFT0+Vm7MbG5olaeHwb8Zsbihvg04ogdQlLP/idYltCvOWVenaF68No4mQxVnd9Ku+s6bCBGgu1BMyie9QmoeywAANUHKwLnJyLmfI3+REWYGsXnSB9/tZPQ1OqjpstZmEs1r00/OuhScwhK5GhNKM4wIcQOPeWHUN7+6S5oKLeifu3GMAlYb/eZDDypLoTXT4/SdTd9PDj4i5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUOI0mCKA1IZIBe7/H/bEmrAzNveH8boizXndzk/dGA=;
 b=RhXXcngLmhd9pzAjGMe1/VbJ0Mj3gk9jN3u2Ks/VfxE6pYdPOXgu6C9gsEUlx2w7KwmdI3uDhLmaJHyLliQhg6KOG87mqRGDm1JLiqN/FoPVhkdAW1CRhTA0FFsJyqPvi+GU7PDKcbIo1O4hJ1yaub0oeoPchEXrYuj6PKuo7cXdMi/kbRiO2Gt0IlltPojloVfJNMnIZUDE4ApT5z9iHmw3NyuX5fjLgwXzjKYpzVpgqj6sQ73j9pt1ybJWJtFvTcBc4uUMy0plCn1Knxd/TrfheGYSZ7y0nQ93Ivvtw0LOaEPhEq3OakGZc1SqX5Ni21yYjAeeL5nOqK7v44iTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUOI0mCKA1IZIBe7/H/bEmrAzNveH8boizXndzk/dGA=;
 b=k1Saa1mEGvgq8MXBQNk7HPGydX6x0IWsAtWeBdtQsrFECFaVJ6m3Ey9NnkcLsWrjjKo5e2MsY9NMQQ9H5PaAT0psq2OrFeoPK90sqW7czbj0tStdrhcFLJodwBYBpp2dooDr8FmOKMxPX+rhlgueRxzASw7Bcx/UXdQq6l6zOMo=
Received: from MN2PR18CA0018.namprd18.prod.outlook.com (2603:10b6:208:23c::23)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 17:53:15 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::e6) by MN2PR18CA0018.outlook.office365.com
 (2603:10b6:208:23c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 17:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:53:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:53:07 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Update vm start, end,
 hole to support 57bit address
Date: Wed, 29 Oct 2025 13:52:42 -0400
Message-ID: <20251029175242.2861740-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175242.2861740-1-alexander.deucher@amd.com>
References: <20251029175242.2861740-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e7ddce-ee2a-41ac-4a90-08de171408f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y+G6YcOkKx3+yXsIGBucK9+NE6861h8RxNHRoMSNTGQF2eoML1l5iQ88GkqX?=
 =?us-ascii?Q?cvsC/cp5W1wNuLShvtFfPwX/HKxTsjZSBiVFI5ltulK29oq7rNUedy3ALW1u?=
 =?us-ascii?Q?xiJWlntlFEzlKxBYQ3vOf1ZgWhFJc5uvoiorLn6FDn9BkXURzJo3hTGReWVg?=
 =?us-ascii?Q?YVuMILXTK0uzlhu9tZh9k0Gl6ecKy+eY/3pEIuMusAGzGWIBkH3OSWV38gzR?=
 =?us-ascii?Q?J6PLlm9gUkxg64wKurgDOz7OlPyddITaGV4a46eGOfEU4UP1B6DXVjzb8BiH?=
 =?us-ascii?Q?k/AU4e+BSXNY0veGETwTtoTIYfB1hd3FWBQEebHdUsh7iWwKAtx1FZ9pzB7Z?=
 =?us-ascii?Q?7qLUDCQE/mxAeB9bn9VR555ykto/vkOkZ+NgJDR+ACDmcWCpYx9aSTRHlifR?=
 =?us-ascii?Q?yw1RWf2QrZ3PQxKp9CTKETxp2XCJRXopKGXDLcFAz0DPzneTYNNfD/7bnm6N?=
 =?us-ascii?Q?9hpCWFRAsQwW/RknTFOWMV7XuUdambkE+nL0IbYFWuNnd2OJ9cKewfkeyiSV?=
 =?us-ascii?Q?ZCpCtsn+kZpoyXErc3DdXDPKkhqp9cEXg2PIiamcgxsOjYXqS9U5VYiKFZzr?=
 =?us-ascii?Q?JjuPNsZSTeE7i9pQyiOA8JAkqZkkXrcTOUR1eEf1lYET9BEwwebaxOFt7edj?=
 =?us-ascii?Q?iYNqGM8EmJEE9LflGAS5fIJHXACqaNIs51vP527rmR1FxzXRx8LEcGVpOj4w?=
 =?us-ascii?Q?sqe4fHG1wvL2kCMD1+1P6Pol0MpYeu8cZhmxXLQv+U9PiPQU/GfWODxXV5eQ?=
 =?us-ascii?Q?Wy7qrty/r5cVlPh8pdsI/vW9SAvqbFX/Fyka7y2biK72WILNqp6SMENT+U8x?=
 =?us-ascii?Q?O6bfj01Td2I0MxXbayZk7rwy1NPqYKjZdo8E/J79lO6sWQEbZLDMYXBUuWRz?=
 =?us-ascii?Q?jFhE+NMKcDfAHziMj6+i7yZW2l/KrC2sNSBZLaIEWteJOac+XL5lPV5CETBj?=
 =?us-ascii?Q?f8qzqkqdWtq6ClVRnKjxgFxNv2yfir5P0+Spku3KOx6QNBH34rtbhmKl6ENb?=
 =?us-ascii?Q?P4WiDI0eOlCUpXVF4neQpbHvqJAcpReCovgu41lY6ztafWdLnz/Ja3FrQrhU?=
 =?us-ascii?Q?dNp9xqeQscETfFAbtizWfz3Hirjcs46Gp4nhmN9InfBwubfxXoSNcjy1+PDx?=
 =?us-ascii?Q?ZOniM8CFTfuAyiZlQVc4UnnvvdqPnldPcpOt9926sQDXP4TGwdNcTZFfaxmv?=
 =?us-ascii?Q?BLpfibLwd2w2YkVZUqs1g6pCJ6dS02m4kg31ebZ+bBoGphMzxUtcetBlIrA7?=
 =?us-ascii?Q?dIptU15TtuZisv3vre6/ZPfvvcdkCjkmGYQrSfvkqTgGasHQfGYqG6YiDX2b?=
 =?us-ascii?Q?Ba6cdZe13M2vnjWfWgVtCknvbXRL53+OpO/PpLQr9MFgBRqjNeJ41jydOT1S?=
 =?us-ascii?Q?OrA3fbDFl71Ucv6qaoVCoOVakD0JqB1L6V09fu8Wdspg+yFkqRTS/skGKOWV?=
 =?us-ascii?Q?loxw4PhFjb+KotdF4RjG8IdJ61uMUhfJ4OjUYoxERbQI8XpZeXEJ/r0FjBvV?=
 =?us-ascii?Q?vJm5Ia9XnDCohQDABVr5gwph0DlJfAnQaobmDjZ9KlOLaVH8yoS8mnZND2p4?=
 =?us-ascii?Q?nNFzZXizMwlQAmT9FTs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:53:15.0032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e7ddce-ee2a-41ac-4a90-08de171408f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

From: Philip Yang <Philip.Yang@amd.com>

Change gmc macro AMDGPU_GMC_HOLE_START/END/MASK to 57bit if vm root
level is PDB3 for 5-level page tables.

The macro access adev without passing adev as parameter is to minimize
the code change to support 57bit, then we have to add adev variable in
several places to use the macro.

Because adev definition is not available in all amdgpu c files which
include amdgpu_gmc.h, change inline function amdgpu_gmc_sign_extend to
macro.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       | 20 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  3 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 13 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  1 +
 10 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ecdfe6cb36ccd..d591dce0f3b3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1021,6 +1021,7 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
 			       struct amdgpu_job *job)
 {
 	struct amdgpu_ring *ring = amdgpu_job_ring(job);
+	struct amdgpu_device *adev = ring->adev;
 	unsigned int i;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 55097ca107382..130310ae3c59e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -32,9 +32,11 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_ras.h"
 
-/* VA hole for 48bit addresses on Vega10 */
-#define AMDGPU_GMC_HOLE_START	0x0000800000000000ULL
-#define AMDGPU_GMC_HOLE_END	0xffff800000000000ULL
+/* VA hole for 48bit and 57bit addresses */
+#define AMDGPU_GMC_HOLE_START	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
+				0x0100000000000000ULL : 0x0000800000000000ULL)
+#define AMDGPU_GMC_HOLE_END	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
+				0xff00000000000000ULL : 0xffff800000000000ULL)
 
 /*
  * Hardware is programmed as if the hole doesn't exists with start and end
@@ -43,7 +45,8 @@
  * This mask is used to remove the upper 16bits of the VA and so come up with
  * the linear addr value.
  */
-#define AMDGPU_GMC_HOLE_MASK	0x0000ffffffffffffULL
+#define AMDGPU_GMC_HOLE_MASK	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
+				0x00ffffffffffffffULL : 0x0000ffffffffffffULL)
 
 /*
  * Ring size as power of two for the log of recent faults.
@@ -389,13 +392,8 @@ static inline bool amdgpu_gmc_vram_full_visible(struct amdgpu_gmc *gmc)
  *
  * @addr: address to extend
  */
-static inline uint64_t amdgpu_gmc_sign_extend(uint64_t addr)
-{
-	if (addr >= AMDGPU_GMC_HOLE_START)
-		addr |= AMDGPU_GMC_HOLE_END;
-
-	return addr;
-}
+#define amdgpu_gmc_sign_extend(addr)	((addr) >= AMDGPU_GMC_HOLE_START ?\
+					((addr) | AMDGPU_GMC_HOLE_END) : (addr))
 
 bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev);
 int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cc2f96ed7004e..1b528311da4e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -64,7 +64,8 @@ static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
 	return 0;
 }
 
-int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
+				   struct amdgpu_usermode_queue *queue,
 				   u64 addr, u64 expected_size)
 {
 	struct amdgpu_bo_va_mapping *va_map;
@@ -614,9 +615,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	db_info.doorbell_offset = args->in.doorbell_offset;
 
 	/* Validate the userq virtual address.*/
-	if (amdgpu_userq_input_va_validate(queue, args->in.queue_va, args->in.queue_size) ||
-	    amdgpu_userq_input_va_validate(queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
-	    amdgpu_userq_input_va_validate(queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
+	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va, args->in.queue_size) ||
+	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
+	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
 		r = -EINVAL;
 		kfree(queue);
 		goto unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 09da0617bfa20..83358c3ea7c93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -148,7 +148,8 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
-int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
+				   struct amdgpu_usermode_queue *queue,
 				   u64 addr, u64 expected_size);
 int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 				       struct amdgpu_bo_va_mapping *mapping,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 2aeeaa9548820..78240fbbf8171 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -351,6 +351,7 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 /**
  * amdgpu_userq_fence_read_wptr - Read the userq wptr value
  *
+ * @adev: amdgpu_device pointer
  * @queue: user mode queue structure pointer
  * @wptr: write pointer value
  *
@@ -360,7 +361,8 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
  *
  * Returns wptr value on success, error on failure.
  */
-static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
+static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
+					struct amdgpu_usermode_queue *queue,
 					u64 *wptr)
 {
 	struct amdgpu_bo_va_mapping *mapping;
@@ -453,6 +455,7 @@ amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
+	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
 	struct drm_amdgpu_userq_signal *args = data;
@@ -543,7 +546,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		goto put_gobj_write;
 	}
 
-	r = amdgpu_userq_fence_read_wptr(queue, &wptr);
+	r = amdgpu_userq_fence_read_wptr(adev, queue, &wptr);
 	if (r)
 		goto put_gobj_write;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index cad2d19105c4c..69d90a26ecf50 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -798,7 +798,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * Set the internal MC address mask This is the max address of the GPU's
 	 * internal address space.
 	 */
-	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
+	adev->gmc.mc_mask = AMDGPU_GMC_HOLE_MASK;
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 5aeadb2f0f473..85206557e1723 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -59,7 +59,8 @@ mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
 }
 
 static int
-mes_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
+mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
+			      struct amdgpu_userq_mgr *uq_mgr,
 			      struct amdgpu_usermode_queue *queue,
 			      uint64_t wptr)
 {
@@ -293,7 +294,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
-		r = amdgpu_userq_input_va_validate(queue, compute_mqd->eop_va,
+		r = amdgpu_userq_input_va_validate(adev, queue, compute_mqd->eop_va,
 						   2048);
 		if (r)
 			goto free_mqd;
@@ -334,11 +335,11 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
-		r = amdgpu_userq_input_va_validate(queue, mqd_gfx_v11->shadow_va,
+		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
 						   shadow_info.shadow_size);
 		if (r)
 			goto free_mqd;
-		r = amdgpu_userq_input_va_validate(queue, mqd_gfx_v11->csa_va,
+		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
 						   shadow_info.csa_size);
 		if (r)
 			goto free_mqd;
@@ -359,7 +360,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			r = -ENOMEM;
 			goto free_mqd;
 		}
-		r = amdgpu_userq_input_va_validate(queue, mqd_sdma_v11->csa_va,
+		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
 						   32);
 		if (r)
 			goto free_mqd;
@@ -384,7 +385,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	}
 
 	/* FW expects WPTR BOs to be mapped into GART */
-	r = mes_userq_create_wptr_mapping(uq_mgr, queue, userq_props->wptr_gpu_addr);
+	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue, userq_props->wptr_gpu_addr);
 	if (r) {
 		DRM_ERROR("Failed to create WPTR mapping\n");
 		goto free_ctx;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index a316797875a8f..e9d790914761c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -2053,6 +2053,7 @@ static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
+	struct amdgpu_device *adev = parser->adev;
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_bo *bo;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index d9cf8f0feeb3e..02d5c5af65f23 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1907,6 +1907,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 			    uint64_t addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
+	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_bo_va_mapping *map;
 	uint32_t *msg, num_buffers;
 	struct amdgpu_bo *bo;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 3ae666522d570..d17219be50f39 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1824,6 +1824,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 			    uint64_t addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
+	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_bo_va_mapping *map;
 	uint32_t *msg, num_buffers;
 	struct amdgpu_bo *bo;
-- 
2.51.0

