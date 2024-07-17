Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43E1C3DA5D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C6210E433;
	Wed, 17 Jul 2024 20:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4N3vf2zY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA72B10E432
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw0VKrqSSDAajQ4IodpYb/ryLMOOCubG84Nc5nK4AGVY9tzBxlq4LNdbi+FudA1JMBykJVz3dLPb7HUU5o2gFbUdViCI+iNRpGqvaLerObgE65JE5zBmyjq5GPZ98U2NZ3jrpeaJwZ4cavCKMxnb2qhu+Mywpe6yZOR1W9VManVgHaTjK0ujQ8f6YZ1KyxTsHE9GNS86x7S25mlr/p0JUa/+kwHk1MbutpqrwN/JZdKB+CXbr8fvSFgReymtY4tAbXhmBMizKZB2Wm50R2+o12wAH9CeYHJXIOsYoN9ENPytMCCQwWCxuGn9Rg36i3gRknrAXOqCCrrulOj+bP/2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUkEsoIECmdLSoKA0pAyvhQ3RxwkJUykMtSFXXgQ+p0=;
 b=NWi6ox6kFanDzc6tgKS0vg/+g6UecM+xjZvJpUekmZ1+9S3w4ad3M4PqQN7JwqhnEq6aWNsjZEy69F3KzAi9w7PHdUAyH43YAzsRtQ4yBr+ThZJZJ8Zos9aj4qsowGFTjG+zKwjfgxUkkDMuwPEor5JcDqaLpUBdB7ZOsOySLOvTvwfb9Z1fzgQ4hn2YlGKmxr4sYEFs7Le9H1gfXQPKHpoRrUmfRUYhw4T32NBcgLG0XqwNo4C9GQ0pkCX3UYMCwEWnAXMpuywZyDIL5eWFfVCfLf6LgDcSKwLZZJPHDTa1zRpwTbKUTikNwilxjDxJ07Y0Mgewthf+pUkkdh3Aog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUkEsoIECmdLSoKA0pAyvhQ3RxwkJUykMtSFXXgQ+p0=;
 b=4N3vf2zYWKA3EepcYadxASEiaRYmTf3pP+lCuvx7KXylGBdK44Y8Xm54atMPYm21ARNe2jyL6IrTOoGMDt7q4SQOpdMUpX0itVdYZdMlIX2VxFQs6IhTerFr73u1iUA6+1hSoNnScvF/S0oAxGFmGavNRsubZUKifjSDQWgYQjc=
Received: from BL0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:208:2d::45)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 20:40:32 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::2a) by BL0PR03CA0032.outlook.office365.com
 (2603:10b6:208:2d::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
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
CC: Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/gfx11: Enable bad opcode interrupt
Date: Wed, 17 Jul 2024 16:40:07 -0400
Message-ID: <20240717204011.15342-2-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 21465bbb-d31d-4f28-26a7-08dca6a0b3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QW/EmQ79tUg9GJtS4+NHebwy1ZRkkA9B5oRVRJG1DjPmd8wNfD2HF8oZYpwM?=
 =?us-ascii?Q?cjCVkbrJLXhvgTNbKvuJAkOBpEyqKMvcZKX0pfK5nlA4P0LrvPVcaKG4ZcB8?=
 =?us-ascii?Q?FzpHMqxZ91dTesELF5txcimg25nzMu3+D5xdGjfXsuKsNLbRNezrc3dpxBAQ?=
 =?us-ascii?Q?73JguvZyYSV1jBCPUJf32+60YdQ1WGK3p6ZRZaEtLmJELb4KF8qM19n1jTCz?=
 =?us-ascii?Q?Sx9Rz/6q2qNaiV+d5KsUNYNWgROg/kGovKG6/uRkqMn0OF30s5jtwwMttdQ5?=
 =?us-ascii?Q?fTTwDV5CNohe05Z7MOpgbyIXkB/6wyRUOJiHw1BhBVNzGL2s7dMhEkHFiqww?=
 =?us-ascii?Q?frt3ZE8KTs2zzZfeladta+FWH8+Z825/cZwy1X8CsDzp83vmL8b4diNYTvTs?=
 =?us-ascii?Q?6y9EQ5kgb5AW2veAkv6FiZsuckwDITDDCsJ0y5SatdR2gq/qlhFx/TAcXJlV?=
 =?us-ascii?Q?4VGMYmwaJD6UY94SwJ1QD204cTwnzb7KiNd7Xwk4bOCviqGmmz8Db28l2t/A?=
 =?us-ascii?Q?BeNhNmWClYiO2++lyiN3vq+b7Ry7NZ85xMreuZpt1OheU+1cYy5Q9KGgCmlA?=
 =?us-ascii?Q?lXHUeL1ByLRdhayDHcM/psAqXtQkBW/XE3DuOfWdwkOVepbC/pzLmnV+nVyS?=
 =?us-ascii?Q?R+32RFbU+I7ol+P/Ig4mEEG2txWJu/SPBDP5r40R7BmDINNf7D7EVizNmRRw?=
 =?us-ascii?Q?VS2XSjxWfl1X5qHFjV4EEFih+PROWIuwMjM8w/2Lvhqw6GOdApfY9wQg/8rz?=
 =?us-ascii?Q?IvLmVEeWXyRhIRPLGGuff7if7cJ7Z2I9CcSbPYWYXbBrnKRLJmsv1vH5Dbhc?=
 =?us-ascii?Q?S10xD1kYtFE8/PYy8otmYg6uG5GP+CoZv1TOTj+Jhf7aMdj44nMvZqoTGx8D?=
 =?us-ascii?Q?Fx2EUKAyGF9PIF0aT2FBRSWBr7a8UWVYrQc4OTGKEHZTCs3XtB5lKpjdf4OY?=
 =?us-ascii?Q?2rFgway7LjX9/cKiQRwGARUFHpARMRT+6DzhPoeUSeG/AFmqh2vABHSQI05v?=
 =?us-ascii?Q?STmvBGn0RtW8yLd5mBaxL1a0cZ8nhWvYRqPchsNSYmzUQEHwwAaunWwigGux?=
 =?us-ascii?Q?P6VLSQS5/CgDw5S/xoR4TAb/WINwm0dh8SCmlkwijjHIGSvgmfjoxzu3T8lk?=
 =?us-ascii?Q?CpCkFLTjJ8BJa/jJPxqL7ZjxlhnxQcLNkSICFrw5mVpB8LXo/ahMpIhhZytV?=
 =?us-ascii?Q?Jj/1VsmXl5FZIeSYqfISm5jWjtvocPcMdVnG9RVwmL5Q8Kz2kC5ARGhiGaLx?=
 =?us-ascii?Q?MGCxSUdmzpbCVvRwFmuXRjfdr1otm8q+4380hBunBYvVMklAEB+uYZvU4yhF?=
 =?us-ascii?Q?F2jzxvtPtgjx8SrYJMdgifR44uRH9kggxB4r6i9Evdo4K/BHIRlrmkUJLvG0?=
 =?us-ascii?Q?a56V7QlxrUaQBYNucZJ8D146iKu1mbw9WcOmHqBMNZwGqvzLy6hkQDEIN5W8?=
 =?us-ascii?Q?lT/LbwOZ6dm5pqktcdxhlXcAJcdDsDcw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:40:32.3702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21465bbb-d31d-4f28-26a7-08dca6a0b3fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973
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

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 73 ++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 02efa475eb7e..ce5cb60b8628 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1569,6 +1569,13 @@ static int gfx_v11_0_sw_init(void *handle)
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
@@ -4646,6 +4653,7 @@ static int gfx_v11_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
@@ -5002,6 +5010,9 @@ static int gfx_v11_0_late_init(void *handle)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -6293,6 +6304,51 @@ static int gfx_v11_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v11_0_set_bad_op_fault_state(struct amdgpu_device *adev,
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
+				cp_int_cntl_reg = gfx_v11_0_get_cpg_int_cntl(adev, i, j);
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
+				cp_int_cntl_reg = gfx_v11_0_get_cpc_int_cntl(adev, i + 1, j);
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
 static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					       struct amdgpu_irq_src *source,
 					       unsigned int type,
@@ -6369,6 +6425,15 @@ static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v11_0_bad_op_irq(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				struct amdgpu_iv_entry *entry)
+{
+	DRM_ERROR("Illegal opcode in command stream \n");
+	gfx_v11_0_handle_priv_fault(adev, entry);
+	return 0;
+}
+
 static int gfx_v11_0_priv_inst_irq(struct amdgpu_device *adev,
 				   struct amdgpu_irq_src *source,
 				   struct amdgpu_iv_entry *entry)
@@ -6747,6 +6812,11 @@ static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_reg_irq_funcs = {
 	.process = gfx_v11_0_priv_reg_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v11_0_bad_op_irq_funcs = {
+	.set = gfx_v11_0_set_bad_op_fault_state,
+	.process = gfx_v11_0_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_funcs = {
 	.set = gfx_v11_0_set_priv_inst_fault_state,
 	.process = gfx_v11_0_priv_inst_irq,
@@ -6764,6 +6834,9 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v11_0_priv_reg_irq_funcs;
 
+	adev->gfx.bad_op_irq.num_types = 1;
+	adev->gfx.bad_op_irq.funcs = &gfx_v11_0_bad_op_irq_funcs;
+
 	adev->gfx.priv_inst_irq.num_types = 1;
 	adev->gfx.priv_inst_irq.funcs = &gfx_v11_0_priv_inst_irq_funcs;
 
-- 
2.45.2

