Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D01C25B45
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 21:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B68710E261;
	Mon, 23 Oct 2023 21:03:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 376B410E261
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 21:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ep5C4tGiYDWlFLEYwmV7o8ivZm5tn2GaCJeiUq7nlZIn2NFrh74Rp6J0Byay9fjddQ7M89ulZu5vmDsjc55yqv7k4TenkTUYzAKge39JRFVEQaV06nmgvlZOm3iRPyAB1ulAdsgmVzxgnXIJbZAgrV5RZ83QnvzAG672phYXvMIW62/AQlrvAbjw+b2gSXo/kkBTybEcurwV9fUQJKPZBz+mKaZAFcJbrmAmSjOW+ELmbX7P48GSZBQcF62AjYaKlNe3/gfJsq4vkUGin0ESFvAcPAlSIpd4Y0tgPtcd121iciMfiuMHcgfOLPkJX6nE94iE/KlYHnJN2Q2pc8sHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEmJXNTI1nKXAnSdURn4rZoo5f0EGLHqT1QMnhoHw+Y=;
 b=WGWWGOWXIwdrPij2iCDH6jFqBU+0Hbg0Vc8Orwqv1v5WGU0YouscZjHHZGqY4O4cLn27aPOIZHI3fA2HlRYgT/HdLgD/w3a8Lf81Wu/sQkhR1r4LUaWAkPhSakKU/rNRj+4A92zPBBIsaYrpkAw26RqfZt1y0NMwWQOcgIXw3YYftNDQ8imtp7qGXbyskpPkPsAdH76u579QXRLhKn+VI0F+a1+7zyhBm+WfF2z5cmeyuEmwo3vM4FvE9Fdlc4Q3A2avQHt9/fbloiD2A42aoAy1/7zhnZQ7ZDrXUZ8VsBlufMO9gOxUWxP+T6ywNyJvfxerCGcjD4EKmY0qodfS0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEmJXNTI1nKXAnSdURn4rZoo5f0EGLHqT1QMnhoHw+Y=;
 b=lpLHM91V1yoVA1zgOAYmT1+83YLwDr8OtlLGr9HXcrQELFqsO9+B7avIwQ6c2IbDLjPFnUijrjUHYLIuiPiHzhfZqpl7ON+5xKlQ8Lj65LjRUPnuUNVT8PYp4YBcfSy4yt8HBV/wOfx2ytAvgTS5tQLy88dDb52clqCbwzwCIk4=
Received: from PH8PR07CA0007.namprd07.prod.outlook.com (2603:10b6:510:2cd::23)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 21:03:19 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::24) by PH8PR07CA0007.outlook.office365.com
 (2603:10b6:510:2cd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Mon, 23 Oct 2023 21:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 21:03:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 23 Oct
 2023 16:03:16 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd: Explicitly disable ASPM when dynamic switching
 disabled
Date: Mon, 23 Oct 2023 15:58:31 -0500
Message-ID: <20231023205831.511-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|PH0PR12MB5450:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e1d304-d21f-4fb1-ce6f-08dbd40b7c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/HzLI5v/wnvfrJh7N8XgUP+Y3l+wXKnUzDjPiuMG+0RC69Bx3NhEyzrlp5j8nfZpqmdUflaNfyro0dqWUyS+F0QrN8a8+X8uU1e/KUeLyBNu39EPascOtTvQ4+UX4PmdM6/nTDScg/zOAKD83dD3R81lNYXyjzERp56KtYcqxVHt3XjrSn6y7IgHJv8A+w+WnIdImD/aDlvTz49+M6F0XK13w5Cw3eluZHRqXa9kBwYR6TRaNxoKSNWxrtu1Hkf2JYAKLimnyjtJOPBAG099RFNbHutZqXadUWaPFwBUPCjlYX99Y4ZQsQ4QT/Cj2QMWYWL8T4tXIcBsPiH9gh5mKs8QQsMj685ThEsHRD1IxaiNwecfIAF4gemUF5J4pxWE2zXTOJoBqSs6IuG0qZ+GQxYfdGoktZk/W8RuTxy58WJEuTqt7uNv+4Uu+OZ66c4H2WBg9y2N3Sy8Bx5lyVse4NCM4f9H3k+bzh794Zyo4wXzViJuw/6ecH0hUDy0SLnf6gmyXyxRDNdiiJtsYn2DHGWgSMaFMFcudysjwMg1kCskfkwYXENHFAbkLWRA1gO6oFJLDUmF9YvbwioTvecyf2uEz/LBwFkjeF0A2zQEupLI+ZMF5wrgWDaslZcE8a7KgyDvMApt1s0qqlRO0LJAJYHC2DVXIDoqFb8qy3AxU1KHoGemh8cHnPuIQOILJbk0qEX6ZXH7cQPDeSxpXSu2PAuRpyN8oa4gBP/8swKIHG547bLUmM6Xp8aLZaJgJmA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(966005)(316002)(478600001)(6916009)(36860700001)(47076005)(2616005)(1076003)(26005)(356005)(336012)(81166007)(16526019)(82740400003)(426003)(70586007)(70206006)(6666004)(7696005)(36756003)(44832011)(41300700001)(4326008)(2906002)(8936002)(5660300002)(8676002)(86362001)(83380400001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 21:03:19.3077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e1d304-d21f-4fb1-ce6f-08dbd40b7c11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
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

Currently there are separate but related checks:
* amdgpu_device_should_use_aspm()
* amdgpu_device_aspm_support_quirk()
* amdgpu_device_pcie_dynamic_switching_supported()

Simplify into checking whether DPM was enabled or not in the auto
case.  This works because amdgpu_device_pcie_dynamic_switching_supported()
populates that value.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++---------------
 drivers/gpu/drm/amd/amdgpu/nv.c            |  7 +++----
 drivers/gpu/drm/amd/amdgpu/vi.c            |  2 +-
 4 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 44df1a5bce7f..c1c98bd2d489 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1339,9 +1339,7 @@ void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
 bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev);
-bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
-bool amdgpu_device_aspm_support_quirk(void);
 
 void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
 				  u64 num_vis_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4e144be7f044..7ec32b44df05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1456,14 +1456,14 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
 }
 
 /*
- * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
- * speed switching. Until we have confirmation from Intel that a specific host
- * supports it, it's safer that we keep it disabled for all.
+ * Intel hosts such as Rocket Lake, Alder Lake, Raptor Lake and Sapphire Rapids
+ * don't support dynamic speed switching. Until we have confirmation from Intel
+ * that a specific host supports it, it's safer that we keep it disabled for all.
  *
  * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
  * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
  */
-bool amdgpu_device_pcie_dynamic_switching_supported(void)
+static bool amdgpu_device_pcie_dynamic_switching_supported(void)
 {
 #if IS_ENABLED(CONFIG_X86)
 	struct cpuinfo_x86 *c = &cpu_data(0);
@@ -1498,20 +1498,11 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	}
 	if (adev->flags & AMD_IS_APU)
 		return false;
+	if (!(adev->pm.pp_feature & PP_PCIE_DPM_MASK))
+		return false;
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-bool amdgpu_device_aspm_support_quirk(void)
-{
-#if IS_ENABLED(CONFIG_X86)
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	return !(c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
-#else
-	return true;
-#endif
-}
-
 /* if we get transitioned to only one device, take VGA back */
 /**
  * amdgpu_device_vga_set_decode - enable/disable vga decode
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 9fa220de1490..4d7976b77767 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -513,7 +513,7 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 
 static void nv_program_aspm(struct amdgpu_device *adev)
 {
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
 	if (adev->nbio.funcs->program_aspm)
@@ -608,9 +608,8 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 	if (adev->gfx.funcs->update_perfmon_mgcg)
 		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
 
-	if (!(adev->flags & AMD_IS_APU) &&
-	    (adev->nbio.funcs->enable_aspm) &&
-	     amdgpu_device_should_use_aspm(adev))
+	if (adev->nbio.funcs->enable_aspm &&
+	    amdgpu_device_should_use_aspm(adev))
 		adev->nbio.funcs->enable_aspm(adev, !enter);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 1a08052bade3..1a98812981f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1124,7 +1124,7 @@ static void vi_program_aspm(struct amdgpu_device *adev)
 	bool bL1SS = false;
 	bool bClkReqSupport = true;
 
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_pcie_dynamic_switching_supported())
+	if (!amdgpu_device_should_use_aspm(adev))
 		return;
 
 	if (adev->asic_type < CHIP_POLARIS10)
-- 
2.34.1

