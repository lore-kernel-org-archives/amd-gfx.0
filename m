Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5755AC7EE31
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE12910E23B;
	Wed, 25 Jun 2025 21:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DrNNUgLW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C42C610E7ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5MMkqNFbBO1PP5ag/ybktbvaxiErATdFtgda417ki/fuq5JgpR9uXCOGVDBXUS+jiIK4u8pcLqM/okpSG6ekuH1l4bGXn8Cq3aZ5FSxxYIoKJGQ8FQ4QY1uUkyJrgrLrw7uyLr559czPQSaHJB+WxCSR3d9NNlYVey9s+fRqXuRks7G49Z/YGKHXEFMCGaa60kk48UoV4ezPzpFi34/cnGsfNer1Lhtv1XC1djhgI8JP6jFb9vRneMeQRXDERNUfIBs+Xkq+xi/PBqmZ+ZQ7Qy4pATmVv6R7Rrpws7BWdYjcpvW/ya7Jr9N3jrhSkgb8j9ie+8Gg36bWzw0WxLNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE2uvAzxyueec+4syxqOa3TWhiaQrtaNGYpqHt7fu9Q=;
 b=qWVKAygQTqHt4Iik+tNN4UqHMA+7TgIalBsZps69eqHT3NGNN6fJklhT++LC2smW7sdL2HnpRUrDR6Nb43+3RLK5sPSvOzpnX5PU8zUbXVNcbmm3aXTOvN9MheY7EKFrEBMNREW9zEyF7623Qj0wEK4cPRTod94bMDuR8Vng2gMhOfGnHbd4OEv6zrTWFJeRLDzfqHSjhUkYwMxwEUOgdrCLeJjTD2ETDW83ajvVUX5z1spYhmmq2YlY6CXiK7qrRRJCaaG9ZuLHBVie3dhgyLiWeMkh9Bn8cEfwxwWznjxKbCOmpcIASvWM9Gb9rAVW5MvGY1hg7iS7+tDwej9Qvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE2uvAzxyueec+4syxqOa3TWhiaQrtaNGYpqHt7fu9Q=;
 b=DrNNUgLWuEaKfP67zJ39tFhECZfJM5iuAiMFCBRftaeE1s3A6kR2PYQIakxYY85Vm8L8Fhbq4vufqvLEUyC/GB93lf/pSv0eAr7k+kHvLUT+6PkNPYHt7dgPDPoX4Y3NhoK+l9MzNN56OZeU67ob8HfQ4fnGXFzNpjN0Vvrdr8M=
Received: from SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::30)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 21:07:12 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::62) by SJ0P220CA0026.outlook.office365.com
 (2603:10b6:a03:41b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 25/30] drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:33 -0400
Message-ID: <20250625210638.422479-26-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9d1435-28b4-483d-c340-08ddb42c40b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yri54UWFwGa1l11mnnsZx+1ndZSjqzo3zpO0admaD4tje4Ml22OKnBsur3Wf?=
 =?us-ascii?Q?J0Q3KyEyMdX2vJNtjBmp1fyTQ54P0Zgn46YsI7OVzJm41MfxXInJYP0JADVi?=
 =?us-ascii?Q?cc3MG6/r78GyZdG+gjCyPQJ8u/fL/039p6GzB95zUtXsT6wYnx4FXI/sviO/?=
 =?us-ascii?Q?Zj/M3eTpAyz92rYcFEetAn1Mta7A6ZK1JqqkwaB6/cMCD2fgS1AN3omqUolq?=
 =?us-ascii?Q?cFZmMKC6a9YJjEkgjCFkCmHJtjyMv6k43loZMQBR2wsxotiI9HLB9l9TwOQP?=
 =?us-ascii?Q?v256gjQO50DJzlMqg4q7TQQGOYUqwr8hi/UobpakJqhKKA+DzfWvI6pdZYTi?=
 =?us-ascii?Q?+kEDMDgYhzN4GjfE0m4RaTI1tjeG5lfzdC+A1E1eyOT6x3SpGnxq7rDB2/NL?=
 =?us-ascii?Q?ZBTmCz5X0Ky1rF/Xj6o2McLbJsIxwAslz6wH+weJZsfklyuB4OQvSRv1RUnv?=
 =?us-ascii?Q?Jzwkxp9HtiwHczfj4hQHe8W7NEKAPE4lMa48N4WuJ6V5zMAoSLATEaeyZc9V?=
 =?us-ascii?Q?IiNP4RF82DOHaPAsqu8MqVju4z+upvMy0vHMrpQy4btEtybEZuXL3lOfkbNZ?=
 =?us-ascii?Q?vf5tU34uad2OrDnrXfdxC+P6Mn3HT65mtq1M9GIz/rpIfgtkNCF0TlMbvd7b?=
 =?us-ascii?Q?dDcNUG+dY696AE4u83b94hKBJymCZEXTHUwyQKggTjwteuwz3jvbhpDRYYkK?=
 =?us-ascii?Q?7bRL0T+V9wcW8zqhcO9Azw6GYy77ll1I4Bk1DGPmzYvdXenGRyuT8CO59DMS?=
 =?us-ascii?Q?6OMpnNDLHpWa4B2TLP1VeMR3lgHcLi8xATYeycY+uqPxA1aSWveYWeW43OEQ?=
 =?us-ascii?Q?PX09U5m9ndEDfpNlHVQohDV+o17V8Fr9h2NWpV/DsuaQm9be3LqwVdRMIEWc?=
 =?us-ascii?Q?mjNsGObAYc2/51c00j2FGsaIQ6HuBGUV88ociLSY5nm4H/TT3qEEHDOss07A?=
 =?us-ascii?Q?eVarCMfQ3DSlGmayAdAHpmXoh+xAu9sHTdyLo4g6JmAkW5kSSqjuk33HjxF1?=
 =?us-ascii?Q?8mGobAO/jMoeX7Ga7dnIsk3O7t9F51P5RhVIg2jUaqehBRNw57mVlznqNAIF?=
 =?us-ascii?Q?JMommF2x8p7AmI0Bnx2o3Le1Q3R3lYg94rJQTL1FXNK6WU13YeqgG5v611Zv?=
 =?us-ascii?Q?invb8kT4bUUTjkFonxSnzA+AazDb+71SpvTYMYq14+VwFijLSIa6LUoB2M6m?=
 =?us-ascii?Q?1pUxfDl20yOt29NWG2HaecM4SGqH+gDQCZfoz1sDWI6b+TQnaK3T3h2S+vjt?=
 =?us-ascii?Q?vgTxjyVclCRq6YTzvzEncMOnf6Lm9sGbzfZqGLk0pdKMZgsNxxyYGsKXsNd3?=
 =?us-ascii?Q?GrkZjlbuwPB/4hxOwG6skYaD4/Qp0gGB73H4RcZAAh7UwkLDj6UmTOAK86SU?=
 =?us-ascii?Q?xoinnBqR8hrFHwMbnksjKaX/bV0Hyu7u/IhKtUehWEhdVo1ZyPE6F8ZQPNed?=
 =?us-ascii?Q?0IJPXXaMGmlC4P6i3+a7UWPhEqbB1Mj3LcLdcAgHACDg+8tlC8GDtnW/6WdM?=
 =?us-ascii?Q?TnsLKgYqamJLX3zzl2vwjviijYtqRWMxcsN0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:11.2425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9d1435-28b4-483d-c340-08ddb42c40b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 7e37ddea63550..faf2df7ed3fd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1471,21 +1471,14 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
-- 
2.50.0

