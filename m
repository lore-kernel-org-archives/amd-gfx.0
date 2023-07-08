Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E63EB64D9
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Jul 2023 02:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD0C10E012;
	Sat,  8 Jul 2023 02:26:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92D1210E012
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Jul 2023 02:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnWsI6eQKGnEtC00DMMPMlGhwlfcbNoD58l0TgUCwURnJkQb/s1oSZm/T9TyLL8hToM5sVXjLqd++D7HsWcMi+sahvHE3E8Hh6UTAIlFy/+X4E7hL/IP8rASGq9v6pE54Kv+wp7QExt/FyfwHIJ6h+ehT1U8gF7cuMf5vKSYJ0jBjMOf8H8uJP8mPx9CGufnjZ4MnVzrjbC9naRKCk2HRKSifDM1Gtkk5FELTuHq2KWYpUlscBPSs9yGsub6uGZr19ovU+RGLGtmVyEyEXGaoRDV90GLATLKyx7NBzjwiMVzDY31Y3h3xU9qeVbDB2ocK7eGpzIBg6upPt35vQPPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a36NbfzeGQfRBDwHzX1ErJvzYYzjgwKTFfrU9WIn/sc=;
 b=ctdKJg7U0e2nTT6ehf+qcjGW5N4TiBpbtybKk6DUsLFt3fULaSkmonspI2Y3ygf0Xe/Wwux6Vp92EAeHd+D06Ja2NEhbwyIAmgpYvFcaFWN2kr6X2FKRRNGSTd9S/mz5tPzCNuI7uOGpwAUCy8HKyw0r5ZtIthOsSGpLcrvpmozpgX+ymUHsWJufqX71thQy15VbWQqfbz/xmFNfdDXfYu0wkSGWq56ciGVWuv2CgzehG29z+ZIsRQUllF54loJDhYYVDod0Rcaa6b2hbKSaMm+UXFxc29odCiW4rCCeaFB4q/RkhgOyrW/yEy42uX+tgcE3nZDor8c9rSxT3c8Log==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a36NbfzeGQfRBDwHzX1ErJvzYYzjgwKTFfrU9WIn/sc=;
 b=XS+iTSlJKtYMCpFLL8E4lhBYFyZv6kkIFJ9Cnv5BRB73oJWJTwsWBtgpsQWAIDW1V85Te+/DzZr1dFZWdYn8JcTG+/uvN3lllT8sxt24n0XrnRv3YcVkRQG7dg6Tc38NVp9ml25LqgR6j4oV2reFvpIbQMbRc1BS1yCtD+gjZDk=
Received: from BN0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:408:e5::24)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Sat, 8 Jul
 2023 02:26:33 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::42) by BN0PR02CA0049.outlook.office365.com
 (2603:10b6:408:e5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26 via Frontend
 Transport; Sat, 8 Jul 2023 02:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Sat, 8 Jul 2023 02:26:33 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 21:26:32 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amd: Move helper for dynamic speed switch check out
 of smu13
Date: Fri, 7 Jul 2023 21:26:08 -0500
Message-ID: <20230708022611.50512-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230708022611.50512-1-mario.limonciello@amd.com>
References: <20230708022611.50512-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c54166a-2963-4edb-9fa2-08db7f5abf10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99/d/sQ23kPoTJhjsvZTJvUFro2Der5871HTtq02zvrFNz8V1ccBCjBasn2QsIpPDPbd1f3hcuLUQSC62DV45Rsc345Vd4eNdNdaV8d3wLiBHd2kjkrRZ7dQgQ5VgQV8mjvLVcPnH/9KznD36qWAU0HOT5eXWtIINPhuljzf+oJIx3zchOhOnaV1PKm2qPqFehT2xeT4gDld9pmBmVNu+QDmErAYkh63Hl2nvXofHkC1WbQ7ueG/uJEk2J9AeiyuxkEsc211F0Y2iqkFPPfXbfF19lADrrtz3Gd4BMeBICOQILgO3uaRUkuo/2e3Bydn8F97Hjd9eZ937PYdOZtFhLHv+jESA6W7aKY2Q23xTDaQ9+xIrOwzaBbFlHVvdYj4h41prAcZCTjyi+EvPmfVp8vb6omokkjZb0zsYg4YI+JCFEOB2xfJDzH2M9T7uj255ILYUWI3/DR/HubQm9lLKYnUiMmHnjuJndLl0etcR4jMf5Rbu0yj4hrBbUoxJw6S0nND122IdViFcTTzCzQlN7M2WAaDi3hSHYq7ZQosV632CrJFGWMBqWSMUmNQUHIuvr2FZOt3+77P+zHU8JlWzAfLQ418qz3pwY5JghcqalCdTgWgtZvt5os6wC5mrxVT8Q4iO4D57wqwBjeUyLN2WrFVH9b+zkwXCTPE+XZYduc+0CCM4V01LhzjRubW8eoA1oiFFeJMcrcaKYKI6cKZeVydMXRgzGoUxF766KsJOiI72eUWPDTBvwphXYwBSKhq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(478600001)(6666004)(7696005)(54906003)(70586007)(26005)(186003)(1076003)(966005)(336012)(70206006)(16526019)(82310400005)(2906002)(41300700001)(4326008)(316002)(6916009)(44832011)(8936002)(8676002)(5660300002)(81166007)(356005)(82740400003)(86362001)(36756003)(2616005)(47076005)(36860700001)(83380400001)(426003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 02:26:33.2066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c54166a-2963-4edb-9fa2-08db7f5abf10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
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
Cc: Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This helper is used for checking if the connected host supports
the feature, it can be moved into generic code to be used by other
smu implementations as well.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 19 +++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 21 +------------------
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dc4dc1446a19..813713f42d5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1313,6 +1313,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
+bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fcf5f07c4775..7314529553f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1461,6 +1461,25 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	return true;
 }
 
+/*
+ * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
+ * speed switching. Until we have confirmation from Intel that a specific host
+ * supports it, it's safer that we keep it disabled for all.
+ *
+ * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
+ */
+bool amdgpu_device_pcie_dynamic_switching_supported(void)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return false;
+#endif
+	return true;
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index cf7e729020ab..9b62b45ebb7f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2425,25 +2425,6 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
 	return ret;
 }
 
-/*
- * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
- * speed switching. Until we have confirmation from Intel that a specific host
- * supports it, it's safer that we keep it disabled for all.
- *
- * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
- * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
- */
-static bool smu_v13_0_is_pcie_dynamic_switching_supported(void)
-{
-#if IS_ENABLED(CONFIG_X86)
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	if (c->x86_vendor == X86_VENDOR_INTEL)
-		return false;
-#endif
-	return true;
-}
-
 int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 				     uint32_t pcie_gen_cap,
 				     uint32_t pcie_width_cap)
@@ -2455,7 +2436,7 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
-	if (!smu_v13_0_is_pcie_dynamic_switching_supported()) {
+	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
 		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
 			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
 
-- 
2.34.1

