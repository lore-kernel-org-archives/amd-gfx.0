Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FE8C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C150A10E80B;
	Wed, 25 Jun 2025 21:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rGwCJ2pO";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6971610E7ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlK7fgZV9RAIeCfIC77hcB+yF5hFnTUPN2PrrRGy0VTqQOASVdr3uQHMmCc1WqYECt4KZ37yP3XKA7x4aT50BMcJ8v6GP1rjkVvsNq0JmJM+vTdUFEVLfbcDERubYCXMd9JIcOHdI3B/kJPvcUvOIcrtAgmm/Iqjh1Dxq6RifkmHAb1YbQlEYZccOnn6CVUrCV+P3zmChTyi9Vk14tpPlhrQV7wIbAfdVw76QiI7FR+RukiGXbYr42dg6UaPo3AQNPGQLhDSHoeR2waQ21kRpez43glmmCebCee/gI6L3aoqvT7mrq3s5OJWMmyp8XR3kkUjsOe+g07GN2pqByhvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAhM0ySDYabhnzhqULnzVBft71MZQIXo0UBgQ29KQlU=;
 b=XfHFtVFH3GVkvFUgb/+nKCVLOzad3BII70aycFcYeuHhvWlwFAXUZEU1zfaS8g61+XmI9fI/kcXZfCKL9nx0F7uX/qI6VkUAKmD+efNh6tB1xbnzT99ZYstkqgRnydGjqUNDqwurKDF5vaMwlUIOqXowFyh6gcnULtwNEy0JSob/hs/RrnsHnR4hUuLAXi6X1sA9oMvpIMFfu+qP7aWLhJxaRwxp7G87vq3hiTeZ9P0H7IDDKBCVYiNDHbiVAJHFjrVuSs61i+C4eUFpF1lnql034YE+S7mGI9bt24b7kQvRCahQDEYRv2jxuEDTBlYjC7wl4W8Og/8zIHt4V8Mr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAhM0ySDYabhnzhqULnzVBft71MZQIXo0UBgQ29KQlU=;
 b=rGwCJ2pOoVf90NatqOmP4mIj0qOlfej8UWrIOBLIffE4UNbkHrCZFJ5dSJCX45B5SsQZh9vP/9Z0h4w3QkPdiGeZqnnw+pEMAETkKOLdbMmfIQcBadT5SeZnln/bKwZw1M/M6Ly2f1rRUKtqYaAJ5BFuuYYIZSX/eq/QRecDX5M=
Received: from SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::6)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 25 Jun
 2025 21:07:09 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ef) by SJ0P220CA0030.outlook.office365.com
 (2603:10b6:a03:41b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 18/30] drm/amdgpu/jpeg4: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:26 -0400
Message-ID: <20250625210638.422479-19-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b4ea53-d9ee-4b03-d15f-08ddb42c3f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pNODW8Wfwk6cf8/EsL35G/eZ/mp7DmGAAAFxmStnLfdsGsxE505JUkxwmVgo?=
 =?us-ascii?Q?wXQhyDLSRrk7a40d28X+e1x8BOQeL4coX5NSfe1lLq7GkcJSSiThN8ELp/Nm?=
 =?us-ascii?Q?kpXt1HWk+1Sgfc6XMaPBMwmL0Un6Bi7IbDfnWXChYpvvW6PoJ5gST96i/ON5?=
 =?us-ascii?Q?NitvmYkkAzXgdKkS6kus5k5nfaVOVi2Mif+0eG2zDKD6G1gL+o1bVX75w4MA?=
 =?us-ascii?Q?kwTh9WjbWKpX4LycLpV3OMHW+xhmFzD+lPUDle/2Tz8HHCrcvtPZCU5sDVw/?=
 =?us-ascii?Q?Tuw+najAz8JtZCW3uiZiPd97Cvnts2dDhsuMyZ8/VU7lY2+ZxrONLk2Rmc0v?=
 =?us-ascii?Q?9kslgWtn4TiI0WcuJ1WPTqyf+7DXGg4K4KeIk6FdtXvwEageSwVbXy5Hr/9+?=
 =?us-ascii?Q?JRSRuopoAq1v+gI64K9XNxbbcz1pybiRgPyYDi6C5oSIwlKgc7lyY0u9pD14?=
 =?us-ascii?Q?sKWdpWEpo/O/Sb525V0uCAjIiDnEewoVYsgclrraAfd+6stR6U3WArCMfrGz?=
 =?us-ascii?Q?lRwmpfdkmW5iKV972zABhc6P3AojDYr4mGZURNIkAiOJJ6iUkTDUqIGFJ8Qo?=
 =?us-ascii?Q?RVDZkXg5603IuJoQjSiEXJtzWnyYex1IHAsfUqZTwQ/+g6Y6O2xVT0sIK0P9?=
 =?us-ascii?Q?AOTJWpUMHzn5Eh27bkC10wWwiLpghrX9hdcPer4vzIRjZQK8rGlXJnriyUQV?=
 =?us-ascii?Q?PUEE4QxkImtwW6aiHEMfhxu0IyY3h5Zr6f26wAEh6/aou24kBZtYPviKAMmu?=
 =?us-ascii?Q?+jhYvgI2nQ/bkMaQSUjc9dOEtzz08JhIYgNV4Lkr1xlcLoT1zGQY54dsUACp?=
 =?us-ascii?Q?KU2a3TqJYHKLkyEX87OXxPGxsG2DRJH9qIfcNRo4ibIptyxZhtcsmAm1YzuH?=
 =?us-ascii?Q?gRb0bVnyC4wtbDl1/+54WGvnhLJlAVDtxUvQFZqJA91JWVrFv1MtUQROakoh?=
 =?us-ascii?Q?kykZRc4EmsX1q/TBpp0r8He82YZGlC+TyLVr6/AQZ1EMQnS6LWwdzRd/aNOn?=
 =?us-ascii?Q?8fKpZFh+lPLmjT91P6Zq/Bfhch8SD6EnExIbpw1E6olSq/Ff4BcHFmaKS4Zg?=
 =?us-ascii?Q?HEC+Q70/7lWnMzIoSr7ZOTVpnFaAi4/SCJ/wrUElPRhhOr8jW9+EuqErCNHH?=
 =?us-ascii?Q?mKVnJc+Nyq9QTSR1hoFKbM/oMp60G0LAW10youAY42ADg8VEgekUCYYj4VJr?=
 =?us-ascii?Q?Raus0KIv+Kv5bzswT6xxZDdsyKx/XGTwi7WKPyDBFJKfEqgasQhLjPQMQuh2?=
 =?us-ascii?Q?bAlN8vyjWAn/+38jXY/hix227LwaescDHOuyVSj9WjQFL6tNZtrtirm0B/ul?=
 =?us-ascii?Q?M4O2o1D7fb++Ze7fzi/uvyt1ierN9D+oQ9dgHQ8FktMuoyEDu3PY7y5gDLQN?=
 =?us-ascii?Q?/1c75S+qFr03EhAFSp0r7d0WtdNTAX8QBG3yshvbSzcKlCiNYa8SunHGITFB?=
 =?us-ascii?Q?NMwcSQ9E8WM85BkZWZKCPOg6NIX/ldIwpnAILhCsfAWXBLbO03smPkOnM3sA?=
 =?us-ascii?Q?Tu/8u7e20dh1/lXuGPWx402ZFwA2kd1VqKpV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:09.2703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b4ea53-d9ee-4b03-d15f-08ddb42c3f89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4
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

