Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BAAC25B77
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 06:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176DC10E5E9;
	Wed, 22 May 2024 06:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zg336Bmt";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE4610E5D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 06:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfEqeEBRKJxchV6hfM6w2TWePxPiPB5f+q3KGgN1IWjexTO6xyHnyO8ZhWKnzQdNrTks73uLhayEXwaJjG3CyrctphhohLX8rHzAQ9mg9HVV/A4mUpVWffffnjfcG+iQfQRzu7gRMZOFhNnYfJxlB0FV8wsuzQp632Z/65CWMucjU9YhbS3kTXaFi9w7EWB9vEN7qLySvd0PZkfMNjgIyUMFd/zAzWRRhaUTWIWOMM1Ls4MuMOjqahB7/NRJrL+GKKf0Grpec8jGK8u6xeoRS1rEBoo8+45+KcIpUBmfJ/mAVBmk92LtCWTEcMoU1LBAf9t+6CxYOSa/ftTaBWAETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWBxoXva4DwqoaO0jzpnrUiX7Jbg3NYHu0MDXG7B2oM=;
 b=Z2Qy6FTGLfTyxxaQ6qkJgBwI8RBNWrBHa06YlYylMvMZ5XY0xp9/oAT5U38+qP5DPwDXZ2LR4t5/8OQpEbteIb2X2jARO1mrALWm04xKRLnjS1kUXW89EoVwyjzwpERe/A6riiWv2XioV30UDOAGhfBCgXR+9MeajsAZ9/YIM1agmi0CnOjInPeowKcDVFXalkherkakkXI+u+ooP4LlDPx5d8CEdTk85WD75yIKHx8ktjYtQZDbPwaR9mkN3D+lHEs1+8HsJR4Q6OYBUAcxmuVOktMduW6VquTETh3e/wH7ui58Zv5gmgDQXL2KZLGJhsK0SyKGBKX7mNqvh0ckxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWBxoXva4DwqoaO0jzpnrUiX7Jbg3NYHu0MDXG7B2oM=;
 b=zg336Bmti2QXz+GXKw158g3IlVAIpmW1a3g1bOuzwEdfpl2jgSir1mKhIZH4hpcwD2vPdHwhGy8XO9zJEXDRWRagPyy6kl1FNWuqPfREatgijVMatAJBYl44KzQgIyQwfnftUXScxdypH0FvCFcLP3DXH/rpKfhdyc65G10z4I4=
Received: from BL1PR13CA0216.namprd13.prod.outlook.com (2603:10b6:208:2bf::11)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 06:31:03 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::8c) by BL1PR13CA0216.outlook.office365.com
 (2603:10b6:208:2bf::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Wed, 22 May 2024 06:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 06:31:03 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 01:31:01 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <yifan1.zhang@amd.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Akshata MukundShetty
 <akshata.mukundshetty@amd.com>, Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 3/6] HID: amd_sfh: Avoid disabling the interrupt
Date: Wed, 22 May 2024 14:29:14 +0800
Message-ID: <20240522062916.705147-3-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522062916.705147-1-li.ma@amd.com>
References: <20240522062916.705147-1-li.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 610515a3-007b-4fc9-8119-08dc7a28c11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gyJbaRy2e8h0SLejokBTPnLwPj3H42ALSiFpGMGFeZ66hkrqbUdDBHyLCwkT?=
 =?us-ascii?Q?kmqGZ2uUHTO+t4H8JHdbzmn9Nx6WnGvUrZgbLkzTv85czbO+8sgI4bx9S4If?=
 =?us-ascii?Q?xCDbqqqJfOxRFJUe9gkdqDsefB+1wMJeztdj9SAOW6ldsIc2HeSuwVNpa9s/?=
 =?us-ascii?Q?VO83AOVMuQBLgISjoYNSgFYJbg8Zbt2nD3a/Lc7RzdLIzqnil6axGqReWM4k?=
 =?us-ascii?Q?mpjyG0vbvE5Gs2U6tGZ2EQP8540S85StK8ft3iEnaCen2w6uXNNJmLM1EgEm?=
 =?us-ascii?Q?fXXhdMNyJQUIeDUlq8ODfhWoceOhv5JFIkTMgB0liyIFhyQWAHMwKLmcpxDx?=
 =?us-ascii?Q?gLzeTSZkNkp+9iLPL7h588tmQgJILb0PWoI7gRZAmridJz8zrHC/ZEa2qpf+?=
 =?us-ascii?Q?mDSNHKe9eVL8hl7ndw3q15S2Ca/O+zeVwURdQj7M/nVwuXyDT6BdcuYbFolq?=
 =?us-ascii?Q?g7eW9jjQ42Q5sk+bznK00KR3P6P3mDwhS6gj8VtroT6jyMkShMX1XEuRNktk?=
 =?us-ascii?Q?1p7jZSEAPRfo/BL9+uEXR3nbf0qt1kzfjX2dgDHhfeZgK+BEBPFMFm+E7CQq?=
 =?us-ascii?Q?PsYE7PiRuILJArAsk7iPgu2LEPvH5ap1niAdOURcsAe2hDLuIDcWVEYaZ22J?=
 =?us-ascii?Q?PZ9Rpj3BQPpwc7qYrYqATnRmGylTbw/uYg/E55QNdOu+IeRnoPaxH/XxiS3X?=
 =?us-ascii?Q?QNVMFSeSltUPvHwsIpNawOiQN6J9SCpq3W8vSInqPXCn7unVfxLG+u+FBBdU?=
 =?us-ascii?Q?UyA8d1EdNuwSlOakv4M9ma+MjaRy/BvVsDxLR48rTPrP3UPt1TUNZfcY3cmm?=
 =?us-ascii?Q?9Nf7YKyS2np7Ij2R/6q08TAZX62Jw4ikGvzEKjgs/fM0unKiezgM7AOGXVpO?=
 =?us-ascii?Q?GB+DVBU5OZ2x7BrQtdn64dPeh+HhjqzyFI6iszH6AQn9ZoO8leo3RKvqyFF3?=
 =?us-ascii?Q?cVvgcOTcDvwVBVqFqnxnT4Q9IJYhKroIC9ydj8BoitZvhInDc39yh68LzGzS?=
 =?us-ascii?Q?wQe+n5EZm0pb02a3stEJlzvGoRWMu2BIz1poxaTfxH2JFcTTSfpGH203iJRw?=
 =?us-ascii?Q?g1reD57YW+Xbq+iApXVxCKWCa1J1Jx3f+RfXYWgf4Koj7Go92AXEsMc7q9Xw?=
 =?us-ascii?Q?ABePBQ/R7BYSR5ZYiChRlxkifCor36ExPywJlLCIvsw6kPlJukxLIRn48bOR?=
 =?us-ascii?Q?4qeYAIpjEbFkhYIS3bJ5JkM0VYVXi3lGW1AzZfBlDgZqv3NTbywKs2k2UKVs?=
 =?us-ascii?Q?EvrNftFbP+5YrnuAj0gGNIC8ceR0Ff9IKjTeuOsxnlHaP4IoHXhZk110W49R?=
 =?us-ascii?Q?EIFWXRVEDw8cmctDtRD8dxrO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 06:31:03.6385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610515a3-007b-4fc9-8119-08dc7a28c11b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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
Signed-off-by: Jiri Kosina <jkosina@suse.com>
(cherry picked from commit c1db0073212ef39d5a46c2aea5e49bf884375ce4)
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

