Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D2AEE7FF4
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 05:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A923C10E030;
	Mon, 11 Sep 2023 05:54:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23D910E030
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Sep 2023 05:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpsJpYYuGQPqyLlDFOvDbrcjVPhozDjNW/ccoMCXh5855NROOO+Ho+M9ue26I+aDgu4/vY/k7slRgIFigbhKtYztzRX0VoA1qe62hfBYTv72GuB/e/9nawIeyQ3uRoQOeXiK+4GPFwFPb41JUYUWUjOGYeEQJIGCNWh2NHZsdaTcd/pCAiaeBbxbdNlnvF9OCVUKOc0OKqOBdq1ZjOXyOMFLe4Z1QDfL3YOvN6vbOT1w2slvf8v99J5YEoPJZ7tzqh0LVKyGt8DeCXaqV0BkQv5f8/bmbuUmHU+75kttvSXoZe2u94APIg37ZVHYjYZPFZRUQgpgN13x+LLxg3CPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waaLXTw7tXjivj3/XTXSbGHBifKwgg/vnaNWrf0LHoo=;
 b=V2hgBonlWV5ljecvqc2GmcrE4jZ8nGush7/S3Jf1fyCpeRBrGSYmIp7UD87cqP80tMIbppad3k7U/WCn+5nWOEa5/wXj4Izh3qGUYeyVOidfIOzVCRguJlrAutNXieidqdD+vkZpFnFlgoOh4ZwRXtjCUb3+bqqeEesnwTO+rjw+PEVwLYyu/AB0jzdanoCds15Zph89w4azl+PbH479EhFWk22GVAlR0To0X4Y6UYRM9f9+Ziwa5SEU/6B5cltx2QgegXHnDfiBJ3Lu9L7czIkyqgYta00/H6yj4VjEdGoQs2oZ9yd3rLpGe74lLQknPcpfHVpoYbXcT6vJUIas8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waaLXTw7tXjivj3/XTXSbGHBifKwgg/vnaNWrf0LHoo=;
 b=H6ZxBJl7z/i/onnKxknfSsXXGpKeioDHJQ2G8esoyG+DPnKZV/piiO4DYkGXZ7pK0vtwZWXvets8mEZJ97+xxrw7x4jTJYT38z6tebS5XpYk3Nv8QUDkju7bGMcVJavbtHbPoCjJdYnLhAlegIu/JeBG97iuYZatd8L4Ti+BJC0=
Received: from MW4PR04CA0257.namprd04.prod.outlook.com (2603:10b6:303:88::22)
 by DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Mon, 11 Sep 2023 05:54:15 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::f0) by MW4PR04CA0257.outlook.office365.com
 (2603:10b6:303:88::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 05:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 05:54:15 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 00:54:12 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Add reset option for fan_curve on smu13_0_0
Date: Mon, 11 Sep 2023 13:53:50 +0800
Message-ID: <20230911055350.3940534-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DM4PR12MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4c1c04-e02b-4d18-0435-08dbb28b87f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2if2dmvoS5wUZ2Xa6Yny0G5kL20kySWPxSWZke9ZOxjj3baZHqbH//Ceo8Hy1H7zvLCo8+/Mo7s6nhoPk1dLWMhLG1r78Ig3ftsyI4WepO3P5ZJ1x0d8isiixSSQaAx/1sD4619IQRMMWr5qdusJ6gE1ztXFzVcGXbbXsoi0R8tIvcSXIOocWDMFU4ioB8gkRAZmOyeMydN5fILquHv3Dpz+UcWup+hHOZZDwAEZcaqFx91uEJ7Bh9e4P+cOviKVzVd6eTSNFKmTKknlr68hzpyWUsKgb/SvJKQO3H0mR6+NSy9tTS+ZToRHyLAceNaal8RhW+27AhBcCoBQ0siLn1mMbzuLoii69S3r9qBZEwTYJTQk/TA4vIv4P4Zc2T3UTV9jeOP7BieVrc++AwQgEvhpniNMSw1FpMhdQF9izQBuh263D/3xOhw6eyxZZ8C7Jnb1WebcMCaQRau/jVak/wm5hojwFIOWHXNQZ5QlP1KQF4pfoRIjnZEdN301YD0KnozQ4xzsDDOAeqIDIU6IV4XYKGdRXututkjGQReWwAZdJItxBQcZV15yywaptySqeKsNtVM8HntFtjk+MgHFf4LYgm7P39d94IPzmyTj+CsCHzfRU0BVTTUpzK/AOZmg1VA6quUaXVQTIbYWpEWUN6x/0yNTWJcmCO1jjU2zx3XOKC6x1b75nHPotY9o/XQa3Kyc0cg1UIDqR8s7CUhPwINIUm2cM64GUfHSlTe/xkzYJGserH8ojHRCQl1E/AIccfAuM0cWhA9Lv7MTNPBBs0wXkSGzr5oCdw2HkB1+NcE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(82310400011)(451199024)(186009)(1800799009)(46966006)(36840700001)(40470700004)(2906002)(4326008)(8936002)(41300700001)(5660300002)(54906003)(70586007)(70206006)(110136005)(8676002)(6636002)(316002)(478600001)(40460700003)(6666004)(7696005)(1076003)(2616005)(16526019)(47076005)(26005)(426003)(336012)(83380400001)(36756003)(36860700001)(40480700001)(81166007)(356005)(86362001)(82740400003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 05:54:15.2896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4c1c04-e02b-4d18-0435-08dbb28b87f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615
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

Add reset option for fan_curve.
User can use command "echo r > fan_cure" to reset the fan_curve
to boot value

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  8 ++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 43 +++++++++++++++++--
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d05d9cd61331..2acac21387bc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3437,6 +3437,11 @@ static int parse_input_od_command_lines(const char *buf,
 	case 'c':
 		*type = PP_OD_COMMIT_DPM_TABLE;
 		return 0;
+	case 'r':
+		params[parameter_size] = *type;
+		*num_of_params = 1;
+		*type = PP_OD_RESTORE_DEFAULT_TABLE;
+		return 0;
 	default:
 		break;
 	}
@@ -3531,6 +3536,9 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
  * When you have finished the editing, write "c" (commit) to the file to commit
  * your changes.
  *
+ * If you want to reset to the default value, write "r" (reset) to the file to
+ * reset them
+ *
  * There are two fan control modes supported: auto and manual. With auto mode,
  * PMFW handles the fan speed control(how fan speed reacts to ASIC temperature).
  * While with manual mode, users can set their own fan curve line as what
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a719bae54e2c..644773c4bccb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1484,6 +1484,36 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 	return size;
 }
 
+
+static int smu_v13_0_0_od_restore_table_single(struct smu_context *smu, long input)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *boot_overdrive_table =
+		(OverDriveTableExternal_t *)table_context->boot_overdrive_table;
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)table_context->overdrive_table;
+	struct amdgpu_device *adev = smu->adev;
+	int i;
+
+	switch (input) {
+	case PP_OD_EDIT_FAN_CURVE:
+		for (i = 0; i < NUM_OD_FAN_MAX_POINTS; i++) {
+			od_table->OverDriveTable.FanLinearTempPoints[i] =
+					boot_overdrive_table->OverDriveTable.FanLinearTempPoints[i];
+			od_table->OverDriveTable.FanLinearPwmPoints[i] =
+					boot_overdrive_table->OverDriveTable.FanLinearPwmPoints[i];
+		}
+		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+	default:
+		dev_info(adev->dev, "Invalid table index: %ld\n", input);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 					 enum PP_OD_DPM_TABLE_COMMAND type,
 					 long input[],
@@ -1770,13 +1800,18 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 		break;
 
 	case PP_OD_RESTORE_DEFAULT_TABLE:
-		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
-		memcpy(od_table,
+		if (size == 1) {
+			ret = smu_v13_0_0_od_restore_table_single(smu, input[0]);
+			if (ret)
+				return ret;
+		} else {
+			feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
+			memcpy(od_table,
 		       table_context->boot_overdrive_table,
 		       sizeof(OverDriveTableExternal_t));
-		od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
+			od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
+		}
 		fallthrough;
-
 	case PP_OD_COMMIT_DPM_TABLE:
 		/*
 		 * The member below instructs PMFW the settings focused in
-- 
2.34.1

