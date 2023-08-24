Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A2BC6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E504A10E5DF;
	Thu, 24 Aug 2023 21:58:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11D310E5CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbUOvu1NDtO18CgwyGgaG2t8I542DsetJv4NcUMMAfyKSjWQk7ePrA8Eexh80wRYXqoLrxa2J971dGmD4EBF2a3Nea7qOuHtlXEQzuUasGAspGJ4NNqfYqyZ/aTnFtaGYcYDDk86VHXHYbUzNm5Sdg2XQZmBIJ1PZMQdB0tQKCQDGQihqFF7iV+Ktibx0st64229F/p783Md24HYEoWex4RHArQYVz58dsJR9EBzbW+rvH74aml5hDB0HRox6COm4V4Q2gRM2yxjhxqU7+oGTy38xnQogv5ASSmmdD8NfKAzDBXJkeKYKGFyNsh6yIk8S6hA/OjQmEwsnmnzBBw6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhX9mxOffJYhcpmOMCWJXa4Z1ymNn5pG2+HnE62AHGM=;
 b=ZgIIiE7/NTs6A1EIQj8TQdEhxEGo1xA9uqeZsEmbFJOABzhkj9wUAhZ0zPYc2ls6LYjOOnPemg9uSPTNTZWDehqjoJQ8JVbE3R9noDlPgn7TPcPR1RPlI2XQgJv2ApFddsJFNlyHHyQVMey1xBODfP0ipmPt7zLKbPoOwO4LpG3S2WZCbhd3VeK9TLJM9DxH8qAy5KYJIYIlRX6UKU51tDFv3PD52TcptTAq+CG/lbQsc9H1GyZujiFNTi3vWOz5rJnPSrKqu0zVo86Z4UY0vP+5qMr6h8pTh6cJ1r04zp8Ws4l6rGCvoQpewu1vJ/CjVT6V9DMDYmweWngojz6ZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhX9mxOffJYhcpmOMCWJXa4Z1ymNn5pG2+HnE62AHGM=;
 b=jVEo+If6jiPHsgSvnicRhHD1OdTthkTplBrzIsXLwzkYeVHTjT4UCzBte8nciBC6zaVCH6DFzHnpEC11UA/pwHfA6FVZfc7ssD2lRe7BtnqdShLDLSQXA+DHxjpv88OQgntwoejcM4DGwLZbTIOnDWV5UiX3MPMHIQZvJub17e0=
Received: from DS0PR17CA0002.namprd17.prod.outlook.com (2603:10b6:8:191::25)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:58:52 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::57) by DS0PR17CA0002.outlook.office365.com
 (2603:10b6:8:191::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amdgpu: add UMSCH 4.0 api definition
Date: Thu, 24 Aug 2023 17:58:26 -0400
Message-ID: <20230824215835.2740115-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: f591c412-26de-409b-19a6-08dba4ed4e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBZ3dWx3iQsM4dp48LlKGYNURjYgMZ7uAqZUDeyQ7sRlbqM4iePQWvRk5SB7KuuzS7YLSVh0XDeAbSb1fG/lEQ6C6YrcOWgG91fWvPK9E5eW3AXxHxhfpn4bJ+IrpuxsLQ+ygGndhvKAvplULLTTr7HaxEA5TVmOpbmrPjGBJUK/Gm2I7fhU7U1t/E2PgGmQ5jeRf3LQgK7V6uXck2hwIqOyJKLhVXHINI0IPexNmpimjUcJMed1gUIMw/zHN5S3jNCmoVwZt6mFm50WimCCYe0VOpH6rcHqNY6dpkspsxyy2ThNLxkQCsi3Y3ZFiXLunobuiesr7Lxpn6WOmrk1wxk5FqYLjtEg4WQ8Fe2po4wUSjOcuI6tBbhOZOggVGGVetdOgB1nnHJ+ST1IkDuHRrgatiPt75FcBJxYANUw1PRFBvQLEE0B7tBg0LHFS5lbcPwxpzksLkNAZTdNQ4cuoUyMgDVgzuQf/VQ1DIvHwy/ahj3pjTvM2OiKEzB2PAC9UwGpN0u9QJPr3ncHBSk8j5/sfK/vaB9SQUMUARLDFAi6pJ+DqMqrTYkdk8D19Rw4gvPvAldrnoBKI8YPJ4I5tkVy/jhl3puQa2syFmIUHSQeu+JqLqlP3ikTb1hVR+qy1Zb93e0T7xziFzeWY3ufV8svT7h7cdrqm9pFvOLOjUOQ2/g+6UhhxgT4srKn/NIX50PG/+k4nhQ/v7WdCLbMOt+yFps3uxy5Fzfznq4BRVZwDFRihHo3j0kgCWy0TDEeIgZSyvbSfl+Zn8yJ1C7ucg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(86362001)(82740400003)(356005)(81166007)(36756003)(66899024)(40460700003)(7696005)(6666004)(478600001)(5660300002)(70586007)(54906003)(6916009)(70206006)(316002)(2906002)(4326008)(8676002)(8936002)(40480700001)(26005)(16526019)(426003)(336012)(83380400001)(36860700001)(47076005)(30864003)(41300700001)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:52.5649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f591c412-26de-409b-19a6-08dba4ed4e0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add api definition for UMSCH 4.0.

v2: adjust coding style.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/include/umsch_mm_4_0_api_def.h    | 434 ++++++++++++++++++
 1 file changed, 434 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h

diff --git a/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h b/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h
new file mode 100644
index 000000000000..086ce7792c29
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h
@@ -0,0 +1,434 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __UMSCH_MM_API_DEF_H__
+#define __UMSCH_MM_API_DEF_H__
+
+#pragma once
+
+#pragma pack(push, 4)
+
+#define UMSCH_API_VERSION 1
+
+/*
+ * Driver submits one API(cmd) as a single Frame and this command size is same for all API
+ * to ease the debugging and parsing of ring buffer.
+ */
+enum { API_FRAME_SIZE_IN_DWORDS = 64 };
+
+/*
+ * To avoid command in scheduler context to be overwritten whenever multiple interrupts come in,
+ * this creates another queue.
+ */
+enum { API_NUMBER_OF_COMMAND_MAX = 32 };
+
+enum { UMSCH_INSTANCE_DB_OFFSET_MAX = 16 };
+
+enum UMSCH_API_TYPE {
+	UMSCH_API_TYPE_SCHEDULER = 1,
+	UMSCH_API_TYPE_MAX
+};
+
+enum UMSCH_MS_LOG_CONTEXT_STATE {
+	UMSCH_LOG_CONTEXT_STATE_IDLE = 0,
+	UMSCH_LOG_CONTEXT_STATE_RUNNING = 1,
+	UMSCH_LOG_CONTEXT_STATE_READY = 2,
+	UMSCH_LOG_CONTEXT_STATE_READY_STANDBY = 3,
+	UMSCH_LOG_CONTEXT_STATE_INVALID = 0xF,
+};
+
+enum UMSCH_MS_LOG_OPERATION {
+	UMSCH_LOG_OPERATION_CONTEXT_STATE_CHANGE = 0,
+	UMSCH_LOG_OPERATION_QUEUE_NEW_WORK = 1,
+	UMSCH_LOG_OPERATION_QUEUE_UNWAIT_SYNC_OBJECT = 2,
+	UMSCH_LOG_OPERATION_QUEUE_NO_MORE_WORK = 3,
+	UMSCH_LOG_OPERATION_QUEUE_WAIT_SYNC_OBJECT = 4,
+	UMSCH_LOG_OPERATION_QUEUE_INVALID = 0xF,
+};
+
+struct UMSCH_INSTANCE_DB_OFFSET {
+	uint32_t instance_index;
+	uint32_t doorbell_offset;
+};
+
+struct UMSCH_LOG_CONTEXT_STATE_CHANGE {
+	uint64_t h_context;
+	enum UMSCH_MS_LOG_CONTEXT_STATE new_context_state;
+};
+
+struct UMSCH_LOG_QUEUE_NEW_WORK {
+	uint64_t h_queue;
+	uint64_t reserved;
+};
+
+struct UMSCH_LOG_QUEUE_UNWAIT_SYNC_OBJECT {
+	uint64_t h_queue;
+	uint64_t h_sync_object;
+};
+
+struct UMSCH_LOG_QUEUE_NO_MORE_WORK {
+	uint64_t h_queue;
+	uint64_t reserved;
+};
+
+struct UMSCH_LOG_QUEUE_WAIT_SYNC_OBJECT {
+	uint64_t h_queue;
+	uint64_t h_sync_object;
+};
+
+struct UMSCH_LOG_ENTRY_HEADER {
+	uint32_t first_free_entry_index;
+	uint32_t wraparound_count;
+	uint64_t number_of_entries;
+	uint64_t reserved[2];
+};
+
+struct UMSCH_LOG_ENTRY_DATA {
+	uint64_t gpu_time_stamp;
+	uint32_t operation_type; /* operation_type is of UMSCH_LOG_OPERATION type */
+	uint32_t reserved_operation_type_bits;
+	union {
+		struct UMSCH_LOG_CONTEXT_STATE_CHANGE context_state_change;
+		struct UMSCH_LOG_QUEUE_NEW_WORK queue_new_work;
+		struct UMSCH_LOG_QUEUE_UNWAIT_SYNC_OBJECT queue_unwait_sync_object;
+		struct UMSCH_LOG_QUEUE_NO_MORE_WORK queue_no_more_work;
+		struct UMSCH_LOG_QUEUE_WAIT_SYNC_OBJECT queue_wait_sync_object;
+		uint64_t all[2];
+	};
+};
+
+struct UMSCH_LOG_BUFFER {
+	struct UMSCH_LOG_ENTRY_HEADER header;
+	struct UMSCH_LOG_ENTRY_DATA entries[1];
+};
+
+enum UMSCH_API_OPCODE {
+	UMSCH_API_SET_HW_RSRC = 0x00,
+	UMSCH_API_SET_SCHEDULING_CONFIG = 0x1,
+	UMSCH_API_ADD_QUEUE = 0x2,
+	UMSCH_API_REMOVE_QUEUE = 0x3,
+	UMSCH_API_PERFORM_YIELD = 0x4,
+	UMSCH_API_SUSPEND = 0x5,
+	UMSCH_API_RESUME = 0x6,
+	UMSCH_API_RESET = 0x7,
+	UMSCH_API_SET_LOG_BUFFER = 0x8,
+	UMSCH_API_CHANGE_CONTEXT_PRIORITY = 0x9,
+	UMSCH_API_QUERY_SCHEDULER_STATUS = 0xA,
+	UMSCH_API_UPDATE_AFFINITY = 0xB,
+	UMSCH_API_MAX = 0xFF
+};
+
+union UMSCH_API_HEADER {
+	struct {
+		uint32_t type : 4; /* 0 - Invalid; 1 - Scheduling; 2 - TBD */
+		uint32_t opcode : 8;
+		uint32_t dwsize : 8;
+		uint32_t reserved : 12;
+	};
+
+	uint32_t u32All;
+};
+
+enum UMSCH_AMD_PRIORITY_LEVEL {
+	AMD_PRIORITY_LEVEL_IDLE = 0,
+	AMD_PRIORITY_LEVEL_NORMAL = 1,
+	AMD_PRIORITY_LEVEL_FOCUS = 2,
+	AMD_PRIORITY_LEVEL_REALTIME = 3,
+	AMD_PRIORITY_NUM_LEVELS
+};
+
+enum UMSCH_ENGINE_TYPE {
+	UMSCH_ENGINE_TYPE_VCN0 = 0,
+	UMSCH_ENGINE_TYPE_VCN1 = 1,
+	UMSCH_ENGINE_TYPE_VCN = 2,
+	UMSCH_ENGINE_TYPE_VPE = 3,
+	UMSCH_ENGINE_TYPE_MAX
+};
+
+#define AFFINITY_DISABLE 0
+#define AFFINITY_ENABLE 1
+#define AFFINITY_MAX 2
+
+union UMSCH_AFFINITY {
+	struct {
+		unsigned int vcn0Affinity : 2; /* enable 1 disable 0 */
+		unsigned int vcn1Affinity : 2;
+		unsigned int reserved : 28;
+	};
+	unsigned int u32All;
+};
+
+struct UMSCH_API_STATUS {
+	uint64_t api_completion_fence_addr;
+	uint32_t api_completion_fence_value;
+};
+
+enum { MAX_VCN0_INSTANCES = 1 };
+enum { MAX_VCN1_INSTANCES = 1 };
+enum { MAX_VCN_INSTANCES = 2 };
+
+enum { MAX_VPE_INSTANCES = 1 };
+
+enum { MAX_VCN_QUEUES = 4 };
+enum { MAX_VPE_QUEUES = 8 };
+
+enum { MAX_QUEUES_IN_A_CONTEXT = 1 };
+
+enum { UMSCH_MAX_HWIP_SEGMENT = 8 };
+
+enum VM_HUB_TYPE {
+	VM_HUB_TYPE_GC = 0,
+	VM_HUB_TYPE_MM = 1,
+	VM_HUB_TYPE_MAX,
+};
+
+enum { VMID_INVALID = 0xffff };
+
+enum { MAX_VMID_MMHUB = 16 };
+
+union UMSCHAPI__SET_HW_RESOURCES {
+	struct {
+		union UMSCH_API_HEADER header;
+		uint32_t vmid_mask_mm_vcn;
+		uint32_t vmid_mask_mm_vpe;
+		uint32_t engine_mask;
+		uint32_t logging_vmid;
+		uint32_t vcn0_hqd_mask[MAX_VCN0_INSTANCES];
+		uint32_t vcn1_hqd_mask[MAX_VCN1_INSTANCES];
+		uint32_t vcn_hqd_mask[MAX_VCN_INSTANCES];
+		uint32_t vpe_hqd_mask[MAX_VPE_INSTANCES];
+		uint64_t g_sch_ctx_gpu_mc_ptr;
+		uint32_t mmhub_base[UMSCH_MAX_HWIP_SEGMENT];
+		uint32_t mmhub_version;
+		uint32_t osssys_base[UMSCH_MAX_HWIP_SEGMENT];
+		uint32_t osssys_version;
+		struct UMSCH_API_STATUS api_status;
+		union {
+			struct {
+				uint32_t disable_reset : 1;
+				uint32_t disable_umsch_log : 1;
+				uint32_t enable_level_process_quantum_check : 1;
+				uint32_t is_vcn0_enabled : 1;
+				uint32_t is_vcn1_enabled : 1;
+				uint32_t reserved : 27;
+			};
+			uint32_t uint32_all;
+		};
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+static_assert(sizeof(union UMSCHAPI__SET_HW_RESOURCES) <= API_FRAME_SIZE_IN_DWORDS * sizeof(uint32_t),
+			  "size of UMSCHAPI__SET_HW_RESOURCES must be less than 256 bytes");
+
+union UMSCHAPI__SET_SCHEDULING_CONFIG {
+	struct {
+		union UMSCH_API_HEADER header;
+		/*
+		 * Grace period when preempting another priority band for this priority band.
+		 * The value for idle priority band is ignored, as it never preempts other bands.
+		 */
+		uint64_t grace_period_other_levels[AMD_PRIORITY_NUM_LEVELS];
+
+		/* Default quantum for scheduling across processes within a priority band. */
+		uint64_t process_quantum_for_level[AMD_PRIORITY_NUM_LEVELS];
+
+		/* Default grace period for processes that preempt each other within a priority band. */
+		uint64_t process_grace_period_same_level[AMD_PRIORITY_NUM_LEVELS];
+
+		/*
+		 * For normal level this field specifies the target GPU percentage in situations
+		 * when it's starved by the high level. Valid values are between 0 and 50,
+		 * with the default being 10.
+		 */
+		uint32_t normal_yield_percent;
+
+		struct UMSCH_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union UMSCHAPI__ADD_QUEUE {
+	struct {
+		union UMSCH_API_HEADER header;
+		uint32_t process_id;
+		uint64_t page_table_base_addr;
+		uint64_t process_va_start;
+		uint64_t process_va_end;
+		uint64_t process_quantum;
+		uint64_t process_csa_addr;
+		uint64_t context_quantum;
+		uint64_t context_csa_addr;
+		uint32_t inprocess_context_priority;
+		enum UMSCH_AMD_PRIORITY_LEVEL context_global_priority_level;
+		uint32_t doorbell_offset_0;
+		uint32_t doorbell_offset_1;
+		union UMSCH_AFFINITY affinity;
+		uint64_t mqd_addr;
+		uint64_t h_context;
+		uint64_t h_queue;
+		enum UMSCH_ENGINE_TYPE engine_type;
+		uint32_t vm_context_cntl;
+
+		struct {
+			uint32_t is_context_suspended : 1;
+			uint32_t reserved : 31;
+		};
+		struct UMSCH_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+
+union UMSCHAPI__REMOVE_QUEUE {
+	struct {
+		union UMSCH_API_HEADER header;
+		uint32_t doorbell_offset_0;
+		uint32_t doorbell_offset_1;
+		uint64_t context_csa_addr;
+
+		struct UMSCH_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union UMSCHAPI__PERFORM_YIELD {
+	struct {
+		union UMSCH_API_HEADER header;
+		uint32_t dummy;
+		struct UMSCH_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union UMSCHAPI__SUSPEND {
+	struct {
+		union UMSCH_API_HEADER header;
+		uint64_t context_csa_addr;
+		uint64_t suspend_fence_addr;
+		uint32_t suspend_fence_value;
+
+		struct UMSCH_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+enum UMSCH_RESUME_OPTION {
+	CONTEXT_RESUME = 0,
+	ENGINE_SCHEDULE_RESUME = 1,
+};
+
+union UMSCHAPI__RESUME {
+	struct {
+		union UMSCH_API_HEADER header;
+
+		enum UMSCH_RESUME_OPTION resume_option;
+		uint64_t context_csa_addr; /* valid only for UMSCH_SWIP_CONTEXT_RESUME */
+		enum UMSCH_ENGINE_TYPE engine_type;
+
+		struct UMSCH_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+enum UMSCH_RESET_OPTION {
+	HANG_DETECT_AND_RESET = 0,
+	HANG_DETECT_ONLY = 1,
+};
+
+union UMSCHAPI__RESET {
+	struct {
+		union UMSCH_API_HEADER header;
+
+		enum UMSCH_RESET_OPTION reset_option;
+		uint64_t doorbell_offset_addr;
+		enum UMSCH_ENGINE_TYPE engine_type;
+
+		struct UMSCH_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union UMSCHAPI__SET_LOGGING_BUFFER {
+	struct {
+		union UMSCH_API_HEADER header;
+		/* There are separate log buffers for each queue type */
+		enum UMSCH_ENGINE_TYPE log_type;
+		/* Log buffer GPU Address */
+		uint64_t logging_buffer_addr;
+		/* Number of entries in the log buffer */
+		uint32_t number_of_entries;
+		/* Entry index at which CPU interrupt needs to be signalled */
+		uint32_t interrupt_entry;
+
+		struct UMSCH_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union UMSCHAPI__UPDATE_AFFINITY {
+	struct {
+		union UMSCH_API_HEADER header;
+		union UMSCH_AFFINITY affinity;
+		uint64_t context_csa_addr;
+		struct UMSCH_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union UMSCHAPI__CHANGE_CONTEXT_PRIORITY_LEVEL {
+	struct {
+		union UMSCH_API_HEADER header;
+		uint32_t inprocess_context_priority;
+		enum UMSCH_AMD_PRIORITY_LEVEL context_global_priority_level;
+		uint64_t context_quantum;
+		uint64_t context_csa_addr;
+		struct UMSCH_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union UMSCHAPI__QUERY_UMSCH_STATUS {
+	struct {
+		union UMSCH_API_HEADER header;
+		bool umsch_mm_healthy; /* 0 - not healthy, 1 - healthy */
+		struct UMSCH_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+#pragma pack(pop)
+
+#endif
-- 
2.41.0

