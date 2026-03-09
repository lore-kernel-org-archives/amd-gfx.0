Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DF0F417E7
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E421810E50E;
	Mon,  9 Mar 2026 14:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ijtSWxxa";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7B510E50C
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3QsKo9aKc9SoPx5tsPgq8TXw0Bjw1GbvawhgbDfGuzVezXXXWtGFZ/tjePspCGPRGokNpbbKxl0QpPjzqoEo1WDhuNJmmJqUxZWhyBviZYADUUXaYjn3K4MPy3frbrKl7tRrrD9l9jQteW7jxvqpvkRIBGIa38pI9GzVMKfab0iaDaboAyoQu5BCEjNKR1EMQb7WvVDodEQEuTCJfMH/apxK0VK6/cGQMJjSnxyVQ14tLoqhfuKPtJCtuWZvSjBSwQUl04edom6V6gEHm2PSTX5TRYAT5SFdVbi38LJROm+4zNJFkZyH2rYyfvG1UwMoT3UGoLeoIcdQhOz3nXIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z3rtv8QZ9WlbYA0Bsd2t2wpzRPLYm+M0Nw4ImY26+g=;
 b=NVejGucBbnHFDeY300biJk84e2D9vrP3RmzmM1Vko2KaUmCO2dVihbHtO2KxLBG6gMEITBRy1HgGfzCE9bF2uZ6TfrFtzyQLJR3L2YGm2PaRZhk37SfHyMTzUGLWiR10MGYNoFYPGC47dbVXP+ufdlbRrLNG2GYUERSDbWGPBfJev1m3Jnta4n0Hd83RbPdPSctJLMXARQtt/MQ1ESN0y2VRjd492q5bV0M/KCxzpYBcSxdF6aCA6qY9lySuWgU+9RIpvpLJI1xKEPF5klb8fSDVl043p7YI8pqG26rs9LBTP142j6kUGwK+dMGN3lq+90v3YRdrWZVb4dsS9xjuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z3rtv8QZ9WlbYA0Bsd2t2wpzRPLYm+M0Nw4ImY26+g=;
 b=ijtSWxxaqB38q+nY2SEawWhMsZ41+Oql6my017wrEgPap7g7l6MUMAS1Z03l3ln1P7X+oHxcXV4LN7jlYV5EtLFx5BkleddZYZgJDDW/qkil1vOZ0YeC/thw0QoMr2BK+TWCf3xfv6W0D2PM4ubFnzfXw+UCaz35VkgIXtH6ZZQ=
Received: from SN1PR12CA0045.namprd12.prod.outlook.com (2603:10b6:802:20::16)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:26:40 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::94) by SN1PR12CA0045.outlook.office365.com
 (2603:10b6:802:20::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 14:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:26:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 9 Mar
 2026 09:26:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Mar
 2026 09:26:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:26:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes12_1: fix the failure access to MID1 registers
Date: Mon, 9 Mar 2026 10:26:17 -0400
Message-ID: <20260309142621.2843831-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309142621.2843831-1-alexander.deucher@amd.com>
References: <20260309142621.2843831-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 9939ae3b-0a54-43a7-52d0-08de7de7e15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: glcwOsa7+dsZPu2P9/JnQfGy7TZw+st3TdXq/+zXOiMYJ9Q7THx2dAT8PJyQyOuSIHgQEYKZyE9mT9THu3KcM18h8mcJbfoa6mEvvNVfOTPT33m2AiNcdUXIEymdbeXv/QjWrSdt8EcNLUfSMzYYuyBF48CYIfZRRtVeFi3EFa+d5LJLTVEh71pJYXdCxjIR94MGMkv5KkyKOAD+nZU9e6JNQZ3OrzSd1KIyhS9lbX+fHAoxflkqOuhmvfFkFbYEhKSYQNGqv1m90higt4iyuOC4tkOAPla8S4HBpGCPgz+Y0Ki0z33yug0cWgejp8XKTa6sRSrX6rQo7ktvWSR0H/+0H60l3TwQiHXoWjxUpQkfuhcePkWEV15Xg0QUx1yzWSw1D+MFeoWOCczRrIa18j1yIwuaGSb1U/JspsNs+lNESTRpEjl3M1JaVLb3a6V2zJHWT+638vCV39atnsDpU9qZxhz1w35BeFFvExgagqLcs3ZJUc2AucchW/B4zPoHg9FZ8CjW9WXLgP12MP2Qay8cKIFhGYPQNGLlcIhjnja3G1rgu+CBx8kRjPaKEIn5Kkr45jkR2dgEMxr2NroCLD3HV/bJ+N0XdXX/pYAN9400DzmYvXwjnxNtV3e3gNVF7IeMCO9I45HpqiDuV6pPVMOZcg4ryurwApQBlNIVLCml0V5PVAQzqow/FCsV+RaPGNIbyE0027X5GFA5l2JGvj+VxEW7x9T09ekBNKnl8pSJYq4/54zaIirNJIfNItt0HE84iV8w0gp8l7TtTG7hGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o/L6eMqqfv9uDw1aR0ZcV0+5BdyutRjJ5xgeYI+D/o1z3hgRLeB/oAuwcg416zqyzwVPMWSoYhdDLKAYUJ9jI3lh4vwiIwQbkHQ+xgFZ2lYClqyWXic57qUBdS3RI6tAFTtviKI9ddYH918FufxYzAnvsNOF3mVHD9UFssUxAI4BEO+L5S2Pq4cZ/oS3Sv7orkjQoJVOfBrQRYJjCzxMKNC6FPNa681TuV2uXPbd6Gk/x2KHtlZMk/AkWGTGg7j320FhmceRFpYBFIlsNjYE/6cLQscNpXXLT9ZrR0QObnclX20Bqv3bL9GKbQfNmm8kvWRy/JacNNmzyqPMoEmnnK85oQfe4rg9P3dUFem18tCK36XDEXUmVPgUQhN0sqF1uRL0vY5XXp0WAanRqvLlqd9Dve7KIgTdCEoah29jSrW5uo7muryzqTb11Wyb5Vpf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:26:40.4437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9939ae3b-0a54-43a7-52d0-08de7de7e15d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332
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

From: Jack Xiao <Jack.Xiao@amd.com>

Correct the mid die id and mid1 register relative offset
for mes fw to access to mid1 registers.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 55 ++++++++------------------
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c  | 33 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h  |  2 +
 3 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index ca8cacd345736..5dcc2c32644ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -494,16 +494,12 @@ static int mes_v12_1_query_sched_status(struct amdgpu_mes *mes,
 }
 static uint32_t mes_v12_1_get_xcc_from_reg(uint32_t reg_offset)
 {
-	/* Check xcc reg offset range */
-	uint32_t xcc = (reg_offset & XCC_MID_MASK) ? 4 : 0;
-	/* Each XCC has two register ranges.
-	 * These are represented in reg_offset[17:16]
-	 */
-	return ((reg_offset >> 16) & 0x3) + xcc;
+	return ((reg_offset >> 16) & 0x7);
 }
 
 static void mes_v12_1_get_rrmt(uint32_t reg, uint32_t xcc_id,
-				 struct RRMT_OPTION *rrmt_opt)
+			       struct RRMT_OPTION *rrmt_opt,
+			       uint32_t *out_reg)
 {
 	uint32_t normalized_reg = soc_v1_0_normalize_xcc_reg_offset(reg);
 
@@ -513,7 +509,11 @@ static void mes_v12_1_get_rrmt(uint32_t reg, uint32_t xcc_id,
 			 MES_RRMT_MODE_LOCAL_XCD : MES_RRMT_MODE_REMOTE_XCD;
 	} else {
 		rrmt_opt->mode = MES_RRMT_MODE_REMOTE_MID;
+		if (soc_v1_0_mid1_reg_range(reg))
+			rrmt_opt->mid_die_id = 1;
 	}
+
+	*out_reg = soc_v1_0_normalize_reg_offset(reg);
 }
 
 static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
@@ -537,65 +537,44 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 	switch (input->op) {
 	case MES_MISC_OP_READ_REG:
 		misc_pkt.opcode = MESAPI_MISC__READ_REG;
-		misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
 		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
 		mes_v12_1_get_rrmt(input->read_reg.reg_offset,
 				   GET_INST(GC, input->xcc_id),
-				   &misc_pkt.read_reg.rrmt_opt);
-		if (misc_pkt.read_reg.rrmt_opt.mode != MES_RRMT_MODE_REMOTE_MID) {
-			misc_pkt.read_reg.reg_offset =
-				soc_v1_0_normalize_xcc_reg_offset(misc_pkt.read_reg.reg_offset);
-		}
+				   &misc_pkt.read_reg.rrmt_opt,
+				   &misc_pkt.read_reg.reg_offset);
 		break;
 	case MES_MISC_OP_WRITE_REG:
 		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
-		misc_pkt.write_reg.reg_offset = input->write_reg.reg_offset;
 		misc_pkt.write_reg.reg_value = input->write_reg.reg_value;
 		mes_v12_1_get_rrmt(input->write_reg.reg_offset,
 				   GET_INST(GC, input->xcc_id),
-				   &misc_pkt.write_reg.rrmt_opt);
-		if (misc_pkt.write_reg.rrmt_opt.mode != MES_RRMT_MODE_REMOTE_MID) {
-			misc_pkt.write_reg.reg_offset =
-				soc_v1_0_normalize_xcc_reg_offset(misc_pkt.write_reg.reg_offset);
-		}
+				   &misc_pkt.write_reg.rrmt_opt,
+				   &misc_pkt.write_reg.reg_offset);
 		break;
 	case MES_MISC_OP_WRM_REG_WAIT:
 		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
 		misc_pkt.wait_reg_mem.op = WRM_OPERATION__WAIT_REG_MEM;
 		misc_pkt.wait_reg_mem.reference = input->wrm_reg.ref;
 		misc_pkt.wait_reg_mem.mask = input->wrm_reg.mask;
-		misc_pkt.wait_reg_mem.reg_offset1 = input->wrm_reg.reg0;
 		misc_pkt.wait_reg_mem.reg_offset2 = 0;
 		mes_v12_1_get_rrmt(input->wrm_reg.reg0,
 				   GET_INST(GC, input->xcc_id),
-				   &misc_pkt.wait_reg_mem.rrmt_opt1);
-		if (misc_pkt.wait_reg_mem.rrmt_opt1.mode != MES_RRMT_MODE_REMOTE_MID) {
-			misc_pkt.wait_reg_mem.reg_offset1 =
-				soc_v1_0_normalize_xcc_reg_offset(misc_pkt.wait_reg_mem.reg_offset1);
-		}
+				   &misc_pkt.wait_reg_mem.rrmt_opt1,
+				   &misc_pkt.wait_reg_mem.reg_offset1);
 		break;
 	case MES_MISC_OP_WRM_REG_WR_WAIT:
 		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
 		misc_pkt.wait_reg_mem.op = WRM_OPERATION__WR_WAIT_WR_REG;
 		misc_pkt.wait_reg_mem.reference = input->wrm_reg.ref;
 		misc_pkt.wait_reg_mem.mask = input->wrm_reg.mask;
-		misc_pkt.wait_reg_mem.reg_offset1 = input->wrm_reg.reg0;
-		misc_pkt.wait_reg_mem.reg_offset2 = input->wrm_reg.reg1;
 		mes_v12_1_get_rrmt(input->wrm_reg.reg0,
 				   GET_INST(GC, input->xcc_id),
-				   &misc_pkt.wait_reg_mem.rrmt_opt1);
+				   &misc_pkt.wait_reg_mem.rrmt_opt1,
+				   &misc_pkt.wait_reg_mem.reg_offset1);
 		mes_v12_1_get_rrmt(input->wrm_reg.reg1,
 				   GET_INST(GC, input->xcc_id),
-				   &misc_pkt.wait_reg_mem.rrmt_opt2);
-
-		if (misc_pkt.wait_reg_mem.rrmt_opt1.mode != MES_RRMT_MODE_REMOTE_MID) {
-			misc_pkt.wait_reg_mem.reg_offset1 =
-				soc_v1_0_normalize_xcc_reg_offset(misc_pkt.wait_reg_mem.reg_offset1);
-		}
-		if (misc_pkt.wait_reg_mem.rrmt_opt2.mode != MES_RRMT_MODE_REMOTE_MID) {
-			misc_pkt.wait_reg_mem.reg_offset2 =
-				soc_v1_0_normalize_xcc_reg_offset(misc_pkt.wait_reg_mem.reg_offset2);
-		}
+				   &misc_pkt.wait_reg_mem.rrmt_opt2,
+				   &misc_pkt.wait_reg_mem.reg_offset2);
 		break;
 	case MES_MISC_OP_SET_SHADER_DEBUGGER:
 		pipe = AMDGPU_MES_SCHED_PIPE;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 0c7759b82fa63..37552c91a8781 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -41,6 +41,11 @@
 #define NORMALIZE_XCC_REG_OFFSET(offset) \
 	(offset & 0xFFFF)
 
+#define MID1_REG_RANGE_0_LOW  0x40000
+#define MID1_REG_RANGE_0_HIGH 0x80000
+#define NORMALIZE_MID_REG_OFFSET(offset) \
+		(offset & 0x3FFFF)
+
 /* Initialized doorbells for amdgpu including multimedia
  * KFD can use all the rest in 2M doorbell bar */
 static void soc_v1_0_doorbell_index_init(struct amdgpu_device *adev)
@@ -870,3 +875,31 @@ uint32_t soc_v1_0_normalize_xcc_reg_offset(uint32_t reg)
 	else
 		return reg;
 }
+
+bool soc_v1_0_mid1_reg_range(uint32_t reg)
+{
+	uint32_t normalized_reg = soc_v1_0_normalize_xcc_reg_offset(reg);
+
+	if (soc_v1_0_normalize_xcc_reg_range(normalized_reg))
+		return false;
+
+	if ((reg >= MID1_REG_RANGE_0_LOW) && (reg < MID1_REG_RANGE_0_HIGH))
+		return true;
+	else
+		return false;
+}
+
+uint32_t soc_v1_0_normalize_reg_offset(uint32_t reg)
+{
+	uint32_t normalized_reg = soc_v1_0_normalize_xcc_reg_offset(reg);
+
+	if (soc_v1_0_normalize_xcc_reg_range(normalized_reg))
+		return soc_v1_0_normalize_xcc_reg_offset(reg);
+
+	/* check if the reg offset is inside MID1. */
+	if (soc_v1_0_mid1_reg_range(reg))
+		return NORMALIZE_MID_REG_OFFSET(reg);
+
+	return reg;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
index 146996101aa07..16c220fcc4e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
@@ -31,7 +31,9 @@ void soc_v1_0_grbm_select(struct amdgpu_device *adev,
 			  int xcc_id);
 int soc_v1_0_init_soc_config(struct amdgpu_device *adev);
 bool soc_v1_0_normalize_xcc_reg_range(uint32_t reg);
+bool soc_v1_0_mid1_reg_range(uint32_t reg);
 uint32_t soc_v1_0_normalize_xcc_reg_offset(uint32_t reg);
+uint32_t soc_v1_0_normalize_reg_offset(uint32_t reg);
 u64 soc_v1_0_encode_ext_smn_addressing(int ext_id);
 
 #endif
-- 
2.53.0

