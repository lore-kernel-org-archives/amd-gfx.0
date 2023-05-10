Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE84FC7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E3A10E52E;
	Wed, 10 May 2023 21:23:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CEC10E52C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEcKoU/+ButkVhrX9zNEqwgl9qbumwxbsk8gFnIFTigiAuu0g6qZiHdxntrP6GtXe5npkBGhDxjAN7uKvBU5Vf3XkF7qnsjQkTWgi0anTKriVSeVsUBk6siGsrSKDTiDuFTLwkEP/2BqAl+qxbaAxZzpI+9o/8U/SbuPtYx5JvV7FcEtBGb+7QZdVsHnGO5ZdLsk2S9WWpHNv6M3iHEc8BqOKF3dBAOSabCE1mewtzfvQ7IGl6jA13HA/tS/mM7X/riaXNt+D/74MkWMC2hKKGbvKpABi3tA8pwk9obmKWA1PYEJcKEXA2BOkECCHkcKeDuOzcSw34qGl2OQZDBsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvb9TQjN2SEJsF1b8+H+rWEmu8MrB3eaAprHQgIimGI=;
 b=dPHwoZ0olN2Mi8JtmLY1E2RkFFMsEzJ59uvQuis+ea/h7bshJnhMlnyPAm5ldGlLKl7ZKfusoZnvPy58T4iC25SCxGNaG2z8S4v9Dbe+/bByg+WJtKFFSwyHJdVF5ZoK3RL505ZGmhRwbvNil1klVoa4WbkQgRPkX6Yl7/mqoRjYfWeQr/wqH8Wf4yeq+adxVDQ9ZhktyQe+2zu6XYMH6q5ngAUVlWoQkeBwgQpeDyVreDB9F1nisZQdNiBbUA5OjvRV3ToRcYuvUqX3ZL3KDOUbH0pU/dha1qtvactecAyZdGo62bFhyV8jS0RZRjm60ezivVQmZDxjoLPK4QN2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvb9TQjN2SEJsF1b8+H+rWEmu8MrB3eaAprHQgIimGI=;
 b=IzqeALJfSfLDsj439pyC40aWuPbhFJ7ygYdVY0n85HZ4d7uRneaePaPjjCWZJauPUu4sY6JbDFKlTwY+LsHZKAui0LfXAZ73XJDgviUkfz4JsuSo1VqcgWsfQS1FSpGHYNPUY1rJjjRmMZNSKTDzHnGyzGRV/60nvZ5BijLO5UY=
Received: from MW4PR03CA0076.namprd03.prod.outlook.com (2603:10b6:303:b6::21)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 21:23:49 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::8f) by MW4PR03CA0076.outlook.office365.com
 (2603:10b6:303:b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 21:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/29] drm/amdgpu: support partition drm devices
Date: Wed, 10 May 2023 17:23:05 -0400
Message-ID: <20230510212333.2071373-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e034a2-51d7-46dd-9bb4-08db519cd83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tec9zQ/2llizWCRTcB5hNSf3A53FjLPXeKtsFLneiEiEy1SyCLO8hmcko0F+cDgDXloPoTC/JadNpihTPUpQ63hrkWmS2HHg374KbFWgGRJHloeO+KOy8b/z6tm2UG8Ua66GXKyC1xdzVTUS94VH62t0uwMOgcngltwDVD+aQVkRaHm/hGH4epjcJAfbSCBj9S4Xe+OcQ6uq7J3Ybn7IreWODw+lWxT9xLnhPWE1G18/keB7WIj8f+YxKkntE3rEjQUr72EHCP1VOkCe3S2HsrsPhL0kkI37bJC0xbMPh8oWq+LIHdmo9aqH6L/dZIdvtH5HBT7UgvI6UVjfwBV0Bx6+EIMKGW9WdRU0q7mV4mviFOkDH3Ly95QyA6Dlx02NvlvRfpsINOcthX1rDmhn3XjqbSx/zCpDx/WFA8MNmo0mumM1WFsvGFU26IdmflvObb7yl4SeP0q1dSLu+44W5KCamVgPXd0koJXr8afllQkE0XFUUBxkSgUL3++XpFB8/fUNdcx6xslu5j34noo2zh0k3FGWJhaF+qOr+NTrDdj4I+pVhg/Tg82Ad0GxQJyKxCIB36ujKlRKf7Qx2Y+Rtd/PAYe7sOgkkQF8c4Oe4dMKlk43TdgO9V4XoQYBdYU9R29LYs20v5nVh4iKDdsBc/15y2va1Y3c1NOG04KPxZ1nVpgsr1GKthoSxFHZCMvMLwDzEph9pQMhAQjGhiHZ1x+jBtXeNKBGzR137ZrZjNUp8+vfJCRnj4V9ulZObckzmooRfbCuhvytlElV+xsOTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2616005)(47076005)(66574015)(426003)(36860700001)(336012)(83380400001)(40460700003)(40480700001)(186003)(16526019)(82740400003)(6916009)(70586007)(81166007)(41300700001)(70206006)(5660300002)(8676002)(8936002)(356005)(316002)(4326008)(2906002)(1076003)(26005)(36756003)(478600001)(54906003)(86362001)(82310400005)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:48.6158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e034a2-51d7-46dd-9bb4-08db519cd83d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 James Zhu <James.Zhu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Support partition drm devices on GC_HWIP IP_VERSION(9, 4, 3).

This is a temporary solution and will be superceded.

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-and-tested-by: Philip Yang<Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 32 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 59 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  5 ++
 6 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bed6d1d09ac2..45c6522ee854 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -108,6 +108,7 @@
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_xcp.h"
 
 #define MAX_GPU_INSTANCE		64
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c2136accd523..40c5845c78df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6062,6 +6062,7 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
 	struct pci_dev *pdev = adev->pdev;
 	struct drm_device *ddev = adev_to_drm(adev);
 
+	amdgpu_xcp_dev_unplug(adev);
 	drm_dev_unplug(ddev);
 
 	amdgpu_irq_disable_all(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 562e65ab48fa..4589cb2255a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2194,6 +2194,10 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		goto err_pci;
 	}
 
+	ret = amdgpu_xcp_dev_register(adev, ent);
+	if (ret)
+		goto err_pci;
+
 	/*
 	 * 1. don't init fbdev on hw without DCE
 	 * 2. don't init fbdev if there are no connectors
@@ -2266,6 +2270,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	amdgpu_xcp_dev_unplug(adev);
 	drm_dev_unplug(dev);
 
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
@@ -2849,6 +2854,33 @@ static const struct drm_driver amdgpu_kms_driver = {
 	.patchlevel = KMS_DRIVER_PATCHLEVEL,
 };
 
+const struct drm_driver amdgpu_partition_driver = {
+	.driver_features =
+	    DRIVER_GEM | DRIVER_RENDER | DRIVER_SYNCOBJ |
+	    DRIVER_SYNCOBJ_TIMELINE,
+	.open = amdgpu_driver_open_kms,
+	.postclose = amdgpu_driver_postclose_kms,
+	.lastclose = amdgpu_driver_lastclose_kms,
+	.ioctls = amdgpu_ioctls_kms,
+	.num_ioctls = ARRAY_SIZE(amdgpu_ioctls_kms),
+	.dumb_create = amdgpu_mode_dumb_create,
+	.dumb_map_offset = amdgpu_mode_dumb_mmap,
+	.fops = &amdgpu_driver_kms_fops,
+	.release = &amdgpu_driver_release_kms,
+
+	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
+	.gem_prime_import = amdgpu_gem_prime_import,
+	.gem_prime_mmap = drm_gem_prime_mmap,
+
+	.name = DRIVER_NAME,
+	.desc = DRIVER_DESC,
+	.date = DRIVER_DATE,
+	.major = KMS_DRIVER_MAJOR,
+	.minor = KMS_DRIVER_MINOR,
+	.patchlevel = KMS_DRIVER_PATCHLEVEL,
+};
+
 static struct pci_error_handlers amdgpu_pci_err_handler = {
 	.error_detected	= amdgpu_pci_error_detected,
 	.mmio_enabled	= amdgpu_pci_mmio_enabled,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
index 8178323e4bef..5bc2cb661af7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
@@ -42,6 +42,8 @@
 #define DRIVER_DESC		"AMD GPU"
 #define DRIVER_DATE		"20150101"
 
+extern const struct drm_driver amdgpu_partition_driver;
+
 long amdgpu_drm_ioctl(struct file *filp,
 		      unsigned int cmd, unsigned long arg);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index bca226cc4e0b..8b28b18e4291 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -22,6 +22,9 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_xcp.h"
+#include "amdgpu_drv.h"
+
+#include <drm/drm_drv.h>
 
 static int __amdgpu_xcp_run(struct amdgpu_xcp_mgr *xcp_mgr,
 			    struct amdgpu_xcp_ip *xcp_ip, int xcp_state)
@@ -217,6 +220,31 @@ int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 	return mode;
 }
 
+static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
+{
+	struct drm_device *p_ddev;
+	struct pci_dev *pdev;
+	struct drm_device *ddev;
+	int i;
+
+	pdev = adev->pdev;
+	ddev = adev_to_drm(adev);
+
+	for (i = 0; i < MAX_XCP; i++) {
+		p_ddev = drm_dev_alloc(&amdgpu_partition_driver,
+			&pci_upstream_bridge(pdev)->dev);
+		if (IS_ERR(p_ddev))
+			return PTR_ERR(p_ddev);
+
+		/* Redirect all IOCTLs to the primary device */
+		p_ddev->render->dev = ddev;
+		p_ddev->vma_offset_manager = ddev->vma_offset_manager;
+		adev->xcp_mgr->xcp[i].ddev = p_ddev;
+	}
+
+	return 0;
+}
+
 int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
 			int init_num_xcps,
 			struct amdgpu_xcp_mgr_funcs *xcp_funcs)
@@ -242,7 +270,7 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
 
 	adev->xcp_mgr = xcp_mgr;
 
-	return 0;
+	return amdgpu_xcp_dev_alloc(adev);
 }
 
 int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
@@ -278,3 +306,32 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
 
 	return 0;
 }
+
+int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
+			const struct pci_device_id *ent)
+{
+	int i, ret;
+
+	if (!adev->xcp_mgr)
+		return 0;
+
+	for (i = 0; i < MAX_XCP; i++) {
+		ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, ent->driver_data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
+{
+	int i;
+
+	if (!adev->xcp_mgr)
+		return;
+
+	for (i = 0; i < MAX_XCP; i++)
+		drm_dev_unplug(adev->xcp_mgr->xcp[i].ddev);
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index e1319b887bf3..dad0b98d1ae7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -70,6 +70,7 @@ struct amdgpu_xcp {
 	uint8_t id;
 	uint8_t mem_id;
 	bool valid;
+	struct drm_device *ddev;
 };
 
 struct amdgpu_xcp_mgr {
@@ -115,6 +116,10 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
 				enum AMDGPU_XCP_IP_BLOCK ip,
 				uint32_t *inst_mask);
 
+int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
+				const struct pci_device_id *ent);
+void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev);
+
 static inline int amdgpu_xcp_get_num_xcp(struct amdgpu_xcp_mgr *xcp_mgr)
 {
 	if (!xcp_mgr)
-- 
2.40.1

