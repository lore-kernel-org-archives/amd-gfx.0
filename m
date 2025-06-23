Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4360C7EE2A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336B310E425;
	Mon, 23 Jun 2025 16:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mEC6wcpn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F6C88984C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vc0NbCQbbo+AuEEkpWfqPxaEY5rxsevL0U2p0oBaykt6OwtIAq5QRHJaSZmoI/K8cRbgpqZFEblvXxwrNsHJXx8TBnvk5hxVRkKL0JcHCH0cFhErfsak0TxqJ2t5J5cMHckRaFX0C0Kg6VAyxgL0TCzkEQrUabihJo9CVAXZfHojDQZ9+2oMCGRhH4OgZQCoqwdK2NxkZqzMXbBI+4xv5ulPMg57RcmZdgwqTDmL1B1njwZJZKw2WhRF6VhEuwn0A44KGvzPNQn9hgPsfpIE2m7qTdASHf10Nh/I7ylEAu21GujpC329wQWd1etIAmdWoLeqtzam8rCJsDjlq6Py7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPed9i0Y7Sy8G6THcoZylmSjWgIm8MnykIux47QOn7U=;
 b=NYgm0i6BI/IXx216GKgMIcIDbqwJ4fr+O293jsS0JSTwWCzG1xHvY4ZN2tUGBwcXiSWz7VXaNfXPfkCAmEr9Kb4YFOZZeZm1SmLu5PonWbO0CN+BeNsZKhDMofw4aXgibYcvpEgnkKHle4Xw8ubzwAkdq6MgRaHqpigCiCq0qFldNktq0wM7uwAB5u1ig07JRDeHMyze7/K5QwBCrCXxkYipyrL9C3uMIflblv0dUqOOSW0XtXzva/qF7DN7uxaTVSrccAzLyB10lB8NoSO+vj91PuHxBoRToLMOZs/nHKhYZ/9dCFb5t87EMVN+S/FgZ8vDnAd6nuLzRijjK4395w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPed9i0Y7Sy8G6THcoZylmSjWgIm8MnykIux47QOn7U=;
 b=mEC6wcpneIPDMdBKRLxr522GpsoPPmBhJdcrEZxKVDq/rCTo45B7VAHKwgGIIFNoELEAs1pnLOyQdlv+b5XjjRJL/VpcRoqUJyxlEi4taS7O9vogKLuYqt1QNMpK/jO0qRFjXz8dYs7pzsQHKLPYu31ahftjJlADvP+3eFkx15I=
Received: from BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 16:15:01 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::97) by BL1PR13CA0213.outlook.office365.com
 (2603:10b6:208:2bf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Mon,
 23 Jun 2025 16:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:14:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/31] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Mon, 23 Jun 2025 12:14:15 -0400
Message-ID: <20250623161438.124020-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d262929-95a4-458f-f12c-08ddb2711b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s746N9pJaQqE4xAHX1NgEyuXamF64jEMudCG/zyRLfRr/yzWcnqQT0noN+EZ?=
 =?us-ascii?Q?j20sk0WxId2TV3Ybq3843o3Lp4SJftKRYSQAh/Lz+d4iPF4+QiK+7P4rA+tv?=
 =?us-ascii?Q?EMNrW7hllAcG/5hoPPSzCkiEBznlGRQ8axnA+BG2wDv05EYdfa40Ke64sIXG?=
 =?us-ascii?Q?IC9umwts5S4gKBM2oHHmpgh6lmD27ftOpaXCx5GdcYxXZgVQV8xgQk6YMhnu?=
 =?us-ascii?Q?Ubz8d23SEg4T84qNQ/PvULnZ9B/gtWA+/x894BvrCl7esWwvznEkUg9l56rF?=
 =?us-ascii?Q?kTwlcYNbsqI5a1ETlkEAm2p3zmzt3uvOml3CIWLASRxvVFXzJsrKZQjEaSGY?=
 =?us-ascii?Q?v+/kAp/K8h4CAyRMHv7hNoqXcYRdRr/Epvq1HDLr2RD/9b9K6MVjkslAZ1Y4?=
 =?us-ascii?Q?+bm7xUq4L03B1++gscei2XhgmZYP4lcIsWIIgrWO5xh7DhBUGYyAeDLCvR/F?=
 =?us-ascii?Q?e8jYNsnN7aqjthfTorHSCiVWpr7JWbdrFejveI5MHF5obpBK+H8VeS8CLH1R?=
 =?us-ascii?Q?TApQ/Lm4aYgK4B3+DzHoGI/Q5vZY/+4MpUFrej95LfOY5/agBUgIf9EHoB3u?=
 =?us-ascii?Q?YsF2/hTycj4UGuuXRMcpovRzt9Gf1UB07VrhO0jKCOOvslqANWHcowmIfdKE?=
 =?us-ascii?Q?xKXjtHYcVzbDQcnx1MQErqIpMc06J0nUdPBLmr2WlLtJtq+04YctZTljFf6V?=
 =?us-ascii?Q?PuFkXHu4GZlbAnzHNiaHjIImrLDsreo/T87RLW9H6UgPoBt2Xh3Kewtr/eG/?=
 =?us-ascii?Q?bSx7ZV/iniXtTjuHdBsinWUJ5xonKqYlozKA+PztanCywGhpIPzLXdSwFQHV?=
 =?us-ascii?Q?+W6Isqhj9EC9uqfgNBvOFTUGv2NUpxT3nIRQRCWrp4xRih57N0p20u93fnXA?=
 =?us-ascii?Q?1fZwCbWo8y3qQ/OBYl8ZOhM8heEm+FLwMj2aV7czTLUsZWPiYyMgDkNQr786?=
 =?us-ascii?Q?rszk8ux2ZB5tzQjDm3H02Y2UVRjf34Zq28bUFK1mXsmYYRgtjHN6gag69lHd?=
 =?us-ascii?Q?O9Oers8eSrklyxb5Twt0Ofr/WK+LfG4bbe0Tm7KuzqC1dxHcWNRdjTQwfie3?=
 =?us-ascii?Q?ST9IyGB7h+i10nWZqBZAwzD2wnTNIfsF4iUMVv4z2519ZWbNbFms7++eF7tf?=
 =?us-ascii?Q?eNowdmiWNAsuIAb8U1jw6UkCnjltD22wL1uS2nNHWzFMmHQ8q7zJHGLD2PJn?=
 =?us-ascii?Q?XDgZQ034sJMkpwiXOhaKQVFnaNvJisrqhedC2gF58NJC5ng5+eya2O804EwH?=
 =?us-ascii?Q?YXKXJcq0pSPHbjl4vap9GJ3d9v0lunFmpp8CO07D57ruQWJwGF8TVuTHVG8m?=
 =?us-ascii?Q?6o8kaBXNuDQgQuCz/iR41QBSH/99KTNyBkiYEN8sgcf2BeDTBfDI5VX3jJ1u?=
 =?us-ascii?Q?PHuUt0z0abMEOEt0R9/exRnrUSuLzA5mZRgKoyo5RW8sq482vPMtj8Eab6Ul?=
 =?us-ascii?Q?MMiotu4WxcFvs3Dk9Rmf2He3hnVFYJt1KE1QvyjSJwYp0WehecweGeOJ5T6H?=
 =?us-ascii?Q?obhiEfnRJQUxfVydMJ7rYUmEP8atmORux5qX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:01.7428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d262929-95a4-458f-f12c-08ddb2711b6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 76ba664efecb3..30f6b04cf82e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7187,7 +7187,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -7238,19 +7238,13 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.49.0

