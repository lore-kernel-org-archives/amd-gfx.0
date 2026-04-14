Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943A5ED7B8D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 08:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CCBC10E282;
	Tue, 14 Apr 2026 08:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="McTnM8ZH";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD12310E282
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 08:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/wOo1+2m7PfK5U/y4q29dbuT3N0YefaCoXqIeazsZwbVX7PyQxFnTFHmGRXIWVPpxO7XIqrdEo7tjEolLxXyJtbXEQ6a3fn9s45tBRQZ6a8u9A9O/w2w5guJTxraCKQkD6AQRHSOJqDyYc8kRbk8qqBLVQXE3wZSL8MZduW+4Yc3uosgZPzGJdFuh8/Rizhue2UJ4CHv/y7KYrEVPiJXlqs80lvodUcxFlIJDQVF0yV+r49VSmottXM/l6pKyqn/5RYRqRUO28Ubnm0tlZG4dtH3MkeKatCShL8H3bIDX8qCcfzQ80E08CFPF+YucfOc10nv+jM0vVoY65V8znlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZTuezTOj/gB0Io4/Oe7P26Zo/b/dk0Y8J1HM4waCf8=;
 b=f+u7uXCrpo6kUX4lW19KC83QqBRNBiSgJINRtFsLkDXYcpAfYlA9j1rgGKjIDHC1ZHKOAPvzb4I1w7f7SrNGuYI+JUqGocXS1xd+q9P+zsTM9XBtsF3/xxh4P+8hX8pqhuSOKrOgb0n7WPB+kkn4oiDJD76hCYKkPWJjGzuRDsmpooPBWk7HN/5bwotpx8oLulvEON6BdhpYnwpDnCd4BOiZEj404ifWExyhZxkSY5gWjLklZRddktWr5rHExBG/fEvPGeoHBD4m0f5nqIXQwqpPk+nGvscBdeBT+Mcj3/etIbHqN6mHMgmVL+58KYc0R3sW0WkxZZT60PwOrSf83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZTuezTOj/gB0Io4/Oe7P26Zo/b/dk0Y8J1HM4waCf8=;
 b=McTnM8ZHafYsqvdIvik0GBWClzsYY+dd6k1iN0i4CkpjHaHWBKKEyu5jHpl5WKqB/OqmjFffuEg36DFg2qi5NWfRq5ZsXVEpfnjZbzswqZR6YDngzNX4fQ4kiauCXVXDKnx1uFoXvXeI/SsSFpGAhlKvz06Rtdbfq/rT+fYah90=
Received: from PH8PR07CA0007.namprd07.prod.outlook.com (2603:10b6:510:2cd::23)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Tue, 14 Apr
 2026 08:55:51 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::3c) by PH8PR07CA0007.outlook.office365.com
 (2603:10b6:510:2cd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 08:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 08:55:50 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 03:55:49 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix userq lock order against reset_domain
Date: Tue, 14 Apr 2026 16:55:36 +0800
Message-ID: <20260414085537.3471717-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: bce5c5fd-4a8c-43bc-d109-08de9a03a0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: s5u0pyJRttuFirXSFyWNbPQeixFAjBCvXH+vIdXhehcNp6PA9X5s1DSjWaB+14/vVtQtJKzrDrFC7+wlAvZZU/OfI8MDVOMldVFnTch6TJwX2xVQSOQMxql1FYuEA7+UMK7CoOBPmIuc+w4I/y5UJoS1yeA3WGMRLT6eWZ8+NoJM4FjEuBsgs61PZGvT8P2fzQkWBUp6oUOUrjA7rOZKcscfOWTD9YpVq/upCvCADKTzIjKkc7mBLK+BnsnoGIgOvP+f8KlzAL98uiDZrUjyUvlylH85Z7nmH7BqBRlsSpJ5V4Bh7J89jGcBzjx05GK6jEW59iDg/egc7Y8qulSMhr0xTfOLhuLt2KT+Vo0BWRDD4C02i0mzvpzo56EVN/rJoJoAznZeD5gDu+Ar8gNQogmsPrQKgv3c4DZISr4vRsxvOvt27/T2ijfHQstefdVG8H1yvMJJH9uUc92mZZTZTWdse1hlcwIq3fhf5YzyGFlxDrgLCTYAR4xo88IWZCI2HHqfzXxszrUVYton4luqRhL0foBVa4CsVMuSL+KrCKVDxVn7RK+wOhLj/dUmzhINzG+sDePNyFYYLNCuPNv/LBHqYpMuDLh7aC3DLykcWBN1krvPiGNE61itGBSQVyxcbWHEGht5k1e+XEdJLfJyUs6y+FBd0X0bj0D+cSN5r0y5gU2DE2lLd0FYmNnlr1c0R2/lBdJc+zP7N+9SaVcrQRqlm0BNbCMNzjFlMvVUkZJ1JYu6rpBUKoRWnCBgbFFLChl9pL7AC1cQlbMJn4FgyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Lm29tK+jfF0veXpqI0m91JjRjYyhVMzUi2siDZQeGaTwN0DBRzXsCZHncRhRsgAfvwWJwZQCY8vC5D5c0UQ2xyCbxBxiWOWCIRRZ179y8xGC3pC/JqcNfh9/FmH706XePi7d9VyogBsOGCeq51GWpzg5TVEOLoQQEMG6Oix0Ghk5zqXHCks9ljS4qbCq7hBSUON9vtDSkUTTny56/GUrJYIYYPa/mGC0oDCqaC/HAXdNuaOIcpKGAb3Xii8OS9NW4l7O28M6cR42sn1Y31eXqvKBWYZyX3f2Az9eE7i5aaaEdL3OGUyq+AHHFvNPp2daWuQcCIesZY+os5ZD+mqAbXX+cl2ZoC643tx4kKiUw5oqwGBfkqdVSOPAIecZab/zeAsPTws8KEv89Sojk3rmhYJDmRwGVr34jsWf4lj3Xh/15MM1GyRlq9pfP2u+//d0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 08:55:50.8188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bce5c5fd-4a8c-43bc-d109-08de9a03a0f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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

User queue restore takes reservation locks before userq_mutex, but the
create and destroy paths can take userq_mutex and then nest
reset_domain->sem under it. Lockdep rightfully reports that as a
possible deadlock against the restore worker and other reservation
users.

Fix this by keeping reset_domain->sem outside the userq_mutex section in
the create path, and by moving queue cleanup out from under userq_mutex
in the destroy path. Remove the queue from the global doorbell lookup
before dropping userq_mutex so IRQ paths cannot access it while teardown
continues.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2408f888c4d9..551426741a7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -447,8 +447,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 	/* Drop the userq reference. */
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	uq_funcs->mqd_destroy(queue);
-	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
-	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
 	amdgpu_userq_fence_driver_free(queue);
 	queue->fence_drv = NULL;
 	queue->userq_mgr = NULL;
@@ -662,8 +660,12 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 	}
-	amdgpu_userq_cleanup(queue);
+	/* Remove the queue from the global doorbell lookup before dropping
+	 * userq_mutex so IRQ paths can't access it while cleanup continues.
+	 */
+	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
 	mutex_unlock(&uq_mgr->userq_mutex);
+	amdgpu_userq_cleanup(queue);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
@@ -799,6 +801,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto clean_fence_driver;
 	}
 
+	/*
+	 * Keep reset_domain->sem outside the userq_mutex section returned by
+	 * amdgpu_userq_ensure_ev_fence(). Restore acquires reservation locks
+	 * before userq_mutex, so taking reset_domain->sem after userq_mutex
+	 * would invert the established order and trigger lockdep.
+	 */
+	down_read(&adev->reset_domain->sem);
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	/* don't map the queue if scheduling is halted */
@@ -812,16 +821,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
-			goto clean_mqd;
+			goto clean_reset_domain;
 		}
 	}
 
 	/* drop this refcount during queue destroy */
 	kref_init(&queue->refcount);
 
-	/* Wait for mode-1 reset to complete */
-	down_read(&adev->reset_domain->sem);
-
 	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
 		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
 	if (r) {
@@ -850,7 +856,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 clean_reset_domain:
 	up_read(&adev->reset_domain->sem);
-clean_mqd:
 	mutex_unlock(&uq_mgr->userq_mutex);
 	uq_funcs->mqd_destroy(queue);
 clean_fence_driver:
-- 
2.34.1

