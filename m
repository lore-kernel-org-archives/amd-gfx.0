Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D510CCFA07
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 11:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C826A10E1C0;
	Mon,  3 Nov 2025 11:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Spyr0951";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7610F10E1C0
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 11:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIXAYFiWRsR5ogOc9+xWz3fG0HUTi6IeaCPQke9rLTB8HKTkZNLfcpCLIUfvcLvEgfJ2ju2Q2SraIjgHjXttW0m92VTDKVq+kEWdl60b8m6uKiqH6FMNn5nk8G4TjJsbl8MctAnA9K9XknWsHNu9AGFL3Pm73ocf2C2QIJz+HtuMi8gZAQ8nFE8YwF+Sy2cBBw+ZOfQk5GfZ2hdg7HVoC6tmm2KOxevpnUwr0QosUiX0ia934hRsEW8/GBLJTqruBJJ2fAk2b/bVytEZRyrXGKZHu6rLrg7qg2exL7YOyaMQ3hn7CLJNYpbrnOkgtIUNmn1oWsyITS3YZxecm+uA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1w5sI/gLUI8M7WHDpP8wqEAiKYcg2AuIclrRnqwElA=;
 b=iX7FibNsz2154Rb9UI+TMOJQy+pEKZz3q6azs0fRpF5b8dLNOzaWMUaigoADFzlcV2qjgVDgWLNjsgk6ZcGoHhGa4tfhreHoGC4QIr6b/NA4Sl9kOQOYE+93lVzh/l4UUiIs9/MV4Oc1VPbbutv44mXAGRfM5H5x0IzH1/2bTdYjTrYkRrLKw3TlaTeWe0yg345mjKRTY4PU/0Z22zQSGPvFAMq2Xd89SEJrW703oH/CX0I5d1XiXIENsVYQqiyAzkMt7v4dPTDNvUrbjFyZffQwtELkQzwP0uTrPeiZlDU+qlNT9QjEU5RjwLqQ+aeLXy8sFVZV0S5TN2XMllg1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1w5sI/gLUI8M7WHDpP8wqEAiKYcg2AuIclrRnqwElA=;
 b=Spyr0951Wb8HsIZxx1t+HO7UXurGJgXt0/Xsv8Y+Br3HYNAOm1exEYPvB+LVWij3v+Tgf2Is/Ba1XibJ13fdMdsm7WBigNDPkmn1H63R4fwNNVLFHWiuVYrFOKEb0Da30avd+/aqixd45Ud0Rga4bPujOWdGcaX7CcDBGYqyJRU=
Received: from SA1P222CA0173.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::16)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 11:36:56 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::e1) by SA1P222CA0173.outlook.office365.com
 (2603:10b6:806:3c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 11:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 11:36:53 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 03:36:51 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix wait after reset sequence in S3
Date: Mon, 3 Nov 2025 17:06:35 +0530
Message-ID: <20251103113635.733891-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ea3784-6c0d-441e-898f-08de1acd4959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?olWwy35nkSgHd1+klNpNBwDixMz2Ucqvz7PgbmERhlM3VdQGdGeJj8qdjG8H?=
 =?us-ascii?Q?viZ3kiY8JkUYXZspmMMIGEGlbc8FxOLwvnObVndyGw8c8DIVmCgSLO097iIR?=
 =?us-ascii?Q?qJMpdUwIfWitnBUuCpBoTKfGlhD0zmfy2plJ50tFDk20tSNP75oEDLvPHMo7?=
 =?us-ascii?Q?xMdur45go1+Jy4nb2vDtwqNv19lz122iQT3/yGQM4UiwghvIOUG/9iQ1DVLx?=
 =?us-ascii?Q?4S8eFVC1m9yskVTsj/O43YDYDOuH6vQ3GF1ujmyKhIw4+KKQ50rs5VMad9IS?=
 =?us-ascii?Q?sChkQJ6WB4NzjRJ4T2OOeHWOjls+Cv3RvI49OqW9WYBS+7ctrvORlzJ0z0HP?=
 =?us-ascii?Q?jtE59bInJhbUL2QvUYoA3TSSnNQAbP6z59A3OFhieJXOnovLB/i1yl9uHq4m?=
 =?us-ascii?Q?hEY1d19V79L21EZPsQm2Oqu/78aGYv/wzKACWftg+pCqZI2mBTtlbelszfeE?=
 =?us-ascii?Q?Gmdj5ZFZ10+DYC9xj6b02ednHTmzZddjceCEtmFjico+ndc/C6nwz8ZFcYoT?=
 =?us-ascii?Q?LSeDpP/JkbZDe/rDPVpWVmAJYZ+Gz0aKYON5csnY+T+gz65TWltTHjAc3yfJ?=
 =?us-ascii?Q?b/HCh4rKhLL9AGKH3tH0owJ7v16KcR6RmCOP7pA/Bf3Wc/pSyLYJdBrbvCGd?=
 =?us-ascii?Q?v2dWmxvXRdkXUYpCOBdApw/6rlEyxWo6TimBJiVKwyGMHilAKKHw3z0JNPhq?=
 =?us-ascii?Q?ueejVr5CzBc+RY7uKcg6VsAPgUqsKwRlFmP9h+PXE9pDZ/BNTYt8PKN+kUsv?=
 =?us-ascii?Q?O3hxFjzHAeaAnnd7GrHNrIKJ8nWBWA0cCrN6+wGUf7Z4uiJIljZs3WfPtTUM?=
 =?us-ascii?Q?ypBFBNBsDB6XunuyHd/dD+iZDKtjo+ouyT0qd8aDu8oFpjhy4Lfr9g1edpJq?=
 =?us-ascii?Q?AK54ThMsqY8+sf2YBr0w1Xj5zMyWg0Ddjg64WYBAIJSkbtk811QBDGDW3biQ?=
 =?us-ascii?Q?/FZ8ZiIbU5v5iyh4fKd3hBPeNqhnhrtIHPtxz+tegQfV4zTZiZVxR0erqk9b?=
 =?us-ascii?Q?d5sq1UTm7Bqbow7wPup1J2AQIMQkhRf4nvd/kHQhJE6iepb1vvyCYAMNpvg9?=
 =?us-ascii?Q?hWkuU5fISU5EYyq/VJfbzrNz9lBW8CPfrsckSQIgYi9TQ+XKcZkKpU5S3Kko?=
 =?us-ascii?Q?XB3DVSwUX/MlX1V2OtAdy17MAQ+GBRACp6Ema1veWyogMeMeyb6sUGFG9s/J?=
 =?us-ascii?Q?oSelcoB89kkPdfd7MkLi9HxzHkecPNl970dIa6bijizF5AxFNqvnOSzcQHW3?=
 =?us-ascii?Q?ww9TRpC//u6/Lg+7zP7rNKamDEN4/L+B6iybiz1byMpV8T98dacc2mt6C7ae?=
 =?us-ascii?Q?lrMvMVN1cG5ECX7ie2LwkNoar0Xo8m2oQNksOu7wFimvEnhU/bUtjprUtPn9?=
 =?us-ascii?Q?qlO7/UKGQ2omsJ8HilPib6aut4bTZ4KEu4ZNc2gPK1Ka2JVQwXPEiNSxP9PF?=
 =?us-ascii?Q?mTOsoqsqGv4pxrWZuPo9Lp41bBPH651oDw9vR58w1Wa8XtpbI9x0mKITjoNs?=
 =?us-ascii?Q?jySJpLy12L/6+EY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 11:36:53.3754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ea3784-6c0d-441e-898f-08de1acd4959
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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

For a mode-1 reset done at the end of S3 on PSPv11 dGPUs, only check if
TOS is unloaded.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4649
Fixes : 440cec4ca1c2 ("drm/amdgpu: Wait for bootloader after PSPv11 reset")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 26 ++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cee90f9e58a9..3f42cf7c6193 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2627,9 +2627,14 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	if (amdgpu_acpi_should_gpu_reset(adev))
-		return amdgpu_asic_reset(adev);
+	if (amdgpu_acpi_should_gpu_reset(adev)) {
+		amdgpu_device_lock_reset_domain(adev->reset_domain);
+		r = amdgpu_asic_reset(adev);
+		amdgpu_device_unlock_reset_domain(adev->reset_domain);
+		return r;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 64b240b51f1a..a9be7a505026 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -142,13 +142,37 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	return err;
 }
 
-static int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
+static int psp_v11_wait_for_tos_unload(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
+	uint32_t sol_reg1, sol_reg2;
+	int retry_loop;
 
+	/* Wait for the TOS to be unloaded */
+	for (retry_loop = 0; retry_loop < 20; retry_loop++) {
+		sol_reg1 = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+		usleep_range(1000, 2000);
+		sol_reg2 = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+		if (sol_reg1 == sol_reg2)
+			return 0;
+	}
+	dev_err(adev->dev, "TOS unload failed, C2PMSG_33: %x C2PMSG_81: %x",
+		RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_33),
+		RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81));
+
+	return -ETIME;
+}
+
+static int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
 	int ret;
 	int retry_loop;
 
+	/* For a reset done at the end of S3, only wait for TOS to be unloaded */
+	if (adev->in_s3 && !(adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev))
+		return psp_v11_wait_for_tos_unload(psp);
+
 	for (retry_loop = 0; retry_loop < 20; retry_loop++) {
 		/* Wait for bootloader to signify that is
 		    ready having bit 31 of C2PMSG_35 set to 1 */
-- 
2.49.0

