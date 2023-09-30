Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1ADE7734F
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Sep 2023 03:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B360B10E12D;
	Sat, 30 Sep 2023 03:23:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF49C10E12D
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Sep 2023 03:23:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW1kthPWF+5/x9jcPDrnQVsdnJHwGr7GJj1X+GwXQUhXgqpSL6MUknbq6wW3YLzYFSCYyuKKjW5xpaYWIyACke5DHz4ZYQvG1i7cnN1+8/FpsqmS+M3469xFkIiskno6Tq26E14fzbx9zK0Wq0hfD9newYAjDoNXlk4Fc4yD5Aqu3GDbmb0XWPl5gOWEzQjGa3DwKeC4PiK/cl8mv+lXD/K8oqKLzBv4lByZHiKD4qHVFLM003YXMcwWKf4MP08WOSfjW29dHYZLweFzbstlItz/FgcusgBqAQipVkg4E8DDrsE84ZB5dYDaPoXfvz19y8+b385InU+mcUXHr2/GoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+emjiLY29YYe96AMCW0+sXpV9sYlJUG/liPQE1FgDEg=;
 b=c/BBCP4A/37nYp2nqILcgpoBUBa8QrChTeHOBWa6ycopjojBSeU1I3/w8eRuZKH13hteVZrejMEsS1Ulmv0VGQtpCHup5u5lGmHekGf1CCyCP8V7rVCBEAMau1YI38UoRwP7QRj2kTyEoEYQ3LMq+/94oViJTIS1Kh14W+L0boB5h0DcXeD2BYAw3pUSkNpM5PriOzxFu8e+6UwnFNldolICgcU7i4QbIW5ZfKEvcy5s5S+njcXz32qQCh+y+yy2LRUtQL2xMNwUgDWHIlvZioBwjIpr54pzlD/zsJzxCs8PrZ+SJZio6YHZUZVn7I72Za3ARLU2LAMxU1wgVPaA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+emjiLY29YYe96AMCW0+sXpV9sYlJUG/liPQE1FgDEg=;
 b=ov4WlcdBQWgCdb7x7/5KhkG//ousM20abj1ZQI1Oc5ns1kQu3YieieUEHr45uvwJDQncM9PaGRZ+IFts8PL97W4+NB8lG1mDm3NzReeth0/33tzZqAXt+5Mdb0H88nxEWBDSdca/t4RUodcGi5uFATZb6MfSZ0TZi9KQjz3Jc94=
Received: from MN2PR06CA0017.namprd06.prod.outlook.com (2603:10b6:208:23d::22)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Sat, 30 Sep
 2023 03:23:21 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::a3) by MN2PR06CA0017.outlook.office365.com
 (2603:10b6:208:23d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27 via Frontend
 Transport; Sat, 30 Sep 2023 03:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Sat, 30 Sep 2023 03:23:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 22:23:12 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd: Update `update_pcie_parameters` functions to use
 uint8_t arguments
Date: Fri, 29 Sep 2023 22:22:53 -0500
Message-ID: <20230930032254.580-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|BN9PR12MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: 172ee341-be15-4b35-52dd-08dbc164993d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4IyiJ/qF3BnZDfHh7qILmQROcFUfwjuVBfgBAOvcawwuuaKAMNoVIDxmAvypyrAvteGSnt+G+2QiCEdc0M57LmRGjSYoEzrGdc4YYBrxi8FZIWfF402Oj3LjaHGgW9im8lI61FP7VAtzPaWjDSpOqILH4jHpxNLWTYhC9ODcab2cyQW/dVAnuFM6I4DWq+7G28igDsYDSvvfldbYm9sS7BdQHkc+aiNLedW+tFNoVluZk6dyU6PzhF5JgWmhYSEjGSM8hV4QWbi5u8TJWilFaBy1xTnGVR5YCDJzTV4/841i4KitHt9kOZoeWPNud9/vX2nfPmYmWxotEcTVpBIdsEPrjIBXOKMAgPLTa9UvwqasTuhWMAuwoTAfRoyzh5tcY7Yy9KhTKIwltJXWEFGKhBY7hOrgHRbY1tLj3w01mQJnAX2zDFi3mGJzqqVapzqDY69iOrYUPYY6QOYfKolSw8KRMy5MrXJeVPDcULL84iRHMryc313ZZ15uLFQ6rRXQrsZ3LYv369sNUlYxvlKaW19F3rZ629OR9B1UKBW4W8TExBqdGlYO7WFu8/ZBeIhX6o1f2mORwB2jzK6ob31sLQ9j5dSBIA08xChVirVnZp3dXskmLfi0upzIhuVN0jKM9AdN+PXoK+oZRfexa84l6xLwGLcTZNvoih9lp77Jh7zK/01SCY6AyoVW2ECG2aNwL7t7JZvs7rkK1dwcxN5IBXjcWX66MuKIPBVW7s44Ri90lvdLEnxvdsvJKhgr1V8N5cAPPytCy7qLGzkWdXmdw1rUjurRXnUUR9FlrVR1hg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(6666004)(7696005)(478600001)(356005)(81166007)(47076005)(36860700001)(86362001)(82740400003)(15650500001)(2906002)(41300700001)(336012)(83380400001)(426003)(2616005)(16526019)(26005)(1076003)(36756003)(44832011)(5660300002)(70586007)(70206006)(316002)(6916009)(8676002)(4326008)(8936002)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 03:23:21.4411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 172ee341-be15-4b35-52dd-08dbc164993d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
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

The matching values for `pcie_gen_cap` and `pcie_width_cap` when
fetched from powerplay tables are 1 byte, so narrow the arguments
to match to ensure min() and max() comparisons without casts.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h           | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h            | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 8 ++++----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 33eaf0d77163..99750c182279 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1270,7 +1270,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 {
 	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t pcie_gen = 0, pcie_width = 0;
+	uint8_t pcie_gen = 0, pcie_width = 0;
 	uint64_t features_supported;
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 4f6df3558b9b..f3cab5e633a7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -846,7 +846,7 @@ struct pptable_funcs {
 	 * &pcie_gen_cap: Maximum allowed PCIe generation.
 	 * &pcie_width_cap: Maximum allowed PCIe width.
 	 */
-	int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
+	int (*update_pcie_parameters)(struct smu_context *smu, uint8_t pcie_gen_cap, uint8_t pcie_width_cap);
 
 	/**
 	 * @i2c_init: Initialize i2c.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 355c156d871a..cc02f979e9e9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -296,8 +296,8 @@ int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu,
 					uint32_t pptable_id);
 
 int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
-				     uint32_t pcie_gen_cap,
-				     uint32_t pcie_width_cap);
+				     uint8_t pcie_gen_cap,
+				     uint8_t pcie_width_cap);
 
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 650482cedd1f..5f3cbfff156a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2380,8 +2380,8 @@ static int navi10_get_power_limit(struct smu_context *smu,
 }
 
 static int navi10_update_pcie_parameters(struct smu_context *smu,
-				     uint32_t pcie_gen_cap,
-				     uint32_t pcie_width_cap)
+					 uint8_t pcie_gen_cap,
+					 uint8_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 1f05bfb7d473..dd07662262e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2092,14 +2092,14 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 #define MAX(a, b)	((a) > (b) ? (a) : (b))
 
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
-					 uint32_t pcie_gen_cap,
-					 uint32_t pcie_width_cap)
+						 uint8_t pcie_gen_cap,
+						 uint8_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
 	uint8_t *table_member1, *table_member2;
-	uint32_t min_gen_speed, max_gen_speed;
-	uint32_t min_lane_width, max_lane_width;
+	uint8_t min_gen_speed, max_gen_speed;
+	uint8_t min_lane_width, max_lane_width;
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index d86499ac8931..208db8b580eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2419,8 +2419,8 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
 }
 
 int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
-				     uint32_t pcie_gen_cap,
-				     uint32_t pcie_width_cap)
+				     uint8_t pcie_gen_cap,
+				     uint8_t pcie_width_cap)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_13_0_pcie_table *pcie_table =
-- 
2.34.1

