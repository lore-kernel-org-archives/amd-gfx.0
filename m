Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2518AC71130
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C240110E1C1;
	Mon,  7 Jul 2025 19:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nG4i6SxW";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBAA10E518
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLYrdPaSpjGcukEUT93O3/pEM2DzIEgVp/UYqpZdXUzbqI4LdKaHy6SFu2nBCR5vxbna/aNwRNA4Lkuivh1hy0rBA1d/oeDQlxSdNZ50YDtQLj4EiaWJ/sJneDJfP8yMyCdXqV1aCC3Jh7OFiIZX//ST9mo6Ziiet/K/hqKdaKyiFDCiL9ZIpgEZiaD1myqemm7Na/sx+uK/I3q+ZtgCbtAS4+J3zJ5yqmAlGXQsAtOiMqP48olrxLLHCUDlCRV5gxx78EmGFNWfDhHXDEgibA4ioFmJ98QmaNDcPdQ13uNV8yjhy8PRPwUeqN7545m7niZJqo2C0c/A11w238sqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALY95A96GJexI+6D21k4I6B4iaRWRGJEGDG+QfEEEqs=;
 b=ggO+h6FuN08Rcm8nKoMMMOp3LixNIMAhpqeJfBxVo4W4ditQ7xn8ZsrFlBGXp1qpb5o0rBP6sQdCRKL9QZE/vJmuZXovgxBu8Zl8c/ZTlmd22F08RBkrXeEc1rwV9dOxy4Pg8FRebw9x7ODUEPUijLsuXdQ6wZEWMYIKKj9cYJ1yparvjBz2/Lfpheae6WXfjbvp7Q340vHkJM+mDwnMpi0GPUdYviN5HzYGIfBlzTNvbsnpC+4ObujK/C5/m/tB0Ilk8c5FQk5+fqKVjNKKEZ2xGZ4OF8wKGjieChiRZ1GONCE2AJD+i3njBgaSpAB/WKGMsB06j31OjjXyDXru8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALY95A96GJexI+6D21k4I6B4iaRWRGJEGDG+QfEEEqs=;
 b=nG4i6SxWsJ/ERorPJBfaVw8ILDk1RFrm0Qn49tq1FA/73w/aNUqir/R4DcShfSDtzAy0QmN14TGSWvRdsdOUoTyLoLQ4m8FuRZhF9ydge7mKcEeUjb/o60+C82XH+Kho9r/Fwj9kPhEma8Eh0XcZxUq7JpM91Y7T26B9PWNkQ3E=
Received: from PH8PR07CA0040.namprd07.prod.outlook.com (2603:10b6:510:2cf::26)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:04:14 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::22) by PH8PR07CA0040.outlook.office365.com
 (2603:10b6:510:2cf::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/36] drm/amdgpu: clean up sdma reset functions
Date: Mon, 7 Jul 2025 15:03:23 -0400
Message-ID: <20250707190355.837891-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc837b5-6afb-4564-fd87-08ddbd890fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?buICbqy3jLXUCPZ2fyv7Yg7bFjOUB3IqmYtswcPJupLR14sn1P25mCTkf7y9?=
 =?us-ascii?Q?hF+dYEkamoH+jHJ6qz1yCeihHNwChcoa7ncswOG8QQAL4mexuYY9QVpTIJ2n?=
 =?us-ascii?Q?a/HufmVSI/JtLr7zVFJSDWtUbG64yOQqlv95SO20XBe8c9smhUnYDtEfXCUA?=
 =?us-ascii?Q?oAPWLApvYKTN5TrpsdrvuAIw4kwKYiSN0JGSf8N54LozmAWYdjRn7dAlHu6K?=
 =?us-ascii?Q?x2mFXuTqJI2g4jgdvq6alX8veih7wNgzRqsiJRk49pJQMak1BDKze4p0a8nN?=
 =?us-ascii?Q?M2slEmakDgh3Vlxq1Vlw+nnZo4pzmMMXt5J53Slzd52xYtDy2HKwGXgmBH29?=
 =?us-ascii?Q?x1/VeQBK8wf7yZoz5l9vJtoaiAbgrgcpnpqOIz4xmHM+IJdQPVsVL1n9jyTh?=
 =?us-ascii?Q?by/UnBe1KkouBh9zgJoARbptbiq1p0BHWrZMQ8v0OVDx6nkK7j50iPt2c8sV?=
 =?us-ascii?Q?0U6QQkjQ70IzKSI8aqXIPzJr6EcMpBJk8QhhO/f8iiI//Ot/PINYMPaBnRGF?=
 =?us-ascii?Q?eYO4hjr1YlUeSuDqJWt4+7CcStPgO5SNkV/44QNlox7LrfIc6MmzHeb/7tV1?=
 =?us-ascii?Q?Q12TDaAVnQoZXySte39k4WiEGfF8n/JQOIRU8B+OJiVD/K8fZKcRg0txgn6B?=
 =?us-ascii?Q?Y690bF0fVzIUN2fKY2wY/pkOSfVBMPAk85BJpuBNCcK0TWzY4eweAMzbpeJS?=
 =?us-ascii?Q?90e0t5j3RxxUBChzFawG6ZSll4JqYxngtcR78cJtVtaujW8B3Mke6YKgvyCa?=
 =?us-ascii?Q?mQ516K/fhHFS/dqFYAB58fiRuwZF3GAYk9qFTwB5Uvv5n4juVlNRpcRxmXTB?=
 =?us-ascii?Q?I6Y5RlY3bIeRchhna/s65JaiDxmCyWxQs/455xbIwi3D8vpAEFYne6SeIJdH?=
 =?us-ascii?Q?q8spzW1CCMCVQfhyt5LK/qX1wucctTYE6sg8nMKphav+xVP45irErdGAk/yi?=
 =?us-ascii?Q?pjMwPIp8oajv+CbrKX21JNblBbXU7nQlZLO+jeUgXd+niYbot0+HIVoYK6Fg?=
 =?us-ascii?Q?Eve9ycMnpBji235DnwnplVtxDTvDftkiyL9UKp79f3hBMlekDf4ZuOxe3LWi?=
 =?us-ascii?Q?dx+er/1us0XPUzhAYAcUtVOFs/lrLJFF5wIZmxFHf8zWp4RDZTqcCT/owWNG?=
 =?us-ascii?Q?lQ1WKpKN/YEcQ6/DFXOej7gw4DqdFy7Qqt3KHJI/21bFwsW1/bZ8EkrUXchc?=
 =?us-ascii?Q?jS5aCfCGYrupZawX8cprK0nLze8SkG8ttLaAyXYvAiTiU48QZ5m/GnHz+9IV?=
 =?us-ascii?Q?oqZFO44tELgIxsMdS4eLAKp+Y/a8SmVDpAWHGyWi0jeg+LTGy7ZjRGjnkpIg?=
 =?us-ascii?Q?GNPVDLwejJKn9J6bQ3ilSJRBNT0kp9H9cV8+lm9K9qMVtin4D+cg11dh2Ip6?=
 =?us-ascii?Q?0KCSXV+88eXgQN8rF6DLeyJbg0M6h51YQJp64G4aHUduoQay5l4Dha5/tL6S?=
 =?us-ascii?Q?Tjj7O0inLlX+SF7M4qykOJs+fscCsOlKq/URltF4gVYpepS7EStXLI84hi2a?=
 =?us-ascii?Q?8/pwhYwTiJENvXFJHKCc8EtSXR1n27Inau0+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:12.8653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc837b5-6afb-4564-fd87-08ddbd890fc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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

Make them consistent and drop unneeded extra variables.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 11 +++++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 11 +++++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 13 ++++---------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 13 ++++---------
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 5a1098bdd8256..1d8ae5ef6e1c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1544,11 +1544,18 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_id = ring->me;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	if (ring->me >= adev->sdma.num_instances) {
+		dev_err(adev->dev, "sdma instance not found\n");
+		return -EINVAL;
+	}
+
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
 	amdgpu_amdkfd_resume(adev, true);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 6843c2c3d71f5..908ed8b849376 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1457,11 +1457,18 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_id = ring->me;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	if (ring->me >= adev->sdma.num_instances) {
+		dev_err(adev->dev, "sdma instance not found\n");
+		return -EINVAL;
+	}
+
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
 	amdgpu_amdkfd_resume(adev, true);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index d2effa5318176..99be92efb74c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1575,18 +1575,13 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring)
-			break;
-	}
-
-	if (i == adev->sdma.num_instances) {
-		DRM_ERROR("sdma instance not found\n");
+	if (ring->me >= adev->sdma.num_instances) {
+		dev_err(adev->dev, "sdma instance not found\n");
 		return -EINVAL;
 	}
 
@@ -1596,7 +1591,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v6_0_gfx_resume_instance(adev, ring->me, true);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 99a080bad2a3d..b79dc0a37667a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -807,18 +807,13 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring)
-			break;
-	}
-
-	if (i == adev->sdma.num_instances) {
-		DRM_ERROR("sdma instance not found\n");
+	if (ring->me >= adev->sdma.num_instances) {
+		dev_err(adev->dev, "sdma instance not found\n");
 		return -EINVAL;
 	}
 
@@ -828,7 +823,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v7_0_gfx_resume_instance(adev, ring->me, true);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
-- 
2.50.0

