Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5389CCA462
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 09:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433391126FF;
	Fri, 16 Oct 2026 09:52:41 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77CF1126F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 09:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNrhdb94vtorOQphK/DFPJtbhg85ympIBeKYNyjzktO1l3zgJPyrgCynpXJQbjnwf42QGznsVtSknFw6GlmFprcRwY75m3wpwdcunbOhT+XHB/+xUmzg1rYCmvs15GtjOiUCtBUrRWvxrcBqEGlm7bdb1z6nrqKs7TVm5sM20Hebyj/CApRodfAEUKUvQRCixhXhgZh0f2LbJRCz//0YQWjWqfKAAdXNIV3hTDDXpNcPFtwha3BL35fghhZQleDmCBNonu8fyMFdfjlEOTUV9kS+JRzp3MKOVBebLSjqRQNt+qx5+T+MIKYfKEi2qprLKMpX56bF0OBmaVd57Q4p0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Y2s0Q2G1GLNHSJZqUFeY1UI84uEf7iETeVjX1Yvu/g=;
 b=BbHR6I+AYdjg0SM0o+xfyJqa5qH6qu0EvIlIqgFAIopphk0CoexTmb0iU+wdrG3FN4eIb+UL31+ydMOLHlHawetBRWZYe1g5fu8yH6qj17jSECWAhGp27uDM2KP7+9cTJY6Ybt9fGjsw6YmUO0suJ5luA4ntfDAMb0Pnzg3Z/9EymEsuJbE40GpLDeHza8s0Mr0GeyBHf7Gdc56MKV3F8VszzW104kkbnROyI14bFC7Z/tes8t9ovyzqMR6jRbbWZFEBTQn4tf5Utq/yQ4weNcdWzaUWPvmJPl+wo1UgAOJi7at2TZNUdRx4NNMDViqZ/4IBZ7V/xN+7yCzuGxviuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y2s0Q2G1GLNHSJZqUFeY1UI84uEf7iETeVjX1Yvu/g=;
 b=2DrDiG4PcIdFTIMkTr7YDC3+QnaZvyP9Pej9u2qY7PmtmpbJBVs5eOX8CK1zXG1ISwTOxX+EgY75XdxE414a0YACxUEVircUXSuLVSem/+JIGBJ2l5VOo6JnTBbpY3rD7UddNwI9ZzCU6ibH93JCLpR7xcMj3h2V3ZHFbjACqpU=
Received: from CH0P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::9)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 09:52:29 +0000
Received: from DM3PEPF000265AE.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::56) by CH0P221CA0025.outlook.office365.com
 (2603:10b6:610:11d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 09:52:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265AE.mail.protection.outlook.com (10.167.23.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:52:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:52:21 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 04:52:19 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <Davis.Ming@amd.com>, <Gavin.Wan@amd.com>, Victor Zhao
 <Victor.Zhao@amd.com>
Subject: [PATCH v4 1/2] drm/amdgpu/mes: Support 64-bit register reads
Date: Fri, 16 Oct 2026 17:52:22 +0800
Message-ID: <20261016095224.461911-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265AE:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b749488-b870-4a54-40c5-08df2b6b3087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|56012099006|261009223027099003|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: QApTZKsEsH7UwMy0Ftm00/K5FZWAoXZQcid6Wqt9enEplYGIEcWCs28fzTpRkgt0X1Lfg0xGMw9hqYOCaN+rmzdQ7eDr1gY0kB6zxLHSe2W0jQRCGr1+9WSWQda4Ns3cFi/yZBFQzv4x9NmB52Dyklzdsed3F6SJ0JLgY81s2M4MG4Gi3CnpJ1WC1IC7M1AydfUq5JYRphvCv1hptyq/KwuiYQ/2Ms1LZPYQaRWVDX7+hBPn8kvN/BOw4qnhjGOg6/ieafrREDucnSS27khz6+tVw9SsSERk5VuKPwOiTGvHqx9pNSqXYUO+Q/mtbKefeL0c6ft6bh0CIjy9BBf4s5OrWOqM5TcVMtBUZ4Ad8nRT2zuqkBS77gZlFlF6IxBnrMpK3j8WY98g7Xc8M+sp5rGf1D8xfd0TqpX4O/wrPz3YMQbM3xY7buPMw02ZFrSLtl3n8GYwM3QxF3OeEJ41tOX4imHF0a+q6ljwuh+Wzh5yZHn9enEGBFap57MXap+LfVYlt1ZPGa93GrRiulafuPkvyTdGmGj/hW2Drsk78jh78RmZsz+a8ApsgQxDbzNJikFB1wFbFzgxceA4HD+tbwFwPZ0+71QWfiNXsixM1+Eh9BnJ090KMslffOAg/WQSlX8miQY6ygZ0vbPg2quaLPmkbXMacnwhLp8sxLCVPEE8pZUhG9DNjnYefJAvms4LDMjU1VbFPLgGakhxfmY5rA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(261009223027099003)(11063799006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1CHJBhq745DEextctghnHgiBoQR7YkVehUdHZgWSFrKhFxeI6YjGL+sY+FFs+nAUyL3ISf4I5hylVODZGmeMDJ5tElVvRoxNWYjLUszWRSiga7h2lsqcAuP6oYncvbZbX1yXPypz5ydfJVjVPcrteYe/ekyDKLRScfBtOcFb/xUl8SzBrTjjuhtR2Y0cdUw9zHfMjcZoh72gxiMCTQXABfFaCrhlyAeKfd2C0Wq7wpMztqQCcsIBTjjMhprBVYxdPeeQa36nbn8HfO87vw8bI9M7nIhIGB7bMeS8zcuLsvvP/EvligpdOusOgJRvnQ0GK5pI+InZIAtPx/OmAlEjoS+UoeFHRHRTTxcfpnqYK9jzQbbitqvfPuZiaVJeHuaVvIbUm6eKSHgsbHPwOzbM2pOfq5gIHTgCWxNnNY4626qK8xAkKxDCnnC4qNo1NBe6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:52:28.4776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b749488-b870-4a54-40c5-08df2b6b3087
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265AE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
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

[why]
Some register values span two consecutive dwords and must be sampled
with one MES operation.

[how]
Add amdgpu_mes_rreg64(), set READ_REG read64Bits for MES 11 and
MES 12, and combine the two returned dwords into a 64-bit value.
Reject 64-bit reads on MES 11 scheduler firmware older than 0x42,
which predates read64Bits support.

v2: add MES 11 support with the same read64Bits option
v3: return read status separately and require MES 11 firmware 0x42 or newer

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 41 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  6 +++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  2 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |  7 ++++
 6 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5bebe74de01ad..fbd0728514b43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -582,6 +582,7 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
 	op_input.op = MES_MISC_OP_READ_REG;
 	op_input.read_reg.reg_offset = reg;
 	op_input.read_reg.buffer_addr = read_val_gpu_addr;
+	op_input.read_reg.read64_bits = false;
 
 	if (!adev->mes.funcs->misc_op) {
 		dev_err(adev->dev, "mes rreg is not supported!\n");
@@ -602,6 +603,46 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
 	return val;
 }
 
+int amdgpu_mes_rreg64(struct amdgpu_device *adev, uint32_t reg,
+		      uint32_t xcc_id, uint64_t *val)
+{
+	struct mes_misc_op_input op_input = { 0 };
+	uint32_t addr_offset;
+	uint64_t *read_val_ptr;
+	int r;
+
+	r = amdgpu_wb_get(adev, &addr_offset);
+	if (r) {
+		dev_err(adev->dev, "critical bug! too many mes readers\n");
+		return r;
+	}
+
+	read_val_ptr = (uint64_t *)&adev->wb.wb[addr_offset];
+	op_input.xcc_id = xcc_id;
+	op_input.op = MES_MISC_OP_READ_REG;
+	op_input.read_reg.reg_offset = reg;
+	op_input.read_reg.buffer_addr = adev->wb.gpu_addr + addr_offset * 4;
+	op_input.read_reg.read64_bits = true;
+
+	if (!adev->mes.funcs->misc_op) {
+		dev_err(adev->dev, "mes rreg is not supported!\n");
+		r = -EINVAL;
+		goto error;
+	}
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "failed to read reg (0x%x)\n", reg);
+	else
+		*val = READ_ONCE(*read_val_ptr);
+
+error:
+	amdgpu_wb_free(adev, addr_offset);
+	return r;
+}
+
 int amdgpu_mes_wreg(struct amdgpu_device *adev, uint32_t reg,
 		    uint32_t val, uint32_t xcc_id)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 33a426f58e723..1e801f427ddb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -373,6 +373,7 @@ struct mes_misc_op_input {
 		struct {
 			uint32_t                  reg_offset;
 			uint64_t                  buffer_addr;
+			bool                      read64_bits;
 		} read_reg;
 
 		struct {
@@ -545,6 +546,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
 			 uint32_t xcc_id);
+int amdgpu_mes_rreg64(struct amdgpu_device *adev, uint32_t reg,
+		      uint32_t xcc_id, uint64_t *val);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		    uint32_t reg, uint32_t val, uint32_t xcc_id);
 int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index d8b4d3deff605..ef82f7536e449 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -902,9 +902,15 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 
 	switch (input->op) {
 	case MES_MISC_OP_READ_REG:
+		if (input->read_reg.read64_bits &&
+		    (mes->sched_version & AMDGPU_MES_VERSION_MASK) < 0x42)
+			return -EOPNOTSUPP;
+
 		misc_pkt.opcode = MESAPI_MISC__READ_REG;
 		misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
 		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
+		misc_pkt.read_reg.option.bits.read64Bits =
+			input->read_reg.read64_bits;
 		break;
 	case MES_MISC_OP_WRITE_REG:
 		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 04465804c2544..0d2a60528802e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -858,6 +858,8 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.opcode = MESAPI_MISC__READ_REG;
 		misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
 		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
+		misc_pkt.read_reg.option.bits.read64Bits =
+			input->read_reg.read64_bits;
 		break;
 	case MES_MISC_OP_WRITE_REG:
 		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index d17ced46d5f73..e0a488e516c09 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -581,6 +581,8 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 	case MES_MISC_OP_READ_REG:
 		misc_pkt.opcode = MESAPI_MISC__READ_REG;
 		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
+		misc_pkt.read_reg.option.bits.read64Bits =
+			input->read_reg.read64_bits;
 		mes_v12_1_get_rrmt(input->read_reg.reg_offset,
 				   GET_INST(GC, input->xcc_id),
 				   &misc_pkt.read_reg.rrmt_opt,
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 1fe824b41f2a5..b27ec78da3b08 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -635,6 +635,13 @@ struct WRITE_REG {
 struct READ_REG {
 	uint32_t                  reg_offset;
 	uint64_t                  buffer_addr;
+	union {
+		struct {
+			uint32_t read64Bits : 1;
+			uint32_t reserved : 31;
+		} bits;
+		uint32_t all;
+	} option;
 };
 
 enum WRM_OPERATION {
-- 
2.50.1

