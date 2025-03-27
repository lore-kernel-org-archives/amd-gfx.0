Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAD0C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 17:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CCF10E130;
	Thu, 27 Mar 2025 17:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ES9EejGj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0179D10E130
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 17:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7OAE7MvVDcyr2Do7atERW5iuB3LQZC6r6kzVEr+rsS2u6COJ8fTqJUITZbFJEmPCQuNJx9u7pQKLeAvUH3ddwIefzk+zcwuUxfyPe6iITJ+mVZcH9R+CIT0SOS/z3HJTZl0MgItOSTLBETkodo5z+VuRlQzXo6WwNH08MVEcySXSd/d7xYF3AMl7nsFaCvs2xRS+zdX8IVj04zQ0klfszkehztph+S0v90Uq9szs7PllZlJUIXY1yiuZj1/+l9cP0DMJQYNBlDPtf+JDDhW1o4ZheVWiHc7M6PqRlrH4/ih0m9ixZv36xwy+RxJbAImHCxy6s8h196JsbD3qD7QXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezpkH8gNZF3aI99SlsSfBkJZ+rTCiYi07SRFdtghkzw=;
 b=wvc2/k5KXzennl0O8tGvdshUxwH0sSXZRXHTsZJ/lDh6SyVDCKp2tnWtnj4q+vlgYFYg066vQVLbY8EyiR7PG0ml5KpYFVb70Ck7V6XXOlpswdXeiBNLaK5ZdHI5oVTJFbM79qj/askwN9jRP9+g3hHYjHx3j4Yso+s2JYF0H2HNM1K5GUhW/bYkkCFT6BXKsJSiGVbXejQ7RFeo86/K/yYwskbmHYFEcL0N/U4MTsqhGROkBDP5AHIGnm16Tu8M8E1EOLwEXOcZwPULdbq0fKuuXukghbEz93o6WuYo0z2LFRkQo35K7xBg+JaewcLMXQTIIsSd6IHe+L3ZzAprwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezpkH8gNZF3aI99SlsSfBkJZ+rTCiYi07SRFdtghkzw=;
 b=ES9EejGjuuXHc7JqiSr7GTB272S+op6a/8XC9EAht/FrhFxJhZsnp/ncZbIeS7bolqHP+0i+rQSCAe3CPoRYXUBeGU3HJuZH7degIebM2fYyZ8/HM/D3t86HV7boaEwxGQ0juBLuzlSpxMt59cUT0Zf/h9dabU3EG5b5FHkstEM=
Received: from MN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:208:52d::28)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.43; Thu, 27 Mar 2025 17:47:55 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::f3) by MN0PR04CA0023.outlook.office365.com
 (2603:10b6:208:52d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Thu,
 27 Mar 2025 17:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Thu, 27 Mar 2025 17:47:54 +0000
Received: from tuf-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 12:47:53 -0500
From: Apurv Mishra <Apurv.Mishra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, Apurv Mishra <Apurv.Mishra@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdkfd: Drop workaround for GC v9.4.3 revID 0
Date: Thu, 27 Mar 2025 13:47:23 -0400
Message-ID: <20250327174723.394804-1-Apurv.Mishra@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: e01aed0f-5940-4e10-c9f7-08dd6d5780a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YfDINDf2EjYE52DUAmSeOzFfqD7qs7YS9GhEH6GoHLpZPkjuKeG9Ox0Xicjc?=
 =?us-ascii?Q?ZENF1RCS6015DEov9ueFrIVJcT88nk4+JG5Wruj0xIp7kZI53u0b32uZB5VU?=
 =?us-ascii?Q?UGxjYpKig2YSBYAeRPXXlra4Iry6N477bEKuCxSeryUs+p9ZiTC1PpbDIG7f?=
 =?us-ascii?Q?PjvLIVqXPD0bX1W5NLm9O2qbf7ly4mSadJyrQouVQ6JtNRJR+uTpt1LNm/ov?=
 =?us-ascii?Q?S9t4c9KAwfSWt0DDHLHX+DabtOu/T1OoP8EAVEydC7RfCv408a/lD4M+KLjx?=
 =?us-ascii?Q?WIYLq0CCYthFjSijlH8W5mr1cB34hVy19+XMmeaMqg1ORlmhmfAV6ImLFVzq?=
 =?us-ascii?Q?U4jBAsdNqbwSwr3EaM092ht3boZNQn/tx2WY8VHHq0zUq3eHxijd6mJDwog1?=
 =?us-ascii?Q?9RE3NNwemWdrXOFZuqNXe+IZ+oiH8pdxeyGEqJLt8u9tXXkoDoBIW5/jseQk?=
 =?us-ascii?Q?LlkMN/K2gE1iPxS2TxtHmrQwiLTfWZV8VGefN+RQWZtX/6ow/43w5KXRtb0/?=
 =?us-ascii?Q?ZE1pAYD0GLm75ngy9U9zigw80cJaFi8UUx1oR9z4sXeFtyssMsZjpysPQu8Q?=
 =?us-ascii?Q?sP/7K0RT6FGHCnlUMeAV6aRHkY06Hts2ay2+3cLNKaVSbqYBB7cKWiWAD7kF?=
 =?us-ascii?Q?uN38G645rp0aJGMKnSdajIh4CfoVUpwyOjJ08kVkRihsiJow1jlOk5iehNkU?=
 =?us-ascii?Q?QbhmLwEdY+wqd5uU429Rz4d1fOS36oWsFUnqEDsGdI86ZW+ShVD12X2ymz1J?=
 =?us-ascii?Q?pCAgAwSlYLMHAk4yLtetB0nU51eG8sSSpM3YpyCxoM97AdiDvwGcjrjBlRhi?=
 =?us-ascii?Q?+npAQ0U+jnl3NBXxMHZvBU+TrY3/MAHouT5Z608mxaghwb1+WmfVSQ5XtcCE?=
 =?us-ascii?Q?ZI3yvq0w7EKC3dBD3OhrIN119wSaKetTf0QRx7hujM9SNC6avlWAt7tD/jQ/?=
 =?us-ascii?Q?un4EV2tBXKmJTnov+aJxmqSMIwpiD3YnJFngTMjqV6/rJjAi9ksfU2PoKa0o?=
 =?us-ascii?Q?JGlpHWxDP193di3POYDw3OvsX2j7VZbL7pdPIYJ1agePzxQj40mWXGrbfXkL?=
 =?us-ascii?Q?rPh53p5wAv5RQVJpbYbvhczM2L8obkgITlzSDZMeCH3qM+H7UJvAfZA6GyrW?=
 =?us-ascii?Q?8FGaSKnegHfcwPgCEyQY6xMoXkYsVETIxhx6girH1ANwdsBgLpImkzVRfemk?=
 =?us-ascii?Q?aJpmFN6TX4p7oUOAhY3cgEahFIg8Z84c3FyQt5F0BYaPGMMvzss2BMFhu4+i?=
 =?us-ascii?Q?AD1XBIHQAN41Ltm+gOvNY+aO86EeHtkSGfXgI1yXMe3e2wDzzzLkHJfo8Wbq?=
 =?us-ascii?Q?DTSYB2vScOq1JXA/vuIErGTffcLCZVPGwPyn13rIPcsXeuUCMck8yXviR8eP?=
 =?us-ascii?Q?tA6ONl8NCDu8pzUsw/pVFBbzM2YbERJUT5+zkc0mfnxExFLzXmlCS9LGAFn1?=
 =?us-ascii?Q?UOII4a5VqxUbl/8xoQPbcJInRMcmxtPfoj39kVTQsHloN2cCP0bzONFSmvXB?=
 =?us-ascii?Q?Lwzb/pHCw4LwQIA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 17:47:54.4116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e01aed0f-5940-4e10-c9f7-08dd6d5780a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
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

remove workaround code for the early engineering samples
GC v9.4.3 SOCs with revID 0 - GFX 940 & 941 - from driver

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 14 ++------------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    |  5 -----
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c     |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       |  3 +--
 5 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d4b01ef00025..81d314f2c689 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2692,6 +2692,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		break;
 	}
 
+	/* Check for IP version 9.4.3 with A0 hardware */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+			!amdgpu_device_get_rev_id(adev)) {
+		dev_err(adev->dev, "Unsupported A0 hardware\n");
+		return -ENODEV;	/* device unsupported - no device error */
+	}
+
 	if (amdgpu_has_atpx() &&
 	    (amdgpu_is_atpx_hybrid() ||
 	     amdgpu_has_atpx_dgpu_power_cntl()) &&
@@ -2704,7 +2711,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
 	}
 
-
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
 	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 783e0c3b86b4..8d3560314e5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1213,10 +1213,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		if (uncached) {
 			mtype = MTYPE_UC;
 		} else if (ext_coherent) {
-			if (gc_ip_version == IP_VERSION(9, 5, 0) || adev->rev_id)
-				mtype = is_local ? MTYPE_CC : MTYPE_UC;
-			else
-				mtype = MTYPE_UC;
+			mtype = is_local ? MTYPE_CC : MTYPE_UC;
 		} else if (adev->flags & AMD_IS_APU) {
 			mtype = is_local ? mtype_local : MTYPE_NC;
 		} else {
@@ -1336,7 +1333,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 				mtype_local = MTYPE_CC;
 
 			*flags = AMDGPU_PTE_MTYPE_VG10(*flags, mtype_local);
-		} else if (adev->rev_id) {
+		} else {
 			/* MTYPE_UC case */
 			*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
 		}
@@ -2411,13 +2408,6 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.flush_tlb_needs_extra_type_2 =
 		amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0) &&
 		adev->gmc.xgmi.num_physical_nodes;
-	/*
-	 * TODO: This workaround is badly documented and had a buggy
-	 * implementation. We should probably verify what we do here.
-	 */
-	adev->gmc.flush_tlb_needs_extra_type_0 =
-		amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
-		adev->rev_id == 0;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v9_0_init_golden_registers(adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b9c82be6ce13..bf0854bd5555 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -352,11 +352,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			f2g = &aldebaran_kfd2kgd;
 			break;
 		case IP_VERSION(9, 4, 3):
-			gfx_target_version = adev->rev_id >= 1 ? 90402
-					   : adev->flags & AMD_IS_APU ? 90400
-					   : 90401;
-			f2g = &gc_9_4_3_kfd2kgd;
-			break;
 		case IP_VERSION(9, 4, 4):
 			gfx_target_version = 90402;
 			f2g = &gc_9_4_3_kfd2kgd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 4afff7094caf..a65c67cf56ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -402,7 +402,7 @@ static u32 kfd_get_vgpr_size_per_cu(u32 gfxv)
 {
 	u32 vgpr_size = 0x40000;
 
-	if ((gfxv / 100 * 100) == 90400 ||	/* GFX_VERSION_AQUA_VANJARAM */
+	if (gfxv == 90402 ||			/* GFX_VERSION_AQUA_VANJARAM */
 	    gfxv == 90010 ||			/* GFX_VERSION_ALDEBARAN */
 	    gfxv == 90008 ||			/* GFX_VERSION_ARCTURUS */
 	    gfxv == 90500)
@@ -462,7 +462,7 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
 
 	if (gfxv == 80002)	/* GFX_VERSION_TONGA */
 		props->eop_buffer_size = 0x8000;
-	else if ((gfxv / 100 * 100) == 90400)	/* GFX_VERSION_AQUA_VANJARAM */
+	else if (gfxv == 90402)	/* GFX_VERSION_AQUA_VANJARAM */
 		props->eop_buffer_size = 4096;
 	else if (gfxv >= 80000)
 		props->eop_buffer_size = 4096;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 100717a98ec1..72be6e152e88 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1245,8 +1245,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	case IP_VERSION(9, 4, 4):
 	case IP_VERSION(9, 5, 0):
 		if (ext_coherent)
-			mtype_local = (gc_ip_version < IP_VERSION(9, 5, 0) && !node->adev->rev_id) ?
-					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_CC;
+			mtype_local = AMDGPU_VM_MTYPE_CC;
 		else
 			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
 				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
-- 
2.43.0

