Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D49C83F3E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 19:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504C010E49E;
	Tue,  5 Sep 2023 19:36:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C8F610E492
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 19:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXizPunB2JWuBDqUaOKYmSpzUDFS7B7pRgL3YCmFdUefqr1KBD7oJaSgM2DNOHF0lIs57vVMTT+fIPoUvi7i2CBsYSwqNkcph/DbWIDkvR4qDmdmV9MTDr5J2YF2JhEgCDsqp3biH0aBoMghjfjjV4NeGZ272XA9o8aoFANpCRmBzGyLmfUjSTXwD66vk1B5zmcXlFm0z/2eBPgDJ+bXPyfihm9qs6DGYAIE1FZew2J4gGV1LT6+d//gZ103crdJZBOCHc9CmXznkAooYQVn3VRWQIJ1q0Jq4YX6yT/Nm9Pi2CNyLDSZU7F1YjkoAJ1fUXQYhZTDB49SVbhxJWW/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT0AIyoKltbPlFayJDlACb4CezdOPVAg3Ii4C7YmPe8=;
 b=HRpBYFLXllc0yV0MJ9Q7RHWlLTUy2cktZYaZkF7+WZmZo8r/pTpweQaSP2kGBXTCkaNl399OfSKbIfEscY8OVMHjuovSgDoMquEJJwTG0s5UdvZN13XHPtKz8xcvxJjGM7eOsCGXEQ6IeB3g5PR2VQlb/mGRYpoHB02WxHqQWbAb9STMH7aaL9xCKS+A9zObdkSkQFs7fsqnZt2XASSWc7e6e4SqH+rPC1yjCRDPMDtxwsFXyM8MKhQqXuHM/569wIy2RxJqPYp5/iekUVSbBcF0j735ltSPoqBrlmCg3Q3fAJ77NDyKenzysnvCjGRUfx23n3TnZdoCiA3WDr3P/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT0AIyoKltbPlFayJDlACb4CezdOPVAg3Ii4C7YmPe8=;
 b=bYpCsUZvQksoz1NjcrU04QCvg4aBwq+NZ8Ub4jYh+m2aP1/m+K75IgMB+Ex089b+X4TZyuoFvRwq5eDUDQpkianAG+GSvWmp0FNy7kOdoX6CLQfeYGO/4vVMZW+EG70E5NxtXHBeEe9aBjIEZHkzIl/3u5jUUEeODR4lM5TJUcc=
Received: from SN6PR2101CA0026.namprd21.prod.outlook.com
 (2603:10b6:805:106::36) by CY8PR12MB8409.namprd12.prod.outlook.com
 (2603:10b6:930:7f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 19:36:39 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::a8) by SN6PR2101CA0026.outlook.office365.com
 (2603:10b6:805:106::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.6 via Frontend
 Transport; Tue, 5 Sep 2023 19:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 19:36:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Sep
 2023 14:36:38 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amd: Add a module parameter for seamless boot
Date: Tue, 5 Sep 2023 14:25:59 -0500
Message-ID: <20230905192600.32449-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905192600.32449-1-mario.limonciello@amd.com>
References: <20230905192600.32449-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6602e6-a826-4e15-f817-08dbae476ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vStoTM4xDtTgZiMprl+XfV0zj0pWWzkLAdbF/BYebV3H3U29IIALK5thPlN1qMopRDNcWVx3Celp37ifcOT60b60wFR+EGjwZh6kpGdeWYD9bK7KCKFkYaxxgqbZH5oJBipGKA9oD7sjcAsiUZFXwzlIDn5uQYJ7VuZrnGTg59PJmfoPtsr2AaNwVEmyvDLX2YI+kUmb1s62z3m7IZGIASBVxTPkKhI9XXZv9q5B3B5ziyJyOqsnOGfwH5d+es+naqOxp0kNv3+OHMFMpkrMU2ZqHZv8Hot2C1dPs0UR2P+sJzQlFcEg9T20TGAOYad1dmYGUzul32qd87/eN7zzmhHer4OhoZZVJixpmzej7gVKbNufxIV8yTqRLvc1y8BM2GRA8T+gE0oV2L3ZY4/eUO0eNTUjStVYdYFsNsLl891Zh5wlHIqFH1hyOZx9wlvFhlaIwHN/vTfHNxrZOJbij7pfmN14CNObCR3VjYwqOgEMsw848Jni7FuH+9PMTJ+O5zYdEgguCre3DbE16zdCzfsNEOTavrIHmegQd8anXAxoNTv1wpxoG4Uow1k5ZUwhNZ1townsmKZPTFYBS4TF6oeLNwZ9ZL1LERaOj/7hb7EV7+jHi17yv8cHK/kXXQsB1GinPdy3p0FHOrxNgvyuo9mSbFfjZC8vzfVc17pLJjMN5R9BXILW2nzS7ZCzLGQIbdRNyEsXbmjaq8GGnXp09ObUBW0DOMpBa31UUUouM9L1kDYW/gfZUxu7azquq5AELAeiLHdmlyhLr4+fE5gkMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(6916009)(316002)(70586007)(70206006)(36860700001)(1076003)(2616005)(7696005)(6666004)(478600001)(82740400003)(356005)(81166007)(5660300002)(8676002)(8936002)(4326008)(44832011)(16526019)(426003)(336012)(47076005)(2906002)(86362001)(26005)(83380400001)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 19:36:39.5550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6602e6-a826-4e15-f817-08dbae476ce8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
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

The module parameter can be used to test more easily enabling seamless
boot support on additional ASICs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  8 ++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7fb282574fa3..2f445f2e9abd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -246,6 +246,7 @@ extern int amdgpu_num_kcq;
 extern int amdgpu_vcnfw_log;
 extern int amdgpu_sg_display;
 extern int amdgpu_umsch_mm;
+extern int amdgpu_seamless;
 
 extern int amdgpu_user_partt_mode;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 72a5f77fc7b4..9159a7b993ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1280,11 +1280,25 @@ bool amdgpu_sg_display_supported(struct amdgpu_device *adev)
  */
 bool amdgpu_seamless_boot_supported(struct amdgpu_device *adev)
 {
+	switch (amdgpu_seamless) {
+	case -1:
+		break;
+	case 1:
+		return true;
+	case 0:
+		return false;
+	default:
+		DRM_ERROR("Invalid value for amdgpu.seamless: %d\n",
+			  amdgpu_seamless);
+		return false;
+	}
+
+	if (adev->mman.keep_stolen_vga_memory)
+		return false;
+
 	switch (adev->ip_versions[DCE_HWIP][0]) {
 	case IP_VERSION(3, 0, 1):
-		if (!adev->mman.keep_stolen_vga_memory)
-			return true;
-		break;
+		return true;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ef713806dd60..8d511e5c43af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -195,6 +195,7 @@ int amdgpu_vcnfw_log;
 int amdgpu_sg_display = -1; /* auto */
 int amdgpu_user_partt_mode = AMDGPU_AUTO_COMPUTE_PARTITION_MODE;
 int amdgpu_umsch_mm;
+int amdgpu_seamless = -1; /* auto */
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -948,6 +949,13 @@ module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
 module_param(enforce_isolation, bool, 0444);
 MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
 
+/**
+ * DOC: seamless (int)
+ * Seamless boot will keep the image on the screen during the boot process.
+ */
+MODULE_PARM_DESC(seamless, "Seamless boot (-1 = auto (default), 0 = disable, 1 = enable)");
+module_param_named(seamless, amdgpu_seamless, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
-- 
2.34.1

