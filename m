Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A77C71135
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE2B10EA5F;
	Fri, 13 Jun 2025 21:48:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S3HRMtB2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9620710EA6E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILbGo8R9nYyfHsRAlOCh3JI+PJLCHHmAO9UwC5UhSPnwVEhEz1w7qvMG2doC691CsVxKovfRjqLod/kTYWchx1ZehA2h32dXoDG8Uaqq7Kmg3jk0eiWyKj3RfbCJv9yanXyUQlELw1Mc8JbNi16X3qP6xNw5khirH+I5Nq39AAzXkpGr4d1WCIP3bGXxX1/+e5A3yQLEgbmGqwa6u8POcmFKPo+g6u5i6JySVDQYR4T3N4fq/PgqvEi7Gq2+BZupyRU/jM+Zz2XpZPNGU0tuFnYKqFj2/RCII3TZ3CKMg9GaKooCaRwiW1FiI6ehOrSL5GChMfVaadNTcoUBt7phVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr5NUfmTmyG5ckU+3zPuoxl0AvCZ/QKqtF+/JrunV0I=;
 b=tmiDaRWzmVXVa0+r93QV973Sdoun7UlazxIiThqz8m4Ys7F8qdMpdxErJ7bYCXY0FYUEHl8bQjFSNESSLGe7Z3FtmV8tcj/0cK6yznQbWh/8KmgLRwZQUaZ4I48hCqEPs+LKp2YWUk9LbYKG3xhRj+Sr40HGt4+ykZI103b11C1HLMU0x87YmqILWcb9c/I3qeBIYG5wlFkzUPIj84YqD7zLV9tmOb8aFrrdNEISH902rY29bjii4h4xquKm0CmT3O5g95sIQq00HV43BkoBSbdV/204Z1z7+HLcBPxBb7Y8/HCRqYl83/qnmcRoKuNYVuWFn4WnNTqelPfo30TfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kr5NUfmTmyG5ckU+3zPuoxl0AvCZ/QKqtF+/JrunV0I=;
 b=S3HRMtB2WRJizbczfEO9OWMLv+OXZDg0Mp0gL84BHrI2hlQxINbAHiODC5PynSSnhUAdRUmCG7a/rOElCDExHHo8dRwV7y4OaroWjQQ7110nPHuP6ecos3qTIVy52U0jZIKsB3yWX85N6gXTdvChosn6eVdmj6wqo20iW42DqCw=
Received: from CH3P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::32)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 13 Jun
 2025 21:48:16 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::d6) by CH3P221CA0006.outlook.office365.com
 (2603:10b6:610:1e7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Fri,
 13 Jun 2025 21:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/27] drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:44 -0400
Message-ID: <20250613214748.5889-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe0c53e-309f-4d4a-1574-08ddaac4012d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7U20OZM4rwgoeqggprSg6rdWKL7dB4Qn3A2EwY7Nf2LexHgSIB1Vl41QzYKW?=
 =?us-ascii?Q?tNJEa6GpRUy8pa1tWrkvvroAUE6Le8J1ZPlaof0Tni/c7S/gQyl6ebf9AKms?=
 =?us-ascii?Q?+yHx7xL1HvH9TTqfsZTfB98eIWGgS5s/Y0a2l6H1dLGqNarOQgUt2kyTEZ4n?=
 =?us-ascii?Q?MJ2JB47ay48M7BCfPc2McpOW26Cq0WTNP+eWZzJoMKvUDj6OnYqevCfJdIDj?=
 =?us-ascii?Q?uYqcF/cvmx07eeijpTsHiPo2sH4kDIwTzIgP3TV+eVxYDRbT5XMti+j6JYiK?=
 =?us-ascii?Q?PaaOzcGo7pmI4/PP/sUBAPfLkfeSXeLV6zUXbPC1tYBLSgS6taQPsP7caqru?=
 =?us-ascii?Q?XonpivnPhsFA7swfo9U4592YPUEcMlyO45Z4rzKRoYfh3IEein5iz8eHrR7Z?=
 =?us-ascii?Q?hyuxXc9y5q4Qya0nu6gJOh8DXYl8lk3RzKNllzvBfTP5896642FxbqyPpaIt?=
 =?us-ascii?Q?lusVa5mF+f2BIeWq5ZK1EywZM4mj0+c0gHR0x58Gv1IF3j6PlIgJCPqVf4Yc?=
 =?us-ascii?Q?pUh+5zbaQVjLM+qajRageLBEVnEhGqbbrzYYYHH+IDJ3i0VO4UehIHWBJyTE?=
 =?us-ascii?Q?KIp1HYoYpePGJaIReid+RCZ1bvke/m25+C81Sd6U3DVxPsmSDyNVuPBmz8xa?=
 =?us-ascii?Q?nhL2GOco5RE2anXH1qkMhw5zyxdTMqzOCsYHBsSwsRRWT3V5BGpW03prslXD?=
 =?us-ascii?Q?5sLosAOd5N4PIDof8ivuoVTBaemLWVeh+wVSYFnMQuSqrcl8ZyJTXzNWkSV1?=
 =?us-ascii?Q?YvEOHVyRlT6kylBzQQHvUlf4SYiV+ujrEw1QDiKX0Dty/iAmloe0bsXaNg+I?=
 =?us-ascii?Q?k9ou7SJfjkrVMDF2AVcy9whUg5ySWyfzo36fv5KfRNX/30j3PQBVb/j/mHbz?=
 =?us-ascii?Q?3Xhx0cjU+RFQesSBkYP2KKsDSeFmHm1Ya5PG0EK0hvZ871Mqn90qXJGz/9RL?=
 =?us-ascii?Q?4kTt/sZQyJUGFcadPjPhqNBDCFEcLcUaOoldNfgv6NbeBuNJz50LdKfAL9bL?=
 =?us-ascii?Q?U1953CsTLYnwyIu4rQneolH/xARFcPaOWpSKbay3GHA9kH9B4C0g4U8n4VEC?=
 =?us-ascii?Q?nots9g1hsPR2olS4sp2CBHHNARljguO5DJMyz9792gm0Rrt78afR5QUACF3A?=
 =?us-ascii?Q?nwUc39PNrScv0N6nfwCglkap5RTACsRzlI3HbDpdzGk6OuQwMMo0hbCqNHnm?=
 =?us-ascii?Q?PgEkRG6Q9aAThCrQbQVIUFuzbOEmASUakVswO6LS8bD2HTKhPMIP1irHGzAR?=
 =?us-ascii?Q?cJX6BUzUJTOmJablbGqu+3mSs584nn5so1qs1tox8zJfyOaxOECCBWNuDyGt?=
 =?us-ascii?Q?b8yL3xj7EVeif3amrRR+2VGzcRrq+xZIZFg2JmGGLlNahu8RER65HXstlc2O?=
 =?us-ascii?Q?wNRN8nlfhE6lBg7XGPLD08s0z3TrLo5d0PATC8jUW1974idwlVySjxFYi2sF?=
 =?us-ascii?Q?KHct01LBBHTd7GPJ8TDTrClY0jR34KsLgEHDv5oElZ9HoZQ7ipSD71Uqqiai?=
 =?us-ascii?Q?Xpo7lMZIWLxPjS5XOTPZT6xRsigc9nQqJUf+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:16.5966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe0c53e-309f-4d4a-1574-08ddaac4012d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index beca4d1e941b3..abdf0f9a5cd20 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -843,13 +843,21 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

