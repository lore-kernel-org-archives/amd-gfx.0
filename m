Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163D8C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 10:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A38510E547;
	Fri, 14 Aug 2026 10:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0xPWd5DS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F0610E547
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 10:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzJOSzwqt6qfK7RXka6WhO7vaJEGh4JrahkuVjpj26m7DJpY+Ttwp7YNJ0QbWYk9pkcqkn519fbbhASycWp3dvR2eKIvXPzPRC0Hk7KBSUBGemuZ28OkO0rBBVI98hrRvg6odkJSC3QKCn98DO7onhwOLA8YcXerFqEhXkmdKEvyydTb+9AtvvHSXCcIAqefklugwEdDhUDgQnet3gk+eZFVY++J/nw5iQbNpfpJPYO33+p5Ayv+kdryALeEVeIpG/293mk6n3Lz8woMsxzvcdVUc6Vqnwo+k5mRgfOGoSTUlL4W69nRssh2CKycubHOrdMJ985Dev0W1QCWM7K4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2KoiJIwO6xFkdHGqVV9arHwAP9qgB+V63yJWMwtGgo=;
 b=OCyBq4sQxB2vDP4e2Sl/3JF0paOu3bpnVnbcQB1UrHTKm9bvsvYgN/8ei5yA+2MJ3Fw20inlPR/jQY/SnPser2w3+EsNSRR+H7g0Lur7zZW2oZiikWgycE75yPCPx6rErjKelIB8j5Y4MwEI0V6YwRgGsD7BZcmx3XfYE7O+ub3vs/yVu1s1CZvGr9eZvdAL9FpaaAOoferzPbnNWqni0wA+15uU2ilkc6mcMT+PUkSCnfmeUliGHBAeI4Mr3wT3nXnjd5uenpIeXmp/WVwkrmO9vUpOZoNFBvggLY3Q90A9sb4SOlk0aebazkEQka9XvPYPE4eyhV5dFXgMt9f50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2KoiJIwO6xFkdHGqVV9arHwAP9qgB+V63yJWMwtGgo=;
 b=0xPWd5DS2/2/DGjKrAyPDu+oZSmi8jOy97ngFECw9PFApxjp34e3EueUf9/EaDwVPBioONGu5Nileu3nJHe2ZsyL4uBLbAVpYlo+gq03t43hlGyYdos0bCAV4NYOz1HHhgyF58SgbepHH/+05WlRcDlpzYNaEtU69ve/+cMKxnc=
Received: from MN0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::18)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 10:30:06 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::2a) by MN0P220CA0024.outlook.office365.com
 (2603:10b6:208:52e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 10:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 10:30:06 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 05:30:02 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] drm/amdgpu: fix hang and race in userq destroy
Date: Fri, 14 Aug 2026 18:30:05 +0800
Message-ID: <20260814103005.9924-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd9e3b2-2b93-484c-ac6a-08def9ef0215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: NBUDinZypkmg1uRPzph3rJJpPt0KWDuuiQTOn7UmtHtEAAvYUjf2g8H+b3eKZgZGZ5/o9H9RCAr08X86Us1Aj0fgMQd/skDsJjISE5parpkEOp247gAHMRK3D3/92JuOS+eBJrOlZ/PKkLEqFoltum+/+eUR6Lqtvo5SZlaa+MJnEWHZFdk4nAW9FzdO7VReCTR9VV0D110IODRxul5EvUgRaPP5aVBFSmAMNmUW1L7yq/2AWNOHRn1J5N2Mw6Gds4I+O7tYD+NvtLUZ7qHIN14t7v7tg2eqNl4uxo2Mo0it56TvmNAqEmmzrq/JG0Hh3p/58BHFN3EyMCsbPqe2SONr1HwqFLcRATjzJlWaL8kPCuRNxWauFfMXtYcfvJ8B35E1laDeIW1OSJJU9us24ZzlxJCQg+RVDnqNXIcA08qoBsCdn45aqYDI+FfBwC5/eIl4/nCUH0Iiaws6X8gWfPFxv237lzBdErHWcY/ZTTrnffbq7ApVa4RQRpMN2eAxCdlXK6zc4F479RU7wQ+xfW18TpWYre4+cI39np1nbtxDxaOznFIsWhqrYS9nlgHpoFffSJWSIPic3RjmuLnD3WuSVre11WmqPEaDOkbm+GKnIVMKd2O/AaFXTSrdo8rW/OV3ED11YLhHKhtEq+U+QS4xxbs4NMXcQzZ6KcTop38wMjL7IG6T0RzYb9zKUlRrLGOe9Lv+ChSHQ072D3y9ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R7Rm8dQPadvxdVB+ioIrlzmsZHU2ydFqhORafnGc/GJEv6rEe9r2e+LwSBu1fx+5nloTbBKrpR/ZjLBeKKs4Z9kj89AO449PYPjhuMPahUq6EdLw+ykhc2hCpJocSBXy2TI++IaFJUpitbgwO2p82thTrlvUpYtmJFH+g0ye13Rc0aS+v4wioUhiDhZYSQvOgdhaAgkLb69O9HQLPaEkmGAjess1iTp8YP7BP4H1yz6TChxMig9/vhzvsK5chWnuNO+vNbYrqKfs1alrSKCIWDFelHJYskAt30X6tSk5fhs8WEVTQf36vJph9hMBihTaynA+UqVHVdHxMcX3ykOhZ1HHhkMYOKH/8Q2bLqn+UyPO2M35oIw6/8T1TOYcoeszL3h39z8tYq1JVKtVunnuHFy6TRYt6/iXUdlZ1YR0cggqsXdBhoE7O/WpEpmrUkQU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 10:30:06.0237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd9e3b2-2b93-484c-ac6a-08def9ef0215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
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

When a queue is hung, the hang_detect_work is the
only way to recover it. However in amdgpu_userq_destroy(),
the hang_detect_work is cancelled too early,
resulting in amdgpu_userq_wait_for_last_fence()
may never return, leaving an uninterruptible dma_fence_wait()
hang there.

To fix this problem, this commit moves the cancelling of
hang_detect_work after amdgpu_userq_wait_for_last_fence(), and it has
to be before the unmap helper, because hang_detect_work resets the
queue, so it races with amdgpu_userq_unmap_helper() for MES operations
and queue state.

This commit splits amdgpu_userq_cleanup() into two parts:

1) amdgpu_userq_detach_doorbell(), which detaches the queue from
userq_doorbell_xa. This has to be called before the cancel, otherwise
the IRQ handlers (for example amdgpu_userq_process_fence_irq)
can re-schedule the hang_detect_work and the cancel is not final.

2) amdgpu_userq_fence_driver_free(), this has to be called after the
unmap helper, because it can release the seq64 slot that the GPU
writes fence values to.

Only one cancel_delayed_work_sync(&queue->hang_detect_work) is needed,
so other redundancies are removed.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 17cc48d87c4d..24adad7be251 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -418,19 +418,12 @@ static void amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue
 	dma_fence_wait(f, false);
 }
 
-static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
+static void amdgpu_userq_detach_doorbell(struct amdgpu_usermode_queue *queue)
 {
-	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
-	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
 
-	/* Wait for mode-1 reset to complete */
 	down_read(&adev->reset_domain->sem);
-
-	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
-	amdgpu_userq_fence_driver_free(queue);
-	queue->fence_drv = NULL;
-
 	up_read(&adev->reset_domain->sem);
 }
 
@@ -551,18 +544,19 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
 
-	/* Cancel any pending hang detection work and cleanup */
-	cancel_delayed_work_sync(&queue->hang_detect_work);
-
 	mutex_lock(&uq_mgr->userq_mutex);
 	amdgpu_userq_wait_for_last_fence(queue);
 
+	amdgpu_userq_detach_doorbell(queue);
+	cancel_delayed_work_sync(&queue->hang_detect_work);
+
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
 #endif
 	r = amdgpu_userq_unmap_helper(queue);
 	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
-	amdgpu_userq_cleanup(queue);
+	amdgpu_userq_fence_driver_free(queue);
+	queue->fence_drv = NULL;
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	/*
@@ -574,7 +568,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	if (r)
 		queue_work(adev->reset_domain->wq, &uq_mgr->reset_work);
 
-	cancel_delayed_work_sync(&queue->hang_detect_work);
 	uq_funcs->mqd_destroy(queue);
 	queue->userq_mgr = NULL;
 
@@ -748,7 +741,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
 	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
 		/* Serialize the map against an in-progress GPU reset (MES is
-		 * unresponsive during recovery), matching amdgpu_userq_cleanup().
+		 * unresponsive during recovery), matching amdgpu_userq_detach_doorbell().
 		 */
 		down_read(&adev->reset_domain->sem);
 		r = amdgpu_userq_map_helper(queue);
-- 
2.53.0

