Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F2CC3DA5D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9038110E42B;
	Wed, 17 Jul 2024 20:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FzUvCMG6";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3702110E41C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6XM7lTSpf8M8vW3YVwZ2trfFY1+zB0/ozMH/VvQDfAqVidT5Z25mm7kN2yUPeJvuckAHeYgmX9vB+JSkpf6gtJU7aC4eJ78q8JQry5AnEmGNGzJiAA0BaarWRaBl8HLG7GjdyzIyWXBAVjMIcAbXfZS6YH4/Jq+QXCXtn9YHbEHweJra2qmtDQx+i6NFW79hRjxAqldOowgK3v1dRNEPfvgUTYRPLqakiET3NPedtrJyjvEaeMVz85jB/JUg7aun1c2Cysq+0zY81H8Daui8Beh9zllVSpB09oQeMUE/YGJScySJTorfn5Bm8fyl2i4W5kHfTBstJe1EEepS5Y02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH/oqajvTKKWMSySWWNYI/ydRBWevrN6BS20CeoEciE=;
 b=YEt5Afh5UpsZHhOrAqI15QFY5e/lgXq4gyoZ4k6gUoV2zOxN+y/JLUkKnXwDD3Mag5Mui5EYBtOU68uNDjq6EGOnf6b0Po+8WKB1qHjoUgJktDUZBiBuco/bfCnBMmfxx0WrpdsTgeyKechtd5wgX6IsTGsiwgXRh4iYCEW7ElNEGKojFX04UFpsECxWaM12R5IvQzEtt1aYnhvzj+36TiNcCKs6AQqS9m8BkiWrKZ1gaAvrgPwfhCQuIolH9yDsTzX/3b7PSxR7qQlz0B6S2It/wZ1EL44IS7InyWpYmSmv9Kqe5PAnAz8yifich0jBjZ94wjfXhShjb5Rh8hEo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH/oqajvTKKWMSySWWNYI/ydRBWevrN6BS20CeoEciE=;
 b=FzUvCMG6KmZTnVG0A6tuMyMweiu85kVore+qqtlmAId9MVQmAINQ4doMkWeRGVG5uuDJqATmt4JiOckKv1pFwSieYqoPyyZ/MActVOwC0U01aKeYSnY+RWo9RDcfEnYgurm+UEJ7VT1wMxOWB3DPfqZXqrYvOSoyYPqHvaDwOBQ=
Received: from BL0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:2d::40)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:40:34 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::b6) by BL0PR03CA0027.outlook.office365.com
 (2603:10b6:208:2d::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
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
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:40:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:40:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/gfx9: Enable bad opcode interrupt
Date: Wed, 17 Jul 2024 16:40:10 -0400
Message-ID: <20240717204011.15342-5-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 9371fab7-9c31-4484-4541-08dca6a0b4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TtCRJ/uNrHXj7uwPOCkMAF3iOPtKpuQ2CHxUIZFv/HV7B8V++eznyemNvECh?=
 =?us-ascii?Q?/n19qIdlja8G8xtaQkj/avdHATRcyFm4ETqrp6dFb+1067988jVYf8DZgBJE?=
 =?us-ascii?Q?AYM3x/niQ8NbMHUxfUTnE+O1mCrjLcMp78FeXzHExQC3zQGer8hmuv5NaT8d?=
 =?us-ascii?Q?orQtEYIE2oH49WdB9lMu9d0aYR1vzTzp1DAEmyV54WY3KgdMOiuVfs4wp1jj?=
 =?us-ascii?Q?w3+ZhvxZRpk7zpmUK4WCKFJuC4voBiK9Yi9fFZoP44FuXwYdr0orH9dz2eMw?=
 =?us-ascii?Q?z7oeImc7Z+oCFp9DZfSBNDysgEzi0Ix+wCt232YneaXIhg5HK+fTOWwXamdb?=
 =?us-ascii?Q?kbgjC481dhkNrf11H3O8gqsMxfkErXCJR1qBoO9KXuMWc9JqGGWamOCvKjd+?=
 =?us-ascii?Q?FPLlKqtOtENlvEJrt0l9MmhDsqvK3DpU9QPWlpR+8yiDOU/l6GZ0bBGIsReE?=
 =?us-ascii?Q?+bFfxXsybcSDm0HCINZCLVvNomIgX6GZZ0I6MYeRpn31j15cREuy2x8yAyFw?=
 =?us-ascii?Q?gPq0ivbuEI1U9Hx6nDfzkCuIuaNY9S8nn2i53yM8fOqRQdo7tNUVEttFvVjR?=
 =?us-ascii?Q?8ZOe008auxfwjuF2d3XWXetrcqS/Wg+8iDcPU5dsMtGctboxCZFGQdLFNoll?=
 =?us-ascii?Q?cIxyuyDLy4MYW5BSFRjc09ijXmpdaH0W+JrCcyctH+2gK/acGfHwoqlNAEEw?=
 =?us-ascii?Q?4rlNIV1JoYAEM2YMEQi+7ZAAxAYj5VRWe1cMN93oX+R7NqNDKwI29hmEJv5O?=
 =?us-ascii?Q?+MqM63OIjh3eYfLsC47yzq1xtwO/laM3sfK51a6d6KjgUc07xF+BmVvw+TUu?=
 =?us-ascii?Q?SQk2WeX1qtdIZ8T7MbUUXVulw78em5hwlTnY3I+vfmF7Ji310jzOf+vwKPmd?=
 =?us-ascii?Q?v8ZDwmJzr1Jl/Zw9OMJdJe9n3T2099KWnw+Up8JkwD2mn+O4z31mUCehep/B?=
 =?us-ascii?Q?azEuv/bjosQdeq6SBhDAy5XCxrIwRPi9JKnRIXVv0JWOsJiT7kMloT4wml9k?=
 =?us-ascii?Q?pXMOo6mEMYP0xm2MSrMFFToFc+Ck2keSGlYtWlBcoV9+A1K4FpbRkLPip8/n?=
 =?us-ascii?Q?NqYjtV5rmoWMOGCjxbdnmeYehGNe+GmqQIGKG1m5yhVqvVWTMnAi8G7jT1/J?=
 =?us-ascii?Q?mBflz46yyPlxS+8bQcZB5D5ho3BQ/RoseAIcmp6Zvlo99VIcrbPS0+n+mTSq?=
 =?us-ascii?Q?67KjeIJJz3sZOgjT5mQhiGGlI04BjsHhKbzhlxw9Ene4Cw8AnM1kmFq8gxUl?=
 =?us-ascii?Q?DDwuBYiAO7rHxzT+mzVLkf0ZkpCAvPPwS+gpolFRrh1zkhBCJbVqAV5xhozD?=
 =?us-ascii?Q?evqgSt+Wks8llYLmDKdaul4l0tlmvoA7RW0jBX/jTNrUvcTIn6G9ciwPbi/i?=
 =?us-ascii?Q?h5lE93Tfz+sujMY8OpEp6btQF0zd+pz9kPeVeP9fQdx8nB5QBY8iVy5L7p64?=
 =?us-ascii?Q?3A/ZQVzB2mYqMfuQiLzzW/x4C9e9aJ92?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:40:33.6358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9371fab7-9c31-4484-4541-08dca6a0b4bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659
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

For the bad opcode case, it will cause CP/ME hang.
The firmware will prevent the ME side from hanging by raising a bad opcode interrupt.
And the driver needs to perform a vmid reset when receiving the interrupt.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 97476fb2ca40..675a1a8e2515 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2182,6 +2182,13 @@ static int gfx_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* Bad opcode Event */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
+			      GFX_9_0__SRCID__CP_BAD_OPCODE_ERROR,
+			      &adev->gfx.bad_op_irq);
+	if (r)
+		return r;
+
 	/* Privileged reg */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_PRIV_REG_FAULT,
 			      &adev->gfx.priv_reg_irq);
@@ -3937,6 +3944,7 @@ static int gfx_v9_0_hw_fini(void *handle)
 		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 
 	/* DF freeze and kcq disable will fail */
 	if (!amdgpu_ras_intr_triggered())
@@ -4747,6 +4755,10 @@ static int gfx_v9_0_late_init(void *handle)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+	if (r)
+		return r;
+
 	r = gfx_v9_0_ecc_late_init(handle);
 	if (r)
 		return r;
@@ -5990,6 +6002,42 @@ static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v9_0_set_bad_op_fault_state(struct amdgpu_device *adev,
+					   struct amdgpu_irq_src *source,
+					   unsigned type,
+					   enum amdgpu_interrupt_state state)
+{
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+	case AMDGPU_IRQ_STATE_ENABLE:
+		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
+			       OPCODE_ERROR_INT_ENABLE,
+			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				/* MECs start at 1 */
+				cp_int_cntl_reg = gfx_v9_0_get_cpc_int_cntl(adev, i + 1, j);
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
+
+	return 0;
+}
+
 static int gfx_v9_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      unsigned type,
@@ -6163,6 +6211,15 @@ static int gfx_v9_0_priv_reg_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v9_0_bad_op_irq(struct amdgpu_device *adev,
+			       struct amdgpu_irq_src *source,
+			       struct amdgpu_iv_entry *entry)
+{
+	DRM_ERROR("Illegal opcode in command stream\n");
+	gfx_v9_0_fault(adev, entry);
+	return 0;
+}
+
 static int gfx_v9_0_priv_inst_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
@@ -7346,6 +7403,11 @@ static const struct amdgpu_irq_src_funcs gfx_v9_0_priv_reg_irq_funcs = {
 	.process = gfx_v9_0_priv_reg_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v9_0_bad_op_irq_funcs = {
+	.set = gfx_v9_0_set_bad_op_fault_state,
+	.process = gfx_v9_0_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v9_0_priv_inst_irq_funcs = {
 	.set = gfx_v9_0_set_priv_inst_fault_state,
 	.process = gfx_v9_0_priv_inst_irq,
@@ -7365,6 +7427,9 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v9_0_priv_reg_irq_funcs;
 
+	adev->gfx.bad_op_irq.num_types = 1;
+	adev->gfx.bad_op_irq.funcs = &gfx_v9_0_bad_op_irq_funcs;
+
 	adev->gfx.priv_inst_irq.num_types = 1;
 	adev->gfx.priv_inst_irq.funcs = &gfx_v9_0_priv_inst_irq_funcs;
 
-- 
2.45.2

