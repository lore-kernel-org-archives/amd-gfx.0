Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4145BC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 19:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58BB10E653;
	Mon, 13 Jul 2026 19:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="szL1iBGK";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F111A10E653
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 19:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTbJIedhlUWE/XM6HwSjfNJUfY70dCnmQvQ5+O2RKgzBgWZsqnj4ImQ1gX3D25dm5eedMac2UzzsCa1ikr7DSGC8ImV8QR6EspQ9bfQeLJKgpVqe1WeWaTTKeoIzplmuSYiRZpmQ1JJoJ/rxoFoCbUBvjoAKk5oNSI+kXTt5Nqbd1hf88kfUJm0prOFJDNPxWwlXRqSOJN9eLGAGbvkvbsE0lomrjHLOtX6OKC8MWx3mJV2VpbbE60QR3KwuznuZtU/+UOTWGeT1m32KFO35IkoPNX4PVnYWBUx2Mg4bdMKZU8UrGNy+qHUqMMxfZjhdd0XaoMibCIs6EobpjCWXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ9pER5GEDuPlr9OiAvlVjvGSQvVipyHgp6APSmTV/c=;
 b=spcdljOzQHAK9PnVUvT/TDmg3BVXOrAycfKMCK8zYKSM3Gk7SyWeIoBoIO2u0yaCXp6EjbjVkip4EXKPLpVG/fs7Pm8owJS9Vk1pMK+1dW9mEkIbjKq8xvOF9OuLfnSmAmbz2CH7b1y7Q/VcysMIZTmsFtnIO/kgCzcdOFB5btbZ8zF5tscp7vX3Egt4ihBIVQwpW+f6sJsJ/DvxuSr7OeTQEWDxri8DUSvd5YCWX7+X3TwxVKx79jA2IT3eBQ1wxK3PxPBGGg91ls/RqHNfbDSzStuOTfBuVmIbGu/0a8R1kAgfP4imm4Tme2es7R0mxgCpmLR34tgXSdCswjGa1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ9pER5GEDuPlr9OiAvlVjvGSQvVipyHgp6APSmTV/c=;
 b=szL1iBGK8ugeBoE3Vq28LItpPiIl1ohtVUzzXKWtOSfQMsU1Hs6yB8154/KXXw1xcIdLtEfJcXlajmNzMUsceak41LEZ/NG4rXv3kXQlgP1ABnfkUIYRbC8c15+OkqwLB3HnOfiLl7kI8Pms5yIBackcygkYR6rKGKkrieQRDFY=
Received: from SJ0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:33a::22)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 19:53:28 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::29) by SJ0PR03CA0017.outlook.office365.com
 (2603:10b6:a03:33a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 19:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 19:53:28 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 14:53:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Aaron Ma
 <aaron.ma@canonical.com>, <mrh@frame.work>
Subject: [PATCH] drm/amd: Create a device link between APU display and XHCI
 devices
Date: Mon, 13 Jul 2026 14:53:13 -0500
Message-ID: <20260713195313.1739762-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 0255d328-770d-4d7d-ab04-08dee11868a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|11063799006|6133799003|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: MkK0UWEr0+rA59J7wYgas8F+lelyHraT0O9dvsfPmcPHx7FtrAhuIF8Q0EBpwJjm76QyAF6NSFI4DI8QLZP4/EIrgZWa66q2bNJYPjOBGoROMd3AaGs2J5gEjz3OLI2T31dyiM4d4UMRoPeEpbx7Q1MosZim68Ejt+c0h/OZkRpfWFAKvOP3+BpYa8cJl5yupTRDkWmrPXWoN/ZB5mF+XhKgWE1rbbFd9KuW4dsWKXwJNnFQHYAkXu3vGKycZyaPW7FzPtlu5tzujWKmUl92ko/MsJAfEyiFfH1zRzflSN1fHMQkT24OfdaOUE+9OQ/900zaAl3x+qVFkPy11tB6vyW7UEBTrPXZSjknGKIiehoJN44lj5VNPGnjJw3BskSo6iRapuW8k4Khl5Vc6mbvfNU7+TzLrZ21hDLPjm4jL/2NuzvqJujRMpOh8LAQcFOBNb8NVOuztcUp53QF+NpLtF89MEu16ZJdHfxACZCiRaBwJ5GlKY0b9E2cYdeOnFg80qGXgkf6yxC8JTb2ApojQeJltgiNBI+O5oaEqyz3Hh9qf8OTbkVMLUgze/ytL+5az/c8HgCivdBAYvp5hMYYhr2nOwnXi8wa3uxYkgyp6asfQUmypE3s3/1XeyX8QWIknhpYjDl3CqMoXPq1eXgby4Dzqi6pjFmrvVfg/jFYgWGrYPQ8Q5m2ea5uci77i73Qg97d6S1HekPgoJ5/3FEK5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(11063799006)(6133799003)(56012099006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +vaZXz1NFsjkM8bPv5tc5f9KQ9z+2zUX62TmMkKiOVzCpDYaMXJYoBouHcIP/kvkrRrH0maRujH4gcwMaPAIVwM+HfgD6w+MEQZDrt5/9K4IS80hs9G0itcFRUxFHS70XI4IvTfbFiYQJURVpY4dpFVcP3+aLbBTjajP6KJs/NTkEFxnqXZC6TrYm0rSD2o5ZubENddwH1x8GgJKxIlcPi1emDDxztcDSckRzoivH/MzRmaqAtfRKNcKrsJKWcC6jypAe6ylXkbl8ZhM2BRjYLRyYKES3/7MgOZSdwa40ONu4QP+0bA0sPww2Zvxhy18yXU0wR8b/N5E0+S2fZyxOLyZ4uZW917iRgBREcQMX5i0+hroJxDsrbpy3wGCi/jwZEDP8czHvWTXXeRAmLkXPLxQVwmEBssepEWw21aFaqSLi28U7FBhEhVX6KQqGo0Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 19:53:28.2815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0255d328-770d-4d7d-ab04-08dee11868a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006
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

Some AMD APU multi-function devices expose an integrated USB xHCI
controller. In some circumstances (such as larger VRAM), the PM core
can resume can fail when the xHCI controller is resuming in parallel
with the GPU/display function.

On affected systems, the xHCI controller can complete pci_pm_resume
and start resuming USB devices while the GPU is still in its much
longer resume path. This race condition leads to USB device resume
failures followed by:

  xhci_hcd ...: xHCI host not responding to stop endpoint command
  xhci_hcd ...: HC died; cleaning up

Create a device link from any xHCI controller sharing the same PCIe
root port as the APU display function. The link uses DL_FLAG_STATELESS
and DL_FLAG_PM_RUNTIME to ensure the GPU completes its resume before
the xHCI controller begins resuming USB devices.

This device link is done specifically in amdgpu so that if the
platform firmware has been modified such that this issue doesn't happen
the version can be detected and the workaround skipped.

Suggested-by: Aaron Ma <aaron.ma@canonical.com>
Reported-by: mrh@frame.work
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221073
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 +++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 11 +++++
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 45 +++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4314dff4ac996..c1ceec7a1986b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1366,6 +1366,14 @@ static void smu_feature_cap_init(struct smu_context *smu)
 	bitmap_zero(fea_cap->cap_map, SMU_FEATURE_CAP_ID__COUNT);
 }
 
+static int smu_set_power_dep(struct smu_context *smu, bool enable)
+{
+	if (!smu->ppt_funcs->set_power_dep)
+		return 0;
+
+	return smu->ppt_funcs->set_power_dep(smu, enable);
+}
+
 static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1427,6 +1435,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	if (!smu->ppt_funcs->get_fan_control_mode)
 		smu->adev->pm.no_fan = true;
 
+	smu_set_power_dep(smu, true);
+
 	return 0;
 }
 
@@ -1449,6 +1459,8 @@ static int smu_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	smu_fini_microcode(smu);
 
+	smu_set_power_dep(smu, false);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index f8fd93999617d..7ea7c4a5279be 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -749,6 +749,9 @@ struct smu_context {
 	bool pm_enabled;
 	bool is_apu;
 
+	/* Power dependency link from an integrated xHCI controller to the GPU */
+	struct device_link		*usb_power_link;
+
 	uint32_t smc_driver_if_version;
 	uint32_t smc_fw_if_version;
 	uint32_t smc_fw_version;
@@ -1618,6 +1621,14 @@ struct pptable_funcs {
 	 */
 	int (*ras_send_msg)(struct smu_context *smu,
 			    enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
+
+	/**
+	 * @set_power_dep: Create or destroy a power dependency link
+	 * from an integrated xHCI controller to the GPU so that the GPU is
+	 * resumed before the USB controller during PM resume. @enable is true
+	 * to create the link and false to tear it down.
+	 */
+	int (*set_power_dep)(struct smu_context *smu, bool enable);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 2fe006de927a3..2abdfef8644e0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1701,6 +1701,50 @@ static int smu_v14_0_0_restore_user_od_settings(struct smu_context *smu)
 	return 0;
 }
 
+/*
+ * Link any xHCI controller sharing the GPU's PCIe root port as a consumer
+ * of the GPU so the GPU resumes first, avoiding an xHCI resume race.
+ */
+static int smu_v14_0_0_set_power_dep(struct smu_context *smu, bool enable)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct pci_dev *gpu_pdev = adev->pdev;
+	struct pci_dev *root_port, *usb_pdev = NULL;
+	struct device_link *link;
+
+	if (!enable) {
+		if (smu->usb_power_link) {
+			device_link_del(smu->usb_power_link);
+			smu->usb_power_link = NULL;
+		}
+		return 0;
+	}
+
+	root_port = pcie_find_root_port(gpu_pdev);
+	while ((usb_pdev = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, usb_pdev))) {
+		struct pci_dev *usb_root;
+
+		usb_root = pcie_find_root_port(usb_pdev);
+		if (usb_root != root_port)
+			continue;
+
+		/* Create device link: USB (consumer) depends on GPU (supplier) */
+		link = device_link_add(&usb_pdev->dev, &gpu_pdev->dev,
+				       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
+		if (link) {
+			smu->usb_power_link = link;
+			drm_info(adev_to_drm(adev), "USB controller %s D0 power state depends on %s\n",
+				 pci_name(usb_pdev), pci_name(gpu_pdev));
+			/* Only create one link for the first USB controller found */
+			break;
+		}
+	}
+
+	pci_dev_put(usb_pdev);
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.check_fw_status = smu_v14_0_check_fw_status,
 	.check_fw_version = smu_cmn_check_fw_version,
@@ -1734,6 +1778,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.dpm_set_umsch_mm_enable = smu_v14_0_0_set_umsch_mm_enable,
 	.get_dpm_clock_table = smu_v14_0_common_get_dpm_table,
 	.set_mall_enable = smu_v14_0_common_set_mall_enable,
+	.set_power_dep = smu_v14_0_0_set_power_dep,
 };
 
 static void smu_v14_0_0_init_msg_ctl(struct smu_context *smu)
-- 
2.43.0

