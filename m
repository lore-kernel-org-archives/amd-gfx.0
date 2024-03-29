Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA8BC6FD1F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 10:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32CF1120CC;
	Fri, 29 Mar 2024 10:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I0npnlyi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6B6112630
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 10:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjZolnpnC90WZxpyFQl5FoEgVssJBiFQyMEx0BrmF5X/2C1zve+WtLtTPNFHQ+vgaH6S1TVg3RvVwv2cz2fstBxqkev/QgiSnVCcKKC9BIMIIJplQKyGm37k/gdTBAvDKl9slVrF4WIGXlqx05/X9RLh5K98xkOAaj1AF+kDf6Iu5GzwKgx3H8UeBMgK4M+iUd/tkyVTL4AP/CVEPYaINjQ9U6Gl5/Kbj6yHFZQFcSijVVOczE2Dm8a4wwvmMS2ygpXqsrUdZRnzwTmGgRIygeHIBE3zYNxrXWel/mJSzK7Mu1u4A+sksuwhe3/rov0iNUNcbFOzTL9CejYMuoxAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kgQIZ0G3zL5Ufgan+RMvq9WTzQ+p5aT447XsYZa8to=;
 b=RqkHzLs7MFn4cxiepE+gGl3zMbZqoav4GCTp2p1ZJD5rsCWLCSWhLEO/JPSVUMX4xppy5KtfoOXFCAmNC3mC64jNDDLQwuJYeawQdQsB6eWyIxUudDewHMyhqhmytEWONMu0rhoHQM34p23Ud5edEAmohneG4W93F6MA5cgL0qbou3POxAdQ5pzXLOaLGevLaYdUHtu6zDpy0qFwYvwA9LARcUUEALFcxALDJbtOnuk4YubuVWAohw27QqbZu/WQLlTq1zN7H76OZ2Y9HDO6qrjaJV16cjU4qg0gkVz6A9aJvD9iK00Kq8jshJikcSLINcPvHnlrA5js2ehGzWG1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kgQIZ0G3zL5Ufgan+RMvq9WTzQ+p5aT447XsYZa8to=;
 b=I0npnlyimNuAY0sBgEEGNQke1sBwZpn7VRF0Jac5IzIZ8ZwG+YNPtBBSlp5lXEa2VdVBC8aM/WUXM7cd2HNa/i1W/oXVvYmrFwLiZ9WQEvM3VmEqjhrtuu2EcIxeqJ8jPns7r7Ijnl7n0B6c0uKkReypQCdATnVMcIzvp7QaPf0=
Received: from BYAPR07CA0106.namprd07.prod.outlook.com (2603:10b6:a03:12b::47)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 10:20:58 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::b7) by BYAPR07CA0106.outlook.office365.com
 (2603:10b6:a03:12b::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39 via Frontend
 Transport; Fri, 29 Mar 2024 10:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 10:20:57 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 05:20:54 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <richard.gong@amd.com>,
 <yifan1.zhang@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Akshata MukundShetty <akshata.mukundshetty@amd.com>
Subject: [PATCH 6/8] HID: amd_sfh: Avoid disabling the interrupt
Date: Fri, 29 Mar 2024 18:17:48 +0800
Message-ID: <20240329101748.3961982-6-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329101748.3961982-1-li.ma@amd.com>
References: <20240329101748.3961982-1-li.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc9e5ff-8c3d-4533-6507-08dc4fd9ecb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J24glS9duVrVOT5AJI2heSYEPiOSil8KqW60w5EB2BDEaFrTYkfzQra2hyqV7UiCPIJIcSYVq1WsHlK0rBU9Ek6QD6suBfZTglQrQDL5fVE/GwnHvJFkjZqK4pJvs6MFF4V+JHlGoK2hyQfCjXAbA6unhQaAf+gG1UEAPtjf4JMOZuZ4+v1bdhd0Mnw7HSkftgcCKSAm5jrA6ONzlNmYOO8+RJAW4ttHu/5I8pukIWOh8QIW/yoRPq8IqebXScgAEBp8jM3CMgA+AmicuSCq9fQ2V0nwdg0Iav/JpGCwohfeyBE3gE/pLLd2+33QAfSAx1oWD7U8Ko9WCktDm+cuTVXM5mVF3sJKvVkhUoLIr3wMPeWSMzOWYrHrt9I2oAxJIXcEju4lMNAV9l0DkCzyc6+iBEBrJ5Z4OnQTCwXu8udcrTmz0N6KnwjDq+G4Z9NED74rgTq2TI8xav2TJCQMAzoCTh30P/JB8FEJ4O+QJU2UpZ0zd7UebqH10e0oLa+YYVRQgo6miOR/WWZNR+VaSNK/MZjQ+xNz7aquv2avFueHbrDQ4Do2DnhTUbULJuu7vmvJKyKYY/ymdX6dAtalFNn1/e9sVpNdmpDm5Got4lnnM8AQ9w8Eu5J7Rty+DiAr9LJn39E6bKHROp3w8RvlEDmW+XLpwThSY4JmAvYoOPcus94pmgPjYfLgYCZu+0L2aWIRXwWzlRLg7E5P+vsY0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 10:20:57.6457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc9e5ff-8c3d-4533-6507-08dc4fd9ecb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
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

HP ProBook x360 435 G7 using older version of firmware which doesn't
support disabling the interrupt for all commands. Hence avoid disabling
the interrupt for that particular model.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218104
Fixes: b300667b33b2 ("HID: amd_sfh: Disable the interrupt for all command")
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
(cherry picked from commit 067539bc937e33c372d93896673f6f74209355db)
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 30 +++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 8a4cd793d021..8c1809c7d1f7 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -35,6 +35,8 @@ static int sensor_mask_override = -1;
 module_param_named(sensor_mask, sensor_mask_override, int, 0444);
 MODULE_PARM_DESC(sensor_mask, "override the detected sensors mask");
 
+static bool intr_disable = true;
+
 static int amd_sfh_wait_response_v2(struct amd_mp2_dev *mp2, u8 sid, u32 sensor_sts)
 {
 	union cmd_response cmd_resp;
@@ -55,7 +57,7 @@ static void amd_start_sensor_v2(struct amd_mp2_dev *privdata, struct amd_mp2_sen
 
 	cmd_base.ul = 0;
 	cmd_base.cmd_v2.cmd_id = ENABLE_SENSOR;
-	cmd_base.cmd_v2.intr_disable = 1;
+	cmd_base.cmd_v2.intr_disable = intr_disable;
 	cmd_base.cmd_v2.period = info.period;
 	cmd_base.cmd_v2.sensor_id = info.sensor_idx;
 	cmd_base.cmd_v2.length = 16;
@@ -73,7 +75,7 @@ static void amd_stop_sensor_v2(struct amd_mp2_dev *privdata, u16 sensor_idx)
 
 	cmd_base.ul = 0;
 	cmd_base.cmd_v2.cmd_id = DISABLE_SENSOR;
-	cmd_base.cmd_v2.intr_disable = 1;
+	cmd_base.cmd_v2.intr_disable = intr_disable;
 	cmd_base.cmd_v2.period = 0;
 	cmd_base.cmd_v2.sensor_id = sensor_idx;
 	cmd_base.cmd_v2.length  = 16;
@@ -87,7 +89,7 @@ static void amd_stop_all_sensor_v2(struct amd_mp2_dev *privdata)
 	union sfh_cmd_base cmd_base;
 
 	cmd_base.cmd_v2.cmd_id = STOP_ALL_SENSORS;
-	cmd_base.cmd_v2.intr_disable = 1;
+	cmd_base.cmd_v2.intr_disable = intr_disable;
 	cmd_base.cmd_v2.period = 0;
 	cmd_base.cmd_v2.sensor_id = 0;
 
@@ -292,6 +294,26 @@ int amd_sfh_irq_init(struct amd_mp2_dev *privdata)
 	return 0;
 }
 
+static int mp2_disable_intr(const struct dmi_system_id *id)
+{
+	intr_disable = false;
+	return 0;
+}
+
+static const struct dmi_system_id dmi_sfh_table[] = {
+	{
+		/*
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=218104
+		 */
+		.callback = mp2_disable_intr,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook x360 435 G7"),
+		},
+	},
+	{}
+};
+
 static const struct dmi_system_id dmi_nodevs[] = {
 	{
 		/*
@@ -315,6 +337,8 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	if (dmi_first_match(dmi_nodevs))
 		return -ENODEV;
 
+	dmi_check_system(dmi_sfh_table);
+
 	privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
 	if (!privdata)
 		return -ENOMEM;
-- 
2.25.1

