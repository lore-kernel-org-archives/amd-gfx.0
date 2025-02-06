Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37DCC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 21:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70DF210E957;
	Thu,  6 Feb 2025 21:18:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BradBolx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92D310E94F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 21:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re8x91mlLddn/siAt2PESXHOJgvuNPbMqBomvivDUgGpFLD8AntyqOcPbA/mbUfARoMCRz07ZPxJzCBqwtntClLYeIRORIlJ8Qfl3RmNMKbeDSlapJ8PoJVgcsN7PTDyvHulhH/rOOggJMcz9DAPdd5QUYQ/10t7nokZrPjJx8s70ujYhdXX+KYkomo3PC9HfJb1+ZIkiLezkK1qbpGKuAa7pwgAYOS6Z0Sx5Xz1Z12KLvxrjfWn3rl27utUn8AKdLSIcdRX+TEzPhPegyiuDq1XxbBscRTy3kT6h1VCj93gu3Hm4muKhAQg3MvZ/UltmN00gZLZLcpi2+1bU5empA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXiOlmPXmplqORaao1Ed5pHOAja1rhoVmWxwQTpmxKc=;
 b=qwXFEJtXodpNfL5fXZ0wtmAuTweQb8N3GYl+nwdj1PzjuEiyGvzr6LGI+8xphRtW3TCMJH4fOB30k+nfNjK5kbxy402+U0OOJZ+Okd76kaFyCqIMrti6ReGYzUTI3DZLOdbQ/AeVEicM6vlpNjUbtY+v5fVxVFlay9PnPP2BWBpg7uaU/0vfsPz6Q067DbuBADuxTMYnSwHSZiXidiwY5Mkf5c2daM3RcwIjo/Zg8PU5xDQQ0Sk/nE7xxqOIZkiWA4sUb2qYc7MXMf7vjFzxhVL5Diq5N3U8ipiP0IKDCyxsEJB4jy+JuifjpCqdfu8lI5X6uPFuQcz1vuPv4pTkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXiOlmPXmplqORaao1Ed5pHOAja1rhoVmWxwQTpmxKc=;
 b=BradBolx7olD7Z7UCAvZULIYa3fyTG2QvAEXlUDH9n/02TJDoZf2S2DILxnUweyd2KHCZ3uqIu2XYouc09YHfcIAIXKh3uYCDtHoE8qYmtc2ZH2BVRwvloe70mvejsCj8ljHDIHnYaVGsie44EDJPwr+MPOve5QdCcBphLB54RQ=
Received: from BN9PR03CA0290.namprd03.prod.outlook.com (2603:10b6:408:f5::25)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 21:07:37 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::19) by BN9PR03CA0290.outlook.office365.com
 (2603:10b6:408:f5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Thu,
 6 Feb 2025 21:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 21:07:36 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Feb 2025 15:07:33 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: Set snoop bit for SDMA for MI series
Date: Thu, 6 Feb 2025 16:07:21 -0500
Message-ID: <20250206210721.200197-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: c39ade02-c4c6-4c82-7969-08dd46f24864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rJ47M8tAKwYQmTnecTbSFsL6PrqkyhV+5DbdjTEv3rDo3zj1HlGkUWbFO2hf?=
 =?us-ascii?Q?WgxdmClCyyj+d79Ue1/7pq0aLzqnnWdGSJgXSFC8K7WsHD/Ko0OscJCXnSpK?=
 =?us-ascii?Q?aAVgCE71EizWVqakRoAGtdekPIJp4Xce8wEnlKO578zkwvfwpYJrCPYhFyHQ?=
 =?us-ascii?Q?eXzDFGFLf3iIC+0+f4KANgg2ziNZVwY30eBLpKqn7NIghy9rMv3xtHktHCSe?=
 =?us-ascii?Q?T/XsLP2CAvUMj4FsBfx170TPz+MiBbKYJc7d1MQBVCbf1y0IUcc+KUw5aewr?=
 =?us-ascii?Q?JCgS3DU6N06ROlLJlTzGWsoD4fGee0ebXQRgps5dXCCZ2rsoa6TGsLgbMmq0?=
 =?us-ascii?Q?dmnHew0pXVTPCVy1pVfVfOQ3JpoLuni/b/13QqLTyEmjmYYsx7YZ4HtA+qSO?=
 =?us-ascii?Q?8GZhrAhPKRGAMIvmhePbmb4I2Bb8Uhon8DRoVYjOh0q3eITOZqfOUl0atHzf?=
 =?us-ascii?Q?evc3L5WiNRJExRxokkUlEaGMI4oKTYv/iNDsoAsjBJp9Gw+ozwYHPN2EzaI3?=
 =?us-ascii?Q?lsTA3yx89pKxJvA9uhQPSBUSCqlRn9QUuzB7rOCYU+aB56icKyZduh5boWkL?=
 =?us-ascii?Q?0eEROzNRnlkGgHj+O6fFtLRX/HR7wjK2mGY11UfCsxSnbsDzc2fFoTruBa2H?=
 =?us-ascii?Q?6lwIV81RXR5Y4x+o7W6hlMGljXRUysdtbvF3UZXPZWxPS8jvVh5TYci6CMVK?=
 =?us-ascii?Q?nUumQKq4+iZHUd2lQNhTjq1pELDlvb0uvVS8n1Q0Rb3w0lfR/3CPwaK+gIB1?=
 =?us-ascii?Q?ZplSEHbrORIB+aUMyL0CafYiDiLSXKabUX/PrZu8eGe9GHNhHKPSPOXlaupJ?=
 =?us-ascii?Q?R0Yl6m+vJ2IpM48CPEgg5C7rWICdPHc2bcbk12kfNE14lIgqrDD5vS5SE+5X?=
 =?us-ascii?Q?IqmYy8MzVMWwb8JTZebR9//CoHgoOC1C3z6nWSkSNr1UJFJGvR5d9t5BnPH6?=
 =?us-ascii?Q?rjxV499GHz6rf09xPUux29gsSZL/j/+sW5/PAOjV3TJte6pRWXb+zU5lOXso?=
 =?us-ascii?Q?cabO3g1ydvJFTrnEl+Q3DdYYw0TsTg0k9wwt0gphsmLd+NvlJdw9ngID9B1a?=
 =?us-ascii?Q?yvvabma8AxWebvwveQ9El11JJh6Nd/qZi/3Z0j2npidkigODXSznhoCfFlem?=
 =?us-ascii?Q?OGQYaYXSuGl/Xkq0MIIuIUFUFWdBnU8i/Sw8OmyUrqoEtvgLX5NmcR7G3Ezo?=
 =?us-ascii?Q?CR3qtN+x8q7JMWjBxh6guupWBC1gOvrhE930gADpLjiC3whitxtqWGhOHPta?=
 =?us-ascii?Q?mrraq/+N/GoQwq4q0uGkqFe+L9Rp+tEdb7y11GUHfs7rXQJi6a1gH/bFLyCM?=
 =?us-ascii?Q?v0LPNp3ssFfQvcLDTJTCBc+WrRJU65YcQZifqe2RuD47He5oTtjfwu3WfzwF?=
 =?us-ascii?Q?Kmow5WVFkJT0QrQBl2WKwpir+B0M8+gxFMFJtDIMRQ7ScFcTNGrZr9pWRAhN?=
 =?us-ascii?Q?PCOkuhfMGdb+MC+hdYs4ZaLKJSKSbdURFNlASYx7oDV8+lvd1q33ZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 21:07:36.6427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c39ade02-c4c6-4c82-7969-08dd46f24864
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
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

SDMA writes has to probe invalidate RW lines. Set snoop bit in mmhub for
this to happen.

v2: Missed a few mmhub_v9_4. Added now.
v3: Calculate hub offset once since it doesn't change inside the loop
    Modified function names based on review comments.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c       | 25 ++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       | 27 +++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c       | 31 ++++++++++++
 .../asic_reg/mmhub/mmhub_9_4_1_offset.h       | 32 +++++++++++++
 .../asic_reg/mmhub/mmhub_9_4_1_sh_mask.h      | 48 +++++++++++++++++++
 5 files changed, 163 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 9689e2b5d4e5..1383acb5aece 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -172,6 +172,30 @@ static void mmhub_v1_7_init_tlb_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v1_7_init_snoop_override_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+	int j;
+	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	for (j = 0; j < 5; j++) { /* DAGB instances */
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance);
+		tmp |= (1 << 15); /* SDMA client is BIT15 */
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance, tmp);
+
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance);
+		tmp |= (1 << 15);
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance, tmp);
+	}
+
+}
+
 static void mmhub_v1_7_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
@@ -337,6 +361,7 @@ static int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
 	mmhub_v1_7_init_system_aperture_regs(adev);
 	mmhub_v1_7_init_tlb_regs(adev);
 	mmhub_v1_7_init_cache_regs(adev);
+	mmhub_v1_7_init_snoop_override_regs(adev);
 
 	mmhub_v1_7_enable_system_domain(adev);
 	mmhub_v1_7_disable_identity_aperture(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index e646e5cef0a2..ce013a715b86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -213,6 +213,32 @@ static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
 	}
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v1_8_init_snoop_override_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp, inst_mask;
+	int i, j;
+	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask) {
+		for (j = 0; j < 5; j++) { /* DAGB instances */
+			tmp = RREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance);
+			tmp |= (1 << 15); /* SDMA client is BIT15 */
+			WREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance, tmp);
+
+			tmp = RREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance);
+			tmp |= (1 << 15);
+			WREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance, tmp);
+		}
+	}
+}
+
 static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp, inst_mask;
@@ -418,6 +444,7 @@ static int mmhub_v1_8_gart_enable(struct amdgpu_device *adev)
 	mmhub_v1_8_init_system_aperture_regs(adev);
 	mmhub_v1_8_init_tlb_regs(adev);
 	mmhub_v1_8_init_cache_regs(adev);
+	mmhub_v1_8_init_snoop_override_regs(adev);
 
 	mmhub_v1_8_enable_system_domain(adev);
 	mmhub_v1_8_disable_identity_aperture(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index ff1b58e44689..fe0710b55c3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -198,6 +198,36 @@ static void mmhub_v9_4_init_tlb_regs(struct amdgpu_device *adev, int hubid)
 			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET, tmp);
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v9_4_init_snoop_override_regs(struct amdgpu_device *adev, int hubid)
+{
+	uint32_t tmp;
+	int i;
+	uint32_t distance = mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+	uint32_t huboffset = hubid * MMHUB_INSTANCE_REGISTER_OFFSET;
+
+	for (i = 0; i < 5 - (2 * hubid); i++) {
+		/* DAGB instances 0 to 4 are in hub0 and 5 to 7 are in hub1 */
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE,
+			huboffset + i * distance);
+		tmp |= (1 << 15); /* SDMA client is BIT15 */
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE,
+			huboffset + i * distance, tmp);
+
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE,
+			huboffset + i * distance);
+		tmp |= (1 << 15);
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE,
+			huboffset + i * distance, tmp);
+	}
+
+}
+
 static void mmhub_v9_4_init_cache_regs(struct amdgpu_device *adev, int hubid)
 {
 	uint32_t tmp;
@@ -392,6 +422,7 @@ static int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
 		if (!amdgpu_sriov_vf(adev))
 			mmhub_v9_4_init_cache_regs(adev, i);
 
+		mmhub_v9_4_init_snoop_override_regs(adev, i);
 		mmhub_v9_4_enable_system_domain(adev, i);
 		if (!amdgpu_sriov_vf(adev))
 			mmhub_v9_4_disable_identity_aperture(adev, i);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
index c488d4a50cf4..b2252deabc17 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
@@ -203,6 +203,10 @@
 #define mmDAGB0_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB0_WR_MISC_CREDIT                                                                         0x0058
 #define mmDAGB0_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x005b
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x005c
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB0_WRCLI_ASK_PENDING                                                                      0x005d
 #define mmDAGB0_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB0_WRCLI_GO_PENDING                                                                       0x005e
@@ -455,6 +459,10 @@
 #define mmDAGB1_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB1_WR_MISC_CREDIT                                                                         0x00d8
 #define mmDAGB1_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x00db
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x00dc
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB1_WRCLI_ASK_PENDING                                                                      0x00dd
 #define mmDAGB1_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB1_WRCLI_GO_PENDING                                                                       0x00de
@@ -707,6 +715,10 @@
 #define mmDAGB2_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB2_WR_MISC_CREDIT                                                                         0x0158
 #define mmDAGB2_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x015b
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x015c
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB2_WRCLI_ASK_PENDING                                                                      0x015d
 #define mmDAGB2_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB2_WRCLI_GO_PENDING                                                                       0x015e
@@ -959,6 +971,10 @@
 #define mmDAGB3_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB3_WR_MISC_CREDIT                                                                         0x01d8
 #define mmDAGB3_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x01db
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x01dc
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB3_WRCLI_ASK_PENDING                                                                      0x01dd
 #define mmDAGB3_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB3_WRCLI_GO_PENDING                                                                       0x01de
@@ -1211,6 +1227,10 @@
 #define mmDAGB4_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB4_WR_MISC_CREDIT                                                                         0x0258
 #define mmDAGB4_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x025b
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x025c
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB4_WRCLI_ASK_PENDING                                                                      0x025d
 #define mmDAGB4_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB4_WRCLI_GO_PENDING                                                                       0x025e
@@ -4793,6 +4813,10 @@
 #define mmDAGB5_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB5_WR_MISC_CREDIT                                                                         0x3058
 #define mmDAGB5_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x305b
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x305c
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB5_WRCLI_ASK_PENDING                                                                      0x305d
 #define mmDAGB5_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB5_WRCLI_GO_PENDING                                                                       0x305e
@@ -5045,6 +5069,10 @@
 #define mmDAGB6_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB6_WR_MISC_CREDIT                                                                         0x30d8
 #define mmDAGB6_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x30db
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x30dc
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB6_WRCLI_ASK_PENDING                                                                      0x30dd
 #define mmDAGB6_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB6_WRCLI_GO_PENDING                                                                       0x30de
@@ -5297,6 +5325,10 @@
 #define mmDAGB7_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB7_WR_MISC_CREDIT                                                                         0x3158
 #define mmDAGB7_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x315b
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x315c
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB7_WRCLI_ASK_PENDING                                                                      0x315d
 #define mmDAGB7_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB7_WRCLI_GO_PENDING                                                                       0x315e
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
index 2969fbf282b7..5069d2fd467f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
@@ -1532,6 +1532,12 @@
 //DAGB0_WRCLI_DBUS_GO_PENDING
 #define DAGB0_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB0_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB0_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB0_DAGB_DLY
 #define DAGB0_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB0_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -3207,6 +3213,12 @@
 //DAGB1_WRCLI_DBUS_GO_PENDING
 #define DAGB1_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB1_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB1_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB1_DAGB_DLY
 #define DAGB1_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB1_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -4882,6 +4894,12 @@
 //DAGB2_WRCLI_DBUS_GO_PENDING
 #define DAGB2_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB2_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB2_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB2_DAGB_DLY
 #define DAGB2_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB2_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -6557,6 +6575,12 @@
 //DAGB3_WRCLI_DBUS_GO_PENDING
 #define DAGB3_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB3_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB3_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB3_DAGB_DLY
 #define DAGB3_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB3_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -8232,6 +8256,12 @@
 //DAGB4_WRCLI_DBUS_GO_PENDING
 #define DAGB4_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB4_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB4_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB4_DAGB_DLY
 #define DAGB4_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB4_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -28737,6 +28767,12 @@
 //DAGB5_WRCLI_DBUS_GO_PENDING
 #define DAGB5_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB5_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB5_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB5_DAGB_DLY
 #define DAGB5_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB5_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -30412,6 +30448,12 @@
 //DAGB6_WRCLI_DBUS_GO_PENDING
 #define DAGB6_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB6_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB6_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB6_DAGB_DLY
 #define DAGB6_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB6_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -32087,6 +32129,12 @@
 //DAGB7_WRCLI_DBUS_GO_PENDING
 #define DAGB7_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB7_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB7_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB7_DAGB_DLY
 #define DAGB7_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB7_DAGB_DLY__CLI__SHIFT                                                                            0x8
-- 
2.34.1

