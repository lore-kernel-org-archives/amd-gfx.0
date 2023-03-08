Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A363CC64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 15:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2962C10E5FC;
	Wed,  8 Mar 2023 15:20:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6BE10E5F8
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 15:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDjn9iJ/50pupY529EdY8bPCYlcoO6+YZ7/cGRoyBu4Mgc7M5OTDj982+n5pOY/tiMfhs+s0UpzlUxaOQsZ1XsV/8SVYOAf0lb+N4BpxWh8YrhVVz0S/s2sqxAm7H21AHqdATivp+dmNJkJwfvPVfXrtcKNCFI7y7/OP6g/FY3uAy08V1KSPaOOgt7bsggEOkRsGYpJbEoBMU+ArAWZpBFvFh/PCcD4B7UN7UpCI0122fkvLj7c6eSzHPZW6OdefRj3gGXpB9XOVNGfoU4ex6cg9Wimj8Dd6N0W4Da8OlRLpTjGHEr7ZveQ3q/vpw1nXqR16HIQzYrJa35eXVYkgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/AxtiflcMnTfPFNBEcHyAnmtAyNIeByMqv19FU1oT0=;
 b=NcfMOI1N7cezKd7yYHUKXGbZzxBc/w3X5clC8d+sERMmiU7vfE/T7F4O3kx/f3iSaCRgnLX+ekJZw6n5ldfO5Czj8hwjQSVG3j4DfFoa39kZ5Tt2aO3LoDgS0pkoeZoMYnOAERc7rLm81R88CPamuH5vYCrRykyUWd9M7ag5QAW6ZFWcRZNRHHXMvIqTjdEiR6fMVevnjeQR/vpiH9H8I+m6C3RbP5tanQPilGa8Hv/OANyYAe36o8N+RfxYXUKTYF9IzYxGRCh2Qfc7rYyeyNe8NTdDFMvddeV9FSNHvyLjlujh6LBtwed0hd2YHE/CFtZuffPEuJmI2l+rHAY+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/AxtiflcMnTfPFNBEcHyAnmtAyNIeByMqv19FU1oT0=;
 b=M60yyzYPJib0dhXkGk9IS6qGoVYaKbLlQTkVuKnDZ/MKZxr8aOmeu8pGvYUfB+bgIIbg0Qz1FQSJb8WCtArXuPYNqoUfHqFMyb+pzJmdxXEK3USBbuoOzL7PgBWlgVWguLhEEAfXjldJtexFwvgQuVBswGEfTKigFdQJMfC6v6A=
Received: from BN0PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:ea::9)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 15:20:28 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::e) by BN0PR04CA0064.outlook.office365.com
 (2603:10b6:408:ea::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 15:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.18 via Frontend Transport; Wed, 8 Mar 2023 15:20:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Mar
 2023 09:20:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: Fix sienna cichlid incorrect OD volage after
 resume
Date: Wed, 8 Mar 2023 10:20:13 -0500
Message-ID: <20230308152014.3814372-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|SJ0PR12MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: 54825f5a-f818-4065-1cc5-08db1fe8a641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NH2diTwdooRdhQmRpo6foytca/7U93dKVDLLCyO7b4SpdFL/CYSDdwkNAkm029iEKJodE8ARTdeYnwdMq2pKepB4m7iwcqOiIWHbwdPKFip+ESUGHZqWF9Y2MQ0vEiCDltPhKeVCuKTINy7GI1LjMkZwzYpABIcW75A08X7i/xwFUBTPvm+EjoKedpju+dlGABnlc1CTkuArYCo2ZthjXwXZWJDvVchpeDLWKAzsYmkqJEPQpdZ6sv8PX/UzC1ACQCyTWlV1icCcF2Yb21zmR2cXdTXXLpsRwtAS28TxUUCtfSeifWBN99ZhB/qZb3BPqyghzXagCmCj1LBCMqy6sVOzbxa32l28HQ7+NGXsAoW42Fe35fA+ljU5TQ8n9AFfZjp1y9ek2srrUgBsSK7rpO8JqfFNtF9d/d3OJRZQzUfkZZsb0fXKG9/jb8fyOKYbqgvGFWUm218snwB6OixW3DphjEwaZtkszwWIBrXwaOuH+KmrwQN1VbycqtPxfBWtuhMplZTBZLMApJS0hsuV37yRZATsXcqBFal79b9aTFlxBCtmmlvR7PXGBldvsloVqaYbRg2TBGBZi8Hh1DHh8NfGp2D2tZ2hEIkHCVGi0udX2YEcaTqH+Cv3NbMHDN9nWqym5bdTZUUOB6tAl5vqkr+TZ+OUDfZ3Ey7WWzpMHVRdQoqzx3ohoB0XO0hCU6Rdlz1N5nIuuF6zpf4FO2OLPRafZlquaUzC7sq1JxlRWrg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(26005)(82740400003)(36860700001)(66574015)(47076005)(83380400001)(36756003)(478600001)(54906003)(336012)(316002)(356005)(81166007)(7696005)(5660300002)(6666004)(2616005)(426003)(40460700003)(186003)(41300700001)(16526019)(1076003)(4326008)(8936002)(70206006)(2906002)(86362001)(6916009)(70586007)(8676002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 15:20:28.4903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54825f5a-f818-4065-1cc5-08db1fe8a641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469
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

From: Błażej Szczygieł <mumei6102@gmail.com>

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

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Błażej Szczygieł <mumei6102@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 43 ++++++++++++++-----
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 697e98a0a20a..75f18681e984 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2143,16 +2143,9 @@ static int sienna_cichlid_set_default_od_settings(struct smu_context *smu)
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
 	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE,
 				   0, (void *)boot_od_table, false);
 	if (ret) {
@@ -2163,7 +2156,23 @@ static int sienna_cichlid_set_default_od_settings(struct smu_context *smu)
 	sienna_cichlid_dump_od_table(smu, boot_od_table);
 
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
+		user_od_table->UclkFmin = user_od_table_bak.UclkFmin;
+		user_od_table->UclkFmax = user_od_table_bak.UclkFmax;
+		user_od_table->VddGfxOffset = user_od_table_bak.VddGfxOffset;
+	}
 
 	return 0;
 }
@@ -2373,6 +2382,20 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 	return ret;
 }
 
+static int sienna_cichlid_restore_user_od_settings(struct smu_context *smu)
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
 static int sienna_cichlid_run_btc(struct smu_context *smu)
 {
 	int res;
@@ -4400,7 +4423,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_default_od_settings = sienna_cichlid_set_default_od_settings,
 	.od_edit_dpm_table = sienna_cichlid_od_edit_dpm_table,
-	.restore_user_od_settings = smu_v11_0_restore_user_od_settings,
+	.restore_user_od_settings = sienna_cichlid_restore_user_od_settings,
 	.run_btc = sienna_cichlid_run_btc,
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-- 
2.39.2

