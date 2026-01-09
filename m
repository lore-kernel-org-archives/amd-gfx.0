Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051B8D232D0
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 02:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BEEA10E31E;
	Fri,  9 Jan 2026 02:34:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bp0Jn+ti";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB65810E31E
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 02:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbgLOzPnIqkdvB6W7niH6YYBYqQWGm69jmqC+NtywtEiyXN8c5Bfxh6q7cn0db6ktnitygFbLgy6ytLPVHstUEKyBqpuoqmY0ofRvxUDQRUKkw8UYMpRuG1W85Qv9TEdqI6dtYuq/PK7KtFURZ5s9u3c9aA5u55quPAIe/CzMe/nmnhMEjANnYWOXWS0j5DRubnGaJ8wmWHu83bNhXzCWRN1ZaN35uIOSweMcgT1MKK/Xp2X5UhiVMQhjQHP4NFsA8zjitf1jE7x1B08mcpZWqsKLzoAwQpVR/alBGJ9g/hsFJ/VmXYHemb/azwIn12uxnBAPGIiH3GX3nj9NXAGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVFcOpQ8ayw6YuXG6w2pmPPGTGVh3FhZsQVERDW+5Dw=;
 b=aB8u2JEU6asmSFeJ1XHDxA28mXDcx+Z1is/dyUE7/MkMY5sf6vRW0JEjOIW5NqpG1iKvak152T2fDNw3qghd9wJxW+ADQ5ChfusoWjBpe5vaUwDpZNwSBZqRfUAbCasu5H4bibXgV0BYfhCnPrY1aTjGKbp5zfGuYhTWAhurPIuv8QPVSrwJux9Tg7ol9tb+dQIAqKw+dX62XdGTNsdDtJYZAHJ60W621g+d34Fp9W4XobsBQISuThY4JVNDMvE74aM1Rk8sbfEHl7996gK8gniKg6JdFx7jVCOLfv5qpSeURMPQOhsVeLDFFLxF2MR/kJ2EEUipv8bYOG452WfEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVFcOpQ8ayw6YuXG6w2pmPPGTGVh3FhZsQVERDW+5Dw=;
 b=bp0Jn+tiHIwBDP7LgbFkg2guG1lOHGeCv29WWlobLE1yuRjlf/WQX5AU/LjFBa7MLW5tdaW48fZHtJvUQH080C2e5hgnOmAztcPJGjOQ0QIqKFsNLUM6WNcR2Uv5ApKQs0+RmuOu58P0oHqs+FtqmeNOhSoLdhzgiC0AC/iQTx8=
Received: from DM5PR07CA0111.namprd07.prod.outlook.com (2603:10b6:4:ae::40) by
 CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.3; Fri, 9 Jan 2026 02:34:54 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::e2) by DM5PR07CA0111.outlook.office365.com
 (2603:10b6:4:ae::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 02:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 02:34:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 20:34:52 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 8 Jan 2026 20:34:40 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/2] drm/amd/amdgpu: Add timeout for user queue fence waiting
Date: Fri, 9 Jan 2026 10:34:27 +0800
Message-ID: <20260109023440.4188487-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: a54fb260-0729-4c0b-c505-08de4f27ac1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ImdYk5B5xlRbbmCILd3rsphHU/f1AzDElCrOqa1DaNWmrwS0wlTghPr2QhLx?=
 =?us-ascii?Q?ZhVqQzCWAhTpuIXIxmrjulOkrITqCsYNUW3Y3W4mZV9sI7O89n8HhWGGcq2D?=
 =?us-ascii?Q?5A5TLl+8aHQUm+7VFGFBQFOURelJ4IR4+AgYzEJoe22r8bCHK1QONT7RgbzR?=
 =?us-ascii?Q?KGXa9u3SAthumXPUlx5x3FQ80YBSHw/cxcnu9HaUWddmNDaUTsBbpL4A8eg3?=
 =?us-ascii?Q?POn8uGnWwFDT0cRV+peb5pc+ecg5AUb2Yd7QK3cuAyQ99diwgwzJaqslqRLL?=
 =?us-ascii?Q?kxRqZZCBSqHbuPozoYBKtGhqPnAN6ht/2LH28Z0ym/Az+CLvAbNnqlpT5oGG?=
 =?us-ascii?Q?gnMuLjlmU+IamIVRgZUiktxHgvcIo5ehm1V+Q0b706DWrhXGcm4An4m5mDmL?=
 =?us-ascii?Q?Jba2MW/M3hJF24A9tFTyZOGz79KpJjd0iMkOY4FL89DEG2obDM8GA65m6usx?=
 =?us-ascii?Q?ICJ2bed+c6R28xwUYLUTvYAXrrr2V1K4f2FdzDLUxkFM1z0Phyo8TRuj1PQ0?=
 =?us-ascii?Q?wA7FQ7yZV+slRuJjsUh3Ndf+2mm7KaYuU/Gi0xicRmABRMfeGGn4W9Mblpw2?=
 =?us-ascii?Q?LoLmpr9Cj+Kai+QlX54IAh/2hWqwiYDUtM4wLFf4kdL/9G6+aV4MmR+rPi9h?=
 =?us-ascii?Q?mPMzHcuy5FBD1vd6f5Nw/EZPp2H/BBIAkSIjje/vBC8Khu7OTlRxTiuvOEOJ?=
 =?us-ascii?Q?VIZrqq6/eXWFy/fgV+3fYgsQ+OXistdg5rzErhlQF0BGVJOTBklSjcf3F6m6?=
 =?us-ascii?Q?dPXLZOgf0C9wGx4j+SvbNMYkwzgtLE1Q9JJcdY8mU93s4rQwIBQCgqDH2YQa?=
 =?us-ascii?Q?JLZ1/KLrRznDHG8KxrqewikavPaiyAb2QgK3prgcIzkzg4h0pZWwqCy3SqyS?=
 =?us-ascii?Q?sVnysqyjsOE6SnCNjuUh4jgEMbp2yvlMuzrWEoMM7KBLzdtDVC9oHf9Fx1ib?=
 =?us-ascii?Q?q8vcek8+hEywyM7XmaVRZShOwOIgWh3nIllu/XPtMf/Opmqq/FghUOEork84?=
 =?us-ascii?Q?WIc/fsKlaf7Caj6tg25mEICVPG50n2AV6JA9SpY3hFRfICJKpAqewi/30o1T?=
 =?us-ascii?Q?RTifTG6Lhd4DBtPuAE3XayqEWq9HB+Pk8L0gwrZu0PPuf9T0cEXt/vtgazsU?=
 =?us-ascii?Q?MIJ70Yi58XXKxw0GPvaRHK/iQ5GfsldsqZ1irLi0zAd1GOQBOAIuIX7wqqMP?=
 =?us-ascii?Q?vaQsda50Qa4aRNbxBYZPHtYgY1bNT4ryxLlPOjYZE9TzWQXS41YYusdtLstK?=
 =?us-ascii?Q?9Le+ePSlCkDsArziCI+BLtsnoaKFCIIQVUyrnr/4OHaUlanKCYAO7/f5FKra?=
 =?us-ascii?Q?HWV6CDboA26VFRMOhHuXwL/3FzENw7xMAkDJ5JdCEyklMl53DJ4X0yr7iB5D?=
 =?us-ascii?Q?rSzaz5kItirPe/8w63lfI325q/dHbthYYeFJuTm5NvwEAkB6hQZ9xugIjPf2?=
 =?us-ascii?Q?sR0Y7Gmfg2CzjvhtBxrGr5EJunEFyudf+44lN/GvpwESNPniuwwA6IW8BUMX?=
 =?us-ascii?Q?n14Nqp1l54l+VwjlAOdIgfgeB/OJqbujrYPMZW40+s2j6xKlXoHvgSSxG4T7?=
 =?us-ascii?Q?qWyLpgnkTzLjeiGMAQM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 02:34:54.2161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a54fb260-0729-4c0b-c505-08de4f27ac1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
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

In certain error scenarios (e.g., malformed commands), a fence may never become signaled, causing the kernel to hang indefinitely when waiting with MAX_SCHEDULE_TIMEOUT.
To prevent such hangs and ensure system responsiveness, replace the indefinite timeout with a reasonable 2-second limit.

This ensures that even if a fence never signals, the wait will time out and appropriate error handling can take place,
rather than stalling the driver indefinitely.

v2: make timeout per queue type (adev->gfx_timeout vs adev->compute_timeout vs adev->sdma_timeout) to be consistent with kernel queues. (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 98110f543307..402307581293 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -367,11 +367,29 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
 	struct dma_fence *f = queue->last_fence;
+	signed long timeout;
 	int ret = 0;
 
+	/* Determine timeout based on queue type */
+	switch (queue->queue_type) {
+	case AMDGPU_RING_TYPE_GFX:
+		timeout = adev->gfx_timeout;
+		break;
+	case AMDGPU_RING_TYPE_COMPUTE:
+		timeout = adev->compute_timeout;
+		break;
+	case AMDGPU_RING_TYPE_SDMA:
+		timeout = adev->sdma_timeout;
+		break;
+	default:
+		timeout = adev->gfx_timeout;
+		break;
+	}
+
 	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+		ret = dma_fence_wait_timeout(f, true, timeout);
 		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
-- 
2.49.0

