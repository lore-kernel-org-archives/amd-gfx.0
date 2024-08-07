Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578BBC52D7B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 09:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1EE410E4AC;
	Wed,  7 Aug 2024 09:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BFC4ucsY";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D9F10E4BA
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 09:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tW8My0uAVTTgkYwc/hYDJLObsk1o52dJOiuD//8QINLm9Vt8p/Y5s55rDyYT3xA41CyVz98s5BWSqMo6/5t5Jk5j2vAcAwEXIvBmFuLB8ramA9S3nVZuwecPyixz0vOD/i4AJT//e7tGZqvuxgCBSGHijbDzFucwM7RwOLOXXSAAhrqungayee3KIjiTVqn4J5z/BcQYi6CZ/ryGiSftAvTsPigyf1sCLOZ7BYL13B29rGCUaoVnBCVpDYIZ7mIX0PgJ8brTiD+QwFu9zVbASJaK7SERezCPcr2m3uQJkkvEBFhuUUsEuTPdQorQB8aX8lU15PI+By/iLeNMRPrPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgDr6/O/enzZS3pRNHLfpRN/EkLDYuu3ZCkXCFCAVOU=;
 b=CkMdpY9hTjupsnoZyiqyM4/Y7pmtEqxn86fr0zqX4OXDuCjjK9SjyG1BcCoTPBH3MhIjIuZhh1LO8LzcxkoK2lDMF9ApYH5EVRZuXD1vVTbVWoy2Yf19gOZ5DRDLorHab1suj0N7Yin3SLB09d381TLHoBdZlJlezrrW3/+AWsBPfUWxKKubgaf+GiKogpRwizxAZt9QaPbbOZ/MsGUkOnK8/4CYxeSpW8DhSIOf8BERv7SImZsUab+TYJpZ4JLcEbutH9QiWN8axhtOu9W1/8py42c7eiaMCLFzFTIsRWm8EV+hmPI30/APoo5kzMKJQ/DIou+0wckc1G/xFF9XCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgDr6/O/enzZS3pRNHLfpRN/EkLDYuu3ZCkXCFCAVOU=;
 b=BFC4ucsY6Si8iS4PlTbko1cS6nxIHUIJnho9c6dXaWB3MoMLJnYdKb6bzYiDtEPCsJYTefW7JmwrUXMY31QXGM06+m24hgcH2OtdMGexh3jAz7qrWcJ3jyk47deAHWGLRzT+zwfqAwFYgXTLiRyEG/Kv0OjRWd17x0PCHhzCba4=
Received: from CH0PR03CA0251.namprd03.prod.outlook.com (2603:10b6:610:e5::16)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Wed, 7 Aug
 2024 09:39:21 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::2f) by CH0PR03CA0251.outlook.office365.com
 (2603:10b6:610:e5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 09:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 09:39:20 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 04:39:19 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 8/8] drm/amdgpu/mes12: fix suspend issue
Date: Wed, 7 Aug 2024 17:38:47 +0800
Message-ID: <20240807093847.2084710-9-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240807093847.2084710-1-Jack.Xiao@amd.com>
References: <20240807093847.2084710-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: bead7575-90f2-4858-d6b4-08dcb6c4d09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?46RS7sNZZMsxrhF/SUlz9zTnBS9jY1IoxhWsMQBf5rRBZfLOcNAJz3pekbWV?=
 =?us-ascii?Q?A8LF0Fhznxq2X+tOMmQSsnOx8e1wRJToUz/tz7FfC7yr8q7FB9FndTqpooLI?=
 =?us-ascii?Q?DS+moL8aYwJO8XYY/xqqcY/zD6UKEjnmkvwGCr0/KlRPGFq7elyUpDxAyOFI?=
 =?us-ascii?Q?qB3/i0rKvZoIX+o+9qdlkr3bniEFCVu68aecaJ1LpbmybzjeiH8T1zBqQr5y?=
 =?us-ascii?Q?vFKAVpMCyYC63CDHszjkLjmKM0FZQWyPN/K/wTpqwQAbUKLP3XT6fOj8kydv?=
 =?us-ascii?Q?n00cZMN4qEX2518gJtPsLGaTHLCJnrz5EY6H5F+SJYtZNafEjcDfzZwwT2Kn?=
 =?us-ascii?Q?UFhPxUQGUgXrdZyJPjF70JOGpw98aIxMKwseG8h4wD2gNlmyEOJsV7G76YKZ?=
 =?us-ascii?Q?rS097pZfZJ5uF2UV8zllGaiAh0UswEFybGqqIjIjlRFmYNH7LNYewWlGOb7N?=
 =?us-ascii?Q?HJk7sgc4wQMNcBH4LfCVp7kmf0eeytVI60xZoSPwm52vO9Ps3799S2fT4zmH?=
 =?us-ascii?Q?8L4/KMnzCYzu7nl0ViMvZ5CtpcIVYrEiBcc0fLG5AEpE4WjSko7D0zG1JxL6?=
 =?us-ascii?Q?kOx0XVUwR042d/9g/zkwxXASa9mJFMsq9jdd/2r5/UdsY08CT+1PDskz6yRG?=
 =?us-ascii?Q?I3O6STHdziRuv4MlUQFT7l2k5bt4LkHWrJ9BcnTcXZ15PRZ9qB6y0B/AGCDj?=
 =?us-ascii?Q?A3FTTrWKBaSgEeU6koMereVRDZIkSQ/5TcvKgVO1YkTADAQNy12Oq/YeqslF?=
 =?us-ascii?Q?h0ayOnA8KvWGrN6iTp2eSKu5sssy1txDkdXDcJQt3M+1xkY78scmT59lVG/5?=
 =?us-ascii?Q?zHjqfjJYlqaKXjRhprePVRKyMZbx3pRGGeE/qmXc8h6KL90x/pSYU3pdD91H?=
 =?us-ascii?Q?DrHQV+rTZmRh5dmecaQ2zrC+NtL3uX3ne2IoK7JWkz4npnDLt5DvO+cUIA9L?=
 =?us-ascii?Q?ZshJHK7Z2GvTagyzaqOOk2PQvWTJDxvt+PpKCWIGlE+1pAmXPJ7pK56Q0m3h?=
 =?us-ascii?Q?XGl+Io+hTCqenz9FzWGFwukjqTi2u3duefnN8puOUvVG+f/KeGCaXiK4kfX+?=
 =?us-ascii?Q?xHmY6piz4Haix0wom8mrdSJjxBth6q2mXnnQd8Vi2P2PzQJiGJ3CxnDUEx8y?=
 =?us-ascii?Q?9FNuPGfH4n2TZqnGk1hvahOvRenZ+2mvmgpS2UTFJxMbRc89lOIsz/LLIqO4?=
 =?us-ascii?Q?XT8ONfwG6ozthM9I+CbbdkndyoE3lB/ug0jGvAHvkPJvlgf0SwjmVdYmbJjO?=
 =?us-ascii?Q?t3suhfPJjCqip3xY8Vk2biUtpcL3zvW+Su+0Lev+a7xVGP8eCF38miOEsvp9?=
 =?us-ascii?Q?yx2bx5lY8cUUXPmYKB0yzojKVzPqaM7KZf8uXH9BCCW+R520VnGCWTCBHZ2I?=
 =?us-ascii?Q?eSXr2XIGH3G4zqri8FJtRuxAOgxyY7GJxzYB4QtscKQFdRgDVhA+oczhsW7O?=
 =?us-ascii?Q?26vH8njwPSf/3ZTlofgpbSqSeiRDtiUr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:39:20.8655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bead7575-90f2-4858-d6b4-08dcb6c4d09f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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

Use mes pipe to unmap kcq and kgq.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 22 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +------------------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f165b9d49e29..c770cb201e64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -509,6 +509,16 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	int i, r = 0;
 	int j;
 
+	if (adev->enable_mes) {
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			j = i + xcc_id * adev->gfx.num_compute_rings;
+			amdgpu_mes_unmap_legacy_queue(adev,
+						   &adev->gfx.compute_ring[j],
+						   RESET_QUEUES, 0, 0);
+		}
+		return 0;
+	}
+
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
@@ -551,6 +561,18 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
 	int i, r = 0;
 	int j;
 
+	if (adev->enable_mes) {
+		if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				j = i + xcc_id * adev->gfx.num_gfx_rings;
+				amdgpu_mes_unmap_legacy_queue(adev,
+						      &adev->gfx.gfx_ring[j],
+						      PREEMPT_QUEUES, 0, 0);
+			}
+		}
+		return 0;
+	}
+
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f384be0d1800..c77c66155d8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3519,33 +3519,9 @@ static int gfx_v12_0_hw_init(void *handle)
 	return r;
 }
 
-static int gfx_v12_0_kiq_disable_kgq(struct amdgpu_device *adev)
-{
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	int i, r = 0;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
-					adev->gfx.num_gfx_rings))
-		return -ENOMEM;
-
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
-					   PREEMPT_QUEUES, 0, 0);
-
-	if (adev->gfx.kiq[0].ring.sched.ready)
-		r = amdgpu_ring_test_helper(kiq_ring);
-
-	return r;
-}
-
 static int gfx_v12_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int r;
 	uint32_t tmp;
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
@@ -3553,8 +3529,7 @@ static int gfx_v12_0_hw_fini(void *handle)
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
-			r = gfx_v12_0_kiq_disable_kgq(adev);
-			if (r)
+			if (amdgpu_gfx_disable_kgq(adev, 0))
 				DRM_ERROR("KGQ disable failed\n");
 		}
 
-- 
2.41.0

