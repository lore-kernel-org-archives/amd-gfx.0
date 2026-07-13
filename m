Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E16C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 17:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 188FF10E618;
	Mon, 13 Jul 2026 17:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PpjM1NSb";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB5B10E618
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 17:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCCccoeRkARaHk6mNh3oPIBiWfqmm/+ExRgLtzONYRcknrALDuZfILJk2dyKfSEZvwteIn5ga/BLJlEEBLwbUJeuZDy3oPHwjhnQPx7YZN9wkVPdVe9GbRDV4yW2yRT3PnfRDg9bGhJrsRQwqGlqZ8DwS7BqpawiEhEfsEcr/hGAXAMBzHAJw55MvKFi4yswu49x3wHmLApT9X5VrPJGkGaPKintO3QHBpglmMNsHb0pozU/cglnOwR1Fr7ACIy8PmPJBIxhXlfEr/Oa7Cqmwn8XHKWfBsBCkZKsCRWLp2FNUi+hrfywDyWjC/HWRT5ApH4H+jJ80aInO2VeizAw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+ARr65fQlhnLsS5MvDOEIdukg9ZaeZ6llsV1aDZKWI=;
 b=yMuh+WA03mejoglfrPMiJHX0madLi2pcYs0vkUqeeYVTfClOPWt08Bt3l+uTxcteNttjxaNoL4wshKetd3h4ue1l0+NepQM5POF1XOIBNaBWx5tvFRTt2Pl/O9Wik2ygDyGCReb0RmLfDgJJAEto6auNa1vaoc3+3X6AosEM5/2FHPvS3kxgCPuSYD8V2lr9USMUrh7opFH9rk4LTjX1aEZq0uAx+2qIIjwDm8ftIelnUoXv9KIHE6qXGV6DFUROd2xtGtNhc+UzLHI1ocLi8XltPnUnUrPub3WXEYYaPjH6GrcqGXfQGJQvYyF/lxvynW6LnuZ+CL3ZI9pI/dR4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+ARr65fQlhnLsS5MvDOEIdukg9ZaeZ6llsV1aDZKWI=;
 b=PpjM1NSb/ek7PDBZuIDd8IcF9Uy8sgzTFrVnzWb0x46QGuLpgLYhuMUxL7I3D3pxYim5UmTXBqYYFXY6l0OVH9z6RrCI2bn3yLvyMKs6ypdb40rgOkZk7uZ30OSO0nXKpfl3A1feYpgBzwix3YBvO2F3d5a8tsv6aUkTvXNimTk=
Received: from SN7PR04CA0224.namprd04.prod.outlook.com (2603:10b6:806:127::19)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:24:43 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::13) by SN7PR04CA0224.outlook.office365.com
 (2603:10b6:806:127::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 17:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 17:24:43 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 12:24:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Move dynamic PCIe switching quirks to X86_MATCH_*
 macros
Date: Mon, 13 Jul 2026 12:24:31 -0500
Message-ID: <20260713172431.1599801-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 59cb280b-2bb6-4767-814b-08dee103a0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: x956VwOOFnPRFo/Yt36k21s+mxMqGRG56MqVcY2P90c45fpopKDhbW+xwyQJxP71Zb/62m2H1zofTuHC/SqTWekw9GLzOAt/XURmnZHBAg0b7YpNY2Qnqk4mqbM9my00WQ8yeLNh79OOAv7s9dD61RySZWlvTGSYHVRTwZSBiDXHy2N8sdTzDhLkSAtpLtpQ+o+hP0Yf1326typk7i6JFMo8xE4MubgWIdUHaXwPMqkphlJh9Xl8KUqrGO7uOR9zRTEZAbdQ9zQVupP95x6eTQ2nvFirTostR01jN3T+gMC+zMch3wYuyfrXJiZrpVbDBIObd1EZpRtvCATHBu4ytfaBZhVuKJHg5ztOLGApyo2d0XQbQlD1+rGcuhWnFuHbiec+vklLuFX5cSLrx4JEGwe7X4qOy0r/QIxhfB5LIhwqyQATO/OQnkpDjgeENcwsuMPez98Rg/6lDor/hVUMOHEJNRUNt8LEzpV5OALlZke3c7cMXclgB6jXe+I+vpeDrjQeC8zKRjtPvmOWaD6SvDaoE3Cm0ZIkDm/PBBN6l4nLmrG+m8HRwAM2n1/f8qBtVW+XhO80y+KdwryxjdVWduzUfIF82WWQOtbsA8jy6Ar1Pzrd5MLrjr+t4s/NLzjlUaPMwcSUsdJJWLk3UtLPPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(56012099006)(11063799006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G6T52HeoekRTLRwxM6/6ZPGEWG430WduAc3jsdP486HhixQrv+fa6pYe1psgI0Na+up3uVDU1D5ce36Rs0vvktKJyzxFBKLecJO76GzsNUYa6pw0qWwnfv8GL7yTUTv01z8Y+KpG4k9IzRc6aC0uy3yOQY0WMHfZfKRcziH7zYcovmyTGtdZMwmEp2QoCmX6siobaqpNy/wbKoymAPZGrEZf0C6a9ui2wSMt2QVeJGxCEGlcgMAggiH9woK/b81mSGh1scZcrGq9N2/7OyJm+cGhTuwNTtqucJuBL7ydIonJnw/n2M0JJOrdMUP8hlarAe7tQTSEuzPQLNl5XG9fVP10J7p+zCUqWCjeuNVYXFge4bbQH1CTvzrUdFtycIPzrzf0VnAFrxZbXuwNnw7PbFUCOwKSXyA1Q+gsrm1eeHYj8pRb6z7t9Z/Xw9dkpnmo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:24:43.3538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cb280b-2bb6-4767-814b-08dee103a0ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
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

Use the X86_MATCH_VENDOR_FAM() and X86_MATCH_VENDOR_FAM_MODEL() macros
to make the quirks for dynamic speed switching more scalable.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 49 ++++++++++++----------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a4c8702fbf5a7..128a285e2bf4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1304,37 +1304,44 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
 	return amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0);
 }
 
-/*
- * Intel hosts such as Rocket Lake, Alder Lake, Raptor Lake and Sapphire Rapids
- * don't support dynamic speed switching. Until we have confirmation from Intel
- * that a specific host supports it, it's safer that we keep it disabled for all.
- *
- * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
- * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
- */
-static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device *adev)
-{
 #if IS_ENABLED(CONFIG_X86)
-	struct cpuinfo_x86 *c = &cpu_data(0);
+static const struct x86_cpu_id amdgpu_pcie_dynamic_switching_quirks[] = {
+	/*
+	 * Intel hosts such as Rocket Lake, Alder Lake, Raptor Lake and Sapphire Rapids
+	 * don't support dynamic speed switching. Until we have confirmation from Intel
+	 * that a specific host supports it, it's safer that we keep it disabled for all.
+	 *
+	 * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
+	 * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
+	 */
+	X86_MATCH_VENDOR_FAM(INTEL, X86_FAMILY_ANY, NULL),
+	/*
+	 * AMD Ryzen Pinnacle Ridge (Zen+, family 0x17 model 0x08) CPUs don't
+	 * support PCIe dynamic speed switching.
+	 * https://gitlab.freedesktop.org/drm/amd/-/work_items/5436
+	 */
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x08, NULL),
+	{}
+};
 
+static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device *adev)
+{
 	/* eGPU change speeds based on USB4 fabric conditions */
 	if (dev_is_removable(adev->dev))
 		return true;
 
-	if (c->x86_vendor == X86_VENDOR_INTEL)
+	/* Hosts have problems with dynamic speed switching */
+	if (x86_match_cpu(amdgpu_pcie_dynamic_switching_quirks))
 		return false;
 
-	/*
-	 * AMD Ryzen Pinnacle Ridge (Zen+, family 0x17 model 0x08) CPUs don't
-	 * support PCIe dynamic speed switching.
-	 * https://gitlab.freedesktop.org/drm/amd/-/work_items/5436
-	 */
-	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 == 0x17 &&
-	    c->x86_model == 0x08)
-		return false;
-#endif
 	return true;
 }
+#else
+static inline bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device *adev)
+{
+	return true;
+}
+#endif
 
 static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
 {
-- 
2.43.0

