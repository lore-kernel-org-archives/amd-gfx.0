Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A03C25B47
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 21:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E039C10E262;
	Mon, 23 Oct 2023 21:03:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3666E10E260
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 21:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgx5Zu1Eb96Ei+ZXz8OwUZ5u5GcXeBr0AZyyQcDFERo48eKSciLf+Hnx3tyu/0FdI2sVF6vvndZM7j1ZMjGt3DNS2XV13CapeYtB9GeUYdTStwJWjpMr0sX1VT5hMTGHQwO2FP0j9Q69EhMxjUibqkhF0I0mgby8/4cO518i9DWN8+NcraWVIThR14nG930cyXS674ZRwierCB3asfTHR99lEws1JBTda//KSlmOvI1/tyz6ZSz12ZxgV0PtnKvna4B07yrW/5ZLTfCXDYEHY3sXAZNEyPDPa1aQQlhvXT4qA6i6o0RoI95GmmPG93/DagwPRoqSamnQCQ04d/ywBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9GlINpUL5NMyBMZPHuUs49NS4UP7jvVFxA0T/Emd8k=;
 b=UDjB7D0jGL4VZE3BwmhIxl14X2qj4sPe2byqFg6W0J+hDZKe6T6RRJWEv0nxMz/GuCAxO2kJgDdjK9c9JnlhWpjYBBkUN5w8+bwnjFFx+/jm9x0ICIwcnDJF0h7QUwJA6MJGk0YzyRBVZKHP13cna4u9ImThKpp8eC9hLdbkgyWmUW2Srp4kGdjqwGARfPPhEDB0TPUdsDIIw3iMT14klmW/eQT7NmWUo1X4bavSuHsoG2vhW7rF2KjpqQw6/uDRr9dBHsAGOmNGj8fq4viEa2u4Lxy1j+mSH1NB/Tm+N0XwpuohyPVglOKg9AW61nnDtwhCUM/lgQE/3YwgxTeNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9GlINpUL5NMyBMZPHuUs49NS4UP7jvVFxA0T/Emd8k=;
 b=pleYS8zJ1xbf+fqDfmIf20XSU4W3AH5v1VejVFqXCA5BcP1LCfPWKKVemiKKslvfxg/lrEapkgCwwMfD26zRyy7t+FS4D0jU3YiI1qTM9m8KN5IdQ8uLB4Pi7Zd3hXg5DCD+kJzVuJH3y3NUSaEow5wH+JmeskpiQuSAOCGfwHE=
Received: from PH8PR07CA0016.namprd07.prod.outlook.com (2603:10b6:510:2cd::24)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 23 Oct
 2023 21:03:19 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::6d) by PH8PR07CA0016.outlook.office365.com
 (2603:10b6:510:2cd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 21:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 21:03:18 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 23 Oct
 2023 16:03:15 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd: Move AMD_IS_APU check for ASPM into top level
 function
Date: Mon, 23 Oct 2023 15:58:30 -0500
Message-ID: <20231023205831.511-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023205831.511-1-mario.limonciello@amd.com>
References: <20231023205831.511-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: a683c311-551b-408e-fb34-08dbd40b7b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+c1Or+MmkwyekHt4E5x5MVDbOtIToUTByb51nA+VTqyFYbkvsBBMwUmcQwxC7yZIadwDakA3jhnnSRv/7wKfvJE1j4k4+ID5IEwsLaQNq8mAWv2xBMTOqsu0uu8LMGZA7bqDk4xQiMESSAGOn6WbCUCdDb/PfSdxsctUjHsdhlKOag2LXgGm9asyKRC78X9Moo6mlY+7xKRuhjGAG5oAmTyUBiKVF8EhJQbSV7hNgKzoMquxMnb0ryK0zHPTWZ7jYywRNPXYm5CeZ9KDZQm2XrPTI26QO+ZDrAPqf6bOU/Q8kpPSf5GO2jnNVZQjYGz1Qio3PQBKDBN50/RV83pnxSKswupl+w7On3QpptKb3I2TVFVEAph4dY0eIw/Mnvp81Nq3Z24u1u9XnsfHr7PB7yMqz2oKwElVoafOhh9D/OLUTAZc7dNMW66DIuxKKBPeX4jDtGEgAk3ezARR2591bzvVaRUfV2MFGU95WBArVrnMAN3ZNEc75RO6EBONOERJkJv+GFOKiIrkJonO8bCzBGinnF+szTOiZL8URsAB45e6UDi2H8TwhGd5iUrEVKTllp06EDfK+WIkSgQ+PRElNBLN+tx4defXvSeOrxt7zHJ305QHSZQBciSTlUF9ZhFnftOn+QrNE8fTsFM1ftVOMrawCyASWUEDlf/tUsQeBAKxastkJmxasFKkjU0EDmWekSCzkeg5CTf6ZU1HWJxup95QiL6l6URU8BjtNm2CLw3GKT29jy62HaHqRrbJPZ+hnzFOaRtFrMpZA00ftJllmktiXh5DwXTTY5YZkgyNdM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(47076005)(336012)(6916009)(40460700003)(41300700001)(6666004)(8676002)(1076003)(2616005)(36860700001)(426003)(5660300002)(83380400001)(16526019)(4326008)(8936002)(2906002)(70586007)(44832011)(7696005)(26005)(316002)(81166007)(356005)(70206006)(478600001)(36756003)(82740400003)(86362001)(40480700001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 21:03:18.6046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a683c311-551b-408e-fb34-08dbd40b7b9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is no need for every ASIC driver to perform the same check.
Move the duplicated code into amdgpu_device_should_use_aspm().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/cik.c           | 4 ----
 drivers/gpu/drm/amd/amdgpu/nv.c            | 3 +--
 drivers/gpu/drm/amd/amdgpu/si.c            | 2 --
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 3 +--
 drivers/gpu/drm/amd/amdgpu/soc21.c         | 3 +--
 drivers/gpu/drm/amd/amdgpu/vi.c            | 3 +--
 7 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b345c7bcc3bc..4e144be7f044 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1496,6 +1496,8 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	default:
 		return false;
 	}
+	if (adev->flags & AMD_IS_APU)
+		return false;
 	return pcie_aspm_enabled(adev->pdev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 5641cf05d856..4cd13486a349 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1725,10 +1725,6 @@ static void cik_program_aspm(struct amdgpu_device *adev)
 	if (pci_is_root_bus(adev->pdev->bus))
 		return;
 
-	/* XXX double check APUs */
-	if (adev->flags & AMD_IS_APU)
-		return;
-
 	orig = data = RREG32_PCIE(ixPCIE_LC_N_FTS_CNTL);
 	data &= ~PCIE_LC_N_FTS_CNTL__LC_XMIT_N_FTS_MASK;
 	data |= (0x24 << PCIE_LC_N_FTS_CNTL__LC_XMIT_N_FTS__SHIFT) |
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 1995c7459f20..9fa220de1490 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -516,8 +516,7 @@ static void nv_program_aspm(struct amdgpu_device *adev)
 	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
 		return;
 
-	if (!(adev->flags & AMD_IS_APU) &&
-	    (adev->nbio.funcs->program_aspm))
+	if (adev->nbio.funcs->program_aspm)
 		adev->nbio.funcs->program_aspm(adev);
 
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index f64b87b11b1b..456ca581f517 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2456,8 +2456,6 @@ static void si_program_aspm(struct amdgpu_device *adev)
 	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
-	if (adev->flags & AMD_IS_APU)
-		return;
 	orig = data = RREG32_PCIE_PORT(PCIE_LC_N_FTS_CNTL);
 	data &= ~LC_XMIT_N_FTS_MASK;
 	data |= LC_XMIT_N_FTS(0x24) | LC_XMIT_N_FTS_OVERRIDE_EN;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 66ed28136bc8..d4b8d62f4294 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -646,8 +646,7 @@ static void soc15_program_aspm(struct amdgpu_device *adev)
 	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
-	if (!(adev->flags & AMD_IS_APU) &&
-	    (adev->nbio.funcs->program_aspm))
+	if (adev->nbio.funcs->program_aspm)
 		adev->nbio.funcs->program_aspm(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 8c6cab641a1c..d5083c549330 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -433,8 +433,7 @@ static void soc21_program_aspm(struct amdgpu_device *adev)
 	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
-	if (!(adev->flags & AMD_IS_APU) &&
-	    (adev->nbio.funcs->program_aspm))
+	if (adev->nbio.funcs->program_aspm)
 		adev->nbio.funcs->program_aspm(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index fe8ba9e9837b..1a08052bade3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1127,8 +1127,7 @@ static void vi_program_aspm(struct amdgpu_device *adev)
 	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_pcie_dynamic_switching_supported())
 		return;
 
-	if (adev->flags & AMD_IS_APU ||
-	    adev->asic_type < CHIP_POLARIS10)
+	if (adev->asic_type < CHIP_POLARIS10)
 		return;
 
 	orig = data = RREG32_PCIE(ixPCIE_LC_CNTL);
-- 
2.34.1

