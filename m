Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53F3C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 12:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A4F2078D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 12:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UhWRVsbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A4F2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2315E6EADB;
	Fri, 21 Aug 2020 12:51:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E7D6EADB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 12:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGF3SXN5mAndwa5A5K9mXVGbyc8QIx256P1GuC6/t7fHky0bq1hA909aNkRqKq6bXuBuzCWHh6RuFqZX9W/oSyh+/RsNImXYUdiudFkvx73dkuO2qRd5k+8sTPIYuqkjELe7ftEf5sh7HgbRFn3cJNse+lcValWRIDxjf18O6FpiqXaWWD0mGPOezZTBrp7GR5FXKxkmbde6dCwBocuidpdUURLFm/smgcPiKL92iPAW2Y/4f5yXrPct6f/8Ri9yzzYZqXUg3GPuNop49pL+MlTVliVGPeq8hlHEqheVWeMQwizZX/J5GBkMfF9+xtIAOm3glbRl5leKt9EGHv25EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI70EkEdrFh+H8ma1VPzL5TpiT4vTSLxivkk+gQ2254=;
 b=KkY52vwWBYvUWMlbhFVr6tn51cLv/yaRzsX4e4cD5RFI3Rs5+UXrhh4eBlI41oznNp7jE/BzKdO69sQm70J6GiS5SDQBh27XzTEubbkzZUXrPFpI1TKPKpjFHpt7Hon8RUAELOXKU8WoKjOMe8gpmzuvNR/juOwuOg7n0B/8oG/qpQPJXXuSExHFstTV71KhSHrf96Bkw0lDhyif1JqHjPW+fFFqLost24KDRnXjQeBARGDaoYvHYPD5pS8R2sbSFqUl91D5y3ZfNLAxwcrzDP1nKh77g/w6Y73D06uq6Zh6MewOuh6s4zsmY4kc2sg4yTYmqG0NifjToILQ4L+Kgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI70EkEdrFh+H8ma1VPzL5TpiT4vTSLxivkk+gQ2254=;
 b=UhWRVsbu6ceTtPXRwOHRMTDOxe0SNy8p2rC1rGH2k0eeiVFKyW0oppeUUVKkHf6J+71mPO8xFwmgqRBtm5XumlwNUa06Mr5DuHlSKlODQWv6uij/nesCkToquCRfoUBaxAd1S1/4rNGaHVod6AzEGkN0s9pvEBBf9wmvfDvpSWg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB3934.namprd12.prod.outlook.com (2603:10b6:208:167::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Fri, 21 Aug
 2020 12:50:58 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Fri, 21 Aug 2020
 12:50:58 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5] drm/amdkfd: implement the dGPU fallback path for apu (v5)
Date: Fri, 21 Aug 2020 20:50:37 +0800
Message-Id: <20200821125037.361341-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR02CA0185.apcprd02.prod.outlook.com
 (2603:1096:201:21::21) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR02CA0185.apcprd02.prod.outlook.com (2603:1096:201:21::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 12:50:56 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b97afe68-97e5-43cd-54eb-08d845d0d9a2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3934CA974E59C296165DB12DEC5B0@MN2PR12MB3934.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKywbAVRCt7KG+juCKPabRLpes7QTQSYuHkYnhQzCpkVNZULqVQM2qTW+/dC7LV2wP7SO/QZVkuvX/dM0YmmeoQTIbN+Pkfc/8eJZi3TUXmnGkVsrKN2wuAi0V8RHxC4d7R7ydSqdyYYPkpMneFp3AhFyMsUsmpXMIPjR8XGPXUsr9fEgW527zQXMB1F/sb4sn5nXpH1W+nVcIy8Y6Z/uN4kHLLsnPhpuPIBf9PHui26J0ts6sAzmjyA/oiAjV0J+y/SptH/DkFPPbN/UsIE3YxobXeSUaevPBXavm38OhcPV3+EYQPc4GdOjysDoiefMqKtDuZXhQOVKh09c9nB6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(6666004)(16526019)(186003)(5660300002)(2616005)(956004)(36756003)(83380400001)(6486002)(6916009)(4326008)(30864003)(2906002)(54906003)(66556008)(86362001)(478600001)(52116002)(1076003)(26005)(8936002)(66476007)(8676002)(316002)(66946007)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dJcf9Fdk7149BAKPabADAOL9IRjOZ2lMLwYeuR6FDD7wSdl/FaPPvB3vvzNgO4cLGgaSTuwWy2TskMijbE8iCB5SzgzUHKZuyb7hV88DS2VnuoudpDoRPci84Z96+zdMdzahpkKgo1CZcIeCpJleFVcYcj6YQtCPo5/fUcO3BKq0U2de/xenmvCakqaPJ6e2MEajvHtLUDdD1kqMlgU/4sOUYyMCHxIlVn/trcUo+BwFBK4cNFl0/8UFQf6unDg/gmAW6lAz1JcL8Nuet6/+OYT406UvhxC+0bMh66qo8sjFgVlJsNrRx151dZ/5mHKRIAvOh0RuSV4U2kWAdXLFBJqeluDVuQu9uHaaJvXk42swqvJrZEXKitveyk3CKwk/jXs0rGkc5CAar84sYyumHfcCpiBeD3vZpeK1Sjvp4DTMws2qcJOM94Ze/VKftWx/Pr31d9CaYn3kdediv54tW3aC0dz8xtNDVfzUAs6fp0qi60VSdHErwWMILJu5hE09LqLeYumBVeCWcu18gcOfLLWFpAAGSt5nBv//foZC7eerRl1P5i6g42VJb9xZBEOreQudeZqEG0wBU94mK5BKsWNgHQZ1CZedt5xl3NqDN5ks+O/isrU7HAOGDoxEM28dm7fxOXSDhu1WHxAaD2ty3g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97afe68-97e5-43cd-54eb-08d845d0d9a2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 12:50:58.4600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXCVrXnJQRBs5FYI4MG5engAABkDX0oY6g0KIH7LTxVb0cKiQ0juBLanQAQdMO+IaZNMakkub3mVm4V1zLUvhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3934
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
v5: refine acpi crat good but no iommu support case, and rename the
    title.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 22 ++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 ++-
 .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        | 10 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 36 +++++++++++++++++--
 10 files changed, 76 insertions(+), 19 deletions(-)

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
index 1b60e0ed6b5c..3ec5322ba88d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1258,7 +1258,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
 		return true;
 	}
 
-	if (dev->device_info->needs_iommu_device)
+	if (dev->use_iommu_v2)
 		return false;
 
 	amdgpu_amdkfd_get_local_mem_info(dev->kgd, &mem_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 59557e3e206a..aba40df189d9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -740,6 +740,25 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 	return 0;
 }
 
+
+#ifdef CONFIG_ACPI
+
+static bool kfd_ignore_crat(void)
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
@@ -751,7 +770,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
  *
  *	Return 0 if successful else return error code
  */
-#ifdef CONFIG_ACPI
 int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 {
 	struct acpi_table_header *crat_table;
@@ -775,7 +793,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 		return -EINVAL;
 	}
 
-	if (ignore_crat) {
+	if (kfd_ignore_crat()) {
 		pr_info("CRAT table disabled by module option\n");
 		return -ENODATA;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index 3e5904f8876a..e4159b5f83d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -309,7 +309,7 @@ static int dbgdev_address_watch_nodiq(struct kfd_dbgdev *dbgdev,
 	for (i = 0; i < adw_info->num_watch_points; i++) {
 		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
 				&cntl, i, pdd->qpd.vmid,
-				dbgdev->dev->device_info->needs_iommu_device);
+				dbgdev->dev->use_iommu_v2);
 
 		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
 		pr_debug("\t\t%20s %08x\n", "register index :", i);
@@ -399,7 +399,7 @@ static int dbgdev_address_watch_diq(struct kfd_dbgdev *dbgdev,
 	for (i = 0; i < adw_info->num_watch_points; i++) {
 		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
 				&cntl, i, vmid,
-				dbgdev->dev->device_info->needs_iommu_device);
+				dbgdev->dev->use_iommu_v2);
 
 		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
 		pr_debug("\t\t%20s %08x\n", "register index :", i);
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index 95a82ac455f2..309f63a0b34a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
 				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 		if (amdgpu_noretry &&
-		    !dqm->dev->device_info->needs_iommu_device)
+		    !dqm->dev->use_iommu_v2)
 			qpd->sh_mem_config |=
 				1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 78714f9a8b11..798303c3c7ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -321,7 +321,7 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
 	pdd->lds_base = MAKE_LDS_APP_BASE_VI();
 	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
 
-	if (!pdd->dev->device_info->needs_iommu_device) {
+	if (!pdd->dev->use_iommu_v2) {
 		/* dGPUs: SVM aperture starting at 0
 		 * with small reserved space for kernel.
 		 * Set them to CANONICAL addresses.
@@ -423,7 +423,7 @@ int kfd_init_apertures(struct kfd_process *process)
 				return -EINVAL;
 			}
 
-			if (!dev->device_info->needs_iommu_device) {
+			if (!dev->use_iommu_v2) {
 				/* dGPUs: the reserved space for kernel
 				 * before SVM
 				 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index 4d3b4188b9a1..0c0269497e51 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -41,7 +41,7 @@ int kfd_iommu_check_device(struct kfd_dev *kfd)
 	struct amd_iommu_device_info iommu_info;
 	int err;
 
-	if (!kfd->device_info->needs_iommu_device)
+	if (!kfd->use_iommu_v2)
 		return -ENODEV;
 
 	iommu_info.flags = 0;
@@ -63,7 +63,7 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
 	unsigned int pasid_limit;
 	int err;
 
-	if (!kfd->device_info->needs_iommu_device)
+	if (!kfd->use_iommu_v2)
 		return 0;
 
 	iommu_info.flags = 0;
@@ -109,7 +109,7 @@ int kfd_iommu_bind_process_to_device(struct kfd_process_device *pdd)
 	struct kfd_process *p = pdd->process;
 	int err;
 
-	if (!dev->device_info->needs_iommu_device || pdd->bound == PDD_BOUND)
+	if (!dev->use_iommu_v2 || pdd->bound == PDD_BOUND)
 		return 0;
 
 	if (unlikely(pdd->bound == PDD_BOUND_SUSPENDED)) {
@@ -284,7 +284,7 @@ static void kfd_unbind_processes_from_device(struct kfd_dev *kfd)
  */
 void kfd_iommu_suspend(struct kfd_dev *kfd)
 {
-	if (!kfd->device_info->needs_iommu_device)
+	if (!kfd->use_iommu_v2)
 		return;
 
 	kfd_unbind_processes_from_device(kfd);
@@ -304,7 +304,7 @@ int kfd_iommu_resume(struct kfd_dev *kfd)
 	unsigned int pasid_limit;
 	int err;
 
-	if (!kfd->device_info->needs_iommu_device)
+	if (!kfd->use_iommu_v2)
 		return 0;
 
 	pasid_limit = kfd_get_pasid_limit();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 60243798cce2..641b964387ec 100644
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index cbb8535abf0c..d141f726d037 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -545,7 +545,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 		 * If the ASIC is APU except Kaveri, set local memory size
 		 * to 0 to disable local memory support
 		 */
-		if (!dev->gpu->device_info->needs_iommu_device
+		if (!dev->gpu->use_iommu_v2
 			|| dev->gpu->device_info->asic_family == CHIP_KAVERI) {
 			amdgpu_amdkfd_get_local_mem_info(dev->gpu->kgd,
 				&local_mem_info);
@@ -1197,7 +1197,7 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
 		/* Discrete GPUs need their own topology device list
 		 * entries. Don't assign them to CPU/APU nodes.
 		 */
-		if (!gpu->device_info->needs_iommu_device &&
+		if (!gpu->use_iommu_v2 &&
 		    dev->node_props.cpu_cores_count)
 			continue;
 
@@ -1452,7 +1452,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	* Overwrite ATS capability according to needs_iommu_device to fix
 	* potential missing corresponding bit in CRAT of BIOS.
 	*/
-	if (dev->gpu->device_info->needs_iommu_device)
+	if (dev->gpu->use_iommu_v2)
 		dev->node_props.capability |= HSA_CAP_ATS_PRESENT;
 	else
 		dev->node_props.capability &= ~HSA_CAP_ATS_PRESENT;
@@ -1579,6 +1579,36 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
 	return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
 }
 
+void kfd_double_confirm_iommu_support(struct kfd_dev *gpu)
+{
+	struct kfd_topology_device *dev;
+
+	gpu->use_iommu_v2 = false;
+
+	down_read(&topology_lock);
+
+	/* Only use IOMMUv2 if there is an APU topology node with no GPU
+	 * assigned yet. This GPU will be assigned to it.
+	 */
+	list_for_each_entry(dev, &topology_device_list, list) {
+		if (dev->node_props.cpu_cores_count &&
+		    dev->node_props.simd_count &&
+		    !dev->gpu) {
+			/* If device_info indicates no iommu support, force
+			 * simd_count as 0 to tell user mode no GPU in the APU
+			 * node.
+			 */
+			if (!gpu->device_info->needs_iommu_device)
+				dev->node_props.simd_count = 0;
+			else
+				gpu->use_iommu_v2 = true;
+			break;
+		}
+	}
+
+	up_read(&topology_lock);
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
