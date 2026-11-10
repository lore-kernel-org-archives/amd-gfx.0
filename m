Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E118606A336
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=W8ztW0DV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E16AC10F6AF;
	Tue, 10 Nov 2026 13:05:07 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C85210F6AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 13:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biQ5DNlpX54Laxe2gfHpeHyoO7CGz+6Gyc5Co5caRnmlwYBeM3U0r799Rb34wKhePenp3T5JMaWocY372OWM0/nEbazIyZbMkn9VfqPuEBDw6/Qdm6S4urzjdSvPWE1+9xO+3b63UpJdiMXT8pt7Y5pAa+IWylfXho5Omz6InY4vZTVfzKzHcncfwBv8Z84vALn2ksO+84xIt0N7825MTd7kiiWGN1BS2dgBCvfOQ5Yj0t3a6osnY+K8qbsYuvumhK3cDiHwWCpw0KL+xlGo1dlUdHajvc5SMaBujRyDi9zpQqVKLWDEQY8j27qLHEcjQliseFo0Orew8Y2mwkSyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKTAkumO/p75JEI/+OXUBO4NbRx5NVtG8wnMzu5V4iE=;
 b=k8Ypd1vdDE/FRVEPaLVPJuggCKyjatex0lBKBpnNT82kIAyY0D4oc0b8cSznrPfwKS4qfQPSJsfUGpxqf8/mu+Q+a+EcATyzi+7m0dxiInxKuyr59kRhIXcs3og0im3Iw/rl8p0K40kV06FrYvC96ZrtSJd1WdWqQbOnvLsuo677yST0ZB70zSrG2f75LSEhMkUzFtQnm5ZHI5yZYmVWsa7jSaQEPm/gadpVuV2xq8pCNeftudXbPVn2WYJmPJhNc/PlXJrcw/shHXb/scieeGfdTkMOc+iucbt1xKtR6ky7YyeEFBwWctCtpje1bwgP674Mp+FAw03rSkYVLox5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKTAkumO/p75JEI/+OXUBO4NbRx5NVtG8wnMzu5V4iE=;
 b=W8ztW0DVZZZz5n43zmKayPjnHUcYWwzNQ2WL0g7lIdQhATYiAn9KUa6cz6SV6TQQmx3eljmxRiWkFm4lFNsCa3mLNIkZlSKSfq4lOaVpztDPTjJlab1AKfZrg0q8m1WiRZ1UTCX0ioJRB8qXux2sA66cAm/Lf1wSaUmZ2a/aGiI=
Received: from DM6PR02CA0143.namprd02.prod.outlook.com (2603:10b6:5:332::10)
 by IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 13:04:57 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::2c) by DM6PR02CA0143.outlook.office365.com
 (2603:10b6:5:332::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 13:04:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 13:04:56 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 07:04:54 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/mes: pass the process context slot to
 SET_SHADER_DEBUGGER
Date: Tue, 10 Nov 2026 21:04:35 +0800
Message-ID: <20261110130440.474374-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 7753d062-cae8-4f70-87ef-08df3f2b3837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|261009223027099003|261009221227099003|11063799006|56012099006|10067099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: HTIrNM5Aml5hK6b4i23dIKPusgWenolQIQ7KnuubdfNENb35vzPpyYLZoKE0Azo1AbRGzfymuvqXbPQgqblskEdbyYym+31hDUuQN+5Cjfh438juRjc+3Y2vjVk5Axolb4fUFzAjqJdBa/6uatodwGmhkm+xlDgfbIkmreIHmeez7KkwXc4dbQ/UpDoNpG1x+ibMsQsxiz7gMkJ84a9eDEcmMpAxiilFxwJNkkFg62JYQHUYSvrQ9QVxRAQG5y/ixtWmjKSTCVWCPB90ojs95pW2UnC1djBsuRNaBBTPanjFxRWXhnMXn/st/mIB8Q6eCt5SBGohPTxI2K5ubudkITQ7om9Nr0e6hlJlJtbohr+VU0WDTgl07SJ+uqfKDR/pVwjDLmKGOPIyugLRb1KyeJPKU4SHV2A7RCOuuh6rFp07/5sk5fNIW35/o2eTY3FSYSpzQXJqzadh5q0nEWCeT+u6UJAmhqI7bXmiB/D8r04prCm7Xogio9NB8quTztOzy4YyIQEiPRlqY4PdvW/d3mJwYInH9Bmo7RSjJIvFd+qcIsb+P4oKIGLQPwol0lYEEfxM9xWu5T3oaJtEt5qn6u6ohlfFDtmIywEha3rzY4tozydjuNelipt9wk7YcXJF53hY1fr6NbMJBZwPmqag63tJCvA+nuA7jARSNR+A/hYr4tdqQd0SCwxwvcQFIscAzGvuvAxaE4L4N/24FycJCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(261009221227099003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G7I6Yr6LjPxbYU+ya1SFiDIHw1v6eja1mQt2Ybdvic69Xu6TtsfBfbfOgzDhIcpE8tBzvIg8WJFNLk6sTqBDOgipcUQaTthIcqF6czx8qIRbkOuqj0//8+hlSbrU05SblNitMcD7MvdFhxSXFEy86nBlf8jW8WbyTkd38eXdL2/amCqpKOxodofAfZRcuhQzaWZuVBoa3e+gfiVvgAjfvJu8HeoD+SfWk+ZSnD9T0t3phXLkmZKlOTcMUowC4J/6GL2G4KFe7oG1RI413arVhCVW+gKrkmvBHblQFERBl1bMDtUledBr9WRVe2jy3djV4XsU4aEEtmaXu+YUuIZkjPkybgyjfoGxt22HpLzTZdZyrMpNsBQ5niJnXWWPZud8L9MubDfFqN54sSU/Z6fnCKycCY3q9HgL0YK0vphEbqe9PHx1n1hceTqjUoa16DS9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:04:56.8580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7753d062-cae8-4f70-87ef-08df3f2b3837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762
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

With MES RS64 process/gang context loading, MES keeps the process
contexts in an array in its local memory and looks them up by the slot
index the driver passes. SET_SHADER_DEBUGGER has a
process_context_array_index field for this, but
amdgpu_mes_set_shader_debugger() and amdgpu_mes_flush_shader_debugger()
only pass the process context address, so MES always gets slot 0.

KFD sends the flush variant of this packet for every process that exits
(kfd_process_dequeue_from_device()). In RS64 mode the flush therefore
hits slot 0, which belongs to whichever process allocated it first,
instead of the exiting process's slot:
 - the owner of slot 0 loses its process context while its queues are
   still running, so its next GPU accesses fault;
 - the exiting process's slot is never flushed, so the next process
   that gets it starts with a stale context.

So the KFDIPCTest.BasicTest failure on Navi3x was caused on the case
when parent holds slot 0, the child's exit flush wipes the parent's
process context, and the parent's next access to the shared IPC buffer
faults.

Fixes: e32b68c6b135 ("drm/amdkfd: enable rs64mem for kfd queue")
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h                | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                 | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                 | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
 5 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 7864afab5b40..99b803f95c56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -763,6 +763,7 @@ int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
 
 int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				uint64_t process_context_addr,
+				uint32_t process_context_array_index,
 				uint32_t spi_gdbg_per_vmid_cntl,
 				const uint32_t *tcp_watch_cntl,
 				const uint64_t *watch_addresses,
@@ -782,6 +783,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 	op_input.xcc_id = xcc_id;
 	op_input.op = MES_MISC_OP_SET_SHADER_DEBUGGER;
 	op_input.set_shader_debugger.process_context_addr = process_context_addr;
+	op_input.set_shader_debugger.process_context_array_index =
+		process_context_array_index;
 	op_input.set_shader_debugger.flags.u32all = flags;
 
 	/* use amdgpu mes_flush_shader_debugger instead */
@@ -811,6 +814,7 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 
 int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
 				     uint64_t process_context_addr,
+				     uint32_t process_context_array_index,
 				     uint32_t xcc_id)
 {
 	struct mes_misc_op_input op_input = {0};
@@ -825,6 +829,8 @@ int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
 	op_input.xcc_id = xcc_id;
 	op_input.op = MES_MISC_OP_SET_SHADER_DEBUGGER;
 	op_input.set_shader_debugger.process_context_addr = process_context_addr;
+	op_input.set_shader_debugger.process_context_array_index =
+		process_context_array_index;
 	op_input.set_shader_debugger.flags.process_ctx_flush = true;
 
 	amdgpu_mes_lock(&adev->mes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e5dbcf8ef890..9358090165aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -450,6 +450,7 @@ struct mes_misc_op_input {
 			uint32_t tcp_watch_cntl[4];
 			uint64_t watch_addresses[4];
 			uint32_t trap_en;
+			uint32_t process_context_array_index;
 		} set_shader_debugger;
 
 		struct {
@@ -653,6 +654,7 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 int amdgpu_mes_hdp_flush(struct amdgpu_device *adev);
 int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				uint64_t process_context_addr,
+				uint32_t process_context_array_index,
 				uint32_t spi_gdbg_per_vmid_cntl,
 				const uint32_t *tcp_watch_cntl,
 				const uint64_t *watch_addresses,
@@ -660,7 +662,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				bool trap_en,
 				uint32_t xcc_id);
 int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
-				uint64_t process_context_addr, uint32_t xcc_id);
+				uint64_t process_context_addr,
+				uint32_t process_context_array_index, uint32_t xcc_id);
 
 uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct amdgpu_device *adev,
 						   enum amdgpu_mes_priority_level prio);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 60b27278a598..2617c2b7f101 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1043,6 +1043,8 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 				upper_32_bits(input->set_shader_debugger.watch_addresses[i]) & 0xffff;
 		}
 		misc_pkt.set_shader_debugger.trap_en = input->set_shader_debugger.trap_en;
+		misc_pkt.set_shader_debugger.process_context_array_index =
+				input->set_shader_debugger.process_context_array_index;
 		break;
 	case MES_MISC_OP_CHANGE_CONFIG:
 		if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) < 0x63) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 71b34a57c2cc..cb830f985536 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -373,7 +373,8 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 	}
 
 	return amdgpu_mes_set_shader_debugger(pdd->dev->adev,
-					pdd->proc_ctx_gpu_addr, spi_dbg_cntl,
+					pdd->proc_ctx_gpu_addr,
+					pdd->proc_ctx_array_index, spi_dbg_cntl,
 					pdd->watch_points,
 					pdd->watch_addresses,
 					flags, sq_trap_en,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index b68e884b1c37..d3149e6d40e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -96,6 +96,7 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 	    down_read_trylock(&dev->adev->reset_domain->sem)) {
 		amdgpu_mes_flush_shader_debugger(dev->adev,
 						 pdd->proc_ctx_gpu_addr,
+						 pdd->proc_ctx_array_index,
 						 ffs(pdd->dev->xcc_mask) - 1);
 		up_read(&dev->adev->reset_domain->sem);
 	}
-- 
2.34.1

