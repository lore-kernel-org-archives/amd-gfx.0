Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9383C7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE92610E93A;
	Fri, 27 Jun 2025 03:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f482nZ4G";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06EC10E935
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9uqv+InmvbMBzVAPAIPlKzu9612Z4KARC1QUDmjEDRFh7age/iri5EmxvYWm/fmM4q5PvAQx5bfp7CNHmQ7zjpthj0zrP50BDRZVCTmAcHJg+wGv8Z+Gb5o9QapGRlXYr25lQdqOspAiT6Izm6ROI3uipDlUWAfzFMkCGujzhCKUtDrimSzI4hIl+CGmXyqnS2oQfc6k3GassKXPoveh6F72Br7+N4YU9SEiM2ITaA+4kp7n6Wnb+rrd3VlSDjgcdB4Rx4pwgU7PVf17HeXK3J+6+/VG4YoBMMcflhlonOZxVNyOK0wcP2sH0zMu/8bB94WRU3amKKy1K4T1vlGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/u55QdQDx2/UEglOM9xJYIBFHL+4kWFO8Z2xbcnuy8=;
 b=vILCf7E/0wy3v9zzKn3fVVXejX4AZJL/fEq6fEDb1eWZvg0A3tmhYmVucYLEINt/D7NCvQE/7bvfj3krg4HnOXuw2PY5npCe9/b4NVW25AbOvOD42g4z2QaN5DoLg/Dvd88IJXTh4EolNtSOhhcaZiGc3HiKgW9k3DCjjTxcKwL5f1gZMH/MxQERe10usXzGjdqEwFq2nnCKjtCWKWhkQ/DZ1dh1QrTilum9nHc3Hx8gihBGe8GRr+wPS+RtpQEoYH8Rmh3AtArRslAVUVxSl6flzNSWgeVH1Zd4sk/a5OgdoX1MItm+nJUy/w3lG/ZlJKJNIgAHpYR7jFgz9Tf9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/u55QdQDx2/UEglOM9xJYIBFHL+4kWFO8Z2xbcnuy8=;
 b=f482nZ4GOuNAXGifsOzhNiCe+kIKqdEBJ5qXGIe4KP5iv+udThISc4ECkgTKKUD//sWs4WQNHNrpl/v/yTRxUQuXPGme9M4CZVHa4BanBaNJnzbP4lZrOzD9I/fxt869txwR6y3jTHDL3XvTNihs0u8maM5cA9zNamw3qm7Ej3M=
Received: from MN2PR15CA0040.namprd15.prod.outlook.com (2603:10b6:208:237::9)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 03:40:22 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::6b) by MN2PR15CA0040.outlook.office365.com
 (2603:10b6:208:237::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 03:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/33] drm/amdgpu/sdma: consolidate engine reset handling
Date: Thu, 26 Jun 2025 23:39:31 -0400
Message-ID: <20250627034002.5590-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f04f08-55a3-4df1-f394-08ddb52c58a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wEQC5aVEWFSaxisbvtnp4/+jA2kJWaOfnR47Xm0PM232bu4oYXnWXRr9K+b/?=
 =?us-ascii?Q?5Q2DBmEi9d+rngrwWy3V9KWWf3BKk1TiA/AeuKo7L+ac0QqaroUxIbUC+GRY?=
 =?us-ascii?Q?zfl1mwZ5p7lwjz6GQKR1bzPAtpPQ///QoSSg6EIgS3BcSmViUrWuizMhpEfG?=
 =?us-ascii?Q?ZXOarkfR9XNUWN3tIgta6QRZuqvF90CyTdVs9yl4k1ZuQLneL8xSG58kqm3l?=
 =?us-ascii?Q?b6cIeNLb47VuYTCFInxFb6SpLOvgmvI4m//D5BVee+AWMAKxyohWw2Aoycee?=
 =?us-ascii?Q?GJT11T7AQ3jakRpC39PT8BlQzV7zxb0T/2n8zJsNddW8W0HTOH3zXuJG2kAf?=
 =?us-ascii?Q?W8AqSu4GOVZFPWJ2IFqm3yUwEp2q12NIYIq1dbNUpiE2kUQxF0VvOj1lty7x?=
 =?us-ascii?Q?RHiMmBXBAIbpiEipQHj6JHnK4hfd8Blm+mAsI/IJtLaZyfzhcxf0cV1+Wilm?=
 =?us-ascii?Q?4rdaytuayKm47HYebgxvPUvlPRXe+MqIFCNuETI1mH1qnOPShB4+A3WOF4K7?=
 =?us-ascii?Q?ULDrVJ2Iu9eWuYRrOdC7Y9BmiPtaKNStAvcrPqVaLRM2pEoKVAoJ8Usyfk0s?=
 =?us-ascii?Q?7/uH42xpbChvkwn+7ZvJccyHz2aUwraC1DZaPY179G3AtAJZ/JoTxEzP73h7?=
 =?us-ascii?Q?9pelq2cu5ixR7sMXucK7OHsddjLGd9JIO2hjCopAWCbSG8h41O0snxeQ3Z6e?=
 =?us-ascii?Q?KF/+xgtUPNwAo35jBGTADNW2C6HRM3fHfDGVD1o55FbzzzDNcZrp/3OcMVkR?=
 =?us-ascii?Q?JiqxICgvVqA6sAdSgD49rdFJmlBpmvSy4D090FLxTp6ls+0Dkj2b2QkplgSj?=
 =?us-ascii?Q?WKNC5ucs9BpjeoRDHcwmJxyYrQalc6CT5OtbBHijdhi6jqFmnCE+m83avSf2?=
 =?us-ascii?Q?z3GPH5td5WuegcAu4fdCRJit9b1XWC0GVv/vdNRkZZH0EwWv/zRbriWaWjHx?=
 =?us-ascii?Q?QWNF1q8zexqSfXY+b3sN2LjW1W/cZHQPlcrMonbo/Iq576eRkMlbymagksFF?=
 =?us-ascii?Q?0lhnNYc+CVrZc2+fQKpDnVD0rQRspAXtAZhXJOhRrQOw3eVC9redWdt967Sx?=
 =?us-ascii?Q?rkwbk6xWaN/jIWwpc3TXrXKGekmrGKypd0EqPbW06MPXLGwGKWcvieTupPEw?=
 =?us-ascii?Q?LUzcXwDOv4NydjqXPThL1+xN6o5plhaAqdYTcasCDem/yHTntY1EMhHguldp?=
 =?us-ascii?Q?5arIgG5DC+DkK5xqtCWSuHSuX1ooZyLb29aSy1NqENLMXK4ygg9LkRSm/9/2?=
 =?us-ascii?Q?rW1Sk0dhvjNhppq2N0ehA6gX/+79vhX25j03pWlVqYwypovZApLw5zAfdYI9?=
 =?us-ascii?Q?hAzNcbf7qUmwExr+als46HzcXnUpKP1qg7E0I0lk9F+LkIzowQbOw2MuNi78?=
 =?us-ascii?Q?Mw6z7CI/qMnUHsWwin4VaOpOlsRWMsBTropy+IJ5X0XZxMS7/5WpW4eqfQId?=
 =?us-ascii?Q?GsqcIaURwRsZYHhkgkSXhVzd2yhjWcu0Z/FPXHBWfNN5m8xEkCa6bo+VQnNd?=
 =?us-ascii?Q?cO0syiB9h0Mg6wmlKQaYr1dkron1jPyL9vBS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:22.6635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f04f08-55a3-4df1-f394-08ddb52c58a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
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

Move the force completion handling into the common
engine reset function.  No need to duplicate it for
every IP version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 17 +----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  6 ++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  6 ++----
 4 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 7e26a44dcc1fd..56939bb1d1a95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -590,9 +590,12 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	 * to be submitted to the queues after the reset is complete.
 	 */
 	if (!ret) {
+		amdgpu_fence_driver_force_completion(gfx_ring);
 		drm_sched_wqueue_start(&gfx_ring->sched);
-		if (adev->sdma.has_page_queue)
+		if (adev->sdma.has_page_queue) {
+			amdgpu_fence_driver_force_completion(page_ring);
 			drm_sched_wqueue_start(&page_ring->sched);
+		}
 	}
 	mutex_unlock(&sdma_instance->engine_reset_mutex);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index d3072bca43e3f..572d105420ec3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1714,7 +1714,7 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_mask, tmp_mask;
+	u32 inst_mask;
 	int i, r;
 
 	inst_mask = 1 << ring->me;
@@ -1733,21 +1733,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 	}
 
 	r = sdma_v4_4_2_inst_start(adev, inst_mask, true);
-	if (r)
-		return r;
-
-	tmp_mask = inst_mask;
-	for_each_inst(i, tmp_mask) {
-		ring = &adev->sdma.instance[i].ring;
-
-		amdgpu_fence_driver_force_completion(ring);
-
-		if (adev->sdma.has_page_queue) {
-			struct amdgpu_ring *page = &adev->sdma.instance[i].page;
-
-			amdgpu_fence_driver_force_completion(page);
-		}
-	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 4d72b085b3dd7..ed1706da7deec 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1618,10 +1618,8 @@ static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
 
 	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	return 0;
+
+	return r;
 }
 
 static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 42a25150f83ac..b87a4b44fa939 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1534,10 +1534,8 @@ static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
 	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	return 0;
+
+	return r;
 }
 
 static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
-- 
2.50.0

