Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B7BCD98D8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 05:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8CB10E94A;
	Fri, 12 Jun 2026 05:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lmIR9Lth";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741D210E932
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 05:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZwD7dsMzvzTz+4HsmyLCHzBSSOcKN+HIfUjmEn/y2EL396/9pduxap3rnBN33alYpx2i80p0QL6U1Dm26ZS5jALROT5LzIM5nk6SDwHOxnCoe5FcY2T5HdciCCwi+nvWUSt96Qtog21usBjfZesKI2e0+cW8ZEwgNBVpFjTQ/F/C03/9KZ3HmwR3iRA0qNYr6nyGSwm92QgoHvH1rLPicVr0kFyCdRrA+E0cOo9sY75laeFm9Qu5ESyIUtmMvB6fkF/XLFEPv+75AtMAzy1TTZt6qcjnnGxM1xLuiUOxti7YP0bNB6YHbiYEewOkmHTzGu2FlBCOY2mfq8EKVy7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2r6RMq92Jx88DBkKFYGkHzNMkE+j0ail7ii4PdqjCk=;
 b=fgksVk9BDG3s0WGviJQPX25kkswlvyse3sCtqmQ7vL+hM3n0hz5ZpYQW9Oax36eVjPydv2o1Swd3Z/6yB1Fgi1elps8o6ifEhO5io4qbSVj/mZrbiMewwUKwUz5dyKklKPQp84abRI/I4iq7OtLybYDKsHnzvAnwHtBDibukvaE+a2ZPT+utGzLvSevutMslpxZy340Qa5l97l/OR1nU4/9qDmvzk3FUXTL82QfwrHS28Sh/Dv1BB7jAew5snKH4oNY6MwzCG86YHWO2u38Ix24OHJDaKpXV3cOSd5AnI1uiE8nQjGY4PhtbCE//jxR7SKudXTjD91z4XAYyU4/lDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2r6RMq92Jx88DBkKFYGkHzNMkE+j0ail7ii4PdqjCk=;
 b=lmIR9LthjXjiPykyPnt9vPfJRCE+0ZXa3JV1SZDRPdCpmFpZ+Fe49WVbPMea2THrtiOQC3hMhD/4JkavhXYKudFO12KISHZzG6gtMOnHIFy/8Y7z8cR07Qie58jQFMrLuVlgCMbjU120HjYXa6uUN77IVuacq95InkM921TlNW8=
Received: from BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::14)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Fri, 12 Jun
 2026 05:53:04 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:59d:cafe::a1) by BY1P220CA0001.outlook.office365.com
 (2603:10b6:a03:59d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 05:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Fri, 12 Jun 2026 05:53:03 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 12 Jun 2026 00:52:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
Date: Fri, 12 Jun 2026 11:22:23 +0530
Message-ID: <20260612055226.2879270-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd45b66-2bb6-48c3-7d5a-08dec846de14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: TJIlwTyd58uf9ZQTBlW42QQf33FafkrUbBpT+5/kZxJ3Jz43qqzSmDOrggWE8zlFCW/yGpg1s1qqqRKvMtYKPIoss249VTM1UihsMMGVE+0nLkcMiIEZcr2stSdFu1Z/5GZnwRuFSq5Chu7XOFNtlagWduMD1UjCpAKIsK1iGjrX9MPYy0rKmGOGdILsN5LDz/c4CVvUDrby9o4GjRopQEbkBqR+Tkw/zHduJgJV+mbHXp1krng6xNNkgatU+fZfgGUcNHOk0MFbHLwjltDKAH1bEBdLfwU5Gt3Xl587B4lZli+AY7s2o7wbJq7Hd1nvnSLPwPrU+R0fyfK9phogsCnWzQYUSbQ7KqvI8oZ06EcHS7xAMpRMS1oW5pv3tsSSBJt95yOsSrb6louyfhRhiZS9GXZyn+LDTia9tX9n/0DVIMBuXTadg1vghed5LKrDcZj7SA3x/hhEgV3WkN845jzkH8BGRnFlDbLuTZB4jibyYsk/RN2HkwbpB6/gfEGIzHo7bC7+6YNmq+JNHD4lIeSlbll7FZxBqk9QBAXj/dTUjBwJl6bidnyU2IMHo3WsHjQjoGGxBVVIlH2Hp8wyJhuk6GZ3pDl7TxOapw6c1t+yVhGNfa+J7C4gePFE0kiYWleEpKXYuKHgD2kHoa5YdoeyrVE5pYJyhG1KquOBhFkfJr1Yn78mlkbI2BmN6BnkHX4tLpBiuaGLWkpyU9O2r1Cjf/+3f0sggYNPwT8aM8w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0ob7kJMi9D8QoeClJv/UTkrUWCYPsoAVzO6m+Xu9FcBOjPxJDXEt/Q0Dd8gdJYCW9nmbW+bPbI1iaYh0GtXI/iRtWBTIfIrgpcjUUb7VlMSUQ4BIwf8BerJ94a6FnLptrW1WIc2EtMm3lHc8xTjVqOdZ0TZH2msJ3criNwwSkepCNbrjG5B1rBNqD8WCzcr9unDZELAEMy3ehLnbLMGGh8MbVyet9UkDRKxEITTLkKimM4ei5oT1MQaBsvc7t9eU3yjuLhjPIvXV1P5zINH6fPhQxN/ni2FQdTFcJMRF9DVElBCeI5nPN1ODJrZUUDjeSNDYFDfS3gKTUlb70YuSLJCz8we0RsE3d5LibomM6EtecP8S6QShv3QGyW0fDSaULh2EMkblbNJxjbDMP3smv1ipp6CZmrZ055RcOpiLsnkWpLvfJLOAzyYT4VFuFN0P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:53:03.0931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd45b66-2bb6-48c3-7d5a-08dec846de14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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

Signal QUEUE_RESET EVENTFD subscriptions when hung user queues are
detected.

The queue reset path already identifies the affected user queues. Use
those queue objects to wake up the matching EVENTFD subscribers.

EVENTFD remains notification-only.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index e9189f07c6dc..ee8dbd70e1c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -238,7 +238,16 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 			if (queue->queue_type == queue_type) {
 				for (i = 0; i < hung_db_num; i++) {
 					if (queue->doorbell_index == db_array[i]) {
+						struct amdgpu_eventfd_mgr *eventfd_mgr;
+
 						queue->state = AMDGPU_USERQ_STATE_HUNG;
+
+						eventfd_mgr =
+							amdgpu_userq_eventfd_mgr(queue->userq_mgr);
+						amdgpu_eventfd_signal(eventfd_mgr,
+								      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
+								      queue);
+
 						found_hung_queue = true;
 						atomic_inc(&adev->gpu_reset_counter);
 						amdgpu_userq_fence_driver_force_completion(queue);
-- 
2.34.1

