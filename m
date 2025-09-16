Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03B7CAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 05:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 823D210E2F8;
	Tue, 16 Sep 2025 05:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="syLcusIX";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F0710E2F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 05:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCEBW5TlXBdzCXtryzBjyf5LWlBq50oK8Q+PSutPoeyd8a67PgRPqxBI6sjLtdABPG48F015KQgxq0ydMpSnLmpqGYDEzIJiaG7QEGBugLPyWk2CCxYN7VoCqBLJrO82TZ6LrxqZuLMuDmwfopmIVutSYTf8+P5A5vKNAskFYsveDBhk1lLDnx3VfBuXSR85++8uZiO+pDty9R7wNi0S9rJ8dxp+wu/hBu5/ZifPrr80eFGyy9J4WY1u9/KL0WoLrMui6dLeqYpM3jXmRWzpplwdUFmKjJDOfe6wEE6mrcjyERLqOSvJi7UhoBacYAQDwNO0cMNEzWS6xE1xEGh80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW6WZioV2uHJZISthf8yaMV+R5jmWPrqLKGMb5kAfhM=;
 b=fu47k55CFep0AFAvfHdvbc8pqkNRt1YO0/8JQcKSMZbY20oLtQmP1I/F3FzHvYUYgu5oh6Ey/KNXnlbDBuQFlySH999rVy5XnD3gR7/bYvMdQQaUjoXDUAXuvK9ktk9BvDpxhDmjfjSMTprsVRBru3SntqbRztaf0GDegJDghaIEek3w+ZaAQS0U/8P2O2qirjvU28sCfxmj1XpR91T6GQUFOlzRttn2v+z39t7MOJgoBlmCpcJtzJxPwHvtnJnV/JIppkwyToBGlbXKiCWOnM20o80hD9WdMINXXD+evL2UBOEOyQ3+XV8P1pEnq2siegbndVRXr0RdIVzSIvo6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW6WZioV2uHJZISthf8yaMV+R5jmWPrqLKGMb5kAfhM=;
 b=syLcusIXI7+XxX5onsxt5i7YQd4GDlPeYBFph27ol+01P2jlTXb5xNZadi46QhBi9qZ7znIr1qvf8UEZqPc5taPI7CrgiYWJChyGKR+B9jqGUXBcKnXyJ84Q+yHs6iWepoTNvSHmSRJYnn1OJgoI8WvjKjTqDcJpaSB0lv7CD18=
Received: from CH2PR10CA0010.namprd10.prod.outlook.com (2603:10b6:610:4c::20)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 05:53:13 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::14) by CH2PR10CA0010.outlook.office365.com
 (2603:10b6:610:4c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 05:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 05:53:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 22:53:11 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Remove redundant return value
Date: Tue, 16 Sep 2025 11:22:35 +0530
Message-ID: <20250916055235.3070689-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 885c8b08-ad10-42ff-5a83-08ddf4e552fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jqsjiink7eC++14u76O79c3O/PHQOaHx2SLyahj2Lx0lwWFjNsgtfvZ6kpMn?=
 =?us-ascii?Q?+b1ajZ2Ia3GpAsbL78ZbFqQ9w0zfT/c9OgOcn3rny36R4DcXAkIdso4OfP/f?=
 =?us-ascii?Q?BwWmdWnporilXxyFyHRPzAyYAez3VG+x6GgK4lO41N53dJcgZ+ZfT0zUdqjl?=
 =?us-ascii?Q?XG+9QyV4TStqA4DseVGsEqX8cCwxTIjVr+j1f5PRC/RPBMA4OyAZmZl06kGg?=
 =?us-ascii?Q?9d3U+KpcQUC4jPwewuQPeb1coIZYRfu5nTMMKZRpqOdlG2HCCl6A1t91ZsJu?=
 =?us-ascii?Q?KK/VQNbkgKEMpGvwAO4PijCvBYft0dhjP0OsjkQNhS2PVWu6l47lgtwKZDcf?=
 =?us-ascii?Q?68/ZC9e2WKla+SdRkIcU7A7Q70jmRglpORyqDGDkGV/ffj6nG9Rci5e3CdUH?=
 =?us-ascii?Q?rX1E3GVPXEQQSQ/vFHBpTbkGPa7NYfBUDEdZE3+lPW3P/CyIWXsAzlCj2KZz?=
 =?us-ascii?Q?tq4XUlIyp2iKFB1VBHLTvbwS9H3WZoi0uGs01xxmEG1IgozRgCdnD5oLcQk/?=
 =?us-ascii?Q?SA/TsfU+ORxyubZtIKDS3PcfgTn+35GKd8pPeQ24enXFFyPew190iFKgHE1W?=
 =?us-ascii?Q?Queytcwi2pzBnaSlayfi32ddc4gss2C1q39ZFv6m5QLMnzFho1+PGagZ//cv?=
 =?us-ascii?Q?1Ww2HT+Tg9dELxC3/4VlE/JADDoFXvRNq3PMP7jZUzTFpWM38diDs2aWmj7b?=
 =?us-ascii?Q?cSv1S9wDDRUj8T5/F5s6J5j2jeITyI/YjuxkgQdR9DesMVo0596j4Fw1b6tn?=
 =?us-ascii?Q?ExTJfT4QsoxkVRYYoc+8SkSU+hsb48IOy1bsPFxu676MwlrJMyzTcqQZDOoG?=
 =?us-ascii?Q?CAsNPovTUot5BR+qd0tppXu6MSADSiaBDilV0UP4A9H+wS5/5PEYGGdTAvh8?=
 =?us-ascii?Q?H1WHOUkPSHgoyAWyQMhoDq0t+o2QEm0O3joLSK+Dokloe61ueCoKYxMeP2TH?=
 =?us-ascii?Q?D4lyGQqefFbRg5Lu1765UKSb9XvosgZwPUdd2W8oYRwcOgZcOpw28uzUvaqg?=
 =?us-ascii?Q?8rSZlxIFrDP9zVIdq9TAmYC9fYTl3k8IzoGBjDs5K1lUTU8Fgn8P9WWuc7wX?=
 =?us-ascii?Q?NNfIoT/PuGov39rAWPzdS80SDLFHPyt4j4THFUQqktKh/t1PyOXPjZBICHmj?=
 =?us-ascii?Q?hiKxEX6383z278zEy1jlE1wLV3vkLi5lG39ahrICg+j0Ne50M/cluefN34VZ?=
 =?us-ascii?Q?/RVzWlLc+Yosd92tPoFqe/JSFxXqiesdUiPuRD+iMNtV2anTNg3XBMmrVKB1?=
 =?us-ascii?Q?+Lr4LnghzdUXGlEMkWcBB9Z8FsEra1pghOK6SMEo2Ocl+EAf5wQbq8YMVxAA?=
 =?us-ascii?Q?ftyxneZIngDDQ2uSHpJn13WWdG3v8Q99R42/2yle78vyomI/ZDJPYHBTVtac?=
 =?us-ascii?Q?PodprddUr03MY8APqeKX4mjAsHYOz/hDbNgHZM75pHrQKvOSDfqeRlikvnIR?=
 =?us-ascii?Q?z6R6bs2HzGaz3aiHM2D+dIWligvce4cuQr6wyFb8qiOH8fSGANJXMDF5pbs3?=
 =?us-ascii?Q?H3Tp12ByB19AtDXWIDblwE5y5oDEzOigf1x7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 05:53:13.2759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 885c8b08-ad10-42ff-5a83-08ddf4e552fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
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

gfx_v9_4_3_xcc_kcq_init_queue doesn't have a fail condition.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8ba66d4dfe86..665ae33bc272 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2152,7 +2152,8 @@ static int gfx_v9_4_3_xcc_kiq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 	return 0;
 }
 
-static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id, bool restore)
+static void gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id,
+					  bool restore)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
@@ -2186,8 +2187,6 @@ static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id, b
 		atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], 0);
 		amdgpu_ring_clear_ring(ring);
 	}
-
-	return 0;
 }
 
 static int gfx_v9_4_3_xcc_kcq_fini_register(struct amdgpu_device *adev, int xcc_id)
@@ -2220,7 +2219,7 @@ static int gfx_v9_4_3_xcc_kiq_resume(struct amdgpu_device *adev, int xcc_id)
 static int gfx_v9_4_3_xcc_kcq_resume(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_ring *ring;
-	int i, r;
+	int i;
 
 	gfx_v9_4_3_xcc_cp_compute_enable(adev, true, xcc_id);
 
@@ -2228,9 +2227,7 @@ static int gfx_v9_4_3_xcc_kcq_resume(struct amdgpu_device *adev, int xcc_id)
 		ring = &adev->gfx.compute_ring[i + xcc_id *
 			adev->gfx.num_compute_rings];
 
-		r = gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id, false);
-		if (r)
-			return r;
+		gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id, false);
 	}
 
 	return amdgpu_gfx_enable_kcq(adev, xcc_id);
@@ -3603,11 +3600,8 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 			return r;
 	}
 
-	r = gfx_v9_4_3_xcc_kcq_init_queue(ring, ring->xcc_id, true);
-	if (r) {
-		dev_err(adev->dev, "fail to init kcq\n");
-		return r;
-	}
+	gfx_v9_4_3_xcc_kcq_init_queue(ring, ring->xcc_id, true);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
 	if (r) {
-- 
2.49.0

