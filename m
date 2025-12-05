Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D67D2E038
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 08:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71F510EA7E;
	Fri,  5 Dec 2025 08:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BihpVFeu";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967D310EA6B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 08:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuoM4+F/cTNf1LRJ5FpTColCjK605irh5BZBmssdF9sTIjT4Lh4FjqaP8VUEXYgy6auvoMTaaPblCG+qFxCXtN4i7i6c+xzgsszRWUxDFTEqDq4a2ovU0YRdm2TppSazhSTptPxa7+kbGG6bsCrqw21FcMD+VJjIylLvWzrfLuG5xJZRYmZxPKBZpVNzU0U1Lws+8aYTIYZfjXmn0bheBOh/iR8ny5tWR643BQF+yzJX66XsrM5vlMiaodi6ynlSKvsLKlHbzF+hH3zjY5WUisfiF87hhHW337DlL6RQXuWix/6GMSUWklDCT6KIrU1tiRSOlNQfqWiJhKnXYMA8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NufO1bBRlUBcczmLiNNbae52LT8SqlGSl/jP4nY01Rw=;
 b=qXLHaHapLwuOEX/9tihErKWJkVtPiUWVbkRWxtGN0/J8uXumBx18TLjurKK4hhIprpuz6t3ar95MePZ/6+SwMYd4eUGRBl/rCksRIjCEc15r0MGm5WENhFip6iaiQtuslD5IDIhjDLmvgshN6Z+96DWN4eAl5RO9lBGkoGZrjDoZEcCue3cfH0KeSzDp5tccfQ6y7fIGKWKLEYhsApezRKNzEe378Tczoj5BOZqjQf8lMTc5mPDGAgq+4QuMNpOtOIpXW+sU+J30uk0+QJEWh9yw29sBTKO/n3xVBInwmvCJ1dSx5hhuq/ftlBtq8xXNpJWlnqO+qJvZHsZ9iHKgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NufO1bBRlUBcczmLiNNbae52LT8SqlGSl/jP4nY01Rw=;
 b=BihpVFeuiWzSR5XbHzZh+gaQuaBVMOUPBcmNATidu119/CxdO7EMO5UJT+GVNe9AkgJ38aXVcM8mDW0Hs97+84Y5EYlCgX46CvbTGNremHwf6CvbemLbB3RYlbAhzC9NKPxE43hqhSSX7tjmG20y2j2fKqnRUnrcQxlLWz1IhGY=
Received: from CH2PR07CA0034.namprd07.prod.outlook.com (2603:10b6:610:20::47)
 by CH3PR12MB9731.namprd12.prod.outlook.com (2603:10b6:610:253::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 08:35:50 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::67) by CH2PR07CA0034.outlook.office365.com
 (2603:10b6:610:20::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 08:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 08:35:50 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 02:35:48 -0600
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <emily.deng@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: fix mes packet params issue when flush hdp.
Date: Fri, 5 Dec 2025 16:35:21 +0800
Message-ID: <20251205083521.1337481-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|CH3PR12MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: b33b5081-dde4-4e7f-9329-08de33d94bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xHFMJh8VqRGqAHDWjIX9bXOGxmVjuKbR180gAlixZ4BBerfdwmF7KqKo2KoD?=
 =?us-ascii?Q?WoEdWBOy5Rq+qL2ukIStVK/E/2FIa+M4x+kGhEp1AIqbXbIOtO8y5QznRq9c?=
 =?us-ascii?Q?7K3aKOjuvh6KqJ7bKpIBiCuSyrINX9DKWGBxs4t8o66N2xnWM7CPit2TX+gF?=
 =?us-ascii?Q?//OWddSOmuAQHk7M5ftBoyzjNwlx1g1kOIK+wey3fFQ2/Xe2Z0qcWEou2SFI?=
 =?us-ascii?Q?S0JXcpduF7W2SwDU7tFbywpteQvrajchD70kIjPQmel8G7oMSbgF9z9yOEGg?=
 =?us-ascii?Q?Or4hb+fAvqdkrObipp3xWota3DcIjtGNueN9r+vg1eDb8xLZA4O4xKaM3wc4?=
 =?us-ascii?Q?62IWuwd49mfiO7kfOt2Vom98RdI6RbCTuEYZoDNP1QHDk+HocfTyLUlubm/b?=
 =?us-ascii?Q?pngsNd3UsQIeUQs7dKIfOH0cPMWTuwi34zC3fuZBIpfVtbrTEgiqtk2xYp8Y?=
 =?us-ascii?Q?67avlNfUgOUuNlAoQaZc9+xzBRgB+0qTkELkwXJrgh2TYZP7sAjAwi7vsBsQ?=
 =?us-ascii?Q?v125Iif/rt+NO9LV8GyTZfmBmzBHmmFz71JEo9c7TVs8c0jXcgN20o2xRq2j?=
 =?us-ascii?Q?DavjZCNqCRL8kxlMUyEnTNYPn2T2RytOqTAcje+l+NZpNHwIu0pitCgL1KTf?=
 =?us-ascii?Q?iu3HGM2LNWkzymJH90CuDOE99vs7GHyLntmtxXL3s+RT1xqu0gVU1R8YJ+GW?=
 =?us-ascii?Q?/ixi9ICZvv25EbBOuQXC3R9LiAfhFP3w6JEJX5/V0Y9Xv7BM8eQ5qMR+3qg9?=
 =?us-ascii?Q?B/QuBdg9V0ixtiqCcYuVL1YfjG8cZBWPn/c8kVNRVndBFWqcJC7fJnvv7n7x?=
 =?us-ascii?Q?AQAxeJYo0fLqoNk6kdoPuA90kWjr+hcmsma/RoYwrz7w2NwQo5wrboPnM9D1?=
 =?us-ascii?Q?GdqTppfCfs7TOtgKleSE+PYhJNMF9cYiUNc74lnzdvlxde/ZZLa2BJy3NWqD?=
 =?us-ascii?Q?bBTfQUq20e3W8tEzI0inHskMkOOx+lapXsLFTVMYp14E6Wt3wRkNgJj99ydB?=
 =?us-ascii?Q?3m4vkwPJEq8JHayIo6I4wyiiE70qWd4s89YGrMX4mNlEJ9snidA589cEsi2f?=
 =?us-ascii?Q?/FWk5gF+44jfWGnKa1oJSeot+ZQ7ysSg4r/CW/uPuucm1zK6VlbCr1r+g1fU?=
 =?us-ascii?Q?rBG72fkKnbFkdIUJkSz4jeY5GG5gyr+wxC9gsxTD3D62uy85PzwEpA93mSfO?=
 =?us-ascii?Q?8/eIUf8G0DYXPFL07mrgYzgg8elWl2VY/DN+V4EpLm3yOKxtu4a4VDYxVRKQ?=
 =?us-ascii?Q?LQVUrp+yVFEbvj5x86YPqKAv3n6F63hgzSmwo35uDI5qOvouJVF2OjVm2iFj?=
 =?us-ascii?Q?z7xv7PZsAI/vtpBVaC3kBIddC+RvrdAx085FhrB3eBgZLnsDSMpcTgkYLVwJ?=
 =?us-ascii?Q?/+ndNqe0CDmfIXYIK91wIEHJoV3gvOrWoCAq3Y8FzdsqODhMGgwUxXH651eb?=
 =?us-ascii?Q?kYM/Xx6T+soVsbiLm+LYOxaDShEBSzwn9T/JLeaV2Z60beN7xxcxSIeZt8Aj?=
 =?us-ascii?Q?DeOj2PwgTeVLEjw3Qg1ExspVtFaBvXqUXsmE9W0fa5v7rIDqngnzqqqDKKa0?=
 =?us-ascii?Q?KnL71WMZ6KjS+arwXsk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 08:35:50.4103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33b5081-dde4-4e7f-9329-08de33d94bb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9731
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

both gfx ring and mes use cp0 to flush hdp, cause conflict.

use function get_ref_and_mask to assign the cp entry.
reassign mes to use cp8 instead.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  | 15 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 40 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 40 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  3 +-
 8 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 895b841b9626..73305f07ddd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -556,11 +556,22 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 
 int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
 {
-	uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
+	uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
+	struct amdgpu_ring *gfx_ring, *mes_ring;
+	uint32_t ref_and_mask = 0, reg_mem_engine = 0;
+
+	gfx_ring = &adev->gfx.gfx_ring[0];
+	mes_ring = &adev->mes.ring[0];
+
+	if (!gfx_ring->funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "amdgpu_mes_hdp_flush not support \n");
+		return -EINVAL;
+	}
 
 	hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
 	hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
-	ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
+
+	gfx_ring->funcs->get_ref_and_mask(mes_ring, &ref_and_mask, &reg_mem_engine);
 
 	return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
 					     ref_and_mask, ref_and_mask, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index a1fb0fadb6ea..adca4396658e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -250,6 +250,8 @@ struct amdgpu_ring_funcs {
 	void (*emit_vm_flush)(struct amdgpu_ring *ring, unsigned vmid,
 			      uint64_t pd_addr);
 	void (*emit_hdp_flush)(struct amdgpu_ring *ring);
+	void (*get_ref_and_mask)(struct amdgpu_ring *ring,
+				uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
 	void (*emit_gds_switch)(struct amdgpu_ring *ring, uint32_t vmid,
 				uint32_t gds_base, uint32_t gds_size,
 				uint32_t gws_base, uint32_t gws_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index aaed24f7e716..aafd34ddcfcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8616,7 +8616,8 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	u32 ref_and_mask, reg_mem_engine;
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
+	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
 		switch (ring->me) {
 		case 1:
 			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f4d4dd5dd07b..0ada69d0cc68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5829,29 +5829,50 @@ static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	}
 }
 
-static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+/**
+ * gfx_v11_0_ring_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v11_0_ring_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 ref_and_mask, reg_mem_engine;
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+	    ring->funcs->type == AMDGPU_RING_TYPE_MES ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
 		switch (ring->me) {
 		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
 			break;
 		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
+			break;
+		case 3:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
 			break;
 		default:
 			return;
 		}
-		reg_mem_engine = 0;
+		*reg_mem_engine = 0;
 	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
-		reg_mem_engine = 1; /* pfp */
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
+		*reg_mem_engine = 1; /* pfp */
 	}
+}
+
+static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 ref_and_mask, reg_mem_engine;
 
+	ring->funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
@@ -7235,6 +7256,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_vm_flush = gfx_v11_0_ring_emit_vm_flush,
 	.emit_gds_switch = gfx_v11_0_ring_emit_gds_switch,
 	.emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
+	.get_ref_and_mask = gfx_v11_0_ring_get_ref_and_mask,
 	.test_ring = gfx_v11_0_ring_test_ring,
 	.test_ib = gfx_v11_0_ring_test_ib,
 	.insert_nop = gfx_v11_ring_insert_nop,
@@ -7281,6 +7303,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_vm_flush = gfx_v11_0_ring_emit_vm_flush,
 	.emit_gds_switch = gfx_v11_0_ring_emit_gds_switch,
 	.emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
+	.get_ref_and_mask = gfx_v11_0_ring_get_ref_and_mask,
 	.test_ring = gfx_v11_0_ring_test_ring,
 	.test_ib = gfx_v11_0_ring_test_ib,
 	.insert_nop = gfx_v11_ring_insert_nop,
@@ -7323,6 +7346,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
 	.emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
+	.get_ref_and_mask = gfx_v11_0_ring_get_ref_and_mask,
 };
 
 static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f9cae6666697..0bdb4f292dea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4385,29 +4385,50 @@ static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	}
 }
 
-static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+/**
+ * gfx_v12_0_ring_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v12_0_ring_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 ref_and_mask, reg_mem_engine;
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+	    ring->funcs->type == AMDGPU_RING_TYPE_MES ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
 		switch (ring->me) {
 		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
 			break;
 		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
+			break;
+		case 3:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
 			break;
 		default:
 			return;
 		}
-		reg_mem_engine = 0;
+		*reg_mem_engine = 0;
 	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
-		reg_mem_engine = 1; /* pfp */
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
+		*reg_mem_engine = 1; /* pfp */
 	}
+}
+
+static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 ref_and_mask, reg_mem_engine;
 
+	ring->funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
@@ -5515,6 +5536,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_pipeline_sync = gfx_v12_0_ring_emit_pipeline_sync,
 	.emit_vm_flush = gfx_v12_0_ring_emit_vm_flush,
 	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
+	.get_ref_and_mask = gfx_v12_0_ring_get_ref_and_mask,
 	.test_ring = gfx_v12_0_ring_test_ring,
 	.test_ib = gfx_v12_0_ring_test_ib,
 	.insert_nop = gfx_v12_ring_insert_nop,
@@ -5557,6 +5579,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_pipeline_sync = gfx_v12_0_ring_emit_pipeline_sync,
 	.emit_vm_flush = gfx_v12_0_ring_emit_vm_flush,
 	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
+	.get_ref_and_mask = gfx_v12_0_ring_get_ref_and_mask,
 	.test_ring = gfx_v12_0_ring_test_ring,
 	.test_ib = gfx_v12_0_ring_test_ib,
 	.insert_nop = gfx_v12_ring_insert_nop,
@@ -5599,6 +5622,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
 	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
+	.get_ref_and_mask = gfx_v12_0_ring_get_ref_and_mask,
 };
 
 static void gfx_v12_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 66a4e4998106..176658846b81 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2070,7 +2070,8 @@ static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	u32 ref_and_mask;
 	int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
 		switch (ring->me) {
 		case 1:
 			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e6187be27385..bc1d0870cb2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5382,7 +5382,8 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	u32 ref_and_mask, reg_mem_engine;
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
+	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
 		switch (ring->me) {
 		case 1:
 			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 89253df5ffc8..418b8daa7097 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2820,7 +2820,8 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	u32 ref_and_mask, reg_mem_engine;
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
+	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
 		switch (ring->me) {
 		case 1:
 			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-- 
2.48.1

