Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010ACCD11DD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 10:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64DE710FF0D;
	Fri, 29 Mar 2024 10:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A2Rar9E+";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019FD10E418
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 10:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eus74/mIff0ggZitmG+K2VOtkLd4cxp0FdekoV71YcPJX/l9ahsDdo2KI0wYZCPu3PRxTywvQVVIPEM0LRRQnDye2vsZlvhxYx57trfg1tQORdmIn843Xwzfi+U/+jqJvcSGFy+t18pGd6HIczFkQnvJfeqwN+Y50M4ljfoJ6UT4IYEJukSHGT/4QfHhSrV6AkQDQduVAlNkYkvtAidA3uwQow81F+KKLnv5hjSMoZ9AaqeEAM7F34kaRrx2p4m+BLUao4hlwohtM1I/x1mUPrup1rFZRAOc5R7+cmIq1wd+klk3cW7Aa5/QI7TGUIxoIFhQDFdZRbL27KDC2OvjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvjjjDDuZmiN85pj+qDKq/4Ok9b2Ort2dI6pn7bJ3PU=;
 b=UKSmhUnKMdQjHncoorcdOG+j37/aD1DkZRHlA/0ervmzZ44OTZC9/2V9CzDkB9RbKSLYsNi83G2Np/PPsrEYImJAtLF1x5fpgnAcsbQYMXiLcUnZTkrw7P+yt4Uqgqib5pDmepF4sZ25feEddGTZUL7fSIgvc3oqAKMew8LN2lgsFFdi+U7vwwm8BoJgeGJwV3796tXMJCzUPo065RoIFH+EsSnAoIupLeZh9To9YyQFTrDa8MD6KNrAgfKF55ibJIJVzfhgVgsZcytzo+GrePrQjC9q7FfNWQUo2yqOhWa6yz3+2J1GCa+NV7OnqXW1OuqtTQY76IuSB8rE+NpPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvjjjDDuZmiN85pj+qDKq/4Ok9b2Ort2dI6pn7bJ3PU=;
 b=A2Rar9E+r59UTLHOtW0mM3q1hb8qByo4mSMpzKYnO5bxgtfGqcrOrcD3Fn0aB1JiGssLMcfjsfwsLsXbGrmkyXRIKa2Byv/U1rPiCjkw1jW7NegLMRKPNYXaxSmT5Hqi+gKpNEudMD4nV18jA/LxAC0HjdfJCQFApDdvpcXTVAQ=
Received: from BYAPR07CA0108.namprd07.prod.outlook.com (2603:10b6:a03:12b::49)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Fri, 29 Mar
 2024 10:20:37 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::f0) by BYAPR07CA0108.outlook.office365.com
 (2603:10b6:a03:12b::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40 via Frontend
 Transport; Fri, 29 Mar 2024 10:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 10:20:37 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 05:20:34 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <richard.gong@amd.com>,
 <yifan1.zhang@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 1/8] HID: amd_sfh: rename float_to_int() to
 amd_sfh_float_to_int()
Date: Fri, 29 Mar 2024 18:17:43 +0800
Message-ID: <20240329101748.3961982-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 490150ad-1940-42f2-136f-08dc4fd9e0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5iTsSRQevE6cEjqR/80oM40aLf+79sJbcVfeehMvidNvDZAxkgAfdSfl1rNyIHarye78GLQ16EpDwGMoAkVIbAk+dL2k+KTllM2vA6zF3yml72NA0sEA3DgLIwScHEcgc+NF9pfLxKTfOyeKYlwu0DpO5I58UhOjqE9vJCQnRydaGaQbmJYhrnSm6jH4hcAHxxVzCw7w2pQH9Um0Pm/LrFg8Lsr0U/btIvCqqPlObffCtTJk/Zi7muC8wNcPX4vaGXZyQsZJ2P5uPz9yMF9EWdVCFKU1nXu5lMxDcqTlnMUDXuGK+dEDpO9GVdqg8sDBWH8DJqq7lDod6Femmjjy2i8M716lxlqPccqkK4NmG0ZX2/hMBSk6vywrNCMGBoLqZVH2v9LZohkA/Nv8QLYpakzpSvcPRyf2t1z8DKWa4NbKl3lMvJnRcTS9N7knSjtxoU3uCCcx8st6hpqA5HU/rgb6G/GgRYByRUx0C2XY78rjCWgtzzi32qo2a13zCc7VS6AOB+DCHSysA13OZHSCtP68czu1WntipSCaTi3REWQ6mTZxaAxsLMcVPGN9IECgLT567kKBB/JCyJCsa3UICogy0Pa2H9Ia/eASWWgG3wcNLLdmLgRslmLJbB8y5U1hlx2lFuyMxhsHRc0okRvGhXdRc3+9OK5lFr6/uMHC5tLaCPiUEw9qj6z/9XYibzoadzpRuOxErABEKAY4cpepw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 10:20:37.3955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490150ad-1940-42f2-136f-08dc4fd9e0a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[Backport]: to fix amd_sfh init fail issue in ASDN

Current amd_sfh driver has float_to_int() to convert units from
float to int. This is fine until this function gets called outside of
the current scope of file.

Add a prefix "amd_sfh" to float_to_int() so that function represents
the driver name. This function will be called by multiple callers in the
next patch.

Link: https://lore.kernel.org/all/ad064333-48a4-4cfa-9428-69e8a7c44667@redhat.com/
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
(cherry picked from commit 4e71d262899d7bab1f0c65936a2e639afeb83e4d)
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c | 28 ++++++++++---------
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  1 +
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
index 8a037de08e92..33fbdde8aff0 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
@@ -132,7 +132,7 @@ static void get_common_inputs(struct common_input_property *common, int report_i
 	common->event_type = HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM;
 }
 
-static int float_to_int(u32 flt32_val)
+int amd_sfh_float_to_int(u32 flt32_val)
 {
 	int fraction, shift, mantissa, sign, exp, zeropre;
 
@@ -201,9 +201,9 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
 			     OFFSET_SENSOR_DATA_DEFAULT;
 		memcpy_fromio(&accel_data, sensoraddr, sizeof(struct sfh_accel_data));
 		get_common_inputs(&acc_input.common_property, report_id);
-		acc_input.in_accel_x_value = float_to_int(accel_data.acceldata.x) / 100;
-		acc_input.in_accel_y_value = float_to_int(accel_data.acceldata.y) / 100;
-		acc_input.in_accel_z_value = float_to_int(accel_data.acceldata.z) / 100;
+		acc_input.in_accel_x_value = amd_sfh_float_to_int(accel_data.acceldata.x) / 100;
+		acc_input.in_accel_y_value = amd_sfh_float_to_int(accel_data.acceldata.y) / 100;
+		acc_input.in_accel_z_value = amd_sfh_float_to_int(accel_data.acceldata.z) / 100;
 		memcpy(input_report, &acc_input, sizeof(acc_input));
 		report_size = sizeof(acc_input);
 		break;
@@ -212,9 +212,9 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
 			     OFFSET_SENSOR_DATA_DEFAULT;
 		memcpy_fromio(&gyro_data, sensoraddr, sizeof(struct sfh_gyro_data));
 		get_common_inputs(&gyro_input.common_property, report_id);
-		gyro_input.in_angel_x_value = float_to_int(gyro_data.gyrodata.x) / 1000;
-		gyro_input.in_angel_y_value = float_to_int(gyro_data.gyrodata.y) / 1000;
-		gyro_input.in_angel_z_value = float_to_int(gyro_data.gyrodata.z) / 1000;
+		gyro_input.in_angel_x_value = amd_sfh_float_to_int(gyro_data.gyrodata.x) / 1000;
+		gyro_input.in_angel_y_value = amd_sfh_float_to_int(gyro_data.gyrodata.y) / 1000;
+		gyro_input.in_angel_z_value = amd_sfh_float_to_int(gyro_data.gyrodata.z) / 1000;
 		memcpy(input_report, &gyro_input, sizeof(gyro_input));
 		report_size = sizeof(gyro_input);
 		break;
@@ -223,9 +223,9 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
 			     OFFSET_SENSOR_DATA_DEFAULT;
 		memcpy_fromio(&mag_data, sensoraddr, sizeof(struct sfh_mag_data));
 		get_common_inputs(&magno_input.common_property, report_id);
-		magno_input.in_magno_x = float_to_int(mag_data.magdata.x) / 100;
-		magno_input.in_magno_y = float_to_int(mag_data.magdata.y) / 100;
-		magno_input.in_magno_z = float_to_int(mag_data.magdata.z) / 100;
+		magno_input.in_magno_x = amd_sfh_float_to_int(mag_data.magdata.x) / 100;
+		magno_input.in_magno_y = amd_sfh_float_to_int(mag_data.magdata.y) / 100;
+		magno_input.in_magno_z = amd_sfh_float_to_int(mag_data.magdata.z) / 100;
 		magno_input.in_magno_accuracy = mag_data.accuracy / 100;
 		memcpy(input_report, &magno_input, sizeof(magno_input));
 		report_size = sizeof(magno_input);
@@ -235,13 +235,15 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
 			     OFFSET_SENSOR_DATA_DEFAULT;
 		memcpy_fromio(&als_data, sensoraddr, sizeof(struct sfh_als_data));
 		get_common_inputs(&als_input.common_property, report_id);
-		als_input.illuminance_value = float_to_int(als_data.lux);
+		als_input.illuminance_value = amd_sfh_float_to_int(als_data.lux);
 
 		memcpy_fromio(&binfo, mp2->vsbase, sizeof(struct sfh_base_info));
 		if (binfo.sbase.s_prop[ALS_IDX].sf.feat & 0x2) {
 			als_input.light_color_temp = als_data.light_color_temp;
-			als_input.chromaticity_x_value = float_to_int(als_data.chromaticity_x);
-			als_input.chromaticity_y_value = float_to_int(als_data.chromaticity_y);
+			als_input.chromaticity_x_value =
+				amd_sfh_float_to_int(als_data.chromaticity_x);
+			als_input.chromaticity_y_value =
+				amd_sfh_float_to_int(als_data.chromaticity_y);
 		}
 
 		report_size = sizeof(als_input);
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
index 656c3e95ef8c..75267b0fec70 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
@@ -166,4 +166,5 @@ struct hpd_status {
 
 void sfh_interface_init(struct amd_mp2_dev *mp2);
 void amd_sfh1_1_set_desc_ops(struct amd_mp2_ops *mp2_ops);
+int amd_sfh_float_to_int(u32 flt32_val);
 #endif
-- 
2.25.1

