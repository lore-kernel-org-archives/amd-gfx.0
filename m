Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33563C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBFC10F0D9;
	Wed, 15 Jul 2026 14:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2wN9r7xx";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA9810F0DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIPiz61TiGny2+L2PyA7VENSp0DWn4TRimaqs+MuxqvcDqC2JC63jDj8wk9VJ6UQ5xKbJM4stBN6q3aw5ClV8zVaQ/Ocq/WeWURIM3ei7S4xbEJyhRjEcy0TFO7O/LShYz9IM6Uk4vqKnJJgSP6hgKUSy7+lXMaT3W0K9zJuy4pxbECAOH1u35jzVbgUxMUvV/90gJwmXQVpwCbH3Sgh3QEXvjYmLfSmnuSl7sti564MAhkDMkifTeQakCFwbFJRYRMovE177JYNRPQQn7MWGmVtjuLgElTCFuwbvIYjFbNPIaABMEepwPkvCuzMKRf+YoNEkvPSvxuM2FJfFjlfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEZAP6ONZUYplgS6ERUyv5HIKaXpjmq3r1xwQrGqsIw=;
 b=PRRDrLK63CIsdZzDQUA/q1UWgqjp1WLsDAmSt/jDxCMaXz3nAr0I6tdKUYbVbJrAtfoEXW0q57MCgoDo3xvZh/CUCc9ZEoU8EPUrhgvSPnmN/fIT4ZRZDU+H7LxmgOfib3Rt7SIt1b9arX2N/ECkLuNDyx0OiztL/odG6g0SbioeLsG4ZT+FH2BSI4RIoKbZa1SR+RoMJEKVL1xOcHBomRh8iJ2znQYLadBVC//lvtMEoCKSpatGl/ioQDoVzYqeBJjcxrU/lErWORsV9I2dZ/xh7gVeCMk9b6Pd2PypuOuIK9ekeK5jJ6q6mqwwnOyPS8R1ZlRa2tv5VJzadbSNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEZAP6ONZUYplgS6ERUyv5HIKaXpjmq3r1xwQrGqsIw=;
 b=2wN9r7xxVIv/qGqX6D2FEeZeRf02hk/qbLhfljflgabykH+ZsSngnjNMzuIIdPhO5NUmlqRL9MJzH/KDumEE5NlVNv0YxSttXCgvBDV8q9xlkLpSlSk1L+trOkGBaWSNM1BkW5Teh5Xjk+IuU+FO27QlgLTXBF9m+LOiy6n50rc=
Received: from SJ0PR03CA0089.namprd03.prod.outlook.com (2603:10b6:a03:331::34)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 14:26:04 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::1a) by SJ0PR03CA0089.outlook.office365.com
 (2603:10b6:a03:331::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 14:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:26:03 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 09:26:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v11 3/5] drm/amdgpu: Remove queue-scoped WAIT_EVENT records on
 queue teardown
Date: Wed, 15 Jul 2026 19:55:40 +0530
Message-ID: <20260715142542.3475265-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715142542.3475265-1-srinivasan.shanmugam@amd.com>
References: <20260715142542.3475265-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d265e01-d4e2-488d-4671-08dee27d0070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zteZLQ04yPQPkLIF9w1GebJn4uiPiVw3s5+kPYsCjCdEMougNK6W1bsB2yes+n9LchX8pHL+NtoGT07VyxNu19scvrHR23z3XyiDZyJGeePbRPro2XkXVVEHyV7FSRSLA2Jlj20GHyfAzR8bUV8GQccRNVVSkJ2H+xcUfDSPAO8z5hUDELMxxRx8htzXrLrMiQ2Kod3w3M51XDzbNBBKznVZTP/vUqt1kyImgApKRMrwTkuPcUK4SIvx6MGdMPOCtbEuj6PAkCkh77jXdC8zvdDNSSwkwfwvCGzQSzKJJhCPSEM5Blb36V/xjpH6Qk9zAZQ6DZztRmiFSkcnbHEd57CGqhMG+rmNkvwLkamw2cFuMjmd02UDOo9mwKOcVr3DE55lvVv0tmKqnE7K1BfEPhS5lakIvTdc2AhLWLQK+5mGt1LvrdvuVscC4UPN4VHZJNkmbNjEk5XRZ5LAAG/SIxCQNND8RjnPeFv3O1iflQ+7uE0a0mSNPf3bHvbutYUjMp7ML5Ql/Q6NtLfQdTysGin8gfw8Qyeo5OcB9LagJuvxgeNMw7IxSJGK6ChXcgVIOcUeoajolszZ1Ob6g6XerIkTwCucZoqrLbpq2mQS0reKvNWK5k63WXOoCTYs/xj4/jxopBbVjncWmSdkac0oJs2+oAm1cYkuO7PGZJUbuj7JOGSPHgXuPZ0Mfv1a1KnqlJCxBZ2TkDC9g2odgMSOuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RfGriKAZf+YlrbqPm7GznIwg7vN/UyrzdkcvRiSHkoF1t1EKKCkD8YCSccja42e+Na5whR8g6CPThpN5DiodU7+kNWoBs1ceviTzKQJDIKJszCjOIEBYP+ugtV0Jme2DxWUNChN8hyefhS+uJKJo+gk9yyElXELnIVzAOuGvbx/tJQRBu2s9nDrUtLSpI/pCCqUZpUbI46xilcZZcJ9cAi7DGVVbNa3IGyv/FCxGfp6Zc4L7QTWJj+5jL7CoMkVez2Ucc2k6zdr8M2imzfyYkCAnL9rp/Y5UBer5ITrZXApp6BLXDP5+OsHy+hilKILl/eVUfqOGjmcroaxGbMbqiQlrMQBbPCLrKOdR4LwKfMIwMaq4eOJ6GCwqghVQg8P0mi5kEbqFcTRZy7tFMWFPZxB+rWwRzKcvCCL2osv0Fv2y9x+NUrkBJbbFPPP2fEjh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:26:03.7954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d265e01-d4e2-488d-4671-08dee27d0070
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
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

Pending WAIT_EVENT records for queue-scoped events store queue pointers
and own queue references while queued.

Remove all WAIT_EVENT records associated with a user queue before USERQ
drops its queue reference during queue teardown. This mirrors the
EVENTFD queue cleanup path and prevents pending records from keeping
stale queue state after the queue is removed from USERQ ownership.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cc30e07a4aa4..db97cd42e81a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -56,6 +56,24 @@ amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr)
 	return &fpriv->eventfd_mgr;
 }
 
+/*
+ * Get the per-file wait-event manager associated with this userq manager.
+ */
+struct amdgpu_wait_event_mgr *
+amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr)
+{
+	struct amdgpu_fpriv *fpriv;
+
+	if (WARN_ON(!userq_mgr || !userq_mgr->file))
+		return NULL;
+
+	fpriv = userq_mgr->file->driver_priv;
+	if (WARN_ON(!fpriv))
+		return NULL;
+
+	return &fpriv->wait_event_mgr;
+}
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
@@ -1050,6 +1068,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 			return -ENOENT;
 
 		amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queue);
+		amdgpu_wait_event_remove_queue(&fpriv->wait_event_mgr, queue);
 
 		amdgpu_userq_put(queue);
 		break;
@@ -1436,6 +1455,8 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 		amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(userq_mgr),
 					    queue);
+		amdgpu_wait_event_remove_queue(amdgpu_userq_wait_event_mgr(userq_mgr),
+					       queue);
 
 		amdgpu_userq_put(queue);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index fa4df8d135eb..babee989a9d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -203,4 +203,6 @@ int amdgpu_userq_input_cwsr_params_validate(
 	struct amdgpu_cwsr_params *cwsr_params);
 struct amdgpu_eventfd_mgr *
 amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
+struct amdgpu_wait_event_mgr *
+amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr);
 #endif
-- 
2.34.1

