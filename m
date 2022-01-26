Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95192C28CF5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 04:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6623810E514;
	Wed, 26 Jan 2022 04:09:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC5A89ADC
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 04:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BF/h4wZlzDcCIi+TZ8wPoWxc5nGOaPiCX6cUpoNiNe/iGsT15nxPbXfrH3R4R+lp674jCv1lcwoT1Xombd2pY3mN2uk6mlMB4sF47eYKx3uNKTpZT+Ur7s6mpAuCxaP7F+lB3OwGZkbUpGcoSPZW2x2+rTvwRhZpqllk3Q/9jnxWI3zK3xLEB9aT8ApY36xTH7B8VInNenmhHEn9OgzTiC74nkX/vXiN4t7RZVLZ8B5bqWZOCrdN/kXk1hCmGDvPEdO7CzcswnPfKBJEXUoF0bHaZSvTel8TrxwPCvDf4WaoGd0vsjriHk1Ub8HfbXG8QfwVG8pqK4PqiI68goyiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGLPrFe/9MJUnekvvfW0uXCM6woY/GdNsggWHe6KJ/Q=;
 b=FRUJ60xYR/LHaMsC4+eAYxeNDLsihYe0MgzGpmhKi4HS03wbUnDSUDRIVnI+MR9VzeNW7ewjoF6Z+qr/FRAAjRuHjE/4jg+6vkeOLJrbJII2S4zaI8ezlSTBGjzeu1K8/KfAQwz5rIriAAqPWiGffuiW3moSFSjuQmuR/AYGYSF7ATPMQ/yEvZfCoA62bsblXD97o1SIjekhd8DrrW/K1CMnZp7ofSQSpZo+EHQ+arJxzhgThfsp9kkeJ6xQSvhCELXbJcrb4QxPyeLJYIt+ORM78tGs5Iuhqw22uW876SU0o5BpYLifHOtu2fB6+M5+tLA3eu6DprypGyaI4RpTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGLPrFe/9MJUnekvvfW0uXCM6woY/GdNsggWHe6KJ/Q=;
 b=1kru1OHdP5T+h+nR5kKDrVRyPOBCGNrlKJm3RDprCqHCwQxR8AccW5RMwDZ77O+5Iq5UCL3c53eXdDkoDCbZujAo3tfWER/lfiTo8ojGzuCkVgGzwstfw3WCI3eA1Zr7gC8Ywt2hGQBVVCPS8laNdhcfm+3XKUXYWmE90f4Gt7s=
Received: from DM6PR06CA0029.namprd06.prod.outlook.com (2603:10b6:5:120::42)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 26 Jan
 2022 04:09:42 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::4a) by DM6PR06CA0029.outlook.office365.com
 (2603:10b6:5:120::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Wed, 26 Jan 2022 04:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 04:09:42 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 22:09:40 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 2/4] drm/amd: add support to check whether the system is
 set to s3
Date: Tue, 25 Jan 2022 22:09:42 -0600
Message-ID: <20220126040944.4324-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126040944.4324-1-mario.limonciello@amd.com>
References: <20220126040944.4324-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 779becd5-580d-4fc4-a7c6-08d9e081add2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51603A8C07FE423FE93DB68EE2209@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23027VU/ZVRo2g7Abeku4bRCUQuj7PZUokGke+MCPPB98b3NkONOuOeBBorG5v+aM6B8LTNcDGTaEsGGOWaqCcF/OVeSmt0aNpLuoARJqo2wY4vDUACPofzqsVaU2HGwoJFdIE9ekfew5+iMgTMIA1roby4pCAx8vtNuNFVtyl+G4fVyN2eEQJbFkCp+L0mlvOvpXAm78R3xtXoBtX6LCorwukqogPOipLsj4CC0JCiZVth7kP7nM33l29Waoh/6ewQYNqXHUO/suD7VvwSR3lj/uGqhBEyQYNs1f0NKP8uJ226XP6B5kPBbo6B6RxFJn70PfqRCR34b6f5Jb5CB8Zsy6aTfi3WMv4hW7bQNpDFnkxoqrR663SSIQGcmbG2AeGDCL4bgKqxkQc3CI+m+k90VEul2JxGXTEuwHrE6bCZ7hmrHGyUnCRRUdmo2iQanVt8kkxbi/MuJ3iUNoWMrEpEunxSM3a8iV8jshgt0fTAn/8Jqc8N/4s0yDJ5re2goUj/X/jLt/5Bk9IvTEOoMm8Hjm5ht3y+S7Nn230diExzjplC3Mwt9x4Kv/jdqdsj8OM947XxZ9m5OjhRo0kFzyn//XgfnJkwpTeMpLCwBRxaWfc8vfZmwumYDKjydO4V+AiY5ssyFj6e2FhiJCtSqyvgFMsPUKqYiP76miAsWTo0P1DRTzuKp/XJHQwfmyim8BQV2pppef+GhDQQTdAMO+aXdhFcsHTkMxU/o75xN9QQgJJ3kzGw8v/9dX+f/SEWrot7gyl8rm9CnZwIw8eAlap9gcPVrPr4xwyN8s8zCkBg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(1076003)(82310400004)(70586007)(2906002)(2616005)(54906003)(44832011)(26005)(316002)(8936002)(47076005)(36756003)(83380400001)(7696005)(70206006)(6916009)(81166007)(186003)(40460700003)(508600001)(336012)(356005)(5660300002)(86362001)(36860700001)(16526019)(426003)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 04:09:42.0521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 779becd5-580d-4fc4-a7c6-08d9e081add2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
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
Cc: prike.liang@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will be used to help make decisions on what to do in
misconfigured systems.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3bc76759c143..f184c88d3d4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1409,11 +1409,13 @@ int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_ss ss_sta
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 
 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 void amdgpu_acpi_detect(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
 static inline void amdgpu_acpi_detect(void) { }
 static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { return false; }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 2531da6cbec3..df673062bc03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1031,6 +1031,23 @@ void amdgpu_acpi_detect(void)
 	}
 }
 
+/**
+ * amdgpu_acpi_is_s3_active
+ *
+ * @adev: amdgpu_device_pointer
+ *
+ * returns true if supported, false if not.
+ */
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
+{
+#if IS_ENABLED(CONFIG_SUSPEND)
+	return !(adev->flags & AMD_IS_APU) ||
+		pm_suspend_target_state == PM_SUSPEND_MEM;
+#else
+	return false;
+#endif
+}
+
 /**
  * amdgpu_acpi_is_s0ix_active
  *
-- 
2.25.1

