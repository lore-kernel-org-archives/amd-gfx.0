Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A633FC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 12:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A94C206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 12:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OVFZTvP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A94C206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027F989AEB;
	Tue, 18 Aug 2020 12:38:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF6E89AEB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 12:38:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxASAJtLqT38iP+7AwBUY1ayOo5eY/zy7hQgj7iqG0tr6aH9Y9wtUFbhuF69sscorlOb/FNGbs6UCfh3X1OJJuEVYWTY8tW6SCFjZ7DJwkJI7xeoXTp8YdDT0vTu6hfFYZl9I0qPyXJeCCtTd+Qbr15O/zmckqro91j34fjZuuYd5oH7vetB7xhxxcQ+P7Mobjk5kS/LvLVSDN8LFhgvDAn9X8BlsIQmhQXMWXtyNbN7943tAYpSmlgATsLFaU1mdAiBn/v3zItlvlET4gVEwuHxoAozsn35bcyUOBUrYbko9voenUQq38Y/PDwXoqU8J6t8wZKUuwqbTwvd3EnBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s14CvtulY8oKu81qgCPZi5C3uxnMsDMq3NHCEyvA/Vw=;
 b=eJBW5+HPruUpOpyDm+imLfsq4lmVKTB1ZjEpZMRMGickWi3fuvtJFohFtqrfle7jTF8U5Thj5OkKdkLahyQmTxjhHqhNAWG1vKL2tu4VbAhqhGN50x3t29XGNbX7bC43edsQakRYw1C9RUkbjNZjX97YGuIW8iviaGerUa9QLqFd/Strupd58os3psX3KOSjMfPWfzyChAJv832VWcN14Uh5l+UTPl424fDpMcEsrsPHqgt7z935Ol2fgQnVpIS5TQLaciq9vGQYSeaM0IsqD5q4KnzG0i0/XsLRU3hAd1+dtyKSsY2Dq9rFwoHIZm6KBFSL04jVjx1KWg/bxgPNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s14CvtulY8oKu81qgCPZi5C3uxnMsDMq3NHCEyvA/Vw=;
 b=OVFZTvP6S5FfXoHlu5A/p/MnFRcFXlO5/0NoZpDh4oUwZaA3u0myVooZw0NQgH3FfgAXC81moseoecGkURmY15RuiupBNZ2jyM7HiLcNJfaXy0b0K4UusjxXa1+N1VPHDVG9I9Ap5wgOmV9OMabGkAjJiwJUQoRMdwpXhoTJrCE=
Received: from BN6PR10CA0046.namprd10.prod.outlook.com (2603:10b6:404:109::32)
 by MN2PR12MB3903.namprd12.prod.outlook.com (2603:10b6:208:15a::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 18 Aug
 2020 12:38:23 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::7) by BN6PR10CA0046.outlook.office365.com
 (2603:10b6:404:109::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Tue, 18 Aug 2020 12:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 12:38:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 18 Aug
 2020 07:38:18 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 18 Aug
 2020 07:38:17 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 18 Aug 2020 07:38:15 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v3] drm/amdgpu: refine create and release logic of hive info
Date: Tue, 18 Aug 2020 20:38:07 +0800
Message-ID: <20200818123807.11333-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9df44961-a039-4125-0a73-08d8437398d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3903:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3903E7D7B758186768BF88E2ED5C0@MN2PR12MB3903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyVUXJiKMv902d9wafHOOeYhq70tddJ6lqYEdu0JJAIOGX1HY2cbdtBLcbKzyzuwm+ypQYqu+KrxSocHpDvp61PxXaZ9hXe2Zzr5sjSVYG5jXuUhEvMwUHZmBltGEHGv4+Zk6Oo9mu0G4faiX9zRgPwp4lMPwOQlzS232fORYdv9xYnpvhdZ+KT9GtiSGPTv8HA3/+wkW2IkYGp0h+wBRp8cfIpH8HLifZh3MJv8IGZCEQ/pdP7CNm5KZAoWTYneCI7P+ELK37wXR4kyirgcwwPg8lBW9u2cQSU87kpkr8t9uS9uX0hl7vEhKizK1bV4AzqhKWsk4vfvh7XeqJlkJU84IXxO3NgZrqh4MsGHWAiWZ3irideOzDyeMHNhhP+4Py169uGUVE1Xa2z4y1KD0ny4FCDKljsPcnhdSnfMMCU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966005)(7696005)(47076004)(356005)(4326008)(336012)(110136005)(82740400003)(478600001)(1076003)(26005)(316002)(6666004)(81166007)(82310400002)(2906002)(70206006)(70586007)(83380400001)(86362001)(5660300002)(186003)(6636002)(2616005)(8936002)(30864003)(8676002)(426003)(36756003)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 12:38:23.6697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df44961-a039-4125-0a73-08d8437398d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3903
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change to dynamically create and release hive info object,
which help driver support more hives in the future.

v2:
Change to save hive object pointer in adev, to avoid locking
xgmi_mutex every time when calling amdgpu_get_xgmi_hive.

v3:
1. Change type of hive object pointer in adev from void* to
amdgpu_hive_info*.
2. remove unnecessary variable initialization.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 98d0c6e5ab3c..e25f952d8836 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -251,6 +251,7 @@ struct amdgpu_fpriv;
 struct amdgpu_bo_va_mapping;
 struct amdgpu_atif;
 struct kfd_vm_fault_info;
+struct amdgpu_hive_info;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -730,7 +731,7 @@ struct amdgpu_device {
 #ifdef CONFIG_DRM_AMD_ACP
 	struct amdgpu_acp		acp;
 #endif
-
+	struct amdgpu_hive_info *hive;
 	/* ASIC */
 	enum amd_asic_type		asic_type;
 	uint32_t			family;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f323281c82b0..bc6ef0caf157 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2857,7 +2857,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 {
 	struct amdgpu_device *adev =
 		container_of(__work, struct amdgpu_device, xgmi_reset_work);
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 
 	/* It's a bug to not have a hive within this function */
 	if (WARN_ON(!hive))
@@ -2895,6 +2895,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 	if (adev->asic_reset_res)
 		DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
 			 adev->asic_reset_res, adev->ddev->unique);
+	amdgpu_put_xgmi_hive(hive);
 }
 
 static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
@@ -4315,7 +4316,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * We always reset all schedulers for device and all devices for XGMI
 	 * hive so that should take care of them too.
 	 */
-	hive = amdgpu_get_xgmi_hive(adev, false);
+	hive = amdgpu_get_xgmi_hive(adev);
 	if (hive) {
 		if (atomic_cmpxchg(&hive->in_reset, 0, 1) != 0) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bf71f0a58786..18cdd259d568 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1555,9 +1555,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_device *remote_adev = NULL;
 	struct amdgpu_device *adev = ras->adev;
 	struct list_head device_list, *device_list_handle =  NULL;
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, false);
 
 	if (!ras->disable_ras_err_cnt_harvest) {
+		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+
 		/* Build list of devices to query RAS related errors */
 		if  (hive && adev->gmc.xgmi.num_physical_nodes > 1) {
 			device_list_handle = &hive->device_list;
@@ -1570,6 +1571,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		list_for_each_entry(remote_adev,
 				device_list_handle, gmc.xgmi.head)
 			amdgpu_ras_log_on_err_counter(remote_adev);
+
+		amdgpu_put_xgmi_hive(hive);
 	}
 
 	if (amdgpu_device_should_recover_gpu(ras->adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 7a61dc6738eb..08ed4dddfaf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -35,11 +35,9 @@
 
 static DEFINE_MUTEX(xgmi_mutex);
 
-#define AMDGPU_MAX_XGMI_HIVE			8
 #define AMDGPU_MAX_XGMI_DEVICE_PER_HIVE		4
 
-static struct amdgpu_hive_info xgmi_hives[AMDGPU_MAX_XGMI_HIVE];
-static unsigned hive_count = 0;
+static LIST_HEAD(xgmi_hive_list);
 
 static const int xgmi_pcs_err_status_reg_vg20[] = {
 	smnXGMI0_PCS_GOPX16_PCS_ERROR_STATUS,
@@ -171,59 +169,47 @@ static const struct amdgpu_pcs_ras_field wafl_pcs_ras_fields[] = {
  *
  */
 
+static struct attribute amdgpu_xgmi_hive_id = {
+	.name = "xgmi_hive_id",
+	.mode = S_IRUGO
+};
 
-static ssize_t amdgpu_xgmi_show_hive_id(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct amdgpu_hive_info *hive =
-			container_of(attr, struct amdgpu_hive_info, dev_attr);
-
-	return snprintf(buf, PAGE_SIZE, "%llu\n", hive->hive_id);
-}
+static struct attribute *amdgpu_xgmi_hive_attrs[] = {
+	&amdgpu_xgmi_hive_id,
+	NULL
+};
 
-static int amdgpu_xgmi_sysfs_create(struct amdgpu_device *adev,
-				    struct amdgpu_hive_info *hive)
+static ssize_t amdgpu_xgmi_show_attrs(struct kobject *kobj,
+	struct attribute *attr, char *buf)
 {
-	int ret = 0;
-
-	if (WARN_ON(hive->kobj))
-		return -EINVAL;
-
-	hive->kobj = kobject_create_and_add("xgmi_hive_info", &adev->dev->kobj);
-	if (!hive->kobj) {
-		dev_err(adev->dev, "XGMI: Failed to allocate sysfs entry!\n");
-		return -EINVAL;
-	}
-
-	hive->dev_attr = (struct device_attribute) {
-		.attr = {
-			.name = "xgmi_hive_id",
-			.mode = S_IRUGO,
+	struct amdgpu_hive_info *hive = container_of(
+		kobj, struct amdgpu_hive_info, kobj);
 
-		},
-		.show = amdgpu_xgmi_show_hive_id,
-	};
-
-	ret = sysfs_create_file(hive->kobj, &hive->dev_attr.attr);
-	if (ret) {
-		dev_err(adev->dev, "XGMI: Failed to create device file xgmi_hive_id\n");
-		kobject_del(hive->kobj);
-		kobject_put(hive->kobj);
-		hive->kobj = NULL;
-	}
+	if (attr == &amdgpu_xgmi_hive_id)
+		return snprintf(buf, PAGE_SIZE, "%llu\n", hive->hive_id);
 
-	return ret;
+	return 0;
 }
 
-static void amdgpu_xgmi_sysfs_destroy(struct amdgpu_device *adev,
-				    struct amdgpu_hive_info *hive)
+static void amdgpu_xgmi_hive_release(struct kobject *kobj)
 {
-	sysfs_remove_file(hive->kobj, &hive->dev_attr.attr);
-	kobject_del(hive->kobj);
-	kobject_put(hive->kobj);
-	hive->kobj = NULL;
+	struct amdgpu_hive_info *hive = container_of(
+		kobj, struct amdgpu_hive_info, kobj);
+
+	mutex_destroy(&hive->hive_lock);
+	kfree(hive);
 }
 
+static const struct sysfs_ops amdgpu_xgmi_hive_ops = {
+	.show = amdgpu_xgmi_show_attrs,
+};
+
+struct kobj_type amdgpu_xgmi_hive_type = {
+	.release = amdgpu_xgmi_hive_release,
+	.sysfs_ops = &amdgpu_xgmi_hive_ops,
+	.default_attrs = amdgpu_xgmi_hive_attrs,
+};
+
 static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -287,8 +273,8 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 
 
 	/* Create sysfs link to hive info folder on the first device */
-	if (adev != hive->adev) {
-		ret = sysfs_create_link(&adev->dev->kobj, hive->kobj,
+	if (hive->kobj.parent != (&adev->dev->kobj)) {
+		ret = sysfs_create_link(&adev->dev->kobj, &hive->kobj,
 					"xgmi_hive_info");
 		if (ret) {
 			dev_err(adev->dev, "XGMI: Failed to create link to hive info");
@@ -296,9 +282,9 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 		}
 	}
 
-	sprintf(node, "node%d", hive->number_devices);
+	sprintf(node, "node%d", atomic_read(&hive->number_devices));
 	/* Create sysfs link form the hive folder to yourself */
-	ret = sysfs_create_link(hive->kobj, &adev->dev->kobj, node);
+	ret = sysfs_create_link(&hive->kobj, &adev->dev->kobj, node);
 	if (ret) {
 		dev_err(adev->dev, "XGMI: Failed to create link from hive info");
 		goto remove_link;
@@ -326,78 +312,96 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
 	device_remove_file(adev->dev, &dev_attr_xgmi_error);
 
-	if (adev != hive->adev)
+	if (hive->kobj.parent != (&adev->dev->kobj))
 		sysfs_remove_link(&adev->dev->kobj,"xgmi_hive_info");
 
-	sprintf(node, "node%d", hive->number_devices);
-	sysfs_remove_link(hive->kobj, node);
+	sprintf(node, "node%d", atomic_read(&hive->number_devices));
+	sysfs_remove_link(&hive->kobj, node);
 
 }
 
 
 
-struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock)
+struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 {
-	int i;
-	struct amdgpu_hive_info *tmp;
+	struct amdgpu_hive_info *hive = NULL, *tmp = NULL;
+	int ret;
 
 	if (!adev->gmc.xgmi.hive_id)
 		return NULL;
 
+	if (adev->hive) {
+		kobject_get(&adev->hive->kobj);
+		return adev->hive;
+	}
+
 	mutex_lock(&xgmi_mutex);
 
-	for (i = 0 ; i < hive_count; ++i) {
-		tmp = &xgmi_hives[i];
-		if (tmp->hive_id == adev->gmc.xgmi.hive_id) {
-			if (lock)
-				mutex_lock(&tmp->hive_lock);
-			mutex_unlock(&xgmi_mutex);
-			return tmp;
+	if (!list_empty(&xgmi_hive_list)) {
+		list_for_each_entry_safe(hive, tmp, &xgmi_hive_list, node)  {
+			if (hive->hive_id == adev->gmc.xgmi.hive_id)
+				goto pro_end;
 		}
 	}
-	if (i >= AMDGPU_MAX_XGMI_HIVE) {
-		mutex_unlock(&xgmi_mutex);
-		return NULL;
+
+	hive = kzalloc(sizeof(*hive), GFP_KERNEL);
+	if (!hive) {
+		dev_err(adev->dev, "XGMI: allocation failed\n");
+		hive = NULL;
+		goto pro_end;
 	}
 
 	/* initialize new hive if not exist */
-	tmp = &xgmi_hives[hive_count++];
-
-	if (amdgpu_xgmi_sysfs_create(adev, tmp)) {
-		mutex_unlock(&xgmi_mutex);
-		return NULL;
+	ret = kobject_init_and_add(&hive->kobj,
+			&amdgpu_xgmi_hive_type,
+			&adev->dev->kobj,
+			"%s", "xgmi_hive_info");
+	if (ret) {
+		dev_err(adev->dev, "XGMI: failed initializing kobject for xgmi hive\n");
+		kfree(hive);
+		hive = NULL;
+		goto pro_end;
 	}
 
-	tmp->adev = adev;
-	tmp->hive_id = adev->gmc.xgmi.hive_id;
-	INIT_LIST_HEAD(&tmp->device_list);
-	mutex_init(&tmp->hive_lock);
-	atomic_set(&tmp->in_reset, 0);
-	task_barrier_init(&tmp->tb);
-
-	if (lock)
-		mutex_lock(&tmp->hive_lock);
-	tmp->pstate = AMDGPU_XGMI_PSTATE_UNKNOWN;
-	tmp->hi_req_gpu = NULL;
+	hive->hive_id = adev->gmc.xgmi.hive_id;
+	INIT_LIST_HEAD(&hive->device_list);
+	INIT_LIST_HEAD(&hive->node);
+	mutex_init(&hive->hive_lock);
+	atomic_set(&hive->in_reset, 0);
+	atomic_set(&hive->number_devices, 0);
+	task_barrier_init(&hive->tb);
+	hive->pstate = AMDGPU_XGMI_PSTATE_UNKNOWN;
+	hive->hi_req_gpu = NULL;
 	/*
 	 * hive pstate on boot is high in vega20 so we have to go to low
 	 * pstate on after boot.
 	 */
-	tmp->hi_req_count = AMDGPU_MAX_XGMI_DEVICE_PER_HIVE;
+	hive->hi_req_count = AMDGPU_MAX_XGMI_DEVICE_PER_HIVE;
+	list_add_tail(&hive->node, &xgmi_hive_list);
+
+pro_end:
+	if (hive)
+		kobject_get(&hive->kobj);
 	mutex_unlock(&xgmi_mutex);
+	return hive;
+}
 
-	return tmp;
+void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive)
+{
+	if (hive)
+		kobject_put(&hive->kobj);
 }
 
 int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
 {
 	int ret = 0;
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 	struct amdgpu_device *request_adev = hive->hi_req_gpu ?
 						hive->hi_req_gpu : adev;
 	bool is_hi_req = pstate == AMDGPU_XGMI_PSTATE_MAX_VEGA20;
 	bool init_low = hive->pstate == AMDGPU_XGMI_PSTATE_UNKNOWN;
 
+	amdgpu_put_xgmi_hive(hive);
 	/* fw bug so temporarily disable pstate switching */
 	return 0;
 
@@ -449,7 +453,7 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
 
 	/* Each psp need to set the latest topology */
 	ret = psp_xgmi_set_topology_info(&adev->psp,
-					 hive->number_devices,
+					 atomic_read(&hive->number_devices),
 					 &adev->psp.xgmi_context.top_info);
 	if (ret)
 		dev_err(adev->dev,
@@ -511,7 +515,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		adev->gmc.xgmi.node_id = adev->gmc.xgmi.physical_node_id + 16;
 	}
 
-	hive = amdgpu_get_xgmi_hive(adev, 1);
+	hive = amdgpu_get_xgmi_hive(adev);
 	if (!hive) {
 		ret = -EINVAL;
 		dev_err(adev->dev,
@@ -519,6 +523,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 			adev->gmc.xgmi.node_id, adev->gmc.xgmi.hive_id);
 		goto exit;
 	}
+	mutex_lock(&hive->hive_lock);
 
 	top_info = &adev->psp.xgmi_context.top_info;
 
@@ -526,7 +531,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	list_for_each_entry(entry, &hive->device_list, head)
 		top_info->nodes[count++].node_id = entry->node_id;
 	top_info->num_nodes = count;
-	hive->number_devices = count;
+	atomic_set(&hive->number_devices, count);
 
 	task_barrier_add_task(&hive->tb);
 
@@ -565,35 +570,48 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 exit_unlock:
 	mutex_unlock(&hive->hive_lock);
 exit:
-	if (!ret)
+	if (!ret) {
+		adev->hive = hive;
 		dev_info(adev->dev, "XGMI: Add node %d, hive 0x%llx.\n",
 			 adev->gmc.xgmi.physical_node_id, adev->gmc.xgmi.hive_id);
-	else
+	} else {
+		amdgpu_put_xgmi_hive(hive);
 		dev_err(adev->dev, "XGMI: Failed to add node %d, hive 0x%llx ret: %d\n",
 			adev->gmc.xgmi.physical_node_id, adev->gmc.xgmi.hive_id,
 			ret);
+	}
 
 	return ret;
 }
 
 int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 {
-	struct amdgpu_hive_info *hive;
+	struct amdgpu_hive_info *hive = adev->hive;
 
 	if (!adev->gmc.xgmi.supported)
 		return -EINVAL;
 
-	hive = amdgpu_get_xgmi_hive(adev, 1);
 	if (!hive)
 		return -EINVAL;
 
+	mutex_lock(&hive->hive_lock);
 	task_barrier_rem_task(&hive->tb);
 	amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
+	if (hive->hi_req_gpu == adev)
+		hive->hi_req_gpu = NULL;
+	list_del(&adev->gmc.xgmi.head);
 	mutex_unlock(&hive->hive_lock);
 
-	if(!(--hive->number_devices)){
-		amdgpu_xgmi_sysfs_destroy(adev, hive);
-		mutex_destroy(&hive->hive_lock);
+	amdgpu_put_xgmi_hive(hive);
+	adev->hive = NULL;
+
+	if (atomic_dec_return(&hive->number_devices) == 0) {
+		/* Remove the hive from global hive list */
+		mutex_lock(&xgmi_mutex);
+		list_del(&hive->node);
+		mutex_unlock(&xgmi_mutex);
+
+		amdgpu_put_xgmi_hive(hive);
 	}
 
 	return psp_xgmi_terminate(&adev->psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 453336ca9675..148560d63554 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -27,13 +27,12 @@
 
 
 struct amdgpu_hive_info {
-	uint64_t		hive_id;
-	struct list_head	device_list;
-	int number_devices;
+	struct kobject kobj;
+	uint64_t hive_id;
+	struct list_head device_list;
+	struct list_head node;
+	atomic_t number_devices;
 	struct mutex hive_lock;
-	struct kobject *kobj;
-	struct device_attribute dev_attr;
-	struct amdgpu_device *adev;
 	atomic_t in_reset;
 	int hi_req_count;
 	struct amdgpu_device *hi_req_gpu;
@@ -51,7 +50,8 @@ struct amdgpu_pcs_ras_field {
 	uint32_t pcs_err_shift;
 };
 
-struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock);
+struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
+void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
 int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
