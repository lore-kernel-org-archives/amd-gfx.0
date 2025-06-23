Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8008C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC7B10E408;
	Mon, 23 Jun 2025 16:15:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HIpTGa+P";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7113B10E406
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2wbAJVToJ1LoVj+YQkbxGIhciZa4TV1hC5XhJvSidrDc7Usw2SZyFpemwkQa5GDAlJmfCppCDTMBwabv9UijyzvxWbpINv5Pbq99/tDTB8/LSDsVQhpCAW06NM2HAo4RpqxocNO3KAE8MbpBwvLEuJP8uGyKFmJzfvaTcyXIfKishYLEjV4NyI4AEPWsZ2EPZD63C7xoz6zYac7oH9S7rLn1jCCC2QNAFafKakAnNXto8CSmzIzExXEomw5IuUYpoOd+kMaEHFmxV4uD6mfxvMYp6gv+CMEnmPFXQaLpNb2BoWTdu3WvZG6mQwTBZp8yV7PkDLIo13rZ8I/ZJigTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QFXT/w8WFmqjM4WshemrGG+629ZpbQ5wnrJSCfnEPo=;
 b=f+yNSJMHAOGxkhJVQc87adcN31STURHIo83FwD3kybBLbKr7ZhZjrT1wHG8rpQx/5o+z9GzcvSOiXpPXXqriVvF8CRAlZv+JNxJIWHVTKiSd+kvzRzaFA7v0ylK1KuV+gjudUrUkvL7DDpYXwSlbaKu9f0nPTu4c9yDixrkxrL+JoHd3BOQZO5Jbeo5CN7p0JkfrWELWzvsmNHTN2sa0PlWTupmUV6Hz3/FpZVzk6K9BXVZORbFSezcaIzU250InGVsIHdC2gz4J1/C19/asljZ4xNDVQKLTXVQKE1OgYogL89i9FmwUx+RbRf7VJLmjEuTHW4to/YY9T6HgK4UVjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QFXT/w8WFmqjM4WshemrGG+629ZpbQ5wnrJSCfnEPo=;
 b=HIpTGa+Po0SOq10fabW8NueBEl4dhG/OFsuVUkNvEypTJdg9ZHZBaiGucm7B4rO3UaR3c18T0KnB3Ww0D9gnFkteEkNR2Afl/7UVL3XsvLcI/hyiyv7qNsRpIW4abXf7lsMtOSNpvJqhQFLI71R4/1jXyXqxd5KUJ8wCnQivdq0=
Received: from BN9PR03CA0064.namprd03.prod.outlook.com (2603:10b6:408:fc::9)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 16:15:09 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::b9) by BN9PR03CA0064.outlook.office365.com
 (2603:10b6:408:fc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 16:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 18/31] drm/amdgpu/jpeg3: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:24 -0400
Message-ID: <20250623161438.124020-19-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 99558378-284d-4bbe-d961-08ddb2711f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mRJl0pmyMV1F2L5bL6qXJIIsyAE8frz5lbY9xTjerBgQL+8e7J2BmdTKXHio?=
 =?us-ascii?Q?ENVVmtucGV4gSHmKxIG7AEdG2ED2xxXliYotGAfzHKIXko5QR+5/l36HTLjC?=
 =?us-ascii?Q?VZljq2EC+q3QiXXO8oUzRoylEBqMKFDEGU6hfwqLJj/wqV1FvXhy8S072+SR?=
 =?us-ascii?Q?sBaQGknH2zIEEUCRx34MKpB5HbV69RscJBq6mTLB+tCOOIbMD4IVBvVJpmjj?=
 =?us-ascii?Q?ha0qt9m7wzCz42evkLrQmQh53dI3Y9I/hU/InFdCMJl7VXTEW4fF26+N330l?=
 =?us-ascii?Q?5Q/Isg/xdw2ST41f7udlwk9XP2FOt+XziLohPxuHaRZ5Q+wJ0h9dI0c8LKed?=
 =?us-ascii?Q?3A+gyydLiNnIFr8hkuwVLT/8YiNoOVkbEtfLcmX4qW1Wpwh8G6UoqpkNVLTC?=
 =?us-ascii?Q?mzd0uhFH+aMbRI6mTtRPoYML4utRHpfkZGyyzLXlLccVADOLTs6DHnRVBlto?=
 =?us-ascii?Q?rvPtqxmAovhs3E75N3y+6syN6Vxt7pQVKcgl5Hmmq5LBF2dz1E45IBXIEeO2?=
 =?us-ascii?Q?0Ah0Q9J0x68hsA7vC/ucEYkpgyXkqai46vuQJdtL9G8acZ0M5IzwE4t6a/iV?=
 =?us-ascii?Q?13krP4cA4MyNfqp5+NxE+XPQV3FvHt0Wq7fTR9yQt/Begob/yJYVcX3tTaQJ?=
 =?us-ascii?Q?sV/ZJhBk32TnAmtsoLNjF19i+QuLcOdkR4doIOaRlrG0CZ5pXGK7OTproBUF?=
 =?us-ascii?Q?ba4gnutFWxOCOMll332KfxycOk5O8aLVjIoD2TCCzhIY4XXwheowesDFzWGV?=
 =?us-ascii?Q?DpO+TSsieyOH7ZLJuXjcXbdXFau+uAomVD0cXhSqSgIEtN/kI3WOhMmHRRpl?=
 =?us-ascii?Q?STRHUZdY9Lv63IJSubRXPSIzb4bmtp/jCjDWIDkA/Cc0+7K7RSBbvdptz0eU?=
 =?us-ascii?Q?5ZI3+RYudZpsijS1GV8FLF33uUlR9AwxO8Am5xcJbgCFoTmyAioXNaOuWpye?=
 =?us-ascii?Q?kadmxm0eiHGBqadkQk2Ow2YX9IBoT+EGMTftdbbFA4+0aXU/zvwOrrCs/ZnV?=
 =?us-ascii?Q?QlKnBOSWwr2dt7rA0HMrlm5rD0nsRcKu7h6PzbbJz4nKVPW6wjGu+bRurKcT?=
 =?us-ascii?Q?AE9JwDnTVgGyEaydokrAyANZEcpYG79ZMagVKcmkyqxwUJIE1VDw2nV2RM/G?=
 =?us-ascii?Q?koXZSsuK5FoiWX3i/pBW4Ysb2a75GrANsSHieaz93xjhUBo406zA4vKvVCy3?=
 =?us-ascii?Q?OmEe60nmM8IqpTrw+wIKuyGbws61l6pufn+tpxbTjd3dpqJI5ftSA0oUkLwP?=
 =?us-ascii?Q?pYQihKrxFMy0JBqPkEOggxMjnG0Di+iN2OJ46VJLQIPpoULY5aRRAE6qaCRE?=
 =?us-ascii?Q?Su5b8U66zGZJbRh8WKxQ36ZI3byB/VfzweZfy57vb6bMjz7OgtMBfBEXTADT?=
 =?us-ascii?Q?EvQF5ABFa+Vy0gT/xNDhbowEBvHOjeiYUcmOkKcPoe/6hFrhsDvTsfD01x67?=
 =?us-ascii?Q?xWYZt3C8gm4pMV5pQUS4GnwC/0D+Z62tvY3efiPpkzTfS8tAwYreD/9GegpG?=
 =?us-ascii?Q?iZiT3G8tfEzMTgpdK+Ir5G65IPoM3uRgvtD6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:08.5436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99558378-284d-4bbe-d961-08ddb2711f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a24bd833d6442..5598fa40764a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -559,17 +559,10 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
-- 
2.49.0

