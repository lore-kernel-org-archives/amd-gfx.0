Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E5FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 21:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9890210E5F2;
	Tue, 28 Jun 2022 21:49:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACFD10E5F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 21:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXQvqZ7YT/d2Uln8Se1YjFO718Ij+J1d8qvLbKhGWf2XHNCpV4HEZOMyRNl2TKaJhihq/xoEIJ+Q400dRY1vujB5kpL2C6+YFdrWUSbJ0lwBegn/xfkxFteNjqq2x1i6JFDGKzd8O/ZmBCyYA+fR1n/gnAdjtZWM+M/Wm2R2VY3mCuqSL5N2eItjE0JZYDDU2kTvtFoVekG1GQByBgQmGTt8JqC4TYZ8PiJyr9Nb2VekiHlNrcoFgNXJNLKCRLWFk9T7Eba8km4WlKYugSs64PKcfFfgLCZaATUnmJqQG9lO9ug8271jbGDZ9eiuCrVdKs6f8kFz+kyZBeKhDRt/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ffr7tljsv6B1IXEfsKyKvCUY16ZvjlzMqadrcuwlCvM=;
 b=H0Go9vnaeuUY9whQJExLg+P8/K7V6U1VVd4uSJtIP6ftBkv6VTxOA9z0Ik/nYW24RJyKo01Gh2YutclL9LEUsoOofy72kifozXHbGU9BFHM7mo93UiBR1a2rCwptnLB1DY2JUMZEdRZkFsEazk1LpnQ0ZLKMN2znHwxyjIz3dEkp91/QbL3zxGLVQlKp7vwVUsOVVj4kktD1VpIJDwJEugEL9tkidJNGbKPLDqgnJNEj1WwrqW2Wj4i3Ls2P7VBP+IB76dbUKQkMQdqO5nGSxiBh0KHuFsjQ9o2MOsw4kOhieJLwb6sdOlwxad/eG007q1fXSCwsw794/sYvwHYpQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ffr7tljsv6B1IXEfsKyKvCUY16ZvjlzMqadrcuwlCvM=;
 b=aQQpszPQrk8rZg4YYdH/2c9m55yesfGtzAvQOFunKWcfeqxWyiavk2Hv5ZaqSZ3axu91oMrugwQvkKK6bJwIr7scHmUvdhF07KMkcPefB7+enGJZm0S+AWUOzuYhhPZbwlqk9bbL+mjNaijDvGf5AZNeE+Y1CWMvNHW84hssPyM=
Received: from MW4PR03CA0044.namprd03.prod.outlook.com (2603:10b6:303:8e::19)
 by MWHPR1201MB0237.namprd12.prod.outlook.com (2603:10b6:301:56::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 21:49:18 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::82) by MW4PR03CA0044.outlook.office365.com
 (2603:10b6:303:8e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Tue, 28 Jun 2022 21:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 21:49:18 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 28 Jun 2022 16:49:16 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] libhsakmt: allocate unified memory for ctx save restore
 area
Date: Tue, 28 Jun 2022 17:48:55 -0400
Message-ID: <20220628214855.237602-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628214855.237602-1-jinhuieric.huang@amd.com>
References: <20220628214855.237602-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f30505ec-3a46-4e7c-9fd3-08da59500d9c
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0237:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gb6de9Hsr1h6TiaiNmU0WeNn4KkY60NSubbUP6zjewGuzl/kM+AaSG2ytKwtKxCB4YUTK1nOqq66Rm9TrRvIPf+MlMKmSt5hFrRbYkZwcfOwEdOfVlg5ASOnGZLGCo4MEZqRsrV3CPIxuPFIxUil0p+UmDRbtaE6kGT1QF7Qago7ppZC1pt6WMJV0TIzCe7HN8iGaQzcIpOyO8zqtHkQ8BseElx/Eyycl+u0NDyXHDbzG0lQARJh0CFRrVS8wW5S/hV4ZDxXHDlQu6WMCsvygE8P68YTQbMsC/RnXIgl3YhopyY6Tu62Rfd4zQkkqpTCnMJBKoEq73zeNS/dEWEDkKhUhN7OSa2UEtXHKK/y8HQbXGBblRm7QWo2moD57SoI8I7g+AukXPtSo2EkE+7heEu++I3V0zA3hb8b1w9fqDr5hx3swuQ5q6//HoZ4WSFYHFA+vxD4s6RqawMap+mwfGWhBrL2lFA/x9YLit6P4ez5cFrozQMsux+521iNcnGXsPEc8o0yD1Jz//GkyoicqRotN7i15aAJKJSMSiJ0zAfnQO2dadVrE02KiGhHehYQ5edFNBqt1BzB84c2f2M9ae1E63Eahm75CJCeBH8mAEurB2b2K3iGcN3FhmicyOnYldCDMOhv0DLZ4LaiR4y86HzRuVOvpu+zKgv1ZRwyeYRBrdALWicPOlip6ocdeYDITOAN1kPU5rAc5Yie1RB5RRqhpIHDnurV/m0s/d5biIBNTbGJj7cKWaCkDBKFV5wY1/N0p8OeTFhOr20462hOamkkxbJKcZJzsIGLQGfbFQ92HDfN+cBP0CYQa33CcQFYXjZFCg7mbcxKbEMCHrOSjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966006)(40470700004)(36840700001)(70206006)(70586007)(47076005)(54906003)(82310400005)(8936002)(7696005)(2906002)(8676002)(4326008)(26005)(6666004)(81166007)(186003)(6916009)(426003)(16526019)(1076003)(86362001)(5660300002)(356005)(40460700003)(478600001)(40480700001)(336012)(41300700001)(83380400001)(82740400003)(36756003)(2616005)(36860700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 21:49:18.5250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f30505ec-3a46-4e7c-9fd3-08da59500d9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0237
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
Reply-To: 20220628214315.235160-1-jinhuieric.huang@amd.com
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

