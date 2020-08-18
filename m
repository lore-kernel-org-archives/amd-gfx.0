Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CE2C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 13:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B5D207DE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 13:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HmnuJMDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B5D207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D766189DA2;
	Tue, 18 Aug 2020 13:10:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77E789CA2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 13:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQmog68kPQ7EkjhAcLT//4BcRsrNrIvyE40IHYcqdl0ItWFlYJ6qOoZV9W8//cQuFSyfdkY7SkJ/ojv8d+VHGFMb12dPr3FICBKHWyNTZNRWnZiZbJwxwrkMkCxlxnZt57Qn6pHwkbJ3qoEuKMXa9udmFYcmaBUimWJVrCTBSHvctWfMhEL5KYgDmiko0boG0DYViXedvkWxXl57bcGaUDChW9OBsutDKbRguyXEbAETgK5/75NqRWge7muV1yeIeDTKzqMGCq5E27flmv2k4tFKuUt9IYp/S0dJ1LlOxeGKKNRAqdJKh386tWP+KaQMM/BQKp3voVa62RbaMGxGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdTOfGe7AuO9OTnUukOAkOrPczJEJ8+MDffaAx/sxJQ=;
 b=L5AYNOl9T+CmLzBwzbwtRMTyBfnNtGVHygYEsG66c5P3ktXpTVywVNZ39BtWwZWxQD0MqMdnL5zMwnT6lssXM1nxNEhFmxj42LE7QFXA0oheXH7GXorsgZK9V1gq4xW02onDG5JGjj9gBTdwUMsDBvVb62VrKyM6T+vk5W/D9413+P8TICoaHgzGlugrU0PClaJA0hEAJPT2qPgjdNhg8kr7HLvavLQGYz9YHTJem4dWg6mUph8Gdbh8OJraWjPjXbwZbobua7dez52wlZFM0n3bDsYpNBo/nNH/dFqhxLxfDQKQwv3HD3I3/zwrXi7AZCB6e3Hd6A4YXVssy4yVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdTOfGe7AuO9OTnUukOAkOrPczJEJ8+MDffaAx/sxJQ=;
 b=HmnuJMDYH/+gjP8qFR0G5nyeMOP5CZAjaXbINVOsUYFZWBBZGnbJtWqlXcAyH0mlfGmP+Q1yblYRx2qVi8nbxzQcyQEw8xIQtqy3/niypk4txOwMrR2THBtQAzuh/ocQoT8OTKolYw2zevhCOUCz0ELNlHX9JOS6Q5fiDQNBMW0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Tue, 18 Aug
 2020 13:10:00 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 13:10:00 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/3] drm/amdkfd: force raven as "dgpu" path (v2)
Date: Tue, 18 Aug 2020 21:09:30 +0800
Message-Id: <20200818130932.180114-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR02CA0141.apcprd02.prod.outlook.com (2603:1096:202:16::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20 via Frontend Transport; Tue, 18 Aug 2020 13:09:58 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 21143769-54c6-4b39-540e-08d8437802cc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4408D5D93C18B8F1EC94AA7BEC5C0@MN2PR12MB4408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7oRVTiHr1CFmNx6sQhqpeCgopvaImsBUWZv2wIeBFsvrbuqcsnbSpP6bS3lsZ1MZP7gMly1RuPFt3/EJAVBRBaYPJ//OcJrNLHGeDjIWMeH97oV1/wTRhxwwwEQ0Ug2JFDnshNiuUKFHTtPlq8KV/FQTexIQHTj5DSOYjjUuNdmzGUfe9LPyuoac2z9hWjjlqUsXzGQTJQhAMrGup0vO3fB0CpUmKhAXLnIjpoQEgCY1PozoRHOATOa4Q94gfsIHskIvZbW/gQUiPd3WYAja08l4Q77qYKEiOzarUhLbjrJZSmtxcmc1JU3ZbnxvvU5G40bKEGf+pBLTW+We5wXpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(4326008)(1076003)(54906003)(6666004)(66476007)(66556008)(30864003)(7696005)(52116002)(66946007)(2906002)(86362001)(83380400001)(8936002)(6916009)(6486002)(8676002)(36756003)(5660300002)(316002)(478600001)(16526019)(2616005)(186003)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ydBIIDKPGF1bB/gg+Gyg8Q8ZBG4B7SM4DY9tz5TLm9czbbZuJoBZ/d/2CxaHnZS9W2IKSB7VQbgSBVn6is7jdyI1uBGN+NOOE4Km2BKnYg5pyxQcgoRYSC+chJuT5cp0bUkyYuFbjEB2kvMy8xjf3oU0Ueyh7NufEMUuW9lY3u09e0nKmbLxcDbbzlcMwRAXJW1tDW6pYyaNsEKkeFXSyZncTp/6TD18SfQFhdNFHJh9mvk/TX2K/YQEyeYOCXgHWr+usEjvf/WMhy7e3rbCQaJLpcngI3VtJgU+z2c6qhnalnqPBdZFMSWjGCXAyO8ca37rkRVbs1mwN6hNJUBQ+NIGZa+U9JeX23cjWDB/Zo0SX6pe3KQUWiyI8TqNWlUAYVWC2gXn1rSHh3/xWNXSxEnHH1VHXijJrXQNbrmfG0fJSxod0WvqSPlhQG/YO9P6DDNoSqKFsTAvvqjKLlLha9lpXYWWlztX3KfM6lJssK/E7Kb2wZff1/u14srHZTmc3M367UcpQrQgVFmZwhX3M58WYpRDlAfkY1kKgeL4rBOloaJqxVyqa9BrvKxT9/FUpBa3ijA648UPxU9cVKXF9rpfICvF25jSdWGJN+PCuSl/gcJQfkimnPZJqlXa+KixV4gyePkxLKeE6c/iBaLZmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21143769-54c6-4b39-540e-08d8437802cc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 13:10:00.0693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKZdYK6o8vD/gatXX+hlHDDE4Mxx3YqI7yxarKVVYnzL6CaejMzREYB7G8+17+FMGv5oUnyUV0gJpoDeh3pS/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

v2: use ignore_crat parameter to decide whether it will go with IOMMUv2.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 27 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  2 +-
 .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        | 10 +++----
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  7 ++---
 9 files changed, 46 insertions(+), 17 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1b60e0ed6b5c..20ef754dc62e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1258,7 +1258,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
 		return true;
 	}
 
-	if (dev->device_info->needs_iommu_device)
+	if (dev->device_info->needs_iommu_device && !ignore_crat)
 		return false;
 
 	amdgpu_amdkfd_get_local_mem_info(dev->kgd, &mem_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 59557e3e206a..98993584802f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -22,6 +22,7 @@
 
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <asm/processor.h>
 #include "kfd_crat.h"
 #include "kfd_priv.h"
 #include "kfd_topology.h"
@@ -740,6 +741,29 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
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
+	/* Raven series will go with the fallback path to use virtual CRAT */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	    boot_cpu_data.x86 == 0x17) {
+		ignore_crat = 1;
+	}
+
+	return;
+}
+
 /*
  * kfd_create_crat_image_acpi - Allocates memory for CRAT image and
  * copies CRAT from ACPI (if available).
@@ -751,7 +775,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
  *
  *	Return 0 if successful else return error code
  */
-#ifdef CONFIG_ACPI
 int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 {
 	struct acpi_table_header *crat_table;
@@ -775,6 +798,8 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 		return -EINVAL;
 	}
 
+	kfd_setup_ignore_crat_option();
+
 	if (ignore_crat) {
 		pr_info("CRAT table disabled by module option\n");
 		return -ENODATA;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index 3e5904f8876a..0c4161ac4102 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -309,7 +309,7 @@ static int dbgdev_address_watch_nodiq(struct kfd_dbgdev *dbgdev,
 	for (i = 0; i < adw_info->num_watch_points; i++) {
 		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
 				&cntl, i, pdd->qpd.vmid,
-				dbgdev->dev->device_info->needs_iommu_device);
+				dbgdev->dev->device_info->needs_iommu_device && !ignore_crat);
 
 		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
 		pr_debug("\t\t%20s %08x\n", "register index :", i);
@@ -399,7 +399,7 @@ static int dbgdev_address_watch_diq(struct kfd_dbgdev *dbgdev,
 	for (i = 0; i < adw_info->num_watch_points; i++) {
 		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
 				&cntl, i, vmid,
-				dbgdev->dev->device_info->needs_iommu_device);
+				dbgdev->dev->device_info->needs_iommu_device && !ignore_crat);
 
 		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
 		pr_debug("\t\t%20s %08x\n", "register index :", i);
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index 95a82ac455f2..48b86bdbb680 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 		if (amdgpu_noretry &&
-		    !dqm->dev->device_info->needs_iommu_device)
+		    !(dqm->dev->device_info->needs_iommu_device && !ignore_crat))
 			qpd->sh_mem_config |=
 				1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 78714f9a8b11..6044d36bceb6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -321,7 +321,7 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
 	pdd->lds_base = MAKE_LDS_APP_BASE_VI();
 	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
 
-	if (!pdd->dev->device_info->needs_iommu_device) {
+	if (!(pdd->dev->device_info->needs_iommu_device && !ignore_crat)) {
 		/* dGPUs: SVM aperture starting at 0
 		 * with small reserved space for kernel.
 		 * Set them to CANONICAL addresses.
@@ -423,7 +423,7 @@ int kfd_init_apertures(struct kfd_process *process)
 				return -EINVAL;
 			}
 
-			if (!dev->device_info->needs_iommu_device) {
+			if (!(dev->device_info->needs_iommu_device && !ignore_crat)) {
 				/* dGPUs: the reserved space for kernel
 				 * before SVM
 				 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index 4d3b4188b9a1..c767b524bea4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -41,7 +41,7 @@ int kfd_iommu_check_device(struct kfd_dev *kfd)
 	struct amd_iommu_device_info iommu_info;
 	int err;
 
-	if (!kfd->device_info->needs_iommu_device)
+	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
 		return -ENODEV;
 
 	iommu_info.flags = 0;
@@ -63,7 +63,7 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
 	unsigned int pasid_limit;
 	int err;
 
-	if (!kfd->device_info->needs_iommu_device)
+	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
 		return 0;
 
 	iommu_info.flags = 0;
@@ -109,7 +109,7 @@ int kfd_iommu_bind_process_to_device(struct kfd_process_device *pdd)
 	struct kfd_process *p = pdd->process;
 	int err;
 
-	if (!dev->device_info->needs_iommu_device || pdd->bound == PDD_BOUND)
+	if (!(dev->device_info->needs_iommu_device && !ignore_crat) || pdd->bound == PDD_BOUND)
 		return 0;
 
 	if (unlikely(pdd->bound == PDD_BOUND_SUSPENDED)) {
@@ -284,7 +284,7 @@ static void kfd_unbind_processes_from_device(struct kfd_dev *kfd)
  */
 void kfd_iommu_suspend(struct kfd_dev *kfd)
 {
-	if (!kfd->device_info->needs_iommu_device)
+	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
 		return;
 
 	kfd_unbind_processes_from_device(kfd);
@@ -304,7 +304,7 @@ int kfd_iommu_resume(struct kfd_dev *kfd)
 	unsigned int pasid_limit;
 	int err;
 
-	if (!kfd->device_info->needs_iommu_device)
+	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
 		return 0;
 
 	pasid_limit = kfd_get_pasid_limit();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index cbb8535abf0c..ad8139594b6f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -545,7 +545,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 		 * If the ASIC is APU except Kaveri, set local memory size
 		 * to 0 to disable local memory support
 		 */
-		if (!dev->gpu->device_info->needs_iommu_device
+		if (!(dev->gpu->device_info->needs_iommu_device && !ignore_crat)
 			|| dev->gpu->device_info->asic_family == CHIP_KAVERI) {
 			amdgpu_amdkfd_get_local_mem_info(dev->gpu->kgd,
 				&local_mem_info);
@@ -1090,6 +1090,7 @@ int kfd_topology_init(void)
 						    COMPUTE_UNIT_CPU, NULL,
 						    proximity_domain);
 		cpu_only_node = 1;
+		ignore_crat = 1;
 		if (ret) {
 			pr_err("Error creating VCRAT table for CPU\n");
 			return ret;
@@ -1197,7 +1198,7 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
 		/* Discrete GPUs need their own topology device list
 		 * entries. Don't assign them to CPU/APU nodes.
 		 */
-		if (!gpu->device_info->needs_iommu_device &&
+		if (!(gpu->device_info->needs_iommu_device && !ignore_crat) &&
 		    dev->node_props.cpu_cores_count)
 			continue;
 
@@ -1452,7 +1453,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	* Overwrite ATS capability according to needs_iommu_device to fix
 	* potential missing corresponding bit in CRAT of BIOS.
 	*/
-	if (dev->gpu->device_info->needs_iommu_device)
+	if (dev->gpu->device_info->needs_iommu_device && !ignore_crat)
 		dev->node_props.capability |= HSA_CAP_ATS_PRESENT;
 	else
 		dev->node_props.capability &= ~HSA_CAP_ATS_PRESENT;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
