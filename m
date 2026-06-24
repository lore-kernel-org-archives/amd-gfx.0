Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAADFCDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 14:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F2F10E088;
	Wed, 24 Jun 2026 14:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xATUp8jv";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D053D10E088
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 14:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfQX0BI61nUFqMMFcqLeBNlbnn2ZTGWijwkb89pvS7/vwwLjQN6qI8THoUCOJsM2YoNtvem7DvFcMO5PUVoF0Qp3ccm0PjMI6sd4WmDignIeP1WLIoStsCCZW6yYrPrE+PHSPgx/zDIlwEFqebUzgrgJdolBf1OlkFwRVGNq0S0kLXW15DjAFKyN0yRVw6mHd3AoMHxTuEWdMa+kPk0eMhJRVToO315NsDWhn51ZzMBf0pzPp5rCD6DiZ1G7ktnh94uHXcAbhgdWG0qya5CP97G/VqQDzxvNYUnfYnJGtFfkPEvop+upW0keh2n2gHYPwHQtWxbxb47dkNa6VJVIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Wyru00Y9hSz03YJOjYDlJxzgVA3jlFkLX5Rn61Z/mc=;
 b=nzIGIxK1pEyG0P9i0l9MBY+c7aTLY39RNyGzaiNxGxfC1uovbHyvb16X0Sl1N6hoaNr7i20VRDDcRsa6ODmVGYqhVeT+gGmWbMLkOWTpbx7kbEXUASImd2EF5gn9qaqGXBoyb4C6Ygw6/wMdoDE7qB/FigVgUJ0hyEyOE7dyV8gegEf2uoRd0n54gzumKlVAEuBCuflmzl8m2Q4iyT1e2GsOYuwN0z1co3RniyzJrsdRfHsbPLQdh3idLwfnt/QpfZq/QRuy+IzXjKCSUADDt1uF6HEtIPw9rLzc/d3tBm69HM+w3rmqWNB91ktRK/J4VZekKnJkjRALUsyH+Du9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Wyru00Y9hSz03YJOjYDlJxzgVA3jlFkLX5Rn61Z/mc=;
 b=xATUp8jvVzZ7AB9YWxleOpT9CAP6NRXAknF7oIFu5779eORh1WhQ5XCUnZG1+HtNfVTfcRhZ7Ra/L/USibAPHJub3z5M4dpwInd8v8yDdezDD1lx5UAbu0GHbQt0+gqYBsycf+yFGFhrOC+XdEcX5C5RUqxLPHJL8wO0Vjlvhg0=
Received: from CH2PR10CA0003.namprd10.prod.outlook.com (2603:10b6:610:4c::13)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 14:27:54 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::6f) by CH2PR10CA0003.outlook.office365.com
 (2603:10b6:610:4c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 14:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 14:27:49 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 09:27:49 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <philip.yang@amd.com>, <Hawking.Zhang@amd.com>, <Bob.Zhou@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <jamesz@amd.com>, Vladimir Indic
 <vladimir.indic@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: support kfd map bo to kernel
Date: Wed, 24 Jun 2026 10:27:26 -0400
Message-ID: <20260624142727.1946258-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c08d07-f597-46dd-81ba-08ded1fcc4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: iZvFrGbEUWQ1KWrHhVLonwRJX0z09UVAHH89uncRMipmef2di/68t6nmAwle/7w7BA3AzHoX7qhV2OlRhuryMrRGnceaS5opUD1y3yO2lpVNpYUjZ1DivuNuNvrlLbRDGUN+UPKZOcR0ulvU4JBb/LgNiwGH/jDqvr3RZd5FdiMcaNoc2U2AFI4GW1F9hRg4hSaWxYkrAFkVkw5oUnbeNhWNDYZLiZdweE+4ogmY8auPFe7UO/9a0b2k5ZpZ+IknupeEjfAEwBEpuIKPZlrcXn+SdkKI2hZYCtCP1ygEcoxjSBBRqGBw+N6l9YRgovvaYx+wwAK5VU/3TZnw43oo5VjS6KSHvBIUNX993Mz+LDnZ8/plcgknPOf8lw5Tzl0knDvqOSFI5bVRwyG23m7XeCsFkVJJPslcEh0FpEJ6TWDxyGRkrB/82nvblCHrIKhxBkvaAyu10tHq5Lz5Ll7jufMRKqNo0ZKXUooT6kfERqroDS6/FgT8oV0zNfenXnDw7p8BhJ5qoJ4HKkszm4Bzn3oX/iulQwXopIOJijEFQ0lLBhvBGqNiTHzOMvMja8h1Er6inTUjreYXsTIr1k48mYtJIOW7381Ic9jn6L/99ycANLDB4nb5RR4NxLC9B1OU+l6VlS7lB4TkTU8GYjEvUZJdvdZIMPYatX81vAiLbVgzzdr8W1+2ZOlRU2q1WjvXiUuikt4BBpn19mw+Osw21w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GORMtqgGCcmKegUuHMaEIeyTK/NccEdc+ichuy3YzUxghoV1cCs1PMw6A7xtyZPfN6B6/xXM4u2vDMj4dq3g8ETUVPdilUB6POnVn4RLvqxjM/9Xq4MQhbDF2CKkzcwFh2arYB38i31APgZoQ1Q/SOy69+Ok1fDf78pRopJJGM6zX2jq975rLUv/aFplpHzf9aNS7Mr74ZsakDB7w6AovoW8DN8dLc1jTdm1iiTXgBUw10ULZTHm7NBCSYgVlv7h87o4/Fy1iuPHFfLrTTtuZadJ+I7mMFmRgjVCon5Nq5xMxIFLL4LT3OgWRZNJa3+5/HCORIeUuOVO2u1Nhb/6l+EtgyeSpR6jLGyX6ptAmB1KJ/A8LNMB/aF6clAdujngR6n/rK9e96BBBaBUoFi963l0ske25cjKe4zdZwXF1r5jlVxfbc5L/3NnIADy9l+M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:27:49.9612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c08d07-f597-46dd-81ba-08ded1fcc4fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838
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

with different domain.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Vladimir Indic <vladimir.indic@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 +++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_events.c          |  5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 10 +++++-----
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 5b49fa50a47d..e40e71f35bb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -336,9 +336,9 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
-					     void **kptr, uint64_t *size);
-void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
+int amdgpu_amdkfd_gpuvm_map_bo_to_kernel(struct kgd_mem *mem,
+					     void **kptr, uint64_t *size, uint32_t domain);
+void amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(struct kgd_mem *mem);
 
 int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 5bb3e28441a5..ec0901aa923c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2271,11 +2271,12 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo
 	return ret;
 }
 
-/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Map a GTT BO for kernel CPU access
+/** amdgpu_amdkfd_gpuvm_map_bo_to_kernel() - Map a GTT BO for kernel CPU access
  *
  * @mem: Buffer object to be mapped for CPU access
  * @kptr[out]: pointer in kernel CPU address space
  * @size[out]: size of the buffer
+ * @domain[IN]: domain of the buffer
  *
  * Pins the BO and maps it for kernel CPU access. The eviction fence is removed
  * from the BO, since pinned BOs cannot be evicted. The bo must remain on the
@@ -2284,8 +2285,8 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo
  *
  * Return: 0 on success, error code on failure
  */
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
-					     void **kptr, uint64_t *size)
+int amdgpu_amdkfd_gpuvm_map_bo_to_kernel(struct kgd_mem *mem,
+					     void **kptr, uint64_t *size, uint32_t domain)
 {
 	int ret;
 	struct amdgpu_bo *bo = mem->bo;
@@ -2303,7 +2304,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
 		goto bo_reserve_failed;
 	}
 
-	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	ret = amdgpu_bo_pin(bo, domain);
 	if (ret) {
 		pr_err("Failed to pin bo. ret %d\n", ret);
 		goto pin_failed;
@@ -2336,7 +2337,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
 	return ret;
 }
 
-/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Unmap a GTT BO for kernel CPU access
+/** amdgpu_amdkfd_gpuvm_map_bo_to_kernel() - Unmap a GTT BO for kernel CPU access
  *
  * @mem: Buffer object to be unmapped for CPU access
  *
@@ -2344,7 +2345,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
  * eviction fence, so this function should only be used for cleanup before the
  * BO is destroyed.
  */
-void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
+void amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(struct kgd_mem *mem)
 {
 	struct amdgpu_bo *bo = mem->bo;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 3ffe9a52f3e1..d6fa5d71f581 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -314,7 +314,8 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 		return -EINVAL;
 	}
 
-	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(mem, &kern_addr, &size);
+	err = amdgpu_amdkfd_gpuvm_map_bo_to_kernel(mem, &kern_addr, &size,
+						AMDGPU_GEM_DOMAIN_GTT);
 	if (err) {
 		pr_err("Failed to map event page to kernel\n");
 		return err;
@@ -323,7 +324,7 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 	err = kfd_event_page_set(p, kern_addr, size, event_page_offset);
 	if (err) {
 		pr_err("Failed to set event page\n");
-		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
+		amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
 		return err;
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 71b36a4613fa..21a90fc3adff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -736,7 +736,7 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
 	struct kfd_node *dev = pdd->dev;
 
 	if (kptr && *kptr) {
-		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
+		amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
 		*kptr = NULL;
 	}
 
@@ -776,10 +776,10 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	}
 
 	if (kptr) {
-		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(
-				(struct kgd_mem *)*mem, kptr, NULL);
+		err = amdgpu_amdkfd_gpuvm_map_bo_to_kernel(
+				(struct kgd_mem *)*mem, kptr, NULL, domain);
 		if (err) {
-			pr_debug("Map GTT BO to kernel failed\n");
+			pr_debug("Map BO to kernel failed\n");
 			goto sync_memory_failed;
 		}
 	}
@@ -1140,7 +1140,7 @@ static void kfd_process_kunmap_signal_bo(struct kfd_process *p)
 	if (!mem)
 		goto out;
 
-	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
+	amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
 
 out:
 	mutex_unlock(&p->mutex);
-- 
2.43.0

