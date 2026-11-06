Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75710606A32C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NNjGtJqD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085E610E4C6;
	Fri,  6 Nov 2026 23:00:03 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6813610E4C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 22:59:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqG0Uf1Koi3SAt31/b6UY9ls24deY6P45LtsDUkUFJ1CfVgoKJYsplYJ6wJwKzbI9b7s/hzUA3Dwk3pJ+8zzYOz9pVS9ItP7fXHoWpm8bD2tj3os/fRvJh+GuTNod9gMBdblEaqCaZt5M0D/9Lcl2luTVcrwew/hfCxNZI933TqTK06Ux9OPsgmui8juIO+Hi4R0cbMVLay+rkKdiElTEfw3MyXGHXjEWbBYQLXUEWHyij9IbRLELzfT4Kw1F0miTc+YBqPUoxv875fnF/6Uh66BxtQP2UoFkUy1qfRojKBUPKrbIyb+0AVaB8DzG3BCXkYbGT6s1cmT0/csdGjuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cek38pFU2N8mBJRgoR5ndLNpGVg/afECTdIMWXK2uaI=;
 b=MODqnh2Qb9hPnOuqFdvgVe3ytwHLIMrZlSIf5Y86qkdD4+JfWSduugGEtVVM54KiYHVsri2l1Lskx2/s2X3V1UGVJtYqHeX/EKUlSRlUjE3wwk12wfsatXbqMpOAgrYitZZPCoX8KA66XGZAcEz0Yxpf4Qb8zL8aOuTA0zlQXzVlE3Ro1PEp6MMo3/ou+9rRKH+wNwhd6mqPht8wzTb4wiza/jsJfam8tSzpMMuBMfILI50l0wQ7lFqO8fGv6b86oPEgGpb85fFTzBsQKiX2lIFgHNnpVl2E1mkA6hOlbW9mf4Y8gLzFMuEtcHUp38cUO7q4z7L1Efd/sfSXUZBQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cek38pFU2N8mBJRgoR5ndLNpGVg/afECTdIMWXK2uaI=;
 b=NNjGtJqD7TQ9OyrW98/ac7xSC51iLIhiSkPvEQhbWxaivW/HyuVsFJcep1oV55mlCrJY2VmvblzwxvAi+krv/+UBVI5mJ+46OhUFVNMV5slm5byrlSR5tiqC6qrqS27h9VWbNxl1q9QlADTQubmRZb91P6SBgYiYbAR08bQoDHQ=
Received: from BN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:ee::18)
 by CH1PPF711010B62.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::614) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 22:59:28 +0000
Received: from BN7PEPF000000AA.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::57) by BN0PR04CA0013.outlook.office365.com
 (2603:10b6:408:ee::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 22:59:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000AA.mail.protection.outlook.com (10.167.245.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 22:59:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 16:59:27 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 16:59:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add gfx v13_0_1 irqsrc header
Date: Fri, 6 Nov 2026 17:59:10 -0500
Message-ID: <20261106225913.3569203-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106225913.3569203-1-alexander.deucher@amd.com>
References: <20261106225913.3569203-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AA:EE_|CH1PPF711010B62:EE_
X-MS-Office365-Filtering-Correlation-Id: f1441a04-d74c-468d-95cf-08df3c599c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|261102123227099003|261026140227099003|11063799006|56012099006|261022105027099003|261022113327099003|261021121427099003|261009223027099003|261022115727099003|261022075727099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: YP1PjeQrocIZa91/VnC5HlYCqSo/p4guT7iVotm8XCHJftInWEy/YI5GpBvQqc12kWEMtUOc/+3+FfY1H4bY6cGw9KKTIIb+VGQ+imdqn4vW+FzS9FSJ7d166dKPXi0J6jBaBmXZmf4PU9R7Cv5UKUMhkCfxOfW+dxNs6GxxUxgFTDN4SA4+l1jlrzu5IPITg8JIG/JyY58rKEFiUIRIZ2DQUfr+VyrN4JT7AtzJgaFIFga41jq7rWzi6VpZWpbRdXxaLC8/YJzwshFlvvhLAg6Fz8B8dI/YCnK4o68/JfenIEoppYesJr7ZvAgHKh9y1FtJlqBks5jhgq9OLG4bcFt7gIa8DgJTimgJHkmjsoV8VLLbP+xg+MCAtce6z6jG+Ip5WFPZzx0bT6/ttTu8L5tDrNFSVqP6oJ8GmIBdgH+/WEZPFybZbySy0BpI5712fGLV5UZ5aU1ah4Krd8tf3jw+XCJZbzAWe5FzQXtzG+WdqrbMm8FZ641cbZeOfkyaN78LEqqko3/OrCWdrt4nsUpIAroFOyX4Zs5PM6p7P3gCx6hr5pA05Sy5qDPY90rzWb28gLYck/Bly04+RLqwLNe8Nl5r+Nx8vAPnHdJiQHCW8Yj+DsaJrWmvITfsg2RDfyko8AG+Y2xi6IgMEEwJ+hRUYm3HlkA/3X2a9Ined1PvdyVj8Q2uqRpHrM4eln3RuYfH9TLsPG4ng7PHS+qNcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261102123227099003)(261026140227099003)(11063799006)(56012099006)(261022105027099003)(261022113327099003)(261021121427099003)(261009223027099003)(261022115727099003)(261022075727099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pRsrJA8igh7d5vNkfGUQ2TVNmdsSpgnqCmLHesIbICn1728+xvtlXerrpgK7MifbPZv96vWhzGOsVNQuAy7EhZZBlODhiy6ENwzc3CHndA7BEX92ttNYJ9aNW1Rtw/J25xyikvLnZKtfCEaxE9jCZrJME3JcvhYLg96V09GgBLz69hCOy9ZIQa4nlwzAXcN1LCe1ZRTIDNKl7MljDtLrva3bBh7Rt4Z86pVrV/47qjalsyHbwIaqV7r2abuRSvv1uGe5/F55Z+jbAJld595Pz1YkiULqLoanjLlXgmYvDY1PD1maei/qrWRjtnVEHjbMBC6Xcx0DDtRnJdYUtDQWv8ShG8j8Ac5d9Im2GtZ+k58GJWAA42a5ga8tZkzPHqDGJ8m6vsWa8cmVpg7KHL8PD9Pb1nyKjqkWauO1vmF8xV8lrNP2qMlwR8JfSIvIGAnA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 22:59:27.9522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1441a04-d74c-468d-95cf-08df3c599c2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000AA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF711010B62
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

To acommandate the specific irq source for gfx v13_0_1

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/ivsrcid/gfx/irqsrcs_gfx_13_0_1.h  | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_13_0_1.h

diff --git a/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_13_0_1.h b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_13_0_1.h
new file mode 100644
index 0000000000000..fead794fdf747
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_13_0_1.h
@@ -0,0 +1,77 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#ifndef __IRQSRCS_GFX_13_0_1_H__
+#define __IRQSRCS_GFX_13_0_1_H__
+
+#define GFX_13_0_1__SRCID__UTCL2_FAULT 				0	// 0x0 UTCL2 has encountered a fault scenario
+#define GFX_13_0_1__SRCID__UTCL2_RETRY 				1	// 0x1 UTCL2 has encountered a retry scenario
+#define GFX_13_0_1__SRCID__UTCL2_DATA_POISONING 		2	// 0x2 UTCL2 for data poisoning
+#define GFX_13_0_1__SRCID__UTCL2_Halt_On_Access 		3	// 0x3 UTCL2 Halt on Access
+#define GFX_13_0_1__SRCID__SDMA_ATOMIC_RTN_DONE			48	// 0x30 SDMA atomic*_rtn ops complete
+#define GFX_13_0_1__SRCID__SDMA_TRAP				49	// 0x31 Trap
+#define GFX_13_0_1__SRCID__SDMA_SRBMWRITE			50	// 0x32 SRBM write Protection
+#define GFX_13_0_1__SRCID__SDMA_CTXEMPTY			51	// 0x33 Context Empty
+#define GFX_13_0_1__SRCID__SDMA_PREEMPT				52	// 0x34 SDMA New Run List
+#define GFX_13_0_1__SRCID__SDMA_IB_PREEMPT			53	// 0x35 sdma mid - command buffer preempt interrupt
+#define GFX_13_0_1__SRCID__SDMA_DOORBELL_INVALID		54	// 0x36 Doorbell BE invalid
+#define GFX_13_0_1__SRCID__SDMA_QUEUE_HANG			55	// 0x37 Queue hang or Command timeout
+#define GFX_13_0_1__SRCID__SDMA_ATOMIC_TIMEOUT			56	// 0x38 SDMA atomic CMPSWAP loop timeout
+#define GFX_13_0_1__SRCID__SDMA_POLL_TIMEOUT			57	// 0x39 SRBM read poll timeout
+#define GFX_13_0_1__SRCID__SDMA_PAGE_TIMEOUT			58	// 0x3A Page retry  timeout after UTCL2 return nack = 1
+#define GFX_13_0_1__SRCID__SDMA_PAGE_NULL			59	// 0x3B Page Null from UTCL2 when nack = 2
+#define GFX_13_0_1__SRCID__SDMA_PAGE_FAULT			60	// 0x3C Page Fault Error from UTCL2 when nack = 3
+#define GFX_13_0_1__SRCID__SDMA_VM_HOLE				61	// 0x3D MC or SEM address in VM hole
+#define GFX_13_0_1__SRCID__SDMA_ECC				62	// 0x3E ECC Error
+#define GFX_13_0_1__SRCID__SDMA_FROZEN				63	// 0x3F SDMA Frozen
+#define GFX_13_0_1__SRCID__SDMA_SRAM_ECC			64	// 0x40 SRAM ECC Error
+#define GFX_13_0_1__SRCID__SDMA_SEM_INCOMPLETE_TIMEOUT		65	// 0x41 GPF(Sem incomplete timeout)
+#define GFX_13_0_1__SRCID__SDMA_SEM_WAIT_FAIL_TIMEOUT		66	// 0x42 Semaphore wait fail timeout
+#define GFX_13_0_1__SRCID__SDMA_FENCE				70	// 0x46 User fence
+#define GFX_13_0_1__SRCID__CP_RB_INTERRUPT 			176	// 0xB0 CP_INTERRUPT pkt in RB
+#define GFX_13_0_1__SRCID__CP_IB1_INTERRUPT 			177	// 0xB1 CP_INTERRUPT pkt in IB1
+#define GFX_13_0_1__SRCID__CP_IB2_INTERRUPT 			178	// 0xB2 CP_INTERRUPT pkt in IB1
+#define GFX_13_0_1__SRCID__CP_DMA_WATCH_INTERRUPT 		179	// 0xB3 CP DMA Watch interrupt
+#define GFX_13_0_1__SRCID__CP_PM4_PKT_RSVD_BIT_ERROR		180	// 0xB4 PM4 Pkt Rsvd Bits Error
+#define GFX_13_0_1__SRCID__CP_EOP_INTERRUPT			181	// 0xB5 End-of-Pipe Interrupt
+#define GFX_13_0_1__SRCID__CP_BAD_OPCODE_ERROR			183	// 0xB7 Bad Opcode Error
+#define GFX_13_0_1__SRCID__CP_PRIV_REG_FAULT			184	// 0xB8 Privileged Register Fault
+#define GFX_13_0_1__SRCID__CP_PRIV_INSTR_FAULT			185	// 0xB9 Privileged Instr Fault
+#define GFX_13_0_1__SRCID__CP_WAIT_MEM_SEM_FAULT		186	// 0xBA Wait Memory Semaphore Fault (Sync Object Fault)
+#define GFX_13_0_1__SRCID__CP_CTX_EMPTY_INTERRUPT		187	// 0xBB Context Empty Interrupt
+#define GFX_13_0_1__SRCID__CP_CTX_BUSY_INTERRUPT		188	// 0xBC Context Busy Interrupt
+#define GFX_13_0_1__SRCID__CP_ME_WAIT_REG_MEM_POLL_TIMEOUT	192	// 0xC0 CP.ME Wait_Reg_Mem Poll Timeout
+#define GFX_13_0_1__SRCID__CP_SIG_INCOMPLETE			193	// 0xC1 "Surface Probe Fault Signal Incomplete"
+#define GFX_13_0_1__SRCID__CP_PREEMPT_ACK			194	// 0xC2 Preemption Ack-wledge
+#define GFX_13_0_1__SRCID__CP_GPF				195	// 0xC3 General Protection Fault (GPF)
+#define GFX_13_0_1__SRCID__CP_GDS_ALLOC_ERROR			196	// 0xC4 GDS Alloc Error
+#define GFX_13_0_1__SRCID__CP_ECC_ERROR				197	// 0xC5 ECC  Error
+#define GFX_13_0_1__SRCID__CP_VM_DOORBELL			200	// 0xC8 Unattached VM Doorbell Received
+#define GFX_13_0_1__SRCID__CP_FUE_ERROR				201	// 0xC9 ECC FUE Error
+#define GFX_13_0_1__SRCID__CP_SUSPEND_REQ_INTERRUPT 		202	// 0xCA CP Suspend Completion interrupt
+#define GFX_13_0_1__SRCID__CP_RESUME_REQ_INTERRUPT 		203	// 0xCB CP Resume Completion Interrupt
+#define GFX_13_0_1__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT	202	// 0xCA RLC Streaming Perf Monitor Interrupt
+#define GFX_13_0_1__SRCID__GRBM_RD_TIMEOUT_ERROR		232	// 0xE8 CRead timeout error
+#define GFX_13_0_1__SRCID__GRBM_REG_GUI_IDLE			233	// 0xE9 Register GUI Idle
+#define GFX_13_0_1__SRCID__SQ_INTERRUPT_ID			239	// 0xEF SQ Interrupt (ttrace wrap, errors)
+
+#endif
-- 
2.56.0

