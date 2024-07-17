Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175CCC3DA62
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FC610E431;
	Wed, 17 Jul 2024 20:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pSMqhmJB";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AA110E431
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftLm+Klnh7zVQ7xw5lxak7JDTzj813TSY4HUPV5Qihb6Mh5tnIMzXlH84nJOzbr08bnOACrHJeYhYXhONtVOcy4AkfdFUumNb2F6KMhN5DjSa4Vd3svubxFjLGrNk8t22M83H1bHS/v4NTwX02S4708cYK+ybDh0HbzduxpBV4H0iRiZ8/FHW8WB0LhXWY539IwnQ4szzlwkQ549GG9P5z6LYZAYjIKhYFexi1Y5rUnIJiVHsX1oF6BK0uSSN70vfAQWQ3/6cNUbtcAWDJ7ksEk3zXuxTC9Uy3YX+qyOhHY0O5cM6b+LdESyTLhOHsBy91apC4UwL/TOl6oDCycWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+G3pyKc5QjJaEMbvTd6Itb96mT6uCJEzeT82h0dviac=;
 b=qXr77ffpwBHE4VsvV5mMiZ5e1/wewBdK4EBNP4YDZqD7r0klUM5+OVz2EqaxHDzqKJotv6auvp68sl45Q3MHMNpCDjJ5yGR/pbVWPe4YVYWqw15dTKJRK97bZV7NZ2QibjCgTIuBmQp3g2ELVENV56NQ8eqwzgx7lAA3RU6CGNBa+TDAvYZeSoJi2y34BxaDCzp6vjiTscfhRwMjKpkypXOA8a4jbE8N0EVihBvV8auKbFDnpb8GQrCqAuBPsQxw29PkYJClDgqPXUj7pqrgt4++WsIFxxLrT7mIwHJzTxERpGCgKfxdRNAtAER9stwgzHfwJIsnGMVBAxaJhGvkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G3pyKc5QjJaEMbvTd6Itb96mT6uCJEzeT82h0dviac=;
 b=pSMqhmJB3k/A9F91zmcuAKaei2MHKrusHTJFq1sFGMh0j0z5EXHh646XSkiJVGQiXVNr+w7dr8g0oLVpT5RjeTgEV1wOjryGA4FJ0UhrgOoNAdA1gFXP98Qu8b7Lt4dALk4A7ttHC+WXjoKljnCC65ZgnMKaN8OqeJ3tQu7GihA=
Received: from BL0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:2d::27)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 20:40:33 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::1e) by BL0PR03CA0014.outlook.office365.com
 (2603:10b6:208:2d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Wed, 17 Jul 2024 20:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:40:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:40:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jesse Zhang <jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu/gfx12: Enable bad opcode interrupt
Date: Wed, 17 Jul 2024 16:40:09 -0400
Message-ID: <20240717204011.15342-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717204011.15342-1-alexander.deucher@amd.com>
References: <20240717204011.15342-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: e501ad55-1b50-4477-e756-08dca6a0b45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XaXpZ8IXfqDrid52VZy6Ja9hoPSucDAXqHeMqVgEEzjCR14CzAJHFxehVPMl?=
 =?us-ascii?Q?mV3Bqw6Uog6wLIrjKwS1ulhZ10o+8+aZUfb2VOFYNLeDXfgFI/cRbkG51JYv?=
 =?us-ascii?Q?teKEmgny+D9xrVUOVUp4K7iPbdmZkkow9LXfqEJot+qH/0oqrZbhiNcNm9rf?=
 =?us-ascii?Q?CJnELmw8M10sgypRtG9Ptf/MtMgU7dI6VX8sQQ1Da0YYuUnqTrKvDJx4eYRk?=
 =?us-ascii?Q?80YESkmBzgeFmfN4+jIwbr4vHz3XeP8Q2JssgWi7/JTcSESaepODe5xzLNTR?=
 =?us-ascii?Q?hHKE3bnL7EmLPhZnosv+tRdkqroOmRFkIkRVBHmbUTWm1e6y09tdpIUjtsKk?=
 =?us-ascii?Q?upEKnJn+hosDlDijxnwQut2oXwCh8gkPxyIbhYTV8FvTS4WXDFT6IyrqKc0J?=
 =?us-ascii?Q?rP4Is5cdOkG0aa3+X3vCdb/Y09KXj0EuiVBs43sNaISNR/9dnKODKJ6iHYi3?=
 =?us-ascii?Q?gAf01hUrXMRTWqcfJiy9rl5copkYE/P4Pt/hCzAYxgLi3H3oYCtqwMALSkx2?=
 =?us-ascii?Q?j9Woey5xzadPK38JLzBl1zrubaJwNe2pZohoXLrL9O98exPtq68sdaXVNjQd?=
 =?us-ascii?Q?rfTlTJbzjhnOn31gckzZIue7ePw4gFM+ha5+2pfUaHhgLSS2GrvIKMc8whBa?=
 =?us-ascii?Q?vzIf1JdUFXxQz4ysQuIiyWoV5NOVPYSQ+nSSaghcoIwE6q2zG1y3E2oiI4xV?=
 =?us-ascii?Q?Jnr9zIcSmuRu1HUemF5QDvJAymWBvgn+VYC2LMzYiXqDsFxcjafEsNS3mkur?=
 =?us-ascii?Q?BHM1ukQNGfsKELVQRqVGBtwzIN+DiC3u86Dpri1129aphNIX9U1Uqc2dvmTy?=
 =?us-ascii?Q?4i1cbcN6Pez77Fy5ZcFxmWGBnoy1mevA4bo/2Ce++AjRbyY47s0ryN8ypgHb?=
 =?us-ascii?Q?Cj8WH8F4g/ZWCV/ldmm59PFDbQScOeoAUbpKImkLqBP3dNfrfn9y7R7juVV1?=
 =?us-ascii?Q?+r+HK2oE58mdo/8ceFVPlvbt7b6w67r0XLw809N1lsLSI+ot7YDw94YxjNSO?=
 =?us-ascii?Q?00gEyeA8N8wbXvLntntfHfOl9niKlVUBj4uqD1pl4RxftO6kQueqZaEOnphj?=
 =?us-ascii?Q?cYHY2zVdhm8zJC3tZxmNxMXcvDyNS4uiGJvPYKg9r8pqkZv4KFoQmN/44DR6?=
 =?us-ascii?Q?qbqloaKI/7pFQQ3/9Z9+uAxtFOW/dqJakQSzcoZHRORjrjixMfPQIXcK9IsX?=
 =?us-ascii?Q?rTEVsw+QX7V8HlbyeAL89copB0nkggPImww3qzDlTMmkrmi+K3iCAzeszhK4?=
 =?us-ascii?Q?cUwBQxp4rYZjXKHFaJZS+zeC3lG2CTLXzxli0hPP7bSztjRcnQLvCpj2TKjP?=
 =?us-ascii?Q?pRjVkIovk1s1xKZWq4Xmcu0JR7zgDiXt0TAdx0SoMPDUMy/51IuBrzMUDGpF?=
 =?us-ascii?Q?nYn32/a2vKZBncW89YmHP2JgZhkKTBwq8WH3yNFYLUR1PY+2PSjH3ysLo5TK?=
 =?us-ascii?Q?OXO9OddkYAXV5pRG1wEyRwE4zbO+ZpDj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:40:32.9952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e501ad55-1b50-4477-e756-08dca6a0b45c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095
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

From: Jesse Zhang <jesse.zhang@amd.com>

For the bad opcode case, it will cause CP/ME hang.
The firmware will prevent the ME side from hanging by raising a bad opcode interrupt.
And the driver needs to perform a vmid reset when receiving the interrupt.

v2: update irq naming (drop priv) (Alex)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 74 ++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index c74c8a60a23a..63b073fd4dc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1349,6 +1349,13 @@ static int gfx_v12_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* Bad opcode Event */
+	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
+			      GFX_11_0_0__SRCID__CP_BAD_OPCODE_ERROR,
+			      &adev->gfx.bad_op_irq);
+	if (r)
+		return r;
+
 	/* Privileged reg */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
 			      GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,
@@ -3592,6 +3599,7 @@ static int gfx_v12_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
@@ -3712,6 +3720,10 @@ static int gfx_v12_0_late_init(void *handle)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -4831,6 +4843,51 @@ static int gfx_v12_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v12_0_set_bad_op_fault_state(struct amdgpu_device *adev,
+					    struct amdgpu_irq_src *source,
+					    unsigned type,
+					    enum amdgpu_interrupt_state state)
+{
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i , j;
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+	case AMDGPU_IRQ_STATE_ENABLE:
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+				cp_int_cntl_reg = gfx_v12_0_get_cpg_int_cntl(adev, i, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+								    OPCODE_ERROR_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				/* MECs start at 1 */
+				cp_int_cntl_reg = gfx_v12_0_get_cpc_int_cntl(adev, i + 1, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+								    OPCODE_ERROR_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					       struct amdgpu_irq_src *source,
 					       unsigned int type,
@@ -4907,6 +4964,15 @@ static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v12_0_bad_op_irq(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				struct amdgpu_iv_entry *entry)
+{
+	DRM_ERROR("Illegal opcode in command stream \n");
+	gfx_v12_0_handle_priv_fault(adev, entry);
+	return 0;
+}
+
 static int gfx_v12_0_priv_inst_irq(struct amdgpu_device *adev,
 				   struct amdgpu_irq_src *source,
 				   struct amdgpu_iv_entry *entry)
@@ -5219,6 +5285,11 @@ static const struct amdgpu_irq_src_funcs gfx_v12_0_priv_reg_irq_funcs = {
 	.process = gfx_v12_0_priv_reg_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v12_0_bad_op_irq_funcs = {
+	.set = gfx_v12_0_set_bad_op_fault_state,
+	.process = gfx_v12_0_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v12_0_priv_inst_irq_funcs = {
 	.set = gfx_v12_0_set_priv_inst_fault_state,
 	.process = gfx_v12_0_priv_inst_irq,
@@ -5232,6 +5303,9 @@ static void gfx_v12_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v12_0_priv_reg_irq_funcs;
 
+	adev->gfx.bad_op_irq.num_types = 1;
+	adev->gfx.bad_op_irq.funcs = &gfx_v12_0_bad_op_irq_funcs;
+
 	adev->gfx.priv_inst_irq.num_types = 1;
 	adev->gfx.priv_inst_irq.funcs = &gfx_v12_0_priv_inst_irq_funcs;
 }
-- 
2.45.2

