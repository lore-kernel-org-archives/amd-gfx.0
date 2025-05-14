Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37C0C3ABC3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 02:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E06210E05E;
	Wed, 14 May 2025 02:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MTxUwkEE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20F110E05E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 02:56:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PE+SQWKCNGJEMZAIvd5c6kY5eEIR7r3Mc75xZOhVlR//PGgqvFE8MnSv1mwa59YLSYhuI6wQ+xTVZRR/ngrrGJdr2WVzRH/V+7wH2f/yVOomRRFW/hauhkki99Km9AryVmFF9CLsXlohmwQD4L7kEaPKAeDpu8/AbDDYR9wqL+nRJ6fCoalOvO8NLZg47YN7ntmutIGR8g11yWsJt03KAGQwGKNCHo0dza2hP1MiMot83Sy/n6T/mVHbPRe0TQxGu3ukV9CONygIbA3NhUIbnriFlkCHBi3iVWTO9FTD7Yqc2yuDD1gK1qtdcIfApY4bhUIC6ewBLEjffgJ5PrF+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTSq4NvBsbTz+R2y5w00Xw3R+j6MihS+YrLE2io5N1Y=;
 b=TyKD/P6rPayeMJZXmnBwCjx6JUmMRrHVz7qjBaVChvlJITOj9ZJ+OV5sR6iUhwVAnHP1os3vfl2z518PDNI3H1Bc1oJVoGdp2NG0ii+Fb2MiCgA5cCXtKZWWyAx8WH/lNbEQTbLbfs7aPW0GSBZDiXO/1xUFf2bbUF5vyPXkZRcSg79VnYV4c225ArOQH6Sef+3W9GvN0v02gFX/JXnFzmn6NurIyuVxYdWAiYI2RyBCevU/rWHQ8QAVHCdeDQLll9uReWd+2AIO6A23nZ2IyRHVyJCHJXAF8TwLTRG1FDwpHF7ggVc/mDq26JUDhpXifQ71WEr7uZ4moqfjzqmVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTSq4NvBsbTz+R2y5w00Xw3R+j6MihS+YrLE2io5N1Y=;
 b=MTxUwkEErCC2JGiW1JLRCXllSClK3em5x1EjlZ7N08VQHhqr566Utb2y/IPEsfjLgFraOWK9bDcqWQ+xr8UtN2S2uHrdk4T1IZ9VkWRFTPguEz8GvA6D4G3u5wEyYcwvp2qPHCrD9GiyvvLDzDGERblFaw9b6RZz6uIMv3XLMTw=
Received: from SA9PR13CA0044.namprd13.prod.outlook.com (2603:10b6:806:22::19)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 02:56:26 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::a8) by SA9PR13CA0044.outlook.office365.com
 (2603:10b6:806:22::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.10 via Frontend Transport; Wed,
 14 May 2025 02:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 02:56:25 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 21:56:18 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH Review 1/2] drm/amdgpu: Register aqua vanjaram vcn poison irq
Date: Wed, 14 May 2025 10:56:00 +0800
Message-ID: <20250514025601.42366-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c28e680-bc0f-45e9-05b9-08dd9292eac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?scjNkz8+lJYkkszpJcq6myNa4VSwgVUFrIL1Tnv/sECnCm7R3568wKQRzcrx?=
 =?us-ascii?Q?uePGJoXveNV1MDWHShJme0UkOebwNPbk0iDLYLnf1UImNRb/mN/t09T2j0ee?=
 =?us-ascii?Q?kqy45baQROUJmv+Ie4EY9wHdrApjZwY8G70sEKY908zKx72sOMJTe0TySsQQ?=
 =?us-ascii?Q?PMdLYWKp+CUTVJhY7zxnJfwzHQj+zA+7AGMufSrZPM4pbIiuWkdvhoVvwmrg?=
 =?us-ascii?Q?6kcZEcemNP3ksRwM5RxcRLQ5rdzC8bjq8EEaRzR9QyqT8uNJnXRVuDIKQgmZ?=
 =?us-ascii?Q?VLZO5woApiDZ2T0N8Go/BbaYwkrLlBJmIS3oajEazLYcutZCAj+etHLEF0Pu?=
 =?us-ascii?Q?82x0KNLR2L14PApvTN7kAt7ObY8EG59elfUwVVXLrvEh6L/IXXezKUTVgaWV?=
 =?us-ascii?Q?PtJUJnRPTBcDMUO8n2qJSsMZBWM94N5qt6ZKsIo7mCZDQ/nrFPklJkfXZmJt?=
 =?us-ascii?Q?C3RDjSXfMKrFB3CsPVSTMSRgGRP6PI0y82FNUb+SHcOsaF+ZIxW9cJmFEcOx?=
 =?us-ascii?Q?3TGOgG3nIiJK/0etMl2kIUCzyngi8LGdrBTJlBCmfmQ5uuHlPX+J6WAzlMAy?=
 =?us-ascii?Q?UUmAga4kEiOSynQl9DnddsCTDby6duGBN2xbHKTDKARDINjd1pAalMtXQaBn?=
 =?us-ascii?Q?IOsrZhzpevbzPPf9SKcAHaWgPyd1pdg7FOpFo58PiKatyxJFKymfz+2lJH71?=
 =?us-ascii?Q?8Q0IE9pusVnuKTC22EYe+si5YmlQfA4Y8lx8PdkJR68IfSBdZUjluTB0wdpQ?=
 =?us-ascii?Q?kCdEBWtCIOR1QprsG5ozufJlWiW4f858xrqjtohsDelp83TYYZDIeLUfmMvJ?=
 =?us-ascii?Q?VgJoog+wldQFY5IPLsUNbrfVjHmVsFInhABt69Dp0NpSzcJZ7xNQifm1fV4c?=
 =?us-ascii?Q?CIcrV+Kj5cgb3ieVHZywTVLxjHmNUXIhx9XIRcRn3a4aaNyLfAkqzJBD6NCq?=
 =?us-ascii?Q?mKkZCZlDkkEW/3AzGa1vr8m1lPJn0bKiF2a9Sy0qYfG52wTCNa4eFFP1eeci?=
 =?us-ascii?Q?m5eY8XUfAhkTtlgPdBusk+MJTo0DwNi6RC4kZU8otKrh5L1IdXH6WmstgyRn?=
 =?us-ascii?Q?QDsQOG+2dICoWSTx2hdQ1ApL5Bk8KsE4CA6A9C0qz4PzIMYgxqIFKggo63WY?=
 =?us-ascii?Q?+I6NRa9tLwYXV8FXS8fpvuhg1w3qdQK6OPfbwglGWEscxki61+sbDU+AqGob?=
 =?us-ascii?Q?vpDgZVe+wTIeC3SpIx9ihPEjpaa4SCTQWvGxZVm73hMKS6EyP6p/fG4a3djz?=
 =?us-ascii?Q?m0NMemH6o56gzRatR0mDjNoRPA85OPNfXBK7axm1JRHVZqp0myDKDfOCG0Ur?=
 =?us-ascii?Q?pKqOd8jzgtmY/gAZp5L80p/mQpnQDLbDfrypubi7Bsuq677iXERRhhuk1tpd?=
 =?us-ascii?Q?bGuRtP5BMotOXHs8POxJZVTf4xFQugEf5LjPD8pbDySiqgKwwpsdVsZzy60O?=
 =?us-ascii?Q?yTVzvfNBanb2wJahmv798Hc2ruTZXyWPp08Es0RbQXpcxmX4MqxGCnJjAn4X?=
 =?us-ascii?Q?znxANlRg/2CNdQwehmSgZKTY2BYboTISUEYL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 02:56:25.7390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c28e680-bc0f-45e9-05b9-08dd9292eac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257
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

Register aqua vanjaram vcn poison irq, add vcn poison handle.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 65 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h |  6 +++
 2 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 139c83bd165e..fbf9695cc62f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -168,6 +168,10 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	/* VCN POISON TRAP */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst->ras_poison_irq);
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 
 		r = amdgpu_vcn_sw_init(adev, i);
@@ -386,6 +390,9 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+		amdgpu_irq_put(adev, &adev->vcn.inst->ras_poison_irq, 0);
+
 	return 0;
 }
 
@@ -1813,11 +1820,24 @@ static int vcn_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int vcn_v4_0_3_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
 	.set = vcn_v4_0_3_set_interrupt_state,
 	.process = vcn_v4_0_3_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs vcn_v4_0_3_ras_irq_funcs = {
+	.set = vcn_v4_0_3_set_ras_interrupt_state,
+	.process = amdgpu_vcn_process_poison_irq,
+};
+
 /**
  * vcn_v4_0_3_set_irq_funcs - set VCN block interrupt irq functions
  *
@@ -1833,6 +1853,9 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
 		adev->vcn.inst->irq.num_types++;
 	}
 	adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
+
+	adev->vcn.inst->ras_poison_irq.num_types = 1;
+	adev->vcn.inst->ras_poison_irq.funcs = &vcn_v4_0_3_ras_irq_funcs;
 }
 
 static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -1980,9 +2003,44 @@ static void vcn_v4_0_3_reset_ras_error_count(struct amdgpu_device *adev)
 		vcn_v4_0_3_inst_reset_ras_error_count(adev, i);
 }
 
+static uint32_t vcn_v4_0_3_query_poison_by_instance(struct amdgpu_device *adev,
+			uint32_t instance, uint32_t sub_block)
+{
+	uint32_t poison_stat = 0, reg_value = 0;
+
+	switch (sub_block) {
+	case AMDGPU_VCN_V4_0_3_VCPU_VCODEC:
+		reg_value = RREG32_SOC15(VCN, instance, regUVD_RAS_VCPU_VCODEC_STATUS);
+		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_VCPU_VCODEC_STATUS, POISONED_PF);
+		break;
+	default:
+		break;
+	}
+
+	if (poison_stat)
+		dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
+			instance, sub_block);
+
+	return poison_stat;
+}
+
+static bool vcn_v4_0_3_query_poison_status(struct amdgpu_device *adev)
+{
+	uint32_t inst, sub;
+	uint32_t poison_stat = 0;
+
+	for (inst = 0; inst < adev->vcn.num_vcn_inst; inst++)
+		for (sub = 0; sub < AMDGPU_VCN_V4_0_3_MAX_SUB_BLOCK; sub++)
+			poison_stat +=
+			vcn_v4_0_3_query_poison_by_instance(adev, inst, sub);
+
+	return !!poison_stat;
+}
+
 static const struct amdgpu_ras_block_hw_ops vcn_v4_0_3_ras_hw_ops = {
 	.query_ras_error_count = vcn_v4_0_3_query_ras_error_count,
 	.reset_ras_error_count = vcn_v4_0_3_reset_ras_error_count,
+	.query_poison_status = vcn_v4_0_3_query_poison_status,
 };
 
 static int vcn_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
@@ -2058,6 +2116,13 @@ static int vcn_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
 	if (r)
 		return r;
 
+	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
+		adev->vcn.inst->ras_poison_irq.funcs) {
+		r = amdgpu_irq_get(adev, &adev->vcn.inst->ras_poison_irq, 0);
+		if (r)
+			goto late_fini;
+	}
+
 	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__VCN,
 				&vcn_v4_0_3_aca_info, NULL);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h
index 03572a1d0c9c..aeab89853a92 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h
@@ -24,6 +24,12 @@
 #ifndef __VCN_V4_0_3_H__
 #define __VCN_V4_0_3_H__
 
+enum amdgpu_vcn_v4_0_3_sub_block {
+	AMDGPU_VCN_V4_0_3_VCPU_VCODEC = 0,
+
+	AMDGPU_VCN_V4_0_3_MAX_SUB_BLOCK,
+};
+
 extern const struct amdgpu_ip_block_version vcn_v4_0_3_ip_block;
 
 void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-- 
2.25.1

