Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90122C7EE32
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Jun 2025 07:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE6410E152;
	Sat, 28 Jun 2025 07:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jGoH98+8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3659E10E152
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Jun 2025 07:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLowHXqb7QvdiDzeaVKesJnNuemcjcXGYHUeyEjjKU8eVetcwk6AfAhZ7qyhn5uzQLqIWhtRqGMxe/FuV5KcG3pehI4HW4mIUcREl+BSj/8upTcN25OQg0su4XzAFp/fLAuPpT7EcZeR20sBNYTlU+VZX3ptUVDvRkUlGVD7p9lwwMK5odx5oTvQm2INssUrMkoYx3CnkJgIrqR/AckDWa3jlHInk1sQlEn4dhzbZIxtylp3RSs5TopEAirdhlDgAgJLv3S4h78yEz4QhTjGDneWPPQU9Zld5MoYBiauujgO5lgmD+qoGRj/hn40bvVyKqmzKtAia8YMCDB9I0SWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDp0GTIqUOZQcSFhn/1INVAyZtEI998oS5KmIGUyAXU=;
 b=kRaqE7oIC9LUaIwSzeR8v36ysCLHVnh+rsyODGgguYiYGoxIRg7UhX+JsPWjbxLM8iTP5d19cEUgSPaaeQXxmSnhDnsR1+AVQHxXVYK0Bv5WfNYILeDQ95B6c7oUtRbE2FytbPdrmVIL0jXcuygYdJxvLADPOtMtVv92zX6ed8ODKWWFcRATF0XRA2bmtpa551l/GAApZMTc8UtP11/QGYQp+G+IdESqPd8FSMhe+R4q6kBUeEL9a8ppxE9oACCrnFXCPicNM8+lV7eipjqTNq1582w+kPE7449YcTM9x8HGr1iQE7S9D0R53ohxeM/UBawEzVPK0dlfxirk641zFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDp0GTIqUOZQcSFhn/1INVAyZtEI998oS5KmIGUyAXU=;
 b=jGoH98+8oGSp0D9oiyA11EnjHduj/JRFfMCPATwaUnUJzZ8PjBbYBHx+DSc0EDwYKVUNbOLpW99R/Sg0sPZrkZtAiviI0FNuOcLg4SVQVSDNzq3ItcEN2SnsGQ87P6VEpxodDLoZoQ9nRtaJSOGAUANpHzmb481Ekp1kls5CPqs=
Received: from CY5PR22CA0012.namprd22.prod.outlook.com (2603:10b6:930:16::32)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Sat, 28 Jun
 2025 07:32:04 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::17) by CY5PR22CA0012.outlook.office365.com
 (2603:10b6:930:16::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Sat,
 28 Jun 2025 07:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Sat, 28 Jun 2025 07:32:03 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 28 Jun
 2025 02:31:59 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: Fix error with dev_info_once usage
Date: Sat, 28 Jun 2025 13:01:43 +0530
Message-ID: <20250628073143.1249393-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 091b8405-b540-416e-ba3c-08ddb615e09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CF6nxfvNtw7mQg56U6ZmQQ9GSujkdjSWtiMam6XvK9I2o1p1E6kpLfudOoKf?=
 =?us-ascii?Q?i8X3KKfU1iioXEiyZlyIJK9ouocSUVeXVwDk0jccIY3q2uXvJXiO+eVzofH5?=
 =?us-ascii?Q?VTRVbblzloX7nJy12LgXG7CVwH0vltBNunRlBtoZSCrw0iHqAnTi+EfpSIb9?=
 =?us-ascii?Q?F+geMWLVNDNsKc4gVgSemSWdlP1sbw5r0adVCHn7md3xYY4dDnV32ajEeA4P?=
 =?us-ascii?Q?FKu2cUnxQs68vDLrST2olHFmNl6I6RX1Zyw1f6iMJpJEIu7XxN4n6h9dXb4s?=
 =?us-ascii?Q?Hkfkc9avSF7d79H6KhPXKt8lH+9KsqFCxfwOXDIUEzhW8PmmPkOvYHCFjHBg?=
 =?us-ascii?Q?c3PWCkVF4qlmKFL7ZP1vOR4PixaVrdITZqmhJOmgD4lWNNC3yRYqBoXMmVP4?=
 =?us-ascii?Q?ogU8s1PCPUTU4H1LvtpPSB/KVjbmhQhb3E+udpCHLVRCfRkL4gAGeriJclz5?=
 =?us-ascii?Q?fMy5TJ6CTV7+0KCib4DnrJZL0a9qreCpCzQ95ANvJke1+O+49t7BuKLnE/gX?=
 =?us-ascii?Q?uR7pQzIw1AZqBhW94lbeOgTj5PkKrRK65qKx2e2au2cJbxkKFM3DIGIrk9/2?=
 =?us-ascii?Q?cimTlVpv4S7uuWzQr00+wrbYUemqZDwkN1pp5gprEGftBpy3SLp55430bSe+?=
 =?us-ascii?Q?+5NPyOFne2LVozjePcuBypXyctdZL7Rq5T8BDr/FBpGhv+dUAb26l6Qtbtys?=
 =?us-ascii?Q?hcXg6lgt7rXj1nsm9pzncsCTW3u2heCkaO1j4nPV8vSm2MlisL500Qt0Xuex?=
 =?us-ascii?Q?H77WWhWet1mgx7vZ1TrBbVcMqREOI+QJnADvLQpWhU3JxpKzHrQt6wHCYFHo?=
 =?us-ascii?Q?bfk7nH28lh2jqGyb0Sewlx+bSjbrJuJLx6ZqCdVFA7G6XiaJfTfIMKMJynXb?=
 =?us-ascii?Q?reCVkGK1Lp5W5nPV0qS0EHly/rtksA9PkNAc4JZGex50doAtmo+59YzASSUB?=
 =?us-ascii?Q?+Kubzi/8jw7ABWKE9hTWGdONKNLNLIjSQVf7SzQ36p7ljnqs5if5pt2OnDaR?=
 =?us-ascii?Q?Y0z9pkXYCJRl3sUAlo7WodjC4mLDVfin4HLFxp+jPTbpt2bQGkbhjko+PmlB?=
 =?us-ascii?Q?Wjp+JLviS9makyirEIgMzKrg6a1XZaVFatGFGIYmaPzXRhj3jPgbhWYbnHVc?=
 =?us-ascii?Q?IYIbNxf3BDb9oXGGSV7UJsN9VOoL1EHOEPrH1JYsiENyEc8X5gSJEe3xpnto?=
 =?us-ascii?Q?2lw83+NR7w0UVsE27gKlcYEQ47iZKZJng08IezgCzOsKnD/SKUWyQ72KuPTz?=
 =?us-ascii?Q?VzIW5TVNm7vjzWm+w4xIqEIiCcUrjGzG5aix/isnldv3cqPsBPqvxbLujLJt?=
 =?us-ascii?Q?qYTabgZHSJKJJCe21tULldhoTsdsNMYBfPnXKy817n9gbMNekjbiFotAMaAO?=
 =?us-ascii?Q?jaNu9HbHyqFKHq3SaPDSVl6BVR3PhJV2ahXhs+cPEwZ941yd5nn7Aogf/u68?=
 =?us-ascii?Q?/I3cm/mAaU+oIy4beW8FyfVt1P/KrlCTOE19druUFVhtbK2WxNfyuyo3LSkX?=
 =?us-ascii?Q?fbYWFXCK8BIm2Vcv0QYPdK1fIsNeF+BifGscxdKp6daAZZgDZnqFnzFjIQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2025 07:32:03.4536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 091b8405-b540-416e-ba3c-08ddb615e09c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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

Fixes error with dev_info_once usage in amdgpu_device_asic_has_dc_support.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506281140.mXfWT3EN-lkp@intel.com/
Fixes: f408cc771c33 ("drm/amdgpu: Convert from DRM_* to dev_*")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7427986992d6..1b61e0d27ce2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1390,7 +1390,8 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev,
 				   u64 reg_addr, u64 reg_data);
 u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev);
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
+bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
+				       enum amd_asic_type asic_type);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
 
 void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 334e442c95ef..95e9f7285351 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4099,12 +4099,14 @@ static void amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev)
 /**
  * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
  *
+ * @pdev : pci device context
  * @asic_type: AMD asic type
  *
  * Check if there is DC (new modesetting infrastructre) support for an asic.
  * returns true if DC has support, false if not.
  */
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
+bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
+				       enum amd_asic_type asic_type)
 {
 	switch (asic_type) {
 #ifdef CONFIG_DRM_AMDGPU_SI
@@ -4148,7 +4150,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 	default:
 		if (amdgpu_dc > 0)
 			dev_info_once(
-				adev->dev,
+				&pdev->dev,
 				"Display Core has been requested via kernel parameter but isn't supported by ASIC, ignoring\n");
 		return false;
 #endif
@@ -4168,7 +4170,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 	    (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK))
 		return false;
 
-	return amdgpu_device_asic_has_dc_support(adev->asic_type);
+	return amdgpu_device_asic_has_dc_support(adev->pdev, adev->asic_type);
 }
 
 static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2bb02fe9c880..b299e15bb5e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2327,7 +2327,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		amdgpu_aspm = 0;
 
 	if (amdgpu_virtual_display ||
-	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
+	    amdgpu_device_asic_has_dc_support(pdev, flags & AMD_ASIC_MASK))
 		supports_atomic = true;
 
 	if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) {
-- 
2.49.0

