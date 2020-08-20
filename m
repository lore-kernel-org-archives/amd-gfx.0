Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AC4C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 08:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685B9206B5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 08:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gV9dFwVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685B9206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25906E91F;
	Thu, 20 Aug 2020 08:40:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F676E91E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 08:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9mOt4/UkcOIrtaJE7bfRmuvxoPE27qQcW2JSXXbcMamT+P9TXtXMAV7sqZNvQlzp+F/aq2IiXfhaqGrERAUiaNPUDF+pVJgVakHQp+xrCGfZuMNJ3pWdQXQs6kkWQLwexIXVgn8UIT5GgD5TKn1vNLE4nCuX71qcprRsmWn/aYbQf4vaP2eYHvFwxhi3S+S6Ftqxsgbf0asmbznpKKWFZ4t2St0logIhhk2dv6TxPjPHbPa2kWmPdQ5T5tF4zefsoqBroZeNs+cbm17DRl+Ae6ycXc3TwRLIu3xyTCmza6gARTj2e1A7+3ALQYEvnuIpndJ8pPWKNhIhajPFf0F8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa495EKoIXEB0szip2liPS+NkRJzptO4ganxknSXy7A=;
 b=I0wM8iHudgo87+Mpk+wwAdFuDADOCSk/Ma1lsrvviq62eu49itjhGSwStOI3JdBojgR78Jq0Hrnz/XT3NOUhC5oYxZMDRjIh60NC3GajRQ1QBaPSEcHFj3gIFRQIli8lMjCu0/1w4MYV4FBnYm+DHKYUOKdPX+jeMbEmP7z9izM6WU6kqNNNRinQA21TgjTsxZ/42kwdL5RFrOe+VFwcf9I4U9/OrumLrKGK2DHlcNhYnX8Ty1YePco+HuWhINC9gwjNBZFT5f7L9CmtHQQjPpEMq3c2t57WyQKH3gw4iUfJwcTsn0TEF1RcekVISQaTtg/dsK6R0P6OQR/ELjKcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa495EKoIXEB0szip2liPS+NkRJzptO4ganxknSXy7A=;
 b=gV9dFwVIKOeqNKWCUIhTUvwjHQ6BTfnLQcegRPKDhu6TBjx3hJzjz0dl62hJHCxt9lSRaBf1AEj7ycoudsahvnAWAqJ1qJitJHzApshB113pQ39HTMYCTw2hAP2PVUVebN5riyXbrtrgqvLx2HIUmFSTun7EofypPeCGiksqKjM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 20 Aug
 2020 08:40:33 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 08:40:33 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 2/2] drm/amdkfd: force raven as "dgpu" path (v4)
Date: Thu, 20 Aug 2020 16:40:08 +0800
Message-Id: <20200820084008.293114-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820084008.293114-1-ray.huang@amd.com>
References: <20200820084008.293114-1-ray.huang@amd.com>
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK0PR01CA0070.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 08:40:31 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62eae9ed-0d1c-4762-e131-08d844e4b3c9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4552144C8622E4DEEF6E021DEC5A0@MN2PR12MB4552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pOg5S1xBaeQHKh64ei46/zDxqdtKxnHGxS5CZiuN0qiYvANCeYVxmNtnmGSMVJO38jr26E5MfiDH26Vlu7Q2xLCzWBcr0FQjDu71Vhpai/dLhgTMR6/WBp9LXicFtJCzQ1E/P+t5mscErVpIi4N51ekXIohSkll+JRSXHvmkhK4T2Yg1HF2otV0SI6gorOWHQIYN980s5y+leGD9yrufixUpIgjckag/FCHKt5+Xpk4vxFKPrw7kouBmXHFPH0uG4yeXTNbYAuItRQthX22k1n2A+fnCzA26A8/1vFE8uMtQ7zp83uOMJngfKmSfgPf25VDNV3pagT2OBuxpTdXcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(5660300002)(6486002)(4326008)(36756003)(1076003)(6666004)(6916009)(956004)(2616005)(316002)(2906002)(86362001)(478600001)(66476007)(8936002)(7696005)(83380400001)(16526019)(52116002)(66556008)(54906003)(186003)(26005)(8676002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hT5AfqsZ6B+JlCFftWLLRmipK5o1zEPMVUTlkV8LnlWlq1k8yhy1y2uVn66rYSwCr6FivRj17umJwBmfyNTO/58qv2CkFf+LUQiM+1rx9Hjmru1U52o8+yPstnoyBh2fmIk+wVMvERO8ydONdCs8zxXliTfj0oCv5xPlFKjDIM3cRv4jaAUFz1dFpDQr1ienor7qnNXZPEhJ7YdnjYeitTdloJm6YCXqeQwyjT5oTbptiCsqyX53nlAmC0gkyxtcN6L4owk2MaCiYRv7aXRmfGa+LRFvtex3DnksUQHIlrXQKY93f7GPZmMRw5eUlV4pMlLcu9dpO4SEVGuGulZlkjIqY1Rc4Cm74/YrIiKNITZkg3PR/hxN9zzYvOmMSGw2ylkkpyWANXyiLiuj5Ba5qaVzuYH66nyhfQ+9v/sSva3gYgMlR753DUBo3j8pGsiEF3xZA0uIJI/GPiohaWuBiVn/1nsjU2vsjXkERebA5uoolBIvZc6hWc0KGt7TZJJJ040wmDLcasUvEAtHu7UF6w2BsY0xszGYPDDnocG6jUhqydq4A+ssc6JW65UUt/vxmUr5Tphm3NkzArUca62fd2RcQTuSocSLe+K9+td7T5bI79iBylHdpGnjOSpDYmAkwUXLxqexxeJPuI70L+8LYw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62eae9ed-0d1c-4762-e131-08d844e4b3c9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 08:40:33.5787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+3PJ7rngHt2KWGVfl4IgpPJoL56iXo95DLIEQJI5fL1U79fPRTK4QGX79gDtSeqsSf6DAgS8GmDh1r5BJWcdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We still have a few iommu issues which need to address, so force raven
as "dgpu" path for the moment.

This is to add the fallback path to bypass IOMMU if IOMMU v2 is disabled
or ACPI CRAT table not correct.

v2: Use ignore_crat parameter to decide whether it will go with IOMMUv2.
v3: Align with existed thunk, don't change the way of raven, only renoir
    will use "dgpu" path by default.
v4: don't update global ignore_crat in the driver, and revise fallback
    function if CRAT is broken.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 23 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   |  5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 10 ++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 20 ++++++++++++++++++++
 5 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a9a4319c24ae..189f9d7e190d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -684,11 +684,14 @@ MODULE_PARM_DESC(debug_largebar,
  * Ignore CRAT table during KFD initialization. By default, KFD uses the ACPI CRAT
  * table to get information about AMD APUs. This option can serve as a workaround on
  * systems with a broken CRAT table.
+ *
+ * Default is auto (according to asic type, iommu_v2, and crat table, to decide
+ * whehter use CRAT)
  */
 int ignore_crat;
 module_param(ignore_crat, int, 0444);
 MODULE_PARM_DESC(ignore_crat,
-	"Ignore CRAT table during KFD initialization (0 = use CRAT (default), 1 = ignore CRAT)");
+	"Ignore CRAT table during KFD initialization (0 = auto (default), 1 = ignore CRAT)");
 
 /**
  * DOC: halt_if_hws_hang (int)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 59557e3e206a..a17cfc290072 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -22,6 +22,7 @@
 
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <asm/processor.h>
 #include "kfd_crat.h"
 #include "kfd_priv.h"
 #include "kfd_topology.h"
@@ -740,6 +741,25 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 	return 0;
 }
 
+
+#ifdef CONFIG_ACPI
+
+bool kfd_ignore_crat(void)
+{
+	bool ret;
+
+	if (ignore_crat)
+		return true;
+
+#ifndef KFD_SUPPORT_IOMMU_V2
+	ret = true;
+#else
+	ret = false;
+#endif
+
+	return ret;
+}
+
 /*
  * kfd_create_crat_image_acpi - Allocates memory for CRAT image and
  * copies CRAT from ACPI (if available).
@@ -751,7 +771,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
  *
  *	Return 0 if successful else return error code
  */
-#ifdef CONFIG_ACPI
 int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 {
 	struct acpi_table_header *crat_table;
@@ -775,7 +794,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 		return -EINVAL;
 	}
 
-	if (ignore_crat) {
+	if (kfd_ignore_crat()) {
 		pr_info("CRAT table disabled by module option\n");
 		return -ENODATA;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 2c030c2b5b8d..fdf64d361be3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -112,6 +112,7 @@ static const struct kfd_device_info carrizo_device_info = {
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
+#endif
 
 static const struct kfd_device_info raven_device_info = {
 	.asic_family = CHIP_RAVEN,
@@ -130,7 +131,6 @@ static const struct kfd_device_info raven_device_info = {
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
-#endif
 
 static const struct kfd_device_info hawaii_device_info = {
 	.asic_family = CHIP_HAWAII,
@@ -688,6 +688,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		goto gws_error;
 	}
 
+	/* If CRAT is broken, won't set iommu enabled */
+	kfd_double_confirm_iommu_support(kfd);
+
 	if (kfd_iommu_device_init(kfd)) {
 		dev_err(kfd_device, "Error initializing iommuv2\n");
 		goto device_iommu_error;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 82f955750e75..5b70fbe429f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -308,12 +308,14 @@ struct kfd_dev {
 
 	/* xGMI */
 	uint64_t hive_id;
-    
 	/* UUID */
 	uint64_t unique_id;
 
 	bool pci_atomic_requested;
 
+	/* Use IOMMU v2 flag */
+	bool use_iommu_v2;
+
 	/* SRAM ECC flag */
 	atomic_t sram_ecc_flag;
 
@@ -1009,6 +1011,7 @@ struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev);
 struct kfd_dev *kfd_device_by_kgd(const struct kgd_dev *kgd);
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_dev **kdev);
 int kfd_numa_node_to_apic_id(int numa_node_id);
+void kfd_double_confirm_iommu_support(struct kfd_dev *gpu);
 
 /* Interrupts */
 int kfd_interrupt_init(struct kfd_dev *dev);
@@ -1232,9 +1235,12 @@ static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
 #endif
 }
 
+bool kfd_ignore_crat(void);
+
 static inline bool kfd_device_use_iommu_v2(const struct kfd_dev *dev)
 {
-	return dev && dev->device_info->needs_iommu_device;
+	return !kfd_ignore_crat() && dev && dev->use_iommu_v2 &&
+		dev->device_info->needs_iommu_device;
 }
 
 /* Debugfs */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4b29815e9205..8907b5317103 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1579,6 +1579,26 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
 	return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
 }
 
+void kfd_double_confirm_iommu_support(struct kfd_dev *gpu)
+{
+	struct kfd_topology_device *dev;
+
+	unsigned temp = 0;
+
+	down_read(&topology_lock);
+
+	/* The cpu_cores_count and simd_count aren't zero at the same time in
+	 * APU node.
+	 */
+	list_for_each_entry(dev, &topology_device_list, list)
+		temp |= dev->node_props.cpu_cores_count *
+			dev->node_props.simd_count;
+
+	up_read(&topology_lock);
+
+	gpu->use_iommu_v2 = temp ? true : false;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 int kfd_debugfs_hqds_by_device(struct seq_file *m, void *data)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
