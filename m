Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2648C83000
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E3310E93F;
	Fri, 27 Jun 2025 03:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FUX47MIV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E81B10E93D
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhTpeHRC/aHonBHPks00ovKYH2jhgqymb5GcPfr2Ytva26wKdz0lDIeNlktlZMXMSha3STtJey4efvaUP6nKtkbtus3qDkF6SJhte0j1Xg/vqrBP6Q6TI/nNVNtKTKUKkUDn31PuZ+82Ojyl5KKOkZekNDROSBAK31IbaDNwV7eLUKiMLTkt1/ScdIbBIXzw5UWCvBJHCIvZ6KDFNq0xMxqbC0Ft1z7wkDuIp3cKVtbWsrkr6UDp8ZXiC/CBvulX5T0llHzdDnyWFj5nEAPjgKYUhqjA7Sa84m2BAa8Sazxa5j9fbdTiM0vewHN5UkE9lQqaXGjIfaexHVoiI43+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNQhmTGE5GpvQdGJzKWGWZl16TJpNbFZA2aTdT2bAEw=;
 b=meQdydC+9dYFB3c3bUoQkMi9pWw+Mlvysz3MXdakhfEuX3o0ct70RbEsJRdnxo6Sitl3HZZFEPrkBg/neiAxTGot/a0AjDU+7+xwtKyJG9SRXYHUFzdm4s1HxK1YruLZaoFeLHyaxo2QPNIKYUN3gk4RTi1/bsMED7Nbl34ayFPUimpTsNz4MbVTvYJCwCFrlnQKI5K1xemVizx8aVsCIOht5PVFys82bS3Ep1UqU3SKPu8pGvJeTHlTaXrFLj+auuSrYA/ZTQpA3mUPOxGO1tSZpAV57et+z6ebDuj/qv6mTEMNkti+QPSvr6LcPcle1K1VcZNHWy+gEZycfTIaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNQhmTGE5GpvQdGJzKWGWZl16TJpNbFZA2aTdT2bAEw=;
 b=FUX47MIVRmneziE3neCm/hg2bvk9mnVDHlazbJXNBOEcTBR55bLVA6nCpNFmSKrTrXKWBq/6NDB2zhouo9yJUPiPbECOLD0sylVckhOlAfOihAPNMr1HpvPTRVfb0dbRAT/h6Ui7iHRWzJCRMwM0DRKFGJfVn/fPOgMFNJxJZvU=
Received: from MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 03:40:26 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::78) by MN2PR08CA0019.outlook.office365.com
 (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Fri,
 27 Jun 2025 03:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/33] drm/amdgpu/sdma6: clean up resume code
Date: Thu, 26 Jun 2025 23:39:35 -0400
Message-ID: <20250627034002.5590-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: de2b2308-1a1d-41db-c782-08ddb52c5b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?czavy13TDvhsIhMUVFckaAio1KeAEmGxG2dESowXrUqeinSUfFhXD36czpxy?=
 =?us-ascii?Q?KwA4J6NamcCbGbz9wYICpD0ygOEoly4SBBwkKI7HeVq45PpLZ++UTR4ktpgP?=
 =?us-ascii?Q?p9JLsctvoPlFtj0fQOUADwsHQeGKYC5L9gJSxu93VxiEDmm64tqaLLfSHAqI?=
 =?us-ascii?Q?TcFax21gQrYBwZmL9CkROFV1z2LAW9y3pR91a8gb6SJK4vCPJtLdxc5M49wT?=
 =?us-ascii?Q?ubneku8oYSEbvOEjBw/CCGKwFT3qoFo/mGBRbRBGidULfr7kudf7eUqZLFJc?=
 =?us-ascii?Q?4MapOCf0w/s9ue0euKcQfjwKojxwu7/j3++z3L1RJ0KD4OkyWWZJ+Zsdtmkd?=
 =?us-ascii?Q?R5kktGglsfFjtoHJcRcugl5mByg6qyfkvTQC2J7puUacrtxfmI2wYzw/2Ray?=
 =?us-ascii?Q?uE+bdtqRm2gQk8imslZGLcNNwhaFCE5x37PBNmZPBvbwUgpTv63mFfHL65/V?=
 =?us-ascii?Q?qOzdwv2r50oMQO5Z6IkCi/TLGUDZPHyZ2tbdeLf+xLlv98E4ZN31JSGT9JvR?=
 =?us-ascii?Q?4BWPaCypm25utKO4ulySXZDEbWyJT3wDyP83VIO9z0zRQbkGg+7goRmMwzjS?=
 =?us-ascii?Q?60EJormGldblaauS5cciDuwBTEoTRRSRXEtJXGVaAzv46NF9W9vsZINZ0tjF?=
 =?us-ascii?Q?2Fq7QVwV/01nGOVwDEWZCPdtAVV+O301zdfPgLQNl/tnB8/KolNG0xAwLOuq?=
 =?us-ascii?Q?N0OnaUOCUjvwV57FCA7uces7lWNrXFt9nZWqyKsDyccylA3C0cj4lxR6ra2T?=
 =?us-ascii?Q?GGGOn+4em73oz2IdmOeUt0WxQw+/GugS6zz4It5AQH8SHx8v0vpBMehzK5Qw?=
 =?us-ascii?Q?xfpaNySiv64ILEGr8bJsWx46xvyqU+TNjqwAQtEWjr+p0iw6LkZ3r5Oj/eQb?=
 =?us-ascii?Q?PZq22YLUhMnr/GXLdYYWxJt5WFTi/HoZnrfqTIr01WjaavROSbSZJbGEXDzr?=
 =?us-ascii?Q?GAD8/3t5yaP8g81ZEoEE7Tt/yn/Ca+LzHXbk0anaJbE5b7qfG60RZR/V9g1q?=
 =?us-ascii?Q?7foPsUwjAOIKdimAPacZjYJV/AGESIuLM0jrheX23yu8lKpEajDLZqQUsjp8?=
 =?us-ascii?Q?ZBhMnjNrL/Agk/0q+QlKxsKcVjOVmYuM7su87yUJw1lCslWw7AQs+aK/6EAP?=
 =?us-ascii?Q?Fuu9VrLTdTAEPSA60798cgWdih3d7jzLJDZ5TY3oWM6SzpJxttPZDGp+8Isl?=
 =?us-ascii?Q?o9lrGjQNGuZz8kSS6om+WmQyclKQCL5uoXyaP1kfjdVRDQdENJaRbKhLK2Yx?=
 =?us-ascii?Q?L4HPBVP4ANN+pQZeZblgWwli26Cv5GceaWKNpJY/HMobLBQjOnRRJMbAd6ZA?=
 =?us-ascii?Q?zARBxkMlW1qtRJ2oD0EudrRZz/+bROcCs/SDpoN+iZuRMtzD+RHp4fVneK5u?=
 =?us-ascii?Q?MeanFnY46Yp+CCc83hIzDdQBzolZwiGxQ+mydl4sXb2HjmO1B7zfkBgkHh8u?=
 =?us-ascii?Q?Mn0F1YC006oz+qmtKiu7y9yTd9TAs6cK27iZu7guYcw4omc7lmPZaWk/Xz2o?=
 =?us-ascii?Q?ZMg6p11fUyRo9em9pMbGI2s4inNDqFzkNfP5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:26.6471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de2b2308-1a1d-41db-c782-08ddb52c5b07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
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

There no need to save the ring ptrs.  Just reset them.
This cleans up a conditional in the resume code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 27 +++++++++-----------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 103e5ec7aa63b..455f1a8a07ad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -474,12 +474,11 @@ static void sdma_v6_0_enable(struct amdgpu_device *adev, bool enable)
  *
  * @adev: amdgpu_device pointer
  * @i: instance
- * @restore: used to restore wptr when restart
  *
- * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
+ * Set up the gfx DMA ring buffers and enable them.
  * Return 0 for success.
  */
-static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
+static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i)
 {
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
@@ -506,17 +505,10 @@ static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
 
 	/* Initialize the ring buffer's read and write pointers */
-	if (restore) {
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
-	} else {
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
-	}
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
 	/* setup the wptr shadow polling */
 	wptr_gpu_addr = ring->wptr_gpu_addr;
 	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
@@ -537,8 +529,7 @@ static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
 	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
 
-	if (!restore)
-		ring->wptr = 0;
+	ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
@@ -633,7 +624,7 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		r = sdma_v6_0_gfx_resume_instance(adev, i, false);
+		r = sdma_v6_0_gfx_resume_instance(adev, i);
 		if (r)
 			return r;
 	}
@@ -1592,7 +1583,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v6_0_gfx_resume_instance(adev, i);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
-- 
2.50.0

