Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64D4C3ABCC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 02:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A0DC10E05B;
	Wed, 14 May 2025 02:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mOEx9oIU";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735EE10E05B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 02:56:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoV58GbXHU+1vLd6bXhyxX3IsMQMS0B1toCPV4skAzsqnEc6Qinlh2jmbLhPHXjj2C0WzDvxY1OHasRfxQEELUaCDqMkVekRx2KAfCgEjh/SAoUTjchR5Vi2MAQYX1yzd7MG4Gjotad2ogiLHwGC19ojfl7bXut5LidfMIkgapQ6im4erd1ETSWbM8HdtArW07k98wUlvBBtyWmeL8M+uMiqa8bFY/b93ajxBE02LsOhH8wi+lHBXBAk5VAzBBAleedtHrt7034VO0ebc8IiyYvlPRaQ3Z1Vo1/RZPEnWCI2C1meDbNWVVbpXJrGnVStrLnpFhBtB6mNZ/PXACBI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwQLFmZzArNxJbGK3CjDu577kNzPgACyJMVfuUUwW/8=;
 b=v9+Errq671D3UQ25Vx87+YXKOj01RbYJM+qYNNJjkss6YaMQCKAPRsnkdJgbspyWFJfLsCeI2FQsd6IE10m0IgndYxlJuvm35vV3k0E9mNfBS/n2YHpKeX01kMy209bCgbipBMQiBHyFNSzJfbBepzLbnrrEIIDMgNqtBidz2UlB0IkUc/RsoIaWnyYlBFB5Vvdr9NKrzJjLZJEpIlzrVe8S8xReCnUq0Y1BNs0VrY+U0H/adYAA5MOMB7znVv/pGRlq1pj5jravG2YVHY2HASbs3Gti/Ubyth3Keifwm3oVnhVbbB6MXmcHgi4VXgjpNgHfYHsZOkFBsx5C9I5/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwQLFmZzArNxJbGK3CjDu577kNzPgACyJMVfuUUwW/8=;
 b=mOEx9oIUHHQe7HK4XHbN3g1DVyUBQ/W4dLphVvDOhz63E3cOeO7SYwpcvhtYbDSREe432ZqQA+TcN6rKXWRZcP/AyF0SvluauUXbHsqWf+hI7S7v2Ix7KsaW7pjxDd9nCCW/FyOkGCjbhxn0U75F1bFd8BfqR2AC/K5a22MnCDk=
Received: from SA9PR13CA0056.namprd13.prod.outlook.com (2603:10b6:806:22::31)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 14 May
 2025 02:56:27 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::e9) by SA9PR13CA0056.outlook.office365.com
 (2603:10b6:806:22::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Wed,
 14 May 2025 02:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 02:56:27 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 21:56:20 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH Review 2/2] drm/amdgpu: Register aqua vanjaram jpeg poison irq
Date: Wed, 14 May 2025 10:56:01 +0800
Message-ID: <20250514025601.42366-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250514025601.42366-1-Stanley.Yang@amd.com>
References: <20250514025601.42366-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3e27f4-d2c0-47fb-c592-08dd9292eb9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sEu7TgfwO3TwNNcijqaiExZs/yRvnigq7mdhznB05C00UcMqmXDUbyqMydvY?=
 =?us-ascii?Q?hPsU/HxgC19vsMrs1DZkMkzdIZLvkcZFK9r5fKLscrEUwXMV7T+UXrPVaMxU?=
 =?us-ascii?Q?fsvH5DTm6xu4l+RoYVlV4Wyw2lHWYivh/QPaSg4KLXGaP7hX3tAlfRyxEjUw?=
 =?us-ascii?Q?nJBMjfXj+RkdyBXWF6ovRkorWZG2wR67FMeYELEGmQ2dcHc5K3TOVvQ03ojt?=
 =?us-ascii?Q?/YsxWfA0pYFA8KgAl6nizRyKI9Olr3K0M5uPzRkZlViGoG7yCYXyTJQwejLe?=
 =?us-ascii?Q?BYnXTyZkoFaidgdWUDGdRWrgH/sdlqJCQgdvHlgR7KcnW1xDCBv7rPO2psZW?=
 =?us-ascii?Q?9ka9wQJKlQLWryCtkPlijOoiUDYNevoLH+smjRVM3GAtpWj6lKwx4AHs9bpZ?=
 =?us-ascii?Q?ZgpoVdftHm7j50F+CzmLRADKJ7cRgUg39BN210yJCAFdlXR78jKXUPcdRGi2?=
 =?us-ascii?Q?DF4P6NjqOEhJ7JXYC5NAi1LlSdpKQPacLG2xZGkR7HNg1uS1vftuX8f+laTF?=
 =?us-ascii?Q?NWwfvPSTpeu47LpgJ+Rl/y9k8xVHceMjH4vOD7kju0pWrcDDZbeZ7Gu94eM2?=
 =?us-ascii?Q?IcLVVdTBKvbx5n6TKAEli9A2p/JZL5mWYB5wAc/yiNQXCZybNFM1hjmGuQ5M?=
 =?us-ascii?Q?Ncbz4Qk0LOkxJ9HgYMeHTLWofWMtf4zLyHGTRi4/0Lz2q0kpSaTb1X+Ys0Qu?=
 =?us-ascii?Q?Xiw2SPu8p4TsgOcSKJKQxG2WwrqMdNAepjRJI5WECSEAG0hf1hhVWlY+Z9ot?=
 =?us-ascii?Q?8VOvokSqFhZgkWcuyGg4izvpu1ykm/YU+zgJ03aUHS6+U9+NdDtWkYC347Jh?=
 =?us-ascii?Q?nxjBMXh6v8IgZUHHpOtgt2WBZXlbqLKYhPlDmx00WBOgPAC6u0PbWlYVKLsn?=
 =?us-ascii?Q?nJFc4U6b40FvXvaKzyS4WkXKNb5fqqmOtc1W7KeUp09iUYfXyAcaHN16I5OW?=
 =?us-ascii?Q?dEyjH0tn3dyPnoC/5JqXhKbqmTDmiNRl1P4wFynica7U9a8o2xikE8lVHZcF?=
 =?us-ascii?Q?ggXWwLKGe1C/XT6prjmPfu9jnr2ls3yynwz8YUz5RPH9PXO8+U5rgJWSN1Ss?=
 =?us-ascii?Q?bAqnIz3BysWUTQRhe6cWthQoE2rM74PhyuI1WyoXINJaNtL7gaVQJBbSpVge?=
 =?us-ascii?Q?ZfpDTexyI0NLOSL8wwuhjQdb7DsxMc/fMXzvDn0LsHPGvGabiskaEWobfs0q?=
 =?us-ascii?Q?fcZthFzDboXniWTtIIaugAp3ih8L82Ytu0yM9+ISS3IjxSjgkXcgK+ribWz0?=
 =?us-ascii?Q?wGL8zdveCPkdCsx8qPC4GHkA75wYmJCu1/Kbla1q1oDRtiGWhQfQrD7yriNi?=
 =?us-ascii?Q?BiHNJUW9vyQJ4gSxnX+Cu1HPwNRq98Wug8kRWOr0DMsyornolQ4CMWrbZvi0?=
 =?us-ascii?Q?XFzpYjKhXirTIUY0xTPemtaM9GBclp0f323lVpAxEO0FOQgdXstU4Yq4f82h?=
 =?us-ascii?Q?djni2NxAkr81p7EfSL3zssA/6Y8RWQiVHum+3zw+uaG3qQGHzAiRrK+Z5B4p?=
 =?us-ascii?Q?B3VQtHpPzikAE53Gsz43mie2TxHF14KufdUA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 02:56:27.1782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3e27f4-d2c0-47fb-c592-08dd9292eb9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315
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

Register aqua vanjaram jpeg poison irq, add jpeg poison handle.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 76 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  7 +++
 2 files changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index a8ccae361ec7..79e342d5ab28 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -149,6 +149,18 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	/* JPEG DJPEG POISON EVENT */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst->ras_poison_irq);
+	if (r)
+		return r;
+
+	/* JPEG EJPEG POISON EVENT */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst->ras_poison_irq);
+	if (r)
+		return r;
+
 	r = amdgpu_jpeg_sw_init(adev);
 	if (r)
 		return r;
@@ -434,6 +446,9 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 			ret = jpeg_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
+		amdgpu_irq_put(adev, &adev->jpeg.inst->ras_poison_irq, 0);
+
 	return ret;
 }
 
@@ -1041,6 +1056,14 @@ static int jpeg_v4_0_3_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_3_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
@@ -1200,6 +1223,11 @@ static const struct amdgpu_irq_src_funcs jpeg_v4_0_3_irq_funcs = {
 	.process = jpeg_v4_0_3_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs jpeg_v4_0_3_ras_irq_funcs = {
+	.set = jpeg_v4_0_3_set_ras_interrupt_state,
+	.process = amdgpu_jpeg_process_poison_irq,
+};
+
 static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -1208,6 +1236,9 @@ static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
 		adev->jpeg.inst->irq.num_types += adev->jpeg.num_jpeg_rings;
 	}
 	adev->jpeg.inst->irq.funcs = &jpeg_v4_0_3_irq_funcs;
+
+	adev->jpeg.inst->ras_poison_irq.num_types = 1;
+	adev->jpeg.inst->ras_poison_irq.funcs = &jpeg_v4_0_3_ras_irq_funcs;
 }
 
 const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block = {
@@ -1304,9 +1335,47 @@ static void jpeg_v4_0_3_reset_ras_error_count(struct amdgpu_device *adev)
 		jpeg_v4_0_3_inst_reset_ras_error_count(adev, i);
 }
 
+static uint32_t jpeg_v4_0_3_query_poison_by_instance(struct amdgpu_device *adev,
+		uint32_t instance, uint32_t sub_block)
+{
+	uint32_t poison_stat = 0, reg_value = 0;
+
+	switch (sub_block) {
+	case AMDGPU_JPEG_V4_0_3_JPEG0:
+		reg_value = RREG32_SOC15(JPEG, instance, regUVD_RAS_JPEG0_STATUS);
+		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_JPEG0_STATUS, POISONED_PF);
+		break;
+	case AMDGPU_JPEG_V4_0_3_JPEG1:
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
+static bool jpeg_v4_0_3_query_ras_poison_status(struct amdgpu_device *adev)
+{
+	uint32_t inst = 0, sub = 0, poison_stat = 0;
+
+	for (inst = 0; inst < adev->jpeg.num_jpeg_inst; inst++)
+		for (sub = 0; sub < AMDGPU_JPEG_V4_0_3_MAX_SUB_BLOCK; sub++)
+			poison_stat +=
+			jpeg_v4_0_3_query_poison_by_instance(adev, inst, sub);
+
+	return !!poison_stat;
+}
+
 static const struct amdgpu_ras_block_hw_ops jpeg_v4_0_3_ras_hw_ops = {
 	.query_ras_error_count = jpeg_v4_0_3_query_ras_error_count,
 	.reset_ras_error_count = jpeg_v4_0_3_reset_ras_error_count,
+	.query_poison_status = jpeg_v4_0_3_query_ras_poison_status,
 };
 
 static int jpeg_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
@@ -1383,6 +1452,13 @@ static int jpeg_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 	if (r)
 		return r;
 
+	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
+		adev->jpeg.inst->ras_poison_irq.funcs) {
+		r = amdgpu_irq_get(adev, &adev->jpeg.inst->ras_poison_irq, 0);
+		if (r)
+			goto late_fini;
+	}
+
 	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__JPEG,
 				&jpeg_v4_0_3_aca_info, NULL);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
index a90bf370a002..2e110d04af84 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -46,6 +46,13 @@
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
+enum amdgpu_jpeg_v4_0_3_sub_block {
+	AMDGPU_JPEG_V4_0_3_JPEG0 = 0,
+	AMDGPU_JPEG_V4_0_3_JPEG1,
+
+	AMDGPU_JPEG_V4_0_3_MAX_SUB_BLOCK,
+};
+
 extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
 
 void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
-- 
2.25.1

