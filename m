Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B05BC624D3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B62510F1B9;
	Wed,  2 Sep 2026 12:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IGGji3gN";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011047.outbound.protection.outlook.com
 [40.93.194.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F0F10F1B3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWZTNdWvA7TG2Sr3am/wLavvwKmgf8kU2AKIJeY/FJAVto4y1y0YNxXOoPxHBP5e1ufQJUQZle5nudzPJ1BIT39JjaTuDCas0U6O1IDHp64052gVP7cL5bWa7fPhB3DZ6DmkPl6oXS7DYk+jkzqsKmSeuck2hQUJDJD2UDqqgNlUjuHsfltyq0w5WM01UvXYd6Jksi0MCRwXXcnB0IQ/rf1e3xofVWK9vWasUBWaP7acsqWmLgi1O3f5NEhjh1jay8GSy5JHo4FYD0JLY5hRN8jdcBFeRmQPYTgwp2lrVt9xw4oHyy3vPcLdFIGm2HhCLhNQRaJ1lnOjLDixv6lL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x31wRvHvVBAHqbPjrhEHbuwXa1zVfz3XTILZEfsEhyc=;
 b=g75un4FIeAqZN10NF+CQp/R+64x5R3ugJp3ajS7odrx+Vfm1JPkw332RFDeSBTxWpRKOBXtfT6M72PRbo93ap1bnuGROS6XEdh63AqppiunCltuXnqWoBj+5pzQ0hZPx7kAFbcZz9s/PfV4EbHnClQJNbUCW8W7bUiLkeBx6lUKreDNIVNvim8+kLP4mHihkOOu5O6x+UevWKKaEocfEKnfwTn5Cytg2Uzi3V0APr0Ou0IZCN5h8Lj5dNAUgB28PeToK0nbz7bs0nbxz65wMecRqYhe5Gtlds3bb4eao88iGhuzI7wbIpwTItBvyuImfOJ9cEaVLvDO9M1/z/JysFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x31wRvHvVBAHqbPjrhEHbuwXa1zVfz3XTILZEfsEhyc=;
 b=IGGji3gNTu7LKzTTQUCdKlAk4qZ+47l01JJlkuJarbMtKu0aETgAYd8Ur3ti4DKN+DqCsIFqS8FOeFhUI7+l1Bg5H25niic4215Th+shlfkn31599HA+V2Q0nDRrbL5TQHaOfYuW1kpRyGEnLw2CL3/Cwa776iZR3GLv5ozi1r8=
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:50:31 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::26) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 12:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:31 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:29 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 12/18] drm/amdgpu: don't block wait gpu reset whthin userq lock
Date: Wed, 2 Sep 2026 20:49:55 +0800
Message-ID: <20260902125001.621629-12-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: de97583a-e84e-42df-b2ec-08df08f0c5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qLSCuKoTXLGfxUKdYS/p4aZnPw7fSf2WiW1OP44dyDjGGzwJfpleldXViTuNs2EDQ6tyM4cHIB8ZgGR4ugCgZ9C7TcaMdBcFfaIISt9H5pMOX/VetG/A7MgBgvonvM1/iEXfrGEpKCjNFXvMBM7KD/0RUMzl1sLwejQX9N0AP0W1qKxIwSr8CTRe7rEfS3DsPqJdOpkKUbpyojEFWEzh1UtD0jAEjX7RWTgTGWPb7U20T4F9yv7nvyLIlqsyS97fD9cB1Y8EuOvhaBwl0EnACsNbmkUT6EdlBMVUPz6VdrCtHhOM5zQdf8+0fUO8ExWXkL+TFMm/Z8VVzE0px2jYuR1OQA/r8zmzaIbPwevhGfU2ygr4hxmBNLbFnVipYUlZmctsMG95tQUkIu5WLF2+K2TaOKlvvEAH/QEOMnPXsZcznPJv1g7L8lKlagvGbFIe0B7fVP2FOuG6FU/vmSuAlpQCBrSKfMVQ7rt8YLxJZvlz47pZBhrs6jguj4mnQ4QzGocAg/n+f01ITOkCzQZbQ/Y48cOE1y4Yu4pxDY1N2Rm70TGQp1QRLLt8n12pBVmLCHTyHpFjcj/TKkjtSvLkMvwq2UnJ8PnlIl4T45VU52vFRecVMsG/aAvRuqypCD+OthJJT+fSZtyFEYbsflzDyJLQlRJ92DW6NFuIEQZKT/EvGmxxgfgAWvaVNJrP/FTahR/0AyiUz96ihZy1hC3bVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k/oXHuCGqx3opD/ZmWSA02aKdFRIuCaSlYVbumA8cyP9h+Yfj6jsSarF/hhJH1ht+djerC7dw6mKJFdV3txPtv9lN1dZmp5SzjzbNfOD9TY6bipN+8FEG621R5SoV4h46lmtytkGE8GuFyTYWTQzZ1Dvx4aKNv0una9W0AlgClajwkn0oWZMQjX/UB8MNHF5HP1RIS/2TVPvEjWNfaA7TLOx5j1XdSZo/15V7sX/C1mpPGyJiTKpxflkLNZM0nhnIJLGYXd1OwHLPiG7UvOxBZXk1XQ8ncg1NpwYjDSHJtpOCd7l32NKcwViso0AlbnAH9+N7KwXOp5KTsHkCEDTwvmC/GuC0gdHOa13qEXHJ+c1tFQIR/4LeetA65zVp1TaF+B7jWwov4wmVg8KPVNBynn3rehxBka1cafdWG1GPJyz04OiFlCW09bEXOx93y9k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:31.1427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de97583a-e84e-42df-b2ec-08df08f0c5bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
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

The offending edge was code that did a blocking
down_read(&adev->reset_domain->sem) as following, while
holding userq_mutex. Since GPU recovery takes reset_domain
->sem for write and then transitively acquires userq_mutex,
the reverse ordering could deadlock.

.569196]
               other info that might help us debug this:

[  307.569516] Chain exists of:
                 &adev->firmware.mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem

[  307.570011]  Possible unsafe locking scenario:

[  307.570250]        CPU0                    CPU1
[  307.570438]        ----                    ----
[  307.570624]   lock(&reset_domain->sem);
[  307.570785]                                lock(&userq_mgr->userq_mutex);
[  307.571061]                                lock(&reset_domain->sem);
[  307.571320]   lock(&adev->firmware.mutex);
[  307.571491]
                *** DEADLOCK ***

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 51 ++++++++++++++++++++---
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2534e4a1a530..a7d5ca741a3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -422,9 +422,12 @@ static void amdgpu_userq_detach_doorbell(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = queue->userq_mgr->adev;
 
-	down_read(&adev->reset_domain->sem);
+	/*
+	 * The caller serializes doorbell removal against an in-progress GPU
+	 * reset by holding adev->reset_domain->sem for read.
+	 */
+	lockdep_assert_held_read(&adev->reset_domain->sem);
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
-	up_read(&adev->reset_domain->sem);
 }
 
 /**
@@ -544,11 +547,34 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
 
+	/*
+	 * Cancel hang detection before serializing against a GPU reset. Hang
+	 * detection triggers recovery, which takes reset_domain->sem for write,
+	 * so it must not be canceled while that semaphore is held for read.
+	 * A reset IRQ can restart hang detection, so this is repeated on retry.
+	 */
+	cancel_delayed_work_sync(&queue->hang_detect_work);
+retry:
 	mutex_lock(&uq_mgr->userq_mutex);
 	amdgpu_userq_wait_for_last_fence(queue);
 
+	/*
+	 * Serialize queue teardown (doorbell detach and MES unmap) against an
+	 * in-progress GPU reset. Do not block on the reset semaphore while
+	 * holding userq_mutex: recovery takes the semaphore for write and then
+	 * (transitively) userq_mutex, so blocking here would invert that order
+	 * and deadlock. If the trylock fails, drop userq_mutex, wait for
+	 * recovery to finish, and retry.
+	 */
+	if (!down_read_trylock(&adev->reset_domain->sem)) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+
+		down_read(&adev->reset_domain->sem);
+		up_read(&adev->reset_domain->sem);
+		goto retry;
+	}
+
 	amdgpu_userq_detach_doorbell(queue);
-	cancel_delayed_work_sync(&queue->hang_detect_work);
 
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
@@ -557,6 +583,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 	amdgpu_userq_fence_driver_free(queue);
 	queue->fence_drv = NULL;
+	up_read(&adev->reset_domain->sem);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	/*
@@ -734,16 +761,28 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (r)
 		goto clean_mqd;
 
+map_retry:
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	/* don't map the queue if scheduling is halted */
 	if (!adev->userq_halt_for_enforce_isolation ||
 	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
 	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
-		/* Serialize the map against an in-progress GPU reset (MES is
-		 * unresponsive during recovery), matching amdgpu_userq_detach_doorbell().
+		/*
+		 * Serialize the map against an in-progress GPU reset (MES is
+		 * unresponsive during recovery). Do not block on the reset
+		 * semaphore while holding userq_mutex: recovery takes the
+		 * semaphore for write and then (transitively) userq_mutex, so
+		 * blocking here would invert that order and deadlock. If the
+		 * trylock fails, drop userq_mutex, wait for recovery, and retry.
 		 */
-		down_read(&adev->reset_domain->sem);
+		if (!down_read_trylock(&adev->reset_domain->sem)) {
+			mutex_unlock(&uq_mgr->userq_mutex);
+
+			down_read(&adev->reset_domain->sem);
+			up_read(&adev->reset_domain->sem);
+			goto map_retry;
+		}
 		r = amdgpu_userq_map_helper(queue);
 		up_read(&adev->reset_domain->sem);
 		if (r) {
-- 
2.34.1

