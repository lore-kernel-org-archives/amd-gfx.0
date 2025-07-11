Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B32C8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 08:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541BF10E266;
	Fri, 11 Jul 2025 08:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wma4w7vl";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E968110E266
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 08:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1S83wB+PUDF/gIp3s2DnqHcxk1uQQnj+fTAJU+wOvDS6saRk/lRe0DYc1vaJTRk6gIWnYn3zCbtLEIrLWLQQD/8U2c/nPHRh5oDpEo43dTlX31+eEWV5kLIdsTA5AyJG4jntF9sdC77w7NRgRAUTMuQTLdBbOPA5aOzMR72dCzqDBwMe/P9GrgoASRDsh7vXwo4TuQz0TzTpZNb11+KByrI9mFaCl0AzWj3YZXDTaWloB+x01ekuI7mGFe2QPiIb4E6G+CrSRT9Onp61DwVSKZZ2i562FgGGaTjkLtE8U7pn/949jY8Laq9ZoeJigwwm5d+TPSpRtrPVwblSxCrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82U+KwOvLItAmswHw5p3SBEazWe9uUARhk7FQcic/Kk=;
 b=DpY8c4kxGwNteyexBmBFaYRni0eQIN0enmR296SveWTTKoOknuCQsIClYCv66iGxWTpptrl06CN6P42BzEt/+/Rw8jVvms18aJcXTpMU4qeO0leQwX2cYN9ocRXaZLkttYTqwo5x0mlPBVIfm7yvgqw5z9YFSMuRcrQrznB/qlWw9K1VJamz3GnwVNd3e61QuEwr+ACVxpJh9Vvwnn1l4JkV38JogGlNdjvURzeWDGYB50A7FGJQvbIe3nGu0fCZN5BxzX/dbGRlJAs5JQMRN6Qx0hS+qSvvNvG31ZwLm8bcV2izCbs8JgVuRMSxguipfKG9cweZjcc+1U8iqtG/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82U+KwOvLItAmswHw5p3SBEazWe9uUARhk7FQcic/Kk=;
 b=Wma4w7vlR24byhu0DrFg8DuQRTlman8GRI09ZXAWo+pQvaE7ZhXx09+DCN6rprpa5JKdvHramATh3/leJ9hN7QhhtI0woSyI9e0kvRGtOxo055/78qaVdKGhtBipxpP8D4qbInZG1D2342NcXIdua9MKBa/CfQtWtnbhg4fJVdw=
Received: from SJ0PR13CA0098.namprd13.prod.outlook.com (2603:10b6:a03:2c5::13)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 08:21:10 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::46) by SJ0PR13CA0098.outlook.office365.com
 (2603:10b6:a03:2c5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.8 via Frontend Transport; Fri,
 11 Jul 2025 08:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 08:21:09 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Jul 2025 03:21:06 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Date: Fri, 11 Jul 2025 16:20:50 +0800
Message-ID: <20250711082051.29344-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a35e9db-5824-473e-4713-08ddc053e3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ti7Xw/EvHiSfSdGzAE17//0c83cegtUYDXzbYdd32Uhf68i8KI5YIV+yhgXL?=
 =?us-ascii?Q?tuTqac17yyiqtVtTq8WEUmmrTvp/9JlqcK6NMXkGfqRikLxnXuW64dGijbhS?=
 =?us-ascii?Q?aR4/Sx99JlY3g6kIS4jJBU0ulv+p6cxCJ9NrYVnNcbMjLE4+XpyCrTBUdgy1?=
 =?us-ascii?Q?fYc3XWWW+rufp0gBxLipOgAc18e5mL/zDN6ZE1vsUV1d7C9j3YaMdUb+GZVQ?=
 =?us-ascii?Q?eQStvyEX3x89pv39vWAv53hYvHJy520BHaWdxy39AFpG9XcY2JTj6v/se8es?=
 =?us-ascii?Q?zuSxU2Fr9pEqrcSTvYawduNLjxOj4z+LDTZj3udP1S1RWy5HguAEbbT8Rz0O?=
 =?us-ascii?Q?4ywlcwFCaLZVoR/2UcXkecexvw/Bns6t9XE9WyYx2CyRC5LAUy0Q3Rq6pp3W?=
 =?us-ascii?Q?AiKGkb8nk3zAIQaWzYI5kbFnF1IV9ptBGxyMs1gCaRfl0vNnNXYbHejTasMM?=
 =?us-ascii?Q?7fN4zl8DrV2440n9Z9qAUaR3kK93fti6Smx1pzUEmXUx8xDnjg1W/ETSJY82?=
 =?us-ascii?Q?bhWirD6mlSXf4zXzpjYkM+qq+lHrpq2/19wWMFC1BSs8dJb0S9tXUdAusvcJ?=
 =?us-ascii?Q?hzUFYtIKkLJqrL5V4e3loX/BOWwE67egKFbpJLEmA1wuLaIASMEQTCcdzdXI?=
 =?us-ascii?Q?zIeAil7Mm9dfbB//RXwjZTtdOs+MeUS6K0S20ehGcQLCd7T6hVOPGTt3Mfb6?=
 =?us-ascii?Q?NNT7rMEeBLd3SnC5Rm0EuZgu0Ec1FmPHMQZl/YYWAa2m2sbK7mOVnNJw3cb3?=
 =?us-ascii?Q?SKo8XtN1tHvKTzNDfQm16rsE9d5Bhq84rZXCF4GYoo+2xDfkg8bFqf89ysyh?=
 =?us-ascii?Q?9kttXBRIDE0x+yQBAKqeQPpVAGAp6pyfSnuwmAPm3US2EmKLds+7XX1SbhXF?=
 =?us-ascii?Q?/OY3oCxXjEIW1mHr50aK/4sIYI68nsx1Un67MMGuICVaXJMXXorc9N5agO4C?=
 =?us-ascii?Q?cAPX+hiMfnXfHVp2h83iqbjT0vl25JeYJLc2FV55tnBFdhL5I7k9QsXGj/Wa?=
 =?us-ascii?Q?CgBTvp9Dt0TqdRI+y14Kl6Vnt8BDg1Gx/vCPCc4K2RLGjfdWEBMtti/vlHBO?=
 =?us-ascii?Q?3Ezet9vGCQLvMXbj2FWLBID3R5j9w1ZWbLIpnM/AT/aDGoG6ahHuCreDKqF5?=
 =?us-ascii?Q?Z9bE86q64Q3vv+/WwwZ3v6lM/dfcxTAaslHadZSSH0Iu8YDlmIynxz1T8ETK?=
 =?us-ascii?Q?yOjEh9cxEX/dvibEhfWjorQbtEbkRiRuoEi5iTnDMhkgOrXTHDYnR6MJFJRg?=
 =?us-ascii?Q?PKkjPRe0XFYXC1CAXU+l5XzH5rECigeHmMyptf4mpXKOGrp+dOSkp+7OabW0?=
 =?us-ascii?Q?WgCLdYWPt8M29ci81V3UruM/5Os38/LYPNbf/A79Mf7/DejyUn89B0KNy9B8?=
 =?us-ascii?Q?poTFH3OpCDyapz0ht/cxwZtj6CqVJmR1L2bceZ6YSPDN94bf5MPNe3to1Bpg?=
 =?us-ascii?Q?z6F0UBrEnB1ma+XdnJ370UNr7ISKHJKJG1mvnOJ1NHJwiBLpMvwxEQ37IPTF?=
 =?us-ascii?Q?xzoP4ybDGDaUPVDr00YkKdEAOe4QUbOhhbcT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 08:21:09.2553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a35e9db-5824-473e-4713-08ddc053e3d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183
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

add eeprom data checksum check before driver unload. reset eeprom
and save correct data to eeprom when check failed

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 28 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 571b70da4562..1009b60f6ae4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2560,6 +2560,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	amdgpu_ras_eeprom_check_and_recover(adev);
 	amdgpu_xcp_dev_unplug(adev);
 	amdgpu_gmc_prepare_nps_mode_change(adev);
 	drm_dev_unplug(dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2af14c369bb9..b66e09ad0cc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1522,3 +1522,31 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
 	return res < 0 ? res : 0;
 }
+
+void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control;
+	int res;
+
+	if (!__is_ras_eeprom_supported(adev) || !ras)
+		return;
+	control = &ras->eeprom_control;
+	if (!control->is_eeprom_valid)
+		return;
+	res = __verify_ras_table_checksum(control);
+	if (res) {
+		dev_warn(adev->dev,
+			"RAS table incorrect checksum or error:%d, try to recover\n",
+			res);
+		if (!amdgpu_ras_eeprom_reset_table(control))
+			if (!amdgpu_ras_save_bad_pages(adev, NULL))
+				if (!__verify_ras_table_checksum(control)) {
+					dev_info(adev->dev, "RAS table recovery succeed\n");
+					return;
+				}
+		dev_err(adev->dev, "RAS table recovery failed\n");
+		control->is_eeprom_valid = false;
+	}
+	return;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 35c69ac3dbeb..ebfca4cb5688 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -161,6 +161,8 @@ void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
 
 int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
 
+void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

