Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526F1C36010
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 15:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF2C410E917;
	Thu, 27 Mar 2025 15:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nNt5nURf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5F810E917
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 15:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEmTutD7mL5W/RiK2SHSC2Cr3cXLmICqHtAYw8V2gv0ocGxH5Wu2C3sN0Hi8+Iwvb5cGsUIH3Bn2ubi+bVHqgsJMRw4USLcC6bZp4sRHA4LtDYEli9+qgYno4ry5Dd/Cp/HCl+da/C8eN9ON9pz7I3//4C3De+n9uznFdC9nAQ07m42eQDLjeRWgMNlCNjjWI8IWA4/WnxuT9soKMP0tRxx+yDaxtJiRgHxgc/BFJ74Dxiba0+s4CsJKXi8xQVWhrxyXUnaRL92lTlrBEJuJTURdzg+sv8YtnLKGdflpQUXBch3Y8PkwF6s5ywBlwiClz+zB1jpmnBkq/814yruwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH9fZoVh9spmFMES2/7uHrH4xzNqvXJ4M8QUOQzxgik=;
 b=afGF4RzgGJwusPF3PeRN5zGYF+2q7WMtfoE507U62XyiKWJu5Wp4Qux3nRUT3Xu5jKNhPMiEvQmlNF6flK9yj2vjTaQG7Jtl4D5wLZCYRe7mOY7U6E7Uuyw0ySbK8puRZs3g18vUIIDNubbPogSK0DHMYQo0xTzmZ0WJDmfErEFwWr4PXgEq9BfRzG0APXRD6iyoS/N8VBD50bK6wo0I0WuKeEcBjtwXmAapl55kchX4AQnbXxRlzoMPJ2TD08fzXJgK21CAVbSqklDL+NBzcz/HObedX6ZmZCUEQjNYCGoFCth0B/Nw46bn7hD5hC1EbS+10n22RR+klx+cJT7OQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH9fZoVh9spmFMES2/7uHrH4xzNqvXJ4M8QUOQzxgik=;
 b=nNt5nURfa9L+jQQiEgoD2lmLVhtKuYZaL9/yINNevLVDWhbU7WjIYRnJDz+Yb7sTs5hlslCHHoco1biMOUXZJ3wkzeTsbzWdo50J6yOVHVJvgVn+o0OE7YYsyfEVMKCkjSxA7Pzu9iZ83TCKkQiB7pH2uzJDdw83jxeaE4iKKwY=
Received: from BL1PR13CA0346.namprd13.prod.outlook.com (2603:10b6:208:2c6::21)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 15:58:10 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::6b) by BL1PR13CA0346.outlook.office365.com
 (2603:10b6:208:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.27 via Frontend Transport; Thu,
 27 Mar 2025 15:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 15:58:10 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 10:58:09 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Ahmad.Rehman@amd.com>, <Jeffrey.Chan@amd.com>, <Zhigang.Luo@amd.com>,
 Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Add indirect L1_TLB_CNTL reg programming for VFs
Date: Thu, 27 Mar 2025 11:57:53 -0400
Message-ID: <20250327155753.252423-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ffdf08-e33f-4751-b2e1-08dd6d482c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TJjoUMIk8KsijgI7+RaGtY8UDzg6fLp99w3qlmTvRGGzff1aKmqn/O65Lqwe?=
 =?us-ascii?Q?b/w1BnWKL4w+gr2IrdaYf8Zr/WiK4hRQNddwh+4BoF6yoKoynyTfyuxqnqTo?=
 =?us-ascii?Q?6iPkdAdOSLW/+dVn3obEO1u3I1PsDxzMrUP6iZt31QAicRr+/DxVS9oF6wk5?=
 =?us-ascii?Q?IUMOvWGEohPnSGVgmKjnW2ErYUc7McXQhpMoW07B18giu9DVEkM7Vm6NI9MV?=
 =?us-ascii?Q?k8cfk2JML9YpPJlTE8r719B+Qpw/wNuL3zjDOodee4hFHtkowdNNzCAGxmlw?=
 =?us-ascii?Q?/oxkSF1a6j0rFKb8np3RTGqQ75W9WY8in57mmH+dRQc+p6Xn45b0d559m8cE?=
 =?us-ascii?Q?yFCYs+GC1mYbgHVcXX44UzLHbfqAPPiRdyQ56M7eVDQHAv2bGLf8DyEEbw6V?=
 =?us-ascii?Q?lKTjWROqORXp3gU9NH2BqcJxo42SpweYrvyX7GLMcKcWuxuHG/NFJ+W5HtBE?=
 =?us-ascii?Q?PV9KcavTWiT+PMdjYjwOjmcfozgtH1r6X3c9pfYYYw1ziJ1KOU1BRTI/VU0g?=
 =?us-ascii?Q?0t43JBGPYI7sL+y/KktpfIkmEEbZWKP6dGwLHfNdud2B6DRLCCljPRfYHoY6?=
 =?us-ascii?Q?L9CVcSNkOaG/DEzJWsFr8rXqIgzGwbNJ44LObIPOYJsYPUOYVK9YuaXkt8t8?=
 =?us-ascii?Q?blWS/s5P0haAsoEYKaLXsDqSEMQqJAAo3MLf5cL946bTg58ubTNxXbSiF3ac?=
 =?us-ascii?Q?O9zy+3VbQjcm8gPDod/8sB+8J1pfYSCcjFZrvGrE9xLUEwwlpL3GT7Y3N3aN?=
 =?us-ascii?Q?cnEppNYkpO6lAPpQhdlNZZwcY5VRxGW9gxTjyPPUkNKoSrf7MGaEL3sn3+hq?=
 =?us-ascii?Q?DRvCq/KrbVMKv1oGpXXIAxv39oJa3kJOh4ZWnIXgRKAO7L6YqPOhS1PYHRu9?=
 =?us-ascii?Q?voU9NbGTUjqvJbpYfo5mhoePhGJGgjL+0EeVu7MDW8BUvmM2XPVu78vMSpo+?=
 =?us-ascii?Q?KbqePLUzE5yL22WwvPEF1b0rtxUY0mH3oqWf+b/8v+W6EhSJA3w0T9zsZp/i?=
 =?us-ascii?Q?SDTqBLkCa2hzGTHaFozsEKfZZPU3mnb4+FbbOF+zK+eKtWWFTzEeZSqr/BlC?=
 =?us-ascii?Q?VRHlmRa44MgdMfn+mze4di3a0q70b2TXf5OA5XJZg8emnGivnbv060F7EhSY?=
 =?us-ascii?Q?Dl1ANYIPceuhAnwYt3JduoFrZmtpFoOi10t5creNKv5lVKTff8DRIn5aWOZE?=
 =?us-ascii?Q?FlSANJxD8RXMBTOtpesxKpTmtMT3mz7PHJ6V8VpQKkjscR+njThrwiq1vdgG?=
 =?us-ascii?Q?4QjcSOD2YVwexUE/G3s0CQ1XBoQDoocHUIpUdzVimT3J4LNF1IS8w7BTw4FL?=
 =?us-ascii?Q?Z/820t4oWZiZL4Dmcog2mN1IZBTfmqYgp+P3h6WWWE/NsuaV3rqh3lfpxrfA?=
 =?us-ascii?Q?5ih3b7D36tabhSNIHLtV4rGx0LKgELHyuVF1AfD/3lwxoZuxRKTVfhntO7rA?=
 =?us-ascii?Q?a68kzGOnRvG9Hrtj3UyJ8Hjr7jkLB6doFwKgIYoPoy/yGHLIDw4fHky6Oi+8?=
 =?us-ascii?Q?Rr9GqKQzA9/Oc+OqCdsm8AOypdr6qYfNm+jl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 15:58:10.2144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ffdf08-e33f-4751-b2e1-08dd6d482c2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
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

VFs on some IP verions are unable to access this register directly.

This register must be programmed before PSP ring is setup,
so use PSP VF mailbox directly.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     | 10 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    | 12 +++-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  9 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c     | 63 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      | 20 +++++++
 5 files changed, 93 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 8d5acc415d38..dcf5e8e0b9e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -107,6 +107,7 @@ enum psp_reg_prog_id {
 	PSP_REG_IH_RB_CNTL        = 0,  /* register IH_RB_CNTL */
 	PSP_REG_IH_RB_CNTL_RING1  = 1,  /* register IH_RB_CNTL_RING1 */
 	PSP_REG_IH_RB_CNTL_RING2  = 2,  /* register IH_RB_CNTL_RING2 */
+	PSP_REG_MMHUB_L1_TLB_CNTL = 25,
 	PSP_REG_LAST
 };
 
@@ -142,6 +143,8 @@ struct psp_funcs {
 	bool (*get_ras_capability)(struct psp_context *psp);
 	bool (*is_aux_sos_load_required)(struct psp_context *psp);
 	bool (*is_reload_needed)(struct psp_context *psp);
+	int (*reg_program_no_ring)(struct psp_context *psp, uint32_t val,
+				   enum psp_reg_prog_id id);
 };
 
 struct ta_funcs {
@@ -475,6 +478,10 @@ struct amdgpu_psp_funcs {
 #define psp_is_aux_sos_load_required(psp) \
 	((psp)->funcs->is_aux_sos_load_required ? (psp)->funcs->is_aux_sos_load_required((psp)) : 0)
 
+#define psp_reg_program_no_ring(psp, val, id) \
+	((psp)->funcs->reg_program_no_ring ? \
+	(psp)->funcs->reg_program_no_ring((psp), val, id) : -EINVAL)
+
 extern const struct amd_ip_funcs psp_ip_funcs;
 
 extern const struct amdgpu_ip_block_version psp_v3_1_ip_block;
@@ -569,5 +576,8 @@ bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
 int psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcp_id,
 	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
 bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);
+int amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
+				   enum psp_reg_prog_id id);
+
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index df03dba67ab8..b6ec6b7969f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -146,11 +146,13 @@ enum AMDGIM_FEATURE_FLAG {
 
 enum AMDGIM_REG_ACCESS_FLAG {
 	/* Use PSP to program IH_RB_CNTL */
-	AMDGIM_FEATURE_IH_REG_PSP_EN     = (1 << 0),
+	AMDGIM_FEATURE_IH_REG_PSP_EN      = (1 << 0),
 	/* Use RLC to program MMHUB regs */
-	AMDGIM_FEATURE_MMHUB_REG_RLC_EN  = (1 << 1),
+	AMDGIM_FEATURE_MMHUB_REG_RLC_EN   = (1 << 1),
 	/* Use RLC to program GC regs */
-	AMDGIM_FEATURE_GC_REG_RLC_EN     = (1 << 2),
+	AMDGIM_FEATURE_GC_REG_RLC_EN      = (1 << 2),
+	/* Use PSP to program L1_TLB_CNTL*/
+	AMDGIM_FEATURE_L1_TLB_CNTL_PSP_EN = (1 << 3),
 };
 
 struct amdgim_pf2vf_info_v1 {
@@ -330,6 +332,10 @@ struct amdgpu_video_codec_info;
 (amdgpu_sriov_vf((adev)) && \
 	((adev)->virt.reg_access & (AMDGIM_FEATURE_GC_REG_RLC_EN)))
 
+#define amdgpu_sriov_reg_indirect_l1_tlb_cntl(adev) \
+(amdgpu_sriov_vf((adev)) && \
+	((adev)->virt.reg_access & (AMDGIM_FEATURE_L1_TLB_CNTL_PSP_EN)))
+
 #define amdgpu_sriov_rlcg_error_report_enabled(adev) \
         (amdgpu_sriov_reg_indirect_mmhub(adev) || amdgpu_sriov_reg_indirect_gc(adev))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index d6ac2652f0ac..bea724981309 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -109,10 +109,11 @@ union amd_sriov_msg_feature_flags {
 
 union amd_sriov_reg_access_flags {
 	struct {
-		uint32_t vf_reg_access_ih	: 1;
-		uint32_t vf_reg_access_mmhub	: 1;
-		uint32_t vf_reg_access_gc	: 1;
-		uint32_t reserved		: 29;
+		uint32_t vf_reg_access_ih		: 1;
+		uint32_t vf_reg_access_mmhub		: 1;
+		uint32_t vf_reg_access_gc		: 1;
+		uint32_t vf_reg_access_l1_tlb_cntl	: 1;
+		uint32_t reserved			: 28;
 	} flags;
 	uint32_t all;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 84cde1239ee4..cc218f6e37c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -30,6 +30,7 @@
 #include "soc15_common.h"
 #include "soc15.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_psp.h"
 
 #define regVM_L2_CNTL3_DEFAULT	0x80100007
 #define regVM_L2_CNTL4_DEFAULT	0x000000c1
@@ -192,10 +193,8 @@ static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
 	uint32_t tmp, inst_mask;
 	int i;
 
-	/* Setup TLB control */
-	inst_mask = adev->aid_mask;
-	for_each_inst(i, inst_mask) {
-		tmp = RREG32_SOC15(MMHUB, i, regMC_VM_MX_L1_TLB_CNTL);
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_l1_tlb_cntl(adev)) {
+		tmp = RREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL);
 
 		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB,
 				    1);
@@ -209,7 +208,26 @@ static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
 				    MTYPE, MTYPE_UC);/* XXX for emulation. */
 		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
 
-		WREG32_SOC15(MMHUB, i, regMC_VM_MX_L1_TLB_CNTL, tmp);
+		psp_reg_program_no_ring(&adev->psp, tmp, PSP_REG_MMHUB_L1_TLB_CNTL);
+	} else {
+		inst_mask = adev->aid_mask;
+		for_each_inst(i, inst_mask) {
+			tmp = RREG32_SOC15(MMHUB, i, regMC_VM_MX_L1_TLB_CNTL);
+
+			tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB,
+					    1);
+			tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+					    SYSTEM_ACCESS_MODE, 3);
+			tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+					    ENABLE_ADVANCED_DRIVER_MODEL, 1);
+			tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+					    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
+			tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+					    MTYPE, MTYPE_UC);/* XXX for emulation. */
+			tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
+
+			WREG32_SOC15(MMHUB, i, regMC_VM_MX_L1_TLB_CNTL, tmp);
+		}
 	}
 }
 
@@ -454,6 +472,30 @@ static int mmhub_v1_8_gart_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void mmhub_v1_8_disable_l1_tlb(struct amdgpu_device *adev)
+{
+	u32 tmp;
+	u32 i, inst_mask;
+
+	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_l1_tlb_cntl(adev)) {
+		tmp = RREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL);
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
+		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+				    ENABLE_ADVANCED_DRIVER_MODEL, 0);
+		psp_reg_program_no_ring(&adev->psp, tmp, PSP_REG_MMHUB_L1_TLB_CNTL);
+	} else {
+		inst_mask = adev->aid_mask;
+		for_each_inst(i, inst_mask) {
+			tmp = RREG32_SOC15(MMHUB, i, regMC_VM_MX_L1_TLB_CNTL);
+			tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB,
+					    0);
+			tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+					    ENABLE_ADVANCED_DRIVER_MODEL, 0);
+			WREG32_SOC15(MMHUB, i, regMC_VM_MX_L1_TLB_CNTL, tmp);
+		}
+	}
+}
+
 static void mmhub_v1_8_gart_disable(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub;
@@ -467,15 +509,6 @@ static void mmhub_v1_8_gart_disable(struct amdgpu_device *adev)
 		for (i = 0; i < 16; i++)
 			WREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT0_CNTL,
 					    i * hub->ctx_distance, 0);
-
-		/* Setup TLB control */
-		tmp = RREG32_SOC15(MMHUB, j, regMC_VM_MX_L1_TLB_CNTL);
-		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB,
-				    0);
-		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
-				    ENABLE_ADVANCED_DRIVER_MODEL, 0);
-		WREG32_SOC15(MMHUB, j, regMC_VM_MX_L1_TLB_CNTL, tmp);
-
 		if (!amdgpu_sriov_vf(adev)) {
 			/* Setup L2 cache */
 			tmp = RREG32_SOC15(MMHUB, j, regVM_L2_CNTL);
@@ -485,6 +518,8 @@ static void mmhub_v1_8_gart_disable(struct amdgpu_device *adev)
 			WREG32_SOC15(MMHUB, j, regVM_L2_CNTL3, 0);
 		}
 	}
+
+	mmhub_v1_8_disable_l1_tlb(adev);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index cc621064610f..17f1ccd8bd53 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -858,6 +858,25 @@ static bool psp_v13_0_is_reload_needed(struct psp_context *psp)
 	return false;
 }
 
+static int psp_v13_0_reg_program_no_ring(struct psp_context *psp, uint32_t val,
+					 enum psp_reg_prog_id id)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int ret = -EOPNOTSUPP;
+
+	/* PSP will broadcast the value to all instances */
+	if (amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_101, GFX_CTRL_CMD_ID_GBR_IH_SET);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_102, id);
+		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_103, val);
+
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
+	}
+
+	return ret;
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.wait_for_bootloader = psp_v13_0_wait_for_bootloader_steady_state,
@@ -884,6 +903,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.get_ras_capability = psp_v13_0_get_ras_capability,
 	.is_aux_sos_load_required = psp_v13_0_is_aux_sos_load_required,
 	.is_reload_needed = psp_v13_0_is_reload_needed,
+	.reg_program_no_ring = psp_v13_0_reg_program_no_ring,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.34.1

