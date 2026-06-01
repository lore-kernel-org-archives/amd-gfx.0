Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5536ACD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC47A112DCD;
	Mon,  1 Jun 2026 05:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rbbAp5WJ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54BF0112DCD
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhRttxg6VOaHQhOlJPnWA9wtqDY5exJfxRHif6nL7iHZPQX1UukfYEHawTdclSikJ6WQNIdpiWuCj74oVx+VJiZl4ssB+CUAMt1By6n70lvmD+bcMrNsC5D/Sl+ZPrIiM0RX4UTdyBoiPvSt5RgZK9E10jEDmp9pt92HV5ZOfsOa6utj8oKbQJ4wQM9eodLufsXWGQAnsdczCZqHknmGBhYY+9gqWNVLrvZTVguKYMvtGoWz+F/Ezh3ULUQfDV1NBRC04CVzorKsAheiF+XRM1hRIcujad9hAo22DA7STYTVO7q9uTPNNOijKAQlZwYi0olpsJ/ZplLoGUhBb2AzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1adUdeNHeLo61X6RNd9VW8dWcGHXqSydHDF1DSjbWY=;
 b=IWhsqvB3Hj7zngOezShP5pSwrnIOswOVYDLZaE17Mu5/me6eA6z51HfnWcSEJ3dRN9llx2os5XpS4J5psG9JJjwMCYTHFasJQ+l3sCfsto3djeF581oofFHED8WQdAel6cZiZrfv+etQq3tFxv8QQDmbTj2TYvqxHClc5IJOD4D7vsnVNWWf4ATvA72cjqMYsMuu0+vWn7CPdZ4RyWEMiWgogGLkyxOZJY63SCGvQpamD9nu6K0qO8maJOLgiaCpz59nCxBrHCyJc0sJ3QAS3LVyD/qFOWNxqeHHPQF4KnJ0UpZKl0mWZ2EhChxk5Bn7FRoi9wLvV0gUg3jPC3C51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1adUdeNHeLo61X6RNd9VW8dWcGHXqSydHDF1DSjbWY=;
 b=rbbAp5WJih8ajFdH/lxOsldJdiHJO5eX5DT8bp1JkMsvoK70t5G2K28Q5IpJBZld7k5zp7cRug3bco4imfHa2v8bwbBPalrEIIUS2AivecGApQ5T2wNZqqxzr9VpuRykS5yc8M3Dx7dIS2HAus+Hn8iilRikjnpUIlzR9mk/wDI=
Received: from BN9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::32)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 05:53:26 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::83) by BN9P223CA0027.outlook.office365.com
 (2603:10b6:408:10b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Mon, 1
 Jun 2026 05:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:53:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:53:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 31 May
 2026 22:53:25 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:53:19 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 22/42] drm/amdgpu/userq: switch to per queue reset
Date: Mon, 1 Jun 2026 13:49:08 +0800
Message-ID: <20260601055034.3700921-22-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d8d70b-1236-4d1f-1ab9-08debfa21949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: UvjsJof8sLfMX8U/QRbICYbcl4+yZuLOUyLyqKWQlVwEJJZ1A2RKK1g/+2b/5NB+/6h3i/5/R+8w/V5xAy+bKdBU3Q6Dkrw6HWjEoQSkPQ8ahmCyy7BVIt3oxL7G1TOpNstZagyy+zmrybkIW8TgL3i/kJleao7Xygg9obQ6GTUJPxCfa7PHg1+E8NNpU8/DK7D0DIiOlbXdwKbVvVHrtvKjz1ddMiisuW93glNYg4L1/jy1tAIytXpWpTmPLgRRFhZKsPv1JMlzIYoZnmnfX2aD54esU5vejJIp6B1mhz4eaAVXSCX48lkbXUTnHJ0vskxvtWJjNdhFlAfUCdP1Ouoc6qDq6PkFy71HuPaPSpOASp+DllFDgdyxW60dD+dhhv2OepulJikDNIx+rIKA7o9TA/l7uPinnjwrJ7bLEZH1Zn/bj15zdqqIuQQBAG7gHpX0TJuZyLIVryUh93Mle1Oz89fvRDqGEYMRKmN6KQsraQocF1WCNWEsBgW+lRsPsxsvLoQ1FdemTXV4wda6/4LPWlSo/TW/fYztWI1TCPHneIxE/NF1m5yjv+lG4ylM1u89jIhwOG+k48ma/OkYgUNdNKM0yPr1PMuy8xmbjrMm2dbbxVqmgnS83xetcYZ1KCVJjU51hZSrmUmTW1+84Tnkph9wU0rdUkPR039s/5w/YfFTE5vk99lhSLhfdUxIW71Y/P3/1muJZIrWEKwjLSr+oVJTnyB7JdnWulXMVU0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W1vYS1hmPCob2c+Gv8ti5D53nbu8+6BJg8PVjYFOB9HSc0XFLxt0FzltDU4PdvgFEQ4Gs1WL1MQBFLOMTyHoSFpAhpdw3RlXl3BlNgZy18Z1PL/GwT6TwtIY2jCrjyARKruEN5EQU1C65IcTVyAKJ3Yb+NQiiyiBK38/xZsKhVlbJRqwIS3eHl64XsMBPmW6ayQnNyVxnDB3Af7bRYTB8fCkt9itJDsMg935zfoBKByfCfWqfjzw8WE+v41RFJars8OpLia2JXBFYu3850AECMmnCa1yMZbz03MU1GDX0Td7Ad0TgJxyDNtYDnf+PkAENJeFIddZdby2qYb3VPwEqCiXd6nizZDXR/wsSimDyneM5Uf5RcyhpSoZwWZb3Rsbk5c220HTv2OLm82lYNMNINRDtXsm4LfiJ+MEpN0ZFXy9SgjiPVIwvZtsc9SXmVb5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:53:26.2620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d8d70b-1236-4d1f-1ab9-08debfa21949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987
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

From: Alex Deucher <alexander.deucher@amd.com>

Switch to using the per queue reset rather than
the detect and reset interface.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 38 ++++++-----------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7a09e3091232..0c9d370341a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -120,14 +120,9 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 			     hang_detect_work.work);
 	struct amdgpu_userq_mgr *uq_mgr =queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
-	const int queue_types[] = {
-		AMDGPU_RING_TYPE_COMPUTE,
-		AMDGPU_RING_TYPE_GFX,
-		AMDGPU_RING_TYPE_SDMA
-	};
-	const int num_queue_types = ARRAY_SIZE(queue_types);
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
 	bool gpu_reset = false;
-	int i, r;
 
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
 		dev_err(adev->dev, "userq reset disabled by debug mask\n");
@@ -141,28 +136,15 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	if (!amdgpu_gpu_recovery)
 		return;
 
-	/*
-	 * Iterate through all queue types to detect and reset problematic queues
-	 * Process each queue type in the defined order
-	 */
-	for (i = 0; i < num_queue_types; i++) {
-		int ring_type = queue_types[i];
-		const struct amdgpu_userq_funcs *funcs =
-			adev->userq_funcs[ring_type];
-
-		if (!amdgpu_userq_is_reset_type_supported(adev, ring_type,
-							  AMDGPU_RESET_TYPE_PER_QUEUE))
-				continue;
-
-		if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
-		    funcs && funcs->detect_and_reset) {
-			r = funcs->detect_and_reset(adev, ring_type);
-			if (r) {
-				gpu_reset = true;
-				break;
-			}
-		}
+	if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
+						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
+		int r = userq_funcs->reset(queue);
+		if (r)
+			gpu_reset = true;
+	} else {
+		gpu_reset = true;
 	}
+
 	/*
 	 * Don't schedule the work here! Scheduling or queue work from one reset
 	 * handler to another is illegal if you don't take extra precautions!
-- 
2.49.0

