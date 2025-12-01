Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A03D116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 19:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E0610E462;
	Mon,  1 Dec 2025 19:50:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pN0Hc0CM";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C71010E462
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 19:50:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3TX/F6Xm5arI3Oj+NxgoV6/kKr5dNQZWK7DHqsCFLBsmaFXrJvtVo8544/VWEwf85tU5AMscnN5l8iXBE/gGWvPJ+ocjWv4bCfIjGxKrGZrtiCypno9n+H5EOmupgNPvRHR9IqwqzybT6eEePhYkRUeiYAHTEVyzXbkIGP8oQuf4jci5dFa49K+qa0KSQyOo21Z7luh4I/JwGoPZVuwGga0noIpZ0Iz9HXi+TSfyZ7tfwywGMiQlSa54/m7Kgd0/680F4OwMSIdl8SxRbQW9eNtnD21+6bKv60PWGTV8gU19tDCjD2g0rbN14UZPnxOSjmtmd0w/jWjAY2s1Ce2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV/JTtBl09lN0EcNwRevvYlnqzwmf/prt9OavSsA81k=;
 b=UhBEQzLMaushck03sN/wwI+tXsaOhxwCZxSRtRWd3LVn0difCX70zdjx/DPt6joEp5j7baaFTgrvvLMcxZA5zyk2GQT2h9ZpSJ+N4TPBIKKuC88hgTZtT1qd/0IuPOSaAmSQl+Wo5V842aurIKnrZApgEM+WFmBOdOC11FYch4873mr/lw8uxN3zvPORRmDWE2iIGSvu7c6U1FAfeIUAjJeR0p072LLJhJTxxF7xO8ztVzasLpbcfq1E1MFOOQLLv58P3FiA9yRs5T/+SkYbP/KS49hdh191gmYY3y5u17I2s4CFlUo8JPNB65sguVJZ8qhVakMoCBIDgRbdOBQuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV/JTtBl09lN0EcNwRevvYlnqzwmf/prt9OavSsA81k=;
 b=pN0Hc0CMXR5di50q2ukKPrW1Z/1NEQZgBHVc0kXa0t9MGma6SwagyCYsB5OinuJtNRaO4b3EP/iwg+lgD9fJj6gs6iFG5X6rwu9u8UocnOUptq2326fb1FG16i+Phs5LrFdd4do9qtlQ1eiZJlZWWUhrN0LyFr0k3G9Y6MFfxqk=
Received: from BN9PR03CA0242.namprd03.prod.outlook.com (2603:10b6:408:ff::7)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:50:36 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::85) by BN9PR03CA0242.outlook.office365.com
 (2603:10b6:408:ff::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 19:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 19:50:34 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 13:50:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: add a helper for processing recoverable GPUVM
 faults
Date: Mon, 1 Dec 2025 14:50:14 -0500
Message-ID: <20251201195014.3759849-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: ba04a284-39ae-456a-1761-08de3112e440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?92xtxJs4HMBorbpmFfp8ftH5WhwhMSQWmsBNwcV0pEOh/+NshO44b+E/Yb9X?=
 =?us-ascii?Q?9xGn3iot18r3I1v/a11mbsYbP5lzmSz7yNWEDC77TSevypB8ct4fX1HWOz/V?=
 =?us-ascii?Q?dbds1pBTKoY6INGuGsl+PLym6dh0Fpa14qy+dKlaGCH1op8OnSyZvfLQI9nq?=
 =?us-ascii?Q?W0kZYCAGr7KibdOo9yzKhBjtcFq2IXAr8Ez/ZOgu2RRsJxyHqbFD9SofchP5?=
 =?us-ascii?Q?NoWP6ouJE53uP7H/hDbtxR/R51UQpZ7ordYyW9HlaSkG4XHBTa0KBjiC3Qua?=
 =?us-ascii?Q?s1WJqwc9bEGsDPrHTeCbu+S2jhsGVpDaPCRx2gZon/cU/d2eUzpb1Zef7x65?=
 =?us-ascii?Q?8kJ/sOKFpXdQ944tiVOFWmLfVQ8JKhebgh1Q1LT9ZlhVPeSBAkfcVJ/aiOpl?=
 =?us-ascii?Q?7odDTqP1PPmbFRMbGIZY1Z9a30CO3zNbcGATL4YTih0BBSlgBT0yUZIu+hHX?=
 =?us-ascii?Q?w9M7uGRfWsfyLxn7YDP/GQxJS+8Df4mX3kW++jvNZoITms+G3vfeBa29GaRh?=
 =?us-ascii?Q?ZmNmMvgfAowMmhXRfQFFG5p6PqeRLvkTHwdC57JF9NuNqwbZxM4U/Pj+g6Hx?=
 =?us-ascii?Q?VLBDMCribjgxGeW6h4acLNlHtP9SP4W1Tr+M/SG5UC55GHIAe95tV6hUcC+y?=
 =?us-ascii?Q?1YZhLlxe7XzXT/FRRGGU+6NtHN5dH2RZrkFG/YL/dqtnS5I90jHXA5xZ0S1s?=
 =?us-ascii?Q?H2Iqeg8qPHyCvgeDCUUGf+Xm25UQmvZnv4Ns1tgpa8JjxEzf89shgaDZiqu0?=
 =?us-ascii?Q?RNX5Dd2tH9Fi/PSDhaFXDNEAUUZHBidF3ZPYSzgIkLVRA00FUMLTmk/ODVT9?=
 =?us-ascii?Q?IxB/3AnT+YLcS0wWIfeFzTpyIrYKdD0zbtzYq2X2gLkWJk2UUytVQvleTwIk?=
 =?us-ascii?Q?CAXb7DHXf2H4tDdRRlhMsrogFoe+Hop2KXjG/7cJEED4GGBs6pmmwfqsRKjk?=
 =?us-ascii?Q?DZSjtbiTufMY/dx0tJZTJcgNYEeXnohMjiD1XgVf9KT/ahXt8+50b8ldvqN1?=
 =?us-ascii?Q?YjECVTvFkBewbVd3ONmhVb2z0X/GU1FPK2Rl9/cpiTNvWcNsM6fI9y5wNDSy?=
 =?us-ascii?Q?Kpy2zIJ3XZp63OSssNl+NUtEaKIsZTFqdqeteYhBe7nIOTJ9AJZY9V+sC7yX?=
 =?us-ascii?Q?0GrcUotpUSYjv7uaECt5jQSiqcCBPAOZ9tlgTqti7AE0/d+oQ9gOo9Yb2Q9E?=
 =?us-ascii?Q?wdGR4p6NRsxCTLM2cxvhDkP7W5bORcMAVgKSl1C+sVPAE3BMdk2/VuuCUTjp?=
 =?us-ascii?Q?wGsuTuajwuhhGlkHtfmjQmL6xD+aIXA4bXm02j++FIs434In1rjWSl0pA2He?=
 =?us-ascii?Q?Ir2A+0iB4W9g2q9oDb/YyyypVGDv0kU3SoscRtQpcaVpmIUTv/0+Fonh+R4L?=
 =?us-ascii?Q?SCncFBY+ov8HQSDM+p1udorscgiJFormFTdToqDsdEkLPVpXBzRsGfYeVngu?=
 =?us-ascii?Q?4cTRQpDQSSeAHw2v1iTZfu09SEoPC8ILw0w6wxQJ9bZS2Lqw4xuxivvHrUWZ?=
 =?us-ascii?Q?lZsc3HpzD3/IkRz5+kGCeBLUIs2m1lq7rXlzGLEHWBj72GP0gmX+YMdinO/u?=
 =?us-ascii?Q?L0KUFVZJ5KWFzTz92K4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:50:34.1336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba04a284-39ae-456a-1761-08de3112e440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
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

Add a common helper to remove the repeated logic from each
gmc module.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 48 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 23 ++----------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 23 ++----------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 23 ++----------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 43 ++++------------------
 6 files changed, 69 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4abed753fc2df..8ac92e7bed315 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -524,6 +524,54 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 	} while (fault->timestamp < tmp);
 }
 
+int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
+				  struct amdgpu_iv_entry *entry,
+				  u64 addr,
+				  u32 cam_index,
+				  u32 node_id,
+				  bool write_fault)
+{
+	int ret;
+
+	if (adev->irq.retry_cam_enabled) {
+		/* Delegate it to a different ring if the hardware hasn't
+		 * already done it.
+		 */
+		if (entry->ih == &adev->irq.ih) {
+			amdgpu_irq_delegate(adev, entry, 8);
+			return 1;
+		}
+
+		ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
+					     addr, entry->timestamp, write_fault);
+		WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
+		if (ret)
+			return 1;
+	} else {
+		/* Process it only if it's the first fault for this address */
+		if (entry->ih != &adev->irq.ih_soft &&
+		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
+					     entry->timestamp))
+			return 1;
+
+		/* Delegate it to a different ring if the hardware hasn't
+		 * already done it.
+		 */
+		if (entry->ih == &adev->irq.ih) {
+			amdgpu_irq_delegate(adev, entry, 8);
+			return 1;
+		}
+
+		/* Try to handle the recoverable page faults by filling page
+		 * tables
+		 */
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
+					   addr, entry->timestamp, write_fault))
+			return 1;
+	}
+	return 0;
+}
+
 int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index b62fa7e92c79d..e8e8bfa098c3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -425,6 +425,12 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
 			      uint16_t pasid, uint64_t timestamp);
 void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 				     uint16_t pasid);
+int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
+				  struct amdgpu_iv_entry *entry,
+				  u64 addr,
+				  u32 cam_index,
+				  u32 node_id,
+				  bool write_fault);
 int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 47558e572553a..0b385a15194d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -115,27 +115,10 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
 	if (retry_fault) {
+		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
+							write_fault);
 		/* Returning 1 here also prevents sending the IV to the KFD */
-
-		/* Process it only if it's the first fault for this address */
-		if (entry->ih != &adev->irq.ih_soft &&
-		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
-					     entry->timestamp))
-			return 1;
-
-		/* Delegate it to a different ring if the hardware hasn't
-		 * already done it.
-		 */
-		if (entry->ih == &adev->irq.ih) {
-			amdgpu_irq_delegate(adev, entry, 8);
-			return 1;
-		}
-
-		/* Try to handle the recoverable page faults by filling page
-		 * tables
-		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
-					   entry->timestamp, write_fault))
+		if (ret == 1)
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index ba59ee8e398a8..7a1f0742754a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -114,27 +114,10 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
 	if (retry_fault) {
+		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
+							write_fault);
 		/* Returning 1 here also prevents sending the IV to the KFD */
-
-		/* Process it only if it's the first fault for this address */
-		if (entry->ih != &adev->irq.ih_soft &&
-		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
-					     entry->timestamp))
-			return 1;
-
-		/* Delegate it to a different ring if the hardware hasn't
-		 * already done it.
-		 */
-		if (entry->ih == &adev->irq.ih) {
-			amdgpu_irq_delegate(adev, entry, 8);
-			return 1;
-		}
-
-		/* Try to handle the recoverable page faults by filling page
-		 * tables
-		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
-					   entry->timestamp, write_fault))
+		if (ret == 1)
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index dfb06baea1ff1..145fcefd1c783 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -110,27 +110,10 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 		hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	if (retry_fault) {
+		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
+							write_fault);
 		/* Returning 1 here also prevents sending the IV to the KFD */
-
-		/* Process it only if it's the first fault for this address */
-		if (entry->ih != &adev->irq.ih_soft &&
-		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
-					     entry->timestamp))
-			return 1;
-
-		/* Delegate it to a different ring if the hardware hasn't
-		 * already done it.
-		 */
-		if (entry->ih == &adev->irq.ih) {
-			amdgpu_irq_delegate(adev, entry, 8);
-			return 1;
-		}
-
-		/* Try to handle the recoverable page faults by filling page
-		 * tables
-		 */
-		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
-					   entry->timestamp, write_fault))
+		if (ret == 1)
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 778ad7ac6d086..97a04e3171f2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -583,44 +583,13 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	hub = &adev->vmhub[vmhub];
 
 	if (retry_fault) {
-		if (adev->irq.retry_cam_enabled) {
-			/* Delegate it to a different ring if the hardware hasn't
-			 * already done it.
-			 */
-			if (entry->ih == &adev->irq.ih) {
-				amdgpu_irq_delegate(adev, entry, 8);
-				return 1;
-			}
-
-			cam_index = entry->src_data[2] & 0x3ff;
+		cam_index = entry->src_data[2] & 0x3ff;
 
-			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-						     addr, entry->timestamp, write_fault);
-			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
-			if (ret)
-				return 1;
-		} else {
-			/* Process it only if it's the first fault for this address */
-			if (entry->ih != &adev->irq.ih_soft &&
-			    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
-					     entry->timestamp))
-				return 1;
-
-			/* Delegate it to a different ring if the hardware hasn't
-			 * already done it.
-			 */
-			if (entry->ih == &adev->irq.ih) {
-				amdgpu_irq_delegate(adev, entry, 8);
-				return 1;
-			}
-
-			/* Try to handle the recoverable page faults by filling page
-			 * tables
-			 */
-			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-						   addr, entry->timestamp, write_fault))
-				return 1;
-		}
+		ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, cam_index, node_id,
+						    write_fault);
+		/* Returning 1 here also prevents sending the IV to the KFD */
+		if (ret == 1)
+			return 1;
 	}
 
 	if (kgd2kfd_vmfault_fast_path(adev, entry, retry_fault))
-- 
2.51.1

