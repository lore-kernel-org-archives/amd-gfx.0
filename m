Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB26EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 04:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DDE010E1BF;
	Tue, 25 Jul 2023 04:42:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0787710E1BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 04:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLsfwhinzd87PO72hDx45Gjgixc+i8Qa3vEU0yjljomILfbyons7zNri9nADq5bEitvIUckXsq4enCiZrCngFJp/x4P12qL3oWWHFLXATMyaziu6pn8/xs+URY/d5UXd1NEB7YY96166VDaBeQTYyyCO5rRiJ5IRUQzaTXcfehvguGw6+V2M6SZHOcZWW3oYpwZlSicWjHFzlFHjV6D25VUOKEUwxfLOLL9QpWxxsVPd1CcOTkapNFzkYUXk5C3vFbT4pyx9yvu4nsOl189eFu0OfC7gAulQwqymbe6MJKkKxni+opzWmiQg5PV6+xjOBud658dfVy/vdOMQWF3NbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7LYvfaTxiIqdrhSpJwr9XT4J0qUJpLK5kDJX77ZbFs=;
 b=YEiyp/WKLdAe0JEn0Ybb88QQFWIezvu7uufo4V7dKT7uGjRciVV0FzKpmfoW/Zks55sEEps2hwBm8DL4Ui1zqBjAcFKTOyVhmQ7gmMICw+CB7VQ1VrXwfArURDQuA9rCRWudbyvPFP8/3HWL6mNI9i5L7cpHV1k1TL0i0jOyCwvAACw3UTyBhVjK4BsyM307wyxPbqrUqZPROtDuhyrMoZ+UoW3D+v+8Oh09AnZ/TtGL93rqjq7qCktGDM6+VB/iSSdZG55TAJmUP40Z38RTvyBEjZ6jGJErKC+E8d42uCOc79xNpo1dE2r69Pj9bkXyWzn5/TIwKyjSwZFJ9aHacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7LYvfaTxiIqdrhSpJwr9XT4J0qUJpLK5kDJX77ZbFs=;
 b=PKdi5HkdMGUteCn/JKSTF8sa3lLOz4ZGI1UQoAxnZW6N3vUogNwxLrtvpFa7lvf6uD5FR/6M15x25LrWD0vIosrtx64gQJfI9Z0onSA951AwOCjaMBTvoYtrrFWkqCxS0fGtq7WEor6EWDyaGe+7E28jpg+oZ7K1MrBkMMKJ8y0=
Received: from BN9PR03CA0270.namprd03.prod.outlook.com (2603:10b6:408:ff::35)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 04:42:04 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::58) by BN9PR03CA0270.outlook.office365.com
 (2603:10b6:408:ff::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 04:42:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 04:42:03 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 23:42:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Move externs to amdgpu.h file from amdgpu_drv.c
Date: Tue, 25 Jul 2023 10:11:43 +0530
Message-ID: <20230725044143.2246047-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c1f1d6-5b96-4fce-4aa4-08db8cc97e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qinVqsjsxd1YpfqOHP7h1VgAmPDf4AuJmF22TvJSbtQve4clZNmTwqk2FUHnvCAGSvRYRwOuUkc3xstTsmd8YT5V0WZ9FkZFnn7vThtEo9e6map83kRUKPAflE5PmV6wv095WohhIFrSjshuImpTfP1s+sEfI5N8QP5MguxmdQdcQVXsxqRt50dpVFNrEDvlx0/7rUp6DeX05bWgNqpdGIacKGwHTJ3lX+JGAG7KlzMvwWZv67oubURMN+IHbg6bdwwM9tpnF/yrCWOxClEOilsPWcY5kx1AMtJTpoVYdG06uQV06bx6bMD8aQt1g8l1FLwpuhi716J9mRuuTCBMgiFyM442HTOM85PQci6KIC/UcJurozluQ4kVs+T94C9AqQT6RnM3H6KefNsdE3v9CT4j3ybTLK5PA13Kj60WWr8NDoEx2ukeF8f7y/YdFt2WuI9c7SWeT09VaFcSiBQ9d3yPSImg6KltJIm16dpiDoxzl3b7Mo0PKaLYx7pTEuxE4lnEvNmxTx8XitGKR+r7LCraoQggxjCaZLV0nuausOOxupbbXs1y3q9E54HrWAKWsIN4TCnvZtt/+eY8Rrxf+xLBlrC/vjYfUJ1ufeDIjFVlRWWCvv1GNfwzFxymtsbTEytwI1rhyhgReJE9bwmZ3cQ/KRaxEqwCIG+Hy1dF2i9KcvUn9sOmRBcbOzyubEcaSVPNUObsqv5boC6nXOqBiZOCB/5PWIGrydU9eARzvmVuOotOX3oj4FDVTiA0l84n9R8G4wUQSjfmpurjwF0scQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(83380400001)(81166007)(40480700001)(36756003)(86362001)(82740400003)(40460700003)(356005)(54906003)(110136005)(2906002)(478600001)(336012)(186003)(26005)(1076003)(7696005)(6666004)(8936002)(5660300002)(8676002)(44832011)(316002)(41300700001)(70206006)(70586007)(6636002)(4326008)(16526019)(66574015)(426003)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 04:42:03.5211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c1f1d6-5b96-4fce-4aa4-08db8cc97e24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WARNING: externs should be avoided in .c files
+extern const struct attribute_group amdgpu_vram_mgr_attr_group;

WARNING: externs should be avoided in .c files
+extern const struct attribute_group amdgpu_gtt_mgr_attr_group;

WARNING: externs should be avoided in .c files
+extern const struct attribute_group amdgpu_flash_attr_group;

And other style fixes:

WARNING: Block comments should align the * on each line
WARNING: void function return statements are not generally useful
WARNING: braces {} are not necessary for single statement blocks

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 28 +++++++++----------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a046160b6a0e..93d0f4c7b560 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1524,4 +1524,8 @@ static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
 
 int amdgpu_in_reset(struct amdgpu_device *adev);
 
+extern const struct attribute_group amdgpu_vram_mgr_attr_group;
+extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
+extern const struct attribute_group amdgpu_flash_attr_group;
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c315fe390e71..84446bbc3509 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -313,9 +313,7 @@ module_param_named(msi, amdgpu_msi, int, 0444);
  * jobs is 10000. The timeout for compute is 60000.
  */
 MODULE_PARM_DESC(lockup_timeout, "GPU lockup timeout in ms (default: for bare metal 10000 for non-compute jobs and 60000 for compute jobs; "
-		"for passthrough or sriov, 10000 for all jobs."
-		" 0: keep default value. negative: infinity timeout), "
-		"format: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
+		"for passthrough or sriov, 10000 for all jobs. 0: keep default value. negative: infinity timeout), format: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
 		"for passthrough or sriov [all jobs] or [GFX,Compute,SDMA,Video].");
 module_param_string(lockup_timeout, amdgpu_lockup_timeout, sizeof(amdgpu_lockup_timeout), 0444);
 
@@ -585,7 +583,7 @@ module_param_named(timeout_period, amdgpu_watchdog_timer.period, uint, 0644);
 #ifdef CONFIG_DRM_AMDGPU_SI
 
 #if IS_ENABLED(CONFIG_DRM_RADEON) || IS_ENABLED(CONFIG_DRM_RADEON_MODULE)
-int amdgpu_si_support = 0;
+int amdgpu_si_support;
 MODULE_PARM_DESC(si_support, "SI support (1 = enabled, 0 = disabled (default))");
 #else
 int amdgpu_si_support = 1;
@@ -604,7 +602,7 @@ module_param_named(si_support, amdgpu_si_support, int, 0444);
 #ifdef CONFIG_DRM_AMDGPU_CIK
 
 #if IS_ENABLED(CONFIG_DRM_RADEON) || IS_ENABLED(CONFIG_DRM_RADEON_MODULE)
-int amdgpu_cik_support = 0;
+int amdgpu_cik_support;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled, 0 = disabled (default))");
 #else
 int amdgpu_cik_support = 1;
@@ -620,8 +618,7 @@ module_param_named(cik_support, amdgpu_cik_support, int, 0444);
  * E.g. 0x1 = 256Mbyte, 0x2 = 512Mbyte, 0x4 = 1 Gbyte, 0x8 = 2GByte. The default is 0 (disabled).
  */
 MODULE_PARM_DESC(smu_memory_pool_size,
-	"reserve gtt for smu debug usage, 0 = disable,"
-		"0x1 = 256Mbyte, 0x2 = 512Mbyte, 0x4 = 1 Gbyte, 0x8 = 2GByte");
+	"reserve gtt for smu debug usage, 0 = disable,0x1 = 256Mbyte, 0x2 = 512Mbyte, 0x4 = 1 Gbyte, 0x8 = 2GByte");
 module_param_named(smu_memory_pool_size, amdgpu_smu_memory_pool_size, uint, 0444);
 
 /**
@@ -791,9 +788,9 @@ module_param(hws_gws_support, bool, 0444);
 MODULE_PARM_DESC(hws_gws_support, "Assume MEC2 FW supports GWS barriers (false = rely on FW version check (Default), true = force supported)");
 
 /**
-  * DOC: queue_preemption_timeout_ms (int)
-  * queue preemption timeout in ms (1 = Minimum, 9000 = default)
-  */
+ * DOC: queue_preemption_timeout_ms (int)
+ * queue preemption timeout in ms (1 = Minimum, 9000 = default)
+ */
 int queue_preemption_timeout_ms = 9000;
 module_param(queue_preemption_timeout_ms, int, 0644);
 MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in ms (1 = Minimum, 9000 = default)");
@@ -2417,7 +2414,6 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 			amdgpu_amdkfd_device_init(adev);
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
-	return;
 }
 
 static int amdgpu_pmops_prepare(struct device *dev)
@@ -2614,6 +2610,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	/* wait for all rings to drain before suspending */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		struct amdgpu_ring *ring = adev->rings[i];
+
 		if (ring && ring->sched.ready) {
 			ret = amdgpu_fence_wait_empty(ring);
 			if (ret)
@@ -2738,6 +2735,7 @@ long amdgpu_drm_ioctl(struct file *filp,
 	struct drm_file *file_priv = filp->private_data;
 	struct drm_device *dev;
 	long ret;
+
 	dev = file_priv->minor->dev;
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0)
@@ -2802,9 +2800,8 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
 	if (!filp)
 		return -EINVAL;
 
-	if (filp->f_op != &amdgpu_driver_kms_fops) {
+	if (filp->f_op != &amdgpu_driver_kms_fops)
 		return -EINVAL;
-	}
 
 	file = filp->private_data;
 	*fpriv = file->driver_priv;
@@ -2894,10 +2891,6 @@ static struct pci_error_handlers amdgpu_pci_err_handler = {
 	.resume		= amdgpu_pci_resume,
 };
 
-extern const struct attribute_group amdgpu_vram_mgr_attr_group;
-extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
-extern const struct attribute_group amdgpu_flash_attr_group;
-
 static const struct attribute_group *amdgpu_sysfs_groups[] = {
 	&amdgpu_vram_mgr_attr_group,
 	&amdgpu_gtt_mgr_attr_group,
@@ -2905,7 +2898,6 @@ static const struct attribute_group *amdgpu_sysfs_groups[] = {
 	NULL,
 };
 
-
 static struct pci_driver amdgpu_kms_pci_driver = {
 	.name = DRIVER_NAME,
 	.id_table = pciidlist,
-- 
2.25.1

