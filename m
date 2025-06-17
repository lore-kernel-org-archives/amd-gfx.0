Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3503AC761AE
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F3C10E492;
	Tue, 17 Jun 2025 03:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oJyM4hUr";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBEA10E48A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/du8j2FSIw652J9eITEWQwLevG47XejZI8uslXIXf2UA4sZOXLQ/BfeoqE6RlhMxfAcHKRjj2sk91R3PgFvbqpzwtg2v0b+qc6owix7k11/YF3U+gUfp+W0UHTjHOEI/E8kWy56vW1u5l9QZplYfso0p246/1m5MXelnHDg+b+5JIYo3hwy8FYJnoRe6kG225lLaREJjp5PoCB2kPC0v1mEujuTHheuZNzKaof43c+lYGPnvuXzRVPBWuGwWBN7ZmhGdZom3bhPbzDCyMbyk41DJQK2/39Sv7ze9qcqrFlcBK0vKL6kcmQaxUS7qM/X9CNHsGb8yG9R3+x6w3KowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eliEhjdc82cZtC5/Eg59DCDei2rMcD48Y6Db5u8xSUo=;
 b=VHDTa7y9tN0DGgq1JGFgQ1pbYGXsbIn0PqYO3HsucK3J1Fltz/bWJD0SyQACi1obTIWrQSpDyIYD1vHvyd48TGBmQqpwF1EsVLXwSFibG/UhTxEiMD5HVxUI97UO+nKGuYwJIGJpqFUg5HBmy0gcDnYVapv8aKA+LuLC+f3Bvpv1MmKy6kBWqd0odT9OQe2lfSs3W5LjrCHW14LvjhMqyFkE4VSvioKCnsfgU95YvqE7g2FDYQ+M72deh//ysoNAG+T1WJcTQmrqN4J/IKPplUQYgVo9jTextLANbXoHzatUv2DkNNugipgkPOk6mzEyTFXJRtrRRQ6JB9DHlXcNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eliEhjdc82cZtC5/Eg59DCDei2rMcD48Y6Db5u8xSUo=;
 b=oJyM4hUrSpbgP+5fPDtOueCySf6mj5MilQj9Q4/1QrUd6bZVxg3aMO+rq8mi0oWOA1ulamCqXEffweUicHSkqr8TP53W7t9tiZ+3I29S627P3WW1DGvm8/Hx2Vkf5DnneVSvJHROGP+OxVQGphQaAnTvllzdEKP+z17yqlD5wM8=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 03:08:46 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::20) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 17 Jun 2025 03:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/36] drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:08:01 -0400
Message-ID: <20250617030815.5785-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: b4aebedf-8a20-446d-295e-08ddad4c4658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LEtAcdqqq1LQ92GCRCDdcLJD9UhhkRzyh/jzywCOOYMiu0DP8/+GFJt2pJmg?=
 =?us-ascii?Q?W3btYte0wfvBN/o2kuIIQSzgQNtfHsHRjrB8/QpIL1HQxWUvKwGejcn/rjyX?=
 =?us-ascii?Q?pSVCkCLF4AZqufHKItl+74JFJld/lheJdwQ05b/YoIwv5sEIxDe3uVZSYCJd?=
 =?us-ascii?Q?Bzf6xVCVir0a1oHHPvbnI2ME1FBz7xjSoezANWbSqRsGsdo1jyAeqAlEU3vP?=
 =?us-ascii?Q?3F35DXhHUhczyONvdenmOIkNolJ9lYAt/PD89PWhqXmuOROZlSxPPTT0aH/x?=
 =?us-ascii?Q?MQY/EupX7djQd5WICgSZQrvCD2OuFYhCpCRBXrZdf7RFF14zXQI+D8suFJQz?=
 =?us-ascii?Q?PqujhrZMrh0taoor5QsWV6Lk1ofYgSUpxZlA+svB1RJ75MWq0quZYh/0Z48w?=
 =?us-ascii?Q?49zJVElIIdw1Na6q/gs6rwmkiPLW1qWDJlTsyfsfCGmro6nMwYi4VBybRRVA?=
 =?us-ascii?Q?jwBBYw4f0FUu+YKkCgwC0AuhYCDiTlEyW+lOZW78rLjekCqs9x/XIiBEA8rl?=
 =?us-ascii?Q?srHDsVkEkM0GvYo9uridM5sass5T+/YqdBptua8Les487XdRZvgEdWPBz8RL?=
 =?us-ascii?Q?gq+YJc9MVdkxOURPAwWONzxRBFbpytmj1NMF5ZkWYuhNSdxefsQFQ5t+neBp?=
 =?us-ascii?Q?tDi+iba06SsmsEIdln5w1vUIIx47lF1S2K4cW9roDNHMZa4eZjJRbP6Afwh6?=
 =?us-ascii?Q?IayP5w3dDYF0TiEhUqzQ0sHpUVxYJHcjTHLoqHPd1CvVwX2ZnlTYqZMaO4nC?=
 =?us-ascii?Q?JOx2GFNnoTMaxdbETd8Be37AhmVZy1PFkKisYgEZz0wpdhYgt46k+OkuTAMf?=
 =?us-ascii?Q?G8m2f5ISh+QHcrh2uGfPNRqYV0p7oWFFn9Cl9leg1eLnYPs1b5cgHXRf/D+p?=
 =?us-ascii?Q?qYI3zisJzM5iKQz2IFtR9bJwQ1uBB/mMWeNJ72h5MVAgc5ToOrKfLnJLtENS?=
 =?us-ascii?Q?7s26peLPNMZhB85BHhn5tVfmPe+FYb9YPHIAahPkTYrvi/0TPQ/UtjXBegc7?=
 =?us-ascii?Q?XwzekNuVLOKfLyD9bekRDVQ+Lgz3+hvRIDhV5MUnM/X5rH+kdI+XGzYlDadj?=
 =?us-ascii?Q?jfq1EUY9NpwihoDy6dzFGjOX4OuVbyO1bIYNYQtKbh33gssxAsnWY2Pqc9Fy?=
 =?us-ascii?Q?TS+1QwG6LYvZQW5dNEE1ruPNOxxyU0aupjOOxGP1+32ZIH4VyXfoZ2htO+PB?=
 =?us-ascii?Q?R9Lg9Op4zzemVfyi9wHmJD2Eb4LvSlcKzbw0ofl+llqUWF/VRkb/ERIuFOO/?=
 =?us-ascii?Q?jHJ2KVIezJgVl0YDtFp9HOvdsFXrVzU0nHXYDWy2MZ78B6PAM/LB80Foanww?=
 =?us-ascii?Q?HAE3jqHPuFBhBa/adOMhfbghGtdoKVux/ha4d14uVLI+g4mGQ7MsMecpkc7b?=
 =?us-ascii?Q?09IujsqqVtCVSrvrBQM92phk9evtgdIP/GBmKvUrWD9gHiJKew80qxqy7hDU?=
 =?us-ascii?Q?PUdIzhNk1go44tSXL3sruOk7EW+Nrcz3APHDkWrW9uXFVVSV7EQSQnDDJtWd?=
 =?us-ascii?Q?wRnxud2efPqix2K2cI5yxveqzsHk0Jpzqj2H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:46.4452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4aebedf-8a20-446d-295e-08ddad4c4658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index d8ab2a96d445e..b98d4536001dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -647,17 +647,10 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *guilty_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
-- 
2.49.0

