Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B6DC7EE32
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D57210E951;
	Fri, 27 Jun 2025 03:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1DnosRmS";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B028710E952
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYpYwKwtKj9EIXaIrXI1AWFFPV81KVlWQVexP7g7kcZDkhnMa6mhcKzP+2KAxtI7FxqywsJGSZf8bViss/PTfe+I1s9x8BVqmo7+Gfn+Ae0Ng3EP9iwulYnUleT/wmH/2pFirs1PX3JvH+B0ISyAPw7z8P+ba8qKi+DBZ9Ffjo6gKj4gNcXnpqR0QWqIDLIlyRmvVCspBKRe469jGwYsvZBgnzrI8aAzSotqrKCZX1sJCzz5JG2aPXDv+JfdDqwgopUsso+xN3FloITGAK8kmlAb3cQHNsTpixRK4tLIaQJblcqGek7BukCVlZSVpBJ/jGRpojoDBgi1WOl6Gunywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAhM0ySDYabhnzhqULnzVBft71MZQIXo0UBgQ29KQlU=;
 b=nCYbCAwFEG3Mg7Y/tvObwlbCJWX9U25QbGAn9f3+1aGASGeKdikwSdrw/5R44Lo6E5fESILoGDCcuRSb5HpF2CRkZjY9RkJ+mmhsegI3Ah+/96fde06xkLb6amuM7cLYZik/soEJXh0RAfO/yVNDTnOWpRhEmUePCaeSLxoHuCi8IhadYcOk2Aj8TexicTPfw0sMQ7UuU2nRt7upskllZbwLqEo8uYmSJHJK1st04ELjA4GBRa3jvJjHAg7THQ1OE6xvO1QJZaOzaO0x0yfuqJG04PMCu8Ei1djUwin0fZV3IOMCK4tYxhTEaZZQDuLlHTJOE5gVDcrSDIWoZiD0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAhM0ySDYabhnzhqULnzVBft71MZQIXo0UBgQ29KQlU=;
 b=1DnosRmSVFBIh+DFp7PtxGN1X11R4lIYhOmYZbq5wY/tbsnI1Bk1khFlkCcIOq/no5xs8uyiepw/aZDZ3HuiSFHw5sJ51/MfmC2hI6EzSWigNttf2c3EdFPz5DCjacrkiyaBEluwXKctdi/Irf406V9n9zG97m+LeP8Pl044WHQ=
Received: from BL1PR13CA0196.namprd13.prod.outlook.com (2603:10b6:208:2be::21)
 by LV8PR12MB9272.namprd12.prod.outlook.com (2603:10b6:408:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 03:40:34 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::be) by BL1PR13CA0196.outlook.office365.com
 (2603:10b6:208:2be::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.7 via Frontend Transport; Fri,
 27 Jun 2025 03:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 21/33] drm/amdgpu/jpeg4: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:50 -0400
Message-ID: <20250627034002.5590-22-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|LV8PR12MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: 82351440-6c8c-40bb-2a70-08ddb52c5f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iJnawqI7hp65ZSVJFY/c+Pgp64oZtx/veCnyUew1hy/ItyPiaXnHM7HWqL+A?=
 =?us-ascii?Q?FsQIYAftdvyUAsHIDYB83X5B8Q1+nAO2JcwGLhNGVppm/CzX13qkq/bNKKW9?=
 =?us-ascii?Q?s0AzomrrX+2Bd4xJMPdqVT5eEHuY00ttrG49BGHu2s+Q74kMP/99UzZ8gGNR?=
 =?us-ascii?Q?b83ONG/G1DXpdvW9S2Lr3g2Ul3undMi76lnZ+FnRqtOtKsLW3nZgcoci9y0C?=
 =?us-ascii?Q?ue/ieQfFw13Pq3CAyfiaEytxfE2fR2fv3RXua7TjqsEmYQx/eZGJ5jzNHKCQ?=
 =?us-ascii?Q?6V54oGkpFiJzYpZFFp2+xX9iZyQ7ix6Q1UqAukgMczLWvuC77qsGyEhdpMAD?=
 =?us-ascii?Q?HtnIa0rN6EwfJ7NvzZuWiUAi+1M6nc0HVfKwUMelQz+xFmJE6Ynop8fU7wB7?=
 =?us-ascii?Q?sW1Zs70Y0O432B61JXd5dO8lRojE5aNFclgHHDt/z7lKvwg6Z5B+qVeV3cXm?=
 =?us-ascii?Q?PpL8E8JxP9B8+7pUFMMLhoGxZTjKt/LW34aQDzeCozVwbhv8T59XEbMlKxnj?=
 =?us-ascii?Q?3v4/BgL1uXtsp9+B3U6UVzoLJKnWGVH941DhgBlHIr57a8BHzLbwFRjgyBlh?=
 =?us-ascii?Q?6orkk4iCHz5eA4w3Q1sTax0/1Jci7Lqj5iBYUQEs91YTh9ZBR3yXvtzLuAbt?=
 =?us-ascii?Q?pKdvaMCAehXPYvBWqqDba214N7IqRaRYZ50acmnBRMGX40wTGFsPFyZzZNz9?=
 =?us-ascii?Q?dHAV34yL0KNess56nh85+yfZbn0rLSWki349TLVA0tjfXRTRF778165bsaBe?=
 =?us-ascii?Q?U5jCETufrqh7T20icZK8mcc3gC8pP6Z5N+1KczloxFBnsXNbNXr50NHWG5IS?=
 =?us-ascii?Q?tkAhFczvZiQ5/Tt+/gMc+EyITrX9Sa3t5RnnKQAfeTuZPAOcORdaBLLMvEML?=
 =?us-ascii?Q?oQWVE1SwyMOAFP7nlB/qKzPZ0N3qZbSFTTI3SqLKE26cXSW0KCYYYAi3C6t1?=
 =?us-ascii?Q?qhTQ69iWi+mC6WFjI/VHfVCBBV1rNp7uYrbtAXxJmcDPr+HfB2dGJmgVTlqY?=
 =?us-ascii?Q?Z3HsK7HZNIzZUU4gu7RBE9TfiUYZ5GgGnwLEqyNlpXbeK5WDeTAFOQ12BhJz?=
 =?us-ascii?Q?cgr5qcSt06qEO9AcJ3ucHUbti+ZmnAb9qD/mNALh4Mv1+MTX5XLOQD9pd52G?=
 =?us-ascii?Q?1Lqfbn3ZkmfAxFTaB1YDcR1vcQUK8esUvN6BvkeSDMstyXY83E+dBqXLTebS?=
 =?us-ascii?Q?L9uHhAg6wSZMe0B4cnc/fxz29lwJ+mswnqierO7WL8in040olhl5lwxTDSig?=
 =?us-ascii?Q?yVhOcbIL5+huNzvNact00ydWOds3CKtoHNtaRPC0mKDzQ67+BGRHwTPGI7Fo?=
 =?us-ascii?Q?xtBGF4ULYpgTyn7RRSWakRDmgOKsidpqJMNuEwatjkFEcC8iS9A6cMXTIf11?=
 =?us-ascii?Q?8lCgKOwC3d//CJuwdGDAwMcd1sPm0LvnxCfKDYLr6p2/gE0wMKnQ47TkD9Iv?=
 =?us-ascii?Q?HP2XRm5gd5hjxgAdcpRmhSex61ZHeIL1pd96iOOGLf89PsD1mcxCJyQLnPCC?=
 =?us-ascii?Q?FdNgJ/s+uMsKrIXQBP5s4V5XCUdPNoI6kpjv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:34.1256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82351440-6c8c-40bb-2a70-08ddb52c5f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9272
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
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 1d4edd77837d0..e9acbd5afbb7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -724,20 +724,13 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
-- 
2.50.0

