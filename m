Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7129606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZlL9tiv/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185341121E2;
	Thu, 26 Nov 2026 09:34:37 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6D41121C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5vfzckf+huEsv8cfU2LGsjI6IECZqE7J9AZR8QbANh+4QHroU4Ko61a6ikxfvthgf4V5aBlG+Yir60l0bPPajlzR6sFuyU20FLJ16tQdG3/IVEEINHqIHzN68AXPzHABXCYEdEICrPuiNYTeNYYqtxPj11S4uzMz18iz78MCHBVmJtmql2pQ66OIctEwHah/OrR3UnPY/K4Ie1T5WeJk0lFqUv+4kWSt9jKmQV7pik+34fcE4AUmQuv4wWce2UxTklaEPSwnMz28+trJaBJY41YvBUULqf+etJe6yDKLnDVNqpP8PPcM88+vZQqRT+vzxgmQKUxuxd1T8OToZS3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czoT0Y9mEwu03Z0ehEBJltNy/Bak6ai5y9qLGx2cpvg=;
 b=VWE17K4M8Nk3QgocNs1twhe73d97o655NOayFdvR/fIWBr5Bn7rwUWLeS4ap6lHSo6OCnvtV3I0fmSk7VhJx+Se5UTsadbx9J1mMnMbP770d1A9dwFTd2X7h+wvRdxfN8Jh1ES4s5e+V0em4hLQFHY+GKnMvicYBpVu987gl9qGmm8tEMPto62mePUpelE5turrq8VB5x16ZPbtdLtY57uMzY7HB3qnrv7ZdYpSSLhfxmAnaOLPkENtTaOcT9wpbiZlD8UrESBs0s/BwnERiwN1tcW2/NYAxy5lOMVBrRk2z5kleCPSAt9AnOKbwDIEbfFMSbmBrvNCyvH0KweD8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czoT0Y9mEwu03Z0ehEBJltNy/Bak6ai5y9qLGx2cpvg=;
 b=ZlL9tiv/e5qgUwTzqbcyaE4ksJTOwgbX9/UcrkU/HvGNSSxPUaOSnUWfNZ58wiaKBjkdXGUVCWSnIMzvxIXyUoqwG5WFKUyOEspdhX4O1S1CUdrcobGsddBDk00qqSmex26x0tuYxbdoXK1Uv02WClq0EEsepA8inZpfxFzHYY4=
Received: from CH5PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:1f4::24)
 by BL4PR12MB9722.namprd12.prod.outlook.com (2603:10b6:208:4ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:34:26 +0000
Received: from CH7PEPF00000019.namprd21.prod.outlook.com
 (2603:10b6:610:1f4:cafe::55) by CH5PR04CA0016.outlook.office365.com
 (2603:10b6:610:1f4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:34:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH7PEPF00000019.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Thu, 26 Nov 2026 09:34:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:25 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:23 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 01/15] drm/amdgpu: pass the device to the multi ring reset
 helpers
Date: Thu, 26 Nov 2026 17:33:37 +0800
Message-ID: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000019:EE_|BL4PR12MB9722:EE_
X-MS-Office365-Filtering-Correlation-Id: b126228a-c620-47d3-c84d-08df4ba07633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|18002099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: N/yCfFrc1lD1AUSn2c+Kunk1weSkJK+ni4LXSfC3nMv5hGVv3uFHya2z3hsACIRWdXqR5QfyALB2A/CERdad8Rxb591/uLs8HYUqbmpRm41865j0PhTkzLojHecHqgc4zItMKBZp0ivH9iQXJwFNDXUtn+edqtf5wCcbJNCF8+08OAE2Ubnhm8HMWQ8WAuCMrwlRo0rF9PCC54qaq9pmywydsmtvZadpcCthyhwsFi6dVg4uYlHWkXySZVkmMuViySocPO/4cAHwq7UqECmsAL6aBoPeX7NtXvmrkRRQHr1AQO+TDpwq7NHEZ/1UwYI4CD4VvaLacswlmWik+hDeRr9uoRFXsOZwTiCxgapmDYjPYuYGKQ+KSnjnkIl+mNFBJzRClaWbIUHHfHF3HKH8qfkYmgznSpP9gqUiufx2E1dQJf89AhR0w9wH/ApjEGvt43Uwy+CcjJ9PV/7LiwPMsxoludL9GzYf+A91q5E5C89JlpON5T9Tz3hPzcvGlyG9RNsXZO4Zlm2gfCXvE8816QzRRkFc7sQ+RQ9v2z2UIytYbMNZF0bBeUMFeiqN5pidWhBkMFnI9AMlVDJk8vg5mMgkpYUrop7MEz3Uz4GdsOPoepC/QKfLlgLnQT/bD6+pwZgOqAYMOriL88zP0LxAdwLOrf84uOTs9zsAgDawp1sWo0jYwBDfVSemNNd+ajHgkvH8SAtb6tyszmS8hv5vWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(18002099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261102123227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /U4vhx5TporhDuYhJGQnd1/gOreCQb0R+Ue96iyChR2D57lZ328veY55StYJKRy1PsQ8VIwuGoOlAV9VYHuQL4CFcF+8PCy0hihb5pDKrupeVB3ofbaXluM0enW9y+O3mUE5D78sX5y+3l4Jq7nWwzm5dxwMJkKH9J8f80va6e4pQMdwKCX9BY2Uj4PJeVHyDwDSOla09d13Oi9WuniDlS3QZnkHQt9V6pruSJxpOOgZLtkjE2zqnwsF57mPyIii4v2ji7iRgcaH1yaNLiBsozwKMV+gjZ/Zv2Kt65rp2Q2kBEGcwFnmE6qiDfbQZWsHBiFbIdP3CG+nTAmidup/6mC8g/QKjLhS3Tv7Va0FZe1g/lVZmbIHf/0T9J2WfXPY/JRu5qWUPyFiB8x0ZIJauPp3vtau4aM2v7Q/4ZbT72Wlk9l1uvLVuKb4VSS5spxa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:34:25.9323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b126228a-c620-47d3-c84d-08df4ba07633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000019.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9722
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_multi_ring_reset_helper_begin() and _end() take the device from
the guilty ring. A reset triggered by a hung user queue has no guilty
kernel ring, so pass the device explicitly and allow a NULL guilty ring.

No functional change.

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 14 ++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  6 ++++--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 734f2a0bc79a..d0b0d3eaffc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -465,11 +465,11 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 	ring_type_mask = amdgpu_ring_mask_from_ip(ip_type);
 
 	amdgpu_device_lock_reset_domain(adev->reset_domain);
-	amdgpu_multi_ring_reset_helper_begin(ring_type_mask, guilty_ring, guilty_fence);
+	amdgpu_multi_ring_reset_helper_begin(adev, ring_type_mask, guilty_ring, guilty_fence);
 
 	r = ip_block->version->funcs->soft_reset(ip_block);
 
-	r = amdgpu_multi_ring_reset_helper_end(ring_type_mask, guilty_ring, r);
+	r = amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask, guilty_ring, r);
 	amdgpu_device_unlock_reset_domain(adev->reset_domain);
 
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 411c74802d20..be91143d9aed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -928,8 +928,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 /**
  * amdgpu_multi_ring_reset_helper_begin() - Prepare multiple rings for a reset.
  *
+ * @adev: amdgpu device
  * @ring_type_mask: Bitmask of affected ring types
- * @guilty_ring: The ring which is guilty of causing a reset.
+ * @guilty_ring: The ring which is guilty of causing a reset, or NULL.
  * @guilty_fence: The fence which didn't signal on the guilty ring.
  *
  * Useful when performing a GPU reset method that affects
@@ -947,11 +948,11 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
  * After the reset is complete, the caller should then call
  * amdgpu_multi_ring_reset_helper_end() to restore the rings.
  */
-void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
+void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
+					  const u32 ring_type_mask,
 					  struct amdgpu_ring *guilty_ring,
 					  struct amdgpu_fence *guilty_fence)
 {
-	struct amdgpu_device *adev = guilty_ring->adev;
 	struct amdgpu_fence *ring_guilty_fence;
 	struct amdgpu_ring *ring;
 	bool rings_busy;
@@ -1043,8 +1044,9 @@ void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
 /**
  * amdgpu_multi_ring_reset_helper_end() - Prepare multiple rings for a reset.
  *
+ * @adev: amdgpu device
  * @ring_type_mask: Bitmask of affected ring types
- * @guilty_ring: The ring which is guilty of causing a reset.
+ * @guilty_ring: The ring which is guilty of causing a reset, or NULL.
  * @ret: Return code from the reset function.
  *
  * After calling amdgpu_multi_ring_reset_helper_begin()
@@ -1055,10 +1057,10 @@ void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
  * be called to restore preemption state, but it won't attempt to
  * fully restore the ring contents.
  */
-int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
+int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
+				       const u32 ring_type_mask,
 				       struct amdgpu_ring *guilty_ring, int ret)
 {
-	struct amdgpu_device *adev = guilty_ring->adev;
 	struct amdgpu_ring *ring;
 	int i, r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 6224a9f94826..db8fbe92a261 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -638,10 +638,12 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence);
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence);
-void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
+void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
+					  const u32 ring_type_mask,
 					  struct amdgpu_ring *guilty_ring,
 					  struct amdgpu_fence *guilty_fence);
-int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
+int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
+				       const u32 ring_type_mask,
 				       struct amdgpu_ring *guilty_ring, int ret);
 bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
 					 u32 reset_type);
-- 
2.50.1

