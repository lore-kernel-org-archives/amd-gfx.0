Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF93D6A225
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 02:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120C610E24E;
	Fri, 15 Nov 2024 02:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zcQWcIJz";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF10810E24E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 02:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkIN9xZlf/3jdxnbyp19MZltyiY7tpex47wPY0DeaBorNEap58G5RmBO7MwcgVueCG7/GuKtvOpB9Z5T2IYIDWiL6PvhDJgC17jtS6OQwFnqKOElWtG2w+lVNld+xDZ6GYSElERLOjjOZ1Z+dA+KENNMrcvB7902PooYm8DhEbDphTq6agae9S9FjlEqBooKbVDE61EBEWzK+f1Yva8Tgwn7smr7pTYTY7nPH/50U6TuvEKqmUXy5UfNEkHjUC60rxW5XEWFOIjw6SFcnIQxBLHg9XKlpnNrBl/8VdiFr7OlKJBK3YokjK1gp4dml1+/KLsmqNo+TuB8jit3ZWifXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzqKgdZ7vL611kFuxheSYq7Nny72Bbsg7PwX/wpbLao=;
 b=anbPXWDp21ZE0mbmQLUIyKMD7xE9dZTrbRJstPnOgpyzH8w0dslldtgri4vkNKx1sPOg4NhwAhQ3EcpauuO/hWxo9PO46XpXTOvWTYSOwVui3XPv9lvmtnjazCN2QBEhwqwpiEnnV3xOmlBv+PqTwUTFPHoElJmRFSlWRvd6QnUaPLkNy/PwEVYLXUwbKx1nxVWcuSlw6uAhpiZDsd2mXnp2EunJRkC3oI2sizs5CgzkUNvVYDFMHZ/Pfbi7rkzic2gnlvy3Z7fa5drVRRn8p2AKJ/i0pqoZNdsM2zWu5llDNJY94CMO++ptVbSWBxgji3ijkn9J/u4+vMFetbDdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzqKgdZ7vL611kFuxheSYq7Nny72Bbsg7PwX/wpbLao=;
 b=zcQWcIJzRSsUd+UI722LuYQ2GZFcgCXS6QcjJo/XE8QyuJ+z/4A4w5H/SbGGnRlzqYZ+Ra/GTa19/xZjOXcLTTqZZl44dVdBeqe4dy9CCqgnL+vp4U3xrcJd0dBeZdZi0sZetNRMAMAKZumGbTMnr7pAupvqjCr+LkbZXNpUyp0=
Received: from CH5PR05CA0014.namprd05.prod.outlook.com (2603:10b6:610:1f0::24)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 02:08:03 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::31) by CH5PR05CA0014.outlook.office365.com
 (2603:10b6:610:1f0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 02:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 02:08:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 20:08:02 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 14 Nov 2024 20:08:00 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Andy Dong <andy.dong@amd.com>
Subject: [PATCH] drm/amdgpu: Fix sysfs warning when hotplugging
Date: Fri, 15 Nov 2024 10:07:59 +0800
Message-ID: <20241115020759.3692876-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: d134c30d-c340-4470-b63e-08dd051a5678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XhWzCjz7WlyswJK4UuswR/CgR0h6GSTYEd1o5lgGye0fkJNYxLaPj7aqLFrn?=
 =?us-ascii?Q?IFCCy8HwfA2nOsypD77eSdhQuBtpUOmzX/3TXgI02+U8b8opvxaff3paIEb+?=
 =?us-ascii?Q?JtO0egdjsCSols7VFEFKLfqjCIYJ1tVM4w9dd398RHY909QULgMR89C+U+Ky?=
 =?us-ascii?Q?onUUvj6hTIEefzPalgPcgB6Zov1yDPdykx3cPMVtw57PIsA06AAYhEWYq24v?=
 =?us-ascii?Q?cMSWVQS1I3YjMsS084lwjGJwNNMd77F036mL9rvbUoFWflmcJg/DVefFJE+h?=
 =?us-ascii?Q?sZHqngahu7JeaiA7lSg4nmGbHC6/Y8c6xCFekyABBSCavvW0dibTJV1BPuW2?=
 =?us-ascii?Q?cPEVYUOSaIK/oEPMoIolkRmC0LdmlwF7aeDjEzbaK4TArj55fzD23SJnAG8k?=
 =?us-ascii?Q?X0ILuLozs4Q8KuoRivqW0npN4Hdagho3Mkf3IsppHaoCSQm+PzuDf5j7rNAp?=
 =?us-ascii?Q?9j2LwkymIlTRSs9aWAKmUOge5LBOeyj6wai69WiJ+szNw9TRZASpZb3pDU3h?=
 =?us-ascii?Q?5m33Whbbe3iY9WujA6sFB64AUqXrDn3KTy3tV96L886eTBAA2QDQOoEiGaMO?=
 =?us-ascii?Q?iQo7ZZ8MUlF+ZyDrbQiXvX75lJAhG5Vae8AbbKWsZoW+uoYT/ZRroNMlqj+/?=
 =?us-ascii?Q?9y//1jPMjMdPgEJPuaZzmH2x3RTRkX7nvXC4sjiWmMWLE6LuwaNeobgmgoGD?=
 =?us-ascii?Q?FPQrkSbIKSi7d7/MUiH9aBk492IVJJRDjtdudPhrmVM7l/lYPe74UEMC9Hxx?=
 =?us-ascii?Q?LdiEMK5rjuqgsqYjUUCgN4QhI29gJpiUpmb0ddytfsPopcL2l+90qQgmFQER?=
 =?us-ascii?Q?OpMGJfmhIc+XlTynJ4uQGzH2hPJBcY6ZS2d7h7kp6wFTUBDnCZmGeuZ0FHLd?=
 =?us-ascii?Q?CSYPNbnZy2fAw9r1s5kfEK58SMzquJBJ4NEQVMknnfqEvxD0KoyxlPjxFku6?=
 =?us-ascii?Q?sSn1kAKgoisUNwzA9p1p0WRWk/Xx3k0Z7un1I0Sx0P9vtCmMhZid6tQcNt6L?=
 =?us-ascii?Q?EncmeyO52c+KTvu8IwyEHwUXAdviV5xXPWsVmrKKy8nm6t6WxQsEcNbng5kp?=
 =?us-ascii?Q?Vehc4/RKTO+rziT0f6lzjGTc6tFpCrreumQYoZf7XVAkinV1Isgjis/HwlWu?=
 =?us-ascii?Q?wnzhmuKWHARanaOy7Z0A4nVmC/VEoGkwcMwvaw1QaKxNWuXJW0232M56oQrE?=
 =?us-ascii?Q?1ji+I59KtTV/Bq4jkC2NLKdu7BpCmUO8WKClnDILvCj9qhuzj7HyUIORGGdH?=
 =?us-ascii?Q?FrF0FM7PjmG84IXwuKVEO+xVqwtX8bY/ehxJJVqEtdOiXciMfTVT9DYFJ8fI?=
 =?us-ascii?Q?Vc7JTV+VQUJzrsEtfXE7cLnlbjRnTelsLF6ZwHIV81XAl2k1m3IcigVq2EyV?=
 =?us-ascii?Q?lM4l+sDy00el21W2vcH0AOn3+F87xzJeNcUIJr5/QZspgaIQrg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 02:08:03.3581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d134c30d-c340-4470-b63e-08dd051a5678
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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

Replace the check drm_dev_enter with sysfs directory entry.
Because the dev->unplugged flag will also be set to true,
Only uninstall the driver by amdgpu_exit, not actually unplug the device.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reported-by: Andy Dong <andy.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 5 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 5 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 5 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         | 5 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         | 5 +----
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 6 +-----
 7 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c65feb97167d..cda0efd4d73c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1779,13 +1779,10 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (adev->dev->kobj.sd) {
 		amdgpu_gfx_sysfs_xcp_fini(adev);
 		amdgpu_gfx_sysfs_isolation_shader_fini(adev);
 		amdgpu_gfx_sysfs_reset_mask_fini(adev);
-		drm_dev_exit(idx);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index bf4dbceb18e1..7444b556e78a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -448,11 +448,8 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (adev->dev->kobj.sd) {
 		if (adev->jpeg.num_jpeg_inst)
 			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
-		drm_dev_exit(idx);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index 9a0346ed6ea4..ead1ca43e14e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
@@ -130,7 +130,7 @@ int amdgpu_preempt_mgr_init(struct amdgpu_device *adev)
 void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 {
 	struct ttm_resource_manager *man = &adev->mman.preempt_mgr;
-	int idx, ret;
+	int ret;
 
 	ttm_resource_manager_set_used(man, false);
 
@@ -138,10 +138,8 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 	if (ret)
 		return;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (adev->dev->kobj.sd)
 		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
-		drm_dev_exit(idx);
-	}
 
 	ttm_resource_manager_cleanup(man);
 	ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 24e9daacaabb..11c64f087efd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -449,14 +449,11 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
 	if (!amdgpu_gpu_recovery)
 		return;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (adev->dev->kobj.sd) {
 		if (adev->sdma.num_instances)
 			device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
-		drm_dev_exit(idx);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 25f490ad3a85..ed9c795e7b35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1310,11 +1310,8 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (adev->dev->kobj.sd) {
 		if (adev->vcn.num_vcn_inst)
 			device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
-		drm_dev_exit(idx);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index b5f5a1a81c29..dc96e81235df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -904,12 +904,9 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (adev->dev->kobj.sd) {
 		if (adev->vpe.num_instances)
 			device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
-		drm_dev_exit(idx);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 54c05af2eed2..0bbeab852540 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -255,12 +255,8 @@ static void df_v3_6_sw_init(struct amdgpu_device *adev)
 
 static void df_v3_6_sw_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	if (adev->dev->kobj.sd)
 		device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
-		drm_dev_exit(idx);
-	}
 }
 
 static void df_v3_6_enable_broadcast_mode(struct amdgpu_device *adev,
-- 
2.25.1

