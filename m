Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80863C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 05:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B238810E843;
	Thu, 17 Feb 2022 05:44:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6A410E373
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 05:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM9ynuFOTYpHB5ehhpSBQp6sa5sssQ7KAkcQT7WVEw3+oZC4XY+k32qQvFCHybUmCDWGGVWLviSMDwHdRU0UJGgPYVdKOfoYPVZ8OGlXHFbqannNgg+VHdtsRBJdh83XveqBo4OJ6U9XzeFwdzWijmz4wsW3xO4ju9wZOuVLhMsv3I/Q/3q7cfnlgeUEZ2sG7RGM/MMJWK+n5LAdDAL730wh6o1eK72DnYaHMojR8IVSRo6TYygK1CfW6fztGzMYH5JWUUA2yu1mG7CjPeMH+O56nvQ6vdSCw6gFiva9nKQBgtAdcbXdfB/Sa2U3t9F4NGJx1dgjDSt9HSUmdZ3E2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaRt6GNr5f9PVj3LoH9l0HN9J6pbsgAI3pgHytn/w7I=;
 b=UocvFzMK6PksqKio6viCkSmq+D3NM1vlXA8ssN6n9Xs5VihO2Jwu+VOeoHTaEe4T9oljpd0aaUpyWJwOaJz7XxoMPgOfyBuvfGlieaCaiogRqu+05zSWArPTrv2JIVouMrLjaSkggZQJA/RdgDzxjZCekE4w1ftOmw9JFt9gQ6nTMJP8u/SD3Gd0Fv8zBtKgv0+BC6rP4qU7VrHzEXAyrPwvTi4SM4lNN/4a6B1k1BDuXTlJL5koRTwdC9k1B9lv3uwDQ66O7mIN7aGr6XxJXnpc67SifaqR6YEtmNL8aFauI2O1Dhb05y7ASvetPCmdmLblDKG0MzNkIaGXALr08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaRt6GNr5f9PVj3LoH9l0HN9J6pbsgAI3pgHytn/w7I=;
 b=CfhIoHrYMvXB/l43VoyObX04xqGWpZYpwIJqXHxZmF7lpbekwRGPmYNr6awewVD3uFpyL9RMzqRbwMikOZfUw2qtJgn/Z5if+jdFrFoHZi8Ev9J5YIbWBbjlQkCmVvSyIoD2nKLbLFIKp1cql/Q0El0/9/0GIp4eWc0GFkMErSw=
Received: from DM6PR02CA0141.namprd02.prod.outlook.com (2603:10b6:5:332::8) by
 MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.18; Thu, 17 Feb 2022 05:44:54 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::20) by DM6PR02CA0141.outlook.office365.com
 (2603:10b6:5:332::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Thu, 17 Feb 2022 05:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 05:44:54 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 23:44:53 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd: Refactor `amdgpu_aspm` to be evaluated per device
Date: Wed, 16 Feb 2022 23:45:03 -0600
Message-ID: <20220217054504.10535-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4e19afc-fa51-4bd3-c4ff-08d9f1d89f8f
X-MS-TrafficTypeDiagnostic: MW3PR12MB4459:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB445928A2537BB78A80A84B63E2369@MW3PR12MB4459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkxusEFM3yZVQKSVnCnoQXsDp+4DYVAPQpNicVbx0Ws4iaO/44qWg4Agpr7+swjWasYBZ03XormmdKbCuBxDG13yuQ/pT+Ya2FXMTsjHg+e2oZ4L9jSElNK8FSC+Gzg1Aa5BYCS+bQJryg0dkAH+BlIN/gfVvXqe7RUS7RcIGsnBDIyuVerye+vmY8TGpuufggWS653sksCJm1vjWw3wYTR6SvN2k/70AiP8u1awNdy9F9oqRYNzNbYIazKsJHstdOe8PlwQBA5ddre3YKPLQxOzTd3m/7CXif4qog/75r0LFG3h88j/pfkmFFdq4mzfNurF8ygvUOOpMkUTo1Ah8/p5Q3Z/TPAmrXypx156nDaugrUmiFvSXefRjBr0PPD9icVoBC6P+EdRBos7igBTM9dg299oreTPgPSoaBcV38Fm0j3a2vhYpFh4fv90PUnY01ubw4qAn0Ks+VG0YPkuWR6jDjgz2xAQ0twUHVjZklw3x5CtFPl8/S2AU2qPs1MXGMVo7WK7Hqs7rrFB4zK3iNzED22BlT3Iuv3gmzJXZ5bBq8uMdJgQO/cJzMOVsQYKT49GKRsa6vh0MyLkn2c1OwQm7bXqilcEhvHaMeDW/Pe7qCjqunQTtTwvKoHQAjBP62y8927i+0s+DSqjfG4JjxZYaRnHVXotTbRerl4HUEs7lWqWExUMpijRfLdsZNonFUl9OGc/X4Po/Wcs9psj9iSVXOgICwTZT8Mbx7nNDHM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(2906002)(70206006)(8936002)(8676002)(70586007)(86362001)(81166007)(4326008)(36756003)(426003)(508600001)(83380400001)(6666004)(40460700003)(356005)(6916009)(47076005)(5660300002)(7696005)(82310400004)(1076003)(44832011)(54906003)(26005)(186003)(16526019)(336012)(316002)(2616005)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 05:44:54.0771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e19afc-fa51-4bd3-c4ff-08d9f1d89f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Evaluating `pcie_aspm_enabled` as part of driver probe has the implication
that if one PCIe bridge with an AMD GPU connected doesn't support ASPM
then none of them do.  This is an invalid assumption as the PCIe core will
configure ASPM for individual PCIe bridges.

Create a new helper function that can be called by individual dGPUs to
react to the `amdgpu_aspm` module parameter without having negative results
for other dGPUs on the PCIe bus.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 25 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  3 ---
 drivers/gpu/drm/amd/amdgpu/cik.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |  2 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |  2 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
 9 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3a126dce8a2f..f0a34aa4af78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1297,6 +1297,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
+bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 
 void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
 				  u64 num_vis_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4667c992a4cc..283d7a7a5249 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1318,6 +1318,31 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	return true;
 }
 
+/**
+ * amdgpu_device_should_use_aspm - check if the device should program ASPM
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Confirm whether the module parameter and pcie bridge agree that ASPM should
+ * be set for this device.
+ *
+ * Returns true if it should be used or false if not.
+ */
+bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
+{
+	switch (amdgpu_aspm) {
+	case -1:
+		break;
+	case 0:
+		return false;
+	case 1:
+		return true;
+	default:
+		return false;
+	}
+	return pcie_aspm_enabled(adev->pdev);
+}
+
 /* if we get transitioned to only one device, take VGA back */
 /**
  * amdgpu_device_vga_set_decode - enable/disable vga decode
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d2548fab51c5..5acd0473ed01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2008,9 +2008,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -ENODEV;
 	}
 
-	if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
-		amdgpu_aspm = 0;
-
 	if (amdgpu_virtual_display ||
 	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
 		supports_atomic = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index f10ce740a29c..de6d10390ab2 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1719,7 +1719,7 @@ static void cik_program_aspm(struct amdgpu_device *adev)
 	bool disable_l0s = false, disable_l1 = false, disable_plloff_in_l1 = false;
 	bool disable_clkreq = false;
 
-	if (amdgpu_aspm == 0)
+	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
 	if (pci_is_root_bus(adev->pdev->bus))
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 8a5642f2daa6..ebed9c84db04 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -520,7 +520,7 @@ static void nv_pcie_gen3_enable(struct amdgpu_device *adev)
 
 static void nv_program_aspm(struct amdgpu_device *adev)
 {
-	if (!amdgpu_aspm)
+	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
 	if (!(adev->flags & AMD_IS_APU) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index e6d2f74a7976..7f99e130acd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2453,7 +2453,7 @@ static void si_program_aspm(struct amdgpu_device *adev)
 	bool disable_l0s = false, disable_l1 = false, disable_plloff_in_l1 = false;
 	bool disable_clkreq = false;
 
-	if (amdgpu_aspm == 0)
+	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
 	if (adev->flags & AMD_IS_APU)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 99a88f4d8050..fe21397323b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -670,7 +670,7 @@ static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
 
 static void soc15_program_aspm(struct amdgpu_device *adev)
 {
-	if (!amdgpu_aspm)
+	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
 	if (!(adev->flags & AMD_IS_APU) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 6645ebbd2696..039b90cdc3bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1140,7 +1140,7 @@ static void vi_program_aspm(struct amdgpu_device *adev)
 	bool bL1SS = false;
 	bool bClkReqSupport = true;
 
-	if (!amdgpu_aspm)
+	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
 	if (adev->flags & AMD_IS_APU ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 4f0bc1841283..d9d634ce9575 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -348,7 +348,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	if (smu->dc_controlled_by_gpio)
        *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
 
-	if (amdgpu_aspm)
+	if (amdgpu_device_should_use_aspm(adev))
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
 
 	return 0;
-- 
2.25.1

