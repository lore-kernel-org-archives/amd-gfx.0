Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE151CF3196
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5703710E690;
	Wed,  2 Oct 2024 04:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L2BwzFuf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83B5A10E68A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NF6xRqgt7FPaoj9o7GvGFFAtsiyC7fDz11kjfpI2qI3z5piWGIOlwng71bT2j43wgOGwlmixmj5yVmD1H3U+W0KdW5+tYwT8jhw55sQyl+RziAziC0MxJq8mRsLBFDHeFVI63xkQp5tGFF7kf7EtDlBMXzI+/d7qZPrRt1jALzWNef0NTSpYyq7H3I5DFHx6Gu/kdZPwx219i/LPknQhDoAUudoNfETVTtTN1wAiJtz4wbuUVPYuqQY4psqmq0mdvfs8ygfPIEJhEJDWjcsf/v+WdDOxn4zKHWP0QB9lC0rjLpSE8nh5sTpEdlLn0m44936DisUrUy84Kx6YMMtbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak0zBx7YlXr6DbEzcyfVtviOpZS90lbi2lu/hcMhhtw=;
 b=pBjjDlXysgO8Zs1eichHWA0UbH8n/iAiYzhPNTceO8WjOq/vW5tkLxxCTnsOoC6AwOx0AoAb2DvgdWOGb14bym0UmecRLzXxObx0rNXP3agFYY0Qon/7C0SzkrWhkmSfyCkzSwKUEwB4hhZfMrEvq2cyopZpocJptHVGwHQZwT4AQqAGcmYkg4xxBzE/XifsvvKE3ThbbcPiR+jMALtYZsYKJT+Xi0qU6ezj62NnidM9TV0qqZnvIsBoaRHHZCq47zq2CpYc7+oVAFx/msBkspXwNOJpd7eQL4ev1sgsu+l/qEUmjWvAvYutbxwSlRkMFWyUcqK5AYvtHM8bt+5qLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak0zBx7YlXr6DbEzcyfVtviOpZS90lbi2lu/hcMhhtw=;
 b=L2BwzFufMEGRBuELDJfegpkkJXlr15ZFHuV7tdTaSdID1TzyKdwHQXBHrAijuNBthmJC93wJU+ODDZni/cCFeafAWD5A9hnbHDpP/QG2gNjact840UIpXlBFBFHU6fdRfugX7nINe61L0aY3fEW/4aJC6ZLR9LlC8xY6NMg5r78=
Received: from SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 04:38:51 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::93) by SJ0PR05CA0103.outlook.office365.com
 (2603:10b6:a03:334::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Wed, 2 Oct 2024 04:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:38:51 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:46 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 05/18] drm/amd/pm: set vcn enable by instance
Date: Wed, 2 Oct 2024 00:36:14 -0400
Message-ID: <20241002043627.102414-6-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: fc09dd26-212b-483d-c827-08dce29c1d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aCdJjT/SFe53TSYdjBCw3SlT7t8Yu0kZits/6o9f6AQpVOwR9WbSTpf5j5ro?=
 =?us-ascii?Q?Cg+3VxUblj3ZM6ezJKdGXCkgly2CPkqzcowC46u6P8M4eDG1OOp9m+SdLVUr?=
 =?us-ascii?Q?jrpHQF2Udx3+STSJg2LyaGjeZ2wdF5NkVApxZMogtC8OkTB5dMDMAPDZEHGT?=
 =?us-ascii?Q?+3acaEJUo16OmuIhf4Sx3B4SKGCxEWXVKR+LHU2SZQnv6O1osclv4X0shqJC?=
 =?us-ascii?Q?/7oC2XHHHaQJi4BA2bNWkOcslfRDVJuY3ne1RzFjnolb5pMIvxz9cPmNeZo7?=
 =?us-ascii?Q?VrKem0ByRo55DTepE2ofrxfmh04zzvsFL5wy2EnzZ/g1gv5R+CUK/NoJrc4P?=
 =?us-ascii?Q?pGGIzXV1ubwf52RNADzJRyIIzzcbYvYNIsENGAMNVaL1/5+A5UDq2us21bN+?=
 =?us-ascii?Q?zscm/xknGzy07nY70fm+niWdFxD+/TzOg5bA3AqNcfV667I/WfqyRnDnDCu6?=
 =?us-ascii?Q?8HzfRckBDwqi65n48JhBNwj6q7LMGSwSTIcOQszhOL/AccbUmP0p0BW2E002?=
 =?us-ascii?Q?dwms4L9nRmzCRTx+k26ught869SvYWqswF6fNXCwTVBwHFBC74pDmFbaGWrm?=
 =?us-ascii?Q?I+PfGT9c+E6PTDDy1+t90BgqgAGMhVro/eIFxgt445GhkuV12h+k6BBiChN3?=
 =?us-ascii?Q?CrSwP9/Sr+ZW1G7c+z6EB8bRWe5p9Yjs1tkbqxqskqYOcwc6T3b51kc75i5z?=
 =?us-ascii?Q?sYyjh62LI+PrNt4wld45RlTsUqwv7lLsPL9lxr25+tSnRWDYpG9ufBRSXH55?=
 =?us-ascii?Q?GSLXxx6ZqeaNXdt3wzLLSF/TtoOtXELMmERnp+hNbBOUyvgEBb8UqevtFP8T?=
 =?us-ascii?Q?krwvDecxVoAX2EEQmI0CuMIyiwOW67nLR6L8Rxtn2lsNzRgOpJ3TDaYs2lMh?=
 =?us-ascii?Q?VlFSW7ZMixoHpvmoxZp2yjZUacSsrqJuMqwYAcr9Fr2zqt5fXZ10c4NMvGBU?=
 =?us-ascii?Q?DQqfkR2l66LvwlgfIsundPS2d+KOkYm+GW93U+Q8AtGajESOjcddUTCu2JOT?=
 =?us-ascii?Q?UYEbjom+0gXi0MZ7YuFmTiVGQg0QwTyNa1vLoluDrnxHudD6Bkenj3lXd9tn?=
 =?us-ascii?Q?00wbZsMnqYEAtThOEfOVawvIbczf/J14KQ/rYct1tSKI7d9LPhxvEHLpu/PF?=
 =?us-ascii?Q?iu4lH34T4X6GdXbRZ5jbqxW7g9jxs6aItcSiyOqBt6/Qk7UOR3vEb+RWbrv5?=
 =?us-ascii?Q?sMSGgg9sxMiZEtII728Y/FW7xET4LfnDU0K5Nq0eJD/NxpU4kpfPggcn9K5p?=
 =?us-ascii?Q?eptSuwvLeEoC1B7Raxlh7momZ3TACiN4t2jPF172+GdfyFw6boCU+OvvB9mw?=
 =?us-ascii?Q?3WjXlISolLMAvRvZivnlFrzPmI3iB4MjFOTvEWadM+GLhlR9ojIFuhSuiejG?=
 =?us-ascii?Q?zLcAvqCqTNoMP2HsBtRWbCkqZkQcTpB81f5ZK8XcrYHXenw7XwFdRJ7Gc9Pr?=
 =?us-ascii?Q?tSrCb/i+1EuD+mWeB+0IKp8nG9v+dANe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:38:51.2118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc09dd26-212b-483d-c827-08dce29c1d43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

The new function smu_dpm_set_vcn_enable_instance() will be used to enable
or disable vcn engine dynamic power for the given vcn instance only.

The original function smu_dpm_set_vcn_enable() will still be used to enable
or disable vcn engine dynamic power for all VCN instances as before.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 132 +++++++++++++++---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   2 +-
 2 files changed, 115 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 939e15b24f86..ddfed7189708 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -232,12 +232,15 @@ static bool is_vcn_enabled(struct amdgpu_device *adev)
 	return true;
 }
 
-static int smu_dpm_set_vcn_enable(struct smu_context *smu,
-				  bool enable)
+static int smu_dpm_set_vcn_enable_instance(struct smu_context *smu,
+				  bool enable,
+				  int inst)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
+	bool single_inst = (adev->vcn.num_vcn_inst == 1);
 
 	/*
 	 * don't poweron vcn/jpeg when they are skipped.
@@ -245,15 +248,33 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	if (!is_vcn_enabled(smu->adev))
 		return 0;
 
-	if (!smu->ppt_funcs->dpm_set_vcn_enable)
+	if (!smu->ppt_funcs->dpm_set_vcn_enable_instance && !single_inst)
 		return 0;
 
-	if (atomic_read(&power_gate->vcn_gated) ^ enable)
+	if (!smu->ppt_funcs->dpm_set_vcn_enable && single_inst)
 		return 0;
 
-	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
+	if (atomic_read(&power_gate->vcn_gated[inst]) ^ enable)
+		return 0;
+
+	if (single_inst)
+		ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
+	else
+		ret = smu->ppt_funcs->dpm_set_vcn_enable_instance(smu, enable, inst);
 	if (!ret)
-		atomic_set(&power_gate->vcn_gated, !enable);
+		atomic_set(&power_gate->vcn_gated[inst], !enable);
+
+	return ret;
+}
+
+static int smu_dpm_set_vcn_enable(struct smu_context *smu,
+				  bool enable)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+		ret = smu_dpm_set_vcn_enable_instance(smu, enable, i);
 
 	return ret;
 }
@@ -408,6 +429,81 @@ static int smu_dpm_set_power_gate(void *handle,
 	return ret;
 }
 
+/**
+ * smu_dpm_set_power_gate_instance - power gate/ungate the specific IP block
+ *                                   for the specific instance
+ *
+ * @handle:     smu_context pointer
+ * @block_type: the IP block to power gate/ungate
+ * @gate:       to power gate if true, ungate otherwise
+ * @inst:       the instance to power gate/ungate
+ *
+ * This API uses no smu->mutex lock protection due to:
+ * 1. It is either called by other IP block(gfx/sdma/vcn/uvd/vce).
+ *    This is guarded to be race condition free by the caller.
+ * 2. Or get called on user setting request of power_dpm_force_performance_level.
+ *    Under this case, the smu->mutex lock protection is already enforced on
+ *    the parent API smu_force_performance_level of the call path.
+ */
+static int smu_dpm_set_power_gate_instance(void *handle,
+				  uint32_t block_type,
+				  bool gate,
+				  int inst)
+{
+	struct smu_context *smu = handle;
+	int ret = 0;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
+		dev_WARN(smu->adev->dev,
+			 "SMU uninitialized but power %s requested for %u!\n",
+			 gate ? "gate" : "ungate", block_type);
+		return -EOPNOTSUPP;
+	}
+
+	switch (block_type) {
+	/*
+	 * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
+	 * AMD_IP_BLOCK_TYPE_UVD for VCN. So, here both of them are kept.
+	 */
+	case AMD_IP_BLOCK_TYPE_UVD:
+	case AMD_IP_BLOCK_TYPE_VCN:
+		ret = smu_dpm_set_vcn_enable_instance(smu, !gate, inst);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
+				gate ? "gate" : "ungate");
+		break;
+	case AMD_IP_BLOCK_TYPE_GFX:
+		ret = smu_gfx_off_control(smu, gate);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to %s gfxoff!\n",
+				gate ? "enable" : "disable");
+		break;
+	case AMD_IP_BLOCK_TYPE_SDMA:
+		ret = smu_powergate_sdma(smu, gate);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s SDMA!\n",
+				gate ? "gate" : "ungate");
+		break;
+	case AMD_IP_BLOCK_TYPE_JPEG:
+		ret = smu_dpm_set_jpeg_enable(smu, !gate);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s JPEG!\n",
+				gate ? "gate" : "ungate");
+		break;
+	case AMD_IP_BLOCK_TYPE_VPE:
+		ret = smu_dpm_set_vpe_enable(smu, !gate);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s VPE!\n",
+				gate ? "gate" : "ungate");
+		break;
+	default:
+		dev_err(smu->adev->dev, "Unsupported block type!\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 /**
  * smu_set_user_clk_dependencies - set user profile clock dependencies
  *
@@ -774,19 +870,11 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 static int smu_set_default_dpm_table(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	int vcn_gate, jpeg_gate;
 	int ret = 0;
 
 	if (!smu->ppt_funcs->set_default_dpm_table)
 		return 0;
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
-		vcn_gate = atomic_read(&power_gate->vcn_gated);
-	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
-		jpeg_gate = atomic_read(&power_gate->jpeg_gated);
-
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
 		ret = smu_dpm_set_vcn_enable(smu, true);
 		if (ret)
@@ -805,10 +893,10 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 			"Failed to setup default dpm clock tables!\n");
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
-		smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
+		smu_dpm_set_jpeg_enable(smu, false);
 err_out:
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
-		smu_dpm_set_vcn_enable(smu, !vcn_gate);
+		smu_dpm_set_vcn_enable(smu, false);
 
 	return ret;
 }
@@ -1253,7 +1341,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 
-	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
@@ -2932,6 +3021,7 @@ static int smu_read_sensor(void *handle,
 			   int *size_arg)
 {
 	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 	int ret = 0;
@@ -2980,7 +3070,13 @@ static int smu_read_sensor(void *handle,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
-		*(uint32_t *)data = atomic_read(&smu->smu_power.power_gate.vcn_gated) ? 0 : 1;
+		*(uint32_t *)data = 0;
+		for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (!atomic_read(&smu->smu_power.power_gate.vcn_gated[i])) {
+				*(uint32_t *)data = 1;
+				break;
+			}
+		}
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index f88241cdf9b9..b8b6050877c1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -399,7 +399,7 @@ struct smu_dpm_context {
 struct smu_power_gate {
 	bool uvd_gated;
 	bool vce_gated;
-	atomic_t vcn_gated;
+	atomic_t vcn_gated[AMDGPU_MAX_VCN_INSTANCES];
 	atomic_t jpeg_gated;
 	atomic_t vpe_gated;
 	atomic_t umsch_mm_gated;
-- 
2.34.1

