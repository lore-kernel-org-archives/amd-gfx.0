Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D72C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 22:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CFBB10EAFB;
	Wed, 26 Jan 2022 22:58:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A9A10EAFB
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 22:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsRDJ/I3dlzUmGgLZDQc7A+pJWZDOGJZuc58sN99RnPuAxVu65VZM8D7wqhHSZCpNQU8Bl/8FAojii8zGnaVGpOmCKn3H7BvHYp3i73dcTRFXXkXtXdZKtHaOhTSUfCqt5lKPrcjsib134V1rrBZstsgDkLVMs/x6hP0Ss5eGyTGXkXH3TWjn72SajgmmuKm+C3MfGoBpbH5ukc60MnSRJ+ki7GIko8kCP8wiVa6P33R+JGTF5PZYSB8R1Jf97b8F/wWcuknMU9Giarh3lWxvceQkseZBnVviVUmqy8nGt5vAXzq9GyxcnFtmlLwL1zBeZJ8Bt7uxAv3hkUsytqtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH6bpuicxAn4GMuFE4EOI3ntvxGJlWsBVmx0kSuS+zU=;
 b=BTJCCYPCBaIBX/QNLgwBHdgtwrWTTvJy0PEWqnkQehSLV8pSTzkiC/EdzswcVA2cqKtScLGjZi5UxA/byalkTODobHLQ45Rc6gpOuFYGKHEq50iNiv5Pn8HpKfXihJ+ZaY4lNGyviryllFlO992vlrW7fmBVtIG7I7fDLgPhXg0DuZt1+DQmu9EFd9l84qetDXCU5ZsHbDv8jkIfxX9cjy2qdxlsdIMTMdsEGDx/d3A087cO5RzPTQ/DXq4NBUh3wQ9GsynIk7+InAwuVFFpo46io+Rxq+3lnnrR0adl/M8GT3mapxvQ+CzPrsvwkzx0JuZGZnbcZepbvC/1LXvsyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH6bpuicxAn4GMuFE4EOI3ntvxGJlWsBVmx0kSuS+zU=;
 b=YVuVrP1aq3no89BubL0QariKkSK1aQW51YtothUH+dc+UQghRiRZzrNGW2iDMXgRrFI0A2qLh3+vAqoRZUtM1jGk2+fbtO21TV5J8WTgWqG0zpxyq8UkXWP64yG+RjkzmE/KgOiLXuKoFR4Ny8G6ZLE4PawJaF7sbum3xN5ueEs=
Received: from DM5PR19CA0013.namprd19.prod.outlook.com (2603:10b6:3:151::23)
 by MN2PR12MB3375.namprd12.prod.outlook.com (2603:10b6:208:cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 22:58:22 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::9c) by DM5PR19CA0013.outlook.office365.com
 (2603:10b6:3:151::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Wed, 26 Jan 2022 22:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 22:58:22 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 26 Jan
 2022 16:58:21 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 2/4] drm/amd: Warn users about potential s0ix problems
Date: Wed, 26 Jan 2022 16:58:29 -0600
Message-ID: <20220126225831.16732-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126225831.16732-1-mario.limonciello@amd.com>
References: <20220126225831.16732-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 697ee292-5882-4b5a-bdb7-08d9e11f5a2d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3375:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB33758DDBE6BE1FBFCC72EEFEE2209@MN2PR12MB3375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KQT6/pfUEiVbVLiKT/Bem97uQvFta6CQc+yHX5VSo1ExiDGk4KFM61JrgFG/cVp1crWzEuYV6LCX9el4sgUjUpTZO5FZzewtoMvRMn8ZrpfJmxQXrLi7K2ioRNzhY1IfSGZcuxB7eEXfR3dKjYZodhqJU11f2r+vHQkdSpQYH1GIsU0oULWkzhy6G0PZcjGZ7uA9YtYawV+1UyyHrABzBDVq5aVSD8CPz4g2Nbki+DJJNI98wJBsnoWG7OZs70pnNi3DWCqukd50y9OSSQ+gACc4WapfECdpRougBqQChH5ssTndFKRVYOhrlg1UHgqY05hOkoBa5QcnhkCcwz0Y21zi65yLO8Mf4+DnebdsXoRqe8nrJZFePFShCBD4HvOMuiSnx2r5YAmrIvuNDgRmxdQBJk7DDbLnQb5FjArlkGREyCIwq4qU9KgIUCp1JgE2cpjJlZf0fT5zkPaLeOdm38khvd/Yopbi+LQSONBCow40XjG3uK4+3lf7yqwiWxvUbdA4h+DsH39HtQH2IoI7lCXe32kg00gcQamWBsWZl+mq5KRMR2dw7GyF6FVb9rOCB7LpwuMxkvrjsCgej0B5pFplYWK9viHGjIfkO3OwWCX+tnztswSp7y4pdExkFoPxQu6DX6T1Z/5FhZ7Qd7iufPRa8txIz1QAOfE5/sMSZWFxYRFTdZwnslC0rWDqwhfUirGYTkzuS8BaS4Umcj93wX9iXYahMSfB/aQi6Iv7TvhlMxVswnl87jtZwajGK5fa+B1h2E0t7/bK8D6BmSEu9hl+IGn1vTV1T81Sj1lOAU5AdmQw/5C3KoczDwOvlPq3m1W/rRkzq6D4e7MrZuThQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(426003)(70206006)(70586007)(4326008)(2616005)(40460700003)(82310400004)(2906002)(47076005)(1076003)(5660300002)(966005)(83380400001)(81166007)(508600001)(356005)(8936002)(186003)(86362001)(16526019)(336012)(7696005)(36860700001)(44832011)(6916009)(54906003)(26005)(36756003)(316002)(8676002)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 22:58:22.1725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697ee292-5882-4b5a-bdb7-08d9e11f5a2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3375
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>, Prike.Liang@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On some OEM setups users can configure the BIOS for S3 or S2idle.
When configured to S3 users can still choose 's2idle' in the kernel by
using `/sys/power/mem_sleep`.  Before commit 6dc8265f9803 ("drm/amdgpu:
always reset the asic in suspend (v2)"), the GPU would crash.  Now when
configured this way, the system should resume but will use more power.

As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about
potential power consumption issues during their first attempt at
suspending.

Reported-by: Bjoren Dasse <bjoern.daase@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * Make CONFIG_SUSPEND wrap around entire function to make more readable
 * Return false if system not properly configured (relevant with later patch)
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 24 +++++++++++++++++++-----
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3bc76759c143..b1db703753f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1409,12 +1409,10 @@ int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_ss ss_sta
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 
 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
-bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 void amdgpu_acpi_detect(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
-static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
 static inline void amdgpu_acpi_detect(void) { }
 static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { return false; }
 static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
@@ -1423,6 +1421,12 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
 						 enum amdgpu_ss ss_state) { return 0; }
 #endif
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
+bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
+#else
+static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
+#endif
+
 int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 			   uint64_t addr, struct amdgpu_bo **bo,
 			   struct amdgpu_bo_va_mapping **mapping);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 4811b0faafd9..b19d40751802 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1031,6 +1031,7 @@ void amdgpu_acpi_detect(void)
 	}
 }
 
+#if IS_ENABLED(CONFIG_SUSPEND)
 /**
  * amdgpu_acpi_is_s0ix_active
  *
@@ -1040,11 +1041,24 @@ void amdgpu_acpi_detect(void)
  */
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 {
-#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
-	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
-		if (adev->flags & AMD_IS_APU)
-			return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
+	if (!(adev->flags & AMD_IS_APU) ||
+	    (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
+		return false;
+
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
+		dev_warn_once(adev->dev,
+			      "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"
+			      "To use suspend-to-idle change the sleep mode in BIOS setup.\n");
+		return false;
 	}
-#endif
+
+#if !IS_ENABLED(CONFIG_AMD_PMC)
+	dev_warn_once(adev->dev,
+		      "Power consumption will be higher as the kernel has not been compiled with CONFIG_AMD_PMC.\n");
 	return false;
+#else
+	return true;
+#endif /* CONFIG_AMD_PMC */
 }
+
+#endif /* CONFIG_SUSPEND */
-- 
2.25.1

