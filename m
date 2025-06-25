Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C8FC7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF5510E818;
	Wed, 25 Jun 2025 21:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x1LWoDzc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF0310E23B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVSGa+1QOpFT5tsV1s+gYDIS5Cj4a27JOimTagwT+Y3vvkQMwjJtcDbEomUJkryPqwmn/7LY0ir4y2TgDhgQHmGykchr6RB2xbdXGCgXfaxgPx/ZRcZr88VzWK0Y8aKFw+nInF6PNabz2I7q7ku6zvYplkkIJGy2iAF9jusUfMCy9tTnRB+QOtaGci1ZHVh2T/xJi7BZ3riTRSQeNaXeISe2YiTsUlfW3z/Luc/FFEMshYT9/lTXvIUIIhvRIJqL9Rp4muOWuRbonLyaQy9jEK/Fn/0gF5GVg6MXWpXcUre7Sa8W5w4OtiY/v6r+A4n7RU/n0Oc0opdjHOK9fDZ5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8eFJ/jVkRvKx6Ll7gObfAg3bVRNc/PMypaMrIvAxPI=;
 b=jwcVEuMZx8GFBfq8bOSPRPntwIycfmjIAwEB/l/SR1tzyQXz+6p2VNBn6dDQWm4A5NjYTPpF0mY8xyyOyHGPbADQRBmgzcoBt/VyazEa34Ha8LaHLuPmBIUpWa1+HcepwaQDrgtuFhu6h0wLo21/aS+B4mIOV21VnJwU7jVOpQKwpMlb+2iUyss/3TIzrGR1TPixZc4gZ/vQpNlNnePANs15fufPQjk1W+vYYjw1UeeYUuQJ1SMSEOR6oV9Asj6IzDT+TanlyavwxmQYnt4IdLdjnDC2xynQlpfXpP9r1+kAz++4qYrQy4i4x6dprYzzKUzvvcmwSlNpmjn1IA+PNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8eFJ/jVkRvKx6Ll7gObfAg3bVRNc/PMypaMrIvAxPI=;
 b=x1LWoDzcm8RpfTU495c6qpIazuT7FpgRR96Q6tMpCQD/GikJv4Y1bgq/HdknvRMJxMKH4WmF1u2YNLKZ/fkV/yaF16hDrosTWW7qfhqNuk1x+eH0RpIHbSEYhtOlYUB+a8z91L6TBw2NgGE21HnECtkDDINByzzP2EpYifYZFTA=
Received: from BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40) by
 LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 25 Jun
 2025 21:07:09 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::f6) by BYAPR01CA0027.outlook.office365.com
 (2603:10b6:a02:80::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 19/30] drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:27 -0400
Message-ID: <20250625210638.422479-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: be7a0b4d-6c5e-4a6c-4cbc-08ddb42c3f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UsTG1cp5WZFVkWikANegN98c/BPHT0yfm1/iUp+z/xD28DurdEZD6mL3ORX0?=
 =?us-ascii?Q?JniwwxSu/Stzn2WCATGBKwQBXaYg+JlUq4JJySa+xLolupndw1FgGfgF+Ml2?=
 =?us-ascii?Q?mSYXviSMFSB50EK+eZuQ9vzUU0AyrS3mQu8PVkxZwBdN9ldubgfvsqNDsZgQ?=
 =?us-ascii?Q?4cB6M4Eky1vHhn9y38P2UfvUJVReZteA4rSfHevncrB5LYeVBasBd3Sks/Sg?=
 =?us-ascii?Q?1eSJASscvY/e2MIu/S8NudM6qrKOVIdApY7NaERf/9DoGu3dddtTWrV9GOeT?=
 =?us-ascii?Q?pYhNmhqB/yzLYcAD1umRcT+CE4WloP0hz4iGShuQng33h25m9WQ/z5j33Z+Z?=
 =?us-ascii?Q?uqVAUaFbQ3ysAWuv3hOw+Iun5Tt/aPW+pylB+i+9KzpXF3SrV/mnqiTVw9sx?=
 =?us-ascii?Q?aRVCBOf8OMvPQ3xT+MNBifTd/L2D+VVkJTuOJDc5dPCIuQ4Wm1Kwmbq3bBuh?=
 =?us-ascii?Q?hWq1NQBIFmiJfQFPz3fsKkx+wdOKGImcpMSPVR0u9T7G9ySR+mGZXXZGy217?=
 =?us-ascii?Q?ts6NxrYgCiIbl2Y8KyHrvCooSZq4kutqwdyb9WgWo4HUJ0E9mdCZPcDzShR5?=
 =?us-ascii?Q?7YsH3lPzrJ/C5Dn/fNjgTcwEiDg1t2T7ScAIEOTEHsKwA0D45OKFDZLS11uq?=
 =?us-ascii?Q?zKGohwH9R2B32fhAMgNnZ8alMYrZbROtQureb1GQMypdfQrzXaMAjCa9dpI1?=
 =?us-ascii?Q?T41egk95EXb9hIhGuv+y8mcRK1nJTj4iunxostiJyJ0Rib+s9gaJCorPj9ak?=
 =?us-ascii?Q?oUNGlBLCaCuTqIq8h0o6g1+UkEKCw4AO/SUwgZJOcZlUbP2tUtg3LQpfu54D?=
 =?us-ascii?Q?UyVF16aBO3OoZF1ZWaRZRAJImAiSapMgr3TCz8kBnQ/e3T6o4pOL7qtBWo2m?=
 =?us-ascii?Q?+56X4z5LbLEZwXGFvtejbyaWnJWsaQ9FL9eT7tMN+VSUgLvCzfXfM4yKcHu2?=
 =?us-ascii?Q?PVgSYrdjmAqC/knM+turC1+2ZDaUgfeLkIWqLIdCOUpowcis1NwhdetxMGZy?=
 =?us-ascii?Q?A84Tt7KnWB9qg9PmiGwrPyOAnKBXzzmstSMzXhipQ8pdbm/yj7aTOLIuLzbJ?=
 =?us-ascii?Q?beZp86HgJv0FmsLoklbZYP5mh0ymcOznrwE8RCER/m4qlCHdoD78h+5HHKGd?=
 =?us-ascii?Q?OA4ukjUzl3F/gCcUsH6/Uols1iUs++QnceRuMeKg3zLrIBWtvZsirjJ+MDgx?=
 =?us-ascii?Q?ezycdS3PLXUC9ugpjPFbjsbPbF3r/yCNOInI0pDcatUuQKnh/gml1nYktceY?=
 =?us-ascii?Q?gOXeD4vaneayRP0pRfpBxiX0YnJZpOv9zUwQGKxxbUtSy20hZIcirNEeMzd1?=
 =?us-ascii?Q?vUJXCcDjFYD4lBlV4YcFxLmPBdKrAhgq9uTFXnO60KeeSC4X+sSqbnPH6lCh?=
 =?us-ascii?Q?qPUjYZSeo3gZlmBmvawCIbz0XWDqvVAy4HI36dtX0ejSiZain7pnjtSQ3wuj?=
 =?us-ascii?Q?VCBF+sAFw7BxDDadeHsFxdfT+26DDH2VH80xVphmRJ/z7cY4DLbkme8iW8qN?=
 =?us-ascii?Q?HZQtlMHadPlf4ash2oLf4DwbAX4Hk02aKk3S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:09.4087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7a0b4d-6c5e-4a6c-4cbc-08ddb42c3f9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
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
2.50.0

