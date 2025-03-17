Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D65C35FF3
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 13:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5628D10E12D;
	Mon, 17 Mar 2025 13:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tg3+PKC1";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8E310E12D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 13:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQPMevBXn2sODn6up9Q2TZO+XB+Du8RHIBtM+Gw4h1DSd0sasOIS8VVrZA49NJt6aEw7S8QBhjVWXSZxfA9a0iiz+XNim6QeCBkY1xWGn1OrwjLM/5shE670EOeAVUIOPPH6D1fOAvug46ixn+k4b/V9LoyNH3mm3WVdEf40vqwC2q9iQyJnuL3KgxXZfyxP1Cbrs0FY/dd7CEXnIThBgUwvNHVqBs76OOcmW1Gp1MjcT3+h4rwQ/3FpxQMrAgQfSKDraEDIBvuZ7q/Tm5tRMS20Qatbx2xcZrXylQzGfCaKHIOqJWi4kVjivqjjIQ+m3Ih4un3Hmp17ffVAWOr5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUicYAHyDHvNlFbV1I54/3zTTyMYenh2UvVVoES+muU=;
 b=hSuWEGoLxOp8QR8tCG7KVrC/HkZfdc8KLjIJjGC5NusBCeI8faHflhRxoEFNL+FrOrkHiyciNWE0hElZLVPYS61aa1TUfRAbkfxeniz1xn7fqBsiUK3FL1zrct6OnsymJ68DDkqkeiBHJpOv4byLN6XVU3tBpK+Ayzl96PN+Jm68PBbeaMLLf04ngfsvFGUOg0Qq/VOXgQhCso75oq0IEReaLtgooJPQ1euqG6PE015pqCmeB0faZ0T2oK9TGKU9l8/d2FpSCsPAdvmTAVslZH+40qnyYQoUmUq+uYQEF1IF+xQ2jI0M8MkrXAK8Mg9MIwmjYn83vLV2WpKcBYIq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUicYAHyDHvNlFbV1I54/3zTTyMYenh2UvVVoES+muU=;
 b=Tg3+PKC1IUDmD67kZVwYntCznbpMPusj09DjvROyYRBS7ejEzqO6yE6zeGip1uVWFSHrw+uzgh97XzJuFgsZEJeTjPFt4QANo+ZZne/xwXP23t6BFiXvEWsZ6a4vxiXYrXwuRrJ/OXFZ6+3Z3X3yRP5Ih+pVuYyWA5+bi8Bl3bw=
Received: from BLAPR03CA0059.namprd03.prod.outlook.com (2603:10b6:208:32d::34)
 by SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:46:22 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::b1) by BLAPR03CA0059.outlook.office365.com
 (2603:10b6:208:32d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 13:46:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 13:46:21 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 08:46:20 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Skip pcie_replay_count sysfs creation for VF
Date: Mon, 17 Mar 2025 09:45:55 -0400
Message-ID: <20250317134555.179491-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 38cf3842-07a2-474c-cc0a-08dd655a1a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YbgPUF+jJk9SRyRtpTIPJKvukDzhx3VSknIOAwFRIIWadkccXSofH41TL7BB?=
 =?us-ascii?Q?EVYTIewZT6/4bOpB6vBK2srFQgAsMh5iaT50LCjOtQ4WfZv4j+6hpcarOJ8H?=
 =?us-ascii?Q?kmV3TT93duTA0Cupi2h3SkPyPJEMGc8irRNVhVbo4q9AjArFDvJ7Q4lD/beb?=
 =?us-ascii?Q?fp3HwL1iejGzIjtMI+YHy+8conBoTCQZqtfQGBcK8QgEuYscZehY3CtntHaN?=
 =?us-ascii?Q?7liGtGrzkWxQkmPjieuXor1Qkgb4jMYvf63JozL8uukaXFBkZcMKsYFtQQUS?=
 =?us-ascii?Q?ztinJu4rhV4sp6BtdgZnS5Nda8KHKlPNyj7JEpYS6AKtBAl2c9qRAIjXgeJJ?=
 =?us-ascii?Q?buoUnvn6ZnbgrtNIsRGfEuv+snnR5zWfaZgkOR+t9lwLUMyTNFgXPRFtHqSj?=
 =?us-ascii?Q?aNo53ds30fcJ3CzSIEUTERFpBF2pkAJGAIrBtnMigEpQve5/ZdMbzR8Q5SeP?=
 =?us-ascii?Q?/Zr44cnBFcHL03g14zTUtFeGKk+YG2PhbpuB+eXfVmzlTXNWc4v7I50Xt8vw?=
 =?us-ascii?Q?1HMj7A+lVukM9u+y45ovZ70JmszLmg9ynOIM5IWlDwIhAO5O3zBknzl+aoLA?=
 =?us-ascii?Q?wcvpKXIxmOKr/2J/EZN88Qr+AudWuw7fKHWlZrESkSS4xhZyCVNnLxkoUaQX?=
 =?us-ascii?Q?zgQ4+F3s/E6NVoZU3pVuKABKB1Fg4xE403M596dUIllSrAT0eIEdK1aYMjEM?=
 =?us-ascii?Q?EbNZZaXiUxhQs6j+20iYNbH4KXlLg+GYo1W2MLObX+XYHXvAP82P2cHPgvV4?=
 =?us-ascii?Q?OJwcq1Dcc8fcOfnK+WwCvhJRg3VRB7wzoKATgBpYl0UMCAfXr7sktZ7olCLF?=
 =?us-ascii?Q?gRt+KSJMv0Fz52nyUAy6DV+Xf0MFA7RlMBy+HQcgsiZq30p6sdhEAllVhdlv?=
 =?us-ascii?Q?14AAZOvX5UKYjjKOXFikeFE/rzElDfEKwvKmg6WwoL2PTsrTa2XfMwJkub3C?=
 =?us-ascii?Q?MAI8h7hhUn1IAxwTah0JPq1dbAxeNgT2NbO/BPvht95kO1ISufML5LEQeooV?=
 =?us-ascii?Q?alY/NI7KwfTu6iFKo74m9kQKHo5x5DN9uKCn8P2JmYpVgTyf6pSTHNkpa9s1?=
 =?us-ascii?Q?yjHcv0rNci+yJ3az6bri/pL3SD3tlZk+IKEUcvfJgdiV3SNM3+OorGAPn57t?=
 =?us-ascii?Q?/DQT8fw32MZivNMf8USfLFJGI/rtRRwMmAg3ZCyNlJWCykb2fFxLlyW+1FYb?=
 =?us-ascii?Q?u++2A6iShG1feJ0Wv/0Jb0Z0+nufbni5ldT9zIKu/HaDM1VJMU+ZBztNhwe4?=
 =?us-ascii?Q?SXz8XpXCrjbGvFdF2Xc7F8FC3UyKPo1c51VsIDdu6bqE4l4yjoFQauRPn4CH?=
 =?us-ascii?Q?8Re4aulGSPldr2sIqtE+QIp6zSqiUE2ExL0HuUZVGDUlAVYxjqzSSPVxo1uu?=
 =?us-ascii?Q?OCYX5ecUFA/cAnMu8j2Ar42Vtx4J4W6IeE2dFqIu3dkbcDabr1AiW529x2yE?=
 =?us-ascii?Q?wem7Z+7zDqgT5VPjNm4EF8e0xYW/Z0FCPMNizASCBCM/8qHegiarTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:46:21.5460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cf3842-07a2-474c-cc0a-08dd655a1a18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942
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

VFs cannot read the NAK_COUNTER register. This information is only
available through PMFW metrics.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7ca2ebdd3c95..86236cfad38c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -227,6 +227,24 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
 static DEVICE_ATTR(pcie_replay_count, 0444,
 		amdgpu_device_get_pcie_replay_count, NULL);
 
+static int amdgpu_device_attr_sysfs_init(struct amdgpu_device *adev)
+{
+	int ret = 0;
+
+	if (!amdgpu_sriov_vf(adev))
+		ret = sysfs_create_file(&adev->dev->kobj,
+					&dev_attr_pcie_replay_count.attr);
+
+	return ret;
+}
+
+static void amdgpu_device_attr_sysfs_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev))
+		sysfs_remove_file(&adev->dev->kobj,
+				  &dev_attr_pcie_replay_count.attr);
+}
+
 static ssize_t amdgpu_sysfs_reg_state_get(struct file *f, struct kobject *kobj,
 					  struct bin_attribute *attr, char *buf,
 					  loff_t ppos, size_t count)
@@ -4166,11 +4184,6 @@ static bool amdgpu_device_check_iommu_remap(struct amdgpu_device *adev)
 }
 #endif
 
-static const struct attribute *amdgpu_dev_attributes[] = {
-	&dev_attr_pcie_replay_count.attr,
-	NULL
-};
-
 static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
 {
 	if (amdgpu_mcbp == 1)
@@ -4609,7 +4622,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	} else
 		adev->ucode_sysfs_en = true;
 
-	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
+	r = amdgpu_device_attr_sysfs_init(adev);
 	if (r)
 		dev_err(adev->dev, "Could not create amdgpu device attr\n");
 
@@ -4746,7 +4759,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_pm_sysfs_fini(adev);
 	if (adev->ucode_sysfs_en)
 		amdgpu_ucode_sysfs_fini(adev);
-	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
+	amdgpu_device_attr_sysfs_fini(adev);
 	amdgpu_fru_sysfs_fini(adev);
 
 	amdgpu_reg_state_sysfs_fini(adev);
-- 
2.34.1

