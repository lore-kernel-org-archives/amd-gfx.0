Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E11C5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C443C10ECAB;
	Tue, 18 Aug 2026 20:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vdrMjVtL";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 026CE10ECAB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atTZLATOzEKQ4u4sVocKtcBbuNb5/nsAHH/CBBCf/2iKC0QFZuOsFow2naKbe1S/nzrNYsOroRuAhAmOAJvsYv/Yu2+1tjTGTe4PmqpIvWay05Dy8yXr2m9k3SlbCAX/4pCCBoTllF/UOe1F6bMp+wzBK4vdpIMIapNmTyoBU/gruVQcZj+8060X1oWanFkf10u71b9g+rE9NVVO7lu3plhal7MOSyps3E86NrTvjXmkidLT9SR83l3AMCPVuZn8Ns6LnuxjPRpGjKJ0cV1/z0S6f7zz0O8wMEfNz3GdHJ3rs/tr0yGhryEbxTUqvpmc/bdNjgNsGnaY8k/vyHNvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xr8Funmx2LeGQ1yT7+d+CHTIjyOETOP4p4xkd+rORLI=;
 b=XajZUTNVkIQYmWAssFujKjAm5GEIQV/chMj9QnMPVl3xjPyIeIPdj/HM+LFFYnSNCNWrxEy1A8n25W5QDb6MsEwkjLyRHYQP6TVIl6XvNmRyUCSdrLBo1Uw5GNA54l5n7AaLa0qHEOYs3Wyyu4rl7/J6aEG1e2Re3HAJVUZk1qPlAHUVRlRwX0M3e0Pr6oGIDzygnkBbLe9Mrs3HVfVTFs0vDHxn14ftEQhlqNF3Zi+gVggWCg0ivgq6xSG9Z5t3c1WCguA75yMCZcsFbyp+OO3eueb9MQa3FCl0a5QVi4MH2JzMSpendXKjsgKOF7b1Pr9O73hzQ93Zo3J6EqnPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xr8Funmx2LeGQ1yT7+d+CHTIjyOETOP4p4xkd+rORLI=;
 b=vdrMjVtL3GRHPB8GLEKqf8t0TvPWFd56GaJ0LVcEt9b79mpaZcQ6JdKjoPexgcQVSL+eiNTwHGLR8GuiuBlCabyjFOMDiRN1oJermRaTyE8S/DWFLTN9iDrf5mxQqHG2mV25CYs7LcUUF4VTsULZENCIvQ9QJl2wE5SPAQHeAes=
Received: from BN9PR03CA0349.namprd03.prod.outlook.com (2603:10b6:408:f6::24)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:37 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::4d) by BN9PR03CA0349.outlook.office365.com
 (2603:10b6:408:f6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:13 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:13 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 28/82] drm/amd/display: Test dm_init_microcode
Date: Tue, 18 Aug 2026 16:15:20 -0400
Message-ID: <20260818202139.4172592-29-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d488265-a47b-4f5b-473c-08defd66722f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Dmt70bKx9rkyk4xRzDxbbEMlf+332wGg6jzRCNUHjROrLBaYwunjOCbplii3NFe8XNlopPhKAL5OhMU6zy7tvR+EpgPLJiT/orTXha1sN9qVMAzOyF66ZyBNdhLbvZ95Z4W2ZzpwENfrgczRGoZCZQ9yaEyyhnvJI85LzYweZMjdWFyEgjkANUI2wZKMaqdmKLFoSemB0RyHhwUp4JmbRMlG9EbtElCkRi8AtuxpiyB+do059IK4Qq10K4OMzU9iWO8HMbSLNhJ88ZZGZ0oltBOQHlYWo6+imgi/5YcFQLm5LlAbkR1QEwkWiYsML7bNTB727U/KFlvdkdf7z9jwfEPBhYvlR9QO0aQuRoZukBEVS1VptxFpV8EOU+MqcaGsfEIurM7kLxFcgSjE0Y9kivrtppH59YExsk1cRmjyvZXLbEt8ISdZwq+upJNZZXgeSFKBGKSDvpsIlTcZU0iHOQOuC6aPxAxpTeymJy4o/YcQbsR/Z/TVXakJDmSKKjsvpUSTQUM0vBmXXVw1Z2u9vuI6jyJc+cl3Ejp50cUt36N0AxcXjF0SZ5Hszy3FAkewq6qXj9X9GNul/IAmXltVBJYF4wOJuRUx5Jd7Gu6h/2x0O6ese2o+fC9KdE1gSziNLWm/5lgvSP6/70YCDILchlRXtrpVAGuIN/mRQFFuYeRsmKqc48UR3XjcqVN9hjxPRNdoINoxLQmAIf2ib/y1JA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mNQAL4Z7pKcn2AvSL6NZmSw/y9gnFZoYQLPYz5UTDg7uhHuLrEVFvoLK8V9HhJxn8qj+x8VZm8D4zAk4+b46/UzkmYtbrKKFPSwbbpOqULDon3jjFVHE5Kt5kGyBUE+4G4opz/NlDSEs7GHeRwGEyr3eC9P13+JjY/P62KbexDgU0fMaZ8JPj5ecWu925jwWGreaO/f7Bv9InoJW5lvpwx7CVTkK5GJJj3x5dONPZtn+OzoPsxcaW4/j6N/xKfZhPEvIEPVE7DrX+tr5fyIzH2D2sIRBeuhONMqwQ39kzq9IAb/SsrduiNakvjLzwg6alR+HRIJE0wWTztwKgyZk1SsDEYvAcBXrpNf9mUZlNY4n6gVc4yVlvEj/KAjivj4df+aCwUee9mLjg2MafyRO3E0N9DLpMGO+uMYbR1TnjQPHRCIoypkazEvrJEbo3RBR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:37.6950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d488265-a47b-4f5b-473c-08defd66722f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add KUnit tests for dm_init_microcode(), covering the ASIC to firmware
name mapping for all 21 supported IP versions and the firmware request
failure path.

[HOW]
The real amdgpu_ucode_request() reaches the firmware loader, so add a
KUnit-only indirection table for it. The default table entry points at
the existing function, so no test-only wrapper is introduced, and the
prototype is mirrored verbatim so an upstream change fails the build at
the default initializer rather than diverging silently.

Tests install a fake that records the formatted firmware name, letting a
single table-driven case assert the name chosen for every ASIC,
including the Green Sardine revision check and the Sienna Cichlid versus
Navy Flounder split on the graphics IP version.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  26 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |   9 ++
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 115 ++++++++++++++++++
 3 files changed, 148 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 29990cfe4265e..2b34d5c36b48d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -65,6 +65,28 @@ MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
 MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
 MODULE_FIRMWARE(FIRMWARE_DCN_60_DMUB);
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+static const struct amdgpu_dm_dmub_kunit_ops amdgpu_dm_dmub_default_ops = {
+	.ucode_request = amdgpu_ucode_request,
+};
+
+static const struct amdgpu_dm_dmub_kunit_ops *amdgpu_dm_dmub_ops =
+	&amdgpu_dm_dmub_default_ops;
+
+void amdgpu_dm_dmub_kunit_set_ops(const struct amdgpu_dm_dmub_kunit_ops *ops)
+{
+	amdgpu_dm_dmub_ops = ops ? ops : &amdgpu_dm_dmub_default_ops;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_dmub_kunit_set_ops);
+
+#define dmub_ucode_request	amdgpu_dm_dmub_ops->ucode_request
+
+#else
+
+#define dmub_ucode_request	amdgpu_ucode_request
+
+#endif
+
 /**
  * dm_dmub_aux_setconfig_callback - Callback for AUX or SET_CONFIG command.
  * @adev: amdgpu_device pointer
@@ -768,8 +790,8 @@ int dm_init_microcode(struct amdgpu_device *adev)
 		/* ASIC doesn't support DMUB. */
 		return 0;
 	}
-	r = amdgpu_ucode_request(adev, &adev->dm.dmub_fw, AMDGPU_UCODE_REQUIRED,
-				 "%s", fw_name_dmub);
+	r = dmub_ucode_request(adev, &adev->dm.dmub_fw, AMDGPU_UCODE_REQUIRED,
+			       "%s", fw_name_dmub);
 	return r;
 }
 EXPORT_IF_KUNIT(dm_init_microcode);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
index 735e2b4299521..d178e1bf4dd6b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
@@ -75,6 +75,15 @@ void abort_fused_io(struct dc_context *ctx,
 		    const struct dmub_cmd_fused_request *request);
 uint32_t amdgpu_dm_dmub_reg_read(void *ctx, uint32_t address);
 void amdgpu_dm_dmub_reg_write(void *ctx, uint32_t address, uint32_t value);
+
+/* Signatures are verbatim copies so an upstream change breaks the default ops. */
+struct amdgpu_dm_dmub_kunit_ops {
+	__printf(4, 5)
+	int (*ucode_request)(struct amdgpu_device *adev, const struct firmware **fw,
+			     enum amdgpu_ucode_required required, const char *fmt, ...);
+};
+
+void amdgpu_dm_dmub_kunit_set_ops(const struct amdgpu_dm_dmub_kunit_ops *ops);
 #endif
 
 #endif /* AMDGPU_DM_AMDGPU_DM_DMUB_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index cda048e8297a0..fa81413be05f5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -14,6 +14,7 @@
 #include "dc/inc/hw/abm.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
+#include "dal_asic_id.h"
 #include "dm_services.h"
 #include "dmub/dmub_srv.h"
 #include "amdgpu_dm_dmub.h"
@@ -1445,6 +1446,32 @@ static const struct amdgpu_dm_services_kunit_ops dm_test_services_ops = {
 	.bo_free_kernel = dm_test_bo_free_kernel,
 };
 
+/* Fake firmware loader, records the firmware name the ASIC switch selected. */
+
+static char dm_test_ucode_name[64];
+static unsigned int dm_test_ucode_calls;
+static int dm_test_ucode_ret;
+
+static __printf(4, 5) int dm_test_ucode_request(struct amdgpu_device *adev,
+						const struct firmware **fw,
+						enum amdgpu_ucode_required required,
+						const char *fmt, ...)
+{
+	va_list args;
+
+	dm_test_ucode_calls++;
+
+	va_start(args, fmt);
+	vsnprintf(dm_test_ucode_name, sizeof(dm_test_ucode_name), fmt, args);
+	va_end(args);
+
+	return dm_test_ucode_ret;
+}
+
+static const struct amdgpu_dm_dmub_kunit_ops dm_test_dmub_ops = {
+	.ucode_request = dm_test_ucode_request,
+};
+
 static int dm_test_dmub_hw_access_init(struct kunit *test)
 {
 	void *cpu_ptr;
@@ -1454,8 +1481,12 @@ static int dm_test_dmub_hw_access_init(struct kunit *test)
 
 	dm_test_bo = (struct dm_test_bo_ctx) { .cpu_ptr = cpu_ptr };
 	dm_test_cgs = (struct dm_test_cgs_ctx) { .dev.ops = &dm_test_cgs_ops };
+	dm_test_ucode_name[0] = '\0';
+	dm_test_ucode_calls = 0;
+	dm_test_ucode_ret = 0;
 
 	amdgpu_dm_services_kunit_set_ops(&dm_test_services_ops);
+	amdgpu_dm_dmub_kunit_set_ops(&dm_test_dmub_ops);
 
 	return 0;
 }
@@ -1463,6 +1494,7 @@ static int dm_test_dmub_hw_access_init(struct kunit *test)
 static void dm_test_dmub_hw_access_exit(struct kunit *test)
 {
 	amdgpu_dm_services_kunit_set_ops(NULL);
+	amdgpu_dm_dmub_kunit_set_ops(NULL);
 }
 
 static struct amdgpu_device *dm_test_alloc_adev_with_cgs(struct kunit *test)
@@ -1608,6 +1640,86 @@ static void dm_test_dmub_get_vbios_bounding_box_copy_timeout(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.da_list));
 }
 
+/* Tests for dm_init_microcode() */
+
+struct dm_test_ucode_case {
+	u32 dce_version;
+	u32 gc_version;
+	u32 external_rev_id;
+	const char *fw_name;
+};
+
+static const struct dm_test_ucode_case dm_test_ucode_cases[] = {
+	{ IP_VERSION(2, 1, 0), 0, 0, FIRMWARE_RENOIR_DMUB },
+	{ IP_VERSION(2, 1, 0), 0, GREEN_SARDINE_A0, FIRMWARE_GREEN_SARDINE_DMUB },
+	{ IP_VERSION(3, 0, 0), IP_VERSION(10, 3, 0), 0, FIRMWARE_SIENNA_CICHLID_DMUB },
+	{ IP_VERSION(3, 0, 0), IP_VERSION(10, 3, 2), 0, FIRMWARE_NAVY_FLOUNDER_DMUB },
+	{ IP_VERSION(3, 0, 1), 0, 0, FIRMWARE_VANGOGH_DMUB },
+	{ IP_VERSION(3, 0, 2), 0, 0, FIRMWARE_DIMGREY_CAVEFISH_DMUB },
+	{ IP_VERSION(3, 0, 3), 0, 0, FIRMWARE_BEIGE_GOBY_DMUB },
+	{ IP_VERSION(3, 1, 2), 0, 0, FIRMWARE_YELLOW_CARP_DMUB },
+	{ IP_VERSION(3, 1, 3), 0, 0, FIRMWARE_YELLOW_CARP_DMUB },
+	{ IP_VERSION(3, 1, 4), 0, 0, FIRMWARE_DCN_314_DMUB },
+	{ IP_VERSION(3, 1, 5), 0, 0, FIRMWARE_DCN_315_DMUB },
+	{ IP_VERSION(3, 1, 6), 0, 0, FIRMWARE_DCN316_DMUB },
+	{ IP_VERSION(3, 2, 0), 0, 0, FIRMWARE_DCN_V3_2_0_DMCUB },
+	{ IP_VERSION(3, 2, 1), 0, 0, FIRMWARE_DCN_V3_2_1_DMCUB },
+	{ IP_VERSION(3, 5, 0), 0, 0, FIRMWARE_DCN_35_DMUB },
+	{ IP_VERSION(3, 5, 1), 0, 0, FIRMWARE_DCN_351_DMUB },
+	{ IP_VERSION(3, 6, 0), 0, 0, FIRMWARE_DCN_36_DMUB },
+	{ IP_VERSION(4, 0, 1), 0, 0, FIRMWARE_DCN_401_DMUB },
+	{ IP_VERSION(4, 2, 0), 0, 0, FIRMWARE_DCN_42_DMUB },
+	{ IP_VERSION(4, 2, 1), 0, 0, FIRMWARE_DCN_42B_DMUB },
+	{ IP_VERSION(6, 0, 0), 0, 0, FIRMWARE_DCN_60_DMUB },
+};
+
+/**
+ * dm_test_init_microcode_fw_names - Test the ASIC to firmware name mapping
+ * @test: The KUnit test context
+ */
+static void dm_test_init_microcode_fw_names(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	unsigned int i;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	for (i = 0; i < ARRAY_SIZE(dm_test_ucode_cases); i++) {
+		const struct dm_test_ucode_case *c = &dm_test_ucode_cases[i];
+
+		adev->ip_versions[DCE_HWIP][0] = c->dce_version;
+		adev->ip_versions[GC_HWIP][0] = c->gc_version;
+		adev->external_rev_id = c->external_rev_id;
+		dm_test_ucode_name[0] = '\0';
+
+		KUNIT_EXPECT_EQ_MSG(test, dm_init_microcode(adev), 0,
+				    "IP version 0x%08x", c->dce_version);
+		KUNIT_EXPECT_STREQ_MSG(test, dm_test_ucode_name, c->fw_name,
+				       "IP version 0x%08x", c->dce_version);
+	}
+
+	KUNIT_EXPECT_EQ(test, dm_test_ucode_calls,
+			(unsigned int)ARRAY_SIZE(dm_test_ucode_cases));
+}
+
+/**
+ * dm_test_init_microcode_request_fails - Test a firmware request failure
+ * @test: The KUnit test context
+ */
+static void dm_test_init_microcode_request_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 0);
+	dm_test_ucode_ret = -ENOENT;
+
+	KUNIT_EXPECT_EQ(test, dm_init_microcode(adev), -ENOENT);
+}
+
 static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	/* dm_register_dmub_notify_callback() */
 	KUNIT_CASE(dm_test_register_dmub_notify_callback_null_callback),
@@ -1681,6 +1793,9 @@ static struct kunit_case amdgpu_dm_dmub_hw_access_tests[] = {
 	KUNIT_CASE(dm_test_dmub_get_vbios_bounding_box_alloc_fails),
 	KUNIT_CASE(dm_test_dmub_get_vbios_bounding_box_addr_timeout),
 	KUNIT_CASE(dm_test_dmub_get_vbios_bounding_box_copy_timeout),
+	/* dm_init_microcode() */
+	KUNIT_CASE(dm_test_init_microcode_fw_names),
+	KUNIT_CASE(dm_test_init_microcode_request_fails),
 	{}
 };
 
-- 
2.43.0

