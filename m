Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E615CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86CB410F044;
	Fri, 29 Apr 2022 17:36:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9787A10F04D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSuOJxUy7dTvbj0Amx24AEIi5U2lWIxmS+cYuckZ2P5WECJ0KHINVrO3NgGJXYf/xByPO+pJLwZsn7xWdayfH/Y8CGdHGkqCg9noeDWJyqXi/IF8iZZRPGGrylqJ/DWBreS3+36d3D7GbOxNkRk9i1Piw/O2p2K+4P3sqP8ZoojAa19SoBPZIW7bTJYEGqZg5/f2xSJ8wxZnTa8zylkx2q5bj3cvgdDeNCn8uV5FvbBlOBM/yHFvkaGrBBGK86HIR1ktaBOFXaxweOegc2sSgmQRHquljSG4G7vUfT6L4SbY71f3gGiINdTbT+X/Jf/ETyu9cXrsltucbTy/FhiMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUmKlVWUv24z7iasOAjEMnT/sqYtukcofbTyfj3G4nM=;
 b=FYTsxKJUXtOOsTh91dxxUf34S+vuYlcUKoQKXXo4dOqpa/jQiQxm3YW+nZmGaCbXRVccmaAHLMqiQ70DypINFgGkIIs11TKymXqj0CEIBLtKEkdCrTAzXNCUllv8zGTRqiH3mPnF7eDQO4zo4j7Kl+dxcSJxb/CQsOzC1E/l72IFULn2E804Gd9/xpQAzrJAAcg+kToAChCaqNDINiJ13QhZxEKuRMsyPVvTmI2CevfSlXcN4TM2BjkVjUgeq5Ak992YNYL04mLH9wZoOVLI0UCCAHdSM7VXp7lFtddlMU6UcA2de7hDQTQj7P5d7tCO3KaJjCLaw9rEktLetaOOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUmKlVWUv24z7iasOAjEMnT/sqYtukcofbTyfj3G4nM=;
 b=JBASvz4nEidh2uAVliuaX6Fzpxit4dx5Ieglwvg+Fq4NX3WcRuZ3vHCt//n8dgmL54q6Oi5Eaon14ZP3K7YPWQ5KLtakjow0qAOJujpM4R0Rvs3XVzAYOOEidW9UueqIrb77oCKTIhDqWVJEH6uz5D4a9CeCSvpMDTkdmtHIVmc=
Received: from BN9PR03CA0327.namprd03.prod.outlook.com (2603:10b6:408:112::32)
 by SN6PR12MB4622.namprd12.prod.outlook.com (2603:10b6:805:e2::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:36:31 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::26) by BN9PR03CA0327.outlook.office365.com
 (2603:10b6:408:112::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Fri, 29 Apr 2022 17:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:36:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:36:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdgpu: add irq src id for GFX11
Date: Fri, 29 Apr 2022 13:36:12 -0400
Message-ID: <20220429173617.433334-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be87cd2-1ea7-4cc2-52e5-08da2a06cc42
X-MS-TrafficTypeDiagnostic: SN6PR12MB4622:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB46226BF6C1459E22DACAEA39F7FC9@SN6PR12MB4622.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnLtciiCFYUYPj0CK7gPV16DVl8Bx32IFYhTOFEb2FOPumbQ04ffm4ma5V2MHs//icn7mWJ+uD5F4Y81MCGaUxzKfJtTDN+8A+LR63Sgj8fJPQ2JUifZmwxMuq031Wyhx6jVRaU5236yYJxaiYgJ5CMWvtQgRKJGY3uhVJ4ed5cuROlbjDYaRB98VAFMQSBgWpgeS7DGlDJt9LUjnB+qnJfnX//QDlD01hhr56YFEWvpbQjXC1++i6RO/fhZ4c8K4ffyrS18jQgonYoXsNG8XejTtfijr3LhZOGsI0gbT05a0Sw55KpAA/iGSikvqBJr7Xb2/QrIDDYvpTmAHrG2mxnorP+tHziLoKghvFkpl/Ic/tSD3/ou9XKnxBykKofpjUIg6IG8ki+aJ77Ax8y5rneJ8NCAUo6Lg91SX5uukbmBHsWkez56CXU4Cu/YIypwkYMBBsELR2pn5lqekWPXNNtw6LzPC5PE6zwHFG8XbJt1h8v7YySMlqJCNZTsqkf79PvcLu6t8A4QQ5AAyNIGVC/zeKudYWuTfvNLywDZ6ULkemPf21QycVWPCd2Yqdq7iJB6Y40oYfDhVYfuzn6qcKj8LSpkKnI3kNIcjd6hJ9V6w9O5BJjDkJ96yzsBRFmOtkW6Uk0Hn61sC/hRx8uDER980fdgOjYi6JY9WQyyNrttHoyVN2LGD0GMoIFmqf3DwCU5vhkBVYzw/1xbetiIMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(70206006)(36756003)(70586007)(54906003)(4326008)(5660300002)(2616005)(186003)(356005)(8936002)(426003)(40460700003)(336012)(47076005)(16526019)(8676002)(7696005)(86362001)(1076003)(6916009)(508600001)(36860700001)(82310400005)(83380400001)(6666004)(316002)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:36:31.0634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be87cd2-1ea7-4cc2-52e5-08da2a06cc42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4622
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenhui Sheng <Wenhui.Sheng@amd.com>

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h  | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h

diff --git a/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
new file mode 100644
index 000000000000..9e8ed9f4bb15
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
@@ -0,0 +1,77 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#ifndef __IRQSRCS_GFX_11_0_0_H__
+#define __IRQSRCS_GFX_11_0_0_H__
+
+
+#define GFX_11_0_0__SRCID__UTCL2_FAULT                          0       // UTCL2 has encountered a fault or retry scenario
+#define GFX_11_0_0__SRCID__UTCL2_DATA_POISONING                 1       // UTCL2 for data poisoning
+
+#define GFX_11_0_0__SRCID__MEM_ACCES_MON		                10		// 0x0A EA memory access monitor interrupt
+
+#define GFX_11_0_0__SRCID__SDMA_ATOMIC_RTN_DONE                 48      // 0x30 SDMA atomic*_rtn ops complete
+#define GFX_11_0_0__SRCID__SDMA_TRAP                            49      // 0x31 Trap
+#define GFX_11_0_0__SRCID__SDMA_SRBMWRITE                       50      // 0x32 SRBM write Protection
+#define GFX_11_0_0__SRCID__SDMA_CTXEMPTY                        51      // 0x33 Context Empty
+#define GFX_11_0_0__SRCID__SDMA_PREEMPT                         52      // 0x34 SDMA New Run List
+#define GFX_11_0_0__SRCID__SDMA_IB_PREEMPT                      53      // 0x35 sdma mid - command buffer preempt interrupt
+#define GFX_11_0_0__SRCID__SDMA_DOORBELL_INVALID                54      // 0x36 Doorbell BE invalid
+#define GFX_11_0_0__SRCID__SDMA_QUEUE_HANG                      55      // 0x37 Queue hang or Command timeout
+#define GFX_11_0_0__SRCID__SDMA_ATOMIC_TIMEOUT                  56      // 0x38 SDMA atomic CMPSWAP loop timeout
+#define GFX_11_0_0__SRCID__SDMA_POLL_TIMEOUT                    57      // 0x39 SRBM read poll timeout
+#define GFX_11_0_0__SRCID__SDMA_PAGE_TIMEOUT                    58      // 0x3A Page retry  timeout after UTCL2 return nack = 1
+#define GFX_11_0_0__SRCID__SDMA_PAGE_NULL                       59      // 0x3B Page Null from UTCL2 when nack = 2
+#define GFX_11_0_0__SRCID__SDMA_PAGE_FAULT                      60      // 0x3C Page Fault Error from UTCL2 when nack = 3
+#define GFX_11_0_0__SRCID__SDMA_VM_HOLE                         61      // 0x3D MC or SEM address in VM hole
+#define GFX_11_0_0__SRCID__SDMA_ECC                             62      // 0x3E ECC Error
+#define GFX_11_0_0__SRCID__SDMA_FROZEN                          63      // 0x3F SDMA Frozen
+#define GFX_11_0_0__SRCID__SDMA_SRAM_ECC                        64      // 0x40 SRAM ECC Error
+#define GFX_11_0_0__SRCID__SDMA_SEM_INCOMPLETE_TIMEOUT          65      // 0x41 GPF(Sem incomplete timeout)
+#define GFX_11_0_0__SRCID__SDMA_SEM_WAIT_FAIL_TIMEOUT           66      // 0x42 Semaphore wait fail timeout
+
+#define GFX_11_0_0__SRCID__CP_GENERIC_INT				        177		// 0xB1 CP_GENERIC int
+#define GFX_11_0_0__SRCID__CP_PM4_PKT_RSVD_BIT_ERROR		    180		// 0xB4 PM4 Pkt Rsvd Bits Error
+#define GFX_11_0_0__SRCID__CP_EOP_INTERRUPT					    181		// 0xB5 End-of-Pipe Interrupt
+#define GFX_11_0_0__SRCID__CP_BAD_OPCODE_ERROR				    183		// 0xB7 Bad Opcode Error
+#define GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT				    184		// 0xB8 Privileged Register Fault
+#define GFX_11_0_0__SRCID__CP_PRIV_INSTR_FAULT				    185		// 0xB9 Privileged Instr Fault
+#define GFX_11_0_0__SRCID__CP_WAIT_MEM_SEM_FAULT			    186		// 0xBA Wait Memory Semaphore Fault (Synchronization Object Fault)
+#define GFX_11_0_0__SRCID__CP_CTX_EMPTY_INTERRUPT			    187		// 0xBB Context Empty Interrupt
+#define GFX_11_0_0__SRCID__CP_CTX_BUSY_INTERRUPT			    188		// 0xBC Context Busy Interrupt
+#define GFX_11_0_0__SRCID__CP_ME_WAIT_REG_MEM_POLL_TIMEOUT	    192		// 0xC0 CP.ME Wait_Reg_Mem Poll Timeout
+#define GFX_11_0_0__SRCID__CP_SIG_INCOMPLETE				    193		// 0xC1 "Surface Probe Fault Signal Incomplete"
+#define GFX_11_0_0__SRCID__CP_PREEMPT_ACK					    194		// 0xC2 Preemption Ack-wledge
+#define GFX_11_0_0__SRCID__CP_GPF					            195		// 0xC3 General Protection Fault (GPF)
+#define GFX_11_0_0__SRCID__CP_GDS_ALLOC_ERROR				    196		// 0xC4 GDS Alloc Error
+#define GFX_11_0_0__SRCID__CP_ECC_ERROR					        197		// 0xC5 ECC  Error
+#define GFX_11_0_0__SRCID__CP_COMPUTE_QUERY_STATUS              199     // 0xC7 Compute query status
+#define GFX_11_0_0__SRCID__CP_VM_DOORBELL					    200		// 0xC8 Unattached VM Doorbell Received
+#define GFX_11_0_0__SRCID__CP_FUE_ERROR					        201		// 0xC9 ECC FUE Error
+#define GFX_11_0_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT	    202		// 0xCA Streaming Perf Monitor Interrupt
+#define GFX_11_0_0__SRCID__GRBM_RD_TIMEOUT_ERROR			    232		// 0xE8 CRead timeout error
+#define GFX_11_0_0__SRCID__GRBM_REG_GUI_IDLE				    233		// 0xE9 Register GUI Idle
+
+#define GFX_11_0_0__SRCID__SQ_INTERRUPT_ID					    239		// 0xEF SQ Interrupt (ttrace wrap, errors)
+
+
+#endif
-- 
2.35.1

