Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EABFF94CA1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 371A910E914;
	Tue, 21 Apr 2026 17:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b2bmWPrN";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96EC310ED37
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyDk0WQnXN7Yc/ghFHBcJvVg1n+5MWEic5xXgVNbcpVSw27+kNKEKhwpVUieNF3HSsIDwYY8ibWt5OAxNmbhC9JbCKgSiXN9LBxRkyOCeTRswcjhHlgxhUtxJgUoFPbBJHUDX+YiCViq2g7xbnFFesrIgriryW3iushERzTL2e9/KVK5kv1YnlUczbkrSEoR5zdt4Mog1R/zOtI8B2jBqde5vyEAULXxhCcUsmmPKdOV9aqClfZGVh3wnqtbyuEz/gVb8MB/u+/4aGZ/HaBo8EkTv2Mnr09q1DYJdLvENlgvH+yUO/UVC6ZtK+vjCpOIFnTvzihPgRjFlbIb9IC+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDGitTQbQcXaZ/Vv/6WZkQ1WQGWP/1+Ay250m8ifdgg=;
 b=Ra8nfKcJ2abmDIlmGy/WGQPC150yMkcyoBrwFEqFGPE3rnNftKWWzH8sLOhT9wt3OkBuSYGY19TcQ3/T7CuJ1t9KwvlYk13EXiryGAqIsQF+RO9vS1Cb5evX4YCUvGV3sT0JePUwZNYEelekl3hKVxMv4i/+1QeugDBAeK9XV+OK+Q8SoBeJZtNUpHohf58vaEAHu4gYtVPSPWDyEybhDwX0poZxVH6wwgytIEhuUH8Gv0JnyxsdVD0y9ezeF92vWpczw9nCDuLvhcWDqhdU1di8NHTjOaa+snlR+nZU09cpJ3T39eizX77prwX6wa+Bsm4tbGbVusQa32tNB5q2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDGitTQbQcXaZ/Vv/6WZkQ1WQGWP/1+Ay250m8ifdgg=;
 b=b2bmWPrNTnOsvsRB21aBy/BhVyaaaCe9ocO/wlVAfuSy+Ar2R8VyWIHmeCrR4jQIT4pafpIUu7MuJ2aj4h8iXm/10engxy1B0kEMZMyt9a4bL6FyvPZ1I7iRfGNc0QTzMsyYM0OtDTz//3c2CchS0JZm5EQSDcc7v3EGh7Y0bdo=
Received: from DM5PR08CA0037.namprd08.prod.outlook.com (2603:10b6:4:60::26) by
 DSWPR12MB999128.namprd12.prod.outlook.com (2603:10b6:8:36c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Tue, 21 Apr
 2026 17:59:41 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::32) by DM5PR08CA0037.outlook.office365.com
 (2603:10b6:4:60::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 17:59:41 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 12:59:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 09/11] drm/amdgpu: Signal QUEUE_RESET eventfds
Date: Tue, 21 Apr 2026 23:29:06 +0530
Message-ID: <20260421175908.2402019-10-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
References: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DSWPR12MB999128:EE_
X-MS-Office365-Filtering-Correlation-Id: 58126694-ca98-49c2-5894-08de9fcfc33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: DCdE4xW7XBkAU5PNaMsvKp1ed+lXfQRL4B1UgyLE+VBH7i3suE3bsWxW72+JsZoEAvzGDf3gcL9559ocBES1LPwaqfm5vxb3/WYOrOEdPtOrR1IiBNuITnEoEwa4xzQ7qi7oMHIp9mv4Jqlvl5SEskDe00cDlBqPh0h/GmxoYFqR2N/v2G+f2Itu4FVE7VXU6Z8KaCHFuTuVXckah6RRt0nF7iFh4nQ8j1pBgD9zBa1U14ewkNxJxu5W8VlGjxMUUliLB+C43JJBGj71dh2l+JyDtgzIYHuE6UZeK+5arkbWtMnWw/Ayt+6JhYWZu9uMRv1rQS+UF4qbXOWCIpScczuXTvqNus5aEi9LPLYXjRjP05IpT648L/Iu12HFA39XXofYPXDJ2Ye03SdukJU5VeKF5GwWjDlH7BATFUTR4wj4BQO1e7o2GB7TXHqiTCcaxie4EXHlQ9V0+KiatOlu40C4gzoPJDZIrsNwzcEwb6QAfvv+S5mGZK5sitQf6Gp32IgMAMIDxjaSm3KTMMICJSPRJ34SImp1mWCkeST2gAA7aMuxGLWw7HviW+hrBMdo9iKoCOSNyafBUULOlCgawENy56uYuN7rnu0P85ZACkwTlAtVJrUOm8bqhxQWyJiuxQWatyM+JDHBVmeOW6OnX52xRXpTVLUpPodFmzCdE2J3hPEq9+wMOVMw0El3TJRv85u3JFXcFQVq7CR4vJGNRYUhQaJDUkD1aW9YoiTfzGevsLHq0vhSShSzQjeojdIBhMw3/d75m/UrGDTPImH79g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hui6J5wgCO2R6hKrHTOlBCn8WfvfTKcMcMs+M6cEFaTH5SuZs1atx4HncX66qayECNPuH8bvuQrNrhmz1A8KbjLfT0YYBxJ4r9UmFu+7eTqfmCOE4CtplvADIyMlinkcDJxCIIGPxWgyJ3p8156cANu8d8sinmG0GuQFSunsluLdOZ594jHRIfW4MzVm56HdhNitIecJZDrwD5SGBD4+H1iSEZSvW8j/JiHvMrXPk6DmKgVincqPawef9TGaBQaInhQlUo4ZUXrg8K6yQfnlf/A7/p/eA7UZZqOHGRFxdmJrPu5n2mrnzlpthMVfmROqEY6Q2U3N239csDLvL4rjV2UbkZCuNSxhQOqjwX6Wk7ripqs+zZyobM9fz87lU4vt0gczrMi2v8aHJZJ2z2OOYcyTxKe6xwNv7DT2h9tKGelbH4udHkK+SglAiJl8ODix
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:59:41.5074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58126694-ca98-49c2-5894-08de9fcfc33d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999128
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

Changes in v8:
- Use queue->qid instead of doorbell_index for queue-scoped event
  handling (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d12cd1b7790b..e99241ae40db 100644
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
+								queue->qid);
+
 						found_hung_queue = true;
 						atomic_inc(&adev->gpu_reset_counter);
 						amdgpu_userq_fence_driver_force_completion(queue);
-- 
2.34.1

