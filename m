Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8631F94CA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 18:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5986110E926;
	Tue, 21 Apr 2026 18:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n5Um3GQG";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450C910E92D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 18:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pd+VbJr62hFJx0fEIiaSWIC6DDGR3quXYz4cqOleCxB4+7CIamxFwEOL4x7UNRlZIjhtzi1iWnqAG2o4NBSnxbopzS0/6m3f2YxAOuYu3IzYCG8TdqTgulDFgpP37sFQWXI3wn0oBrEcgLcsKOvOBcZDxRSEjgHS9ojofCVe+prS9rzvvnB6lcFw5Em4s0F2eX85uxJ/zoPrTDCpiS3ZqQfCq5XlTTwb+uK942fyex7+vmOLLIMlyKbiVRA44qw4Wpupl4TzP71YlxS3b5BMX6P1fmusrGZ4hTgk58tjbfqxq4h8/eRryeO5SfeTFElCryEDYB0PFjV9n10/sdvnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHLfzT39p2NNath1/A/tQGCOPem+tWwFWpQCR3LXbMQ=;
 b=JOa0ja0BHEMmTaxj5Uc3On0v1EZQ5C2W+mWN5oVmSqnjTttzO8j/XHCit/Ehgq//nNofITH0R2JlGBttFPVz2+rqdULWCEh88m3ckm8TWKpMMs24T9NkNyUgNXTQjnwCCXAMWJFW8K/Wd0pFjdDNsdRsxpCKXQS6DfbplqrorNo3cydRy5xlm//SMavgXZrIJmu6F+StGQZh5n0A+iTJaF3iCzdoxV+AULwLxwDHZf3Rso1xfv3H2NtI7hMoE1rAm4uUecCYO7ubs2ZvJ86pFX0zRgvmXk9rDdTNz3VR4PcQn3a0gkJtwBtdI1NGFskX3GXf18BWhCTKSGzxpiAhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHLfzT39p2NNath1/A/tQGCOPem+tWwFWpQCR3LXbMQ=;
 b=n5Um3GQG0MoESQ+H17UzI7qpXyB6GP4yEnpugsFBePLHioDwzhn7WN1aGnb0xwkyLzoxwgjNMi9To3uwUxCk7cl5w2wQQVQVgjIIS5tBK0yrBtxeIypQcVfUESXleIOHgI5AXzC3Oe7Cro0Xk+hJhGKRd7uzQeA0VE2JfTEwdVA=
Received: from BLAPR03CA0094.namprd03.prod.outlook.com (2603:10b6:208:32a::9)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:07:57 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::78) by BLAPR03CA0094.outlook.office365.com
 (2603:10b6:208:32a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 18:07:57 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 13:07:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 11/11] drm/amdgpu: Add scratch records to WAIT_EVENT
Date: Tue, 21 Apr 2026 23:36:27 +0530
Message-ID: <20260421180627.2402093-12-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
References: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1af80a-0605-4f0b-2c7b-08de9fd0eab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YARj4idcUL4y6jhpB5S9D4csluVJAFROwWreDToW3/AvZ/jQ3CRA4i8uJCK4H3Wp678Y12DVJKO9FsQqdpyqj8OygS72v26R3PVoUDW5WEAS8KrfE88s8Iunf6DAipzT2rzwTv3Qb9dvCICHPXROfqO74NerEAq8l/Jqa7XjheG/4n8Vz7pY/k8MamuQ/1hQuf2jGLIVZlLqfg0/fsG5HU3HhLT3HO5xvU6wXXviVbEkPcaFSbTjHgYYFR8FaXkO2eNmEr30f2Sdx+av8ZTUyJnq9bez15sMAECXfl5RJ9TA1h/T1xDabjcpd0J1g9rQpz0707N8kdKWbqwkwH7IwAEWomsS9VXadiXC0CKkbroWvdofK1WGmPfe7pJ/MQMEcwUi/dRvIz26yMwO/7IrZlHRh9OuoXGf1GsD+Ot+U+QlonWvQkRgYAQRyaB8N46E4uBTxU+sctqhBZb9iKumu7fKopGv2Pw/7VlrnpPq1ZJ2DHW+2MDvCgPpqaGI1LX8HVCvzUfaXgYtO/91QddnSWzNF291rF7J0rWNwMadx1IWN/6X3YuJqgEl+Ut3NAr99nQ00CTvnBBZcmAXFpBSOEfrBtSgXteP3UJjqDSiwFSlM0+xmqF19kXYPH6RRdi8fhrO6uMpGmXvlzBNYcpSBwqM3abr4y5v7BNGxlXnObqjN/T9aOjPHglonate8qkmEHzNnh6zL7+2Wu04N+0Q8SsLWmwQkrVM1ZxW/aTgAZIR+CRc55cgvQqrmlXlU7nDDuWDw4V0G/90zHGHCxsW+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V7luvPgnnUPBf+EmQ+4t3u2Tgy7a8WO1+zXv50QNXD9jBL+JYuB8Wds3uZN04qyX3r6F8CWjZFN/shJBgnz9muE33jWI66de/tDxJGrsjdX8ny/ZTDE0EaKQhZI7jQ0mKp0WOOwgShNJHYLTRYcoYXE3bEISW0vEUTfQHN6QyHxVe+p4qk85mHrUtvnr9B6Na2HzNwNu+AydEPFTfGqcPUbuRRwNKjrYsGTXRDElLIeD5JzYk29zoQ/Ui8QkBxnLHQOLDMwOdwxx/2+cW8lKwLkQ0MXUl+C+KZu17x/V3ISIbp/xcMG+A4mrlSQucdL3+PmgbD7lVgPp1904ZTzCW10mHo2/DUb93Yu817Gy1yDgpvZvSyJ/xz1FHhfjn+09eqSC6mC0GdCwk+Xt/pcNa54TeG6X6SgZq4Vic+HoGr08BJkCAzp+jMkV15Kh1joC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:07:57.2368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1af80a-0605-4f0b-2c7b-08de9fd0eab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
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

Queue scratch/runtime error records into the WAIT_EVENT path.

The INVALID_VA queue state is set when user queue restore finds that
required VA mappings are no longer present. Reuse this point to emit
a WAIT_EVENT scratch record.

The queue doorbell index is used as the queue identifier.

Changes in v5:
- Use queue->qid instead of doorbell_index for queue-scoped event
  handling (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6fb656f42690..7b60974638e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1025,9 +1025,9 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret = 0, r;
 
-
-	if (amdgpu_bo_reserve(vm->root.bo, false))
-		return false;
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
 
 	mutex_lock(&uq_mgr->userq_mutex);
 	/* Resume all the queues for this process */
@@ -1045,6 +1045,16 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 					DRM_AMDGPU_EVENT_TYPE_SCRATCH,
 					queue->qid);
 
+			if (queue->userq_mgr &&
+			    queue->userq_mgr->wait_event_mgr)
+				amdgpu_wait_event_push_scratch(
+					queue->userq_mgr->wait_event_mgr,
+					queue->qid,
+					0, /* error_code */
+					0, /* requested_bytes */
+					0  /* available_bytes */
+				);
+
 			continue;
 		}
 
-- 
2.34.1

