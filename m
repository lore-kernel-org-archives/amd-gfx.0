Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA94FC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 14:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6441B10E0B7;
	Fri, 21 Feb 2025 14:50:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xpt71wr1";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD4A10E0B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 14:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlIalELGLt/36ll9YvJM4X3BYB1AsSzgtGqUZ/4M0Vu2qUhxzzs/0FuGBS0s1KrH0LFB4ODYxmZDU1x1t9oaVA+N0WCOzhRPMevOXvohiXBQT1JXzT1u14tjxrpzctbfbosKghQzd8GNRJbrL5m94O7qXwosyr0+x8DZj8SZwk1RaphNQK2x7TzWCpPOxnYvNG8FloMB5BaJEfwxG301unk40j9sowCxM1nM4PT5LM2NUo3wdYu/v+lFyK0hqEmQMPrlViu+zhWtl0HvI3P05onrEBsIFDU135I8KKqxb0JjpOyL64cOEyjSWhR7bZPaPDIo539MRb/46aig95NizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3V/f2edMEY/csluK4GB9MjCu+En5NiwtvOPBzVX/Y4=;
 b=m2iAhAIKbieKVLveTrgwvFaBe9H+7q7XEYdgiIMeOYYPxp+vXEAjI+7r/A/Xlb/juY2Nw0+G4ZjgPo0dDA/kd61P+AfEAIWXaloiP6j0X/6YNApiIdufzPRt0vA5yBG4JjPQXkcNdv+CpI2rB+jnYe9jfiNs88XOWjWFqhHiO/vQnPgoo6klTDueUWM6z69VjpA0DXKKCMa7/a5o6b9PV3lnw8CeQ1YjQWa/Auj7Ia7gKqOk2DVyF3TCPklZCsYlzq5DqSC3HQ1c/FAhzqR9jfeTJfxu5ongcvU3KRX4fE4vXb/JKjsTcW36rX4RdGC0mKl4D5q66luDg1w5i63+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3V/f2edMEY/csluK4GB9MjCu+En5NiwtvOPBzVX/Y4=;
 b=xpt71wr1ABqUOUB/UCzsC8drgXhDrQYneWfHaIfVeoQ8JdaDTZGJKnHBPimKvnrXAPge00XqWJVbGRMXhGBRQGd9jSY+6tS6LoudQHBmXdpU7OJ49lmnEjB987mPGqVwTbiWoIQ6+KLk20mYgYnb198/LSh27FMNV8A6tCC43xk=
Received: from BN9PR03CA0039.namprd03.prod.outlook.com (2603:10b6:408:fb::14)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 14:50:47 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::b6) by BN9PR03CA0039.outlook.office365.com
 (2603:10b6:408:fb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 14:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 14:50:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 08:50:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/userq: fix hardcoded uq functions
Date: Fri, 21 Feb 2025 09:50:32 -0500
Message-ID: <20250221145032.3440904-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221145032.3440904-1-alexander.deucher@amd.com>
References: <20250221145032.3440904-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a90bb5-7e77-4a74-4df4-08dd5287206a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Yx8kuxZaZ4kEtVFkxjaAyB7oL/diNEN4OZrC28mjZL+2d8McqYP18vvcn2V?=
 =?us-ascii?Q?u6QSVaQwpraof7w5dW0trurMUb0Xmjx1oKdw30LxhfmA9kAtu4F8jh0M4pmS?=
 =?us-ascii?Q?GTEzGNcEEQ8ulcIWwtiw5FMdq06TeDsyHch0YcHgRX7R4piM0kR5x4so0lti?=
 =?us-ascii?Q?FdpzEjBVRBj4k3aijSjecUqA72TEJ71XTdXdXqvy9hXudOjIPmA9+ByxveLE?=
 =?us-ascii?Q?m+iGLZaD7oALGIwFNd+tfYnvrdOut28QFVjur3GYowNiOjrg5QnNx16ssiL5?=
 =?us-ascii?Q?L9LFkc6+VwTyMPAXdzo/1divMRI7QlmSAbuYaWfBgzULhcLxcKwRn8r2QfcV?=
 =?us-ascii?Q?FfIaTzA7+dN0/dFyBNbOogilUGUryzhRynuUR3Htz0G3eu/ryCUaObX6Y8f7?=
 =?us-ascii?Q?QbvNqp9cV9i2QfXx71TprXO07pY7V4x2x/lwOtlmcoBykdEQI9M7+9kh+wxO?=
 =?us-ascii?Q?7MY1HuQAeOsD7Y1UOVRKVxJocyMyJlXUxxyJBejOQ0bo5X0sTGd2uIGmNjnK?=
 =?us-ascii?Q?sCCoT0OtIVfGJkP1sbSZhGfKmjoexpq68t2JwJeAoJHXTt//iovj4BGdhdhW?=
 =?us-ascii?Q?65eMJN4/Y+yXlMVh28xoscID25/A0GBaaQiBXPDLg1wABLUW8cDBJ9lvzOh/?=
 =?us-ascii?Q?3rVU/3Yld4EnzKOU0TkJPbhbI3IwLhurdIgCDqGqtfYRhqHoSeRlNOENmzkC?=
 =?us-ascii?Q?jt02CJOoim2kXtIiUbFg8RqpTStfi777BKmz5jsj3ESNhpjUvao4WrcIfqMO?=
 =?us-ascii?Q?hSSij8tnZLPDVLRE3vBT5t+7Iv2iY59/b7Wq3K71ImTp+FEk4ayZLQfPwreG?=
 =?us-ascii?Q?Ll3UhRk7RZBmSkmGauDLc+UReJ05GBXXCN1P/4+BrVHRIpM6JWGbCVPoyitm?=
 =?us-ascii?Q?MGsX6HOPQdroVcT2kS4qUd4x2eWYciFmvafBNfCRXwjnpF5Ma7Ur9zMZvvnN?=
 =?us-ascii?Q?0Z2kD4bExjIakI8Ks+zQJw55FRF2PvA4SOZjXItweKzw4jO/pyqfN2IRwOid?=
 =?us-ascii?Q?I7f7Opw0Pp26W2I1U61boLm5evCuZhLjYxbxsk8cYZqxtqrXMk6KWBll17mK?=
 =?us-ascii?Q?Z3geKKK4jZeas1sYz48irQY1Kl25H2/Ew/61Hoc54+CCUUQB98Wm9HUZ3Dwn?=
 =?us-ascii?Q?W9bUpket9sCn41/YcyFsunxeGDLLNzCVXqwvkt3FpxemHaTiZFYp/dUE6Q7T?=
 =?us-ascii?Q?PxDDvQxq/ma2zHlT9gBAyUQIuz1fbnErMkdBvpcZyEv8XYuGrR0b3gW+WV+2?=
 =?us-ascii?Q?f0jWdZn/VzxAf7Wi7FdkVjsnuqJpBzF2I1L5YGO6WFJgl2ucWeVa/Vd8tjRk?=
 =?us-ascii?Q?lOzF1A/PfsLZYpvAFaz6qT5KylwFg+77OytLT2FsJEpPcwddxu/UCWd9Ltqx?=
 =?us-ascii?Q?VnW5ACTrt+YMvKenRxu+ntxPkzd6TLDbF/fipb3uObgLlqUCZ+l+z4cs4fP6?=
 =?us-ascii?Q?lcUAnPxd0uCXHVmporL7+aK5Z52/7Yzjevr8H3JJkOPz3Uut5DDsJw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:50:47.4066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a90bb5-7e77-4a74-4df4-08dd5287206a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
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

Use the IP type to look up the userq functions rather
than hardcoding it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index f1d4e29772a53..0664e04828c07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -415,11 +415,11 @@ amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
 	int queue_id;
 	int ret = 0;
 
-	userq_funcs = adev->userq_funcs[AMDGPU_HW_IP_GFX];
-
 	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
+	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+		userq_funcs = adev->userq_funcs[queue->queue_type];
 		ret = userq_funcs->resume(uq_mgr, queue);
+	}
 
 	if (ret)
 		DRM_ERROR("Failed to resume all the queue\n");
@@ -570,11 +570,11 @@ amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
 	int queue_id;
 	int ret = 0;
 
-	userq_funcs = adev->userq_funcs[AMDGPU_HW_IP_GFX];
-
 	/* Try to suspend all the queues in this process ctx */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
+	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+		userq_funcs = adev->userq_funcs[queue->queue_type];
 		ret += userq_funcs->suspend(uq_mgr, queue);
+	}
 
 	if (ret)
 		DRM_ERROR("Couldn't suspend all the queues\n");
-- 
2.48.1

