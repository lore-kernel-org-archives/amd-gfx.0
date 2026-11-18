Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D975606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eBnUquKP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2392D10E05B;
	Wed, 18 Nov 2026 05:50:30 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8061110E05B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 05:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLR80p+33L9OcrzcziE0xuNml1mCLJ2d4amtLvT67CwZDzgKipgdxO0jCytBe19xn2o9NbjRN9+SkGpiNyJTxG6mqeetHHwQ38UufX4+RlKhfBr4aIO5cJiFCcNLd0gNwKUYGeDFkM8QB/KkVQ2d4jDW6UIY253I1/V8sP/Yy801NfJgqyJOQOGouPIQWFlRId+GnzA91XkoMNcWPqTpkbijHxyX3gn8iDV5lTarjlsTiQBvZprBV0TRWHH4mPRAHAhAChnvkQY8KNLI6kz4gRbbgzjdbrJkgeOqG9Rr8NjoZw7ucXsqgZtXmvVs3tLjQwOisi52HIpqhaazirBnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ5TU+MAfgBi3UQhI7IUo4mSllVVkcUkZ6/2pq5Z/KY=;
 b=HKUSjWWXfaH5a04nuzR5NYxw5L5aPUgHFDdPET/mc3WV5T8BUwL4+Ji1ljK6t9FWSl4xUtaFweYNePmBjmzEbSC5aVoZfA4NUTflehZk1CF/fO08XlI672dDoB54SLfYnCRCj0Hhouln15vAjeAYMWRvxGaWMqewrk2CZSwsBrVQUVMbSiwt9dspWD1eutjyCy1aL4kzZpyjyb/CYoruRC/bDtO+1BAp2/0RrchPB/1Q9dvdudiXcvYPzye6Y2V48zgakrATBpbBwf2lrzEqJw5Uo99y1CdFEWcQl9Fk5ZgkLAzouxEyksnPc+g6duUvdYaAC29fRoExAeWfDXWTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ5TU+MAfgBi3UQhI7IUo4mSllVVkcUkZ6/2pq5Z/KY=;
 b=eBnUquKP/3h+Vqz5Gi44ghUQtq4kHBVKUOJeMc+7B4C81yFfX2s5K+s6d3eE99D1qSbrSwnCbqTsRi8fQhhHkItG2Z2cSRxkplb4TdNjhwxty4mVmaUNTsTbQZT7kLpItgiOETcg5pRq/OTeCclFv4tYECdPfVWjsGsgZGo7u+c=
Received: from MW4PR04CA0163.namprd04.prod.outlook.com (2603:10b6:303:85::18)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:50:19 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::1d) by MW4PR04CA0163.outlook.office365.com
 (2603:10b6:303:85::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 05:50:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 05:50:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 23:50:16 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 23:50:15 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: only flush the TLB of devices whose queues
 got suspended
Date: Wed, 18 Nov 2026 13:49:58 +0800
Message-ID: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc9eae5-9dc5-400b-90b8-08df4537d35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261021135927099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: Djo6WUI5xE2oyfzJkezuTJOZDQrPP9c5Yup/Due4Md1wBNnZj9+hxtLzWs1VfDXfAbGaFOXCrnxJUoI6e+4jszz94K7Uo2lpL2rCHdcRLEyjmpEI2S8Aol/vkdhtf19XFIOD2gLtfZIjpIZggA4otRicus7Nwo+u3PHOFMYcQHsut8OfVzpVMkX3SCX6hwRsesqbNo+h+YpeZmqk+ngljsnnXVF8iErIUgqX5jrbUaicjGcAZEurcj/fWfWKVCqWx4ARFTm0Tb0efH8AYcj0fMvKbfClIACJ23TMY+W+JSWhNFuvprZyL4PqjGtx+KOQaWG+mL0kolQRUmaj1+JCovrqnqP6K08FSv/gJ6qyd28UhR7Q/30jX9p0r5dFTgKAMOlxG9OzRIGpGHC69iW5UFYqBAsdXj7y5RMtJ5r0+L6gmvnrkHPVFs4XunGAWfTr3YFHiUd3gVTrQHGp3UwEOPHHuSUEgnoGBVkkRiempVvtDhjdtyN+s9am9iHjeVplRAuY/6da29IZ+mBGepNPffMyD9qUQ26GoBUAldtvdR9lt5L4QS827oMVLHPbXqZZUvDOKlIZXjS+fOtJILGXky+1G7OQ96JpIPTtH5lfQF8gNIAiqC0byl6gjElJSzfR3yo+9luVM04VYkLzMsVqmJE6SsKlvfGFuxcZaeG/SRtMQ+fUQDzB7BpVCy3f+SlrF9pWfAANpKgk2Q11mLmAcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261021135927099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FotrZiukRWTtuALJsF/myjQ6hayS+THW4k9c2jB4rTRt+bI6e3Rrhs1ap/nRjMm0U9m0WNg8+zErMUOjKEk9FXpxp6qOFQMRicqUoQKO0y7MnQuJKBd6sCbeCQNDzxvMR0y5p6J1f1oerh8KasCF4w/OX9nDkHkNmcYKglE5JUVPuWFhHEoAxTOMR4jTIaRwTyri+qDIeyxX2yZ/50hklu9PZor6tKdxvIQKKZw7RovYKxpYh4zfPe1e/zyfn0diwTAHfBHROv+dK8J7EY6BmYK3YjWl0QOFUqqgOqUJcwIXzm4NwhNyFF+qBMvAqnmXSiJLRrQ36ToKSFZLAq2oMwQ+1EPMPY/GxwyyCY3hPlWrjFWfzhKcUrlNqYixv2DbvlVUhq+Xf1v8LZaFOFwdvrzTB7MhsBY8rMybnG5ZmanqmfuHUGU9oI+RQDOVPKr0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:50:18.0697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc9eae5-9dc5-400b-90b8-08df4537d35c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

suspend_queues() goes through all devices of the process, and on MES does
the debug memory fence and a heavy-weight TLB flush when total_suspended,
the number of queues suspended so far on any device, is non-zero. On a
later device without suspended queues that flushes the TLB of a VM the
process may not even have: kfd_flush_tlb() dereferences pdd->drm_priv,
which is NULL when the process never acquired a VM on that GPU.

That is a process using only one GPU of a system with more, e.g. a dGPU
plus the APU's iGPU, stopped by a debugger. On navi31 with the iGPU,
a debugger suspending a compute queue of a ptraced child that only
acquired the navi31 VM:

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000002f: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
  RIP: 0010:suspend_queues+0x104b/0x1a80 [amdgpu]
  Call Trace:
   kfd_ioctl_set_debug_trap+0x1234/0x1720 [amdgpu]
   kfd_ioctl+0x46a/0xb70 [amdgpu]

and the debugger ends up in D state.

Count the queues MES suspended per device and only fence and flush for
those devices. With that the queue is suspended and resumed (status 0) and
the kfdtest KFDDBGTest tests pass.

Fixes: ff114e705d6a ("drm/amdkfd: Add TLB flush after MES queue eviction/suspension")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b5d7d13f31a5..a50a49d6ed01 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3952,7 +3952,7 @@ int suspend_queues(struct kfd_process *p,
 		struct device *dev = dqm->dev->adev->dev;
 		struct qcm_process_device *qpd = &pdd->qpd;
 		struct queue *q;
-		int r, per_device_suspended = 0;
+		int r, per_device_suspended = 0, mes_suspended = 0;
 
 		mutex_lock(&p->event_mutex);
 		dqm_lock(dqm);
@@ -3974,7 +3974,7 @@ int suspend_queues(struct kfd_process *p,
 							~exception_clear_mask;
 
 					if (is_mes)
-						total_suspended++;
+						mes_suspended++;
 					else
 						per_device_suspended++;
 				} else if (err != -EBUSY) {
@@ -3987,7 +3987,12 @@ int suspend_queues(struct kfd_process *p,
 		if (!per_device_suspended) {
 			dqm_unlock(dqm);
 			mutex_unlock(&p->event_mutex);
-			if (total_suspended) {
+			/*
+			 * Only for the queues of this device, the process may
+			 * not even have a VM on the other devices.
+			 */
+			if (mes_suspended) {
+				total_suspended += mes_suspended;
 				amdgpu_amdkfd_debug_mem_fence(dqm->dev->adev);
 				/* Heavy-weight TLB flush after MES suspends queues */
 				kfd_flush_tlb(pdd);
-- 
2.50.1

