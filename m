Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE18AC54E65
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 04:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D67C10E4D7;
	Tue, 20 May 2025 04:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yntm2FLQ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3705610E4CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 04:27:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEWdfYiEpuNBZiV+Ou76cEsPCBj1GzsAvBp1AdF+vSx6IVOMH79hQOqpr46gSb0KYGU3j+VZCKa1eb3ewT2Me9Ff21+uV1MHPpaPcJOqipmUvQ26kyXXAA1ki5qPsyweFzLCTSimJbMo0vwfOhqEbiVo6ih2EpPB8mSFn2CpJYGXY8J5H+oCUB533t5CikvLTavQMLqdSCrYbRbb2+Ii2XlkYbR02Lfuoag1V5sz0w1KWH582BofuQSEJQy+WKw0kIcMZVCRolOW2r0SVa84rwEOtkoZuCwvB80QMO5YhpS8q3GAPtU4CZd8HgVMyxyOt4TSNU6p7PljTMSwL3hdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd4oo2OcNNAA0IDFSowVYvXng7Yel2VaTihqa99DY9A=;
 b=UZ+CW7hw6yjnwz1rdj1jIRXP0FbVqYy4RQVqFT6ZJvW93hgqY1ZLinZsPm6LMS8yWNtbJuhf/ONw0vDx574dmrGj2dZ3N02pGUyNlBOm8cLlGme+3xHQY75X6vqc1VQ5PoOf8gTJNn3Re6kUcjT5NAjFsbjlTUSMeE6q8ImRQFHQTxelWS5m+AiiMqjoSesTV/BVaQ4pwUSHWJL/0HePciMY+5jkOetzHpYpVOx3GMM5VQVKoDV5VZj7M6IugD7DLpj52SnmePCcGec59VIuMPWaxlvNLkZ3pxcRZ88FaBSijB4ySSJcK0YUHeIVQJjBBg3mBO8XjB/QzmPi958CpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd4oo2OcNNAA0IDFSowVYvXng7Yel2VaTihqa99DY9A=;
 b=Yntm2FLQXLgcuK43i/GAe7zrhqxgHxdqU4TkTi6NnkkjAfV9p/6RB3iZ1Xe+YTMX8AMuwEE4UTejaVwGVnsdfw9T94ExD782iuhYQf3c+SILNdb2rpRATzqhrRsAWRjpuJT29J23bV1g81OR0cPjwYTiu8STeTTpgTpb87N6M90=
Received: from BN9PR03CA0483.namprd03.prod.outlook.com (2603:10b6:408:130::8)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 20 May
 2025 04:27:06 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::4e) by BN9PR03CA0483.outlook.office365.com
 (2603:10b6:408:130::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Tue,
 20 May 2025 04:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Tue, 20 May 2025 04:27:05 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 23:27:03 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Stanley.Yang@amd.com>, <Tao.Zhou1@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>
Subject: [PATCH v2 4/5] drm/amdgpu: Enable RAS for jpeg 5.0.1
Date: Tue, 20 May 2025 12:26:42 +0800
Message-ID: <20250520042642.1606715-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 841fb6ff-27da-46c9-d9e1-08dd975693b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aD3AttPXo3fBcbiExe1GUJUMmYPPyfRtWJqpOCqmmGEUt/hNZQyfo0jTA6rZ?=
 =?us-ascii?Q?PAf9Ses/CKgqfULp/6R6HT4fIDmfAQ7qiNp0xbbeoyhtEjv+ZekC/wLKuATj?=
 =?us-ascii?Q?7vVSR+Ayn+KSuBaQnaRdqf9/Bo8GuXIeDHelo8Hz+w6J7f0jAElkukRxE1Hg?=
 =?us-ascii?Q?rzyAmeyZfYgAH5uyQVKjdSK4aiR91j5UgvDNsgiLtgwuJfiRjB6WLvN22HiG?=
 =?us-ascii?Q?0jLrg00wNxgGro9tdIuYAD+TUzYajTlzFuqYNx+UrGkZKGuBuRKV4QKQ3LzM?=
 =?us-ascii?Q?u3YnyN2TeAG2hOLBKGPlJS7MO1qpbQk6tS4H7SjwCJVejktHknytsSXIhKVH?=
 =?us-ascii?Q?pZiizzcIS42dzWjarzh5+fJykoQTCkCyvCc9PGP1x37SLmceUdl7kA5C5K/p?=
 =?us-ascii?Q?4u2qvIGZGFAlGOYTBwLFlxpYdC7v88BXGM1pYEyQS0WxrDRRgQ5g9b3QcPyO?=
 =?us-ascii?Q?wqMLd+C+/wXxBSjgSh8I0WMPz0OUydgChBH8frRdtIbTQ/0Eo/piGEDq/vuW?=
 =?us-ascii?Q?88UJKgdb8AYA5aVrI+N4i4mUP7ul6+2M+UGh9uWFPyypEEltrTbwnP/BLEai?=
 =?us-ascii?Q?SD+bhvxLmR03F/ucYz4QXtzwjpRFVf41TTXUfjgwAECP6hw22sXD8TchW8uU?=
 =?us-ascii?Q?OaBIzQKnVaJPbMvbaccfEa/6uXXIsbbxHgtUDSMwplINSbD+pyvKEiMc4A+6?=
 =?us-ascii?Q?2sNGv+vLqvl3OngwzF6RhktFv9gh9uAvxRUY2BGSIxuPFV0LwCgK7Z2Jv689?=
 =?us-ascii?Q?0h2eGPvw3L5nxu8g48V3vViKcueiaoRrPB90nMf1JoSspY9BqEF9f415276s?=
 =?us-ascii?Q?hAUOpxekfwk9bWO4n3UZQMA3cyWMj4ve/3bsIF3RW4dvTO1crb24zXPVjXBY?=
 =?us-ascii?Q?46rnO5xqwjNQ2DlNJahH+xQ9TCCxx9yHH6DnyDjvDw1i4mf65pvlOCCBKzVy?=
 =?us-ascii?Q?Xbs4pzuNO/gfwHiKWXUbiB1WYktfz48U9LBiFjbj5Um3+7bLWKDCMN+h/c03?=
 =?us-ascii?Q?gCKVnK2lC08Or0f3YM/d7SNE1CyuAtjc+tMdCpknBiCdm5oI5NM6k5fUfgcC?=
 =?us-ascii?Q?AHhxD8pfcOAgIlEf0Ge4BWzhnFIoJdvxUVP+VEhpBNDPDo/A7BZ8l8wtK3D+?=
 =?us-ascii?Q?/M46xU5G+I+dw1tWlUExQkGOJfDWMJIBRRCexfSy7VbiSMYgpGvdXcRjwA2D?=
 =?us-ascii?Q?nddaVF7tYMJ0cSfBFnGSy1Mf3+zrtekyGw5P8ZTxdTfAPFJamc7kUxfqe2fn?=
 =?us-ascii?Q?Kv5RvcuZq2VXKk+3LlD8b2fT6Z50kauEjBxWyYDNtq5faXYPuVw2qD+O7+LC?=
 =?us-ascii?Q?xfe/ZHWGFUxakoSiCEN7NFtFbBP4wJNnJMzsq3nSZm0cBlt/VEoRFrnT46mj?=
 =?us-ascii?Q?hABcrNcuFsEm5VmiWFdpPaYoSkcrTuIajGs1aZ8JlBIuAQR4Zrpi5nHIs4KL?=
 =?us-ascii?Q?vgYkL3rXXOYW4undyyD6TXWpeiWl5wTAWxjx5LaKXeWO18asbOPisbsE4p7A?=
 =?us-ascii?Q?nEWpdopgISw0jNPoWinf1XUq+FpXjbOZj0WR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 04:27:05.7271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 841fb6ff-27da-46c9-d9e1-08dd975693b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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

Enable jpeg ras posion processing and aca error logging

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
---
v2:query ras error count legacy callback removed

 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 182 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h |  10 ++
 2 files changed, 192 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 6f73033d78b5..758a017124f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -37,6 +37,7 @@ static void jpeg_v5_0_1_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					     enum amd_powergating_state state);
+static void jpeg_v5_0_1_set_ras_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_1_dec_ring_set_wptr(struct amdgpu_ring *ring);
 
 static int amdgpu_ih_srcid_jpeg[] = {
@@ -118,6 +119,7 @@ static int jpeg_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS;
 	jpeg_v5_0_1_set_dec_ring_funcs(adev);
 	jpeg_v5_0_1_set_irq_funcs(adev);
+	jpeg_v5_0_1_set_ras_funcs(adev);
 
 	return 0;
 }
@@ -142,6 +144,17 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 	}
+	/* JPEG DJPEG POISON EVENT */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+			VCN_5_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst->ras_poison_irq);
+	if (r)
+		return r;
+
+	/* JPEG EJPEG POISON EVENT */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+			VCN_5_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst->ras_poison_irq);
+	if (r)
+		return r;
 
 	r = amdgpu_jpeg_sw_init(adev);
 	if (r)
@@ -294,6 +307,9 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
 		ret = jpeg_v5_0_1_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
+		amdgpu_irq_put(adev, &adev->jpeg.inst->ras_poison_irq, 0);
+
 	return ret;
 }
 
@@ -603,6 +619,16 @@ static int jpeg_v5_0_1_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_0_1_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
+
+
 static int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *source,
 					 struct amdgpu_iv_entry *entry)
@@ -772,6 +798,11 @@ static const struct amdgpu_irq_src_funcs jpeg_v5_0_1_irq_funcs = {
 	.process = jpeg_v5_0_1_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs jpeg_v5_0_1_ras_irq_funcs = {
+	.set = jpeg_v5_0_1_set_ras_interrupt_state,
+	.process = amdgpu_jpeg_process_poison_irq,
+};
+
 static void jpeg_v5_0_1_set_irq_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -780,6 +811,10 @@ static void jpeg_v5_0_1_set_irq_funcs(struct amdgpu_device *adev)
 		adev->jpeg.inst->irq.num_types += adev->jpeg.num_jpeg_rings;
 
 	adev->jpeg.inst->irq.funcs = &jpeg_v5_0_1_irq_funcs;
+
+	adev->jpeg.inst->ras_poison_irq.num_types = 1;
+	adev->jpeg.inst->ras_poison_irq.funcs = &jpeg_v5_0_1_ras_irq_funcs;
+
 }
 
 const struct amdgpu_ip_block_version jpeg_v5_0_1_ip_block = {
@@ -789,3 +824,150 @@ const struct amdgpu_ip_block_version jpeg_v5_0_1_ip_block = {
 	.rev = 1,
 	.funcs = &jpeg_v5_0_1_ip_funcs,
 };
+
+static uint32_t jpeg_v5_0_1_query_poison_by_instance(struct amdgpu_device *adev,
+		uint32_t instance, uint32_t sub_block)
+{
+	uint32_t poison_stat = 0, reg_value = 0;
+
+	switch (sub_block) {
+	case AMDGPU_JPEG_V5_0_1_JPEG0:
+		reg_value = RREG32_SOC15(JPEG, instance, regUVD_RAS_JPEG0_STATUS);
+		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_JPEG0_STATUS, POISONED_PF);
+		break;
+	case AMDGPU_JPEG_V5_0_1_JPEG1:
+		reg_value = RREG32_SOC15(JPEG, instance, regUVD_RAS_JPEG1_STATUS);
+		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_JPEG1_STATUS, POISONED_PF);
+		break;
+	default:
+		break;
+	}
+
+	if (poison_stat)
+		dev_info(adev->dev, "Poison detected in JPEG%d sub_block%d\n",
+			instance, sub_block);
+
+	return poison_stat;
+}
+
+static bool jpeg_v5_0_1_query_ras_poison_status(struct amdgpu_device *adev)
+{
+	uint32_t inst = 0, sub = 0, poison_stat = 0;
+
+	for (inst = 0; inst < adev->jpeg.num_jpeg_inst; inst++)
+		for (sub = 0; sub < AMDGPU_JPEG_V5_0_1_MAX_SUB_BLOCK; sub++)
+			poison_stat +=
+			jpeg_v5_0_1_query_poison_by_instance(adev, inst, sub);
+
+	return !!poison_stat;
+}
+
+static const struct amdgpu_ras_block_hw_ops jpeg_v5_0_1_ras_hw_ops = {
+	.query_poison_status = jpeg_v5_0_1_query_ras_poison_status,
+};
+
+static int jpeg_v5_0_1_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
+				      enum aca_smu_type type, void *data)
+{
+	struct aca_bank_info info;
+	u64 misc0;
+	int ret;
+
+	ret = aca_bank_info_decode(bank, &info);
+	if (ret)
+		return ret;
+
+	misc0 = bank->regs[ACA_REG_IDX_MISC0];
+	switch (type) {
+	case ACA_SMU_TYPE_UE:
+		bank->aca_err_type = ACA_ERROR_TYPE_UE;
+		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
+						     1ULL);
+		break;
+	case ACA_SMU_TYPE_CE:
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
+		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
+						     ACA_REG__MISC0__ERRCNT(misc0));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+/* reference to smu driver if header file */
+static int jpeg_v5_0_1_err_codes[] = {
+	16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-7][S|D] */
+	24, 25, 26, 27, 28, 29, 30, 31
+};
+
+static bool jpeg_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
+					 enum aca_smu_type type, void *data)
+{
+	u32 instlo;
+
+	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
+	instlo &= GENMASK(31, 1);
+
+	if (instlo != mmSMNAID_AID0_MCA_SMU)
+		return false;
+
+	if (aca_bank_check_error_codes(handle->adev, bank,
+				       jpeg_v5_0_1_err_codes,
+				       ARRAY_SIZE(jpeg_v5_0_1_err_codes)))
+		return false;
+
+	return true;
+}
+
+static const struct aca_bank_ops jpeg_v5_0_1_aca_bank_ops = {
+	.aca_bank_parser = jpeg_v5_0_1_aca_bank_parser,
+	.aca_bank_is_valid = jpeg_v5_0_1_aca_bank_is_valid,
+};
+
+static const struct aca_info jpeg_v5_0_1_aca_info = {
+	.hwip = ACA_HWIP_TYPE_SMU,
+	.mask = ACA_ERROR_UE_MASK,
+	.bank_ops = &jpeg_v5_0_1_aca_bank_ops,
+};
+
+static int jpeg_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
+		adev->jpeg.inst->ras_poison_irq.funcs) {
+		r = amdgpu_irq_get(adev, &adev->jpeg.inst->ras_poison_irq, 0);
+		if (r)
+			goto late_fini;
+	}
+
+	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__JPEG,
+				&jpeg_v5_0_1_aca_info, NULL);
+	if (r)
+		goto late_fini;
+
+	return 0;
+
+late_fini:
+	amdgpu_ras_block_late_fini(adev, ras_block);
+
+	return r;
+}
+
+static struct amdgpu_jpeg_ras jpeg_v5_0_1_ras = {
+	.ras_block = {
+		.hw_ops = &jpeg_v5_0_1_ras_hw_ops,
+		.ras_late_init = jpeg_v5_0_1_ras_late_init,
+	},
+};
+
+static void jpeg_v5_0_1_set_ras_funcs(struct amdgpu_device *adev)
+{
+	adev->jpeg.ras = &jpeg_v5_0_1_ras;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
index efdab57324e4..a7e58d5fb246 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
@@ -26,6 +26,9 @@
 
 extern const struct amdgpu_ip_block_version jpeg_v5_0_1_ip_block;
 
+#define regUVD_JRBC0_UVD_JRBC_SCRATCH0_INTERNAL_OFFSET			0x4094
+#define regUVD_JRBC_EXTERNAL_MCM_ADDR_INTERNAL_OFFSET			0x1bffe
+
 #define regUVD_JRBC0_UVD_JRBC_RB_WPTR                                                         0x0640
 #define regUVD_JRBC0_UVD_JRBC_RB_WPTR_BASE_IDX                                                1
 #define regUVD_JRBC0_UVD_JRBC_STATUS                                                          0x0649
@@ -98,4 +101,11 @@ extern const struct amdgpu_ip_block_version jpeg_v5_0_1_ip_block;
 #define regVCN_RRMT_CNTL                          0x0940
 #define regVCN_RRMT_CNTL_BASE_IDX                 1
 
+enum amdgpu_jpeg_v5_0_1_sub_block {
+	AMDGPU_JPEG_V5_0_1_JPEG0 = 0,
+	AMDGPU_JPEG_V5_0_1_JPEG1,
+
+	AMDGPU_JPEG_V5_0_1_MAX_SUB_BLOCK,
+};
+
 #endif /* __JPEG_V5_0_1_H__ */
-- 
2.34.1

