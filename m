Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7707C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB3510E70E;
	Mon, 25 Mar 2024 10:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rwCt5l2X";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA4F10E70D
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 10:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMnKyMNe2Ff5MgHKyR4FtDIA3EOVtBU/LT6d7BOALsLSimNLVlPj0AtWLc1OCToFCOzHKWplczEECDDAxHXm6+Kb++mOM93pLhCKXSsoaPBfSQdhRBQlLbEEMkmkDkOIT8JhBftqMUhOX2439osQekxbx5VbFm2f9YRoKzOTqNycPTxKVQttiN7RAu15wBy/6G7n8m3Stp3nF9p5AqPlJvmWFo30ZiVe+sUQqdvLVVfihZt7ufoWvU0k2Uhy3BryXehWIH2DcBTLE6J4nBZXUVacGqj24EmAiqL6ngJj2jA+oddMBg+YEpKTlNOqReSChk4s1f/N0fl+5ZqWcY4iPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M34Ya4SOi0lmAXXxpDvxsUPplURysAQoCEv0YgyH2W8=;
 b=i2eg3RxmMRlVO0GSpmiEacWkqNTR5AahhYliQ7iceEL1UKqq8LAuDK1TLrxLDSHpxxYccElVJqULRZ+w1dYIlFOotPSFYwz7QplTU3qeiypfkO2MzGX+HAbfXeUC5FVimTvEU19nO2zEgqyvsllUzwZcJACprpTSpA9c1O1X+ZjUo/O9/eDvUkqnxUqIqMN5CCeYbaKtq3flyJBRAvTAzcbYqZcm3UNTjGCplqG4BhcaXJ2nahNmvkz3vzuj2YQC55OalxV5bk5QZggnYP8AEqL/b9GPY+iHSvuGfyejESmz+bbAZI4+QtK1Km3UKWZvQl9Wcn2SFByvZzJcL0VQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M34Ya4SOi0lmAXXxpDvxsUPplURysAQoCEv0YgyH2W8=;
 b=rwCt5l2XEPDfEPB2MbZEJtjnEvSsWyyGGX16nH1veiAH9A0hNgY64VWU3/3dvzYnJsMNvrOJuvjRRlTcWv1+GNFH+ZvYYaQalgUIqJJik3OlHVBQsRNh+pKIjLbTVdiUHS5pK/Zd1RjEQFN+ykauqEyHyLsRjtQ2Sw9h6U4VuMI=
Received: from BYAPR06CA0032.namprd06.prod.outlook.com (2603:10b6:a03:d4::45)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 10:16:30 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::c7) by BYAPR06CA0032.outlook.office365.com
 (2603:10b6:a03:d4::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 10:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 10:16:30 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 05:16:27 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Add support for BAMACO mode checking
Date: Mon, 25 Mar 2024 18:15:58 +0800
Message-ID: <20240325101559.2807629-4-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325101559.2807629-1-Jun.Ma2@amd.com>
References: <20240325101559.2807629-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d27aa98-5ad8-47f0-47d7-08dc4cb4a3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lh96yfmLRwvF7TDEZxY1d/WET3WMCbnyN3W4Y5VeDGdMUaSMF+Yzo8NAKIX1yf39/6pwNEK1vMVXHRQb6z2brxov9y9mSTbIEQK2BTr7aPsOhrDrflHAREq4d/x9uF+IhNvg1oAN7118w5mAGJsaH4t61TPWnlDARsqjEBGe9wK0MUlunuF9aKANTqGLGIhXRlty3yIYqkcK04xD9oDMO3oWSfhyqDOqXET+HfpmoPqds+QLElH2X7GPwbSekYeND08bcqLJsy6jS/97a2wJTMlEOONn+lStNyjQe7BQqX1v69Bb9X1enn6izf+7ZM+zaRch4LXsjJM8A1gkennE/fDtqtFqc1qCIowEOFsaXE2MbHxx8Pk3YmE8orzTjTIWPp56W7t7KlG8NB06Sr/s8AphG96FlDdrTn3f0D1mlk/cSyJLr1o0Np2WzeisI0cEEKi1FClxsynQqk9dFcPYAtFFXoe/qARJHDcEHgr8QidCDDORyAoY2/yoLOzSKRoFnxhmToIONubxF/Vf3gvCIZ7+3kDIyde3E+5UBulkzuhb7dfjIWzjMZH0qe7kOBO97rybFaC0rYLnzGzYJsGjbD+9njIUATECExrgkuO+JNufbj1eIGpI+3Mg68Xe/zSgriS8zyW84dMcIDJ9qfIL684mwKYyZ9DUig13oxO98pM0+wWBKCx03Ld6Hqm/wPfNdToAA/+iDR+5aYIJNLkc/87YyftV1+6RLZM/3bz65SB8e8iQa50O2Gy90SrXRAlN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 10:16:30.4668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d27aa98-5ad8-47f0-47d7-08dc4cb4a3d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643
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

Optimize the code to add support for BAMACO mode checking

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 74 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  4 +-
 3 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 80b9642f2bc4..e267ac032a1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2734,7 +2734,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
 	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
 		/* nothing to do */
-	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
+	} else if (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO) {
 		amdgpu_device_baco_enter(drm_dev);
 	}
 
@@ -2774,7 +2774,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		 * PCI core handles it for _PR3.
 		 */
 		pci_set_master(pdev);
-	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
+	} else if (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO) {
 		amdgpu_device_baco_exit(drm_dev);
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a66d47865e3b..81bb0a2c8227 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -133,6 +133,7 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 {
 	struct drm_device *dev;
+	int bamaco_support = 0;
 	int r, acpi_status;
 
 	dev = adev_to_drm(adev);
@@ -150,38 +151,55 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	}
 
 	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
-	if (amdgpu_device_supports_px(dev) &&
-	    (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
-		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
-		dev_info(adev->dev, "Using ATPX for runtime pm\n");
-	} else if (amdgpu_device_supports_boco(dev) &&
-		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
-		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
-		dev_info(adev->dev, "Using BOCO for runtime pm\n");
-	} else if (amdgpu_device_supports_baco(dev) &&
-		   (amdgpu_runtime_pm != 0)) {
-		switch (adev->asic_type) {
-		case CHIP_VEGA20:
-		case CHIP_ARCTURUS:
-			/* enable BACO as runpm mode if runpm=1 */
-			if (amdgpu_runtime_pm > 0)
-				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			break;
-		case CHIP_VEGA10:
-			/* enable BACO as runpm mode if noretry=0 */
-			if (!adev->gmc.noretry)
+	if (amdgpu_runtime_pm == 2) {
+		adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
+		dev_info(adev->dev, "Forcing BAMACO for runtime pm\n");
+	} else if (amdgpu_runtime_pm == 1) {
+		adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+		dev_info(adev->dev, "Forcing BACO for runtime pm\n");
+	} else if (amdgpu_runtime_pm != 0) {
+		if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
+			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
+			dev_info(adev->dev, "Using ATPX for runtime pm\n");
+		} else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
+			dev_info(adev->dev, "Using BOCO for runtime pm\n");
+		} else {
+			bamaco_support = amdgpu_device_supports_baco(dev);
+
+			if (!bamaco_support)
+				goto no_runtime_pm;
+
+			switch (adev->asic_type) {
+			case CHIP_VEGA20:
+			case CHIP_ARCTURUS:
+				/* vega20 and arcturus don't support runtime pm */
+				break;
+			case CHIP_VEGA10:
+				/* enable BACO as runpm mode if noretry=0 */
+				if (!adev->gmc.noretry)
+					adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+				break;
+			default:
+				/* enable BACO as runpm mode on CI+ */
 				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			break;
-		default:
-			/* enable BACO as runpm mode on CI+ */
-			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			break;
+				break;
+			}
+			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
+				if (bamaco_support & MACO_SUPPORT) {
+					adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
+					dev_info(adev->dev, "Using BAMACO for runtime pm\n");
+				} else {
+					dev_info(adev->dev, "Using BACO for runtime pm\n");
+				}
+			}
 		}
-
-		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
-			dev_info(adev->dev, "Using BACO for runtime pm\n");
 	}
 
+no_runtime_pm:
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
+		dev_info(adev->dev, "NO pm mode for runtime pm\n");
+
 	/* Call ACPI methods: require modeset init
 	 * but failure is not fatal
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 94b310fdb719..b4702a7961ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2617,7 +2617,7 @@ static int psp_load_p2s_table(struct psp_context *psp)
 	struct amdgpu_firmware_info *ucode =
 		&adev->firmware.ucode[AMDGPU_UCODE_ID_P2S_TABLE];
 
-	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
+	if (adev->in_runpm && (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO))
 		return 0;
 
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
@@ -2647,7 +2647,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	 * Skip SMU FW reloading in case of using BACO for runpm only,
 	 * as SMU is always alive.
 	 */
-	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
+	if (adev->in_runpm && (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO))
 		return 0;
 
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
-- 
2.34.1

