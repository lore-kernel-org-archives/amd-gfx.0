Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E272C35FF3
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 13:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9186310E150;
	Mon, 17 Mar 2025 13:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sfNZ08M2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83F310E13F
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 13:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7oaRa19TLZ5iiuy5dcFLGQ5oOT4jXIKhL9NtNW72h18o0NtsZEs7dkW00KXVybKU/PReS1GGmEQ0cDZPaX3xCvWsiKJR7DHoxi9nmYcm6VdYgp5sYNtKu13CyQYiVRxqncHnhxeQXQtPi0/5CBJHY7JsnJFE9LfdJr6IEcLdg2O0SeL4FYDx4PDYZn23CNNSYyTA3cGYUMB9HwaYWlIn+JPswuOKvZkwtnwXaxyHusy9IF6tK/AlYn4ksGIP/wqd36wXv9+4XMadUWqfcETzq8+Cj2frA+haKP9WFrUnIeHNzZPJAI/ml3k4Lc5FUq5CxyqK3Zu8WN13UcktoI0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VivRaek7KMCVx0lnZHp6tvaPMkP4OY0i1zkwCXiwo1E=;
 b=XX68R8cu6pRDTKJ7s0918COXkGEC2wqmq6oKLnNqoJ+Qp5n8ik84pMjF9mTuAubASsLAW5mhHXWKM7ujwwxhm9yQ6JdH/I61fCc1XubURvim/o2OSixZRg2aRxaL3FeWHyJy5qyzLdvDh0kIBG9XgfA/59t0Ny/vuBLcRu/wDrIuVEfopXsDtob1uzEQ8IAu2RX68wNDybb6UemaYS9kLjgqpbK4KI3zqBwvjpltMRaFrmZSlET1hV/UNcZOjgPYC0jmKXO86g2sh9m/RBSeEXsm1AkOW5FSuijdkNsJkUhQHz6OO5O35mCD8P3oN/Hmzcc3Hs/Efwwcr7Yeg7ZgMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VivRaek7KMCVx0lnZHp6tvaPMkP4OY0i1zkwCXiwo1E=;
 b=sfNZ08M2ZPDiEFsZwANETFQv9zGoRaYsIC0g+IAlP7c8+3+IaKz2laMRtx1ku1gkBkPFntGxXQjmJHxdoIJRvvWQ/QTPHKoNQV+3INWyNHoAVvLEPLCj11fClaahfbls7BjDPXWMXZjMPNfLuacipwKWbe5yXx3xgaGKwIYIXeI=
Received: from MN0P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::15)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:47:25 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::ca) by MN0P223CA0013.outlook.office365.com
 (2603:10b6:208:52b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Mon,
 17 Mar 2025 13:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 13:47:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 08:47:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/sdma: guilty tracking is per instance
Date: Mon, 17 Mar 2025 09:47:10 -0400
Message-ID: <20250317134710.764906-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317134710.764906-1-alexander.deucher@amd.com>
References: <20250317134710.764906-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: aa41f17f-cb8b-4073-026c-08dd655a4021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fK5ARjBIM2R+aBhle+QlCrLesGZMA9iN+sUAlELGf05IlPqfvF7Pd56sy/6g?=
 =?us-ascii?Q?h27xwLcWD6Z1bTPA3GM/oc4Qj8tjJuPbQsgQ7IJZBWRUsctt/OGjyaeVXaJK?=
 =?us-ascii?Q?2iP/05yd7BtNP+DAtciv27Xb7mDUbTLnJtW7YI11zKjMB2bCDJMEGCcPvIGE?=
 =?us-ascii?Q?CGbukNYj0PzxTrFIpBu9gLGn5ADL/zqzyLUN0y2yyihqncgLWCNPhrSbUaKT?=
 =?us-ascii?Q?wJfUYkamAakN4pDl84mtPOgy42ooedVYMSPh9V8lBdsoYaRpxG85SCt1H7HQ?=
 =?us-ascii?Q?nVknHAz/TfPzv5HmprYS6RKQu2XhM+1IuOkfbfVuFmN+wJ0ueaaeP3XGGsor?=
 =?us-ascii?Q?s+n1xX2GYVeC9Ljda+/DzpuZvRE0aBxq/3kooC2HPc0/T8jU7X243S3g3xJS?=
 =?us-ascii?Q?C/5FiAOM6X3IGErYt2xXGxnv5xX5GV8a5Q9PbwbXiFn5n4cCJr6HvmSk2+uY?=
 =?us-ascii?Q?HG+p0IpF/oPwc9w2uwej6Nvbs2vkNdgYLvnZetgTyT7MzAbTceLEOu8Lu+50?=
 =?us-ascii?Q?mJX5712yV47isDnk0znqRS2Gf+ZQPCe0yAZpR/nN1Jp3Qk68nt5Lm1c1h83A?=
 =?us-ascii?Q?VmPM0Vu6r7moDEMNxrvfbWMXUexJ2VyEL6WIUOh2ldQGuoZUq5rwFTiNv0TW?=
 =?us-ascii?Q?/Cd9zyxkZhE8clIoqNGJXtMWUFcP2tLPh1QAaLfzgQaoTXbV4tiEXgfsFEvt?=
 =?us-ascii?Q?tmi+c4NvFgPtHFerrrmG+W/hryzuO6GQiZccuMo92dGRHf5odJ8lIDDbzkNw?=
 =?us-ascii?Q?CYf88wCSKVlLxu6o3fbnNrNPR7WrTPq9LMOIS8/tjBrPHxzbdfVl24jKzGse?=
 =?us-ascii?Q?PNLibNPaIxv+pPg98I0zobwN43hiT5x63HFo/zhx0J1/h/k5ksS8JyK/C2RU?=
 =?us-ascii?Q?DelGpfpD9R098rFJ4cZVRTEQwSSmkrlOnvX9dX0WTFx3wtC1psTUBxJAemPp?=
 =?us-ascii?Q?3dZ919LBxW5o8T4YvnnKf/E+BOQbjwVzbinxg1JDf7pqoHxAV8Gd4man7q4I?=
 =?us-ascii?Q?XMYl0mTcJBJIC9me9m8k1YQikDofNIQRhaWOlirS+0IG2kSMSoWPYi8btHWf?=
 =?us-ascii?Q?unnOT1f9zNUI2lcgCsxnQEwwvzXfm6cXOoDtjRRTdzD2aDA09tRAeZrEI+95?=
 =?us-ascii?Q?FBmJEjIdSkEFmr0bB19GPoHRdH70ux8qagQ4w9sbPRtOx+8Dd0bky1tKXeCM?=
 =?us-ascii?Q?DRT/8pA8Ln8iOOyGSyA8vMq3AN1mqdJbRipj4T+GhWT4NaevhqUoY+k9AXxg?=
 =?us-ascii?Q?fybwQJ5XLK0rLmJy7dHEkpJa/Opn/hEVT+9RtpnBC+IkAUTGJXqPnmitgzEX?=
 =?us-ascii?Q?HnLLEfJ4ap/Rq0Kv65ZH2+gqvPwobFjKuB2jrcjvuvgf8BIHyauDMsrKqj+0?=
 =?us-ascii?Q?z8D0frJlS2EX1qHKOTGf8EhcaRVlMtSgd4JCtanCXW6bKNTIA3SmGz+ERbRF?=
 =?us-ascii?Q?Ab0EDfrnymUBs2r7fqXz3lO0nAeztSqtnf+tgHA+DvQh3N8CUgITWwkxlL6/?=
 =?us-ascii?Q?pSZiOmwUZKiOOYw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:47:25.3376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa41f17f-cb8b-4073-026c-08dd655a4021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
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

The gfx and page queues are per instance, so track them
per instance.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 18 +++++++++++-------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 8e7e794ff136f..dc1a81c2f9af7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -65,6 +65,10 @@ struct amdgpu_sdma_instance {
 	uint64_t		sdma_fw_gpu_addr;
 	uint32_t		*sdma_fw_ptr;
 	struct mutex		engine_reset_mutex;
+	/* track guilty state of GFX and PAGE queues */
+	bool			gfx_guilty;
+	bool			page_guilty;
+
 };
 
 enum amdgpu_sdma_ras_memory_id {
@@ -127,9 +131,6 @@ struct amdgpu_sdma {
 	uint32_t		*ip_dump;
 	uint32_t 		supported_reset;
 	struct list_head	reset_callback_list;
-	/* track guilty state of GFX and PAGE queues */
-	bool gfx_guilty;
-	bool page_guilty;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 927db7a080f0a..c485b582a20f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -989,9 +989,10 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		uint32_t temp;
 
 		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
-		sdma_v4_4_2_gfx_resume(adev, i, restore, adev->sdma.gfx_guilty);
+		sdma_v4_4_2_gfx_resume(adev, i, restore, adev->sdma.instance[i].gfx_guilty);
 		if (adev->sdma.has_page_queue)
-			sdma_v4_4_2_page_resume(adev, i, restore, adev->sdma.page_guilty);
+			sdma_v4_4_2_page_resume(adev, i, restore,
+						adev->sdma.instance[i].page_guilty);
 
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
@@ -1446,6 +1447,10 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
+		/* Initialize guilty flags for GFX and PAGE queues */
+		adev->sdma.instance[i].gfx_guilty = false;
+		adev->sdma.instance[i].page_guilty = false;
+
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
@@ -1507,9 +1512,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
-	/* Initialize guilty flags for GFX and PAGE queues */
-	adev->sdma.gfx_guilty = false;
-	adev->sdma.page_guilty = false;
 
 	return r;
 }
@@ -1686,9 +1688,11 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_
 		return -EINVAL;
 
 	/* Check if this queue is the guilty one */
-	adev->sdma.gfx_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
+	adev->sdma.instance[instance_id].gfx_guilty =
+		sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
 	if (adev->sdma.has_page_queue)
-		adev->sdma.page_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
+		adev->sdma.instance[instance_id].page_guilty =
+			sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
 
 	/* Cache the rptr before reset, after the reset,
 	* all of the registers will be reset to 0
-- 
2.48.1

