Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809FBC83F25
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C55810EAF6;
	Fri, 11 Jul 2025 22:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UJU/sqMQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFEC10EAEB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJ8/RjEbcwI2/F3jpM5YZb392ZKlflbQ3G5awl+ITAXoZoB7vbu2Xe+yR5KOD9kz/wx49gjJFpMezhl1+2rSz40jdUXFZqOG4zpe7oaQ0whGY8joZm1ZA4vE1c0aS0kcJd7wPAYHoP0BOs0IpCJ0RpXxo3mCF3E8ipWtxNb2Ma1GsdigcSfmnN5lcdrU8pFJu4Ljm9h1YVh6bAZlfbqlukJQ6CitV98q8Ii6V9sDdBDmAsrgka1z8DlB8d81X2fM11dwNpkmAkDr0GKjSDwwnjtcsyqUn9P3w99rB/JJeQeSd8GMR1O0qf6m+e/alepTi7OFlEXLMvp42ODZQJVg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmmPBfWDDDg/bt+7OqXGjyOsK7oxjdnqkMQG6sGd2qI=;
 b=XXIgWPqap2Dpnnis5OIQltn421dFWCewDKap6dL6Yf6KR70uuBZx8dulB0Q5g1h53K6GHkdAfYikH6KeoclEeD8xqMoS6h+N5An9N7E+C38AKZUw4XTz5Ha4Ze2zG/+dvcc7l7MoayAy2LBJgTv2qjVtLqI4OJ3hj7I6p1aIrIOUl1oXgfXzvvOYoG7h2mkcKn8qjqH75FyI2+sf70Nz61XIMhBoUAiJOj15trIqICVukbC/d8O8VGeJZB59OEXNluLRKsc3BHyt3DHzIHmvAhtOAcHA7jYISMWj/6eMP6Ly2Rl60E7wHRwPXGEyu6nlEYgcc9/7mbkniuvDzM7Xkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmmPBfWDDDg/bt+7OqXGjyOsK7oxjdnqkMQG6sGd2qI=;
 b=UJU/sqMQcJw5gT0JGtMHVinx3/eJJi+67Iu0sKsO6dGOAZUIzmagSxUd8cBy2CUymijKTxy/UAs2EROJy3dKYlpu+m1qc9yXe9S4RRg0hdIjWow9TllzfiDuA9ZnvHA1jlabxcQh08lhA946/jLu5YGe5HLtbzMPqSvMorvWtIQ=
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.24; Fri, 11 Jul
 2025 22:40:50 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f::4) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 18/33] drm/amdgpu/jpeg2: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:09 -0400
Message-ID: <20250711224024.410506-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 599403b7-566a-4516-0299-08ddc0cbfc6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?phVpdKLYGIZj3vx/ya2gP0WLs9P6187XHlQkHEKgWPKs6eqt/qTI9D5Xogxv?=
 =?us-ascii?Q?NKBzSWFiMLzPnUUFX9ejajIMBm8HEgqoSWqH3lBFg9Ge8K89GZSNY5De4U1G?=
 =?us-ascii?Q?KPAvcI5/86ygBp0lkJQ3Re8vKocaR94bZ1WDC0OnTBbb+50jl8AfNQAd4EBi?=
 =?us-ascii?Q?wL2sPSborcnJq+ys6KJIiKdKK2SOTWQb4bj1Ertu9WRdLd87AHKya41Lypkk?=
 =?us-ascii?Q?Z8zf3Rum7L7SgW4JE9ctGw2OplAFRG/dW5AxTR9kAU+w+xVsWFzuLUQdpk6D?=
 =?us-ascii?Q?gmFsLr8BLWSRcNTjxUhknz50KA+OVnrK4MIlMjN5eng07eGCez5ScV2RNJtw?=
 =?us-ascii?Q?PTKL7MqAE8ZCgex3b7YJXgA92Bx2c6ceohG1q4jK9mN9yp+EBr32/zw2BmxE?=
 =?us-ascii?Q?47nsDojyWqGRrYCaumljRjHlCV170PpEFKejn8nQr6X3MqtCyBHC2MlO2T9G?=
 =?us-ascii?Q?+X95nVEsLxB84O7eD+t0Jd5Lcu9L3Qupu9pP6b0dIs/TIbuBbKB/wt9XIdnV?=
 =?us-ascii?Q?6SvSc5k+shvCcDfk31k9/JkzkGO6Yhd/dMfjb5zHuSxLhJBnefxcsupWkwR4?=
 =?us-ascii?Q?/jCQXwnTzXWaha3Ujv1XsOU08rz2EMZfTArcKQOIsFLUOFgdvxmtyz9LK5Jl?=
 =?us-ascii?Q?YYufG/C411eybqISV9epux2okQuJfDQ03XsGI/Ay131EA3voYnqylu/rH2r5?=
 =?us-ascii?Q?L9FCj1cV/bIFV8Sgg4aKjjhMmRxvY2dPeqwbuq72/U503W0pTyIPHCmd0WrI?=
 =?us-ascii?Q?vyi0OmtIn9BpXnzEx63wHbyEbboNBgYcNVykTuxWntshHryXOhqGEfEM0kvA?=
 =?us-ascii?Q?//rdbEt+9ezwn03gvTktHrSGBossDKuOE/tHeQvQnlyAzw5TEPI0YPQmA/Do?=
 =?us-ascii?Q?/S+FbhIUyrhnq0wRH2piTEcAQjU+XMEc7+QG1FUaeM1msMwETg5eK/GsktzA?=
 =?us-ascii?Q?Xhm6RTz+fTe7qS+Gt7nqjmKAekPSrQ4ctcVAI67XeoobYZJO8dU+6LVz2Ana?=
 =?us-ascii?Q?8gpvf/Ikr8SI1dL5iN6o4yGDxfTof09BZY97VgKNStvSYt7GRlTNtblzKNkB?=
 =?us-ascii?Q?ADHOc2rykILLFivLM4HOdjBZwF5e7OLJiRnlk/RTfS1as3+WYpRLaMizfc5x?=
 =?us-ascii?Q?jWdK13/3H69CQTbX/F4n7a/ktwlFfxiF4giVs36/y6ss5BH/F578QNgl4fo9?=
 =?us-ascii?Q?pGZ4IbeujzTaLToRrNCVTTiOLaw7/dRId8GtjJPyIHK4KKnepSjQXNEGqUpP?=
 =?us-ascii?Q?9YpHG/z09Y1XpWnVUQplAZkF9QGwatEXOpGYfkqD3QG6ZQdndwuc+JC3c2JX?=
 =?us-ascii?Q?e1thCi0ktkfEd/OFFkGFF0FCcdVy9RE7bUUdVdiXPFpfJflnArS3YSXdBibG?=
 =?us-ascii?Q?manMSaF32mNxuFroPzAx6+netNnu/QrN+L3nSCR5k+33sUlfd8Xf2kk0YeOt?=
 =?us-ascii?Q?CkwyqUk9pDExJD3p5hfOd96+vR9FA84wCOjtRjGk3n/UvrWexxi3i+urS3jj?=
 =?us-ascii?Q?qHYvVUNr768nAa76BJ3XxBTh9ou3JD4olYvy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:50.1611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599403b7-566a-4516-0299-08ddc0cbfc6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 0b56cb67e8f1d..554af4b9930e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -774,19 +774,14 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v2_0_stop(ring->adev);
 	if (r)
 		return r;
 	r = jpeg_v2_0_start(ring->adev);
 	if (r)
 		return r;
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
-- 
2.50.0

