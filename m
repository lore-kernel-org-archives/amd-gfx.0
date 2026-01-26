Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8CAD19518
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E98810E218;
	Mon, 26 Jan 2026 20:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g+zIf5As";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C4E10E218
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qF1DgS87z2FjX+qo4fFUFt2awdxnOuQT1As7ivNgoty3a7+lOnitIeZkSf+PIczj2lV9q1+XFC5YWMyd3suFQ5n3VeqjjhUuvTZjNbE5ArGg5kGUvlrDU78vB5zWy/Kn+qbPU4n5hJp6yFwHCBS9HOU4c/gH1y+oUVwoJPiokY8HBMDFw/faUf+uvkqyy6nhSnw6mLfev109mAmWfzCvL3mtsWzG2+CYCkFxzmoPe7CdQ3+eu8Cgx6XBHmm305CZrkMHpYS1Uc7Bbgj7AVWZ80gte9/tpOovlJvTwhZ7pDZ496wulTQpjmAeRr44mx+MsMB/bJqVe4OSNu34v3AHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au4PozrB5bvqoz7IWm8GZkaX3Is7/zHsUWdBMN3Jipw=;
 b=JU/j1XuCivbcxZMLymNsNIMkGpMskBMnUd+RNlqKaiu0rSMP+FxiXMFLP0DaMec5wmvU/Rnx78a5uQZScc+tAdhF3Ov/8oFYI/xLp5u34Xh3fzLBHbpUxjMPf/FHYz8Qiw9aruaxe06bb2AXtapz2nAGAdEhXRscPoy1UZub+cilJRTZixK1TRERQGmzjBH4ROrP3I1a2978gF8Cpkz+AWE6YLYxosL0RIaoS7OLZuBnzHCtvx01kM++fkGga2mcNGNxTSdqIXyADVk+4P7HzqEREcRR7DeqFkAvAdqMquG1IeoIsmTbAfxBcu8D4AOrhyC3PxpaTaPfQZBabRJIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au4PozrB5bvqoz7IWm8GZkaX3Is7/zHsUWdBMN3Jipw=;
 b=g+zIf5AsGiLQqCphnFkjuwsueLZ++OdTJn2r24kE9YcKx0i4fuD+yOc7UCmy0CjAVkBNV8dNZQmWYyHOffCZXZyaAbW+U1/9QBd3Z+2DdSNM+lv/YdyBg7fK795uO0Regh8TMwDSIOGL4OkIczGNeLpoF6mmknX5CBJIkQKzpW0=
Received: from PH8P221CA0060.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::9)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 20:07:58 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::ff) by PH8P221CA0060.outlook.office365.com
 (2603:10b6:510:349::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 20:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 20:07:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 14:07:57 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 14:07:56 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 14:07:56 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 01/12] drm/amdgpu/gfx9: handle gfxoff in interrupt set
 functions
Date: Mon, 26 Jan 2026 15:07:36 -0500
Message-ID: <20260126200747.13527-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 44057d09-f6c7-4e93-4500-08de5d169950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8XSSK76KqIBDIqAqaOiX/IcVYOkpXjSswB/Jd5suUEY5mTC5Q1g4tIDUwrL8?=
 =?us-ascii?Q?x9tX0SPmbXy5ONtyq11sDh5Mva1QKtPUSDNV7VLpAbeHsAMnf1ifklWpN/Be?=
 =?us-ascii?Q?cyvfBQet61SKQ7oM+9QVM1i/YjFC/H2YFvWfeiN2QVmOfgrjdYtq7EPYUESt?=
 =?us-ascii?Q?b584ogiTpSSjVMIUdkhYjySGHF/53OjkYRGgUsQhP2/wiLwEQiv5tL3G5OBD?=
 =?us-ascii?Q?KKDtXWRhECGwVRO4WATkZNzOO6RsUK+ROAg+0sMys8ZE9bOqP761ugu+mlCs?=
 =?us-ascii?Q?nR+nwQujKtSZJJcJPjsiMl9UnMkftn26EM51tTKARvvqHbTe+EmRY0yp9MfD?=
 =?us-ascii?Q?TTEtUOVG9Qny8IucCm47AzsRLkc9KazxZytMZ7jswV2hUi6Xjg/cMFU8gv5g?=
 =?us-ascii?Q?q7VNqgKH61jMDcVBiCyVZ8Zju8QVUTFNBFDO0K1ZeipAQ0itsDm7oeEp65ks?=
 =?us-ascii?Q?eg5m8ayA9WE9uKq1CgwO+uTKLK7cUopj3exozIfpJnAcDg6cJi71P8drLtLu?=
 =?us-ascii?Q?kQLMUhjt3Xm5r4MFquA4CHVdnIp5GJHRSG6LtRwLwtEW35qOxdV8tYK2fecI?=
 =?us-ascii?Q?3cBfyIAI2fNFuqKEqFn24+ZK+0ZPJnykQYkASJUq/phZxE6PPmzd2M8K7H6l?=
 =?us-ascii?Q?29afRjo4eIA7BFep6nYwQ2O7j+bxed/YoY4DiIyt7nfWt/D60RkwQVmJhCHA?=
 =?us-ascii?Q?sueUeEvlG1ZSpZ1OrVmPiUBVaicJ+6FCcGTcJtQcBEM+heeDVt202VXkzX20?=
 =?us-ascii?Q?15o2wURwpQYphLm0I+V/MLkI4c9Ekpjxy+oyWO1pOcWzp3yvAPsdYp5ozl/A?=
 =?us-ascii?Q?OgRfPqYzhq0RwMzfdpVIYaLdCo2NfvNrQ5Qo11NPlAO/NILMwzh2Pvyg4/Ha?=
 =?us-ascii?Q?4l4+ezjTtvCCEe3IcDxctcfSE6ISeT6scmB9haMRJSKF0fDKB6Ul3OCtLbKI?=
 =?us-ascii?Q?D/tKu24Z5pLlzObAcnj44rM0pSFH/8Jr1VKb9voKEJf7C7S1Mvppnl1G/xrL?=
 =?us-ascii?Q?pk2qyepwG7tZf0oF0Qoj2scdwSBgRRcNGgy1FSsnp7KBja/fxXiKHxqeawsW?=
 =?us-ascii?Q?w49PLVHTRXG7e2BC2QEsCrbcXGVbOn8+b6CCX9zhOsnyQRp1OjC7A3w8mwIe?=
 =?us-ascii?Q?Y3FziZqwcfv4Wz/UYXRtkW5mxGmfubQZ25iz0d4DvjlnrgYHQNi9RTY4GNo7?=
 =?us-ascii?Q?lVm8v+Qh+YUvp4y9Y62pjObwCFDv1g2DISGq2w+raA+kZr/N+kTKTFVEPEXR?=
 =?us-ascii?Q?ZScbyneCbNdF0L9g7FZEzpNZ9GJhBlv7M0R0prO4+nxnaBgI7EtQwtQnK8Qu?=
 =?us-ascii?Q?GcEd5zgfnFu+lCzvWXl+fP3/uTjh7kM41hsC7yIxaAIOhrXO25Kf3yA4ml2p?=
 =?us-ascii?Q?9GCKrDnLXpBykGlc7ijwhNk3AHEJX9sME2ktS99k1yBApUy+w0MUSG3lPhGP?=
 =?us-ascii?Q?Cz4CpZiKj4APJOlpTZ6MU9QNJ3x3gYa2+91toadNkqSpeierEYN3nhZYiOqk?=
 =?us-ascii?Q?UN7i61Gf49IVB7dV1/TjIQkfVRUJhNkebqr253oU+PuS/YyvACkIMIH/xVYN?=
 =?us-ascii?Q?XbNI9j2uRnDPeW6fgwWH8nSLKL93Tg9wfX5YkCk7Sbzx2SOuuQUsOCruJFnU?=
 =?us-ascii?Q?IxOH5LrQEY+hgRAAgUf8VXuysS1AoqSYN6TcVUuNy+XUabwewmXTOYkv1nDk?=
 =?us-ascii?Q?1Wozow=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:07:57.5150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44057d09-f6c7-4e93-4500-08de5d169950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
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

Need to make sure gfxoff is disallowed when we touch GC
registers over MMIO.

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 36f0300a21bfa..05178ee8e0e3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6056,6 +6056,7 @@ static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	u32 cp_int_cntl_reg, cp_int_cntl;
 	int i, j;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -6080,6 +6081,7 @@ static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
@@ -6092,6 +6094,7 @@ static int gfx_v9_0_set_bad_op_fault_state(struct amdgpu_device *adev,
 	u32 cp_int_cntl_reg, cp_int_cntl;
 	int i, j;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -6116,6 +6119,7 @@ static int gfx_v9_0_set_bad_op_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
@@ -6125,6 +6129,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					      unsigned type,
 					      enum amdgpu_interrupt_state state)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -6135,6 +6140,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
@@ -6152,6 +6158,7 @@ static int gfx_v9_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
 					      unsigned type,
 					      enum amdgpu_interrupt_state state)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
@@ -6173,6 +6180,7 @@ static int gfx_v9_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
@@ -6183,6 +6191,7 @@ static int gfx_v9_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 					    unsigned type,
 					    enum amdgpu_interrupt_state state)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (type) {
 	case AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP:
 		gfx_v9_0_set_gfx_eop_interrupt_state(adev, state);
@@ -6214,6 +6223,7 @@ static int gfx_v9_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 	return 0;
 }
 
-- 
2.52.0

