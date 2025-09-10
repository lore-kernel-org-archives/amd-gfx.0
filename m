Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C36BCAC583
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 11:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 332B510E8F3;
	Wed, 10 Sep 2025 11:37:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q2Br5DqF";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5ACB10E8F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI0ljm+fn1ZqZ76ElGba9LriydbyPnUf2MEm5i3VnHblrObBn4s2IoqQ2MRWDn3uVsViYOt5ZOKef94QHcL7JbCuLjFRuWLZWRTn4W6Hf8WFQrGOL2U5D9W3ISl3XVx+gjMsBwjcOAGhmv1Dgeo11Uev7N5thmAODAb9StVF6GJYC1MPek1VEPYgqd6C3f2zwvqeFLnA2p6qRHBQPGr7GQ2XNv/1H602e/mfqTw5npVLvmdCpa/scdOi1EFkv27e4BhuEFJE5pYGWz5kReYYP/Q2LoLhrwW/5WSSP1BYu7ZRS4LHduy3UhWOqiZYBNLNwwQnVvrlpu/1HCtBu/PcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE1NiMuriskjwHr4uJ1LdiEsZACcpdUKjwXHIdCwsY0=;
 b=EuG8QPDDlILxknxMiBxJqnbHb7q7vtHN5F+9P4trcevEWHBwW0nRtKkCFFsPXCdeXrT8L+pnhMJ/zHna9aGkA7KS4AhZGhOXD7cSN/bYXxkvu71htvuzH80lKmm5uSKK2E0DLaGJL2DyfTt2bU2te5Hkuz2dz6HIEafdbvxdasWYNVwf5xu4aqtPeBQbht4zfePO34YsOtZjaIGdacOqtIN6UkaMIVlq9ixXC5YCGKiQkrf80x98ZbFimkWqr73PTqUVgzD5ki0dLUZfyBcf3JAN6dZNbR2HGvBccl/w/TD9MynycsBJsRHTjuQ4NjQWP+eMqk0DF9OqlQIiFQQm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE1NiMuriskjwHr4uJ1LdiEsZACcpdUKjwXHIdCwsY0=;
 b=q2Br5DqFYez1lWzmWnU7GgJNWTJpCs1fUUGh74jXMhQQhSnf1LiMnRH6Tw7EnwKuIkga+sDQiz6FCaizMqV47O6cy3TdhqhDUDlRL4eIxUA9X/6Eof5FGQv33LR3454ulgYClY8KuX/DSJYgmvcjffN+1r9CS8C0Q8cDY/EwKmk=
Received: from CH0PR03CA0447.namprd03.prod.outlook.com (2603:10b6:610:10e::24)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:37:55 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::a3) by CH0PR03CA0447.outlook.office365.com
 (2603:10b6:610:10e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 11:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:37:54 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:37:52 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: validate the queue va for resuming the queue
Date: Wed, 10 Sep 2025 19:37:30 +0800
Message-ID: <20250910113731.2688320-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910113731.2688320-1-Prike.Liang@amd.com>
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de71238-5c9e-48c5-5798-08ddf05e7b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVY4aUdRTHhhbDBLQjBKemlkcTVudmNMclhCVXFxeW9mSjk2RmRMaDcwV01X?=
 =?utf-8?B?VEFCcEdDL0pZckk3ajJOVUp5QjZhMm41QTM2TUwySGZIMkswaUQvT21JOGhN?=
 =?utf-8?B?QkhrTHlrb2wvMTNaODlPSkczamNZbmJvN3FkaTNZR2lpUnhIUFRMb1pydVFT?=
 =?utf-8?B?OXg0WUFleUJTSldDcUtjb3lHVGwyQy9WMHNyTStDUjdJRS9kS0IxczNrQURx?=
 =?utf-8?B?UEUxak9WQ09uUERFQUdnckxhZnNibXBnVWRmMmZYQjFFc3pQdzVtcjF2VFZt?=
 =?utf-8?B?aU5sZ3U3dTBwNUZiRGVDYXB3ZmtUbzcveHpkZkxJWEtaaHlsRG4yaHB2TXNn?=
 =?utf-8?B?ZHdjL2Y5d0VpUW0xcEtLcmdXcE4yMTJrZDkvbXJtREFvRmo1bXQyS2hYY0NM?=
 =?utf-8?B?dlRBNjJ4OWRKcVNReHJQQnFZaUFmUEJaMG9JYXRmL3QvU3ZTODczbk1lb1My?=
 =?utf-8?B?dFZHN1FlNmhGdFBMZDRRVVRLT3NmYzl6c2xoU0FtUDZJUFdYRlRYelJTOUxj?=
 =?utf-8?B?T1U5clowWEsya2xKT3JlWVJUSERVclgvYW00RHFnejM5QjVBMS8vWTlrYnMy?=
 =?utf-8?B?VGQ5NlhmVVJjUUptVm85RU5ZV3FyN1FYRjdCcnYxMXpSVlJVMGE1R2pWTEdW?=
 =?utf-8?B?Yi9OZDlvOHVqZ2hqbTlyS2dzYjU0ZVJ6L3paOTA3eUhCV1VmOVRnWGtLZ0pz?=
 =?utf-8?B?cFlFcVlaWDZpZmxXR0R4bWQvZDBkMGI0RHppQkRNcDZuUk1pUG8zZG43T3d4?=
 =?utf-8?B?SHlCYVM5WnhwcjMxdUhPMEhFaUJqZmcxM1BRYm9tc3lQTXhnM1ltYzFPQkdE?=
 =?utf-8?B?SElOUTVmT1NoaVRKeU8zMEF1ZWZYOXFzY3cva1pIT1FWeGRsdDFTaUhFZ2ti?=
 =?utf-8?B?R2JYMkpIZ2FNLzR4U1Mra0Q1YmIxVjVWOU5PRE5mN1NDbCtzU3B1UStEb2JD?=
 =?utf-8?B?b1pTb3g3aU9HZjY4b3htTng2NEZnWWpSNXpTSG9EQkZ5V0FoNWdkdWNvWWVE?=
 =?utf-8?B?RWFVb0JndzB4OFJQeDRuNWRJVHgzWkcyYmRHbHZuY2pWRG1icXBwK0o0WUhU?=
 =?utf-8?B?M09WY3RoYjJxTTdMTFhLK3ZZdnhlWFppTytHV1VYRzI5QlV2ak05QVRxSW9I?=
 =?utf-8?B?ZDJKN2o2OE9pZ1JjVXQrMFg2a3BBRVlFdGpOdXozTHJnOWNwKzlMKzhHV3pz?=
 =?utf-8?B?aklLYjdzTUlZSlRZWXkzcVlzdVdhbEowSHVOa3BWcTNrUFFGQVdvWFcrUG5k?=
 =?utf-8?B?V3lHOGJyUE5ZY2JLYUtqKzZ0QWxNbE9ubk1Ydm5KT2twbnM0bW5CQ2FkSEpm?=
 =?utf-8?B?QjdrYzVkT0JSbUcwL0tLYkwySGswUnFwZkIwc0tFRlVKdDVyTDB6YmFiT0M5?=
 =?utf-8?B?OVBtU2RTQjhaR2JocHF4d3AzUlA2Z3lxN044dUk4UGNzVGszT2JCMDBUOGph?=
 =?utf-8?B?L3R4SXZiNFhuQ3JrRmRwb2cyU3k5T0h4UXdaSkQzZmpIWStwcHZWZlBRRTZv?=
 =?utf-8?B?aUhQSHVqSDVCT2p3VVJiL21OVFlsN1UvdHNWYTdNa1p5dVlhQ0NPUWhCK2RC?=
 =?utf-8?B?MWN3Smh4c1dTczU3eEF0OElnWjNBdmNTVFo1ZkU0d1dtLzZDWXg2U2dwRis3?=
 =?utf-8?B?UmZhOW1UWGIyZi9DWmc0TzA2QkNFV2lFUjFUaTBFU254K01aeEZIWmhqWjRv?=
 =?utf-8?B?Qk93U3BTMFR6aWhCcnl1cDA5aEpKTU1pTmN6NFU4RytqU2dZSzBkZnpFWUx2?=
 =?utf-8?B?K3FHMEpra1NnRk1mc21kclZUY05YQUJVTjhNM1RyOTIyTW5hMko0TkF3MXlB?=
 =?utf-8?B?ejYxV0FSOW5yalBSSjhWeDc2alRLWDdlWXRFYkN1dEszcnpQeExsTkJyQmFM?=
 =?utf-8?B?QXYvSTN1YWl6NWMyZFJLR2ZhanU0ME56NGUrYUR0UklsYnFob3BkajdCUklq?=
 =?utf-8?B?aW12SEc3STV0dDRPT3hpU2lFOUd3MGE3RzkwTDZuOTRVVll6SFVlZ2prNGgz?=
 =?utf-8?B?VjJ2R2tGdGtBNlJMOGtRTDBLU1Q0eVZHTENOZUVSNllBTGhMR2d2b3Bxekp4?=
 =?utf-8?Q?uDVnAx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:37:54.5802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de71238-5c9e-48c5-5798-08ddf05e7b84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374
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

It requires validating the userq VA whether is mapped before
trying to resume the queue.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 31 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2626a41a8418..fa44a47b2734 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -101,15 +101,12 @@ int amdgpu_userq_buffer_va_get(struct amdgpu_usermode_queue *queue,
 bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 {
 	struct amdgpu_bo_va_mapping *mapping;
-	u64 user_addr;
 	bool r;
 
-	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
-
 	if (amdgpu_bo_reserve(vm->root.bo, false))
 		return false;
 
-	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
 	if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->userq_va_mapped))
 		r = true;
 	else
@@ -119,6 +116,24 @@ bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 	return r;
 }
 
+bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
+				    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
+	int r;
+
+	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
+		r += amdgpu_userq_buffer_va_mapped(vm, va_cursor->gpu_addr);
+		dev_dbg(queue->userq_mgr->adev->dev, "validate the userq mapping: %p va:%llx r:%d\n",
+			queue, va_cursor->gpu_addr, r);
+	}
+
+	if (r != 0)
+		return true;
+
+	return false;
+}
+
 int amdgpu_userq_buffer_va_put(struct amdgpu_usermode_queue *queue,
 			       u64 addr)
 {
@@ -774,11 +789,19 @@ static int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	int queue_id;
 	int ret = 0, r;
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+
+		if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
+			drm_file_err(uq_mgr->file, "trying restore queue without va mappping\n");
+			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+			continue;
+		}
+
 		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 3623c8f6899a..cd63f7d79a95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -157,4 +157,6 @@ int amdgpu_userq_buffer_va_put(struct amdgpu_usermode_queue *queue, u64 addr);
 int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm,
 				struct amdgpu_usermode_queue *queue);
+bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
+				    struct amdgpu_usermode_queue *queue);
 #endif
-- 
2.34.1

