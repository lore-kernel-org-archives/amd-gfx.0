Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA234C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 21:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0332110F07D;
	Tue, 28 Jun 2022 21:44:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BD410EA9F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 21:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtiKdv3XCI/2XJmjhdgF86IkA63WrJ12y040+nlVU9tjNLcnU+SamGeqilkaBvuHaQH0vEzrvwEK6klhD6EuO3O2qyN28EjMiGRy9S3Kg4isUXW3LSPH3pSIJGQbs+sK3aVazBrGomolEocBWAl2+cDBhjy+RVYRhMG3IeetsYsLpq/hvqCIR6bex3LWdDdg8T57usfUnUD4r44MGlzyC8wo7hw8N1z5CjgnkojdvIhMoiU0xxjDvTigGrYwlSubHXt5EWP55U8gmKN17hVCjFe8bOF2+V27K7wePcxvqCqd1hPWS8fHDuF+op+kU7L1trzS3oG0iTebylvFP4fxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ffr7tljsv6B1IXEfsKyKvCUY16ZvjlzMqadrcuwlCvM=;
 b=eUW/vUIA/hcnSHFqdmHcs2aBc7bpr0RbV0wTFqiUXQ5TwVv1aJWImappikE+aKr+Qdvry3+HS8iW8RiVgd5bvDKQqlkSIRqztxTgVfgw5N6dMA/aiasedFG+FzRVlfc/slTaiJzbwIq0HRmDuCWsy68YCOeyB6ATDmBPO4DruCVZbnsYbE192uIgEqHA19ezqE6f9Tquio3SG9/DRNE5nAOUPNRYS8pjYrCbLjLYCt/g5A7kTIeNTHSyJqcuU92h27BQO0B5Vx+RvvDQHiu0oHLPwoZ8GWjX6yF0db9tNVRvVCRT/espStF25hT34o3AAehSliSmQ+Is0AoMpno9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ffr7tljsv6B1IXEfsKyKvCUY16ZvjlzMqadrcuwlCvM=;
 b=jYmy9bxx0+CoAJnlQ8e7BvEg9hpcER0XFNDE2dsXTKep0HzVzMEz0QyNHqO2ehXp9BsdIUHggPArvLKwEkBY6e/JsnjqrgixYQJb6xIgCi8TT1mHwq9Boi0/MwB0IH7KBFhUFZHP/XxO6cM3tsEZf198xKobAYHfnKmYjOXs7/E=
Received: from DM6PR18CA0033.namprd18.prod.outlook.com (2603:10b6:5:15b::46)
 by BY5PR12MB5526.namprd12.prod.outlook.com (2603:10b6:a03:1d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 21:44:11 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::70) by DM6PR18CA0033.outlook.office365.com
 (2603:10b6:5:15b::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 21:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 21:44:10 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 28 Jun 2022 16:44:05 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] libhsakmt: allocate unified memory for ctx save restore
 area
Date: Tue, 28 Jun 2022 17:43:15 -0400
Message-ID: <20220628214315.235160-5-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628214315.235160-1-jinhuieric.huang@amd.com>
References: <20220628214315.235160-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a412ea3d-e531-4136-53c8-08da594f5612
X-MS-TrafficTypeDiagnostic: BY5PR12MB5526:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5gLozj76MvkbrWKtEptha12SlxooV6/zyXYfK83RR3wJFoeYLeLoocBQR7shsYBYbdQ2g+47vivoZ5tmnkCZGXzXN+h2toXQKvaoa5AJNfbPbV4AxyqZYJGrCZ1YKkO4gAiAv4pJ9Eg46FV7w+ddta1ji2kxy/jwlADzia3PNuowBqRbGXm3S0jhKQWj4lEGQpbfXCeERSYO08AO9j+8mIcxrBIlK+rxQPkvdn+9jfLjdnbRr9Twq5nah3OiRXriDojrzZomYZ1Wsq5+/qk0VccuBp23gz6e36yjM+DJI2AwnrmpnY4335Q2UGxvIfSS1QWzCpWIAs2E3GYH2wraJi/0Hf+AtczzeAp3TPeVl35HAdpdrr+FcAkRKRMaTltuITvLpRddwsZs7sFnw3b54SHwIKvOQqaGgWr7jGvtLqCCnGPpeJBb2bsO6wjZ+IWM0cDnGEBuKF9LQMId+Z8HPGaCi171tetm0515EKXLle+XdnZrL8mHEC6aQfRaHbq2/l287zlt+qkaBoIAhNQ3080DoqsMzIY7QL3t3HXP6gbpx2Y6tztzDtyavbg0gdyINXqV8CPMPVCjtwQ/OP70ZW2qHvKDf15BH060F1y3uD/GopXaQBmARnE0T/suHgqWGom192es9DegQfx/8krHf3i/RglHyvM22LoseK1tCpnjmWgRkFLsIQVvtWKjRlsw6S3VR0bIIQpzQBMjpnrH7re5YiwSFAZYN5j3yUxDqc/X+VjlWxO85kID2Ov1MVanXooBA8lZGfG3/F4JybSoCWU0TEbGgFpYkbglsgJpfPNSJSVVDp6l61H88W68j78aWjlLJklFZqpQubcb+a2sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(40470700004)(46966006)(36840700001)(426003)(70206006)(7696005)(8676002)(40460700003)(40480700001)(36756003)(26005)(82740400003)(2906002)(82310400005)(81166007)(356005)(16526019)(70586007)(2616005)(83380400001)(86362001)(36860700001)(6916009)(316002)(54906003)(478600001)(6666004)(41300700001)(5660300002)(4326008)(336012)(186003)(1076003)(8936002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 21:44:10.6582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a412ea3d-e531-4136-53c8-08da594f5612
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5526
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To improve performance on queue preemption, allocate ctx s/r
 area in VRAM instead of system memory, and migrate it back
 to system memory when VRAM is full.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Change-Id: If775782027188dbe84b6868260e429373675434c
---
 include/hsakmttypes.h |   1 +
 src/queues.c          | 109 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 96 insertions(+), 14 deletions(-)

diff --git a/include/hsakmttypes.h b/include/hsakmttypes.h
index 9063f85..2c1c7cc 100644
--- a/include/hsakmttypes.h
+++ b/include/hsakmttypes.h
@@ -1329,6 +1329,7 @@ typedef enum _HSA_SVM_FLAGS {
 	HSA_SVM_FLAG_GPU_RO      = 0x00000008, // GPUs only read, allows replication
 	HSA_SVM_FLAG_GPU_EXEC    = 0x00000010, // Allow execution on GPU
 	HSA_SVM_FLAG_GPU_READ_MOSTLY = 0x00000020, // GPUs mostly read, may allow similar optimizations as RO, but writes fault
+	HSA_SVM_FLAG_GPU_ALWAYS_MAPPED = 0x00000040, // Keep GPU memory mapping always valid as if XNACK is disable
 } HSA_SVM_FLAGS;
 
 typedef enum _HSA_SVM_ATTR_TYPE {
diff --git a/src/queues.c b/src/queues.c
index c83dd93..e65103d 100644
--- a/src/queues.c
+++ b/src/queues.c
@@ -68,6 +68,7 @@ struct queue {
 	uint32_t eop_buffer_size;
 	uint32_t gfxv;
 	bool use_ats;
+	bool unified_ctx_save_restore;
 	/* This queue structure is allocated from GPU with page aligned size
 	 * but only small bytes are used. We use the extra space in the end for
 	 * cu_mask bits array.
@@ -383,13 +384,50 @@ static void free_exec_aligned_memory(void *addr, uint32_t size, uint32_t align,
 		munmap(addr, size);
 }
 
+static HSAKMT_STATUS register_exec_svm_range(void *mem, uint32_t size,
+				uint32_t gpuNode, uint32_t prefetchNode,
+				uint32_t preferredNode, bool alwaysMapped)
+{
+	HSA_SVM_ATTRIBUTE *attrs;
+	HSAuint64 s_attr;
+	HSAuint32 nattr;
+	HSAuint32 flags;
+
+	flags = HSA_SVM_FLAG_HOST_ACCESS |
+	        HSA_SVM_FLAG_GPU_EXEC;
+
+	if (alwaysMapped)
+		flags |= HSA_SVM_FLAG_GPU_ALWAYS_MAPPED;
+
+	nattr = 5;
+	s_attr = sizeof(*attrs) * nattr;
+	attrs = (HSA_SVM_ATTRIBUTE *)alloca(s_attr);
+
+	attrs[0].type = HSA_SVM_ATTR_PREFETCH_LOC;
+	attrs[0].value = prefetchNode;
+	attrs[1].type = HSA_SVM_ATTR_PREFERRED_LOC;
+	attrs[1].value = preferredNode;
+	attrs[2].type = HSA_SVM_ATTR_CLR_FLAGS;
+	attrs[2].value = flags;
+	attrs[3].type = HSA_SVM_ATTR_SET_FLAGS;
+	attrs[3].value = flags;
+	attrs[4].type = HSA_SVM_ATTR_ACCESS;
+	attrs[4].value = gpuNode;
+
+	return hsaKmtSVMSetAttr(mem, size, nattr, attrs);
+}
+
 static void free_queue(struct queue *q)
 {
 	if (q->eop_buffer)
 		free_exec_aligned_memory(q->eop_buffer,
 					 q->eop_buffer_size,
 					 PAGE_SIZE, q->use_ats);
-	if (q->ctx_save_restore)
+	if (q->unified_ctx_save_restore)
+		munmap(q->ctx_save_restore,
+			ALIGN_UP(q->ctx_save_restore_size + q->debug_memory_size,
+					PAGE_SIZE));
+	else if (q->ctx_save_restore)
 		free_exec_aligned_memory(q->ctx_save_restore,
 					 q->ctx_save_restore_size,
 					 PAGE_SIZE, q->use_ats);
@@ -425,6 +463,8 @@ static int handle_concrete_asic(struct queue *q,
 	if (ret) {
 		uint32_t total_mem_alloc_size = 0;
 		HsaUserContextSaveAreaHeader *header;
+		HsaNodeProperties node;
+		bool svm_api;
 
 		args->ctx_save_restore_size = q->ctx_save_restore_size;
 		args->ctl_stack_size = q->ctl_stack_size;
@@ -434,22 +474,63 @@ static int handle_concrete_asic(struct queue *q,
 		 */
 		total_mem_alloc_size = q->ctx_save_restore_size +
 				       q->debug_memory_size;
-		q->ctx_save_restore =
-			allocate_exec_aligned_memory(total_mem_alloc_size,
-					 q->use_ats, NodeId, false, false);
 
-		if (!q->ctx_save_restore)
-			return HSAKMT_STATUS_NO_MEMORY;
+		if (hsaKmtGetNodeProperties(NodeId, &node))
+			svm_api = false;
+		else
+			svm_api = node.Capability.ui32.SVMAPISupported;
 
-		args->ctx_save_restore_address = (uintptr_t)q->ctx_save_restore;
+		/* Allocate unified memory for context save restore
+		 * area on dGPU.
+		 */
+		if (!q->use_ats && svm_api) {
+			uint32_t size = ALIGN_UP(total_mem_alloc_size, PAGE_SIZE);
+			void *addr;
+			HSAKMT_STATUS r = HSAKMT_STATUS_ERROR;
+
+			addr = mmap(0, size, PROT_READ | PROT_WRITE,
+					MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+
+			if (addr == MAP_FAILED)
+				pr_err("[%s] mmap failed: %s\n", __func__, strerror(errno));
+			else {
+				header = (HsaUserContextSaveAreaHeader *)addr;
+				header->ErrorEventId = 0;
+				if (Event)
+					header->ErrorEventId = Event->EventId;
+				header->ErrorReason = ErrPayload;
+				header->DebugOffset = q->ctx_save_restore_size;
+				header->DebugSize = q->debug_memory_size;
+
+				r = register_exec_svm_range(addr, size,
+						NodeId, NodeId, 0, true);
+
+				if (r == HSAKMT_STATUS_SUCCESS) {
+					q->ctx_save_restore = addr;
+					q->unified_ctx_save_restore = true;
+				} else
+					munmap(addr, size);
+			}
+		}
 
-		header = (HsaUserContextSaveAreaHeader *)q->ctx_save_restore;
-		header->ErrorEventId = 0;
-		if (Event)
-			header->ErrorEventId = Event->EventId;
-		header->ErrorReason = ErrPayload;
-		header->DebugOffset = q->ctx_save_restore_size;
-		header->DebugSize = q->debug_memory_size;
+		if (!q->unified_ctx_save_restore) {
+			q->ctx_save_restore = allocate_exec_aligned_memory(
+							total_mem_alloc_size,
+							q->use_ats, NodeId, false, false);
+
+			if (!q->ctx_save_restore)
+				return HSAKMT_STATUS_NO_MEMORY;
+
+			header = (HsaUserContextSaveAreaHeader *)q->ctx_save_restore;
+			header->ErrorEventId = 0;
+			if (Event)
+				header->ErrorEventId = Event->EventId;
+			header->ErrorReason = ErrPayload;
+			header->DebugOffset = q->ctx_save_restore_size;
+			header->DebugSize = q->debug_memory_size;
+		}
+
+		args->ctx_save_restore_address = (uintptr_t)q->ctx_save_restore;
 	}
 
 	return HSAKMT_STATUS_SUCCESS;
-- 
2.25.1

