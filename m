Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B50CDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 07:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5743A10F156;
	Thu, 25 Jun 2026 07:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f8CGOlUD";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29FD410F156
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 07:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9+mpiSm8bnZM0W2A1gmpexzOE7QdNvo4gCmejtz1zWj9WqgpB0lpcY5Idxei2HLDschTBtjC3rT1Aq84XPUKLUarAlbbX1/vRrqBkf6TZa/emzOlSOilUnVJWxaNQBuD/794Wv6Qhfk46Z0gYkxBKvAmfxbaZN8I+CctUNLEF3jRa+7ini0r1xHbCGbdJR/xLItU4deiods27NxBc15GKhmPyJcwdsDVO4NbOcst6VXlYcRKK2zy0dMpf0sKmMKNpMPeLS/tge0kPken6e4Lf9YvB2s9U7QVtUbLSmmePwFiSNQERADfqfHqYxsiCKGz4L0XbH8qOfPJHWhDw1LlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2GJX1AOy/c4nmbYwuePRn4s3+3nWeet0m61tyuJQYQ=;
 b=bODXsgunpAAbTlU4fOi0/idC+vW8q+qV7MkXKzdI83QghGuVkuUOHxUIHuMap6t/47DFnUlMfYHvJOj0k246PnT4V9kC2LnVbtAEPPwcqdrQZF4hy+PCXIR2YoRwg/4LgmQysNDSWjtI3tuzale8zVfw6jfTy95juqJ0WP0Uin5p2bI740FTqT07ymSkiP4rL8aRUclo5QtzargfHwKG7+YVtdWHhBhVhcvJHRT/r3gfZPHcaM8G8jwk7YKzjfr6xbVIvcdMJJPebzNskzZnKnhxOab5mxNeTBA8MW4J5tarDiPof06H64zdaDjCBGvpAvqitVf4u2MjuHkscc6fMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2GJX1AOy/c4nmbYwuePRn4s3+3nWeet0m61tyuJQYQ=;
 b=f8CGOlUDLkDQ5/bZmkNRIhvEOaEdnMZJOP5wQw8bc7nIF6Jgnn5NEiiHbwItALB33wo2Lzj5F6h1rFfD4DBIcVaWmgNUwhJuU321H5+Kucs7dyDpeXzr+TXumi79aUFbF7yiWtND/CnilynYHslkaZbl6Dq7Z2NmIBkYftmbLIA=
Received: from DS1PR07CA0012.namprd07.prod.outlook.com (2603:10b6:8:456::12)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 07:27:30 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:8:456:cafe::12) by DS1PR07CA0012.outlook.office365.com
 (2603:10b6:8:456::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 07:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 07:27:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 02:27:27 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 25 Jun 2026 02:27:26 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] Revert "drm/amdgpu: defer KCQ remap until after MES
 resume in reset flow"
Date: Thu, 25 Jun 2026 15:27:08 +0800
Message-ID: <20260625072723.1919513-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260625072723.1919513-1-Jesse.Zhang@amd.com>
References: <20260625072723.1919513-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: d3537cb7-10d0-48bb-e2c1-08ded28b36e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: vOyONB8Ip65xG0UgNP6OqzYrHAt/lXqYzfsPhcPC1a/OpmlxbD8YFKhxvf+wsr1uCu5nss6uWDKfsY2GuxlRz4Pe6JfQmF9nksND529sfFirvLyjPSWRAHfDZssIY7CiIlljEAG6KzeVlQM7IX9CIiw8rTV+UmLVwUk8TK5Tz7Fa6qabGQP4xa0PpLoHLa8toZeQ549h+Y3GIahIaQwDPnFgtiFL+GklrWU6Yvnz53Q1uZFEALIsSisR9ZjbVZYKo5yb4VK9YYHqGMQj8ScTTJMKZeungFUk63DV7LxNhqAIR/FD3mQ44UqWkxPMORBeLYfiFEl8Z+ltDMdXMeSR8NULWlwcCpvg1nMrq05+WJsQ9eCl1c9fMhZv0pjBzh34+o35ydbCUDhgjjzn/jfmd9DkNU0HU9IRD6fL4w2Zi2fGv5LEto1eoruHito3iziumJs2WENK9Y84wqSQ4Cks/1Yt6B2bGQf/J5gJInTiTQv3Nnt5UzIkJVrf9sSy/105d9WNo3o86hYRkjHnr4h96kltNf/mUmnTpSH9WFIyMmTTDr+4mfDQeFB59NFMbwDyqsEaf0BGRgvD/oo+sRfEJPwzCl54H1aouAqmGsWq8TBcXc2XKoTwK3BrBnaG99BJj1NG3RUpoecBiAOSU4A8JkPYPQLGYFabNFEi0IMScnzLKKm378KqCFk8O8FLy76Y0QTCFX4WeHyhDPv8Df9rsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3Ha0Q8fymKgj+9NNbktPgjFOEpJ1k0VQstM4LgyrBSCedVJ4tIiRgaM+RiHNlbN6GTUzi9w0NRZ/3dUyHXCNFaxL0JEu+J5jhPyg/FRqI3jKBfh6kLmi3NVtufcsqIF3U0yQX2z7M9oiJv8MgQL5hfAd9B42PL4Q8ccyJB7Eu45F0DQ6FG1dHUaFdueVYRAV00Jzyd668tLAqAFLoZhqTWZiCboUKL+4TC0eLSska5BMSSuE7zNgL7jVChHlvZqlZvSt32THF/lhUu9dGpWN4Y2p8dbQ4vjGFEW452gV1Xlsr2S5EyJq2/UPdRxxDLuw4vszLR+dNmBgrg0csGhN4lNb0DS4DLCKefzbAoDMBO7/lL0S0PVX3/o3Lv6CZpbBMOnXPM1ZVI7A0BBKwfZT3JG4EBAfhGlIYMFu9TExY84QrP1+zI8mXxZNotJYgbH2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:27:29.5564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3537cb7-10d0-48bb-e2c1-08ded28b36e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
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

This reverts commit 5d95aa4278be.
It introduced a regression issue on gfx11.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 70 ++++++-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 -
 2 files changed, 16 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a3e76bd85401..0506b90f318e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1989,24 +1989,10 @@ static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
 	return amdgpu_show_reset_mask(buf, adev->gfx.compute_supported_reset);
 }
 
-static int amdgpu_gfx_mes_reset_queue_reinit(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	int r;
-
-	amdgpu_gfx_mqd_reset_restore(ring);
-
-	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-	if (r)
-		dev_err(adev->dev, "failed to remap kgq\n");
-
-	return r;
-}
-
 static int amdgpu_gfx_mes_reset_queue_start(struct amdgpu_ring *ring,
 					     unsigned int vmid,
 					     struct amdgpu_fence *timedout_fence,
-					     bool use_mmio, bool *need_reinit)
+					     bool use_mmio)
 {
 	struct amdgpu_device *adev = ring->adev;
 	bool reinit_queue;
@@ -2021,9 +2007,6 @@ static int amdgpu_gfx_mes_reset_queue_start(struct amdgpu_ring *ring,
 	else
 		reinit_queue = use_mmio;
 
-	if (need_reinit)
-		*need_reinit = false;
-
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
@@ -2035,9 +2018,13 @@ static int amdgpu_gfx_mes_reset_queue_start(struct amdgpu_ring *ring,
 						  RESET_QUEUES, 0, 0, 0);
 		if (r)
 			return r;
+		amdgpu_gfx_mqd_reset_restore(ring);
 
-		if (need_reinit)
-			*need_reinit = true;
+		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+		if (r) {
+			dev_err(adev->dev, "failed to remap kgq\n");
+			return r;
+		}
 	}
 	return 0;
 }
@@ -2047,19 +2034,12 @@ int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence,
 			       bool use_mmio)
 {
-	bool need_reinit;
 	int r;
 
-	/* Single-queue reset (no suspend/resume): re-add the queue inline. */
 	r = amdgpu_gfx_mes_reset_queue_start(ring, vmid, timedout_fence,
-					      use_mmio, &need_reinit);
+					      use_mmio);
 	if (r)
 		return r;
-	if (need_reinit) {
-		r = amdgpu_gfx_mes_reset_queue_reinit(ring);
-		if (r)
-			return r;
-	}
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
@@ -2259,8 +2239,7 @@ static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_device *adev,
 				    struct amdgpu_ring *guilty_ring,
 				    unsigned int db,
 				    struct amdgpu_ring **out_ring,
-				    struct amdgpu_fence **out_fence,
-				    bool *out_reinit)
+				    struct amdgpu_fence **out_fence)
 {
 	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
 	struct amdgpu_fence *fence;
@@ -2269,16 +2248,14 @@ static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_device *adev,
 
 	*out_ring = NULL;
 	*out_fence = NULL;
-	*out_reinit = false;
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
 		if (ring == guilty_ring)
 			continue;
 		if (ring->doorbell_index == db) {
 			fence = amdgpu_ring_find_guilty_fence(ring);
-			/* reset + unmap now; re-add (map) is deferred to after resume */
 			r = amdgpu_gfx_mes_reset_queue_start(ring, 0, fence,
-							      use_mmio, out_reinit);
+							      use_mmio);
 			if (r)
 				return r;
 			*out_ring = ring;
@@ -2329,16 +2306,12 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 fence_reset:
 	/* reset the queue this came from if specified */
 	if (ring) {
-		bool reinit = false;
-
-		/* reset + unmap now; re-add (map) is deferred to after resume */
 		r = amdgpu_gfx_mes_reset_queue_start(ring, 0, guilty_fence,
-						      use_mmio, &reinit);
+						      use_mmio);
 		if (r)
 			goto out;
 		deferred_end[n_deferred].ring = ring;
 		deferred_end[n_deferred].fence = guilty_fence;
-		deferred_end[n_deferred].reinit = reinit;
 		n_deferred++;
 	}
 	if (uq) {
@@ -2349,7 +2322,6 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	for (i = 0; i < num_hung; i++) {
 		struct amdgpu_ring *hr = NULL;
 		struct amdgpu_fence *hf = NULL;
-		bool hr_reinit = false;
 
 		pipe = hqd_info[i].pipe_index;
 		queue = hqd_info[i].queue_index;
@@ -2358,13 +2330,12 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 		/* reset any KCQs */
 		r = amdgpu_gfx_reset_mes_kcq(adev, ring,
 					     adev->gfx.mec.mes_hung_db_array[i],
-					     &hr, &hf, &hr_reinit);
+					     &hr, &hf);
 		if (r)
 			goto out;
 		if (hr) {
 			deferred_end[n_deferred].ring = hr;
 			deferred_end[n_deferred].fence = hf;
-			deferred_end[n_deferred].reinit = hr_reinit;
 			n_deferred++;
 		}
 		/* reset any KFD queues */
@@ -2396,21 +2367,12 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	/* resume all will enable the non-hung queues */
 	amdgpu_mes_resume(adev, 0);
 
-	/* Now CP is running again — for queues that were unmapped during the
-	 * reset, re-add (map) them only now that MES is resumed and back to a
-	 * normal state, then replay backed-up commands and ring doorbells on
-	 * each reset queue.
+	/* Now CP is running again — replay backed-up commands and ring
+	 * doorbells on each reset queue.
 	 */
 	for (i = 0; i < n_deferred; i++) {
-		int er;
-
-		if (deferred_end[i].reinit) {
-			er = amdgpu_gfx_mes_reset_queue_reinit(deferred_end[i].ring);
-			if (er && !r)
-				r = er;
-		}
-		er = amdgpu_ring_reset_helper_end(deferred_end[i].ring,
-						  deferred_end[i].fence);
+		int er = amdgpu_ring_reset_helper_end(deferred_end[i].ring,
+						      deferred_end[i].fence);
 		if (er && !r)
 			r = er;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 9432107c96a1..aefd4f03b443 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -550,7 +550,6 @@ struct amdgpu_gfx {
 struct amdgpu_gfx_deferred_entry {
 	struct amdgpu_ring	*ring;
 	struct amdgpu_fence	*fence;
-	bool			reinit;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
-- 
2.49.0

