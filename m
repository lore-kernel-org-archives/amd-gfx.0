Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AABC7EE24
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 01:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22F110E20A;
	Thu,  1 Jun 2023 01:59:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D1E610E207
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 01:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxxYN5mmZPQfYuC7IhptnSvKpa6/HZMIktMuBZKTaOxhKL9dQGh21MVhnzJa8JF2vC6bEYt1Iwr6TtUFhCZ8Pd0oHwbEOQuqzdrZMGjlH4+COGNbMvu1bQD05rSWcpHq6K6g7AChCqEt7WJt+QIy6SGUxLzK0miL1wZwo5PCOHDUB9N6IqlIqwclc5GEaU3XfvQUg3GKzMDLALwuULytH0hMUefqf6eUf5mzQgSI58+Rg/FJ2BlkuWoYvhkxko/iR0yE4EZ8Hm/caFfGCqUUrnoORdvV9T2I/uc3aOlXur3yiVY2PhgBqS/lFQu3nOdytCpx21DR7jr/IZMYvHM+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6P/op9ibOtpkuYep7vzDKu9QkFGvZ5Lj4YPUBzPaRU=;
 b=AmsfGbemOFf0w8Qkkf9sHud+EBtQBs7b63YszsE2zXemTT6bXoNXQaDLUgNeEaYIDxIOiyjT++CBJ4rcynlqV6LYluMaN7WXGHvv1blvnN53la0Zy3ytQq63DuodDLQx2DXhmgn3lGlY9Pl4tZjOn5cfJ0t8AnPvmwRCUMZPtCs37UpdDofYoPKOJGHRqWHOnUFEXWoySERgbYE2r4ctFh0bFUlqqUm+GYA/Ac+ru5ZcMdQLN/bAKhceoa9LLsIvjNi6sSEDBORUQBPMSUaEl1cRkK4H1oMNu01Dp6LmSphAW5lTjePiTi8qzmfs4W2YszS35ksSasvRssklMB/frw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6P/op9ibOtpkuYep7vzDKu9QkFGvZ5Lj4YPUBzPaRU=;
 b=kllZUW+mIE5sZ00BYXFOKIu3/pR6B4I9CTt0MfqaXeCuDS0PfPMPRUS+TswJAfURRnmLCRmIm7bnUvDYaXjrJWqlxPdfsDJVtvuS0sFxzhnqigLshd4bRR+F2836b6KYYVK7nhmP+UJFVNOF090PoJjtHsgf63DtgOsFk4MySpU=
Received: from BN9PR03CA0208.namprd03.prod.outlook.com (2603:10b6:408:f9::33)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 01:59:36 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::70) by BN9PR03CA0208.outlook.office365.com
 (2603:10b6:408:f9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 01:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 01:59:35 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 20:59:33 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amd/pm: fulfill SMU13 OD settings init and restore
Date: Thu, 1 Jun 2023 09:59:03 +0800
Message-ID: <20230601015905.49427-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601015905.49427-1-evan.quan@amd.com>
References: <20230601015905.49427-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c78d72-9002-4705-9986-08db6243d99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpucHqA2XhhtlZ8ffjyjpRQeqw08VU+mKvKxl8hW5dwq3Q2h7JmWlygWPpS/SMnqDtau0r9lgBp99fwPixhoT6A92rvVT1icU/xq7++Nhnp1OU5JymF4CoO06sXbVD3aHW8FbpoQvaWxWsI2iFVsfykCIdncn6Y1wRk37f2Qw1NRKotX3+wDQEeFIKfQ4atg4oYDqJ/OycsvbSUFdEA3V6ecKKy2+MhMqiXjYwzhwCUfzF0Me4QQ3RfJPuYJN9uuaOoAQwwL3olj7af+SIED3lu1UYvXRpDnrxnQx7siQU7faIsytCgTIgOqjAKJJylcCehoPqhN3kMxRjw0DvSxyhm4YMTcB4DNLKZ6E9NIPVeLpQfQ40uNnvbST3xTlu1iU244KKpwM1XS1rdLyo5lOPHyz/Qd77aHB4X4XQg9aS9btBMqLXJji5Lw6zisQ83Wj2lkWrfpDlt22bWI/tkIwv+u9ED4Ko9bryrZhPY6/fRseuibsvszULooBLWAnfab/Kh+Ill3oRyZKyYRyJjxbryowI7LHv/ZrOQhTSi4KO/WIybSM2gh+QsYx83kSa+8Q7SvVFj39KHAV1Cq8pG37cVQQYCaMIBUHkKJCa/r6DsKAWJt6n9DraL1v0M2q37VwKslsijTCFgToyq3GWJ8sS5/APuFatemp7Rs3QSLlJe8MdyxonzZmPrHBdA+1yQEzz5wjG573a8MP12K4UHBC65PnSo93yMpYotOotd/GmjCaJi9bX4rS9ikmF+Ie1e/RsAbVPbmEd9QZg/IOYGBHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(44832011)(47076005)(6666004)(41300700001)(83380400001)(7696005)(186003)(16526019)(316002)(36860700001)(1076003)(26005)(8936002)(82310400005)(86362001)(2616005)(40480700001)(40460700003)(336012)(426003)(5660300002)(8676002)(30864003)(36756003)(2906002)(81166007)(82740400003)(356005)(54906003)(478600001)(6916009)(4326008)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 01:59:35.5994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c78d72-9002-4705-9986-08db6243d99c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Gfxclk fmin/fmax, Uclk fmin/fmax and Gfx v/f curve voltage offset
OD settings are supported for SMU13.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  26 +++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  13 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 129 +++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 128 ++++++++++++++++-
 4 files changed, 286 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index da0da03569e8..a57952b93e73 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -678,7 +678,12 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  *   clock labeled OD_MCLK
  *
  * - three <frequency, voltage> points labeled OD_VDDC_CURVE.
- *   They can be used to calibrate the sclk voltage curve.
+ *   They can be used to calibrate the sclk voltage curve. This is
+ *   available for Vega20 and NV1X.
+ *
+ * - voltage offset for the six anchor points of the v/f curve labeled
+ *   OD_VDDC_CURVE. They can be used to calibrate the v/f curve. This
+ *   is only availabe for some SMU13 ASICs.
  *
  * - voltage offset(in mV) applied on target voltage calculation.
  *   This is available for Sienna Cichlid, Navy Flounder and Dimgrey
@@ -719,12 +724,19 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  *   E.g., "p 2 0 800" would set the minimum core clock on core
  *   2 to 800Mhz.
  *
- *   For sclk voltage curve, enter the new values by writing a
- *   string that contains "vc point clock voltage" to the file. The
- *   points are indexed by 0, 1 and 2. E.g., "vc 0 300 600" will
- *   update point1 with clock set as 300Mhz and voltage as
- *   600mV. "vc 2 1000 1000" will update point3 with clock set
- *   as 1000Mhz and voltage 1000mV.
+ *   For sclk voltage curve,
+ *     - For NV1X, enter the new values by writing a string that
+ *       contains "vc point clock voltage" to the file. The points
+ *       are indexed by 0, 1 and 2. E.g., "vc 0 300 600" will update
+ *       point1 with clock set as 300Mhz and voltage as 600mV. "vc 2
+ *       1000 1000" will update point3 with clock set as 1000Mhz and
+ *       voltage 1000mV.
+ *     - For SMU13 ASICs, enter the new values by writing a string that
+ *       contains "vc anchor_point_index voltage_offset" to the file.
+ *       There are total six anchor points defined on the v/f curve with
+ *       index as 0 - 5.
+ *       - "vc 0 10" will update the voltage offset for point1 as 10mv.
+ *       - "vc 5 -10" will update the voltage offset for point6 as -10mv.
  *
  *   To update the voltage offset applied for gfxclk/voltage calculation,
  *   enter the new value by writing a string that contains "vo offset".
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 54b9930ff599..9295dbe06200 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -467,17 +467,26 @@ int smu_v13_0_init_smc_tables(struct smu_context *smu)
 			ret = -ENOMEM;
 			goto err3_out;
 		}
+
+		smu_table->user_overdrive_table =
+			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
+		if (!smu_table->user_overdrive_table) {
+			ret = -ENOMEM;
+			goto err4_out;
+		}
 	}
 
 	smu_table->combo_pptable =
 		kzalloc(tables[SMU_TABLE_COMBO_PPTABLE].size, GFP_KERNEL);
 	if (!smu_table->combo_pptable) {
 		ret = -ENOMEM;
-		goto err4_out;
+		goto err5_out;
 	}
 
 	return 0;
 
+err5_out:
+	kfree(smu_table->user_overdrive_table);
 err4_out:
 	kfree(smu_table->boot_overdrive_table);
 err3_out:
@@ -497,12 +506,14 @@ int smu_v13_0_fini_smc_tables(struct smu_context *smu)
 
 	kfree(smu_table->gpu_metrics_table);
 	kfree(smu_table->combo_pptable);
+	kfree(smu_table->user_overdrive_table);
 	kfree(smu_table->boot_overdrive_table);
 	kfree(smu_table->overdrive_table);
 	kfree(smu_table->max_sustainable_clocks);
 	kfree(smu_table->driver_pptable);
 	smu_table->gpu_metrics_table = NULL;
 	smu_table->combo_pptable = NULL;
+	smu_table->user_overdrive_table = NULL;
 	smu_table->boot_overdrive_table = NULL;
 	smu_table->overdrive_table = NULL;
 	smu_table->max_sustainable_clocks = NULL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3fd6d10eac25..2a9840c54f72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -239,6 +239,7 @@ static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(WIFIBAND),
 	TAB_MAP(I2C_COMMANDS),
 	TAB_MAP(ECCINFO),
+	TAB_MAP(OVERDRIVE),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
@@ -333,6 +334,11 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 	struct smu_13_0_0_powerplay_table *powerplay_table =
 		table_context->power_play_table;
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	const OverDriveLimits_t * const overdrive_upperlimits =
+				&pptable->SkuTable.OverDriveLimitsBasicMax;
+	const OverDriveLimits_t * const overdrive_lowerlimits =
+				&pptable->SkuTable.OverDriveLimitsMin;
 
 	if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_HARDWAREDC)
 		smu->dc_controlled_by_gpio = true;
@@ -344,6 +350,10 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 	if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
 		smu_baco->maco_support = true;
 
+	if (!overdrive_lowerlimits->FeatureCtrlMask ||
+	    !overdrive_upperlimits->FeatureCtrlMask)
+		smu->od_enabled = false;
+
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
 
@@ -463,7 +473,7 @@ static int smu_v13_0_0_tables_init(struct smu_context *smu)
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-	SMU_TABLE_INIT(tables, SMU_TABLE_OVERDRIVE, sizeof(OverDriveTable_t),
+	SMU_TABLE_INIT(tables, SMU_TABLE_OVERDRIVE, sizeof(OverDriveTableExternal_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU13_TOOL_SIZE,
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -1358,6 +1368,121 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static int smu_v13_0_0_get_overdrive_table(struct smu_context *smu,
+					   OverDriveTableExternal_t *od_table)
+{
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_OVERDRIVE,
+				   0,
+				   (void *)od_table,
+				   false);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
+
+	return ret;
+}
+
+static int smu_v13_0_0_upload_overdrive_table(struct smu_context *smu,
+					      OverDriveTableExternal_t *od_table)
+{
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_OVERDRIVE,
+				   0,
+				   (void *)od_table,
+				   true);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
+
+	return ret;
+}
+
+static void smu_v13_0_0_dump_od_table(struct smu_context *smu,
+				      OverDriveTableExternal_t *od_table)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	dev_dbg(adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->OverDriveTable.GfxclkFmin,
+						     od_table->OverDriveTable.GfxclkFmax);
+	dev_dbg(adev->dev, "OD: Uclk: (%d, %d)\n", od_table->OverDriveTable.UclkFmin,
+						   od_table->OverDriveTable.UclkFmax);
+}
+
+static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
+{
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
+	OverDriveTableExternal_t *boot_od_table =
+		(OverDriveTableExternal_t *)smu->smu_table.boot_overdrive_table;
+	OverDriveTableExternal_t *user_od_table =
+		(OverDriveTableExternal_t *)smu->smu_table.user_overdrive_table;
+	OverDriveTableExternal_t user_od_table_bak;
+	int ret = 0;
+	int i;
+
+	ret = smu_v13_0_0_get_overdrive_table(smu, boot_od_table);
+	if (ret)
+		return ret;
+
+	smu_v13_0_0_dump_od_table(smu, boot_od_table);
+
+	memcpy(od_table,
+	       boot_od_table,
+	       sizeof(OverDriveTableExternal_t));
+
+	/*
+	 * For S3/S4/Runpm resume, we need to setup those overdrive tables again,
+	 * but we have to preserve user defined values in "user_od_table".
+	 */
+	if (!smu->adev->in_suspend) {
+		memcpy(user_od_table,
+		       boot_od_table,
+		       sizeof(OverDriveTableExternal_t));
+		smu->user_dpm_profile.user_od = false;
+	} else if (smu->user_dpm_profile.user_od) {
+		memcpy(&user_od_table_bak,
+		       user_od_table,
+		       sizeof(OverDriveTableExternal_t));
+		memcpy(user_od_table,
+		       boot_od_table,
+		       sizeof(OverDriveTableExternal_t));
+		user_od_table->OverDriveTable.GfxclkFmin =
+				user_od_table_bak.OverDriveTable.GfxclkFmin;
+		user_od_table->OverDriveTable.GfxclkFmax =
+				user_od_table_bak.OverDriveTable.GfxclkFmax;
+		user_od_table->OverDriveTable.UclkFmin =
+				user_od_table_bak.OverDriveTable.UclkFmin;
+		user_od_table->OverDriveTable.UclkFmax =
+				user_od_table_bak.OverDriveTable.UclkFmax;
+		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
+			user_od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i] =
+				user_od_table_bak.OverDriveTable.VoltageOffsetPerZoneBoundary[i];
+	}
+
+	return 0;
+}
+
+static int smu_v13_0_0_restore_user_od_settings(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *od_table = table_context->overdrive_table;
+	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
+	int res;
+
+	user_od_table->OverDriveTable.FeatureCtrlMask = 1U << PP_OD_FEATURE_GFXCLK_BIT |
+							1U << PP_OD_FEATURE_UCLK_BIT |
+							1U << PP_OD_FEATURE_GFX_VF_CURVE_BIT;
+	res = smu_v13_0_0_upload_overdrive_table(smu, user_od_table);
+	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
+	if (res == 0)
+		memcpy(od_table, user_od_table, sizeof(OverDriveTableExternal_t));
+
+	return res;
+}
+
 static int smu_v13_0_0_populate_umd_state_clk(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context =
@@ -2190,6 +2315,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.notify_memory_pool_location = smu_v13_0_notify_memory_pool_location,
 	.get_gpu_metrics = smu_v13_0_0_get_gpu_metrics,
 	.set_soft_freq_limited_range = smu_v13_0_set_soft_freq_limited_range,
+	.set_default_od_settings = smu_v13_0_0_set_default_od_settings,
+	.restore_user_od_settings = smu_v13_0_0_restore_user_od_settings,
 	.init_pptable_microcode = smu_v13_0_init_pptable_microcode,
 	.populate_umd_state_clk = smu_v13_0_0_populate_umd_state_clk,
 	.set_performance_level = smu_v13_0_set_performance_level,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 44f934fafd51..3ba88033c766 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -208,6 +208,7 @@ static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(ACTIVITY_MONITOR_COEFF),
 	[SMU_TABLE_COMBO_PPTABLE] = {1, TABLE_COMBO_PPTABLE},
 	TAB_MAP(WIFIBAND),
+	TAB_MAP(OVERDRIVE),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
@@ -324,6 +325,10 @@ static int smu_v13_0_7_check_powerplay_table(struct smu_context *smu)
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 	PPTable_t *smc_pptable = table_context->driver_pptable;
 	BoardTable_t *BoardTable = &smc_pptable->BoardTable;
+	const OverDriveLimits_t * const overdrive_upperlimits =
+				&smc_pptable->SkuTable.OverDriveLimitsBasicMax;
+	const OverDriveLimits_t * const overdrive_lowerlimits =
+				&smc_pptable->SkuTable.OverDriveLimitsMin;
 
 	if (powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_HARDWAREDC)
 		smu->dc_controlled_by_gpio = true;
@@ -335,6 +340,10 @@ static int smu_v13_0_7_check_powerplay_table(struct smu_context *smu)
 	if (smu_baco->platform_support && (BoardTable->HsrEnabled || BoardTable->VddqOffEnabled))
 		smu_baco->maco_support = true;
 
+	if (!overdrive_lowerlimits->FeatureCtrlMask ||
+	    !overdrive_upperlimits->FeatureCtrlMask)
+		smu->od_enabled = false;
+
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
 
@@ -481,7 +490,7 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-	SMU_TABLE_INIT(tables, SMU_TABLE_OVERDRIVE, sizeof(OverDriveTable_t),
+	SMU_TABLE_INIT(tables, SMU_TABLE_OVERDRIVE, sizeof(OverDriveTableExternal_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU13_TOOL_SIZE,
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -1345,6 +1354,121 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static int smu_v13_0_7_get_overdrive_table(struct smu_context *smu,
+					   OverDriveTableExternal_t *od_table)
+{
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_OVERDRIVE,
+				   0,
+				   (void *)od_table,
+				   false);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
+
+	return ret;
+}
+
+static int smu_v13_0_7_upload_overdrive_table(struct smu_context *smu,
+					      OverDriveTableExternal_t *od_table)
+{
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_OVERDRIVE,
+				   0,
+				   (void *)od_table,
+				   true);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
+
+	return ret;
+}
+
+static void smu_v13_0_7_dump_od_table(struct smu_context *smu,
+				      OverDriveTableExternal_t *od_table)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	dev_dbg(adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->OverDriveTable.GfxclkFmin,
+						     od_table->OverDriveTable.GfxclkFmax);
+	dev_dbg(adev->dev, "OD: Uclk: (%d, %d)\n", od_table->OverDriveTable.UclkFmin,
+						   od_table->OverDriveTable.UclkFmax);
+}
+
+static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
+{
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
+	OverDriveTableExternal_t *boot_od_table =
+		(OverDriveTableExternal_t *)smu->smu_table.boot_overdrive_table;
+	OverDriveTableExternal_t *user_od_table =
+		(OverDriveTableExternal_t *)smu->smu_table.user_overdrive_table;
+	OverDriveTableExternal_t user_od_table_bak;
+	int ret = 0;
+	int i;
+
+	ret = smu_v13_0_7_get_overdrive_table(smu, boot_od_table);
+	if (ret)
+		return ret;
+
+	smu_v13_0_7_dump_od_table(smu, boot_od_table);
+
+	memcpy(od_table,
+	       boot_od_table,
+	       sizeof(OverDriveTableExternal_t));
+
+	/*
+	 * For S3/S4/Runpm resume, we need to setup those overdrive tables again,
+	 * but we have to preserve user defined values in "user_od_table".
+	 */
+	if (!smu->adev->in_suspend) {
+		memcpy(user_od_table,
+		       boot_od_table,
+		       sizeof(OverDriveTableExternal_t));
+		smu->user_dpm_profile.user_od = false;
+	} else if (smu->user_dpm_profile.user_od) {
+		memcpy(&user_od_table_bak,
+		       user_od_table,
+		       sizeof(OverDriveTableExternal_t));
+		memcpy(user_od_table,
+		       boot_od_table,
+		       sizeof(OverDriveTableExternal_t));
+		user_od_table->OverDriveTable.GfxclkFmin =
+				user_od_table_bak.OverDriveTable.GfxclkFmin;
+		user_od_table->OverDriveTable.GfxclkFmax =
+				user_od_table_bak.OverDriveTable.GfxclkFmax;
+		user_od_table->OverDriveTable.UclkFmin =
+				user_od_table_bak.OverDriveTable.UclkFmin;
+		user_od_table->OverDriveTable.UclkFmax =
+				user_od_table_bak.OverDriveTable.UclkFmax;
+		for (i = 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
+			user_od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[i] =
+				user_od_table_bak.OverDriveTable.VoltageOffsetPerZoneBoundary[i];
+	}
+
+	return 0;
+}
+
+static int smu_v13_0_7_restore_user_od_settings(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *od_table = table_context->overdrive_table;
+	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
+	int res;
+
+	user_od_table->OverDriveTable.FeatureCtrlMask = 1U << PP_OD_FEATURE_GFXCLK_BIT |
+							1U << PP_OD_FEATURE_UCLK_BIT |
+							1U << PP_OD_FEATURE_GFX_VF_CURVE_BIT;
+	res = smu_v13_0_7_upload_overdrive_table(smu, user_od_table);
+	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
+	if (res == 0)
+		memcpy(od_table, user_od_table, sizeof(OverDriveTableExternal_t));
+
+	return res;
+}
+
 static int smu_v13_0_7_populate_umd_state_clk(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context =
@@ -1799,6 +1923,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.notify_memory_pool_location = smu_v13_0_notify_memory_pool_location,
 	.get_gpu_metrics = smu_v13_0_7_get_gpu_metrics,
 	.set_soft_freq_limited_range = smu_v13_0_set_soft_freq_limited_range,
+	.set_default_od_settings = smu_v13_0_7_set_default_od_settings,
+	.restore_user_od_settings = smu_v13_0_7_restore_user_od_settings,
 	.set_performance_level = smu_v13_0_set_performance_level,
 	.gfx_off_control = smu_v13_0_gfx_off_control,
 	.get_fan_speed_pwm = smu_v13_0_7_get_fan_speed_pwm,
-- 
2.34.1

