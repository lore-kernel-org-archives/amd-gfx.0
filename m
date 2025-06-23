Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EE4C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC55C10E41A;
	Mon, 23 Jun 2025 16:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lQk+J6lk";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B711510E41F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHbJwfBCTFhrQsJDkh2DzL2SI/M34at9E/sOzBqrZDB3Vk8o+wKbfnw3ShVwhHATaRrFQUE60uSelcwBFcWGP4Rcru/axvTR2W8CMTr/vs67KOvphQark9f1kPFDCNYd+vPKltEkwvdm13jI+K9zw08bt1B68/5IlI/PHWpB4R/7VaVXadDEFbDk9bwF8ac1szXC/TeRJSqNqrMuTc6aUFusCMIz0TcaoVKSCEbg20Vau5MkNkU3pijiTZQh1Pv42O9Zw0s5u45b8qIp/Jjb0biWSX7j+65+Xq8j5LKQlq6lBCEDOnWOoVWy4FIzhtVi8CKoQpTZlyLwCMP83OfkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIJ01F+VCHhA+dhHdLk+P2XNwjBVlIuynvfOdT827Q8=;
 b=Pwtif7yPIHJpEv7qHfNOb6NGDiI9p6Ija+rMo3ySPPIxQfY59smfP2XIeeec+WDS90MMhHiM0hEopQNuoEdXuGu5mae7CSSVuRoib4sR2pY2SOe8bTNAQv/Rhj9avi+jO6p436GA1Dn9K8g3XBK4Gpcud0CdwOpuXWzaE6Dt9C0QOnQc/a5fg/6xuHrMBVHjvS2kuMBjazHxjG6Xrf8G3mezIemgISbTg4XO5aAeO0/GC6zqqB9Pq2MLmlGoAp2TSzFv9MFvYqKvzi320B2ScL8iWhwkk8UyaTLhhfLOWdi2+o6+wX/HpVVivvK2tVsUC8esDflQpt9lsF2qlQoaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIJ01F+VCHhA+dhHdLk+P2XNwjBVlIuynvfOdT827Q8=;
 b=lQk+J6lkv1Lm3wID5c7y2oGWDqzL4U1wXbYDdnwF5PJnTGSiFwBMAdr/c0pXOtKTWEjRy4oRLw317IEYr8WiI2tNaH9/AukjOpcs04NT8BMixXCNr3IDmRZxG7tA2cEsQE5UR9Hul/xpA1u7hDtZ3rYqUu3oEzox+J4L/xSfvFU=
Received: from BN0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:e6::29)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Mon, 23 Jun
 2025 16:15:10 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::6b) by BN0PR03CA0024.outlook.office365.com
 (2603:10b6:408:e6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Mon,
 23 Jun 2025 16:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 20/31] drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:26 -0400
Message-ID: <20250623161438.124020-21-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: b50c738b-32c8-4ed5-b793-08ddb2712050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PRvV286XMXLxKGcg6UZU5CAhBQ46ouyVK3xfW3r0nf3Pr2nxIn21w/hnq0Fy?=
 =?us-ascii?Q?bc+JaZr19c1YA9ZkPykZ/Gon+IZxHbYMn1kude9cA0J0CvI1VvbYew2ns+/x?=
 =?us-ascii?Q?5Q2EiUxMFQpQBNRLtDNSJ9it82Ck0ScpWY9Vp4LF+SyoLFDLJNrmuXZCUZEC?=
 =?us-ascii?Q?z88HcFmmrKvhAirSKimkdOekIKeOC/CUj2lDEXp6qilQqaV59OAme7xgU81J?=
 =?us-ascii?Q?gw7MsDwpSZNrMHfc8Y0fFlGvbBKyFnohMuDEzIM0ydAm+VDewt4wYaG47PvH?=
 =?us-ascii?Q?bfgFVBaq+j7CuenF3Vynz6H/e9+s72hSyS0HfLFrvebdHGjXOrjjaUW+gIau?=
 =?us-ascii?Q?EgjUccGbUf3QNuSbNtyIFgMSTboQiwH2ElvD3EgDU3pt5S6ao5vE4f8PmyfA?=
 =?us-ascii?Q?OdEnTKGPCtSNZxa+cRWkGv+SXRmNIDYTSed4c76dkiE7XWjx+dhCXjSXn6ju?=
 =?us-ascii?Q?KCNc40xwq8IPGxQgoLNQe2krCCdsz9cNDthA++ElY8hxNPdOyQ068Yz4uRcZ?=
 =?us-ascii?Q?ZoIoXfhSYqyHqUvD1/tKir6EzXnBOGkX7TtWqO1dusRwCtt3vG17oGlByhez?=
 =?us-ascii?Q?S6OtzeMUYCTGNCtUmrB/Dh9Lg0zOsOblFQbDO4Zw/CBx/yZQ2ZzmsTGVt3k2?=
 =?us-ascii?Q?pJ76Qc3lLjO+9RBcsMS+rH0NwaBAOWnhm6PKrHvBiksQzUKe3qxrorRcU391?=
 =?us-ascii?Q?MvRlY8tz3OFvMacJdUOThrD+dFM4VLKqthmKvJTiy76s7F3F8FBM+yD57ldQ?=
 =?us-ascii?Q?1BUIttBraqynvTe33fBbTrAa+GXDoY2kRJp2um03WYIhpWzYHUWlUNJ2bgVh?=
 =?us-ascii?Q?0YewjrlpuSdsFhC6YbsV4P1L1r7Ngt0PAEACQh2NANwg/Ivb7UNMFuPs2rgc?=
 =?us-ascii?Q?dy4KPkTsZjCX1vhBTYrcFTWGcWR+VJld26xrOGzHvq9aH1ir5VAxFOrfKJLg?=
 =?us-ascii?Q?gZPEqC+Fr7C+xgEJ/Iuw6Rwag7xb3Uh5ZwoyvJnbIHM9/l/1QK0orPvlETWJ?=
 =?us-ascii?Q?ObZSydA6VsljpFYENgKW2kKArl9JUeCmQ0h70ijbEYqwXI2I3/+O/vP7fBlr?=
 =?us-ascii?Q?1c8AUr+e/WOEJqSz2NXNRDxhtPJhL+IOqgoOSL8OzkHhbrDoIsv1Y4dq5Cyu?=
 =?us-ascii?Q?Gty6OBhaAl+KniI1qOWqW/bobDN4Bl53SF8CegO0U9stASdPh3QJOkiTKYY4?=
 =?us-ascii?Q?CKR3k2s0l1R/4DGmRqAnHWbSdEdw1uq+AvvWCrqaxJVEsrudOYdaqieoKPIQ?=
 =?us-ascii?Q?QfteaFuYmxymrGtJPgp0eCP+4nrakou+uplPY929tdckcW4vgIEwXOYC9KcD?=
 =?us-ascii?Q?SmDaVqd0yL84X60STQKNHuuwdVl80iWb5ZI+5vE9h1PFkhU7bhpvUeY5b5C2?=
 =?us-ascii?Q?km2an222cmETXKmeZNFGO91eqkk7iW0jPHHwjwY/llrzq+CLFlfqQ0JWUaho?=
 =?us-ascii?Q?MAO2xOJOVntJ9nAy/Sgi1cp42nDdNygtvLVkrYCR8GmiD4CSNvMGqUkTWieI?=
 =?us-ascii?Q?nuLHZriS7mN+P9rs7yhrJr97FH0j2/eKe+mh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:09.9272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b50c738b-32c8-4ed5-b793-08ddb2712050
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 78441f8fce972..c3f73a2a911b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1147,20 +1147,13 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
-- 
2.49.0

