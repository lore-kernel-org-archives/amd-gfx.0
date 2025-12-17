Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCDFD65526
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 09:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FCC910E287;
	Wed, 17 Dec 2025 09:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NNK9SCtD";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0FAA10E287
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 09:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bM23PkQFhQcBSVkchZxQOClOElpwlBiLC6N8avc8lvWMfUg1sYWvIjP/KqhS/UfpQmDCGSqwywGMFKuYMrN47fw+wxc1HoyN4HyTduPV4ao2d5V6wM3qV5nCDL2BWx0QD33MIzkqwQYvsIppdED3hMNWXHcILWTrSEad8JA0ibtjjCzqyWhh6eSEJcJRuxN+4WcWEvomyGKM2CYQrcb44T3WUKaeIqpe7TWsf5Rne9VRIbCPtMkR45mxgpB1aBFNR54WqeMKiCSJyAGgM2SPC2LPzHoIiHNttbIi0RadnAY4TNbJv7oR81m3iXUxJj+sMmTxHkLaIDtW7UdpqFrOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebj/sQob2xtYTsLr1eRa1t93qdLhxy23ujr9GruLAOE=;
 b=G4i89uK0xi2202cYblYRuvQJBh8UbVqogdi0pj143jWHpJF4QFUZhsufp3fRga2E4VEBrLXOVPVFENqUcAJV29tQHCGDXI8tJ1+TawAeF0Vp1qqCQ6QP5GslOs7I2rtvbL6MNz56G+zbBFR+hFB+CheuSC6i/TzoxokMsNFyf30HYidER7ikMhvRch4VBlAx058bZxQDuIXKq6CPs0fsALg0Ab+WnDlp49VVe5G2TKDRQN2+UaC3N67mQWKPPy5p6RgEwxgroEkqhA1xIDTKO27GZ6W3X6HFLsYde/727nnC3QlJJ6H0o/IpEfan4BuK6KtBoay3NVNQYjdNbTVUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebj/sQob2xtYTsLr1eRa1t93qdLhxy23ujr9GruLAOE=;
 b=NNK9SCtDPamp6e66nRiX2jKRsDLmlyAmepw9nWlGRIFtbPymeL8OrbKgg5B6sqV04Qg0LZbLuEB4mKCB8B28LsFPau7VlGyNWwnavDdkE7Mb3Mg5MRQsT1wX6lFZhmJALE3Rt7iRRJ2msVLwFGinomalCVATbkFz0ciY1To9wRI=
Received: from PH7P220CA0101.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::17)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:58:28 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::f7) by PH7P220CA0101.outlook.office365.com
 (2603:10b6:510:32d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 09:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 09:58:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Dec 2025 03:58:24 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Philip Yang <Philip.Yang@amd.com>, Gang BA
 <Gang.Ba@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Fix signal_eviction_fence() bool return value
Date: Wed, 17 Dec 2025 15:28:11 +0530
Message-ID: <20251217095811.709295-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b0256c-d7ad-432d-1d77-08de3d52d36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kmgqKGSdVqLwwOABNj4rS4GktKK912st9tZ/vl7mVAKho3hnktoFtPQ6Pqeq?=
 =?us-ascii?Q?NQXkAt/5wNgqL3u/VPip8KosPra6cj0+b2NWhVTNvRHSxPAEEgi3uiUqeeOC?=
 =?us-ascii?Q?CdXXgcpOQyAQ2blWt2Z8UkPtWyNGtEw0Drfrbk870u4kmGeFw+NBHoYJwPbu?=
 =?us-ascii?Q?yRWVaJI91iasx+2i49DD2Nqz2tccG7TG9F2jQMt0mRIDuqIBmAOdShpTMTgH?=
 =?us-ascii?Q?6ropk4ICEJE8Y5BptLDfHTCfQnBxjNUBGJc45eJt4bHVVreiLQdfXRaE/RzC?=
 =?us-ascii?Q?KzQZeElDzq5gczLaZwGZCAWJ7gayOHV1O/Ec/C9wm4lqol60GbNWeJi93cMk?=
 =?us-ascii?Q?eVUu+TyrlwPOUHW9xZIfjMwt3e16AX47qm5BrV+4OsCtUsxIq+csb7LhUuR3?=
 =?us-ascii?Q?xOJ4QCkqdlc95hmcmmkK6noye2v8DhKc3HnZ9I+lOLfL4s3+aTEtqgpWp1f4?=
 =?us-ascii?Q?FoJVorlVieW8GTtDzhQSwZzIH/f1xkHWvVkz/hhTRzC1eghAbxa8MBv8NEB8?=
 =?us-ascii?Q?dXVxAoD22O1NvDrAtTmtu5qVlS/LH5vp6FqkslKt/xqskqrWGVII84gBb0Xj?=
 =?us-ascii?Q?/GyAivpCYTuOYe3ONCHFVeOc/oI2UX5DBA/arw88Pb5gT3YNzQNaycdgCEhC?=
 =?us-ascii?Q?AUCpquAq/i8N7dtK0L1DQjA9/WKt8/wHzTLDzOWtv3E/S3yK6M+C9cKLXhVJ?=
 =?us-ascii?Q?tIezM6gqSVOrP+v77wxLWYEBDnTTmY36Xul/D4osoBIFFIOLoAUj2fcsOzk5?=
 =?us-ascii?Q?2Up573mD4qP5qRQkImzcPQuJax9zBvaqZML61Md9rC05fC6QRBnMqnsHOAS2?=
 =?us-ascii?Q?aqpmt9GGvD3KUbTmIznAoOElTa7jjGxbs6MTQVOUdpACvos0Z3eFMrMU3UXx?=
 =?us-ascii?Q?FpqrN562rMBGV3YOjOESS7CbSdqu7xGQCYv4IitosKf6AVmYSjAieFC9ihq8?=
 =?us-ascii?Q?kXpu8kH/2+AwJYbzDbj7RiYmqrNS/npSg17U5ZPwXudxmcLAdzKVNAAmXjVX?=
 =?us-ascii?Q?bqwIPgn0MBB6kQ8rLLGnuMin9AcYNe5h4vgwI6PL0QZ1sDYAh74Ra5dMDHZg?=
 =?us-ascii?Q?bOhxA+Lw4c3VQonvZZ/KISYTRGEAtctqSwygQms0VJfMOJ8YhkCWl2Z+AJbx?=
 =?us-ascii?Q?sGz6Pj7vm/sWPJ0W4luxhCugPWYRxSfEeF3VgmOU2r6B2+lSAWKWMDK5CtYo?=
 =?us-ascii?Q?ZX2rJNp5am/cP//Ju0RqaCgkZuebun5Ngn/eXcxuMPGDipuKZoT26a/NoE+Q?=
 =?us-ascii?Q?NA6Jz6YfUVBoX+goh6oLVVtS0N+bbleAoNlIh/Kydw0iLvdgDeB8xROCTJj9?=
 =?us-ascii?Q?IjEx7qzXcKhJYz1ygMZ2tOfkY+Z7HoF1N7H2jrCfFy2H9Jlmqp4GTW1e7CAj?=
 =?us-ascii?Q?JGY24Lz5weqVx79D468lMkStQO9Fjn+x1iCnEobiNN+62v/EDTzwkbX3E99D?=
 =?us-ascii?Q?uytmgUe69cBkskmNwnzQMryH358PPql2lSn8FIvv2VgXF47eSwXzT1Z950gl?=
 =?us-ascii?Q?/VGaPnQ1OKtuidagwLZ0DPGEVFb11AIDmrR7YJSpD3rM+e6g08uKMzvIyX28?=
 =?us-ascii?Q?wlcWbueuJ5ooaC6LhO0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:58:27.6215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b0256c-d7ad-432d-1d77-08de3d52d36b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
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

signal_eviction_fence() is declared to return bool, but returns -EINVAL
when no eviction fence is present.  This makes the "no fence" path
evaluate to true and triggers a Smatch warning.

Return false when the fence pointer is NULL, and keep propagating the
result of dma_fence_check_and_signal().

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:2099 signal_eviction_fence()
warn: '(-22)' is not bool

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c
    2090 static bool signal_eviction_fence(struct kfd_process *p)
                ^^^^

    2091 {
    2092         struct dma_fence *ef;
    2093         bool ret;
    2094
    2095         rcu_read_lock();
    2096         ef = dma_fence_get_rcu_safe(&p->ef);
    2097         rcu_read_unlock();
    2098         if (!ef)
--> 2099                 return -EINVAL;

This should be either true or false.  Probably true because presumably it has been tested?

    2100
    2101         ret = dma_fence_check_and_signal(ef);
    2102         dma_fence_put(ef);
    2103
    2104         return ret;
    2105 }

Fixes: 37865e02e6cc ("drm/amdkfd: Fix eviction fence handling")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Gang BA <Gang.Ba@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 2a72dc95cc0f..3e7e91dd4316 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2097,7 +2097,7 @@ static int signal_eviction_fence(struct kfd_process *p)
 	ef = dma_fence_get_rcu_safe(&p->ef);
 	rcu_read_unlock();
 	if (!ef)
-		return -EINVAL;
+		return false;
 
 	ret = dma_fence_signal(ef);
 	dma_fence_put(ef);
-- 
2.34.1

