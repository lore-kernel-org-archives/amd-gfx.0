Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A3CC25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3A210E1E1;
	Mon,  3 Jun 2024 08:48:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3MG+UtPv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F58810E1E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXwdHDRXB0Bvovgx9q6kBFee2QSib8PjKD9Plsqsi0wfc7BkL7+0pMts3z78ZmHLa4einUYCiuX9nqqiAw4tB9s0zG7ZbNUywo/RwGr19S4WWl4N9rH+rDEGOleDT6AY6vXrg5XpFdHYBb26++gVCY4A4zGNOMQnRckc2hX6rtWGhIWCcFSXDoQrn5Dl9puCCpeqL08dCQJw5s4CzOjYUcdXD7G/K9Ue6ZaVqvfUt4N5Eu4bEebOe1D5j3v1lFWcm72TicWkYB4dVRxZZxWi5JXfuMl7sTaP0xyLKTbBGGPyvmkkA1vWghn6GHF4pWbiA6kJykUjfd3Qc/GhC2unMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTTk3blCGwYoP4GnMYZFU3L257bJPq5Ydz/uKMbfahA=;
 b=hj43/WyB4uZSVaBWAjUYz6rhdFsHF6kPnKXhYzZZ/+BDXo5gMy2ZnDcoN5O3mnZkIcZL2uXWOeB+ugFv+xDrNp8DXj6FquRmMIEgz6OkuXT+M6YVrX7ivMrXkepSm1EWzWjK6IeV07SMJKyDPM/wgHP6w/S5rR7uzvhkleCKqObs33/NBt/p4tHYQeVedb8jOaSzrCQdhdlU8Gc2whRlRjvx7d/3feYWyFWW2Fndqv7yTjBKgsnlT+QqoyCDpwGIZbxnDzeH+uk0cyqADgR7xBgedjv272vZUxvjrNBA/6MBvtWpktbUNWSJJ383ZVzM3/GfDLWmiRgEHknbGXCoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTTk3blCGwYoP4GnMYZFU3L257bJPq5Ydz/uKMbfahA=;
 b=3MG+UtPvLr6/E5r1mUuyyYNVf92CrFzGWL/6jC8WCekJfysDtD0jgMC0kjOtQCIlxEKHaCR2Vv+3SOJrHFgn5M7zO0xrfHQV2O+jkt5tA4KInIwd7oMIuxo5EEeYUhNp5/06V2z/T9lYw2GVDnXJXey8d717CrTpugcm/193KNg=
Received: from CH0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:610:b3::21)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Mon, 3 Jun 2024 08:47:55 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::43) by CH0PR03CA0046.outlook.office365.com
 (2603:10b6:610:b3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Mon, 3 Jun 2024 08:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 3 Jun 2024 08:47:54 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:47:52 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 1/2] amdgpu: add the amdgpu_vm ptr in the vm_bo_map/unmap
 events
Date: Mon, 3 Jun 2024 10:46:09 +0200
Message-ID: <20240603084729.15135-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 447ed0e2-65fb-4b33-bd78-08dc83a9dc5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zjn3V2ZCyyGX882RLbrCcSN1XjCQmpi0/lCjmaElToUwHFQdl0FFCHbuLiIE?=
 =?us-ascii?Q?AoxODOY4zwcPH+U6xT2lwpkyl+GW/Tw6t09Xtr7HMSXSN+EANWCsTOux0xrL?=
 =?us-ascii?Q?huc93Tko8tb+emWGyiS1PydKoUqyjJClXBb0IZv7gGmESr0lL9bCGBRdLTcj?=
 =?us-ascii?Q?rHZT6ZrOhZrkSUVuuMgrVVJkAIWFhy3M3Zspw/qDiLiHRcd4x0s3K7gRXEbL?=
 =?us-ascii?Q?O5mBz7R6tjYGzyDB54exo5Hcu23aMSd/WKO/abpF/Lsd2uVjTNuBDfZS0cnm?=
 =?us-ascii?Q?PU1Hzy/GWijlgzNqiZdWix9gUgfUqAunlIdsjQtaXOGDoid4VbRpBgKmVRjy?=
 =?us-ascii?Q?+GbQL1fdshvAkIO2+E1z0Q8wUtjbgTgHlzwJP0S4FaAZaSWWVQPp01IwBiVl?=
 =?us-ascii?Q?CsIH21Dtv1kNuygxrMaWFLX7t/c6jJt2/oH09icwToitj84/WWW1E6vDbGPY?=
 =?us-ascii?Q?wpJI8f0zRKYGC5PWLo4W8drvdBZlgXaLYpzRI35OGOwDqomcg0ySUG+6ax1F?=
 =?us-ascii?Q?EqBLVFeNr0Kr9dAxX9groUuFfqHw8mvgrTBjW/rAob8j5xfkjtlS1fDC7t0U?=
 =?us-ascii?Q?VupPoNwD6X3VLtgoBUwEZQyD0Vlu/NV+cLN/j3iTe59HZ2ZAjjP521V+LNsW?=
 =?us-ascii?Q?MeWqx58ktubPVSELMQOK1lV+XywzFZ2fYMK1SfaV5DGlI4jU14lbtzNuYLQZ?=
 =?us-ascii?Q?i8v/Yb8FManMRRNr+cBP27LPURrroocIQikhNu2lGd2CHNF7/Ihj/p5BDix/?=
 =?us-ascii?Q?cV5DELFhU0uE8jGSyBeGG5Tgf+Sub958k/PqWLCNq01YjGGkbln7R5XI7Ok1?=
 =?us-ascii?Q?mQqoV0dVexC4fSEJYiKYWhu8hud3AD4yjfebQpr7ceD36a5sbivXwKro3700?=
 =?us-ascii?Q?u2OrsST1H667o+Ec5mOTkY1lOfDUv/noqocw1ED6bfUP4HyRifJhshZok9i1?=
 =?us-ascii?Q?w1KcDilHSOkW9NV/qTGmw1lUKZozVFpCe4ERd7iYvh5vWmMBQA0MtZinj+WP?=
 =?us-ascii?Q?FwTGc1LGZc1oFEH0t2FTKWgxu4v9Ff0ShtRNKltezHrtQD+uAMD+En25w9kG?=
 =?us-ascii?Q?Eu1aJacGe9FcBjzzOT8LbV23oWSxKobraXiKlwV+61C1EIF/0zglu3ahaTAf?=
 =?us-ascii?Q?WAk36VIv01YzOJHovVy8kaaeF0FLxG7+d3X195cePhyqsldpS5InRgQyI3Mv?=
 =?us-ascii?Q?TWfM4ukgwMqUCo51Lhuhh7PTNLo3qPB+zmKAnDEZGYfYxz7safVVd9LHhZBj?=
 =?us-ascii?Q?xebd2PTVBEydqYn76uHOijWGCgAM4fKEsvnyQpHk/IXsAodtxsArwivQPKEx?=
 =?us-ascii?Q?UG+Y8ghIl7TIByd2fxtuy+N9iKZDLPmzovFz5mh3pdEad122gx711+lRSvPm?=
 =?us-ascii?Q?yIWJEbSQj/d99WXoA6P7Uj10m2IC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:47:54.8919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447ed0e2-65fb-4b33-bd78-08dc83a9dc5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
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

These 2 traces events are tied to a specific VM so in order for them
to be useful for a tool we need to trace the amdgpu_vm as well.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 20 ++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++++----
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index f539b1d00234..c84050d318d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -243,10 +243,11 @@ TRACE_EVENT(amdgpu_vm_grab_id,
 );
 
 TRACE_EVENT(amdgpu_vm_bo_map,
-	    TP_PROTO(struct amdgpu_bo_va *bo_va,
+	    TP_PROTO(struct amdgpu_vm *vm, struct amdgpu_bo_va *bo_va,
 		     struct amdgpu_bo_va_mapping *mapping),
-	    TP_ARGS(bo_va, mapping),
+	    TP_ARGS(vm, bo_va, mapping),
 	    TP_STRUCT__entry(
+			     __field(struct amdgpu_vm *, vm)
 			     __field(struct amdgpu_bo *, bo)
 			     __field(long, start)
 			     __field(long, last)
@@ -255,22 +256,24 @@ TRACE_EVENT(amdgpu_vm_bo_map,
 			     ),
 
 	    TP_fast_assign(
+			   __entry->vm = vm;
 			   __entry->bo = bo_va ? bo_va->base.bo : NULL;
 			   __entry->start = mapping->start;
 			   __entry->last = mapping->last;
 			   __entry->offset = mapping->offset;
 			   __entry->flags = mapping->flags;
 			   ),
-	    TP_printk("bo=%p, start=%lx, last=%lx, offset=%010llx, flags=%llx",
-		      __entry->bo, __entry->start, __entry->last,
+	    TP_printk("vm=%p bo=%p, start=%lx, last=%lx, offset=%010llx, flags=%llx",
+		      __entry->vm, __entry->bo, __entry->start, __entry->last,
 		      __entry->offset, __entry->flags)
 );
 
 TRACE_EVENT(amdgpu_vm_bo_unmap,
-	    TP_PROTO(struct amdgpu_bo_va *bo_va,
+	    TP_PROTO(struct amdgpu_vm *vm, struct amdgpu_bo_va *bo_va,
 		     struct amdgpu_bo_va_mapping *mapping),
-	    TP_ARGS(bo_va, mapping),
+	    TP_ARGS(vm, bo_va, mapping),
 	    TP_STRUCT__entry(
+			     __field(struct amdgpu_vm *, vm)
 			     __field(struct amdgpu_bo *, bo)
 			     __field(long, start)
 			     __field(long, last)
@@ -279,14 +282,15 @@ TRACE_EVENT(amdgpu_vm_bo_unmap,
 			     ),
 
 	    TP_fast_assign(
+			   __entry->vm = vm;
 			   __entry->bo = bo_va ? bo_va->base.bo : NULL;
 			   __entry->start = mapping->start;
 			   __entry->last = mapping->last;
 			   __entry->offset = mapping->offset;
 			   __entry->flags = mapping->flags;
 			   ),
-	    TP_printk("bo=%p, start=%lx, last=%lx, offset=%010llx, flags=%llx",
-		      __entry->bo, __entry->start, __entry->last,
+	    TP_printk("vm=%p bo=%p, start=%lx, last=%lx, offset=%010llx, flags=%llx",
+		      __entry->vm, __entry->bo, __entry->start, __entry->last,
 		      __entry->offset, __entry->flags)
 );
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3abfa66d72a2..e04928d2e26a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1642,7 +1642,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
 		amdgpu_vm_bo_moved(&bo_va->base);
 
-	trace_amdgpu_vm_bo_map(bo_va, mapping);
+	trace_amdgpu_vm_bo_map(vm, bo_va, mapping);
 }
 
 /* Validate operation parameters to prevent potential abuse */
@@ -1834,7 +1834,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-	trace_amdgpu_vm_bo_unmap(bo_va, mapping);
+	trace_amdgpu_vm_bo_unmap(vm, bo_va, mapping);
 
 	if (valid)
 		list_add(&mapping->list, &vm->freed);
@@ -1929,7 +1929,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 
 		tmp->bo_va = NULL;
 		list_add(&tmp->list, &vm->freed);
-		trace_amdgpu_vm_bo_unmap(NULL, tmp);
+		trace_amdgpu_vm_bo_unmap(vm, NULL, tmp);
 	}
 
 	/* Insert partial mapping before the range */
@@ -2056,7 +2056,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		list_del(&mapping->list);
 		amdgpu_vm_it_remove(mapping, &vm->va);
 		mapping->bo_va = NULL;
-		trace_amdgpu_vm_bo_unmap(bo_va, mapping);
+		trace_amdgpu_vm_bo_unmap(vm, bo_va, mapping);
 		list_add(&mapping->list, &vm->freed);
 	}
 	list_for_each_entry_safe(mapping, next, &bo_va->invalids, list) {
-- 
2.40.1

