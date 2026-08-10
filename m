Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568B9C5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFA410E5E5;
	Mon, 10 Aug 2026 03:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TfMtiXr7";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010033.outbound.protection.outlook.com
 [40.93.198.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2949010E5EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0H9MO4dxDy+bxc4zgvncMI8vWkrH0y3KZ2TKYXvRSI/pp8bytVlqXD9ll+MsU3Ss+qcHy9PCGunpve0w654TrJDSVdjZkxC/uAUwLJQ8ps4HyT5h97atnShXrFwRF3pmb/akTawpNlfUst1C92Gtop+CgoG+FDZQFl4prY6h6wqA6ANQM819ZAuvYsOIiSt5sT+xsA0/P415XzK1vL/E7KIVuKTICbRRMuU7qsE4mRP8064Szs/7BhsO0V9JcLfq+giFxTZlCZUDTer4DeNimDwC4EfbkiSNfwigLj+dvPrfS7g4vCrTwRsOCxQbcBcIUa0gspmmvwruyFYc0SWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znyZd1E5WRZO+FRPosZFsSC8qokBJyP5iu807WKcQKE=;
 b=hjmYcmVe1l+GSMmcipikGxkpx0SllKRT/PozfmGaL9G5MHdOg0n743dr1Aqpku37FPZwMztlizOEjEHOH/TiiWfRcjDqvn5lPpBYkw8BAPU/yRRMCA98Mu8IMLToMD5WBGeI2+0LlndjXEbHKTFYm2R+K/5Li+nMvjNNXdBsU4fX5JO2f5mn6k0EnyPIEjNEL9rroQ0lsvPhgjyQYSnV+sjWLaUaNi/IlnopiY3MsFN/oTFdLdU3wb6qdbUGa74MWDJ6vpASCLmkaA8CA1WDSgkvmoKpBH+GFUnApKnbwqraxBAM7FvGjDWBJ4/Fd9InRXIloJX8tUXXBhkfOWRSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znyZd1E5WRZO+FRPosZFsSC8qokBJyP5iu807WKcQKE=;
 b=TfMtiXr7GwQcjIe5p4xfo1tTbvbBnjkPbnWb2NdOTFbv/GgCiaOOeZJwcApbWdJirOBjvoiIVPATjJiE60iTluHQxi2ayxsH3cZavRPe6STN0WNjVSR5njSKMhxuRpTys1kACmYCfpwWS4DxV9fW+0ufhKDNFw/FA9CcpCoR0D4=
Received: from DM6PR06CA0079.namprd06.prod.outlook.com (2603:10b6:5:336::12)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:41:13 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::ab) by DM6PR06CA0079.outlook.office365.com
 (2603:10b6:5:336::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:41:12 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 9 Aug
 2026 22:41:09 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>
Subject: [PATCH 12/13] drm/amdgpu: Jpeg uses shard VM invalidation engine
Date: Sun, 9 Aug 2026 23:36:43 -0400
Message-ID: <20260810033644.118194-12-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810033644.118194-1-boyuan.zhang@amd.com>
References: <20260810033644.118194-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: f6538266-49ec-42bf-c8cd-08def6913993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: HYIqoAkcTAT75vLxxsyHZ0tHd/24S54iZ71CKzlYG3oFUCI6Brf8MFs6Sp8pYgxqjGUoyBcDd+DU8U7nZCLzQQJ+I21XTHS2WEbGggdcQ2QjpF17G9X5qmY0OMQ9JE3Vr01Wsqi6WTKxifxMIN0eZSHXU45ai7oPS3O+3RMcrAP37XpXAdfS7y129guASxL3djTD/yf+5FeTGRhz5C4RcNi6/aDbv2g6HqipcxNMWOxC3f99WKr82po8gI0gfzDlVkZO9t8iYHw2Vb9o49xGKJWmSmb8r9tG50+0IxJB8T9+hoTk4PHdq8DQGka6K9H/8SwflXUA9rpbebgN7ASAKnW73HmhOnIs4IIpzn7KPXr3gfrbXyAn/IcXYUDDZZYmNbvx8jGDWt4KkJ9DIxRzuRvVKOUhBs9KEZoZjfJft015iFPJ8Mk8xxFPcIxLjqzt+Xko4BkasmjxuwKYlzc4OnKnwEpAecTa1j2P96jc4gfZOnhulLz7iMrD5bY/lCPGuS25PdrkA+pkrt65+4LlQXvjEs95GKwUFFDm/n3VUat7BdUUCg3mFjkQlfUVVCW8E2e8gotCyNQAadCgpWl686O7dPicLM1NTzbAG7ExUrnOhgkqcjZ8AXZZtaIyRR7BlNbzZi9PyHZwA4/OXVpeVWQgiUQ2Oj6FjO3MR2CuYoQfdxpd2q6DsU9KTP8w1H3kZq97s1Yl6A6dEYid4iQnaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uWlZ16uYOdRdUMkkX6Sj4yoTfkssiqg/qLdyA9rINObf89hJdvKfTfhAFVHWMkDogB7a3lv+cClIPI801rBqyIS5Euo125UKkt/RuTw6SoRKUcN9u6ims5Pv2eqUN4gNAUQM53ZhJgVeXTnK3e4Tnj4BGPGt8XmnsKh+fxhAsejvmkrNtWqf5EE0QAC1Wiy6GCGGVZS0k31SIZ4i/0WkurQexoefM7NdR8RTzWlDzbXAKDoM4NbxGfnghrLg+Pe2IVYGA19I7jeeFe1rxCWSeJ8QqbMjHTRLhmLspHAtZWaeks4Z/JnaP44b0yMy8vkTqjZzVe/jyU/vgJuF1PJyMFY8D+pdWOYsb9cnhczvPaxV1NmGD8dUA1s6fM61eAOq2NyUt5beLfxQlNr1MXio5qpjkjH9txhOMEpCe4IegHQG2lMTNiceymsUVQTQ3ysO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:41:12.8991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6538266-49ec-42bf-c8cd-08def6913993
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045
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

From: Sonny Jiang <sonny.jiang@amd.com>

JPEG 5_0_2 has 2 instances per die. Each instance has 10 rings.
Each ring consuming a unique VM invalidation engine exhausts the
available engines per MMHUB.

All rings within a JPEG instance can safely share one engine since
MMHUB serializes concurrent invalidation requests via hardware
semaphore (see "drm/amdgpu: add invalidate semaphore support for
gmc v12.1").

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  9 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 38 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  2 ++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3dc8faa091d7..2f6d20c00ce2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -672,7 +672,8 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 			continue;
 
 		/* Skip if the ring is a shared ring */
-		if (amdgpu_sdma_is_shared_inv_eng(adev, ring))
+		if (amdgpu_sdma_is_shared_inv_eng(adev, ring) ||
+		    amdgpu_jpeg_is_shared_inv_eng(adev, ring))
 			continue;
 
 		inv_eng = ffs(vm_inv_engs[vmhub]);
@@ -702,6 +703,12 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 					ring->name, ring->vm_inv_eng, shared_ring->name, ring->vm_hub);
 			continue;
 		}
+
+		/* All decode rings within one JPEG instance share one VM
+		 * invalidation engine (no-op unless ring is a JPEG instance's
+		 * first ring).
+		 */
+		amdgpu_jpeg_set_shared_inv_eng(adev, ring);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 363b99168478..208566ffe898 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -607,3 +607,41 @@ int amdgpu_jpeg_dec_parse_cs(struct amdgpu_cs_parser *parser,
 
 	return 0;
 }
+
+/**
+ * amdgpu_jpeg_is_shared_inv_eng - Check if a ring is a JPEG ring that shares a VM invalidation
+ * engine
+ * @adev: Pointer to the AMDGPU device structure
+ * @ring: Pointer to the ring structure to check
+ *
+ * All decode rings within one JPEG instance share a single VM invalidation
+ * engine (see amdgpu_jpeg_set_shared_inv_eng()). This returns true for every
+ * ring in the instance except the first (ring->pipe == 0), which owns the
+ * engine allocated by amdgpu_gmc_allocate_vm_inv_eng().
+ */
+bool amdgpu_jpeg_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring)
+{
+	return ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG && ring->pipe != 0;
+}
+
+/**
+ * amdgpu_jpeg_set_shared_inv_eng - Propagate a VM invalidation engine to the rest of a JPEG
+ * instance
+ * @adev: Pointer to the AMDGPU device structure
+ * @ring: Pointer to the ring that just had a VM invalidation engine allocated
+ *
+ * No-op unless @ring is the owner (ring->pipe == 0) of a JPEG instance.
+ * When it is, mirrors its freshly allocated vm_inv_eng onto the rest of the
+ * rings in that instance, so the whole instance shares one engine instead of
+ * consuming one per ring.
+ */
+void amdgpu_jpeg_set_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring)
+{
+	int j;
+
+	if (ring->funcs->type != AMDGPU_RING_TYPE_VCN_JPEG || ring->pipe != 0)
+		return;
+
+	for (j = 1; j < adev->jpeg.num_jpeg_rings; j++)
+		adev->jpeg.inst[ring->me].ring_dec[j].vm_inv_eng = ring->vm_inv_eng;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index fe95d9188713..05d58e6bbfab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -183,5 +183,7 @@ void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_pri
 int amdgpu_jpeg_dec_parse_cs(struct amdgpu_cs_parser *parser,
 			     struct amdgpu_job *job,
 			     struct amdgpu_ib *ib);
+bool amdgpu_jpeg_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring);
+void amdgpu_jpeg_set_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 
 #endif /*__AMDGPU_JPEG_H__*/
-- 
2.43.0

