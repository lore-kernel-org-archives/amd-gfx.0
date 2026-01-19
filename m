Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51067C98315
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 05:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E155C10E360;
	Mon, 19 Jan 2026 05:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nyQBkG6q";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011048.outbound.protection.outlook.com
 [40.93.194.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2613510E360
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 05:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwHdky34CJoAadK6cqlglx7KKXwXKCzfQWXvDcw+fORw24wx1GVRgQSEmN/0DmDFmwad9ae1HsSAaz8/aPsPI/U4q1lYiRt42ML9QnQKE8TuaGJ7YflurVPNZVI64sL8KWXJIU0k4YPvdKlbFFyByOB3JwL+GeeMbpPq/A5O7PT57Sne5mJhanJj0IDTx8vRbIRQM97kEbo7NtAZmdPbDnP/ZxuaSJCWowQQOAIcDQxMae+WwJDnOnMWdUeygfiCcflMlvxFE6UzZ9wzJ4V09Hocp/u4nz9U8q37ittjut0c53ahrqfgBud6QX30hQGV4FkpJQpRhMRkMhxBKgoMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+aArWS/kl8r5McLu1hForMaGhc5+RQaArnNZLAhqOc=;
 b=UGJNQKa3s8US3LRv8HFwg0UwmgdztmsVjJoFfC+lqO8QlZryJSZmhEuq/+nFt+G5MxgKGfOyFbGOAPi2UaiQSz4Pz52Lhn8D99ad9JuYKICXQzLERACJNFTfVTMBqGf1Y8+wVwugcbZ6gA99mW5reTkat4xZXGJ9TiwgufSl/Kl9Luzkek3t7Z2zr9iCprWYQvAWesCrKB17/24b1ipllSPkpxnRXxgmXFmIpC8UMZ6DH45UOYeiNao+/EpOmN4yKvTMjWI5NKsFcVOeBaTO5Ic9PGNy+kwG41om5vXLRfnxlo/dFUbi1uVbZiDEgJRyyr71iKMZZXF0mP7dRKveIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+aArWS/kl8r5McLu1hForMaGhc5+RQaArnNZLAhqOc=;
 b=nyQBkG6q8K+dYuOXcSRJM5C/wuIwHorCt1o/Azzh9Usf/k+OTArQEimVohcZDEjAWztTz2XR2AXJZhgn+HdoEhWAQEx2SnvuD+TwvvVnjja0vWNMZVia6zpgwbc3Cj9sn4Hs9JzRmrjuvCmz4Ph6HFnY97XR+ex0F1isYqMfUqU=
Received: from SA1P222CA0165.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::11)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Mon, 19 Jan
 2026 05:35:37 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::a8) by SA1P222CA0165.outlook.office365.com
 (2603:10b6:806:3c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 05:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 05:35:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 23:35:36 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sun, 18 Jan 2026 23:35:29 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 3/5] drm/amdgpu/vcn4.0.3: implement DPG pause mode handling
 for VCN 4.0.3
Date: Mon, 19 Jan 2026 13:34:04 +0800
Message-ID: <20260119053515.893663-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260119053515.893663-1-Jesse.Zhang@amd.com>
References: <20260119053515.893663-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|IA0PR12MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: f925614a-293c-4908-9e24-08de571c92e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0kmXAvivapO2HKjUMzkLit2OULbmCFH9MIIab/v3sd3jrCkknT3wVkMJa5/U?=
 =?us-ascii?Q?doVmgqlnzLvxQPbxfVkLPJZBHhrf5zTPwjM4EQL6rekn/eA9nupyNJP6wevv?=
 =?us-ascii?Q?l7K97D3FppbACB1EFus+MqSdbJ3+ZkIbTmQzwaFImMyH7izLtFBElRGQ9q4M?=
 =?us-ascii?Q?Az2Hvm9iw5F4FeG6PbYUtBZxEy8eluFG2FJd4DVdPIIprTFyH/NkFOr/tt9z?=
 =?us-ascii?Q?UOh07laNbAV+uj3h/zML+kHBjT9ZfKv7oRwmNJRXqEvgSTUw8zYaLziWhF15?=
 =?us-ascii?Q?DWFqBQCiRTED9GVjefGhZvEfSLxFwTPBWifW5y2V+bIGRu3YJtaR2h+L7NA6?=
 =?us-ascii?Q?gBaH79Wi1r//k5A8L77P51ExxwqxTBWFg2vVLguHjR+R+2fuyPZk9B3qBDFf?=
 =?us-ascii?Q?X0D5xMaqcIOfbLLhOhaChccyIg/sBWy7GUXIskAlJol/E/+W8ywZS5jXsAsB?=
 =?us-ascii?Q?YJwFQ24goFtNdEIF9TsyvElvxgqrzR2EEdAI4vrzJqEgIYFMI7ZDJanrRh85?=
 =?us-ascii?Q?Acx1xGhzkSzSQT9F31Ne1/6mq3+Jp/WetyJ4UyDetXtn18xZBUIR1EyLWD2E?=
 =?us-ascii?Q?0B3UbWPczN5mua5QJt8xyKUbJHB/0iK3eXZC2kKHhndTE7AbgwstkW8TtKTV?=
 =?us-ascii?Q?z+HV704pj6/ZlRIDOOtrOyzpdVPTYu1obpx51V8Qc7ysjvAXCYtQ1a9yUI+/?=
 =?us-ascii?Q?SC8UlJtEQxPYs2zVumP0vwGyB0wmVAUiNTAJtPG7Yj5Hk4eTnrz76n/tSPM5?=
 =?us-ascii?Q?XifwYDfWD3KTphONkT499G9MM3epRIR1/k+zKx0FjdUKAie7UKS9cw9ZicH8?=
 =?us-ascii?Q?RywxXypGzWVp27HFmWRMQPoCyiF9Ken7iqkX0nKXjQAUsCQplnLMzWVb5PHJ?=
 =?us-ascii?Q?bwsNJ+PCYIbsgXOsrZkUG4n/zybZ2FFCGlkjYEf+JZ83eO6UOP/ItT+/qdh5?=
 =?us-ascii?Q?DqZPzzM4/JGhvYharAcrVAT1AXj2crYMuupIk8GJw7uWu1u9xxAwYyx8rKmw?=
 =?us-ascii?Q?fVkg82ikByTDIaJ1lPKaswGnmHyWIeL/ar4ehJLFuWaRIbNIGLzTgFfRAons?=
 =?us-ascii?Q?5UuASkBPol4U+5wiax2LI2Z52fg5p1eCyHXsMYay4tnhbVxD8EReczFMJbDX?=
 =?us-ascii?Q?OCY200VQb72HVhuw8Ec+H6SZmuOSr/pJMntZ5tRGqK09wtdC7JGRZcAQEhK1?=
 =?us-ascii?Q?qzIhUA89AjRKy0uwsEkQErb/G8H2KKQbDpD6Tf1ItehH7G8qDGaVqx8QSAzG?=
 =?us-ascii?Q?HO6ivZK03dJnRZfxO0XfAqn7ayu6PbSj6FU6PnT8DlWHBHCqw7A8ypHvNZAW?=
 =?us-ascii?Q?h+5Ypke08SZriorRLd2cO6JpzLkjqcGX/f4AgnAOxPZHCtkmcMA/Ebit5dY9?=
 =?us-ascii?Q?ct/eNiR7kgIlLDsOTU8S+EOKZu8VGFS/YuZvWh1A0mSWZeu/e/PWVTYsf7Zq?=
 =?us-ascii?Q?nZu9mYf+TiVcVJJz1y5Dqklez4oqZwPLvfR48f/2QA5A68Gr0mRKnS19o5xm?=
 =?us-ascii?Q?13Ulf9oXyXqccW/Mr81vWcPnnZxGEZM0p0nu1z4LOdD+HY9Zq4FP7xgHNCl6?=
 =?us-ascii?Q?WXpG/vgwV/haHRPhR3kvmCk/cvOH2TiSCR4f69hNbrsIv5FImyx/JYDLjAyt?=
 =?us-ascii?Q?TSP7HtOr1JnqIf7CPoKprkyrDF1lTuOdM3PyE48GwfCaxqizZbD7VqfxFiC+?=
 =?us-ascii?Q?O4JZBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 05:35:36.8020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f925614a-293c-4908-9e24-08de571c92e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648
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

For MI projects, when Dynamic Power Gating (DPG) is enabled,
VCN reset operations should be performed with DPG in pause mode.
Otherwise, the hardware may perform undesirable reset operations

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 78c13724a7ba..dd247abce1ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -847,6 +847,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	int inst_idx = vinst->inst;
 	struct amdgpu_vcn4_fw_shared *fw_shared =
 						adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__PAUSE};
 	struct amdgpu_ring *ring;
 	int vcn_inst, ret;
 	uint32_t tmp;
@@ -951,6 +952,9 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
+	/* Pause dpg */
+	vcn_v4_0_3_pause_dpg_mode(vinst, &state);
+
 	/* program the RB_BASE for ring buffer */
 	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
 		     lower_32_bits(ring->gpu_addr));
@@ -1360,9 +1364,13 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	int inst_idx = vinst->inst;
 	uint32_t tmp;
 	int vcn_inst;
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 
 	vcn_inst = GET_INST(VCN, inst_idx);
 
+	/* Unpause dpg */
+	vcn_v4_0_3_pause_dpg_mode(vinst, &state);
+
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_POWER_STATUS, 1,
 			   UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
@@ -1486,6 +1494,39 @@ static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst *vinst)
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				     struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
+	uint32_t reg_data = 0;
+	int ret_code;
+
+	/* pause/unpause if state is changed */
+	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
+		DRM_DEV_DEBUG(adev->dev, "dpg pause state changed %d -> %d",
+			adev->vcn.inst[inst_idx].pause_state.fw_based,	new_state->fw_based);
+		reg_data = RREG32_SOC15(VCN, inst_idx, regUVD_DPG_PAUSE) &
+			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+
+		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
+			ret_code = SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 0x1,
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+			if (!ret_code) {
+				/* pause DPG */
+				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+				WREG32_SOC15(VCN, inst_idx, regUVD_DPG_PAUSE, reg_data);
+
+				/* wait for ACK */
+				SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_DPG_PAUSE,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+			}
+		} else {
+			/* unpause dpg, no need to wait */
+			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(VCN, inst_idx, regUVD_DPG_PAUSE, reg_data);
+		}
+		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
+	}
 
 	return 0;
 }
-- 
2.49.0

