Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27F3C678D5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 15:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4601910E5F8;
	Wed,  8 Mar 2023 15:20:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 131C410E5F8
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 15:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmVlmsEdiVXh9LytAbM3WMtLWj4GUuiM4ysVIxfdxs1YRgPYprbZXsja1MO9fwjPwrYsgbr2bjw8ITsAXISShM91MRj8baCOLtU3HbeQtetrQqgjLk7u9gsy8oHBRLW7R5P7mfi86n+fdCwZ7bP5E6pEBRZ3IQWF8+J0zgA7X//H/3siwb7y9WV9C2V7ouGj+tHhSAdtA1RvAyUFE8zzNWL23Ah/UOgENB9DsUjpNaC82uXjy1YArqgJ8TP29985s6U+AKjY6Z64ZaP+ofAZFb9QbDuMSWUUSKkLT7DxM3woWD21IGYtmjy7XUzVHKWRGBGXWA+qF3xbXjcyYwNy8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrC26zbWXR6iuoDqtU5wUi9wE97ABPdKqMMl+ShzY+Y=;
 b=NkK/g7CrfEX8w0IkKNTUbgJi11sELdMZTsxDv+IC3ibABdd1waCLgN8jHuw5app3NbSNLN7aHmNAH4/BrCMTTsDRPr/AdkoEXvA6oGcziU5RYsPF7W4BFT1UrqyzHYsMfM93GyRnhHeKI2FoGkYRxF2lvTJ71DFCgpG2Hi8sSGlfH5/2Bk2hSFsKJ2Mzv6zEJ2TIVSIwK4rPtKUs6GIRotenlj5AJZbvnPS1FSjtGSOsUuJych42zZgq4bNZnUoTy69g2OwPnMBMv28NSd9FuFZopeRd7Ex+l9JVCdgVdlWVSkzPWav2GMYCp7aGng04Yz0HT5OEk0OiigGqwehxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrC26zbWXR6iuoDqtU5wUi9wE97ABPdKqMMl+ShzY+Y=;
 b=cI2HeG9BQsHsFLLdtji8Im/JdxdK637axBbBlET5ASPFksgpecsc+s0A9CvTrNB6upgvK4fgr2VzF0SkD80GmnnJiomtnwQslu5CL1FKnG+lKyzn/K2V9W3MXYoWiso9x8tGBWf9JqGXmGaSlZhVzcIIvxwNvf/fSiJN1PXhoYM=
Received: from BN9PR03CA0146.namprd03.prod.outlook.com (2603:10b6:408:fe::31)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 15:20:30 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::c8) by BN9PR03CA0146.outlook.office365.com
 (2603:10b6:408:fe::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 15:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.17 via Frontend Transport; Wed, 8 Mar 2023 15:20:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Mar
 2023 09:20:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: Fix navi10 incorrect OD volage after resume
Date: Wed, 8 Mar 2023 10:20:14 -0500
Message-ID: <20230308152014.3814372-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308152014.3814372-1-alexander.deucher@amd.com>
References: <20230308152014.3814372-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b69bd6-49ad-401e-06af-08db1fe8a6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2WDXzvDg1FJ+yh1LMZnTc4Dgal+l3e7slb3uhJPIxz5XIiY+MTz8aFYNzyIY2ZK+PE/lFPsRCA628cnZVabQ0ft9ne0fV9smjkn+nAz7Kiwk09n4yZM2HG7grqN9x8xtk6+DvRzXYRs7ACo0rZyzJ3CFKSeRBcVImhEdXWWoKtZuYPWTGuzOYkjSioDc1dwHVv6tn8B3Qth6ZM5fOuQtw5bRQYI/5rEQo71x2m4AHB9Rqd4iSKLbJF7aZMeckYKjq61pBb8jDD8Ryx12FwZgbxCwdWGxfYYUW+b8QZlC40E8i1aF7N3QLvzbFSeckNv4CtdV2jl3a0PkEABWUDOjPh5982S2qEccv9V13CDDc0YzP2c2+TU1iuqNt+AV3bVse65Q/iHAGyOlTPMxFwqRLUiRmL6lAgpYp+50tuTKXWqLHXUt2n6dUi5Tevv9BvJYZImeslZgd7rw8diCb8jCt7s31KDEu2ykPLAqoqgBys2qBn4flGWmC7qBsJyZIpZWXT6qi7QQjcQFVshZTCEt3vw/6l1QGsYVQSyknfsYT6M0ec0H44hCIxsNccfv9BTVNQ7q2jImU6HdukvYc5vUx8yZWhVMzjQEtbQaICW1kp15jLy9aa5p+tpwqld5wmhoOvIVAGod9hbCiNzYXflK9j7oQuchANEkfz4taUQ/YIK/IOhBnhqvXxUkgKWH7nz3gy7PdDI3BRKLjXWk5xFP+5jq9J1W8/iFdrXaO/exSU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(4326008)(36756003)(70206006)(70586007)(8676002)(8936002)(41300700001)(2906002)(6916009)(82740400003)(40480700001)(81166007)(36860700001)(5660300002)(86362001)(7696005)(356005)(1076003)(6666004)(54906003)(478600001)(316002)(47076005)(82310400005)(40460700003)(83380400001)(426003)(66574015)(2616005)(16526019)(186003)(336012)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 15:20:29.7087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b69bd6-49ad-401e-06af-08db1fe8a6fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Always setup overdrive tables after resume. Preserve only some
user-defined settings in user_overdrive_table if they're set.

Copy restored user_overdrive_table into od_table to get correct
values.

On cold boot, BTC was triggered and GfxVfCurve was calibrated. We
got VfCurve settings (a). On resuming back, BTC will be triggered
again and GfxVfCurve will be recalibrated. VfCurve settings (b)
got may be different from those of cold boot.  So if we reuse
those VfCurve settings (a) got on cold boot on suspend, we can
run into discrepencies.

Based on the sienna cichlid patch from Błażej Szczygieł <mumei6102@gmail.com>

Cc: Błażej Szczygieł <mumei6102@gmail.com>
Cc: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 47 +++++++++++++++----
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 95da6dd1cc65..68201d8e1c72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2510,16 +2510,9 @@ static int navi10_set_default_od_settings(struct smu_context *smu)
 		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
 	OverDriveTable_t *user_od_table =
 		(OverDriveTable_t *)smu->smu_table.user_overdrive_table;
+	OverDriveTable_t user_od_table_bak;
 	int ret = 0;
 
-	/*
-	 * For S3/S4/Runpm resume, no need to setup those overdrive tables again as
-	 *   - either they already have the default OD settings got during cold bootup
-	 *   - or they have some user customized OD settings which cannot be overwritten
-	 */
-	if (smu->adev->in_suspend)
-		return 0;
-
 	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)boot_od_table, false);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
@@ -2553,7 +2546,27 @@ static int navi10_set_default_od_settings(struct smu_context *smu)
 	navi10_dump_od_table(smu, boot_od_table);
 
 	memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
-	memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
+
+	/*
+	 * For S3/S4/Runpm resume, we need to setup those overdrive tables again,
+	 * but we have to preserve user defined values in "user_od_table".
+	 */
+	if (!smu->adev->in_suspend) {
+		memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
+		smu->user_dpm_profile.user_od = false;
+	} else if (smu->user_dpm_profile.user_od) {
+		memcpy(&user_od_table_bak, user_od_table, sizeof(OverDriveTable_t));
+		memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
+		user_od_table->GfxclkFmin = user_od_table_bak.GfxclkFmin;
+		user_od_table->GfxclkFmax = user_od_table_bak.GfxclkFmax;
+		user_od_table->UclkFmax = user_od_table_bak.UclkFmax;
+		user_od_table->GfxclkFreq1 = user_od_table_bak.GfxclkFreq1;
+		user_od_table->GfxclkVolt1 = user_od_table_bak.GfxclkVolt1;
+		user_od_table->GfxclkFreq2 = user_od_table_bak.GfxclkFreq2;
+		user_od_table->GfxclkVolt2 = user_od_table_bak.GfxclkVolt2;
+		user_od_table->GfxclkFreq3 = user_od_table_bak.GfxclkFreq3;
+		user_od_table->GfxclkVolt3 = user_od_table_bak.GfxclkVolt3;
+	}
 
 	return 0;
 }
@@ -2733,6 +2746,20 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 	return ret;
 }
 
+static int navi10_restore_user_od_settings(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTable_t *od_table = table_context->overdrive_table;
+	OverDriveTable_t *user_od_table = table_context->user_overdrive_table;
+	int res;
+
+	res = smu_v11_0_restore_user_od_settings(smu);
+	if (res == 0)
+		memcpy(od_table, user_od_table, sizeof(OverDriveTable_t));
+
+	return res;
+}
+
 static int navi10_run_btc(struct smu_context *smu)
 {
 	int ret = 0;
@@ -3560,7 +3587,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_default_od_settings = navi10_set_default_od_settings,
 	.od_edit_dpm_table = navi10_od_edit_dpm_table,
-	.restore_user_od_settings = smu_v11_0_restore_user_od_settings,
+	.restore_user_od_settings = navi10_restore_user_od_settings,
 	.run_btc = navi10_run_btc,
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-- 
2.39.2

