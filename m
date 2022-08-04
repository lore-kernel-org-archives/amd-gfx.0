Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA3EC25B06
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Aug 2022 22:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8D0CA90A9;
	Thu,  4 Aug 2022 22:30:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC83AA2260
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Aug 2022 22:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfgW6Dud5hul9Ev2gj1yOTDjELxjzsdUKJlpLsQZK2o+7g3DWBw5TDqwXKJdeUguy/gkAKPe5eY9NYLl+7jlLJkiNM4Wa8JJM04BDbxl0W8wWg+Rx1/nEhjX1lI+U3cHTtI1Hv5tEgrWrVtXNyhp0AQsT0xh5zoTy8ophp8NfcxaUHvag79JA2c3coXAsGbmgRBjVii0AL3UAV+DU1cuKb7UJbqDoeJbLINBsYkfCUFKWDDNkMH2N7QbhuUhmoJqZioNWqsoD66zxxJAgK+09eKhLphj85T46LNau+uuDUrDLbUnRop/Anfo+v2bgEmWjWc4FdkmNSnzQe5J/cd3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exqzNnvbabdU9ITxrZcLNHAQbWEJBnZ5QjTxOf/8ECs=;
 b=E7yLdwo4Pj2o8QwW7KQs4f4IhVmACigtDCNt5Yq7BeQJCgBirLH6uKOwpUySd7V/z4Cz9TcOYsufGLavDNN3yQS+O67nO+DVzvm9HSZvjHDmzuzVeY4qh5EfcsWpN9TdlJTUP8TKb2mcFMDah7wdsqjkW3+UHnvRN/MQZ3c9XPgHJ36hi8FLgzDrynO3zN6O5mpIuHnisBLP505EFW/A+kdHOSmfBdbZhzmjLNL1NTBh6i5V/ijA58lzzbfeGVvyyZLaZEi8hvGrhLPkkWwkpRaJGVQ+TBz/Tuhe5kvwX2Xb1HNcopaDDqFj8be2Veja4PGgaazLxNpEduYfvAxLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exqzNnvbabdU9ITxrZcLNHAQbWEJBnZ5QjTxOf/8ECs=;
 b=E6yYgV4Cpnh14YHoraXWKHVuVlhXX4RUW5JP//tqQUE9pT12e2dzvv65KLoMsLDyiXCvLpjHeI+B5m1idCx39aZiKlkfa+btGFQr458tFXTGdvOi/ogK7vFTEOkAzE5rGNPahhBuXmjZfPK9QCEgXRzP+uJHvf+bcBFnEXLoBSA=
Received: from MW4PR03CA0243.namprd03.prod.outlook.com (2603:10b6:303:b4::8)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 22:29:46 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::22) by MW4PR03CA0243.outlook.office365.com
 (2603:10b6:303:b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25 via Frontend
 Transport; Thu, 4 Aug 2022 22:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 22:29:46 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 4 Aug
 2022 17:29:44 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Handle restart of kfd_ioctl_wait_events
Date: Thu, 4 Aug 2022 18:29:01 -0400
Message-ID: <20220804222901.134048-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64394c8c-9afc-4261-a044-08da7668d5cb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: De7VUcW8Slsiu4E6H6Z2XVl42LljJJI95veFqloVna65rJlU6kefEQldivQa2zQvslt2k0k+SxNzhbjialnzydM6SXEiNvyHQpA8Y+3tRIJdG07bnad9wq8Qdm+RYvQ/tfMP+Qyw9jPGdtRtuXZ7QWMbufXeWoDB50OBiIa2FC5cnrmRpCnT5LugWuQG0D5mHGjBXqj553gkFfc0f/Ka1dfLXK2RnYYYra1YToHCLPvUP15qCKtTQBSKXpREiTyB3FKXRVlWU4u45ZFPmEKfnOPsAO9WRc4GKHfrawFT4trA4GdAXH7SuknOpnC2k1J6PROKKVleTDtHvSdIWimbvxiweHZaJ3C69EYjEm25YVK+xL4LaRnej618e7GbckN39wFKcdopOw3E96rUYhzJRY3QRG24yk3QfIwTUoPHjxRXJ5RoDFSJ8+ZPAivgSwsEtviium6A9r5dBpgL7K0V1qwr2GyTz/XI/e8t7hJXfvAlrP8ZPo4PLhUZ6sFtphJWk6DoHciYocf8TViVVI0uTn4pyLO2WDeMTaG/whryaH/KkP86tDoi7xwMLtWjPl6o3PQSmSeBI53buvdysl3j3yEp5YHR30NSIU13hvmaTQi/25Ozexk67RcKP6Kso3QrunKt7BcY8zGJ6A25KevAw1Q7SQcarA0wmMa6FIWTlkMX5gvVZ8veU3gzI2SpgxeiqElp+4tVrWP/2C6qCGhzhix3N+kzEZNz+pEKuUwaGX7RaLgKcjLK1VNasDHsHYB4OjfbFgMEPprxXYBehdOValQbIFQkgPMG9Kv+SXRj/CKL/oI2LSupYBjX+TKZNRductHUMj2C++5NA0QegsXITw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(40470700004)(46966006)(36840700001)(41300700001)(478600001)(86362001)(6666004)(26005)(356005)(7696005)(82740400003)(81166007)(336012)(2616005)(426003)(47076005)(1076003)(83380400001)(16526019)(186003)(40460700003)(36860700001)(40480700001)(70206006)(4326008)(82310400005)(8676002)(70586007)(8936002)(5660300002)(2906002)(54906003)(36756003)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 22:29:46.0039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64394c8c-9afc-4261-a044-08da7668d5cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
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
Cc: xiaogang.chen@amd.com, nicholas.curtis@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When kfd_ioctl_wait_events needs to restart due to a signal, we need to
update the timeout to account for the time already elapsed. We also need
to undo auto_reset of events that have signaled already, so that the
restarted ioctl will be able to count those signals again.

This fixes infinite hangs when kfd_ioctl_wait_events is interrupted by a
signal.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c  | 24 ++++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 907f4711abce..664e8b5d82c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -881,7 +881,7 @@ static int kfd_ioctl_wait_events(struct file *filp, struct kfd_process *p,
 	err = kfd_wait_on_events(p, args->num_events,
 			(void __user *)args->events_ptr,
 			(args->wait_for_all != 0),
-			args->timeout, &args->wait_result);
+			&args->timeout, &args->wait_result);
 
 	return err;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 3942a56c28bb..83e3ce9f6049 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -894,7 +894,8 @@ static long user_timeout_to_jiffies(uint32_t user_timeout_ms)
 	return msecs_to_jiffies(user_timeout_ms) + 1;
 }
 
-static void free_waiters(uint32_t num_events, struct kfd_event_waiter *waiters)
+static void free_waiters(uint32_t num_events, struct kfd_event_waiter *waiters,
+			 bool undo_auto_reset)
 {
 	uint32_t i;
 
@@ -903,6 +904,9 @@ static void free_waiters(uint32_t num_events, struct kfd_event_waiter *waiters)
 			spin_lock(&waiters[i].event->lock);
 			remove_wait_queue(&waiters[i].event->wq,
 					  &waiters[i].wait);
+			if (undo_auto_reset && waiters[i].activated &&
+			    waiters[i].event && waiters[i].event->auto_reset)
+				set_event(waiters[i].event);
 			spin_unlock(&waiters[i].event->lock);
 		}
 
@@ -911,7 +915,7 @@ static void free_waiters(uint32_t num_events, struct kfd_event_waiter *waiters)
 
 int kfd_wait_on_events(struct kfd_process *p,
 		       uint32_t num_events, void __user *data,
-		       bool all, uint32_t user_timeout_ms,
+		       bool all, uint32_t *user_timeout_ms,
 		       uint32_t *wait_result)
 {
 	struct kfd_event_data __user *events =
@@ -920,7 +924,7 @@ int kfd_wait_on_events(struct kfd_process *p,
 	int ret = 0;
 
 	struct kfd_event_waiter *event_waiters = NULL;
-	long timeout = user_timeout_to_jiffies(user_timeout_ms);
+	long timeout = user_timeout_to_jiffies(*user_timeout_ms);
 
 	event_waiters = alloc_event_waiters(num_events);
 	if (!event_waiters) {
@@ -970,15 +974,11 @@ int kfd_wait_on_events(struct kfd_process *p,
 		}
 
 		if (signal_pending(current)) {
-			/*
-			 * This is wrong when a nonzero, non-infinite timeout
-			 * is specified. We need to use
-			 * ERESTARTSYS_RESTARTBLOCK, but struct restart_block
-			 * contains a union with data for each user and it's
-			 * in generic kernel code that I don't want to
-			 * touch yet.
-			 */
 			ret = -ERESTARTSYS;
+			if (*user_timeout_ms != KFD_EVENT_TIMEOUT_IMMEDIATE &&
+			    *user_timeout_ms != KFD_EVENT_TIMEOUT_INFINITE)
+				*user_timeout_ms = jiffies_to_msecs(
+					max(0l, timeout-1));
 			break;
 		}
 
@@ -1019,7 +1019,7 @@ int kfd_wait_on_events(struct kfd_process *p,
 					       event_waiters, events);
 
 out_unlock:
-	free_waiters(num_events, event_waiters);
+	free_waiters(num_events, event_waiters, ret == -ERESTARTSYS);
 	mutex_unlock(&p->event_mutex);
 out:
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d03a3b9c9c5d..bf610e3b683b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1317,7 +1317,7 @@ void kfd_event_free_process(struct kfd_process *p);
 int kfd_event_mmap(struct kfd_process *process, struct vm_area_struct *vma);
 int kfd_wait_on_events(struct kfd_process *p,
 		       uint32_t num_events, void __user *data,
-		       bool all, uint32_t user_timeout_ms,
+		       bool all, uint32_t *user_timeout_ms,
 		       uint32_t *wait_result);
 void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 				uint32_t valid_id_bits);
-- 
2.32.0

