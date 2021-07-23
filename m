Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D36C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 09:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D14A60ED4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 09:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D14A60ED4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA54B6F5CA;
	Fri, 23 Jul 2021 09:10:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18FF6F5CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 09:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyC8H2i6hwA3phdxyhePtYLOPxNNMm4Q0JVI+BvfrpgOMwqAZv8oxQcGiRmJABb5Q8o/8j33F9Uoi3hK5cfONXyGKzNzxBpkMfnC4Bv8s6ScHNAkDSt/wddDmtrAxnM4sLhZ3+nZZUOigsOzomxFLHe+00H8JtlGNhE7mxtuP4iZrSuAgJHYW0CuSR9ZoXxDUTqZRmjmMXNiCHqfIn0xPC+ugQIBt5DF4NTg1sowSXwWurAXhGtRoDY170sEmcJ7HcBQFMK1gaxpKPB0B3ENjis0ZtFSblcl3Oas1fxN+J6wrGNs/P2HSjelu7LvI6O4Nyc9J+7b5BCprcaQTH3BZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvcWgqV06hPYPnmED6ImBUKBlsDw7kFnCaFd031U65Q=;
 b=XIHN04LtoG6q/EFbC0ytwmkTmR60SHoOKRXoz7KEkKmOV1U3BPjD9xPp6TqIg8PfMaXmT2a096U+g2CM5Sc2wI1kdJrBKA9yCricjmZM95zjbBrKdnC/Ks1T3a42ZSRyAVM8FBU1lngqIbmz6ITWdhr40Y6jiDS3eEJy6WPD5SQH1IqbWSHIxV3z2F6tG8VqS4c0ZHJnHkghzOCNiia3QXzy7EBEf25+BJsGcEMOr/mSylHkrF7Skrg8aN9erpKB8q+wAJKazbGG5jrRzwea1wVwoolAbSNGfSp5V4d8OuA64N9LmXFuZqY8Ev3uUGaIIfVRCK4OMSLuJ0PNxv7euQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvcWgqV06hPYPnmED6ImBUKBlsDw7kFnCaFd031U65Q=;
 b=GdVEwbNG9P+Zm0l3t6k4TGdxiOSQnCOZWnDEQC5qkzh4bK9en0S/9wHbKWFqmO2QNAl2y6uS218UI4iyG/cZWAFqVEqK/+aUR9DkLw93zxuY9mSa4uCAv4HfhsSDrTVsit/Qrk6/O4PYo6wHOCNiUzhSTxQq6nxhZyr9lGt+SEM=
Received: from DM5PR10CA0011.namprd10.prod.outlook.com (2603:10b6:4:2::21) by
 MWHPR12MB1328.namprd12.prod.outlook.com (2603:10b6:300:c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25; Fri, 23 Jul 2021 09:10:23 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::76) by DM5PR10CA0011.outlook.office365.com
 (2603:10b6:4:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Fri, 23 Jul 2021 09:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 09:10:23 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 04:10:21 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/2] drm/amd/pm: restore user customized OD settings
 properly for Sienna Cichlid
Date: Fri, 23 Jul 2021 17:10:08 +0800
Message-ID: <20210723091008.806692-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 066057ff-a4ea-4ade-7d5a-08d94db9b3ff
X-MS-TrafficTypeDiagnostic: MWHPR12MB1328:
X-Microsoft-Antispam-PRVS: <MWHPR12MB13282838868C0270CA13B3DBE4E59@MWHPR12MB1328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCjJJC+DuK/V7AQvhgXKrW9w+sgx3uCfjiXKXEsaYHncFNVIEUXr3SSNNy/aOADbZkQoBwmFwR4HAJ6Tj3EgBI+Ut+5593WVJt2jq2qBJCWtkBbR2oqJr8hfzhHGE2u1MXJP8FGn7e8ATStN5r85k7c3UJ85rl/Ddt+yEQhFmbtsnlHPd32I2WQa4WJt1FMUEnawYsUY30U900kMpIb5qzYBIdeYtzNgvnqzLNdocEL3mLUOHbEdHOWGGFsqzuXNkwEYc8A0Ji1aSa6C4CKQxvi9sYeFEneab5CxMJsTnyTJhy3dUjPJUZiluHep0XOt2wQFIILqJwufmiTu9Z0M7SQwUCBM7GKkliWq0t4OeIraa3Yxgu/eLWzN4p+nb/7yLpa+BdhtC+Jj9hLCQiOoBzp0k+TewPrW8G23Mz/WPlrg99wSOkUPkiTYhePeEO6maVgbDkQXxBcxoo+AOhXxXjBWBQ+bS5b/6y5ywnS/90XrCfutzLTxbl2PPp8h4xuyNWx7FYM33rKceWIb4f2PMZHP77ZG+7INnHUiWdnFAtYa+e4JJcBd9HpIavGcwo7uVn+tc9Y6ga9EgER7VvKqYnDc59VHawGxVP82HOzpQEgDG8GwVbSvNppQxOaY4KYJT30DBaPPtYvtVgdMt8XYzK7JZPPqSAXkx5oC1k9oQhBjS0lb0K0kU8T1qw34HOUA2t4mjMIjxCKF+Z90QIWDeGlMuQGf0dLY5IrDOUmW/MY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966006)(36840700001)(47076005)(36756003)(36860700001)(186003)(16526019)(5660300002)(82740400003)(86362001)(8676002)(82310400003)(7696005)(81166007)(70206006)(70586007)(316002)(478600001)(54906003)(26005)(1076003)(2906002)(2616005)(83380400001)(4326008)(66574015)(6916009)(426003)(6666004)(356005)(8936002)(336012)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 09:10:23.2810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066057ff-a4ea-4ade-7d5a-08d94db9b3ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1328
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Properly restore those committed and non-committed user customized OD
settings.

Change-Id: I25396df0b3ecdd7a0d9fc77ed220b0abf1fde020
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 37 ++++++++++++++-----
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e0638dc3f617..7efbdca2d3b1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1954,18 +1954,29 @@ static int sienna_cichlid_set_default_od_settings(struct smu_context *smu)
 		(OverDriveTable_t *)smu->smu_table.overdrive_table;
 	OverDriveTable_t *boot_od_table =
 		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
+	OverDriveTable_t *user_od_table =
+		(OverDriveTable_t *)smu->smu_table.user_overdrive_table;
 	int ret = 0;
 
+	/*
+	 * For S3/S4/Runpm resume, no need to setup those overdrive tables again as
+	 *   - either they already have the default OD settings got during cold bootup
+	 *   - or they have some user customized OD settings which cannot be overwritten
+	 */
+	if (smu->adev->in_suspend)
+		return 0;
+
 	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE,
-				   0, (void *)od_table, false);
+				   0, (void *)boot_od_table, false);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
 		return ret;
 	}
 
-	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
+	sienna_cichlid_dump_od_table(smu, boot_od_table);
 
-	sienna_cichlid_dump_od_table(smu, od_table);
+	memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
+	memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
 
 	return 0;
 }
@@ -2128,13 +2139,20 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
 		fallthrough;
 
 	case PP_OD_COMMIT_DPM_TABLE:
-		sienna_cichlid_dump_od_table(smu, od_table);
+		if (memcmp(od_table, table_context->user_overdrive_table, sizeof(OverDriveTable_t))) {
+			sienna_cichlid_dump_od_table(smu, od_table);
+			ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
+			if (ret) {
+				dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
+				return ret;
+			}
+			memcpy(table_context->user_overdrive_table, od_table, sizeof(OverDriveTable_t));
+			smu->user_dpm_profile.user_od = true;
 
-		ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE,
-					   0, (void *)od_table, true);
-		if (ret) {
-			dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
-			return ret;
+			if (!memcmp(table_context->user_overdrive_table,
+				    table_context->boot_overdrive_table,
+				    sizeof(OverDriveTable_t)))
+				smu->user_dpm_profile.user_od = false;
 		}
 		break;
 
@@ -3902,6 +3920,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_default_od_settings = sienna_cichlid_set_default_od_settings,
 	.od_edit_dpm_table = sienna_cichlid_od_edit_dpm_table,
+	.restore_user_od_settings = smu_v11_0_restore_user_od_settings,
 	.run_btc = sienna_cichlid_run_btc,
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
