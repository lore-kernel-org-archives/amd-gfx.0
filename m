Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35CCC83F07
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 07:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9458810E424;
	Mon,  7 Jul 2025 07:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rBRadvUU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6916A10E424
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 07:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVKUeWIksT3dDdOay/aKVgYfpcFwyk0MhBlYo9qU1A7t2OSIq+pRIV0JAEdL1w4uayY2OrSpZj/iBluwnD7+EjFnSAeL0hxZjE7XZfSjWjMb+4UOMdb1pCHUWklxRynO33gLloKEDUY4a3HXGIljghqr5oPM85EhnxGh7b0p9lF+9jP7sjeojle/07bpxZRZSfdWBDUEzT5EhDvLeLwd2+zJ1lnp8HrO20zDIYj66pwizxPE/ehEXiuKhjL2VkMpCofS+WVOg8h72SMDP3krd1kaSCqGyfYaDDXn4n6b8+XMWL71z90ddvrv0UlLsx1ZEb4jRbaMQzdbOHeK+IG31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6euuVqKYtzmCkUbf7MKOCJtyE2K3focfpW9PySEtn8Q=;
 b=rEB+Upj9iQnXeQF/N0VbKeBzmnLpoLIYhDzqUKv63+9Z9U8n2lqrcs14kOxN6M2ErRHa5cAqtBLJzEw/oHJ8dnuEpuuUat488DxswyJN4H6PFTVhvvw17tnm0gA9jlKpEDOH27vyw/R19O50nvDUNuneJ8Pw60iyeXcqkP+lPspm/BKbJeOFzruiJzzXNwegxjs4rUHt369xPNZNWv5TADa2rY0f0j10ZST1muekL6C4S+zJo0BDs7eWevY0MlYh122tWmcYzV+smnFhsweuSLZbXS0Q5XfkIX5JXHuDgL51FrIJFaM0V/bJDfLjMcMcqdSMza5qe+sAaYUAjNXtYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6euuVqKYtzmCkUbf7MKOCJtyE2K3focfpW9PySEtn8Q=;
 b=rBRadvUUjFgt+F5rB4rxJxJXwTi+Ri755TMwyc/IdNObG6+Mou1kqB3dLjH05HyZ50PFjhp1lMagk1xP2lT2cDZqeuZJg3lu210RKd/dHSsMzzBwQhKOvBnKhqAfa/yaxRfAOmot11qSM+Vj+NwIuk0oQVw8L8JMRD1P3wPMXdE=
Received: from CH0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:76::11)
 by DS5PPF922753E5F.namprd12.prod.outlook.com (2603:10b6:f:fc00::65a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 7 Jul
 2025 07:10:12 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::b8) by CH0PR04CA0006.outlook.office365.com
 (2603:10b6:610:76::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 07:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 07:10:11 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Jul 2025 02:10:10 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Date: Mon, 7 Jul 2025 15:09:38 +0800
Message-ID: <20250707070939.6852-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DS5PPF922753E5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 048aa8c2-6ac0-40a9-2d03-08ddbd255098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2QJmJu8USYiu4GyYwf/BCzdvgf2WdTRkW2PBV9pR3dQu4kVTd/a4ahIkk73C?=
 =?us-ascii?Q?8iQVhGD2GvMqezizsfIydYhpwH8BE296sHxH1UqqozCIYcIVYWfoAttWrC3M?=
 =?us-ascii?Q?YkLUoLIOveULIEGCFfpqM5CVRhhGYM6/0rRC3xDPj1xbvh2LldbVXnhAn9RF?=
 =?us-ascii?Q?5YewLhS3NTvBSH2ieyZCzbDdECQAaN8KAhKuv1v0vDMk4xJ0aZGaxKqqH55q?=
 =?us-ascii?Q?KolSpcwutyiXpmLd4Q+uDu5ODZ2i/yi+dzg2SDRlS+cFRpY/uXm86nLKjz/1?=
 =?us-ascii?Q?hHMPv7/QjTU747cWMrNvEb+e8OjjY4nRg48xsiA86XEUIY2kgmO79yvTLayd?=
 =?us-ascii?Q?un8snLH486p72NTNNMyLBu3phtWwIh8AR43rZFLqpY6bWvR0dp936gh/H7GQ?=
 =?us-ascii?Q?vCNergDxhT5iV43KTbPY0CwZkQBFRCD6yuhcA9qxs8gMRqJw2Eib0Bum5jc0?=
 =?us-ascii?Q?SnIN3zODFaTnVjW6WYHhzEI6F8CN5ZkVXWufAUPD4KUfDOG7amzKjwvnjWeU?=
 =?us-ascii?Q?V3cYx4qYQCHZLhTRBHEkkUp/Gb+VxpmD05XeA40mSzsvkfW/L5I15CrAlHZM?=
 =?us-ascii?Q?AJh8SchRytaFcRmWa24dCQ65gFEPBphjn7wjQH1mYvoZeqzNpOhy17ShKusE?=
 =?us-ascii?Q?xMHEe1vJirYz3WteFG2IrIB4ivjveRGkc4sPvwEZfVjtWL97uA3P/HGTgwu1?=
 =?us-ascii?Q?EuDw+1hfwWGVlhJnE04h2NkS1QTLabL0NobmK8W9ZLQ3vwDEfw4XCW6pL8Gp?=
 =?us-ascii?Q?G7fhHj17olg+Xlm57OJSLyhI//cG7t84krBIsivt7yKrW+B7Spgnc4w2KqwZ?=
 =?us-ascii?Q?YvolOrZnPtQ+5a0kFkcH/PgqjDBJOBl0O2SDRGXWmF9zj9VRYurkpEh7xmtC?=
 =?us-ascii?Q?BuiYNpAfqoA2Eb5L54ivNzgBjyR4bWRdp8nAKZ4CkjqsUzdJlxkD34vdtLp4?=
 =?us-ascii?Q?tficLaEdsYRWXwSFnNujJ1bSMRo45AVs8Z+nYbLkofsT9fpp7tOUibOXxenZ?=
 =?us-ascii?Q?AzkXaeAKoQtG8zQYBQvpplFQsJ4nbOE84KnlzNcRZO+8xB101SrPlPInmYhi?=
 =?us-ascii?Q?jtN8iZVsHFMosJ74rnaSEv2pBKYt0gPCfagqWwlfajeRICsm6ZGqbASw18i+?=
 =?us-ascii?Q?wSxbyCOw/2qywBQ+rvGysjpnF8IsDsiTFnVUhhqnEQp5TX0C/AJpMibVZzwt?=
 =?us-ascii?Q?8p4J7wl99TilP1axDIEmnPUVYyTqofxMRGdzu+yrSiZgVRs5D7OIG4LXUKAb?=
 =?us-ascii?Q?hRVA5YvfLvZfbOWirothlvEP53wgO7mZq/BrEV1p4dMVaW5BGjf6PppVOG5G?=
 =?us-ascii?Q?WQa5HQY5MiwOg+5gv7kufhk+J+62z6SAC4WVM76g7DmYLwxfoDavg6t3vH1u?=
 =?us-ascii?Q?M4A8wYyCXutHSIHBGpCWwn4I4dJZQrUINGp8PmNwN1aZCouDPu1mo09NzOKZ?=
 =?us-ascii?Q?i2Ffsp/hSP6u9rOhgFDAJ9Wl9vR4Amv2s1MMJ51YQgCuwNX6HiEnH+YuPJQ3?=
 =?us-ascii?Q?sfGfl5491UYEVTVZwBj3ixiRb8Gao0vaNENr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 07:10:11.9529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048aa8c2-6ac0-40a9-2d03-08ddbd255098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF922753E5F
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

add eeprom data checksum check after data writing, before gpu reset, and before driver unload
reset eeprom and save correct data to eeprom when check failed

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  2 ++
 6 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 84fcaf84fead..ecdebca7f3f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6506,6 +6506,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (!r)
 		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
 
+	amdgpu_ras_eeprom_check_and_recover(adev);
 	return r;
 }
 
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f8a8c8502013..e03550be45b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -196,6 +196,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
 					 err_data.err_addr_cnt, false);
 		amdgpu_ras_save_bad_pages(adev, NULL);
+		amdgpu_ras_eeprom_check_and_recover(adev);
 	}
 
 	amdgpu_ras_error_data_fini(&err_data);
@@ -3539,9 +3540,13 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 		/* The format action is only applied to new ASICs */
 		if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) >= 12 &&
 		    control->tbl_hdr.version < RAS_TABLE_VER_V3)
-			if (!amdgpu_ras_eeprom_reset_table(control))
+			if (!amdgpu_ras_eeprom_reset_table(control)) {
 				if (amdgpu_ras_save_bad_pages(adev, NULL))
 					dev_warn(adev->dev, "Failed to format RAS EEPROM data in V3 version!\n");
+				else
+					amdgpu_ras_eeprom_check_and_recover(adev);
+			}
+
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2af14c369bb9..2458c67526c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1522,3 +1522,28 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
 	return res < 0 ? res : 0;
 }
+
+void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control = &ras->eeprom_control;
+	int res = 0;
+
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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index bfc86f1e84e5..f36fe46541ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -80,6 +80,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
 						err_data.err_addr_cnt, false);
 		amdgpu_ras_save_bad_pages(adev, NULL);
+		amdgpu_ras_eeprom_check_and_recover(adev);
 	}
 
 out_free_err_addr:
@@ -168,6 +169,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
 						err_data->err_addr_cnt, false);
 			amdgpu_ras_save_bad_pages(adev, &err_count);
+			amdgpu_ras_eeprom_check_and_recover(adev);
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev,
 					con->eeprom_control.ras_num_bad_pages);
-- 
2.34.1

