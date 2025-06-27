Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54465C7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD0C210E942;
	Fri, 27 Jun 2025 03:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5A/55Dm+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8E810E941
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzCJEfdu6+G6+uqCS9xue3MLMnG7Jc8kakJpnK8tZwv9kT6yeKz1VHVjr5ezSQ63AjkYiX2+7bh6K3ArRQijoiZ0dxbMiZo6aSnktM8OV7V7jx16g1VOkXvbk16vJ9sOM23+/tJRQo1cdhzERwP6KGkVckvuOiPgQG7aMgH45/OXeXOu3KbWMHXw07/0rZhhLRUR2Lx0IUhy+6S4qo+THxkkJLf5QXPsAluFtAryS0vnQUU1Z4UZ3du5RwHgsQh93y6wHavfg6igJkNFNLPngeOfUYlO4sGUQh7rp/4G/OquFoX1dMntkHXCjtZixscPCM1toLgxpYegS0cu3QHZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTR2UtbfCuYcQNfbpHAQHf4s7t307nX/I9+Fw8M86Eo=;
 b=m9x0Wx7qM6kh12CbwnF4+OIlfn39qat21ezxYel8AcwC3YbHpRFPnC2zr7pwrSe3JiZb3hoj784EjLr/WhnDA11Ow4TuYQUElEgYIFVFHw/LiQDMBxy7vFjiEOAluo4tvU4PaM1xp94ArbbIIYekUttemHH2llT6vS0MR+zh4NId8HBLxIYX8jFznlegS9u3SBAUjlp9Gh4+ZG6qK+S8zNayecvF4lXv5ipifGUBVe49RKe64BESUdsUyiExU6zYiASs46ScgrO4hb09jHzhvP8kcgoMXG/XmDKhTm1jQdHG8RNdHz0CnsZTePC7vAMfGHWh5PXdLQ0wWtXXFb3Z4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTR2UtbfCuYcQNfbpHAQHf4s7t307nX/I9+Fw8M86Eo=;
 b=5A/55Dm+Mb2kcNu8uV3kcCH3+nPtDLUDoSV7KHKxnLmuwTQ3UVvwmxZqGifTgh8xECtf0mOlDZEd0ag9LeJIlWEYP5882/75ZtylFlFsaaVBxx7oy82BTfSERdSOpgk4pOJRt7bBcN3CigGSfQlbsGDYg50DbB0EYRpaHLq+pPM=
Received: from MN2PR08CA0011.namprd08.prod.outlook.com (2603:10b6:208:239::16)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Fri, 27 Jun
 2025 03:40:32 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::29) by MN2PR08CA0011.outlook.office365.com
 (2603:10b6:208:239::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 03:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/33] drm/amdgpu/sdma5.2: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:44 -0400
Message-ID: <20250627034002.5590-16-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: c205cfe2-c7a1-4f1b-9bd7-08ddb52c5e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PeQe3Cr8C+X6lKxjru7bdHddQDRBLnEMrUGXACUb81OwtFe3s5nrj+mVNg78?=
 =?us-ascii?Q?St/uEloStwGkVhzZGYcRsk/CK4Fa7sEB+kYINi87KSBBVypX/8JP0TVGgnI2?=
 =?us-ascii?Q?ciCyLVTjyP1f+RiOKF1jdtnHaWJztjqj3rJF4/5qSEvw7pS9EZFKedmnfo6r?=
 =?us-ascii?Q?rZmwpnudSfxjCqmoiC2YZDG9DhJUMZoNFa2KBbRaKZbYAohjVFgCe8PqgIyl?=
 =?us-ascii?Q?Zsu/8wxkuoJYqIOgb0N6ncoJehpjDvOgH7jU2q3oQH94uxyV+YqKILhWM+Qs?=
 =?us-ascii?Q?F+Inpcdq2xx5G/oEmRH15fdNlLbg6cUcizgZfyCzO2fyRZsG6SctrAfamA7W?=
 =?us-ascii?Q?TCGSpX5CA6b8E2dhbeQKWvue2SnxLUnsgXLtLwImj7GFbaurFnHuXtqVdYPK?=
 =?us-ascii?Q?G8+VFRpJ04CIk1Dt0E3tbflUBKSWgw2Q6+tragpUFWQUpL5buXBT+AuxD8eX?=
 =?us-ascii?Q?Bf6VCoIzcVOXw8CbcW3g3u6oT24Kg9FEeC1x9bO8TB0ECbH30mZ+3cZtdgJ2?=
 =?us-ascii?Q?Af0IegfmbZK+vkNseWXvhjmAwYiWNaz5BVAqnzNNnRR4HeSvORA8CTHQM+rN?=
 =?us-ascii?Q?n6TYFoP8bUg3G9oE90VWTLYj0A8Zj5JVqX8Dib5/9DsgTGK953ZoMlWwS5R7?=
 =?us-ascii?Q?mL5b/o8Sp6hfjePk1nNJzmVjsoZ3W/zyPN9CwoFQOcUvwrCJj+7SItwxjqNc?=
 =?us-ascii?Q?Zinl42rZNgX1KsGPGLkobMaaNL3bFIlh9MaOWwgJLd2gYr5AZ6dxv1fQsZvz?=
 =?us-ascii?Q?M7uLNZppl/obXWA0d1au4ntYC5S0UqkI37WV07yVgXj0I+sx/wwA6XLrwpke?=
 =?us-ascii?Q?UsuKdg6Bj/V/u4sov9CgMUfIU4CFYL39SHq4DiCcXGcCWO/+CwBKBV17jwON?=
 =?us-ascii?Q?bCuSPZ9kdGhNYEWiH3O9+D87h+IlzFV8hrgaM6BCfhs+vT1YgW9ZqfDA+NQK?=
 =?us-ascii?Q?KokkL4gsqiDgMDBR9yXhUBYvsZPLkWagMRrlMat7ygQSC9AnXAuccMLzukhT?=
 =?us-ascii?Q?oNIBi1lTmVWAOhogD+xiCqauJPBimYMGRR/mdKrnAo9pnb7kYoDgM7hWjT33?=
 =?us-ascii?Q?5A22JI2CQxAt00C4j+DMYs9j9JHauvIbnoVYYUD0yp+XgqYPvcZ9U0kABEZV?=
 =?us-ascii?Q?BufLe0NQQGdrCR4XmLjIqjQyybx3Ca+tuCSgNIND603vhQHQm2EmS51AHeLe?=
 =?us-ascii?Q?PaHcORobwWhaX5eiMdTWb5euoutgyVHQPXLGNYZnM7uI0tdN/uWg/Q8Z1RqC?=
 =?us-ascii?Q?tknuDZ6ojzmZxfuxS/TL6TwUb/50tr8S96YscUyYyXf5zo/Axfl/gWJoPq9G?=
 =?us-ascii?Q?ZUT4r45zr3Xhbugx3Uo9m4eN3ga+2oOnuHwdYqt9AwnHA/kW2yrl+FZ93OWB?=
 =?us-ascii?Q?mWfsx+Z0saxmYnVgjfGkFr2Xq5TrYePNW8+NqNpEWk4KZy14Q+j0R9ipnSXI?=
 =?us-ascii?Q?nNrN/ca18+2GLdCgKZjevZ3yYuTW1aY8ht1Xh5G+jD/RtkfURwrvbtSLHnoP?=
 =?us-ascii?Q?KA1XLBc4I5kQNgfjSJtve4VrcCCnKpwVmrCi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:32.0152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c205cfe2-c7a1-4f1b-9bd7-08ddb52c5e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index b9498697ef41c..58d92225fd5ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1448,14 +1448,25 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_id = ring->me;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	if (ring->me >= adev->sdma.num_instances) {
+		DRM_ERROR("sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
 	amdgpu_amdkfd_resume(adev, true);
+	if (r)
+		return r;
 
-	return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
-- 
2.50.0

