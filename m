Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44E8CD691F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4703A10E1C0;
	Tue, 10 Oct 2023 10:01:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A05610E1C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmTsy2616rH51Df1CKU4bREzegBooDcaWweSdifnavLTw5CW2ROt3kdh+imQqtiOSZTlQDFninXTE3MiFgIqtZCfahtYqdvyV2Z4+j1LsbmF2ba6oPcCK3sS8gMesUU3u55WwDnNk5K9mJ2J1FgCEw8FYvFvl10t62k2fpnXLHtxHkGRWildznuyO5VyTqZSdweSk8hkNES5QJRKdshSXDOggE8DOqDDuYsBFTz+HZS07mYPnZ7H7ewppfMFz6FqBRtC2JGmrPCxeA4RQjAxsDgNDyXzhwelT4P33bBSVipCDbkWSj2S5qxSWbEyqOEXUW5olMsCIyYX2QCls4b7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8cijky9tOgsTKWbI+izv31AOXI8xRXlXhpBJIT0C7c=;
 b=aTaMV7YHthGzLtATQe4syRsx1NOVs7C6uk5HrizxaL+Lk3u0vhiS6/qyUyFn6qTmFr1+JzgkX4ASlDxl9eNi90mL2c1EnXVuvIQ3ejfFC4PTrIoeM8s5bl2rEl6PVnPZdYr0j9EtGFp7tkMXEopYs/Qjmy5P3nAr6Gf6LOktrrBzfVLDmPdENe4maXJ9Z+rUpGjcw36XMos1QnE+LkgGf9uL4cW9Y/FWjFOtoNMf1tw8U5QBRjICERC5sTAh6h4zjqcYA1BHdkEwAos7kuyK/Z6KES/VEVCKD4PMxgxD1tP9NZU2uHKtMU3145AUhCYLrUzNIavlX/qzZ11xDn+8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8cijky9tOgsTKWbI+izv31AOXI8xRXlXhpBJIT0C7c=;
 b=yK3n51kVM9Db493RxCrQZFr8zSGrTTLwk0+cFCnpQ2mOWNT23oaKTEBlQS4ZcWiKWFe7kXFvPTo9d5gbWiqdUXqOA63+Br5JLb3HU7hdTbeNILVEHLMLEAIcc7eVEkfhuhuL8z0/AOGMFq/OpVMS3OhUPhwaaGdu6WUTuiqH670=
Received: from CH0PR03CA0427.namprd03.prod.outlook.com (2603:10b6:610:10e::30)
 by BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 10:01:15 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::4c) by CH0PR03CA0427.outlook.office365.com
 (2603:10b6:610:10e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 10:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:00:53 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:00:49 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Add reset option for fan_ctrl on smu 13.0.7
Date: Tue, 10 Oct 2023 18:00:22 +0800
Message-ID: <20231010100022.1023882-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010100022.1023882-1-Jun.Ma2@amd.com>
References: <20231010100022.1023882-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|BY5PR12MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: b36d5a38-accb-4811-6c26-08dbc977d718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //sKDwZ3kzGfwEJOWwxAt2bWCrIdUXBOIQW2XcK3dUSvpzHeNrngNZhK+Nfc6nH+++DY/AIv5kEnnIwiCa96NbPhZyKh3o6erPvVYluEYnFAwvcaBVrsOZ9pybRjUMoGjL23Sht8dbNiLJj7IyoJH4py+4KEGdGnSoxRrYdVI9wr49/FRKCX5RSnlHZyC2vNtZHf6RYhTV03FbLEzpZzwxilZNrmpfGchM2XDbFOi7I4QNGbdOZurSYhA8z8f6xmSBFnU21qf8FUDFkPNu0Dj+vkdRv4QdJGn7zp8wqTA9PQQ2j6CvXavQaGvDd+OE9Wbhg7de4ZKnVtr7JzD1WpOof+wGkuipdW1RdDcboFCAPOeslyTbvRspDIKwyJIbai+JiaegKdC155bpQZXQUTU+MQDVYxl4a7rA6An4ozIP2qzj9lLwQSOeuURE1ltBTaNgr5wCGsqGf5KTDhtb+FwZc0HU0lISfPytXrjT+hsvLhTeKyU002W7GG19G/Awpa8mkpHIshTfnO1+YdQYb9ossuyksamrZu//BAz0bkaFPp3PMbVfX9flft7m/dmUTdWkStl0HZNLLeu4Imebs4dkA3iP3JKyl4XI/e//1qeWrkrJLKUdEXdKVjjc/EQ/+tS0zm0xp3GBPYlej8TA/79ToHuXdL9w7P9gZFNY/rRGuo7Vmx+L9hPGqQA/zJQ0wmwGeg75SuOkZ0kRU9sncvQ+fqiTfZ+pqTXNEqjL9yRHgjWE5m0VoFSNp3RDoQVT9b6MOkNb7LN4KQdQud4RAT/j5FOkmsgVLnjfiPDXwrk5I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(83380400001)(426003)(2616005)(1076003)(26005)(336012)(16526019)(81166007)(40460700003)(86362001)(40480700001)(82740400003)(36756003)(356005)(8936002)(478600001)(4326008)(2906002)(8676002)(6666004)(47076005)(7696005)(36860700001)(110136005)(41300700001)(316002)(5660300002)(6636002)(54906003)(70586007)(70206006)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:00:53.2704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b36d5a38-accb-4811-6c26-08dbc977d718
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4918
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

Add reset option for fan_ctrl interfaces on the smu v13.0.7
User can use command "echo r > interface_name" to reset the
interface to boot value

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 69 +++++++++++++++++--
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b8a7a1d853df..3c5526babb14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1497,6 +1497,59 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 	return size;
 }
 
+static int smu_v13_0_7_od_restore_table_single(struct smu_context *smu, long input)
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
+	default:
+		dev_info(adev->dev, "Invalid table index: %ld\n", input);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 					 enum PP_OD_DPM_TABLE_COMMAND type,
 					 long input[],
@@ -1783,11 +1836,17 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 		break;
 
 	case PP_OD_RESTORE_DEFAULT_TABLE:
-		feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
-		memcpy(od_table,
-		       table_context->boot_overdrive_table,
-		       sizeof(OverDriveTableExternal_t));
-		od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
+		if (size == 1) {
+			ret = smu_v13_0_7_od_restore_table_single(smu, input[0]);
+			if (ret)
+				return ret;
+		} else {
+			feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
+			memcpy(od_table,
+					table_context->boot_overdrive_table,
+					sizeof(OverDriveTableExternal_t));
+			od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
+		}
 		fallthrough;
 
 	case PP_OD_COMMIT_DPM_TABLE:
-- 
2.34.1

