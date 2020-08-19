Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA617C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 11:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FE0207BB
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 11:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IALuOdMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FE0207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03EAA6E223;
	Wed, 19 Aug 2020 11:07:14 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam04on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4d::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247D56E223
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 11:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwDY/Z8ktRBXLVSfGApL+M9R+Lk9F44OwkV8bIFURa4lbpzuvnNAKv2L1qsCFKUVvu+6UihQD3bNte7cX/r72Uo74JGoP8nlxIRkj124wj9t1SVz5EMxO6mzlQCOTo0sKjWXG1I0BRcAB61TCDKDKoKdMI1EbYBfqgXjOZMiEIkuW6nohb42CNsacWcZW3uKDsWOekVU1orWg2nvCx2Q2IP3S530ZumH/wJ5uK8SUBAd9oq6p0w6kjt4yY/xtdDbADeTpu4JVotvq2u7MoJOhGCbb856PK04KyY3wHGtQQKahT7p1phXumJdGFdvK0rAvk7O3C6pnaynKarLK+r9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwCJxwP4Uy/vtPPTbrBZ0bmGU5OOSgOqDUAN3dCiXHU=;
 b=G3rWAfW/jEyzd0jKAb40CUsFHPlJ4Q8byQpu1FDB/QKdLiGS+PovTr6dxY7hMkTMx6D1IM5zT78aSQtaR4bftaFeRZ0jA8lU54CIit7tcSo6P5pLuhaOi264H01BSWPWikuJDXbyCW8mHZdLAFivjFZMHbkaacBm3977khUGGmyM1I/vcQPT1V18mzCWtnBncRcjcCmIFofA8Zq3ac/jioYQDYI+Hfsm1XGqrdAwIX/Rd3laO/DH3595iXbClD//f3fhItmCzS0chq+j1zbZ2mW9atcXNeqkedEhmpPkaWMotHZqjigE09UXS0FIL6mq9mAjtXIrERJhHIi4qHpZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwCJxwP4Uy/vtPPTbrBZ0bmGU5OOSgOqDUAN3dCiXHU=;
 b=IALuOdMO7tbX5ZAUL+viJ75XimTerg46/BESlrUXFFp3xg7mvyyMcfk7w8/WiI4P1smCsq5GiJT6gnc7eSOC7Ve/pF1JfAVrBvdxVMhwYJlYew9m7NllbrcTsM4eqfsTQQjDFtVZH1l177F3Igc8eD9cTZYeojhmbhUGxNmvv40=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 11:07:09 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 11:07:09 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 2/3] drm/amdkfd: force raven as "dgpu" path (v3)
Date: Wed, 19 Aug 2020 19:06:47 +0800
Message-Id: <20200819110647.212404-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819110647.212404-1-ray.huang@amd.com>
References: <20200819110647.212404-1-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR04CA0047.apcprd04.prod.outlook.com (2603:1096:202:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Wed, 19 Aug 2020 11:07:07 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e30219a2-a524-4aa7-5c93-08d8443003f2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41265B43143AB2B4A3FD1338EC5D0@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHRgw1xnc4qTxRIU7nWxw8A6EB4dvWCOKMdSyftKMR7WcLAJCoEHtld5lEG9oxXJSLUzGPUfPzORlH3Tg60Rq+6848kC1a9w+c4dehe1sLctrPQRi+PpVCKkQ6fUoygwWAoehIlbEd5eqzsvBZ4E6hrYd+SN8NcGS1AQBUVZZwTSZsZc4DlKzNF3SI1iWCWDHLDP8uU7kCF9+i4m4o1rmN9+TE7oItQxseBkldpBzg3UQv5fqiovS2n+f1bPetOtJCfZ08gfJlW4WIhtoB4v+fqepQ16oN1NT9usOAG4LVan1CKe+FNCkCwwyC7YL8WV1oEbYY5Ln78g92+H1hlkrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(16526019)(6916009)(186003)(83380400001)(2616005)(52116002)(7696005)(956004)(36756003)(4326008)(6486002)(54906003)(26005)(86362001)(6666004)(5660300002)(316002)(66476007)(2906002)(478600001)(8936002)(66556008)(8676002)(1076003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gHi4QSlHnNZfBAZHwQ9dZ0hDmeDmsKm/FCA+CTz7RKiQDjTVINga2JtLsgCl3AOWAF9kmVdB9/+YdFeNLP+Vpdyf5qKpN15wV2hca6uAKkTC+cRn3gqtG0gQeaHqCqaicq2s5avhXRtXkWN4yZJBRYYZyWQEsRcKe6HX6QvSX6OGIAQVFrv82nenATOOG38AzQ1kLU4o+ac6e345MAd/eTnpsz7F7qGuKhOWOF8dl7KTvz+qcBX+9C5WXcBWvQ5sltTsTnXuOuMKRTGDLxZXoEjT4zucbF0L9coLnbu3MNvdWOJ6Gj21VEzh+JEk3CT2URMxN6c5nxJ0crTfOPk8VqyiqtT815sXnO0c02p7zolv9axC7bGQNmJ44bsC+yy1/RWXqbyNM4jHUlQfeVWp/AUieDEomcuhtWy9rDtV6P/IGZM9su8/joS5tuP1EL4Lw7X83UZAUQmo5VIoiVxAr1+W9nPUF7uZBhQk+XDTYeahjoGY/GWq4Z0LTeV2eakOkcZPNe0MTEkSvqkjRW0dEVke5PhUy2w3jHkLeYdRBfFYtvxnnMcS40gCTXmOAd+aKdqNuMe3Phwh/JANj2Ph9DbValHY3FwJ3nHSEleg1dQXN/5mrgKHkdZJyeY50DRlTwbjawzD+Od4Qrsu3ycbLw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30219a2-a524-4aa7-5c93-08d8443003f2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 11:07:09.1317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 220ZOf7meQhLDF6ieA53sM1AdFzrch0yrjh1tnhw24a1qHBU5hLyX3prBjmgqpraGDFMTWtQuJc++7OAJBy5Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  5 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 28 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  1 +
 5 files changed, 34 insertions(+), 4 deletions(-)

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
index 59557e3e206a..f8346d4402e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -22,6 +22,7 @@
 
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <asm/processor.h>
 #include "kfd_crat.h"
 #include "kfd_priv.h"
 #include "kfd_topology.h"
@@ -740,6 +741,30 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 	return 0;
 }
 
+
+#ifdef CONFIG_ACPI
+static void kfd_setup_ignore_crat_option(void)
+{
+
+	if (ignore_crat)
+		return;
+
+#ifndef KFD_SUPPORT_IOMMU_V2
+	ignore_crat = 1;
+#else
+	ignore_crat = 0;
+#endif
+
+	/* Renoir use the fallback path to align with existed thunk */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	    boot_cpu_data.x86 == 0x17 &&
+	    boot_cpu_data.x86_model >= 0x60 && boot_cpu_data.x86_model < 0x70) {
+		ignore_crat = 1;
+	}
+
+	return;
+}
+
 /*
  * kfd_create_crat_image_acpi - Allocates memory for CRAT image and
  * copies CRAT from ACPI (if available).
@@ -751,7 +776,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
  *
  *	Return 0 if successful else return error code
  */
-#ifdef CONFIG_ACPI
 int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 {
 	struct acpi_table_header *crat_table;
@@ -775,6 +799,8 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 		return -EINVAL;
 	}
 
+	kfd_setup_ignore_crat_option();
+
 	if (ignore_crat) {
 		pr_info("CRAT table disabled by module option\n");
 		return -ENODATA;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 2c030c2b5b8d..dab44951c4d8 100644
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 82f955750e75..4b6e7ef7a71c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1234,7 +1234,7 @@ static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
 
 static inline bool kfd_device_use_iommu_v2(const struct kfd_dev *dev)
 {
-	return dev && dev->device_info->needs_iommu_device;
+	return !ignore_crat && dev && dev->device_info->needs_iommu_device;
 }
 
 /* Debugfs */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4b29815e9205..b92ce75a4c53 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1090,6 +1090,7 @@ int kfd_topology_init(void)
 						    COMPUTE_UNIT_CPU, NULL,
 						    proximity_domain);
 		cpu_only_node = 1;
+		ignore_crat = 1;
 		if (ret) {
 			pr_err("Error creating VCRAT table for CPU\n");
 			return ret;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
