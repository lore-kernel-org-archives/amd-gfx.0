Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92533C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60149206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3w7FJ/TL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60149206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097D96E0F4;
	Tue, 11 Aug 2020 06:17:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 731736E0F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 06:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/mj3GgO27N+LvWIRyNGH8+YN6SHojX2CGnR5KBobsrDifYjqPbZPlUikct16Nvc2pnTbHRm36zpP1/WeM2ao0hcvN8XZi8Ue0Asp/ysvRFi1PMkd/hqS+6x9iu28/sG/f6o2JlR63VFT91tntGh4glhD8c34qTwiEccdKfH1ObCffdBRqUf+IaVl50sRWJvLQiP981qfH2j+Df+ECGauKC4Uvee3vIQ+flIefq6CnQBN8lSqVyf08r/MDtLOe/pRNSrsPhBvSEMd3vX2NxmP1cqtDxzMNbFrp7uYBMpBGSCorzm0HwdZv+LCUzoRIm9tYpBhfmVQ3ay8vFX3mjBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5Noi/0s5suq9QyLrZ3DamGTF64UzXB7Mpl9wTmpSjc=;
 b=cdXWAtic9h2/AdmnCCM4fnKqe8igi+vu+W9YAIzZ0fodVhA1iKbciTfPsKADbusZ2eQgu+k3Gm8O933NCJL0K1Naf2wEvgiNzePmQZwnlAUprwP26i8Sd6q7OxnBLlP7QHuCqQV7eni+OStxVQFYQMJ9a7243+kxAvSsSMjMwhVxRb1lCemUP51VGpNWBykAXyVwjVIV298FYJwFHltRg2kq6cbbLcWTKPCG23kHuAHylhv7YWCMBDS0wspDajmzpN11Xhl5r/FS3iCiPbHkEnWfVCcyBi0ZYbH8UHhqodROk2E8WCHwEvg77T//U5wBF31mbBfVYgonNhZ/FGblzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5Noi/0s5suq9QyLrZ3DamGTF64UzXB7Mpl9wTmpSjc=;
 b=3w7FJ/TLowNCySvmtwZPFWhAIxpq1/Y6PX8KBJV7Rxi4pYJkV/eyMizZwP9NUjoZOWuYAj7Sk95cftKlnyJoGJgcUWYB/YkQHpvWEwIAQw4Fy5rjgrU9VgACgTRjUDKuHl9lIrz5hVRNt3b78Khld/aPKTG60aqCTsQaCS+pIcA=
Received: from MWHPR18CA0056.namprd18.prod.outlook.com (2603:10b6:300:39::18)
 by MN2PR12MB3040.namprd12.prod.outlook.com (2603:10b6:208:ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 06:17:25 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::df) by MWHPR18CA0056.outlook.office365.com
 (2603:10b6:300:39::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Tue, 11 Aug 2020 06:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Tue, 11 Aug 2020 06:17:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 11 Aug
 2020 01:17:24 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 11 Aug
 2020 01:17:23 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 11 Aug 2020 01:17:21 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: refine create and release logic of hive info
Date: Tue, 11 Aug 2020 14:17:10 +0800
Message-ID: <20200811061710.20988-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ccfddca-dc0c-4ff1-a0d4-08d83dbe371a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3040:
X-Microsoft-Antispam-PRVS: <MN2PR12MB30409E344225F14D2A01D6D1ED450@MN2PR12MB3040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUq+FZLnQ+MOR/bSBnyEUldiXZjGII4DQSbbGR3MOlopkcgsByGvoogFiRMEexsfrv81QMpGgOmFNP1k0rEtu7k9vhki8Yz+IL3wzuAXOleiHOnvz2K1V2+OEGVRHK+bLUddQ5lZFhL3tpVfq3sghl8WIxRdqx9t1A9uQ85Mb+kMZm24OxK7DG9akAnPumKEBH11x8S0FAKlEaBndW7VPAeihfXLdlkG2crX9eqbr9QJJvLnZfpJcyNzmIWWqNbpJ3b6FtB14gBzVJgu+O4vON9A37dPFPkNCTSts9/xFFCuOuHUnu9sTbJ9LW55Brnfe+YF76ZgUo8xRDdGkC5oGioaOLA/7nO4OmU4EsJBoitoZ3JJPBh3XA/zbG8rmdBxv1UYMgVTIzT2Cs8l7HcpsiXhvEl72n88oHCgEET0vfY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(46966005)(336012)(2616005)(83380400001)(8936002)(8676002)(70586007)(1076003)(7696005)(6666004)(426003)(186003)(26005)(5660300002)(30864003)(4326008)(6636002)(478600001)(2906002)(110136005)(47076004)(86362001)(356005)(82310400002)(82740400003)(36756003)(81166007)(70206006)(316002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 06:17:24.8928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccfddca-dc0c-4ff1-a0d4-08d83dbe371a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3040
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

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8a55b0bc044a..fdfdc2f678c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2840,7 +2840,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 {
 	struct amdgpu_device *adev =
 		container_of(__work, struct amdgpu_device, xgmi_reset_work);
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 
 	/* It's a bug to not have a hive within this function */
 	if (WARN_ON(!hive))
@@ -2878,6 +2878,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 	if (adev->asic_reset_res)
 		DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
 			 adev->asic_reset_res, adev->ddev->unique);
+	amdgpu_put_xgmi_hive(hive);
 }
 
 static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
@@ -4286,11 +4287,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * We always reset all schedulers for device and all devices for XGMI
 	 * hive so that should take care of them too.
 	 */
-	hive = amdgpu_get_xgmi_hive(adev, false);
+	hive = amdgpu_get_xgmi_hive(adev);
 	if (hive) {
 		if (atomic_cmpxchg(&hive->in_reset, 0, 1) != 0) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
 				job ? job->base.id : -1, hive->hive_id);
+			amdgpu_put_xgmi_hive(hive);
 			return 0;
 		}
 		mutex_lock(&hive->hive_lock);
@@ -4456,6 +4458,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (hive) {
 		atomic_set(&hive->in_reset, 0);
 		mutex_unlock(&hive->hive_lock);
+		amdgpu_put_xgmi_hive(hive);
 	}
 
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5680f7eafcb1..e18606e322e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1514,7 +1514,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_device *remote_adev = NULL;
 	struct amdgpu_device *adev = ras->adev;
 	struct list_head device_list, *device_list_handle =  NULL;
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, false);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 
 	/* Build list of devices to query RAS related errors */
 	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1)
@@ -1525,6 +1525,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		device_list_handle = &device_list;
 	}
 
+	amdgpu_put_xgmi_hive(hive);
+
 	list_for_each_entry(remote_adev, device_list_handle, gmc.xgmi.head) {
 		amdgpu_ras_log_on_err_counter(remote_adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 67a756f4337b..5315d16539f6 100644
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
+static ssize_t amdgpu_xgmi_show_hive_id(struct kobject *kobj,
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
+	struct amdgpu_hive_info *hive = container_of(
+		kobj, struct amdgpu_hive_info, kobj);
 
-	hive->dev_attr = (struct device_attribute) {
-		.attr = {
-			.name = "xgmi_hive_id",
-			.mode = S_IRUGO,
+	if (attr == &amdgpu_xgmi_hive_id)
+		return snprintf(buf, PAGE_SIZE, "%llu\n", hive->hive_id);
 
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
-
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
+	.show = amdgpu_xgmi_show_hive_id,
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
@@ -285,10 +271,9 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 	if (ret)
 		pr_err("failed to create xgmi_error\n");
 
-
 	/* Create sysfs link to hive info folder on the first device */
-	if (adev != hive->adev) {
-		ret = sysfs_create_link(&adev->dev->kobj, hive->kobj,
+	if (hive->kobj.parent != (&adev->dev->kobj)) {
+		ret = sysfs_create_link(&adev->dev->kobj, &hive->kobj,
 					"xgmi_hive_info");
 		if (ret) {
 			dev_err(adev->dev, "XGMI: Failed to create link to hive info");
@@ -296,9 +281,9 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
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
@@ -326,79 +311,89 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
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
-
-
-
-struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock)
+struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 {
-	int i;
-	struct amdgpu_hive_info *tmp;
+	struct amdgpu_hive_info *hive = NULL, *tmp = NULL;
+	int ret = 0;
 
 	if (!adev->gmc.xgmi.hive_id)
 		return NULL;
 
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
 	bool locked;
 
+	amdgpu_put_xgmi_hive(hive);
 	/* fw bug so temporarily disable pstate switching */
 	return 0;
 
@@ -453,7 +448,7 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
 
 	/* Each psp need to set the latest topology */
 	ret = psp_xgmi_set_topology_info(&adev->psp,
-					 hive->number_devices,
+					 atomic_read(&hive->number_devices),
 					 &adev->psp.xgmi_context.top_info);
 	if (ret)
 		dev_err(adev->dev,
@@ -515,7 +510,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		adev->gmc.xgmi.node_id = adev->gmc.xgmi.physical_node_id + 16;
 	}
 
-	hive = amdgpu_get_xgmi_hive(adev, 1);
+	hive = amdgpu_get_xgmi_hive(adev);
 	if (!hive) {
 		ret = -EINVAL;
 		dev_err(adev->dev,
@@ -523,6 +518,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 			adev->gmc.xgmi.node_id, adev->gmc.xgmi.hive_id);
 		goto exit;
 	}
+	mutex_lock(&hive->hive_lock);
 
 	top_info = &adev->psp.xgmi_context.top_info;
 
@@ -530,7 +526,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	list_for_each_entry(entry, &hive->device_list, head)
 		top_info->nodes[count++].node_id = entry->node_id;
 	top_info->num_nodes = count;
-	hive->number_devices = count;
+	atomic_set(&hive->number_devices, count);
 
 	task_barrier_add_task(&hive->tb);
 
@@ -568,6 +564,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 exit_unlock:
 	mutex_unlock(&hive->hive_lock);
+	amdgpu_put_xgmi_hive(hive);
 exit:
 	if (!ret)
 		dev_info(adev->dev, "XGMI: Add node %d, hive 0x%llx.\n",
@@ -576,7 +573,6 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		dev_err(adev->dev, "XGMI: Failed to add node %d, hive 0x%llx ret: %d\n",
 			adev->gmc.xgmi.physical_node_id, adev->gmc.xgmi.hive_id,
 			ret);
-
 	return ret;
 }
 
@@ -587,17 +583,27 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return -EINVAL;
 
-	hive = amdgpu_get_xgmi_hive(adev, 1);
+	hive = amdgpu_get_xgmi_hive(adev);
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
+
+	if(atomic_dec_return(&hive->number_devices) == 0) {
+		/* Remove the hive from global hive list */
+		mutex_lock(&xgmi_mutex);
+		list_del(&hive->node);
+		mutex_unlock(&xgmi_mutex);
+
+		amdgpu_put_xgmi_hive(hive);
 	}
 
 	return psp_xgmi_terminate(&adev->psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 61720cd4a1ee..148560d63554 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -27,14 +27,13 @@
 
 
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
 	atomic_t in_reset;
-	struct kobject *kobj;
-	struct device_attribute dev_attr;
-	struct amdgpu_device *adev;
 	int hi_req_count;
 	struct amdgpu_device *hi_req_gpu;
 	struct task_barrier tb;
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
