Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF6BC7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016BC10E53F;
	Wed, 10 May 2023 21:24:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E3810E541
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F92WKmtl7E31iRRIlHXAjVE+htXOg7irf0ku9i7MvtaPWsQArfQfqyZCWuqFijahjt6MsZB/+diIyIH2tQkJEsnssyg98UmapKT0LbP3ZtEDy/nngwTc7HlNF6DELO/sO/HjcsR5aF8DE52r46TJQoFhmAhnFwVRC0cDkQk7DrLqJon9ynIoWethFa9RDrnOqHSPiMOOKoijfRZyfzBZckBSRwy2Oautq4MdeDNyNBkiAVWpSqkO70sDdESYfcTgC0BwH89FcGkR2Z0AxT5F/GvyheEUnZngtSsaveHfJFydbWzRvgQ/ubps0f99HYzZe1QAX8q07i4EEwPn12VcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yJs0DJm4Q4m1ZYAU348cxGihiQlKLzX/RWAvb6Ykqo=;
 b=K9GEMgerMlHo2SZJLgGcQn25vvzqJdVMTwF4sbDJtyR6zqS5BwQHk8o1FA+mW9u6IFm5XYOvwiGw+Hv/b6bW/IvVikiBCjJkrmEQTPLYzc/Io1mTii0g8iy9s80N/ONaOCeVXzCltGSPd1q6ktdjN231mP8E/w+rKqKcfi1CxTqofObiOLXinDUVw1buSu8xtqvoRltnyRE0kUYaAh4sysu2lmRc6rnthcYgaF6E7xKtcXChK/6SBbn6mrfh6VgGKUSW/O+1BS7yQjTNWDI9o/uRMXeXyF6Wbs3PwCwU+l/scUZSBXqf2g6hQ9Ur46U2rwn/2sxyvYv6Ie9SL+CiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yJs0DJm4Q4m1ZYAU348cxGihiQlKLzX/RWAvb6Ykqo=;
 b=sExm37GMouSdRhVCWii2zEfo08/WntqIC6mB2FIRINNe4saQtmO6C/sRUnCiVJ9wVBMpUsDrAxekgfcBFXIEQRE9WeXtj53TMC4lbXCrAlvb8UE66FP6UUk5dgR/vzfXT1hw6wS8z2L+F6HO8ZAlZx0aIaLToDEDDlUDg93cWvg=
Received: from MW4PR04CA0333.namprd04.prod.outlook.com (2603:10b6:303:8a::8)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Wed, 10 May 2023 21:24:04 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::76) by MW4PR04CA0333.outlook.office365.com
 (2603:10b6:303:8a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:24:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:24:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support partition
 switch
Date: Wed, 10 May 2023 17:23:32 -0400
Message-ID: <20230510212333.2071373-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: e925c880-e5d0-4efe-0471-08db519ce1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKqp7zpixgh2x75lCLs/PEg2cN7l+EwjXxD6ngHPVxCXX3HWpqTMLAcxzJi4wtEXWYrz5ATITC5VY3WQFKpU44EcqWfiykO49Az3wkGLHpe/ekts3j6HnbpOSc1Jz1X0ZFMIjpyeZ6EDTuxtswMnUhFq7bRnlFu9OzJrO+l49H8aI3BWsUxJZ1YSurlxjNR+qYoEzTZaid09trwQUYq3Xhp6X7rM0Dhff+pX5QQ9XWTv/B6ebXxIAmxRdAXhfEGFy3uzwau9uPffyV18UwSg3scn/n92VrNFueot3LuNI9+JWd6Wd74stYdyUffHtbReEiCN2KaHTUrfR8e8nDfa4tNY5KctluSHA1MvMiQtMIWGcmrr8fWWxRkER5yweE0BFEbbVa2KtW4PrPBO8kJaFSB0myLMw+AxD1RWBARL6I4iYsklpEkaZKzJK3m7ezKzIWa/RYw6cRSVpyQbjC4MTKzsYtlQiu6aQ8QRLWSaoToWqqPukE4qdPosRi6KSoidh/Dqx70rJCgeiKvBKg7Q+IHDoCOi2eKb0kuTkX1/Him8JKW8zKQuu3tLJWjH+ivtl66cYwLJ1VH9efmTFbAqTqegl0L+oEWQKIQTnjHuWd61k1Jx1OZuU74gzY1EzVday6nwaD6dDs/aAJ2CmURGbHWISZ6lZbpXapc/81XSO5HHqWpjMealj916HMd6CqFoyZx1s4ZOkDiqzCNmkPrlIA8kXnLskZ4CtFKojapcqSA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(36756003)(36860700001)(478600001)(7696005)(426003)(2616005)(336012)(40480700001)(47076005)(40460700003)(83380400001)(4326008)(82740400003)(356005)(41300700001)(81166007)(82310400005)(1076003)(54906003)(70206006)(70586007)(26005)(86362001)(6916009)(5660300002)(6666004)(316002)(8676002)(8936002)(16526019)(186003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:24:04.6789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e925c880-e5d0-4efe-0471-08db519ce1d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
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
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

Rename smv_migrate_init to a better name kgd2kfd_init_zone_device
because it setup zone devive pgmap for page migration and keep it in
kfd_migrate.c to access static functions svm_migrate_pgmap_ops. Call it
only once in amdgpu_device_ip_init after adev ip blocks are initialized,
but before amdgpu_amdkfd_device_init initialize kfd nodes which enable
SVM support based on pgmap.

svm_range_set_max_pages is called by kgd2kfd_device_init everytime after
switching compute partition mode.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c   |  8 +++-----
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h   |  9 ---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h       |  4 ++++
 6 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 948d362adabb..48d12dbff968 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -372,6 +372,17 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 {
 }
 #endif
+
+#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+int kgd2kfd_init_zone_device(struct amdgpu_device *adev);
+#else
+static inline
+int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
+{
+	return 0;
+}
+#endif
+
 /* KGD2KFD callbacks */
 int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger);
 int kgd2kfd_resume_mm(struct mm_struct *mm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 321b689db601..9c1a8ace6c31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2632,8 +2632,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		goto init_failed;
 
 	/* Don't init kfd if whole hive need to be reset during init */
-	if (!adev->gmc.xgmi.pending_reset)
+	if (!adev->gmc.xgmi.pending_reset) {
+		kgd2kfd_init_zone_device(adev);
 		amdgpu_amdkfd_device_init(adev);
+	}
 
 	amdgpu_fru_get_product_info(adev);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 882ff86bba08..bf32e547182c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -32,6 +32,7 @@
 #include "kfd_iommu.h"
 #include "amdgpu_amdkfd.h"
 #include "kfd_smi_events.h"
+#include "kfd_svm.h"
 #include "kfd_migrate.h"
 #include "amdgpu.h"
 #include "amdgpu_xcp.h"
@@ -791,7 +792,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		kfd->nodes[i] = node;
 	}
 
-	svm_migrate_init(kfd->adev);
+	svm_range_set_max_pages(kfd->adev);
 
 	if (kfd_resume_iommu(kfd))
 		goto kfd_resume_iommu_error;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 2512bf681112..35cf6558cf1b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -988,7 +988,7 @@ static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
 /* Each VRAM page uses sizeof(struct page) on system memory */
 #define SVM_HMM_PAGE_STRUCT_SIZE(size) ((size)/PAGE_SIZE * sizeof(struct page))
 
-int svm_migrate_init(struct amdgpu_device *adev)
+int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 {
 	struct amdgpu_kfd_dev *kfddev = &adev->kfd;
 	struct dev_pagemap *pgmap;
@@ -996,12 +996,10 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	unsigned long size;
 	void *r;
 
-	/* Page migration works on Vega10 or newer */
-	if (!KFD_IS_SOC15(kfddev->dev))
+	/* Page migration works on gfx9 or newer */
+	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1))
 		return -EINVAL;
 
-	svm_range_set_max_pages(adev);
-
 	if (adev->gmc.is_app_apu)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
index a5d7e6d22264..487f26368164 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
@@ -47,15 +47,6 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
 
-int svm_migrate_init(struct amdgpu_device *adev);
-
-#else
-
-static inline int svm_migrate_init(struct amdgpu_device *adev)
-{
-	return 0;
-}
-
 #endif /* IS_ENABLED(CONFIG_HSA_AMD_SVM) */
 
 #endif /* KFD_MIGRATE_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 021def496f5a..762679835e31 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -265,6 +265,10 @@ static inline int kfd_criu_resume_svm(struct kfd_process *p)
 	return 0;
 }
 
+static inline void svm_range_set_max_pages(struct amdgpu_device *adev)
+{
+}
+
 #define KFD_IS_SVM_API_SUPPORTED(dev) false
 
 #endif /* IS_ENABLED(CONFIG_HSA_AMD_SVM) */
-- 
2.40.1

