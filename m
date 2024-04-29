Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FFBC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D20112CA6;
	Mon, 29 Apr 2024 14:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UH5Iqm4H";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030EA10EE8E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rjn+oIY8jPwLnbrCSIA1/lDwl/tJg5tBH0QmP11yQOveDyYebkH3nUAL4F/zlmuHGHmUhpZMZMDFwiUP4d9OWNRDHIn7H3tZI94+pzET/JPYFGiNU4GMT8ofW3+79uKa/2qnzGnAEFRaW4nnMIm9oucdw0qG5b+r+F3KXVeK4XxNSK58V9596C04qFv6omxTNn8a71s6oZM1ufwgINhJiQX6XBheOz4xHsQ670k4+7uX4ibzrVx9WBBfGfiJW30INrZgD6zczcc0ElJYiuBmkBinKUdqNevezJVyGfpV9XVWDB5DXQushfC8FTvT602HjEJumy+vUY94v2Wy1sxhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQEOIauiDkthBL1jqDYq3yzPMqG3iutbw+KLXMBjTEI=;
 b=QgqvxOQsU/nm/wo8N7HT1Cv/rQbiWBXukoAa1qsp5MKuTfNCBIwwdCW9ltXzTbaVfHa0yaCS65eHzJoNiHCGE3+eewWvMHLHaREVPdK0yc0Se0w73H/k5e0q96Q1V9AeKqHW3YVhYTnTVaK4+WUJ2FRldw+TyapQOtV7EolDp3ifVGHsf7VkhKElDPWhkSbt7Fnax1PHAqlH4aVoKHvmlBQae0Si4oQJ5BUCbIlaI7/LWvq6ACJeWhT5VTFKbjCHxbaVRWJ1F1B+Ct8jh8BYjJr4v2Ndy2Yz2CWgB4fxW2QmDwPYPzKKhFvKPhFp/oG3sam+Y4L8Wshxm6D/nSrZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQEOIauiDkthBL1jqDYq3yzPMqG3iutbw+KLXMBjTEI=;
 b=UH5Iqm4HKLtE5j10PbSNlapieXq9xipBvrSFl03PmIIgIR4cZNQxzTxpl7BKH6TupbCkK40V0UXqdXPj5+BjOzR+qdNHMmtXjWhqK6dLWSgiEv4TkmeH1GIip3VTv83B86Zq8sRm/u2M4jd2YPTSCmm8SaadsKb0K4Je80zqsuc=
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:34:09 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::f9) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 06/31] drm/amdgpu: Add mes_v12_api_def.h for gfx12
Date: Mon, 29 Apr 2024 10:33:14 -0400
Message-ID: <20240429143339.3450256-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d8581d-55b6-460f-ab5f-08dc68596e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t6q+ddpzy/eTznF3ZlNo+5rri9fj82wEZDWYQv9nkgRTc6iLJLm0bpvrJUIu?=
 =?us-ascii?Q?3ybRMPNvifloEqelxQWFxqGcy7Fbs2dUGXe1NvPBa1uXkmHss0QrG4dM4R/w?=
 =?us-ascii?Q?NTUeIJdJwUlxjUSodk0j23OscSQLtNHfMV7+PBIn5LTv08j/iNFCSZRFOziz?=
 =?us-ascii?Q?/+6Fp9w7QwQdKbzcoJUOYyDqcm9TLHTOUevrn114hVWsN2pgCULp3qe/OOA1?=
 =?us-ascii?Q?SiUs43KlJo/R4Uvm+IH1z2D3iENU/7cvYVJblfJKy1ADUSZ6wtEkZXzHS4GB?=
 =?us-ascii?Q?9ge9a351RsZCfdJXYsuVDxCvZbn/zKI6Nj4ZSbp/lMceq83GMEmsOi549hwt?=
 =?us-ascii?Q?Kp5/VC096gWnHiN9YDlIL+zTeJromDpQDaC4HrC5FdULB6egCrmwpDxBGl9U?=
 =?us-ascii?Q?MIBPk1FE1BuP9l6NLkOK8GfrabSmQAhCOkGgYrAriwzht+j4k+P2TzkXy0fx?=
 =?us-ascii?Q?zE+8r2RLbUHtfQ7nSVDvAEVJIZvQM387sICUK6ns2rfJy1aKx2pe7qEPAoay?=
 =?us-ascii?Q?4vN7voBDVQbKzLHZ0Kid1cat2sbTgBJxR7eNfOBd8HsDGU3vWQYsSY+A2ZeQ?=
 =?us-ascii?Q?8STw6huh+QrKI9236sMLDNAJ5U3K9Iw8sbki0GPIqEQAO3fpfKVnHYiNIWxX?=
 =?us-ascii?Q?/spPe/OBuX3U2JH9rATPHkWNs1TE98x0At8cenCYv9jw8yCGXBctiv5znaic?=
 =?us-ascii?Q?62FJc8iKEp16vBSyRr1kUPRMG7OhzpgoBY8F55T2xEAuufG4aFEjb46U3syK?=
 =?us-ascii?Q?W8X99986qD+Gr3LxeswlkvGvIGpWHJdIeDmS+EmyKXs2wqQ/LrxUdmQddKUa?=
 =?us-ascii?Q?8mpV/LLAt5TXyEu0KYFKtOdfdwxYQmFZnURUiXKtErkjVQzRrrHLGq1lMscy?=
 =?us-ascii?Q?bi1PQISbYKpJBWLQEyO62Gs1cOhpp8LVQrB5utKrGWBC1i4D5MjE1PmC3It8?=
 =?us-ascii?Q?2svJnhow4gdNNCNnju2G/wuqhi8E0jMk4+70eo5JxQgtzb+hPe2KlQkpj6SF?=
 =?us-ascii?Q?IFP+2R/Qq8XQ7/xMiNHFXBK7PeqNwAnr9RSDAq/NuXNJEWCOrimkyZqPPR9K?=
 =?us-ascii?Q?Bvw2P741A9im8kIi9zcBystp0vcQKNwXom2YftG0G+dB/xJesf+3Z9oM0uys?=
 =?us-ascii?Q?2BsiLUD2IrVYPXdEcEZG+cACd94pfa62y9RjNqFsMFM5mbiV99WCUIGehj/w?=
 =?us-ascii?Q?Umk91jHrfQj5mt8UmNY6Hl50cVJzyeKRB1n93AhnTpHjjo1jPHEG6pycMIZI?=
 =?us-ascii?Q?dSpRxX6fznsrJqkbydoEFdmWQY6yCw5JpGU1svWXZHFFRfP3wSmkBFtQX3t5?=
 =?us-ascii?Q?TzgZFrPlvPsu+jUZAi8r4jPI6AxOFq5o1LDE4jIWrRHgby2DOu3d/NODyEU1?=
 =?us-ascii?Q?uJb+6R0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:08.5433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d8581d-55b6-460f-ab5f-08dc68596e00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Add MES_v12 header definition for gfx12

v2: Modify SET_SHADER_DEBUGGER to match mes_v11 definition. This doesn't
change the structure layout

v3: Removed unncessary comment and spaces

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 775 ++++++++++++++++++
 1 file changed, 775 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/mes_v12_api_def.h

diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
new file mode 100644
index 0000000000000..81cc0a5540492
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -0,0 +1,775 @@
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
+#ifndef __MES_API_DEF_H__
+#define __MES_API_DEF_H__
+
+#pragma pack(push, 8)
+
+#define MES_API_VERSION 0x14
+
+/* Driver submits one API(cmd) as a single Frame and this command size is same for all API
+ * to ease the debugging and parsing of ring buffer.
+ */
+enum {API_FRAME_SIZE_IN_DWORDS = 64};
+
+/* To avoid command in scheduler context to be overwritten whenenver mutilple interrupts come in,
+ * this creates another queue
+ */
+enum {API_NUMBER_OF_COMMAND_MAX   = 32};
+
+enum MES_API_TYPE {
+	MES_API_TYPE_SCHEDULER = 1,
+	MES_API_TYPE_MAX
+};
+
+enum MES_SCH_API_OPCODE {
+	MES_SCH_API_SET_HW_RSRC			= 0,
+	MES_SCH_API_SET_SCHEDULING_CONFIG	= 1, /* agreegated db, quantums, etc */
+	MES_SCH_API_ADD_QUEUE			= 2,
+	MES_SCH_API_REMOVE_QUEUE		= 3,
+	MES_SCH_API_PERFORM_YIELD		= 4,
+	MES_SCH_API_SET_GANG_PRIORITY_LEVEL	= 5, /* For windows GANG = Context */
+	MES_SCH_API_SUSPEND			= 6,
+	MES_SCH_API_RESUME			= 7,
+	MES_SCH_API_RESET			= 8,
+	MES_SCH_API_SET_LOG_BUFFER		= 9,
+	MES_SCH_API_CHANGE_GANG_PRORITY		= 10,
+	MES_SCH_API_QUERY_SCHEDULER_STATUS	= 11,
+	MES_SCH_API_SET_DEBUG_VMID		= 13,
+	MES_SCH_API_MISC			= 14,
+	MES_SCH_API_UPDATE_ROOT_PAGE_TABLE	= 15,
+	MES_SCH_API_AMD_LOG			= 16,
+	MES_SCH_API_SET_SE_MODE			= 17,
+	MES_SCH_API_SET_GANG_SUBMIT		= 18,
+
+	MES_SCH_API_MAX = 0xFF
+};
+
+union MES_API_HEADER {
+	struct {
+		uint32_t type	  : 4; /* 0 - Invalid; 1 - Scheduling; 2 - TBD */
+		uint32_t opcode   : 8;
+		uint32_t dwsize   : 8; /* including header */
+		uint32_t reserved : 12;
+	};
+
+	uint32_t u32All;
+};
+
+enum MES_AMD_PRIORITY_LEVEL {
+	AMD_PRIORITY_LEVEL_LOW		= 0,
+	AMD_PRIORITY_LEVEL_NORMAL	= 1,
+	AMD_PRIORITY_LEVEL_MEDIUM	= 2,
+	AMD_PRIORITY_LEVEL_HIGH		= 3,
+	AMD_PRIORITY_LEVEL_REALTIME	= 4,
+
+	AMD_PRIORITY_NUM_LEVELS
+};
+
+enum MES_QUEUE_TYPE {
+	MES_QUEUE_TYPE_GFX,
+	MES_QUEUE_TYPE_COMPUTE,
+	MES_QUEUE_TYPE_SDMA,
+
+	MES_QUEUE_TYPE_MAX,
+};
+
+struct MES_API_STATUS {
+	uint64_t api_completion_fence_addr;
+	uint64_t api_completion_fence_value;
+};
+
+
+enum { MAX_COMPUTE_PIPES = 8 };
+enum { MAX_GFX_PIPES	 = 2 };
+enum { MAX_SDMA_PIPES	 = 2 };
+
+enum { MAX_COMPUTE_HQD_PER_PIPE		= 8 };
+enum { MAX_GFX_HQD_PER_PIPE		= 8 };
+enum { MAX_SDMA_HQD_PER_PIPE		= 10 };
+enum { MAX_SDMA_HQD_PER_PIPE_11_0	= 8 };
+
+
+enum { MAX_QUEUES_IN_A_GANG = 8 };
+
+enum VM_HUB_TYPE {
+	VM_HUB_TYPE_GC = 0,
+	VM_HUB_TYPE_MM = 1,
+
+	VM_HUB_TYPE_MAX,
+};
+
+enum { VMID_INVALID = 0xffff };
+
+enum { MAX_VMID_GCHUB = 16 };
+enum { MAX_VMID_MMHUB = 16 };
+
+enum SET_DEBUG_VMID_OPERATIONS {
+	DEBUG_VMID_OP_PROGRAM	= 0,
+	DEBUG_VMID_OP_ALLOCATE	= 1,
+	DEBUG_VMID_OP_RELEASE	= 2,
+	DEBUG_VMID_OP_VM_SETUP	= 3 // used to set up the debug vmid page table in the kernel queue case (mode 1)
+};
+
+enum MES_MS_LOG_CONTEXT_STATE {
+	MES_LOG_CONTEXT_STATE_IDLE		= 0,
+	MES_LOG_CONTEXT_STATE_RUNNING		= 1,
+	MES_LOG_CONTEXT_STATE_READY		= 2,
+	MES_LOG_CONTEXT_STATE_READY_STANDBY	= 3,
+	MES_LOG_CONTEXT_STATE_INVALID		= 0xF,
+};
+
+enum MES_MS_LOG_OPERATION {
+	MES_LOG_OPERATION_CONTEXT_STATE_CHANGE		= 0,
+	MES_LOG_OPERATION_QUEUE_NEW_WORK		= 1,
+	MES_LOG_OPERATION_QUEUE_UNWAIT_SYNC_OBJECT	= 2,
+	MES_LOG_OPERATION_QUEUE_NO_MORE_WORK		= 3,
+	MES_LOG_OPERATION_QUEUE_WAIT_SYNC_OBJECT	= 4,
+	MES_LOG_OPERATION_QUEUE_INVALID			= 0xF,
+};
+
+struct MES_LOG_CONTEXT_STATE_CHANGE {
+	uint64_t			h_context;
+	enum MES_MS_LOG_CONTEXT_STATE	new_context_state;
+};
+
+struct MES_LOG_QUEUE_NEW_WORK {
+	uint64_t	h_queue;
+	uint64_t	reserved;
+};
+
+struct MES_LOG_QUEUE_UNWAIT_SYNC_OBJECT {
+	uint64_t	h_queue;
+	uint64_t	h_sync_object;
+};
+
+struct MES_LOG_QUEUE_NO_MORE_WORK {
+	uint64_t	h_queue;
+	uint64_t	reserved;
+};
+
+struct MES_LOG_QUEUE_WAIT_SYNC_OBJECT {
+	uint64_t	h_queue;
+	uint64_t	h_sync_object;
+};
+
+struct MES_LOG_ENTRY_HEADER {
+	uint32_t first_free_entry_index;
+	uint32_t wraparound_count;
+	uint64_t number_of_entries;
+	uint64_t reserved[2];
+};
+
+struct MES_LOG_ENTRY_DATA {
+	uint64_t gpu_time_stamp;
+	uint32_t operation_type; /* operation_type is of MES_LOG_OPERATION type */
+	uint32_t reserved_operation_type_bits;
+	union {
+		struct MES_LOG_CONTEXT_STATE_CHANGE context_state_change;
+		struct MES_LOG_QUEUE_NEW_WORK queue_new_work;
+		struct MES_LOG_QUEUE_UNWAIT_SYNC_OBJECT queue_unwait_sync_object;
+		struct MES_LOG_QUEUE_NO_MORE_WORK queue_no_more_work;
+		struct MES_LOG_QUEUE_WAIT_SYNC_OBJECT queue_wait_sync_object;
+		uint64_t all[2];
+	};
+};
+
+struct MES_LOG_BUFFER {
+	struct MES_LOG_ENTRY_HEADER header;
+	struct MES_LOG_ENTRY_DATA	entries[];
+};
+
+enum MES_SWIP_TO_HWIP_DEF {
+	MES_MAX_HWIP_SEGMENT = 8,
+};
+
+union MESAPI_SET_HW_RESOURCES {
+	struct {
+		union MES_API_HEADER	header;
+		uint32_t		vmid_mask_mmhub;
+		uint32_t		vmid_mask_gfxhub;
+		uint32_t		gds_size;
+		uint32_t		paging_vmid;
+		uint32_t		compute_hqd_mask[MAX_COMPUTE_PIPES];
+		uint32_t		gfx_hqd_mask[MAX_GFX_PIPES];
+		uint32_t		sdma_hqd_mask[MAX_SDMA_PIPES];
+		uint32_t		aggregated_doorbells[AMD_PRIORITY_NUM_LEVELS];
+		uint64_t		g_sch_ctx_gpu_mc_ptr;
+		uint64_t		query_status_fence_gpu_mc_ptr;
+		uint32_t		gc_base[MES_MAX_HWIP_SEGMENT];
+		uint32_t		mmhub_base[MES_MAX_HWIP_SEGMENT];
+		uint32_t		osssys_base[MES_MAX_HWIP_SEGMENT];
+		struct MES_API_STATUS	api_status;
+		union {
+			struct {
+				uint32_t disable_reset : 1;
+				uint32_t use_different_vmid_compute : 1;
+				uint32_t disable_mes_log   : 1;
+				uint32_t apply_mmhub_pgvm_invalidate_ack_loss_wa : 1;
+				uint32_t apply_grbm_remote_register_dummy_read_wa : 1;
+				uint32_t second_gfx_pipe_enabled : 1;
+				uint32_t enable_level_process_quantum_check : 1;
+				uint32_t legacy_sch_mode : 1;
+				uint32_t disable_add_queue_wptr_mc_addr : 1;
+				uint32_t enable_mes_event_int_logging : 1;
+				uint32_t enable_reg_active_poll : 1;
+				uint32_t use_disable_queue_in_legacy_uq_preemption : 1;
+				uint32_t send_write_data : 1;
+				uint32_t os_tdr_timeout_override : 1;
+				uint32_t use_rs64mem_for_proc_gang_ctx : 1;
+				uint32_t reserved : 17;
+			};
+			uint32_t uint32_all;
+		};
+	uint32_t	oversubscription_timer;
+	uint64_t	doorbell_info;
+	uint64_t	event_intr_history_gpu_mc_ptr;
+	uint64_t	timestamp;
+	uint32_t	os_tdr_timeout_in_sec;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__ADD_QUEUE {
+	struct {
+		union MES_API_HEADER	header;
+		uint32_t		process_id;
+		uint64_t		page_table_base_addr;
+		uint64_t		process_va_start;
+		uint64_t		process_va_end;
+		uint64_t		process_quantum;
+		uint64_t		process_context_addr;
+		uint64_t		gang_quantum;
+		uint64_t		gang_context_addr;
+		uint32_t		inprocess_gang_priority;
+		enum MES_AMD_PRIORITY_LEVEL gang_global_priority_level;
+		uint32_t		doorbell_offset;
+		uint64_t		mqd_addr;
+		/* From MES_API_VERSION 2, mc addr is expected for wptr_addr */
+		uint64_t		wptr_addr;
+		uint64_t		h_context;
+		uint64_t		h_queue;
+		enum MES_QUEUE_TYPE	queue_type;
+		uint32_t		gds_base;
+		union {
+			/* backwards compatibility with Linux, remove union once they use kfd_queue_size */
+			uint32_t	gds_size;
+			uint32_t	kfd_queue_size;
+		};
+		uint32_t		gws_base;
+		uint32_t		gws_size;
+		uint32_t		oa_mask;
+		uint64_t		trap_handler_addr;
+		uint32_t		vm_context_cntl;
+
+		struct {
+			uint32_t paging	 : 1;
+			uint32_t debug_vmid  : 4;
+			uint32_t program_gds : 1;
+			uint32_t is_gang_suspended : 1;
+			uint32_t is_tmz_queue : 1;
+			uint32_t map_kiq_utility_queue : 1;
+			uint32_t is_kfd_process : 1;
+			uint32_t trap_en : 1;
+			uint32_t is_aql_queue : 1;
+			uint32_t skip_process_ctx_clear : 1;
+			uint32_t map_legacy_kq : 1;
+			uint32_t exclusively_scheduled : 1;
+			uint32_t is_long_running : 1;
+			uint32_t is_dwm_queue : 1;
+			uint32_t reserved	 : 15;
+		};
+		struct MES_API_STATUS	api_status;
+		uint64_t		tma_addr;
+		uint32_t		sch_id;
+		uint64_t		timestamp;
+		uint32_t		process_context_array_index;
+		uint32_t		gang_context_array_index;
+		uint32_t		pipe_id;	//used for mapping legacy kernel queue
+		uint32_t		queue_id;
+		uint32_t		alignment_mode_setting;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__REMOVE_QUEUE {
+	struct {
+		union MES_API_HEADER	header;
+		uint32_t		doorbell_offset;
+		uint64_t		gang_context_addr;
+
+		struct {
+			uint32_t reserved01		  : 1;
+			uint32_t unmap_kiq_utility_queue  : 1;
+			uint32_t preempt_legacy_gfx_queue : 1;
+			uint32_t unmap_legacy_queue	  : 1;
+			uint32_t reserved		  : 28;
+		};
+		struct MES_API_STATUS		api_status;
+
+		uint32_t			pipe_id;
+		uint32_t			queue_id;
+
+		uint64_t			tf_addr;
+		uint32_t			tf_data;
+
+		enum MES_QUEUE_TYPE		queue_type;
+		uint64_t			timestamp;
+		uint32_t			gang_context_array_index;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SET_SCHEDULING_CONFIG {
+	struct {
+		union MES_API_HEADER	header;
+		/* Grace period when preempting another priority band for this priority band.
+		 * The value for idle priority band is ignored, as it never preempts other bands.
+		 */
+		uint64_t		grace_period_other_levels[AMD_PRIORITY_NUM_LEVELS];
+
+		/* Default quantum for scheduling across processes within a priority band. */
+		uint64_t		process_quantum_for_level[AMD_PRIORITY_NUM_LEVELS];
+
+		/* Default grace period for processes that preempt each other within a priority band.*/
+		uint64_t		process_grace_period_same_level[AMD_PRIORITY_NUM_LEVELS];
+
+		/* For normal level this field specifies the target GPU percentage in situations when it's starved by the high level.
+		 * Valid values are between 0 and 50, with the default being 10.
+		 */
+		uint32_t		normal_yield_percent;
+
+		struct MES_API_STATUS	api_status;
+		uint64_t		timestamp;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__PERFORM_YIELD {
+	struct {
+		union MES_API_HEADER	header;
+		uint32_t		dummy;
+		struct MES_API_STATUS	api_status;
+		uint64_t		timestamp;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__CHANGE_GANG_PRIORITY_LEVEL {
+	struct {
+		union MES_API_HEADER		header;
+		uint32_t			inprocess_gang_priority;
+		enum MES_AMD_PRIORITY_LEVEL gang_global_priority_level;
+		uint64_t			gang_quantum;
+		uint64_t			gang_context_addr;
+		struct MES_API_STATUS		api_status;
+		uint32_t			doorbell_offset;
+		uint64_t			timestamp;
+		uint32_t			gang_context_array_index;
+		struct {
+			uint32_t		queue_quantum_scale	: 2;
+			uint32_t		queue_quantum_duration	: 8;
+			uint32_t		apply_quantum_all_processes : 1;
+			uint32_t		reserved		: 21;
+		};
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SUSPEND {
+	struct {
+		union MES_API_HEADER	header;
+		/* false - suspend all gangs; true - specific gang */
+		struct {
+			uint32_t	suspend_all_gangs : 1;
+			uint32_t	reserved : 31;
+		};
+		/* gang_context_addr is valid only if suspend_all = false */
+
+		uint64_t		gang_context_addr;
+
+		uint64_t		suspend_fence_addr;
+		uint32_t		suspend_fence_value;
+
+		struct MES_API_STATUS	api_status;
+
+		union {
+			uint32_t return_value; // to be removed
+			uint32_t sch_id;       //keep the old return_value temporarily for compatibility
+		};
+		uint32_t		doorbell_offset;
+		uint64_t		timestamp;
+		enum MES_QUEUE_TYPE	legacy_uq_type;
+		enum MES_AMD_PRIORITY_LEVEL legacy_uq_priority_level;
+		uint32_t		gang_context_array_index;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__RESUME {
+	struct {
+		union MES_API_HEADER	header;
+		/* false - resume all gangs; true - specified gang */
+		struct {
+			uint32_t	resume_all_gangs : 1;
+			uint32_t	reserved : 31;
+		};
+		/* valid only if resume_all_gangs = false */
+		uint64_t		gang_context_addr;
+
+		struct MES_API_STATUS	api_status;
+		uint32_t		doorbell_offset;
+		uint64_t		timestamp;
+		uint32_t		gang_context_array_index;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__RESET {
+	struct {
+		union MES_API_HEADER		header;
+
+		struct {
+			/* Only reset the queue given by doorbell_offset (not entire gang) */
+			uint32_t		reset_queue_only : 1;
+			/* Hang detection first then reset any queues that are hung */
+			uint32_t		hang_detect_then_reset : 1;
+			/* Only do hang detection (no reset) */
+			uint32_t		hang_detect_only : 1;
+			/* Reset HP and LP kernel queues not managed by MES */
+			uint32_t		reset_legacy_gfx : 1;
+			/* Fallback to use conneceted queue index when CP_CNTX_STAT method fails (gfx pipe 0) */
+			uint32_t		use_connected_queue_index : 1;
+			/* For gfx pipe 1 */
+			uint32_t		use_connected_queue_index_p1 : 1;
+			uint32_t		reserved : 26;
+		};
+
+		uint64_t			gang_context_addr;
+
+		/* valid only if reset_queue_only = true */
+		uint32_t			doorbell_offset;
+
+		/* valid only if hang_detect_then_reset = true */
+		uint64_t			doorbell_offset_addr;
+		enum MES_QUEUE_TYPE		queue_type;
+
+		/* valid only if reset_legacy_gfx = true */
+		uint32_t			pipe_id_lp;
+		uint32_t			queue_id_lp;
+		uint32_t			vmid_id_lp;
+		uint64_t			mqd_mc_addr_lp;
+		uint32_t			doorbell_offset_lp;
+		uint64_t			wptr_addr_lp;
+
+		uint32_t			pipe_id_hp;
+		uint32_t			queue_id_hp;
+		uint32_t			vmid_id_hp;
+		uint64_t			mqd_mc_addr_hp;
+		uint32_t			doorbell_offset_hp;
+		uint64_t			wptr_addr_hp;
+
+		struct MES_API_STATUS		api_status;
+		uint32_t			active_vmids;
+		uint64_t			timestamp;
+
+		uint32_t			gang_context_array_index;
+
+		uint32_t			connected_queue_index;
+		uint32_t			connected_queue_index_p1;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SET_LOGGING_BUFFER {
+	struct {
+		union MES_API_HEADER		header;
+		/* There are separate log buffers for each queue type */
+		enum MES_QUEUE_TYPE		log_type;
+		/* Log buffer GPU Address */
+		uint64_t			logging_buffer_addr;
+		/* number of entries in the log buffer */
+		uint32_t			number_of_entries;
+		/* Entry index at which CPU interrupt needs to be signalled */
+		uint32_t			interrupt_entry;
+
+		struct MES_API_STATUS		api_status;
+		uint64_t			timestamp;
+		uint32_t			vmid;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+enum MES_API_QUERY_MES_OPCODE {
+	MES_API_QUERY_MES__GET_CTX_ARRAY_SIZE,
+	MES_API_QUERY_MES__CHECK_HEALTHY,
+	MES_API_QUERY_MES__MAX,
+};
+
+enum { QUERY_MES_MAX_SIZE_IN_DWORDS = 20 };
+
+struct MES_API_QUERY_MES__CTX_ARRAY_SIZE {
+	uint64_t	proc_ctx_array_size_addr;
+	uint64_t	gang_ctx_array_size_addr;
+};
+
+struct MES_API_QUERY_MES__HEALTHY_CHECK {
+	uint64_t	healthy_addr;
+};
+
+union MESAPI__QUERY_MES_STATUS {
+	struct {
+		union MES_API_HEADER		header;
+		enum MES_API_QUERY_MES_OPCODE	subopcode;
+		struct MES_API_STATUS		api_status;
+		uint64_t			timestamp;
+		union {
+			struct MES_API_QUERY_MES__CTX_ARRAY_SIZE	ctx_array_size;
+			struct MES_API_QUERY_MES__HEALTHY_CHECK	healthy_check;
+			uint32_t data[QUERY_MES_MAX_SIZE_IN_DWORDS];
+		};
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SET_DEBUG_VMID {
+	struct {
+		union MES_API_HEADER	header;
+		struct MES_API_STATUS	api_status;
+		union {
+			struct {
+			uint32_t use_gds   : 1;
+			uint32_t operation : 2;
+			uint32_t reserved  : 29;
+			} flags;
+			uint32_t u32All;
+		};
+		uint32_t		reserved;
+		uint32_t		debug_vmid;
+		uint64_t		process_context_addr;
+		uint64_t		page_table_base_addr;
+		uint64_t		process_va_start;
+		uint64_t		process_va_end;
+		uint32_t		gds_base;
+		uint32_t		gds_size;
+		uint32_t		gws_base;
+		uint32_t		gws_size;
+		uint32_t		oa_mask;
+
+		uint64_t		output_addr; // output addr of the acquired vmid value
+
+		uint64_t		timestamp;
+
+		uint32_t		process_vm_cntl;
+		enum MES_QUEUE_TYPE	queue_type;
+
+		uint32_t		process_context_array_index;
+
+		uint32_t		alignment_mode_setting;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+enum MESAPI_MISC_OPCODE {
+	MESAPI_MISC__WRITE_REG,
+	MESAPI_MISC__INV_GART,
+	MESAPI_MISC__QUERY_STATUS,
+	MESAPI_MISC__READ_REG,
+	MESAPI_MISC__WAIT_REG_MEM,
+	MESAPI_MISC__SET_SHADER_DEBUGGER,
+	MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE,
+	MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
+
+	MESAPI_MISC__MAX,
+};
+
+enum {MISC_DATA_MAX_SIZE_IN_DWORDS = 20};
+
+struct WRITE_REG {
+	uint32_t	reg_offset;
+	uint32_t	reg_value;
+};
+
+struct READ_REG {
+	uint32_t reg_offset;
+	uint64_t buffer_addr;
+	union {
+		struct {
+			uint32_t read64Bits : 1;
+			uint32_t reserved : 31;
+		} bits;
+		uint32_t all;
+	} option;
+};
+
+struct INV_GART {
+	uint64_t	inv_range_va_start;
+	uint64_t	inv_range_size;
+};
+
+struct QUERY_STATUS {
+	uint32_t context_id;
+};
+
+enum WRM_OPERATION {
+	WRM_OPERATION__WAIT_REG_MEM,
+	WRM_OPERATION__WR_WAIT_WR_REG,
+
+	WRM_OPERATION__MAX,
+};
+
+struct WAIT_REG_MEM {
+	enum WRM_OPERATION op;
+	/* only function = equal_to_the_reference_value and mem_space = register_space supported for now */
+	uint32_t reference;
+	uint32_t mask;
+	uint32_t reg_offset1;
+	uint32_t reg_offset2;
+};
+
+struct SET_SHADER_DEBUGGER {
+	uint64_t process_context_addr;
+	union {
+		struct {
+			uint32_t single_memop : 1; // SQ_DEBUG.single_memop
+			uint32_t single_alu_op : 1; // SQ_DEBUG.single_alu_op
+			uint32_t reserved : 30;
+		};
+		uint32_t u32all;
+	} flags;
+	uint32_t spi_gdbg_per_vmid_cntl;
+	uint32_t tcp_watch_cntl[4]; // TCP_WATCHx_CNTL
+	uint32_t trap_en;
+};
+
+struct SET_GANG_SUBMIT {
+	uint64_t gang_context_addr;
+	uint64_t slave_gang_context_addr;
+	uint32_t gang_context_array_index;
+	uint32_t slave_gang_context_array_index;
+};
+
+union MESAPI__MISC {
+	struct {
+		union MES_API_HEADER	header;
+		enum MESAPI_MISC_OPCODE opcode;
+		struct MES_API_STATUS	api_status;
+		union {
+			struct WRITE_REG write_reg;
+			struct INV_GART inv_gart;
+			struct QUERY_STATUS query_status;
+			struct READ_REG read_reg;
+			struct WAIT_REG_MEM wait_reg_mem;
+			struct SET_SHADER_DEBUGGER set_shader_debugger;
+			enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
+
+			uint32_t data[MISC_DATA_MAX_SIZE_IN_DWORDS];
+		};
+		uint64_t		timestamp;
+		uint32_t		doorbell_offset;
+		uint32_t		os_fence;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__UPDATE_ROOT_PAGE_TABLE {
+	struct {
+		union MES_API_HEADER		header;
+		uint64_t			page_table_base_addr;
+		uint64_t			process_context_addr;
+		struct MES_API_STATUS		api_status;
+		uint64_t			timestamp;
+		uint32_t			process_context_array_index;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI_AMD_LOG {
+	struct {
+		union MES_API_HEADER		header;
+		uint64_t			p_buffer_memory;
+		uint64_t			p_buffer_size_used;
+		struct MES_API_STATUS		api_status;
+		uint64_t			timestamp;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+enum MES_SE_MODE {
+	MES_SE_MODE_INVALID	= 0,
+	MES_SE_MODE_SINGLE_SE	= 1,
+	MES_SE_MODE_DUAL_SE	= 2,
+	MES_SE_MODE_LOWER_POWER	= 3,
+};
+
+union MESAPI__SET_SE_MODE {
+	struct {
+		union MES_API_HEADER header;
+		/* the new SE mode to apply*/
+		enum MES_SE_MODE new_se_mode;
+		/* the fence to make sure the ItCpgCtxtSync packet is completed */
+		uint64_t cpg_ctxt_sync_fence_addr;
+		uint32_t cpg_ctxt_sync_fence_value;
+		/* log_seq_time - Scheduler logs the switch seq start/end ts in the IH cookies */
+		union {
+			struct {
+				uint32_t log_seq_time : 1;
+				uint32_t reserved : 31;
+			};
+			uint32_t uint32_all;
+		};
+		struct MES_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SET_GANG_SUBMIT {
+	struct {
+		union MES_API_HEADER	header;
+		struct MES_API_STATUS	api_status;
+		struct SET_GANG_SUBMIT	set_gang_submit;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+#pragma pack(pop)
+
+#endif
-- 
2.44.0

