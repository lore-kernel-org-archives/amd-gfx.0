Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B65C98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 06:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B0110F2FD;
	Thu, 24 Sep 2026 06:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V5tzivCf";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AED210F300
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 06:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7N4CHf7mcB44A99Aag4bGIWM5hHuVVWrM0GnVOf8/wj3XbS+/rtKjXmaBjJAzDoWfxuYKPPmnhylrU9s20JVYvAHhYNieJ9rsCDDaf1i7YsNEx1216XIP0eKto4xsQgv4+GCwXfgKakWH6h+AIpT3CcRQT1jaoBKJp1jDgNhJbKDABRRaF2dz14R+90DzoPkdCzhsXYhra2OTKAZX/rLEw65pvyNK07/Dkr6fECSZu+4VmjEvIcmCM2LRykQciY8OGjvadUqEJeUMj3bjy2HYj62nFoScm7PbVj3gIA9M8+5APOmwObOmdDHHZTW2PW/y4OO7oGRC05ir2gY2icOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdSTGFmnOF30AnkPibOEF+AfDGeB11h/t9rxRNYDCVw=;
 b=Tes9PkIBI5tivkz6EYKkBBKjVfZZra2qHkllmsLP1NeSmALIhuIFQsrek1PrjRXUzElVxwqdYW+6bSBDuOobm2bckoNBNajYROPC7+rHPAAETqeHayjSCDOlQOvSM65BOqze9EcN8jaF9rwlRsgXdZ8dguYkTsUumQ/KnmZ3nqQg9/Y4CITL8HkdsGfO9ki7w0uQkRF9r8+LQKA5HYEPTsmrLHh1IKn8el+LUht1ur1DjJZBHxowo8yHkI/GFHJ8GhMUJdNW4iN2I7AHiGbbdQnQU53RwXxILnuE20UxNBR26l47tIz3+V/aIVkoEUpPXQW39PcbtQqxpz6dYKMKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdSTGFmnOF30AnkPibOEF+AfDGeB11h/t9rxRNYDCVw=;
 b=V5tzivCf20GfbG4RyhFlZsGclG2eVg5gDSL3QbX5OQ9LYp8vmsNbRsBZos6Il+ItDDOwwxzH9XrMQYVVgjlyxbio3hvdfeqlbinOqgjwsncrstLfbwIFIkzEL5WLjcVadyyk72W85fUneD+kHy8LywQiHLxBNfnGdPPwGmfW9dA=
Received: from CH0PR03CA0409.namprd03.prod.outlook.com (2603:10b6:610:11b::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Thu, 24 Sep
 2026 06:35:37 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::13) by CH0PR03CA0409.outlook.office365.com
 (2603:10b6:610:11b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 06:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 06:35:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 01:35:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 01:35:35 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 01:35:34 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Shaoyun.Liu@amd.com>
CC: <Davis.Ming@amd.com>, <Gavin.Wan@amd.com>, Victor Zhao
 <Victor.Zhao@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu/mes: Support 64-bit register reads
Date: Thu, 24 Sep 2026 14:35:17 +0800
Message-ID: <20260924063519.688340-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e03ccaf-46b8-42f8-48d0-08df1a060b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: i9pl3sKhlH7FoU1KT+ekOg9BF9JCYHeVDcTeBKc56J7is+Mby1IU4itp2AxzkDxrl4rpRX6NmLWJqhsSuOuHziBtkMlmJVjDeddD7RuzOaf7D5jgHUu0ExrrtNNu9WmKSeVH+JXKgJuTVIn3GSL6F2yOPYjadmXRPs3Fmu8umn3bCWUTM0Qn8+funjPFa9PkVJxNwPPB9yjbyuw4DP/vkGe1TndI7UTRgTWd3B7Tlx9eE69jmun+rLEd2npp3j2yXM0UlynSXBeKMr3FOIZB8NlXhXOHX/4jRKsQ+PZAemvIk0ZcZF6/dhkwiK/LL8H8OACQPQR79bjqwRrrTm3ejuwVdgIhiRm+cF2b1l3RUz9LqlWLFGQTdORYfCxjKVpZj9I0ZABXs3gWMonikMAYgiuY5tuJjJsrkFfHxvRGDyME1VsIqFkmmyrcCzRKf8My+DyXKey8vNfcmmm1I6OpXs0jl8eciNO9gzWlFsVOWXGIF0diDqohRP03MF6qGs5s8v2Dqj3VzBHMnkPmkCbPkYZtkI0LmxfIN7JeJI4iUWFwmGSrkvV8Y+J/kMEiHvFid/g3vPt7ER7f2JzRGZXnVpmU5PgpgzjM/EwxjNehh7Jvo8nVzkNV8KkrVP1pJUDSm+7mFp18nqE08fzef571ZHE9yElo6eceqjR232WDrPsU/J9VTpMskatX3zboYVmXFbdJ8FiFP6XDgMh7dss3qg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UuOiPKarNQh05isP+KtotWKstm8eGdU7uWNCGxu9ktF9hZLJHdWh6tF+4riH5vvpiE54t7caudxw290JDfdVTuuUlfdPWfxrtLD2YvEu5Bt1Shg0v2JYDn+Oez1VTWN6xWdg+756qzWbMxapON6n6TSXvwoSbAQZ6eEAydImD12gUHxCLvyGZJdR4JIAASgnIO7ULwELOzxUTeebMlKHjaOiGClBKgAHtD1c8paaqgk5UdooraPCLz07t4L2ALxTETjZJqd16SzxdYspAW0IqPNMfR8uLrm5fd6pYalV9in1EW1iLGmN65tjxCtOM66FByWPqVXA6hVpWFpyC8w7clcHFPhOPRm7VmJFyQ8nsi7Bc3NxcK2vUqGmhuYswDQ2R3SGZql6heIseX5miSB0UZANp7YdLjbPHfaSy1nNH2mGEiaziKWRiBeE1UTd4Wx+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 06:35:36.9521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e03ccaf-46b8-42f8-48d0-08df1a060b35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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

v2: add MES 11 support with the same read64Bits option

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 42 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  2 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |  7 ++++
 6 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5bebe74de01ad..52b05dc7b74e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -582,6 +582,7 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
 	op_input.op = MES_MISC_OP_READ_REG;
 	op_input.read_reg.reg_offset = reg;
 	op_input.read_reg.buffer_addr = read_val_gpu_addr;
+	op_input.read_reg.read64_bits = false;
 
 	if (!adev->mes.funcs->misc_op) {
 		dev_err(adev->dev, "mes rreg is not supported!\n");
@@ -602,6 +603,47 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
 	return val;
 }
 
+uint64_t amdgpu_mes_rreg64(struct amdgpu_device *adev, uint32_t reg,
+			   uint32_t xcc_id)
+{
+	struct mes_misc_op_input op_input = { 0 };
+	uint64_t val = 0;
+	uint32_t addr_offset;
+	uint32_t *read_val_ptr;
+	int r;
+
+	if (amdgpu_wb_get(adev, &addr_offset)) {
+		dev_err(adev->dev, "critical bug! too many mes readers\n");
+		return 0;
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
+		goto error;
+	}
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r) {
+		dev_err(adev->dev, "failed to read reg (0x%x)\n", reg);
+	} else {
+		val = READ_ONCE(read_val_ptr[0]);
+		val |= (uint64_t)READ_ONCE(read_val_ptr[1]) << 32;
+	}
+
+error:
+	amdgpu_wb_free(adev, addr_offset);
+	return val;
+}
+
 int amdgpu_mes_wreg(struct amdgpu_device *adev, uint32_t reg,
 		    uint32_t val, uint32_t xcc_id)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 33a426f58e723..d67814124f9e1 100644
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
+uint64_t amdgpu_mes_rreg64(struct amdgpu_device *adev, uint32_t reg,
+			   uint32_t xcc_id);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		    uint32_t reg, uint32_t val, uint32_t xcc_id);
 int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index d8b4d3deff605..304087b851644 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -905,6 +905,8 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
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

