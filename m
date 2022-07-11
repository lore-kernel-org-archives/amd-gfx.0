Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746D2C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 18:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B150A90872;
	Mon, 11 Jul 2022 18:42:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D35A90870
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 18:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGw7y4wzlmOkf+cmWnbm2iK8+6cd2nI2oi6nonK+YqzpwOIdxddGMY2oi38+bRhmEp6NuNw89gh948RRqnbWfZTA6qDhH2bA/ryVz+UdE1vVX933uYbkGQQai4M0yKHMCLpAUyZZFnd2NIaB/56f8gYpRwNG8Nl7HVvhwdFz9EA1SdN4nHVZ9BzByQfNqGoYoshmQ3WsufziyP+oZZptSlxu/WXRMIOd4H/qyByFT3c3fQliMwGupFW5CJG2tKhcyM1x9183RNU5+Eg5Ar2qsoGAhsHIKpx+CToTHv2D1pn97FJb1g8+/0bj+fsTk6QzwvOHygVPImEiwUcO050qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knce3a/4FkbmHFdfm9ACqvMwT0UxI6fWECY0C2jFGIA=;
 b=EQ6BOznuuGIeNcoJqLsfkx1469BPE7k/sEm0cT+d+OaPJwdAIwsKjoHAjIvbYKQOuqKWMPCIey2j0s0D8Np1NBsl0135yywv9tWN8iSqWZLc8nV3WCpwMM1ZA8at8x5pyRsO4nY2NmTdn+vjlwsPb/axfcFI1berPiZEhgO5KEMb2iep7FEMKJi/0jdeqU79u0HWt4FA6UYMUjgSRdh8IcbtsrdaxygDkh3SUQK4kJIfL3/Ep1fe9MCHZsK7sgFGS39vlXS2lSYS47fgF7W/mwwyE2PKm3EUySmYom4DrOcoMF4VUSo2W8iApOOC3l/bDltoakKiXjvaLhnQYMaLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knce3a/4FkbmHFdfm9ACqvMwT0UxI6fWECY0C2jFGIA=;
 b=chH1KNUcOsduZh3rwenlQLUUqkhm9jhtND0rwgH+qNFI04r3nf8eV3hQR+aJ/Kc167x2bpRwTnT+ojXtf2nc5MPk1pTtU2SH8RnygYPDuWcVKybvh1NEex/14MerRlW/BCleCm307samryFCAyf5jHLjYV8hnntkaUnyGYtAUbI=
Received: from DS7PR05CA0085.namprd05.prod.outlook.com (2603:10b6:8:56::15) by
 DM6PR12MB2908.namprd12.prod.outlook.com (2603:10b6:5:185::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Mon, 11 Jul 2022 18:42:24 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::c7) by DS7PR05CA0085.outlook.office365.com
 (2603:10b6:8:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.6 via Frontend
 Transport; Mon, 11 Jul 2022 18:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 18:42:24 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 11 Jul 2022 13:42:23 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] libhsakmt: allocate unified memory for ctx save restore
 area
Date: Mon, 11 Jul 2022 14:41:53 -0400
Message-ID: <20220711184153.135021-3-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711184153.135021-1-jinhuieric.huang@amd.com>
References: <20220711184153.135021-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eab493ab-c681-4142-7cf3-08da636d18dc
X-MS-TrafficTypeDiagnostic: DM6PR12MB2908:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rr2XRzxHVIoZFY4ll43lTBBsqJiRZPBaLIOx9iuPaX+OqBCtVkt0oE9LtEOzopJ9t2bnHNAva5qznjFkLGNyMJZJPoIFOMCklC5/0m6/zsLF3vvBc1reSPkgzmQOg8Ge+t3dWkksZYQIxfFkj2duH9e36Fwv5E46rxC2/NL5nsOOW96KEsn6LhfbBZZ3XuQ0MAideugwf3VphRU6BjwDfNLgCouddqv1wMAAGfz5ThTIVbfGHyrZ8XX+5eeyhcZlz1nPlxgGNoliXjvroTYZX/5OCJ3/dYkRuKu3FjIF2pgV7ZWFYWBgnkfHNDyy1b196Pd2q1nfBfZwLuTLrNxsjZHUbbv15jEq2LIndQFzebZOfPIjhRlvr+4dvUE0vh2W5Bfi+CVfaW3bP7ObXZUzth4m57HKjwEdZhmEV+LDV+SpWD6EBHTOC7OpVkLVLZILxDHQtID0d86jvaN7r4eOmzAS2w1xUcFcLvck8+axEwtKxKEB3WWTJXGJ+4O9ia8Q39pb4vw8LeNCta5w8LbZCoqWCfD++jWYXZ8fb6LPLwQSKFHtvbi7+q7JutV89ou0LHLzLd58gKyIgcFIpX0GlcjV1afh+9InGCEpI3X6iaxtKHykles/OWCEOPnPYE+1vhc+3gk4thLs+QXs3OPwZzdVIgF8g6shjfDxgks+rudqPNZzU8alLXClfnshsPN5uijNZw6UhBRttZdeSjfrsFFqtwQh4Ng8Qz/FhdV4d5zic0VV5xpTK96pG7mWR32AyGDU/iUPxTpAMkKfNvZgIR7mhZxdUR+TyPnbHzf3WJaLCnM0vkaqiomPIrT9SR0X4Zr8q4Jkx21hChanEVjihXvN0yM3JSPWliM1+ryqIhM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(40470700004)(36840700001)(1076003)(70206006)(83380400001)(26005)(40460700003)(41300700001)(70586007)(2616005)(336012)(47076005)(5660300002)(16526019)(40480700001)(36756003)(54906003)(6916009)(316002)(186003)(426003)(82310400005)(36860700001)(478600001)(81166007)(2906002)(8676002)(4326008)(86362001)(7696005)(8936002)(356005)(82740400003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 18:42:24.5097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab493ab-c681-4142-7cf3-08da636d18dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2908
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, felix.kuehling@amd.com
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
 2 files changed, 95 insertions(+), 15 deletions(-)

diff --git a/include/hsakmttypes.h b/include/hsakmttypes.h
index 690e001..65f23de 100644
--- a/include/hsakmttypes.h
+++ b/include/hsakmttypes.h
@@ -1331,6 +1331,7 @@ typedef enum _HSA_SVM_FLAGS {
 	HSA_SVM_FLAG_GPU_RO      = 0x00000008, // GPUs only read, allows replication
 	HSA_SVM_FLAG_GPU_EXEC    = 0x00000010, // Allow execution on GPU
 	HSA_SVM_FLAG_GPU_READ_MOSTLY = 0x00000020, // GPUs mostly read, may allow similar optimizations as RO, but writes fault
+	HSA_SVM_FLAG_GPU_ALWAYS_MAPPED = 0x00000040, // Keep GPU memory mapping always valid as if XNACK is disable
 } HSA_SVM_FLAGS;
 
 typedef enum _HSA_SVM_ATTR_TYPE {
diff --git a/src/queues.c b/src/queues.c
index d38ea0c..5702c95 100644
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
@@ -384,13 +385,49 @@ static void free_exec_aligned_memory(void *addr, uint32_t size, uint32_t align,
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
+	if (alwaysMapped) {
+		CHECK_KFD_MINOR_VERSION(11);
+		flags |= HSA_SVM_FLAG_GPU_ALWAYS_MAPPED;
+	}
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
@@ -398,6 +435,20 @@ static void free_queue(struct queue *q)
 	free_exec_aligned_memory((void *)q, sizeof(*q), PAGE_SIZE, q->use_ats);
 }
 
+static inline void fill_cwsr_header(struct queue *q, void *addr,
+		HsaEvent *Event, volatile HSAint64 *ErrPayload)
+{
+	HsaUserContextSaveAreaHeader *header =
+			(HsaUserContextSaveAreaHeader *)addr;
+
+	header->ErrorEventId = 0;
+	if (Event)
+		header->ErrorEventId = Event->EventId;
+	header->ErrorReason = ErrPayload;
+	header->DebugOffset = q->ctx_save_restore_size;
+	header->DebugSize = q->debug_memory_size;
+}
+
 static int handle_concrete_asic(struct queue *q,
 				struct kfd_ioctl_create_queue_args *args,
 				uint32_t NodeId,
@@ -425,7 +476,8 @@ static int handle_concrete_asic(struct queue *q,
 
 	if (ret) {
 		uint32_t total_mem_alloc_size = 0;
-		HsaUserContextSaveAreaHeader *header;
+		HsaNodeProperties node;
+		bool svm_api;
 
 		args->ctx_save_restore_size = q->ctx_save_restore_size;
 		args->ctl_stack_size = q->ctl_stack_size;
@@ -435,22 +487,49 @@ static int handle_concrete_asic(struct queue *q,
 		 */
 		total_mem_alloc_size = q->ctx_save_restore_size +
 				       q->debug_memory_size;
-		q->ctx_save_restore =
-			allocate_exec_aligned_memory(total_mem_alloc_size,
-					 q->use_ats, NodeId, false, false, false);
 
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
+				fill_cwsr_header(q, addr, Event, ErrPayload);
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
+
+		if (!q->unified_ctx_save_restore) {
+			q->ctx_save_restore = allocate_exec_aligned_memory(
+							total_mem_alloc_size,
+							q->use_ats, NodeId,
+							false, false, false);
 
-		header = (HsaUserContextSaveAreaHeader *)q->ctx_save_restore;
-		header->ErrorEventId = 0;
-		if (Event)
-			header->ErrorEventId = Event->EventId;
-		header->ErrorReason = ErrPayload;
-		header->DebugOffset = q->ctx_save_restore_size;
-		header->DebugSize = q->debug_memory_size;
+			if (!q->ctx_save_restore)
+				return HSAKMT_STATUS_NO_MEMORY;
+
+			fill_cwsr_header(q, q->ctx_save_restore, Event, ErrPayload);
+		}
+
+		args->ctx_save_restore_address = (uintptr_t)q->ctx_save_restore;
 	}
 
 	return HSAKMT_STATUS_SUCCESS;
-- 
2.25.1

