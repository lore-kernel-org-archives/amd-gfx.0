Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD398EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 04:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4558210E1D0;
	Tue, 25 Jul 2023 04:52:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A6A10E1D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 04:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbV5Wnedam1K/efoPZJDqfS6wZ3KZ7f83sb3VUWhPWXZQqyDOdcTsYbFRlipNgPNCSaamSRBbjil1zCxqvmKCZu4BZbzsyLGVQ/cqDqlOjTHcFsb14t0fjdikJ/5cDW/n5TP6o6sjMmDxSjic7hrx3WQ0YE8U1ZcZsx544N1vHX4pIqwqEC67A3n15WJntahX1QLyZ569Oq2kfV1I4AHzgDPllTtuZQIgn52ZkctClaO2B47hJUPjSFQyZLKXPeMRBoAyUgav/fP2dhfMtlHLQ8m8z1uR8yOYAgW6Kil6KGIhyeK+T6nENWjrU7fAd5GHNbZNaK+ClRGvIcyyTLX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiNR4ezUhvraBAi07bnD2xZHEhDNIydniJyhW9sXe4A=;
 b=gzLsT2+jL0OBWZ58b/4MlDJXrsEKTQTzbBkTViQ4wjRo7NxqFuFE4MKVW2/hTENjoY2WMYp2PATUGJrkz4e7L0RvEttiv8GmpsTWNeDzfsBUHLEVJs8TLA8COW4+utgonL+vnqryyoahfiXU5e6EVsDGWWJXbQw1jrwGYZ9QmHqLhcZJMoelZP+UC0sWU+LwG3YtpUkYeZu/sDLAAftgEsVrlJ8jVP+tR2nzf6sLYgPw/SL48JLwWg9vFYkeaIdfsVB9JB/C98gkM1g/xrFfRnuxdXrVXXUc4NWjjbJ9nqAG7mGbD/3rzwUFFM5HxxJhYqDGJl01JzMsbnpSzxIjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiNR4ezUhvraBAi07bnD2xZHEhDNIydniJyhW9sXe4A=;
 b=0x7aJbva4x3Bjyzfv8ll1nQBSQPQ/U86Rta4VwuN4DsNj7a6TbxiBhfvqW3RuG8+LF/ngcD3hviz4MQ0uNzKG7rac9X/n3+nrx0lmByNDotmrdvGgKvGj8EQFN6kezc96gKrb++c6MT181zMha2vyUZIkbpuQVRVlS6Oc7D/IKc=
Received: from BY5PR20CA0001.namprd20.prod.outlook.com (2603:10b6:a03:1f4::14)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 04:52:22 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1f4:cafe::3) by BY5PR20CA0001.outlook.office365.com
 (2603:10b6:a03:1f4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Tue, 25 Jul 2023 04:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 04:52:21 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 23:52:19 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Move externs to amdgpu.h file from amdgpu_drv.c
Date: Tue, 25 Jul 2023 10:21:59 +0530
Message-ID: <20230725045159.2246417-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725044143.2246047-1-srinivasan.shanmugam@amd.com>
References: <20230725044143.2246047-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b5f80d-cdd4-4012-a081-08db8ccaee7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isNikbRC1lpAEMG/db0lYhVYw/hOGPFsgu5PjpQoNPegnWNWopBfIhUhlG/joIwEXHiXiWqFP7qIJeWzVDooWxh32dR6/BiDhLNCTFT1Yi212HMWV5lPJQgZogBgj3XrHCnCSKny7XS8c+V8AxwREHUFuDG1GDzarkkUn2xq9qDk4a8zRqr1WKEae2DIW/tKE13etS5zP9i6T419p52AKoyWH82IqFC741PQIhEe15+iuMtqBjZfoKu819rSSYb+Wc7vIcJwbimvYFIGsxpoHccYieV5UvMP8+TOH3zymab0U0Aa7NoWy8kQ80tBKJd5CERb6gdU43Hqr2p8uKYBS/AdaIXDAQzYPQwfXdcKpc3aEx/gH7lfIoR1ohSd4SNa1zXHNPA5p82J5Ui8DGGAIa1Jukeqd0IJt+iqE4di3rUtNvlAlNnroeL330xuJiP13uJrtPG2t74yW2RrVWCyFr3uSd4bNdDkLj3+TW7K54JXAWzAGJjvQgO2rGH0BrDA5NVO5kdtfBcwFSGl1nM8rbEazZ8jYrcCi7ipPpz03NPEisOYkGLyFKeemJhQILorMiXlUbuhFTFunRiBKSKUbI+tObBp3QY7UtS5QGNuejKBohV6BOrmqOA3ezWeGBou+QdjHtwWMQXSaqJINVDXEe/i89Cvw1fTzDgNJdgSZvsr7lCEbsbBQ3QgyRx6aqYdgHAa/cuk6uXQ1NLhBARexU5Ep326t7R8GviE9+HWAwF9vHb15t/Ps/H6wXV0HNXdfRFjo39J/VaFocf3L1Inqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(356005)(81166007)(40480700001)(36860700001)(426003)(47076005)(2616005)(66574015)(83380400001)(36756003)(5660300002)(44832011)(16526019)(8936002)(8676002)(478600001)(54906003)(6636002)(316002)(70586007)(70206006)(4326008)(110136005)(41300700001)(1076003)(186003)(26005)(336012)(6666004)(7696005)(2906002)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 04:52:21.4572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b5f80d-cdd4-4012-a081-08db8ccaee7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
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

Fixes the following:

WARNING: externs should be avoided in .c files
+extern const struct attribute_group amdgpu_vram_mgr_attr_group;

WARNING: externs should be avoided in .c files
+extern const struct attribute_group amdgpu_gtt_mgr_attr_group;

WARNING: externs should be avoided in .c files
+extern const struct attribute_group amdgpu_flash_attr_group;

And other style fixes:

ERROR: do not initialise globals to 0
WARNING: Block comments should align the * on each line
WARNING: void function return statements are not generally useful
WARNING: braces {} are not necessary for single statement blocks

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2: 
 - Updated commit message - Added "ERROR: do not initialise globals to
   0"

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

