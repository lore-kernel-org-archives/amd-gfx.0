Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B184C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58DB810F4F9;
	Thu, 30 Jun 2022 19:03:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CCEA890DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am0KZxRF046UX3Ur6m3xq7gRiJbCDOciyjMRR1V0vKdFfsDbVcD2CkD1v1wCJF9si2rIbvWXQ7iBvz/S/+vfKE0Ki22VPjWzQNa9otThVJe7t5d/xoPAnCY3bKAG6P/TlFO2diW8zUFOKUf2UcCK/Igc5ncESsm181bjI1YnP2lf91kJeT3SXItq84esU7+c02yDmBU3y4EoRn47l7WAJRj67b32E0o4hBkLD9ShPte7UN6MWkNHbxUIly0V1G2uZxfNuD1RB4Nyd1IxVHeU0nduGGeJLqG9Qh9GOU1DK18/krbf1yM2F+MSIkfCrRGgzDS3NJk7QFlGUlBLu8mw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obi10Ssw1m8jcGVwaNXa52PUjxMdLk849fI997LzAlE=;
 b=WQPF63SvK4/IHUTv1HaZ5FsrTt/voavo1Bv5V66XcNuFIr3RSiHu0h9LodmHlg4812h3yd89AwN5+PhpkuL029JdCPfzSjeJ8Nml8qMtHPTGnBoXaLRWNuCs1IZ5pdMbAPLQ+QE3C+0Jf3cXTrwWa3mvK3ZjAKb599Wo7eO/NoMJAcjd+fKk7eC+r4jB9tdJt+16kzFbvo4RedRP54ijC/Mm4K7Ryp+/qBZlw4EwFHyBfxlf/gJ3/vP/Wk2ZNF6qq8leY8ZlLGJtcsmKMgLE/74V0A2zzqZYjGX+zWLioofHsAuP5BcrhWoJfUElgYKFasEtgyznpSzyVbXRKP4NAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obi10Ssw1m8jcGVwaNXa52PUjxMdLk849fI997LzAlE=;
 b=v17QE+BASG9a2pITS9kMOzzqKTEy+2yzE5ctBQXHxOqIew2N8GExCT0bql4HVBuHIc3TLtSGJI/pNNhHqXrcAK30M96Es15XOO7SYtpcmDGBwofYvHaiMpbvh7laBCjyPw1gmvDV9Omcl8biTgOnAw84C8mqrPKilNlG9meyEt4=
Received: from DS7PR03CA0234.namprd03.prod.outlook.com (2603:10b6:5:3ba::29)
 by BL0PR12MB2482.namprd12.prod.outlook.com (2603:10b6:207:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:03:47 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::4f) by DS7PR03CA0234.outlook.office365.com
 (2603:10b6:5:3ba::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Thu, 30 Jun 2022 19:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:03:47 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 14:03:45 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] libhsakmt: allocate unified memory for ctx save restore
 area
Date: Thu, 30 Jun 2022 15:03:09 -0400
Message-ID: <20220630190309.119238-6-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630190309.119238-1-jinhuieric.huang@amd.com>
References: <20220630190309.119238-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62ebb598-273a-4d7d-3aa7-08da5acb431b
X-MS-TrafficTypeDiagnostic: BL0PR12MB2482:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6OVmlt7R8KOnYtf0S7FCiuMM96wulSaXH7Zau/6h9Bc5kpeAI0QwzKjX0lBvf1t2iPT9iEIOTR6aLU9OJg40/msikGeQ50VZ/ZptfxgD8rsSeigVPZ9u22Keouj3YLaBbHPD04h2nbWYD1MbbvUSbA3SPL7uBpWBcoF6ZHqL/E5aoPHIQcAwyiIRxhWGWsHm1Z9d4bW1VIIxBoqVdv50j1Ox1ScgCoWmHkhIUrK4ja3+qzpBDRBgvWhJYfxLXE/CwGNGBBmS7sQhDNhr94VrdB8Oes1JK+JZ/AUC7PNHSDzlr/2G6eAdo+KUyOHbnCXGD8FJNL/FW11Wt6BNB0YJbc3x3m3YDQAkx8N0qWGxhDM+xoxPAtU0WJo317k0LpgsyHCIVuluMOqihY5huU85e96LKlmzdIMzkI/9trTVTpdYZ261T+7T3I3cXXlG8lcnDIYm8sDZ1FX4WagqqZnVGP7N0UeBtUIetZ+RjHFnS6HpmJO10/lcKGkQIAvlNV/W6OeLtWyEvTXXg2krXsvGXbvCgoLNZmJklHO3Jm2DATDZO59DB/h/PLxJMTpLv6NEJZ0vlssZ3cGcaoe+1hL0qh56geUpw5JqdyWnvxvS/IZdtsnGbKM5rlYegwN1TIgJihczfxueIT/C2iNf4KQbX4QRzHE6XcnFRvQyxEBrzkX90knlKA59RTmuHEhTZw93Ek4E0cT4Aw5TkH/b3vlu4DRnw4hGTaWTZSqIVCOQsyIMgJ+BhP/wKYnAhiNLj+6M3McpUwyEQdZXpDDGefnmm4ZlShFLf2OPLVzqxskAvB+bxW7UA9M/4RQT0CThA9DYUxCyKXcQX8aTYK1oycQCctS9GkQuiuQlFUeGK3wAR4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(40470700004)(46966006)(36840700001)(40460700003)(83380400001)(5660300002)(478600001)(16526019)(186003)(70586007)(26005)(70206006)(2616005)(36860700001)(8936002)(4326008)(1076003)(8676002)(6916009)(7696005)(426003)(336012)(82740400003)(86362001)(54906003)(47076005)(6666004)(2906002)(41300700001)(356005)(316002)(36756003)(40480700001)(81166007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:03:47.5971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ebb598-273a-4d7d-3aa7-08da5acb431b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2482
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
 src/queues.c          | 103 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 90 insertions(+), 14 deletions(-)

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
index c83dd93..d5109f9 100644
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
@@ -383,13 +384,47 @@ static void free_exec_aligned_memory(void *addr, uint32_t size, uint32_t align,
 		munmap(addr, size);
 }
 
+static HSAKMT_STATUS register_svm_range(void *mem, uint32_t size,
+				uint32_t gpuNode, uint32_t prefetchNode,
+				uint32_t preferredNode, bool alwaysMapped)
+{
+	HSA_SVM_ATTRIBUTE *attrs;
+	HSAuint64 s_attr;
+	HSAuint32 nattr;
+	HSAuint32 flags;
+
+	flags = HSA_SVM_FLAG_HOST_ACCESS;
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
+	attrs[2].value = ~flags;
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
+		free(q->ctx_save_restore);
+	else if (q->ctx_save_restore)
 		free_exec_aligned_memory(q->ctx_save_restore,
 					 q->ctx_save_restore_size,
 					 PAGE_SIZE, q->use_ats);
@@ -425,6 +460,8 @@ static int handle_concrete_asic(struct queue *q,
 	if (ret) {
 		uint32_t total_mem_alloc_size = 0;
 		HsaUserContextSaveAreaHeader *header;
+		HsaNodeProperties node;
+		bool svm_api;
 
 		args->ctx_save_restore_size = q->ctx_save_restore_size;
 		args->ctl_stack_size = q->ctl_stack_size;
@@ -434,22 +471,60 @@ static int handle_concrete_asic(struct queue *q,
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
+			uint32_t size = PAGE_ALIGN_UP(total_mem_alloc_size);
+			void *addr;
+			HSAKMT_STATUS r = HSAKMT_STATUS_ERROR;
+
+			if (posix_memalign(&addr, GPU_HUGE_PAGE_SIZE, size))
+				pr_err("[%s] posix_memalign failed:\n", __func__);
+			else {
+				header = (HsaUserContextSaveAreaHeader *)addr;
+				header->ErrorEventId = 0;
+				if (Event)
+					header->ErrorEventId = Event->EventId;
+				header->ErrorReason = ErrPayload;
+				header->DebugOffset = q->ctx_save_restore_size;
+				header->DebugSize = q->debug_memory_size;
+
+				r = register_svm_range(addr, size,
+						NodeId, NodeId, 0, true);
+
+				if (r == HSAKMT_STATUS_SUCCESS) {
+					q->ctx_save_restore = addr;
+					q->unified_ctx_save_restore = true;
+				} else
+					free(addr);
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

