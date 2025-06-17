Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D070C71159
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F211410E497;
	Tue, 17 Jun 2025 03:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nP40WAii";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D2910E489
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAmq/LEoFtBhDjYCXqNIZzrDFSkv+MmzVA5jNN3Hhch/dWuS3jf7Qo6DV3JCqfu5kcHIPazFB6GPP/v7AS8MBL78rM1Ar/X0DwzIQ+S4LcDRcbyXu+BqOdEz0v/HGDOzhbIegnnHubVsArbobKgLL4pRIk/d0av/ibU70VPYhaziGjxqAQpvKAX3dxwjLNPbqGMybbCkt51mWTlLbITr2AImr6ywUEPHi49ZsDPxPTCSpDQVX+8Wouno4wc6fGI2v7Rqyj6OM4L5Mg/CCP7cl22sn8Lp34AUY8q10ZtJHgrh3JaIYMswcGJfBPG0CgsfGhFyNU1H9N6hX3DjCTPU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKe8qFNeJG9X1sWYEke+xo3NippSIF2QiwOBGAjruiw=;
 b=GbUIwf2YgwMWcZHyJN2aev3+mDIQ7MwBKi+gjAFU99WW5/DaXv2ikUHfptnJhVW8JaaudYpCnPy/Pw/S+Lozy0ZaDaL7TiZerSjhzNY0GimZYkTYFzXXANQavCVEhi5Mw/gQz/wt9RcTRkTWMoUSk/E79FRKVA96lqH0U5j45MLxq1YeOUOD8croBu6RIoa4praISWPKZSiEDYvnwp2UBW7jP3vFRGRyr6Th95RErimVbA7O46UeouLx2mDdEqzKt96Fz5RdsKRWO8Si/KQeVmonck/YooFAUn5DZ+OoYHHOb48AyhWcCZ41Otv52UlGaw+1utYGMdoJiNPwRHIk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKe8qFNeJG9X1sWYEke+xo3NippSIF2QiwOBGAjruiw=;
 b=nP40WAiiozwjfnoONIE0fjot0CE+hiORYFQDUb1lm/WedOUd8J9coRrmJuqv3AVmfqfR0NXFqB0WsbAKK17Frzrb56+8cqgMvRMRrqinTEfsTK19KTybeWRyTJOTiKkMyjfeitP4a3bnnE4uVlmf/7njYMCRhVsh8HXoVOL2S54=
Received: from MW4PR03CA0006.namprd03.prod.outlook.com (2603:10b6:303:8f::11)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 17 Jun 2025 03:08:44 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::d1) by MW4PR03CA0006.outlook.office365.com
 (2603:10b6:303:8f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 03:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/36] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Mon, 16 Jun 2025 23:07:53 -0400
Message-ID: <20250617030815.5785-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5c96ed-7f33-4c06-3a7d-08ddad4c44da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ajs6s02KUnUElc5MLU2wnaIReFQsAnNm1kSIYv1OZ4zDvZtmhROm7pzT9mK?=
 =?us-ascii?Q?4I/Mz4rLnbtbjDEkVELRxiawMpiNt+SAg2Sj+xSauwBrzwhPamciZY18OfVX?=
 =?us-ascii?Q?KMAwUkOtjLP0jdMXIEt5kXUwx6xGHhHN/fIIkswohmuwWxpQj8/hzJktodgF?=
 =?us-ascii?Q?oyRAXDvdgaGuT2xVJVBRAW4xL5HguN44x8RTlrN9W8wrVE/fQWhgcT38qB8g?=
 =?us-ascii?Q?2RjFBjH6chBGz3yjA4DdG/OgHWeTSOn+pcFqMAB1LwO/FaAei7o8uMoXFFf6?=
 =?us-ascii?Q?xplK+cXYzRzStxvnPoe72v78V6+MlWk9RLekh58iv/h1YyZJ3XwGep0XE8IW?=
 =?us-ascii?Q?bbkLnrOMYj7T1Txg2+8GJhU3RhSPm5hT9dHZ7bhX+DYl3AH5WrI66KpjUmCH?=
 =?us-ascii?Q?FFZ7C3furB+YnH0ZPJFUOyOKOHwVqc+sm+dY8E06Cy/63gMHV7Tsbu85jKLR?=
 =?us-ascii?Q?Sl2uNoEz0pwFAn14ZpR4shBk1k/zMdzFHsLh+kpeAoINWyS6xZLSd8tElNXR?=
 =?us-ascii?Q?CyyCP1kqc39Zp2ifnK2bjuaF5PhTuinpTr6VluaKl7mYeJEed65VlWwhPSpt?=
 =?us-ascii?Q?a2bunHZDilVbsIyfcgVIENsS+mZWXYer+n4ooMnNISue8defiiUY4JjK1AsN?=
 =?us-ascii?Q?se3m1JyXRbew8lGX1v24dKe3QxTRAzVcyV+2XAxGsD+jpp9hBkwWQh0QwTJi?=
 =?us-ascii?Q?plcLroUp74KBFJQiqD04+b3/E2mRvOW4YfM3qIBa9nhaCoWm4XxXj5toYzF1?=
 =?us-ascii?Q?KL26+BsvMPI0YeQlPjYIaUOhamx7zFSNW7qRo7Fwc+m++HvLvGfmEAWJh25Y?=
 =?us-ascii?Q?L61KvafzWSk2ykhcokSenPi/cxT/HqOCCtHWvZLPXssneo0fE9e8RzE9RDJq?=
 =?us-ascii?Q?S87WNzQYmdIIejRifynh5hwMlt5y5ZxEpp74UEuCaJUTNB6O4odIxioHkotw?=
 =?us-ascii?Q?amrGxWSEZxu2NWbtymY1Du0NxaM3te3xFDUWwlDRYA3hBMfDHCrAfd02HK/g?=
 =?us-ascii?Q?Y3rd7EhLRKPgirb51l5GPkQGtj5/9slPlpKEtwQlswhXCIbg4vI6+H+InO4I?=
 =?us-ascii?Q?Cul/iX/jK5Eni39I/XncXkO1lCH8mcKFdkmPEHz18jTw4rMsaJlBlNiVyxEA?=
 =?us-ascii?Q?TLU7pzw4vt1gk32o7MQ0YtwHjxeS67SJtMBZrgEZglMcqfZsjN8xpnhELpvS?=
 =?us-ascii?Q?zNZl6QmxXh1h0zHWVF93ysXrHh6a2CibptBKGTCa5VlX1VPuQNkAMXPvAkBb?=
 =?us-ascii?Q?1Ir+y2m8WDhPqnFoTfbXlJTjCAw4wPusyDZeKF77nr1l6A+gA4xvV0tfXD/g?=
 =?us-ascii?Q?/8h6daFJR8J0KiIlTIZoc2/s0m62uJVerD/nbTNmXp8b2Y/+Uam/nPJpybKX?=
 =?us-ascii?Q?YeuYWWpemO2CbW1Ox2U/Jq9YdceIHZlqckiaSj41/aMBz5DOJpm6aG5u0Qec?=
 =?us-ascii?Q?8xN44/ARgeSg4pWiwJC2pBszCytxEO5l7gLklaH6sNzlTzVt0XOuaaPyCLos?=
 =?us-ascii?Q?iV0/vp0z6OANby/xwu8AWQ2CjeL0LcK3AywE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:43.9400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5c96ed-7f33-4c06-3a7d-08ddad4c44da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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
index fd43c047991e7..d6b6c1ad6636d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7168,7 +7168,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -7219,19 +7219,13 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
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
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.49.0

