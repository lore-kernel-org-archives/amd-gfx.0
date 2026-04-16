Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF17F433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA58E10E7D8;
	Thu, 16 Apr 2026 03:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="psQ4HngR";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013027.outbound.protection.outlook.com
 [40.93.196.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E208F10E7D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6JUlHIXf5h5Vmg4NGtsr8euRzmCPHcPmhxwJH3RuNzKowrYN3tXvuMGPNHSPiKMWEvqx9+u9kMBFBceNS/wq83u42hvTu716zFNPEyW05MoFy+8HFMgzafBAfhhY2UZB+bKotc7h8Haeroy+IhUvEuqk0dbv5P0/RUIMa9BepFl1HlswestU/buarYbNSNZXhD96MD53gtduZXvWtSa717eU3t0PIWGV5dby1p1ABcXXOpni6MTD3vcoa9tu2P9V06AsjfwgcD6cSPQuqXnClepMyohuzt4w+k9AEQedzyB0ftaddMbDQm+7Vjt0lIss8jM9esh4CrsV3GZxVNDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti//agqfGbS0KWVnnFfevJhI1H8rSd4upzM6MRMc7yw=;
 b=YVSlPaEpEePJoRKz/hRljGrHp3CwQs9Ri0VjWV1+w2/R8V1GAIstbXaW41HoJCqpr7WwJBFX1eekSP+AmBW/Hb1Ej4K/Y9km6VhPYXhC5SZLpyBdRGgXKp2nmT8uZZBhkufK9b7iiFteCxscrI8l6bcZenT9De3FRtJxrEfC6oGKviRe8Y57XhTMPG8A3oR+QzgPhCAhWrurzJb0DTF5Nz3yhkBJk0hLcszHqmz057bsvtnRUcg3rGE5nn4J+NyMVBDG5MnVfzP+IFPI+d0cP0Uwn391j5Gk3JMxJ/7Y+49MNQcfF0nbMWj9Rs4cNAkkDm6fNh53mlv8//iW1zcvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti//agqfGbS0KWVnnFfevJhI1H8rSd4upzM6MRMc7yw=;
 b=psQ4HngRIS1+xiyUlllfukDUZFxIC6faWjzK7Tt/qQYyxbFp/nGbtoOx6rXndVQ3BmhlA4IuXNk0/Z1IeKeRE6I1RBzneapopn3Es0Ei9RxVUGvJ4pUSD49QCVE347YMs8tBPrcZprZvhRus1GAcftyNYZvDUWdW2RxKyNd8cEY=
Received: from DM6PR07CA0097.namprd07.prod.outlook.com (2603:10b6:5:337::30)
 by SJ5PPF0170DF9F2.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::985) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:27:36 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::9a) by DM6PR07CA0097.outlook.office365.com
 (2603:10b6:5:337::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 03:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:27:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:27:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 08/10] drm/amdgpu: Signal QUEUE_RESET eventfds
Date: Thu, 16 Apr 2026 08:56:57 +0530
Message-ID: <20260416032659.2368054-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
References: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SJ5PPF0170DF9F2:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a37f20-afcf-4a94-0578-08de9b6819ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7IMlvW746pYIsg1hK6avXshHGTreFbNyMUaUAwHkiae4UjAfbwsVZwelegAkLEldJDMQ5Q0D7NyNbvQtd/nABmn12rH468GuEzrGdUQjATlVltK3R2IuK8CSMYnus63aMRZkP0nDxJfeTM2iuO0+iHmr1in37/btjUmH61T6XMCUGJyCDGHzoZIfJzR7j072teWKc7Cgylcpxip1AKh88zyWdLfGar4oX1KXMAhyVpKOWQhk/D2yoU151vrhG94iV4uX1mrmZuxH7nfVriJkOwpuvdtnxNLyM1oA7d6ZiDttykzPZNgPr0F7pwpEAVkuTT+Ew9rSj1+wGflhSys9BX28At3dmG54MebfWsEoBF7cf+oIyXs7JwfJt5JzbFFad92zbNpVJrrOkkAwDn6wI1lISwTGH50ZjS5bZxzvXpbm0yOykg+fuFlrS+XgbwMCHbXLKIP00NJqzi1f/hK/7plAJ72hhhb+C+BPEyS7MsQIryCpYkGkQ2pCeZcMLFraeBi4HElu9z5m8ZWYUbQ6n17pJNImX4YllVLNdcqZdcpJTDM10dW0TQUWO2rjJMxLtLuWx236/dxN7yklSCtzm3o2YKIcI3/6SUvb/IgrWcgcdlEufgAvedF3VIU/Erwu175C36FE9yHXquAD9XH8KQ74anM+M1FAXgdiG4Gr9ynnCVtUv2fWQl/+d2z8t4iB1pS898Zit6suxjUHRBFUt10pJcffA/oHVfXQZwq8hmXm4NnFX7Rf3KuCIdMsLW73eX4GRHSFDEXN9vvWO+AvsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m/KGiVyyu4RVG7RUoSKHdm7Am+qkSPyElxNMRJmH8vg2hgREiTdyISP9uJZvCM3dElQtfKR6jNkoHxISGX5uVGqAjySg5O6vEEUY0WBcU/Ti84An/YVwdWNpq5pjuiQuIcZ6SE/aw/g1peNl8YxAOklxIFLL5ltrwJC7KaLxfIy9lilz6296QqcPS/5T7aFaNXUrvTi6awLBQryfjHh0IyGbN0R0ybq5ht/wr/v6aGQXiVBdzV1WsTj7uh8MIKzWQok2B0KKImG521g6rCqXUMK2+wN6xghFX0VmsNSLRbL1yOe9TPpF4wRMspT+k8kj6JbwJa0clQXyaaQg9x6exBWrdKHYdErKXAejh9npmNecs8R/Swy81ALlaLfWI5EyQiWvazsOwyiXfH8IZQzoHC1z57IDvjJKJ2SPi6SveYoC8KE6BCnGTlH/We3Cq+q9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:27:34.2200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a37f20-afcf-4a94-0578-08de9b6819ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0170DF9F2
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

Signal queue reset EVENTFD subscriptions when hung user queues are
detected.

The user queue reset path already identifies affected queues and marks
them as AMDGPU_USERQ_STATE_HUNG. Reuse this point to signal queue-scoped
QUEUE_RESET eventfd subscriptions keyed by doorbell index.

EVENTFD remains notification-only.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d12cd1b7790b..af29c1d8d699 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -254,6 +254,14 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 				for (i = 0; i < hung_db_num; i++) {
 					if (queue->doorbell_index == db_array[i]) {
 						queue->state = AMDGPU_USERQ_STATE_HUNG;
+
+						if (queue->userq_mgr &&
+						    queue->userq_mgr->eventfd_mgr)
+							amdgpu_eventfd_signal(
+								queue->userq_mgr->eventfd_mgr,
+								DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
+								queue->doorbell_index);
+
 						found_hung_queue = true;
 						atomic_inc(&adev->gpu_reset_counter);
 						amdgpu_userq_fence_driver_force_completion(queue);
-- 
2.34.1

