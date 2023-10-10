Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB3FCD6134
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A08210E0A0;
	Tue, 10 Oct 2023 10:00:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813B110E0A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3lYFCsmnT1aYsnEX3VvL4w8cmNtJPN/p97YUnXcdfX1RQgmzLCQVsFwJgP2wfw2rOvZJYWCq57Nw08WPm6PqaVxw0j/rby+QSQSkJf9f+rk1NY0DViWxMaM3qncv904CRiixQ/jrjnkR1XgrePFrzLudqngTz1nLyB3cg/U3ddZk6lceyfLzfn8adqb8paFW8Dtx68Se6qvvGqFHopiThB08Olei7ZANm8C1TK1NFBlxw4V7VhNwegfe4TPxQp2V+221gn5us1nDOW0bJEezpsfrmD5731agkadT5WoRCxWdneddh+8vsRAyQGxkNE1fBIkJbbbDFmlf0h1+D7EHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1P6m/CEZ+ytN7CncFk7xv+U6qmVu9VWHIkW8nUx/OY=;
 b=LfrNN0bX3WWcqQgGb4Nxh592Ex9+pRS58CRdHu7s0fS6vmTey73JtBguIb5pEc+J+ZQafZs/o+zXSFh+upslvDSljUBtnyN5kR6jTK2HY7R1wpsDG7kM3oEbFe73faeCScyNDP0TQf9ctxJbwZ8NL0smDB6plEQbYFDlyYKMnRtXy6gbWlt7kyhtfVhChG4EcRc11YWU0vjvMOZ7UosOKbeleUC8fPaqv/siyJ71CynTzCxAl7fFN14JOTaUX/6ZlEjn2SksaVnXyA3ZfaKs/svT9BijS8eMZAV7r+DlSFRQ3tMa6qhhXUIozmt7//bVbA7v9J8L+vRynMncdQThdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1P6m/CEZ+ytN7CncFk7xv+U6qmVu9VWHIkW8nUx/OY=;
 b=hbCgYqDVb5SM6LU2KAbDk4DxMHIaSFkovCgDl35y4yrKW9+iVqpbgkCv5bR+9Hej2pAOjfUZYJPADHEVsYdpiC9vJm5eWOpLd7ceLe+rJMKjoxbcyVFYcPPMVadIeu5HLquP15exhyVcu/2QbIochquN2qWXkedRgaMH8S7CNCI=
Received: from CH0PR03CA0444.namprd03.prod.outlook.com (2603:10b6:610:10e::12)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 10:00:52 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::89) by CH0PR03CA0444.outlook.office365.com
 (2603:10b6:610:10e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29 via Frontend
 Transport; Tue, 10 Oct 2023 10:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:00:51 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:00:45 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Add reset option for fan_ctrl interfaces
Date: Tue, 10 Oct 2023 18:00:21 +0800
Message-ID: <20231010100022.1023882-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: f1529c94-43bb-4fe2-f85b-08dbc977c8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/WJzEJjAPU5UxnubiNIkGnSECx4HCdKuPSftoQJ6n1DQ/pth4CmAg1zI5ZwqjEmJs5sdvrReZqe8qm0ecBzxhYtdVel3fTygj0Gzdwxrq/Pxu/Ng/RtlZAIl/t9ziB1F3Y1/vnwkxM5LEIXLBmwklYLCUtxNTwtQm3+cIU68IfQ45WYWc2mG1LCc+p0ZhKV/KQH+zhF7Y20qXhp2iO0Lddai+wr3FZMBi5WtgAD0Nn5pP3HkBs7Gui/qA6kYrEtNhRrMka5ZNgqIriyL1Z9iCtd2lwEAFrWOc4Xujydcmq/o+aQ5X9y97rpCaM6S2dHFllG5njIsyujcpLDzzwuKp/8UANkQzpiCgNP7xUJSzH6zBvIrPD7EGymjXwNDK9kIhYdkCqz+x5iBuXGdYKk4zySflMND+jd6CYZB6dWaPwOmL724Tr32GKw/ReTdw06+qxBmjS75rxr66PIjZOBLNfMQX9ww98+MGATE7zjmWlnIS1wdpZ6arwnEagnHNGBFxvilkhJxRYSd/NIbAWP5UZJZz50UkyXF0wUYBMcbbFazuwztgmsuGcIaiLoJMcDtZ2F3zMcnnn6escUOmkszH3KIa59b/REl0Z8mNq8ChnAi2GlpcudNMGzlcjHU07V/2h/paogDO0u7I5wVlO4SB++06ALh62J2u1EXhGAgOjgnQ3yJ9uAao2SPt9aYWk8MmzRBopatQyqNIPhj/JyCCahENHq8j1coimbnPK1pZa17NQsVcYFuwk+PpcKtpY5DgIykFgKQauNN2hZig43uCsxw4MeyZMz6ubcjS93uwI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(40470700004)(46966006)(36840700001)(86362001)(82740400003)(356005)(81166007)(36756003)(40480700001)(478600001)(2906002)(7696005)(5660300002)(41300700001)(4326008)(8676002)(8936002)(6666004)(63350400001)(1076003)(63370400001)(336012)(426003)(83380400001)(2616005)(40460700003)(54906003)(70586007)(316002)(110136005)(70206006)(16526019)(6636002)(36860700001)(26005)(47076005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:00:51.0673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1529c94-43bb-4fe2-f85b-08dbc977c8da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add reset option for fan_ctrl interfaces.

For example:
User can use the "echo r > acoustic_limit_rpm_threshold" command
to reset acoustic_limit_rpm_threshold to boot value

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 12 ++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 24 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 4c65a2fac028..c7c29aa24c36 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3680,6 +3680,9 @@ static umode_t fan_curve_visible(struct amdgpu_device *adev)
  * When you have finished the editing, write "c" (commit) to the file to commit
  * your changes.
  *
+ * If you want to reset to the default value, write "r" (reset) to the file to
+ * reset them
+ *
  * This setting works under auto fan control mode only. It adjusts the PMFW's
  * behavior about the maximum speed in RPM the fan can spin. Setting via this
  * interface will switch the fan control to auto mode implicitly.
@@ -3735,6 +3738,9 @@ static umode_t acoustic_limit_threshold_visible(struct amdgpu_device *adev)
  * When you have finished the editing, write "c" (commit) to the file to commit
  * your changes.
  *
+ * If you want to reset to the default value, write "r" (reset) to the file to
+ * reset them
+ *
  * This setting works under auto fan control mode only. It can co-exist with
  * other settings which can work also under auto mode. It adjusts the PMFW's
  * behavior about the maximum speed in RPM the fan can spin when ASIC
@@ -3792,6 +3798,9 @@ static umode_t acoustic_target_threshold_visible(struct amdgpu_device *adev)
  * When you have finished the editing, write "c" (commit) to the file to commit
  * your changes.
  *
+ * If you want to reset to the default value, write "r" (reset) to the file to
+ * reset them
+ *
  * This setting works under auto fan control mode only. It can co-exist with
  * other settings which can work also under auto mode. Paring with the
  * acoustic_target_rpm_threshold setting, they define the maximum speed in
@@ -3850,6 +3859,9 @@ static umode_t fan_target_temperature_visible(struct amdgpu_device *adev)
  * When you have finished the editing, write "c" (commit) to the file to commit
  * your changes.
  *
+ * If you want to reset to the default value, write "r" (reset) to the file to
+ * reset them
+ *
  * This setting works under auto fan control mode only. It can co-exist with
  * other settings which can work also under auto mode. It adjusts the PMFW's
  * behavior about the minimum fan speed in PWM the fan should spin. Setting
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 47d008cbc186..4ddaa372604a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1533,6 +1533,30 @@ static int smu_v13_0_0_od_restore_table_single(struct smu_context *smu, long inp
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
+	case PP_OD_EDIT_ACOUSTIC_LIMIT:
+		od_table->OverDriveTable.AcousticLimitRpmThreshold =
+					boot_overdrive_table->OverDriveTable.AcousticLimitRpmThreshold;
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+	case PP_OD_EDIT_ACOUSTIC_TARGET:
+		od_table->OverDriveTable.AcousticTargetRpmThreshold =
+					boot_overdrive_table->OverDriveTable.AcousticTargetRpmThreshold;
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
+		od_table->OverDriveTable.FanTargetTemperature =
+					boot_overdrive_table->OverDriveTable.FanTargetTemperature;
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+	case PP_OD_EDIT_FAN_MINIMUM_PWM:
+		od_table->OverDriveTable.FanMinimumPwm =
+					boot_overdrive_table->OverDriveTable.FanMinimumPwm;
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
 	default:
 		dev_info(adev->dev, "Invalid table index: %ld\n", input);
 		return -EINVAL;
-- 
2.34.1

