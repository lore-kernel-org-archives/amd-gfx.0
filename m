Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544CAC369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F2DB10E396;
	Thu, 10 Apr 2025 18:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="12onvs9N";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E8E10E390
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAzTWJLB0ZJ2yuUFWS3W18r0padXLLImGR4LsfKlu26QkcrhdUEhoPI4umGXBSM/ne5J/8VN31N2em7RnVyi7zegRqqpJHohqSllsDNNbnG5jBglIPH39E4GpAMOrMlMg4G9Gtavv6vrawpoyimRlVGG0XYRiSjyZZUZ1KNdcSbK9IGDRNu6grEvkXD9RFByFnSgOYPNGdGXOfU/KSkDLU80rn1lX+iL8QE4ckWZQ4WaSopaz/lZOLRDg2rCTy8QUx41V60mO21lt/Lm4MKv8s5hVy5R+5oGtrFhEu4TR4q41wtaRKpsIw0HvwL/ItYHKRl3YEDW2+DdhLxnj5hkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQRijLcnZK6lGJs201gmVOVGpGxjj6R1TMo+zFcRXq0=;
 b=MiSvF1tXxjepioW15axivWiCmYDQq0JUZMlGnVfvfuZk/FbWHRB8xGKRldDAKNRgrPngzbRFsl+6zq8JLX3Ubp+2vthgJ3PwO6NJrIGhPDD53j9ZT8upLaIjaOi0B4N+giwtrDaINb4WJ+zpZqci6dUd5jvn+ZjcXYZ7bU8t8sMs3XgnL1R3vOj5FditNYAOo2BVpSZKhxiV6SzFOVamLPOpyGQUvLl2CildbSJur1JJX5MK5NxTrWXhbbH4qPyf02c6dXWJ+Jkrv4Y4JtayXjWPZjLQO86C9p0WLS1SawEIsuJO8sH7gt1BmarA1D4Xeq+k9fZzbUfY94EgZLyvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQRijLcnZK6lGJs201gmVOVGpGxjj6R1TMo+zFcRXq0=;
 b=12onvs9NGsXyOvtJRmmruqSS+ZBJ5KTfAALhGYfK6F3oLI/6HhRko43qEzi9Yi4lgU4VY8Ys+7QUZ5GhHwDceNJ3qXh4Tin/l6uSJtNeSSP1nR4kFmWfU+uwxT1mWnxY5k9/XHFPSO4g1VfQwgk8oYkjZzrTnt9VvxabHLgWdns=
Received: from BN0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:e7::12)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 18:54:18 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::70) by BN0PR03CA0037.outlook.office365.com
 (2603:10b6:408:e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Thu,
 10 Apr 2025 18:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/13] drm/amdgpu/userq: enable support for queue priorities
Date: Thu, 10 Apr 2025 14:53:56 -0400
Message-ID: <20250410185402.2352109-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410185402.2352109-1-alexander.deucher@amd.com>
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: a88c37d8-ecd7-46f5-0069-08dd7861190d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oqcAFV6FRad6eJAJDxOSgZYwoK+RcfcY42hSGB0tOq2p8d21s+7A28ao+Cp5?=
 =?us-ascii?Q?x6XWDijAiTA3Ap7Qaaryw8ukmgJgoxTX7cnF9UgRiTy3cYuskbW61+vcUgDp?=
 =?us-ascii?Q?Fs7QMcKIVEoA+85ttyWFWX42odYW10XxANtsfkmm7/mOWTF6ndOUrMqgEZNE?=
 =?us-ascii?Q?o/cmHAv8fGEGyp+iHlX5J2ivdLsV+x6TqeisTH1oNElYdzpqbrMJ62hHebe+?=
 =?us-ascii?Q?5+fi5ViylWixUKYoz+EbcYj/ZFw3tW6kb1iezDglnS2UguRy7dSx5fRsmW7v?=
 =?us-ascii?Q?BwpnVHyPGty22m6uCZWTwhQidL9u6Pxk7RvsHq+dov3x78MXanL8WMSW+sBV?=
 =?us-ascii?Q?kyJ6qVcDkkOcCJzH1sqRLuvQBqWDT9XoJu1zG+uexDaJgQgySPPCEDlyo8Wu?=
 =?us-ascii?Q?Rma6bMbrryfIyCX3mqBoZMNKnY5E9szTKOBBIVoRbUIp1I2Zh63Ze/P7tqie?=
 =?us-ascii?Q?byHp4ZDJgJgWqf4TaN/F0xCk1YpwZGhSviUfPlNNi/TxZfCP9ugmldJOp0vC?=
 =?us-ascii?Q?JZ1jc1bBI4VN9sppb8dOCskPkoNqbba/07L46MY8Pb9yoivF+w04CRC4847f?=
 =?us-ascii?Q?UHkImr6YDlrp3pi3EWFdXlDfNreLy365jDNOSHLF2Md8DK0AZBNhnJ/OJAYp?=
 =?us-ascii?Q?9B8CTnCi0QXaogga0NGN9lLGrl/aJoeBE6iEpu4taJxoF5dWgOnv+nFHPInc?=
 =?us-ascii?Q?u4DozuMHaIuYoD4lvvTN66Q0/hEWBFdcl7nJhm7v0ARXNziUJO7u8q7GLVbO?=
 =?us-ascii?Q?MYCq4Kw8T0wMyLoK5cgrnWLVioYmmBCx1T05NU+icQPpzxQ2+XSU44+If72C?=
 =?us-ascii?Q?txJjW7tiA7gQe1877iUq/IkR1ig/GeZBlYqBbGvSmhOiJjItomnf7RSrGo6Y?=
 =?us-ascii?Q?0egD5UMgZmvwW8+I5/4NgN6M/uSxcO05080COb7BzOD/ueve+4nfD6W9biZW?=
 =?us-ascii?Q?CNMri6VVy3CVVVteYmySQlWZI8coKexgC+sIiBfxXrkS5UYkQw03E/yaQfXp?=
 =?us-ascii?Q?qQNxavl1mqQttxZ3u5NKeAYc/qhlBEaTSS1n7ULTX4e9cMXRVmk7aXU2Nfdw?=
 =?us-ascii?Q?J4l47IPn/zaIbXLPKq4/YNVCnLoJmyaQGons4b65qbpp8MS9Ue+bGqmqBagv?=
 =?us-ascii?Q?H5JSYS8hOyGPUJWpolUl3Tql4eMdHNXCSu6B0h6+eII0H+dbm0WrDmH8BYN3?=
 =?us-ascii?Q?+GpNvo43RMM8t38DQUSxVLbGqN3WjJmmvs+WFwzRnYVlNLkCNw94jYmoTLmJ?=
 =?us-ascii?Q?LTyW7OdrK9QxMFERyTx9cPZr/0BO7uWBwXeJ1ewnnbF0BTXlUxN0iOscU4kR?=
 =?us-ascii?Q?b0sehcZj6vkgF0/4JRy7/fssFQdukRrwt0eqNJqcIZLzTEtQbzO/W2GO24QI?=
 =?us-ascii?Q?wNYKUbYbTMxnknJce/Q2QSZopnVge1+kJbuP/TcEdPPmw2XBoxG974TL5Tu4?=
 =?us-ascii?Q?J3ec/8B6bV0y79n/F4TETbZ8i/Nbyeq1MRaZs7Ks8VlDx/h4HL8R2zV+e5r4?=
 =?us-ascii?Q?mc9ciTjPZo7fis8Cqw9jwSnQrTcUxG3V0D+o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:18.3498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a88c37d8-ecd7-46f5-0069-08dd7861190d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
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

Enable users to create queues at different priority levels.
The highest level is restricted to drm master.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 57a4ef64e0b8b..b8b13b6ab4631 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -22,6 +22,7 @@
  *
  */
 
+#include <drm/drm_auth.h>
 #include <drm/drm_exec.h>
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
@@ -260,6 +261,21 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 	return r;
 }
 
+static int amdgpu_userq_priority_permit(struct drm_file *filp,
+					int priority)
+{
+	if (priority < AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
+		return 0;
+
+	if (capable(CAP_SYS_NICE))
+		return 0;
+
+	if (drm_is_current_master(filp))
+		return 0;
+
+	return -EACCES;
+}
+
 static int
 amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
@@ -271,6 +287,9 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	struct amdgpu_db_info db_info;
 	uint64_t index;
 	int qid, r = 0;
+	int priority =
+		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
+		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
 
 	/* Usermode queues are only supported for GFX IP as of now */
 	if (args->in.ip_type != AMDGPU_HW_IP_GFX &&
@@ -280,6 +299,10 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		return -EINVAL;
 	}
 
+	r = amdgpu_userq_priority_permit(filp, priority);
+	if (r)
+		return r;
+
 	/*
 	 * There could be a situation that we are creating a new queue while
 	 * the other queues under this UQ_mgr are suspended. So if there is any
@@ -305,6 +328,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->doorbell_handle = args->in.doorbell_handle;
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
+	queue->priority = priority;
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -377,7 +401,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
 	switch (args->in.op) {
 	case AMDGPU_USERQ_OP_CREATE:
-		if (args->in.flags)
+		if (args->in.flags & ~AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK)
 			return -EINVAL;
 		r = amdgpu_userqueue_create(filp, args);
 		if (r)
-- 
2.49.0

