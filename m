Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00027ED7B8D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 08:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2E510E37D;
	Tue, 14 Apr 2026 08:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="18lDFyfK";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010027.outbound.protection.outlook.com
 [40.93.198.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A8F410E37D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 08:56:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaiCX/0iCAglevCyWRmBd4aKFcgy6w43Ii6SLXu9bI72GPwV892T5c4XUvwTVeDzDNzFFrvNICml8o8rK29BN1k974sn3jiCvfP5DMgjAyg4PsM/q9yYIhT3flbY7fz0YE/eoMDLLZ1RRLXs7v68PaNSklERvtPGpDkz159RZWw7PZP3mcpgUgsdMfR4/SZSF0i2ggsQWC+tOtfqMfhiM3P3bPJ63ztS5VbOieD3+dsR/XsnlE5z4FCbLDTWEbRyo3MH0NAMstXipdrCuU3W5G0+g2qhfGt4qS9xwJCG/WLzanDohJwuJxKt9RG0vwMgrp0yrmfx2KE7ItT3QJxjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i97NcbWHZGqgnN4gP3EZluZxkvrdFAhjcyV018ltBWg=;
 b=xtgiW0qldcoMVe14yCmeRazsEhkoZ82yWyw7W9SayBcmS9YIIlh4CEtaxCTYGFH7RLVY53/hLuBTYfG9i4lTqpggSc6qB86GQO1j/gFMd0RIUAj0JLYs1/Nuc3hS3N34v7ILzFO7OLVWH6955Zxyn0EWCdes23UnRUHbmkJGY6DpzGa8nnSznXjOkIz/tkj5jdRCUmCKXl/HANjdvtncnteCIlCOSNXXvGzo3guIbbIaSs2BZ2RJxBqFC3MdGI4pEcPD2s5qiJUGzKR8Jkve8YNrl8fnVmDIYznm+FJ5jDe0PsuFR48r2X3Mgb+IAtWc1wV2bK5p8Ek9+HTCchIukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i97NcbWHZGqgnN4gP3EZluZxkvrdFAhjcyV018ltBWg=;
 b=18lDFyfKc5IO5RdfT/8/8F5ZERGBAnu3qfE3jIIndhGtMJ3LFHEdXbltoOHUtPWQze11J+pz08rtnIMpcQXfSS/YDoNbmht9RBTLpbU4XVYBd9eVV1GNxx6dzRVKsyYkl0oEsktHvD4B/NsU9IbtfE1S/n8LeDulm7nrlsgdAvw=
Received: from BL1PR13CA0298.namprd13.prod.outlook.com (2603:10b6:208:2bc::33)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 08:55:54 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::86) by BL1PR13CA0298.outlook.office365.com
 (2603:10b6:208:2bc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 08:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 08:55:52 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 03:55:50 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix userq destroy reservation inversion
Date: Tue, 14 Apr 2026 16:55:37 +0800
Message-ID: <20260414085537.3471717-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414085537.3471717-1-Prike.Liang@amd.com>
References: <20260414085537.3471717-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: f87a27cf-05ea-461b-8db7-08de9a03a226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /FZrwQgWoxPXu/CDdfS2jiUljzjiF630IEmV6SqVbImN5KHGb/S4PEv1NuQzlcKrk0zo0E8azavY2UzPY5PjrOjaXvgaN7aL6rpZoAsNp4aTOVkIiu1/smVsa+/8PaChVKKTIAtvXC3aNComAoEgkLt7+gFcA9xS+v8jK6gHK/CzCHyHA7lH7Ok9iVlKnciPfcWyWOl2+WccJNZVrqsTBB24sHT+ShZAt3V2FSOstY32TXWUe21kpRHieW7nbjg1DBnDk9GkMakZGMQxRN3EXHM2lun2BEaA8av/Vsu8vgD17Oqxk2OJpUT2GwtdThc3ScZPWT73Z5+oxlorBp+wjoMLEdcnwyoP4fL0utquA/UDYnu5TQPMtNoldQAyfusMaCv0sLoWlSsw8nJpZZnPJ2XKv7iiuteXpsYzeRQS8bjUGepSTse2VOEqThrvZTyEHJBVDCY9okoaFl4jxkax4qEiPcttcO5qP3sayY5MG8NP6ymfokOUvZLbC5+3QOVSctZG2skH4q2djISdnf3R6XnH01qZ9jcLyuNTgY7GAdM8WliVvEaIVDgq21knlYQCUtDOj21uLromtMlm9UUx3VjEzc7KhlWG1vo2xCDKe4zy213n8F5lEOyZ5OGC5GachaeRRfIH1RCMlDMDA30ssQJCNth4QHGaEa0/4HcXiZfUVqyDt5+AM3oqv+D8Q2ATaK8hkbw822p4R487CnnjKJLia0YuKY12gnglbN7GBznK3zGIRoEr1l4o/8IWYrZcOEBw/IOOaWh0DxPajhiDuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z0y5azwxNbXRNE9UmuzsvOhC97+PdXegTdIO3PtgbvMkfibLUNw+7TQ42st0GSHpxuyPjYAaBBQJPd0Kh9j65Cdl0x74sXIAqA2mUWUIuj3AOdYzyQBLjSAgnAqqUbwmMCA6ROZh2BfSPYHBVvIYmemSP2QpSz/xPnX8FbEqdlW3t7C3t4Ae+FKl7mXrnbNhx1hTr/FKbrR5fkz9u3NoTV19DhFWhAp0MB88ISZ7b9LNboyv7nTYi6rmps88XkE/04SZQKCd7sjoeo/SVR7dF7TTyNdZVMRCp+9U2qm7WUuB582/N7Fr0zO8yYFDQTQET7Ibf+eJADk+a22TAyVBZxInMQBn/TO4LfLfehDkuVuznyy2ntL0BBcpA3DQ1ed82SA5kprF26O3PM47PblWZB4zkD8PtYSD12QWWzUeEUKh/tedlyI3YZQYzhJjAiQF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 08:55:52.7126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87a27cf-05ea-461b-8db7-08de9a03a226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
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

As queue destroy still reserves and unpins the doorbell and
write-pointer BOs while holding userq_mutex. but the restore
worker takes reservation locks before userq_mutex, so queue
destroy still creates a reservation_ww_class_mutex -> userq_mutex
cycle and can deadlock against amdgpu_userq_restore_worker.

This reservation inversion issue can be fixed by moving the pinned BO
release into amdgpu_userq_cleanup(), which runs after userq_mutex has been
dropped. This keeps queue state updates serialized under userq_mutex while
moving all reservation taking cleanup to the post unlock path.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 28 +++++++++++------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 551426741a7f..3edd74d89f08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -435,6 +435,17 @@ static void amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue
 	dma_fence_wait(f, false);
 }
 
+static void amdgpu_userq_release_pinned_obj(struct amdgpu_userq_obj *userq_obj)
+{
+	if (!userq_obj->obj)
+		return;
+	if (!amdgpu_bo_reserve(userq_obj->obj, true)) {
+		amdgpu_bo_unpin(userq_obj->obj);
+		amdgpu_bo_unreserve(userq_obj->obj);
+	}
+	amdgpu_bo_unref(&userq_obj->obj);
+}
+
 static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
@@ -443,7 +454,8 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 
 	/* Wait for mode-1 reset to complete */
 	down_read(&adev->reset_domain->sem);
-
+	amdgpu_userq_release_pinned_obj(&queue->db_obj);
+	amdgpu_userq_release_pinned_obj(&queue->wptr_obj);
 	/* Drop the userq reference. */
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	uq_funcs->mqd_destroy(queue);
@@ -635,20 +647,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	queue->hang_detect_fence = NULL;
 	amdgpu_userq_wait_for_last_fence(queue);
 
-	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
-	if (!r) {
-		amdgpu_bo_unpin(queue->db_obj.obj);
-		amdgpu_bo_unreserve(queue->db_obj.obj);
-	}
-	amdgpu_bo_unref(&queue->db_obj.obj);
-
-	r = amdgpu_bo_reserve(queue->wptr_obj.obj, true);
-	if (!r) {
-		amdgpu_bo_unpin(queue->wptr_obj.obj);
-		amdgpu_bo_unreserve(queue->wptr_obj.obj);
-	}
-	amdgpu_bo_unref(&queue->wptr_obj.obj);
-
 	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
-- 
2.34.1

