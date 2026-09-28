Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97410C9833F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 10:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3778C10E95C;
	Mon, 28 Sep 2026 10:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YAa9BuZ2";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4146F10E95C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 10:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo2jiE8EA+A0z4ZGEJGMxgsIA0estUeQ527HDf8ZrRchfd+K+CFp1xu2GHs5mgTApQi77jycbRnAQlwpoMPV4SKFFTkOs9dn5T2goeLgvfwTDuMnE+Z1QiD7TsITnMWaORIaK5K6Z9zVADP/e5wtGLsutVW/L53d8yMJeEL/qAwH+bO5TSTaddmc+q6kFjCg7x1VJt7CszVvUNS/10YZBiTJv1jswdnjiW2POOxc9YIyhkvt2lu0Xn/y7R5W9yfXfSHNLJKsIQjeKhx+cjw0Ql8yZMNUYR56AETB9jTis1BEPLtl7V6zS98NVITzo1iIpnOch95hUJkVB9+cgzqOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTLxTezBASPc1VU1+x2EemUuUEX9v2XAcjsQqWNrLyo=;
 b=ppOmEmeAPA4GEiWGwtUdtyJ1h5YsCoM3FMkdB36bMb2WBWmgE6TzMmCa79SXI19bhfmIfGn4kxehTDHoKvODclwOXWiFy8kcBsv/0mRoOUAZC0urU2mX8WGbtUvvEm7Mg3PWy6eo9W2yWldxo52godGa/ZqJgtCWttbsWgXZG8u2/APGuZet6poFpup7gPk/r7VwNQvE3HzY9X5t4KE6+lsmonBWF1CMQa9mE3hbc2+PlQ+PVds4xlyGqzXr0jt2q/gjbKRkAckF7ZUKH0jk3uLkdaxSmfOv5nduD03UIQyHD4SkkFt3BjCtfTCP1LTAGDSelei4SyQ6HW2c35buXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTLxTezBASPc1VU1+x2EemUuUEX9v2XAcjsQqWNrLyo=;
 b=YAa9BuZ2tLNJHpnYRm4ilxZfZAULsXLBTkOARghxP9eXSAtj3kCV9TfvhmQcUuq34amlE6B7tlMp7Me/AYUcx/UswIy28oGdmkUcdnlpXTMCs+1xZ7I0ONjo+xM+AWtX52dsr5cU7NsE+KGRIBThUd33fB4IeShG1QudUcj69rg=
Received: from SJ2P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::10)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 10:32:13 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:5db:cafe::16) by SJ2P221CA0003.outlook.office365.com
 (2603:10b6:a03:5db::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 10:32:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 10:32:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 05:32:11 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 05:32:10 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Shaoyun.Liu@amd.com>
CC: <Davis.Ming@amd.com>, <Gavin.Wan@amd.com>, Victor Zhao
 <Victor.Zhao@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu/mes: Support 64-bit register reads
Date: Mon, 28 Sep 2026 18:31:54 +0800
Message-ID: <20260928103155.843597-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: b71a4970-17df-42e6-d412-08df1d4bc27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: nRmN06hJ1YoIiqSN4B2p8RHz7o75L88Vy2fUMH1AtZbu5iAqPhVInwrjrPjbVY25bs3NFTznfqYoHNZgE4tGH2gjBtstKEj88XBrkfKLDvH+m8HM6pVqBSu3Yp8DogZ484o9SbNIXoqyGOnX4iGme+lTOVKVN3QMFTqG8wg4jzPC7lBdTBm23Q73TbT6y6XXqaY74Qcc0vki5D/E6nNYK1tXS6FTf3T5HkN9z+apkXWx1rzHIBjmrwsedWXcjRVafZLKzo4wt4iB+3J0rnoCrFPJo9Xan6Tqdh+i0RqJsfHxmtajJ2dPiGKm8jKDh2LN37PMBJnjo4gtNureVB1K9bKbiq3tjvuiJfgWqyRU3THhF2GRwngqphPA5UMn2slMTku3k9OyZMOBaabkpwHSXghwh26a8AgvEoHP7xfnqn7pNgvNncrHm9jpaLP/XELN04ucM64Fju/jnvhpbwBrdxAFzvSkymGw+eI9wofLwFJ9Uzb06KKAIys5EolwbrQONsRW8rNVvfTLOuUJscsItXzYLc+ycZjpGwEgYtfiDJFH0m7oL2LBKNTy/nadGu49iQUgMQpkZBm85qNVgBdYXLGezcKvjo6F5tTpIVtM/bjtah4CX32awAqeR8RIcUyowMtJ+pTIfEo/wDgTrmic1ovlZOh10+BTVQbMO3ma8anQefvH+5y2gKNUCHCNV2NhZg9UV5mzTA6663JkXbcx3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DG0hcwKzu7YrC+acYnaZHREfKHEjHjSHQ8J2u+6fxRZE8I+TpoeTpCpvLQhEgTF47n1OuUhEeDUhQZ+BOa8a7fI59cNGs48WqUOs9e0T4BHru9xlHk2UGrW1vqzGPAl4rB1WUvXdIGG6RkiH+f8kTVDPR0NcXaGK4UUguYxtJVxJpe5jRPlDxl2k/7dDyZIEMEFFbybsus+IKcQa8tyFXcx36OdekI/FPA/60gj0FLlQIfrbPzh8f1o+g5SRJ+TDaumT/39agOkpRvHNduqUVp05skCplu30Xzh3XY4EI6paT8VdcWZrmplGmyKsfHZQuNmMbShoqJ7PpgoeSJc3p2ZCUCFf8Qocf5s6nTfajFSAtw0cTxvAl/SOHVz4q7x2/+zZelCtx6EUFRnr75tpp0S2JBfEpSRrw46s8n85uXoDZOKYEtYY599/ItH9xR1I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:32:13.1341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b71a4970-17df-42e6-d412-08df1d4bc27c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 43 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  6 +++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  2 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |  7 +++
 6 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5bebe74de01ad..3be6e577a8aa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -582,6 +582,7 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
 	op_input.op = MES_MISC_OP_READ_REG;
 	op_input.read_reg.reg_offset = reg;
 	op_input.read_reg.buffer_addr = read_val_gpu_addr;
+	op_input.read_reg.read64_bits = false;
 
 	if (!adev->mes.funcs->misc_op) {
 		dev_err(adev->dev, "mes rreg is not supported!\n");
@@ -602,6 +603,48 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
 	return val;
 }
 
+int amdgpu_mes_rreg64(struct amdgpu_device *adev, uint32_t reg,
+		      uint32_t xcc_id, uint64_t *val)
+{
+	struct mes_misc_op_input op_input = { 0 };
+	uint32_t addr_offset;
+	uint32_t *read_val_ptr;
+	int r;
+
+	r = amdgpu_wb_get(adev, &addr_offset);
+	if (r) {
+		dev_err(adev->dev, "critical bug! too many mes readers\n");
+		return r;
+	}
+
+	read_val_ptr = (uint32_t *)&adev->wb.wb[addr_offset];
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
+	if (r) {
+		dev_err(adev->dev, "failed to read reg (0x%x)\n", reg);
+	} else {
+		*val = READ_ONCE(read_val_ptr[0]);
+		*val |= (uint64_t)READ_ONCE(read_val_ptr[1]) << 32;
+	}
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

