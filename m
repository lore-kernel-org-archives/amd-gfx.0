Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4B3D0E6F9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4F110E29F;
	Tue, 25 Nov 2025 15:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lwCCnd5F";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF99510E428
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:08:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MViTFNJZF1WazrIWiBe4w/f2X4AWogklBPClhdlarQix6wFZesYCMKH/BTM9NhPTCKqtiJi2yTR8AoFGZ20i4/LxFDCnMMQnYeXIsj/n71+iZAarsQEmpUK+XVgQwasr1X/lJLOTnCI3qppnm4uCrZfOTCLAiT93thz/yMhVXnvH6ZF9Z9bc4kybQaLXEdulp3FiNcCZdQDGk1y0ZZLH0YtmG6mIcGFuMmIaqtV9/IqPdGCVo44KYpzdwPdFN6hYdp7dArWpz6L1pmxWcxaWkkPvrRoDexlvHTrjAcMO55XWw65Uq9QRWi8nEjrVemgyB+p6hdzDbfI6GwS/kG+Iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8s0rJFC1H6YctA+HnfnWhVGwkVWVVSq6+aQIp5Swgg=;
 b=I5//wyD7pLSMZSD0nsGu64nN98QqWuoe9FOgFch/RNplJ3c+SL5sgGO+pz68vkUDKBuZ+zZzS9GSJ/Fx07DHp5UzEU/4ac9N3VghtgL1fvldQORfBBydAt81SgH4aenz9DFehuZZF/5aKvMlcqdHUE6VGoUbhky/EoysGXcCchriLxouquXVLLQwwMmH78oMborBkd+MBjdTnLNhOKITZ3yFjZc5cIJeCVQSSUQCMFV9SJdc4yodfPSp+Bg2Tt8aNVfG/4CVqcbYOXW3PhwAc0YM3WFAkMDQqG+cz12OEKP9N6b5ECsiqgGSsFnoNwOJsyK+0sDxC/E1Ui/f6CxdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8s0rJFC1H6YctA+HnfnWhVGwkVWVVSq6+aQIp5Swgg=;
 b=lwCCnd5FZWvuyLk9hUXU2/n8AcS5wpWkEiL9z//7k6dmktXBcO/iEvMPhgzH+H4+UaxEn/E19ytDS9Vhmxde2HmKHabaXZkxmvn5CsDdPSk2Yacwsp8PdudcNLw/5cZ7SK6ByaUNj/L7A/zQHGVNaKfLD6hljmJUyiFwaDV9GuM=
Received: from BN1PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:e0::32)
 by DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 15:08:32 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::bb) by BN1PR10CA0027.outlook.office365.com
 (2603:10b6:408:e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 15:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 15:08:30 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 09:08:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Michael Chen <michael.chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd: include rrmt mode for mes_v12_1
Date: Tue, 25 Nov 2025 10:08:05 -0500
Message-ID: <20251125150812.2046438-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7852f3-58cb-4568-9f42-08de2c347e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K7bkN7VHt9hNOZ9b8nQVmX2vO9bpkc1Ubc8cguCygBk3tu2VusCBI2Wy3Zje?=
 =?us-ascii?Q?fAO7PP7NEnKxgjbgUIC0x7TN6OcLF6bIShjQytoaO+A1MQPMjpa90dRtfgc2?=
 =?us-ascii?Q?6JRUCRjpoAsWAcKCcm08D8PgpDUQcdt+36isULaUJNnPXvuq51ATztBHG/7B?=
 =?us-ascii?Q?wJlSNRXemsj3hQ2Xp6xZ6Htt4wWQALg9pSQA0wPGbETxDC/8Izd6yKxPP25w?=
 =?us-ascii?Q?ddmGRbxMIA3hHIwFe1bsvZZ5Gryx7JAWGjzDN4IqbhZQNaLNumePyzRIbsX+?=
 =?us-ascii?Q?Gh+viLhB+LkjKKN+ORnU35lEw6IiLxuI+p923Xfn3nl1fuJVjAamVAMGvbyt?=
 =?us-ascii?Q?fFFTOwXFIViGJygb0kmcC+4zOYsxBOnCvy608dZXd41fU0Ki+tm7Q61+d55j?=
 =?us-ascii?Q?CPh+IID9iWjgMS8sD88Og8ihAHamEV2I5kJ9/Zs5CE+4ZZyx0wdBwEOjXTXe?=
 =?us-ascii?Q?v4JuKcy7/RbkPellDox4ZgnJCK4PxCCzFEzfgNRw6xmRgIARZd3L96piabos?=
 =?us-ascii?Q?2BGNck3DGkmE+4iJApQTiy4X0aO+DHV39070iHdFi7R3ynI5wxEguHU/mVLu?=
 =?us-ascii?Q?bFH5KH1Jzgkfnjymut4PAes92uid6NRYVKQJwWHXjnAKeZWSH6adJHLI/5ee?=
 =?us-ascii?Q?O1z/Ti4O5QV0JdYIVuvYRJcmfK6G8Jqv2fWrFniINGouypnBkaiWRVAgzhQe?=
 =?us-ascii?Q?hVHCorIRvpcZIGlkLwl6oheqUdcxMTc23qefQB6HJyMNCsnR87g1JTfDrAvM?=
 =?us-ascii?Q?aEfaPQrcWNJvcC+A1pdnQKXgMUE1P2uw/o8kDZUaI6CnFyCB04jJx2lA5KMf?=
 =?us-ascii?Q?JcH3aTndGN9cUaoLdtpVQl7H64ryGWUTFPeKXR5j+hMv9HoMpTaw3/eeqp8a?=
 =?us-ascii?Q?UorKDyUd3KjIeMXo1MbKRvCGuzNeOlv4w9L6FjdHfLHA+ZFzIeV72OWpf3D/?=
 =?us-ascii?Q?J57n7wWilXhJfJteI+PfSsLp20bOLV8vf+PLJWt4dc71Uld+5tUzId2Z4BSX?=
 =?us-ascii?Q?KRF3tVOXOeWrWfUwBqlV3QK37GIl/mUYQHQlAlZC63O3njCkzEw0VThJ4Q+s?=
 =?us-ascii?Q?soSHXhFdhR5W5ICeW6yECOWTSnq5VBLNCxq+5mCy9ixDiXHfbE+FWT3p/7qE?=
 =?us-ascii?Q?8XzEx51aNyoyMek3lf72NclRPUlVS5dS0nXIMwKSG6gndXnrQsheFP/dYKRX?=
 =?us-ascii?Q?OQAldbdhaMBXiSXRv0o8t++6+kdjvyfIRw/Kres5rvLCwTyc85mWB5bMNTNx?=
 =?us-ascii?Q?UI8Ld19Wt99CUpZn2ukpT2fm5Yg7KKh+YUtIly/ubnj6gMuzZ/eaEipAYUAZ?=
 =?us-ascii?Q?73ZqSlxlMnbS4O9KODMvbHjt5Gg8lFP8cZYh+UY3X7V007cm+C8JOr8tFTMH?=
 =?us-ascii?Q?BPDbV394UQPF8t5HfFTai5MKRwSySHu+wXOELlaN2k4rmz8GP9Yvl3GUKLh+?=
 =?us-ascii?Q?EQAT34eV2X1IM41Rkw6JJg+H1JtEFqyWaw+lMY7+Zb8yOBrtn8A4LAx4Pcm0?=
 =?us-ascii?Q?06OvRFcl5ymgPel6v9acJJAG6uXTLTE0RwWh1/ac/Fs7u6wkj/UaHomQgXu9?=
 =?us-ascii?Q?ueIy6zZjSbp7DWXPFUU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:08:30.0968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7852f3-58cb-4568-9f42-08de2c347e42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717
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

From: Alex Sierra <alex.sierra@amd.com>

Implement rrmt for misc read/write regs ops in mes_v12.
This covers LOCAL/REMOTE XCD and LOCAL/REMOTE AID.

v2: fix comments (Alex)

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        | 43 +++++++++++++++++++
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |  7 +++
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 13269d1113730..1ec3f876f7c53 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -44,6 +44,14 @@ static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
 #define MES_EOP_SIZE   2048
 
 #define regCP_HQD_IB_CONTROL_MES_12_1_DEFAULT 0x100000
+#define XCC_REG_RANGE_0_LOW  0x1260     /* XCC gfxdec0 lower Bound */
+#define XCC_REG_RANGE_0_HIGH 0x3C00     /* XCC gfxdec0 upper Bound */
+#define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
+#define XCC_REG_RANGE_1_HIGH 0x10000    /* XCC gfxdec1 upper Bound */
+#define XCC_MID_MASK 0x41000000
+
+#define NORMALIZE_XCC_REG_OFFSET(offset) \
+	(offset & 0x3FFFF)
 
 static void mes_v12_1_ring_set_wptr(struct amdgpu_ring *ring)
 {
@@ -477,6 +485,31 @@ static int mes_v12_1_query_sched_status(struct amdgpu_mes *mes,
 			&mes_status_pkt, sizeof(mes_status_pkt),
 			offsetof(union MESAPI__QUERY_MES_STATUS, api_status));
 }
+static uint32_t mes_v12_1_get_xcc_from_reg(uint32_t reg_offset)
+{
+	/* Check xcc reg offset range */
+	uint32_t xcc = (reg_offset & XCC_MID_MASK) ? 4 : 0;
+	/* Each XCC has two register ranges.
+	 * These are represented in reg_offset[17:16]
+	 */
+	return ((reg_offset >> 16) & 0x3) + xcc;
+}
+
+static void mes_v12_1_get_rrmt(uint32_t reg, uint32_t xcc_id,
+				 struct RRMT_OPTION *rrmt_opt)
+{
+	uint32_t normalized_reg = NORMALIZE_XCC_REG_OFFSET(reg);
+
+	if (((normalized_reg >= XCC_REG_RANGE_0_LOW) && (normalized_reg < XCC_REG_RANGE_0_HIGH)) ||
+		((normalized_reg >= XCC_REG_RANGE_1_LOW) && (normalized_reg < XCC_REG_RANGE_1_HIGH))) {
+		rrmt_opt->xcd_die_id = mes_v12_1_get_xcc_from_reg(reg);
+		rrmt_opt->mode = (xcc_id == rrmt_opt->xcd_die_id) ?
+			 MES_RRMT_MODE_LOCAL_XCD : MES_RRMT_MODE_REMOTE_XCD;
+	}
+	else {
+		rrmt_opt->mode = MES_RRMT_MODE_LOCAL_REMOTE_AID;
+	}
+}
 
 static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 			     struct mes_misc_op_input *input)
@@ -500,11 +533,15 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.opcode = MESAPI_MISC__READ_REG;
 		misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
 		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
+		mes_v12_1_get_rrmt(input->read_reg.reg_offset, input->xcc_id,
+				     &misc_pkt.read_reg.rrmt_opt);
 		break;
 	case MES_MISC_OP_WRITE_REG:
 		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
 		misc_pkt.write_reg.reg_offset = input->write_reg.reg_offset;
 		misc_pkt.write_reg.reg_value = input->write_reg.reg_value;
+		mes_v12_1_get_rrmt(input->write_reg.reg_offset, input->xcc_id,
+				     &misc_pkt.write_reg.rrmt_opt);
 		break;
 	case MES_MISC_OP_WRM_REG_WAIT:
 		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
@@ -513,6 +550,8 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.wait_reg_mem.mask = input->wrm_reg.mask;
 		misc_pkt.wait_reg_mem.reg_offset1 = input->wrm_reg.reg0;
 		misc_pkt.wait_reg_mem.reg_offset2 = 0;
+		mes_v12_1_get_rrmt(input->wrm_reg.reg0, input->xcc_id,
+				     &misc_pkt.wait_reg_mem.rrmt_opt1);
 		break;
 	case MES_MISC_OP_WRM_REG_WR_WAIT:
 		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
@@ -521,6 +560,10 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.wait_reg_mem.mask = input->wrm_reg.mask;
 		misc_pkt.wait_reg_mem.reg_offset1 = input->wrm_reg.reg0;
 		misc_pkt.wait_reg_mem.reg_offset2 = input->wrm_reg.reg1;
+		mes_v12_1_get_rrmt(input->wrm_reg.reg0, input->xcc_id,
+				     &misc_pkt.wait_reg_mem.rrmt_opt1);
+		mes_v12_1_get_rrmt(input->wrm_reg.reg1, input->xcc_id,
+				     &misc_pkt.wait_reg_mem.rrmt_opt2);
 		break;
 	case MES_MISC_OP_SET_SHADER_DEBUGGER:
 		pipe = AMDGPU_MES_SCHED_PIPE;
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 256eb7f702f66..a9bbe3070a488 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -71,6 +71,13 @@ enum MES_SCH_API_OPCODE {
 	MES_SCH_API_MAX = 0xFF
 };
 
+enum MES_RRMT_MODE {
+	MES_RRMT_MODE_LOCAL_XCD,
+	MES_RRMT_MODE_LOCAL_REMOTE_AID,
+	MES_RRMT_MODE_REMOTE_XCD,
+	MES_RRMT_MODE_REMOTE_MID
+};
+
 union MES_API_HEADER {
 	struct {
 		uint32_t type	  : 4; /* 0 - Invalid; 1 - Scheduling; 2 - TBD */
-- 
2.51.1

