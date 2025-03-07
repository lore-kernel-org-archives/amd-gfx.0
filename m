Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089B1C28B2F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09FF310EBD7;
	Fri,  7 Mar 2025 15:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kmwtdQRb";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E461A10EBCD
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiD8E/Smbgdfmm6lsCHS1dvj/NpGpOtd6as/H1XdkygA6AK7yfgpRVHeGY6h6q7aMWGzaq9af/QpQGIAc1IFlkIuUwq65rRBkZ8F5Jw+Cog74rJ7gNPiwuuKgxxKGXdYRPJlpTrrJyhNGlPInmmeIsIToRR0N0KMrSOdcyNBoFwUBk8D2olDGmnZJcF/52GG3RI0lhdmYf+/vqOJ2ukoSA6hims/6mUJ4EjZ2gviOfICdq2GtA7ocp2vuu/GgMP2+3ZX8syT5E54tH65fHNOriM8RgZxwsyMvVcRePulVERsflYQrMHLN0mdAItmnnLzmPp8SnHcDXjW5uKOKmARow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skzCSBsLBria4oVYhTGQD8Nw/X65w/9eChUmzNbNe0Q=;
 b=scnKHoVjnwgsKRwyGokzbuRpzHJtAL6GaIXrvMidJM5UYS7ljwxDPPQhTfkydTl856Ep6kd0OgZeP0ZXyJIvGFl+rk8WoYKyPYnBA3ciPDUxcGyZMGWvJ/vTST5vJdpAmDe2bX1e4G3CFLMIzWihabPREsJDzzl/NGL0H2QoS8FfAVrjNrLJuAojCopxAXm7PNb6Ccl/OnM2OdVdxam3geYd5N//N3sacLaqr2lOVvTD7kXY9wm1T6ewA/XaESKYnf9zNn2T7/G2J4wxRUkwQT+UvmPpcZoEkl1BMjAArJK8xfo9KhaMoCy+UsBsWXFBJb6qDt6OBmNAYxlwN53z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skzCSBsLBria4oVYhTGQD8Nw/X65w/9eChUmzNbNe0Q=;
 b=kmwtdQRbCnZ+6FMP3e6hOsOyfUDrt3Mx+ocrWXNOCVqv/6ycUk5NXoTOpwPq6zA2/hCYad0ZxNSk2uR7bJ3Q4noia6Oqp7lLd/1GbtFbsd3vZ4AZkY1TCr5IpNlj7LD96x/rpkmKktrg4/VbAOL9F8uSTBbvFIAXciszhBdSoo8=
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 15:16:23 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::36) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 15:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:16:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:16:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/11] drm/amdgpu/gfx11: add support for disable_kq
Date: Fri, 7 Mar 2025 10:16:01 -0500
Message-ID: <20250307151605.946109-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307151605.946109-1-alexander.deucher@amd.com>
References: <20250307151605.946109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b7f22f-1646-43fd-89c6-08dd5d8b05b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iycsVD1LFCMeQh1f+vVfzgRQlX1smV4dwpscgxtZgy6CSuv/KfKBCuSfMgSk?=
 =?us-ascii?Q?m/XtREemQQ/W9emFDnJAL4iAuUAZ9z6TFtfjg4UO6AFD6Eg8eYWrH0vx+/FT?=
 =?us-ascii?Q?yqH9GmVngGnXDbyBHk7OwnxUF3K85NvJ+4aMuvbgiHb/Rp8VOCkjDw5HCo7r?=
 =?us-ascii?Q?EWRB57tpC04sK9MiOv7nJD5bwGn7pQ/IdtlU1f+nw6ARWCgOiSHeT6aayrMU?=
 =?us-ascii?Q?k3Dsdy8FIF5gEWoIIlR2IPjjbubIfejDyVPIxiMExfKlT7tl9KdokF+8amPC?=
 =?us-ascii?Q?iDeuxEOPRgWK4HD55VabS0jHBAvRRBi6CaDmjzsIG6shRdmZavk2FMMHK9+5?=
 =?us-ascii?Q?6lB/55KrZw8jyADnkAHRSDeGgO6i/J1oBGU3Rv9gd+lpB2sJd98MXBdYHUrv?=
 =?us-ascii?Q?yOMml9J/5ryh2cCm8FCFOGz8gNZ54/czlZg8ex2tX+8gqSjS5FxnDLuhO4Dt?=
 =?us-ascii?Q?uyeFcNzRn9arTL2RGVxDVBzbMT686UJ2PYbvkL0aB8EkiuT8fV/yEZUV6M/d?=
 =?us-ascii?Q?EIjMStbN3XbcQfKOCr/yWyr2ikwA4wQwKr1vmzVKEehf/mzpa/QWL0SvTEvq?=
 =?us-ascii?Q?ssx2ydmVICGMo70oJXenacE0d+9KO3kUlV9XW+aGaSolLvJrZJ6ACNPQ0yoR?=
 =?us-ascii?Q?3Ksw+tz5HXWOZgI/1WTQFDDM0XBsPnM/hNlgc0pVUYPFheugmyOCxuKnDjpw?=
 =?us-ascii?Q?iEk0Wpnk/TPodB7h/VZiQFNTmIH8gN+uMG2Thb9/StlvCdlH5zKsN24lj49d?=
 =?us-ascii?Q?ftCxWRFX50584lxhdKw2FPKpV/MDq+jo2q47tOx1Fya0GMskpFdnf+8cbO7w?=
 =?us-ascii?Q?fKnUu1Ipt+iTbaCeTQMUSL5bmdyOM6V8ZKHAmKII+KU8oaIM2pzJ9tEBbK8f?=
 =?us-ascii?Q?eZ+QSyskUy8ksNuinmjwYRL9ikVChfUbu347GMxnj4Oo1AaGmesOIGpqtI8s?=
 =?us-ascii?Q?d6rf4g1RrIfca7qALyYmYKHW6A+KZgLeyKVahv4d97jPLt49GdotAa6A/HYN?=
 =?us-ascii?Q?lkeS1DWSEWEkINOkw2ZefwKRxDC8LHnk3L+La4eqa614653cUTruLz5wm2Bh?=
 =?us-ascii?Q?k2JLQ2fjgj3vipIPkSkYXCtjGOdVGMdLTaKbSo5uSJ+XP4GQvZe3lrzPdzEg?=
 =?us-ascii?Q?bOsn0KTG/QfEodIV68GG3wbwFU0tCiz6AHMPuqs2a28b6+Ubv8AZ8oxNZoWS?=
 =?us-ascii?Q?jCS067l1y1p9H60eWN42M1jFNCyWw8ddU6+UiBOTI1hywarrf9M8kNCMmqVw?=
 =?us-ascii?Q?enyn64+vv2mMW6HDsUC9JLJMvJZhsyVtj/8CkeisaxKok0/+TadInOEXMQwD?=
 =?us-ascii?Q?Wb6Uh91+WJl0FD6EZBYsZJjbYHTGK4DsvBQqzvNLTiPldWUuXgs3yWpxJ4YI?=
 =?us-ascii?Q?gO4AXOBGzmmO3z7K4cHwiGbrMLsux9UYXLfVB2Ku4fRK5w14/Toy9prCLnoH?=
 =?us-ascii?Q?y27jZutQ8fGui2ZNfhgvfmHE3W/XJStqFz3X3qoPiakEW0dQuqyKUmQXRhxN?=
 =?us-ascii?Q?2VM/BZ99ZMAf5F4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:16:23.3292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b7f22f-1646-43fd-89c6-08dd5d8b05b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964
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

Plumb in support for disabling kernel queues in
GFX11.  We have to bring up a GFX queue briefly in
order to initialize the clear state.  After that
we can disable it.

v2: use ring counts per Felix' suggestion

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 99 +++++++++++++++++---------
 1 file changed, 65 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 95eefd9a40d28..b20624f8cbbbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1145,6 +1145,10 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
+	if (adev->gfx.disable_kq) {
+		ring->no_scheduler = true;
+		ring->no_user_submission = true;
+	}
 
 	if (!ring_id)
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
@@ -1577,7 +1581,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	int i, j, k, r, ring_id = 0;
+	int i, j, k, r, ring_id;
 	int xcc_id = 0;
 	struct amdgpu_device *adev = ip_block->adev;
 
@@ -1710,37 +1714,42 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
-	/* set up the gfx ring */
-	for (i = 0; i < adev->gfx.me.num_me; i++) {
-		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
-				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
-					continue;
-
-				r = gfx_v11_0_gfx_ring_init(adev, ring_id,
-							    i, k, j);
-				if (r)
-					return r;
-				ring_id++;
+	if (adev->gfx.num_gfx_rings) {
+		ring_id = 0;
+		/* set up the gfx ring */
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
+					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
+						continue;
+
+					r = gfx_v11_0_gfx_ring_init(adev, ring_id,
+								    i, k, j);
+					if (r)
+						return r;
+					ring_id++;
+				}
 			}
 		}
 	}
 
-	ring_id = 0;
-	/* set up the compute queues - allocate horizontally across pipes */
-	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
-		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
-								     k, j))
-					continue;
+	if (adev->gfx.num_compute_rings) {
+		ring_id = 0;
+		/* set up the compute queues - allocate horizontally across pipes */
+		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
+			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
+									     k, j))
+						continue;
 
-				r = gfx_v11_0_compute_ring_init(adev, ring_id,
-								i, k, j);
-				if (r)
-					return r;
+					r = gfx_v11_0_compute_ring_init(adev, ring_id,
+									i, k, j);
+					if (r)
+						return r;
 
-				ring_id++;
+					ring_id++;
+				}
 			}
 		}
 	}
@@ -4578,11 +4587,22 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
 			return r;
 	}
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
+	if (adev->gfx.disable_kq) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			/* we don't want to set ring->ready */
+			r = amdgpu_ring_test_ring(ring);
+			if (r)
+				return r;
+		}
+		amdgpu_gfx_disable_kgq(adev, 0);
+	} else {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
 	}
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
@@ -5128,11 +5148,22 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (amdgpu_disable_kq == 1)
+		adev->gfx.disable_kq = true;
+
 	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
 
-	adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
-					  AMDGPU_MAX_COMPUTE_RINGS);
+	if (adev->gfx.disable_kq) {
+		/* We need one GFX ring temporarily to set up
+		 * the clear state.
+		 */
+		adev->gfx.num_gfx_rings = 1;
+		adev->gfx.num_compute_rings = 0;
+	} else {
+		adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
+		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+						  AMDGPU_MAX_COMPUTE_RINGS);
+	}
 
 	gfx_v11_0_set_kiq_pm4_funcs(adev);
 	gfx_v11_0_set_ring_funcs(adev);
-- 
2.48.1

