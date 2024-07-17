Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EA8C3DA62
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D059710E41C;
	Wed, 17 Jul 2024 20:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Sd5DpCD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B75F210E42B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+kt9Upqa+9ISvJC878gygOkwCGoQS7GIIwVZWjdXmYgCOIKK2uPOwraiLgfg2ZBSxdvkikl6u2vQxsJ7mTLAP565iQOtp2d11/4m1YgBIv5A+PlrT5KbbyUJLRXKmH6imm1H1PEhCSJxtOyG0dh70TxwRvwU7rtHUr6oNxLmNz5yjAf7tYAojDHlHPzIFcTqWvZNw7Fv4WB0VKFOYvxXOXLik+lNI2dlP60Jdam6DS1pZj2n0MOn/Kb7A5rjaSUdyDjQrdxaq1WgjpLO01mkvQLbNJIHxZM0zjtWSC10t6lo8Ssf1pvgsg0lHSFsXir0abbDxXZrHzQWJbNDwSDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag06b65fI3kXXO8jG9PnXLF3br8m6trPDcw+6gWdzCM=;
 b=GeY2hgkkmE4S3DCLwYeTChtw+NG9P8gOvHwDQrS3LOcbYypOXy8EfJExz7T4pVH2ucktjiTjGkpjsV0GN5sofxnWFKT9WcfM3EKRpctKK3bA8OpcUCKSDQy5rfAfTmokW6kK0we/at80ZJzUZw5CR5+kpasqu7t22fkVlZg3R+rjAsGBUGQMpveMeuQ2bcVZfaZkeXYmln1oXhVo4eJD4Bb4Ch1TLB1ocdg6bkQAL+L1K/pR31iyXDJTUF9OSu3yoOo6FdVCrjR0WKO7/j4bBxEch4fXbWAmdlC4FmobF12r24vn18xhO6B+jD9v1iwjAHgjsABDoD4sfa/ys197fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag06b65fI3kXXO8jG9PnXLF3br8m6trPDcw+6gWdzCM=;
 b=5Sd5DpCDMDES8o8xU1/ICYL0yYwdRP31yE8/r+oNqvOupXymKpKkCeaemU2opuEsRmua/HQn4qRXlpyUzSwDZYn8ARo89wUBQlYA4hRHP6X/e4/D5lUh1uCLy2iAkRvmwZb1jc9tv98evPWowgoIWtX2ldzng8ECggqf4eTtko0=
Received: from BL0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:2d::34)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:40:32 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::6e) by BL0PR03CA0021.outlook.office365.com
 (2603:10b6:208:2d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 20:40:32 +0000
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
 2024 15:40:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jesse Zhang <jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/gfx10: Enable bad opcode interrupt
Date: Wed, 17 Jul 2024 16:40:08 -0400
Message-ID: <20240717204011.15342-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb992e0-6d0d-477f-d5cc-08dca6a0b42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OBbePH9LmzNWC6zWLd2+YGeSfYiA2T5xFaVLd22+1pCwiA5Jy5TMURRpvppy?=
 =?us-ascii?Q?PZJOdXlApZSQYCUcjYAi/O9oggXKBiELkVBA+jHr//JNOpZUua8YCAJiOTRA?=
 =?us-ascii?Q?m9DOV+o+bSB3LNhKcpbrtERnKnr51xpaFHiF2t2z49nq6sHvQI0psYX0c2wx?=
 =?us-ascii?Q?S1XavrAfrcka7Nefh/VUw3VHZcHCwjWwpLqQQd2EX+NXWk86cmLqkC5UB2Pb?=
 =?us-ascii?Q?QTcyMk0uDHsGXZYxxoyIqf8NuNKLwnBxbM+hdMebaDWftffG9BeBh6ZgaJzZ?=
 =?us-ascii?Q?b7zxlJDLzP6coWWEE8+D50jz1aHpiuBxpgP/ROp+7Vy1oXZ48ThJS1CENtB5?=
 =?us-ascii?Q?9wj16h/2yLVnC3IEq+LPSsa3ks7I+nzwy7s3DdXN6yjv3hZEaLwdsogRCzv1?=
 =?us-ascii?Q?YQia7/dEshbnDBhmS/i3cnqSy2jP8ksvS/GVqdV0VmyrMQqbjjatPsN1PEqm?=
 =?us-ascii?Q?EVNfeLbXtwDD/0oCi4d4NzgV+NHIdkf1oMpFdksdeoGSZ/i8OozH+xfGbKdC?=
 =?us-ascii?Q?NxjFWH1fYgDspnldsjkHxTgyBz8ALRcrb1P0MASppJhZcWu35UXYFuj8AkpH?=
 =?us-ascii?Q?ybNuxztSUzx5EIEqcOo8ZPOAfjsnF9vnLpgOE4/z13wFGnvnyI7PXDt/Rf5V?=
 =?us-ascii?Q?vdnikmqdnx+Q83SzreM9lzcZI8vWhAW3a4BzkFsgpGgfk7EIMC8xNzy/KtRW?=
 =?us-ascii?Q?lfnPVBwMnbSrt7CqtkBys32RovhCfIYTh07VqVIwUUZgmtFwL8hAGmGsZ2s/?=
 =?us-ascii?Q?ORM6IIG5cDtjwMZpOqkkMWmlWLNnKmbJqAhOjPVZtLaQiNrVTxeibmsXgbqk?=
 =?us-ascii?Q?14K3RLBSThOS8af+UQXFYtzq647QKvATcYHqlYv8XpPLDEHYXsz30ubHO9B1?=
 =?us-ascii?Q?2Y+EhLpFTkobSa2bl4KVdPAzWiIc5fjucm6buU79jfZFwgGrBEosw303mL01?=
 =?us-ascii?Q?pQImXlLAAbcF1VVdXd78+u13wp9f3rLu+GgqjVaFLzgwclrOPcGjKcMNzNNd?=
 =?us-ascii?Q?LXMXfuwRaugNpHyegH9gYMliRJg2h0x2WuAxaXQNLbPUoYZqnqhQ3QLjtO4i?=
 =?us-ascii?Q?TEPhhzk8ehsT14hAGZeYp1EtMAEoVhGlcm2uxxZerEJyDyK6TvTJ0HExEeHn?=
 =?us-ascii?Q?qABEYJTr0mAxz1wY37KRMG3puu84mNVA9DLdvTIo/dRa7H/SYjiagCDJGqx2?=
 =?us-ascii?Q?Iv4mYdNW45a+nplJp+dkzVhHlip/j9GjOZVjmjZnGIiKg7W9Id/SkgKtNXWl?=
 =?us-ascii?Q?M3rgNV5olePqFi76/Fb+Dp6YadTCNL2c2jTWQ406g2+nG00mVyXwWG/JZYJy?=
 =?us-ascii?Q?xxu1V9RVozSDNLh+FpZXGnIgelbvSDJ4JjfHOGydA0FVfqKCneXRK3bPSGsC?=
 =?us-ascii?Q?F4sh3sVpi4IcJhyrdM9DBy8EiQQVxtCb7TkeSa5MrrPO+0B2GwfeFXUwTLiD?=
 =?us-ascii?Q?xMNEyCTkKsZql8d4l01nfUyi0ypKas0q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:40:32.6670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb992e0-6d0d-477f-d5cc-08dca6a0b42a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 74 ++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 66d80f3dc661..4ce13a4f7a20 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4740,6 +4740,13 @@ static int gfx_v10_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* Bad opcode Event */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
+			      GFX_10_1__SRCID__CP_BAD_OPCODE_ERROR,
+			      &adev->gfx.bad_op_irq);
+	if (r)
+		return r;
+
 	/* Privileged reg */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_10_1__SRCID__CP_PRIV_REG_FAULT,
 			      &adev->gfx.priv_reg_irq);
@@ -7416,6 +7423,7 @@ static int gfx_v10_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 
 	/* WA added for Vangogh asic fixing the SMU suspend failure
 	 * It needs to set power gating again during gfxoff control
@@ -7726,6 +7734,10 @@ static int gfx_v10_0_late_init(void *handle)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -9162,6 +9174,51 @@ static int gfx_v10_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v10_0_set_bad_op_fault_state(struct amdgpu_device *adev,
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
+				cp_int_cntl_reg = gfx_v10_0_get_cpg_int_cntl(adev, i, j);
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
+				cp_int_cntl_reg = gfx_v10_0_get_cpc_int_cntl(adev, i + 1, j);
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
 static int gfx_v10_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					       struct amdgpu_irq_src *source,
 					       unsigned int type,
@@ -9237,6 +9294,15 @@ static int gfx_v10_0_priv_reg_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v10_0_bad_op_irq(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				struct amdgpu_iv_entry *entry)
+{
+	DRM_ERROR("Illegal opcode in command stream \n");
+	gfx_v10_0_handle_priv_fault(adev, entry);
+	return 0;
+}
+
 static int gfx_v10_0_priv_inst_irq(struct amdgpu_device *adev,
 				   struct amdgpu_irq_src *source,
 				   struct amdgpu_iv_entry *entry)
@@ -9624,6 +9690,11 @@ static const struct amdgpu_irq_src_funcs gfx_v10_0_priv_reg_irq_funcs = {
 	.process = gfx_v10_0_priv_reg_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v10_0_bad_op_irq_funcs = {
+	.set = gfx_v10_0_set_bad_op_fault_state,
+	.process = gfx_v10_0_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v10_0_priv_inst_irq_funcs = {
 	.set = gfx_v10_0_set_priv_inst_fault_state,
 	.process = gfx_v10_0_priv_inst_irq,
@@ -9645,6 +9716,9 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v10_0_priv_reg_irq_funcs;
 
+	adev->gfx.bad_op_irq.num_types = 1;
+	adev->gfx.bad_op_irq.funcs = &gfx_v10_0_bad_op_irq_funcs;
+
 	adev->gfx.priv_inst_irq.num_types = 1;
 	adev->gfx.priv_inst_irq.funcs = &gfx_v10_0_priv_inst_irq_funcs;
 }
-- 
2.45.2

