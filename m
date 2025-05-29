Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB0AC5B558
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DF610E783;
	Thu, 29 May 2025 20:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fCjXsKGp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4A610E76C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIHVH3HqLCG/d07RoZWD5LcJSWR2NkFscP5FiDm2SGBaxslVuWIygFw4UV9iXIeUH97oDCKO32vgqLdVmgGSBMvsmOE+Ecfd5L3O8ghaIkDJDThJFqoQtsfmQsXIAn7e3Xgd0ngZCRzG5WmiP+J9nuzzgpeeE7fAtCoz35z2xXwPvI9tV/IkeGhiFTXXDsnnUZNPAXcBPGlhX8GxVPkkWP1wCA54jch+0cJn/ubqD/p6Hb8tVwFkXeKorgk357Avi1DVQtaf2Ia+Sp11wWDkJAPwQzTotaK/i52mjwy80Bf4YFJI5x67svY7UmPy/0eucWYOPS+1uXthyz1c6iM82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGdhYf7eCMSbNA8fMTB/ck3ptbj0AmhDfrM14R3QUI8=;
 b=VHVFQmtB7ucysUdPvXHiC8O4Jln6No6wt3qjiZ8hm0UO4DO4mIGOUXa46Qm8Unn0nDEeuHyx6w5j9EmyiMJbFBxBimTNgGxMVeOxmfqiarQIWcy3aWHCSriL5oaQlBACAJH8I57/ITRs7sxYVAJUEamSgcCbfFwnjGkB21AUkFOh7FzZob1TXcXQV3VBkofmpGonbv0+xymPwCLRdSIOyDCJqFhxpKVHlLowyHvjPFfSWaK46XFLPMLOHf/a0KKQggnRN3wzU6tGqqyH/uZb9x6y0OHO2WtJ2w44SWLNjz5gGFr8isiPckF+or4jTquawshhF8XfstnYXu1jfXfj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGdhYf7eCMSbNA8fMTB/ck3ptbj0AmhDfrM14R3QUI8=;
 b=fCjXsKGpIPw+zwj8+Fw/21nA8suIfbc3V19vQjFQNOR5DNV+eXNN3dHOQP+nP98FnYmUY7J6onnDd6xPdSRu116sBugL36wIKw4LPv6YYtFTbFIqlwAJu1b2QC1OUNiSvEYbMPcdHQg/7xAGPabSBfWMNr3O+zGQgUlVr1YQMXg=
Received: from MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::29)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 20:08:32 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::fb) by MW4P220CA0024.outlook.office365.com
 (2603:10b6:303:115::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Thu,
 29 May 2025 20:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/28] drm/amdgpu/jpeg4: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:50 -0400
Message-ID: <20250529200758.6326-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0e59ac-700b-4603-bda9-08dd9eec95d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mOeuO07zGmYX8sJeQdetouSzB82V3K/+t13ZO/1AjrbokQUQUKJtuGYAHnQs?=
 =?us-ascii?Q?S46ShbtPdm9zZu+Iz3ZjoN8bSFuUQQ9JUZUecfvMzjepNUw58q39VgTkGIVe?=
 =?us-ascii?Q?r4xHjrpD/CTKj8E37LtPJICL/aimTQPUZULhhVyKGg0IqyunTXVPp2cINx2+?=
 =?us-ascii?Q?JMgfAan8roY/9leyhukLZsyWFVW2L/kX+DYyNt9gfwnMEgkiC+H3bOr/GKPY?=
 =?us-ascii?Q?mTv1LEiL4/InXUO0UQMB2bwWZdDVDy/FquDGTqVi8KsUZ+Nh9eUuMt4eRxPQ?=
 =?us-ascii?Q?QOLVIOxK+aYGwTckT19BeHGzA2AUn6ewfz5U8U5Jlq/kbl0j2HaTJ4fXGjKA?=
 =?us-ascii?Q?z8yj+fesRg1NIYTmVxf9vLhcWfn7i51cIujJbWUupvrFTMtTPX+eWQNMrVD5?=
 =?us-ascii?Q?rhDMhIm7JdzdnWTVqTeL/YLla4SEk6s28+lmQ91HNSfYUETc6BW171gjS6qZ?=
 =?us-ascii?Q?ygXA6UXDS9pGtd6ka5hYQ7c1jFl7Kj4+9b4vpOWK+0JviFpTWHCWiKlAxQnm?=
 =?us-ascii?Q?7i6ahuir6WqyvSbJgb7IxyTI/ZkKhm4TTfYVpMOelaBZVZyJr1iUH8KWCOgb?=
 =?us-ascii?Q?pcK+ekyebzvexDfLFQX60EWfMdypMv8f4xdITmMVxEHLhgIT1aIYLxmq+cw3?=
 =?us-ascii?Q?eLfWKPY2+e0fCh2EygzRd6+csWk97uARLT5k5EAgVLEugHAqkOWPS+tqKMOW?=
 =?us-ascii?Q?eoEswYcCLyJIGvzGJjcl2ZQZu0aNIO9ZsuLm7PgKM1l0bUA2HP4Z2QIVyQGx?=
 =?us-ascii?Q?aey5yHAtChiUpNnnbuhfgVf3TXot0eni+BYxtdQhSoXNpiycvPkY2ivO9Cda?=
 =?us-ascii?Q?y1oZvwfDTsZx8jv8XDb3MBEnMsqi6wa1R5AwhkNKJl2AQxPH+4TWVCyzOg1L?=
 =?us-ascii?Q?VkhatefpY++sDpvHs3bUQ/4XLQAMYsLLYpo+nSbqfMXck3WJNCt2C/4XENHj?=
 =?us-ascii?Q?gQFLIbHJQ6nQFPy3EBGRWDVm4aczrbNDe8lL0dbdj8g39JYcCJdou6QcgEvp?=
 =?us-ascii?Q?1kF6/Ra/xfFNOpszcO+Yug3LoHRGI4UrtSKkKBB84aaqEvnFWdASoQ55qcYw?=
 =?us-ascii?Q?n6FqM3m2HTw6XM/RctsvkNFcPdCyRUY8SORqrE55amQobvkU0QgM3fOfBJsP?=
 =?us-ascii?Q?11AnLkn8qiXrF7Oo5265N1NABgRJUEz1IE1sbt5FEQuYSd6bOBJTQBwQu//x?=
 =?us-ascii?Q?RGrD0l9XD9861Af2KZgurQN2oHVoq83DoaU5iUUTGavRc6v5MN0FQL0UQPhW?=
 =?us-ascii?Q?+GWjjUti0jnkdt9PsJ5eiG/t/ILwaga+Y3ua1FmlVSk8wwX6wg1/3d4b/Dez?=
 =?us-ascii?Q?zQ+ZgfA7L+hBLOS/gnCMvgx6cuyxyE9KRw+zriPaQ6YyEqpIy9g9nKcWG6wT?=
 =?us-ascii?Q?rzXQ5JMbSdUJcHs1+bWtl/sZr5fbUr/Ox0UC4Kv+KjVrVuGfl3Xymf1A+drR?=
 =?us-ascii?Q?AWBKRwNNIb1Bexch33lGlqTLglqUi6qPXF8ZmDmxrHW4b7t2VuCR+BjAX6CW?=
 =?us-ascii?Q?C+NdIcosDx9U+pJmplscW+qpk8TvvfAnZ3eb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:31.8683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0e59ac-700b-4603-bda9-08dd9eec95d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 9301d0ff2593b..4e644b645bd25 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -727,8 +727,8 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
-- 
2.49.0

