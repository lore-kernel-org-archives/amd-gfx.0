Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD7EC28B30
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 03:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861B610E6EB;
	Fri, 21 Mar 2025 03:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F/0972X/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A876910E6EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 03:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGzijN6/nprWEA3jFHbM7pTGDjN3YdLaH+6NQnIgzDrfRKvhGkTxj2TGRp11OyMYCYm1ij6DJvetIb0y+G84bL+n0ZLBCHscFfKG7xKE5Q+hD2j45D5Q8lCiNZFXWnWhmqX2t5hvOFQpGJoqdEKiY9apvdw9RMqEnDCnyY3dUMVUHnNJsnaWqCn3huMddvE6u2li1jsh7xseu9DZO4sC5rc1V8LabwGCPUJQwWBajGFpM1d0bMJCZO2ZrhzkGWUrIH1WUdqt9CMZu2mkVQdERO3ogH9mPw/CR+hsk+0ibqBc8mBk5ZBRrpGgpoKJKF/K/hbbL0gdUssYQvnf3a9j0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVfuPUz6/c37I8gyhuGhoQs+0rSEerxEvgphfWYj8D0=;
 b=YtEPLKgptGSK/17l4Ip1FF/FWPyo7eH/1z5boJnaLlMvRKzccwDODXQ2WjffeHAxkKubLPDyIzVrg/vTxfUMzNaOvjlBytkWvKw0u9cAKgwbcLySxoN3/a5f9xAfI8oCJ1nEntMBTPeNyI9TYpdYdm/6WcutsPvxgCTgSp3SZb23d+ZMut7TMweB31UCpLHL0fDsqu/unoUWeatZsh6b+7Zo3Mo2KvKk1856fRRDMclBdKjjQAOpS+8Tlfhyg2ao9uAIahMI+dy/xB0HuZK8dX+09TAJxXtjW2+/OZb2OLs+6vagCT+kepTLjBLjr854vDrIw0lNMUSVE3Qqnot30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVfuPUz6/c37I8gyhuGhoQs+0rSEerxEvgphfWYj8D0=;
 b=F/0972X/jHOhyf7XF1E8A633pezAJk/MWNo3GdId3uNhiTIBbcmtlRbJlM9cd5aGELbZ71pmJd5vRqZEUUw2v0/WdZYjHEnjY+kFgCN3kGdGR72b2/BExIgmT1mqwCasNfG18SSls/LlKudeipvAcGpvoYEiIpkCrkLnwNavNzM=
Received: from BYAPR04CA0032.namprd04.prod.outlook.com (2603:10b6:a03:40::45)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 03:27:04 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::48) by BYAPR04CA0032.outlook.office365.com
 (2603:10b6:a03:40::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Fri,
 21 Mar 2025 03:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 03:27:04 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 22:26:38 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v4 3/4] drm/amdgpu: Multi-GPU DPC recovery support
Date: Fri, 21 Mar 2025 11:26:28 +0800
Message-ID: <64beae23b4c6560a02c219f4f8bbc0a7be60cde3.1742526761.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1742526761.git.cesun102@amd.com>
References: <cover.1742526761.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f4e0e0-6a7e-4729-116e-08dd68284066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0VcWxsORuVvM7P6b9K0vAVOlCdK3WSnv5E2z15hWJ+EzmLIAEyXYSYSd6bvY?=
 =?us-ascii?Q?9ZgMxBPv9tb3cMnOHiI9eO/++B7onIEx1euwAFVJv8JCoP6i/N1/lI9gKrWz?=
 =?us-ascii?Q?LCSMbo0siwp+gL4BuTpxDRJJpjmQ7XPc84g3UQrCPVuE995SKgXbnt5pjTGk?=
 =?us-ascii?Q?wI2WU6/z30oBG0fYbDMKBmVF2MEBFkN/gBqS72uLLQneUzfvuSt106D+HTWh?=
 =?us-ascii?Q?cFjHSTDo3dwQIyBog0yUzqnFbtiYMCqkNfNLvHwBuml6wzSCbvFqSWQUqJCH?=
 =?us-ascii?Q?4GirOTYOquLz4Nv1vpo0CjqtqZ/fEbQMCvkCkfI1iBLfpOTmSIUvt+wLRoZD?=
 =?us-ascii?Q?2QNXv4tuHQsJA+aVzHW+Qrkk80vplyljCCcTB0aPOEQa/PCsI/RuFvT1RIpo?=
 =?us-ascii?Q?qWqnlmM74eFNH5ozfrhRBRUcHw4kE2tybiEPoDxafGrh/+8srBBE7dvgDi39?=
 =?us-ascii?Q?B+t70my01Lg/1d5aIWKHaGkitanbJS7L49myIGe+XNI+CZd5MO3BlDjw3lA/?=
 =?us-ascii?Q?9vUWNh2y//00OIkaTy59E+v7Zn5OfUGSb9VBHnglW2NQv+dU9x1jimCSMjEJ?=
 =?us-ascii?Q?zMWPc7OTw+X40AYzVzxOJuR/15f4fSIvQUCzzfPuo7TN2qw6VR9TRo28PE/g?=
 =?us-ascii?Q?2bCAOzJi5mhHAPcadEkhgdE8OxfzX+k1oa2/f2EgZK7YjtCXRTbNV6HTGuIL?=
 =?us-ascii?Q?VdqLJze3X+Z2cRQrAvusTVeP33/VyZNw0+I1/NLbaThS6iKkhJTEmbW3TipI?=
 =?us-ascii?Q?51nvf0hQ9rt1ciCxsu4+iiQF7veWDD+Lt55RYZ3zEA5Id/aTjeRHZw/V9ca/?=
 =?us-ascii?Q?X5ayQtTGdlPUWysC4pMacfJ1riknNEswxiEGpnBeW28SAT/LrkiupipdY18S?=
 =?us-ascii?Q?fZ9YfrZnb16reaS6dX2cSo7Yp2UYUmDARyaTgak6M+9GR8u1jpYvMws2z3wm?=
 =?us-ascii?Q?3tC8Hsjook+IAnykehkNFvr4EJ5Q3o1DibWue3eCtYhQirupdodJsiSWG5hU?=
 =?us-ascii?Q?Yk/E+6ZrdTMarM716J01tCC3U1Pv5j6h6Spgz/GRNlld0G6bdnid4hgRW3cd?=
 =?us-ascii?Q?W2cm0wHHbKYCcLZbcKV6kX+12zQP91y0FsSw8yKQPYFn02kLVKhPRNWvFe78?=
 =?us-ascii?Q?0FNN64l45svvtcoHS97uVvM//pF3EK67BTLyM9EmRYHzTEX0zfdE/dcct6EQ?=
 =?us-ascii?Q?5ujgnVgoSQN4VSCTl2m+BHhPhgja9tC+5Bxie0K/fAre6QaZ08oLwYmv5O8Q?=
 =?us-ascii?Q?N/i7NzJb0+D4bEMTxADKIciuGCBBBS9zIi3kO9ke6xuP5iM1fczsYTQkFbXq?=
 =?us-ascii?Q?TRY/h2xufKWXQJw2QGYFHup6zP8J99mYKwa6BdxvNnJ5799SIst9lWOQDI7k?=
 =?us-ascii?Q?y/38CTFtgJ0hUFaU+YXP5y6BeHu2EmLB08ke2fu1qPpi2NFEoSTEllD2VLoh?=
 =?us-ascii?Q?8tGB2mjiPMG0kSJzhlsOVSJxZHxVW+5gle/oJDseSO7DvARudQ/h1OPz/auz?=
 =?us-ascii?Q?02/lovrm2TtjTUI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 03:27:04.3483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f4e0e0-6a7e-4729-116e-08dd68284066
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
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

Add support for DPC recover based on refactored code

Signed-off-by: Ce Sun <cesun102@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 172 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/soc15.c         |   5 +
 3 files changed, 125 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 774df867ea71..2082be3d2b36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -563,6 +563,7 @@ struct amdgpu_allowed_register_entry {
  *                   are reset depends on the ASIC. Notably doesn't reset IPs
  *                   shared with the CPU on APUs or the memory controllers (so
  *                   VRAM is not lost). Not available on all ASICs.
+ * @AMD_RESET_LINK: Triggers SW-UP link reset on other GPUs
  * @AMD_RESET_BACO: BACO (Bus Alive, Chip Off) method powers off and on the card
  *                  but without powering off the PCI bus. Suitable only for
  *                  discrete GPUs.
@@ -580,6 +581,7 @@ enum amd_reset_method {
 	AMD_RESET_METHOD_MODE0,
 	AMD_RESET_METHOD_MODE1,
 	AMD_RESET_METHOD_MODE2,
+	AMD_RESET_METHOD_LINK,
 	AMD_RESET_METHOD_BACO,
 	AMD_RESET_METHOD_PCI,
 	AMD_RESET_METHOD_ON_INIT,
@@ -857,6 +859,8 @@ struct amdgpu_mqd {
 };
 
 struct amdgpu_pcie_reset_ctx {
+	bool in_link_reset;
+	bool occurs_dpc;
 	bool audio_suspended;
 };
 
@@ -1511,6 +1515,7 @@ void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
 					     const u32 array_size);
 
 int amdgpu_device_mode1_reset(struct amdgpu_device *adev);
+int amdgpu_device_link_reset(struct amdgpu_device *adev);
 bool amdgpu_device_supports_atpx(struct drm_device *dev);
 bool amdgpu_device_supports_px(struct drm_device *dev);
 bool amdgpu_device_supports_boco(struct drm_device *dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9da399626a64..df4e304f1913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3164,6 +3164,7 @@ static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
 	 * always assumed to be lost.
 	 */
 	switch (amdgpu_asic_reset_method(adev)) {
+	case AMD_RESET_METHOD_LINK:
 	case AMD_RESET_METHOD_BACO:
 	case AMD_RESET_METHOD_MODE1:
 		return true;
@@ -5464,6 +5465,29 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	return ret;
 }
 
+int amdgpu_device_link_reset(struct amdgpu_device *adev)
+{
+	int ret = 0;
+
+	dev_info(adev->dev, "GPU link reset\n");
+
+	if (!adev->pcie_reset_ctx.occurs_dpc)
+		ret = amdgpu_dpm_link_reset(adev);
+
+	if (ret)
+		goto link_reset_failed;
+
+	ret = amdgpu_psp_wait_for_bootloader(adev);
+	if (ret)
+		goto link_reset_failed;
+
+	return 0;
+
+link_reset_failed:
+	dev_err(adev->dev, "GPU link reset failed\n");
+	return ret;
+}
+
 int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 				 struct amdgpu_reset_context *reset_context)
 {
@@ -5768,6 +5792,7 @@ static void amdgpu_device_set_mp1_state(struct amdgpu_device *adev)
 
 	switch (amdgpu_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_MODE1:
+	case AMD_RESET_METHOD_LINK:
 		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
 		break;
 	case AMD_RESET_METHOD_MODE2:
@@ -5907,6 +5932,8 @@ static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
 			list_add_tail(&tmp_adev->reset_list, device_list);
 			if (adev->shutdown)
 				tmp_adev->shutdown = true;
+			if (adev->pcie_reset_ctx.occurs_dpc)
+				tmp_adev->pcie_reset_ctx.in_link_reset = true;
 		}
 		if (!list_is_first(&adev->reset_list, device_list))
 			list_rotate_to_front(&adev->reset_list, device_list);
@@ -5916,7 +5943,7 @@ static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		device_list_handle = device_list;
 	}
 
-	if (!amdgpu_sriov_vf(adev)) {
+	if (!amdgpu_sriov_vf(adev) && (!adev->pcie_reset_ctx.occurs_dpc)) {
 		r = amdgpu_device_health_check(device_list_handle);
 		if (r)
 			return r;
@@ -5961,6 +5988,7 @@ static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
 
 		/* disable ras on ALL IPs */
 		if (!need_emergency_restart &&
+		      (!adev->pcie_reset_ctx.occurs_dpc) &&
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
@@ -5991,7 +6019,11 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
 	list_for_each_entry(tmp_adev, device_list, reset_list) {
+		if (adev->pcie_reset_ctx.occurs_dpc)
+			tmp_adev->no_hw_access = true;
 		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
+		if (adev->pcie_reset_ctx.occurs_dpc)
+			tmp_adev->no_hw_access = false;
 		/*TODO Should we stop ?*/
 		if (r) {
 			dev_err(tmp_adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
@@ -6594,12 +6626,15 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int i;
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+	struct amdgpu_reset_context reset_context;
+	struct list_head device_list;
+	int r = 0;
 
-	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
+	dev_info(adev->dev, "PCI error: detected callback!!\n");
 
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
-		DRM_WARN("No support for XGMI hive yet...");
+	if (!amdgpu_dpm_is_link_reset_supported(adev)) {
+		dev_warn(adev->dev, "No support for XGMI hive yet...\n");
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
@@ -6607,32 +6642,30 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
 	switch (state) {
 	case pci_channel_io_normal:
+		dev_info(adev->dev, "pci_channel_io_normal: state(%d)!!\n", state);
 		return PCI_ERS_RESULT_CAN_RECOVER;
-	/* Fatal error, prepare for slot reset */
 	case pci_channel_io_frozen:
-		/*
-		 * Locking adev->reset_domain->sem will prevent any external access
-		 * to GPU during PCI error recovery
-		 */
-		amdgpu_device_lock_reset_domain(adev->reset_domain);
-		amdgpu_device_set_mp1_state(adev);
-
-		/*
-		 * Block any work scheduling as we do for regular GPU reset
-		 * for the duration of the recovery
-		 */
-		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
-			struct amdgpu_ring *ring = adev->rings[i];
-
-			if (!amdgpu_ring_sched_ready(ring))
-				continue;
-
-			drm_sched_stop(&ring->sched, NULL);
+		/* Fatal error, prepare for slot reset */
+		dev_info(adev->dev, "pci_channel_io_frozen: state(%d)!!\n", state);
+
+		if (hive)
+			mutex_lock(&hive->hive_lock);
+		adev->pcie_reset_ctx.occurs_dpc = true;
+		memset(&reset_context, 0, sizeof(reset_context));
+		INIT_LIST_HEAD(&device_list);
+
+		r = amdgpu_device_halt_activities(adev, NULL, &reset_context, &device_list,
+					 hive, false);
+		if (hive) {
+			mutex_unlock(&hive->hive_lock);
+			amdgpu_put_xgmi_hive(hive);
 		}
-		atomic_inc(&adev->gpu_reset_counter);
+		if (r)
+			return PCI_ERS_RESULT_DISCONNECT;
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		/* Permanent error, prepare for device removal */
+		dev_info(adev->dev, "pci_channel_io_perm_failure: state(%d)!!\n", state);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
@@ -6645,8 +6678,10 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
  */
 pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev)
 {
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	DRM_INFO("PCI error: mmio enabled callback!!\n");
+	dev_info(adev->dev, "PCI error: mmio enabled callback!!\n");
 
 	/* TODO - dump whatever for debugging purposes */
 
@@ -6670,10 +6705,12 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r, i;
 	struct amdgpu_reset_context reset_context;
-	u32 memsize;
+	struct amdgpu_device *tmp_adev = NULL;
+	struct amdgpu_hive_info *hive = NULL;
 	struct list_head device_list;
+	int r = 0, i;
+	u32 memsize;
 
 	/* PCI error slot reset should be skipped During RAS recovery */
 	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
@@ -6681,15 +6718,12 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	    amdgpu_ras_in_recovery(adev))
 		return PCI_ERS_RESULT_RECOVERED;
 
-	DRM_INFO("PCI error: slot reset callback!!\n");
+	dev_info(adev->dev, "PCI error: slot reset callback!!\n");
 
 	memset(&reset_context, 0, sizeof(reset_context));
 
-	INIT_LIST_HEAD(&device_list);
-	list_add_tail(&adev->reset_list, &device_list);
-
 	/* wait for asic to come out of reset */
-	msleep(500);
+	msleep(700);
 
 	/* Restore PCI confspace */
 	amdgpu_device_load_pci_state(pdev);
@@ -6710,26 +6744,40 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	reset_context.method = AMD_RESET_METHOD_NONE;
 	reset_context.reset_req_dev = adev;
 	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
-
-	adev->no_hw_access = true;
-	r = amdgpu_device_pre_asic_reset(adev, &reset_context);
-	adev->no_hw_access = false;
-	if (r)
-		goto out;
+	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
+	INIT_LIST_HEAD(&device_list);
 
-	r = amdgpu_do_asic_reset(&device_list, &reset_context);
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (hive) {
+		mutex_lock(&hive->hive_lock);
+		reset_context.hive = hive;
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+			tmp_adev->pcie_reset_ctx.in_link_reset = true;
+			list_add_tail(&tmp_adev->reset_list, &device_list);
+		}
+	} else {
+		set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
+		list_add_tail(&adev->reset_list, &device_list);
+	}
 
+	r = amdgpu_device_asic_reset(adev, &device_list, &reset_context);
 out:
 	if (!r) {
 		if (amdgpu_device_cache_pci_state(adev->pdev))
 			pci_restore_state(adev->pdev);
-
-		DRM_INFO("PCIe error recovery succeeded\n");
+		dev_info(adev->dev, "PCIe error recovery succeeded\n");
 	} else {
-		DRM_ERROR("PCIe error recovery failed, err:%d", r);
-		amdgpu_device_unset_mp1_state(adev);
-		amdgpu_device_unlock_reset_domain(adev->reset_domain);
+		dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", r);
+		if (tmp_adev) {
+			list_for_each_entry(tmp_adev, &device_list, reset_list)
+				amdgpu_device_unset_mp1_state(tmp_adev);
+			amdgpu_device_unlock_reset_domain(adev->reset_domain);
+		}
+	}
+
+	if (hive) {
+		mutex_unlock(&hive->hive_lock);
+		amdgpu_put_xgmi_hive(hive);
 	}
 
 	return r ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
@@ -6746,26 +6794,36 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int i;
-
+	struct list_head device_list;
+	struct amdgpu_hive_info *hive = NULL;
+	struct amdgpu_device *tmp_adev = NULL;
 
-	DRM_INFO("PCI error: resume callback!!\n");
+	dev_info(adev->dev, "PCI error: resume callback!!\n");
 
 	/* Only continue execution for the case of pci_channel_io_frozen */
 	if (adev->pci_channel_state != pci_channel_io_frozen)
 		return;
 
-	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
-		struct amdgpu_ring *ring = adev->rings[i];
+	INIT_LIST_HEAD(&device_list);
 
-		if (!amdgpu_ring_sched_ready(ring))
-			continue;
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (hive) {
+		mutex_lock(&hive->hive_lock);
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+			tmp_adev->pcie_reset_ctx.in_link_reset = false;
+			list_add_tail(&tmp_adev->reset_list, &device_list);
+		}
+	} else
+		list_add_tail(&adev->reset_list, &device_list);
 
-		drm_sched_start(&ring->sched, 0);
-	}
+	amdgpu_device_sched_resume(&device_list, NULL, NULL);
+	amdgpu_device_gpu_resume(adev, &device_list, false);
+	adev->pcie_reset_ctx.occurs_dpc = false;
 
-	amdgpu_device_unset_mp1_state(adev);
-	amdgpu_device_unlock_reset_domain(adev->reset_domain);
+	if (hive) {
+		mutex_unlock(&hive->hive_lock);
+		amdgpu_put_xgmi_hive(hive);
+	}
 }
 
 bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8732f766947e..acd85deb3d58 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -585,6 +585,8 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 		 * Enable triggering of GPU reset only if specified
 		 * by module parameter.
 		 */
+		if (adev->pcie_reset_ctx.in_link_reset)
+			return AMD_RESET_METHOD_LINK;
 		if (amdgpu_gpu_recovery == 4 || amdgpu_gpu_recovery == 5)
 			return AMD_RESET_METHOD_MODE2;
 		else if (!(adev->flags & AMD_IS_APU))
@@ -641,6 +643,9 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 	case AMD_RESET_METHOD_MODE2:
 		dev_info(adev->dev, "MODE2 reset\n");
 		return amdgpu_dpm_mode2_reset(adev);
+	case AMD_RESET_METHOD_LINK:
+		dev_info(adev->dev, "Link reset\n");
+		return amdgpu_device_link_reset(adev);
 	default:
 		dev_info(adev->dev, "MODE1 reset\n");
 		return amdgpu_device_mode1_reset(adev);
-- 
2.34.1

