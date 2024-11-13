Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCB3D41C08
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 06:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C8710E350;
	Wed, 13 Nov 2024 06:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JxJAjOUU";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B006D10E350
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 06:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNZvR78QOmL90Ei8gZkXUkDntyih25tY/JkZdDyVrCCaFTRHeH9PDvgPPgV3B4bOe3tnoXJguPwHuAn9LtafdDbLKRohbeRLXHSogC8xAUpLcm0ytgpgkDGgJR9rr9qFk/FijGo4NLy2g7zAWp1jFLZNvp7gtM9CHs99FWcg/DCcc6Mc3g4rEs4TWifLoniGuwWZaccMM9SLShExY89e0AXf7+X5JhsqN7xpDGW2ZXJB9ZGADEkfZQnbw8J8lsGqV+OEeuTVvqzSTokq12inHYKdi4ImrYdsbeTBB4vRkwaHodwqvCUpTSl9lSgUoczCXi4/XgBudQcxyeGME/qbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh0Y2MxkJVvyFfpr/tlP1AXTnPe3hssj7LLnmybxpXg=;
 b=qYI0gbXiQqykY5GbGN7GXCoGVMZ7XZ1JCCzFd7XhIBpJO38U/v9cgttd/c+3GdzXbQuSAhG/Y4i/C1PkbhVCkJTYZwuqQfrh06b2K6Atm2C022A7ILRXgsPyQq97gynjI+jEQTQ7svRj8LN2prEFa5VGbiQiqItmS9Eo55/7orl1At2zjiNs7Z+v3Mu/eXNz18DFBoEgu+E8l0dOjMAIxSKM2yvcVj0PpNNEyxN7iuJ8gENfsndBDQeISMf/G+E+s4RdUyz7+tnwe2JFv1WbfeWLYHtxt+joLBLtgD5MFXLSSkqDgdCEBnXKBLvIBNkKQlzK5ZTD4/nvqZlRD5NcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh0Y2MxkJVvyFfpr/tlP1AXTnPe3hssj7LLnmybxpXg=;
 b=JxJAjOUUIg0B7SQVfbVCmWp49h1H6R4xEUY12kdOdmi+FTbqJGcT1nkvA5Rt0iAdcCZPtYPlyJ1kIka61pOupODycyRY6lNIwY7CqIODI4cPO+cNSmkBWnIe1yhMjwhvHk1VOJx24Ex0cwN92HxqTbkvmBmZvjLXMkrADzGEP/M=
Received: from PH8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:510:2cd::16)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 06:37:50 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::5c) by PH8PR07CA0008.outlook.office365.com
 (2603:10b6:510:2cd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 06:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 06:37:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 00:37:48 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 13 Nov 2024 00:37:46 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>
Subject: [PATCH] drm/admgpu: fix vcn reset sysfs warning
Date: Wed, 13 Nov 2024 14:37:45 +0800
Message-ID: <20241113063745.2011455-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: acfcc511-aa2d-4b3f-5335-08dd03adb164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fogo5kTkmdesvsW0PR5YcXYqGqOeKauiU8mvDsIk7PKjBKpo1pL+zI4z7wsb?=
 =?us-ascii?Q?sLmRb0NtoNb01HoijQucSg/EHkvDkKYQa8/IWLJcf+rk5aL0jqQCZfWBgzsf?=
 =?us-ascii?Q?9J/0spyedz75Mw9kZDPjEFIHm3fRXeRl7jh6NDB7eyzlpl/hliu41XA5ePa+?=
 =?us-ascii?Q?DKpGvmmMVy+XQl36vZmj8sZBGYIIBdnv3pu6T4x0SqAtJSFoXGSOwuSLEoVU?=
 =?us-ascii?Q?zK6mZCV1ea9AMwqNpgG9oSJBq+YSi+ffFyMUOAqiDqUwsYyiRUakQIHA7SZH?=
 =?us-ascii?Q?dOHhIA/kh3mW1M1eEuiR0vkjDD4sDBuJnT2mhNRvgC8Q0MGRNh5h1c5W5+RP?=
 =?us-ascii?Q?uHWB5AGort1LO/EHoLUWgvQh6xOh3O6gM7GFRyKQkzqXkIPIJn2dvtklo2eq?=
 =?us-ascii?Q?sr9ICVYJ732IUF5iUotVhhP65yf9RZQBY41qKF2cz2B1/q+std7ZP2Mchhc9?=
 =?us-ascii?Q?eEyq6PqpsVfyAHMHkSsaZZ8Nzdt9+C6QjTv6WkgCviNX6n4QKBdfDjEMNSnq?=
 =?us-ascii?Q?svrlKSx+YRM9FmARRUgCBBf3z4U4dq6eaezKNBo7T369opjxQ5tfSaehXi1h?=
 =?us-ascii?Q?R+FpyMWMPnQj/MQCURKSrPf49jxeWaG1VkbH5xYZI/EMl3XXzD6Tx5uorlif?=
 =?us-ascii?Q?XAFiwaNfZqeP/TphzRgWrroeHFRJuRYuHmqrAy/I5oe0UF5vHxECoEkItNG6?=
 =?us-ascii?Q?Kdj35iwKlGMYhGVgk+4Nrn5Q8UvmeMIjkuTpXB8o/Kc6S47iWW+clNkuNoKf?=
 =?us-ascii?Q?7UlUU0+z8Y+KoXEmfMQboPnM0ZJZzOklNJ33hwV3vP4TFvKeFaleJMrc4/Vp?=
 =?us-ascii?Q?zB/2SbRs3XnpLXzknsbnuChhd4Sp2MmfoV5lz7b+5ivBA+O0cOJCoDlVnL9s?=
 =?us-ascii?Q?8SBNeFNLSszJNlvJlSTdeeGu3rlSTzrthOP0e4nrSLm26YNexfd5S3eHjLpN?=
 =?us-ascii?Q?5E6HKnNvJ4wsbJzI380TA1ifkOn+S145AhysNxXAfiiEbDTlueEfFfZ0vlIL?=
 =?us-ascii?Q?6Confi/sxLEezJLg5LEe4SHlkFwmq47X/+YNTcgpeBCH4IjlUylE+g0B8Mqh?=
 =?us-ascii?Q?y7NtGnjffOX5SbuHXePuhdgc095WCs7wINl0dfA2FSYuonw7if8IzMW3UbOe?=
 =?us-ascii?Q?/eFM3moOyILuPVI3963CEoCUTM6RtpEZPePy2zR+IMxR3/LwkYwUfTOojiDk?=
 =?us-ascii?Q?7v76Tqvw+ximQCgx2b5rWxwsRFPXRJ1Qb8nzfS4g120r6zzJ0QGtgpOL5k4b?=
 =?us-ascii?Q?esih02nmy8kO2NUTjY2jpGLrgmipUYEJvxMCTx1ulqyBNgkFwpk/3GnYwAzW?=
 =?us-ascii?Q?Cfe47daXdrl6sHOH65oT55vHxJICQzyi2h2KS5NBvxECuvaeOX8uNQrN9HJR?=
 =?us-ascii?Q?QkziXuqunamIdFaTEI6123PhCI3z94/W78xz5LIBu8DygjkPEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 06:37:49.5908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acfcc511-aa2d-4b3f-5335-08dd03adb164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758
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

sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.0/vcn_reset_mask'
[  562.443738] CPU: 13 PID: 4888 Comm: modprobe Tainted: G            E      6.10.0+ #51
[  562.443740] Hardware name: AMD Splinter/Splinter-RPL, BIOS VS2683299N.FD 05/10/2023
[  562.443741] Call Trace:
[  562.443743]  <TASK>
[  562.443746]  dump_stack_lvl+0x70/0x90
[  562.443751]  dump_stack+0x14/0x20
[  562.443753]  sysfs_warn_dup+0x60/0x80
[  562.443757]  sysfs_add_file_mode_ns+0x126/0x130
[  562.443760]  sysfs_create_file_ns+0x68/0xa0
[  562.443762]  device_create_file+0x46/0x90
[  562.443766]  amdgpu_vcn_sysfs_reset_mask_init+0x1c/0x30 [amdgpu]
[  562.443991]  vcn_v4_0_3_sw_init+0x270/0x3e0 [amdgpu]
[  562.444120]  amdgpu_device_init+0x1a0e/0x35a0 [amdgpu]
[  562.444227]  ? srso_alias_return_thunk+0x5/0xfbef5
[  562.444230]  ? pci_read_config_word+0x2d/0x50
[  562.444235]  amdgpu_driver_load_kms+0x1e/0xc0 [amdgpu]
[  562.444340]  amdgpu_pci_probe+0x1c3/0x660 [amdgpu]
[  562.444451]  local_pci_probe+0x4c/0xb0

For multiple vcn instances, to avoid creating reset sysfs multiple times,
add the instance paramter in reset mask init.

V2: create one sysfs file per instance.  E.g.,
    vcn_reset_mask, vcn1_reset_mask, vcn2_reset_mask, etc. (Alex)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 92 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 14 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  8 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  8 +--
 5 files changed, 104 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 25f490ad3a85..e3eab01ea38d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1289,32 +1289,114 @@ static ssize_t amdgpu_get_vcn_reset_mask(struct device *dev,
 	if (!adev)
 		return -ENODEV;
 
-	return amdgpu_show_reset_mask(buf, adev->vcn.supported_reset);
+	return amdgpu_show_reset_mask(buf, adev->vcn.inst[0].supported_reset);
+}
+
+static ssize_t amdgpu_get_vcn1_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->vcn.inst[1].supported_reset);
+}
+
+static ssize_t amdgpu_get_vcn2_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->vcn.inst[2].supported_reset);
+}
+
+static ssize_t amdgpu_get_vcn3_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->vcn.inst[3].supported_reset);
 }
 
 static DEVICE_ATTR(vcn_reset_mask, 0444,
 		   amdgpu_get_vcn_reset_mask, NULL);
 
-int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
+static DEVICE_ATTR(vcn1_reset_mask, 0444,
+		   amdgpu_get_vcn1_reset_mask, NULL);
+
+static DEVICE_ATTR(vcn2_reset_mask, 0444,
+		   amdgpu_get_vcn2_reset_mask, NULL);
+
+static DEVICE_ATTR(vcn3_reset_mask, 0444,
+		   amdgpu_get_vcn3_reset_mask, NULL);
+
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev, int inst)
 {
 	int r = 0;
 
-	if (adev->vcn.num_vcn_inst) {
+	switch (inst) {
+	case 0:
 		r = device_create_file(adev->dev, &dev_attr_vcn_reset_mask);
 		if (r)
 			return r;
+		break;
+	case 1:
+		r = device_create_file(adev->dev, &dev_attr_vcn1_reset_mask);
+		if (r)
+			return r;
+		break;
+	case 2:
+		r = device_create_file(adev->dev, &dev_attr_vcn2_reset_mask);
+		if (r)
+			return r;
+		break;
+	case 3:
+		r = device_create_file(adev->dev, &dev_attr_vcn3_reset_mask);
+		if (r)
+			return r;
+		break;
+	default:
+		break;
 	}
 
 	return r;
 }
 
-void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev, int inst)
 {
 	int idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		if (adev->vcn.num_vcn_inst)
+		switch (inst) {
+		case 0:
 			device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
+			break;
+		case 1:
+			device_remove_file(adev->dev, &dev_attr_vcn1_reset_mask);
+			break;
+		case 2:
+			device_remove_file(adev->dev, &dev_attr_vcn2_reset_mask);
+			break;
+		case 3:
+			device_remove_file(adev->dev, &dev_attr_vcn3_reset_mask);
+			break;
+		default:
+			break;
+		}
+
 		drm_dev_exit(idx);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 7ff4ae2a0432..e655bc32a3cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -304,6 +304,7 @@ struct amdgpu_vcn_inst {
 	uint32_t		vcn_codec_disable_mask;
 	struct delayed_work	idle_work;
 	uint8_t 		work_inst;
+	uint32_t		supported_reset;
 };
 
 struct amdgpu_vcn_ras {
@@ -332,7 +333,6 @@ struct amdgpu_vcn {
 	uint16_t inst_mask;
 	uint8_t	num_inst_per_aid;
 	bool using_unified_queue;
-	uint32_t		supported_reset;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
@@ -519,7 +519,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
 int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
-void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev, int inst);
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev, int inst);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 59f83409d323..f79008f51089 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -224,8 +224,8 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_fw_shared_init(adev, inst);
 
 	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->sdma.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+	adev->vcn.inst[inst].supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[inst].ring_enc[0]);
 
 done:
 	if (amdgpu_sriov_vf(adev)) {
@@ -250,11 +250,9 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ip_block->ip_dump = ptr;
 	}
 
-	if (inst == 0) {
-		r = amdgpu_vcn_sysfs_reset_mask_init(adev);
-		if (r)
-			return r;
-	}
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
+	if (r)
+		return r;
 
 	return 0;
 }
@@ -292,7 +290,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+	amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(ip_block->ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index e9b869f373c9..b862c9c7e98f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -185,8 +185,8 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	fw_shared->sq.is_enabled = true;
 
 	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->sdma.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+	adev->vcn.inst[inst].supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[inst].ring_enc[0]);
 
 	if (amdgpu_vcnfw_log)
 		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
@@ -217,7 +217,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		ip_block->ip_dump = ptr;
 	}
 
-	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
 	if (r)
 		return r;
 
@@ -254,7 +254,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+	amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(ip_block->ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 96ec01cffea3..703aa5ee7e6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -168,8 +168,8 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	fw_shared->sq.is_enabled = 1;
 
 	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->sdma.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+	adev->vcn.inst[inst].supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[inst].ring_enc[0]);
 
 	if (amdgpu_vcnfw_log)
 		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
@@ -186,7 +186,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ip_block->ip_dump = ptr;
 	}
 
-	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
 	if (r)
 		return r;
 
@@ -223,7 +223,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+	amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
 	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(ip_block->ip_dump);
-- 
2.25.1

